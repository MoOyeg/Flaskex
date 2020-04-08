#Dockerfile for Openshift
#Must pass $WORK_DIR in build environment

FROM python:3

USER root
RUN mkdir -p ${WORK_DIR}
COPY requirements.txt ${WORK_DIR}
RUN touch /usr/local/lib/python3.8/site-packages/scripts
RUN echo "${WORK_DIR}/scripts" > /usr/local/lib/python3.8/site-packages/scripts

# Adjust permissions on /etc/passwd so writable by group root.
RUN chmod g+w /etc/passwd
RUN chgrp -Rf root ${WORK_DIR}
RUN chmod -Rf g+w ${WORK_DIR}

#Install PIP
WORKDIR ${WORK_DIR}

RUN pip install --no-cache-dir -r requirements.txt

COPY . .
EXPOSE 5000/tcp

### Containers should NOT run as root as a good practice
USER 10001

CMD [ "python", "app.py" ]
