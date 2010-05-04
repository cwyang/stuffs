# Web client, immediate close after sending request
import socket
sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
sock.connect(('192.168.100.109', 80))
data = """GET / HTTP/1.1
Host: www.aratech.co.kr
Connection: close

"""
for line in data.splitlines():
    sock.sendall("%s\r\n"%line)
sock.close()
