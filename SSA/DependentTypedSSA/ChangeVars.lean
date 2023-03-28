import SSA.DependentTypedSSA.Semantics

namespace AST

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
theorem Tuple.eval_changeVars (f : Γ₁ ⟶ Γ₂) (t : Tuple e Γ₁ k) (g : Γ₂.eval) :
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
  funext <| fun t => by induction t <;> simp [*, Expr.changeVars] at *

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
theorem Expr.eval_changeVars : ∀ {k : Kind} {Γ₁ Γ₂ : Context} (f : Γ₁ ⟶ Γ₂)
    (e : Expr e Γ₁ k) (g : Γ₂.eval), (e.changeVars f).eval s g = e.eval s (Context.evalMap f g)
  | _, _, _, f, ._let f' x e, g => by  simp [Expr.eval_changeVars _ e]
  | _, _, _, f, .letlam f' x e, g => by simp [Expr.eval_changeVars _ e]
  | _, _, _, f, .retμrn x, g => by simp

end AST