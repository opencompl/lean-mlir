import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import os 

benchmark_dir = "../SSA/Projects/InstCombine/tests/proofs/"
res_dir = "results/llvm/"
dir = 'plots/'
# dir = '../../paper-lean-bitvectors/plots/'


col = [
"#a6cee3",
"#1f78b4",
"#b2df8a",
"#33a02c",
"#fb9a99",
"#e31a1c"]


df = pd.read_csv('raw-data/llvm-proved-data.csv')
df_ceg = pd.read_csv('raw-data/llvm-ceg-data.csv')


sum_steps = np.sum(np.array(df['leanSAT-rw'])+np.array(df['leanSAT-bb'])+np.array(df['leanSAT-sat'])+np.array(df['leanSAT-lrat-c'])+np.array(df['leanSAT-lrat-t']))

diff = np.array(df['leanSAT']-sum_steps)/np.array(df['leanSAT'])

rw = np.sum(df['leanSAT-rw'])/sum_steps*100
bb=np.sum(df['leanSAT-bb'])/sum_steps*100
sat=np.sum(df['leanSAT-sat'])/sum_steps*100
lrat_c=np.sum(df['leanSAT-lrat-c'])/sum_steps*100
lrat_t=np.sum(df['leanSAT-lrat-t'])/sum_steps*100

print('\n\nrw takes on average: '+str(np.mean(rw))+'%')
print('bb takes on average: '+str(np.mean(bb))+'%')
print('sat takes on average: '+str(np.mean(sat))+'%')
print('lrat-c takes on average: '+str(np.mean(lrat_c))+'%')
print('lrat-t takes on average: '+str(np.mean(lrat_t))+'%')

df_slowest = df.sort_values('leanSAT', ascending=False)

print('\n\nslowest theorems:')

for thm in range(10):
    print(df_slowest.iloc[thm])

print('\n\nA proof was found for '+str(len(df))+' theorems')


ceg_sum_steps = np.sum(np.array(df_ceg['leanSAT-rw'])+np.array(df_ceg['leanSAT-sat']))
ceg_diff = np.array(df_ceg['leanSAT']-ceg_sum_steps)/np.array(df_ceg['leanSAT'])

ceg_rw = np.sum(df_ceg['leanSAT-rw'])/ceg_sum_steps*100
ceg_sat=np.sum(df_ceg['leanSAT-sat'])/ceg_sum_steps*100

print('\n\nA counterexample was found for '+str(len(df_ceg))+' theorems')

print('in these cases: ')
print('rw takes on average: '+str(np.mean(ceg_rw))+'%')
print('sat takes on average: '+str(np.mean(ceg_sat))+'%')

# plot

def cumul_solving_time(df, tool1, tool2, bm):
    fig, ax = plt.subplots()
    sorted1 = np.sort(df[tool1])
    sorted2 = np.sort(df[tool2])
    cumtime1 = [0]
    cumtime1.extend(np.cumsum(sorted1))
    cumtime2 = [0]
    cumtime2.extend(np.cumsum(sorted2))
    ax.plot(
        cumtime1,
        np.arange(0, len(df[tool1]) + 1),
        marker="o",
        color=col[0],
        label=tool1,
    )
    ax.plot(
        cumtime2,
        np.arange(0, len(df[tool2]) + 1),
        marker="x",
        color=col[3],
        label=tool2,
    )
    ax.set_xlabel("Time [ms]")
    ax.set_ylabel("Problems solved", rotation="horizontal", ha="left", y=1)
    # ax.set_xscale("log")
    # ax.set_yscale("log")
    ax.legend(loc="center right", ncols=1, frameon=False, bbox_to_anchor=(1.2, 0.5))
    fig.savefig(dir+"cumul_problems_llvm_" + bm.split(".")[0] + ".pdf")

cumul_solving_time(df, 'bitwuzla', 'leanSAT', 'llvm-cumul.pdf')
cumul_solving_time(df_ceg, 'bitwuzla', 'leanSAT', 'llvm-ceg-cumul.pdf')