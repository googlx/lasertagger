import os
import pandas as pd
from tqdm import tqdm

names = ['text', 'decoded', 'reference']
df = pd.read_csv('pred.tsv', sep='\t', header=None, names=names)

df['text'] = df['text'].apply(lambda x: ' '.join(list(x)))
df['reference'] = df['reference'].apply(lambda x: ' '.join(list(x)))

char_dict = {}
with open('vocab.txt', 'r') as f:
    i = 1
    for line in f.readlines():
        char = line.strip()
        char_dict[char] = str(i)
        i += 1

for name in names:
    df[name] = df[name].apply(lambda x: ' '.join([char_dict[char] if char in char_dict.keys() else '0' for char in x.split(' ')]))
    if not os.path.exists(name):
        os.mkdir(name)
    idx = 0
    for data in tqdm(df[name]):
        with open(os.path.join(name, '{0:04d}.txt'.format(idx)), 'w') as f:
            f.write(data)
            idx += 1
