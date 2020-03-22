# Demo for Github Actions

A demo to show a server CI/CD flow with Github Actions.

The actions will run a container on Google Cloud Run every time a push happens.  

https://itnext.io/github-actions-ship-code-to-gcp-cloud-run-8d607f34e1cd

Flow:
- create an IAM that covers necessary Google services according to that article
- export all the required secrets to Github's project settings
- prepare .github/workflows/cloud-run.xml with steps that include Build and Deploy
- create Dockerfile
    - sbt project like Scala needs to be built as fat jars with `sbt assembly`, otherwise [server will not be ready by the time health check hits](https://stackoverflow.com/questions/55662222/container-failed-to-start-failed-to-start-and-then-listen-on-the-port-defined-b)
- push the project

    