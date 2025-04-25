import numpy as np

# PRN values in octal
data_prncode_first_24_bits = [0o77001425, 0o23342754, 0o30523404, 0o3777635, 0o10505640]
data_prncode_last_24_bits  = [0o52231646, 0o46703351, 0o0145161, 0o11261273, 0o71364603]

pilot_prncode_first_24_bits = [0o5752067, 0o70146401, 0o32066222, 0o72125121, 0o42323273]
pilot_prncode_last_24_bits  = [0o20173742, 0o35437154, 0o0161056, 0o71435437, 0o15035661]

# Load data from files
data_1 = np.loadtxt("data_prn_1.txt")
data_2 = np.loadtxt("data_prn_2.txt")
data_3 = np.loadtxt("data_prn_3.txt")
data_4 = np.loadtxt("data_prn_4.txt")
data_5 = np.loadtxt("data_prn_5.txt")

pilot_1 = np.loadtxt("pilot_prn_1.txt")
pilot_2 = np.loadtxt("pilot_prn_2.txt")
pilot_3 = np.loadtxt("pilot_prn_3.txt")
pilot_4 = np.loadtxt("pilot_prn_4.txt")
pilot_5 = np.loadtxt("pilot_prn_5.txt")


# Conversion function
def binstr_to_octal(bits):
    if isinstance(bits, np.ndarray):
        bits = bits.tolist()
    if isinstance(bits, list):
        bits = ''.join(str(int(b)) for b in bits)
    elif not isinstance(bits, str):
        raise ValueError(f"Input must be a string, list, or numpy array of bits, got {type(bits)}")
    return oct(int(bits, 2))[2:]  # Remove the '0o' prefix


# Convert each to octal
data_1_first_24 = binstr_to_octal(data_1[0:24])
data_1_last_24  = binstr_to_octal(data_1[-24:])

data_2_first_24 = binstr_to_octal(data_2[0:24])
data_2_last_24  = binstr_to_octal(data_2[-24:])

data_3_first_24 = binstr_to_octal(data_3[0:24])
data_3_last_24  = binstr_to_octal(data_3[-24:])

data_4_first_24 = binstr_to_octal(data_4[0:24])
data_4_last_24  = binstr_to_octal(data_4[-24:])

data_5_first_24 = binstr_to_octal(data_5[0:24])
data_5_last_24  = binstr_to_octal(data_5[-24:])

pilot_1_first_24 = binstr_to_octal(pilot_1[0:24])
pilot_1_last_24  = binstr_to_octal(pilot_1[-24:])

pilot_2_first_24 = binstr_to_octal(pilot_2[0:24])
pilot_2_last_24  = binstr_to_octal(pilot_2[-24:])

pilot_3_first_24 = binstr_to_octal(pilot_3[0:24])
pilot_3_last_24  = binstr_to_octal(pilot_3[-24:])

pilot_4_first_24 = binstr_to_octal(pilot_4[0:24])
pilot_4_last_24  = binstr_to_octal(pilot_4[-24:])

pilot_5_first_24 = binstr_to_octal(pilot_5[0:24])
pilot_5_last_24  = binstr_to_octal(pilot_5[-24:])


for i in range(5):
    data_first_expected = data_prncode_first_24_bits[i]
    data_last_expected  = data_prncode_last_24_bits[i]
    data_first_actual   = int(eval(f"data_{i+1}_first_24"), 8)
    data_last_actual    = int(eval(f"data_{i+1}_last_24"), 8)

    print(f"Data PRN {i+1} First 24 bits -> Expected: {oct(data_first_expected)}, Got: {oct(data_first_actual)} -> Match: {data_first_expected == data_first_actual}")
    print(f"Data PRN {i+1} Last  24 bits -> Expected: {oct(data_last_expected)}, Got: {oct(data_last_actual)} -> Match: {data_last_expected == data_last_actual}")

for i in range(5):
    pilot_first_expected = pilot_prncode_first_24_bits[i]
    pilot_last_expected  = pilot_prncode_last_24_bits[i]
    pilot_first_actual   = int(eval(f"pilot_{i+1}_first_24"), 8)
    pilot_last_actual    = int(eval(f"pilot_{i+1}_last_24"), 8)

    print(f"Pilot PRN {i+1} First 24 bits -> Expected: {oct(pilot_first_expected)}, Got: {oct(pilot_first_actual)} -> Match: {pilot_first_expected == pilot_first_actual}")
    print(f"Pilot PRN {i+1} Last  24 bits -> Expected: {oct(pilot_last_expected)}, Got: {oct(pilot_last_actual)} -> Match: {pilot_last_expected == pilot_last_actual}")
