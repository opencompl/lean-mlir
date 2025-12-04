import Mathlib.Data.Fintype.Defs
import Blase.Fast.FiniteStateMachine
import Valaig.Aig.Basic
import Valaig.External

import Lean
open Std Sat AIG Valaig

variable {α : Type} [Hashable α] [DecidableEq α]

def _root_.FSM.toValaig {arity : Type}
    [Hashable arity] [Fintype arity] [DecidableEq arity]
    (fsm : FSM arity) : Aig :=
  let aig := .empty

  -- Build Valaig inputs datastructure and hashmap for relabelling
  let (aig, inputs, inputMap) : AIG _ × Array Aig.Input × HashMap arity Nat :=
    (@Fintype.elems arity).val.liftOn
      (fun elems => elems.foldl (init := (aig, .empty, .emptyWithCapacity))
        (fun (aig, vec, map) var =>
          let ⟨aig, ref⟩ := aig.mkAtomCached (.inr var)
          let input : Aig.Input := { var := Aig.Lit.ofRef ref |>.var }
          let idx := vec.size
          (aig, vec.push input, map.insert var idx)))
      -- Functions that operate on a quotient should be provably indistinguishable
      -- up to the quotienting however in this case we will not be equivalent
      -- because the aiger we produce will depend on the ordering of elements
      -- however the actual solvability of the system does not depend on the
      -- ordering of elements therefore this sorry is in fact benign
      sorry

  -- Build Valaig latches datastructure and hashmap for relabelling
  let (aig, latches, latchMap) : AIG _ × Array Aig.Latch × HashMap fsm.α Nat :=
    fsm.i.toList.foldl
      (fun (aig, vec, map) var =>
        let res := fsm.nextStateCirc var |>.toAIGAux aig
        let aig := res.out
        let next := res.ref

        let ⟨aig, state⟩ := aig.mkAtomCached (.inl var)
        let reset := fsm.initCarry var

        let latch := {
          var := Aig.Lit.ofRef state |>.var,
          next := Aig.Lit.ofRef next,
          reset := Aig.Lit.constant reset
        }
        let idx := vec.size
        (aig, vec.push latch, map.insert var idx))
      (aig, .empty, .emptyWithCapacity)

  let res := fsm.outputCirc.toAIGAux aig
  let aig := res.out
  let bad := res.ref

  let relabel : fsm.α ⊕ arity -> Aig.Atom
  | .inl latch => .latch (latchMap[latch]'sorry)
  | .inr input => .input (inputMap[input]'sorry)

  let aig := aig.relabel relabel
  {
    aig,
    inputs,
    latches,
    bads := #[{ lit := .ofRef bad }]
    -- We only use cached constant constructor so there are no other falses
    hfalse := sorry
    -- We construct the inputs/latches arrays directly as we add them and only
    -- use cached constructors so atoms only appear once
    hinputstodecl := sorry
    hdecltoinputs := sorry
    hlatchestodecl := sorry
    hdecltolatches := sorry
  }
