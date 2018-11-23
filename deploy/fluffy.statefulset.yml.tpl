apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: {{ PROJECT_NAME }}
  namespace: {{ NAMESPACE }}
spec:
  selector:
    matchLabels:
      app: database
  serviceName: {{ PROJECT_NAME }}-database
  replicas: 3
  template:
    metadata:
      labels:
        app: database
    spec:
      containers:
        - name: database
          image: postgres:9.6-alpine
          imagePullPolicy: Always
          ports:
            - name: postgres
              containerPort: 5432
          env:
            - name: POSTGRES_PASSWORD
              value: fluffy
            - name: POSTGRES_USER
              value: fluffy
            - name: POSTGRES_DB
              value: fluffy
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
