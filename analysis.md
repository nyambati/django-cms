# Fluffy Infrastructure Analysis

## Infrastructure Overview

The current kubernetes cluster comprises of the following objects.

- Deployment
- Stateful Sets
- Services
- Ingress
- Secrets
- ConfigMaps

## High Availability and Scaling

With the current setup, we have only been able to take care of pod scaling within our cluster. This is achieved via Horizontal Pod auto-scaler object. This approach enables us to manage the number of pods we can have in our cluster based on CPU usage and traffic. This approach makes our cluster elastic and dynamic in that its able to increase or reduce the number of pods without external interference.

HPA works within the limits of resources provided by the cluster. This means that it will not be able to scale pods beyond what the available nodes can handle. This can be fixed by adding more nodes or by increasing node capacity. Most cloud provides like GCP and AWS already have established autoscaling services that can be utilized to automate this process. In combination with HPA, we can be able to implement a cluster that scales both ends.

When it comes to persistence it is important to ensure that system data is secure and well stored. The current infrastructure uses StatefulSets to manage our application database. This might be a good idea for staging or QA environment. For production deployments, this might increase the complexities of cluster management and risks of losing crucial data. A well-designed database infrastructure will include read replica capability, fault-tolerance, failover, and automated data backups etc. Implementing these capabilities may be expensive it times of time and risk and therefore managed services such as GCP CloudSQL and AWS RDS are recommended for production deployments.

## Templating

This current implementation uses a custom bash script templating system. As much as it works for the current deployment, its not a scalable option. The increase of variables will increase boilerplate for our scripts which will become bloated. For this reason, helm would be a preferable option. Helm will enable us to define our application and dependencies as charts making it portable across namespaces and clusters.

## Monitoring and logging
Monitoring is important when it comes to building a highly available system. This enables us to constantly monitor our systems, gather metrics that we can use to make changes to infrastructure or make critical patches when necessary. Below are some of the tools that should be considered.
- Infrastructure/Application monitoring: Monitor both cluster and application performance. With this metrics, we can make informed changes to both the application and infrastructure
- Application error monitoring: Monitors production application errors. With integration with slack, email or any other supported platform, we can get real-time notifications when errors occur.
- Centralized Logging: All application and server logs will be collected and analyzed from one dashboard. This makes it easier to review and analyze logs as compared to checking individual server logs.

## Known Issues

The current implementation uses StatefulSet to deploy our Postgres database. When the replicas are scaled to 2+, each replica seems to use individual volume instead of sharing one volume. This translates to a scenario where we don't have eventual consistency. This could be an isolated issue within minikube, however, it should be expected on cloud-based clusters as well.
