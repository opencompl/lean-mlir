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
structure FSM (arity : Type) : Type 1 :=
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

theorem eval_eq_eval' :
    p.eval x = p.eval' x := by
  funext i
  simp only [eval, eval']
  induction i generalizing p x
  case zero => rfl
  case succ i ih =>
    sorry

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

@[simp] lemma eval_xor (x : Bool → BitStream) : xor.eval x = (x true) ^^^ (x false) := by
  ext n; cases n <;> simp [and, eval, nextBit]

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
    simp [carry, nextBit, Function.funext_iff, BitStream.subAux, sub]
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
    simp [carry, nextBit, Function.funext_iff, BitStream.negAux, neg]
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
    simp [carry, nextBit, Function.funext_iff, ls]
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

-- Circuit that increments input by 1.
def incr : FSM Unit :=
  { α := Unit,
    initCarry := fun _ => true, -- adding 1
    nextBitCirc := fun x =>
      match x with
      -- Output is carry bit XOR state bit.
      | none => (Circuit.var true (inr ())) ^^^ (Circuit.var true (inl ()))
      -- Next carry bit is carry bit AND state bit.
      | some _ => (Circuit.var true (inr ())) &&& (Circuit.var true (inl ()))
  }

theorem carry_incr (x : Unit → BitStream) : ∀ (n : ℕ),
    incr.carry x (n+1) = fun _ => (BitStream.incrAux (x ()) n).2
  | 0 => by
    simp [carry, nextBit, Function.funext_iff, BitStream.incrAux, incr]
  | n+1 => by
    rw [carry, carry_incr _ n]
    simp [nextBit, eval, incr, incr, BitStream.incrAux]

@[simp] lemma eval_incr (x : Unit → BitStream) : incr.eval x = (x ()).incr := by
  ext n
  cases n
  · simp [eval, incr, nextBit, carry, BitStream.incr, BitStream.incrAux]
  · rw [eval, carry_incr]; rfl

-- Circuit that decrements input by 1.
def decr : FSM Unit :=
  { α := Unit,
    i := by infer_instance,
    initCarry := λ _ => true, -- subtracting 1
    nextBitCirc := fun x =>
      match x with
      | none => (Circuit.var true (inr ())) ^^^ (Circuit.var true (inl ())) -- output is borrow XOR a[i]
      | some _ => (Circuit.var false (inr ())) &&& (Circuit.var true (inl ())) -- Next borrow is neg `a[i] & borrow`
  }

theorem carry_decr (x : Unit → BitStream) : ∀ (n : ℕ), decr.carry x (n+1) =
    fun _ => (BitStream.decrAux (x ()) n).2
  | 0 => by
    simp [carry, nextBit, Function.funext_iff, BitStream.decrAux, decr]
  | n+1 => by
    rw [carry, carry_decr _ n]
    simp [nextBit, eval, decr, BitStream.decrAux]

@[simp] lemma eval_decr (x : Unit → BitStream) : decr.eval x = BitStream.decr (x ()) := by
  ext n
  cases n
  · simp [eval, decr, nextBit, carry, BitStream.decr, BitStream.decrAux]
  · rw [eval, carry_decr]; rfl

/--
If the set of states R is closed under the inverse image of next state,
and if every state in the set R produces a true next output,
and furthermore, if our initial state is not R,
the the value at the initial state is zero, and furthermore, the state will not enter into R in the next state
-/

theorem evalAux_eq_zero_of_set {arity : Type _} (p : FSM arity)
    (R : Set (p.α → Bool)) -- set of state bitvectors (i.e., set of carries)
    (hR : ∀ x s, (p.nextBit s x).1 ∈ R → s ∈ R) -- if the next state is in R, then s is in R (coinductive inclusion)
    (hi : p.initCarry ∉ R) -- the initial state is currently not in R.
    (hr1 : ∀ x s, (p.nextBit s x).2 = true → s ∈ R) -- if the next output is true, then s is in R.
    (x : arity → BitStream) (n : ℕ) :
    p.eval x n = false ∧ p.carry x n ∉ R  -- then the current state is false, and the next state is not in R.
    := by
  simp (config := {singlePass := true}) only [← not_imp_not] at hR hr1
  simp only [Bool.not_eq_true] at hR hr1
  induction n with
  | zero =>
    simp only [eval, carry]
    exact ⟨hr1 _ _ hi, hi⟩
  | succ n ih =>
    simp only [eval, carry] at ih ⊢
    exact ⟨hr1 _ _ (hR _ _ ih.2), hR _ _ ih.2⟩

/-- Under the same conditions as before, the evaluation of the FSM will be all zeroes -/
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

@[simp] theorem eval_repeatBit :
    repeatBit.eval x = BitStream.repeatBit (x ()) := by
  unfold BitStream.repeatBit
  rw [eval_eq_eval', eval']
  apply BitStream.corec_eq_corec
    (R := fun a b => a.1 () = b.2 ∧ (a.2 ()) = b.1)
  · simp [repeatBit]
  · intro ⟨y, a⟩ ⟨b, x⟩ h
    simp at h
    simp [h, nextBit, BitStream.head]

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
    (x : Fin t.arity → BitStream) :
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

instance {α β : Type} [Fintype α] [Fintype β] (b : Bool) :
    Fintype (cond b α β) := by
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

/--
Compute the cardinality of the set of inputs where the circuit produces false.
It builds the set of all bitvectors with `Finset.univ`,
filters those states where the Circuit evaluates to false ,
and then returns the cardinality of this set.
It is the cardinality of the complement of the set of inputs to the circuit that produce 1 as output.
-/
def card_compl [Fintype α] [DecidableEq α] (c : Circuit α) : ℕ :=
  Finset.card $ (@Finset.univ (α → Bool) _).filter (fun a => c.eval a = false)


/-
For any two circuits c, c', we must have that card_compl (c' ||| c) ≤ card_compl c.
This is because whenever `c' ||| c = 0`, this implies that `c = 0`.
Therefore, if `i ∈ card_compl (c' ||| c)` , then it implies that `i ∈ card_compl c`.
-/
theorem card_compl_or_le {α : Type _} [Fintype α] [DecidableEq α]
    {c c' : Circuit α}
    : card_compl (c' ||| c) ≤  -- the set of inputs where `c' ||| c` is zero, is always ≤
      card_compl c -- the set of inputs where `c` is zero.
    := by
  apply Finset.card_le_card
  simp [Finset.ssubset_iff, Finset.subset_iff]

/-
Recall the circuit ordering of L ≤ R:
  We have L ≤ R iff for every input `i` such that L[i] = 1, we have R[i] = 1.
  Therefore, L as treated as a function is pointwise less than the function R,
  under the ordering `0 ≤ 1`.

- We know from `card_compl_or_le` that `card_compl (c' ||| c) ≤ card_compl c.
- We also know from the hypothesis `¬ c' ≤ c` that there is some input `i` for `c'` where `c'[i] = 1` while
  c[i] = 0.
- this tells us that `c' ||| c` is 1 strictly more than `c` is, and thus
  `card_compl (c' ||| c)` is strict less than `card_compl c`.
-/
theorem decideIfZeroAux_wf {α : Type _} [Fintype α] [DecidableEq α]
    {c c' : Circuit α}
    (h : ¬c' ≤ c) -- c' is not less than c, so there is *some* input i where c'[i] = 1, and c[i] = 0.
    : card_compl (c' ||| c) <  -- the set of inputs where `c' ||| c` is zero, is strictly less than
      card_compl c -- the set of inputs where `c` is zero.
    := by
  apply Finset.card_lt_card
  simp [Finset.ssubset_iff, Finset.subset_iff]
  simp only [Circuit.le_def, not_forall, Bool.not_eq_true] at h
  rcases h with ⟨x, hx, h⟩
  use x
  simp [hx, h]

/--
We check if the circuit, when fed the sequence of states from the FSM, produces all zeroes.

- If the circuit evaluates to true on the initial state of the FSM,
  then we instantly return false, since the circuit has not produced a zero on the initial state.
- If the circuit evaluates to false on the current state,
  we extend the circuit by adjoining the output circuit on top of the next state circuit.
  We use `Circuit.bind` to perform this operation.
- We then *decide* if the next state's output circuit can make more inputs true.
   + If it cannot, then we have saturated, and have established that going to the next state
     does not add any more zeroes, and thus we are done. we return `true`.
   + TODO: why does this suffice?
- If the next state's output circuit can make more inputs true,
  we then recurse and run our procedure on both the current state and the next state's circuits ORd together.
   + See that this will mean that on the next step, we will unfold the circuit for TWO steps!
- Also see that this entire procedure is *crazy* expensive.
-/
def decideIfZerosAux {arity : Type _} [DecidableEq arity]
    (p : FSM arity) (c : Circuit p.α) : Bool :=
  if c.eval p.initCarry
  then false
  else
    -- Funny, we don't even need the FSM here, we can write this in terms of `p.nextBitCirc`.
    have c' := (c.bind (p.nextBitCirc ∘ some)).fst
    if h : c' ≤ c -- 2^n
    then true
    else
      have _wf : card_compl (c' ||| c) < card_compl c :=
        decideIfZeroAux_wf h
      decideIfZerosAux p (c' ||| c)
  termination_by card_compl c

/--
Check if the FSM `p` ever causes the output bit circuit to produce a `1`.
We do this by invoking `decideIfZeroesAux` on the output bit circuit of the FSM.
-/
def decideIfZeros {arity : Type _} [DecidableEq arity]
    (p : FSM arity) : Bool :=
  decideIfZerosAux p (p.nextBitCirc none).fst

theorem decideIfZerosAux_correct {arity : Type _} [DecidableEq arity]
    (p : FSM arity) (c : Circuit p.α)
    (hc : ∀ s, c.eval s = true → -- if for a given state, the circuit `c` evaluates to true,
      ∃ (m : ℕ) (y : arity → BitStream), (p.changeInitCarry s).eval y m = true)
      -- ^ then there exists an input `y1,... yn`, on which simulating for `m` steps makes the FSM return true.
    (hc₂ : ∀ (x : arity → Bool) (s : p.α → Bool),
      (FSM.nextBit p s x).snd = true → -- if the state bit of the FSM at state `s` and input `x1...xn` is true,
      Circuit.eval c s = true) -- then the circuit `c` evaluates to true.
    :
    decideIfZerosAux p c = true ↔ -- if decideIfZerosAux says it's true
    ∀ n x, p.eval x n = false := -- then for all inputs, it is indeed false.
  by
  rw [decideIfZerosAux]
  split_ifs with h
  · -- c.eval p.initCarry = true
    simp
    exact hc p.initCarry h -- initial input makes it true.
  · -- c.eval p.initCarry = false.
    dsimp
    split_ifs with h'
    · -- (c.bind (p.nextBitCirc ∘ some)).fst ≤ c
      -- next state has strictly fewer 1s than current state.
      simp only [true_iff]
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
    (p : FSM arity) :
    decideIfZeros p = true ↔
    ∀ n x, p.eval x n = false := by
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




/-
Recall the circuit ordering of L ≤ R:
  We have L ≤ R iff for every input `i` such that L[i] = 1, we have R[i] = 1.
  Therefore, L as treated as a function is pointwise less than the function R,
  under the ordering `0 ≤ 1`.

- We know from `card_compl_or_le` that `card_compl (c' ||| c) ≤ card_compl c.
- We also know from the hypothesis `¬ c' ≤ c` that there is some input `i` for `c'` where `c'[i] = 1` while
  c[i] = 0.
- this tells us that `c' ||| c` is 1 strictly more than `c` is, and thus
  `card_compl (c' ||| c)` is strict less than `card_compl c`.
-/
theorem decideEventuallyZeroAux_wf {α : Type _} [Fintype α] [DecidableEq α]
    {c c' : Circuit α}
    (h : ¬c' ≤ c) -- c' is not less than c, so there is *some* input i where c'[i] = 1, and c[i] = 0.
    : card_compl (c' ||| c) <  -- the set of inputs where `c' ||| c` is zero, is strictly less than
      card_compl c -- the set of inputs where `c` is zero.
    := by
  apply Finset.card_lt_card
  simp [Finset.ssubset_iff, Finset.subset_iff]
  simp only [Circuit.le_def, not_forall, Bool.not_eq_true] at h
  rcases h with ⟨x, hx, h⟩
  use x
  simp [hx, h]

/-!
## Thoughts

We had some thoughts about deciding eventually all-zeroes: the core idea was
that if our state space is limited to `k` bits (i.e., `2^k` states), then
we only have to look at most `2^k` steps in the future before we are guaranteed
to enter into a loop.

We were trying to work out some examples where we fixed a particular input, and
trying to prove that, say `p.eval x` is eventually all zeroes iff
`(p.eval x).drop (2^k)` is the all-zeroes bitstream.

This is, sadly, untrue: consider `p` the stateless identity FSM, and `x` the
single inputs stream `1^{64}⋅0^{ω}`. Clearly, `x` is eventually
all zeroes, however, this happens only after 64 bits. Not the `2^0 = 1` bits
we conjectured.
This is because, when we talk about the bitstream generated by `p` for a
particular input `x`, the state-space is not *just* the state-space of `p`, but
we also have to take the state space used to generate `x` into account.

In our *actual* goal, we don't have a state-space of the input, since we are
universally quantifying. This is just to say that we cannot simplify by thinking
about a fixed input, we truly have to talk in terms of universally qualified
inputs.

### Coinductive Brainrot

One way to go all in, is to change what the FSM denotes into.
(CAVEAT: I'm not seriously proposing we do this now, just taking notes for
  post-PLDI deadline)

Instead of denoting an FSM into a function `(arity → BitStream) → BitStream`, we
can denote it into a coinductive tree type, let's call it `BitTree`,
where each node is labeled with the current output bit and has `2^arity`
subtrees (one for each possible combination of the `i`-th bits of the input
streams).
```
codata BitTree arity where
| node (bit : Bool) (children : arity → BitTree arity)
```

Note that we can define such a tree without `codata` as
```
def BitStream (arity : Type) :=
  (Σ w, arity → BitVec w) → Bool
```
That is, as a function which takes in a `w : Nat`, and a prefix of the first
`w` bits of the input, and returns the `w`-th bit of the output.

This is computationally likely to be horrendous (for a concrete input), but
might be the philosophically right type for universally quantified inputs --
assuming an adequate coinductive Kool-Aid consumption.

We might not even have to define this type explicitly, but it could inform
the way we design the proofs, keeping in mind this is the kind of structure we
are reasoning about.

Coming back to our original question of bounds: this tree can be generated with
as its statespace purely the FSM state-space. Therefore, we only need to
traverse the tree up to depth `2^{stateWidth}`. But, given that it's a tree,
it's width scales with the arity.

### Alternative Bounds

Sid conjectures the true bound should be 2^{stateWidth} × 2^{arity}.

-/

/--
We check if the circuit, when fed the sequence of states from the FSM, produces all zeroes.

- If the circuit evaluates to true on the initial state of the FSM,
  then we instantly return false, since the circuit has not produced a zero on the initial state.
- If the circuit evaluates to false on the current state,
  we extend the circuit by adjoining the output circuit on top of the next state circuit.
  We use `Circuit.bind` to perform this operation.
- We then *decide* if the next state's output circuit can make more inputs true.
   + If it cannot, then we have saturated, and have established that going to the next state
     does not add any more zeroes, and thus we are done. we return `true`.
   + TODO: why does this suffice?
- If the next state's output circuit can make more inputs true,
  we then recurse and run our procedure on both the current state and the next state's circuits ORd together.
   + See that this will mean that on the next step, we will unfold the circuit for TWO steps!
- Also see that this entire procedure is *crazy* expensive.
-/
def decideEventuallyZerosAux {arity : Type _} [DecidableEq arity]
    (depth : Nat)
    (p : FSM arity) (c : Circuit p.α) : Bool :=
  -- Funny, we don't even need the FSM here, we can write this in terms of `p.nextBitCirc`.
  have c' := (c.bind (p.nextBitCirc ∘ some)).fst
  if c.eval p.initCarry = false ∧ c' ≤ c /- 2^n -/ then
    true
  else
    match depth with
    | 0 => false
    | depth+1 => decideEventuallyZerosAux depth p c'

def Circuit.bindN (c : Circuit α) (f : α → Circuit α) (n : Nat) : Circuit α :=
  (Circuit.bind · f)^[n] c


theorem useful (c: Circuit α) (f : α → Circuit α) (v : α → Bool) (hc : c.eval v = false)
    (hbind : c.bind f ≤ c) : ∀ n, c.bindN f n |>.eval v = false := sorry

#check Circuit.eval_fst
theorem basecase {arity : Type _} [DecidableEq arity]
    (p : FSM arity) (c : Circuit p.α)
    -- (hc : ∀ s, c.eval s = true → -- if for a given state, the circuit `c` evaluates to true,
    --   ∃ (m : ℕ) (y : arity → BitStream), (p.changeInitCarry s).eval y m = true)
    --   -- ^ then there exists an input `y1,... yn`, on which simulating for `m` steps makes the FSM return true.
    -- (hc₂ : ∀ (x : arity → Bool) (s : p.α → Bool),
    --   (FSM.nextBit p s x).snd = true → -- if the state bit of the FSM at state `s` and input `x1...xn` is true,
    --   Circuit.eval c s = true) -- then the circuit `c` evaluates to true.
    (hc_eq :
      c = (p.nextBitCirc none).fst
    )
    (h : c.eval p.initCarry = false
         ∧ (c.bind (p.nextBitCirc ∘ some)).fst ≤ c) :
    ∀ xs, p.eval xs = fun _ => false := by
  intro xs
  funext i
  subst hc_eq
  obtain ⟨h₁, h₂⟩ := h
  simp [FSM.eval, FSM.nextBit]
  simp [(· ≤ ·), Circuit.eval_fst, Circuit.eval_bind] at h₂
  simp [Circuit.eval_bind] at h₂


/--
Check if the FSM `p` ever causes the output bit circuit to produce a `1`.
We do this by invoking `decideEventuallyZeroesAux` on the output bit circuit of the FSM.
-/
def decideEventuallyZeros {arity : Type _} [DecidableEq arity]
    (p : FSM arity) : Bool :=
  decideEventuallyZerosAux p (p.nextBitCirc none).fst

theorem decideEventuallyZerosAux_correct {arity : Type _} [DecidableEq arity]
    (p : FSM arity) (c : Circuit p.α)
    (hc : ∀ s, c.eval s = true → -- if for a given state, the circuit `c` evaluates to true,
      ∃ (m : ℕ) (y : arity → BitStream), (p.changeInitCarry s).eval y m = true)
      -- ^ then there exists an input `y1,... yn`, on which simulating for `m` steps makes the FSM return true.
    (hc₂ : ∀ (x : arity → Bool) (s : p.α → Bool),
      (FSM.nextBit p s x).snd = true → -- if the state bit of the FSM at state `s` and input `x1...xn` is true,
      Circuit.eval c s = true) -- then the circuit `c` evaluates to true.
    :
    decideEventuallyZerosAux p c = true ↔ -- if decideEventuallyZerosAux says it's true
    ∀ n x, p.eval x n = false := -- then for all inputs, it is indeed false.
  by
  rw [decideEventuallyZerosAux]
  split_ifs with h
  · -- c.eval p.initCarry = true
    simp
    exact hc p.initCarry h -- initial input makes it true.
  · -- c.eval p.initCarry = false.
    dsimp
    split_ifs with h'
    · -- (c.bind (p.nextBitCirc ∘ some)).fst ≤ c
      -- next state has strictly fewer 1s than current state.
      simp only [true_iff]
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
        decideEventuallyZeroAux_wf h'
      apply decideEventuallyZerosAux_correct p (c' ||| c)
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

theorem decideEventuallyZeros_correct {arity : Type _} [DecidableEq arity]
    (p : FSM arity) :
    decideEventuallyZeros p = true ↔
    ∀ n x, p.eval x n = false := by
  apply decideEventuallyZerosAux_correct
  · simp only [Circuit.eval_fst, forall_exists_index]
    intro s x h
    use 0
    use (fun a _ => x a)
    simpa [FSM.eval, FSM.changeInitCarry, FSM.nextBit, FSM.carry]
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
def Predicate.denote : Predicate α → Prop
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
