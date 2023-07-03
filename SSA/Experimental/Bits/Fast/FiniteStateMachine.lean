import Mathlib.Data.Fintype.Card
import Mathlib.Data.Fintype.Sum
import Mathlib.Data.Fintype.Sigma
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

def evalAux (x : arity → ℕ → Bool) : ℕ → (p.α → Bool) × Bool
  | 0 => p.nextBit p.initCarry (fun i => x i 0)
  | n+1 => p.nextBit (evalAux x n).1 (fun i => x i (n+1))

def eval (x : arity → ℕ → Bool) : ℕ → Bool :=
  fun n => (evalAux p x n).2

def carry (x : arity → ℕ → Bool) : ℕ → p.α → Bool :=
  fun n => (evalAux p x n).1

theorem eval_eq_carry (x : arity → ℕ → Bool) (n : ℕ) : 
  p.eval x n = (p.nextBit (Nat.casesOn n p.initCarry (p.carry x)) 
    (fun i => x i n)).2 := by
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

lemma evalAux_compose [Fintype arity] [DecidableEq arity]
    (new_arity : Type)
    (q_arity : arity → Type)
    (vars : ∀ (a : arity), q_arity a → new_arity)
    (q : ∀ (a : arity), FSM (q_arity a))
    (x : new_arity → ℕ → Bool) : ∀ (n : ℕ),
    (p.compose new_arity q_arity vars q).evalAux x n = 
      let z := p.evalAux (λ a => (q a).eval (fun i => x (vars _ i))) n
      (Sum.elim z.1 (fun a => (q a.1).carry (fun t => x (vars _ t)) n a.2), z.2)
  | 0 => by
      ext y
      cases y
      . simp only [evalAux, nextBit, compose, Circuit.eval_bind, eval]
        congr
        ext z
        cases z
        . simp
        . simp [Circuit.eval_map]
          congr
          ext s
          cases s
          . simp
          . simp
      . simp [Circuit.eval_map, evalAux, compose, eval, carry, nextBit]
        congr
        ext z
        cases z
        . simp
        . simp
      . simp [evalAux, nextBit, compose, Circuit.eval_bind, eval]
        congr
        ext z
        cases z
        . simp
        . simp [Circuit.eval_map]
          congr
          ext s
          cases s
          . simp
          . simp        
  | n+1 => by
      rw [evalAux, evalAux_compose _ _ _ _ _ n]
      ext y
      cases y
      . simp [evalAux, nextBit, compose, Circuit.eval_bind, eval]
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
      . simp [Circuit.eval_map, evalAux, compose, eval, carry, nextBit]
        congr
        ext z
        cases z
        . simp
        . simp
      . simp [evalAux, nextBit, compose, Circuit.eval_bind, eval]
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

lemma eval_compose [Fintype arity] [DecidableEq arity]
    (new_arity : Type)
    (q_arity : arity → Type)
    (vars : ∀ (a : arity), q_arity a → new_arity)
    (q : ∀ (a : arity), FSM (q_arity a))
    (x : new_arity → ℕ → Bool) :
    (p.compose new_arity q_arity vars q).eval x = 
      p.eval (λ a => (q a).eval (fun i => x (vars _ i))) := by
  ext n
  rw [eval, evalAux_compose, eval]

def and : FSM Bool :=
  { α := Empty,
    i := by infer_instance,
    initCarry := Empty.elim,
    nextBitCirc := fun a => a.elim 
      (Circuit.and 
        (Circuit.var true (inr true)) 
        (Circuit.var true (inr false))) Empty.elim }

@[simp] lemma eval_and (x : Bool → ℕ → Bool) : and.eval x = andSeq (x true) (x false) := by
  ext n; cases n <;> simp [and, andSeq, evalAux, eval, nextBit]

def or : FSM Bool :=
  { α := Empty,
    i := by infer_instance,
    initCarry := Empty.elim,
    nextBitCirc := fun a => a.elim 
      (Circuit.or 
        (Circuit.var true (inr true)) 
        (Circuit.var true (inr false))) Empty.elim }

@[simp] lemma eval_or (x : Bool → ℕ → Bool) : or.eval x = orSeq (x true) (x false) := by
  ext n; cases n <;> simp [and, orSeq, evalAux, eval, nextBit]

def xor : FSM Bool :=
  { α := Empty,
    i := by infer_instance,
    initCarry := Empty.elim,
    nextBitCirc := fun a => a.elim 
      (Circuit.xor 
        (Circuit.var true (inr true)) 
        (Circuit.var true (inr false))) Empty.elim }

@[simp] lemma eval_xor (x : Bool → ℕ → Bool) : xor.eval x = xorSeq (x true) (x false) := by
  ext n; cases n <;> simp [and, xorSeq, evalAux, eval, nextBit]

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

theorem evalAux_add (x : Bool → ℕ → Bool) : ∀ (n : ℕ), add.evalAux x n = 
    (fun _ => (addSeqAux (x true) (x false) n).2, (addSeqAux (x true) (x false) n).1)
  | 0 => by
    simp [evalAux, nextBit, Function.funext_iff, addSeqAux, add]
  | n+1 => by
    rw [evalAux, evalAux_add _ n]
    simp [nextBit, Function.funext_iff, addSeqAux]

@[simp] lemma eval_add (x : Bool → ℕ → Bool) : add.eval x = addSeq (x true) (x false) := by
  ext n
  rw [eval, evalAux_add]; rfl

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

theorem evalAux_sub (x : Bool → ℕ → Bool) : ∀ (n : ℕ), sub.evalAux x n = 
    (fun _ => (subSeqAux (x true) (x false) n).2, (subSeqAux (x true) (x false) n).1)
  | 0 => by
    simp [evalAux, nextBit, Function.funext_iff, subSeqAux, sub]
  | n+1 => by
    rw [evalAux, evalAux_sub _ n]
    simp [nextBit, Function.funext_iff, subSeqAux, Bool.xor_not_left']

@[simp] lemma eval_sub (x : Bool → ℕ → Bool) : sub.eval x = subSeq (x true) (x false) := by
  ext n
  rw [eval, evalAux_sub]; rfl

def neg : FSM Unit :=
  { α := Unit,
    i := by infer_instance,
    initCarry := λ _ => true,
    nextBitCirc := fun a =>
      match a with
      | some () => Circuit.var false (inr ()) &&& Circuit.var true (inl ())
      | none => Circuit.var false (inr ()) ^^^ Circuit.var true (inl ())  }

theorem evalAux_neg (x : Unit → ℕ → Bool) : ∀ (n : ℕ), neg.evalAux x n = 
    (fun _ => (negSeqAux (x ()) n).2, (negSeqAux (x ()) n).1)
  | 0 => by
    simp [evalAux, nextBit, Function.funext_iff, negSeqAux, neg]
  | n+1 => by
    rw [evalAux, evalAux_neg _ n]
    simp [nextBit, Function.funext_iff, negSeqAux, Bool.xor_not_left']

@[simp] lemma eval_neg (x : Unit → ℕ → Bool) : neg.eval x = negSeq (x ()) := by
  ext n
  rw [eval, evalAux_neg]; rfl

def not : FSM Unit :=
  { α := Empty,
    i := by infer_instance,
    initCarry := Empty.elim,
    nextBitCirc := fun _ => Circuit.var false (inr ()) }

@[simp] lemma eval_not (x : Unit → ℕ → Bool) : not.eval x = notSeq (x ()) := by
  ext n; cases n <;> simp [eval, evalAux, not, notSeq, nextBit]

def zero : FSM (Fin 0) :=
  { α := Empty,
    i := by infer_instance,
    initCarry := Empty.elim,
    nextBitCirc := fun _ => Circuit.fals }

@[simp] lemma eval_zero (x : Fin 0 → ℕ → Bool) : zero.eval x = zeroSeq := by
  ext n; cases n <;> simp [zero, zeroSeq, eval, nextBit, evalAux]

def one : FSM (Fin 0) :=
  { α := Unit,
    i := by infer_instance,
    initCarry := λ _ => true,
    nextBitCirc := fun a => 
      match a with
      | some () => Circuit.fals
      | none => Circuit.var true (inl ()) }

theorem evalAux_one (x : Fin 0 → ℕ → Bool) : ∀ (n : ℕ),
    one.evalAux x n = (fun _ => false, oneSeq n) 
  | 0 => by simp [evalAux, nextBit, one, oneSeq]
  | n+1 => by 
    rw [evalAux, evalAux_one _ n]
    simp [nextBit, oneSeq]

@[simp] lemma eval_one (x : Fin 0 → ℕ → Bool) : one.eval x = oneSeq := by
  ext n
  rw [eval, evalAux_one]

def negOne : FSM (Fin 0) :=
  { α := Empty,
    i := by infer_instance,
    initCarry := Empty.elim,
    nextBitCirc := fun _ => Circuit.tru }

@[simp] lemma eval_negOne (x : Fin 0 → ℕ → Bool) : negOne.eval x = negOneSeq := by
  ext n; cases n <;> simp [negOne, negOneSeq, eval, evalAux, nextBit]

def ls (b : Bool) : FSM Unit :=
  { α := Unit,
    i := by infer_instance,
    initCarry := λ _ => b,
    nextBitCirc := fun x => 
      match x with
      | none => Circuit.var true (inl ())
      | some () => Circuit.var true (inr ()) }

theorem evalAux_ls (b : Bool) (x : Unit → ℕ → Bool) : ∀ (n : ℕ),
    (ls b).evalAux x n = (fun _ => x () n, lsSeq b (x ()) n)
  | 0 => by simp [evalAux, nextBit, ls, lsSeq]
  | n+1 => by
    rw [evalAux, evalAux_ls _ _ n]
    simp [nextBit, lsSeq]

@[simp] lemma eval_ls (b : Bool) (x : Unit → ℕ → Bool) : (ls b).eval x = lsSeq b (x ()) := by
  ext n
  rw [eval, evalAux_ls]

def var (n : ℕ) : FSM (Fin (n+1)) :=
  { α := Empty,
    i := by infer_instance,
    initCarry := Empty.elim,
    nextBitCirc := λ _ => Circuit.var true (inr (Fin.last _)) }

@[simp] lemma eval_var (n : ℕ) (x : Fin (n+1) → ℕ → Bool) : (var n).eval x = x (Fin.last n) := by
  ext m; cases m <;> simp [var, eval, evalAux, nextBit]

def incr : FSM Unit :=
  { α := Unit,
    i := by infer_instance,
    initCarry := λ _ => true,
    nextBitCirc := fun x => 
      match x with
      | none => (Circuit.var true (inr ())) ^^^ (Circuit.var true (inl ()))
      | some _ => (Circuit.var true (inr ())) &&& (Circuit.var true (inl ())) }

theorem evalAux_incr (x : Unit → ℕ → Bool) : ∀ n, 
    incr.evalAux x n = (fun _ => (incrSeqAux (x ()) n).2, (incrSeqAux (x ()) n).1)
  | 0 => by simp [evalAux, nextBit, nextBit, incrSeqAux, incr]
  | n+1 => by
    rw [evalAux, evalAux_incr _ n]
    simp [nextBit, incrSeqAux, incr]

@[simp] lemma eval_incr (x : Unit → ℕ → Bool) : incr.eval x = incrSeq (x ()) := by
  ext n
  rw [eval, evalAux_incr]; rfl

def decr : FSM Unit :=
  { α := Unit,
    i := by infer_instance,
    initCarry := λ _ => true,
    nextBitCirc := fun x => 
      match x with
      | none => (Circuit.var true (inr ())) ^^^ (Circuit.var true (inl ()))
      | some _ => (Circuit.var false (inr ())) &&& (Circuit.var true (inl ())) }

theorem evalAux_decr (x : Unit → ℕ → Bool) : ∀ n, 
    decr.evalAux x n = (fun _ => (decrSeqAux (x ()) n).2, (decrSeqAux (x ()) n).1)
  | 0 => by simp [evalAux, nextBit, nextBit, decrSeqAux, decr]
  | n+1 => by
    rw [evalAux, evalAux_decr _ n]
    simp [nextBit, decrSeqAux, decr]

@[simp] lemma eval_decr (x : Unit → ℕ → Bool) : decr.eval x = decrSeq (x ()) := by
  ext n
  rw [eval, evalAux_decr]; rfl

theorem evalAux_eq_zero_of_set {arity : Type _} (p : FSM arity) 
    (R : Set (p.α → Bool)) (hR : ∀ x s, (p.nextBit s x).1 ∈ R → s ∈ R) 
    (hi : p.initCarry ∉ R) (hr1 : ∀ x s, (p.nextBit s x).2 = true → s ∈ R)
    (x : arity → ℕ → Bool) (n : ℕ) : p.eval x n = false ∧ p.carry x n ∉ R := by
  simp (config := {singlePass := true}) only [← not_imp_not] at hR hr1
  simp only [Bool.not_eq_true] at hR hr1
  induction n with
  | zero => 
    simp only [eval, evalAux, carry]
    exact ⟨hr1 _ _ hi, hR _ _ hi⟩
  | succ n ih => 
    simp only [eval, evalAux, carry] at ih ⊢
    exact ⟨hr1 _ _ ih.2, hR _ _ ih.2⟩ 

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

def decideIfZerosAux {arity : Type _} [DecidableEq arity]
    (p : FSM arity) (c : Circuit p.α) : Bool :=
  if c.eval p.initCarry
  then false
  else 
    let c' := (c.bind (p.nextBitCirc ∘ some)).fst
    decideIfZerosAux p c
decreasing_by sorry
