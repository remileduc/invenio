# -*- coding: utf-8 -*-
#
# This file is part of Invenio.
# Copyright (C) 2015, 2016, 2017 CERN.
#
# Invenio is free software; you can redistribute it
# and/or modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of the
# License, or (at your option) any later version.
#
# Invenio is distributed in the hope that it will be
# useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Invenio; if not, write to the
# Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston,
# MA 02111-1307, USA.
#
# In applying this license, CERN does not
# waive the privileges and immunities granted to it by virtue of its status
# as an Intergovernmental Organization or submit itself to any jurisdiction.

# Use Python-2.7:
FROM python:2.7-slim

# Args coming from docker-compose
ARG DEBUG

# Configure Invenio instance:
ENV INVENIO_WEB_INSTANCE=invenio
ENV INVENIO_INSTANCE_PATH=/usr/local/var/invenio-instance
ENV FLASK_DEBUG=$DEBUG

# Install Invenio web node pre-requisites:
RUN apt-get update -qy \
    && apt-get install -qy \
        apt-utils \
        curl \
    && curl -sL https://deb.nodesource.com/setup_7.x | $sudo bash - \
    && apt-get update -qy \
    && apt-get install -qy \
        git \
        libffi-dev \
        libfreetype6-dev \
        libjpeg-dev \
        libmsgpack-dev \
        libpq-dev \
        libssl-dev \
        libtiff-dev \
        libxml2-dev \
        libxslt-dev \
        nano \
        nginx \
        nodejs \
        python-dev \
        python-pip \
        rlwrap \
        screen \
        sshpass \
        vim \
    && apt-get autoremove -qy --purge \
    && apt-get clean -qy

# Create Invenio instance:
RUN pip install -U \
    invenio-app-ils[postgresql,elasticsearch2] \
    jinja2-cli>=0.6.0 \
    git+https://github.com/inveniosoftware/invenio-archivematica.git#egg=invenio-archivematica \
    invenio-records-files
# Bug in simplekv, see https://github.com/mbr/simplekv/issues/57
RUN pip install -U simplekv==0.10.0
RUN mkdir -p ${INVENIO_INSTANCE_PATH}
WORKDIR ${INVENIO_INSTANCE_PATH}
COPY scripts/instance.cfg invenio.cfg
RUN ${INVENIO_WEB_INSTANCE} npm \
    && cd static \
    && npm update \
    && npm install -g --silent node-sass@3.8.0 clean-css@3.4.19 uglify-js@2.7.3 requirejs@2.2.0 \
    && ${INVENIO_WEB_INSTANCE} collect -v \
    && ${INVENIO_WEB_INSTANCE} assets build
RUN chmod -R 777 ${INVENIO_INSTANCE_PATH}
RUN mkdir /archive && chmod -R 777 /archive

# Start the Invenio application:
CMD ["/bin/bash", "-c", "invenio run -h 0.0.0.0"]
