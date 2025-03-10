# SQIsign Key Recovery

This repository implements an attack on the **SQIsign** digital signature scheme proposed in https://eprint.iacr.org/2020/1240. The attack code is written in **SageMath** and runs in **WSL (Windows Subsystem for Linux)**. It uses the SQIsign SageMath implementation from https://github.com/LearningToSQI/SQISign-SageMath.git.

## Overview

- The **original SageMath SQISign implementation** is included as a folder in `SQIsign-SageMath`.
- The attack is implemented separately in `SQIsign_KeyRecovery` by modifying only the attack-relevant files.
---

## Description

We target the signing process of SQIsign, where a significant portion of the computation involves processing the secret key through quaternion arithmetic enabled by the Deuring correspondence. The KLPT algorithm plays a central role in the signing procedure of https://eprint.iacr.org/2020/1240. 
Within its internal subroutines , we identify Cornacchia’s algorithm as a prime target for side-channel attacks. This algorithm is used to find a pair of integers $(x, y)$ satisfying the equation $x^2 + d\cdot y^2 = M$ for co-prime integers $d$ and $M$, where $d=1$ in our case, and $M$ is derived from the secret key $s$. If the input $M$ to Cornacchia's algorithm can be guessed correctly via power side-channel, then it becomes possible to recover the secret signing key of SQIsign. In our paper, we propose a key recovery framework through the KLPT algorithm. Specifically, if an attacker can retrieve the outputs $\gamma$ of RepresentInteger and $\mu$ of StrongApproximation algorithms within KLPT, then the output $\gamma \cdot \mu$ to the KLPT algorithm can be reconstructed. 

- 
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
