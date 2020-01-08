#!/bin/bash

echo "Этот скрипт делает конспект более интересным для чтения."
echo "Но он сильно меняет исходники."
echo "НЕ КОММИТЬТЕ после применения этого скрипта к репозиторию!"

while :; do
	echo -n "Продолжить? [Y/N] "
	read -r OUTCOME
	case "$OUTCOME" in
		Y|y|Д|д)
			break
		;;
		N|n|Н|н)
			echo "Останов."
			exit 0
		;;
	esac
done

shopt -s globstar

sed -i -E 's/% add new headers if necessary/\\textit{Конспект был улучшен с применением} \\texttt{antibulatov.sh}./g' tex/title.tex

sed -i -E '
s/([Уу])быв/\1бив/g
s/конечн/кончен/g
s/конечен/кончен/g
s/ескончен/есконечн/g
s/([Фф])ункци/\1укнци/g
s/([Дд])ифференц/\1езинфиц/g
s/([Чч])астн/\1аст/g
s/([Пп])риращ/\1ревращ/g
s/\bпредел/беспредел/g
s/\bПредел/Беспредел/g
s/([Сс])меша[н]+/\1мешн/g
s/([Пп])роизводн/\1роизводственн/g
s/([Яя])вн/\1вственн/g
s/([Ээ])кстремум/\1кстремизм/g
s/([Мм])инимум/\1инимализм/g
s/([Мм])аксимум/\1аксимализм/g
s/епрерывност/епрекращаемост/g
s/епрерывны([а-я]+)\b/епрекращающи\1ся/g
s/епрерывно([а-я]+)\b/епрекращающе\1ся/g
s/епрерывна([а-я]+)\b/епрекращающа\1ся/g
s/епрерывну([а-я]+)\b/епрекращающу\1ся/g
s/епрерывн([оаы])\b/епрекращаем\1/g
s/([Сс])оответствующ/\1оответсвующ/g
s/([Гг])ладк/\1адк/g
s/([Пп])ризнак/\1ризрак/g
s/([Сс])тепенн/\1тепн/g
s/([Пп])о Коши/\1о кошке/g
s/Коши/кошки/g
s/кошки-([А-Я])/кошки \1/g
s/\bмал/крохотн/g
s/\bбольш/громадн/g
s/\bгромадни([йхем])/громадны\1/g
s/громаднинство/большинство/g
s/\b([Сс])ходи/\1бегае/g
s/\b([Сс])ходя/\1бегаю/g
s/\b([Рр])асходи/\1азбегае/g
s/\b([Рр])асходя/\1азбегаю/g
s/интегральн/интернациональн/g
s/[Ии]нтеграл/Интернационал/g
s/([Ии])нтегрир/\1нтернационализир/g
s/([Кк])омпакт/\1омпот/g
s/([Кк])асат/\1усат/g
s/([Сс])вязн/\1вязан/g
s/([Оо])ткрыт/\1пенсорсн/g
s/([Дд])искриминант/\1искриминатор/g
s/([Кк])вадрир/\1адрир/g
s/([Сс])(жат[а-я]+)/\1\2 архиватором/g
s/([Аа])налитич/\1политич/g
s/([Пп])одстанов/\1одстав/g
' **/*.tex

sed -i -E 's/\{mes\}/{mr}/g' matanhelper.sty

echo "Building PDF..."
make build
make clean
