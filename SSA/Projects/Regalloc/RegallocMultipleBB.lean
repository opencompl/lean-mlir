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
import Mathlib.Init.Function
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

namespace Pure

variable [TyDenote Ty]

/-- A simple term, consisting of variables, operations, pairs, units, and booleans -/
inductive Term (Γ : Ctxt Ty) : Ty → Type where
  | var : {α : Ty} → (v : Γ.Var α) → Term Γ α
  | val : {α : Ty} → (v : toType α) → Term Γ α
  -- | op : φ → Term φ → Term φ
  -- | let1 : Term φ → Term φ → Term φ
  -- | pair : Term φ → Term φ → Term φ
  -- | unit : Term φ
  -- | let2 : Term φ → Term φ → Term φ
  -- | inl : Term φ → Term φ
  -- | inr : Term φ → Term φ
  -- | case: Term φ → Term φ → Term φ → Term φ
  -- | abort : Term φ → Term φ

-- inductive Wf : Ctx α ε → Region φ → LCtx α → Prop
--   | br : L.Trg n A → a.Wf Γ ⟨A, ⊥⟩ → Wf Γ (br n a) L
--   | case : a.Wf Γ ⟨Ty.coprod A B, e⟩
--     → s.Wf (⟨A, ⊥⟩::Γ) L
--     → t.Wf (⟨B, ⊥⟩::Γ) L
--     → Wf Γ (case a s t) L
--   | let1 : a.Wf Γ ⟨A, e⟩ → t.Wf (⟨A, ⊥⟩::Γ) L → (let1 a t).Wf Γ L
--   | let2 : a.Wf Γ ⟨(Ty.prod A B), e⟩ → t.Wf (⟨B, ⊥⟩::⟨A, ⊥⟩::Γ) L → (let2 a t).Wf Γ L
--   | cfg (n) {G} (R : LCtx α) :
--     (hR : R.length = n) → β.Wf Γ (R ++ L) →
--     (∀i : Fin n, (G i).Wf (⟨R.get (i.cast hR.symm), ⊥⟩::Γ) (R ++ L)) →
--     Wf Γ (cfg β n G) L

def Term.evaluate [TyDenote Ty] {Γ : Ctxt Ty} {ty : Ty} (t : Term Γ ty) (VΓ : Ctxt.Valuation Γ) : toType ty :=
  match t with
  | var v => VΓ v
  | val v => v

-- def InS.br {Γ : Ctx α ε} {L : LCtx α} (ℓ) (a : Term.InS φ Γ ⟨A, ⊥⟩)
--   (hℓ : L.Trg ℓ A) : InS φ Γ L
--   := ⟨Region.br ℓ a, Wf.br hℓ a.2⟩


-- | TODO: add a thingie that coerces case into `Bool`.
-- def InS.case {Γ : Ctx α ε} {L : LCtx α} {A B e}
--  (a : Term.InS φ Γ ⟨Ty.coprod A B, e⟩) (s : InS φ (⟨A, ⊥⟩::Γ) L) (t : InS φ (⟨B, ⊥⟩::Γ) L) : InS φ Γ L

class TyHasCoprod (Ty : Type) where
  coprod : Ty → Ty → Ty

class TyHasCoprodDenote (Ty : Type) [TyDenote Ty] [C : TyHasCoprod Ty] where
  inl : toType α →  toType (C.coprod α β)
  inr : toType α →  toType (C.coprod α β)
  elim : (toType α → γ) → (toType β → γ) → toType (C.coprod α β) → γ

/- TODO: implement a thing `left? : toType (C.coprod α β) → Option (toType α)` using `elim`.
This will allow us to cleanup case_inl by writing `(ha : (l : toType  α) ∈ a.evaluate VΓ |>.left?)`-/
/-
TODO: add lawful instance of TyHasCoprodDenote for proving properties about the universal property.
-/

instance : Append (Ctxt Ty) where
  append Γ Δ := Γ.append Δ

inductive Region [C : TyHasCoprod Ty] : (Γ : Ctxt Ty) → (L : Ctxt Ty) → Type
| br (a : Term Γ α) (hl : L.Var α) : Region Γ L
| case (a : Term Γ (C.coprod α β)) (s : Region (Γ.snoc α) L) (t : Region (Γ.snoc β) L) : Region Γ L
| let₁ (a : Term Γ α) (t : Region (Γ.snoc α) L) : Region Γ L
-- | cfg {R L D : Ctxt Ty}
--     (hD : D = R ++ L)
--     (t : Region Γ D) -- t for terminator, G for fixpoint graph.
--     (G : R.Var α → Region (Γ.snoc α) D)
--    : Region Γ L
| cfg {R L D : Ctxt Ty}
    -- (hD : D = R ++ L)
    (inL : Ctxt.Hom D (R ++ L))
    (t : Region Γ D) -- t for terminator, G for fixpoint graph.
    (G : R.Var α → Region (Γ.snoc α) D)
   : Region Γ L

def _root_.Ctxt.CoValuation.ofAppend {R L : Ctxt Ty} (VRL : Ctxt.CoValuation (R ++ L)) : (Ctxt.CoValuation R)⊕(Ctxt.CoValuation L) :=
  sorry

/- Show that CoVal (R++L) splits as (Either (CoVal R) (CoVal L))-/
/--
Bigstep operational semantics for evaluation of a control flow graph.
-/
inductive Region.Evaluated [C : TyHasCoprod Ty] [TyDenote Ty] [CD : TyHasCoprodDenote Ty]  :
    (Γ : Ctxt Ty) → (VΓ : Ctxt.Valuation Γ) → (L : Ctxt Ty) → (R : Region Γ L) → (VL' : Ctxt.CoValuation L) → Prop
| br :  Evaluated Γ VL L (Region.br a hl) (Ctxt.CoValuation.ofVar hl (a.evaluate VΓ))
| case_inl : (ha : a.evaluate VΓ = CD.inl (α := α) l)
  → Evaluated (Ctxt.snoc Γ α) (Ctxt.Valuation.snoc VΓ l) L t VL
  → Evaluated Γ VΓ L (Region.case a s t) VL
| case_inr : (ha : a.evaluate VΓ = CD.inr (β := β) r)
  → Evaluated (Ctxt.snoc Γ β) (Ctxt.Valuation.snoc VΓ r) L t VL
  → Evaluated Γ VΓ L (Region.case a s t) VL
| let₁
  : Evaluated (Ctxt.snoc Γ α) (Ctxt.Valuation.snoc VΓ (a.evaluate VΓ)) L t VL
  → Evaluated Γ VΓ L (let₁ a t) VL
| cfg_sibling {inL : Ctxt.Hom D (R ++ L)}
  : Evaluated Γ VΓ D t VL
  → (hVL : (VL.comap inL).ofAppend = Sum.inr S)
  → Evaluated Γ VΓ L (cfg inL t G) S
| cfg_child {Γ : Ctxt Ty} {VΓ : Γ.Valuation} {L : Ctxt Ty }
  {VL : L.CoValuation} {VD : D.CoValuation} {inL : Ctxt.Hom D (R ++ L)}
  {C : Ctxt.CoValuation R}
  {t : Region Γ D}
  {G : ∀ {α}, R.Var α → Region (Γ.snoc α) D}
  : Evaluated Γ VΓ D t VD
  -- → (hVL : (VD.comap inL).ofAppend = Sum.inl C)
  -- → Evaluated Γ VΓ L (cfg inL (let₁ (Term.val C.val) (G C.var)) G) VL
  → Evaluated Γ VΓ L (cfg inL t G) VL

end Pure
