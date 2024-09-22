/-
Copyright (c) 2023 Tobias Grosser, Siddharth Bhat. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Siddharth Bhat, Tobias Grosser
-/
import Lean

open Lean Meta Elab Simp

theorem Nat.mod_eq_sub {x y : Nat} (h : x ≥ y) (h' : x - y < y) :
    x % y = x - y := by
  rw [Nat.mod_eq_sub_mod h]
  rw [Nat.mod_eq_of_lt h']

private def mkLTNat (x y : Expr) : Expr :=
  mkAppN (.const ``LT.lt [levelZero]) #[mkConst ``Nat, mkConst ``instLTNat, x, y]

private def mkLENat (x y : Expr) : Expr :=
  mkAppN (.const ``LE.le [levelZero]) #[mkConst ``Nat, mkConst ``instLENat, x, y]

private def mkGENat (x y : Expr) : Expr := mkLENat y x

private def mkSubNat (x y : Expr) : Expr :=
  let lz := levelZero
  let nat := mkConst ``Nat
  let instSub := mkConst ``instSubNat
  let instHSub := mkAppN (mkConst ``instHSub [lz]) #[nat, instSub]
  mkAppN (mkConst ``HSub.hSub [lz, lz, lz]) #[nat, nat, nat, instHSub, x, y]

@[inline] def proofOmega (ty : Expr) : SimpM Step := do
  let proof : Expr ← mkFreshExprMVar ty
  let proofMVar := proof.mvarId!
  let some g ← proofMVar.falseOrByContra
    | return .continue
  try
    g.withContext (Lean.Elab.Tactic.Omega.omega (← getLocalHyps).toList g {})
  catch _ =>
    return .continue
  return .done { expr := ty, proof? := proof }

-- x % n = x if x < n
@[inline] def reduceModOfLt (x : Expr) (n : Expr) : SimpM Step := do
  let ltTy := mkLTNat x n
  let Step.done { expr := _, proof? := some p} ← proofOmega ltTy
    | return .continue
  let eqProof ← mkAppM ``Nat.mod_eq_of_lt #[p]
  return .done { expr := x, proof? := eqProof : Result }

-- x % n = x - n if x >= n and x - n < n
@[inline] def reduceModSub (x : Expr) (n : Expr) : SimpM Step := do
  let geTy := mkGENat x n
  let Step.done { expr := _, proof? := some geProof} ← proofOmega geTy
    | return .continue
  let subTy := mkSubNat x n
  let ltTy := mkLTNat subTy n
  let Step.done { expr := _, proof? := some ltProof} ← proofOmega ltTy
    | return .continue
  let eqProof ← mkAppM ``Nat.mod_eq_sub #[geProof, ltProof]
  return .done { expr := subTy, proof? := eqProof : Result }

@[inline] def reduceMod (e : Expr) : SimpM Step := do
  match_expr e with
  | HMod.hMod xTy nTy outTy  _inst x n =>
    let natTy := mkConst ``Nat
    if (xTy != natTy) || (nTy != natTy) || (outTy != natTy) then
      return .continue
    if let .done res ← reduceModOfLt x n then
      return .done res
    if let .done res ← reduceModSub x n then
      return .done res
    return .continue
  | _ => do
     return .continue

simproc↑ reduce_mod_omega (_ % _) := fun e => reduceMod e

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

/-- info: 'eg₅' depends on axioms: [propext, Quot.sound] -/
#guard_msgs in #print axioms eg₅
