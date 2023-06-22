#!/usr/bin/env python3

def getProofs(lines):
    proofs = []
    
    proof = []
    for line in lines:
        if line.startswith("-- Name"):
            proofs.append(proof)
            proof = []
        proof.append(line)
    proofs.append(proof)

    return proofs[0], proofs[1:]

def isWorkingProof(preamble, proof):
    f = open("InstCombineAliveTest.lean", "w")

    f.write("".join(preamble))
    rewritten = []
    for line in proof:
        rewritten.append(line.replace("print_goal_as_error", "sorry"))
    f.write("".join(rewritten))

    f.close()
    
    import subprocess
    x = subprocess.run("(cd ../../../; lake build SSA.Projects.InstCombine.InstCombineAliveTest)", shell=True, capture_output=True)
    return (x.returncode == 0 or x.stderr.decode().find("no goals to be solved") != -1)

def filterProofs(preamble, proofs):

    workingProofs = []
    brokenProofs = []
    for proof in proofs:
        print("processing: " + proof[0])
        if isWorkingProof(preamble, proof):
            workingProofs.append(proof)
        else:
            brokenProofs.append(proof)

    return workingProofs, brokenProofs

def writeOutput(preamble, proofs, filename):
    with open(filename, "w") as f:
        f.write("".join(preamble))
        for proof in proofs:
            f.write("".join(proof))

f = open("InstCombineAliveAll.lean", "r")
lines = f.readlines()
preamble, proofs = getProofs(lines)
working_proofs, broken_proofs = filterProofs(preamble, proofs)
writeOutput(preamble, working_proofs, "InstCombineAlive.lean")
writeOutput(preamble, broken_proofs, "Broken.lean")
