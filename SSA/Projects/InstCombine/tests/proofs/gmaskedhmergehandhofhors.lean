import SSA.Projects.InstCombine.tests.proofs.gmaskedhmergehandhofhors_proof
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
section gmaskedhmergehandhofhors_statements

def p_before := [llvm|
{
^0(%arg73 : i32, %arg74 : i32, %arg75 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg75, %0 : i32
  %2 = llvm.or %1, %arg73 : i32
  %3 = llvm.or %arg74, %arg75 : i32
  %4 = llvm.and %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def p_after := [llvm|
{
^0(%arg73 : i32, %arg74 : i32, %arg75 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg75, %0 : i32
  %2 = llvm.or %arg73, %1 : i32
  %3 = llvm.or %arg74, %arg75 : i32
  %4 = llvm.and %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem p_proof : p_before ⊑ p_after := by
  unfold p_before p_after
  simp_alive_peephole
  intros
  ---BEGIN p
  apply p_thm
  ---END p



def p_commutative2_before := [llvm|
{
^0(%arg51 : i32, %arg52 : i32, %arg53 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg53, %0 : i32
  %2 = llvm.or %1, %arg51 : i32
  %3 = llvm.or %arg52, %arg53 : i32
  %4 = llvm.and %3, %2 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def p_commutative2_after := [llvm|
{
^0(%arg51 : i32, %arg52 : i32, %arg53 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg53, %0 : i32
  %2 = llvm.or %arg51, %1 : i32
  %3 = llvm.or %arg52, %arg53 : i32
  %4 = llvm.and %3, %2 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem p_commutative2_proof : p_commutative2_before ⊑ p_commutative2_after := by
  unfold p_commutative2_before p_commutative2_after
  simp_alive_peephole
  intros
  ---BEGIN p_commutative2
  apply p_commutative2_thm
  ---END p_commutative2



def n2_badmask_before := [llvm|
{
^0(%arg6 : i32, %arg7 : i32, %arg8 : i32, %arg9 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg9, %0 : i32
  %2 = llvm.or %1, %arg6 : i32
  %3 = llvm.or %arg8, %arg7 : i32
  %4 = llvm.and %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def n2_badmask_after := [llvm|
{
^0(%arg6 : i32, %arg7 : i32, %arg8 : i32, %arg9 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg9, %0 : i32
  %2 = llvm.or %arg6, %1 : i32
  %3 = llvm.or %arg8, %arg7 : i32
  %4 = llvm.and %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem n2_badmask_proof : n2_badmask_before ⊑ n2_badmask_after := by
  unfold n2_badmask_before n2_badmask_after
  simp_alive_peephole
  intros
  ---BEGIN n2_badmask
  apply n2_badmask_thm
  ---END n2_badmask



def n3_constmask_samemask_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.mlir.constant(-65281 : i32) : i32
  %1 = llvm.or %arg0, %0 : i32
  %2 = llvm.or %arg1, %0 : i32
  %3 = llvm.and %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def n3_constmask_samemask_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.mlir.constant(-65281 : i32) : i32
  %1 = llvm.and %arg0, %arg1 : i32
  %2 = llvm.or %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem n3_constmask_samemask_proof : n3_constmask_samemask_before ⊑ n3_constmask_samemask_after := by
  unfold n3_constmask_samemask_before n3_constmask_samemask_after
  simp_alive_peephole
  intros
  ---BEGIN n3_constmask_samemask
  apply n3_constmask_samemask_thm
  ---END n3_constmask_samemask


