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


df = pd.read_csv('llvm-data.csv')

rw = np.array(df['leanSAT-rw'])/np.array(df['leanSAT'])*100
bb=np.array(df['leanSAT-bb'])/np.array(df['leanSAT'])*100
sat=np.array(df['leanSAT-sat'])/np.array(df['leanSAT'])*100
lrat_c=np.array(df['leanSAT-lrat-c'])/np.array(df['leanSAT'])*100
lrat_t=np.array(df['leanSAT-lrat-t'])/np.array(df['leanSAT'])*100


print('\n\nrw takes on average: '+str(np.mean(rw))+'%')
print('bb takes on average: '+str(np.mean(bb))+'%')
print('sat takes on average: '+str(np.mean(sat))+'%')
print('lrat-c takes on average: '+str(np.mean(lrat_c))+'%')
print('lrat-t takes on average: '+str(np.mean(lrat_t))+'%')

sum_steps = np.array(df['leanSAT-rw'])+np.array(df['leanSAT-bb'])+np.array(df['leanSAT-sat'])+np.array(df['leanSAT-lrat-c'])+np.array(df['leanSAT-lrat-t'])
diff = np.array(df['leanSAT']-sum_steps)/np.array(df['leanSAT'])

print("\n\naverage difference is "+str(np.mean(diff))+"%")

df_slowest = df.sort_values('leanSAT', ascending=False)

print('\n\nslowest theorems:')

for thm in range(10):
    print(df_slowest.iloc[thm])

# plot

def cumul_solving_time(data, tool1, tool2):
    
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

    plt.figure()
    plt.rc('axes.spines', **{'bottom':True, 'left':True, 'right':False, 'top':False})
    plt.plot(cumtime1, np.arange(0, len(sorted1)+1), marker = 'o', color=col[0], label = tool1)
    plt.plot(cumtime2, np.arange(0, len(sorted2)+1), marker = 'x', color=col[3], label = tool2)

    # Add labels and title
    plt.xlabel('Time [ms]')
    plt.ylabel('Problems\nsolved', rotation='horizontal', ha='left', y = 1)

    # plt.title('Problems solved - '+tool1+" vs. "+tool2+" "+bm)
    if tot_time < 250:
        step = 50
    elif tot_time < 750:
        step = 100
    elif tot_time < 1250:
        step = 250
    else:
        step = 1000
    plt.xticks(np.arange(0, tot_time+10, step))  # Show ticks for each time point
    plt.legend(frameon=False)
    plt.savefig(dir+'cumul_problems_bv_llvm.pdf', dpi = 500)
    plt.close()

cumul_solving_time(df, 'leanSAT', 'bitwuzla')