# Repo
https://github.com/winksaville/clang-dev-arch.git

# Pull image
```bash
docker pull winksaville/clang-dev:arch
```

# Build image

```bash
docker build -t winksaville/clang-dev:arch .
```

# Run image

The easy way to run the image is use docker-compose which
uses docker-compose.yml to set the volumes and the network
(runs in privileged mode so gdb can be used):
```bash
docker-compose run --rm -w `pwd` clang-dev
```

To manually run the image as the current user which is
equivalent to docker-compose above:
```bash
docker run --privileged --name clang-dev --user=$USER -v /home:/home -w `pwd` -v /etc/group:/etc/group:ro -v /etc/gshadow:/etc/gshadow:ro -v /etc/passwd:/etc/passwd:ro -v /etc/shadow:/etc/shadow:ro -v /etc/sudoers:/etc/sudoers:ro --rm -it winksaville/clang-dev:arch
```

# Push to dockerhub

```bash
docker push winksaville/clang-dev:arch
```
