### Eclipse Che stack for Ansible Playbook Bundle

Provides an easy way to get started with APBs without having to install any software
except Docker.


#### Install

1. To allow the workspace access to the host's docker instance and add GitHub OAuth modify `data/che.env`.  See https://eclipse.org/che/docs/ide/git-svn/#github-oauth for more information.

    ```
    CHE_HOST=<ip_address>
    CHE_SINGLE_PORT=false

    # Optional, but required if running `docker build` within workspace
    CHE_WORKSPACE_VOLUME=/var/run/docker.sock:/var/run/docker.sock:rw,Z;

    # Optional, but easier to manage 
    CHE_OAUTH_GITHUB_CLIENTID=
    CHE_OAUTH_GITHUB_CLIENTSECRET=
    CHE_OAUTH_GITHUB_AUTHURI= https://github.com/login/oauth/authorize
    CHE_OAUTH_GITHUB_TOKENURI= https://github.com/login/oauth/access_token
    CHE_OAUTH_GITHUB_REDIRECTURIS=http://${CHE_HOST}:${SERVER_PORT}/wsmaster/api/oauth/callback
    ```

2. Start Che

3. Add the stack to Che via the API.

    ```
    # httpie
    http http://localhost:8080/wsmaster/api/stack < stack.json

    # curl
    curl -X POST --header 'Content-Type: application/json' --header 'Accept: application/json' -d @stack.json http://localhost:8080/wsmaster/api/stack
    ```


