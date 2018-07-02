FROM archimg/base-devel

RUN pacman -Syu --noconfirm \
  bash-completion \
  clang \
  cmake \
  gdb \
  git \
  nodejs \
  python \
  vim \
  wget

# add user wink  and don't require a password to use sudo
# since I haven't been able to successfully add passwords :(
#
# Also change the group id (gid) of users and wheel so it matches the
# gids of my arch linux host. Use the command 'id' to see the id
# information.
#   wink@c46e88869f35:~
#   $ id
#   uid=1000(wink) gid=100(users) groups=100(users),10(wheel)
#   wink@c46e88869f35:~
#   $ exit
#   exit
#   wink@wink-desktop:~/prgs/docker/arch
#   $ id
#   uid=1000(wink) gid=100(users) groups=100(users),10(wheel),95(storage),98(power),150(wireshark),992(adbusers),995(docker)
#
# This is a crappy solution but it's working where as
# https://medium.com/@pawitp/syncing-host-and-container-users-in-docker-39337eff0094 and
# https://gist.github.com/marten-cz/77b48b15928eb6f10c901073ff3e3425 didn't.
RUN \
 groupmod -g 100 users && groupmod -g 10 wheel \
 && ln -sfn `which vim` `which vi` \
 && sed -i 's/# %wheel ALL=(ALL) NOPASSWD: ALL/%wheel ALL=(ALL) NOPASSWD: ALL/' /etc/sudoers \
 && useradd -ms /bin/bash -d /home/wink -G wheel -g users -u 1000 wink

# Login as user wink
USER wink
WORKDIR /home/wink
