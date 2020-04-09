#Dockerfile for Openshift
#Must pass $WORK_DIR in build environment

FROM python:3

USER root
RUN mkdir -p ${WORK_DIR}
COPY requirements.txt ${WORK_DIR}
COPY . ${WORK_DIR}/

# Adjust permissions on /etc/passwd so writable by group root.
RUN chgrp -R 0 ${WORK_DIR} && chmod -R g=u ${WORK_DIR}
RUN chmod g+w /etc/passwd

#Install PIP
WORKDIR ${WORK_DIR}
RUN pip install --no-cache-dir -r requirements.txt

#Expose Ports
EXPOSE 8080/tcp

CMD [ "python", "app.py" ]
