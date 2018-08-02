pipeline {
  agent any
  stages {
    stage('Reset') {
      steps {
        sh 'rake db:migrate:reset'
        sh 'bundle'
      }
    }
  }
}