pipeline {
agent any

stages {
 

         stage('Cloning from GitHub') {
                steps {
                    git branch: 'main', url: 'https://github.com/heditrigui/devops.git'
                }  
            }
           
               stage('MVN CLEAN') {
                        steps {
                           sh 'mvn clean '
                        }
                    }
          stage('MVN COMPILE') {
            steps {
               sh 'mvn compile'
           }
        }

          stage('mvn Test') {
            steps {
               sh 'mvn test'
            }
        }
          stage('mvn Verify') {
             steps {
               sh 'mvn verify'
          }
       }
       stage ('sonar '){
    steps {
       script {
           withSonarQubeEnv('sonarqube_token'){
               sh "mvn sonar:sonar"
           }
       }
    }
       }
           stage('Nexus') {
      steps {
        sh 'mvn deploy -DskipTests'
      }
    }
stage("Building Docker Image") {
                steps{
                   
                    sh 'docker build -t heditrigui/achat .'
                }
        }
    stage("Login to DockerHub") {
                steps{
                    sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u heditrigui -p dockerpass'
                }
        }
    stage("Push to DockerHub") {
                steps{
                    sh 'docker push heditrigui/achat'
                }
        }
}
   post { 
    success { 
        mail to: "hedi.trigui@esprit.tn", 
        subject: "Welcome to DevOps project Front-End : Pipeline Success", 
        body: "success on job ${env.JOB_NAME}, Build Number: ${env.BUILD_NUMBER}, Build URL: ${env.BUILD_URL}" } 
    failure { mail to: "hedi.trigui@esprit.tn", 
    subject: "Pipeline Failure", 
    body: "Welcome to DevOps project Front-End :Failure on job ${env.JOB_NAME}, Build Number: ${env.BUILD_NUMBER}, Build URL: ${env.BUILD_URL} " } 
}

}
