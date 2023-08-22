import Mathlib.RingTheory.Polynomial.Quotient
import Mathlib.RingTheory.Ideal.Quotient
import Mathlib.Data.Zmod.Basic
import SSA.Core.WellTypedFramework
-- https://github.com/google/heir/blob/a18d4e8ddc0031e2a0e6dd2dd0d7fe289b9d1651/include/Dialect/Poly/IR/PolyDialect.td
-- https://github.com/j2kun/heir/blob/5c5c0e2ff2ae37a7d1ec5791ec6c38046c4115c1/include/Dialect/Poly/IR/PolyOps.td
-- https://github.com/google/heir/blob/a18d4e8ddc0031e2a0e6dd2dd0d7fe289b9d1651/tests/poly/poly_ops.mlir

open Polynomial -- for R[X] notation


-- Basics from Junfeng Fan and Frederik Vercauteren, Somewhat Practical Fully Homomorphic Encryption
-- https://eprint.iacr.org/2012/144
variable (q t : Nat) [Fact (q > 1)] (n : Nat)

-- Can we make this computable?
-- see: https://leanprover.zulipchat.com/#narrow/stream/113488-general/topic/Way.20to.20recover.20computability.3F/near/322382109
-- and :https://leanprover.zulipchat.com/#narrow/stream/113488-general/topic/Groebner.20bases

-- Question: Can we make something like d := 2^n work as a macro?
--

noncomputable def f : (ZMod q)[X] := X^(2^n) + 1
abbrev R := (ZMod q)[X] ⧸ (Ideal.span {f q n})
-- Coefficients of `a : R' q n` are `a\_i : Zmod q`.
-- TODO: get this from mathlib

-- Canonical epimorphism `ZMod q[X] ->*+ R q n`
abbrev R.fromPoly {q n : Nat} : (ZMod q)[X] → R q n := Ideal.Quotient.mk (Ideal.span {f q n})

noncomputable abbrev R.zero {q n : Nat} : R q n := R.fromPoly 0
noncomputable abbrev R.one {q n : Nat} : R q n := R.fromPoly 1

noncomputable instance {q n : Nat} : Zero (R q n) := ⟨R.zero⟩
noncomputable instance {q n : Nat} : One (R q n) := ⟨R.one⟩

axiom R.representative {q n} : R q n → (ZMod q)[X]
--axiom R.canonicalRep_fromPoly_eq {q n} : forall a : R q n, (R.fromPoly (R.representative a)) = a


noncomputable def R.coeff (a : R q n) (i : Nat) : Nat := 
  let zmodCoef := Polynomial.coeff a.representative i 
  zmodCoef.val

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

-- See: https://releases.llvm.org/14.0.0/docs/LangRef.html#bitwise-binary-operations
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
| Op.add q n => .pair (.base $ BaseType.poly q n) (.base $ BaseType.poly q n)
| Op.sub q n => .pair (.base $ BaseType.poly q n) (.base $ BaseType.poly q n)
| Op.mul q n => .pair (.base $ BaseType.poly q n) (.base $ BaseType.poly q n)
| Op.mul_constant q n _ => (.base $ BaseType.poly q n)
| Op.get_coeff q n => .pair (.base $ BaseType.poly q n) (.base  .nat)
| Op.extract_slice q n => .pair (.base $ BaseType.poly q n) (.pair (.base  .nat) (.base  .nat))

@[simp, reducible]
def outUserType : Op → UserType
| Op.add q n => .base $ BaseType.poly q n
| Op.sub q n => .base $ BaseType.poly q n
| Op.mul q n => .base $ BaseType.poly q n
| Op.mul_constant q n _ => .base $ BaseType.poly q n
| Op.get_coeff _ _ => .base  .nat
| Op.extract_slice q n => .base $ BaseType.poly q n


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
    | Op.get_coeff q n => (fun args : R q n × Nat => args.1.coeff args.2) arg
    -- sum of get_coeff i * X^i
    | Op.extract_slice q n => (fun args : R q n × Nat × Nat => 
      -- let (a, i, j) := args
      -- let coeffIdxs := List.range (j - i + 1)
      -- let coeffs := coeffIdxs.map (fun k => a.coeff (i + k))
      -- coeffs.zip coeffIdxs
      --  |>.foldl (fun acc (c,i) => acc + (R.fromPoly (monomial i ↑c))) R.zero) arg
      sorry

