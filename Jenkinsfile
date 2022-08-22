pipeline {

    agent any

    environment {
  		PASS = credentials('registry-pass')
        // Comment
    }

    stages {

        stage('Build') {
            steps {
                sh '''
                    ./build/mvn.sh mvn -B -DskipTests clean package
                    ./build/build.sh
                    '''   
            }
            post {
                success {
                    archiveArtifacts artifacts: 'build/simple-java-maven-app/target/*.jar', fingerprint: true
                }
            }
        }                        
        stage('Test') {
            steps {
                sh './build/mvn-test.sh mvn test'
            }
            post {
                always {
                    junit 'build/simple-java-maven-app/target/surefire-reports/*.xml'
                }
            }
        }
        stage('Push') {
            steps {
                cd /home/dockeradmin;
                docker build -t simple-java-maven .; 
                docker run -d --name simple-java-container -p 8085:8080 simple-java-maven;
                docker ps -a;
            }
        }
        stage('Deploy') {
        	steps {
        		sh './deploy/deploy.sh'
        	}
        }
    }
}
