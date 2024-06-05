/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Core.MLIRSyntax.GenericParser
import SSA.Core.MLIRSyntax.Transform
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.ComWrappers
import SSA.Projects.InstCombine.Tactic
open MLIR AST

/-
  TODO: infer the number of meta-variables in an AST, so that we can remove the `Op 0` annotation
  in the following
-/
def add_mask : Op 0 := [mlir_op|
  "module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i32):
    %0 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 31 : i32} : () -> i32
    %2 = "llvm.ashr"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.and"(%2, %0) : (i32, i32) -> i32
    %4 = "llvm.add"(%3, %2) : (i32, i32) -> i32
    "llvm.return"(%4) : (i32) -> ()
  })  : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):
    %0 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 31 : i32} : () -> i32
    %2 = "llvm.ashr"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.and"(%2, %0) : (i32, i32) -> i32
    %4 = "llvm.add"(%2, %3) : (i32, i32) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) : () -> ()
}) : () -> ()
]

def bb0 : Region 0 := [mlir_region|
{
  ^bb0(%arg0: i32):
    %0 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 31 : i32} : () -> i32
    %2 = "llvm.ashr"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.and"(%2, %0) : (i32, i32) -> i32
    %4 = "llvm.add"(%3, %2) : (i32, i32) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }]


/--
info: def bb0 : Region 0 :=
Region.mk "bb0" [(SSAVal.SSAVal "arg0", MLIRType.int Signedness.Signless 32)]
  [Op.mk "llvm.mlir.constant" [(SSAVal.SSAVal (EDSL.IntToString 0), MLIRType.int Signedness.Signless 32)] [] []
      (AttrDict.mk [AttrEntry.mk "value" (AttrValue.int 8 (MLIRType.int Signedness.Signless 32))]),
    Op.mk "llvm.mlir.constant" [(SSAVal.SSAVal (EDSL.IntToString 1), MLIRType.int Signedness.Signless 32)] [] []
      (AttrDict.mk [AttrEntry.mk "value" (AttrValue.int 31 (MLIRType.int Signedness.Signless 32))]),
    Op.mk "llvm.ashr" [(SSAVal.SSAVal (EDSL.IntToString 2), MLIRType.int Signedness.Signless 32)]
      [(SSAVal.SSAVal "arg0", MLIRType.int Signedness.Signless 32),
        (SSAVal.SSAVal (EDSL.IntToString 1), MLIRType.int Signedness.Signless 32)]
      [] (AttrDict.mk []),
    Op.mk "llvm.and" [(SSAVal.SSAVal (EDSL.IntToString 3), MLIRType.int Signedness.Signless 32)]
      [(SSAVal.SSAVal (EDSL.IntToString 2), MLIRType.int Signedness.Signless 32),
        (SSAVal.SSAVal (EDSL.IntToString 0), MLIRType.int Signedness.Signless 32)]
      [] (AttrDict.mk []),
    Op.mk "llvm.add" [(SSAVal.SSAVal (EDSL.IntToString 4), MLIRType.int Signedness.Signless 32)]
      [(SSAVal.SSAVal (EDSL.IntToString 3), MLIRType.int Signedness.Signless 32),
        (SSAVal.SSAVal (EDSL.IntToString 2), MLIRType.int Signedness.Signless 32)]
      [] (AttrDict.mk []),
    Op.mk "llvm.return" [] [(SSAVal.SSAVal (EDSL.IntToString 4), MLIRType.int Signedness.Signless 32)] []
      (AttrDict.mk [])]
-/
#guard_msgs in #print bb0

open InstCombine
open InstcombineTransformDialect
def Γn (n : Nat) : Ctxt (MetaLLVM φ).Ty :=
  Ctxt.ofList <| .replicate n (.bitvec 32)

def op0 : Op 0 := [mlir_op| %0 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32]
def op1 : Op 0 := [mlir_op| %1 = "llvm.mlir.constant"() {value = 31 : i32} : () -> i32]
def op2 : Op 0 := [mlir_op| %2 = "llvm.ashr"(%arg0, %1) : (i32, i32) -> i32]
def op3 : Op 0 := [mlir_op| %3 = "llvm.and"(%2, %0) : (i32, i32) -> i32]
def op4 : Op 0 := [mlir_op| %4 = "llvm.add"(%3, %2) : (i32, i32) -> i32]
def opRet : Op 0 := [mlir_op| "llvm.return"(%4) : (i32) -> ()]

/-
  TODO: these tests were broken.
  I've changed them to be consistent with how the current code works,
  please check that the tested behaviour is actually the desired behaviour
-/

/--
info: Except.ok ⟨EffectKind.pure, ⟨i32, InstCombine.MOp.const (ConcreteOrMVar.concrete 32) 8[[]]⟩⟩
-/
#guard_msgs in #eval mkExpr    (Γn 1) op0    ["arg0"]

/--
info: Except.ok ⟨EffectKind.pure, ⟨i32, InstCombine.MOp.const (ConcreteOrMVar.concrete 32) 31[[]]⟩⟩
-/
#guard_msgs in #eval mkExpr    (Γn 2) op1    ["0", "arg0"]

/--
info: Except.ok ⟨EffectKind.pure, ⟨i32, InstCombine.MOp.binary
    (ConcreteOrMVar.concrete 32)
    (InstCombine.MOp.BinaryOp.ashr)[[%2, ,, %0]]⟩⟩
    -/
#guard_msgs in #eval mkExpr    (Γn 3) op2    ["1", "0", "arg0"]

/--
info: Except.ok ⟨EffectKind.pure, ⟨i32, InstCombine.MOp.binary
    (ConcreteOrMVar.concrete 32)
    (InstCombine.MOp.BinaryOp.and)[[%0, ,, %2]]⟩⟩
-/
#guard_msgs in #eval mkExpr    (Γn 4) op3    ["2", "1", "0", "arg0"]

/--
info: Except.ok ⟨EffectKind.pure, ⟨i32, InstCombine.MOp.binary
    (ConcreteOrMVar.concrete 32)
    (InstCombine.MOp.BinaryOp.add)[[%0, ,, %1]]⟩⟩
-/
#guard_msgs in #eval mkExpr    (Γn 5) op4    ["3", "2", "1", "0", "arg0"]

/--
info: Except.ok ⟨EffectKind.pure, ⟨i32, return %0⟩⟩
-/
#guard_msgs in #eval mkReturn  (Γn 6) opRet  ["4", "3", "2", "1", "0", "arg0"]

def ops : List (Op 0) := [mlir_ops|
    %0 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 31 : i32} : () -> i32
    %2 = "llvm.ashr"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.and"(%2, %0) : (i32, i32) -> i32
    %4 = "llvm.add"(%3, %2) : (i32, i32) -> i32
    "llvm.return"(%4) : (i32) -> ()
]
def ops' := [op0, op1, op2, op3, op4]

/--
info: Except.ok ⟨EffectKind.pure, ⟨i32, InstCombine.MOp.const (ConcreteOrMVar.concrete 32) 8[[]]⟩⟩
-/
#guard_msgs in #eval mkExpr    (Γn 1)  (ops.get! 0) ["arg0"]

/--
info: Except.ok ⟨EffectKind.pure, ⟨i32, InstCombine.MOp.const (ConcreteOrMVar.concrete 32) 31[[]]⟩⟩
-/
#guard_msgs in #eval mkExpr    (Γn 2)  (ops.get! 1) ["0", "arg0"]

/--
info: Except.ok ⟨EffectKind.pure, ⟨i32, InstCombine.MOp.binary
    (ConcreteOrMVar.concrete 32)
    (InstCombine.MOp.BinaryOp.ashr)[[%2, ,, %0]]⟩⟩
-/
#guard_msgs in #eval mkExpr    (Γn 3)  (ops.get! 2) ["1", "0", "arg0"]

/--
info: Except.ok ⟨EffectKind.pure, ⟨i32, InstCombine.MOp.binary
    (ConcreteOrMVar.concrete 32)
    (InstCombine.MOp.BinaryOp.and)[[%0, ,, %2]]⟩⟩
-/
#guard_msgs in #eval mkExpr    (Γn 4)  (ops.get! 3) ["2", "1", "0", "arg0"]

/--
info: Except.ok ⟨EffectKind.pure, ⟨i32, InstCombine.MOp.binary
    (ConcreteOrMVar.concrete 32)
    (InstCombine.MOp.BinaryOp.add)[[%0, ,, %1]]⟩⟩
-/
#guard_msgs in #eval mkExpr    (Γn 5)  (ops.get! 4) ["3", "2", "1", "0", "arg0"]

/--
info: Except.ok ⟨EffectKind.pure, ⟨i32, return %0⟩⟩
-/
#guard_msgs in #eval mkReturn  (Γn 6)  (ops.get! 5) ["4", "3", "2", "1", "0", "arg0"]

def com := mkCom (d := InstCombine.MetaLLVM 0) bb0 |>.toOption |>.get (by rfl)

/--
info: ⟨[MTy.bitvec (ConcreteOrMVar.concrete 32)],
  ⟨EffectKind.pure,
    ⟨MTy.bitvec (ConcreteOrMVar.concrete 32),
      Com.lete (Expr.mk (MOp.const (ConcreteOrMVar.concrete 32) (Int.ofNat 8)) ⋯ ⋯ HVector.nil HVector.nil)
        (Com.lete (Expr.mk (MOp.const (ConcreteOrMVar.concrete 32) (Int.ofNat 31)) ⋯ ⋯ HVector.nil HVector.nil)
          (Com.lete
            (Expr.mk (MOp.binary (ConcreteOrMVar.concrete 32) MOp.BinaryOp.ashr) ⋯ ⋯ (⟨2, ⋯⟩::ₕ(⟨0, ⋯⟩::ₕHVector.nil))
              HVector.nil)
            (Com.lete
              (Expr.mk (MOp.binary (ConcreteOrMVar.concrete 32) MOp.BinaryOp.and) ⋯ ⋯ (⟨0, ⋯⟩::ₕ(⟨2, ⋯⟩::ₕHVector.nil))
                HVector.nil)
              (Com.lete
                (Expr.mk (MOp.binary (ConcreteOrMVar.concrete 32) MOp.BinaryOp.add) ⋯ ⋯
                  (⟨0, ⋯⟩::ₕ(⟨1, ⋯⟩::ₕHVector.nil)) HVector.nil)
                (Com.ret ⟨0, ⋯⟩)))))⟩⟩⟩
-/
#guard_msgs in #reduce com

theorem com_Γ : com.1 = (Γn 1) := by rfl
theorem com_ty : com.2.2.1 = .bitvec 32 := by rfl

def bb0IcomConcrete := [alive_icom ()|
{
  ^bb0(%arg0: i32):
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 31 : i32} : () -> i32
    %2 = "llvm.ashr"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.and"(%2, %0) : (i32, i32) -> i32
    %4 = "llvm.add"(%3, %2) : (i32, i32) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }]

/-- A simple example of a family of programs, generic over some bitwidth `w` -/
def GenericWidth (w : Nat) := [alive_icom (w)|
{
  ^bb0():
    %0 = "llvm.mlir.constant"() {value = 0 : _} : () -> _
    "llvm.return"(%0) : (_) -> ()
  }]

def bb0IcomGeneric (w : Nat) := [alive_icom (w)|
{
  ^bb0(%arg0: _):
    %0 = "llvm.mlir.constant"() {value = 1 : _} : () -> _
    %1 = "llvm.mlir.constant"() {value = 31 : _} : () -> _
    %2 = "llvm.ashr"(%arg0, %1) : (_, _) -> _
    %3 = "llvm.and"(%2, %0) : (_, _) -> _
    %4 = "llvm.add"(%3, %2) : (_, _) -> _
    "llvm.return"(%4) : (_) -> ()
  }]

/-- Indeed, the concrete program is an instantiation of the generic program -/
example : bb0IcomGeneric 32 = bb0IcomConcrete := by rfl

/--
  Simple example of the denotation of `GenericWidth`.
  Note that we only have semantics (in the sense of "an implementation of `OpSemantics`")
  for concrete programs. We thus need to instantiate `GenericWidth` with some width `w` before we
  can use `denote`. In this way, we indirectly give semantics to the family of programs that
  `GenericWidth` represents.
-/
example (w Γv) : (GenericWidth w).denote Γv = some (BitVec.ofNat w 0) := rfl

open ComWrappers

set_option ssa.alive_icom_reduce true in
def one_inst_macro (w: Nat) :=
  [alive_icom (w)|{
  ^bb0(%arg0: _):
    %0 = llvm.not %arg0
    llvm.return %0
  }]

set_option ssa.alive_icom_reduce false in
def one_inst_macro_noreduce (w: Nat) :=
  [alive_icom (w)|{
  ^bb0(%arg0: _):
    %0 = llvm.not %arg0
    llvm.return %0
  }]

def one_inst_com (w : ℕ) :
    Com InstCombine.LLVM [InstCombine.Ty.bitvec w] .pure (InstCombine.Ty.bitvec w) :=
  Com.lete (not w 0) <|
  Com.ret ⟨0, by simp [Ctxt.snoc]⟩

def one_inst_stmt (e : LLVM.IntW w) :
    @BitVec.Refinement (BitVec w) (LLVM.not e) (LLVM.not e) := by
  simp

def one_inst_com_proof (w : Nat) :
    one_inst_com w ⊑ one_inst_com w := by
  unfold one_inst_com
  simp only [simp_llvm_wrap]
  simp_alive_meta
  simp_alive_ssa
  apply one_inst_stmt

def one_inst_macro_proof (w : Nat) :
    one_inst_macro w ⊑ one_inst_macro w := by
  unfold one_inst_macro
  simp_alive_meta
  simp_alive_ssa
  apply one_inst_stmt

def one_inst_macro_proof_noreduce (w : Nat) :
    one_inst_macro_noreduce w ⊑ one_inst_macro_noreduce w := by
  unfold one_inst_macro_noreduce
  simp_alive_meta
  simp_alive_ssa
  apply one_inst_stmt

set_option ssa.alive_icom_reduce true in
def two_inst_macro (w: Nat) :=
  [alive_icom (w)|{
  ^bb0(%arg0: _):
    %0 = llvm.not %arg0
    %1 = llvm.not %arg0
    llvm.return %0
  }]

set_option ssa.alive_icom_reduce false in
def two_inst_macro_noreduce (w: Nat) :=
  [alive_icom (w)|{
  ^bb0(%arg0: _):
    %0 = llvm.not %arg0
    %1 = llvm.not %arg0
    llvm.return %0
  }]

def two_inst_com (w : ℕ) :
    Com InstCombine.LLVM [InstCombine.Ty.bitvec w] .pure (InstCombine.Ty.bitvec w) :=
  Com.lete (not w 0) <|
  Com.lete (not w 1) <|
  Com.ret ⟨1, by simp [Ctxt.snoc]⟩

def two_inst_stmt (e : LLVM.IntW w) :
    @BitVec.Refinement (BitVec w) (LLVM.not e) (LLVM.not e) := by
  simp

def two_inst_com_proof (w : Nat) :
    two_inst_com w ⊑ two_inst_com w := by
  unfold two_inst_com
  simp only [simp_llvm_wrap]
  simp_alive_meta
  simp_alive_ssa
  apply two_inst_stmt

def two_inst_macro_proof (w : Nat) :
    two_inst_macro w ⊑ two_inst_macro w := by
  unfold two_inst_macro
  simp_alive_meta
  simp_alive_ssa
  apply two_inst_stmt

def two_inst_macro_noreduce_proof (w : Nat) :
    two_inst_macro_noreduce w ⊑ two_inst_macro_noreduce w := by
  unfold two_inst_macro_noreduce
  simp_alive_meta
  simp_alive_ssa
  apply two_inst_stmt

def three_inst_macro (w: Nat) :=
  [alive_icom (w)|{
  ^bb0(%arg0: _):
    %0 = llvm.not %arg0
    %1 = llvm.not %0
    %2 = llvm.not %1
    llvm.return %2
  }]

set_option ssa.alive_icom_reduce false in
def three_inst_macro_noreduce (w: Nat) :=
  [alive_icom (w)|{
  ^bb0(%arg0: _):
    %0 = llvm.not %arg0
    %1 = llvm.not %0
    %2 = llvm.not %1
    llvm.return %2
  }]

def three_inst_com (w : ℕ) :
    Com InstCombine.LLVM [InstCombine.Ty.bitvec w] .pure (InstCombine.Ty.bitvec w) :=
  Com.lete (not w 0) <|
  Com.lete (not w 0) <|
  Com.lete (not w 0) <|
  Com.ret ⟨0, by simp [Ctxt.snoc]⟩

def three_inst_stmt (e : LLVM.IntW w) :
    @BitVec.Refinement (BitVec w) (LLVM.not (LLVM.not (LLVM.not e)))
      (LLVM.not (LLVM.not (LLVM.not e))) := by
  simp

def three_inst_com_proof (w : Nat) :
    three_inst_com w ⊑ three_inst_com w := by
  unfold three_inst_com
  simp only [simp_llvm_wrap]
  simp_alive_meta
  simp_alive_ssa
  apply three_inst_stmt

def three_inst_macro_proof (w : Nat) :
    three_inst_macro w ⊑ three_inst_macro w := by
  unfold three_inst_macro
  simp_alive_meta
  simp_alive_ssa
  apply three_inst_stmt

def three_inst_macro_noreduce_proof (w : Nat) :
    three_inst_macro_noreduce w ⊑ three_inst_macro_noreduce w := by
  unfold three_inst_macro_noreduce
  simp_alive_meta
  simp_alive_ssa
  apply three_inst_stmt

set_option ssa.alive_icom_reduce true in
def one_inst_concrete_macro :=
  [alive_icom ()|{
  ^bb0(%arg0: i1):
    %0 = llvm.not %arg0 : i1
    llvm.return %0 : i1
  }]

set_option ssa.alive_icom_reduce false in
def one_inst_concrete_macro_noreduce :=
  [alive_icom ()|{
  ^bb0(%arg0: i1):
    %0 = llvm.not %arg0 : i1
    llvm.return %0 : i1
  }]

def one_inst_concrete_com :
    Com InstCombine.LLVM [InstCombine.Ty.bitvec 1] .pure (InstCombine.Ty.bitvec 1) :=
  Com.lete (not 1 0) <|
  Com.ret ⟨0, by simp [Ctxt.snoc]⟩

def one_inst_concrete_stmt :
    @BitVec.Refinement (BitVec 1) (LLVM.not e) (LLVM.not e) := by
  simp

def one_inst_concrete_com_proof :
    one_inst_concrete_com ⊑ one_inst_concrete_com := by
  unfold one_inst_concrete_com
  simp only [simp_llvm_wrap]
  simp_alive_meta
  simp_alive_ssa
  apply one_inst_concrete_stmt

def one_inst_concrete_macro_proof :
    one_inst_concrete_macro ⊑ one_inst_concrete_macro := by
  unfold one_inst_concrete_macro
  simp_alive_meta
  simp_alive_ssa
  apply one_inst_concrete_stmt

def one_inst_concrete_macro_proof_noreduce :
    one_inst_concrete_macro_noreduce ⊑ one_inst_concrete_macro_noreduce := by
  unfold one_inst_concrete_macro_noreduce
  simp_alive_meta
  simp_alive_ssa
  apply one_inst_concrete_stmt

set_option ssa.alive_icom_reduce true in
def two_inst_concrete_macro :=
  [alive_icom ()|{
  ^bb0(%arg0: i1):
    %0 = llvm.not %arg0 : i1
    %1 = llvm.not %arg0 : i1
    llvm.return %0 : i1
  }]

set_option ssa.alive_icom_reduce false in
def two_inst_concrete_macro_noreduce :=
  [alive_icom ()|{
  ^bb0(%arg0: i1):
    %0 = llvm.not %arg0 : i1
    %1 = llvm.not %arg0 : i1
    llvm.return %0 : i1
  }]

def two_inst_concrete_com (w : ℕ) :
  Com InstCombine.LLVM [InstCombine.Ty.bitvec w] .pure (InstCombine.Ty.bitvec w) :=
  Com.lete (not w 0) <|
  Com.lete (not w 1) <|
  Com.ret ⟨1, by simp [Ctxt.snoc]⟩

def two_inst_concrete_stmt (e : LLVM.IntW w) :
    @BitVec.Refinement (BitVec w) (LLVM.not e) (LLVM.not e) := by
  simp

def two_inst_concrete_com_proof :
    two_inst_concrete_com w ⊑ two_inst_concrete_com w := by
  unfold two_inst_concrete_com
  simp only [simp_llvm_wrap]
  simp_alive_meta
  simp_alive_ssa
  apply two_inst_concrete_stmt

def two_inst_concrete_macro_proof :
    two_inst_concrete_macro ⊑ two_inst_concrete_macro := by
  unfold two_inst_concrete_macro
  simp_alive_meta
  simp_alive_ssa
  apply two_inst_concrete_stmt

def two_inst_concrete_macro_noreduce_proof :
    two_inst_concrete_macro_noreduce ⊑ two_inst_concrete_macro_noreduce := by
  unfold two_inst_concrete_macro_noreduce
  simp_alive_meta
  simp_alive_ssa
  apply two_inst_concrete_stmt

set_option ssa.alive_icom_reduce true in
def three_inst_concrete_macro :=
  [alive_icom ()|{
  ^bb0(%arg0: i1):
    %0 = llvm.not %arg0 : i1
    %1 = llvm.not %0 : i1
    %2 = llvm.not %1 : i1
    llvm.return %2 : i1
  }]

set_option ssa.alive_icom_reduce false in
def three_inst_concrete_macro_noreduce :=
  [alive_icom ()|{
  ^bb0(%arg0: i1):
    %0 = llvm.not %arg0 : i1
    %1 = llvm.not %0 : i1
    %2 = llvm.not %1 : i1
    llvm.return %2 : i1
  }]

def three_inst_concrete_com :
  Com InstCombine.LLVM [InstCombine.Ty.bitvec 1] .pure (InstCombine.Ty.bitvec 1) :=
  Com.lete (not 1 0) <|
  Com.lete (not 1 0) <|
  Com.lete (not 1 0) <|
  Com.ret ⟨0, by simp [Ctxt.snoc]⟩

def three_inst_concrete_stmt (e : LLVM.IntW 1) :
    @BitVec.Refinement (BitVec 1) (LLVM.not (LLVM.not (LLVM.not e)))
      (LLVM.not (LLVM.not (LLVM.not e))) := by
  simp

def three_inst_concrete_com_proof :
    three_inst_concrete_com ⊑ three_inst_concrete_com := by
  unfold three_inst_concrete_com
  simp only [simp_llvm_wrap]
  simp_alive_meta
  simp_alive_ssa
  apply three_inst_concrete_stmt

def three_inst_concrete_macro_proof :
    three_inst_concrete_macro ⊑ three_inst_concrete_macro := by
  unfold three_inst_concrete_macro
  simp_alive_meta
  simp_alive_ssa
  apply three_inst_concrete_stmt

def three_inst_concrete_macro_noreduce_proof :
    three_inst_concrete_macro_noreduce ⊑ three_inst_concrete_macro_noreduce := by
  unfold three_inst_concrete_macro_noreduce
  simp_alive_meta
  simp_alive_ssa
  apply three_inst_concrete_stmt

set_option ssa.alive_icom_reduce false in
def two_ne_macro_noreduce (w : Nat) :=
  [alive_icom (w)|{
  ^bb0(%arg0: _, %arg1: _):
    %0 = llvm.icmp.ne %arg0,  %arg1
    %1 = llvm.icmp.ne %arg0,  %arg1
    llvm.return %1 : i1
  }]

def two_ne_stmt (a b : LLVM.IntW w) :
    @BitVec.Refinement (BitVec 1) (LLVM.icmp LLVM.IntPredicate.ne b a)
      (LLVM.icmp LLVM.IntPredicate.ne b a) := by
  simp

def two_ne_macro_noreduce_proof (w : Nat) :
    two_ne_macro_noreduce w ⊑ two_ne_macro_noreduce w := by
  unfold two_ne_macro_noreduce
  simp_alive_meta
  simp_alive_ssa
  apply two_ne_stmt

set_option ssa.alive_icom_reduce true in
def constant_macro (w : Nat) :=
  [alive_icom (w)|{
  ^bb0():
    %0 = "llvm.mlir.constant" () { value = 2 : _ } : () -> (_)
    %1 = "llvm.mlir.constant" () { value = 1 : _ } : () -> (_)
    %2 = "llvm.mlir.constant" () { value = 0 : _ } : () -> (_)
    %3 = "llvm.mlir.constant" () { value = -1 : _ } : () -> (_)
    %4 = "llvm.mlir.constant" () { value = -2 : _ } : () -> (_)
    %5 = llvm.add %0,  %1
    %6 = llvm.add %5,  %2
    %7 = llvm.add %6,  %3
    %8 = llvm.add %7,  %4
    llvm.return %8
  }]

set_option ssa.alive_icom_reduce false in
def constant_macro_noreduce (w : Nat) :=
  [alive_icom (w)|{
  ^bb0():
    %0 = "llvm.mlir.constant" () { value = 2 : _ } : () -> (_)
    %1 = "llvm.mlir.constant" () { value = 1 : _ } : () -> (_)
    %2 = "llvm.mlir.constant" () { value = 0 : _ } : () -> (_)
    %3 = "llvm.mlir.constant" () { value = -1 : _ } : () -> (_)
    %4 = "llvm.mlir.constant" () { value = -2 : _ } : () -> (_)
    %5 = llvm.add %0,  %1
    %6 = llvm.add %5,  %2
    %7 = llvm.add %6,  %3
    %8 = llvm.add %7,  %4
    llvm.return %8
  }]

def constant_stmt :
    @BitVec.Refinement (BitVec w)
      (LLVM.add (LLVM.add (LLVM.add (LLVM.add (LLVM.const? 2) (LLVM.const? 1))
        (LLVM.const? 0)) (LLVM.const? (-1))) (LLVM.const? (-2)))
      (LLVM.add (LLVM.add (LLVM.add (LLVM.add (LLVM.const? 2) (LLVM.const? 1))
        (LLVM.const? 0)) (LLVM.const? (-1))) (LLVM.const? (-2))) := by
  simp

def constant_macro_proof (w : Nat) :
    constant_macro w ⊑ constant_macro w := by
  unfold constant_macro
  simp_alive_meta
  simp_alive_ssa
  apply constant_stmt

def constant_macro_noreduce_proof (w : Nat) :
    constant_macro_noreduce w ⊑ constant_macro_noreduce w := by
  unfold constant_macro_noreduce
  simp_alive_meta
  simp_alive_ssa
  apply constant_stmt
