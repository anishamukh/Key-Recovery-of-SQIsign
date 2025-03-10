# SQIsign Key Recovery

This repository implements an attack on the **SQIsign** digital signature scheme proposed in https://eprint.iacr.org/2020/1240. The attack code is written in **SageMath** and runs in **WSL (Windows Subsystem for Linux)**. It uses the SQIsign SageMath implementation from https://github.com/LearningToSQI/SQISign-SageMath.git.

## Overview

- The **original SageMath SQISign implementation** is included as a folder in `SQIsign_Sage`.
- The attack is implemented separately in `SQIsign_KeyRecovery` by modifying only the attack-relevant files.
---

## Description

We target the signing process of SQIsign, where a significant portion of the computation involves processing the secret key through quaternion arithmetic enabled by the Deuring correspondence. The KLPT algorithm plays a central role in the signing procedure of https://eprint.iacr.org/2020/1240. 
Within its internal subroutines , we identify Cornacchia’s algorithm as a prime target for side-channel attacks. This algorithm is used to find a pair of integers $(x, y)$ satisfying the equation $x^2 + d\cdot y^2 = M$ for co-prime integers $d$ and $M$, where $d=1$ in our case, and $M$ is derived from the secret key $s$. If the input $M$ to Cornacchia's algorithm can be guessed correctly via power side-channel, then it becomes possible to recover the secret signing key of SQIsign. In our paper, we propose a key recovery framework through the KLPT algorithm. Specifically, if an attacker can retrieve the outputs $\gamma$ of RepresentInteger and $\mu$ of StrongApproximation algorithms within KLPT, then the output $\gamma \cdot \mu$ to the KLPT algorithm can be reconstructed (Theorem-2 in the paper). Once the output to KLPT algorithm is known, the attacker can follow a deterministic approach to retrieve the secret signing key as given in Corollary-1 in the paper. Thus, for demonstration purposes, hitting a successful match of $\gamma \cdot \mu$ is equivalent to retreiving the key.

Demonstration: Both $\gamma$ and $\mu$ are quaternions, specifically, they have the form, $(x + iy + jz + kt) \in \mathbb{Z} + i\cdot \mathbb{Z} + j\cdot \mathbb{Z} + k\cdot \mathbb{Z}$. The coefficients $(x, y)$ can be recovered as the outputs of the Cornacchia's algorithm. Thus, we need to recover the remaining two coordinates (z, t) from RepresentInteger as well as StrongApproximation (Theorem-1 and Proposition-1 in the paper). Based on the methods described in Theorem-1 and Proposition-1, we run the `two_squares()` function available in SageMath. 

- Specifically, in `KLPT_attack.py`, we call the `two_squares()` function inside `RepresentintegerHeuristic` and `strong_approximation_lattice_heuristic` functions. All intermediate values and relevant data are stored in `RepresentInteger_attack_values.txt` and `StrongApproximation_attack_values.txt` files. We perform the attack for 54-bit toy parameter set given in SQIsign-SageMath.

 ## How to run and interpret results

- Ensure that you have **SageMath** installed.
- Run the file, `example_signing_attack.sage` file in sage command line.
- The output prints all the successfully reconstructed values of $\gamma$ and $\mu$ as $\gamma$ _constructed and $\mu$ _constructed.
- When the retrieved values $\gamma_$constructed and $\mu_$constructed match with the actual values of $\gamma$ and $\mu$, the output notifies saying "Attack successful in Represent Integer(or respectively, Strong Approximation) with M = (retrieved value of intermediate M) and (z, t) = (retrieved value of z, t)"
- Additionally, it also prints the time taken for the attack, which is usually in the order of $10^{-3}$ seconds for the 54-bit parameter set.
- Finally, it also prints the actual values of $\gamma$ and $\mu$ in the KLPT algorithm which allows us to match the retrieved values with the actual values, thereby giving us $\gamma \cdot \mu$ and hence the output of KLPT.
- All the above-mentioned relevant values and the time taken for the attack can also be found in the .txt files mentioned before.


