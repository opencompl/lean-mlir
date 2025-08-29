#this script is intended to be run after having run the run_mca.py script to analyse
# the result and it relies on the directories created by run_mca.py.

import subprocess
import os
import re
import csv
from pathlib import Path
import pandas as pd
import numpy as np
import matplotlib
import matplotlib.pyplot as plt

# Color palette
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

## Use TrueType fonts instead of Type 3 fonts
#
# Type 3 fonts embed bitmaps and are not allowed in camera-ready submissions
# for many conferences. TrueType fonts look better and are accepted.
# This follows: https://www.conference-publishing.com/Help.php
matplotlib.rcParams['pdf.fonttype'] = 42
matplotlib.rcParams['ps.fonttype'] = 42

## Enable tight_layout by default
#
# This ensures the plot has always sufficient space for legends, ...
# Without this sometimes parts of the figure would be cut off.
matplotlib.rcParams['figure.autolayout'] = True

## Legend defaults
matplotlib.rcParams['legend.frameon'] = False

# Hide the right and top spines
#
# This reduces the number of lines in the plot. Lines typically catch
# a readers attention and distract the reader from the actual content.
# By removing unnecessary spines, we help the reader to focus on
# the figures in the graph.
matplotlib.rcParams['axes.spines.right'] = False
matplotlib.rcParams['axes.spines.top'] = False

ROOT_DIR_PATH = (
    subprocess.check_output(["git", "rev-parse", "--show-toplevel"])
    .decode("utf-8")
    .strip()
)

LLVMIR_DIR_PATH = (
    # f"{ROOT_DIR_PATH}/SSA/Projects/LLVMRiscV/Evaluation/mca-analysis/LLVM/"
    f"{ROOT_DIR_PATH}/SSA/Projects/LLVMRiscV/Evaluation/mca-analysis/results/LLVM/"
)
LLVM_GLOBALISEL_DIR_PATH = (
    f"{ROOT_DIR_PATH}/SSA/Projects/LLVMRiscV/Evaluation/mca-analysis/results/LLVM_GLOBALISEL/"
)
LEANMLIR_DIR_PATH = (
    f"{ROOT_DIR_PATH}/SSA/Projects/LLVMRiscV/Evaluation/mca-analysis/results/Lean-MLIR/"
)
LLVMIR_TABLE_DIR_PATH = (
    f"{ROOT_DIR_PATH}/SSA/Projects/LLVMRiscV/Evaluation/mca-analysis/results/LLVM_table/"
)
LLVM_GLOBALISEL_TABLE_DIR_PATH = (
        f"{ROOT_DIR_PATH}/SSA/Projects/LLVMRiscV/Evaluation/mca-analysis/results/LLVM_GLOBALISEL_table/"
)
LEANMLIR_TABLE_DIR_PATH = (
    f"{ROOT_DIR_PATH}/SSA/Projects/LLVMRiscV/Evaluation/mca-analysis/results/Lean-MLIR_table/"
)

def createPlotsFromTables_isel_line():
    df = pd.read_csv('pivoted_instructions_for_plot.csv')

    sorted_by_isel = df.sort_values(by=["our", "GlobalISel"], ascending=[True, True])

    plt.plot(range(0, len(sorted_by_isel)), sorted_by_isel['our'],label = 'Verified ISel', color = light_green)
    plt.plot(range(0, len(sorted_by_isel)), sorted_by_isel['GlobalISel'],label='GlobalISel', color =light_red)

    plt.xlabel('Program idx.')
    plt.ylabel('Instruction Count')
    plt.xticks(range(0, len(sorted_by_isel['our']), 100))
    plt.legend()
    plt.tight_layout()

    pdf_filename = "stackPlot_globalISel_line.pdf"
    plt.savefig(pdf_filename)
    print(f"\nPlot saved to '{pdf_filename}' in the current working directory.")
    plt.close()

def createPlotsFromTables_sdag_line():
    
    df = pd.read_csv('pivoted_instructions_for_plot.csv')

    sorted_by_sdag = df.sort_values(by=["our", "SelectionDAG"], ascending=True)

    plt.plot(range(0, len(sorted_by_sdag)), sorted_by_sdag['our'],label='Verified ISel', color = light_green)
    plt.plot(range(0, len(sorted_by_sdag)), sorted_by_sdag['SelectionDAG'],label='SelectionDAG', color =light_blue)

    plt.xlabel('Program idx.')

    plt.ylabel('Instruction Count')
    plt.xticks(range(0, len(sorted_by_sdag['our']), 100))
    plt.legend()
    plt.tight_layout()

    pdf_filename = "stackPlot_selectionDag_line.pdf"
    plt.savefig(pdf_filename)
    print(f"\nPlot saved to '{pdf_filename}' in the current working directory.")
    plt.close()

def createPlotsFromTables_isel_dot():
    df = pd.read_csv('pivoted_instructions_for_plot.csv')

    sorted_by_isel = df.sort_values(by=["our", "GlobalISel"], ascending=[True, True])

    plt.scatter(range(0, len(sorted_by_isel)), sorted_by_isel['our'], label='Verified ISel', color=light_green, s=10, marker='x', alpha=0.2)
    plt.scatter(range(0, len(sorted_by_isel)), sorted_by_isel['GlobalISel'], label='GlobalISel', color=light_red, s=10, marker='o', alpha=0.2)

    plt.xlabel('Program idx.')
    plt.ylabel('Instruction Count')
    plt.xticks(range(0, len(sorted_by_isel['our']), 100))
    plt.legend()
    plt.tight_layout()

    pdf_filename = "stackPlot_globalISel_dot.pdf"
    plt.savefig(pdf_filename)
    print(f"\nPlot saved to '{pdf_filename}' in the current working directory.")
    plt.close()

def createPlotsFromTables_sdag_dot():
    df = pd.read_csv('pivoted_instructions_for_plot.csv')

    sorted_by_isel = df.sort_values(by=["our", "SelectionDAG"], ascending=[True, True])

    plt.scatter(range(0, len(sorted_by_isel)), sorted_by_isel['our'], label='Verified ISel', color=light_green, s=10, marker='x', alpha=0.2)
    plt.scatter(range(0, len(sorted_by_isel)), sorted_by_isel['SelectionDAG'], label='SelectionDAG', color=light_red, s=10, marker='o', alpha=0.2)

    plt.xlabel('Program idx.')
    plt.ylabel('Instruction Count')
    plt.xticks(range(0, len(sorted_by_isel['our']), 100))
    plt.legend()
    plt.tight_layout()

    pdf_filename = "stackPlot_selectionDAG_dot.pdf"
    plt.savefig(pdf_filename)
    print(f"\nPlot saved to '{pdf_filename}' in the current working directory.")
    plt.close()



def createPlotsFromTables_isel():
    df = pd.read_csv('pivoted_instructions_for_plot.csv')

    sorted_by_isel = df.sort_values(by=["our", "GlobalISel"], ascending=[True, True])

    plt.stackplot(range(0, len(sorted_by_isel)), sorted_by_isel['our'],labels=['Verified ISel'], color = light_green)
    plt.stackplot(range(0, len(sorted_by_isel)), sorted_by_isel['GlobalISel'],labels=['GlobalISel'], color =light_red)

    plt.xlabel('Program idx.')
    plt.ylabel('Instruction Count')
    plt.xticks(range(0, len(sorted_by_isel['our']), 100))
    plt.legend()
    plt.tight_layout()

    pdf_filename = "stackPlot_globalISel.pdf"
    plt.savefig(pdf_filename)
    print(f"\nPlot saved to '{pdf_filename}' in the current working directory.")
    plt.close()

def createPlotsFromTables_sdag():
    df = pd.read_csv('pivoted_instructions_for_plot.csv')

    sorted_by_sdag = df.sort_values(by=["our", "SelectionDAG"], ascending=True)

    plt.stackplot(range(0, len(sorted_by_sdag)), sorted_by_sdag['our'],labels=['Verified ISel'], color = light_green)
    plt.stackplot(range(0, len(sorted_by_sdag)), sorted_by_sdag['SelectionDAG'],labels=['SelectionDAG'], color =light_blue)

    plt.xlabel('Program idx.')
    plt.ylabel('Instruction Count')
    plt.xticks(range(0, len(sorted_by_sdag['our']), 100))
    plt.legend()
    plt.tight_layout()

    pdf_filename = "stackPlot_selectionDag.pdf"
    plt.savefig(pdf_filename)
    print(f"\nPlot saved to '{pdf_filename}' in the current working directory.")
    plt.close()

def createPlotsFromTables_isel_overhead():
    df = pd.read_csv('pivoted_instructions_for_plot.csv')

    sorted_by_isel = df.sort_values(by=["our", "GlobalISel"], ascending=[True, True])

    plt.stackplot(range(0, len(sorted_by_isel)), sorted_by_isel['our'],labels=['Verified ISel'], color = light_green)
    plt.stackplot(range(0, len(sorted_by_isel)), sorted_by_isel['GlobalISel'],labels=['GlobalISel'], color =white,edgecolor=light_red)

    plt.xlabel('Program idx.')
    plt.ylabel('Instruction Count')
    plt.xticks(range(0, len(sorted_by_isel['our']), 100))
    plt.legend()
    plt.tight_layout()

    pdf_filename = "stackPlot_globalISel_overhead.pdf"
    plt.savefig(pdf_filename)
    print(f"\nPlot saved to '{pdf_filename}' in the current working directory.")
    plt.close()

def createPlotsFromTables_sdag_overhead():
    df = pd.read_csv('pivoted_instructions_for_plot.csv')

    sorted_by_sdag = df.sort_values(by=["our", "SelectionDAG"], ascending=True)

    plt.stackplot(range(0, len(sorted_by_sdag)), sorted_by_sdag['our'],labels=['Verified ISel'], color = light_green)
    plt.stackplot(range(0, len(sorted_by_sdag)), sorted_by_sdag['SelectionDAG'],labels=['SelectionDAG'], color =white, edgecolor=light_blue)

    plt.xlabel('Program idx.')
    plt.ylabel('Instruction Count')
    plt.xticks(range(0, len(sorted_by_sdag['our']), 100))
    plt.legend()
    plt.tight_layout()

    pdf_filename = "stackPlot_selectionDag_overhead.pdf"
    plt.savefig(pdf_filename)
    print(f"\nPlot saved to '{pdf_filename}' in the current working directory.")
    plt.close()

def createPlotsFromTables_diff_both():
    df = pd.read_csv('pivoted_instructions_for_plot.csv')

    sorted_by_sdag = df.sort_values(by="our", ascending=True)
    diff_sdag = np.sort(np.array(df["our"]-df["SelectionDAG"]))
    diff_isel = np.sort(np.array(df["our"]-df["GlobalISel"]))

    plt.plot(diff_sdag, label="vs. SelectionDAG", color =light_blue)
    plt.plot(diff_isel, label="vs. GlobalISel", color =light_red)
    plt.legend()
    plt.xlabel('Program idx.')

    plt.ylabel('Difference in Instruction Count')
    plt.xticks(range(0, len(df['our']), 100))
    plt.tight_layout()

    pdf_filename = "diffplot_sdag_isel.pdf"
    plt.savefig(pdf_filename)
    print(f"\nPlot saved to '{pdf_filename}' in the current working directory.")
    plt.close()

def createPlotsFromTables_diff_bars_sdag():
    df = pd.read_csv('pivoted_instructions_for_plot.csv')
    df['diff_sdag'] = df["our"] - df["SelectionDAG"]

    value_counts = df['diff_sdag'].value_counts().sort_index()
    total = len(df)
    percentages = (value_counts / total) * 100

    plt.bar(percentages.index, percentages.values, color=light_green)
    plt.xlabel('Difference in Instruction Count against SelectionDAG')
    plt.ylabel('% Programs')
    plt.xticks(range(int(min(percentages.index)), int(max(percentages.index))+1, 1))
    plt.tight_layout()

    pdf_filename = "diff_histogram_sdag.pdf"
    plt.savefig(pdf_filename)
    print(f"\nPlot saved to '{pdf_filename}' in the current working directory.")
    plt.close()

def createPlotsFromTables_diff_bars_gisel():
    df = pd.read_csv('pivoted_instructions_for_plot.csv')
    df['diff_sdag'] = df["our"] - df["GlobalISel"]

    value_counts = df['diff_sdag'].value_counts().sort_index()
    total = len(df)
    percentages = (value_counts / total) * 100

    plt.bar(percentages.index, percentages.values, color=light_green)
    plt.xlabel('Difference in Instruction Count against GlobalISel')
    plt.xticks(range(int(min(percentages.index)), int(max(percentages.index))+1, 1))
    plt.ylabel('% Programs')
    plt.tight_layout()

    pdf_filename = "diff_histogram_gisel.pdf"
    plt.savefig(pdf_filename)
    print(f"\nPlot saved to '{pdf_filename}' in the current working directory.")
    plt.close()




def createPlotsFromTables():
    pivoted_df = pd.read_csv('pivoted_instructions_for_plot.csv')
# Sort the DataFrame by the 'our' selector's instruction count
    if 'our' in pivoted_df.columns:
        pivoted_df = pivoted_df.sort_values(by='our').dropna()
    else:
        # Fallback to sorting by Function Number if 'our' column doesn't exist
        pivoted_df['Function Number'] = pivoted_df['File'].apply(
            lambda x: int(re.search(r'function_(\d+)\.out', x).group(1))
            if re.search(r'function_(\d+)\.out', x) else -1
        )
        pivoted_df = pivoted_df.sort_values(by='Function Number').dropna()
        
    pivoted_df = pivoted_df.reset_index(drop=True)
    pivoted_df.index.name = 'Sorted Function Index'

    print("\n(first 5 rows):")
    print(pivoted_df.head())

    plt.figure(figsize=(12, 7),frameon=False)

    # Plot with thinner lines, sorted already by index
    if 'GlobalISel' in pivoted_df.columns:
        plt.plot(pivoted_df.index, pivoted_df['GlobalISel'],
                 marker='o', linewidth=0.8, label='GlobalISel')
    if 'SelectionDAG' in pivoted_df.columns:
        plt.plot(pivoted_df.index, pivoted_df['SelectionDAG'],
                 marker='x', linewidth=0.8, label='SelectionDAG')
    if 'our' in pivoted_df.columns:
        plt.plot(pivoted_df.index, pivoted_df['our'],
                 marker='s', linewidth=0.8, label='Our Selector')

    plt.xlabel('Function Number')
    plt.ylabel('Instruction Count')
    plt.title('Instruction Count per Function for Different Selectors')
    # plt.xticks(pivoted_df.index)  # only show function numbers on x-axis
    plt.legend()
    # plt.grid(True, linestyle='--', alpha=0.7)
    plt.tight_layout()

    pdf_filename = "instruction_line_diagram.pdf"
    plt.savefig(pdf_filename)
    print(f"\nPlot saved to '{pdf_filename}' in the current working directory.")

    pivoted_df.to_csv("pivoted_instructions_for_plot.csv")
    print("Pivoted data used for plotting saved to 'pivoted_instructions_for_plot.csv'.")

def createPlotsFromTables():
    directories = [LLVMIR_TABLE_DIR_PATH, LLVM_GLOBALISEL_TABLE_DIR_PATH, LEANMLIR_TABLE_DIR_PATH]
    all_data = []
    for directory in directories:
        for filename in os.listdir(directory):
            filepath = os.path.join(directory, filename)
            if directory == LLVMIR_TABLE_DIR_PATH:
                selector = "SelectionDAG"
            elif directory == LLVM_GLOBALISEL_TABLE_DIR_PATH:
                selector = "GlobalISel"
            else:
                selector = "our"
            try:
                with open(filepath, 'r') as f:
                    lines = f.readlines()[1:] # we skip the header.
                    for line in lines:
                        parts = line.strip().split(',')
                        if len(parts) == 2:
                            file_name = parts[0]
                            instructions = int(parts[1])
                            all_data.append({"Selector" : selector, "File": file_name, "Instructions": instructions/100})
            except Exception as e:
                print(f"Error reading file {filepath}: {e}")
    df = pd.DataFrame(all_data)

    final_df = df.pivot_table(index='File', columns='Selector', values='Instructions')
    print("\nPivoted Table:")
    print(final_df)
    final_df.to_csv("mca_analysis_instructions_by_function.csv", index=True) # index=True to keep 'File' as the first column in CSV
    print(f"\nrun successfull, populated final table.")
    pivoted_df = final_df.reset_index()
    pivoted_df['Function Number'] = pivoted_df['File'].apply(
        lambda x: int(re.search(r'function_(\d+)\.out', x).group(1)) if re.search(r'function_(\d+)\.out', x) else -1
    )

    # Sort the DataFrame by the new 'Function Number' for correct plotting order
    pivoted_df1 = pivoted_df.sort_values(by='Function Number').set_index('Function Number')

    
    pivoted_df = pivoted_df1.dropna() #drop nan if lean mlir doesnt lower it
    print("\n (first 5 rows):")
    print(pivoted_df.head()) #to check the first 5
    plt.figure(figsize=(12, 7))  # Set the figure size for better readability

    # line diagram plot.
    if 'GlobalISel' in pivoted_df.columns:
     plt.plot(pivoted_df.index, pivoted_df['GlobalISel'], marker='o', label='GlobalISel')
    if 'SelectionDAG' in pivoted_df.columns:
        plt.plot(pivoted_df.index, pivoted_df['SelectionDAG'], marker='x', label='SelectionDAG')
    if 'our' in pivoted_df.columns:
        plt.plot(pivoted_df.index, pivoted_df['our'], marker='s', label='Our Selector')
    plt.xlabel('Function Number')
    plt.ylabel('Instruction Count')
    plt.title('Instruction Count per Function for Different Selectors')
    plt.xticks(pivoted_df.index)
    plt.legend()
    plt.grid(True, linestyle='--', alpha=0.7)
    plt.tight_layout()

    pdf_filename = "instruction_line_diagram.pdf"
    plt.savefig(pdf_filename)
    print(f"\nPlot saved to '{pdf_filename}' in the current working directory.")
    #plt.show()
    pivoted_df.to_csv("pivoted_instructions_for_plot.csv")
    print(f"\nPivoted data used for plotting saved to 'pivoted_instructions_for_plot.csv'.")
    
    
    #scatter plot
    llvm_selector_column_GlobalISel = 'GlobalISel'
    llvm_selector_column_SelectionDAG = 'SelectionDAG'
    our_selector_column = 'our'
    scatter_plotting_selectors (pivoted_df, our_selector_column, llvm_selector_column_SelectionDAG)
    scatter_plotting_selectors (pivoted_df, our_selector_column, llvm_selector_column_GlobalISel)
    scatter_plotting_selectors (pivoted_df, llvm_selector_column_GlobalISel, llvm_selector_column_SelectionDAG)


def createPlotsFromTables_GlobalISel_area():
    directories = [LLVMIR_TABLE_DIR_PATH, LLVM_GLOBALISEL_TABLE_DIR_PATH, LEANMLIR_TABLE_DIR_PATH]
    all_data = []
    for directory in directories:
        for filename in os.listdir(directory):
            filepath = os.path.join(directory, filename)
            if directory == LLVMIR_TABLE_DIR_PATH:
                selector = "SelectionDAG"
            elif directory == LLVM_GLOBALISEL_TABLE_DIR_PATH:
                selector = "GlobalISel"
            else:
                selector = "our"
            try:
                with open(filepath, 'r') as f:
                    lines = f.readlines()[1:] # we skip the header.
                    for line in lines:
                        parts = line.strip().split(',')
                        if len(parts) == 2:
                            file_name = parts[0]
                            instructions = int(parts[1])
                            all_data.append({"Selector" : selector, "File": file_name, "Instructions": instructions/100})
            except Exception as e:
                print(f"Error reading file {filepath}: {e}")
    df = pd.DataFrame(all_data)

    final_df = df.pivot_table(index='File', columns='Selector', values='Instructions')
    print("\nPivoted Table:")
    print(final_df)
    final_df.to_csv("mca_analysis_instructions_by_function.csv", index=True) # index=True to keep 'File' as the first column in CSV
    print(f"\nrun successfull, populated final table.")
    pivoted_df = final_df.reset_index()
    pivoted_df['Function Number'] = pivoted_df['File'].apply(
        lambda x: int(re.search(r'function_(\d+)\.out', x).group(1)) if re.search(r'function_(\d+)\.out', x) else -1
    )

    # Sort the DataFrame by the new 'Function Number' for correct plotting order
    pivoted_df1 = pivoted_df.sort_values(by='Function Number').set_index('Function Number')
    pivoted_df1 = pivoted_df.sort_values(by='Function Number').set_index('Function Number')

    print("\n\n\npivoted_df1:\n")
    print(pivoted_df1)
    
    pivoted_df = pivoted_df1.dropna() #drop nan if lean mlir doesnt lower it
    print("\n (first 5 rows):")
    print(pivoted_df.head()) #to check the first 5
    plt.figure(figsize=(24, 7))  # Set the figure size for better readability

    # line diagram plot.
    plt.stackplot(pivoted_df.index, pivoted_df['our'], pivoted_df['GlobalISel'], labels=['ours', 'GlobalISel'])


    plt.xlabel('Function Number')
    plt.ylabel('Instruction Count')
    plt.title('Instruction Count per Function for Different Selectors')
    plt.xticks(range(0, len(pivoted_df['our']), 100))
    plt.legend()
    plt.tight_layout()

    pdf_filename = "stackplot_globalISel.pdf"
    plt.savefig(pdf_filename)
    print(f"\nPlot saved to '{pdf_filename}' in the current working directory.")
    #plt.show()
    print(f"\nPivoted data used for plotting saved to 'pivoted_instructions_for_plot.csv'.")


def createPlotsFromTables_SDAG_area():
    directories = [LLVMIR_TABLE_DIR_PATH, LLVM_GLOBALISEL_TABLE_DIR_PATH, LEANMLIR_TABLE_DIR_PATH]
    all_data = []
    for directory in directories:
        for filename in os.listdir(directory):
            filepath = os.path.join(directory, filename)
            if directory == LLVMIR_TABLE_DIR_PATH:
                selector = "SelectionDAG"
            elif directory == LLVM_GLOBALISEL_TABLE_DIR_PATH:
                selector = "GlobalISel"
            else:
                selector = "our"
            try:
                with open(filepath, 'r') as f:
                    lines = f.readlines()[1:] # we skip the header.
                    for line in lines:
                        parts = line.strip().split(',')
                        if len(parts) == 2:
                            file_name = parts[0]
                            instructions = int(parts[1])
                            all_data.append({"Selector" : selector, "File": file_name, "Instructions": instructions/100})
            except Exception as e:
                print(f"Error reading file {filepath}: {e}")
    df = pd.DataFrame(all_data)

    final_df = df.pivot_table(index='File', columns='Selector', values='Instructions')
    print("\nPivoted Table:")
    print(final_df)
    final_df.to_csv("mca_analysis_instructions_by_function.csv", index=True) # index=True to keep 'File' as the first column in CSV
    print(f"\nrun successfull, populated final table.")
    pivoted_df = final_df.reset_index()
    pivoted_df['Function Number'] = pivoted_df['File'].apply(
        lambda x: int(re.search(r'function_(\d+)\.out', x).group(1)) if re.search(r'function_(\d+)\.out', x) else -1
    )

    # Sort the DataFrame by the new 'Function Number' for correct plotting order
    pivoted_df1 = pivoted_df.sort_values(by='Function Number').set_index('Function Number')

    
    pivoted_df = pivoted_df1.dropna() #drop nan if lean mlir doesnt lower it
    print("\n (first 5 rows):")
    print(pivoted_df.head()) #to check the first 5

    plt.figure(figsize=(24, 7))  # Set the figure size for better readability

    # line diagram plot.
    plt.stackplot(pivoted_df.index, pivoted_df['our'], pivoted_df['SelectionDAG'], labels=['ours', 'SelectionDAG'])

    plt.xlabel('Function Number')
    plt.ylabel('Instruction Count')
    plt.title('Instruction Count per Function for Different Selectors')
    plt.xticks(range(0, len(pivoted_df['our']), 50))
    plt.legend()
    plt.tight_layout()

    pdf_filename = "stackPlot_selectionDag.pdf"
    plt.savefig(pdf_filename)
    print(f"\nPlot saved to '{pdf_filename}' in the current working directory.")
    #plt.show()

def scatter_plotting_selectors (pivoted_df, selector1, selector2): # defined selector1 as x-axes.
    plt.figure(figsize=(8, 8),frameon=False) # A square figure is often good for comparison plots

    #cech existence
    if selector1 not in pivoted_df.columns or selector2 not in pivoted_df.columns:
        print(f"Error: the column we wanred doesnt exist'{selector1}' or '{selector2}' not found in data.")
        return

    df_plot_comparison = pivoted_df[[selector1, selector2]].dropna()
    if df_plot_comparison.empty:
        print(f"No common data points for '{selector1}' and '{selector2}' after dropping NaNs. No plot generated.")
        return
    

    num_data_pairs = df_plot_comparison.shape[0]
    print(num_data_pairs)   
    frequencies = df_plot_comparison.groupby([selector1, selector2]).size().reset_index(name='Frequency')
    print("here")
    print(frequencies)
    df_plot_scaled = pd.merge(df_plot_comparison, frequencies, on=[selector1, selector2], how='left')

    # difference scaling 
    # print(1/(df_plot_scaled['Frequency']/num_data_pairs))# improve scaling 

    df_plot_scaled['Scaled_Size'] = np.sqrt ((df_plot_scaled['Frequency']))*50   + 20
    # df_plot_scaled['Scaled_Size'] = (df_plot_scaled['Frequency'] * 50) + 20 # *  (df_plot_scaled['Frequency']/num_data_pairs ) + 20
    # df_plot_scaled['Scaled_Size'] = np.sqrt ((1/(df_plot_scaled['Frequency']/num_data_pairs) * 2500)) 

    print("\nData test for plotting (first 5 rows, with frequency and scaled size):")
    print(df_plot_scaled.head())

    plt.scatter(df_plot_scaled[selector1],
                df_plot_scaled[selector2],
                s=df_plot_scaled['Scaled_Size'],
                color='skyblue', alpha=0.7, edgecolors='w', label=f'Function data points (Size by frequency)')

    # # Scatter plot: 'our' instructions on x-axis, LLVM selector instructions on y-axis
    # plt.scatter(df_plot_comparison[our_selector_column],
    #             df_plot_comparison[llvm_selector_column],
    #             color='skyblue', alpha=0.7, edgecolors='w', s=100, label=f'Function data points') # Added label for legend

    # Add the x=y line (diagonal line)
    # Determine the limits for the x=y line based on the data range

    min_val = min(df_plot_comparison[selector1].min(), df_plot_comparison[selector2].min())
    max_val = max(df_plot_comparison[selector1].max(), df_plot_comparison[selector2].max())
    
    # Add a small buffer to the min/max values for better visualization
    buffer = (max_val - min_val) * 0.1
    plot_min = max(0, min_val - buffer) # Ensure it doesn't go below zero
    plot_max = max_val + buffer

    plt.plot([plot_min, plot_max], [plot_min, plot_max], color='gray', linestyle='--', label='$x=y$ line')
    if selector1 == 'our':
        plt.xlabel(f'Verified ISel Instruction Count')
    else:
        plt.xlabel(f'{selector1} Instruction Count')
    plt.ylabel(f' LLVM {selector2} Instruction Count')
    # if selector1 == 'our':
    #     plt.title(f'Instruction Count Comparison Per Program: {selector2} vs. Verified ISel')
    # else :
    #     plt.title(f'Instruction Count Comparison Per Program: {selector2} vs. {selector1} ')
    # plt.legend()

    # Set axis limits to be equal to visually compare values directly
    plt.xlim(plot_min, plot_max)
    plt.ylim(plot_min, plot_max)
    plt.gca().set_aspect('equal', adjustable='box') # Make  axes equal

    plt.tight_layout()

    pdf_filename = f"comparison_plot_{selector1}_vs_{selector2}.pdf"
    plt.savefig(pdf_filename)
    print(f"\nScatter plot saved to '{pdf_filename}' in the current working directory.")



    # plt.show()

if __name__ == "__main__":
    createPlotsFromTables()