pipeline {
  agent any

  environment {
    REGISTRY = '003235076673.dkr.ecr.eu-west-2.amazonaws.com'
    REGION = 'eu-west-2'
    ECR_REPOSITORY = 'il-homework-zs'
    VERSION = 'latest'
    CREDENTIALS = 'AWS_CREDENTIALS'
    DOCKERFILE_PATH = './app/'
    BUCKET_NAME = "site-host-bucket-zs"
  }


  stages {
    stage('Git cloning'){
      steps {
        git branch: 'main',
            credentialsId: 'github',
            url: 'https://github.com/ZsoltTirkala/infinite-lambda-devops-homework.git'
      }
    }

  


    stage('Build image and push') {
      steps {
        script {
            docker.build("${ECR_REPOSITORY}", "${DOCKERFILE_PATH}")
            docker.withRegistry("https://${REGISTRY}", "ecr:${REGION}:${CREDENTIALS}") { 
            docker.image("${ECR_REPOSITORY}").push("${VERSION}") 
          }
        }
      }
    }


    stage('Deploy website to S3') {
      steps {
        withAWS(credentials:"${CREDENTIALS}", region:"${REGION}") {
          s3Upload(file:'app/templates/index.html', bucket:"${BUCKET_NAME}", path:'index.html')
        }
      }
    }
  }

  post {
    success {
      sh "echo Successfully builded docker image and pushed it to the ${ECR_REPOSITORY} ECR!" 
    }
    failure {
      sh "echo Failure!"
    }
  }
}
