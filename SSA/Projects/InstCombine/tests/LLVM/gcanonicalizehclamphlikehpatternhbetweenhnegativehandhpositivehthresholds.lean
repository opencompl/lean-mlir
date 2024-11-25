
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
section gcanonicalizehclamphlikehpatternhbetweenhnegativehandhpositivehthresholds_statements

def t0_ult_slt_128_before := [llvm|
{
^0(%arg78 : i32, %arg79 : i32, %arg80 : i32):
  %0 = llvm.mlir.constant(128 : i32) : i32
  %1 = llvm.mlir.constant(16 : i32) : i32
  %2 = llvm.mlir.constant(144 : i32) : i32
  %3 = llvm.icmp "slt" %arg78, %0 : i32
  %4 = "llvm.select"(%3, %arg79, %arg80) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %5 = llvm.add %arg78, %1 : i32
  %6 = llvm.icmp "ult" %5, %2 : i32
  %7 = "llvm.select"(%6, %arg78, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def t0_ult_slt_128_after := [llvm|
{
^0(%arg78 : i32, %arg79 : i32, %arg80 : i32):
  %0 = llvm.mlir.constant(-16 : i32) : i32
  %1 = llvm.mlir.constant(127 : i32) : i32
  %2 = llvm.icmp "slt" %arg78, %0 : i32
  %3 = llvm.icmp "sgt" %arg78, %1 : i32
  %4 = "llvm.select"(%2, %arg79, %arg78) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %5 = "llvm.select"(%3, %arg80, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t0_ult_slt_128_proof : t0_ult_slt_128_before ⊑ t0_ult_slt_128_after := by
  unfold t0_ult_slt_128_before t0_ult_slt_128_after
  simp_alive_peephole
  intros
  ---BEGIN t0_ult_slt_128
  all_goals (try extract_goal ; sorry)
  ---END t0_ult_slt_128



def t1_ult_slt_0_before := [llvm|
{
^0(%arg75 : i32, %arg76 : i32, %arg77 : i32):
  %0 = llvm.mlir.constant(-16 : i32) : i32
  %1 = llvm.mlir.constant(16 : i32) : i32
  %2 = llvm.mlir.constant(144 : i32) : i32
  %3 = llvm.icmp "slt" %arg75, %0 : i32
  %4 = "llvm.select"(%3, %arg76, %arg77) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %5 = llvm.add %arg75, %1 : i32
  %6 = llvm.icmp "ult" %5, %2 : i32
  %7 = "llvm.select"(%6, %arg75, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def t1_ult_slt_0_after := [llvm|
{
^0(%arg75 : i32, %arg76 : i32, %arg77 : i32):
  %0 = llvm.mlir.constant(-16 : i32) : i32
  %1 = llvm.mlir.constant(127 : i32) : i32
  %2 = llvm.icmp "slt" %arg75, %0 : i32
  %3 = llvm.icmp "sgt" %arg75, %1 : i32
  %4 = "llvm.select"(%2, %arg76, %arg75) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %5 = "llvm.select"(%3, %arg77, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t1_ult_slt_0_proof : t1_ult_slt_0_before ⊑ t1_ult_slt_0_after := by
  unfold t1_ult_slt_0_before t1_ult_slt_0_after
  simp_alive_peephole
  intros
  ---BEGIN t1_ult_slt_0
  all_goals (try extract_goal ; sorry)
  ---END t1_ult_slt_0



def t2_ult_sgt_128_before := [llvm|
{
^0(%arg72 : i32, %arg73 : i32, %arg74 : i32):
  %0 = llvm.mlir.constant(127 : i32) : i32
  %1 = llvm.mlir.constant(16 : i32) : i32
  %2 = llvm.mlir.constant(144 : i32) : i32
  %3 = llvm.icmp "sgt" %arg72, %0 : i32
  %4 = "llvm.select"(%3, %arg74, %arg73) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %5 = llvm.add %arg72, %1 : i32
  %6 = llvm.icmp "ult" %5, %2 : i32
  %7 = "llvm.select"(%6, %arg72, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def t2_ult_sgt_128_after := [llvm|
{
^0(%arg72 : i32, %arg73 : i32, %arg74 : i32):
  %0 = llvm.mlir.constant(-16 : i32) : i32
  %1 = llvm.mlir.constant(127 : i32) : i32
  %2 = llvm.icmp "slt" %arg72, %0 : i32
  %3 = llvm.icmp "sgt" %arg72, %1 : i32
  %4 = "llvm.select"(%2, %arg73, %arg72) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %5 = "llvm.select"(%3, %arg74, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t2_ult_sgt_128_proof : t2_ult_sgt_128_before ⊑ t2_ult_sgt_128_after := by
  unfold t2_ult_sgt_128_before t2_ult_sgt_128_after
  simp_alive_peephole
  intros
  ---BEGIN t2_ult_sgt_128
  all_goals (try extract_goal ; sorry)
  ---END t2_ult_sgt_128



def t3_ult_sgt_neg1_before := [llvm|
{
^0(%arg69 : i32, %arg70 : i32, %arg71 : i32):
  %0 = llvm.mlir.constant(-17 : i32) : i32
  %1 = llvm.mlir.constant(16 : i32) : i32
  %2 = llvm.mlir.constant(144 : i32) : i32
  %3 = llvm.icmp "sgt" %arg69, %0 : i32
  %4 = "llvm.select"(%3, %arg71, %arg70) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %5 = llvm.add %arg69, %1 : i32
  %6 = llvm.icmp "ult" %5, %2 : i32
  %7 = "llvm.select"(%6, %arg69, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def t3_ult_sgt_neg1_after := [llvm|
{
^0(%arg69 : i32, %arg70 : i32, %arg71 : i32):
  %0 = llvm.mlir.constant(-16 : i32) : i32
  %1 = llvm.mlir.constant(127 : i32) : i32
  %2 = llvm.icmp "slt" %arg69, %0 : i32
  %3 = llvm.icmp "sgt" %arg69, %1 : i32
  %4 = "llvm.select"(%2, %arg70, %arg69) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %5 = "llvm.select"(%3, %arg71, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t3_ult_sgt_neg1_proof : t3_ult_sgt_neg1_before ⊑ t3_ult_sgt_neg1_after := by
  unfold t3_ult_sgt_neg1_before t3_ult_sgt_neg1_after
  simp_alive_peephole
  intros
  ---BEGIN t3_ult_sgt_neg1
  all_goals (try extract_goal ; sorry)
  ---END t3_ult_sgt_neg1



def t4_ugt_slt_128_before := [llvm|
{
^0(%arg66 : i32, %arg67 : i32, %arg68 : i32):
  %0 = llvm.mlir.constant(128 : i32) : i32
  %1 = llvm.mlir.constant(16 : i32) : i32
  %2 = llvm.mlir.constant(143 : i32) : i32
  %3 = llvm.icmp "slt" %arg66, %0 : i32
  %4 = "llvm.select"(%3, %arg67, %arg68) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %5 = llvm.add %arg66, %1 : i32
  %6 = llvm.icmp "ugt" %5, %2 : i32
  %7 = "llvm.select"(%6, %4, %arg66) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def t4_ugt_slt_128_after := [llvm|
{
^0(%arg66 : i32, %arg67 : i32, %arg68 : i32):
  %0 = llvm.mlir.constant(-16 : i32) : i32
  %1 = llvm.mlir.constant(127 : i32) : i32
  %2 = llvm.icmp "slt" %arg66, %0 : i32
  %3 = llvm.icmp "sgt" %arg66, %1 : i32
  %4 = "llvm.select"(%2, %arg67, %arg66) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %5 = "llvm.select"(%3, %arg68, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t4_ugt_slt_128_proof : t4_ugt_slt_128_before ⊑ t4_ugt_slt_128_after := by
  unfold t4_ugt_slt_128_before t4_ugt_slt_128_after
  simp_alive_peephole
  intros
  ---BEGIN t4_ugt_slt_128
  all_goals (try extract_goal ; sorry)
  ---END t4_ugt_slt_128



def t5_ugt_slt_0_before := [llvm|
{
^0(%arg63 : i32, %arg64 : i32, %arg65 : i32):
  %0 = llvm.mlir.constant(-16 : i32) : i32
  %1 = llvm.mlir.constant(16 : i32) : i32
  %2 = llvm.mlir.constant(143 : i32) : i32
  %3 = llvm.icmp "slt" %arg63, %0 : i32
  %4 = "llvm.select"(%3, %arg64, %arg65) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %5 = llvm.add %arg63, %1 : i32
  %6 = llvm.icmp "ugt" %5, %2 : i32
  %7 = "llvm.select"(%6, %4, %arg63) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def t5_ugt_slt_0_after := [llvm|
{
^0(%arg63 : i32, %arg64 : i32, %arg65 : i32):
  %0 = llvm.mlir.constant(-16 : i32) : i32
  %1 = llvm.mlir.constant(127 : i32) : i32
  %2 = llvm.icmp "slt" %arg63, %0 : i32
  %3 = llvm.icmp "sgt" %arg63, %1 : i32
  %4 = "llvm.select"(%2, %arg64, %arg63) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %5 = "llvm.select"(%3, %arg65, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t5_ugt_slt_0_proof : t5_ugt_slt_0_before ⊑ t5_ugt_slt_0_after := by
  unfold t5_ugt_slt_0_before t5_ugt_slt_0_after
  simp_alive_peephole
  intros
  ---BEGIN t5_ugt_slt_0
  all_goals (try extract_goal ; sorry)
  ---END t5_ugt_slt_0



def t6_ugt_sgt_128_before := [llvm|
{
^0(%arg60 : i32, %arg61 : i32, %arg62 : i32):
  %0 = llvm.mlir.constant(127 : i32) : i32
  %1 = llvm.mlir.constant(16 : i32) : i32
  %2 = llvm.mlir.constant(143 : i32) : i32
  %3 = llvm.icmp "sgt" %arg60, %0 : i32
  %4 = "llvm.select"(%3, %arg62, %arg61) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %5 = llvm.add %arg60, %1 : i32
  %6 = llvm.icmp "ugt" %5, %2 : i32
  %7 = "llvm.select"(%6, %4, %arg60) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def t6_ugt_sgt_128_after := [llvm|
{
^0(%arg60 : i32, %arg61 : i32, %arg62 : i32):
  %0 = llvm.mlir.constant(-16 : i32) : i32
  %1 = llvm.mlir.constant(127 : i32) : i32
  %2 = llvm.icmp "slt" %arg60, %0 : i32
  %3 = llvm.icmp "sgt" %arg60, %1 : i32
  %4 = "llvm.select"(%2, %arg61, %arg60) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %5 = "llvm.select"(%3, %arg62, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t6_ugt_sgt_128_proof : t6_ugt_sgt_128_before ⊑ t6_ugt_sgt_128_after := by
  unfold t6_ugt_sgt_128_before t6_ugt_sgt_128_after
  simp_alive_peephole
  intros
  ---BEGIN t6_ugt_sgt_128
  all_goals (try extract_goal ; sorry)
  ---END t6_ugt_sgt_128



def t7_ugt_sgt_neg1_before := [llvm|
{
^0(%arg57 : i32, %arg58 : i32, %arg59 : i32):
  %0 = llvm.mlir.constant(-17 : i32) : i32
  %1 = llvm.mlir.constant(16 : i32) : i32
  %2 = llvm.mlir.constant(143 : i32) : i32
  %3 = llvm.icmp "sgt" %arg57, %0 : i32
  %4 = "llvm.select"(%3, %arg59, %arg58) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %5 = llvm.add %arg57, %1 : i32
  %6 = llvm.icmp "ugt" %5, %2 : i32
  %7 = "llvm.select"(%6, %4, %arg57) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def t7_ugt_sgt_neg1_after := [llvm|
{
^0(%arg57 : i32, %arg58 : i32, %arg59 : i32):
  %0 = llvm.mlir.constant(-16 : i32) : i32
  %1 = llvm.mlir.constant(127 : i32) : i32
  %2 = llvm.icmp "slt" %arg57, %0 : i32
  %3 = llvm.icmp "sgt" %arg57, %1 : i32
  %4 = "llvm.select"(%2, %arg58, %arg57) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %5 = "llvm.select"(%3, %arg59, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t7_ugt_sgt_neg1_proof : t7_ugt_sgt_neg1_before ⊑ t7_ugt_sgt_neg1_after := by
  unfold t7_ugt_sgt_neg1_before t7_ugt_sgt_neg1_after
  simp_alive_peephole
  intros
  ---BEGIN t7_ugt_sgt_neg1
  all_goals (try extract_goal ; sorry)
  ---END t7_ugt_sgt_neg1



def n10_ugt_slt_before := [llvm|
{
^0(%arg48 : i32, %arg49 : i32, %arg50 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(128 : i32) : i32
  %2 = llvm.icmp "slt" %arg48, %0 : i32
  %3 = "llvm.select"(%2, %arg49, %arg50) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.icmp "ugt" %arg48, %1 : i32
  %5 = "llvm.select"(%4, %arg48, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def n10_ugt_slt_after := [llvm|
{
^0(%arg48 : i32, %arg49 : i32, %arg50 : i32):
  %0 = llvm.mlir.constant(128 : i32) : i32
  %1 = llvm.icmp "ugt" %arg48, %0 : i32
  %2 = "llvm.select"(%1, %arg48, %arg50) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem n10_ugt_slt_proof : n10_ugt_slt_before ⊑ n10_ugt_slt_after := by
  unfold n10_ugt_slt_before n10_ugt_slt_after
  simp_alive_peephole
  intros
  ---BEGIN n10_ugt_slt
  all_goals (try extract_goal ; sorry)
  ---END n10_ugt_slt



def n11_uge_slt_before := [llvm|
{
^0(%arg45 : i32, %arg46 : i32, %arg47 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(129 : i32) : i32
  %2 = llvm.icmp "slt" %arg45, %0 : i32
  %3 = "llvm.select"(%2, %arg46, %arg47) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.icmp "ult" %arg45, %1 : i32
  %5 = "llvm.select"(%4, %3, %arg45) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def n11_uge_slt_after := [llvm|
{
^0(%arg45 : i32, %arg46 : i32, %arg47 : i32):
  %0 = llvm.mlir.constant(129 : i32) : i32
  %1 = llvm.icmp "ult" %arg45, %0 : i32
  %2 = "llvm.select"(%1, %arg47, %arg45) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem n11_uge_slt_proof : n11_uge_slt_before ⊑ n11_uge_slt_after := by
  unfold n11_uge_slt_before n11_uge_slt_after
  simp_alive_peephole
  intros
  ---BEGIN n11_uge_slt
  all_goals (try extract_goal ; sorry)
  ---END n11_uge_slt


