import numpy as np

SHIFT = 16  # Number of fractional bits
FIXED_ONE = 1 << SHIFT  # 1.0 in Q16.16 format

def to_fixed(x):
    return int(x * FIXED_ONE)

def to_float(x):
    return x / FIXED_ONE

def multiply_fixed(a, b):
    return (a * b) >> SHIFT

#  Generate Lookup Table Using Textbook Formula
def generate_lookup_table():
    num_entries = 64
    table = []
    for i in range(num_entries):
        d = 0.5 + (i / num_entries) * 0.5  # d in [0.5, 1)
        
        # Corrected textbook formula for x0
        x0 = 2.9282 - 2 * d 
        
        table.append(to_fixed(x0))  
    return table

LOOKUP_TABLE = generate_lookup_table()
# for i in range(0,64):
#     print(f" 64'sd{LOOKUP_TABLE[i]},")

def lookup_x0(d_fixed):
    d_float = to_float(d_fixed)
    if d_float < 0.5 or d_float >= 1.0:
        raise ValueError("d must be normalized to [0.5, 1)")
    
    index = int((d_float - 0.5) / (0.5 / 64))
    return LOOKUP_TABLE[index]

def normalize_denominator(d_fixed):
    shift = 0
    while d_fixed < (1 << (SHIFT - 1)):  
        d_fixed <<= 1  
        shift += 1
    while d_fixed >= (1 << SHIFT):  
        d_fixed >>= 1  
        shift -= 1
    return d_fixed, shift

# Newton-Raphson Fixed-Point Division
def newton_raphson_divide(numerator, denominator):
    denominator, shift = normalize_denominator(denominator)
    x = lookup_x0(denominator)

    for _ in range(3):  
        x = multiply_fixed(x, (FIXED_ONE * 2 - multiply_fixed(x, denominator)))

    result = multiply_fixed(numerator, x)
    if(shift > 0):
        result <<= abs(shift)  
    else:
        result >>= abs(shift)
    return result

# Example
numerator = to_fixed(10)
denominator = to_fixed(101)


# numerator = 983040
# denominator = 65536


quotient_fixed = newton_raphson_divide(numerator, denominator)
quotient_float = to_float(quotient_fixed)

print(f"Fixed-point result: {quotient_fixed} (Q16.16)")
print(f"Floating-point equivalent: {quotient_float}")
