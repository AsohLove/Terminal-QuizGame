#! /bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
RESET="\e[0m"


QUEST_FILE="questions.txt"
score=0
num_of_incorrect_ans=0
win_streak=0
date=$(date +%Y-%m-%d)
longest_win_streak=0
HIGH="highscores.txt"

if [[ $1 == "$HIGH" ]]; then
    if [[ ! -f "$HIGH" ]];then
        echo -e "${RED} The highcore file does not exist${RESET}"
    elif [[ ! -s "$HIGH" ]]; then
        echo -e "${RED}  the highscore file is empty ${RESET}"
    else 
            
            echo -e "${GREEN} The 5 top scorers are: ${RESET}"
            sort -nr highscores.txt | head -n 5
            exit 1
    fi
fi

echo "   ================================    "
echo "   ==========  Quiz Game  =========    "
read -r -p " Please provide your name: " name

echo "   ================================    "


 #File validation check
if [[ ! -f "$QUEST_FILE" ]]; then
     echo -e "${RED}The questions file you are trying to access is not found!${RESET}"
     exit 1
fi

  #Check to ensure file is not empty
if [[ ! -s "$QUEST_FILE" ]]; then 
     echo -e "${RED}The question file is currently empty. ${RESET}"
     exit 1
fi

# Read the file line by line and then add them to a declared empty array questions
questions=()
while IFS= read -r line || [[ -n "$line" ]]; do 
   questions+=("$line")
done < "$QUEST_FILE"

total=${#questions[@]}

echo -e "Choose the mode you want to play"
echo "1. Competitive Quiz Mode"
echo "2. Non-competitive Practice Mode"
read -r -p "Choose 1 or 2: " mode_choice

    case $mode_choice in 
        1) 
            # Quiz Mode
            echo "====== Welcome $name to this Competitive Quiz mode ======="

            # Shuffle(randomize) the sequence number of questions with shuf
            mapfile -t order < <(seq 0 $((total -1)) | shuf)



            for i in "${!order[@]}"; do
                idx="${order[$i]}"
                
                clear 

                echo -e "==== Question $(( i + 1)) of $total ======= "

                IFS='|' read -r q a b c d correct <<< "${questions[$idx]}"

                echo -e "$q"
                echo "$a"
                echo "$b"
                echo "$c"
                echo "$d"


                #Checking that the right input option is provided
                while true; do
                    read -r -p "Enter your answer A/B/C/D: " answer
                    # In case the answer is lowercase, convert to uppercase
                    answer=$(echo "$answer" | tr '[:lower:]' '[:upper:]') 
                    if [[ $answer =~ ^[ABCD]$ ]]; then
                        break
                    else
                        echo -e "${RED}Invalid input Please select either the letter: A, B, C, or D ${RESET}"
                    fi
                done
                    if [[ $answer == "$correct" ]]; then
                        echo -e "${GREEN} Correct!!${RESET}"
                        score=$((score + 1))
                        win_streak=$((win_streak + 1 ))
                        if [[ $win_streak -gt $longest_win_streak ]]; then
                            longest_win_streak=$win_streak
                        fi
                    else
                        echo -e "${RED} Incorrect. The correct answer is $correct${RESET}"
                        win_streak=0
                        num_of_incorrect_ans=$((num_of_incorrect_ans + 1))
                    fi

          
            sleep 3
            clear
            done

        percent_correct=$(((score * 100) / total))
        echo "Thank You for partaking in the quiz."
        echo "Here is how you performed!"
        echo "Total: $total Correct: $score Incorrect: $num_of_incorrect_ans Longest Streak: $longest_win_streak Final Score: $percent_correct%"
       
        echo -e "$name|$percent_correct|$score/$total|$date" >> highscores.txt

        ;;
        2)
            # Practice Mode
            echo "====== Welcome $name to this Non-Competitive Practice mode ======="
       
            # The loop that ensures all questions in the questions array are read.
            for i in "${!questions[@]}"; do
                IFS='|' read -r q a b c d correct <<< "${questions[$i]}"

                # This note the progress of the questions
                echo -e "==== Question $(( i + 1)) of $total ======= "

                echo -e "$q"
                echo "$a"
                echo "$b"
                echo "$c"
                echo "$d"

                while true; do 
                    read -r -p "Enter your answer A/B/C/D: " answer
                    # In case the answer is lowercase, convert to uppercase and accept the answer
                    answer=$(echo "$answer" | tr '[:lower:]' '[:upper:]')
                    if [[ $answer =~ ^[ABCD]$ ]]; then
                        break
                    else 
                        echo -e "${RED} Invalid input. Please select either the letter A, B, C, or D ${RESET}"
                    fi
                done

                # The condition that checks that the answer the player selected is correct or not
                if [[ $answer == "$correct" ]]; then
                    echo -e "${GREEN} Correct! $correct ${RESET}"
                else
                    echo -e "${RED} Incorrect. The correct answer was $correct${RESET}"
            
                fi
            # After each answered question, the screen sleeps for a while before being cleared for the next question
            sleep 3
            clear

            done

                echo -e "Practice mode exiting....."

        ;;
        *)
            # The default message that is displayed when the an invalid mode options is entered
            echo -e "${RED}Invalid choice. Usage : You need to choose either 1 or 2 ${RESET}"
            exit 1
        ;;
    
    esac
    