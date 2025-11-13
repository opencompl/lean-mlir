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
from num2words import num2words

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
    "LEANMLIR_opt": "Lean-mlir-ISel",
    "LLVM_globalisel_O1": "GlobalISel (O1)",
    "LLVM_globalisel_O2": "GlobalISel (O2)",
    "LLVM_globalisel_O3": "GlobalISel (O3)",
    "LLVM_globalisel": "GlobalISel",
    "LLVM_selectiondag_O1": "SelectionDAG (O1)",
    "LLVM_selectiondag_O2": "SelectionDAG (O2)",
    "LLVM_selectiondag_O3": "SelectionDAG (O3)",
    "LLVM_selectiondag": "SelectionDAG",
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
                instruction = parts[8:]  # inst name is in 9th column
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
                        parameter_numbers.append(instructions)
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
    if parameter == "similarity":
        complete_df["is_eqv_LLVM_globalisel"] = complete_df["LLVM_globalisel_" + parameter] == complete_df["LEANMLIR_opt_" + parameter]
        complete_df["is_eqv_LLVM_selectiondag"] = complete_df["LLVM_selectiondag_" + parameter] == complete_df["LEANMLIR_opt_" + parameter]
        # drop LLVM_globalisel_similarity and LLVM_selectiondag_similarity columns
        complete_df = complete_df.drop(
            ["LLVM_globalisel_" + parameter, "LLVM_selectiondag_" + parameter, "LEANMLIR_opt_" + parameter], axis=1
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
    plt.savefig(pdf_filename)
    # print(f"\nPlot saved to '{pdf_filename}' in the current working directory.")
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
    # print(f"\nScatter plot saved to '{pdf_filename}' in the current working directory.")
    plt.close()

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

    # for c in class_order:
    #     if c not in group.columns:
    #         group[c] = 0
    group = group[class_order]

    # Colors for each class
    class_colors = {
        "<1x": light_blue,
        "1x": dark_green,
        "1x-1.5x": light_green,
        "1.5x-2x": light_red,
        ">2x": dark_red,
    }
    
    similarity_df = pd.read_csv(data_dir + "similarity.csv")
    similarity_percentages = {}
    col_name = f"is_eqv_{selector2}"
    for instr_num, group_df in similarity_df.groupby("instructions_number"):
        total_count = len(group_df)
        true_count = group_df[col_name].sum()
        percentage = (true_count / total_count) * 100 if total_count > 0 else 0.0
        similarity_percentages[int(instr_num)] = percentage
        

    def plot_columns(with_similarity=False):
        bottom = np.zeros(len(group))
        similarity_df = pd.read_csv(data_dir + "similarity.csv")
        similarity_df_grouped = similarity_df.groupby("instructions_number")
        x = group.index.astype(str)
        plt.figure(figsize=(10, 5))
        for c in class_order:
            if c == "1x" and with_similarity:
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
        plt.savefig(pdf_filename)
        # print(
        #     f"\nStacked bar plot saved to '{pdf_filename}' in the current working directory."
        # )
        plt.close()

    plot_columns()
    if parameter == "tot_instructions":
        plot_columns(with_similarity=True)
    
    
def violin_plot(parameter, selector1, selector2):
    df = pd.read_csv(data_dir + parameter + ".csv")

    col1 = selector1 + "_" + parameter
    col2 = selector2 + "_" + parameter

    if col1 not in df.columns:
        print(f"Error: the column {col1} does not exist in the dataframe.")
        return
    if col2 not in df.columns:
        print(f"Error: the column {col2} does not exist in the dataframe.")
        return

    df["ratio"] = df[col1] / df[col2]
    
    num_above_50 = sum(df["ratio"] > 50)
    
    print(f"Number of programs with ratio above 50: {num_above_50} out of {len(df)}")
    
    # extract the columns with ratio > 50
    
    high_ratio_df =( df[df["ratio"] > 50]).groupby("instructions_number") 
    for instr_num, group in high_ratio_df:
        print(f"LLVM #Instructions: {instr_num}, #programs with ratio > 50 : {len(group)}")    
        
    # remove points above 50 for y-axis scaling
    
    grouped = df.groupby("instructions_number")["ratio"].apply(list).reset_index()

    violin_data = grouped["ratio"].values
    positions = grouped["instructions_number"].values
    

    plt.figure(figsize=(10, 5))
    parts = plt.violinplot(
        violin_data,
        positions,
        showmedians=True
    )

    for pc in parts["bodies"]:
        pc.set_facecolor(light_green)
        pc.set_edgecolor(light_green)
        pc.set_alpha(1.0)
        
    plt.axhline(1, color=black, linestyle="--", linewidth=1, label="1x")
    plt.text(positions[-1]*1.08, 1.02, "1x", color=black, ha='center', fontsize=20)
        
    for partname in ('cbars', 'cmins', 'cmaxes'):
        if partname in parts:
            parts[partname].set_edgecolor(light_gray)
            parts[partname].set_linewidth(1)
    parts['cmedians'].set_edgecolor(dark_green)

    plt.xlabel(f"#Instructions - LLVM IR")
    plt.ylabel(
        f"{parameters_labels[parameter]},$\\frac{{\\text{{{selector_labels[selector1]}}}}}{{\\text{{{selector_labels[selector2]}}}}}$",
        rotation="horizontal", horizontalalignment="left", y=1.05
    )
    
    # add a marker at the top of every column indicating the number of outliers removed

    max_ratio = df["ratio"].max()
    
    print(f"Max ratio for {parameter} between {selector1} and {selector2} is {max_ratio}")
    
    
    if max_ratio > 200:
        plt.yticks(np.arange(0, 270, 50))
    else:
        plt.yticks(np.arange(0, math.ceil(df["ratio"].max()) + 2, 2))
    
    plt.tight_layout()

    pdf_filename = (
        plots_dir + f"{parameter}_violin_{selector1}_vs_{selector2}.pdf"
    )
    plt.savefig(pdf_filename)
    # print(f"\nViolin plot saved to '{pdf_filename}' in the current working directory.")
    plt.close()


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
    # print(f"\nPlot saved to '{pdf_filename}' in the current working directory.")
    plt.close()

    avg_diff = (
        sorted_df[selector1 + "_" + parameter] - sorted_df[selector2 + "_" + parameter]
    ).mean()
    # Clean names for LaTeX command



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
        # print(f"\nPlot saved to '{pdf_filename}' in the current working directory.")
        plt.close()

def geomean_plot_tot_cycles(): 
    parameters = ("#cycles", "#instructions")
    # tot_cycles
    df_cycles = pd.read_csv(data_dir + "tot_cycles.csv")
    plt.figure(figsize=(6, 5))
    df_cycles['ratio_gisel'] = df_cycles['LEANMLIR_opt_tot_cycles'] / df_cycles['LLVM_globalisel_tot_cycles']
    df_cycles['ratio_sdag'] = df_cycles['LEANMLIR_opt_tot_cycles'] / df_cycles['LLVM_selectiondag_tot_cycles']
    geomean_gisel_cycles = np.exp(np.mean(np.log(df_cycles["ratio_gisel"])))
    geomean_sdag_cycles = np.exp(np.mean(np.log(df_cycles["ratio_sdag"])))
    #tot_instructions 
    df_instructions = pd.read_csv(data_dir + "tot_instructions.csv")
    df_instructions['ratio_gisel'] = df_instructions['LEANMLIR_opt_tot_instructions'] / df_instructions['LLVM_globalisel_tot_instructions']
    df_instructions['ratio_sdag'] = df_instructions['LEANMLIR_opt_tot_instructions'] / df_instructions['LLVM_selectiondag_tot_instructions']
    geomean_gisel_instructions = np.exp(np.mean(np.log(df_instructions["ratio_gisel"])))
    geomean_sdag_instructions= np.exp(np.mean(np.log(df_instructions["ratio_sdag"])))
    geomeans_gisel = [geomean_gisel_instructions, geomean_gisel_cycles]
    geomeans_sdag = [geomean_sdag_instructions, geomean_sdag_cycles]

    x = np.arange(len(parameters))
    width = 0.35
    
    plt.bar(x - width/2, geomeans_gisel, width, label=selector_labels["LLVM_globalisel"], color=light_blue)
    plt.bar(x + width/2, geomeans_sdag, width, label=selector_labels["LLVM_selectiondag"], color=light_red)
    plt.axhline(1, color=black, linestyle="--", linewidth=2)

    plt.ylabel(
            'Geomean Ratio',
            rotation="horizontal",
            horizontalalignment="left",
            y=1,
        )
    plt.xticks(x, parameters)
    plt.legend()
    plt.tight_layout()
    
    pdf_filename = plots_dir + "geomean_comparison.pdf"
    plt.savefig(pdf_filename)
    print(f"\nGeometric mean plot saved to '{pdf_filename}' in the current working directory.")
    plt.close()


def equivalent_plot_perc(): 
    df_similarity = (pd.read_csv(data_dir + "similarity.csv"))
    
    df_eqv_gisel = (
        df_similarity.groupby("instructions_number")["is_eqv_LLVM_globalisel"]
        .value_counts(normalize=True)
        .unstack(fill_value=0)
        * 100
    )
    
    df_eqv_sdag = (
        df_similarity.groupby("instructions_number")["is_eqv_LLVM_selectiondag"]
        .value_counts(normalize=True)
        .unstack(fill_value=0)
        * 100
    )
    plt.figure(figsize=(10, 5))
    
    
    width = 0.35
    
    plt.bar((df_eqv_gisel.index) - width/2, (df_eqv_gisel[True]).to_list(), width, label=selector_labels["LLVM_globalisel"], color=light_blue)
    plt.bar((df_eqv_gisel.index) + width/2, (df_eqv_sdag[True]).to_list(), width, label=selector_labels["LLVM_selectiondag"], color=light_red)
    
    plt.ylabel(
            '% Identical Outputs',
            rotation="horizontal",
            horizontalalignment="left",
            y=1.05,
        )
    plt.xlabel("#Instructions - LLVM IR")
    
    plt.legend()
    plt.tight_layout()
    
    pdf_filename = plots_dir + "equivalent_outputs.pdf"
    plt.savefig(pdf_filename)
    print(f"\nGeometric mean plot saved to '{pdf_filename}' in the current working directory.")
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
    
    df['ratios'] = df[col1] / df[col2]
    
    average_ratios_by_instruction = (
        df.groupby('instructions_number')['ratios']
        .apply(lambda x: np.exp(np.log(x).mean()))
        .reset_index(name='average_ratio')
    )
    

    plt.bar(
        average_ratios_by_instruction["instructions_number"],
        average_ratios_by_instruction["average_ratio"],
        color=light_green,
        label=f"Avg. {parameters_labels[parameter]},$\\frac{{\\text{{{selector_labels[selector1]}}}}}{{\\text{{{selector_labels[selector2]}}}}}$"
    )

    plt.axhline(1, color=black, linestyle="--", linewidth=2)
    plt.text((((average_ratios_by_instruction["instructions_number"]).to_list())[-1])*1.15, 1.05, f"{selector_labels[selector2]}", color=black, ha='center', fontsize=20)
    

    plt.xlabel("#Instructions - LLVM IR")
    
    plt.ylabel(
        f"$\\frac{{\\text{{{selector_labels[selector1]}}}}}{{\\text{{{selector_labels[selector2]}}}}}$, {parameters_labels[parameter]}",
        rotation="horizontal", horizontalalignment="left", y=1.08
    )
    
    if max(average_ratios_by_instruction["average_ratio"]) < 10:
        plt.yticks(np.arange(0, math.ceil(max(average_ratios_by_instruction["average_ratio"])+1), 1))
    else : 
        plt.yticks(np.arange(0, math.ceil(max(average_ratios_by_instruction["average_ratio"])+1), 100))
        
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
    plt.savefig(pdf_filename)
    print(
        f"\nProportional bar plot saved to '{pdf_filename}' in the current working directory."
    )
    plt.close()
    

    

def create_latex_command(parameters, filename):
    f = open(filename, 'w')
    
    git_command = ["git", "rev-parse", "--short", "HEAD"]
    result = subprocess.run(
        git_command, cwd=ROOT_DIR_PATH, capture_output=True, text=True, check=True
    )

    commit_hash = result.stdout.strip()

    f.write(f"Lean-mlir commit hash: {commit_hash}\n")
    
    f.write(f"In the following commands the following rules apply:\n")
    f.write(f"A: class  <1x\n")
    f.write(f"B: class 1x\n")
    f.write(f"C: class 1x-1.5x\n")
    f.write(f"D: class 1.5x-2x\n")
    f.write(f"E: class >2x\n")
    f.write('\n\n')
    
    # print the percentage of programs in each of the above classes, for each number of instructions
    for p in parameters:
        df = pd.read_csv(data_dir + p + ".csv")
        
        df['ratios_gisel'] = df['LEANMLIR_opt_' + p] / df['LLVM_globalisel_' + p]
        df['ratios_sdag'] = df['LEANMLIR_opt_' + p] / df['LLVM_selectiondag_' + p]
        df['ratios_gisel_sdag'] = df['LLVM_globalisel_' + p] / df['LLVM_selectiondag_' + p]
        df['ratios_gisel_class'] = df['ratios_gisel'].apply(lambda x: 'A' if x < 1 else 'B' if x == 1 else 'C' if x < 1.5 else 'D' if x < 2 else 'E')
        df['ratios_sdag_class'] = df['ratios_sdag'].apply(lambda x: 'A' if x < 1 else 'B' if x == 1 else 'C' if x < 1.5 else 'D' if x < 2 else 'E')
        df['ratios_gisel_sdag_class'] = df['ratios_gisel_sdag'].apply(lambda x: 'A' if x < 1 else 'B' if x == 1 else 'C' if x < 1.5 else 'D' if x < 2 else 'E')
        
        # max and min values
        max_ratio_gisel = df["ratios_gisel"].max()
        max_ratio_sdag = df["ratios_sdag"].max()
        max_ratio_gisel_sdag = df["ratios_gisel_sdag"].max()
        min_ratio_gisel = df["ratios_gisel"].min()
        min_ratio_sdag = df["ratios_sdag"].min()
        min_ratio_gisel_sdag = df["ratios_gisel_sdag"].min()
        
        print(df[df['ratios_sdag']==df['ratios_sdag'].min()])
        
        if p == "tot_cycles": 
            p = 'NumCycles'
        else: 
            p = 'NumInstr'
        latex_command_max_gisel = f"\\newcommand{{\\MaxRatioLeanmlirVsGiselParam{p}}}{{{max_ratio_gisel:.2f}}}\n"
        latex_command_max_sdag = f"\\newcommand{{\\MaxRatioLeanmlirVsSdagParam{p}}}{{{max_ratio_sdag:.2f}}}\n"
        latex_command_max_gisel_sdag = f"\\newcommand{{\\MaxRatioGiselVsSdagParam{p}}}{{{max_ratio_gisel_sdag:.2f}}}\n"
        latex_command_min_gisel = f"\\newcommand{{\\MinRatioLeanmlirVsGiselParam{p}}}{{{min_ratio_gisel:.2f}}}\n"
        latex_command_min_sdag = f"\\newcommand{{\\MinRatioLeanmlirVsSdagParam{p}}}{{{min_ratio_sdag:.2f}}}\n"
        latex_command_min_gisel_sdag = f"\\newcommand{{\\MinRatioGiselVsSdagParam{p}}}{{{min_ratio_gisel_sdag:.2f}}}\n"
        
        f.write(latex_command_max_gisel)
        f.write(latex_command_max_sdag)
        f.write(latex_command_min_gisel)
        f.write(latex_command_min_sdag)
        f.write(latex_command_max_gisel_sdag)
        f.write(latex_command_min_gisel_sdag)
        
        
        # calculate % of elements in each class 
        df_grouped_gisel = df.groupby('instructions_number')['ratios_gisel_class'].value_counts(normalize=True) * 100
        df_grouped_sdag = df.groupby('instructions_number')['ratios_sdag_class'].value_counts(normalize=True) * 100
        df_grouped_gisel_sdag = df.groupby('instructions_number')['ratios_gisel_sdag_class'].value_counts(normalize=True) * 100
        
        
        
        # print a latex command for each percentage, specify in the name the class it belongs to 
        # and the `instructions_number`
        
        df_grouped_gisel = df_grouped_gisel.reset_index()
        df_grouped_sdag = df_grouped_sdag.reset_index()
        df_grouped_gisel_sdag = df_grouped_gisel_sdag.reset_index()
        
        for _, row in df_grouped_gisel.iterrows(): 
            c = row['ratios_gisel_class']
            percentage = row['proportion']
            instructions_number = num2words(row['instructions_number'])
            latex_command = f"\\newcommand{{\\PercLeanmlirVsGiselParam{p}Class{c}Instr{instructions_number}}}{{{int(percentage)}\%}}\n"
            f.write(latex_command)
        for _, row in df_grouped_sdag.iterrows(): 
            c = row['ratios_sdag_class']
            percentage = row['proportion']
            instructions_number = num2words(row['instructions_number'])
            latex_command = f"\\newcommand{{\\PercLeanmlirVsSdagParam{p}Class{c}Instr{instructions_number}}}{{{int(percentage)}\%}}\n"
            f.write(latex_command)
            
        for _, row in df_grouped_gisel_sdag.iterrows(): 
            c = row['ratios_gisel_sdag_class']
            percentage = row['proportion']
            instructions_number = num2words(row['instructions_number'])
            latex_command = f"\\newcommand{{\\PercGiselVsSdagParam{p}Class{c}Instr{instructions_number}}}{{{int(percentage)}\%}}\n"
            f.write(latex_command)
        
        # geomean ratios and total geomeans
        
        geomeans_gisel = df.groupby('instructions_number')['ratios_gisel'].apply(
            lambda x: np.exp(np.log(x).mean())
        )
        for instr_num, geomean_value in geomeans_gisel.items():
            instructions_number = num2words(instr_num)
            latex_command = f"\\newcommand{{\\GeomeanLeanmlirVsGiselParam{p}Instr{instructions_number}}}{{{geomean_value:.1f}}}\n"
            f.write(latex_command)
            
        geomeans_sdag = df.groupby('instructions_number')['ratios_sdag'].apply(
            lambda x: np.exp(np.log(x).mean())
        )
        for instr_num, geomean_value in geomeans_sdag.items():
            instructions_number = num2words(instr_num)
            latex_command = f"\\newcommand{{\\GeomeanLeanmlirVsSdagParam{p}Instr{instructions_number}}}{{{geomean_value:.1f}}}\n"
            f.write(latex_command)
        
        # total geomeans
        
        geomean_gisel_tot = np.exp(np.log(df['ratios_gisel']).mean())
        latex_command_gisel_geomean = f"\\newcommand{{\\GeomeanTotLeanmlirVsGisel{p}}}{{{geomean_gisel_tot:.1f}}}\n"
        f.write(latex_command_gisel_geomean)
        
        geomean_gisel_tot_perc = (np.exp(np.log(df['ratios_gisel']).mean()) - 1) * 100
        latex_command_gisel_geomean_perc = f"\\newcommand{{\\GeomeanTotLeanmlirVsGiselSlowDown{p}}}{{{geomean_gisel_tot_perc:.1f}}}\n"
        f.write(latex_command_gisel_geomean_perc)
        
        geomean_sdag_tot = np.exp(np.log(df['ratios_sdag']).mean())
        latex_command_sdag_geomean = f"\\newcommand{{\\GeomeanTotLeanmlirVsSdag{p}}}{{{geomean_sdag_tot:.1f}}}\n"
        f.write(latex_command_sdag_geomean)
        
        geomean_sdag_tot_perc = (np.exp(np.log(df['ratios_sdag']).mean()) - 1) * 100
        latex_command_sdag_geomean_perc = f"\\newcommand{{\\GeomeanTotLeanmlirVsSdagSlowDown{p}}}{{{geomean_sdag_tot_perc:.1f}}}\n"
        f.write(latex_command_sdag_geomean_perc)
        
        
    # print the percentage of programs that are identical, for each number of instructions
    
    df_similarity = pd.read_csv(data_dir + "similarity.csv")
    
    df_similarity_gisel = df_similarity.groupby('instructions_number')['is_eqv_LLVM_globalisel'].value_counts(normalize=True) * 100
    df_similarity_sdag = df_similarity.groupby('instructions_number')['is_eqv_LLVM_selectiondag'].value_counts(normalize=True) * 100
    
    df_similarity_gisel = df_similarity_gisel.reset_index()
    df_similarity_sdag = df_similarity_sdag.reset_index()
    
    for idx, row in df_similarity_gisel.iterrows(): 
        if row['is_eqv_LLVM_globalisel']: 
            percentage = row['proportion']
            instructions_number = num2words(row['instructions_number'])
            latex_command = f"\\newcommand{{\\PercIdenticalGiselInstr{instructions_number}}}{{{int(percentage)}\%}}\n"
            f.write(latex_command)
    for idx, row in df_similarity_sdag.iterrows(): 
        if row['is_eqv_LLVM_selectiondag']: 
            percentage = row['proportion']
            instructions_number = num2words(row['instructions_number'])
            latex_command = f"\\newcommand{{\\PercIdenticalSdagInstr{instructions_number}}}{{{int(percentage)}\%}}\n"
            f.write(latex_command)
    
    # total similarity 
    
    tot_similarity_gisel_true = df_similarity['is_eqv_LLVM_globalisel'].sum()/len(df_similarity)*100
    tot_similarity_sdag_true = df_similarity['is_eqv_LLVM_selectiondag'].sum()/len(df_similarity)*100
    
    latex_command_similarity_tot_gisel = f"\\newcommand{{\\PercIdenticalGiselTot}}{{{tot_similarity_gisel_true:.1f}\%}}\n"
    f.write(latex_command_similarity_tot_gisel)
    latex_command_similarity_tot_sdag = f"\\newcommand{{\\PercIdenticalSdagTot}}{{{tot_similarity_sdag_true:.1f}\%}}\n"
    f.write(latex_command_similarity_tot_sdag)
    f.close()
    
    

    


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
        default="all"
    )

    parser.add_argument(
        "-t",
        "--plot_type",
        nargs="+",
        choices=["scatter", "sorted", "stacked", "overhead", "violin", "all"],
        default="all"
    )

    args = parser.parse_args()

    params_to_evaluate = (
        ["similarity", "tot_instructions", "tot_cycles", "tot_uops"]
        if "all" in args.parameters
        else args.parameters
    )

    plots_to_produce = (
        ["scatter", "sorted", "stacked", "overhead", "proportional", "violin"]
        if "all" in args.plot_type
        else args.plot_type
    )

    setup_benchmarking_directories()
    for parameter in params_to_evaluate:
        extract_data(LLVM_globalisel_results_DIR_PATH, "LLVM_globalisel", parameter)
        extract_data(LLVM_selectiondag_results_DIR_PATH, "LLVM_selectiondag", parameter)
        extract_data(LEANMLIR_opt_results_DIR_PATH, "LEANMLIR_opt", parameter)

        to_join = ["LEANMLIR_opt", "LLVM_globalisel", "LLVM_selectiondag"]
        join_dataframes(to_join, parameter)
        if parameter == "similarity":
            continue
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
            if "violin" in plots_to_produce or "all" in plots_to_produce:
                violin_plot(parameter, "LEANMLIR_opt", "LLVM_globalisel")
                violin_plot(parameter, "LEANMLIR_opt", "LLVM_selectiondag")
                violin_plot(parameter, "LLVM_globalisel", "LLVM_selectiondag")
                # bar_plot(parameter, 'LLVM_globalisel', 'LLVM_selectiondag')
            if "proportional" in plots_to_produce or "all" in plots_to_produce:
                proportional_bar_plot(parameter, "LEANMLIR_opt", "LLVM_globalisel")
                proportional_bar_plot(parameter, "LEANMLIR_opt", "LLVM_selectiondag")
                
                # proportional_bar_plot(parameter, 'LLVM_globalisel', 'LLVM_selectiondag')

    geomean_plot_tot_cycles()
    equivalent_plot_perc()
    create_latex_command(['tot_cycles', 'tot_instructions'], plots_dir + 'numerical_commands.tex')
    
if __name__ == "__main__":
    main()
