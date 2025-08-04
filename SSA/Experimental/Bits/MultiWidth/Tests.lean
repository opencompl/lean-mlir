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
info: declared (ReflectVerif.BvDecide.KInductionCircuits.mkN
        (mkPredicateFSMDep
            (Predicate.binRel BinaryRelationKind.eq (MultiWidth.Term.var ⟨0, ⋯⟩) (MultiWidth.Term.var ⟨0, ⋯⟩))).toFsm
        10).mkSafetyCircuit.verifyCircuit
  "193 65 0 1 2 0\n194 68 0 1 3 0\n195 12 0 194 5 0\n196 67 0 194 6 0\n197 2 0 196 8 0\n198 66 0 196 9 0\n199 3 0 198 11 0\n200 6 0 198 12 0\n201 30 0 193 14 0\n202 15 0 201 116 0\n203 -13 0 202 156 0\n204 -11 0 203 195 164 0\n205 -10 0 204 197 169 0\n206 8 9 0 205 172 0\n207 7 -4 0 200 181 0\n208 5 -4 0 199 186 0\n209 -5 0 176 185 206 207 174 0\n210 -9 0 209 173 0\n211 -4 0 209 208 0\n212 8 0 210 206 0\n213 -7 0 211 179 0\n214 0 212 213 177 0\n" as eg1.safetyCert.lhs_1_1
---
info: made safety cert proof: Lean.ofReduceBool eg1.safetyCert.lhs_1_1 true (Eq.refl true)
---
info: made verifyCircuit expr: {verifyCircuitMkIndHypCircuitExpr}
---
info: declared (ReflectVerif.BvDecide.KInductionCircuits.mkN
        (mkPredicateFSMDep
            (Predicate.binRel BinaryRelationKind.eq (MultiWidth.Term.var ⟨0, ⋯⟩) (MultiWidth.Term.var ⟨0, ⋯⟩))).toFsm
        10).mkIndHypCycleBreaking.verifyCircuit
  "187 65 0 1 2 0\n188 66 0 1 3 0\n189 -12 0 188 5 0\n190 26 0 188 6 0\n191 30 0 187 8 0\n192 64 0 187 9 0\n193 45 0 192 11 0\n194 37 0 193 65 0\n195 44 0 193 66 0\n196 40 0 195 68 0\n197 43 0 195 69 0\n198 -41 0 197 71 0\n199 -42 0 197 72 0\n200 -5 17 0 199 76 0\n201 5 -17 0 198 79 0\n202 -38 0 196 80 0\n203 -39 0 196 81 0\n204 -7 20 0 203 85 0\n205 7 -20 0 202 88 0\n206 -36 0 194 90 0\n207 16 -34 0 206 94 0\n208 15 0 191 110 0\n209 29 0 191 111 0\n210 -27 0 209 113 0\n211 -25 0 210 190 121 0\n212 -16 -24 0 211 126 0\n213 -14 0 208 151 0\n214 11 0 213 189 155 0\n215 2 0 214 161 0\n216 10 0 214 162 0\n217 -8 0 216 164 0\n218 -9 0 216 165 0\n219 -5 7 0 218 169 0\n220 5 -7 0 217 172 0\n221 -19 0 215 133 141 142 201 219 204 109 138 101 131 100 129 207 212 0\n222 -23 0 221 130 0\n223 -21 0 221 136 137 143 205 200 220 0\n224 -22 0 223 134 0\n225 24 0 224 222 129 0\n226 -16 0 225 212 0\n227 -34 0 226 207 0\n228 33 0 227 215 100 0\n229 -31 0 228 101 0\n230 -32 0 228 102 0\n231 -7 0 229 220 109 0\n232 -5 0 231 219 0\n233 0 231 232 230 106 0\n" as eg1.indCert.lhs_1_3
---
info: made induction cert = true proof...
---
info: made final appM: ⏎
  Predicate.toProp_of_KInductionCircuits
    ((Term.Ctx.empty 1).cons (WidthExpr.var ⟨0, of_decide_eq_true (id (Eq.refl true))⟩))
    (Predicate.binRel BinaryRelationKind.eq (MultiWidth.Term.var ⟨0, of_decide_eq_true (id (Eq.refl true))⟩)
      (MultiWidth.Term.var ⟨0, of_decide_eq_true (id (Eq.refl true))⟩))
    (mkPredicateFSMDep
      (Predicate.binRel BinaryRelationKind.eq (MultiWidth.Term.var ⟨0, of_decide_eq_true (id (Eq.refl true))⟩)
        (MultiWidth.Term.var ⟨0, of_decide_eq_true (id (Eq.refl true))⟩)))
    10
    (ReflectVerif.BvDecide.KInductionCircuits.mkN
      (mkPredicateFSMDep
          (Predicate.binRel BinaryRelationKind.eq (MultiWidth.Term.var ⟨0, of_decide_eq_true (id (Eq.refl true))⟩)
            (MultiWidth.Term.var ⟨0, of_decide_eq_true (id (Eq.refl true))⟩))).toFsm
      10)
    (ReflectVerif.BvDecide.KInductionCircuits.IsLawful_mkN
      (mkPredicateFSMDep
          (Predicate.binRel BinaryRelationKind.eq (MultiWidth.Term.var ⟨0, of_decide_eq_true (id (Eq.refl true))⟩)
            (MultiWidth.Term.var ⟨0, of_decide_eq_true (id (Eq.refl true))⟩))).toFsm
      10)
    "193 65 0 1 2 0\n194 68 0 1 3 0\n195 12 0 194 5 0\n196 67 0 194 6 0\n197 2 0 196 8 0\n198 66 0 196 9 0\n199 3 0 198 11 0\n200 6 0 198 12 0\n201 30 0 193 14 0\n202 15 0 201 116 0\n203 -13 0 202 156 0\n204 -11 0 203 195 164 0\n205 -10 0 204 197 169 0\n206 8 9 0 205 172 0\n207 7 -4 0 200 181 0\n208 5 -4 0 199 186 0\n209 -5 0 176 185 206 207 174 0\n210 -9 0 209 173 0\n211 -4 0 209 208 0\n212 8 0 210 206 0\n213 -7 0 211 179 0\n214 0 212 213 177 0\n"
    (Lean.ofReduceBool eg1.safetyCert.lhs_1_1 true (Eq.refl true))
    "187 65 0 1 2 0\n188 66 0 1 3 0\n189 -12 0 188 5 0\n190 26 0 188 6 0\n191 30 0 187 8 0\n192 64 0 187 9 0\n193 45 0 192 11 0\n194 37 0 193 65 0\n195 44 0 193 66 0\n196 40 0 195 68 0\n197 43 0 195 69 0\n198 -41 0 197 71 0\n199 -42 0 197 72 0\n200 -5 17 0 199 76 0\n201 5 -17 0 198 79 0\n202 -38 0 196 80 0\n203 -39 0 196 81 0\n204 -7 20 0 203 85 0\n205 7 -20 0 202 88 0\n206 -36 0 194 90 0\n207 16 -34 0 206 94 0\n208 15 0 191 110 0\n209 29 0 191 111 0\n210 -27 0 209 113 0\n211 -25 0 210 190 121 0\n212 -16 -24 0 211 126 0\n213 -14 0 208 151 0\n214 11 0 213 189 155 0\n215 2 0 214 161 0\n216 10 0 214 162 0\n217 -8 0 216 164 0\n218 -9 0 216 165 0\n219 -5 7 0 218 169 0\n220 5 -7 0 217 172 0\n221 -19 0 215 133 141 142 201 219 204 109 138 101 131 100 129 207 212 0\n222 -23 0 221 130 0\n223 -21 0 221 136 137 143 205 200 220 0\n224 -22 0 223 134 0\n225 24 0 224 222 129 0\n226 -16 0 225 212 0\n227 -34 0 226 207 0\n228 33 0 227 215 100 0\n229 -31 0 228 101 0\n230 -32 0 228 102 0\n231 -7 0 229 220 109 0\n232 -5 0 231 219 0\n233 0 231 232 230 106 0\n"
    (Lean.ofReduceBool eg1.indCert.lhs_1_3 true (Eq.refl true)) (WidthExpr.Env.empty.cons w)
    ((Term.Ctx.Env.empty (WidthExpr.Env.empty.cons w) (Term.Ctx.empty 1)).cons
      (WidthExpr.var ⟨0, of_decide_eq_true (id (Eq.refl true))⟩) x
      (Eq.refl ((WidthExpr.var ⟨0, of_decide_eq_true (id (Eq.refl true))⟩).toNat (WidthExpr.Env.empty.cons w))))
---
error: (kernel) application type mismatch
  Lean.ofReduceBool eg1.safetyCert.lhs_1_1 true (Eq.refl true)
argument has type
  true = true
but function has type
  Lean.reduceBool eg1.safetyCert.lhs_1_1 = true → eg1.safetyCert.lhs_1_1 = true
-/
theorem eg1 (w : Nat) (x : BitVec w) : x = x := by
  bv_multi_width

#print eg1.safetyCert.lhs_1_1

#eval Lean.reduceBool eg1.safetyCert.lhs_1_1

#print eg1.indCert.lhs_1_3
#eval Lean.reduceBool eg1.indCert.lhs_1_3


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


/--
info: collected predicate: MultiWidth.Nondep.Predicate.binRel
  (MultiWidth.BinaryRelationKind.eq)
  (MultiWidth.Nondep.Term.zext
    (MultiWidth.Nondep.Term.zext (MultiWidth.Nondep.Term.var 0 { toNat := 2 }) { toNat := 1 })
    { toNat := 0 })
  (MultiWidth.Nondep.Term.zext (MultiWidth.Nondep.Term.var 0 { toNat := 2 }) { toNat := 0 })
---
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
  bv_multi_width (config := { niter := 0})
