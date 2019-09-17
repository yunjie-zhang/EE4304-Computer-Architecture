size = 10
result = 0
array = [0, 2, 4, 6, 8, 10, 12, 14, 16, 18]

cnt = 0
while size > 0:
    result += array[cnt]
    size -= 1
    cnt += 1

print(result)
