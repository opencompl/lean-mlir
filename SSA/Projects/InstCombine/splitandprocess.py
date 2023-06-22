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
    f.write("".join(proof))

    f.close()
    
    import subprocess
    x = subprocess.run("(cd ../../../; lake build SSA.Projects.InstCombine.InstCombineAliveTest)", shell=True)
    return x.returncode == 0

def filterProofs(preamble, proofs):

    workingProofs = []
    for proof in proofs:
        if not isWorkingProof(preamble, proof):
            continue

        workingProofs.append(proof)

    return workingProofs

def writeOutput(preamble, proofs):
    f = open("InstCombineAliveOnlyCorrect.lean", "w")

    f.write("".join(preamble))
    for proof in proofs:
        f.write("".join(proof))

f = open("InstCombineAlive.lean", "r")
lines = f.readlines()
preamble, proofs = getProofs(lines)
working_proofs = filterProofs(preamble, proofs)

writeOutput(preamble, working_proofs)
