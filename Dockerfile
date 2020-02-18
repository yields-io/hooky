FROM python:3.7-slim

EXPOSE 3000

COPY requirements.txt /

# RUN apt-get update && \
#     apt-get install -y \
#         gcc \
#         g++

RUN python3 -m pip install -r requirements.txt

WORKDIR /src
COPY app.py .
# ENTRYPOINT ["gunicorn", "app:app", "--bind=0.0.0.0:3000", "--workers=4", "--log-level=debug", "--reload"]
ENTRYPOINT ["python3"]
CMD ["app.py"]
