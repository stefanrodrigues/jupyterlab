FROM registry.access.redhat.com/ubi9/python-39

RUN pip install --upgrade --no-cache-dir jupyterlab

EXPOSE 8888

CMD [ "jupyter","lab","--ip=0.0.0.0" ]
