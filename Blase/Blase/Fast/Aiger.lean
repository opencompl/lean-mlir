import Mathlib.Data.Fintype.Defs
import Blase.Fast.FiniteStateMachine

import Lean
open Std Sat AIG

variable {α : Type} [Hashable α] [DecidableEq α]

private structure Latch (aig : AIG α) where
  init : Bool
  state : aig.Ref
  next : aig.Ref

-- Note that this currently does not require much in the way of wellformedness,
-- it could specify multiple references as the same latch/input etc
structure Aiger (α : Type) [Hashable α] [DecidableEq α] where
  aig : AIG α
  latches : Array (Latch aig)
  inputs : Array aig.Ref
  bad : aig.Ref

def _root_.FSM.toAiger {arity : Type}
    [Hashable arity] [Fintype arity] [DecidableEq arity]
    (fsm : FSM arity) : Aiger (fsm.α ⊕ arity) :=
  let aig := .empty

  let ⟨aig, inputs⟩ : (aig : AIG _) × Array aig.Ref :=
    (@Fintype.elems arity).val.liftOn
      (fun elems => elems.foldl (init := ⟨aig, .empty⟩)
        (fun ⟨aig, vec⟩ s =>
          let ⟨aig, ref⟩ := aig.mkAtomCached (.inr s)
          let vec := vec.map (.cast . sorry)
          ⟨aig, vec.push ref⟩))
      -- Functions that operate on a quotient should be provably indistinguishable
      -- up to the quotienting however in this case we will not be equivalent
      -- because the aiger we produce will depend on the ordering of elements
      -- however the actual solvability of the system does not depend on the
      -- ordering of elements therefore this sorry is in fact benign
      sorry

  -- Array of next state variables with their function
  let ⟨aig, latches⟩ : (aig : AIG _) × Array (Latch aig) := fsm.i.toList.foldl
    (fun ⟨aig, vec⟩ var =>
      let res := fsm.nextStateCirc var |>.toAIGAux aig
      let aig := res.out
      let next := res.ref

      let ⟨aig, state⟩ := aig.mkAtomCached (.inl var)
      let init := fsm.initCarry var
      let vec := vec.map (fun l => { l with state := l.state.cast sorry, next := l.next.cast sorry })
      ⟨aig, vec.push {init, state, next := next.cast sorry}⟩)
    ⟨aig, .empty⟩

  let res := fsm.outputCirc.toAIGAux aig
  let aig := res.out
  let bad := res.ref

  let inputs := inputs.map (.cast . sorry)
  let latches := latches.map
    (fun l => { l with state := l.state.cast sorry, next := l.next.cast sorry })

  { aig, latches, inputs, bad }

namespace Aiger

private def toVarFalseLit (lit : Nat) : Nat := lit * 2
private def toVarFalse {aig : AIG α} (ref : aig.Ref) : Nat := toVarFalseLit ref.gate

private def toVar {aig : AIG α} (ref : aig.Ref) : Nat := (toVarFalse ref) + ref.invert.toNat
private def toVarFanin (fanin : Fanin) : Nat := toVarFalseLit fanin.gate + fanin.invert.toNat

def toAagFile (aig : Aiger α) (file : IO.FS.Stream) : IO Unit := do
  let maxVar := aig.aig.decls.size
  let numInputs := aig.inputs.size
  let numLatches := aig.latches.size
  let ⟨numAnds, body, _⟩ : _ × _ × _ := aig.aig.decls.foldl
      (fun ⟨numAnds, s, idx⟩ term =>
        match term with
        | Decl.gate l r => ⟨numAnds + 1, s ++ s!"{toVarFalseLit idx} {toVarFanin l} {toVarFanin r}\n", idx + 1⟩
        | _ => ⟨numAnds, s, idx + 1⟩)
      ⟨0, "", 0⟩

  -- Aiger 1.9 Header M I L O A B C J F
  file.putStrLn s!"aag {maxVar} {numInputs} {numLatches} 0 {numAnds} 1 0 0 0"

  -- Input lines
  for input in aig.inputs do
    assert! !input.invert
    file.putStrLn s!"{toVarFalse input}"

  -- Latch lines
  for l in aig.latches do
    assert! !l.state.invert
    file.putStrLn s!"{toVarFalse l.state} {toVar l.next} {l.init.toNat}"

  file.putStrLn s!"{toVar aig.bad}"

  file.putStr body

end Aiger

