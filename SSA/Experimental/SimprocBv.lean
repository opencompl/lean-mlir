/-
Copyright (c) 2023 Lean FRO, LLC. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Siddharth Bhat, Tobias Groser
-/
import Lean
open Lean Meta Elab Simp

@[inline] def reduceModEqOfLtV3 (e : Expr) : SimpM Step := do
  match_expr e with
  | HMod.hMod xTy nTy outTy  _inst x n =>
     let natTy := mkConst ``Nat
     -- x must be a Nat
     if xTy != natTy then
       trace[debug] "modEqOfLt: xTy:'{xTy}' != Nat"
       return .done { expr := e }
     if nTy != natTy then
       trace[debug] "modEqOfLt: nTy:'{nTy}' != Nat"
       return .done { expr := e }
     if outTy != natTy then
       trace[debug] "modEqOfLt: outTy:'{outTy}' != Nat"
       return .done { expr := e }
     trace[debug] "modEqOfLt: '{x}' % '{n}'"
    --  let h : Expr ← mkSorry (type := ← mkFreshExprMVar .none) true -- proof that a < b, to be proven by omega.
    --  trace[debug] "h: '{h}'"
     let instLtNat := mkConst ``instLTNat
     let ltTy := mkAppN (mkConst ``LT.lt [levelZero]) #[natTy, instLtNat, x, n] -- LT.lt Nat Nat
     -- general idea:
     -- 1. create an MVar `m` of type `g` is a goal state: `(... ⊢ g)`.
     -- when a value of the Mvar `m` is found, that's the proof of `g`.
     --  let ltProof : Expr ← mkSorry ltTy true
     -- FIXME: replace with the clean API that actually returns an MVarId.
     let ltProof : Expr ← mkFreshExprMVar ltTy
     trace[debug] "ltProof: {ltProof}"
     let ltProofMVar := ltProof.mvarId!
     trace[debug] "ltProofMVar: {ltProofMVar}"
     let some g ← ltProofMVar.falseOrByContra
       | return .done { expr := e }
     try
       g.withContext (do
          let hyps := (← getLocalHyps).toList
          Lean.Elab.Tactic.Omega.omega hyps g {})
       let eqProof ← mkAppM ``Nat.mod_eq_of_lt #[ltProof]
       trace[debug] "proof: {eqProof}"
       return .done { expr := x, proof? := eqProof : Result }
     catch ex =>
       return .done { expr := e }
  | _ => do
     trace[debug] "no match: '{toString e}'"
     return .done { expr := e  : Result }

simproc↑ reduce_mod_eq_of_lt_v3 (_ % _) := fun e => reduceModEqOfLtV3 e

-- set_option trace.Debug.Meta.Tactic.simp true in
set_option trace.debug true in
theorem eg₁ (x : BitVec w) : x.toNat % 2^w = x.toNat + 0:= by
  simp

/-- info: 'eg₁' depends on axioms: [propext] -/
#guard_msgs in #print axioms eg₁

theorem eg₂ (x y : BitVec w)  (h : x.toNat + y.toNat < 2^w) :
  (x + y).toNat = x.toNat + y.toNat := by
  simp

/-- info: 'eg₂' depends on axioms: [propext, Quot.sound] -/
#guard_msgs in #print axioms eg₂

theorem eg₃ (x y : BitVec w) :
  (x + y).toNat = (x.toNat + y.toNat) % 2 ^ w := by
  simp

/-- info: 'eg₂' depends on axioms: [propext, Quot.sound] -/
#guard_msgs in #print axioms eg₂

theorem eg₄ (x y z : BitVec w)
  (h₂ : y.toNat + z.toNat < 2^w)
  (h : x.toNat * (y.toNat + z.toNat) < 2^w) :
  (x * (y + z)).toNat = x.toNat * (y.toNat + z.toNat) := by
  simp

/-- info: 'eg₄' depends on axioms: [propext, Quot.sound] -/
#guard_msgs in #print axioms eg₄
