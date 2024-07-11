import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  vscale_alloca
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def alloca_before := [llvmfunc|
  llvm.func @alloca(%arg0: !llvm.vec<? x 4 x  i32>) -> !llvm.vec<? x 4 x  i32> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.vec<? x 4 x  i32> {alignment = 16 : i64} : (i32) -> !llvm.ptr]

    llvm.store %arg0, %1 {alignment = 16 : i64} : !llvm.vec<? x 4 x  i32>, !llvm.ptr]

    %2 = llvm.load %1 {alignment = 16 : i64} : !llvm.ptr -> !llvm.vec<? x 4 x  i32>]

    llvm.return %2 : !llvm.vec<? x 4 x  i32>
  }]

def alloca_dead_store_before := [llvmfunc|
  llvm.func @alloca_dead_store(%arg0: !llvm.vec<? x 4 x  i32>) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.vec<? x 4 x  i32> {alignment = 16 : i64} : (i32) -> !llvm.ptr]

    llvm.store %arg0, %1 {alignment = 16 : i64} : !llvm.vec<? x 4 x  i32>, !llvm.ptr]

    llvm.return
  }]

def alloca_zero_byte_move_first_inst_before := [llvmfunc|
  llvm.func @alloca_zero_byte_move_first_inst() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.vec<? x 16 x  i8> {alignment = 16 : i64} : (i32) -> !llvm.ptr]

    llvm.call @use(%1) vararg(!llvm.func<void (...)>) : (!llvm.ptr) -> ()
    %2 = llvm.alloca %0 x !llvm.struct<()> {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    llvm.call @use(%2) vararg(!llvm.func<void (...)>) : (!llvm.ptr) -> ()
    llvm.return
  }]

def alloca_combined := [llvmfunc|
  llvm.func @alloca(%arg0: !llvm.vec<? x 4 x  i32>) -> !llvm.vec<? x 4 x  i32> {
    llvm.return %arg0 : !llvm.vec<? x 4 x  i32>
  }]

theorem inst_combine_alloca   : alloca_before  ⊑  alloca_combined := by
  unfold alloca_before alloca_combined
  simp_alive_peephole
  sorry
def alloca_dead_store_combined := [llvmfunc|
  llvm.func @alloca_dead_store(%arg0: !llvm.vec<? x 4 x  i32>) {
    llvm.return
  }]

theorem inst_combine_alloca_dead_store   : alloca_dead_store_before  ⊑  alloca_dead_store_combined := by
  unfold alloca_dead_store_before alloca_dead_store_combined
  simp_alive_peephole
  sorry
def alloca_zero_byte_move_first_inst_combined := [llvmfunc|
  llvm.func @alloca_zero_byte_move_first_inst() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.struct<()> {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %2 = llvm.alloca %0 x !llvm.vec<? x 16 x  i8> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    llvm.call @use(%2) vararg(!llvm.func<void (...)>) : (!llvm.ptr) -> ()
    llvm.call @use(%1) vararg(!llvm.func<void (...)>) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_alloca_zero_byte_move_first_inst   : alloca_zero_byte_move_first_inst_before  ⊑  alloca_zero_byte_move_first_inst_combined := by
  unfold alloca_zero_byte_move_first_inst_before alloca_zero_byte_move_first_inst_combined
  simp_alive_peephole
  sorry
