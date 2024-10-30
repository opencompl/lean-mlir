import SSA.Projects.InstCombine.tests.proofs.gshifthbyhsignext_proof
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
section gshifthbyhsignext_statements

def t0_shl_before := [llvm|
{
^0(%arg28 : i32, %arg29 : i8):
  %0 = llvm.sext %arg29 : i8 to i32
  %1 = llvm.shl %arg28, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
def t0_shl_after := [llvm|
{
^0(%arg28 : i32, %arg29 : i8):
  %0 = llvm.zext %arg29 : i8 to i32
  %1 = llvm.shl %arg28, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem t0_shl_proof : t0_shl_before ⊑ t0_shl_after := by
  unfold t0_shl_before t0_shl_after
  simp_alive_peephole
  ---BEGIN t0_shl
  apply t0_shl_thm
  ---END t0_shl



def t1_lshr_before := [llvm|
{
^0(%arg26 : i32, %arg27 : i8):
  %0 = llvm.sext %arg27 : i8 to i32
  %1 = llvm.lshr %arg26, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
def t1_lshr_after := [llvm|
{
^0(%arg26 : i32, %arg27 : i8):
  %0 = llvm.zext %arg27 : i8 to i32
  %1 = llvm.lshr %arg26, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem t1_lshr_proof : t1_lshr_before ⊑ t1_lshr_after := by
  unfold t1_lshr_before t1_lshr_after
  simp_alive_peephole
  ---BEGIN t1_lshr
  apply t1_lshr_thm
  ---END t1_lshr



def t2_ashr_before := [llvm|
{
^0(%arg24 : i32, %arg25 : i8):
  %0 = llvm.sext %arg25 : i8 to i32
  %1 = llvm.ashr %arg24, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
def t2_ashr_after := [llvm|
{
^0(%arg24 : i32, %arg25 : i8):
  %0 = llvm.zext %arg25 : i8 to i32
  %1 = llvm.ashr %arg24, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem t2_ashr_proof : t2_ashr_before ⊑ t2_ashr_after := by
  unfold t2_ashr_before t2_ashr_after
  simp_alive_peephole
  ---BEGIN t2_ashr
  apply t2_ashr_thm
  ---END t2_ashr


