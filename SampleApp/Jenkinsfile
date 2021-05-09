pipeline {
    agent any
    stages {
        stage('Initialize Git POLL SCM Feature') {
            steps {
                //Enable remote triggers
                script {
                    properties([[$class: 'GithubProjectProperty', displayName: '', projectUrlStr: 'https://github.com/bipin115/AngularDocker_CI-CD_Workflow.git'], pipelineTriggers([pollSCM('* * * * *')])])
                }  
            }
        }

	    stage('Git project checkout') {
           steps {
                git branch: 'main', url: 'https://github.com/bipin115/AngularDocker_CI-CD_Workflow.git'  
          }
        }

	    stage('Clean Existing Images and Stop and remove Running container') {            
            steps {
                catchError (buildResult:'SUCCESS', stageResult: 'FAILURE') {
                    sh "docker images"
                    sh "docker container ls"
                    sh "docker container stop angular_dockerwebapp"
                    sh "docker rm -f angular_dockerwebapp"
                    sh "docker image rm -f bipin115/angular_dockerwebapp"
                }
            }
        }

        stage('Docker Build and Tag') {
            steps {
                sh 'docker build -t angular_dockerwebapp:latest .'  
                sh 'docker tag angular_dockerwebapp bipin115/angular_dockerwebapp:latest'       
            }
        }
        
        stage('Publish image to Docker Hub') { 
            steps {
                    withDockerRegistry([ credentialsId: "dockerHub", url: "" ]) {
                    sh  'docker push bipin115/angular_dockerwebapp:latest'
                } 
            }
        }
     
      stage('Run Docker container') {
            steps {
                sh "docker run --name angular_dockerwebapp -d -p 9090:8080 bipin115/angular_dockerwebapp"
            }
        }
    }
}