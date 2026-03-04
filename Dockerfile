FROM python:3.12-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg libass9 fontconfig libfreetype6 \
    && rm -rf /var/lib/apt/lists/*

COPY fonts /usr/share/fonts/custom
RUN fc-cache -f -v

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000", "--workers", "2", "--timeout-keep-alive", "600"]

