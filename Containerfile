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

# Create workspace dir
RUN mkdir -p /home/${USERNAME}/workspace/repos/github/neffercarrillo/

# Switch to github dir
WORKDIR /home/${USERNAME}/workspace/repos/github/neffercarrillo/

# Get dotfiles from github
RUN git clone https://github.com/neffercarrillo/dotfiles.git

# Get into dotfiles
WORKDIR /home/${USERNAME}/workspace/repos/github/neffercarrillo/dotfiles

# Setup dotfiles
RUN perl setup

# Switch to user's home directory
WORKDIR /home/${USERNAME}

# Default command: Start a Bash shell
CMD ["bash", "-l"]
