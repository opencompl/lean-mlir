#!/usr/bin/env python3
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import os 
from enum import Enum
import subprocess
output = Enum('output', [('counterxample', 1), ('proved', 2), ('failed', 0)])
paper_directory = ''
benchmark_dir = "../SSA/Projects/InstCombine/tests/proofs/"
res_dir = "results/InstCombine/"
raw_data_dir = paper_directory + "raw-data/InstCombine/"


REPS = 1

def compare_solvers_on_file(results: dict):
    benchmark_errors = []
    solved_bitwuzla_tot = 0
    counter_bitwuzla_tot = 0
    error_bitwuzla_tot = 0
    solved_bv_decide_tot = 0
    counter_bv_decide_tot = 0
    error_bv_decide_tot = 0
    failed_bv_decide_and_bitwuzla = 0
    failed_bitwuzla_only = 0
    failed_bv_decide_only = 0
    benchmark_errors = []

    print(file_result[0])

    count_bitwuzla = Counter(file_result[1]["outputs_bitwuzla"])
    count_bv_decide = Counter(file_result[1]["outputs_bv_decide"])

    solved_bitwuzla_tot += count_bitwuzla[output.proved]
    counter_bitwuzla_tot += count_bitwuzla[output.counterexample]
    error_bitwuzla_tot += count_bitwuzla[output.failed]

    solved_bv_decide_tot += count_bv_decide[output.proved]
    counter_bv_decide_tot += count_bv_decide[output.counterexample]
    error_bv_decide_tot += count_bv_decide[output.failed]

    # each entry contains the solving time average among all repetitions
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

    for theorem_num, [output_bitwuzla, output_bv_decide] in enumerate(
        zip(file_result[1]["outputs_bitwuzla"], file_result[1]["outputs_bv_decide"])
    ):
        if output_bitwuzla == output.failed and output_bv_decide == output.failed:
            failed_bv_decide_and_bitwuzla += 1
        elif output_bitwuzla == output.failed and output_bv_decide == output.proved:
            print(
                "bitwuzla failed and bv_decide proved theorem "
                + str()
                + " in file "
                + file_result[0]
            )
            failed_bitwuzla_only += 1
        elif output_bitwuzla == output.proved and output_bv_decide == output.failed:
            print(
                "bitwuzla proved and bv_decide failed theorem "
                + str(theorem_num)
                + " in file "
                + file_result[0]
            )
            failed_bv_decide_only += 1
        elif (
            output_bitwuzla == output.counterexample
            and output_bv_decide == output.counterexample
        ):
            # only store these results if they're actually consistent between the two solvers
            print(
                "bitwuzla and bv_decide provided a counterexample for theorem "
                + str(theorem_num)
                + " in file "
                + file_result[0]
            )
            file_counter_bitwuzla_times_average.append(
                np.mean(file_result[1]["counter_bitwuzla_times_average"][theorem_num])
            )
            file_counter_bv_decide_times_average.append(
                np.mean(file_result[1]["counter_bv_decide_times_average"][theorem_num])
            )
            file_counter_bv_decide_rw_times_average.append(
                np.mean(file_result[1]["counter_bv_decide_times_average"][theorem_num])
            )
            file_counter_bv_decide_sat_times_average.append(
                np.mean(file_result[1]["counter_bv_decide_times_average"][theorem_num])
            )
        elif (
            output_bitwuzla == output.counterexample
            and output_bv_decide == output.proved
        ):
            print(
                "bitwuzla provided counterexample and bv_decide proved theorem "
                + str(theorem_num)
                + " in file "
                + file_result[0]
            )
        elif (
            output_bitwuzla == output.proved
            and output_bv_decide == output.counterexample
        ):
            print(
                "bitwuzla proved and bv_decide provided counterexample for theorem "
                + str(theorem_num)
                + " in file "
                + file_result[0]
            )
        elif output_bitwuzla == output.proved and output_bv_decide == output.proved:
            # only store these results if they're actually consistent between the two solvers
            file_solved_bitwuzla_times_average.append(
                np.mean(file_result[1]["solved_bitwuzla_times_average"][theorem_num])
            )
            file_solved_bv_decide_times_average.append(
                np.mean(file_result[1]["solved_bv_decide_times_average"][theorem_num])
            )
            file_solved_bv_decide_rw_times_average.append(
                np.mean(
                    file_result[1]["solved_bv_decide_rw_times_average"][theorem_num]
                )
            )
            file_solved_bv_decide_bb_times_average.append(
                np.mean(
                    file_result[1]["solved_bv_decide_bb_times_average"][theorem_num]
                )
            )
            file_solved_bv_decide_sat_times_average.append(
                np.mean(
                    file_result[1]["solved_bv_decide_sat_times_average"][theorem_num]
                )
            )
            file_solved_bv_decide_lratt_times_average.append(
                np.mean(
                    file_result[1]["solved_bv_decide_lratt_times_average"][theorem_num]
                )
            )
            file_solved_bv_decide_lratc_times_average.append(
                np.mean(
                    file_result[1]["solved_bv_decide_lratc_times_average"][theorem_num]
                )
            )
        elif (
            output_bitwuzla == output.failed
            and output_bv_decide == output.counterexample
        ):
            print(
                "bitwuzla failed and bv_decide provided counterexample for theorem "
                + str(theorem_num)
                + " in file "
                + file_result[0]
            )
        elif output_bitwuzla == output.failed and output_bv_decide == output.proved:
            print(
                "bitwuzla failed and bv_decide proved theorem "
                + str(theorem_num)
                + " in file "
                + file_result[0]
            )
        elif output_bitwuzla == output.proved and output_bv_decide == output.failed:
            print(
                "bitwuzla proved and bv_decide failed theorem "
                + str(theorem_num)
                + " in file "
                + file_result[0]
            )
        elif (
            output_bitwuzla == output.counterexample
            and output_bv_decide == output.failed
        ):
            print(
                "bitwuzla provided counterexample and bv_decide failed theorem "
                + str(theorem_num)
                + " in file "
                + file_result[0]
            )
        else:
            raise Exception(
                "Unexpected output: "
                + str(output_bitwuzla.value)
                + " bv_decide output "
                + str(output_bv_decide.value)
            )

    for error in file_result[1]["errors"]:
        benchmark_errors.append(error)

    print("bv_decide solved " + str(solved_bv_decide_tot) + " theorems.")
    print("bitwuzla solved " + str(solved_bitwuzla_tot) + " theorems.")
    print("bv_decide found " + str(counter_bv_decide_tot) + " counterexamples.")
    print("bitwuzla found " + str(counter_bitwuzla_tot) + " counterexamples.")
    print("Errors raised: " + str(error_bitwuzla_tot + error_bv_decide_tot))

    data = {
        "file_solved_bitwuzla_times_average": file_solved_bitwuzla_times_average,
        "file_counter_bitwuzla_times_average": file_counter_bitwuzla_times_average,
        "": file_solved_bv_decide_times_average,
        "file_solved_bv_decide_rw_times_average": file_solved_bv_decide_rw_times_average,
        "file_solved_bv_decide_rw_times_average": file_solved_bv_decide_bb_times_average,
        "file_solved_bv_decide_sat_times_average": file_solved_bv_decide_sat_times_average,
        "file_solved_bv_decide_lratt_times_average": file_solved_bv_decide_lratt_times_average,
        "file_solved_bv_decide_lratc_times_average": file_solved_bv_decide_lratc_times_average,
        "file_counter_bv_decide_times_average": file_counter_bv_decide_times_average,
        "file_counter_bv_decide_rw_times_average": file_counter_bv_decide_rw_times_average,
        "file_counter_bv_decide_sat_times_average": file_counter_bv_decide_sat_times_average,
        "errors": benchmark_errors,
    }
    return data

def parse_file(file_name: str, reps: int):
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
        res_file = open(file_name + "_r" + str(r) + ".txt")
        file_line = res_file.readline()
        thm = 0
        while file_line:
            # look for a line that contains a Bitwuzla output
            if "Bitwuzla " in file_line:
                # parse bitwuzla output
                if "failed" in file_line:
                    # Append `-1` in the solved and counterexample times
                    if r == 0:
                        outputs_bitwuzla.append(output.failed)
                    counter_bitwuzla_times_average.append(float(-1))
                    solved_bitwuzla_times_average.append(float(-1))
                elif "counter" in file_line:
                    # Append `-1` in the solved times only, append solving time in the counterexample times
                    tot = float(file_line.split("after ")[1].split("ms")[0])
                    if r == 0:
                        outputs_bitwuzla.append(output.counterexample)
                    counter_bitwuzla_times_average.append([tot])
                    solved_bitwuzla_times_average.append(float(-1))
                elif "proved" in file_line:
                    # Append `-1` in the counterexample times only, append solving time in the solved times
                    tot = float(file_line.split("after ")[1].split("ms")[0])
                    if r == 0:
                        outputs_bitwuzla.append(output.proved)
                    solved_bitwuzla_times_average.append([tot])
                    counter_bitwuzla_times_average.append(float(-1))
                else:
                    raise Exception("Unknown error in " + file.name)
                # if bitwuzla output was successful, analyze the next output
                file_line = res_file.readline()
                if "LeanSAT " in file_line:
                    if "failed" in file_line:
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
                    elif "counter " in file_line:
                        if r == 0:
                            outputs_bv_decide.append(output.counterexample)
                        counter_bv_decide_times_average[thm].append(
                            float(file_line.split("ms")[0].split("after ")[1])
                        )
                        counter_bv_decide_rw_times_average[thm].append(
                            float(file_line.split(" SAT")[0].split("rewriting ")[1])
                        )
                        counter_bv_decide_sat_times_average[thm].append(
                            float(file_line.split("ms")[1].split("solving ")[1])
                        )
                        solved_bv_decide_times_average[thm].append(float(-1))
                        solved_bv_decide_rw_times_average[thm].append(float(-1))
                        solved_bv_decide_bb_times_average[thm].append(float(-1))
                        solved_bv_decide_sat_times_average[thm].append(float(-1))
                        solved_bv_decide_lratt_times_average[thm].append(float(-1))
                        solved_bv_decide_lratc_times_average[thm].append(float(-1))
                    elif "proved" in file_line:
                        if r == 0:
                            outputs_bv_decide.append(output.proved)
                        solved_bv_decide_times_average.append(
                            [float(file_line.split("ms")[0].split("r ")[1])]
                        )
                        solved_bv_decide_rw_times_average.append(
                            [float(file_line.split("ms")[1].split("g ")[1])]
                        )
                        solved_bv_decide_bb_times_average.append(
                            [float(file_line.split("ms")[2].split("g ")[1])]
                        )
                        solved_bv_decide_sat_times_average.append(
                            [float(file_line.split("ms")[3].split("g ")[1])]
                        )
                        solved_bv_decide_lratt_times_average.append(
                            [float(file_line.split("ms")[4].split("g ")[1])]
                        )
                        solved_bv_decide_lratc_times_average.append(
                            [float(file_line.split("ms")[5].split("g ")[1])]
                        )
                        counter_bv_decide_times_average.append([float(-1)])
                        counter_bv_decide_rw_times_average.append([float(-1)])
                        counter_bv_decide_sat_times_average.append([float(-1)])
                        thm = thm + 1
                else:
                    raise Exception("Unknown error in " + file.name)
            elif (
                ("error:" in file_line or "PANIC" in file_line)
                and "Lean" not in file_line
                and r == 0
            ):
                error_location = file_line.split("error: ")[0].split("/")[-1][0:-1]
                error_message = (file_line.split("error: ")[1])[0:-1]
                errors.append([error_location, error_message])
            file_line = res_file.readline()

    data = {
        "outputs_bitwuzla": outputs_bitwuzla,
        "solved_bitwuzla_times_average": solved_bitwuzla_times_average,
        "counter_bitwuzla_times_average": counter_bitwuzla_times_average,
        "outputs_bv_decide": outputs_bv_decide,
        "solved_bv_decide_times_average": solved_bv_decide_times_average,
        "solved_bv_decide_rw_times_average": solved_bv_decide_rw_times_average,
        "solved_bv_decide_bb_times_average": solved_bv_decide_bb_times_average,
        "solved_bv_decide_sat_times_average": solved_bv_decide_sat_times_average,
        "solved_bv_decide_lratt_times_average": solved_bv_decide_lratt_times_average,
        "solved_bv_decide_lratc_times_average": solved_bv_decide_lratc_times_average,
        "counter_bv_decide_times_average": counter_bv_decide_times_average,
        "counter_bv_decide_rw_times_average": counter_bv_decide_rw_times_average,
        "counter_bv_decide_sat_times_average": counter_bv_decide_sat_times_average,
        "errors": errors,
    }
    return data




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

file_data = []


for file in os.listdir(benchmark_dir):

    if "_proof" in file: # currently discard broken chapter
        file_name = open(res_dir+file.split(".")[0])
        file_data.append([file_name, parse_file(file_name, REPS)])


all_files = []

for file_result in file_data:

    print(file_result[0])

    all_files.append[compare_solvers_on_file(file_result)]

all_files_solved_bitwuzla_times_average = []
all_files_counter_bitwuzla_times_average = []
all_files_solved_bv_decide_times_average = []
all_files_solved_bv_decide_rw_times_average = []
all_files_solved_bv_decide_bb_times_average = []
all_files_solved_bv_decide_sat_times_average = []
all_files_solved_bv_decide_lratt_times_average = []
all_files_solved_bv_decide_lratc_times_average = []
all_files_counter_bv_decide_times_average = []
all_files_counter_bv_decide_rw_times_average = []
all_files_counter_bv_decide_sat_times_average = []


for single_file_data in all_files : 
    all_files_solved_bitwuzla_times_average.append(single_file_data['files_solved_bitwuzla_times_average'])
    all_files_counter_bitwuzla_times_average.append(single_file_data['files_counter_bitwuzla_times_average'])
    all_files_solved_bv_decide_times_average.append(single_file_data['files_solved_bv_decide_times_average'])
    all_files_solved_bv_decide_rw_times_average.append(single_file_data['files_solved_bv_decide_rw_times_average'])
    all_files_solved_bv_decide_bb_times_average.append(single_file_data['files_solved_bv_decide_bb_times_average'])
    all_files_solved_bv_decide_sat_times_average.append(single_file_data['files_solved_bv_decide_sat_times_average'])
    all_files_solved_bv_decide_lratt_times_average.append(single_file_data['files_solved_bv_decide_lratt_times_average'])
    all_files_solved_bv_decide_lratc_times_average.append(single_file_data['files_solved_bv_decide_lratc_times_average'])
    all_files_counter_bv_decide_times_average.append(single_file_data['files_counter_bv_decide_times_times_average'])
    all_files_counter_bv_decide_rw_times_average.append(single_file_data['files_counter_bv_decide_rw_times_average'])
    all_files_counter_bv_decide_sat_times_average.append(single_file_data['files_counter_bv_decide_sa_times_average'])

        

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

