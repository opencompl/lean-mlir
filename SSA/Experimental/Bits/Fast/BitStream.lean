import Mathlib.Tactic.ExtractGoal

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

#eval (10 : Int).bmod 2
#eval (10 : Int).bmod 3
#eval (10 : Int).bmod 4
#eval (10 : Int).bmod 5
#eval (10 : Int).bmod 6
#eval (10 : Int).bmod 7
#eval (10 : Int).bmod 8
#eval (10 : Int).bmod 9
#eval (10 : Int).bmod 10
#eval (10 : Int).bmod 11
#eval (10 : Int).bmod 12
#eval (10 : Int).bmod 13
#eval (10 : Int).bmod 14
#eval (10 : Int).bmod 15
#eval (10 : Int).bmod 16
#eval (10 : Int).bmod 17
#eval (10 : Int).bmod 16
#eval (10 : Int).bmod 17
#eval (10 : Int).bmod 18
#eval (10 : Int).bmod 19
#eval (10 : Int).bmod 20
#eval (10 : Int).bmod 21

#eval (10 : Int).bmod 2   |>.bmod 5
#eval (10 : Int).bmod 3   |>.bmod 5
#eval (10 : Int).bmod 4   |>.bmod 5
#eval (10 : Int).bmod 5   |>.bmod 5
#eval (10 : Int).bmod 6   |>.bmod 5
#eval (10 : Int).bmod 7   |>.bmod 5
#eval (10 : Int).bmod 8   |>.bmod 5
#eval (10 : Int).bmod 9   |>.bmod 5
#eval (10 : Int).bmod 10  |>.bmod   5
#eval (10 : Int).bmod 11  |>.bmod   5
#eval (10 : Int).bmod 12  |>.bmod   5
#eval (10 : Int).bmod 13  |>.bmod   5
#eval (10 : Int).bmod 14  |>.bmod   5
#eval (10 : Int).bmod 15  |>.bmod   5
#eval (10 : Int).bmod 16  |>.bmod   5
#eval (10 : Int).bmod 17  |>.bmod   5
#eval (10 : Int).bmod 16  |>.bmod   5
#eval (10 : Int).bmod 17  |>.bmod   5
#eval (10 : Int).bmod 18  |>.bmod   5
#eval (10 : Int).bmod 19  |>.bmod   5
#eval (10 : Int).bmod 20  |>.bmod   5
#eval (10 : Int).bmod 21  |>.bmod   5

theorem bmod_bmod_eq_bmod_min (z : Int) (n m : Nat) :
    (z.bmod n).bmod m = z.bmod (Nat.min n m) := by
  simp [bmod]

-- theorem bmod_ofNat_eq_of_not_lt (n m : Nat) (h : ¬n < (m + 1) / 2) :
--     (↑n : Int).bmod m = ↑(n % m) - m := by
--   simp only [
--     bmod, ofNat_emod, ite_eq_left_iff,
--     show (n : Int) % (m : Int) = ((n % m : Nat) : Int) from rfl,
--     Nat.mod_eq_of_lt (by omega : n < m)
--   ]
--   omega


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
    simp [this]; omega

-- theorem toInt_gt_or_le (x : BitVec w) :
--     x

theorem signExtend_succ (i : Nat) (x : BitVec w) :
    x.signExtend (i+1) = cons (if i ≤ w then x.getLsb i else x.msb) (x.signExtend i) := by
  apply eq_of_toInt_eq
  -- conv => {lhs; unfold signExtend; simp}
  simp [signExtend]
  -- rcases (Nat.lt_trichotomy .. : i < w ∨ i = w ∨ i > w) with i_lt_w | rfl | i_gt_w
  by_cases i_le_w : i ≤ w <;> simp only [i_le_w, ↓reduceIte]
  · simp [toInt_eq_toNat_bmod]


    rw [Int.bmod_eq_of_ge_and_le]
    · sorry
    · omega
    · sorry
  · simp [toInt_eq_toNat_bmod]
    sorry



    -- rw [toInt_eq_msb_cond]
    -- cases h_msb : x.msb <;> simp


end BitVec
end UpStream

def BitStream : Type := Nat → Bool

namespace BitStream

def ofNat (x : Nat) : BitStream
  | 0   => x % 2 == 1
  | i+1 => ofNat (x/2) i

instance : OfNat BitStream n := ⟨ofNat n⟩

def head (x : BitStream) : Bool      := x 0
def tail (x : BitStream) : BitStream := (x <| · + 1)


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
  simpa

end Lemmas

/-! # Bitwise Operations -/
section BitwiseOps

/-- `map f` maps a (unary) function over a bitstreams -/
abbrev map (f : Bool → Bool) : BitStream → BitStream :=
  fun x i => f (x i)

/-- `map₂ f` maps a binary function over two bitstreams -/
abbrev map₂ (f : Bool → Bool → Bool) : BitStream → BitStream → BitStream :=
  fun x y i => f (x i) (y i)

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

variable (x y : BitVec w)

@[simp] theorem ofBitVec_complement : ofBitVec (~~~x) = ~~~(ofBitVec x) := by
  funext i
  simp only [ofBitVec, BitVec.getLsb_not, BitVec.msb_not, not_eq]
  split <;> simp_all

@[simp] theorem ofBitVec_and : ofBitVec (x &&& y) ={≤w} (ofBitVec x) &&& (ofBitVec y) := by
  intro i _; simp

@[simp] theorem ofBitVec_or : ofBitVec (x ||| y) ={≤w} (ofBitVec x) ||| (ofBitVec y) := by
  intro i _; simp

@[simp] theorem ofBitVec_xor : ofBitVec (x ^^^ y) ={≤w} (ofBitVec x) ^^^ (ofBitVec y) := by
  intro i _; simp

end Lemmas

end BitwiseOps

/-! # Addition -/
section Arith

/-- `mapAccum₂` ("binary map accumulate") maps a binary function `f` over two streams,
while accumulating some state -/
def mapAccum₂ {α} (f : α → Bool → Bool → α × Bool) (init : α) (x y : BitStream) : BitStream :=
  fun i => (go i).snd
where
  go : Nat → α × Bool
    | 0   => f init (x 0) (y 0)
    | i+1 =>
      let ⟨a, _⟩ := go i
      f a (x <| i + 1) (y <| i + 1)

instance : Add BitStream := ⟨mapAccum₂ BitVec.adcb false⟩

section Lemmas

theorem mapAccum₂_succ (f) (init : α) (x y) (i) :
    (mapAccum₂ f init x y) (i + 1)
    = (f (mapAccum₂.go f init x y i).fst (x (i+1)) (y (i+1))).snd := by
  simp [mapAccum₂, mapAccum₂.go]

-- theorem add_eq (x y : BitStream) (i : Nat) :
--     (x + y) i = _

theorem ofBitVec_add {w} (x y : BitVec w) :
    ofBitVec (x + y) ={≤w} (ofBitVec x) + (ofBitVec y) := by
  have ⟨h₁, h₂⟩ : True ∧ True := sorry
  sorry

end Lemmas

end Arith
