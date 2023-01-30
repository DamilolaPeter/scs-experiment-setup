# SCS experiment setup

A setup guide to run the [scs_predictive_analysis](https://github.com/AllisonOge/scs_predictive_analysis) project.

## Quick Start
This setup can be ran in github codespaces or on your local machine.

### GitHub Codespaces
- start a codespace

### Local Machine
The requirement for this setup is Docker so be sure to install it from the official [site](https://docs.docker.com/engine/install/) before proceeding with the next steps.

- clone this repository
- build the dockerfile: if using linux or MacOS use the following command
```bash
docker build --network=host -t scs-experiment-setup .
```
- run a container: if using linux or MacOS use the following command
```bash
docker run -dit --net=host --expose 2222 --privileged scs-experiment-setup:latest
```
Then ssh to the container using the command `ssh -Xp 2222 root@localhost`

**The docker image used in the dockerfile is large and so the build may take some time. Be patient!**

----
With the previous steps done, run the python script `get_experiment_results.py` to produce results for the experiment and commit the changes (generated CSV file).