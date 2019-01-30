docker run -it --rm --name pytorch_notebook -p 8888:8888 -e JUPYTER_ENABLE_LAB=yes  -v $(pwd)/exchange:/home/jovyan/exchange -v $(pwd)/work:/home/jovyan/work pytorch_notebook_img
