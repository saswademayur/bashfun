# Data store containing key and value pair
# input to a function a list of keys
# get the value from data store for given keys
# return map as follows:
#  {"foo1":"fooValue","foo2":"fooValue"}
echo "data store of sounds"
declare -A sounds
sounds[dog]="bark"
sounds[cow]="moo"
sounds[bird]="tweet"
sounds[wolf]="howl"
sounds[cat]="mew"
echo ${sounds[dog]} # Dog's sound
echo ${sounds[@]}   # All values
echo ${!sounds[@]}  # All keys
echo ${#sounds[@]}  # Number of elements
echo "blank data store to fill"
declare -A soundsToPrepare
echo "array of animals"
animals=('dog' 'cow' 'bird' 'wolf' 'cat')
echo ${animals[0]}           # Element #0
echo ${animals[-1]}          # Last element
echo ${animals[@]}           # All elements, space-separated
echo ${!animals[@]}          # Keys of all elements, space-separated
echo ${#animals[@]}          # Number of element
echo "sample function with no return value"
function samplefunc() {
    echo "hello from function $1"
}
echo "call to sample function with no return value"
samplefunc "to animals"
echo "sample function with return value"
function samplefuncWithReturn() {
    echo "hello from function $1"
    catSound=${sounds[cat]}
    echo "$catSound"
    soundsToPrepare[cat]="$catSound"
    echo ${soundsToPrepare[cat]}
    if [[ ${soundsToPrepare[cat]} == ${sounds[cat]} ]]; then
        return 0
    else
        return 1
    fi
}
echo "call to sample function with no return value"
if samplefuncWithReturn "to cat with a "; then
echo "success"
else
echo "failed"
fi
echo "sample function with return value try 1"
function samplefuncWithReturnTry1() {
    echo "hello from function $1"
    catSound=${sounds[cat]}
    echo "$catSound"
    soundsToPrepare[cat]=catSound # here we manupulate the blank array with another sound to make it fail
    echo ${soundsToPrepare[cat]}
    if [[ ${soundsToPrepare[cat]} == ${sounds[cat]} ]]; then
        return 0
    else
        return 1
    fi
}
echo "call to sample function with no return value try 1"
if samplefuncWithReturnTry1 "to dummy cat with a "; then
echo "success"
else
echo "failed"
fi
echo "function with input as key and print the value from data store"
#  {"foo1":"fooValue","foo2":"fooValue"}
function ActualTest() {
    for i in "${animals[@]}"; do
        soundsToPrepare[$i]="${sounds[$i]}"
        echo {""$i"":"""${sounds[$i]}"""}
    done
    echo "From soundsToPrepare"
    echo ${soundsToPrepare[@]}   # All values
    echo ${!soundsToPrepare[@]}  # All keys
    echo ${#soundsToPrepare[@]}  # Number of elements
}
echo "call to function with input as key and print the value from data store"
ActualTest
echo "function with input as key and print the value from data store with argument"
#  {"foo1":"fooValue","foo2":"fooValue"}
function ActualTestWithArgs() {
    echo $1
}
echo "call to function with input as key and print the value from data store with argument"
ActualTestWithArgs "${animals[@]}"