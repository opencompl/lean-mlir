/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Lean

/-!
## LeanMLIR Simpsets
Recall that we can't use a simpset in the same file as it's defined, so we
define all simpsets in this separate file.
-/

/-- `simp_denote` simplifies the denotation of `Expr`s and `Com`s into the
underlying semantics functions. -/
register_simp_attr simp_denote
