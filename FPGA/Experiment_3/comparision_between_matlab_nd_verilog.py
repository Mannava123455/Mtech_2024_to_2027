import numpy as np
import matplotlib
import matplotlib.pyplot as plt
from matplotlib.backends.backend_pdf import PdfPages

matplotlib.use('TkAgg') 

# Load data

input = np.loadtxt("division_input.txt")
matlab_output = np.loadtxt("output.txt")
verilog_output = np.loadtxt("division_output.txt")



# Save plots in a single PDF
with PdfPages("comparison_plots.pdf") as pdf:
    
    # Plot for Sum
    fig, axs = plt.subplots(3, 1, figsize=(8, 6), sharex=True)
    fig.suptitle("Newton raphson division in fixed point", fontsize=14, fontweight='bold')
    
    axs[0].plot(input, label="Matlab")
    axs[0].set_title("Input from matlab x[n]", fontsize=10)
    axs[0].legend()
    
    axs[1].plot(matlab_output, label="matlab", color='r')
    axs[1].set_title("matlab Output using newton raphson method 10/x[n]", fontsize=10)
    axs[1].legend()
    
    axs[2].plot(verilog_output, label="Verilog", color='b')
    axs[2].set_title("Verilog Output using newton raphson method 10/x[n] ", fontsize=10)
    axs[2].legend()
    
    plt.tight_layout(rect=[0, 0, 1, 0.95])  # Adjust layout to prevent overlap
    pdf.savefig()
    plt.close()

