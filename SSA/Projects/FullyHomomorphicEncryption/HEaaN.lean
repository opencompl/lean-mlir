import SSA.Core.WellTypedFramework
import SSA.Projects.FullyHomomorphicEncryption.Basic
import Mathlib.Data.Vector.Zip
import Mathlib.Data.Matrix.Basic

/-- Scalar integer type? -/
abbrev Pty := Nat

instance : DecidableEq Pty := inferInstanceAs (DecidableEq Nat)
instance : Inhabited Pty := inferInstanceAs (Inhabited Nat)

/-- Base type for the number of moduli (in RNS). It can be a concrete value,
unknown at compile time, or one of two predefined constants: `encmax` and
`keyswitch`. -/
inductive Nm
| nat : Nat → Nm
| encmax : Nm
| keyswitch : Nm
| unknown : Nm
deriving DecidableEq, Inhabited

/-- Not sure what this is for. -/
inductive Np
| nat : Nat → Np
| unknown : Np
deriving DecidableEq, Inhabited

def Np.toNat : Np → Nat
  | Np.nat n => n
  | Np.unknown => panic! "using unknown value"

instance : Coe Np Nat := ⟨Np.toNat⟩

namespace ModArith

inductive BaseType
| tensor1 : Np → Pty → BaseType
| tensor2 : Np → Np → Pty → BaseType
| tensor3 : Np → Np → Np → Pty → BaseType
deriving DecidableEq, Inhabited

-- I don't understand what Pty does
instance : Goedel BaseType where
toType := fun
  | .tensor1 n _ => Vector ℤ ↑n
  | .tensor2 n1 n2 _ => Matrix (Fin ↑n1) (Fin ↑n2) ℤ
  | .tensor3 n1 n2 n3 _ => Fin ↑n1 → Fin ↑n2 → Fin ↑n3 → ℤ

def Vector.add {n : Nat} : Vector ℤ n → Vector ℤ n → Vector ℤ n
  | v1, v2 => v1.zipWith Int.add v2

def Vector.sub {n : Nat} : Vector ℤ n → Vector ℤ n → Vector ℤ n
  | v1, v2 => v1.zipWith Int.sub v2

def Vector.dot {n : Nat} : Vector ℤ n → Vector ℤ n → ℤ
  | v1, v2 => (v1.zipWith Int.mul v2).val.foldl Int.add 0

def Vector.negate {n : Nat} : Vector ℤ n → Vector ℤ n
  | v => v.map (-·)



/--
The basic operation type for the HEaaN.MLIR ModArith dialect.
The basic operations are `add`, `sub`, `negate`, `inverse`, `dot`, `dot_flattened_barr`,
`haddamard_mult`, `matmul_barr`, and `mult_rows_barr`.

The paper defines each of these `op`s as an individual `op` that takes
parameters of different types and is undefined if the types don't match.
We could define our types to be something like `Option (tensor1 ⊕ tensor2 ⊕ tensor3)`
This would just get in the way, so we define three variants instead.

Mutual inductives could work as well.-/
inductive Op
| add1 {n1 : Np} {p1 : Pty} : Op
| add2 {n1 n2 : Np} {p1 : Pty} : Op
| add3 {n1 n2 n3 : Np} {p1 : Pty} : Op
| sub1 {n1 : Np} {p1 : Pty} : Op
| sub2 {n1 n2 : Np} {p1 : Pty} : Op
| sub3 {n1 n2 n3 : Np} {p1 : Pty} : Op
| negate1 {n1 : Np} {p1 : Pty} : Op
| negate2 {n1 n2 : Np} {p1 : Pty} : Op
| negate3 {n1 n2 n3 : Np} {p1 : Pty} : Op
| inverse2 {n1 n2 : Np} {p1 : Pty} : Op
| inverse3 {n1 n2 n3 : Np} {p1 : Pty} : Op
| dot1 {n1 : Np} {p1 : Pty} : Op
| dot2 {n1 n2 : Np} {p1 : Pty} : Op
| dot3 {n1 n2 n3 : Np} {p1 : Pty} : Op
| dot_flattened_barr1 {n1 : Np} {p1 : Pty} : Op
| dot_flattened_barr2 {n1 n2 : Np} {p1 : Pty} : Op
| dot_flattened_barr3 {n1 n2 n3 : Np} {p1 : Pty} : Op
| haddamard_mult1 {n1 : Np} {p1 : Pty} : Op
| haddamard_mult2 {n1 n2 : Np} {p1 : Pty} : Op
| haddamard_mult3 {n1 n2 n3 : Np} {p1 : Pty} : Op
| matmul_barr1 {n1 : Np} {p1 : Pty} : Op
| matmul_barr2 {n1 n2 : Np} {p1 : Pty} : Op
| matmul_barr3 {n1 n2 n3 : Np} {p1 : Pty} : Op
| mult_rows_barr1 {n1 : Np} {p1 : Pty} : Op
| mult_rows_barr2 {n1 n2 : Np} {p1 : Pty} : Op
| mult_rows_barr3 {n1 n2 n3 : Np} {p1 : Pty} : Op
deriving DecidableEq, Inhabited


abbrev UserType := SSA.UserType BaseType

@[simp, reducible]
def argUserType : Op → UserType
| @Op.add1 n1 p1 | @Op.sub1 n1 p1 | @Op.dot1 n1 p1 | @Op.dot_flattened_barr1 n1 p1
  | @Op.haddamard_mult1 n1 p1 | @Op.matmul_barr1 n1 p1 | @Op.mult_rows_barr1 n1 p1 =>
  .pair (.base (BaseType.tensor1 n1 p1)) (.base (BaseType.tensor1 n1 p1))
| @Op.negate1 n1 p1 | @Op.inverse1 n1 p1 =>
  .base (BaseType.tensor1 n1 p1)
| @Op.add2 n1 n2 p1 | @Op.sub2 n1 n2 p1 | @Op.dot2 n1 n2 p1 | @Op.dot_flattened_barr2 n1 n2 p1
  | @Op.haddamard_mult2 n1 n2 p1 | @Op.matmul_barr2 n1 n2 p1 | @Op.mult_rows_barr2 n1 n2 p1 =>
  .pair (.base (BaseType.tensor2 n1 n2 p1)) (.base (BaseType.tensor2 n1 n2 p1))
| @Op.negate2 n1 n2 p1 | @Op.inverse2 n1 n2 p1 =>
  .base (BaseType.tensor2 n1 n2 p1)
| @Op.add3 n1 n2 n3 p1 | @Op.sub3 n1 n2 n3 p1 | @Op.dot3 n1 n2 n3 p1 | @Op.dot_flattened_barr3 n1 n2 n3 p1
  | @Op.haddamard_mult3 n1 n2 n3 p1 | @Op.matmul_barr3 n1 n2 n3 p1 | @Op.mult_rows_barr3 n1 n2 n3 p1 =>
  .pair (.base (BaseType.tensor3 n1 n2 n3 p1)) (.base (BaseType.tensor3 n1 n2 n3 p1))
| @Op.negate3 n1 n2 n3 p1 | @Op.inverse3 n1 n2 n3 p1 =>
  .base (BaseType.tensor3 n1 n2 n3 p1)

@[simp, reducible]
def outUserType : Op → UserType
| @Op.add1 n1 p1 | @Op.sub1 n1 p1 | @Op.dot1 n1 p1 | @Op.dot_flattened_barr1 n1 p1
  | @Op.haddamard_mult1 n1 p1 | @Op.matmul_barr1 n1 p1 | @Op.mult_rows_barr1 n1 p1
  | @Op.negate1 n1 p1 =>
  .base (BaseType.tensor1 n1 p1)
| @Op.add2 n1 n2 p1 | @Op.sub2 n1 n2 p1 | @Op.dot2 n1 n2 p1 | @Op.dot_flattened_barr2 n1 n2 p1
  | @Op.haddamard_mult2 n1 n2 p1 | @Op.matmul_barr2 n1 n2 p1 | @Op.mult_rows_barr2 n1 n2 p1
  | @Op.negate2 n1 n2 p1 | @Op.inverse2 n1 n2 p1 =>
  .base (BaseType.tensor2 n1 n2 p1)
| @Op.add3 n1 n2 n3 p1 | @Op.sub3 n1 n2 n3 p1 | @Op.dot3 n1 n2 n3 p1 | @Op.dot_flattened_barr3 n1 n2 n3 p1
  | @Op.haddamard_mult3 n1 n2 n3 p1 | @Op.matmul_barr3 n1 n2 n3 p1 | @Op.mult_rows_barr3 n1 n2 n3 p1
  | @Op.negate3 n1 n2 n3 p1 | @Op.inverse3 n1 n2 n3 p1 =>
  .base (BaseType.tensor3 n1 n2 n3 p1)

@[simp]
def rgnDom : Op → UserType := fun _ => .unit
@[simp]
def rgnCod : Op → UserType := fun _ => .unit

@[simp]
def eval (o : Op)
  (arg: Goedel.toType (argUserType o))
  (_rgn : (Goedel.toType (rgnDom o) → Goedel.toType (rgnCod o))) :
  Goedel.toType (outUserType o) :=
    match o with
    | Op.add1 => Vector.add arg.1 arg.2

instance TUS : SSA.TypedUserSemantics Op BaseType where
  argUserType := argUserType
  rgnDom := rgnDom
  rgnCod := rgnCod
  outUserType := outUserType
  eval := eval



end ModArith

namespace Poly

/-- The Poly dialect, ironically, does not deal with polynomials.
It deals with quotients of a polynomial ring. However, in keeping
consistent with the paper notation we still call them polynomials -/
inductive BaseType
| poly (q : Nat) (n : Nat) : BaseType
| poly_ntt (q : Nat) (n : Nat) : BaseType
| poly_array (q : Nat) (n : Nat) : BaseType -- forgetful functor
| poly_ntt_array (q : Nat) (n : Nat) : BaseType
deriving DecidableEq, Inhabited

inductive Op
| forward_ntt (q : Nat) (n : Nat) : Op -- do we need to parametrize the ops with q and n?
| backward_ntt (q : Nat) (n : Nat) : Op
| get_num_moduli : Op
| add : Op
| add_poly (q : Nat) (n : Nat) : Op
| const (n : Nat): Op
| const_poly : R q n → Op
| encrypt : Op
| decrypt : Op
--deriving Repr, DecidableEq

end Poly
