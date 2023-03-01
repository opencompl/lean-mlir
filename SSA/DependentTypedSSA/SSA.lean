import Mathlib.Tactic.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.LibrarySearch
import Mathlib.Tactic.Cases
import Mathlib.Data.Quot
import Mathlib.Data.List.AList
import Mathlib.CategoryTheory.EpiMono
import Std.Data.Int.Basic
import Mathlib.Tactic.Reassoc

open Std

namespace AST

/-
Kinds of values. We must have 'pair' to take multiple arguments.
-/
inductive Kind where
  | int : Kind
  | nat : Kind
  | float : Kind
  | pair : Kind → Kind → Kind
  | arrow : Kind → Kind → Kind
  | unit: Kind
  deriving Inhabited, DecidableEq, BEq

instance : ToString Kind where
  toString k :=
    let rec go : Kind → String
    | .nat => "nat"
    | .int => "int"
    | .float => "float"
    | .unit => "unit"
    | .pair p q => s!"{go p} × {go q}"
    | .arrow p q => s!"{go p} → {go q}"
    go k

-- compile time constant values.
inductive Const : (k : Kind) → Type where
  | int : Int → Const Kind.int
  | float : Float → Const Kind.float
  | unit : Const Kind.unit
  | pair {k₁ k₂} : Const k₁ → Const k₂ → Const (Kind.pair k₁ k₂)
  deriving BEq

instance {k : Kind} : ToString (Const k) where
  toString :=
    let rec go (k : Kind) : Const k → String
    | .int i => toString i
    | .float f => toString f
    | .unit => "()"
    | .pair p q => s!"({go _ p}, {go _ q})"
    go k

inductive Context : Type
  | nil : Context
  | snoc : Context → Kind → Context

inductive Var : (Γ : Context) → Kind → Type where
  | zero (Γ : Context) (k : Kind) : Var (Γ.snoc k) k
  | succ {Γ : Context} {k₁ k₂ : Kind} : Var Γ k₁ → Var (Γ.snoc k₂) k₁
  deriving DecidableEq

@[elab_as_elim]
def Var.elim {Γ : Context} {k₁ : Kind} {motive : ∀ k₂, Var (Γ.snoc k₁) k₂ → Sort _} {k₂ : Kind} :
    ∀ (v : Var (Γ.snoc k₁) k₂)
    (_succ : ∀ k₂ v, motive k₂ (.succ v))
    (_zero : motive _ (.zero Γ k₁)) , motive _ v
  | .zero _ _, _, h => h
  | .succ v, hsucc, _ => hsucc _ v

def Env : Type :=
  String → Option Kind

structure Decl (e : Env) (k : Kind) : Type :=
  ( name : String )
  ( mem : k ∈ e name )

inductive Tuple (e : Env) (Γ : Context) : Kind → Type
  | decl : {k : Kind} → Decl e k → Tuple e Γ k
  | const : {k : Kind} → Const k → Tuple e Γ k
  | var : {k : Kind} → Var Γ k → Tuple e Γ k
  | pair : {k₁ k₂ : Kind} → Tuple e Γ k₁ →
      Tuple e Γ k₂ → Tuple e Γ (Kind.pair k₁ k₂)
  | fst : {k₁ k₂ : Kind} → Tuple e Γ (Kind.pair k₁ k₂) → Tuple e Γ k₁
  | snd : {k₁ k₂ : Kind} → Tuple e Γ (Kind.pair k₁ k₂) → Tuple e Γ k₂

inductive Expr (e : Env) : Context → Kind → Type where
  | _let {Γ : Context}
    {a b k : Kind}
    (f : Decl e (a.arrow b)) --Should be decl
    (x : Tuple e Γ a)
    (exp : Expr e (Γ.snoc b) k)
    -- let _ : b = f x in exp
    : Expr e Γ k
  | letlam {Γ : Context}
    {dom a cod k : Kind}
    (f : Decl e (a.arrow cod)) --Should be decl
    (x : Tuple e (Γ.snoc dom) a)
    (exp : Expr e (Γ.snoc (dom.arrow cod)) k)
    -- let _ : dom → cod := λ _, f x in exp
    : Expr e Γ k
  | retμrn (val : Var Γ k) : Expr e Γ k

-- Lean type that corresponds to kind.
@[reducible, simp]
def Kind.eval: Kind → Type
  | .int => Int
  | .nat => Nat
  | .unit => Unit
  | .float => Float
  | .pair p q => p.eval × q.eval
  | .arrow p q => p.eval → q.eval

section Semantics
open AST

def Semantics (e : Env) : Type :=
  {k : Kind} → Decl e k → k.eval

variable {e : Env} (s : Semantics e)

@[simp, reducible]
def Context.eval (Γ : Context) : Type :=
  ⦃k : Kind⦄ → Var Γ k → k.eval

@[reducible]
def Const.eval : {k : Kind} → Const k → k.eval
  | _, .int i => i
  | _, .float f => f
  | _, .unit => ()
  | _, .pair p q => (p.eval, q.eval)

@[simp, reducible]
def Var.eval : {Γ : Context} → {k : Kind} → Var Γ k → Γ.eval → k.eval :=
  fun v g => g v

@[simp, reducible]
def Tuple.eval : {Γ : Context} → {k : Kind} → Tuple e Γ k → Γ.eval → k.eval
  | _, _, .decl d => fun _ => s d
  | _, _, .const c => fun _ => c.eval
  | _, _, .fst t => fun g => (t.eval g).1
  | _, _, .snd t => fun g => (t.eval g).2
  | _, _, .pair a b => fun v => (a.eval v, b.eval v)
  | _, _, .var v => v.eval

@[simp, reducible]
def Expr.eval : {Γ : Context} → {k : Kind} → Expr e Γ k → Γ.eval → k.eval
  | _, _, ._let f x e => fun g => e.eval (fun _ v => v.elim g (s f (x.eval s g)))
  | _, _, .letlam f x e => fun g => e.eval (fun _ v => v.elim g
    (fun y => s f (x.eval s (fun _ v => v.elim g y))))
  | _, _, .retμrn x => fun g => x.eval g

end Semantics

section changeVars

open AST

open CategoryTheory

instance : Category Context where
  Hom := fun Γ₁ Γ₂ => ∀ ⦃k : Kind⦄, Var Γ₁ k → Var Γ₂ k
  id := fun Γ _ => id
  comp := fun f g k v => g (f v)

variable {Γ₁ Γ₂ Γ₃ : Context}

@[simp]
theorem Context.id_apply (k : Kind) (v : Var Γ₁ k) : (𝟙 Γ₁) v = v :=
  rfl

@[simp]
theorem Context.comp_apply (f : Γ₁ ⟶ Γ₂) (g : Γ₂ ⟶ Γ₃) (k : Kind) (v : Var Γ₁ k) :
    (f ≫ g) v = g (f v) :=
  rfl

@[reducible, simp]
def Context.evalMap {Γ₁ Γ₂ : Context} : (Γ₁ ⟶ Γ₂) → Γ₂.eval → Γ₁.eval :=
  fun f g _ v => g (f v)

theorem Context.evalMap_id : Context.evalMap (𝟙 Γ₁) = id :=
  rfl

theorem Context.evalMap_comp (f : Γ₁ ⟶ Γ₂) (g : Γ₂ ⟶ Γ₃) :
    Context.evalMap (f ≫ g) = Context.evalMap f ∘ Context.evalMap g :=
  rfl

def toSnoc {Γ : Context} {k : Kind} : Γ ⟶ (Γ.snoc k) :=
  fun _ v => v.succ

def snocElim {Γ₁ Γ₂  : Context} {k : Kind} (f : Γ₁ ⟶ Γ₂) (v : Var Γ₂ k) :
  (Γ₁.snoc k) ⟶ Γ₂ :=
  fun _ v₁ => v₁.elim f v

@[reassoc (attr := simp)]
theorem toSnoc_comp_snocElim {Γ₁ Γ₂  : Context} {k : Kind} (f : Γ₁ ⟶ Γ₂) (v : Var Γ₂ k) :
    toSnoc ≫ snocElim f v = f :=
  rfl

@[ext]
theorem snoc_ext {Γ₁ Γ₂  : Context} {k : Kind} {f g : Γ₁.snoc k ⟶ Γ₂}
    (h₁ : f (Var.zero _ _) = g (Var.zero _ _))
    (h₂ : toSnoc ≫ f = toSnoc ≫ g) : f = g := by
  funext k v
  cases v
  . exact h₁
  . exact Function.funext_iff.1 (Function.funext_iff.1 h₂ k) _

@[simp]
theorem snocElim_toSnoc_apply {Γ₁ Γ₂  : Context} {k k' : Kind} (f : Γ₁ ⟶ Γ₂) (v : Var Γ₂ k)
    (v' : Var Γ₁ k') : snocElim f v (toSnoc v') = f v' :=
  rfl

@[simp]
theorem snocElim_zero {Γ₁ Γ₂  : Context} {k : Kind} (f : Γ₁ ⟶ Γ₂) (v : Var Γ₂ k) :
    snocElim f v (Var.zero Γ₁ k) = v :=
  rfl

theorem snocElim_comp {Γ₁ Γ₂ Γ₃ : Context} {k : Kind} (f : Γ₁ ⟶ Γ₂) (v : Var Γ₂ k) (g : Γ₂ ⟶ Γ₃) :
    snocElim f v ≫ g = snocElim (f ≫ g) (g v) :=
  snoc_ext (by simp) (by simp)

def Context.snocHom {Γ₁ Γ₂ : Context} (f : Γ₁ ⟶ Γ₂) : (Γ₁.snoc k ⟶ Γ₂.snoc k) :=
  snocElim (f ≫ toSnoc) (Var.zero _ _)

def Context.append (Γ₁ : Context) : Context → Context
  | .nil => Γ₁
  | .snoc Γ₂ k => (Γ₁.append Γ₂).snoc k

instance : IsEmpty (Var (Context.nil) k) where
  false := fun v => match v with.

instance (Γ : Context) : Unique (Context.nil ⟶ Γ) where
  default := fun _ v => match v with.
  uniq := fun f => by funext k v; cases v

def Context.single (k : Kind) : Context :=
  Context.snoc Context.nil k

instance : Unique (Var (Context.single k) k) where
  default := Var.zero _ _
  uniq := fun v => match v with | Var.zero _ _ => rfl

instance : Subsingleton (Var (Context.single k₁) k₂) :=
  ⟨fun v₁ v₂ => match v₁, v₂ with | Var.zero _ _, Var.zero _ _ => rfl⟩

def Context.singleElim {Γ : Context} (v : Var Γ k) : Context.single k ⟶ Γ :=
  snocElim default v

theorem Context.singleElim_injective {Γ : Context} :
   Function.Injective (Context.singleElim : Var Γ k → (Context.single k ⟶ Γ)) :=
  fun v₁ v₂ h => by
    have : singleElim v₁ (Var.zero _ _) = singleElim v₂ (Var.zero _ _) := by rw [h]
    simpa using this

@[simp]
theorem Context.singleElim_zero {Γ : Context} (v : Var Γ k) :
    Context.singleElim v (Var.zero _ _) = v :=
  rfl

def Context.inl {Γ₁ : Context} : {Γ₂ : Context} → Γ₁ ⟶ Γ₁.append Γ₂
  | .nil => 𝟙 _
  | .snoc _ _ => inl ≫ toSnoc

def Context.inr {Γ₁ : Context} : {Γ₂ : Context} → Γ₂ ⟶ Γ₁.append Γ₂
  | .nil => default
  | .snoc _ _ => snocHom inr

def Context.appendElim {Γ₁ : Context} : {Γ₂ Γ₃ : Context} → (Γ₁ ⟶ Γ₃) → (Γ₂ ⟶ Γ₃) → (Γ₁.append Γ₂ ⟶ Γ₃)
  | .nil, _, f, _ => f
  | .snoc _ _, _, f, g => snocElim (appendElim f (toSnoc ≫ g)) (g (Var.zero _ _))

@[reassoc (attr := simp)]
theorem Context.inl_comp_appendElim {Γ₁ Γ₂ Γ₃ : Context} (f : Γ₁ ⟶ Γ₃) (g : Γ₂ ⟶ Γ₃) :
    Context.inl ≫ Context.appendElim f g = f :=
  by induction Γ₂ <;> simp [*, Context.inl, appendElim] at *

@[reassoc (attr := simp)]
theorem Context.inr_comp_appendElim {Γ₁ Γ₂ Γ₃ : Context} (f : Γ₁ ⟶ Γ₃) (g : Γ₂ ⟶ Γ₃) :
    Context.inr ≫ Context.appendElim f g = g := by
  induction Γ₂ <;> simp [*, Context.inr, appendElim, snocHom, snocElim_comp] at *
  . apply snoc_ext
    . simp [inr, snocHom, appendElim]
    . simp [inr, snocHom, appendElim, snocElim_toSnoc_apply, *]

theorem Context.append_ext : ∀ {Γ₁ Γ₂ Γ₃ : Context} {f g : Γ₁.append Γ₂ ⟶ Γ₃}
    (_h₁ : Context.inl ≫ f = Context.inl ≫ g)
    (_h₂ : Context.inr ≫ f = Context.inr ≫ g), f = g
  | _, .nil, _, _, _, h₁, _ => h₁
  | _, .snoc Γ₂ k, _, f, g, h₁, h₂ => snoc_ext
    (have : (inr ≫ f) (Var.zero _ _) = (inr ≫ g) (Var.zero _ _) := by rw [h₂]
     by simpa using this)
    (Context.append_ext h₁
      (have : toSnoc ≫ (inr ≫ f) = toSnoc ≫ (inr ≫ g) := by rw [h₂]
       by simpa [inr, snocHom] using this))

@[simp]
theorem Context.snocHom_id : Context.snocHom (𝟙 Γ₁) = 𝟙 (Γ₁.snoc k) := by
  ext <;> simp [snocHom]

@[simp]
theorem Context.snocHom_comp (f : Γ₁ ⟶ Γ₂) (g : Γ₂ ⟶ Γ₃) :
    (Context.snocHom (f ≫ g) : Γ₁.snoc k ⟶ Γ₃.snoc k) =
    Context.snocHom f ≫ Context.snocHom g := by
  ext <;> simp [snocHom]

@[simp]
theorem Context.evalMap_snocHom {Γ₁ Γ₂ : Context} (f : Γ₁ ⟶ Γ₂) (g : (Γ₂.snoc k).eval) :
    Context.evalMap (Context.snocHom f) g = fun _ v => v.elim
      (fun _ v => g (Var.succ (f v))) (g (Var.zero _ _)) := by
  funext k v; cases v <;> simp [Var.elim, snocHom, evalMap, snocElim, toSnoc]

@[simp] theorem Context.elim_snocHom {Γ₁ Γ₂ : Context} {k₁ : Kind}
    {motive : ∀ k₂, Var (Γ₂.snoc k₁) k₂ → Sort _} {k₂ : Kind}
    (f : Γ₁ ⟶ Γ₂) (v : Var (Γ₁.snoc k₁) k₂)
    (succ : ∀ k₂ v, motive k₂ (Var.succ v))
    (zero : motive k₁ (Var.zero _ _)) :
    (Var.elim (Context.snocHom f v) succ zero : motive k₂ (Context.snocHom f v)) =
    (Var.elim v (fun _ v => succ _ (f v)) zero) := by
  cases v <;> simp [Var.elim, snocHom, snocElim, toSnoc]

@[simp]
def Tuple.changeVars : {Γ₁ Γ₂ : Context} → (Γ₁ ⟶ Γ₂) → Tuple e Γ₁ k → Tuple e Γ₂ k
  | _, _, _, .decl d => .decl d
  | _, _, _, .const c => .const c
  | _, _, h, .fst t => .fst (t.changeVars h)
  | _, _, h, .snd t => .snd (t.changeVars h)
  | _, _, h, .pair a b => .pair (a.changeVars h) (b.changeVars h)
  | _, _, h, .var v => .var (h v)

@[simp]
theorem Tuple.changeVars_id :
    (Tuple.changeVars (𝟙 Γ₁) : Tuple e Γ₁ k → Tuple e Γ₁ k) = id :=
  funext <| fun t => by induction t <;> simp [*] at *

@[simp]
theorem Tuple.changeVars_comp (f : Γ₁ ⟶ Γ₂) (g : Γ₂ ⟶ Γ₃) :
    (Tuple.changeVars (f ≫ g) : Tuple e Γ₁ k → Tuple e Γ₃ k) =
      Tuple.changeVars g ∘ Tuple.changeVars f :=
  funext <| fun t => by induction t <;> simp [*] at *

theorem Tuple.changeVars_comp_apply (f : Γ₁ ⟶ Γ₂) (g : Γ₂ ⟶ Γ₃) (t : Tuple e Γ₁ k) :
    Tuple.changeVars (f ≫ g) t = Tuple.changeVars g (Tuple.changeVars f t) :=
  by simp

@[simp]
theorem Tuple.changeVars_eval (f : Γ₁ ⟶ Γ₂) (t : Tuple e Γ₁ k) (g : Γ₂.eval) :
    (t.changeVars f).eval s g = t.eval s (Context.evalMap f g) := by
  induction t <;> simp [*] at *

@[simp]
def Expr.changeVars : {Γ₁ Γ₂ : Context} → (Γ₁ ⟶ Γ₂) → Expr e Γ₁ k → Expr e Γ₂ k
  | _, _, h, ._let f x e => ._let f (x.changeVars h) (e.changeVars (Context.snocHom h))
  | _, _, h, .letlam f x e =>
    .letlam f
      (x.changeVars (Context.snocHom h))
      (e.changeVars (Context.snocHom h))
  | _, _, h, .retμrn x => .retμrn (h x)

@[simp]
theorem Expr.changeVars_id :
    (Expr.changeVars (𝟙 Γ₁) : Expr e Γ₁ k → Expr e Γ₁ k) = id :=
  funext <| fun t => by induction t <;> simp [*] at *

theorem Expr.changeVars_comp_apply : ∀ {Γ₁ Γ₂ Γ₃} (f : Γ₁ ⟶ Γ₂) (g : Γ₂ ⟶ Γ₃)
    (ex : Expr e Γ₁ k),
    (ex.changeVars (f ≫ g) : Expr e Γ₃ k) =
      (ex.changeVars f).changeVars g
  | _, _, _, f, g, ._let f' x e => by
    simp [Expr.changeVars, Expr.changeVars_comp_apply _ _ e]
  | _, _, _, f, g, .letlam f' x e => by
    simp [Expr.changeVars, Expr.changeVars_comp_apply _ _ e]
  | _, _, _, f, g, .retμrn x => by simp

@[simp]
theorem Expr.changeVars_comp (f : Γ₁ ⟶ Γ₂) (g : Γ₂ ⟶ Γ₃) :
    (Expr.changeVars (f ≫ g) : Expr e Γ₁ k → Expr e Γ₃ k) =
      Expr.changeVars g ∘ Expr.changeVars f :=
  funext <| fun t => t.changeVars_comp_apply _ _

@[simp]
theorem Expr.changeVars_eval : ∀ {k : Kind} {Γ₁ Γ₂ : Context} (f : Γ₁ ⟶ Γ₂)
    (e : Expr e Γ₁ k) (g : Γ₂.eval), (e.changeVars f).eval s g = e.eval s (Context.evalMap f g)
  | _, _, _, f, ._let f' x e, g => by simp [Expr.changeVars_eval _ e]
  | _, _, _, f, .letlam f' x e, g => by simp [Expr.changeVars_eval _ e]
  | _, _, _, f, .retμrn x, g => by simp

def Var.preimage : {Γ₁ Γ₂ : Context} → (Γ₁ ⟶ Γ₂) → Var Γ₂ k → Option (Var Γ₁ k)
  | Context.nil, _, _, _ => none
  | Context.snoc _ k', _, f, v =>
    match Var.preimage (toSnoc ≫ f) v with
    | none => if h : ∃ h : k' = k, f (Var.zero _ _) = h ▸ v
        then some (h.fst ▸ Var.zero _ _) else none
    | some v' => some (toSnoc v')

theorem Var.eq_of_mem_preimage : ∀ {Γ₁ Γ₂ : Context} {f : Γ₁ ⟶ Γ₂} {v : Var Γ₂ k}
    {v' : Var Γ₁ k}, Var.preimage f v = some v' → f v' = v
  | Context.snoc _ k', _, f, v, v', h => by
    simp only [Var.preimage] at h
    cases h' : preimage (toSnoc ≫ f) v
    . simp only [h'] at h
      split_ifs at h with h₁
      cases h
      rcases h₁ with ⟨rfl, h₁⟩
      exact h₁
    . simp only [h', Option.some.injEq] at h
      rw [← Var.eq_of_mem_preimage h', ← h]
      simp

theorem Var.preimage_eq_none_iff : ∀ {Γ₁ Γ₂ : Context} (f : Γ₁ ⟶ Γ₂) (v : Var Γ₂ k),
    Var.preimage f v = none ↔ ∀ (v' : Var Γ₁ k), f v' ≠ v
  | Context.nil, _, _, _ => by simp [Var.preimage]
  | Context.snoc _ k', _, f, v => by
      rw [Var.preimage]
      cases h : preimage (toSnoc ≫ f) v
      . rw [Var.preimage_eq_none_iff] at h
        simp only [dite_eq_right_iff, forall_exists_index, ne_eq]
        constructor
        . intro h' v'
          cases v'
          . exact h' rfl
          exact h _
        . intro h' heq
          cases heq
          exact h' _
      . simp only [ne_eq, false_iff, not_forall, not_not]
        rw [← Var.eq_of_mem_preimage h]
        simp

theorem mono_iff_injective {f : Γ₁ ⟶ Γ₂} :
    Mono f ↔ (∀ k, Function.Injective (@f k)) := by
  constructor
  . intro h k v₁ v₂ hv
    refine Context.singleElim_injective
      (Mono.right_cancellation (f := f)
        (Context.singleElim v₁) (Context.singleElim v₂) ?_)
    funext k v
    cases v with
    | zero _ _ => simp [hv]
    | succ v => cases v
  . intro h
    constructor
    intro Γ₃ g i gi
    funext k v
    apply h
    rw [← Context.comp_apply g f, gi, Context.comp_apply]

theorem injective {Γ₁ Γ₂ : Context} (f : Γ₁ ⟶ Γ₂) [Mono f] :
    ∀ k, Function.Injective (@f k) := by
  rw [← mono_iff_injective]; infer_instance

@[simp]
theorem Context.eq_iff {Γ₁ Γ₂ : Context} (f : Γ₁ ⟶ Γ₂) [Mono f] {k : Kind} (v₁ v₂ : Var Γ₁ k) :
    f v₁ = f v₂ ↔ v₁ = v₂ := (injective f k).eq_iff

instance : Mono (@toSnoc Γ k) :=
  mono_iff_injective.2 (fun _ _ h => by simp [toSnoc] at *)

instance {k : Kind} (v : Var Γ k) : Mono (Context.singleElim v) :=
  mono_iff_injective.2 (fun _ _ _ _ => Subsingleton.elim _ _)

def Context.union : ∀ {Γ₁ Γ₂ Γ₃ : Context}, (Γ₁ ⟶ Γ₃) → (Γ₂ ⟶ Γ₃) → Context
  | Γ₁, .nil, _, _, _ => Γ₁
  | _, .snoc _ k, _, f, g =>
    let U := Context.union f (toSnoc ≫ g)
    match Var.preimage f (g (Var.zero _ _)) with
    | none => U.snoc k
    | some _ => U

def unionInl : ∀ {Γ₁ Γ₂ Γ₃ : Context} (f : Γ₁ ⟶ Γ₃) (g : Γ₂ ⟶ Γ₃),
    Γ₁ ⟶ (Context.union f g)
  | _, .nil, _, _, _ => 𝟙 _
  | _, .snoc Γ₂ k, _, f, g => by
    simp only [Context.union]
    cases h : Var.preimage f (g (Var.zero _ _))
    . exact unionInl _ _ ≫ toSnoc
    . exact unionInl _ _

def unionInr : ∀ {Γ₁ Γ₂ Γ₃ : Context} (f : Γ₁ ⟶ Γ₃) (g : Γ₂ ⟶ Γ₃),
    Γ₂ ⟶ (Context.union f g)
  | _, .nil, _, _, _ => default
  | _, .snoc Γ₂ k, vadd_add_assoc, f, g => by
    simp only [Context.union]
    cases h : Var.preimage f (g (Var.zero _ _)) with
    | none => exact Context.snocHom (unionInr _ _)
    | some v => exact snocElim (unionInr _ _) $ by
                  simp
                  exact unionInl _ _ v

def Context.unionEmb : ∀ {Γ₁ Γ₂ Γ₃ : Context} (f : Γ₁ ⟶ Γ₃) (g : Γ₂ ⟶ Γ₃),
    (Context.union f g) ⟶ Γ₃
  | _, .nil, _, f, g => f
  | _, .snoc Γ₂ k, _, f, g => by
    simp only [Context.union]
    cases h : Var.preimage f (g (Var.zero _ _)) with
    | none => exact snocElim (Context.unionEmb _ _) (g (Var.zero _ _))
    | some v => _


end changeVars

section shrinkContext

--This is bad in the pair case. Need unions of contexts.
@[simp]
def Tuple.shrinkContext {Γ : Context} : {k : Kind} → (t : Tuple e Γ k) →
    (Γ' : Context) × (Γ' ⟶ Γ) × Tuple e Γ' k
  | _, .decl d => ⟨Context.nil, default, .decl d⟩
  | _, .const c => ⟨Context.nil, default, .const c⟩
  | _, .fst t =>
    let ⟨Γ', f, t'⟩ := t.shrinkContext
    ⟨Γ', f, .fst t'⟩
  | _, .snd t =>
    let ⟨Γ', f, t'⟩ := t.shrinkContext
    ⟨Γ', f, .snd t'⟩
  | _, .pair a b =>
    let ⟨Γ', f, a'⟩ := a.shrinkContext
    let ⟨Γ'', f', b'⟩ := b.shrinkContext
    ⟨Γ'.append Γ'', Context.appendElim f f',
      (a'.changeVars Context.inl).pair (b'.changeVars Context.inr)⟩
  | k, .var v => ⟨Context.single k, Context.singleElim v, .var (Var.zero _ _)⟩

@[simp]
theorem Tuple.changeVars_shrinkContext {Γ : Context} : ∀ {k : Kind} (t : Tuple e Γ k),
    (t.shrinkContext.2.2).changeVars t.shrinkContext.2.1 = t
  | _, .decl d => by simp
  | _, .const c => by simp
  | _, .fst t => by simp [t.changeVars_shrinkContext]
  | _, .snd t => by simp [t.changeVars_shrinkContext]
  | _, .pair a b => by
     simp only [changeVars, shrinkContext]
     rw [← Tuple.changeVars_comp_apply, Context.inl_comp_appendElim,
        ← Tuple.changeVars_comp_apply, Context.inr_comp_appendElim,
        a.changeVars_shrinkContext, b.changeVars_shrinkContext]
  | _, .var v => by simp

def Expr.shrinkContext (env : Env): ∀ {Γ : Context} {k : Kind} (e : Expr env Γ k),
    (Γ' : Context) × (Γ' ⟶ Γ) × Expr env Γ' k
  | _, _, ._let (b := b) f x e =>
    let ⟨Γ', f', x'⟩ := x.shrinkContext
    let ⟨Γ'', f'', e'⟩ := e.shrinkContext
    ⟨Γ'.append Γ'', Context.appendElim f' (f'' ≫ snocElim (𝟙 _) _), _⟩
  | _, _, .letlam f x e =>
    let ⟨Γ', f', x'⟩ := x.shrinkContext
    let ⟨Γ'', f'', e'⟩ := e.shrinkContext
    ⟨Γ'.append Γ'', _, _⟩
  | _, k, .retμrn x => ⟨Context.single k, Context.singleElim x, .retμrn (Var.zero _ _)⟩

end shrinkContext


end AST