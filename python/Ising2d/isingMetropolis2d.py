"""
Metropolis Algorithm for 2D Ising model.
By Christopher Wilson.
Written in Python 2.7.
"""
from __future__ import division, print_function
import numpy as np
from random import random

#Simulation Options; Tc = 2/np.log(1+np.sqrt(2)).
T_start, T_end, T_step = 2.269, 2.269, 1
L, mcsteps = 64, 1000

#Output File Name
output_name = 'isingMetro2d_64x1000'


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
        L, T_range, Z = self.L, self.T_range, self.Z
        # average and normalize observables per spin.
        self.mean_energy /= (Z*L**2)
        self.mean_magnetization /= (Z*L**2)
        self.specific_heat = (self.mean_energy[1, :]
                                 - (self.mean_energy[0, :]*L)**2)/T_range**2
        self.susceptibility = (self.mean_magnetization[1, :]
                                 - (self.mean_magnetization[0, :]*L)**2)/T_range


def ising2d_metropolis(T_range, mcsteps, L):
    """T = temperature [K].  L = Length of grid."""

    def compute_mcsteps(spin_T, L, T, mcsteps):
        """
        The variable notation 'observable_T' denotes that quantity's value as per the
        given temperature.  The spin array is referenced with indices in reverse order 
        (j, i) to make the lattice plotting process easier.
        """
        energy_T, magnetization_T = np.zeros((2)), np.zeros((2))
        for one_mcstep in range(mcsteps):
            random_sites = np.random.randint(0, L, size=(L**2, 2))
            # each mcstep performs L**2 updates on the square spin_T lattice.
            for micro_step in range(L**2):
                # Randomly choose a site on the grid.
                [i, j] = random_sites[micro_step, :]
                # Get neighbor indices, accounting for periodic boundaries.
                i_prev = L-1 if i==0   else i-1
                i_next = 0   if i==L-1 else i+1
                j_prev = L-1 if j==0   else j-1
                j_next = 0   if j==L-1 else j+1
                # Calculate the proposed change in energy.
                delta_energy = 2*spin_T[j, i]*(spin_T[j, i_prev] + spin_T[j, i_next] +
                                                spin_T[j_prev, i] + spin_T[j_next, i])
                # Spin flip condition, the exp term is the Boltzmann factor.
                if delta_energy<=0 or np.exp(-delta_energy/T)>random():
                    spin_T[j, i] = -spin_T[j, i]
            # vectorized approach to measuring observables.
            left_spin = np.roll(spin_T, -1, axis=1)
            lower_spin = np.roll(spin_T, 1, axis=0)
            E = -np.sum(spin_T*(left_spin+lower_spin))
            M = np.sum(spin_T)
            energy_T += E, E**2
            magnetization_T += M, M**2
        return spin_T, np.abs(magnetization_T), energy_T

    # initialize main structures.
    observables = Observables(L, T_range, mcsteps)
    lattice = Lattice(L, T_range)
    # magnetization, energy, and spins each act as a pointer.
    magnetization = observables.mean_magnetization
    energy = observables.mean_energy
    spins = lattice.spins

    print ('Starting thermalization cycle ...')
    spins[:, :, -1], magnetization[:, -1], energy[:, -1] = \
        compute_mcsteps(spins[:, :, -1], L, T_range[0], mcsteps)

    print ('Starting measurement cycle ...')
    for T_idx, T in enumerate(T_range):
        print('  Running temperature =', T, '...')
        spins[:, :, T_idx], magnetization[:, T_idx], energy[:, T_idx] = \
            compute_mcsteps(spins[:, :, T_idx-1], L, T, mcsteps)

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
    observables, lattice = ising2d_metropolis(T_range, mcsteps, L)
    save_output(output_name, observables, lattice)

if __name__ == '__main__':
    main()
