#!/usr/bin/env python3

from analyze import analyze_files # , Tactics
import glob
def main():
    # files = glob.glob("SSA/Projects/InstCombine/tests/LLVM/*_proof.lean")
    # print(files)
    analyze_files(
        file_paths = ["SSA/Projects/InstCombine/HackersDelight.lean"],
        tactics = [ "data_bitwise", "data_ring", "data_automata"], # Tactics.automata
        summary_file = "summary.xlsx",
        output_file = "output.xlsx",
    )

if __name__ == "__main__":
    main()
