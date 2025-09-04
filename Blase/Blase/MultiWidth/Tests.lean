import Blase.MultiWidth.Tactic

open MultiWidth

theorem test28 {w : Nat} (x : BitVec w) :
    x &&& x &&& x &&& x &&& x &&& x = x := by
  bv_multi_width (config := { niter := 2 })

def thmStmt : MultiWidth.Predicate (wcard := 1) (tcard := 2)
  (MultiWidth.Term.Ctx.cons
    (MultiWidth.Term.Ctx.cons
      (MultiWidth.Term.Ctx.empty (wcard := 1))
    (.var ⟨0, by omega⟩))
  (.var ⟨0, by omega⟩)) :=
     (Predicate.binRel BinaryRelationKind.eq (WidthExpr.var ⟨0, by omega⟩)
       (MultiWidth.Term.add
          (MultiWidth.Term.var (⟨0, by omega⟩ : Fin 2))
          (MultiWidth.Term.var (⟨1, by omega⟩ : Fin 2)))
       (MultiWidth.Term.add
         (MultiWidth.Term.var (⟨1, by omega⟩ : Fin 2))
         (MultiWidth.Term.var (⟨0, by omega⟩ : Fin 2))
       )
     )

abbrev ty :=
  BitVec (WidthExpr.toNat (WidthExpr.var (Fin.mk 0 (by simp))) (WidthExpr.Env.empty.cons 10))

theorem hty : ty = BitVec 10 := by
  unfold ty
  rfl

set_option pp.analyze true in
def test5 (x y z : BitVec w) : (x + y) = (y + x) := by
  bv_multi_width +verbose? +debugFillFinalReflectionProofWithSorry

#eval test5.safetyCert.lhs_1
#eval test5.indCert.lhs_3

def test6 (x y z : BitVec w) : (x + (y + z)) = ((x + y) + z) := by
  bv_multi_width (config := { niter := 10 })

theorem add_eq_or_add_and (x y : BitVec w) :
    x + y = (x ||| y) + (x &&& y) := by
  bv_multi_width (config := { niter := 10, verbose? := True })

theorem add_eq_xor_add_mul_and_1 (x y : BitVec w) :
    x + y = (x ^^^ y) + 2 * (x &&& y) := by
  bv_multi_width (config := { niter := 10, verbose? := True })

theorem add_eq_xor_add_mul_and_2 (x y : BitVec w) :
    x + y = (x ^^^ y) + (x &&& y) <<< 1 := by
  bv_multi_width (config := { niter := 2, verbose? := True })

theorem add_eq_xor_add_mul_and_3 (x y : BitVec w) :
    x + y = (x ^^^ y) + (x &&& y) * 2#w := by
  bv_multi_width (config := { niter := 2, verbose? := True })


theorem add_eq_xor_add_mul_and_nt_zext (x y : BitVec w) :
    x.zeroExtend (w + 1) + y.zeroExtend (w + 1) =
      (x ^^^ y).zeroExtend (w + 1) + 2 * (x &&& y).zeroExtend (w + 1) := by
  bv_multi_width (config := { niter := 10, verbose? := True })

/-

 theorem eg2 (w : Nat) (x : BitVec w) : x + 2 = x + 1 + 1 := by
  bv_multi_width

theorem eg3 (u w : Nat) (x : BitVec w) :
    (x.zeroExtend u).zeroExtend u = x.zeroExtend u := by
  bv_multi_width (config := { niter := 2 })

theorem eg4 (u w : Nat) (x : BitVec w) :
    (x.signExtend u).signExtend u = x.signExtend u := by
  bv_multi_width (config := { niter := 0 })

theorem eg5 (u w : Nat) (x : BitVec w) :
    (x.signExtend u).zeroExtend u = x.signExtend u := by
  bv_multi_width (config := { niter := 0 })

theorem eg6 (u w : Nat) (x : BitVec w) :
    (x.zeroExtend u).signExtend u = x.zeroExtend u := by
  bv_multi_width (config := { niter := 0 })

/--
error: safety failure at iteration 0 for predicate MultiWidth.Nondep.Predicate.binRel
  (MultiWidth.BinaryRelationKind.eq)
  (MultiWidth.Nondep.Term.zext
    (MultiWidth.Nondep.Term.zext
      (MultiWidth.Nondep.Term.var 0 (MultiWidth.Nondep.WidthExpr.var 2))
      (MultiWidth.Nondep.WidthExpr.var 1))
    (MultiWidth.Nondep.WidthExpr.var 0))
  (MultiWidth.Nondep.Term.zext
    (MultiWidth.Nondep.Term.var 0 (MultiWidth.Nondep.WidthExpr.var 2))
    (MultiWidth.Nondep.WidthExpr.var 0))
-/
#guard_msgs in theorem eg100 (u v w : Nat) (x : BitVec w) (h : u ≥ v) :
    (x.zeroExtend u).zeroExtend v = x.zeroExtend v := by
  bv_multi_width (config := { niter := 2 })


open Lean Meta Elab Tactic in
#eval show TermElabM Unit from do
  let fsm : FSM (Fin 1) := FSM.mk (α := Unit)
    (initCarry :=
      fun
      | _ => false)
    (outputCirc := .var true (.inl ()))
    (nextStateCirc := fun () => .var true (.inr 0))
  let _ ← fsm.decideIfZerosVerified 0
  --logInfo "done test."
  return ()

set_option linter.unusedVariables false

/-- Can solve explicitly quantified expressions with intros. bv_automata3. -/
theorem eq1 : ∀ (w : Nat) (a : BitVec w), a = a := by
  intros
  bv_multi_width (config := { niter := 2 })


/-- Can solve implicitly quantified expressions by directly invoking bv_automata3. -/
theorem eq2 (w : Nat) (a : BitVec w) : a = a := by
  bv_multi_width (config := { niter := 2 })


theorem eq3 (w : Nat) (a b : BitVec w) : a = a ||| 0 := by
  bv_multi_width (config := { niter := 2 })

example (w : Nat) (a b : BitVec w) : a = a + 0 := by
  bv_multi_width (config := { niter := 2 })

--set_option trace.Bits.FastVerif true in
theorem check_axioms_cadical (w : Nat) (a b : BitVec w) : a + b = b + a := by
  bv_multi_width (config := { niter := 2 })

/--
info: 'check_axioms_cadical' depends on axioms: [propext, Classical.choice, Lean.ofReduceBool, Lean.trustCompiler, Quot.sound]
-/
#guard_msgs in #print axioms check_axioms_cadical

theorem check_axioms_presburger (w : Nat) (a b : BitVec w) : a + b = b + a := by
  bv_multi_width (config := { niter := 2 })

/--
info: 'check_axioms_presburger' depends on axioms: [hashMap_missing,
 propext,
 Classical.choice,
 Lean.ofReduceBool,
 Lean.trustCompiler,
 Quot.sound]
-/
#guard_msgs in #print axioms check_axioms_presburger

example (w : Nat) (a b : BitVec w) : (a + b = b + a)  := by
  bv_multi_width (config := { niter := 2 })

--set_option trace.Bits.FastVerif true in
example (w : Nat) (a : BitVec w) : (a = a + 0#w) ∨ (a = a - a)  := by
  bv_multi_width (config := { niter := 2 })

example (w : Nat) (a : BitVec w) :  (a = a + 0#w)  := by
  bv_multi_width (config := { niter := 2 })


-- Check that this example produces 'normCircuitVerified: ok, normCircuitUnverified: ok'
set_option warn.sorry false in
example (w : Nat) (a : BitVec w) :  (a * 3 = a + a + a)  := by
  bv_multi_width (config := { niter := 2 })


set_option warn.sorry false in
example (w : Nat) (a b : BitVec w) (hw : w = 0) : a = b  := by
  bv_multi_width (config := { niter := 2 })

set_option warn.sorry false in
example (w : Nat) (a : BitVec w) : (a = 0#w) := by
  bv_multi_width (config := { niter := 2 })

example (w : Nat) (a : BitVec w) : (a = 0#w) ∨ (a = a + 0#w)  := by
  bv_multi_width (config := { niter := 2 })


example (w : Nat) (a b : BitVec w) : (a = 0#w) ∨ (a + b = b + a) := by
  bv_multi_width (config := { niter := 2 })

example (w : Nat) (a : BitVec w) : (a = 0#w) ∨ (a ≠ 0#w) := by
  bv_multi_width (config := { niter := 2 })

example (w : Nat) (a b : BitVec w) : (a + b = b + a) ∧ (a + 0#w = a) := by
  bv_multi_width (config := { niter := 2 })

example (w : Nat) (a b : BitVec w) : (a + 0#w = a) := by
  bv_multi_width (config := { niter := 2 })

example (w : Nat) (a b : BitVec w) : (a + b = b + a) ∧ (a + 0#w = a) := by
  bv_multi_width (config := { niter := 2 })

example (w : Nat) (a b : BitVec w) : (a ≠ b) → (b ≠ a) := by
  bv_multi_width (config := { niter := 2 })

/-- either a < b or b ≤ a -/
example (w : Nat) (a b : BitVec w) : (a < b) ∨ (b ≤ a) := by
  bv_multi_width (config := { niter := 2 })

/-- Tricohotomy of < -/
example (w : Nat) (a b : BitVec w) : (a < b) ∨ (b < a) ∨ (a = b) := by
  bv_multi_width (config := { niter := 2 })

/-- < implies not equals -/
example (w : Nat) (a b : BitVec w) : (a < b) → (a ≠ b) := by
  bv_multi_width (config := { niter := 2 })

/-- <= and >= implies equals -/
example (w : Nat) (a b : BitVec w) : ((a ≤ b) ∧ (b ≤ a)) → (a = b) := by
  bv_multi_width (config := { niter := 2 })

-- This should succeed.
set_option warn.sorry false in
example (w : Nat) (a b : BitVec w) : (w > 1 ∧ (a - b).slt 0 → a.slt b) := by
  bv_multi_width (config := { niter := 2 })


/-- Tricohotomy of slt. Currently fails! -/
example (w : Nat) (a b : BitVec w) : (a.slt b) ∨ (b.sle a) := by
  bv_multi_width (config := { niter := 2 })

/-- Tricohotomy of slt. Currently fails! -/
example (w : Nat) (a b : BitVec w) : (a.slt b) ∨ (b.slt a) ∨ (a = b) := by
  bv_multi_width (config := { niter := 2 })

/-- a <=s b and b <=s a implies a = b-/
example (w : Nat) (a b : BitVec w) : ((a.sle b) ∧ (b.sle a)) → a = b := by
  bv_multi_width (config := { niter := 2 })

/-- In bitwidth 0, all values are equal.
In bitwidth 1, 1 + 1 = 0.
In bitwidth 2, 1 + 1 = 2 ≠ 0#2
For all bitwidths ≥ 2, we know that a ≠ a + 1
-/
example (w : Nat) (a : BitVec w) : (a ≠ a + 1#w) ∨ (1#w + 1#w = 0#w) ∨ (1#w = 0#w):= by
  bv_multi_width (config := { niter := 2 })

/-- If we have that 'a &&& a = 0`, then we know that `a = 0` -/
example (w : Nat) (a : BitVec w) : (a &&& a = 0#w) → a = 0#w := by
  bv_multi_width (config := { niter := 2 })

set_option warn.sorry false in
/--
Is this true at bitwidth 1? Not it is not!
So we need an extra hypothesis that rules out bitwifth 1.
We do this by saying that either the given condition, or 1+1 = 0.
I'm actually not sure why I need to rule out bitwidth 0? Mysterious!
-/
example (w : Nat) (a : BitVec w) : (w = 2) → ((a = - a) → a = 0#w) := by
  bv_multi_width (config := { niter := 2 })


example (w : Nat) (a : BitVec w) : (w = 1) → (a = 0#w ∨ a = 1#w) := by
  bv_multi_width (config := { niter := 2 })

example (w : Nat) : (w = 1) → (1#w + 1#w = 0#w) := by
  bv_multi_width (config := { niter := 2 })

example (w : Nat) : (1#w + 1#w = 0#w) → ((w = 0) ∨ (w = 1)):= by
  bv_multi_width (config := { niter := 2 })

example (w : Nat) : (1#w + 1#w = 0#w) → (w < 2) := by
  bv_multi_width (config := { niter := 2 })

example (w : Nat) (a b : BitVec w) : (a + b = 0#w) → a = - b := by
  bv_multi_width (config := { niter := 2 })


/-- Can use implications -/
theorem eq_gen (w : Nat) (a b : BitVec w) : (a &&& b = 0#w) → ((a + b) = (a ||| b)) := by
  bv_multi_width (config := { niter := 2 })

/-- Can exploit hyps -/
theorem eq4 (w : Nat) (a b : BitVec w) (h : a &&& b = 0#w) : a + b = a ||| b := by
  bv_multi_width (config := { niter := 2 })


/-!
# Test Cases
-/

set_option warn.sorry false in
/--
warning: Tactic has not understood the following expressions, and will treat them as symbolic:

  - 'f x'
  - 'f y'
-/
#guard_msgs (warning, drop error, drop info) in
theorem test_symbolic_abstraction (f : BitVec w → BitVec w) (x y : BitVec w) : f x ≠ f y := by
  bv_multi_width (config := { niter := 2 })

/-- Check that we correctly handle `OfNat.ofNat 1`. -/
theorem not_neg_eq_sub_one (x : BitVec 53) :
    ~~~ (- x) = x - 1 := by
  bv_multi_width (config := { niter := 2 })

/-- Check that we correctly handle multiplication by two. -/
theorem sub_eq_mul_and_not_sub_xor (x y : BitVec w):
    x - y = 2 * (x &&& ~~~ y) - (x ^^^ y) := by
  bv_multi_width (config := { niter := 2 })


/- See that such problems have large gen sizes, but small state spaces -/
def alive_1 {w : ℕ} (x x_1 x_2 : BitVec w) : (x_2 &&& x_1 ^^^ x_1) + 1#w + x = x - (x_2 ||| ~~~x_1) := by
  bv_multi_width (config := { niter := 2 })


def test_OfNat_ofNat (x : BitVec 1) : 1#1 + x = x + 1#1 := by
  bv_multi_width (config := { niter := 2 })

def test0 {w : Nat} (x y : BitVec w) : x + 0#w = x := by
  bv_multi_width (config := { niter := 2 })


def test_simple2 {w : Nat} (x y : BitVec w) : x = x := by
  bv_multi_width (config := { niter := 2 })

def test1 {w : Nat} (x y : BitVec w) : (x ||| y) - (x ^^^ y) = x &&& y := by
  bv_multi_width (config := { niter := 2 })


def test4 (x y : BitVec w) : (x + -y) = (x - y) := by
  bv_multi_width (config := { niter := 2 })

def test5 (x y z : BitVec w) : (x + y + z) = (z + y + x) := by
  bv_multi_width (config := { niter := 2 })



def test11 (x y : BitVec w) : (x + y) = ((x |||  y) + (x &&&  y)) := by
  bv_multi_width (config := { niter := 2 })


def test15 (x y : BitVec w) : (x - y) = (( x &&& (~~~ y)) - ((~~~ x) &&&  y)) := by
  bv_multi_width (config := { niter := 2 })

def test17 (x y : BitVec w) : (x ^^^ y) = ((x ||| y) - (x &&& y)) := by
  bv_multi_width (config := { niter := 2 })


def test18 (x y : BitVec w) : (x &&&  (~~~ y)) = ((x ||| y) - y) := by
  bv_multi_width (config := { niter := 2 })


def test19 (x y : BitVec w) : (x &&&  (~~~ y)) = (x -  (x &&& y)) := by
  bv_multi_width (config := { niter := 2 })


def test21 (x y : BitVec w) : (~~~(x - y)) = (~~~x + y) := by
  bv_multi_width (config := { niter := 2 })

def test2_gen (x y : BitVec w) : (~~~(x ^^^ y)) = ((x &&& y) + ~~~(x ||| y)) := by
  bv_multi_width (config := { niter := 2 })

def test24 (x y : BitVec w) : (x ||| y) = (( x &&& (~~~y)) + y) := by
  bv_multi_width (config := { niter := 2 })

def test25 (x y : BitVec w) : (x &&& y) = (((~~~x) ||| y) - ~~~x) := by
  bv_multi_width (config := { niter := 2 })

def test26 {w : Nat} (x y : BitVec w) : 1#w + x + 0#w = 1#w + x := by
  bv_multi_width (config := { niter := 2 })

/-- NOTE: we now support 'ofNat' literals -/
def test27 (x y : BitVec w) : 2#w + x  = 1#w  + x + 1#w := by
  bv_multi_width (config := { niter := 2 })


example : ∀ (w : Nat) , (BitVec.ofNat w 1) &&& (BitVec.ofNat w 3) = BitVec.ofNat w 1 := by
  intros
  bv_multi_width (config := { niter := 2 })

--set_option trace.Bits.FastVerif true in
example : ∀ (w : Nat) (x : BitVec w), -1#w &&& x = x := by
  intros
  bv_multi_width (config := { niter := 2 })

example : ∀ (w : Nat) (x : BitVec w), x <<< (0 : Nat) = x := by
  intros
  bv_multi_width (config := { niter := 2 })

example : ∀ (w : Nat) (x : BitVec w), x <<< (1 : Nat) = x + x := by
  intros
  bv_multi_width (config := { niter := 2 })

example : ∀ (w : Nat) (x : BitVec w), x <<< (2 : Nat) = x + x + x + x := by
  intros
  bv_multi_width (config := { niter := 2 })

/-- Can solve width-constraints problems -/
def test30  : (w = 2) → 8#w = 0#w := by
  bv_multi_width (config := { niter := 2 })

/-- Can solve width-constraints problems -/
def test31 (w : Nat) (x : BitVec w) : x &&& x = x := by
  bv_multi_width (config := { niter := 2 })

theorem neg_eq_not_add_one (x : BitVec w) :
    -x = ~~~ x + 1#w := by
  bv_multi_width (config := { niter := 2 })

theorem add_eq_xor_add_mul_and (x y : BitVec w) :
    x + y = (x ^^^ y) + (x &&& y) + (x &&& y) := by
  bv_multi_width (config := { niter := 2 })

theorem add_eq_xor_add_mul_and' (x y : BitVec w) :
    x + y = (x ^^^ y) + (x &&& y) + (x &&& y) := by
  bv_multi_width (config := { niter := 2 })

/-- Check that we correctly process an even numeral multiplication. -/
theorem mul_four (x : BitVec w) : 4 * x = x + x + x + x := by
  bv_multi_width (config := { niter := 2 })

theorem add_eq (x : BitVec w) : x = x + 0 := by
  bv_multi_width (config := { niter := 2 })

theorem add_five (x : BitVec w) : (x + x) + (x + x) + x = x + x + x + x + x := by
  bv_multi_width (config := { niter := 2 })

/-- Check that we correctly process an odd numeral multiplication. -/
theorem mul_five (x : BitVec w) : 5 * x = x + x + x + x + x := by
  bv_multi_width (config := { niter := 2 })

set_option warn.sorry false in
/-- Check that we support zero extension. -/
theorem zext (b : BitVec 8) : (b.zeroExtend 10 |>.zeroExtend 8) = b := by
  bv_multi_width (config := { niter := 2 })

/-- Can solve width-constraints problems, when written with a width constraint. -/
def width_specific_1 (x : BitVec w) : w = 1 →  x + x = x ^^^ x := by
  bv_multi_width (config := { niter := 2 })


example (x : BitVec 0) : x = x + 0#0 := by
  bv_multi_width (config := { niter := 2 })

/-- All bitvectors are equal at width 0 -/
example (x y : BitVec w) (hw : w = 0) : x = y := by
  bv_multi_width (config := { niter := 2 })

/-- At width 1, adding bitvector to itself four times gives 0. Characteristic equals 2 -/
def width_1_char_2 (x : BitVec w) (hw : w = 1) : x + x = 0#w := by
  bv_multi_width (config := { niter := 2 })

/-- At width 1, adding bitvector to itself four times gives 0. Characteristic 2 divides 4 -/
def width_1_char_2_add_four (x : BitVec w) (hw : w = 1) : x + x + x + x = 0#w := by
  bv_multi_width (config := { niter := 2 })

theorem e_1 (x y : BitVec w) :
     - 1 *  ~~~(x ^^^ y) - 2 * y + 1 *  ~~~x =  - 1 *  ~~~(x |||  ~~~y) - 3 * (x &&& y) := by
  bv_multi_width (config := { niter := 2 })

-/
