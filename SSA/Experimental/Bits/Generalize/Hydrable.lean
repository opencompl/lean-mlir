/-
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Timi Adeniran, Siddharth Bhat
-/
import Lean.Elab.Term
import Lean.Meta.ForEachExpr
import Lean.Meta.Tactic.Simp.BuiltinSimprocs.BitVec
import Lean

open Lean
open Lean.Meta
open Std.Sat
open Std.Tactic.BVDecide

open Lean Elab Std Sat AIG Tactic BVDecide Frontend


namespace Generalize

inductive SubstitutionValue (genExpr : Nat → Type) where
| bvExpr {w} (bvExpr : genExpr w)
| packedBV  (bv: BVExpr.PackedBitVec)

instance : Inhabited (SubstitutionValue genExpr) where
  default := .packedBV (BVExpr.PackedBitVec.mk (w := 0) 0#0)

-- class Monad n
class Hydrable (parsedLogicalExpr : Type) (genLogicalExpr : Type) (genExpr : Nat → Type) where
  beqLogical : BEq genLogicalExpr := by infer_instance
  messageDataLogical : ToMessageData genLogicalExpr := by infer_instance
  hashableLogical : Hashable genLogicalExpr := by infer_instance
  hashableGenExpr : ∀ (n : Nat), Hashable (genExpr n) := by infer_instance
  beqGenExpr : ∀ (n : Nat), BEq (genExpr n) := by infer_instance
  genExprToExpr {n : Nat} : parsedLogicalExpr → genExpr n → MetaM Expr
  genLogicalExprToExpr : parsedLogicalExpr → genLogicalExpr → (widthExpr : Expr) → MetaM Expr
  getAllNamesFromParsedLogicalExpr : parsedLogicalExpr → HashMap Nat Name
  getLogicalExprSize : genLogicalExpr → Nat
  substitute : genLogicalExpr → (assignment: Std.HashMap Nat (SubstitutionValue genExpr)) → genLogicalExpr
  packedBitVecToSubstitutionValue : (Std.HashMap Nat BVExpr.PackedBitVec) → Std.HashMap Nat (SubstitutionValue genExpr)
  getIdentityAndAbsorptionConstraints : genLogicalExpr →  Std.HashSet Nat → List genLogicalExpr
  addConstraints : genLogicalExpr → List genLogicalExpr → Gate → genLogicalExpr
  -- pruneEquivalentGenExprs : List (genExpr n) → MetaM (List (genExpr n))
  -- pruneEquivalentGenLogicalExprs : List (genLogicalExpr) → MetaM (List genLogicalExpr)
  not : genLogicalExpr → genLogicalExpr
  and : genLogicalExpr → genLogicalExpr → genLogicalExpr
  eq : genExpr n → genExpr n → genLogicalExpr
  True : genLogicalExpr
  False : genLogicalExpr
  genExprVar : Nat → genExpr n
  genExprConst : BitVec n → genExpr n
  deductiveSearch : genExpr n → Std.HashMap Nat BVExpr.PackedBitVec → BVExpr.PackedBitVec → Nat → Nat → TermElabM (List (genExpr n))


attribute [instance] Hydrable.beqLogical
attribute [instance] Hydrable.messageDataLogical
attribute [instance] Hydrable.hashableLogical
attribute [instance] Hydrable.hashableGenExpr
attribute [instance] Hydrable.beqGenExpr

end Generalize
