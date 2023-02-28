import Mathlib.Tactic.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.LibrarySearch
import Mathlib.Tactic.Cases
import Mathlib.Data.Quot
import Mathlib.Data.List.AList
import Std.Data.Int.Basic

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

@[reducible] def Env : Type :=
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
def Kind.eval: Kind -> Type
  | .int => Int
  | .nat => Nat
  | .unit => Unit
  | .float => Float
  | .pair p q => p.eval × q.eval
  | .arrow p q => p.eval → q.eval

end AST

section Semantics
open AST

def Semantics (e : Env) : Type :=
  {k : Kind} → Decl e k → k.eval

variable {e : Env} (s : Semantics e)

@[simp, reducible]
def AST.Context.eval : Context → Type
  | .nil => Unit
  | .snoc Γ k => Γ.eval × k.eval

@[reducible]
def AST.Const.eval : {k : Kind} → Const k → k.eval
  | _, .int i => i
  | _, .float f => f
  | _, .unit => ()
  | _, .pair p q => (p.eval, q.eval)

@[simp, reducible]
def AST.Var.eval : {Γ : Context} → {k : Kind} → Var Γ k → Γ.eval → k.eval
  | _, _, .zero _ _ => Prod.snd
  | _, _, .succ v => fun g => v.eval g.1

@[simp, reducible]
def AST.Tuple.eval : {Γ : Context} → {k : Kind} → Tuple e Γ k → Γ.eval → k.eval
  | _, _, .decl d => fun _ => s d
  | _, _, .const c => fun _ => c.eval
  | _, _, .fst t => fun g => (t.eval g).1
  | _, _, .snd t => fun g => (t.eval g).2
  | _, _, .pair a b => fun v => (a.eval v, b.eval v)
  | _, _, .var v => v.eval

@[simp, reducible]
def AST.Expr.eval : {Γ : Context} → {k : Kind} → Expr e Γ k → Γ.eval → k.eval
  | _, _, ._let f x e => fun g => e.eval (g, s f (x.eval s g))
  | _, _, .letlam f x e => fun g => e.eval (g, fun d => s f (x.eval s (g, d)))
  | _, _, .retμrn x => fun g => x.eval g

end Semantics
