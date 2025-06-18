### Multi-stage Dockerfile for ExoSuite ###
FROM python:3.11-slim AS builder
WORKDIR /app
COPY requirements.txt ./
RUN pip install --user -r requirements.txt

FROM python:3.11-slim
WORKDIR /app
COPY --from=builder /root/.local /root/.local
ENV PATH=/root/.local/bin:$PATH
COPY . .
CMD ["pytest", "--maxfail=1", "--disable-warnings", "-q"]
