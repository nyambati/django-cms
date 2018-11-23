apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: {{ PROJECT_NAME }}
  namespace: {{ NAMESPACE }}
spec:
  selector:
    matchLabels:
      app: postgres
  serviceName: {{ PROJECT_NAME }}-{{ NAMESPACE }}-postgres
  replicas: 3
  template:
    metadata:
      labels:
        app: postgres
    spec:
      containers:
        - name: postgres
          image: postgres:9.6-alpine
          imagePullPolicy: Always
          ports:
            - name: postgres
              containerPort: 5432
          volumeMounts:
            - name: postgres-database-volume
              mountPath: /data
  volumeClaimTemplates:
  - metadata:
      name: postgres-database-volume
    spec:
      accessModes:
        - ReadWriteOnce
      resources:
        requests:
          storage: 1Gi
