import SSA.DependentTypedSSA.Expr

namespace AST

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

@[reducible, simp]
def Context.evalMap {Γ₁ Γ₂ : Context} : (Γ₁ ⟶ Γ₂) → Γ₂.eval → Γ₁.eval :=
  fun f g _ v => g (f v)

@[simp]
theorem Context.evalMap_id : Context.evalMap (𝟙 Γ₁) = id :=
  rfl

@[simp]
theorem Context.evalMap_comp (f : Γ₁ ⟶ Γ₂) (g : Γ₂ ⟶ Γ₃) :
    Context.evalMap (f ≫ g) = Context.evalMap f ∘ Context.evalMap g :=
  rfl

theorem Context.evalMap_comp_apply (f : Γ₁ ⟶ Γ₂) (g : Γ₂ ⟶ Γ₃) (v : Γ₃.eval) :
    Context.evalMap (f ≫ g) v = Context.evalMap f (Context.evalMap g v) :=
  rfl

end AST