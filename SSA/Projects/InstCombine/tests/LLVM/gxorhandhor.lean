
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
section gxorhandhor_statements

def xor_logic_and_logic_or1_before := [llvm|
{
^0(%arg54 : i1, %arg55 : i1, %arg56 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = "llvm.select"(%arg54, %0, %arg56) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%arg54, %arg55, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = llvm.xor %3, %2 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def xor_logic_and_logic_or1_after := [llvm|
{
^0(%arg54 : i1, %arg55 : i1, %arg56 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg55, %0 : i1
  %2 = "llvm.select"(%arg54, %1, %arg56) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_logic_and_logic_or1_proof : xor_logic_and_logic_or1_before ⊑ xor_logic_and_logic_or1_after := by
  unfold xor_logic_and_logic_or1_before xor_logic_and_logic_or1_after
  simp_alive_peephole
  intros
  ---BEGIN xor_logic_and_logic_or1
  all_goals (try extract_goal ; sorry)
  ---END xor_logic_and_logic_or1



def xor_logic_and_logic_or2_before := [llvm|
{
^0(%arg51 : i1, %arg52 : i1, %arg53 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = "llvm.select"(%arg53, %0, %arg51) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%arg51, %arg52, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = llvm.xor %3, %2 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def xor_logic_and_logic_or2_after := [llvm|
{
^0(%arg51 : i1, %arg52 : i1, %arg53 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg52, %0 : i1
  %2 = "llvm.select"(%arg51, %1, %arg53) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_logic_and_logic_or2_proof : xor_logic_and_logic_or2_before ⊑ xor_logic_and_logic_or2_after := by
  unfold xor_logic_and_logic_or2_before xor_logic_and_logic_or2_after
  simp_alive_peephole
  intros
  ---BEGIN xor_logic_and_logic_or2
  all_goals (try extract_goal ; sorry)
  ---END xor_logic_and_logic_or2



def xor_logic_and_logic_or4_before := [llvm|
{
^0(%arg45 : i1, %arg46 : i1, %arg47 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = "llvm.select"(%arg45, %0, %arg47) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%arg46, %arg45, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = llvm.xor %3, %2 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def xor_logic_and_logic_or4_after := [llvm|
{
^0(%arg45 : i1, %arg46 : i1, %arg47 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg46, %0 : i1
  %2 = "llvm.select"(%arg45, %1, %arg47) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_logic_and_logic_or4_proof : xor_logic_and_logic_or4_before ⊑ xor_logic_and_logic_or4_after := by
  unfold xor_logic_and_logic_or4_before xor_logic_and_logic_or4_after
  simp_alive_peephole
  intros
  ---BEGIN xor_logic_and_logic_or4
  all_goals (try extract_goal ; sorry)
  ---END xor_logic_and_logic_or4



def xor_and_logic_or1_before := [llvm|
{
^0(%arg30 : i1, %arg31 : i1, %arg32 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = "llvm.select"(%arg30, %0, %arg32) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %2 = llvm.and %arg30, %arg31 : i1
  %3 = llvm.xor %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def xor_and_logic_or1_after := [llvm|
{
^0(%arg30 : i1, %arg31 : i1, %arg32 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg31, %0 : i1
  %2 = "llvm.select"(%arg30, %1, %arg32) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_and_logic_or1_proof : xor_and_logic_or1_before ⊑ xor_and_logic_or1_after := by
  unfold xor_and_logic_or1_before xor_and_logic_or1_after
  simp_alive_peephole
  intros
  ---BEGIN xor_and_logic_or1
  all_goals (try extract_goal ; sorry)
  ---END xor_and_logic_or1



def xor_and_logic_or2_before := [llvm|
{
^0(%arg27 : i1, %arg28 : i1, %arg29 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = "llvm.select"(%arg29, %0, %arg27) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %2 = llvm.and %arg28, %arg27 : i1
  %3 = llvm.xor %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def xor_and_logic_or2_after := [llvm|
{
^0(%arg27 : i1, %arg28 : i1, %arg29 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg28, %0 : i1
  %2 = "llvm.select"(%arg27, %1, %arg29) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_and_logic_or2_proof : xor_and_logic_or2_before ⊑ xor_and_logic_or2_after := by
  unfold xor_and_logic_or2_before xor_and_logic_or2_after
  simp_alive_peephole
  intros
  ---BEGIN xor_and_logic_or2
  all_goals (try extract_goal ; sorry)
  ---END xor_and_logic_or2



def xor_logic_and_or1_before := [llvm|
{
^0(%arg18 : i1, %arg19 : i1, %arg20 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.or %arg20, %arg18 : i1
  %2 = "llvm.select"(%arg18, %arg19, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = llvm.xor %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def xor_logic_and_or1_after := [llvm|
{
^0(%arg18 : i1, %arg19 : i1, %arg20 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg19, %0 : i1
  %2 = "llvm.select"(%arg18, %1, %arg20) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_logic_and_or1_proof : xor_logic_and_or1_before ⊑ xor_logic_and_or1_after := by
  unfold xor_logic_and_or1_before xor_logic_and_or1_after
  simp_alive_peephole
  intros
  ---BEGIN xor_logic_and_or1
  all_goals (try extract_goal ; sorry)
  ---END xor_logic_and_or1



def xor_logic_and_or2_before := [llvm|
{
^0(%arg15 : i1, %arg16 : i1, %arg17 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.or %arg15, %arg17 : i1
  %2 = "llvm.select"(%arg16, %arg15, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = llvm.xor %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def xor_logic_and_or2_after := [llvm|
{
^0(%arg15 : i1, %arg16 : i1, %arg17 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg16, %0 : i1
  %2 = "llvm.select"(%arg15, %1, %arg17) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_logic_and_or2_proof : xor_logic_and_or2_before ⊑ xor_logic_and_or2_after := by
  unfold xor_logic_and_or2_before xor_logic_and_or2_after
  simp_alive_peephole
  intros
  ---BEGIN xor_logic_and_or2
  all_goals (try extract_goal ; sorry)
  ---END xor_logic_and_or2



def xor_and_or_before := [llvm|
{
^0(%arg6 : i1, %arg7 : i1, %arg8 : i1):
  %0 = llvm.or %arg8, %arg6 : i1
  %1 = llvm.and %arg6, %arg7 : i1
  %2 = llvm.xor %1, %0 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def xor_and_or_after := [llvm|
{
^0(%arg6 : i1, %arg7 : i1, %arg8 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg7, %0 : i1
  %2 = "llvm.select"(%arg6, %1, %arg8) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_and_or_proof : xor_and_or_before ⊑ xor_and_or_after := by
  unfold xor_and_or_before xor_and_or_after
  simp_alive_peephole
  intros
  ---BEGIN xor_and_or
  all_goals (try extract_goal ; sorry)
  ---END xor_and_or


