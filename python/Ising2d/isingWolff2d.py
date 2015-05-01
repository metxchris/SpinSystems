from __future__ import division, print_function
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.widgets import Slider
from random import random
from sys import setrecursionlimit
setrecursionlimit(10000)

class Observables(object):
    def __init__(self, L, T_range, mcsteps):
        self.L = L #lattice length.
        self.Z = mcsteps #partition function.
        self.T_range = T_range #temperature range.
        self.mean_magnetization = np.zeros_like(T_range)
        self.mean_magnetization2 = np.zeros_like(T_range)
        self.mean_energy = np.zeros_like(T_range)
        self.mean_energy2 = np.zeros_like(T_range)
        self.specific_heat = np.zeros_like(T_range)


def ising2d_wolff(T_start=2, T_end=2.5, T_step=0.1, mcsteps=10000, L=16):

    def initialize_spins(L, T_start):
        spin_array = np.ones((L, L, len(T_range)))
        if T_start>2:
            print('Using random spins for initial lattice.')
            spin_array[:,:,-1] = np.random.random_integers(0, 1, (L, L))
            spin_array[spin_array[:,:,-1]==0,-1] = -1
        else:
            print('Using ordered spins for initial lattice.')
        return spin_array

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

    def monte_carlo_step(temperature, L, spin, probability_add):
        cluster = np.zeros((L, L), dtype=bool) 
        # choose a random spin and grow a cluster.
        x, y = np.random.randint(0, L, 2)
        spin, cluster = grow_cluster(x, y, spin, cluster, spin[y, x])
        # flip the cluster
        spin[cluster] *= -1
        return spin

    print('Initializing Wolff Algorithm.')
    T_range = np.linspace(T_start, T_end, int((T_end-T_start)/T_step+1))
    observables = Observables(L, T_range, mcsteps)
    spin_array = initialize_spins(L, T_start)

    print ('Starting thermalization cycle ...')
    probability_add = 1 - np.exp(-2/T_start) # define Boltzmann Criterion
    for step in range(int(mcsteps/5)):
        spin_array[:, :, -1] = monte_carlo_step(T_start, L, spin_array[:,:,-1], probability_add)

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
        # average and store observables.
        observables.mean_energy[i] = energy/(mcsteps*L**2)
        observables.mean_energy2[i] = energy2/(mcsteps*L**4)
        print ('  temperature, mean_energy, mean_energy2 = %.3f, %.4f, %.4f' 
                % (temperature, observables.mean_energy[i], observables.mean_energy2[i]))
    observables.specific_heat = (observables.mean_energy2 - observables.mean_energy**2)*(L/T_range)**2
    print(observables.specific_heat)
    return spin_array, observables

def plot_spin_lattice(spin_array, observables):
    """
    Shows the spin_array for all temperature values.
    """
    T_range = observables.T_range

    fig = plt.figure(figsize=(4.5, 5))
    ax = fig.add_subplot(111)
    plt.subplots_adjust(bottom=0.12, top=1)
    ax.set_title('$\\rm{\\bf Spin\,Lattice:}\;T= %.3f\,\\rm [K]$' % (T_range[-1]),
            fontsize=14, loc=('center'))
    im = ax.imshow(spin_array[:,:,-1], origin='lower', interpolation='none')
    slider_ax = plt.axes([0.2, 0.06, 0.6, 0.03], axisbg='#7F0000')
    spin_slider = Slider(slider_ax, '', 0, len(T_range)-1, len(T_range)-1, 
                            valfmt ='%u', facecolor='#00007F')

    def update(val):
        i = int(val)
        ax.set_title('$\\rm{\\bf Spin\,Lattice:}\;T= %.3f\,\\rm [K]$'
            % (T_range[i]), fontsize=14, loc=('center'))
        im.set_array(spin_array[:,:,i])

    spin_slider.on_changed(update)
    plt.annotate('Temperature Slider', xy=(0.32,0.025), xycoords='figure fraction', fontsize=12)
    plt.show()

def plot_observables(observables):
    fig = plt.figure(figsize=(6, 4))
    ax = fig.add_subplot(111,
        xlim=(observables.T_range[0], observables.T_range[-1]),
        ylim=(observables.mean_energy[0], observables.mean_energy[-1]))
    ax.set_xlabel("Temperature [K]")
    ax.set_ylabel("Energy [$k_b$]")
    digits = int(np.log10(observables.Z))
    ax.set_title(r'$\rm{\bf Ising\,2D:}\,%s^2 Grid,\,%.1f\!\times 10^{%u}MCSteps$'
        % (observables.L, observables.Z/(10**digits), digits),
        fontsize=14, loc=('center'))
    plt.subplots_adjust(bottom=0.15, top=0.9, right=0.95, left=0.15)
    ax.plot(observables.T_range, observables.mean_energy, 'bo')

def main():
    spin_array, observables = ising2d_wolff()
    #plot_spin_lattice(spin_array, observables)
    #plot_observables(observables)
    #plt.show()

if __name__ == '__main__':
    main()
