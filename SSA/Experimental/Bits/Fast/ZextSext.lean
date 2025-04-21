import Std.Tactic.BVDecide
import SSA.Experimental.Bits.Fast.Reflect
import SSA.Experimental.Bits.Fast.FiniteStateMachine

inductive NatExpr (n : Nat) : Type
| var : (v : Fin n) → NatExpr n
| add : NatExpr n → NatExpr n → NatExpr n

def NatExpr.toDefEqBV (e : NatExpr n) (env : Fin n → Nat) : Nat :=
  match e with
  | .var v => env v
  | .add e1 e2 => NatExpr.toDefEqBV e1 env + NatExpr.toDefEqBV e2 env

-- inductive NatPredicate (n : Nat) : Type
-- | eq : NatExpr n → NatExpr n → NatPredicate n

-- def NatPredicate.toDefEqBV (env : Fin n → Nat) : NatPredicate n → Prop
--   | .eq e1 e2 => NatExpr.toDefEqBV e1 env = NatExpr.toDefEqBV e2 env
--
-- def NatPredicate.decide : NatPredicate n → Bool := sorry
--
-- theorem NatPredicate.decide_iff_toDefEqBV (p : NatPredicate n) :
--   (∀ (env : Fin n → Nat), p.toDefEqBV env) ↔
--   (p.decide = true) := sorry

-- theorem foo : ∀ (n m : Nat), n + m = m + n := by
--   -- (NatPredicate.eq (NatExpr.add (NatExpr.var 0) (NatExpr.var 1))
--   --   (NatExpr.add (NatExpr.var 1) (NatExpr.var 0))).toDefEqBV (...)
--   -- revert env
--   -- apply NatPredicate.decide_iff_toDefEqBV |>.mpr (by rfl)
--   sorry

namespace BV

abbrev BVTyCtx (natCard : Nat) (bvCard : Nat) : Type :=
  Fin bvCard → NatExpr natCard

inductive BVExpr (ctx : BVTyCtx natCard bvCard) : (NatExpr natCard) → Type
| var (v : Fin bvCard) : BVExpr ctx (ctx v)
| add (a : BVExpr ctx w) (b : BVExpr ctx w) : BVExpr ctx w
| append (a : BVExpr ctx v) (b : BVExpr ctx w) : BVExpr ctx (.add v w)

abbrev BVEnv (tyCtx : BVTyCtx natCard bvCard) (natEnv : Fin natCard → Nat) :=
  (v : Fin bvCard) → BitVec ((tyCtx v).toDefEqBV natEnv)

def BVExpr.toDefEqBV {natEnv : Fin n → Nat} (bvEnv : BVEnv bvCard natEnv) :
  BVExpr bvCard w → BitVec (w.toDefEqBV natEnv)
| .var v => bvEnv v
| .add a b => a.toDefEqBV bvEnv + b.toDefEqBV bvEnv
| .append a b => a.toDefEqBV bvEnv ++ b.toDefEqBV bvEnv

inductive BVPredicate (ctx : BVTyCtx natCard bvCard) : Type
| eq (a : BVExpr ctx w) (b : BVExpr ctx w)

def BVPredicate.toDefEqBV {natEnv : Fin natCard → Nat} {ctx : BVTyCtx natCard bvCard}
    (bvEnv : BVEnv ctx natEnv) :
  BVPredicate ctx → Prop
| .eq a b => a.toDefEqBV bvEnv = b.toDefEqBV bvEnv

def BVPredicate.decide (ctx : BVTyCtx natCard bvCard) :
  BVPredicate ctx → Bool 
| .eq a b => false


/-- Rewrite rule to express msb in terms of slt. -/
theorem BitVec.msb_iff_slt_zero (bv : BitVec w) :
  bv.msb = true ↔ bv.slt 0#w = true := by
  simp [BitVec.msb_eq_toInt, BitVec.slt_eq_decide]

theorem BVPredicate.toDefEqBV_of_decide (ctx : BVTyCtx natCard bvCard)
    (p : BVPredicate ctx) (h : p.decide = true) :
  ∀ (bvEnv : BVEnv ctx natEnv), p.toDefEqBV bvEnv := by
  sorry

inductive Expr

end BV

