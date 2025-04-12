#!/bin/bash
sonar-scanner \
  -Dsonar.projectKey=portfolio \
  -Dsonar.sources=. \
  -Dsonar.host.url=http://192.168.56.11:9000 \
  -Dsonar.login=your-sonar-token