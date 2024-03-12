DOCKER
==============

IMAGES
-------------------------

- **List images**:

.. code-block:: console

    $ docker image ls
    $ docker images


- **Remove images**:

.. code-block:: console

    $ docker rmi <name|id>

- **Image build**:

.. code-block:: console

    $ docker build -t IMAGE_NAME .
    $ docker build -t IMAGE_NAME -f /path/to/Dockerfile /path/to/

"/path/to/": tells Docker to look for the build context in the current directory. The Dockerfile and any files it
references should be located in or below this directory.

- **Image from container current state**: Use the docker commit command to create a new Docker image from the current
state of the container. You'll specify the container ID or name and a name for the new image:

.. code-block:: console

    $ docker commit CONTAINER_ID_OR_NAME new-image-name:tag

CONTAINERS
-------------------------

- **Containers running** (or all with -a):

.. code-block:: console
    
    $ docker ps -a
    $ docker container ls -a


- **Create and start a new container**:

.. code-block:: console

    # -v share folder between 2 worlds
    $ docker run -it -v /local/folder/to/be/shared/:/docker/folder/name/ --name my_debian11 debian:11

- **Enter a started container**:

.. code-block:: console
    
    # container name or ID and the shell you want to use
    $ docker exec -it CONTAINER_NAME_OR_ID /bin/bash

- **Start/stop**:
  
.. code-block:: console

    $ docker start my_debian11
    $ docker stop my_debian11

- **Remove**:

.. code-block:: console

    $ docker rm container_name_or_id
