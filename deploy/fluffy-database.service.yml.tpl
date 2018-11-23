
apiVersion: v1
kind: Service
metadata:
  name: {{ PROJECT_NAME }}-database
  namespace: {{ NAMESPACE }}
  labels:
    app: database
spec:
  ports:
  - port: 5432
    name: postgres
  clusterIP: None
  selector:
    app: database
