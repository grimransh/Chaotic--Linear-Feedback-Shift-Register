# Chaotic Linear Feedback Shift Register (CLFSR)

A hybrid image encryption–decryption system using **Chaotic Maps + Linear Feedback Shift Registers (LFSRs)**.  
This project integrates Python for image preprocessing and reconstruction, and Verilog (Icarus Verilog) for secure bit-level encryption.

---

## 📁 Project Structure

```
CHAOTIC--LINEAR-FEEDBACK-SHIFT-REGISTER/
├── Main/
│   ├── Transmitter/
│   │   ├── Encrypt.v
│   │   ├── Main.v
│   │   ├── RandomNumberGenerator.v
│   │   ├── to_mem.py               # Converts image to .mem format (R/G/B)
│   │   └── tb_main.v                # Encrypts image
│   ├── Channel/
│   │   └── for_encrypted_image.py   # Visualize encrypted image
│   ├── Receiver/
│   │   ├── Decrypt.v
│   │   ├── Main.v
│   │   ├── RandomNumberGenerator.v
│   │   ├── tb_main.v                # Decrypts encrypted data
│   │   └── decrypted_image.py       # Converts decrypted .mem back to image
├── Images/
│   ├── tree_128.jpg
│   ├── bird_128.jpg
│   └── ...
```

---

## ▶️ Full Workflow

### 🔒 1. Transmitter Phase (Encryption)

1. **Convert an image to `.mem` format**:
   ```bash
   python to_mem.py
   ```
   This generates:
   - `R.mem`
   - `G.mem`
   - `B.mem`

2. **Run Verilog testbench to encrypt the image**:
   ```bash
   cd codes/Transmitter
   iverilog -o tx.out tb_main.v
   vvp tx.out
   ```
   This produces:
   - `R_encrypted.mem`
   - `G_encrypted.mem`
   - `B_encrypted.mem`

3. **Move encrypted files to Channel**:
   ```bash
   mv *_encrypted.mem ../Channel/
   ```

---

### 📡 2. Channel Phase (Visualization)

1. **Visualize encrypted image**:
   ```bash
   cd ../Channel
   python for_encrypted_image.py
   ```
2. **Move encrypted files to Receiver**:
   ```bash
   mv *_encrypted.mem ../Receiver/
   ```
   ➜ The Encrypted output image will be saved in the same folder.


---

### 🔓 3. Receiver Phase (Decryption)

1. **Run Verilog testbench to decrypt**:
   ```bash
   cd ../Receiver
   iverilog -o rx.out tb_main.v
   vvp rx.out
   ```
   This creates:
   - `R_decrypted.mem`
   - `G_decrypted.mem`
   - `B_decrypted.mem`

2. **Convert `.mem` files back to an image**:
   ```bash
   python decrypted_image.py
   ```

   ➜ The final output image will be saved in the same folder.

---

## 🖼️ How to Change the Input Image

1. Open `codes/transmitter/to_mem.py`
2. Modify the image file path:
   ```python
   image_path = "../Images/tree_128.jpg"
   ```
3. You can use any `*_128.jpg` file from the `Images/` folder.  
   **Ensure it is 128x128 pixels in size.**

---

## ⚙️ Requirements

- Python 3.x
- Icarus Verilog (install via `apt`, `brew`, or from source)
- Python dependencies:
  ```bash
  pip install pillow numpy
  ```

---

## ✅ Summary of File Flow

| Stage         | Inputs           | Outputs                   |
|---------------|------------------|---------------------------|
| Python Input   | `.jpg` image     | `R.mem`, `G.mem`, `B.mem` |
| Verilog TX    | R/G/B `.mem`     | `R_encrypted.mem`, etc.   |
| Channel       | Encrypted `.mem` | Visual confirmation       |
| Verilog RX    | Encrypted `.mem` | `decrypted_R/G/B.mem`     |
| Python Output | Decrypted `.mem` | Final reconstructed image |

---

<!-- ## 🧪 Possible Enhancements

- Add support for different chaotic maps (Tent, Sine, Bernoulli)
- Add automation script for the full pipeline
- Integrate NIST randomness test suite
- Add waveform viewer with `gtkwave` -->

---

