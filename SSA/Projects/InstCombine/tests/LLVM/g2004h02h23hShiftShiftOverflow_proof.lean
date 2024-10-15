
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section g2004h02h23hShiftShiftOverflow_proof
theorem test_thm (x : BitVec 32) : (x.sshiftRight 17).sshiftRight 17 = x.sshiftRight 31 := sorry

theorem test2_thm (x : BitVec 32) : x <<< 34 = 0#32 := sorry

