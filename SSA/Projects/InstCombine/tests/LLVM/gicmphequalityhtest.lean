
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
section gicmphequalityhtest_statements

def icmp_equality_test_before := [llvm|
{
^0(%arg34 : i64, %arg35 : i64, %arg36 : i64):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "eq" %arg34, %arg36 : i64
  %3 = llvm.icmp "eq" %arg35, %arg36 : i64
  %4 = llvm.icmp "eq" %arg34, %arg35 : i64
  %5 = llvm.xor %3, %0 : i1
  %6 = "llvm.select"(%5, %4, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %7 = "llvm.select"(%2, %3, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def icmp_equality_test_after := [llvm|
{
^0(%arg34 : i64, %arg35 : i64, %arg36 : i64):
  %0 = llvm.icmp "eq" %arg34, %arg35 : i64
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_equality_test_proof : icmp_equality_test_before ⊑ icmp_equality_test_after := by
  unfold icmp_equality_test_before icmp_equality_test_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_equality_test
  all_goals (try extract_goal ; sorry)
  ---END icmp_equality_test



def icmp_equality_test_constant_before := [llvm|
{
^0(%arg32 : i42, %arg33 : i42):
  %0 = llvm.mlir.constant(-42 : i42) : i42
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.icmp "eq" %arg32, %0 : i42
  %4 = llvm.icmp "eq" %arg33, %0 : i42
  %5 = llvm.icmp "eq" %arg32, %arg33 : i42
  %6 = llvm.xor %4, %1 : i1
  %7 = "llvm.select"(%6, %5, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %8 = "llvm.select"(%3, %4, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def icmp_equality_test_constant_after := [llvm|
{
^0(%arg32 : i42, %arg33 : i42):
  %0 = llvm.icmp "eq" %arg32, %arg33 : i42
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_equality_test_constant_proof : icmp_equality_test_constant_before ⊑ icmp_equality_test_constant_after := by
  unfold icmp_equality_test_constant_before icmp_equality_test_constant_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_equality_test_constant
  all_goals (try extract_goal ; sorry)
  ---END icmp_equality_test_constant



def icmp_equality_test_constant_samesign_before := [llvm|
{
^0(%arg30 : i42, %arg31 : i42):
  %0 = llvm.mlir.constant(-42 : i42) : i42
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.icmp "eq" %arg30, %0 : i42
  %4 = llvm.icmp "eq" %arg31, %0 : i42
  %5 = llvm.icmp "eq" %arg30, %arg31 : i42
  %6 = llvm.xor %4, %1 : i1
  %7 = "llvm.select"(%6, %5, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %8 = "llvm.select"(%3, %4, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def icmp_equality_test_constant_samesign_after := [llvm|
{
^0(%arg30 : i42, %arg31 : i42):
  %0 = llvm.icmp "eq" %arg30, %arg31 : i42
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_equality_test_constant_samesign_proof : icmp_equality_test_constant_samesign_before ⊑ icmp_equality_test_constant_samesign_after := by
  unfold icmp_equality_test_constant_samesign_before icmp_equality_test_constant_samesign_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_equality_test_constant_samesign
  all_goals (try extract_goal ; sorry)
  ---END icmp_equality_test_constant_samesign



def icmp_equality_test_swift_optional_pointers_before := [llvm|
{
^0(%arg28 : i64, %arg29 : i64):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.icmp "eq" %arg28, %0 : i64
  %4 = llvm.icmp "eq" %arg29, %0 : i64
  %5 = "llvm.select"(%3, %1, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %6 = "llvm.select"(%3, %4, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %7 = llvm.icmp "eq" %arg28, %arg29 : i64
  %8 = "llvm.select"(%5, %6, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def icmp_equality_test_swift_optional_pointers_after := [llvm|
{
^0(%arg28 : i64, %arg29 : i64):
  %0 = llvm.icmp "eq" %arg28, %arg29 : i64
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_equality_test_swift_optional_pointers_proof : icmp_equality_test_swift_optional_pointers_before ⊑ icmp_equality_test_swift_optional_pointers_after := by
  unfold icmp_equality_test_swift_optional_pointers_before icmp_equality_test_swift_optional_pointers_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_equality_test_swift_optional_pointers
  all_goals (try extract_goal ; sorry)
  ---END icmp_equality_test_swift_optional_pointers



def icmp_equality_test_commute_icmp1_before := [llvm|
{
^0(%arg23 : i64, %arg24 : i64, %arg25 : i64):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "eq" %arg25, %arg23 : i64
  %3 = llvm.icmp "eq" %arg25, %arg24 : i64
  %4 = llvm.icmp "eq" %arg24, %arg23 : i64
  %5 = llvm.xor %3, %0 : i1
  %6 = "llvm.select"(%5, %4, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %7 = "llvm.select"(%2, %3, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def icmp_equality_test_commute_icmp1_after := [llvm|
{
^0(%arg23 : i64, %arg24 : i64, %arg25 : i64):
  %0 = llvm.icmp "eq" %arg24, %arg23 : i64
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_equality_test_commute_icmp1_proof : icmp_equality_test_commute_icmp1_before ⊑ icmp_equality_test_commute_icmp1_after := by
  unfold icmp_equality_test_commute_icmp1_before icmp_equality_test_commute_icmp1_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_equality_test_commute_icmp1
  all_goals (try extract_goal ; sorry)
  ---END icmp_equality_test_commute_icmp1



def icmp_equality_test_commute_icmp2_before := [llvm|
{
^0(%arg20 : i64, %arg21 : i64, %arg22 : i64):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "eq" %arg22, %arg20 : i64
  %3 = llvm.icmp "eq" %arg21, %arg22 : i64
  %4 = llvm.icmp "eq" %arg21, %arg20 : i64
  %5 = llvm.xor %3, %0 : i1
  %6 = "llvm.select"(%5, %4, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %7 = "llvm.select"(%2, %3, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def icmp_equality_test_commute_icmp2_after := [llvm|
{
^0(%arg20 : i64, %arg21 : i64, %arg22 : i64):
  %0 = llvm.icmp "eq" %arg21, %arg20 : i64
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_equality_test_commute_icmp2_proof : icmp_equality_test_commute_icmp2_before ⊑ icmp_equality_test_commute_icmp2_after := by
  unfold icmp_equality_test_commute_icmp2_before icmp_equality_test_commute_icmp2_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_equality_test_commute_icmp2
  all_goals (try extract_goal ; sorry)
  ---END icmp_equality_test_commute_icmp2



def icmp_equality_test_commute_select1_before := [llvm|
{
^0(%arg17 : i64, %arg18 : i64, %arg19 : i64):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.icmp "eq" %arg17, %arg19 : i64
  %2 = llvm.icmp "eq" %arg18, %arg19 : i64
  %3 = llvm.icmp "eq" %arg17, %arg18 : i64
  %4 = "llvm.select"(%2, %0, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %5 = "llvm.select"(%1, %2, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def icmp_equality_test_commute_select1_after := [llvm|
{
^0(%arg17 : i64, %arg18 : i64, %arg19 : i64):
  %0 = llvm.icmp "eq" %arg17, %arg18 : i64
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_equality_test_commute_select1_proof : icmp_equality_test_commute_select1_before ⊑ icmp_equality_test_commute_select1_after := by
  unfold icmp_equality_test_commute_select1_before icmp_equality_test_commute_select1_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_equality_test_commute_select1
  all_goals (try extract_goal ; sorry)
  ---END icmp_equality_test_commute_select1



def icmp_equality_test_commute_select2_before := [llvm|
{
^0(%arg14 : i64, %arg15 : i64, %arg16 : i64):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "eq" %arg14, %arg16 : i64
  %3 = llvm.icmp "eq" %arg15, %arg16 : i64
  %4 = llvm.icmp "eq" %arg14, %arg15 : i64
  %5 = llvm.xor %2, %0 : i1
  %6 = "llvm.select"(%3, %1, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %7 = "llvm.select"(%5, %6, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def icmp_equality_test_commute_select2_after := [llvm|
{
^0(%arg14 : i64, %arg15 : i64, %arg16 : i64):
  %0 = llvm.icmp "eq" %arg14, %arg15 : i64
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_equality_test_commute_select2_proof : icmp_equality_test_commute_select2_before ⊑ icmp_equality_test_commute_select2_after := by
  unfold icmp_equality_test_commute_select2_before icmp_equality_test_commute_select2_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_equality_test_commute_select2
  all_goals (try extract_goal ; sorry)
  ---END icmp_equality_test_commute_select2



def icmp_equality_test_wrong_and_before := [llvm|
{
^0(%arg6 : i64, %arg7 : i64, %arg8 : i64):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "eq" %arg6, %arg8 : i64
  %3 = llvm.icmp "eq" %arg7, %arg8 : i64
  %4 = llvm.icmp "eq" %arg6, %arg7 : i64
  %5 = llvm.xor %3, %0 : i1
  %6 = "llvm.select"(%5, %1, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %7 = "llvm.select"(%2, %3, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def icmp_equality_test_wrong_and_after := [llvm|
{
^0(%arg6 : i64, %arg7 : i64, %arg8 : i64):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.icmp "eq" %arg6, %arg8 : i64
  %2 = llvm.icmp "eq" %arg7, %arg8 : i64
  %3 = llvm.icmp "eq" %arg6, %arg7 : i64
  %4 = "llvm.select"(%2, %3, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %5 = "llvm.select"(%1, %2, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_equality_test_wrong_and_proof : icmp_equality_test_wrong_and_before ⊑ icmp_equality_test_wrong_and_after := by
  unfold icmp_equality_test_wrong_and_before icmp_equality_test_wrong_and_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_equality_test_wrong_and
  all_goals (try extract_goal ; sorry)
  ---END icmp_equality_test_wrong_and


