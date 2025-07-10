import SSA.Projects.InstCombine.tests.proofs.gandhor_proof
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
section gandhor_statements

def or_and_not_constant_commute0_before := [llvm|
{
^0(%arg112 : i32, %arg113 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-2 : i32) : i32
  %2 = llvm.or %arg113, %arg112 : i32
  %3 = llvm.and %2, %0 : i32
  %4 = llvm.and %arg113, %1 : i32
  %5 = llvm.or %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def or_and_not_constant_commute0_after := [llvm|
{
^0(%arg112 : i32, %arg113 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.and %arg112, %0 : i32
  %2 = llvm.or %1, %arg113 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_and_not_constant_commute0_proof : or_and_not_constant_commute0_before ⊑ or_and_not_constant_commute0_after := by
  unfold or_and_not_constant_commute0_before or_and_not_constant_commute0_after
  simp_alive_peephole
  intros
  ---BEGIN or_and_not_constant_commute0
  apply or_and_not_constant_commute0_thm
  ---END or_and_not_constant_commute0



def or_and_not_constant_commute1_before := [llvm|
{
^0(%arg110 : i32, %arg111 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-2 : i32) : i32
  %2 = llvm.or %arg110, %arg111 : i32
  %3 = llvm.and %0, %2 : i32
  %4 = llvm.and %1, %arg111 : i32
  %5 = llvm.or %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def or_and_not_constant_commute1_after := [llvm|
{
^0(%arg110 : i32, %arg111 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.and %arg110, %0 : i32
  %2 = llvm.or %1, %arg111 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_and_not_constant_commute1_proof : or_and_not_constant_commute1_before ⊑ or_and_not_constant_commute1_after := by
  unfold or_and_not_constant_commute1_before or_and_not_constant_commute1_after
  simp_alive_peephole
  intros
  ---BEGIN or_and_not_constant_commute1
  apply or_and_not_constant_commute1_thm
  ---END or_and_not_constant_commute1



def or_and_not_constant_commute2_before := [llvm|
{
^0(%arg108 : i32, %arg109 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-2 : i32) : i32
  %2 = llvm.or %arg109, %arg108 : i32
  %3 = llvm.and %2, %0 : i32
  %4 = llvm.and %arg109, %1 : i32
  %5 = llvm.or %4, %3 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def or_and_not_constant_commute2_after := [llvm|
{
^0(%arg108 : i32, %arg109 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.and %arg108, %0 : i32
  %2 = llvm.or %1, %arg109 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_and_not_constant_commute2_proof : or_and_not_constant_commute2_before ⊑ or_and_not_constant_commute2_after := by
  unfold or_and_not_constant_commute2_before or_and_not_constant_commute2_after
  simp_alive_peephole
  intros
  ---BEGIN or_and_not_constant_commute2
  apply or_and_not_constant_commute2_thm
  ---END or_and_not_constant_commute2



def or_and_not_constant_commute3_before := [llvm|
{
^0(%arg106 : i32, %arg107 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-2 : i32) : i32
  %2 = llvm.or %arg106, %arg107 : i32
  %3 = llvm.and %0, %2 : i32
  %4 = llvm.and %1, %arg107 : i32
  %5 = llvm.or %4, %3 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def or_and_not_constant_commute3_after := [llvm|
{
^0(%arg106 : i32, %arg107 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.and %arg106, %0 : i32
  %2 = llvm.or %1, %arg107 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_and_not_constant_commute3_proof : or_and_not_constant_commute3_before ⊑ or_and_not_constant_commute3_after := by
  unfold or_and_not_constant_commute3_before or_and_not_constant_commute3_after
  simp_alive_peephole
  intros
  ---BEGIN or_and_not_constant_commute3
  apply or_and_not_constant_commute3_thm
  ---END or_and_not_constant_commute3



def and_or_hoist_mask_before := [llvm|
{
^0(%arg91 : i8, %arg92 : i8):
  %0 = llvm.mlir.constant(6 : i8) : i8
  %1 = llvm.mlir.constant(3 : i8) : i8
  %2 = llvm.lshr %arg91, %0 : i8
  %3 = llvm.or %2, %arg92 : i8
  %4 = llvm.and %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def and_or_hoist_mask_after := [llvm|
{
^0(%arg91 : i8, %arg92 : i8):
  %0 = llvm.mlir.constant(6 : i8) : i8
  %1 = llvm.mlir.constant(3 : i8) : i8
  %2 = llvm.lshr %arg91, %0 : i8
  %3 = llvm.and %arg92, %1 : i8
  %4 = llvm.or %2, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_or_hoist_mask_proof : and_or_hoist_mask_before ⊑ and_or_hoist_mask_after := by
  unfold and_or_hoist_mask_before and_or_hoist_mask_after
  simp_alive_peephole
  intros
  ---BEGIN and_or_hoist_mask
  apply and_or_hoist_mask_thm
  ---END and_or_hoist_mask



def and_xor_hoist_mask_commute_before := [llvm|
{
^0(%arg87 : i8, %arg88 : i8):
  %0 = llvm.mlir.constant(43 : i8) : i8
  %1 = llvm.mlir.constant(6 : i8) : i8
  %2 = llvm.mlir.constant(3 : i8) : i8
  %3 = llvm.mul %arg88, %0 : i8
  %4 = llvm.lshr %arg87, %1 : i8
  %5 = llvm.xor %3, %4 : i8
  %6 = llvm.and %5, %2 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def and_xor_hoist_mask_commute_after := [llvm|
{
^0(%arg87 : i8, %arg88 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(6 : i8) : i8
  %2 = llvm.mul %arg88, %0 : i8
  %3 = llvm.lshr %arg87, %1 : i8
  %4 = llvm.and %2, %0 : i8
  %5 = llvm.xor %4, %3 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_xor_hoist_mask_commute_proof : and_xor_hoist_mask_commute_before ⊑ and_xor_hoist_mask_commute_after := by
  unfold and_xor_hoist_mask_commute_before and_xor_hoist_mask_commute_after
  simp_alive_peephole
  intros
  ---BEGIN and_xor_hoist_mask_commute
  apply and_xor_hoist_mask_commute_thm
  ---END and_xor_hoist_mask_commute



def or_or_and_complex_before := [llvm|
{
^0(%arg82 : i64):
  %0 = llvm.mlir.constant(8) : i64
  %1 = llvm.mlir.constant(71776119061217280) : i64
  %2 = llvm.mlir.constant(-72057594037927936) : i64
  %3 = llvm.mlir.constant(1095216660480) : i64
  %4 = llvm.mlir.constant(280375465082880) : i64
  %5 = llvm.mlir.constant(16711680) : i64
  %6 = llvm.mlir.constant(4278190080) : i64
  %7 = llvm.mlir.constant(255) : i64
  %8 = llvm.mlir.constant(65280) : i64
  %9 = llvm.lshr %arg82, %0 : i64
  %10 = llvm.and %9, %1 : i64
  %11 = llvm.shl %arg82, %0 : i64
  %12 = llvm.and %11, %2 : i64
  %13 = llvm.or %10, %12 : i64
  %14 = llvm.and %9, %3 : i64
  %15 = llvm.or %13, %14 : i64
  %16 = llvm.and %11, %4 : i64
  %17 = llvm.or %15, %16 : i64
  %18 = llvm.and %9, %5 : i64
  %19 = llvm.or %17, %18 : i64
  %20 = llvm.and %11, %6 : i64
  %21 = llvm.or %19, %20 : i64
  %22 = llvm.and %9, %7 : i64
  %23 = llvm.or %21, %22 : i64
  %24 = llvm.and %11, %8 : i64
  %25 = llvm.or %23, %24 : i64
  "llvm.return"(%25) : (i64) -> ()
}
]
def or_or_and_complex_after := [llvm|
{
^0(%arg82 : i64):
  %0 = llvm.mlir.constant(8) : i64
  %1 = llvm.mlir.constant(71777214294589695) : i64
  %2 = llvm.mlir.constant(-71777214294589696) : i64
  %3 = llvm.lshr %arg82, %0 : i64
  %4 = llvm.shl %arg82, %0 : i64
  %5 = llvm.and %3, %1 : i64
  %6 = llvm.and %4, %2 : i64
  %7 = llvm.or disjoint %5, %6 : i64
  "llvm.return"(%7) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_or_and_complex_proof : or_or_and_complex_before ⊑ or_or_and_complex_after := by
  unfold or_or_and_complex_before or_or_and_complex_after
  simp_alive_peephole
  intros
  ---BEGIN or_or_and_complex
  apply or_or_and_complex_thm
  ---END or_or_and_complex



def or_or_and_pat1_before := [llvm|
{
^0(%arg74 : i8, %arg75 : i8, %arg76 : i8, %arg77 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.udiv %0, %arg76 : i8
  %2 = llvm.and %arg74, %arg75 : i8
  %3 = llvm.and %arg74, %arg77 : i8
  %4 = llvm.or %1, %3 : i8
  %5 = llvm.or %4, %2 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def or_or_and_pat1_after := [llvm|
{
^0(%arg74 : i8, %arg75 : i8, %arg76 : i8, %arg77 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.udiv %0, %arg76 : i8
  %2 = llvm.or %arg77, %arg75 : i8
  %3 = llvm.and %arg74, %2 : i8
  %4 = llvm.or %1, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_or_and_pat1_proof : or_or_and_pat1_before ⊑ or_or_and_pat1_after := by
  unfold or_or_and_pat1_before or_or_and_pat1_after
  simp_alive_peephole
  intros
  ---BEGIN or_or_and_pat1
  apply or_or_and_pat1_thm
  ---END or_or_and_pat1



def or_or_and_pat2_before := [llvm|
{
^0(%arg70 : i8, %arg71 : i8, %arg72 : i8, %arg73 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.udiv %0, %arg72 : i8
  %2 = llvm.and %arg70, %arg71 : i8
  %3 = llvm.and %arg73, %arg70 : i8
  %4 = llvm.or %1, %3 : i8
  %5 = llvm.or %4, %2 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def or_or_and_pat2_after := [llvm|
{
^0(%arg70 : i8, %arg71 : i8, %arg72 : i8, %arg73 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.udiv %0, %arg72 : i8
  %2 = llvm.or %arg73, %arg71 : i8
  %3 = llvm.and %2, %arg70 : i8
  %4 = llvm.or %1, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_or_and_pat2_proof : or_or_and_pat2_before ⊑ or_or_and_pat2_after := by
  unfold or_or_and_pat2_before or_or_and_pat2_after
  simp_alive_peephole
  intros
  ---BEGIN or_or_and_pat2
  apply or_or_and_pat2_thm
  ---END or_or_and_pat2



def or_or_and_pat3_before := [llvm|
{
^0(%arg66 : i8, %arg67 : i8, %arg68 : i8, %arg69 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.udiv %0, %arg68 : i8
  %2 = llvm.and %arg66, %arg67 : i8
  %3 = llvm.and %arg67, %arg69 : i8
  %4 = llvm.or %1, %3 : i8
  %5 = llvm.or %4, %2 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def or_or_and_pat3_after := [llvm|
{
^0(%arg66 : i8, %arg67 : i8, %arg68 : i8, %arg69 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.udiv %0, %arg68 : i8
  %2 = llvm.or %arg69, %arg66 : i8
  %3 = llvm.and %arg67, %2 : i8
  %4 = llvm.or %1, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_or_and_pat3_proof : or_or_and_pat3_before ⊑ or_or_and_pat3_after := by
  unfold or_or_and_pat3_before or_or_and_pat3_after
  simp_alive_peephole
  intros
  ---BEGIN or_or_and_pat3
  apply or_or_and_pat3_thm
  ---END or_or_and_pat3



def or_or_and_pat4_before := [llvm|
{
^0(%arg62 : i8, %arg63 : i8, %arg64 : i8, %arg65 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.udiv %0, %arg64 : i8
  %2 = llvm.and %arg62, %arg63 : i8
  %3 = llvm.and %arg65, %arg63 : i8
  %4 = llvm.or %1, %3 : i8
  %5 = llvm.or %4, %2 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def or_or_and_pat4_after := [llvm|
{
^0(%arg62 : i8, %arg63 : i8, %arg64 : i8, %arg65 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.udiv %0, %arg64 : i8
  %2 = llvm.or %arg65, %arg62 : i8
  %3 = llvm.and %2, %arg63 : i8
  %4 = llvm.or %1, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_or_and_pat4_proof : or_or_and_pat4_before ⊑ or_or_and_pat4_after := by
  unfold or_or_and_pat4_before or_or_and_pat4_after
  simp_alive_peephole
  intros
  ---BEGIN or_or_and_pat4
  apply or_or_and_pat4_thm
  ---END or_or_and_pat4



def or_or_and_pat5_before := [llvm|
{
^0(%arg58 : i8, %arg59 : i8, %arg60 : i8, %arg61 : i8):
  %0 = llvm.and %arg58, %arg59 : i8
  %1 = llvm.and %arg58, %arg61 : i8
  %2 = llvm.or %1, %arg60 : i8
  %3 = llvm.or %2, %0 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def or_or_and_pat5_after := [llvm|
{
^0(%arg58 : i8, %arg59 : i8, %arg60 : i8, %arg61 : i8):
  %0 = llvm.or %arg61, %arg59 : i8
  %1 = llvm.and %arg58, %0 : i8
  %2 = llvm.or %1, %arg60 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_or_and_pat5_proof : or_or_and_pat5_before ⊑ or_or_and_pat5_after := by
  unfold or_or_and_pat5_before or_or_and_pat5_after
  simp_alive_peephole
  intros
  ---BEGIN or_or_and_pat5
  apply or_or_and_pat5_thm
  ---END or_or_and_pat5



def or_or_and_pat6_before := [llvm|
{
^0(%arg54 : i8, %arg55 : i8, %arg56 : i8, %arg57 : i8):
  %0 = llvm.and %arg54, %arg55 : i8
  %1 = llvm.and %arg57, %arg54 : i8
  %2 = llvm.or %1, %arg56 : i8
  %3 = llvm.or %2, %0 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def or_or_and_pat6_after := [llvm|
{
^0(%arg54 : i8, %arg55 : i8, %arg56 : i8, %arg57 : i8):
  %0 = llvm.or %arg57, %arg55 : i8
  %1 = llvm.and %0, %arg54 : i8
  %2 = llvm.or %1, %arg56 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_or_and_pat6_proof : or_or_and_pat6_before ⊑ or_or_and_pat6_after := by
  unfold or_or_and_pat6_before or_or_and_pat6_after
  simp_alive_peephole
  intros
  ---BEGIN or_or_and_pat6
  apply or_or_and_pat6_thm
  ---END or_or_and_pat6



def or_or_and_pat7_before := [llvm|
{
^0(%arg50 : i8, %arg51 : i8, %arg52 : i8, %arg53 : i8):
  %0 = llvm.and %arg50, %arg51 : i8
  %1 = llvm.and %arg51, %arg53 : i8
  %2 = llvm.or %1, %arg52 : i8
  %3 = llvm.or %2, %0 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def or_or_and_pat7_after := [llvm|
{
^0(%arg50 : i8, %arg51 : i8, %arg52 : i8, %arg53 : i8):
  %0 = llvm.or %arg53, %arg50 : i8
  %1 = llvm.and %arg51, %0 : i8
  %2 = llvm.or %1, %arg52 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_or_and_pat7_proof : or_or_and_pat7_before ⊑ or_or_and_pat7_after := by
  unfold or_or_and_pat7_before or_or_and_pat7_after
  simp_alive_peephole
  intros
  ---BEGIN or_or_and_pat7
  apply or_or_and_pat7_thm
  ---END or_or_and_pat7



def or_or_and_pat8_before := [llvm|
{
^0(%arg46 : i8, %arg47 : i8, %arg48 : i8, %arg49 : i8):
  %0 = llvm.and %arg46, %arg47 : i8
  %1 = llvm.and %arg49, %arg47 : i8
  %2 = llvm.or %1, %arg48 : i8
  %3 = llvm.or %2, %0 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def or_or_and_pat8_after := [llvm|
{
^0(%arg46 : i8, %arg47 : i8, %arg48 : i8, %arg49 : i8):
  %0 = llvm.or %arg49, %arg46 : i8
  %1 = llvm.and %0, %arg47 : i8
  %2 = llvm.or %1, %arg48 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_or_and_pat8_proof : or_or_and_pat8_before ⊑ or_or_and_pat8_after := by
  unfold or_or_and_pat8_before or_or_and_pat8_after
  simp_alive_peephole
  intros
  ---BEGIN or_or_and_pat8
  apply or_or_and_pat8_thm
  ---END or_or_and_pat8



def or_and_or_pat1_before := [llvm|
{
^0(%arg38 : i8, %arg39 : i8, %arg40 : i8, %arg41 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.udiv %0, %arg40 : i8
  %2 = llvm.and %arg38, %arg39 : i8
  %3 = llvm.and %arg38, %arg41 : i8
  %4 = llvm.or %1, %3 : i8
  %5 = llvm.or %2, %4 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def or_and_or_pat1_after := [llvm|
{
^0(%arg38 : i8, %arg39 : i8, %arg40 : i8, %arg41 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.udiv %0, %arg40 : i8
  %2 = llvm.or %arg41, %arg39 : i8
  %3 = llvm.and %arg38, %2 : i8
  %4 = llvm.or %1, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_and_or_pat1_proof : or_and_or_pat1_before ⊑ or_and_or_pat1_after := by
  unfold or_and_or_pat1_before or_and_or_pat1_after
  simp_alive_peephole
  intros
  ---BEGIN or_and_or_pat1
  apply or_and_or_pat1_thm
  ---END or_and_or_pat1



def or_and_or_pat2_before := [llvm|
{
^0(%arg34 : i8, %arg35 : i8, %arg36 : i8, %arg37 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.udiv %0, %arg36 : i8
  %2 = llvm.and %arg34, %arg35 : i8
  %3 = llvm.and %arg37, %arg34 : i8
  %4 = llvm.or %1, %3 : i8
  %5 = llvm.or %2, %4 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def or_and_or_pat2_after := [llvm|
{
^0(%arg34 : i8, %arg35 : i8, %arg36 : i8, %arg37 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.udiv %0, %arg36 : i8
  %2 = llvm.or %arg37, %arg35 : i8
  %3 = llvm.and %2, %arg34 : i8
  %4 = llvm.or %1, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_and_or_pat2_proof : or_and_or_pat2_before ⊑ or_and_or_pat2_after := by
  unfold or_and_or_pat2_before or_and_or_pat2_after
  simp_alive_peephole
  intros
  ---BEGIN or_and_or_pat2
  apply or_and_or_pat2_thm
  ---END or_and_or_pat2



def or_and_or_pat3_before := [llvm|
{
^0(%arg30 : i8, %arg31 : i8, %arg32 : i8, %arg33 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.udiv %0, %arg32 : i8
  %2 = llvm.and %arg30, %arg31 : i8
  %3 = llvm.and %arg31, %arg33 : i8
  %4 = llvm.or %1, %3 : i8
  %5 = llvm.or %2, %4 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def or_and_or_pat3_after := [llvm|
{
^0(%arg30 : i8, %arg31 : i8, %arg32 : i8, %arg33 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.udiv %0, %arg32 : i8
  %2 = llvm.or %arg33, %arg30 : i8
  %3 = llvm.and %arg31, %2 : i8
  %4 = llvm.or %1, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_and_or_pat3_proof : or_and_or_pat3_before ⊑ or_and_or_pat3_after := by
  unfold or_and_or_pat3_before or_and_or_pat3_after
  simp_alive_peephole
  intros
  ---BEGIN or_and_or_pat3
  apply or_and_or_pat3_thm
  ---END or_and_or_pat3



def or_and_or_pat4_before := [llvm|
{
^0(%arg26 : i8, %arg27 : i8, %arg28 : i8, %arg29 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.udiv %0, %arg28 : i8
  %2 = llvm.and %arg26, %arg27 : i8
  %3 = llvm.and %arg29, %arg27 : i8
  %4 = llvm.or %1, %3 : i8
  %5 = llvm.or %2, %4 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def or_and_or_pat4_after := [llvm|
{
^0(%arg26 : i8, %arg27 : i8, %arg28 : i8, %arg29 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.udiv %0, %arg28 : i8
  %2 = llvm.or %arg29, %arg26 : i8
  %3 = llvm.and %2, %arg27 : i8
  %4 = llvm.or %1, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_and_or_pat4_proof : or_and_or_pat4_before ⊑ or_and_or_pat4_after := by
  unfold or_and_or_pat4_before or_and_or_pat4_after
  simp_alive_peephole
  intros
  ---BEGIN or_and_or_pat4
  apply or_and_or_pat4_thm
  ---END or_and_or_pat4



def or_and_or_pat5_before := [llvm|
{
^0(%arg22 : i8, %arg23 : i8, %arg24 : i8, %arg25 : i8):
  %0 = llvm.and %arg22, %arg23 : i8
  %1 = llvm.and %arg22, %arg25 : i8
  %2 = llvm.or %1, %arg24 : i8
  %3 = llvm.or %0, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def or_and_or_pat5_after := [llvm|
{
^0(%arg22 : i8, %arg23 : i8, %arg24 : i8, %arg25 : i8):
  %0 = llvm.or %arg25, %arg23 : i8
  %1 = llvm.and %arg22, %0 : i8
  %2 = llvm.or %1, %arg24 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_and_or_pat5_proof : or_and_or_pat5_before ⊑ or_and_or_pat5_after := by
  unfold or_and_or_pat5_before or_and_or_pat5_after
  simp_alive_peephole
  intros
  ---BEGIN or_and_or_pat5
  apply or_and_or_pat5_thm
  ---END or_and_or_pat5



def or_and_or_pat6_before := [llvm|
{
^0(%arg18 : i8, %arg19 : i8, %arg20 : i8, %arg21 : i8):
  %0 = llvm.and %arg18, %arg19 : i8
  %1 = llvm.and %arg21, %arg18 : i8
  %2 = llvm.or %1, %arg20 : i8
  %3 = llvm.or %0, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def or_and_or_pat6_after := [llvm|
{
^0(%arg18 : i8, %arg19 : i8, %arg20 : i8, %arg21 : i8):
  %0 = llvm.or %arg21, %arg19 : i8
  %1 = llvm.and %0, %arg18 : i8
  %2 = llvm.or %1, %arg20 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_and_or_pat6_proof : or_and_or_pat6_before ⊑ or_and_or_pat6_after := by
  unfold or_and_or_pat6_before or_and_or_pat6_after
  simp_alive_peephole
  intros
  ---BEGIN or_and_or_pat6
  apply or_and_or_pat6_thm
  ---END or_and_or_pat6



def or_and_or_pat7_before := [llvm|
{
^0(%arg14 : i8, %arg15 : i8, %arg16 : i8, %arg17 : i8):
  %0 = llvm.and %arg14, %arg15 : i8
  %1 = llvm.and %arg15, %arg17 : i8
  %2 = llvm.or %1, %arg16 : i8
  %3 = llvm.or %0, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def or_and_or_pat7_after := [llvm|
{
^0(%arg14 : i8, %arg15 : i8, %arg16 : i8, %arg17 : i8):
  %0 = llvm.or %arg17, %arg14 : i8
  %1 = llvm.and %arg15, %0 : i8
  %2 = llvm.or %1, %arg16 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_and_or_pat7_proof : or_and_or_pat7_before ⊑ or_and_or_pat7_after := by
  unfold or_and_or_pat7_before or_and_or_pat7_after
  simp_alive_peephole
  intros
  ---BEGIN or_and_or_pat7
  apply or_and_or_pat7_thm
  ---END or_and_or_pat7



def or_and_or_pat8_before := [llvm|
{
^0(%arg10 : i8, %arg11 : i8, %arg12 : i8, %arg13 : i8):
  %0 = llvm.and %arg10, %arg11 : i8
  %1 = llvm.and %arg13, %arg11 : i8
  %2 = llvm.or %1, %arg12 : i8
  %3 = llvm.or %0, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def or_and_or_pat8_after := [llvm|
{
^0(%arg10 : i8, %arg11 : i8, %arg12 : i8, %arg13 : i8):
  %0 = llvm.or %arg13, %arg10 : i8
  %1 = llvm.and %0, %arg11 : i8
  %2 = llvm.or %1, %arg12 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_and_or_pat8_proof : or_and_or_pat8_before ⊑ or_and_or_pat8_after := by
  unfold or_and_or_pat8_before or_and_or_pat8_after
  simp_alive_peephole
  intros
  ---BEGIN or_and_or_pat8
  apply or_and_or_pat8_thm
  ---END or_and_or_pat8


