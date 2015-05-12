import numpy as np 
np.random.seed(0)
L = 8
q = 2
Bq = np.zeros((q))

if 0:
    bonds_x, bonds_y = np.random.randint(0, q, (L, L)), np.random.randint(0, q, (L, L))
    for i in range(q):
        Bq[i] = (bonds_x==i).sum()+(bonds_y==i).sum()
    B = max(Bq)
    print(bonds_x)
    print(bonds_y)
    print(Bq, B)

if 1:
    print(np.random.randint(1, 1))