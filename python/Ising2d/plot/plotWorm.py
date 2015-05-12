"""
plot data from isingWorm2d.py
"""
from __future__ import division, print_function
import cPickle as pickle # for reading/writing data to text files.
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.widgets import Slider
from matplotlib import rcParams # for turning off legend frame
from scipy import stats

input_name = 'pottsWorm2d_highT'

#need to create an empty classes with the sames name as used in the pickle file.
class Lattice(object): pass
class Worm(object): pass
class Observables(object): pass


def load_data():
    import cPickle as pickle

    observables_file = ((r'..\data\%s.pkl') % (input_name))
    lattice_file = ((r'..\data\%s_lattice.pkl') % (input_name))
    worm_file = ((r'..\data\%s_worm.pkl') % (input_name))

    observables = pickle.load(open(observables_file, 'rb'))
    lattice = pickle.load(open(lattice_file, 'rb'))
    worm = pickle.load(open(worm_file, 'rb'))
    return lattice, worm, observables


def plot_correlation_loglog(observables):
    """
    Currently only the Worm algorithm measures correlation data.
    """
    fig = plt.figure(figsize=(6,5))
    ax = fig.add_subplot(111)
    # make room for slider
    plt.subplots_adjust(bottom=0.22, top=0.9, right=0.95, left=0.15)
    ax.set_xlabel('$\log\,r_{ij}$', fontsize=14)
    ax.set_ylabel('$\\rm \log\,g\\left(r_{ij}\\right)$', fontsize=14)
    digits = int(np.log10(observables.Z[-1]))
    ax.set_title(r'$\rm{\bf Ising\,2D:}\,%s^2 Grid,\,%.1f\!\times 10^{%u}MCSteps$'
        % (observables.L, observables.Z[-1]/(10**digits), digits),
        fontsize=14, loc=('center'))
    r_range = np.linspace(1, observables.L+1, observables.L)
    correlation = observables.correlation
    #correlation = np.cumsum(correlation[::-1], axis=0)[::-1]
    # initialize correlation function plot.
    correlation_plot = ax.plot([], [], 'o', markersize=6, color='b')[0]
    # initialize least squares fit plot.
    least_squares_fit = ax.plot([], [], '-r', label='y=mx+b')[0]
    rcParams['legend.frameon'] = 'False'
    # create position index slider
    r_max = len(np.log(correlation[correlation[:, -1]>0, -1]))
    slider_axes = plt.axes([0.2, 0.03, 0.7, 0.03], axisbg='lightgoldenrodyellow')
    r_slider = Slider(slider_axes, '$r_{max}$', 3, r_max, valinit=r_max, 
        facecolor='b', valfmt ='%u')
    # create temperature index slider
    T_range = observables.T_range
    slider_axes = plt.axes([0.2, 0.07, 0.7, 0.03], axisbg='lightgoldenrodyellow')
    T_slider = Slider(slider_axes, '$T$', 1, len(T_range), valinit=len(T_range), 
        facecolor='b', valfmt ='%u')
    
    def slider_update(value):
        r_idx, T_idx = int(r_slider.val), int(T_slider.val)-1
        correlation_function = correlation[1:,T_idx]/correlation[0,T_idx]
        # use only nonzero correlation values for fitting
        r = np.log(r_range[correlation_function>0])
        y = np.log(correlation_function[correlation_function>0])
        correlation_plot.set_xdata(r[0:r_idx])
        correlation_plot.set_ydata(y[0:r_idx])
        # least squares fit using scipy package.
        fit_data = stats.linregress(correlation_plot.get_xdata(), correlation_plot.get_ydata())
        slope, intercept, r_value = fit_data[0], fit_data[1], fit_data[2]
        least_squares_fit.set_label(r'${\rmFit:}\; m = %.3f,\;r^2 = %.3f,\;T=%.3f$'
            % (slope, r_value**2, T_range[T_idx]))
        # plot least squares fit.
        least_squares_fit.set_ydata((slope*correlation_plot.get_xdata()+intercept))
        least_squares_fit.set_xdata(correlation_plot.get_xdata())
        # set new axes bounds.
        ax.set_xlim(min(correlation_plot.get_xdata()), max(correlation_plot.get_xdata()))
        ax.set_ylim(min(correlation_plot.get_ydata()), max(correlation_plot.get_ydata()))
        # refresh figure.
        ax.legend(loc='lower left')
        fig.canvas.draw_idle()
    
    r_slider.on_changed(slider_update) # set slider callback function.
    T_slider.on_changed(slider_update) # set slider callback function.
    slider_update(True) # initialize plot
    plt.show()

def plot_bond_lattice(lattice, worm, observables):
    """
    Displays the bond lattice corresponding to the most recent temperature used.
    """
    # create bond grid for plotting
    line_range = np.linspace(0, lattice.L, lattice.L+1)
    x_grid, y_grid = np.meshgrid(line_range, line_range)


    # initialize figure.
    fig = plt.figure(figsize=(9, 9))
    ax = plt.axes(xlim=(0, lattice.L), ylim=(0, lattice.L))
    ax.set_xlabel(r'$T = %.2f,\;\langle H \rangle = %.3f$' 
        % (observables.T_range[-1],  observables.mean_energy[0, -1]),
        fontsize=16, position=(0.5,-0.085))
    plt.subplots_adjust(bottom=0.1, top=0.96, right=0.96, left=0.04)
    # create grid (gray lines).
    plt.plot(x_grid, y_grid, c='#dddddd', lw=1)
    plt.plot(y_grid, x_grid, c='#dddddd', lw=1)
    ax.set_title(r'$\rm{\bf High\ Temperature\ Domain\!\ }$',
            fontsize=14, loc=('center'))
    # convert boolean bond data to numeric arrays for plotting.
    colors = ['aquamarine', 'midnightblue', 'skyblue', 'blueviolet', 'cadetblue', 'cornflowerblue', 'coral', 'firebrick', 'purple']
    #colors = ['azure']*8

    # plot bond lines.
    cm = plt.get_cmap('jet')
    #ax.set_color_cycle([cm(1.*i/(worm.q-1)) for i in range(worm.q-1)])
    for i in range(1, 2):
        xh = x_grid[lattice.bonds[0]==i].flatten()
        yh = y_grid[lattice.bonds[0]==i].flatten()
        xv = x_grid[lattice.bonds[1]==i].flatten()
        yv = y_grid[lattice.bonds[1]==i].flatten()
        h_bonds = np.hstack((np.vstack((xh, xh+1)), np.vstack((xv, xv))))
        v_bonds = np.hstack((np.vstack((yh, yh)), np.vstack((yv, yv+1))))
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
        ylim=(observables.mean_energy[0, 0], observables.mean_energy[0, -1]))
    ax.set_xlabel("Temperature [K]")
    ax.set_ylabel("Energy [$k_b$]")
    digits = int(np.log10(observables.mcsteps))
    ax.set_title(r'$\rm{\bf Ising\,2D:}\,%s^2 Grid,\,%.1f\!\times 10^{%u}MCSteps$'
        % (observables.L, observables.mcsteps/(10**digits), digits),
        fontsize=14, loc=('center'))
    plt.subplots_adjust(bottom=0.15, top=0.9, right=0.95, left=0.15)
    ax.plot(observables.T_range, observables.mean_energy[0, :], 'bo')

def main():
    lattice, worm, observables = load_data()
    #plot_correlation_loglog(observables)
    plot_bond_lattice(lattice, worm, observables)
    #plot_observables(observables)
    plt.show()

if __name__ == '__main__':
    main()
