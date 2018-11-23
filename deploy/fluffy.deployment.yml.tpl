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
      initContainers:
        - name: collect-static-files
          image: "{{ CONTAINER_REGISTRY }}/{{ PROJECT_NAME }}:{{ IMAGE_TAG }}"
          command:
            - python
            - manage.py
            - collectstatic
            - --no-input
      containers:
        - name: app
          image: "{{ CONTAINER_REGISTRY }}/{{ PROJECT_NAME }}:{{ IMAGE_TAG }}"
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
            tcpSocket:
              port: http
            periodSeconds: 10
            timeoutSeconds: 10
            successThreshold: 1
            failureThreshold: 10
          livenessProbe:
            tcpSocket:
              port: http
            initialDelaySeconds: 10
