# syntax=docker/dockerfile:1
FROM python:3.10-alpine
WORKDIR /
ENV FLASK_APP=dana-chat.py
ENV FLASK_RUN_HOST=0.0.0.0
RUN apk add --no-cache gcc musl-dev linux-headers sqlite3 libsqlite3-dev
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
COPY ./system_init/db/init_db.sql ./system_init/db/init_db.sql
RUN cd ./system_init/db/ && sqlite3 database.db < init_db.sql
EXPOSE 5000
COPY . .
CMD ["flask", "run", "--debug"]
