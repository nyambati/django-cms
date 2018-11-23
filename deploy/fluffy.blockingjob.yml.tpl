apiVersion: batch/v1
kind: Job
metadata:
  name: {{ PROJECT_NAME }}
  namespace: {{ NAMESPACE }}
spec:
  template:
    metadata:
      name: {{ PROJECT_NAME }}
    spec:
      containers:
        - name: run-migrations
          image: "{{ CONTAINER_REGISTRY }}/{{ PROJECT_NAME }}:{{ IMAGE_TAG }}"
          command:
          - python
          - manage.py
          - migrate
      restartPolicy: Never
