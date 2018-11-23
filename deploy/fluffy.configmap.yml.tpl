apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ PROJECT_NAME }}-config
  namespace: {{ NAMESPACE }}
data:
  POSTGRES_USER: fluffy
  POSTGRES_DB: fluffy
