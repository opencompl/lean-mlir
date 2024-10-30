
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
section glogicalhselecthinseltpoison_statements

def bools_before := [llvm|
{
^0(%arg51 : i1, %arg52 : i1, %arg53 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg53, %0 : i1
  %2 = llvm.and %1, %arg51 : i1
  %3 = llvm.and %arg53, %arg52 : i1
  %4 = llvm.or %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def bools_after := [llvm|
{
^0(%arg51 : i1, %arg52 : i1, %arg53 : i1):
  %0 = "llvm.select"(%arg53, %arg52, %arg51) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem bools_proof : bools_before ⊑ bools_after := by
  unfold bools_before bools_after
  simp_alive_peephole
  ---BEGIN bools
  all_goals (try extract_goal ; sorry)
  ---END bools



def bools_logical_before := [llvm|
{
^0(%arg48 : i1, %arg49 : i1, %arg50 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.xor %arg50, %0 : i1
  %3 = "llvm.select"(%2, %arg48, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%arg50, %arg49, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %5 = "llvm.select"(%3, %0, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def bools_logical_after := [llvm|
{
^0(%arg48 : i1, %arg49 : i1, %arg50 : i1):
  %0 = "llvm.select"(%arg50, %arg49, %arg48) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem bools_logical_proof : bools_logical_before ⊑ bools_logical_after := by
  unfold bools_logical_before bools_logical_after
  simp_alive_peephole
  ---BEGIN bools_logical
  all_goals (try extract_goal ; sorry)
  ---END bools_logical



def bools_multi_uses1_before := [llvm|
{
^0(%arg45 : i1, %arg46 : i1, %arg47 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg47, %0 : i1
  %2 = llvm.and %1, %arg45 : i1
  %3 = llvm.and %arg47, %arg46 : i1
  %4 = llvm.or %2, %3 : i1
  %5 = llvm.xor %4, %2 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def bools_multi_uses1_after := [llvm|
{
^0(%arg45 : i1, %arg46 : i1, %arg47 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg47, %0 : i1
  %2 = llvm.and %arg45, %1 : i1
  %3 = "llvm.select"(%arg47, %arg46, %arg45) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = llvm.xor %3, %2 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
theorem bools_multi_uses1_proof : bools_multi_uses1_before ⊑ bools_multi_uses1_after := by
  unfold bools_multi_uses1_before bools_multi_uses1_after
  simp_alive_peephole
  ---BEGIN bools_multi_uses1
  all_goals (try extract_goal ; sorry)
  ---END bools_multi_uses1



def bools_multi_uses1_logical_before := [llvm|
{
^0(%arg42 : i1, %arg43 : i1, %arg44 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.xor %arg44, %0 : i1
  %3 = "llvm.select"(%2, %arg42, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%arg44, %arg43, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %5 = "llvm.select"(%3, %0, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %6 = llvm.xor %5, %3 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def bools_multi_uses1_logical_after := [llvm|
{
^0(%arg42 : i1, %arg43 : i1, %arg44 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.xor %arg44, %0 : i1
  %3 = "llvm.select"(%2, %arg42, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%arg44, %arg43, %arg42) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %5 = llvm.xor %4, %3 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
theorem bools_multi_uses1_logical_proof : bools_multi_uses1_logical_before ⊑ bools_multi_uses1_logical_after := by
  unfold bools_multi_uses1_logical_before bools_multi_uses1_logical_after
  simp_alive_peephole
  ---BEGIN bools_multi_uses1_logical
  all_goals (try extract_goal ; sorry)
  ---END bools_multi_uses1_logical



def bools_multi_uses2_before := [llvm|
{
^0(%arg39 : i1, %arg40 : i1, %arg41 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg41, %0 : i1
  %2 = llvm.and %1, %arg39 : i1
  %3 = llvm.and %arg41, %arg40 : i1
  %4 = llvm.or %2, %3 : i1
  %5 = llvm.add %2, %3 : i1
  %6 = llvm.and %4, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def bools_multi_uses2_after := [llvm|
{
^0(%arg39 : i1, %arg40 : i1, %arg41 : i1):
  %0 = "llvm.select"(%arg41, %arg40, %arg39) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem bools_multi_uses2_proof : bools_multi_uses2_before ⊑ bools_multi_uses2_after := by
  unfold bools_multi_uses2_before bools_multi_uses2_after
  simp_alive_peephole
  ---BEGIN bools_multi_uses2
  all_goals (try extract_goal ; sorry)
  ---END bools_multi_uses2



def bools_multi_uses2_logical_before := [llvm|
{
^0(%arg36 : i1, %arg37 : i1, %arg38 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.xor %arg38, %0 : i1
  %3 = "llvm.select"(%2, %arg36, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%arg38, %arg37, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %5 = "llvm.select"(%3, %0, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %6 = llvm.add %3, %4 : i1
  %7 = "llvm.select"(%5, %6, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def bools_multi_uses2_logical_after := [llvm|
{
^0(%arg36 : i1, %arg37 : i1, %arg38 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.xor %arg38, %0 : i1
  %3 = "llvm.select"(%2, %arg36, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%arg38, %arg37, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %5 = "llvm.select"(%arg38, %arg37, %arg36) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %6 = llvm.xor %3, %4 : i1
  %7 = "llvm.select"(%5, %6, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%7) : (i1) -> ()
}
]
theorem bools_multi_uses2_logical_proof : bools_multi_uses2_logical_before ⊑ bools_multi_uses2_logical_after := by
  unfold bools_multi_uses2_logical_before bools_multi_uses2_logical_after
  simp_alive_peephole
  ---BEGIN bools_multi_uses2_logical
  all_goals (try extract_goal ; sorry)
  ---END bools_multi_uses2_logical


