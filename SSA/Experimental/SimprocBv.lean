import Lean
open Lean Meta Elab Simp

/-! # V0 -/

/-- We need this to be a `post` procedure, so that we can e.g.
simplify `((2 % 16 + 4 % 16) % 16)` to collapse leaf-first:
[((2 % 16 + 4 % 16) % 16)]
-> ([(2 % 16 + 4 % 16)] % 16)
-> (([2 % 16] + 4 % 16) % 16)
-> (([2] + 4 % 16) % 16)
-> ((2 + [4 % 16]) % 16)
-> ((2 + [4]) % 16)
-> [((2 + 4) % 16)]
-> [(6 % 16)]

-/
@[inline] def reduceModEqOfLtV0 (e : Expr) : SimpM Step := do
  match_expr e with
  | _ => do
     trace[debug] "modEqOfLt: '{toString e}' | {e}"
     return .done { expr := e  : Result }
simproc↑ reduce_mod_eq_of_lt_v0 (_ % _) := fun e => reduceModEqOfLtV0 e

-- set_option trace.Debug.Meta.Tactic.simp true in
set_option trace.debug true in
example (x : BitVec w) : x.toNat % 2^w = x.toNat + 100:= by
  simp only [reduce_mod_eq_of_lt_v0]
  sorry

/-! # V1 -/

@[inline] def reduceModEqOfLtV1 (e : Expr) : SimpM Step := do
  match_expr e with
  | HMod.hMod _nat _nat _nat  _inst x n =>
     trace[debug] "modEqOfLt: '{x}' % '{n}'"
     return .done { expr := e  : Result }
  | _ => do
     trace[debug] "no match: '{toString e}'"
     return .done { expr := e  : Result }
simproc↑ reduce_mod_eq_of_lt_v1 (_ % _) := fun e => reduceModEqOfLtV1 e

-- set_option trace.Debug.Meta.Tactic.simp true in
set_option trace.debug true in
example (x : BitVec w) : x.toNat % 2^w = x.toNat + 100:= by
  simp only [reduce_mod_eq_of_lt_v1]
  sorry

/-! # V2 -/

@[inline] def reduceModEqOfLtV2 (e : Expr) : SimpM Step := do
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
     return .done { expr := e  : Result }
  | _ => do
     trace[debug] "no match: '{toString e}'"
     return .done { expr := e  : Result }
simproc↑ reduce_mod_eq_of_lt_v2 (_ % _) := fun e => reduceModEqOfLtV2 e

set_option trace.debug true in
example (x : BitVec w) : (x.toNat : Int) % 2^w = x.toNat + 100:= by
  simp only [reduce_mod_eq_of_lt_v2]
  sorry

-- set_option trace.Debug.Meta.Tactic.simp true in
set_option trace.debug true in
example (x : BitVec w) : x.toNat % 2^w = x.toNat + 100:= by
  simp only [reduce_mod_eq_of_lt_v2]
  sorry

/-! # V3 -/

-- /-- info: Nat.mod_eq_of_lt {a b : Nat} (h : a < b) : a % b = a -/
set_option pp.all true in
/-
⊢ ∀ {a b : Nat},
  @LT.lt.{0} Nat instLTNat a b → @Eq.{1} Nat (@HMod.hMod.{0, 0, 0} Nat Nat Nat (@instHMod.{0} Nat Nat.instMod) a b) a
-/
#check Nat.mod_eq_of_lt

/-- info: Lean.Meta.mkAppM (constName : Name) (xs : Array Expr) : MetaM Expr -/
#guard_msgs in #check mkAppM

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
     let proofTy := mkAppN (mkConst ``LT.lt [levelZero]) #[natTy, instLtNat, x, n] -- LT.lt Nat Nat
     let h : Expr ← mkSorry proofTy true
     let proof ← mkAppM ``Nat.mod_eq_of_lt #[h]
    --  trace[debug] "h: '{h}'"
     trace[debug] "proof: {proof}"
     return .done { expr := x, proof? := proof : Result }
  | _ => do
     trace[debug] "no match: '{toString e}'"
     return .done { expr := e  : Result }
simproc↑ reduce_mod_eq_of_lt_v3 (_ % _) := fun e => reduceModEqOfLtV3 e


-- set_option trace.Debug.Meta.Tactic.simp true in
set_option trace.debug true in
example (x : BitVec w) : x.toNat % 2^w = x.toNat + 0:= by
  simp only [reduce_mod_eq_of_lt_v3]
  rfl
