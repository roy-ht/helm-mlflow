FROM python:3.10-slim

ARG MLFLOW_VERSION

RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends build-essential libpq-dev \
    && rm -rf /var/lib/apt/lists/*

RUN pip install mlflow==${MLFLOW_VERSION} psycopg2==2.9.5 boto3==1.26.38

COPY entrypoint.sh /
RUN chmod 755 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["--default-artifact-root", "/opt/artifact"]
EXPOSE 80