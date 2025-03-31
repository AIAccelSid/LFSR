# 🔢 LFSR-Generator: Linear Feedback Shift Register Implementation

## 📌 Overview
**LFSR-Generator** is a collection of **Linear Feedback Shift Register (LFSR)** implementations in Verilog, C++, and Python. LFSRs are widely used in **random number generation, cryptography, error detection (CRC), and hardware testing (BIST).** This project provides parameterized LFSRs with testbenches, waveform analysis, and visualization tools.

## 🏗️ Features
- ✅ **Multi-language Support**: Verilog, C++, Python
- ✅ **Maximal-Length Sequences** using optimal feedback polynomials
- ✅ **Customizable Bit-widths** (8-bit, 16-bit, 32-bit, etc.)
- ✅ **PRNG & Cryptography Applications**
- ✅ **Hardware Testing & FPGA Ready**
- ✅ **Waveform Analysis (GTKWave, ModelSim)**
- ✅ **Python Visualization** using Matplotlib

---

## 📂 Repository Structure
```
LFSR-Generator/
│── docs/               # Documentation & tutorials
│── src/                # Source code for different languages
│   ├── verilog/        # Verilog implementation + testbench
│   ├── cpp/            # C++ implementation + example usage
│   ├── python/         # Python script for analysis & visualization
│── test/               # Test cases & validation scripts
│── examples/           # Real-world use cases (CRC, PRNG, BIST)
│── README.md           # Project overview
│── LICENSE             # Open-source license
│── .gitignore          # Ignore unnecessary files
```

---

## 🛠️ Implementations

### 🚀 Verilog Implementation
A parameterized **Verilog LFSR module** supporting different bit-widths:
```verilog
module lfsr #(
    parameter WIDTH = 32,
    parameter TAPS = 32'h80200003  // Example for 32-bit LFSR
) (
    input  logic clk, rst,
    output logic [WIDTH-1:0] lfsr_out
);
    logic [WIDTH-1:0] lfsr_reg;
    
    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            lfsr_reg <= 32'h1; // Seed
        else
            lfsr_reg <= {lfsr_reg[WIDTH-2:0], ^(lfsr_reg & TAPS)};
    end

    assign lfsr_out = lfsr_reg;
endmodule
```
✅ **Testbench included** for waveform simulation.
<img width="590" alt="Screenshot 2025-03-31 064639" src="https://github.com/user-attachments/assets/84de0e1c-61c6-48db-a08a-8d8115fb851f" />


---

### 🚀 C++ Implementation
LFSR-based **PRNG** in C++:
```cpp
#include <iostream>
#include <cstdint>

class LFSR {
private:
    uint32_t state;
    const uint32_t taps = 0x80200003;  // 32-bit polynomial

public:
    LFSR(uint32_t seed) : state(seed) {}
    
    uint32_t next() {
        state = (state >> 1) ^ (-(state & 1u) & taps);
        return state;
    }
};

int main() {
    LFSR lfsr(1);
    for (int i = 0; i < 10; i++)
        std::cout << std::hex << lfsr.next() << std::endl;
    return 0;
}
```
✅ **Benchmarked against standard `rand()` function.**

---

### 🚀 Python Implementation
Simulating and **visualizing LFSR sequences**:
```python
import numpy as np
import matplotlib.pyplot as plt

def lfsr_32bit(seed=1, taps=0x80200003, cycles=100):
    state = seed
    output = []
    for _ in range(cycles):
        state = (state >> 1) ^ (-(state & 1) & taps)
        output.append(state & 1)  # Store LSB
    return output

# Generate sequence
seq = lfsr_32bit()

# Plot results
plt.figure(figsize=(10, 3))
plt.plot(seq, marker="o")
plt.title("LFSR Output Sequence")
plt.show()
```
✅ **Matplotlib used for randomness visualization.**

---

## 🧪 Test & Validation
- ✅ **Functional tests** (Verify LFSR output sequence)
- ✅ **Waveform analysis** in Verilog using **GTKWave**
- ✅ **Randomness tests** (e.g., **NIST test suite** for PRNG validation)

---

## 🎯 Getting Started
### 📌 **1️⃣ Clone the Repository**
```bash
git clone https://github.com/your-username/LFSR-Generator.git
cd LFSR-Generator
```

### 📌 **2️⃣ Run the C++ Code**
```bash
g++ -o lfsr lfsr.cpp
./lfsr
```

### 📌 **3️⃣ Simulate the Verilog Code**
Using ModelSim or Icarus Verilog:
```bash
iverilog -o lfsr_tb lfsr_tb.v
vvp lfsr_tb
```

### 📌 **4️⃣ Run the Python Visualization**
```bash
python3 lfsr_plot.py
```

---

## 📜 License
This project is licensed under the **MIT License**.

---

## 🎯 Next Steps
🔹 FPGA implementation (Vivado/Quartus)  
🔹 More bit-widths (64-bit LFSR)  
🔹 Advanced PRNG benchmarking  
🔹 Integration with cryptographic functions  

💡 **Want to contribute?** PRs are welcome! 🚀

---

## 🤝 Contributors
- **Siddharth Singh Upadhyay** *(Project Lead & Maintainer)*
- Open for community contributions!

---

## ⭐ Star & Follow
If you found this project useful, please consider **starring ⭐** the repo and following for updates!

🔥 Let's build something amazing together! 🚀

