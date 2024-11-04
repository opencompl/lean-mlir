import SSA.Projects.InstCombine.tests.proofs.gpr53357_proof
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open LLVM
open BitVec

open MLIR AST
open Ctxt (Var)

set_option linter.deprecated false
set_option linter.unreachableTactic false
set_option linter.unusedTactic false
section gpr53357_statements

def src_before := [llvm|
{
^0(%arg16 : i32, %arg17 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg17, %arg16 : i32
  %2 = llvm.or %arg17, %arg16 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.add %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def src_after := [llvm|
{
^0(%arg16 : i32, %arg17 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg17, %arg16 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem src_proof : src_before ⊑ src_after := by
  unfold src_before src_after
  simp_alive_peephole
  intros
  ---BEGIN src
  apply src_thm
  ---END src



def src2_before := [llvm|
{
^0(%arg10 : i32, %arg11 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg11, %arg10 : i32
  %2 = llvm.or %arg10, %arg11 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.add %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def src2_after := [llvm|
{
^0(%arg10 : i32, %arg11 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg11, %arg10 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem src2_proof : src2_before ⊑ src2_after := by
  unfold src2_before src2_after
  simp_alive_peephole
  intros
  ---BEGIN src2
  apply src2_thm
  ---END src2



def src3_before := [llvm|
{
^0(%arg8 : i32, %arg9 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg9, %arg8 : i32
  %2 = llvm.xor %arg8, %0 : i32
  %3 = llvm.xor %arg9, %0 : i32
  %4 = llvm.and %2, %3 : i32
  %5 = llvm.add %1, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def src3_after := [llvm|
{
^0(%arg8 : i32, %arg9 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg9, %arg8 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem src3_proof : src3_before ⊑ src3_after := by
  unfold src3_before src3_after
  simp_alive_peephole
  intros
  ---BEGIN src3
  apply src3_thm
  ---END src3



def src4_before := [llvm|
{
^0(%arg6 : i32, %arg7 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg6, %arg7 : i32
  %2 = llvm.or %arg7, %arg6 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.add %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def src4_after := [llvm|
{
^0(%arg6 : i32, %arg7 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg6, %arg7 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem src4_proof : src4_before ⊑ src4_after := by
  unfold src4_before src4_after
  simp_alive_peephole
  intros
  ---BEGIN src4
  apply src4_thm
  ---END src4



def src5_before := [llvm|
{
^0(%arg4 : i32, %arg5 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.or %arg5, %arg4 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %arg5, %arg4 : i32
  %4 = llvm.add %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def src5_after := [llvm|
{
^0(%arg4 : i32, %arg5 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg5, %arg4 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem src5_proof : src5_before ⊑ src5_after := by
  unfold src5_before src5_after
  simp_alive_peephole
  intros
  ---BEGIN src5
  apply src5_thm
  ---END src5


