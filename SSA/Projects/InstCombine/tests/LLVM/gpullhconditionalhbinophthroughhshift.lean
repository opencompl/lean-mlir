
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
section gpullhconditionalhbinophthroughhshift_statements

def and_signbit_select_shl_before := [llvm|
{
^0(%arg46 : i32, %arg47 : i1):
  %0 = llvm.mlir.constant(-65536 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.and %arg46, %0 : i32
  %3 = "llvm.select"(%arg47, %2, %arg46) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.shl %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def and_signbit_select_shl_after := [llvm|
{
^0(%arg46 : i32, %arg47 : i1):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(-16777216 : i32) : i32
  %2 = llvm.shl %arg46, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = "llvm.select"(%arg47, %3, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_signbit_select_shl_proof : and_signbit_select_shl_before ⊑ and_signbit_select_shl_after := by
  unfold and_signbit_select_shl_before and_signbit_select_shl_after
  simp_alive_peephole
  intros
  ---BEGIN and_signbit_select_shl
  all_goals (try extract_goal ; sorry)
  ---END and_signbit_select_shl



def and_nosignbit_select_shl_before := [llvm|
{
^0(%arg44 : i32, %arg45 : i1):
  %0 = llvm.mlir.constant(2147418112 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.and %arg44, %0 : i32
  %3 = "llvm.select"(%arg45, %2, %arg44) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.shl %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def and_nosignbit_select_shl_after := [llvm|
{
^0(%arg44 : i32, %arg45 : i1):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(-16777216 : i32) : i32
  %2 = llvm.shl %arg44, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = "llvm.select"(%arg45, %3, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_nosignbit_select_shl_proof : and_nosignbit_select_shl_before ⊑ and_nosignbit_select_shl_after := by
  unfold and_nosignbit_select_shl_before and_nosignbit_select_shl_after
  simp_alive_peephole
  intros
  ---BEGIN and_nosignbit_select_shl
  all_goals (try extract_goal ; sorry)
  ---END and_nosignbit_select_shl



def or_signbit_select_shl_before := [llvm|
{
^0(%arg42 : i32, %arg43 : i1):
  %0 = llvm.mlir.constant(-65536 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.or %arg42, %0 : i32
  %3 = "llvm.select"(%arg43, %2, %arg42) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.shl %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def or_signbit_select_shl_after := [llvm|
{
^0(%arg42 : i32, %arg43 : i1):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(-16777216 : i32) : i32
  %2 = llvm.shl %arg42, %0 : i32
  %3 = llvm.or %2, %1 : i32
  %4 = "llvm.select"(%arg43, %3, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_signbit_select_shl_proof : or_signbit_select_shl_before ⊑ or_signbit_select_shl_after := by
  unfold or_signbit_select_shl_before or_signbit_select_shl_after
  simp_alive_peephole
  intros
  ---BEGIN or_signbit_select_shl
  all_goals (try extract_goal ; sorry)
  ---END or_signbit_select_shl



def or_nosignbit_select_shl_before := [llvm|
{
^0(%arg40 : i32, %arg41 : i1):
  %0 = llvm.mlir.constant(2147418112 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.or %arg40, %0 : i32
  %3 = "llvm.select"(%arg41, %2, %arg40) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.shl %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def or_nosignbit_select_shl_after := [llvm|
{
^0(%arg40 : i32, %arg41 : i1):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(-16777216 : i32) : i32
  %2 = llvm.shl %arg40, %0 : i32
  %3 = llvm.or %2, %1 : i32
  %4 = "llvm.select"(%arg41, %3, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_nosignbit_select_shl_proof : or_nosignbit_select_shl_before ⊑ or_nosignbit_select_shl_after := by
  unfold or_nosignbit_select_shl_before or_nosignbit_select_shl_after
  simp_alive_peephole
  intros
  ---BEGIN or_nosignbit_select_shl
  all_goals (try extract_goal ; sorry)
  ---END or_nosignbit_select_shl



def xor_signbit_select_shl_before := [llvm|
{
^0(%arg38 : i32, %arg39 : i1):
  %0 = llvm.mlir.constant(-65536 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.xor %arg38, %0 : i32
  %3 = "llvm.select"(%arg39, %2, %arg38) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.shl %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def xor_signbit_select_shl_after := [llvm|
{
^0(%arg38 : i32, %arg39 : i1):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(-16777216 : i32) : i32
  %2 = llvm.shl %arg38, %0 : i32
  %3 = llvm.xor %2, %1 : i32
  %4 = "llvm.select"(%arg39, %3, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_signbit_select_shl_proof : xor_signbit_select_shl_before ⊑ xor_signbit_select_shl_after := by
  unfold xor_signbit_select_shl_before xor_signbit_select_shl_after
  simp_alive_peephole
  intros
  ---BEGIN xor_signbit_select_shl
  all_goals (try extract_goal ; sorry)
  ---END xor_signbit_select_shl



def xor_nosignbit_select_shl_before := [llvm|
{
^0(%arg36 : i32, %arg37 : i1):
  %0 = llvm.mlir.constant(2147418112 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.xor %arg36, %0 : i32
  %3 = "llvm.select"(%arg37, %2, %arg36) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.shl %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def xor_nosignbit_select_shl_after := [llvm|
{
^0(%arg36 : i32, %arg37 : i1):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(-16777216 : i32) : i32
  %2 = llvm.shl %arg36, %0 : i32
  %3 = llvm.xor %2, %1 : i32
  %4 = "llvm.select"(%arg37, %3, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_nosignbit_select_shl_proof : xor_nosignbit_select_shl_before ⊑ xor_nosignbit_select_shl_after := by
  unfold xor_nosignbit_select_shl_before xor_nosignbit_select_shl_after
  simp_alive_peephole
  intros
  ---BEGIN xor_nosignbit_select_shl
  all_goals (try extract_goal ; sorry)
  ---END xor_nosignbit_select_shl



def add_signbit_select_shl_before := [llvm|
{
^0(%arg34 : i32, %arg35 : i1):
  %0 = llvm.mlir.constant(-65536 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.add %arg34, %0 : i32
  %3 = "llvm.select"(%arg35, %2, %arg34) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.shl %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def add_signbit_select_shl_after := [llvm|
{
^0(%arg34 : i32, %arg35 : i1):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(-16777216 : i32) : i32
  %2 = llvm.shl %arg34, %0 : i32
  %3 = llvm.add %2, %1 : i32
  %4 = "llvm.select"(%arg35, %3, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_signbit_select_shl_proof : add_signbit_select_shl_before ⊑ add_signbit_select_shl_after := by
  unfold add_signbit_select_shl_before add_signbit_select_shl_after
  simp_alive_peephole
  intros
  ---BEGIN add_signbit_select_shl
  all_goals (try extract_goal ; sorry)
  ---END add_signbit_select_shl



def add_nosignbit_select_shl_before := [llvm|
{
^0(%arg32 : i32, %arg33 : i1):
  %0 = llvm.mlir.constant(2147418112 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.add %arg32, %0 : i32
  %3 = "llvm.select"(%arg33, %2, %arg32) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.shl %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def add_nosignbit_select_shl_after := [llvm|
{
^0(%arg32 : i32, %arg33 : i1):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(-16777216 : i32) : i32
  %2 = llvm.shl %arg32, %0 : i32
  %3 = llvm.add %2, %1 : i32
  %4 = "llvm.select"(%arg33, %3, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_nosignbit_select_shl_proof : add_nosignbit_select_shl_before ⊑ add_nosignbit_select_shl_after := by
  unfold add_nosignbit_select_shl_before add_nosignbit_select_shl_after
  simp_alive_peephole
  intros
  ---BEGIN add_nosignbit_select_shl
  all_goals (try extract_goal ; sorry)
  ---END add_nosignbit_select_shl



def and_signbit_select_lshr_before := [llvm|
{
^0(%arg30 : i32, %arg31 : i1):
  %0 = llvm.mlir.constant(-65536 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.and %arg30, %0 : i32
  %3 = "llvm.select"(%arg31, %2, %arg30) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.lshr %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def and_signbit_select_lshr_after := [llvm|
{
^0(%arg30 : i32, %arg31 : i1):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(16776960 : i32) : i32
  %2 = llvm.lshr %arg30, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = "llvm.select"(%arg31, %3, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_signbit_select_lshr_proof : and_signbit_select_lshr_before ⊑ and_signbit_select_lshr_after := by
  unfold and_signbit_select_lshr_before and_signbit_select_lshr_after
  simp_alive_peephole
  intros
  ---BEGIN and_signbit_select_lshr
  all_goals (try extract_goal ; sorry)
  ---END and_signbit_select_lshr



def and_nosignbit_select_lshr_before := [llvm|
{
^0(%arg28 : i32, %arg29 : i1):
  %0 = llvm.mlir.constant(2147418112 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.and %arg28, %0 : i32
  %3 = "llvm.select"(%arg29, %2, %arg28) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.lshr %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def and_nosignbit_select_lshr_after := [llvm|
{
^0(%arg28 : i32, %arg29 : i1):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(8388352 : i32) : i32
  %2 = llvm.lshr %arg28, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = "llvm.select"(%arg29, %3, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_nosignbit_select_lshr_proof : and_nosignbit_select_lshr_before ⊑ and_nosignbit_select_lshr_after := by
  unfold and_nosignbit_select_lshr_before and_nosignbit_select_lshr_after
  simp_alive_peephole
  intros
  ---BEGIN and_nosignbit_select_lshr
  all_goals (try extract_goal ; sorry)
  ---END and_nosignbit_select_lshr



def or_signbit_select_lshr_before := [llvm|
{
^0(%arg26 : i32, %arg27 : i1):
  %0 = llvm.mlir.constant(-65536 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.or %arg26, %0 : i32
  %3 = "llvm.select"(%arg27, %2, %arg26) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.lshr %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def or_signbit_select_lshr_after := [llvm|
{
^0(%arg26 : i32, %arg27 : i1):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(16776960 : i32) : i32
  %2 = llvm.lshr %arg26, %0 : i32
  %3 = llvm.or %2, %1 : i32
  %4 = "llvm.select"(%arg27, %3, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_signbit_select_lshr_proof : or_signbit_select_lshr_before ⊑ or_signbit_select_lshr_after := by
  unfold or_signbit_select_lshr_before or_signbit_select_lshr_after
  simp_alive_peephole
  intros
  ---BEGIN or_signbit_select_lshr
  all_goals (try extract_goal ; sorry)
  ---END or_signbit_select_lshr



def or_nosignbit_select_lshr_before := [llvm|
{
^0(%arg24 : i32, %arg25 : i1):
  %0 = llvm.mlir.constant(2147418112 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.or %arg24, %0 : i32
  %3 = "llvm.select"(%arg25, %2, %arg24) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.lshr %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def or_nosignbit_select_lshr_after := [llvm|
{
^0(%arg24 : i32, %arg25 : i1):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(8388352 : i32) : i32
  %2 = llvm.lshr %arg24, %0 : i32
  %3 = llvm.or %2, %1 : i32
  %4 = "llvm.select"(%arg25, %3, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_nosignbit_select_lshr_proof : or_nosignbit_select_lshr_before ⊑ or_nosignbit_select_lshr_after := by
  unfold or_nosignbit_select_lshr_before or_nosignbit_select_lshr_after
  simp_alive_peephole
  intros
  ---BEGIN or_nosignbit_select_lshr
  all_goals (try extract_goal ; sorry)
  ---END or_nosignbit_select_lshr



def xor_signbit_select_lshr_before := [llvm|
{
^0(%arg22 : i32, %arg23 : i1):
  %0 = llvm.mlir.constant(-65536 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.xor %arg22, %0 : i32
  %3 = "llvm.select"(%arg23, %2, %arg22) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.lshr %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def xor_signbit_select_lshr_after := [llvm|
{
^0(%arg22 : i32, %arg23 : i1):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(16776960 : i32) : i32
  %2 = llvm.lshr %arg22, %0 : i32
  %3 = llvm.xor %2, %1 : i32
  %4 = "llvm.select"(%arg23, %3, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_signbit_select_lshr_proof : xor_signbit_select_lshr_before ⊑ xor_signbit_select_lshr_after := by
  unfold xor_signbit_select_lshr_before xor_signbit_select_lshr_after
  simp_alive_peephole
  intros
  ---BEGIN xor_signbit_select_lshr
  all_goals (try extract_goal ; sorry)
  ---END xor_signbit_select_lshr



def xor_nosignbit_select_lshr_before := [llvm|
{
^0(%arg20 : i32, %arg21 : i1):
  %0 = llvm.mlir.constant(2147418112 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.xor %arg20, %0 : i32
  %3 = "llvm.select"(%arg21, %2, %arg20) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.lshr %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def xor_nosignbit_select_lshr_after := [llvm|
{
^0(%arg20 : i32, %arg21 : i1):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(8388352 : i32) : i32
  %2 = llvm.lshr %arg20, %0 : i32
  %3 = llvm.xor %2, %1 : i32
  %4 = "llvm.select"(%arg21, %3, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_nosignbit_select_lshr_proof : xor_nosignbit_select_lshr_before ⊑ xor_nosignbit_select_lshr_after := by
  unfold xor_nosignbit_select_lshr_before xor_nosignbit_select_lshr_after
  simp_alive_peephole
  intros
  ---BEGIN xor_nosignbit_select_lshr
  all_goals (try extract_goal ; sorry)
  ---END xor_nosignbit_select_lshr



def and_signbit_select_ashr_before := [llvm|
{
^0(%arg14 : i32, %arg15 : i1):
  %0 = llvm.mlir.constant(-65536 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.and %arg14, %0 : i32
  %3 = "llvm.select"(%arg15, %2, %arg14) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.ashr %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def and_signbit_select_ashr_after := [llvm|
{
^0(%arg14 : i32, %arg15 : i1):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(-256 : i32) : i32
  %2 = llvm.ashr %arg14, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = "llvm.select"(%arg15, %3, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_signbit_select_ashr_proof : and_signbit_select_ashr_before ⊑ and_signbit_select_ashr_after := by
  unfold and_signbit_select_ashr_before and_signbit_select_ashr_after
  simp_alive_peephole
  intros
  ---BEGIN and_signbit_select_ashr
  all_goals (try extract_goal ; sorry)
  ---END and_signbit_select_ashr



def and_nosignbit_select_ashr_before := [llvm|
{
^0(%arg12 : i32, %arg13 : i1):
  %0 = llvm.mlir.constant(2147418112 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.and %arg12, %0 : i32
  %3 = "llvm.select"(%arg13, %2, %arg12) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.ashr %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def and_nosignbit_select_ashr_after := [llvm|
{
^0(%arg12 : i32, %arg13 : i1):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(8388352 : i32) : i32
  %2 = llvm.ashr %arg12, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = "llvm.select"(%arg13, %3, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_nosignbit_select_ashr_proof : and_nosignbit_select_ashr_before ⊑ and_nosignbit_select_ashr_after := by
  unfold and_nosignbit_select_ashr_before and_nosignbit_select_ashr_after
  simp_alive_peephole
  intros
  ---BEGIN and_nosignbit_select_ashr
  all_goals (try extract_goal ; sorry)
  ---END and_nosignbit_select_ashr



def or_signbit_select_ashr_before := [llvm|
{
^0(%arg10 : i32, %arg11 : i1):
  %0 = llvm.mlir.constant(-65536 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.or %arg10, %0 : i32
  %3 = "llvm.select"(%arg11, %2, %arg10) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.ashr %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def or_signbit_select_ashr_after := [llvm|
{
^0(%arg10 : i32, %arg11 : i1):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(-256 : i32) : i32
  %2 = llvm.ashr %arg10, %0 : i32
  %3 = llvm.or %2, %1 : i32
  %4 = "llvm.select"(%arg11, %3, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_signbit_select_ashr_proof : or_signbit_select_ashr_before ⊑ or_signbit_select_ashr_after := by
  unfold or_signbit_select_ashr_before or_signbit_select_ashr_after
  simp_alive_peephole
  intros
  ---BEGIN or_signbit_select_ashr
  all_goals (try extract_goal ; sorry)
  ---END or_signbit_select_ashr



def or_nosignbit_select_ashr_before := [llvm|
{
^0(%arg8 : i32, %arg9 : i1):
  %0 = llvm.mlir.constant(2147418112 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.or %arg8, %0 : i32
  %3 = "llvm.select"(%arg9, %2, %arg8) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.ashr %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def or_nosignbit_select_ashr_after := [llvm|
{
^0(%arg8 : i32, %arg9 : i1):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(8388352 : i32) : i32
  %2 = llvm.ashr %arg8, %0 : i32
  %3 = llvm.or %2, %1 : i32
  %4 = "llvm.select"(%arg9, %3, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_nosignbit_select_ashr_proof : or_nosignbit_select_ashr_before ⊑ or_nosignbit_select_ashr_after := by
  unfold or_nosignbit_select_ashr_before or_nosignbit_select_ashr_after
  simp_alive_peephole
  intros
  ---BEGIN or_nosignbit_select_ashr
  all_goals (try extract_goal ; sorry)
  ---END or_nosignbit_select_ashr



def xor_signbit_select_ashr_before := [llvm|
{
^0(%arg6 : i32, %arg7 : i1):
  %0 = llvm.mlir.constant(-65536 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.xor %arg6, %0 : i32
  %3 = "llvm.select"(%arg7, %2, %arg6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.ashr %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def xor_signbit_select_ashr_after := [llvm|
{
^0(%arg6 : i32, %arg7 : i1):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(-256 : i32) : i32
  %2 = llvm.ashr %arg6, %0 : i32
  %3 = llvm.xor %2, %1 : i32
  %4 = "llvm.select"(%arg7, %3, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_signbit_select_ashr_proof : xor_signbit_select_ashr_before ⊑ xor_signbit_select_ashr_after := by
  unfold xor_signbit_select_ashr_before xor_signbit_select_ashr_after
  simp_alive_peephole
  intros
  ---BEGIN xor_signbit_select_ashr
  all_goals (try extract_goal ; sorry)
  ---END xor_signbit_select_ashr



def xor_nosignbit_select_ashr_before := [llvm|
{
^0(%arg4 : i32, %arg5 : i1):
  %0 = llvm.mlir.constant(2147418112 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.xor %arg4, %0 : i32
  %3 = "llvm.select"(%arg5, %2, %arg4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.ashr %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def xor_nosignbit_select_ashr_after := [llvm|
{
^0(%arg4 : i32, %arg5 : i1):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(8388352 : i32) : i32
  %2 = llvm.ashr %arg4, %0 : i32
  %3 = llvm.xor %2, %1 : i32
  %4 = "llvm.select"(%arg5, %3, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_nosignbit_select_ashr_proof : xor_nosignbit_select_ashr_before ⊑ xor_nosignbit_select_ashr_after := by
  unfold xor_nosignbit_select_ashr_before xor_nosignbit_select_ashr_after
  simp_alive_peephole
  intros
  ---BEGIN xor_nosignbit_select_ashr
  all_goals (try extract_goal ; sorry)
  ---END xor_nosignbit_select_ashr


