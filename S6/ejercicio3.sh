myFor(){
	return
}

myWhile(){
	return
}

myUntil(){
	return
}

myExit(){
	exit 0;
}

main(){
	select ORD in 'for' 'while' 'until' 'exit'
	do
		case $ORD in
			'for')
				myFor $@
				break
			;;
			'while')
				myWhile $@
				break
			;;
			'until')
				myUntil $@
				break
			;;
			'exit')
				myExit
			;;
		esac
	done
	while [ $# -gt 0 ];
	do
		echo $1
		shift
	done
}
if [ $# -lt 1 ]; then
	echo "[ERROR]	Mínimo un argumentos";
else
	while [ 1 ]
	do
		main $@
	done;
fi
