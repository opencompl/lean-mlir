import SSA.Projects.InstCombine.tests.proofs.gselecthselect_proof
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
section gselecthselect_statements

def strong_order_cmp_eq_slt_before := [llvm|
{
^0(%arg38 : i32, %arg39 : i32):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(-1 : i8) : i8
  %3 = llvm.icmp "eq" %arg38, %arg39 : i32
  %4 = "llvm.select"(%3, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %5 = llvm.icmp "slt" %arg38, %arg39 : i32
  %6 = "llvm.select"(%5, %2, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def strong_order_cmp_eq_slt_after := [llvm|
{
^0(%arg38 : i32, %arg39 : i32):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.icmp "ne" %arg38, %arg39 : i32
  %2 = llvm.zext %1 : i1 to i8
  %3 = llvm.icmp "slt" %arg38, %arg39 : i32
  %4 = "llvm.select"(%3, %0, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem strong_order_cmp_eq_slt_proof : strong_order_cmp_eq_slt_before ⊑ strong_order_cmp_eq_slt_after := by
  unfold strong_order_cmp_eq_slt_before strong_order_cmp_eq_slt_after
  simp_alive_peephole
  intros
  ---BEGIN strong_order_cmp_eq_slt
  apply strong_order_cmp_eq_slt_thm
  ---END strong_order_cmp_eq_slt



def strong_order_cmp_eq_sgt_before := [llvm|
{
^0(%arg36 : i32, %arg37 : i32):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.mlir.constant(1 : i8) : i8
  %3 = llvm.icmp "eq" %arg36, %arg37 : i32
  %4 = "llvm.select"(%3, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %5 = llvm.icmp "sgt" %arg36, %arg37 : i32
  %6 = "llvm.select"(%5, %2, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def strong_order_cmp_eq_sgt_after := [llvm|
{
^0(%arg36 : i32, %arg37 : i32):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.icmp "ne" %arg36, %arg37 : i32
  %2 = llvm.sext %1 : i1 to i8
  %3 = llvm.icmp "sgt" %arg36, %arg37 : i32
  %4 = "llvm.select"(%3, %0, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem strong_order_cmp_eq_sgt_proof : strong_order_cmp_eq_sgt_before ⊑ strong_order_cmp_eq_sgt_after := by
  unfold strong_order_cmp_eq_sgt_before strong_order_cmp_eq_sgt_after
  simp_alive_peephole
  intros
  ---BEGIN strong_order_cmp_eq_sgt
  apply strong_order_cmp_eq_sgt_thm
  ---END strong_order_cmp_eq_sgt



def strong_order_cmp_eq_ult_before := [llvm|
{
^0(%arg34 : i32, %arg35 : i32):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(-1 : i8) : i8
  %3 = llvm.icmp "eq" %arg34, %arg35 : i32
  %4 = "llvm.select"(%3, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %5 = llvm.icmp "ult" %arg34, %arg35 : i32
  %6 = "llvm.select"(%5, %2, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def strong_order_cmp_eq_ult_after := [llvm|
{
^0(%arg34 : i32, %arg35 : i32):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.icmp "ne" %arg34, %arg35 : i32
  %2 = llvm.zext %1 : i1 to i8
  %3 = llvm.icmp "ult" %arg34, %arg35 : i32
  %4 = "llvm.select"(%3, %0, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem strong_order_cmp_eq_ult_proof : strong_order_cmp_eq_ult_before ⊑ strong_order_cmp_eq_ult_after := by
  unfold strong_order_cmp_eq_ult_before strong_order_cmp_eq_ult_after
  simp_alive_peephole
  intros
  ---BEGIN strong_order_cmp_eq_ult
  apply strong_order_cmp_eq_ult_thm
  ---END strong_order_cmp_eq_ult



def strong_order_cmp_eq_ugt_before := [llvm|
{
^0(%arg32 : i32, %arg33 : i32):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.mlir.constant(1 : i8) : i8
  %3 = llvm.icmp "eq" %arg32, %arg33 : i32
  %4 = "llvm.select"(%3, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %5 = llvm.icmp "ugt" %arg32, %arg33 : i32
  %6 = "llvm.select"(%5, %2, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def strong_order_cmp_eq_ugt_after := [llvm|
{
^0(%arg32 : i32, %arg33 : i32):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.icmp "ne" %arg32, %arg33 : i32
  %2 = llvm.sext %1 : i1 to i8
  %3 = llvm.icmp "ugt" %arg32, %arg33 : i32
  %4 = "llvm.select"(%3, %0, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem strong_order_cmp_eq_ugt_proof : strong_order_cmp_eq_ugt_before ⊑ strong_order_cmp_eq_ugt_after := by
  unfold strong_order_cmp_eq_ugt_before strong_order_cmp_eq_ugt_after
  simp_alive_peephole
  intros
  ---BEGIN strong_order_cmp_eq_ugt
  apply strong_order_cmp_eq_ugt_thm
  ---END strong_order_cmp_eq_ugt


