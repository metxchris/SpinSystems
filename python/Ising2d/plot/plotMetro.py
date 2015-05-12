"""
plot data from isingMetropolis2d.py
"""
from __future__ import division, print_function
import cPickle as pickle # for reading/writing data to text files.
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.widgets import Slider
from matplotlib import rcParams # for turning off legend frame
from scipy import stats

#need to create an empty class with the same name as used in the pickle file.
class Lattice(object): pass
class Observables(object): pass

def load_data():
    observables = pickle.load(open('..\\data\\isingMetro2d_16x5000.pkl', 'rb'))
    lattice = pickle.load(open('..\\data\\isingMetro2d_64x1000_lattice.pkl', 'rb'))
    return observables, lattice


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
    """
    Plot the mean magnetization and mean energy.
    """
    # unpack variables
    T_range = observables.T_range
    mean_magnetization = observables.mean_magnetization
    mean_energy = observables.mean_energy
    Z, L = observables.Z, observables.L
    # create figure.
    fig = plt.figure(figsize=(12, 4.5))
    ax = fig.add_subplot(121, xlim=(min(T_range), max(T_range)),
        ylim=(0, max(mean_magnetization)))
    ax.set_xlabel('$\\rm Temperature$', fontsize=14)
    ax.set_ylabel('$\\rm Magnetization$', fontsize=14)
    ax.set_title('$\\rm{\\bf Ising\,2D:}\,%s ^2 Grid,\,%s\,MCSteps$' % (L, Z),
        fontsize=14, loc=('center'))
    ax.plot(T_range, mean_magnetization, 'o', ms=4, mec='#00007F', mew=1, mfc="None")
    ax = fig.add_subplot(122, xlim=(min(T_range), max(T_range)),
        ylim=(min(mean_energy), max(mean_energy)))
    ax.set_xlabel('$\\rm Temperature$', fontsize=14)
    ax.set_ylabel('$\\rm Energy$', fontsize=14)
    ax.set_title('$\\rm{\\bf Ising\,2D:}\,%s ^2 Grid,\,%s\,MCSteps$' % (L, Z),
        fontsize=14, loc=('center'))
    en = ax.plot(T_range, mean_energy, 'o', ms=4, mec='#7F0000', mew=1, mfc="None")
    plt.tight_layout()
    plt.show()

def plot_loglog(observables):
    """
    Estimate the critical exponent beta of the magnetization.
    This function requires several temperature values T<Tc in order to work.
    """
    from matplotlib import rcParams # for turning off legend frame
    from scipy import stats
    # unpack variables
    T_range = observables.T_range
    mean_magnetization = observables.mean_magnetization
    Z, L = observables.Z, observables.L
    # create figure.
    fig = plt.figure(figsize=(8,6))
    ax = fig.add_subplot(111)
    # make room for slider
    plt.subplots_adjust(bottom=0.25)
    ax.set_xlabel('$\log\,(T_c - T)$', fontsize=14)
    ax.set_ylabel('$\\rm \log\,|M|$', fontsize=14)
    ax.set_title(r'$\rm{\bf Ising\,2D:}\,%s^2 Grid,\,%.0G\,MCSteps$'
        % (L, Z), fontsize=14, loc=('center'))
    # placeholders for magnetization data and least squares fit
    mag_plot = ax.plot(0, 0, 'o', markersize=6, color='b')[0]
    least_squares_fit = ax.plot(0, 0, '-r', label='y=mx+b')[0]
    fit_annotation = plt.annotate('', xy=(0.6,0.3), 
        xycoords='figure fraction', fontsize=14)
    # create Tc slider
    slider_axes = plt.axes([0.2, 0.1, 0.6, 0.03], axisbg='lightgoldenrodyellow')
    Tc_max = 2.4
    Tc_init = min(T_range[-1], 2.244) # set to reflex my choice of Tc
    Tc_slider = Slider(slider_axes, '$T_c$', 2.19, Tc_max, valinit=Tc_init, 
        facecolor='b', valfmt ='%.3f K')
    # create slider for points displayed
    slider_axes = plt.axes([0.2, 0.05, 0.6, 0.03], axisbg='lightgoldenrodyellow')
    number_max = 40
    number_init = 12 # set to reflex my choice of points displayed
    number_slider = Slider(slider_axes, r'$\rm Points$', valmin=3, valmax=number_max,
        valinit=number_init, closedmax=True, facecolor='b', valfmt ='%u')
    rcParams['legend.frameon'] = 'False'

    def slider_update(val):
        # keep slider value to 3 decimal places
        Tc = round(Tc_slider.val*1000)/1000 
        num_points=int(number_slider.val)
        # start and end indices of plotted magnetization data
        mag_cutoff = 0.6 # don't consider points where M < mag_cutoff
        mag_cutoff_idx = (mean_magnetization>mag_cutoff).argmin()
        mag_cutoff_idx = len(mean_magnetization[mean_magnetization>mag_cutoff])
        temp_cutoff_idx = len(T_range[(Tc-T_range)>0])
        upper_idx = min(temp_cutoff_idx, mag_cutoff_idx)
        lower_idx = max(0, upper_idx-num_points)
        # update plotted magnetization data based on Tc.
        mag_plot.set_xdata(np.log(Tc-T_range[lower_idx:upper_idx]))
        mag_plot.set_ydata(np.log(mean_magnetization[lower_idx:upper_idx]))
        # least squares fit using scipy package.
        fit_data = stats.linregress(mag_plot.get_xdata(), mag_plot.get_ydata())
        slope, intercept, r_value = fit_data[0], fit_data[1], fit_data[2]
        #fit_annotation.set_text(r'$\rm{Fit:}\; \beta = %.3f,\;r^2 = %.3f$' % (slope, r_value**2))
        least_squares_fit.set_label(r'$\rm{Fit:}\; \beta = %.3f,\;r^2 = %.3f$'
            % (slope, r_value**2))
        # plot least squares fit.
        least_squares_fit.set_ydata((slope*mag_plot.get_xdata()+intercept))
        least_squares_fit.set_xdata(mag_plot.get_xdata())
        # set new axes bounds.
        ax.set_xlim(min(mag_plot.get_xdata()), max(mag_plot.get_xdata()))
        ax.set_ylim(min(mag_plot.get_ydata()), max(mag_plot.get_ydata()))
        # refresh figure.
        ax.legend(loc='lower right')
        fig.canvas.draw_idle()

    # set slider callback functions.
    Tc_slider.on_changed(slider_update) 
    number_slider.on_changed(slider_update)
    # initialize plot
    slider_update(0) 
    plt.show()

def main():
    observables, lattice = load_data()
    #plot_correlation_loglog(observables)
    plot_spin_lattice(lattice.spins, observables)

if __name__ == '__main__':
    main()
