
function es_un_built_in
{	
	SEPARACION=`expr index "$1" " "`
	
	if [ $SEPARACION -eq 0 ];then
		BUILT_IN=$1
	else		
		BUILT_IN=`echo ${1:0:$SEPARACION}`
	fi
	if ( test -r $BUILT_IN_LIST );then
		for built in `cat $BUILT_IN_LIST`
		do	
		
	  		if [ "$BUILT_IN" == $built ];then
			  return 0		
	  		fi
		done	
		return 1
	else
		echo "No existe el archivo $BUILT_IN_LIST"
		return 1
	fi
}
