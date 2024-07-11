import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  loadstore-alignment
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def static_hem_before := [llvmfunc|
  llvm.func @static_hem() -> vector<2xi64> {
    %0 = llvm.mlir.addressof @x : !llvm.ptr
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.getelementptr %0[%1] : (!llvm.ptr, i32) -> !llvm.ptr, vector<2xi64>
    %3 = llvm.load %2 {alignment = 1 : i64} : !llvm.ptr -> vector<2xi64>]

    llvm.return %3 : vector<2xi64>
  }]

def hem_before := [llvmfunc|
  llvm.func @hem(%arg0: i32) -> vector<2xi64> {
    %0 = llvm.mlir.addressof @x : !llvm.ptr
    %1 = llvm.getelementptr %0[%arg0] : (!llvm.ptr, i32) -> !llvm.ptr, vector<2xi64>
    %2 = llvm.load %1 {alignment = 1 : i64} : !llvm.ptr -> vector<2xi64>]

    llvm.return %2 : vector<2xi64>
  }]

def hem_2d_before := [llvmfunc|
  llvm.func @hem_2d(%arg0: i32, %arg1: i32) -> vector<2xi64> {
    %0 = llvm.mlir.addressof @xx : !llvm.ptr
    %1 = llvm.getelementptr %0[%arg0, %arg1] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<13 x vector<2xi64>>
    %2 = llvm.load %1 {alignment = 1 : i64} : !llvm.ptr -> vector<2xi64>]

    llvm.return %2 : vector<2xi64>
  }]

def foo_before := [llvmfunc|
  llvm.func @foo() -> vector<2xi64> {
    %0 = llvm.mlir.addressof @x : !llvm.ptr
    %1 = llvm.load %0 {alignment = 1 : i64} : !llvm.ptr -> vector<2xi64>]

    llvm.return %1 : vector<2xi64>
  }]

def bar_before := [llvmfunc|
  llvm.func @bar() -> vector<2xi64> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x vector<2xi64> {alignment = 16 : i64} : (i32) -> !llvm.ptr]

    llvm.call @kip(%1) : (!llvm.ptr) -> ()
    %2 = llvm.load %1 {alignment = 1 : i64} : !llvm.ptr -> vector<2xi64>]

    llvm.return %2 : vector<2xi64>
  }]

def static_hem_store_before := [llvmfunc|
  llvm.func @static_hem_store(%arg0: vector<2xi64>) {
    %0 = llvm.mlir.addressof @x : !llvm.ptr
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.getelementptr %0[%1] : (!llvm.ptr, i32) -> !llvm.ptr, vector<2xi64>
    llvm.store %arg0, %2 {alignment = 1 : i64} : vector<2xi64>, !llvm.ptr]

    llvm.return
  }]

def hem_store_before := [llvmfunc|
  llvm.func @hem_store(%arg0: i32, %arg1: vector<2xi64>) {
    %0 = llvm.mlir.addressof @x : !llvm.ptr
    %1 = llvm.getelementptr %0[%arg0] : (!llvm.ptr, i32) -> !llvm.ptr, vector<2xi64>
    llvm.store %arg1, %1 {alignment = 1 : i64} : vector<2xi64>, !llvm.ptr]

    llvm.return
  }]

def hem_2d_store_before := [llvmfunc|
  llvm.func @hem_2d_store(%arg0: i32, %arg1: i32, %arg2: vector<2xi64>) {
    %0 = llvm.mlir.addressof @xx : !llvm.ptr
    %1 = llvm.getelementptr %0[%arg0, %arg1] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<13 x vector<2xi64>>
    llvm.store %arg2, %1 {alignment = 1 : i64} : vector<2xi64>, !llvm.ptr]

    llvm.return
  }]

def foo_store_before := [llvmfunc|
  llvm.func @foo_store(%arg0: vector<2xi64>) {
    %0 = llvm.mlir.addressof @x : !llvm.ptr
    llvm.store %arg0, %0 {alignment = 1 : i64} : vector<2xi64>, !llvm.ptr]

    llvm.return
  }]

def bar_store_before := [llvmfunc|
  llvm.func @bar_store(%arg0: vector<2xi64>) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x vector<2xi64> {alignment = 16 : i64} : (i32) -> !llvm.ptr]

    llvm.call @kip(%1) : (!llvm.ptr) -> ()
    llvm.store %arg0, %1 {alignment = 1 : i64} : vector<2xi64>, !llvm.ptr]

    llvm.return
  }]

def static_hem_combined := [llvmfunc|
  llvm.func @static_hem() -> vector<2xi64> {
    %0 = llvm.mlir.constant(7 : i64) : i64
    %1 = llvm.mlir.addressof @x : !llvm.ptr
    %2 = llvm.getelementptr %1[%0] : (!llvm.ptr, i64) -> !llvm.ptr, vector<2xi64>
    %3 = llvm.load %2 {alignment = 1 : i64} : !llvm.ptr -> vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }]

theorem inst_combine_static_hem   : static_hem_before  ⊑  static_hem_combined := by
  unfold static_hem_before static_hem_combined
  simp_alive_peephole
  sorry
def hem_combined := [llvmfunc|
  llvm.func @hem(%arg0: i32) -> vector<2xi64> {
    %0 = llvm.mlir.addressof @x : !llvm.ptr
    %1 = llvm.sext %arg0 : i32 to i64
    %2 = llvm.getelementptr %0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, vector<2xi64>
    %3 = llvm.load %2 {alignment = 1 : i64} : !llvm.ptr -> vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }]

theorem inst_combine_hem   : hem_before  ⊑  hem_combined := by
  unfold hem_before hem_combined
  simp_alive_peephole
  sorry
def hem_2d_combined := [llvmfunc|
  llvm.func @hem_2d(%arg0: i32, %arg1: i32) -> vector<2xi64> {
    %0 = llvm.mlir.addressof @xx : !llvm.ptr
    %1 = llvm.sext %arg0 : i32 to i64
    %2 = llvm.sext %arg1 : i32 to i64
    %3 = llvm.getelementptr %0[%1, %2] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<13 x vector<2xi64>>
    %4 = llvm.load %3 {alignment = 1 : i64} : !llvm.ptr -> vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

theorem inst_combine_hem_2d   : hem_2d_before  ⊑  hem_2d_combined := by
  unfold hem_2d_before hem_2d_combined
  simp_alive_peephole
  sorry
def foo_combined := [llvmfunc|
  llvm.func @foo() -> vector<2xi64> {
    %0 = llvm.mlir.addressof @x : !llvm.ptr
    %1 = llvm.load %0 {alignment = 1 : i64} : !llvm.ptr -> vector<2xi64>
    llvm.return %1 : vector<2xi64>
  }]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
def bar_combined := [llvmfunc|
  llvm.func @bar() -> vector<2xi64> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x vector<2xi64> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    llvm.call @kip(%1) : (!llvm.ptr) -> ()
    %2 = llvm.load %1 {alignment = 1 : i64} : !llvm.ptr -> vector<2xi64>
    llvm.return %2 : vector<2xi64>
  }]

theorem inst_combine_bar   : bar_before  ⊑  bar_combined := by
  unfold bar_before bar_combined
  simp_alive_peephole
  sorry
def static_hem_store_combined := [llvmfunc|
  llvm.func @static_hem_store(%arg0: vector<2xi64>) {
    %0 = llvm.mlir.constant(7 : i64) : i64
    %1 = llvm.mlir.addressof @x : !llvm.ptr
    %2 = llvm.getelementptr %1[%0] : (!llvm.ptr, i64) -> !llvm.ptr, vector<2xi64>
    llvm.store %arg0, %2 {alignment = 1 : i64} : vector<2xi64>, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_static_hem_store   : static_hem_store_before  ⊑  static_hem_store_combined := by
  unfold static_hem_store_before static_hem_store_combined
  simp_alive_peephole
  sorry
def hem_store_combined := [llvmfunc|
  llvm.func @hem_store(%arg0: i32, %arg1: vector<2xi64>) {
    %0 = llvm.mlir.addressof @x : !llvm.ptr
    %1 = llvm.sext %arg0 : i32 to i64
    %2 = llvm.getelementptr %0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, vector<2xi64>
    llvm.store %arg1, %2 {alignment = 1 : i64} : vector<2xi64>, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_hem_store   : hem_store_before  ⊑  hem_store_combined := by
  unfold hem_store_before hem_store_combined
  simp_alive_peephole
  sorry
def hem_2d_store_combined := [llvmfunc|
  llvm.func @hem_2d_store(%arg0: i32, %arg1: i32, %arg2: vector<2xi64>) {
    %0 = llvm.mlir.addressof @xx : !llvm.ptr
    %1 = llvm.sext %arg0 : i32 to i64
    %2 = llvm.sext %arg1 : i32 to i64
    %3 = llvm.getelementptr %0[%1, %2] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<13 x vector<2xi64>>
    llvm.store %arg2, %3 {alignment = 1 : i64} : vector<2xi64>, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_hem_2d_store   : hem_2d_store_before  ⊑  hem_2d_store_combined := by
  unfold hem_2d_store_before hem_2d_store_combined
  simp_alive_peephole
  sorry
def foo_store_combined := [llvmfunc|
  llvm.func @foo_store(%arg0: vector<2xi64>) {
    %0 = llvm.mlir.addressof @x : !llvm.ptr
    llvm.store %arg0, %0 {alignment = 1 : i64} : vector<2xi64>, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_foo_store   : foo_store_before  ⊑  foo_store_combined := by
  unfold foo_store_before foo_store_combined
  simp_alive_peephole
  sorry
def bar_store_combined := [llvmfunc|
  llvm.func @bar_store(%arg0: vector<2xi64>) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x vector<2xi64> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    llvm.call @kip(%1) : (!llvm.ptr) -> ()
    llvm.store %arg0, %1 {alignment = 1 : i64} : vector<2xi64>, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_bar_store   : bar_store_before  ⊑  bar_store_combined := by
  unfold bar_store_before bar_store_combined
  simp_alive_peephole
  sorry
