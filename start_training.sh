#!/bin/bash

# Funzioni per i colori
bold() {
    echo -e "\033[1m$1\033[0m"
}

green() {
    echo -e "\033[32m$1\033[0m"
}

red() {
    echo -e "\033[31m$1\033[0m"
}

cyan() {
    echo -e "\033[36m$1\033[0m"
}

yellow() {
    echo -e "\033[33m$1\033[0m"
}

# ASCII Art e titolo
clear
yellow "============================================"
yellow " CKAD Trainer - Interactive CKAD Simulator "
yellow "============================================"
echo ""

# Funzione per verificare una soluzione
verify_solution() {
    local verify_command="$1"
    local expected_output="$2"
    local output=$(eval "$verify_command" 2>/dev/null)
    if [[ "$output" == "$expected_output" ]]; then
        green "✅ Correct! You can proceed to the next question."
        return 0
    else
        red "❌ Incorrect. Try again."
        echo -e "Expected Output:\n$expected_output"
        echo -e "Your Output:\n$output"
        return 1
    fi
}

# Directory delle domande
QUESTIONS_DIR="q-pool"

# Verifica se la directory esiste
if [[ ! -d "$QUESTIONS_DIR" ]]; then
    red "Error: The '$QUESTIONS_DIR' directory does not exist."
    exit 1
fi

# Leggi i file delle domande
question_files=("$QUESTIONS_DIR"/q*.txt)

# Verifica se ci sono file di domande
if [[ ${#question_files[@]} -eq 0 ]]; then
    red "Error: No question files found in '$QUESTIONS_DIR'."
    exit 1
fi

# Mescola l'ordine dei file delle domande
shuffled_question_files=($(shuf -e "${question_files[@]}"))

# Ciclo attraverso i file delle domande
for question_file in "${shuffled_question_files[@]}"; do
    mapfile -t questions < <(awk -v RS= '{print > ("question" NR ".tmp")}' "$question_file")
    
    for question_data in "${questions[@]}"; do
        question=$(echo "$question_data" | grep '^question:' | cut -d ' ' -f 2-)
        verify_command=$(echo "$question_data" | grep '^verify_command:' | cut -d ' ' -f 2-)
        expected_output=$(echo "$question_data" | grep '^expected_output:' | cut -d ' ' -f 2-)

        # Mostra la domanda
        bold "\nQuestion: $question"
        read -p "Press Enter after completing the solution or type 'exit' to quit..."

        # Verifica la soluzione
        while ! verify_solution "$verify_command" "$expected_output"; do
            read -p "Modify the solution and press Enter to verify again or type 'exit' to quit..."
            if [[ $REPLY == "exit" ]]; then
                red "Exiting..."
                exit 0
            fi
        done
    done
done

green "\n🎉 Congratulations! You have completed all the questions!"