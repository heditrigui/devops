pipeline {
    agent any
    environment{
        PATH = "$PATH:/usr/share/maven/bin"
    }

    stages {
         stage('Cloning from GitHub') {
                steps {
                    git branch: 'main', url: 'https://github.com/KlaiGhassen/devops'
                }
                
            }
        stage('MVN CLEAN') {
            steps {
               sh 'mvn clean'
            }
        }
          stage('Test') {
            steps {
               sh 'mvn test'
            }
        }
        stage('MVN COMPILE') {
            steps {
               sh 'mvn compile'
            
           }
        }
      
        stage ('Scan Sonar'){
            steps {
        
    sh "mvn sonar:sonar \
  -Dsonar.projectKey=sonar \
  -Dsonar.host.url=http://192.168.33.10:9000 \
  -Dsonar.login=d618898b5841d20f3167a7f9f39dbf6e3ff10f1f"

    }
        }
        stage('Nexus') {
      steps {
        sh 'mvn deploy -DskipTests'
      }
    }
       
     stage("Building Docker Image") {
                steps{
                    sh 'docker build -t gaston2100/achat .'
                }
        }
        
        
           stage("Login to DockerHub") {
                steps{
                   // sh 'sudo chmod 666 /var/run/docker.sock'
                    sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u gaston2100 -p hinda2100@@'
                }
        }
        stage("Push to DockerHub") {
                steps{
                    sh 'docker push gaston2100/achat'
                }
        }
    
               stage("Docker-compose") {
                steps{
                    sh 'docker-compose up -d'
                }
        }
    }
    
 /*   post {
                success {
                     mail to: "ghassen.klai@esprit.tn",
                     subject: "success",
                     body: "success on job ${env.JOB_NAME}, Build Number: ${env.BUILD_NUMBER}, Build URL: ${env.BUILD_URL}"
                }
failure {
                    mail to: "ghassen.klai@esprit.tn",
                     subject: "Failure",
                     body: "Failure on job ${env.JOB_NAME}, Build Number: ${env.BUILD_NUMBER}, Build URL: ${env.BUILD_URL} "     
                }
             
       
    }*/

}
