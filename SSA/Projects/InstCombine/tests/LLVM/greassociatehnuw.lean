
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
section greassociatehnuw_statements

def reassoc_add_nuw_before := [llvm|
{
^0(%arg26 : i32):
  %0 = llvm.mlir.constant(4 : i32) : i32
  %1 = llvm.mlir.constant(64 : i32) : i32
  %2 = llvm.add %arg26, %0 overflow<nuw> : i32
  %3 = llvm.add %2, %1 overflow<nuw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def reassoc_add_nuw_after := [llvm|
{
^0(%arg26 : i32):
  %0 = llvm.mlir.constant(68 : i32) : i32
  %1 = llvm.add %arg26, %0 overflow<nuw> : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem reassoc_add_nuw_proof : reassoc_add_nuw_before ⊑ reassoc_add_nuw_after := by
  unfold reassoc_add_nuw_before reassoc_add_nuw_after
  simp_alive_peephole
  intros
  ---BEGIN reassoc_add_nuw
  all_goals (try extract_goal ; sorry)
  ---END reassoc_add_nuw



def reassoc_sub_nuw_before := [llvm|
{
^0(%arg25 : i32):
  %0 = llvm.mlir.constant(4 : i32) : i32
  %1 = llvm.mlir.constant(64 : i32) : i32
  %2 = llvm.sub %arg25, %0 overflow<nuw> : i32
  %3 = llvm.sub %2, %1 overflow<nuw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def reassoc_sub_nuw_after := [llvm|
{
^0(%arg25 : i32):
  %0 = llvm.mlir.constant(-68 : i32) : i32
  %1 = llvm.add %arg25, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem reassoc_sub_nuw_proof : reassoc_sub_nuw_before ⊑ reassoc_sub_nuw_after := by
  unfold reassoc_sub_nuw_before reassoc_sub_nuw_after
  simp_alive_peephole
  intros
  ---BEGIN reassoc_sub_nuw
  all_goals (try extract_goal ; sorry)
  ---END reassoc_sub_nuw



def reassoc_mul_nuw_before := [llvm|
{
^0(%arg24 : i32):
  %0 = llvm.mlir.constant(4 : i32) : i32
  %1 = llvm.mlir.constant(65 : i32) : i32
  %2 = llvm.mul %arg24, %0 overflow<nuw> : i32
  %3 = llvm.mul %2, %1 overflow<nuw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def reassoc_mul_nuw_after := [llvm|
{
^0(%arg24 : i32):
  %0 = llvm.mlir.constant(260 : i32) : i32
  %1 = llvm.mul %arg24, %0 overflow<nuw> : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem reassoc_mul_nuw_proof : reassoc_mul_nuw_before ⊑ reassoc_mul_nuw_after := by
  unfold reassoc_mul_nuw_before reassoc_mul_nuw_after
  simp_alive_peephole
  intros
  ---BEGIN reassoc_mul_nuw
  all_goals (try extract_goal ; sorry)
  ---END reassoc_mul_nuw



def no_reassoc_add_nuw_none_before := [llvm|
{
^0(%arg23 : i32):
  %0 = llvm.mlir.constant(4 : i32) : i32
  %1 = llvm.mlir.constant(64 : i32) : i32
  %2 = llvm.add %arg23, %0 : i32
  %3 = llvm.add %2, %1 overflow<nuw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def no_reassoc_add_nuw_none_after := [llvm|
{
^0(%arg23 : i32):
  %0 = llvm.mlir.constant(68 : i32) : i32
  %1 = llvm.add %arg23, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem no_reassoc_add_nuw_none_proof : no_reassoc_add_nuw_none_before ⊑ no_reassoc_add_nuw_none_after := by
  unfold no_reassoc_add_nuw_none_before no_reassoc_add_nuw_none_after
  simp_alive_peephole
  intros
  ---BEGIN no_reassoc_add_nuw_none
  all_goals (try extract_goal ; sorry)
  ---END no_reassoc_add_nuw_none



def no_reassoc_add_none_nuw_before := [llvm|
{
^0(%arg22 : i32):
  %0 = llvm.mlir.constant(4 : i32) : i32
  %1 = llvm.mlir.constant(64 : i32) : i32
  %2 = llvm.add %arg22, %0 overflow<nuw> : i32
  %3 = llvm.add %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def no_reassoc_add_none_nuw_after := [llvm|
{
^0(%arg22 : i32):
  %0 = llvm.mlir.constant(68 : i32) : i32
  %1 = llvm.add %arg22, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem no_reassoc_add_none_nuw_proof : no_reassoc_add_none_nuw_before ⊑ no_reassoc_add_none_nuw_after := by
  unfold no_reassoc_add_none_nuw_before no_reassoc_add_none_nuw_after
  simp_alive_peephole
  intros
  ---BEGIN no_reassoc_add_none_nuw
  all_goals (try extract_goal ; sorry)
  ---END no_reassoc_add_none_nuw



def reassoc_x2_add_nuw_before := [llvm|
{
^0(%arg20 : i32, %arg21 : i32):
  %0 = llvm.mlir.constant(4 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.add %arg20, %0 overflow<nuw> : i32
  %3 = llvm.add %arg21, %1 overflow<nuw> : i32
  %4 = llvm.add %2, %3 overflow<nuw> : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def reassoc_x2_add_nuw_after := [llvm|
{
^0(%arg20 : i32, %arg21 : i32):
  %0 = llvm.mlir.constant(12 : i32) : i32
  %1 = llvm.add %arg20, %arg21 overflow<nuw> : i32
  %2 = llvm.add %1, %0 overflow<nuw> : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem reassoc_x2_add_nuw_proof : reassoc_x2_add_nuw_before ⊑ reassoc_x2_add_nuw_after := by
  unfold reassoc_x2_add_nuw_before reassoc_x2_add_nuw_after
  simp_alive_peephole
  intros
  ---BEGIN reassoc_x2_add_nuw
  all_goals (try extract_goal ; sorry)
  ---END reassoc_x2_add_nuw



def reassoc_x2_mul_nuw_before := [llvm|
{
^0(%arg18 : i32, %arg19 : i32):
  %0 = llvm.mlir.constant(5 : i32) : i32
  %1 = llvm.mlir.constant(9 : i32) : i32
  %2 = llvm.mul %arg18, %0 overflow<nuw> : i32
  %3 = llvm.mul %arg19, %1 overflow<nuw> : i32
  %4 = llvm.mul %2, %3 overflow<nuw> : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def reassoc_x2_mul_nuw_after := [llvm|
{
^0(%arg18 : i32, %arg19 : i32):
  %0 = llvm.mlir.constant(45 : i32) : i32
  %1 = llvm.mul %arg18, %arg19 : i32
  %2 = llvm.mul %1, %0 overflow<nuw> : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem reassoc_x2_mul_nuw_proof : reassoc_x2_mul_nuw_before ⊑ reassoc_x2_mul_nuw_after := by
  unfold reassoc_x2_mul_nuw_before reassoc_x2_mul_nuw_after
  simp_alive_peephole
  intros
  ---BEGIN reassoc_x2_mul_nuw
  all_goals (try extract_goal ; sorry)
  ---END reassoc_x2_mul_nuw



def reassoc_x2_sub_nuw_before := [llvm|
{
^0(%arg16 : i32, %arg17 : i32):
  %0 = llvm.mlir.constant(4 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.sub %arg16, %0 overflow<nuw> : i32
  %3 = llvm.sub %arg17, %1 overflow<nuw> : i32
  %4 = llvm.sub %2, %3 overflow<nuw> : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def reassoc_x2_sub_nuw_after := [llvm|
{
^0(%arg16 : i32, %arg17 : i32):
  %0 = llvm.mlir.constant(4 : i32) : i32
  %1 = llvm.sub %arg16, %arg17 : i32
  %2 = llvm.add %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem reassoc_x2_sub_nuw_proof : reassoc_x2_sub_nuw_before ⊑ reassoc_x2_sub_nuw_after := by
  unfold reassoc_x2_sub_nuw_before reassoc_x2_sub_nuw_after
  simp_alive_peephole
  intros
  ---BEGIN reassoc_x2_sub_nuw
  all_goals (try extract_goal ; sorry)
  ---END reassoc_x2_sub_nuw



def tryFactorization_add_nuw_mul_nuw_before := [llvm|
{
^0(%arg15 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.mul %arg15, %0 overflow<nuw> : i32
  %2 = llvm.add %1, %arg15 overflow<nuw> : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def tryFactorization_add_nuw_mul_nuw_after := [llvm|
{
^0(%arg15 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.shl %arg15, %0 overflow<nuw> : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem tryFactorization_add_nuw_mul_nuw_proof : tryFactorization_add_nuw_mul_nuw_before ⊑ tryFactorization_add_nuw_mul_nuw_after := by
  unfold tryFactorization_add_nuw_mul_nuw_before tryFactorization_add_nuw_mul_nuw_after
  simp_alive_peephole
  intros
  ---BEGIN tryFactorization_add_nuw_mul_nuw
  all_goals (try extract_goal ; sorry)
  ---END tryFactorization_add_nuw_mul_nuw



def tryFactorization_add_nuw_mul_nuw_int_max_before := [llvm|
{
^0(%arg14 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.mul %arg14, %0 overflow<nuw> : i32
  %2 = llvm.add %1, %arg14 overflow<nuw> : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def tryFactorization_add_nuw_mul_nuw_int_max_after := [llvm|
{
^0(%arg14 : i32):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.shl %arg14, %0 overflow<nuw> : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem tryFactorization_add_nuw_mul_nuw_int_max_proof : tryFactorization_add_nuw_mul_nuw_int_max_before ⊑ tryFactorization_add_nuw_mul_nuw_int_max_after := by
  unfold tryFactorization_add_nuw_mul_nuw_int_max_before tryFactorization_add_nuw_mul_nuw_int_max_after
  simp_alive_peephole
  intros
  ---BEGIN tryFactorization_add_nuw_mul_nuw_int_max
  all_goals (try extract_goal ; sorry)
  ---END tryFactorization_add_nuw_mul_nuw_int_max



def tryFactorization_add_mul_nuw_before := [llvm|
{
^0(%arg13 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.mul %arg13, %0 : i32
  %2 = llvm.add %1, %arg13 overflow<nuw> : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def tryFactorization_add_mul_nuw_after := [llvm|
{
^0(%arg13 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.shl %arg13, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem tryFactorization_add_mul_nuw_proof : tryFactorization_add_mul_nuw_before ⊑ tryFactorization_add_mul_nuw_after := by
  unfold tryFactorization_add_mul_nuw_before tryFactorization_add_mul_nuw_after
  simp_alive_peephole
  intros
  ---BEGIN tryFactorization_add_mul_nuw
  all_goals (try extract_goal ; sorry)
  ---END tryFactorization_add_mul_nuw



def tryFactorization_add_nuw_mul_before := [llvm|
{
^0(%arg12 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.mul %arg12, %0 overflow<nuw> : i32
  %2 = llvm.add %1, %arg12 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def tryFactorization_add_nuw_mul_after := [llvm|
{
^0(%arg12 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.shl %arg12, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem tryFactorization_add_nuw_mul_proof : tryFactorization_add_nuw_mul_before ⊑ tryFactorization_add_nuw_mul_after := by
  unfold tryFactorization_add_nuw_mul_before tryFactorization_add_nuw_mul_after
  simp_alive_peephole
  intros
  ---BEGIN tryFactorization_add_nuw_mul
  all_goals (try extract_goal ; sorry)
  ---END tryFactorization_add_nuw_mul



def tryFactorization_add_nuw_mul_nuw_mul_nuw_var_before := [llvm|
{
^0(%arg9 : i32, %arg10 : i32, %arg11 : i32):
  %0 = llvm.mul %arg9, %arg10 overflow<nuw> : i32
  %1 = llvm.mul %arg9, %arg11 overflow<nuw> : i32
  %2 = llvm.add %0, %1 overflow<nuw> : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def tryFactorization_add_nuw_mul_nuw_mul_nuw_var_after := [llvm|
{
^0(%arg9 : i32, %arg10 : i32, %arg11 : i32):
  %0 = llvm.add %arg10, %arg11 : i32
  %1 = llvm.mul %arg9, %0 overflow<nuw> : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem tryFactorization_add_nuw_mul_nuw_mul_nuw_var_proof : tryFactorization_add_nuw_mul_nuw_mul_nuw_var_before ⊑ tryFactorization_add_nuw_mul_nuw_mul_nuw_var_after := by
  unfold tryFactorization_add_nuw_mul_nuw_mul_nuw_var_before tryFactorization_add_nuw_mul_nuw_mul_nuw_var_after
  simp_alive_peephole
  intros
  ---BEGIN tryFactorization_add_nuw_mul_nuw_mul_nuw_var
  all_goals (try extract_goal ; sorry)
  ---END tryFactorization_add_nuw_mul_nuw_mul_nuw_var



def tryFactorization_add_nuw_mul_mul_nuw_var_before := [llvm|
{
^0(%arg6 : i32, %arg7 : i32, %arg8 : i32):
  %0 = llvm.mul %arg6, %arg7 : i32
  %1 = llvm.mul %arg6, %arg8 overflow<nuw> : i32
  %2 = llvm.add %0, %1 overflow<nuw> : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def tryFactorization_add_nuw_mul_mul_nuw_var_after := [llvm|
{
^0(%arg6 : i32, %arg7 : i32, %arg8 : i32):
  %0 = llvm.add %arg7, %arg8 : i32
  %1 = llvm.mul %arg6, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem tryFactorization_add_nuw_mul_mul_nuw_var_proof : tryFactorization_add_nuw_mul_mul_nuw_var_before ⊑ tryFactorization_add_nuw_mul_mul_nuw_var_after := by
  unfold tryFactorization_add_nuw_mul_mul_nuw_var_before tryFactorization_add_nuw_mul_mul_nuw_var_after
  simp_alive_peephole
  intros
  ---BEGIN tryFactorization_add_nuw_mul_mul_nuw_var
  all_goals (try extract_goal ; sorry)
  ---END tryFactorization_add_nuw_mul_mul_nuw_var



def tryFactorization_add_nuw_mul_nuw_mul_var_before := [llvm|
{
^0(%arg3 : i32, %arg4 : i32, %arg5 : i32):
  %0 = llvm.mul %arg3, %arg4 overflow<nuw> : i32
  %1 = llvm.mul %arg3, %arg5 : i32
  %2 = llvm.add %0, %1 overflow<nuw> : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def tryFactorization_add_nuw_mul_nuw_mul_var_after := [llvm|
{
^0(%arg3 : i32, %arg4 : i32, %arg5 : i32):
  %0 = llvm.add %arg4, %arg5 : i32
  %1 = llvm.mul %arg3, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem tryFactorization_add_nuw_mul_nuw_mul_var_proof : tryFactorization_add_nuw_mul_nuw_mul_var_before ⊑ tryFactorization_add_nuw_mul_nuw_mul_var_after := by
  unfold tryFactorization_add_nuw_mul_nuw_mul_var_before tryFactorization_add_nuw_mul_nuw_mul_var_after
  simp_alive_peephole
  intros
  ---BEGIN tryFactorization_add_nuw_mul_nuw_mul_var
  all_goals (try extract_goal ; sorry)
  ---END tryFactorization_add_nuw_mul_nuw_mul_var



def tryFactorization_add_mul_nuw_mul_var_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = llvm.mul %arg0, %arg1 overflow<nuw> : i32
  %1 = llvm.mul %arg0, %arg2 overflow<nuw> : i32
  %2 = llvm.add %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def tryFactorization_add_mul_nuw_mul_var_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = llvm.add %arg1, %arg2 : i32
  %1 = llvm.mul %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem tryFactorization_add_mul_nuw_mul_var_proof : tryFactorization_add_mul_nuw_mul_var_before ⊑ tryFactorization_add_mul_nuw_mul_var_after := by
  unfold tryFactorization_add_mul_nuw_mul_var_before tryFactorization_add_mul_nuw_mul_var_after
  simp_alive_peephole
  intros
  ---BEGIN tryFactorization_add_mul_nuw_mul_var
  all_goals (try extract_goal ; sorry)
  ---END tryFactorization_add_mul_nuw_mul_var


