import SSA.Projects.MLIRSyntax.EDSL
import SSA.Projects.InstCombine.LLVM.Transform
open MLIR AST

def add_mask := [mlir_op| 
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

def bb0 := [mlir_region| 
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

    
open InstCombine
def Γn (n : Nat) :Context := 
  List.range n |>.foldl 
    (fun c _ => Ctxt.snoc c (Ty.bitvec 32))
    Ctxt.empty

def op0 := [mlir_op| %0 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32]
def op1 := [mlir_op| %1 = "llvm.mlir.constant"() {value = 31 : i32} : () -> i32]
def op2 := [mlir_op| %2 = "llvm.ashr"(%arg0, %1) : (i32, i32) -> i32]
def op3 := [mlir_op| %3 = "llvm.and"(%2, %0) : (i32, i32) -> i32]
def op4 := [mlir_op| %4 = "llvm.add"(%3, %2) : (i32, i32) -> i32]
#eval mkExpr (Γn 2) op1 |>.printErr
#eval mkExpr (Γn 3) op2 |>.printErr
#eval mkExpr (Γn 4) op3  |>.printErr
#eval mkExpr (Γn 5) op4  |>.printErr
def opRet := [mlir_op| "llvm.return"(%4) : (i32) -> ()]
#eval mkReturn (Γn 6) opRet |>.printErr

def ops := [mlir_ops| 
    %0 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 31 : i32} : () -> i32
    %2 = "llvm.ashr"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.and"(%2, %0) : (i32, i32) -> i32
    %4 = "llvm.add"(%3, %2) : (i32, i32) -> i32
    "llvm.return"(%4) : (i32) -> ()
]
def ops' := [op0, op1, op2, op3, op4]
def com (Γ : Context) := mkCom Γ bb0

#eval com Ctxt.empty |>.printErr
#eval mkExpr  (Γn 1) (ops.get! 0) |>.printErr
#eval mkExpr  (Γn 2) (ops.get! 1) |>.printErr
#eval mkExpr  (Γn 3) (ops.get! 2) |>.printErr
#eval mkExpr  (Γn 4) (ops.get! 3) |>.printErr
#eval mkExpr  (Γn 5) (ops.get! 4) |>.printErr
#eval mkReturn (Γn 6) (ops.get! 5) |>.printErr


#eval mkComHelper (Γn 1) ops |>.printErr
#eval mkComHelper (Γn 1) ops' |>.printErr