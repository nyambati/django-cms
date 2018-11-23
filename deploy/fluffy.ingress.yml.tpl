apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: {{ PROJECT_NAME }}
  namespace: {{ NAMESPACE }}
  labels:
    app: {{ PROJECT_NAME }}
  annotations:
    kubernetes.io/ingress.class: "nginx"
spec:
  backend:
    serviceName: {{ PROJECT_NAME }}
    servicePort: http
