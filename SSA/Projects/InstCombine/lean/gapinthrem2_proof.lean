
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import Batteries.Data.BitVec

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)
theorem test1_thm (x : _root_.BitVec 333) :
  BitVec.ofNat 333 (x.toNat % 70368744177664) = x &&& 70368744177663#333 := sorry

theorem test2_thm :
  ∀ (x : _root_.BitVec 499),
    (Option.bind (if (111#499).toNat ≥ 499 then none else some (4096#499 <<< 111#499)) fun y' =>
        if y'.toNat = 0 then none else some (BitVec.ofNat 499 (x.toNat % y'.toNat))) ⊑
      some (x.and 10633823966279326983230456482242756607#499) := sorry

