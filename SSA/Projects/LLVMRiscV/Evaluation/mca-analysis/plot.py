#!/usr/bin/env python3

import subprocess
import os
import re
import csv
import argparse
import shutil
from pathlib import Path
import pandas as pd
import matplotlib
import matplotlib.pyplot as plt
import numpy as np


matplotlib.rcParams['pdf.fonttype'] = 42
matplotlib.rcParams['ps.fonttype'] = 42


matplotlib.rcParams['figure.autolayout'] = True
matplotlib.rcParams['legend.frameon'] = False
matplotlib.rcParams['axes.spines.right'] = False
matplotlib.rcParams['axes.spines.top'] = False

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
light_green ,
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


LLVM_globalisel_results_DIR_PATH = (
    f"{ROOT_DIR_PATH}/SSA/Projects/LLVMRiscV/Evaluation/mca-analysis/results/LLVM_globalisel/"
)
LLVM_selectiondag_results_DIR_PATH = (
    f"{ROOT_DIR_PATH}/SSA/Projects/LLVMRiscV/Evaluation/mca-analysis/results/LLVM_selectiondag/"
)
LEANMLIR_results_DIR_PATH = (
    f"{ROOT_DIR_PATH}/SSA/Projects/LLVMRiscV/Evaluation/mca-analysis/results/LEANMLIR/"
)
LEANMLIR_opt_results_DIR_PATH = (
    f"{ROOT_DIR_PATH}/SSA/Projects/LLVMRiscV/Evaluation/mca-analysis/results/LEANMLIR_opt/"
)

tables_dir = f"{ROOT_DIR_PATH}/SSA/Projects/LLVMRiscV/Evaluation/mca-analysis/tables/"
data_dir = f"{ROOT_DIR_PATH}/SSA/Projects/LLVMRiscV/Evaluation/mca-analysis/data/"
plots_dir = f"{ROOT_DIR_PATH}/SSA/Projects/LLVMRiscV/Evaluation/mca-analysis/plots/"


def setup_benchmarking_directories(): 
    """
    Create clean directories to store the benchmarks.
    """
    if not os.path.exists(data_dir):
        os.makedirs(data_dir)
    else : 
        shutil.rmtree(data_dir)
        os.makedirs(data_dir)

    if not os.path.exists(plots_dir):
        os.makedirs(plots_dir)
    else: 
        shutil.rmtree(plots_dir)
        os.makedirs(plots_dir)

parameters_match = {
    "tot_instructions" : "Instructions:      ",
    "tot_cycles" : "Total Cycles:      ",
    "tot_uops" : "Total uOps:        "
}

parameters_labels = {
    "tot_instructions" : "#instructions",
    "tot_cycles" : "#cycles",
    "tot_uops" : "#uOps"
}

selector_labels = {
    "LEANMLIR" : "Cert.",
    "LEANMLIR_opt" : "Cert. + Opt",
    "LLVM_globalisel" : "GlobalISel",
    "LLVM_selectiondag" : "SelectionDAG"
}


def extract_data(results_directory, benchmark_name, parameter) :
    """
    Parses the results of mca and saves the result in a DataFrame, then printed to `.csv`
    """
    function_names = []
    parameter_numbers = []
    for filename in os.listdir(results_directory):
        file_path = os.path.join(results_directory, filename)
        try:
            with open(file_path, "r") as f:
                file_lines = f.readlines()
                for line in file_lines:
                    if parameters_match[parameter] in line : 
                        num = int(line.split(" ")[-1])
                        function_names.append(filename.split(".")[0])
                        parameter_numbers.append(int(num/100))
        except FileNotFoundError:
            print(f"Warning: file not found at {file_path}. Skipping.")
        
    df = pd.DataFrame({"function_name": function_names, benchmark_name+"_"+parameter : parameter_numbers})
    df.to_csv(data_dir + benchmark_name+'_'+ parameter + '.csv')

def join_dataframes(dataframe_names, parameter) :
    """
    Joins multiple DataFrames on a common 'function_name' column.
    """
    for idx, name in enumerate(dataframe_names) : 
        df = pd.read_csv(data_dir + name +"_"+parameter +".csv", index_col=0, header=0)
        if idx == 0 : 
            complete_df = df 
        else: 
            complete_df = pd.merge(complete_df, df, on='function_name', how='inner')
    
    complete_df.to_csv(data_dir + parameter+".csv")

def sorted_line_plot_all(parameter):

    df = pd.read_csv(data_dir + parameter + '.csv')

    sorted_df = df.sort_values(by = 'LEANMLIR_' + parameter)

    plt.plot(sorted_df.index, sorted_df['LEANMLIR_' + parameter], label = selector_labels['LEANMLIR'], 
        color = light_green)
    plt.plot(sorted_df.index, sorted_df['LEANMLIR_opt_' + parameter], label = selector_labels['LEANMLIR_opt'], color = dark_green)
    plt.plot(sorted_df.index, sorted_df['LLVM_globalisel_' + parameter], label=selector_labels['LLVM_globalisel'], color = light_blue)
    plt.plot(sorted_df.index, sorted_df['LLVM_selectiondag_' + parameter], label=selector_labels['LLVM_selectiondag'], color = light_red)

    plt.xlabel('Program Index')
    plt.ylabel(parameter)
    plt.title(f'{parameter} Per Program')
    plt.xticks(range(0, len(sorted_df), int(np.ceil(np.log(len(sorted_df))))))
    plot_min = min(0, np.min([sorted_df['LEANMLIR_' + parameter].min(), 
                                sorted_df['LEANMLIR_opt_' + parameter].min(), 
                                sorted_df['LLVM_globalisel_' + parameter].min(), 
                                sorted_df['LLVM_selectiondag_' + parameter].min()]) - 1)
    plot_max = np.max([sorted_df['LEANMLIR_' + parameter].min(), 
                                sorted_df['LEANMLIR_opt_' + parameter].min(), 
                                sorted_df['LLVM_globalisel_' + parameter].min(), 
                                sorted_df['LLVM_selectiondag_' + parameter].min()]) + 1

    plt.yticks(range(int(plot_min), int(plot_max + 1), 1))
    
    plt.legend()
    plt.tight_layout()

    pdf_filename = plots_dir + parameter + "_line.pdf"
    plt.savefig(pdf_filename)
    print(f"\nPlot saved to '{pdf_filename}' in the current working directory.")
    plt.close()

def scatter_plot(parameter, selector1, selector2) : 
    df = pd.read_csv(data_dir + parameter + '.csv')

    if selector1 + '_' + parameter not in df.columns: 
        print(f"Error: the column {selector1} does not exist in the dataframe.")
        return
    if selector2 + '_' + parameter not in df.columns: 
        print(f"Error: the column {selector2} does not exist in the dataframe.")

    df_plot_comparison = df[[selector1+ '_' + parameter, selector2+ '_' + parameter]].dropna()

    num_data_pairs = df_plot_comparison.shape[0]
    frequencies = df_plot_comparison.groupby([selector1+ '_' + parameter, selector2+ '_' + parameter]).size().reset_index(name='Frequency')
    df_plot_scaled = pd.merge(df_plot_comparison, frequencies, on=[selector1+ '_' + parameter, selector2+ '_' + parameter], how='left')

    df_plot_scaled['Scaled_Size'] = np.sqrt ((df_plot_scaled['Frequency']))*50   + 20

    print("\nData test for plotting (first 5 rows, with frequency and scaled size):")
    print(df_plot_scaled.head())

    plt.scatter(df_plot_scaled[selector1+ '_' + parameter],
                df_plot_scaled[selector2+ '_' + parameter],
                s=df_plot_scaled['Scaled_Size'],
                color='skyblue', alpha=0.7, edgecolors='w', label=f'Function data points (Size by frequency)')

    min_val = min(df_plot_comparison[selector1+ '_' + parameter].min(), df_plot_comparison[selector2+ '_' + parameter].min())
    max_val = max(df_plot_comparison[selector1+ '_' + parameter].max(), df_plot_comparison[selector2+ '_' + parameter].max())
    
    # Add a small buffer to the min/max values for better visualization
    plot_min = max(0, min_val - 1)
    plot_max = max_val + 1

    plt.plot([plot_min, plot_max], [plot_min, plot_max], color='gray', linestyle='--', label='$x=y$ line')
    
    plt.xlabel(selector1 + ' - ' + parameters_labels[parameter])
    plt.ylabel(selector2 + ' - ' + parameters_labels[parameter])

    plt.xlim(plot_min, plot_max)
    plt.ylim(plot_min, plot_max)

    plt.xticks(range(int(plot_min), int(plot_max), 1))
    plt.yticks(range(int(plot_min), int(plot_max), 1))
    plt.gca().set_aspect('equal', adjustable='box') 

    plt.tight_layout()

    pdf_filename = plots_dir + f"scatter_plot_{selector1}_vs_{selector2}.pdf"
    plt.savefig(pdf_filename)
    print(f"\nScatter plot saved to '{pdf_filename}' in the current working directory.")
    plt.close()


def sorted_line_plot(parameter, selector1, selector2):

    df = pd.read_csv(data_dir + parameter + '.csv')

    sorted_df = df.sort_values(by = 'LEANMLIR_' + parameter)

    plt.plot(sorted_df.index, sorted_df[selector1 +'_'+ parameter], label = selector_labels[selector1], color = light_green)
    plt.plot(sorted_df.index, sorted_df[selector2 +'_'+ parameter], label = selector_labels[selector2], color = dark_green)

    plt.xlabel('Program Index')
    plt.ylabel(parameters_labels[parameter])
    plt.title(f'{parameters_labels[parameter]} Per Program, {selector1} vs. {selector2}')
    plt.xticks(range(0, len(sorted_df), int(np.ceil(np.log(len(sorted_df))))))
    plot_min = min(0, np.min([sorted_df[selector1 +'_'+ parameter].min(), 
                                sorted_df[selector2 +'_'+ parameter].min()]) - 1)
    plot_max = np.max([sorted_df[selector1 +'_'+ parameter].min(), 
                                sorted_df[selector2 +'_'+ parameter].min()]) + 1

    plt.yticks(range(int(plot_min), int(plot_max + 1), 1))
    
    plt.legend()
    plt.tight_layout()

    pdf_filename = plots_dir + parameter + f"_{selector1}_vs_{selector2}_line.pdf"
    plt.savefig(pdf_filename)
    print(f"\nPlot saved to '{pdf_filename}' in the current working directory.")
    plt.close()

def overhead_plot(parameter, selector1, selector2):
    """
    Plots the overhead of employing `selector1` against `selector2`
    """
    df = pd.read_csv(data_dir + parameter + '.csv')

    sorted_df = df.sort_values(by=[selector1 + '_' + parameter, selector2 + '_' + parameter], ascending=[True, True])

    plt.stackplot(range(0, len(sorted_df)), sorted_df[selector1 + '_' + parameter],labels=selector_labels[selector1], color = light_green)
    plt.stackplot(range(0, len(sorted_df)), sorted_df[selector2 + '_' + parameter],labels=selector_labels[selector2], color =white, edgecolor=light_red)

    plt.xlabel('Program Index')
    plt.ylabel(parameters_labels[parameter])
    plt.xticks(range(0, len(sorted_df), int(np.ceil(len(sorted_df)/10))))
    plt.legend()
    plt.tight_layout()

    pdf_filename = plots_dir + f"overhead_{selector1}_vs_{selector2}.pdf"
    plt.savefig(pdf_filename)
    print(f"\nPlot saved to '{pdf_filename}' in the current working directory.")
    plt.close()


def main():
    parser = argparse.ArgumentParser(
        prog="plot",
        description="Produce the plots to evaluate the performance of the Lean-MLIR certified Instruction Selection.",
    )

    parser.add_argument(
        "-p",
        "--parameters",
        nargs="+",
        choices=["tot_instructions", "tot_cycles", "tot_uops"], 
    )

    args = parser.parse_args()

    setup_benchmarking_directories()

    print(args)

    for parameter in args.parameters : 
        extract_data(LLVM_selectiondag_results_DIR_PATH, 'LLVM_selectiondag', parameter)
        extract_data(LLVM_globalisel_results_DIR_PATH, 'LLVM_globalisel', parameter)
        extract_data(LEANMLIR_results_DIR_PATH, 'LEANMLIR', parameter)
        extract_data(LEANMLIR_opt_results_DIR_PATH, 'LEANMLIR_opt', parameter)
        join_dataframes(['LEANMLIR', 'LEANMLIR_opt', 'LLVM_globalisel', 'LLVM_selectiondag'], parameter)
        # bubble plots
        scatter_plot(parameter, 'LEANMLIR_opt', 'LLVM_globalisel')
        scatter_plot(parameter, 'LEANMLIR_opt', 'LLVM_selectiondag')
        scatter_plot(parameter, 'LEANMLIR', 'LLVM_globalisel')
        scatter_plot(parameter, 'LEANMLIR', 'LLVM_selectiondag')
        # line plots
        sorted_line_plot_all(parameter)
        sorted_line_plot(parameter, 'LEANMLIR_opt', 'LLVM_globalisel')
        sorted_line_plot(parameter, 'LEANMLIR_opt', 'LLVM_selectiondag')
        sorted_line_plot(parameter, 'LEANMLIR', 'LLVM_globalisel')
        sorted_line_plot(parameter, 'LEANMLIR', 'LLVM_selectiondag')
        # overhead plots 
        overhead_plot(parameter, 'LEANMLIR_opt', 'LLVM_globalisel')
        overhead_plot(parameter, 'LEANMLIR_opt', 'LLVM_selectiondag')
        overhead_plot(parameter, 'LEANMLIR', 'LLVM_globalisel')
        overhead_plot(parameter, 'LEANMLIR', 'LLVM_selectiondag')

if __name__ == "__main__":
    main()



