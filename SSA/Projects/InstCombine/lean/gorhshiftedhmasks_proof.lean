
import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM



open Std (BitVec)
theorem or_and_shifts1_thm (x : _root_.BitVec 32) :
  x <<< 3 &&& 15#32 ||| x <<< 5 &&& 60#32 = x <<< 3 &&& 8#32 ||| x <<< 5 &&& 32#32 := sorry

theorem or_and_shift_shift_and_thm (x : _root_.BitVec 32) :
  (x &&& 7#32) <<< 3 ||| x <<< 2 &&& 28#32 = x <<< 3 &&& 56#32 ||| x <<< 2 &&& 28#32 := sorry

theorem multiuse1_thm (x : _root_.BitVec 32) :
  (x &&& 2#32) >>> 1 ||| (x &&& 4#32) >>> 1 ||| ((x &&& 2#32) <<< 6 ||| (x &&& 4#32) <<< 6) =
    x >>> 1 &&& 1#32 ||| x >>> 1 &&& 2#32 ||| x <<< 6 &&& 384#32 := sorry

theorem multiuse2_thm (x : _root_.BitVec 32) :
  (x &&& 96#32) <<< 8 ||| ((x &&& 6#32) <<< 8 ||| (x &&& 24#32) <<< 8) |||
      ((x &&& 6#32) <<< 1 ||| ((x &&& 96#32) <<< 1 ||| (x &&& 24#32) <<< 1)) =
    x <<< 8 &&& 32256#32 ||| (x <<< 1 &&& 12#32 ||| (x <<< 1 &&& 192#32 ||| x <<< 1 &&& 48#32)) := sorry

theorem multiuse3_thm (x : _root_.BitVec 32) :
  (x &&& 96#32) >>> 1 ||| x >>> 1 &&& 15#32 ||| ((x &&& 96#32) <<< 6 ||| x <<< 6 &&& 1920#32) =
    x >>> 1 &&& 48#32 ||| x >>> 1 &&& 15#32 ||| x <<< 6 &&& 8064#32 := sorry

