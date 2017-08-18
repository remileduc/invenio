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
FROM ampervue/python27

RUN apt-get update -q=2 && apt-get upgrade -q=2 && apt-get install -q=2 \
    apt-transport-https \
    htop \
    mlocate \
    nano \
    sqlite3 \
    libsqlite3-dev \
    wget
RUN updatedb

# archivematica prerequisites
RUN wget -O - https://packages.archivematica.org/1.6.x/key.asc | apt-key add -
RUN echo "deb [arch=amd64] http://packages.archivematica.org/1.6.x/ubuntu trusty main" >> /etc/apt/sources.list
RUN echo "deb [arch=amd64] http://packages.archivematica.org/1.6.x/ubuntu-externals trusty main" >> /etc/apt/sources.list
# elasticsearch
RUN wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add -
RUN echo "deb http://packages.elasticsearch.org/elasticsearch/1.7/debian stable main" >> /etc/apt/sources.list
#update
RUN apt-get update -q=2 && apt-get upgrade -q=2
# install packages
#RUN apt-get install -q=2 \
#    elasticsearch \
#    archivematica-storage-service \
#    archivematica-mcp-server \
#    archivematica-dashboard \
#    archivematica-mcp-client


# Clean up APT when done.
#RUN apt-get clean -q=2 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD tail -f /dev/null
