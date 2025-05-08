import Mathlib.Algebra.Notation.Defs
import Mathlib.Order.Notation


inductive TermKind : Type
| bv

/-!
# Term Language
This file defines the term language the decision procedure operates on,
and the denotation of these terms into operations on bitstreams -/

/-- A `Term` is an expression in the language our decision procedure operates on,
it represent an infinite bitstream (with free variables) -/
inductive Term : TermKind → Type
| var : Nat → Term .bv
/-- The constant `0` -/
| zero : Term .bv
/-- The constant `-1` -/
| negOne : Term .bv
/-- The constant `1` -/
| one : Term .bv
/-- The constant `n` from a bitvector expression -/
| ofNat (n : Nat) : Term .bv
/-- Bitwise and -/
| and : Term .bv → Term .bv → Term .bv
/-- Bitwise or -/
| or : Term .bv → Term .bv → Term .bv
/-- Bitwise xor -/
| xor : Term .bv → Term .bv → Term .bv
/-- Bitwise complement -/
| not : Term .bv → Term .bv
/-- Addition -/
| add : Term .bv → Term .bv → Term .bv
/-- Subtraction -/
| sub : Term .bv → Term .bv → Term .bv
/-- Negation -/
| neg : Term .bv → Term .bv
-- /-- Increment (i.e., add one) -/
-- | incr : Term → Term
-- /-- Decrement (i.e., subtract one) -/
-- | decr : Term → Term
/-- shift left by `k` bits. -/
| shiftL : Term .bv → Nat → Term .bv
-- /-- logical shift right by `k` bits. -/
-- | lshiftR : Term → Nat → Term
-- bollu: I don't think we can do ashiftr, because it's output is 'irregular',
--   hence, I don't anticipate us implementing it.
deriving Repr, Inhabited

inductive BTerm : Type
| msb : Term .bv → BTerm
| tru : BTerm
| fals : BTerm
| xor : BTerm → BTerm → BTerm
| var : Nat → BTerm
deriving Repr, Inhabited

open Term

instance : Add (Term .bv) := ⟨add⟩
instance : Sub (Term .bv) := ⟨sub⟩
instance : One (Term .bv) := ⟨one⟩
instance : Zero (Term .bv) := ⟨zero⟩
instance : Neg (Term .bv) := ⟨neg⟩

/-- `t.arity` is the max free variable id that occurs in the given term `t`,
and thus is an upper bound on the number of free variables that occur in `t`.

Note that the upper bound is not perfect:
a term like `var 10` only has a single free variable, but its arity will be `11` -/
@[simp] def Term.arity {k : TermKind} (t : Term k) : Nat :=
  match k, t with
  | .bv, (var n) => n+1
  | .bv, zero => 0
  | .bv, one => 0
  | .bv, negOne => 0
  | .bv, ofNat _ => 0
  | .bv, Term.and t₁ t₂ => max (arity t₁) (arity t₂)
  | .bv, Term.or t₁ t₂ => max (arity t₁) (arity t₂)
  | .bv, Term.xor t₁ t₂ => max (arity t₁) (arity t₂)
  | .bv, Term.not t => arity t
  | .bv, add t₁ t₂ => max (arity t₁) (arity t₂)
  | .bv, sub t₁ t₂ => max (arity t₁) (arity t₂)
  | .bv, neg t => arity t
  --.bv,  | incr t => arity t
  --.bv,  | decr t => arity t
  | .bv, shiftL t .. => arity t
  --.bv,  | repeatBit t => arity t

@[simp] def BTerm.arity : BTerm → Nat
| .msb t => (t.arity)
| .var n => (n + 1)
| .tru => 0
| .fals => 0
| .xor a b =>  max (arity a) (arity b)

inductive BinaryPredicate
| eq
| neq
| ult
| ule
| slt
| sle
deriving Repr


inductive BoolBinaryPredicate
| eq
| neq
deriving Repr, Inhabited

inductive WidthPredicate
| eq
| neq
| lt
| le
| gt
| ge
deriving Repr, Inhabited

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
| binary (p : BinaryPredicate) (t₁ t₂ : Term .bv)
| boolBinary (p : BoolBinaryPredicate) (t₁ t₂ : BTerm)
| land  (p q : Predicate) : Predicate
| lor (p q : Predicate) : Predicate
deriving Repr, Inhabited

-- TODO: This ugly definition is here to make the `predicateEvalEqFSM` function compile wihtout change.
@[simp] def Predicate.arity : Predicate → Nat
| .width _ _ => 0
| .boolBinary .eq t1 t2 => max t1.arity t2.arity
| .boolBinary .neq t1 t2 => max t1.arity t2.arity
| .binary .eq t1 t2 => max t1.arity t2.arity
| .binary .neq t₁ t₂ => max t₁.arity t₂.arity
| .binary .ult t₁ t₂ => max t₁.arity t₂.arity
| .binary .ule t₁ t₂ => t₁.arity ⊔ t₂.arity ⊔ (t₁.arity ⊔ t₂.arity)
| .binary .slt t₁ t₂ => (t₁.arity ⊔ t₂.arity ⊔ (t₁.arity ⊔ t₂.arity))
| .binary .sle t₁ t₂ => (t₁.arity ⊔ t₂.arity ⊔ (t₁.arity ⊔ t₂.arity) ⊔ (t₁.arity ⊔ t₂.arity))
| .lor p q => max p.arity q.arity
| .land p q => max p.arity q.arity

/-- toBitVec a Term into its underlying bitvector -/
def Term.denote (w : Nat) (t : Term .bv) (vars : List (BitVec w)) : BitVec w :=
  match t with
  | ofNat n => BitVec.ofNat w n
  | var n => vars.getD n default
  | zero => 0#w
  | negOne => -1#w
  | one  => 1#w
  | and a b => (a.denote w vars) &&& (b.denote w vars)
  | or a b => (a.denote w vars) ||| (b.denote w vars)
  | xor a b => (a.denote w vars) ^^^ (b.denote w vars)
  | not a => ~~~ (a.denote w vars)
  | add a b => (a.denote w vars) + (b.denote w vars)
  | sub a b => (a.denote w vars) - (b.denote w vars)
  | neg a => - (a.denote w vars)
  -- | incr a => (a.denote w vars) + 1#w
  -- | decr a => (a.denote w vars) - 1#w
  | shiftL a n => (a.denote w vars) <<< n


/-- toBitVec a Term into its underlying bitvector -/
def BTerm.denote (w : Nat) (t : BTerm) (vars : List (BitVec w)) (bvars : List Bool) : Bool :=
  match t with
  | .var x => bvars.getD x false
  | .msb x => (x.denote w vars).msb
  | .tru => Bool.true
  | .fals => Bool.false
  | .xor a b => (a.denote w vars bvars).xor (b.denote w vars bvars)

def Predicate.denote (p : Predicate) (w : Nat) (vars : List (BitVec w)) : Prop :=
  match p with
  | .width .ge k => k ≤ w -- w ≥ k
  | .width .gt k => k < w -- w > k
  | .width .le k => w ≤ k
  | .width .lt k => w < k
  | .width .neq k => w ≠ k
  | .width .eq k => w = k
  | .boolBinary .eq t₁ t₂ => t₁.denote w vars = t₂.denote w vars
  | .boolBinary .neq t₁ t₂ => t₁.denote w vars = t₂.denote w vars
  | .binary .eq t₁ t₂ => t₁.denote w vars = t₂.denote w vars
  | .binary .neq t₁ t₂ => t₁.denote w vars ≠ t₂.denote w vars
  | .binary .sle  t₁ t₂ => ((t₁.denote w vars).sle (t₂.denote w vars)) = true
  | .binary .slt  t₁ t₂ => ((t₁.denote w vars).slt (t₂.denote w vars)) = true
  | .binary .ule  t₁ t₂ => ((t₁.denote w vars).ule (t₂.denote w vars)) = true
  | .binary .ult  t₁ t₂ => (t₁.denote w vars).ult (t₂.denote w vars) = true
  | .land  p q => p.denote w vars ∧ q.denote w vars
  | .lor  p q => p.denote w vars ∨ q.denote w vars
