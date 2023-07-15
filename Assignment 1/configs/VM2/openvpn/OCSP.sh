#!/bin/bash

if [ "$1" -ne 0 ]
then
	exit_code=0
	
else
	if [ -n "${tls_serial_0}" ]
	then
		cmd=$(openssl ocsp -issuer /etc/openvpn/ca.crt -CAfile /etc/openvpn/ca.crt -url http://ocsp.sti.pt:81 -serial "${tls_serial_0}")
		if [ $? -eq 0 ]
		then
			if echo "$cmd" | grep -Fq "${tls_serial_0}: good"
			then
				exit_code=0
				
			else
				exit_code=1
			fi
			
		else
			exit_code=1
		fi
		
	else
		exit_code=1
	fi
fi

exit "$exit_code"

