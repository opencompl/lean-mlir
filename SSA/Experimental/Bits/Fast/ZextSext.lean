import Std.Tactic.BVDecide
import SSA.Experimental.Bits.Fast.Reflect
import SSA.Experimental.Bits.Fast.FiniteStateMachine

inductive NatExpr (n : Nat) : Type
| var : (v : Fin n) → NatExpr n
| add : NatExpr n → NatExpr n → NatExpr n

def NatExpr.eval (e : NatExpr n) (env : Fin n → Nat) : Nat :=
  match e with
  | .var v => env v
  | .add e1 e2 => NatExpr.eval e1 env + NatExpr.eval e2 env

-- inductive NatPredicate (n : Nat) : Type
-- | eq : NatExpr n → NatExpr n → NatPredicate n

-- def NatPredicate.eval (env : Fin n → Nat) : NatPredicate n → Prop
--   | .eq e1 e2 => NatExpr.eval e1 env = NatExpr.eval e2 env
--
-- def NatPredicate.decide : NatPredicate n → Bool := sorry
--
-- theorem NatPredicate.decide_iff_eval (p : NatPredicate n) :
--   (∀ (env : Fin n → Nat), p.eval env) ↔
--   (p.decide = true) := sorry

-- theorem foo : ∀ (n m : Nat), n + m = m + n := by
--   -- (NatPredicate.eq (NatExpr.add (NatExpr.var 0) (NatExpr.var 1))
--   --   (NatExpr.add (NatExpr.var 1) (NatExpr.var 0))).eval (...)
--   -- revert env
--   -- apply NatPredicate.decide_iff_eval |>.mpr (by rfl)
--   sorry

namespace BV

abbrev BVTyCtx (natCard : Nat) (bvCard : Nat) : Type :=
  Fin bvCard → NatExpr natCard

inductive BVExpr (ctx : BVTyCtx natCard bvCard) : (NatExpr natCard) → Type
| var (v : Fin bvCard) : BVExpr ctx (ctx v)
| add (a : BVExpr ctx w) (b : BVExpr ctx w) : BVExpr ctx w
| append (a : BVExpr ctx v) (b : BVExpr ctx w) : BVExpr ctx (.add v w)

abbrev BVEnv (tyCtx : BVTyCtx natCard bvCard) (natEnv : Fin natCard → Nat) :=
  (v : Fin bvCard) → BitVec ((tyCtx v).eval natEnv)

def BVExpr.eval {natEnv : Fin n → Nat} (bvEnv : BVEnv bvCard natEnv) :
  BVExpr bvCard w → BitVec (w.eval natEnv)
| .var v => bvEnv v
| .add a b => a.eval bvEnv + b.eval bvEnv
| .append a b => a.eval bvEnv ++ b.eval bvEnv

inductive BVPredicate (ctx : BVTyCtx natCard bvCard) : Type
| eq (a : BVExpr ctx w) (b : BVExpr ctx w)

def BVPredicate.eval {natEnv : Fin natCard → Nat} {ctx : BVTyCtx natCard bvCard}
    (bvEnv : BVEnv ctx natEnv) :
  BVPredicate ctx → Prop
| .eq a b => a.eval bvEnv = b.eval bvEnv

def BVPredicate.decide (ctx : BVTyCtx natCard bvCard) :
  BVPredicate ctx → Bool 
| .eq a b => false

theorem BVPredicate.eval_of_decide (ctx : BVTyCtx natCard bvCard)
    (p : BVPredicate ctx) (h : p.decide = true) :
  ∀ (bvEnv : BVEnv ctx natEnv), p.eval bvEnv := by
  sorry

inductive Expr

end BV

