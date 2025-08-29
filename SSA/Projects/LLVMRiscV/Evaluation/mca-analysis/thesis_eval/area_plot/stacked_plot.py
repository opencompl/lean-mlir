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

if __name__ == "__main__":
    createPlotsFromTables_sdag()
    createPlotsFromTables_sdag_line()
    createPlotsFromTables_isel()
    createPlotsFromTables_isel_line()
    createPlotsFromTables_diff_both()
    createPlotsFromTables_diff_bars_sdag()
    createPlotsFromTables_diff_bars_gisel()
    createPlotsFromTables_sdag_dot()
    createPlotsFromTables_isel_dot()
    createPlotsFromTables_isel_overhead()
    createPlotsFromTables_sdag_overhead()