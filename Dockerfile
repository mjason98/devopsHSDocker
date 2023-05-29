from ubuntu

run apt-get update
run apt-get install -y python3 python3-pip
run pip install Flask

copy web.py /web.py

cmd ["python3 /web.py"]