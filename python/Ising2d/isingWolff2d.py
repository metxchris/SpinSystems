from __future__ import division, print_function
import numpy as np
from random import random
from sys import setrecursionlimit
# Python 2.7.9 (64bit) crashes on me when trying to exceed this threshold.
setrecursionlimit(3000) 

#Simulation Options; Tc = 2/np.log(1+np.sqrt(2)).
T_start, T_end, T_step = 1, 4, 0.1
L, mcsteps = 16, 5000

#Output File Name
output_name = 'isingWolff2d_16x5000'


class Lattice(object):
    def __init__(self, L, T_range):
        """
        self.spins stores the final lattice configuration for each T in T_range.
        """
        self.L = L
        self.spins = np.ones((L, L, len(T_range)))
        self.InitializeSpins(T_range[0])

    def InitializeSpins(self, T_start):
        if T_start>2:
            print('Using random spins for initial lattice.')
            initial_array = np.random.random_integers(0, 1, (self.L, self.L))
            initial_array[initial_array==0] = -1
            self.spins[:,:,-1] = initial_array
        else:
            print('Using ordered spins for initial lattice.')


class Observables(object):
    def __init__(self, L, T_range, mcsteps):
        self.L = L #lattice length.
        self.Z = mcsteps #partition function.
        self.mcsteps = mcsteps #monte carlo steps.
        self.T_range = T_range #temperature range.
        self.mean_energy = np.zeros((2, len(T_range)))
        self.mean_magnetization = np.zeros((2, len(T_range)))
        self.specific_heat = np.zeros_like(len(T_range))
        self.susceptibility = np.zeros_like(len(T_range))

    def AverageObservables(self):
        """
        Note that mean_magnetization[0, :] = <|M|> and not |<M>|, but this is
        the best we can do for the Wolff algorithm.  Likewise, the susceptibility
        definition here is slighly different from the metropolis definition.
        Otherwise, mean_magnetization[1, :] should work out to be the same
        as given by the metropolis algorithm.
        """
        L, T_range, Z = self.L, self.T_range, self.Z
        # average and normalize observables per spin.
        self.mean_energy /= (Z*L**2)
        self.mean_magnetization /= (Z*L**2)
        self.specific_heat = (self.mean_energy[1, :]
                                 - (self.mean_energy[0, :]*L)**2)/T_range**2
        self.susceptibility = (self.mean_magnetization[1, :]
                                 - (self.mean_magnetization[0, :]*L)**2)/T_range


def ising2d_wolff(T_range, mcsteps, L):
    """T = temperature [K].  L = Length of grid."""

    def try_add(x, y, spin, cluster, cluster_spin):
        """Add to cluster with probability 1 - exp(-2J/T)."""
        if spin[y, x] == cluster_spin and random() < probability_add:
            spin, cluster = grow_cluster(x, y, spin, cluster, cluster_spin)
        return spin, cluster

    def grow_cluster(x, y, spin, cluster, cluster_spin):
        """Functional approach to Wolff algorithm."""
        # mark the spin as belonging to the cluster.
        cluster[y, x] = True
        # assume periodic boundary.
        x_prev = L-1 if x==0   else x-1
        x_next = 0   if x==L-1 else x+1
        y_prev = L-1 if y==0   else y-1
        y_next = 0   if y==L-1 else y+1
        # check neighbors.
        if not cluster[y, x_prev]: 
            spin, cluster = try_add(x_prev, y, spin, cluster, cluster_spin)
        if not cluster[y, x_next]:
            spin, cluster = try_add(x_next, y, spin, cluster, cluster_spin)
        if not cluster[y_prev, x]:
            spin, cluster = try_add(x, y_prev, spin, cluster, cluster_spin)
        if not cluster[y_next, x]:
            spin, cluster = try_add(x, y_next, spin, cluster, cluster_spin)
        return spin, cluster

    def monte_carlo_step(L, spins_T, probability_add):
        cluster = np.zeros((L, L), dtype=bool) 
        # choose a random spin and grow a cluster.
        x, y = np.random.randint(0, L, 2)
        spins_T, cluster = grow_cluster(x, y, spins_T, cluster, spins_T[y, x])
        # flip the cluster
        spins_T[cluster] *= -1
        return spins_T

    # initialize main structures.
    observables = Observables(L, T_range, mcsteps)
    lattice = Lattice(L, T_range)
    # magnetization, energy, and spins each act as a pointer.
    magnetization = observables.mean_magnetization
    energy = observables.mean_energy
    spins = lattice.spins

    print ('Starting thermalization cycle ...')
    probability_add = 1 - np.exp(-2/T_range[0]) # define Boltzmann Criterion
    for step in range(int(mcsteps/5)):
        spins[:, :, -1] = monte_carlo_step(L, spins[:,:,-1], probability_add)

    print ('Starting measurement cycle ...')
    for T_idx, T in enumerate(T_range):
        spins[:, :, T_idx] = spins[:, :, T_idx-1]
        probability_add = 1 - np.exp(-2/T) # define Boltzmann Criterion
        print('  Running temperature =', T, '...')
        for step in range(mcsteps):
            spins[:, :, T_idx] = monte_carlo_step(L, spins[:,:,T_idx], probability_add)
            # Measure observables (vectorized).
            left_spins = np.roll(spins[:,:,T_idx], 1, axis=1)
            lower_spins = np.roll(spins[:,:,T_idx], 1, axis=0)
            E = -np.sum(spins[:,:,T_idx]*(left_spins+lower_spins))
            M = np.sum(spins[:,:,T_idx])
            energy[:, T_idx] += E, E**2
            magnetization[:, T_idx] += abs(M), M**2
        
    # average and store observable measurements.
    observables.AverageObservables()

    print('  Simulation Complete!')
    return observables, lattice

def save_output(output_name, observables, lattice):
    """
    Save observables and lattice to pickle files.
    The isfile checks will return an error if either one fails.
    """
    import cPickle as pickle
    from os.path import isfile
    observables_file = ((r'data\%s.pkl') % (output_name))
    with open(observables_file, 'wb') as output:
        pickle.dump(observables, output, pickle.HIGHEST_PROTOCOL)
    if isfile(observables_file):
        print('Observables saved to: %s' % (observables_file))
    lattice_file = ((r'data\%s_lattice.pkl') % (output_name))
    with open(lattice_file, 'wb') as output:
        pickle.dump(lattice, output, pickle.HIGHEST_PROTOCOL)
    if isfile(lattice_file):
        print('Lattice saved to: %s' % (lattice_file))

def main():
    T_range = np.arange(T_start, T_end+T_step, T_step)
    observables, lattice = ising2d_wolff(T_range, mcsteps, L)
    save_output(output_name, observables, lattice)

if __name__ == '__main__':
    main()
