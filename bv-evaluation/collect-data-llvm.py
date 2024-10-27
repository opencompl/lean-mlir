import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import os 

benchmark_dir = "../SSA/Projects/InstCombine/tests/proofs/"
res_dir = "results/llvm/"
# dir = 'plots/'
dir = '../../paper-lean-bitvectors/plots/'


reps = 1



locations = []
bitwuzla = []
leanSAT = []
leanSAT_rw = []
leanSAT_bb = []
leanSAT_sat = []
leanSAT_lrat_c = []
leanSAT_lrat_t = []


thmTot = 0

errTot = 0

for file in os.listdir(benchmark_dir):

    if "_proof" in file: # currently discard broken chapter
        
        bitwuzla_times_average = []
        leanSAT_tot_times_average = []
        leanSAT_rw_times_average = []
        leanSAT_bb_times_average = []
        leanSAT_sat_times_average = []
        leanSAT_lrat_t_times_average = []
        leanSAT_lrat_c_times_average = []

        lineNumbers = []

        # collect the numbers for all repetitions
        for r in range(reps):
            res_file = open(res_dir+file.split(".")[0]+"_r"+str(r)+".txt")
            print(res_dir+file.split(".")[0]+"_r"+str(r)+".txt")
            thm = 0
            errs = 0
            l = res_file.readline()
            while l:
                if ("info:" in l):
                    # found a solution
                    if "Bitwuzla" in l: 
                        lineNumbers.append((l.split(".lean:")[1].split(":")[0]))
                        tot = float(l.split("after ")[1].split("ms")[0])
                        if r == 0:
                            bitwuzla_times_average.append([tot])
                        else: 
                            bitwuzla_times_average[thm].append(tot)
                            # leanSAT results will be on the next line
                        l = res_file.readline()
                        if "LeanSAT" in l:
                            if "counter example" in l : 
                                tot = float(l.split("ms")[0].split("after ")[1])
                                if r == 0:
                                    leanSAT_tot_times_average.append([tot])
                                    leanSAT_rw_times_average.append([float(l.split(" SAT")[0].split("rewriting ")[1])])
                                    leanSAT_bb_times_average.append([0])
                                    leanSAT_sat_times_average.append([float(l.split("ms")[1].split("solving ")[1])])
                                    leanSAT_lrat_t_times_average.append([0])
                                    leanSAT_lrat_c_times_average.append([0])

                                else: 
                                    leanSAT_tot_times_average[thm].append(tot)
                                    leanSAT_rw_times_average[thm].append(float(l.split(" SAT")[0].split("rewriting ")[1]))
                                    leanSAT_bb_times_average[thm].append(0)
                                    leanSAT_sat_times_average[thm].append(float(l.split("ms")[1].split("solving ")[1]))
                                    leanSAT_lrat_t_times_average[thm].append(0)
                                    leanSAT_lrat_c_times_average[thm].append(0)

                            else : 
                                tot = float(l.split("ms")[0].split("r ")[1])
                                if r == 0:
                                    leanSAT_tot_times_average.append([tot])
                                    leanSAT_rw_times_average.append([float(l.split("ms")[1].split("g ")[1])])
                                    leanSAT_bb_times_average.append([float(l.split("ms")[2].split("g ")[1])])
                                    leanSAT_sat_times_average.append([float(l.split("ms")[3].split("g ")[1])])
                                    leanSAT_lrat_t_times_average.append([float(l.split("ms")[4].split("g ")[1])])
                                    leanSAT_lrat_c_times_average.append([float(l.split("ms")[5].split("g ")[1])])

                                else: 
                                    leanSAT_tot_times_average[thm].append(tot)
                                    leanSAT_rw_times_average[thm].append(float(l.split("ms")[1].split("g ")[1]))
                                    leanSAT_bb_times_average[thm].append(float(l.split("ms")[2].split("g ")[1]))
                                    leanSAT_sat_times_average[thm].append(float(l.split("ms")[3].split("g ")[1]))
                                    leanSAT_lrat_t_times_average[thm].append(float(l.split("ms")[4].split("g ")[1]))
                                    leanSAT_lrat_c_times_average[thm].append(float(l.split("ms")[5].split("g ")[1]))
                            thm = thm + 1
                    else : 
                        errs = errs + 1  
                l = res_file.readline()
        
        # for every solved theorem in the file add an entry to the dataframe
        for id in range(len(lineNumbers)): 
            locations.append(file+':'+lineNumbers[id])
            bitwuzla.append(np.mean(bitwuzla_times_average[id]))
            leanSAT.append(np.mean(leanSAT_tot_times_average[id]))
            leanSAT_rw.append(np.mean(leanSAT_rw_times_average[id]))
            leanSAT_bb.append(np.mean(leanSAT_bb_times_average[id]))
            leanSAT_sat.append (np.mean(leanSAT_sat_times_average[id]))
            leanSAT_lrat_t.append(np.mean(leanSAT_lrat_t_times_average[id]))
            leanSAT_lrat_c.append(np.mean(leanSAT_lrat_c_times_average[id]))

        thmTot += thm 
        errTot += errs


print("leanSAT solved: "+str(thmTot))
print("errors: "+str(errTot))
print("theorems in total: "+str(errTot+thmTot))

df = pd.DataFrame({'locations':locations, 'bitwuzla':bitwuzla, 'leanSAT':leanSAT,
                    'leanSAT-rw':leanSAT_rw, 'leanSAT-bb':leanSAT_bb, 'leanSAT-sat':leanSAT_sat, 
                    'leanSAT-lrat-t':leanSAT_lrat_t, 'leanSAT-lrat-c':leanSAT_lrat_c})


df.to_csv('llvm-data.csv')
