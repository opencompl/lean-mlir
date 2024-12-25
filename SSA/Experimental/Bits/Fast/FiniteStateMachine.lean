import Mathlib.Data.Fintype.Card
import Mathlib.Data.FinEnum
import Mathlib.Data.Fintype.Sum
import Mathlib.Data.Fintype.Sigma
import Mathlib.Data.Fintype.Pi
import Mathlib.Data.Fintype.BigOperators
import Mathlib.Tactic.Zify
import Mathlib.Tactic.Ring
import SSA.Experimental.Bits.AutoStructs.Defs
import SSA.Experimental.Bits.AutoStructs.FinEnum
import SSA.Experimental.Bits.Fast.Circuit
import SSA.Experimental.Bits.Fast.BitStream
namespace AutoStructs

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
  [ i : FinEnum α ]
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

variable {ar : Type} (p : FSM ar)

/-- The state of FSM `p` is given by a function from `p.α` to `Bool`.

Note that `p.α` is assumed to be a finite type, so `p.State` is morally
a finite bitvector whose width is given by the arity of `p.α` -/
abbrev State : Type := p.α → Bool

/-- `p.nextBit state in` computes both the next state bits and the output bit,
where `state` are the *current* state bits, and `in` are the current input bits. -/
def nextBit : p.State → (ar → Bool) → p.State × Bool :=
  fun carry inputBits =>
    let input := Sum.elim carry inputBits
    let newState : p.State  := fun (a : p.α) => (p.nextBitCirc (some a)).eval input
    let outBit : Bool       := (p.nextBitCirc none).eval input
    (newState, outBit)

/-- `p.carry in i` computes the internal carry state at step `i`, given input *streams* `in` -/
def carry (x : ar → BitStream) : ℕ → p.State
  | 0 => p.initCarry
  | n+1 => (p.nextBit (carry x n) (fun i => x i n)).1

lemma carry_eq_up_to :
    (∀ ar k, k < n → x ar k = y ar k) →
    p.carry x n = p.carry y n := by
  induction n generalizing x y
  case zero => intros; rfl
  case succ n ih =>
    rintro heq
    simp [carry, @ih x y (by tauto)]
    congr; simp_all only [lt_add_iff_pos_right, zero_lt_one]

def carryBV (x : ar → BitVec w) : p.State :=
  p.carry (fun ar => BitStream.ofBitVec (x ar)) w

/-- `eval p` morally gives the function `BitStream → ... → BitStream` represented by FSM `p` -/
def eval (x : ar → BitStream) : BitStream :=
  fun n => (p.nextBit (p.carry x n) (fun i => x i n)).2

lemma eval_eq_up_to :
    (∀ ar k, k ≤ n → x ar k = y ar k) →
    p.eval x n = p.eval y n := by
  rintro h
  simp [eval]
  congr
  apply carry_eq_up_to p (by rintro ar k hlt; apply h; omega)
  ext; apply h; rfl

def evalBV {w} (x : ar → BitVec w) : BitVec w :=
  BitVec.ofFn fun k => p.eval (fun ar => BitStream.ofBitVec (x ar)) k

/-- `eval'` is an alternative definition of `eval` -/
def eval' (x : ar → BitStream) : BitStream :=
  BitStream.corec (fun ⟨x, (carry : p.State)⟩ =>
    let x_head  := (x · |>.head)
    let next    := p.nextBit carry x_head
    let x_tail  := (x · |>.tail)
    ((x_tail, next.fst), next.snd)
  ) (x, p.initCarry)

/-- `p.changeInitCarry c` yields an FSM with `c` as the initial state -/
def changeInitCarry (p : FSM ar) (c : p.α → Bool) : FSM ar :=
  { p with initCarry := c }

theorem carry_changeInitCarry_succ
    (p : FSM ar) (c : p.α → Bool) (x : ar → BitStream) : ∀ n,
    (p.changeInitCarry c).carry x (n+1) =
      (p.changeInitCarry (p.nextBit c (fun a => x a 0)).1).carry
        (fun a i => x a (i+1)) n
  | 0 => by simp [carry, changeInitCarry, nextBit]
  | n+1 => by
    rw [carry, carry_changeInitCarry_succ p _ _ n]
    simp [nextBit, carry, changeInitCarry]

theorem eval_changeInitCarry_succ
    (p : FSM ar) (c : p.α → Bool) (x : ar → BitStream) (n : ℕ) :
    (p.changeInitCarry c).eval x (n+1) =
      (p.changeInitCarry (p.nextBit c (fun a => x a 0)).1).eval
        (fun a i => x a (i+1)) n := by
  rw [eval, carry_changeInitCarry_succ]
  simp [eval, changeInitCarry, nextBit]

/-- unfolds the definition of `eval` -/
theorem eval_eq_carry (x : ar → BitStream) (n : ℕ) :
    p.eval x n = (p.nextBit (p.carry x n) (fun i => x i n)).2 :=
  rfl

/-- `p.changeVars f` changes the arity of an `FSM`.
The function `f` determines how the new input bits map to the input expected by `p` -/
def changeVars {arity2 : Type} (changeVars : ar → arity2) : FSM arity2 :=
  { p with nextBitCirc := fun a => (p.nextBitCirc a).map (Sum.map id changeVars) }

/--
Given an FSM `p` of arity `n`,
a family of `n` FSMs `qᵢ` of posibly different arities `mᵢ`,
and given yet another arity `m` such that `mᵢ ≤ m` for all `i`,
we can compose `p` with `qᵢ` yielding a single FSM of arity `m`,
such that each FSM `qᵢ` computes the `i`th bit that is fed to the FSM `p`. -/
def compose [FinEnum ar] [DecidableEq ar]
    (new_arity : Type)        -- `new_arity` is the resulting arity
    (q_arity : ar → Type)  -- `q_arityₐ` is the arity of FSM `qₐ`
    (vars : ∀ (a : ar), q_arity a → new_arity)
    -- ^^ `vars` is the function that tells us, for each FSM `qₐ`,
    --     which bits of the final `new_arity` corresponds to the `q_arityₐ` bits expected by `qₐ`
    (q : ∀ (a : ar), FSM (q_arity a)) : -- `q` gives the FSMs to be composed with `p`
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

lemma carry_compose [FinEnum ar] [DecidableEq ar]
    (new_arity : Type)
    (q_arity : ar → Type)
    (vars : ∀ (a : ar), q_arity a → new_arity)
    (q : ∀ (a : ar), FSM (q_arity a))
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
lemma eval_compose [FinEnum ar] [DecidableEq ar]
    (new_arity : Type)
    (q_arity : ar → Type)
    (vars : ∀ (a : ar), q_arity a → new_arity)
    (q : ∀ (a : ar), FSM (q_arity a))
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
  ext n; cases n <;> simp [or, eval, nextBit]

def xor : FSM Bool :=
  { α := Empty,
    initCarry := Empty.elim,
    nextBitCirc := fun a => a.elim
      (Circuit.xor
        (Circuit.var true (inr true))
        (Circuit.var true (inr false))) Empty.elim }

@[simp] lemma eval_xor (x : Bool → BitStream) : xor.eval x = (x true) ^^^ (x false) := by
  ext n; cases n <;> simp [xor, eval, nextBit]

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

theorem add_nextBitCirc_some_eval :
    (add.nextBitCirc (some ())).eval =
      fun x => x (inr true) && x (inr false) || x (inr true)
        && x (inl ()) || x (inr false) && x (inl ()) := by
  ext x
  simp +ground [eval, add, Circuit.simplifyAnd, Circuit.simplifyOr]

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
    simp [add_nextBitCirc_some_eval, nextBit, ih, Circuit.eval, BitStream.addAux, BitVec.adcb]


@[simp] theorem carry_zero (x : ar → BitStream) : carry p x 0 = p.initCarry := rfl
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
    simp [carry, nextBit, BitStream.subAux, sub]
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
    simp [carry, nextBit, BitStream.negAux, neg]
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
  · simp! [eval, carry_one, nextBit, one]

def negOne : FSM (Fin 0) :=
  { α := Empty,
    i := by infer_instance,
    initCarry := Empty.elim,
    nextBitCirc := fun _ => Circuit.tru }

@[simp] lemma eval_negOne (x : Fin 0 → BitStream) : negOne.eval x = BitStream.negOne := by
  ext; simp [negOne, eval, nextBit]

@[simp] def ls (b : Bool) : FSM Unit :=
  { α := Unit,
    initCarry := fun _ => b,
    nextBitCirc := fun x =>
      match x with
      | none => Circuit.var true (inl ())
      | some () => Circuit.var true (inr ()) }

theorem carry_ls (b : Bool) (x : Unit → BitStream) : ∀ (n : ℕ),
    (ls b).carry x (n+1) = fun _ => x () n
  | 0 => by
    simp [carry, nextBit, ls]
  | n+1 => by
    rw [carry, carry_ls _ _ n]
    simp [nextBit, eval, ls]

@[simp] lemma eval_ls (b : Bool) (x : Unit → BitStream) :
    (ls b).eval x = (x ()).concat b := by
  ext n
  cases n
  · rfl
  · simp [ls, carry_ls, eval, nextBit, BitStream.concat, carry]

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
    simp [carry, nextBit, BitStream.incrAux, incr]
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
    simp [carry, nextBit, BitStream.decrAux, decr]
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

end FSM

structure FSMSolution (t : Term) extends FSM (Fin t.arity) where
  ( good : t.evalFinStream = toFSM.eval )

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
    (x : Fin t.arity → BitStream) :
    (composeUnary p q).eval x = p.eval (λ _ => t.evalFinStream x) := by
  rw [composeUnary, FSM.eval_compose, q.good]; rfl

@[simp] lemma composeBinary_eval
    (p : FSM Bool)
    {t₁ t₂ : Term}
    (q₁ : FSMSolution t₁)
    (q₂ : FSMSolution t₂)
    (x : Fin (max t₁.arity t₂.arity) → BitStream) :
    (composeBinary p q₁ q₂).eval x = p.eval
      (λ b => cond b (t₁.evalFinStream (fun i => x (Fin.castLE (by simp) i)))
                  (t₂.evalFinStream (fun i => x (Fin.castLE (by simp) i)))) := by
  rw [composeBinary, FSM.eval_compose, q₁.good, q₂.good]
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
theorem ofNat_zero : ofNat 0 = FSM.zero :=
  by simp [ofNat]

/-- Evaluating 'const n' gives us the bits of the value of 'const n'.-/
@[simp]
theorem eval_ofNat (n : Nat) (i : Nat) {env : Fin 0 → BitStream} :
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


/-- Test the 'k'th bit of an integer.

* negSucc:
   - (n + 1)
   = -n - 1
   = (!x + 1) - 1 = !x
-/
def _root_.Int.testBit' (i : Int) (k : Nat) : Bool :=
  match i with
  | .ofNat n => n.testBit k
  | .negSucc n => !(n.testBit k)

/--
the 'k'th bit of 'w' is equal to the 'k'th bit we get by testing the integer representation.
-/
theorem BitVec.getLsbD_eq_toInt_testBit' (b : BitVec w) (hk : k < w) : b.getLsbD k = b.toInt.testBit' k := by
  rw [BitVec.getLsbD]
  rw [BitVec.toInt_eq_toNat_cond]
  by_cases hb : 2 * b.toNat < 2^w
  · simp [hb]
    rw [Int.testBit'.eq_def]
  · simp [hb]
    have : ↑b.toNat - 2 ^ w = Int.subNatNat b.toNat (2 ^ w) := by norm_cast
    rw [Int.testBit'.eq_def, this, Int.subNatNat_of_lt (by omega)]
    simp
    let notb := (~~~ b).toNat
    rw [show 2^w - b.toNat - 1 = 2^w - 1 - b.toNat by omega, ← BitVec.toNat_not]
    rw [← BitVec.getLsbD, ← BitVec.getLsbD]
    simp
    omega


/--
If `i < -1`, then `i` is less than `i / 2`.
If `i = -1`, then `-1 / 2 = -1` (floor division of integers).
-/
private theorem Int.lt_of_neg {i : Int} (hi : i < - 1) : i < i / 2 := by
  have h : (2 ∣ i) ∨ (2 ∣ (i - 1)) := by
    omega
  rcases h with h | h
  · rw [Int.div_def]
    apply Int.lt_ediv_of_mul_lt <;> omega
  · have hi : i = (i - 1) + 1 := by omega
    conv =>
      rhs
      rw [hi]
    rw [Int.add_ediv_of_dvd_left]
    · simp only [Int.reduceDiv, add_zero]
      apply Int.lt_ediv_of_mul_lt
      · omega
      · exact h
      · omega
    · omega

/--
Show how to build a bitvector representation from a `negSucc`.
The theory of `Int.testBit` tells us that we can get the bits from `!(n.testBit k)`.
-/
def ofNegInt (i : Int) (hi : i < 0) : FSM (Fin 0) :=
  if hi' : i = -1 then
    FSM.negOne
  else
    let bit := i.testBit' 0
    let m := i / 2
    let k := ofNegInt m (by omega)
    composeUnaryAux (FSM.ls bit) k
  termination_by (-i |>.toNat)
  decreasing_by
    simp [hi]
    apply Int.lt_of_neg
    omega

/--
-/
@[simp] theorem eval_ofNegInt (x : Int) (hx : x < 0)  (i : Nat) {env : Fin 0 → BitStream} :
    (ofNegInt x hx).eval env i = BitStream.ofInt x i := by
  rcases x with x | x
  · simp at hx; omega
  · simp [BitStream.ofInt]
    induction x
    case zero =>
      simp [ofNegInt]
    case succ x ih =>
      rw [ofNegInt]
      have hi' : Int.negSucc (x + 1) ≠ -1 := by omega
      simp [hi']
      simp [BitStream.concat]
      sorry

/-- Build a finite state machine for the integer `i` -/
def ofInt (x : Int) : FSM (Fin 0) :=
  if hi : x ≥ 0 then
    ofNat x.toNat
  else
    ofNegInt x (by omega)

/--
The result of `FSM.ofInt x` matches with `BitStream.ofInt x`.
-/
theorem eval_ofInt (x : Int) (i : Nat) {env : Fin 0 → BitStream} :
    (ofInt x).eval env i = BitStream.ofInt x i := by
  rcases x with x | x
  · simp [ofInt, BitStream.ofInt]
  · simp [ofInt, BitStream.ofInt]


/-- Identity finite state machine -/
def id : FSM Unit := {
 α := Empty,
 initCarry := Empty.elim,
 nextBitCirc := fun a =>
   match a with
   | none => (Circuit.var true (inr ()))
   | some f => f.elim
}

/-- Build logical shift left automata by `n` bits -/
def shiftLeft (n : Nat) : FSM Unit :=
  match n with
  | 0 => FSM.id
  | n + 1 => composeUnaryAux (FSM.ls false) (shiftLeft n)

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

abbrev FSM.ofTerm (t : Term) : FSM (Fin t.arity) := termEvalEqFSM t |>.toFSM

end FSM
