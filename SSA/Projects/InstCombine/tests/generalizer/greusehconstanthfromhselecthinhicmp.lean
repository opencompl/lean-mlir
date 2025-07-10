import SSA.Projects.InstCombine.tests.proofs.greusehconstanthfromhselecthinhicmp_proof
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
section greusehconstanthfromhselecthinhicmp_statements

def p0_ult_65536_before := [llvm|
{
^0(%arg54 : i32, %arg55 : i32):
  %0 = llvm.mlir.constant(65536 : i32) : i32
  %1 = llvm.mlir.constant(65535 : i32) : i32
  %2 = llvm.icmp "ult" %arg54, %0 : i32
  %3 = "llvm.select"(%2, %arg55, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def p0_ult_65536_after := [llvm|
{
^0(%arg54 : i32, %arg55 : i32):
  %0 = llvm.mlir.constant(65535 : i32) : i32
  %1 = llvm.icmp "ugt" %arg54, %0 : i32
  %2 = "llvm.select"(%1, %0, %arg55) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem p0_ult_65536_proof : p0_ult_65536_before ⊑ p0_ult_65536_after := by
  unfold p0_ult_65536_before p0_ult_65536_after
  simp_alive_peephole
  intros
  ---BEGIN p0_ult_65536
  apply p0_ult_65536_thm
  ---END p0_ult_65536



def p1_ugt_before := [llvm|
{
^0(%arg52 : i32, %arg53 : i32):
  %0 = llvm.mlir.constant(65534 : i32) : i32
  %1 = llvm.mlir.constant(65535 : i32) : i32
  %2 = llvm.icmp "ugt" %arg52, %0 : i32
  %3 = "llvm.select"(%2, %arg53, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def p1_ugt_after := [llvm|
{
^0(%arg52 : i32, %arg53 : i32):
  %0 = llvm.mlir.constant(65535 : i32) : i32
  %1 = llvm.icmp "ult" %arg52, %0 : i32
  %2 = "llvm.select"(%1, %0, %arg53) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem p1_ugt_proof : p1_ugt_before ⊑ p1_ugt_after := by
  unfold p1_ugt_before p1_ugt_after
  simp_alive_peephole
  intros
  ---BEGIN p1_ugt
  apply p1_ugt_thm
  ---END p1_ugt



def p2_slt_65536_before := [llvm|
{
^0(%arg50 : i32, %arg51 : i32):
  %0 = llvm.mlir.constant(65536 : i32) : i32
  %1 = llvm.mlir.constant(65535 : i32) : i32
  %2 = llvm.icmp "slt" %arg50, %0 : i32
  %3 = "llvm.select"(%2, %arg51, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def p2_slt_65536_after := [llvm|
{
^0(%arg50 : i32, %arg51 : i32):
  %0 = llvm.mlir.constant(65535 : i32) : i32
  %1 = llvm.icmp "sgt" %arg50, %0 : i32
  %2 = "llvm.select"(%1, %0, %arg51) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem p2_slt_65536_proof : p2_slt_65536_before ⊑ p2_slt_65536_after := by
  unfold p2_slt_65536_before p2_slt_65536_after
  simp_alive_peephole
  intros
  ---BEGIN p2_slt_65536
  apply p2_slt_65536_thm
  ---END p2_slt_65536



def p3_sgt_before := [llvm|
{
^0(%arg48 : i32, %arg49 : i32):
  %0 = llvm.mlir.constant(65534 : i32) : i32
  %1 = llvm.mlir.constant(65535 : i32) : i32
  %2 = llvm.icmp "sgt" %arg48, %0 : i32
  %3 = "llvm.select"(%2, %arg49, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def p3_sgt_after := [llvm|
{
^0(%arg48 : i32, %arg49 : i32):
  %0 = llvm.mlir.constant(65535 : i32) : i32
  %1 = llvm.icmp "slt" %arg48, %0 : i32
  %2 = "llvm.select"(%1, %0, %arg49) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem p3_sgt_proof : p3_sgt_before ⊑ p3_sgt_after := by
  unfold p3_sgt_before p3_sgt_after
  simp_alive_peephole
  intros
  ---BEGIN p3_sgt
  apply p3_sgt_thm
  ---END p3_sgt



def p13_commutativity0_before := [llvm|
{
^0(%arg28 : i32, %arg29 : i32):
  %0 = llvm.mlir.constant(65536 : i32) : i32
  %1 = llvm.mlir.constant(65535 : i32) : i32
  %2 = llvm.icmp "ult" %arg28, %0 : i32
  %3 = "llvm.select"(%2, %1, %arg29) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def p13_commutativity0_after := [llvm|
{
^0(%arg28 : i32, %arg29 : i32):
  %0 = llvm.mlir.constant(65535 : i32) : i32
  %1 = llvm.icmp "ugt" %arg28, %0 : i32
  %2 = "llvm.select"(%1, %arg29, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem p13_commutativity0_proof : p13_commutativity0_before ⊑ p13_commutativity0_after := by
  unfold p13_commutativity0_before p13_commutativity0_after
  simp_alive_peephole
  intros
  ---BEGIN p13_commutativity0
  apply p13_commutativity0_thm
  ---END p13_commutativity0



def p14_commutativity1_before := [llvm|
{
^0(%arg26 : i32, %arg27 : i32):
  %0 = llvm.mlir.constant(65536 : i32) : i32
  %1 = llvm.mlir.constant(65535 : i32) : i32
  %2 = llvm.mlir.constant(42 : i32) : i32
  %3 = llvm.icmp "ult" %arg26, %0 : i32
  %4 = "llvm.select"(%3, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def p14_commutativity1_after := [llvm|
{
^0(%arg26 : i32, %arg27 : i32):
  %0 = llvm.mlir.constant(65535 : i32) : i32
  %1 = llvm.mlir.constant(42 : i32) : i32
  %2 = llvm.icmp "ugt" %arg26, %0 : i32
  %3 = "llvm.select"(%2, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem p14_commutativity1_proof : p14_commutativity1_before ⊑ p14_commutativity1_after := by
  unfold p14_commutativity1_before p14_commutativity1_after
  simp_alive_peephole
  intros
  ---BEGIN p14_commutativity1
  apply p14_commutativity1_thm
  ---END p14_commutativity1



def p15_commutativity2_before := [llvm|
{
^0(%arg24 : i32, %arg25 : i32):
  %0 = llvm.mlir.constant(65536 : i32) : i32
  %1 = llvm.mlir.constant(42 : i32) : i32
  %2 = llvm.mlir.constant(65535 : i32) : i32
  %3 = llvm.icmp "ult" %arg24, %0 : i32
  %4 = "llvm.select"(%3, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def p15_commutativity2_after := [llvm|
{
^0(%arg24 : i32, %arg25 : i32):
  %0 = llvm.mlir.constant(65535 : i32) : i32
  %1 = llvm.mlir.constant(42 : i32) : i32
  %2 = llvm.icmp "ugt" %arg24, %0 : i32
  %3 = "llvm.select"(%2, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem p15_commutativity2_proof : p15_commutativity2_before ⊑ p15_commutativity2_after := by
  unfold p15_commutativity2_before p15_commutativity2_after
  simp_alive_peephole
  intros
  ---BEGIN p15_commutativity2
  apply p15_commutativity2_thm
  ---END p15_commutativity2



def t22_sign_check_before := [llvm|
{
^0(%arg12 : i32, %arg13 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.icmp "slt" %arg12, %0 : i32
  %3 = "llvm.select"(%2, %1, %arg13) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def t22_sign_check_after := [llvm|
{
^0(%arg12 : i32, %arg13 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.icmp "sgt" %arg12, %0 : i32
  %2 = "llvm.select"(%1, %arg13, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t22_sign_check_proof : t22_sign_check_before ⊑ t22_sign_check_after := by
  unfold t22_sign_check_before t22_sign_check_after
  simp_alive_peephole
  intros
  ---BEGIN t22_sign_check
  apply t22_sign_check_thm
  ---END t22_sign_check



def t22_sign_check2_before := [llvm|
{
^0(%arg10 : i32, %arg11 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.icmp "sgt" %arg10, %0 : i32
  %3 = "llvm.select"(%2, %1, %arg11) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def t22_sign_check2_after := [llvm|
{
^0(%arg10 : i32, %arg11 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "slt" %arg10, %0 : i32
  %2 = "llvm.select"(%1, %arg11, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t22_sign_check2_proof : t22_sign_check2_before ⊑ t22_sign_check2_after := by
  unfold t22_sign_check2_before t22_sign_check2_after
  simp_alive_peephole
  intros
  ---BEGIN t22_sign_check2
  apply t22_sign_check2_thm
  ---END t22_sign_check2


