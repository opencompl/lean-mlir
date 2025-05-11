
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
section gshifthshift_statements

def shl_shl_before := [llvm|
{
^0(%arg50 : i32):
  %0 = llvm.mlir.constant(6 : i32) : i32
  %1 = llvm.mlir.constant(28 : i32) : i32
  %2 = llvm.shl %arg50, %0 : i32
  %3 = llvm.shl %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def shl_shl_after := [llvm|
{
^0(%arg50 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_shl_proof : shl_shl_before ⊑ shl_shl_after := by
  unfold shl_shl_before shl_shl_after
  simp_alive_peephole
  intros
  ---BEGIN shl_shl
  all_goals (try extract_goal ; sorry)
  ---END shl_shl



def lshr_lshr_before := [llvm|
{
^0(%arg47 : i232):
  %0 = llvm.mlir.constant(231 : i232) : i232
  %1 = llvm.mlir.constant(1 : i232) : i232
  %2 = llvm.lshr %arg47, %0 : i232
  %3 = llvm.lshr %2, %1 : i232
  "llvm.return"(%3) : (i232) -> ()
}
]
def lshr_lshr_after := [llvm|
{
^0(%arg47 : i232):
  %0 = llvm.mlir.constant(0 : i232) : i232
  "llvm.return"(%0) : (i232) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_lshr_proof : lshr_lshr_before ⊑ lshr_lshr_after := by
  unfold lshr_lshr_before lshr_lshr_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_lshr
  all_goals (try extract_goal ; sorry)
  ---END lshr_lshr



def shl_trunc_bigger_lshr_before := [llvm|
{
^0(%arg44 : i32):
  %0 = llvm.mlir.constant(5 : i32) : i32
  %1 = llvm.mlir.constant(3 : i8) : i8
  %2 = llvm.lshr %arg44, %0 : i32
  %3 = llvm.trunc %2 : i32 to i8
  %4 = llvm.shl %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def shl_trunc_bigger_lshr_after := [llvm|
{
^0(%arg44 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(-8 : i8) : i8
  %2 = llvm.lshr %arg44, %0 : i32
  %3 = llvm.trunc %2 : i32 to i8
  %4 = llvm.and %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_trunc_bigger_lshr_proof : shl_trunc_bigger_lshr_before ⊑ shl_trunc_bigger_lshr_after := by
  unfold shl_trunc_bigger_lshr_before shl_trunc_bigger_lshr_after
  simp_alive_peephole
  intros
  ---BEGIN shl_trunc_bigger_lshr
  all_goals (try extract_goal ; sorry)
  ---END shl_trunc_bigger_lshr



def shl_trunc_smaller_lshr_before := [llvm|
{
^0(%arg43 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.mlir.constant(5 : i8) : i8
  %2 = llvm.lshr %arg43, %0 : i32
  %3 = llvm.trunc %2 : i32 to i8
  %4 = llvm.shl %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def shl_trunc_smaller_lshr_after := [llvm|
{
^0(%arg43 : i32):
  %0 = llvm.mlir.constant(2 : i8) : i8
  %1 = llvm.mlir.constant(-32 : i8) : i8
  %2 = llvm.trunc %arg43 : i32 to i8
  %3 = llvm.shl %2, %0 : i8
  %4 = llvm.and %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_trunc_smaller_lshr_proof : shl_trunc_smaller_lshr_before ⊑ shl_trunc_smaller_lshr_after := by
  unfold shl_trunc_smaller_lshr_before shl_trunc_smaller_lshr_after
  simp_alive_peephole
  intros
  ---BEGIN shl_trunc_smaller_lshr
  all_goals (try extract_goal ; sorry)
  ---END shl_trunc_smaller_lshr



def shl_trunc_bigger_ashr_before := [llvm|
{
^0(%arg42 : i32):
  %0 = llvm.mlir.constant(12 : i32) : i32
  %1 = llvm.mlir.constant(3 : i24) : i24
  %2 = llvm.ashr %arg42, %0 : i32
  %3 = llvm.trunc %2 : i32 to i24
  %4 = llvm.shl %3, %1 : i24
  "llvm.return"(%4) : (i24) -> ()
}
]
def shl_trunc_bigger_ashr_after := [llvm|
{
^0(%arg42 : i32):
  %0 = llvm.mlir.constant(9 : i32) : i32
  %1 = llvm.mlir.constant(-8 : i24) : i24
  %2 = llvm.ashr %arg42, %0 : i32
  %3 = llvm.trunc %2 overflow<nsw> : i32 to i24
  %4 = llvm.and %3, %1 : i24
  "llvm.return"(%4) : (i24) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_trunc_bigger_ashr_proof : shl_trunc_bigger_ashr_before ⊑ shl_trunc_bigger_ashr_after := by
  unfold shl_trunc_bigger_ashr_before shl_trunc_bigger_ashr_after
  simp_alive_peephole
  intros
  ---BEGIN shl_trunc_bigger_ashr
  all_goals (try extract_goal ; sorry)
  ---END shl_trunc_bigger_ashr



def shl_trunc_smaller_ashr_before := [llvm|
{
^0(%arg41 : i32):
  %0 = llvm.mlir.constant(10 : i32) : i32
  %1 = llvm.mlir.constant(13 : i24) : i24
  %2 = llvm.ashr %arg41, %0 : i32
  %3 = llvm.trunc %2 : i32 to i24
  %4 = llvm.shl %3, %1 : i24
  "llvm.return"(%4) : (i24) -> ()
}
]
def shl_trunc_smaller_ashr_after := [llvm|
{
^0(%arg41 : i32):
  %0 = llvm.mlir.constant(3 : i24) : i24
  %1 = llvm.mlir.constant(-8192 : i24) : i24
  %2 = llvm.trunc %arg41 : i32 to i24
  %3 = llvm.shl %2, %0 : i24
  %4 = llvm.and %3, %1 : i24
  "llvm.return"(%4) : (i24) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_trunc_smaller_ashr_proof : shl_trunc_smaller_ashr_before ⊑ shl_trunc_smaller_ashr_after := by
  unfold shl_trunc_smaller_ashr_before shl_trunc_smaller_ashr_after
  simp_alive_peephole
  intros
  ---BEGIN shl_trunc_smaller_ashr
  all_goals (try extract_goal ; sorry)
  ---END shl_trunc_smaller_ashr



def shl_trunc_bigger_shl_before := [llvm|
{
^0(%arg40 : i32):
  %0 = llvm.mlir.constant(4 : i32) : i32
  %1 = llvm.mlir.constant(2 : i8) : i8
  %2 = llvm.shl %arg40, %0 : i32
  %3 = llvm.trunc %2 : i32 to i8
  %4 = llvm.shl %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def shl_trunc_bigger_shl_after := [llvm|
{
^0(%arg40 : i32):
  %0 = llvm.mlir.constant(6 : i8) : i8
  %1 = llvm.trunc %arg40 : i32 to i8
  %2 = llvm.shl %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_trunc_bigger_shl_proof : shl_trunc_bigger_shl_before ⊑ shl_trunc_bigger_shl_after := by
  unfold shl_trunc_bigger_shl_before shl_trunc_bigger_shl_after
  simp_alive_peephole
  intros
  ---BEGIN shl_trunc_bigger_shl
  all_goals (try extract_goal ; sorry)
  ---END shl_trunc_bigger_shl



def shl_trunc_smaller_shl_before := [llvm|
{
^0(%arg39 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(4 : i8) : i8
  %2 = llvm.shl %arg39, %0 : i32
  %3 = llvm.trunc %2 : i32 to i8
  %4 = llvm.shl %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def shl_trunc_smaller_shl_after := [llvm|
{
^0(%arg39 : i32):
  %0 = llvm.mlir.constant(6 : i8) : i8
  %1 = llvm.trunc %arg39 : i32 to i8
  %2 = llvm.shl %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_trunc_smaller_shl_proof : shl_trunc_smaller_shl_before ⊑ shl_trunc_smaller_shl_after := by
  unfold shl_trunc_smaller_shl_before shl_trunc_smaller_shl_after
  simp_alive_peephole
  intros
  ---BEGIN shl_trunc_smaller_shl
  all_goals (try extract_goal ; sorry)
  ---END shl_trunc_smaller_shl



def shl_shl_constants_div_before := [llvm|
{
^0(%arg27 : i32, %arg28 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.shl %0, %arg28 : i32
  %3 = llvm.shl %2, %1 : i32
  %4 = llvm.udiv %arg27, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def shl_shl_constants_div_after := [llvm|
{
^0(%arg27 : i32, %arg28 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.add %arg28, %0 : i32
  %2 = llvm.lshr %arg27, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_shl_constants_div_proof : shl_shl_constants_div_before ⊑ shl_shl_constants_div_after := by
  unfold shl_shl_constants_div_before shl_shl_constants_div_after
  simp_alive_peephole
  intros
  ---BEGIN shl_shl_constants_div
  all_goals (try extract_goal ; sorry)
  ---END shl_shl_constants_div



def ashr_shl_constants_before := [llvm|
{
^0(%arg25 : i32):
  %0 = llvm.mlir.constant(-33 : i32) : i32
  %1 = llvm.mlir.constant(3 : i32) : i32
  %2 = llvm.ashr %0, %arg25 : i32
  %3 = llvm.shl %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def ashr_shl_constants_after := [llvm|
{
^0(%arg25 : i32):
  %0 = llvm.mlir.constant(-33 : i32) : i32
  %1 = llvm.mlir.constant(3 : i32) : i32
  %2 = llvm.ashr %0, %arg25 : i32
  %3 = llvm.shl %2, %1 overflow<nsw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_shl_constants_proof : ashr_shl_constants_before ⊑ ashr_shl_constants_after := by
  unfold ashr_shl_constants_before ashr_shl_constants_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_shl_constants
  all_goals (try extract_goal ; sorry)
  ---END ashr_shl_constants



def shl_lshr_demand1_before := [llvm|
{
^0(%arg20 : i8):
  %0 = llvm.mlir.constant(40 : i8) : i8
  %1 = llvm.mlir.constant(3 : i8) : i8
  %2 = llvm.mlir.constant(-32 : i8) : i8
  %3 = llvm.shl %0, %arg20 : i8
  %4 = llvm.lshr %3, %1 : i8
  %5 = llvm.or %4, %2 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def shl_lshr_demand1_after := [llvm|
{
^0(%arg20 : i8):
  %0 = llvm.mlir.constant(5 : i8) : i8
  %1 = llvm.mlir.constant(-32 : i8) : i8
  %2 = llvm.shl %0, %arg20 : i8
  %3 = llvm.or %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_lshr_demand1_proof : shl_lshr_demand1_before ⊑ shl_lshr_demand1_after := by
  unfold shl_lshr_demand1_before shl_lshr_demand1_after
  simp_alive_peephole
  intros
  ---BEGIN shl_lshr_demand1
  all_goals (try extract_goal ; sorry)
  ---END shl_lshr_demand1



def shl_lshr_demand3_before := [llvm|
{
^0(%arg18 : i8):
  %0 = llvm.mlir.constant(40 : i8) : i8
  %1 = llvm.mlir.constant(3 : i8) : i8
  %2 = llvm.mlir.constant(-64 : i8) : i8
  %3 = llvm.shl %0, %arg18 : i8
  %4 = llvm.lshr %3, %1 : i8
  %5 = llvm.or %4, %2 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def shl_lshr_demand3_after := [llvm|
{
^0(%arg18 : i8):
  %0 = llvm.mlir.constant(40 : i8) : i8
  %1 = llvm.mlir.constant(3 : i8) : i8
  %2 = llvm.mlir.constant(-64 : i8) : i8
  %3 = llvm.shl %0, %arg18 : i8
  %4 = llvm.lshr exact %3, %1 : i8
  %5 = llvm.or disjoint %4, %2 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_lshr_demand3_proof : shl_lshr_demand3_before ⊑ shl_lshr_demand3_after := by
  unfold shl_lshr_demand3_before shl_lshr_demand3_after
  simp_alive_peephole
  intros
  ---BEGIN shl_lshr_demand3
  all_goals (try extract_goal ; sorry)
  ---END shl_lshr_demand3



def shl_lshr_demand4_before := [llvm|
{
^0(%arg17 : i8):
  %0 = llvm.mlir.constant(44 : i8) : i8
  %1 = llvm.mlir.constant(3 : i8) : i8
  %2 = llvm.mlir.constant(-32 : i8) : i8
  %3 = llvm.shl %0, %arg17 : i8
  %4 = llvm.lshr %3, %1 : i8
  %5 = llvm.or %4, %2 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def shl_lshr_demand4_after := [llvm|
{
^0(%arg17 : i8):
  %0 = llvm.mlir.constant(44 : i8) : i8
  %1 = llvm.mlir.constant(3 : i8) : i8
  %2 = llvm.mlir.constant(-32 : i8) : i8
  %3 = llvm.shl %0, %arg17 : i8
  %4 = llvm.lshr %3, %1 : i8
  %5 = llvm.or disjoint %4, %2 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_lshr_demand4_proof : shl_lshr_demand4_before ⊑ shl_lshr_demand4_after := by
  unfold shl_lshr_demand4_before shl_lshr_demand4_after
  simp_alive_peephole
  intros
  ---BEGIN shl_lshr_demand4
  all_goals (try extract_goal ; sorry)
  ---END shl_lshr_demand4



def shl_lshr_demand6_before := [llvm|
{
^0(%arg10 : i16):
  %0 = llvm.mlir.constant(-32624 : i16) : i16
  %1 = llvm.mlir.constant(4 : i16) : i16
  %2 = llvm.mlir.constant(4094 : i16) : i16
  %3 = llvm.shl %0, %arg10 : i16
  %4 = llvm.lshr %3, %1 : i16
  %5 = llvm.and %4, %2 : i16
  "llvm.return"(%5) : (i16) -> ()
}
]
def shl_lshr_demand6_after := [llvm|
{
^0(%arg10 : i16):
  %0 = llvm.mlir.constant(2057 : i16) : i16
  %1 = llvm.mlir.constant(4094 : i16) : i16
  %2 = llvm.shl %0, %arg10 : i16
  %3 = llvm.and %2, %1 : i16
  "llvm.return"(%3) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_lshr_demand6_proof : shl_lshr_demand6_before ⊑ shl_lshr_demand6_after := by
  unfold shl_lshr_demand6_before shl_lshr_demand6_after
  simp_alive_peephole
  intros
  ---BEGIN shl_lshr_demand6
  all_goals (try extract_goal ; sorry)
  ---END shl_lshr_demand6



def lshr_shl_demand1_before := [llvm|
{
^0(%arg9 : i8):
  %0 = llvm.mlir.constant(28 : i8) : i8
  %1 = llvm.mlir.constant(3 : i8) : i8
  %2 = llvm.mlir.constant(7 : i8) : i8
  %3 = llvm.lshr %0, %arg9 : i8
  %4 = llvm.shl %3, %1 : i8
  %5 = llvm.or %4, %2 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def lshr_shl_demand1_after := [llvm|
{
^0(%arg9 : i8):
  %0 = llvm.mlir.constant(-32 : i8) : i8
  %1 = llvm.mlir.constant(7 : i8) : i8
  %2 = llvm.lshr %0, %arg9 : i8
  %3 = llvm.or %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_shl_demand1_proof : lshr_shl_demand1_before ⊑ lshr_shl_demand1_after := by
  unfold lshr_shl_demand1_before lshr_shl_demand1_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_shl_demand1
  all_goals (try extract_goal ; sorry)
  ---END lshr_shl_demand1



def lshr_shl_demand3_before := [llvm|
{
^0(%arg7 : i8):
  %0 = llvm.mlir.constant(28 : i8) : i8
  %1 = llvm.mlir.constant(3 : i8) : i8
  %2 = llvm.lshr %0, %arg7 : i8
  %3 = llvm.shl %2, %1 : i8
  %4 = llvm.or %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def lshr_shl_demand3_after := [llvm|
{
^0(%arg7 : i8):
  %0 = llvm.mlir.constant(28 : i8) : i8
  %1 = llvm.mlir.constant(3 : i8) : i8
  %2 = llvm.lshr %0, %arg7 : i8
  %3 = llvm.shl %2, %1 overflow<nuw> : i8
  %4 = llvm.or disjoint %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_shl_demand3_proof : lshr_shl_demand3_before ⊑ lshr_shl_demand3_after := by
  unfold lshr_shl_demand3_before lshr_shl_demand3_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_shl_demand3
  all_goals (try extract_goal ; sorry)
  ---END lshr_shl_demand3



def lshr_shl_demand4_before := [llvm|
{
^0(%arg6 : i8):
  %0 = llvm.mlir.constant(60 : i8) : i8
  %1 = llvm.mlir.constant(3 : i8) : i8
  %2 = llvm.mlir.constant(7 : i8) : i8
  %3 = llvm.lshr %0, %arg6 : i8
  %4 = llvm.shl %3, %1 : i8
  %5 = llvm.or %4, %2 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def lshr_shl_demand4_after := [llvm|
{
^0(%arg6 : i8):
  %0 = llvm.mlir.constant(60 : i8) : i8
  %1 = llvm.mlir.constant(3 : i8) : i8
  %2 = llvm.mlir.constant(7 : i8) : i8
  %3 = llvm.lshr %0, %arg6 : i8
  %4 = llvm.shl %3, %1 : i8
  %5 = llvm.or disjoint %4, %2 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_shl_demand4_proof : lshr_shl_demand4_before ⊑ lshr_shl_demand4_after := by
  unfold lshr_shl_demand4_before lshr_shl_demand4_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_shl_demand4
  all_goals (try extract_goal ; sorry)
  ---END lshr_shl_demand4


