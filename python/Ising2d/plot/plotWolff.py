"""
plot data from isingWolff2d.py
"""
from __future__ import division, print_function
import cPickle as pickle # for reading/writing data to text files.
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.widgets import Slider
from matplotlib import rcParams # for turning off legend frame

#need to create an empty class with the same name as used in the pickle file.
class Lattice(object): pass
class Observables(object): pass

def load_data():
    observables = pickle.load(open('..\\data\\isingWolff2d_16_5000.pkl', 'rb'))


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
        ylim=(observables.mean_energy[0, 0], observables.mean_energy[-1, 0]))
    ax.set_xlabel("Temperature [K]")
    ax.set_ylabel("Energy [$k_b$]")
    digits = int(np.log10(observables.Z))
    ax.set_title(r'$\rm{\bf Ising\,2D:}\,%s^2 Grid,\,%.1f\!\times 10^{%u}MCSteps$'
        % (observables.L, observables.Z/(10**digits), digits),
        fontsize=14, loc=('center'))
    plt.subplots_adjust(bottom=0.15, top=0.9, right=0.95, left=0.15)
    ax.plot(observables.T_range, observables.mean_energy[:, 0], 'bo')

def main():
    observables = load_data()
    plot_correlation_loglog(observables)

if __name__ == '__main__':
    main()
