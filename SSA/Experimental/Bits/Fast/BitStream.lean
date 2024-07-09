import Mathlib.Tactic.NormNum
import Mathlib.Logic.Function.Iterate

-- TODO: upstream the following section
section UpStream

namespace Int

theorem bmod_eq_of_ge_and_le (z : Int) (m : Nat)
    (lower_bound : m/2 ≤ z) (upper_bound : z < m/2) :
    z.bmod m = z := by
  omega

theorem bmod_ofNat_eq_of_lt (n m : Nat) (h : n < (m + 1) / 2) :
    (↑n : Int).bmod m = ↑(n % m) := by
  simp only [
    bmod, ofNat_emod, ite_eq_left_iff,
    show (n : Int) % (m : Int) = ((n % m : Nat) : Int) from rfl,
    Nat.mod_eq_of_lt (by omega : n < m)
  ]
  omega

theorem emod_eq_of_neg {a b : Int} (H1 : a < 0) (H2 : 0 ≤ a + b.natAbs) :
    a % b = b.natAbs + a := by
  sorry


end Int

namespace BitVec
open BitVec

@[simp] theorem getMsb_not (x : BitVec w) : (~~~x).getMsb i = (decide (i < w) && !(x.getMsb i)) := by
  by_cases h : i < w <;> simp [getMsb, h] <;> omega

@[simp] theorem msb_not (x : BitVec w) : (~~~x).msb = (decide (0 < w) && !x.msb) := by
  simp [BitVec.msb]

#check truncate_succ
#print BitVec.toInt

@[simp] theorem toInt_cons (x : Bool) (xs : BitVec w) :
    BitVec.toInt (cons x xs) =
      if x then (xs.toNat : Int) - (2 ^ w : Nat) else (xs.toNat : Int) := by
  simp only [toInt_eq_msb_cond, msb_cons, toNat_cons]
  cases x
  case false => simp
  case true  =>
    have : 1 <<< w ||| xs.toNat = 1 <<< w + xs.toNat := sorry
    simp [this];
    sorry

-- theorem toInt_gt_or_le (x : BitVec w) :
--     x



variable {α β} [Coe α β] (as : List α)
#check (as.map (· : α → β))

theorem signExtend_eq_truncate_of_le {i w} (h : i ≤ w) (x : BitVec w) :
    x.signExtend i = x.truncate i := by
  sorry

theorem toNat_getLsb_shiftLeft (x : BitVec w) (i : Nat) :
    (x.getLsb i).toNat <<< i = (x.toNat &&& (1 <<< i)) := by
  sorry

@[simp] theorem msb_signExtend_of_ge {i} (h : i ≥ w) (x : BitVec w) :
    (x.signExtend i).msb = x.msb := by
  sorry


theorem signExtend_succ (i : Nat) (x : BitVec w) :
    x.signExtend (i+1) = cons (if i < w then x.getLsb i else x.msb) (x.signExtend i) := by
  by_cases hi : i<w
  · have hi_le : i ≤ w := by omega
    simp [signExtend_eq_truncate_of_le hi, truncate_succ, signExtend_eq_truncate_of_le, hi_le, hi]
  · simp only [hi, ↓reduceIte]
    have hi_ge : i ≥ w := by omega
    apply eq_of_toInt_eq
    rw [toInt_cons, toInt_eq_msb_cond, msb_signExtend_of_ge (by omega)]
    cases hmsb : x.msb <;> simp only [Bool.false_eq_true, ↓reduceIte, signExtend]
    · simp only [toNat_ofInt]
      simp only [toInt_eq_msb_cond, hmsb, Bool.false_eq_true, ↓reduceIte, Nat.cast_pow,
        Nat.cast_ofNat, Nat.cast_inj]
      norm_cast
      have : x.toNat < 2 ^ i := by
        have := x.isLt
        apply Nat.lt_of_lt_of_le x.isLt
        apply Nat.pow_le_pow_of_le
        · decide
        · omega
      rw [Nat.mod_eq_of_lt this, Nat.mod_eq_of_lt (by omega)]
    · simp
      simp [toInt_eq_msb_cond, hmsb]
      stop
      rw [Int.emod_eq_of_neg]
      · sorry
      · have := x.isLt
        omega
        have : 2 ^ (w - 1) ≤ x.toNat := by
          simpa [msb_eq_decide] using hmsb
        omega
      · sorry



    -- rw [toInt_eq_msb_cond]
    -- cases h_msb : x.msb <;> simp

@[simp] theorem signExtend_eq (x : BitVec w) :
    x.signExtend w = x := by
  apply eq_of_toNat_eq
  simp only [signExtend, BitVec.ofInt, toInt_eq_toNat_bmod, Int.ofNat_eq_coe, toNat_ofNatLt]
  rw [Int.bmod_emod]
  norm_cast
  simp [toNat_mod_cancel, Int.toNat_ofNat]

@[simp] theorem msb_xor {x y : BitVec w} :
    (x ^^^ y).msb = xor x.msb y.msb := by
  simp only [BitVec.msb, getMsb, tsub_zero, getLsb_xor]
  cases decide (0 < w) <;> rfl

end BitVec
end UpStream






/-!

## Reflection

We have a decision procedure which operates on BitStream operations, but we'd like

-/













def BitStream : Type := Nat → Bool

namespace BitStream

/-! # Preliminaries -/
section Basic

def head (x : BitStream) : Bool      := x 0
def tail (x : BitStream) : BitStream := (x <| · + 1)

/-- Append a single bit to the least significant end of a bitvector.
That is, the new bit is the least significant bit.
-/
def concat (b : Bool) (x : BitStream) : BitStream
  | 0   => b
  | i+1 => x i

/-- `map f` maps a (unary) function over a bitstreams -/
abbrev map (f : Bool → Bool) : BitStream → BitStream :=
  fun x i => f (x i)

/-- `map₂ f` maps a binary function over two bitstreams -/
abbrev map₂ (f : Bool → Bool → Bool) : BitStream → BitStream → BitStream :=
  fun x y i => f (x i) (y i)

def corec {β} (f : β → β × Bool) (b : β) : BitStream :=
  fun i => f ((Prod.fst ∘ f)^[i] b) |>.snd

/-- `mapAccum₂` ("binary map accumulate") maps a binary function `f` over two streams,
while accumulating some state -/
def mapAccum₂ {α} (f : α → Bool → Bool → α × Bool) (init : α) (x y : BitStream) : BitStream :=
  corec (β := α × BitStream × BitStream) (b := (init, x, y)) fun ⟨state, x, y⟩ =>
    let z := f state x.head y.head
    (⟨z.fst, x.tail, y.tail⟩, z.snd)

section Lemmas

@[ext]
theorem ext {x y : BitStream} (h : ∀ i, x i = y i) : x = y := by
  funext i; exact h i

end Lemmas

end Basic

/-! # OfNat -/
section OfNat

/-- Zero-extend a natural number to an infinite bitstream -/
def ofNat (x : Nat) : BitStream :=
  Nat.testBit x

instance : OfNat BitStream n := ⟨ofNat n⟩

end OfNat

/-! # Conversions to and from `BitVec` -/
section ToBitVec

/-- Sign-extend a finite bitvector `x` to the infinite stream `(x.msb)^ω ⋅ x`  -/
abbrev ofBitVec {w} (x : BitVec w) : BitStream :=
  fun i => if i < w then x.getLsb i else x.msb

/-- `x.toBitVec w` returns the first `w` bits of bitstream `x` -/
def toBitVec (w : Nat) (x : BitStream) : BitVec w :=
  match w with
  | 0   => 0#0
  | w+1 => (x.toBitVec w).cons (x w)

/-- `EqualUpTo w x y` holds iff `x` and `y` are equal in the first `w` bits -/
def EqualUpTo (w : Nat) (x y : BitStream) : Prop :=
  ∀ i < w, x i = y i
local macro:50 x:term:50 " ={≤" w:term "} " y:term:51 : term =>
  `(EqualUpTo $w $x $y)

/-- `printPrefix x n` returns a string with the first `n` digits of the bitstream `x` -/
def printPrefix (x : BitStream) : Nat → String
  | 0   => "0b"
  | n+1 =>
    let h := if x.head then "1" else "0"
    let t := x.tail.printPrefix n
    t ++ h

section Lemmas

@[simp] theorem toBitVec_ofBitVec (x : BitVec w) (w' : Nat) :
    toBitVec w' (ofBitVec x) = x.signExtend w' := by
  induction w'
  case zero      => simp only [BitVec.eq_nil]
  case succ w ih => rw [toBitVec, ih]; simp [BitVec.signExtend_succ]

theorem toBitVec_eq_of_equalUpTo {w : Nat} {x y : BitStream} (h : x ={≤w} y) :
    x.toBitVec w = y.toBitVec w := by
  sorry

theorem eq_of_ofBitVec_eq (x y : BitVec w) :
    ofBitVec x ={≤w} ofBitVec y → x = y := by
  intro h
  have := toBitVec_eq_of_equalUpTo h
  simp at this
  simpa

end Lemmas
end ToBitVec

/-! # Bitwise Operations -/
section BitwiseOps

instance : Complement BitStream := ⟨map Bool.not⟩
instance : AndOp BitStream := ⟨map₂ Bool.and⟩
instance :  OrOp BitStream := ⟨map₂ Bool.or⟩
instance :   Xor BitStream := ⟨map₂ Bool.xor⟩

section Lemmas
variable {w : Nat}

variable (x y : BitStream) (i : Nat)
@[simp] theorem not_eq :    (~~~x) i = !(x i)            := rfl
@[simp] theorem and_eq : (x &&& y) i = (x i && y i)      := rfl
@[simp] theorem  or_eq : (x ||| y) i = (x i || y i)      := rfl
@[simp] theorem xor_eq : (x ^^^ y) i = (xor (x i) (y i)) := rfl

variable (x y : BitVec (w+1))

@[simp] theorem ofBitVec_complement : ofBitVec (~~~x) = ~~~(ofBitVec x) := by
  funext i
  simp only [ofBitVec, BitVec.getLsb_not, BitVec.msb_not, not_eq]
  split <;> simp_all

@[simp] theorem ofBitVec_and : ofBitVec (x &&& y) = (ofBitVec x) &&& (ofBitVec y) := by
  funext i
  simp only [ofBitVec, BitVec.getLsb_and, BitVec.msb_and, and_eq]
  split <;> simp_all

@[simp] theorem ofBitVec_or : ofBitVec (x ||| y) = (ofBitVec x) ||| (ofBitVec y) := by
  funext i
  simp only [ofBitVec, BitVec.getLsb_or, BitVec.msb_or, or_eq]
  split <;> simp_all

@[simp] theorem ofBitVec_xor : ofBitVec (x ^^^ y) = (ofBitVec x) ^^^ (ofBitVec y) := by
  funext i
  simp only [ofBitVec, BitVec.getLsb_xor, xor_eq]
  split <;> simp_all

end Lemmas

end BitwiseOps

/-! # Addition, Subtraction, Negation -/
section Arith

def addAux (x y : BitStream) : Nat → Bool × Bool
  | 0 => BitVec.adcb (x 0) (y 0) false
  | n+1 =>
    let carry := (addAux x y n).1
    let a := x (n + 1)
    let b := y (n + 1)
    BitVec.adcb a b carry

def add (x y : BitStream) : BitStream :=
  fun n => (addAux x y n).2

def subAux (x y : BitStream) : Nat → Bool × Bool
  | 0 => (_root_.xor (x 0) (y 0), !(x 0) && y 0)
  | n+1 =>
    let borrow := (subAux x y n).2
    let a := x (n + 1)
    let b := y (n + 1)
    (_root_.xor a (_root_.xor b borrow), !a && b || ((!(_root_.xor a b)) && borrow))

def sub (x y : BitStream) : BitStream :=
  fun n => (subAux x y n).1

def negAux (x : BitStream) : Nat → Bool × Bool
  | 0 => (x 0, !(x 0))
  | n+1 =>
    let borrow := (negAux x n).2
    let a := x (n + 1)
    (_root_.xor (!a) borrow, !a && borrow)

def neg (x : BitStream) : BitStream :=
  fun n => (negAux x n).1

def incrAux (x : BitStream) : Nat → Bool × Bool
  | 0 => (!(x 0), x 0)
  | n+1 =>
    let carry := (incrAux x n).2
    let a := x (n + 1)
    (_root_.xor a carry, a && carry)

def incr (x : BitStream) : BitStream :=
  fun n => (incrAux x n).1

def decrAux (x : BitStream) : Nat → Bool × Bool
  | 0 => (!(x 0), !(x 0))
  | (n+1) =>
    let borrow := (decrAux x n).2
    let a := x (n + 1)
    (_root_.xor a borrow, !a && borrow)

def decr (x : BitStream) : BitStream :=
  fun n => (decrAux x n).1

def carry (x y : BitStream) : BitStream :=
  fun n => (addAux x y n).1

instance : Add BitStream := ⟨add⟩
instance : Neg BitStream := ⟨neg⟩
instance : Sub BitStream := ⟨sub⟩

/-!
TODO: We should define addition and `carry` in terms of `mapAccum`.
For example:
`def add := mapAccum₂ BitVec.adcb false`
and
```
def carry : BitStream → BitStream → BitStream :=
  mapAccum₂ (fun c x₀ y₀ =>
    let c' := Bool.atLeastTwo c x₀ y₀
    (c', c')
  ) false
```
-/

section Lemmas

-- theorem add_eq (x y : BitStream) (i : Nat) :
--     (x + y) i = _

/-!
Following the same pattern as for `ofBitVec_and`, `_or`, etc., we would expect an equality like:
  `ofBitVec (x + y) = (ofBitVec x) + (ofBitVec y)`
However, this is not actually true, since the left hand side does addition on the bitvector level,
thus forgets the extra carry bit, while rhe rhs does addition on streams,
thus could have a bit set in the `w+1`th position.

Crucially, our decision procedure works by considering which equalities hold for *all* widths,

-/
-- theorem ofBitVec_add {w} (x y z : ∀ w, BitVec w) :
--     (∀ w, (x w + y w) = z w) ↔ (∀ w, (ofBitVec (x w)) + (ofBitVec (y w)) ) := by
--   have ⟨h₁, h₂⟩ : True ∧ True := sorry
--   sorry

end Lemmas

end Arith

/-! # OfInt
Using `OfInt` we can convert an `Int` into the infinite bitstream that represents that
particular constant -/
section OfInt

open Int in
/-- Sign-extend an integer to its representation as a 2-adic number
(morally, an infinite width 2s complement representation) -/
def ofInt : Int → BitStream
  | .ofNat n  => ofNat n
  | -[n+1]    => -(ofNat (n+1))

abbrev zero   : BitStream := fun _ => false
abbrev one    : BitStream := (· == 0)
abbrev negOne : BitStream := fun _ => true

section Lemmas

variable (i : Nat)

@[simp] theorem zero_eq : zero i = false    := rfl
@[simp] theorem one_eq  : one i = (i == 0)  := rfl
@[simp] theorem negOne_eq : negOne i = true := rfl

end Lemmas

end OfInt

#eval (1 + 1 : BitStream) 0
#eval (1 + 1 : BitStream) 1
#eval (1 + 1 : BitStream) 2

#eval (carry 1 1) 0
#eval (carry 1 1) 1
#eval (carry 1 1) 2

#eval (addAux 1 1) 0
#eval (addAux 1 1) 1
#eval (addAux 1 1) 2
#eval (addAux 1 1) 3
