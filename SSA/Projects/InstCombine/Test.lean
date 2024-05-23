/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Core.MLIRSyntax.GenericParser
import SSA.Core.MLIRSyntax.Transform
import SSA.Projects.InstCombine.LLVM.EDSL
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
info: ^bb0(%arg0 : MLIR.AST.MLIRType.int
  (MLIR.AST.Signedness.Signless)
  (ConcreteOrMVar.concrete
    32)) : ⏎
((%0,
 MLIR.AST.MLIRType.int
   (MLIR.AST.Signedness.Signless)
   (ConcreteOrMVar.concrete
     32))) := "llvm.mlir.constant"(){value = 8 : MLIR.AST.MLIRType.int
  (MLIR.AST.Signedness.Signless)
  (ConcreteOrMVar.concrete
    32)}
((%1,
 MLIR.AST.MLIRType.int
   (MLIR.AST.Signedness.Signless)
   (ConcreteOrMVar.concrete
     32))) := "llvm.mlir.constant"(){value = 31 : MLIR.AST.MLIRType.int
  (MLIR.AST.Signedness.Signless)
  (ConcreteOrMVar.concrete
    32)}
((%2,
 MLIR.AST.MLIRType.int
   (MLIR.AST.Signedness.Signless)
   (ConcreteOrMVar.concrete
     32))) := "llvm.ashr"((%arg0,
 MLIR.AST.MLIRType.int
   (MLIR.AST.Signedness.Signless)
   (ConcreteOrMVar.concrete
     32)), (%1,
 MLIR.AST.MLIRType.int
   (MLIR.AST.Signedness.Signless)
   (ConcreteOrMVar.concrete
     32)))
((%3,
 MLIR.AST.MLIRType.int
   (MLIR.AST.Signedness.Signless)
   (ConcreteOrMVar.concrete
     32))) := "llvm.and"((%2,
 MLIR.AST.MLIRType.int
   (MLIR.AST.Signedness.Signless)
   (ConcreteOrMVar.concrete
     32)), (%0,
 MLIR.AST.MLIRType.int
   (MLIR.AST.Signedness.Signless)
   (ConcreteOrMVar.concrete
     32)))
((%4,
 MLIR.AST.MLIRType.int
   (MLIR.AST.Signedness.Signless)
   (ConcreteOrMVar.concrete
     32))) := "llvm.add"((%3,
 MLIR.AST.MLIRType.int
   (MLIR.AST.Signedness.Signless)
   (ConcreteOrMVar.concrete
     32)), (%2,
 MLIR.AST.MLIRType.int
   (MLIR.AST.Signedness.Signless)
   (ConcreteOrMVar.concrete
     32)))
() := "llvm.return"((%4, MLIR.AST.MLIRType.int (MLIR.AST.Signedness.Signless) (ConcreteOrMVar.concrete 32)))
-/
#guard_msgs in #eval bb0


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

/--
info: Except.ok ⟨EffectKind.pure, ⟨i32, InstCombine.MOp.const (ConcreteOrMVar.concrete 32) 8[[]]⟩⟩
-/
#guard_msgs in #eval mkExpr    (Γn 1) op0    ["arg0"]

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


/-- info: Except.ok ⟨EffectKind.pure, ⟨i32, return %0⟩⟩ -/
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

/-- info: Except.ok ⟨EffectKind.pure, ⟨i32, return %0⟩⟩ -/
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

def bb0IcomConcrete := [alive_icom ()| {
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
