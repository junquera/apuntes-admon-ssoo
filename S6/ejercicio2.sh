if [ $# -lt 1 ]; then
	echo "[ERROR]	Mínimo un argumentos";
else
	select ORD in 'for' 'while' 'until' 'exit'
	do
		case $ORD in
			'for')
				break
			;;
			'while')
				break
			;;
			'until')
				break
			;;
			'exit')
			;;
		esac
	done
	while [ $# -gt 0 ];
	do
		echo $1
		shift
	done
fi
