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
def addExtending (a : BitVec w) (b : BitVec v) : BitVec ow :=
  a.zeroExtend _ + b.zeroExtend _

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
constraint w1 == w2 + 1
constraint w2 > 1
z <- c + d
-/
def v0  (alo : BitVec 1) (ahi : BitVec w2) (a : BitVec (w2 + 1)) (z : BitVec w2) (hw2 : w2 > 1)
  (ha : a = alo.zeroExtend (w2 + 1) || (ahi.zeroExtend (w2 + 1) <<< 1)) : 
      let c := ahi
      let d := alo
      let z := c.zeroExtend w2 + d.zeroExtend w2
      z := z
end UnsignedRounding
