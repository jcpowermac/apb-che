FROM quay.io/jcallen/che-fedora-base

EXPOSE 8080 8000 9191
ENV REQUIRED_PKGS="bzip2 procps python-pip ansible docker origin-clients dnf-plugins-core" \
    OPTIONAL_PKGS="python-psycopg2 ara zsh vim vim-jedi vim-powerline vim-pysmell vim-syntastic vim-syntastic-python"

USER root
RUN dnf install -y ${REQUIRED_PKGS} ${OPTIONAL_PKGS} && \
    dnf clean all && \
    rm -rf /var/lib/rpm/__db.00*

# Install Ansible Service Broker and Ansible Playbook Bundle tools
RUN dnf -y copr enable @ansible-service-broker/ansible-service-broker-latest && \
    dnf -y install apb ansible-asb-modules ansible-kubernetes-modules

# Install Service Catalog CLI
RUN curl --url https://download.svcat.sh/cli/latest/linux/amd64/svcat --output /usr/local/bin/svcat && \
    chmod +x /usr/local/bin/svcat

# Optional - download and install oh-my-zsh
ADD https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh /home/user/
RUN chown user:users /home/user/install.sh && \
    chmod 755 /home/user/install.sh

USER user

RUN /home/user/install.sh >/dev/null 2>&1 && \
    ln -s /usr/share/vim/vimfiles/ /home/user/.vim
COPY .vimrc /home/user
