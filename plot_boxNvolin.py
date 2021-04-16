# -*- coding: utf-8 -*-

import numpy as np
import matplotlib.pyplot as plt

fig3, axs = plt.subplots(nrows=1, ncols=2, figsize=(7, 3))

# Fixing random state for reproducibility
np.random.seed(19680801)

# generate some random test data
all_data = [np.random.normal(0, std, 100) for std in range(6, 10)]

# plot violin plot
axs[0].violinplot(all_data, showmeans=False, showmedians=True)
axs[0].set_title('Violin plot')

# plot box plot
axs[1].boxplot(all_data)
axs[1].set_title('Box plot')

# adding horizontal grid lines
for ax in axs:
    ax.yaxis.grid(True)
    ax.set_xticks([y + 1 for y in range(len(all_data))])
    ax.set_xlabel('Four separate samples')
    ax.set_ylabel('Observed values')
    
plt.tight_layout(pad=1, w_pad=1.5)
plt.show()

