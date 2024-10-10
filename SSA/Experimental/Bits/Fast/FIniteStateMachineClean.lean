import Mathlib.Data.Fintype.Card
import Mathlib.Data.Fintype.Sum
import Mathlib.Data.Fintype.Sigma
import Mathlib.Data.Fintype.Pi
import Mathlib.Data.Fintype.BigOperators
import Mathlib.Tactic.Zify
import Mathlib.Tactic.Ring

import SSA.Experimental.Bits.Fast.Defs
import SSA.Experimental.Bits.Fast.Circuit

open Sum

section FSM
variable {σ β σ' β' : Type} {γ : β → Type}

def portingSorryImpl {α : Sort _}  : α := sorryAx α

@[implemented_by portingSorryImpl]
axiom portingSorryAx {α : Sort _}  : α

def BoolProd (ι : Type) : Type :=
  ι → Bool

namespace BoolProd

def comap {ι ω : Type} (f : ι → ω) (xs : BoolProd ω) : BoolProd ι :=
  fun i => xs (f i)

theorem comap_eq {ι ω : Type} (f : ι → ω) (xs : BoolProd ω) :
    (comap f xs) = fun i => xs (f i) := by
  rfl

instance : HAppend (BoolProd ι) (BoolProd ω) (BoolProd (ι ⊕ ω)) where
  hAppend := Sum.elim

theorem append_def (xs : BoolProd ι) (ys : BoolProd ω) (i : ι ⊕ ω) :
    (xs ++ ys) i = Sum.elim xs ys i := by rfl

@[simp]
theorem append_inl (xs : BoolProd ι) (ys : BoolProd ω)  :
    (xs ++ ys) (Sum.inl i) = (xs i) := by rfl
@[simp]
theorem append_inr (xs : BoolProd ι) (ys : BoolProd ω)  :
    (xs ++ ys) (Sum.inr w) = (ys w) := by rfl

def getLsb' (xs : BoolProd ι) (i : ι) : Bool := xs i

@[simp]
theorem getLsb_eq (xs : BoolProd ι) (i : ι) :
    xs.getLsb' i = xs i := by
  rfl

end BoolProd

namespace Fin

def addToSum (i : Fin (x + y)) : Fin x ⊕ Fin y :=
  if h : i < y then
    .inr ⟨i, h⟩
  else
    .inl (i.subNat y <| by simp_all)

@[simp] abbrev addInl (i : Fin x) : Fin (x + y) := castAdd y i
@[simp] abbrev addInr (i : Fin y) : Fin (x + y) := natAdd x i

@[deprecated addCases]
def addElim (f : Fin x → α) (g : Fin y → α) : Fin (x + y) → α :=
  addCases f g

def sumOfSigma {f : α → Nat} [Fintype α] (i : Σ a, Fin (f a)) : Fin (∑ a, f a) := by
  exact portingSorryAx

def sumToSigma {f : α → Nat} [Fintype α] (i : Fin (∑ a, f a)) : Σ a, Fin (f a) := by
  exact portingSorryAx

end Fin

/-- An `n`-ary product of `Bitstream`s. -/
def BitStreamProd (ι : Type) : Type := ι → BitStream

namespace BitStreamProd

/-- Return the `i`-th stream of `x` -/
def nthStream (x : BitStreamProd ι) (i : ι) : BitStream := x i

/-- Get the `i`th least significant bit of each constituent stream -/
def getLsbs (xs : BitStreamProd ι) (i : Nat) : BoolProd ι :=
  fun j => xs j i

/-- Get the least significant bit of each constituent stream -/
def heads (xs : BitStreamProd ι) : BoolProd ι :=
  fun i => (xs i).head

/-- Drop the least significant bit from each constituent stream,
returning an n-ary product of each streams tail  -/
def tails (xs : BitStreamProd ι) : BitStreamProd ι :=
  fun i => (xs i).tail

def comap (f : ω → ι) : BitStreamProd ι → BitStreamProd ω :=
  fun xs j => xs (f j)

section Lemmas

@[simp] lemma getElem_heads (xs : BitStreamProd ι) (i : ι) :
    xs.heads i = (xs i).head := by
  simp [heads]

/-! ### Note about normal forms for BitStreamProd

We will strive to rewrite everything in terms of 'getElem', and so
all normalized indexing into a BitSream, BitStreamProd, CircuitProd, etc.
should always look like `(xs i j)`, with no intervening `getLsb` or `getElem`
calls.
-/

/-- TODO: rename theorem. -/
lemma getLsb'_heads_eq_self_head (xs : BitStreamProd ι) (i : ι) :
    xs.heads.getLsb' i = (xs i).head := rfl

/-- TODO: rename theorem. -/
lemma getLsb'_heads_eq_self_zero (xs : BitStreamProd ι) (i : ι) :
    xs.heads.getLsb' i = (xs i 0) := rfl

@[simp] lemma getElem_getLsbs (xs : BitStreamProd ι) (i : Nat) (j : ι) :
    (xs.getLsbs i) j = xs j i := by
  simp [getLsbs]

 @[simp] lemma getElem_tails (xs : BitStreamProd ι) (i : Nat) (j : ι) :
     xs.tails j i = xs j (i + 1) := by
   simp [tails, BitStream.getElem_tail]

@[simp] lemma getLsb'_getLsbs (xs : BitStreamProd ι) (i : Nat) (j : ι) :
    (xs.getLsbs i).getLsb' j = xs j i := by
  unfold getLsbs
  unfold BoolProd.getLsb'
  simp

end Lemmas

end BitStreamProd

/--
`CircuitProd vars n` is a collection of `n` Boolean Circuits, each of which can
refer to at most `vars` variables.

This morally represents a function from `BoolProd vars`
(i.e., an assignment of a single bit per variable),
to a `BoolProd ι` (where each circuit computes a single bit of the output).
See `CircuitProd.eval`.
-/
def CircuitProd (vars ι : Type) : Type :=
  ι → Circuit vars

namespace CircuitProd


/-- Evaluate a `CircuitProd vars n` to the function `BoolProd vars → BoolProd ι`
it represents.

By convention, we use Little Endian order, which is to say, the `i`th circuit
will compute the `i`-th least significant bit of the output, and the variable
with index `i` derives it's assignment from the `i`-th least signicant bit of
the input.
-/
def eval {vars ι : Type}
    (circuit : CircuitProd vars ι) (assignment : BoolProd vars) :
    BoolProd ι :=
  fun i =>
    (circuit i).eval assignment

@[simp] lemma getLsbD_eval (c : CircuitProd vars ι) (assignment : BoolProd vars)
    (i : ι) :
    (c.eval assignment) i = (c i).eval assignment := by
  simp [eval]

/-- The identity circuit family on `n` bits -/
def id (ι : Type) : CircuitProd ι ι :=
  fun i => Circuit.var true i

@[simp] lemma eval_id : eval (id ι) = _root_.id := rfl

def map (f : ι → ω) (cs : CircuitProd ι k) : CircuitProd ω k :=
  fun i => (cs i).map f

@[simp] lemma eval_map (f : ι → ω) (cs : CircuitProd ι k) (xs : BoolProd ω) :
    eval (cs.map f) xs = eval cs (xs.comap f) := by
  funext i
  simp [BoolProd.comap_eq, map]

/-- Re-interpret a family of circuits with `x` variables as a family with
`x + y` variables -/
def addInl : CircuitProd ι n → CircuitProd (ι ⊕ ω) n :=
  map Sum.inl

/-- Re-interpret a family of circuits with `y` variables as a family with
`x + y` variables -/
def addInr : CircuitProd ω n → CircuitProd (ι ⊕ ω) n :=
  map Sum.inr

def sigmaMk {f : ι → Type} {i : ι} :
    CircuitProd (f i) n → CircuitProd (Σ j, f j) n :=
  map (Sigma.mk i)

def append : (CircuitProd vars n) → (CircuitProd vars m) → (CircuitProd vars (n ⊕ m)) :=
  Sum.elim

instance : HAppend (CircuitProd vars n) (CircuitProd vars m)
    (CircuitProd vars (n ⊕ m)) where
  hAppend := append

@[simp] lemma eval_append {vars n m}
    (xs : CircuitProd vars n) (ys : CircuitProd vars m) (V : BoolProd vars) :
    eval (xs ++ ys) V = (eval xs V) ++ (eval ys V) := by
  funext i; cases i <;> rfl

lemma eval_append_eq {vars n m}
    (xs : CircuitProd vars n) (ys : CircuitProd vars m) :
    eval (xs ++ ys) = fun V => (eval xs V) ++ (eval ys V) := by
  funext V; simp

-- def bind (cs : CircuitProd n k) (f : Fin n → CircuitProd )

instance : Subsingleton (CircuitProd n Empty) :=
  inferInstanceAs (Subsingleton (Empty → _))

end CircuitProd

/-- Width is a type, which has an element `α`.
Here, the cardinality of `α` is to be thought of as a number that represents the
width of a bitvector.
In the FSM, this is used to declare the width of the bitvector that is the internal state.
-/
structure Width where
  /-- The type whose cardinality encodes the width. -/
  α : Type
  /-- The cardinality of the type is finite -/
  [instFintype : Fintype α]
  /-- The type can decide equality of its inhabintants. -/
  [instDecEq : DecidableEq α]

/-- A Width whose type is `Fin n`, which has exactly `n` inhabitants -/
def Width.n (n : Nat) : Width where
  α := Fin n

#check Fin.ofNat
#check Fin.instOfNat
#synth OfNat (Fin 10) 5


attribute [instance] Width.instFintype Width.instDecEq

instance : CoeSort Width Type where
  coe := Width.α

/-- Given an (i : Fin n), convert it to an inhabitant of (Width.n n) -/
def Width.n.mk {n : Nat} (i : Fin n) : (Width.n n) := i

instance : Coe (Fin n) (Width.n n) where
  coe := Width.n.mk

/--
The type `(Width.n n).α` is definitionally equal to `Fin n`,
so we write a simp lemma to strip the wrapper of `Width.n.mk`.
We still want the `Width.n.mk` for conceptual clarity,
to tell us that we can construct a `Width.n` with a `Fin n`.
This also has the pleasing effect of enabling autocomplete in places where
we expect a `Width.n n`, allowing us to write `(.mk 10) : Width.n 42`.
-/
@[simp]
theorem Width.n.mk_eq {n : Nat} (i : Fin n) : (Width.n.mk i) = i := rfl


/-- `FSM arity` represents a function `BitStream → ⋯ → BitStream → BitStream`,
where `arity` is the number of `BitStream` arguments,
as a finite state machine.
-/
structure FSM (arity : Type) : Type 1 :=
  /--
  `stateWidth` is the number of bits the state has
  -/
  (stateWidth : Width)
  /--
  `initialState` is the initial state.
  -/
  (initialState : BoolProd stateWidth)
  /--
  `outCircuit` is a single Boolean circuit,
  which will compute the output bit of the current state,
  given the current state and input bits.
  -/
  (outCircuit : Circuit (stateWidth ⊕ arity))
  /--
  `nextStateCircuit` is a uniform family of `stateWidth` Boolean circuits,
  where each circuit computes one bit of the next state,
  given the current state and input bits.
  -/
  (nextStateCircuits : CircuitProd (stateWidth ⊕ arity) stateWidth)

namespace FSM

/-- A `State` of FSM `p` is just a bitvector with `p.stateWidth` bits -/
abbrev State (p : FSM arity) : Type := BoolProd p.stateWidth

@[deprecated HAppend.hAppend]
def appendInput {p : FSM arity} (s : BoolProd p.stateWidth) (x : BoolProd arity) :
    BoolProd (p.stateWidth ⊕ arity) :=
  s ++ x

variable {arity} (p : FSM arity)

/-- Return the output bit of FSM `p`, given the current state and input bits. -/
@[simp]
def outBit (state : p.State) (input : BoolProd arity) : Bool :=
  (p.outCircuit).eval (state ++ input).getLsb'

/-- Return the next state of FSM `p`, given the current state and input bits. -/
@[simp]
def nextState (s : p.State) (input : BoolProd arity) : p.State :=
  p.nextStateCircuits.eval (s ++ input)

/-- `p.next state in` computes both the next state bits and the output bit,
where `state` are the *current* state bits, and `in` are the current input bits. -/
@[simp]
def next (state : p.State) (inputBits : BoolProd arity) : p.State × Bool :=
    let newState := p.nextState state inputBits
    let outBit   := p.outBit state inputBits
    (newState, outBit)

-- TODO: document this
def outputStreamAux (s₀ : p.State) (inputStream : BitStreamProd arity) : BitStream := fun n =>
  match n with
  | 0 => p.outBit s₀ inputStream.heads
  | n+1 => outputStreamAux (nextState p s₀ (inputStream.heads)) inputStream.tails n

@[simp]
theorem outputStreamAux_zero (s₀ : p.State) (inputStream : BitStreamProd arity) :
    outputStreamAux p s₀ inputStream 0 = p.outBit s₀ (inputStream.getLsbs 0) := rfl

@[simp]
theorem outputStreamAux_succ (s₀ : p.State) (inputStream : BitStreamProd arity) (n : ℕ) :
    outputStreamAux p s₀ inputStream (n+1) =
    outputStreamAux p (p.nextState s₀ (inputStream.heads)) inputStream.tails n := by rfl

/--
A `StateStream` w.r.t. FSM `p` is an infinite stream of `p.State`s
-/
def StateStream (p : FSM arity) := ℕ → p.State

/-- `p.stateStream` is the stream of states of FSM `p`,
for a given product of input streams.

That is, it is the stream that starts with `p.initialState`,
and evolves according to `p.nextState`. -/
def stateStream (p : FSM arity) (xs : BitStreamProd arity) : p.StateStream
  | 0 => p.initialState
  | n+1 => (p.nextState (p.stateStream xs n) (xs.getLsbs n))

@[simp]
theorem stateStream_zero (xs : BitStreamProd arity) :
    p.stateStream xs 0 = p.initialState := rfl

@[simp]
theorem stateStream_succ (inputStream : BitStreamProd arity) (n : Nat) :
    p.stateStream inputStream (n+1)
    = p.nextState (p.stateStream inputStream n) (inputStream.getLsbs n) :=
  rfl

-- /-- `eval p` morally gives the function `BitStream → ... → BitStream` represented by FSM `p` -/
def eval (xs : BitStreamProd arity) : BitStream :=
   p.outputStreamAux p.initialState xs

def eval.next (xs : BitStreamProd arity × p.State) :
    (BitStreamProd arity × p.State) × Bool := -- (fun ⟨x, (state : p.State)⟩ =>
  let x       := xs.1
  let state   := xs.2
  let x_head  := x.heads
  let next    := p.next state x_head
  let x_tail  := x.tails
  ((x_tail, next.fst), next.snd)

/-- `eval'` is an alternative definition of `eval`, written in terms of corecursion.  -/
def eval' (x : BitStreamProd arity) : BitStream :=
  BitStream.corec (eval.next p) (x, p.initialState)

-- /--
-- Generalized hypothesis that shows how the output stream and
-- its corecursive definition evolve with an arbitrary input state.
-- -/

/-- `p.withInitialState s` yields an FSM with `s` as the initial state -/
def withInitialState (p : FSM arity) (s : p.State) : FSM arity :=
  { p with initialState := s }

/-!
## Concrete FSMs
From here on out, we start to implement various operations as concrete FSMs
-/

/-! ### Bitwise operations -/



/--
Build a circuit of type `Width.n 0 ⊕ α` from a `Circuit α`.
This is always canonically possible, because a `Width.n 0` has no inhabintants.
-/
def Circuit.widthZero_sum (c : Circuit α) : Circuit (Width.n 0 ⊕ α) :=
  c.map inj
  where
  inj (a : α) : Width.n 0 ⊕ α := Sum.inr a

instance : Subsingleton (Width.n 0) :=
  inferInstanceAs (Subsingleton (Fin 0))

instance : Subsingleton (Width.n 1) :=
  inferInstanceAs (Subsingleton (Fin 1))

instance : Subsingleton (BoolProd (Width.n 0)) :=
  inferInstanceAs (Subsingleton (Fin 0 → Bool))

theorem Subsingleton_of_codom_Subsingleton [Subsingleton o] :
    Subsingleton (i → o) := by
  constructor
  intros a b
  funext o
  apply Subsingleton.allEq

/--
If the FSM does not have any appreciable state,
then evaluating from a stream `xs` at index `i` does not actually evolve the state,
and we can thus directly evaluate the FSM at index `i + 1` without having
to take into account the evolution of the state the bit `(xs i)` would have induced.
-/
@[simp]
def eval_tails_of_Subsingleton (xs : BitStreamProd arity) [hp : Subsingleton p.State] :
    (p.eval xs.tails) i = (p.eval xs) (i + 1) := by
  simp [eval]
  congr
  apply Subsingleton.allEq

def Width.elim0 {α : Sort _} (x : Width.n 0) : α :=
  Fin.elim0 x


/--
Build a circuit of type `α` from a `Circuit (Width.n 0 ⊕ α)`.
This is always canonically possible, because a `Width.n 0` has no inhabintants.
-/
def Circuit.of_widthZero_sum (c : Circuit (Width.n 0 ⊕ α)) : Circuit α :=
  c.map inj
  where
  inj (pair : Width.n 0 ⊕ α) : α :=
    -- Sum.elim Fin.elim0 id pair
    match pair with
    | .inl (valWidth0 : Width.n 0) => Width.elim0 valWidth0
    | .inr (a : α) => a

/--
Build a zero-product of circuits, where each circuit has `α` number of variables.
Since we are producing an empty product, this is the trivial, canonical product.

CircuitProd (Width.n 2) (Width.n 3)

x0  x1
|    |
+-+--+
| |  |
v v  v
y0 y1 y2

-/
def CircuitProd.ofWidth0 : CircuitProd α (Width.n 0) :=
  fun (i : Width.n 0) => Width.elim0 i

/-bitwise AND term:

..1101
..1001
--------
..1001

Two arguments, therefore 'FSM Bool' (where 'Bool' is the arity.)
Fin 2 == Bool, anything with two members
Requires no state, therefore stateWidth is zero.
-/
def bitwiseAnd : FSM (Fin 2) where
  stateWidth := Width.n 0
  initialState := fun x => x.elim0
  outCircuit :=
    let vl := Circuit.var true 0 -- left bit
    let vr := Circuit.var true 1 -- right bit
    let circuit := Circuit.and vl vr
    Circuit.widthZero_sum circuit
  nextStateCircuits := CircuitProd.ofWidth0

instance : Subsingleton (bitwiseAnd.State) := by
  simp [FSM.State, bitwiseAnd]
  infer_instance


/--
proof sketch:
1. Unfold  (&&&) as a `corec`.
2. Unfold `bitwiseAnd.eval` as corec.
3. This gives us something of the form `corec <stuff> = corec <stuff>`
4. Apply `BitStream.corec_eq_corec to prove "one step"
5. We've already proved the "one step" :) Unfold everything! It will just work TM, can copy the existing proof below.
6. $$$
-/
@[simp] lemma eval_bitwiseAnd (xs : BitStreamProd (Fin 2)) :
    bitwiseAnd.eval xs = (xs 0) &&& (xs 1) := by
  ext i
  induction i generalizing xs
  case zero => simp [eval, Circuit.widthZero_sum.inj]
  case succ i ih =>
    simp [eval.next]
    specialize ih xs.tails
    simp at ih
    rw [← ih]

/-- info: 'FSM.eval_bitwiseAnd' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms eval_bitwiseAnd

def bitwiseOr : FSM (Fin 2) where
  stateWidth := Width.n 0
  initialState := fun x => x.elim0
  outCircuit :=
    let vl := Circuit.var true 0 -- left bit
    let vr := Circuit.var true 1 -- right bit
    let circuit := Circuit.or vl vr
    Circuit.widthZero_sum circuit
  nextStateCircuits := CircuitProd.ofWidth0

instance : Subsingleton (bitwiseOr.State) := by
  simp [FSM.State, bitwiseOr]
  infer_instance

@[simp] lemma eval_bitwiseOr (xs : BitStreamProd (Fin 2)) :
    bitwiseOr.eval xs = (xs 0) ||| (xs 1) := by
  ext i
  induction i generalizing xs
  case zero =>
    simp [eval, Circuit.widthZero_sum.inj]
  case succ i ih =>
    simp [eval.next]
    specialize ih xs.tails
    simp at ih
    simp [← ih]

/-- info: 'FSM.eval_bitwiseOr' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms eval_bitwiseOr

def bitwiseXor : FSM (Fin 2) where
  stateWidth := Width.n 0
  initialState := fun x => x.elim0
  outCircuit :=
    let vl := Circuit.var true 0 -- left bit
    let vr := Circuit.var true 1 -- right bit
    let circuit := Circuit.xor vl vr
    Circuit.widthZero_sum circuit
  nextStateCircuits := CircuitProd.ofWidth0

instance : Subsingleton (bitwiseXor.State) := by
  simp [FSM.State, bitwiseXor]
  infer_instance

@[simp] lemma eval_bitwiseXor (xs : BitStreamProd (Fin 2)) :
    bitwiseXor.eval xs = (xs 0) ^^^ (xs 1) := by
  ext i
  induction i generalizing xs
  case zero =>
    simp [eval, Circuit.widthZero_sum.inj]
  case succ i ih =>
    simp [eval.next]
    specialize ih xs.tails
    simp at ih
    simp [← ih]

/-- info: 'FSM.eval_bitwiseOr' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms eval_bitwiseOr

/-! ### Predicates -/

/--
To build a `CircuitProd` that produces `1` bit as output with `α as inputs,
we use a single circuit that produces `1` bit as output with `α` as inputs.
-/
def CircuitProd.ofWidth1 (c : Circuit α) :
    (CircuitProd α (Width.n 1)) :=
  fun (_ : Width.n 1) => c

def Circuit.inr (c : Circuit β) : Circuit (α ⊕ β) := c.map Sum.inr


/--
`predicateAtBit` is a circuit that computes the predicate at the current bit.
We need to enforce the behaviour that if `predicateAtBit[i] = 0`, then
`(mkBinaryPredicate predicateAtBit)[i + k] = 0` for all `k ∈ ℕ`.
That is, if the `predicateAtBit` ever becomes `0`,
then the automata created by `mkBinaryPredicate` will say as zeroes forever.

To achieve this, we use a single bit of state to the automata, which is `0` if
`predicateAtBit` has ever produced a `0`. -/
def mkBinaryPredicate (predicateAtBit : Circuit (Fin 2)) : FSM (Fin 2) where
  stateWidth := Width.n 1
  initialState := fun _ => true -- initial state is `1`, always one until the property holds
  outCircuit :=
    -- | current output.
    let predTrueSoFar? := Circuit.var true (Sum.inl (Width.n.mk 0))
    let predTrueNow? := (Circuit.inr predicateAtBit)
    Circuit.and predTrueSoFar? predTrueNow?
  nextStateCircuits :=
    -- | next state, which is the same as the current output,
    -- since if we produce a `0`, we want to forever produce zeroes,
    -- and if we produce a `1`, we want to see the next bit.
    let predTrueSoFar? := Circuit.var true (Sum.inl (Width.n.mk 0))
    let predTrueNow? := (Circuit.inr predicateAtBit)
    CircuitProd.ofWidth1 <| Circuit.and predTrueSoFar? predTrueNow?

def and' : FSM (Fin 2) :=
  let vl := Circuit.var true 0
  let vr := Circuit.var true 1
  mkBinaryPredicate (Circuit.and vl vr)

def or' : FSM (Fin 2) :=
  let vl := Circuit.var true 0
  let vr := Circuit.var true 1
  mkBinaryPredicate (Circuit.or vl vr)
