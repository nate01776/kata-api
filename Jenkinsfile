pipeline {
  agent any
  stages {
    stage('Reset') {
      steps {
        sh 'bash ./scripts/kill.sh'
        sh 'rake db:create'
        sh 'rake db:migrate:reset'
      }
    }
    stage('Build') {
      steps {
        sh 'bundle'
      }
    }
    stage('Deploy') {
      steps {
        sh './scripts/start.sh'
      }
    }
    stage('Test') {
      steps {
        sh 'curl \'http://10.0.25.247:4567/pet/1\''
      }
    }
  }
}