pipeline {
  agent any
  stages {
    stage('Install') {
      steps { dir('app') { sh 'npm ci' } }
    }
    stage('Build') {
      steps { dir('app') { sh 'npm run build --if-present' } }
    }
    stage('Test') {
      steps { dir('app') { sh 'npm test -- --coverage' } }
    }
  }
  post {
    always {
      archiveArtifacts artifacts: 'app/coverage/**', allowEmptyArchive: true
    }
  }
}
