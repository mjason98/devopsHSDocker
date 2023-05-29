from ubuntu

run apt update
run apt install python3 python3-pip
run pip install Flask

copy web.py /web.py

cmd ["python /web.py"]