# Web_Application

This is an application to dempnstrate how you can create a quick 2 tier web-app. It contains 2 pods JBoss EAP + mysql.
I used a template (eap70-mysql-s2i, Version: 1.3.0) for this, which you can get from below url :

https://registry.access.redhat.com

use your rhn credentials ofcourse :)

Ensure that while creating the application you fill in correct details for your datasource. I used `myDS` in this case.

Also once the application is built, deployment will trigger and while scaling the pod, it will fail with an error :

```
Error creating: pods "eap-app-1-" is forbidden: service account mysqlj2ee/eap7-service-account was not found, retry after the service account is created
```

To solve this we would need to create below service account and secret :

```
$ echo '{"kind":"ServiceAccount","apiVersion":"v1","metadata":{"name":"eap7-service-account"}}' \ | oc create -f -

$ echo '{"kind":"Secret","apiVersion":"v1","metadata":{"name":"eap7-app-secret"}}' \ | oc create -f -
```

After this trigger the deployment once agin or try to scale the failed application and it should scale successfully. 

This issue has been reported as bug and I will be updating README with the bug details soon. 
Till then we need to use above workaround.

Once the pod is up and ready, click on the route automatically created during the application creation and 
add the context root of application with `NewFile.jsp`. You will get below result.

```
$ curl 10.1.0.4:8080/Web_Tutorial-0.0.1-SNAPSHOT/NewFile.jsp
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>

Entering Try block !!
Registering Driver !!
Getting the connection
Got the connection
101 - Nikhil
102 - Amit
103 - Prabhat
Closed the connection

<body>

</body>
</html>
```

P.S. : Do not forget to create TABLE and Insert few values prior testing the app :D
