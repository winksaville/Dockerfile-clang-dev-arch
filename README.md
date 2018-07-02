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

# Run image to test

Run the arch image as the current user, which is assumed
to be a user in the docker image. Adding "--privileged"
is useful to run gdb.
```bash
docker run --name arch --user=wink -v /home/wink:/home/wink --rm -i -t winksaville/clang-dev:arch
```

Here is an attempt to run and map passwd, group and shadow to share the information
with the container. But it doesn't quite work :(
See: https://medium.com/@pawitp/syncing-host-and-container-users-in-docker-39337eff0094
```
docker run --name arch --privileged --user=$USER -v /etc/group:/etc/group:ro -v /etc/passwd:/etc/passwd:ro -v /home:/home --rm -i -t winksaville/clang-dev:arch
```

When I do something like create a file the user is OK but group is 1000 not "users"
```
wink@c26b8958de3d:~
$ touch z3.txt
wink@c26b8958de3d:~
$ ls -al z3.txt
-rw-r--r-- 1 wink 1000 0 Jul  2 21:51 z3.txt
```
And sudo doesn't work, the password get asked for and it isn't evaluted
correctly. I have something wrong.

# Run CircleCI jobs locally

Use the [CircleCI CLI](https://circleci.com/docs/2.0/local-cli/) to run the
CI job using this image from the project root:

```bash
circleci build --job arch-debug
circleci build --job arch-release
```
Note: when building you might want to set CPUs environment
variable to speed up the build:
```bash
circleci build -e CPUs=10 --job arch-debug
```

# Push to dockerhub

```bash
docker push winksaville/clang-dev:arch
```
