import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import os 

benchmark_dir = "../SSA/Projects/InstCombine/HackersDelight/"
res_dir = "results/HackersDelight/"

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

for file in os.listdir(benchmark_dir):
    print(file)
    if "ch2_3" not in file: # currently discard broken chapter
        data={}
        data['bitwuzla'] = {}
        data['leanSAT'] = {} 
        data['leanSAT-rw'] = {}
        data['leanSAT-bb'] = {}
        data['leanSAT-sat'] = {}
        data['leanSAT-lrats'] = {}
        data['leanSAT-lratc'] = {}

        for bvw in bv_width:

            data['bitwuzla'][str(bvw)] = []
            data['leanSAT'][str(bvw)] = []
            data['leanSAT-rw'][str(bvw)] = []
            data['leanSAT-bb'][str(bvw)] = []
            data['leanSAT-sat'][str(bvw)] = []
            data['leanSAT-lrats'][str(bvw)] = []
            data['leanSAT-lratc'][str(bvw)] = []

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

            data['bitwuzla'][str(bvw)] = bitwuzla_times
            data['leanSAT'][str(bvw)] = leanSAT_tot_times
            data['leanSAT-rw'][str(bvw)] = leanSAT_rw_times
            data['leanSAT-bb'][str(bvw)] = leanSAT_bb_times
            data['leanSAT-sat'][str(bvw)] = leanSAT_sat_times
            data['leanSAT-lrats'][str(bvw)] = leanSAT_lrats_times
            data['leanSAT-lratc'][str(bvw)] = leanSAT_lratc_times
        
        rows = []

        for tool, bvws in data.items():
            for bvw, times in bvws.items():
                for time in times:
                    rows.append({'tool': tool, 'bvw': bvw, 'times': time})
        
        df =pd.DataFrame(rows)

        df.to_csv('raw-data/'+file.split(".")[0]+'.csv')


