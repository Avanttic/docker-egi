FROM debian:8

RUN apt-get update
RUN apt-get install -y sudo tar curl bzip2 libfreetype6 libfontconfig1 libxrender1 libxext6 libxdamage1 libxcomposite1 libasound2 libdbus-glib-1-2 libgtk*
RUN apt-get install -y icedtea-plugin

# Replace 1000 with your user / group id
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/weblogic && \
    echo "weblogic:x:${uid}:${gid}:Weblogic,,,:/home/weblogic:/bin/bash" >> /etc/passwd && \
    echo "weblogic:x:${uid}:" >> /etc/group && \
    echo "weblogic ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/weblogic && \
    chmod 0440 /etc/sudoers.d/weblogic && \
    chown ${uid}:${gid} -R /home/weblogic

USER weblogic
ENV HOME /home/weblogic
RUN cd && \
    curl -O https://ftp.mozilla.org/pub/firefox/releases/45.8.0esr/linux-x86_64/en-US/firefox-45.8.0esr.tar.bz2 && \
    tar xvjf firefox-45.8.0esr.tar.bz2
CMD /home/weblogic/firefox/firefox "http://saas.avanttic.com:7778/forms/frmservlet?config=egiexp17&P_CODEMP=AVT"
