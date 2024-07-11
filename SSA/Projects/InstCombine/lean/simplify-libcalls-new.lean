import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  simplify-libcalls-new
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def new_before := [llvmfunc|
  llvm.func @new() {
    %0 = llvm.mlir.constant(10 : i64) : i64
    %1 = llvm.call @_Znwm(%0) : (i64) -> !llvm.ptr
    llvm.call @dummy(%1) : (!llvm.ptr) -> ()
    %2 = llvm.call @_Znwm(%0) : (i64) -> !llvm.ptr
    llvm.call @dummy(%2) : (!llvm.ptr) -> ()
    %3 = llvm.call @_Znwm(%0) : (i64) -> !llvm.ptr
    llvm.call @dummy(%3) : (!llvm.ptr) -> ()
    llvm.return
  }]

def new_align_before := [llvmfunc|
  llvm.func @new_align() {
    %0 = llvm.mlir.constant(10 : i64) : i64
    %1 = llvm.mlir.constant(8 : i64) : i64
    %2 = llvm.call @_ZnwmSt11align_val_t(%0, %1) : (i64, i64) -> !llvm.ptr
    llvm.call @dummy(%2) : (!llvm.ptr) -> ()
    %3 = llvm.call @_ZnwmSt11align_val_t(%0, %1) : (i64, i64) -> !llvm.ptr
    llvm.call @dummy(%3) : (!llvm.ptr) -> ()
    %4 = llvm.call @_ZnwmSt11align_val_t(%0, %1) : (i64, i64) -> !llvm.ptr
    llvm.call @dummy(%4) : (!llvm.ptr) -> ()
    llvm.return
  }]

def new_nothrow_before := [llvmfunc|
  llvm.func @new_nothrow() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(10 : i64) : i64
    %2 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    %3 = llvm.call @_ZnwmRKSt9nothrow_t(%1, %2) : (i64, !llvm.ptr) -> !llvm.ptr
    llvm.call @dummy(%3) : (!llvm.ptr) -> ()
    %4 = llvm.call @_ZnwmRKSt9nothrow_t(%1, %2) : (i64, !llvm.ptr) -> !llvm.ptr
    llvm.call @dummy(%4) : (!llvm.ptr) -> ()
    %5 = llvm.call @_ZnwmRKSt9nothrow_t(%1, %2) : (i64, !llvm.ptr) -> !llvm.ptr
    llvm.call @dummy(%5) : (!llvm.ptr) -> ()
    llvm.return
  }]

def new_align_nothrow_before := [llvmfunc|
  llvm.func @new_align_nothrow() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(10 : i64) : i64
    %2 = llvm.mlir.constant(8 : i64) : i64
    %3 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    %4 = llvm.call @_ZnwmSt11align_val_tRKSt9nothrow_t(%1, %2, %3) : (i64, i64, !llvm.ptr) -> !llvm.ptr
    llvm.call @dummy(%4) : (!llvm.ptr) -> ()
    %5 = llvm.call @_ZnwmSt11align_val_tRKSt9nothrow_t(%1, %2, %3) : (i64, i64, !llvm.ptr) -> !llvm.ptr
    llvm.call @dummy(%5) : (!llvm.ptr) -> ()
    %6 = llvm.call @_ZnwmSt11align_val_tRKSt9nothrow_t(%1, %2, %3) : (i64, i64, !llvm.ptr) -> !llvm.ptr
    llvm.call @dummy(%6) : (!llvm.ptr) -> ()
    llvm.return
  }]

def array_new_before := [llvmfunc|
  llvm.func @array_new() {
    %0 = llvm.mlir.constant(10 : i64) : i64
    %1 = llvm.call @_Znam(%0) : (i64) -> !llvm.ptr
    llvm.call @dummy(%1) : (!llvm.ptr) -> ()
    %2 = llvm.call @_Znam(%0) : (i64) -> !llvm.ptr
    llvm.call @dummy(%2) : (!llvm.ptr) -> ()
    %3 = llvm.call @_Znam(%0) : (i64) -> !llvm.ptr
    llvm.call @dummy(%3) : (!llvm.ptr) -> ()
    llvm.return
  }]

def array_new_align_before := [llvmfunc|
  llvm.func @array_new_align() {
    %0 = llvm.mlir.constant(10 : i64) : i64
    %1 = llvm.mlir.constant(8 : i64) : i64
    %2 = llvm.call @_ZnamSt11align_val_t(%0, %1) : (i64, i64) -> !llvm.ptr
    llvm.call @dummy(%2) : (!llvm.ptr) -> ()
    %3 = llvm.call @_ZnamSt11align_val_t(%0, %1) : (i64, i64) -> !llvm.ptr
    llvm.call @dummy(%3) : (!llvm.ptr) -> ()
    %4 = llvm.call @_ZnamSt11align_val_t(%0, %1) : (i64, i64) -> !llvm.ptr
    llvm.call @dummy(%4) : (!llvm.ptr) -> ()
    llvm.return
  }]

def array_new_nothrow_before := [llvmfunc|
  llvm.func @array_new_nothrow() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(10 : i64) : i64
    %2 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    %3 = llvm.call @_ZnamRKSt9nothrow_t(%1, %2) : (i64, !llvm.ptr) -> !llvm.ptr
    llvm.call @dummy(%3) : (!llvm.ptr) -> ()
    %4 = llvm.call @_ZnamRKSt9nothrow_t(%1, %2) : (i64, !llvm.ptr) -> !llvm.ptr
    llvm.call @dummy(%4) : (!llvm.ptr) -> ()
    %5 = llvm.call @_ZnamRKSt9nothrow_t(%1, %2) : (i64, !llvm.ptr) -> !llvm.ptr
    llvm.call @dummy(%5) : (!llvm.ptr) -> ()
    llvm.return
  }]

def array_new_align_nothrow_before := [llvmfunc|
  llvm.func @array_new_align_nothrow() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(10 : i64) : i64
    %2 = llvm.mlir.constant(8 : i64) : i64
    %3 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    %4 = llvm.call @_ZnamSt11align_val_tRKSt9nothrow_t(%1, %2, %3) : (i64, i64, !llvm.ptr) -> !llvm.ptr
    llvm.call @dummy(%4) : (!llvm.ptr) -> ()
    %5 = llvm.call @_ZnamSt11align_val_tRKSt9nothrow_t(%1, %2, %3) : (i64, i64, !llvm.ptr) -> !llvm.ptr
    llvm.call @dummy(%5) : (!llvm.ptr) -> ()
    %6 = llvm.call @_ZnamSt11align_val_tRKSt9nothrow_t(%1, %2, %3) : (i64, i64, !llvm.ptr) -> !llvm.ptr
    llvm.call @dummy(%6) : (!llvm.ptr) -> ()
    llvm.return
  }]

def new_hot_cold_before := [llvmfunc|
  llvm.func @new_hot_cold() {
    %0 = llvm.mlir.constant(10 : i64) : i64
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.call @_Znwm12__hot_cold_t(%0, %1) : (i64, i8) -> !llvm.ptr
    llvm.call @dummy(%2) : (!llvm.ptr) -> ()
    %3 = llvm.call @_Znwm12__hot_cold_t(%0, %1) : (i64, i8) -> !llvm.ptr
    llvm.call @dummy(%3) : (!llvm.ptr) -> ()
    %4 = llvm.call @_Znwm12__hot_cold_t(%0, %1) : (i64, i8) -> !llvm.ptr
    llvm.call @dummy(%4) : (!llvm.ptr) -> ()
    llvm.return
  }]

def new_align_hot_cold_before := [llvmfunc|
  llvm.func @new_align_hot_cold() {
    %0 = llvm.mlir.constant(10 : i64) : i64
    %1 = llvm.mlir.constant(8 : i64) : i64
    %2 = llvm.mlir.constant(7 : i8) : i8
    %3 = llvm.call @_ZnwmSt11align_val_t12__hot_cold_t(%0, %1, %2) : (i64, i64, i8) -> !llvm.ptr
    llvm.call @dummy(%3) : (!llvm.ptr) -> ()
    %4 = llvm.call @_ZnwmSt11align_val_t12__hot_cold_t(%0, %1, %2) : (i64, i64, i8) -> !llvm.ptr
    llvm.call @dummy(%4) : (!llvm.ptr) -> ()
    %5 = llvm.call @_ZnwmSt11align_val_t12__hot_cold_t(%0, %1, %2) : (i64, i64, i8) -> !llvm.ptr
    llvm.call @dummy(%5) : (!llvm.ptr) -> ()
    llvm.return
  }]

def new_nothrow_hot_cold_before := [llvmfunc|
  llvm.func @new_nothrow_hot_cold() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(10 : i64) : i64
    %2 = llvm.mlir.constant(7 : i8) : i8
    %3 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    %4 = llvm.call @_ZnwmRKSt9nothrow_t12__hot_cold_t(%1, %3, %2) : (i64, !llvm.ptr, i8) -> !llvm.ptr
    llvm.call @dummy(%4) : (!llvm.ptr) -> ()
    %5 = llvm.call @_ZnwmRKSt9nothrow_t12__hot_cold_t(%1, %3, %2) : (i64, !llvm.ptr, i8) -> !llvm.ptr
    llvm.call @dummy(%5) : (!llvm.ptr) -> ()
    %6 = llvm.call @_ZnwmRKSt9nothrow_t12__hot_cold_t(%1, %3, %2) : (i64, !llvm.ptr, i8) -> !llvm.ptr
    llvm.call @dummy(%6) : (!llvm.ptr) -> ()
    llvm.return
  }]

def new_align_nothrow_hot_cold_before := [llvmfunc|
  llvm.func @new_align_nothrow_hot_cold() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(10 : i64) : i64
    %2 = llvm.mlir.constant(8 : i64) : i64
    %3 = llvm.mlir.constant(7 : i8) : i8
    %4 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    %5 = llvm.call @_ZnwmSt11align_val_tRKSt9nothrow_t12__hot_cold_t(%1, %2, %4, %3) : (i64, i64, !llvm.ptr, i8) -> !llvm.ptr
    llvm.call @dummy(%5) : (!llvm.ptr) -> ()
    %6 = llvm.call @_ZnwmSt11align_val_tRKSt9nothrow_t12__hot_cold_t(%1, %2, %4, %3) : (i64, i64, !llvm.ptr, i8) -> !llvm.ptr
    llvm.call @dummy(%6) : (!llvm.ptr) -> ()
    %7 = llvm.call @_ZnwmSt11align_val_tRKSt9nothrow_t12__hot_cold_t(%1, %2, %4, %3) : (i64, i64, !llvm.ptr, i8) -> !llvm.ptr
    llvm.call @dummy(%7) : (!llvm.ptr) -> ()
    llvm.return
  }]

def array_new_hot_cold_before := [llvmfunc|
  llvm.func @array_new_hot_cold() {
    %0 = llvm.mlir.constant(10 : i64) : i64
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.call @_Znam12__hot_cold_t(%0, %1) : (i64, i8) -> !llvm.ptr
    llvm.call @dummy(%2) : (!llvm.ptr) -> ()
    %3 = llvm.call @_Znam12__hot_cold_t(%0, %1) : (i64, i8) -> !llvm.ptr
    llvm.call @dummy(%3) : (!llvm.ptr) -> ()
    %4 = llvm.call @_Znam12__hot_cold_t(%0, %1) : (i64, i8) -> !llvm.ptr
    llvm.call @dummy(%4) : (!llvm.ptr) -> ()
    llvm.return
  }]

def array_new_align_hot_cold_before := [llvmfunc|
  llvm.func @array_new_align_hot_cold() {
    %0 = llvm.mlir.constant(10 : i64) : i64
    %1 = llvm.mlir.constant(8 : i64) : i64
    %2 = llvm.mlir.constant(7 : i8) : i8
    %3 = llvm.call @_ZnamSt11align_val_t12__hot_cold_t(%0, %1, %2) : (i64, i64, i8) -> !llvm.ptr
    llvm.call @dummy(%3) : (!llvm.ptr) -> ()
    %4 = llvm.call @_ZnamSt11align_val_t12__hot_cold_t(%0, %1, %2) : (i64, i64, i8) -> !llvm.ptr
    llvm.call @dummy(%4) : (!llvm.ptr) -> ()
    %5 = llvm.call @_ZnamSt11align_val_t12__hot_cold_t(%0, %1, %2) : (i64, i64, i8) -> !llvm.ptr
    llvm.call @dummy(%5) : (!llvm.ptr) -> ()
    llvm.return
  }]

def array_new_nothrow_hot_cold_before := [llvmfunc|
  llvm.func @array_new_nothrow_hot_cold() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(10 : i64) : i64
    %2 = llvm.mlir.constant(7 : i8) : i8
    %3 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    %4 = llvm.call @_ZnamRKSt9nothrow_t12__hot_cold_t(%1, %3, %2) : (i64, !llvm.ptr, i8) -> !llvm.ptr
    llvm.call @dummy(%4) : (!llvm.ptr) -> ()
    %5 = llvm.call @_ZnamRKSt9nothrow_t12__hot_cold_t(%1, %3, %2) : (i64, !llvm.ptr, i8) -> !llvm.ptr
    llvm.call @dummy(%5) : (!llvm.ptr) -> ()
    %6 = llvm.call @_ZnamRKSt9nothrow_t12__hot_cold_t(%1, %3, %2) : (i64, !llvm.ptr, i8) -> !llvm.ptr
    llvm.call @dummy(%6) : (!llvm.ptr) -> ()
    llvm.return
  }]

def array_new_align_nothrow_hot_cold_before := [llvmfunc|
  llvm.func @array_new_align_nothrow_hot_cold() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(10 : i64) : i64
    %2 = llvm.mlir.constant(8 : i64) : i64
    %3 = llvm.mlir.constant(7 : i8) : i8
    %4 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    %5 = llvm.call @_ZnamSt11align_val_tRKSt9nothrow_t12__hot_cold_t(%1, %2, %4, %3) : (i64, i64, !llvm.ptr, i8) -> !llvm.ptr
    llvm.call @dummy(%5) : (!llvm.ptr) -> ()
    %6 = llvm.call @_ZnamSt11align_val_tRKSt9nothrow_t12__hot_cold_t(%1, %2, %4, %3) : (i64, i64, !llvm.ptr, i8) -> !llvm.ptr
    llvm.call @dummy(%6) : (!llvm.ptr) -> ()
    %7 = llvm.call @_ZnamSt11align_val_tRKSt9nothrow_t12__hot_cold_t(%1, %2, %4, %3) : (i64, i64, !llvm.ptr, i8) -> !llvm.ptr
    llvm.call @dummy(%7) : (!llvm.ptr) -> ()
    llvm.return
  }]

def new_combined := [llvmfunc|
  llvm.func @new() {
    %0 = llvm.mlir.constant(10 : i64) : i64
    %1 = llvm.call @_Znwm(%0) : (i64) -> !llvm.ptr
    llvm.call @dummy(%1) : (!llvm.ptr) -> ()
    %2 = llvm.call @_Znwm(%0) : (i64) -> !llvm.ptr
    llvm.call @dummy(%2) : (!llvm.ptr) -> ()
    %3 = llvm.call @_Znwm(%0) : (i64) -> !llvm.ptr
    llvm.call @dummy(%3) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_new   : new_before  ⊑  new_combined := by
  unfold new_before new_combined
  simp_alive_peephole
  sorry
def new_align_combined := [llvmfunc|
  llvm.func @new_align() {
    %0 = llvm.mlir.constant(10 : i64) : i64
    %1 = llvm.mlir.constant(8 : i64) : i64
    %2 = llvm.call @_ZnwmSt11align_val_t(%0, %1) : (i64, i64) -> !llvm.ptr
    llvm.call @dummy(%2) : (!llvm.ptr) -> ()
    %3 = llvm.call @_ZnwmSt11align_val_t(%0, %1) : (i64, i64) -> !llvm.ptr
    llvm.call @dummy(%3) : (!llvm.ptr) -> ()
    %4 = llvm.call @_ZnwmSt11align_val_t(%0, %1) : (i64, i64) -> !llvm.ptr
    llvm.call @dummy(%4) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_new_align   : new_align_before  ⊑  new_align_combined := by
  unfold new_align_before new_align_combined
  simp_alive_peephole
  sorry
def new_nothrow_combined := [llvmfunc|
  llvm.func @new_nothrow() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(10 : i64) : i64
    %2 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_new_nothrow   : new_nothrow_before  ⊑  new_nothrow_combined := by
  unfold new_nothrow_before new_nothrow_combined
  simp_alive_peephole
  sorry
    %3 = llvm.call @_ZnwmRKSt9nothrow_t(%1, %2) : (i64, !llvm.ptr) -> !llvm.ptr
    llvm.call @dummy(%3) : (!llvm.ptr) -> ()
    %4 = llvm.call @_ZnwmRKSt9nothrow_t(%1, %2) : (i64, !llvm.ptr) -> !llvm.ptr
    llvm.call @dummy(%4) : (!llvm.ptr) -> ()
    %5 = llvm.call @_ZnwmRKSt9nothrow_t(%1, %2) : (i64, !llvm.ptr) -> !llvm.ptr
    llvm.call @dummy(%5) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_new_nothrow   : new_nothrow_before  ⊑  new_nothrow_combined := by
  unfold new_nothrow_before new_nothrow_combined
  simp_alive_peephole
  sorry
def new_align_nothrow_combined := [llvmfunc|
  llvm.func @new_align_nothrow() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(10 : i64) : i64
    %2 = llvm.mlir.constant(8 : i64) : i64
    %3 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_new_align_nothrow   : new_align_nothrow_before  ⊑  new_align_nothrow_combined := by
  unfold new_align_nothrow_before new_align_nothrow_combined
  simp_alive_peephole
  sorry
    %4 = llvm.call @_ZnwmSt11align_val_tRKSt9nothrow_t(%1, %2, %3) : (i64, i64, !llvm.ptr) -> !llvm.ptr
    llvm.call @dummy(%4) : (!llvm.ptr) -> ()
    %5 = llvm.call @_ZnwmSt11align_val_tRKSt9nothrow_t(%1, %2, %3) : (i64, i64, !llvm.ptr) -> !llvm.ptr
    llvm.call @dummy(%5) : (!llvm.ptr) -> ()
    %6 = llvm.call @_ZnwmSt11align_val_tRKSt9nothrow_t(%1, %2, %3) : (i64, i64, !llvm.ptr) -> !llvm.ptr
    llvm.call @dummy(%6) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_new_align_nothrow   : new_align_nothrow_before  ⊑  new_align_nothrow_combined := by
  unfold new_align_nothrow_before new_align_nothrow_combined
  simp_alive_peephole
  sorry
def array_new_combined := [llvmfunc|
  llvm.func @array_new() {
    %0 = llvm.mlir.constant(10 : i64) : i64
    %1 = llvm.call @_Znam(%0) : (i64) -> !llvm.ptr
    llvm.call @dummy(%1) : (!llvm.ptr) -> ()
    %2 = llvm.call @_Znam(%0) : (i64) -> !llvm.ptr
    llvm.call @dummy(%2) : (!llvm.ptr) -> ()
    %3 = llvm.call @_Znam(%0) : (i64) -> !llvm.ptr
    llvm.call @dummy(%3) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_array_new   : array_new_before  ⊑  array_new_combined := by
  unfold array_new_before array_new_combined
  simp_alive_peephole
  sorry
def array_new_align_combined := [llvmfunc|
  llvm.func @array_new_align() {
    %0 = llvm.mlir.constant(10 : i64) : i64
    %1 = llvm.mlir.constant(8 : i64) : i64
    %2 = llvm.call @_ZnamSt11align_val_t(%0, %1) : (i64, i64) -> !llvm.ptr
    llvm.call @dummy(%2) : (!llvm.ptr) -> ()
    %3 = llvm.call @_ZnamSt11align_val_t(%0, %1) : (i64, i64) -> !llvm.ptr
    llvm.call @dummy(%3) : (!llvm.ptr) -> ()
    %4 = llvm.call @_ZnamSt11align_val_t(%0, %1) : (i64, i64) -> !llvm.ptr
    llvm.call @dummy(%4) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_array_new_align   : array_new_align_before  ⊑  array_new_align_combined := by
  unfold array_new_align_before array_new_align_combined
  simp_alive_peephole
  sorry
def array_new_nothrow_combined := [llvmfunc|
  llvm.func @array_new_nothrow() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(10 : i64) : i64
    %2 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_array_new_nothrow   : array_new_nothrow_before  ⊑  array_new_nothrow_combined := by
  unfold array_new_nothrow_before array_new_nothrow_combined
  simp_alive_peephole
  sorry
    %3 = llvm.call @_ZnamRKSt9nothrow_t(%1, %2) : (i64, !llvm.ptr) -> !llvm.ptr
    llvm.call @dummy(%3) : (!llvm.ptr) -> ()
    %4 = llvm.call @_ZnamRKSt9nothrow_t(%1, %2) : (i64, !llvm.ptr) -> !llvm.ptr
    llvm.call @dummy(%4) : (!llvm.ptr) -> ()
    %5 = llvm.call @_ZnamRKSt9nothrow_t(%1, %2) : (i64, !llvm.ptr) -> !llvm.ptr
    llvm.call @dummy(%5) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_array_new_nothrow   : array_new_nothrow_before  ⊑  array_new_nothrow_combined := by
  unfold array_new_nothrow_before array_new_nothrow_combined
  simp_alive_peephole
  sorry
def array_new_align_nothrow_combined := [llvmfunc|
  llvm.func @array_new_align_nothrow() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(10 : i64) : i64
    %2 = llvm.mlir.constant(8 : i64) : i64
    %3 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_array_new_align_nothrow   : array_new_align_nothrow_before  ⊑  array_new_align_nothrow_combined := by
  unfold array_new_align_nothrow_before array_new_align_nothrow_combined
  simp_alive_peephole
  sorry
    %4 = llvm.call @_ZnamSt11align_val_tRKSt9nothrow_t(%1, %2, %3) : (i64, i64, !llvm.ptr) -> !llvm.ptr
    llvm.call @dummy(%4) : (!llvm.ptr) -> ()
    %5 = llvm.call @_ZnamSt11align_val_tRKSt9nothrow_t(%1, %2, %3) : (i64, i64, !llvm.ptr) -> !llvm.ptr
    llvm.call @dummy(%5) : (!llvm.ptr) -> ()
    %6 = llvm.call @_ZnamSt11align_val_tRKSt9nothrow_t(%1, %2, %3) : (i64, i64, !llvm.ptr) -> !llvm.ptr
    llvm.call @dummy(%6) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_array_new_align_nothrow   : array_new_align_nothrow_before  ⊑  array_new_align_nothrow_combined := by
  unfold array_new_align_nothrow_before array_new_align_nothrow_combined
  simp_alive_peephole
  sorry
def new_hot_cold_combined := [llvmfunc|
  llvm.func @new_hot_cold() {
    %0 = llvm.mlir.constant(10 : i64) : i64
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.call @_Znwm12__hot_cold_t(%0, %1) : (i64, i8) -> !llvm.ptr
    llvm.call @dummy(%2) : (!llvm.ptr) -> ()
    %3 = llvm.call @_Znwm12__hot_cold_t(%0, %1) : (i64, i8) -> !llvm.ptr
    llvm.call @dummy(%3) : (!llvm.ptr) -> ()
    %4 = llvm.call @_Znwm12__hot_cold_t(%0, %1) : (i64, i8) -> !llvm.ptr
    llvm.call @dummy(%4) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_new_hot_cold   : new_hot_cold_before  ⊑  new_hot_cold_combined := by
  unfold new_hot_cold_before new_hot_cold_combined
  simp_alive_peephole
  sorry
def new_align_hot_cold_combined := [llvmfunc|
  llvm.func @new_align_hot_cold() {
    %0 = llvm.mlir.constant(10 : i64) : i64
    %1 = llvm.mlir.constant(8 : i64) : i64
    %2 = llvm.mlir.constant(7 : i8) : i8
    %3 = llvm.call @_ZnwmSt11align_val_t12__hot_cold_t(%0, %1, %2) : (i64, i64, i8) -> !llvm.ptr
    llvm.call @dummy(%3) : (!llvm.ptr) -> ()
    %4 = llvm.call @_ZnwmSt11align_val_t12__hot_cold_t(%0, %1, %2) : (i64, i64, i8) -> !llvm.ptr
    llvm.call @dummy(%4) : (!llvm.ptr) -> ()
    %5 = llvm.call @_ZnwmSt11align_val_t12__hot_cold_t(%0, %1, %2) : (i64, i64, i8) -> !llvm.ptr
    llvm.call @dummy(%5) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_new_align_hot_cold   : new_align_hot_cold_before  ⊑  new_align_hot_cold_combined := by
  unfold new_align_hot_cold_before new_align_hot_cold_combined
  simp_alive_peephole
  sorry
def new_nothrow_hot_cold_combined := [llvmfunc|
  llvm.func @new_nothrow_hot_cold() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(10 : i64) : i64
    %2 = llvm.mlir.constant(7 : i8) : i8
    %3 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_new_nothrow_hot_cold   : new_nothrow_hot_cold_before  ⊑  new_nothrow_hot_cold_combined := by
  unfold new_nothrow_hot_cold_before new_nothrow_hot_cold_combined
  simp_alive_peephole
  sorry
    %4 = llvm.call @_ZnwmRKSt9nothrow_t12__hot_cold_t(%1, %3, %2) : (i64, !llvm.ptr, i8) -> !llvm.ptr
    llvm.call @dummy(%4) : (!llvm.ptr) -> ()
    %5 = llvm.call @_ZnwmRKSt9nothrow_t12__hot_cold_t(%1, %3, %2) : (i64, !llvm.ptr, i8) -> !llvm.ptr
    llvm.call @dummy(%5) : (!llvm.ptr) -> ()
    %6 = llvm.call @_ZnwmRKSt9nothrow_t12__hot_cold_t(%1, %3, %2) : (i64, !llvm.ptr, i8) -> !llvm.ptr
    llvm.call @dummy(%6) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_new_nothrow_hot_cold   : new_nothrow_hot_cold_before  ⊑  new_nothrow_hot_cold_combined := by
  unfold new_nothrow_hot_cold_before new_nothrow_hot_cold_combined
  simp_alive_peephole
  sorry
def new_align_nothrow_hot_cold_combined := [llvmfunc|
  llvm.func @new_align_nothrow_hot_cold() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(10 : i64) : i64
    %2 = llvm.mlir.constant(8 : i64) : i64
    %3 = llvm.mlir.constant(7 : i8) : i8
    %4 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_new_align_nothrow_hot_cold   : new_align_nothrow_hot_cold_before  ⊑  new_align_nothrow_hot_cold_combined := by
  unfold new_align_nothrow_hot_cold_before new_align_nothrow_hot_cold_combined
  simp_alive_peephole
  sorry
    %5 = llvm.call @_ZnwmSt11align_val_tRKSt9nothrow_t12__hot_cold_t(%1, %2, %4, %3) : (i64, i64, !llvm.ptr, i8) -> !llvm.ptr
    llvm.call @dummy(%5) : (!llvm.ptr) -> ()
    %6 = llvm.call @_ZnwmSt11align_val_tRKSt9nothrow_t12__hot_cold_t(%1, %2, %4, %3) : (i64, i64, !llvm.ptr, i8) -> !llvm.ptr
    llvm.call @dummy(%6) : (!llvm.ptr) -> ()
    %7 = llvm.call @_ZnwmSt11align_val_tRKSt9nothrow_t12__hot_cold_t(%1, %2, %4, %3) : (i64, i64, !llvm.ptr, i8) -> !llvm.ptr
    llvm.call @dummy(%7) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_new_align_nothrow_hot_cold   : new_align_nothrow_hot_cold_before  ⊑  new_align_nothrow_hot_cold_combined := by
  unfold new_align_nothrow_hot_cold_before new_align_nothrow_hot_cold_combined
  simp_alive_peephole
  sorry
def array_new_hot_cold_combined := [llvmfunc|
  llvm.func @array_new_hot_cold() {
    %0 = llvm.mlir.constant(10 : i64) : i64
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.call @_Znam12__hot_cold_t(%0, %1) : (i64, i8) -> !llvm.ptr
    llvm.call @dummy(%2) : (!llvm.ptr) -> ()
    %3 = llvm.call @_Znam12__hot_cold_t(%0, %1) : (i64, i8) -> !llvm.ptr
    llvm.call @dummy(%3) : (!llvm.ptr) -> ()
    %4 = llvm.call @_Znam12__hot_cold_t(%0, %1) : (i64, i8) -> !llvm.ptr
    llvm.call @dummy(%4) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_array_new_hot_cold   : array_new_hot_cold_before  ⊑  array_new_hot_cold_combined := by
  unfold array_new_hot_cold_before array_new_hot_cold_combined
  simp_alive_peephole
  sorry
def array_new_align_hot_cold_combined := [llvmfunc|
  llvm.func @array_new_align_hot_cold() {
    %0 = llvm.mlir.constant(10 : i64) : i64
    %1 = llvm.mlir.constant(8 : i64) : i64
    %2 = llvm.mlir.constant(7 : i8) : i8
    %3 = llvm.call @_ZnamSt11align_val_t12__hot_cold_t(%0, %1, %2) : (i64, i64, i8) -> !llvm.ptr
    llvm.call @dummy(%3) : (!llvm.ptr) -> ()
    %4 = llvm.call @_ZnamSt11align_val_t12__hot_cold_t(%0, %1, %2) : (i64, i64, i8) -> !llvm.ptr
    llvm.call @dummy(%4) : (!llvm.ptr) -> ()
    %5 = llvm.call @_ZnamSt11align_val_t12__hot_cold_t(%0, %1, %2) : (i64, i64, i8) -> !llvm.ptr
    llvm.call @dummy(%5) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_array_new_align_hot_cold   : array_new_align_hot_cold_before  ⊑  array_new_align_hot_cold_combined := by
  unfold array_new_align_hot_cold_before array_new_align_hot_cold_combined
  simp_alive_peephole
  sorry
def array_new_nothrow_hot_cold_combined := [llvmfunc|
  llvm.func @array_new_nothrow_hot_cold() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(10 : i64) : i64
    %2 = llvm.mlir.constant(7 : i8) : i8
    %3 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_array_new_nothrow_hot_cold   : array_new_nothrow_hot_cold_before  ⊑  array_new_nothrow_hot_cold_combined := by
  unfold array_new_nothrow_hot_cold_before array_new_nothrow_hot_cold_combined
  simp_alive_peephole
  sorry
    %4 = llvm.call @_ZnamRKSt9nothrow_t12__hot_cold_t(%1, %3, %2) : (i64, !llvm.ptr, i8) -> !llvm.ptr
    llvm.call @dummy(%4) : (!llvm.ptr) -> ()
    %5 = llvm.call @_ZnamRKSt9nothrow_t12__hot_cold_t(%1, %3, %2) : (i64, !llvm.ptr, i8) -> !llvm.ptr
    llvm.call @dummy(%5) : (!llvm.ptr) -> ()
    %6 = llvm.call @_ZnamRKSt9nothrow_t12__hot_cold_t(%1, %3, %2) : (i64, !llvm.ptr, i8) -> !llvm.ptr
    llvm.call @dummy(%6) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_array_new_nothrow_hot_cold   : array_new_nothrow_hot_cold_before  ⊑  array_new_nothrow_hot_cold_combined := by
  unfold array_new_nothrow_hot_cold_before array_new_nothrow_hot_cold_combined
  simp_alive_peephole
  sorry
def array_new_align_nothrow_hot_cold_combined := [llvmfunc|
  llvm.func @array_new_align_nothrow_hot_cold() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(10 : i64) : i64
    %2 = llvm.mlir.constant(8 : i64) : i64
    %3 = llvm.mlir.constant(7 : i8) : i8
    %4 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_array_new_align_nothrow_hot_cold   : array_new_align_nothrow_hot_cold_before  ⊑  array_new_align_nothrow_hot_cold_combined := by
  unfold array_new_align_nothrow_hot_cold_before array_new_align_nothrow_hot_cold_combined
  simp_alive_peephole
  sorry
    %5 = llvm.call @_ZnamSt11align_val_tRKSt9nothrow_t12__hot_cold_t(%1, %2, %4, %3) : (i64, i64, !llvm.ptr, i8) -> !llvm.ptr
    llvm.call @dummy(%5) : (!llvm.ptr) -> ()
    %6 = llvm.call @_ZnamSt11align_val_tRKSt9nothrow_t12__hot_cold_t(%1, %2, %4, %3) : (i64, i64, !llvm.ptr, i8) -> !llvm.ptr
    llvm.call @dummy(%6) : (!llvm.ptr) -> ()
    %7 = llvm.call @_ZnamSt11align_val_tRKSt9nothrow_t12__hot_cold_t(%1, %2, %4, %3) : (i64, i64, !llvm.ptr, i8) -> !llvm.ptr
    llvm.call @dummy(%7) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_array_new_align_nothrow_hot_cold   : array_new_align_nothrow_hot_cold_before  ⊑  array_new_align_nothrow_hot_cold_combined := by
  unfold array_new_align_nothrow_hot_cold_before array_new_align_nothrow_hot_cold_combined
  simp_alive_peephole
  sorry
