import Lean
import Lean.Meta.Tactic.Util

open Lean
open Lean.Meta
open Lean.Elab
open Lean.Elab.Tactic
open Lean Elab Tactic Meta
open Lean.Meta.Tactic

-- Function to check if an expression only uses `+` and `*`
partial def assertRingSolvable (e : Expr) : MetaM Unit :=
  match_expr e with
  | HAdd.hAdd _ _ _ _ f g => do
    assertRingSolvable f
    assertRingSolvable g
  | HMul.hMul _ _ _ _ f g => do
    assertRingSolvable f
    assertRingSolvable g
  | Expr.app f a => do
      assertRingSolvable f
      assertRingSolvable a
  | Expr.lam _ _ body _ => assertRingSolvable body
  | Expr.forallE _ _ body _ => assertRingSolvable body
  | Expr.letE _ _ value body _ => do
      assertRingSolvable value
      assertRingSolvable body
  | OfNat.ofNat _ _ _ => return ()
  | _ => match e with
      | Expr.fvar _ => return ()
      | e => do
        logInfo (repr e)
        throwError m!"Not Ring Solvable: Unallowed expression {e}"


-- Macro to check if the goal is of the form `... = ...` and only uses `+` and `*`
elab "tactic_check_ring_solvable" : tactic => do
  let goal ← getMainGoal
  let goalType ← Lean.MVarId.getType goal
  match_expr goalType with
  | Eq _ lhs rhs   =>
    do
      assertRingSolvable lhs
      assertRingSolvable rhs
      logInfo m!"The goal is of the form `... = ...` (specifically lhs = {lhs} and rhs = {rhs}) and only uses `+` and `*`."
  | _  => logInfo m!"The goal is not an equality."


-- Example usage
example (a  b: Nat ) : b * (2 + 1) = ( 4 + 2) * a := by
  tactic_check_ring_solvable
  sorry
