### Eclipse Che stack for Ansible Playbook Bundle

Provides an easy way to get started with APBs without having to install any software
except Docker.


#### Install
1. Add the stack to Che via the API.

    ```
    # httpie
    http http://localhost:8080/wsmaster/api/stack < stack.json

    # curl
    curl -X POST --header 'Content-Type: application/json' --header 'Accept: application/json' -d @stack.json http://localhost:8080/wsmaster/api/stack
    ```

2. To allow the workspace access to the host's docker instance modify `instance/config/che.properties` to include
docker's socket.

    ```
    che.workspace.volume=/var/run/docker.sock:/var/run/docker.sock
    ```

3. Restart Che
