/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Mathlib.Tactic.Ring
import SSA.Projects.InstCombine.ForLean
import SSA.Projects.InstCombine.LLVM.EDSL
import SSA.Experimental.Bits.Fast.Tactic
import SSA.Experimental.Bits.AutoStructs.Tactic
import SSA.Experimental.Bits.AutoStructs.ForLean
import Std.Tactic.BVDecide
import Leanwuzla

open Lean
open Lean.Elab.Tactic

attribute [simp_llvm_case_bash]
  BitVec.Refinement.refl BitVec.Refinement.some_some BitVec.Refinement.none_left
  bind_assoc forall_const
  Option.bind_eq_bind Option.none_bind Option.bind_none Option.some_bind Option.pure_def
  BitVec.reduceOfInt Nat.cast_one
/- `reduceOfInt` and `Nat.cast_one` are somewhat questionable additions to this simp-set.
   They are not needed for the case-bashing to succeed, but they are simp-lemmas that were
   previously being applied in `AliveAutoGenerated`, where they closed a few trivial goals,
   so they've been preserved to not change this existing behaviour of `simp_alive_case_bash` -/

/-- `ensure_only_goal` succeeds, doing nothing, when there is exactly *one* goal.
If there are multiple goals, `ensure_only_goal` fails -/
elab "ensure_only_goal" : tactic =>
  Lean.Elab.Tactic.withMainContext do
    match (← Lean.Elab.Tactic.getGoals) with
    | [_g] => pure ()
    | [] => throwError "expected exactly one goal, found no goals."
    | gs@(_ :: _ :: _) =>
      throwError m!"expected exactly one goal, found multiple goals: '{gs}'."

/--
`simp_alive_case_bash` transforms a goal of the form
  `∀ (x₁ : Option (BitVec _)) ... (xₙ : Option (BitVec _)), ...`
into a goal about just `BitVec`s, by doing a case distinction on each `Option`.

Then, we `simp`lify each goal, following the assumption that the `none` cases
should generally be trivial, hopefully leaving us with just a single goal:
the one where each option is `some`. -/
syntax "simp_alive_case_bash'" : tactic
macro_rules
  | `(tactic| simp_alive_case_bash') => `(tactic|
    first
    | fail_if_success (intro (v : Option (_)))
      -- If there is no variable to introduce, `intro` fails, so the first branch succeeds,
      -- but does nothing. This is similar to `try`, except `first ...` does not swallow any errors
      -- that occur in the later tactics
    | intro (v : Option (_))    -- Introduce the variable,
      rcases v with _|x         -- Do the case distinction
      <;> simp (config:={failIfUnchanged := false}) only [simp_llvm_case_bash]
      --  ^^^^^^^^^^^^^^^^^^^^^^^^ Simplify, in the hopes that the `none` case is trivially closed
      <;> simp_alive_case_bash'  -- Recurse, to case bash the next variable (if it exists)
      <;> (try revert x)        -- Finally, revert the variable we got in the `some` case, so that
                                --   we are left with a universally quantified goal of the form:
                                --   `∀ (x₁ : BitVec _) ... (xₙ : BitVec _), ...`
    )

def revertIntW (g : MVarId) : MetaM (Array FVarId × MVarId) := do
  let type ← g.getType
  let (_, fvars) ← type.forEachWhere Expr.isFVar collector |>.run {}
  g.revert fvars.toArray
where
  collector (e : Expr) : StateT (Std.HashSet FVarId) MetaM Unit := do
    let fvarId := e.fvarId!
    let typ ← fvarId.getType
    match_expr typ with
    | LLVM.IntW _ =>
      modify fun s => s.insert fvarId
    | _ => return ()

elab "revert_intw" : tactic => do
  let g ← getMainGoal
  let (_, g') ← revertIntW g
  replaceMainGoal [g']

syntax "simp_alive_case_bash" : tactic
macro_rules
  | `(tactic| simp_alive_case_bash) => `(tactic|
    (
      revert_intw
      simp_alive_case_bash'
    )
  )


/-- Unfold into the `undef' statements and eliminates as much as possible. -/
macro "simp_alive_undef" : tactic =>
  `(tactic|
      (
        simp (config := {failIfUnchanged := false}) only [
            simp_llvm_option,
            BitVec.Refinement, bind_assoc,
            Bool.false_eq_true, false_and, reduceIte,
            (BitVec.ofInt_ofNat),
            Option.some_bind''
          ]
      )
  )

/- Simplify away the `InstCombine` specific semantics. -/
macro "simp_alive_ops" : tactic =>
  `(tactic|
      (
        simp (config := {failIfUnchanged := false}) only [
            simp_llvm,
            BitVec.ofInt_neg_one,
            (BitVec.ofInt_ofNat),
            pure_bind,
            bind_if_then_none_eq_if_bind, bind_if_else_none_eq_if_bind
          ]
      )
  )

/-
This tactic attempts to shift ofBool to the outer-most level,
and then convert everything to arithmetic
and then solve with the omega tactic.
-/
macro "of_bool_tactic" : tactic =>
  `(tactic|
    (
    try simp only [bv_ofBool, BitVec.ule, BitVec.ult, BitVec.sle, BitVec.slt, BitVec.toInt, BEq.beq, bne]
    try ext
    simp only [← Bool.decide_or, ← Bool.decide_and, ← decide_not, decide_eq_decide, of_decide_eq_true,
      BitVec.toNat_eq]
    repeat (
      first
      | simp [h]
      | split
      | omega
      | rw [Nat.mod_eq_if]
    )
    ))

macro "bv_eliminate_bool" : tactic =>
  `(tactic|
    (
      try simp only [BitVec.and_eq, BitVec.or_eq, bv_ofBool, BEq.beq, bne,
        ←Bool.decide_and, ←Bool.decide_or]
      simp only [decide_eq_decide]
    )
   )

macro "bv_distrib" : tactic =>
  `(tactic|
    (
      try simp [BitVec.shiftLeft_or_distrib, BitVec.shiftLeft_xor_distrib,
        BitVec.shiftLeft_and_distrib, BitVec.and_assoc, BitVec.or_assoc]
      try ac_rfl
    )
   )

macro "bv_auto": tactic =>
  `(tactic|
      (
        intros
        try simp (config := {failIfUnchanged := false}) [-Bool.and_iff_left_iff_imp, (BitVec.negOne_eq_allOnes)]
        try ring_nf
        try bv_eliminate_bool
        repeat (split)
        <;> try simp (config := {failIfUnchanged := false})
        /-
        Solve tries each arm in order, falling through
        if the goal is not closed.
        Note that all goals are tried with the original state
        (i.e. backtracking semantics).
        -/
        try solve
          | ext; simp [BitVec.negOne_eq_allOnes, BitVec.allOnes_sub_eq_xor];
            try bv_decide
          | simp [bv_ofBool]
          /-
          There are 2 main kinds of operations on BitVecs
          1. Boolean operations (^^^, &&&, |||) which can be solved by extensionality.
          2. Arithmetic operations (+, -) which can be solved by `ring_nf`.
          The purpose of the below line is to convert boolean
          operations to arithmetic operations and then
          solve the arithmetic with the `ring_nf` tactic.
          -/
          | simp only [← BitVec.allOnes_sub_eq_xor]
            simp only [← BitVec.negOne_eq_allOnes]
            ring_nf
          | of_bool_tactic
          -- Disabled as `x &&& 4294967295#32 = x` leads to a stack overflow.
          -- | (
          --   simp (config := {failIfUnchanged := false}) only [(BitVec.two_mul), ←BitVec.negOne_eq_allOnes]
          --    bv_automata
          --  )
          | (
             simp (config := {failIfUnchanged := false}) only [BitVec.two_mul, ←BitVec.negOne_eq_allOnes, ofBool_0_iff_false, ofBool_1_iff_true]
             try rw [Bool.eq_iff_iff]
             simp (config := {failIfUnchanged := false}) [Bool.or_eq_true_iff, Bool.and_eq_true_iff,  beq_iff_eq]
             bv_automata'
           )
          |
            try split
            all_goals bv_decide
          | bv_distrib
      )
   )

macro "alive_auto": tactic =>
  `(tactic|
      (
        simp_alive_undef
        simp_alive_ops
        try (
          simp_alive_case_bash
          ensure_only_goal
        )
        bv_auto
      )
   )

macro "bv_compare'": tactic =>
  `(tactic|
      (
        -- bv_compare -- for evaluating performance
        bv_decide -- replace this with bv_compare to evaluate performance
      )
   )

macro "simp_alive_split": tactic =>
  `(tactic|
      (
        repeat(all_goals split; all_goals simp only [BitVec.Refinement.some_some, BitVec.Refinement.refl])
      )
   )

macro "simp_alive_benchmark": tactic =>
  `(tactic|
      (
        all_goals try bv_decide -- replace this with bv_compare to evaluate performance
      )
   )
