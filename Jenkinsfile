pipeline {
    agent none
        stages {
        stage('checking out') {
            agent { label 'wcsv9' }
            steps { 
             echo "Checking out to Mounted Volume"
              
            }
        }
            stage('Creating WCB Commerce Build') {
            agent { label 'wcsv9' }
                steps { 
             echo "Building Image in Utility Container"
                    sh 'docker exec -i ac9dccabb431 bash -c  "cd /opt/WebSphere/CommerceServer90/wcbd/ ; ./setenv ; ./wcbd-ant -buildfile wcbd-build.xml -Dbuild.type=local -Dapp.type=$apptype -Dbuild.label=$label -Dwork.dir=/opt/WebSphere/CommerceServer90/wcbd"'
              
            }
            }
			
            stage('Copying Package to Deploy Folder') {
            agent { label 'wcsv9' }
                steps { 
             
                    sh 'docker cp -L ac9dccabb431:/opt/WebSphere/CommerceServer90/wcbd/dist/server/wcbd-deploy-server-local-"$apptype"-"$label".zip /home/'
                    
            }
            }
			   stage('Unpacking Deploy package') {
            agent { label 'wcsv9' }
                steps { 
                            
                   dir ('/home/') {
                   sh 'rm -rf /home/CustDeploy/CusDeploy/*'
                  sh 'unzip wcbd-deploy-server-local-"$apptype"-"$label".zip -d /home/CustDeploy/CusDeploy/'
             
              }
                    
            }
            }
		 stage('Updating Image with Changes ') {
            agent { label 'wcsv9' }
                steps { 
                    dir ('/home/CustDeploy') {
                    sh "docker build -f Dockerfile . -t  commerce/crs-app:9.0.0.1"
                    
                    }
            }
            }	        
		
		stage('Starting Container ') {
            agent { label 'wcsv9' }
                steps { 
                    dir ('/home/') {
                    sh "docker-compose -f docker-compose-auth-crs.xml up -d"
                    
                    }
            }
            }
            
            
            
        }
}
