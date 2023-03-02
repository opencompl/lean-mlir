import Mathlib.Init.Data.Option.Basic
import SSA.DependentTypedSSA.Context.Basic

namespace AST

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

end AST