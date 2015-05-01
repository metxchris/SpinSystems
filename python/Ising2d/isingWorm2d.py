"""
Worm Algorithm for 2D Ising model.
By Christopher Wilson.
Written in Python 2.7.

Initialize Algorithm:
    0. Start with empty grid and random worm position.

Worm Algorithm (one mcstep):
    1. Choose random nearest-neighbor site with respect to worm head.
    2. If bond between current position and new position, delete the bond.
       Otherwise, create a new bond using the Boltzmann probability factor.
    3. End mcstep if worm.head == worm.tail.  Otherwise, repeat step 1.
    4. Measure observables.

Notes:
    The worm head is commonly referred to as 'ira', and the worm tail is
    commonly referred to as 'masha', but we will use head and tail here.
"""
from __future__ import division, print_function
import numpy as np
import matplotlib.pyplot as plt
np.random.seed(0)

class Lattice(object):
    def __init__(self, L):
        """
        self.occupied will act as a pointer to either bonds_x or bonds_y.
        """
        self.length = L
        self.bonds_x = np.zeros((L, L), dtype=bool)
        self.bonds_y = np.zeros((L, L), dtype=bool)
        self.occupied = np.zeros((L, L), dtype=bool)


class Worm(object):
    def __init__(self, L):
        self.max_length = L
        self.head = np.zeros(2)
        self.tail = np.zeros(2)

    def ResetPosition(self):
        """
        Returns randomized [i, j] indices of new worm position for both the head and tail.
        """
        new_position = np.random.randint(0, self.max_length, 2)
        self.head = new_position
        self.tail = new_position

    def Diameter(self):
        """
        Gives minimum distance from head to tail, accounting for periodic boundaries.
        """
        diameter_x = min(np.abs(self.head[0]-self.tail[0]), 
                         self.max_length-np.abs(self.head[0]-self.tail[0]))
        diameter_y = min(np.abs(self.head[1]-self.tail[1]), 
                         self.max_length-np.abs(self.head[1]-self.tail[1]))
        return diameter_x + diameter_y


class Observables(object):
    def __init__(self, L, T_range, mcsteps):
        self.L = L #lattice length.
        self.Z = mcsteps #partition function.
        self.T_range = T_range #temperature range.
        self.mean_bonds = np.zeros((L, len(T_range)))
        self.mean_energy = np.zeros((1, len(T_range)))
        self.mean_correlation = np.zeros((L, len(T_range)))
        self.total_iterations = np.zeros((1, len(T_range)))


def ising2d_worm(T_start=2, T_end=2.5, T_step=0.1, mcsteps=10000, L=16):
    """
    temp = temperature [K].
    L = Length of grid.
    """

    def new_head_position(worm, lattice):
        """
        Extract current worm head position indices, 
        then randomly set new worm head position index.
        lattice.occupied points to either lattice.bonds_x or lattice.bonds_y.
        """
        [i, j] = worm.head
        direction = ["Up", "Down", "Left", "Right"][np.random.randint(0, 4)]
        if direction=="Right":
            # use current indices to check for bond
            bond = [i, j]
            site = [0 if i==L-1 else i+1, j]
            lattice.occupied = lattice.bonds_x
        elif direction=="Left":
            # use new indices to check for bond
            site = [L-1 if i==0 else i-1, j]
            bond = [site[0], site[1]]
            lattice.occupied = lattice.bonds_x
        elif direction=="Up":
            # use current indices to check for bond
            bond = [i, j]
            site = [i, 0 if j==L-1 else j+1]
            lattice.occupied = lattice.bonds_y
        elif direction=="Down":
            # use new indices to check for bond
            site = [i, L-1 if j==0 else j-1]
            bond = [site[0], site[1]]
            lattice.occupied = lattice.bonds_y
        return bond, site, lattice

    def accept_movement(current_bond, temperature):
        """
        Bond creation/deletion using Boltzman factor.
        Bonds are always deleted since 1/exp(-2/T) > 1 for all T>0.
        """
        accept_probability = 1 if current_bond else np.exp(-2/temperature)
        return True if np.random.rand()<accept_probability else False

    def monte_carlo_step(lattice, worm, temperature):
        """
        Since the lattice matrix is indexed as [column, row], we need to input the 
        i, j indices in reversed order, as lattice.bond.occupied[j, i].
        """
        step_correlation = np.zeros(L+1, dtype=np.int32)
        worm.ResetPosition()
        # loop until worm head and tail meet (when step_correlation[0]==1).
        while not step_correlation[0]:
            # propose head movement; [i, j] = new bond indices.
            [i, j], new_site, lattice = new_head_position(worm, lattice)
            if accept_movement(lattice.occupied[j, i], temperature):
                # move worm head and flip the bond.
                worm.head = new_site
                lattice.occupied[j, i] = not lattice.occupied[j, i]
            step_correlation[worm.Diameter()] = 1
        return lattice, worm, step_correlation

    # initialize observables and lattice.
    print('Initializing Worm Algorithm.')
    T_range = np.linspace(T_start, T_end, int((T_end-T_start)/T_step+1))
    lattice, worm, observables = Lattice(L), Worm(L), Observables(L, T_range, mcsteps)
    correlation = np.zeros((L+1, len(T_range)), dtype=np.int32)
    bond_count = np.zeros(len(T_range))
    bond_count2 = np.zeros(len(T_range))

    print('Starting thermalization cycle ...')
    for step in range(int(mcsteps/5)):
        lattice, worm, step_correlation = monte_carlo_step(lattice, worm, T_start)

    print('Starting measurement cycle ...')
    for T_idx, T in enumerate(T_range):
        print("  ", "Starting temperature =", T, "...")
        for step in range(mcsteps):
            lattice, worm, step_correlation = monte_carlo_step(lattice, worm, T)
            # measure observables
            correlation[:, T_idx] += step_correlation
            bond_count[T_idx] += lattice.bonds_x.sum()+lattice.bonds_y.sum()
            bond_count2[T_idx] += (lattice.bonds_x.sum()+lattice.bonds_y.sum())**2

    # average and store observables.
    observables.total_iterations = correlation.sum(axis=1)
    observables.mean_bonds = bond_count/(observables.Z*L**2)
    observables.mean_bonds2 = bond_count2/(observables.Z*L**4)
    observables.mean_energy = -2*(1-observables.mean_bonds)
    observables.mean_energy2 = 4*(1-observables.mean_bonds2)
    observables.specific_heat = 4*(observables.mean_bonds2 - observables.mean_bonds**2)*(L/T_range)**2
    observables.mean_correlation = correlation/observables.Z
    #print("Temparture range = ",T_range)
    #print("Mean bonds / temperature = ", mean_bonds/temperature)
    print("Mean energy =", observables.mean_energy)
    print("Mean energy2 =", observables.mean_energy2)
    print("Specific heat =", observables.specific_heat)
    #print("g(|i-j|) =", correlation/observables.Z)
    return lattice, worm, observables

def plot_bond_lattice(lattice, worm, observables):
    """
    Displays the bond lattice corresponding to the most recent temperature used.
    """
    # create bond grid for plotting
    line_range = np.linspace(0, lattice.length, lattice.length+1)
    x_grid, y_grid = np.meshgrid(line_range, line_range)
    # convert boolean bond data to numeric arrays for plotting.
    xh = x_grid[lattice.bonds_x].flatten()
    yh = y_grid[lattice.bonds_x].flatten()
    xv = x_grid[lattice.bonds_y].flatten()
    yv = y_grid[lattice.bonds_y].flatten()
    h_bonds = np.hstack((np.vstack((xh, xh+1)), np.vstack((xv, xv))))
    v_bonds = np.hstack((np.vstack((yh, yh)), np.vstack((yv, yv+1))))
    # initialize figure.
    fig = plt.figure(figsize=(10, 10))
    ax = plt.axes(xlim=(0, lattice.length), ylim=(0, lattice.length))
    ax.set_title(r'$T = %.2f,\;\langle N_b \rangle = %.1f,\;\langle H \rangle = %.3f$' 
        % (observables.T_range[-1], observables.mean_bonds[-1], observables.mean_energy[-1]),
        fontsize=16, position=(0.5,-0.085))
    plt.subplots_adjust(bottom=0.1, top=0.96, right=0.96, left=0.04)
    # create grid (gray lines).
    plt.plot(x_grid, y_grid, c='#dddddd', lw=1)
    plt.plot(y_grid, x_grid, c='#dddddd', lw=1)
    # plot bond lines.
    plt.plot(h_bonds, v_bonds, 'r', lw=3)
    # plot worm head and tail.
    plt.plot(worm.tail[0], worm.tail[1], 'bs', ms=10)
    plt.plot(worm.head[0], worm.head[1], 'g>', ms=15)
    # disable clipping to show periodic bonds.
    for o in fig.findobj():
        o.set_clip_on(False)

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

def plot_loglog(observables):
    """loglog plot for finding critical exponents."""
    from matplotlib import rcParams # for turning off legend frame
    from matplotlib.widgets import Slider
    from scipy import stats

    fig = plt.figure(figsize=(6,4.5))
    ax = fig.add_subplot(111)
    # make room for slider
    plt.subplots_adjust(bottom=0.20, top=0.9, right=0.95, left=0.15)
    ax.set_xlabel('$\log\,r_{ij}$', fontsize=14)
    ax.set_ylabel('$\\rm \log\,g\\left(r_{ij}\\right)$', fontsize=14)
    digits = int(np.log10(observables.Z))
    ax.set_title(r'$\rm{\bf Ising\,2D:}\,%s^2 Grid,\,%.1f\!\times 10^{%u}MCSteps$'
        % (observables.L, observables.Z/(10**digits), digits),
        fontsize=14, loc=('center'))
    # use only nonzero correlation values for fitting.
    lattice_range = np.linspace(1, observables.L+1, observables.L)
    correlation_function = observables.mean_correlation[1:,-1]
    r = np.log(lattice_range[correlation_function>0])
    y = np.log(correlation_function[correlation_function>0])
    # plot correlation function.
    correlation_plot = ax.plot(r, y, 'o', markersize=6, color='b')[0]
    # initialize least squares fit plot.
    least_squares_fit = ax.plot([], [], '-r', label='y=mx+b')[0]
    rcParams['legend.frameon'] = 'False'
    # create index slider
    slider_axes = plt.axes([0.2, 0.03, 0.7, 0.03], axisbg='lightgoldenrodyellow')
    idx_slider = Slider(slider_axes, '$r_{max}$', 3, len(y), valinit=len(y), 
        facecolor='b', valfmt ='%u')

    def slider_update(val):
        # keep slider value to 3 decimal places
        r_idx = int(val)
        correlation_plot.set_xdata(r[0:r_idx])
        correlation_plot.set_ydata(y[0:r_idx])
        # least squares fit using scipy package.
        fit_data = stats.linregress(correlation_plot.get_xdata(), correlation_plot.get_ydata())
        slope, intercept, r_value = fit_data[0], fit_data[1], fit_data[2]
        #fit_annotation.set_text(r'$\rm{Fit:}\; \beta = %.3f,\;r^2 = %.3f$' % (slope, r_value**2))
        least_squares_fit.set_label(r'$\rm{Fit:}\; \xi = %.3f,\;r^2 = %.3f$'
            % (slope, r_value**2))
        # plot least squares fit.
        least_squares_fit.set_ydata((slope*correlation_plot.get_xdata()+intercept))
        least_squares_fit.set_xdata(correlation_plot.get_xdata())
        # set new axes bounds.
        ax.set_xlim(min(correlation_plot.get_xdata()), max(correlation_plot.get_xdata()))
        ax.set_ylim(min(correlation_plot.get_ydata()), max(correlation_plot.get_ydata()))
        # refresh figure.
        ax.legend(loc='lower left')
        fig.canvas.draw_idle()
    
    idx_slider.on_changed(slider_update) # set slider callback function.
    slider_update(len(y)) # initialize plot
    plt.show()

if __name__ == '__main__':
    lattice, worm, observables = ising2d_worm()
    #plot_bond_lattice(lattice, worm, observables)
    #plot_observables(observables)
    #plot_loglog(observables)
    #plt.show()
    