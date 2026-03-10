FROM fedora:41

RUN dnf install -y \
    curl git sudo bash \
    gcc gcc-c++ make \
    procps-ng file \
    dconf glib2 \
  && dnf clean all

# Simulate Bazzite GNOME environment
RUN echo "VARIANT_ID=bazzite" >> /etc/os-release
ENV XDG_CURRENT_DESKTOP=GNOME
ENV DESKTOP_SESSION=gnome

ARG USERNAME=testuser
RUN useradd -m -s /bin/bash "$USERNAME" \
  && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/"$USERNAME" \
  && chmod 0440 /etc/sudoers.d/"$USERNAME"

USER $USERNAME
WORKDIR /home/$USERNAME

CMD ["bash"]
