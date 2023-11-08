# Alafia AI CONN Toolbox for ARM64

## Introduction

This is a Dockerfile project to build a Matlab image with CONN and SPM pre-installed for use on Alafia AI's ARM64 workstation.

## Usage

### Build

docker build . -t alafia-conn-toolbox

### Run with VNC

```bash
docker run \
  --interactive \
  --tty \
  --rm \
  --platform linux/amd64 \
  -p 5901:5901 \
  -p 6080:6080 \
  --ulimit nofile=10000:10000 \
  --shm-size=512M \
  alafia-conn-toolbox \
    -vnc
```

Navigate to http://localhost:6080 in browser

### Run with Shell

```bash
docker run \
  --interactive \
  --tty \
  --rm \
  --platform linux/amd64 \
  --ulimit nofile=10000:10000 \
  --shm-size=512M
  alafia-conn-toolbox \
    -shell
```

## Resources

- https://web.conn-toolbox.org/resources
- https://github.com/mathworks-ref-arch/matlab-dockerfile
- https://www.nitrc.org/frs/?group_id=279
- https://hub.docker.com/r/mathworks/matlab
- https://github.com/demartis/matlab_runtime_docker
- https://www.mathworks.com/help/cloudcenter/ug/matlab-container-on-docker-hub.html
- https://www.mathworks.com/help/compiler/package-matlab-standalone-applications-into-docker-images.html
- https://github.com/alfnie/conn
- https://www.fil.ion.ucl.ac.uk/spm/software/download/
- https://github.com/spm/spm
