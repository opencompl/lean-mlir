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
variable {α β α' β' : Type} {γ : β → Type}

/-- `FSM n` represents a function `BitStream → ⋯ → BitStream → BitStream`,
where `n` is the number of `BitStream` arguments,
as a finite state machine.
-/
structure FSM (arity : Type) : Type 1 where
  /--
  The arity of the (finite) type `α` determines how many bits the internal carry state of this
  FSM has -/
  ( α  : Type )
  [ i : Fintype α ]
  [ dec_eq : DecidableEq α ]
  /--
  `initCarry` is the value of the initial internal carry state.
  It maps each `α` to a bit, thus it is morally a bitvector where the width is the arity of `α`
  -/
  ( initCarry : α → Bool )
  /--
  `nextBitCirc` is a family of Boolean circuits,
  which may refer to the current input bits *and* the current state bits
  as free variables in the circuit.

  `nextBitCirc none` computes the current output bit.
  `nextBitCirc (some a)`, computes the *one* bit of the new state that corresponds to `a : α`. -/
  ( nextBitCirc : Option α → Circuit (α ⊕ arity) )

attribute [instance] FSM.i FSM.dec_eq

namespace FSM

variable {arity : Type} (p : FSM arity)

instance : Std.Commutative Nat.add where
  comm := fun a b => by simp only [Nat.add_eq]; omega

instance : Std.Associative Nat.add where
  assoc := fun a b => by simp only [Nat.add_eq]; omega

/-- The size of the state space of the finite state machine. -/
def stateSpaceSize : Nat := @Finset.univ p.α inferInstance |>.card


/--
Return the total size of the FSM as a function of all of its circuits.
Note that this implicitly counts the size of the state space of the FSM,
and consequently, is the natural notion of complexity of the FSM.
-/
def circuitSize : Nat := Id.run do
  let outCircSize := p.nextBitCirc none |>.size
  let states := @Finset.univ p.α inferInstance
  let stateCircSize := Finset.fold Nat.add  0 (fun a => p.nextBitCirc (.some a) |>.size) states
  return outCircSize + stateCircSize

/-- The state of FSM `p` is given by a function from `p.α` to `Bool`.

Note that `p.α` is assumed to be a finite type, so `p.State` is morally
a finite bitvector whose width is given by the arity of `p.α` -/
abbrev State : Type := p.α → Bool

/-- `p.nextBit state in` computes both the next state bits and the output bit,
where `state` are the *current* state bits, and `in` are the current input bits. -/
def nextBit : p.State → (arity → Bool) → p.State × Bool :=
  fun carry inputBits =>
    let input := Sum.elim carry inputBits
    let newState : p.State  := fun (a : p.α) => (p.nextBitCirc (some a)).eval input
    let outBit : Bool       := (p.nextBitCirc none).eval input
    (newState, outBit)

/-- `p.carry in i` computes the internal carry state at step `i`, given input *streams* `in` -/
def carry (x : arity → BitStream) : ℕ → p.State
  | 0 => p.initCarry
  | n+1 => (p.nextBit (carry x n) (fun i => x i n)).1

/-- `eval p` morally gives the function `BitStream → ... → BitStream` represented by FSM `p` -/
def eval (x : arity → BitStream) : BitStream :=
  fun n => (p.nextBit (p.carry x n) (fun i => x i n)).2

/-- `eval'` is an alternative definition of `eval` -/
def eval' (x : arity → BitStream) : BitStream :=
  BitStream.corec (fun ⟨x, (carry : p.State)⟩ =>
    let x_head  := (x · |>.head)
    let next    := p.nextBit carry x_head
    let x_tail  := (x · |>.tail)
    ((x_tail, next.fst), next.snd)
  ) (x, p.initCarry)

/-- `p.changeInitCarry c` yields an FSM with `c` as the initial state -/
def changeInitCarry (p : FSM arity) (c : p.α → Bool) : FSM arity :=
  { p with initCarry := c }

theorem carry_changeInitCarry_succ
    (p : FSM arity) (c : p.α → Bool) (x : arity → BitStream) : ∀ n,
    (p.changeInitCarry c).carry x (n+1) =
      (p.changeInitCarry (p.nextBit c (fun a => x a 0)).1).carry
        (fun a i => x a (i+1)) n
  | 0 => by simp [carry, changeInitCarry, nextBit]
  | n+1 => by
    rw [carry, carry_changeInitCarry_succ p _ _ n]
    simp [nextBit, carry, changeInitCarry]

theorem eval_changeInitCarry_succ
    (p : FSM arity) (c : p.α → Bool) (x : arity → BitStream) (n : ℕ) :
    (p.changeInitCarry c).eval x (n+1) =
      (p.changeInitCarry (p.nextBit c (fun a => x a 0)).1).eval
        (fun a i => x a (i+1)) n := by
  rw [eval, carry_changeInitCarry_succ]
  simp [eval, changeInitCarry, nextBit]

/-- unfolds the definition of `eval` -/
theorem eval_eq_carry (x : arity → BitStream) (n : ℕ) :
    p.eval x n = (p.nextBit (p.carry x n) (fun i => x i n)).2 :=
  rfl


/-- `p.changeVars f` changes the arity of an `FSM`.
The function `f` determines how the new input bits map to the input expected by `p` -/
def changeVars {arity2 : Type} (changeVars : arity → arity2) : FSM arity2 :=
  { p with nextBitCirc := fun a => (p.nextBitCirc a).map (Sum.map id changeVars) }

/--
Given an FSM `p` of arity `n`,
a family of `n` FSMs `qᵢ` of posibly different arities `mᵢ`,
and given yet another arity `m` such that `mᵢ ≤ m` for all `i`,
we can compose `p` with `qᵢ` yielding a single FSM of arity `m`,
such that each FSM `qᵢ` computes the `i`th bit that is fed to the FSM `p`. -/
def compose [Fintype arity] [DecidableEq arity]
    (new_arity : Type)        -- `new_arity` is the resulting arity
    (q_arity : arity → Type)  -- `q_arityₐ` is the arity of FSM `qₐ`
    (vars : ∀ (a : arity), q_arity a → new_arity)
    -- ^^ `vars` is the function that tells us, for each FSM `qₐ`,
    --     which bits of the final `new_arity` corresponds to the `q_arityₐ` bits expected by `qₐ`
    (q : ∀ (a : arity), FSM (q_arity a)) : -- `q` gives the FSMs to be composed with `p`
    FSM new_arity :=
  { α := p.α ⊕ (Σ a, (q a).α),
    i := by letI := p.i; infer_instance,
    dec_eq := by
      letI := p.dec_eq
      letI := fun a => (q a).dec_eq
      infer_instance,
    initCarry := Sum.elim p.initCarry (λ x => (q x.1).initCarry x.2),
    nextBitCirc := λ a =>
      match a with
      | none => (p.nextBitCirc none).bind
        (Sum.elim
          (fun a => Circuit.var true (inl (inl a)))
          (fun a => ((q a).nextBitCirc none).map
            (Sum.elim (fun d => (inl (inr ⟨a, d⟩))) (fun q => inr (vars a q)))))
      | some (inl a) =>
        (p.nextBitCirc (some a)).bind
          (Sum.elim
            (fun a => Circuit.var true (inl (inl a)))
            (fun a => ((q a).nextBitCirc none).map
            (Sum.elim (fun d => (inl (inr ⟨a, d⟩))) (fun q => inr (vars a q)))))
      | some (inr ⟨x, y⟩) =>
          ((q x).nextBitCirc (some y)).map
            (Sum.elim
              (fun a => inl (inr ⟨_, a⟩))
              (fun a => inr (vars x a))) }

lemma carry_compose [Fintype arity] [DecidableEq arity]
    (new_arity : Type)
    (q_arity : arity → Type)
    (vars : ∀ (a : arity), q_arity a → new_arity)
    (q : ∀ (a : arity), FSM (q_arity a))
    (x : new_arity → BitStream) : ∀ (n : ℕ),
    (p.compose new_arity q_arity vars q).carry x n =
      let z := p.carry (λ a => (q a).eval (fun i => x (vars _ i))) n
      Sum.elim z (fun a => (q a.1).carry (fun t => x (vars _ t)) n a.2)
  | 0 => by simp [carry, compose]
  | n+1 => by
      rw [carry, carry_compose _ _ _ _ _ n]
      ext y
      cases y
      · simp [carry, nextBit, compose, Circuit.eval_bind, eval]
        congr
        ext z
        cases z
        · simp
        · simp [Circuit.eval_map, carry]
          congr
          ext s
          cases s
          · simp
          · simp
      · simp [Circuit.eval_map, carry, compose, eval, carry, nextBit]
        congr
        ext z
        cases z
        · simp
        · simp

/-- Evaluating a composed fsm is equivalent to composing the evaluations of the constituent FSMs -/
lemma eval_compose [Fintype arity] [DecidableEq arity]
    (new_arity : Type)
    (q_arity : arity → Type)
    (vars : ∀ (a : arity), q_arity a → new_arity)
    (q : ∀ (a : arity), FSM (q_arity a))
    (x : new_arity → BitStream) :
    (p.compose new_arity q_arity vars q).eval x =
      p.eval (λ a => (q a).eval (fun i => x (vars _ i))) := by
  ext n
  rw [eval, carry_compose, eval]
  simp [compose, nextBit, Circuit.eval_bind]
  congr
  ext a
  cases a
  simp
  simp [Circuit.eval_map, eval, nextBit]
  congr
  ext a
  cases a
  simp
  simp

def and : FSM Bool :=
  { α := Empty,
    initCarry := Empty.elim,
    nextBitCirc := fun a => a.elim
      (Circuit.and
        (Circuit.var true (inr true))
        (Circuit.var true (inr false))) Empty.elim }

@[simp] lemma eval_and (x : Bool → BitStream) : and.eval x = (x true) &&& (x false) := by
  ext n; cases n <;> simp [and, eval, nextBit]

def or : FSM Bool :=
  { α := Empty,
    initCarry := Empty.elim,
    nextBitCirc := fun a => a.elim
      (Circuit.or
        (Circuit.var true (inr true))
        (Circuit.var true (inr false))) Empty.elim }

@[simp] lemma eval_or (x : Bool → BitStream) : or.eval x = (x true) ||| (x false) := by
  ext n; cases n <;> simp [and, eval, nextBit]

def xor : FSM Bool :=
  { α := Empty,
    initCarry := Empty.elim,
    nextBitCirc := fun a => a.elim
      (Circuit.xor
        (Circuit.var true (inr true))
        (Circuit.var true (inr false))) Empty.elim }

/-- Equality, or alternatively, negation of the xor -/
def nxor : FSM Bool :=
  { α := Empty,
    initCarry := Empty.elim,
    nextBitCirc := fun a =>
     match a with
     | none =>
      -- x ⊕ y ⊕ T
      -- 0 ⊕ 0 ⊕ 1 = 1
      -- 0 ⊕ 1 ⊕ 1 = 0 -- value is 0 iff they differ
      -- 1 ⊕ 0 ⊕ 1 = 0 -- value is 1 iff they differ.
      -- 1 ⊕ 1 ⊕ 1 = 1
      (Circuit.xor Circuit.tru
        (Circuit.xor
        (Circuit.var true (inr true))
        (Circuit.var true (inr false))))
     | some empty => empty.elim
  }

/--
Scan a sequence of booleans with the bitwise and operator
Thus:

```lean
(scanAnd)[0] = in[0] &&& True
(scanAnd)[1] = in[1] &&& scanAnd[0]
(scanAnd)[2] = in[2] &&& scanAnd[1]
```
-/
def scanAnd  : FSM Unit :=
  {
   α := Unit,
   initCarry := fun () => true,
   nextBitCirc := fun _a => (Circuit.var true (inl ())) &&& (Circuit.var true (inr ()))
  }

@[simp]
lemma eval_scanAnd_zero (x : Unit → BitStream) : scanAnd.eval x 0 = (x () 0) := by
  simp[eval, nextBit, scanAnd, and, carry]

@[simp]
lemma eval_scanAnd_succ (x : Unit → BitStream) (n : Nat) :
    (scanAnd.eval x (n+1)) = ((scanAnd.eval x n) && (x () (n+1)))  := by
  simp [eval, nextBit, scanAnd, and, carry]

/-- The result of `scanAnd` is true at `n` iff the bitvector has been true upto (and including) `n`. -/
@[simp] lemma eval_scanAnd_true_iff (x : Unit → BitStream) (n : Nat) : scanAnd.eval x n = true ↔ (∀ (i : Nat), (hi : i ≤ n) → x () i = true) := by
  induction n
  case zero => simp [eval, nextBit, scanAnd, and, carry]
  case succ n ih =>
    rw [eval_scanAnd_succ]
    constructor
    · intros h
      intros i hi
      have hScan := Bool.and_elim_left h
      have hxn := Bool.and_elim_right h
      have hi : (i = n+1) ∨ (i < n + 1) := by omega
      rcases hi with rfl | hi
      · exact hxn
      · apply ih.mp
        · exact hScan
        · omega
    · intros h
      have := h (n + 1) (by omega)
      simp [this]
      apply ih.mpr
      intros j hj
      exact h j (by omega)

@[simp] lemma eval_xor (x : Bool → BitStream) : xor.eval x = (x true) ^^^ (x false) := by
  ext n; cases n <;> simp [and, eval, nextBit]

@[simp] lemma eval_nxor (x : Bool → BitStream) : nxor.eval x = ((x true).nxor (x false)) := by
  ext n; cases n
  · simp [nxor, eval, nextBit]
  · simp [nxor, eval, nextBit]

def scanOr  : FSM Unit :=
  {
   α := Unit,
   initCarry := fun () => false,
   nextBitCirc := fun _α => (Circuit.var true (inl ())) ||| (Circuit.var true (inr ()))
  }

@[simp]
lemma eval_scanOr_zero (x : Unit → BitStream) : scanOr.eval x 0 = (x () 0) := by
  simp[eval, nextBit, scanOr, and, carry]

@[simp]
lemma eval_scanOr_succ (x : Unit → BitStream) (n : Nat) :
    (scanOr.eval x (n+1)) = ((scanOr.eval x n) || (x () (n+1)))  := by
  simp [eval, nextBit, scanOr, and, carry]

/-- The result of `scanOr` is false at `n` iff the bitvector has been false upto (and including) time `n`. -/
@[simp] lemma eval_scanor_false_iff (x : Unit → BitStream) (n : Nat) : scanOr.eval x n = false ↔ (∀ (i : Nat), (hi : i ≤ n) → x () i = false) := by
  induction n
  case zero => simp [eval, nextBit, scanOr, and, carry]
  case succ n ih =>
    rw [eval_scanOr_succ]
    constructor
    · intros h
      intros i hi
      have := Bool.or_eq_false_iff.mp h
      have hi : (i = n+1) ∨ (i < n + 1) := by omega
      rcases hi with rfl | hi
      · simp [this]
      · apply ih.mp
        · simp [this]
        · omega
    · intros h
      have := h (n + 1) (by omega)
      simp [this]
      apply ih.mpr
      intros j hj
      exact h j (by omega)

/-- Show that the FSM and the bitstream computations agree for `scanOr`. -/
@[simp] lemma eval_scanOr (x : Unit → BitStream) : scanOr.eval x = (x ()).scanOr := by
  ext n;
  induction n
  case zero => simp
  case succ n ih => simp [ih]

/-- Show that the FSM and the bitstream computations agree for `scanOr`. -/
@[simp] lemma eval_scanAnd (x : Unit → BitStream) : scanAnd.eval x = (x ()).scanAnd := by
  ext n;
  induction n
  case zero => simp
  case succ n ih => simp [ih]

def add : FSM Bool :=
  { α := Unit,
    initCarry := λ _ => false,
    nextBitCirc := fun a =>
      match a with
      | some () =>
             (Circuit.var true (inr true)  &&& Circuit.var true (inr false))
             ||| (Circuit.var true (inr true)  &&& Circuit.var true (inl ()))
             ||| (Circuit.var true (inr false) &&& Circuit.var true (inl ()))
      | none => Circuit.var true (inr true) ^^^
                Circuit.var true (inr false) ^^^
                Circuit.var true (inl ()) }

/-- The internal carry state of the `add` FSM agrees with
the carry bit of addition as implemented on bitstreams -/
theorem carry_add_succ (x : Bool → BitStream) (n : ℕ) :
    add.carry x (n+1) =
      fun _ => (BitStream.addAux (x true) (x false) n).2 := by
  ext a; obtain rfl : a = () := rfl
  induction n with
  | zero      =>
    simp [carry, BitStream.addAux, nextBit, add, BitVec.adcb]
  | succ n ih =>
    unfold carry
    simp [nextBit, ih, Circuit.eval, BitStream.addAux, BitVec.adcb]

@[simp] theorem carry_zero (x : arity → BitStream) : carry p x 0 = p.initCarry := rfl
@[simp] theorem initCarry_add : add.initCarry = (fun _ => false) := rfl

@[simp] lemma eval_add (x : Bool → BitStream) : add.eval x = (x true) + (x false) := by
  ext n
  simp only [eval]
  cases n
  · show Bool.xor _ _ = Bool.xor _ _; simp
  · rw [carry_add_succ]
    conv => {rhs; simp only [(· + ·), BitStream.add, Add.add, BitStream.addAux, BitVec.adcb]}
    simp [nextBit, eval, add]
/-!
We don't really need subtraction or negation FSMs,
given that we can reduce both those operations to just addition and bitwise complement -/

def sub : FSM Bool :=
  { α := Unit,
    initCarry := fun _ => false,
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
    simp [carry, nextBit, funext_iff, BitStream.subAux, sub]
  | n+1 => by
    rw [carry, carry_sub _ n]
    simp [nextBit, eval, sub, BitStream.sub, BitStream.subAux, Bool.xor_not_left']

@[simp]
theorem eval_sub (x : Bool → BitStream) : sub.eval x = (x true) - (x false) := by
  simp only [(· - ·), Sub.sub]
  ext n
  cases n
  · simp [eval, sub, nextBit, BitStream.sub, BitStream.subAux, carry]
  · rw [eval, carry_sub]
    simp [nextBit, eval, sub, BitStream.sub, BitStream.subAux]

/-!
We define a borrow automata, whose output stream is the internal state of the subtraction automata,
which is the bits to be borrowed.

Compare against subAux.2
-/

def borrow : FSM Bool :=
  { α := Unit,
    -- Internal state is the current borrow.
    initCarry := fun _ => false,
    -- | TODO: check that this is in fact the borrow bit of the subtraction automata.
    -- Check that we do correctly compute the borrow bit here.
    nextBitCirc := fun _i =>
      let borrow := Circuit.var true (inl ())
      let a := Circuit.var true (inr true)
      let nota := Circuit.var false (inr true)
      let b := Circuit.var true (inr false)
      -- let borrow := (subAux x y n).2
      -- computing x - y:
      -- x y b | out-borrow
      -- 0 0 0 | 0
      -- 0 0 1 | 1
      -- 0 1 0 | 1
      -- 0 1 1 | 1
      -- 1 0 0 | 0
      -- 1 0 1 | 0
      -- 1 1 0 | 0
      -- 1 1 1 | 1
      -- (!a && b || ((!(xor a b)) && borrow))
      (nota &&& b/- !a && b-/) |||
      ((Circuit.not <| a ^^^ b /- !(xor a b) -/) &&& borrow)

  }

def neg : FSM Unit :=
  { α := Unit,
    i := by infer_instance,
    initCarry := λ _ => true,
    nextBitCirc := fun a =>
      match a with
      | some () => Circuit.var false (inr ()) &&& Circuit.var true (inl ())
      | none => Circuit.var false (inr ()) ^^^ Circuit.var true (inl ())  }

theorem carry_neg (x : Unit → BitStream) : ∀ (n : ℕ), neg.carry x (n+1) =
    fun _ => (BitStream.negAux (x ()) n).2
  | 0 => by
    simp [carry, nextBit, funext_iff, BitStream.negAux, neg]
  | n+1 => by
    rw [carry, carry_neg _ n]
    simp [nextBit, eval, neg, BitStream.neg, BitStream.negAux, Bool.xor_not_left']

@[simp] lemma eval_neg (x : Unit → BitStream) : neg.eval x = -(x ()) := by
  show _ = BitStream.neg _
  ext n
  cases n
  · simp [eval, neg, nextBit, BitStream.neg, BitStream.negAux, carry]
  · rw [eval, carry_neg]
    simp [nextBit, eval, neg, BitStream.neg, BitStream.negAux]

def not : FSM Unit :=
  { α := Empty,
    initCarry := Empty.elim,
    nextBitCirc := fun _ => Circuit.var false (inr ()) }

@[simp] lemma eval_not (x : Unit → BitStream) : not.eval x = ~~~(x ()) := by
  ext; simp [eval, not, nextBit]

def zero : FSM (Fin 0) :=
  { α := Empty,
    initCarry := Empty.elim,
    nextBitCirc := fun _ => Circuit.fals }

@[simp] lemma eval_zero (x : Fin 0 → BitStream) : zero.eval x = BitStream.zero := by
  ext; simp [zero, eval, nextBit]

def one : FSM (Fin 0) :=
  { α := Unit,
    i := by infer_instance,
    initCarry := λ _ => true,
    nextBitCirc := fun a =>
      match a with
      | some () => Circuit.fals
      | none => Circuit.var true (inl ()) }

@[simp] theorem carry_one (x : Fin 0 → BitStream) (n : ℕ) :
    one.carry x (n+1) = fun _ => false := by
  simp [carry, nextBit, one]

@[simp] lemma eval_one (x : Fin 0 → BitStream) : one.eval x = BitStream.one := by
  ext n
  cases n
  · rfl
  · simp [eval, carry_one, nextBit]

def negOne : FSM (Fin 0) :=
  { α := Empty,
    i := by infer_instance,
    initCarry := Empty.elim,
    nextBitCirc := fun _ => Circuit.tru }

@[simp] lemma eval_negOne (x : Fin 0 → BitStream) : negOne.eval x = BitStream.negOne := by
  ext; simp [negOne, eval, nextBit]

/--
An FSM whose first output is `b`, and later outputs are whatever the input is.
-/
def ls (b : Bool) : FSM Unit :=
  { α := Unit,
    initCarry := fun _ => b,
    nextBitCirc := fun x =>
      match x with
      | none => Circuit.var true (inl ())
      | some () => Circuit.var true (inr ()) }

theorem carry_ls (b : Bool) (x : Unit → BitStream) : ∀ (n : ℕ),
    (ls b).carry x (n+1) = fun _ => x () n
  | 0 => by
    simp [carry, nextBit, funext_iff, ls]
  | n+1 => by
    rw [carry, carry_ls _ _ n]
    simp [nextBit, eval, ls]

@[simp] lemma eval_ls (b : Bool) (x : Unit → BitStream) :
    (ls b).eval x = (x ()).concat b := by
  ext n
  cases n
  · rfl
  · simp [carry_ls, eval, nextBit, BitStream.concat]

def var (n : ℕ) : FSM (Fin (n+1)) :=
  { α := Empty,
    i := by infer_instance,
    initCarry := Empty.elim,
    nextBitCirc := λ _ => Circuit.var true (inr (Fin.last _)) }

@[simp] lemma eval_var (n : ℕ) (x : Fin (n+1) → BitStream) : (var n).eval x = x (Fin.last n) := by
  ext m; cases m <;> simp [var, eval, carry, nextBit]

def incr : FSM Unit :=
  { α := Unit,
    initCarry := fun _ => true,
    nextBitCirc := fun x =>
      match x with
      | none => (Circuit.var true (inr ())) ^^^ (Circuit.var true (inl ()))
      | some _ => (Circuit.var true (inr ())) &&& (Circuit.var true (inl ())) }

theorem carry_incr (x : Unit → BitStream) : ∀ (n : ℕ),
    incr.carry x (n+1) = fun _ => (BitStream.incrAux (x ()) n).2
  | 0 => by
    simp [carry, nextBit, funext_iff, BitStream.incrAux, incr]
  | n+1 => by
    rw [carry, carry_incr _ n]
    simp [nextBit, eval, incr, incr, BitStream.incrAux]

@[simp] lemma eval_incr (x : Unit → BitStream) : incr.eval x = (x ()).incr := by
  ext n
  cases n
  · simp [eval, incr, nextBit, carry, BitStream.incr, BitStream.incrAux]
  · rw [eval, carry_incr]; rfl

def decr : FSM Unit :=
  { α := Unit,
    i := by infer_instance,
    initCarry := λ _ => true,
    nextBitCirc := fun x =>
      match x with
      | none => (Circuit.var true (inr ())) ^^^ (Circuit.var true (inl ()))
      | some _ => (Circuit.var false (inr ())) &&& (Circuit.var true (inl ())) }

theorem carry_decr (x : Unit → BitStream) : ∀ (n : ℕ), decr.carry x (n+1) =
    fun _ => (BitStream.decrAux (x ()) n).2
  | 0 => by
    simp [carry, nextBit, funext_iff, BitStream.decrAux, decr]
  | n+1 => by
    rw [carry, carry_decr _ n]
    simp [nextBit, eval, decr, BitStream.decrAux]

@[simp] lemma eval_decr (x : Unit → BitStream) : decr.eval x = BitStream.decr (x ()) := by
  ext n
  cases n
  · simp [eval, decr, nextBit, carry, BitStream.decr, BitStream.decrAux]
  · rw [eval, carry_decr]; rfl

theorem evalAux_eq_zero_of_set {arity : Type _} (p : FSM arity)
    (R : Set (p.α → Bool)) (hR : ∀ x s, (p.nextBit s x).1 ∈ R → s ∈ R)
    (hi : p.initCarry ∉ R) (hr1 : ∀ x s, (p.nextBit s x).2 = true → s ∈ R)
    (x : arity → BitStream) (n : ℕ) : p.eval x n = false ∧ p.carry x n ∉ R := by
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
    (R : Set (p.α → Bool)) (hR : ∀ x s, (p.nextBit s x).1 ∈ R → s ∈ R)
    (hi : p.initCarry ∉ R) (hr1 : ∀ x s, (p.nextBit s x).2 = true → s ∈ R) :
    p.eval = fun _ _ => false := by
  ext x n
  rw [eval]
  exact (evalAux_eq_zero_of_set p R hR hi hr1 x n).1

def repeatBit : FSM Unit where
  α := Unit
  initCarry := fun () => false
  nextBitCirc := fun _ =>
    .or (.var true <| .inl ()) (.var true <| .inr ())

-- @[simp] theorem eval_repeatBit :
--     repeatBit.eval x = BitStream.repeatBit (x ()) := by
--   unfold BitStream.repeatBit
--   rw [eval_eq_eval', eval']
--   apply BitStream.corec_eq_corec
--     (R := fun a b => a.1 () = b.2 ∧ (a.2 ()) = b.1)
--   · simp [repeatBit]
--   · intro ⟨y, a⟩ ⟨b, x⟩ h
--     simp at h
--     simp [h, nextBit, BitStream.head]

end FSM

/-- An `FSMTermSolution `t` is an FSM with a witness that the FSM evaluates to the same value as `t` does -/
structure FSMTermSolution (t : Term) extends FSM (Fin t.arity) where
  ( good : t.evalFin = toFSM.eval )


/-- Compose two automata together, where `q` is an FSM -/
def composeUnaryAux
    (p : FSM Unit)
    (q : FSM arity) :
    FSM arity :=
  p.compose
    arity
    _
    (λ _ => id)
    (λ _ => q)

/-- Compose two automata together, where `q` is an FSMTermSolution -/
def composeUnary
    (p : FSM Unit)
    {t : Term}
    (q : FSMTermSolution t) :
    FSM (Fin t.arity) := composeUnaryAux p q.toFSM

def composeBinaryAux
    (p : FSM Bool)
    (q₁ : FSM (Fin a₁))
    (q₂ : FSM (Fin a₂)) :
    FSM (Fin (max a₁ a₂)) :=
  p.compose (Fin (max a₁ a₂))
    (λ b => Fin (cond b a₁ a₂))
    (λ b i => Fin.castLE (by cases b <;> simp) i)
    (λ b => match b with
      | true => q₁
      | false => q₂)

/-- Compose two binary opeators -/
def composeBinary
    (p : FSM Bool)
    {t₁ t₂ : Term}
    (q₁ : FSMTermSolution t₁)
    (q₂ : FSMTermSolution t₂) :
    FSM (Fin (max t₁.arity t₂.arity)) := composeBinaryAux p q₁.toFSM q₂.toFSM


@[simp] lemma composeUnaryAux_eval
    (p : FSM Unit)
    (q : FSM arity)
    (x : arity → BitStream) :
    (composeUnaryAux p q).eval x = p.eval (λ _ => q.eval x) := by
  simp [composeUnaryAux, FSM.eval_compose]

@[simp] lemma composeUnary_eval
    (p : FSM Unit)
    {t : Term}
    (q : FSMTermSolution t)
    (x : Fin t.arity → BitStream) :
    (composeUnary p q).eval x = p.eval (λ _ => t.evalFin x) := by
  simp [composeUnary, FSM.eval_compose, q.good]

@[simp] lemma composeBinaryAux_eval
    (p : FSM Bool)
    (q₁ : FSM (Fin a₁))
    (q₂ : FSM (Fin a₂))
    (x : Fin (max a₁ a₂) → BitStream) :
    (composeBinaryAux p q₁ q₂).eval x = p.eval
      (λ b => cond b (q₁.eval (fun i => x (Fin.castLE (by simp) i)))
                  (q₂.eval (fun i => x (Fin.castLE (by simp) i)))) := by
  rw [composeBinaryAux, FSM.eval_compose]
  ext b
  cases b <;> dsimp <;> congr <;> funext b <;> cases b <;> simp

@[simp] lemma composeBinary_eval
    (p : FSM Bool)
    {t₁ t₂ : Term}
    (q₁ : FSMTermSolution t₁)
    (q₂ : FSMTermSolution t₂)
    (x : Fin (max t₁.arity t₂.arity) → BitStream) :
    (composeBinary p q₁ q₂).eval x = p.eval
      (λ b => cond b (t₁.evalFin (fun i => x (Fin.castLE (by simp) i)))
                  (t₂.evalFin (fun i => x (Fin.castLE (by simp) i)))) := by
  rw [composeBinary, composeBinaryAux, FSM.eval_compose, q₁.good, q₂.good]
  ext b
  cases b <;> dsimp <;> congr <;> funext b <;> cases b <;> simp

instance {α β : Type} [Fintype α] [Fintype β] (b : Bool) :
    Fintype (cond b α β) := by
  cases b <;> simp <;> infer_instance


namespace FSM

/--
A finite state machine whose outputs are the bits of the natural number `n`,
in least to most significant bit order.

See that this uses only as much as as *log₂ n*, which is the correct
number of bits necessary to count up to `n`.
-/
def ofNat (n : Nat)  : FSM (Fin 0) :=
  match hn : n with
  | 0 => FSM.zero
  | n' + 1 =>
    let bit := n.testBit 0
    let m := n / 2
    have h : m < n := by
      simp [m];
      apply Nat.div_lt_iff_lt_mul _ |>.mpr
      · omega
      · decide
    composeUnaryAux (FSM.ls bit) (ofNat m)

@[simp]
theorem const_zero : ofNat 0 = FSM.zero :=
  by simp [ofNat]

/-- Evaluating 'const n' gives us the bits of the value of 'const n'.-/
@[simp]
theorem eval_const (n : Nat) (i : Nat) {env : Fin 0 → BitStream} :
    (ofNat n).eval env i = n.testBit i := by
  induction n using Nat.div2Induction generalizing i
  case ind n hn =>
    rcases n with rfl | hn
    case zero => simp
    case succ n =>
      simp [ofNat]
      have : n + 1 > 0 := by omega
      specialize (hn this)
      cases i
      · case zero => simp
      · case succ i' =>
        simp [hn, Nat.testBit_succ]

/--
Build an FSM whose state is `true` at step `n`,
and `false` everywhere else.
-/
def trueOnlyAt (n : Nat) : FSM (Fin 0) := ofNat (1 <<< n)

/- `Nat.testBit 1 i = false` if and only if `i` is nonzero. -/
@[simp]
private theorem _root_.Nat.testBit_one_eq_false_iff (i : Nat) :
    Nat.testBit 1 i = false ↔ i ≠ 0 := by
  constructor
  · simp only [ne_eq]
    by_cases hi : i = 0 <;> simp [hi]
  · intros h
    rw [Nat.testBit, Nat.shiftRight_eq_div_pow]
    have : 2^i ≥ 2 := by
      exact Nat.le_self_pow h 2
    simp only [Nat.one_and_eq_mod_two, Nat.mod_two_bne_zero, beq_eq_false_iff_ne,
      ne_eq, Nat.mod_two_not_eq_one]
    rw [Nat.mod_eq_of_lt]
    · apply Nat.div_eq_zero_iff |>.mpr; omega
    · apply Nat.div_lt_of_lt_mul
      omega

/--
`falseOnlyAt n` builds an FSM that is `false` at state `n` and
`true` everywhere else. This is useful to build a predicate that
checks if we are in the `n`th state.
-/
@[simp]
theorem eval_trueOnlyAt (n : Nat) (i : Nat) {env : Fin 0 → BitStream} :
    (trueOnlyAt n).eval env i = decide (i = n) := by
  simp [trueOnlyAt]
  by_cases hn : i = n
  · simp [hn]
  · simp [hn]
    omega

/--
Build an FSM whose state is `false` at step `n`,
and `true` everywhere else.
-/
def falseOnlyAt (n : Nat) : FSM (Fin 0) :=
  composeUnaryAux FSM.not (trueOnlyAt n)

/--
`falseOnlyAt n` builds an FSM that is `false` at state `n` and
`true` everywhere else. This is useful to build a predicate that
checks if we are in the `n`th state.
-/
@[simp] theorem eval_falseOnlyAt (n : Nat) (i : Nat) {env : Fin 0 → BitStream} :
    (falseOnlyAt n).eval env i = !decide (i = n) := by simp [falseOnlyAt]

/--
Build an FSM whose value is 'true' for states [0, 1, ... n),
and 'false' after.
-/
def trueUptoExcluding (n : Nat) : FSM (Fin 0) :=
  ofNat (BitVec.allOnes n).toNat
@[simp] theorem eval_trueUptoExcluding (n : Nat) (i : Nat) {env : Fin 0 → BitStream} :
    (trueUptoExcluding n).eval env i = decide (i < n) := by simp [trueUptoExcluding]

def falseAfterIncluding (n : Nat) : FSM (Fin 0) := trueUptoExcluding n
private theorem falseAfterIncluding_false_iff (n i : Nat) {env : Fin 0 → BitStream} :
  (falseAfterIncluding n).eval env i = false ↔ i ≥ n := by simp [falseAfterIncluding];

/--
Build an FSM whose value is 'true' for states [0, 1, ... n] (including the endpoint),
and 'false' after.
-/
def trueUptoIncluding (n : Nat) : FSM (Fin 0) := ofNat (BitVec.allOnes (n+1)).toNat
@[simp] theorem eval_trueUptoIncluding (n : Nat) (i : Nat) {env : Fin 0 → BitStream} :
    (trueUptoIncluding n).eval env i = decide (i ≤ n) := by
  simp [trueUptoIncluding]; omega
def falseAfterExcluding (n : Nat) : FSM (Fin 0) := trueUptoIncluding n
private theorem falseAfterExcluding_false_iff (n i : Nat) {env : Fin 0 → BitStream} :
  (falseAfterExcluding n).eval env i = false ↔ i > n := by simp [falseAfterExcluding]

/--
Build an FSM whose value is and 'false' for the first [0, 1, ... n), and 'true' for [n, n + 1, ...).
-/
def falseUptoExcluding (n : Nat) : FSM (Fin 0) := composeUnaryAux FSM.not (FSM.trueUptoExcluding n)
@[simp] theorem eval_falseUptoExcluding (n : Nat) (i : Nat) {env : Fin 0 → BitStream} :
    (falseUptoExcluding n).eval env i = decide (n ≤ i) := by
  simp [falseUptoExcluding];
  by_cases hi : i < n <;> (simp [hi]; try omega)
/--
Psychological theorem to see that 'i < n'
if and only if 'falseUptoExcluding' evaluates to 'false
-/
private theorem falseUptoExcluding_eq_false_iff (n : Nat) (i : Nat) {env : Fin 0 → BitStream} :
    ((falseUptoExcluding n).eval env i = false) ↔ i < n := by simp;

/--
Build an FSM whose value is false' for the first [0, 1, ... n],
and 'true' for (n, n + 1, ...) (excluding the startpoint)
-/
def falseUptoIncluding (n : Nat) : FSM (Fin 0) :=
  composeUnaryAux FSM.not (FSM.trueUptoIncluding n)
@[simp] theorem eval_falseUptoIncluding (n : Nat) (i : Nat) {env : Fin 0 → BitStream} :
    (falseUptoIncluding n).eval env i = decide (n < i) := by
  simp [falseUptoIncluding];
  by_cases hi : n < i <;> (simp [hi]; try omega)
/--
Psychological theorem to see that 'i ≤ n'
if and only if 'falseUptoExcluding' evaluates to 'false
-/
private theorem falseUptoIncluding_eq_false_iff (n : Nat) (i : Nat) {env : Fin 0 → BitStream} :
    ((falseUptoIncluding n).eval env i = false) ↔ i ≤ n := by simp

end FSM

open Term

/--

Note that **this is the value that is run by decide**.
-/
def termEvalEqFSM : ∀ (t : Term), FSMTermSolution t
  | ofNat n =>
    { toFSM := FSM.ofNat n,
      good := by ext; simp [Term.evalFin] }
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
  -- | repeatBit t =>
  --   let p := termEvalEqFSM t
  --   { toFSM := by dsimp [arity]; exact composeUnary FSM.repeatBit p,
  --     good := by ext; simp }

/-!
FSM that implement bitwise-and. Since we use `0` as the good state,
we keep the invariant that if both inputs are good and our state is `0`, then we produce a `0`.
If not, we produce an infinite sequence of `1`.
-/
def and : FSM Bool :=
  { α := Unit,
    initCarry := fun _ => false,
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
  { α := Unit,
    initCarry := fun _ => false,
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

/-- An `FSMPredicateSolution `t` is an FSM with a witness that the FSM evaluates to the same value as `t` does -/
structure FSMPredicateSolution (p : Predicate) extends FSM (Fin p.arity) where
  ( good : p.evalFin = toFSM.eval )



/-- Evaluating the eq predicate equals the FSM value.

Note that **this is the value that is run by decide**.

-/
def predicateEvalEqFSM : ∀ (p : Predicate), FSMPredicateSolution p
  | .widthEq n =>
    {
      toFSM := FSM.falseOnlyAt n
      good := by sorry
    }
  | .widthNeq n =>
     {
      toFSM := FSM.trueOnlyAt n
      good := by sorry
     }
  | .widthGe n =>
     {
      toFSM := FSM.falseAfterIncluding n
      good := by sorry
     }
  | .widthGt n =>
     {
      toFSM := FSM.falseAfterExcluding n
      good := by sorry
     }
  | .widthLt n =>
     {
      toFSM := FSM.falseUptoExcluding n
      good := by sorry
     }
  | .widthLe n =>
     {
      toFSM := FSM.falseUptoIncluding n
      good := by sorry
     }
  | .eq t₁ t₂ =>
    let t₁' := termEvalEqFSM t₁
    let t₂' := termEvalEqFSM t₂
    {
     toFSM := (composeBinary FSM.xor t₁' t₂')
     good := by ext; simp;
    }
  | .neq t₁ t₂ =>
    let t₁' := termEvalEqFSM t₁
    let t₂' := termEvalEqFSM t₂
    {
     -- If it ever becomes `0`, it should stay `0` forever, because once
     -- two bitstreams become disequal, they stay disequal!
     toFSM := composeUnaryAux FSM.scanAnd <| (composeBinary FSM.nxor t₁' t₂')
     good := by sorry -- ext; simp;
    }
   | .land p q =>
     let x₁ := predicateEvalEqFSM p
     let x₂ :=  predicateEvalEqFSM q
     {
       -- If this ever becomes `1`, it should stay `1`,
       -- since once it's falsified, it should stay falsified!
       toFSM := composeBinaryAux FSM.or x₁.toFSM x₂.toFSM
       good := by sorry -- ext; simp [x₁.good, x₂.good]
     }
   | .lor p q =>
     let x₁ := predicateEvalEqFSM p
     let x₂ :=  predicateEvalEqFSM q
     {
       -- If it ever becomes `1`, it should stay `1`,
       -- since one it's falsified, it should stay falsified!
       toFSM := composeBinaryAux FSM.and x₁.toFSM x₂.toFSM
       good := by sorry -- ext; simp [x₁.good, x₂.good]
     }
   | .slt t₁ t₂ =>
     let q₁ := termEvalEqFSM t₁
     let q₂ := termEvalEqFSM t₂
     { toFSM := composeUnaryAux FSM.not <| composeBinary FSM.sub q₁ q₂,
       good := by sorry --   ext; simp }
     }
   | .sle t₁ t₂ =>
      let t₁' := termEvalEqFSM t₁
      let t₂' := termEvalEqFSM t₂
      let slt := (composeUnaryAux FSM.not <| composeBinaryAux FSM.sub t₁'.toFSM t₂'.toFSM)
      let eq := (composeBinaryAux FSM.xor t₁'.toFSM t₂'.toFSM)
      have hsz : max (max t₁.arity t₂.arity) (max t₁.arity t₂.arity) = (max t₁.arity t₂.arity) :=
        Nat.max_self ..
      have hsz : max (max t₁.arity t₂.arity) (max t₁.arity t₂.arity) = Predicate.arity (.sle t₁ t₂) := by
        simp [hsz]
      -- We want an OR of the two cases, which we take by computing an AND of the predicates.
      let out := composeBinaryAux FSM.and slt eq
      {
       toFSM := hsz ▸ out
       good := by sorry -- TODO: show that it's good 'ext; simp';
      }
   | .ult t₁ t₂ =>
      let t₁' := termEvalEqFSM t₁
      let t₂' := termEvalEqFSM t₂
      {
       -- a <u b if when we compute (a - b), we must borrow a value.
       toFSM := (composeUnaryAux FSM.not $ composeBinary FSM.borrow t₁' t₂')
       good := by sorry -- TODO: show that it's good 'ext; simp';
      }
   | .ule t₁ t₂ =>
      let t₁' := termEvalEqFSM t₁
      let t₂' := termEvalEqFSM t₂
      let ult := (composeUnaryAux FSM.not $ composeBinaryAux FSM.borrow t₁'.toFSM t₂'.toFSM)
      let eq := (composeBinaryAux FSM.xor t₁'.toFSM t₂'.toFSM)
      have hsz : max (max t₁.arity t₂.arity) (max t₁.arity t₂.arity) = (max t₁.arity t₂.arity) :=
        Nat.max_self ..
      have hsz : max (max t₁.arity t₂.arity) (max t₁.arity t₂.arity) = Predicate.arity (.ule t₁ t₂) := by
        simp [hsz]
      -- IF either a < b, or a = b, then we know that a ≤ b.
      let out := composeBinaryAux FSM.and ult eq
      {
       toFSM := hsz ▸ out
       good := by sorry -- TODO: show that it's good 'ext; simp';
      }

def card_compl [Fintype α] [DecidableEq α] (c : Circuit α) : ℕ :=
  Finset.card $ (@Finset.univ (α → Bool) _).filter (fun a => c.eval a = false)

theorem decideIfZeroAux_wf {α : Type _} [Fintype α] [DecidableEq α]
    {c c' : Circuit α} (h : ¬c' ≤ c) : card_compl (c' ||| c) < card_compl c := by
  apply Finset.card_lt_card
  simp [Finset.ssubset_iff, Finset.subset_iff]
  simp only [Circuit.le_def, not_forall, Bool.not_eq_true] at h
  rcases h with ⟨x, hx, h⟩
  use x
  simp [hx, h]

def decideIfZerosAux {arity : Type _} [DecidableEq arity]
    (p : FSM arity) (c : Circuit p.α) : Bool :=
  if c.eval p.initCarry
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
    (p : FSM arity) (c : Circuit p.α)
    (hc : ∀ s, c.eval s = true →
      ∃ m y, (p.changeInitCarry s).eval y m = true)
    (hc₂ : ∀ (x : arity → Bool) (s : p.α → Bool),
      (FSM.nextBit p s x).snd = true → Circuit.eval c s = true) :
    decideIfZerosAux p c = true ↔ ∀ n x, p.eval x n = false := by
  rw [decideIfZerosAux]
  split_ifs with h
  · simp
    exact hc p.initCarry h
  · dsimp
    split_ifs with h'
    · simp only [true_iff]
      intro n x
      rw [p.eval_eq_zero_of_set {x | c.eval x = true}]
      · intro y s
        simp [Circuit.le_def, Circuit.eval_fst, Circuit.eval_bind] at h'
        simp [Circuit.eval_fst, FSM.nextBit]
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
        rw [FSM.eval_changeInitCarry_succ]
        rw [← hmy]
        simp only [FSM.nextBit, Nat.rec_zero, Nat.rec_add_one]
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
    simpa [FSM.eval, FSM.changeInitCarry, FSM.nextBit, FSM.carry]
  · simp only [Circuit.eval_fst]
    intro x s h
    use x
    exact h

/-- Iterate the next bit circuit 'n' times, while universally quantifying over all inputs
that are possible at each step. -/
def FSM.nextBitCircIterate {arity : Type _ } [DecidableEq arity]
    (fsm : FSM arity) (n : Nat) : Circuit fsm.α :=
  match n with
  | 0 => fsm.nextBitCirc none |>.fst
  | n' + 1 =>
     -- | the .fst performs quantifier elimination, by running over all possible values of inputs.
     let c := fsm.nextBitCircIterate n'
     (c.bind (fsm.nextBitCirc ∘ some)).fst

/-- Decide if the FSM produces zeroes for all inputs at a given index of the bitstream -/
def decideIfZerosAtIx {arity : Type _} [DecidableEq arity]
      (fsm : FSM arity) (w : Nat) : Bool :=
    let c := fsm.nextBitCircIterate w
    c.eval fsm.initCarry

/--
The correctness statement of 'denoteIfZeroesAtIx'.
This tells us that 'denoteIfZeroesAtIx' is correct iff the FSM 'p' when evaluated returns false
for all inputs at the index 'w' of the bitstream
-/
theorem decideIfZeroesAtIx_correct {arity : Type _} [DecidableEq arity]
    (p : FSM arity) (w : Nat) : decideIfZerosAtIx p w = true ↔ ∀ x, p.eval x w = false := by
  sorry

end FSM
