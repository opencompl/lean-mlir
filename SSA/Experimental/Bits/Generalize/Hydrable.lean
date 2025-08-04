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


attribute [instance] Hydrable.beqLogical
attribute [instance] Hydrable.messageDataLogical
attribute [instance] Hydrable.hashableLogical
attribute [instance] Hydrable.hashableGenExpr
attribute [instance] Hydrable.beqGenExpr

end Generalize
