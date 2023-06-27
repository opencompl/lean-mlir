import Mathlib.Data.Finset.Card

universe u v

inductive Circuit (α : Type u) : Type u
  | tru : Circuit α 
  | fals : Circuit α 
  | var : Bool → α → Circuit α
  | and : Circuit α → Circuit α → Circuit α
  | or : Circuit α → Circuit α → Circuit α
  | xor : Circuit α → Circuit α → Circuit α
deriving Repr

namespace Circuit
variable {α : Type u} {β : Type v}

def vars [DecidableEq α] : Circuit α → List α
  | tru => []
  | fals => []
  | var _ x => [x]
  | and c₁ c₂ => (vars c₁ ++ vars c₂).dedup
  | or c₁ c₂ => (vars c₁ ++ vars c₂).dedup
  | xor c₁ c₂ => (vars c₁ ++ vars c₂).dedup

theorem nodup_vars [DecidableEq α] (c : Circuit α) : c.vars.Nodup := by
  cases c <;> simp [vars, List.nodup_dedup]

@[simp]
def eval : Circuit α → (α → Bool) → Bool
  | tru, _ => true
  | fals, _ => false
  | var b x, f => if b then f x else !(f x)
  | and c₁ c₂, f => (eval c₁ f) && (eval c₂ f)
  | or c₁ c₂, f => (eval c₁ f) || (eval c₂ f)
  | xor c₁ c₂, f => _root_.xor (eval c₁ f) (eval c₂ f)

@[simp] def evalv [DecidableEq α] : ∀ (c : Circuit α), (∀ a ∈ vars c, Bool) → Bool
  | tru, _ => true
  | fals, _ => false
  | var b x, f => if b then f x (by simp [vars]) else !(f x (by simp [vars]))
  | and c₁ c₂, f => (evalv c₁ (fun i hi => f i (by simp [hi, vars]))) &&
    (evalv c₂ (fun i hi => f i (by simp [hi, vars])))
  | or c₁ c₂, f => (evalv c₁ (fun i hi => f i (by simp [hi, vars]))) ||
    (evalv c₂ (fun i hi => f i (by simp [hi, vars])))
  | xor c₁ c₂, f => _root_.xor (evalv c₁ (fun i hi => f i (by simp [hi, vars])))
    (evalv c₂ (fun i hi => f i (by simp [hi, vars])))

lemma eval_eq_evalv [DecidableEq α] : ∀ (c : Circuit α) (f : α → Bool),
    eval c f = evalv c (λ x _ => f x)
  | tru, _ => rfl
  | fals, _ => rfl
  | var _ x, f => rfl
  | and c₁ c₂, f => by rw [eval, evalv, eval_eq_evalv c₁, eval_eq_evalv c₂]
  | or c₁ c₂, f => by rw [eval, evalv, eval_eq_evalv c₁, eval_eq_evalv c₂]
  | xor c₁ c₂, f => by rw [eval, evalv, eval_eq_evalv c₁, eval_eq_evalv c₂]

@[simp] def of_bool (b : Bool) : Circuit α :=
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

def simplifyAnd : Circuit α → Circuit α → Circuit α
  | tru, c => c
  | c, tru => c
  | fals, _ => fals
  | _, fals => fals
  | c₁, c₂ => and c₁ c₂

instance : AndOp (Circuit α) := ⟨Circuit.simplifyAnd⟩

@[simp] lemma eval_and : ∀ (c₁ c₂ : Circuit α) (f : α → Bool),
    (eval (c₁ &&& c₂) f) = ((eval c₁ f) && (eval c₂ f)) := by
  intros c₁ c₂ f
  cases c₁ <;> cases c₂ <;> simp [eval, simplifyAnd]

theorem vars_and [DecidableEq α] (c₁ c₂ : Circuit α) :
    (vars (c₁ &&& c₂)) ⊆ (vars c₁ ++ vars c₂).dedup := by
  cases c₁ <;> cases c₂ <;> simp [vars, simplifyAnd]

def simplifyOr : Circuit α → Circuit α → Circuit α
  | tru, _ => tru
  | _, tru => tru
  | fals, c => c
  | c, fals => c
  | c₁, c₂ => or c₁ c₂

instance : OrOp (Circuit α) := ⟨Circuit.simplifyOr⟩

@[simp] lemma eval_or : ∀ (c₁ c₂ : Circuit α) (f : α → Bool),
    (eval (c₁ ||| c₂) f) = ((eval c₁ f) || (eval c₂ f)) := by
  intros c₁ c₂ f
  cases c₁ <;> cases c₂ <;> simp [Circuit.simplifyOr, eval]

theorem vars_or [DecidableEq α] (c₁ c₂ : Circuit α) :
    (vars (c₁ ||| c₂)) ⊆ (vars c₁ ++ vars c₂).dedup := by
  cases c₁ <;> cases c₂ <;> simp [vars, simplifyOr]

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
  | var true a, f => by simp [eval]
  | var false a, f => by simp [eval]

theorem vars_complement [DecidableEq α] (c : Circuit α) :
    (vars (~~~ c)) ⊆ vars c := by
  intro x
  induction c <;> simp [simplifyNot, vars] <;> aesop

@[simp]
def simplifyXor : Circuit α → Circuit α → Circuit α
  | fals, c => c
  | c, fals => c
  | tru, c => ~~~ c
  | c, tru => ~~~ c
  | c₁, c₂ => xor c₁ c₂

theorem _root_.Bool.xor_not_left' (a b : Bool) : 
    _root_.xor (!a) b = !_root_.xor a b := by
  cases a <;> cases b <;> rfl

instance : Xor (Circuit α) := ⟨Circuit.simplifyXor⟩

@[simp] lemma eval_xor : ∀ (c₁ c₂ : Circuit α) (f : α → Bool),
    eval (c₁ ^^^ c₂) f = _root_.xor (eval c₁ f) (eval c₂ f) := by
  intros c₁ c₂ f
  cases c₁ <;> cases c₂ <;> simp [simplifyXor, Bool.xor_not_left'] <;>
  split_ifs <;> simp [*] at *

set_option maxHeartbeats 1000000
theorem vars_simplifyXor [DecidableEq α] (c₁ c₂ : Circuit α) :
    (vars (simplifyXor c₁ c₂)) ⊆ (vars c₁ ++ vars c₂).dedup := by
  intro x
  simp only [List.mem_dedup, List.mem_append]
  induction c₁ <;> induction c₂ <;> simp only [simplifyXor, vars,
    ← simplifyNot_eq_complement] at * <;> aesop

theorem vars_xor [DecidableEq α] (c₁ c₂ : Circuit α) :
    (vars (c₁ ^^^ c₂)) ⊆ (vars c₁ ++ vars c₂).dedup :=
  vars_simplifyXor c₁ c₂

def map : ∀ (_c : Circuit α) (_f : α → β), Circuit β
  | tru, _ => tru
  | fals, _ => fals
  | var b x, f => var b (f x)
  | and c₁ c₂, f => (map c₁ f) &&& (map c₂ f)
  | or c₁ c₂, f => (map c₁ f) ||| (map c₂ f)
  | xor c₁ c₂, f => (map c₁ f) ^^^ (map c₂ f)

lemma eval_map {c : Circuit α} {f : α → β} {g : β → Bool} :
    eval (map c f) g = eval c (λ x => g (f x)) := by
  induction c <;> simp [*, Circuit.map, eval] at *

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
    eval (bOr s f) g ↔ ∃ a ∈ s, eval (f a) g
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

-- lemma length_varsAssignVars [DecidableEq α] [DecidableEq β] :
--     ∀ (c : Circuit α) (f : ∀ (a : α) (_ha : a ∈ c.vars), β ⊕ Bool), 
--       (c.assignVars f).vars ⊆ 
--   | tru, _, _, h, _, _ => by simp [vars] at h     
--   | fals, _, _, h, _, _ => by simp [vars] at h
--   | var c v, f, a, ha, b, haa => by
--     simp only [vars, List.mem_singleton] at ha 
--     subst a
--     simp [vars, assignVars, haa, Xor']
--     split_ifs <;> simp [*, vars]
--   | and c₁ c₂, f, a, ha, b, haa => by
--     simp [assignVars, vars]
--     refine lt_of_le_of_lt (List.length_le_of_subset_of_nodup 
--       (vars_simplifyAnd _ _) (nodup_vars _)) ?_
    

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

def nonempty_aux [DecidableEq α] :
    ∀ (c : Circuit α) (l : List α) (hL : c.vars = l), 
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
      let b₁ := nonempty_aux c₁ c₁.vars rfl
      let b₂ := nonempty_aux c₂ c₂.vars rfl
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
decreasing_by sorry

def nonempty [DecidableEq α] (c : Circuit α) : Bool :=
  (nonempty_aux c c.vars rfl).1

lemma nonempty_iff [DecidableEq α] (c : Circuit α) :
    nonempty c ↔ ∃ x, eval c x :=
  by rw [nonempty, ← (nonempty_aux c c.vars rfl).2]

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
