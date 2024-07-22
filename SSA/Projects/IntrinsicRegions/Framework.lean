/-
We develop the core theory of unstructured control flow that is intrinsically well-typed.
The key insight to intrinsically well-type a CFG is to realize that a CFG is inductively well-typed
when performing induction on the *dominator tree*. 

Author: Jad Ghaliyani, Siddharth Bhat
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

variable [TyDenote Ty] [C : TyHasCoprod Ty] [CD : TyHasCoprodDenote Ty]

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


/-- Evaluate a term -/
def Term.evaluate [TyDenote Ty] {Γ : Ctxt Ty} {ty : Ty} (t : Term Γ ty) (VΓ : Ctxt.Valuation Γ)
  : ⟦ty⟧ := match t with
  | var v => VΓ v
  | val v => v

/-- A region supporting arbitrary control-flow -/
inductive Region [C : TyHasCoprod Ty] : (Γ : Ctxt Ty) → (L : Ctxt Ty) → Type
| br (a : Term Γ α) (hl : L.Var α) : Region Γ L
| case (a : Term Γ (C.coprod α β)) (s : Region (Γ.snoc α) L) (t : Region (Γ.snoc β) L) : Region Γ L
| let₁ (a : Term Γ α) (t : Region (Γ.snoc α) L) : Region Γ L
| cfg {Γ R L D : Ctxt Ty}
    (inL : Ctxt.Hom D (R ++ L))
    (t : Region Γ D) -- t for terminator, G for fixpoint graph.
    (G : ∀{α}, R.Var α → Region (Γ.snoc α) D)
   : Region Γ L

inductive Region.Evaluated  :
    (Γ : Ctxt Ty) → (VΓ : Ctxt.Valuation Γ) → (L : Ctxt Ty) → (R : Region Γ L) → (VL' : Ctxt.CoValuation L) → Prop
| br :  Evaluated Γ VL L (Region.br a hl) (Ctxt.CoValuation.ofVar hl (a.evaluate VΓ))
| case_inl : (ha : a.evaluate VΓ = CD.inl (a := α) l)
  → Evaluated (Ctxt.snoc Γ α) (Ctxt.Valuation.snoc VΓ l) L t VL
  → Evaluated Γ VΓ L (Region.case a s t) VL
| case_inr : (ha : a.evaluate VΓ = CD.inr (b := β) r)
  → Evaluated (Ctxt.snoc Γ β) (Ctxt.Valuation.snoc VΓ r) L t VL
  → Evaluated Γ VΓ L (Region.case a s t) VL
| let₁
  : Evaluated (Ctxt.snoc Γ α) (Ctxt.Valuation.snoc VΓ (a.evaluate VΓ)) L t VL
  → Evaluated Γ VΓ L (let₁ a t) VL
| cfg_sibling {inL : Ctxt.Hom D (R ++ L)}
  : Evaluated Γ VΓ D t VL
  → (hVL : appendEquiv (VL.comap inL) = Sum.inr S)
  → Evaluated Γ VΓ L (cfg inL t G) S
| cfg_child {Γ : Ctxt Ty} {VΓ : Γ.Valuation} {L R D : Ctxt Ty}
  {VL : L.CoValuation} {VD : D.CoValuation} {inL : Ctxt.Hom D (R ++ L)}
  {C : Ctxt.CoValuation R}
  {t : Region Γ D}
  {G : ∀ {α}, R.Var α → Region (Γ.snoc α) D}
  : Evaluated Γ VΓ D t VD
  → (hVL : appendEquiv (VD.comap inL) = Sum.inl (α := R.CoValuation) (β := L.CoValuation) C)
  → Evaluated Γ VΓ L (cfg inL (let₁ (Term.val C.val) (G C.var)) G) VL
  → Evaluated Γ VΓ L (cfg (Γ := Γ) (R := R) (L := L) (D := D) inL t G) VL
