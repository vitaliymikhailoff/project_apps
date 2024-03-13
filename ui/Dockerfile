FROM python:3.6-alpine
WORKDIR app
ADD . .

ENV MONGO mongohost
ENV MONGO_PORT 27017
ENV FLASK_APP ui.py
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8000
ENTRYPOINT ["/bin/sh", "entrypoint.sh"]
