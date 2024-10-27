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

counter_locations = []
counter_bitwuzla = []
counter_leanSAT = []
counter_leanSAT_rw = []
counter_leanSAT_sat = []

thmTot = 0

errTot = 0

bw_counter = 0
ls_counter = 0

err_loc_tot = []
err_msg_tot = []


for file in os.listdir(benchmark_dir):

    if "_proof" in file: # currently discard broken chapter
        
        bitwuzla_times_average = []
        leanSAT_tot_times_average = []
        leanSAT_rw_times_average = []
        leanSAT_bb_times_average = []
        leanSAT_sat_times_average = []
        leanSAT_lrat_t_times_average = []
        leanSAT_lrat_c_times_average = []

        counter_bitwuzla_times_average = []
        counter_leanSAT_tot_times_average = []
        counter_leanSAT_rw_times_average = []
        counter_leanSAT_bb_times_average = []
        counter_leanSAT_sat_times_average = []
        counter_leanSAT_lrat_t_times_average = []
        counter_leanSAT_lrat_c_times_average = []

        lineNumbers = []
        counter_lineNumbers = []


        # collect the numbers for all repetitions
        for r in range(reps):
            err_locations = []
            err_msg = []

            res_file = open(res_dir+file.split(".")[0]+"_r"+str(r)+".txt")
            # print(res_dir+file.split(".")[0]+"_r"+str(r)+".txt")
            ls = 0
            bw = 0
            ceg_bw = 0
            ceg_ls = 0
            errs = 0
            l = res_file.readline()
            while l:
                if ("info:" in l):
                    # found a solution
                    if "Bitwuzla" in l: 
                        ceg = False
                        theoremName = l.split(".lean:")[1].split(":")[0]
                        if "counter" in l : 
                            ceg = True
                            counter_lineNumbers.append((l.split(".lean:")[1].split(":")[0]))
                            tot = float(l.split("after ")[1].split("ms")[0])
                            if r == 0:
                                counter_bitwuzla_times_average.append([tot])
                            else: 
                                counter_bitwuzla_times_average[ceg_bw].append(tot)
                                # leanSAT results will be on the next line
                            ceg_bw += 1
                        else:
                            lineNumbers.append((l.split(".lean:")[1].split(":")[0]))
                            tot = float(l.split("after ")[1].split("ms")[0])
                            if r == 0:
                                bitwuzla_times_average.append([tot])
                            else: 
                                bitwuzla_times_average[bw].append(tot)
                                # leanSAT results will be on the next line
                            bw += 1
                        l = res_file.readline()
                        if "LeanSAT" in l:
                            if "counter example" in l and ceg: 
                                tot = float(l.split("ms")[0].split("after ")[1])
                                if r == 0:
                                    counter_leanSAT_tot_times_average.append([tot])
                                    counter_leanSAT_rw_times_average.append([float(l.split(" SAT")[0].split("rewriting ")[1])])
                                    counter_leanSAT_sat_times_average.append([float(l.split("ms")[1].split("solving ")[1])])

                                else: 
                                    counter_leanSAT_tot_times_average[ceg_ls].append(tot)
                                    counter_leanSAT_rw_times_average[ceg_ls].append(float(l.split(" SAT")[0].split("rewriting ")[1]))
                                    counter_leanSAT_sat_times_average[ceg_ls].append(float(l.split("ms")[1].split("solving ")[1]))
                                ceg_ls += 1
                            elif "counter example" not in l and not ceg:  
                                tot = float(l.split("ms")[0].split("r ")[1])
                                if r == 0:
                                    leanSAT_tot_times_average.append([tot])
                                    leanSAT_rw_times_average.append([float(l.split("ms")[1].split("g ")[1])])
                                    leanSAT_bb_times_average.append([float(l.split("ms")[2].split("g ")[1])])
                                    leanSAT_sat_times_average.append([float(l.split("ms")[3].split("g ")[1])])
                                    leanSAT_lrat_t_times_average.append([float(l.split("ms")[4].split("g ")[1])])
                                    leanSAT_lrat_c_times_average.append([float(l.split("ms")[5].split("g ")[1])])

                                else: 
                                    leanSAT_tot_times_average[ls].append(tot)
                                    leanSAT_rw_times_average[ls].append(float(l.split("ms")[1].split("g ")[1]))
                                    leanSAT_bb_times_average[ls].append(float(l.split("ms")[2].split("g ")[1]))
                                    leanSAT_sat_times_average[ls].append(float(l.split("ms")[3].split("g ")[1]))
                                    leanSAT_lrat_t_times_average[ls].append(float(l.split("ms")[4].split("g ")[1]))
                                    leanSAT_lrat_c_times_average[ls].append(float(l.split("ms")[5].split("g ")[1]))
                                ls = ls + 1
                            elif "counter example" not in l and ceg: 
                                print("bitwuzla found a counterexample, leanSAT proved "+file + theoremName)
                                if r == 0:
                                    del counter_bitwuzla_times_average[-1]
                                else: 
                                    del counter_bitwuzla_times_average[ceg_bw][-1]
                                del counter_lineNumbers[-1]
                            elif "counter example" in l and not ceg: 
                                print("leanSAT found a counterexample, bitwuzla proved  "+file + theoremName)
                elif ("error:" in l and "Lean" not in l):
                    err_locations.append(l.split(" ")[1])
                    err_msg.append(l.split(": ")[2][0:-1])
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


        if(ceg_bw>0):
            for id in range(len(counter_lineNumbers)): 
                counter_locations.append(file+':'+counter_lineNumbers[id])
                counter_bitwuzla.append(np.mean(counter_bitwuzla_times_average[id]))
                counter_leanSAT.append(np.mean(counter_leanSAT_tot_times_average[id]))
                counter_leanSAT_rw.append(np.mean(counter_leanSAT_rw_times_average[id]))
                counter_leanSAT_sat.append (np.mean(counter_leanSAT_sat_times_average[id]))

        for el in err_locations:
            err_loc_tot.append(el.split("/")[-1])
            err_msg_tot.append(err_msg[err_locations.index(el)])

        thmTot += ls 
        errTot += errs


print("leanSAT solved: "+str(thmTot))
print("errors: "+str(errTot))
print("theorems in total: "+str(errTot+thmTot))

df_err = pd.DataFrame({'locations':err_loc_tot, 'err-msg':err_msg_tot})

msg_counts = df_err['err-msg'].value_counts()

df_err = df_err.assign(msg_count=df_err['err-msg'].map(msg_counts)).sort_values(by=['msg_count', 'err-msg'], ascending=[False, True])

df_err_sorted = df_err.drop(columns='msg_count')

df_err_sorted.to_csv('raw-data/err-llvm.csv')



df = pd.DataFrame({'locations':locations, 'bitwuzla':bitwuzla, 'leanSAT':leanSAT,
                    'leanSAT-rw':leanSAT_rw, 'leanSAT-bb':leanSAT_bb, 'leanSAT-sat':leanSAT_sat, 
                    'leanSAT-lrat-t':leanSAT_lrat_t, 'leanSAT-lrat-c':leanSAT_lrat_c})

df_ceg = pd.DataFrame({'locations':counter_locations, 'bitwuzla':counter_bitwuzla, 'leanSAT':counter_leanSAT,
                    'leanSAT-rw':counter_leanSAT_rw, 'leanSAT-sat':counter_leanSAT_sat})

df.to_csv('raw-data/llvm-proved-data.csv')
df_ceg.to_csv('raw-data/llvm-ceg-data.csv')

