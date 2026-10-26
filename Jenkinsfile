// // //
// // // pipeline {
// // //     agent any
// // //
// // //     options {
// // //         timestamps()
// // //         disableConcurrentBuilds()
// // //         buildDiscarder(logRotator(numToKeepStr: '10'))
// // //     }
// // //
// // //     environment {
// // //         DOCKER = 'C:\\Users\\shree\\AppData\\Local\\Programs\\DockerDesktop\\resources\\bin\\docker.exe'
// // //         APP_NAME = 'task-1-java'
// // //         IMAGE_TAG = "${BUILD_NUMBER}"
// // //         MAVEN = 'C:\\tools\\apache-maven-3.9.16\\bin\\mvn.cmd'
// // //     }
// // //
// // //     stages {
// // //         stage('Checkout') {
// // //             steps {
// // //                 checkout scm
// // //             }
// // //         }
// // //
// // //         stage('Check Tools') {
// // //             steps {
// // //                 bat 'java -version'
// // //                 bat '"%MAVEN%" -version'
// // //                 bat '"%DOCKER%" version'
// // //                 bat 'git --version'
// // //             }
// // //         }
// // //
// // //         stage('SonarQube Analysis') {
// // //             steps {
// // //                 dir('task-1-java') {
// // //                     withCredentials([string(
// // //                         credentialsId: 'sonarcloud-token',
// // //                         variable: 'sonarcloud-token'
// // //                     )]) {
// // //                         bat '''
// // //                             "%MAVEN%" -B org.sonarsource.scanner.maven:sonar-maven-plugin:sonar ^
// // //                             -Dsonar.host.url=https://sonarcloud.io ^
// // //                             -Dsonar.organization=rahuldeshmukh-17 ^
// // //                             -Dsonar.projectKey=RahulDeshmukh-17_devops-tasks
// // //                         '''
// // //                     }
// // //                 }
// // //             }
// // //         }
// // //
// // //
// // //         stage('Build and Unit Test') {
// // //             steps {
// // //                 dir('task-1-java') {
// // //                     bat '"%MAVEN%" -B clean verify'
// // //                 }
// // //             }
// // //             post {
// // //                 always {
// // //                     junit allowEmptyResults: true,
// // //                           testResults: 'task-1-java/target/surefire-reports/*.xml'
// // //                 }
// // //             }
// // //         }
// // //
// // // stage('Upload JAR to Nexus') {
// // //     steps {
// // //         dir('task-1-java') {
// // //             withCredentials([usernamePassword(
// // //                 credentialsId: 'nexus-credentials',
// // //                 usernameVariable: 'NEXUS_USER',
// // //                 passwordVariable: 'NEXUS_PASSWORD'
// // //             )]) {
// // //                 bat '''
// // //                     curl.exe -f -u "%NEXUS_USER%:%NEXUS_PASSWORD%" ^
// // //                       -X POST "http://localhost:8081/service/rest/v1/components?repository=maven-releases" ^
// // //                       -F "maven2.groupId=com.example" ^
// // //                       -F "maven2.artifactId=task-1-java" ^
// // //                       -F "maven2.version=1.0.0" ^
// // //                       -F "maven2.generate-pom=true" ^
// // //                       -F "maven2.asset1=@target/task-1-java-1.0.0.jar" ^
// // //                       -F "maven2.asset1.extension=jar"
// // //                 '''
// // //             }
// // //         }
// // //     }
// // // }
// // //
// // //
// // //         stage('Build Docker Image') {
// // //             steps {
// // //                 dir('task-1-java') {
// // //                     bat '"%DOCKER%" build -t %APP_NAME%:%IMAGE_TAG% .'
// // //                 }
// // //             }
// // //         }
// // //
// // //         stage('Run Docker Container') {
// // //             steps {
// // //                 bat '"%DOCKER%" run --rm %APP_NAME%:%IMAGE_TAG%'
// // //             }
// // //         }
// // //     }
// // //
// // //
// // //     post {
// // //         success {
// // //             echo 'Java build, tests, and Docker build/run completed successfully.'
// // //         }
// // //         failure {
// // //             echo 'Pipeline failed. Check the failed stage in Console Output.'
// // //         }
// // //         always {
// // //             archiveArtifacts artifacts: 'task-1-java/target/*.jar',
// // //                              allowEmptyArchive: true
// // //         }
// // //     }
// // // }
// //
// //
// // pipeline {
// //     agent any
// //
// //     options {
// //         timestamps()
// //         disableConcurrentBuilds()
// //         buildDiscarder(logRotator(numToKeepStr: '10'))
// //     }
// //
// //     environment {
// //         DOCKER = 'C:\\Users\\shree\\AppData\\Local\\Programs\\DockerDesktop\\resources\\bin\\docker.exe'
// //         APP_NAME = 'task-1-java'
// //         IMAGE_TAG = "${BUILD_NUMBER}"
// //         MAVEN = 'C:\\tools\\apache-maven-3.9.16\\bin\\mvn.cmd'
// //         NEXUS_REGISTRY = 'localhost:8083'
// //     }
// //
// //     stages {
// //         stage('Checkout') {
// //             steps {
// //                 checkout scm
// //             }
// //         }
// //
// //         stage('Check Tools') {
// //             steps {
// //                 bat 'java -version'
// //                 bat '"%MAVEN%" -version'
// //                 bat '"%DOCKER%" version'
// //                 bat 'git --version'
// //             }
// //         }
// //
// //
// // stage('SonarCloud Analysis') {
// //     steps {
// //         withCredentials([string(credentialsId: 'sonarcloud-token', variable: 'sonarcloud-token')]) {
// //             bat '''
// //                 "C:\\tools\\apache-maven-3.9.16\\bin\\mvn.cmd" -B clean verify org.sonarsource.scanner.maven:sonar-maven-plugin:sonar ^
// //                 -Dsonar.host.url=https://sonarcloud.io ^
// //                 -Dsonar.organization=rahuldeshmukh-17 ^
// //                 -Dsonar.projectKey=RahulDeshmukh-17_devops-tasks ^
// //                 -Dsonar.token=%sonarcloud-token%
// //             '''
// //         }
// //     }
// // }
// //
// //
// //         stage('Build and Unit Test') {
// //             steps {
// //                 dir('task-1-java') {
// //                     bat '"%MAVEN%" -B clean verify'
// //                 }
// //             }
// //             post {
// //                 always {
// //                     junit allowEmptyResults: true,
// //                           testResults: 'task-1-java/target/surefire-reports/*.xml'
// //                 }
// //             }
// //         }
// //
// //         stage('Upload JAR to Nexus') {
// //             steps {
// //                 dir('task-1-java') {
// //                     withCredentials([usernamePassword(
// //                         credentialsId: 'nexus-credentials',
// //                         usernameVariable: 'NEXUS_USER',
// //                         passwordVariable: 'NEXUS_PASSWORD'
// //                     )]) {
// //                         bat '''
// //                             curl.exe -f -u "%NEXUS_USER%:%NEXUS_PASSWORD%" ^
// //                               -X POST "http://localhost:8081/service/rest/v1/components?repository=maven-releases" ^
// //                               -F "maven2.groupId=com.example" ^
// //                               -F "maven2.artifactId=task-1-java" ^
// //                               -F "maven2.version=1.0.%BUILD_NUMBER%" ^
// //                               -F "maven2.generate-pom=true" ^
// //                               -F "maven2.asset1=@target/task-1-java-1.0.0.jar" ^
// //                               -F "maven2.asset1.extension=jar"
// //                         '''
// //                     }
// //                 }
// //             }
// //         }
// //
// //         stage('Build Docker Image') {
// //             steps {
// //                 dir('task-1-java') {
// //                     bat '"%DOCKER%" build -t %APP_NAME%:%IMAGE_TAG% .'
// //                 }
// //             }
// //         }
// //
// //         stage('Run Docker Container') {
// //             steps {
// //                 bat '"%DOCKER%" run --rm %APP_NAME%:%IMAGE_TAG%'
// //             }
// //         }
// //
// //         stage('Push Docker Image to Nexus') {
// //             steps {
// //                 withCredentials([usernamePassword(
// //                     credentialsId: 'nexus-docker-creds',
// //                     usernameVariable: 'NEXUS_DOCKER_USER',
// //                     passwordVariable: 'NEXUS_DOCKER_PASSWORD'
// //                 )]) {
// //                     bat '''
// //                         "%DOCKER%" login %NEXUS_REGISTRY% -u "%NEXUS_DOCKER_USER%" -p "%NEXUS_DOCKER_PASSWORD%"
// //                         if errorlevel 1 exit /b 1
// //
// //                         "%DOCKER%" tag %APP_NAME%:%IMAGE_TAG% %NEXUS_REGISTRY%/%APP_NAME%:%IMAGE_TAG%
// //                         if errorlevel 1 exit /b 1
// //
// //                         "%DOCKER%" push %NEXUS_REGISTRY%/%APP_NAME%:%IMAGE_TAG%
// //                         if errorlevel 1 exit /b 1
// //
// //                         "%DOCKER%" logout %NEXUS_REGISTRY%
// //                     '''
// //                 }
// //             }
// //         }
// //     }
// //
// //     post {
// //         success {
// //             echo 'Build, tests, SonarCloud analysis and Nexus Docker push completed.'
// //         }
// //         failure {
// //             echo 'Pipeline failed. Check the failed stage in Console Output.'
// //         }
// //         always {
// //             archiveArtifacts artifacts: 'task-1-java/target/*.jar',
// //                              allowEmptyArchive: true
// //         }
// //     }
// // }
//
//
// pipeline {
//     agent any
//
//     options {
//         timestamps()
//         disableConcurrentBuilds()
//         buildDiscarder(logRotator(numToKeepStr: '10'))
//     }
//
//     environment {
//         DOCKER = 'C:\\Users\\shree\\AppData\\Local\\Programs\\DockerDesktop\\resources\\bin\\docker.exe'
//         APP_NAME = 'task-1-java'
//         IMAGE_TAG = "${BUILD_NUMBER}"
//         MAVEN = 'C:\\tools\\apache-maven-3.9.16\\bin\\mvn.cmd'
//         NEXUS_REGISTRY = 'localhost:8083'
//     }
//
//     stages {
//         stage('Checkout') {
//             steps {
//                 checkout scm
//             }
//         }
//
//         stage('Check Tools') {
//             steps {
//                 bat 'java -version'
//                 bat '"%MAVEN%" -version'
//                 bat '"%DOCKER%" version'
//                 bat 'git --version'
//             }
//         }
//
//         stage('SonarCloud Analysis') {
//             steps {
//                 withCredentials([
//                     string(credentialsId: 'sonarcloud-token', variable: 'sonarcloud-token')
//                 ]) {
//                     bat '''
//                         "%MAVEN%" -B clean verify org.sonarsource.scanner.maven:sonar-maven-plugin:sonar ^
//                         -Dsonar.host.url=https://sonarcloud.io ^
//                         -Dsonar.organization=rahuldeshmukh-17 ^
//                         -Dsonar.projectKey=RahulDeshmukh-17_devops-tasks ^
//                         -Dsonar.token=%sonarcloud-token%
//                     '''
//                 }
//             }
//         }
//
//         stage('Build and Unit Test') {
//             steps {
//                 bat '"%MAVEN%" -B clean verify'
//             }
//             post {
//                 always {
//                     junit allowEmptyResults: true,
//                           testResults: 'target/surefire-reports/*.xml'
//                 }
//             }
//         }
//
//         stage('Upload JAR to Nexus') {
//             steps {
//                 withCredentials([
//                     usernamePassword(
//                         credentialsId: 'nexus-credentials',
//                         usernameVariable: 'NEXUS_USER',
//                         passwordVariable: 'NEXUS_PASSWORD'
//                     )
//                 ]) {
//                     bat '''
//                         curl.exe -f -u "%NEXUS_USER%:%NEXUS_PASSWORD%" ^
//                           -X POST "http://localhost:8081/service/rest/v1/components?repository=maven-releases" ^
//                           -F "maven2.groupId=com.example" ^
//                           -F "maven2.artifactId=task-1-java" ^
//                           -F "maven2.version=1.0.%BUILD_NUMBER%" ^
//                           -F "maven2.generate-pom=true" ^
//                           -F "maven2.asset1=@target/task-1-java-1.0.0.jar" ^
//                           -F "maven2.asset1.extension=jar"
//                     '''
//                 }
//             }
//         }
//
//         stage('Build Docker Image') {
//             steps {
//                 bat '"%DOCKER%" build -t %APP_NAME%:%IMAGE_TAG% .'
//             }
//         }
//
//         stage('Run Docker Container') {
//             steps {
//                 bat '"%DOCKER%" run --rm %APP_NAME%:%IMAGE_TAG%'
//             }
//         }
//
//         stage('Push Docker Image to Nexus') {
//             steps {
//                 withCredentials([
//                     usernamePassword(
//                         credentialsId: 'nexus-docker-creds',
//                         usernameVariable: 'NEXUS_DOCKER_USER',
//                         passwordVariable: 'NEXUS_DOCKER_PASSWORD'
//                     )
//                 ]) {
//                     bat '''
//                         "%DOCKER%" login %NEXUS_REGISTRY% -u "%NEXUS_DOCKER_USER%" --password-stdin < nul
//                     '''
//                 }
//             }
//         }
//     }
//
//     post {
//         success {
//             echo 'Build, tests, SonarCloud analysis and Nexus stages completed.'
//         }
//         failure {
//             echo 'Pipeline failed. Check the failed stage in Console Output.'
//         }
//         always {
//             archiveArtifacts artifacts: 'target/*.jar',
//                              allowEmptyArchive: true
//         }
//     }
// }
//
pipeline {
    agent any

    options {
        timestamps()
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '10'))
    }

    environment {
        DOCKER = 'C:\\Users\\shree\\AppData\\Local\\Programs\\DockerDesktop\\resources\\bin\\docker.exe'
        APP_NAME = 'task-1-java'
        IMAGE_TAG = "${BUILD_NUMBER}"
        MAVEN = 'C:\\tools\\apache-maven-3.9.16\\bin\\mvn.cmd'
        NEXUS_REGISTRY = 'localhost:8083'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Check Tools') {
            steps {
                bat 'java -version'
                bat '"%MAVEN%" -version'
                bat '"%DOCKER%" version'
                bat 'git --version'
            }
        }

        stage('SonarCloud Analysis') {
            steps {
                withCredentials([
                    string(credentialsId: 'sonarcloud-token', variable: 'sonarcloud-token')
                ]) {
                    bat '''
                        "%MAVEN%" -B clean verify org.sonarsource.scanner.maven:sonar-maven-plugin:sonar ^
                        -Dsonar.host.url=https://sonarcloud.io ^
                        -Dsonar.organization=rahuldeshmukh-17 ^
                        -Dsonar.projectKey=RahulDeshmukh-17_devops-tasks ^
                        -Dsonar.token=%sonarcloud-token%
                    '''
                }
            }
        }

        stage('Build and Unit Test') {
            steps {
                bat '"%MAVEN%" -B clean verify'
            }
            post {
                always {
                    junit allowEmptyResults: true,
                          testResults: 'target/surefire-reports/*.xml'
                }
            }
        }

        stage('Upload JAR to Nexus') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'nexus-credentials',
                        usernameVariable: 'NEXUS_USER',
                        passwordVariable: 'NEXUS_PASSWORD'
                    )
                ]) {
                    bat '''
                        curl.exe -f -u "%NEXUS_USER%:%NEXUS_PASSWORD%" ^
                          -X POST "http://localhost:8081/service/rest/v1/components?repository=maven-releases" ^
                          -F "maven2.groupId=com.example" ^
                          -F "maven2.artifactId=task-1-java" ^
                          -F "maven2.version=1.0.%BUILD_NUMBER%" ^
                          -F "maven2.generate-pom=true" ^
                          -F "maven2.asset1=@target/task-1-java-1.0.0.jar" ^
                          -F "maven2.asset1.extension=jar"
                    '''
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                bat '"%DOCKER%" build -t %APP_NAME%:%IMAGE_TAG% .'
            }
        }

        stage('Run Docker Container') {
            steps {
                bat '"%DOCKER%" run --rm %APP_NAME%:%IMAGE_TAG%'
            }
        }
stage('Push Docker Image to Nexus') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'nexus-docker-creds',
                    usernameVariable: 'NEXUS_DOCKER_USER',
                    passwordVariable: 'NEXUS_DOCKER_PASSWORD'
                )]) {
                    bat '''
                        "%DOCKER%" login %NEXUS_REGISTRY% -u "%NEXUS_DOCKER_USER%" -p "%NEXUS_DOCKER_PASSWORD%"
                        if errorlevel 1 exit /b 1

                        "%DOCKER%" tag %APP_NAME%:%IMAGE_TAG% %NEXUS_REGISTRY%/%APP_NAME%:%IMAGE_TAG%
                        if errorlevel 1 exit /b 1

                        "%DOCKER%" push %NEXUS_REGISTRY%/%APP_NAME%:%IMAGE_TAG%
                        if errorlevel 1 exit /b 1

                        "%DOCKER%" logout %NEXUS_REGISTRY%
                    '''
                }
            }
        }
//         stage('Push Docker Image to Nexus') {
//             steps {
//                 withCredentials([
//                     usernamePassword(
//                         credentialsId: 'nexus-credentials',
//                         usernameVariable: 'NEXUS_USER',
//                         passwordVariable: 'NEXUS_PASSWORD'
//                     )
//                 ]) {
//                     powershell '''
//                         $ErrorActionPreference = "Stop"
//                         $password = $env:NEXUS_DOCKER_PASSWORD
//                         $password | & $env:DOCKER login $env:NEXUS_REGISTRY --username $env:NEXUS_DOCKER_USER --password-stdin
//                         if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
//
//                         & $env:DOCKER tag "$env:APP_NAME`:$env:IMAGE_TAG" "$env:NEXUS_REGISTRY/$env:APP_NAME`:$env:IMAGE_TAG"
//                         if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
//
//                         & $env:DOCKER push "$env:NEXUS_REGISTRY/$env:APP_NAME`:$env:IMAGE_TAG"
//                         if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
//
//                         & $env:DOCKER logout $env:NEXUS_REGISTRY
//                     '''
//                 }
//             }
//         }
    }

    post {
        success {
            echo 'Build, tests, SonarCloud analysis and Nexus stages completed.'
        }
        failure {
            echo 'Pipeline failed. Check the failed stage in Console Output.'
        }
        always {
            archiveArtifacts artifacts: 'target/*.jar',
                             allowEmptyArchive: true
        }
    }
}

