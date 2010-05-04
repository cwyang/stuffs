# Web server
import socket
sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
sock.bind(('',8887))
sock.listen(5)

try:
    while True:
        newSocket, address = sock.accept()
        print "Connected from", address
        while True:
            receivedData = newSocket.recv(8192)
            print receivedData
            break
#            newSocket.sendall('%d'%len(receivedData))
        newSocket.close()
        print "Disconnected from", address
finally:
    sock.close()
