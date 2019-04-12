

  $ rails s -b 0.0.0.0
  $ docker run -p 8089:8089 --rm --name locust -v $PWD:/locust gunesmes/docker-locust \
    -f /locust/run_0.py --host=http://10.0.1.7:3000
  
  open http://localhost:8089

