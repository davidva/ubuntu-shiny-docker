FROM ubuntu:trusty

MAINTAINER David Vilar "summun@gmail.com"

RUN echo "deb http://cran.ma.imperial.ac.uk/bin/linux/ubuntu trusty/" >> /etc/apt/sources.list

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9

RUN apt-get update

RUN apt-get install -y r-base gdebi-core wget libssl0.9.8

RUN R -e "install.packages('shiny', repos='https://cran.rstudio.com/')"

RUN wget https://download3.rstudio.org/ubuntu-12.04/x86_64/shiny-server-1.4.1.759-amd64.deb

RUN gdebi -n shiny-server-1.4.1.759-amd64.deb

RUN R -e "install.packages(c('rmarkdown', 'tm', 'wordcloud', 'memoise'), repos='http://cran.rstudio.com/')"

COPY /conf/shiny-server.conf /etc/shiny-server/shiny-server.conf

COPY /app/* /srv/shiny-server/

EXPOSE 80

COPY /bin/shiny-server.sh /usr/bin/shiny-server.sh

RUN chmod +x /usr/bin/shiny-server.sh

CMD ["/usr/bin/shiny-server.sh"]








# RUN apt-get update && apt-get install -y \
#     sudo \
#     gdebi-core \
#     pandoc \
#     pandoc-citeproc \
#     libcurl4-gnutls-dev \
#     libcairo2-dev/unstable \
#     libxt-dev

# # Download and install libssl 0.9.8
# RUN wget --no-verbose http://ftp.us.debian.org/debian/pool/main/o/openssl/libssl0.9.8_0.9.8o-4squeeze14_amd64.deb && \
#     dpkg -i libssl0.9.8_0.9.8o-4squeeze14_amd64.deb && \
#     rm -f libssl0.9.8_0.9.8o-4squeeze14_amd64.deb

# # Download and install shiny server
# RUN wget --no-verbose https://s3.amazonaws.com/rstudio-shiny-server-os-build/ubuntu-12.04/x86_64/VERSION -O "version.txt" && \
#     VERSION=$(cat version.txt)  && \
#     wget --no-verbose "https://s3.amazonaws.com/rstudio-shiny-server-os-build/ubuntu-12.04/x86_64/shiny-server-$VERSION-amd64.deb" -O ss-latest.deb && \
#     gdebi -n ss-latest.deb && \
#     rm -f version.txt ss-latest.deb

# RUN R -e "install.packages(c('shiny', 'rmarkdown', 'tm', 'wordcloud', 'memoise'), repos='http://cran.rstudio.com/')"

# COPY shiny-server.conf  /etc/shiny-server/shiny-server.conf
# COPY /myapp/* /srv/shiny-server/

# EXPOSE 80

# COPY shiny-server.sh /usr/bin/shiny-server.sh

# CMD ["/usr/bin/shiny-server.sh"]
