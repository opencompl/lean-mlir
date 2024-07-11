import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  volatile_load_cast
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def float_load_before := [llvmfunc|
  llvm.func @float_load(%arg0: !llvm.ptr) -> f32 {
    %0 = llvm.load volatile %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %1 = llvm.bitcast %0 : i32 to f32
    llvm.return %1 : f32
  }]

def i32_load_before := [llvmfunc|
  llvm.func @i32_load(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.load volatile %arg0 {alignment = 4 : i64} : !llvm.ptr -> f32]

    %1 = llvm.bitcast %0 : f32 to i32
    llvm.return %1 : i32
  }]

def double_load_before := [llvmfunc|
  llvm.func @double_load(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.load volatile %arg0 {alignment = 8 : i64} : !llvm.ptr -> i64]

    %1 = llvm.bitcast %0 : i64 to f64
    llvm.return %1 : f64
  }]

def i64_load_before := [llvmfunc|
  llvm.func @i64_load(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.load volatile %arg0 {alignment = 8 : i64} : !llvm.ptr -> f64]

    %1 = llvm.bitcast %0 : f64 to i64
    llvm.return %1 : i64
  }]

def ptr_load_before := [llvmfunc|
  llvm.func @ptr_load(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.load volatile %arg0 {alignment = 8 : i64} : !llvm.ptr -> i64]

    %1 = llvm.inttoptr %0 : i64 to !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

def float_load_combined := [llvmfunc|
  llvm.func @float_load(%arg0: !llvm.ptr) -> f32 {
    %0 = llvm.load volatile %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32
    %1 = llvm.bitcast %0 : i32 to f32
    llvm.return %1 : f32
  }]

theorem inst_combine_float_load   : float_load_before  ⊑  float_load_combined := by
  unfold float_load_before float_load_combined
  simp_alive_peephole
  sorry
def i32_load_combined := [llvmfunc|
  llvm.func @i32_load(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.load volatile %arg0 {alignment = 4 : i64} : !llvm.ptr -> f32
    %1 = llvm.bitcast %0 : f32 to i32
    llvm.return %1 : i32
  }]

theorem inst_combine_i32_load   : i32_load_before  ⊑  i32_load_combined := by
  unfold i32_load_before i32_load_combined
  simp_alive_peephole
  sorry
def double_load_combined := [llvmfunc|
  llvm.func @double_load(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.load volatile %arg0 {alignment = 8 : i64} : !llvm.ptr -> i64
    %1 = llvm.bitcast %0 : i64 to f64
    llvm.return %1 : f64
  }]

theorem inst_combine_double_load   : double_load_before  ⊑  double_load_combined := by
  unfold double_load_before double_load_combined
  simp_alive_peephole
  sorry
def i64_load_combined := [llvmfunc|
  llvm.func @i64_load(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.load volatile %arg0 {alignment = 8 : i64} : !llvm.ptr -> f64
    %1 = llvm.bitcast %0 : f64 to i64
    llvm.return %1 : i64
  }]

theorem inst_combine_i64_load   : i64_load_before  ⊑  i64_load_combined := by
  unfold i64_load_before i64_load_combined
  simp_alive_peephole
  sorry
def ptr_load_combined := [llvmfunc|
  llvm.func @ptr_load(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.load volatile %arg0 {alignment = 8 : i64} : !llvm.ptr -> i64
    %1 = llvm.inttoptr %0 : i64 to !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_ptr_load   : ptr_load_before  ⊑  ptr_load_combined := by
  unfold ptr_load_before ptr_load_combined
  simp_alive_peephole
  sorry
