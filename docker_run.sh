docker run -it --rm --name pytorch_notebook -p 8888:8888 -v $(pwd)/exchange:/home/jovyan/exchange -v $(pwd)/notebooks:/home/jovyan/work pytorch_notebook_img
