node {
    dir("/root/"){
    	checkout scm

     	print "Francis - finished checkout......"

    	env.DOCKER_API_VERSION="1.23"
    	appName = "default/flask-app"

    	registryHost = "icp.demo.ibm:8500/"

	registryURL = "https://${registryHost}"

    	imageName = "${registryHost}${appName}:${env.BUILD_ID}"

    	env.BUILDIMG=imageName

    	docker.withRegistry(${registryURL}, 'docker'){
       		print "Francis - within docker.with registry, build ID: ${env.BUILD_ID}"
    		stage "Build"

        	def pcImg = docker.build("${registryHost}/default/flask-app:${env.BUILD_ID}", "-f Dockerfile .")
        	// sh "cp /root/.dockercfg ${HOME}/.dockercfg"
		pcImg.tag()
        	pcImg.push()

    		input 'Do you want to proceed with Deployment?'
    		stage "Deploy"

        	sh "kubectl set image deployment/demoapp-demochart demoapp-demochart=${imageName}"
        	sh "kubectl rollout status deployment/demoapp-demochart"
	}
    }
}
