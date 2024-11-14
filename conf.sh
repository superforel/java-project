#!/bin/bash

systemctl restart nginx
java -jar /app/simpleweb.jar
