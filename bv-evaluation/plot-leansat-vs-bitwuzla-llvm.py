import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import os 

benchmark_dir = "../SSA/Projects/InstCombine/tests/proofs/"
res_dir = "results/llvm/"
# dir = 'plots/'
dir = '../../paper-lean-bitvectors/plots/'


reps = 1

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


bitwuzla = []
leanSAT = []
leanSAT_rw = []
leanSAT_bb = []
leanSAT_sat = []
leanSAT_lrat = []

max = 0


for file in os.listdir(benchmark_dir):

    if "_proof" in file: # currently discard broken chapter
        
        bitwuzla_times_average = []
        leanSAT_tot_times_average = []
        leanSAT_rw_times_average = []
        leanSAT_bb_times_average = []
        leanSAT_sat_times_average = []
        leanSAT_lrat_proc_times_average = []

        for r in range(reps):
            res_file = open(res_dir+file.split(".")[0]+"_r"+str(r)+".txt")
            print(res_dir+file.split(".")[0]+"_r"+str(r)+".txt")
            lines = res_file.readlines()
            print(len(lines))
            thm = 0
            for l in lines: 
                if "LeanSAT" in l :
                    if "counter example" in l : 
                        tot = float(l.split("ms")[0].split("after ")[1])
                        if r == 0:
                            leanSAT_tot_times_average.append([tot])
                            leanSAT_rw_times_average.append([float(l.split(" SAT")[0].split("rewriting ")[1])])
                            leanSAT_bb_times_average.append([0])
                            leanSAT_sat_times_average.append([float(l.split("ms")[1].split("solving ")[1])])
                            leanSAT_lrat_proc_times_average.append([0])
                        else: 
                            leanSAT_tot_times_average[thm].append(tot)
                            leanSAT_rw_times_average[thm].append(float(l.split(" SAT")[0].split("rewriting ")[1]))
                            leanSAT_bb_times_average[thm].append(0)
                            leanSAT_sat_times_average[thm].append(float(l.split("ms")[1].split("solving ")[1]))
                            leanSAT_lrat_proc_times_average[thm].append(0)
                    else : 
                        tot = float(l.split("ms")[0].split("r ")[1])
                        if r == 0:
                            leanSAT_tot_times_average.append([tot])
                            leanSAT_rw_times_average.append([float(l.split("ms")[1].split("g ")[1])])
                            leanSAT_bb_times_average.append([float(l.split("ms")[2].split("g ")[1])])
                            leanSAT_sat_times_average.append([float(l.split("ms")[3].split("g ")[1])])
                            leanSAT_lrat_proc_times_average.append([float(l.split("ms")[4].split("g ")[1])])
                        else: 
                            leanSAT_tot_times_average[thm].append(tot)
                            leanSAT_rw_times_average[thm].append(float(l.split("ms")[1].split("g ")[1]))
                            leanSAT_bb_times_average[thm].append(float(l.split("ms")[2].split("g ")[1]))
                            leanSAT_sat_times_average[thm].append(float(l.split("ms")[3].split("g ")[1]))
                            leanSAT_lrat_proc_times_average[thm].append(float(l.split("ms")[4].split("g ")[1]))
                    thm = thm + 1
                elif "Bitwuzla" in l:
                    tot = float(l.split("after ")[1].split("ms")[0])
                    if r == 0:
                        bitwuzla_times_average.append([tot])
                    else: 
                        bitwuzla_times_average[thm].append(tot)
                elif "error" in l and "Lean exited" not in l:
                    if r ==0:
                        bitwuzla_times_average.append([-1])
                        leanSAT_tot_times_average.append([-1])
                        leanSAT_rw_times_average.append([-1])
                        leanSAT_bb_times_average.append([-1])
                        leanSAT_sat_times_average.append([-1])
                        leanSAT_lrat_proc_times_average.append([-1])
                    else:
                        bitwuzla_times_average[thm].append(-1)
                        leanSAT_tot_times_average[thm].append(-1)
                        leanSAT_rw_times_average[thm].append(-1)
                        leanSAT_bb_times_average[thm].append(-1)
                        leanSAT_sat_times_average[thm].append(-1)
                        leanSAT_lrat_proc_times_average[thm].append(-1)
                    thm = thm + 1
        

        for thm in bitwuzla_times_average: 
            bitwuzla.append(np.mean(bitwuzla_times_average))
        
        for thm in leanSAT_tot_times_average: 
            leanSAT.append(np.mean(leanSAT_tot_times_average))
            if (np.mean(leanSAT_tot_times_average) > max): 
                max = np.mean(leanSAT_tot_times_average)
                maxfile = file

        for thm in leanSAT_rw_times_average: 
            leanSAT_rw.append(np.mean(leanSAT_rw_times_average))

        for thm in leanSAT_bb_times_average: 
            leanSAT_bb.append(np.mean(leanSAT_bb_times_average))
        
        for thm in leanSAT_sat_times_average: 
            leanSAT_sat.append(np.mean(leanSAT_sat_times_average))

        for thm in leanSAT_lrat_proc_times_average: 
            leanSAT_lrat.append(np.mean(leanSAT_lrat_proc_times_average))

        print(leanSAT)
        print(bitwuzla)


data = {}

print(maxfile)

data['bitwuzla'] = bitwuzla
data['leanSAT'] = leanSAT
data['leanSAT_rw'] = leanSAT_rw
data['leanSAT_bb'] = leanSAT_bb
data['leanSAT_sat'] = leanSAT_sat
data['leanSAT_lrats'] = leanSAT_lrat

# plot

def get_stats (data) : 
    errs=data['leanSAT'].count(-1)
    tot = len(data['leanSAT'])
    print("solved "+str(tot - errs)+" out of "+str(tot)+" theorems")


def cumul_solving_time(data, tool1, tool2):

    filtered1 = list(filter(lambda a: a != -1, data[tool1]))
    filtered2 = list(filter(lambda a: a != -1, data[tool2]))

    
    # sort before cumulating 

    sorted1 = np.sort(filtered1)
    sorted2 = np.sort(filtered2)


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

get_stats(data)
cumul_solving_time(data, tools[0], tools[1])
        