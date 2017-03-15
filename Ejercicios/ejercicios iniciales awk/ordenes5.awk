NR == 2{
	min["size"]=$5;
        min["name"]=$9;
	max["size"]=$5;
        max["name"]=$9;
}
$5<min["size"]{
	min["size"]=$5;
	min["name"]=$9;
}
$5 > max["size"]{
	max["size"]=$5; 
	max["name"]=$9;
}
END{
	print "Max: "max["name"];
	print "Min: "min["name"];
	print "Entradas: "NR-1
}
