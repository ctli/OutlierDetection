# -*- coding: utf-8 -*-

from IPython import get_ipython
get_ipython().magic('reset -sf') # Clear all variables before running a script
get_ipython().magic('clear') # Clear console

import scipy.io
import numpy as np
import pandas as pd
import pandas_profiling
import matplotlib.pyplot as plt
from matplotlib import cm

plt.close('all')


#%% Read data
data = scipy.io.loadmat('satimage-2.mat')
X = data['X']
y = data['y'].ravel()

nrows, ncols = data['X'].shape
rr = np.arange(0, nrows, 1) # syntex: np.arange(start, stop, step)
cc = np.arange(0, ncols, 1)
pltx, plty = np.meshgrid(cc, rr)

fig1 = plt.figure()
fig1.set_size_inches(12, 6)

ax1a = fig1.add_subplot(121, projection='3d')
ax1a.plot_surface(pltx, plty, data['X'], rstride=1, cstride=1, cmap=cm.viridis)
ax1a.set_title("X (input data)");

ax1b = fig1.add_subplot(122);
ax1b.plot(rr, data['y'])
ax1b.set_title("y (output data)");
                    
plt.show()
plt.savefig('fullDataSet_mesh.png')


#%% Anaylze the input data by pandas_profiling
# # https://pandas-profiling.github.io/pandas-profiling/docs/master/rtd/pages/advanced_usage.html#sample-configuration-files
# cc = list(range(36)) # Create column names
# cname = []
# for ci in cc:
#     cname.append('Column' + str(ci))

# df = pd.DataFrame(X, columns=cname) # Convert array to DataFrame
# profile = pandas_profiling.ProfileReport(df, minimal=True)
# profile.to_file("satimag_pandasProfiling.html")


#%% Box plot and violin plot
fig2, axs = plt.subplots(nrows=2, ncols=1, figsize=(12, 8), sharex='all', sharey='all')

axs[0].boxplot(X)
axs[0].set_title('Boxplot of Input Matrix, X')

axs[1].violinplot(X)
axs[1].set_title('Violin of Input Matrix, X')

plt.tight_layout(pad=2, h_pad=3)
plt.show()
plt.savefig('Fig2.png')
