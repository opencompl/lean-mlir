#!/usr/bin/env python3
# Released under Apache 2.0 license as described in the file LICENSE.

import re
import subprocess
from typing import *
from multiprocessing import Pool, TimeoutError
import time
import os

alive_statements_preamble = """
/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.ForStd
import SSA.Projects.InstCombine.ForMathlib
import SSA.Projects.InstCombine.LLVM.Semantics
import Batteries.Data.BitVec
import Mathlib.Data.BitVec.Lemmas

open LLVM
open BitVec
"""


def getProofs(lines: List[str]) -> Tuple[List[str], List[List[str]]]:
    """
    Breaks the file apart into subarrays.
    Each subarray starts with the line `-- Name`.
    This effectively returns a list of sequences of lines, where each sequence of
    lines corresponds to a proof.  Peels the first subarray (the "preamble") out,
    which contains the imports and other setup before the proofs.

    Returns a tuple of the preamble and a list of proofs (each a list of lines).
    """

    proofs = []
    proof = []
    for line in lines:
        if line.startswith("-- Name"):
            proofs.append(proof)
            proof = []
        proof.append(line)
    proofs.append(proof)

    return proofs[0], proofs[1:]


def getStatement(preamble: List[str], id : int, proof: List[str]) -> str:
    """
    Produces the proof state produced by running the `proof`.
    Uses the preamble to create a valid Lean file.
    """

    f = open("AliveTest_" + str(id) + ".lean", "w")

    f.write("".join(preamble))
    rewritten = []
    name = ""
    for line in proof:
        if line.startswith("  apply"):
            rewritten.append("  print_goal_as_error")
            name = line.split(" ")[3][0:-1]
        else:
            rewritten.append(line)
    f.write("".join(rewritten))
    f.close()

    x = subprocess.run(
        "(cd ../../../; lake build SSA.Projects.InstCombine.AliveTest_" + str(id) + ")",
        shell=True,
        capture_output=True,
    )

    name = "\n\ntheorem " + name + " :\n"

    if x.returncode == 0:
        return ""

    error = x.stdout.decode("utf-8")
    msg = re.sub(".*AliveTest_[0-9]+.lean:[0-9]+:[0-9]+-[0-9]+:[0-9]+: ", "", error, flags=re.DOTALL)
    msg = re.sub("\nerror: Lean.*", "", msg, flags=re.DOTALL)
    msg = "    " + re.sub("\n", "\n    ", msg, flags=re.DOTALL)

    stmt = name
    stmt += msg
    stmt += " := by\n  simp_alive_undef\n  simp_alive_ops\n  simp_alive_case_bash\n  try alive_auto\n  try sorry"

    print(stmt)

    return stmt


def filterProofs(preamble: List[str], proofs: List[List[str]]) -> List[str]:
    """
    Returns a list of statements, corresponding to each of the proofs.
    """

    with Pool() as pool:
        async_results = [pool.apply_async(getStatement, args=(preamble, i, proofs[i])) for i in range(len(proofs))]
        statements = [ar.get() for ar in async_results]

    return statements


def writeOutput(preamble, proofs, filename):
    with open(filename, "w") as f:
        f.write("".join(preamble))
        for proof in proofs:
            f.write("".join(proof))


if __name__ == "__main__":
    f = open("AliveAutoGenerated.lean", "r")
    lines = f.readlines()
    preamble, proofs = getProofs(lines)
    statements = filterProofs(preamble, proofs)
    writeOutput(alive_statements_preamble, statements, "AliveStatements.lean")
