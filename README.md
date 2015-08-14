# Docker Jenkins

Docker build info for a useful jenkins image. Based on the ["official" docker hub jenkins image](https://hub.docker.com/_/jenkins/).
See above for documentation on customizing this image, as well as [official github repo](https://github.com/jenkinsci/docker).

*N.B., NOT BASED ON INTUIT RHEL IMAGE*

Usage
-----

I launch a container with this image mapping a local volume to `/var/jenkins_home`. This ensures the data isn't lost,
and it's easily accessible. You do this any way you like, but do make sure that `/var/jenkins_home` is not left ephemeral.

This image also sets up JDK 7 and 8, and Maven 3.1.1, 3.2.5, and 3.3.3.

Also, if you want to iterate development, you may want to map your local git repository as a volume to your container. See example.

Example
-------

    docker run -d --name myjenkins -p 8080 -p 50000 -v $HOME/sandbox/docker/jenkins_home:/var/jenkins_home -v $HOME/sandbox/apps/risk-assessment/.git:/home/git/repos/risk-assessment.git dpisoni/jenkins:v1

Here I'm mapping a local directory (initially empty) as my jenkins_home, and also a git repo (tied to my working copy) to a directory in the container.
