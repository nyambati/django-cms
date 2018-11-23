# Configuration for https://github.com/reactiveops/rok8s-scripts

# Dockerfile to build
DOCKERFILE='docker/release/Dockerfile'

# External registry domain
EXTERNAL_REGISTRY_BASE_DOMAIN=thomasnyambati

# Name of repository/project
REPOSITORY_NAME={{ PROJECT_NAME }}

# Docker tag that will be created
# Defaults to concatenation of your external registry + repository name, i.e.:
# DOCKERTAG=quay.io/example-org/example-app
DOCKERTAG="$EXTERNAL_REGISTRY_BASE_DOMAIN/$REPOSITORY_NAME"

# Namespace to work in
NAMESPACE={{ NAMESPACE }}

# List of files ending in '.configmap.yml' in the kube directory
CONFIGMAPS=('fluffy')

# List of files ending in '.service_account.yml' in the kube directory
SERVICE_ACCOUNTS=()

# List of files ending in '.secret.yml' in the kube directory
SECRETS=('fluffy')

# List of secrets to pull from S3
S3_SECRETS=()

# List of files ending in '.persistent_volume.yml' in the kube directory
PERSISTENT_VOLUMES=()

# List of files ending in '.persistent_volume_claim.yml' in the kube directory
PERSISTENT_VOLUME_CLAIMS=()

# List of files ending in '.statefulset.yml' in the kube directory
STATEFULSETS=('fluffy')

# List of files ending in '.service.yml' in the kube directory
SERVICES=('fluffy' 'fluffy-database')

# List of files ending in '.endpoint.yml' in the kube directory
ENDPOINTS=()

# List of ingress resource files ending in '.ingress.yml' in the kube directory
INGRESSES=('fluffy')

# List of files ending in '.deployment.yml' in the kube directory
DEPLOYMENTS=('fluffy')

# List of files ending in '.horizontal_pod_autoscaler.yml' in the kube directory
HORIZONTAL_POD_AUTOSCALERS=('fluffy')

# List of files ending in '.job.yml' in the kube directory
JOBS=()

# List of files ending in '.blockingjob.yml' in the kube directory
BLOCKING_JOBS=('fluffy')

# List of files ending in '.cronjob.yml' in the kube directory
CRONJOBS=()
