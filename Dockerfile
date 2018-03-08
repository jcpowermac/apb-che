FROM fedora:27

EXPOSE 4403 8080 8000 22
ENV REQUIRED_PKGS="bzip2 sudo git procps unzip python-pip ansible wget curl docker java-1.8.0-openjdk origin-clients dnf-plugins-core" \
    OPTIONAL_PKGS="ara zsh vim openssh-server nmap vim-jedi vim-powerline vim-pysmell vim-syntastic vim-syntastic-python"

RUN dnf --setopt=deltarpm=false upgrade -y && \
    dnf install -y ${REQUIRED_PKGS} ${OPTIONAL_PKGS} && \
    dnf clean all && \
    rm -rf /var/lib/rpm/__db.00*

# Install Ansible Service Broker and Ansible Playbook Bundle tools
RUN dnf -y copr enable @ansible-service-broker/ansible-service-broker-latest && \
    dnf -y install apb ansible-asb-modules ansible-kubernetes-modules

# Install Service Catalog CLI
RUN curl --url https://download.svcat.sh/cli/latest/linux/amd64/svcat --output /usr/local/bin/svcat && \
    chmod +x /usr/local/bin/svcat

RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config && \
    sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config && \
    echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    useradd -u 1000 -G users,wheel -d /home/user --shell /usr/bin/zsh -m user && \
    usermod -p "*" user && \
    sed -i 's/requiretty/!requiretty/g' /etc/sudoers

# Optional - download and install oh-my-zsh
ADD https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh /home/user/
RUN chown user:users /home/user/install.sh && \
    chmod 755 /home/user/install.sh

USER user
ENV HOME=/home/user
RUN /home/user/install.sh && \
    ln -s /usr/share/vim/vimfiles/ /home/user/.vim
COPY .vimrc /home/user

WORKDIR /projects
CMD tail -f /dev/null
