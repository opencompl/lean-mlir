/-
Released under Apache 2.0 license as described in the file LICENSE.
This file reflects the semantics of bitstreams, terms, predicates, and FSMs
into lean bitvectors.

Relation between environments of bitvectors and environments of bitstreams.
This is used during reflection proofs to relate the infinite bitstream
semantics of FSMs with the finite semantics of the term being reflected.

Authors: Siddharth Bhat

-/
import Mathlib.Data.Bool.Basic
import Mathlib.Data.Fin.Basic
import Mathlib.Data.Finset.Basic
import Mathlib.Data.Finset.Defs
import Mathlib.Data.Multiset.FinsetOps
import SSA.Experimental.Bits.Frontend.Defs
import SSA.Experimental.Bits.Fast.BitStream
import SSA.Experimental.Bits.Fast.Defs
import SSA.Experimental.Bits.Fast.FiniteStateMachine
import SSA.Experimental.Bits.Fast.Decide
import SSA.Experimental.Bits.Frontend.Syntax
import SSA.Experimental.Bits.Frontend.Preprocessing
import Lean.Meta.ForEachExpr
import Lean.Meta.Tactic.Simp.BuiltinSimprocs.BitVec
import SSA.Experimental.Bits.Fast.ForLean
import SSA.Experimental.Bits.Vars

/-- Relate boolean and bitstream environments. -/
structure EnvSimEnvBitstream {arity : Type _} {α : Type _}
    (envBool : Vars α arity n → Bool)
    (envBitstream : arity → BitStream) where
  envBool_inputs_mk_eq_envBitStream : ∀ (x : arity) (i : Nat) (hi: i < n),
    envBool (Vars.inputs (Inputs.mk ⟨i, by omega⟩ x)) = envBitstream x i


theorem EnvSimEnvBitstream.envBool_inputs_mk_castShift_eq_envBitStream
   (envBool : Vars α arity m → Bool)
   (envBitstream : arity → BitStream)
   (hEnvBitstream : EnvSimEnvBitstream envBool envBitstream)
   (hnm : n ≤ m) (x : arity) (i : Nat) (hi : i < n) :
   (envBool ((Vars.inputs (Inputs.mk ⟨i, by omega⟩ x : Inputs _ n) :  Vars _ _ n).castShift hnm))=
   envBitstream x (m - 1 - i) := by
  rw [← hEnvBitstream.envBool_inputs_mk_eq_envBitStream]
  rfl

attribute [simp] EnvSimEnvBitstream.envBool_inputs_mk_eq_envBitStream

/-- Environment with chosen state variables of the FSM. -/
def envBool_of_envBitstream_of_state (p : FSM arity)
   (envBitstream : arity → BitStream)
   (s0 : p.α → Bool)
   (n : Nat) : Vars p.α arity (n + 1) → Bool :=
  fun x =>
    match x with
    | .state ss =>
      p.carryWith s0 envBitstream ss.ix ss.input
    | .inputs (.mk a i) => envBitstream i a
    | .outputs o =>
      p.evalWith s0 envBitstream o

/-- Environment with chosen state variables of the FSM. -/
def envBoolStart_of_envBitstream (p : FSM arity)
   (envBitstream : arity → BitStream)
   (n : Nat) : Vars p.α arity (n + 1) → Bool :=
  envBool_of_envBitstream_of_state p envBitstream p.initCarry n
