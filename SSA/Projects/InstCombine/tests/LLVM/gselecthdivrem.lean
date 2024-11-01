
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
section gselecthdivrem_statements

def udiv_common_divisor_before := [llvm|
{
^0(%arg65 : i1, %arg66 : i5, %arg67 : i5, %arg68 : i5):
  %0 = llvm.udiv %arg67, %arg66 : i5
  %1 = llvm.udiv %arg68, %arg66 : i5
  %2 = "llvm.select"(%arg65, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i5, i5) -> i5
  "llvm.return"(%2) : (i5) -> ()
}
]
def udiv_common_divisor_after := [llvm|
{
^0(%arg65 : i1, %arg66 : i5, %arg67 : i5, %arg68 : i5):
  %0 = "llvm.select"(%arg65, %arg68, %arg67) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i5, i5) -> i5
  %1 = llvm.udiv %0, %arg66 : i5
  "llvm.return"(%1) : (i5) -> ()
}
]
set_option debug.skipKernelTC true in
theorem udiv_common_divisor_proof : udiv_common_divisor_before ⊑ udiv_common_divisor_after := by
  unfold udiv_common_divisor_before udiv_common_divisor_after
  simp_alive_peephole
  ---BEGIN udiv_common_divisor
  all_goals (try extract_goal ; sorry)
  ---END udiv_common_divisor



def urem_common_divisor_before := [llvm|
{
^0(%arg61 : i1, %arg62 : i5, %arg63 : i5, %arg64 : i5):
  %0 = llvm.urem %arg63, %arg62 : i5
  %1 = llvm.urem %arg64, %arg62 : i5
  %2 = "llvm.select"(%arg61, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i5, i5) -> i5
  "llvm.return"(%2) : (i5) -> ()
}
]
def urem_common_divisor_after := [llvm|
{
^0(%arg61 : i1, %arg62 : i5, %arg63 : i5, %arg64 : i5):
  %0 = "llvm.select"(%arg61, %arg64, %arg63) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i5, i5) -> i5
  %1 = llvm.urem %0, %arg62 : i5
  "llvm.return"(%1) : (i5) -> ()
}
]
set_option debug.skipKernelTC true in
theorem urem_common_divisor_proof : urem_common_divisor_before ⊑ urem_common_divisor_after := by
  unfold urem_common_divisor_before urem_common_divisor_after
  simp_alive_peephole
  ---BEGIN urem_common_divisor
  all_goals (try extract_goal ; sorry)
  ---END urem_common_divisor



def sdiv_common_divisor_defined_cond_before := [llvm|
{
^0(%arg41 : i1, %arg42 : i5, %arg43 : i5, %arg44 : i5):
  %0 = llvm.sdiv %arg43, %arg42 : i5
  %1 = llvm.sdiv %arg44, %arg42 : i5
  %2 = "llvm.select"(%arg41, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i5, i5) -> i5
  "llvm.return"(%2) : (i5) -> ()
}
]
def sdiv_common_divisor_defined_cond_after := [llvm|
{
^0(%arg41 : i1, %arg42 : i5, %arg43 : i5, %arg44 : i5):
  %0 = "llvm.select"(%arg41, %arg44, %arg43) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i5, i5) -> i5
  %1 = llvm.sdiv %0, %arg42 : i5
  "llvm.return"(%1) : (i5) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sdiv_common_divisor_defined_cond_proof : sdiv_common_divisor_defined_cond_before ⊑ sdiv_common_divisor_defined_cond_after := by
  unfold sdiv_common_divisor_defined_cond_before sdiv_common_divisor_defined_cond_after
  simp_alive_peephole
  ---BEGIN sdiv_common_divisor_defined_cond
  all_goals (try extract_goal ; sorry)
  ---END sdiv_common_divisor_defined_cond



def srem_common_divisor_defined_cond_before := [llvm|
{
^0(%arg37 : i1, %arg38 : i5, %arg39 : i5, %arg40 : i5):
  %0 = llvm.srem %arg39, %arg38 : i5
  %1 = llvm.srem %arg40, %arg38 : i5
  %2 = "llvm.select"(%arg37, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i5, i5) -> i5
  "llvm.return"(%2) : (i5) -> ()
}
]
def srem_common_divisor_defined_cond_after := [llvm|
{
^0(%arg37 : i1, %arg38 : i5, %arg39 : i5, %arg40 : i5):
  %0 = "llvm.select"(%arg37, %arg40, %arg39) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i5, i5) -> i5
  %1 = llvm.srem %0, %arg38 : i5
  "llvm.return"(%1) : (i5) -> ()
}
]
set_option debug.skipKernelTC true in
theorem srem_common_divisor_defined_cond_proof : srem_common_divisor_defined_cond_before ⊑ srem_common_divisor_defined_cond_after := by
  unfold srem_common_divisor_defined_cond_before srem_common_divisor_defined_cond_after
  simp_alive_peephole
  ---BEGIN srem_common_divisor_defined_cond
  all_goals (try extract_goal ; sorry)
  ---END srem_common_divisor_defined_cond



def udiv_common_divisor_defined_cond_before := [llvm|
{
^0(%arg33 : i1, %arg34 : i5, %arg35 : i5, %arg36 : i5):
  %0 = llvm.udiv %arg35, %arg34 : i5
  %1 = llvm.udiv %arg36, %arg34 : i5
  %2 = "llvm.select"(%arg33, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i5, i5) -> i5
  "llvm.return"(%2) : (i5) -> ()
}
]
def udiv_common_divisor_defined_cond_after := [llvm|
{
^0(%arg33 : i1, %arg34 : i5, %arg35 : i5, %arg36 : i5):
  %0 = "llvm.select"(%arg33, %arg36, %arg35) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i5, i5) -> i5
  %1 = llvm.udiv %0, %arg34 : i5
  "llvm.return"(%1) : (i5) -> ()
}
]
set_option debug.skipKernelTC true in
theorem udiv_common_divisor_defined_cond_proof : udiv_common_divisor_defined_cond_before ⊑ udiv_common_divisor_defined_cond_after := by
  unfold udiv_common_divisor_defined_cond_before udiv_common_divisor_defined_cond_after
  simp_alive_peephole
  ---BEGIN udiv_common_divisor_defined_cond
  all_goals (try extract_goal ; sorry)
  ---END udiv_common_divisor_defined_cond



def urem_common_divisor_defined_cond_before := [llvm|
{
^0(%arg29 : i1, %arg30 : i5, %arg31 : i5, %arg32 : i5):
  %0 = llvm.urem %arg31, %arg30 : i5
  %1 = llvm.urem %arg32, %arg30 : i5
  %2 = "llvm.select"(%arg29, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i5, i5) -> i5
  "llvm.return"(%2) : (i5) -> ()
}
]
def urem_common_divisor_defined_cond_after := [llvm|
{
^0(%arg29 : i1, %arg30 : i5, %arg31 : i5, %arg32 : i5):
  %0 = "llvm.select"(%arg29, %arg32, %arg31) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i5, i5) -> i5
  %1 = llvm.urem %0, %arg30 : i5
  "llvm.return"(%1) : (i5) -> ()
}
]
set_option debug.skipKernelTC true in
theorem urem_common_divisor_defined_cond_proof : urem_common_divisor_defined_cond_before ⊑ urem_common_divisor_defined_cond_after := by
  unfold urem_common_divisor_defined_cond_before urem_common_divisor_defined_cond_after
  simp_alive_peephole
  ---BEGIN urem_common_divisor_defined_cond
  all_goals (try extract_goal ; sorry)
  ---END urem_common_divisor_defined_cond



def sdiv_common_dividend_defined_cond_before := [llvm|
{
^0(%arg25 : i1, %arg26 : i5, %arg27 : i5, %arg28 : i5):
  %0 = llvm.sdiv %arg26, %arg27 : i5
  %1 = llvm.sdiv %arg26, %arg28 : i5
  %2 = "llvm.select"(%arg25, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i5, i5) -> i5
  "llvm.return"(%2) : (i5) -> ()
}
]
def sdiv_common_dividend_defined_cond_after := [llvm|
{
^0(%arg25 : i1, %arg26 : i5, %arg27 : i5, %arg28 : i5):
  %0 = "llvm.select"(%arg25, %arg28, %arg27) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i5, i5) -> i5
  %1 = llvm.sdiv %arg26, %0 : i5
  "llvm.return"(%1) : (i5) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sdiv_common_dividend_defined_cond_proof : sdiv_common_dividend_defined_cond_before ⊑ sdiv_common_dividend_defined_cond_after := by
  unfold sdiv_common_dividend_defined_cond_before sdiv_common_dividend_defined_cond_after
  simp_alive_peephole
  ---BEGIN sdiv_common_dividend_defined_cond
  all_goals (try extract_goal ; sorry)
  ---END sdiv_common_dividend_defined_cond



def srem_common_dividend_defined_cond_before := [llvm|
{
^0(%arg21 : i1, %arg22 : i5, %arg23 : i5, %arg24 : i5):
  %0 = llvm.srem %arg22, %arg23 : i5
  %1 = llvm.srem %arg22, %arg24 : i5
  %2 = "llvm.select"(%arg21, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i5, i5) -> i5
  "llvm.return"(%2) : (i5) -> ()
}
]
def srem_common_dividend_defined_cond_after := [llvm|
{
^0(%arg21 : i1, %arg22 : i5, %arg23 : i5, %arg24 : i5):
  %0 = "llvm.select"(%arg21, %arg24, %arg23) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i5, i5) -> i5
  %1 = llvm.srem %arg22, %0 : i5
  "llvm.return"(%1) : (i5) -> ()
}
]
set_option debug.skipKernelTC true in
theorem srem_common_dividend_defined_cond_proof : srem_common_dividend_defined_cond_before ⊑ srem_common_dividend_defined_cond_after := by
  unfold srem_common_dividend_defined_cond_before srem_common_dividend_defined_cond_after
  simp_alive_peephole
  ---BEGIN srem_common_dividend_defined_cond
  all_goals (try extract_goal ; sorry)
  ---END srem_common_dividend_defined_cond



def udiv_common_dividend_defined_cond_before := [llvm|
{
^0(%arg17 : i1, %arg18 : i5, %arg19 : i5, %arg20 : i5):
  %0 = llvm.udiv %arg18, %arg19 : i5
  %1 = llvm.udiv %arg18, %arg20 : i5
  %2 = "llvm.select"(%arg17, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i5, i5) -> i5
  "llvm.return"(%2) : (i5) -> ()
}
]
def udiv_common_dividend_defined_cond_after := [llvm|
{
^0(%arg17 : i1, %arg18 : i5, %arg19 : i5, %arg20 : i5):
  %0 = "llvm.select"(%arg17, %arg20, %arg19) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i5, i5) -> i5
  %1 = llvm.udiv %arg18, %0 : i5
  "llvm.return"(%1) : (i5) -> ()
}
]
set_option debug.skipKernelTC true in
theorem udiv_common_dividend_defined_cond_proof : udiv_common_dividend_defined_cond_before ⊑ udiv_common_dividend_defined_cond_after := by
  unfold udiv_common_dividend_defined_cond_before udiv_common_dividend_defined_cond_after
  simp_alive_peephole
  ---BEGIN udiv_common_dividend_defined_cond
  all_goals (try extract_goal ; sorry)
  ---END udiv_common_dividend_defined_cond



def urem_common_dividend_defined_cond_before := [llvm|
{
^0(%arg13 : i1, %arg14 : i5, %arg15 : i5, %arg16 : i5):
  %0 = llvm.urem %arg14, %arg15 : i5
  %1 = llvm.urem %arg14, %arg16 : i5
  %2 = "llvm.select"(%arg13, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i5, i5) -> i5
  "llvm.return"(%2) : (i5) -> ()
}
]
def urem_common_dividend_defined_cond_after := [llvm|
{
^0(%arg13 : i1, %arg14 : i5, %arg15 : i5, %arg16 : i5):
  %0 = "llvm.select"(%arg13, %arg16, %arg15) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i5, i5) -> i5
  %1 = llvm.urem %arg14, %0 : i5
  "llvm.return"(%1) : (i5) -> ()
}
]
set_option debug.skipKernelTC true in
theorem urem_common_dividend_defined_cond_proof : urem_common_dividend_defined_cond_before ⊑ urem_common_dividend_defined_cond_after := by
  unfold urem_common_dividend_defined_cond_before urem_common_dividend_defined_cond_after
  simp_alive_peephole
  ---BEGIN urem_common_dividend_defined_cond
  all_goals (try extract_goal ; sorry)
  ---END urem_common_dividend_defined_cond


