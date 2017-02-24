# paashello
An example dockerized application that shows how to build a docker image for an app, push it to the registry, and then deploy the application to the PaaS Platform under a customer's namespace. The application is scaled to 3 instances, re-routed by AVI, and exposed as a public application accessed by a DNS hostname. 

## Pre-requisites
- Install [Docker](https://docs.docker.com/engine/installation/). If you are on the Mac OSX, install [Docker for Mac](https://docs.docker.com/engine/installation/mac/#/docker-for-mac).
- Install [DCOS CLI](https://dcos.io/docs/1.7/usage/cli/install/)
  - Follow the manual instructions, ignore AWS references
  - You will need some data to complete the setup. These data values were sent to you as part of the onboarding process.
    - master node = $DCOS_URL
    - username = $ADMIN_USER
    - password = $PASSWORD

## Get the code
```
$ git clone https://github.webapps.rr.com/Docker/paashello.git
```

## Build the app
```
$ cd paashello
$ docker build -t paashello .
$ docker run -P -d --name paashello paashello
```

## Upload the image to the Docker Private Registry
```
### Use the credentials $ADMIN_USER_REGISTRY / $PASSWORD to authenticate.
$ docker login $REGISTRY_URL
$ docker tag paashello $REGISTRY_PATH
$ docker push $REGISTRY_PATH
```
Note: Go to $REGISTRY_URL to see your uploaded image.

## Deploy the app
```
$ cp deploy.json.sample deploy.json
### Update the 'deploy.json' file by replacing $REGISTRY_PATH, $VIP, $TEAMNAME, and $CREDENTIAL_FILE. 
### These data values were sent to you as part of the onboarding process.
$ dcos config set core.dcos_url $DCOS_URL
$ dcos config set marathon.url $MARATHON_URL # needs a trailing '/'
### Use $ADMIN_USER / $PASSWORD to authenticate 
$ dcos auth login
$ dcos marathon app add ./deploy.json
```

## View your application
- Go to $MARATHON_URL to see your app running.
- Go to $AVI_URL to see your app being exposed publicly. (This can take a minute or two after the app has successfully started in Marathon.)
- Go to $HOSTNAME to see your application running and showing "Hello World!"

## Stop your application
```
$ dcos marathon app stop /$TEAMNAME-paashello
```

## Remove your application
```
$ dcos marathon app remove /$TEAMNAME-paashello
```

## Automated Build via Jenkins
An alternate method to build the image and deploy the app to Marathon, is via a Jenkins job. A 'marathon.json' file is placed at the root to facilitate that. The main difference between the 'deploy.json.sample' and the 'marathon.json' file is that the 'marathon.json' file does not contain the AVI labels and the Docker credential file URIs. The Jenkins job supplies that at run time. It also does not assume any 'tenant' prefixes in the app id or the image name. All of the tenant details are also supplied at run time.
