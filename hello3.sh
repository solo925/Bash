# declare variable canbe used with other options such as
# declare -r name='onyango'  # this will make the variable read only and cannot be changed
# declae -i num=10  # this will make the variable an integer and can only hold integer values
# declare -a arr=(1 2 3 4 5) # this will make the variable an array and can hold multiple values
# declare -A dict=([key1]=value1 [key2]=value2) # this will make the variable an associative array and can hold key-value pairs
# declare -x name='onyango' # this will make the variable an environment variable and can be accessed by other programs
# declare -l name='onyango' # this will make the variable lowercase and any value assigned to it will be converted to lowercase
# declare -u name='onyango' # this will make the variable uppercase and any value assigned to it will be converted to uppercase
# declare -p name # this will print the value of the variable name
# declare -f function_name # this will print the definition of the function function_named
declare name='onyango'
echo "hello mr ${name}"
name2='solomon'

echo "hello there ${name2}"

echo "my current directory is $(pwd)"

echo "and the current contents in my directory are $(ls) "
