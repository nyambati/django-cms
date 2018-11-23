apiVersion: autoscaling/v1
kind: HorizontalPodAutoscaler
metadata:
  name: {{ PROJECT_NAME }}
  namespace: {{ NAMESPACE }}
spec:
  minReplicas: 2
  maxReplicas: 10
  scaleTargetRef:
    apiVersion: extensions/v1beta1
    kind: Deployment
    name: {{ PROJECT_NAME }}
  targetCPUUtilizationPercentage: 70
