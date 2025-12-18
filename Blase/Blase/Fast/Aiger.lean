import Mathlib.Data.Fintype.Defs
import Blase.Fast.FiniteStateMachine
import Valaig.Aig.FromStd
import Valaig.External

import Lean
open Std Sat AIG Valaig

def _root_.FSM.toAiger {arity : Type}
    [Hashable arity] [Fintype arity] [DecidableEq arity]
    (fsm : FSM arity) : Aiger :=
  -- First we build a Std.Sat.AIG using toAIGAux by iterating the latches
  -- and bad, adding them to the new AIG. As we go, we take note of what these
  -- next state variables map to
  let res : (aig : AIG _) × Std.HashMap fsm.α aig.Ref :=
    fsm.i.toList.foldl
      (fun ⟨aig, map⟩ var =>
        let res := fsm.nextStateCirc var |>.toAIGAux aig
        let map := map.map fun _ r => r.cast res.le_size
        let map := map.insert var res.ref
        ⟨res.out, map⟩)
      ⟨.empty, .emptyWithCapacity⟩

  let stdAig := res.fst
  let nextMap := res.snd

  have hmapmem {a : fsm.α} : a ∈ nextMap := by
    have : ∀ {a} (_ : a ∈ fsm.i.toList), a ∈ nextMap := by
      let motive idx (state : (aig : AIG (fsm.α ⊕ arity)) × Std.HashMap _ aig.Ref) : Prop :=
        ∀ {i : Nat} {_ : idx ≤ fsm.i.toList.length} (_ : i < idx), fsm.i.toList[i]'(by grind) ∈ state.snd
      subst nextMap res
      simp only [←List.mem_toArray, ←Array.forall_getElem]
      rw [←List.foldl_toArray]
      intro i
      apply Array.foldl_induction motive
      · unfold motive; omega
      · unfold motive; grind
      · trivial
    exact this (FinEnum.mem_toList a)

  let res := fsm.outputCirc.toAIGAux stdAig
  let stdAig := res.out
  let bad := res.ref
  let nextMap := nextMap.map fun _ r => r.cast res.le_size
  have hmapmem : ∀ {a : fsm.α}, a ∈ nextMap := by grind only [HashMap.mem_map]

  let res := Valaig.Aig.fromStdAIG stdAig fun atom =>
    match atom with
    | .inl latch =>
      let next := nextMap[latch]'hmapmem
      let reset := .inl (fsm.initCarry latch)
      .latch next reset
    | .inr input => .input

  let bad := res.refMap bad
  {
    aig := res.aig,
    bads := #[.mk bad],
    hwf := res.hwf
    hbads := by simp; exact res.hrefvalid
  }

