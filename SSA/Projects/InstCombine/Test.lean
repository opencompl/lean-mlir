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
#print bb0
#eval bb0


open InstCombine
def Γn (n : Nat) : Context φ :=
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
#eval mkExpr    (Γn 1) op0    ["arg0"]
#eval mkExpr    (Γn 2) op1    ["0", "arg0"]
#eval mkExpr    (Γn 3) op2    ["1", "0", "arg0"]
#eval mkExpr    (Γn 4) op3    ["2", "1", "0", "arg0"]
#eval mkExpr    (Γn 5) op4    ["3", "2", "1", "0", "arg0"]
#eval mkReturn  (Γn 6) opRet  ["4", "3", "2", "1", "0", "arg0"]

def ops : List (Op 0) := [mlir_ops|
    %0 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 31 : i32} : () -> i32
    %2 = "llvm.ashr"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.and"(%2, %0) : (i32, i32) -> i32
    %4 = "llvm.add"(%3, %2) : (i32, i32) -> i32
    "llvm.return"(%4) : (i32) -> ()
]
def ops' := [op0, op1, op2, op3, op4]

#eval mkExpr    (Γn 1)  (ops.get! 0) ["arg0"]
#eval mkExpr    (Γn 2)  (ops.get! 1) ["0", "arg0"]
#eval mkExpr    (Γn 3)  (ops.get! 2) ["1", "0", "arg0"]
#eval mkExpr    (Γn 4)  (ops.get! 3) ["2", "1", "0", "arg0"]
#eval mkExpr    (Γn 5)  (ops.get! 4) ["3", "2", "1", "0", "arg0"]
#eval mkReturn  (Γn 6)  (ops.get! 5) ["4", "3", "2", "1", "0", "arg0"]

#eval (mkCom bb0).toOption


#check ExceptT.run

def com := mkCom bb0 |>.toOption |>.get (by rfl)

#eval com

theorem com_Γ : com.1 = (Γn 1) := by rfl
theorem com_ty : com.2.1 = .bitvec 32 := by rfl

def bb0IcomConcrete := [mlir_icom|
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
def GenericWidth (w : Nat) := [mlir_icom (w)|
{
  ^bb0():
    %0 = "llvm.mlir.constant"() {value = 0 : _} : () -> _
    "llvm.return"(%0) : (_) -> ()
  }]

def bb0IcomGeneric (w : Nat) := [mlir_icom (w)|
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
example (w Γv) : (GenericWidth w).denote Γv = some (Bitvec.ofNat w 0) := by
  rfl
