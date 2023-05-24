import Mathlib.Data.Vector
import Mathlib.Data.Bitvec.Basic -- we should add a `Bitvec.lean` in Mathlib/Data/

namespace Vector

instance {α : Type u} {n : Nat} [NeZero n] : GetElem (Vector α n) (Fin n) α (fun _ _ => True) where
  getElem := fun v i _ => v.1[i.val]

end Vector
namespace Bitvec

def width : Bitvec n → Nat := fun _ => n

-- Shouldn't this be inferred from the instance above? (as Bitvec is @[reducible])
instance {n : Nat} [NeZero n] : GetElem (Bitvec n) (Fin n) Bool (fun _ _ => True) where
  getElem := fun v i _ => v.1[i.val]

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
def udiv {w : Nat} (x y : Bitvec w) : Option $ Bitvec w :=
  match y.toNat with
    | 0 => none
    | _ => some $ Bitvec.ofNat w (x.toNat / y.toNat)

/--
The value produced is the signed integer quotient of the two operands rounded towards zero.
Note that signed integer division and unsigned integer division are distinct operations; for unsigned integer division, use ‘udiv’.
Division by zero is undefined behavior.
Overflow also leads to undefined behavior; this is a rare case, but can occur, for example, by doing a 32-bit division of -2147483648 by -1.
-/
def sdiv {w : Nat} (x y : Bitvec w) : Option $ Bitvec w := 
  match y.toInt with
    | 0 => none
    | _ => match w with
      | 0 => some Vector.nil
      | w' + 1 => some $ Bitvec.ofInt w' (x.toInt / y.toInt)

/--
 If the condition is an i1 and it evaluates to 1, the instruction returns the first value argument; otherwise, it returns the second value argument.
-/
def select {w : Nat} (c : Bitvec 1) (x y : Bitvec w) : Bitvec w :=
    if c = true ::ᵥ Vector.nil then x else y

theorem bitwise_eq_eq {w : Nat} (x y : Bitvec w) [ wneq0 : NeZero w] :
 (forall i : Fin w, x[i] = y[i]) ↔ x = y := sorry
    
-- from InstCombine/Shift:279
theorem shl_ushr_eq_and_shl {w : Nat} {x C : Bitvec w.succ} :
  Bitvec.shl (Bitvec.ushr x C.toNat) C.toNat = Bitvec.and x (Bitvec.shl (Bitvec.ofInt w (-1)) C.toNat) :=
  sorry -- TODO: make sure the semantics are the same here


-- from InstCombine/:805
theorem one_sdiv_eq_add_cmp_select {w : Nat} {x : Bitvec w.succ} :
  Bitvec.sdiv (Bitvec.ofInt w 1) x = Option.some (Bitvec.select ((Nat.blt (Bitvec.add x (Bitvec.ofNat w.succ 1)).toNat 3) ::ᵥ Vector.nil)  x (Bitvec.ofNat w.succ 0)) :=
  sorry -- TODO: make sure the semantics are the same here
  -- Looks pretty ugly/random, can we make it more readable


end Bitvec
