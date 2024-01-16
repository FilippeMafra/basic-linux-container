FROM alpine:3.7

LABEL dev.mafra.image.authors="org@mafra.dev"

ENV TERM xterm

ENV USER_UID 1000
ENV USER_GID 1000
ENV USER_NAME mafra
ENV USER_HOME /home/mafra

RUN apk update && \
    apk upgrade && \
    adduser -D -u $USER_UID $USER_NAME -g $USER_GID && \
    rm -rf /var/cache/apk/*

CMD ["/bin/sh"]

# git
RUN apk add --no-cache --update git

# zsh
RUN apk add zsh

# oh my zsh
RUN apk add --no-cache wget && \
    sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

# asdf
RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf
RUN sed "s/plugins=(/plugins=(asdf /g" "/root/.zshrc"

# volume base
RUN cd && \
    mkdir shared

# ssh
EXPOSE 22

VOLUME ~/shared
