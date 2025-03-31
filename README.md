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
'''
`timescale 1ns/1ps

module lfsr_tb;
    // Parameter declaration
    parameter WIDTH = 32;

    // Signal declarations
    reg clk;
    reg rst;
    wire [WIDTH-1:0] lfsr_out;

    // Instantiate the LFSR module
    lfsr #(
        .WIDTH(WIDTH),
        .TAPS(32'h80200003)
    ) uut (
        .clk(clk),
        .rst(rst),
        .lfsr_out(lfsr_out)
    );

    // Clock generation: 10 ns period
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Dump waveforms and monitor signals
    initial begin
        $dumpfile("lfsr_tb.vcd");
        $dumpvars(0, lfsr_tb);
        $monitor("Time: %0t | rst: %b | lfsr_out: %h", $time, rst, lfsr_out);
    end

    // Test sequence
    initial begin
        rst = 1;         // Assert reset
        #10;
        rst = 0;         // De-assert reset

        // Run simulation for enough time to observe behavior
        #500;
        $display("Simulation complete at time %0t", $time);
        $finish;
    end
endmodule '''
'''(base) PS C:\Users\futur\Desktop\vscode_verilog> iverilog -o simulation LFSR_.v 
(base) PS C:\Users\futur\Desktop\vscode_verilog> vvp simulation
VCD info: dumpfile lfsr_tb.vcd opened for output.
Time: 0 | rst: 1 | lfsr_out: 00000001
Time: 10000 | rst: 0 | lfsr_out: 00000001
Time: 15000 | rst: 0 | lfsr_out: 00000003
Time: 25000 | rst: 0 | lfsr_out: 00000006
Time: 35000 | rst: 0 | lfsr_out: 0000000d
Time: 45000 | rst: 0 | lfsr_out: 0000001b
Time: 55000 | rst: 0 | lfsr_out: 00000036
Time: 65000 | rst: 0 | lfsr_out: 0000006d
Time: 75000 | rst: 0 | lfsr_out: 000000db
Time: 85000 | rst: 0 | lfsr_out: 000001b6
Time: 95000 | rst: 0 | lfsr_out: 0000036d
Time: 105000 | rst: 0 | lfsr_out: 000006db
Time: 115000 | rst: 0 | lfsr_out: 00000db6
Time: 125000 | rst: 0 | lfsr_out: 00001b6d
Time: 135000 | rst: 0 | lfsr_out: 000036db
Time: 145000 | rst: 0 | lfsr_out: 00006db6
Time: 155000 | rst: 0 | lfsr_out: 0000db6d
Time: 165000 | rst: 0 | lfsr_out: 0001b6db
Time: 175000 | rst: 0 | lfsr_out: 00036db6
Time: 185000 | rst: 0 | lfsr_out: 0006db6d
Time: 195000 | rst: 0 | lfsr_out: 000db6db
Time: 205000 | rst: 0 | lfsr_out: 001b6db6
Time: 215000 | rst: 0 | lfsr_out: 0036db6d
Time: 225000 | rst: 0 | lfsr_out: 006db6da
Time: 235000 | rst: 0 | lfsr_out: 00db6db4
Time: 245000 | rst: 0 | lfsr_out: 01b6db68
Time: 255000 | rst: 0 | lfsr_out: 036db6d1
Time: 265000 | rst: 0 | lfsr_out: 06db6da2
Time: 275000 | rst: 0 | lfsr_out: 0db6db45
Time: 285000 | rst: 0 | lfsr_out: 1b6db68a
Time: 295000 | rst: 0 | lfsr_out: 36db6d14
Time: 305000 | rst: 0 | lfsr_out: 6db6da28
Time: 315000 | rst: 0 | lfsr_out: db6db451
Time: 325000 | rst: 0 | lfsr_out: b6db68a3
Time: 335000 | rst: 0 | lfsr_out: 6db6d147
Time: 345000 | rst: 0 | lfsr_out: db6da28f
Time: 355000 | rst: 0 | lfsr_out: b6db451e
Time: 365000 | rst: 0 | lfsr_out: 6db68a3c
Time: 375000 | rst: 0 | lfsr_out: db6d1479
Time: 385000 | rst: 0 | lfsr_out: b6da28f3
Time: 395000 | rst: 0 | lfsr_out: 6db451e7
Time: 405000 | rst: 0 | lfsr_out: db68a3cf
Time: 415000 | rst: 0 | lfsr_out: b6d1479e
Time: 425000 | rst: 0 | lfsr_out: 6da28f3c
Time: 435000 | rst: 0 | lfsr_out: db451e79
Time: 445000 | rst: 0 | lfsr_out: b68a3cf2
Time: 455000 | rst: 0 | lfsr_out: 6d1479e4
Time: 465000 | rst: 0 | lfsr_out: da28f3c8
Time: 475000 | rst: 0 | lfsr_out: b451e790
Time: 485000 | rst: 0 | lfsr_out: 68a3cf21
Time: 495000 | rst: 0 | lfsr_out: d1479e42
Time: 505000 | rst: 0 | lfsr_out: a28f3c84
Simulation complete at time 510000
LFSR_.v:67: $finish called at 510000 (1ps)
(base) PS C:\Users\futur\Desktop\vscode_verilog> gtkwave lfsr_tb.vcd

GTKWave Analyzer v3.3.100 (w)1999-2019 BSI

[0] start time.
[510000] end time.
GTKWAVE | Select one or more traces. '''

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

