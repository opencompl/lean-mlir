import Lean

open Lean Elab Tactic


/-- `assertBitwiseOnly e` throws an error if `e` contains anything besides:
    bitwise operations, free variables and constants -/
partial def assertBitwiseOnly (e : Expr) : TacticM Unit :=
  if e.isFVar || !e.hasFVar then
    return ()
  else if e.isAppOfArity' ``HAnd.hAnd 6
      || e.isAppOfArity' ``HOr.hOr 6
      || e.isAppOfArity' ``HXor.hXor 6
  then do
    assertBitwiseOnly <| e.getArg! 4
    assertBitwiseOnly <| e.getArg! 5
  else
    throwError "{e} is not a bitwise-only bitvector expression"



/-- `assertRingSolvable e` throws an error if `e` contains anything besides:
    addition, multiplication, free variables and constants -/
partial def assertRingSolvable (e : Expr) : TacticM Unit :=
  if e.isFVar || !e.hasFVar then
    return ()
  else if e.isAppOfArity' ``HAdd.hAdd 6
      || e.isAppOfArity' ``HMul.hMul 6
  then do
    assertBitwiseOnly <| e.getArg! 4
    assertBitwiseOnly <| e.getArg! 5
  else
    throwError "{e} is not a ring-only bitvector expression"



partial def assertAutomataSolvable (e : Expr) : TacticM Unit :=
  if e.isFVar || !e.hasFVar then
    return ()
  else if e.isAppOfArity' ``HAdd.hAdd 6
      || e.isAppOfArity' ``HAnd.hAnd 6
      || e.isAppOfArity' ``HOr.hOr 6
      || e.isAppOfArity' ``HXor.hXor 6
  then do
    assertAutomataSolvable <| e.getArg! 4
    assertAutomataSolvable <| e.getArg! 5
  else
    throwError "{e} is not a automata-solvable bitvector expression"

def assertGoal (k : Expr → TacticM Unit) := do withMainContext <| do
  let goal ← getMainTarget
  match_expr goal with
    | Eq _ lhs rhs =>
        dbg_trace "`{lhs}` = `{rhs}`"
        assertBitwiseOnly lhs
        assertBitwiseOnly rhs
        return ()
    | _ => throwError "Equality expected, found:\n{goal}"

namespace BitVec.Tactic
open BitVec
open Lean.Meta (kabstract)

scoped elab "bitvec_assert_bitwise"  : tactic => assertGoal assertBitwiseOnly
scoped elab "bitvec_assert_ring"     : tactic => assertGoal assertRingSolvable
scoped elab "bitvec_assert_automata" : tactic => assertGoal assertAutomataSolvable

/--
Check if an expression is contained in the current goal and fail otherwise.
This tactic does not modify the goal state.
 -/
scoped elab "contains? " ts:term : tactic => withMainContext do
  let tgt ← getMainTarget
  if (← kabstract tgt (← elabTerm ts none)) == tgt then throwError "pattern not found"

macro "bitvec_auto" : tactic => `(tactic|
  first
  | bitvec_assert_bitwise
    ext i
    simp only [getLsb_and, getLsb_or, getLsb_xor];
    repeat (
      contains? (BitVec.getLsb _ i)
      generalize (BitVec.getLsb _ i) = x
      revert x
    )
    decide

  -- | bitvec_assert_ring
    -- TODO: import mathlib
    -- ring

  | bitvec_assert_automata
    sorry
  | fail "Could not solve goal" -- TODO: better error
)



end BitVec.Tactic

open BitVec.Tactic

example (x y : BitVec w) : x ||| y = y ||| x := by
  bitvec_auto


#check Lean.Elab.Term.BinderView
