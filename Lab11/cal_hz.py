from math import floor

bits = int(input("bits ? "))

constant_bit = 2**(bits - 8)
bit_to_dec = 2**bits

x = input("Hz : array ")
arr = list(map(int, x.split()))

print("Th0 : , Tl0 : ")
for i in arr:
    a = i
    i = (1/i) * 0.5
    i /= (10**-6)
    i = bit_to_dec - i
    print("db ", floor(i/constant_bit), end=',')
    print(floor(i % constant_bit), end=',')
    print(floor(a/4))
