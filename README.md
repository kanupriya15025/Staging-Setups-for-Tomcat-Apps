Repo for all the stuff required for staging-setup

Docker images : 

r.reports.mn/autoopt/tomcat-staging-docker:filebeat  // Image with filebeat inbuild

r.reports.mn/autoopt/tomcat-staging-docker:latest   // Just tomcat image



For reference on creating an app on dcos :

/autoopt-staging/generic-tomcat-container-test



For scaling apps to 0 after certain amount under /autoopt-staging/ group on dcos ncal setup :
run the script : 
RemoveApps.py

Time is currently set to 5hrs
