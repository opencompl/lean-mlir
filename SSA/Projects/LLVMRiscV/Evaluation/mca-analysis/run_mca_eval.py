

#this script is intended to be run after having run the run_mca.py script to analyse
# the result and it relies on the directories created by run_mca.py.

import subprocess
import os
import re
import csv
from pathlib import Path
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
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


def create_missing_table_folders(): 
    if not os.path.exists(LLVMIR_TABLE_DIR_PATH):
        os.makedirs(LLVMIR_TABLE_DIR_PATH)
    if not os.path.exists(LLVM_GLOBALISEL_TABLE_DIR_PATH):
        os.makedirs(LLVM_GLOBALISEL_TABLE_DIR_PATH)
    if not os.path.exists(LEANMLIR_TABLE_DIR_PATH):
        os.makedirs(LEANMLIR_TABLE_DIR_PATH)

def write_csv(rows, out_dir, filename):
    out_dir = Path(out_dir)
    csv_path = out_dir / filename
    with csv_path.open("w", newline="") as f:
        writer = csv.writer(f)
        writer.writerow(["File", "Instructions"])
        for name, val in rows:
            writer.writerow([name, "" if val == "—" else val])
    return csv_path

def iterate_files_in_directory(directory, out_directory):
    instr = re.compile(r"Instructions:\s*([0-9]+)")  #get number of instr.
    rows = []
    for filename in os.listdir(directory):
        file_path = os.path.join(directory, filename)
        if not os.path.isfile(file_path):
            continue #we skip if its not a file
        pair = "-" # garabage value 
        try:
            with open(file_path, "r") as f:
                for line in f:
                    pair = instr.search(line)
                    if pair:
                        instr_val = pair.group(1)
                        print(f"{filename}: {instr_val}")
                        break #we know this is valid given the structure of the mca output
        except Exception as e:
            print(f"Error reading {file_path}: {e}")
        
        rows.append((filename, instr_val))
    filenametobe = os.path.basename(os.path.normpath(directory))
    write_csv(rows, out_directory,filenametobe) 

# def createPlotsFromTables():
#     directories = [LLVMIR_TABLE_DIR_PATH, LLVM_GLOBALISEL_DIR_PATH, LEANMLIR_TABLE_DIR_PATH]
#     all_data = []
#     for directory in directories:
#         for filename in os.listdir(directory):
#             filepath = os.path.join(directory, filename)
#             if directory == LLVMIR_TABLE_DIR_PATH:
#                 selector = "SelectionDAG"
#             elif directory == LLVM_GLOBALISEL_DIR_PATH:
#                 selector = "GlobalISel"
#             else:
#                 selector = "our"
#             try:
#                 with open(filepath, 'r') as f:
#                     lines = f.readlines()[1:]  # skip header
#                     for line in lines:
#                         parts = line.strip().split(',')
#                         if len(parts) == 2 and parts[1].isdigit():
#                             file_name = parts[0]
#                             instructions = int(parts[1])
#                             all_data.append({
#                                 "Selector": selector,
#                                 "File": file_name,
#                                 "Instructions": instructions / 100
#                             })
#             except Exception as e:
#                 print(f"Error reading file {filepath}: {e}")

#     df = pd.DataFrame(all_data)

#     final_df = df.pivot_table(index='File', columns='Selector', values='Instructions')
#     final_df.to_csv("mca_analysis_instructions_by_function.csv", index=True)

#     pivoted_df = final_df.reset_index()

#     # Sort the DataFrame by the 'our' selector's instruction count if available, otherwise by GlobalISel
#     if 'our' in pivoted_df.columns:
#         pivoted_df = pivoted_df.sort_values(by='our', ascending=True).dropna()
#         sort_column_name = "Our Selector"
#     elif 'GlobalISel' in pivoted_df.columns:
#         pivoted_df = pivoted_df.sort_values(by='GlobalISel', ascending=True).dropna()
#         sort_column_name = "GlobalISel"
#     else:
#         # Fallback if neither 'our' nor 'GlobalISel' exist (should not happen with your data)
#         pivoted_df['Function Number'] = pivoted_df['File'].apply(
#             lambda x: int(re.search(r'function_(\d+)\.out', x).group(1))
#             if re.search(r'function_(\d+)\.out', x) else -1
#         )
#         pivoted_df = pivoted_df.sort_values(by='Function Number').dropna()
#         sort_column_name = "Original Function Index"


#     # Create a new numerical index for plotting after sorting
#     pivoted_df = pivoted_df.reset_index(drop=True)
#     pivoted_df.index.name = 'Sorted Function Index'


#     print("\n(first 5 rows after sorting):")
#     print(pivoted_df.head())

#     # --- Start of Plotting Enhancements ---

#     # Set a more professional style for matplotlib
#     plt.style.use('seaborn-v0_8-darkgrid') # 'seaborn-v0_8-whitegrid' or 'ggplot' are also good options

#     plt.figure(figsize=(14, 8), frameon=False) # Increased figure size for better detail

#     # Define a custom color palette for better distinction and aesthetics
#     colors = {
#         'GlobalISel': '#1f77b4',  # Muted Blue
#         'SelectionDAG': '#ff7f0e', # Muted Orange
#         'our': '#2ca02c'        # Muted Green
#     }

#     # Define markers and line styles
#     markers = {
#         'GlobalISel': 'o',
#         'SelectionDAG': 'x',
#         'our': 's'
#     }
#     line_styles = {
#         'GlobalISel': '-',
#         'SelectionDAG': '--',
#         'our': '-.'
#     }
#     line_widths = {
#         'GlobalISel': 1.5,
#         'SelectionDAG': 1.5,
#         'our': 2.0 # Make 'our' slightly bolder
#     }

#     # Plot each selector with enhanced styling
#     if 'GlobalISel' in pivoted_df.columns:
#         plt.plot(pivoted_df.index, pivoted_df['GlobalISel'],
#                  marker=markers['GlobalISel'],
#                  linestyle=line_styles['GlobalISel'],
#                  linewidth=line_widths['GlobalISel'],
#                  color=colors['GlobalISel'],
#                  label='GlobalISel',
#                  markersize=6, # Larger markers
#                  alpha=0.8)    # Slightly transparent
#     if 'SelectionDAG' in pivoted_df.columns:
#         plt.plot(pivoted_df.index, pivoted_df['SelectionDAG'],
#                  marker=markers['SelectionDAG'],
#                  linestyle=line_styles['SelectionDAG'],
#                  linewidth=line_widths['SelectionDAG'],
#                  color=colors['SelectionDAG'],
#                  label='SelectionDAG',
#                  markersize=6,
#                  alpha=0.8)
#     if 'our' in pivoted_df.columns:
#         plt.plot(pivoted_df.index, pivoted_df['our'],
#                  marker=markers['our'],
#                  linestyle=line_styles['our'],
#                  linewidth=line_widths['our'],
#                  color=colors['our'],
#                  label='Our Selector',
#                  markersize=7, # Slightly larger marker for 'our'
#                  alpha=0.9)

#     # Labels and Title with increased font sizes
#     plt.xlabel(f'Functions Sorted by {sort_column_name} Instruction Count (Index)', fontsize=14, labelpad=10)
#     plt.ylabel('Instruction Count', fontsize=14, labelpad=10)
#     plt.title('Instruction Count per Function for Different Selectors', fontsize=16, pad=20)

#     # Enhance the legend
#     plt.legend(title="Selector Type", fontsize=12, title_fontsize=13,
#                loc='upper left', frameon=True, fancybox=True, shadow=True, borderpad=1) # Added frame and shadow

#     # Customize grid
#     plt.grid(True, linestyle=':', alpha=0.6, color='gray') # Finer grid lines

#     # Customize ticks and their labels
#     plt.tick_params(axis='both', which='major', labelsize=12, length=6)
#     plt.tick_params(axis='both', which='minor', length=3)
#     plt.minorticks_on() # Show minor ticks

#     # Add minor grid lines for better readability
#     plt.grid(which='minor', linestyle=':', alpha=0.3)

#     # Add a text annotation to explain the sorting, if desired
#     # plt.text(0.02, 0.98, f"Functions ordered by '{sort_column_name}' instruction count",
#     #          transform=plt.gca().transAxes, fontsize=10, verticalalignment='top',
#     #          bbox=dict(boxstyle='round,pad=0.5', fc='white', alpha=0.6, ec='lightgray'))


#     plt.tight_layout(rect=[0, 0.03, 1, 0.95]) # Adjust layout to make room for title and labels
#                                               # rect=[left, bottom, right, top] - values are fractions of figure width/height


#     pdf_filename = "instruction_line_diagram_enhanced.pdf" # Changed filename to avoid overwriting
#     plt.savefig(pdf_filename, dpi=300, bbox_inches='tight') # Increased DPI for higher quality image, bbox_inches='tight' for cleaner edges
#     print(f"\nEnhanced Plot saved to '{pdf_filename}' in the current working directory.")

#     pivoted_df.to_csv("pivoted_instructions_for_plot_enhanced.csv")
#     print("Pivoted data used for plotting saved to 'pivoted_instructions_for_plot_enhanced.csv'.")

    # --- End of Plotting Enhancements ---
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
                    lines = f.readlines()[1:]  # skip header
                    for line in lines:
                        parts = line.strip().split(',')
                        if len(parts) == 2 and parts[1].isdigit():
                            file_name = parts[0]
                            instructions = int(parts[1])
                            all_data.append({
                                "Selector": selector,
                                "File": file_name,
                                "Instructions": instructions / 100
                            })
            except Exception as e:
                print(f"Error reading file {filepath}: {e}")

    df = pd.DataFrame(all_data)

    final_df = df.pivot_table(index='File', columns='Selector', values='Instructions')
    final_df.to_csv("mca_analysis_instructions_by_function.csv", index=True)

    pivoted_df = final_df.reset_index()
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

    plt.grid(True, linestyle='--', alpha=0.7)
    plt.tight_layout()

    pdf_filename = f"comparison_plot_{selector1}_vs_{selector2}.pdf"
    plt.savefig(pdf_filename)
    print(f"\nScatter plot saved to '{pdf_filename}' in the current working directory.")



    # plt.show()

if __name__ == "__main__":
    create_missing_table_folders()
    iterate_files_in_directory(LLVMIR_DIR_PATH,LLVMIR_TABLE_DIR_PATH)
    iterate_files_in_directory(LLVM_GLOBALISEL_DIR_PATH,LLVM_GLOBALISEL_TABLE_DIR_PATH)
    iterate_files_in_directory(LEANMLIR_DIR_PATH,LEANMLIR_TABLE_DIR_PATH)
    createPlotsFromTables()