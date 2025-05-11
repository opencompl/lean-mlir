
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
section gunfoldhmaskedhmergehwithhconsthmaskhscalar_statements

def scalar0_before := [llvm|
{
^0(%arg32 : i4, %arg33 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.xor %arg32, %arg33 : i4
  %2 = llvm.and %1, %0 : i4
  %3 = llvm.xor %2, %arg33 : i4
  "llvm.return"(%3) : (i4) -> ()
}
]
def scalar0_after := [llvm|
{
^0(%arg32 : i4, %arg33 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-2 : i4) : i4
  %2 = llvm.and %arg32, %0 : i4
  %3 = llvm.and %arg33, %1 : i4
  %4 = llvm.or disjoint %2, %3 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
set_option debug.skipKernelTC true in
theorem scalar0_proof : scalar0_before ⊑ scalar0_after := by
  unfold scalar0_before scalar0_after
  simp_alive_peephole
  intros
  ---BEGIN scalar0
  all_goals (try extract_goal ; sorry)
  ---END scalar0



def scalar1_before := [llvm|
{
^0(%arg30 : i4, %arg31 : i4):
  %0 = llvm.mlir.constant(-2 : i4) : i4
  %1 = llvm.xor %arg30, %arg31 : i4
  %2 = llvm.and %1, %0 : i4
  %3 = llvm.xor %2, %arg31 : i4
  "llvm.return"(%3) : (i4) -> ()
}
]
def scalar1_after := [llvm|
{
^0(%arg30 : i4, %arg31 : i4):
  %0 = llvm.mlir.constant(-2 : i4) : i4
  %1 = llvm.mlir.constant(1 : i4) : i4
  %2 = llvm.and %arg30, %0 : i4
  %3 = llvm.and %arg31, %1 : i4
  %4 = llvm.or disjoint %2, %3 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
set_option debug.skipKernelTC true in
theorem scalar1_proof : scalar1_before ⊑ scalar1_after := by
  unfold scalar1_before scalar1_after
  simp_alive_peephole
  intros
  ---BEGIN scalar1
  all_goals (try extract_goal ; sorry)
  ---END scalar1



def in_constant_varx_mone_before := [llvm|
{
^0(%arg28 : i4, %arg29 : i4):
  %0 = llvm.mlir.constant(-1 : i4) : i4
  %1 = llvm.mlir.constant(1 : i4) : i4
  %2 = llvm.xor %arg28, %0 : i4
  %3 = llvm.and %2, %1 : i4
  %4 = llvm.xor %3, %0 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def in_constant_varx_mone_after := [llvm|
{
^0(%arg28 : i4, %arg29 : i4):
  %0 = llvm.mlir.constant(-2 : i4) : i4
  %1 = llvm.or %arg28, %0 : i4
  "llvm.return"(%1) : (i4) -> ()
}
]
set_option debug.skipKernelTC true in
theorem in_constant_varx_mone_proof : in_constant_varx_mone_before ⊑ in_constant_varx_mone_after := by
  unfold in_constant_varx_mone_before in_constant_varx_mone_after
  simp_alive_peephole
  intros
  ---BEGIN in_constant_varx_mone
  all_goals (try extract_goal ; sorry)
  ---END in_constant_varx_mone



def in_constant_varx_14_before := [llvm|
{
^0(%arg26 : i4, %arg27 : i4):
  %0 = llvm.mlir.constant(-2 : i4) : i4
  %1 = llvm.mlir.constant(1 : i4) : i4
  %2 = llvm.xor %arg26, %0 : i4
  %3 = llvm.and %2, %1 : i4
  %4 = llvm.xor %3, %0 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def in_constant_varx_14_after := [llvm|
{
^0(%arg26 : i4, %arg27 : i4):
  %0 = llvm.mlir.constant(-2 : i4) : i4
  %1 = llvm.or %arg26, %0 : i4
  "llvm.return"(%1) : (i4) -> ()
}
]
set_option debug.skipKernelTC true in
theorem in_constant_varx_14_proof : in_constant_varx_14_before ⊑ in_constant_varx_14_after := by
  unfold in_constant_varx_14_before in_constant_varx_14_after
  simp_alive_peephole
  intros
  ---BEGIN in_constant_varx_14
  all_goals (try extract_goal ; sorry)
  ---END in_constant_varx_14



def in_constant_mone_vary_before := [llvm|
{
^0(%arg24 : i4, %arg25 : i4):
  %0 = llvm.mlir.constant(-1 : i4) : i4
  %1 = llvm.mlir.constant(1 : i4) : i4
  %2 = llvm.xor %arg24, %0 : i4
  %3 = llvm.and %2, %1 : i4
  %4 = llvm.xor %3, %arg24 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def in_constant_mone_vary_after := [llvm|
{
^0(%arg24 : i4, %arg25 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.or %arg24, %0 : i4
  "llvm.return"(%1) : (i4) -> ()
}
]
set_option debug.skipKernelTC true in
theorem in_constant_mone_vary_proof : in_constant_mone_vary_before ⊑ in_constant_mone_vary_after := by
  unfold in_constant_mone_vary_before in_constant_mone_vary_after
  simp_alive_peephole
  intros
  ---BEGIN in_constant_mone_vary
  all_goals (try extract_goal ; sorry)
  ---END in_constant_mone_vary



def in_constant_14_vary_before := [llvm|
{
^0(%arg22 : i4, %arg23 : i4):
  %0 = llvm.mlir.constant(-2 : i4) : i4
  %1 = llvm.mlir.constant(1 : i4) : i4
  %2 = llvm.xor %arg22, %0 : i4
  %3 = llvm.and %2, %1 : i4
  %4 = llvm.xor %3, %arg22 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def in_constant_14_vary_after := [llvm|
{
^0(%arg22 : i4, %arg23 : i4):
  %0 = llvm.mlir.constant(-2 : i4) : i4
  %1 = llvm.and %arg22, %0 : i4
  "llvm.return"(%1) : (i4) -> ()
}
]
set_option debug.skipKernelTC true in
theorem in_constant_14_vary_proof : in_constant_14_vary_before ⊑ in_constant_14_vary_after := by
  unfold in_constant_14_vary_before in_constant_14_vary_after
  simp_alive_peephole
  intros
  ---BEGIN in_constant_14_vary
  all_goals (try extract_goal ; sorry)
  ---END in_constant_14_vary



def c_1_0_0_before := [llvm|
{
^0(%arg20 : i4, %arg21 : i4):
  %0 = llvm.mlir.constant(-2 : i4) : i4
  %1 = llvm.xor %arg21, %arg20 : i4
  %2 = llvm.and %1, %0 : i4
  %3 = llvm.xor %2, %arg21 : i4
  "llvm.return"(%3) : (i4) -> ()
}
]
def c_1_0_0_after := [llvm|
{
^0(%arg20 : i4, %arg21 : i4):
  %0 = llvm.mlir.constant(-2 : i4) : i4
  %1 = llvm.mlir.constant(1 : i4) : i4
  %2 = llvm.and %arg20, %0 : i4
  %3 = llvm.and %arg21, %1 : i4
  %4 = llvm.or disjoint %2, %3 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
set_option debug.skipKernelTC true in
theorem c_1_0_0_proof : c_1_0_0_before ⊑ c_1_0_0_after := by
  unfold c_1_0_0_before c_1_0_0_after
  simp_alive_peephole
  intros
  ---BEGIN c_1_0_0
  all_goals (try extract_goal ; sorry)
  ---END c_1_0_0



def c_0_1_0_before := [llvm|
{
^0(%arg18 : i4, %arg19 : i4):
  %0 = llvm.mlir.constant(-2 : i4) : i4
  %1 = llvm.xor %arg18, %arg19 : i4
  %2 = llvm.and %1, %0 : i4
  %3 = llvm.xor %2, %arg18 : i4
  "llvm.return"(%3) : (i4) -> ()
}
]
def c_0_1_0_after := [llvm|
{
^0(%arg18 : i4, %arg19 : i4):
  %0 = llvm.mlir.constant(-2 : i4) : i4
  %1 = llvm.mlir.constant(1 : i4) : i4
  %2 = llvm.and %arg19, %0 : i4
  %3 = llvm.and %arg18, %1 : i4
  %4 = llvm.or disjoint %2, %3 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
set_option debug.skipKernelTC true in
theorem c_0_1_0_proof : c_0_1_0_before ⊑ c_0_1_0_after := by
  unfold c_0_1_0_before c_0_1_0_after
  simp_alive_peephole
  intros
  ---BEGIN c_0_1_0
  all_goals (try extract_goal ; sorry)
  ---END c_0_1_0



def c_1_1_0_before := [llvm|
{
^0(%arg16 : i4, %arg17 : i4):
  %0 = llvm.mlir.constant(-2 : i4) : i4
  %1 = llvm.xor %arg17, %arg16 : i4
  %2 = llvm.and %1, %0 : i4
  %3 = llvm.xor %2, %arg16 : i4
  "llvm.return"(%3) : (i4) -> ()
}
]
def c_1_1_0_after := [llvm|
{
^0(%arg16 : i4, %arg17 : i4):
  %0 = llvm.mlir.constant(-2 : i4) : i4
  %1 = llvm.mlir.constant(1 : i4) : i4
  %2 = llvm.and %arg17, %0 : i4
  %3 = llvm.and %arg16, %1 : i4
  %4 = llvm.or disjoint %2, %3 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
set_option debug.skipKernelTC true in
theorem c_1_1_0_proof : c_1_1_0_before ⊑ c_1_1_0_after := by
  unfold c_1_1_0_before c_1_1_0_after
  simp_alive_peephole
  intros
  ---BEGIN c_1_1_0
  all_goals (try extract_goal ; sorry)
  ---END c_1_1_0



def commutativity_constant_14_vary_before := [llvm|
{
^0(%arg12 : i4, %arg13 : i4):
  %0 = llvm.mlir.constant(-2 : i4) : i4
  %1 = llvm.mlir.constant(1 : i4) : i4
  %2 = llvm.xor %arg12, %0 : i4
  %3 = llvm.and %2, %1 : i4
  %4 = llvm.xor %arg12, %3 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def commutativity_constant_14_vary_after := [llvm|
{
^0(%arg12 : i4, %arg13 : i4):
  %0 = llvm.mlir.constant(-2 : i4) : i4
  %1 = llvm.and %arg12, %0 : i4
  "llvm.return"(%1) : (i4) -> ()
}
]
set_option debug.skipKernelTC true in
theorem commutativity_constant_14_vary_proof : commutativity_constant_14_vary_before ⊑ commutativity_constant_14_vary_after := by
  unfold commutativity_constant_14_vary_before commutativity_constant_14_vary_after
  simp_alive_peephole
  intros
  ---BEGIN commutativity_constant_14_vary
  all_goals (try extract_goal ; sorry)
  ---END commutativity_constant_14_vary


