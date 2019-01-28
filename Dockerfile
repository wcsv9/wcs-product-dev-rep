FROM gcr.io/tj-devops/commerce/crs-app:9.0.0.6
COPY CustDeploy /SETUP/Cus
RUN chmod 777 -R  /SETUP/Cus &&\
/SETUP/bin/applyCustomization.sh
