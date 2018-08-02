pipeline {
  agent any
  stages {
    stage('Reset') {
      steps {
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
        sh 'rackup -q'
      }
    }
    stage('Test') {
      steps {
        sh 'curl \'http://10.0.25.247:4567/pet/1\''
      }
    }
  }
}