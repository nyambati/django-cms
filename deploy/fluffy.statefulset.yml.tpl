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
  replicas: 1
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
          envFrom:
            - configMapRef:
                name: {{ PROJECT_NAME }}-config
            - secretRef:
                name: {{ PROJECT_NAME }}-env-secrets
          env:
            - name: POSTGRES_USER
              value: fluffy
            - name: POSTGRES_DB
              value: fluffy
          volumeMounts:
            - name: postgres-database-volume
              mountPath: /var/lib/postgresql/data
  volumeClaimTemplates:
  - metadata:
      name: postgres-database-volume
    spec:
      accessModes:
        - ReadWriteOnce
      resources:
        requests:
          storage: 1Gi
