import numpy as np
import matplotlib
import matplotlib.pyplot as plt
from matplotlib.backends.backend_pdf import PdfPages

matplotlib.use('TkAgg') 

# Load data
sum_verilog = np.loadtxt("sum_verilog_out.txt")
sum_matlab = np.loadtxt("sum_matlab_out.txt")

diff_verilog = np.loadtxt("diff_verilog_out.txt")
diff_matlab = np.loadtxt("diff_matlab_out.txt")

product_verilog = np.loadtxt("product_verilog_out.txt")
product_matlab = np.loadtxt("product_matlab_out.txt")

# Compute differences
diff_sum = sum_verilog - sum_matlab
print(f"Error between Matlab and Verilog output (sum): {np.sum(diff_sum)}")

diff_diff = diff_verilog - diff_matlab
print(f"Error between Matlab and Verilog output (difference): {np.sum(diff_diff)}")

diff_product = product_verilog - product_matlab
print(f"Error between Matlab and Verilog output (product): {np.sum(diff_product)}")

# Save plots in a single PDF
with PdfPages("comparison_plots.pdf") as pdf:
    
    # Plot for Sum
    fig, axs = plt.subplots(2, 1, figsize=(8, 6), sharex=True)
    fig.suptitle("Sum of Numbers two numbers in Fixed Point Q(2,14) and Q(4,12)", fontsize=14, fontweight='bold')
    axs[0].plot(sum_matlab, label="Matlab")
    axs[0].set_title("Matlab Output", fontsize=10)
    axs[0].legend()
    axs[1].plot(sum_verilog, label="Verilog", color='r')
    axs[1].set_title("Verilog Output", fontsize=10)
    axs[1].legend()
    plt.tight_layout(rect=[0, 0, 1, 0.95])  # Adjust layout to prevent overlap
    pdf.savefig()
    plt.close()

    # Plot for Difference
    fig, axs = plt.subplots(2, 1, figsize=(8, 6), sharex=True)
    fig.suptitle("Difference of two Numbers in Fixed Point Q(2,14) and Q(4,12)", fontsize=14, fontweight='bold')
    axs[0].plot(diff_matlab, label="Matlab")
    axs[0].set_title("Matlab Output", fontsize=10)
    axs[0].legend()
    axs[1].plot(diff_verilog, label="Verilog", color='r')
    axs[1].set_title("Verilog Output", fontsize=10)
    axs[1].legend()
    plt.tight_layout(rect=[0, 0, 1, 0.95])
    pdf.savefig()
    plt.close()

    # Plot for Product
    fig, axs = plt.subplots(2, 1, figsize=(8, 6), sharex=True)
    fig.suptitle("Product of two Numbers in Fixed Point Q(2,14) and Q(4,12)", fontsize=14, fontweight='bold')
    axs[0].plot(product_matlab, label="Matlab")
    axs[0].set_title("Matlab Output", fontsize=10)
    axs[0].legend()
    axs[1].plot(product_verilog, label="Verilog", color='r')
    axs[1].set_title("Verilog Output", fontsize=10)
    axs[1].legend()
    plt.tight_layout(rect=[0, 0, 1, 0.95])
    pdf.savefig()
    plt.close()

print("Plots saved to 'comparison_plots.pdf'")
