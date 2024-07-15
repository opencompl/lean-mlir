
import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM



open Std (BitVec)
theorem low_mask_nsw_nuw_thm (x : _root_.BitVec 32) : 63#32 + (x &&& 31#32) * 4294967295#32 = x &&& 31#32 ^^^ 63#32 := sorry

theorem xor_add_thm (x : _root_.BitVec 32) :
  (x &&& 31#32 ^^^ 31#32) + 42#32 = 73#32 + (x &&& 31#32) * 4294967295#32 := sorry

