# docker-pytorch-notebook



| <p><img width="300" src="https://upload.wikimedia.org/wikipedia/commons/7/79/Docker_%28container_engine%29_logo.png" /></p> | <p><img width="300" src="https://upload.wikimedia.org/wikipedia/commons/9/96/Pytorch_logo.png" /></p> | <p><img width="300" src="https://upload.wikimedia.org/wikipedia/commons/thumb/3/38/Jupyter_logo.svg/250px-Jupyter_logo.svg.png" /></p> |
|:-------------------------:|:-------------------------:|:-------------------------:|
|           Docker          |          Pytorch          | Jupyter notebook/ JupyterLab |



## Overview
This repo provides the means to run Pytorch(CPU installation) and Jupyter notebook inside a Docker container.  
By exposing the port you can access the notebooks via a web browser on your host system.  
The container is self-cleaning, i.e. it resets everytime you restart it.  
Only two folders (one for notebooks, one for other data exchange) are persistent because they are mounted from the host making them also accessible from both host and container.

## First-steps
For convenience the necessary docker commands are saved in one-line bash scripts so you don't have to type them every time. For better understanding they are added in comments below.

### Post-installtion step
Make bash files executable:
```bash
chmod +x docker_*.sh
```


### Building the docker image
To build the image, type:
```bash
# docker build -t pytorch_notebook_img .
./docker_build.sh
```
This will take a while if you run it for the first time because it needs to pull the [scipy-notebook](https://hub.docker.com/r/jupyter/scipy-notebook) base-image and installs pytorch on top of it.

### Running the docker image 
To run the previously built image, type:
```bash
# docker run -it --rm --name pytorch_notebook -p 8888:8888 -v $(pwd)/exchange:/home/jovyan/exchange -v $(pwd)/notebooks:/home/jovyan/work pytorch_notebook_img
./docker_run.sh
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
./docker_join.sh
```
This opens a bash session inside the container. The default user is "joyvan" and the password is also "joyvan".  
Note that all changes will be lost after you exit the container. More information in the following chapter.

### (Note) Auto-removing docker container
By specifying the --rm flag in *docker-run.sh* the container is removed after it ends.
This is the intended behavior because we want to keep the docker container clean. If you want to e.g. add packages to the container add them as a RUN step in the Dockerfile and rebuild the image. Alternatively you can [docker commit](https://docs.docker.com/engine/reference/commandline/commit/) the changes of a container to a new image.

## Additional features

### Change theme of Jupyter UI
By installing [jupyter-themes](https://github.com/dunovank/jupyter-themes) you are able to change the Jupyter UI (e.g. if you want a darker theme). To do this uncomment the section _"(optional) Install and switch jupyter theme"_ in the Dockerfile.

If you want to try out different themes join a running container and type ```jt -l``` to display available themes and type ```jt -t THEMENAME``` to change the theme. A simple reload of the browser page will update the UI.

Currently, 9 alternative themes are supported: _chesterish, grade3, gruvboxd, gruvboxl, monokai, oceans16, onedork, solarizedd, solarizedl._

### Use JupyterLab
If you want to use JupyerLab instead of Jupyter notebook use
```bash
# docker run -it --rm --name pytorch_notebook -p 8888:8888 -e JUPYTER_ENABLE_LAB=yes -v $(pwd)/exchange:/home/jovyan/exchange -v $(pwd)/notebooks:/home/jovyan/work pytorch_notebook_img
./docker_labrun.sh
```
instead of ```./docker_run.sh```. Otherwise the steps are the same.  
Note that [jupyter-themes](https://github.com/dunovank/jupyter-themes) are currently not supported for JupyterLab.

## Supported Host OS
Currently this setup is only tested on a MacOS host. Should work on linux hosts as well.
I am not sure if it works on Windows. I think the Dockerfile should work. You might have to manually enter the .sh files into the terminal window. I am happy for feedback.
