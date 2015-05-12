"""
For use with data from the 2d ising algorithms.
Still ironing out correlation function details for the worm algorithm.
"""
from __future__ import division, print_function
import numpy as np
import matplotlib.pyplot as plt
import cPickle as pickle # for reading/writing data to text files.
from matplotlib import rcParams # for turning off legend frame

# choose one data set to use by changing the trailing index.
data_type = np.array(["16x5000", "test"])[0]

# choose any number of plots to create by changing the trailing index.
plot_type = np.array([False, "energy", "specific_heat",
                        "magnetization**2", "correlation"])[1]


#need to create an empty class with the same name as used in the pickle file.
class Observables(object): pass


#NaN class to use when algorithm data is not available; i.e., metro = NaN().
class NaN(object):
    def __init__(self):
        nan_array = np.array([[np.nan], [np.nan]])
        self.L = np.nan
        self.Z = np.nan
        self.mcsteps = np.nan
        self.T_range = np.nan
        self.mean_bonds = nan_array
        self.mean_magnetization = nan_array
        self.mean_energy = nan_array
        self.susceptibility = np.nan
        self.specific_heat = np.nan
        self.correlation = nan_array
        self.correlation2 = nan_array


def load_data(data_type):
    if np.any(data_type == "16x5000"):
        worm = pickle.load(open('..\\data\\isingWorm2d_16x5000.pkl', 'rb'))
        wolff = pickle.load(open('..\\data\\isingWolff2d_16x5000.pkl', 'rb'))
        metro = pickle.load(open('..\\data\\isingMetro2d_16x5000.pkl', 'rb'))
    if np.any(data_type == "test"):
        worm = pickle.load(open('..\\data\\pottsWorm2d_q3test.pkl', 'rb'))
        wolff = NaN()
        metro = NaN()
    return worm, wolff, metro

def plot_comparisons(plot_type, worm, wolff, metro):
    correlation = worm.correlation
    #correlation[1:, :] /= 4*np.transpose(np.tile(np.linspace(1, worm.L, worm.L),  (1, 1)))
    #correlation = np.cumsum(worm.correlation[::-1], axis=0)[::-1]

    def create_comparison_figure(ylabel, xlabel):
        fig = plt.figure(figsize=(6, 4))
        ax = fig.add_subplot(111, xlim=(1,4))
        plt.subplots_adjust(bottom=0.12, top=0.92, right=0.95, left=0.12)
        rcParams['legend.frameon'] = 'False'
        ax.set_title(r'$\rm{\bf Ising\ 2D\!\ :}\,Comparison\ of\ Averaged\ Observables$',
            fontsize=14, loc=('center'))
        ax.set_ylabel(ylabel)
        ax.set_xlabel(xlabel)
        return ax

    if np.all(plot_type == False):
        return

    if np.any(plot_type == "energy"):
        ax = create_comparison_figure("Energy", "Temperature")
        ax.plot(wolff.T_range, wolff.mean_energy[0, :], 'o',
            mfc="None", mec='b', mew=2, label=r'$E_{\rm Wolff}\, \sim\,\langle H\rangle$')
        ax.plot(metro.T_range, metro.mean_energy[0, :], 'x',
            mfc="None", mec='m', mew=2, label=r'$E_{\rm Metro}\, \sim\,\langle H\rangle$')
        ax.plot(worm.T_range, worm.mean_energy[0, :], 's',
            mfc="None", mec='r', mew=2, label=r'$E_{\rm Worm}\, \sim\,\langle N_b\rangle$')
        #ax.plot(worm.T_range, 1.5*worm.T_range*np.sum(correlation, axis=0)/(correlation[1,:]*worm.L**2)-2, '^',
        #    mfc="None", mec='g', mew=2, label=r'$E_{\rm Worm}\, \sim\,G(r_{ij})$')
        ax.legend(loc='upper left')

    if np.any(plot_type == "specific_heat"):
        ax = create_comparison_figure("Specific Heat", "Temperature")
        ax.plot(wolff.T_range, wolff.specific_heat, 'o',
            mfc="None", mec='b', mew=2, label=r'$c_{\rm\, Wolff}\, \sim\,(\Delta H)^2$')
        ax.plot(metro.T_range, metro.specific_heat, 'x',
            mfc="None", mec='m', mew=2, label=r'$c_{\rm\, Metro}\, \sim\,(\Delta H)^2$')
        ax.plot(worm.T_range, worm.specific_heat, 's',
            mfc="None", mec='r', mew=2, label=r'$c_{\rm\, Worm}\, \sim\,(\Delta N_b)^2$')
        ax.legend(loc='upper right')

    if np.any(plot_type == "magnetization**2"):
        ax = create_comparison_figure("Magnetization**2", "Temperature")
        ax.plot(wolff.T_range, wolff.mean_magnetization[1, :]/wolff.L**2, 'o',
            mfc="None", mec='b', mew=2, label=r'$\chi_{\rm Wolff}\, \sim\,\langle M^2\!\rangle$')
        ax.plot(metro.T_range, metro.mean_magnetization[1, :]/metro.L**2, 'x',
            mfc="None", mec='m', mew=2, label=r'$\chi_{\rm Metro}\, \sim\,\langle M^2\!\rangle$')
        ax.plot(worm.T_range, 1-(worm.Z*worm.L**2/np.sum(correlation, axis=0))**-1, 's',
            mfc="None", mec='r', mew=2, label=r'$\chi_{\rm Worm}\, \sim\,\langle G(r_{ij})\rangle^{-1}$')
        ax.legend(loc='lower left')

    if np.any(plot_type == "correlation"):
        ax = create_comparison_figure("Two Point Correlation (1)", "radius")
        r_range = np.linspace(0, worm.L, worm.L+1)
        Tc_idx = (np.argmin(np.abs(worm.T_range-2.269)))
        correlation_sum = np.cumsum(worm.correlation[::-1], axis=0)[::-1]
        #correlation = correlation_sum
        #correlation = worm.correlation
        for i, T in enumerate(worm.T_range):
            if i == Tc_idx:
                ax.plot(r_range, correlation[:, i]/worm.correlation[0, i], 'ro')
            else:
                ax.plot(r_range, correlation[:, i]/worm.correlation[0, i], 'b-')

        ax = create_comparison_figure("Two Point Correlation (2)", "radius")
        r_range = np.linspace(0, worm.L, worm.L+1)
        correlation_sum = np.cumsum(worm.correlation2[::-1], axis=0)[::-1]
        #correlation = correlation_sum
        #correlation = worm.correlation
        for i, T in enumerate(worm.T_range):
            if i == Tc_idx:
                ax.plot(r_range, correlation[:, i]/correlation[0, i], 'ro')
            else:
                ax.plot(r_range, correlation[:, i]/correlation[0, i], 'b-')
        """
        for i, r in enumerate(r_range):
                ax.plot(T_range, -1/np.log(abs(correlation[-1, :])), 'b-')
        """
    plt.show()

def plot_correlation_loglog(observables):
    """
    Currently only the Worm algorithm measures correlation data.
    """
    from matplotlib import rcParams # for turning off legend frame
    from matplotlib.widgets import Slider
    from scipy import stats
    correlation = observables.correlation
    #correlation[1:, :] /= 4*np.transpose(np.tile(np.linspace(1, observables.L, observables.L),  (1, 1)))

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
    #correlation = observables.correlation
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



def main():
    worm, wolff, metro = load_data(data_type)

    plot_comparisons(plot_type, worm, wolff, metro)
    #plot_correlation_loglog(worm)

    plt.show()

if __name__ == '__main__':
    main()
