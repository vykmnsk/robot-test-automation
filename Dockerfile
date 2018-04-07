FROM python:2.7-alpine3.7

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories && \
    echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk --no-cache  update && \
    apk --no-cache  upgrade && \
    apk add --no-cache --virtual .build-deps \ 
    chromium chromium-chromedriver \
    # gifsicle pngquant optipng libjpeg-turbo-utils udev ttf-opensans \
    && rm -rf /var/cache/apk/* /tmp/*

# ENV CHROME_BIN /usr/bin/chromium-browser

WORKDIR /src/robot/

COPY lib/ lib/
COPY tests/ tests/
COPY requirements.txt .

RUN pip install --trusted-host pypi.python.org -U pip
RUN pip install --trusted-host pypi.python.org -U -r requirements.txt

CMD robot -d results $TA_RUN_TAGS -v HEADLESS:yes tests