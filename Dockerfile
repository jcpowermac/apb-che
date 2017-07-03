FROM fedora

EXPOSE 4403 8080 8000 22
ENV REQUIRED_PKGS="bzip2 sudo git procps unzip python-pip ansible wget curl docker java-1.8.0-openjdk origin-clients" \
    OPTIONAL_PKGS="zsh vim openssh-server nmap nodejs vim-jedi vim-minimal vim-powerline vim-pysmell vim-syntastic vim-syntastic-python" \
    PIP_PKGS="pip setuptools openshift"
                  
RUN dnf --setopt=deltarpm=false upgrade -y && \
    dnf install -y ${REQUIRED_PKGS} ${OPTIONAL_PKGS} && \
    dnf clean all

RUN pip install -U ${PIP_PKGS} 

RUN git clone https://github.com/fusor/ansible-playbook-bundle.git /tmp/apb && \
    cd /tmp/apb && \
    pip install -r src/requirements.txt && \
    python setup.py install && \
    cd / && \
    rm -rf /tmp/apb

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
