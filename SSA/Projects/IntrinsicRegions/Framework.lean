/-
We develop the core theory of unstructured control flow that is intrinsically well-typed.
The key insight to intrinsically well-type a CFG is to realize that a CFG is inductively well-typed
when performing induction on the *dominator tree*.

See: https://tekne.dev/blog/building-inductive-ssa

Authors: Jad Ghaliyani, Siddharth Bhat
-/
import Init.Data.BitVec.Basic
import Init.Data.BitVec.Lemmas
import Init.Data.BitVec.Bitblast

-- 1) RegionTree in Polly, from our work in Polly:
-- 2) https://github.com/llvm/llvm-project/blob/7b08c2774ca7350b372f70f63135eacc04d739c5/llvm/include/llvm/Analysis/RegionInfo.h#L9-L22
--      Which is, in turn, based on the program structure Tree: https://en.wikipedia.org/wiki/Program_structure_tree
-- 3) LLVM's functional API for BB utils,
--     which we shall provide as a surface level API https://llvm.org/doxygen/BasicBlockUtils_8h.html
-- import SSA.Core.Framework
import Lean.Data.HashMap
import Mathlib.CategoryTheory.Category.Basic

import SSA.Core.ErasedContext
import SSA.Core.HVector
import SSA.Core.EffectKind
import Mathlib.Control.Monad.Basic
import SSA.Core.Framework.Dialect
import Mathlib.Data.List.AList
import Mathlib.Data.Finset.Piecewise

open Ctxt (Var VarSet Valuation)
open TyDenote (toType)
open Ctxt.CoValuation (appendEquiv)

namespace Pure

class InstSet (φ : Type u) (α : outParam (Type v)) where
  arity : φ → ℕ
  arg : (f : φ) → Fin (arity f) → α
  trg : φ → α

-- TODO: generalize universe level here...
class InstDenote (φ : Type u) (α : outParam (Type)) [Φ : InstSet φ α] [TyDenote α] where
  evaluate : φ → (∀i : Fin (Φ.arity f), ⟦Φ.arg f i⟧) → ⟦Φ.trg f⟧

variable
  [TyDenote Ty] [InstSet Op Ty] [FD : InstDenote Op Ty]
  [C : TyHasCoprod Ty] [CD : TyHasCoprodDenote Ty]
  [P : TyHasProd Ty] [PD : TyHasProdDenote Ty]

-- TODO: using HVector here will create a mutual induction, which will create suffering.

/-- A simple term, consisting of variables, operations, products, and coproducts -/
inductive Term (Op) [Φ : InstSet Op Ty] : (Γ : Ctxt Ty) → Ty → Type _ where
  | var : {α : Ty} → (v : Γ.Var α) → Term Op Γ α
  | val : {α : Ty} → (v : toType α) → Term Op Γ α
  | op : Op → (∀i : Fin (Φ.arity f), Term Op Γ (Φ.arg f i)) → Term Op Γ (Φ.trg f)
  | let₁ : Term Op Γ α → Term Op (Γ.snoc α) β → Term Op Γ β
  | prod : (∀i : Fin arity, Term Op Γ (α i)) → Term Op Γ (P.prod α)
  | inj : (i : Fin arity) → Term Op Γ (α i) → Term Op Γ (C.coprod α)
  | letₙ {α : Fin arity → Ty}
    : Term Op Γ (P.prod α) → Term Op Δ β → Ctxt.Hom Δ (Ctxt.ofFn α ++ Γ) → Term Op Γ β
  | case {α : Fin arity → Ty}
    : Term Op Γ (C.coprod α) → (∀i : Fin arity, Term Op (Γ.snoc (α i)) β) → Term Op Γ β

  -- Extension possibility: replace Term.evaluate with a mutual inductive, allow Op to take region
  -- parameters; then we support arbitrary MLIR dialects w/ control flow + coproducts

/-- Evaluate a term -/
def Term.evaluate {Γ : Ctxt Ty} {ty : Ty} (t : Term Op Γ ty) (VΓ : Ctxt.Valuation Γ)
  : ⟦ty⟧ := match t with
  | var v => VΓ v
  | val v => v
  | op f as => FD.evaluate f (λi => (as i).evaluate VΓ)
  | let₁ a t => t.evaluate (Ctxt.Valuation.snoc VΓ (a.evaluate VΓ))
  | prod as => PD.pack (λi => (as i).evaluate VΓ)
  | inj i a => CD.inj i (a.evaluate VΓ)
  | letₙ a e h => e.evaluate (Ctxt.Valuation.comap (Ctxt.Valuation.appendEquiv.symm ⟨
    Ctxt.Valuation.ofFn (a.evaluate VΓ),
    VΓ⟩) h)
  | case a bs => CD.elim (λi a => (bs i).evaluate (VΓ.snoc a)) (a.evaluate VΓ)

/-- A region supporting arbitrary control-flow -/
inductive Region (Op) [InstSet Op Ty] [C : TyHasCoprod Ty] : (Γ : Ctxt Ty) → (L : Ctxt Ty) → Type
| br (a : Term Op Γ α) (hl : L.Var α) : Region Op Γ L
| case {α : Fin arity → Ty}
  (a : Term Op Γ (C.coprod α)) (bs : ∀i : Fin arity, Region Op (Γ.snoc (α i)) L)
   : Region Op Γ L
| let₁ (a : Term Op Γ α) (t : Region Op (Γ.snoc α) L) : Region Op Γ L
| letₙ {α : Fin arity → Ty}
  : Term Op Γ (P.prod α) → Region Op Δ β → Ctxt.Hom Δ (Ctxt.ofFn α ++ Γ) → Region Op Γ β
| cfg {Γ R L D : Ctxt Ty}
    (inL : Ctxt.Hom D (R ++ L))
    (t : Region Op Γ D) -- t for terminator, G for fixpoint graph.
    (G : ∀{α}, R.Var α → Region Op (Γ.snoc α) D)
   : Region Op Γ L

inductive Region.Evaluated  :
    (Γ : Ctxt Ty) → (VΓ : Ctxt.Valuation Γ)
    → (L : Ctxt Ty) → (R : Region Op Γ L) → (VL' : Ctxt.CoValuation L) → Prop
| br :  Evaluated Γ VL L (Region.br a hl) (Ctxt.CoValuation.ofVar hl (a.evaluate VΓ))
| case_inj
  {α : Fin arity → Ty} {a : Term Op Γ (C.coprod α)}
  {bs : ∀i : Fin arity, Region Op (Γ.snoc (α i)) L}
  {l : ⟦α i⟧}
  : (ha : a.evaluate VΓ = CD.inj i l)
  → Evaluated (Ctxt.snoc Γ (α i)) (Ctxt.Valuation.snoc VΓ l) L (bs i) VL
  → Evaluated Γ VΓ L (Region.case a bs) VL
| let₁
  : Evaluated (Ctxt.snoc Γ α) (Ctxt.Valuation.snoc VΓ (a.evaluate VΓ)) L t VL
  → Evaluated Γ VΓ L (let₁ a t) VL
| letₙ
  {a : Term Op Γ (P.prod α)} {e : Region Op Δ β} {h : Ctxt.Hom Δ (Ctxt.ofFn α ++ Γ)}
  : (hVΔ : (Ctxt.Valuation.appendEquiv.symm ⟨Ctxt.Valuation.ofFn (a.evaluate VΓ), VΓ⟩).comap h = VΔ)
  → Evaluated Δ VΔ L t VL
  → Evaluated Γ VΓ L (letₙ a t h) VL
| cfg_sibling {inL : Ctxt.Hom D (R ++ L)}
  : Evaluated Γ VΓ D t VL
  → (hVL : appendEquiv (VL.comap inL) = Sum.inr S)
  → Evaluated Γ VΓ L (cfg inL t G) S
| cfg_child {Γ : Ctxt Ty} {VΓ : Γ.Valuation} {L R D : Ctxt Ty}
  {VL : L.CoValuation} {VD : D.CoValuation} {inL : Ctxt.Hom D (R ++ L)}
  {C : Ctxt.CoValuation R}
  {t : Region Op Γ D}
  {G : ∀ {α}, R.Var α → Region Op (Γ.snoc α) D}
  : Evaluated Γ VΓ D t VD
  → (hVL : appendEquiv (VD.comap inL) = Sum.inl (α := R.CoValuation) (β := L.CoValuation) C)
  → Evaluated Γ VΓ L (cfg inL (let₁ (Term.val C.val) (G C.var)) G) VL
  → Evaluated Γ VΓ L (cfg (Γ := Γ) (R := R) (L := L) (D := D) inL t G) VL
