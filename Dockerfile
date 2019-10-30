#Dockerfile for Openshift
#Must pass $WORK_DIR in build environment

FROM python:3

WORKDIR ${WORK_DIR}

COPY requirements.txt ${WORK_DIR}
COPY uid_entrypoint ${WORK_DIR}

RUN chmod -R ugo+x ${WORK_DIR}/uid_entrypoint && \
    chgrp -R 0 ${WORK_DIR} && \
    chmod -R g=u ${WORK_DIR}

RUN pip install --no-cache-dir -r requirements.txt
RUN export PATH=$PATH:${WORK_DIR}

COPY . .
EXPOSE 5000/tcp

### Containers should NOT run as root as a good practice
USER 10001

### user name recognition at runtime w/ an arbitrary uid - for OpenShift deployments
ENTRYPOINT [ "${WORK_DIR}/uid_entrypoint" ]

CMD [ "python", "app.py" ]
