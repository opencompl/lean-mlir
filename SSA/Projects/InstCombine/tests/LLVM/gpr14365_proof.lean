
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gpr14365_proof
theorem test0_thm (x : BitVec 32) :
  x + ((x &&& 1431655765#32 ^^^ 4294967295#32) + 1#32) = x &&& 2863311530#32 := sorry

theorem test1_thm (x : BitVec 32) :
  x + ((x.sshiftRight 1 &&& 1431655765#32 ^^^ 4294967295#32) + 1#32) = x - (x >>> 1 &&& 1431655765#32) := sorry

