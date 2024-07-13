
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import Batteries.Data.BitVec

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)
theorem shl_shl_thm (x : _root_.BitVec 32) : x <<< 34 = 0#32 := sorry

theorem shl_lshr_demand1_thm (x : _root_.BitVec 8) :
  (Option.bind (if 8 ≤ x.toNat then none else some (40#8 <<< x)) fun a => some (a >>> 3 ||| 224#8)) ⊑
    Option.bind (if 8 ≤ x.toNat then none else some (5#8 <<< x)) fun a => some (a ||| 224#8) := sorry

theorem shl_lshr_demand6_thm (x : _root_.BitVec 16) :
  (Option.bind (if 16 ≤ x.toNat then none else some (32912#16 <<< x)) fun a => some (a >>> 4 &&& 4094#16)) ⊑
    Option.bind (if 16 ≤ x.toNat then none else some (2057#16 <<< x)) fun a => some (a &&& 4094#16) := sorry

theorem lshr_shl_demand1_thm (x : _root_.BitVec 8) :
  (Option.bind (if 8 ≤ x.toNat then none else some (28#8 >>> x)) fun a => some (a <<< 3 ||| 7#8)) ⊑
    Option.bind (if 8 ≤ x.toNat then none else some (224#8 >>> x)) fun a => some (a ||| 7#8) := sorry

