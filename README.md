# docker-pytorch-notebook



| <p><img width="300" src="https://upload.wikimedia.org/wikipedia/commons/7/79/Docker_%28container_engine%29_logo.png" /></p> | <p><img width="300" src="https://upload.wikimedia.org/wikipedia/commons/9/96/Pytorch_logo.png" /></p> | <p><img width="300" src="https://upload.wikimedia.org/wikipedia/commons/thumb/3/38/Jupyter_logo.svg/250px-Jupyter_logo.svg.png" /></p> |
|:-------------------------:|:-------------------------:|:-------------------------:|
|           Docker          |          Pytorch          | Jupyter notebook          |



## Overview
This repo provides the means to run Pytorch(CPU installation) and Jupyter notebook inside a Docker container.  
By exposing the port you can access the notebooks via a web browser on your host system.  
A folder is mounted on the docker container so you can access your notebooks and other files from both host and container.

## First-steps
For convenience the necessary docker commands are saved in one-line bash scripts so you don't have to type them every time.  
For better understanding they are added in comments below.
### Building the docker image
To build the image, type:
```bash
# docker build -t pytorch_notebook_img .
source docker_build.sh
```
This will take a while if you run it for the first time because it needs to pull the [scipy-notebook](https://hub.docker.com/r/jupyter/scipy-notebook) base-image and installs pytorch on top of it.

### Running the docker image 
To run the previously built image, type:
```bash
# docker run -it --rm --name pytorch_notebook -p 8888:8888 -v $(pwd)/exchange:/home/jovyan/exchange -v $(pwd)/notebooks:/home/jovyan/work pytorch_notebook_img
source docker_run.sh
```
By forwarding port 8888 you can then access the Jupyter notebook from your host.

### Working with Jupyter notebooks
Look at the output of the previous command and copy the token string (e.g. e949537d15c56e2b9a2cc543a490cd2adf8f2846d5a822ce).  
In your browser, type in: http://localhost:8888 and enter the token string. You can now work with Jupyter.

### Exit the container
Once you have finished working with the notebooks press *CTRL+C* in the terminal window where you ran *docker_run.sh* and confirm by entering *y*.  

### (Optional) Accessing the docker container's filesystem
If you want to access the file system of the container, type:
```bash
# docker exec -it pytorch_notebook bash
source docker_join.sh
```
This opens a bash session inside the container. Note that all changes will be lost after you exit the container. More information in the following chapter.

### (Note) Auto-removing docker container
By specifying the --rm flag in *docker-run.sh* the container is removed after it ends.  
This is the intended behavior because we want to keep the docker container clean. If you want to e.g. add packages to the container add them as a RUN step in the Dockerfile and rebuild the image.

However there are two folders that are mounted from the host system and therefore are persistent between sessions:
* *work:* All the files created by the Jupyter notebooks are saved in here. This saves the notebooks between sessions and also makes them accessible on your host.
* *exchange:* This folder can be accessed by both host and container if data needs to be exchanged (other than the notebooks).
