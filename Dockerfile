FROM fedora

EXPOSE 4403 8080 8000 22
RUN dnf --setopt=deltarpm=false upgrade -y && \
    dnf install -y nodejs bzip2 sudo git openssh-server procps \
                   unzip nmap python-pip ansible wget curl zsh docker \
                   java-1.8.0-openjdk origin-clients && \
    dnf clean all

RUN pip install -U pip && \
    pip install -U setuptools && \
    pip install -U openshift

RUN git clone https://github.com/fusor/ansible-playbook-bundle.git && \
    cd ansible-playbook-bundle && \
    pip install -r src/requirements.txt && \
    python setup.py install

RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config && \
    sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config && \
    echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    useradd -u 1000 -G users,wheel -d /home/user --shell /usr/bin/zsh -m user && \
    usermod -p "*" user && \
    sed -i 's/requiretty/!requiretty/g' /etc/sudoers

USER user
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

CMD tail -f /dev/null
