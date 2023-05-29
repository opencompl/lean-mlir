import Mathlib.RingTheory.Polynomial.Quotient
import Mathlib.Data.Zmod.Basic
import SSA.Core.WellTypedFramework

open Polynomial -- for R[X] notation

-- variable {q : ℤ} [Fact (q > 1)] {n : Nat}
-- def qZ : Ideal ℤ := Ideal.span {q}
-- def R := (ℤ ⧸ @qZ q) -- is there a way to avoid explicitly passing q here?
variable (q : Nat) [Fact (q > 1)] (n : Nat)
def R := ZMod q
instance : CommRing (R q) := inferInstanceAs (CommRing (ZMod q))

-- TODO: can we make this computable?
-- failed to compile definition, consider marking it as 'noncomputable' because it depends on 'Polynomial.add'', and it does not have executable code
noncomputable def f : (R q)[X] := X^n + 1
def R' := (@R q)[X] ⧸ (Ideal.span {f q n})
-- it's strange that Lean won't figure out these instances...
noncomputable instance : CommRing (R' q n) := inferInstanceAs (CommRing ((R q)[X] ⧸ (Ideal.span {f q n})))

inductive BaseType
  | nat : BaseType
  | poly (q : Nat) (n : Nat) (_ : q > 1) : BaseType
  deriving DecidableEq

instance : Inhabited BaseType := ⟨BaseType.nat⟩

instance : Goedel BaseType where
toType := fun
  | .nat => Nat
  | .poly q n _ => (R' q n)

abbrev UserType := SSA.UserType BaseType

-- See: https://releases.llvm.org/14.0.0/docs/LangRef.html#bitwise-binary-operations
inductive Op
| add : Op
| add_poly {q : Nat} {n : Nat} {_ : q > 1} : Op
deriving Repr, DecidableEq

@[simp, reducible]
def argUserType : Op → UserType
| Op.add => .pair (.base BaseType.nat) (.base BaseType.nat)
| @Op.add_poly q n h => .pair (.base $ BaseType.poly q n h) (.base $ BaseType.poly q n h)

@[simp, reducible]
def outUserType : Op → UserType
| Op.add => .base BaseType.nat
| @Op.add_poly q n h => .base $ BaseType.poly q n h

@[simp]
def rgnDom : Op → UserType := fun _ => .unit
@[simp]
def rgnCod : Op → UserType := fun _ => .unit

variable (a b : R' q n)

@[simp]
noncomputable def eval (o : Op)
  (arg: Goedel.toType (argUserType o))
  (_rgn : (Goedel.toType (rgnDom o) → Goedel.toType (rgnCod o))) :
  Goedel.toType (outUserType o) :=
    match o with
    | Op.add => (fun args : Nat × Nat => args.1 + args.2) arg
    | @Op.add_poly q n _ => (fun args : (R' q n) × (R' q n) => args.1 + args.2) arg
  