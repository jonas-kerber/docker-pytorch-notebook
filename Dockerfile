FROM jupyter/scipy-notebook:latest

##### Update conda and install pytorch
RUN conda update -n base conda
RUN conda install -y pytorch torchvision -c soumith

#####  Add default user to sudoers and set passwd (need root)
USER root
RUN adduser jovyan sudo
RUN echo 'jovyan:jovyan' | chpasswd

##### Install additonal packages (need root)
RUN apt-get update
RUN apt-get install -y vim less
USER jovyan

##### (optional) Install and switch jupyter theme
#RUN conda install -y jupyterthemes
#RUN jt -t gruvboxd
