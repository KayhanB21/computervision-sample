#################### Oct 6, 2021
FROM python:3.8.11
LABEL maintainer="Kayhan <me@kayhan.dev>"
RUN pip install --upgrade pip
RUN pip install --no-cache-dir "uvicorn[standard]" gunicorn
####################

#################### Oct 6, 2021
COPY ./docker-config/start.sh /start.sh
RUN chmod +x /start.sh

COPY ./docker-config/gunicorn_conf.py /gunicorn_conf.py
ENV PYTHONPATH=/app
# COPY ./docker-config/app /app
# Source: https://github.com/tiangolo/uvicorn-gunicorn-docker
####################

#################### Oct 6, 2021
# COPY ./docker-config/start-reload.sh /start-reload.sh
# RUN chmod +x /start-reload.sh
# Source: https://github.com/tiangolo/uvicorn-gunicorn-docker
# For development, it's useful to be able to mount the contents of the application code inside
# of the container as a Docker "host volume", to be able to change the code and test it live,
# without having to build the image every time.
####################

#################### Oct 6, 2021
# Can be included (but the chances are low)
# Source: https://github.com/tiangolo/uvicorn-gunicorn-docker
# MODULE_NAME
# VARIABLE_NAME
# APP_MODULE
# GUNICORN_CONF
# WORKER_CLASS
# ACCESS_LOG
# ERROR_LOG
# GUNICORN_CMD_ARGS
# PRE_START_PATH
####################

#################### Oct 6, 2021
# ENV GUNICORN_CMD_ARGS="--preload"
# Source: https://github.com/tiangolo/uvicorn-gunicorn-docker
####################

#################### Oct 6, 2021
ENV WORKERS_PER_CORE=1
# Source: https://github.com/tiangolo/uvicorn-gunicorn-docker
# Note: By default, if WORKERS_PER_CORE is 1 and the server has only 1 CPU core,
# instead of starting 1 single worker, it will start 2.
# This is to avoid bad performance and blocking applications
# (server application) on small machines (server machine/cloud/etc).
# This can be overridden using WEB_CONCURRENCY.
####################

#################### Oct 6, 2021
ENV MAX_WORKERS=2
# Set the maximum number of workers to use.
# By default it's not set, meaning that it's unlimited.
####################

#################### Oct 6, 2021
# ENV WEB_CONCURRENCY=2
# Override the automatic definition of number of workers.
# This would make the image start 2 worker processes,
# independent of how many CPU cores are available in the server.
# by deault ENV WEB_CONCURRENCY=2
####################

#################### Oct 6, 2021
# ENV HOST="0.0.0.0"
# Source: https://github.com/tiangolo/uvicorn-gunicorn-docker
# The "host" used by Gunicorn, the IP where Gunicorn will listen for requests.
# by default ENV HOST="0.0.0.0"
####################

#################### Oct 6, 2021
ENV PORT="8491"
# Source: https://github.com/tiangolo/uvicorn-gunicorn-docker
# The port the container should listen on.
# By default ENV PORT="80"
####################

#################### Oct 6, 2021
# ENV BIND="0.0.0.0:80"
# Source: https://github.com/tiangolo/uvicorn-gunicorn-docker
# The actual host and port passed to Gunicorn.
# by default ENV BIND="0.0.0.0:80"
####################

#################### Oct 6, 2021
# ENV LOG_LEVEL="info"
# Source: https://github.com/tiangolo/uvicorn-gunicorn-docker
# The log level for Gunicorn. One of: debug, info, warning, error, critical
# By default, set to info.
####################

#################### Oct 6, 2021
ENV TIMEOUT=43200
# Source: https://github.com/tiangolo/uvicorn-gunicorn-docker
# Workers silent for more than this many seconds are killed and restarted.
# By default ENV TIMEOUT=120
####################

#################### Oct 6, 2021
# ENV KEEP_ALIVE=2
# Source: https://github.com/tiangolo/uvicorn-gunicorn-docker
# The number of seconds to wait for requests on a Keep-Alive connection.
# By default ENV KEEP_ALIVE=2
####################

#################### Oct 6, 2021
# ENV GRACEFUL_TIMEOUT=120
# Source: https://github.com/tiangolo/uvicorn-gunicorn-docker
# Timeout for graceful workers restart.
# By default ENV GRACEFUL_TIMEOUT=120
####################

#################### Oct 6, 2021
ENV PYTHONUNBUFFERED=1
# Ensures that the python output is sent straight to terminal (e.g. your container log)
# without being first buffered and that you can see the output of your application in real time.
####################

#################### Oct 6, 2021
RUN pip install --upgrade pip
COPY ./requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r /app/requirements.txt
####################

#################### Oct 6, 2021
COPY ./app /app
WORKDIR /app
####################

#################### Oct 6, 2021
CMD ["/start.sh"]
# Source: https://github.com/tiangolo/uvicorn-gunicorn-docker
# Run the start script, it will check for an /app/prestart.sh script (e.g. for migrations)
# And then will start
####################
