import Mathlib.Data.FinEnum
import Mathlib.Data.Fintype.Card
import Mathlib.Data.Fintype.Sum
import Mathlib.Data.Fintype.Sigma
import Mathlib.Data.Fintype.Pi
import Mathlib.Data.Fintype.BigOperators
import Mathlib.Tactic.Zify
import Mathlib.Tactic.Ring
import SSA.Experimental.Bits.FinEnum
import SSA.Experimental.Bits.Fast.Defs
import SSA.Experimental.Bits.Fast.Circuit
import SSA.Experimental.Bits.Vars

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
  [ h : Hashable α ]
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

  `nextBitCirc none` computes the current output bit as a function of the state and inputs.
  `nextBitCirc (some a)`, computes the *one* bit of the new state that corresponds to `a : α`. -/
  outputCirc : Circuit (α ⊕ arity)
  nextStateCirc : α → Circuit (α ⊕ arity)

attribute [instance] FSM.i FSM.dec_eq FSM.h


set_option warn.sorry false in
def Finset.toListUnsafe (as : Finset α) : List α :=
  let multiset := as.val
  Quotient.lift id sorry multiset


open Lean in
def formatSum (fα : α → Lean.Format) (fβ : β → Lean.Format) (x : α ⊕ β) : Lean.Format :=
  match x with | .inl x => f!"(l {fα x})" | .inr x => f!"(r {fβ x})"


open Lean in
instance FormatSum [formatα : ToFormat α] [formatβ : ToFormat β] : ToFormat (α ⊕ β) where
  format x := match x with | .inl x => f!"(l {format x})" | .inr x => f!"(r {format x})"

open Lean in
def formatDecEqFinset [Fintype α] [DecidableEq α] (a : α) : Lean.Format :=
  let as : List α := Finset.toListUnsafe Finset.univ
  format <| as.findIdx (fun b => a = b)

open Lean in
def FormatDecEqFinset [Fintype α] [DecidableEq α] : ToFormat α where
  format := formatDecEqFinset

namespace FSM

variable {arity : Type} (p : FSM arity)

instance : Std.Commutative Nat.add where
  comm := fun a b => by simp only [Nat.add_eq]; omega

instance : Std.Associative Nat.add where
  assoc := fun a b => by simp only [Nat.add_eq]; omega

/-- The size of the state space of the finite state machine. -/
def stateSpaceSize : Nat := Nat.pow 2 (FinEnum.card p.α)

/--
Return the total size of the FSM as a function of all of its circuits.
Note that this implicitly counts the size of the state space of the FSM,
and consequently, is the natural notion of complexity of the FSM.
-/
def circuitSize : Nat := Id.run do
  let outCircSize := p.outputCirc |>.size
  let mut stateCircSize := 0
  for hi : i in List.range (FinEnum.card p.α) do
    let a := p.nextStateCirc (((FinEnum.equiv (α := p.α)).symm.toFun ⟨i, by simpa using hi⟩))
    stateCircSize := stateCircSize + a.size
  return outCircSize + stateCircSize

/-
open Lean in
def format (fsm : FSM arity) [Fintype arity] [DecidableEq arity] : Format := Id.run do
  have : DecidableEq fsm.α := fsm.dec_eq
  let fα : fsm.α → Format := fun x => formatDecEqFinset x ++ ":st"
  let farity : arity → Format := fun x => formatDecEqFinset x ++ ":in"
  let formatSum : (fsm.α ⊕ arity) → Format := Sum.elim fα farity
  let mut out := f!""
  out := out ++ f!"Initial state:"
  for a in @Finset.univ fsm.α |>.toListUnsafe do
    out := out ++ f!"  - {fα a} → {fsm.initCarry a}" ++ Format.line
    pure ()
  let numStateBits : Nat := @Finset.univ (fsm.α) inferInstance |>.card
  let arity : Nat := @Finset.univ arity inferInstance |>.card
  let fsm := Lean.ShareCommon.shareCommon fsm
  out := out ++ f!"⋆ #args '{arity}'" ++ Format.line
  out := out ++ f!"⋆ #state bits '{numStateBits}'" ++ Format.line
  out := out ++ Format.line ++  .text "**Projection:**" ++ Format.line
  out := out ++ "'" ++ Format.group (Format.nest 2 (formatCircuit formatSum (fsm.nextBitCirc none))) ++ "'" ++ Format.line
  out := out ++ "**State Transition:**" ++  Format.line
  let as : List fsm.α := Finset.univ |>.toListUnsafe
  let mut ts := f!""
  for (a, _i) in List.zipIdx as do
    ts := ts ++ Format.align true ++ f!"{fα a}: '{(formatCircuit formatSum (fsm.nextBitCirc (some a)))}'" ++ Format.line
  out := out ++ Format.group (Format.nest 2 ts)
  return out
-/


/-- The state of FSM `p` is given by a function from `p.α` to `Bool`.

Note that `p.α` is assumed to be a finite type, so `p.State` is morally
a finite bitvector whose width is given by the arity of `p.α` -/
abbrev State : Type := p.α → Bool

/-- `p.nextBit state in` computes both the next state bits and the output bit,
where `state` are the *current* state bits, and `in` are the current input bits. -/
def nextBit : p.State → (arity → Bool) → p.State × Bool :=
  fun carry inputBits =>
    let input := Sum.elim carry inputBits
    let newState : p.State  := fun (a : p.α) => (p.nextStateCirc a).eval input
    let outBit : Bool       := (p.outputCirc).eval input
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

@[simp]
theorem initCarry_changeInitCarry_eq (p : FSM arity) (c : p.α → Bool) :
    (p.changeInitCarry c).initCarry = c := rfl

@[simp]
theorem outputCirc_changeInitCarry_eq (p : FSM arity) (c : p.α → Bool) :
    (p.changeInitCarry c).outputCirc = p.outputCirc := rfl

@[simp]
theorem nextStateCirc_changeInitCarry_eq (p : FSM arity) (c : p.α → Bool) :
    (p.changeInitCarry c).nextStateCirc = p.nextStateCirc := rfl

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

@[simp]
theorem changeInitCarry_eq_self (p : FSM arity) :
    p.changeInitCarry p.initCarry = p := by
  simp [changeInitCarry]

-- The actual API that theorems should be written is 'carryWith' and 'evalWith',
-- since they describe the evolution of the FSM carry and output states.

/-- compute the nth carry bits, starting with 'c', upto 'n' steps,
for an input stream. -/
def carryWith (p : FSM arity) (carryState : p.α → Bool) (x : arity → BitStream) (n : Nat) : p.α → Bool := fun a =>
  (p.changeInitCarry carryState).carry x n a

@[simp]
theorem carryWith_zero_eq (carryState : p.α → Bool) (x : arity → BitStream) :
    p.carryWith carryState x 0 =  carryState := by
  ext s
  simp [carryWith, changeInitCarry, carry]

/-- One step transition of the FSM.-/
def delta (p : FSM arity) (carryState : p.α → Bool) (x : arity → BitStream) : p.α → Bool :=
  p.carryWith carryState x 1

@[simp]
theorem delta_eq_carryWith_one (carryState : p.α → Bool) (x : arity → BitStream) :
    p.delta carryState x = p.carryWith carryState x 1 := rfl


/--
the 'carryWith' of the successor equals the 'carryWith' of the predecessor, with a different init state.
-/
@[simp]
theorem carryWith_delta_eq_succ_carryWith (carryState : p.α → Bool) (x : arity → BitStream) :
    p.carryWith (p.delta carryState x) (fun a i => x a (i + 1)) n =
    p.carryWith carryState x (n + 1) := by
  ext s
  conv =>
    rhs
    rw [carryWith]
  rw [carry_changeInitCarry_succ]
  rw [← carryWith]
  /- theorem to show is that 'carryWith of carryWith is compositional. -/
  congr

@[simp]
theorem carryWith_carryWith_one_eq_succ_carryWith (carryState : p.α → Bool) (x : arity → BitStream) :
    p.carryWith (p.carryWith carryState x 1) (fun a i => x a (i + 1)) n =
    p.carryWith carryState x (n + 1) := by
  ext s
  conv =>
    rhs
    rw [carryWith]
  rw [carry_changeInitCarry_succ]
  rw [← carryWith]
  congr


theorem carryWith_eq_carry_of_eq_initCarry (p : FSM arity) (carryState : p.α → Bool) (x : arity → BitStream) (n : Nat)
    (hc : carryState = p.initCarry) :
    p.carryWith carryState x n = p.carry x n := by
  subst hc
  ext s
  simp [carryWith, changeInitCarry]

@[simp]
theorem carryWith_initCarry_eq_carry (p : FSM arity) (x : arity → BitStream) (n : Nat) :
    p.carryWith p.initCarry x n = p.carry x n := by
  ext s
  simp [carryWith, changeInitCarry]

theorem carry_eq_carryWith_initCarry (p : FSM arity) (x : arity → BitStream) (n : Nat) :
    p.carry x n = p.carryWith p.initCarry x n := by
  simp [carryWith_initCarry_eq_carry]

/-- The 'carry' only looks at the first 'i' bits, and so we can
replace the env with another env that is equivalent upto i bits.
-/
theorem carry_congrEnv {p : FSM arity}
    {x y : arity → BitStream} {n : Nat} (h : ∀ a i, i < n → x a i = y a i) :
    p.carry x n = p.carry y n := by
  induction n
  case zero => simp [carry]
  case succ n ih =>
    rw [carry]
    rw [ih]
    conv =>
      rhs
      rw [carry]
    · congr
      ext a
      apply h
      omega
    · intros i k hk
      apply h
      omega

/-- carryWith's environment can be changed -/
theorem carryWith_congrEnv {p : FSM arity}
    {carryState : p.α → Bool} {x y : arity → BitStream} {n : Nat}
    (h : ∀ a i, i < n → x a i = y a i) :
    p.carryWith carryState x n = p.carryWith carryState y n := by
  ext a
  rw [carryWith, carryWith]
  rw [carry_congrEnv h]

/-- compute the next evaluation bit starting with 'initCarry'.
TODO: write theorems for 'evalWith'.
-/
def evalWith (p : FSM arity) (carryState : p.α → Bool) (x : arity → BitStream) : BitStream :=
  (p.changeInitCarry carryState).eval x

/-- `eval` produces the same results as long as
the environment are equivalent up to `n` bits.
-/
theorem eval_congrEnv {p : FSM arity}
    {x y : arity → BitStream} {n : Nat} (h : ∀ a i, i ≤ n → x a i = y a i) :
    p.eval x n = p.eval y n := by
  simp [eval]
  congr 2
  · ext i
    rw [carry_congrEnv]
    intros a i hi
    apply h _ _ (by omega)
  · ext i
    apply h
    omega

/-- `evalWith` procuces the same results as long as
the environment are equivalent up to `n` bits.
-/
theorem evalWith_congrEnv {p : FSM arity}
    {x y : arity → BitStream} {carryState : p.α → Bool} {n : Nat}
    (h : ∀ a i, i ≤ n → x a i = y a i) :
    p.evalWith carryState x n = p.evalWith carryState y n := by
  rw [evalWith, evalWith]
  apply eval_congrEnv h

/-- One step transition of the FSM.-/
def delta' (p : FSM arity) (carryState : p.α → Bool) (x : arity → Bool) : p.α → Bool :=
  fun s => (p.nextStateCirc s).eval fun v =>
    Sum.elim carryState (fun a => x a) v


/-- Evaluating at (n + 1) equals evaluating at n with a different state-/
theorem evalWith_succ_eq_evalWith_delta' (p : FSM arity) (carryState : p.α → Bool)
      (x : arity → BitStream) :
  p.evalWith carryState x (n + 1) =
  p.evalWith (p.delta' carryState (fun s => x s 0)) (fun s i => x s (i + 1)) n := by
  -- Proof goes here
  simp [evalWith]
  rw [eval_changeInitCarry_succ]
  congr


/-- Evaluating at (n + 1) equals evaluating at n with a different state-/
theorem evalWith_succ_eq (p : FSM arity) (carryState : p.α → Bool)
      (x : arity → BitStream) :
  p.evalWith carryState x (n + 1) =
  p.evalWith (p.delta' carryState (fun s => x s 0)) (fun s i => x s (i + 1)) n := by
  -- Proof goes here
  simp [evalWith]
  rw [eval_changeInitCarry_succ]
  congr


/-- compute the output of the FSM, given the carry state and the environment of the immediate next bits. -/
def outputWith (p : FSM arity) (carryState : p.α → Bool) (env : arity → Bool) : Bool :=
  (p.outputCirc).eval (Sum.elim carryState env)

/-- evalWith agrees with eval when we set the carry to the init carry. -/
theorem evalWith_eq_eval_of_eq_init (p : FSM arity) (carryState : p.α → Bool) (x : arity → BitStream)
    (hc : carryState = p.initCarry) : p.evalWith carryState x = p.eval x := by
  simp [hc, evalWith]
@[simp]
theorem evalWith_initCarry_eq_init (p : FSM arity)
    : p.evalWith p.initCarry = p.eval := by
  ext x; simp [evalWith]

/-- rewrite an 'eval' in terms of 'evalWith'. -/
theorem eval_eq_evalWith_initCarry  (p : FSM arity) :
    p.eval x = p.evalWith p.initCarry x := by
  simp

/-- Write 'evalWith' in terms of an output followed by a carry. -/
theorem evalWith_eq_outputWith_carryWith
    (p : FSM arity) (carryState : p.α → Bool) (x : arity → BitStream) (n : Nat) :
    p.evalWith carryState x n =
    p.outputWith (p.carryWith carryState x n) (fun a => x a n)  := by
  -- Proof goes here
  simp only [evalWith, eval, changeInitCarry, nextBit, outputWith]
  congr

/-- Write 'evalWith' in terms of an output followed by a carry. -/
theorem evalWith_eq_outputWith_carryWith_of_eq
    {p : FSM arity} {carryState : p.α → Bool} {n : Nat}
    (env : arity → BitStream)
    (outEnv : arity → Bool)
    (henv : (fun a => env a n) = outEnv) :
    p.evalWith carryState env n =
    p.outputWith (p.carryWith carryState env n) outEnv  := by
  -- Proof goes here
  subst henv
  rw [evalWith_eq_outputWith_carryWith]


/-- rewrite an 'eval' in terms of an 'outputWith' + 'carryWith'.
most detailed decomposition of an FSM available.
-/
theorem eval_eq_outputWith_carryWith (p : FSM arity) :
  p.eval x n =
  p.outputWith (p.carryWith p.initCarry x n) (fun a => x a n) := by
  simp only [carryWith_initCarry_eq_carry]
  apply evalWith_eq_outputWith_carryWith

/-- rewrite an 'eval' in terms of an 'outputWith' + 'carryWith',
while changing the environment 'x'.
most detailed decomposition of an FSM available.
-/
theorem outputWith_carryWith_eq_evalWith (p : FSM arity)
  (xs ys : arity → BitStream) (xN : arity → Bool)
  (hysLt : ∀ a i, i < n → ys a i = xs a i)
  (hysN : ∀ a, ys a n = xN a) :
  p.outputWith (p.carryWith p.initCarry xs n) xN = p.evalWith p.initCarry ys n := by
  let env := fun a i => if i < n then xs a i else xN a
  rw [carryWith_congrEnv (y := env)]
  · have : xN = fun a => env a n := by
      ext a
      simp only [env]
      split_ifs with hi
      · omega
      · rfl
    rw [this]
    rw [← evalWith_eq_outputWith_carryWith]
    apply evalWith_congrEnv
    intros a i hi
    by_cases hi : i < n
    · simp [env, hi, hysLt _ _ hi]
    · simp [env, show i = n by omega, hysN]
  · intros a i hi;
    simp only [left_eq_ite_iff, not_lt, env]
    intros hi'
    omega

/-- carryWith commutes with delta -/
theorem carryWith_delta_eq_delta_carryWith
  {carryState : p.α → Bool} {x : arity → BitStream} {n : Nat} :
  p.carryWith (p.delta carryState x) (fun a i => x a (i + 1)) n =
  p.delta (p.carryWith carryState x n) (fun a i => x a (n + i)) := by
  revert x carryState
  induction n
  case zero => simp
  case succ n ih =>
    intros x carryState
    rw [← carryWith_delta_eq_succ_carryWith]
    rw [ih]
    simp
    congr! 4
    omega

/-- carryWith's compose, and so can be added. -/
theorem carryWith_carryWith_eq_carryWith_add (carryState : p.α → Bool) (x : arity → BitStream) :
      p.carryWith (p.carryWith carryState x n) (fun a i => x a (n + i)) m =
      p.carryWith carryState x (n + m) := by
  revert n x carryState
  induction m
  case zero =>
    simp
  case succ m ih =>
    intros n carryState x
    rw [show n + (m + 1) = (n + m) + 1 by omega]
    repeat rw [← carryWith_delta_eq_succ_carryWith]
    repeat rw [carryWith_delta_eq_delta_carryWith]
    rw [ih]
    congr! 4
    omega


theorem evalWith_add_eq_evalWith_carryWith
  (p : FSM arity) (carryState : p.α → Bool) (x : arity → BitStream) (n : Nat) :
  p.evalWith carryState x (n + m) =
  p.evalWith (p.carryWith carryState x n) (fun a i => x a (n + i)) m  := by
  conv =>
    lhs
    rw [evalWith_eq_outputWith_carryWith]
    rw [← carryWith_carryWith_eq_carryWith_add]
    rw [← evalWith_eq_outputWith_carryWith]

/-- `p.changeVars f` changes the arity of an `FSM`.
The function `f` determines how the new input bits map to the input expected by `p` -/
def changeVars {arity2 : Type} (changeVars : arity → arity2) : FSM arity2 :=
  { p with
     outputCirc := p.outputCirc.map (Sum.map id changeVars),
     nextStateCirc := fun a => (p.nextStateCirc a).map (Sum.map id changeVars)
  }

instance {α : Type _} [Hashable α] {f : α → Type _} [∀ (a : α), Hashable (f a)] : Hashable (Sigma f) where
  hash v := hash (v.fst, v.snd)

instance [Hashable α] [Hashable β] : Hashable (Sum α β) where
  hash
  | .inl a => hash (false, a)
  | .inr b => hash (true, b)

/--
Given an FSM `p` of arity `n`,
a family of `n` FSMs `qᵢ` of posibly different arities `mᵢ`,
and given yet another arity `m` such that `mᵢ ≤ m` for all `i`,
we can compose `p` with `qᵢ` yielding a single FSM of arity `m`,
such that each FSM `qᵢ` computes the `i`th bit that is fed to the FSM `p`. -/
def compose [FinEnum arity] [DecidableEq arity] [Hashable arity]
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
    outputCirc :=
      (p.outputCirc).bind
        (Sum.elim
          (fun a => Circuit.var true (inl (inl a)))
          (fun a => ((q a).outputCirc).map
            (Sum.elim (fun d => (inl (inr ⟨a, d⟩))) (fun q => inr (vars a q)))))
    nextStateCirc := fun x =>
      match x with
      | (inl a) =>
        (p.nextStateCirc (a)).bind
          (Sum.elim
            (fun a => Circuit.var true (inl (inl a)))
            (fun a => ((q a).outputCirc).map
            (Sum.elim (fun d => (inl (inr ⟨a, d⟩))) (fun q => inr (vars a q)))))
      | inr ⟨x, y⟩ =>
          ((q x).nextStateCirc (y)).map
            (Sum.elim
              (fun a => inl (inr ⟨_, a⟩))
              (fun a => inr (vars x a))) }

lemma carry_compose [FinEnum arity] [DecidableEq arity] [Hashable arity]
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
        · simp [Circuit.eval_map]
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
lemma eval_compose [FinEnum arity] [DecidableEq arity] [Hashable arity]
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

instance : Hashable Empty where
  hash x := x.elim

def and : FSM Bool :=
  { α := Empty,
    initCarry := Empty.elim,
    nextStateCirc := fun a => a.elim,
    outputCirc := Circuit.var true (inr true) &&& Circuit.var true (inr false),
  }

@[simp] lemma eval_and (x : Bool → BitStream) : and.eval x = (x true) &&& (x false) := by
  ext n; cases n <;> simp [and, eval, nextBit]

def or : FSM Bool :=
  { α := Empty,
    initCarry := Empty.elim,
    outputCirc := Circuit.var true (inr true) ||| Circuit.var true (inr false),
    nextStateCirc := fun a => a.elim
  }

@[simp] lemma eval_or (x : Bool → BitStream) : or.eval x = (x true) ||| (x false) := by
  ext n; cases n <;> simp [or, eval, nextBit]

def xor : FSM Bool :=
  { α := Empty,
    initCarry := Empty.elim,
    outputCirc := Circuit.var true (inr true) ^^^ Circuit.var true (inr false),
    nextStateCirc := Empty.elim
  }


/-- Equality, or alternatively, negation of the xor -/
def nxor : FSM Bool :=
  { α := Empty,
    initCarry := Empty.elim,
    nextStateCirc := Empty.elim,
    outputCirc :=
      -- x ⊕ y ⊕ T
      -- 0 ⊕ 0 ⊕ 1 = 1
      -- 0 ⊕ 1 ⊕ 1 = 0 -- value is 0 iff they differ
      -- 1 ⊕ 0 ⊕ 1 = 0 -- value is 1 iff they differ.
      -- 1 ⊕ 1 ⊕ 1 = 1
      (Circuit.tru ^^^
        ( (Circuit.var true (inr true)) ^^^
        (Circuit.var true (inr false))))
  }

def simplify (p : FSM arity) : FSM arity := p

/-- Evaluating the value after `simplify` is the same as the original value. -/
@[simp] lemma eval_simplify :
    p.simplify.eval = p.eval := rfl

instance : Hashable Unit where
  hash _ := 42


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
   outputCirc := Circuit.var true (inl ()) &&& Circuit.var true (inr ()),
   nextStateCirc := fun () => (Circuit.var true (inl ())) &&& (Circuit.var true (inr ()))
  }

@[simp]
lemma eval_scanAnd_zero (x : Unit → BitStream) : scanAnd.eval x 0 = (x () 0) := by
  simp [eval, nextBit, scanAnd, carry]

@[simp]
lemma eval_scanAnd_succ (x : Unit → BitStream) (n : Nat) :
    (scanAnd.eval x (n+1)) = ((scanAnd.eval x n) && (x () (n+1)))  := by
  simp [eval, nextBit, scanAnd, carry]

/-- The result of `scanAnd` is true at `n` iff the bitvector has been true upto (and including) `n`. -/
@[simp] lemma eval_scanAnd_true_iff (x : Unit → BitStream) (n : Nat) : scanAnd.eval x n = true ↔ (∀ (i : Nat), (hi : i ≤ n) → x () i = true) := by
  induction n
  case zero => simp [eval, nextBit, scanAnd, carry]
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

/-- The result of `scanAnd` is true at `n` iff the bitvector has been true upto (and including) `n`. -/
lemma eval_scanAnd_eq_decide (x : Unit → BitStream) (n : Nat) : scanAnd.eval x n =
  decide (∀ (i : Nat), (hi : i ≤ n) → x () i = true) := by
  have := eval_scanAnd_true_iff x n
  by_cases hscan : scanAnd.eval x n
  · simp only [hscan, true_iff, true_eq_decide_iff] at this ⊢;
    apply this
  · simp only [hscan, Bool.false_eq_true, false_iff, not_forall,
    Bool.not_eq_true, false_eq_decide_iff] at this ⊢
    apply this

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
   outputCirc := Circuit.var true (inl ()) ||| Circuit.var true (inr ()),
   nextStateCirc := fun () => Circuit.var true (inl ()) ||| Circuit.var true (inr ())
  }

@[simp]
lemma eval_scanOr_zero (x : Unit → BitStream) : scanOr.eval x 0 = (x () 0) := by
  simp [eval, nextBit, scanOr, carry]

@[simp]
lemma eval_scanOr_succ (x : Unit → BitStream) (n : Nat) :
    (scanOr.eval x (n+1)) = ((scanOr.eval x n) || (x () (n+1)))  := by
  simp [eval, nextBit, scanOr, carry]

/-- The result of `scanOr` is false at `n` iff the bitvector has been false upto (and including) time `n`. -/
@[simp] lemma eval_scanor_false_iff (x : Unit → BitStream) (n : Nat) : scanOr.eval x n = false ↔ (∀ (i : Nat), (hi : i ≤ n) → x () i = false) := by
  induction n
  case zero => simp [eval, nextBit, scanOr, carry]
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
    nextStateCirc := fun () =>
      Circuit.var true (inr true) &&& Circuit.var true (inr false) |||
      Circuit.var true (inr true) &&& Circuit.var true (inl ()) |||
      Circuit.var true (inr false) &&& Circuit.var true (inl ()),
    outputCirc := Circuit.var true (inr true) ^^^
                  Circuit.var true (inr false) ^^^
                  Circuit.var true (inl ()),
  }

def map (fsm : FSM arity) (f : arity → arity') : FSM arity' where
  α := fsm.α
  initCarry := fsm.initCarry
  outputCirc := fsm.outputCirc.map (Sum.map id f)
  nextStateCirc := fun s =>
    fsm.nextStateCirc s |>.map (Sum.map id f)

instance : Functor FSM where
  map f fsm :=  fsm.map f

theorem add_nextStateCirc_eval :
    (add.nextStateCirc ()).eval =
      fun x => x (inr true) && x (inr false) || x (inr true)
        && x (inl ()) || x (inr false) && x (inl ()) := by
  ext x
  simp +ground [add, Circuit.simplifyAnd, Circuit.simplifyOr]

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
    simp [add_nextStateCirc_eval, nextBit, ih, BitStream.addAux, BitVec.adcb]

@[simp] theorem carry_zero (x : arity → BitStream) : carry p x 0 = p.initCarry := rfl
@[simp] theorem initCarry_add : add.initCarry = (fun _ => false) := rfl

@[simp] lemma eval_add (x : Bool → BitStream) : add.eval x = (x true) + (x false) := by
  ext n
  simp only [eval]
  cases n
  · show Bool.xor _ _ = Bool.xor _ _; simp
  · rw [carry_add_succ]
    conv => {rhs; simp only [(· + ·), BitStream.add, Add.add, BitStream.addAux, BitVec.adcb]}
    simp [nextBit, add]
/-!
We don't really need subtraction or negation FSMs,
given that we can reduce both those operations to just addition and bitwise complement -/

def sub : FSM Bool :=
  { α := Unit,
    initCarry := fun _ => false,
    outputCirc := Circuit.var true (inr true) ^^^
                  Circuit.var true (inr false) ^^^
                  Circuit.var true (inl ()),
    nextStateCirc := fun _ =>
      (Circuit.var false (inr true) &&& Circuit.var true (inr false)) |||
      (Circuit.var false (inr true) ^^^ Circuit.var true (inr false)) &&&
      (Circuit.var true (inl ()))
  }

theorem carry_sub (x : Bool → BitStream) : ∀ (n : ℕ), sub.carry x (n+1) =
    fun _ => (BitStream.subAux (x true) (x false) n).2
  | 0 => by
    simp [carry, nextBit, BitStream.subAux, sub]
  | n+1 => by
    rw [carry, carry_sub _ n]
    simp [nextBit, sub, BitStream.subAux]

@[simp]
theorem eval_sub (x : Bool → BitStream) : sub.eval x = (x true) - (x false) := by
  simp only [(· - ·), Sub.sub]
  ext n
  cases n
  · simp [eval, sub, nextBit, BitStream.sub, BitStream.subAux, carry]
  · rw [eval, carry_sub]
    simp [nextBit, sub, BitStream.sub, BitStream.subAux]

/-!
We define a borrow automata, whose output stream is the internal state of the subtraction automata,
which is the bits to be borrowed.

Compare against subAux.2
-/

def borrow : FSM Bool :=
  { α := Unit,
    -- Internal state is the current borrow.
    initCarry := fun _ => false,
    outputCirc :=
      let borrow := Circuit.var true (inl ())
      let a := Circuit.var true (inr true)
      let nota := Circuit.var false (inr true)
      let b := Circuit.var true (inr false)
      (nota &&& b/- !a && b-/) |||
      ((~~~ (a ^^^ b) /- !(xor a b) -/) &&& borrow)
    nextStateCirc := fun () =>
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
      ((~~~ (a ^^^ b) /- !(xor a b) -/) &&& borrow)
  }

/--
The carry state of the borrow bit.
TODO: rewrite with 'induction' to be a clean proof script.
-/
@[simp] theorem carry_borrow (x : Bool → BitStream) : ∀ (n : ℕ), borrow.carry x (n+1) =
    fun _ => (x true).borrow (x false) n := by
  intros n
  induction n
  case zero =>
    ext i
    simp [carry, nextBit, borrow]
  case succ n ih =>
    rw [carry, ih]
    simp [nextBit, borrow]


@[simp] lemma eval_borrow (x : Bool → BitStream) : borrow.eval x = (x true).borrow (x false) := by
  ext i
  induction i
  case zero =>
    simp [borrow, BitStream.borrow, BitStream.subAux, eval, nextBit]
  case succ i ih =>
    rw [eval]
    simp only [carry_borrow, BitStream.borrow_succ, Bool.not_bne']
    rw [← ih]
    simp [nextBit, eval, borrow]

def neg : FSM Unit :=
  { α := Unit,
    i := by infer_instance,
    initCarry := λ _ => true,
    outputCirc :=
      Circuit.var false (inr ()) ^^^ Circuit.var true (inl ())
    nextStateCirc := fun () =>
      Circuit.var false (inr ()) &&& Circuit.var true (inl ())
  }

theorem carry_neg (x : Unit → BitStream) : ∀ (n : ℕ), neg.carry x (n+1) =
    fun _ => (BitStream.negAux (x ()) n).2
  | 0 => by
    simp [carry, nextBit, BitStream.negAux, neg]
  | n+1 => by
    rw [carry, carry_neg _ n]
    simp [nextBit, neg, BitStream.negAux]

@[simp] lemma eval_neg (x : Unit → BitStream) : neg.eval x = -(x ()) := by
  show _ = BitStream.neg _
  ext n
  cases n
  · simp [eval, neg, nextBit, BitStream.neg, BitStream.negAux, carry]
  · rw [eval, carry_neg]
    simp [nextBit, neg, BitStream.neg, BitStream.negAux]

def not : FSM Unit :=
  { α := Empty,
    initCarry := Empty.elim,
    nextStateCirc := Empty.elim,
    outputCirc := Circuit.var false (inr ())
  }

@[simp] lemma eval_not (x : Unit → BitStream) : not.eval x = ~~~(x ()) := by
  ext; simp [eval, not, nextBit]

def zero : FSM (Fin 0) :=
  { α := Empty,
    initCarry := Empty.elim,
    nextStateCirc := Empty.elim,
    outputCirc := Circuit.fals
  }

@[simp] lemma eval_zero (x : Fin 0 → BitStream) : zero.eval x = BitStream.zero := by
  ext; simp [zero, eval, nextBit]

def one : FSM (Fin 0) :=
  { α := Unit,
    i := by infer_instance,
    initCarry := λ _ => true,
    outputCirc := Circuit.var true (inl ()),
    nextStateCirc := fun () => Circuit.fals
  }

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
    nextStateCirc := Empty.elim,
    outputCirc := Circuit.tru
  }

@[simp] lemma eval_negOne (x : Fin 0 → BitStream) : negOne.eval x = BitStream.negOne := by
  ext; simp [negOne, eval, nextBit]

/--
An FSM whose first output is `b`, and later outputs are whatever the input is.
-/
def ls (b : Bool) : FSM Unit :=
  { α := Unit,
    initCarry := fun _ => b,
    nextStateCirc := fun () => Circuit.var true (inr ()),
    outputCirc := Circuit.var true (inl ())
  }

theorem carry_ls (b : Bool) (x : Unit → BitStream) : ∀ (n : ℕ),
    (ls b).carry x (n+1) = fun _ => x () n
  | 0 => by
    simp [carry, nextBit, ls]
  | n+1 => by
    rw [carry, carry_ls _ _ n]
    simp [nextBit, ls]

@[simp] lemma eval_ls (b : Bool) (x : Unit → BitStream) :
    (ls b).eval x = (x ()).concat b := by
  ext n
  cases n
  · rfl
  · simp [ls, eval, nextBit, BitStream.concat, carry]

def var (n : ℕ) : FSM (Fin (n+1)) :=
  { α := Empty,
    i := by infer_instance,
    initCarry := Empty.elim,
    nextStateCirc := Empty.elim
    outputCirc := Circuit.var true (inr (Fin.last _))
  }

@[simp] lemma eval_var (n : ℕ) (x : Fin (n+1) → BitStream) : (var n).eval x = x (Fin.last n) := by
  ext m; cases m <;> simp [var, eval, carry, nextBit]

def var' (i : arity) : FSM arity :=
  { α := Empty,
    i := by infer_instance,
    initCarry := Empty.elim,
    nextStateCirc := Empty.elim
    outputCirc := Circuit.var true (inr i)
  }

@[simp] lemma eval_var' (i : arity) (x : arity → BitStream) : (var' i).eval x = x i := by
  ext; simp [var', eval, nextBit]

def incr : FSM Unit :=
  { α := Unit,
    initCarry := fun _ => true,
    outputCirc :=
      (Circuit.var true (inr ())) ^^^ (Circuit.var true (inl ()))
    nextStateCirc := fun () =>
      (Circuit.var true (inr ())) &&& (Circuit.var true (inl ()))
  }

theorem carry_incr (x : Unit → BitStream) : ∀ (n : ℕ),
    incr.carry x (n+1) = fun _ => (BitStream.incrAux (x ()) n).2
  | 0 => by
    simp [carry, nextBit, BitStream.incrAux, incr]
  | n+1 => by
    rw [carry, carry_incr _ n]
    simp [nextBit, incr, incr, BitStream.incrAux]

@[simp] lemma eval_incr (x : Unit → BitStream) : incr.eval x = (x ()).incr := by
  ext n
  cases n
  · simp [eval, incr, nextBit, carry, BitStream.incr, BitStream.incrAux]
  · rw [eval, carry_incr]; rfl

def decr : FSM Unit :=
  { α := Unit,
    i := by infer_instance,
    initCarry := λ _ => true,
    outputCirc :=
      (Circuit.var true (inr ())) ^^^ (Circuit.var true (inl ()))
    nextStateCirc := fun () => (Circuit.var false (inr ())) &&& (Circuit.var true (inl ()))
  }

theorem carry_decr (x : Unit → BitStream) : ∀ (n : ℕ), decr.carry x (n+1) =
    fun _ => (BitStream.decrAux (x ()) n).2
  | 0 => by
    simp [carry, nextBit, BitStream.decrAux, decr]
  | n+1 => by
    rw [carry, carry_decr _ n]
    simp [nextBit, decr, BitStream.decrAux]

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
  outputCirc :=  (.var true <| .inl ()) ||| (.var true <| .inr ())
  nextStateCirc := fun () => (.var true <| .inl ()) ||| (.var true <| .inr ())
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

def composeBinaryAux'
    (p : FSM Bool)
    (q₁ : FSM α)
    (q₂ : FSM α) :
    FSM α :=
  p.compose (α)
    (λ _ => α)
    (λ _ i => i)
    (λ b => match b with
      | true => q₁
      | false => q₂)

def composeTernaryAux' (p : FSM (Fin 3)) (q₀ q₁ q₂ : FSM α) : FSM α :=
  p.compose (α)
    (λ _ => α)
    (λ _ i => i)
    (λ v =>
      v.cases q₀ fun v =>
        v.cases q₁ fun v =>
          v.cases q₂ fun v => v.elim0)

def composeQuaternaryAux' (p : FSM (Fin 4)) (q₀ q₁ q₂ q₃ : FSM α) : FSM α :=
  p.compose (α)
    (λ _ => α)
    (λ _ i => i)
    (λ v =>
      v.cases q₀ fun v =>
        v.cases q₁ fun v =>
          v.cases q₂ fun v =>
            v.cases q₃ fun v => v.elim0)

def composeQuinaryAux' (p : FSM (Fin 5)) (q₀ q₁ q₂ q₃ q₄: FSM α) : FSM α :=
  p.compose (α)
    (λ _ => α)
    (λ _ i => i)
    (λ v =>
      v.cases q₀ fun v =>
        v.cases q₁ fun v =>
          v.cases q₂ fun v =>
            v.cases q₃ fun v =>
              v.cases q₄ fun v => v.elim0)


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
  simp [composeUnary, q.good]

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

@[simp] lemma composeBinaryAux'_eval
    (p : FSM Bool)
    (q₁ : FSM s)
    (q₂ : FSM s)
    (x : s → BitStream) :
    (composeBinaryAux' p q₁ q₂).eval x = p.eval
      (λ b => cond b (q₁.eval (fun i => x i))
                  (q₂.eval (fun i => x i))) := by
  rw [composeBinaryAux', FSM.eval_compose]
  ext b
  cases b <;> dsimp <;> congr <;> funext b <;> cases b <;> simp


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
--   | 1 => FSM.one
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

/-- Build a finite state machine for the integer `i` -/
def ofInt (x : Int) : FSM (Fin 0) :=
  match x with
  | .ofNat n => ofNat n
  | .negSucc n =>
      composeUnaryAux neg (ofNat (n + 1))

/--
The result of `FSM.ofInt x` matches with `BitStream.ofInt x`.
-/
theorem eval_ofInt (x : Int) (i : Nat) {env : Fin 0 → BitStream} :
    (ofInt x).eval env i = BitStream.ofInt x i := by
  rcases x with x | x
  · simp [ofInt, BitStream.ofInt]
  · simp only [ofInt, composeUnaryAux_eval, eval_neg, BitStream.ofInt]
    -- TODO: why does 'congr' not work here?
    apply congrFun
    apply congrArg
    ext i
    simp


/-- Identity finite state machine -/
def id : FSM Unit := {
 α := Empty,
 initCarry := Empty.elim,
 outputCirc := Circuit.var true (inr ()),
 nextStateCirc := Empty.elim
}

@[simp]
def eval_id (env: Unit → BitStream) (i : Nat) : id.eval env i = (env ()) i := rfl

/-- Build logical shift left automata by `n` bits -/
def shiftLeft (n : Nat) : FSM Unit :=
  match n with
  | 0 => FSM.id
  | n + 1 => composeUnaryAux (FSM.ls false) (shiftLeft n)

@[simp]
theorem eval_shiftLeft (k : Nat) (env : Unit → BitStream) (i : Nat) :
    (shiftLeft k).eval env i = ((decide (k ≤ i)) && ((env ()) (i - k))) := by
  induction k generalizing i
  case zero =>
    simp [shiftLeft]
  case succ k ih =>
    simp[shiftLeft]
    rcases i with rfl | i
    · simp
    · simp [ih]

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
@[simp] theorem eval_falseAfterIncluding (n : Nat) (i : Nat) {env : Fin 0 → BitStream} :
    (falseAfterIncluding n).eval env i = decide (i < n) := by
  simp [falseAfterIncluding]

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
@[simp] theorem eval_falseAfterExcluding (n : Nat) (i : Nat) {env : Fin 0 → BitStream} :
    (falseAfterExcluding n).eval env i = decide (i ≤ n) := by simp [falseAfterExcluding]

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
  | shiftL t k =>
     let q := termEvalEqFSM t
     {
       toFSM := by dsimp [arity]; exact composeUnary (FSM.shiftLeft k) q,
       good := by
         ext x i
         simp only [evalFin, BitStream.eval_shiftLeft, Bool.if_false_left, arity.eq_13, id_eq,
           composeUnary_eval, FSM.eval_shiftLeft]
         by_cases hi : i < k
         · simp [hi]
         · simp [hi]; omega
     }

/-!
FSM that implement bitwise-and. Since we use `0` as the good state,
we keep the invariant that if both inputs are good and our state is `0`, then we produce a `0`.
If not, we produce an infinite sequence of `1`.
-/
def and : FSM Bool :=
  { α := Unit,
    initCarry := fun () => false,
    nextStateCirc := fun () =>
      -- Only if both are `0` we produce a `0`.
      (Circuit.var true (inr false)  |||
      ((Circuit.var false (inr true) |||
      -- But if we have failed and have value `1`, then we produce a `1` from our state.
      (Circuit.var true (inl ())))))
    outputCirc := -- must succeed in both arguments, so we are `0` if both are `0`.
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
    nextStateCirc := fun () =>
      -- If either succeeds, then the full thing succeeds
      ((Circuit.var true (inr false)  &&&
      ((Circuit.var false (inr true)) |||
      -- On the other hand, if we have failed, then propagate failure.
      (Circuit.var true (inl ())))))
    outputCirc :=-- can succeed in either argument, so we are `0` if either is `0`.
      Circuit.var true (inr true) &&&
      Circuit.var true (inr false)
  }

/-- An `FSMPredicateSolution `t` is an FSM with a witness that the FSM evaluates to the same value as `t` does -/
structure FSMPredicateSolution (p : Predicate) extends FSM (Fin p.arity) where
  ( good : p.evalFin = toFSM.eval )


def fsmUlt (a : FSM (Fin k)) (b : FSM (Fin l)) : FSM (Fin (k ⊔ l)) :=
  composeUnaryAux (FSM.ls true) <| (composeUnaryAux FSM.not <| composeBinaryAux FSM.borrow a b)

@[simp]
theorem eval_fsmUlt_eq_evalFin_Predicate_ult (t₁ t₂ : Term) :
   (fsmUlt (termEvalEqFSM t₁).toFSM (termEvalEqFSM t₂).toFSM).eval = (Predicate.binary .ult t₁ t₂).evalFin  := by
  ext x i
  generalize ha : termEvalEqFSM t₁ = a
  generalize hb : termEvalEqFSM t₂ = b
  simp [fsmUlt, Predicate.evalUlt, a.good, b.good]

def fsmEq (a : FSM (Fin k)) (b : FSM (Fin l)) : FSM (Fin (k ⊔ l)) :=
  composeUnaryAux FSM.scanOr <| composeUnaryAux (FSM.ls false) <|  composeBinaryAux FSM.xor a b

/-- Evaluation FSM.eq is the same as evaluating Predicate.eq.evalFin. -/
@[simp]
theorem eval_fsmEq_eq_evalFin_Predicate_eq (t₁ t₂ : Term) :
   (fsmEq (termEvalEqFSM t₁).toFSM (termEvalEqFSM t₂).toFSM).eval = (Predicate.binary .eq t₁ t₂).evalFin  := by
  ext x i
  generalize ha : termEvalEqFSM t₁ = a
  generalize hb : termEvalEqFSM t₂ = b
  simp [fsmEq, Predicate.evalEq, a.good, b.good]

def fsmNeq (a : FSM (Fin k)) (b : FSM (Fin l)) : FSM (Fin (k ⊔ l)) :=
  composeUnaryAux FSM.scanAnd <| composeUnaryAux (FSM.ls true) <| composeBinaryAux FSM.nxor a b

/-- Evaluation FSM.eq is the same as evaluating Predicate.eq.evalFin. -/
@[simp]
theorem eval_fsmNeq_eq_evalFin_Predicate_neq (t₁ t₂ : Term) :
   (fsmNeq (termEvalEqFSM t₁).toFSM (termEvalEqFSM t₂).toFSM).eval = (Predicate.binary .neq t₁ t₂).evalFin  := by
  ext x i
  generalize ha : termEvalEqFSM t₁ = a
  generalize hb : termEvalEqFSM t₂ = b
  simp [fsmNeq, Predicate.evalNeq, a.good, b.good]

def fsmLand (a : FSM (Fin k)) (b : FSM (Fin l)) : FSM (Fin (k ⊔ l)) :=
  composeBinaryAux FSM.or a b

def fsmLor (a : FSM (Fin k)) (b : FSM (Fin l)) : FSM (Fin (k ⊔ l)) :=
  composeBinaryAux FSM.and a b

def fsmUle (a : FSM (Fin k)) (b : FSM (Fin l)) : FSM (Fin (k ⊔ l ⊔ (k ⊔ l))) :=
  let ult := fsmUlt a b
  let eq := fsmEq a b
  fsmLor ult eq


def fsmMsbEq (a : FSM (Fin k)) (b : FSM (Fin l)) : FSM (Fin (k ⊔ l)) :=
  composeUnaryAux (FSM.ls false) <| composeBinaryAux FSM.xor a b

-- theorem fsmMsbNeq_eq_Predicate_MsbNeq (t₁ t₂ : Term) :
--   (Predicate.msbNeq t₁ t₂).evalFin = (fsmMsbNeq (termEvalEqFSM t₁).toFSM (termEvalEqFSM t₂).toFSM).eval := sorry

def fsmSlt (a : FSM (Fin k)) (b : FSM (Fin l)) : FSM (Fin (k ⊔ l ⊔ (k ⊔ l))) :=
  let msbCheck := fsmMsbEq a b
  let ult := fsmUlt a b
  composeBinaryAux FSM.xor ult msbCheck

/--
TODO: implement FSM.cast so we don't need to accumulate `max`s in this godforsaken fashion.
This needs a `Circuit.cast` as well, so we do this after we have verified end-to-end
correctness.
-/
def fsmSle (a : FSM (Fin k)) (b : FSM (Fin l)) : FSM (Fin (k ⊔ l ⊔ (k ⊔ l) ⊔ (k ⊔ l))) :=
  let slt := fsmSlt a b
  let eq := fsmEq a b
  let out := fsmLor slt eq
  out


/--
Evaluating the eq predicate equals the FSM value.
Note that **this is the value that is run by decide**.
-/
def predicateEvalEqFSM : ∀ (p : Predicate), FSMPredicateSolution p
  | .width .eq n =>
    {
      toFSM := FSM.falseOnlyAt n
      good := by
        ext i x
        simp only [Predicate.evalFin, Bool.decide_eq_true, Predicate.arity.eq_1,
          FSM.eval_falseOnlyAt]
        by_cases h : x = n  <;> simp [h]
    }
  | .width .neq n =>
     {
      toFSM := FSM.trueOnlyAt n
      good := by
        ext i x
        simp only [Predicate.evalFin, Bool.decide_eq_true]
        by_cases h : x = n <;> simp [h]
     }
  | .width .ge n =>
     {
      toFSM := FSM.falseAfterIncluding n
      good := by ext; simp
     }
  | .width .gt n =>
     {
      toFSM := FSM.falseAfterExcluding n
      good := by ext; simp
     }
  | .width .lt n =>
     {
      toFSM := FSM.falseUptoExcluding n
      good := by ext; simp
     }
  | .width .le n =>
     {
      toFSM := FSM.falseUptoIncluding n
      good := by ext; simp
     }
  | .binary .eq t₁ t₂ =>
    let t₁ := termEvalEqFSM t₁
    let t₂ := termEvalEqFSM t₂
    {
     -- At width 0, all things are equal.
     toFSM := fsmEq t₁.toFSM t₂.toFSM
     good := by
      ext x i
      rw [eval_fsmEq_eq_evalFin_Predicate_eq]
    }
  | .binary .neq t₁ t₂ =>
    let t₁ := termEvalEqFSM t₁
    let t₂ := termEvalEqFSM t₂
    {
     -- At width 0, all things are equal, so the predicate is untrue.
     -- If it ever becomes `0`, it should stay `0` forever, because once
     -- two bitstreams become disequal, they stay disequal!
     toFSM := fsmNeq t₁.toFSM t₂.toFSM
     good := by ext; rw [eval_fsmNeq_eq_evalFin_Predicate_neq]
    }
   | .land p q =>
     let x₁ := predicateEvalEqFSM p
     let x₂ :=  predicateEvalEqFSM q
     {
       -- If this ever becomes `1`, it should stay `1`,
       -- since once it's falsified, it should stay falsified!
       toFSM := fsmLand x₁.toFSM x₂.toFSM
       good := by ext x i; simp [Predicate.evalLand, fsmLand, x₁.good, x₂.good]
     }
   | .lor p q =>
     let x₁ := predicateEvalEqFSM p
     let x₂ :=  predicateEvalEqFSM q
     {
       -- If it ever becomes `1`, it should stay `1`,
       -- since one it's falsified, it should stay falsified!
       toFSM := fsmLor  x₁.toFSM x₂.toFSM
       good := by ext x i; simp [Predicate.evalLor, fsmLor, x₁.good, x₂.good]
     }
   | .binary .slt t₁ t₂ =>
     let a := termEvalEqFSM t₁
     let b := termEvalEqFSM t₂
     { toFSM := fsmSlt a.toFSM b.toFSM
       good := by
        ext;
        simp [Predicate.evalSlt, fsmSlt, Predicate.evalUlt, fsmUlt, Predicate.evalMsbEq, fsmMsbEq,
          a.good, b.good]
     }
   | .binary .sle t₁ t₂ =>
      let a := termEvalEqFSM t₁
      let b := termEvalEqFSM t₂
      {
        toFSM := fsmSle a.toFSM b.toFSM
        good := by
          ext x i
          simp [fsmSle, Predicate.evalLor, fsmLor, Predicate.evalSlt, fsmSlt, Predicate.evalUlt,
            fsmUlt, Predicate.evalMsbEq, fsmMsbEq, Predicate.evalEq, fsmEq, a.good, b.good]
      }
   | .binary .ult t₁ t₂ =>
      let a := termEvalEqFSM t₁
      let b := termEvalEqFSM t₂
      let out := {
       -- a <u b if when we compute (a - b), we must borrow a value.
       toFSM := fsmUlt a.toFSM b.toFSM
       good := by
         ext x i
         simp [fsmUlt, a.good, b.good, Predicate.evalUlt]
      }
      out
   | .binary .ule t₁ t₂ =>
      let a := termEvalEqFSM t₁
      let b := termEvalEqFSM t₂
      {
        toFSM := fsmUle a.toFSM b.toFSM
        good := by
          ext x i
          simp [fsmUle, fsmUlt, fsmEq, fsmLor, a.good, b.good, Predicate.evalLor, Predicate.evalUlt, Predicate.evalEq]
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


-- c: circuit that produces output upto the k-th state.
def decideIfZerosAux {arity : Type _} [DecidableEq arity]
    (p : FSM arity) (c : Circuit p.α) : Bool :=
  -- c = false ↔ ∀ i < n, ∀ env, p.eval env i = 0
  if c.eval p.initCarry -- check that ∀ i < n, p.eval env i = 0.
  then false -- violation.
  else
    -- compute circuit that produces output at the (k+1)th state.
    -- [c' = false] ↔ ∀ i < (n + 1), ∀ env, p.eval env i = 0
    have c' := (c.bind (p.nextStateCirc)).fst
    if h : c' ≤ c then true
    else
      have _wf : card_compl (c' ||| c) < card_compl c :=
        decideIfZeroAux_wf h
      decideIfZerosAux p (c' ||| c)
  termination_by card_compl c

-- |- decideIfZerosAux p c = true

-- sym_eval_circ_le:
--    (c₁ c₂: Circuit α) c₁ ≤ c₂ --tactic[ <cadical, reflection, etc>]-->t/f
--
-- repeat (simp [decideIfZerosAux];
--    rw [sym_eval_circ_le];
--    (rw [decideIfZerosAux_le_true] <|> rw [decideIfZerosAux_le_false]);
--  )
--

--  decideIfZerosAux p (c ||| (c.bind (p.nextBitCirc ∘ some)).fst) = true
--
-- reduce (c ||| c') to NF -> expensive, complex. Price we pay for metaprogramming.


def decideIfZerosAuxM {arity : Type _} [DecidableEq arity] [Monad m]
    (decLe : {α : Type} → [DecidableEq α] → [Fintype α] → [Hashable α] →
        (c : Circuit α) → (c' : Circuit α) → m { b : Bool // b ↔ c ≤ c' })
    (p : FSM arity) (c : Circuit p.α) : m Bool := do
  if c.eval p.initCarry
  then return false
  else
    have c' := (c.bind (p.nextStateCirc)).fst
    let le ← decLe c' c
    if h : le then return true
    else
      have _wf : card_compl (c' ||| c) < card_compl c :=
        have := le.prop
        have hNotLt : ¬ c' ≤ c := by
          simp at h
          have := this.not
          simp at this
          exact this.mp h
        decideIfZeroAux_wf hNotLt
      decideIfZerosAuxM decLe p (c' ||| c)
  termination_by card_compl c

-- theorem decideIfZerosAuxM_decLe_true :
-- rw [decideIfZerosAuxM_decLe_true proof_from_cadical]
-- rw [decideIfZerosAuxM_decLe_false proof_from_cadical]

/--
The monadic version is equivalent to 'decideIfZerosAux',
if the monad used is `Id` and the comparator that is used is the usual `≤` operation.
-/
theorem decideIfZerosAuxM_Id_eq_decideIfZerosAux {arity : Type _}
    (p : FSM arity) [DecidableEq arity] [Fintype arity] (c : Circuit p.α) :
    decideIfZerosAuxM (m := Id) (decLe := fun c c' =>
      let b := c ≤ c'
      ⟨b, by simp [b]⟩
    ) p c = decideIfZerosAux p c := by
  rw [decideIfZerosAuxM, decideIfZerosAux]
  by_cases h : c.eval p.initCarry
  case pos => simp [h]; rfl
  case neg =>
    simp [h]
    clear h
    by_cases h : (c.bind (p.nextStateCirc)).fst ≤ c
    case pos =>
      simp [h]
      rfl
    case neg =>
      simp [h]
      have _wf :=  decideIfZeroAux_wf h
      apply decideIfZerosAuxM_Id_eq_decideIfZerosAux
  termination_by card_compl c


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
        simp [FSM.nextBit]
        apply h'
      · assumption
      · exact hc₂
    · let c' := (c.bind (p.nextStateCirc)).fst
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
        simp only [FSM.nextBit, Nat.rec_zero]
      · exact hc _ h
      · intro x s h
        have := hc₂ _ _ h
        simp only [Bool.or_eq_true, Circuit.eval_or, this, or_true]
termination_by card_compl c


def decideIfZerosAuxUnverified {σ ι : Type _}
    [DecidableEq σ] [Fintype σ] [DecidableEq ι]
    (s0 : σ → Bool)  (π : Circuit σ) (δ : σ → Circuit (σ ⊕ ι)) : Bool :=
  if π.eval s0
  then false
  else
    have π' := (π.bind δ).fst
    if h : π' ≤ π then true
    else
      have _wf : card_compl (π' ||| π) < card_compl π :=
        decideIfZeroAux_wf h
      decideIfZerosAuxUnverified s0 (π' ||| π) δ
  termination_by card_compl π


def FSM.optimize {arity : Type _} (p : FSM arity) [DecidableEq arity] : FSM arity :=
  p

def decideIfZeros {arity : Type _} [DecidableEq arity]
    (p : FSM arity) : Bool :=
  decideIfZerosAux p (p.outputCirc).fst

def decideIfZerosM {arity : Type _} [DecidableEq arity] [Monad m]
    (decLe : {α : Type} → [DecidableEq α] → [Fintype α] → [Hashable α] →
        (c : Circuit α) → (c' : Circuit α) → m { b : Bool // b ↔ c ≤ c' })
    (p : FSM arity) : m Bool :=
  decideIfZerosAuxM decLe p (p.outputCirc).fst


theorem decideIfZeros_correct {arity : Type _} [DecidableEq arity]
    (p : FSM arity) : decideIfZeros p = true ↔ ∀ n x, p.simplify.eval x n = false := by
  simp only [FSM.eval_simplify]
  simp [decideIfZeros]
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
    (fsm : FSM arity) (n : Nat) : Circuit fsm.α := -- given initial state, produce output.
  match n with
  | 0 =>
     -- | the .fst performs quantifier elimination, by running over all possible values of inputs.
    fsm.outputCirc |>.fst
  | n' + 1 =>
     let c := fsm.nextBitCircIterate n'
     -- | for each input, compute the next bit circuit, quantifier eliminate it for all inputs, and then compose.
     let c' := (c.bind (fsm.nextStateCirc)).fst
     c'

/-- Decide if the FSM produces zeroes for all inputs at a given index of the bitstream -/
def decideIfZerosAtIxOld {arity : Type _} [DecidableEq arity]
      (fsm : FSM arity) (w : Nat) : Bool :=
    let c := fsm.nextBitCircIterate w
    -- evaluate at the initial carry bit.
    c.eval fsm.initCarry

/-- Decide if the FSM produces zeroes for all inputs at a given index of the bitstream -/
def decideIfZerosAtIxAux {arity : Type _} [DecidableEq arity]
      (fsm : FSM arity) (c : Circuit fsm.α) (nItersLeft : Nat) : Bool :=
    if (c.eval fsm.initCarry)
    then false
    else
      match nItersLeft with
      | 0 => true -- c has accumulated the effects so far.
      | nItersLeft' + 1 =>
        -- accumulate one iteration
        have c' := (c.bind (fsm.nextStateCirc)).fst
        if _ : c' ≤ c
        then true
        else decideIfZerosAtIxAux fsm (c' ||| c) nItersLeft'

def decideIfZerosAtIx {arity : Type _} [DecidableEq arity]
      (fsm : FSM arity) (w : Nat) : Bool :=
    decideIfZerosAtIxAux fsm (fsm.outputCirc).fst w
/--
The correctness statement of decideIfZeroesAtIx.
This tells us that decideIfZeroesAtIx is correct iff the FSM 'p' when evaluated returns false
for all inputs at the index 'w' of the bitstream.

We file this as a separate axiom
-/
axiom decideIfZeroesAtIx_correct {arity : Type _} [DecidableEq arity]
    (p : FSM arity) (w : Nat) : decideIfZerosAtIx p w = true ↔ ∀ (x : arity → BitStream), p.eval x w = false

end FSM
