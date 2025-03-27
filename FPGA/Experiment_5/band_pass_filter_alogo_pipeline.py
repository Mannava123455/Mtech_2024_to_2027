import numpy as np
import scipy.io
import matplotlib
matplotlib.use("TkAgg")  # Use TkAgg instead of GTK4
import matplotlib.pyplot as plt


def fir_filter_with_verilog_logic(x, h):
    N = len(x)
    M = len(h)
    
    # Shift register and buffers
    shift_reg = np.zeros(N)  # Holds past input values
    mult_stage = np.zeros(M)  # Holds multiplication results
    add_stage = np.zeros(M)   # Holds accumulated sums
    out = np.zeros(N + M - 1) # Final output
    
    i = 0
    for n in range(N + M - 1):
        ## **Stage 1: Shift Register Update (Pipeline Stage 1)**
        shift_reg[1:] = shift_reg[:-1]
        shift_reg[0] = x[n] if n < N else 0
        
        ## **Stage 2: Parallel Multiplication (Pipeline Stage 2)**
        for j in range(M):
            if j < N:
                mult_stage[j] = shift_reg[j] * h[j]  # Multiply input with filter coefficient
        
        ## **Stage 3: Parallel Accumulation (Pipeline Stage 3)**
        add_stage[0] = mult_stage[0]
        for j in range(1, M):
            add_stage[j] = add_stage[j-1] + mult_stage[j]  # Accumulate partial sums
        
        ## **Stage 4: Store Output**
        if i < N - 1:
            out[n] = add_stage[i]
            i += 1
        else:
            out[n] = add_stage[i]
    
    return out


# Parameters
fs = 48000
f1 = 2000
cycles = 5

# Load filter coefficients from MATLAB file
data = scipy.io.loadmat("exp_4.mat")
var_name = list(data.keys())[-1]  # Get the variable name
filter_coeff = data[var_name].flatten()

# Generate input signal
no_of_samples_for_f1 = round(cycles * fs / f1)
t1 = np.arange(no_of_samples_for_f1) / fs
x1 = np.sin(2 * np.pi * f1 * t1)

# Apply FIR filter
x1 = [1,2,3,4,5]
filter_coeff = [1,2,3,4,5]
filter_out_1 = fir_filter_with_verilog_logic(x1, filter_coeff)
mid_index = round(len(filter_coeff) / 2)
filter_out_1 = filter_out_1[mid_index:mid_index + no_of_samples_for_f1]

# Plot results
plt.figure()
plt.subplot(2,1,1)
plt.plot(t1, x1)
plt.title("Input signal with frequency 100 Hz")

plt.subplot(2,1,2)
plt.plot(t1, filter_out_1)
plt.title("Filter output in floating point (signal is attenuated)")
plt.show()