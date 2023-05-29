from ubuntu

run "apt-get update && apt-get install -y pip python"
run "pip install Flask"

copy web.py /web.py

cmd ["python /web.py"]