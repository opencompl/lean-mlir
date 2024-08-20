import Mathlib.Tactic.NormNum

import Mathlib.Logic.Function.Iterate
import SSA.Projects.InstCombine.ForLean
-- TODO: upstream the following section
section UpStream

namespace Int

theorem bmod_eq_of_ge_and_le (z : Int) (m : Nat)
    (hlower_bound : m/2 ≤ z) (hupper_bound : z < m/2) :
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
      simp [HMod.hMod, Mod.mod, Int.emod]
      cases a
      all_goals (rename_i o)
      {
        have := Int.zero_le_ofNat o
        contradiction
      }
      simp only [Int.abs_eq_natAbs, subNatNat, HAdd.hAdd, Add.add, Int.add]
      have e : o.succ = (o.mod b.natAbs).add 1 := by
        simp only [Nat.mod, Nat.add]
        congr
        cases o
        all_goals simp
        rename_i g
        have l : ¬ (b.natAbs ≤ g + 1) := by
          have y : g + 2 ≤ ↑b.natAbs := by
            rw [← Int.ofNat_le]
            rw [Int.add_comm, Int.negSucc_eq] at H2
            omega
          omega
        simp [l]
      simp only [e]



end Int

namespace BitVec
open BitVec

@[simp] theorem getMsb_not (x : BitVec w) :
    (~~~x).getMsb i = (decide (i < w) && !(x.getMsb i)) := by
  by_cases h : i < w <;> simp [getMsb, h] ; omega

@[simp] theorem msb_not (x : BitVec w) : (~~~x).msb = (decide (0 < w) && !x.msb) := by
  simp [BitVec.msb]

variable {α β} [Coe α β] (as : List α)

@[simp] theorem msb_signExtend_of_ge {i} (h : i ≥ w) (x : BitVec w) :
    (x.signExtend i).msb = x.msb := by
  simp [BitVec.msb_eq_getLsb_last]
  split <;> by_cases (0 < i) <;> simp_all
  simp [show i = w by omega]

theorem signExtend_succ (i : Nat) (x : BitVec w) :
    x.signExtend (i+1) = cons (if i < w then x.getLsb i else x.msb) (x.signExtend i) := by
  ext j
  simp only [getLsb_signExtend, Fin.is_lt, decide_True, Bool.true_and, getLsb_cons]
  split <;> split <;> simp_all <;> omega

@[simp] theorem signExtend_eq (x : BitVec w) :
    x.signExtend w = x := by
  apply eq_of_toNat_eq
  simp only [signExtend, BitVec.ofInt, toInt_eq_toNat_bmod, Int.ofNat_eq_coe, toNat_ofNatLt]
  rw [Int.bmod_emod]
  norm_cast
  simp [toNat_mod_cancel, Int.toNat_ofNat]

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
  simp [EqualUpTo] at h
  induction w
  all_goals simp [toBitVec]
  rename_i r f
  have a := h r (Nat.lt_add_of_pos_right (by decide))
  have b := f (fun y g => h y (by omega))
  rw [a,b]

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

@[simp] theorem ofBitVec_not : ofBitVec (~~~ x) = ~~~ (ofBitVec x) := by
  funext i
  simp only [ofBitVec, BitVec.getLsb_not, BitVec.msb_not, lt_add_iff_pos_left, add_pos_iff,
    zero_lt_one, or_true, decide_True, Bool.true_and, not_eq]
  split <;> simp_all

end Lemmas

end BitwiseOps

/-! # Addition, Subtraction, Negation -/
section Arith

def addAux (x y : BitStream) (i : Nat) :  Bool × Bool :=
  let carry : Bool := match i with
    | 0 => false
    | i + 1 => (addAux x y i).2
  Prod.swap (BitVec.adcb (x i) (y i) carry)

def add (x y : BitStream) : BitStream :=
  fun n => (addAux x y n).1

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

variable {w : Nat} {x y : BitVec w} {a b a' b' : BitStream}

local infix:20 " ≈ʷ " => EqualUpTo w

@[simp]
theorem ofBitVec_getLsb (n : Nat) (h : n < w) : ofBitVec x n = x.getLsb n := by
  simp [ofBitVec, h]

theorem ofBitVec_add : ofBitVec (x + y) ≈ʷ (ofBitVec x) + (ofBitVec y) := by
  intros n a
  have add_lemma : ⟨(x + y).getLsb n, BitVec.carry (n + 1) x y false ⟩ = (ofBitVec x).addAux (ofBitVec y) n := by
    induction' n with n ih
    · simp [addAux, BitVec.adcb, a, BitVec.getLsb, BitVec.carry, ← Bool.decide_and,
        Bool.xor_decide, Nat.two_le_add_iff_odd_and_odd, Nat.add_odd_iff_neq]
    · simp [addAux, ← ih (by omega), BitVec.adcb, a, BitVec.carry_succ, BitVec.getLsb_add]
  simp [HAdd.hAdd, Add.add, BitStream.add, ← add_lemma, a, -BitVec.add_eq, -Nat.add_eq, -Nat.add_def]

@[refl]
theorem equal_up_to_refl : a ≈ʷ a := by
  intros _ _
  rfl

@[symm]
theorem equal_up_to_symm (e : a ≈ʷ b) : b ≈ʷ a := by
  intros j h
  symm
  exact e j h

@[trans]
theorem equal_up_to_trans (e1 : a ≈ʷ b) (e2 : b ≈ʷ c) : a ≈ʷ c := by
  intros j h
  trans b j
  exact e1 j h
  exact e2 j h

instance congr_trans : Trans (EqualUpTo w) (EqualUpTo w) (EqualUpTo w) where
  trans := equal_up_to_trans

instance congr_equiv : Equivalence (EqualUpTo w) where
  refl := fun _ => equal_up_to_refl
  symm := equal_up_to_symm
  trans := equal_up_to_trans

theorem add_congr (e1 : a ≈ʷ b) (e2 : c ≈ʷ d) : (a + c) ≈ʷ (b + d) := by
  intros n h
  have add_congr_lemma : a.addAux c n = b.addAux d n := by
    induction' n with _ ih
    · simp only [addAux, e1 _ h, e2 _ h]
    · simp only [addAux, e1 _ h, e2 _ h, ih (by omega)]
  simp [HAdd.hAdd, Add.add, BitStream.add, add_congr_lemma, addAux]


theorem not_congr (e1 : a ≈ʷ b) : (~~~a) ≈ʷ ~~~b := by
  intros g h
  simp only [not_eq, e1 g h]

theorem ofBitVec_not_eqTo : ofBitVec (~~~ x) ≈ʷ ~~~ ofBitVec x := by
  intros _ a
  simp [ofBitVec, a]

theorem negAux_eq_not_addAux : a.negAux = (~~~a).addAux 1 := by
  funext i
  induction' i with _ ih
  · simp [negAux, addAux, BitVec.adcb, OfNat.ofNat, ofNat]
  · simp [negAux, addAux, BitVec.adcb, OfNat.ofNat, ofNat, ih]

theorem neg_eq_not_add : - a = ~~~ a + 1 := by
  ext _
  simp [negAux_eq_not_addAux, Neg.neg, neg, HAdd.hAdd, Add.add, add, addAux, BitVec.adcb]

theorem ofNat_one (i : Nat) : ofNat 1 i = decide (0 = i) := by
  cases i
  <;> simp [ofNat, Nat.shiftRight]

theorem ofBitVec_one_eqTo_ofNat : @ofBitVec w 1 ≈ʷ ofNat 1 := by
  by_cases h : w = 0
  · simp [EqualUpTo ,h]
  · intros n a
    simp [ofNat_one n, ofBitVec, a]
    omega

theorem ofBitVec_neg : ofBitVec (- x) ≈ʷ - (ofBitVec x) := by
  calc
  _ ≈ʷ ofBitVec (~~~ x + 1)            := by rw [BitVec.neg_eq_not_add]
  _ ≈ʷ ofBitVec (~~~ x) + (ofBitVec 1) := ofBitVec_add
  _ ≈ʷ ~~~ ofBitVec x   + 1            := add_congr ofBitVec_not_eqTo ofBitVec_one_eqTo_ofNat
  _ ≈ʷ - (ofBitVec x)                  := by rw [neg_eq_not_add]

theorem sub_congr (e1 : a ≈ʷ b) (e2 : c ≈ʷ d) : (a - c) ≈ʷ (b - d) := by
  intros n h
  have sub_congr_lemma : a.subAux c n = b.subAux d n := by
    induction' n with _ ih
    <;> simp only [subAux, Prod.mk.injEq, e1 _ h, e2 _ h, and_self]
    simp only [ih (by omega), and_self]
  simp only [HSub.hSub, Sub.sub, BitStream.sub, sub_congr_lemma]

theorem neg_congr (e1 : a ≈ʷ b) : (-a) ≈ʷ -b := by
  intros n h
  have neg_congr_lemma : a.negAux n = b.negAux n := by
    induction' n with _ ih
    <;> simp only [negAux, Prod.mk.injEq, (e1 _ h)]
    simp only [ih (by omega), Bool.bne_right_inj, and_self]
  simp only [Neg.neg, BitStream.neg, neg_congr_lemma]

theorem BitVec.sub_add_neg : x - y = x + (- y) := by
  simp only [HAdd.hAdd, HSub.hSub, Neg.neg, Sub.sub, BitVec.sub,Add.add, BitVec.add]
  simp [← BitVec.ofNat_add_ofNat, add_comm, BitVec.ofNat, -BitVec.ofFin_ofNat, Fin.ofNat']

/--
g is some unknown auxiliary function that will be useful in proving sub_add_neg
-/
def g (a b : BitStream) (i : Nat) : Bool := sorry

theorem g_zero {a b : BitStream} :
    (!a 0 && b 0) = a.g b 0 := by
  sorry

theorem g_succ_left {a b : BitStream} (i : ℕ) :
    xor (b (i + 1)) (a.g b i) = ((!b (i + 1)) != ((b.negAux i).2 != (a.addAux (fun n => (b.negAux n).1) i).2)) := by
  sorry

theorem g_succ_right {a b : BitStream} (i : ℕ)  :
    (!a (i + 1) && b (i + 1) || !xor (a (i + 1)) (b (i + 1)) && a.g b i) = a.g b (i + 1) := by
  sorry

theorem sub_add_neg {a b : BitStream} : a - b = a + (-b) := by
  have sub_add_lemma (i : Nat) :
      let y := b.negAux
      let x := a.addAux (fun n => (y n).1) i
      a.subAux b i = ⟨x.1, g a b i⟩  := by
    induction' i with i ih
    · simp [subAux,addAux,negAux, BitVec.adcb]
      exact g_zero
    · simp [subAux,addAux,negAux, BitVec.adcb]
      rw [ih]
      simp
      constructor
      · exact g_succ_left i
      · exact g_succ_right i
  ext i
  simp only [HAdd.hAdd, HSub.hSub, Neg.neg, Sub.sub, BitStream.sub,Add.add, BitStream.add]
  unfold neg
  simp [sub_add_lemma i]

theorem ofBitVec_sub : ofBitVec (x - y) ≈ʷ (ofBitVec x) - (ofBitVec y)  := by
  calc
  _ ≈ʷ ofBitVec (x + - y) := by rw [BitVec.sub_add_neg]
  _ ≈ʷ ofBitVec x + ofBitVec (-y) := ofBitVec_add
  _ ≈ʷ ofBitVec x + - ofBitVec y := add_congr equal_up_to_refl ofBitVec_neg
  _ ≈ʷ ofBitVec x - ofBitVec y := by rw [sub_add_neg]


theorem equal_congr_congr  (e1 : a ≈ʷ b) (e2 : c ≈ʷ d) : (a ≈ʷ c) = (b ≈ʷ d) := by
  apply propext
  constructor
  <;> intros h
  · apply equal_up_to_trans _ e2
    apply equal_up_to_trans _ h
    apply equal_up_to_symm
    assumption
  · apply equal_up_to_trans _
    apply (equal_up_to_symm e2)
    apply equal_up_to_trans _ h
    assumption

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
