import SSA.Experimental.Bits.MultiWidth.Tactic

open MultiWidth


abbrev ty := BitVec (WidthExpr.toNat (WidthExpr.var (Fin.mk 0 (by simp))) (WidthExpr.Env.empty.cons 10))

theorem hty : ty = BitVec 10 := by
  unfold ty
  rfl

example (w : Nat) :
      w = (WidthExpr.var (wcard := 2) ⟨0, by simp⟩).toNat
      ((WidthExpr.Env.empty.cons u).cons w) := rfl


/-
set_option pp.analyze true
set_option pp.analyze.explicitHoles true
set_option pp.analyze.checkInstances true
set_option trace.Meta.check true
-/

theorem foo (w : Nat) :
  w = WidthExpr.toNat (WidthExpr.var (Fin.mk 0 (by simp))) (WidthExpr.Env.empty.cons w) := rfl

/--
info: collected predicate: MultiWidth.Nondep.Predicate.binRel
  (MultiWidth.BinaryRelationKind.eq)
  (MultiWidth.Nondep.Term.var 0 { toNat := 0 })
  (MultiWidth.Nondep.Term.var 0 { toNat := 0 })
---
info: fsm circuit size: 24
---
info: FSM state space size: 8
---
info: proven by KInduction with 0 iterations
---
info: making safety certs...
---
info: made safety cert expr: (ReflectVerif.BvDecide.KInductionCircuits.mkN
        (mkPredicateFSMDep
            (Predicate.binRel BinaryRelationKind.eq (MultiWidth.Term.var ⟨0, ⋯⟩) (MultiWidth.Term.var ⟨0, ⋯⟩))).toFsm
        10).mkSafetyCircuit.verifyCircuit
  "193 65 0 1 2 0\n194 68 0 1 3 0\n195 12 0 194 5 0\n196 67 0 194 6 0\n197 2 0 196 8 0\n198 66 0 196 9 0\n199 3 0 198 11 0\n200 6 0 198 12 0\n201 30 0 193 14 0\n202 15 0 201 116 0\n203 -13 0 202 156 0\n204 -11 0 203 195 164 0\n205 -10 0 204 197 169 0\n206 8 9 0 205 172 0\n207 7 -4 0 200 181 0\n208 5 -4 0 199 186 0\n209 -5 0 176 185 206 207 174 0\n210 -9 0 209 173 0\n211 -4 0 209 208 0\n212 8 0 210 206 0\n213 -7 0 211 179 0\n214 0 212 213 177 0\n"
---
info: making safety cert = true proof...
---
error: Application type mismatch: The argument
  Eq.refl true
has type
  true = true
but is expected to have type
  Lean.reduceBool eg1.safetyCert.mkEqRflNativeDecideProof_1_1 = true
in the application
  Lean.ofReduceBool eg1.safetyCert.mkEqRflNativeDecideProof_1_1 true (Eq.refl true)
-/
#guard_msgs in theorem eg1 (w : Nat) (x : BitVec w) : x = x := by
  bv_multi_width

/--
info: collected predicate: MultiWidth.Nondep.Predicate.binRel
  (MultiWidth.BinaryRelationKind.eq)
  (MultiWidth.Nondep.Term.var 0 { toNat := 0 })
  (MultiWidth.Nondep.Term.add
    (MultiWidth.Nondep.Term.var 0 { toNat := 0 })
    (MultiWidth.Nondep.Term.var 1 { toNat := 0 }))
---
info: fsm circuit size: 58
---
info: FSM state space size: 32
---
warning: abstracted non-variable bitvector: ⏎
  → '1'
---
error: safety failure at iteration 0 for predicate MultiWidth.Nondep.Predicate.binRel
  (MultiWidth.BinaryRelationKind.eq)
  (MultiWidth.Nondep.Term.var 0 { toNat := 0 })
  (MultiWidth.Nondep.Term.add
    (MultiWidth.Nondep.Term.var 0 { toNat := 0 })
    (MultiWidth.Nondep.Term.var 1 { toNat := 0 }))
-/
#guard_msgs in theorem eg2 (w : Nat) (x : BitVec w) : x = x + 1 := by
  bv_multi_width

theorem eg3 (u w : Nat) (x : BitVec w) :
    (x.zeroExtend u).zeroExtend u = x.zeroExtend u := by
  bv_multi_width (config := { niter := 0 })

#exit

/--
info: fsm circuit size: 258
---
info: FSM state space size: 8589934592
---
error: safety failure at iteration 0 for predicate MultiWidth.Nondep.Predicate.binRel
  (MultiWidth.BinaryRelationKind.eq)
  (MultiWidth.Nondep.Term.zext
    (MultiWidth.Nondep.Term.zext (MultiWidth.Nondep.Term.var 0 { toNat := 2 }) { toNat := 1 })
    { toNat := 0 })
  (MultiWidth.Nondep.Term.zext (MultiWidth.Nondep.Term.var 0 { toNat := 2 }) { toNat := 0 })
-/
#guard_msgs in theorem eg4 (u v w : Nat) (x : BitVec w) :
    (x.zeroExtend u).zeroExtend v = x.zeroExtend v := by
  bv_multi_width
