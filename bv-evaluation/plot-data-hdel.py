import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import os 

benchmark_dir = "../SSA/Projects/InstCombine/HackersDelight/"
res_dir = "results/"
# dir = 'plots/'
dir = '../../paper-lean-bitvectors/plots/'


reps = 2

bv_width = [4, 8, 16, 32, 64]

tools = ['bitwuzla', 'leanSAT']

# create dataframe
data = {}

col = [
"#a6cee3",
"#1f78b4",
"#b2df8a",
"#33a02c",
"#fb9a99",
"#e31a1c"]

# plot

def bar_bw_impact(data, bm, tool):
    i = 0
    plt.figure()
    plt.rc('axes.spines', **{'bottom':True, 'left':True, 'right':False, 'top':False})
    width = len(bv_width)/30
    max = 0 
    for bvw in bv_width: 
        plt.bar(np.arange(len(data[tool][bvw]))-width+(i-1)*width, data[tool][bvw], width, color=col[i], label = bvw)
        i = i + 1
        if (np.max(data[tool][bvw])> max):
            max = np.max(data[tool][bvw])
    # Labels and legend
    plt.xlabel("Theorems")
    plt.ylabel("Time [ms]", rotation='horizontal', ha='left', y = 1)
    plt.xticks(np.arange(len(data[tool][bvw])))
    # plt.title(tool+' proving time - '+bm)
    plt.legend(loc = 'upper center', ncols = len(bv_width), frameon=False)
    plt.ylim(0, max * 1.15) 
    plt.tight_layout()
    plt.savefig(dir+tool+'_'+bm.split(".")[0]+'.pdf', dpi = 500)
    plt.close()

def compare_tools_same_bw(data, bm,  tool1, tool2, bvw):
    i = 0
    plt.figure()
    plt.rc('axes.spines', **{'bottom':True, 'left':True, 'right':False, 'top':False})
    max = np.max(data[tool1][bvw])
    plt.plot(np.arange(len(data[tool1][bvw])), data[tool1][bvw], color=col[0], label = tool1)
    plt.plot(np.arange(len(data[tool2][bvw])), data[tool2][bvw], color=col[3], label = tool2)
    if (np.max(data[tool2][bvw])> max):
        max = np.max(data[tool2][bvw])
    # Labels and legend
    plt.xlabel("Theorems")
    plt.ylabel("Time [ms]", rotation='horizontal', ha='left', y = 1)
    plt.xticks(np.arange(len(data[tool1][bvw])))
    # plt.title(tool1+' vs. '+tool2+' proving time - '+bm)
    plt.legend(loc = 'upper center', ncols = len(bv_width), frameon=False)
    plt.ylim(0, max * 1.15) 
    plt.tight_layout()
    plt.savefig(dir+tool1+'_'+tool2+'_'+bm.split(".")[0]+'_'+str(bvw)+'.pdf', dpi = 500)
    plt.close()

def compare_tools_diff_bw(data, bm, tool1, tool2):
    i = 0
    plt.figure()
    plt.rc('axes.spines', **{'bottom':True, 'left':True, 'right':False, 'top':False})
    width = len(bv_width)/30
    max = 0.0
    for bvw in bv_width: 
        plt.bar(np.arange(len(data[tool1][bvw]))-width+(i-1)*width, np.subtract(data[tool1][bvw], data[tool2][bvw]), width, color=col[i], label = bvw)
        i = i + 1
        if (np.max(np.subtract(data[tool1][bvw], data[tool2][bvw]))> max):
            max = np.max(np.subtract(data[tool1][bvw], data[tool2][bvw]))
    # Labels and legend
    plt.xlabel("Theorems")
    plt.ylabel("Time [ms]", rotation='horizontal', ha='left', y = 1)
    plt.xticks(np.arange(len(data[tool][bvw])))
    # plt.title(tool1+' vs. '+tool2+' diff - '+bm)
    plt.legend(loc = 'upper center', ncols = len(bv_width), frameon=False)
    plt.tight_layout()
    plt.savefig(dir+tool1+'_'+tool2+'_diff_'+bm.split(".")[0]+'.pdf', dpi = 500)
    plt.close()

def leanSAT_tot_stacked(data, bm, bvw):
    x = np.arange(len(data['leanSAT'][bvw]))

    # Set the width of the bars
    width = len(bv_width)/30
    # Create the figure and axis
    plt.figure()
    plt.rc('axes.spines', **{'bottom':True, 'left':True, 'right':False, 'top':False})
    # Plot the total times (non-stacked)
    plt.bar(x - width/2, data['leanSAT'][bvw], width, label='leanSAT', color=col[0])

    # Plot the stacked bars
    plt.bar(x + width/2, data['leanSAT-rw'][bvw], width, label='rw', bottom=np.zeros_like(data['leanSAT-rw'][bvw]), color=col[1])
    plt.bar(x + width/2, data['leanSAT-bb'][bvw], width, label='bb', bottom=data['leanSAT-rw'][bvw], color=col[2])
    plt.bar(x + width/2, data['leanSAT-sat'][bvw], width, label='sat', bottom=np.array(data['leanSAT-rw'][bvw]) + np.array(data['leanSAT-bb'][bvw]), color=col[3])
    plt.bar(x + width/2, data['leanSAT-lrats'][bvw], width, label='lrat-s', bottom=np.array(data['leanSAT-rw'][bvw]) + np.array(data['leanSAT-bb'][bvw]) 
                                    + np.array(data['leanSAT-sat'][bvw]), color=col[4])
    plt.bar(x + width/2, data['leanSAT-lratc'][bvw], width, label='lrat-c', bottom=np.array(data['leanSAT-rw'][bvw]) + np.array(data['leanSAT-bb'][bvw]) 
                                    + np.array(data['leanSAT-sat'][bvw]) + np.array(data['leanSAT-lrats'][bvw]), color=col[5])
    

    # Set the x-axis labels and tick positions
    plt.xticks(x)

    # Set axis labels and title
    plt.xlabel('Theorems')
    plt.ylabel('Time [ms]', rotation='horizontal', ha='left', y = 1)

    # plt.title('leanSAT Total vs Stacked Components')

    # Add a legend
    plt.legend(frameon=False)

    # Show the plot
    plt.tight_layout()
    plt.savefig(dir+'leanSAT_stacked_'+bm.split(".")[0]+'_'+str(bvw)+'.pdf', dpi = 500)
    plt.close()

def cumul_solving_time_same_bvw(data, tool1, tool2,  bm, bvw):
    
    # sort before cumulating 

    sorted1 = np.sort(data[tool1][bvw])
    sorted2 = np.sort(data[tool2][bvw])


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
    plt.plot(cumtime1, np.arange(0, len(data[tool1][bvw])+1), marker = 'o', color=col[0], label = tool1)
    plt.plot(cumtime2, np.arange(0, len(data[tool2][bvw])+1), marker = 'x', color=col[3], label = tool2)

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
        step = 500
    plt.xticks(np.arange(0, tot_time+10, step))  # Show ticks for each time point
    plt.legend(frameon=False)
    plt.savefig(dir+'cumul_problems_bv'+str(bvw)+'_'+bm.split(".")[0]+'.pdf', dpi = 500)
    plt.close()

for file in os.listdir(benchmark_dir):
    if "ch2_3" not in file: # currently discard broken chapter
        df = pd.read_csv('raw-data/'+file.split(".")[0]+'.csv')
        data = {tool: df[df['tool'] == tool].groupby('bvw')['times'].apply(list).to_dict()
                for tool in df['tool'].unique()}
        print(data)
        for tool in tools:  
            bar_bw_impact(data, file, tool)
        for bvw in bv_width:
            compare_tools_same_bw(data, file, tools[0], tools[1], bvw)
            leanSAT_tot_stacked(data, file, bvw)
            cumul_solving_time_same_bvw(data, tools[0], tools[1], file, bvw)
        compare_tools_diff_bw(data, file, tools[1], tools[0])
        