## Usage

First of all, update [the example project path in the compose file](./docker-compose.yml#L8) to point to *your* example WiFi project, so it gets mounted into the ns3 scratch directory.

In the repo directory, run:
`docker compose build` to build the image.

Once built, start a container and attach to it using: `docker compose run ns3`. This will drop you into an interactive shell in the container.

Alternatively use VS Code's [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) to get a VS Code client running in/attached to the container.

From here, run `./waf` to make sure it all builds correctly and builds the wifi example.