FROM python:alpine3.7

#copy the contents to the root
COPY . /app

#set the working directory
WORKDIR /app

ENV PACKAGES="\
    dumb-init \
    musl \
    libc6-compat \
    linux-headers \
    build-base \
    bash \
    git \
    ca-certificates \
    freetype \
    libgfortran \
    libgcc \
    libstdc++ \
    openblas \
    tcl \
    tk \
    libssl1.0 \
    "

ENV PYTHON_PACKAGES="\
    numpy \
    matplotlib \
    scipy \
    scikit-learn \
    nltk \
    " 

RUN apk add --no-cache --virtual build-dependencies python3 \
    && apk add --virtual build-runtime build-base python3-dev openblas-dev freetype-dev pkgconfig gfortran \
    && ln -s /usr/include/locale.h /usr/include/xlocale.h \
    && python3 -m ensurepip \
    && rm -r /usr/lib/python*/ensurepip \
    && pip3 install --upgrade pip setuptools \
    && ln -sf /usr/bin/python3 /usr/bin/python \
    && ln -sf pip3 /usr/bin/pip \
    && rm -r /root/.cache \
    && pip install --no-cache-dir $PYTHON_PACKAGES \
    && pip3 install 'pandas<0.21.0' \
    && apk add --no-cache --virtual build-dependencies $PACKAGES \
    && rm -rf /var/cache/apk/*

RUN pip install numpy==1.16.1 scikit-learn==0.20.2 scipy==1.2.1 nltk==3.4 pandas==0.24.1 matplotlib==3.0.2

RUN apk del build-runtime