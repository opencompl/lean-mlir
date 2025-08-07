import Mathlib.Data.Finset.Card
import Mathlib.Data.List.Pi
import Mathlib.Data.Finset.Union
import Mathlib.Data.Fin.Basic
import Mathlib.Data.Finset.Basic
import Mathlib.Data.Finset.Defs
import Mathlib.Data.Fintype.Basic

open Std Sat AIG


universe u v

/--
`Circuit α` is a type of (partly normalized) Boolean circuits,
where `α` gives the type of free variables in the circuit.

Morally, it represents a function `Bool → ⋯ → Bool`, where the number of `Bool` arguments is equal
to the arity of `α`. See also `eval` for the explicit conversion of a circuit to a similar function
-/
inductive Circuit (α : Type u) : Type u
  | tru : Circuit α
  | fals : Circuit α
  /-- `var b x` represents literal `x` if `b = true` or the negated literat `¬x` if `b = false` -/
  | var : Bool → α → Circuit α
  | and : Circuit α → Circuit α → Circuit α
  | or : Circuit α → Circuit α → Circuit α
  | xor : Circuit α → Circuit α → Circuit α
deriving Repr, DecidableEq

open Lean in
def formatCircuit {α : Type u} (formatVar : α → Format)  (c : Circuit α) : Lean.Format :=
  match c with
  | .tru => "T"
  | .fals => "F"
  | .var b v =>
     let vstr := "v:" ++ formatVar v
     if b then vstr else "!" ++ vstr
  | .and l r => s!"(and {formatCircuit formatVar l} {formatCircuit formatVar r})"
  | .or l r => s!"(or {formatCircuit formatVar l} {formatCircuit formatVar r})"
  | .xor l r => s!"(xor {formatCircuit formatVar l} {formatCircuit formatVar r})"

namespace Circuit

variable {α : Type u} {β : Type v}

/--
Compute the size of the circuit.
Leaf nodes take 1 size, and internal nodes take 1 + size of children.
-/
def size (α : Type u) : Circuit α → Nat
| tru | fals | var .. => 1
| and l r | or l r | xor l r => 1 + l.size  + r.size

def vars [DecidableEq α] : Circuit α → List α
  | tru => []
  | fals => []
  | var _ x => [x]
  | and c₁ c₂ => (vars c₁ ++ vars c₂).dedup
  | or c₁ c₂ => (vars c₁ ++ vars c₂).dedup
  | xor c₁ c₂ => (vars c₁ ++ vars c₂).dedup

theorem nodup_vars [DecidableEq α] (c : Circuit α) : c.vars.Nodup := by
  cases c <;> simp [vars, List.nodup_dedup]

def varsFinset [DecidableEq α] (c : Circuit α) : Finset α :=
  ⟨c.vars, nodup_vars c⟩

lemma mem_varsFinset [DecidableEq α] {c : Circuit α} :
    ∀ {x : α}, x ∈ c.varsFinset ↔ x ∈ c.vars := by
  simp [varsFinset]

@[simp]
def eval : Circuit α → (α → Bool) → Bool
  | tru, _ => true
  | fals, _ => false
  | var b x, f => if b then f x else !(f x)
  | and c₁ c₂, f => (eval c₁ f) && (eval c₂ f)
  | or c₁ c₂, f => (eval c₁ f) || (eval c₂ f)
  | xor c₁ c₂, f => Bool.xor (eval c₁ f) (eval c₂ f)

@[simp] def evalv [DecidableEq α] : ∀ (c : Circuit α), (∀ a ∈ vars c, Bool) → Bool
  | tru, _ => true
  | fals, _ => false
  | var b x, f => if b then f x (by simp [vars]) else !(f x (by simp [vars]))
  | and c₁ c₂, f => (evalv c₁ (fun i hi => f i (by simp [hi, vars]))) &&
    (evalv c₂ (fun i hi => f i (by simp [hi, vars])))
  | or c₁ c₂, f => (evalv c₁ (fun i hi => f i (by simp [hi, vars]))) ||
    (evalv c₂ (fun i hi => f i (by simp [hi, vars])))
  | xor c₁ c₂, f => Bool.xor (evalv c₁ (fun i hi => f i (by simp [hi, vars])))
    (evalv c₂ (fun i hi => f i (by simp [hi, vars])))

lemma eval_eq_evalv [DecidableEq α] : ∀ (c : Circuit α) (f : α → Bool),
    eval c f = evalv c (λ x _ => f x)
  | tru, _ => rfl
  | fals, _ => rfl
  | var _ x, f => rfl
  | and c₁ c₂, f => by rw [eval, evalv, eval_eq_evalv c₁, eval_eq_evalv c₂]
  | or c₁ c₂, f => by rw [eval, evalv, eval_eq_evalv c₁, eval_eq_evalv c₂]
  | xor c₁ c₂, f => by rw [eval, evalv, eval_eq_evalv c₁, eval_eq_evalv c₂]

@[simp] def ofBool (b : Bool) : Circuit α :=
  if b then tru else fals

instance : LE (Circuit α) :=
  ⟨λ c₁ c₂ => ∀ f, eval c₁ f → eval c₂ f⟩

instance : Preorder (Circuit α) :=
  { inferInstanceAs (LE (Circuit α)) with
    le_refl := λ c f h => h,
    le_trans := λ c₁ c₂ c₃ h₁₂ h₂₃ f h₁ => h₂₃ f (h₁₂ f h₁) }

lemma le_def : ∀ (c₁ c₂ : Circuit α), c₁ ≤ c₂ ↔ ∀ f, eval c₁ f → eval c₂ f :=
  λ _ _ => Iff.rfl

lemma exists_eval_iff_exists_evalv [DecidableEq α] (c : Circuit α) :
    (∃ x, eval c x) ↔ ∃ x, evalv c x := by
  constructor
  · rintro ⟨x, hx⟩
    use λ a _ => x a
    rw [eval_eq_evalv] at hx
    exact hx
  · rintro ⟨x, hx⟩
    refine ⟨λ a => dite (a ∈ c.vars) (x a) (λ _ => false), ?_⟩
    convert hx
    rw [eval_eq_evalv]
    congr 1
    ext i hi
    simp [hi]

def simplifyAnd : Circuit α → Circuit α → Circuit α
  | tru, c => c
  | c, tru => c
  | fals, _ => fals
  | _, fals => fals
  | c₁, c₂ => and c₁ c₂

instance : AndOp (Circuit α) := ⟨Circuit.simplifyAnd⟩

theorem and_def {α : Type _} (c d : Circuit α) :
  (c &&& d) = Circuit.simplifyAnd c d := rfl

@[simp] lemma tru_and (c : Circuit α) :
  Circuit.tru &&& c = c := by
  simp [Circuit.and_def, Circuit.simplifyAnd]

@[simp] lemma fals_and (c : Circuit α) :
  Circuit.fals &&& c = Circuit.fals := by
  simp [Circuit.and_def, Circuit.simplifyAnd]
  rcases c <;> simp

@[simp] lemma and_fals (c : Circuit α) :
  c &&& Circuit.fals = Circuit.fals := by
  simp [Circuit.and_def, Circuit.simplifyAnd]
  rcases c <;> simp

@[simp] lemma and_tru (c : Circuit α) :
  c &&& Circuit.tru = c := by
  simp [Circuit.and_def, Circuit.simplifyAnd]
  rcases c <;> simp

@[simp] lemma eval_and : ∀ (c₁ c₂ : Circuit α) (f : α → Bool),
    (eval (c₁ &&& c₂) f) = ((eval c₁ f) && (eval c₂ f)) := by
  intros c₁ c₂ f
  cases c₁ <;> cases c₂ <;> simp [simplifyAnd, AndOp.and, HAnd.hAnd]

theorem varsFinset_and [DecidableEq α] (c₁ c₂ : Circuit α) :
    (varsFinset (c₁ &&& c₂)) ⊆ (varsFinset c₁ ∪ varsFinset c₂) := by
  cases c₁ <;> cases c₂ <;> simp [vars, simplifyAnd, varsFinset, Finset.subset_iff,
    AndOp.and, HAnd.hAnd]

def simplifyOr : Circuit α → Circuit α → Circuit α
  | tru, _ => tru
  | _, tru => tru
  | fals, c => c
  | c, fals => c
  | c₁, c₂ => or c₁ c₂

instance : OrOp (Circuit α) := ⟨Circuit.simplifyOr⟩

theorem or_def {α : Type _} (c d : Circuit α) :
  (c ||| d) = Circuit.simplifyOr c d := rfl

@[simp]
lemma fals_or (c : Circuit α) :
  Circuit.fals ||| c = c := by
  simp [Circuit.or_def, Circuit.simplifyOr]
  rcases c <;> simp

@[simp]
lemma tru_or (c : Circuit α) :
  Circuit.tru ||| c = Circuit.tru := by
  simp [Circuit.or_def, Circuit.simplifyOr]

@[simp]
lemma or_fals (c : Circuit α) :
  c ||| Circuit.fals = c := by
  simp [Circuit.or_def, Circuit.simplifyOr]
  rcases c <;> simp

@[simp]
lemma or_tru (c : Circuit α) :
  c ||| Circuit.tru = Circuit.tru := by
  simp [Circuit.or_def, Circuit.simplifyOr]
  rcases c <;> simp

@[simp] lemma eval_or : ∀ (c₁ c₂ : Circuit α) (f : α → Bool),
    (eval (c₁ ||| c₂) f) = ((eval c₁ f) || (eval c₂ f)) := by
  intros c₁ c₂ f
  cases c₁ <;> cases c₂ <;> simp [Circuit.simplifyOr, eval,
    OrOp.or, HOr.hOr]

theorem vars_or [DecidableEq α] (c₁ c₂ : Circuit α) :
    (vars (c₁ ||| c₂)) ⊆ (vars c₁ ++ vars c₂).dedup := by
  cases c₁ <;> cases c₂ <;> simp [vars, simplifyOr,
    OrOp.or, HOr.hOr]

theorem varsFinset_or [DecidableEq α] (c₁ c₂ : Circuit α) :
    (varsFinset (c₁ ||| c₂)) ⊆ (varsFinset c₁ ∪ varsFinset c₂) := by
  cases c₁ <;> cases c₂ <;> simp [vars, simplifyOr, varsFinset, Finset.subset_iff,
    OrOp.or, HOr.hOr]

def simplifyNot : Circuit α → Circuit α
  | tru => fals
  | fals => tru
  | xor a b => xor (simplifyNot a) b
  | and a b => or (simplifyNot a) (simplifyNot b)
  | or a b => and (simplifyNot a) (simplifyNot b)
  | var b a => var (!b) a

instance : Complement (Circuit α) := ⟨Circuit.simplifyNot⟩

@[simp]
theorem simplifyNot_eq_complement (c : Circuit α) :
    simplifyNot c = ~~~ c := rfl

@[simp] lemma eval_complement : ∀ (c : Circuit α) (f : α → Bool),
    eval (~~~ c) f = !(eval c f)
  | tru, f => rfl
  | fals, f => rfl
  | xor a b, f => by
    erw [eval, eval_complement a, eval]
    cases eval a f <;> cases eval b f <;> rfl
  | and a b, f => by
    erw [eval, eval, eval_complement a, eval_complement b, Bool.not_and]
  | or a b, f => by
    erw [eval, eval, eval_complement a, eval_complement b, Bool.not_or]
  | var true a, f => by simp [eval, ←simplifyNot_eq_complement, simplifyNot]
  | var false a, f => by simp [eval, ←simplifyNot_eq_complement, simplifyNot]

theorem varsFinset_complement [DecidableEq α] (c : Circuit α) :
    (varsFinset (~~~ c)) ⊆ varsFinset c := by
  intro x
  induction c <;> simp [simplifyNot, ←simplifyNot_eq_complement, vars, mem_varsFinset]
  <;> aesop

@[simp]
def simplifyXor : Circuit α → Circuit α → Circuit α
  | fals, c => c
  | c, fals => c
  | tru, c => ~~~ c
  | c, tru => ~~~ c
  | c₁, c₂ => xor c₁ c₂

theorem _root_.Bool.xor_not_left' (a b : Bool) :
    Bool.xor (!a) b = !Bool.xor a b := by
  cases a <;> cases b <;> rfl

instance : XorOp (Circuit α) := ⟨Circuit.simplifyXor⟩

@[simp] lemma eval_xor : ∀ (c₁ c₂ : Circuit α) (f : α → Bool),
    eval (c₁ ^^^ c₂) f = Bool.xor (eval c₁ f) (eval c₂ f) := by
  intros c₁ c₂ f
  cases c₁ <;> cases c₂ <;> simp [simplifyXor, HXor.hXor, XorOp.xor]

set_option maxHeartbeats 1000000
theorem vars_simplifyXor [DecidableEq α] (c₁ c₂ : Circuit α) :
    (vars (simplifyXor c₁ c₂)) ⊆ (vars c₁ ++ vars c₂).dedup := by
  intro x
  simp only [List.mem_dedup, List.mem_append]
  induction c₁ <;> induction c₂ <;> simp only [simplifyXor, vars,
    ← simplifyNot_eq_complement, simplifyNot] at * <;> aesop

theorem varsFinset_simplifyXor [DecidableEq α] (c₁ c₂ : Circuit α) :
    (varsFinset (simplifyXor c₁ c₂)) ⊆ (varsFinset c₁ ∪ varsFinset c₂) := by
  have := vars_simplifyXor c₁ c₂
  intro x
  simpa only [Finset.subset_iff, List.subset_def, mem_varsFinset,
    List.mem_dedup, List.subset_def, Finset.mem_union, List.mem_append]
      using this

theorem varsFinset_xor [DecidableEq α] (c₁ c₂ : Circuit α) :
    (varsFinset (c₁ ^^^ c₂)) ⊆ (varsFinset c₁ ∪ varsFinset c₂) :=
  varsFinset_simplifyXor c₁ c₂

def map : ∀ (_c : Circuit α) (_f : α → β), Circuit β
  | tru, _ => tru
  | fals, _ => fals
  | var b x, f => var b (f x)
  | and c₁ c₂, f => (map c₁ f) &&& (map c₂ f)
  | or c₁ c₂, f => (map c₁ f) ||| (map c₂ f)
  | xor c₁ c₂, f => (map c₁ f) ^^^ (map c₂ f)

/--
Map of 'identity' does not change the evaluation of the circuit.
Funnily, it *can* structually change the circuit,
since it rebuilds the circuit, while simplifying it during rebuilding.
-/
@[simp]
theorem eval_map_id_eq (c : Circuit α) (env : α → Bool) :
    (Circuit.map c (id : α → α)).eval env = c.eval env := by
  induction c <;> simp [Circuit.map, *] at *

@[simp]
theorem eval_map_id_eq' {c : Circuit α} {f : α → Bool} :
    eval (map c fun v => v) f = eval c f := by
  induction c <;> simp [Circuit.map, *] at *

@[simp]
theorem map_tru (f : α → β) :
    Circuit.tru.map f = Circuit.tru := rfl

@[simp]
theorem map_fals (f : α → β) :
    Circuit.fals.map f = Circuit.fals := rfl

lemma eval_map {c : Circuit α} {f : α → β} {g : β → Bool} :
    eval (map c f) g = eval c (λ x => g (f x)) := by
  induction c <;> simp [*, Circuit.map, eval] at *

@[simp]
lemma fals_map (f : α → β) :
  fals.map f = Circuit.fals := rfl

@[simp]
lemma var_map (f : α → β) (b : Bool) (x : α) :
  (Circuit.var b x).map f = Circuit.var b (f x) := rfl

@[simp]
lemma tru_map (f : α → β) :
  Circuit.tru.map f = Circuit.tru := rfl

def simplify : ∀ (_c : Circuit α), Circuit α
  | tru => tru
  | fals => fals
  | var b x => var b x
  | and c₁ c₂ => (simplify c₁) &&& (simplify c₂)
  | or c₁ c₂ => (simplify c₁) ||| (simplify c₂)
  | xor c₁ c₂ => (simplify c₁) ^^^ (simplify c₂)


def ite (cond t f : Circuit α) : Circuit α :=
  (cond &&& t) ||| (~~~ cond &&& f)

lemma ite_def (cond t f : Circuit α) :
  Circuit.ite cond t f = (cond &&& t) ||| (~~~ cond &&& f) := rfl

@[simp] lemma eval_ite {cond t f : Circuit α} :
    (ite cond t f).eval g =
    if cond.eval g then t.eval g else f.eval g := by
  simp only [ite_def, eval_or, eval_and, eval_complement]
  rcases heval : cond.eval g <;> simp

theorem ite_eq_of_eq_true {cond t f : Circuit α} (h : cond.eval g = true) :
    (ite cond t f).eval g = t.eval g := by
  simp [ite_def, h]

theorem ite_eq_of_eq_false {cond t f : Circuit α} (h : cond.eval g = false) :
    (ite cond t f).eval g = f.eval g := by
  simp [ite_def, h]

@[simp] lemma eval_simplify : ∀ (c : Circuit α) (f : α → Bool),
    eval (simplify c) f = eval c f
  | tru, _ => rfl
  | fals, _ => rfl
  | var b x, f => rfl
  | and c₁ c₂, f => by rw [simplify]; simp [eval_simplify c₁, eval_simplify c₂]
  | or c₁ c₂, f => by rw [simplify]; simp [eval_simplify c₁, eval_simplify c₂]
  | xor c₁ c₂, f => by rw [simplify]; simp [eval_simplify c₁, eval_simplify c₂]

def sumVarsLeft [DecidableEq α] [DecidableEq β] : Circuit (α ⊕ β) → List α
  | tru => []
  | fals => []
  | var _ (Sum.inl x) => [x]
  | var _ (Sum.inr _) => []
  | and c₁ c₂ => (sumVarsLeft c₁ ++ sumVarsLeft c₂).dedup
  | or c₁ c₂ => (sumVarsLeft c₁ ++ sumVarsLeft c₂).dedup
  | xor c₁ c₂ => (sumVarsLeft c₁ ++ sumVarsLeft c₂).dedup

def sumVarsRight [DecidableEq α] [DecidableEq β] : Circuit (α ⊕ β) → List β
  | tru => []
  | fals => []
  | var _ (Sum.inl _) => []
  | var _ (Sum.inr x) => [x]
  | and c₁ c₂ => (sumVarsRight c₁ ++ sumVarsRight c₂).dedup
  | or c₁ c₂ => (sumVarsRight c₁ ++ sumVarsRight c₂).dedup
  | xor c₁ c₂ => (sumVarsRight c₁ ++ sumVarsRight c₂).dedup

lemma eval_eq_of_eq_on_vars [DecidableEq α] : ∀ {c : Circuit α} {f g : α → Bool}
    (_h : ∀ x ∈ c.vars, f x = g x), eval c f = eval c g
  | tru, _, _, _ => rfl
  | fals, _, _, _ => rfl
  | var true x, _f, _g, h => h x (by simp [vars])
  | var false x, f, g, h => by simp [eval, h x (by simp [vars])]
  | and c₁ c₂, f, g, h => by
    simp only [vars, List.mem_append, List.mem_dedup] at h
    rw [eval, eval,
      eval_eq_of_eq_on_vars (λ x hx => h x (Or.inl hx)),
      eval_eq_of_eq_on_vars (λ x hx => h x (Or.inr hx))]
  | or c₁ c₂, f, g, h => by
    simp only [vars, List.mem_append, List.mem_dedup] at h
    rw [eval, eval,
      eval_eq_of_eq_on_vars (λ x hx => h x (Or.inl hx)),
      eval_eq_of_eq_on_vars (λ x hx => h x (Or.inr hx))]
  | xor c₁ c₂, f, g, h => by
    simp only [vars, List.mem_append, List.mem_dedup] at h
    rw [eval, eval,
      eval_eq_of_eq_on_vars (λ x hx => h x (Or.inl hx)),
      eval_eq_of_eq_on_vars (λ x hx => h x (Or.inr hx))]

@[simp] lemma mem_vars_iff_mem_sumVarsLeft [DecidableEq α] [DecidableEq β] :
    ∀ {c : Circuit (α ⊕ β)} {x : α},
    (x ∈ c.sumVarsLeft) ↔ Sum.inl x ∈ c.vars
  | tru, _  => by simp [vars, sumVarsLeft]
  | fals, _  => by simp [vars, sumVarsLeft]
  | var _ (Sum.inl x), _ => by simp [vars, sumVarsLeft]
  | var _ (Sum.inr _), _ => by simp [vars, sumVarsLeft]
  | and c₁ c₂, _ => by
      simp [vars, sumVarsLeft]
      simp [mem_vars_iff_mem_sumVarsLeft (c := c₁),
            mem_vars_iff_mem_sumVarsLeft (c := c₂)]
  | or c₁ c₂, _ => by
      simp [vars, sumVarsLeft]
      simp [mem_vars_iff_mem_sumVarsLeft (c := c₁),
            mem_vars_iff_mem_sumVarsLeft (c := c₂)]
  | xor c₁ c₂, _ => by
      simp [vars, sumVarsLeft]
      simp [mem_vars_iff_mem_sumVarsLeft (c := c₁),
            mem_vars_iff_mem_sumVarsLeft (c := c₂)]

@[simp] lemma mem_vars_iff_mem_sumVarsRight [DecidableEq α] [DecidableEq β] :
    ∀ {c : Circuit (α ⊕ β)} {x : β},
    (x ∈ c.sumVarsRight) ↔ Sum.inr x ∈ c.vars
  | tru, _  => by simp [vars, sumVarsRight]
  | fals, _  => by simp [vars, sumVarsRight]
  | var _ (Sum.inl _), _ => by simp [vars, sumVarsRight]
  | var _ (Sum.inr x), _ => by simp [vars, sumVarsRight]
  | and c₁ c₂, _ => by
      simp [vars, sumVarsRight]
      simp [mem_vars_iff_mem_sumVarsRight (c := c₁),
            mem_vars_iff_mem_sumVarsRight (c := c₂)]
  | or c₁ c₂, _ => by
      simp [vars, sumVarsRight]
      simp [mem_vars_iff_mem_sumVarsRight (c := c₁),
            mem_vars_iff_mem_sumVarsRight (c := c₂)]
  | xor c₁ c₂, _ => by
      simp [vars, sumVarsRight]
      simp [mem_vars_iff_mem_sumVarsRight (c := c₁),
            mem_vars_iff_mem_sumVarsRight (c := c₂)]

theorem eval_eq_of_eq_on_sumVarsLeft_right
    [DecidableEq α] [DecidableEq β] :
    ∀ {c : Circuit (α ⊕ β)} {f g : α ⊕ β → Bool}
    (_h₁ : ∀ x ∈ c.sumVarsLeft, f (Sum.inl x) = g (Sum.inl x))
    (_h₂ : ∀ x ∈ c.sumVarsRight, f (Sum.inr x) = g (Sum.inr x)),
    eval c f = eval c g
  | tru, _, _, _, _ => rfl
  | fals, _, _, _, _ => rfl
  | var _ (Sum.inl x), f, g, h₁, _ => by simp [h₁ x (by simp [sumVarsLeft])]
  | var _ (Sum.inr x), f, g, _, h₂ => by simp [h₂ x (by simp [sumVarsRight])]
  | and c₁ c₂, f, g, h₁, h₂ => by
    simp only [sumVarsLeft, sumVarsRight, List.mem_append, List.mem_dedup] at h₁ h₂
    rw [eval, eval,
      eval_eq_of_eq_on_sumVarsLeft_right
        (λ x hx => h₁ x (Or.inl hx)) (λ x hx => h₂ x (Or.inl hx)),
      eval_eq_of_eq_on_sumVarsLeft_right
        (λ x hx => h₁ x (Or.inr hx)) (λ x hx => h₂ x (Or.inr hx))]
  | or c₁ c₂, f, g, h₁, h₂ => by
    simp only [sumVarsLeft, sumVarsRight, List.mem_append, List.mem_dedup] at h₁ h₂
    rw [eval, eval,
      eval_eq_of_eq_on_sumVarsLeft_right
        (λ x hx => h₁ x (Or.inl hx)) (λ x hx => h₂ x (Or.inl hx)),
      eval_eq_of_eq_on_sumVarsLeft_right
        (λ x hx => h₁ x (Or.inr hx)) (λ x hx => h₂ x (Or.inr hx))]
  | xor c₁ c₂, f, g, h₁, h₂ => by
    simp only [sumVarsLeft, sumVarsRight, List.mem_append, List.mem_dedup] at h₁ h₂
    rw [eval, eval,
      eval_eq_of_eq_on_sumVarsLeft_right
        (λ x hx => h₁ x (Or.inl hx)) (λ x hx => h₂ x (Or.inl hx)),
      eval_eq_of_eq_on_sumVarsLeft_right
        (λ x hx => h₁ x (Or.inr hx)) (λ x hx => h₂ x (Or.inr hx))]

def bOr : ∀ (_s : List α) (_f : α → Circuit β), Circuit β
| [], _ => fals
| a::l, f => l.foldl (λ c x => c ||| (f x)) (f a)

@[simp] lemma eval_foldl_or :
  ∀ (s : List α) (f : α → Circuit β) (c : Circuit β) (g : β → Bool),
    (eval (s.foldl (λ c x => c ||| (f x)) c) g : Prop) ↔
      eval c g ∨ (∃ a ∈ s, eval (f a) g)
| [], f, c, g => by simp
| a::l, f, c, g => by
  rw [List.foldl_cons, eval_foldl_or l]
  simp only [eval_or, Bool.or_eq_true, List.mem_cons]
  constructor
  · intro h
    rcases h with (h₁ | h₂) | ⟨a, ha⟩
    · simp [*]
    · exact Or.inr ⟨_, Or.inl rfl, h₂⟩
    · exact Or.inr ⟨_, Or.inr ha.1, ha.2⟩
  · intro h
    rcases h with h | ⟨a, rfl| ha, h⟩
    · simp [*]
    · simp [*]
    · exact Or.inr ⟨_, ha, h⟩

@[simp] lemma eval_bOr :
  ∀ {s : List α} {f : α → Circuit β} {g : β → Bool},
    eval (bOr s f) g = ∃ a ∈ s, eval (f a) g
| [], _, _ => by simp [bOr, eval]
| [a], f, g => by simp [bOr]
| a::l, f, g => by
  rw [bOr, eval_foldl_or, List.exists_mem_cons_iff]

def bAnd : ∀ (_s : List α) (_f : α → Circuit β), Circuit β
| [], _ => tru
| a::l, f => l.foldl (λ c x => c &&& (f x)) (f a)

@[simp] lemma eval_foldl_and :
    ∀ (s : List α) (f : α → Circuit β) (c : Circuit β) (g : β → Bool),
      (eval (s.foldl (λ c x => c &&& (f x)) c) g : Prop) ↔
        eval c g ∧ (∀ a ∈ s, eval (f a) g)
  | [], f, c, g => by simp
  | a::l, f, c, g => by
    rw [List.foldl_cons, eval_foldl_and l]
    simp only [eval_and, Bool.and_eq_true, List.mem_cons]
    constructor
    · intro h
      rcases h with ⟨⟨h₁, h₂⟩, h⟩
      simpa [*] using h
    · intro h
      rcases h with ⟨h₁, h₂⟩
      simp only [h₁, true_and, h₂ a (Or.inl rfl)]
      aesop

@[simp] lemma eval_bAnd :
    ∀ {s : List α} {f : α → Circuit β} {g : β → Bool},
      eval (bAnd s f) g ↔ ∀ a ∈ s, eval (f a) g
  | [], _, _ => by simp [bAnd, eval]
  | [a], f, g => by simp [bAnd]
  | a::l, f, g => by
    rw [bAnd, eval_foldl_and]; simp

/-- perform the same task as assignVars, but don't change the signature of the circuit. -/
def assignAllVars [DecidableEq α] (c : Circuit α)
  (f : α → Bool) : Circuit Empty
  := match c with
  | tru => tru
  | fals => fals
  | var b x =>
    let v := f x
    Circuit.ofBool (b = v)
  | and p q => assignAllVars p f &&& assignAllVars q f
  | or p q => assignAllVars p f ||| assignAllVars q f
  | xor p q => assignAllVars p f ^^^ assignAllVars q f

/-- Says how to evaluate asssignVars' in terms of an updated environment. -/
@[simp]
lemma eval_assignAllVars [DecidableEq α] {c : Circuit α} {f : α → Bool} :
    eval (assignAllVars c f) env = c.eval f := by
  induction c
  case tru => simp [eval, assignAllVars]
  case fals => simp [eval, assignAllVars]
  case var b x =>
    simp [assignAllVars]
    rcases fx : f x <;> rcases b <;> simp
  case and p q hp hq =>
    simp [eval, hp, hq, assignAllVars]
  case or p q hp hq =>
    simp [eval, hp, hq, assignAllVars]
  case xor p q hp hq =>
    simp [eval, hp, hq, assignAllVars]


def assignVars [DecidableEq α] :
    ∀ (c : Circuit α) (_f : ∀ (a : α) (_ha : a ∈ c.vars), β ⊕ Bool), Circuit β
  | tru, _ => tru
  | fals, _ => fals
  | var b x, f =>
    Sum.elim
      (var b)
      (λ c : Bool => if Bool.xor b c then fals else tru)
      (f x (by simp [vars]))
  | and c₁ c₂, f => (assignVars c₁ (λ x hx => f x (by simp [hx, vars]))) &&&
                    (assignVars c₂ (λ x hx => f x (by simp [hx, vars])))
  | or c₁ c₂, f =>  (assignVars c₁ (λ x hx => f x (by simp [hx, vars]))) |||
                    (assignVars c₂ (λ x hx => f x (by simp [hx, vars])))
  | xor c₁ c₂, f => (assignVars c₁ (λ x hx => f x (by simp [hx, vars]))) ^^^
                    (assignVars c₂ (λ x hx => f x (by simp [hx, vars])))

theorem _root_.List.length_le_of_subset_of_nodup {l₁ l₂ : List α}
    (hs : l₁ ⊆ l₂) (hnd : l₁.Nodup) : l₁.length ≤ l₂.length := by
  classical
  refine le_trans ?_ (List.Sublist.length_le (List.dedup_sublist l₂))
  rw [← List.dedup_eq_self.2 hnd]
  rw [← List.card_toFinset, ← List.card_toFinset]
  refine Finset.card_le_card ?_A
  intro x
  simpa using @hs x

lemma varsFinset_assignVars [DecidableEq α] [DecidableEq β] :
    ∀ (c : Circuit α) (f : ∀ (a : α) (_ha : a ∈ c.vars), β ⊕ Bool),
      (c.assignVars f).varsFinset ⊆ c.varsFinset.biUnion
        (fun a => if ha : a ∈ c.vars
                  then
                    match f a ha with
                    | Sum.inl b => {b}
                    | Sum.inr _ => ∅
                  else ∅)
  | tru, _ => by simp [assignVars, varsFinset, vars]
  | fals, _ => by simp [vars, assignVars, varsFinset]
  | var c v, f => by
    intro x
    simp [assignVars, varsFinset, vars]
    split <;>
    simp [*, vars]
    split_ifs <;> simp [vars]
  | and c₁ c₂, f => by
    intro x
    simp only [assignVars, Finset.mem_biUnion]
    intro hx
    replace hx := varsFinset_and _ _ hx
    simp only [Finset.mem_union] at hx
    cases hx with
    | inl hx =>
      have := varsFinset_assignVars _ _ hx
      simp only [Finset.mem_biUnion] at this
      rcases this with ⟨a, ha⟩
      use a
      simp only [mem_varsFinset] at ha
      simpa [ha.1, mem_varsFinset, vars] using ha.2
    | inr hx =>
      have := varsFinset_assignVars _ _ hx
      simp only [Finset.mem_biUnion] at this
      rcases this with ⟨a, ha⟩
      use a
      simp only [mem_varsFinset] at ha
      simpa [ha.1, mem_varsFinset, vars] using ha.2
  | or c₁ c₂, f => by
    intro x
    simp only [assignVars, Finset.mem_biUnion]
    intro hx
    replace hx := varsFinset_or _ _ hx
    simp only [Finset.mem_union] at hx
    cases hx with
    | inl hx =>
      have := varsFinset_assignVars _ _ hx
      simp only [Finset.mem_biUnion] at this
      rcases this with ⟨a, ha⟩
      use a
      simp only [mem_varsFinset] at ha
      simpa [ha.1, mem_varsFinset, vars] using ha.2
    | inr hx =>
      have := varsFinset_assignVars _ _ hx
      simp only [Finset.mem_biUnion] at this
      rcases this with ⟨a, ha⟩
      use a
      simp only [mem_varsFinset] at ha
      simpa [ha.1, mem_varsFinset, vars] using ha.2
  | xor c₁ c₂, f => by
    intro x
    simp only [assignVars, Finset.mem_biUnion]
    intro hx
    replace hx := varsFinset_xor _ _ hx
    simp only [Finset.mem_union] at hx
    cases hx with
    | inl hx =>
      have := varsFinset_assignVars _ _ hx
      simp only [Finset.mem_biUnion] at this
      rcases this with ⟨a, ha⟩
      use a
      simp only [mem_varsFinset] at ha
      simpa [ha.1, mem_varsFinset, vars] using ha.2
    | inr hx =>
      have := varsFinset_assignVars _ _ hx
      simp only [Finset.mem_biUnion] at this
      rcases this with ⟨a, ha⟩
      use a
      simp only [mem_varsFinset] at ha
      simpa [ha.1, mem_varsFinset, vars] using ha.2

theorem card_varsFinset_assignVars_lt [DecidableEq α] [DecidableEq β]
    (c : Circuit α) (f : ∀ (a : α) (_ha : a ∈ c.vars), β ⊕ Bool)
      (a : α) (ha : a ∈ c.vars) (b : Bool) (hfa : f a ha = Sum.inr b) :
      (c.assignVars f).varsFinset.card < c.varsFinset.card :=
  calc (c.assignVars f).varsFinset.card
     ≤ _ := Finset.card_le_card (varsFinset_assignVars c f)
   _ = _ := Eq.symm $ Finset.card_map ⟨(Sum.inl : β → β ⊕ Bool), Sum.inl_injective⟩
   _ < (c.varsFinset.image (fun a => if ha : a ∈ c.vars
                  then f a ha else Sum.inr false)).card :=
      Finset.card_lt_card $ by
        simp only [Finset.ssubset_iff, Finset.mem_map, Finset.mem_biUnion,
          Function.Embedding.coeFn_mk, not_exists, not_and, forall_exists_index, and_imp,
          Finset.subset_iff, Finset.mem_insert, Finset.mem_image, forall_eq_or_imp, Sum.forall,
          Sum.inl.injEq]
        use (f a ha)
        simp only [hfa, reduceCtorEq, not_false_eq_true, implies_true, false_implies, and_true,
          true_and]
        constructor
        · use a
          simp [ha, varsFinset, hfa]
        · rintro b₁ b₂ a' ha' hb₂ rfl
          simp only [mem_varsFinset.1 ha', dite_true] at hb₂
          use a'
          use ha'
          simp only [mem_varsFinset.1 ha', dite_true]
          split at hb₂
          · simp_all
          · simp at hb₂
   _ ≤ _ := Finset.card_image_le

lemma eval_assignVars [DecidableEq α] : ∀ {c : Circuit α}
    {f : ∀ (a : α) (_ha : a ∈ c.vars), β ⊕ Bool} {g : β → Bool},
    eval (assignVars c f) g = evalv c (λ a ha => Sum.elim g id (f a ha))
  | tru, _, _ => rfl
  | fals, _, _ => rfl
  | var b x, f, g => by
    simp [assignVars]
    cases f x (by simp [vars]) with
    | inl val => cases b <;> simp [eval]
    | inr val =>
      simp
      cases val <;> cases b <;> simp [eval]
  | and c₁ c₂, f, g => by
    simp [assignVars]
    rw [eval_assignVars, eval_assignVars]
  | or c₁ c₂, f, g => by
    simp [assignVars]
    rw [eval_assignVars, eval_assignVars]
  | xor c₁ c₂, f, g => by
    simp [assignVars]
    rw [eval_assignVars, eval_assignVars]

def fst {α β : Type _} [DecidableEq α] [DecidableEq β]
    (c : Circuit (α ⊕ β)) : Circuit α :=
  Circuit.bOr (c.sumVarsRight.pi (λ _ => [true, false]))
  (λ x => Circuit.assignVars c
    (λ i => Sum.rec (λ i _ => Sum.inl i) (λ i hi => Sum.inr (x i (by simp [hi]))) i))

theorem eval_fst {α β : Type _} [DecidableEq α] [DecidableEq β]
    (c : Circuit (α ⊕ β)) (g : α → Bool) :
    c.fst.eval g ↔ ∃ g' : β → Bool, c.eval (Sum.elim g g') := by
  simp only [fst, eval_bOr, List.mem_pi, List.mem_cons, eval_assignVars]
  constructor
  · rintro ⟨a, ha⟩
    use (fun i => if hi : i ∈ c.sumVarsRight then a i hi else true)
    rw [← ha.2, eval_eq_evalv]
    congr
    ext i hi
    cases i <;> simp [hi]
  · rintro ⟨a, ha⟩
    use (fun i _ => a i)
    constructor
    · intro i _
      simp
    · rw [← ha, eval_eq_evalv]
      congr
      ext i hi
      cases i <;> simp

def snd {α β : Type _} [DecidableEq α] [DecidableEq β]
    (c : Circuit (α ⊕ β)) : Circuit β :=
  Circuit.bOr (c.sumVarsLeft.pi (λ _ => [true, false]))
  (λ x => Circuit.assignVars c
    (λ i => Sum.rec (fun i hi => Sum.inr (x i (by simp [hi]))) (fun i _ => Sum.inl i) i))

theorem eval_sn.d {α β : Type _} [DecidableEq α] [DecidableEq β]
    (c : Circuit (α ⊕ β)) (g : β → Bool) :
    c.snd.eval g ↔ ∃ g' : α → Bool, c.eval (Sum.elim g' g) := by
  simp only [snd, eval_bOr, List.mem_pi, List.mem_cons, eval_assignVars]
  constructor
  · rintro ⟨a, ha⟩
    use (fun i => if hi : i ∈ c.sumVarsLeft then a i hi else true)
    rw [← ha.2, eval_eq_evalv]
    congr
    ext i hi
    cases i <;> simp [hi]
  · rintro ⟨a, ha⟩
    use (fun i _ => a i)
    constructor
    · intro i _
      simp
    · rw [← ha, eval_eq_evalv]
      congr
      ext i hi
      cases i <;> simp

def bind : ∀ (_c : Circuit α) (_f : α → Circuit β), Circuit β
  | tru, _ => tru
  | fals, _ => fals
  | var b x, f => if b then f x else ~~~ (f x)
  | and c₁ c₂, f => (bind c₁ f) &&& (bind c₂ f)
  | or c₁ c₂, f => (bind c₁ f) ||| (bind c₂ f)
  | xor c₁ c₂, f => (bind c₁ f) ^^^ (bind c₂ f)

lemma eval_bind : ∀ (c : Circuit α) (f : α → Circuit β) (g : β → Bool),
    eval (bind c f) g = eval c (λ a => eval (f a) g)
  | tru, _, _ => rfl
  | fals, _, _ => rfl
  | var b x, f, g => by cases b <;> simp [eval, bind]
  | and c₁ c₂, f, g => by
    simp [bind, eval]
    rw [eval_bind c₁, eval_bind c₂]
  | or c₁ c₂, f, g => by
    simp [bind, eval]
    rw [eval_bind c₁, eval_bind c₂]
  | xor c₁ c₂, f, g => by
    simp [bind, eval]
    rw [eval_bind c₁, eval_bind c₂]

def single [DecidableEq α] {s : List α} (x : ∀ a ∈ s, Bool) : Circuit α :=
  bAnd s (λ i => if hi : i ∈ s then var (x i hi) i else tru)

@[simp] lemma eval_single [DecidableEq α] {s : List α} (x : ∀ a ∈ s, Bool) (g : α → Bool):
  eval (single x) g ↔ (∀ a (ha : a ∈ s), g a = x a (by simpa)) := by
  rw [single]
  simp
  constructor
  · intros h a ha
    specialize h a ha
    rw [dif_pos ha] at h
    revert h
    cases x a ha <;> simp
  · intros h a ha
    rw [dif_pos ha]
    specialize h a ha
    revert h
    cases x a ha <;> simp

def nonemptyAux [DecidableEq α] :
    ∀ (c : Circuit α) (l : List α) (_hL : c.vars = l),
      { b : Bool // (∃ x, eval c x) = (b : Prop) }
  | tru, _, _ => ⟨true, by simp⟩
  | fals, _, _ => ⟨false, by simp⟩
  | var b x, _, _ => ⟨true,
      match b with
      | true => by
        simp only [eval, ite_true, eq_iff_iff, iff_true]
        use fun _ => true
      | false => by
        simp only [eval, Bool.false_eq_true, ↓reduceIte, Bool.not_eq_true', eq_iff_iff,
          iff_true]
        use fun _ => false⟩
  | c, l, hl =>
    match l, hl with
    | [], hv => ⟨eval c (λ _ => false), by
        rw [exists_eval_iff_exists_evalv, eq_iff_iff, eval_eq_evalv]
        constructor
        · rintro ⟨x, hx⟩
          rw [← hx]
          congr
          funext i hi
          simp [hv] at hi
        · intro h
          use λ i _ => false
          ⟩
    | i::l, hv =>
      let c₁ := c.assignVars (λ j _ => if i = j then Sum.inr true else Sum.inl j)
      let c₂ := c.assignVars (λ j _ => if i = j then Sum.inr false else Sum.inl j)
      let cc₁' := c.assignVars (λ j _ => if i = j then Sum.inr true else Sum.inl j)
      let cc₂' := c.assignVars (λ j _ => if i = j then Sum.inr false else Sum.inl j)
      have wf₁ : cc₁'.varsFinset.card < c.varsFinset.card :=
        card_varsFinset_assignVars_lt _ _ i (hv ▸ by simp) true (by simp)
      have wf₂ : cc₂'.varsFinset.card < c.varsFinset.card :=
        card_varsFinset_assignVars_lt _ _ i (hv ▸ by simp) false (by simp)
      have b₁ := nonemptyAux c₁ c₁.vars rfl
      have b₂ := nonemptyAux c₂ c₂.vars rfl
      ⟨b₁ || b₂, by
        simp only [eval_eq_evalv, Bool.or_eq_true, eq_iff_iff]
        rw [← b₁.prop, ← b₂.prop]
        simp +zetaDelta only [(eval_assignVars)]
        constructor
        · rintro ⟨x, hx⟩
          cases hi : x i
          · right
            use x
            convert hx
            split_ifs
            · subst i
              simp [hi]
            · simp
          · left
            use x
            convert hx
            split_ifs
            · subst i
              simp [hi]
            · simp
        · intro h
          rcases h with ⟨x, hx⟩ | ⟨x, hx⟩
          · refine ⟨_, hx⟩
          · refine ⟨_, hx⟩⟩
termination_by c l _ => c.varsFinset.card

def nonempty [DecidableEq α] (c : Circuit α) : Bool :=
  (nonemptyAux c c.vars rfl).1

lemma nonempty_iff [DecidableEq α] (c : Circuit α) :
    nonempty c ↔ ∃ x, eval c x :=
  by rw [nonempty, ← (nonemptyAux c c.vars rfl).2]


lemma nonempty_eq_false_iff [DecidableEq α] (c : Circuit α) :
    nonempty c = false ↔ ∀ x, ¬ eval c x := by
  apply not_iff_not.1
  simpa using nonempty_iff c

def always_false [DecidableEq α] (c : Circuit α) : Bool :=
   nonempty c = false

@[simp]
lemma always_false_iff [DecidableEq α] (c : Circuit α) :
    always_false c ↔ ∀ x, ¬ eval c x := by
rw [always_false]
simp [nonempty_eq_false_iff]

def always_true [DecidableEq α] (c : Circuit α) : Bool :=
  !(nonempty (~~~ c))

@[simp]
lemma always_true_iff [DecidableEq α] (c : Circuit α) :
    always_true c ↔ ∀ x, eval c x := by
  simp [always_true, nonempty_eq_false_iff]

instance [DecidableEq α] : DecidableRel ((· ≤· ) : Circuit α → Circuit α → Prop) :=
  λ c₁ c₂ => decidable_of_iff (always_true ((~~~ c₁).or c₂)) <|
    by simp [always_true_iff, le_def, or_iff_not_imp_left]

def implies (c₁ c₂ : Circuit α) : Circuit α := (~~~ c₁) ||| c₂

@[simp]
theorem eval_implies (c₁ c₂ : Circuit α) (f : _) : (c₁.implies c₂).eval f = (!(c₁.eval f) || (c₂.eval f)) := by
  simp [implies]

/-- c₁ ≤ c₂ iff (c₁.implies c₂) is a tautology. -/
lemma le_iff_implies : ∀ (c₁ c₂ : Circuit α), c₁ ≤ c₂ ↔ (∀ f, eval (implies c₁ c₂) f = true) := by
  intros c₁ c₂
  simp [le_def]
  constructor
  · intros h
    intros f
    specialize h f
    by_cases hc₁ : c₁.eval f  <;> by_cases hc₂ : c₂.eval f <;> simp_all
  · intros h
    intros f
    specialize h f
    by_cases hc₁ : c₁.eval f  <;> by_cases hc₂ : c₂.eval f <;> simp_all

section Optimizer
variable {α : Type u} [DecidableEq α]

def optimize : Circuit α → Circuit α
| .tru => .tru
| .fals => .fals
| .var b v => .var b v
| .or l r =>
   let l := optimize l
   let r := optimize r
   if l == r
   then l
   else l ||| r
| .and l r =>
   let l := optimize l
   let r := optimize r
   if l == r then l
   else l &&& r
| .xor l r =>
  let l := optimize l
  let r := optimize r
  if l == r
  then .fals
  else
    match l, r with
    | .var b v, .var b' v' =>
       if v == v'
       then .ofBool <| b.xor b'
       else l ^^^ r
    | _, _ => l ^^^ r
end Optimizer



section Equiv

/--
Two circuits are equivalent if they evaluate to the same result for all possible inputs.
-/
def Equiv (c₁ c₂ : Circuit α) : Prop :=
    eval c₁ = eval c₂

@[simp]
theorem Equiv_refl : ∀ (c : Circuit α), Circuit.Equiv c c := by
  intro c
  ext v
  simp

@[symm]
theorem Equiv_symm : ∀ {c₁ c₂ : Circuit α}, Circuit.Equiv c₁ c₂ → Circuit.Equiv c₂ c₁ := by
  intros c₁ c₂ h
  ext env
  rw [h]

@[trans]
theorem Equiv_trans : ∀ {c₁ c₂ c₃ : Circuit α},
    Circuit.Equiv c₁ c₂ → Circuit.Equiv c₂ c₃ → Circuit.Equiv c₁ c₃ := by
  intros c₁ c₂ c₃ h₁ h₂
  ext env
  rw [h₁, h₂]

theorem eval_eq_of_Equiv {c₁ c₂ : Circuit α} (h : Circuit.Equiv c₁ c₂) (f : α → Bool) :
    eval c₁ f = eval c₂ f := by rw [h]

theorem Equiv_of_eval_eq {c₁ c₂ : Circuit α} (h : ∀ f, eval c₁ f = eval c₂ f) :
    Circuit.Equiv c₁ c₂ := by
    ext v
    apply h

end Equiv

/-- Take the 'or' of many circuits.-/
def bigOr {α : Type _}
    (cs : List (Circuit α)) : Circuit α :=
  match cs with
  | [] => Circuit.fals
  | c :: cs =>
    c ||| (Circuit.bigOr cs)

@[simp]
theorem bigOr_nil_eq {α : Type _} :
    Circuit.bigOr (α := α) [] = Circuit.fals := by
  simp [bigOr]

@[simp]
theorem bigOr_cons_eq {α : Type _}
    (c : Circuit α) (cs : List (Circuit α)) :
    Circuit.bigOr (c :: cs) = c ||| Circuit.bigOr cs := by
  induction cs
  case nil => simp [bigOr]
  case cons a as ih =>
    simp [bigOr]


/-- append to the bigOr list is equivalent to a circuit
that is the bigOr of the circuit and the |||
-/
theorem bigOr_append_equiv_or_bigOr {α : Type _}
    (c : Circuit α) (cs : List (Circuit α)) :
    Equiv (Circuit.bigOr (cs ++ [c])) (c ||| Circuit.bigOr cs) := by
  induction cs
  case nil => simp [bigOr]
  case cons a as ih =>
    simp [bigOr]
    ext env
    have := Circuit.eval_eq_of_Equiv ih
    simp
    rw [this]
    simp [Circuit.eval_or]
    rcases (a.eval env) <;> simp
-- bigOr [a, b]
-- = a ||| (bigOr [b])
-- = a ||| (b ||| fals)

theorem bigOr_append_equiv_bigOr_cons {α : Type _}
    (c : Circuit α) (cs : List (Circuit α)) :
    Equiv (bigOr (cs ++ [c])) (Circuit.bigOr (c :: cs)) := by
  rw [bigOr_cons_eq]
  apply Circuit.Equiv_trans
  · apply Circuit.bigOr_append_equiv_or_bigOr
  · apply Circuit.Equiv_refl

theorem eval_bigOr_eq_decide
    (cs : List (Circuit α)) (env : α → Bool):
    (Circuit.bigOr cs).eval env = decide (∃ c ∈ cs, c.eval env = true) := by
  induction cs
  case nil => simp [bigOr]
  case cons a as ih =>
    simp [bigOr, ih]

@[simp]
theorem eval_bigOr_eq_false_iff
    (cs : List (Circuit α)) (env : α → Bool):
    (Circuit.bigOr cs).eval env = false ↔
    (∀ (c : Circuit α), c ∈ cs → c.eval env = false) := by
  induction cs
  case nil => simp [bigOr]
  case cons a as ih =>
    simp [bigOr, ih]

@[simp]
theorem eval_bigOr_eq_true_iff
    (cs : List (Circuit α)) (env : α → Bool):
    (Circuit.bigOr cs).eval env = true ↔
    (∃ (c : Circuit α), c ∈ cs ∧ c.eval env = true) := by
  induction cs
  case nil => simp [bigOr]
  case cons a as ih =>
    simp [bigOr, ih]

/-- Take the and of many circuits.-/
def bigAnd {α : Type _}
    (cs : List (Circuit α)) : Circuit α :=
  match cs with
  | [] => Circuit.tru
  | c :: cs =>
    c &&& (Circuit.bigAnd cs)

@[simp]
theorem eval_bigAnd_eq_true_iff
    (cs : List (Circuit α)) (env : α → Bool):
    (Circuit.bigAnd cs).eval env = true ↔
    (∀ (c : Circuit α), c ∈ cs → c.eval env = true) := by
  induction cs
  case nil => simp [bigAnd]
  case cons a as ih =>
    simp [bigAnd, ih]

@[simp]
theorem eval_bigAnd_eq_false_iff
    (cs : List (Circuit α)) (env : α → Bool):
    (Circuit.bigAnd cs).eval env = false ↔
    (∃ (c : Circuit α), c ∈ cs ∧ c.eval env = false) := by
  induction cs
  case nil => simp [bigAnd]
  case cons a as ih =>
    simp only [bigAnd, List.mem_cons, exists_eq_or_imp]
    by_cases h : a.eval env <;> simp [h, ih]



/--
The 'Entrypoint' for the 'toAIGAux' function, which maintains invariants
about AIGs.
-/
structure ToAIGAuxEntrypoint {α : Type} [DecidableEq α] [Fintype α] [Hashable α]
    (aig : AIG α) (c : Circuit α) where
  out : AIG α
  ref : out.Ref
  href : ∀ env, AIG.denote env ⟨out, ref⟩ = c.eval env
  le_size : aig.decls.size ≤ out.decls.size
  decl_eq : ∀ (idx : Nat) (h1 : idx < aig.decls.size) (h2),
    out.decls[idx]'h2 = aig.decls[idx]'h1
  denote_eq : ∀ (env : α → Bool) (ref : aig.Ref),
    AIG.denote env ⟨aig, ref⟩ = AIG.denote env ⟨out, ref.cast (by omega)⟩

set_option maxHeartbeats 2000000 in
/--
Convert a 'Circuit α' into an 'AIG α' in order to reuse bv_decide's
bitblasting capabilities.
-/
@[nospecialize]
def toAIGAux {α : Type}
    [DecidableEq α] [Fintype α] [Hashable α] (c : Circuit α) (aig : AIG α) :
    ToAIGAuxEntrypoint aig c :=
  match c with
  | .fals => {
      out := aig,
      ref := aig.mkConstCached false,
      href := by simp,
      le_size := by simp,
      decl_eq := by
        intro idx h1 h2
        simp,
      denote_eq := by
        intro env ref
        rfl
    }
  | .tru => {
    out := aig,
    ref := aig.mkConstCached true,
    href := by simp,
    le_size := by simp,
    decl_eq := by
      intro idx h1 h2
      simp,
    denote_eq := by
      intro env ref
      rfl
    }
  | .var b v =>
    let out := mkAtomCached aig v
    have AtomLe := LawfulOperator.le_size (f := mkAtomCached) aig v
    have AtomEq := LawfulOperator.decl_eq (f := mkAtomCached) aig v
    if hb : b then
      {
        out := out.aig,
        ref := out.ref,
        href := by simp [out]; omega,
        le_size := by
          omega
        decl_eq := by
          intro idx h1 h2
          rw [AtomEq],
        denote_eq := by
          intros env ref
          rw [← denote.eq_of_isPrefix (newAIG := out.aig)]
          · simp
          · constructor
            · intros idx h
              simp at h ⊢
              rw [AtomEq]
            · simp; apply AtomLe
      }
    else
      let notOut := mkNotCached out.aig out.ref
      have NotLe := LawfulOperator.le_size (f := mkNotCached) out.aig out.ref
      have notDeclEq := LawfulOperator.decl_eq (f := mkNotCached) out.aig out.ref
      have le_size : aig.decls.size ≤ notOut.aig.decls.size := by
        apply Nat.le_trans (m := (aig.mkAtomCached v).aig.decls.size)
        · omega
        · omega
      have decl_eq : ∀ (idx : Nat) (h1 : idx < aig.decls.size) (h2),
        notOut.aig.decls[idx]'h2 = aig.decls[idx]'h1 := by
        intro idx h1 h2
        simp [notOut, out]
        rw [notDeclEq, AtomEq]
        omega
      {
      out := notOut.aig,
      ref := notOut.ref,
      href := by
        simp [notOut, out]
        simp [hb],
      le_size,
      decl_eq,
      denote_eq := by
        intros env ref
        rw [← denote.eq_of_isPrefix (newAIG := notOut.aig)]
        · simp
        · constructor
          · simp
            intros idx hidx
            rw [decl_eq]
          · simp; omega
      }
      -- ⟨notOut, by simp only [notOut, out] at NotLe AtomLe ⊢; omega⟩
  | .and l r =>
    let laig := l.toAIGAux aig
    let raig := r.toAIGAux laig.out
    have := laig.le_size
    have := raig.le_size
    let input := ⟨laig.ref.cast this, raig.ref⟩
    let ret := raig.out.mkAndCached input
    have Lawful := LawfulOperator.le_size (f := mkAndCached) raig.out input
    have le_size : aig.decls.size ≤ ret.aig.decls.size := by
      apply Nat.le_trans (m := laig.out.decls.size)
      · omega
      · apply Nat.le_trans (m := raig.out.decls.size)
        · omega
        · omega
    have decl_eq : ∀ (idx : Nat) (h1 : idx < aig.decls.size) (h2),
        ret.aig.decls[idx]'h2 = aig.decls[idx]'h1 := by
      intro idx h1 h2
      simp [ret]
      have := LawfulOperator.decl_eq (f := mkAndCached) raig.out input idx
      rw [this]
      · rw [raig.decl_eq]
        · rw [laig.decl_eq]
          omega
        · omega
    {
      out := ret.aig,
      ref := ret.ref,
      href := by
        simp [ret]
        intros env
        rw [raig.href]
        rw [← laig.href]
        congr 1
        simp [input]
        rw [raig.denote_eq]
        rfl
      le_size,
      decl_eq,
      denote_eq := by
        intros env ref
        rw [← denote.eq_of_isPrefix (newAIG := ret.aig)]
        · simp [ret]
        · constructor
          · intros idx hidx
            simp at hidx ⊢
            rw [decl_eq]
          · simp; omega
    }
  | .or l r =>
    let laig := l.toAIGAux aig
    let raig := r.toAIGAux laig.out
    have := laig.le_size
    have := raig.le_size
    let input := ⟨laig.ref.cast this, raig.ref⟩
    let ret := raig.out.mkOrCached input
    have Lawful := LawfulOperator.le_size (f := mkOrCached) raig.out input
    have le_size : aig.decls.size ≤ ret.aig.decls.size := by
      apply Nat.le_trans (m := laig.out.decls.size)
      · omega
      · apply Nat.le_trans (m := raig.out.decls.size)
        · omega
        · omega
    have decl_eq : ∀ (idx : Nat) (h1 : idx < aig.decls.size) (h2),
        ret.aig.decls[idx]'h2 = aig.decls[idx]'h1 := by
      intro idx h1 h2
      simp [ret]
      have := LawfulOperator.decl_eq (f := mkOrCached) raig.out input idx
      rw [this]
      · rw [raig.decl_eq]
        · rw [laig.decl_eq]
          omega
        · omega
    {
      out := ret.aig,
      ref := ret.ref,
      href := by
        simp [ret]
        intros env
        rw [raig.href]
        rw [← laig.href]
        congr 1
        simp [input]
        rw [raig.denote_eq]
        rfl
      le_size,
      decl_eq,
      denote_eq := by
        intros env ref
        rw [← denote.eq_of_isPrefix (newAIG := ret.aig)]
        · simp [ret]
        · constructor
          · intros idx hidx
            simp at hidx ⊢
            rw [decl_eq]
          · simp; omega
    }
  | .xor l r =>
    let laig := l.toAIGAux aig
    let raig := r.toAIGAux laig.out
    have := laig.le_size
    have := raig.le_size
    let input := ⟨laig.ref.cast this, raig.ref⟩
    let ret := raig.out.mkXorCached input
    have Lawful := LawfulOperator.le_size (f := mkXorCached) raig.out input
    have le_size : aig.decls.size ≤ ret.aig.decls.size := by
      apply Nat.le_trans (m := laig.out.decls.size)
      · omega
      · apply Nat.le_trans (m := raig.out.decls.size)
        · omega
        · omega
    have decl_eq : ∀ (idx : Nat) (h1 : idx < aig.decls.size) (h2),
        ret.aig.decls[idx]'h2 = aig.decls[idx]'h1 := by
      intro idx h1 h2
      simp [ret]
      have := LawfulOperator.decl_eq (f := mkXorCached) raig.out input idx
      rw [this]
      · rw [raig.decl_eq]
        · rw [laig.decl_eq]
          omega
        · omega
    {
      out := ret.aig,
      ref := ret.ref,
      href := by
        simp [ret]
        intros env
        rw [raig.href]
        rw [← laig.href]
        congr 1
        simp [input]
        rw [raig.denote_eq]
        rfl
      le_size,
      decl_eq,
      denote_eq := by
        intros env ref
        rw [← denote.eq_of_isPrefix (newAIG := ret.aig)]
        · simp [ret]
        · constructor
          · intros idx hidx
            simp at hidx ⊢
            rw [decl_eq]
          · simp; omega
    }


def toAIG {α : Type}
    [DecidableEq α] [Fintype α] [Hashable α]
    (c : Circuit α) : { entry : Entrypoint α // ∀ (env : α → Bool), AIG.denote env entry = c.eval env } :=
  let aig : AIG α := AIG.empty
  let val := c.toAIGAux aig
  let aig := val.out
  let ref := val.ref
  let outVal := ⟨aig, ref⟩
  ⟨outVal, by
    intros env
    simp [outVal]
    rw [val.href]
  ⟩
open Std Sat AIG


/-- The denotations of the AIG and the circuit agree. -/
@[simp]
theorem denote_toAIG_eq_eval
    {α : Type} [DecidableEq α] [Fintype α] [Hashable α]
    {c : Circuit α}
    {env : α → Bool} :
    Std.Sat.AIG.denote env c.toAIG = c.eval env := by
  let x := c.toAIG
  apply x.prop

/-- If the circuit is UNSAT, then the AIG is UNSAT. -/
theorem eval_eq_false_iff_toAIG_unsat {α : Type}
    [DecidableEq α] [Fintype α] [Hashable α]
    {c : Circuit α} :
    (∀ env, c.eval env = false) ↔ c.toAIG.val.Unsat := by
  rw [Entrypoint.Unsat, UnsatAt]
  simp [← Circuit.denote_toAIG_eq_eval]

open Std Sat AIG in
/-- Verify the AIG by converting to CNF
and checking the LRAT certificate against it. -/
def verifyAIG {α : Type} [DecidableEq α] [Hashable α] (x : Entrypoint α) (cert : String) : Bool :=
  let y := (Entrypoint.relabelNat x)
  let z := AIG.toCNF y
  Std.Tactic.BVDecide.Reflect.verifyCert z cert



open Std Tactic BVDecide Reflect AIG in
/--
This theorem tracks that Std.Sat.AIG.Entrypoint.relabelNat_unsat_iff does not need a [Nonempty α]
to preserve unsatisfiability.
@hargoniX uses [Nonempty α] to convert a partial inverse to the relabelling.
However, this is un-necessary: One can case split on `Nonempty α`, and:
- When it is nonempty, we can apply the relabelling directly to show unsatisfiability.
- When it is empty, we show that the relabelling preserves unsatisfiability
  by showing that the relabelling is a no-op.
- Alternative proof strategy: Implement a 'RelabelNat' that case splits on
  'NonEmpty α', and when it is empty, returns the original AIG.
-/

theorem relabelNat_unsat_iff₂ {α : Type} [DecidableEq α] [Hashable α]
{entry : Entrypoint α} :
    (entry.relabelNat).Unsat ↔ entry.Unsat:= by
  simp only [Entrypoint.Unsat, Entrypoint.relabelNat]
  rw [relabelNat_unsat_iff]

open Std Tactic Sat AIG BitVec in
/-- Verifying the AIG implies that the AIG is unsat at the entrypoint. -/
theorem verifyAIG_correct {α : Type} [DecidableEq α] [Fintype α] [Hashable α]
    {entry : Entrypoint α} {cert : String}
    (h : verifyAIG entry cert) :
    entry.Unsat := by
  rw [verifyAIG] at h
  rw [← relabelNat_unsat_iff₂]
  rw [← AIG.toCNF_equisat entry.relabelNat]
  apply Std.Tactic.BVDecide.Reflect.verifyCert_correct (cert := cert) _ h

/-- Verify the circuit by translating to AIG. -/
def verifyCircuit {α : Type} [DecidableEq α] [Fintype α] [Hashable α]
    (c : Circuit α) (cert : String) : Bool :=
  verifyAIG (α := α) c.toAIG cert

/- If circuit verification succeeds, then the circuit is unsat. -/
theorem eval_eq_false_of_verifyCircuit {α : Type}
    [DecidableEq α] [Fintype α] [Hashable α]
    {c : Circuit α} {cert : String}
    (h : verifyCircuit c cert) :
    ∀ (env : _), c.eval env = false := by
  intros env
  simp [verifyCircuit] at h
  apply Circuit.eval_eq_false_iff_toAIG_unsat .. |>.mpr
  apply verifyAIG_correct h

/-!
Helpers to use `bv_decide` as a solver-in-the-loop for the reflection proof.
-/

def cadicalTimeoutSec : Nat := 1000

attribute [nospecialize] Circuit.toAIG

-- TODO: rename to checkUnsatAux
open Lean Elab Meta Std Sat AIG Tactic BVDecide Frontend in
def checkCircuitUnsatAux {α : Type} [DecidableEq α] [Hashable α] [Fintype α]
    (c : Circuit α) : TermElabM (Option LratCert) := do
  let cfg : BVDecideConfig := { timeout := cadicalTimeoutSec }
  IO.FS.withTempFile fun _ lratFile => do
    let cfg ← BVDecide.Frontend.TacticContext.new lratFile cfg
    let entrypoint:= c.toAIG.val
    let ⟨entrypoint, _labelling⟩ := entrypoint.relabelNat'
    let cnf := toCNF entrypoint
    let out ← runExternal cnf cfg.solver cfg.lratPath
      (trimProofs := true)
      (timeout := cadicalTimeoutSec)
      (binaryProofs := true)
    match out with
    | .error _model => return .none
    | .ok cert => return .some cert

end Circuit
