import SSA.DependentTypedSSA.Semantics

open Std

namespace AST

-- def Context.union : ∀ {Γ₁ Γ₂ Γ₃ : Context}, (Γ₁ ⟶ Γ₃) → (Γ₂ ⟶ Γ₃) → Context
--   | Γ₁, .nil, _, _, _ => Γ₁
--   | _, .snoc _ k, _, f, g =>
--     let U := Context.union f (toSnoc ≫ g)
--     match Var.preimage f (g (Var.zero _ _)) with
--     | none => U.snoc k
--     | some _ => U

-- def unionInl : ∀ {Γ₁ Γ₂ Γ₃ : Context} (f : Γ₁ ⟶ Γ₃) (g : Γ₂ ⟶ Γ₃),
--     Γ₁ ⟶ (Context.union f g)
--   | _, .nil, _, _, _ => 𝟙 _
--   | _, .snoc Γ₂ k, _, f, g => by
--     simp only [Context.union]
--     cases h : Var.preimage f (g (Var.zero _ _))
--     . exact unionInl _ _ ≫ toSnoc
--     . exact unionInl _ _

-- def unionInr : ∀ {Γ₁ Γ₂ Γ₃ : Context} (f : Γ₁ ⟶ Γ₃) (g : Γ₂ ⟶ Γ₃),
--     Γ₂ ⟶ (Context.union f g)
--   | _, .nil, _, _, _ => default
--   | _, .snoc Γ₂ k, vadd_add_assoc, f, g => by
--     simp only [Context.union]
--     cases h : Var.preimage f (g (Var.zero _ _)) with
--     | none => exact Context.snocHom (unionInr _ _)
--     | some v => exact snocElim (unionInr _ _) $ by
--                   simp
--                   exact unionInl _ _ v

-- def Context.unionEmb : ∀ {Γ₁ Γ₂ Γ₃ : Context} (f : Γ₁ ⟶ Γ₃) (g : Γ₂ ⟶ Γ₃),
--     (Context.union f g) ⟶ Γ₃
--   | _, .nil, _, f, g => f
--   | _, .snoc Γ₂ k, _, f, g => by
--     simp only [Context.union]
--     cases h : Var.preimage f (g (Var.zero _ _)) with
--     | none => exact snocElim (Context.unionEmb _ _) (g (Var.zero _ _))
--     | some v => _

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

-- def Expr.shrinkContext (env : Env): ∀ {Γ : Context} {k : Kind} (e : Expr env Γ k),
--     (Γ' : Context) × (Γ' ⟶ Γ) × Expr env Γ' k
--   | _, _, ._let (b := b) f x e =>
--     let ⟨Γ', f', x'⟩ := x.shrinkContext
--     let ⟨Γ'', f'', e'⟩ := e.shrinkContext
--     ⟨Γ'.append Γ'', Context.appendElim f' (f'' ≫ Context.snocElim (𝟙 _) _), _⟩
--   | _, _, .letlam f x e =>
--     let ⟨Γ', f', x'⟩ := x.shrinkContext
--     let ⟨Γ'', f'', e'⟩ := e.shrinkContext
--     ⟨Γ'.append Γ'', _, _⟩
--   | _, k, .retμrn x => ⟨Context.single k, Context.singleElim x, .retμrn (Var.zero _ _)⟩

end shrinkContext


end AST