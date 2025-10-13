# simple echo program
echo "Hello, World!"
echo "This is a simple echo script."

# variabnles

name="solomon"
age=200
echo "My name is $name and I am $age years old."

# command substitution
current_date=$(date)
current_time=$(date +"%T")
current_day=$(date +"%A")
echo "Today is $current_day"
echo "Current time is $current_time"
echo "Today's date is $current_date"

# user input

read -p "Enter yoiur favourite anime: " anime
read -p "entre your favourite character in $anime: " character
echo "Your favourite anime is $anime and your favourite character is $character"

# arithmetic operations
num1=10
num2=20
sum=$((num1 + num2))
diff=$((num2 - num1))
prod=$((num1 * num2))
quot=$((num2 / num1))

echo "Sum: $sum"
echo "Difference: $diff"
echo "Product: $prod"
echo "Quotient: $quot"

# conditional statements greater than
if [ $age -gt 18 ]; then
    echo "You are an adult."
else
    echo "You are a minor."
fi

# conditional statements string comparison
if [ "$anime" == "Naruto" ]; then
    echo "Naruto is a great anime!"
else
    echo "$anime is also a good anime."
fi

# conditional statements with elif
if ["age" -lt 18 ]; then
    echo "You are a minor."
elif [ "$age" -ge 18 ] && [ "$age" -lt 65 ]; then
    echo "You are an adult."
else
    echo "You are a senior citizen."
fi

# loops
echo "Counting from 1 to 5:"
for i in {1..5}; do
    echo "$i"
done

echo "Counting down from 5 to 1:"
for ((i=5; i>=1; i--)); do
    echo "$i"
done

echo "Counting even numbers from 2 to 10:"
for ((i=2; i<=10; i+=2)); do
    echo "$i"
done

echo "Counting odd numbers from 1 to 9:"
for ((i=1; i<10; i+=2)); do
    echo "$i"
done
# while loop
count=1
while [ $count -le 5 ]; do
    echo "Count: $count"
    ((count++))
done
# functions
greet() {
    echo "Hello, $1! Welcome to the bash scripting world."
}
greet "solomon"
# arrays
fruits=("apple" "banana" "cherry" "date")
echo "First fruit: ${fruits[0]}"
echo "All fruits: ${fruits[@]}"
echo "Number of fruits: ${#fruits[@]}"
# associative arrays
declare -A capitals
capitals=( ["USA"]="Washington, D.C." ["France"]="Paris" ["Japan"]="Tokyo" )
echo "Capital of USA: ${capitals["USA"]}"
echo "Capital of France: ${capitals["France"]}"
echo "Capital of Japan: ${capitals["Japan"]}"
# file operations
file="sample.txt"
echo "Creating a file named $file"
echo "This is a sample file." > $file
echo "Appending more text to $file"
echo "This is an appended line." >> $file
echo "Displaying the contents of $file:"
cat $file
echo "Deleting the file $file"
rm $file
echo "$file deleted."
# end of script
echo "Script execution completed."


