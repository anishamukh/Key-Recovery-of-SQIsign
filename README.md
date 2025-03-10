# SQIsign Key Recovery

This repository implements an attack on the **SQIsign** digital signature scheme proposed in https://eprint.iacr.org/2020/1240. The attack code is written in **SageMath** and runs in **WSL (Windows Subsystem for Linux)**. It uses the SQIsign SageMath implementation from https://github.com/LearningToSQI/SQISign-SageMath.git.

## Overview

- The **original SageMath SQISign implementation** is included as a folder in `SQIsign-SageMath`.
- The attack is implemented separately in `SQIsign_KeyRecovery` by modifying only the attack-relevant files.
---

## Description

### **Step 1: Install Required Software**
Ensure you have the following installed on **WSL (Ubuntu on Windows)**:

1. **WSL** (Windows Subsystem for Linux)
   - Install WSL from PowerShell:
     ```sh
     wsl --install
     ```
   - If WSL is already installed, update it:
     ```sh
     wsl --update
     ```

2. **SageMath** (in WSL)
   - Install SageMath:
     ```sh
     sudo apt update
     sudo apt install sagemath
     ```
   - Verify installation:
     ```sh
     sage --version
     ```

3. **Git** (if not installed)
   ```sh
   sudo apt install git
