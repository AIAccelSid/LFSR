import numpy as np
import matplotlib.pyplot as plt

def lfsr_32bit(seed = 1, taps = 0x80200003 , cycles = 100):
    state = seed
    output = []
    for _ in range(cycles):
        state = (state >> 1) ^ (-(state & 1) & taps)
        output.append(state & 1)
    return output    

seq = lfsr_32bit()

plt.figure(figsize=(10 , 3))
plt.plot(seq, marker = 'o')
plt.title("LSFR Output Sequence")
plt.show()