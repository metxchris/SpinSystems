
print ('Starting measurement cycle ...')
for i, temperature in enumerate(T_range):
    energy = energy2 = 0
    spin_array[:, :, i] = spin_array[:, :, i-1]
    probability_add = 1 - np.exp(-2/temperature) # define Boltzmann Criterion
    for step in range(mcsteps):
        spin_array[:, :, i] = monte_carlo_step(temperature, L, spin_array[:,:,i], probability_add)
        # Measure observables (vectorized).
        left_spin = np.roll(spin_array[:,:,i], 1, axis=1)
        lower_spin = np.roll(spin_array[:,:,i], 1, axis=0)
        E = -np.sum(spin_array[:,:,i]*(left_spin+lower_spin))
        energy += E
        energy2 += E**2


print ('Starting measurement cycle ...')
for i, temperature in enumerate(T_range):
    energy = energy2 = 0
    spin_array[:, :, i] = spin_array[:, :, i-1]
    probability_add = 1 - np.exp(-2/temperature) # define Boltzmann Criterion
    for step in range(mcsteps):
        spin_array[:, :, i] = monte_carlo_step(temperature, L, spin_array[:,:,i], probability_add)
        # Measure observables (looped).
        E = 0
        for x in xrange(L):
            for y in xrange(L):
                x_prev = L-1 if x==0   else x-1     
                y_prev = L-1 if y==0   else y-1
                E -= spin[x, y]*(spin[x_prev, y]+spin[x, y_prev])
        energy += E
        energy2 += E**2
        