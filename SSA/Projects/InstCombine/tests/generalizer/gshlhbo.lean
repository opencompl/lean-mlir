import SSA.Projects.InstCombine.tests.proofs.gshlhbo_proof
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
section gshlhbo_statements

def lshr_add_before := [llvm|
{
^0(%arg81 : i8, %arg82 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(5 : i8) : i8
  %2 = llvm.srem %arg81, %0 : i8
  %3 = llvm.lshr %arg82, %1 : i8
  %4 = llvm.add %3, %2 : i8
  %5 = llvm.shl %4, %1 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def lshr_add_after := [llvm|
{
^0(%arg81 : i8, %arg82 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(5 : i8) : i8
  %2 = llvm.mlir.constant(-32 : i8) : i8
  %3 = llvm.srem %arg81, %0 : i8
  %4 = llvm.shl %3, %1 : i8
  %5 = llvm.add %arg82, %4 : i8
  %6 = llvm.and %5, %2 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_add_proof : lshr_add_before ⊑ lshr_add_after := by
  unfold lshr_add_before lshr_add_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_add
  apply lshr_add_thm
  ---END lshr_add



def lshr_sub_before := [llvm|
{
^0(%arg77 : i8, %arg78 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(3 : i8) : i8
  %2 = llvm.srem %arg77, %0 : i8
  %3 = llvm.lshr %arg78, %1 : i8
  %4 = llvm.sub %2, %3 : i8
  %5 = llvm.shl %4, %1 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def lshr_sub_after := [llvm|
{
^0(%arg77 : i8, %arg78 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(3 : i8) : i8
  %2 = llvm.srem %arg77, %0 : i8
  %3 = llvm.lshr %arg78, %1 : i8
  %4 = llvm.sub %2, %3 overflow<nsw> : i8
  %5 = llvm.shl %4, %1 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_sub_proof : lshr_sub_before ⊑ lshr_sub_after := by
  unfold lshr_sub_before lshr_sub_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_sub
  apply lshr_sub_thm
  ---END lshr_sub



def lshr_and_before := [llvm|
{
^0(%arg73 : i8, %arg74 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(6 : i8) : i8
  %2 = llvm.srem %arg73, %0 : i8
  %3 = llvm.lshr %arg74, %1 : i8
  %4 = llvm.and %3, %2 : i8
  %5 = llvm.shl %4, %1 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def lshr_and_after := [llvm|
{
^0(%arg73 : i8, %arg74 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(6 : i8) : i8
  %2 = llvm.srem %arg73, %0 : i8
  %3 = llvm.shl %2, %1 : i8
  %4 = llvm.and %arg74, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_and_proof : lshr_and_before ⊑ lshr_and_after := by
  unfold lshr_and_before lshr_and_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_and
  apply lshr_and_thm
  ---END lshr_and



def lshr_or_before := [llvm|
{
^0(%arg69 : i8, %arg70 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(4 : i8) : i8
  %2 = llvm.srem %arg69, %0 : i8
  %3 = llvm.lshr %arg70, %1 : i8
  %4 = llvm.or %2, %3 : i8
  %5 = llvm.shl %4, %1 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def lshr_or_after := [llvm|
{
^0(%arg69 : i8, %arg70 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(4 : i8) : i8
  %2 = llvm.mlir.constant(-16 : i8) : i8
  %3 = llvm.srem %arg69, %0 : i8
  %4 = llvm.shl %3, %1 : i8
  %5 = llvm.and %arg70, %2 : i8
  %6 = llvm.or %5, %4 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_or_proof : lshr_or_before ⊑ lshr_or_after := by
  unfold lshr_or_before lshr_or_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_or
  apply lshr_or_thm
  ---END lshr_or



def lshr_xor_before := [llvm|
{
^0(%arg65 : i8, %arg66 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(3 : i8) : i8
  %2 = llvm.srem %arg65, %0 : i8
  %3 = llvm.lshr %arg66, %1 : i8
  %4 = llvm.xor %3, %2 : i8
  %5 = llvm.shl %4, %1 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def lshr_xor_after := [llvm|
{
^0(%arg65 : i8, %arg66 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(3 : i8) : i8
  %2 = llvm.mlir.constant(-8 : i8) : i8
  %3 = llvm.srem %arg65, %0 : i8
  %4 = llvm.shl %3, %1 : i8
  %5 = llvm.and %arg66, %2 : i8
  %6 = llvm.xor %5, %4 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_xor_proof : lshr_xor_before ⊑ lshr_xor_after := by
  unfold lshr_xor_before lshr_xor_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_xor
  apply lshr_xor_thm
  ---END lshr_xor



def lshr_and_add_before := [llvm|
{
^0(%arg57 : i8, %arg58 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(3 : i8) : i8
  %2 = llvm.mlir.constant(12 : i8) : i8
  %3 = llvm.srem %arg57, %0 : i8
  %4 = llvm.lshr %arg58, %1 : i8
  %5 = llvm.and %4, %2 : i8
  %6 = llvm.add %3, %5 : i8
  %7 = llvm.shl %6, %1 : i8
  "llvm.return"(%7) : (i8) -> ()
}
]
def lshr_and_add_after := [llvm|
{
^0(%arg57 : i8, %arg58 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(3 : i8) : i8
  %2 = llvm.mlir.constant(96 : i8) : i8
  %3 = llvm.srem %arg57, %0 : i8
  %4 = llvm.shl %3, %1 : i8
  %5 = llvm.and %arg58, %2 : i8
  %6 = llvm.add %5, %4 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_and_add_proof : lshr_and_add_before ⊑ lshr_and_add_after := by
  unfold lshr_and_add_before lshr_and_add_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_and_add
  apply lshr_and_add_thm
  ---END lshr_and_add



def lshr_and_sub_before := [llvm|
{
^0(%arg53 : i8, %arg54 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(2 : i8) : i8
  %2 = llvm.mlir.constant(13 : i8) : i8
  %3 = llvm.srem %arg53, %0 : i8
  %4 = llvm.lshr %arg54, %1 : i8
  %5 = llvm.and %4, %2 : i8
  %6 = llvm.sub %3, %5 : i8
  %7 = llvm.shl %6, %1 : i8
  "llvm.return"(%7) : (i8) -> ()
}
]
def lshr_and_sub_after := [llvm|
{
^0(%arg53 : i8, %arg54 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(2 : i8) : i8
  %2 = llvm.mlir.constant(13 : i8) : i8
  %3 = llvm.srem %arg53, %0 : i8
  %4 = llvm.lshr %arg54, %1 : i8
  %5 = llvm.and %4, %2 : i8
  %6 = llvm.sub %3, %5 overflow<nsw> : i8
  %7 = llvm.shl %6, %1 : i8
  "llvm.return"(%7) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_and_sub_proof : lshr_and_sub_before ⊑ lshr_and_sub_after := by
  unfold lshr_and_sub_before lshr_and_sub_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_and_sub
  apply lshr_and_sub_thm
  ---END lshr_and_sub



def lshr_and_and_before := [llvm|
{
^0(%arg49 : i8, %arg50 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(2 : i8) : i8
  %2 = llvm.mlir.constant(13 : i8) : i8
  %3 = llvm.srem %arg49, %0 : i8
  %4 = llvm.lshr %arg50, %1 : i8
  %5 = llvm.and %4, %2 : i8
  %6 = llvm.and %5, %3 : i8
  %7 = llvm.shl %6, %1 : i8
  "llvm.return"(%7) : (i8) -> ()
}
]
def lshr_and_and_after := [llvm|
{
^0(%arg49 : i8, %arg50 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(2 : i8) : i8
  %2 = llvm.mlir.constant(52 : i8) : i8
  %3 = llvm.srem %arg49, %0 : i8
  %4 = llvm.shl %3, %1 : i8
  %5 = llvm.and %arg50, %2 : i8
  %6 = llvm.and %5, %4 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_and_and_proof : lshr_and_and_before ⊑ lshr_and_and_after := by
  unfold lshr_and_and_before lshr_and_and_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_and_and
  apply lshr_and_and_thm
  ---END lshr_and_and



def lshr_and_or_before := [llvm|
{
^0(%arg45 : i8, %arg46 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(2 : i8) : i8
  %2 = llvm.mlir.constant(13 : i8) : i8
  %3 = llvm.srem %arg45, %0 : i8
  %4 = llvm.lshr %arg46, %1 : i8
  %5 = llvm.and %4, %2 : i8
  %6 = llvm.or %3, %5 : i8
  %7 = llvm.shl %6, %1 : i8
  "llvm.return"(%7) : (i8) -> ()
}
]
def lshr_and_or_after := [llvm|
{
^0(%arg45 : i8, %arg46 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(2 : i8) : i8
  %2 = llvm.mlir.constant(52 : i8) : i8
  %3 = llvm.srem %arg45, %0 : i8
  %4 = llvm.shl %3, %1 : i8
  %5 = llvm.and %arg46, %2 : i8
  %6 = llvm.or %5, %4 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_and_or_proof : lshr_and_or_before ⊑ lshr_and_or_after := by
  unfold lshr_and_or_before lshr_and_or_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_and_or
  apply lshr_and_or_thm
  ---END lshr_and_or



def lshr_and_or_disjoint_before := [llvm|
{
^0(%arg43 : i8, %arg44 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(2 : i8) : i8
  %2 = llvm.mlir.constant(13 : i8) : i8
  %3 = llvm.srem %arg43, %0 : i8
  %4 = llvm.lshr %arg44, %1 : i8
  %5 = llvm.and %4, %2 : i8
  %6 = llvm.or disjoint %3, %5 : i8
  %7 = llvm.shl %6, %1 : i8
  "llvm.return"(%7) : (i8) -> ()
}
]
def lshr_and_or_disjoint_after := [llvm|
{
^0(%arg43 : i8, %arg44 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(2 : i8) : i8
  %2 = llvm.mlir.constant(52 : i8) : i8
  %3 = llvm.srem %arg43, %0 : i8
  %4 = llvm.shl %3, %1 : i8
  %5 = llvm.and %arg44, %2 : i8
  %6 = llvm.or disjoint %5, %4 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_and_or_disjoint_proof : lshr_and_or_disjoint_before ⊑ lshr_and_or_disjoint_after := by
  unfold lshr_and_or_disjoint_before lshr_and_or_disjoint_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_and_or_disjoint
  apply lshr_and_or_disjoint_thm
  ---END lshr_and_or_disjoint



def ashr_and_or_disjoint_before := [llvm|
{
^0(%arg41 : i8, %arg42 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(2 : i8) : i8
  %2 = llvm.mlir.constant(13 : i8) : i8
  %3 = llvm.srem %arg41, %0 : i8
  %4 = llvm.ashr %arg42, %1 : i8
  %5 = llvm.and %4, %2 : i8
  %6 = llvm.or disjoint %3, %5 : i8
  %7 = llvm.shl %6, %1 : i8
  "llvm.return"(%7) : (i8) -> ()
}
]
def ashr_and_or_disjoint_after := [llvm|
{
^0(%arg41 : i8, %arg42 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(2 : i8) : i8
  %2 = llvm.mlir.constant(52 : i8) : i8
  %3 = llvm.srem %arg41, %0 : i8
  %4 = llvm.shl %3, %1 : i8
  %5 = llvm.and %arg42, %2 : i8
  %6 = llvm.or disjoint %5, %4 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_and_or_disjoint_proof : ashr_and_or_disjoint_before ⊑ ashr_and_or_disjoint_after := by
  unfold ashr_and_or_disjoint_before ashr_and_or_disjoint_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_and_or_disjoint
  apply ashr_and_or_disjoint_thm
  ---END ashr_and_or_disjoint



def lshr_and_xor_before := [llvm|
{
^0(%arg37 : i8, %arg38 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(2 : i8) : i8
  %2 = llvm.mlir.constant(13 : i8) : i8
  %3 = llvm.srem %arg37, %0 : i8
  %4 = llvm.lshr %arg38, %1 : i8
  %5 = llvm.and %4, %2 : i8
  %6 = llvm.xor %5, %3 : i8
  %7 = llvm.shl %6, %1 : i8
  "llvm.return"(%7) : (i8) -> ()
}
]
def lshr_and_xor_after := [llvm|
{
^0(%arg37 : i8, %arg38 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(2 : i8) : i8
  %2 = llvm.mlir.constant(52 : i8) : i8
  %3 = llvm.srem %arg37, %0 : i8
  %4 = llvm.shl %3, %1 : i8
  %5 = llvm.and %arg38, %2 : i8
  %6 = llvm.xor %5, %4 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_and_xor_proof : lshr_and_xor_before ⊑ lshr_and_xor_after := by
  unfold lshr_and_xor_before lshr_and_xor_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_and_xor
  apply lshr_and_xor_thm
  ---END lshr_and_xor



def lshr_add_and_shl_before := [llvm|
{
^0(%arg17 : i32, %arg18 : i32):
  %0 = llvm.mlir.constant(5 : i32) : i32
  %1 = llvm.mlir.constant(127 : i32) : i32
  %2 = llvm.lshr %arg17, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.add %arg18, %3 : i32
  %5 = llvm.shl %4, %0 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def lshr_add_and_shl_after := [llvm|
{
^0(%arg17 : i32, %arg18 : i32):
  %0 = llvm.mlir.constant(5 : i32) : i32
  %1 = llvm.mlir.constant(4064 : i32) : i32
  %2 = llvm.shl %arg18, %0 : i32
  %3 = llvm.and %arg17, %1 : i32
  %4 = llvm.add %3, %2 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_add_and_shl_proof : lshr_add_and_shl_before ⊑ lshr_add_and_shl_after := by
  unfold lshr_add_and_shl_before lshr_add_and_shl_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_add_and_shl
  apply lshr_add_and_shl_thm
  ---END lshr_add_and_shl



def shl_add_and_lshr_before := [llvm|
{
^0(%arg9 : i32, %arg10 : i32):
  %0 = llvm.mlir.constant(4 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.lshr %arg9, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.add %3, %arg10 : i32
  %5 = llvm.shl %4, %0 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def shl_add_and_lshr_after := [llvm|
{
^0(%arg9 : i32, %arg10 : i32):
  %0 = llvm.mlir.constant(4 : i32) : i32
  %1 = llvm.mlir.constant(128 : i32) : i32
  %2 = llvm.shl %arg10, %0 : i32
  %3 = llvm.and %arg9, %1 : i32
  %4 = llvm.add %3, %2 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_add_and_lshr_proof : shl_add_and_lshr_before ⊑ shl_add_and_lshr_after := by
  unfold shl_add_and_lshr_before shl_add_and_lshr_after
  simp_alive_peephole
  intros
  ---BEGIN shl_add_and_lshr
  apply shl_add_and_lshr_thm
  ---END shl_add_and_lshr


