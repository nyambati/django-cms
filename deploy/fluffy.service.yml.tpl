
apiVersion: v1
kind: Service
metadata:
  name: {{ PROJECT_NAME }}
  namespace: {{ NAMESPACE }}
  labels:
    app: {{ PROJECT_NAME }}
spec:
  type: NodePort
  ports:
    - port: 80
      targetPort: http
      protocol: TCP
      name: http
  selector:
    app: {{ PROJECT_NAME }}
