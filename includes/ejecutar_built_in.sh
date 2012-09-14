function ejecutar_built_in()
{	
	SEPARACION=`expr index "$1" " "`
	
	if [ $SEPARACION -eq 0 ];then
		BUILT_IN=$1
	else		
		BUILT_IN=`echo ${1:0:$SEPARACION}`
		PARAMETRO=`echo ${1:$SEPARACION}`
	fi
	
	bash $PATH_BUILTS$BUILT_IN.sh $PARAMETRO
	
	#Para que el proximo built-in se ejecute bien
	PARAMETRO=""


	return 0
}
