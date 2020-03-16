FROM us.gcr.io/gcpwcs/crs-app:9.0.1.10
COPY CustDeploy /SETUP/Cus
RUN chmod 777 -R  /SETUP/Cus &&\
/SETUP/bin/applyCustomization.sh
