FROM gcr.io/rc-devops/commerce/crs-app:9.0.1.1-fix1
COPY CustDeploy /SETUP/Cus
RUN chmod 777 -R  /SETUP/Cus &&\
/SETUP/bin/applyCustomization.sh
