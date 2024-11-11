import SSA.Projects.InstCombine.tests.proofs.gtrunchshifthtrunc_proof
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
section gtrunchshifthtrunc_statements

def trunc_lshr_trunc_before := [llvm|
{
^0(%arg14 : i64):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.trunc %arg14 : i64 to i32
  %2 = llvm.lshr %1, %0 : i32
  %3 = llvm.trunc %2 : i32 to i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def trunc_lshr_trunc_after := [llvm|
{
^0(%arg14 : i64):
  %0 = llvm.mlir.constant(8) : i64
  %1 = llvm.lshr %arg14, %0 : i64
  %2 = llvm.trunc %1 : i64 to i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_lshr_trunc_proof : trunc_lshr_trunc_before ⊑ trunc_lshr_trunc_after := by
  unfold trunc_lshr_trunc_before trunc_lshr_trunc_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_lshr_trunc
  apply trunc_lshr_trunc_thm
  ---END trunc_lshr_trunc



def trunc_lshr_trunc_outofrange_before := [llvm|
{
^0(%arg9 : i64):
  %0 = llvm.mlir.constant(25 : i32) : i32
  %1 = llvm.trunc %arg9 : i64 to i32
  %2 = llvm.lshr %1, %0 : i32
  %3 = llvm.trunc %2 : i32 to i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def trunc_lshr_trunc_outofrange_after := [llvm|
{
^0(%arg9 : i64):
  %0 = llvm.mlir.constant(25 : i32) : i32
  %1 = llvm.trunc %arg9 : i64 to i32
  %2 = llvm.lshr %1, %0 : i32
  %3 = llvm.trunc %2 overflow<nsw,nuw> : i32 to i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_lshr_trunc_outofrange_proof : trunc_lshr_trunc_outofrange_before ⊑ trunc_lshr_trunc_outofrange_after := by
  unfold trunc_lshr_trunc_outofrange_before trunc_lshr_trunc_outofrange_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_lshr_trunc_outofrange
  apply trunc_lshr_trunc_outofrange_thm
  ---END trunc_lshr_trunc_outofrange



def trunc_ashr_trunc_before := [llvm|
{
^0(%arg7 : i64):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.trunc %arg7 : i64 to i32
  %2 = llvm.ashr %1, %0 : i32
  %3 = llvm.trunc %2 : i32 to i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def trunc_ashr_trunc_after := [llvm|
{
^0(%arg7 : i64):
  %0 = llvm.mlir.constant(8) : i64
  %1 = llvm.lshr %arg7, %0 : i64
  %2 = llvm.trunc %1 : i64 to i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_ashr_trunc_proof : trunc_ashr_trunc_before ⊑ trunc_ashr_trunc_after := by
  unfold trunc_ashr_trunc_before trunc_ashr_trunc_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_ashr_trunc
  apply trunc_ashr_trunc_thm
  ---END trunc_ashr_trunc



def trunc_ashr_trunc_exact_before := [llvm|
{
^0(%arg6 : i64):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.trunc %arg6 : i64 to i32
  %2 = llvm.ashr exact %1, %0 : i32
  %3 = llvm.trunc %2 : i32 to i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def trunc_ashr_trunc_exact_after := [llvm|
{
^0(%arg6 : i64):
  %0 = llvm.mlir.constant(8) : i64
  %1 = llvm.lshr exact %arg6, %0 : i64
  %2 = llvm.trunc %1 : i64 to i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_ashr_trunc_exact_proof : trunc_ashr_trunc_exact_before ⊑ trunc_ashr_trunc_exact_after := by
  unfold trunc_ashr_trunc_exact_before trunc_ashr_trunc_exact_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_ashr_trunc_exact
  apply trunc_ashr_trunc_exact_thm
  ---END trunc_ashr_trunc_exact



def trunc_ashr_trunc_outofrange_before := [llvm|
{
^0(%arg2 : i64):
  %0 = llvm.mlir.constant(25 : i32) : i32
  %1 = llvm.trunc %arg2 : i64 to i32
  %2 = llvm.ashr %1, %0 : i32
  %3 = llvm.trunc %2 : i32 to i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def trunc_ashr_trunc_outofrange_after := [llvm|
{
^0(%arg2 : i64):
  %0 = llvm.mlir.constant(25 : i32) : i32
  %1 = llvm.trunc %arg2 : i64 to i32
  %2 = llvm.ashr %1, %0 : i32
  %3 = llvm.trunc %2 overflow<nsw> : i32 to i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_ashr_trunc_outofrange_proof : trunc_ashr_trunc_outofrange_before ⊑ trunc_ashr_trunc_outofrange_after := by
  unfold trunc_ashr_trunc_outofrange_before trunc_ashr_trunc_outofrange_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_ashr_trunc_outofrange
  apply trunc_ashr_trunc_outofrange_thm
  ---END trunc_ashr_trunc_outofrange


