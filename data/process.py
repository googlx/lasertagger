data = []
with open('test.txt', 'r') as f:
    for line in f.readlines():
        line = line.strip()
        data.append(f'{line}\t{line}')

with open('test.tsv', 'w') as f:
    f.write('\n'.join(data))
