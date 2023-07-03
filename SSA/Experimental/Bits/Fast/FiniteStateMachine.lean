import Mathlib.Data.Fintype.Card
import Mathlib.Data.Fintype.Sum
import Mathlib.Data.Fintype.Sigma
import Mathlib.Data.Fintype.Pi
import Mathlib.Data.Fintype.BigOperators
import Mathlib.Tactic.Zify
import Mathlib.Tactic.Ring
import SSA.Experimental.Bits.Defs
import SSA.Experimental.Bits.Fast.Circuit

open Sum

variable {α β α' β' : Type} {γ : β → Type}

structure FSM (arity : Type) : Type 1 :=
  ( α  : Type )
  [ i : Fintype α ]
  [ dec_eq : DecidableEq α ]
  ( initCarry : α → Bool )
  ( nextBitCirc : Option α → Circuit (α ⊕ arity) )

attribute [instance] FSM.i FSM.dec_eq

namespace FSM

variable {arity : Type} (p : FSM arity)

def nextBit : (p.α → Bool) → (arity → Bool) → (p.α → Bool) × Bool :=
  fun carry bits => (fun a => (p.nextBitCirc (some a)).eval 
      (Sum.elim carry bits), 
    (p.nextBitCirc none).eval (Sum.elim carry bits)) 

def carry (x : arity → ℕ → Bool) : ℕ → p.α → Bool 
  | 0 => p.initCarry
  | n+1 => (p.nextBit (carry x n) (fun i => x i n)).1

def eval (x : arity → ℕ → Bool) (n : ℕ) : Bool := 
  (p.nextBit (p.carry x n) (fun i => x i n)).2

theorem eval_eq_carry (x : arity → ℕ → Bool) (n : ℕ) : 
  p.eval x n = (p.nextBit (p.carry x n) (fun i => x i n)).2 := by
  cases n <;> rfl

def changeVars {arity2 : Type} (changeVars : arity → arity2) :
    FSM arity2 :=
  { α := p.α,
    i := p.i,
    initCarry := p.initCarry,
    nextBitCirc := fun a => (p.nextBitCirc a).map (Sum.map id changeVars) }

def compose [Fintype arity] [DecidableEq arity]
  (new_arity : Type)
    (q_arity : arity → Type)
    (vars : ∀ (a : arity), q_arity a → new_arity)
    (q : ∀ (a : arity), FSM (q_arity a)) :
    FSM new_arity :=
  { α := p.α ⊕ (Σ a, (q a).α),
    i := by letI := p.i;  infer_instance,
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
    (x : new_arity → ℕ → Bool) : ∀ (n : ℕ),
    (p.compose new_arity q_arity vars q).carry x n = 
      let z := p.carry (λ a => (q a).eval (fun i => x (vars _ i))) n
      Sum.elim z (fun a => (q a.1).carry (fun t => x (vars _ t)) n a.2)
  | 0 => by simp [carry, compose]     
  | n+1 => by
      rw [carry, carry_compose _ _ _ _ _ n]
      ext y
      cases y
      . simp [carry, nextBit, compose, Circuit.eval_bind, eval]
        congr
        ext z
        cases z
        . simp
        . simp [Circuit.eval_map, carry]
          congr
          ext s
          cases s
          . simp
          . simp
      . simp [Circuit.eval_map, carry, compose, eval, carry, nextBit]
        congr
        ext z
        cases z
        . simp
        . simp

lemma eval_compose [Fintype arity] [DecidableEq arity]
    (new_arity : Type)
    (q_arity : arity → Type)
    (vars : ∀ (a : arity), q_arity a → new_arity)
    (q : ∀ (a : arity), FSM (q_arity a))
    (x : new_arity → ℕ → Bool) :
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
    i := by infer_instance,
    initCarry := Empty.elim,
    nextBitCirc := fun a => a.elim 
      (Circuit.and 
        (Circuit.var true (inr true)) 
        (Circuit.var true (inr false))) Empty.elim }

@[simp] lemma eval_and (x : Bool → ℕ → Bool) : and.eval x = andSeq (x true) (x false) := by
  ext n; cases n <;> simp [and, andSeq, eval, nextBit]

def or : FSM Bool :=
  { α := Empty,
    i := by infer_instance,
    initCarry := Empty.elim,
    nextBitCirc := fun a => a.elim 
      (Circuit.or 
        (Circuit.var true (inr true)) 
        (Circuit.var true (inr false))) Empty.elim }

@[simp] lemma eval_or (x : Bool → ℕ → Bool) : or.eval x = orSeq (x true) (x false) := by
  ext n; cases n <;> simp [and, orSeq, eval, nextBit]

def xor : FSM Bool :=
  { α := Empty,
    i := by infer_instance,
    initCarry := Empty.elim,
    nextBitCirc := fun a => a.elim 
      (Circuit.xor 
        (Circuit.var true (inr true)) 
        (Circuit.var true (inr false))) Empty.elim }

@[simp] lemma eval_xor (x : Bool → ℕ → Bool) : xor.eval x = xorSeq (x true) (x false) := by
  ext n; cases n <;> simp [and, xorSeq, eval, nextBit]

def add : FSM Bool :=
  { α := Unit,
    i := by infer_instance,
    initCarry := λ _ => false,
    nextBitCirc := fun a =>
      match a with
      | some () => 
             (Circuit.var true (inr true) &&& Circuit.var true (inr false)) |||
             (Circuit.var true (inr false) &&& Circuit.var true (inl ())) |||
             (Circuit.var true (inr true) &&& Circuit.var true (inl ()))
      | none => Circuit.var true (inr true) ^^^ 
                Circuit.var true (inr false) ^^^ 
                Circuit.var true (inl ()) }

theorem carry_add (x : Bool → ℕ → Bool) : ∀ (n : ℕ), add.carry x (n+1) = 
    fun _ => (addSeqAux (x true) (x false) n).2
  | 0 => by
    simp [carry, nextBit, Function.funext_iff, addSeqAux, add]
  | n+1 => by
    rw [carry, carry_add _ n]
    simp [nextBit, Function.funext_iff, addSeqAux]

@[simp] lemma eval_add (x : Bool → ℕ → Bool) : add.eval x = addSeq (x true) (x false) := by
  ext n
  cases n
  . simp [eval, add, nextBit, addSeq, addSeqAux, carry]
  . rw [eval, carry_add]
    simp [nextBit, eval, add, addSeq, addSeqAux]

def sub : FSM Bool :=
  { α := Unit,
    i := by infer_instance,
    initCarry := λ _ => false,
    nextBitCirc := fun a =>
      match a with
      | some () => 
             (Circuit.var false (inr true) &&& Circuit.var true (inr false)) |||
             ((Circuit.var false (inr true) ^^^ Circuit.var true (inr false)) &&&
              (Circuit.var true (inl ())))
      | none => Circuit.var true (inr true) ^^^ 
                Circuit.var true (inr false) ^^^ 
                Circuit.var true (inl ()) }

theorem carry_sub (x : Bool → ℕ → Bool) : ∀ (n : ℕ), sub.carry x (n+1) = 
    fun _ => (subSeqAux (x true) (x false) n).2
  | 0 => by
    simp [carry, nextBit, Function.funext_iff, subSeqAux, sub]
  | n+1 => by
    rw [carry, carry_sub _ n]
    simp [nextBit, eval, sub, subSeq, subSeqAux, Bool.xor_not_left']

@[simp]
theorem eval_sub (x : Bool → ℕ → Bool) : sub.eval x = subSeq (x true) (x false) := by
  ext n
  cases n
  . simp [eval, sub, nextBit, subSeq, subSeqAux, carry]
  . rw [eval, carry_sub]
    simp [nextBit, eval, sub, subSeq, subSeqAux]

def neg : FSM Unit :=
  { α := Unit,
    i := by infer_instance,
    initCarry := λ _ => true,
    nextBitCirc := fun a =>
      match a with
      | some () => Circuit.var false (inr ()) &&& Circuit.var true (inl ())
      | none => Circuit.var false (inr ()) ^^^ Circuit.var true (inl ())  }

theorem carry_neg (x : Unit → ℕ → Bool) : ∀ (n : ℕ), neg.carry x (n+1) = 
    fun _ => (negSeqAux (x ()) n).2
  | 0 => by
    simp [carry, nextBit, Function.funext_iff, negSeqAux, neg]
  | n+1 => by
    rw [carry, carry_neg _ n]
    simp [nextBit, eval, neg, negSeq, negSeqAux, Bool.xor_not_left']

@[simp] lemma eval_neg (x : Unit → ℕ → Bool) : neg.eval x = negSeq (x ()) := by
  ext n
  cases n
  . simp [eval, neg, nextBit, negSeq, negSeqAux, carry]
  . rw [eval, carry_neg]
    simp [nextBit, eval, neg, negSeq, negSeqAux]

def not : FSM Unit :=
  { α := Empty,
    i := by infer_instance,
    initCarry := Empty.elim,
    nextBitCirc := fun _ => Circuit.var false (inr ()) }

@[simp] lemma eval_not (x : Unit → ℕ → Bool) : not.eval x = notSeq (x ()) := by
  ext n; cases n <;> simp [eval, carry, not, notSeq, nextBit]

def zero : FSM (Fin 0) :=
  { α := Empty,
    i := by infer_instance,
    initCarry := Empty.elim,
    nextBitCirc := fun _ => Circuit.fals }

@[simp] lemma eval_zero (x : Fin 0 → ℕ → Bool) : zero.eval x = zeroSeq := by
  ext n; cases n <;> simp [zero, zeroSeq, eval, nextBit, carry]

def one : FSM (Fin 0) :=
  { α := Unit,
    i := by infer_instance,
    initCarry := λ _ => true,
    nextBitCirc := fun a => 
      match a with
      | some () => Circuit.fals
      | none => Circuit.var true (inl ()) }

theorem carry_one (x : Fin 0 → ℕ → Bool) : ∀ (n : ℕ), one.carry x (n+1) = 
    fun _ => false
  | 0 => by
    simp [carry, nextBit, Function.funext_iff, one]
  | n+1 => by
    rw [carry, carry_one _ n]
    simp [nextBit, eval, one, oneSeq]

@[simp] lemma eval_one (x : Fin 0 → ℕ → Bool) : one.eval x = oneSeq := by
  ext n
  cases n
  . rfl
  . simp [eval, carry_one, oneSeq, nextBit]

def negOne : FSM (Fin 0) :=
  { α := Empty,
    i := by infer_instance,
    initCarry := Empty.elim,
    nextBitCirc := fun _ => Circuit.tru }

@[simp] lemma eval_negOne (x : Fin 0 → ℕ → Bool) : negOne.eval x = negOneSeq := by
  ext n; cases n <;> simp [negOne, negOneSeq, eval, nextBit]

def ls (b : Bool) : FSM Unit :=
  { α := Unit,
    i := by infer_instance,
    initCarry := λ _ => b,
    nextBitCirc := fun x => 
      match x with
      | none => Circuit.var true (inl ())
      | some () => Circuit.var true (inr ()) }

theorem carry_ls (b : Bool) (x : Unit → ℕ → Bool) : ∀ (n : ℕ), (ls b).carry x (n+1) = 
    fun _ => x () n
  | 0 => by
    simp [carry, nextBit, Function.funext_iff, ls]
  | n+1 => by
    rw [carry, carry_ls _ _ n]
    simp [nextBit, eval, ls, lsSeq]

@[simp] lemma eval_ls (b : Bool) (x : Unit → ℕ → Bool) : (ls b).eval x = lsSeq b (x ()) := by
  ext n
  cases n
  . rfl
  . simp [carry_ls, eval, nextBit, lsSeq]

def var (n : ℕ) : FSM (Fin (n+1)) :=
  { α := Empty,
    i := by infer_instance,
    initCarry := Empty.elim,
    nextBitCirc := λ _ => Circuit.var true (inr (Fin.last _)) }

@[simp] lemma eval_var (n : ℕ) (x : Fin (n+1) → ℕ → Bool) : (var n).eval x = x (Fin.last n) := by
  ext m; cases m <;> simp [var, eval, carry, nextBit]

def incr : FSM Unit :=
  { α := Unit,
    i := by infer_instance,
    initCarry := λ _ => true,
    nextBitCirc := fun x => 
      match x with
      | none => (Circuit.var true (inr ())) ^^^ (Circuit.var true (inl ()))
      | some _ => (Circuit.var true (inr ())) &&& (Circuit.var true (inl ())) }

theorem carry_incr (x : Unit → ℕ → Bool) : ∀ (n : ℕ), incr.carry x (n+1) = 
    fun _ => (incrSeqAux (x ()) n).2
  | 0 => by
    simp [carry, nextBit, Function.funext_iff, incrSeqAux, incr]
  | n+1 => by
    rw [carry, carry_incr _ n]
    simp [nextBit, eval, incr, incrSeq, incrSeqAux]

@[simp] lemma eval_incr (x : Unit → ℕ → Bool) : incr.eval x = incrSeq (x ()) := by
  ext n
  cases n
  . simp [eval, incr, nextBit, carry, incrSeq, incrSeqAux]
  . rw [eval, carry_incr]; rfl

def decr : FSM Unit :=
  { α := Unit,
    i := by infer_instance,
    initCarry := λ _ => true,
    nextBitCirc := fun x => 
      match x with
      | none => (Circuit.var true (inr ())) ^^^ (Circuit.var true (inl ()))
      | some _ => (Circuit.var false (inr ())) &&& (Circuit.var true (inl ())) }

theorem carry_decr (x : Unit → ℕ → Bool) : ∀ (n : ℕ), decr.carry x (n+1) = 
    fun _ => (decrSeqAux (x ()) n).2
  | 0 => by
    simp [carry, nextBit, Function.funext_iff, decrSeqAux, decr]
  | n+1 => by
    rw [carry, carry_decr _ n]
    simp [nextBit, eval, decr, decrSeq, decrSeqAux]

@[simp] lemma eval_decr (x : Unit → ℕ → Bool) : decr.eval x = decrSeq (x ()) := by
  ext n
  cases n
  . simp [eval, decr, nextBit, carry, decrSeq, decrSeqAux]
  . rw [eval, carry_decr]; rfl

theorem evalAux_eq_zero_of_set {arity : Type _} (p : FSM arity) 
    (R : Set (p.α → Bool)) (hR : ∀ x s, (p.nextBit s x).1 ∈ R → s ∈ R) 
    (hi : p.initCarry ∉ R) (hr1 : ∀ x s, (p.nextBit s x).2 = true → s ∈ R)
    (x : arity → ℕ → Bool) (n : ℕ) : p.eval x n = false ∧ p.carry x n ∉ R := by
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

@[simp] lemma composeUnary_eval
    (p : FSM Unit)
    {t : Term}
    (q : FSMSolution t)
    (x : Fin t.arity → ℕ → Bool) :
    (composeUnary p q).eval x = p.eval (λ _ => t.evalFin x) := by
  rw [composeUnary, FSM.eval_compose, q.good]; rfl

@[simp] lemma composeBinary_eval
    (p : FSM Bool)
    {t₁ t₂ : Term}
    (q₁ : FSMSolution t₁)
    (q₂ : FSMSolution t₂)
    (x : Fin (max t₁.arity t₂.arity) → ℕ → Bool) :
    (composeBinary p q₁ q₂).eval x = p.eval
      (λ b => cond b (t₁.evalFin (fun i => x (Fin.castLE (by simp) i)))
                  (t₂.evalFin (fun i => x (Fin.castLE (by simp) i)))) := by
  rw [composeBinary, FSM.eval_compose, q₁.good, q₂.good]
  congr
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

inductive Result : Type
  | falseAfter (n : ℕ) : Result
  | trueFor (n : ℕ) : Result
  | trueForall : Result
deriving Repr, DecidableEq

def card_compl [Fintype α] [DecidableEq α] (c : Circuit α) : ℕ :=
  Finset.card $ (@Finset.univ (α → Bool) _).filter (fun a => c.eval a = false)

theorem decideIfZeroAux_wf {α : Type _} [Fintype α] [DecidableEq α] 
    {c c' : Circuit α} (h : ¬c' ≤ c) : card_compl (c' ||| c) < card_compl c := by
  apply Finset.card_lt_card
  simp [Finset.ssubset_iff, Finset.subset_iff]
  simp only [Circuit.le_def, not_forall, Bool.not_eq_true] at h
  push_neg at h
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
  termination_by decideIfZerosAux p c => card_compl c

theorem decideIfZeroAux_correct {arity : Type _} [DecidableEq arity]
    (p : FSM arity) (c : Circuit p.α)
    (hc : ∀ n x, c.eval (p.carry x n) = true →  
      ∃ m y, p.eval y m = true) :
    decideIfZerosAux p c = true ↔ ∀ n x, p.eval x n = false := by
  rw [decideIfZerosAux]
  split_ifs with h
  . simp
    exact hc 0 (fun _ _ => false) h
  . dsimp
    split_ifs with h'
    . simp only [true_iff]
      intro n x
      rw [p.eval_eq_zero_of_set {x | c.eval x = true}]
      . intro y s
        simp [Circuit.le_def, Circuit.eval_fst, Circuit.eval_bind] at h'
        simp [Circuit.eval_fst, FSM.nextBit]
        apply h'
      . assumption
      . simp
    . apply decideIfZeroAux_correct p 
      simp [Circuit.eval_fst, Circuit.eval_bind]
      intro h
      rcases h with ⟨g, hg⟩ | h
      . simp [Circuit.le_def, Circuit.eval_fst, Circuit.eval_bind] at h'
        





      