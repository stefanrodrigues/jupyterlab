FROM registry.access.redhat.com/ubi9/python-39:1-172

# Install requirements
RUN \
  if [ -f requirements.txt ]; \
    then pip install --upgrade --no-cache-dir -r requirements.txt; \
  fi

#OLD
#RUN pip install --upgrade --no-cache-dir jupyterlab

#Port Expose
EXPOSE 8888

CMD [ "jupyter","lab","--ip=0.0.0.0" ]
