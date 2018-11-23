apiVersion: v1
kind: Secret
metadata:
  name: {{ PROJECT_NAME }}-env-secrets
  namespace: {{ NAMESPACE }}
type: Opaque
data:
  POSTGRES_PASSWORD: {{ POSTGRES_PASSWORD }}
