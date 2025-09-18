import Blase

namespace MultiWidthTests
set_option warn.sorry false

theorem add_eq_xor_add_mul_and_zext (x y : BitVec w) :
    x.zeroExtend (w + 1) + y.zeroExtend (w + 1) =
      (x ^^^ y).zeroExtend (w + 1) + (x &&& y).zeroExtend (w + 1) <<< 1 := by
  bv_multi_width

/--
info: 'MultiWidthTests.add_eq_xor_add_mul_and_zext' depends on axioms: [propext,
 Classical.choice,
 Lean.ofReduceBool,
 Lean.trustCompiler,
 Quot.sound]
-/
#guard_msgs in #print axioms add_eq_xor_add_mul_and_zext

theorem eg5 (u w : Nat) (x : BitVec w) :
    (x.signExtend u).zeroExtend u = x.signExtend u := by
  bv_multi_width

theorem eg6 (u w : Nat) (x : BitVec w) :
    (x.zeroExtend u).signExtend u = x.zeroExtend u := by
  bv_multi_width (config := { niter := 0 })

theorem test28 {w : Nat} (x : BitVec w) :
    x &&& x &&& x &&& x &&& x &&& x = x := by
  bv_multi_width (config := { niter := 2 })

def test4 (x y : BitVec w) : (x ||| y) = y ||| x := by
  bv_multi_width

def test5 (x y : BitVec w) : (x + y) = (y + x) := by
  bv_multi_width

def test6 (x y z : BitVec w) : (x + (y + z)) = ((x + y) + z) := by
  bv_multi_width

theorem add_eq_or_add_and (x y : BitVec w) :
    x + y = (x ||| y) + (x &&& y) := by
  bv_multi_width

theorem add_eq_xor_add_mul_and_1 (x y : BitVec w) :
    x + y = (x ^^^ y) + 2 * (x &&& y) := by
  bv_multi_width

theorem add_eq_xor_add_mul_and_2 (x y : BitVec w) :
    x + y = (x ^^^ y) + (x &&& y) <<< 1 := by
  bv_multi_width

theorem add_eq_xor_add_mul_and_3 (x y : BitVec w) :
    x + y = (x ^^^ y) + (x &&& y) * 2#w := by
  bv_multi_width

def test26 {w : Nat} (x : BitVec w) : 1#w + x + 0#w = 1#w + x := by
  bv_multi_width

/-- NOTE: we now support 'ofNat' literals -/
def test27 (x : BitVec w) : 2#w + x  = 1#w  + x + 1#w := by
  bv_multi_width

/-- For fixed-width problems, we encode constraints correctly, and understand
e.g. characteristic. -/
theorem egFixedWidthTwo (x : BitVec 2) : x + x + x + x = 0 := by
  bv_multi_width (config := { widthAbstraction := .never })

/-- We understand constant numerals. -/
theorem egConstNumeral (w : Nat) (x : BitVec w) : x + 2 = x + 1 + 1 := by
  bv_multi_width

/-- We understand constant BVs. -/
theorem egConstBV (w : Nat) (x : BitVec w) : x + (2#w) = x + (1#w) + (1#w) := by
  bv_multi_width

/-- Can solve explicitly quantified expressions -/
theorem eq1 : ∀ (w : Nat) (a : BitVec w), a = a := by
  intros
  bv_multi_width (config := { niter := 2 })


/-- Can solve implicitly quantified expressions by directly invoking bv_automata3. -/
theorem eq2 (w : Nat) (a : BitVec w) : a = a := by
  bv_multi_width

theorem eq3 (w : Nat) (a : BitVec w) : a = a ||| 0 := by
  bv_multi_width

theorem check_add_comm (w : Nat) (a b : BitVec w) : a + b = b + a := by
  bv_multi_width

-- For some reason, this fails. I don't understand why.
example (w : Nat) (a : BitVec w) : (a = a + 0#w) := by
  bv_multi_width

example (w : Nat) (a : BitVec w) :  (a * 3 = a + a + a)  := by
  bv_multi_width

/-- We know that all bitvectors are equal at width 0 -/
example (a b : BitVec 0) : a = b  := by
  bv_multi_width (config := { widthAbstraction := .never })


/-- Can solve conjunctions. -/
example (w : Nat) (a b : BitVec w) : (a + b = b + a) ∧ (a + a = a <<< 1) := by
  bv_multi_width

example (w : Nat) (a b : BitVec w) : (a ≠ b) → (b ≠ a) := by
  bv_multi_width

/-- either a < b or b ≤ a -/
example (w : Nat) (a b : BitVec w) : (a < b) ∨ (b ≤ a) := by
  bv_multi_width

/-- Tricohotomy of < -/
example (w : Nat) (a b : BitVec w) : (a < b) ∨ (b < a) ∨ (a = b) := by
  bv_multi_width

/-- < implies not equals -/
example (w : Nat) (a b : BitVec w) : (a < b) → (a ≠ b) := by
  bv_multi_width

/-- <= and >= implies equals -/
example (w : Nat) (a b : BitVec w) : ((a ≤ b) ∧ (b ≤ a)) → (a = b) := by
  bv_multi_width

-- This should succeed.
example (w : Nat) (a b : BitVec w) : ((a - b).slt 0 → a.slt b) := by
  -- | TODO: handle width constraints.
  fail_if_success bv_multi_width
  sorry

/-- Tricohotomy of slt. Currently runs out of k-induction iterations! -/
example (w : Nat) (a b : BitVec w) : (a.slt b) ∨ (b.sle a) := by
  fail_if_success bv_multi_width (config := { niter := 10 })
  sorry

/-- Tricohotomy of slt. Currently fails! -/
example (w : Nat) (a b : BitVec w) : (a.slt b) ∨ (b.slt a) ∨ (a = b) := by
  fail_if_success bv_multi_width (config := { niter := 15 })
  sorry

/-- a <=s b and b <=s a implies a = b-/
example (w : Nat) (a b : BitVec w) : ((a.sle b) ∧ (b.sle a)) → a = b := by
  fail_if_success bv_multi_width (config := { niter := 15 })
  sorry


/-- In bitwidth 0, all values are equal.
In bitwidth 1, 1 + 1 = 0.
In bitwidth 2, 1 + 1 = 2 ≠ 0#2
For all bitwidths ≥ 2, we know that a ≠ a + 1
-/
example (w : Nat) (a : BitVec w) : (a ≠ a + 1#w) ∨ (1#w + 1#w = 0#w) ∨ (1#w = 0#w):= by
  bv_multi_width

/-- If we have that 'a &&& a = 0`, then we know that `a = 0` -/
example (w : Nat) (a : BitVec w) : (a &&& a = 0#w) → a = 0#w := by
   bv_multi_width

/--
Is this true at bitwidth 1? Not it is not!
So we need an extra hypothesis that rules out bitwifth 1.
We do this by saying that either the given condition, or 1+1 = 0.
I'm actually not sure why I need to rule out bitwidth 0? Mysterious!
-/
example (w : Nat) (a : BitVec w) : (w = 2) → ((a = - a) → a = 0#w) := by
  fail_if_success bv_multi_width
  sorry


example (w : Nat) (a : BitVec w) : (w = 1) → (a = 0#w ∨ a = 1#w) := by
  fail_if_success bv_multi_width
  sorry

example (w : Nat) : (w = 1) → (1#w + 1#w = 0#w) := by
  fail_if_success bv_multi_width
  sorry

example (w : Nat) : (1#w + 1#w = 0#w) → ((w = 0) ∨ (w = 1)):= by
  fail_if_success bv_multi_width
  sorry

example (w : Nat) : (1#w + 1#w = 0#w) → (w < 2) := by
  fail_if_success bv_multi_width
  sorry

example (w : Nat) (a b : BitVec w) : (a + b = a - a) → a = - b := by
  bv_multi_width

/-- Can use implications -/
theorem eq_gen (w : Nat) (a b : BitVec w) : (a &&& b = 0#w) → ((a + b) = (a ||| b)) := by
  bv_multi_width

/-- Can exploit hyps, without needing to explicitly call 'revert'. -/
theorem eq4 (w : Nat) (a b : BitVec w) (h : a &&& b = 0#w) : a + b = a ||| b := by
  bv_multi_width


/-- Check that we correctly handle `OfNat.ofNat 1`. -/
theorem not_neg_eq_sub_one (x : BitVec w) :
    ~~~ (- x) = x - 1 := by
  bv_multi_width

/-- Check that we correctly handle multiplication by two. -/
theorem sub_eq_mul_and_not_sub_xor (x y : BitVec w):
    x - y = 2 * (x &&& ~~~ y) - (x ^^^ y) := by
  bv_multi_width


/- See that such problems have large gen sizes, but small state spaces -/
def alive_1 {w : ℕ} (x x_1 x_2 : BitVec w) : (x_2 &&& x_1 ^^^ x_1) + 1#w + x = x - (x_2 ||| ~~~x_1) := by
  bv_multi_width


def test_OfNat_ofNat (x : BitVec 1) : 1#1 + x = x + 1#1 := by
  bv_multi_width (config := { niter := 2, widthAbstraction := .never  })

def test0 {w : Nat} (x : BitVec w) : x + 0#w = x := by
  bv_multi_width

def test_simple2 {w : Nat} (x _y : BitVec w) : x = x := by
  bv_multi_width (config := { niter := 2 })

def test1 {w : Nat} (x y : BitVec w) : (x ||| y) - (x ^^^ y) = x &&& y := by
  bv_multi_width

example (x y : BitVec w) : (x + -y) = (x - y) := by
  bv_multi_width (config := { niter := 2 })

example (x y z : BitVec w) : (x + y + z) = (z + y + x) := by
  bv_multi_width

def test11 (x y : BitVec w) : (x + y) = ((x |||  y) + (x &&&  y)) := by
  bv_multi_width

def test15 (x y : BitVec w) : (x - y) = (( x &&& (~~~ y)) - ((~~~ x) &&&  y)) := by
  bv_multi_width

def test17 (x y : BitVec w) : (x ^^^ y) = ((x ||| y) - (x &&& y)) := by
  bv_multi_width

def test18 (x y : BitVec w) : (x &&&  (~~~ y)) = ((x ||| y) - y) := by
  bv_multi_width

def test19 (x y : BitVec w) : (x &&&  (~~~ y)) = (x -  (x &&& y)) := by
  bv_multi_width

def test21 (x y : BitVec w) : (~~~(x - y)) = (~~~x + y) := by
  bv_multi_width

def test2_gen (x y : BitVec w) : (~~~(x ^^^ y)) = ((x &&& y) + ~~~(x ||| y)) := by
  bv_multi_width

def test24 (x y : BitVec w) : (x ||| y) = (( x &&& (~~~y)) + y) := by
  bv_multi_width

def test25 (x y : BitVec w) : (x &&& y) = (((~~~x) ||| y) - ~~~x) := by
  bv_multi_width

example : ∀ (w : Nat) , (BitVec.ofNat w 1) &&& (BitVec.ofNat w 3) = BitVec.ofNat w 1 := by
  intros
  bv_multi_width (config := { niter := 2 })

--set_option trace.Bits.FastVerif true in
example : ∀ (w : Nat) (x : BitVec w), -1#w &&& x = x := by
  fail_if_success bv_multi_width
  sorry

example : ∀ (w : Nat) (x : BitVec w), x <<< (0 : Nat) = x := by
  intros
  bv_multi_width (config := { niter := 2 })

example : ∀ (w : Nat) (x : BitVec w), x <<< (1 : Nat) = x + x := by
  intros
  bv_multi_width (config := { niter := 2 })

example : ∀ (w : Nat) (x : BitVec w), x <<< (2 : Nat) = x + x + x + x := by
  intros; bv_multi_width

/-- Can solve width-constraints problems -/
def test30  : (w = 2) → 8#w = 0#w := by
  fail_if_success bv_multi_width
  sorry

/-- Can solve width-constraints problems -/
def test31 (w : Nat) (x : BitVec w) : x &&& x = x := by
  bv_multi_width (config := { niter := 2 })

theorem neg_eq_not_add_one (x : BitVec w) :
    -x = ~~~ x + 1#w := by
  bv_multi_width (config := { niter := 2 })

theorem add_eq_xor_add_mul_and (x y : BitVec w) :
    x + y = (x ^^^ y) + (x &&& y) + (x &&& y) := by
  bv_multi_width

theorem add_eq_xor_add_mul_and' (x y : BitVec w) :
    x + y = (x ^^^ y) + (x &&& y) + (x &&& y) := by
  bv_multi_width

/-- Check that we correctly process an even numeral multiplication. -/
theorem mul_four (x : BitVec w) : 4 * x = x + x + x + x := by
  bv_multi_width

theorem add_eq (x : BitVec w) : x = x + 0 := by
  bv_multi_width

theorem add_five (x : BitVec w) : (x + x) + (x + x) + x = x + x + x + x + x := by
  bv_multi_width

/-- Check that we correctly process an odd numeral multiplication. -/
theorem mul_five (x : BitVec w) : 5 * x = x + x + x + x + x := by
  bv_multi_width

/-- Check that we support zero extension. -/
theorem zext (b : BitVec 8) : (b.zeroExtend 10 |>.zeroExtend 8) = b := by
  bv_multi_width (config := { widthAbstraction := .never })

/-- Can solve width-constraints problems, when written with a width constraint. -/
def width_specific_1 (x : BitVec w) : w = 1 →  x + x = x ^^^ x := by
  fail_if_success bv_multi_width
  sorry

/-- All bitvectors are equal at width 0 -/
example (x y : BitVec w) (hw : w = 0) : x = y := by
  fail_if_success bv_multi_width
  sorry

/-- At width 1, adding bitvector to itself four times gives 0. Characteristic equals 2 -/
def width_1_char_2 (x : BitVec w) (hw : w = 1) : x + x = 0#w := by
  fail_if_success bv_multi_width
  sorry

/-- At width 1, adding bitvector to itself four times gives 0. Characteristic 2 divides 4 -/
def width_1_char_2_add_four (x : BitVec w) (hw : w = 1) : x + x + x + x = 0#w := by
  fail_if_success bv_multi_width
  sorry

theorem e_1 (x y : BitVec w) :
     - 1 *  ~~~(x ^^^ y) - 2 * y + 1 *  ~~~x =  - 1 *  ~~~(x |||  ~~~y) - 3 * (x &&& y) := by
  -- So we should have subtraction as a primitive, so that we don't get stuck
  -- in simplification.
  -- → '(~~~1#w + 1#w) * ~~~(x ||| ~~~y)'
  fail_if_success bv_multi_width +verbose?
  sorry

theorem egZextMin (u v : Nat) (x : BitVec w) :
    u ≤ v → (x.zeroExtend u).zeroExtend v = x.zeroExtend v := by
  fail_if_success bv_multi_width
  sorry

example (w : Nat) (a : BitVec w) : a = a + 0#w := by
  bv_multi_width

end MultiWidthTests
