import SSA.Projects.InstCombine.tests.proofs.gcanonicalizehclamphlikehpatternhbetweenhzerohandhpositivehthreshold_proof
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
section gcanonicalizehclamphlikehpatternhbetweenhzerohandhpositivehthreshold_statements

def t0_ult_slt_65536_before := [llvm|
{
^0(%arg66 : i32, %arg67 : i32, %arg68 : i32):
  %0 = llvm.mlir.constant(65536 : i32) : i32
  %1 = llvm.icmp "slt" %arg66, %0 : i32
  %2 = "llvm.select"(%1, %arg67, %arg68) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %3 = llvm.icmp "ult" %arg66, %0 : i32
  %4 = "llvm.select"(%3, %arg66, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def t0_ult_slt_65536_after := [llvm|
{
^0(%arg66 : i32, %arg67 : i32, %arg68 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(65535 : i32) : i32
  %2 = llvm.icmp "slt" %arg66, %0 : i32
  %3 = llvm.icmp "sgt" %arg66, %1 : i32
  %4 = "llvm.select"(%2, %arg67, %arg66) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %5 = "llvm.select"(%3, %arg68, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t0_ult_slt_65536_proof : t0_ult_slt_65536_before ⊑ t0_ult_slt_65536_after := by
  unfold t0_ult_slt_65536_before t0_ult_slt_65536_after
  simp_alive_peephole
  intros
  ---BEGIN t0_ult_slt_65536
  apply t0_ult_slt_65536_thm
  ---END t0_ult_slt_65536



def t1_ult_slt_0_before := [llvm|
{
^0(%arg63 : i32, %arg64 : i32, %arg65 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(65536 : i32) : i32
  %2 = llvm.icmp "slt" %arg63, %0 : i32
  %3 = "llvm.select"(%2, %arg64, %arg65) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.icmp "ult" %arg63, %1 : i32
  %5 = "llvm.select"(%4, %arg63, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def t1_ult_slt_0_after := [llvm|
{
^0(%arg63 : i32, %arg64 : i32, %arg65 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(65535 : i32) : i32
  %2 = llvm.icmp "slt" %arg63, %0 : i32
  %3 = llvm.icmp "sgt" %arg63, %1 : i32
  %4 = "llvm.select"(%2, %arg64, %arg63) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %5 = "llvm.select"(%3, %arg65, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t1_ult_slt_0_proof : t1_ult_slt_0_before ⊑ t1_ult_slt_0_after := by
  unfold t1_ult_slt_0_before t1_ult_slt_0_after
  simp_alive_peephole
  intros
  ---BEGIN t1_ult_slt_0
  apply t1_ult_slt_0_thm
  ---END t1_ult_slt_0



def t2_ult_sgt_65536_before := [llvm|
{
^0(%arg60 : i32, %arg61 : i32, %arg62 : i32):
  %0 = llvm.mlir.constant(65535 : i32) : i32
  %1 = llvm.mlir.constant(65536 : i32) : i32
  %2 = llvm.icmp "sgt" %arg60, %0 : i32
  %3 = "llvm.select"(%2, %arg62, %arg61) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.icmp "ult" %arg60, %1 : i32
  %5 = "llvm.select"(%4, %arg60, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def t2_ult_sgt_65536_after := [llvm|
{
^0(%arg60 : i32, %arg61 : i32, %arg62 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(65535 : i32) : i32
  %2 = llvm.icmp "slt" %arg60, %0 : i32
  %3 = llvm.icmp "sgt" %arg60, %1 : i32
  %4 = "llvm.select"(%2, %arg61, %arg60) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %5 = "llvm.select"(%3, %arg62, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t2_ult_sgt_65536_proof : t2_ult_sgt_65536_before ⊑ t2_ult_sgt_65536_after := by
  unfold t2_ult_sgt_65536_before t2_ult_sgt_65536_after
  simp_alive_peephole
  intros
  ---BEGIN t2_ult_sgt_65536
  apply t2_ult_sgt_65536_thm
  ---END t2_ult_sgt_65536



def t3_ult_sgt_neg1_before := [llvm|
{
^0(%arg57 : i32, %arg58 : i32, %arg59 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(65536 : i32) : i32
  %2 = llvm.icmp "sgt" %arg57, %0 : i32
  %3 = "llvm.select"(%2, %arg59, %arg58) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.icmp "ult" %arg57, %1 : i32
  %5 = "llvm.select"(%4, %arg57, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def t3_ult_sgt_neg1_after := [llvm|
{
^0(%arg57 : i32, %arg58 : i32, %arg59 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(65535 : i32) : i32
  %2 = llvm.icmp "slt" %arg57, %0 : i32
  %3 = llvm.icmp "sgt" %arg57, %1 : i32
  %4 = "llvm.select"(%2, %arg58, %arg57) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %5 = "llvm.select"(%3, %arg59, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t3_ult_sgt_neg1_proof : t3_ult_sgt_neg1_before ⊑ t3_ult_sgt_neg1_after := by
  unfold t3_ult_sgt_neg1_before t3_ult_sgt_neg1_after
  simp_alive_peephole
  intros
  ---BEGIN t3_ult_sgt_neg1
  apply t3_ult_sgt_neg1_thm
  ---END t3_ult_sgt_neg1



def t4_ugt_slt_65536_before := [llvm|
{
^0(%arg54 : i32, %arg55 : i32, %arg56 : i32):
  %0 = llvm.mlir.constant(65536 : i32) : i32
  %1 = llvm.mlir.constant(65535 : i32) : i32
  %2 = llvm.icmp "slt" %arg54, %0 : i32
  %3 = "llvm.select"(%2, %arg55, %arg56) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.icmp "ugt" %arg54, %1 : i32
  %5 = "llvm.select"(%4, %3, %arg54) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def t4_ugt_slt_65536_after := [llvm|
{
^0(%arg54 : i32, %arg55 : i32, %arg56 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(65535 : i32) : i32
  %2 = llvm.icmp "slt" %arg54, %0 : i32
  %3 = llvm.icmp "sgt" %arg54, %1 : i32
  %4 = "llvm.select"(%2, %arg55, %arg54) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %5 = "llvm.select"(%3, %arg56, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t4_ugt_slt_65536_proof : t4_ugt_slt_65536_before ⊑ t4_ugt_slt_65536_after := by
  unfold t4_ugt_slt_65536_before t4_ugt_slt_65536_after
  simp_alive_peephole
  intros
  ---BEGIN t4_ugt_slt_65536
  apply t4_ugt_slt_65536_thm
  ---END t4_ugt_slt_65536



def t5_ugt_slt_0_before := [llvm|
{
^0(%arg51 : i32, %arg52 : i32, %arg53 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(65535 : i32) : i32
  %2 = llvm.icmp "slt" %arg51, %0 : i32
  %3 = "llvm.select"(%2, %arg52, %arg53) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.icmp "ugt" %arg51, %1 : i32
  %5 = "llvm.select"(%4, %3, %arg51) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def t5_ugt_slt_0_after := [llvm|
{
^0(%arg51 : i32, %arg52 : i32, %arg53 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(65535 : i32) : i32
  %2 = llvm.icmp "slt" %arg51, %0 : i32
  %3 = llvm.icmp "sgt" %arg51, %1 : i32
  %4 = "llvm.select"(%2, %arg52, %arg51) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %5 = "llvm.select"(%3, %arg53, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t5_ugt_slt_0_proof : t5_ugt_slt_0_before ⊑ t5_ugt_slt_0_after := by
  unfold t5_ugt_slt_0_before t5_ugt_slt_0_after
  simp_alive_peephole
  intros
  ---BEGIN t5_ugt_slt_0
  apply t5_ugt_slt_0_thm
  ---END t5_ugt_slt_0



def t6_ugt_sgt_65536_before := [llvm|
{
^0(%arg48 : i32, %arg49 : i32, %arg50 : i32):
  %0 = llvm.mlir.constant(65535 : i32) : i32
  %1 = llvm.icmp "sgt" %arg48, %0 : i32
  %2 = "llvm.select"(%1, %arg50, %arg49) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %3 = llvm.icmp "ugt" %arg48, %0 : i32
  %4 = "llvm.select"(%3, %2, %arg48) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def t6_ugt_sgt_65536_after := [llvm|
{
^0(%arg48 : i32, %arg49 : i32, %arg50 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(65535 : i32) : i32
  %2 = llvm.icmp "slt" %arg48, %0 : i32
  %3 = llvm.icmp "sgt" %arg48, %1 : i32
  %4 = "llvm.select"(%2, %arg49, %arg48) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %5 = "llvm.select"(%3, %arg50, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t6_ugt_sgt_65536_proof : t6_ugt_sgt_65536_before ⊑ t6_ugt_sgt_65536_after := by
  unfold t6_ugt_sgt_65536_before t6_ugt_sgt_65536_after
  simp_alive_peephole
  intros
  ---BEGIN t6_ugt_sgt_65536
  apply t6_ugt_sgt_65536_thm
  ---END t6_ugt_sgt_65536



def t7_ugt_sgt_neg1_before := [llvm|
{
^0(%arg45 : i32, %arg46 : i32, %arg47 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(65535 : i32) : i32
  %2 = llvm.icmp "sgt" %arg45, %0 : i32
  %3 = "llvm.select"(%2, %arg47, %arg46) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.icmp "ugt" %arg45, %1 : i32
  %5 = "llvm.select"(%4, %3, %arg45) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def t7_ugt_sgt_neg1_after := [llvm|
{
^0(%arg45 : i32, %arg46 : i32, %arg47 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(65535 : i32) : i32
  %2 = llvm.icmp "slt" %arg45, %0 : i32
  %3 = llvm.icmp "sgt" %arg45, %1 : i32
  %4 = "llvm.select"(%2, %arg46, %arg45) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %5 = "llvm.select"(%3, %arg47, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t7_ugt_sgt_neg1_proof : t7_ugt_sgt_neg1_before ⊑ t7_ugt_sgt_neg1_after := by
  unfold t7_ugt_sgt_neg1_before t7_ugt_sgt_neg1_after
  simp_alive_peephole
  intros
  ---BEGIN t7_ugt_sgt_neg1
  apply t7_ugt_sgt_neg1_thm
  ---END t7_ugt_sgt_neg1


