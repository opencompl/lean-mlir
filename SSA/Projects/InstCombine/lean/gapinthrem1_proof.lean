import SSA.Projects.InstCombine.ForLean

import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM



open Std (BitVec)
theorem test1_thm (x : _root_.BitVec 33) : BitVec.ofNat 33 (x.toNat % 4096) = x &&& 4095#33 := sorry

theorem test2_thm (x : _root_.BitVec 49) : BitVec.ofNat 49 (x.toNat % 8388608) = x &&& 8388607#49 := sorry

