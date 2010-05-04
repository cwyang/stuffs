# Web client 
import socket
sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
sock.connect(('192.168.100.109', 80))
data = """GET /~cwyang/php/exit.php HTTP/1.1
Host: ns.aratech.co.kr
Connection: close

"""
for line in data.splitlines():
    sock.sendall("%s\r\n"%line)
response = sock.recv(8192)
print response
sock.close()
