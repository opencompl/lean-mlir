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
  ( init_carry : α → Bool )
  ( next_bit_circ : Option α → Circuit (α ⊕ arity) )

attribute [instance] FSM.i

namespace FSM

variable {arity : Type} (p : FSM arity)

def next_bit : (p.α → Bool) → (arity → Bool) → (p.α → Bool) × Bool :=
  fun carry bits => (fun a => (p.next_bit_circ (some a)).eval 
      (Sum.elim carry bits), 
    (p.next_bit_circ none).eval (Sum.elim carry bits)) 

def evalAux (x : arity → ℕ → Bool) : ℕ → (p.α → Bool) × Bool
  | 0 => p.next_bit p.init_carry (fun i => x i 0)
  | n+1 => p.next_bit (evalAux x n).1 (fun i => x i (n+1))

def eval (x : arity → ℕ → Bool) : ℕ → Bool :=
  fun n => (evalAux p x n).2

def carry (x : arity → ℕ → Bool) : ℕ → p.α → Bool :=
  fun n => (evalAux p x n).1

def changeVars {arity2 : Type} (changeVars : arity → arity2) :
    FSM arity2 :=
  { α := p.α,
    i := p.i,
    init_carry := p.init_carry,
    next_bit_circ := fun a => (p.next_bit_circ a).map (Sum.map id changeVars) }

def compose [Fintype arity]
  (new_arity : Type)
    (q_arity : arity → Type)
    (vars : ∀ (a : arity), q_arity a → new_arity)
    (q : ∀ (a : arity), FSM (q_arity a)) :
    FSM new_arity :=
  { α := p.α ⊕ (Σ a, (q a).α),
    i := by letI := p.i;  infer_instance,
    init_carry := Sum.elim p.init_carry (λ x => (q x.1).init_carry x.2),
    next_bit_circ := λ a => 
      match a with
      | none => (p.next_bit_circ none).bind 
        (Sum.elim 
          (fun a => Circuit.var true (inl (inl a))) 
          (fun a => ((q a).next_bit_circ none).map
            (Sum.elim (fun d => (inl (inr ⟨a, d⟩))) (fun q => inr (vars a q)))))
      | some (inl a) => 
        (p.next_bit_circ (some a)).bind 
          (Sum.elim 
            (fun a => Circuit.var true (inl (inl a)))
            (fun a => ((q a).next_bit_circ none).map
            (Sum.elim (fun d => (inl (inr ⟨a, d⟩))) (fun q => inr (vars a q)))))
      | some (inr ⟨x, y⟩) => 
          ((q x).next_bit_circ (some y)).map 
            (Sum.elim 
              (fun a => inl (inr ⟨_, a⟩)) 
              (fun a => inr (vars x a))) }

lemma evalAux_compose [Fintype arity]
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
      . simp [evalAux, next_bit, compose, Circuit.eval_bind, eval]
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
      . simp [Circuit.eval_map, evalAux, compose, eval, carry, next_bit]
        congr
        ext z
        cases z
        . simp
        . simp
      . simp [evalAux, next_bit, compose, Circuit.eval_bind, eval]
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
      . simp [evalAux, next_bit, compose, Circuit.eval_bind, eval]
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
      . simp [Circuit.eval_map, evalAux, compose, eval, carry, next_bit]
        congr
        ext z
        cases z
        . simp
        . simp
      . simp [evalAux, next_bit, compose, Circuit.eval_bind, eval]
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


def and : FSM Bool :=
  { α := Empty,
    i := by infer_instance,
    init_carry := Empty.elim,
    next_bit := λ _carry bits => (Empty.elim, bits true && bits false) }

@[simp] lemma eval_and (x : Bool → ℕ → Bool) : and.eval x = andSeq (x true) (x false) := by
  ext n; cases n <;> simp [and, andSeq, eval, propagate_succ]

def or : FSM Bool :=
  { α := Empty,
    i := by infer_instance,
    init_carry := Empty.elim,
    next_bit := λ _carry bits => (Empty.elim, bits true || bits false) }

@[simp] lemma eval_or (x : Bool → ℕ → Bool) : or.eval x = orSeq (x true) (x false) := by
  ext n; cases n <;> simp [or, orSeq, eval, propagate_succ]

def xor : FSM Bool :=
  { α := Empty,
    i := by infer_instance,
    init_carry := Empty.elim,
    next_bit := λ _carry bits => (Empty.elim, _root_.xor (bits true) (bits false)) }

@[simp] lemma eval_xor (x : Bool → ℕ → Bool) : xor.eval x = xorSeq (x true) (x false) := by
  ext n; cases n <;> simp [xor, xorSeq, eval, propagate_succ]

  def add : FSM Bool :=
  { α := Unit,
    i := by infer_instance,
    init_carry := λ _ => false,
    next_bit := λ (carry : Unit → Bool) (bits : Bool → Bool) =>
        (λ _ => (bits true && bits false) || (bits false && carry ()) || (bits true && carry ()),
          _root_.xor (bits true) (_root_.xor (bits false) (carry ()))) }

@[simp] lemma eval_add (x : Bool → ℕ → Bool) : add.eval x = addSeq (x true) (x false) := by
  dsimp [add, eval]
  rw [add_eq_propagate]
  congr
  funext b
  cases b; rfl
  simp
  congr
  funext i
  cases i <;> simp


def sub : FSM Bool :=
  { α := Unit,
    i := by infer_instance,
    init_carry := λ _ => false,
    next_bit := λ (carry : Unit → Bool) (bits : Bool → Bool) =>
        (λ _ => (!(bits true) && (bits false)) ||
          ((!(_root_.xor (bits true) (bits false))) && carry ()),
          _root_.xor (bits true) (_root_.xor (bits false) (carry ()))) }

@[simp] lemma eval_sub (x : Bool → ℕ → Bool) : sub.eval x = subSeq (x true) (x false) := by
  dsimp [sub, eval]
  rw [sub_eq_propagate]
  congr
  funext b
  cases b;  rfl
  simp
  congr
  funext i
  cases i <;> simp

def neg : FSM Unit :=
  { α := Unit,
    i := by infer_instance,
    init_carry := λ _ => true,
    next_bit := λ (carry : Unit → Bool) (bits : Unit → Bool) =>
      (λ _ => (!(bits ())) && (carry ()), _root_.xor (!(bits ())) (carry ())) }

@[simp] lemma eval_neg (x : Unit → ℕ → Bool) : neg.eval x = negSeq (x ()) := by
  dsimp [neg, eval]
  rw [neg_eq_propagate]

def not : FSM Unit :=
{ α := Empty,
  i := by infer_instance,
  init_carry := Empty.elim,
  next_bit := λ _carry bits => (Empty.elim, !(bits ())) }

@[simp] lemma eval_not (x : Unit → ℕ → Bool) : not.eval x = notSeq (x ()) := by
  ext n; cases n <;> simp [not, notSeq, eval, propagate_succ]

def zero : FSM (Fin 0) :=
  { α := Empty,
    i := by infer_instance,
    init_carry := Empty.elim,
    next_bit := λ _carry _bits => (Empty.elim, false) }

@[simp] lemma eval_zero (x : Fin 0 → ℕ → Bool) : zero.eval x = zeroSeq := by
  ext n; cases n <;> simp [zero, zeroSeq, eval, propagate_succ]

def one : FSM (Fin 0) :=
  { α := Unit,
    i := by infer_instance,
    init_carry := λ _ => true,
    next_bit := λ carry _bits => (λ _ => false, carry ()) }

@[simp] lemma eval_one (x : Fin 0 → ℕ → Bool) : one.eval x = oneSeq := by
  ext n; cases n <;> simp [one, oneSeq, eval, propagate_succ2, @eq_comm _ false]

def negOne : FSM (Fin 0) :=
  { α := Empty,
    i := by infer_instance,
    init_carry := Empty.elim,
    next_bit := λ _carry _bits => (Empty.elim, true) }

@[simp] lemma eval_negOne (x : Fin 0 → ℕ → Bool) : negOne.eval x = negOneSeq := by
  ext n; cases n <;> simp [negOne, negOneSeq, eval, propagate_succ2]

def ls : FSM Unit :=
  { α := Unit,
    i := by infer_instance,
    init_carry := λ _ => false,
    next_bit := λ carry bits => (bits, carry ()) }

@[simp] lemma eval_ls (x : Unit → ℕ → Bool) : ls.eval x = lsSeq (x ()) := by
  ext n; cases n <;> simp [ls, lsSeq, eval, propagate_succ2]

def var (n : ℕ) : FSM (Fin (n+1)) :=
  { α := Empty,
    i := by infer_instance,
    init_carry := Empty.elim,
    next_bit := λ _carry bits => (Empty.elim, bits (Fin.last n)) }

@[simp] lemma eval_var (n : ℕ) (x : Fin (n+1) → ℕ → Bool) : (var n).eval x = x (Fin.last n) := by
  ext m; cases m <;> simp [var, eval, propagate_succ]

def incr : FSM Unit :=
  { α := Unit,
    i := by infer_instance,
    init_carry := λ _ => true,
    next_bit := λ carry bits => (λ _ => bits () && carry (), _root_.xor (bits ()) (carry ())) }

@[simp] lemma eval_incr (x : Unit → ℕ → Bool) : incr.eval x = incrSeq (x ()) := by
  dsimp [incr, eval]
  rw [incr_eq_propagate]

def decr : FSM Unit :=
  { α := Unit,
    i := by infer_instance,
    init_carry := λ _ => true,
    next_bit := λ carry bits => (λ _ => !(bits ()) && carry (), _root_.xor (bits ()) (carry ())) }

@[simp] lemma eval_decr (x : Unit → ℕ → Bool) : decr.eval x = decrSeq (x ()) := by
  dsimp [decr, eval]
  rw [decr_eq_propagate]

end FSM

structure PropagateSolution (t : Term) extends FSM (Fin (arity t)) :=
( good : t.evalFin = toFSM.eval )

def composeUnary
    (p : FSM Unit)
    {t : Term}
    (q : PropagateSolution t) :
    FSM (Fin (arity t)) :=
  p.compose
    (Fin (arity t))
    _
    (λ _ => id)
    (λ _ => q.toFSM)
def X := @Bool.casesOn
def composeBinary
    (p : FSM Bool)
    {t₁ t₂ : Term}
    (q₁ : PropagateSolution t₁)
    (q₂ : PropagateSolution t₂) :
    FSM (Fin (max (arity t₁) (arity t₂))) :=
  p.compose (Fin (max (arity t₁) (arity t₂)))
    (λ b => Fin (cond b (arity t₁) (arity t₂)))
    (λ b i => Fin.castLE (by cases b <;> simp) i)
    (λ b => match b with
      | true => q₁.toFSM
      | false => q₂.toFSM)

@[simp] lemma composeUnary_eval
    (p : FSM Unit)
    {t : Term}
    (q : PropagateSolution t)
    (x : Fin (arity t) → ℕ → Bool) :
    (composeUnary p q).eval x = p.eval (λ _ => t.evalFin x) := by
  rw [composeUnary, FSM.eval_compose, q.good]; rfl

@[simp] lemma composeBinary_eval
    (p : FSM Bool)
    {t₁ t₂ : Term}
    (q₁ : PropagateSolution t₁)
    (q₂ : PropagateSolution t₂)
    (x : Fin (max (arity t₁) (arity t₂)) → ℕ → Bool) :
    (composeBinary p q₁ q₂).eval x = p.eval
      (λ b => cond b (t₁.evalFin (fun i => x (Fin.castLE (by simp) i)))
                  (t₂.evalFin (fun i => x (Fin.castLE (by simp) i)))) := by
  rw [composeBinary, FSM.eval_compose, q₁.good, q₂.good]
  congr
  ext b
  cases b <;> dsimp <;> congr <;> funext b <;> cases b <;> simp

instance {α β : Type} [Fintype α] [Fintype β] (b : Bool) :
    Fintype (cond b α β) :=
  by cases b <;> simp <;> infer_instance

lemma cond_propagate {α α' β β' : Type}
    (init_carry : α → Bool)
    (next_bit : ∀ (_carry : α → Bool) (_bits : β → Bool),
      (α → Bool) × Bool)
    (init_carry' : α' → Bool)
    (next_bit' : ∀ (_carry : α' → Bool) (_bits : β' → Bool),
      (α' → Bool) × Bool)
    {γ : Type} (fβ : β → γ) (fβ' : β' → γ)
    (x : γ → ℕ → Bool) (b : Bool) :
    cond b (propagate init_carry next_bit (λ b => (x (fβ b))))
      (propagate init_carry' next_bit' (λ b => (x (fβ' b)))) =
    propagate (show cond b α α' → Bool from Bool.rec init_carry' init_carry b)
      (show ∀ (_carry : cond b α α' → Bool) (_bits : cond b β β' → Bool),
          (cond b α α' → Bool) × Bool
        from Bool.rec next_bit' next_bit b)
      (show cond b β β' → ℕ → Bool from Bool.rec (λ b => (x (fβ' b))) (λ b => (x (fβ b))) b) :=
  by cases b <;> rfl

def termEvalEqPropagate : ∀ (t : Term),
  PropagateSolution t
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
  let q₁ := termEvalEqPropagate t₁
  let q₂ := termEvalEqPropagate t₂
  { toFSM := composeBinary FSM.and q₁ q₂,
    good := by ext; simp }
| Term.or t₁ t₂ =>
  let q₁ := termEvalEqPropagate t₁
  let q₂ := termEvalEqPropagate t₂
  { toFSM := composeBinary FSM.or q₁ q₂,
    good := by ext; simp }
| Term.xor t₁ t₂ =>
  let q₁ := termEvalEqPropagate t₁
  let q₂ := termEvalEqPropagate t₂
  { toFSM := composeBinary FSM.xor q₁ q₂,
    good := by ext; simp }
| ls t =>
  let q := termEvalEqPropagate t
  { toFSM := by dsimp [arity]; exact composeUnary FSM.ls q,
    good := by ext; simp }
| Term.not t =>
  let q := termEvalEqPropagate t
  { toFSM := by dsimp [arity]; exact composeUnary FSM.not q,
    good := by ext; simp }
| add t₁ t₂ =>
  let q₁ := termEvalEqPropagate t₁
  let q₂ := termEvalEqPropagate t₂
  { toFSM := composeBinary FSM.add q₁ q₂,
    good := by ext; simp }
| sub t₁ t₂ =>
  let q₁ := termEvalEqPropagate t₁
  let q₂ := termEvalEqPropagate t₂
  { toFSM := composeBinary FSM.sub q₁ q₂,
    good := by ext; simp }
| neg t =>
  let q := termEvalEqPropagate t
  { toFSM := by dsimp [arity]; exact composeUnary FSM.neg q,
    good := by ext; simp }
| incr t =>
  let q := termEvalEqPropagate t
  { toFSM := by dsimp [arity]; exact composeUnary FSM.incr q,
    good := by ext; simp }
| decr t =>
  let q := termEvalEqPropagate t
  { toFSM := by dsimp [arity]; exact composeUnary FSM.decr q,
    good := by ext; simp }

variable
  (init_carry : α → Bool)
  (next_carry : ∀ (_carry : α → Bool) (_bits : β → Bool), (α → Bool))
  (next_bit : ∀ (_carry : α → Bool) (_bits : β → Bool), (α → Bool) × Bool)

variable [Fintype α] [Fintype α']

open Fintype

lemma exists_repeat_carry (seq : β → ℕ → Bool) :
    ∃ n m : Fin (2 ^ (card α) + 1),
      propagateCarry2 init_carry next_carry seq n =
      propagateCarry2 init_carry next_carry seq m ∧
      n < m := by
  by_contra h
  haveI := Classical.decEq α
  push_neg at h
  have := λ a b hab => (le_antisymm (h a b hab) (h b a hab.symm)).symm
  have := Fintype.card_le_of_injective _ this
  simp at this

lemma propagateCarry2_eq_of_seq_eq_lt (seq₁ seq₂ : β → ℕ → Bool)
    (init_carry : α → Bool)
    (next_carry : ∀ (_carry : α → Bool) (_bits : β → Bool), (α → Bool))
    (i : ℕ) (h : ∀ (b) (j) (_hj : j < i), seq₁ b j = seq₂ b j) :
    propagateCarry2 init_carry next_carry seq₁ i =
      propagateCarry2 init_carry next_carry seq₂ i := by
  induction' i with i ih
  { simp [propagateCarry2] }
  { simp only [propagateCarry2, h _ i (Nat.lt_succ_self i)]
    rw [ih]
    exact λ b j hj => h b j (Nat.lt_succ_of_lt hj) }

lemma propagate_eq_of_seq_eq_le (seq₁ seq₂ : β → ℕ → Bool)
    (init_carry : α → Bool)
    (next_bit : ∀ (_carry : α → Bool) (_bits : β → Bool), (α → Bool) × Bool)
    (i : ℕ) (h : ∀ (b) (j) (_hj : j ≤ i), seq₁ b j = seq₂ b j) :
    propagate init_carry next_bit seq₁ i =
      propagate init_carry next_bit seq₂ i := by
  cases i
  { simp [propagate_zero, h _ 0 (le_refl _)] }
  { simp only [propagate_succ2, propagate_succ2, h _ _ (le_refl _)]
    congr 2
    apply propagateCarry2_eq_of_seq_eq_lt
    exact λ b j hj => h b j (le_of_lt hj) }


lemma propagateCarry2_eq_of_carry_eq (seq₁ seq₂ : β → ℕ → Bool)
    (m n : ℕ)
    (h₁ : propagateCarry2 init_carry
      (λ carry bits => (next_bit carry bits).1) seq₁ m =
        propagateCarry2 init_carry
      (λ carry bits => (next_bit carry bits).1) seq₂ n) (x : ℕ)
    (h₃ : ∀ y b, y ≤ x → seq₁ b (m + y) = seq₂ b (n + y))  :
    propagateCarry2 init_carry
      (λ carry bits => (next_bit carry bits).1) seq₁ (m + x) =
    propagateCarry2 init_carry
      (λ carry bits => (next_bit carry bits).1) seq₂ (n + x) := by
  induction' x with x ih generalizing seq₁ seq₂
  { simp [*] at * }
  { simp only [propagateCarry2, Nat.add_eq, h₃ x _ (Nat.le_succ _)] at *
    rw [ih]
    assumption
    exact λ y b h => h₃ y b (Nat.le_succ_of_le h) }

lemma propagate_eq_of_carry_eq (seq₁ seq₂ : β → ℕ → Bool)
    (m n : ℕ)
    (h₁ : propagateCarry2 init_carry
      (λ carry bits => (next_bit carry bits).1) seq₁ m =
        propagateCarry2 init_carry
      (λ carry bits => (next_bit carry bits).1) seq₂ n) (x : ℕ)
    (h₃ : ∀ y b, y ≤ x → seq₁ b (m + y) = seq₂ b (n + y))  :
    propagate init_carry next_bit seq₁ (m + x) =
    propagate init_carry next_bit seq₂ (n + x) := by
  cases x
  { cases m
    { cases n
      { simp [h₃ 0 _ (le_refl _), propagateCarry2, *] at * }
      { simp [*, h₃ 0 _ (le_refl _), propagate_succ2] at *
        rw [← h₁] } }
    { cases n
      { simp [*, propagate_succ2] at *
        have := fun i => h₃ 0 i rfl
        dsimp at this
        simp [this]
        simp [h₁] }
      { rw [propagate_succ2, h₁, propagate_succ2]
        have := h₃ 0
        simp [*] at * } } }
  { erw [Nat.add_succ, propagate_succ2, propagate_succ2, Nat.add_eq]
    simp [← Nat.succ_eq_add_one, ← Nat.add_succ, h₃ _ _ (le_refl _)]
    congr
    . apply propagateCarry2_eq_of_carry_eq
      . assumption
      . exact λ y b h => h₃ y b (Nat.le_succ_of_le h)
    . funext i
      rw [h₃]
      exact Nat.le_succ _ }

lemma propagateCarry_propagateCarry_add (x : β → ℕ → Bool) :
    ∀ (init_carry : α → Bool)
      (next_carry : ∀ (_carry : α → Bool) (_bits : β → Bool), (α → Bool)),
    ∀ n i : ℕ,
    propagateCarry2 (propagateCarry2 init_carry next_carry x n)
      next_carry (λ b k => x b (k + n)) i =
    propagateCarry2 init_carry next_carry x (i + n)
  | init_carry, _next_carry, 0, 0 => by simp [propagateCarry2]
  | init_carry, next_carr, n+1, 0 =>
    by simp [propagateCarry, propagateCarry2_succ]
  | init_carry, next_carry, n, i+1 => by
    rw [propagateCarry2, add_assoc,
      propagateCarry_propagateCarry_add _ _ _ _ i]
    simp only [Nat.one_add, Nat.add_one, Nat.succ_add, Nat.add_succ,
      add_zero, propagateCarry2, zero_add]

lemma exists_repeat : ∀ (seq : β → ℕ → Bool)
    (n : ℕ),
    ∃ (m : ℕ) (_hm : m < 2 ^ (card α)) (seq2 : β → ℕ → Bool),
      propagate init_carry next_bit seq2 m = propagate init_carry next_bit seq n
  | seq, n => by
    by_cases hn2 : n < 2 ^ card α
    { exact ⟨n, hn2, seq, rfl⟩ }
    { rcases exists_repeat_carry
        (propagateCarry2 init_carry (λ c b => (next_bit c b).1) seq
          (n - 2 ^ card α))
        (λ carry bits => (next_bit  carry bits).1)
        (λ b i => seq b (i + (n - 2^ (card α)))) with ⟨a, b, h₁, h₂⟩
      simp only [propagateCarry_propagateCarry_add] at h₁
      rcases have _wf : n - (b - a) < n :=
         Nat.sub_lt (lt_of_lt_of_le (pow_pos (by norm_num) _) (le_of_not_lt hn2)) (Nat.sub_pos_of_lt h₂)
        exists_repeat (λ c i => if i < a + (n - 2 ^ card α) then seq c i else
          seq c (i + (b - a))) (n - (b - a)) with ⟨m, hmle, seq2, hm⟩
      use m; use hmle; use seq2
      rw [hm]; clear hm
      have h1 : n - (b - a) = (a + (n - 2 ^ (card α))) + (2 ^ card α - b) := by
      { zify
        rw [Nat.cast_sub, Nat.cast_sub, Nat.cast_sub, Nat.cast_sub]
        ring_nf
        exact Nat.le_of_lt_succ b.2
        simp [*] at *
        exact hn2
        exact le_of_lt h₂
        exact le_trans (Nat.sub_le _ _) (le_trans (Nat.le_of_lt_succ b.2)
          (le_of_not_lt hn2)) }
      rw [h1]
      have h2 : n = (b + (n - 2 ^ card α)) + (2 ^ card α - b) := by
      { zify
        rw [Nat.cast_sub, Nat.cast_sub]
        ring
        exact Nat.le_of_lt_succ b.2
        simp [*] at *
        exact hn2 }
      conv_rhs => rw [h2]
      refine' propagate_eq_of_carry_eq _ _ _ _ _ _ _ _ _
      { have _h : ↑b + (n - 2 ^ card α) = (a + (n - 2 ^ card α)) + (b - a) := by
        { zify
          rw [Nat.cast_sub, Nat.cast_sub]
          ring_nf
          exact le_of_lt h₂
          exact le_of_not_lt hn2 }
        rw [← h₁]
        apply propagateCarry2_eq_of_seq_eq_lt
        simp (config := { contextual := true }) }
      { intro y c _hc
        simp only [add_lt_iff_neg_left, not_lt_zero', if_false]
        congr 1
        zify
        rw [Nat.cast_sub, Nat.cast_sub]
        ring
        exact le_of_lt h₂
        exact le_of_not_lt hn2 } }


lemma propagate_eq_zero_iff (init_carry : α → Bool)
    (next_bit : ∀ (_carry : α → Bool) (_bits : β → Bool), (α → Bool) × Bool) :
    (∀ seq, propagate init_carry next_bit seq = zeroSeq) ↔
    (∀ seq, ∀ i < 2 ^ (card α), propagate init_carry next_bit seq i = false) := by
  constructor
  { intro h i _
    simp [h, zeroSeq] }
  { intro h seq
    funext i
    rcases exists_repeat init_carry next_bit seq i with ⟨j, hj, seq2, hseq2⟩
    rw [← hseq2, h seq2 j hj, zeroSeq] }

lemma eq_iff_xorSeq_eq_zero (seq₁ seq₂ : ℕ → Bool) :
    (∀ i, seq₁ i = seq₂ i) ↔ (∀ i, xorSeq seq₁ seq₂ i = zeroSeq i) := by
  simp [Function.funext_iff, xorSeq, zeroSeq]
  constructor
  { intro i _; simp [*] }
  { intro h a
    specialize h a
    revert h
    cases (seq₁ a) <;> cases (seq₂ a) <;> simp [*] at * }

lemma eval_eq_iff_xorSeq_eq_zero (t₁ t₂ : Term) :
    t₁.eval = t₂.eval ↔ (t₁.xor t₂).evalFin = λ _ => zeroSeq := by
  simp only [Function.funext_iff, Term.eval, Term.evalFin,
    ← eq_iff_xorSeq_eq_zero, ← evalFin_eq_eval]
  constructor
  { intro h seq n
    have := h (λ j => if hj : j < (arity (t₁.xor t₂)) then seq ⟨j, hj⟩ else λ _ => false) n
    simp at this
    convert this using 1 }
  { intro h seq m
    exact h (λ j => seq j) _ }
