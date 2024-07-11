import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  erase-dbg-values-at-dead-alloc-site
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t1_before := [llvmfunc|
  llvm.func @t1(%arg0: i32) {
    llvm.intr.dbg.value #di_local_variable = %arg0 : i32
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.intr.dbg.value #di_local_variable1 = %1 : !llvm.ptr
    llvm.intr.dbg.value #di_local_variable #llvm.di_expression<[DW_OP_deref]> = %1 : !llvm.ptr
    llvm.store %arg0, %1 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def t1_combined := [llvmfunc|
  llvm.func @t1(%arg0: i32) {
    %0 = llvm.mlir.poison : !llvm.ptr
    llvm.intr.dbg.value #di_local_variable = %0 : !llvm.ptr
    llvm.intr.dbg.value #di_local_variable1 = %arg0 : i32
    llvm.return
  }]

theorem inst_combine_t1   : t1_before  ⊑  t1_combined := by
  unfold t1_before t1_combined
  simp_alive_peephole
  sorry
