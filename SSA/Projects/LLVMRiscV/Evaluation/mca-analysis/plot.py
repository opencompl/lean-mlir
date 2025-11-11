#!/usr/bin/env python3

import subprocess
import os
import argparse
import shutil
import pandas as pd
import matplotlib
import matplotlib.pyplot as plt
import numpy as np
import math


matplotlib.rcParams["pdf.fonttype"] = 42
matplotlib.rcParams["font.size"] = 20


matplotlib.rcParams["figure.autolayout"] = True
matplotlib.rcParams["legend.frameon"] = False
matplotlib.rcParams["axes.spines.right"] = False
matplotlib.rcParams["axes.spines.top"] = False

# matplotlib.rcParams['figure.figsize'] = 5, 2

light_gray = "#cacaca"
dark_gray = "#827b7b"
light_blue = "#a6cee3"
dark_blue = "#1f78b4"
light_green = "#b2df8a"
dark_green = "#33a02c"
light_red = "#fb9a99"
dark_red = "#e31a1c"
black = "#000000"
white = "#ffffff"

colors_list = [
    light_gray,
    dark_gray,
    light_blue,
    dark_blue,
    light_green,
    dark_green,
    light_red,
    dark_red,
    black,
    white,
]

ROOT_DIR_PATH = (
    subprocess.check_output(["git", "rev-parse", "--show-toplevel"])
    .decode("utf-8")
    .strip()
)

LLVMIR_DIR_PATH = (
    f"{ROOT_DIR_PATH}/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/LLVMIR/"
)

LLVM_globalisel_results_DIR_PATH = f"{ROOT_DIR_PATH}/SSA/Projects/LLVMRiscV/Evaluation/mca-analysis/results/LLVM_globalisel/"
LLVM_selectiondag_results_DIR_PATH = f"{ROOT_DIR_PATH}/SSA/Projects/LLVMRiscV/Evaluation/mca-analysis/results/LLVM_selectiondag/"
LEANMLIR_results_DIR_PATH = (
    f"{ROOT_DIR_PATH}/SSA/Projects/LLVMRiscV/Evaluation/mca-analysis/results/LEANMLIR/"
)
LEANMLIR_opt_results_DIR_PATH = f"{ROOT_DIR_PATH}/SSA/Projects/LLVMRiscV/Evaluation/mca-analysis/results/LEANMLIR_opt/"

tables_dir = f"{ROOT_DIR_PATH}/SSA/Projects/LLVMRiscV/Evaluation/mca-analysis/tables/"
data_dir = f"{ROOT_DIR_PATH}/SSA/Projects/LLVMRiscV/Evaluation/mca-analysis/data/"
plots_dir = f"{ROOT_DIR_PATH}/SSA/Projects/LLVMRiscV/Evaluation/mca-analysis/plots/"


def setup_benchmarking_directories():
    """
    Create clean directories to store the benchmarks.
    """
    if not os.path.exists(data_dir):
        os.makedirs(data_dir)
    else:
        shutil.rmtree(data_dir)
        os.makedirs(data_dir)

    if not os.path.exists(plots_dir):
        os.makedirs(plots_dir)
    else:
        shutil.rmtree(plots_dir)
        os.makedirs(plots_dir)


parameters_match = {
    "tot_instructions": "Instructions:      ",
    "tot_cycles": "Total Cycles:      ",
    "tot_uops": "Total uOps:        ",
    "similarity": "Instructions List:      ",
}

parameters_labels = {
    "tot_instructions": "#instructions",
    "tot_cycles": "#cycles",
    "tot_uops": "#uOps",
    "similarity": "Instructions List:",
}

selector_labels = {
    "LEANMLIR": "CertISel",
    "LEANMLIR_opt": "CertOptISel",
    "LLVM_globalisel_O1": "GlobalISel (O1)",
    "LLVM_globalisel_O2": "GlobalISel (O2)",
    "LLVM_globalisel_O3": "GlobalISel (O3)",
    "LLVM_globalisel": "GlobalISel (def.)",
    "LLVM_selectiondag_O1": "SelectionDAG (O1)",
    "LLVM_selectiondag_O2": "SelectionDAG (O2)",
    "LLVM_selectiondag_O3": "SelectionDAG (O3)",
    "LLVM_selectiondag": "SelectionDAG (def.)",
}


def parse_instructions(filename):
    instructions = []
    in_instruction_section = False

    with open(filename, "r") as f:
        for line in f:
            if (
                "[0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    Instructions:"
                in line
            ):
                in_instruction_section = True
                continue

            if in_instruction_section and line.strip():
                parts = line.split()
                instruction = parts[8]  # inst name is in 9th column
                instructions.append(instruction)
    if len(instructions) == 0:
        return None
    return instructions


def extract_data(results_directory, benchmark_name, parameter):
    """
    Parses the results of mca and saves the result in a DataFrame, then printed to `.csv`
    """
    function_names = []
    parameter_numbers = []
    for filename in os.listdir(results_directory):
        file_path = os.path.join(results_directory, filename)
        try:
            if parameter == "similarity":
                with open(file_path, "r") as f:
                    file_lines = f.readlines()
                    instructions = parse_instructions(file_path)
                    if instructions is not None:
                        parameter_numbers.append(",".join(instructions))
                        function_names.append(filename.split(".")[0])
            else:
                with open(file_path, "r") as f:
                    file_lines = f.readlines()
                    for line in file_lines:
                        if parameters_match[parameter] in line:
                            function_names.append(filename.split(".")[0])
                            num = int(line.split(" ")[-1])
                            if parameter == "tot_cycles":
                                parameter_numbers.append(int(num))
                            else:
                                parameter_numbers.append(int(num / 100))
        except FileNotFoundError:
            print(f"Warning: file not found at {file_path}. Skipping.")
    df = pd.DataFrame(
        {
            "function_name": function_names,
            benchmark_name + "_" + parameter: parameter_numbers,
        }
    )
    df.to_csv(data_dir + benchmark_name + "_" + parameter + ".csv")


def join_dataframes(dataframe_names, parameter):
    """
    Joins multiple DataFrames on a common 'function_name' column.
    """
    for idx, name in enumerate(dataframe_names):
        df = pd.read_csv(
            data_dir + name + "_" + parameter + ".csv", index_col=0, header=0
        )
        if idx == 0:
            complete_df = df
        else:
            complete_df = pd.merge(complete_df, df, on="function_name", how="inner")
    complete_df["instructions_number"] = complete_df["function_name"].apply(
        lambda x: int(x.split("_")[0])
    )
    complete_df.to_csv(data_dir + parameter + ".csv")


def sorted_line_plot_all(parameter):
    df = pd.read_csv(data_dir + parameter + ".csv")

    sorted_df = df.sort_values(
        by=[
            "LEANMLIR_opt_" + parameter,
            "LLVM_globalisel_" + parameter,
            "LLVM_selectiondag_" + parameter,
        ]
    )

    plt.plot(
        range(len(sorted_df)),
        sorted_df["LEANMLIR_opt_" + parameter],
        label=selector_labels["LEANMLIR_opt"],
        color=dark_green,
    )
    plt.plot(
        range(len(sorted_df)),
        sorted_df["LLVM_globalisel_" + parameter],
        label=selector_labels["LLVM_globalisel"],
        color=light_blue,
    )
    plt.plot(
        range(len(sorted_df)),
        sorted_df["LLVM_selectiondag_" + parameter],
        label=selector_labels["LLVM_selectiondag"],
        color=light_red,
    )
    plot_max = (
        np.max(
            [
                sorted_df["LEANMLIR_opt_" + parameter].min(),
                sorted_df["LLVM_globalisel_" + parameter].min(),
                sorted_df["LLVM_selectiondag_" + parameter].min(),
            ]
        )
        + 1
    )

    plt.ylim(1, int(plot_max * 1.5) + 1)
    plt.yticks(range(1, int(plot_max * 1.5) + 1, int((int(plot_max * 1.5) + 5) / 5)))

    plt.xlabel("Program Index")
    plt.ylabel(parameter)
    plt.figure(figsize=(10, 5))

    # plt.title(f'{parameter} Per Program')

    plt.legend(ncols=2)
    plt.tight_layout()

    pdf_filename = plots_dir + parameter + "_line.pdf"
    plt.savefig(pdf_filename, bbox_inches='tight')
    print(f"\nPlot saved to '{pdf_filename}' in the current working directory.")
    plt.close()


def scatter_plot(parameter, selector1, selector2):
    df = pd.read_csv(data_dir + parameter + ".csv")

    if selector1 + "_" + parameter not in df.columns:
        print(f"Error: the column {selector1} does not exist in the dataframe.")
        return
    if selector2 + "_" + parameter not in df.columns:
        print(f"Error: the column {selector2} does not exist in the dataframe.")

    df_plot_comparison = df[
        [selector1 + "_" + parameter, selector2 + "_" + parameter]
    ].dropna()

    frequencies = (
        df_plot_comparison.groupby(
            [selector1 + "_" + parameter, selector2 + "_" + parameter]
        )
        .size()
        .reset_index(name="Frequency")
    )
    df_plot_scaled = pd.merge(
        df_plot_comparison,
        frequencies,
        on=[selector1 + "_" + parameter, selector2 + "_" + parameter],
        how="left",
    )

    df_plot_scaled["Scaled_Size"] = np.sqrt((df_plot_scaled["Frequency"])) * 50 + 20

    print("\nData test for plotting (first 5 rows, with frequency and scaled size):")
    print(df_plot_scaled.head())

    plt.scatter(
        df_plot_scaled[selector1 + "_" + parameter],
        df_plot_scaled[selector2 + "_" + parameter],
        s=df_plot_scaled["Scaled_Size"],
        color=light_blue,
        alpha=0.7,
        edgecolors="w",
        label="Function data points (Size by frequency)",
    )

    min_val = min(
        df_plot_comparison[selector1 + "_" + parameter].min(),
        df_plot_comparison[selector2 + "_" + parameter].min(),
    )
    max_val = max(
        df_plot_comparison[selector1 + "_" + parameter].max(),
        df_plot_comparison[selector2 + "_" + parameter].max(),
    )
    print(min_val)
    print(max_val)
    # Add a small buffer to the min/max values for better visualization
    plot_min = max(0, min_val - 1)
    plot_max = max_val + 1

    plt.plot(
        [plot_min, plot_max],
        [plot_min, plot_max],
        color="gray",
        linestyle="--",
        label="$x=y$ line",
    )

    plt.xlabel(selector_labels[selector1] + " - " + parameters_labels[parameter])
    plt.ylabel(selector_labels[selector2] + " - " + parameters_labels[parameter])

    if (
        not (plot_min == plot_max)
        and (0 < int(plot_min / 5))
        and (0 < int(plot_max / 5))
    ):
        plt.xlim(plot_min, plot_max)
        plt.ylim(plot_min, plot_max)

        plt.xticks(range(0, int(plot_max), int((plot_max) / 5)))
        plt.yticks(range(0, int(plot_max), int((plot_max) / 5)))

    plt.gca().set_aspect("equal", adjustable="box")

    plt.tight_layout()

    pdf_filename = (
        plots_dir + f"{parameter}_scatter_plot_{selector1}_vs_{selector2}.pdf"
    )
    plt.savefig(pdf_filename, bbox_inches='tight')
    print(f"\nScatter plot saved to '{pdf_filename}' in the current working directory.")
    plt.close()


def clean_name(s):
    # Remove underscores and capitalize parts
    return "".join([w.capitalize() for w in str(s).split("_")])


def calculate_similarity(selector1, selector2, print_latex=True):
    df = pd.read_csv(data_dir + "similarity" + ".csv")
    print("done")

    col1 = selector1 + "_" + "similarity"
    col2 = selector2 + "_" + "similarity"
    instruction_count = "instructions_number"

    if col1 not in df.columns or col2 not in df.columns:
        print(
            f"Error: One or both columns ({col1}, {col2}) do not exist in the dataframe."
        )
        return

    col1_values = df[col1].dropna().apply(lambda x: x.split(","))
    col2_values = df[col2].dropna().apply(lambda x: x.split(","))

    grouped = df.groupby(instruction_count)
    similarity_percentages = {}

    for count, group in grouped:
        col1_values = group[col1].dropna().apply(lambda x: x.split(","))
        col2_values = group[col2].dropna().apply(lambda x: x.split(","))
        similarities = col1_values == col2_values
        similarity_percentage = similarities.mean() * 100
        similarity_percentages[count] = similarity_percentage
        print(
            f"Similarity for instruction count {count} between {selector1} and {selector2}: {similarity_percentage:.2f}%"
        )

        if print_latex:
            cmd_name = (
                f"\\newcommand{{\\Similarity"
                f"{clean_name(selector1.replace('1', 'one').replace('2', 'two').replace('3', 'three').replace('4', 'four').replace('5', 'five'))}Vs{clean_name(selector2.replace('1', 'one').replace('2', 'two').replace('3', 'three').replace('4', 'four').replace('5', 'five'))}"
                f"{clean_name('instructions')}For{str(count).replace('3', 'three').replace('4', 'four').replace('5', 'five').replace('6', 'six').replace('7', 'seven').replace('8', 'eight')}Instructions}}{{{similarity_percentage:.2f}}}"
            )
            latex_file = os.path.join(plots_dir, "similarity_percentages.tex")
            with open(latex_file, "a") as f:
                f.write(cmd_name + "\n")

    mean_similarity = np.mean(list(similarity_percentages.values()))
    print(
        f"Mean similarity {count} between {selector1} and {selector2}: {similarity_percentage:.2f}%"
    )

    if print_latex:
        cmd_name = (
            f"\\newcommand{{\\MeanSimilarity"
            f"{clean_name(selector1.replace('1', 'one').replace('2', 'two').replace('3', 'three').replace('4', 'four').replace('5', 'five'))}Vs{clean_name(selector2.replace('1', 'one').replace('2', 'two').replace('3', 'three').replace('4', 'four').replace('5', 'five'))}"
            f"}}{{{mean_similarity:.2f}}}"
        )
        latex_file = os.path.join(plots_dir, "similarity_percentages.tex")
        with open(latex_file, "a") as f:
            f.write(cmd_name + "\n")

    return similarity_percentages


def bar_plot(parameter, selector1, selector2):
    df = pd.read_csv(data_dir + parameter + ".csv")

    col1 = selector1 + "_" + parameter
    col2 = selector2 + "_" + parameter

    if col1 not in df.columns:
        print(f"Error: the column {col1} does not exist in the dataframe.")
        return
    if col2 not in df.columns:
        print(f"Error: the column {col2} does not exist in the dataframe.")
        return

    # Compute the difference
    df["diff"] = df[col1] / df[col2]

    # Classify the differences
    def classify(diff):
        if diff < 1:
            return "<1x"
        elif diff == 1:
            return "1x"
        elif diff < 1.5:
            return "1x-1.5x"
        elif diff < 2:
            return "1.5x-2x"
        else:
            return ">2x"

    df["diff_class"] = df["diff"].apply(classify)

    df.to_csv(data_dir + parameter + f"_{selector1}_vs_{selector2}_classified.csv")

    # For each unique value of the initial `instructions_number`, compute the % of each diff_class
    group = (
        df.groupby("instructions_number")["diff_class"]
        .value_counts(normalize=True)
        .unstack(fill_value=0)
        * 100
    )

    # Ensure all classes are present for consistent coloring/order
    class_order = ["<1x", "1x", "1x-1.5x", "1.5x-2x", ">2x"]

    for c in class_order:
        if c not in group.columns:
            group[c] = 0
    group = group[class_order]

    # Colors for each class
    class_colors = {
        "<1x": light_blue,
        "1x": dark_green,
        "1x-1.5x": light_green,
        "1.5x-2x": light_red,
        ">2x": dark_red,
    }

    # Plot
    def plot_bar(with_similarity=False):
        bottom = np.zeros(len(group))
        x = group.index.astype(str)
        plt.figure(figsize=(10, 5))
        for c in class_order:
            if c == "1x" and with_similarity:
                similarity_percentages = calculate_similarity(
                    selector1, selector2, False
                )
                similarity_list = list(similarity_percentages.values())
                remaining = [a - b for a, b in zip(group[c], similarity_list)]
                plt.bar(
                    x, similarity_list, bottom=bottom, color=class_colors[c], hatch="//"
                )
                bottom += similarity_list
                plt.bar(
                    x, remaining, bottom=bottom, label=f"{c}", color=class_colors[c]
                )
                bottom += remaining
            else:
                plt.bar(x, group[c], bottom=bottom, label=f"{c}", color=class_colors[c])
                bottom += group[c].values

        plt.xlabel("#instructions - LLVM IR")
        plt.ylabel(
            "%Programs", rotation="horizontal", horizontalalignment="left", y=1.05
        )
        plt.legend(ncols=5, bbox_to_anchor=(0.5, -0.5), loc="lower center")
        plt.subplots_adjust(bottom=0.4)
        plt.tight_layout()

        name_extension = "_similarity_" if with_similarity else "_"
        pdf_filename = (
            plots_dir
            + f"{parameter}_stacked_bar{name_extension}{selector1}_vs_{selector2}.pdf"
        )
        plt.savefig(pdf_filename, bbox_inches='tight')
        print(
            f"\nStacked bar plot saved to '{pdf_filename}' in the current working directory."
        )
        plt.close()

    plot_bar()
    if parameter == "tot_instructions":
        plot_bar(with_similarity=True)

    latex_lines = []
    for idx, row in group.iterrows():
        idx_str = str(idx)
        idx_str_clean = idx_str.replace("_", "")  # Remove underscores from index if any
        # Ensure the last character is a letter by appending 'N' if it ends with a digit
        if idx_str_clean and idx_str_clean[-1].isdigit():
            idx_str_clean = (
                idx_str_clean.replace("0", "zero")
                .replace("1", "one")
                .replace("2", "two")
                .replace("3", "three")
                .replace("4", "four")
                .replace("5", "five")
                .replace("6", "six")
                .replace("7", "seven")
                .replace("8", "eight")
                .replace("9", "nine")
                .replace("-", "dash")
                .replace(".", "")
            )
            idx_str_clean += "Instr"
        for c in class_order:
            perc = row[c]
            cmd = (
                f"\\newcommand{{\\Perc"
                f"{clean_name(selector1.replace('1', 'one').replace('2', 'two').replace('3', 'three').replace('4', 'four').replace('5', 'five'))}Vs{clean_name(selector2.replace('1', 'one').replace('2', 'two').replace('3', 'three').replace('4', 'four').replace('5', 'five').replace('-', 'dash').replace('.', ''))}"
                f"{clean_name(parameter)}For{idx_str_clean}On{c.replace('<', 'lt').replace('>', 'gt').replace('0', 'zero').replace('1', 'one').replace('2', 'two').replace('3', 'three').replace('4', 'four').replace('5', 'five').replace('-', 'dash').replace('.', '')}}}{{{perc:.1f}}}"
            )
            latex_lines.append(cmd)
    latex_file = os.path.join(plots_dir, "bar_plot_percentages.tex")
    with open(latex_file, "a") as f:
        for line in latex_lines:
            f.write(line + "\n")


def sorted_line_plot(parameter, selector1, selector2):
    df = pd.read_csv(data_dir + parameter + ".csv")

    sorted_df = df.sort_values(
        by=[selector1 + "_" + parameter, selector2 + "_" + parameter]
    )
    plt.figure(figsize=(12, 5))

    plt.plot(
        range(len(sorted_df)),
        sorted_df[selector1 + "_" + parameter],
        label=selector_labels[selector1],
        color=light_green,
    )
    plt.plot(
        range(len(sorted_df)),
        sorted_df[selector2 + "_" + parameter],
        label=selector_labels[selector2],
        color=dark_green,
    )

    plt.xlabel("Program Index")
    plt.ylabel(
        parameters_labels[parameter],
        rotation="horizontal",
        horizontalalignment="left",
        y=1,
    )
    # plt.title(f'{parameters_labels[parameter]} Per Program, {selector1} vs. {selector2}')
    # plt.yticks(range(int(plot_min), int(plot_max + 1), 1))
    plt.legend()
    plt.tight_layout()

    pdf_filename = plots_dir + parameter + f"_{selector1}_vs_{selector2}_line.pdf"
    plt.savefig(pdf_filename, bbox_inches='tight')
    print(f"\nPlot saved to '{pdf_filename}' in the current working directory.")
    plt.close()

    avg_diff = (
        sorted_df[selector1 + "_" + parameter] - sorted_df[selector2 + "_" + parameter]
    ).mean()
    # Clean names for LaTeX command

    cmd_name = (
        f"\\newcommand{{\\AvgDiff"
        f"{
            clean_name(
                selector1.replace('1', 'one')
                .replace('2', 'two')
                .replace('3', 'three')
                .replace('4', 'four')
                .replace('5', 'five')
            )
        }Vs{
            clean_name(
                selector2.replace('1', 'one')
                .replace('2', 'two')
                .replace('3', 'three')
                .replace('4', 'four')
                .replace('5', 'five')
            )
        }"
        f"{clean_name(parameter)}}}{{{avg_diff:.2f}}}"
    )
    latex_file = os.path.join(plots_dir, "sorted_line_plot_averages.tex")
    with open(latex_file, "a") as f:
        f.write(cmd_name + "\n")


def overhead_plot(parameter, selector1, selector2):
    """
    Plots the overhead of employing `selector1` against `selector2`
    """
    df = pd.read_csv(data_dir + parameter + ".csv")

    sorted_df = df.sort_values(
        by=[selector1 + "_" + parameter, selector2 + "_" + parameter],
        ascending=[True, True],
    )
    plt.figure(figsize=(10, 5))

    if 0 < len(sorted_df):
        plt.stackplot(
            range(0, len(sorted_df)),
            sorted_df[selector1 + "_" + parameter],
            labels=[selector_labels[selector1]],
            color=light_green,
        )
        plt.stackplot(
            range(0, len(sorted_df)),
            sorted_df[selector2 + "_" + parameter],
            labels=[selector_labels[selector2]],
            color=white,
            edgecolor=light_red,
        )

        plt.xlabel("Program Index")
        plt.ylabel(
            parameters_labels[parameter],
            rotation="horizontal",
            horizontalalignment="left",
            y=1,
        )
        plt.xticks(range(0, len(sorted_df), int(np.ceil(len(sorted_df) / 5))))
        plt.legend()
        plt.tight_layout()

        pdf_filename = (
            plots_dir + f"{parameter}_overhead_{selector1}_vs_{selector2}.pdf"
        )
        plt.savefig(pdf_filename, bbox_inches='tight')
        print(f"\nPlot saved to '{pdf_filename}' in the current working directory.")
        plt.close()


def proportional_bar_plot(parameter, selector1, selector2):
    df = pd.read_csv(data_dir + parameter + ".csv")

    plt.figure(figsize=(10, 5))

    col1 = selector1 + "_" + parameter
    col2 = selector2 + "_" + parameter

    if col1 not in df.columns or col2 not in df.columns:
        print(
            f"Error: One or both columns ({col1}, {col2}) do not exist in the dataframe."
        )
        return

    grouped = df.groupby("instructions_number")[[col1, col2]].mean()
    grouped["proportion"] = grouped[col1] / grouped[col2]
    legend_name1 = (
        selector_labels[selector1]
        .replace(" (O3)", "")
        .replace(" (O2)", "")
        .replace(" (O1)", "")
        .replace(" (def.)", "")
    )
    legend_name2 = selector_labels[selector2]

    plt.bar(
        grouped.index.astype(str),
        grouped["proportion"],
        color=dark_green,
        label=legend_name1,
    )

    plt.axhline(1, color=dark_gray, linestyle="--", linewidth=5, label=legend_name2)

    plt.xlabel("#Instructions - LLVM IR")
    plt.ylabel(
        f"{parameters_labels[parameter]} [x]"
    )
    plt.yticks(np.arange(0, math.ceil(max(grouped["proportion"])+1), 1))
    plt.legend(ncols=2, bbox_to_anchor=(0.5, -0.5), loc="lower center")
    plt.tight_layout()

    # uncomment to have numbers on top of the bars
    # for bar in bars:
    #     height = bar.get_height()
    #     plt.text(bar.get_x() + bar.get_width()/2., height,
    #             f'{height:.2f}',
    #             ha='center', va='bottom')

    pdf_filename = (
        plots_dir + f"{parameter}_proportional_bar_{selector1}_vs_{selector2}.pdf"
    )
    plt.savefig(pdf_filename, bbox_inches='tight')
    print(
        f"\nProportional bar plot saved to '{pdf_filename}' in the current working directory."
    )
    plt.close()

    geomean_ratio = np.exp(np.mean(np.log(grouped["proportion"])))

    latex_lines = []
    for idx, ratio in enumerate(grouped["proportion"]):
        idx_str = str(idx)
        idx_str_clean = idx_str.replace("_", "")  # Remove underscores from index if any
        # Ensure the last character is a letter by appending 'N' if it ends with a digit
        if idx_str_clean and idx_str_clean[-1].isdigit():
            idx_str_clean = (
                idx_str_clean.replace("0", "zero")
                .replace("1", "one")
                .replace("2", "two")
                .replace("3", "three")
                .replace("4", "four")
                .replace("5", "five")
                .replace("6", "six")
                .replace("7", "seven")
                .replace("8", "eight")
                .replace("9", "nine")
            )
            idx_str_clean += "Instr"
        cmd = (
            f"\\newcommand{{\\Ratio"
            f"{clean_name(selector1.replace('1', 'one').replace('2', 'two').replace('3', 'three').replace('4', 'four').replace('5', 'five'))}Vs{clean_name(selector2.replace('1', 'one').replace('2', 'two').replace('3', 'three').replace('4', 'four').replace('5', 'five'))}"
            f"{clean_name(parameter)}For{idx_str_clean}}}{{{ratio:.2f}}}"
        )
        latex_lines.append(cmd)

    geomean_cmd = (
        f"\\newcommand{{\\GeoMean"
        f"{clean_name(selector1.replace('1', 'one').replace('2', 'two').replace('3', 'three').replace('4', 'four').replace('5', 'five'))}Vs{clean_name(selector2.replace('1', 'one').replace('2', 'two').replace('3', 'three').replace('4', 'four').replace('5', 'five'))}"
        f"{clean_name(parameter)}}}{{{geomean_ratio:.2f}}}"
    )
    latex_lines.append(geomean_cmd)

    latex_file = os.path.join(plots_dir, "proportions.tex")
    with open(latex_file, "a") as f:
        for line in latex_lines:
            f.write(line + "\n")


def main():
    parser = argparse.ArgumentParser(
        prog="plot",
        description="Produce the plots to evaluate the performance of the Lean-MLIR certified Instruction Selection.",
    )

    parser.add_argument(
        "-p",
        "--parameters",
        nargs="+",
        choices=["tot_instructions", "tot_cycles", "tot_uops", "similarity", "all"],
    )

    parser.add_argument(
        "-t",
        "--plot_type",
        nargs="+",
        choices=["scatter", "sorted", "stacked", "overhead", "all"],
    )

    parser.add_argument(
        "-llvm",
        "--llvm_opt",
        help="Optimization level for LLVM.",
        choices=["O3", "O2", "O1", "O0", "default"],
    )

    args = parser.parse_args()

    params_to_evaluate = (
        ["similarity", "tot_instructions", "tot_cycles", "tot_uops"]
        if "all" in args.parameters
        else args.parameters
    )

    plots_to_produce = (
        ["scatter", "sorted", "stacked", "overhead", "proportional"]
        if "all" in args.plot_type
        else args.plot_type
    )

    setup_benchmarking_directories()

    print(args)

    for parameter in params_to_evaluate:
        extract_data(LLVM_globalisel_results_DIR_PATH, "LLVM_globalisel", parameter)
        extract_data(LLVM_selectiondag_results_DIR_PATH, "LLVM_selectiondag", parameter)
        extract_data(LEANMLIR_opt_results_DIR_PATH, "LEANMLIR_opt", parameter)

        to_join = ["LEANMLIR_opt", "LLVM_globalisel", "LLVM_selectiondag"]
        join_dataframes(to_join, parameter)
        if parameter == "similarity":
            calculate_similarity("LEANMLIR_opt", "LLVM_globalisel")
            calculate_similarity("LEANMLIR_opt", "LLVM_selectiondag")
            # calculate_similarity('LLVM_globalisel', 'LLVM_selectiondag')
        else:
            # if "scatter" in plots_to_produce or "all" in plots_to_produce:
            #     scatter_plot(parameter, "LEANMLIR_opt", "LLVM_globalisel")
            #     scatter_plot(parameter, "LEANMLIR_opt", "LLVM_selectiondag")
            #     # scatter_plot(parameter, 'LLVM_globalisel', 'LLVM_selectiondag')
            # if "sorted" in plots_to_produce or "all" in plots_to_produce:
            #     sorted_line_plot_all(parameter)
            #     sorted_line_plot(parameter, "LEANMLIR_opt", "LLVM_globalisel")
            #     sorted_line_plot(parameter, "LEANMLIR_opt", "LLVM_selectiondag")
            #     # sorted_line_plot(parameter, 'LLVM_globalisel', 'LLVM_selectiondag')
            # if "overhead" in plots_to_produce or "all" in plots_to_produce:
            #     overhead_plot(parameter, "LEANMLIR_opt", "LLVM_globalisel")
            #     overhead_plot(parameter, "LEANMLIR_opt", "LLVM_selectiondag")
            #     # overhead_plot(parameter, 'LLVM_globalisel', 'LLVM_selectiondag')
            if "stacked" in plots_to_produce or "all" in plots_to_produce:
                bar_plot(parameter, "LEANMLIR_opt", "LLVM_globalisel")
                bar_plot(parameter, "LEANMLIR_opt", "LLVM_selectiondag")
                # bar_plot(parameter, 'LLVM_globalisel', 'LLVM_selectiondag')
            if "proportional" in plots_to_produce or "all" in plots_to_produce:
                proportional_bar_plot(parameter, "LEANMLIR_opt", "LLVM_globalisel")
                proportional_bar_plot(parameter, "LEANMLIR_opt", "LLVM_selectiondag")
                # proportional_bar_plot(parameter, 'LLVM_globalisel', 'LLVM_selectiondag')


if __name__ == "__main__":
    main()
