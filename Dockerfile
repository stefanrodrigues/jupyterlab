FROM registry.access.redhat.com/ubi9/python-39:1-172

# Opcional: Se for usar cx-Oracle, ele precisa das libs nativas da Oracle instaladas no SO.
# Caso vá usar apenas conexões que não dependem do Instant Client, pode remover as 3 linhas abaixo.
USER root
RUN dnf install -y libaio && dnf clean all
USER 1001

# Copia os requerimentos para o diretório padrão (/opt/app-root/src)
COPY --chown=1001:0 requirements.txt ./

# Atualiza pip e instala as dependências
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r ./requirements.txt

# Copia o restante do código/notebooks se houver (opcional)
# COPY --chown=1001:0 . .

# Expõe a porta padrão do Jupyter
EXPOSE 8888

# Garante que o OpenShift (mesmo com UID aleatório) pertença ao grupo raiz (0) e consiga escrever no home
ENV HOME=/opt/app-root/src
RUN chmod -R g+w /opt/app-root/src

# Comando de inicialização seguro para OpenShift (sem token para facilitar, ou configure uma senha)
CMD [ "jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--AllowRoot" ]
