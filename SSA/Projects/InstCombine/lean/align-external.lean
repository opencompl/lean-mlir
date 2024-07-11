import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  align-external
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo_before := [llvmfunc|
  llvm.func @foo(%arg0: i64) -> i64 {
    %0 = llvm.mlir.addressof @A : !llvm.ptr
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.ptrtoint %0 : !llvm.ptr to i64
    %4 = llvm.shl %arg0, %1  : i64
    %5 = llvm.or %3, %4  : i64
    %6 = llvm.add %5, %2  : i64
    llvm.return %6 : i64
  }]

def bar_before := [llvmfunc|
  llvm.func @bar() -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @B : !llvm.ptr
    %2 = llvm.load %1 {alignment = 1 : i64} : !llvm.ptr -> i32]

    llvm.return %2 : i32
  }]

def vec_store_before := [llvmfunc|
  llvm.func @vec_store() {
    %0 = llvm.mlir.constant(dense<[0, 1, 2, 3]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.mlir.addressof @C : !llvm.ptr
    llvm.store %0, %3 {alignment = 4 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.return
  }]

def foo_combined := [llvmfunc|
  llvm.func @foo(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.mlir.addressof @A : !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.shl %arg0, %0  : i64
    %5 = llvm.or %4, %2  : i64
    %6 = llvm.add %5, %3  : i64
    llvm.return %6 : i64
  }]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
def bar_combined := [llvmfunc|
  llvm.func @bar() -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @B : !llvm.ptr
    %2 = llvm.load %1 {alignment = 1 : i64} : !llvm.ptr -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_bar   : bar_before  ⊑  bar_combined := by
  unfold bar_before bar_combined
  simp_alive_peephole
  sorry
def vec_store_combined := [llvmfunc|
  llvm.func @vec_store() {
    %0 = llvm.mlir.constant(dense<[0, 1, 2, 3]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.mlir.addressof @C : !llvm.ptr
    llvm.store %0, %3 {alignment = 4 : i64} : vector<4xi32>, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_vec_store   : vec_store_before  ⊑  vec_store_combined := by
  unfold vec_store_before vec_store_combined
  simp_alive_peephole
  sorry
