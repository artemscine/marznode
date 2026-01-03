FROM tobyxdd/hysteria:v2 AS hysteria-image
FROM jklolixxs/sing-box:latest AS sing-box-image
FROM ghcr.io/xtls/xray-core:latest AS xray-image

FROM python:3.12-alpine

ENV PYTHONUNBUFFERED=1

COPY --from=hysteria-image /usr/local/bin/hysteria /usr/local/bin/hysteria
COPY --from=sing-box-image /usr/local/bin/sing-box /usr/local/bin/sing-box
COPY --from=xray-image /usr/local/bin/xray /usr/local/bin/xray

WORKDIR /app

COPY . .

RUN apk add --no-cache alpine-sdk libffi-dev && pip install --no-cache-dir -r /app/requirements.txt && apk del -r alpine-sdk libffi-dev

CMD ["python3", "marznode.py"]
