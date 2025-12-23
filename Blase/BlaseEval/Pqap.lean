import Blase
set_option warn.sorry false
open BitVec

@[bv_normalize]
def select (s : BitVec 1) {w : Nat} (a b : BitVec w) : BitVec w :=
  (s.signExtend w &&& a) ||| (~~~(s.signExtend w) &&& b)

namespace AbsDiffSharedSubUnsigned
/-
From:

input a: w
input b: w
input s: 1
a_minus_b: w <- a - b
b_minus_a: w <- b - a
output z : w <- s.select(a_minus_b, b_minus_a)
-/
def pfrom (a b : BitVec w) (s : BitVec 1) : BitVec w :=
  let a_minus_b := a - b
  let b_minus_a := b - a
  select s a_minus_b b_minus_a


/-
To:

input a: w
input b: w
input s: 1
a_or_b <- s.select(a, b)
b_or_a <- s.select(b, a)
output z : w <- a_or_b - b_or_a
-/
def pto (a b : BitVec w) (s : BitVec 1) : BitVec w :=
  let a_or_b := select s a b
  let b_or_a := select s b a
  a_or_b - b_or_a

theorem correct : ∀ (a b : BitVec w) (s : BitVec 1), pfrom a b s = pto a b s := by
  intro a b s
  simp [pfrom, pto, select]
  bv_multi_width
end AbsDiffSharedSubUnsigned

namespace AbsDiffSharedSubSigned
/-
input a: w signed
input b: w signed
input s: 1
a_minus_b: w signed <- a - b
b_minus_a: w signed <- b - a
output z: w signed <- s.select(a_minus_b, b_minus_a)
-/
def pfrom (a b : BitVec w) (s : BitVec 1) : BitVec w :=
  let a_minus_b := a - b
  let b_minus_a := b - a
  select s a_minus_b b_minus_a

/-
input a: w signed
input b: w signed
input s: 1
a_or_b: w signed <- s.select(a, b)
b_or_a: w signed <- s.select(b, a)
output z: w signed <- a_or_b - b_or_a
-/
def pto (a b : BitVec w) (s : BitVec 1) : BitVec w :=
  let a_or_b := select s a b
  let b_or_a := select s b a
  a_or_b - b_or_a

theorem correct : ∀ (a b : BitVec w) (s : BitVec 1), pfrom a b s = pto a b s := by
  intro a b s
  simp [pfrom, pto, select]
  bv_multi_width
end AbsDiffSharedSubSigned

namespace UnsignedRounding

-- | TODO: what is the precise semantics in 
@[bv_multi_width_normalize]
def addExtending (a : BitVec w) (b : BitVec v) : BitVec ow :=
  a.zeroExtend _ + b.zeroExtend _

@[bv_multi_width_normalize]
def topBits (a : BitVec w) (n : Nat) : BitVec n :=
  ((a >>> (w - n))).truncate n

@[bv_multi_width_normalize]
def bottomBits (a : BitVec w) (n : Nat) : BitVec n :=
  a.truncate n

notation a "[: " n "]" => topBits a n
notation a "[" n ":]" => bottomBits a n


/-
NOTE (sid): Here we do some preprocessing, where we explicitly write `w2` in terms of `w1 + 1`.
This should be done by our preprocessor, but it's currently not strong enough to handle
append-of-constant-width. This is totally encodable, but needs some elbow grease to be enabled.

Instead, I write the preprocessed format directly.
-/

/-
input a : w1
output z : w2
c <- a[:w2]
d: 1 <- a[1:]
constraint w1 == 1 + w2
constraint w2 > 1
z <- c + d
-/
def v0  (alo : BitVec 1) (ahi : BitVec w2) (a : BitVec (1 + w2)) (hw2 : w2 > 1)
  (ha : a = (alo.zeroExtend (1 + w2) ||| (ahi.zeroExtend (1 + w2) <<< 1))) : BitVec w2 :=
      let c := ahi
      let d := alo
      let z := addExtending c d
      z

/-
input a: w1
output z: w2
c <- a[:w2]
d <- a[1:].zero_extend(2)
constraint w1 == 1 + w2
constraint w2 > 1
z <- c + d
-/

def v1 (alo : BitVec 1) (ahi : BitVec w2) (a : BitVec (1 + w2)) 
  (hw2 : w2 > 1)
  (ha : a = (alo.zeroExtend (1 + w2) ||| (ahi.zeroExtend (1 + w2) <<< 1))) : BitVec w2 :=
      let c := ahi
      let d := alo.zeroExtend 2
      let z := addExtending c d
      z

theorem v0_eq_v1 (alo : BitVec 1) (ahi : BitVec w2) (a : BitVec (1 + w2))
  (hw2 : w2 > 1)
  (ha : a = (alo.zeroExtend (1 + w2) ||| (ahi.zeroExtend (1 + w2) <<< 1))) :
  v0 alo ahi a hw2 ha = v1 alo ahi a hw2 ha := by
    simp only [v0, v1]
    bv_multi_width

/-
input a: w1
output z: w2
c: w1 <- a + 1'b1
constraint w1 == 1 + w2
constraint w2 > 1
z <- c[:w2]
-/
def v2 (alo : BitVec 1) (ahi : BitVec w2) (a : BitVec (1 + w2)) 
  (hw2 : w2 > 1)
  (ha : a = (alo.zeroExtend (1 + w2) ||| (ahi.zeroExtend (1 + w2) <<< 1))) : BitVec w2 :=
      let c := a + 1
      let z := c[:w2]
      z

@[simp, bv_multi_width_normalize]
def bvOnes (n : Nat) : BitVec w :=
    ((1#1).signExtend n).zeroExtend w

/--
Reduction from shift right to shift left.
-/
theorem shiftRight_iff_shiftLeft (x : BitVec w) (n : Nat) (y : BitVec w) :
      ((x >>> n) = y) ↔ ((y <<< n = (x &&& (~~~(bvOnes n)))) ∧ (y &&& bvOnes (w - n) = y)) := by
  constructor
  · intros h 
    subst h 
    simp 
    constructor
    · ext i 
      simp 
      by_cases hi : i = 0 
      · simp [hi]
        rw [BitVec.getLsbD_signExtend]
        subst hi
        simp
        by_cases hn : 0 < n 
        · simp [hn]
        · simp [show n = 0 by omega]
          rfl
      · by_cases hi : i < n 
        · simp [hi]
          intros hx 
          simp [getElem_signExtend]
        · simp [hi]
          simp [show n + (i - n) = i by omega]
          simp [getLsbD_signExtend, hi]
          rfl
    · ext i 
      simp 
      rw [BitVec.getLsbD_signExtend]
      by_cases hi : i < w - n 
      · simp [hi]
      · simp [hi]
        rw [BitVec.getLsbD_of_ge]
        omega
  · intros h 
    ext i 
    obtain ⟨h, h2⟩ := h
    have := congrFun (congrArg BitVec.getLsbD h) i
    simp [BitVec.getLsbD_signExtend] at this
    simp 
    by_cases hi1 : i < w 
    · simp [hi1] at this ⊢
      by_cases hn1 : i < n 
      · simp [hn1] at this ⊢
        have := congrFun (congrArg BitVec.getLsbD h) (n + i)
        simp [hi1] at this
        by_cases hin : n + i < w 
        · simp [hin] at this ⊢
          exact this.symm
        · simp [hin] at this
          simp at hin
          rw [BitVec.getLsbD_of_ge]
          · rw [← h2]
            simp [BitVec.getLsbD_signExtend]
            omega
          · omega
      · rw [← h2]
        simp [BitVec.getLsbD_signExtend]
        by_cases hi2 : i < w - n 
        · simp [hi2]
          have := congrFun (congrArg BitVec.getLsbD h) (n + i)
          simp at this
          simp [show n + i < w by omega] at this
          rw [BitVec.getLsbD_eq_getElem] at this
          · rw [this]
            rfl
          · omega
        · simp [hi2]
          rw [BitVec.getLsbD_of_ge]
          omega
    · simp [hi1] at this ⊢
      simp at hi1
      rw [BitVec.getLsbD_of_ge]
      · rw [← h2]
        simp [BitVec.getLsbD_signExtend]
        omega
      · omega
        

theorem shiftRight_elim (x : BitVec w) (n : Nat) :
    ∃ (y : BitVec w), (x >>> n) = y ∧ (y <<< n = (x &&& (~~~(bvOnes n)))) ∧ (y &&& bvOnes (w - n) = y) := by
  use (x >>> n)
  simp
  sorry

theorem v0_eq_v2 (alo : BitVec 1) (ahi : BitVec w2) (a : BitVec (1 + w2))
  (hw2 : w2 > 1)
  (ha : a = (alo.zeroExtend (1 + w2) ||| (ahi.zeroExtend (1 + w2) <<< 1))) :
  v0 alo ahi a hw2 ha = v2 alo ahi a hw2 ha := by
    simp only [v0, v2]
    simp [topBits, show 1 + w2 - w2 = 1 by omega]
    obtain ⟨ar, har1, har2⟩ := shiftRight_elim (a + 1#_) 1
    rw [har1]
    clear har1
    obtain ⟨hleft, hright⟩ := har2
    simp [bvOnes] at hright
    bv_multi_width_normalize -- TODO: need to add right shift by constant support via quantifiers.
    bv_multi_width

end UnsignedRoundin
