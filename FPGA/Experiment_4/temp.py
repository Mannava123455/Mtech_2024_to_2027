import numpy as np
import matplotlib
matplotlib.use("TkAgg")  # Use TkAgg instead of GTK4
import matplotlib.pyplot as plt




m_input1 = np.loadtxt("input_signal_1.txt")
m_input2 = np.loadtxt("input_signal_2.txt")
m_input3 = np.loadtxt("input_signal_3.txt")
m_input4 = np.loadtxt("input_signal_4.txt")


m_output1 = np.loadtxt("output_signal_1.txt")
m_output2 = np.loadtxt("output_signal_2.txt")
m_output3 = np.loadtxt("output_signal_3.txt")
m_output4 = np.loadtxt("output_signal_4.txt")


v_data1 = np.loadtxt("verilog_output_1.txt")
v_data2 = np.loadtxt("verilog_output_2.txt")
v_data3 = np.loadtxt("verilog_output_3.txt")
v_data4 = np.loadtxt("verilog_output_4.txt")

v_data1 = v_data1[62 : 62+len(v_data1) + 1 - 123]
v_data2 = v_data2[62 : 62+len(v_data2) + 1 - 123]
v_data3 = v_data3[62 : 62+len(v_data3) + 1 - 123]
v_data4 = v_data4[62 : 62+len(v_data4) + 1 - 123]



# Create PDF to save figures
from matplotlib.backends.backend_pdf import PdfPages
pdf_pages = PdfPages("comparision_between_matlab_and_verilog.pdf")

# Plot and save Figure 1
fig, axs = plt.subplots(3, 1, figsize=(10, 8), sharex=True)
axs[0].plot(m_input1, label="Input Signal", color='b')
axs[0].set_title("Figure 1 - Input Signal with freq 100Hz ")
axs[0].legend()
axs[0].grid()
axs[1].plot(m_output1, label="Matlab output", color='g')
axs[1].set_title("Figure 2 - Matlab output")
axs[1].legend()
axs[1].grid()
axs[2].plot(v_data1, label="Verilog Output", color='r')
axs[2].set_title("Figure 3 - Verilog Output")
axs[2].legend()
axs[2].grid()
plt.xlabel("Sample Index")
plt.tight_layout()
pdf_pages.savefig(fig)
plt.close()

# Plot and save Figure 2
fig, axs = plt.subplots(3, 1, figsize=(10, 8), sharex=True)
axs[0].plot(m_input2, label="Input Signal", color='b')
axs[0].set_title("Figure 1 - Input Signal with freq 2000Hz")
axs[0].legend()
axs[0].grid()
axs[1].plot(m_output2, label="Matlab output", color='g')
axs[1].set_title("Figure 2 - Matlab output")
axs[1].legend()
axs[1].grid()
axs[2].plot(v_data2, label="Verilog Output", color='r')
axs[2].set_title("Figure 3 - Verilog Output")
axs[2].legend()
axs[2].grid()
plt.xlabel("Sample Index")
plt.tight_layout()
pdf_pages.savefig(fig)
plt.close()

# Plot and save Figure 3
fig, axs = plt.subplots(3, 1, figsize=(10, 8), sharex=True)
axs[0].plot(m_input3, label="Input Signal", color='b')
axs[0].set_title("Figure 1 - Input Signal with freq 6000Hz")
axs[0].legend()
axs[0].grid()
axs[1].plot(m_output3, label="Matlab output", color='g')
axs[1].set_title("Figure 2 - Matlab output")
axs[1].legend()
axs[1].grid()
axs[2].plot(v_data3, label="Verilog Output", color='r')
axs[2].set_title("Figure 3 - Verilog Output")
axs[2].legend()
axs[2].grid()
plt.xlabel("Sample Index")
plt.tight_layout()
pdf_pages.savefig(fig)
plt.close()

# Plot and save Figure 4
fig, axs = plt.subplots(3, 1, figsize=(10, 8), sharex=True)
axs[0].plot(m_input4, label="Input Signal", color='b')
axs[0].set_title("Figure 1 - Input Signal with freq 11000Hz")
axs[0].legend()
axs[0].grid()
axs[1].plot(m_output4, label="Expected Output", color='g')
axs[1].set_title("Figure 2 - Matlab output")
axs[1].legend()
axs[1].grid()
axs[2].plot(v_data4, label="Verilog Output", color='r')
axs[2].set_title("Figure 3 - Verilog Output")
axs[2].legend()
axs[2].grid()
plt.xlabel("Sample Index")
plt.tight_layout()
pdf_pages.savefig(fig)
plt.close()

# Save PDF
pdf_pages.close()


