#!/usr/bin/env python3
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import os 
from enum import Enum
from collections import Counter

output = Enum('output', [('counterexample', 1), ('proved', 2), ('failed', 0)])

paper_directory = ''
benchmark_dir = "../SSA/Projects/InstCombine/HackersDelight/"
res_dir = "results/HackersDelight/"
raw_data_dir = paper_directory + 'raw-data/HackersDelight/'
REPS = 1

bv_width = [4, 8, 16, 32, 64]

tools = ['bitwuzla', 'bv_decide']

# create dataframe
data = {}

col = [
"#a6cee3",
"#1f78b4",
"#b2df8a",
"#33a02c",
"#fb9a99",
"#e31a1c"]

def parse_file(file_name : str, reps : int) : 
    """Parse an output file and compute the performance number of each solver."""
    outputs_bitwuzla = []
    solved_bitwuzla_times_average = []
    counter_bitwuzla_times_average = []
    outputs_bv_decide = []
    solved_bv_decide_times_average = []
    solved_bv_decide_rw_times_average = []
    solved_bv_decide_bb_times_average = []
    solved_bv_decide_sat_times_average = []
    solved_bv_decide_lratt_times_average = []
    solved_bv_decide_lratc_times_average = []
    counter_bv_decide_times_average = []
    counter_bv_decide_rw_times_average = []
    counter_bv_decide_sat_times_average = []
    errors = []
    for r in range(reps):
        res_file = open(file_name+"_r"+str(r)+".txt")
        l = res_file.readline()
        thm = 0
        while l:
            # look for a line that contains a Bitwuzla output
            if "Bitwuzla " in l: 
                # parse bitwuzla output
                if "failed" in l: 
                    """Append `-1` in the solved and counterexample times"""
                    if r == 0:
                        outputs_bitwuzla.append(output.failed)       
                        counter_bitwuzla_times_average.append(float(-1))
                        solved_bitwuzla_times_average.append(float(-1))
                    else: 
                        counter_bitwuzla_times_average[thm].append(float(-1))
                        solved_bitwuzla_times_average[thm].append(float(-1))         
                elif "counter" in l :    
                    """Append `-1` in the solved times only, append solving time
                        in the counterexample times"""
                    tot = float(l.split("after ")[1].split("ms")[0])
                    if r == 0:
                        outputs_bitwuzla.append(output.counterexample) 
                        counter_bitwuzla_times_average.append([tot])
                        solved_bitwuzla_times_average.append(float(-1))
                    else: 
                        counter_bitwuzla_times_average[thm].append(tot)
                        solved_bitwuzla_times_average[thm].append(float(-1))             
                elif "proved" in l : 
                    """Append `-1` in the counterexample times only, append solving time
                        in the solved times"""           
                    tot = float(l.split("after ")[1].split("ms")[0])
                    if r == 0:
                        outputs_bitwuzla.append(output.proved) 
                        solved_bitwuzla_times_average.append([tot])
                        counter_bitwuzla_times_average.append(float(-1)) 
                    else: 
                        solved_bitwuzla_times_average[thm].append(tot)
                        counter_bitwuzla_times_average[thm].append(float(-1))             
                else: 
                    raise Exception("Unknown error in "+file.name)
                # if bitwuzla output was successful, analyze the next output
                l = res_file.readline()
                if "LeanSAT " in l:
                    if "failed" in l :         
                        if r == 0:
                            outputs_bv_decide.append(output.failed)
                            counter_bv_decide_times_average.append([float(-1)])
                            counter_bv_decide_rw_times_average.append([float(-1)])
                            counter_bv_decide_sat_times_average.append([float(-1)])
                            solved_bv_decide_times_average.append([float(-1)])
                            solved_bv_decide_rw_times_average.append([float(-1)])
                            solved_bv_decide_bb_times_average.append([float(-1)])
                            solved_bv_decide_sat_times_average.append([float(-1)])
                            solved_bv_decide_lratt_times_average.append([float(-1)])
                            solved_bv_decide_lratc_times_average.append([float(-1)])
                        else: 
                            counter_bv_decide_times_average[thm].append(float(-1))
                            counter_bv_decide_rw_times_average[thm].append(float(-1))
                            counter_bv_decide_sat_times_average[thm].append(float(-1))
                            solved_bv_decide_times_average[thm].append(float(-1))
                            solved_bv_decide_rw_times_average[thm].append(float(-1))
                            solved_bv_decide_bb_times_average[thm].append(float(-1))
                            solved_bv_decide_sat_times_average[thm].append(float(-1))
                            solved_bv_decide_lratt_times_average[thm].append(float(-1))
                            solved_bv_decide_lratc_times_average[thm].append(float(-1))
                    elif "counter " in l:   
                        tot = float(l.split("ms")[0].split("after ")[1])
                        if r == 0:
                            outputs_bv_decide.append(output.counterexample)
                            counter_bv_decide_times_average.append([tot])
                            counter_bv_decide_rw_times_average.append([float(l.split(" SAT")[0].split("rewriting ")[1])])
                            counter_bv_decide_sat_times_average.append([float(l.split("ms")[1].split("solving ")[1])])
                            solved_bv_decide_times_average.append([float(-1)])
                            solved_bv_decide_rw_times_average.append([float(-1)])
                            solved_bv_decide_bb_times_average.append([float(-1)])
                            solved_bv_decide_sat_times_average.append([float(-1)])
                            solved_bv_decide_lratt_times_average.append([float(-1)])
                            solved_bv_decide_lratc_times_average.append([float(-1)])
                        else: 
                            counter_bv_decide_times_average[thm].append(tot)
                            counter_bv_decide_rw_times_average[thm].append(float(l.split(" SAT")[0].split("rewriting ")[1]))
                            counter_bv_decide_sat_times_average[thm].append(float(l.split("ms")[1].split("solving ")[1]))
                            solved_bv_decide_times_average[thm].append(float(-1))
                            solved_bv_decide_rw_times_average[thm].append(float(-1))
                            solved_bv_decide_bb_times_average[thm].append(float(-1))
                            solved_bv_decide_sat_times_average[thm].append(float(-1))
                            solved_bv_decide_lratt_times_average[thm].append(float(-1))
                            solved_bv_decide_lratc_times_average[thm].append(float(-1))
                    elif "proved" in l:  
                        tot = float(l.split("ms")[0].split("r ")[1])
                        if r == 0:
                            outputs_bv_decide.append(output.proved)
                            solved_bv_decide_times_average.append([tot])
                            solved_bv_decide_rw_times_average.append([float(l.split("ms")[1].split("g ")[1])])
                            solved_bv_decide_bb_times_average.append([float(l.split("ms")[2].split("g ")[1])])
                            solved_bv_decide_sat_times_average.append([float(l.split("ms")[3].split("g ")[1])])
                            solved_bv_decide_lratt_times_average.append([float(l.split("ms")[4].split("g ")[1])])
                            solved_bv_decide_lratc_times_average.append([float(l.split("ms")[5].split("g ")[1])])
                            counter_bv_decide_times_average.append([float(-1)])
                            counter_bv_decide_rw_times_average.append([float(-1)])
                            counter_bv_decide_sat_times_average.append([float(-1)])
                        else: 
                            solved_bv_decide_times_average[thm].append(tot)
                            solved_bv_decide_rw_times_average[thm].append(float(l.split("ms")[1].split("g ")[1]))
                            solved_bv_decide_bb_times_average[thm].append(float(l.split("ms")[2].split("g ")[1]))
                            solved_bv_decide_sat_times_average[thm].append(float(l.split("ms")[3].split("g ")[1]))
                            solved_bv_decide_lratt_times_average[thm].append(float(l.split("ms")[4].split("g ")[1]))
                            solved_bv_decide_lratc_times_average[thm].append(float(l.split("ms")[5].split("g ")[1]))
                            counter_bv_decide_times_average[thm].append(float(-1))
                            counter_bv_decide_rw_times_average[thm].append(float(-1))
                            counter_bv_decide_sat_times_average[thm].append(float(-1))
                        thm = thm + 1                        
                else :
                    raise Exception("Unknown error in "+file.name)
            elif (("error:" in l or "PANIC" in l) and "Lean" not in l and r == 0):
                error_location = l.split("error: ")[0].split("/")[-1][0:-1]
                error_message = (l.split("error: ")[1])[0:-1]
                errors.append([error_location, error_message])
                errs = errs + 1
            l = res_file.readline()
    data = {'outputs_bitwuzla':outputs_bitwuzla, 
            'solved_bitwuzla_times_average': solved_bitwuzla_times_average, 
            'counter_bitwuzla_times_average': counter_bitwuzla_times_average, 
            'outputs_bv_decide': outputs_bv_decide,
            'solved_bv_decide_times_average': solved_bv_decide_times_average, 
            'solved_bv_decide_rw_times_average': solved_bv_decide_rw_times_average, 
            'solved_bv_decide_bb_times_average': solved_bv_decide_bb_times_average, 
            'solved_bv_decide_sat_times_average': solved_bv_decide_sat_times_average, 
            'solved_bv_decide_lratt_times_average': solved_bv_decide_lratt_times_average, 
            'solved_bv_decide_lratc_times_average': solved_bv_decide_lratc_times_average, 
            'counter_bv_decide_times_average': counter_bv_decide_times_average, 
            'counter_bv_decide_rw_times_average': counter_bv_decide_rw_times_average, 
            'counter_bv_decide_sat_times_average': counter_bv_decide_sat_times_average,
            'errors':errors}
    return data

file_data = []

for file in os.listdir(benchmark_dir):
    
    for bvw in bv_width:

        file_name = res_dir+file.split(".")[0]+"_"+str(bvw)

        file_data.append([file_name, parse_file(file_name, REPS)])

benchmark_solved_bitwuzla_times = []
benchmark_counter_bitwuzla_times = []
benchmark_solved_bv_decide_times = []
benchmark_solved_bv_decide_rw_times = []
benchmark_solved_bv_decide_bb_times = []
benchmark_solved_bv_decide_sat_times = []
benchmark_solved_bv_decide_lratt_times = []
benchmark_solved_bv_decide_lratc_times = []
benchmark_counter_bv_decide_times = []
benchmark_errors = []
solved_bitwuzla_tot = 0
counter_bitwuzla_tot = 0
error_bitwuzla_tot = 0
solved_bv_decide_tot = 0
counter_bv_decide_tot = 0
error_bv_decide_tot = 0



for file_result in file_data: 

    # each entry contains the solving time average among all files 
    file_solved_bitwuzla_times_average = []
    file_counter_bitwuzla_times_average = []
    file_solved_bv_decide_times_average = []
    file_solved_bv_decide_rw_times_average = []
    file_solved_bv_decide_bb_times_average = []
    file_solved_bv_decide_sat_times_average = []
    file_solved_bv_decide_lratt_times_average = []
    file_solved_bv_decide_lratc_times_average = []
    file_counter_bv_decide_times_average = []
    file_counter_bv_decide_rw_times_average = []
    file_counter_bv_decide_sat_times_average = []

    print(file_result[0])

    count_bitwuzla = Counter(file_result[1]['outputs_bitwuzla'])
    count_bv_decide = Counter(file_result[1]['outputs_bv_decide'])

    solved_bitwuzla_tot += count_bitwuzla[output.proved]
    counter_bitwuzla_tot += count_bitwuzla[output.counterexample]
    error_bitwuzla_tot += count_bitwuzla[output.failed]

    solved_bv_decide_tot += count_bv_decide[output.proved]
    counter_bv_decide_tot += count_bv_decide[output.counterexample]
    error_bv_decide_tot += count_bv_decide[output.failed]

    # average all the results among all repetitions 
        
    for error in file_result[1]['errors'] : 
        benchmark_errors.append(error)

    for theorem in file_result[1]['solved_bitwuzla_times_average'] : 
        file_solved_bitwuzla_times_average.append(np.mean(theorem))

    for theorem in file_result[1]['counter_bitwuzla_times_average'] : 
        file_counter_bitwuzla_times_average.append(np.mean(theorem))

    for theorem in file_result[1]['solved_bv_decide_times_average'] : 
        file_solved_bv_decide_times_average.append(np.mean(theorem))

    for theorem in file_result[1]['solved_bv_decide_rw_times_average'] : 
        file_solved_bv_decide_rw_times_average.append(np.mean(theorem))

    for theorem in file_result[1]['solved_bv_decide_bb_times_average'] : 
        file_solved_bv_decide_bb_times_average.append(np.mean(theorem))

    for theorem in file_result[1]['solved_bv_decide_sat_times_average'] : 
        file_solved_bv_decide_sat_times_average.append(np.mean(theorem))

    for theorem in file_result[1]['solved_bv_decide_lratt_times_average'] : 
        file_solved_bv_decide_lratt_times_average.append(np.mean(theorem))

    for theorem in file_result[1]['solved_bv_decide_lratc_times_average'] : 
        file_solved_bv_decide_lratc_times_average.append(np.mean(theorem))

    for theorem in file_result[1]['counter_bv_decide_times_average'] : 
        file_counter_bv_decide_times_average.append(np.mean(theorem))

    for theorem in file_result[1]['counter_bv_decide_rw_times_average'] : 
        file_counter_bv_decide_rw_times_average.append(np.mean(theorem))

    for theorem in file_result[1]['counter_bv_decide_sat_times_average'] : 
        file_counter_bv_decide_sat_times_average.append(np.mean(theorem))


    # for hackers'delight we want to produce a single .csv dataframe per file per bitwidth 

    ceg_df = pd.DataFrame({'counter_bitwuzla_times_average': file_counter_bitwuzla_times_average, 
                            'counter_bv_decide_times_average': file_counter_bv_decide_times_average, 
                            'counter_bv_decide_rw_times_average': file_counter_bv_decide_rw_times_average, 
                            'counter_bv_decide_sat_times_average': file_counter_bv_decide_sat_times_average})

    solved_df = pd.DataFrame({'solved_bitwuzla_times_average': file_solved_bitwuzla_times_average, 
                            'solved_bv_decide_times_average': file_solved_bv_decide_times_average, 
                            'solved_bv_decide_rw_times_average': file_solved_bv_decide_rw_times_average, 
                            'solved_bv_decide_bb_times_average': file_solved_bv_decide_bb_times_average, 
                            'solved_bv_decide_sat_times_average': file_solved_bv_decide_sat_times_average, 
                            'solved_bv_decide_lratt_times_average': file_solved_bv_decide_sat_times_average, 
                            'solved_bv_decide_lratc_times_average': file_solved_bv_decide_sat_times_average})

    errors_df = pd.DataFrame({'errors_bitwuzla':benchmark_errors})

    ceg_df.to_csv(raw_data_dir+file_result[0].split("/")[-1]+'_ceg_data.csv')
    print(raw_data_dir+file_result[0].split("/")[-1]+'_ceg_data.csv')
    solved_df.to_csv(raw_data_dir+file_result[0].split("/")[-1]+'_solved_data.csv')
    errors_df.to_csv(raw_data_dir+file_result[0].split("/")[-1]+'_err_data.csv')

    print("bv_decide solved "+str(solved_bv_decide_tot)+" theorems.")
    print("bitwuzla solved "+str(solved_bitwuzla_tot)+" theorems.")
    print("bv_decide found "+str(counter_bv_decide_tot)+" counterexamples.")
    print("bitwuzla found "+str(counter_bitwuzla_tot)+" counterexamples.")
    print("Errors raised: "+str(error_bitwuzla_tot + error_bv_decide_tot))

# err_a = np.array(err_msg)

    # unique_elements, counts = np.unique(err_a, return_counts=True)

    # for id, el in enumerate(unique_elements):
    #     print("error "+el+" was raised "+str(counts[id])+" times")

    # df_err = pd.DataFrame({'locations':err_locations, 'err-msg':err_msg})

    # msg_counts = df_err['err-msg'].value_counts()

    # df_err = df_err.assign(msg_count=df_err['err-msg'].map(msg_counts)).sort_values(by=['msg_count', 'err-msg'], ascending=[False, True])

    # df_err_sorted = df_err.drop(columns='msg_count')

    # df_err_sorted.to_csv(raw_data_dir+'err-hackersdelight.csv')


    # df = pd.DataFrame({'bitwuzla':bitwuzla_times, 'bv_decide':bv_decide_tot_times,
    #                     'bv_decide-rw':bv_decide_rw_times, 'bv_decide-bb':bv_decide_bb_times, 'bv_decide-sat':bv_decide_sat_times, 
    #                     'bv_decide-lrat-t':bv_decide_lrat_t_times, 'bv_decide-lrat-c':bv_decide_lrat_c_times})

    # df_ceg = pd.DataFrame({'bitwuzla':counter_bitwuzla_times, 'bv_decide':counter_bv_decide_tot_times,
    #                     'bv_decide-rw':counter_bv_decide_rw_times, 'bv_decide-sat':counter_bv_decide_sat_times})


    # df.to_csv(raw_data_dir+'bvw'+str(bvw)+'_'+file.split('.')[0]+'_proved_data.csv')
    # df_ceg.to_csv(raw_data_dir+'bvw'+str(bvw)+'_'+file.split('.')[0]+'_ceg_data.csv')
    # df_err_sorted.to_csv(raw_data_dir+'bvw'+str(bvw)+'_'+file.split('.')[0]+'_err_data.csv')
