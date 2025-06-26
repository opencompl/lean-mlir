#!/usr/bin/env python3
import numpy as np
import pandas as pd
import os
from enum import Enum
from collections import Counter

output = Enum("output", [("counterexample", 1), ("proved", 2), ("failed", 0)])

paper_directory = ""
benchmark_dir = "../SSA/Projects/InstCombine/HackersDelight/"
res_dir = "results/HackersDelight/"
raw_data_dir = paper_directory + "raw-data/HackersDelight/"
REPS = 1

bv_width = [4, 8, 16, 32, 64]

tools = ["bitwuzla", "bv_decide"]

# create dataframe
data = {}

col = ["#a6cee3", "#1f78b4", "#b2df8a", "#33a02c", "#fb9a99", "#e31a1c"]

threshold = 1.1


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


file_data = []

for file in os.listdir(benchmark_dir):
    for bvw in bv_width:
        file_name = res_dir + file.split(".")[0] + "_" + str(bvw)

        file_data.append([file_name, parse_file(file_name, REPS)])

for file_result in file_data:
    print(file_result[0])

    file_comparison = compare_solvers_on_file(file_result)

    # for hackers'delight we want to produce a single .csv dataframe per file per bitwidth

    # sanity_check_times(file_comparison)

    ceg_df = pd.DataFrame(
        {
            "counter_bitwuzla_times_average": file_comparison[
                "file_counter_bitwuzla_times_average"
            ],
            "counter_bv_decide_times_average": file_comparison[
                "file_counter_bv_decide_times_average"
            ],
            "counter_bv_decide_rw_times_average": file_comparison[
                "file_counter_bv_decide_rw_times_average"
            ],
            "counter_bv_decide_sat_times_average": file_comparison[
                "file_counter_bv_decide_sat_times_average"
            ],
        }
    )

    solved_df = pd.DataFrame(
        {
            "solved_bitwuzla_times_average": file_comparison[
                "file_solved_bitwuzla_times_average"
            ],
            "solved_bv_decide_times_average": file_comparison[
                "file_solved_bv_decide_times_average"
            ],
            "solved_bv_decide_rw_times_average": file_comparison[
                "file_solved_bv_decide_rw_times_average"
            ],
            "solved_bv_decide_bb_times_average": file_comparison[
                "file_solved_bv_decide_bb_times_average"
            ],
            "solved_bv_decide_sat_times_average": file_comparison[
                "file_solved_bv_decide_sat_times_average"
            ],
            "solved_bv_decide_lratt_times_average": file_comparison[
                "file_solved_bv_decide_lratt_times_average"
            ],
            "solved_bv_decide_lratc_times_average": file_comparison[
                "file_solved_bv_decide_lratc_times_average"
            ],
        }
    )

    errors_df = pd.DataFrame({"errors_bitwuzla": file_comparison["errors"]})

    ceg_df.to_csv(raw_data_dir + file_result[0].split("/")[-1] + "_ceg_data.csv")
    print(raw_data_dir + file_result[0].split("/")[-1] + "_ceg_data.csv")
    solved_df.to_csv(raw_data_dir + file_result[0].split("/")[-1] + "_solved_data.csv")
    print(raw_data_dir + file_result[0].split("/")[-1] + "_solved_data.csv")
    errors_df.to_csv(raw_data_dir + file_result[0].split("/")[-1] + "_err_data.csv")
    print(raw_data_dir + file_result[0].split("/")[-1] + "_err_data.csv")
