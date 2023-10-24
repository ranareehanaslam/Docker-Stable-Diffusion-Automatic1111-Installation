FROM nvidia/cuda:12.2.2-runtime-ubuntu22.04

ENV DEBIAN_FRONTEND noninteractive


RUN apt-get update
# Install dependencies
RUN apt-get update && apt-get install -y \
    libpq-dev \
    python3-dev \
    python3-pip \
    python3-setuptools \
    python3-wheel 
RUN apt-get install -y git


RUN pip install --upgrade pip

#RUN pip install -r requirements_versions.txt
#RUN pip install -r requirements.txt
RUN pip install xformers
RUN apt-get update && apt-get install ffmpeg libsm6 libxext6  -y
RUN apt-get update && apt-get install libgl1
RUN apt install -y python3.10-venv
RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1001 ubuntu
USER ubuntu
ADD . /home/ubuntu
WORKDIR /home/ubuntu

COPY . .
EXPOSE 7806
CMD ["bash", "webui.sh"]
