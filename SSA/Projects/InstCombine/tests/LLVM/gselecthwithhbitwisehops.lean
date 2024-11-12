
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
section gselecthwithhbitwisehops_statements

def select_icmp_eq_and_1_0_or_2_before := [llvm|
{
^0(%arg255 : i32, %arg256 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(2 : i32) : i32
  %3 = llvm.and %arg255, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.or %arg256, %2 : i32
  %6 = "llvm.select"(%4, %arg256, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def select_icmp_eq_and_1_0_or_2_after := [llvm|
{
^0(%arg255 : i32, %arg256 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.shl %arg255, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.or %arg256, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_icmp_eq_and_1_0_or_2_proof : select_icmp_eq_and_1_0_or_2_before ⊑ select_icmp_eq_and_1_0_or_2_after := by
  unfold select_icmp_eq_and_1_0_or_2_before select_icmp_eq_and_1_0_or_2_after
  simp_alive_peephole
  intros
  ---BEGIN select_icmp_eq_and_1_0_or_2
  all_goals (try extract_goal ; sorry)
  ---END select_icmp_eq_and_1_0_or_2



def select_icmp_eq_and_1_0_xor_2_before := [llvm|
{
^0(%arg245 : i32, %arg246 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(2 : i32) : i32
  %3 = llvm.and %arg245, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.xor %arg246, %2 : i32
  %6 = "llvm.select"(%4, %arg246, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def select_icmp_eq_and_1_0_xor_2_after := [llvm|
{
^0(%arg245 : i32, %arg246 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.shl %arg245, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.xor %arg246, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_icmp_eq_and_1_0_xor_2_proof : select_icmp_eq_and_1_0_xor_2_before ⊑ select_icmp_eq_and_1_0_xor_2_after := by
  unfold select_icmp_eq_and_1_0_xor_2_before select_icmp_eq_and_1_0_xor_2_after
  simp_alive_peephole
  intros
  ---BEGIN select_icmp_eq_and_1_0_xor_2
  all_goals (try extract_goal ; sorry)
  ---END select_icmp_eq_and_1_0_xor_2



def select_icmp_eq_and_32_0_or_8_before := [llvm|
{
^0(%arg241 : i32, %arg242 : i32):
  %0 = llvm.mlir.constant(32 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(8 : i32) : i32
  %3 = llvm.and %arg241, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.or %arg242, %2 : i32
  %6 = "llvm.select"(%4, %arg242, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def select_icmp_eq_and_32_0_or_8_after := [llvm|
{
^0(%arg241 : i32, %arg242 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.lshr %arg241, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.or %arg242, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_icmp_eq_and_32_0_or_8_proof : select_icmp_eq_and_32_0_or_8_before ⊑ select_icmp_eq_and_32_0_or_8_after := by
  unfold select_icmp_eq_and_32_0_or_8_before select_icmp_eq_and_32_0_or_8_after
  simp_alive_peephole
  intros
  ---BEGIN select_icmp_eq_and_32_0_or_8
  all_goals (try extract_goal ; sorry)
  ---END select_icmp_eq_and_32_0_or_8



def select_icmp_eq_and_32_0_xor_8_before := [llvm|
{
^0(%arg237 : i32, %arg238 : i32):
  %0 = llvm.mlir.constant(32 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(8 : i32) : i32
  %3 = llvm.and %arg237, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.xor %arg238, %2 : i32
  %6 = "llvm.select"(%4, %arg238, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def select_icmp_eq_and_32_0_xor_8_after := [llvm|
{
^0(%arg237 : i32, %arg238 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.lshr %arg237, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.xor %arg238, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_icmp_eq_and_32_0_xor_8_proof : select_icmp_eq_and_32_0_xor_8_before ⊑ select_icmp_eq_and_32_0_xor_8_after := by
  unfold select_icmp_eq_and_32_0_xor_8_before select_icmp_eq_and_32_0_xor_8_after
  simp_alive_peephole
  intros
  ---BEGIN select_icmp_eq_and_32_0_xor_8
  all_goals (try extract_goal ; sorry)
  ---END select_icmp_eq_and_32_0_xor_8



def select_icmp_ne_0_and_4096_or_4096_before := [llvm|
{
^0(%arg233 : i32, %arg234 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg233, %0 : i32
  %3 = llvm.icmp "ne" %1, %2 : i32
  %4 = llvm.or %arg234, %0 : i32
  %5 = "llvm.select"(%3, %arg234, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def select_icmp_ne_0_and_4096_or_4096_after := [llvm|
{
^0(%arg233 : i32, %arg234 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.and %arg233, %0 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %arg234, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_icmp_ne_0_and_4096_or_4096_proof : select_icmp_ne_0_and_4096_or_4096_before ⊑ select_icmp_ne_0_and_4096_or_4096_after := by
  unfold select_icmp_ne_0_and_4096_or_4096_before select_icmp_ne_0_and_4096_or_4096_after
  simp_alive_peephole
  intros
  ---BEGIN select_icmp_ne_0_and_4096_or_4096
  all_goals (try extract_goal ; sorry)
  ---END select_icmp_ne_0_and_4096_or_4096



def select_icmp_ne_0_and_4096_xor_4096_before := [llvm|
{
^0(%arg229 : i32, %arg230 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg229, %0 : i32
  %3 = llvm.icmp "ne" %1, %2 : i32
  %4 = llvm.xor %arg230, %0 : i32
  %5 = "llvm.select"(%3, %arg230, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def select_icmp_ne_0_and_4096_xor_4096_after := [llvm|
{
^0(%arg229 : i32, %arg230 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.and %arg229, %0 : i32
  %2 = llvm.xor %1, %arg230 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_icmp_ne_0_and_4096_xor_4096_proof : select_icmp_ne_0_and_4096_xor_4096_before ⊑ select_icmp_ne_0_and_4096_xor_4096_after := by
  unfold select_icmp_ne_0_and_4096_xor_4096_before select_icmp_ne_0_and_4096_xor_4096_after
  simp_alive_peephole
  intros
  ---BEGIN select_icmp_ne_0_and_4096_xor_4096
  all_goals (try extract_goal ; sorry)
  ---END select_icmp_ne_0_and_4096_xor_4096



def select_icmp_ne_0_and_4096_and_not_4096_before := [llvm|
{
^0(%arg227 : i32, %arg228 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(-4097 : i32) : i32
  %3 = llvm.and %arg227, %0 : i32
  %4 = llvm.icmp "ne" %1, %3 : i32
  %5 = llvm.and %arg228, %2 : i32
  %6 = "llvm.select"(%4, %arg228, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def select_icmp_ne_0_and_4096_and_not_4096_after := [llvm|
{
^0(%arg227 : i32, %arg228 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(-4097 : i32) : i32
  %3 = llvm.and %arg227, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.and %arg228, %2 : i32
  %6 = "llvm.select"(%4, %5, %arg228) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_icmp_ne_0_and_4096_and_not_4096_proof : select_icmp_ne_0_and_4096_and_not_4096_before ⊑ select_icmp_ne_0_and_4096_and_not_4096_after := by
  unfold select_icmp_ne_0_and_4096_and_not_4096_before select_icmp_ne_0_and_4096_and_not_4096_after
  simp_alive_peephole
  intros
  ---BEGIN select_icmp_ne_0_and_4096_and_not_4096
  all_goals (try extract_goal ; sorry)
  ---END select_icmp_ne_0_and_4096_and_not_4096



def select_icmp_eq_and_4096_0_or_4096_before := [llvm|
{
^0(%arg225 : i32, %arg226 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg225, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  %4 = llvm.or %arg226, %0 : i32
  %5 = "llvm.select"(%3, %arg226, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def select_icmp_eq_and_4096_0_or_4096_after := [llvm|
{
^0(%arg225 : i32, %arg226 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.and %arg225, %0 : i32
  %2 = llvm.or %arg226, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_icmp_eq_and_4096_0_or_4096_proof : select_icmp_eq_and_4096_0_or_4096_before ⊑ select_icmp_eq_and_4096_0_or_4096_after := by
  unfold select_icmp_eq_and_4096_0_or_4096_before select_icmp_eq_and_4096_0_or_4096_after
  simp_alive_peephole
  intros
  ---BEGIN select_icmp_eq_and_4096_0_or_4096
  all_goals (try extract_goal ; sorry)
  ---END select_icmp_eq_and_4096_0_or_4096



def select_icmp_eq_and_4096_0_xor_4096_before := [llvm|
{
^0(%arg221 : i32, %arg222 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg221, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  %4 = llvm.xor %arg222, %0 : i32
  %5 = "llvm.select"(%3, %arg222, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def select_icmp_eq_and_4096_0_xor_4096_after := [llvm|
{
^0(%arg221 : i32, %arg222 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.and %arg221, %0 : i32
  %2 = llvm.xor %arg222, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_icmp_eq_and_4096_0_xor_4096_proof : select_icmp_eq_and_4096_0_xor_4096_before ⊑ select_icmp_eq_and_4096_0_xor_4096_after := by
  unfold select_icmp_eq_and_4096_0_xor_4096_before select_icmp_eq_and_4096_0_xor_4096_after
  simp_alive_peephole
  intros
  ---BEGIN select_icmp_eq_and_4096_0_xor_4096
  all_goals (try extract_goal ; sorry)
  ---END select_icmp_eq_and_4096_0_xor_4096



def select_icmp_eq_0_and_1_or_1_before := [llvm|
{
^0(%arg217 : i64, %arg218 : i32):
  %0 = llvm.mlir.constant(1) : i64
  %1 = llvm.mlir.constant(0) : i64
  %2 = llvm.mlir.constant(1 : i32) : i32
  %3 = llvm.and %arg217, %0 : i64
  %4 = llvm.icmp "eq" %3, %1 : i64
  %5 = llvm.or %arg218, %2 : i32
  %6 = "llvm.select"(%4, %arg218, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def select_icmp_eq_0_and_1_or_1_after := [llvm|
{
^0(%arg217 : i64, %arg218 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.trunc %arg217 : i64 to i32
  %2 = llvm.and %1, %0 : i32
  %3 = llvm.or %arg218, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_icmp_eq_0_and_1_or_1_proof : select_icmp_eq_0_and_1_or_1_before ⊑ select_icmp_eq_0_and_1_or_1_after := by
  unfold select_icmp_eq_0_and_1_or_1_before select_icmp_eq_0_and_1_or_1_after
  simp_alive_peephole
  intros
  ---BEGIN select_icmp_eq_0_and_1_or_1
  all_goals (try extract_goal ; sorry)
  ---END select_icmp_eq_0_and_1_or_1



def select_icmp_eq_0_and_1_xor_1_before := [llvm|
{
^0(%arg213 : i64, %arg214 : i32):
  %0 = llvm.mlir.constant(1) : i64
  %1 = llvm.mlir.constant(0) : i64
  %2 = llvm.mlir.constant(1 : i32) : i32
  %3 = llvm.and %arg213, %0 : i64
  %4 = llvm.icmp "eq" %3, %1 : i64
  %5 = llvm.xor %arg214, %2 : i32
  %6 = "llvm.select"(%4, %arg214, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def select_icmp_eq_0_and_1_xor_1_after := [llvm|
{
^0(%arg213 : i64, %arg214 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.trunc %arg213 : i64 to i32
  %2 = llvm.and %1, %0 : i32
  %3 = llvm.xor %arg214, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_icmp_eq_0_and_1_xor_1_proof : select_icmp_eq_0_and_1_xor_1_before ⊑ select_icmp_eq_0_and_1_xor_1_after := by
  unfold select_icmp_eq_0_and_1_xor_1_before select_icmp_eq_0_and_1_xor_1_after
  simp_alive_peephole
  intros
  ---BEGIN select_icmp_eq_0_and_1_xor_1
  all_goals (try extract_goal ; sorry)
  ---END select_icmp_eq_0_and_1_xor_1



def select_icmp_ne_0_and_4096_or_32_before := [llvm|
{
^0(%arg209 : i32, %arg210 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(32 : i32) : i32
  %3 = llvm.and %arg209, %0 : i32
  %4 = llvm.icmp "ne" %1, %3 : i32
  %5 = llvm.or %arg210, %2 : i32
  %6 = "llvm.select"(%4, %arg210, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def select_icmp_ne_0_and_4096_or_32_after := [llvm|
{
^0(%arg209 : i32, %arg210 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(32 : i32) : i32
  %2 = llvm.lshr %arg209, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.or %arg210, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_icmp_ne_0_and_4096_or_32_proof : select_icmp_ne_0_and_4096_or_32_before ⊑ select_icmp_ne_0_and_4096_or_32_after := by
  unfold select_icmp_ne_0_and_4096_or_32_before select_icmp_ne_0_and_4096_or_32_after
  simp_alive_peephole
  intros
  ---BEGIN select_icmp_ne_0_and_4096_or_32
  all_goals (try extract_goal ; sorry)
  ---END select_icmp_ne_0_and_4096_or_32



def select_icmp_ne_0_and_4096_xor_32_before := [llvm|
{
^0(%arg207 : i32, %arg208 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(32 : i32) : i32
  %3 = llvm.and %arg207, %0 : i32
  %4 = llvm.icmp "ne" %1, %3 : i32
  %5 = llvm.xor %arg208, %2 : i32
  %6 = "llvm.select"(%4, %arg208, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def select_icmp_ne_0_and_4096_xor_32_after := [llvm|
{
^0(%arg207 : i32, %arg208 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(32 : i32) : i32
  %2 = llvm.lshr %arg207, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.xor %3, %arg208 : i32
  %5 = llvm.xor %4, %1 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_icmp_ne_0_and_4096_xor_32_proof : select_icmp_ne_0_and_4096_xor_32_before ⊑ select_icmp_ne_0_and_4096_xor_32_after := by
  unfold select_icmp_ne_0_and_4096_xor_32_before select_icmp_ne_0_and_4096_xor_32_after
  simp_alive_peephole
  intros
  ---BEGIN select_icmp_ne_0_and_4096_xor_32
  all_goals (try extract_goal ; sorry)
  ---END select_icmp_ne_0_and_4096_xor_32



def select_icmp_ne_0_and_4096_and_not_32_before := [llvm|
{
^0(%arg205 : i32, %arg206 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(-33 : i32) : i32
  %3 = llvm.and %arg205, %0 : i32
  %4 = llvm.icmp "ne" %1, %3 : i32
  %5 = llvm.and %arg206, %2 : i32
  %6 = "llvm.select"(%4, %arg206, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def select_icmp_ne_0_and_4096_and_not_32_after := [llvm|
{
^0(%arg205 : i32, %arg206 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(-33 : i32) : i32
  %3 = llvm.and %arg205, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.and %arg206, %2 : i32
  %6 = "llvm.select"(%4, %5, %arg206) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_icmp_ne_0_and_4096_and_not_32_proof : select_icmp_ne_0_and_4096_and_not_32_before ⊑ select_icmp_ne_0_and_4096_and_not_32_after := by
  unfold select_icmp_ne_0_and_4096_and_not_32_before select_icmp_ne_0_and_4096_and_not_32_after
  simp_alive_peephole
  intros
  ---BEGIN select_icmp_ne_0_and_4096_and_not_32
  all_goals (try extract_goal ; sorry)
  ---END select_icmp_ne_0_and_4096_and_not_32



def select_icmp_ne_0_and_32_or_4096_before := [llvm|
{
^0(%arg203 : i32, %arg204 : i32):
  %0 = llvm.mlir.constant(32 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(4096 : i32) : i32
  %3 = llvm.and %arg203, %0 : i32
  %4 = llvm.icmp "ne" %1, %3 : i32
  %5 = llvm.or %arg204, %2 : i32
  %6 = "llvm.select"(%4, %arg204, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def select_icmp_ne_0_and_32_or_4096_after := [llvm|
{
^0(%arg203 : i32, %arg204 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(4096 : i32) : i32
  %2 = llvm.shl %arg203, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.or %arg204, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_icmp_ne_0_and_32_or_4096_proof : select_icmp_ne_0_and_32_or_4096_before ⊑ select_icmp_ne_0_and_32_or_4096_after := by
  unfold select_icmp_ne_0_and_32_or_4096_before select_icmp_ne_0_and_32_or_4096_after
  simp_alive_peephole
  intros
  ---BEGIN select_icmp_ne_0_and_32_or_4096
  all_goals (try extract_goal ; sorry)
  ---END select_icmp_ne_0_and_32_or_4096



def select_icmp_ne_0_and_32_xor_4096_before := [llvm|
{
^0(%arg199 : i32, %arg200 : i32):
  %0 = llvm.mlir.constant(32 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(4096 : i32) : i32
  %3 = llvm.and %arg199, %0 : i32
  %4 = llvm.icmp "ne" %1, %3 : i32
  %5 = llvm.xor %arg200, %2 : i32
  %6 = "llvm.select"(%4, %arg200, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def select_icmp_ne_0_and_32_xor_4096_after := [llvm|
{
^0(%arg199 : i32, %arg200 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(4096 : i32) : i32
  %2 = llvm.shl %arg199, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.xor %3, %arg200 : i32
  %5 = llvm.xor %4, %1 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_icmp_ne_0_and_32_xor_4096_proof : select_icmp_ne_0_and_32_xor_4096_before ⊑ select_icmp_ne_0_and_32_xor_4096_after := by
  unfold select_icmp_ne_0_and_32_xor_4096_before select_icmp_ne_0_and_32_xor_4096_after
  simp_alive_peephole
  intros
  ---BEGIN select_icmp_ne_0_and_32_xor_4096
  all_goals (try extract_goal ; sorry)
  ---END select_icmp_ne_0_and_32_xor_4096



def select_icmp_ne_0_and_32_and_not_4096_before := [llvm|
{
^0(%arg197 : i32, %arg198 : i32):
  %0 = llvm.mlir.constant(32 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(-4097 : i32) : i32
  %3 = llvm.and %arg197, %0 : i32
  %4 = llvm.icmp "ne" %1, %3 : i32
  %5 = llvm.and %arg198, %2 : i32
  %6 = "llvm.select"(%4, %arg198, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def select_icmp_ne_0_and_32_and_not_4096_after := [llvm|
{
^0(%arg197 : i32, %arg198 : i32):
  %0 = llvm.mlir.constant(32 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(-4097 : i32) : i32
  %3 = llvm.and %arg197, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.and %arg198, %2 : i32
  %6 = "llvm.select"(%4, %5, %arg198) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_icmp_ne_0_and_32_and_not_4096_proof : select_icmp_ne_0_and_32_and_not_4096_before ⊑ select_icmp_ne_0_and_32_and_not_4096_after := by
  unfold select_icmp_ne_0_and_32_and_not_4096_before select_icmp_ne_0_and_32_and_not_4096_after
  simp_alive_peephole
  intros
  ---BEGIN select_icmp_ne_0_and_32_and_not_4096
  all_goals (try extract_goal ; sorry)
  ---END select_icmp_ne_0_and_32_and_not_4096



def select_icmp_ne_0_and_1073741824_or_8_before := [llvm|
{
^0(%arg195 : i32, %arg196 : i8):
  %0 = llvm.mlir.constant(1073741824 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(8 : i8) : i8
  %3 = llvm.and %arg195, %0 : i32
  %4 = llvm.icmp "ne" %1, %3 : i32
  %5 = llvm.or %arg196, %2 : i8
  %6 = "llvm.select"(%4, %arg196, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def select_icmp_ne_0_and_1073741824_or_8_after := [llvm|
{
^0(%arg195 : i32, %arg196 : i8):
  %0 = llvm.mlir.constant(1073741824 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(8 : i8) : i8
  %3 = llvm.and %arg195, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.or %arg196, %2 : i8
  %6 = "llvm.select"(%4, %5, %arg196) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%6) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_icmp_ne_0_and_1073741824_or_8_proof : select_icmp_ne_0_and_1073741824_or_8_before ⊑ select_icmp_ne_0_and_1073741824_or_8_after := by
  unfold select_icmp_ne_0_and_1073741824_or_8_before select_icmp_ne_0_and_1073741824_or_8_after
  simp_alive_peephole
  intros
  ---BEGIN select_icmp_ne_0_and_1073741824_or_8
  all_goals (try extract_goal ; sorry)
  ---END select_icmp_ne_0_and_1073741824_or_8



def select_icmp_ne_0_and_1073741824_xor_8_before := [llvm|
{
^0(%arg193 : i32, %arg194 : i8):
  %0 = llvm.mlir.constant(1073741824 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(8 : i8) : i8
  %3 = llvm.and %arg193, %0 : i32
  %4 = llvm.icmp "ne" %1, %3 : i32
  %5 = llvm.xor %arg194, %2 : i8
  %6 = "llvm.select"(%4, %arg194, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def select_icmp_ne_0_and_1073741824_xor_8_after := [llvm|
{
^0(%arg193 : i32, %arg194 : i8):
  %0 = llvm.mlir.constant(1073741824 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(8 : i8) : i8
  %3 = llvm.and %arg193, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.xor %arg194, %2 : i8
  %6 = "llvm.select"(%4, %5, %arg194) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%6) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_icmp_ne_0_and_1073741824_xor_8_proof : select_icmp_ne_0_and_1073741824_xor_8_before ⊑ select_icmp_ne_0_and_1073741824_xor_8_after := by
  unfold select_icmp_ne_0_and_1073741824_xor_8_before select_icmp_ne_0_and_1073741824_xor_8_after
  simp_alive_peephole
  intros
  ---BEGIN select_icmp_ne_0_and_1073741824_xor_8
  all_goals (try extract_goal ; sorry)
  ---END select_icmp_ne_0_and_1073741824_xor_8



def select_icmp_ne_0_and_1073741824_and_not_8_before := [llvm|
{
^0(%arg191 : i32, %arg192 : i8):
  %0 = llvm.mlir.constant(1073741824 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(-9 : i8) : i8
  %3 = llvm.and %arg191, %0 : i32
  %4 = llvm.icmp "ne" %1, %3 : i32
  %5 = llvm.and %arg192, %2 : i8
  %6 = "llvm.select"(%4, %arg192, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def select_icmp_ne_0_and_1073741824_and_not_8_after := [llvm|
{
^0(%arg191 : i32, %arg192 : i8):
  %0 = llvm.mlir.constant(1073741824 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(-9 : i8) : i8
  %3 = llvm.and %arg191, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.and %arg192, %2 : i8
  %6 = "llvm.select"(%4, %5, %arg192) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%6) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_icmp_ne_0_and_1073741824_and_not_8_proof : select_icmp_ne_0_and_1073741824_and_not_8_before ⊑ select_icmp_ne_0_and_1073741824_and_not_8_after := by
  unfold select_icmp_ne_0_and_1073741824_and_not_8_before select_icmp_ne_0_and_1073741824_and_not_8_after
  simp_alive_peephole
  intros
  ---BEGIN select_icmp_ne_0_and_1073741824_and_not_8
  all_goals (try extract_goal ; sorry)
  ---END select_icmp_ne_0_and_1073741824_and_not_8



def select_icmp_ne_0_and_8_or_1073741824_before := [llvm|
{
^0(%arg189 : i8, %arg190 : i32):
  %0 = llvm.mlir.constant(8 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.mlir.constant(1073741824 : i32) : i32
  %3 = llvm.and %arg189, %0 : i8
  %4 = llvm.icmp "ne" %1, %3 : i8
  %5 = llvm.or %arg190, %2 : i32
  %6 = "llvm.select"(%4, %arg190, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def select_icmp_ne_0_and_8_or_1073741824_after := [llvm|
{
^0(%arg189 : i8, %arg190 : i32):
  %0 = llvm.mlir.constant(8 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.mlir.constant(1073741824 : i32) : i32
  %3 = llvm.and %arg189, %0 : i8
  %4 = llvm.icmp "eq" %3, %1 : i8
  %5 = llvm.or %arg190, %2 : i32
  %6 = "llvm.select"(%4, %5, %arg190) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_icmp_ne_0_and_8_or_1073741824_proof : select_icmp_ne_0_and_8_or_1073741824_before ⊑ select_icmp_ne_0_and_8_or_1073741824_after := by
  unfold select_icmp_ne_0_and_8_or_1073741824_before select_icmp_ne_0_and_8_or_1073741824_after
  simp_alive_peephole
  intros
  ---BEGIN select_icmp_ne_0_and_8_or_1073741824
  all_goals (try extract_goal ; sorry)
  ---END select_icmp_ne_0_and_8_or_1073741824



def select_icmp_ne_0_and_8_xor_1073741824_before := [llvm|
{
^0(%arg187 : i8, %arg188 : i32):
  %0 = llvm.mlir.constant(8 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.mlir.constant(1073741824 : i32) : i32
  %3 = llvm.and %arg187, %0 : i8
  %4 = llvm.icmp "ne" %1, %3 : i8
  %5 = llvm.xor %arg188, %2 : i32
  %6 = "llvm.select"(%4, %arg188, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def select_icmp_ne_0_and_8_xor_1073741824_after := [llvm|
{
^0(%arg187 : i8, %arg188 : i32):
  %0 = llvm.mlir.constant(8 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.mlir.constant(1073741824 : i32) : i32
  %3 = llvm.and %arg187, %0 : i8
  %4 = llvm.icmp "eq" %3, %1 : i8
  %5 = llvm.xor %arg188, %2 : i32
  %6 = "llvm.select"(%4, %5, %arg188) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_icmp_ne_0_and_8_xor_1073741824_proof : select_icmp_ne_0_and_8_xor_1073741824_before ⊑ select_icmp_ne_0_and_8_xor_1073741824_after := by
  unfold select_icmp_ne_0_and_8_xor_1073741824_before select_icmp_ne_0_and_8_xor_1073741824_after
  simp_alive_peephole
  intros
  ---BEGIN select_icmp_ne_0_and_8_xor_1073741824
  all_goals (try extract_goal ; sorry)
  ---END select_icmp_ne_0_and_8_xor_1073741824



def select_icmp_ne_0_and_8_and_not_1073741824_before := [llvm|
{
^0(%arg185 : i8, %arg186 : i32):
  %0 = llvm.mlir.constant(8 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.mlir.constant(-1073741825 : i32) : i32
  %3 = llvm.and %arg185, %0 : i8
  %4 = llvm.icmp "ne" %1, %3 : i8
  %5 = llvm.and %arg186, %2 : i32
  %6 = "llvm.select"(%4, %arg186, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def select_icmp_ne_0_and_8_and_not_1073741824_after := [llvm|
{
^0(%arg185 : i8, %arg186 : i32):
  %0 = llvm.mlir.constant(8 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.mlir.constant(-1073741825 : i32) : i32
  %3 = llvm.and %arg185, %0 : i8
  %4 = llvm.icmp "eq" %3, %1 : i8
  %5 = llvm.and %arg186, %2 : i32
  %6 = "llvm.select"(%4, %5, %arg186) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_icmp_ne_0_and_8_and_not_1073741824_proof : select_icmp_ne_0_and_8_and_not_1073741824_before ⊑ select_icmp_ne_0_and_8_and_not_1073741824_after := by
  unfold select_icmp_ne_0_and_8_and_not_1073741824_before select_icmp_ne_0_and_8_and_not_1073741824_after
  simp_alive_peephole
  intros
  ---BEGIN select_icmp_ne_0_and_8_and_not_1073741824
  all_goals (try extract_goal ; sorry)
  ---END select_icmp_ne_0_and_8_and_not_1073741824



def select_icmp_and_8_ne_0_xor_8_before := [llvm|
{
^0(%arg182 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg182, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  %4 = llvm.xor %arg182, %0 : i32
  %5 = "llvm.select"(%3, %arg182, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def select_icmp_and_8_ne_0_xor_8_after := [llvm|
{
^0(%arg182 : i32):
  %0 = llvm.mlir.constant(-9 : i32) : i32
  %1 = llvm.and %arg182, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_icmp_and_8_ne_0_xor_8_proof : select_icmp_and_8_ne_0_xor_8_before ⊑ select_icmp_and_8_ne_0_xor_8_after := by
  unfold select_icmp_and_8_ne_0_xor_8_before select_icmp_and_8_ne_0_xor_8_after
  simp_alive_peephole
  intros
  ---BEGIN select_icmp_and_8_ne_0_xor_8
  all_goals (try extract_goal ; sorry)
  ---END select_icmp_and_8_ne_0_xor_8



def select_icmp_and_8_eq_0_xor_8_before := [llvm|
{
^0(%arg181 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg181, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  %4 = llvm.xor %arg181, %0 : i32
  %5 = "llvm.select"(%3, %4, %arg181) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def select_icmp_and_8_eq_0_xor_8_after := [llvm|
{
^0(%arg181 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.or %arg181, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_icmp_and_8_eq_0_xor_8_proof : select_icmp_and_8_eq_0_xor_8_before ⊑ select_icmp_and_8_eq_0_xor_8_after := by
  unfold select_icmp_and_8_eq_0_xor_8_before select_icmp_and_8_eq_0_xor_8_after
  simp_alive_peephole
  intros
  ---BEGIN select_icmp_and_8_eq_0_xor_8
  all_goals (try extract_goal ; sorry)
  ---END select_icmp_and_8_eq_0_xor_8



def select_icmp_x_and_8_eq_0_y_xor_8_before := [llvm|
{
^0(%arg179 : i32, %arg180 : i64):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(8) : i64
  %3 = llvm.and %arg179, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.xor %arg180, %2 : i64
  %6 = "llvm.select"(%4, %arg180, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%6) : (i64) -> ()
}
]
def select_icmp_x_and_8_eq_0_y_xor_8_after := [llvm|
{
^0(%arg179 : i32, %arg180 : i64):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.and %arg179, %0 : i32
  %2 = llvm.zext nneg %1 : i32 to i64
  %3 = llvm.xor %arg180, %2 : i64
  "llvm.return"(%3) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_icmp_x_and_8_eq_0_y_xor_8_proof : select_icmp_x_and_8_eq_0_y_xor_8_before ⊑ select_icmp_x_and_8_eq_0_y_xor_8_after := by
  unfold select_icmp_x_and_8_eq_0_y_xor_8_before select_icmp_x_and_8_eq_0_y_xor_8_after
  simp_alive_peephole
  intros
  ---BEGIN select_icmp_x_and_8_eq_0_y_xor_8
  all_goals (try extract_goal ; sorry)
  ---END select_icmp_x_and_8_eq_0_y_xor_8



def select_icmp_x_and_8_ne_0_y_xor_8_before := [llvm|
{
^0(%arg177 : i32, %arg178 : i64):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(8) : i64
  %3 = llvm.and %arg177, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.xor %arg178, %2 : i64
  %6 = "llvm.select"(%4, %5, %arg178) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%6) : (i64) -> ()
}
]
def select_icmp_x_and_8_ne_0_y_xor_8_after := [llvm|
{
^0(%arg177 : i32, %arg178 : i64):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.and %arg177, %0 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.zext nneg %2 : i32 to i64
  %4 = llvm.xor %arg178, %3 : i64
  "llvm.return"(%4) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_icmp_x_and_8_ne_0_y_xor_8_proof : select_icmp_x_and_8_ne_0_y_xor_8_before ⊑ select_icmp_x_and_8_ne_0_y_xor_8_after := by
  unfold select_icmp_x_and_8_ne_0_y_xor_8_before select_icmp_x_and_8_ne_0_y_xor_8_after
  simp_alive_peephole
  intros
  ---BEGIN select_icmp_x_and_8_ne_0_y_xor_8
  all_goals (try extract_goal ; sorry)
  ---END select_icmp_x_and_8_ne_0_y_xor_8



def select_icmp_x_and_8_ne_0_y_or_8_before := [llvm|
{
^0(%arg175 : i32, %arg176 : i64):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(8) : i64
  %3 = llvm.and %arg175, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.or %arg176, %2 : i64
  %6 = "llvm.select"(%4, %5, %arg176) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%6) : (i64) -> ()
}
]
def select_icmp_x_and_8_ne_0_y_or_8_after := [llvm|
{
^0(%arg175 : i32, %arg176 : i64):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.and %arg175, %0 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.zext nneg %2 : i32 to i64
  %4 = llvm.or %arg176, %3 : i64
  "llvm.return"(%4) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_icmp_x_and_8_ne_0_y_or_8_proof : select_icmp_x_and_8_ne_0_y_or_8_before ⊑ select_icmp_x_and_8_ne_0_y_or_8_after := by
  unfold select_icmp_x_and_8_ne_0_y_or_8_before select_icmp_x_and_8_ne_0_y_or_8_after
  simp_alive_peephole
  intros
  ---BEGIN select_icmp_x_and_8_ne_0_y_or_8
  all_goals (try extract_goal ; sorry)
  ---END select_icmp_x_and_8_ne_0_y_or_8



def select_icmp_and_2147483648_ne_0_xor_2147483648_before := [llvm|
{
^0(%arg170 : i32):
  %0 = llvm.mlir.constant(-2147483648 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg170, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  %4 = llvm.xor %arg170, %0 : i32
  %5 = "llvm.select"(%3, %arg170, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def select_icmp_and_2147483648_ne_0_xor_2147483648_after := [llvm|
{
^0(%arg170 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.and %arg170, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_icmp_and_2147483648_ne_0_xor_2147483648_proof : select_icmp_and_2147483648_ne_0_xor_2147483648_before ⊑ select_icmp_and_2147483648_ne_0_xor_2147483648_after := by
  unfold select_icmp_and_2147483648_ne_0_xor_2147483648_before select_icmp_and_2147483648_ne_0_xor_2147483648_after
  simp_alive_peephole
  intros
  ---BEGIN select_icmp_and_2147483648_ne_0_xor_2147483648
  all_goals (try extract_goal ; sorry)
  ---END select_icmp_and_2147483648_ne_0_xor_2147483648



def select_icmp_and_2147483648_eq_0_xor_2147483648_before := [llvm|
{
^0(%arg169 : i32):
  %0 = llvm.mlir.constant(-2147483648 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg169, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  %4 = llvm.xor %arg169, %0 : i32
  %5 = "llvm.select"(%3, %4, %arg169) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def select_icmp_and_2147483648_eq_0_xor_2147483648_after := [llvm|
{
^0(%arg169 : i32):
  %0 = llvm.mlir.constant(-2147483648 : i32) : i32
  %1 = llvm.or %arg169, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_icmp_and_2147483648_eq_0_xor_2147483648_proof : select_icmp_and_2147483648_eq_0_xor_2147483648_before ⊑ select_icmp_and_2147483648_eq_0_xor_2147483648_after := by
  unfold select_icmp_and_2147483648_eq_0_xor_2147483648_before select_icmp_and_2147483648_eq_0_xor_2147483648_after
  simp_alive_peephole
  intros
  ---BEGIN select_icmp_and_2147483648_eq_0_xor_2147483648
  all_goals (try extract_goal ; sorry)
  ---END select_icmp_and_2147483648_eq_0_xor_2147483648



def select_icmp_x_and_2147483648_ne_0_or_2147483648_before := [llvm|
{
^0(%arg168 : i32):
  %0 = llvm.mlir.constant(-2147483648 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg168, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  %4 = llvm.or %arg168, %0 : i32
  %5 = "llvm.select"(%3, %4, %arg168) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def select_icmp_x_and_2147483648_ne_0_or_2147483648_after := [llvm|
{
^0(%arg168 : i32):
  %0 = llvm.mlir.constant(-2147483648 : i32) : i32
  %1 = llvm.or %arg168, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_icmp_x_and_2147483648_ne_0_or_2147483648_proof : select_icmp_x_and_2147483648_ne_0_or_2147483648_before ⊑ select_icmp_x_and_2147483648_ne_0_or_2147483648_after := by
  unfold select_icmp_x_and_2147483648_ne_0_or_2147483648_before select_icmp_x_and_2147483648_ne_0_or_2147483648_after
  simp_alive_peephole
  intros
  ---BEGIN select_icmp_x_and_2147483648_ne_0_or_2147483648
  all_goals (try extract_goal ; sorry)
  ---END select_icmp_x_and_2147483648_ne_0_or_2147483648



def test68_before := [llvm|
{
^0(%arg166 : i32, %arg167 : i32):
  %0 = llvm.mlir.constant(128 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(2 : i32) : i32
  %3 = llvm.and %arg166, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.or %arg167, %2 : i32
  %6 = "llvm.select"(%4, %arg167, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def test68_after := [llvm|
{
^0(%arg166 : i32, %arg167 : i32):
  %0 = llvm.mlir.constant(6 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.lshr %arg166, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.or %arg167, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test68_proof : test68_before ⊑ test68_after := by
  unfold test68_before test68_after
  simp_alive_peephole
  intros
  ---BEGIN test68
  all_goals (try extract_goal ; sorry)
  ---END test68



def test68_xor_before := [llvm|
{
^0(%arg162 : i32, %arg163 : i32):
  %0 = llvm.mlir.constant(128 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(2 : i32) : i32
  %3 = llvm.and %arg162, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.xor %arg163, %2 : i32
  %6 = "llvm.select"(%4, %arg163, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def test68_xor_after := [llvm|
{
^0(%arg162 : i32, %arg163 : i32):
  %0 = llvm.mlir.constant(6 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.lshr %arg162, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.xor %arg163, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test68_xor_proof : test68_xor_before ⊑ test68_xor_after := by
  unfold test68_xor_before test68_xor_after
  simp_alive_peephole
  intros
  ---BEGIN test68_xor
  all_goals (try extract_goal ; sorry)
  ---END test68_xor



def test69_before := [llvm|
{
^0(%arg158 : i32, %arg159 : i32):
  %0 = llvm.mlir.constant(128 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(2 : i32) : i32
  %3 = llvm.and %arg158, %0 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  %5 = llvm.or %arg159, %2 : i32
  %6 = "llvm.select"(%4, %arg159, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def test69_after := [llvm|
{
^0(%arg158 : i32, %arg159 : i32):
  %0 = llvm.mlir.constant(6 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.lshr %arg158, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.or %arg159, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test69_proof : test69_before ⊑ test69_after := by
  unfold test69_before test69_after
  simp_alive_peephole
  intros
  ---BEGIN test69
  all_goals (try extract_goal ; sorry)
  ---END test69



def test69_xor_before := [llvm|
{
^0(%arg154 : i32, %arg155 : i32):
  %0 = llvm.mlir.constant(128 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(2 : i32) : i32
  %3 = llvm.and %arg154, %0 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  %5 = llvm.xor %arg155, %2 : i32
  %6 = "llvm.select"(%4, %arg155, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def test69_xor_after := [llvm|
{
^0(%arg154 : i32, %arg155 : i32):
  %0 = llvm.mlir.constant(6 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.lshr %arg154, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.xor %3, %arg155 : i32
  %5 = llvm.xor %4, %1 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test69_xor_proof : test69_xor_before ⊑ test69_xor_after := by
  unfold test69_xor_before test69_xor_after
  simp_alive_peephole
  intros
  ---BEGIN test69_xor
  all_goals (try extract_goal ; sorry)
  ---END test69_xor



def test69_and_before := [llvm|
{
^0(%arg152 : i32, %arg153 : i32):
  %0 = llvm.mlir.constant(128 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(2 : i32) : i32
  %3 = llvm.and %arg152, %0 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  %5 = llvm.and %arg153, %2 : i32
  %6 = "llvm.select"(%4, %arg153, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def test69_and_after := [llvm|
{
^0(%arg152 : i32, %arg153 : i32):
  %0 = llvm.mlir.constant(128 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(2 : i32) : i32
  %3 = llvm.and %arg152, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.and %arg153, %2 : i32
  %6 = "llvm.select"(%4, %5, %arg153) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test69_and_proof : test69_and_before ⊑ test69_and_after := by
  unfold test69_and_before test69_and_after
  simp_alive_peephole
  intros
  ---BEGIN test69_and
  all_goals (try extract_goal ; sorry)
  ---END test69_and



def test70_before := [llvm|
{
^0(%arg150 : i8, %arg151 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(2 : i8) : i8
  %2 = llvm.icmp "slt" %arg150, %0 : i8
  %3 = llvm.or %arg151, %1 : i8
  %4 = "llvm.select"(%2, %3, %arg151) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def test70_after := [llvm|
{
^0(%arg150 : i8, %arg151 : i8):
  %0 = llvm.mlir.constant(6 : i8) : i8
  %1 = llvm.mlir.constant(2 : i8) : i8
  %2 = llvm.lshr %arg150, %0 : i8
  %3 = llvm.and %2, %1 : i8
  %4 = llvm.or %arg151, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test70_proof : test70_before ⊑ test70_after := by
  unfold test70_before test70_after
  simp_alive_peephole
  intros
  ---BEGIN test70
  all_goals (try extract_goal ; sorry)
  ---END test70



def shift_no_xor_multiuse_or_before := [llvm|
{
^0(%arg146 : i32, %arg147 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(2 : i32) : i32
  %3 = llvm.and %arg146, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.or %arg147, %2 : i32
  %6 = "llvm.select"(%4, %arg147, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %7 = llvm.mul %6, %5 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def shift_no_xor_multiuse_or_after := [llvm|
{
^0(%arg146 : i32, %arg147 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.or %arg147, %0 : i32
  %3 = llvm.shl %arg146, %1 : i32
  %4 = llvm.and %3, %0 : i32
  %5 = llvm.or %arg147, %4 : i32
  %6 = llvm.mul %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shift_no_xor_multiuse_or_proof : shift_no_xor_multiuse_or_before ⊑ shift_no_xor_multiuse_or_after := by
  unfold shift_no_xor_multiuse_or_before shift_no_xor_multiuse_or_after
  simp_alive_peephole
  intros
  ---BEGIN shift_no_xor_multiuse_or
  all_goals (try extract_goal ; sorry)
  ---END shift_no_xor_multiuse_or



def shift_no_xor_multiuse_xor_before := [llvm|
{
^0(%arg144 : i32, %arg145 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(2 : i32) : i32
  %3 = llvm.and %arg144, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.xor %arg145, %2 : i32
  %6 = "llvm.select"(%4, %arg145, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %7 = llvm.mul %6, %5 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def shift_no_xor_multiuse_xor_after := [llvm|
{
^0(%arg144 : i32, %arg145 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.xor %arg145, %0 : i32
  %3 = llvm.shl %arg144, %1 : i32
  %4 = llvm.and %3, %0 : i32
  %5 = llvm.xor %arg145, %4 : i32
  %6 = llvm.mul %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shift_no_xor_multiuse_xor_proof : shift_no_xor_multiuse_xor_before ⊑ shift_no_xor_multiuse_xor_after := by
  unfold shift_no_xor_multiuse_xor_before shift_no_xor_multiuse_xor_after
  simp_alive_peephole
  intros
  ---BEGIN shift_no_xor_multiuse_xor
  all_goals (try extract_goal ; sorry)
  ---END shift_no_xor_multiuse_xor



def no_shift_no_xor_multiuse_or_before := [llvm|
{
^0(%arg140 : i32, %arg141 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg140, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  %4 = llvm.or %arg141, %0 : i32
  %5 = "llvm.select"(%3, %arg141, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %6 = llvm.mul %5, %4 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def no_shift_no_xor_multiuse_or_after := [llvm|
{
^0(%arg140 : i32, %arg141 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.and %arg140, %0 : i32
  %2 = llvm.or %arg141, %0 : i32
  %3 = llvm.or %arg141, %1 : i32
  %4 = llvm.mul %3, %2 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem no_shift_no_xor_multiuse_or_proof : no_shift_no_xor_multiuse_or_before ⊑ no_shift_no_xor_multiuse_or_after := by
  unfold no_shift_no_xor_multiuse_or_before no_shift_no_xor_multiuse_or_after
  simp_alive_peephole
  intros
  ---BEGIN no_shift_no_xor_multiuse_or
  all_goals (try extract_goal ; sorry)
  ---END no_shift_no_xor_multiuse_or



def no_shift_no_xor_multiuse_xor_before := [llvm|
{
^0(%arg138 : i32, %arg139 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg138, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  %4 = llvm.xor %arg139, %0 : i32
  %5 = "llvm.select"(%3, %arg139, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %6 = llvm.mul %5, %4 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def no_shift_no_xor_multiuse_xor_after := [llvm|
{
^0(%arg138 : i32, %arg139 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.and %arg138, %0 : i32
  %2 = llvm.xor %arg139, %0 : i32
  %3 = llvm.xor %arg139, %1 : i32
  %4 = llvm.mul %3, %2 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem no_shift_no_xor_multiuse_xor_proof : no_shift_no_xor_multiuse_xor_before ⊑ no_shift_no_xor_multiuse_xor_after := by
  unfold no_shift_no_xor_multiuse_xor_before no_shift_no_xor_multiuse_xor_after
  simp_alive_peephole
  intros
  ---BEGIN no_shift_no_xor_multiuse_xor
  all_goals (try extract_goal ; sorry)
  ---END no_shift_no_xor_multiuse_xor



def no_shift_xor_multiuse_or_before := [llvm|
{
^0(%arg134 : i32, %arg135 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg134, %0 : i32
  %3 = llvm.icmp "ne" %1, %2 : i32
  %4 = llvm.or %arg135, %0 : i32
  %5 = "llvm.select"(%3, %arg135, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %6 = llvm.mul %5, %4 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def no_shift_xor_multiuse_or_after := [llvm|
{
^0(%arg134 : i32, %arg135 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.and %arg134, %0 : i32
  %2 = llvm.or %arg135, %0 : i32
  %3 = llvm.xor %1, %0 : i32
  %4 = llvm.or %arg135, %3 : i32
  %5 = llvm.mul %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem no_shift_xor_multiuse_or_proof : no_shift_xor_multiuse_or_before ⊑ no_shift_xor_multiuse_or_after := by
  unfold no_shift_xor_multiuse_or_before no_shift_xor_multiuse_or_after
  simp_alive_peephole
  intros
  ---BEGIN no_shift_xor_multiuse_or
  all_goals (try extract_goal ; sorry)
  ---END no_shift_xor_multiuse_or



def no_shift_xor_multiuse_xor_before := [llvm|
{
^0(%arg132 : i32, %arg133 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg132, %0 : i32
  %3 = llvm.icmp "ne" %1, %2 : i32
  %4 = llvm.xor %arg133, %0 : i32
  %5 = "llvm.select"(%3, %arg133, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %6 = llvm.mul %5, %4 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def no_shift_xor_multiuse_xor_after := [llvm|
{
^0(%arg132 : i32, %arg133 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.and %arg132, %0 : i32
  %2 = llvm.xor %arg133, %0 : i32
  %3 = llvm.xor %1, %arg133 : i32
  %4 = llvm.xor %3, %0 : i32
  %5 = llvm.mul %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem no_shift_xor_multiuse_xor_proof : no_shift_xor_multiuse_xor_before ⊑ no_shift_xor_multiuse_xor_after := by
  unfold no_shift_xor_multiuse_xor_before no_shift_xor_multiuse_xor_after
  simp_alive_peephole
  intros
  ---BEGIN no_shift_xor_multiuse_xor
  all_goals (try extract_goal ; sorry)
  ---END no_shift_xor_multiuse_xor



def no_shift_xor_multiuse_and_before := [llvm|
{
^0(%arg130 : i32, %arg131 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(-4097 : i32) : i32
  %3 = llvm.and %arg130, %0 : i32
  %4 = llvm.icmp "ne" %1, %3 : i32
  %5 = llvm.and %arg131, %2 : i32
  %6 = "llvm.select"(%4, %arg131, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %7 = llvm.mul %6, %5 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def no_shift_xor_multiuse_and_after := [llvm|
{
^0(%arg130 : i32, %arg131 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(-4097 : i32) : i32
  %3 = llvm.and %arg130, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.and %arg131, %2 : i32
  %6 = "llvm.select"(%4, %5, %arg131) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %7 = llvm.mul %6, %5 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem no_shift_xor_multiuse_and_proof : no_shift_xor_multiuse_and_before ⊑ no_shift_xor_multiuse_and_after := by
  unfold no_shift_xor_multiuse_and_before no_shift_xor_multiuse_and_after
  simp_alive_peephole
  intros
  ---BEGIN no_shift_xor_multiuse_and
  all_goals (try extract_goal ; sorry)
  ---END no_shift_xor_multiuse_and



def shift_xor_multiuse_or_before := [llvm|
{
^0(%arg128 : i32, %arg129 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(2048 : i32) : i32
  %3 = llvm.and %arg128, %0 : i32
  %4 = llvm.icmp "ne" %1, %3 : i32
  %5 = llvm.or %arg129, %2 : i32
  %6 = "llvm.select"(%4, %arg129, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %7 = llvm.mul %6, %5 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def shift_xor_multiuse_or_after := [llvm|
{
^0(%arg128 : i32, %arg129 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(2048 : i32) : i32
  %3 = llvm.and %arg128, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.or %arg129, %2 : i32
  %6 = "llvm.select"(%4, %5, %arg129) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %7 = llvm.mul %6, %5 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shift_xor_multiuse_or_proof : shift_xor_multiuse_or_before ⊑ shift_xor_multiuse_or_after := by
  unfold shift_xor_multiuse_or_before shift_xor_multiuse_or_after
  simp_alive_peephole
  intros
  ---BEGIN shift_xor_multiuse_or
  all_goals (try extract_goal ; sorry)
  ---END shift_xor_multiuse_or



def shift_xor_multiuse_xor_before := [llvm|
{
^0(%arg126 : i32, %arg127 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(2048 : i32) : i32
  %3 = llvm.and %arg126, %0 : i32
  %4 = llvm.icmp "ne" %1, %3 : i32
  %5 = llvm.xor %arg127, %2 : i32
  %6 = "llvm.select"(%4, %arg127, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %7 = llvm.mul %6, %5 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def shift_xor_multiuse_xor_after := [llvm|
{
^0(%arg126 : i32, %arg127 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(2048 : i32) : i32
  %3 = llvm.and %arg126, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.xor %arg127, %2 : i32
  %6 = "llvm.select"(%4, %5, %arg127) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %7 = llvm.mul %6, %5 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shift_xor_multiuse_xor_proof : shift_xor_multiuse_xor_before ⊑ shift_xor_multiuse_xor_after := by
  unfold shift_xor_multiuse_xor_before shift_xor_multiuse_xor_after
  simp_alive_peephole
  intros
  ---BEGIN shift_xor_multiuse_xor
  all_goals (try extract_goal ; sorry)
  ---END shift_xor_multiuse_xor



def shift_xor_multiuse_and_before := [llvm|
{
^0(%arg124 : i32, %arg125 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(-2049 : i32) : i32
  %3 = llvm.and %arg124, %0 : i32
  %4 = llvm.icmp "ne" %1, %3 : i32
  %5 = llvm.and %arg125, %2 : i32
  %6 = "llvm.select"(%4, %arg125, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %7 = llvm.mul %6, %5 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def shift_xor_multiuse_and_after := [llvm|
{
^0(%arg124 : i32, %arg125 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(-2049 : i32) : i32
  %3 = llvm.and %arg124, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.and %arg125, %2 : i32
  %6 = "llvm.select"(%4, %5, %arg125) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %7 = llvm.mul %6, %5 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shift_xor_multiuse_and_proof : shift_xor_multiuse_and_before ⊑ shift_xor_multiuse_and_after := by
  unfold shift_xor_multiuse_and_before shift_xor_multiuse_and_after
  simp_alive_peephole
  intros
  ---BEGIN shift_xor_multiuse_and
  all_goals (try extract_goal ; sorry)
  ---END shift_xor_multiuse_and



def shift_no_xor_multiuse_cmp_before := [llvm|
{
^0(%arg120 : i32, %arg121 : i32, %arg122 : i32, %arg123 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(2 : i32) : i32
  %3 = llvm.and %arg120, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.or %arg121, %2 : i32
  %6 = "llvm.select"(%4, %arg121, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %7 = "llvm.select"(%4, %arg122, %arg123) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %8 = llvm.mul %6, %7 : i32
  "llvm.return"(%8) : (i32) -> ()
}
]
def shift_no_xor_multiuse_cmp_after := [llvm|
{
^0(%arg120 : i32, %arg121 : i32, %arg122 : i32, %arg123 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg120, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  %4 = llvm.shl %2, %0 overflow<nsw,nuw> : i32
  %5 = llvm.or %arg121, %4 : i32
  %6 = "llvm.select"(%3, %arg122, %arg123) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %7 = llvm.mul %5, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shift_no_xor_multiuse_cmp_proof : shift_no_xor_multiuse_cmp_before ⊑ shift_no_xor_multiuse_cmp_after := by
  unfold shift_no_xor_multiuse_cmp_before shift_no_xor_multiuse_cmp_after
  simp_alive_peephole
  intros
  ---BEGIN shift_no_xor_multiuse_cmp
  all_goals (try extract_goal ; sorry)
  ---END shift_no_xor_multiuse_cmp



def shift_no_xor_multiuse_cmp_with_xor_before := [llvm|
{
^0(%arg116 : i32, %arg117 : i32, %arg118 : i32, %arg119 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(2 : i32) : i32
  %3 = llvm.and %arg116, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.xor %arg117, %2 : i32
  %6 = "llvm.select"(%4, %arg117, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %7 = "llvm.select"(%4, %arg118, %arg119) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %8 = llvm.mul %6, %7 : i32
  "llvm.return"(%8) : (i32) -> ()
}
]
def shift_no_xor_multiuse_cmp_with_xor_after := [llvm|
{
^0(%arg116 : i32, %arg117 : i32, %arg118 : i32, %arg119 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg116, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  %4 = llvm.shl %2, %0 overflow<nsw,nuw> : i32
  %5 = llvm.xor %arg117, %4 : i32
  %6 = "llvm.select"(%3, %arg118, %arg119) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %7 = llvm.mul %5, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shift_no_xor_multiuse_cmp_with_xor_proof : shift_no_xor_multiuse_cmp_with_xor_before ⊑ shift_no_xor_multiuse_cmp_with_xor_after := by
  unfold shift_no_xor_multiuse_cmp_with_xor_before shift_no_xor_multiuse_cmp_with_xor_after
  simp_alive_peephole
  intros
  ---BEGIN shift_no_xor_multiuse_cmp_with_xor
  all_goals (try extract_goal ; sorry)
  ---END shift_no_xor_multiuse_cmp_with_xor



def no_shift_no_xor_multiuse_cmp_before := [llvm|
{
^0(%arg108 : i32, %arg109 : i32, %arg110 : i32, %arg111 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg108, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  %4 = llvm.or %arg109, %0 : i32
  %5 = "llvm.select"(%3, %arg109, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %6 = "llvm.select"(%3, %arg110, %arg111) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %7 = llvm.mul %5, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def no_shift_no_xor_multiuse_cmp_after := [llvm|
{
^0(%arg108 : i32, %arg109 : i32, %arg110 : i32, %arg111 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg108, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  %4 = llvm.or %arg109, %2 : i32
  %5 = "llvm.select"(%3, %arg110, %arg111) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %6 = llvm.mul %4, %5 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem no_shift_no_xor_multiuse_cmp_proof : no_shift_no_xor_multiuse_cmp_before ⊑ no_shift_no_xor_multiuse_cmp_after := by
  unfold no_shift_no_xor_multiuse_cmp_before no_shift_no_xor_multiuse_cmp_after
  simp_alive_peephole
  intros
  ---BEGIN no_shift_no_xor_multiuse_cmp
  all_goals (try extract_goal ; sorry)
  ---END no_shift_no_xor_multiuse_cmp



def no_shift_no_xor_multiuse_cmp_with_xor_before := [llvm|
{
^0(%arg104 : i32, %arg105 : i32, %arg106 : i32, %arg107 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg104, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  %4 = llvm.xor %arg105, %0 : i32
  %5 = "llvm.select"(%3, %arg105, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %6 = "llvm.select"(%3, %arg106, %arg107) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %7 = llvm.mul %5, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def no_shift_no_xor_multiuse_cmp_with_xor_after := [llvm|
{
^0(%arg104 : i32, %arg105 : i32, %arg106 : i32, %arg107 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg104, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  %4 = llvm.xor %arg105, %2 : i32
  %5 = "llvm.select"(%3, %arg106, %arg107) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %6 = llvm.mul %4, %5 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem no_shift_no_xor_multiuse_cmp_with_xor_proof : no_shift_no_xor_multiuse_cmp_with_xor_before ⊑ no_shift_no_xor_multiuse_cmp_with_xor_after := by
  unfold no_shift_no_xor_multiuse_cmp_with_xor_before no_shift_no_xor_multiuse_cmp_with_xor_after
  simp_alive_peephole
  intros
  ---BEGIN no_shift_no_xor_multiuse_cmp_with_xor
  all_goals (try extract_goal ; sorry)
  ---END no_shift_no_xor_multiuse_cmp_with_xor



def no_shift_xor_multiuse_cmp_before := [llvm|
{
^0(%arg96 : i32, %arg97 : i32, %arg98 : i32, %arg99 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg96, %0 : i32
  %3 = llvm.icmp "ne" %1, %2 : i32
  %4 = llvm.or %arg97, %0 : i32
  %5 = "llvm.select"(%3, %arg97, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %6 = "llvm.select"(%3, %arg98, %arg99) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %7 = llvm.mul %5, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def no_shift_xor_multiuse_cmp_after := [llvm|
{
^0(%arg96 : i32, %arg97 : i32, %arg98 : i32, %arg99 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg96, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  %4 = llvm.xor %2, %0 : i32
  %5 = llvm.or %arg97, %4 : i32
  %6 = "llvm.select"(%3, %arg99, %arg98) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %7 = llvm.mul %5, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem no_shift_xor_multiuse_cmp_proof : no_shift_xor_multiuse_cmp_before ⊑ no_shift_xor_multiuse_cmp_after := by
  unfold no_shift_xor_multiuse_cmp_before no_shift_xor_multiuse_cmp_after
  simp_alive_peephole
  intros
  ---BEGIN no_shift_xor_multiuse_cmp
  all_goals (try extract_goal ; sorry)
  ---END no_shift_xor_multiuse_cmp



def no_shift_xor_multiuse_cmp_with_xor_before := [llvm|
{
^0(%arg92 : i32, %arg93 : i32, %arg94 : i32, %arg95 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg92, %0 : i32
  %3 = llvm.icmp "ne" %1, %2 : i32
  %4 = llvm.xor %arg93, %0 : i32
  %5 = "llvm.select"(%3, %arg93, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %6 = "llvm.select"(%3, %arg94, %arg95) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %7 = llvm.mul %5, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def no_shift_xor_multiuse_cmp_with_xor_after := [llvm|
{
^0(%arg92 : i32, %arg93 : i32, %arg94 : i32, %arg95 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg92, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  %4 = llvm.xor %2, %arg93 : i32
  %5 = llvm.xor %4, %0 : i32
  %6 = "llvm.select"(%3, %arg95, %arg94) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %7 = llvm.mul %5, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem no_shift_xor_multiuse_cmp_with_xor_proof : no_shift_xor_multiuse_cmp_with_xor_before ⊑ no_shift_xor_multiuse_cmp_with_xor_after := by
  unfold no_shift_xor_multiuse_cmp_with_xor_before no_shift_xor_multiuse_cmp_with_xor_after
  simp_alive_peephole
  intros
  ---BEGIN no_shift_xor_multiuse_cmp_with_xor
  all_goals (try extract_goal ; sorry)
  ---END no_shift_xor_multiuse_cmp_with_xor



def no_shift_xor_multiuse_cmp_with_and_before := [llvm|
{
^0(%arg88 : i32, %arg89 : i32, %arg90 : i32, %arg91 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(-4097 : i32) : i32
  %3 = llvm.and %arg88, %0 : i32
  %4 = llvm.icmp "ne" %1, %3 : i32
  %5 = llvm.and %arg89, %2 : i32
  %6 = "llvm.select"(%4, %arg89, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %7 = "llvm.select"(%4, %arg90, %arg91) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %8 = llvm.mul %6, %7 : i32
  "llvm.return"(%8) : (i32) -> ()
}
]
def no_shift_xor_multiuse_cmp_with_and_after := [llvm|
{
^0(%arg88 : i32, %arg89 : i32, %arg90 : i32, %arg91 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(-4097 : i32) : i32
  %3 = llvm.and %arg88, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.and %arg89, %2 : i32
  %6 = "llvm.select"(%4, %5, %arg89) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %7 = "llvm.select"(%4, %arg91, %arg90) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %8 = llvm.mul %6, %7 : i32
  "llvm.return"(%8) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem no_shift_xor_multiuse_cmp_with_and_proof : no_shift_xor_multiuse_cmp_with_and_before ⊑ no_shift_xor_multiuse_cmp_with_and_after := by
  unfold no_shift_xor_multiuse_cmp_with_and_before no_shift_xor_multiuse_cmp_with_and_after
  simp_alive_peephole
  intros
  ---BEGIN no_shift_xor_multiuse_cmp_with_and
  all_goals (try extract_goal ; sorry)
  ---END no_shift_xor_multiuse_cmp_with_and



def shift_xor_multiuse_cmp_before := [llvm|
{
^0(%arg84 : i32, %arg85 : i32, %arg86 : i32, %arg87 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(2048 : i32) : i32
  %3 = llvm.and %arg84, %0 : i32
  %4 = llvm.icmp "ne" %1, %3 : i32
  %5 = llvm.or %arg85, %2 : i32
  %6 = "llvm.select"(%4, %arg85, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %7 = "llvm.select"(%4, %arg86, %arg87) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %8 = llvm.mul %6, %7 : i32
  "llvm.return"(%8) : (i32) -> ()
}
]
def shift_xor_multiuse_cmp_after := [llvm|
{
^0(%arg84 : i32, %arg85 : i32, %arg86 : i32, %arg87 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(2048 : i32) : i32
  %3 = llvm.and %arg84, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.or %arg85, %2 : i32
  %6 = "llvm.select"(%4, %5, %arg85) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %7 = "llvm.select"(%4, %arg87, %arg86) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %8 = llvm.mul %6, %7 : i32
  "llvm.return"(%8) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shift_xor_multiuse_cmp_proof : shift_xor_multiuse_cmp_before ⊑ shift_xor_multiuse_cmp_after := by
  unfold shift_xor_multiuse_cmp_before shift_xor_multiuse_cmp_after
  simp_alive_peephole
  intros
  ---BEGIN shift_xor_multiuse_cmp
  all_goals (try extract_goal ; sorry)
  ---END shift_xor_multiuse_cmp



def shift_xor_multiuse_cmp_with_xor_before := [llvm|
{
^0(%arg80 : i32, %arg81 : i32, %arg82 : i32, %arg83 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(2048 : i32) : i32
  %3 = llvm.and %arg80, %0 : i32
  %4 = llvm.icmp "ne" %1, %3 : i32
  %5 = llvm.xor %arg81, %2 : i32
  %6 = "llvm.select"(%4, %arg81, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %7 = "llvm.select"(%4, %arg82, %arg83) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %8 = llvm.mul %6, %7 : i32
  "llvm.return"(%8) : (i32) -> ()
}
]
def shift_xor_multiuse_cmp_with_xor_after := [llvm|
{
^0(%arg80 : i32, %arg81 : i32, %arg82 : i32, %arg83 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(2048 : i32) : i32
  %3 = llvm.and %arg80, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.xor %arg81, %2 : i32
  %6 = "llvm.select"(%4, %5, %arg81) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %7 = "llvm.select"(%4, %arg83, %arg82) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %8 = llvm.mul %6, %7 : i32
  "llvm.return"(%8) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shift_xor_multiuse_cmp_with_xor_proof : shift_xor_multiuse_cmp_with_xor_before ⊑ shift_xor_multiuse_cmp_with_xor_after := by
  unfold shift_xor_multiuse_cmp_with_xor_before shift_xor_multiuse_cmp_with_xor_after
  simp_alive_peephole
  intros
  ---BEGIN shift_xor_multiuse_cmp_with_xor
  all_goals (try extract_goal ; sorry)
  ---END shift_xor_multiuse_cmp_with_xor



def shift_xor_multiuse_cmp_with_and_before := [llvm|
{
^0(%arg76 : i32, %arg77 : i32, %arg78 : i32, %arg79 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(-2049 : i32) : i32
  %3 = llvm.and %arg76, %0 : i32
  %4 = llvm.icmp "ne" %1, %3 : i32
  %5 = llvm.and %arg77, %2 : i32
  %6 = "llvm.select"(%4, %arg77, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %7 = "llvm.select"(%4, %arg78, %arg79) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %8 = llvm.mul %6, %7 : i32
  "llvm.return"(%8) : (i32) -> ()
}
]
def shift_xor_multiuse_cmp_with_and_after := [llvm|
{
^0(%arg76 : i32, %arg77 : i32, %arg78 : i32, %arg79 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(-2049 : i32) : i32
  %3 = llvm.and %arg76, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.and %arg77, %2 : i32
  %6 = "llvm.select"(%4, %5, %arg77) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %7 = "llvm.select"(%4, %arg79, %arg78) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %8 = llvm.mul %6, %7 : i32
  "llvm.return"(%8) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shift_xor_multiuse_cmp_with_and_proof : shift_xor_multiuse_cmp_with_and_before ⊑ shift_xor_multiuse_cmp_with_and_after := by
  unfold shift_xor_multiuse_cmp_with_and_before shift_xor_multiuse_cmp_with_and_after
  simp_alive_peephole
  intros
  ---BEGIN shift_xor_multiuse_cmp_with_and
  all_goals (try extract_goal ; sorry)
  ---END shift_xor_multiuse_cmp_with_and



def no_shift_no_xor_multiuse_cmp_or_before := [llvm|
{
^0(%arg60 : i32, %arg61 : i32, %arg62 : i32, %arg63 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg60, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  %4 = llvm.or %arg61, %0 : i32
  %5 = "llvm.select"(%3, %arg61, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %6 = "llvm.select"(%3, %arg62, %arg63) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %7 = llvm.mul %5, %6 : i32
  %8 = llvm.mul %7, %4 : i32
  "llvm.return"(%8) : (i32) -> ()
}
]
def no_shift_no_xor_multiuse_cmp_or_after := [llvm|
{
^0(%arg60 : i32, %arg61 : i32, %arg62 : i32, %arg63 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg60, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  %4 = llvm.or %arg61, %0 : i32
  %5 = llvm.or %arg61, %2 : i32
  %6 = "llvm.select"(%3, %arg62, %arg63) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %7 = llvm.mul %5, %6 : i32
  %8 = llvm.mul %7, %4 : i32
  "llvm.return"(%8) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem no_shift_no_xor_multiuse_cmp_or_proof : no_shift_no_xor_multiuse_cmp_or_before ⊑ no_shift_no_xor_multiuse_cmp_or_after := by
  unfold no_shift_no_xor_multiuse_cmp_or_before no_shift_no_xor_multiuse_cmp_or_after
  simp_alive_peephole
  intros
  ---BEGIN no_shift_no_xor_multiuse_cmp_or
  all_goals (try extract_goal ; sorry)
  ---END no_shift_no_xor_multiuse_cmp_or



def no_shift_no_xor_multiuse_cmp_xor_before := [llvm|
{
^0(%arg56 : i32, %arg57 : i32, %arg58 : i32, %arg59 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg56, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  %4 = llvm.xor %arg57, %0 : i32
  %5 = "llvm.select"(%3, %arg57, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %6 = "llvm.select"(%3, %arg58, %arg59) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %7 = llvm.mul %5, %6 : i32
  %8 = llvm.mul %7, %4 : i32
  "llvm.return"(%8) : (i32) -> ()
}
]
def no_shift_no_xor_multiuse_cmp_xor_after := [llvm|
{
^0(%arg56 : i32, %arg57 : i32, %arg58 : i32, %arg59 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg56, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  %4 = llvm.xor %arg57, %0 : i32
  %5 = llvm.xor %arg57, %2 : i32
  %6 = "llvm.select"(%3, %arg58, %arg59) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %7 = llvm.mul %5, %6 : i32
  %8 = llvm.mul %7, %4 : i32
  "llvm.return"(%8) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem no_shift_no_xor_multiuse_cmp_xor_proof : no_shift_no_xor_multiuse_cmp_xor_before ⊑ no_shift_no_xor_multiuse_cmp_xor_after := by
  unfold no_shift_no_xor_multiuse_cmp_xor_before no_shift_no_xor_multiuse_cmp_xor_after
  simp_alive_peephole
  intros
  ---BEGIN no_shift_no_xor_multiuse_cmp_xor
  all_goals (try extract_goal ; sorry)
  ---END no_shift_no_xor_multiuse_cmp_xor



def no_shift_xor_multiuse_cmp_or_before := [llvm|
{
^0(%arg48 : i32, %arg49 : i32, %arg50 : i32, %arg51 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg48, %0 : i32
  %3 = llvm.icmp "ne" %1, %2 : i32
  %4 = llvm.or %arg49, %0 : i32
  %5 = "llvm.select"(%3, %arg49, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %6 = "llvm.select"(%3, %arg50, %arg51) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %7 = llvm.mul %5, %6 : i32
  %8 = llvm.mul %7, %4 : i32
  "llvm.return"(%8) : (i32) -> ()
}
]
def no_shift_xor_multiuse_cmp_or_after := [llvm|
{
^0(%arg48 : i32, %arg49 : i32, %arg50 : i32, %arg51 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg48, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  %4 = llvm.or %arg49, %0 : i32
  %5 = "llvm.select"(%3, %4, %arg49) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %6 = "llvm.select"(%3, %arg51, %arg50) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %7 = llvm.mul %5, %6 : i32
  %8 = llvm.mul %7, %4 : i32
  "llvm.return"(%8) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem no_shift_xor_multiuse_cmp_or_proof : no_shift_xor_multiuse_cmp_or_before ⊑ no_shift_xor_multiuse_cmp_or_after := by
  unfold no_shift_xor_multiuse_cmp_or_before no_shift_xor_multiuse_cmp_or_after
  simp_alive_peephole
  intros
  ---BEGIN no_shift_xor_multiuse_cmp_or
  all_goals (try extract_goal ; sorry)
  ---END no_shift_xor_multiuse_cmp_or



def no_shift_xor_multiuse_cmp_xor_before := [llvm|
{
^0(%arg44 : i32, %arg45 : i32, %arg46 : i32, %arg47 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg44, %0 : i32
  %3 = llvm.icmp "ne" %1, %2 : i32
  %4 = llvm.xor %arg45, %0 : i32
  %5 = "llvm.select"(%3, %arg45, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %6 = "llvm.select"(%3, %arg46, %arg47) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %7 = llvm.mul %5, %6 : i32
  %8 = llvm.mul %7, %4 : i32
  "llvm.return"(%8) : (i32) -> ()
}
]
def no_shift_xor_multiuse_cmp_xor_after := [llvm|
{
^0(%arg44 : i32, %arg45 : i32, %arg46 : i32, %arg47 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg44, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  %4 = llvm.xor %arg45, %0 : i32
  %5 = "llvm.select"(%3, %4, %arg45) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %6 = "llvm.select"(%3, %arg47, %arg46) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %7 = llvm.mul %5, %6 : i32
  %8 = llvm.mul %7, %4 : i32
  "llvm.return"(%8) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem no_shift_xor_multiuse_cmp_xor_proof : no_shift_xor_multiuse_cmp_xor_before ⊑ no_shift_xor_multiuse_cmp_xor_after := by
  unfold no_shift_xor_multiuse_cmp_xor_before no_shift_xor_multiuse_cmp_xor_after
  simp_alive_peephole
  intros
  ---BEGIN no_shift_xor_multiuse_cmp_xor
  all_goals (try extract_goal ; sorry)
  ---END no_shift_xor_multiuse_cmp_xor



def no_shift_xor_multiuse_cmp_and_before := [llvm|
{
^0(%arg40 : i32, %arg41 : i32, %arg42 : i32, %arg43 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(-4097 : i32) : i32
  %3 = llvm.and %arg40, %0 : i32
  %4 = llvm.icmp "ne" %1, %3 : i32
  %5 = llvm.and %arg41, %2 : i32
  %6 = "llvm.select"(%4, %arg41, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %7 = "llvm.select"(%4, %arg42, %arg43) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %8 = llvm.mul %6, %7 : i32
  %9 = llvm.mul %8, %5 : i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def no_shift_xor_multiuse_cmp_and_after := [llvm|
{
^0(%arg40 : i32, %arg41 : i32, %arg42 : i32, %arg43 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(-4097 : i32) : i32
  %3 = llvm.and %arg40, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.and %arg41, %2 : i32
  %6 = "llvm.select"(%4, %5, %arg41) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %7 = "llvm.select"(%4, %arg43, %arg42) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %8 = llvm.mul %6, %7 : i32
  %9 = llvm.mul %8, %5 : i32
  "llvm.return"(%9) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem no_shift_xor_multiuse_cmp_and_proof : no_shift_xor_multiuse_cmp_and_before ⊑ no_shift_xor_multiuse_cmp_and_after := by
  unfold no_shift_xor_multiuse_cmp_and_before no_shift_xor_multiuse_cmp_and_after
  simp_alive_peephole
  intros
  ---BEGIN no_shift_xor_multiuse_cmp_and
  all_goals (try extract_goal ; sorry)
  ---END no_shift_xor_multiuse_cmp_and



def shift_xor_multiuse_cmp_or_before := [llvm|
{
^0(%arg36 : i32, %arg37 : i32, %arg38 : i32, %arg39 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(2048 : i32) : i32
  %3 = llvm.and %arg36, %0 : i32
  %4 = llvm.icmp "ne" %1, %3 : i32
  %5 = llvm.or %arg37, %2 : i32
  %6 = "llvm.select"(%4, %arg37, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %7 = "llvm.select"(%4, %arg38, %arg39) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %8 = llvm.mul %6, %7 : i32
  %9 = llvm.mul %8, %5 : i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def shift_xor_multiuse_cmp_or_after := [llvm|
{
^0(%arg36 : i32, %arg37 : i32, %arg38 : i32, %arg39 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(2048 : i32) : i32
  %3 = llvm.and %arg36, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.or %arg37, %2 : i32
  %6 = "llvm.select"(%4, %5, %arg37) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %7 = "llvm.select"(%4, %arg39, %arg38) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %8 = llvm.mul %6, %7 : i32
  %9 = llvm.mul %8, %5 : i32
  "llvm.return"(%9) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shift_xor_multiuse_cmp_or_proof : shift_xor_multiuse_cmp_or_before ⊑ shift_xor_multiuse_cmp_or_after := by
  unfold shift_xor_multiuse_cmp_or_before shift_xor_multiuse_cmp_or_after
  simp_alive_peephole
  intros
  ---BEGIN shift_xor_multiuse_cmp_or
  all_goals (try extract_goal ; sorry)
  ---END shift_xor_multiuse_cmp_or



def shift_xor_multiuse_cmp_xor_before := [llvm|
{
^0(%arg32 : i32, %arg33 : i32, %arg34 : i32, %arg35 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(2048 : i32) : i32
  %3 = llvm.and %arg32, %0 : i32
  %4 = llvm.icmp "ne" %1, %3 : i32
  %5 = llvm.xor %arg33, %2 : i32
  %6 = "llvm.select"(%4, %arg33, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %7 = "llvm.select"(%4, %arg34, %arg35) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %8 = llvm.mul %6, %7 : i32
  %9 = llvm.mul %8, %5 : i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def shift_xor_multiuse_cmp_xor_after := [llvm|
{
^0(%arg32 : i32, %arg33 : i32, %arg34 : i32, %arg35 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(2048 : i32) : i32
  %3 = llvm.and %arg32, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.xor %arg33, %2 : i32
  %6 = "llvm.select"(%4, %5, %arg33) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %7 = "llvm.select"(%4, %arg35, %arg34) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %8 = llvm.mul %6, %7 : i32
  %9 = llvm.mul %8, %5 : i32
  "llvm.return"(%9) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shift_xor_multiuse_cmp_xor_proof : shift_xor_multiuse_cmp_xor_before ⊑ shift_xor_multiuse_cmp_xor_after := by
  unfold shift_xor_multiuse_cmp_xor_before shift_xor_multiuse_cmp_xor_after
  simp_alive_peephole
  intros
  ---BEGIN shift_xor_multiuse_cmp_xor
  all_goals (try extract_goal ; sorry)
  ---END shift_xor_multiuse_cmp_xor



def shift_xor_multiuse_cmp_and_before := [llvm|
{
^0(%arg28 : i32, %arg29 : i32, %arg30 : i32, %arg31 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(2048 : i32) : i32
  %3 = llvm.and %arg28, %0 : i32
  %4 = llvm.icmp "ne" %1, %3 : i32
  %5 = llvm.and %arg29, %2 : i32
  %6 = "llvm.select"(%4, %arg29, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %7 = "llvm.select"(%4, %arg30, %arg31) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %8 = llvm.mul %6, %7 : i32
  %9 = llvm.mul %8, %5 : i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def shift_xor_multiuse_cmp_and_after := [llvm|
{
^0(%arg28 : i32, %arg29 : i32, %arg30 : i32, %arg31 : i32):
  %0 = llvm.mlir.constant(4096 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(2048 : i32) : i32
  %3 = llvm.and %arg28, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.and %arg29, %2 : i32
  %6 = "llvm.select"(%4, %5, %arg29) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %7 = "llvm.select"(%4, %arg31, %arg30) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %8 = llvm.mul %6, %7 : i32
  %9 = llvm.mul %8, %5 : i32
  "llvm.return"(%9) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shift_xor_multiuse_cmp_and_proof : shift_xor_multiuse_cmp_and_before ⊑ shift_xor_multiuse_cmp_and_after := by
  unfold shift_xor_multiuse_cmp_and_before shift_xor_multiuse_cmp_and_after
  simp_alive_peephole
  intros
  ---BEGIN shift_xor_multiuse_cmp_and
  all_goals (try extract_goal ; sorry)
  ---END shift_xor_multiuse_cmp_and



def set_bits_before := [llvm|
{
^0(%arg26 : i8, %arg27 : i1):
  %0 = llvm.mlir.constant(-6 : i8) : i8
  %1 = llvm.mlir.constant(5 : i8) : i8
  %2 = llvm.and %arg26, %0 : i8
  %3 = llvm.or %arg26, %1 : i8
  %4 = "llvm.select"(%arg27, %3, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def set_bits_after := [llvm|
{
^0(%arg26 : i8, %arg27 : i1):
  %0 = llvm.mlir.constant(-6 : i8) : i8
  %1 = llvm.mlir.constant(5 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.and %arg26, %0 : i8
  %4 = "llvm.select"(%arg27, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %5 = llvm.or disjoint %3, %4 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem set_bits_proof : set_bits_before ⊑ set_bits_after := by
  unfold set_bits_before set_bits_after
  simp_alive_peephole
  intros
  ---BEGIN set_bits
  all_goals (try extract_goal ; sorry)
  ---END set_bits



def xor_i8_to_i64_shl_save_and_ne_before := [llvm|
{
^0(%arg8 : i8, %arg9 : i64):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.mlir.constant(-9223372036854775808) : i64
  %3 = llvm.and %arg8, %0 : i8
  %4 = llvm.icmp "ne" %3, %1 : i8
  %5 = llvm.xor %arg9, %2 : i64
  %6 = "llvm.select"(%4, %5, %arg9) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%6) : (i64) -> ()
}
]
def xor_i8_to_i64_shl_save_and_ne_after := [llvm|
{
^0(%arg8 : i8, %arg9 : i64):
  %0 = llvm.mlir.constant(63) : i64
  %1 = llvm.zext %arg8 : i8 to i64
  %2 = llvm.shl %1, %0 : i64
  %3 = llvm.xor %arg9, %2 : i64
  "llvm.return"(%3) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_i8_to_i64_shl_save_and_ne_proof : xor_i8_to_i64_shl_save_and_ne_before ⊑ xor_i8_to_i64_shl_save_and_ne_after := by
  unfold xor_i8_to_i64_shl_save_and_ne_before xor_i8_to_i64_shl_save_and_ne_after
  simp_alive_peephole
  intros
  ---BEGIN xor_i8_to_i64_shl_save_and_ne
  all_goals (try extract_goal ; sorry)
  ---END xor_i8_to_i64_shl_save_and_ne



def select_icmp_eq_and_1_0_lshr_fv_before := [llvm|
{
^0(%arg2 : i8, %arg3 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.mlir.constant(2 : i8) : i8
  %3 = llvm.and %arg2, %0 : i8
  %4 = llvm.icmp "eq" %3, %1 : i8
  %5 = llvm.lshr %arg3, %2 : i8
  %6 = "llvm.select"(%4, %arg3, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def select_icmp_eq_and_1_0_lshr_fv_after := [llvm|
{
^0(%arg2 : i8, %arg3 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(2 : i8) : i8
  %2 = llvm.shl %arg2, %0 : i8
  %3 = llvm.and %2, %1 : i8
  %4 = llvm.lshr %arg3, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_icmp_eq_and_1_0_lshr_fv_proof : select_icmp_eq_and_1_0_lshr_fv_before ⊑ select_icmp_eq_and_1_0_lshr_fv_after := by
  unfold select_icmp_eq_and_1_0_lshr_fv_before select_icmp_eq_and_1_0_lshr_fv_after
  simp_alive_peephole
  intros
  ---BEGIN select_icmp_eq_and_1_0_lshr_fv
  all_goals (try extract_goal ; sorry)
  ---END select_icmp_eq_and_1_0_lshr_fv



def select_icmp_eq_and_1_0_lshr_tv_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.mlir.constant(2 : i8) : i8
  %3 = llvm.and %arg0, %0 : i8
  %4 = llvm.icmp "ne" %3, %1 : i8
  %5 = llvm.lshr %arg1, %2 : i8
  %6 = "llvm.select"(%4, %5, %arg1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def select_icmp_eq_and_1_0_lshr_tv_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(2 : i8) : i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = llvm.and %2, %1 : i8
  %4 = llvm.lshr %arg1, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_icmp_eq_and_1_0_lshr_tv_proof : select_icmp_eq_and_1_0_lshr_tv_before ⊑ select_icmp_eq_and_1_0_lshr_tv_after := by
  unfold select_icmp_eq_and_1_0_lshr_tv_before select_icmp_eq_and_1_0_lshr_tv_after
  simp_alive_peephole
  intros
  ---BEGIN select_icmp_eq_and_1_0_lshr_tv
  all_goals (try extract_goal ; sorry)
  ---END select_icmp_eq_and_1_0_lshr_tv


