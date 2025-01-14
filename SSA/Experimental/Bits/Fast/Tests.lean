/-
Released under Apache 2.0 license as described in the file LICENSE.
This file reflects the semantics of bitstreams, terms, predicates, and FSMs
into lean bitvectors.

We use `grind_norm` to convert the expression into negation normal form.

Authors: Siddharth Bhat
-/
import SSA.Experimental.Bits.Fast.Reflect

/-- Can solve explicitly quantified expressions with intros. bv_automata3. -/
theorem eq1 : ∀ (w : Nat) (a : BitVec w), a = a := by
  intros
  bv_automata_circuit
#print eq1

/-- Can solve implicitly quantified expressions by directly invoking bv_automata3. -/
theorem eq2 (w : Nat) (a : BitVec w) : a = a := by
  bv_automata_circuit
#print eq1

open NNF in

example (w : Nat) (a b : BitVec w) : a + b = b + a := by
  bv_automata_circuit

example (w : Nat) (a b : BitVec w) : (a + b = b + a) ∨ (a = 0#w) := by
  bv_automata_circuit

example (w : Nat) (a b : BitVec w) : (a = 0#w) ∨ (a + b = b + a) := by
  bv_automata_circuit

example (w : Nat) (a : BitVec w) : (a = 0#w) ∨ (a ≠ 0#w) := by
  bv_automata_circuit

example (w : Nat) (a b : BitVec w) : (a + b = b + a) ∧ (a + 0#w = a) := by
  bv_automata_circuit

example (w : Nat) (a b : BitVec w) : (a + 0#w = a) := by
  bv_automata_circuit

example (w : Nat) (a b : BitVec w) : (a + b = b + a) ∧ (a + 0#w = a) := by
  bv_automata_circuit

example (w : Nat) (a b : BitVec w) : (a ≠ b) → (b ≠ a) := by
  bv_automata_circuit

/-- either a < b or b ≤ a -/
example (w : Nat) (a b : BitVec w) : (a < b) ∨ (b ≤ a) := by
  bv_automata_circuit

/-- Tricohotomy of < -/
example (w : Nat) (a b : BitVec w) : (a < b) ∨ (b < a) ∨ (a = b) := by
  bv_automata_circuit

/-- < implies not equals -/
example (w : Nat) (a b : BitVec w) : (a < b) → (a ≠ b) := by
  bv_automata_circuit

/-- <= and >= implies equals -/
example (w : Nat) (a b : BitVec w) : ((a ≤ b) ∧ (b ≤ a)) → (a = b) := by
  bv_automata_circuit

example (a b : BitVec 1) : (a - b).slt 0 → a.slt b := by
  fail_if_success bv_decide
  -- The prover found a counterexample, consider the following assignment:
  -- a = 0x0#1
  -- b = 0x1#1
  sorry

-- This should succeed.
example (w : Nat) (a b : BitVec w) : (w > 1 ∧ (a - b).slt 0 → a.slt b) := by
  try bv_automata_circuit;
  sorry


/-- Tricohotomy of slt. Currently fails! -/
example (w : Nat) (a b : BitVec w) : (a.slt b) ∨ (b.sle a) := by
  bv_automata_circuit
  -- TODO: I don't understand this metaprogramming error, I must be building the term weirdly...

/-- Tricohotomy of slt. Currently fails! -/
example (w : Nat) (a b : BitVec w) : (a.slt b) ∨ (b.slt a) ∨ (a = b) := by
  bv_automata_circuit
  -- TODO: I don't understand this metaprogramming error, I must be building the term weirdly...

/-- a <=s b and b <=s a implies a = b-/
example (w : Nat) (a b : BitVec w) : ((a.sle b) ∧ (b.sle a)) → a = b := by
  bv_automata_circuit
  -- TODO: I don't understand this metaprogramming error, I must be building the term weirdly...

/-- In bitwidth 0, all values are equal.
In bitwidth 1, 1 + 1 = 0.
In bitwidth 2, 1 + 1 = 2 ≠ 0#2
For all bitwidths ≥ 2, we know that a ≠ a + 1
-/
example (w : Nat) (a : BitVec w) : (a ≠ a + 1#w) ∨ (1#w + 1#w = 0#w) ∨ (1#w = 0#w):= by
  bv_automata_circuit

/-- If we have that 'a &&& a = 0`, then we know that `a = 0` -/
example (w : Nat) (a : BitVec w) : (a &&& a = 0#w) → a = 0#w := by
  bv_automata_circuit

/--
Is this true at bitwidth 1? Not it is not!
So we need an extra hypothesis that rules out bitwifth 1.
We do this by saying that either the given condition, or 1+1 = 0.
I'm actually not sure why I need to rule out bitwidth 0? Mysterious!
-/
example (w : Nat) (a : BitVec w) : (w = 2) → ((a = - a) → a = 0#w) := by
  fail_if_success bv_automata_circuit
  sorry


example (w : Nat) (a : BitVec w) : (w = 1) → (a = 0#w ∨ a = 1#w) := by bv_automata_circuit
example (w : Nat) (a : BitVec w) : (w = 0) → (a = 0#w ∨ a = 1#w) := by bv_automata_circuit
example (w : Nat) : (w = 1) → (1#w + 1#w = 0#w) := by bv_automata_circuit
example (w : Nat) : (w = 0) → (1#w + 1#w = 0#w) := by bv_automata_circuit
example (w : Nat) : ((w = 0) ∨ (w = 1)) → (1#w + 1#w = 0#w) := by bv_automata_circuit

example (w : Nat) : (1#w + 1#w = 0#w) → ((w = 0) ∨ (w = 1)):= by
  bv_automata_circuit
/-
We can say that we are at bitwidth 1 by saying that 1 + 1 = 0.
When we have this, we then explicitly enumerate the different values that a can have.
Note that this is pretty expensive.
-/
example (w : Nat) (a : BitVec w) : (1#w + 1#w = 0#w) → (a = 0#w ∨ a = 1#w) := by
  bv_automata_circuit

example (w : Nat) (a b : BitVec w) : (a + b = 0#w) → a = - b := by
  bv_automata_circuit


/-- Can use implications -/
theorem eq_circuit (w : Nat) (a b : BitVec w) : (a &&& b = 0#w) → ((a + b) = (a ||| b)) := by
  bv_nnf
  bv_automata_circuit

#print eq_circuit


/-- Can exploit hyps -/
theorem eq4 (w : Nat) (a b : BitVec w) (h : a &&& b = 0#w) : a + b = a ||| b := by
  bv_automata_circuit

#print eq_circuit

section BvAutomataTests

/-!
# Test Cases
-/

/--
warning: Tactic has not understood the following expressions, and will treat them as symbolic:

  - 'f x'
  - 'f y'
-/
#guard_msgs (warning, drop error, drop info) in
theorem test_symbolic_abstraction (f : BitVec w → BitVec w) (x y : BitVec w) : f x ≠ f y :=
  by bv_automata_circuit

/-- Check that we correctly handle `OfNat.ofNat 1`. -/
theorem not_neg_eq_sub_one (x : BitVec 53) :
    ~~~ (- x) = x - 1 := by
  bv_automata_circuit

/-- Check that we correctly handle multiplication by two. -/
theorem sub_eq_mul_and_not_sub_xor (x y : BitVec w):
    x - y = 2 * (x &&& ~~~ y) - (x ^^^ y) := by
  -- simp [Simplifications.BitVec.OfNat_ofNat_mul_eq_ofNat_mul]
  -- simp only [BitVec.ofNat_eq_ofNat, Simplifications.BitVec.two_mul_eq_add_add]
  all_goals bv_automata_circuit (config := {circuitSizeThreshold := 140 })


/- See that such problems have large circuit sizes, but small state spaces -/
def alive_1 {w : ℕ} (x x_1 x_2 : BitVec w) : (x_2 &&& x_1 ^^^ x_1) + 1#w + x = x - (x_2 ||| ~~~x_1) := by
  bv_automata_circuit (config := { circuitSizeThreshold := 107 })


def false_statement {w : ℕ} (x y : BitVec w) : x = y := by
  fail_if_success bv_automata_circuit
  sorry

def test_OfNat_ofNat (x : BitVec 1) : 1#1 + x = x + 1#1 := by
  bv_automata_circuit -- can't decide things for fixed bitwidth.

def test0 {w : Nat} (x y : BitVec w) : x + 0#w = x := by
  bv_automata_circuit


def test_simple2 {w : Nat} (x y : BitVec w) : x = x := by
  bv_automata_circuit

def test1 {w : Nat} (x y : BitVec w) : (x ||| y) - (x ^^^ y) = x &&& y := by
  bv_automata_circuit


def test4 (x y : BitVec w) : (x + -y) = (x - y) := by
  bv_automata_circuit

def test5 (x y z : BitVec w) : (x + y + z) = (z + y + x) := by
  bv_automata_circuit


def test6 (x y z : BitVec w) : (x + (y + z)) = (x + y + z) := by
  bv_automata_circuit

def test11 (x y : BitVec w) : (x + y) = ((x |||  y) +  (x &&&  y)) := by
  bv_automata_circuit


def test15 (x y : BitVec w) : (x - y) = (( x &&& (~~~ y)) - ((~~~ x) &&&  y)) := by
  bv_automata_circuit

def test17 (x y : BitVec w) : (x ^^^ y) = ((x ||| y) - (x &&& y)) := by
  bv_automata_circuit


def test18 (x y : BitVec w) : (x &&&  (~~~ y)) = ((x ||| y) - y) := by
  bv_automata_circuit


def test19 (x y : BitVec w) : (x &&&  (~~~ y)) = (x -  (x &&& y)) := by
  bv_automata_circuit


def test21 (x y : BitVec w) : (~~~(x - y)) = (~~~x + y) := by
  bv_automata_circuit

def test2_circuit (x y : BitVec w) : (~~~(x ^^^ y)) = ((x &&& y) + ~~~(x ||| y)) := by
  bv_automata_circuit

def test24 (x y : BitVec w) : (x ||| y) = (( x &&& (~~~y)) + y) := by
  bv_automata_circuit

/--
info: 'test24' depends on axioms: [propext, Classical.choice, Lean.ofReduceBool, Lean.trustCompiler, Quot.sound]
-/
#guard_msgs in #print axioms test24

/--
info: def test24 : ∀ {w : ℕ} (x y : BitVec w), x ||| y = (x &&& ~~~y) + y :=
fun {w} x y =>
  id
    (Predicate.denote_of_eval_eq
      (of_decide_eq_true
        (Lean.ofReduceBool
          (decide
            (∀ (w : ℕ) (vars : List BitStream),
              (Predicate.eq ((Term.var 0).or (Term.var 1)) (((Term.var 0).and (Term.var 1).not).add (Term.var 1))).eval
                  vars w =
                false))
          true SSA.Experimental.Bits.Fast.Tests._auxLemma.18))
      w (Reflect.Map.append w y (Reflect.Map.append w x Reflect.Map.empty)))
-/
#guard_msgs in #print test24

def test25 (x y : BitVec w) : (x &&& y) = (((~~~x) ||| y) - ~~~x) := by
  bv_automata_circuit

def test26 {w : Nat} (x y : BitVec w) : 1#w + x + 0#w = 1#w + x := by
  bv_automata_circuit

/-- NOTE: we now support 'ofNat' literals -/
def test27 (x y : BitVec w) : 2#w + x  = 1#w  + x + 1#w := by
  bv_automata_circuit

def test28 {w : Nat} (x y : BitVec w) : x &&& x &&& x &&& x &&& x &&& x = x := by
  bv_automata_circuit

example : ∀ (w : Nat) , (BitVec.ofNat w 1) &&& (BitVec.ofNat w 3) = BitVec.ofNat w 1 := by
  intros
  bv_automata_circuit

example : ∀ (w : Nat) (x : BitVec w), -1#w &&& x = x := by
  intros
  bv_automata_circuit

example : ∀ (w : Nat) (x : BitVec w), x <<< (0 : Nat) = x := by intros; bv_automata_circuit
example : ∀ (w : Nat) (x : BitVec w), x <<< (1 : Nat) = x + x := by intros; bv_automata_circuit
example : ∀ (w : Nat) (x : BitVec w), x <<< (2 : Nat) = x + x + x + x := by
  intros w n
  -- rw [BitVec.ofNat_eq_ofNat (n := w) (i := 2)]
  intros; bv_automata_circuit

/-- Can solve width-constraints problems -/
def test30  : (w = 2) → 8#w = 0#w := by
  bv_automata_circuit

/-- Can solve width-constraints problems -/
def test31 (w : Nat) (x : BitVec w) : x &&& x = x := by
  bv_automata_circuit (config := { stateSpaceSizeThreshold := 100 })

theorem neg_eq_not_add_one (x : BitVec w) :
    -x = ~~~ x + 1#w := by
  bv_automata_circuit

theorem add_eq_xor_add_mul_and (x y : BitVec w) :
    x + y = (x ^^^ y) + (x &&& y) + (x &&& y) := by
  bv_automata_circuit (config := { circuitSizeThreshold := 300 } )

theorem add_eq_xor_add_mul_and' (x y : BitVec w) :
    x + y = (x ^^^ y) + (x &&& y) + (x &&& y) := by
  bv_automata_circuit (config := { circuitSizeThreshold := 300 } )

theorem add_eq_xor_add_mul_and_nt (x y : BitVec w) :
    x + y = (x ^^^ y) + 2 * (x &&& y) := by
  bv_automata_circuit

/-- Check that we correctly process an even numeral multiplication. -/
theorem mul_four (x : BitVec w) : 4 * x = x + x + x + x := by
  bv_automata_circuit

/-- Check that we correctly process an odd numeral multiplication. -/
theorem mul_five (x : BitVec w) : 5 * x = x + x + x + x + x := by
  bv_automata_circuit (config := { backend := .cadical })

open BitVec in
/-- Check that we support sign extension. -/
theorem sext
    (b : BitVec 8)
    (c : ¬(11#9 - signExtend 9 (b &&& 7#8)).msb = (11#9 - signExtend 9 (b &&& 7#8)).getMsbD 1) :
    False := by
  fail_if_success bv_automata_circuit
  sorry

/-- Check that we support zero extension. -/
theorem zext (b : BitVec 8) : (b.zeroExtend 10 |>.zeroExtend 8) = b := by
  fail_if_success bv_automata_circuit
  sorry

/-- Can solve width-constraints problems, when written with a width constraint. -/
def width_specific_1 (x : BitVec w) : w = 1 →  x + x = x ^^^ x := by
  bv_automata_circuit


example (x : BitVec 0) : x = x + 0#0 := by
  bv_automata_circuit

/-- All bitvectors are equal at width 0 -/
example (x y : BitVec w) (hw : w = 0) : x = y := by
  bv_automata_circuit

/-- At width 1, adding bitvector to itself four times gives 0. Characteristic equals 2 -/
def width_1_char_2 (x : BitVec w) (hw : w = 1) : x + x = 0#w := by
  bv_automata_circuit

/-- At width 1, adding bitvector to itself four times gives 0. Characteristic 2 divides 4 -/
def width_1_char_2_add_four (x : BitVec w) (hw : w = 1) : x + x + x + x = 0#w := by
  bv_automata_circuit

/--
info: 'width_1_char_2_add_four' depends on axioms: [propext,
 Classical.choice,
 Lean.ofReduceBool,
 Lean.trustCompiler,
 Quot.sound]
-/
#guard_msgs in #print axioms width_1_char_2_add_four

set_option trace.profiler true  in
/-- warning: declaration uses 'sorry' -/
theorem slow₁ (x : BitVec 32) :
    63#32 - (x &&& 31#32) = x &&& 31#32 ^^^ 63#32 := by
  fail_if_success bv_automata_circuit (config := { circuitSizeThreshold := 30, stateSpaceSizeThreshold := 24 } )
  sorry

theorem e_1 (x y : BitVec w) :
     - 1 *  ~~~(x ^^^ y) - 2 * y + 1 *  ~~~x =  - 1 *  ~~~(x |||  ~~~y) - 3 * (x &&& y) := by
  bv_automata_circuit (config := { backend := .cadical })

end BvAutomataTests
