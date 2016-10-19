#!/bin/sh

# Run me to launch the example application:
# ./README.sh

# First we start elastisearch. If you don't have it, please install it.
elasticsearch -d
# Then we run rabbitmq. If you don't have it, please install it.
rabbitmq-server -d
# We setup the application.
./app-setup.sh
# Let's put some records in the database.
./app-fixtures.sh
# And now we run it. We need to export FLASK_APP variable so flask knows which file to run.
FLASK_APP=app.py flask run
