#!/usr/bin/env python3
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import os 

benchmark_dir = "../SSA/Projects/InstCombine/HackersDelight/"
res_dir = "results/HackersDelight/"
raw_data_dir = '../../paper-lean-bitvectors/raw-data/HackersDelight/'
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
    

    for bvw in bv_width:
        bitwuzla_times = []

        leanSAT_tot_times = []
        leanSAT_rw_times = []
        leanSAT_bb_times = []
        leanSAT_sat_times = []
        leanSAT_lrat_t_times = []
        leanSAT_lrat_c_times = []

        counter_bitwuzla_times = []
        counter_leanSAT_tot_times = []
        counter_leanSAT_rw_times = []
        counter_leanSAT_sat_times = []

        err_locations = []
        err_msg = []


        err_tot = 0

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

        for r in range(reps):
            inconsistencies = 0

            res_file = open(res_dir+file.split(".")[0]+"_"+str(bvw)+"_r"+str(r)+".txt")
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
                    if "counter" in l : 
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
                        cegl = False
                        if "counter example" in l: 
                            tot = float(l.split("ms")[0].split("after ")[1])
                            print(counter_leanSAT_rw_times_average)
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
                        err_locations.append(l.split("error: ")[0].split("/")[-1][0:-1])
                        err_msg.append((l.split("error: ")[1])[0:-1])
                        errs = errs + 1  
                elif (("error:" in l or "PANIC" in l) and "Lean" not in l and r == 0):
                    err_locations.append(l.split("error: ")[0].split("/")[-1][0:-1])
                    err_msg.append((l.split("error: ")[1])[0:-1])
                    errs = errs + 1  
                l = res_file.readline()


        err_tot = err_tot + errs

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

        for thm in leanSAT_lrat_t_times_average: 
            leanSAT_lrat_t_times.append(np.mean(thm))

        for thm in leanSAT_lrat_c_times_average: 
            leanSAT_lrat_c_times.append(np.mean(thm))

        for thm in counter_bitwuzla_times_average: 
            counter_bitwuzla_times.append(np.mean(thm))

        for thm in counter_leanSAT_tot_times_average: 
            counter_leanSAT_tot_times.append(np.mean(thm))

        for thm in counter_leanSAT_rw_times_average: 
            counter_leanSAT_rw_times.append(np.mean(thm))

        for thm in counter_leanSAT_sat_times_average: 
            print(counter_leanSAT_sat_times_average)
            counter_leanSAT_sat_times.append(np.mean(thm))

        print("\n\nwith bitwidth = "+str(bvw))
        print("leanSAT and Bitwuzla solved: "+str(len(leanSAT_tot_times)))
        print("leanSAT and Bitwuzla provided "+str(len(counter_leanSAT_tot_times))+" counterexamples")
        print("There were "+str(inconsistencies)+" inconsistencies")
        print("Errors raised: "+str(err_tot))

        err_a = np.array(err_msg)

        unique_elements, counts = np.unique(err_a, return_counts=True)

        for id, el in enumerate(unique_elements):
            print("error "+el+" was raised "+str(counts[id])+" times")

        df_err = pd.DataFrame({'locations':err_locations, 'err-msg':err_msg})

        msg_counts = df_err['err-msg'].value_counts()

        df_err = df_err.assign(msg_count=df_err['err-msg'].map(msg_counts)).sort_values(by=['msg_count', 'err-msg'], ascending=[False, True])

        df_err_sorted = df_err.drop(columns='msg_count')

        df_err_sorted.to_csv(raw_data_dir+'err-hackersdelight.csv')


        df = pd.DataFrame({'bitwuzla':bitwuzla_times, 'leanSAT':leanSAT_tot_times,
                            'leanSAT-rw':leanSAT_rw_times, 'leanSAT-bb':leanSAT_bb_times, 'leanSAT-sat':leanSAT_sat_times, 
                            'leanSAT-lrat-t':leanSAT_lrat_t_times, 'leanSAT-lrat-c':leanSAT_lrat_c_times})

        df_ceg = pd.DataFrame({'bitwuzla':counter_bitwuzla_times, 'leanSAT':counter_leanSAT_tot_times,
                            'leanSAT-rw':counter_leanSAT_rw_times, 'leanSAT-sat':counter_leanSAT_sat_times})


        df.to_csv(raw_data_dir+'bvw'+str(bvw)+'_'+file.split('.')[0]+'_proved_data.csv')
        df_ceg.to_csv(raw_data_dir+'bvw'+str(bvw)+'_'+file.split('.')[0]+'_ceg_data.csv')
