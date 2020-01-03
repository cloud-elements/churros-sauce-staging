FROM  ubuntu:18.04
MAINTAINER developer@cloud-elements.com
ENV USER=root
ENV CHURROS_USER="churros@churros.com"
ENV CHURROS_URL="staging.cloud-elements.com"
ENV CHURROS_PASSWORD="elements1"
ENV CHURROS_ENV="staging"
ENV DISPLAY=:99
RUN apt-get update
RUN apt-get install curl -yq
RUN apt-get install ssh -yq
RUN apt-get install git -yq
RUN apt-get install jq -yq
RUN apt-get install build-essential libssl-dev -yq
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt install build-essential
RUN wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
CMD source ~/.bashrc
CMD source ~/.profile
RUN apt-get install nodejs -yq
CMD source ~/.profile
RUN apt-get install firefox -yq
RUN apt-get install xvfb -yq
RUN apt-get install xsel -yq
RUN apt-get install unzip -yq
RUN apt-get install libncurses5 -yq
RUN apt-get install libxml2-dev -yq
RUN apt-get install libxslt-dev -yq
RUN apt-get install libz-dev -yq
RUN apt-get install fonts-liberation -yq
RUN apt-get install libappindicator3-1 -yq
RUN apt-get install libxss1 -yq
RUN apt-get install xclip -yq
RUN echo $NVM_DIR
RUN echo $PATH
RUN wget -q "https://github.com/mozilla/geckodriver/releases/download/v0.23.0/geckodriver-v0.23.0-linux64.tar.gz" -O /tmp/geckodriver.tgz \
    && tar zxf /tmp/geckodriver.tgz -C /usr/bin/ \
    && rm /tmp/geckodriver.tgz

# chromeDriver v2.45
RUN wget -q "https://chromedriver.storage.googleapis.com/79.0.3945.36/chromedriver_linux64.zip" -O /tmp/chromedriver.zip \
    && unzip /tmp/chromedriver.zip -d /usr/bin/ \
    && rm /tmp/chromedriver.zip

# chrome
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN dpkg -i google-chrome-stable_current_amd64.deb; apt-get -fy install
ENTRYPOINT /bin/bash
