/-
Released under Apache 2.0 license as described in the file LICENSE.


Attributes for automata tactic.

Authors: Siddharth Bhat
-/
import Lean

/-- The simproc extension for the 'bv_automata' tactic, which rewrites the denotations of bitvectors into that of automata. -/
register_simp_attr bv_automata_denote

