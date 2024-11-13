#!/usr/bin/env python3
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import os 

benchmark_dir = "../SSA/Projects/InstCombine/tests/proofs/"
res_dir = "results/llvm/"
raw_data_dir = "raw-data/"


reps = 1



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

inconsistencies  = 0

both_failed = 0
ls_only_failed = 0
bw_only_failed = 0

thmTot = 0

errTot = 0

bw_counter = 0
ls_counter = 0

err_loc_tot = []
err_msg_tot = []
bitwuzla_failed_locations = []
leanSAT_failed_locations = []

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
                if "Bitwuzla " in l: 
                    cegb = False
                    bw_failed = False
                    if "failed" in l : 
                        bw_failed = True
                        if (r == 0):
                            bitwuzla_failed_locations.append(file)
                    elif "counter" in l : 
                        cegb = True
                        tot = float(l.split("after ")[1].split("ms")[0])
                        if r == 0:
                            counter_bitwuzla_times_average.append([tot])
                        else: 
                            counter_bitwuzla_times_average[ceg_bw].append(tot)
                            # leanSAT results will be on the next line
                        ceg_bw += 1
                    else:
                        tot = float(l.split("after ")[1].split("ms")[0])
                        if r == 0:
                            bitwuzla_times_average.append([tot])
                        else: 
                            bitwuzla_times_average[bw].append(tot)
                            # leanSAT results will be on the next line
                        bw += 1
                    l = res_file.readline()
                    # if testing went right the next line should contain 
                    if "LeanSAT " in l:
                        ls_failed = False
                        cegl = False
                        if "failed" in l : 
                            ls_failed = True
                            if (r == 0):
                                leanSAT_failed_locations.append(file)
                        elif "counter example" in l: 
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
                            cegl=True
                        elif "counter example" not in l:  
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
                        
                        if bw_failed and ls_failed and r ==0:
                            both_failed+=1
                        elif ls_failed and r ==0:
                            ls_only_failed +=1
                            # delete latest entry from bw results for consistency
                            if cegb:
                                del counter_bitwuzla_times_average[-1]
                            else :
                                del bitwuzla_times_average[-1]
                        elif bw_failed and r ==0:
                            bw_only_failed +=1
                            if cegl : 
                                del counter_leanSAT_tot_times_average[-1]
                                del counter_leanSAT_rw_times_average[-1]
                                del counter_leanSAT_sat_times_average[-1]
                            else : 
                                del leanSAT_tot_times_average[-1]
                                del leanSAT_rw_times_average[-1]
                                del leanSAT_bb_times_average[-1]
                                del leanSAT_sat_times_average[-1]
                                del leanSAT_lrat_t_times_average[-1]
                                del leanSAT_lrat_c_times_average[-1]

                        if cegb and not cegl: 
                            print("bitwuzla found a counterexample, leanSAT proved a theorem in file "+file)
                            inconsistencies+=1
                            del counter_bitwuzla_times_average[-1]
                            del leanSAT_tot_times_average[-1]
                            del leanSAT_rw_times_average[-1]
                            del leanSAT_bb_times_average[-1]
                            del leanSAT_sat_times_average[-1]
                            del leanSAT_lrat_t_times_average[-1]
                            del leanSAT_lrat_c_times_average[-1]
                        elif cegl and not cegb: 
                            print("leanSAT found a counterexample, bitwuzla proved a theorem in file "+file)
                            inconsistencies+=1
                            del bitwuzla_times_average[-1]
                            del counter_leanSAT_tot_times_average[-1]
                            del counter_leanSAT_rw_times_average[-1]
                            del counter_leanSAT_sat_times_average[-1]
                    elif (("error:" in l or "PANIC" in l) and "Lean" not in l and r == 0):
                        err_loc_tot.append(l.split("error: ")[0].split("/")[-1][0:-1])
                        err_msg_tot.append((l.split("error: ")[1])[0:-1])
                        errs = errs + 1  
                elif (("error:" in l or "PANIC" in l) and "Lean" not in l and r == 0):
                    err_loc_tot.append(l.split("error: ")[0].split("/")[-1][0:-1])
                    err_msg_tot.append((l.split("error: ")[1])[0:-1])
                    errs = errs + 1  
                l = res_file.readline()

        # for every solved theorem in the file add an entry to the dataframe
        for id in range(len(bitwuzla_times_average)): 
            bitwuzla.append(np.mean(bitwuzla_times_average[id]))
            leanSAT.append(np.mean(leanSAT_tot_times_average[id]))
            leanSAT_rw.append(np.mean(leanSAT_rw_times_average[id]))
            leanSAT_bb.append(np.mean(leanSAT_bb_times_average[id]))
            leanSAT_sat.append (np.mean(leanSAT_sat_times_average[id]))
            leanSAT_lrat_t.append(np.mean(leanSAT_lrat_t_times_average[id]))
            leanSAT_lrat_c.append(np.mean(leanSAT_lrat_c_times_average[id]))

        for id in range(len(counter_bitwuzla_times_average)): 
            counter_bitwuzla.append(np.mean(counter_bitwuzla_times_average[id]))
            counter_leanSAT.append(np.mean(counter_leanSAT_tot_times_average[id]))
            counter_leanSAT_rw.append(np.mean(counter_leanSAT_rw_times_average[id]))
            counter_leanSAT_sat.append (np.mean(counter_leanSAT_sat_times_average[id]))

        thmTot += ls 
        errTot += errs


print("leanSAT and Bitwuzla solved: "+str(len(leanSAT)))
print("leanSAT and Bitwuzla provided "+str(len(counter_leanSAT))+" counterexamples")
print("leanSAT and Bitwuzla both failed on "+str(both_failed)+" theorems")
print("leanSAT failed and Bitwuzla succeeded on "+str(ls_only_failed)+" theorems")
print("leanSAT succeeded and Bitwuzla failed on "+str(bw_only_failed)+" theorems")
print("There were "+str(inconsistencies)+" inconsistencies")
print("Errors raised: "+str(errTot))



err_a = np.array(err_msg_tot)

unique_elements, counts = np.unique(err_a, return_counts=True)

for id, el in enumerate(unique_elements):
    print("error "+el+" was raised "+str(counts[id])+" times")

df_err = pd.DataFrame({'locations':err_loc_tot, 'err-msg':err_msg_tot})

msg_counts = df_err['err-msg'].value_counts()

df_err = df_err.assign(msg_count=df_err['err-msg'].map(msg_counts)).sort_values(by=['msg_count', 'err-msg'], ascending=[False, True])

df_err_sorted = df_err.drop(columns='msg_count')

df_err_sorted.to_csv(raw_data_dir+'err-llvm.csv')


df = pd.DataFrame({'bitwuzla':bitwuzla, 'leanSAT':leanSAT,
                    'leanSAT-rw':leanSAT_rw, 'leanSAT-bb':leanSAT_bb, 'leanSAT-sat':leanSAT_sat, 
                    'leanSAT-lrat-t':leanSAT_lrat_t, 'leanSAT-lrat-c':leanSAT_lrat_c})

df_ceg = pd.DataFrame({'bitwuzla':counter_bitwuzla, 'leanSAT':counter_leanSAT,
                    'leanSAT-rw':counter_leanSAT_rw, 'leanSAT-sat':counter_leanSAT_sat})


df.to_csv(raw_data_dir+'llvm-proved-data.csv')
df_ceg.to_csv(raw_data_dir+'llvm-ceg-data.csv')

