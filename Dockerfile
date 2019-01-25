FROM jupyter/scipy-notebook:latest

RUN conda install -y pytorch torchvision -c soumith

# run Dockerfile as root to be able to install packages
USER root
# add jovyan to sudoers and add passwd to "jovyan"
RUN adduser jovyan sudo
RUN echo 'jovyan:jovyan' | chpasswd

# install packages tools
RUN apt-get update
RUN apt-get install -y vim less

# change user back to jovyan in the end after everything is installed
USER jovyan
