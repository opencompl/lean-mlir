import Mathlib.Tactic.NormNum

import Mathlib.Logic.Function.Iterate
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

variable {w : Nat} {x y : BitVec w} {a b a' b' : BitStream}

local infix:20 " ≈ʷ " => EqualUpTo w

-- TODO: These sorries are difficult, and will be proven in a later Pull Request.
@[simp] theorem ofBitVec_sub : ofBitVec (x - y) ≈ʷ (ofBitVec x) - (ofBitVec y)  := by
  sorry

@[simp] theorem ofBitVec_add : ofBitVec (x + y) ≈ʷ (ofBitVec x) + (ofBitVec y)  := by
  sorry
/--
This function says returns
true iff ∀ i < n, x[i] = 0
and returns false
iff   ∃ i < n , x[i] = 1
-/
-- @[simp]
def doesNegCarry? {w : Nat} (x : BitVec w) (n : Nat) : Prop := match n with
  | Nat.zero => ¬ x.getLsb 0
  | Nat.succ y => ¬ x.getLsb (Nat.succ y) ∧  doesNegCarry? x y

instance decid : Decidable (doesNegCarry? x n)  := sorry

-- -- instance _ : DecideAb
-- lemma lemma1 : (-x).getLsb (n + 1) = (x.getLsb (n + 1) != (-x).getLsb n) := by
--   sorry

-- lemma lemma2 (c  : x.getLsb n) :  (-x).getLsb (n + 1) = !x.getLsb (n + 1) := by
--   sorry

-- lemma lemma3 : decide ((2 ^ w - x.toNat) % 2 ^ w / 2 % 2 = 1) = (decide (x.toNat / 2 % 2 = 1) != decide (x.toNat % 2 = 1)):= by
--   sorry

-- theorem neg_induction {w : Nat} (x : BitVec w) (n : Nat) : (-x).getLsb (n + 1) = ( (¬ x.getLsb (n + 1)) ≠ (doesNegCarry? x n)) := by
--   induction n
--   simp only [doesNegCarry?, bne_self_eq_false]
--   simp [BitVec.getLsb, BitVec.toNat_not, BitVec.toNat_ofNat, Nat.add_mod_mod,
--     Nat.testBit_add_one, Nat.testBit_zero]
--   exact lemma3
--   rename_i n ih
--   simp [doesNegCarry?]
--   by_cases c : (x.getLsb (n + 1))
--   all_goals (simp [c])
--   exact lemma2 c
--   simp [c] at ih
--   have g : (!(-x).getLsb (n + 1)) = doesNegCarry? x n := by simp [ih]
--   simp [← g]
--   exact lemma1

-- theorem neg_bit {w : Nat}  (x  : BitVec w) :  (-x).getLsb 0 = x.getLsb 0 := by
--   by_cases c : 0 < w
--   rw [BitVec.neg_eq_not_add]
--   rw [BitVec.getLsb_add c]
--   rw [BitVec.getLsb_not]
--   simp
--   simp [Bool.xor_comm]
--   simp [c]
--   have : w = 0 := by omega
--   simp [this]

-- @[simp] theorem ofBitVec_neg : ofBitVec (- x) ≈ʷ  - (ofBitVec x) := by
--   intros n a
--   have neg_lemma  : ⟨ x.neg.getLsb n , decide (doesNegCarry? x n) ⟩  = (ofBitVec x).negAux n := by
--     induction n
--     simp only [BitVec.neg_eq, doesNegCarry?, negAux, Prod.mk.injEq]
--     constructor
--     all_goals simp [ofBitVec,a]
--     exact neg_bit x
--     rename_i n ih
--     have ihg := ih (by omega)
--     unfold negAux
--     simp [← ihg]
--     constructor
--     simp [ofBitVec, a]
--     exact neg_induction x n
--     congr
--     simp [ofBitVec,a]
--   simp only [Neg.neg]
--   simp only [BitStream.neg]
--   rw [← neg_lemma]
--   simp only [ofBitVec,a,↓reduceIte]

def state {w : Nat} (x : BitVec w) (n : Nat) : Bool := match n with
  | 0 => false
  | i + 1 => !decide (doesNegCarry? x i) --sorryAx (Nat → Bool) false i


theorem extracted_1 {w : ℕ} {x : BitVec w} (n : ℕ)

   :
  (!x.getLsb n).atLeastTwo (decide (0 < w) && decide (0 = n)) (state x n) = decide (doesNegCarry? x n) := by
  induction n
  simp [state, doesNegCarry?]
  sorry
  sorry
@[simp] theorem ofBitVec_neg3 : ofBitVec (- x) ≈ʷ  - (ofBitVec x) := by
  intros n a
  have neg_lemma  : ⟨(-x).getLsb n , decide (doesNegCarry? x n) ⟩  = (ofBitVec x).negAux n := by
    rw [BitVec.neg_eq_not_add]
    -- rw [BitVec.iunfoldr_replace_snd ?f x.neg]
    induction n
    all_goals simp
    simp [negAux,ofBitVec,a,BitVec.getLsb,doesNegCarry?,← decide_not,decide_eq_decide]
    -- simp [BitVec.iunfoldr]
    -- simp [BitVec.iunfoldr]
    sorry
    rename_i n ih
    simp [BitVec.add_eq_adc]
    unfold BitVec.adc
    have ihg := ih (by omega)
    unfold negAux
    -- unfl
    unfold doesNegCarry?
    simp
    constructor

    let t : Fin w := ⟨n+1, a ⟩
    have xl : (↑(⟨n + 1, a⟩ : Fin w)) = n + 1 := by rfl
    rw [← xl]

    have gg : false = state x 0 := by
      rfl
      -- unfold BitStream.ofBitVec_neg3.state
      -- sorry
    rw [gg]
    rw [BitVec.iunfoldr_getLsb (state x) ⟨n+1 ,a ⟩ ]

    rw [← ihg]
    simp
    unfold BitVec.adcb
    unfold Bool.atLeastTwo
    simp
    simp [state]
    simp [ofBitVec,a]
    -- sorry
    -- simp [BitVec.adcb]
    -- extract_goal
    -- exact extracted_1 n
    -- match n with
    --   | 0 =>
    --     have fg : 0 < w := by omega
    --     simp [fg, state, doesNegCarry?]

    --   | Nat.succ k =>
    --     simp [state, doesNegCarry?]
    --     congr

    --     sorry
    -- by_cases p  : n = 0

    -- all_goals try simp [p]
    -- sorry
    -- simp [p]
    -- have asd : ¬ (0 = n) := by
    --   intro jr
    --   symm at jr
    --   exact p jr

      -- simp [p]
    -- simp [asd]
    -- simp [doesNegCarry?]

    sorry
    intro i
    induction i.val
    simp [state, doesNegCarry?, BitVec.adcb, BitVec.getLsb,← decide_not, ← Bool.decide_and]
    sorry
    -- simp [state]

    -- sorry
    -- sorry
    -- sorry
    -- sorry
    -- sorry
    -- unfold ofBitVec

    sorry
    simp [ofBitVec,a]
    congr
    simp [← ihg]
    -- sorry
    -- sorry
    -- sorry
    -- sorry
    -- sorry
    -- intros i ilew
    -- unfold ofBitVec
    -- simp [ilew]
    -- unfold Neg.neg
    -- unfold instNeg
    -- simp [neg]

    -- sorry
  simp only [Neg.neg]
  simp only [BitStream.neg]
  rw [← neg_lemma]
  simp only [ofBitVec,a,↓reduceIte, Neg.neg]


theorem ofBitVec_neg : ofBitVec (- x) ≈ʷ  - (ofBitVec x) := by
  rw [BitVec.neg_eq_not_add]
  simp [BitVec.add_eq_adc]
  unfold BitVec.adc
  intros i ilew
  unfold ofBitVec
  simp [ilew]
  unfold Neg.neg
  unfold instNeg
  simp [neg]

  -- unfold BitVec.adc
  -- rw [BitVec.iunfoldr_replace_snd ?f ?state]
  -- unfold NegA
  sorry
  -- rw [BitVec.bit_neg_eq_neg]
  -- rw [BitVec.iunfoldr_replace_snd (fun n => ()) (~~~ x)]
  -- unfold BitVec.adc
  -- rw [BitVec.iunfoldr_replace_snd (fun n => true) ?x]
  -- -- simp [← BitVec.add_eq_adc]
  -- sorry
  -- rfl
  -- intros i
  -- simp

  -- sorry

  -- sorry
  -- -- exact (fun n => ())
  -- -- exact ~~~ x
  -- rfl
  -- intro i
  -- simp only [Prod.mk.injEq, true_and]
  -- unfold Complement.complement
  -- unfold  BitVec.instComplement
  -- simp
theorem equal_up_to_refl : a ≈ʷ a := by
  intros  j _
  rfl

theorem equal_up_to_symm (e : a ≈ʷ b) : b ≈ʷ a := by
  intros j h
  symm
  exact e j h

theorem equal_up_to_trans (e1 : a ≈ʷ b) (e2 : b ≈ʷ c) : a ≈ʷ c := by
  intros j h
  trans b j
  exact e1 j h
  exact e2 j h

instance congr_equiv : Equivalence (EqualUpTo w) := {
  refl := fun _ => equal_up_to_refl,
  symm := equal_up_to_symm,
  trans := equal_up_to_trans
}

theorem sub_congr (e1 : a ≈ʷ b) (e2 : c  ≈ʷ d) : (a - c) ≈ʷ (b - d) := by
  intros n h
  have sub_congr_lemma : a.subAux c n = b.subAux d n := by
    induction n
    <;> simp only [subAux, Prod.mk.injEq, e1 _ h, e2 _ h, and_self]
    rename_i _ ih
    simp only [ih (by omega), and_self]
  simp only [HSub.hSub, Sub.sub, BitStream.sub, sub_congr_lemma]

theorem add_congr (e1 : a ≈ʷ b) (e2 : c  ≈ʷ d) : (a + c) ≈ʷ (b + d) := by
  intros n h
  have add_congr_lemma : a.addAux c n = b.addAux d n := by
    induction n
    <;> simp only [addAux, Prod.mk.injEq, e1 _ h, e2 _ h]
    rename_i _ ih
    simp only [ih (by omega), Bool.bne_right_inj]
  simp only [HAdd.hAdd, Add.add, BitStream.add, add_congr_lemma]

theorem neg_congr (e1 : a ≈ʷ b) : (-a) ≈ʷ -b := by
  intros n h
  have neg_congr_lemma : a.negAux n = b.negAux n := by
    induction n
    <;> simp only [negAux, Prod.mk.injEq, (e1 _ h)]
    rename_i _ ih
    simp only [ih (by omega), Bool.bne_right_inj, and_self]
  simp only [Neg.neg, BitStream.neg, neg_congr_lemma]

theorem not_congr (e1 : a ≈ʷ b) : (~~~a) ≈ʷ ~~~b := by
  intros g h
  simp only [not_eq, e1 g h]

theorem equal_trans  (e1 :  a ≈ʷ b) (e2 : c ≈ʷ d)  : (a ≈ʷ c) = (b ≈ʷ d) := by
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
