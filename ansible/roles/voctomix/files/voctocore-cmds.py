#!/usr/bin/env python3

# put Voctocore in production mode:
# grabber/cam pnp

# Credits to voctomix example scripts

import socket
import sys

host = 'localhost'
port = 9999

sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
sock.setsockopt(socket.SOL_SOCKET, socket.SO_KEEPALIVE, 1)

try:
    sock.connect((host, port))
    sock.settimeout(2)
except ConnectionRefusedError:
    sys.exit('Voctocore is not running. Exiting')

def vocto_write(file_object, command: str):
    """Write commands to the voctocore control server

    file_object: socket file object
    command: voctocore command server command
    """
    file_object.write(command + '\n')
    file_object.flush()

try:
    fd = sock.makefile('w')

    vocto_write(fd, 'set_video_a Grabber')
    vocto_write(fd, 'set_composite_mode picture_in_picture')

    print('voctomix set to record talks')

    sys.exit()
except socket.timeout as err:
    sys.exit('there was a problem while asking voctocore to display '
             'the loop. please retry or put voctomix on loop manually')
