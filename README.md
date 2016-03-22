Cloud9 IDE container
====================

Cloud9 IDE SDK container with git and python.

To build the container:

```
git clone https://github.com/rjrivero/docker-c9
cd docker-c9

# To build the x86 version
docker build --rm -t c9 .
```

To run:

```
docker run --rm -p 8080:8080 \
           -v /opt/c9/data:/home/c9/data \
           -e C9_PASSWORD=mypassword \
           --name c9 c9
```

Volumes
-------

If you want to make your development persistent, you can mount external directories as volumes, writable by the **c9** user. The c9 user's home is */home/c9*, and it has **uid 1000** and **gid 1000**

Do **not** mount your data volumes directly on */home/c9*! There are some folders there, like *.c9* or .*config*, required for correct c9 operation.

Environment Variables
---------------------

The container accepts a single environment variable, **C9_PASSWORD**, with the password for the cloud9 default *admin* user.

Ports
-----

The container exposes the c9 IDE at port **8080**.
