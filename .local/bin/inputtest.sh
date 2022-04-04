#echo "enter your names"
read -p "enter your names>" name1 name2  name3
echo "your names are" $name1 $name2 $name3
# with arrrays
echo "enter your names"
read -as  names
echo "your names are ${names[@]}"
echo "first and last name  are ${names[0]} and ${names[2]}."
