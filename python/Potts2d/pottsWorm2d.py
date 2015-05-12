"""
Worm Algorithm for 2D Ising model.
By Christopher Wilson.
Written in Python 2.7.
Algorithm adapted from: http://www.sciencedirect.com/science/article/pii/S0550321308005609
Original Paper: http://journals.aps.org/prl/pdf/10.1103/PhysRevLett.87.160601

Other references:
    Slides - http://pitp.physics.ubc.ca/confs/sherbrooke/archives/pitpcifar_sherbrooke2008_worm_boninsegni.pdf
    Slides - http://physics.bu.edu/py502/slides/l17.pdf
    Analytic Paper - http://johnkerl.org/rcm/doc/ch7.pdf
    rapid mixing - http://arxiv.org/pdf/1409.4484v1.pdf
    bond algorithm - http://journals.aps.org/prb/pdf/10.1103/PhysRevB.27.4445
    geometrical worm - http://www.sciencedirect.com/science/article/pii/S1875389211003300

Initialize Algorithm:
    0. Start with empty grid and random worm position.

Worm Algorithm (one mcstep):
    1. Choose random nearest-neighbor site with respect to worm head.
    2. If bond between current position and new position, delete the bond.
       Otherwise, create a new bond using the Boltzmann probability factor.
    3. Add to Z if worm.head == worm.tail and measure observables.  
    4. Always add to correlation function.
    5. Repeat

Notes:
    The worm head is commonly referred to as 'ira', and the worm tail is
    commonly referred to as 'masha', but we will use head and tail here.
"""
from __future__ import division, print_function
import numpy as np

#Simulation Options; Tc = 2/np.log(1+np.sqrt(q)).
T_start, T_end, T_step = 1, 3, 0.1
q, L, mcsteps = 2, 16, 50

#Output File Name
output_name = 'pottsWorm2d_test'


class Lattice(object):
    def __init__(self, L):
        """
        Changed from isingWorm2d.py: bonds[0] = bonds_x, bonds[1] = bonds_y.
        All bonds are initialized as off, as opposed to the metropolis/wolff case.
        """
        self.L = L
        self.bonds = np.zeros((2, L, L))
        self.occupied = np.zeros((L, L))


class Worm(object):
    def __init__(self, q, L):
        self.max_length = L
        self.q = q #number of different bond types.
        self.head = np.zeros(2)
        self.tail = np.zeros(2)

    def ResetPosition(self):
        """
        Returns randomized [i, j] indices of new worm position 
        for both the head (ira) and tail (masha).
        """
        new_position = np.random.randint(0, self.max_length, 2)
        self.head = new_position
        self.tail = new_position

    def Diameter(self):
        """
        Gives minimum distance from head to tail, 
        accounting for periodic boundaries.
        """
        diameter_x = min(np.abs(self.head[0]-self.tail[0]), 
                         self.max_length-np.abs(self.head[0]-self.tail[0]))
        diameter_y = min(np.abs(self.head[1]-self.tail[1]), 
                         self.max_length-np.abs(self.head[1]-self.tail[1]))
        return diameter_x + diameter_y


class Observables(object):
    def __init__(self, q, L, T_range, mcsteps):
        self.q = q #number of spins.
        self.L = L #lattice length.
        self.Z = [] #partition function (Z != mcsteps for worm algorithm).
        self.mcsteps = mcsteps #monte carlo steps.
        self.T_range = T_range #temperature range.
        self.correlation = np.zeros((L+1, len(T_range)))
        self.correlation2 = np.zeros((L+1, len(T_range)))
        self.mean_bonds = np.zeros((2, len(T_range)))
        self.mean_energy = np.zeros((2, len(T_range)))
        self.mean_magnetization = np.zeros((2, len(T_range)))
        self.specific_heat = np.zeros_like(len(T_range))
        self.susceptibility = np.zeros_like(len(T_range))

    def AverageObservables(self):
        L, T_range, Z = self.L, self.T_range, self.correlation[0, :]
        # average and normalize observables per spin.
        self.Z = Z
        self.mean_bonds /= (Z*L**2)
        self.mean_energy[0, :] = -2*(1-self.mean_bonds[0, :])
        self.mean_magnetization[1, :] = 1-(Z*L**2/np.sum(self.correlation, axis=0))**-1
        self.specific_heat = 4*(self.mean_bonds[1, :]
                                -(self.mean_bonds[0, :]*L)**2)/T_range**2
        self.susceptibility = (self.mean_magnetization[1, :]
                                 - (self.mean_magnetization[0, :]*L)**2)/T_range


def ising2d_worm(T_range, mcsteps, L):
    #T_start = T_end = 2/np.log(1 + np.sqrt(2))
    """T = temperature [K]; L = Length of grid."""

    def new_head_position(worm, lattice):
        """
        Extract current worm head position indices, 
        then randomly set new worm head position index.
        lattice.occupied points to either lattice.bonds_x or lattice.bonds_y.
        """
        [i, j] = worm.head
        bond_type = np.random.randint(0, worm.q)
        direction = ["Up", "Down", "Left", "Right"][np.random.randint(0, 4)]
        if direction=="Right":
            # use current indices to check for bond
            bond = [i, j]
            site = [0 if i==L-1 else i+1, j]
            lattice.occupied = lattice.bonds[0]
        elif direction=="Left":
            # use new indices to check for bond
            site = [L-1 if i==0 else i-1, j]
            bond = [site[0], site[1]]
            lattice.occupied = lattice.bonds[0]
        elif direction=="Up":
            # use current indices to check for bond
            bond = [i, j]
            site = [i, 0 if j==L-1 else j+1]
            lattice.occupied = lattice.bonds[1]
        elif direction=="Down":
            # use new indices to check for bond
            site = [i, L-1 if j==0 else j-1]
            bond = [site[0], site[1]]
            lattice.occupied = lattice.bonds[1]
        return bond, bond_type, site, lattice

    def accept_movement(current_bond, bond_type, temperature):
        """
        Bond creation/deletion using Boltzman factor.
        Bonds are always deleted since 1/exp(-2/T) > 1 for all T>0.
        """
        accept_probability = 1 if current_bond==bond_type else np.exp(-2/temperature)
        return True if np.random.rand()<accept_probability else False

    def monte_carlo_step(lattice, worm, temperature):
        """
        Since the lattice matrix is indexed as [column, row], we need to input the 
        i, j indices in reversed order, as lattice.bond.occupied[j, i].  

        Measured quantities per step:
        Nb_step = number of bonds per step.
        G_micro = 2pt correlation function per micro_step corresponding to the 
            partition function of the worm algorithm for the 2D Ising model.
        G_step = 2pt correlation function per step corresponding to the partition
            function of the metropolis algorithm for the 2D Ising model.
        * Note that G_micro(|i-j|) == G_step(|i-j|) when |i-j|=0.
        """
        Nb_step = np.zeros((2))
        G_micro, G_step = np.zeros((L+1)), np.zeros((L+1))
        G_step_bool = np.zeros((L+1), dtype=bool)
        Bq = np.zeros((worm.q))
        for micro_step in range(2*L**2):
            # propose head movement; [i, j] = new bond indices.
            [i, j], bond_type, new_site, lattice = new_head_position(worm, lattice)
            if accept_movement(lattice.occupied[j, i], bond_type, temperature):
                # move worm head and flip the bond.
                worm.head = new_site
                lattice.occupied[j, i] = bond_type
            # Update correlation function every microstep.
            diameter = worm.Diameter()
            G_micro[diameter] += 1
            G_step_bool[diameter] = True
            if np.all(worm.head==worm.tail):
                # measure observables and reset worm when path is closed.
                G_step[G_step_bool] += 1
                G_step_bool[:] = False
                for i in range(worm.q):
                    Bq[i] = (lattice.bonds==i).sum()
                B = max(Bq)
                Nb_step += B, B**2
                worm.ResetPosition()
        return lattice, worm, G_micro, G_step, Nb_step

    # initialize main structures.
    print('Initializing Worm Algorithm.')
    observables = Observables(q, L, T_range, mcsteps)
    lattice = Lattice(L)
    worm = Worm(q, L)
    # correlation, correlation2, and bond_number each act as a pointer.
    correlation = observables.correlation #relates to G_micro
    correlation2 = observables.correlation2 #relates to G_step
    bond_number = observables.mean_bonds #relates to Nb_step

    print('Starting thermalization cycle ...')
    for step in range(int(mcsteps/5)):
        lattice, worm, G_micro, G_step, Nb_step = monte_carlo_step(lattice, worm, T_range[0])

    print('Starting measurement cycle ...')
    for T_idx, T in enumerate(T_range):
        print("  ", "Running temperature =", T, "...")
        for step in range(mcsteps):
            lattice, worm, G_micro, G_step, Nb_step = monte_carlo_step(lattice, worm, T)
            # sum observables
            correlation[:, T_idx] += G_micro
            correlation2[:, T_idx] += G_step
            bond_number[:, T_idx] += Nb_step

    # average and store observables.
    observables.AverageObservables()

    print('Simulation Complete!')
    return observables, lattice, worm

def save_output(output_name, observables, lattice, worm):
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
    worm_file = ((r'data\%s_worm.pkl') % (output_name))
    with open(lattice_file, 'wb') as output:
        pickle.dump(worm, output, pickle.HIGHEST_PROTOCOL)
    if isfile(worm_file):
        print('Worm saved to: %s' % (worm_file))

def main():
    T_range = np.arange(T_start, T_end+T_step, T_step)
    observables, lattice, worm = ising2d_worm(T_range, mcsteps, L)
    save_output(output_name, observables, lattice, worm)

if __name__ == '__main__':
    main()
    