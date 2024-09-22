/-
Copyright (c) 2023 Lean FRO, LLC. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Siddharth Bhat, Tobias Groser
-/
import Lean
open Lean Meta Elab Simp

theorem Nat.mod_eq_sub {x y : Nat} (h : x ≥ y) (h' : x - y < y) :
    x % y = x - y := by
  rw [Nat.mod_eq_sub_mod h]
  rw [Nat.mod_eq_of_lt h']

@[inline] def reduceModEqOfLt (e : Expr) : SimpM Step := do
  match_expr e with
  | HMod.hMod xTy nTy outTy  _inst x n =>
    let natTy := mkConst ``Nat
    if (xTy != natTy) || (nTy != natTy) || (outTy != natTy) then
     return .continue
    let instLtNat := mkConst ``instLTNat
    let ltTy := mkAppN (mkConst ``LT.lt [levelZero]) #[natTy, instLtNat, x, n]
    let ltProof : Expr ← mkFreshExprMVar ltTy
    let ltProofMVar := ltProof.mvarId!
    let some g ← ltProofMVar.falseOrByContra
      | return .continue
    try
      g.withContext (do
         let hyps := (← getLocalHyps).toList
         Lean.Elab.Tactic.Omega.omega hyps g {})
      let eqProof ← mkAppM ``Nat.mod_eq_of_lt #[ltProof]
      return .done { expr := x, proof? := eqProof : Result }
    catch _ =>
      return .continue
  | _ => do
     return .continue

simproc↑ reduce_mod_eq_of_lt (_ % _) := fun e => reduceModEqOfLt e

@[inline] def reduceModEqSub (e : Expr) : SimpM Step := do
  match_expr e with
  | HMod.hMod xTy nTy outTy  _inst x n =>
    let natTy := mkConst ``Nat
    if (xTy != natTy) || (nTy != natTy) || (outTy != natTy) then
      return .continue
    let instLENat := mkConst ``instLENat
    let geTy := mkAppN (mkConst ``GE.ge [levelZero]) #[natTy, instLENat, x, n]
    let geProof : Expr ← mkFreshExprMVar geTy
    let geProofMVar := geProof.mvarId!
    let some gLe ← geProofMVar.falseOrByContra
      | return .continue
    try
      gLe.withContext (do
         let hyps := (← getLocalHyps).toList
         Lean.Elab.Tactic.Omega.omega hyps gLe {})
      let instHSub := mkAppN (mkConst ``instHSub [levelZero]) #[natTy, mkConst ``instSubNat]
      let subTy := mkAppN (mkConst ``HSub.hSub [levelZero, levelZero, levelZero])
        #[natTy, natTy, natTy, instHSub, x, n]
      let instLtNat := mkConst ``instLTNat
      let ltTy := mkAppN (mkConst ``LT.lt [levelZero]) #[natTy, instLtNat, subTy, n]
      let ltProof : Expr ← mkFreshExprMVar ltTy
      let ltProofMVar := ltProof.mvarId!
      let some gLt ← ltProofMVar.falseOrByContra
        | return .continue
      gLt.withContext (do
         let hyps := (← getLocalHyps).toList
         Lean.Elab.Tactic.Omega.omega hyps gLt {})
      let eqProof ← mkAppM ``Nat.mod_eq_sub #[geProof, ltProof]
      return .done { expr := subTy, proof? := eqProof : Result }
    catch _ =>
      return .continue
  | _ => do
     return .continue

simproc↑ reduce_mod_eq_sub (_ % _) := fun e => reduceModEqSub e

theorem eg₁ (x : BitVec w) : x.toNat % 2 ^ w = x.toNat + 0:= by
  simp

/-- info: 'eg₁' depends on axioms: [propext] -/
#guard_msgs in #print axioms eg₁

theorem eg₂ (x y : BitVec w)  (h : x.toNat + y.toNat < 2 ^ w) :
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
  (h₂ : y.toNat + z.toNat < 2 ^ w)
  (h : x.toNat * (y.toNat + z.toNat) < 2 ^ w) :
  (x * (y + z)).toNat = x.toNat * (y.toNat + z.toNat) := by
  simp

/-- info: 'eg₄' depends on axioms: [propext, Quot.sound] -/
#guard_msgs in #print axioms eg₄

theorem eg₅ (x y : BitVec w) (h : x.toNat + y.toNat ≥ 2 ^ w) (h' : (x.toNat + y.toNat) - 2 ^ w < 2 ^ w) :
  (x + y).toNat = x.toNat + y.toNat - 2 ^ w := by
  simp
