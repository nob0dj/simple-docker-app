pipeline {
    agent any

    tools {
        maven 'jenkins-maven'
    }

    environment {
        imageName = 'shqkel/simple-docker-app' // 사용자명/저장소명
        registryCredentials = 'dockerhub-credentials' // 저장된 dockerhub 인증정보명
        dockerImage = ''
		BUILD_NUMBER = '0.0.7'
		TARGET_HOST = "ubuntu@130.162.159.60"
	    sshCredentials = 'ssh-jenkins' // 저장된 ssh 인증정보 id
		containerName= 'app'
    }

    stages {
        // git에서 repository clone
        stage('Prepare') {
          steps {
            echo 'Clonning Repository'
            git url: 'https://github.com/nob0dj/simple-docker-app.git',
              branch: 'main'
            }
            post {
             success {
               echo 'Successfully Cloned Repository'
             }
           	 failure {
               error 'This pipeline stops here...'
             }
          }
        }

        // maven build
        stage('Bulid Maven') {
          steps {
            echo 'Bulid Maven'
            dir ('.'){
                sh """
                mvn -Dmaven.test.skip=true clean package
                """
            }
          }
          post {
						success {
	            echo 'Successfully Build Maven Project'
	          }
            failure {
              error 'This pipeline stops here...'
            }
          }
        }

        // docker build
        stage('Bulid Docker') {
          steps {
            echo 'Bulid Docker'
            script {
                // docker build
                dockerImage = docker.build imageName
            }
          }
          post {
			success {
	            echo 'Successfully Build Docker Image'
	          }
            failure {
              error 'This pipeline stops here...'
            }
          }
        }

        // docker push
        stage('Push Docker') {
          steps {
            echo 'Push Docker'
            script {
                docker.withRegistry('', registryCredentials) {
                    dockerImage.push("${BUILD_NUMBER}")
                    dockerImage.push("latest")
                }
            }
          }
          post {
            failure {
              error 'This pipeline stops here...'
            }
          }
        }

				stage('Pull Docker Image Via SSH & Run') {
          steps {
            echo 'Pull Docker Image Via SSH & Run'

            sshagent (credentials: ['ssh-jenkins']) {
                sh """
                    ssh -o StrictHostKeyChecking=no ${TARGET_HOST} '
                    docker pull ${imageName}
                    docker stop ${containerName}
                    docker rm ${containerName}
                    docker run -d --name ${containerName} -p 80:8080 ${imageName}
                    '
                """
            }
          }
       }
    }
}