function ejecutar_built_in()
{	
	PATH_BUILTS=/home/utnso/TP1---SHIELD---SO/built-in/
	
	SEPARACION=`expr index "$1" " "`
	
	if [ $SEPARACION -eq 0 ];then
		BUILT_IN=$1
	else		
		BUILT_IN=`echo ${1:0:$SEPARACION}`
		PARAMETRO=`echo ${1:$SEPARACION}`
	fi
	
	bash /home/utnso/TP1---SHIELD---SO/built-in/$BUILT_IN.sh $PARAMETRO

	return 0
}
