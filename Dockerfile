from ubuntu

WORKDIR /app

run apt-get update
run apt-get install -y python3 python3-pip

copy requirements.txt .
copy web.py .

run pip3 install -r requirements.txt

cmd ["python3", "web.py"]