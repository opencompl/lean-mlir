
import SSA.Projects.InstCombine.LLVM.EDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
import SSA.Core.Tactic
import SSA.Projects.InstCombine.ComWrappers

open MLIR AST
open Std (BitVec)
open Ctxt (Var)
open ComWrappers

macro "simp_alive_meta" : tactic =>
  `(tactic|
      (
        simp only [InstcombineTransformDialect.MOp.instantiateCom,
                   InstcombineTransformDialect.instantiateMTy,
                   InstcombineTransformDialect.instantiateMOp,
                   Expr.mk,
                   ConcreteOrMVar.instantiate,
                   Vector.get,
                   List.nthLe,
                   List.get,
                   InstCombine.MTy.bitvec,
                   DialectMorphism.mapTy
        ] at *
      )
  )


--set_option pp.proofs true
--set_option pp.proofs.withType true
--set_option pp.all true
--set_option pp.explicit true
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

def src_i1_cw :
  Com InstCombine.Op [InstCombine.Ty.bitvec 1] (InstCombine.Ty.bitvec 1) :=
  .ret ⟨0, by simp [Ctxt.snoc]⟩

def src_cw (w : Nat) :
  Com InstCombine.Op [InstCombine.Ty.bitvec w] (InstCombine.Ty.bitvec w) :=
  .ret ⟨0, by simp [Ctxt.snoc]⟩

def tgt_cw (w : Nat) :
  Com InstCombine.Op [InstCombine.Ty.bitvec w] (InstCombine.Ty.bitvec w) :=
  .lete (ComWrappers.mul w 0 0) <|
  .ret ⟨0, by simp [Ctxt.snoc]⟩

def src_cw_hidden (w : Nat) := src_cw w
def src_i1_cw_hidden (w : Nat) := src_cw w

theorem ss : src_i1 1 = src 1 := rfl
theorem sss : src_cw 1 = src 1 := rfl
theorem ssss : src_i1_cw = src 1 := rfl

theorem tgttt : tgt_cw 1 = tgt 1 := rfl

open Ctxt

/-- This one does not have the 'snoc' leftover. -/
theorem okkk : src_cw 1  ⊑ tgt_cw 1  := by
  unfold tgt_cw
  unfold src_cw
  unfold mul
  simp_alive_ssa
  dsimp only [Com.Refinement]
  intros Γv
  change_mlir_context Γv

  simp (config := {failIfUnchanged := false}) only [Com.denote]
  simp (config := {failIfUnchanged := false}) only [Expr.denote]
  simp (config := {failIfUnchanged := false}) only [HVector.denote]
  simp (config := {failIfUnchanged := false}) only [HVector.map]
  simp (config := {failIfUnchanged := false}) only [List.map_eq_map]
  simp (config := {failIfUnchanged := false}) only [Var.zero_eq_last]
  simp only [Valuation.snoc_last]
  sorry


/-- This one does not have the 'snoc' leftover. -/
theorem okk : src_i1_cw  ⊑ tgt_cw 1  := by
  unfold tgt_cw
  unfold src_i1_cw
  unfold mul

  simp_alive_ssa
  dsimp only [Com.Refinement]
  intros Γv
  change_mlir_context Γv

  simp (config := {failIfUnchanged := false}) only [Com.denote]
  simp (config := {failIfUnchanged := false}) only [Expr.denote]
  simp (config := {failIfUnchanged := false}) only [HVector.denote]
  simp (config := {failIfUnchanged := false}) only [HVector.map]
  simp (config := {failIfUnchanged := false}) only [List.map_eq_map]
  simp (config := {failIfUnchanged := false}) only [Var.zero_eq_last]
  simp only [Valuation.snoc_last]
  sorry

#check Lean.Meta.Simp.Config

-- def instantiateMTy (vals : Vector Nat φ) : (MTy φ) → InstCombine.Ty
--   | .bitvec w => .bitvec <| w.instantiate vals

@[simp]
lemma InstcombineTransformDialect.instantiateMTy_eq (vals : Vector Nat φ) :
    instantiateMTy vals (.bitvec w) = InstCombine.Ty.bitvec (w.instantiate vals) := rfl

@[simp]
lemma ConcreteOrMVar.instantiate_mvar_zero {hφ : List.length (w :: ws) = φ} {h0 : 0 < φ} :
    ConcreteOrMVar.instantiate (Subtype.mk (w :: ws) hφ)  (ConcreteOrMVar.mvar ⟨0, h0⟩) = w := by
  simp [instantiate]
  simp [Vector.get]
  simp [List.nthLe]

set_option pp.proofs.withType true in
@[simp]
lemma ConcreteOrMVar.instantiate_mvar_zero' :
    (ConcreteOrMVar.mvar (φ := 1) ⟨0, by simp⟩).instantiate (Subtype.mk [w] (by simp)) = w := by
  -- simp [instantiate, Vector.head]
  rfl

set_option pp.proofs.withType true in
@[simp]
lemma ConcreteOrMVar.instantiate_mvar_zero'' :
    (ConcreteOrMVar.mvar (φ := 1) 0).instantiate (Subtype.mk [w] h1) = w := by
  rfl

@[simp]
lemma ConcreteOrMVar.instantiate_mvar_succ (hφ : List.length (w :: ws) = φ := by rfl) (hsucci : i+1 < φ := by linarith):
    (ConcreteOrMVar.mvar ⟨i+1, hsucci⟩).instantiate (Subtype.mk (w :: ws) hφ) =
    (ConcreteOrMVar.mvar ⟨i, by sorry⟩).instantiate (Subtype.mk ws (by rfl)) := by rfl

-- Somewhat evil notation for Subtype and Fin, which rewrites them in terms of ⟨..., ...⟩.
--   This is a bit aggressive, since it affects all subtypes, even those outside our project.
--   The upshot is that terms look nice, and retains the identity `elab <=< delab =id`.

/-- This makes Vars look way prettier than { val := 0, property := ... }, but is aggressive... -/
@[app_unexpander Subtype.mk] def unexpandSubtypeMk : Lean.PrettyPrinter.Unexpander
  | `($(_) $val $prop)  => `(⟨$val, $prop⟩)
  | _ => throw ()


-- Note that if we setup elaboration right, this is un-necessary, since the only users for `Fin` are
-- `Width.mvar`, and `HVector.getN`.
-- · `Width.mvar` should be removed during framework time, so the user never sees this in their goal state.
-- · `HVector.getN` should be replaced by `List.get` style notation, which will be elaborated to `HVector.get`.
/-- This makes MVars look way prettier than { val := 0, isLt := ... }, but is aggressive... -/
@[app_unexpander Fin.mk] def unexpandFinMk : Lean.PrettyPrinter.Unexpander
  | `($(_) $val $prop)  => `(⟨$val, $prop⟩)
  | _ => throw ()

theorem DerivedCtxt_snoc_ctxt_eq_ctxt_snoc:
    (DerivedCtxt.snoc Γ ty).ctxt = Ctxt.snoc Γ.ctxt ty := by
  rfl

theorem Ctxt.map_snoc (Γ : Ctxt Ty) : (Γ.snoc a).map f = (Γ.map f).snoc (f a) := by
  rfl

@[app_unexpander Var.last] def unexpandVarLast : Lean.PrettyPrinter.Unexpander
  | `($(f) $_ctxt $ty)  => `($f _ $ty)
  | _ => throw ()

open InstCombine InstcombineTransformDialect MOp ConcreteOrMVar ConcreteOrMVar.Notation BinaryOp in
-- set_option pp.proofs.withType true in
theorem ok : src 1  ⊑ tgt 1  := by
  --unfold tgt
  unfold tgt
  unfold src
  dsimp only [Com.Refinement]
  dsimp only [DerivedCtxt_snoc_ctxt_eq_ctxt_snoc]
  dsimp only [Var.zero_eq_last, List.map] -- @bollu is scared x(
  unfold Width.mvar -- TODO: write theorems in terms of Width.mvar?
  dsimp only [Ctxt.map_snoc, Ctxt.map_nil]
  dsimp only [InstcombineTransformDialect.MOp.instantiateCom,
    InstcombineTransformDialect.instantiateMTy_eq, ConcreteOrMVar.instantiate_mvar_zero']
  -- intros Γv
  simp_alive_peephole
  rename_i x
  /- x ⊑ LLVM.mul x x-/
  sorry

/-- This one has the 'snoc' leftover. -/
theorem broken : src_i1 1 ⊑ tgt 1  := by
  -- ∀ (e : Option (_root_.BitVec 1)),
  -- Com.denote (src_i1 1) Γv✝ ⊑ Ctxt.Valuation.snoc Γv✝ (LLVM.mul e e) { val := 0, property := ⋯ }
  dsimp only [Com.Refinement]
  intros Γv
  change_mlir_context Γv

  unfold tgt
  simp (config := {failIfUnchanged := false}) only [Com.denote]
  simp (config := {failIfUnchanged := false}) only [Expr.denote]
  simp (config := {failIfUnchanged := false}) only [HVector.denote]
  simp (config := {failIfUnchanged := false}) only [HVector.map]
  simp (config := {failIfUnchanged := false}) only [List.map_eq_map]
  simp (config := {failIfUnchanged := false}) only [Var.zero_eq_last]
  simp_alive_meta
  simp [InstcombineTransformDialect.instantiateMTy]
  --set_option trace.Meta.isDefEq true in
  rw [Valuation.snoc_last]
  sorry


def alive_Select_858_src  (w : Nat)   :=
[alive_icom ( w )| {
^bb0(%a : i1, %b : i1):
  %v1 = "llvm.mlir.constant" () { value = -1 : i1 } :() -> (i1)
  %v2 = "llvm.xor" (%a,%v1) : (i1, i1) -> (i1)
  %v3 = "llvm.select" (%a,%v2,%b) : (i1, i1, i1) -> (i1)
  "llvm.return" (%v3) : (i1) -> ()
}]

def alive_Select_858_tgt  (w : Nat)  :=
[alive_icom ( w )| {
^bb0(%a : _, %b : _):
  %v1 = "llvm.mlir.constant" () { value = -1 : _ } :() -> (_)
  %v2 = "llvm.xor" (%a,%v1) : (_, _) -> (_)
  %v3 = "llvm.and" (%v2,%b) : (_, _) -> (_)
  "llvm.return" (%v3) : (_) -> ()
}]
theorem alive_Select_858  (w : Nat)   : alive_Select_858_src w  ⊑ alive_Select_858_tgt 1  := by
  unfold alive_Select_858_src alive_Select_858_tgt
  simp_alive_peephole -- fails to clear the context
  all_goals sorry --apply bitvec_Select_858
