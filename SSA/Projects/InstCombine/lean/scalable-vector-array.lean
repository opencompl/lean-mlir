import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  scalable-vector-array
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def load_before := [llvmfunc|
  llvm.func @load(%arg0: !llvm.ptr) -> !llvm.vec<? x 4 x  i32> {
    %0 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr -> !llvm.array<2 x vec<? x 4 x  i32>>]

    %1 = llvm.extractvalue %0[1] : !llvm.array<2 x vec<? x 4 x  i32>> 
    llvm.return %1 : !llvm.vec<? x 4 x  i32>
  }]

def store_before := [llvmfunc|
  llvm.func @store(%arg0: !llvm.ptr, %arg1: !llvm.vec<? x 4 x  i32>, %arg2: !llvm.vec<? x 4 x  i32>) {
    %0 = llvm.mlir.poison : !llvm.array<2 x vec<? x 4 x  i32>>
    %1 = llvm.insertvalue %arg1, %0[0] : !llvm.array<2 x vec<? x 4 x  i32>> 
    %2 = llvm.insertvalue %arg2, %1[1] : !llvm.array<2 x vec<? x 4 x  i32>> 
    llvm.store %2, %arg0 {alignment = 16 : i64} : !llvm.array<2 x vec<? x 4 x  i32>>, !llvm.ptr]

    llvm.return
  }]

def load_combined := [llvmfunc|
  llvm.func @load(%arg0: !llvm.ptr) -> !llvm.vec<? x 4 x  i32> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr inbounds %arg0[%0, %1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<2 x vec<? x 4 x  i32>>
    %3 = llvm.load %2 {alignment = 16 : i64} : !llvm.ptr -> !llvm.vec<? x 4 x  i32>]

theorem inst_combine_load   : load_before  ⊑  load_combined := by
  unfold load_before load_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : !llvm.vec<? x 4 x  i32>
  }]

theorem inst_combine_load   : load_before  ⊑  load_combined := by
  unfold load_before load_combined
  simp_alive_peephole
  sorry
def store_combined := [llvmfunc|
  llvm.func @store(%arg0: !llvm.ptr, %arg1: !llvm.vec<? x 4 x  i32>, %arg2: !llvm.vec<? x 4 x  i32>) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    llvm.store %arg1, %arg0 {alignment = 16 : i64} : !llvm.vec<? x 4 x  i32>, !llvm.ptr]

theorem inst_combine_store   : store_before  ⊑  store_combined := by
  unfold store_before store_combined
  simp_alive_peephole
  sorry
    %2 = llvm.getelementptr inbounds %arg0[%0, %1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<2 x vec<? x 4 x  i32>>
    llvm.store %arg2, %2 {alignment = 16 : i64} : !llvm.vec<? x 4 x  i32>, !llvm.ptr]

theorem inst_combine_store   : store_before  ⊑  store_combined := by
  unfold store_before store_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_store   : store_before  ⊑  store_combined := by
  unfold store_before store_combined
  simp_alive_peephole
  sorry
