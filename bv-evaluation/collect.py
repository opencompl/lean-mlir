import argparse
import os
import csv
import subprocess
from pathlib import Path
from enum import Enum
from collections import Counter
import numpy as np
import pandas as pd
import shutil

def geomean(xs):
    xs = [x for x in xs if x > 0]
    if xs:
        # (x1 x2 ... xn)^1/n
        # = e^([log x1 + log x2 + ... + log xn] / n)
        # = e^(mean(log(xs)))
        return np.exp(np.mean(np.log(np.array(xs))))
    else:
        return 0

bv_width = [4, 8, 16, 32, 64]

ROOT_DIR = (
    subprocess.check_output(["git", "rev-parse", "--show-toplevel"])
    .decode("utf-8")
    .strip()
)

output = Enum("output", [("counterexample", 1), ("proved", 2), ("failed", 0)])
# paper_directory = ""
# benchmark_dir = "../SSA/Projects/InstCombine/tests/proofs/"
# res_dir = "results/InstCombine/"
# raw_data_dir = paper_directory + "raw-data/InstCombine/"

RAW_DATA_DIR_SMTLIB = ROOT_DIR + "/bv-evaluation/raw-data/SMT-LIB"
RESULTS_DIR_SMTLIB = ROOT_DIR + "/bv-evaluation/results/SMT-LIB"
SOLVERS_SMTLIB = ["bitwuzla", "bv_decide", "bv_decide-nokernel", "coqQFBV"]
FIELDNAMES_SMTLIB = {
    "bitwuzla": ["benchmark", "result", "total"],
    "bv_decide": [
        "benchmark",
        "result",
        "leanSAT-ld",
        "leanSAT-ps",
        "leanSAT-rr",
        "leanSAT-ac",
        "leanSAT-af",
        "leanSAT-ecs",
        "leanSAT-bb",
        "leanSAT-sat",
        "leanSAT-lrat",
        "leanSAT-kc",
        "total",
    ],
    "bv_decide-nokernel": [
        "benchmark",
        "result",
        "leanSAT-ld",
        "leanSAT-ps",
        "leanSAT-rr",
        "leanSAT-ac",
        "leanSAT-af",
        "leanSAT-ecs",
        "leanSAT-bb",
        "leanSAT-sat",
        "leanSAT-lrat",
        "leanSAT-kc",
        "total",
    ],
    "coqQFBV": ["benchmark", "result", "total"],
}


def parse_log_file(filepath):
    data = {
        "benchmark": filepath,
        "result": "unknown",
        "leanSAT-ld": 0,
        "leanSAT-ps": 0,
        "leanSAT-rr": 0,
        "leanSAT-ac": 0,
        "leanSAT-af": 0,
        "leanSAT-ecs": 0,
        "leanSAT-bb": 0,
        "leanSAT-sat": 0,
        "leanSAT-lrat": 0,
        "leanSAT-kc": 0,
        "total": 0,
    }

    with open(filepath, "r") as file:
        for line in file:
            if "load:" in line:
                data["leanSAT-ld"] += int(line.split("load:")[1].strip())
            elif "parse:" in line:
                data["leanSAT-ps"] += int(line.split("parse:")[1].strip())
            elif "rewriteRules:" in line:
                data["leanSAT-rr"] += int(line.split("rewriteRules:")[1].strip())
            elif "bv_ac_nf:" in line:
                data["leanSAT-ac"] += int(line.split("bv_ac_nf:")[1].strip())
            elif "andFlattening:" in line:
                data["leanSAT-af"] += int(line.split("andFlattening:")[1].strip())
            elif "embeddedConstraintSubsitution:" in line:
                data["leanSAT-ecs"] += int(
                    line.split("embeddedConstraintSubsitution:")[1].strip()
                )
            elif "bitblast:" in line:
                data["leanSAT-bb"] += int(line.split("bitblast:")[1].strip())
            elif "sat:" in line:
                data["leanSAT-sat"] += int(line.split("sat:")[1].strip())
            elif "lrat:" in line:
                data["leanSAT-lrat"] += int(line.split("lrat:")[1].strip())
            elif "kernel:" in line:
                data["leanSAT-kc"] += int(line.split("kernel:")[1].strip())
            elif "total:" in line:
                data["total"] += int(line.split("total:")[1].strip())
            elif "unsat\n" in line:
                data["result"] = "unsat"
            elif "sat\n" in line:
                data["result"] = "sat"
            elif "unknown\n" in line:
                data["result"] = "unknown"

    return data


def find_log_files(solver, directory):
    log_files = []
    for root, _, files in os.walk(directory):
        for file in files:
            if file.endswith(f"{solver}.stdout"):
                log_files.append(os.path.join(root, file))
    return log_files


def write_to_csv(solver, log_files, output_csv):
    with open(output_csv, "w", newline="") as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=FIELDNAMES_SMTLIB[solver])
        writer.writeheader()

        for filepath in log_files:
            data = parse_log_file(filepath)
            filtered_data = {k: data[k] for k in FIELDNAMES_SMTLIB[solver] if k in data}
            writer.writerow(filtered_data)


def collect_solver_data(solver, directory):
    log_files = find_log_files(solver, directory)
    if not log_files:
        print(f"No log files found for solver {solver} in {directory}")
        return
    Path(RAW_DATA_DIR_SMTLIB).mkdir(parents=True, exist_ok=True)
    output_csv = f"{RAW_DATA_DIR_SMTLIB}/{solver}_data.csv"
    write_to_csv(solver, log_files, output_csv)
    print(f"Data for solver {solver} has been written to {output_csv}")


def collect_smtlib_data(solver, directory):
    if solver == "all":
        for s in SOLVERS_SMTLIB:
            collect_solver_data(s, directory)
    else:
        collect_solver_data(solver, directory)


def clear_folder(results_dir):
    """Clears all files and subdirectories within the given directory."""
    if not os.path.exists(results_dir):
        return

    for item in os.listdir(results_dir):
        item_path = os.path.join(results_dir, item)
        try:
            if os.path.isfile(item_path) or os.path.islink(item_path):
                os.unlink(item_path)
            elif os.path.isdir(item_path):
                shutil.rmtree(item_path)
        except Exception as e:
            print(f"Failed to delete {item_path}. Reason: {e}")


RAW_DATA_DIR_HACKERSDELIGHT = ROOT_DIR + "/bv-evaluation/raw-data/HackersDelight/"
RESULTS_DIR_HACKERSDELIGHT = ROOT_DIR + "/bv-evaluation/results/HackersDelight/"
BENCHMARK_DIR_HACKERSDELIGHT = ROOT_DIR + "/SSA/Projects/InstCombine/HackersDelight/"

RAW_DATA_DIR_INSTCOMBINE = ROOT_DIR + "/bv-evaluation/raw-data/InstCombine/"
RESULTS_DIR_INSTCOMBINE = ROOT_DIR + "/bv-evaluation/results/InstCombine/"
BENCHMARK_DIR_INSTCOMBINE = ROOT_DIR + "/SSA/Projects/InstCombine/tests/proofs/"

TIMEOUT = 1800

def compare_solvers_on_file(file_result):
    benchmark_errors = []
    solved_bitwuzla_tot = 0
    counter_bitwuzla_tot = 0
    error_bitwuzla_tot = 0
    solved_bv_decide_tot = 0
    counter_bv_decide_tot = 0
    error_bv_decide_tot = 0

    benchmark_errors = []

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
    failed_bv_decide_and_bitwuzla = []
    failed_bitwuzla_only = []
    failed_bv_decide_only = []

    # stddev for the above data.
    file_solved_bitwuzla_times_stddev = []
    file_solved_bv_decide_times_stddev = []
    file_solved_bv_decide_rw_times_stddev = []
    file_solved_bv_decide_bb_times_stddev = []
    file_solved_bv_decide_sat_times_stddev = []
    file_solved_bv_decide_lratt_times_stddev = []
    file_solved_bv_decide_lratc_times_stddev = []

    for theorem_num, [output_bitwuzla, output_bv_decide] in enumerate(
        zip(file_result[1]["outputs_bitwuzla"], file_result[1]["outputs_bv_decide"])
    ):
        if output_bitwuzla == output.failed and output_bv_decide == output.failed:
            failed_bv_decide_and_bitwuzla.append(
                "theorem " + str(theorem_num) + " in " + file_result[0]
            )
        elif output_bitwuzla == output.failed and output_bv_decide == output.proved:
            print(
                "bitwuzla failed and bv_decide proved theorem "
                + str()
                + " in file "
                + file_result[0]
            )
            failed_bitwuzla_only.append(
                "theorem " + str(theorem_num) + " in " + file_result[0]
            )
        elif output_bitwuzla == output.proved and output_bv_decide == output.failed:
            print(
                "bitwuzla proved and bv_decide failed theorem "
                + str(theorem_num)
                + " in file "
                + file_result[0]
            )
            failed_bv_decide_only.append(
                "theorem " + str(theorem_num) + " in " + file_result[0]
            )
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
                np.mean(file_result[1]["counter_bv_decide_rw_times_average"][theorem_num])
            )
            file_counter_bv_decide_sat_times_average.append(
                np.mean(file_result[1]["counter_bv_decide_sat_times_average"][theorem_num])
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
                "INCONSISTENT RESULT: bitwuzla proved and bv_decide provided counterexample for theorem "
                + str(theorem_num)
                + " in file "
                + file_result[0]
            )
        elif output_bitwuzla == output.proved and output_bv_decide == output.proved:
            # only store these results if they're actually consistent between the two solvers
            file_solved_bitwuzla_times_average.append(
                np.mean(file_result[1]["solved_bitwuzla_times_average"][theorem_num])
            )
            file_solved_bitwuzla_times_stddev.append(np.std(file_result[1]["solved_bitwuzla_times_average"][theorem_num]))



            file_solved_bv_decide_times_average.append(
                np.mean(file_result[1]["solved_bv_decide_times_average"][theorem_num])
            )


            file_solved_bv_decide_times_stddev.append(np.std(file_result[1]["solved_bv_decide_times_average"][theorem_num]))

            file_solved_bv_decide_rw_times_average.append(
                np.mean(
                    file_result[1]["solved_bv_decide_rw_times_average"][theorem_num]
                )
            )
            file_solved_bv_decide_rw_times_stddev.append(np.std(file_result[1]["solved_bv_decide_rw_times_average"][theorem_num]))

            file_solved_bv_decide_bb_times_average.append(
                np.mean(
                    file_result[1]["solved_bv_decide_bb_times_average"][theorem_num]
                )
            )

            file_solved_bv_decide_bb_times_stddev.append(np.std(file_result[1]["solved_bv_decide_bb_times_average"][theorem_num]))

            file_solved_bv_decide_sat_times_average.append(
                np.mean(
                    file_result[1]["solved_bv_decide_sat_times_average"][theorem_num]
                )
            )
            file_solved_bv_decide_sat_times_stddev.append(np.std(file_result[1]["solved_bv_decide_sat_times_average"][theorem_num]))

            file_solved_bv_decide_lratt_times_average.append(
                np.mean(
                    file_result[1]["solved_bv_decide_lratt_times_average"][theorem_num]
                )
            )
            file_solved_bv_decide_lratt_times_stddev.append(np.std(file_result[1]["solved_bv_decide_lratt_times_average"][theorem_num]))

            file_solved_bv_decide_lratc_times_average.append(
                np.mean(
                    file_result[1]["solved_bv_decide_lratc_times_average"][theorem_num]
                )
            )
            file_solved_bv_decide_lratc_times_stddev.append(np.std(file_result[1]["solved_bv_decide_lratc_times_average"][theorem_num]))
        elif (
            output_bitwuzla == output.failed
            and output_bv_decide == output.counterexample
        ):
            print(
                "INCONSISTENT RESULT: bitwuzla failed and bv_decide provided counterexample for theorem "
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

    data = {
        "file_solved_bitwuzla_times_average": file_solved_bitwuzla_times_average,
        "file_counter_bitwuzla_times_average": file_counter_bitwuzla_times_average,
        "file_solved_bv_decide_times_average": file_solved_bv_decide_times_average,
        "file_solved_bv_decide_rw_times_average": file_solved_bv_decide_rw_times_average,
        "file_solved_bv_decide_bb_times_average": file_solved_bv_decide_bb_times_average,
        "file_solved_bv_decide_sat_times_average": file_solved_bv_decide_sat_times_average,
        "file_solved_bv_decide_lratt_times_average": file_solved_bv_decide_lratt_times_average,
        "file_solved_bv_decide_lratc_times_average": file_solved_bv_decide_lratc_times_average,
        "file_counter_bv_decide_times_average": file_counter_bv_decide_times_average,
        "file_counter_bv_decide_rw_times_average": file_counter_bv_decide_rw_times_average,
        "file_counter_bv_decide_sat_times_average": file_counter_bv_decide_sat_times_average,
        "failed_bv_decide_and_bitwuzla": failed_bv_decide_and_bitwuzla,
        "failed_bitwuzla_only": failed_bitwuzla_only,
        "failed_bv_decide_only": failed_bv_decide_only,
        "file_solved_bitwuzla_times_stddev": file_solved_bitwuzla_times_stddev,
        "file_solved_bv_decide_times_stddev": file_solved_bv_decide_times_stddev,
        "file_solved_bv_decide_rw_times_stddev": file_solved_bv_decide_rw_times_stddev,
        "file_solved_bv_decide_bb_times_stddev": file_solved_bv_decide_bb_times_stddev,
        "file_solved_bv_decide_sat_times_stddev": file_solved_bv_decide_sat_times_stddev,
        "file_solved_bv_decide_lratt_times_stddev": file_solved_bv_decide_lratt_times_stddev,
        "file_solved_bv_decide_lratc_times_stddev":  file_solved_bv_decide_lratc_times_stddev,
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
                        counter_bitwuzla_times_average.append([float(-1)])
                        solved_bitwuzla_times_average.append([float(-1)])
                    else:
                        counter_bitwuzla_times_average[thm].append(float(-1))
                        solved_bitwuzla_times_average[thm].append(float(-1))
                elif "counter" in file_line:
                    # Append `-1` in the solved times only, append solving time in the counterexample times
                    tot = float(file_line.split("after ")[1].split("ms")[0])
                    if r == 0:
                        outputs_bitwuzla.append(output.counterexample)
                        counter_bitwuzla_times_average.append([tot])
                        solved_bitwuzla_times_average.append([float(-1)])
                    else:
                        counter_bitwuzla_times_average[thm].append(tot)
                        solved_bitwuzla_times_average[thm].append(float(-1))
                elif "proved" in file_line:
                    # Append `-1` in the counterexample times only, append solving time in the solved times
                    tot = float(file_line.split("after ")[1].split("ms")[0])
                    if r == 0:
                        outputs_bitwuzla.append(output.proved)
                        solved_bitwuzla_times_average.append([tot])
                        counter_bitwuzla_times_average.append([float(-1)])
                    else:
                        solved_bitwuzla_times_average[thm].append(tot)
                        counter_bitwuzla_times_average[thm].append(float(-1))
                else:
                    raise Exception("Unknown error in " + file_name)
                # if bitwuzla output was successful, analyze the next output
                file_line = res_file.readline()
                if "LeanSAT " in file_line:
                    if "failed" in file_line:
                        if "gdivhshift_proof" in file_name and thm == 46:
                            print(file_line)
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
                            solved_bv_decide_lratt_times_average[thm].append(
                                float(-1)
                            )
                            solved_bv_decide_lratc_times_average[thm].append(
                                float(-1)
                            )
                    elif "counter " in file_line:
                        if r == 0:
                            outputs_bv_decide.append(output.counterexample)
                            counter_bv_decide_times_average.append(
                                float([file_line.split("ms")[0].split("after ")[1]])
                            )
                            counter_bv_decide_rw_times_average.append(
                                float([file_line.split(" SAT")[0].split("rewriting ")[1]])
                            )
                            counter_bv_decide_sat_times_average.append(
                                float([file_line.split("ms")[1].split("solving ")[1]])
                            )
                            solved_bv_decide_times_average.append([float(-1)])
                            solved_bv_decide_rw_times_average.append([float(-1)])
                            solved_bv_decide_bb_times_average.append([float(-1)])
                            solved_bv_decide_sat_times_average.append([float(-1)])
                            solved_bv_decide_lratt_times_average.append([float(-1)])
                            solved_bv_decide_lratc_times_average.append([float(-1)])
                        else:
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
                        else:
                            solved_bv_decide_times_average[thm].append(
                                float(file_line.split("ms")[0].split("r ")[1])
                            )
                            solved_bv_decide_rw_times_average[thm].append(
                                float(file_line.split("ms")[1].split("g ")[1])
                            )
                            solved_bv_decide_bb_times_average[thm].append(
                                float(file_line.split("ms")[2].split("g ")[1])
                            )
                            solved_bv_decide_sat_times_average[thm].append(
                                float(file_line.split("ms")[3].split("g ")[1])
                            )
                            solved_bv_decide_lratt_times_average[thm].append(
                                float(file_line.split("ms")[4].split("g ")[1])
                            )
                            solved_bv_decide_lratc_times_average[thm].append(
                                float(file_line.split("ms")[5].split("g ")[1])
                            )
                            counter_bv_decide_times_average[thm].append(float(-1))
                            counter_bv_decide_rw_times_average[thm].append(float(-1))
                            counter_bv_decide_sat_times_average[thm].append(float(-1))
                    thm = thm + 1
                else:
                    raise Exception("Unknown error in " + file_name)
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


def run_shell_command_and_assert_output_eq_int(
    cwd: str, cmd: str, expected_val: int
) -> int:
    response = subprocess.check_output(cmd, shell=True, cwd=cwd, text=True)
    val = int(response)
    failed = val != expected_val
    failed_str = "FAIL" if failed else "SUCCESS"
    print(f"ran {cmd}, this file found {expected_val}, rg found {val}, {failed_str}")


def save_counterexample_df(
    all_files_counter_bitwuzla_times_average: list,
    all_files_counter_bv_decide_times_average: list,
    all_files_counter_bv_decide_rw_times_average: list,
    all_files_counter_bv_decide_sat_times_average: list,
    csv_name: str,
):
    ceg_df = pd.DataFrame(
        {
            "counter_bitwuzla_times_average": all_files_counter_bitwuzla_times_average,
            "counter_bv_decide_times_average": all_files_counter_bv_decide_times_average,
            "counter_bv_decide_rw_times_average": all_files_counter_bv_decide_rw_times_average,
            "counter_bv_decide_sat_times_average": all_files_counter_bv_decide_sat_times_average,
        }
    )

    ceg_df.to_csv(csv_name)
    print("Saved dataframe at: " + csv_name)


def save_solved_df(
    all_files_solved_bitwuzla_times_average: list,
    all_files_solved_bv_decide_times_average: list,
    all_files_solved_bv_decide_rw_times_average: list,
    all_files_solved_bv_decide_bb_times_average: list,
    all_files_solved_bv_decide_sat_times_average: list,
    all_files_solved_bv_decide_lratt_times_average: list,
    all_files_solved_bv_decide_lratc_times_average: list,
    all_files_solved_bitwuzla_times_stddev: list,
    all_files_solved_bv_decide_times_stddev: list,
    all_files_solved_bv_decide_rw_times_stddev: list,
    all_files_solved_bv_decide_bb_times_stddev: list,
    all_files_solved_bv_decide_sat_times_stddev: list,
    all_files_solved_bv_decide_lratt_times_stddev: list,
    all_files_solved_bv_decide_lratc_times_stddev: list,

    csv_name: str,
):
    solved_df = pd.DataFrame(
        {
            "solved_bitwuzla_times_average": all_files_solved_bitwuzla_times_average,
            "solved_bv_decide_times_average": all_files_solved_bv_decide_times_average,
            "solved_bv_decide_rw_times_average": all_files_solved_bv_decide_rw_times_average,
            "solved_bv_decide_bb_times_average": all_files_solved_bv_decide_bb_times_average,
            "solved_bv_decide_sat_times_average": all_files_solved_bv_decide_sat_times_average,
            "solved_bv_decide_lratt_times_average": all_files_solved_bv_decide_lratt_times_average,
            "solved_bv_decide_lratc_times_average": all_files_solved_bv_decide_lratc_times_average,
            "solved_bitwuzla_times_stddev": all_files_solved_bitwuzla_times_stddev,
            "solved_bv_decide_times_stddev": all_files_solved_bv_decide_times_stddev,
            "solved_bv_decide_rw_times_stddev": all_files_solved_bv_decide_rw_times_stddev,
            "solved_bv_decide_bb_times_stddev": all_files_solved_bv_decide_bb_times_stddev,
            "solved_bv_decide_sat_times_stddev": all_files_solved_bv_decide_sat_times_stddev,
            "solved_bv_decide_lratt_times_stddev": all_files_solved_bv_decide_lratt_times_stddev,
            "solved_bv_decide_lratc_times_stddev": all_files_solved_bv_decide_lratc_times_stddev,
        }
    )
    solved_df.to_csv(csv_name)
    print("Saved dataframe at: " + csv_name)


def collect(benchmark: str, reps : int):
    if benchmark == "instcombine":
        file_data = []

        for file in os.listdir(BENCHMARK_DIR_INSTCOMBINE):
            if "_proof" in file:
                file_name = RESULTS_DIR_INSTCOMBINE + file.split(".")[0]
                parsed_results = parse_file(file_name, reps)
                file_data.append([file_name, parsed_results])

        clear_folder(RAW_DATA_DIR_INSTCOMBINE)

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
        all_files_failed_bv_decide_and_bitwuzla = []
        all_files_failed_bv_decide_only = []
        all_files_failed_bitwuzla_only = []
        all_files_solved_bitwuzla_times_stddev = []
        all_files_solved_bv_decide_times_stddev = []
        all_files_solved_bv_decide_rw_times_stddev = []
        all_files_solved_bv_decide_bb_times_stddev = []
        all_files_solved_bv_decide_sat_times_stddev = []
        all_files_solved_bv_decide_lratt_times_stddev = []
        all_files_solved_bv_decide_lratc_times_stddev = []

        solved_bitwuzla_tot = 0
        counter_bitwuzla_tot = 0
        error_bitwuzla_tot = 0
        solved_bv_decide_tot = 0
        counter_bv_decide_tot = 0
        error_bv_decide_tot = 0
        benchmarks_errors = []

        for file_result in file_data:
            count_bitwuzla = Counter(file_result[1]["outputs_bitwuzla"])
            count_bv_decide = Counter(file_result[1]["outputs_bv_decide"])

            solved_bitwuzla_tot += count_bitwuzla[output.proved]
            counter_bitwuzla_tot += count_bitwuzla[output.counterexample]
            error_bitwuzla_tot += count_bitwuzla[output.failed]

            solved_bv_decide_tot += count_bv_decide[output.proved]
            counter_bv_decide_tot += count_bv_decide[output.counterexample]
            error_bv_decide_tot += count_bv_decide[output.failed]

            file_comparison = compare_solvers_on_file(file_result)
            for tmp in file_comparison["file_solved_bitwuzla_times_average"]:
                all_files_solved_bitwuzla_times_average.append(tmp)

            for tmp in file_comparison["file_counter_bitwuzla_times_average"]:
                all_files_counter_bitwuzla_times_average.append(tmp)

            for tmp in file_comparison["file_solved_bv_decide_times_average"]:
                all_files_solved_bv_decide_times_average.append(tmp)

            for tmp in file_comparison["file_solved_bv_decide_rw_times_average"]:
                all_files_solved_bv_decide_rw_times_average.append(tmp)

            for tmp in file_comparison["file_solved_bv_decide_bb_times_average"]:
                all_files_solved_bv_decide_bb_times_average.append(tmp)

            for tmp in file_comparison["file_solved_bv_decide_sat_times_average"]:
                all_files_solved_bv_decide_sat_times_average.append(tmp)

            for tmp in file_comparison["file_solved_bv_decide_lratt_times_average"]:
                all_files_solved_bv_decide_lratt_times_average.append(tmp)

            for tmp in file_comparison["file_solved_bv_decide_lratc_times_average"]:
                all_files_solved_bv_decide_lratc_times_average.append(tmp)

            for tmp in file_comparison["file_counter_bv_decide_times_average"]:
                all_files_counter_bv_decide_times_average.append(tmp)

            for tmp in file_comparison["file_counter_bv_decide_rw_times_average"]:
                all_files_counter_bv_decide_rw_times_average.append(tmp)

            for tmp in file_comparison["file_counter_bv_decide_sat_times_average"]:
                all_files_counter_bv_decide_sat_times_average.append(tmp)

            for tmp in file_comparison["failed_bv_decide_and_bitwuzla"]:
                all_files_failed_bv_decide_and_bitwuzla.append(tmp)

            for tmp in file_comparison["failed_bitwuzla_only"]:
                all_files_failed_bitwuzla_only.append(tmp)

            for tmp in file_comparison["failed_bv_decide_only"]:
                all_files_failed_bv_decide_only.append(tmp)

            for tmp in file_comparison["file_solved_bitwuzla_times_stddev"]:
                all_files_solved_bitwuzla_times_stddev.append(tmp)

            for tmp in file_comparison["file_solved_bv_decide_times_stddev"]:
                all_files_solved_bv_decide_times_stddev.append(tmp)

            for tmp in file_comparison["file_solved_bv_decide_rw_times_stddev"]:
                all_files_solved_bv_decide_rw_times_stddev.append(tmp)

            for tmp in file_comparison["file_solved_bv_decide_bb_times_stddev"]:
                all_files_solved_bv_decide_bb_times_stddev.append(tmp)

            for tmp in file_comparison["file_solved_bv_decide_sat_times_stddev"]:
                all_files_solved_bv_decide_sat_times_stddev.append(tmp)

            for tmp in file_comparison["file_solved_bv_decide_lratt_times_stddev"]:
                all_files_solved_bv_decide_lratt_times_stddev.append(tmp)

            for tmp in file_comparison["file_solved_bv_decide_lratc_times_stddev"]:
                all_files_solved_bv_decide_lratc_times_stddev.append(tmp)

            for tmp in file_comparison["errors"]:
                benchmarks_errors.append(tmp)

        df_errors = pd.DataFrame({'errors':benchmarks_errors})

        df_errors.to_csv(RAW_DATA_DIR_INSTCOMBINE + "instcombine_err_data.csv")

        print("bv_decide solved " + str(solved_bv_decide_tot) + " theorems.")
        print("bitwuzla solved " + str(solved_bitwuzla_tot) + " theorems.")
        print("bv_decide found " + str(counter_bv_decide_tot) + " counterexamples.")
        print("bitwuzla found " + str(counter_bitwuzla_tot) + " counterexamples.")
        print(
            "bv_decide only failed on "
            + str(len(all_files_failed_bv_decide_only))
            + " problems."
        )
        print(
            "bitwuzla only failed on "
            + str(len(all_files_failed_bitwuzla_only))
            + " problems."
        )
        print(
            "both bitwuzla and bv_decide failed on "
            + str(len(all_files_failed_bv_decide_and_bitwuzla))
            + " problems."
        )
        print(
            "In total, bitwuzla saw "
            + str(counter_bitwuzla_tot + solved_bitwuzla_tot + error_bitwuzla_tot)
            + " problems."
        )
        print(
            "In total, bv_decide saw "
            + str(counter_bv_decide_tot + solved_bv_decide_tot + error_bv_decide_tot)
            + " problems."
        )

        run_shell_command_and_assert_output_eq_int(
            "results/InstCombine/",
            "rg 'LeanSAT provided a counter' | wc -l",
            reps * len(all_files_counter_bv_decide_times_average),
        )
        run_shell_command_and_assert_output_eq_int(
            "results/InstCombine/",
            "rg 'Bitwuzla provided a counter' | wc -l",
            reps * len(all_files_counter_bitwuzla_times_average),
        )
        run_shell_command_and_assert_output_eq_int(
            "results/InstCombine/",
            "rg 'LeanSAT proved' | wc -l",
            reps * len(all_files_solved_bv_decide_times_average)
            + reps * len(all_files_failed_bitwuzla_only),
        )
        run_shell_command_and_assert_output_eq_int(
            "results/InstCombine/",
            "rg 'Bitwuzla proved' | wc -l",
            reps * len(all_files_solved_bitwuzla_times_average)
            + reps * len(all_files_failed_bv_decide_only),
        )
        response = subprocess.check_output(
            "cat "
            + ROOT_DIR
            + "/SSA/Projects/InstCombine/tests/proofs/*_proof.lean  | grep theorem | wc -l",
            shell=True,
            text=True,
        )
        val = int(response)
        print("The InstCombine benchmark contains " + str(val) + " theorems in total.")

        save_counterexample_df(
            all_files_counter_bitwuzla_times_average,
            all_files_counter_bv_decide_times_average,
            all_files_counter_bv_decide_rw_times_average,
            all_files_counter_bv_decide_sat_times_average,
            RAW_DATA_DIR_INSTCOMBINE + "instcombine_ceg_data.csv",
        )
        # print("median of all_files_solved_bitwuzla_times_stddev "+str(np.median(all_files_solved_bitwuzla_times_stddev)))
        # print("median of all_files_solved_bv_decide_times_stddev "+str(np.median(all_files_solved_bv_decide_times_stddev)))
        # print("median of all_files_solved_bv_decide_rw_times_stddev "+str(np.median(all_files_solved_bv_decide_rw_times_stddev)))
        # print("median of all_files_solved_bv_decide_bb_times_stddev "+str(np.median(all_files_solved_bv_decide_bb_times_stddev)))
        # print("median of all_files_solved_bv_decide_sat_times_stddev "+str(np.median(all_files_solved_bv_decide_sat_times_stddev)))
        # print("median of all_files_solved_bv_decide_lratt_times_stddev "+str(np.median(all_files_solved_bv_decide_lratt_times_stddev)))
        # print("median of all_files_solved_bv_decide_lratc_times_stddev "+str(np.median(all_files_solved_bv_decide_lratc_times_stddev)))

        print("all_files_solved_bitwuzla_times_stddev" + " avg: " + str(np.median(all_files_solved_bitwuzla_times_average)) + " | stddev:  "+str(np.median(all_files_solved_bitwuzla_times_stddev)))
        print("all_files_solved_bv_decide_times_stddev" + " avg: " + str(np.median(all_files_solved_bv_decide_times_average)) + " | stddev:  "+str(np.median(all_files_solved_bv_decide_times_stddev)))
        print("all_files_solved_bv_decide_rw_times_stddev" + " avg: " + str(np.median(all_files_solved_bv_decide_rw_times_average)) + " | stddev:  "+str(np.median(all_files_solved_bv_decide_rw_times_stddev)))
        print("all_files_solved_bv_decide_bb_times_stddev" + " avg: " + str(np.median(all_files_solved_bv_decide_bb_times_average)) + " | stddev:  "+str(np.median(all_files_solved_bv_decide_bb_times_stddev)))
        print("all_files_solved_bv_decide_sat_times_stddev" + " avg: " + str(np.median(all_files_solved_bv_decide_sat_times_average)) + " | stddev:  "+str(np.median(all_files_solved_bv_decide_sat_times_stddev)))
        print("all_files_solved_bv_decide_lratt_times_stddev" + " avg: " + str(np.median(all_files_solved_bv_decide_lratt_times_average)) + " | stddev:  "+str(np.median(all_files_solved_bv_decide_lratt_times_stddev)))
        print("all_files_solved_bv_decide_lratc_times_stddev" + " avg: " + str(np.median(all_files_solved_bv_decide_lratc_times_average)) + " | stddev:  "+str(np.median(all_files_solved_bv_decide_lratc_times_stddev)))

        ratios = []
        for avg, stddev in zip(all_files_solved_bv_decide_times_average, all_files_solved_bv_decide_times_stddev):
            ratio = (stddev/avg) * 100
            ratios.append(ratio)

        print("mean of percentage stddev/av: "+str(np.mean(ratios)) + "%")
        print("max of percentage stddev/av: "+str(np.max(ratios))+ "%")


        save_solved_df(
            all_files_solved_bitwuzla_times_average,
            all_files_solved_bv_decide_times_average,
            all_files_solved_bv_decide_rw_times_average,
            all_files_solved_bv_decide_bb_times_average,
            all_files_solved_bv_decide_sat_times_average,
            all_files_solved_bv_decide_lratt_times_average,
            all_files_solved_bv_decide_lratc_times_average,
            all_files_solved_bitwuzla_times_stddev,
            all_files_solved_bv_decide_times_stddev,
            all_files_solved_bv_decide_rw_times_stddev,
            all_files_solved_bv_decide_bb_times_stddev,
            all_files_solved_bv_decide_sat_times_stddev,
            all_files_solved_bv_decide_lratt_times_stddev,
            all_files_solved_bv_decide_lratc_times_stddev,
            RAW_DATA_DIR_INSTCOMBINE + "instcombine_solved_data.csv",
        )

        geomean_time_instcombine_bvdecide = geomean(all_files_solved_bv_decide_times_average)
        geomean_time_instcombine_bitwuzla = geomean(all_files_solved_bitwuzla_times_average)
        all_files_slowdown = np.array(all_files_solved_bv_decide_times_average) /np.array(all_files_solved_bitwuzla_times_average)
        geomean_slowdown_instcombine = geomean(all_files_slowdown)
        mean_slowdown_instcombine = np.mean(all_files_slowdown)

        with open("performance-instcombine.tex", "w") as f:
            f.write(r"\newcommand{\InstCombineNProblemsTot}{" + str(counter_bv_decide_tot + solved_bv_decide_tot + error_bv_decide_tot) + "}\n")
            f.write(r"\newcommand{\InstCombineNumProblemsSolved}{" + str(solved_bv_decide_tot) + "}\n")
            f.write(r"\newcommand{\InstCombineGeomeanBvDecide}{" + str("%.2f" % geomean_time_instcombine_bvdecide) + "}\n")
            f.write(r"\newcommand{\InstCombineGeomeanBitwuzla}{" + str("%.2f" %geomean_time_instcombine_bitwuzla) + "}\n")
            f.write(r"\newcommand{\InstCombineGeomeanSlowdown}{" + str("%.2f" % geomean_slowdown_instcombine) + "}\n")
            f.write(r"\newcommand{\InstCombineMeanSlowdown}{" + str("%.2f" % mean_slowdown_instcombine) + "}\n")
            f.write(r"\newcommand{\InstCombineBothFailed}{" + str(len(all_files_failed_bv_decide_and_bitwuzla)) + "}\n")
            f.write(r"\newcommand{\InstCombineOnlyBvDecideFailed}{" + str(len(all_files_failed_bv_decide_only)) + "}\n")
            f.write(r"\newcommand{\InstCombineOnlyBitwuzlaFailed}{" + str(len(all_files_failed_bitwuzla_only)) + "}\n")


    elif benchmark == "hackersdelight":
        clear_folder(RAW_DATA_DIR_HACKERSDELIGHT)

        file_data = []

        for file in os.listdir(BENCHMARK_DIR_HACKERSDELIGHT):
            for bvw in bv_width:
                file_name = (
                    RESULTS_DIR_HACKERSDELIGHT + file.split(".")[0] + "_" + str(bvw)
                )

                file_data.append([file_name, parse_file(file_name, reps)])

        for file_result in file_data:
            print(file_result[0])

            file_comparison = compare_solvers_on_file(file_result)

            # for hackers'delight we want to produce a single .csv dataframe per file per bitwidth

            # sanity_check_times(file_comparison)
            print(file_comparison['errors'])

            df_errors = pd.DataFrame({'errors':file_comparison['errors']})

            df_errors.to_csv(RAW_DATA_DIR_HACKERSDELIGHT + "hackersdelight_err_data.csv")

            save_counterexample_df(
                file_comparison["file_counter_bitwuzla_times_average"],
                file_comparison["file_counter_bv_decide_times_average"],
                file_comparison["file_counter_bv_decide_rw_times_average"],
                file_comparison["file_counter_bv_decide_sat_times_average"],
                RAW_DATA_DIR_HACKERSDELIGHT
                + file_result[0].split("/")[-1]
                + "_ceg_data.csv"
            )

            save_solved_df(
                file_comparison["file_solved_bitwuzla_times_average"],
                file_comparison["file_solved_bv_decide_times_average"],
                file_comparison["file_solved_bv_decide_rw_times_average"],
                file_comparison["file_solved_bv_decide_bb_times_average"],
                file_comparison["file_solved_bv_decide_sat_times_average"],
                file_comparison["file_solved_bv_decide_lratt_times_average"],
                file_comparison["file_solved_bv_decide_lratc_times_average"],
                file_comparison["file_solved_bitwuzla_times_stddev"],
                file_comparison["file_solved_bv_decide_times_stddev"],
                file_comparison["file_solved_bv_decide_rw_times_stddev"],
                file_comparison["file_solved_bv_decide_bb_times_stddev"],
                file_comparison["file_solved_bv_decide_sat_times_stddev"],
                file_comparison["file_solved_bv_decide_lratt_times_stddev"],
                file_comparison["file_solved_bv_decide_lratc_times_stddev"],
                RAW_DATA_DIR_HACKERSDELIGHT
                + file_result[0].split("/")[-1]
                + "_solved_data.csv",
            )

            errors_df = pd.DataFrame({"errors_bitwuzla": file_comparison["errors"]})

            errors_df.to_csv(
                RAW_DATA_DIR_HACKERSDELIGHT
                + file_result[0].split("/")[-1]
                + "_err_data.csv"
            )
            print(
                RAW_DATA_DIR_HACKERSDELIGHT
                + file_result[0].split("/")[-1]
                + "_err_data.csv"
            )

    elif benchmark == "smtlib":
        clear_folder(RAW_DATA_DIR_SMTLIB)
        collect_smtlib_data("all", RESULTS_DIR_SMTLIB)

    else:
        raise Exception("Unknown benchmark " + benchmark)


def main():
    parser = argparse.ArgumentParser(
        prog="compare",
        description="Compare the performance of bv_decide vs. bitwuzla",
    )

    parser.add_argument(
        "benchmark",
        nargs="+",
        choices=["all", "hackersdelight", "instcombine", "alive", "smtlib"],
    )
    parser.add_argument("-j", "--jobs", type=int, default=1)
    parser.add_argument("-r", "--repetitions", type=int, default=1)

    args = parser.parse_args()
    benchmarks_to_run = (
        ["hackersdelight", "instcombine"] if "all" in args.benchmark else args.benchmark
    )
    reps = args.repetitions

    for b in benchmarks_to_run:
        collect(b, reps=reps)


if __name__ == "__main__":
    main()
