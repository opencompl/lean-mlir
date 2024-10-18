import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import os 

benchmark_dir = "../SSA/Projects/InstCombine/HackersDelight/"
res_dir = "results/"
dir = 'plots/'

reps = 1

bv_width = [4, 8, 16, 32, 64]

tools = ['bitwuzla', 'leanSAT-tot']

# create dataframe
data = {}

col = [
"#bfd3e6",
"#9ebcda",
"#8c96c6",
"#8c6bb1",
"#88419d",
"#6e016b"]

for file in os.listdir(benchmark_dir):
    print(file)
    if "ch2_3" not in file: # currently discard broken chapter
        data[file]={}
        data[file]['bitwuzla'] = {}
        data[file]['leanSAT-tot'] = {} 
        data[file]['leanSAT-rw'] = {}
        data[file]['leanSAT-bb'] = {}
        data[file]['leanSAT-sat'] = {}
        data[file]['leanSAT-lrats'] = {}
        data[file]['leanSAT-lratc'] = {}

        for bvw in bv_width:

            data[file]['bitwuzla'][str(bvw)] = []
            data[file]['leanSAT-tot'][str(bvw)] = []
            data[file]['leanSAT-rw'][str(bvw)] = []
            data[file]['leanSAT-bb'][str(bvw)] = []
            data[file]['leanSAT-sat'][str(bvw)] = []
            data[file]['leanSAT-lrats'][str(bvw)] = []
            data[file]['leanSAT-lratc'][str(bvw)] = []

            bitwuzla_times_average = []
            leanSAT_tot_times_average = []
            leanSAT_rw_times_average = []
            leanSAT_bb_times_average = []
            leanSAT_sat_times_average = []
            leanSAT_lrats_times_average = []
            leanSAT_lratc_times_average = []

            for r in range(reps):
                res_file = open(res_dir+file.split(".")[0]+"_"+str(bvw)+"_r"+str(r)+".txt")
                print(res_dir+file.split(".")[0]+"_"+str(bvw)+"_r"+str(r)+".txt")
                lines = res_file.readlines()
                print(len(lines))
                thm = 0
                for l in lines: 
                    if "LeanSAT" in l :
                        tot = float(l.split("ms")[0].split("r ")[1])
                        if r == 0:
                            leanSAT_tot_times_average.append([tot])
                            leanSAT_rw_times_average.append([float(l.split("ms")[1].split("g ")[1])])
                            leanSAT_bb_times_average.append([float(l.split("ms")[2].split("g ")[1])])
                            leanSAT_sat_times_average.append([float(l.split("ms")[3].split("g ")[1])])
                            leanSAT_lrats_times_average.append([float(l.split("ms")[4].split("g ")[1])])
                            leanSAT_lratc_times_average.append([float(l.split("ms")[5].split("g ")[1])])
                        else: 
                            leanSAT_tot_times_average[thm].append(tot)
                            leanSAT_rw_times_average[thm].append(float(l.split("ms")[1].split("g ")[1]))
                            leanSAT_bb_times_average[thm].append(float(l.split("ms")[2].split("g ")[1]))
                            leanSAT_sat_times_average[thm].append(float(l.split("ms")[3].split("g ")[1]))
                            leanSAT_lrats_times_average[thm].append(float(l.split("ms")[4].split("g ")[1]))
                            leanSAT_lratc_times_average[thm].append(float(l.split("ms")[5].split("g ")[1]))
                        thm = thm + 1
                    elif "Bitwuzla" in l:
                        tot = float(l.split("after ")[1].split("ms")[0])
                        if r == 0:
                            bitwuzla_times_average.append([tot])
                        else: 
                            bitwuzla_times_average[thm].append(tot)
            
            bitwuzla_times = []
            leanSAT_tot_times = []
            leanSAT_rw_times = []
            leanSAT_bb_times = []
            leanSAT_sat_times = []
            leanSAT_lrats_times = []
            leanSAT_lratc_times = []

            for thm in bitwuzla_times_average: 
                bitwuzla_times.append(np.mean(thm))
            
            for thm in leanSAT_tot_times_average: 
                leanSAT_tot_times.append(np.mean(thm))

            for thm in leanSAT_rw_times_average: 
                leanSAT_rw_times.append(np.mean(thm))

            for thm in leanSAT_bb_times_average: 
                leanSAT_bb_times.append(np.mean(thm))
            
            for thm in leanSAT_sat_times_average: 
                leanSAT_sat_times.append(np.mean(thm))

            for thm in leanSAT_lrats_times_average: 
                leanSAT_lrats_times.append(np.mean(thm))

            for thm in leanSAT_lratc_times_average: 
                leanSAT_lratc_times.append(np.mean(thm))

            data[file]['bitwuzla'][str(bvw)] = bitwuzla_times
            data[file]['leanSAT-tot'][str(bvw)] = leanSAT_tot_times
            data[file]['leanSAT-rw'][str(bvw)] = leanSAT_rw_times
            data[file]['leanSAT-bb'][str(bvw)] = leanSAT_bb_times
            data[file]['leanSAT-sat'][str(bvw)] = leanSAT_sat_times
            data[file]['leanSAT-lrats'][str(bvw)] = leanSAT_lrats_times
            data[file]['leanSAT-lratc'][str(bvw)] = leanSAT_lratc_times

# plot

def bar_bw_impact(data, bm, tool):
    i = 0
    plt.figure()
    width = len(bv_width)/30
    max = 0 
    for bvw in bv_width: 
        plt.bar(np.arange(len(data[bm][tool][str(bvw)]))-width+(i-1)*width, data[bm][tool][str(bvw)], width, color=col[i], label = bvw)
        i = i + 1
        if (np.max(data[bm][tool][str(bvw)])> max):
            max = np.max(data[bm][tool][str(bvw)])
    # Labels and legend
    plt.xlabel("Theorems")
    plt.ylabel("Time [ms]")
    plt.xticks(np.arange(len(data[bm][tool][str(bvw)])))
    plt.title(tool+' proving time - '+bm)
    plt.legend(loc = 'upper center', ncols = len(bv_width))
    plt.ylim(0, max * 1.15) 
    plt.savefig(dir+tool+'_'+bm.split(".")[0]+'.pdf', dpi = 500)

def compare_tools_same_bw(data, bm, tool1, tool2, bvw):
    i = 0
    plt.figure()
    max = np.max(data[bm][tool1][str(bvw)])
    plt.plot(np.arange(len(data[bm][tool1][str(bvw)])), data[bm][tool1][str(bvw)], color=col[2], label = tool1)
    plt.plot(np.arange(len(data[bm][tool2][str(bvw)])), data[bm][tool2][str(bvw)], color=col[3], label = tool2)
    if (np.max(data[bm][tool2][str(bvw)])> max):
        max = np.max(data[bm][tool2][str(bvw)])
    # Labels and legend
    plt.xlabel("Theorems")
    plt.ylabel("Time [ms]")
    plt.xticks(np.arange(len(data[bm][tool1][str(bvw)])))
    plt.title(tool1+' vs. '+tool2+' proving time - '+bm)
    plt.legend(loc = 'upper center', ncols = len(bv_width))
    plt.ylim(0, max * 1.15) 
    plt.savefig(dir+tool1+'_'+tool2+'_'+bm.split(".")[0]+'_'+str(bvw)+'.pdf', dpi = 500)

def compare_tools_diff_bw(data, bm, tool1, tool2):
    i = 0
    plt.figure()
    width = len(bv_width)/30
    max = 0.0
    for bvw in bv_width: 
        plt.bar(np.arange(len(data[bm][tool1][str(bvw)]))-width+(i-1)*width, np.subtract(data[bm][tool1][str(bvw)], data[bm][tool2][str(bvw)]), width, color=col[i], label = bvw)
        i = i + 1
        if (np.max(np.subtract(data[bm][tool1][str(bvw)], data[bm][tool2][str(bvw)]))> max):
            max = np.max(np.subtract(data[bm][tool1][str(bvw)], data[bm][tool2][str(bvw)]))
    # Labels and legend
    plt.xlabel("Theorems")
    plt.ylabel("Time [ms]")
    plt.xticks(np.arange(len(data[bm][tool][str(bvw)])))
    plt.title(tool1+' vs. '+tool2+' diff - '+bm)
    plt.legend(loc = 'upper center', ncols = len(bv_width))
    plt.tight_layout()
    plt.savefig(dir+tool1+'_'+tool2+'_diff_'+bm.split(".")[0]+'.pdf', dpi = 500)

def leanSAT_tot_stacked(data, bm, bvw):
    x = np.arange(len(data[bm]['leanSAT-tot'][str(bvw)]))

    # Set the width of the bars
    width = len(bv_width)/30
    # Create the figure and axis
    plt.figure()
    # Plot the total times (non-stacked)
    plt.bar(x - width/2, data[bm]['leanSAT-tot'][str(bvw)], width, label='leanSAT-tot', color=col[0])

    # Plot the stacked bars
    plt.bar(x + width/2, data[bm]['leanSAT-rw'][str(bvw)], width, label='rw', bottom=np.zeros_like(data[bm]['leanSAT-rw'][str(bvw)]), color=col[1])
    plt.bar(x + width/2, data[bm]['leanSAT-bb'][str(bvw)], width, label='bb', bottom=data[bm]['leanSAT-rw'][str(bvw)], color=col[2])
    plt.bar(x + width/2, data[bm]['leanSAT-sat'][str(bvw)], width, label='sat', bottom=np.array(data[bm]['leanSAT-rw'][str(bvw)]) + np.array(data[bm]['leanSAT-bb'][str(bvw)]), color=col[3])
    plt.bar(x + width/2, data[bm]['leanSAT-lrats'][str(bvw)], width, label='lrat-s', bottom=np.array(data[bm]['leanSAT-rw'][str(bvw)]) + np.array(data[bm]['leanSAT-bb'][str(bvw)]) 
                                    + np.array(data[bm]['leanSAT-sat'][str(bvw)]), color=col[4])
    plt.bar(x + width/2, data[bm]['leanSAT-lratc'][str(bvw)], width, label='lrat-c', bottom=np.array(data[bm]['leanSAT-rw'][str(bvw)]) + np.array(data[bm]['leanSAT-bb'][str(bvw)]) 
                                    + np.array(data[bm]['leanSAT-sat'][str(bvw)]) + np.array(data[bm]['leanSAT-lrats'][str(bvw)]), color=col[5])

    # Set the x-axis labels and tick positions
    plt.xticks(x)

    # Set axis labels and title
    plt.xlabel('Theorems')
    plt.ylabel('Time [ms]')
    plt.title('leanSAT Total vs Stacked Components')

    # Add a legend
    plt.legend()

    # Show the plot
    plt.tight_layout()
    plt.savefig(dir+'leanSAT_stacked_'+bm.split(".")[0]+'.pdf', dpi = 500)

for file in os.listdir(benchmark_dir):
    if "ch2_3" not in file: # currently discard broken chapter
        for tool in tools:  
            bar_bw_impact(data, file, tool)
        for bvw in bv_width:
            compare_tools_same_bw(data, file, tools[0], tools[1], bvw)
            leanSAT_tot_stacked(data, file, bvw)
        compare_tools_diff_bw(data, file, tools[1], tools[0])
        