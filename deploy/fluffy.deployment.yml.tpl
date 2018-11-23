apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: {{ PROJECT_NAME }}
  namespace: {{ NAMESPACE }}
spec:
  minReadySeconds: 15
  revisionHistoryLimit: 3
  template:
    metadata:
      labels:
        app: {{ PROJECT_NAME }}
    spec:
      containers:
        - name: app
          image: thomasnyambati/{{ PROJECT_NAME }}:{{ IMAGE_TAG }}
          imagePullPolicy: Always
          command:
            - gunicorn
            - fluffy.wsgi
            - -w 2
            - -b :{{ PORT }}
          ports:
          - containerPort: {{ PORT }}
            name: http
          readinessProbe:
            httpGet:
              path: /_healthz
              port: http
            periodSeconds: 10
            timeoutSeconds: 10
            successThreshold: 1
            failureThreshold: 10
          livenessProbe:
            httpGet:
              path: /_healthz
              port: http
            initialDelaySeconds: 10
        - name: proxy
          image: thomasnyambati/fluffy-proxy
          ports:
            - containerPort: 80
              name: proxy
