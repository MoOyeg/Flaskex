FROM python:3

WORKDIR /usr/src/app

RUN chgrp -R 0 /usr/src && \
    chmod -R g=u /usr/src

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD [ "python", "app.py" ]
