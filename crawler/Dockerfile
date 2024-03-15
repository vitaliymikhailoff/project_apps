FROM python:3.6-alpine
WORKDIR app
ADD . .

ENV MONGO mongohost
ENV MONGO_PORT 27017
ENV RMQ_HOST rabbithost
ENV RMQ_QUEUE crawler
ENV RMQ_USERNAME crawler
ENV RMQ_PASSWORD crawler
ENV CHECK_INTERVAL 60
ENV EXCLUDE_URLS '.*github.com'
ENV URL 'https://vitkhab.github.io/search_engine_test_site/'

RUN pip install --no-cache-dir -r requirements.txt -r requirements-test.txt
EXPOSE 8000
ENTRYPOINT ["/bin/sh", "entrypoint.sh"]
