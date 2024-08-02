import Lean
import Init.Data.BitVec.Lemmas
-- import Init.Data.BitVec.Lemmas
import SSA.Projects.InstCombine.TacticAuto
-- import SSA.Projects.InstCombine.ForStd
-- import SSA.Projects.InstCombine.ForMathlib
import SSA.Projects.InstCombine.LLVM.Semantics
-- import Mathlib.Tactic.Ring
-- import Batteries.Data.BitVec
import SSA.Projects.InstCombine.ForLean
import Lean.Meta
import SSA.Projects.InstCombine.LLVM.EDSL
-- import Batteries.Data.BitVec
-- import SSA.Projects.DataTactics.alex
open Lean Elab Tactic

set_option pp.proofs false
set_option pp.fullNames false
set_option linter.unusedTactic false
/-- `assertBitwiseOnly e` throws an error if `e` contains anything besides:
    bitwise operations, free variables and constants -/
partial def assertBitwiseOnly  (e : Expr)  : TacticM Unit :=
  if e.isFVar ∨ !e.hasFVar then
    return ()
  else
    match_expr e with
      | HAnd.hAnd _ _ _ _ a b => do
        assertBitwiseOnly a
        assertBitwiseOnly b
      | HOr.hOr _ _ _ _ a b => do
        assertBitwiseOnly a
        assertBitwiseOnly b
      | HXor.hXor _ _ _ _ a b => do
        assertBitwiseOnly a
        assertBitwiseOnly b
      | Complement.complement _ _ a => assertBitwiseOnly  a
      | BitVec.ofNat _ _ => return ()
      | BitVec.allOnes _ => return ()
      | Neg.neg _ _ a => assertBitwiseOnly  a
      | BitVec.xor _ a b =>  do
        assertBitwiseOnly a
        assertBitwiseOnly b
      | BitVec.or _ a b =>  do
        assertBitwiseOnly a
        assertBitwiseOnly b
      | BitVec.and _ a b =>  do
        assertBitwiseOnly a
        assertBitwiseOnly b
      | BitVec.not _ a  =>  do
        assertBitwiseOnly a
      | OfNat.ofNat _ _ _ => return ()
      | _ => throwError m!"{e} is not a bitwise-only bitvector expression"

/-- `assertRingSolvable e` throws an error if `e` contains anything besides:    addition, multiplication, free variables and constants -/
partial def assertAutomataSolvable  (e : Expr)  : TacticM Unit :=
  if e.isFVar ∨ !e.hasFVar then
    return ()
  else
    match_expr e with
      | HAdd.hAdd _ _ _ _ a b => do
        assertAutomataSolvable a
        assertAutomataSolvable b
      | HSub.hSub _ _ _ _ a b => do
        assertAutomataSolvable a
        assertAutomataSolvable b
      | HAnd.hAnd _ _ _ _ a b => do
        assertAutomataSolvable a
        assertAutomataSolvable b
      | HOr.hOr _ _ _ _ a b => do
        assertAutomataSolvable a
        assertAutomataSolvable b
      | HXor.hXor _ _ _ _ a b => do
        assertAutomataSolvable a
        assertAutomataSolvable b
      | Complement.complement _ _ a => assertAutomataSolvable  a
      | BitVec.ofNat _ _ => return ()
      | BitVec.allOnes _ => return ()
      | Neg.neg _ _ a => assertBitwiseOnly  a
      | _ => throwError m!"{e} is not a automata expression"


def x : Bool := Bool.xor true true
-- #check

/--
`assertRingSolvable e` throws an error if `e` contains
a non-arithmetic expression
-/
partial def assertRingSolvable (e : Expr) : TacticM Unit := do
  let name := (← getLCtx).foldl (· ++ toString ·.userName) ""
  if e.isFVar ∨ !e.hasFVar then
    return ()
  else
    match_expr e with
      | HAdd.hAdd _ _ _ _ a b => do
        assertRingSolvable a
        assertRingSolvable b
      | HMul.hMul _ _ _ _ a b => do
        assertRingSolvable a
        assertRingSolvable b
      | HSub.hSub _ _ _ _ a b => do
        assertRingSolvable a
        assertRingSolvable b
      | BitVec.ofNat _ _ => return ()
      | BitVec.allOnes _ => return ()
      | Neg.neg _ _ a => assertRingSolvable  a
      | BitVec.sub _ a b => do
        assertRingSolvable a
        assertRingSolvable b
      | BitVec.add _ a b => do
        assertRingSolvable a
        assertRingSolvable b
      | BitVec.mul _ a b => do
        assertRingSolvable a
        assertRingSolvable b
      | OfNat.ofNat _ _ _ => return ()
      | _ => throwError m!"{e} is not a ring-only expression"

partial def assertOfboolSolvable (e : Expr) : TacticM Unit := do
  let name := (← getLCtx).foldl (· ++ toString ·.userName) ""
  if e.isFVar ∨ !e.hasFVar then
    return ()
  else
    match_expr e with
      | BitVec.ofBool _ => return ()
      | _ => throwError m!"{name}: {e} not ofbool"

elab tk:"print_lctx" : tactic => do
  withMainContext do
    logInfoAt tk <| (← getLCtx).foldl (· ++ ·.userName) "Goal:"
def removeNewLines (s : String) : String :=
  s.foldl (fun acc c => if c == '\n' then acc else acc.push c) ""

/--
`assertGoal assert` throws an error iff the goal is not of the form
`lhs = rhs`, and then it runs `assert lhs` and `assert rhs`
-/
def assertGoal (assert : Expr → TacticM Unit) := do withMainContext <| do
  let goal ← getMainTarget
  let name := (← getLCtx).foldl (· ++ toString ·.userName) ""
  -- let name ←  (← getLCtx).foldl (· ++ s!"{·.userName}\n") ""

  match_expr goal with
    | Eq type lhs rhs =>
        -- match_expr type with
        -- | BitVec _ =>
        assert rhs
        assert lhs
        logInfo s!"succeeded"
        return ()
        -- | _ => do
        -- let m := m!"{type}"
        -- throwError m!"{name}: Equality not on the type of BitVectors. It is instead on another type {type}"
    | _ => do
      -- let m := m!"{goal}"
      throwError m!"{name}: Equality expected, found something else"


-- def assert_ofbool := do withMainContext <| do
--   let goal ← getMainTarget
--   let name := (← getLCtx).foldl (· ++ toString ·.userName) ""
--   -- let name ←  (← getLCtx).foldl (· ++ s!"{·.userName}\n") ""

--   match_expr goal with
--     | Iff type lhs rhs =>
--         match_expr type with
--         | BitVec _ =>
--           assertOfboolSolvable rhs
--           assertOfboolSolvable lhs
--           logInfo s!"succeeded"
--           return ()
--         | _ => do
--         -- let m := m!"{type}"
--         throwError m!"{name}: Equality not on the type of BitVectors. It is instead on another type"
--     | _ => do
--       -- let m := m!"{goal}"
--       throwError m!"{name}: Equality expected, found something {goal}"

namespace BitVec.Tactic
open BitVec
open Lean.Meta (kabstract)
elab "printIfNoGoals" : tactic => do
  let goals ← getGoals
  if goals.isEmpty then
    logInfo m!"No goals remaining!"

/--
bitvec_assert_bitwise asserts that the current goal
could be solved by a bitwise tactic because
it only contains bitwise operations
-/
elab "bitvec_assert_bitwise"  : tactic => assertGoal assertBitwiseOnly
/--
bitvec_assert_ring asserts that the current goal
could be solved by a ring tactic because it
only contains arithmetic operations
-/
elab "bitvec_assert_ring"     : tactic => assertGoal assertRingSolvable
/--
bitvec_assert_automata asserts that the current goal
could be solved by an automata tactic
because the current goal only contains
bitwise and arithmetic operations
-/
elab "bitvec_assert_automata" : tactic => assertGoal assertAutomataSolvable
elab "bitvec_assert_ofbool" : tactic => assertGoal assertOfboolSolvable

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
    simp only [BitVec.getLsb_and, BitVec.getLsb_or, BitVec.getLsb_xor];
    repeat (
      contains? (BitVec.getLsb _ i)
      generalize (BitVec.getLsb _ i) = x
      revert x
    )
    decide ; trace "solved by bitwise tactic"

  | bitvec_assert_ring
    -- TODO: import mathlib
    -- ring

  | bitvec_assert_automata
    sorry ; trace "solved by automata tactic"
  | fail "Could not solve goal with neither bitvec nor automata" -- TODO: better error
)
-- @[simp]
theorem BitVec.shift_left_eq_pow (x : BitVec w) (n : Nat) : x <<< n = x * BitVec.ofNat w (2 ^ n) := by
  sorry
macro "data_automata": tactic =>
  `(tactic|
       (
        intros
        all_goals (
          try (
            simp_alive_undef
            simp_alive_ops
            try (
              simp_alive_case_bash
              ensure_only_goal
            )
            simp  (config := {failIfUnchanged := false}) [(BitVec.negOne_eq_allOnes')]
            -- simp_alive_bitvec2
            -- of_bool_tactic
          )
          printIfNoGoals
          all_goals bitvec_assert_automata
        )
        all_goals (sorry)
      )
   )

macro "data_ring": tactic =>
  `(tactic|
       (
        intros
        all_goals (
          (
            simp_alive_undef
            simp_alive_ops
            try (
              simp_alive_case_bash
              ensure_only_goal
            )
            try simp only [(BitVec.negOne_eq_allOnes')]
            -- simp_alive_bitvec2
            try solve  | of_bool_tactic

            try simp only [← BitVec.allOnes_sub_eq_xor]
            try simp only [← BitVec.negOne_eq_allOnes']
            try simp only [BitVec.ofNat_eq_ofNat, BitVec.shiftLeft_eq', BitVec.shift_left_eq_pow]
          )
          printIfNoGoals
          all_goals bitvec_assert_ring
        )
        all_goals sorry
   )
  )

macro "data_bitwise": tactic =>
  `(tactic|
       (
        all_goals (
          intros
          try (
            simp_alive_undef
            simp_alive_ops
            try (
              simp_alive_case_bash
              ensure_only_goal
            )
            -- simp  (config := {failIfUnchanged := false}) [(BitVec.negOne_eq_allOnes')]
            -- simp_alive_bitvec2
            -- of_bool_tactic
            try simp only [BitVec.allOnes_sub_eq_xor]
            try simp only [BitVec.negOne_eq_allOnes']
          )
          printIfNoGoals
          all_goals bitvec_assert_bitwise
        )
        all_goals (sorry)
      )
   )

macro "data_ofbool": tactic =>
  `(tactic|
       (
        all_goals (
          intros
          try (
            simp_alive_undef
            simp_alive_ops
            try (
              simp_alive_case_bash
              ensure_only_goal
            )
            repeat (
            simp [bv_ofBool, -BitVec.ofBool_eq']
            )
            -- simp  (config := {failIfUnchanged := false}) [(BitVec.negOne_eq_allOnes')]
            -- simp_alive_bitvec2
            -- of_bool_tactic
            -- try simp only [BitVec.allOnes_sub_eq_xor]
            -- try simp only [BitVec.negOne_eq_allOnes']

          )
          printIfNoGoals
          all_goals bitvec_assert_ofbool
        )
        all_goals (sorry)
      )
   )

end BitVec.Tactic

open BitVec.Tactic
-- example :x✝
-- example (x y : BitVec w) : x + ((x * y) ||| y) = x := by
--   bitvec_assert_automata
--   sorry
-- theorem extracted_1 {w : Nat} (x x_1 x_2 : BitVec w) :
--   (((x_2.and x_1).xor x_1).add 1#w).add x = x.sub (x_2.or x_1.not) := by
--   --  intros
--   data_automata
-- Macro to check if the goal is of the form `... = ...` and only uses `+` and `*`

-- Example usage in a theorem
-- theorem exampleThezorem : 1 + 1 = 2 := by
--   -- printTheoremName
--   print_lctx
--   rfl
-- example (w : Nat) (x  : BitVec w) : x <<< 4 = x * 16 := by
--   -- simp only [← BitVec.allOnes_sub_eq_xor]
--   -- simp only [← BitVec.negOne_eq_allOnes']
--   data_ring
-- #check Lean.Elab.Term.BinderView
