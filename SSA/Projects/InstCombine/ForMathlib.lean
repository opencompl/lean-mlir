import Mathlib.Data.Vector
import Mathlib.Data.Bitvec.Basic -- we should add a `Bitvec.lean` in Mathlib/Data/

namespace Vector

instance {α : Type u} {n : Nat} [NeZero n] : GetElem (Vector α n) (Fin n) α (fun _ _ => True) where
  getElem := fun v i _ => v.1[i.val]

end Vector
namespace Bitvec

def width : Bitvec n → Nat := fun _ => n

instance (n : Nat) : Inhabited (Bitvec n) :=
  ⟨List.replicate n true, by apply List.length_replicate⟩

def Fun (width : Nat) := Fin width → Bool

/-- convert `Bitvec n` to `Fin n → Bool` -/
def ofFun {width : Nat} : Fun width → Bitvec width :=
  match width with
    | 0 => fun _ => ⟨List.nil, rfl⟩
    | n + 1 => fun f => sorry

/-- convert `Fin n → Bool` to `Bitvec n` -/
def toFun {width : Nat} : Bitvec width → Fun width :=
    match width with
        | 0 => fun _ => Fin.elim0
        | n + 1 => fun bv i => bv[i]

instance {width : Nat} : Coe (Fun width) (Bitvec width) := ⟨@ofFun width⟩
instance {width : Nat} : Coe (Bitvec width) (Fun width) := ⟨@toFun width⟩


/--
The value produced is the unsigned integer quotient of the two operands.
Note that unsigned integer division and signed integer division are distinct operations; for signed integer division, use ‘sdiv’.
Division by zero is undefined behavior.
-/
def Bitvec.udiv {w : Nat} (x y : Bitvec w) : Option $ Bitvec w :=
 panic! "unimplemented" -- TODO: adapt this to Mathlib style (with carry, no overflow, etc) 


/--
The value produced is the signed integer quotient of the two operands rounded towards zero.
Note that signed integer division and unsigned integer division are distinct operations; for unsigned integer division, use ‘udiv’.
Division by zero is undefined behavior.
Overflow also leads to undefined behavior; this is a rare case, but can occur, for example, by doing a 32-bit division of -2147483648 by -1.
-/
def Bitvec.sdiv {w : Nat} (x y : Bitvec w) : Option $ Bitvec w := panic! "unimlpmented" -- TODO: adapt this to Mathlib style (with carry, no overflow, etc)

/--
 If the condition is an i1 and it evaluates to 1, the instruction returns the first value argument; otherwise, it returns the second value argument.
-/
def Bitvec.select {w : Nat} (c : Bitvec 1) (x y : Bitvec w) : Bitvec w :=
    if c = true ::ᵥ Vector.nil then x else y

end Bitvec
