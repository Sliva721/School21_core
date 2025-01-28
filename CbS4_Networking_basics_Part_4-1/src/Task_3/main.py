from scapy.all import *

# Message
message = b'Dear Steel Cat! This is no attack, it\'s my humster Pinkie you should track'

# Create TCP/IP packet
packet = IP(dst='127.0.0.1')/TCP(dport=12345, sport=RandShort())/Raw(load=message)

# send
send(packet)