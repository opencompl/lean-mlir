import SSA.Experimental.Bits.MultiWidth.Tactic

open MultiWidth


abbrev ty := BitVec (WidthExpr.toNat (WidthExpr.var (Fin.mk 0 (by simp))) (WidthExpr.Env.empty.cons 10))

theorem hty : ty = BitVec 10 := by
  unfold ty
  rfl

set_option pp.analyze true
set_option pp.analyze.explicitHoles true
set_option pp.analyze.checkInstances true
set_option trace.Meta.check true

theorem foo (w : Nat) :
  w = WidthExpr.toNat (WidthExpr.var (Fin.mk 0 (by simp))) (WidthExpr.Env.empty.cons w) := rfl

theorem eg1 (w : Nat) (x : BitVec w) : x = x := by
  bv_multi_width
