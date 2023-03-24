#!/bin/bash
CURRENT_DEPTH=0
function tab_generator() {
	local COUNTER=0
	local TAB=" "
	local DEPTH=$1 # уровень глубины
	local LETTER=" " # отступ 
	while [ $COUNTER -lt $DEPTH ] # пока счетчик не равен уровню глубины. -lt означает меньше
	do # генерация оступов 
		LETTER="${LETTER}${TAB}" # увеличение отступа
		COUNTER=$(( $COUNTER + 1 )) #увеличение счетчика на 1
	done
	echo -en "$LETTER" # не выводит перевод строки и включает поддержку вывода Escape последовательностей
}

function printTree() {
	local HOME=$1
	for ELEM in ${HOME}/*
	do
		if [ -d $ELEM ] # Проверка является ли элемент папки директорией
		then
			TABULATION=$(tab_generator $CURRENT_DEPTH)
			printf "%s%s\n" "$TABULATION" "$ELEM"
			CURRENT_DEPTH=$(( CURRENT_DEPTH + 1))
			printTree $ELEM $CURRENT_DEPTH
			CURRENT_DEPTH=$(( CURRENT_DEPTH - 1 ))
		elif [ -f $ELEM ] # Проверка является ли элемент файлом
		then
			TABULATION=$(tab_generator $CURRENT_DEPTH)
			printf "%s%s\n" "$TABULATION" "$ELEM"
		elif [ -l $ELEM ] # Проверка является ли элемент ссылкой
		then
			TABULATION=$(tab_generator $CURRENT_DEPTH)
			printf "%s%s\n" "$TABULATION" "$ELEM"
		fi
	done
}

HOME_DIRECTORY=$1
if [ -z $1 ]
then
	HOME_DIRECTORY=$PWD
fi
echo $1
printTree $HOME_DIRECTORY 1
