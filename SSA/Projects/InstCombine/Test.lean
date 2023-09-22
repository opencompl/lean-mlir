import SSA.Projects.MLIRSyntax.EDSL
import SSA.Projects.InstCombine.LLVM.Transform
import SSA.Projects.InstCombine.LLVM.EDSL
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
#eval bb0

    
open InstCombine
def Γn (n : Nat) : Context := 
  Ctxt.ofList <| .replicate n (Ty.bitvec 32)

def op0 := [mlir_op| %0 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32]
def op1 := [mlir_op| %1 = "llvm.mlir.constant"() {value = 31 : i32} : () -> i32]
def op2 := [mlir_op| %2 = "llvm.ashr"(%arg0, %1) : (i32, i32) -> i32]
def op3 := [mlir_op| %3 = "llvm.and"(%2, %0) : (i32, i32) -> i32]
def op4 := [mlir_op| %4 = "llvm.add"(%3, %2) : (i32, i32) -> i32]
def opRet := [mlir_op| "llvm.return"(%4) : (i32) -> ()]

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

def ops := [mlir_ops| 
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
theorem com_ty : com.2.1 = Ty.bitvec 32 := by rfl

def bb0IcomConcrete := [mlir_icom| 
{
  ^bb0(%arg0: i32): 
    %0 = "llvm.mlir.constant"() {value = $(.int 1 (.i 32))} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 31 : i32} : () -> i32
    %2 = "llvm.ashr"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.and"(%2, %0) : (i32, i32) -> i32
    %4 = "llvm.add"(%3, %2) : (i32, i32) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }]

/-! anti-quotations with let-bindings seem to work for arbitrary values `w < 100`. 
    If we set `w := 100` or above, we get `maximum recursion depth has been reached`-/
def bb0IcomLet := let w := 99; [mlir_icom| 
{
  ^bb0():
    %0 = "llvm.mlir.constant"() {value = 0 : $(.i w)} : () -> $(.i w)
    "llvm.return"(%0) : ($(.i w)) -> ()
  }]

#print bb0IcomLet

-- `bb0IcomLet` should already be in normal form. Yet, reducing it again seems to not work
#reduce bb0IcomLet -- error: maximum recursion depth has been reached

/-!
  Similarly, syntax that is fully generic over bit-width (by taking `w` as argument) 
  seems to fail to reduce at all
-/

def bb0IcomGeneric (w : Nat) := [mlir_icom| 
{
  ^bb0():
    %0 = "llvm.mlir.constant"() {value = 0 : $(.i w)} : () -> $(.i w)
    "llvm.return"(%0) : ($(.i w)) -> ()
  }]