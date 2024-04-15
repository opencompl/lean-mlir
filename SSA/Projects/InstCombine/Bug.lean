
import SSA.Projects.InstCombine.LLVM.EDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
import SSA.Projects.InstCombine.ComWrappers

open MLIR AST
open Std (BitVec)
open Ctxt (Var)
open ComWrappers

set_option pp.proofs true
set_option pp.proofs.withType true
set_option linter.deprecated false

def src_i1 (w : Nat) :=
[alive_icom| {
^bb0(%a : i1):
  "llvm.return" (%a) : (i1) -> ()
}]

def src  (w : Nat)   :=
[alive_icom ( w )| {
^bb0(%a : _):
  "llvm.return" (%a) : (_) -> ()
}]

def tgt  (w : Nat)  :=
[alive_icom ( w )| {
^bb0(%a : _):
  %v1 = "llvm.mul" (%a,%a) : (_, _) -> (_)
  "llvm.return" (%v1) : (_) -> ()
}]

def src_cw (w : Nat) :
  Com InstCombine.Op [InstCombine.Ty.bitvec 1] (InstCombine.Ty.bitvec 1) :=
  .ret ⟨0, by simp [Ctxt.snoc]⟩

def src_i1_cw (w : Nat) :
  Com InstCombine.Op [InstCombine.Ty.bitvec w] (InstCombine.Ty.bitvec w) :=
  .ret ⟨0, by simp [Ctxt.snoc]⟩

def tgt_cw (w : Nat) :
  Com InstCombine.Op [InstCombine.Ty.bitvec w] (InstCombine.Ty.bitvec w) :=
  .lete (ComWrappers.mul w 0 0) <|
  .ret ⟨1, by simp [Ctxt.snoc]⟩

def src_cw_hidden (w : Nat) := src_cw w
def src_i1_cw_hidden (w : Nat) := src_cw w

#check src_cw 1
#check src_i1_cw 1
#check src 1
#check src_i1 1
#check tgt 1

theorem ss : src_i1 1 = src 1 := rfl
theorem sss : src_cw 1 = src 1 := rfl
theorem ssss : src_i1_cw 1 = src 1 := rfl

open Ctxt

/-- This one does not have the 'snoc' leftover. -/
theorem okkk : src_cw_hidden 1  ⊑ tgt 1  := by
  unfold tgt

  dsimp only [Com.Refinement]
  intros Γv
  change_mlir_context Γv

  simp (config := {failIfUnchanged := false}) only [Com.denote]
  simp (config := {failIfUnchanged := false}) only [Expr.denote]
  simp (config := {failIfUnchanged := false}) only [HVector.denote]
  simp (config := {failIfUnchanged := false}) only [HVector.map]
  simp (config := {failIfUnchanged := false}) only [List.map_eq_map]
  simp (config := {failIfUnchanged := false}) only [Var.zero_eq_last]
  rw [Valuation.snoc_last]
  sorry


/-- This one does not have the 'snoc' leftover. -/
theorem okk : src_i1_cw_hidden 1  ⊑ tgt 1  := by
  unfold tgt
  dsimp only [Com.Refinement]
  intros Γv
  change_mlir_context Γv

  simp (config := {failIfUnchanged := false}) only [Com.denote]
  simp (config := {failIfUnchanged := false}) only [Expr.denote]
  simp (config := {failIfUnchanged := false}) only [HVector.denote]
  simp (config := {failIfUnchanged := false}) only [HVector.map]
  simp (config := {failIfUnchanged := false}) only [List.map_eq_map]
  simp (config := {failIfUnchanged := false}) only [Var.zero_eq_last]
  rw [Valuation.snoc_last]
  sorry

/-- This one does not have the 'snoc' leftover. -/
theorem ok : src 1  ⊑ tgt 1  := by
  unfold tgt
  dsimp only [Com.Refinement]
  intros Γv
  change_mlir_context Γv

  simp (config := {failIfUnchanged := false}) only [Com.denote]
  simp (config := {failIfUnchanged := false}) only [Expr.denote]
  simp (config := {failIfUnchanged := false}) only [HVector.denote]
  simp (config := {failIfUnchanged := false}) only [HVector.map]
  simp (config := {failIfUnchanged := false}) only [List.map_eq_map]
  simp (config := {failIfUnchanged := false}) only [Var.zero_eq_last]
  rw [Valuation.snoc_last]
  sorry

/-- This one has the 'snoc' leftover. -/
theorem broken : src_i1 1 ⊑ tgt 1  := by
  unfold tgt
  -- Γv✝ : Ctxt.Valuation [InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)]
  -- ∀ (e : Option (_root_.BitVec 1)),
  -- Com.denote (src_i1 1) Γv✝ ⊑ Ctxt.Valuation.snoc Γv✝ (LLVM.mul e e) { val := 0, property := ⋯ }
  dsimp only [Com.Refinement]
  intros Γv
  change_mlir_context Γv

  simp (config := {failIfUnchanged := false}) only [Com.denote]
  simp (config := {failIfUnchanged := false}) only [Expr.denote]
  simp (config := {failIfUnchanged := false}) only [HVector.denote]
  simp (config := {failIfUnchanged := false}) only [HVector.map]
  simp (config := {failIfUnchanged := false}) only [List.map_eq_map]
  simp (config := {failIfUnchanged := false}) only [Var.zero_eq_last]
  rw [Valuation.snoc_last] -- <= This one does not fire!
  sorry
