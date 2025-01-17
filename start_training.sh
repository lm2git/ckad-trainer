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
        return 1
    fi
}

# File delle domande
QUESTIONS_FILE="questions.txt"

# Verifica se il file esiste
if [[ ! -f "$QUESTIONS_FILE" ]]; then
    red "Error: The 'questions.txt' file does not exist."
    exit 1
fi

# Leggi le domande dal file
mapfile -t questions < <(awk -v RS= '{print > ("question" NR ".tmp")}' "$QUESTIONS_FILE")

# Mescola l'ordine delle domande
shuffled_questions=($(shuf -e "${questions[@]}"))

# Ciclo attraverso le domande
for question_data in "${shuffled_questions[@]}"; do
    question=$(echo "$question_data" | grep '^question:' | cut -d ' ' -f 2-)
    verify_command=$(echo "$question_data" | grep '^verify_command:' | cut -d ' ' -f 2-)
    expected_output=$(echo "$question_data" | grep '^expected_output:' | cut -d ' ' -f 2-)

    # Mostra la domanda
    bold "\nQuestion: $question"
    read -p "Press Enter after completing the solution..."

    # Verifica la soluzione
    while ! verify_solution "$verify_command" "$expected_output"; do
        read -p "Modify the solution and press Enter to verify again..."
    done
done

green "\n🎉 Congratulations! You have completed all the questions!"