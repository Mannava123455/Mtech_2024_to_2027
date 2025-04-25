import numpy as np
import matplotlib
matplotlib.use("TkAgg")  # Use TkAgg instead of GTK4
import matplotlib.pyplot as plt
from matplotlib.backends.backend_pdf import PdfPages

input_signal_1 = np.loadtxt("input_signal_1.txt")
input_signal_2 = np.loadtxt("input_signal_2.txt")
input_signal_3 = np.loadtxt("input_signal_3.txt")
input_signal_4 = np.loadtxt("input_signal_4.txt")

# Load non-pipeline signals
non_pip_1 = np.loadtxt("non_pipeline_sig_1.dat")
non_pip_2 = np.loadtxt("non_pipeline_sig_2.dat")
non_pip_3 = np.loadtxt("non_pipeline_sig_3.dat")
non_pip_4 = np.loadtxt("non_pipeline_sig_4.dat")

# Load pipeline signals
pip_1 = np.loadtxt("pipeline_sig_1.dat")
pip_2 = np.loadtxt("pipeline_sig_2.dat")
pip_3 = np.loadtxt("pipeline_sig_3.dat")
pip_4 = np.loadtxt("pipeline_sig_4.dat")

# Open a PDF file to save all figures
pdf_filename = "fir_pipeline_vs_nonpipeline.pdf"
with PdfPages(pdf_filename) as pdf:
    
    # Create first figure (100Hz signal)
    fig1 = plt.figure(figsize=(8, 6))
    
    plt.subplot(3, 1, 1)
    plt.plot(input_signal_1)
    plt.title("input 100Hz signal")
    plt.grid()
    
    plt.subplot(3, 1, 2)
    plt.plot(non_pip_1)
    plt.title("FIR non_pipeline_output for 100Hz signal")
    plt.grid()

    plt.subplot(3, 1, 3)
    plt.plot(pip_1)
    plt.title("FIR pipeline_output for 100Hz signal")
    plt.grid()

    plt.tight_layout()
    pdf.savefig(fig1)  # Save the figure to the PDF
    plt.close(fig1)    # Close the figure to free memory

    # Create second figure (2000Hz signal)
    fig2 = plt.figure(figsize=(8, 6))
    
    plt.subplot(3, 1, 1)
    plt.plot(input_signal_2)
    plt.title("input 2000Hz signal")
    plt.grid()
    
    
    plt.subplot(3, 1, 2)
    plt.plot(non_pip_2)
    plt.title("FIR non_pipeline_output for 2000Hz signal")
    plt.grid()

    plt.subplot(3, 1, 3)
    plt.plot(pip_2)
    plt.title("FIR pipeline_output for 2000Hz signal")
    plt.grid()

    plt.tight_layout()
    pdf.savefig(fig2)
    plt.close(fig2)

    # Create third figure (6000Hz signal)
    fig3 = plt.figure(figsize=(8, 6))
    
    plt.subplot(3, 1, 1)
    plt.plot(input_signal_3)
    plt.title("input 6000Hz signal")
    plt.grid()
    
    plt.subplot(3, 1, 2)
    plt.plot(non_pip_3)
    plt.title("FIR non_pipeline_output for 6000Hz signal")
    plt.grid()

    plt.subplot(3, 1, 3)
    plt.plot(pip_3)
    plt.title("FIR pipeline_output for 6000Hz signal")
    plt.grid()

    plt.tight_layout()
    pdf.savefig(fig3)
    plt.close(fig3)

    # Create fourth figure (11000Hz signal)
    fig4 = plt.figure(figsize=(8, 6))
    
    plt.subplot(3, 1, 1)
    plt.plot(input_signal_4)
    plt.title("input 11000Hz signal")
    plt.grid()
    
    plt.subplot(3, 1, 2)
    plt.plot(non_pip_4)
    plt.title("FIR non_pipeline_output for 11000Hz signal")
    plt.grid()

    plt.subplot(3, 1, 3)
    plt.plot(pip_4)
    plt.title("FIR pipeline_output for 11000Hz signal")
    plt.grid()

    plt.tight_layout()
    pdf.savefig(fig4)
    plt.close(fig4)

print(f"All plots saved in '{pdf_filename}'")
