if [ $# -lt 2 ]; then
	echo "[ERROR]	Mínimo dos argumentos";
else
	case $1 in 
		'for');; 
		'while');; 
		'until');;
		*)
			echo "[ERROR]	El primer argumento debe ser for, while o until"
			exit -1 
		;;
	esac
	
	shift	
	while [ $# -gt 0 ];
	do
		echo $1
		shift
	done
fi
