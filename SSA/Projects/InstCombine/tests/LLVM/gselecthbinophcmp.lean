
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
section gselecthbinophcmp_statements

def select_xor_icmp_before := [llvm|
{
^0(%arg293 : i32, %arg294 : i32, %arg295 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "eq" %arg293, %0 : i32
  %2 = llvm.xor %arg293, %arg295 : i32
  %3 = "llvm.select"(%1, %2, %arg294) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def select_xor_icmp_after := [llvm|
{
^0(%arg293 : i32, %arg294 : i32, %arg295 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "eq" %arg293, %0 : i32
  %2 = "llvm.select"(%1, %arg295, %arg294) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_xor_icmp_proof : select_xor_icmp_before ⊑ select_xor_icmp_after := by
  unfold select_xor_icmp_before select_xor_icmp_after
  simp_alive_peephole
  intros
  ---BEGIN select_xor_icmp
  all_goals (try extract_goal ; sorry)
  ---END select_xor_icmp



def select_xor_icmp2_before := [llvm|
{
^0(%arg290 : i32, %arg291 : i32, %arg292 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "ne" %arg290, %0 : i32
  %2 = llvm.xor %arg290, %arg292 : i32
  %3 = "llvm.select"(%1, %arg291, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def select_xor_icmp2_after := [llvm|
{
^0(%arg290 : i32, %arg291 : i32, %arg292 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "eq" %arg290, %0 : i32
  %2 = "llvm.select"(%1, %arg292, %arg291) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_xor_icmp2_proof : select_xor_icmp2_before ⊑ select_xor_icmp2_after := by
  unfold select_xor_icmp2_before select_xor_icmp2_after
  simp_alive_peephole
  intros
  ---BEGIN select_xor_icmp2
  all_goals (try extract_goal ; sorry)
  ---END select_xor_icmp2



def select_xor_icmp_meta_before := [llvm|
{
^0(%arg287 : i32, %arg288 : i32, %arg289 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "eq" %arg287, %0 : i32
  %2 = llvm.xor %arg287, %arg289 : i32
  %3 = "llvm.select"(%1, %2, %arg288) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def select_xor_icmp_meta_after := [llvm|
{
^0(%arg287 : i32, %arg288 : i32, %arg289 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "eq" %arg287, %0 : i32
  %2 = "llvm.select"(%1, %arg289, %arg288) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_xor_icmp_meta_proof : select_xor_icmp_meta_before ⊑ select_xor_icmp_meta_after := by
  unfold select_xor_icmp_meta_before select_xor_icmp_meta_after
  simp_alive_peephole
  intros
  ---BEGIN select_xor_icmp_meta
  all_goals (try extract_goal ; sorry)
  ---END select_xor_icmp_meta



def select_mul_icmp_before := [llvm|
{
^0(%arg284 : i32, %arg285 : i32, %arg286 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.icmp "eq" %arg284, %0 : i32
  %2 = llvm.mul %arg284, %arg286 : i32
  %3 = "llvm.select"(%1, %2, %arg285) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def select_mul_icmp_after := [llvm|
{
^0(%arg284 : i32, %arg285 : i32, %arg286 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.icmp "eq" %arg284, %0 : i32
  %2 = "llvm.select"(%1, %arg286, %arg285) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_mul_icmp_proof : select_mul_icmp_before ⊑ select_mul_icmp_after := by
  unfold select_mul_icmp_before select_mul_icmp_after
  simp_alive_peephole
  intros
  ---BEGIN select_mul_icmp
  all_goals (try extract_goal ; sorry)
  ---END select_mul_icmp



def select_add_icmp_before := [llvm|
{
^0(%arg281 : i32, %arg282 : i32, %arg283 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "eq" %arg281, %0 : i32
  %2 = llvm.add %arg281, %arg283 : i32
  %3 = "llvm.select"(%1, %2, %arg282) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def select_add_icmp_after := [llvm|
{
^0(%arg281 : i32, %arg282 : i32, %arg283 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "eq" %arg281, %0 : i32
  %2 = "llvm.select"(%1, %arg283, %arg282) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_add_icmp_proof : select_add_icmp_before ⊑ select_add_icmp_after := by
  unfold select_add_icmp_before select_add_icmp_after
  simp_alive_peephole
  intros
  ---BEGIN select_add_icmp
  all_goals (try extract_goal ; sorry)
  ---END select_add_icmp



def select_or_icmp_before := [llvm|
{
^0(%arg278 : i32, %arg279 : i32, %arg280 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "eq" %arg278, %0 : i32
  %2 = llvm.or %arg278, %arg280 : i32
  %3 = "llvm.select"(%1, %2, %arg279) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def select_or_icmp_after := [llvm|
{
^0(%arg278 : i32, %arg279 : i32, %arg280 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "eq" %arg278, %0 : i32
  %2 = "llvm.select"(%1, %arg280, %arg279) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_or_icmp_proof : select_or_icmp_before ⊑ select_or_icmp_after := by
  unfold select_or_icmp_before select_or_icmp_after
  simp_alive_peephole
  intros
  ---BEGIN select_or_icmp
  all_goals (try extract_goal ; sorry)
  ---END select_or_icmp



def select_and_icmp_before := [llvm|
{
^0(%arg275 : i32, %arg276 : i32, %arg277 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.icmp "eq" %arg275, %0 : i32
  %2 = llvm.and %arg275, %arg277 : i32
  %3 = "llvm.select"(%1, %2, %arg276) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def select_and_icmp_after := [llvm|
{
^0(%arg275 : i32, %arg276 : i32, %arg277 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.icmp "eq" %arg275, %0 : i32
  %2 = "llvm.select"(%1, %arg277, %arg276) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_and_icmp_proof : select_and_icmp_before ⊑ select_and_icmp_after := by
  unfold select_and_icmp_before select_and_icmp_after
  simp_alive_peephole
  intros
  ---BEGIN select_and_icmp
  all_goals (try extract_goal ; sorry)
  ---END select_and_icmp



def select_xor_inv_icmp_before := [llvm|
{
^0(%arg266 : i32, %arg267 : i32, %arg268 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "eq" %arg266, %0 : i32
  %2 = llvm.xor %arg268, %arg266 : i32
  %3 = "llvm.select"(%1, %2, %arg267) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def select_xor_inv_icmp_after := [llvm|
{
^0(%arg266 : i32, %arg267 : i32, %arg268 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "eq" %arg266, %0 : i32
  %2 = "llvm.select"(%1, %arg268, %arg267) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_xor_inv_icmp_proof : select_xor_inv_icmp_before ⊑ select_xor_inv_icmp_after := by
  unfold select_xor_inv_icmp_before select_xor_inv_icmp_after
  simp_alive_peephole
  intros
  ---BEGIN select_xor_inv_icmp
  all_goals (try extract_goal ; sorry)
  ---END select_xor_inv_icmp



def select_sub_icmp_before := [llvm|
{
^0(%arg214 : i32, %arg215 : i32, %arg216 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "eq" %arg214, %0 : i32
  %2 = llvm.sub %arg216, %arg214 : i32
  %3 = "llvm.select"(%1, %2, %arg215) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def select_sub_icmp_after := [llvm|
{
^0(%arg214 : i32, %arg215 : i32, %arg216 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "eq" %arg214, %0 : i32
  %2 = "llvm.select"(%1, %arg216, %arg215) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_sub_icmp_proof : select_sub_icmp_before ⊑ select_sub_icmp_after := by
  unfold select_sub_icmp_before select_sub_icmp_after
  simp_alive_peephole
  intros
  ---BEGIN select_sub_icmp
  all_goals (try extract_goal ; sorry)
  ---END select_sub_icmp



def select_lshr_icmp_before := [llvm|
{
^0(%arg199 : i32, %arg200 : i32, %arg201 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "eq" %arg199, %0 : i32
  %2 = llvm.lshr %arg201, %arg199 : i32
  %3 = "llvm.select"(%1, %2, %arg200) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def select_lshr_icmp_after := [llvm|
{
^0(%arg199 : i32, %arg200 : i32, %arg201 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "eq" %arg199, %0 : i32
  %2 = "llvm.select"(%1, %arg201, %arg200) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_lshr_icmp_proof : select_lshr_icmp_before ⊑ select_lshr_icmp_after := by
  unfold select_lshr_icmp_before select_lshr_icmp_after
  simp_alive_peephole
  intros
  ---BEGIN select_lshr_icmp
  all_goals (try extract_goal ; sorry)
  ---END select_lshr_icmp



def select_udiv_icmp_before := [llvm|
{
^0(%arg193 : i32, %arg194 : i32, %arg195 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.icmp "eq" %arg193, %0 : i32
  %2 = llvm.udiv %arg195, %arg193 : i32
  %3 = "llvm.select"(%1, %2, %arg194) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def select_udiv_icmp_after := [llvm|
{
^0(%arg193 : i32, %arg194 : i32, %arg195 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.icmp "eq" %arg193, %0 : i32
  %2 = "llvm.select"(%1, %arg195, %arg194) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_udiv_icmp_proof : select_udiv_icmp_before ⊑ select_udiv_icmp_after := by
  unfold select_udiv_icmp_before select_udiv_icmp_after
  simp_alive_peephole
  intros
  ---BEGIN select_udiv_icmp
  all_goals (try extract_goal ; sorry)
  ---END select_udiv_icmp



def select_xor_icmp_bad_3_before := [llvm|
{
^0(%arg179 : i32, %arg180 : i32, %arg181 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.icmp "eq" %arg179, %0 : i32
  %2 = llvm.xor %arg179, %arg181 : i32
  %3 = "llvm.select"(%1, %2, %arg180) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def select_xor_icmp_bad_3_after := [llvm|
{
^0(%arg179 : i32, %arg180 : i32, %arg181 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.icmp "eq" %arg179, %0 : i32
  %2 = llvm.xor %arg181, %0 : i32
  %3 = "llvm.select"(%1, %2, %arg180) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_xor_icmp_bad_3_proof : select_xor_icmp_bad_3_before ⊑ select_xor_icmp_bad_3_after := by
  unfold select_xor_icmp_bad_3_before select_xor_icmp_bad_3_after
  simp_alive_peephole
  intros
  ---BEGIN select_xor_icmp_bad_3
  all_goals (try extract_goal ; sorry)
  ---END select_xor_icmp_bad_3



def select_xor_icmp_bad_5_before := [llvm|
{
^0(%arg172 : i32, %arg173 : i32, %arg174 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "ne" %arg172, %0 : i32
  %2 = llvm.xor %arg172, %arg174 : i32
  %3 = "llvm.select"(%1, %2, %arg173) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def select_xor_icmp_bad_5_after := [llvm|
{
^0(%arg172 : i32, %arg173 : i32, %arg174 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "eq" %arg172, %0 : i32
  %2 = llvm.xor %arg172, %arg174 : i32
  %3 = "llvm.select"(%1, %arg173, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_xor_icmp_bad_5_proof : select_xor_icmp_bad_5_before ⊑ select_xor_icmp_bad_5_after := by
  unfold select_xor_icmp_bad_5_before select_xor_icmp_bad_5_after
  simp_alive_peephole
  intros
  ---BEGIN select_xor_icmp_bad_5
  all_goals (try extract_goal ; sorry)
  ---END select_xor_icmp_bad_5



def select_xor_icmp_bad_6_before := [llvm|
{
^0(%arg169 : i32, %arg170 : i32, %arg171 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.icmp "ne" %arg169, %0 : i32
  %2 = llvm.xor %arg169, %arg171 : i32
  %3 = "llvm.select"(%1, %arg170, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def select_xor_icmp_bad_6_after := [llvm|
{
^0(%arg169 : i32, %arg170 : i32, %arg171 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.icmp "eq" %arg169, %0 : i32
  %2 = llvm.xor %arg171, %0 : i32
  %3 = "llvm.select"(%1, %2, %arg170) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_xor_icmp_bad_6_proof : select_xor_icmp_bad_6_before ⊑ select_xor_icmp_bad_6_after := by
  unfold select_xor_icmp_bad_6_before select_xor_icmp_bad_6_after
  simp_alive_peephole
  intros
  ---BEGIN select_xor_icmp_bad_6
  all_goals (try extract_goal ; sorry)
  ---END select_xor_icmp_bad_6



def select_mul_icmp_bad_before := [llvm|
{
^0(%arg158 : i32, %arg159 : i32, %arg160 : i32, %arg161 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.icmp "eq" %arg158, %0 : i32
  %2 = llvm.mul %arg158, %arg160 : i32
  %3 = "llvm.select"(%1, %2, %arg159) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def select_mul_icmp_bad_after := [llvm|
{
^0(%arg158 : i32, %arg159 : i32, %arg160 : i32, %arg161 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.icmp "eq" %arg158, %0 : i32
  %2 = llvm.mul %arg160, %0 : i32
  %3 = "llvm.select"(%1, %2, %arg159) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_mul_icmp_bad_proof : select_mul_icmp_bad_before ⊑ select_mul_icmp_bad_after := by
  unfold select_mul_icmp_bad_before select_mul_icmp_bad_after
  simp_alive_peephole
  intros
  ---BEGIN select_mul_icmp_bad
  all_goals (try extract_goal ; sorry)
  ---END select_mul_icmp_bad



def select_add_icmp_bad_before := [llvm|
{
^0(%arg155 : i32, %arg156 : i32, %arg157 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.icmp "eq" %arg155, %0 : i32
  %2 = llvm.add %arg155, %arg157 : i32
  %3 = "llvm.select"(%1, %2, %arg156) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def select_add_icmp_bad_after := [llvm|
{
^0(%arg155 : i32, %arg156 : i32, %arg157 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.icmp "eq" %arg155, %0 : i32
  %2 = llvm.add %arg157, %0 : i32
  %3 = "llvm.select"(%1, %2, %arg156) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_add_icmp_bad_proof : select_add_icmp_bad_before ⊑ select_add_icmp_bad_after := by
  unfold select_add_icmp_bad_before select_add_icmp_bad_after
  simp_alive_peephole
  intros
  ---BEGIN select_add_icmp_bad
  all_goals (try extract_goal ; sorry)
  ---END select_add_icmp_bad



def select_and_icmp_zero_before := [llvm|
{
^0(%arg152 : i32, %arg153 : i32, %arg154 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "eq" %arg152, %0 : i32
  %2 = llvm.and %arg152, %arg154 : i32
  %3 = "llvm.select"(%1, %2, %arg153) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def select_and_icmp_zero_after := [llvm|
{
^0(%arg152 : i32, %arg153 : i32, %arg154 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "eq" %arg152, %0 : i32
  %2 = "llvm.select"(%1, %0, %arg153) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_and_icmp_zero_proof : select_and_icmp_zero_before ⊑ select_and_icmp_zero_after := by
  unfold select_and_icmp_zero_before select_and_icmp_zero_after
  simp_alive_peephole
  intros
  ---BEGIN select_and_icmp_zero
  all_goals (try extract_goal ; sorry)
  ---END select_and_icmp_zero



def select_or_icmp_bad_before := [llvm|
{
^0(%arg149 : i32, %arg150 : i32, %arg151 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.icmp "eq" %arg149, %0 : i32
  %2 = llvm.or %arg149, %arg151 : i32
  %3 = "llvm.select"(%1, %2, %arg150) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def select_or_icmp_bad_after := [llvm|
{
^0(%arg149 : i32, %arg150 : i32, %arg151 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.icmp "eq" %arg149, %0 : i32
  %2 = llvm.or %arg151, %0 : i32
  %3 = "llvm.select"(%1, %2, %arg150) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_or_icmp_bad_proof : select_or_icmp_bad_before ⊑ select_or_icmp_bad_after := by
  unfold select_or_icmp_bad_before select_or_icmp_bad_after
  simp_alive_peephole
  intros
  ---BEGIN select_or_icmp_bad
  all_goals (try extract_goal ; sorry)
  ---END select_or_icmp_bad



def select_lshr_icmp_const_before := [llvm|
{
^0(%arg148 : i32):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.mlir.constant(5 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.icmp "ugt" %arg148, %0 : i32
  %4 = llvm.lshr %arg148, %1 : i32
  %5 = "llvm.select"(%3, %4, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def select_lshr_icmp_const_after := [llvm|
{
^0(%arg148 : i32):
  %0 = llvm.mlir.constant(5 : i32) : i32
  %1 = llvm.lshr %arg148, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_lshr_icmp_const_proof : select_lshr_icmp_const_before ⊑ select_lshr_icmp_const_after := by
  unfold select_lshr_icmp_const_before select_lshr_icmp_const_after
  simp_alive_peephole
  intros
  ---BEGIN select_lshr_icmp_const
  all_goals (try extract_goal ; sorry)
  ---END select_lshr_icmp_const



def select_lshr_icmp_const_reordered_before := [llvm|
{
^0(%arg147 : i32):
  %0 = llvm.mlir.constant(32 : i32) : i32
  %1 = llvm.mlir.constant(5 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.icmp "ult" %arg147, %0 : i32
  %4 = llvm.lshr %arg147, %1 : i32
  %5 = "llvm.select"(%3, %2, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def select_lshr_icmp_const_reordered_after := [llvm|
{
^0(%arg147 : i32):
  %0 = llvm.mlir.constant(5 : i32) : i32
  %1 = llvm.lshr %arg147, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_lshr_icmp_const_reordered_proof : select_lshr_icmp_const_reordered_before ⊑ select_lshr_icmp_const_reordered_after := by
  unfold select_lshr_icmp_const_reordered_before select_lshr_icmp_const_reordered_after
  simp_alive_peephole
  intros
  ---BEGIN select_lshr_icmp_const_reordered
  all_goals (try extract_goal ; sorry)
  ---END select_lshr_icmp_const_reordered



def select_exact_lshr_icmp_const_before := [llvm|
{
^0(%arg146 : i32):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.mlir.constant(5 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.icmp "ugt" %arg146, %0 : i32
  %4 = llvm.lshr exact %arg146, %1 : i32
  %5 = "llvm.select"(%3, %4, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def select_exact_lshr_icmp_const_after := [llvm|
{
^0(%arg146 : i32):
  %0 = llvm.mlir.constant(5 : i32) : i32
  %1 = llvm.lshr %arg146, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_exact_lshr_icmp_const_proof : select_exact_lshr_icmp_const_before ⊑ select_exact_lshr_icmp_const_after := by
  unfold select_exact_lshr_icmp_const_before select_exact_lshr_icmp_const_after
  simp_alive_peephole
  intros
  ---BEGIN select_exact_lshr_icmp_const
  all_goals (try extract_goal ; sorry)
  ---END select_exact_lshr_icmp_const



def select_sub_icmp_bad_before := [llvm|
{
^0(%arg71 : i32, %arg72 : i32, %arg73 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "eq" %arg71, %0 : i32
  %2 = llvm.sub %arg71, %arg73 : i32
  %3 = "llvm.select"(%1, %2, %arg72) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def select_sub_icmp_bad_after := [llvm|
{
^0(%arg71 : i32, %arg72 : i32, %arg73 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "eq" %arg71, %0 : i32
  %2 = llvm.sub %0, %arg73 : i32
  %3 = "llvm.select"(%1, %2, %arg72) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_sub_icmp_bad_proof : select_sub_icmp_bad_before ⊑ select_sub_icmp_bad_after := by
  unfold select_sub_icmp_bad_before select_sub_icmp_bad_after
  simp_alive_peephole
  intros
  ---BEGIN select_sub_icmp_bad
  all_goals (try extract_goal ; sorry)
  ---END select_sub_icmp_bad



def select_sub_icmp_bad_2_before := [llvm|
{
^0(%arg68 : i32, %arg69 : i32, %arg70 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.icmp "eq" %arg68, %0 : i32
  %2 = llvm.sub %arg70, %arg68 : i32
  %3 = "llvm.select"(%1, %2, %arg69) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def select_sub_icmp_bad_2_after := [llvm|
{
^0(%arg68 : i32, %arg69 : i32, %arg70 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.icmp "eq" %arg68, %0 : i32
  %3 = llvm.add %arg70, %1 : i32
  %4 = "llvm.select"(%2, %3, %arg69) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_sub_icmp_bad_2_proof : select_sub_icmp_bad_2_before ⊑ select_sub_icmp_bad_2_after := by
  unfold select_sub_icmp_bad_2_before select_sub_icmp_bad_2_after
  simp_alive_peephole
  intros
  ---BEGIN select_sub_icmp_bad_2
  all_goals (try extract_goal ; sorry)
  ---END select_sub_icmp_bad_2



def select_shl_icmp_bad_before := [llvm|
{
^0(%arg51 : i32, %arg52 : i32, %arg53 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.icmp "eq" %arg51, %0 : i32
  %2 = llvm.shl %arg53, %arg51 : i32
  %3 = "llvm.select"(%1, %2, %arg52) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def select_shl_icmp_bad_after := [llvm|
{
^0(%arg51 : i32, %arg52 : i32, %arg53 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.icmp "eq" %arg51, %0 : i32
  %2 = llvm.shl %arg53, %0 : i32
  %3 = "llvm.select"(%1, %2, %arg52) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_shl_icmp_bad_proof : select_shl_icmp_bad_before ⊑ select_shl_icmp_bad_after := by
  unfold select_shl_icmp_bad_before select_shl_icmp_bad_after
  simp_alive_peephole
  intros
  ---BEGIN select_shl_icmp_bad
  all_goals (try extract_goal ; sorry)
  ---END select_shl_icmp_bad



def select_lshr_icmp_bad_before := [llvm|
{
^0(%arg48 : i32, %arg49 : i32, %arg50 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.icmp "eq" %arg48, %0 : i32
  %2 = llvm.lshr %arg50, %arg48 : i32
  %3 = "llvm.select"(%1, %2, %arg49) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def select_lshr_icmp_bad_after := [llvm|
{
^0(%arg48 : i32, %arg49 : i32, %arg50 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.icmp "eq" %arg48, %0 : i32
  %2 = llvm.lshr %arg50, %0 : i32
  %3 = "llvm.select"(%1, %2, %arg49) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_lshr_icmp_bad_proof : select_lshr_icmp_bad_before ⊑ select_lshr_icmp_bad_after := by
  unfold select_lshr_icmp_bad_before select_lshr_icmp_bad_after
  simp_alive_peephole
  intros
  ---BEGIN select_lshr_icmp_bad
  all_goals (try extract_goal ; sorry)
  ---END select_lshr_icmp_bad



def select_ashr_icmp_bad_before := [llvm|
{
^0(%arg45 : i32, %arg46 : i32, %arg47 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.icmp "eq" %arg45, %0 : i32
  %2 = llvm.ashr %arg47, %arg45 : i32
  %3 = "llvm.select"(%1, %2, %arg46) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def select_ashr_icmp_bad_after := [llvm|
{
^0(%arg45 : i32, %arg46 : i32, %arg47 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.icmp "eq" %arg45, %0 : i32
  %2 = llvm.ashr %arg47, %0 : i32
  %3 = "llvm.select"(%1, %2, %arg46) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_ashr_icmp_bad_proof : select_ashr_icmp_bad_before ⊑ select_ashr_icmp_bad_after := by
  unfold select_ashr_icmp_bad_before select_ashr_icmp_bad_after
  simp_alive_peephole
  intros
  ---BEGIN select_ashr_icmp_bad
  all_goals (try extract_goal ; sorry)
  ---END select_ashr_icmp_bad



def select_replace_one_use_before := [llvm|
{
^0(%arg37 : i32, %arg38 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "eq" %arg37, %0 : i32
  %2 = llvm.sub %arg37, %arg38 : i32
  %3 = "llvm.select"(%1, %2, %arg38) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def select_replace_one_use_after := [llvm|
{
^0(%arg37 : i32, %arg38 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "eq" %arg37, %0 : i32
  %2 = llvm.sub %0, %arg38 : i32
  %3 = "llvm.select"(%1, %2, %arg38) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_replace_one_use_proof : select_replace_one_use_before ⊑ select_replace_one_use_after := by
  unfold select_replace_one_use_before select_replace_one_use_after
  simp_alive_peephole
  intros
  ---BEGIN select_replace_one_use
  all_goals (try extract_goal ; sorry)
  ---END select_replace_one_use



def select_replace_nested_before := [llvm|
{
^0(%arg29 : i32, %arg30 : i32, %arg31 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "eq" %arg29, %0 : i32
  %2 = llvm.sub %arg30, %arg29 : i32
  %3 = llvm.add %2, %arg31 : i32
  %4 = "llvm.select"(%1, %3, %arg30) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def select_replace_nested_after := [llvm|
{
^0(%arg29 : i32, %arg30 : i32, %arg31 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "eq" %arg29, %0 : i32
  %2 = "llvm.select"(%1, %arg31, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %3 = llvm.add %arg30, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_replace_nested_proof : select_replace_nested_before ⊑ select_replace_nested_after := by
  unfold select_replace_nested_before select_replace_nested_after
  simp_alive_peephole
  intros
  ---BEGIN select_replace_nested
  all_goals (try extract_goal ; sorry)
  ---END select_replace_nested



def select_replace_nested_no_simplify_before := [llvm|
{
^0(%arg23 : i32, %arg24 : i32, %arg25 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.icmp "eq" %arg23, %0 : i32
  %2 = llvm.sub %arg24, %arg23 : i32
  %3 = llvm.add %2, %arg25 : i32
  %4 = "llvm.select"(%1, %3, %arg24) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def select_replace_nested_no_simplify_after := [llvm|
{
^0(%arg23 : i32, %arg24 : i32, %arg25 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.icmp "eq" %arg23, %0 : i32
  %3 = llvm.add %arg24, %1 : i32
  %4 = llvm.add %3, %arg25 : i32
  %5 = "llvm.select"(%2, %4, %arg24) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_replace_nested_no_simplify_proof : select_replace_nested_no_simplify_before ⊑ select_replace_nested_no_simplify_after := by
  unfold select_replace_nested_no_simplify_before select_replace_nested_no_simplify_after
  simp_alive_peephole
  intros
  ---BEGIN select_replace_nested_no_simplify
  all_goals (try extract_goal ; sorry)
  ---END select_replace_nested_no_simplify



def select_replace_udiv_non_speculatable_before := [llvm|
{
^0(%arg1 : i32, %arg2 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "eq" %arg1, %0 : i32
  %2 = llvm.udiv %arg2, %arg1 : i32
  %3 = "llvm.select"(%1, %2, %arg2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def select_replace_udiv_non_speculatable_after := [llvm|
{
^0(%arg1 : i32, %arg2 : i32):
  "llvm.return"(%arg2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_replace_udiv_non_speculatable_proof : select_replace_udiv_non_speculatable_before ⊑ select_replace_udiv_non_speculatable_after := by
  unfold select_replace_udiv_non_speculatable_before select_replace_udiv_non_speculatable_after
  simp_alive_peephole
  intros
  ---BEGIN select_replace_udiv_non_speculatable
  all_goals (try extract_goal ; sorry)
  ---END select_replace_udiv_non_speculatable


