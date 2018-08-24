Repo for all the stuff required for staging-setup

Docker image : 

kanu15025/tomcat-staging-docker:latest   // Image with filebeat inbuild



For reference on creating an app on dcos :

Reference config :

{
  "id": "staging-app",
  "cmd": null,
  "cpus": 1,
  "mem": 6000,
  "disk": 0,
  "instances": 1,
  "acceptedResourceRoles": [
    "*"
  ],
  "container": {
    "type": "DOCKER",
    "docker": {
      "forcePullImage": true,
      "image": "kanu15025/tomcat-staging-docker:latest",
      "parameters": [],
      "privileged": false
    },
    "volumes": [
      {
        "containerPath": "<container war path>",
        "hostPath": "<host war path>",
        "mode": "RO"
      }
    ],
    "portMappings": [
      {
        "containerPort": 8080,
        "hostPort": 0,
        "labels": {},
        "protocol": "tcp",
        "servicePort": <randomly assignned port>
      }
    ]
  },
  "env": {
    "LOGGING_KAFKA_TOPIC": "<Specify it for outputing logs to Kafka>",
    "LOGGING_IN_FILE": "<Logs location>",
    "LOGGING_OUT_FILE": "<Output location for the logs>",
    "WarName": "<War name to be picked up>"
  },
  "healthChecks": [
    {
      "gracePeriodSeconds": 300,
      "intervalSeconds": 60,
      "maxConsecutiveFailures": 3,
      "portIndex": 0,
      "protocol": "TCP",
      "ipProtocol": "IPv4",
      "timeoutSeconds": 20,
      "delaySeconds": 15
    }
  ],
  "networks": [
    {
      "mode": "container/bridge"
    }
  ],
  "portDefinitions": []
}


For scaling apps to 0 after certain amount under a particular marathon group on dcos setup :
run the script : 
RemoveApps.py

Time is currently set to 5hrs
