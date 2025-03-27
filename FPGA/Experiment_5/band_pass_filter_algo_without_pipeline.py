import numpy as np
import scipy.io
import matplotlib
matplotlib.use("TkAgg")  # Use TkAgg instead of GTK4
import matplotlib.pyplot as plt

def fir_filter_with_verilog_logic(x, h):
    N = len(x)
    M = len(h)
    
    shift_reg = np.zeros(N)
    buffer = np.zeros(N)
    out = np.zeros(M + N - 1)
    
    i = 0
    for n in range(N + M - 1):
        shift_reg[1:] = shift_reg[:-1]
        
        if n < N:
            shift_reg[0] = x[n]
        else:
            shift_reg[0] = 0
            
        
        buffer[0] = shift_reg[0] * h[0]
        for j in range(1, N):
            if j < M:
                buffer[j] = buffer[j-1] + shift_reg[j] * h[j]
        
        if i < N - 1:
            out[n] = buffer[i]
            i += 1
        else:
            out[n] = buffer[i]
    
    return out

fs = 48000
f1 = 2000
cycles = 5

data = scipy.io.loadmat("exp_4.mat")
var_name = list(data.keys())[-1] 
filter_coeff = data[var_name].flatten()

no_of_samples_for_f1 = round(cycles * fs / f1)
t1 = np.arange(no_of_samples_for_f1) / fs
x1 = np.sin(2 * np.pi * f1 * t1)

filter_out_1 = fir_filter_with_verilog_logic(x1, filter_coeff)
mid_index = round(len(filter_coeff) / 2)
filter_out_1 = filter_out_1[mid_index:mid_index + no_of_samples_for_f1]

plt.figure()
plt.subplot(2,1,1)
plt.plot(t1, x1)
plt.title("Input signal with frequency 100 Hz")

plt.subplot(2,1,2)
plt.plot(t1, filter_out_1)
plt.title("Filter output in floating point (signal is attenuated)")
plt.show()