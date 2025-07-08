/-
Released under Apache 2.0 license as described in the file LICENSE.


Attributes for automata tactic.

Authors: Siddharth Bhat
-/
import Lean

/-- Preprocessing steps for the automata tactics. -/
register_simp_attr bv_automata_preprocess

/-- Preprocessing steps for bv_mba tactic. -/
register_simp_attr bv_mba_preprocess

/-- Preprocessing steps for the automata tactics. -/
register_simp_attr bv_automata_nnf
