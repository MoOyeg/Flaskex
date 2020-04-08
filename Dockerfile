#Dockerfile for Openshift
#Must pass $WORK_DIR in build environment

FROM python:3

WORKDIR ${WORK_DIR}

COPY requirements.txt ${WORK_DIR}
COPY uid_entrypoint /

# Adjust permissions on /etc/passwd so writable by group root.
RUN chmod g+w /etc/passwd
RUN chgrp -Rf root ${WORK_DIR}
RUN chmod -Rf g+w ${WORK_DIR}

#Install PIP
RUN pip install --no-cache-dir -r requirements.txt

COPY . .
EXPOSE 5000/tcp

### Containers should NOT run as root as a good practice
USER 10001

CMD [ "python", "app.py" ]
