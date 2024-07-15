
import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM



open Std (BitVec)
theorem test1_thm (x x_1 : _root_.BitVec 32) : (x_1 &&& 7#32 ||| x &&& 8#32) &&& 7#32 = x_1 &&& 7#32 := sorry

theorem test3_thm (x x_1 : _root_.BitVec 32) : (x_1 ||| x <<< 1) &&& 1#32 = x_1 &&& 1#32 := sorry

theorem test4_thm (x x_1 : _root_.BitVec 32) : (x_1 ||| x >>> 31) &&& 2#32 = x_1 &&& 2#32 := sorry

theorem or_test2_thm (x : _root_.BitVec 8) : x <<< 7 ||| 128#8 = 128#8 := sorry

