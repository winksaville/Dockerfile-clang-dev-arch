# This is an Arch Linux docker image for compiling clang with clang.
#
# I added user wink, uid=1000, and changed the default group id (gid)
# of users, gid=100 and wheel, gid=10, so it matches the gids of my
# Arch Linux host. This allows me, wink, to create new the files in
# my home directory and the user will be 'wink' and group will be 'users'.
#
# To get this functionality I need to execute docker run with a bunch
# of volume mappings using -v for home, group, gshadow, passwd, shadow and
# sudoers. The '-w `pwd`' will set the current directory as the initial
# directory. The complete command line is:
#   $ docker run --name clang-dev --user=$USER -v /home:/home -w `pwd` \
#    -v /etc/group:/etc/group:ro -v /etc/gshadow:/etc/gshadow \
#    -v /etc/passwd:/etc/passwd:ro -v /etc/shadow:/etc/shadow \
#    -v /etc/sudoers:/etc/sudoers \
#    --rm --entrypoint=/usr/bin/bash -i -t winksaville/clang-dev:arch

FROM archimg/base

RUN pacman -Syu --noconfirm \
  bash-completion \
  clang \
  cmake \
  gdb \
  git \
  lld \
  make \
  ninja \
  nodejs \
  python \
  sudo \
  vim \
  wget

RUN \
 groupmod -g 100 users && groupmod -g 10 wheel \
 && useradd -ms /bin/bash -d /home/wink -G wheel -g users -u 1000 wink \
 && ln -sfn /usr/bin/clang /usr/bin/cc \
 && ln -sfn /usr/bin/clang++ /usr/bin/c++ \
 && rm /usr/bin/gcc* \
 && rm /usr/bin/g++


# Login as user wink
USER wink
WORKDIR /home/wink
