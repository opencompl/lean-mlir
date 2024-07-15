/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Mathlib.Tactic.Ring
import Batteries.Data.BitVec
import SSA.Projects.InstCombine.ForLean

import SSA.Projects.InstCombine.LLVM.EDSL
import Batteries.Data.BitVec

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
syntax "simp_alive_case_bash" : tactic
macro_rules
  | `(tactic| simp_alive_case_bash) => `(tactic|
    first
    | fail_if_success (intro (v : Option (_)))
      -- If there is no variable to introduce, `intro` fails, so the first branch succeeds,
      -- but does nothing. This is similar to `try`, except `first ...` does not swallow any errors
      -- that occur in the later tactics
    | intro (v : Option (_))    -- Introduce the variable,
      rcases v with _|x         -- Do the case distinction
      <;> simp (config:={failIfUnchanged := false}) only [simp_llvm_case_bash]
      --  ^^^^^^^^^^^^^^^^^^^^^^^^ Simplify, in the hopes that the `none` case is trivially closed
      <;> simp_alive_case_bash  -- Recurse, to case bash the next variable (if it exists)
      <;> (try revert x)        -- Finally, revert the variable we got in the `some` case, so that
                                --   we are left with a universally quantified goal of the form:
                                --   `∀ (x₁ : BitVec _) ... (xₙ : BitVec _), ...`
    )


/-- Unfold into the `undef' statements and eliminates as much as possible. -/
macro "simp_alive_undef" : tactic =>
  `(tactic|
      (
        simp (config := {failIfUnchanged := false}) only [
            simp_llvm_option,
            BitVec.Refinement, bind_assoc,
          ]
      )
  )

/- Simplify away the `InstCombine` specific semantics. -/
macro "simp_alive_ops" : tactic =>
  `(tactic|
      (
        simp (config := {failIfUnchanged := false}) only [
            simp_llvm, BitVec.bitvec_minus_one,
            BitVec.bitvec_minus_one',
            (BitVec.ofInt_ofNat),
            pure_bind
          ]
      )
  )

macro "simp_alive_bitvec": tactic =>
  `(tactic|
      (
        intros
        simp (config := {failIfUnchanged := false}) [(BitVec.negOne_eq_allOnes')]
        try ring_nf
        /-
        Solve tries each arm in order, falling through
        if the goal is not closed.
        Note that all goals are tried with the original state
        (i.e. backtracking semantics).
        -/
        try solve
          | ext; simp [BitVec.negOne_eq_allOnes, BitVec.allOnes_sub_eq_xor];
            try cases BitVec.getLsb _ _ <;> try simp
            try cases BitVec.getLsb _ _ <;> try simp
            try cases BitVec.getLsb _ _ <;> try simp
            try cases BitVec.getLsb _ _ <;> try simp
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
            simp only [← BitVec.negOne_eq_allOnes']
            ring_nf
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
      repeat (
        first
      | simp [bv_ofBool]
      | simp [ForLean.ofBool_eq']
      | simp
      | simp only [bne]
      )
      repeat (
        first
      | simp only [BitVec.ule]
      | simp only [BitVec.ult]
      | simp only [BitVec.sle]
      | simp only [BitVec.slt]
      | simp only [BitVec.toInt]
      | simp only [BEq.beq]
      | simp only [← Bool.decide_or]
      | simp only [← Bool.decide_and]
      | simp only [← decide_not]
      | simp only [decide_eq_decide]
      | simp [of_decide_eq_true]
      | simp only [BitVec.toNat_eq]
      )
      try omega
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
        simp_alive_bitvec
        of_bool_tactic
      )
   )
