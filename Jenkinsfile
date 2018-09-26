pipeline {
    agent none
        stages {
        stage('checking out') {
            agent { label 'wcsv9' }
            steps { 
             echo "Checking out to Mounted Repo"
              
            }
        }
            stage('Creating WCB Commerce Build') {
            agent { label 'wcsv9' }
                steps { 
             echo "Building Image in Utility Container"
                    sh """ 'docker exec -it 09f0bf823543 bash -c "cd /opt/WebSphere/CommerceServer90/wcbd/ ; ./setenv ; ./wcbd-ant -buildfile wcbd-build.xml -Dbuild.type=local -Dapp.type=$apptype -Dbuild.label=$label -Dwork.dir=/opt/WebSphere/CommerceServer90/wcbd"' """
              
            }
            }
            
            stage('Copying Package to Deploy Folder') {
            agent { label 'wcsv9' }
                steps { 
             
                    sh "docker cp -L 09f0bf823543:/opt/WebSphere/CommerceServer90/wcbd/dist/server/wcbd-deploy-server-local-$apptype-$label.zip /home/CustDeploy"
                    
            }
            }
            
            
             stage('Unpacking Deploy package') {
            agent { label 'wcsv9' }
                steps { 
                            
                   dir ('/home/CustDeploy') {
               
                  sh "unzip /home/CustDeploy/CusDeploy/wcbd-deploy-server-local-$apptype-$label.zip"
             
              }
                    
            }
            }
            
            stage('Building Image') {
            agent { label 'wcsv9' }
                steps { 
                    dir ('/home/CustDeploy') {
                    sh "docker build -f Dockerfile . -t  crs-app:2.1"
                    
                    }
            }
            }
            
            stage('Starting Container ') {
            agent { label 'wcsv9' }
                steps { 
                    dir ('/home/CustDeploy') {
                    sh "docker-compose -f docker-compose-auth-crs.xml up -d"
                    
                    }
            }
            }
            
            
            
        }
}
