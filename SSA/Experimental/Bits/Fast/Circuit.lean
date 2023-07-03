import Mathlib.Data.Finset.Card
import Mathlib.Data.List.Pi
import Mathlib.Data.List.Lattice

universe u v

set_option linter.unusedVariables false

inductive CircuitAux (α : Type u) : Type u
  | tru : CircuitAux α 
  | fals : CircuitAux α 
  | var : α → CircuitAux α
  | and : CircuitAux α → CircuitAux α → CircuitAux α
  | or : CircuitAux α → CircuitAux α → CircuitAux α
  | xor : CircuitAux α → CircuitAux α → CircuitAux α
  | not : CircuitAux α → CircuitAux α
deriving Repr

namespace CircuitAux

@[simp]
def vars : CircuitAux α → Set α
  | tru => ∅ 
  | fals => ∅ 
  | var x => {x}
  | and c₁ c₂ => (vars c₁ ∪ vars c₂)
  | or c₁ c₂ => (vars c₁ ∪ vars c₂)
  | xor c₁ c₂ => (vars c₁ ∪ vars c₂)
  | not c => vars c

@[simp]
def evalv : ∀ (c : CircuitAux α) (f : ∀ a : α, a ∈ c.vars → Bool), Bool
  | tru, _ => true
  | fals, _ => false
  | var x, f => f x (by simp)
  | and c₁ c₂, f => (evalv c₁ (fun a ha => f a (Or.inl ha))) && (evalv c₂ (fun a ha => f a (Or.inr ha)))
  | or c₁ c₂, f => (evalv c₁ (fun a ha => f a (Or.inl ha))) || (evalv c₂ (fun a ha => f a (Or.inr ha)))
  | xor c₁ c₂, f => _root_.xor (evalv c₁ (fun a ha => f a (Or.inl ha))) (evalv c₂ (fun a ha => f a (Or.inr ha)))
  | not c, f => !(evalv c f)  

@[simp]
def eval (c : CircuitAux α) (f : α → Bool) : Bool :=
  c.evalv (fun a _ => f a)

def simplifyAnd : CircuitAux α → CircuitAux α → CircuitAux α
  | tru, c₂ => c₂
  | c₁, tru => c₁
  | fals, _ => fals
  | _, fals => fals
  | c₁, c₂ => and c₁ c₂

def simplifyOr : CircuitAux α → CircuitAux α → CircuitAux α
  | tru, _ => tru
  | _, tru => tru
  | fals, c₂ => c₂
  | c₁, fals => c₁
  | c₁, c₂ => or c₁ c₂ 

def simplifyXor : CircuitAux α → CircuitAux α → CircuitAux α
  | tru, c₂ => not c₂
  | c₁, tru => not c₁
  | fals, c₂ => c₂
  | c₁, fals => c₁
  | c₁, c₂ => xor c₁ c₂

def map (f : α → β) : CircuitAux α → CircuitAux β 
  | tru => tru
  | fals => fals
  | var x => var (f x)
  | and c₁ c₂ => and (map f c₁) (map f c₂)
  | or c₁ c₂ => or (map f c₁) (map f c₂)
  | xor c₁ c₂ => xor (map f c₁) (map f c₂)
  | not c => not (map f c)

lemma vars_map (f : α → β) : ∀ (c : CircuitAux α), (c.map f).vars = c.vars.image f
  | tru => by simp
  | fals => by simp
  | var x => by simp
  | and c₁ c₂ => by simp [vars_map f c₁, vars_map f c₂, Set.image_union]
  | or c₁ c₂ => by simp [vars_map f c₁, vars_map f c₂, Set.image_union]
  | xor c₁ c₂ => by simp [vars_map f c₁, vars_map f c₂, Set.image_union]
  | not c => by simp [vars_map f c]

lemma evalv_map 

end CircuitAux

structure Circuit (α : Type _) where
  toCircuitAux : CircuitAux α
  vars : List α
  nodup_vars : vars.Nodup
  varsEq : ∀ x, x ∈ vars ↔ x ∈ toCircuitAux.vars

namespace Circuit
variable {α : Type u} {β : Type v}

def varsFinset [DecidableEq α] (c : Circuit α) : Finset α :=  
  ⟨c.vars, nodup_vars c⟩ 

lemma mem_varsFinset [DecidableEq α] {c : Circuit α} : 
    ∀ {x : α}, x ∈ c.varsFinset ↔ x ∈ c.vars := by
  simp [varsFinset]

def tru : Circuit α := ⟨CircuitAux.tru, [], by simp, by simp⟩

def fals : Circuit α := ⟨CircuitAux.fals, [], by simp, by simp⟩

def var (x : α) : Circuit α := ⟨CircuitAux.var x, [x], by simp, by simp⟩

def and [DecidableEq α] : ∀ (c₁ c₂ : Circuit α), Circuit α
  | ⟨CircuitAux.tru, v₁, h₁, h₁'⟩, ⟨c₂, v₂, h₂, h₂'⟩ => 
    ⟨c₂, v₂, by simp [h₁, h₂], by simp [h₁', h₂']⟩
  | ⟨c₁, v₁, h₁, h₁'⟩, ⟨CircuitAux.tru, v₂, h₂, h₂'⟩ =>
    ⟨c₁, v₁, by simp [h₁, h₂], by simp [h₁', h₂']⟩
  | ⟨CircuitAux.fals, v₁, h₁, h₁'⟩, _ => fals
  | _, ⟨CircuitAux.fals, v₂, h₂, h₂'⟩ => fals
  | ⟨c₁, v₁, h₁, h₁'⟩, ⟨c₂, v₂, h₂, h₂'⟩ => 
    ⟨c₁.and c₂, v₁.union v₂, List.Nodup.union _ h₂, by simp [h₁', h₂']⟩

def or [DecidableEq α] : ∀ (c₁ c₂ : Circuit α), Circuit α
  | ⟨CircuitAux.tru, v₁, h₁, h₁'⟩, _ => tru
  | _, ⟨CircuitAux.tru, v₂, h₂, h₂'⟩ => tru
  | ⟨CircuitAux.fals, v₁, h₁, h₁'⟩, ⟨c₂, v₂, h₂, h₂'⟩ => 
    ⟨c₂, v₂, by simp [h₁, h₂], by simp [h₁', h₂']⟩
  | ⟨c₁, v₁, h₁, h₁'⟩, ⟨CircuitAux.fals, v₂, h₂, h₂'⟩ =>
    ⟨c₁, v₁, by simp [h₁, h₂], by simp [h₁', h₂']⟩
  | ⟨c₁, v₁, h₁, h₁'⟩, ⟨c₂, v₂, h₂, h₂'⟩ => 
    ⟨c₁.or c₂, v₁.union v₂, List.Nodup.union _ h₂, by simp [h₁', h₂']⟩

def xor [DecidableEq α] : ∀ (c₁ c₂ : Circuit α), Circuit α 
  | ⟨CircuitAux.tru, v₁, h₁, h₁'⟩, ⟨c₂, v₂, h₂, h₂'⟩ => 
    ⟨c₂.not, v₂, by simp [h₁, h₂], by simp [h₁', h₂']⟩
  | ⟨c₁, v₁, h₁, h₁'⟩, ⟨CircuitAux.tru, v₂, h₂, h₂'⟩ =>
    ⟨c₁.not, v₁, by simp [h₁, h₂], by simp [h₁', h₂']⟩
  | ⟨CircuitAux.fals, v₁, h₁, h₁'⟩, ⟨c₂, v₂, h₂, h₂'⟩ => 
    ⟨c₂, v₂, by simp [h₁, h₂], by simp [h₁', h₂']⟩
  | ⟨c₁, v₁, h₁, h₁'⟩, ⟨CircuitAux.fals, v₂, h₂, h₂'⟩ =>
    ⟨c₁, v₁, by simp [h₁, h₂], by simp [h₁', h₂']⟩
  | ⟨c₁, v₁, h₁, h₁'⟩, ⟨c₂, v₂, h₂, h₂'⟩ => 
    ⟨c₁.xor c₂, v₁.union v₂, List.Nodup.union _ h₂, by simp [h₁', h₂']⟩ 

def not : Circuit α → Circuit α
  | ⟨c, v, h, h'⟩ => ⟨c.not, v, h, h'⟩

def eval (c : Circuit α) (f : α → Bool) : Bool :=
  c.toCircuitAux.eval f

@[simp] def evalv [DecidableEq α] (c : Circuit α) (f : ∀ a ∈ vars c, Bool) : Bool :=
  c.toCircuitAux.evalv (fun a ha => f a ((c.varsEq a).mpr ha))

lemma eval_eq_evalv [DecidableEq α] (c : Circuit α) (f : α → Bool) :
    eval c f = evalv c (λ x _ => f x) := rfl

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
  . rintro ⟨x, hx⟩
    use λ a _ => x a
    rw [eval_eq_evalv] at hx
    exact hx
  . rintro ⟨x, hx⟩
    refine ⟨λ a => dite (a ∈ c.vars) (x a) (λ _ => false), ?_⟩
    convert hx
    rw [eval_eq_evalv]
    congr 1
    ext i hi
    simp [hi]

instance [DecidableEq α] : AndOp (Circuit α) := ⟨Circuit.and⟩

theorem and_def [DecidableEq α] (c₁ c₂ : Circuit α) :
    c₁ &&& c₂ = c₁.and c₂ := rfl

@[simp] lemma eval_and [DecidableEq α] (c₁ c₂ : Circuit α) (f : α → Bool) :
    (eval (c₁ &&& c₂) f) = ((eval c₁ f) && (eval c₂ f)) := by
  rcases c₁ with ⟨c₁, _, _, _⟩
  rcases c₂ with ⟨c₂, _, _, _⟩
  cases c₁ <;> cases c₂ <;> simp [eval, and] 

theorem varsFinset_and [DecidableEq α] (c₁ c₂ : Circuit α) :
    (varsFinset (c₁ &&& c₂)) ⊆ (varsFinset c₁ ∪ varsFinset c₂) := by
  rcases c₁ with ⟨c₁, _, _, _⟩
  rcases c₂ with ⟨c₂, _, _, _⟩
  cases c₁ <;> cases c₂ <;> 
    simp [vars, varsFinset, and, and_def, Finset.subset_iff] <;> tauto

instance [DecidableEq α] : OrOp (Circuit α) := ⟨Circuit.or⟩

theorem or_def [DecidableEq α] (c₁ c₂ : Circuit α) :
    c₁ ||| c₂ = c₁.or c₂ := rfl

@[simp] lemma eval_or [DecidableEq α] (c₁ c₂ : Circuit α) (f : α → Bool) :
    (eval (c₁ ||| c₂) f) = ((eval c₁ f) || (eval c₂ f)) := by
  rcases c₁ with ⟨c₁, _, _, _⟩
  rcases c₂ with ⟨c₂, _, _, _⟩
  cases c₁ <;> cases c₂ <;> simp [eval, or]

@[simp] lemma varsFinset_or [DecidableEq α] (c₁ c₂ : Circuit α) : 
    (varsFinset (c₁ ||| c₂)) ⊆ (varsFinset c₁ ∪ varsFinset c₂) := by
  rcases c₁ with ⟨c₁, _, _, _⟩
  rcases c₂ with ⟨c₂, _, _, _⟩
  cases c₁ <;> cases c₂ <;> 
    simp [vars, varsFinset, or, or_def, Finset.subset_iff] <;> tauto
  
instance : Complement (Circuit α) := ⟨Circuit.not⟩

@[simp]
theorem complement_def (c : Circuit α) : ~~~ c = c.not := rfl 

@[simp] lemma eval_complement (c : Circuit α) (f : α → Bool) :
    eval (~~~ c) f = !(eval c f) := rfl

theorem varsFinset_complement [DecidableEq α] (c : Circuit α) :
    (varsFinset (~~~ c)) = varsFinset c :=
  rfl

theorem _root_.Bool.xor_not_left' (a b : Bool) : 
    _root_.xor (!a) b = !_root_.xor a b := by
  cases a <;> cases b <;> rfl

instance [DecidableEq α] : Xor (Circuit α) := ⟨Circuit.xor⟩

@[simp] theorem xor_def [DecidableEq α] (c₁ c₂ : Circuit α) :
    c₁ ^^^ c₂ = c₁.xor c₂ := rfl

@[simp] lemma eval_xor [DecidableEq α] (c₁ c₂ : Circuit α) (f : α → Bool) :
    eval (c₁ ^^^ c₂) f = _root_.xor (eval c₁ f) (eval c₂ f) := by
  rcases c₁ with ⟨c₁, _, _, _⟩
  rcases c₂ with ⟨c₂, _, _, _⟩
  cases c₁ <;> cases c₂ <;> simp [eval, xor]

@[simp] lemma varsFinset_xor [DecidableEq α] (c₁ c₂ : Circuit α) : 
    (varsFinset (c₁ ^^^ c₂)) ⊆ (varsFinset c₁ ∪ varsFinset c₂) := by
  rcases c₁ with ⟨c₁, _, _, _⟩
  rcases c₂ with ⟨c₂, _, _, _⟩
  cases c₁ <;> cases c₂ <;> 
    simp [vars, varsFinset, xor, xor_def, Finset.subset_iff] <;> tauto

def map (f : α → β) (hf : Function.Injective f) (c : Circuit α)  : Circuit β :=
  ⟨c.toCircuitAux.map f, (c.vars.map f), 
    List.Nodup.map hf c.nodup_vars, 
    by simp [c.varsEq, c.toCircuitAux.vars_map]⟩ 

lemma eval_map {c : Circuit α} {f : α → β} (hf : Function.Injective f) 
    {g : β → Bool} : eval (map f hf c) g = eval c (λ x => g (f x)) := by
  rcases c with ⟨c, _, _, _⟩
  induction c <;> simp [*, Circuit.map, CircuitAux.map, eval] at *

def simplify : ∀ (_c : Circuit α), Circuit α
  | tru => tru
  | fals => fals
  | var b x => var b x
  | and c₁ c₂ => (simplify c₁) &&& (simplify c₂)
  | or c₁ c₂ => (simplify c₁) ||| (simplify c₂)
  | xor c₁ c₂ => (simplify c₁) ^^^ (simplify c₂)

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
  | var false x, f, g, h => by simp [eval, h x (by simp [vars, eval])]
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
| [], f, c, g => by simp [eval]
| a::l, f, c, g => by
  rw [List.foldl_cons, eval_foldl_or l]
  simp only [eval_or, Bool.or_eq_true, List.mem_cons]
  constructor
  . intro h
    rcases h with (h₁ | h₂) | ⟨a, ha⟩
    . simp [*]
    . exact Or.inr ⟨_, Or.inl rfl, h₂⟩
    . exact Or.inr ⟨_, Or.inr ha.1, ha.2⟩
  . intro h
    rcases h with h | ⟨a, rfl| ha, h⟩
    . simp [*]
    . simp [*]
    . exact Or.inr ⟨_, ha, h⟩

@[simp] lemma eval_bOr :
  ∀ {s : List α} {f : α → Circuit β} {g : β → Bool},
    eval (bOr s f) g = ∃ a ∈ s, eval (f a) g
| [], _, _ => by simp [bOr, eval]
| [a], f, g => by simp [bOr, eval]
| a::l, f, g => by 
  rw [bOr, eval_foldl_or, List.exists_mem_cons_iff]

def bAnd : ∀ (_s : List α) (_f : α → Circuit β), Circuit β
| [], _ => tru
| a::l, f => l.foldl (λ c x => c &&& (f x)) (f a)

@[simp] lemma eval_foldl_and :
    ∀ (s : List α) (f : α → Circuit β) (c : Circuit β) (g : β → Bool),
      (eval (s.foldl (λ c x => c &&& (f x)) c) g : Prop) ↔
        eval c g ∧ (∀ a ∈ s, eval (f a) g)
  | [], f, c, g => by simp [eval]
  | a::l, f, c, g => by
    rw [List.foldl_cons, eval_foldl_and l]
    simp only [eval_and, Bool.and_eq_true, List.mem_cons]
    constructor
    . intro h
      rcases h with ⟨⟨h₁, h₂⟩, h⟩
      simpa [*] using h
    . intro h
      rcases h with ⟨h₁, h₂⟩
      simp only [h₁, true_and, h₂ a (Or.inl rfl)]
      aesop
      
@[simp] lemma eval_bAnd :
    ∀ {s : List α} {f : α → Circuit β} {g : β → Bool},
      eval (bAnd s f) g ↔ ∀ a ∈ s, eval (f a) g
  | [], _, _ => by simp [bAnd, eval]
  | [a], f, g => by simp [bAnd, eval]
  | a::l, f, g => by
    rw [bAnd, eval_foldl_and]; simp

def assignVars [DecidableEq α] :
    ∀ (c : Circuit α) (_f : ∀ (a : α) (_ha : a ∈ c.vars), β ⊕ Bool), Circuit β
  | tru, _ => tru
  | fals, _ => fals
  | var b x, f => 
    Sum.elim 
      (var b)
      (λ c : Bool => if _root_.xor b c then fals else tru) 
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
  refine le_trans ?_ (List.length_le_of_sublist (List.dedup_sublist l₂))
  rw [← List.dedup_eq_self.2 hnd]
  rw [← List.card_toFinset, ← List.card_toFinset]
  refine Finset.card_le_of_subset ?_
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
    simp [*, vars, Xor']
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
     ≤ _ := Finset.card_le_of_subset (varsFinset_assignVars c f)
   _ = _ := Eq.symm $ Finset.card_map ⟨(Sum.inl : β → β ⊕ Bool), Sum.inl_injective⟩  
   _ < (c.varsFinset.image (fun a => if ha : a ∈ c.vars 
                  then f a ha else Sum.inr false)).card := 
      Finset.card_lt_card $ by
        simp only [Finset.ssubset_iff, Finset.mem_map, Finset.mem_biUnion, Function.Embedding.coeFn_mk,
          Finset.subset_iff, Finset.mem_insert, Finset.mem_image, forall_eq_or_imp, forall_exists_index, and_imp,
          Sum.forall, Sum.inl.injEq, IsEmpty.forall_iff, implies_true, Bool.forall_bool, and_true, not_exists, not_and,
          exists_and_left, exists_prop, exists_exists_and_eq_and]
        use a
        use mem_varsFinset.2 ha
        simp only [ha, hfa, dite_eq_ite, ite_true, not_false_eq_true, implies_true, true_and]
        rintro b₁ b₂ a' ha' hb₂ rfl
        simp only [mem_varsFinset.1 ha', dite_true] at hb₂ 
        use a'
        use ha'
        simp only [mem_varsFinset.1 ha', dite_true, hb₂]
        split at hb₂
        . simpa [*, eq_comm] using hb₂
        . simp at hb₂
   _ ≤ _ := Finset.card_image_le

lemma eval_assignVars [DecidableEq α] : ∀ {c : Circuit α}
    {f : ∀ (a : α) (_ha : a ∈ c.vars), β ⊕ Bool} {g : β → Bool},
    eval (assignVars c f) g = evalv c (λ a ha => Sum.elim g id (f a ha))
  | tru, _, _ => rfl
  | fals, _, _ => rfl
  | var b x, f, g => by
    simp [assignVars, eval, vars]
    cases f x (by simp [vars]) with
    | inl val => cases b <;> simp [eval]
    | inr val => 
      simp [eval]
      cases val <;> cases b <;> simp [eval] 
  | and c₁ c₂, f, g => by
    simp [assignVars, eval, vars]
    rw [eval_assignVars, eval_assignVars]
  | or c₁ c₂, f, g => by
    simp [assignVars, eval, vars]
    rw [eval_assignVars, eval_assignVars]
  | xor c₁ c₂, f, g => by
    simp [assignVars, eval, vars]
    rw [eval_assignVars, eval_assignVars]

def fst {α β : Type _} [DecidableEq α] [DecidableEq β] 
    (c : Circuit (α ⊕ β)) : Circuit α :=
  Circuit.bOr (c.sumVarsRight.pi (λ _ => [true, false]))
  (λ x => Circuit.assignVars c
    (λ i => Sum.rec (λ i _ => Sum.inl i) (λ i hi => Sum.inr (x i (by simp [hi]))) i))

theorem eval_fst {α β : Type _} [DecidableEq α] [DecidableEq β]
    (c : Circuit (α ⊕ β)) (g : α → Bool) : 
    c.fst.eval g ↔ ∃ g' : β → Bool, c.eval (Sum.elim g g') := by
  simp only [fst, eval_bOr, List.mem_pi, List.find?, List.mem_cons, 
    List.mem_singleton, eval_assignVars]
  constructor
  . rintro ⟨a, ha⟩
    use (fun i => if hi : i ∈ c.sumVarsRight then a i hi else true)
    rw [← ha.2, eval_eq_evalv]
    congr
    ext i hi
    cases i <;> simp [hi]
  . rintro ⟨a, ha⟩ 
    use (fun i _ => a i)
    constructor
    . intro i hi
      simp
      cases a i <;> simp
    . rw [← ha, eval_eq_evalv]
      congr
      ext i hi
      cases i <;> simp

def snd {α β : Type _} [DecidableEq α] [DecidableEq β] 
    (c : Circuit (α ⊕ β)) : Circuit β :=
  Circuit.bOr (c.sumVarsLeft.pi (λ _ => [true, false]))
  (λ x => Circuit.assignVars c
    (λ i => Sum.rec (fun i hi => Sum.inr (x i (by simp [hi]))) (fun i _ => Sum.inl i) i))

theorem eval_snd {α β : Type _} [DecidableEq α] [DecidableEq β]
    (c : Circuit (α ⊕ β)) (g : β → Bool) : 
    c.snd.eval g ↔ ∃ g' : α → Bool, c.eval (Sum.elim g' g) := by
  simp only [snd, eval_bOr, List.mem_pi, List.find?, List.mem_cons, 
    List.mem_singleton, eval_assignVars]
  constructor
  . rintro ⟨a, ha⟩
    use (fun i => if hi : i ∈ c.sumVarsLeft then a i hi else true)
    rw [← ha.2, eval_eq_evalv]
    congr
    ext i hi
    cases i <;> simp [hi]
  . rintro ⟨a, ha⟩ 
    use (fun i _ => a i)
    constructor
    . intro i hi
      simp
      cases a i <;> simp
    . rw [← ha, eval_eq_evalv]
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
  . intros h a ha
    specialize h a ha
    rw [dif_pos ha] at h
    revert h
    cases x a ha <;> simp
  . intros h a ha
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
        simp only [eval, ite_false, Bool.not_eq_true', eq_iff_iff, iff_true]
        use fun _ => false⟩
  | c, l, hl =>
    match l, hl with
    | [], hv => ⟨eval c (λ _ => false), by
        rw [exists_eval_iff_exists_evalv, eq_iff_iff, eval_eq_evalv]
        constructor
        . rintro ⟨x, hx⟩
          rw [← hx]
          congr
          funext i hi
          simp [hv] at hi
        . intro h
          use λ i _ => false
          exact h⟩
    | i::l, hv =>
      let c₁ := c.assignVars (λ j _ => if i = j then Sum.inr true else Sum.inl j)
      let c₂ := c.assignVars (λ j _ => if i = j then Sum.inr false else Sum.inl j)
      have wf₁ : c₁.varsFinset.card < c.varsFinset.card := 
        card_varsFinset_assignVars_lt _ _ i (hv ▸ by simp) true (by simp)
      have wf₂ : c₂.varsFinset.card < c.varsFinset.card := 
        card_varsFinset_assignVars_lt _ _ i (hv ▸ by simp) false (by simp)
      let b₁ := nonemptyAux c₁ c₁.vars rfl
      let b₂ := nonemptyAux c₂ c₂.vars rfl
      ⟨b₁ || b₂, by
        simp only [eval_eq_evalv, Bool.or_eq_true, eq_iff_iff]
        rw [← b₁.prop, ← b₂.prop]
        simp only [eval_assignVars]
        constructor
        . rintro ⟨x, hx⟩
          cases hi : x i
          . right
            use x
            convert hx
            split_ifs
            . subst i
              simp [hi]
            . simp 
          . left
            use x
            convert hx
            split_ifs
            . subst i
              simp [hi]
            . simp
        . intro h
          rcases h with ⟨x, hx⟩ | ⟨x, hx⟩
          . refine ⟨_, hx⟩
          . refine ⟨_, hx⟩⟩
termination_by nonemptyAux c l hL => c.varsFinset.card

def nonempty [DecidableEq α] (c : Circuit α) : Bool :=
  (nonemptyAux c c.vars rfl).1

lemma nonempty_iff [DecidableEq α] (c : Circuit α) :
    nonempty c ↔ ∃ x, eval c x :=
  by rw [nonempty, ← (nonemptyAux c c.vars rfl).2]

lemma nonempty_eq_false_iff [DecidableEq α] (c : Circuit α) :
    nonempty c = false ↔ ∀ x, ¬ eval c x := by
  apply not_iff_not.1
  simpa using nonempty_iff c

def always_true [DecidableEq α] (c : Circuit α) : Bool :=
  !(nonempty (~~~ c))

lemma always_true_iff [DecidableEq α] (c : Circuit α) :
    always_true c ↔ ∀ x, eval c x := by
  simp [always_true, nonempty_eq_false_iff, not_not]

instance [DecidableEq α] : DecidableRel ((. ≤. ) : Circuit α → Circuit α → Prop) :=
  λ c₁ c₂ => decidable_of_iff (always_true ((~~~ c₁).or c₂)) <|
    by simp [always_true_iff, le_def, or_iff_not_imp_left]

end Circuit
