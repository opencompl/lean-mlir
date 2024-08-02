#!/usr/bin/env python3

from analyze import analyze_files # , Tactics
import glob
def main():
    files = glob.glob("SSA/Projects/InstCombine/tests/LLVM/*_proof.lean")
    files.remove("SSA/Projects/InstCombine/tests/LLVM/gshifthlogic_proof.lean")
    files.remove("SSA/Projects/InstCombine/tests/LLVM/g2010h11h01hlshrhmask_proof.lean")
    files.remove("SSA/Projects/InstCombine/tests/LLVM/gcanonicalizehshlhlshrhtohmasking_proof.lean")
    files.remove("SSA/Projects/InstCombine/tests/LLVM/gorhshiftedhmasks_proof.lean")
    print(files)
    analyze_files(
        file_paths = files, #["SSA/Projects/InstCombine/HackersDelight.lean"],
        tactics = [ "data_bitwise", "data_ring", "data_automata"], # Tactics.automata
        summary_file = "summary.xlsx",
        output_file = "output.xlsx",
    )

if __name__ == "__main__":
    main()
