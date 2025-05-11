
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
section gfreehinversion_statements

def xor_1_before := [llvm|
{
^0(%arg137 : i8, %arg138 : i1, %arg139 : i8, %arg140 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(123 : i8) : i8
  %2 = llvm.xor %arg139, %0 : i8
  %3 = llvm.xor %arg140, %1 : i8
  %4 = "llvm.select"(%arg138, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %5 = llvm.xor %4, %arg137 : i8
  %6 = llvm.xor %5, %0 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def xor_1_after := [llvm|
{
^0(%arg137 : i8, %arg138 : i1, %arg139 : i8, %arg140 : i8):
  %0 = llvm.mlir.constant(-124 : i8) : i8
  %1 = llvm.xor %arg140, %0 : i8
  %2 = "llvm.select"(%arg138, %arg139, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %3 = llvm.xor %2, %arg137 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_1_proof : xor_1_before ⊑ xor_1_after := by
  unfold xor_1_before xor_1_after
  simp_alive_peephole
  intros
  ---BEGIN xor_1
  all_goals (try extract_goal ; sorry)
  ---END xor_1



def xor_2_before := [llvm|
{
^0(%arg133 : i8, %arg134 : i1, %arg135 : i8, %arg136 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(123 : i8) : i8
  %2 = llvm.xor %arg135, %0 : i8
  %3 = llvm.xor %arg136, %1 : i8
  %4 = "llvm.select"(%arg134, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %5 = llvm.xor %arg133, %4 : i8
  %6 = llvm.xor %5, %0 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def xor_2_after := [llvm|
{
^0(%arg133 : i8, %arg134 : i1, %arg135 : i8, %arg136 : i8):
  %0 = llvm.mlir.constant(-124 : i8) : i8
  %1 = llvm.xor %arg136, %0 : i8
  %2 = "llvm.select"(%arg134, %arg135, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %3 = llvm.xor %arg133, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_2_proof : xor_2_before ⊑ xor_2_after := by
  unfold xor_2_before xor_2_after
  simp_alive_peephole
  intros
  ---BEGIN xor_2
  all_goals (try extract_goal ; sorry)
  ---END xor_2



def add_1_before := [llvm|
{
^0(%arg125 : i8, %arg126 : i1, %arg127 : i8, %arg128 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(123 : i8) : i8
  %2 = llvm.xor %arg127, %0 : i8
  %3 = llvm.xor %arg128, %1 : i8
  %4 = "llvm.select"(%arg126, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %5 = llvm.add %4, %arg125 : i8
  %6 = llvm.xor %5, %0 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def add_1_after := [llvm|
{
^0(%arg125 : i8, %arg126 : i1, %arg127 : i8, %arg128 : i8):
  %0 = llvm.mlir.constant(-124 : i8) : i8
  %1 = llvm.xor %arg128, %0 : i8
  %2 = "llvm.select"(%arg126, %arg127, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %3 = llvm.sub %2, %arg125 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_1_proof : add_1_before ⊑ add_1_after := by
  unfold add_1_before add_1_after
  simp_alive_peephole
  intros
  ---BEGIN add_1
  all_goals (try extract_goal ; sorry)
  ---END add_1



def add_2_before := [llvm|
{
^0(%arg121 : i8, %arg122 : i1, %arg123 : i8, %arg124 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(123 : i8) : i8
  %2 = llvm.xor %arg123, %0 : i8
  %3 = llvm.xor %arg124, %1 : i8
  %4 = "llvm.select"(%arg122, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %5 = llvm.add %arg121, %4 : i8
  %6 = llvm.xor %5, %0 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def add_2_after := [llvm|
{
^0(%arg121 : i8, %arg122 : i1, %arg123 : i8, %arg124 : i8):
  %0 = llvm.mlir.constant(-124 : i8) : i8
  %1 = llvm.xor %arg124, %0 : i8
  %2 = "llvm.select"(%arg122, %arg123, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %3 = llvm.sub %2, %arg121 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_2_proof : add_2_before ⊑ add_2_after := by
  unfold add_2_before add_2_after
  simp_alive_peephole
  intros
  ---BEGIN add_2
  all_goals (try extract_goal ; sorry)
  ---END add_2



def sub_1_before := [llvm|
{
^0(%arg113 : i8, %arg114 : i1, %arg115 : i8, %arg116 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(123 : i8) : i8
  %2 = llvm.xor %arg115, %0 : i8
  %3 = llvm.xor %arg116, %1 : i8
  %4 = "llvm.select"(%arg114, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %5 = llvm.sub %4, %arg113 : i8
  %6 = llvm.xor %5, %0 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def sub_1_after := [llvm|
{
^0(%arg113 : i8, %arg114 : i1, %arg115 : i8, %arg116 : i8):
  %0 = llvm.mlir.constant(-124 : i8) : i8
  %1 = llvm.xor %arg116, %0 : i8
  %2 = "llvm.select"(%arg114, %arg115, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %3 = llvm.add %2, %arg113 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sub_1_proof : sub_1_before ⊑ sub_1_after := by
  unfold sub_1_before sub_1_after
  simp_alive_peephole
  intros
  ---BEGIN sub_1
  all_goals (try extract_goal ; sorry)
  ---END sub_1



def sub_2_before := [llvm|
{
^0(%arg109 : i8, %arg110 : i1, %arg111 : i8, %arg112 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(123 : i8) : i8
  %2 = llvm.xor %arg111, %0 : i8
  %3 = llvm.xor %arg112, %1 : i8
  %4 = "llvm.select"(%arg110, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %5 = llvm.sub %arg109, %4 : i8
  %6 = llvm.xor %5, %0 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def sub_2_after := [llvm|
{
^0(%arg109 : i8, %arg110 : i1, %arg111 : i8, %arg112 : i8):
  %0 = llvm.mlir.constant(-124 : i8) : i8
  %1 = llvm.mlir.constant(-2 : i8) : i8
  %2 = llvm.xor %arg112, %0 : i8
  %3 = "llvm.select"(%arg110, %arg111, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %4 = llvm.add %3, %arg109 : i8
  %5 = llvm.sub %1, %4 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sub_2_proof : sub_2_before ⊑ sub_2_after := by
  unfold sub_2_before sub_2_after
  simp_alive_peephole
  intros
  ---BEGIN sub_2
  all_goals (try extract_goal ; sorry)
  ---END sub_2



def sub_3_before := [llvm|
{
^0(%arg105 : i128, %arg106 : i1, %arg107 : i128, %arg108 : i128):
  %0 = llvm.mlir.constant(-1 : i128) : i128
  %1 = llvm.mlir.constant(123 : i128) : i128
  %2 = llvm.xor %arg107, %0 : i128
  %3 = llvm.xor %arg108, %1 : i128
  %4 = "llvm.select"(%arg106, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i128, i128) -> i128
  %5 = llvm.sub %arg105, %4 : i128
  %6 = llvm.xor %5, %0 : i128
  "llvm.return"(%6) : (i128) -> ()
}
]
def sub_3_after := [llvm|
{
^0(%arg105 : i128, %arg106 : i1, %arg107 : i128, %arg108 : i128):
  %0 = llvm.mlir.constant(-124 : i128) : i128
  %1 = llvm.mlir.constant(-2 : i128) : i128
  %2 = llvm.xor %arg108, %0 : i128
  %3 = "llvm.select"(%arg106, %arg107, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i128, i128) -> i128
  %4 = llvm.add %3, %arg105 : i128
  %5 = llvm.sub %1, %4 : i128
  "llvm.return"(%5) : (i128) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sub_3_proof : sub_3_before ⊑ sub_3_after := by
  unfold sub_3_before sub_3_after
  simp_alive_peephole
  intros
  ---BEGIN sub_3
  all_goals (try extract_goal ; sorry)
  ---END sub_3



def ashr_1_before := [llvm|
{
^0(%arg97 : i8, %arg98 : i1, %arg99 : i8, %arg100 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(123 : i8) : i8
  %2 = llvm.xor %arg99, %0 : i8
  %3 = llvm.xor %arg100, %1 : i8
  %4 = "llvm.select"(%arg98, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %5 = llvm.ashr %4, %arg97 : i8
  %6 = llvm.xor %5, %0 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def ashr_1_after := [llvm|
{
^0(%arg97 : i8, %arg98 : i1, %arg99 : i8, %arg100 : i8):
  %0 = llvm.mlir.constant(-124 : i8) : i8
  %1 = llvm.xor %arg100, %0 : i8
  %2 = "llvm.select"(%arg98, %arg99, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %3 = llvm.ashr %2, %arg97 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_1_proof : ashr_1_before ⊑ ashr_1_after := by
  unfold ashr_1_before ashr_1_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_1
  all_goals (try extract_goal ; sorry)
  ---END ashr_1



def select_1_before := [llvm|
{
^0(%arg87 : i1, %arg88 : i8, %arg89 : i8, %arg90 : i1, %arg91 : i8, %arg92 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(123 : i8) : i8
  %2 = llvm.mlir.constant(45 : i8) : i8
  %3 = llvm.xor %arg91, %0 : i8
  %4 = llvm.xor %arg92, %1 : i8
  %5 = "llvm.select"(%arg90, %3, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %6 = llvm.xor %arg88, %2 : i8
  %7 = llvm.xor %arg89, %6 : i8
  %8 = "llvm.select"(%arg87, %7, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %9 = llvm.xor %8, %0 : i8
  "llvm.return"(%9) : (i8) -> ()
}
]
def select_1_after := [llvm|
{
^0(%arg87 : i1, %arg88 : i8, %arg89 : i8, %arg90 : i1, %arg91 : i8, %arg92 : i8):
  %0 = llvm.mlir.constant(-46 : i8) : i8
  %1 = llvm.mlir.constant(-124 : i8) : i8
  %2 = llvm.xor %arg88, %arg89 : i8
  %3 = llvm.xor %2, %0 : i8
  %4 = llvm.xor %arg92, %1 : i8
  %5 = "llvm.select"(%arg90, %arg91, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %6 = "llvm.select"(%arg87, %3, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%6) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_1_proof : select_1_before ⊑ select_1_after := by
  unfold select_1_before select_1_after
  simp_alive_peephole
  intros
  ---BEGIN select_1
  all_goals (try extract_goal ; sorry)
  ---END select_1



def select_2_before := [llvm|
{
^0(%arg82 : i1, %arg83 : i8, %arg84 : i1, %arg85 : i8, %arg86 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(123 : i8) : i8
  %2 = llvm.mlir.constant(45 : i8) : i8
  %3 = llvm.xor %arg85, %0 : i8
  %4 = llvm.xor %arg86, %1 : i8
  %5 = "llvm.select"(%arg84, %3, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %6 = llvm.xor %arg83, %2 : i8
  %7 = "llvm.select"(%arg82, %5, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %8 = llvm.xor %7, %0 : i8
  "llvm.return"(%8) : (i8) -> ()
}
]
def select_2_after := [llvm|
{
^0(%arg82 : i1, %arg83 : i8, %arg84 : i1, %arg85 : i8, %arg86 : i8):
  %0 = llvm.mlir.constant(-124 : i8) : i8
  %1 = llvm.mlir.constant(-46 : i8) : i8
  %2 = llvm.xor %arg86, %0 : i8
  %3 = "llvm.select"(%arg84, %arg85, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %4 = llvm.xor %arg83, %1 : i8
  %5 = "llvm.select"(%arg82, %3, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%5) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_2_proof : select_2_before ⊑ select_2_after := by
  unfold select_2_before select_2_after
  simp_alive_peephole
  intros
  ---BEGIN select_2
  all_goals (try extract_goal ; sorry)
  ---END select_2



def lshr_not_nneg2_before := [llvm|
{
^0(%arg20 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.xor %arg20, %0 : i8
  %3 = llvm.lshr %2, %1 : i8
  %4 = llvm.xor %3, %0 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def lshr_not_nneg2_after := [llvm|
{
^0(%arg20 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(-128 : i8) : i8
  %2 = llvm.lshr %arg20, %0 : i8
  %3 = llvm.or disjoint %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_not_nneg2_proof : lshr_not_nneg2_before ⊑ lshr_not_nneg2_after := by
  unfold lshr_not_nneg2_before lshr_not_nneg2_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_not_nneg2
  all_goals (try extract_goal ; sorry)
  ---END lshr_not_nneg2


