import Mathlib.RingTheory.Polynomial.Quotient
import Mathlib.Data.Zmod.Basic
import SSA.Core.WellTypedFramework

open Polynomial -- for R[X] notation

-- Basics from Junfeng Fan and Frederik Vercauteren, Somewhat Practical Fully Homomorphic Encryption
-- https://eprint.iacr.org/2012/144

variable (q t : Nat) [Fact (q > 1)] (n : Nat)

-- TODO: can we make this computable?
-- failed to compile definition, consider marking it as 'noncomputable' because it depends on 'Polynomial.add'', and it does not have executable code

-- Question: Can we make something like d := 2^n work as a macro?
noncomputable def f : (ZMod q)[X] := X^(2^n) + 1
abbrev R := (ZMod q)[X] ⧸ (Ideal.span {f q n})

-- Coefficients of `a : R' q n` are `a\_i : Zmod q`.
-- TODO: get this from mathlib
def R.coeff (a : R q n) (i : Nat) : ZMod q := sorry



-- TODO: get infinity norm from mathlib
--
--

namespace FV
namespace SH

def Delta : Nat := sorry -- (q.toFloat / t.toFloat).floor
def encrypt (pk : R q n) (m : Nat) : R q n := sorry -- ([p0 ·u+e1 +∆·m] ,[p1 ·u+e2])
def decrypt (sk : R q n) (ct : R q n) : Nat := sorry -- [ (t·[c0 +c1 ·s]q / q).ceil ]t
def add (ct1 ct2 : R q n) : R q n := sorry -- ([ct1 [0] + ct2 [0]]q , [ct1 [1] + ct2 [1]]q ) .

end SH
end FV

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
| add : Op
| add_poly (q : Nat) (n : Nat) : Op
| const : Nat → Op 
| const_poly : R q n → Op
| encrypt : Op
| decrypt : Op
--deriving Repr, DecidableEq

@[simp, reducible]
def argUserType : Op q n  → UserType
| Op.add => .pair (.base BaseType.nat) (.base BaseType.nat)
| Op.add_poly q n => .pair (.base $ BaseType.poly q n) (.base $ BaseType.poly q n)
| Op.const _ => .unit
| Op.const_poly _ => .unit
| Op.encrypt => .base $ BaseType.nat
| Op.decrypt => .base $ BaseType.poly q n 

@[simp, reducible]
def outUserType : Op q n → UserType
| Op.add => .base BaseType.nat
| Op.add_poly q n => .base $ BaseType.poly q n
| Op.const _ => .base BaseType.nat
| Op.const_poly _ => .base $ BaseType.poly q n
| Op.encrypt => .base $ BaseType.poly q n
| Op.decrypt => .base BaseType.nat

@[simp]
def rgnDom : Op q n → UserType := fun _ => .unit
@[simp]
def rgnCod : Op q n → UserType := fun _ => .unit

variable (a b : R q n)

@[simp]
noncomputable def eval (o : Op q n)
  (arg: Goedel.toType (argUserType q n o))
  (_rgn : (Goedel.toType (rgnDom q n o) → Goedel.toType (rgnCod q n o))) :
  Goedel.toType (outUserType q n o) :=
    match o with
    | Op.add => (fun args : Nat × Nat => args.1 + args.2) arg
    | Op.add_poly q n => (fun args : (R q n) × (R q n) => args.1 + args.2) arg
    | Op.const n => n
    | Op.const_poly a => a
    | Op.encrypt => sorry
    | Op.decrypt => sorry
