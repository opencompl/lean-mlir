import Mathlib.Data.Fintype.Card
import Mathlib.Data.Fintype.Sum
import Mathlib.Data.Fintype.Sigma
import Mathlib.Data.Fintype.BigOperators
import Mathlib.Tactic.Zify
import Mathlib.Tactic.Ring
import SSA.Experimental.Bits.Defs
import SSA.Experimental.Bits.Lemmas

open Sum

variable {α β α' β' : Type} {γ : β → Type}

def propagateAux (init_carry : α → Bool)
    (next_bit : ∀ (_carry : α → Bool) (_bits : β → Bool),
      (α → Bool) × Bool)
    (x : β → ℕ → Bool) : ℕ → (α → Bool) × Bool
  | 0 => next_bit init_carry (fun i => x i 0)
  | n+1 => next_bit (propagateAux init_carry next_bit x n).1 (fun i => x i (n+1))

def propagate (init_carry : α → Bool)
    (next_bit : ∀ (_carry : α → Bool) (_bits : β → Bool),
      (α → Bool) × Bool)
    (x : β → ℕ → Bool) (i : ℕ) : Bool :=
  (propagateAux init_carry next_bit x i).2

@[simp] def propagateCarry (init_carry : α → Bool)
    (next_bit : ∀ (_carry : α → Bool) (_bits : β → Bool),
      (α → Bool))
    (x : β → ℕ → Bool) : ℕ → (α → Bool)
  | 0 => next_bit init_carry (fun i => x i 0)
  | n+1 => next_bit (propagateCarry init_carry next_bit x n) (fun i => x i (n+1))

@[simp] def propagateCarry2 (init_carry : α → Bool)
    (next_bit : ∀ (_carry : α → Bool) (_bits : β → Bool),
      (α → Bool))
    (x : β → ℕ → Bool) : ℕ → (α → Bool)
  | 0 => init_carry
  | n+1 => next_bit (propagateCarry2 init_carry next_bit x n) (fun i => x i n)

lemma propagateCarry2_succ (init_carry : α → Bool)
    (next_bit : ∀ (_carry : α → Bool) (_bits : β → Bool),
      (α → Bool))
    (x : β → ℕ → Bool) : ∀ (n : ℕ),
    propagateCarry2 init_carry next_bit x (n+1) =
    propagateCarry init_carry next_bit x n
  | 0 => rfl
  | n+1 => by rw [propagateCarry2, propagateCarry2_succ _ _ _ n, propagateCarry]

@[simp] lemma propagateAux_fst_eq_carry (init_carry : α → Bool)
    (next_bit : ∀ (_carry : α → Bool) (_bits : β → Bool),
      (α → Bool) × Bool)
    (x : β → ℕ → Bool) : ∀ n : ℕ,
    (propagateAux init_carry next_bit x n).1 =
    propagateCarry init_carry (fun c b => (next_bit c b).1) x n
  | 0 => rfl
  | n+1 => by rw [propagateAux, propagateCarry, propagateAux_fst_eq_carry _ _ _ n]

@[simp] lemma propagate_zero (init_carry : α → Bool)
    (next_bit : ∀ (_carry : α → Bool) (_bits : β → Bool),
    (α → Bool) × Bool)
    (x : β → ℕ → Bool) :
    propagate init_carry next_bit x 0 = (next_bit init_carry (fun i => x i 0)).2 :=
  rfl

lemma propagate_succ (init_carry : α → Bool)
    (next_bit : ∀ (_carry : α → Bool) (_bits : β → Bool),
      (α → Bool) × Bool)
    (x : β → ℕ → Bool) (i : ℕ) :
    propagate init_carry next_bit x (i+1) = (next_bit
      (propagateCarry init_carry (fun c b => (next_bit c b).1) x i)
      (λ j => x j (i+1))).2 :=
  by rw [← propagateAux_fst_eq_carry]; rfl

lemma propagate_succ2 (init_carry : α → Bool)
    (next_bit : ∀ (_carry : α → Bool) (_bits : β → Bool),
      (α → Bool) × Bool)
    (x : β → ℕ → Bool) (i : ℕ) :
    propagate init_carry next_bit x (i+1) = (next_bit
      (propagateCarry2 init_carry (λ c b => (next_bit c b).1) x (i+1))
      (λ j => x j (i+1))).2 :=
  by rw [propagateCarry2_succ, ← propagateAux_fst_eq_carry]; rfl

lemma propagateCarry_propagate {δ : β → Type} {β' : Type}
      (f : ∀ a, δ a → β') : ∀ (n : ℕ) (init_carry : α → Bool)
    (next_bit : ∀ (_carry : α → Bool) (_bits : β → Bool),
      (α → Bool))
    (init_carry_x : ∀ a, γ a → Bool)
    (next_bit_x : ∀ a (_carry : γ a → Bool) (_bits : δ a → Bool),
      (γ a → Bool) × Bool)
    (x : β' → ℕ → Bool),
    propagateCarry init_carry next_bit (λ a => propagate (init_carry_x a)
      (next_bit_x a) (λ d => x (f a d))) n =
    propagateCarry
      (λ a : α ⊕ (Σ a, γ a) => Sum.elim init_carry (λ b : Σ a, γ a =>
        init_carry_x b.1 b.2) a)
      (λ (carry : (α ⊕ (Σ a, γ a)) → Bool) (bits : β' → Bool) =>
    -- first compute (propagate (init_carry_x a) (next_bit_x a) (x a) n)
        let f : ∀ (a : β), (γ a → Bool) × Bool := λ a => next_bit_x a
          (λ d => carry (inr ⟨a, d⟩)) (λ d => bits (f a d))
        let g : (α → Bool) := (next_bit (carry ∘ inl) (λ a => (f a).2))
        Sum.elim g (λ x => (f x.1).1 x.2))
      x n ∘ inl
  | 0, init_carry, next_bit, init_carry_x, next_bit_x, x => rfl
  | n+1, init_carry, next_bit, init_carry_x, next_bit_x, x => by
    have := propagateCarry_propagate f n
    simp only [propagateCarry, propagate_succ, elim_inl, Nat.add] at *
    conv_lhs => simp only [this]
    clear this
    dsimp
    congr
    ext a
    dsimp
    congr
    ext b
    dsimp [propagateCarry, propagate_succ, elim_inl, Nat.add]
    congr
    dsimp
    induction' n with n ih
    . simp
    . simp [ih]

lemma propagate_propagate {δ : β → Type} {β' : Type}
      (f : ∀ a, δ a → β') : ∀ (n : ℕ) (init_carry : α → Bool)
    (next_bit : ∀ (_carry : α → Bool) (_bits : β → Bool),
      (α → Bool) × Bool)
    (init_carry_x : ∀ a, γ a → Bool)
    (next_bit_x : ∀ a (_carry : γ a → Bool) (_bits : δ a → Bool),
      (γ a → Bool) × Bool)
    (x : β' → ℕ → Bool),
    propagate init_carry next_bit (λ a => propagate (init_carry_x a)
      (next_bit_x a) (λ d => x (f a d))) n =
    propagate
      (λ a : α ⊕ (Σ a, γ a) => Sum.elim init_carry (λ b : Σ a, γ a =>
        init_carry_x b.1 b.2) a)
      (λ (carry : (α ⊕ (Σ a, γ a)) → Bool) (bits : β' → Bool) =>
        -- first compute (propagate (init_carry_x a) (next_bit_x a) (x a) n)
        let f : ∀ (a : β), (γ a → Bool) × Bool := λ a => next_bit_x a (λ d =>
          carry (inr ⟨a, d⟩)) (λ d => bits (f a d))
        let g : (α → Bool) × Bool := (next_bit (carry ∘ inl) (λ a => (f a).2))
        (Sum.elim g.1 (λ x => (f x.1).1 x.2), g.2)
      )
    x n
  | 0, init_carry, next_bit, init_carry_x, next_bit_x, x => rfl
  | n+1, init_carry, next_bit, init_carry_x, next_bit_x, x => by
    simp only [propagate_succ]
    rw [propagateCarry_propagate]
    congr
    ext
    congr
    induction' n with n ih
    . simp
    . simp [ih]

lemma propagateCarry_changeVars {β' : Type}
    (init_carry : α → Bool)
    (next_bit : ∀ (_carry : α → Bool) (_bits : β → Bool),
      (α → Bool))
    (x : β' → ℕ → Bool) (i : ℕ)
    (changeVars : β → β') :
    propagateCarry init_carry next_bit (λ b => x (changeVars b)) i =
    propagateCarry init_carry (λ (carry : α → Bool) (bits : β' → Bool) =>
      next_bit carry (λ b => bits (changeVars b))) x i := by
  induction i
  . simp
  . simp [*]

lemma propagate_changeVars {β' : Type}
    (init_carry : α → Bool)
    (next_bit : ∀ (_carry : α → Bool) (_bits : β → Bool),
      (α → Bool) × Bool)
    (x : β' → ℕ → Bool) (i : ℕ)
    (changeVars : β → β') :
    propagate init_carry next_bit (λ b => x (changeVars b)) i =
    propagate init_carry (λ (carry : α → Bool) (bits : β' → Bool) =>
      next_bit carry (λ b => bits (changeVars b))) x i := by
  induction' i with i ih
  . rfl
  . simp only [propagate_succ, propagateCarry_changeVars, ih]

open Term

lemma id_eq_propagate (x : ℕ → Bool) :
    x = propagate Empty.elim (λ _ (y : Unit → Bool) => (Empty.elim, y ())) (λ _ => x) := by
  ext n; cases n <;> rfl

lemma zero_eq_propagate :
    zeroSeq = propagate Empty.elim (λ (_ _ : Empty → Bool) => (Empty.elim, false)) Empty.elim := by
  ext n; cases n <;> rfl

lemma one_eq_propagate :
    oneSeq = propagate (λ _ : Unit => true)
      (λ f (_ : Empty → Bool) => (λ _ => false, f ())) Empty.elim := by
  ext n
  match n with
  | 0 => rfl
  | 1 => rfl
  | n+2 => simp [oneSeq, propagate_succ]

lemma and_eq_propagate (x y : ℕ → Bool) :
    andSeq x y = propagate Empty.elim
      (λ _ (y : Bool → Bool) => (Empty.elim, y true && y false)) (λ b => cond b x y) := by
  ext n; cases n <;> simp [propagate, propagateAux, andSeq]

lemma or_eq_propagate (x y : ℕ → Bool) :
    orSeq x y = propagate Empty.elim
      (λ _ (y : Bool → Bool) => (Empty.elim, y true || y false)) (λ b => cond b x y) := by
  ext n; cases n <;> simp [propagate, propagateAux, orSeq]

lemma xor_eq_propagate (x y : ℕ → Bool) :
    xorSeq x y = propagate Empty.elim
      (λ _ (y : Bool → Bool) => (Empty.elim, xor (y true) (y false))) (λ b => cond b x y) := by
  ext n; cases n <;> simp [propagate, propagateAux, xorSeq]

lemma not_eq_propagate (x : ℕ → Bool) :
    notSeq x = propagate Empty.elim (λ _ (y : Unit → Bool) => (Empty.elim, !(y ()))) (λ _ => x) := by
  ext n; cases n <;> simp [propagate, propagateAux, notSeq]

lemma ls_eq_propagate (b : Bool) (x : ℕ → Bool) :
    lsSeq b x = propagate (λ _ : Unit => b)
      (λ (carry x : Unit → Bool) => (x, carry ())) (λ _ => x) := by
  ext n
  match n with
  | 0 => rfl
  | 1 => rfl
  | n+2 => simp [lsSeq, propagate_succ]

lemma addSeqAux_eq_propagateCarry (x y : ℕ → Bool) (n : ℕ) :
    (addSeqAux x y n).2 = propagateCarry (λ _ => false)
      (λ (carry : Unit → Bool) (bits : Bool → Bool) =>
        λ _ => (bits true && bits false) || (bits false && carry ()) || (bits true && carry ()))
    (λ b => cond b x y) n () := by
  induction n <;> simp [addSeqAux, *]

lemma add_eq_propagate (x y : ℕ → Bool) :
    addSeq x y = propagate (λ _ => false)
      (λ (carry : Unit → Bool) (bits : Bool → Bool) =>
        (λ _ => (bits true && bits false) || (bits false && carry ()) || (bits true && carry ()),
          _root_.xor (bits true) (_root_.xor (bits false) (carry ()))))
    (λ b => cond b x y) := by
  ext n
  match n with
  | 0 => simp [addSeq, addSeqAux]
  | 1 => simp [addSeq, addSeqAux, propagate, propagateAux]
  | n+2 => simp [addSeq, addSeqAux, addSeqAux_eq_propagateCarry, propagate_succ]

lemma subSeqAux_eq_propagateCarry (x y : ℕ → Bool) (n : ℕ) :
    (subSeqAux x y n).2 = propagateCarry (λ _ => false)
      (λ (carry : Unit → Bool) (bits : Bool → Bool) =>
        λ _ => (!(bits true) && (bits false)) ||
          (!(_root_.xor (bits true) (bits false))) && carry ())
    (λ b => cond b x y) n () := by
  induction n <;> simp [subSeqAux, *]

lemma sub_eq_propagate (x y : ℕ → Bool) :
    subSeq x y = propagate (λ _ => false)
      (λ (carry : Unit → Bool) (bits : Bool → Bool) =>
        (λ _ => (!(bits true) && (bits false)) ||
          ((!(_root_.xor (bits true) (bits false))) && carry ()),
          _root_.xor (bits true) (_root_.xor (bits false) (carry ()))))
    (λ b => cond b x y) := by
  ext n
  match n with
  | 0 => simp [subSeq, subSeqAux]
  | 1 => simp [subSeq, subSeqAux, propagate, propagateAux]
  | n+2 => simp [subSeq, subSeqAux, subSeqAux_eq_propagateCarry, propagate_succ]

lemma negSeqAux_eq_propagateCarry (x : ℕ → Bool) (n : ℕ) :
    (negSeqAux x n).2 = propagateCarry (λ _ => true)
      (λ (carry : Unit → Bool) (bits : Unit → Bool) =>
        λ _ => (!(bits ())) && (carry ()))
    (λ _ => x) n () := by
  induction n <;> simp [negSeqAux, *]

lemma neg_eq_propagate (x : ℕ → Bool) :
    negSeq x = propagate (λ _ => true)
      (λ (carry : Unit → Bool) (bits : Unit → Bool) =>
        (λ _ => (!(bits ())) && (carry ()), _root_.xor (!(bits ())) (carry ())))
    (λ _ => x) := by
  ext n
  match n with
  | 0 => simp [negSeq, negSeqAux]
  | 1 => simp [negSeq, negSeqAux, propagate, propagateAux]
  | n+2 => simp [negSeq, negSeqAux, negSeqAux_eq_propagateCarry, propagate_succ]

lemma incrSeqAux_eq_propagateCarry (x : ℕ → Bool) (n : ℕ) :
    (incrSeqAux x n).2 = propagateCarry (λ _ => true)
      (λ (carry : Unit → Bool) (bits : Unit → Bool) =>
        λ _ => (bits ()) && carry ())
    (λ _ => x) n () := by
  induction n <;> simp [incrSeqAux, *]

lemma incr_eq_propagate (x : ℕ → Bool) :
    incrSeq x = propagate (λ _ => true)
      (λ (carry : Unit → Bool) (bits : Unit → Bool) =>
        (λ _ => (bits ()) && carry (), _root_.xor (bits ()) (carry ())))
    (λ _ => x) := by
  ext n
  match n with
  | 0 => simp [incrSeq, incrSeqAux]
  | 1 => simp [incrSeq, incrSeqAux, propagate, propagateAux]
  | n+2 => simp [incrSeq, incrSeqAux, incrSeqAux_eq_propagateCarry, propagate_succ]

lemma decrSeqAux_eq_propagateCarry (x : ℕ → Bool) (n : ℕ) :
    (decrSeqAux x n).2 = propagateCarry (λ _ => true)
      (λ (carry : Unit → Bool) (bits : Unit → Bool) =>
        λ _ => (!(bits ())) && carry ())
    (λ _ => x) n () := by
  induction n <;> simp [decrSeqAux, *]

lemma decr_eq_propagate (x : ℕ → Bool) :
    decrSeq x = propagate (λ _ => true)
      (λ (carry : Unit → Bool) (bits : Unit → Bool) =>
        (λ _ => (!(bits ())) && carry (), _root_.xor (bits ()) (carry ())))
    (λ _ => x) := by
  ext n
  match n with
  | 0 => simp [decrSeq, decrSeqAux]
  | 1 => simp [decrSeq, decrSeqAux, propagate, propagateAux]
  | n+2 => simp [decrSeq, decrSeqAux, decrSeqAux_eq_propagateCarry, propagate_succ]

structure PropagateStruc (arity : Type) : Type 1 :=
  ( α  : Type )
  [ i : Fintype α ]
  ( init_carry : α → Bool )
  ( next_bit : ∀ (_carry : α → Bool) (_bits : arity → Bool),
      (α → Bool) × Bool )

attribute [instance] PropagateStruc.i

namespace PropagateStruc

variable {arity : Type} (p : PropagateStruc arity)

def eval : (arity → ℕ → Bool) → ℕ → Bool :=
  propagate p.init_carry p.next_bit

def changeVars {arity2 : Type} (changeVars : arity → arity2) :
    PropagateStruc arity2 :=
  { α := p.α,
    i := p.i,
    init_carry := p.init_carry,
    next_bit := λ carry bits => p.next_bit carry (fun i => bits (changeVars i)) }

def compose [Fintype arity]
  (new_arity : Type)
    (q_arity : arity → Type)
    (vars : ∀ (a : arity), q_arity a → new_arity)
    (q : ∀ (a : arity), PropagateStruc (q_arity a)) :
    PropagateStruc (new_arity) :=
  { α := p.α ⊕ (Σ a, (q a).α),
    i := by letI := p.i;  infer_instance,
    init_carry := Sum.elim p.init_carry (λ x => (q x.1).init_carry x.2),
    next_bit := λ carry bits =>
      let f : ∀ (a : arity), ((q a).α → Bool) × Bool := λ a => (q a).next_bit (λ d =>
          carry (inr ⟨a, d⟩)) (λ d => bits (vars a d))
      let g : (p.α → Bool) × Bool := (p.next_bit (carry ∘ inl) (λ a => (f a).2))
      (Sum.elim g.1 (λ x => (f x.1).1 x.2), g.2) }

lemma eval_compose [Fintype arity]
    (new_arity : Type)
    (q_arity : arity → Type)
    (vars : ∀ (a : arity), q_arity a → new_arity)
    (q : ∀ (a : arity), PropagateStruc (q_arity a))
    (x : new_arity → ℕ → Bool):
    (p.compose new_arity q_arity vars q).eval x =
    p.eval (λ a => (q a).eval (fun i => x (vars _ i))) := by
  ext n; simp only [eval, compose, propagate_propagate]

def and : PropagateStruc Bool :=
  { α := Empty,
    i := by infer_instance,
    init_carry := Empty.elim,
    next_bit := λ _carry bits => (Empty.elim, bits true && bits false) }

@[simp] lemma eval_and (x : Bool → ℕ → Bool) : and.eval x = andSeq (x true) (x false) := by
  ext n; cases n <;> simp [and, andSeq, eval, propagate_succ]

def or : PropagateStruc Bool :=
  { α := Empty,
    i := by infer_instance,
    init_carry := Empty.elim,
    next_bit := λ _carry bits => (Empty.elim, bits true || bits false) }

@[simp] lemma eval_or (x : Bool → ℕ → Bool) : or.eval x = orSeq (x true) (x false) := by
  ext n; cases n <;> simp [or, orSeq, eval, propagate_succ]

def xor : PropagateStruc Bool :=
  { α := Empty,
    i := by infer_instance,
    init_carry := Empty.elim,
    next_bit := λ _carry bits => (Empty.elim, _root_.xor (bits true) (bits false)) }

@[simp] lemma eval_xor (x : Bool → ℕ → Bool) : xor.eval x = xorSeq (x true) (x false) := by
  ext n; cases n <;> simp [xor, xorSeq, eval, propagate_succ]

  def add : PropagateStruc Bool :=
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


def sub : PropagateStruc Bool :=
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

def neg : PropagateStruc Unit :=
  { α := Unit,
    i := by infer_instance,
    init_carry := λ _ => true,
    next_bit := λ (carry : Unit → Bool) (bits : Unit → Bool) =>
      (λ _ => (!(bits ())) && (carry ()), _root_.xor (!(bits ())) (carry ())) }

@[simp] lemma eval_neg (x : Unit → ℕ → Bool) : neg.eval x = negSeq (x ()) := by
  dsimp [neg, eval]
  rw [neg_eq_propagate]

def not : PropagateStruc Unit :=
{ α := Empty,
  i := by infer_instance,
  init_carry := Empty.elim,
  next_bit := λ _carry bits => (Empty.elim, !(bits ())) }

@[simp] lemma eval_not (x : Unit → ℕ → Bool) : not.eval x = notSeq (x ()) := by
  ext n; cases n <;> simp [not, notSeq, eval, propagate_succ]

def zero : PropagateStruc (Fin 0) :=
  { α := Empty,
    i := by infer_instance,
    init_carry := Empty.elim,
    next_bit := λ _carry _bits => (Empty.elim, false) }

@[simp] lemma eval_zero (x : Fin 0 → ℕ → Bool) : zero.eval x = zeroSeq := by
  ext n; cases n <;> simp [zero, zeroSeq, eval, propagate_succ]

def one : PropagateStruc (Fin 0) :=
  { α := Unit,
    i := by infer_instance,
    init_carry := λ _ => true,
    next_bit := λ carry _bits => (λ _ => false, carry ()) }

@[simp] lemma eval_one (x : Fin 0 → ℕ → Bool) : one.eval x = oneSeq := by
  ext n; cases n <;> simp [one, oneSeq, eval, propagate_succ2, @eq_comm _ false]

def negOne : PropagateStruc (Fin 0) :=
  { α := Empty,
    i := by infer_instance,
    init_carry := Empty.elim,
    next_bit := λ _carry _bits => (Empty.elim, true) }

@[simp] lemma eval_negOne (x : Fin 0 → ℕ → Bool) : negOne.eval x = negOneSeq := by
  ext n; cases n <;> simp [negOne, negOneSeq, eval, propagate_succ2]

def ls (b : Bool) : PropagateStruc Unit :=
  { α := Unit,
    i := by infer_instance,
    init_carry := λ _ => b,
    next_bit := λ carry bits => (bits, carry ()) }

@[simp] lemma eval_ls (b : Bool) (x : Unit → ℕ → Bool) : (ls b).eval x = lsSeq b (x ()) := by
  ext n; cases n <;> simp [ls, lsSeq, eval, propagate_succ2]

def var (n : ℕ) : PropagateStruc (Fin (n+1)) :=
  { α := Empty,
    i := by infer_instance,
    init_carry := Empty.elim,
    next_bit := λ _carry bits => (Empty.elim, bits (Fin.last n)) }

@[simp] lemma eval_var (n : ℕ) (x : Fin (n+1) → ℕ → Bool) : (var n).eval x = x (Fin.last n) := by
  ext m; cases m <;> simp [var, eval, propagate_succ]

def incr : PropagateStruc Unit :=
  { α := Unit,
    i := by infer_instance,
    init_carry := λ _ => true,
    next_bit := λ carry bits => (λ _ => bits () && carry (), _root_.xor (bits ()) (carry ())) }

@[simp] lemma eval_incr (x : Unit → ℕ → Bool) : incr.eval x = incrSeq (x ()) := by
  dsimp [incr, eval]
  rw [incr_eq_propagate]

def decr : PropagateStruc Unit :=
  { α := Unit,
    i := by infer_instance,
    init_carry := λ _ => true,
    next_bit := λ carry bits => (λ _ => !(bits ()) && carry (), _root_.xor (bits ()) (carry ())) }

@[simp] lemma eval_decr (x : Unit → ℕ → Bool) : decr.eval x = decrSeq (x ()) := by
  dsimp [decr, eval]
  rw [decr_eq_propagate]

end PropagateStruc

structure PropagateSolution (t : Term) extends PropagateStruc (Fin (arity t)) :=
( good : t.evalFin = toPropagateStruc.eval )

def composeUnary
    (p : PropagateStruc Unit)
    {t : Term}
    (q : PropagateSolution t) :
    PropagateStruc (Fin (arity t)) :=
  p.compose
    (Fin (arity t))
    _
    (λ _ => id)
    (λ _ => q.toPropagateStruc)
def X := @Bool.casesOn
def composeBinary
    (p : PropagateStruc Bool)
    {t₁ t₂ : Term}
    (q₁ : PropagateSolution t₁)
    (q₂ : PropagateSolution t₂) :
    PropagateStruc (Fin (max (arity t₁) (arity t₂))) :=
  p.compose (Fin (max (arity t₁) (arity t₂)))
    (λ b => Fin (cond b (arity t₁) (arity t₂)))
    (λ b i => Fin.castLE (by cases b <;> simp) i)
    (λ b => match b with
      | true => q₁.toPropagateStruc
      | false => q₂.toPropagateStruc)

@[simp] lemma composeUnary_eval
    (p : PropagateStruc Unit)
    {t : Term}
    (q : PropagateSolution t)
    (x : Fin (arity t) → ℕ → Bool) :
    (composeUnary p q).eval x = p.eval (λ _ => t.evalFin x) := by
  rw [composeUnary, PropagateStruc.eval_compose, q.good]; rfl

@[simp] lemma composeBinary_eval
    (p : PropagateStruc Bool)
    {t₁ t₂ : Term}
    (q₁ : PropagateSolution t₁)
    (q₂ : PropagateSolution t₂)
    (x : Fin (max (arity t₁) (arity t₂)) → ℕ → Bool) :
    (composeBinary p q₁ q₂).eval x = p.eval
      (λ b => cond b (t₁.evalFin (fun i => x (Fin.castLE (by simp) i)))
                  (t₂.evalFin (fun i => x (Fin.castLE (by simp) i)))) := by
  rw [composeBinary, PropagateStruc.eval_compose, q₁.good, q₂.good]
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
  { toPropagateStruc := PropagateStruc.var n,
    good := by ext; simp [Term.evalFin] }
| zero =>
  { toPropagateStruc := PropagateStruc.zero,
    good := by ext; simp [Term.evalFin] }
| one =>
  { toPropagateStruc := PropagateStruc.one,
    good := by ext; simp [Term.evalFin] }
| negOne =>
  { toPropagateStruc := PropagateStruc.negOne,
    good := by ext; simp [Term.evalFin] }
| Term.and t₁ t₂ =>
  let q₁ := termEvalEqPropagate t₁
  let q₂ := termEvalEqPropagate t₂
  { toPropagateStruc := composeBinary PropagateStruc.and q₁ q₂,
    good := by ext; simp }
| Term.or t₁ t₂ =>
  let q₁ := termEvalEqPropagate t₁
  let q₂ := termEvalEqPropagate t₂
  { toPropagateStruc := composeBinary PropagateStruc.or q₁ q₂,
    good := by ext; simp }
| Term.xor t₁ t₂ =>
  let q₁ := termEvalEqPropagate t₁
  let q₂ := termEvalEqPropagate t₂
  { toPropagateStruc := composeBinary PropagateStruc.xor q₁ q₂,
    good := by ext; simp }
| ls b t =>
  let q := termEvalEqPropagate t
  { toPropagateStruc := by dsimp [arity]; exact composeUnary (PropagateStruc.ls b) q,
    good := by ext; simp }
| Term.not t =>
  let q := termEvalEqPropagate t
  { toPropagateStruc := by dsimp [arity]; exact composeUnary PropagateStruc.not q,
    good := by ext; simp }
| add t₁ t₂ =>
  let q₁ := termEvalEqPropagate t₁
  let q₂ := termEvalEqPropagate t₂
  { toPropagateStruc := composeBinary PropagateStruc.add q₁ q₂,
    good := by ext; simp }
| sub t₁ t₂ =>
  let q₁ := termEvalEqPropagate t₁
  let q₂ := termEvalEqPropagate t₂
  { toPropagateStruc := composeBinary PropagateStruc.sub q₁ q₂,
    good := by ext; simp }
| neg t =>
  let q := termEvalEqPropagate t
  { toPropagateStruc := by dsimp [arity]; exact composeUnary PropagateStruc.neg q,
    good := by ext; simp }
| incr t =>
  let q := termEvalEqPropagate t
  { toPropagateStruc := by dsimp [arity]; exact composeUnary PropagateStruc.incr q,
    good := by ext; simp }
| decr t =>
  let q := termEvalEqPropagate t
  { toPropagateStruc := by dsimp [arity]; exact composeUnary PropagateStruc.decr q,
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
