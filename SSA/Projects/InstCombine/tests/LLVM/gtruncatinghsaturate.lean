
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
section gtruncatinghsaturate_statements

def testtrunclowhigh_before := [llvm|
{
^0(%arg40 : i32, %arg41 : i16, %arg42 : i16):
  %0 = llvm.mlir.constant(128 : i32) : i32
  %1 = llvm.mlir.constant(256 : i32) : i32
  %2 = llvm.mlir.constant(-1 : i32) : i32
  %3 = llvm.add %arg40, %0 : i32
  %4 = llvm.icmp "ult" %3, %1 : i32
  %5 = llvm.trunc %arg40 : i32 to i16
  %6 = llvm.icmp "sgt" %arg40, %2 : i32
  %7 = "llvm.select"(%6, %arg42, %arg41) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i16, i16) -> i16
  %8 = "llvm.select"(%4, %5, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i16, i16) -> i16
  "llvm.return"(%8) : (i16) -> ()
}
]
def testtrunclowhigh_after := [llvm|
{
^0(%arg40 : i32, %arg41 : i16, %arg42 : i16):
  %0 = llvm.mlir.constant(128 : i32) : i32
  %1 = llvm.mlir.constant(256 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.add %arg40, %0 : i32
  %4 = llvm.icmp "ult" %3, %1 : i32
  %5 = llvm.trunc %arg40 : i32 to i16
  %6 = llvm.icmp "slt" %arg40, %2 : i32
  %7 = "llvm.select"(%6, %arg41, %arg42) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i16, i16) -> i16
  %8 = "llvm.select"(%4, %5, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i16, i16) -> i16
  "llvm.return"(%8) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem testtrunclowhigh_proof : testtrunclowhigh_before ⊑ testtrunclowhigh_after := by
  unfold testtrunclowhigh_before testtrunclowhigh_after
  simp_alive_peephole
  intros
  ---BEGIN testtrunclowhigh
  all_goals (try extract_goal ; sorry)
  ---END testtrunclowhigh



def testi32i8_before := [llvm|
{
^0(%arg32 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(7 : i8) : i8
  %2 = llvm.mlir.constant(15 : i32) : i32
  %3 = llvm.mlir.constant(127 : i8) : i8
  %4 = llvm.lshr %arg32, %0 : i32
  %5 = llvm.trunc %4 : i32 to i8
  %6 = llvm.trunc %arg32 : i32 to i8
  %7 = llvm.ashr %6, %1 : i8
  %8 = llvm.icmp "eq" %7, %5 : i8
  %9 = llvm.ashr %arg32, %2 : i32
  %10 = llvm.trunc %9 : i32 to i8
  %11 = llvm.xor %10, %3 : i8
  %12 = "llvm.select"(%8, %6, %11) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%12) : (i8) -> ()
}
]
def testi32i8_after := [llvm|
{
^0(%arg32 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(7 : i8) : i8
  %2 = llvm.mlir.constant(15 : i32) : i32
  %3 = llvm.mlir.constant(127 : i8) : i8
  %4 = llvm.lshr %arg32, %0 : i32
  %5 = llvm.trunc %4 : i32 to i8
  %6 = llvm.trunc %arg32 : i32 to i8
  %7 = llvm.ashr %6, %1 : i8
  %8 = llvm.icmp "eq" %7, %5 : i8
  %9 = llvm.lshr %arg32, %2 : i32
  %10 = llvm.trunc %9 : i32 to i8
  %11 = llvm.xor %10, %3 : i8
  %12 = "llvm.select"(%8, %6, %11) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%12) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem testi32i8_proof : testi32i8_before ⊑ testi32i8_after := by
  unfold testi32i8_before testi32i8_after
  simp_alive_peephole
  intros
  ---BEGIN testi32i8
  all_goals (try extract_goal ; sorry)
  ---END testi32i8



def differentconsts_before := [llvm|
{
^0(%arg29 : i32, %arg30 : i16, %arg31 : i16):
  %0 = llvm.mlir.constant(128 : i32) : i32
  %1 = llvm.mlir.constant(256 : i16) : i16
  %2 = llvm.mlir.constant(-1 : i16) : i16
  %3 = llvm.mlir.constant(16 : i32) : i32
  %4 = llvm.mlir.constant(144 : i32) : i32
  %5 = llvm.icmp "slt" %arg29, %0 : i32
  %6 = "llvm.select"(%5, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i16, i16) -> i16
  %7 = llvm.add %arg29, %3 : i32
  %8 = llvm.icmp "ult" %7, %4 : i32
  %9 = llvm.trunc %arg29 : i32 to i16
  %10 = "llvm.select"(%8, %9, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i16, i16) -> i16
  "llvm.return"(%10) : (i16) -> ()
}
]
def differentconsts_after := [llvm|
{
^0(%arg29 : i32, %arg30 : i16, %arg31 : i16):
  %0 = llvm.mlir.constant(-16 : i32) : i32
  %1 = llvm.mlir.constant(127 : i32) : i32
  %2 = llvm.mlir.constant(256 : i16) : i16
  %3 = llvm.mlir.constant(-1 : i16) : i16
  %4 = llvm.icmp "slt" %arg29, %0 : i32
  %5 = llvm.icmp "sgt" %arg29, %1 : i32
  %6 = llvm.trunc %arg29 : i32 to i16
  %7 = "llvm.select"(%4, %2, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i16, i16) -> i16
  %8 = "llvm.select"(%5, %3, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i16, i16) -> i16
  "llvm.return"(%8) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem differentconsts_proof : differentconsts_before ⊑ differentconsts_after := by
  unfold differentconsts_before differentconsts_after
  simp_alive_peephole
  intros
  ---BEGIN differentconsts
  all_goals (try extract_goal ; sorry)
  ---END differentconsts



def badimm1_before := [llvm|
{
^0(%arg28 : i16):
  %0 = llvm.mlir.constant(9 : i16) : i16
  %1 = llvm.mlir.constant(7 : i8) : i8
  %2 = llvm.mlir.constant(15 : i16) : i16
  %3 = llvm.mlir.constant(127 : i8) : i8
  %4 = llvm.lshr %arg28, %0 : i16
  %5 = llvm.trunc %4 : i16 to i8
  %6 = llvm.trunc %arg28 : i16 to i8
  %7 = llvm.ashr %6, %1 : i8
  %8 = llvm.icmp "eq" %7, %5 : i8
  %9 = llvm.ashr %arg28, %2 : i16
  %10 = llvm.trunc %9 : i16 to i8
  %11 = llvm.xor %10, %3 : i8
  %12 = "llvm.select"(%8, %6, %11) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%12) : (i8) -> ()
}
]
def badimm1_after := [llvm|
{
^0(%arg28 : i16):
  %0 = llvm.mlir.constant(9 : i16) : i16
  %1 = llvm.mlir.constant(7 : i8) : i8
  %2 = llvm.mlir.constant(-1 : i16) : i16
  %3 = llvm.mlir.constant(127 : i8) : i8
  %4 = llvm.mlir.constant(-128 : i8) : i8
  %5 = llvm.lshr %arg28, %0 : i16
  %6 = llvm.trunc %5 overflow<nsw,nuw> : i16 to i8
  %7 = llvm.trunc %arg28 : i16 to i8
  %8 = llvm.ashr %7, %1 : i8
  %9 = llvm.icmp "eq" %8, %6 : i8
  %10 = llvm.icmp "sgt" %arg28, %2 : i16
  %11 = "llvm.select"(%10, %3, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %12 = "llvm.select"(%9, %7, %11) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%12) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem badimm1_proof : badimm1_before ⊑ badimm1_after := by
  unfold badimm1_before badimm1_after
  simp_alive_peephole
  intros
  ---BEGIN badimm1
  all_goals (try extract_goal ; sorry)
  ---END badimm1



def badimm2_before := [llvm|
{
^0(%arg27 : i16):
  %0 = llvm.mlir.constant(8 : i16) : i16
  %1 = llvm.mlir.constant(6 : i8) : i8
  %2 = llvm.mlir.constant(15 : i16) : i16
  %3 = llvm.mlir.constant(127 : i8) : i8
  %4 = llvm.lshr %arg27, %0 : i16
  %5 = llvm.trunc %4 : i16 to i8
  %6 = llvm.trunc %arg27 : i16 to i8
  %7 = llvm.ashr %6, %1 : i8
  %8 = llvm.icmp "eq" %7, %5 : i8
  %9 = llvm.ashr %arg27, %2 : i16
  %10 = llvm.trunc %9 : i16 to i8
  %11 = llvm.xor %10, %3 : i8
  %12 = "llvm.select"(%8, %6, %11) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%12) : (i8) -> ()
}
]
def badimm2_after := [llvm|
{
^0(%arg27 : i16):
  %0 = llvm.mlir.constant(8 : i16) : i16
  %1 = llvm.mlir.constant(6 : i8) : i8
  %2 = llvm.mlir.constant(-1 : i16) : i16
  %3 = llvm.mlir.constant(127 : i8) : i8
  %4 = llvm.mlir.constant(-128 : i8) : i8
  %5 = llvm.lshr %arg27, %0 : i16
  %6 = llvm.trunc %5 overflow<nuw> : i16 to i8
  %7 = llvm.trunc %arg27 : i16 to i8
  %8 = llvm.ashr %7, %1 : i8
  %9 = llvm.icmp "eq" %8, %6 : i8
  %10 = llvm.icmp "sgt" %arg27, %2 : i16
  %11 = "llvm.select"(%10, %3, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %12 = "llvm.select"(%9, %7, %11) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%12) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem badimm2_proof : badimm2_before ⊑ badimm2_after := by
  unfold badimm2_before badimm2_after
  simp_alive_peephole
  intros
  ---BEGIN badimm2
  all_goals (try extract_goal ; sorry)
  ---END badimm2



def badimm3_before := [llvm|
{
^0(%arg26 : i16):
  %0 = llvm.mlir.constant(8 : i16) : i16
  %1 = llvm.mlir.constant(7 : i8) : i8
  %2 = llvm.mlir.constant(14 : i16) : i16
  %3 = llvm.mlir.constant(127 : i8) : i8
  %4 = llvm.lshr %arg26, %0 : i16
  %5 = llvm.trunc %4 : i16 to i8
  %6 = llvm.trunc %arg26 : i16 to i8
  %7 = llvm.ashr %6, %1 : i8
  %8 = llvm.icmp "eq" %7, %5 : i8
  %9 = llvm.ashr %arg26, %2 : i16
  %10 = llvm.trunc %9 : i16 to i8
  %11 = llvm.xor %10, %3 : i8
  %12 = "llvm.select"(%8, %6, %11) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%12) : (i8) -> ()
}
]
def badimm3_after := [llvm|
{
^0(%arg26 : i16):
  %0 = llvm.mlir.constant(128 : i16) : i16
  %1 = llvm.mlir.constant(256 : i16) : i16
  %2 = llvm.mlir.constant(14 : i16) : i16
  %3 = llvm.mlir.constant(127 : i8) : i8
  %4 = llvm.trunc %arg26 : i16 to i8
  %5 = llvm.add %arg26, %0 : i16
  %6 = llvm.icmp "ult" %5, %1 : i16
  %7 = llvm.ashr %arg26, %2 : i16
  %8 = llvm.trunc %7 overflow<nsw> : i16 to i8
  %9 = llvm.xor %8, %3 : i8
  %10 = "llvm.select"(%6, %4, %9) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%10) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem badimm3_proof : badimm3_before ⊑ badimm3_after := by
  unfold badimm3_before badimm3_after
  simp_alive_peephole
  intros
  ---BEGIN badimm3
  all_goals (try extract_goal ; sorry)
  ---END badimm3



def badimm4_before := [llvm|
{
^0(%arg25 : i16):
  %0 = llvm.mlir.constant(8 : i16) : i16
  %1 = llvm.mlir.constant(7 : i8) : i8
  %2 = llvm.mlir.constant(15 : i16) : i16
  %3 = llvm.mlir.constant(126 : i8) : i8
  %4 = llvm.lshr %arg25, %0 : i16
  %5 = llvm.trunc %4 : i16 to i8
  %6 = llvm.trunc %arg25 : i16 to i8
  %7 = llvm.ashr %6, %1 : i8
  %8 = llvm.icmp "eq" %7, %5 : i8
  %9 = llvm.ashr %arg25, %2 : i16
  %10 = llvm.trunc %9 : i16 to i8
  %11 = llvm.xor %10, %3 : i8
  %12 = "llvm.select"(%8, %6, %11) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%12) : (i8) -> ()
}
]
def badimm4_after := [llvm|
{
^0(%arg25 : i16):
  %0 = llvm.mlir.constant(-128 : i16) : i16
  %1 = llvm.mlir.constant(127 : i16) : i16
  %2 = llvm.mlir.constant(-127 : i8) : i8
  %3 = llvm.mlir.constant(126 : i8) : i8
  %4 = llvm.icmp "slt" %arg25, %0 : i16
  %5 = llvm.icmp "sgt" %arg25, %1 : i16
  %6 = llvm.trunc %arg25 : i16 to i8
  %7 = "llvm.select"(%4, %2, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %8 = "llvm.select"(%5, %3, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%8) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem badimm4_proof : badimm4_before ⊑ badimm4_after := by
  unfold badimm4_before badimm4_after
  simp_alive_peephole
  intros
  ---BEGIN badimm4
  all_goals (try extract_goal ; sorry)
  ---END badimm4



def C0zero_before := [llvm|
{
^0(%arg8 : i8, %arg9 : i8, %arg10 : i8):
  %0 = llvm.mlir.constant(10 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.mlir.constant(-10 : i8) : i8
  %3 = llvm.add %arg8, %0 : i8
  %4 = llvm.icmp "ult" %3, %1 : i8
  %5 = llvm.icmp "slt" %arg8, %2 : i8
  %6 = "llvm.select"(%5, %arg9, %arg10) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %7 = "llvm.select"(%4, %arg8, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%7) : (i8) -> ()
}
]
def C0zero_after := [llvm|
{
^0(%arg8 : i8, %arg9 : i8, %arg10 : i8):
  %0 = llvm.mlir.constant(-10 : i8) : i8
  %1 = llvm.icmp "slt" %arg8, %0 : i8
  %2 = "llvm.select"(%1, %arg9, %arg10) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem C0zero_proof : C0zero_before ⊑ C0zero_after := by
  unfold C0zero_before C0zero_after
  simp_alive_peephole
  intros
  ---BEGIN C0zero
  all_goals (try extract_goal ; sorry)
  ---END C0zero


