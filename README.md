# Running Apache Tomcat on a Raspberry Pi 3B+

## Overview
I wanted to show a friend how easy it would be to spin up a web-app container in Docker this afternoon. It turns out that it's mega-easy!  I had already previously installed Docker on the Pi in Raspbian.  I built the container on my desktop machine (in Windows) and uploaded it to my repository on dockerhub (dockerhub.com) and then pulled it to the Raspberry Pi from there.

## Apache Tomcat
To run on a Raspberry Pi 3B+, Tomcat needs to be build against an ARMv7 processor. Luckily there is such a beast and it's even maintained by the Docker community. You can find it here: https://hub.docker.com/r/arm32v7/tomcat/. I decided to use arm32v7/tomcat:8.0

All I had to add to the dockerfile was expose port 8080 for Apache

## build
To build and deploy the container on the Raspberry Pi, it couldn't be simpler.  I built the container on my Windows PC.
### Build the container
```dockerfile
docker build -t sample-tomcat .
```
### Push the container image to the registry
So the Raspberry Pi could access the container image, I pushed it to my container repository.  You should login first if you have not done so already
```
docker login
```
###Get a list of your docker images
```
docker images
```
the output should look like this
```
REPOSITORY                                 TAG                 IMAGE ID            CREATED              SIZE
sample-tomcat                              latest              1234567890ab        About a minute ago   283MB
```
###Push your container
My dockerhub id is appthem (replace this with your own). I have tagged the image with "firsttry" as it's not best practice to use the default "latest".
```
docker tag 1234567890ab appthem/sample-tomcat:firsttry
```
Then push the container to dockerhub (again replace appthem with your own id)
```
docker push appthem/sample-tomcat
```

## Run
On your Raspberry Pi, you can now run the container
```
docker run -it --rm -p 8888:8080 appthem/sample-tomcat:firsttry
```

You will be able to see it running at http://localhost:8888 or http://pi-host-ip:8888 in a browser.
