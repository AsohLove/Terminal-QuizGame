# Terminal Quiz Game

## :beginner: Project description
This is a command-line game built with bash where a user is able answer an interactive quiz on the terminal, also able to record their score, track their longest winning streak on the MCQs and finally get a final score in percentage.

```text
|
|--- .github/
| |--- workflows/
|    |--- linters.yml # Contains the linters code for checking code errors
|
|--- quiz.sh # quiz game implementation in bash programming language
|
|--- questions.txt # text file containing quiz questions
|
|---README.md # Project overview and documentation
|
```

### :star: Tech Stack
- Bash

**Code snippet**

```bash
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
                        num_of_correct_ans=$((num_of_correct_ans + 1))
                    else
                        echo -e "${RED} Incorrect. The correct answer is $correct${RESET}"
                        num_of_incorrect_ans=$((num_of_incorrect_ans + 1))
                    fi
```

### Preview of answer

![Answering MCQs](assets/images/MCQ.png)

## About
The game is programmed such that a player chooses to either a *play competitive quiz mode* or a *non-competitive practice mode*. The quiz mode tracks the player's score, longest winning streak and save the high scores whereas the practice mode does not track high scores.

### :electric_plug: How to play this quiz Game
This quiz game is built using Bash and runs directly in your terminal.

Follow the steps below to start playing:

- You can get a copy of the game at [this repository](https://github.com/AsohLove/Terminal-Quiz-Game.git) OR download it as a ZIP file and extract it.

- Open your terminal and move into the project directory `cd Terminal-QuizGame` OR if you downloaded the ZIP file, navigate to where you extracted it. Example: `cd Desktop/quiz-game`

- Give execution permission to the script; `chmod +x quiz.sh`

- Run `./quiz.sh` to launch the game

The game will now start in your terminal


## Author

:fire: **Love Asoh**

- GitHub: [@loveasoh](https://github.com/AsohLove)
- Twitter: [@loveasoh](https://x.com/LoveTheModifier)
- LinkedIn: [love asoh](https://www.linkedin.com/in/asohlove/)


## :lock: License
This project is [MIT](./LICENSE) licensed.