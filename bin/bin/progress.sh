#! /bin/sh
# Display a simple progressbar
#
# Arguments:
#	$1: current value
#	$2: maximum value
#	$3: character width of the bar
value=${1}
max_value=${2:-100}
width=${3:-10}

if [[ ! -n ${value} ]]
then
	echo "Please enter a value!"
	exit 1
fi

cut=$(printf "%.0f" $(echo "${value} * ${width} / ${max_value}" | bc -l))

for i in $(seq 1 ${width})
do
	[[ ${i} -le ${cut} ]] && printf "━" || printf "─"
done
