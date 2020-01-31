FROM tiangolo/uwsgi-nginx:python3.6

ENV TZ="Asia/Tokyo"

# # for flask application
RUN  apt-get update -y \
    && apt-get install -y --no-install-recommends \
    && apt-get -y install autoconf libtool \
    && apt-get install -y git tzdata locales \
    && localedef -f UTF-8 -i ja_JP ja_JP.UTF-8

ENV LANG="ja_JP.UTF-8" \
    LANGUAGE="ja_JP:ja" \
    LC_ALL="ja_JP.UTF-8"

# - upgrade system
RUN apt-get upgrade -y \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

COPY ./requirements.txt /app
RUN pip install --upgrade pip \
    && pip install -r requirements.txt

# -----
# - for uwsgi-nginx flacsk setup
RUN pip install flask

ARG PYTHONPATH
WORKDIR $PYTHONPATH

RUN mv /entrypoint.sh /uwsgi-nginx-entrypoint.sh
COPY base/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

# Run the start script provided by the parent image tiangolo/uwsgi-nginx.
# It will check for an /app/prestart.sh script (e.g. for migrations)
# And then will start Supervisor, which in turn will start Nginx and uWSGI
CMD ["/start.sh"]
