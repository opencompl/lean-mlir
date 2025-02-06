/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Mathlib.Tactic.Ring
import SSA.Projects.InstCombine.ForLean
import SSA.Projects.InstCombine.LLVM.EDSL
import SSA.Experimental.Bits.Fast.Reflect
import SSA.Experimental.Bits.Fast.MBA
import SSA.Experimental.Bits.FastCopy.Reflect
import SSA.Experimental.Bits.AutoStructs.Tactic
import SSA.Experimental.Bits.AutoStructs.ForLean
import Std.Tactic.BVDecide
import SSA.Core.Tactic.TacBench
import Leanwuzla

open Lean
open Lean.Elab.Tactic

attribute [simp_llvm_case_bash]
  BitVec.Refinement.refl BitVec.Refinement.some_some BitVec.Refinement.none_left
  bind_assoc forall_const
  Option.bind_eq_bind Option.none_bind Option.bind_none Option.some_bind Option.pure_def
  Nat.cast_one

attribute [simp_llvm_split]
  BitVec.Refinement.some_some BitVec.Refinement.refl Option.some_bind''
  BitVec.Refinement.none_left Option.some_bind Option.bind_none Option.none_bind
  Option.some.injEq if_if_eq_if_and if_if_eq_if_or
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
      <;> simp (config:={failIfUnchanged := false}) -implicitDefEqProofs only [simp_llvm_case_bash]
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
macro "bv_of_bool" : tactic =>
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

macro "bv_bitwise" : tactic =>
  `(tactic|
    (
      ext
      simp (config := {failIfUnchanged := false}) [BitVec.negOne_eq_allOnes, BitVec.allOnes_sub_eq_xor];
      try bv_decide
      done
    )
   )

macro "bool_to_prop" : tactic =>
  `(tactic|
    (
      simp -failIfUnchanged only
        [BitVec.two_mul, ←BitVec.negOne_eq_allOnes, ofBool_0_iff_false, ofBool_1_iff_true]
      try rw [Bool.eq_iff_iff]
      simp -failIfUnchanged only
        [Bool.or_eq_true_iff, Bool.and_eq_true_iff, beq_iff_eq, BitVec.ofBool_or_ofBool,
         ofBool_1_iff_true, Bool.or_eq_true, bne_iff_ne, ne_eq, iff_true, true_iff]
    )
   )

macro "bv_automata_classic" : tactic =>
  `(tactic|
    (
      bv_automata_classic_nf
    )
   )

/--
There are 2 main kinds of operations on BitVecs
1. Boolean operations (^^^, &&&, |||) which can be solved by extensionality.
2. Arithmetic operations (+, -) which can be solved by `ring_nf`.
The purpose of the below line is to convert boolean
operations to arithmetic operations and then
solve the arithmetic with the `ring_nf` tactic.
-/
macro "bv_ring" : tactic =>
  `(tactic|
    (
      simp (config := {failIfUnchanged := false}) only [← BitVec.allOnes_sub_eq_xor,
        ← BitVec.negOne_eq_allOnes]
      try ring_nf
      try rfl
      done
    )
   )

macro "bv_ac" : tactic =>
  `(tactic|
    (
      simp (config := {failIfUnchanged := false}) only [← BitVec.allOnes_sub_eq_xor,
        ← BitVec.negOne_eq_allOnes]
      ac_nf
      done
    )
   )

macro "bv_auto": tactic =>
  `(tactic|
      (
        simp (config := { failIfUnchanged := false }) only
          [BitVec.ofBool_or_ofBool, BitVec.ofBool_and_ofBool,
           BitVec.ofBool_xor_ofBool, BitVec.ofBool_eq_iff_eq]
        try solve
          | bv_bitwise
          | bv_ac
          | bv_distrib
          | bv_ring
          | bv_of_bool
          | bool_to_prop; bv_automata'
          | bv_decide
      )
   )

macro "alive_auto'": tactic =>
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

macro "alive_auto": tactic =>
  `(tactic|
      (
        all_goals alive_auto'
      )
   )

macro "bv_compare'": tactic =>
  `(tactic|
      (
        simp (config := {failIfUnchanged := false}) only [BitVec.twoPow, BitVec.intMin, BitVec.intMax] at *
        bv_compare
        try bv_decide -- close the goal if possible but do not report errors again
      )
   )

macro "simp_alive_split": tactic =>
  `(tactic|
      (
        all_goals try intros
        repeat(
          all_goals try simp -implicitDefEqProofs only [simp_llvm_split]
          all_goals try simp -implicitDefEqProofs only [simp_llvm_split] at *
          any_goals split_ifs
        )
        repeat(
          all_goals try simp -implicitDefEqProofs only [simp_llvm_split]
          all_goals try simp -implicitDefEqProofs only [simp_llvm_split] at *
          any_goals split
        )
        all_goals try simp -implicitDefEqProofs only [simp_llvm_split]
        all_goals try simp -implicitDefEqProofs only [simp_llvm_split] at *
      )
   )

macro "simp_alive_benchmark": tactic =>
  `(tactic|
      (
        all_goals bv_compare'
      )
   )

macro "bv_bench": tactic =>
  `(tactic|
      (
        simp (config := { failIfUnchanged := false }) only
          [BitVec.ofBool_or_ofBool, BitVec.ofBool_and_ofBool,
           BitVec.ofBool_xor_ofBool, BitVec.ofBool_eq_iff_eq,
           BitVec.ofNat_eq_ofNat, BitVec.two_mul]
        all_goals (
          tac_bench [
            "rfl" : (rfl; done),
            "bv_bitwise" : (bv_bitwise; done),
            "bv_ac" : (bv_ac; done),
            "bv_distrib" : (bv_distrib; done),
            "bv_ring" : (bv_ring; done),
            "bv_of_bool" : (bv_of_bool; done),
            "bv_omega" : (bv_omega; done),
            "bv_automata_classic_prop" : (bool_to_prop; bv_automata_classic; done),
            "bv_automata_classic" : (bv_automata_classic; done),
            "bv_normalize_automata_classic" : ((try (solve | bv_normalize)); (try bv_automata_classic); done),
            "simp" : (simp; done),
            "bv_normalize" : (bv_normalize; done),
            "bv_decide" : (bv_decide; done),
            "bv_auto" : (bv_auto; done),
            "bv_automata_circuit_prop" : (bool_to_prop; bv_automata_circuit; done),
            "bv_automata_circuit" : (bv_automata_circuit; done),
            "bv_normalize_automata_circuit" : ((try (solve | bv_normalize)); (try bv_automata_circuit); done),
            "bv_mba" : (bv_mba; done),
            "bv_normalize_mba" : ((try (solve | bv_normalize)); (try bv_mba); done)
          ]
          try bv_auto
          try sorry
        )
      )
   )

/--
Benchmark the automata algorithms to understand their pros and cons. Produce output as CSV.
-/
macro "bv_bench_automata": tactic =>
  `(tactic|
      (
        simp (config := { failIfUnchanged := false }) only
          [BitVec.ofBool_or_ofBool, BitVec.ofBool_and_ofBool,
           BitVec.ofBool_xor_ofBool, BitVec.ofBool_eq_iff_eq,
           BitVec.ofNat_eq_ofNat, BitVec.two_mul]
        all_goals (
          tac_bench (config := { outputType := .csv }) [
            "presburger" : (bv_automata_classic; done),
            "circuit" : (bv_automata_circuit (config := { backend := .cadical 0 }); done),
            "no_uninterpreted" : (bv_automata_fragment_no_uninterpreted),
            "width_ok" : (bv_automata_fragment_width_legal),
            "reflect_ok" : (bv_automata_fragment_reflect)
          ]
        )
      )
   )
