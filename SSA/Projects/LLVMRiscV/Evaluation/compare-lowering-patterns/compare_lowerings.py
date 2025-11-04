#!/usr/bin/env python3

import os
import re
import sys
import argparse
from pathlib import Path
from collections import defaultdict, Counter
import json
import subprocess
from datetime import datetime

ROOT_DIR = (
    subprocess.check_output(["git", "rev-parse", "--show-toplevel"])
    .decode("utf-8")
    .strip()
)

MCA_LEANMLIR_DIR = (
    f"{ROOT_DIR}/SSA/Projects/LLVMRiscV/Evaluation/mca-analysis/results/LEANMLIR/"
)
MCA_LEANMLIR_opt_DIR = (
    f"{ROOT_DIR}/SSA/Projects/LLVMRiscV/Evaluation/mca-analysis/results/LEANMLIR_opt/"
)
MCA_LLVM_globalisel_DIR = (
    f"{ROOT_DIR}/SSA/Projects/LLVMRiscV/Evaluation/mca-analysis/results/LLVM_globalisel/"
)
MCA_LLVM_selectiondag_DIR = (
    f"{ROOT_DIR}/SSA/Projects/LLVMRiscV/Evaluation/mca-analysis/results/LLVM_selectiondag/"
)

LOGS_DIR = f"{ROOT_DIR}/SSA/Projects/LLVMRiscV/Evaluation/compare-lowering-patterns"


class Logger:
    """Logger class to write to both console and file."""
    
    def __init__(self, log_file):
        self.log_file = log_file
        self.file_handle = None
        
    def __enter__(self):
        # Create logs directory if it doesn't exist
        os.makedirs(os.path.dirname(self.log_file), exist_ok=True)
        self.file_handle = open(self.log_file, 'w')
        return self
        
    def __exit__(self, exc_type, exc_val, exc_tb):
        if self.file_handle:
            self.file_handle.close()
    
    def log(self, message):
        """Write message to both console and file."""
        print(message)
        if self.file_handle:
            self.file_handle.write(message + '\n')
            self.file_handle.flush()


def parse_instructions(filename):
    """
    Parse instructions from a compiler output file.
    
    Args:
        filename: Path to the .out file
        
    Returns:
        List of instruction names
    """
    instructions = []
    in_instruction_section = False
    
    try:
        with open(filename, 'r') as f:
            for line in f:
                if '[0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    Instructions:' in line:
                    in_instruction_section = True
                    continue
                if in_instruction_section and line.strip():
                    parts = line.split()
                    if len(parts) > 8:
                        instruction = parts[8]  # inst name is in 9th column
                        instructions.append(instruction)
    except FileNotFoundError:
        print(f"Warning: File not found: {filename}")
        return []
    except Exception as e:
        print(f"Error parsing {filename}: {e}")
        return []
    
    return instructions


def collect_results_lean(base_dir):
    results = {}
    
    if not os.path.exists(base_dir):
        print(f"Warning: Directory not found: {base_dir}")
        return results
    
    for filename in os.listdir(base_dir):
        filepath = os.path.join(base_dir, filename)
        basename = os.path.basename(filename)
        pattern = r'llvm_(\w+)_(\d+)\.out'
        match = re.match(pattern, basename)
        
        if match: 
            instruction_name = match.group(1)
            variant = int(match.group(2))
            
            instructions = parse_instructions(filepath)
            
            if instruction_name not in results:
                results[instruction_name] = {}

            results[instruction_name][variant] = instructions
    
    return results

    
    
def collect_results_llvm(base_dir):
    results = {}
    
    if not os.path.exists(base_dir):
        print(f"Warning: Directory not found: {base_dir}")
        return results
    
    for filename in os.listdir(base_dir):
        filepath = os.path.join(base_dir, filename)
        basename = os.path.basename(filename)
        pattern = r'llvm_(\w+)_(\d+)_(O[0-3]|default)\.out'
        match = re.match(pattern, basename)
        
        if match: 
            instruction_name = match.group(1)
            variant = int(match.group(2))
            opt_level = match.group(3)
            
            instructions = parse_instructions(filepath)
            
            if instruction_name not in results:
                results[instruction_name] = {}
            if variant not in results[instruction_name]:
                results[instruction_name][variant] = {}
            
            results[instruction_name][variant][opt_level] = instructions
    
    return results


def log_instruction_diff(logger, instructions_list, labels):
    """
    Log detailed differences between instruction lists.
    
    Args:
        logger: Logger instance
        instructions_list: List of instruction lists to compare
        labels: Labels for each instruction list
    """
    max_len = max(len(insts) for insts in instructions_list)
    
    logger.log("\n    Instruction-by-instruction comparison:")
    logger.log("    " + "-" * 80)
    
    # Print header
    header = f"    {'Index':<8}"
    for label in labels:
        header += f"{label:<25}"
    logger.log(header)
    logger.log("    " + "-" * 80)
    
    # Compare instruction by instruction
    for i in range(max_len):
        row = f"    {i:<8}"
        instructions_at_i = []
        
        for insts in instructions_list:
            if i < len(insts):
                inst = insts[i]
                instructions_at_i.append(inst)
                row += f"{inst:<25}"
            else:
                instructions_at_i.append(None)
                row += f"{'<missing>':<25}"
        
        # Highlight if instructions differ at this position
        if len(set(inst for inst in instructions_at_i if inst is not None)) > 1:
            logger.log(row + " DIFFERS")
        else:
            logger.log(row)
    
    logger.log("    " + "-" * 80)
    
    # Print summary
    logger.log("\n    Summary:")
    for label, insts in zip(labels, instructions_list):
        logger.log(f"      {label}: {len(insts)} instructions")
    logger.log("")


def compare_in_compiler(logger, results, op, var, compiler_name):
    """
    Compare instruction sets across optimization levels within a single compiler.
    
    Args:
        logger: Logger instance
        results: List of instruction lists for different optimization levels
        op: Operation name
        var: Variant number
        compiler_name: Name of the compiler
    """
    all_equal = all(lst == results[0] for lst in results)
    
    if all_equal:
        logger.log(f"  ✓ All optimization levels produce the same instructions for "
                   f"{compiler_name} llvm.{op} variant {var}")
    else:
        logger.log(f"\n  ✗ DIFFERENT instruction sets found across optimization levels for "
                   f"{compiler_name} llvm.{op} variant {var}")
        
        # Create labels for each optimization level
        opt_levels = ['O0', 'O1', 'O2', 'O3', 'default'][:len(results)]
        log_instruction_diff(logger, results, opt_levels)


def compare_llvm_compilers(logger, globalisel_results, selectiondag_results):
    """
    Compare instruction sets between GlobalISel and SelectionDAG compilers.
    """
    logger.log("\n" + "=" * 100)
    logger.log("COMPARISON 1: GlobalISel vs SelectionDAG")
    logger.log("=" * 100 + "\n")
    
    for operation in sorted(globalisel_results.keys()):
        for variant in sorted(globalisel_results[operation].keys()):
            logger.log(f"\n{'─' * 100}")
            logger.log(f"Operation: llvm.{operation}, Variant: {variant}")
            logger.log(f"{'─' * 100}")
            
            opt_results_globalisel = []
            opt_results_selectiondag = []
            opt_levels = sorted(globalisel_results[operation][variant].keys())
            
            # Compare across optimization levels
            for opt_level in opt_levels:
                globalisel_insts = globalisel_results[operation][variant][opt_level]
                selectiondag_insts = selectiondag_results[operation][variant][opt_level]
                
                opt_results_globalisel.append(globalisel_insts)
                opt_results_selectiondag.append(selectiondag_insts)
                
                if globalisel_insts == selectiondag_insts:
                    logger.log(f"  ✓ Same instructions at {opt_level}")
                else:
                    logger.log(f"\n  ✗ DIFFERENT instructions at {opt_level}")
                    log_instruction_diff(
                        logger,
                        [globalisel_insts, selectiondag_insts],
                        [f"GlobalISel-{opt_level}", f"SelectionDAG-{opt_level}"]
                    )
            
            # Compare within each compiler across optimization levels
            logger.log("")
            compare_in_compiler(logger, opt_results_globalisel, operation, variant, "GlobalISel")
            compare_in_compiler(logger, opt_results_selectiondag, operation, variant, "SelectionDAG")


def compare_lean_vs_llvm(logger, leanmlir_results, leanmlir_opt_results, 
                         globalisel_results, selectiondag_results):
    """
    Compare LEAN compilers with LLVM compilers.
    - LEANMLIR vs O0 of GlobalISel and SelectionDAG
    - LEANMLIR_opt vs O2 of GlobalISel and SelectionDAG
    """
    logger.log("\n" + "=" * 100)
    logger.log("COMPARISON 2: LEANMLIR vs LLVM at O0")
    logger.log("=" * 100 + "\n")
    
    # Get all operations that exist in LEANMLIR
    for operation in sorted(leanmlir_results.keys()):
        for variant in sorted(leanmlir_results[operation].keys()):
            logger.log(f"\n{'─' * 100}")
            logger.log(f"Operation: llvm.{operation}, Variant: {variant}")
            logger.log(f"{'─' * 100}")
            
            lean_insts = leanmlir_results[operation][variant]
            
            # Check if this operation/variant exists in LLVM results
            if operation not in globalisel_results or variant not in globalisel_results[operation]:
                logger.log(f" ✗ Operation/variant not found in GlobalISel results")
                continue
            
            if operation not in selectiondag_results or variant not in selectiondag_results[operation]:
                logger.log(f" ✗ Operation/variant not found in SelectionDAG results")
                continue
            
            # Get O0 instructions from LLVM compilers
            globalisel_o0 = globalisel_results[operation][variant].get('O0', [])
            selectiondag_o0 = selectiondag_results[operation][variant].get('O0', [])
            
            if not globalisel_o0:
                logger.log(f"  ✗  O0 results not found for GlobalISel")
            if not selectiondag_o0:
                logger.log(f"  ✗  O0 results not found for SelectionDAG")
            
            # Compare LEAN vs GlobalISel O0
            if globalisel_o0:
                if lean_insts == globalisel_o0:
                    logger.log(f"  ✓ LEANMLIR matches GlobalISel-O0")
                else:
                    logger.log(f"\n  ✗ LEANMLIR DIFFERS from GlobalISel-O0")
                    log_instruction_diff(
                        logger,
                        [lean_insts, globalisel_o0],
                        ["LEANMLIR", "GlobalISel-O0"]
                    )
            
            # Compare LEAN vs SelectionDAG O0
            if selectiondag_o0:
                if lean_insts == selectiondag_o0:
                    logger.log(f"  ✓ LEANMLIR matches SelectionDAG-O0")
                else:
                    logger.log(f"\n  ✗ LEANMLIR DIFFERS from SelectionDAG-O0")
                    log_instruction_diff(
                        logger,
                        [lean_insts, selectiondag_o0],
                        ["LEANMLIR", "SelectionDAG-O0"]
                    )
            
            # Compare all three at once for a comprehensive view
            if globalisel_o0 and selectiondag_o0:
                all_same = lean_insts == globalisel_o0 == selectiondag_o0
                if all_same:
                    logger.log(f"\n  ✓ All three produce IDENTICAL instructions (LEANMLIR, GlobalISel-O0, SelectionDAG-O0)")
                else:
                    logger.log(f"\n  Comprehensive comparison of all three:")
                    log_instruction_diff(
                        logger,
                        [lean_insts, globalisel_o0, selectiondag_o0],
                        ["LEANMLIR", "GlobalISel-O0", "SelectionDAG-O0"]
                    )
    
    logger.log("\n" + "=" * 100)
    logger.log("COMPARISON 3: LEANMLIR_opt vs LLVM at O2")
    logger.log("=" * 100 + "\n")
    
    # Get all operations that exist in LEANMLIR_opt
    for operation in sorted(leanmlir_opt_results.keys()):
        for variant in sorted(leanmlir_opt_results[operation].keys()):
            logger.log(f"\n{'─' * 100}")
            logger.log(f"Operation: llvm.{operation}, Variant: {variant}")
            logger.log(f"{'─' * 100}")
            
            lean_opt_insts = leanmlir_opt_results[operation][variant]
            
            # Check if this operation/variant exists in LLVM results
            if operation not in globalisel_results or variant not in globalisel_results[operation]:
                logger.log(f"  ✗  Operation/variant not found in GlobalISel results")
                continue
            
            if operation not in selectiondag_results or variant not in selectiondag_results[operation]:
                logger.log(f"  ✗  Operation/variant not found in SelectionDAG results")
                continue
            
            # Get O2 instructions from LLVM compilers
            globalisel_o2 = globalisel_results[operation][variant].get('O2', [])
            selectiondag_o2 = selectiondag_results[operation][variant].get('O2', [])
            
            if not globalisel_o2:
                logger.log(f"  ✗  O2 results not found for GlobalISel")
            if not selectiondag_o2:
                logger.log(f"  ✗  O2 results not found for SelectionDAG")
            
            # Compare LEAN_opt vs GlobalISel O2
            if globalisel_o2:
                if lean_opt_insts == globalisel_o2:
                    logger.log(f"  ✓ LEANMLIR_opt matches GlobalISel-O2")
                else:
                    logger.log(f"\n  ✗ LEANMLIR_opt DIFFERS from GlobalISel-O2")
                    log_instruction_diff(
                        logger,
                        [lean_opt_insts, globalisel_o2],
                        ["LEANMLIR_opt", "GlobalISel-O2"]
                    )
            
            # Compare LEAN_opt vs SelectionDAG O2
            if selectiondag_o2:
                if lean_opt_insts == selectiondag_o2:
                    logger.log(f"  ✓ LEANMLIR_opt matches SelectionDAG-O2")
                else:
                    logger.log(f"\n  ✗ LEANMLIR_opt DIFFERS from SelectionDAG-O2")
                    log_instruction_diff(
                        logger,
                        [lean_opt_insts, selectiondag_o2],
                        ["LEANMLIR_opt", "SelectionDAG-O2"]
                    )
            
            # Compare all three at once for a comprehensive view
            if globalisel_o2 and selectiondag_o2:
                all_same = lean_opt_insts == globalisel_o2 == selectiondag_o2
                if all_same:
                    logger.log(f"\n  ✓ All three produce IDENTICAL instructions (LEANMLIR_opt, GlobalISel-O2, SelectionDAG-O2)")
                else:
                    logger.log(f"\n  Comprehensive comparison of all three:")
                    log_instruction_diff(
                        logger,
                        [lean_opt_insts, globalisel_o2, selectiondag_o2],
                        ["LEANMLIR_opt", "GlobalISel-O2", "SelectionDAG-O2"]
                    )


def main():
    log_file = os.path.join(LOGS_DIR, f"comparison.log")
    
    # Collect results from all compilers
    print(f"Collecting results... (log will be saved to {log_file})")
    
    globalisel_results = collect_results_llvm(MCA_LLVM_globalisel_DIR)
    selectiondag_results = collect_results_llvm(MCA_LLVM_selectiondag_DIR)
    leanmlir_results = collect_results_lean(MCA_LEANMLIR_DIR)
    leanmlir_opt_results = collect_results_lean(MCA_LEANMLIR_opt_DIR)
    
    # Use logger context manager
    with Logger(log_file) as logger:        
        # Compare LLVM compilers
        compare_llvm_compilers(logger, globalisel_results, selectiondag_results)
        
        # Compare LEAN vs LLVM
        compare_lean_vs_llvm(logger, leanmlir_results, leanmlir_opt_results, 
                            globalisel_results, selectiondag_results)
        
        logger.log("\n" + "=" * 100)
        logger.log("END OF ALL COMPARISONS")
        logger.log("=" * 100 + "\n")
    
    print(f"\nLog file saved to: {log_file}")
    
if __name__ == "__main__":
    main()