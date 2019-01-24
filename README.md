# docker-pytorch-notebook



| <p><img width="300" src="https://upload.wikimedia.org/wikipedia/commons/7/79/Docker_%28container_engine%29_logo.png" /></p> | <p><img width="300" src="https://upload.wikimedia.org/wikipedia/commons/9/96/Pytorch_logo.png" /></p> | <p><img width="300" src="https://upload.wikimedia.org/wikipedia/commons/thumb/3/38/Jupyter_logo.svg/250px-Jupyter_logo.svg.png" /></p> |
|:-------------------------:|:-------------------------:|:-------------------------:|
|           Docker          |          Pytorch          | Jupyter notebook          |



## Overview
This repo provides the means to run Pytorch(CPU installation) and Jupyter notebook inside a Docker container.  
By exposing the port you can access the notebooks via a web browser on your host system.  
A folder is mounted on the docker container so you can access your notebooks and other files from both host and container.

## First-steps
### Building the docker image
This will take a while if you run it for the first time because it needs to pull the [scipy-notebook](https://hub.docker.com/r/jupyter/scipy-notebook) base-image and installs pytorch on top of it.
```
source docker_build.sh
```
### Running the docker image 
To run the previously built image, type:
```
source docker_run.sh
```

### Working with Jupyter notebooks
Look at the previous command's output and copy the token string (e.g. e949537d15c56e2b9a2cc543a490cd2adf8f2846d5a822ce).

In your browser, type in: http://localhost:8888 and enter the token string. You can now work with Jupyter.

### Accessing the docker container's filesystem
If you want to access the file system of the container, type:
```
source docker_join.sh
```
This opens a bash session inside the container. Note that the container is removed and therefore any changes will be lost after exiting the docker_run.sh. This is intended by specifying the --rm flag in *docker_run.sh*. 

However there are two folders that are mounted from the host system and therefore are persistent between sessions:
* *work:* All the files created by the Jupyter notebooks are saved in here. That way the files are saved even when the container is removed.
* *exchange:* This folder can be accessed by both host and container if data needs to be exchanged (other than the notebooks)
