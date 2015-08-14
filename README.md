# Docker Jenkins

Docker build info for a jenkins image useful for java/maven projects. Based on the ["official" docker hub jenkins image](https://hub.docker.com/_/jenkins/).
See above for documentation on customizing this image, as well as [official github repo](https://github.com/jenkinsci/docker).

This image sets up JDK 7 and 8 (using OpenJDK), and Maven versions 3.1.1, 3.2.5, and 3.3.3.

Usage
-----

Launch a container with this image mapping a volume to `/var/jenkins_home`. This ensures the data isn't lost.

Also, if you want to iterate development, you may want to map your local git repository as a volume to your container. See example.

Example
-------

    docker run -d --name myjenkins -p 8080 -p 50000 -v /var/jenkins_home -v $HOME/sandbox/apps/my_project/.git:/home/git/repos/my_project.git my_jenkins_image

Here I'm mapping my jenkins_home and also a git repo (tied to my working copy) to a directory in the container. This way
I can commit files to my local git branches for use in my jenkins without having to push the code.

TODO
----

* Configure the list of maven and JVM versions and paramerize the groovy scripts
