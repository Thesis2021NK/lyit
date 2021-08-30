pipeline {
    agent any

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "maven"
    }
    stages {
        stage('Code Quality Check via SonarQube') {
            steps {
                script {
                    def scannerHome = tool 'sonarqube-scanner';
                    withSonarQubeEnv("sonarqube-container") {
                        sh "${tool("sonarqube-scanner")}/bin/sonar-scanner \
                        -Dsonar.projectKey=securedevops \
                        -Dsonar.java.binaries=src/main \
                        -Dsonar.sourceEncoding=UTF-8 \
                        -Dsonar.language=java \
                        -Dsonar.css.node=. \
                        -Dsonar.host.url=http://178.79.157.210 \
                        -Dsonar.login=61299c5b02ef493dd15821ecc14db4628934780e"
                    }
                }
            }
        }
        stage("Quality gate") {
            steps {
                waitForQualityGate abortPipeline: true
            }
        }
        stage('Build Artificat') {
            steps {
                sh "mvn clean package -DskipTests=true"
                archive 'target/*.jar' 
            }
        }
        stage('Vulnerability scan - Docker') {
            steps {
                sh "bash trivyscan.sh"
            }
        }
        stage('Docker Build and Push') {
            steps {
                withDockerRegistry([credentialsId: "devsecops-docker-hub", url: ""]) { 
                    sh 'printenv'
                    sh 'docker build -t h352615/secureregistry:lts .'
                    sh 'docker push h352615/secureregistry:lts'
                }
            }
        }
    }
}
