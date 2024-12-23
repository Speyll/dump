import obsws_python as obs
cl = obs.ReqClient(host='localhost', port=4455, password="ErsA4hEFB1VXil6V", timeout=3)
cl.save_replay_buffer()
