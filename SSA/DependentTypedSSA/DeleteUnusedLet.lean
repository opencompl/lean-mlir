import SSA.DependentTypedSSA.Semantics
import SSA.DependentTypedSSA.Context.Subcontext
import SSA.DependentTypedSSA.ChangeVars

open Std

namespace AST

open Subcontext

def Tuple.usedVars {Γ : Context} : {k : Kind} → (t : Tuple e Γ k) →
    Subcontext Γ
  | _, .decl _ => ⊥
  | _, .const _ => ⊥
  | _, .fst t => t.usedVars
  | _, .snd t => t.usedVars
  | _, .pair a b => a.usedVars ⊔ b.usedVars
  | _, .var v => singleton v

@[simp]
def Tuple.shrinkContext {Γ : Context} : {k : Kind} → (t : Tuple e Γ k) →
    Tuple e t.usedVars k
  | _, .decl d => .decl d
  | _, .const c => .const c
  | _, .fst t => .fst t.shrinkContext
  | _, .snd t => .snd t.shrinkContext
  | _, .pair a b =>
    let a' := a.shrinkContext
    let b' := b.shrinkContext
    .pair
      (a'.changeVars (ofLE (by simp [usedVars])))
      (b'.changeVars (ofLE (by simp [usedVars])))
  | k, .var v => .var (restrictVar (singleton_apply_self v))

@[simp]
theorem Tuple.changeVars_shrinkContext {Γ : Context} : ∀ {k : Kind} (t : Tuple e Γ k),
    t.shrinkContext.changeVars (ofSubcontext t.usedVars) = t
  | _, .decl d => by simp
  | _, .const c => by simp
  | _, .fst t => by simp [t.changeVars_shrinkContext, usedVars]
  | _, .snd t => by simp [t.changeVars_shrinkContext, usedVars]
  | _, .pair a b => by
    conv_rhs => rw [← a.changeVars_shrinkContext, ← b.changeVars_shrinkContext]
    simp only [shrinkContext, Tuple.changeVars]
    simp only [← changeVars_comp_apply, ofLE_comp_ofSubcontext]
  | _, .var v => by simp

theorem Tuple.eval_shrinkContext {Γ : Context} {k : Kind} (t : Tuple e Γ k)
    (g : Γ.eval) :
    t.shrinkContext.eval s (Context.evalMap (ofSubcontext _) g) = t.eval s g := by
  rw [← Tuple.eval_changeVars, Tuple.changeVars_shrinkContext]

def Expr.usedVars {env : Env} : ∀ {Γ : Context} {k : Kind} (_ : Expr env Γ k),
    Subcontext Γ
  | _, _, ._let _ x e => x.usedVars ⊔ ofSnoc e.usedVars
  | _, _, .letlam _ x e => ofSnoc x.usedVars ⊔ ofSnoc e.usedVars
  | _, _, .retμrn x => singleton x

def Expr.shrinkContext {env : Env} : ∀ {Γ : Context} {k : Kind} (e : Expr env Γ k),
    Expr env e.usedVars k
  | _, _, ._let f x e =>
    let x' := x.shrinkContext
    let e' := e.shrinkContext
    ._let f (x'.changeVars (ofLE (by simp [usedVars])))
            (e'.changeVars (by
                rw [← Subcontext.toContext_toSnocMem];
                exact ofLE (by simp [usedVars])))
  | _, _, .letlam (dom := dom) (cod := cod) f x e =>
    let x' := x.shrinkContext
    let e' := e.shrinkContext
    .letlam (dom := dom) (cod := cod) f
      (x'.changeVars (by
                rw [← Subcontext.toContext_toSnocMem];
                exact ofLE (by simp [usedVars])))
      (e'.changeVars (by
                rw [← Subcontext.toContext_toSnocMem];
                exact ofLE (by simp [usedVars])))
  | _, _, .retμrn x => .retμrn (restrictVar (singleton_apply_self x))

theorem Expr.changeVars_shrinkContext {env : Env} : ∀ {Γ : Context} {k : Kind} (e : Expr env Γ k),
    e.shrinkContext.changeVars (ofSubcontext e.usedVars) = e
  | _, _, ._let f x e => by
      dsimp
      rw [ ← Tuple.changeVars_comp_apply, ofLE_comp_ofSubcontext, ← Expr.changeVars_comp_apply,
        ← ofSubcontext_toSnocMem, ofLE_comp_ofSubcontext, e.changeVars_shrinkContext,
        Tuple.changeVars_shrinkContext]
  | _, _, .letlam (dom := dom) (cod := cod) f x e => by
      dsimp
      rw [ ← Tuple.changeVars_comp_apply, ← ofSubcontext_toSnocMem,
        ofLE_comp_ofSubcontext, ← Expr.changeVars_comp_apply,
        ← ofSubcontext_toSnocMem, ofLE_comp_ofSubcontext, e.changeVars_shrinkContext,
        Tuple.changeVars_shrinkContext]
  | _, _, .retμrn x => by simp

theorem Expr.eval_shrinkContext {Γ : Context} {k : Kind} (e : Expr env Γ k) (g : Γ.eval) :
    e.shrinkContext.eval s (Context.evalMap (ofSubcontext _) g) = e.eval s g := by
  rw [← Expr.eval_changeVars, Expr.changeVars_shrinkContext]

def Expr.letIf
    {Γ : Context} {a b k : Kind} (f : Decl env (Kind.arrow a b))
    (x : Tuple env Γ a) (e : Expr env (Γ.snoc b) k) :
    Expr env Γ k :=
  if h : e.usedVars (Var.zero _ _)
  then ._let f x e
  else e.shrinkContext.changeVars (ofSubcontextSnocOfNotMem h)

@[simp]
theorem Expr.eval_letIf
    {Γ : Context} {a b k : Kind} (f : Decl env (Kind.arrow a b))
    (x : Tuple env Γ a) (e : Expr env (Γ.snoc b) k) :
    ∀ s g, (Expr.letIf f x e : Expr env Γ k).eval s g =
           (Expr._let f x e : Expr env Γ k).eval s g := by
  rw [Expr.letIf]
  intro s g
  split_ifs with h
  . exact rfl
  . conv_rhs => dsimp [eval]; rw [← Expr.eval_shrinkContext]
    simp only [eval_changeVars, Context.evalMap]
    congr
    funext x v
    induction v using Var.subcontextCasesOn with
    | h v' hv' =>
      cases v'
      . exact (h hv').elim
      . simp [Var.elim]

def Expr.letlamIf {Γ : Context} {dom a cod k : Kind}
    (f : Decl env (Kind.arrow a cod)) (x : Tuple env (Context.snoc Γ dom) a)
    (e : Expr env (Context.snoc Γ (Kind.arrow dom cod)) k) : Expr env Γ k :=
  if h : e.usedVars (Var.zero _ _)
  then .letlam f x e
  else e.shrinkContext.changeVars (ofSubcontextSnocOfNotMem h)

@[simp]
theorem Expr.eval_letlamIf {Γ : Context} {dom a cod k : Kind}
    (f : Decl env (Kind.arrow a cod)) (x : Tuple env (Context.snoc Γ dom) a)
    (e : Expr env (Context.snoc Γ (Kind.arrow dom cod)) k) :
    ∀ s g, (Expr.letlamIf f x e : Expr env Γ k).eval s g =
           (Expr.letlam f x e : Expr env Γ k).eval s g := by
  rw [Expr.letlamIf]
  intro s g
  split_ifs with h
  . exact rfl
  . conv_rhs => dsimp [eval]; rw [← Expr.eval_shrinkContext]
    simp only [eval_changeVars, Context.evalMap]
    congr
    funext x v
    induction v using Var.subcontextCasesOn with
    | h v' hv' =>
      cases v'
      . exact (h hv').elim
      . simp [Var.elim]

def Expr.deleteUnusedLets {env : Env} : ∀ {Γ : Context} {k : Kind},
    Expr env Γ k → Expr env Γ k
  | _, _, ._let f x e => .letIf f x e
  | _, _, .letlam f x e => .letlamIf f x e
  | _, _, .retμrn x => .retμrn x

@[simp]
theorem Expr.eval_deleteUnusedLets {s : Semantics env} :
    ∀ {Γ : Context} {k : Kind} (e : Expr env Γ k)
    (g : Γ.eval), e.deleteUnusedLets.eval s g = e.eval s g
  | _, _, ._let (b := b) f x e => by simp [Expr.deleteUnusedLets]
  | _, _, .letlam  f x e => by simp [Expr.deleteUnusedLets]
  | _, k, .retμrn x => by simp [Expr.deleteUnusedLets]

end AST