FROM python:3

WORKDIR $WORKDIR

COPY requirements.txt ./
COPY uid_entrypoint ./

RUN chmod -R ugo+x uid_entrypoint && \
    chgrp -R 0 /../.. && \
    chmod -R g=u /usr/src

RUN pip install --no-cache-dir -r requirements.txt
RUN export PATH=$PATH:/usr/src/app

COPY . .
EXPOSE 5000/tcp

### Containers should NOT run as root as a good practice
USER 10001

### user name recognition at runtime w/ an arbitrary uid - for OpenShift deployments
ENTRYPOINT [ "/usr/src/app/uid_entrypoint" ]

CMD [ "python", "app.py" ]
