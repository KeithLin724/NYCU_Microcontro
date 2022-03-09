
def fun(t: int):
    if t == 0:
        return 1
    return 3*fun(t-1)


t = int(input())
print(fun(t))
