import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  load-bitcast-select
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def _Z3foov_before := [llvmfunc|
  llvm.func @_Z3foov() {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1000 : i32) : i32
    %2 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %3 = llvm.mlir.constant(dense<0.000000e+00> : tensor<1000xf32>) : !llvm.array<1000 x f32>
    %4 = llvm.mlir.addressof @a : !llvm.ptr
    %5 = llvm.mlir.constant(0 : i64) : i64
    %6 = llvm.mlir.addressof @b : !llvm.ptr
    %7 = llvm.mlir.constant(1 : i32) : i32
    llvm.br ^bb1(%0 : i32)
  ^bb1(%8: i32):  // 2 preds: ^bb0, ^bb3
    %9 = llvm.icmp "ult" %8, %1 : i32
    llvm.cond_br %9, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return
  ^bb3:  // pred: ^bb1
    %10 = llvm.zext %8 : i32 to i64
    %11 = llvm.getelementptr inbounds %4[%5, %10] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<1000 x f32>
    %12 = llvm.getelementptr inbounds %6[%5, %10] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<1000 x f32>
    %13 = llvm.load %11 {alignment = 4 : i64} : !llvm.ptr -> f32]

    %14 = llvm.load %12 {alignment = 4 : i64} : !llvm.ptr -> f32]

    %15 = llvm.fcmp "olt" %13, %14 {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %16 = llvm.select %15, %12, %11 : i1, !llvm.ptr
    %17 = llvm.load %16 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.store %17, %11 {alignment = 4 : i64} : i32, !llvm.ptr]

    %18 = llvm.add %8, %7 overflow<nsw, nuw>  : i32
    llvm.br ^bb1(%18 : i32)
  }]

def store_bitcasted_load_before := [llvmfunc|
  llvm.func @store_bitcasted_load(%arg0: i1, %arg1: !llvm.ptr {llvm.dereferenceable = 4 : i64}, %arg2: !llvm.ptr {llvm.dereferenceable = 4 : i64}) -> i32 {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, !llvm.ptr
    %1 = llvm.load %0 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %1 : i32
  }]

def bitcasted_store_before := [llvmfunc|
  llvm.func @bitcasted_store(%arg0: i1, %arg1: !llvm.ptr, %arg2: !llvm.ptr, %arg3: !llvm.ptr) {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, !llvm.ptr
    %1 = llvm.load %0 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.store %1, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def bitcasted_minmax_with_select_of_pointers_before := [llvmfunc|
  llvm.func @bitcasted_minmax_with_select_of_pointers(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: !llvm.ptr) {
    %0 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> f32]

    %1 = llvm.load %arg1 {alignment = 4 : i64} : !llvm.ptr -> f32]

    %2 = llvm.fcmp "ogt" %0, %1 : f32
    %3 = llvm.select %2, %arg0, %arg1 : i1, !llvm.ptr
    %4 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.store %4, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def _Z3foov_combined := [llvmfunc|
  llvm.func @_Z3foov() {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1000 : i32) : i32
    %2 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %3 = llvm.mlir.constant(dense<0.000000e+00> : tensor<1000xf32>) : !llvm.array<1000 x f32>
    %4 = llvm.mlir.addressof @a : !llvm.ptr
    %5 = llvm.mlir.constant(0 : i64) : i64
    %6 = llvm.mlir.addressof @b : !llvm.ptr
    %7 = llvm.mlir.constant(1 : i32) : i32
    llvm.br ^bb1(%0 : i32)
  ^bb1(%8: i32):  // 2 preds: ^bb0, ^bb3
    %9 = llvm.icmp "ult" %8, %1 : i32
    llvm.cond_br %9, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return
  ^bb3:  // pred: ^bb1
    %10 = llvm.zext %8 : i32 to i64
    %11 = llvm.getelementptr inbounds %4[%5, %10] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<1000 x f32>
    %12 = llvm.getelementptr inbounds %6[%5, %10] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<1000 x f32>
    %13 = llvm.load %11 {alignment = 4 : i64} : !llvm.ptr -> f32]

theorem inst_combine__Z3foov   : _Z3foov_before  ⊑  _Z3foov_combined := by
  unfold _Z3foov_before _Z3foov_combined
  simp_alive_peephole
  sorry
    %14 = llvm.load %12 {alignment = 4 : i64} : !llvm.ptr -> f32]

theorem inst_combine__Z3foov   : _Z3foov_before  ⊑  _Z3foov_combined := by
  unfold _Z3foov_before _Z3foov_combined
  simp_alive_peephole
  sorry
    %15 = llvm.fcmp "olt" %13, %14 {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine__Z3foov   : _Z3foov_before  ⊑  _Z3foov_combined := by
  unfold _Z3foov_before _Z3foov_combined
  simp_alive_peephole
  sorry
    %16 = llvm.select %15, %14, %13 : i1, f32
    llvm.store %16, %11 {alignment = 4 : i64} : f32, !llvm.ptr]

theorem inst_combine__Z3foov   : _Z3foov_before  ⊑  _Z3foov_combined := by
  unfold _Z3foov_before _Z3foov_combined
  simp_alive_peephole
  sorry
    %17 = llvm.add %8, %7 overflow<nsw, nuw>  : i32
    llvm.br ^bb1(%17 : i32)
  }]

theorem inst_combine__Z3foov   : _Z3foov_before  ⊑  _Z3foov_combined := by
  unfold _Z3foov_before _Z3foov_combined
  simp_alive_peephole
  sorry
def store_bitcasted_load_combined := [llvmfunc|
  llvm.func @store_bitcasted_load(%arg0: i1, %arg1: !llvm.ptr {llvm.dereferenceable = 4 : i64}, %arg2: !llvm.ptr {llvm.dereferenceable = 4 : i64}) -> i32 {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, !llvm.ptr
    %1 = llvm.load %0 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_store_bitcasted_load   : store_bitcasted_load_before  ⊑  store_bitcasted_load_combined := by
  unfold store_bitcasted_load_before store_bitcasted_load_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i32
  }]

theorem inst_combine_store_bitcasted_load   : store_bitcasted_load_before  ⊑  store_bitcasted_load_combined := by
  unfold store_bitcasted_load_before store_bitcasted_load_combined
  simp_alive_peephole
  sorry
def bitcasted_store_combined := [llvmfunc|
  llvm.func @bitcasted_store(%arg0: i1, %arg1: !llvm.ptr, %arg2: !llvm.ptr, %arg3: !llvm.ptr) {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, !llvm.ptr
    %1 = llvm.load %0 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_bitcasted_store   : bitcasted_store_before  ⊑  bitcasted_store_combined := by
  unfold bitcasted_store_before bitcasted_store_combined
  simp_alive_peephole
  sorry
    llvm.store %1, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_bitcasted_store   : bitcasted_store_before  ⊑  bitcasted_store_combined := by
  unfold bitcasted_store_before bitcasted_store_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_bitcasted_store   : bitcasted_store_before  ⊑  bitcasted_store_combined := by
  unfold bitcasted_store_before bitcasted_store_combined
  simp_alive_peephole
  sorry
def bitcasted_minmax_with_select_of_pointers_combined := [llvmfunc|
  llvm.func @bitcasted_minmax_with_select_of_pointers(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: !llvm.ptr) {
    %0 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> f32]

theorem inst_combine_bitcasted_minmax_with_select_of_pointers   : bitcasted_minmax_with_select_of_pointers_before  ⊑  bitcasted_minmax_with_select_of_pointers_combined := by
  unfold bitcasted_minmax_with_select_of_pointers_before bitcasted_minmax_with_select_of_pointers_combined
  simp_alive_peephole
  sorry
    %1 = llvm.load %arg1 {alignment = 4 : i64} : !llvm.ptr -> f32]

theorem inst_combine_bitcasted_minmax_with_select_of_pointers   : bitcasted_minmax_with_select_of_pointers_before  ⊑  bitcasted_minmax_with_select_of_pointers_combined := by
  unfold bitcasted_minmax_with_select_of_pointers_before bitcasted_minmax_with_select_of_pointers_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fcmp "ogt" %0, %1 : f32
    %3 = llvm.select %2, %0, %1 : i1, f32
    llvm.store %3, %arg2 {alignment = 4 : i64} : f32, !llvm.ptr]

theorem inst_combine_bitcasted_minmax_with_select_of_pointers   : bitcasted_minmax_with_select_of_pointers_before  ⊑  bitcasted_minmax_with_select_of_pointers_combined := by
  unfold bitcasted_minmax_with_select_of_pointers_before bitcasted_minmax_with_select_of_pointers_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_bitcasted_minmax_with_select_of_pointers   : bitcasted_minmax_with_select_of_pointers_before  ⊑  bitcasted_minmax_with_select_of_pointers_combined := by
  unfold bitcasted_minmax_with_select_of_pointers_before bitcasted_minmax_with_select_of_pointers_combined
  simp_alive_peephole
  sorry
