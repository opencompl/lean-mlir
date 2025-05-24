/-
Released under Apache 2.0 license as described in the file LICENSE.
This file reflects the semantics of bitstreams, terms, predicates, and FSMs
into lean bitvectors.

We use `grind_norm` to convert the expression into negation normal form.

Authors: Siddharth Bhat
-/
import SSA.Experimental.Bits.Frontend.Tactic
import SSA.Experimental.Bits.Fast.MBA

set_option linter.unusedVariables false

set_option trace.Bits.Fast true

/-- Can solve explicitly quantified expressions with intros. bv_automata3. -/
theorem eq1 : ∀ (w : Nat) (a : BitVec w), a = a := by
  intros
  bv_automata_gen (config := {backend := .circuit_cadical} )

/-- Can solve implicitly quantified expressions by directly invoking bv_automata3. -/
theorem eq2 (w : Nat) (a : BitVec w) : a = a := by
  bv_automata_gen (config := {backend := .circuit_cadical} )

def lhs : Bool := Reflect.BvDecide.verifyAIG
      (Reflect.BvDecide.mkSafetyCircuit
          (predicateEvalEqFSM
              (Predicate.binary BinaryPredicate.eq ((Term.var 0).add (Term.var 1))
                ((Term.var 1).add (Term.var 0)))).toFSM
          3).toAIG
      "3 0 1 2 0\n"

theorem y : lhs = true := Lean.ofReduceBool _ _ rfl

theorem x : Reflect.BvDecide.verifyAIG
      (Reflect.BvDecide.mkSafetyCircuit
          (predicateEvalEqFSM
              (Predicate.binary BinaryPredicate.eq ((Term.var 0).add (Term.var 1))
                ((Term.var 1).add (Term.var 0)))).toFSM
          3).toAIG
      "3 0 1 2 0\n" = true := y



example (w : Nat) (a b : BitVec w) : a + b = b + a := by
  bv_automata_gen (config := {backend := .circuit_cadical} )

example (w : Nat) (a b : BitVec w) : (a + b = b + a)  := by
  bv_automata_gen (config := {backend := .circuit_cadical} )

example (w : Nat) (a : BitVec w) : (a = a + 0#w) ∨ (a = a - a)  := by
  bv_automata_gen (config := {backend := .circuit_cadical 20 } )

example (w : Nat) (a : BitVec w) :  (a = a + 0#w)  := by
  bv_automata_gen (config := {backend := .circuit_cadical 20 } )

example (w : Nat) (a : BitVec w) : (a ≠ a - a)  := by
  -- this cannot be true, because it's false at width 0
  fail_if_success bv_automata_gen (config := {backend := .circuit_cadical 5 } )
  sorry

example (w : Nat) (a : BitVec w) : (a = 0#w) := by
  -- bv_automata_gen
  fail_if_success bv_automata_gen (config := {backend := .circuit_cadical 20 } )
  sorry

/-
Init: 0:st → false
Init: 1:st → false
Init: 2:st → false
Init: 3:st → false
Init: 4:st → false
'(and (or v:(l 0:st) v:(l 1:st)) (or v:(l 2:st) v:(l 3:st)))'
**State Transition:**
  0:st: '(or v:(l 0:st) v:(l 1:st))' -- accumulate failure from [1], and check that (a=0)
  1:st: 'v:(r 0:in)' -- store value from the input stream [from a=0]
  2:st: '(or v:(l 2:st) v:(l 3:st))' -- accumulate failure from [3]
  3:st: '(xor v:(r 0:in) (xor v:(r 0:in) v:(l 4:st)))' ~= v:(4:st)
  4:st: '(and v:(r 0:in) v:(l 4:st))' ' -- accumulate failure, and check that a=0.
-/
example (w : Nat) (a : BitVec w) : (a = 0#w) ∨ (a = a + 0#w)  := by
  bv_automata_gen
  -- bv_automata_gen (config := {backend := .circuit_cadical 20 } )


example (w : Nat) (a b : BitVec w) : (a = 0#w) ∨ (a + b = b + a) := by
  -- bv_automata_gen (config := {backend := .circuit_cadical} )
  sorry

example (w : Nat) (a : BitVec w) : (a = 0#w) ∨ (a ≠ 0#w) := by
  bv_automata_gen (config := {backend := .circuit_cadical} )

example (w : Nat) (a b : BitVec w) : (a + b = b + a) ∧ (a + 0#w = a) := by
  bv_automata_gen (config := {backend := .circuit_cadical} )

example (w : Nat) (a b : BitVec w) : (a + 0#w = a) := by
  bv_automata_gen (config := {backend := .circuit_cadical} )

example (w : Nat) (a b : BitVec w) : (a + b = b + a) ∧ (a + 0#w = a) := by
  bv_automata_gen (config := {backend := .circuit_cadical} )

example (w : Nat) (a b : BitVec w) : (a ≠ b) → (b ≠ a) := by
  bv_automata_gen (config := {backend := .circuit_cadical} )

/-- either a < b or b ≤ a -/
example (w : Nat) (a b : BitVec w) : (a < b) ∨ (b ≤ a) := by
  bv_automata_gen (config := {backend := .circuit_cadical} )

/-- Tricohotomy of < -/
example (w : Nat) (a b : BitVec w) : (a < b) ∨ (b < a) ∨ (a = b) := by
  bv_automata_gen (config := {backend := .circuit_cadical} )

/-- < implies not equals -/
example (w : Nat) (a b : BitVec w) : (a < b) → (a ≠ b) := by
  bv_automata_gen (config := {backend := .circuit_cadical} )

/-- <= and >= implies equals -/
example (w : Nat) (a b : BitVec w) : ((a ≤ b) ∧ (b ≤ a)) → (a = b) := by
  bv_automata_gen (config := {backend := .circuit_cadical} )

example (a b : BitVec 1) : (a - b).slt 0 → a.slt b := by
  fail_if_success bv_decide
  -- The prover found a counterexample, consider the following assignment:
  -- a = 0x0#1
  -- b = 0x1#1
  sorry

-- This should succeed.
example (w : Nat) (a b : BitVec w) : (w > 1 ∧ (a - b).slt 0 → a.slt b) := by
  try bv_automata_gen;
  sorry


/-- Tricohotomy of slt. Currently fails! -/
example (w : Nat) (a b : BitVec w) : (a.slt b) ∨ (b.sle a) := by
  bv_automata_gen (config := {backend := .circuit_cadical} )
  -- TODO: I don't understand this metaprogramming error, I must be building the term weirdly...

/-- Tricohotomy of slt. Currently fails! -/
example (w : Nat) (a b : BitVec w) : (a.slt b) ∨ (b.slt a) ∨ (a = b) := by
  bv_automata_gen (config := {backend := .circuit_cadical} )
  -- TODO: I don't understand this metaprogramming error, I must be building the term weirdly...

/-- a <=s b and b <=s a implies a = b-/
example (w : Nat) (a b : BitVec w) : ((a.sle b) ∧ (b.sle a)) → a = b := by
  bv_automata_gen (config := {backend := .circuit_cadical} )
  -- TODO: I don't understand this metaprogramming error, I must be building the term weirdly...

/-- In bitwidth 0, all values are equal.
In bitwidth 1, 1 + 1 = 0.
In bitwidth 2, 1 + 1 = 2 ≠ 0#2
For all bitwidths ≥ 2, we know that a ≠ a + 1
-/
example (w : Nat) (a : BitVec w) : (a ≠ a + 1#w) ∨ (1#w + 1#w = 0#w) ∨ (1#w = 0#w):= by
  bv_automata_gen (config := {backend := .circuit_cadical} )

/-- If we have that 'a &&& a = 0`, then we know that `a = 0` -/
example (w : Nat) (a : BitVec w) : (a &&& a = 0#w) → a = 0#w := by
  bv_automata_gen (config := {backend := .circuit_cadical} )

/--
Is this true at bitwidth 1? Not it is not!
So we need an extra hypothesis that rules out bitwifth 1.
We do this by saying that either the given condition, or 1+1 = 0.
I'm actually not sure why I need to rule out bitwidth 0? Mysterious!
-/
example (w : Nat) (a : BitVec w) : (w = 2) → ((a = - a) → a = 0#w) := by
  fail_if_success bv_automata_gen
  sorry


example (w : Nat) (a : BitVec w) : (w = 1) → (a = 0#w ∨ a = 1#w) := by
  bv_automata_gen (config := {backend := .circuit_cadical} )
example (w : Nat) (a : BitVec w) : (w = 0) → (a = 0#w ∨ a = 1#w) := by
  bv_automata_gen (config := {backend := .circuit_cadical} )
example (w : Nat) : (w = 1) → (1#w + 1#w = 0#w) := by
  bv_automata_gen (config := {backend := .circuit_cadical} )
example (w : Nat) : (w = 0) → (1#w + 1#w = 0#w) := by
  bv_automata_gen (config := {backend := .circuit_cadical} )
example (w : Nat) : ((w = 0) ∨ (w = 1)) → (1#w + 1#w = 0#w) := by
  bv_automata_gen (config := {backend := .circuit_cadical} )

example (w : Nat) : (1#w + 1#w = 0#w) → ((w = 0) ∨ (w = 1)):= by
  bv_automata_gen (config := {backend := .circuit_cadical} )
/-
We can say that we are at bitwidth 1 by saying that 1 + 1 = 0.
When we have this, we then explicitly enumerate the different values that a can have.
Note that this is pretty expensive.
-/
example (w : Nat) (a : BitVec w) : (1#w + 1#w = 0#w) → (a = 0#w ∨ a = 1#w) := by
  bv_automata_gen (config := {backend := .circuit_cadical} )

example (w : Nat) (a b : BitVec w) : (a + b = 0#w) → a = - b := by
  bv_automata_gen (config := {backend := .circuit_cadical} )


/-- Can use implications -/
theorem eq_gen (w : Nat) (a b : BitVec w) : (a &&& b = 0#w) → ((a + b) = (a ||| b)) := by
  bv_automata_gen (config := {backend := .circuit_cadical} )

/-- Can exploit hyps -/
theorem eq4 (w : Nat) (a b : BitVec w) (h : a &&& b = 0#w) : a + b = a ||| b := by
  bv_automata_gen (config := {backend := .circuit_cadical} )

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
theorem test_symbolic_abstraction (f : BitVec w → BitVec w) (x y : BitVec w) : f x ≠ f y := by
  bv_automata_gen
  sorry

/-- Check that we correctly handle `OfNat.ofNat 1`. -/
theorem not_neg_eq_sub_one (x : BitVec 53) :
    ~~~ (- x) = x - 1 := by
  bv_automata_gen (config := {backend := .circuit_cadical} )

/-- Check that we correctly handle multiplication by two. -/
theorem sub_eq_mul_and_not_sub_xor (x y : BitVec w):
    x - y = 2 * (x &&& ~~~ y) - (x ^^^ y) := by
  -- simp [Simplifications.BitVec.OfNat_ofNat_mul_eq_ofNat_mul]
  -- simp only [BitVec.ofNat_eq_ofNat, Simplifications.BitVec.two_mul_eq_add_add]
  bv_automata_gen (config := {backend := .circuit_cadical} )


/- See that such problems have large gen sizes, but small state spaces -/
def alive_1 {w : ℕ} (x x_1 x_2 : BitVec w) : (x_2 &&& x_1 ^^^ x_1) + 1#w + x = x - (x_2 ||| ~~~x_1) := by
  bv_automata_gen (config := { backend := .circuit_cadical })


def false_statement {w : ℕ} (x y : BitVec w) : x = y := by
  fail_if_success bv_automata_gen
  sorry

def test_OfNat_ofNat (x : BitVec 1) : 1#1 + x = x + 1#1 := by
  bv_automata_gen (config := {backend := .circuit_cadical} )

def test0 {w : Nat} (x y : BitVec w) : x + 0#w = x := by
  bv_automata_gen (config := {backend := .circuit_cadical} )


def test_simple2 {w : Nat} (x y : BitVec w) : x = x := by
  bv_automata_gen (config := {backend := .circuit_cadical} )

def test1 {w : Nat} (x y : BitVec w) : (x ||| y) - (x ^^^ y) = x &&& y := by
  bv_automata_gen


def test4 (x y : BitVec w) : (x + -y) = (x - y) := by
  bv_automata_gen

def test5 (x y z : BitVec w) : (x + y + z) = (z + y + x) := by
  bv_automata_gen (config := {backend := .circuit_cadical} )


def test6 (x y z : BitVec w) : (x + (y + z)) = (x + y + z) := by
  bv_automata_gen (config := {backend := .circuit_cadical} )

def test11 (x y : BitVec w) : (x + y) = ((x |||  y) +  (x &&&  y)) := by
  bv_automata_gen (config := {backend := .circuit_cadical} )


def test15 (x y : BitVec w) : (x - y) = (( x &&& (~~~ y)) - ((~~~ x) &&&  y)) := by
  bv_automata_gen (config := {backend := .circuit_cadical} )

def test17 (x y : BitVec w) : (x ^^^ y) = ((x ||| y) - (x &&& y)) := by
  bv_automata_gen (config := {backend := .circuit_cadical} )


def test18 (x y : BitVec w) : (x &&&  (~~~ y)) = ((x ||| y) - y) := by
  bv_automata_gen (config := {backend := .circuit_cadical} )


def test19 (x y : BitVec w) : (x &&&  (~~~ y)) = (x -  (x &&& y)) := by
  bv_automata_gen (config := {backend := .circuit_cadical} )


def test21 (x y : BitVec w) : (~~~(x - y)) = (~~~x + y) := by
  bv_automata_gen (config := {backend := .circuit_cadical} )

def test2_gen (x y : BitVec w) : (~~~(x ^^^ y)) = ((x &&& y) + ~~~(x ||| y)) := by
  bv_automata_gen (config := {backend := .circuit_cadical} )

def test24 (x y : BitVec w) : (x ||| y) = (( x &&& (~~~y)) + y) := by
  bv_automata_gen (config := {backend := .circuit_cadical} )

/-- info: 'test24' depends on axioms: [propext, Quot.sound, Reflect.BvDecide.decideIfZerosMAx] -/
#guard_msgs in #print axioms test24

def test25 (x y : BitVec w) : (x &&& y) = (((~~~x) ||| y) - ~~~x) := by
  bv_automata_gen (config := {backend := .circuit_cadical} )

def test26 {w : Nat} (x y : BitVec w) : 1#w + x + 0#w = 1#w + x := by
  bv_automata_gen (config := {backend := .circuit_cadical} )

/-- NOTE: we now support 'ofNat' literals -/
def test27 (x y : BitVec w) : 2#w + x  = 1#w  + x + 1#w := by
  bv_automata_gen (config := {backend := .circuit_cadical} )

def test28 {w : Nat} (x y : BitVec w) : x &&& x &&& x &&& x &&& x &&& x = x := by
  bv_automata_gen (config := {backend := .circuit_cadical} )

example : ∀ (w : Nat) , (BitVec.ofNat w 1) &&& (BitVec.ofNat w 3) = BitVec.ofNat w 1 := by
  intros
  bv_automata_gen (config := {backend := .circuit_cadical} )

example : ∀ (w : Nat) (x : BitVec w), -1#w &&& x = x := by
  intros
  bv_automata_gen (config := {backend := .circuit_cadical} )

example : ∀ (w : Nat) (x : BitVec w), x <<< (0 : Nat) = x := by
  intros
  bv_automata_gen (config := {backend := .circuit_cadical} )

example : ∀ (w : Nat) (x : BitVec w), x <<< (1 : Nat) = x + x := by
  intros
  bv_automata_gen (config := {backend := .circuit_cadical} )

example : ∀ (w : Nat) (x : BitVec w), x <<< (2 : Nat) = x + x + x + x := by
  intros w n
  bv_automata_gen (config := {backend := .circuit_cadical} )

/-- Can solve width-constraints problems -/
def test30  : (w = 2) → 8#w = 0#w := by
  bv_automata_gen (config := {backend := .circuit_cadical} )

/-- Can solve width-constraints problems -/
def test31 (w : Nat) (x : BitVec w) : x &&& x = x := by
  bv_automata_gen (config := {backend := .circuit_cadical} )

theorem neg_eq_not_add_one (x : BitVec w) :
    -x = ~~~ x + 1#w := by
  bv_automata_gen (config := {backend := .circuit_cadical} )

theorem add_eq_xor_add_mul_and (x y : BitVec w) :
    x + y = (x ^^^ y) + (x &&& y) + (x &&& y) := by
  bv_automata_gen (config := {backend := .circuit_cadical} )

theorem add_eq_xor_add_mul_and' (x y : BitVec w) :
    x + y = (x ^^^ y) + (x &&& y) + (x &&& y) := by
  bv_automata_gen (config := {backend := .circuit_cadical} )

theorem add_eq_xor_add_mul_and_nt (x y : BitVec w) :
    x + y = (x ^^^ y) + 2 * (x &&& y) := by
  bv_automata_gen (config := {backend := .circuit_cadical} )

/-- Check that we correctly process an even numeral multiplication. -/
theorem mul_four (x : BitVec w) : 4 * x = x + x + x + x := by
  bv_automata_gen

/-- Check that we correctly process an odd numeral multiplication. -/
theorem mul_five (x : BitVec w) : 5 * x = x + x + x + x + x := by
  bv_automata_gen (config := {backend := .circuit_cadical 6 } )

/-- Check that we correctly process an odd numeral multiplication. -/
theorem mul_eleven (x : BitVec w) : 11 * x =
  (x + x + x + x + x +
   x + x + x + x + x +
   x) := by
  bv_automata_gen (config := {backend := .circuit_cadical 6 } )

theorem mul_eleven' (x : BitVec w) : 11 * x =
  (x + x + x + x + x +
   x + x + x + x + x +
   x) := by
  bv_automata_gen (config := {backend := .circuit_cadical 6 } )

theorem mul_eleven'' (x : BitVec w) : 11 * x =
  x <<< (3 : ℕ) + x <<< (1 : ℕ) + x := by
  bv_automata_gen (config := {backend := .circuit_cadical 6} )

open BitVec in
/-- Check that we support sign extension. -/
theorem sext
    (b : BitVec 8)
    (c : ¬(11#9 - signExtend 9 (b &&& 7#8)).msb = (11#9 - signExtend 9 (b &&& 7#8)).getMsbD 1) :
    False := by
  fail_if_success bv_automata_gen
  sorry

/-- Check that we support zero extension. -/
theorem zext (b : BitVec 8) : (b.zeroExtend 10 |>.zeroExtend 8) = b := by
  fail_if_success bv_automata_gen
  sorry

/-- Can solve width-constraints problems, when written with a width constraint. -/
def width_specific_1 (x : BitVec w) : w = 1 →  x + x = x ^^^ x := by
  bv_automata_gen (config := {backend := .circuit_cadical} )


example (x : BitVec 0) : x = x + 0#0 := by
  bv_automata_gen (config := {backend := .circuit_cadical} )

/-- All bitvectors are equal at width 0 -/
example (x y : BitVec w) (hw : w = 0) : x = y := by
  bv_automata_gen (config := {backend := .circuit_cadical} )

/-- At width 1, adding bitvector to itself four times gives 0. Characteristic equals 2 -/
def width_1_char_2 (x : BitVec w) (hw : w = 1) : x + x = 0#w := by
  bv_automata_gen (config := {backend := .circuit_cadical} )

/-- At width 1, adding bitvector to itself four times gives 0. Characteristic 2 divides 4 -/
def width_1_char_2_add_four (x : BitVec w) (hw : w = 1) : x + x + x + x = 0#w := by
  bv_automata_gen (config := {backend := .circuit_cadical} )

/--
info: 'width_1_char_2_add_four' depends on axioms: [propext, Classical.choice, Quot.sound, Reflect.BvDecide.decideIfZerosMAx]
-/
#guard_msgs in #print axioms width_1_char_2_add_four

theorem e_1 (x y : BitVec w) :
     - 1 *  ~~~(x ^^^ y) - 2 * y + 1 *  ~~~x =  - 1 *  ~~~(x |||  ~~~y) - 3 * (x &&& y) := by
  bv_automata_gen (config := {backend := .circuit_cadical 5 } )

theorem e_331 (x y : BitVec w):
     - 6 *  ~~~x + 2 * (x |||  ~~~y) - 3 * x + 2 * (x ||| y) - 10 *  ~~~(x ||| y) - 10 *  ~~~(x |||  ~~~y) - 4 * (x &&&  ~~~y) - 15 * (x &&& y) + 3 *  ~~~(x &&&  ~~~x) + 11 *  ~~~(x &&&  ~~~y) = 0#w := by
  -- bv_automata_gen (config := {genSizeThreshold := 2000, stateSpaceSizeThreshold := 100})
  bv_automata_gen (config := {backend := .circuit_cadical 5 } )

set_option maxHeartbeats 0 in
theorem e_2500 (a b c d e f g h i j k l m n o p q r s t u v x y z : BitVec w):
    7 * ( ~~~f ||| (d ^^^ e)) - 6 * ( ~~~(d &&&  ~~~e) &&& (e ^^^ f)) - 11 * ( ~~~(d &&&  ~~~e) &&& (d ^^^ (e ^^^ f))) - 1 * (f ^^^  ~~~( ~~~d &&& (e ||| f))) + 3 * ((e &&&  ~~~f) |||  ~~~(d ||| ( ~~~e &&& f))) - 3 * (f |||  ~~~(d |||  ~~~e)) + 1 *  ~~~(e ^^^ f) + 1 *  ~~~(d &&& (e ||| f)) + 5 * ( ~~~(d |||  ~~~e) ||| (d ^^^ (e ^^^ f))) + 1 * (e ^^^  ~~~(d ||| (e &&& f))) + 1 *  ~~~(d ||| ( ~~~e &&& f)) - 1 * ( ~~~d ||| (e ^^^ f)) + 4 * (e ^^^  ~~~( ~~~d &&& (e ||| f))) + 3 * ((d &&&  ~~~e) |||  ~~~(e ^^^ f)) + 4 * (f ^^^ ( ~~~d ||| ( ~~~e ||| f))) + 4 * ((e &&&  ~~~f) ^^^ (d ||| (e ^^^ f))) + 7 * ((d &&&  ~~~e) ||| (e ^^^ f)) + 2 * ((d ||| e) &&& (e ^^^ f)) + 3 * (e ^^^  ~~~( ~~~d ||| (e ^^^ f))) - 6 * (e ^^^  ~~~(d &&& f)) - 1 * (e ^^^ ( ~~~d ||| (e ||| f))) + 5 * (f ^^^ (d &&& (e ||| f))) + 4 * ((d &&& f) ^^^ (e ||| f)) + 1 * (e &&& (d |||  ~~~f)) - 2 *  ~~~(d &&&  ~~~e) + 7 * (f ^^^  ~~~( ~~~d &&& ( ~~~e ||| f))) - 3 * ((d &&& e) |||  ~~~(e ^^^ f)) - 1 *  ~~~( ~~~d &&& ( ~~~e ||| f)) - 5 * (f ^^^ ( ~~~d ||| (e &&& f))) - 1 * (d ||| (e ||| f)) + 5 * (d &&&  ~~~f) + 7 * (f ||| (d &&& e)) - 1 * ( ~~~d &&& (e ||| f)) + 1 * ( ~~~(d ||| e) ||| (d ^^^ (e ^^^ f))) + 7 * (e ^^^  ~~~( ~~~d &&& (e ^^^ f))) + 1 * ((d |||  ~~~e) &&& (d ^^^ (e ^^^ f))) + 11 *  ~~~(d ||| (e ^^^ f)) + 4 * (e ^^^ (d &&& (e ^^^ f))) - 1 * ( ~~~d ||| ( ~~~e ||| f)) + 5 * ((d &&&  ~~~e) |||  ~~~(d ^^^ (e ^^^ f))) - 11 * (e ^^^ ( ~~~d ||| (e ^^^ f))) - 1 * (d &&& (e ||| f)) - 1 * (f ^^^  ~~~( ~~~d ||| ( ~~~e &&& f))) + 3 * (e ^^^ ( ~~~d &&& (e ||| f))) + 7 * (e ^^^ (d &&&  ~~~f)) + 1 *  ~~~( ~~~d &&& ( ~~~e &&& f)) - 1 * (e ^^^ (d ||| (e &&& f))) + 1 * (e ^^^ (d &&& ( ~~~e ||| f))) - 1 * (f ^^^ ( ~~~d &&& ( ~~~e ||| f))) - 1 * (d ||| ( ~~~e &&& f)) - 6 * (e ^^^  ~~~(d |||  ~~~f)) + 3 *  ~~~(d ||| f) + 4 * (e |||  ~~~(d ^^^ f)) - 2 *  ~~~(d &&& ( ~~~e ||| f)) - 6 * f - 1 * (e |||  ~~~(d |||  ~~~f)) + 5 * ((d ^^^ e) |||  ~~~(d ^^^ f)) - 2 * (f ^^^ ( ~~~d ||| (e ||| f))) + 5 * (f ^^^  ~~~(d |||  ~~~e)) - 11 * (e ||| (d &&&  ~~~f)) + 11 *  ~~~(d &&& (e &&& f)) - 3 * (e ^^^  ~~~( ~~~d &&& ( ~~~e ||| f))) - 5 * ((d &&& e) ||| (e ^^^ f)) + 1 * ((e &&&  ~~~f) ^^^ ( ~~~d ||| (e ^^^ f))) - 3 * (f ^^^  ~~~(d &&& ( ~~~e &&& f))) - 1 *  ~~~(d &&& ( ~~~e &&& f)) + 4 *  ~~~( ~~~d &&& (e &&& f)) - 6 * ((d ||| e) &&&  ~~~(e ^^^ f)) - 11 * ( ~~~e &&& (d ^^^ f)) - 7 * (f &&& (d |||  ~~~e)) + 5 * (d &&& ( ~~~e ||| f)) + 11 *  ~~~(e ||| f) - 7 * (f ^^^  ~~~(d &&& e)) + 1 * ((d ^^^ e) &&& (d ^^^ f)) - 39 *  ~~~(d ||| (e ||| f)) - 29 *  ~~~(d ||| ( ~~~e ||| f)) - 54 *  ~~~( ~~~d ||| (e ||| f)) - 32 *  ~~~( ~~~d ||| ( ~~~e ||| f)) + 19 * ( ~~~d &&& ( ~~~e &&& f)) - 60 * ( ~~~d &&& (e &&& f)) - 31 * (d &&& ( ~~~e &&& f)) + 33 * (d &&& (e &&& f)) =  - 1 * (e ^^^  ~~~( ~~~d ||| ( ~~~e &&& f))) + 3 *  ~~~(d ^^^ f) := by
  bv_automata_gen (config := {backend := .circuit_cadical 1 } )

end BvAutomataTests
