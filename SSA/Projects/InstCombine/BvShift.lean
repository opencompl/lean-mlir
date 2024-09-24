/-
Released under Apache 2.0 license as described in the file LICENSE.
-/

import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.ForLean

@[simp]
theorem shiftRight_and_or_shiftLeft_distrib {x y z : BitVec w} {n : Nat}:
    (x >>> n &&& y ||| z) <<< n = x &&& y <<< n ||| z <<< n := by
  bv_auto

@[simp]
theorem or_shiftRight_and_shiftLeft_distrib {x y z : BitVec w} {n : Nat}:
    (z ||| x >>> n &&& y) <<< n = z <<< n ||| x &&& y <<< n := by
  bv_auto

@[simp]
theorem shiftRight_and_xor_shiftLeft_distrib {x y z : BitVec w} {n : Nat}:
    (x >>> n &&& y ^^^ z) <<< n = x &&& y <<< n ^^^ z <<< n := by
  bv_auto

@[simp]
theorem xor_shiftRight_and_shiftLeft_distrib {x y z : BitVec w} {n : Nat}:
    (z ^^^ x >>> n &&& y) <<< n = z <<< n ^^^ x &&& y <<< n := by
  bv_auto

@[simp]
theorem and_shiftLeft_allOnes {x y : BitVec w} (n : Nat):
  x &&& BitVec.allOnes w <<< n &&& y <<< n = x &&& y <<< n := by
  bv_auto

@[simp]
theorem or_shiftLeft_allOnes {x y : BitVec w} (n : Nat):
  x ||| BitVec.allOnes w <<< n &&& y <<< n = x ||| y <<< n := by
  bv_auto
