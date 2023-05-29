from ubuntu

WORKDIR /app

run apt-get update
run apt-get install -y python3 python3-pip

run pip install -r requirements.txt

copy web.py .

cmd ["python3", "web.py"]