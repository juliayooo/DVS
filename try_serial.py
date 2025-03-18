from serial	import Serial
import datetime

serial_port	= "/dev/cu.usbmodem101"
arduino	=	Serial(serial_port,	baudrate=115200,	timeout=0.1)

while True:
				line_bytes	=	arduino.readline()
				timeNow = datetime.datetime.now()
				line_string	=	(line_bytes.decode('ascii').strip()
									 + " at " + str(timeNow)
									 )
				print(line_string)