# Use the nvidia/cuda base image with CUDA 12.2.2 and Ubuntu 22.04
FROM nvidia/cuda:12.2.2-runtime-ubuntu22.04

# Set the DEBIAN_FRONTEND environment variable to noninteractive
ENV DEBIAN_FRONTEND noninteractive

# Update the package repositories
RUN apt-get update
# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    libpq-dev \
    python3-dev \
    python3-pip \
    python3-setuptools \
    python3-wheel

# Install Git
RUN apt-get install -y git

# Upgrade pip to the latest version
RUN pip install --upgrade pip

# Install the 'xformers' Python package
RUN pip install xformers

# Install additional system packages
RUN apt-get update && apt-get install ffmpeg libsm6 libxext6 -y
RUN apt-get update && apt-get install libgl1
RUN apt install -y python3.10-venv
RUN apt install -y --no-install-recommends google-perftools
RUN apt-get install -y wget
# Create a user named 'ubuntu' with specified user and group settings
RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1001 ubuntu

# Set the working directory to /home/ubuntu and copy the current directory contents to it
USER ubuntu
ADD . /home/ubuntu
WORKDIR /home/ubuntu

# Copy the contents of the current directory into the container
COPY . .

# Expose port 7806 (if your application uses this port)
EXPOSE 7860

# Specify the command to run when the container starts
CMD ["bash", "webui.sh"]
