import requests,json
import time,datetime

apps = requests.get("http://dcos-master-3.ncal.reports.mn:8080/v2/apps/autoopt-staging/*")
if(apps.status_code == 200):
	apps = json.loads(apps.content)
	apps_list = apps['*']
	for app in apps_list:
		max_ts=0
		print app['id'] + "   " +  str(len(app['tasks']))
		if (len(app['tasks'])>0):
			for task in app['tasks']:
				app_ts = time.mktime(datetime.datetime.strptime(task['stagedAt'], "%Y-%m-%dT%H:%M:%S.%fZ").timetuple())
				if(max_ts<app_ts):
					max_ts=app_ts
			
			ts = time.time()
			print ts-max_ts
			if(ts-max_ts>18000):  #5hrs
				print max_ts
				print("http://dcos-master-3.ncal.reports.mn:8080/v2/apps"+app['id'])
				print app['id']
				payload={'id':app['id'],'instances':0}
				scale_down_request = requests.put("http://dcos-master-3.ncal.reports.mn:8080/v2/apps"+app['id'],json=payload)
				if(scale_down_request.status_code==200):
					print("Scaled down to 0  app" + app['id'])
				else:
					print("Error scaling down app "+ app['id'] + " Status code : " + str(scale_down_request.status_code) + scale_down_request.content)
				
