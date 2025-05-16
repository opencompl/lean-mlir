/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Mathlib.Tactic.Ring
import Std.Tactic.BVDecide
import Leanwuzla

import SSA.Projects.InstCombine.Tactic.SimpLLVM
import SSA.Experimental.Bits.Frontend.Tactic
import SSA.Experimental.Bits.Fast.MBA
import SSA.Experimental.Bits.AutoStructs.ForLean
import SSA.Core.Tactic.TacBench

open Lean
open Lean.Elab.Tactic

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
      simp (config := {failIfUnchanged := false}) [BitVec.neg_one_eq_allOnes, BitVec.allOnes_sub_eq_xor];
      try bv_decide
      done
    )
   )

macro "bool_to_prop" : tactic =>
  `(tactic|
    (
      simp -failIfUnchanged only
        [BitVec.two_mul, ←BitVec.neg_one_eq_allOnes, ofBool_0_iff_false, ofBool_1_iff_true]
      try rw [Bool.eq_iff_iff]
      simp -failIfUnchanged only
        [Bool.or_eq_true_iff, Bool.and_eq_true_iff, beq_iff_eq, BitVec.ofBool_or_ofBool,
         ofBool_1_iff_true, Bool.or_eq_true, bne_iff_ne, ne_eq, iff_true, true_iff]
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
        ← BitVec.neg_one_eq_allOnes]
      try ring_nf
      try rfl
      done
    )
   )

macro "bv_ac" : tactic =>
  `(tactic|
    (
      simp (config := {failIfUnchanged := false}) only [← BitVec.allOnes_sub_eq_xor,
        ← BitVec.neg_one_eq_allOnes]
      ac_nf
      done
    )
   )

macro "bv_auto": tactic =>
  `(tactic|
      (
        simp_all (config := { failIfUnchanged := false }) only
          [BitVec.ofBool_or_ofBool, BitVec.ofBool_and_ofBool,
           BitVec.ofBool_xor_ofBool, BitVec.ofBool_eq_iff_eq]
        try solve
          | bv_bitwise
          | bv_ac
          | bv_distrib
          | bv_ring
          | bv_of_bool
          | bool_to_prop; bv_automata_classic
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
        bv_compare +acNf +shortCircuit
        try bv_decide +acNf +shortCircuit -- close the goal if possible but do not report errors again
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
            -- Automata Classic
            "bv_automata_classic_prop" : (bool_to_prop; bv_automata_classic; done),
            "bv_automata_classic" : (bv_automata_classic; done),
            "bv_normalize_automata_classic" : ((try (solve | bv_normalize)); (try bv_automata_classic); done),
            "simp" : (simp; done),
            "bv_normalize" : (bv_normalize; done),
            "bv_decide" : (bv_decide; done),
            "bv_auto" : (bv_auto; done),
            -- Verified, Lean-based.
            "bv_automata_circuit_lean_prop" : (bool_to_prop; bv_automata_gen; done),
            "bv_automata_circuit_lean" : (bv_automata_gen (config := {backend := .circuit_lean}); done),
            "bv_normalize_automata_circuit_lean" : ((try (solve | bv_normalize)); (try bv_automata_gen (config := {backend := .circuit_lean}); done); done),
            -- Cadical based, currently unverified.
            "bv_automata_circuit_cadical_prop" : (bool_to_prop; bv_automata_gen (config := { backend := .circuit_cadical /- maxIter -/ 4 }); done),
            "bv_automata_circuit_cadical" : (bv_automata_gen (config := { backend := .circuit_cadical /- maxIter-/ 4 }); done),
            "bv_normalize_automata_circuit_cadical" : ((try (solve | bv_normalize)); (try bv_automata_gen (config := { backend := .circuit_cadical /- maxIter -/ 4})); done),
            -- MBA algorithm.
            "bv_mba" : (bv_mba; done),
            "bv_normalize_mba" : ((try (solve | bv_normalize)); (try bv_mba); done),
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
            "bv_normalize" : (bv_normalize; done),
            "presburger" : (bv_automata_classic; done),
            "normPresburger" : ((try (solve | bv_normalize)); (try bv_automata_classic); done),
            "circuitLean" : (bv_automata_gen (config := { backend := .cicuit_lean /- maxIter -/ 4 }); done),
            "circuit" : (bv_automata_gen (config := { backend := .circuit_cadical /- maxIter -/ 4 }); done),
            "normCircuit" : ((try (solve | bv_normalize)); (try bv_automata_gen (config := { backend := .circuit_cadical /- maxIter -/ 4 })); done),
            "no_uninterpreted" : (bv_automata_fragment_no_uninterpreted),
            "width_ok" : (bv_automata_fragment_width_legal),
            "reflect_ok" : (bv_automata_fragment_reflect),
            "bv_decide" : (bv_decide; done),
          ]
        )
      )
   )
