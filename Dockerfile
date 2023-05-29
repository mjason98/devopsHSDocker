from ubuntu

WORKDIR /app

run apt-get update
run apt-get install -y python3 python3-pip

copy requirements.txt .
copy app.py .

run pip3 install -r requirements.txt

cmd ["python3", "-m", "gunicorn", "--bind", "0.0.0.0:4444", "app:app"]