import SSA.Projects.InstCombine.ForLean

import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM



theorem test0_thm (x : _root_.BitVec 32) :
  x + (x &&& 1431655765#32 ^^^ 4294967295#32) + 1#32 = x &&& 2863311530#32 := by
  sorry

theorem test1_thm (x : _root_.BitVec 32) :
  x + (x.sshiftRight 1 &&& 1431655765#32 ^^^ 4294967295#32) + 1#32 =
    x + (x >>> 1 &&& 1431655765#32) * 4294967295#32 := by
  sorry

