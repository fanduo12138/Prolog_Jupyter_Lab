FROM python:3.6

RUN apt update \
    && pip install jupyter -U && pip install jupyterlab \
    && cd && jupyter lab --generate-config \
    && echo "c.NotebookApp.ip = '127.0.0.1'" >> ./.jupyter/jupyter_notebook_config.py \
    && echo "c.NotebookApp.open_browser = True" >> ./.jupyter/jupyter_notebook_config.py \
    && pip install --upgrade calysto_prolog \
    && python -m calysto_prolog install \
    && apt-get autoremove -y \
    && apt-get autoclean

VOLUME /notebooks
VOLUME /home/opam/.jupyter
WORKDIR /notebooks

EXPOSE 8888

ENTRYPOINT ["jupyter", "lab", "--ip=0.0.0.0","--allow-root"]
