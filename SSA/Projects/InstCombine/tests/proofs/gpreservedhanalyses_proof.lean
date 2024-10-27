
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gpreservedhanalyses_proof
theorem test_thm (x : BitVec 32) : x + 5#32 + 4294967291#32 = x := by bv_compare'

