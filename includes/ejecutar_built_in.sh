function ejecutar_built_in()
{	
	SEPARACION=`expr index "$1" " "`
	
	if [ $SEPARACION -eq 0 ];then
		BUILT_IN=$1
	else		
		BUILT_IN=`echo ${1:0:$SEPARACION}`
		local PARAMETRO=`echo ${1:$SEPARACION}`
	fi
	
	if ( test -e $PATH_BUILTS$BUILT_IN.sh );then
		bash $PATH_BUILTS$BUILT_IN.sh $PARAMETRO
	else
		echo "No existe el archivo $PATH_BUILTS$BUILT_IN.sh"
		return 1
	fi
	
	return 0
}
