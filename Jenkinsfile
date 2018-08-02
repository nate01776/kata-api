pipeline {
  agent any
  stages {
    stage('Reset') {
      steps {
        sh 'rake db:create'
        sh 'rake db:migrate:reset'
        sh 'bundle'
      }
    }
  }
}