import Mathlib.Algebra.Notation.Defs
import Mathlib.Order.Notation

import Std.Tactic.BVDecide

namespace MultiWidth

inductive WidthExpr (n : Nat) : Type
| var : (v : Fin n) → WidthExpr n

def WidthExpr.Env (n : Nat) : Type :=
  Fin n → Nat

def WidthExpr.eval (e : WidthExpr n) (env : Fin n → Nat) : Nat :=
  match e with
  | .var v => env v

inductive NatPredicate (n : Nat) : Type
| eq : WidthExpr n → WidthExpr n → NatPredicate n

def NatPredicate.eval (env : Fin n → Nat) : NatPredicate n → Prop
  | .eq e1 e2 => WidthExpr.eval e1 env = WidthExpr.eval e2 env


abbrev Term.Ctx (widthCard : Nat) (termCard : Nat) : Type :=
  Fin termCard → WidthExpr widthCard

inductive Term
  (ctx : Term.Ctx widthCard termCard) : (WidthExpr widthCard) → Type
/-- a variable of a given width -/
| var (v : Fin termCard) : Term ctx (ctx v)
/-- addition of two terms of the same width -/
| add (a : Term ctx w) (b : Term ctx w) : Term ctx w
/-- zero extend a term to a given width -/
| zext (a : Term ctx w) (v : WidthExpr widthCard) : Term ctx v
/-- sign extend a term to a given width -/
| sext (a : Term ctx w) (v : WidthExpr widthCard) : Term ctx v

/--
Environments are for evaluation.
-/
abbrev Term.Env
  (tyCtx : Term.Ctx widthCard termCard)
  (widthEnv : Fin widthCard → Nat) :=
  (v : Fin termCard) → BitVec ((tyCtx v).eval widthEnv)

/-- Evaluate a term to get a concrete bitvector expression. -/
def Term.eval {widthEnv : WidthExpr.Env widthCard}
    (bvEnv : Term.Env termCard widthEnv) :
  Term termCard w → BitVec (w.eval widthEnv)
| .var v => bvEnv v
| .add a b => a.eval bvEnv + b.eval bvEnv
| .zext a v => (a.eval bvEnv).zeroExtend (v.eval widthEnv)
| .sext a v => (a.eval bvEnv).signExtend (v.eval widthEnv)

inductive BinaryRelationKind
| eq

inductive Predicate
  (ctx : Term.Ctx widthCard termCard) : Type
| binRel (k : BinaryRelationKind) (a : Term ctx w) (b : Term ctx w) : Predicate ctx
| and (p1 p2 : Predicate ctx) : Predicate ctx
| or (p1 p2 : Predicate ctx) : Predicate ctx
| not (p : Predicate ctx) : Predicate ctx

end MultiWidth


