# CLFSR_system
🔐 CLFSR Encryption System A Chaotic Linear Feedback Shift Register (CLFSR) based encryption system that combines the simplicity of LFSR-based pseudo-random number generation with the unpredictability of chaotic maps. This hybrid system aims to enhance security for lightweight cryptographic applications such as image encryption, secure communication, and embedded systems.

📘 Overview The CLFSR Encryption System incorporates:

Linear Feedback Shift Register (LFSR): A basic shift register with XOR-based feedback to generate pseudo-random sequences.

Chaotic Map (e.g., Logistic Map): A deterministic nonlinear map that generates complex, non-repeating outputs.

XOR-based Encryption: The plaintext is encrypted using a keystream generated from the CLFSR.

This project includes:

HDL implementation (Verilog or VHDL)

MATLAB/Python simulation models

Testbenches for verification

Performance analysis (NPCR, UACI, entropy, histogram)

🛠 Features Hybrid pseudo-random number generation using chaos + LFSR

Lightweight encryption suitable for FPGA or ASIC

Configurable chaotic map parameters (e.g., logistic map r and initial x)

Bitwise XOR encryption and decryption

Simulation and analysis scripts

Test cases and example usage

🚀 Getting Started Requirements For Simulation:

MATLAB or Python 3.x (for algorithm simulation)

Verilog/VHDL simulation tools (e.g., ModelSim, Vivado)

For Hardware:

FPGA (e.g., Xilinx Spartan, Artix series)

Vivado / Quartus toolchain

HDL Simulation Run testbench for clfsr.v or clfsr.vhdl

Use waveform to verify output

Check encryption/decryption match

🔒 Security Metrics Metric Description NPCR Measures pixel change rate between original and cipher UACI Measures intensity difference Entropy Measures randomness Histogram Uniformity check of cipher output

✍️ Author Shivam Sikri Student of ECE BTech in NIT KURUKSHTRA Email: shivamsikri36@gmail.com
