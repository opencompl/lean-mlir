
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
section gsexthofhtrunchnsw_statements

def narrow_source_matching_signbits_before := [llvm|
{
^0(%arg7 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.and %arg7, %0 : i32
  %3 = llvm.shl %1, %2 overflow<nsw> : i32
  %4 = llvm.trunc %3 : i32 to i8
  %5 = llvm.sext %4 : i8 to i64
  "llvm.return"(%5) : (i64) -> ()
}
]
def narrow_source_matching_signbits_after := [llvm|
{
^0(%arg7 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.and %arg7, %0 : i32
  %3 = llvm.shl %1, %2 overflow<nsw> : i32
  %4 = llvm.sext %3 : i32 to i64
  "llvm.return"(%4) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem narrow_source_matching_signbits_proof : narrow_source_matching_signbits_before ⊑ narrow_source_matching_signbits_after := by
  unfold narrow_source_matching_signbits_before narrow_source_matching_signbits_after
  simp_alive_peephole
  intros
  ---BEGIN narrow_source_matching_signbits
  all_goals (try extract_goal ; sorry)
  ---END narrow_source_matching_signbits



def wide_source_matching_signbits_before := [llvm|
{
^0(%arg5 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.and %arg5, %0 : i32
  %3 = llvm.shl %1, %2 overflow<nsw> : i32
  %4 = llvm.trunc %3 : i32 to i8
  %5 = llvm.sext %4 : i8 to i24
  "llvm.return"(%5) : (i24) -> ()
}
]
def wide_source_matching_signbits_after := [llvm|
{
^0(%arg5 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.and %arg5, %0 : i32
  %3 = llvm.shl %1, %2 overflow<nsw> : i32
  %4 = llvm.trunc %3 overflow<nsw> : i32 to i24
  "llvm.return"(%4) : (i24) -> ()
}
]
set_option debug.skipKernelTC true in
theorem wide_source_matching_signbits_proof : wide_source_matching_signbits_before ⊑ wide_source_matching_signbits_after := by
  unfold wide_source_matching_signbits_before wide_source_matching_signbits_after
  simp_alive_peephole
  intros
  ---BEGIN wide_source_matching_signbits
  all_goals (try extract_goal ; sorry)
  ---END wide_source_matching_signbits



def same_source_matching_signbits_before := [llvm|
{
^0(%arg3 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.and %arg3, %0 : i32
  %3 = llvm.shl %1, %2 overflow<nsw> : i32
  %4 = llvm.trunc %3 : i32 to i8
  %5 = llvm.sext %4 : i8 to i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def same_source_matching_signbits_after := [llvm|
{
^0(%arg3 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.and %arg3, %0 : i32
  %3 = llvm.shl %1, %2 overflow<nsw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem same_source_matching_signbits_proof : same_source_matching_signbits_before ⊑ same_source_matching_signbits_after := by
  unfold same_source_matching_signbits_before same_source_matching_signbits_after
  simp_alive_peephole
  intros
  ---BEGIN same_source_matching_signbits
  all_goals (try extract_goal ; sorry)
  ---END same_source_matching_signbits



def same_source_not_matching_signbits_before := [llvm|
{
^0(%arg2 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.and %arg2, %0 : i32
  %3 = llvm.shl %1, %2 overflow<nsw> : i32
  %4 = llvm.trunc %3 : i32 to i8
  %5 = llvm.sext %4 : i8 to i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def same_source_not_matching_signbits_after := [llvm|
{
^0(%arg2 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(-16777216 : i32) : i32
  %2 = llvm.mlir.constant(24 : i32) : i32
  %3 = llvm.and %arg2, %0 : i32
  %4 = llvm.shl %1, %3 : i32
  %5 = llvm.ashr exact %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem same_source_not_matching_signbits_proof : same_source_not_matching_signbits_before ⊑ same_source_not_matching_signbits_after := by
  unfold same_source_not_matching_signbits_before same_source_not_matching_signbits_after
  simp_alive_peephole
  intros
  ---BEGIN same_source_not_matching_signbits
  all_goals (try extract_goal ; sorry)
  ---END same_source_not_matching_signbits


