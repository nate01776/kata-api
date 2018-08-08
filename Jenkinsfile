pipeline {
  agent {
    node {
      label 'default'
    }

  }
  stages {
    stage('Stage') {
      steps {
        sh 'rake db:create'
        sh 'rake db:migrate:reset'
      }
    }
    stage('Build') {
      steps {
        sh 'bundler'
      }
    }
    stage('Deploy') {
      steps {
        sh 'nohup ruby ./server.rb -p 4567 -o 10.0.25.247 >> ./logs/log_file.txt 2>&1 &'
      }
    }
    stage('Test') {
      steps {
        sh 'curl \'http://10.0.25.247:4567/pet/1\''
      }
    }
  }
}