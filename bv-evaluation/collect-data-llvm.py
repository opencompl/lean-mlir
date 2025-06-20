import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import os 
from enum import Enum
import subprocess
output = Enum('output', [('counterxample', 1), ('proved', 2), ('failed', 0)])
paper_directory = 'for-paper/'
benchmark_dir = "../SSA/Projects/InstCombine/tests/proofs/"
res_dir = "results/InstCombine/"
raw_data_dir = paper_directory + "raw-data/InstCombine/"


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
        errs = 0
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

        outputs_bitwuzla = []
        outputs_leanSAT = []
        # collect the numbers for all repetitions

        for r in range(reps):
            res_file = open(res_dir+file.split(".")[0]+"_r"+str(r)+".txt")
            l = res_file.readline()
            thm = 0
            while l:
                if "Bitwuzla " in l: 
                    if "failed" in l: 
                        if r == 0:
                            outputs_bitwuzla.append(output.failed)       
                            counter_bitwuzla_times_average.append(float(-1))
                            bitwuzla_times_average.append(float(-1))
                        else: 
                            counter_bitwuzla_times_average[thm].append(float(-1))
                            bitwuzla_times_average[thm].append(float(-1))         
                    elif "counter" in l :    
                        tot = float(l.split("after ")[1].split("ms")[0])
                        if r == 0:
                            outputs_bitwuzla.append(output.counterxample) 
                            counter_bitwuzla_times_average.append([tot])
                            bitwuzla_times_average.append(float(-1))
                        else: 
                            counter_bitwuzla_times_average[thm].append(tot)
                            bitwuzla_times_average[thm].append(float(-1))             
                    elif "proved" in l :            
                        tot = float(l.split("after ")[1].split("ms")[0])
                        if r == 0:
                            outputs_bitwuzla.append(output.proved) 
                            bitwuzla_times_average.append([tot])
                            counter_bitwuzla_times_average.append(float(-1)) 
                        else: 
                            bitwuzla_times_average[thm].append(tot)
                            counter_bitwuzla_times_average[thm].append(float(-1))             
                    else: 
                        print('something is wrong with '+file.name)
                        break
                    l = res_file.readline()
                    # if testing went right the next line should contain 
                    if "LeanSAT " in l:
                        if "failed" in l :         
                            if r == 0:
                                outputs_leanSAT.append(output.failed)
                                counter_leanSAT_tot_times_average.append([float(-1)])
                                counter_leanSAT_rw_times_average.append([float(-1)])
                                counter_leanSAT_sat_times_average.append([float(-1)])
                                leanSAT_tot_times_average.append([float(-1)])
                                leanSAT_rw_times_average.append([float(-1)])
                                leanSAT_bb_times_average.append([float(-1)])
                                leanSAT_sat_times_average.append([float(-1)])
                                leanSAT_lrat_t_times_average.append([float(-1)])
                                leanSAT_lrat_c_times_average.append([float(-1)])
                            else: 
                                counter_leanSAT_tot_times_average[thm].append(float(-1))
                                counter_leanSAT_rw_times_average[thm].append(float(-1))
                                counter_leanSAT_sat_times_average[thm].append(float(-1))
                                leanSAT_tot_times_average[thm].append(float(-1))
                                leanSAT_rw_times_average[thm].append(float(-1))
                                leanSAT_bb_times_average[thm].append(float(-1))
                                leanSAT_sat_times_average[thm].append(float(-1))
                                leanSAT_lrat_t_times_average[thm].append(float(-1))
                                leanSAT_lrat_c_times_average[thm].append(float(-1))
                        elif "counter " in l:   
                            tot = float(l.split("ms")[0].split("after ")[1])
                            if r == 0:
                                outputs_leanSAT.append(output.counterxample)
                                counter_leanSAT_tot_times_average.append([tot])
                                counter_leanSAT_rw_times_average.append([float(l.split(" SAT")[0].split("rewriting ")[1])])
                                counter_leanSAT_sat_times_average.append([float(l.split("ms")[1].split("solving ")[1])])
                                leanSAT_tot_times_average.append([float(-1)])
                                leanSAT_rw_times_average.append([float(-1)])
                                leanSAT_bb_times_average.append([float(-1)])
                                leanSAT_sat_times_average.append([float(-1)])
                                leanSAT_lrat_t_times_average.append([float(-1)])
                                leanSAT_lrat_c_times_average.append([float(-1)])
                            else: 
                                counter_leanSAT_tot_times_average[thm].append(tot)
                                counter_leanSAT_rw_times_average[thm].append(float(l.split(" SAT")[0].split("rewriting ")[1]))
                                counter_leanSAT_sat_times_average[thm].append(float(l.split("ms")[1].split("solving ")[1]))
                                leanSAT_tot_times_average[thm].append(float(-1))
                                leanSAT_rw_times_average[thm].append(float(-1))
                                leanSAT_bb_times_average[thm].append(float(-1))
                                leanSAT_sat_times_average[thm].append(float(-1))
                                leanSAT_lrat_t_times_average[thm].append(float(-1))
                                leanSAT_lrat_c_times_average[thm].append(float(-1))
                        elif "proved" in l:  
                            tot = float(l.split("ms")[0].split("r ")[1])
                            if r == 0:
                                outputs_leanSAT.append(output.proved)
                                leanSAT_tot_times_average.append([tot])
                                leanSAT_rw_times_average.append([float(l.split("ms")[1].split("g ")[1])])
                                leanSAT_bb_times_average.append([float(l.split("ms")[2].split("g ")[1])])
                                leanSAT_sat_times_average.append([float(l.split("ms")[3].split("g ")[1])])
                                leanSAT_lrat_t_times_average.append([float(l.split("ms")[4].split("g ")[1])])
                                leanSAT_lrat_c_times_average.append([float(l.split("ms")[5].split("g ")[1])])
                                counter_leanSAT_tot_times_average.append([float(-1)])
                                counter_leanSAT_rw_times_average.append([float(-1)])
                                counter_leanSAT_sat_times_average.append([float(-1)])
                            else: 
                                leanSAT_tot_times_average[thm].append(tot)
                                leanSAT_rw_times_average[thm].append(float(l.split("ms")[1].split("g ")[1]))
                                leanSAT_bb_times_average[thm].append(float(l.split("ms")[2].split("g ")[1]))
                                leanSAT_sat_times_average[thm].append(float(l.split("ms")[3].split("g ")[1]))
                                leanSAT_lrat_t_times_average[thm].append(float(l.split("ms")[4].split("g ")[1]))
                                leanSAT_lrat_c_times_average[thm].append(float(l.split("ms")[5].split("g ")[1]))
                                counter_leanSAT_tot_times_average[thm].append(float(-1))
                                counter_leanSAT_rw_times_average[thm].append(float(-1))
                                counter_leanSAT_sat_times_average[thm].append(float(-1))
                            thm = thm + 1                        
                    elif (("error:" in l or "PANIC" in l) and "Lean" not in l and r == 0):
                        err_loc_tot.append(l.split("error: ")[0].split("/")[-1][0:-1])
                        err_msg_tot.append((l.split("error: ")[1])[0:-1])
                        errs = errs + 1  
                elif (("error:" in l or "PANIC" in l) and "Lean" not in l and r == 0):
                    err_loc_tot.append(l.split("error: ")[0].split("/")[-1][0:-1])
                    err_msg_tot.append((l.split("error: ")[1])[0:-1]+", file: "+file+", goal = "+str(thm))
                    errs = errs + 1
                l = res_file.readline()

        # for every solved theorem in the file add an entry to the dataframe
        thm = 0 
        for output_bw, output_ls in zip(outputs_bitwuzla, outputs_leanSAT): 
            if output_bw == output.failed and output_ls == output.failed: 
                # print("bitwuzla failed and leanSAT failed on theorem "+str(thm)+ "in file "+file)
                both_failed += 1
                thm = thm + 1
            elif output_bw == output.failed and output_ls == output.proved:
                print("bitwuzla failed and leanSAT proved theorem "+str(thm)+ " in file "+file)
                bw_only_failed += 1
                thm = thm + 1
            elif output_bw == output.proved and output_ls == output.failed:
                print("bitwuzla proved and leanSAT failed theorem "+str(thm)+ " in file "+file)
                ls_only_failed += 1
                thm = thm + 1
            elif output_bw == output.counterxample and output_ls == output.counterxample:
                print("bitwuzla and leanSAT provided counterexample for theorem "+str(thm)+ " in file "+file)
                counter_bitwuzla.append(np.mean(counter_bitwuzla_times_average[thm]))
                counter_leanSAT.append(np.mean(counter_leanSAT_tot_times_average[thm]))
                counter_leanSAT_rw.append(np.mean(counter_leanSAT_rw_times_average[thm]))
                counter_leanSAT_sat.append (np.mean(counter_leanSAT_sat_times_average[thm]))
                thm = thm + 1
            elif output_bw == output.counterxample and output_ls == output.proved:
                print("bitwuzla provided counterexample and leanSAT proved theorem "+str(thm)+ " in file "+file)
                thm = thm + 1
            elif output_bw == output.proved and output_ls == output.counterxample:
                print("bitwuzla proved and leanSAT provided counterexample for theorem "+str(thm)+ " in file "+file)
                thm = thm + 1
            elif output_bw == output.proved and output_ls == output.proved:
                # print("bitwuzla and leanSAT proved theorem "+str(thm)+ "in file "+file)
                bitwuzla.append(np.mean(bitwuzla_times_average[thm]))
                leanSAT.append(np.mean(leanSAT_tot_times_average[thm]))
                leanSAT_rw.append(np.mean(leanSAT_rw_times_average[thm]))
                leanSAT_bb.append(np.mean(leanSAT_bb_times_average[thm]))
                leanSAT_sat.append (np.mean(leanSAT_sat_times_average[thm]))
                leanSAT_lrat_t.append(np.mean(leanSAT_lrat_t_times_average[thm]))
                leanSAT_lrat_c.append(np.mean(leanSAT_lrat_c_times_average[thm]))
                thm = thm + 1
            elif output_bw == output.failed and output_ls == output.counterxample:
                print("bitwuzla failed and leanSAT provided counterexample for theorem "+str(thm)+ " in file "+file)
                thm = thm + 1
            elif output_bw == output.failed and output_ls == output.proved:
                print("bitwuzla failed and leanSAT proved theorem "+str(thm)+ " in file "+file)
                thm = thm + 1
            elif output_bw == output.proved and output_ls == output.failed:
                print("bitwuzla proved and leanSAT failed theorem "+str(thm)+ " in file "+file)
                thm = thm + 1
            elif output_bw == output.counterxample and output_ls == output.failed:
                print("bitwuzla provided counterexample and leanSAT failed theorem "+str(thm)+ " in file "+file)
            else:   
                print("something is broken: bitwuzla output "+str(output_bw.value)+" leanSAT output "+str(output_ls.value))
                break
        thmTot += thm
        errTot += errs

print("In total we found "+str(thmTot)+" goals.")


print("leanSAT and Bitwuzla solved: "+str(len(leanSAT)))
print("leanSAT and Bitwuzla provided "+str(len(counter_leanSAT))+" counterexamples")
print("leanSAT and Bitwuzla both failed on "+str(both_failed)+" theorems")
print("leanSAT failed and Bitwuzla succeeded on "+str(ls_only_failed)+" theorems")
print("leanSAT succeeded and Bitwuzla failed on "+str(bw_only_failed)+" theorems")
print("There were "+str(inconsistencies)+" inconsistencies")
print("Errors raised: "+str(errTot))

# Double Checking Against Grep Output
def run_shell_command_and_assert_output_eq_int(cwd : str, cmd : str, expected_val : int) -> int:
    response = subprocess.check_output(cmd, shell=True, cwd=cwd, text=True)
    val = int(response)
    failed =  val != expected_val
    failed_str = "FAIL" if failed else "SUCCESS"
    print(f"ran {cmd}, expected {expected_val}, found {val}, {failed_str}")

run_shell_command_and_assert_output_eq_int("results/InstCombine/", "rg 'Bitwuzla failed' | wc -l", both_failed+bw_only_failed)
run_shell_command_and_assert_output_eq_int("results/InstCombine/", "rg 'LeanSAT failed' | wc -l", both_failed+ls_only_failed)
run_shell_command_and_assert_output_eq_int("results/InstCombine/", "rg 'LeanSAT provided a counter' | wc -l", len(counter_leanSAT))
run_shell_command_and_assert_output_eq_int("results/InstCombine/", "rg 'Bitwuzla provided a counter' | wc -l", len(counter_bitwuzla))
run_shell_command_and_assert_output_eq_int("results/InstCombine/", "rg 'LeanSAT proved' | wc -l", len(leanSAT) + bw_only_failed)
run_shell_command_and_assert_output_eq_int("results/InstCombine/", "rg 'Bitwuzla proved' | wc -l", len(bitwuzla) + ls_only_failed)


# Converting to DataFrame


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

