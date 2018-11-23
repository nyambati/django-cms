
apiVersion: v1
kind: Service
metadata:
  name: {{ PROJECT_NAME }}-{{ NAMESPACE }}-postgres
  namespace: {{ NAMESPACE }}
  labels:
    app: postgres
spec:
  ports:
  - port: 5432
    name: postgres
  clusterIP: None
  selector:
    app: postgres
