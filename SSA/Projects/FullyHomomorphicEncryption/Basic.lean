/-
This file contains the definition of the MLIR `Poly` dialect as implemented in HEIR, see:
https://github.com/google/heir/blob/a18d4e8ddc0031e2a0e6dd2dd0d7fe289b9d1651/include/Dialect/Poly/IR/PolyDialect.td
https://github.com/j2kun/heir/blob/5c5c0e2ff2ae37a7d1ec5791ec6c38046c4115c1/include/Dialect/Poly/IR/PolyOps.td
https://github.com/google/heir/blob/a18d4e8ddc0031e2a0e6dd2dd0d7fe289b9d1651/tests/poly/poly_ops.mlir

This dialect describes operations on equivalence classes of polynomials in ℤ/qℤ[X]/(X^(2^n) + 1).
For the rationale behind this, see:
 Junfeng Fan and Frederik Vercauteren, Somewhat Practical Fully Homomorphic Encryption
https://eprint.iacr.org/2012/144

-/
import Mathlib.RingTheory.Polynomial.Quotient
import Mathlib.RingTheory.Ideal.Quotient
import Mathlib.Data.Zmod.Basic
import SSA.Core.WellTypedFramework

open Polynomial -- for R[X] notation

/-
We assume tat `q > 1` is a natural number (not necessarily a prime) and `n` is a natural number.
We will use these to build `ℤ/qℤ[X]/(X^(2^n) + 1)`
-/
variable (q t : Nat) [Fact (q > 1)] (n : Nat)

-- Can we make this computable?
-- see: https://leanprover.zulipchat.com/#narrow/stream/113488-general/topic/Way.20to.20recover.20computability.3F/near/322382109
-- and :https://leanprover.zulipchat.com/#narrow/stream/113488-general/topic/Groebner.20bases

-- Question: Can we make something like d := 2^n work as a macro?
--

noncomputable def f : (ZMod q)[X] := X^(2^n) + 1

/--
The basic ring of interest in this dialect is `R q n` which corresponds to
the ring `ℤ/qℤ[X]/(X^(2^n) + 1)`.
-/
abbrev R := (ZMod q)[X] ⧸ (Ideal.span {f q n})
-- Coefficients of `a : R' q n` are `a\_i : Zmod q`.
-- TODO: get this from mathlib

/-- Canonical epimorphism `ZMod q[X] ->*+ R q n` -/
abbrev R.fromPoly {q n : Nat} : (ZMod q)[X] → R q n := Ideal.Quotient.mk (Ideal.span {f q n})

noncomputable abbrev R.zero {q n : Nat} : R q n := R.fromPoly 0
noncomputable abbrev R.one {q n : Nat} : R q n := R.fromPoly 1

noncomputable instance {q n : Nat} : Zero (R q n) := ⟨R.zero⟩
noncomputable instance {q n : Nat} : One (R q n) := ⟨R.one⟩

/--
The representative of `a : R q n` is the (unique) polynomial `p : ZMod q[X]` of degree `< 2^n`
 such that `R.fromPoly p = a`.
 TODO: replace these axioms with the proper definition and prove the two characterizations.
-/
axiom R.representative {q n} : R q n → (ZMod q)[X]

/--
`R.representative` is in fact a representative of the equivalence class.
-/
axiom R.rep_fromPoly_eq {q n} : forall a : R q n, (R.fromPoly (n:=n) (R.representative a)) = a
/--
The representative of `a : R q n` is the (unique) reperesntative with degree `< 2^n`.
-/
axiom R.rep_degree_lt_n {q n} : forall a : R q n, (R.representative a).degree < 2^n

/--
This function gets the `i`th coefficient of the polynomial representative 
(with degree `< 2^n`) of an element `a : R q n`. Note that this is not 
invariant under the choice of representative.
-/
noncomputable def R.coeff (a : R q n) (i : Nat) : ZMod q := 
  Polynomial.coeff a.representative i 

/--
`R.monomial i c` is the equivalence class of the monomial `c * X^i` in `R q n`.
-/
noncomputable def R.monomial {q n : Nat} (i : Nat) (c : ZMod q) : R q n :=
  R.fromPoly (Polynomial.monomial i c)

/--
Given an equivalence class of polynomials `a : R q n` with representative 
`p = p_0 + p_1 X + ... + p_{2^n - 1} X^{2^n - 1}`, `R.slice a startIdx endIdx` yields
the equivalence class of the polynomial 
`p_{startIdx}*X^{startIdx} + p_{startIdx + 1} X^{startIdx + 1} + ... + p_{endIdx - 1} X^{endIdx - 1}`
 Note that this is not invariant under the choice of representative.
-/
noncomputable def R.slice {q n : Nat} (a : R q n) (startIdx endIdx : Nat) : R q n :=
  let coeffIdxs := List.range (endIdx - startIdx)
  let coeffs := coeffIdxs.map (fun i => a.coeff (startIdx + i))
  let accum : R q n → (ZMod q × Nat) → R q n :=
    fun poly (c,i) => poly + R.monomial (n:=n) i c
  coeffs.zip coeffIdxs |>.foldl accum R.zero

/--
We define the base type of the representation, which encodes both natural numbers 
and elements in the ring `R q n` (which in FHE are sometimes called 'polynomials'
 in allusion to `R.representative`).
-/
inductive BaseType
  | nat : BaseType
  | poly (q : Nat) (n : Nat) : BaseType
  deriving DecidableEq

instance : Inhabited BaseType := ⟨BaseType.nat⟩
instance : Goedel BaseType where
toType := fun
  | .nat => Nat
  | .poly q n => (R q n)

abbrev UserType := SSA.UserType BaseType

/--
The operation type of the `Poly` dialect. Operations are parametrized by the 
two parameters `p` and `n` that characterize the ring `R q n`.
-/
inductive Op
| add (q : Nat) (n : Nat) : Op
| sub (q : Nat) (n : Nat) : Op
| mul (q : Nat) (n : Nat) : Op
| mul_constant (q : Nat) (n : Nat) (c : R q n) : Op
| get_coeff (q : Nat) (n : Nat) : Op
| extract_slice (q : Nat) (n : Nat) : Op
--deriving DecidableEq --, Repr

@[simp, reducible]
def argUserType : Op  → UserType
| Op.add q n => .pair (.base <| BaseType.poly q n) (.base <| BaseType.poly q n)
| Op.sub q n => .pair (.base <| BaseType.poly q n) (.base <| BaseType.poly q n)
| Op.mul q n => .pair (.base <| BaseType.poly q n) (.base <| BaseType.poly q n)
| Op.mul_constant q n _ => (.base <| BaseType.poly q n)
| Op.get_coeff q n => .pair (.base <| BaseType.poly q n) (.base  .nat)
| Op.extract_slice q n => .pair (.base <| BaseType.poly q n) (.pair (.base  .nat) (.base  .nat))

@[simp, reducible]
def outUserType : Op → UserType
| Op.add q n => .base <| BaseType.poly q n
| Op.sub q n => .base <| BaseType.poly q n
| Op.mul q n => .base <| BaseType.poly q n
| Op.mul_constant q n _ => .base <| BaseType.poly q n
| Op.get_coeff _ _ => .base  .nat
| Op.extract_slice q n => .base <| BaseType.poly q n

@[simp]
def rgnDom : Op → UserType := fun _ => .unit
@[simp]
def rgnCod : Op → UserType := fun _ => .unit

variable (a b : R q n)
@[simp]
noncomputable def eval (o : Op)
  (arg: Goedel.toType (argUserType o))
  (_rgn : (Goedel.toType (rgnDom o) → Goedel.toType (rgnCod o))) :
  Goedel.toType (outUserType o) :=
    match o with
    | Op.add q n => (fun args : R q n × R q n => args.1 + args.2) arg
    | Op.sub q n => (fun args : R q n × R q n => args.1 - args.2) arg
    | Op.mul q n => (fun args : R q n × R q n => args.1 * args.2) arg
    | Op.mul_constant q n c => (fun arg : R q n => arg * c) arg
    | Op.get_coeff q n => (fun args : R q n × Nat => args.1.coeff args.2) arg |>.val
    | Op.extract_slice _ _ => (fun (a,i,c) => R.slice a i c) arg