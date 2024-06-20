def sum(**kwargs):
    str1 = ''
    sum = 0
    tax = 13
    for k,x in kwargs.items():
        str1 += ('{}:{}\n'.format(k,x))
        sum += x
    total = sum * (tax / 100 +1)
    return str1, ('subtotal{}'.format(round(sum,2))), round(total,2)
res = sum(coffee=2.99, cake=4.55, juice=2.99)
for i in res:
    print(i)


