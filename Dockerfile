# iperf3 in a container
#
# Run as Server:
# docker run  -it --rm --name=iperf3-srv -p 5201:5201 networkstatic/iperf3 -s
#
# Run as Client (first get server IP address):
# docker inspect --format "{{ .NetworkSettings.IPAddress }}" iperf3-srv
# docker run  -it --rm networkstatic/iperf3 -c <SERVER_IP>
#
FROM debian:latest
MAINTAINER Matthew Mattox matthew.mattox@rancher.com
# Based on https://hub.docker.com/r/networkstatic/iperf3/dockerfile

# install binary and remove cache
RUN apt-get -qq update \
    && apt-get -qq install -y \
    iperf3 \
    traceroute \
    curl \
    procps \
    net-tools\
    wget \
    && rm -rf /var/lib/apt/lists/*

# Expose the default iperf3 server port
EXPOSE 5201

# entrypoint allows you to pass your arguments to the container at runtime
# very similar to a binary you would run. For example, in the following
# docker run -it <IMAGE> --help' is like running 'iperf3 --help'
CMD ["iperf3"]
