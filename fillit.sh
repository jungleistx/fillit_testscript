##! /bin/bash

# CHANGE PATH
# * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
BASE="/Users/login_name/folder_containing_repositories"
# * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 

TEST=$(pwd)
TESTFILE="${TEST}/testfiles"
RES="${TEST}/results"

# check for number of arguments
if (($# != 1))
then
    printf "usage: $0 <directory in '$BASE'>\n"
    exit
fi

# check if valid argument
if [ ! -d "$BASE/$1" ]
then
    printf "ERROR!\t\"$BASE/$1\" directory not found!\n"
    exit
fi

REPO="$BASE/$1"

# colors
YE='\033[4;33m'
YEN='\033[1;33m'
PR='\033[1;35m'
GR='\033[0;32m'
RD='\033[0;31m'
NC='\033[0m'
BL='\033[0;34m'

echo "\n\n${RD}_|___|___|___|___|___|___|___|___|___|___|___|___|___|___|_"
echo "___|___|___|___|___|___|___|___|___|___|___|___|___|___|___"
echo "_|___|___|___|___|___|___|___|___|___|___|___|___|___|     "
echo "__|___|${PR}   ______                          ${RD}__|___|___  ${GR} ^ ^${RD}"
echo "___|__ ${PR}   |                      _____     ${RD}___|___|_  ${GR}(O,O)${RD}"
echo "|___|_${PR}    |--    @  |    |    @    |       ${RD}_|__|___|  ${GR}(   )${RD}"
echo "_|___|_${PR}   |      |  |__  |__  |    |      ${RD}___|___|__ ${GR}---"-"--${RD}"
echo "__|___|_			        __|___|___|___|___|"
echo "___|___|___|___|___|___|___|___|___|___|___|___|___|___|___"
echo "|___|___|___|___|___|___|___|___|___|___|___|___|___|___|__"
echo "_|___|___|___|___|___|___|___|___|___|___|___|___|___|___|_${NC}\n"

printf "\nCleaning up results folder...\n\n"
rm -rf results/* > /dev/null

write_to_files() {

    printf "${YE}Writing output of 'usage' to file...${NC}"
    $1/./fillit > result_usage
    printf "\t---Results for \"usage\"\n\n---\n\n" >> result_usage
    printf "\t\t${GR}DONE!${NC}\n"
    
    declare -i x=1 y
    while [ $x -le 5 ]
    do
        printf "${YE}Writing output of '$x' to file...${NC}"
        { time $1/./fillit ../testfiles/$x; } &> result_$x
        printf "\t---Results for \"$x\"\n\n---\n\n" >> result_$x
        printf "\t\t${GR}DONE!${NC}\n"
        ((x++))
    done
    y=$x
    x=1
    while [ $x -le 13 ]
    do
        printf "${YE}Writing output of 'e_$x' to file...${NC}"
        { time $1/./fillit ../testfiles/e_$x; } &> result_$y
        printf "\t---Results for \"e_$x\"\n\n---\n\n" >> result_$y
        printf "\t\t${GR}DONE!${NC}\n"
        ((x++))
        ((y++))
    done
    printf "${YE}Writing output of 'pdf_1' to file...${NC}"
    { time $1/./fillit ../testfiles/pdf_1; } &> result_pdf_1.txt
    printf "\t---Results for pdf_1\n\n---\n\n" >> result_pdf_1.txt
    printf "\t\t${GR}DONE!${NC}\n"
    
    printf "${YE}Writing output of 'pdf_2' to file...${NC}"
    { time $1/./fillit ../testfiles/pdf_2; } &> result_pdf_2.txt
    printf "\t---Results for pdf_2\n\n---\n\n" >> result_pdf_2.txt
    printf "\t\t${GR}DONE!${NC}\n"
    
    printf "${YE}Writing output of 'max.txt' to file...${NC}"
    { time $1/./fillit ../testfiles/max.txt; } &> result_max.txt
    printf "\t---Results for max.txt\n" >> result_max.txt
    printf "\t\t${GR}DONE!${NC}\n"
}

write_to_tmp() {

    printf "\t\t$1\n\n" > fillit_$1
    cat result_usage >> fillit_$1
    
    declare -i y=1
    while [ $y -le 17 ]
    do
        cat result_$y >> fillit_$1
        ((y++))
    done
    cat result_pdf_1.txt >> fillit_$1
    cat result_pdf_2.txt >> fillit_$1
    cat result_max.txt >> fillit_$1
}

# check if libft makefile exists
cd $REPO
#<<com
if [ -f $REPO/libft/Makefile ]
then
    make -C libft/ fclean > /dev/null && make -C libft/ > /dev/null
fi
#com
make all > /dev/null
#make -C fclean > /dev/null && make -C > /dev/null

printf "\n\t\t\t${YE}---- TESTS ----\n\n${NC}"
cd $RES
write_to_files $REPO
write_to_tmp $1

cd $REPO
if [ -f $REPO/libft/Makefile ]
then
    make -C libft/ fclean > /dev/null
fi
make fclean > /dev/null

cd $REPO
printf "\n\t\t\t${YE}---- NORM ----\n${NC}"
norminette

cd $TEST
printf "\n---\n\nComparing with rvuorenl-jhaukil-fillit...\n"
diff -y rvuorenl_jhaukil results/fillit_$1 > results/fillit_$1_comparison

open results/fillit_$1_comparison
open results/fillit_$1

printf "\nOpened \"results/fillit_$1\"\n"
printf "\nOpened \"results/fillit_$1_comparison\"\n"

printf "\n\t\t${YE}TESTING REMINDER: Check leaks!${NC}\n\n"
