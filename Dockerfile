FROM jupyter/scipy-notebook:latest

RUN conda install -y pytorch torchvision -c soumith
