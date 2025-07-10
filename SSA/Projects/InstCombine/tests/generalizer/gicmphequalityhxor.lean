import SSA.Projects.InstCombine.tests.proofs.gicmphequalityhxor_proof
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
section gicmphequalityhxor_statements

def cmpeq_xor_cst1_before := [llvm|
{
^0(%arg26 : i32, %arg27 : i32):
  %0 = llvm.mlir.constant(10 : i32) : i32
  %1 = llvm.xor %arg26, %0 : i32
  %2 = llvm.icmp "eq" %1, %arg27 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def cmpeq_xor_cst1_after := [llvm|
{
^0(%arg26 : i32, %arg27 : i32):
  %0 = llvm.mlir.constant(10 : i32) : i32
  %1 = llvm.xor %arg26, %arg27 : i32
  %2 = llvm.icmp "eq" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem cmpeq_xor_cst1_proof : cmpeq_xor_cst1_before ⊑ cmpeq_xor_cst1_after := by
  unfold cmpeq_xor_cst1_before cmpeq_xor_cst1_after
  simp_alive_peephole
  intros
  ---BEGIN cmpeq_xor_cst1
  apply cmpeq_xor_cst1_thm
  ---END cmpeq_xor_cst1



def cmpeq_xor_cst3_before := [llvm|
{
^0(%arg22 : i32, %arg23 : i32):
  %0 = llvm.mlir.constant(10 : i32) : i32
  %1 = llvm.xor %arg22, %0 : i32
  %2 = llvm.xor %arg23, %0 : i32
  %3 = llvm.icmp "eq" %1, %2 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def cmpeq_xor_cst3_after := [llvm|
{
^0(%arg22 : i32, %arg23 : i32):
  %0 = llvm.icmp "eq" %arg22, %arg23 : i32
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem cmpeq_xor_cst3_proof : cmpeq_xor_cst3_before ⊑ cmpeq_xor_cst3_after := by
  unfold cmpeq_xor_cst3_before cmpeq_xor_cst3_after
  simp_alive_peephole
  intros
  ---BEGIN cmpeq_xor_cst3
  apply cmpeq_xor_cst3_thm
  ---END cmpeq_xor_cst3



def cmpne_xor_cst1_before := [llvm|
{
^0(%arg20 : i32, %arg21 : i32):
  %0 = llvm.mlir.constant(10 : i32) : i32
  %1 = llvm.xor %arg20, %0 : i32
  %2 = llvm.icmp "ne" %1, %arg21 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def cmpne_xor_cst1_after := [llvm|
{
^0(%arg20 : i32, %arg21 : i32):
  %0 = llvm.mlir.constant(10 : i32) : i32
  %1 = llvm.xor %arg20, %arg21 : i32
  %2 = llvm.icmp "ne" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem cmpne_xor_cst1_proof : cmpne_xor_cst1_before ⊑ cmpne_xor_cst1_after := by
  unfold cmpne_xor_cst1_before cmpne_xor_cst1_after
  simp_alive_peephole
  intros
  ---BEGIN cmpne_xor_cst1
  apply cmpne_xor_cst1_thm
  ---END cmpne_xor_cst1



def cmpne_xor_cst3_before := [llvm|
{
^0(%arg16 : i32, %arg17 : i32):
  %0 = llvm.mlir.constant(10 : i32) : i32
  %1 = llvm.xor %arg16, %0 : i32
  %2 = llvm.xor %arg17, %0 : i32
  %3 = llvm.icmp "ne" %1, %2 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def cmpne_xor_cst3_after := [llvm|
{
^0(%arg16 : i32, %arg17 : i32):
  %0 = llvm.icmp "ne" %arg16, %arg17 : i32
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem cmpne_xor_cst3_proof : cmpne_xor_cst3_before ⊑ cmpne_xor_cst3_after := by
  unfold cmpne_xor_cst3_before cmpne_xor_cst3_after
  simp_alive_peephole
  intros
  ---BEGIN cmpne_xor_cst3
  apply cmpne_xor_cst3_thm
  ---END cmpne_xor_cst3



def cmpeq_xor_cst1_commuted_before := [llvm|
{
^0(%arg12 : i32, %arg13 : i32):
  %0 = llvm.mlir.constant(10 : i32) : i32
  %1 = llvm.mul %arg13, %arg13 : i32
  %2 = llvm.xor %arg12, %0 : i32
  %3 = llvm.icmp "eq" %1, %2 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def cmpeq_xor_cst1_commuted_after := [llvm|
{
^0(%arg12 : i32, %arg13 : i32):
  %0 = llvm.mlir.constant(10 : i32) : i32
  %1 = llvm.mul %arg13, %arg13 : i32
  %2 = llvm.xor %arg12, %1 : i32
  %3 = llvm.icmp "eq" %2, %0 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem cmpeq_xor_cst1_commuted_proof : cmpeq_xor_cst1_commuted_before ⊑ cmpeq_xor_cst1_commuted_after := by
  unfold cmpeq_xor_cst1_commuted_before cmpeq_xor_cst1_commuted_after
  simp_alive_peephole
  intros
  ---BEGIN cmpeq_xor_cst1_commuted
  apply cmpeq_xor_cst1_commuted_thm
  ---END cmpeq_xor_cst1_commuted



def foo1_before := [llvm|
{
^0(%arg8 : i32, %arg9 : i32):
  %0 = llvm.mlir.constant(-2147483648 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.and %arg8, %0 : i32
  %3 = llvm.xor %arg9, %1 : i32
  %4 = llvm.and %3, %0 : i32
  %5 = llvm.icmp "eq" %2, %4 : i32
  "llvm.return"(%5) : (i1) -> ()
}
]
def foo1_after := [llvm|
{
^0(%arg8 : i32, %arg9 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.xor %arg9, %arg8 : i32
  %2 = llvm.icmp "slt" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem foo1_proof : foo1_before ⊑ foo1_after := by
  unfold foo1_before foo1_after
  simp_alive_peephole
  intros
  ---BEGIN foo1
  apply foo1_thm
  ---END foo1



def foo2_before := [llvm|
{
^0(%arg6 : i32, %arg7 : i32):
  %0 = llvm.mlir.constant(-2147483648 : i32) : i32
  %1 = llvm.and %arg6, %0 : i32
  %2 = llvm.and %arg7, %0 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.icmp "eq" %1, %3 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def foo2_after := [llvm|
{
^0(%arg6 : i32, %arg7 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.xor %arg7, %arg6 : i32
  %2 = llvm.icmp "slt" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem foo2_proof : foo2_before ⊑ foo2_after := by
  unfold foo2_before foo2_after
  simp_alive_peephole
  intros
  ---BEGIN foo2
  apply foo2_thm
  ---END foo2


