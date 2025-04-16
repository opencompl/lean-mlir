import Mathlib.Algebra.Notation.Defs
import Mathlib.Order.Notation

/-!
# Term Language
This file defines the term language the decision procedure operates on,
and the denotation of these terms into operations on bitstreams -/

/-- The sort of widths, which are natural numbers. -/
inductive Width : Type
| var : Nat → Width
deriving Repr, Inhabited

/-- Denote a width variable into a concrete width. -/
def Width.denote (ws : List Nat) : Width → Nat
| var n => ws.getD n default

/-- A `Term` is an expression in the language our decision procedure operates on,
it represent an infinite bitstream (with free variables) -/
inductive Term : Width → Type
| var : (w : Width) → (v : Nat) → Term w
/-- The constant `0` -/
| zero (w : Width) : Term w
/-- The constant `-1` -/
| negOne (w : Width) : Term w
/-- The constant `1` -/
| one (w : Width) : Term w
/-- The constant `n` from a bitvector expression -/
| ofNat (w : Width) (n : Nat) : Term w
/-- Bitwise and -/
| and : Term w → Term w → Term w
/-- Bitwise or -/
| or : Term w → Term w → Term w
/-- Bitwise xor -/
| xor : Term w → Term w → Term w
/-- Bitwise complement -/
| not : Term w → Term w
/-- Addition -/
| add : Term w → Term w → Term w
/-- Subtraction -/
| sub : Term w → Term w → Term w
/-- Negation -/
| neg : Term w → Term w
-- /-- Increment (i.e., add one) -/
-- | incr : Term → Term
-- /-- Decrement (i.e., subtract one) -/
-- | decr : Term → Term
/-- shift left by `k` bits. -/
| shiftL : Term w → Nat → Term w
-- /-- logical shift right by `k` bits. -/
-- | lshiftR : Term → Nat → Term
-- bollu: I don't think we can do ashiftr, because it's output is 'irregular',
--   hence, I don't anticipate us implementing it.
-- | append : Term → Term → Term
deriving Repr, Inhabited

open Term

instance : Add (Term w) := ⟨add⟩
instance : Sub (Term w) := ⟨sub⟩
instance : One (Term w) := ⟨one w⟩
instance : Zero (Term w) := ⟨zero w⟩
instance : Neg (Term w) := ⟨neg⟩

/-- `t.arity` is the max free variable id that occurs in the given term `t`,
and thus is an upper bound on the number of free variables that occur in `t`.

Note that the upper bound is not perfect:
a term like `var 10` only has a single free variable, but its arity will be `11` -/
@[simp] def Term.arity : Term w → Nat
| (var w n) => n+1
| zero w => 0
| one w => 0
| negOne w => 0
| ofNat w _ => 0
| Term.and t₁ t₂ => max (arity t₁) (arity t₂)
| Term.or t₁ t₂ => max (arity t₁) (arity t₂)
| Term.xor t₁ t₂ => max (arity t₁) (arity t₂)
| Term.not t => arity t
| add t₁ t₂ => max (arity t₁) (arity t₂)
| sub t₁ t₂ => max (arity t₁) (arity t₂)
| neg t => arity t
-- | incr t => arity t
-- | decr t => arity t
| shiftL t .. => arity t
-- | repeatBit t => arity t

inductive BinaryPredicate
| eq
| neq
| ult
| ule
| slt
| sle
deriving Repr

inductive WidthPredicate
| eq
| neq
| lt
| le
| gt
| ge
deriving Repr

/--
The fragment of predicate logic that we support in `bv_automata`.
Currently, we support equality, conjunction, disjunction, and negation.
This can be expanded to also support arithmetic constraints such as unsigned-less-than.

Meaning of the denotation:

`p w = false` iff the predicate holds *at* width w
-/
-- a < b <=> a - b < 0
-- a <= 0 <=> a < 0 ∨ a = 0
-- a > b <=> b < a <=> b - a < 0
inductive Predicate : Type where
/-- Assert relationship between bitwidth and `n` -/
| width (wp : WidthPredicate) (n : Nat) : Predicate
| binary (p : BinaryPredicate) (t₁ t₂ : Term w)
| land  (p q : Predicate) : Predicate
| lor (p q : Predicate) : Predicate
deriving Repr

-- TODO: This ugly definition is here to make the `predicateEvalEqFSM` function compile wihtout change.
@[simp] def Predicate.arity : Predicate → Nat
| .width _ _ => 0
| .binary .eq t1 t2 => max t1.arity t2.arity
| .binary .neq t₁ t₂ => max t₁.arity t₂.arity
| .binary .ult t₁ t₂ => max t₁.arity t₂.arity
| .binary .ule t₁ t₂ => t₁.arity ⊔ t₂.arity ⊔ (t₁.arity ⊔ t₂.arity)
| .binary .slt t₁ t₂ => (t₁.arity ⊔ t₂.arity ⊔ (t₁.arity ⊔ t₂.arity))
| .binary .sle t₁ t₂ => (t₁.arity ⊔ t₂.arity ⊔ (t₁.arity ⊔ t₂.arity) ⊔ (t₁.arity ⊔ t₂.arity))
| .lor p q => max p.arity q.arity
| .land p q => max p.arity q.arity


/-- toBitVec a Term into its underlying bitvector -/
def Term.denote 
    {w : Width}
    (t : Term w)
    (ws : List Nat)
    (vars : List (BitVec (w.denote ws))) :
    BitVec (w.denote ws) :=
  match t with
  | ofNat w n => BitVec.ofNat (w.denote ws) n
  | var w n => vars.getD n default
  | zero w => 0#(w.denote ws)
  | negOne w => -1#(w.denote ws)
  | one w => 1#(w.denote ws)
  | and a b => (a.denote ws vars) &&& (b.denote ws vars)
  | or a b => (a.denote ws vars) ||| (b.denote ws vars)
  | xor a b => (a.denote ws vars) ^^^ (b.denote ws vars)
  | not a => ~~~ (a.denote ws vars)
  | add a b => (a.denote ws vars) + (b.denote ws vars)
  | sub a b => (a.denote ws vars) - (b.denote ws vars)
  | neg a => - (a.denote ws vars)
  -- | incr a => (a.denote w vars) + 1#w
  -- | decr a => (a.denote w vars) - 1#w
  | shiftL a n => (a.denote ws vars) <<< n


def Predicate.denote (p : Predicate) (ws : List Nat) (vars : List (BitVec w)) : Prop :=
  match p with
  | .width .ge k => k ≤ w -- w ≥ k
  | .width .gt k => k < w -- w > k
  | .width .le k => w ≤ k
  | .width .lt k => w < k
  | .width .neq k => w ≠ k
  | .width .eq k => w = k
  | .binary .eq t₁ t₂ => t₁.denote w vars = t₂.denote w vars
  | .binary .neq t₁ t₂ => t₁.denote w vars ≠ t₂.denote w vars
  | .binary .sle  t₁ t₂ => ((t₁.denote ws vars).sle (t₂.denote w vars)) = true
  | .binary .slt  t₁ t₂ => ((t₁.denote ws vars).slt (t₂.denote w vars)) = true
  | .binary .ule  t₁ t₂ => ((t₁.denote ws vars).ule (t₂.denote w vars)) = true
  | .binary .ult  t₁ t₂ => (t₁.denote w vars).ult (t₂.denote w vars) = true
  | .land  p q => p.denote w vars ∧ q.denote w vars
  | .lor  p q => p.denote w vars ∨ q.denote w vars
