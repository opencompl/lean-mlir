/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.Base
import SSA.Projects.InstCombine.ForStd
import SSA.Core.ErasedContext

open MLIR AST
open Std (BitVec)
open Ctxt (Var DerivedCtxt)
open InstCombine (MOp)

namespace AliveHandwritten


/-
Name: SimplifyDivRemOfSelect
precondition: true
%sel = select %c, %Y, 0
%r = udiv %X, %sel
  =>
%r = udiv %X, %Y

-/
def alive_DivRemOfSelect_src (w : Nat) :=
  [llvm (w)| {
  ^bb0(%c: i1, %y : _, %x : _):
    %c0 = llvm.mlir.constant(0) : _
    %v1 = llvm.select %c, %y, %c0
    %v2 = llvm.udiv %x,  %v1
    llvm.return %v2
  }]
def alive_DivRemOfSelect_tgt (w : Nat) :=
  [llvm (w)| {
  ^bb0(%c: i1, %y : _, %x : _):
    %v1 = llvm.udiv %x, %y
    llvm.return %v1
  }]

@[simp]
theorem BitVec.ofNat_toNat_zero :
BitVec.toNat (BitVec.ofInt w 0) = 0 := by
  simp only [BitVec.toNat, BitVec.ofInt, BitVec.toFin, BitVec.ofNat, OfNat.ofNat]
  norm_cast

theorem alive_DivRemOfSelect (w : Nat) :
    alive_DivRemOfSelect_src w ⊑ alive_DivRemOfSelect_tgt w := by
  unfold alive_DivRemOfSelect_src alive_DivRemOfSelect_tgt
  simp_alive_meta
  simp_alive_ssa
  simp_alive_undef
  simp [simp_llvm]
  intro y c x
  cases c
  -- | select condition is itself `none`, nothing more to be done. propagate the `none`.
  case none => cases x <;> cases y <;> simp
  case some cond =>
     obtain ⟨vcond, hcond⟩ := cond
     obtain (h | h) : vcond = 1 ∨ vcond = 0 := by
       norm_num at hcond
       rcases vcond with zero | vcond <;> simp;
       rcases vcond with zero | vcond <;> simp;
       linarith
     · subst h
       simp
     · subst h; simp

end AliveHandwritten
