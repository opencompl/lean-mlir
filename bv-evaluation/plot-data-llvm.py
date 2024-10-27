import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import os 

benchmark_dir = "../SSA/Projects/InstCombine/tests/proofs/"
res_dir = "results/llvm/"
# dir = 'plots/'
dir = '../../paper-lean-bitvectors/plots/'


col = [
"#a6cee3",
"#1f78b4",
"#b2df8a",
"#33a02c",
"#fb9a99",
"#e31a1c"]


df = pd.read_csv('raw-data/llvm-proved-data.csv')
df_ceg = pd.read_csv('raw-data/llvm-ceg-data.csv')


sum_steps = np.array(df['leanSAT-rw'])+np.array(df['leanSAT-bb'])+np.array(df['leanSAT-sat'])+np.array(df['leanSAT-lrat-c'])+np.array(df['leanSAT-lrat-t'])

diff = np.array(df['leanSAT']-sum_steps)/np.array(df['leanSAT'])

rw = np.array(df['leanSAT-rw'])/df['leanSAT']*100
bb=np.array(df['leanSAT-bb'])/df['leanSAT']*100
sat=np.array(df['leanSAT-sat'])/df['leanSAT']*100
lrat_c=np.array(df['leanSAT-lrat-c'])/df['leanSAT']*100
lrat_t=np.array(df['leanSAT-lrat-t'])/df['leanSAT']*100

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


ceg_sum_steps = np.array(df_ceg['leanSAT-rw'])+np.array(df_ceg['leanSAT-sat'])
ceg_diff = np.array(df_ceg['leanSAT']-ceg_sum_steps)/np.array(df_ceg['leanSAT'])

ceg_rw = np.array(df_ceg['leanSAT-rw'])/ceg_sum_steps*100
ceg_sat=np.array(df_ceg['leanSAT-sat'])/ceg_sum_steps*100

print('\n\nA counterexample was found for '+str(len(df_ceg))+' theorems')

print('in these cases: ')
print('rw takes on average: '+str(np.mean(ceg_rw))+'%')
print('sat takes on average: '+str(np.mean(ceg_sat))+'%')

# plot

def cumul_solving_time(df, tool1, tool2, filename):
    
    # sort before cumulating 

    sorted1 = np.sort(df['bitwuzla'])
    sorted2 = np.sort(df['leanSAT'])

    cumtime1 = [0]
    cumtime1.extend(sorted1)
    cumtime2 = [0]
    cumtime2.extend(sorted2)

    if cumtime1[-1]>cumtime2[-1]:
        tot_time = cumtime1[-1]
    else:
        tot_time = cumtime2[-1]

    plt.figure(figsize =(8, 5))
    plt.rc('axes.spines', **{'bottom':True, 'left':True, 'right':False, 'top':False})
    plt.plot(cumtime1, np.arange(0, len(sorted1)+1), marker = 'o', color=col[0], label = 'Bitwuzla')
    plt.plot(cumtime2, np.arange(0, len(sorted2)+1), marker = 'x', color=col[3], label = 'bv_decide')

    # Add labels and title
    plt.xlabel('Time [ms]', fontsize = 15)
    plt.ylabel('Problems solved', rotation='horizontal', ha='left', y = 1, fontsize = 15)

    # plt.title('Problems solved - '+tool1+" vs. "+tool2+" "+bm)
    if tot_time < 250:
        step = 50
    elif tot_time < 750:
        step = 100
    elif tot_time < 1250:
        step = 250
    else:
        step = 1000
    plt.xticks(np.arange(0, tot_time+10, step), fontsize=14) 
    plt.yticks(fontsize=14) 

    plt.legend(frameon=False, fontsize = 15)
    plt.savefig(dir+filename, dpi = 500)
    plt.close()


cumul_solving_time(df, 'bv_decide', 'BitWuzla', 'llvm-cumul.pdf')
cumul_solving_time(df_ceg, 'bv_decide', 'BitWuzla', 'llvm-ceg-cumul.pdf')