FROM python:alpine3.8

#copy the contents to the root
COPY . /app

#set the working directory
WORKDIR /app

# install the packages
RUN apk add build-base libffi-dev openssl-dev --no-cache

#copy the cronfile to cron directory
COPY ./cronfile /etc/crontabs
#change the permission of the cronfile
RUN chmod 0644 /etc/crontabs/cronfile
#apply the cron job
RUN crontab /etc/crontabs/cronfile

#command to run the script
CMD ["crond" ,"-f"]
