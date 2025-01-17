# CKAD Trainer - Interactive CKAD Simulator

Welcome to the **CKAD Trainer**! This is an interactive simulator designed to help you prepare for the **Certified Kubernetes Application Developer (CKAD)** exam. The simulator provides a series of randomized questions and scenarios to test your Kubernetes skills in a hands-on environment.

---

## Features

- **Randomized Questions**: Questions are shuffled to ensure a unique experience every time.
- **Interactive Verification**: After attempting a solution, the simulator verifies your answer and provides feedback.
- **Color-Coded Output**: Clear visual feedback with color-coded messages for correct and incorrect answers.
- **Dynamic Question Pool**: Questions are loaded from a directory (`q-pool`), making it easy to add or modify questions.

---

## How It Works

1. **Question Display**: Each question is displayed with a prompt to complete the task.
2. **Solution Verification**: After attempting the solution, the simulator runs a verification command to check your work.
3. **Feedback**: If the solution is correct, you'll receive a green ✅ and move to the next question. If incorrect, you'll see a red ❌ and can try again.
4. **Completion**: Once all questions are completed, you'll receive a congratulatory message 🎉.

---

## Getting Started

### Prerequisites

- A working Kubernetes cluster (e.g., Minikube, Kind, or a cloud-based cluster).
- `kubectl` installed and configured to interact with your cluster.
- Basic familiarity with Kubernetes concepts and commands.

### Running the Simulator

1. Clone the repository:
   ```bash
   git clone https://github.com/lm2git/ckad-trainer.git
   cd ckad-trainer
   ```
2. Ensure the `q-pool` directory contains the question files (e.g., `q1.txt`, `q2.txt`, etc.).

3. Make the script executable:
   ```bash
   chmod +x start_training.sh
   ```
4. Run the simulator:
   ```bash
   ./start_training.sh
   ```

## Contributing

Contributions are welcome! If you'd like to add new questions or improve the simulator, follow these steps:

1. Fork the repository.
2. Add your questions to the `q-pool` directory.
3. Submit a pull request with a description of your changes.


---

## Contact

If you have any questions or feedback, feel free to reach out:

- **GitHub**: [lm2git](https://github.com/lm2git)