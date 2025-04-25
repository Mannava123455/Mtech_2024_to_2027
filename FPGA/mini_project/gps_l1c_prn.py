import numpy as np
import math

expansion_bits = [0,1,1,0,1,0,0]

weil_index_pilot = [5111,5109,5108,5106,5103]
insertion_index_pilot = [412,161,1,303,207]

weil_index_data = [5097,5110,5079,4403,4121]
insertion_index_data = [181,359,72,1110,1480]



weil_seq = np.zeros(10223)
L = np.zeros(10223)

def generate_legendre_sequence(sequence_length):
    output = [0] * sequence_length
    for x in range(1, sequence_length):
        t = (x * x) % sequence_length
        output[t] = 1
    return output



'''
pd = 1 -> data code
pd = 0 -> pilot code 
'''
def prn_code_generation(prn_id,pd):
    L = generate_legendre_sequence(10223)
    
    #generate the weil_sequence
    if(pd):
        weil_ind = weil_index_data[prn_id - 1]
        insertion_ind = insertion_index_data[prn_id - 1]
    else:
        weil_ind = weil_index_pilot[prn_id - 1]
        insertion_ind = insertion_index_pilot[prn_id - 1]

    for i in range(10223):
        weil_seq[i] = (L[i] ^ L[(i+weil_ind)%10223])
        
    #generate the prn code from the weil sequence
    out = weil_seq
    out[insertion_ind:insertion_ind + 7] = expansion_bits[0:]
    return out


np.set_printoptions(threshold=np.inf)
prn_code = prn_code_generation(1,1)
print(f"first 24 bits : {prn_code[0:24]}")
print(f"last 24 bits  : {prn_code[-24:]}")


L = generate_legendre_sequence(10223)

with open("legendre.mem", "w") as f:
    for bit in L:
        f.write(f"{bit}\n")
    
    
    
    
    
    


