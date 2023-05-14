/-
## `arith` dialect


This file formalises part of the `arith` dialect. The goal is to showcase
operations on multiple types (with overloading) and basic reasoning. `arith`
does not have new datatypes, but it supports operations on tensors and vectors,
which are some of the most complex builtin types.

TODO: This file uses shorter operation names (without "arith.") to work around
      a normalization performance issue that is affected by the string length
See https://leanprover.zulipchat.com/#narrow/stream/270676-lean4/topic/unfold.20essentially.20loops
-/

import MLIR.Semantics.Fitree
import MLIR.Semantics.Semantics
import MLIR.Semantics.SSAEnv
import MLIR.Semantics.UB
import MLIR.Dialects.BuiltinModel
import MLIR.Util.Metagen
import MLIR.AST
import MLIR.EDSL
import MLIR.Semantics.Rewriting
open MLIR.AST

/-
### Dialect extensions

`arith` has no extended types or attributes.
-/

instance arith: Dialect Void Void (fun _ => Unit) where
  name := "arith"
  iα := inferInstance
  iε := inferInstance

/-
### Dialect operations

In order to support type overloads while keeping reasonably-strong typing on
operands and disallowing incorrect types in the operation arguments, we define
scalar, tensor, and vector overloads of each operation.
-/

inductive ComparisonPred :=
  | eq  | ne
  | slt | sle | sgt | sge
  | ult | ule | ugt | uge

def ComparisonPred.ofInt: Int → Option ComparisonPred
  | 0 => some eq
  | 1 => some ne
  | 2 => some slt
  | 3 => some sle
  | 4 => some sgt
  | 5 => some sge
  | 6 => some ult
  | 7 => some ule
  | 8 => some ugt
  | 9 => some uge
  | _ => none

-- inductive ArithE: Type → Type :=
--   | CmpI: (sz: Nat) → (pred: ComparisonPred) → (lhs rhs: FinInt sz) →
--           ArithE (FinInt 1)
--   | CmpIndex: (pred: ComparisonPred) → (lhs rhs: Int) →
--           ArithE (FinInt 1)
--   | AddI: (sz: Nat) → (lhs rhs: FinInt sz) →
--           ArithE (FinInt sz)
--   | AddT: (sz: Nat) → (D: DimList) → (lhs rhs: RankedTensor D (.int sgn sz)) →
--           ArithE (RankedTensor D (.int sgn sz))
--   | AddV: (sz: Nat) → (sc fx: List Nat) →
--           (lhs rhs: Vector sc fx (.int sgn sz)) →
--           ArithE (Vector sc fx (.int sgn sz))
--   | SubI: (sz: Nat) → (lhs rhs: FinInt sz) →
--           ArithE (FinInt sz)
--   | NegI: (sz: Nat) → (op: FinInt sz) →
--           ArithE (FinInt sz)
--   | AndI: (sz: Nat) → (lhs rhs: FinInt sz) →
--           ArithE (FinInt sz)
--   | OrI: (sz: Nat) → (lhs rhs: FinInt sz) →
--           ArithE (FinInt sz)
--   | XorI: (sz: Nat) → (lhs rhs: FinInt sz) →
--           ArithE (FinInt sz)
--   | Zext: (sz₁: Nat) → (sz₂: Nat) → (FinInt sz₁) →
--           ArithE (FinInt sz₂)
--   | Select: (sz: Nat) → (b: FinInt 1) → (lhs rhs: FinInt sz) →
--           ArithE (FinInt sz)

def unary_semantics_op (op: IOp Δ)
      (ctor: {sz: Nat} → FinInt sz → FinInt sz): OpM Δ (TypedArgs Δ) :=
  match op with
  | IOp.mk _ _ [⟨.int sgn sz, arg⟩]  [] _ => do
      let r := ctor arg
      return [⟨.int sgn sz, r⟩]
  | IOp.mk name .. =>  OpM.Unhandled s!"unary_semantics_op: unhandled {name}"

def binary_semantics_op {Δ: Dialect α' σ' ε'}
      (name: String) (args: List ((τ: MLIRType Δ) × τ.eval))
      (ctor: {sz: Nat} → FinInt sz → FinInt sz → FinInt sz): OpM Δ (TypedArgs Δ) :=
  match args with
  | [⟨.int sgn sz, lhs⟩, ⟨.int sgn' sz', rhs⟩] =>
      if EQ: sgn = sgn' /\ sz = sz' then  do
        let r := ctor lhs (EQ.2 ▸ rhs)
        return [⟨.int sgn sz, r⟩]
      else OpM.Unhandled s!"binary_semantics_op: sgn != sgn' || sz != sz': {name}"
  | _ => OpM.Unhandled s!"binary_semantics_op: unhandled {name}"

def cmpIndex (pred : ComparisonPred) (lhs rhs: Int): FinInt 1 :=
      let b: Bool :=
        match pred with
        | .eq  => lhs = rhs
        | .ne  => lhs != rhs
        | .slt => lhs <  rhs
        | .sle => lhs <= rhs
        | .sgt => lhs >  rhs
        | .sge => lhs >= rhs
        | .ult => lhs <  rhs
        | .ule => lhs <= rhs
        | .ugt => lhs >  rhs
        | .uge => lhs >= rhs
      FinInt.ofInt 1 (if b then 1 else 0)


def cmpI (sz : ℕ) (pred : ComparisonPred) (lhs: FinInt sz) (rhs: FinInt sz): FinInt 1 :=
      let b: Bool :=
        match pred with
        | .eq  => lhs = rhs
        | .ne  => lhs != rhs
        | .slt => lhs.toSint <  rhs.toSint
        | .sle => lhs.toSint <= rhs.toSint
        | .sgt => lhs.toSint >  rhs.toSint
        | .sge => lhs.toSint >= rhs.toSint
        | .ult => lhs.toUint <  rhs.toUint
        | .ule => lhs.toUint <= rhs.toUint
        | .ugt => lhs.toUint >  rhs.toUint
        | .uge => lhs.toUint >= rhs.toUint
      FinInt.ofInt 1 (if b then 1 else 0)

def arith_semantics_op (o: IOp Δ): OpM Δ (TypedArgs Δ) :=
  match o with
  | IOp.mk "arith.constant" [τ₁] [] [] attrs =>
      match AttrDict.find attrs "value" with
      | some (.int value τ₂) =>
          if τ₁ = τ₂ then
            match τ₂ with
            | .int sgn sz => do
                -- TODO: Check range of constants
                let v := FinInt.ofInt sz value
                return [⟨.int sgn sz, v⟩]
            | .index => do
                return [⟨.index, value⟩]
            | _ => OpM.Error s! "arith.constant: unknown type {τ₂}"
          else OpM.Error "arith.constant: retty not equal to value ty"
      | some _
      | nofne => OpM.Error "arith.constant: cannot find value"

  | IOp.mk "arith.cmpi" _ [ ⟨(.int sgn sz), lhs⟩, ⟨(.int sgn' sz'), rhs⟩ ] []
    attrs =>
      if EQ: sgn = sgn' /\ sz = sz' then
            match attrs.find "predicate" with
            | some (.int n (.int .Signless 64)) =>
                match (ComparisonPred.ofInt n) with
                | some pred => do
                  let r := cmpI sz pred lhs (EQ.2 ▸ rhs)
                  return [⟨.i1, r⟩]
                | none => OpM.Unhandled "arith.cmpi"
            | some _
            | none => OpM.Unhandled "arith.cmpi"
      else OpM.Unhandled "arith.cmpi"

  | IOp.mk "arith.cmpi" _ [ ⟨.index, lhs⟩, ⟨.index, rhs⟩ ] [] attrs =>
      match attrs.find "predicate" with
      | some (.int n (.int .Signless 64)) =>
          match (ComparisonPred.ofInt n) with
          | some pred => do
            let r := cmpIndex pred lhs rhs
            return [⟨.i1, r⟩]
          | none => OpM.Unhandled "arith.cmpi"
      | some _
      | none => OpM.Unhandled "arith.cmpi"

  | IOp.mk "arith.zext" [.int sgn₂ sz₂] [⟨.int sgn₁ sz₁, value⟩]  [] _ =>
      if sgn₁ = sgn₂ then do
        let r :=  FinInt.zext sz₂ value
        return [⟨.int sgn₂ sz₂, r⟩]
      else OpM.Unhandled "arith.zext"

  | IOp.mk "arith.select" _ [⟨.i1, b⟩, ⟨.int sgn sz, lhs⟩, ⟨.int sgn' sz', rhs⟩]  [] _ =>
      if EQ: sgn = sgn' /\ sz = sz' then  do
        let r := if b.toUint = 1 then lhs else (EQ.2 ▸ rhs)
        return [⟨.int sgn sz, r⟩]
      else OpM.Unhandled "arith.select"
  | IOp.mk "arith.negi" .. =>
      unary_semantics_op o FinInt.neg
  | IOp.mk name _ args _ _  =>
      if name = "arith.addi" then
        binary_semantics_op name args FinInt.add
      else if name = "arith.subi" then
        binary_semantics_op name args FinInt.sub
      else if name = "arith.andi" then
        binary_semantics_op name args FinInt.and
      else if name = "arith.ori" then
        binary_semantics_op name args FinInt.or
      else if name = "arith.xori" then
        binary_semantics_op name args FinInt.xor
      else
        OpM.Unhandled (s!"generic_check {name}")

instance: Semantics arith where
  semantics_op := arith_semantics_op


/-
### Semantics of individual operations

In principle we would compute the semantics of entire programs simply by
unfolding the definitions. But simp and dsimp have many problems which makes
this extremely slow, buggy, or infeasible even for programs with only a couple
of operations. We work around this issue by precomputing the semantics of
individual operations and then substituting them as needed.
-/

private abbrev ops.constant (output: SSAVal) (value: Int):
    Op arith :=
  Op.mk "arith.constant" [⟨output, .i32⟩] [] .regionsnil (.mk [.mk "value" (.int value .i32)])

private abbrev ops.negi (output input: SSAVal): Op arith :=
  .mk "arith.negi" [⟨output, .i32⟩] [⟨input, .i32⟩] .regionsnil (.mk [])

private abbrev ops.zext (sz₁ sz₂: Nat) (output input: SSAVal): Op arith :=
  .mk "arith.zext" [⟨output, .int .Signless sz₂⟩] [⟨input, .int .Signless sz₁⟩] .regionsnil (.mk [])

private abbrev ops.select (output cond t f: SSAVal): Op arith :=
  .mk "arith.select" [⟨output, .i32⟩] [⟨cond, .i1⟩, ⟨t, .i32⟩, ⟨f, .i32⟩] .regionsnil (.mk [])

private abbrev ops._binary (name: String) (output lhs rhs: SSAVal):
    Op arith :=
  .mk name [⟨output, .i32⟩] [⟨lhs, .i32⟩, ⟨rhs, .i32⟩] .regionsnil (.mk [])

private abbrev ops.addi := ops._binary "arith.addi"
private abbrev ops.subi := ops._binary "arith.subi"
private abbrev ops.andi := ops._binary "arith.andi"
private abbrev ops.ori  := ops._binary "arith.ori"
private abbrev ops.xori := ops._binary "arith.xori"

/-

The great Commenting
====================

Everything below assumes we have a handle + semantics, which makes
things quite complex. Now that we have removed the handle, the hope
is that we can recover the semantics proofs in a much easier fashion.


private theorem ops.constant.sem output value:
    denoteOp arith (ops.constant output value) =
  Fitree.Vis (E := SSAEnvE arith +' Semantics.E arith +' UBE)
    (Sum.inl <| SSAEnvE.Set .i32 output (FinInt.ofInt 32 value)) fun _ =>
  Fitree.ret (TypedArgs.Next (δ := arith)
    ⟨.i32, FinInt.ofInt 32 value⟩) := by
  simp [ops.constant, denoteOp, denoteOpBase, Semantics.semantics_op]
  simp_itree
  simp [arith_semantics_op]
  simp [List.map]

private theorem ops.negi.sem output input:
    denoteOp arith (ops.negi output input) =
  Fitree.Vis (E := SSAEnvE arith +' Semantics.E arith +' UBE)
    (Sum.inl <| SSAEnvE.Get .i32 input) fun r =>
  Fitree.Vis (Sum.inr <| Sum.inl <| ArithE.NegI 32 r) fun r =>
  Fitree.Vis (Sum.inl <| SSAEnvE.Set .i32 output r) fun _ =>
  Fitree.ret (TypedArgs.Next ⟨.i32, r⟩) := by
  simp [ops.negi, denoteOp, denoteOpBase, Semantics.semantics_op]
  simp_itree

private theorem ops.zext.sem sz₁ sz₂ output input:
    denoteOp arith (ops.zext sz₁ sz₂ output input) =
  Fitree.Vis (E := SSAEnvE arith +' Semantics.E arith +' UBE)
    (Sum.inl <| @SSAEnvE.Get _ _ _ _ (.int .Signless sz₁) (instInhabitedEval _) input) fun r =>
  Fitree.Vis (Sum.inr <| Sum.inl <| ArithE.Zext sz₁ sz₂ r) fun r =>
  Fitree.Vis (Sum.inl <| SSAEnvE.Set (.int .Signless sz₂) output r) fun _ =>
  Fitree.ret (TypedArgs.Next ⟨.int .Signless sz₂, r⟩) := by
  simp [ops.zext, denoteOp, denoteOpBase, Semantics.semantics_op]
  simp_itree


private theorem ops.select.sem output cond t f:
    denoteOp arith (ops.select output cond t f) =
  Fitree.Vis (E := SSAEnvE arith +' UBE)
    (Sum.inl <| SSAEnvE.Get .i1 cond) fun cond =>
  Fitree.Vis (E := SSAEnvE arith +' UBE)
    (Sum.inl <| SSAEnvE.Get .i32 t) fun t =>
  Fitree.Vis (E := SSAEnvE arith +' UBE)
    (Sum.inl <| SSAEnvE.Get .i32 f) fun f =>
  Fitree.Vis (Sum.inr <| Sum.inl <| ArithE.Select 32 cond t f) fun r =>
  Fitree.Vis (Sum.inl <| SSAEnvE.Set .i32 output r) fun _ =>
  Fitree.ret (TypedArgs.Next ⟨.i32, r⟩) := by
  simp [ops.select, denoteOp, denoteOpBase, Semantics.semantics_op]
  simp_itree

private theorem ops._binary.sem name ctor output lhs rhs:
    (forall (n m: FinInt 32),
      arith_semantics_op (Δ := arith)
        (IOp.mk name [.i32] [⟨.i32, n⟩, ⟨.i32, m⟩] [] 0 (.mk []))  =
      binary_semantics_op name [⟨.i32, n⟩, ⟨.i32, m⟩] ctor) →
    denoteOp arith (ops._binary name output lhs rhs) =
  Fitree.Vis (E := SSAEnvE arith +' Semantics.E arith +' UBE)
    (Sum.inl <| SSAEnvE.Get .i32 lhs) fun lhs =>
  Fitree.Vis (Sum.inl <| SSAEnvE.Get .i32 rhs) fun rhs =>
  Fitree.Vis (Sum.inr <| Sum.inl <| ctor 32 lhs rhs) fun r =>
  Fitree.Vis (Sum.inl <| SSAEnvE.Set .i32 output r) fun _ =>
  Fitree.ret (TypedArgs.Next ⟨.i32, r⟩) := by
  intro h
  simp [denoteOp, denoteOpBase, Semantics.semantics_op]
  simp [List.zip, List.zipWith, List.mapM, List.map]
  simp [h];
  sorry -- the proof broke when updating to the new Lean version.

private abbrev ops.addi.sem output lhs rhs :=
  ops._binary.sem "arith.addi" ArithE.AddI output lhs rhs (fun _ _ => rfl)
private abbrev ops.subi.sem output lhs rhs :=
  ops._binary.sem "arith.subi" ArithE.SubI output lhs rhs (fun _ _ => rfl)
private abbrev ops.andi.sem output lhs rhs :=
  ops._binary.sem "arith.andi" ArithE.AndI output lhs rhs (fun _ _ => rfl)
private abbrev ops.ori.sem output lhs rhs :=
  ops._binary.sem "arith.ori" ArithE.OrI output lhs rhs (fun _ _ => rfl)
private abbrev ops.xori.sem output lhs rhs :=
  ops._binary.sem "arith.xori" ArithE.XorI output lhs rhs (fun _ _ => rfl)

/-
### Basic examples
-/

private def cst1: BasicBlock arith := [mlir_bb|
  ^bb:
    %true = "arith.constant" () {value = 1: i1}: () -> i1
    %false = "arith.constant" () {value = 0: i1}: () -> i1
    %r1 = "arith.constant" () {value = 25: i32}: () -> i32
    %r2 = "arith.constant" () {value = 17: i32}: () -> i32
    %r = "arith.addi" (%r1, %r2): (i32, i32) -> i32
    %s = "arith.subi" (%r2, %r): (i32, i32) -> i32
    %b1 = "arith.cmpi" (%r, %r1) {predicate = 5 /- sge -/}: (i32, i32) -> i1
    %b2 = "arith.cmpi" (%r2, %r) {predicate = 8 /- ugt -/}: (i32, i32) -> i1
]

#eval run (Δ := arith) ⟦cst1⟧ (SSAEnv.empty (δ := arith))
-/

/-
### Rewriting heorems
-/

/- Commutativity of addition -/

namespace th1
def LHS: Op arith := [mlir_op|
  %r = "arith.addi"(%n, %m): (i32, i32) -> i32
]
def RHS: Op arith := [mlir_op|
  %r = "arith.addi"(%m, %n): (i32, i32) -> i32
]

theorem equivalent (n m: FinInt 32):
    run ⟦LHS⟧ (SSAEnv.One [ ("n", ⟨.i32, n⟩), ("m", ⟨.i32, m⟩) ]) =
    run ⟦RHS⟧ (SSAEnv.One [ ("n", ⟨.i32, n⟩), ("m", ⟨.i32, m⟩) ]) := by
  simp [LHS, RHS,
        run, StateT.run,
        OpRegion.denoteTop, bind, List.mapM, StateT.bind, denoteOpArgs, List.mapM,
        List.mapM.loop, Except.bind, TopM.get, StateT.get, pure, Except.pure,
        StateT.pure, OpM.toTopM, TopM.set, StateT.set, MLIRType.eval,
        SSAEnv.get, SSAEnv.getT, cast];
  simp [FinInt.add_comm']

def th1 : PeepholeRewriteOp arith :=
{
  findRoot := MTerm.buildOp "arith.addi"
        [MTerm.buildOperand "n" .i32, MTerm.buildOperand "m" .i32]
        [MTerm.buildOperand "r" .i32]
  , findSubtree := []
  , replaceSubtree := [MTerm.buildOp "arith.addi"
        [MTerm.buildOperand "m" .i32, MTerm.buildOperand "n" .i32]
        [MTerm.buildOperand "r" .i32]]
  , wellformed := by {
     intros toplevelProg _prog matchCtx replacedProg matchctx domctx
     intros MATCH FIND SUBST DOMFIND
     simp [List.append] at *;
     sorry
  }
  , correct := by {
     intros toplevelProg _prog matchCtx replacedProg matchctx domctx
     intros MATCH FIND SUBST DOMFIND
     simp [List.append] at *;
     simp [MTerm.concretizeProg, List.mapM, List.mapM.loop] at FIND;
     simp [MTerm.concretizeOp, MTerm.buildOp, MTerm.concretizeOperands, MTerm.concretizeOperand, MTerm.buildOperand,
        MTerm.concretizeVariable, List.mapM, List.mapM.loop] at FIND;
      -- cases on the MTerm.getVariable and show that we must have such a variable.
      -- then generalize on this.
      sorry

  }
}

end th1

/- LLVM InstCombine: `C-(X+C2) --> (C-C2)-X`
   https://github.com/llvm/llvm-project/blob/291e3a85658e264a2918298e804972bd68681af8/llvm/lib/Transforms/InstCombine/InstCombineAddSub.cpp#L1794 -/

theorem FinInt.sub_add_dist: forall (C X C2: FinInt sz),
    C - (X + C2) = (C - C2) - X := by
  intros C X C2
  apply eq_of_toUint_cong2
  simp [cong2, FinInt.sub_toUint, FinInt.add_toUint]
  apply FinInt.mod2_fequal
  simp [Int.sub_add_dist, Int.sub_assoc]

/-

namespace th2
def LHS: BasicBlock arith := [mlir_bb|
  ^bb:
    %t = "arith.addi"(%X, %C2): (i32, i32) -> i32
    %r = "arith.subi"(%C, %t): (i32, i32) -> i32
]
def RHS: BasicBlock arith := [mlir_bb|
  ^bb:
    %t = "arith.subi"(%C, %C2): (i32, i32) -> i32
    %r = "arith.subi"(%t, %X): (i32, i32) -> i32
]
def INPUT (C X C2: FinInt 32): SSAEnv arith := SSAEnv.One [
  ("C", ⟨.i32, C⟩), ("X", ⟨.i32, X⟩), ("C2", ⟨.i32, C2⟩)
]

theorem equivalent (C X C2: FinInt 32):
    semanticPostCondition₂
      (run ⟦LHS⟧ (INPUT C X C2))
      (run ⟦RHS⟧ (INPUT C X C2))
    fun _ env₁ _ env₂ =>
      env₁.get "r" .i32 = env₂.get "r" .i32 := by
  simp [LHS, RHS, INPUT]
  simp [run, denoteBB, denoteOps, denoteOp, denoteOpBase]; simp_itree
  apply FinInt.sub_add_dist

/-
-- This proof works, but triggers a Lean performance issue and basically loops.
-- During testing, the trigger was unfolding `denoteTypedArgs`, though the
-- culprit is specifically the combination of conditions that led to reducing
-- WF-induction proofs within the terms. Changing `denoteTypedArgs` to a simple
-- event `SSAEnvE.SetMultiple` did not eliminate the problem.
theorem equivalent2 (C X C2: FinInt 32):
    (run ⟦LHS⟧ (INPUT C X C2) |>.snd.get "r" .i32) =
    (run ⟦RHS⟧ (INPUT C X C2) |>.snd.get "r" .i32) := by
  simp [LHS, RHS, INPUT, run, Semantics.handle]
  simp [denoteBB, denoteBBStmts]
  rw [ops.addi.sem]
  rw [ops.subi.sem]
  rw [ops.subi.sem]
  rw [ops.subi.sem]
  simp [interpUB'_bind]
  simp [interpSSA'_bind]
  repeat conv in SSAEnvE.handle _ _ => simp [SSAEnvE.handle]
  simp [Fitree.interp_bind]
  repeat conv in ArithE.handle _ _ => simp [ArithE.handle]
  simp [cast_eq]
  repeat conv in SSAEnvE.handle _ _ => simp [SSAEnvE.handle]
  simp [cast_eq]
  apply FinInt.sub_add_dist
-/
end th2

/- LLVM InstCombine: `~X + C --> (C-1) - X`
   https://github.com/llvm/llvm-project/blob/291e3a85658e264a2918298e804972bd68681af8/llvm/lib/Transforms/InstCombine/InstCombineAddSub.cpp#L882 -/

theorem FinInt.comp_add: sz > 0 → forall (X C: FinInt sz),
    (X ^^^ -1) + C = (C - 1) - X := by
  intros h_sz X C
  simp [←FinInt.comp_eq_xor_minusOne]
  apply eq_of_toUint_cong2
  simp [cong2, FinInt.add_toUint, FinInt.comp_toUint, FinInt.sub_toUint]
  simp [toUint_ofNat]
  have h: Int.ofNat 1 = 1 := by decide
  simp [h, mod2_idem ⟨by decide, Int.one_lt_two_pow h_sz⟩]
  simp [Int.sub_eq_add_neg, Int.add_assoc, FinInt.mod2_add_left]
  rw [←@Int.add_assoc _ (-1) _, @Int.add_comm _ (-1)]
  simp [@Int.add_comm (-X.toUint), Int.add_assoc]

namespace th3
def LHS: BasicBlock arith := [mlir_bb|
  ^bb:
    %_1 = "arith.constant"() {value = 1: i32}: () -> i32
    %_2 = "arith.negi"(%_1): (i32) -> i32
    %_3 = "arith.xori"(%X, %_2): (i32, i32) -> i32
    %r = "arith.addi"(%_3, %C): (i32, i32) -> i32
]
def RHS: BasicBlock arith := [mlir_bb|
  ^bb:
    %o = "arith.constant"() {value = 1: i32}: () -> i32
    %t = "arith.subi"(%C, %o): (i32, i32) -> i32
    %r = "arith.subi"(%t, %X): (i32, i32) -> i32
]
def INPUT (C X: FinInt 32): SSAEnv arith := SSAEnv.One [
    ("C", ⟨.i32, C⟩), ("X", ⟨.i32, X⟩)
]

theorem equivalent (C X: FinInt 32):
  semanticPostCondition₂
    (run ⟦LHS⟧ (INPUT C X))
    (run ⟦RHS⟧ (INPUT C X))
  fun _ env₁ _ env₂ =>
    env₁.get "r" .i32 = env₂.get "r" .i32 := by
  -- TODO: If we could simplify `denoteTypedArgs` we could save a lot of work
  -- TODO: here. But it triggers the WF-induction bug, so we instead we unfold
  -- TODO: the SSA stuff later. Investigate.
  simp [INPUT, LHS, RHS, run, denoteOps, denoteBB]
  rw [ops.constant.sem]
  rw [ops.negi.sem]
  rw [ops.xori.sem]
  rw [ops.addi.sem]
  rw [ops.constant.sem]
  rw [ops.subi.sem]
  rw [ops.subi.sem]
  simp [interpSSA', Fitree.interpState, SSAEnvE.handle]; simp_itree
  apply FinInt.comp_add (by decide)
end th3

/- LLVM InstCombine: `-A + -B --> -(A + B)`
   https://github.com/llvm/llvm-project/blob/291e3a85658e264a2918298e804972bd68681af8/llvm/lib/Transforms/InstCombine/InstCombineAddSub.cpp#L1316 -/

theorem FinInt.neg_add_dist (A B: FinInt sz):
    -(A + B) = -A + -B := by
  apply eq_of_toUint_cong2
  simp [cong2, neg_toUint, add_toUint]
  apply mod2_fequal
  simp [Int.neg_add]

namespace th4
def LHS: BasicBlock arith := [mlir_bb|
  ^bb:
    %_1 = "arith.negi"(%A): (i32) -> i32
    %_2 = "arith.negi"(%B): (i32) -> i32
    %r = "arith.addi"(%_1, %_2): (i32, i32) -> i32
]
def RHS: BasicBlock arith := [mlir_bb|
  ^bb:
    %_1 = "arith.addi"(%A, %B): (i32, i32) -> i32
    %r = "arith.negi"(%_1): (i32) -> i32
]
def INPUT (A B: FinInt 32): SSAEnv arith := SSAEnv.One [
  ("A", ⟨.i32, A⟩), ("B", ⟨.i32, B⟩)
]

theorem equivalent (A B: FinInt 32):
  semanticPostCondition₂
    (run ⟦LHS⟧ (INPUT A B))
    (run ⟦RHS⟧ (INPUT A B))
  fun _ env₁ _ env₂ =>
    env₁.get "r" .i32 = env₂.get "r" .i32 := by
  simp [LHS, RHS, INPUT]
  simp [run, denoteBB, denoteOps, denoteOp, denoteOpBase]; simp_itree
  rw [FinInt.neg_add_dist]
end th4

/- LLVM InstCombine: `-(X - Y) --> (Y - X)`
   https://github.com/llvm/llvm-project/blob/291e3a85658e264a2918298e804972bd68681af8/llvm/lib/Transforms/InstCombine/InstCombineAddSub.cpp#L2290 -/

theorem FinInt.neg_sub_dist (X Y: FinInt sz):
    -(X - Y) = Y - X := by
  apply eq_of_toUint_cong2
  simp [cong2, neg_toUint, sub_toUint]
  apply mod2_fequal
  simp [Int.neg_sub]

namespace th5
def LHS: BasicBlock arith := [mlir_bb|
  ^bb:
    %_1 = "arith.subi"(%X, %Y): (i32, i32) -> i32
    %r = "arith.negi"(%_1): (i32) -> i32
]
def RHS: BasicBlock arith := [mlir_bb|
  ^bb:
    %r = "arith.subi"(%Y, %X): (i32, i32) -> i32
]
def INPUT (X Y: FinInt 32): SSAEnv arith := SSAEnv.One [
  ("X", ⟨.i32, X⟩), ("Y", ⟨.i32, Y⟩)
]

theorem equivalent (X Y: FinInt 32):
  semanticPostCondition₂
    (run ⟦LHS⟧ (INPUT X Y))
    (run ⟦RHS⟧ (INPUT X Y))
  fun _ env₁ _ env₂ =>
    env₁.get "r" .i32 = env₂.get "r" .i32 := by
  simp [LHS, RHS, INPUT]
  simp [run, denoteBB, denoteOps, denoteOp, denoteOpBase]; simp_itree
  apply FinInt.neg_sub_dist
end th5

/- LLVM InstCombine: `(A + 1) + ~B --> A - B`
   https://github.com/llvm/llvm-project/blob/291e3a85658e264a2918298e804972bd68681af8/llvm/lib/Transforms/InstCombine/InstCombineAddSub.cpp#L1331 -/

theorem FinInt.plus_one_plus_comp (A B: FinInt sz):
    (A + 1) + (B ^^^ -1) = A - B := by
  simp [←FinInt.comp_eq_xor_minusOne]
  apply eq_of_toUint_cong2
  simp [cong2, neg_toUint, add_toUint, sub_toUint, comp_toUint]
  simp [toUint_ofNat, (by decide: Int.ofNat 1 = 1)]
  -- Rearranging terms without the powerful Mathlib tactics is quite tedious
  simp [Int.add_comm _ (mod2 _ _), Int.add_assoc]
  simp [Int.sub_eq_add_neg]
  simp [←@Int.add_assoc A.toUint _, Int.add_comm A.toUint _]
  simp [←@Int.add_assoc 1 _, Int.add_comm 1 _]
  simp [Int.add_assoc, mod2_add_left]
  simp [Int.add_comm _ 1, ←Int.add_assoc _ 1 _, Int.add_assoc 1 _ _]
  simp [←Int.add_assoc, Int.add_right_neg, Int.zero_add]

namespace th6
def LHS: BasicBlock arith := [mlir_bb|
  ^bb:
    %_1 = "arith.constant"() {value = 1: i32}: () -> i32
    %_2 = "arith.addi"(%A, %_1): (i32, i32) -> i32
    %_3 = "arith.negi"(%_1): (i32) -> i32
    %_4 = "arith.xori"(%B, %_3): (i32, i32) -> i32
    %r = "arith.addi"(%_2, %_4): (i32, i32) -> i32
]
def RHS: BasicBlock arith := [mlir_bb|
  ^bb:
    %r = "arith.subi"(%A, %B): (i32, i32) -> i32
]
def INPUT (A B: FinInt 32): SSAEnv arith := SSAEnv.One [
  ("A", ⟨.i32, A⟩), ("B", ⟨.i32, B⟩)
]

theorem equivalent (A B: FinInt 32):
  semanticPostCondition₂
    (run ⟦LHS⟧ (INPUT A B))
    (run ⟦RHS⟧ (INPUT A B))
  fun _ env₁ _ env₂ =>
    env₁.get "r" .i32 = env₂.get "r" .i32 := by
  simp [INPUT, LHS, RHS, run, denoteOps, denoteBB]
  rw [ops.constant.sem]
  rw [ops.addi.sem]
  rw [ops.negi.sem]
  rw [ops.xori.sem]
  rw [ops.addi.sem]
  rw [ops.subi.sem]
  simp [interpSSA', Fitree.interpState, SSAEnvE.handle]; simp_itree
  apply FinInt.plus_one_plus_comp
end th6

/- LLVM InstCombine: `(~X) - (~Y) --> Y - X`
   https://github.com/llvm/llvm-project/blob/291e3a85658e264a2918298e804972bd68681af8/llvm/lib/Transforms/InstCombine/InstCombineAddSub.cpp#L1867 -/

theorem FinInt.comp_sub_comp (X Y: FinInt sz):
    (X ^^^ -1) - (Y ^^^ -1) = Y - X := by
  simp [←FinInt.comp_eq_xor_minusOne]
  apply eq_of_toUint_cong2
  simp [cong2, sub_toUint, comp_toUint]
  simp [Int.sub_eq_add_neg, Int.add_assoc, Int.neg_add, Int.neg_neg]
  simp [mod2_add_left]
  simp [←Int.add_assoc]
  rw [Int.add_comm _ (-_)]
  have h x: mod2 (-(2^sz) + x) sz = mod2 x sz := by sorry_arith
  simp [Int.add_assoc, h]
  rw [←Int.add_assoc (-1) _ _, Int.add_comm (-1) _]
  rw [Int.add_assoc _ (-1) _, ←Int.add_assoc _ 1 _]
  rw [Int.add_left_neg, Int.zero_add, Int.add_comm]

namespace th7
def LHS: BasicBlock arith := [mlir_bb|
  ^bb:
    %_1 = "arith.constant"() {value = 1: i32}: () -> i32
    %_2 = "arith.negi"(%_1): (i32) -> i32
    %_3 = "arith.xori"(%X, %_2): (i32, i32) -> i32
    %_4 = "arith.xori"(%Y, %_2): (i32, i32) -> i32
    %r = "arith.subi"(%_3, %_4): (i32, i32) -> i32
]
def RHS: BasicBlock arith := [mlir_bb|
  ^bb:
    %r = "arith.subi"(%Y, %X): (i32, i32) -> i32
]
def INPUT (X Y: FinInt 32): SSAEnv arith := SSAEnv.One [
  ("X", ⟨.i32, X⟩), ("Y", ⟨.i32, Y⟩)
]

theorem equivalent (X Y: FinInt 32):
  semanticPostCondition₂
    (run ⟦LHS⟧ (INPUT X Y))
    (run ⟦RHS⟧ (INPUT X Y))
  fun _ env₁ _ env₂ =>
    env₁.get "r" .i32 = env₂.get "r" .i32 := by
  simp [INPUT, LHS, RHS, run, denoteBB, denoteOps]
  rw [ops.constant.sem]
  rw [ops.negi.sem]
  rw [ops.xori.sem]
  rw [ops.xori.sem]
  rw [ops.subi.sem]
  rw [ops.subi.sem]
  simp [interpSSA', Fitree.interpState, SSAEnvE.handle]; simp_itree
  apply FinInt.comp_sub_comp
end th7

/- LLVM InstCombine: `(add (xor A, B) (and A, B)) --> (or A, B)`
   https://github.com/llvm/llvm-project/blob/291e3a85658e264a2918298e804972bd68681af8/llvm/lib/Transforms/InstCombine/InstCombineAddSub.cpp#L1411 -/

theorem FinInt.addfull_xor_and (A B: FinInt sz):
    addfull (A ^^^ B) (A &&& B) = .next false (A ||| B) := by
  induction sz with
  | zero => cases A; cases B; decide
  | succ sz ih =>
    match A, B with
    | next bA A', next bB B' =>
      simp [HXor.hXor, HAnd.hAnd, HOr.hOr, xor, and, or, logic2] at *
      simp [addfull, ih]
      cases bA <;> cases bB <;> decide;


theorem FinInt.add_xor_and (A B: FinInt sz):
    (A ^^^ B) + (A &&& B) = (A ||| B) := by
  simp [HAdd.hAdd, add, addfull_xor_and]

namespace th8
def LHS: BasicBlock arith := [mlir_bb|
  ^bb:
    %_1 = "arith.xori"(%A, %B): (i32, i32) -> i32
    %_2 = "arith.andi"(%A, %B): (i32, i32) -> i32
    %r = "arith.addi"(%_1, %_2): (i32, i32) -> i32
]
def RHS: BasicBlock arith := [mlir_bb|
  ^bb:
    %r = "arith.ori"(%A, %B): (i32, i32) -> i32
]
def INPUT (A B: FinInt 32): SSAEnv arith := SSAEnv.One [
  ("A", ⟨.i32, A⟩), ("B", ⟨.i32, B⟩)
]

theorem equivalent (A B: FinInt 32):
  semanticPostCondition₂
    (run ⟦LHS⟧ (INPUT A B))
    (run ⟦RHS⟧ (INPUT A B))
  fun _ env₁ _ env₂ =>
    env₁.get "r" .i32 = env₂.get "r" .i32 := by
  simp [LHS, RHS, INPUT]
  simp [run, denoteBB, denoteOps, denoteOp, denoteOpBase]; simp_itree
  apply FinInt.add_xor_and
end th8

/- LLVM InstCombine: `zext(bool) + C --> bool ? C + 1 : C`
   https://github.com/llvm/llvm-project/blob/291e3a85658e264a2918298e804972bd68681af8/llvm/lib/Transforms/InstCombine/InstCombineAddSub.cpp#L873 -/

theorem FinInt.add_bool_eq_select (B: FinInt 1) (C: FinInt 32):
    zext 32 B + C = select B (C + 1) C := by
  apply eq_of_toUint_cong2
  simp [cong2, add_toUint]
  rw [zext_toUint' (by decide)]
  cases bool_cases B <;> subst B <;> simp [select, Int.add_assoc, Int.zero_add]
  rw [add_toUint]
  simp [toUint, (by decide: 2^0 = 1), Int.add_zero]
  simp [Int.add_comm]

namespace th9
def LHS: BasicBlock arith := [mlir_bb|
  ^bb:
    %_1 = "arith.zext"(%B): (i1) -> i32
    %r = "arith.addi"(%_1, %C): (i32, i32) -> i32
]
def RHS: BasicBlock arith := [mlir_bb|
  ^bb:
    %_1 = "arith.constant"() {value = 1: i32}: () -> i32
    %_2 = "arith.addi"(%C, %_1): (i32, i32) -> i32
    %r = "arith.select"(%B, %_2, %C): (i1, i32, i32) -> i32
]
def INPUT (B: FinInt 1) (C: FinInt 32): SSAEnv arith := SSAEnv.One [
  ("B", ⟨.i1, B⟩), ("C", ⟨.i32, C⟩)
]

theorem equivalent (B: FinInt 1) (C: FinInt 32):
  semanticPostCondition₂
    (run ⟦LHS⟧ (INPUT B C))
    (run ⟦RHS⟧ (INPUT B C))
  fun _ env₁ _ env₂ =>
    env₁.get "r" .i32 = env₂.get "r" .i32 := by
  simp [LHS, RHS, INPUT]
  simp [run, denoteBB, denoteOps, denoteOp, denoteOpBase]; simp_itree
  simp [List.map, Semantics.semantics_op, arith_semantics_op]; simp_itree
  apply FinInt.add_bool_eq_select
end th9

/- LLVM InstCombine: `(A & ~B) & ~C --> A & ~(B | C)`
   https://github.com/llvm/llvm-project/blob/291e3a85658e264a2918298e804972bd68681af8/llvm/lib/Transforms/InstCombine/InstCombineAndOrXor.cpp#L1340 -/

theorem FinInt.and_not_and_not (A B C: FinInt sz):
    (A &&& (B ^^^ -1)) &&& (C ^^^ -1) = A &&& ((B ||| C) ^^^ -1) := by
  simp [←comp_eq_xor_minusOne]
  induction sz with
  | zero => cases A; cases B; cases C; decide
  | succ sz ih =>
      match A, B, C with
      | .next bA A', .next bB B', .next bC C' =>
          simp [HAnd.hAnd, HOr.hOr, and, or, comp] at *
          simp [logic2, ih]
          cases bA <;> cases bB <;> cases bC <;> decide

namespace th10
def LHS: BasicBlock arith := [mlir_bb|
  ^bb:
    %_1 = "arith.constant"() {value = 1: i32}: () -> i32
    %_2 = "arith.negi"(%_1): (i32) -> i32
    %_3 = "arith.xori"(%B, %_2): (i32, i32) -> i32
    %_4 = "arith.andi"(%A, %_3): (i32, i32) -> i32
    %_5 = "arith.xori"(%C, %_2): (i32, i32) -> i32
    %r = "arith.andi"(%_4, %_5): (i32, i32) -> i32
]
def RHS: BasicBlock arith := [mlir_bb|
  ^bb:
    %_1 = "arith.constant"() {value = 1: i32}: () -> i32
    %_2 = "arith.negi"(%_1): (i32) -> i32
    %_3 = "arith.ori"(%B, %C): (i32, i32) -> i32
    %_4 = "arith.xori"(%_3, %_2): (i32, i32) -> i32
    %r = "arith.andi"(%A, %_4): (i32, i32) -> i32
]
def INPUT (A B C: FinInt 32): SSAEnv arith := SSAEnv.One [
  ("A", ⟨.i32, A⟩), ("B", ⟨.i32, B⟩), ("C", ⟨.i32, C⟩)
]

theorem equivalent (A B C: FinInt 32):
  semanticPostCondition₂
    (run ⟦LHS⟧ (INPUT A B C))
    (run ⟦RHS⟧ (INPUT A B C))
  fun _ env₁ _ env₂ =>
    env₁.get "r" .i32 = env₂.get "r" .i32 := by
  simp [INPUT, LHS, RHS, run, denoteBB, denoteOps]
  rw [ops.constant.sem]
  rw [ops.negi.sem]
  rw [ops.xori.sem]
  rw [ops.andi.sem]
  rw [ops.xori.sem]
  rw [ops.andi.sem]
  rw [ops.ori.sem]
  rw [ops.xori.sem]
  rw [ops.andi.sem]
  simp [interpSSA', Fitree.interpState, SSAEnvE.handle]; simp_itree
  apply FinInt.and_not_and_not
end th10

/- LLVM InstCombine: `(A & B) | ~(A | B) --> ~(A ^ B)`
   https://github.com/llvm/llvm-project/blob/291e3a85658e264a2918298e804972bd68681af8/llvm/lib/Transforms/InstCombine/InstCombineAndOrXor.cpp#L1510 -/

theorem FinInt.and_or_not_or (A B: FinInt sz):
    (A &&& B) ||| ((A ||| B) ^^^ -1) = ((A ^^^ B) ^^^ -1) := by
  simp [←comp_eq_xor_minusOne]
  induction sz with
  | zero => cases A; cases B; decide
  | succ sz ih =>
      match A, B with
      | .next bA A', .next bB B' =>
          simp [HXor.hXor, HAnd.hAnd, HOr.hOr, xor, and, or, comp] at *
          simp [logic1, logic2, ih]
          cases bA <;> cases bB <;> decide

namespace th11
def LHS: BasicBlock arith := [mlir_bb|
  ^bb:
    %_1 = "arith.constant"() {value = 1: i32}: () -> i32
    %_2 = "arith.negi"(%_1): (i32) -> i32
    %_3 = "arith.ori"(%A, %B): (i32, i32) -> i32
    %_4 = "arith.xori"(%_3, %_2): (i32, i32) -> i32
    %_5 = "arith.andi"(%A, %B): (i32, i32) -> i32
    %r = "arith.ori"(%_5, %_4): (i32, i32) -> i32
]
def RHS: BasicBlock arith := [mlir_bb|
  ^bb:
    %_1 = "arith.constant"() {value = 1: i32}: () -> i32
    %_2 = "arith.negi"(%_1): (i32) -> i32
    %_3 = "arith.xori"(%A, %B): (i32, i32) -> i32
    %r = "arith.xori"(%_3, %_2): (i32, i32) -> i32
]
def INPUT (A B: FinInt 32): SSAEnv arith := SSAEnv.One [
  ("A", ⟨.i32, A⟩), ("B", ⟨.i32, B⟩)
]

theorem equivalent (A B: FinInt 32):
  semanticPostCondition₂
    (run ⟦LHS⟧ (INPUT A B))
    (run ⟦RHS⟧ (INPUT A B))
  fun _ env₁ _ env₂ =>
    env₁.get "r" .i32 = env₂.get "r" .i32 := by
  simp [INPUT, LHS, RHS, run, denoteBB, denoteOps]
  rw [ops.constant.sem]
  rw [ops.negi.sem]
  rw [ops.ori.sem]
  rw [ops.xori.sem]
  rw [ops.andi.sem]
  rw [ops.ori.sem]
  rw [ops.xori.sem]
  rw [ops.xori.sem]
  simp [interpSSA', Fitree.interpState, SSAEnvE.handle]; simp_itree
  apply FinInt.and_or_not_or
end th11

/- LLVM InstCombine: `(X ^ C1) & C2 --> (X & C2) ^ (C1&C2)`
   https://github.com/llvm/llvm-project/blob/291e3a85658e264a2918298e804972bd68681af8/llvm/lib/Transforms/InstCombine/InstCombineAndOrXor.cpp#L1778 -/

theorem FinInt.xor_and (X C₁ C₂: FinInt sz):
    (X ^^^ C₁) &&& C₂ = (X &&& C₂) ^^^ (C₁ &&& C₂) := by
  induction sz with
  | zero => cases X; cases C₁; cases C₂; decide
  | succ sz ih =>
      match X, C₁, C₂ with
      | .next bX X', .next bC₁ C₁', .next bC₂ C₂' =>
          simp [HXor.hXor, HAnd.hAnd, HOr.hOr, xor, and, or] at *
          simp [logic2, ih]
          cases bX <;> cases bC₁ <;> cases bC₂ <;> decide

namespace th12
def LHS: BasicBlock arith := [mlir_bb|
  ^bb:
    %_1 = "arith.xori"(%X, %C1): (i32, i32) -> i32
    %r = "arith.andi"(%_1, %C2): (i32, i32) -> i32
]
def RHS: BasicBlock arith := [mlir_bb|
  ^bb:
    %_1 = "arith.andi"(%X, %C2): (i32, i32) -> i32
    %_2 = "arith.andi"(%C1, %C2): (i32, i32) -> i32
    %r = "arith.xori"(%_1, %_2): (i32, i32) -> i32
]
def INPUT (X C₁ C₂: FinInt 32): SSAEnv arith := SSAEnv.One [
  ("X", ⟨.i32, X⟩), ("C1", ⟨.i32, C₁⟩), ("C2", ⟨.i32, C₂⟩)
]

theorem equivalent (X C₁ C₂: FinInt 32):
  semanticPostCondition₂
    (run ⟦LHS⟧ (INPUT X C₁ C₂))
    (run ⟦RHS⟧ (INPUT X C₁ C₂))
  fun _ env₁ _ env₂ =>
    env₁.get "r" .i32 = env₂.get "r" .i32 := by
  simp [LHS, RHS, INPUT]
  simp [run, denoteBB, denoteOps, denoteOp, denoteOpBase]; simp_itree
  apply FinInt.xor_and
end th12
-/
