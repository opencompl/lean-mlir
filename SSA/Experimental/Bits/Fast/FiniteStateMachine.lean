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

namespace BitVec

@[simp]
theorem getLsbD_append_left (x : BitVec v) (y : BitVec w) (i : Nat)
    (h : ¬(i < w)) :
    getLsbD (x ++ y) i = x.getLsbD (i - w) := by
  simp [getLsbD_append, h]

@[simp]
theorem getLsbD_append_right (x : BitVec v) (y : BitVec w) (i : Nat)
    (h : i < w) :
    getLsbD (x ++ y) i = y.getLsbD i := by
  simp [getLsbD_append, h]

/-- `appendVector` appends a family of `n` bitvectors, each of which might have
a different width, together into a bitvector whose length is the sum of lengths
-/
def appendVector {ws : Fin n → Nat} (xs : (i : Fin n) → BitVec (ws i)) :
    BitVec (∑ i, ws i) :=
  match n with
  | 0   => 0#_
  | n+1 =>
    let x := xs 0
    (x ++ (appendVector (fun i => xs i.succ))).cast <| by
      simp [Finset.sum]

/-- Construct a bitvector from a function that maps `i : Fin w` to the
`i`-th least significant bit -/
def ofFnLsb (f : Fin w → Bool) : BitVec w :=
  match w with
  | 0   => 0#0
  | _+1 => concat (ofFnLsb (f ∘ Fin.succ)) (f 0)

@[simp] lemma getElem_ofFnLsb (f : Fin w → Bool) (i : Fin w) :
    (ofFnLsb f)[i.val] = f i := by
  sorry

end BitVec

namespace Fin

def addToSum (i : Fin (x + y)) : Fin x ⊕ Fin y :=
  if h : i < y then
    .inr ⟨i, h⟩
  else
    .inl (i.subNat y <| by simp_all)

@[simp] abbrev addInl (i : Fin x) : Fin (x + y) := castAdd y i
@[simp] abbrev addInr (i : Fin y) : Fin (x + y) := natAdd x i

def addElim (f : Fin x → α) (g : Fin y → α) : Fin (x + y) → α :=
  fun i => Sum.elim f g (addToSum i)

def sumOfSigma {f : α → Nat} [Fintype α] (i : Σ a, Fin (f a)) : Fin (∑ a, f a) :=
  sorry

def sumToSigma {f : α → Nat} [Fintype α] (i : Fin (∑ a, f a)) : Σ a, Fin (f a) :=
  sorry

end Fin

/-- An `n`-ary product of `Bitstream`s. -/
def BitStreamProd (n : Nat) : Type := Fin n → BitStream

namespace BitStreamProd

/-- Return the `i`-th stream of `x` -/
def nthStream (x : BitStreamProd n) (i : Fin n) : BitStream := x i

/-- Get the `i`th least significant bit of each constituent stream -/
def getLsbs (xs : BitStreamProd n) (i : Nat) : BitVec n :=
  BitVec.ofFnLsb fun j => xs j i

/-- Get the least significant bit of each constituent stream -/
def heads (xs : BitStreamProd n) : BitVec n :=
  BitVec.ofFnLsb fun i => (xs i).head

/-- Drop the least significant bit from each constituent stream,
returning an n-ary product of each streams tail  -/
def tails (xs : BitStreamProd n) : BitStreamProd n :=
  fun i => (xs i).tail

def castLE (h : n ≤ m) : BitStreamProd m → BitStreamProd n :=
  (· ∘ Fin.castLE h)

section Lemmas

@[simp] lemma getElem_heads (xs : BitStreamProd n) (i : Fin n) :
    xs.heads[i.val] = (xs i).head := by
  simp [heads]

@[simp] lemma getElem_getLsbs (xs : BitStreamProd n) (i : Nat) (j : Fin n) :
    (xs.getLsbs i)[j.val] = xs j i := by
  simp [getLsbs]

end Lemmas

end BitStreamProd

/--
`CircuitProd vars n` is a collection of `n` Boolean Circuits, each of which can
refer to at most `vars` variables.

This morally represents a function from `BitVec vars`
(i.e., an assignment of a single bit per variable),
to a `BitVec n` (where each circuit computes a single bit of the output).
See `CircuitProd.eval`.
-/
def CircuitProd (vars n : Nat) : Type := Fin n → Circuit (Fin vars)

namespace CircuitProd


/-- Evaluate a `CircuitProd vars n` to the function `BitVec vars → BitVec n`
it represents.

By convention, we use Little Endian order, which is to say, the `i`th circuit
will compute the `i`-th least significant bit of the output, and the variable
with index `i` derives it's assignment from the `i`-th least signicant bit of
the input.
-/
def eval {vars n : Nat}
    (circuit : CircuitProd vars n) (assignment : BitVec vars) :
    BitVec n :=
  BitVec.ofFnLsb fun i =>
    (circuit i).eval assignment.getLsb'

@[simp] lemma getLsbD_eval (c : CircuitProd vars n) (assignment : BitVec vars)
    (i : Fin n) :
    (c.eval assignment)[i.val]
    = (c i).eval assignment.getLsb' := by
  simp [eval]

/-- The identity circuit family on `n` bits -/
def id {n : Nat} : CircuitProd n n :=
  fun i => Circuit.var true i

@[simp] lemma eval_id {n : Nat} : eval id = (@_root_.id (BitVec n)) := by
  sorry

/-- Re-interpret a family of circuits with `x` variables as a family with
`x + y` variables -/
def addInl : CircuitProd x n → CircuitProd (x + y) n :=
  sorry
/-- Re-interpret a family of circuits with `y` variables as a family with
`x + y` variables -/
def addInr : CircuitProd y n → CircuitProd (x + y) n :=
  sorry

def append {vars n m} (xs : CircuitProd vars n) (ys : CircuitProd vars m) :
    CircuitProd vars (n + m) := by
  sorry

@[simp] lemma eval_append {vars n m}
    (xs : CircuitProd vars n) (ys : CircuitProd vars m) (V : BitVec vars) :
    eval (append xs ys) V = (eval xs V) ++ (eval ys V) := by
  sorry

instance : Subsingleton (CircuitProd n 0) :=
  inferInstanceAs (Subsingleton (Fin 0 → _))

end CircuitProd

/-- `FSM arity` represents a function `BitStream → ⋯ → BitStream → BitStream`,
where `arity` is the number of `BitStream` arguments,
as a finite state machine.
-/
structure FSM (arity : Nat) : Type 1 :=
  /--
  `stateWidth` is the number of bits the state has
  -/
  (stateWidth : Nat)
  /--
  `initialState` is the initial state.
  -/
  (initialState : BitVec stateWidth)
  /--
  `outCircuit` is a single Boolean circuit,
  which will compute the output bit of the current state,
  given the current state and input bits.
  -/
  (outCircuit : Circuit (Fin <| stateWidth + arity))
  /--
  `nextStateCircuit` is a uniform family of `stateWidth` Boolean circuits,
  where each circuit computes one bit of the next state,
  given the current state and input bits.
  -/
  (nextStateCircuits : CircuitProd (stateWidth + arity) stateWidth)

namespace FSM

/-- A `State` of FSM `p` is just a bitvector with `p.stateWidth` bits -/
abbrev State (p : FSM arity) : Type := BitVec p.stateWidth

@[deprecated BitVec.append]
def appendInput {p : FSM arity} (s : BitVec p.stateWidth) (x : BitVec arity) :
    BitVec (p.stateWidth + arity) :=
  s ++ x

variable {arity : Nat} (p : FSM arity)

/-- Return the output bit of FSM `p`, given the current state and input bits. -/
@[simp]
def outBit (state : p.State) (input : BitVec arity) : Bool :=
  (p.outCircuit).eval (state ++ input).getLsb'

/-- Return the next state of FSM `p`, given the current state and input bits. -/
@[simp]
def nextState (s : p.State) (input : BitVec arity) : p.State :=
  p.nextStateCircuits.eval (s ++ input)

/-- `p.next state in` computes both the next state bits and the output bit,
where `state` are the *current* state bits, and `in` are the current input bits. -/
@[simp]
def next (state : p.State) (inputBits : BitVec arity) : p.State × Bool :=
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
-- def eval (xs : BitStreamProd arity) : BitStream :=
--   p.outputStreamAux p.initialState xs

def eval.next (xs : BitStreamProd arity × p.State) :
    (BitStreamProd arity × p.State) × Bool := -- (fun ⟨x, (state : p.State)⟩ =>
  let x       := xs.1
  let state   := xs.2
  let x_head  := x.heads
  let next    := p.next state x_head
  let x_tail  := x.tails
  ((x_tail, next.fst), next.snd)

/-- `eval'` is an alternative definition of `eval`, written in terms of corecursion.  -/
def eval (x : BitStreamProd arity) : BitStream :=
  BitStream.corec (eval.next p) (x, p.initialState)

-- /--
-- Generalized hypothesis that shows how the output stream and
-- its corecursive definition evolve with an arbitrary input state.
-- -/
-- theorem eval_eq_eval'_aux (i : Nat) :
--     (p.outputStreamAux state x) i = (BitStream.corec (eval'Corec p) (x, state)) i := by
--   induction i generalizing state x
--   case zero => rfl
--   case succ i ih =>
--     simp [outputStreamAux, eval'Corec, BitStream.corec_succ]
--     rw [← ih]
--     rfl

-- /-- Show that the two definitions of evaluation are equivalent. -/
-- theorem eval_eq_eval' : p.eval x = p.eval' x := by
--   funext i
--   apply eval_eq_eval'_aux

/-- `p.withInitialState s` yields an FSM with `s` as the initial state -/
def withInitialState (p : FSM arity) (s : p.State) : FSM arity :=
  { p with initialState := s }

theorem eval_withInitialState_succ
    (p : FSM arity) (c : p.State) (xs : BitStreamProd arity) (n : ℕ) :
    (p.withInitialState c).eval xs (n+1) =
      (p.withInitialState (p.nextState c xs.heads)).eval (xs.tails) n := by
  simp [eval, withInitialState, next]; rfl


-- /-- `p.changeVars f` changes the arity of an `FSM`.
-- The function `f` determines how the new input bits map to the input expected by `p` -/
-- def changeVars {newArity : Nat} (changeVars : Fin arity → Fin newArity) :
--     FSM newArity :=
--   let map (x : BitVec newArity) : BitVec arity :=
--     BitVec.ofFnLsb (fun j => x[changeVars j])
--   { p with
--     outCircuit := p.outCircuit.map _
--     -- nextBitCirc := fun a => (p.nextBitCirc a).map (Sum.map id changeVars) }

-- open Fin in
-- def composeUnary (p : FSM 1) (q : FSM n) : FSM n where
--   stateWidth := p.stateWidth + q.stateWidth
--   initialState := p.initialState ++ q.initialState
--   outCircuit := p.outCircuit.bind <| addCases
--     (fun i => Circuit.var true (addInl <| addInl i))
--     (fun _ => q.outCircuit.map fun j =>
--       j.natAdd p.stateWidth |>.cast (by ac_rfl)
--     )
--   nextStateCircuits :=
--    addCases
--     (fun i => (p.nextStateCircuits i).bind <| )
--     _
--     -- p.nextStateCircuits

open Fin in
/--
Given an FSM `p` of some `arity`,
and a family of `arity` FSMs `qᵢ`,
whose (possibly differing) arities are bounded by `newArity`,
we can compose `p` with `qᵢ` yielding a single FSM of arity `newArity`.

The input of the composed FSM is given to the FSMs `qᵢ`, each of which computes
a single bit of the input that is then given to `p`. -/
def compose {newArity : Nat} {qArity : Fin arity → Nat}
    (arityLE : ∀ (a : Fin arity), qArity a ≤ newArity)
    (q : (i : Fin arity) → FSM (qArity i)) :
    FSM newArity :=
  let qOutCircuit : CircuitProd _ arity := fun (i : Fin arity) =>
    (q i).outCircuit.map <| Fin.addElim
      (fun j => (addInl (addInr (sumOfSigma ⟨i, j⟩))))
      (fun j => addInr (j.castLE (arityLE i)))
  { stateWidth    := p.stateWidth + (∑ i, (q i).stateWidth),
    initialState  := p.initialState ++ (BitVec.appendVector (q · |>.initialState))
    outCircuit :=
      open Fin in
      p.outCircuit.bind <|
        (_ : CircuitProd _ _)
        ++ qOutCircuit
    nextStateCircuits :=
      open Fin in
      addCases
       (fun i => (p.nextStateCircuits i).bind <| addCases
          (CircuitProd.id |>.addInl.addInl)
          qOutCircuit
       )
       (fun i =>
        let ⟨i, j⟩ := i.sumToSigma
        ((q i).nextStateCircuits j).map <| addCases
          (fun k => addInl (addInr (sumOfSigma ⟨_, k⟩)))
          (fun k => addInr (k.castLE <| arityLE i))
      )
  }

lemma stateStream_compose {newArity : Nat} {qArity : Fin arity → Nat}
    (arityLE : ∀ (i : Fin arity), qArity i ≤ newArity)
    (q : ∀ (i : Fin arity), FSM (qArity i))
    (xs : BitStreamProd newArity)
    (n : Nat) :
    (p.compose arityLE q).stateStream xs n =
      let pState := p.stateStream (fun i =>
        (q i).eval (fun j => xs <| j.castLE (arityLE _))) n
      let qState : BitVec (∑ i, (q i).stateWidth) :=
        BitVec.appendVector fun i =>
          ((q i).stateStream (xs.castLE <| arityLE _) n)
      pState ++ qState := by
  induction n with
  | zero => simp [stateStream, compose]
  | succ n ih =>
      rw [stateStream, ih]
      ext (y : Fin (_ + _))
      cases y using Fin.addCases
      · simp [stateStream, next, compose, Circuit.eval_bind, eval]
        congr
        ext (z : Fin (_ + _))
        cases z using Fin.addCases
        · simp;
          sorry
        · simp [Circuit.eval_map, stateStream]
          congr
          ext (s : Fin (_ + _))
          cases s using Fin.addCases
          · simp; sorry
          · simp; sorry
      · simp [Circuit.eval_map, stateStream, compose, eval, next]
        congr
        ext (z : Fin (_ + _))
        cases z using Fin.addCases
        · simp; sorry
        · simp; sorry

/-- Evaluating a composed fsm is equivalent to composing the evaluations of the constituent FSMs -/
lemma eval_compose {newArity : Nat} {qArity : Fin arity → Nat}
    (arityLE : ∀ (i : Fin arity), qArity i ≤ newArity)
    (q : ∀ (i : Fin arity), FSM (qArity i))
    (x : BitStreamProd newArity) :
    (p.compose arityLE q).eval x =
      p.eval (λ a => (q a).eval (fun i => x (i.castLE <| arityLE _))) := by
  ext n
  stop
  rw [eval, stateStream_compose, eval]
  simp [compose, next, Circuit.eval_bind]
  congr
  ext a
  cases a
  simp
  simp [Circuit.eval_map, eval, next]
  congr
  ext a
  cases a
  simp
  simp

/-!
## Concrete FSMs
From here on out, we start to implement various operations as concrete FSMs
-/

/-! ### Bitwise operations -/

/-- `mapCircuit` lifts a Boolean circuit into a stateless FSM -/
def mapCircuit (c : Circuit (Fin n)) : FSM n where
  stateWidth := 0
  initialState := 0#0
  outCircuit := c.map (Fin.cast <| by ac_rfl)
  nextStateCircuits := Fin.elim0

@[simp] lemma eval_mapCircuit (c : Circuit (Fin n)) (xs : BitStreamProd n) :
    (mapCircuit c).eval xs = (fun n => c.eval fun j => (xs.getLsbs n)[j.val]) := by
  funext m
  simp only [eval, mapCircuit]
  induction m generalizing xs
  case zero =>
    simp [eval.next, next, BitVec.zero_width_append _, BitStream.head]
  case succ m ih =>

    simp [eval.next]
    specialize ih xs.tails

    simp at ih
    rw [ih (xs.tails)]



def and : FSM 2 :=
  mapCircuit (Circuit.and
    (Circuit.var true 1)
    (Circuit.var true 0))

@[simp] lemma eval_and (xs : BitStreamProd 2) :
    and.eval x = (xs 1) &&& (xs 0) := by
  ext n;
  -- stop
  cases n <;> simp [mapCircuit, and, eval, next]

def or : FSM 2 :=
  mapCircuit (Circuit.or
    (Circuit.var true 1)
    (Circuit.var true 0))

@[simp] lemma eval_or (x : Bool → BitStream) : or.eval x = (x true) ||| (x false) := by
  ext n; cases n <;> simp [and, eval, next]

def xor : FSM 2 :=
  mapCircuit (Circuit.xor
    (Circuit.var true 1)
    (Circuit.var true 0))

@[simp] lemma eval_xor (xs : BitStreamProd 2) :
    xor.eval xs = (xs 1) ^^^ (xs 0) := by
  ext n; stop cases n <;> simp [and, eval, next]

/-! ### Arithmetic -/

def add : FSM 2 where
  stateWidth := 1
  initialState := 0#1
  outCircuit :=
    Circuit.var true 0
    ^^^ Circuit.var true 1
    ^^^ Circuit.var true 2
  nextStateCircuits _ :=
    (Circuit.var true 2 &&& Circuit.var true 1)
    ||| (Circuit.var true 2  &&& Circuit.var true 0)
    ||| (Circuit.var true 1 &&& Circuit.var true 0)

/-- The internal state of the `add` FSM agrees with
the carry bit of addition as implemented on bitstreams -/
theorem carry_add_succ (xs : BitStreamProd 2) (n : ℕ) :
    add.stateStream xs (n+1)
    = BitVec.ofBool ((BitStream.addAux (xs 1) (xs 0) n).2) := by
  ext (a : Fin 1)
  obtain rfl : a = (0 : Fin 1) := Fin.fin_one_eq_zero a
  induction n with
  | zero      =>
    simp [stateStream, BitStream.addAux, next, add, BitVec.adcb]
  | succ n ih =>
    unfold carry
    simp [next, ih, Circuit.eval, BitStream.addAux, BitVec.adcb]

@[simp] theorem carry_zero (x : BitStreamProd arity) : carry p x 0 = p.initialState := rfl
@[simp] theorem initialState_add : add.initialState = (fun _ => false) := rfl

@[simp] lemma eval_add (x : Bool → BitStream) : add.eval x = (x true) + (x false) := by
  ext n
  simp only [eval]
  cases n
  · show Bool.xor _ _ = Bool.xor _ _; simp
  · rw [carry_add_succ]
    conv => {rhs; simp only [(· + ·), BitStream.add, Add.add, BitStream.addAux, BitVec.adcb]}
    simp [next, eval, add]
/-!
We don't really need subtraction or negation FSMs,
given that we can reduce both those operations to just addition and bitwise complement -/

def sub : FSM Bool :=
  { σ := Unit,
    initialState := fun _ => false,
    nextBitCirc := fun a =>
      match a with
      | some () =>
             (Circuit.var false (inr true) &&& Circuit.var true (inr false)) |||
             ((Circuit.var false (inr true) ^^^ Circuit.var true (inr false)) &&&
              (Circuit.var true (inl ())))
      | none => Circuit.var true (inr true) ^^^
                Circuit.var true (inr false) ^^^
                Circuit.var true (inl ()) }

theorem carry_sub (x : Bool → BitStream) : ∀ (n : ℕ), sub.carry x (n+1) =
    fun _ => (BitStream.subAux (x true) (x false) n).2
  | 0 => by
    simp [carry, next, Function.funext_iff, BitStream.subAux, sub]
  | n+1 => by
    rw [carry, carry_sub _ n]
    simp [next, eval, sub, BitStream.sub, BitStream.subAux, Bool.xor_not_left']

@[simp]
theorem eval_sub (x : Bool → BitStream) : sub.eval x = (x true) - (x false) := by
  simp only [(· - ·), Sub.sub]
  ext n
  cases n
  · simp [eval, sub, next, BitStream.sub, BitStream.subAux, carry]
  · rw [eval, carry_sub]
    simp [next, eval, sub, BitStream.sub, BitStream.subAux]

def neg : FSM Unit :=
  { σ := Unit,
    i := by infer_instance,
    initialState := λ _ => true,
    nextBitCirc := fun a =>
      match a with
      | some () => Circuit.var false (inr ()) &&& Circuit.var true (inl ())
      | none => Circuit.var false (inr ()) ^^^ Circuit.var true (inl ())  }

theorem carry_neg (x : Unit → BitStream) : ∀ (n : ℕ), neg.carry x (n+1) =
    fun _ => (BitStream.negAux (x ()) n).2
  | 0 => by
    simp [carry, next, Function.funext_iff, BitStream.negAux, neg]
  | n+1 => by
    rw [carry, carry_neg _ n]
    simp [next, eval, neg, BitStream.neg, BitStream.negAux, Bool.xor_not_left']

@[simp] lemma eval_neg (x : Unit → BitStream) : neg.eval x = -(x ()) := by
  show _ = BitStream.neg _
  ext n
  cases n
  · simp [eval, neg, next, BitStream.neg, BitStream.negAux, carry]
  · rw [eval, carry_neg]
    simp [next, eval, neg, BitStream.neg, BitStream.negAux]

def not : FSM Unit :=
  { σ := Empty,
    initialState := Empty.elim,
    nextBitCirc := fun _ => Circuit.var false (inr ()) }

@[simp] lemma eval_not (x : Unit → BitStream) : not.eval x = ~~~(x ()) := by
  ext; simp [eval, not, next]

def zero : FSM (Fin 0) :=
  { σ := Empty,
    initialState := Empty.elim,
    nextBitCirc := fun _ => Circuit.fals }

@[simp] lemma eval_zero (x : Fin 0 → BitStream) : zero.eval x = BitStream.zero := by
  ext; simp [zero, eval, next]

def one : FSM (Fin 0) :=
  { σ := Unit,
    i := by infer_instance,
    initialState := λ _ => true,
    nextBitCirc := fun a =>
      match a with
      | some () => Circuit.fals
      | none => Circuit.var true (inl ()) }

@[simp] theorem carry_one (x : Fin 0 → BitStream) (n : ℕ) :
    one.carry x (n+1) = fun _ => false := by
  simp [carry, next, one]

@[simp] lemma eval_one (x : Fin 0 → BitStream) : one.eval x = BitStream.one := by
  ext n
  cases n
  · rfl
  · simp [eval, carry_one, next]

def negOne : FSM (Fin 0) :=
  { σ := Empty,
    i := by infer_instance,
    initialState := Empty.elim,
    nextBitCirc := fun _ => Circuit.tru }

@[simp] lemma eval_negOne (x : Fin 0 → BitStream) : negOne.eval x = BitStream.negOne := by
  ext; simp [negOne, eval, next]

def ls (b : Bool) : FSM Unit :=
  { σ := Unit,
    initialState := fun _ => b,
    nextBitCirc := fun x =>
      match x with
      | none => Circuit.var true (inl ())
      | some () => Circuit.var true (inr ()) }

theorem carry_ls (b : Bool) (x : Unit → BitStream) : ∀ (n : ℕ),
    (ls b).carry x (n+1) = fun _ => x () n
  | 0 => by
    simp [carry, next, Function.funext_iff, ls]
  | n+1 => by
    rw [carry, carry_ls _ _ n]
    simp [next, eval, ls]

@[simp] lemma eval_ls (b : Bool) (x : Unit → BitStream) :
    (ls b).eval x = (x ()).concat b := by
  ext n
  cases n
  · rfl
  · simp [carry_ls, eval, next, BitStream.concat]

def var (n : ℕ) : FSM (Fin (n+1)) :=
  { σ := Empty,
    i := by infer_instance,
    initialState := Empty.elim,
    nextBitCirc := λ _ => Circuit.var true (inr (Fin.last _)) }

@[simp] lemma eval_var (n : ℕ) (x : Fin (n+1) → BitStream) : (var n).eval x = x (Fin.last n) := by
  ext m; cases m <;> simp [var, eval, carry, next]

def incr : FSM Unit :=
  { σ := Unit,
    initialState := fun _ => true,
    nextBitCirc := fun x =>
      match x with
      | none => (Circuit.var true (inr ())) ^^^ (Circuit.var true (inl ()))
      | some _ => (Circuit.var true (inr ())) &&& (Circuit.var true (inl ())) }

theorem carry_incr (x : Unit → BitStream) : ∀ (n : ℕ),
    incr.carry x (n+1) = fun _ => (BitStream.incrAux (x ()) n).2
  | 0 => by
    simp [carry, next, Function.funext_iff, BitStream.incrAux, incr]
  | n+1 => by
    rw [carry, carry_incr _ n]
    simp [next, eval, incr, incr, BitStream.incrAux]

@[simp] lemma eval_incr (x : Unit → BitStream) : incr.eval x = (x ()).incr := by
  ext n
  cases n
  · simp [eval, incr, next, carry, BitStream.incr, BitStream.incrAux]
  · rw [eval, carry_incr]; rfl

def decr : FSM Unit :=
  { σ := Unit,
    i := by infer_instance,
    initialState := λ _ => true,
    nextBitCirc := fun x =>
      match x with
      | none => (Circuit.var true (inr ())) ^^^ (Circuit.var true (inl ()))
      | some _ => (Circuit.var false (inr ())) &&& (Circuit.var true (inl ())) }

theorem carry_decr (x : Unit → BitStream) : ∀ (n : ℕ), decr.carry x (n+1) =
    fun _ => (BitStream.decrAux (x ()) n).2
  | 0 => by
    simp [carry, next, Function.funext_iff, BitStream.decrAux, decr]
  | n+1 => by
    rw [carry, carry_decr _ n]
    simp [next, eval, decr, BitStream.decrAux]

@[simp] lemma eval_decr (x : Unit → BitStream) : decr.eval x = BitStream.decr (x ()) := by
  ext n
  cases n
  · simp [eval, decr, next, carry, BitStream.decr, BitStream.decrAux]
  · rw [eval, carry_decr]; rfl

theorem evalAux_eq_zero_of_set {arity : Type _} (p : FSM arity)
    (R : Set (p.σ → Bool)) (hR : ∀ x s, (p.next s x).1 ∈ R → s ∈ R)
    (hi : p.initialState ∉ R) (hr1 : ∀ x s, (p.next s x).2 = true → s ∈ R)
    (x : BitStreamProd arity) (n : ℕ) : p.eval x n = false ∧ p.carry x n ∉ R := by
  simp (config := {singlePass := true}) only [← not_imp_not] at hR hr1
  simp only [Bool.not_eq_true] at hR hr1
  induction n with
  | zero =>
    simp only [eval, carry]
    exact ⟨hr1 _ _ hi, hi⟩
  | succ n ih =>
    simp only [eval, carry] at ih ⊢
    exact ⟨hr1 _ _ (hR _ _ ih.2), hR _ _ ih.2⟩

theorem eval_eq_zero_of_set {arity : Type _} (p : FSM arity)
    (R : Set (p.σ → Bool)) (hR : ∀ x s, (p.next s x).1 ∈ R → s ∈ R)
    (hi : p.initialState ∉ R) (hr1 : ∀ x s, (p.next s x).2 = true → s ∈ R) :
    p.eval = fun _ _ => false := by
  ext x n
  rw [eval]
  exact (evalAux_eq_zero_of_set p R hR hi hr1 x n).1

def repeatBit : FSM Unit where
  σ := Unit
  initialState := fun () => false
  nextBitCirc := fun _ =>
    .or (.var true <| .inl ()) (.var true <| .inr ())

@[simp] theorem eval_repeatBit :
    repeatBit.eval x = BitStream.repeatBit (x ()) := by
  unfold BitStream.repeatBit
  rw [eval_eq_eval', eval']
  apply BitStream.corec_eq_corec
    (R := fun a b => a.1 () = b.2 ∧ (a.2 ()) = b.1)
  · simp [repeatBit]
  · intro ⟨y, a⟩ ⟨b, x⟩ h
    simp at h
    simp [h, next, BitStream.head]

end FSM

structure FSMSolution (t : Term) extends FSM (Fin t.arity) :=
  ( good : t.evalFin = toFSM.eval )

def composeUnary
    (p : FSM Unit)
    {t : Term}
    (q : FSMSolution t) :
    FSM (Fin t.arity) :=
  p.compose
    (Fin t.arity)
    _
    (λ _ => id)
    (λ _ => q.toFSM)

def composeBinary
    (p : FSM Bool)
    {t₁ t₂ : Term}
    (q₁ : FSMSolution t₁)
    (q₂ : FSMSolution t₂) :
    FSM (Fin (max t₁.arity t₂.arity)) :=
  p.compose (Fin (max t₁.arity t₂.arity))
    (λ b => Fin (cond b t₁.arity t₂.arity))
    (λ b i => Fin.castLE (by cases b <;> simp) i)
    (λ b => match b with
      | true => q₁.toFSM
      | false => q₂.toFSM)

def composeBinary'
    (p : FSM Bool)
    {n m : Nat}
    (q₁ : FSM (Fin n))
    (q₂ : FSM (Fin m)) :
    FSM (Fin (max n m)) :=
  p.compose (Fin (max n m))
    (λ b => Fin (cond b n m))
    (λ b i => Fin.castLE (by cases b <;> simp) i)
    (λ b => match b with
      | true => q₁
      | false => q₂)

@[simp] lemma composeUnary_eval
    (p : FSM Unit)
    {t : Term}
    (q : FSMSolution t)
    (x : Fin t.BitStreamProd arity) :
    (composeUnary p q).eval x = p.eval (λ _ => t.evalFin x) := by
  rw [composeUnary, FSM.eval_compose, q.good]; rfl

@[simp] lemma composeBinary_eval
    (p : FSM Bool)
    {t₁ t₂ : Term}
    (q₁ : FSMSolution t₁)
    (q₂ : FSMSolution t₂)
    (x : Fin (max t₁.arity t₂.arity) → BitStream) :
    (composeBinary p q₁ q₂).eval x = p.eval
      (λ b => cond b (t₁.evalFin (fun i => x (Fin.castLE (by simp) i)))
                  (t₂.evalFin (fun i => x (Fin.castLE (by simp) i)))) := by
  rw [composeBinary, FSM.eval_compose, q₁.good, q₂.good]
  ext b
  cases b <;> dsimp <;> congr <;> funext b <;> cases b <;> simp

instance {σ β : Type} [Fintype σ] [Fintype β] (b : Bool) :
    Fintype (cond b σ β) := by
  cases b <;> simp <;> infer_instance

open Term

def termEvalEqFSM : ∀ (t : Term), FSMSolution t
  | var n =>
    { toFSM := FSM.var n,
      good := by ext; simp [Term.evalFin] }
  | zero =>
    { toFSM := FSM.zero,
      good := by ext; simp [Term.evalFin] }
  | one =>
    { toFSM := FSM.one,
      good := by ext; simp [Term.evalFin] }
  | negOne =>
    { toFSM := FSM.negOne,
      good := by ext; simp [Term.evalFin] }
  | Term.and t₁ t₂ =>
    let q₁ := termEvalEqFSM t₁
    let q₂ := termEvalEqFSM t₂
    { toFSM := composeBinary FSM.and q₁ q₂,
      good := by ext; simp }
  | Term.or t₁ t₂ =>
    let q₁ := termEvalEqFSM t₁
    let q₂ := termEvalEqFSM t₂
    { toFSM := composeBinary FSM.or q₁ q₂,
      good := by ext; simp }
  | Term.xor t₁ t₂ =>
    let q₁ := termEvalEqFSM t₁
    let q₂ := termEvalEqFSM t₂
    { toFSM := composeBinary FSM.xor q₁ q₂,
      good := by ext; simp }
  | ls b t =>
    let q := termEvalEqFSM t
    { toFSM := by dsimp [arity]; exact composeUnary (FSM.ls b) q,
      good := by ext; simp }
  | Term.not t =>
    let q := termEvalEqFSM t
    { toFSM := by dsimp [arity]; exact composeUnary FSM.not q,
      good := by ext; simp }
  | add t₁ t₂ =>
    let q₁ := termEvalEqFSM t₁
    let q₂ := termEvalEqFSM t₂
    { toFSM := composeBinary FSM.add q₁ q₂,
      good := by ext; simp }
  | sub t₁ t₂ =>
    let q₁ := termEvalEqFSM t₁
    let q₂ := termEvalEqFSM t₂
    { toFSM := composeBinary FSM.sub q₁ q₂,
      good := by ext; simp }
  | neg t =>
    let q := termEvalEqFSM t
    { toFSM := by dsimp [arity]; exact composeUnary FSM.neg q,
      good := by ext; simp }
  | incr t =>
    let q := termEvalEqFSM t
    { toFSM := by dsimp [arity]; exact composeUnary FSM.incr q,
      good := by ext; simp }
  | decr t =>
    let q := termEvalEqFSM t
    { toFSM := by dsimp [arity]; exact composeUnary FSM.decr q,
      good := by ext; simp }
  | repeatBit t =>
    let p := termEvalEqFSM t
    { toFSM := by dsimp [arity]; exact composeUnary FSM.repeatBit p,
      good := by ext; simp }

/-!
FSM that implement bitwise-and. Since we use `0` as the good state,
we keep the invariant that if both inputs are good and our state is `0`, then we produce a `0`.
If not, we produce an infinite sequence of `1`.
-/
def and : FSM Bool :=
  { σ := Unit,
    initialState := fun _ => false,
    nextBitCirc := fun a =>
      match a with
      | some () =>
             -- Only if both are `0` we produce a `0`.
             (Circuit.var true (inr false)  |||
             ((Circuit.var false (inr true) |||
              -- But if we have failed and have value `1`, then we produce a `1` from our state.
              (Circuit.var true (inl ())))))
      | none => -- must succeed in both arguments, so we are `0` if both are `0`.
                Circuit.var true (inr true) |||
                Circuit.var true (inr false)
                }

/-!
FSM that implement bitwise-or. Since we use `0` as the good state,
we keep the invariant that if either inputs is `0` then our state is `0`.
If not, we produce a `1`.
-/
def or : FSM Bool :=
  { σ := Unit,
    initialState := fun _ => false,
    nextBitCirc := fun a =>
      match a with
      | some () =>
             -- If either succeeds, then the full thing succeeds
             ((Circuit.var true (inr false)  &&&
             ((Circuit.var false (inr true)) |||
             -- On the other hand, if we have failed, then propagate failure.
              (Circuit.var true (inl ())))))
      | none => -- can succeed in either argument, so we are `0` if either is `0`.
                Circuit.var true (inr true) &&&
                Circuit.var true (inr false)
                }

/-!
FSM that implement logical not.
we keep the invariant that if the input ever fails and becomes a `1`, then we produce a `0`.
IF not, we produce an infinite sequence of `1`.

EDIT: Aha, this doesn't work!
We need NFA to DFA here (as the presburger book does),
where we must produce an infinite sequence of`0` iff the input can *ever* become a `1`.
But here, since we phrase things directly in terms of producing sequences, it's a bit less clear
what we should do :)

- Alternatively, we need to be able to decide `eventually always zero`.
- Alternatively, we push negations inside, and decide `⬝ ≠ ⬝` and `⬝ ≰ ⬝`.
-/

inductive Result : Type
  | falseAfter (n : ℕ) : Result
  | trueFor (n : ℕ) : Result
  | trueForall : Result
deriving Repr, DecidableEq

def card_compl [Fintype σ] [DecidableEq σ] (c : Circuit σ) : ℕ :=
  Finset.card $ (@Finset.univ (σ → Bool) _).filter (fun a => c.eval a = false)

theorem decideIfZeroAux_wf {σ : Type _} [Fintype σ] [DecidableEq σ]
    {c c' : Circuit σ} (h : ¬c' ≤ c) : card_compl (c' ||| c) < card_compl c := by
  apply Finset.card_lt_card
  simp [Finset.ssubset_iff, Finset.subset_iff]
  simp only [Circuit.le_def, not_forall, Bool.not_eq_true] at h
  rcases h with ⟨x, hx, h⟩
  use x
  simp [hx, h]

def decideIfZerosAux {arity : Type _} [DecidableEq arity]
    (p : FSM arity) (c : Circuit p.σ) : Bool :=
  if c.eval p.initialState
  then false
  else
    have c' := (c.bind (p.nextBitCirc ∘ some)).fst
    if h : c' ≤ c then true
    else
      have _wf : card_compl (c' ||| c) < card_compl c :=
        decideIfZeroAux_wf h
      decideIfZerosAux p (c' ||| c)
  termination_by card_compl c

def decideIfZeros {arity : Type _} [DecidableEq arity]
    (p : FSM arity) : Bool :=
  decideIfZerosAux p (p.nextBitCirc none).fst

theorem decideIfZerosAux_correct {arity : Type _} [DecidableEq arity]
    (p : FSM arity) (c : Circuit p.σ)
    (hc : ∀ s, c.eval s = true →
      ∃ m y, (p.withInitialState s).eval y m = true)
    (hc₂ : ∀ (x : arity → Bool) (s : p.σ → Bool),
      (FSM.next p s x).snd = true → Circuit.eval c s = true) :
    decideIfZerosAux p c = true ↔ ∀ n x, p.eval x n = false := by
  rw [decideIfZerosAux]
  split_ifs with h
  · simp
    exact hc p.initialState h
  · dsimp
    split_ifs with h'
    · simp only [true_iff]
      intro n x
      rw [p.eval_eq_zero_of_set {x | c.eval x = true}]
      · intro y s
        simp [Circuit.le_def, Circuit.eval_fst, Circuit.eval_bind] at h'
        simp [Circuit.eval_fst, FSM.next]
        apply h'
      · assumption
      · exact hc₂
    · let c' := (c.bind (p.nextBitCirc ∘ some)).fst
      have _wf : card_compl (c' ||| c) < card_compl c :=
        decideIfZeroAux_wf h'
      apply decideIfZerosAux_correct p (c' ||| c)
      simp [c', Circuit.eval_fst, Circuit.eval_bind]
      intro s hs
      rcases hs with ⟨x, hx⟩ | h
      · rcases hc _ hx with ⟨m, y, hmy⟩
        use (m+1)
        use fun a i => Nat.casesOn i x (fun i a => y a i) a
        rw [FSM.eval_withInitialState_succ]
        rw [← hmy]
        simp only [FSM.next, Nat.rec_zero, Nat.rec_add_one]
      · exact hc _ h
      · intro x s h
        have := hc₂ _ _ h
        simp only [Circuit.eval_bind, Bool.or_eq_true, Circuit.eval_fst,
          Circuit.eval_or, this, or_true]
termination_by card_compl c

theorem decideIfZeros_correct {arity : Type _} [DecidableEq arity]
    (p : FSM arity) : decideIfZeros p = true ↔ ∀ n x, p.eval x n = false := by
  apply decideIfZerosAux_correct
  · simp only [Circuit.eval_fst, forall_exists_index]
    intro s x h
    use 0
    use (fun a _ => x a)
    simpa [FSM.eval, FSM.withInitialState, FSM.next, FSM.carry]
  · simp only [Circuit.eval_fst]
    intro x s h
    use x
    exact h

end FSM

/--
The fragment of predicate logic that we support in `bv_automata`.
Currently, we support equality, conjunction, disjunction, and negation.
This can be expanded to also support arithmetic constraints such as unsigned-less-than.
-/
inductive Predicate : Nat → Type _ where
| eq (t1 t2 : Term) : Predicate ((max t1.arity t2.arity))
| and  (p : Predicate n) (q : Predicate m) : Predicate (max n m)
| or  (p : Predicate n) (q : Predicate m) : Predicate (max n m)
-- For now, we can't prove `not`, because it needs NFA → DFA conversion
-- the way Sid knows how to build it, or negation normal form,
-- both of which is machinery we lack.
-- | not (p : Predicate n) : Predicate n



/--
denote a reflected `predicate` into a `prop.
-/
def Predicate.denote : Predicate σ → Prop
| eq t1 t2 => t1.eval = t2.eval
| and p q => p.denote ∧  q.denote
| or p q => p.denote ∨  q.denote
-- | not p => ¬ p.denote

/--
Convert a predicate into a proposition
-/
def Predicate.toFSM : Predicate k → FSM (Fin k)
| .eq t1 t2 => (termEvalEqFSM (Term.repeatBit <| Term.xor t1 t2)).toFSM
| .and p q =>
    let p := toFSM p
    let q := toFSM q
    composeBinary' FSM.and p q
| .or p q =>
    let p := toFSM p
    let q := toFSM q
    composeBinary' FSM.or p q

theorem Predicate.toFsm_correct {k : Nat} (p : Predicate k) :
  decideIfZeros p.toFSM = true ↔ p.denote := by sorry
