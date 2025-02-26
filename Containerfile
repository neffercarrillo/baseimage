FROM debian:latest

# vars
ARG USERNAME=app
ENV USERNAME=${USERNAME}
ENV HOME=/home/${USERNAME}

# Install dependencies
RUN apt update && apt install -y \
    rakudo \
    raku-zef \
    python3 \
    python3-pip \
    perl \
    cpanminus \
    git \
    curl \
    bash \
    tmux \
    emacs \
    vim \
    lynx \
    newsboat \
    irssi \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root user and set permissions
RUN useradd -m -s /bin/bash ${USERNAME} && chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}

# Set the working directory to home
WORKDIR /home/${USERNAME}

# Switch to non-root user
USER ${USERNAME}

# Switch to user's home directory
WORKDIR /home/${USERNAME}

# Create workspace dir
RUN mkdir -p /home/${USERNAME}/workspace

# Start emacs daemon
CMD ["/usr/bin/emacs","--daemon"]

# Default command: Start a Bash shell
CMD ["bash", "-l"]
