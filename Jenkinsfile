node {

    stage("Check out source") {
        checkout scm
    }  
    stage("Build test environment in Docker") {
        sh "docker build -t py-alpine-ta ."
    }

    try {
        withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: '${TA_USR_PWD}',
        usernameVariable: 'TA_USR', passwordVariable: 'TA_PWD']]) {
            
            stage("Pre-run ping tests") {
                sh "docker run -v `pwd`/docker-results:/src/robot/results -e TA_RUN_TAGS='-i ping' -e TA_WEB_URL -e TA_API_URL -e TA_USR -e TA_PWD py-alpine-ipact-ta"
            }
            stage("Run selected tests") {
                sh "docker run -v `pwd`/docker-results:/src/robot/results -e TA_RUN_TAGS -e TA_WEB_URL -e TA_API_URL -e TA_USR -e TA_PWD py-alpine-ipact-ta"
            }
        }

    } finally {
        step([$class: 'RobotPublisher',
            disableArchiveOutput: false,
            logFileName: 'log.html',
            otherFiles: '*.png',
            outputFileName: '*.xml',
            outputPath: 'docker-results',
            passThreshold: 100,
            reportFileName: 'report.html',
            unstableThreshold: 95.0]);
    }

}