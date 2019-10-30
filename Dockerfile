FROM python:3

WORKDIR /usr/src/app

RUN chgrp -R 0 /usr/src && \
    chmod -R g=u /usr/src

COPY requirements.txt ./
COPY uid_entrypoint ./

RUN pip install --no-cache-dir -r requirements.txt

COPY . .
EXPOSE 5000/tcp

### Containers should NOT run as root as a good practice
USER 10001

### user name recognition at runtime w/ an arbitrary uid - for OpenShift deployments
ENTRYPOINT [ "uid_entrypoint" ]
CMD [ "python", "app.py" ]
