import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  strnlen-6
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def deref_strnlen_ecp_3_before := [llvmfunc|
  llvm.func @deref_strnlen_ecp_3() -> i64 {
    %0 = llvm.mlir.addressof @ecp : !llvm.ptr
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.load %0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %3 = llvm.call @strnlen(%2, %1) : (!llvm.ptr, i64) -> i64
    llvm.return %3 : i64
  }]

def deref_strnlen_ecp_nz_before := [llvmfunc|
  llvm.func @deref_strnlen_ecp_nz(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.addressof @ecp : !llvm.ptr
    %2 = llvm.or %arg0, %0  : i64
    %3 = llvm.load %1 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %4 = llvm.call @strnlen(%3, %2) : (!llvm.ptr, i64) -> i64
    llvm.return %4 : i64
  }]

def noderef_strnlen_ecp_n_before := [llvmfunc|
  llvm.func @noderef_strnlen_ecp_n(%arg0: i64) -> i64 {
    %0 = llvm.mlir.addressof @ecp : !llvm.ptr
    %1 = llvm.load %0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %2 = llvm.call @strnlen(%1, %arg0) : (!llvm.ptr, i64) -> i64
    llvm.return %2 : i64
  }]

def deref_strnlen_ecp_3_combined := [llvmfunc|
  llvm.func @deref_strnlen_ecp_3() -> i64 {
    %0 = llvm.mlir.addressof @ecp : !llvm.ptr
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.load %0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

theorem inst_combine_deref_strnlen_ecp_3   : deref_strnlen_ecp_3_before  ⊑  deref_strnlen_ecp_3_combined := by
  unfold deref_strnlen_ecp_3_before deref_strnlen_ecp_3_combined
  simp_alive_peephole
  sorry
    %3 = llvm.call @strnlen(%2, %1) : (!llvm.ptr, i64) -> i64
    llvm.return %3 : i64
  }]

theorem inst_combine_deref_strnlen_ecp_3   : deref_strnlen_ecp_3_before  ⊑  deref_strnlen_ecp_3_combined := by
  unfold deref_strnlen_ecp_3_before deref_strnlen_ecp_3_combined
  simp_alive_peephole
  sorry
def deref_strnlen_ecp_nz_combined := [llvmfunc|
  llvm.func @deref_strnlen_ecp_nz(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.addressof @ecp : !llvm.ptr
    %2 = llvm.or %arg0, %0  : i64
    %3 = llvm.load %1 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

theorem inst_combine_deref_strnlen_ecp_nz   : deref_strnlen_ecp_nz_before  ⊑  deref_strnlen_ecp_nz_combined := by
  unfold deref_strnlen_ecp_nz_before deref_strnlen_ecp_nz_combined
  simp_alive_peephole
  sorry
    %4 = llvm.call @strnlen(%3, %2) : (!llvm.ptr, i64) -> i64
    llvm.return %4 : i64
  }]

theorem inst_combine_deref_strnlen_ecp_nz   : deref_strnlen_ecp_nz_before  ⊑  deref_strnlen_ecp_nz_combined := by
  unfold deref_strnlen_ecp_nz_before deref_strnlen_ecp_nz_combined
  simp_alive_peephole
  sorry
def noderef_strnlen_ecp_n_combined := [llvmfunc|
  llvm.func @noderef_strnlen_ecp_n(%arg0: i64) -> i64 {
    %0 = llvm.mlir.addressof @ecp : !llvm.ptr
    %1 = llvm.load %0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

theorem inst_combine_noderef_strnlen_ecp_n   : noderef_strnlen_ecp_n_before  ⊑  noderef_strnlen_ecp_n_combined := by
  unfold noderef_strnlen_ecp_n_before noderef_strnlen_ecp_n_combined
  simp_alive_peephole
  sorry
    %2 = llvm.call @strnlen(%1, %arg0) : (!llvm.ptr, i64) -> i64
    llvm.return %2 : i64
  }]

theorem inst_combine_noderef_strnlen_ecp_n   : noderef_strnlen_ecp_n_before  ⊑  noderef_strnlen_ecp_n_combined := by
  unfold noderef_strnlen_ecp_n_before noderef_strnlen_ecp_n_combined
  simp_alive_peephole
  sorry
