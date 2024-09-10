#!/usr/bin/env python3

from analyze import analyze_files # , Tactics
import glob
def main():
    # files = glob.glob("SSA/Projects/InstCombine/tests/LLVM/*_proof.lean")
    # files.remove("SSA/Projects/InstCombine/tests/LLVM/gshifthlogic_proof.lean")
    # files.remove("SSA/Projects/InstCombine/tests/LLVM/g2010h11h01hlshrhmask_proof.lean")
    # files.remove("SSA/Projects/InstCombine/tests/LLVM/gcanonicalizehshlhlshrhtohmasking_proof.lean")
    # files.remove("SSA/Projects/InstCombine/tests/LLVM/gorhshiftedhmasks_proof.lean")
    # print("\n".join(["import " + f.replace("/", ".")[:-5] for f in files]))
    # print(",\n".join(["`" + f.replace("/", ".")[:-5] for f in files]))
    analyze_files(
        file_paths = ["SSA/Projects/DataTactics/simple.lean"],
        tactics = [ "data_bitwise", "data_ring", "data_automata", "data_automata_or_ring"], # Tactics.automata
    )

if __name__ == "__main__":
    main()
