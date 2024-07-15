
import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM



open Std (BitVec)

theorem addhshlhsdivhscalar0_thm (x : _root_.BitVec 8) : x.sdiv 252#8 <<< 2 + x = x + x.sdiv 4#8 * 252#8 := sorry

theorem addhshlhsdivhscalar1_thm (x : _root_.BitVec 8) : x.sdiv 192#8 <<< 6 + x = x + x.sdiv 64#8 * 192#8 := sorry

theorem addhshlhsdivhscalar2_thm (x : _root_.BitVec 32) :
  x.sdiv 3221225472#32 <<< 30 + x = x + x.sdiv 1073741824#32 * 3221225472#32 := sorry

theorem addhshlhsdivhnegative1_thm (x : _root_.BitVec 32) :
  (Option.bind (if x = LLVM.intMin 32 then none else some (x.sdiv 4294967295#32)) fun a => some (a <<< 1 + x)) ⊑
    some (x * 4294967295#32) := sorry
