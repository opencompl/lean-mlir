/-
Copyright (c) 2023 Lean FRO, LLC. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Siddharth Bhat, Tobias Groser
-/
import Lean
open Lean Meta Elab Simp

@[inline] def reduceModEqOfLt (e : Expr) : SimpM Step := do
  match_expr e with
  | HMod.hMod xTy nTy outTy  _inst x n =>
     let natTy := mkConst ``Nat
     if xTy != natTy then
       return .visit { expr := e }
     if nTy != natTy then
       return .visit { expr := e }
     if outTy != natTy then
       return .visit { expr := e }
     let instLtNat := mkConst ``instLTNat
     let ltTy := mkAppN (mkConst ``LT.lt [levelZero]) #[natTy, instLtNat, x, n]
     let ltProof : Expr ← mkFreshExprMVar ltTy
     let ltProofMVar := ltProof.mvarId!
     let some g ← ltProofMVar.falseOrByContra
       | return .visit { expr := e }
     try
       g.withContext (do
          let hyps := (← getLocalHyps).toList
          Lean.Elab.Tactic.Omega.omega hyps g {})
       let eqProof ← mkAppM ``Nat.mod_eq_of_lt #[ltProof]
       return .done { expr := x, proof? := eqProof : Result }
     catch _ =>
       return .visit { expr := e }
  | _ => do
     return .visit { expr := e : Result }

simproc↑ reduce_mod_eq_of_lt (_ % _) := fun e => reduceModEqOfLt e

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
