FROM registry.access.redhat.com/ubi8/python-312:1781043418

USER root
RUN dnf install -y libaio && dnf clean all
USER 1001

COPY --chown=1001:0 requirements.txt ./

# Otimiza ferramentas de build e executa a instalação limpa
RUN pip install --no-cache-dir --upgrade pip setuptools wheel && \
    pip install --no-cache-dir -r ./requirements.txt

ENV HOME=/opt/app-root/src
RUN chmod -R g+w /opt/app-root/src

EXPOSE 8888

CMD [ "jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--AllowRoot" ]
