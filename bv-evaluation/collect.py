import argparse
import os
import subprocess
from enum import Enum
from collections import Counter
import numpy as np
import pandas as pd
import shutil

bv_width = [4, 8, 16, 32, 64]

ROOT_DIR = (
    subprocess.check_output(["git", "rev-parse", "--show-toplevel"])
    .decode("utf-8")
    .strip()
)

output = Enum("output", [("counterexample", 1), ("proved", 2), ("failed", 0)])

RAW_DATA_DIR_HACKERSDELIGHT = ROOT_DIR + "/bv-evaluation/raw-data/HackersDelight/"
RESULTS_DIR_HACKERSDELIGHT = ROOT_DIR + "/bv-evaluation/results/HackersDelight/"
BENCHMARK_DIR_HACKERSDELIGHT = ROOT_DIR + "/SSA/Projects/InstCombine/HackersDelight/"

RAW_DATA_DIR_INSTCOMBINE = ROOT_DIR + "/bv-evaluation/raw-data/InstCombine/"
RESULTS_DIR_INSTCOMBINE = ROOT_DIR + "/bv-evaluation/results/InstCombine/"
BENCHMARK_DIR_INSTCOMBINE = ROOT_DIR + "/SSA/Projects/InstCombine/tests/proofs/"

TIMEOUT = 1800

REPS = 1


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


def sanity_check_bv_decide_times(df: pd.DataFrame, df_name: str):
    """
    Checks that for every entry, bv_decide_times_average is within +/- 20%
    of the sum of its component times (rw, bb, sat, lratt, lratc).
    Ignores entries where bv_decide_times_average is -1 (failed/timeout).
    """
    print(f"\n--- Validating bv_decide times for {df_name} ---")

    # Define the columns that sum up to bv_decide_times_average
    component_cols = [
        "solved_bv_decide_rw_times_average",
        "solved_bv_decide_bb_times_average",
        "solved_bv_decide_sat_times_average",
        "solved_bv_decide_lratt_times_average",
        "solved_bv_decide_lratc_times_average",
    ]

    # Filter out rows where solved_bv_decide_times_average is -1 (indicating failure/timeout)
    # Also, ensure all component columns are present and their values are not -1
    valid_rows = df[(df["solved_bv_decide_times_average"] != -1)].copy()

    # Check if all component columns exist in the DataFrame
    missing_cols = [col for col in component_cols if col not in valid_rows.columns]
    if missing_cols:
        print(f"Skipping validation for {df_name}: Missing columns {missing_cols}")
        return

    # Further filter out rows where any of the component times are -1, as they wouldn't sum correctly
    for col in component_cols:
        valid_rows = valid_rows[valid_rows[col] != -1]

    if valid_rows.empty:
        print(f"No valid entries to check for {df_name} after filtering.")
        return

    # Calculate the sum of component times
    valid_rows["component_sum"] = valid_rows[component_cols].sum(axis=1)

    # Define the tolerance
    tolerance = 0.30  # 20%

    # Calculate the lower and upper bounds for validation
    valid_rows["lower_bound"] = valid_rows["solved_bv_decide_times_average"] * (
        1 - tolerance
    )
    valid_rows["upper_bound"] = valid_rows["solved_bv_decide_times_average"] * (
        1 + tolerance
    )

    # Check if solved_bv_decide_times_average is within the allowed range
    # Add a small epsilon for floating point comparison to prevent minor inaccuracies from failing
    valid_rows["is_valid"] = (
        valid_rows["component_sum"] >= np.floor(valid_rows["lower_bound"])
    ) & (valid_rows["component_sum"] <= np.ceil(valid_rows["upper_bound"]))

    # Report discrepancies
    discrepancies = valid_rows[~valid_rows["is_valid"]]

    if not discrepancies.empty:
        print(f"Discrepancies found in {df_name}:")
        for index, row in discrepancies.iterrows():
            print(
                f"Row {index}: "
                f"Actual total time: {row['solved_bv_decide_times_average']:.2f}, "
                f"Component sum: {row['component_sum']:.2f}, "
                f"Expected range: [{row['lower_bound']:.2f}, {row['upper_bound']:.2f}]"
            )
        print(
            f"Total discrepancies: {len(discrepancies)} out of {len(valid_rows)} valid entries."
        )
    else:
        print(
            f"All bv_decide times in {df_name} are consistent with their components within +/- {tolerance * 100}% tolerance."
        )


def compare_solvers_on_file(file_result):
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
                    else:
                        # Ensure list exists before appending
                        if thm >= len(counter_bitwuzla_times_average):
                            counter_bitwuzla_times_average.append(float(-1))
                        else:
                            # If it was a list (from proved/counter) convert to float and then append
                            if isinstance(counter_bitwuzla_times_average[thm], list):
                                counter_bitwuzla_times_average[thm] = float(
                                    -1
                                )  # Overwrite if it was a list of timings
                            else:
                                counter_bitwuzla_times_average[thm] = float(
                                    -1
                                )  # Already a float

                        if thm >= len(solved_bitwuzla_times_average):
                            solved_bitwuzla_times_average.append(float(-1))
                        else:
                            if isinstance(solved_bitwuzla_times_average[thm], list):
                                solved_bitwuzla_times_average[thm] = float(-1)
                            else:
                                solved_bitwuzla_times_average[thm] = float(-1)
                elif "counter" in file_line:
                    # Append `-1` in the solved times only, append solving time in the counterexample times
                    tot = float(file_line.split("after ")[1].split("ms")[0])
                    if r == 0:
                        outputs_bitwuzla.append(output.counterexample)
                        counter_bitwuzla_times_average.append([tot])
                        solved_bitwuzla_times_average.append(float(-1))
                    else:
                        # If it was a float(-1), convert to list and append
                        if thm >= len(counter_bitwuzla_times_average) or not isinstance(
                            counter_bitwuzla_times_average[thm], list
                        ):
                            counter_bitwuzla_times_average.insert(thm, [])
                        counter_bitwuzla_times_average[thm].append(tot)

                        if thm >= len(solved_bitwuzla_times_average):
                            solved_bitwuzla_times_average.append(
                                float(-1)
                            )  # Initialize if not present
                        elif isinstance(solved_bitwuzla_times_average[thm], list):
                            solved_bitwuzla_times_average[thm].append(float(-1))
                        else:
                            # It was a float, just set it if it was -1, else keep the original value
                            if solved_bitwuzla_times_average[thm] == float(-1):
                                solved_bitwuzla_times_average[thm] = float(-1)
                            else:  # If it was a proved time from a previous rep, keep it
                                pass  # No change needed if it already has a non-negative value

                elif "proved" in file_line:
                    # Append `-1` in the counterexample times only, append solving time in the solved times
                    tot = float(file_line.split("after ")[1].split("ms")[0])
                    if r == 0:
                        outputs_bitwuzla.append(output.proved)
                        solved_bitwuzla_times_average.append([tot])
                        counter_bitwuzla_times_average.append(float(-1))
                    else:
                        if thm >= len(solved_bitwuzla_times_average) or not isinstance(
                            solved_bitwuzla_times_average[thm], list
                        ):
                            solved_bitwuzla_times_average.insert(thm, [])
                        solved_bitwuzla_times_average[thm].append(tot)

                        if thm >= len(counter_bitwuzla_times_average):
                            counter_bitwuzla_times_average.append(float(-1))
                        elif isinstance(counter_bitwuzla_times_average[thm], list):
                            counter_bitwuzla_times_average[thm].append(float(-1))
                        else:
                            if counter_bitwuzla_times_average[thm] == float(-1):
                                counter_bitwuzla_times_average[thm] = float(-1)
                            else:
                                pass

                else:
                    raise Exception("Unknown error in " + file_name)
                # if bitwuzla output was successful, analyze the next output
                file_line = res_file.readline()
                if "LeanSAT " in file_line:
                    if "failed" in file_line:
                        if r == 0:
                            outputs_bv_decide.append(output.failed)
                            counter_bv_decide_times_average.append(
                                [float(-1)]
                            )  # Changed to list for consistency
                            counter_bv_decide_rw_times_average.append([float(-1)])
                            counter_bv_decide_sat_times_average.append([float(-1)])
                            solved_bv_decide_times_average.append([float(-1)])
                            solved_bv_decide_rw_times_average.append([float(-1)])
                            solved_bv_decide_bb_times_average.append([float(-1)])
                            solved_bv_decide_sat_times_average.append([float(-1)])
                            solved_bv_decide_lratt_times_average.append([float(-1)])
                            solved_bv_decide_lratc_times_average.append([float(-1)])
                        else:
                            if thm >= len(counter_bv_decide_times_average):
                                counter_bv_decide_times_average.append([])
                            counter_bv_decide_times_average[thm].append(float(-1))
                            if thm >= len(counter_bv_decide_rw_times_average):
                                counter_bv_decide_rw_times_average.append([])
                            counter_bv_decide_rw_times_average[thm].append(float(-1))
                            if thm >= len(counter_bv_decide_sat_times_average):
                                counter_bv_decide_sat_times_average.append([])
                            counter_bv_decide_sat_times_average[thm].append(float(-1))
                            if thm >= len(solved_bv_decide_times_average):
                                solved_bv_decide_times_average.append([])
                            solved_bv_decide_times_average[thm].append(float(-1))
                            if thm >= len(solved_bv_decide_rw_times_average):
                                solved_bv_decide_rw_times_average.append([])
                            solved_bv_decide_rw_times_average[thm].append(float(-1))
                            if thm >= len(solved_bv_decide_bb_times_average):
                                solved_bv_decide_bb_times_average.append([])
                            solved_bv_decide_bb_times_average[thm].append(float(-1))
                            if thm >= len(solved_bv_decide_sat_times_average):
                                solved_bv_decide_sat_times_average.append([])
                            solved_bv_decide_sat_times_average[thm].append(float(-1))
                            if thm >= len(solved_bv_decide_lratt_times_average):
                                solved_bv_decide_lratt_times_average.append([])
                            solved_bv_decide_lratt_times_average[thm].append(
                                [float(-1)]
                            )
                            if thm >= len(solved_bv_decide_lratc_times_average):
                                solved_bv_decide_lratc_times_average.append([])
                            solved_bv_decide_lratc_times_average[thm].append(
                                [float(-1)]
                            )

                    elif "counter " in file_line:
                        if r == 0:
                            outputs_bv_decide.append(output.counterexample)
                            counter_bv_decide_times_average.append(
                                [
                                    float(file_line.split("ms")[0].split("after ")[1])
                                ]  # Changed to list for consistency
                            )
                            counter_bv_decide_rw_times_average.append(
                                [
                                    float(
                                        file_line.split(" SAT")[0].split("rewriting ")[
                                            1
                                        ]
                                    )
                                ]
                            )
                            counter_bv_decide_sat_times_average.append(
                                [float(file_line.split("ms")[1].split("solving ")[1])]
                            )
                            solved_bv_decide_times_average.append([float(-1)])
                            solved_bv_decide_rw_times_average.append([float(-1)])
                            solved_bv_decide_bb_times_average.append([float(-1)])
                            solved_bv_decide_sat_times_average.append([float(-1)])
                            solved_bv_decide_lratt_times_average.append([float(-1)])
                            solved_bv_decide_lratc_times_average.append([float(-1)])
                        else:
                            if thm >= len(
                                counter_bv_decide_times_average
                            ) or not isinstance(
                                counter_bv_decide_times_average[thm], list
                            ):
                                counter_bv_decide_times_average.insert(thm, [])
                            counter_bv_decide_times_average[thm].append(
                                float(file_line.split("ms")[0].split("after ")[1])
                            )
                            if thm >= len(
                                counter_bv_decide_rw_times_average
                            ) or not isinstance(
                                counter_bv_decide_rw_times_average[thm], list
                            ):
                                counter_bv_decide_rw_times_average.insert(thm, [])
                            counter_bv_decide_rw_times_average[thm].append(
                                float(file_line.split(" SAT")[0].split("rewriting ")[1])
                            )
                            if thm >= len(
                                counter_bv_decide_sat_times_average
                            ) or not isinstance(
                                counter_bv_decide_sat_times_average[thm], list
                            ):
                                counter_bv_decide_sat_times_average.insert(thm, [])
                            counter_bv_decide_sat_times_average[thm].append(
                                float(file_line.split("ms")[1].split("solving ")[1])
                            )

                            # Handle solved lists similarly
                            if thm >= len(solved_bv_decide_times_average):
                                solved_bv_decide_times_average.append([])
                            if isinstance(solved_bv_decide_times_average[thm], list):
                                solved_bv_decide_times_average[thm].append(float(-1))
                            else:
                                solved_bv_decide_times_average[thm] = float(
                                    -1
                                )  # Or potentially insert a list

                            if thm >= len(solved_bv_decide_rw_times_average):
                                solved_bv_decide_rw_times_average.append([])
                            if isinstance(solved_bv_decide_rw_times_average[thm], list):
                                solved_bv_decide_rw_times_average[thm].append(float(-1))
                            else:
                                solved_bv_decide_rw_times_average[thm] = float(-1)

                            if thm >= len(solved_bv_decide_bb_times_average):
                                solved_bv_decide_bb_times_average.append([])
                            if isinstance(solved_bv_decide_bb_times_average[thm], list):
                                solved_bv_decide_bb_times_average[thm].append(float(-1))
                            else:
                                solved_bv_decide_bb_times_average[thm] = float(-1)

                            if thm >= len(solved_bv_decide_sat_times_average):
                                solved_bv_decide_sat_times_average.append([])
                            if isinstance(
                                solved_bv_decide_sat_times_average[thm], list
                            ):
                                solved_bv_decide_sat_times_average[thm].append(
                                    float(-1)
                                )
                            else:
                                solved_bv_decide_sat_times_average[thm] = float(-1)

                            if thm >= len(solved_bv_decide_lratt_times_average):
                                solved_bv_decide_lratt_times_average.append([])
                            if isinstance(
                                solved_bv_decide_lratt_times_average[thm], list
                            ):
                                solved_bv_decide_lratt_times_average[thm].append(
                                    float(-1)
                                )
                            else:
                                solved_bv_decide_lratt_times_average[thm] = float(-1)

                            if thm >= len(solved_bv_decide_lratc_times_average):
                                solved_bv_decide_lratc_times_average.append([])
                            if isinstance(
                                solved_bv_decide_lratc_times_average[thm], list
                            ):
                                solved_bv_decide_lratc_times_average[thm].append(
                                    float(-1)
                                )
                            else:
                                solved_bv_decide_lratc_times_average[thm] = float(-1)

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
                            if thm >= len(
                                solved_bv_decide_times_average
                            ) or not isinstance(
                                solved_bv_decide_times_average[thm], list
                            ):
                                solved_bv_decide_times_average.insert(thm, [])
                            solved_bv_decide_times_average[thm].append(
                                float(file_line.split("ms")[0].split("r ")[1])
                            )
                            if thm >= len(
                                solved_bv_decide_rw_times_average
                            ) or not isinstance(
                                solved_bv_decide_rw_times_average[thm], list
                            ):
                                solved_bv_decide_rw_times_average.insert(thm, [])
                            solved_bv_decide_rw_times_average[thm].append(
                                float(file_line.split("ms")[1].split("g ")[1])
                            )
                            if thm >= len(
                                solved_bv_decide_bb_times_average
                            ) or not isinstance(
                                solved_bv_decide_bb_times_average[thm], list
                            ):
                                solved_bv_decide_bb_times_average.insert(thm, [])
                            solved_bv_decide_bb_times_average[thm].append(
                                float(file_line.split("ms")[2].split("g ")[1])
                            )
                            if thm >= len(
                                solved_bv_decide_sat_times_average
                            ) or not isinstance(
                                solved_bv_decide_sat_times_average[thm], list
                            ):
                                solved_bv_decide_sat_times_average.insert(thm, [])
                            solved_bv_decide_sat_times_average[thm].append(
                                float(file_line.split("ms")[3].split("g ")[1])
                            )
                            if thm >= len(
                                solved_bv_decide_lratt_times_average
                            ) or not isinstance(
                                solved_bv_decide_lratt_times_average[thm], list
                            ):
                                solved_bv_decide_lratt_times_average.insert(thm, [])
                            solved_bv_decide_lratt_times_average[thm].append(
                                float(file_line.split("ms")[4].split("g ")[1])
                            )
                            if thm >= len(
                                solved_bv_decide_lratc_times_average
                            ) or not isinstance(
                                solved_bv_decide_lratc_times_average[thm], list
                            ):
                                solved_bv_decide_lratc_times_average.insert(thm, [])
                            solved_bv_decide_lratc_times_average[thm].append(
                                float(file_line.split("ms")[5].split("g ")[1])
                            )

                            # Handle counter lists similarly
                            if thm >= len(counter_bv_decide_times_average):
                                counter_bv_decide_times_average.append([])
                            if isinstance(counter_bv_decide_times_average[thm], list):
                                counter_bv_decide_times_average[thm].append(float(-1))
                            else:
                                counter_bv_decide_times_average[thm] = float(-1)

                            if thm >= len(counter_bv_decide_rw_times_average):
                                counter_bv_decide_rw_times_average.append([])
                            if isinstance(
                                counter_bv_decide_rw_times_average[thm], list
                            ):
                                counter_bv_decide_rw_times_average[thm].append(
                                    float(-1)
                                )
                            else:
                                counter_bv_decide_rw_times_average[thm] = float(-1)

                            if thm >= len(counter_bv_decide_sat_times_average):
                                counter_bv_decide_sat_times_average.append([])
                            if isinstance(
                                counter_bv_decide_sat_times_average[thm], list
                            ):
                                counter_bv_decide_sat_times_average[thm].append(
                                    float(-1)
                                )
                            else:
                                counter_bv_decide_sat_times_average[thm] = float(-1)

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
        }
    )
    # sanity_check_bv_decide_times(solved_df, csv_name)
    solved_df.to_csv(csv_name)
    print("Saved dataframe at: " + csv_name)


def update_overall_statistics(total_counts: dict, parsed_results: dict):
    """
    Updates the aggregate counts for proved, counterexample, and failed theorems
    for both solvers from a single file's parsed results.
    """
    count_bitwuzla = Counter(parsed_results["outputs_bitwuzla"])
    count_bv_decide = Counter(parsed_results["outputs_bv_decide"])

    total_counts["solved_bitwuzla"] += count_bitwuzla[output.proved]
    total_counts["counter_bitwuzla"] += count_bitwuzla[output.counterexample]
    total_counts["error_bitwuzla"] += count_bitwuzla[output.failed]

    total_counts["solved_bv_decide"] += count_bv_decide[output.proved]
    total_counts["counter_bv_decide"] += count_bv_decide[output.counterexample]
    total_counts["error_bv_decide"] += count_bv_decide[output.failed]


def append_comparison_results(aggregated_data: dict, file_comparison: dict):
    """
    Appends data from a single file's comparison results to the main aggregated lists.
    Maps keys from `file_comparison` (e.g., 'file_solved_...') to `aggregated_data` (e.g., 'solved_...').
    """
    key_mapping = {
        "file_solved_bitwuzla_times_average": "solved_bitwuzla_times_average",
        "file_counter_bitwuzla_times_average": "counter_bitwuzla_times_average",
        "file_solved_bv_decide_times_average": "solved_bv_decide_times_average",
        "file_solved_bv_decide_rw_times_average": "solved_bv_decide_rw_times_average",
        "file_solved_bv_decide_bb_times_average": "solved_bv_decide_bb_times_average",
        "file_solved_bv_decide_sat_times_average": "solved_bv_decide_sat_times_average",
        "file_solved_bv_decide_lratt_times_average": "solved_bv_decide_lratt_times_average",
        "file_solved_bv_decide_lratc_times_average": "solved_bv_decide_lratc_times_average",
        "file_counter_bv_decide_times_average": "counter_bv_decide_times_average",
        "file_counter_bv_decide_rw_times_average": "counter_bv_decide_rw_times_average",
        "file_counter_bv_decide_sat_times_average": "counter_bv_decide_sat_times_average",
        "failed_bv_decide_and_bitwuzla": "failed_bv_decide_and_bitwuzla",
        "failed_bitwuzla_only": "failed_bitwuzla_only",
        "failed_bv_decide_only": "failed_bv_decide_only",
        "errors": "errors",
    }

    for comp_key, agg_key in key_mapping.items():
        if comp_key in file_comparison and agg_key in aggregated_data:
            aggregated_data[agg_key].extend(file_comparison[comp_key])
        else:
            print(f"Warning: Key mismatch or missing data for {comp_key} -> {agg_key}")


def print_instcombine_summary(total_counts: dict, aggregated_data: dict):
    """Prints a summary of the collected InstCombine benchmark statistics."""
    print(f"bv_decide solved {total_counts['solved_bv_decide']} theorems.")
    print(f"bitwuzla solved {total_counts['solved_bitwuzla']} theorems.")
    print(f"bv_decide found {total_counts['counter_bv_decide']} counterexamples.")
    print(f"bitwuzla found {total_counts['counter_bitwuzla']} counterexamples.")
    print(
        f"bv_decide only failed on {len(aggregated_data['failed_bv_decide_only'])} problems."
    )
    print(
        f"bitwuzla only failed on {len(aggregated_data['failed_bitwuzla_only'])} problems."
    )
    print(
        f"both bitwuzla and bv_decide failed on {len(aggregated_data['failed_bv_decide_and_bitwuzla'])} problems."
    )
    print(
        "In total, bitwuzla saw "
        f"{total_counts['counter_bitwuzla'] + total_counts['solved_bitwuzla'] + total_counts['error_bitwuzla']} problems."
    )
    print(
        "In total, bv_decide saw "
        f"{total_counts['counter_bv_decide'] + total_counts['solved_bv_decide'] + total_counts['error_bv_decide']} problems."
    )


def run_instcombine_assertions(results_dir: str, aggregated_data: dict):
    """Runs shell command assertions specific to InstCombine results."""
    run_shell_command_and_assert_output_eq_int(
        results_dir,
        "rg 'LeanSAT provided a counter' | wc -l",
        len(aggregated_data["counter_bv_decide_times_average"]),
    )
    run_shell_command_and_assert_output_eq_int(
        results_dir,
        "rg 'Bitwuzla provided a counter' | wc -l",
        len(aggregated_data["counter_bitwuzla_times_average"]),
    )
    run_shell_command_and_assert_output_eq_int(
        results_dir,
        "rg 'LeanSAT proved' | wc -l",
        len(aggregated_data["solved_bv_decide_times_average"])
        + len(aggregated_data["failed_bitwuzla_only"]),
    )
    run_shell_command_and_assert_output_eq_int(
        results_dir,
        "rg 'Bitwuzla proved' | wc -l",
        len(aggregated_data["solved_bitwuzla_times_average"])
        + len(aggregated_data["failed_bv_decide_only"]),
    )
    response = subprocess.check_output("cat "+ROOT_DIR+"/SSA/Projects/InstCombine/tests/proofs/*_proof.lean  | grep theorem | wc -l", shell=True, text=True)
    val = int(response)
    print("The InstCombine benchmark contains "+str(val)+" theorems in total.")


def process_and_save_single_hackersdelight_benchmark(
    file_path_base: str, reps: int, raw_data_output_dir: str
):
    """
    Processes a single HackersDelight benchmark (file + bitwidth) and saves its results
    into individual CSVs.
    """
    parsed_results = parse_file(file_path_base, reps)
    file_comparison = compare_solvers_on_file([file_path_base, parsed_results])

    # Extract base file name for CSVs
    csv_base_name = os.path.basename(file_path_base)

    save_counterexample_df(
        file_comparison["file_counter_bitwuzla_times_average"],
        file_comparison["file_counter_bv_decide_times_average"],
        file_comparison["file_counter_bv_decide_rw_times_average"],
        file_comparison["file_counter_bv_decide_sat_times_average"],
        os.path.join(raw_data_output_dir, csv_base_name + "_ceg_data.csv"),
    )

    save_solved_df(
        file_comparison["file_solved_bitwuzla_times_average"],
        file_comparison["file_solved_bv_decide_times_average"],
        file_comparison["file_solved_bv_decide_rw_times_average"],
        file_comparison["file_solved_bv_decide_bb_times_average"],
        file_comparison["file_solved_bv_decide_sat_times_average"],
        file_comparison["file_solved_bv_decide_lratt_times_average"],
        file_comparison["file_solved_bv_decide_lratc_times_average"],
        os.path.join(raw_data_output_dir, csv_base_name + "_solved_data.csv"),
    )

    errors_df = pd.DataFrame({"errors_bitwuzla": file_comparison["errors"]})
    errors_csv_path = os.path.join(raw_data_output_dir, csv_base_name + "_err_data.csv")
    errors_df.to_csv(errors_csv_path)
    print(f"Saved errors dataframe at: {errors_csv_path}")


def collect(benchmark: str):
    if benchmark == "instcombine":
        clear_folder(RAW_DATA_DIR_INSTCOMBINE)

        file_data = []

        for file in os.listdir(BENCHMARK_DIR_INSTCOMBINE):
            if "_proof" in file:
                file_name = RESULTS_DIR_INSTCOMBINE + file.split(".")[0]
                parsed_results = parse_file(file_name, REPS)
                file_data.append([file_name, parsed_results])

        # Initialize a dictionary to hold all aggregated data lists
        all_files_aggregated_data = {
            "solved_bitwuzla_times_average": [],
            "counter_bitwuzla_times_average": [],
            "solved_bv_decide_times_average": [],
            "solved_bv_decide_rw_times_average": [],
            "solved_bv_decide_bb_times_average": [],
            "solved_bv_decide_sat_times_average": [],
            "solved_bv_decide_lratt_times_average": [],
            "solved_bv_decide_lratc_times_average": [],
            "counter_bv_decide_times_average": [],
            "counter_bv_decide_rw_times_average": [],
            "counter_bv_decide_sat_times_average": [],
            "failed_bv_decide_and_bitwuzla": [],
            "failed_bv_decide_only": [],
            "failed_bitwuzla_only": [],
            "errors": [],
        }

        # Initialize total counts using Counter for convenience
        total_counts = Counter(
            {
                "solved_bitwuzla": 0,
                "counter_bitwuzla": 0,
                "error_bitwuzla": 0,
                "solved_bv_decide": 0,
                "counter_bv_decide": 0,
                "error_bv_decide": 0,
            }
        )

        for file_name, parsed_results in file_data:
            # Update total statistics
            update_overall_statistics(total_counts, parsed_results)

            # Compare solvers on this file's results
            file_comparison = compare_solvers_on_file([file_name, parsed_results])

            # Append individual file comparison results to master lists
            append_comparison_results(all_files_aggregated_data, file_comparison)

        # Print summary statistics
        print_instcombine_summary(total_counts, all_files_aggregated_data)

        # Run shell command assertions
        run_instcombine_assertions(RESULTS_DIR_INSTCOMBINE, all_files_aggregated_data)

        # Save dataframes
        save_counterexample_df(
            all_files_aggregated_data["counter_bitwuzla_times_average"],
            all_files_aggregated_data["counter_bv_decide_times_average"],
            all_files_aggregated_data["counter_bv_decide_rw_times_average"],
            all_files_aggregated_data["counter_bv_decide_sat_times_average"],
            RAW_DATA_DIR_INSTCOMBINE + "instcombine_ceg_data.csv",
        )

        save_solved_df(
            all_files_aggregated_data["solved_bitwuzla_times_average"],
            all_files_aggregated_data["solved_bv_decide_times_average"],
            all_files_aggregated_data["solved_bv_decide_rw_times_average"],
            all_files_aggregated_data["solved_bv_decide_bb_times_average"],
            all_files_aggregated_data["solved_bv_decide_sat_times_average"],
            all_files_aggregated_data["solved_bv_decide_lratt_times_average"],
            all_files_aggregated_data["solved_bv_decide_lratc_times_average"],
            RAW_DATA_DIR_INSTCOMBINE + "instcombine_solved_data.csv",
        )
    elif benchmark == "hackersdelight":
        clear_folder(RAW_DATA_DIR_HACKERSDELIGHT)

        for file in os.listdir(BENCHMARK_DIR_HACKERSDELIGHT):
            # Assuming .split(".") is safe and there's always at least one dot
            base_file_name_without_ext = file.split(".")[0]
            for bvw in bv_width:
                file_base_path = os.path.join(
                    RESULTS_DIR_HACKERSDELIGHT, f"{base_file_name_without_ext}_{bvw}"
                )
                print(file_base_path)  # Original print statement

                process_and_save_single_hackersdelight_benchmark(
                    file_base_path, REPS, RAW_DATA_DIR_HACKERSDELIGHT
                )


def main():
    parser = argparse.ArgumentParser(
        prog="compare",
        description="Compare the performance of bv_decide vs. bitwuzla",
    )

    parser.add_argument(
        "benchmark",
        nargs="+",
        choices=["all", "hackersdelight", "instcombine"],
    )
    parser.add_argument("-j", "--jobs", type=int, default=1)
    parser.add_argument("-r", "--repetitions", type=int, default=1)

    args = parser.parse_args()
    benchmarks_to_run = args.benchmark

    # Set global REPS based on arguments
    global REPS
    REPS = args.repetitions

    for b in benchmarks_to_run:
        collect(b)


if __name__ == "__main__":
    main()
    