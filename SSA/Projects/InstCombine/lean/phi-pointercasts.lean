import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  phi-pointercasts
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_bitcast_1_before := [llvmfunc|
  llvm.func @test_bitcast_1(%arg0: i1, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @use(%arg1) : (!llvm.ptr) -> ()
    llvm.br ^bb3(%arg1 : !llvm.ptr)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg1 : !llvm.ptr)
  ^bb3(%1: !llvm.ptr):  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %1 {alignment = 1 : i64} : i8, !llvm.ptr]

    llvm.return
  }]

def test_bitcast_2_before := [llvmfunc|
  llvm.func @test_bitcast_2(%arg0: i1, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg1 : !llvm.ptr)
  ^bb2:  // pred: ^bb0
    llvm.call @use(%arg1) : (!llvm.ptr) -> ()
    llvm.br ^bb3(%arg1 : !llvm.ptr)
  ^bb3(%1: !llvm.ptr):  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %1 {alignment = 1 : i64} : i8, !llvm.ptr]

    llvm.return
  }]

def test_bitcast_3_before := [llvmfunc|
  llvm.func @test_bitcast_3(%arg0: i1, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.load %arg1 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%1 : !llvm.ptr)
  ^bb2:  // pred: ^bb0
    llvm.call @use(%1) : (!llvm.ptr) -> ()
    llvm.br ^bb3(%1 : !llvm.ptr)
  ^bb3(%2: !llvm.ptr):  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %2 {alignment = 1 : i64} : i8, !llvm.ptr]

    llvm.return
  }]

def test_bitcast_loads_in_different_bbs_before := [llvmfunc|
  llvm.func @test_bitcast_loads_in_different_bbs(%arg0: i1, %arg1: !llvm.ptr, %arg2: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.load %arg1 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    llvm.call @use(%1) : (!llvm.ptr) -> ()
    llvm.br ^bb3(%1 : !llvm.ptr)
  ^bb2:  // pred: ^bb0
    %2 = llvm.load %arg2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    llvm.br ^bb3(%2 : !llvm.ptr)
  ^bb3(%3: !llvm.ptr):  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %3 {alignment = 1 : i64} : i8, !llvm.ptr]

    llvm.return
  }]

def test_gep_1_before := [llvmfunc|
  llvm.func @test_gep_1(%arg0: i1, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @use.i32(%arg1) : (!llvm.ptr) -> ()
    llvm.br ^bb3(%arg1 : !llvm.ptr)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg1 : !llvm.ptr)
  ^bb3(%1: !llvm.ptr):  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %1 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def test_bitcast_not_foldable_before := [llvmfunc|
  llvm.func @test_bitcast_not_foldable(%arg0: i1, %arg1: !llvm.ptr, %arg2: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg1 : !llvm.ptr)
  ^bb2:  // pred: ^bb0
    llvm.call @use(%arg2) : (!llvm.ptr) -> ()
    llvm.br ^bb3(%arg2 : !llvm.ptr)
  ^bb3(%1: !llvm.ptr):  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %1 {alignment = 1 : i64} : i8, !llvm.ptr]

    llvm.return
  }]

def test_bitcast_with_extra_use_before := [llvmfunc|
  llvm.func @test_bitcast_with_extra_use(%arg0: i1, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @use(%arg1) : (!llvm.ptr) -> ()
    llvm.br ^bb3(%arg1 : !llvm.ptr)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg1 : !llvm.ptr)
  ^bb3(%1: !llvm.ptr):  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %1 {alignment = 1 : i64} : i8, !llvm.ptr]

    llvm.return
  }]

def test_bitcast_different_bases_before := [llvmfunc|
  llvm.func @test_bitcast_different_bases(%arg0: i1, %arg1: !llvm.ptr, %arg2: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @use(%arg1) : (!llvm.ptr) -> ()
    llvm.br ^bb3(%arg1 : !llvm.ptr)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg2 : !llvm.ptr)
  ^bb3(%1: !llvm.ptr):  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %1 {alignment = 1 : i64} : i8, !llvm.ptr]

    llvm.return
  }]

def test_bitcast_gep_chains_before := [llvmfunc|
  llvm.func @test_bitcast_gep_chains(%arg0: i1, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @use(%arg1) : (!llvm.ptr) -> ()
    llvm.br ^bb3(%arg1 : !llvm.ptr)
  ^bb2:  // pred: ^bb0
    llvm.call @use.i32(%arg1) : (!llvm.ptr) -> ()
    llvm.br ^bb3(%arg1 : !llvm.ptr)
  ^bb3(%1: !llvm.ptr):  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %1 {alignment = 1 : i64} : i8, !llvm.ptr]

    llvm.return
  }]

def test_4_incoming_values_different_bases_1_before := [llvmfunc|
  llvm.func @test_4_incoming_values_different_bases_1(%arg0: i32, %arg1: !llvm.ptr, %arg2: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.switch %arg0 : i32, ^bb6 [
      0: ^bb1,
      1: ^bb2,
      2: ^bb3,
      3: ^bb4
    ]
  ^bb1:  // pred: ^bb0
    llvm.call @use(%arg1) : (!llvm.ptr) -> ()
    llvm.br ^bb5(%arg1 : !llvm.ptr)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb5(%arg2 : !llvm.ptr)
  ^bb3:  // pred: ^bb0
    llvm.br ^bb5(%arg1 : !llvm.ptr)
  ^bb4:  // pred: ^bb0
    llvm.br ^bb5(%arg1 : !llvm.ptr)
  ^bb5(%1: !llvm.ptr):  // 4 preds: ^bb1, ^bb2, ^bb3, ^bb4
    llvm.store %0, %1 {alignment = 1 : i64} : i8, !llvm.ptr]

    llvm.return
  ^bb6:  // pred: ^bb0
    llvm.return
  }]

def test_4_incoming_values_different_bases_2_before := [llvmfunc|
  llvm.func @test_4_incoming_values_different_bases_2(%arg0: i32, %arg1: !llvm.ptr, %arg2: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.switch %arg0 : i32, ^bb6 [
      0: ^bb1,
      1: ^bb2,
      2: ^bb3,
      3: ^bb4
    ]
  ^bb1:  // pred: ^bb0
    llvm.br ^bb5(%arg2 : !llvm.ptr)
  ^bb2:  // pred: ^bb0
    llvm.call @use(%arg1) : (!llvm.ptr) -> ()
    llvm.br ^bb5(%arg1 : !llvm.ptr)
  ^bb3:  // pred: ^bb0
    llvm.br ^bb5(%arg1 : !llvm.ptr)
  ^bb4:  // pred: ^bb0
    llvm.br ^bb5(%arg1 : !llvm.ptr)
  ^bb5(%1: !llvm.ptr):  // 4 preds: ^bb1, ^bb2, ^bb3, ^bb4
    llvm.store %0, %1 {alignment = 1 : i64} : i8, !llvm.ptr]

    llvm.return
  ^bb6:  // pred: ^bb0
    llvm.return
  }]

def test_4_incoming_values_different_bases_3_before := [llvmfunc|
  llvm.func @test_4_incoming_values_different_bases_3(%arg0: i32, %arg1: !llvm.ptr, %arg2: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.switch %arg0 : i32, ^bb6 [
      0: ^bb1,
      1: ^bb2,
      2: ^bb3,
      3: ^bb4
    ]
  ^bb1:  // pred: ^bb0
    llvm.br ^bb5(%arg1 : !llvm.ptr)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb5(%arg1 : !llvm.ptr)
  ^bb3:  // pred: ^bb0
    llvm.call @use(%arg1) : (!llvm.ptr) -> ()
    llvm.br ^bb5(%arg1 : !llvm.ptr)
  ^bb4:  // pred: ^bb0
    llvm.br ^bb5(%arg2 : !llvm.ptr)
  ^bb5(%1: !llvm.ptr):  // 4 preds: ^bb1, ^bb2, ^bb3, ^bb4
    llvm.store %0, %1 {alignment = 1 : i64} : i8, !llvm.ptr]

    llvm.return
  ^bb6:  // pred: ^bb0
    llvm.return
  }]

def test_addrspacecast_1_before := [llvmfunc|
  llvm.func @test_addrspacecast_1(%arg0: i1, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.addrspacecast %arg1 : !llvm.ptr to !llvm.ptr<1>
    %2 = llvm.addrspacecast %arg1 : !llvm.ptr to !llvm.ptr<1>
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%1 : !llvm.ptr<1>)
  ^bb2:  // pred: ^bb0
    llvm.call @use.i8.addrspace1(%2) : (!llvm.ptr<1>) -> ()
    llvm.br ^bb3(%2 : !llvm.ptr<1>)
  ^bb3(%3: !llvm.ptr<1>):  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %3 {alignment = 1 : i64} : i8, !llvm.ptr<1>]

    llvm.return
  }]

def test_bitcast_1_combined := [llvmfunc|
  llvm.func @test_bitcast_1(%arg0: i1, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @use(%arg1) : (!llvm.ptr) -> ()
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %arg1 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_test_bitcast_1   : test_bitcast_1_before  ⊑  test_bitcast_1_combined := by
  unfold test_bitcast_1_before test_bitcast_1_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test_bitcast_1   : test_bitcast_1_before  ⊑  test_bitcast_1_combined := by
  unfold test_bitcast_1_before test_bitcast_1_combined
  simp_alive_peephole
  sorry
def test_bitcast_2_combined := [llvmfunc|
  llvm.func @test_bitcast_2(%arg0: i1, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.call @use(%arg1) : (!llvm.ptr) -> ()
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %arg1 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_test_bitcast_2   : test_bitcast_2_before  ⊑  test_bitcast_2_combined := by
  unfold test_bitcast_2_before test_bitcast_2_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test_bitcast_2   : test_bitcast_2_before  ⊑  test_bitcast_2_combined := by
  unfold test_bitcast_2_before test_bitcast_2_combined
  simp_alive_peephole
  sorry
def test_bitcast_3_combined := [llvmfunc|
  llvm.func @test_bitcast_3(%arg0: i1, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.load %arg1 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

theorem inst_combine_test_bitcast_3   : test_bitcast_3_before  ⊑  test_bitcast_3_combined := by
  unfold test_bitcast_3_before test_bitcast_3_combined
  simp_alive_peephole
  sorry
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.call @use(%1) : (!llvm.ptr) -> ()
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %1 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_test_bitcast_3   : test_bitcast_3_before  ⊑  test_bitcast_3_combined := by
  unfold test_bitcast_3_before test_bitcast_3_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test_bitcast_3   : test_bitcast_3_before  ⊑  test_bitcast_3_combined := by
  unfold test_bitcast_3_before test_bitcast_3_combined
  simp_alive_peephole
  sorry
def test_bitcast_loads_in_different_bbs_combined := [llvmfunc|
  llvm.func @test_bitcast_loads_in_different_bbs(%arg0: i1, %arg1: !llvm.ptr, %arg2: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.load %arg1 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

theorem inst_combine_test_bitcast_loads_in_different_bbs   : test_bitcast_loads_in_different_bbs_before  ⊑  test_bitcast_loads_in_different_bbs_combined := by
  unfold test_bitcast_loads_in_different_bbs_before test_bitcast_loads_in_different_bbs_combined
  simp_alive_peephole
  sorry
    llvm.call @use(%1) : (!llvm.ptr) -> ()
    llvm.br ^bb3(%1 : !llvm.ptr)
  ^bb2:  // pred: ^bb0
    %2 = llvm.load %arg2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

theorem inst_combine_test_bitcast_loads_in_different_bbs   : test_bitcast_loads_in_different_bbs_before  ⊑  test_bitcast_loads_in_different_bbs_combined := by
  unfold test_bitcast_loads_in_different_bbs_before test_bitcast_loads_in_different_bbs_combined
  simp_alive_peephole
  sorry
    llvm.br ^bb3(%2 : !llvm.ptr)
  ^bb3(%3: !llvm.ptr):  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %3 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_test_bitcast_loads_in_different_bbs   : test_bitcast_loads_in_different_bbs_before  ⊑  test_bitcast_loads_in_different_bbs_combined := by
  unfold test_bitcast_loads_in_different_bbs_before test_bitcast_loads_in_different_bbs_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test_bitcast_loads_in_different_bbs   : test_bitcast_loads_in_different_bbs_before  ⊑  test_bitcast_loads_in_different_bbs_combined := by
  unfold test_bitcast_loads_in_different_bbs_before test_bitcast_loads_in_different_bbs_combined
  simp_alive_peephole
  sorry
def test_gep_1_combined := [llvmfunc|
  llvm.func @test_gep_1(%arg0: i1, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @use.i32(%arg1) : (!llvm.ptr) -> ()
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_test_gep_1   : test_gep_1_before  ⊑  test_gep_1_combined := by
  unfold test_gep_1_before test_gep_1_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test_gep_1   : test_gep_1_before  ⊑  test_gep_1_combined := by
  unfold test_gep_1_before test_gep_1_combined
  simp_alive_peephole
  sorry
def test_bitcast_not_foldable_combined := [llvmfunc|
  llvm.func @test_bitcast_not_foldable(%arg0: i1, %arg1: !llvm.ptr, %arg2: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg1 : !llvm.ptr)
  ^bb2:  // pred: ^bb0
    llvm.call @use(%arg2) : (!llvm.ptr) -> ()
    llvm.br ^bb3(%arg2 : !llvm.ptr)
  ^bb3(%1: !llvm.ptr):  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %1 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_test_bitcast_not_foldable   : test_bitcast_not_foldable_before  ⊑  test_bitcast_not_foldable_combined := by
  unfold test_bitcast_not_foldable_before test_bitcast_not_foldable_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test_bitcast_not_foldable   : test_bitcast_not_foldable_before  ⊑  test_bitcast_not_foldable_combined := by
  unfold test_bitcast_not_foldable_before test_bitcast_not_foldable_combined
  simp_alive_peephole
  sorry
def test_bitcast_with_extra_use_combined := [llvmfunc|
  llvm.func @test_bitcast_with_extra_use(%arg0: i1, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @use(%arg1) : (!llvm.ptr) -> ()
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %arg1 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_test_bitcast_with_extra_use   : test_bitcast_with_extra_use_before  ⊑  test_bitcast_with_extra_use_combined := by
  unfold test_bitcast_with_extra_use_before test_bitcast_with_extra_use_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test_bitcast_with_extra_use   : test_bitcast_with_extra_use_before  ⊑  test_bitcast_with_extra_use_combined := by
  unfold test_bitcast_with_extra_use_before test_bitcast_with_extra_use_combined
  simp_alive_peephole
  sorry
def test_bitcast_different_bases_combined := [llvmfunc|
  llvm.func @test_bitcast_different_bases(%arg0: i1, %arg1: !llvm.ptr, %arg2: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @use(%arg1) : (!llvm.ptr) -> ()
    llvm.br ^bb3(%arg1 : !llvm.ptr)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg2 : !llvm.ptr)
  ^bb3(%1: !llvm.ptr):  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %1 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_test_bitcast_different_bases   : test_bitcast_different_bases_before  ⊑  test_bitcast_different_bases_combined := by
  unfold test_bitcast_different_bases_before test_bitcast_different_bases_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test_bitcast_different_bases   : test_bitcast_different_bases_before  ⊑  test_bitcast_different_bases_combined := by
  unfold test_bitcast_different_bases_before test_bitcast_different_bases_combined
  simp_alive_peephole
  sorry
def test_bitcast_gep_chains_combined := [llvmfunc|
  llvm.func @test_bitcast_gep_chains(%arg0: i1, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @use(%arg1) : (!llvm.ptr) -> ()
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.call @use.i32(%arg1) : (!llvm.ptr) -> ()
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %arg1 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_test_bitcast_gep_chains   : test_bitcast_gep_chains_before  ⊑  test_bitcast_gep_chains_combined := by
  unfold test_bitcast_gep_chains_before test_bitcast_gep_chains_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test_bitcast_gep_chains   : test_bitcast_gep_chains_before  ⊑  test_bitcast_gep_chains_combined := by
  unfold test_bitcast_gep_chains_before test_bitcast_gep_chains_combined
  simp_alive_peephole
  sorry
def test_4_incoming_values_different_bases_1_combined := [llvmfunc|
  llvm.func @test_4_incoming_values_different_bases_1(%arg0: i32, %arg1: !llvm.ptr, %arg2: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.switch %arg0 : i32, ^bb6 [
      0: ^bb1,
      1: ^bb2,
      2: ^bb3,
      3: ^bb4
    ]
  ^bb1:  // pred: ^bb0
    llvm.call @use(%arg1) : (!llvm.ptr) -> ()
    llvm.br ^bb5(%arg1 : !llvm.ptr)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb5(%arg2 : !llvm.ptr)
  ^bb3:  // pred: ^bb0
    llvm.br ^bb5(%arg1 : !llvm.ptr)
  ^bb4:  // pred: ^bb0
    llvm.br ^bb5(%arg1 : !llvm.ptr)
  ^bb5(%1: !llvm.ptr):  // 4 preds: ^bb1, ^bb2, ^bb3, ^bb4
    llvm.store %0, %1 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_test_4_incoming_values_different_bases_1   : test_4_incoming_values_different_bases_1_before  ⊑  test_4_incoming_values_different_bases_1_combined := by
  unfold test_4_incoming_values_different_bases_1_before test_4_incoming_values_different_bases_1_combined
  simp_alive_peephole
  sorry
    llvm.return
  ^bb6:  // pred: ^bb0
    llvm.return
  }]

theorem inst_combine_test_4_incoming_values_different_bases_1   : test_4_incoming_values_different_bases_1_before  ⊑  test_4_incoming_values_different_bases_1_combined := by
  unfold test_4_incoming_values_different_bases_1_before test_4_incoming_values_different_bases_1_combined
  simp_alive_peephole
  sorry
def test_4_incoming_values_different_bases_2_combined := [llvmfunc|
  llvm.func @test_4_incoming_values_different_bases_2(%arg0: i32, %arg1: !llvm.ptr, %arg2: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.switch %arg0 : i32, ^bb6 [
      0: ^bb1,
      1: ^bb2,
      2: ^bb3,
      3: ^bb4
    ]
  ^bb1:  // pred: ^bb0
    llvm.br ^bb5(%arg2 : !llvm.ptr)
  ^bb2:  // pred: ^bb0
    llvm.call @use(%arg1) : (!llvm.ptr) -> ()
    llvm.br ^bb5(%arg1 : !llvm.ptr)
  ^bb3:  // pred: ^bb0
    llvm.br ^bb5(%arg1 : !llvm.ptr)
  ^bb4:  // pred: ^bb0
    llvm.br ^bb5(%arg1 : !llvm.ptr)
  ^bb5(%1: !llvm.ptr):  // 4 preds: ^bb1, ^bb2, ^bb3, ^bb4
    llvm.store %0, %1 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_test_4_incoming_values_different_bases_2   : test_4_incoming_values_different_bases_2_before  ⊑  test_4_incoming_values_different_bases_2_combined := by
  unfold test_4_incoming_values_different_bases_2_before test_4_incoming_values_different_bases_2_combined
  simp_alive_peephole
  sorry
    llvm.return
  ^bb6:  // pred: ^bb0
    llvm.return
  }]

theorem inst_combine_test_4_incoming_values_different_bases_2   : test_4_incoming_values_different_bases_2_before  ⊑  test_4_incoming_values_different_bases_2_combined := by
  unfold test_4_incoming_values_different_bases_2_before test_4_incoming_values_different_bases_2_combined
  simp_alive_peephole
  sorry
def test_4_incoming_values_different_bases_3_combined := [llvmfunc|
  llvm.func @test_4_incoming_values_different_bases_3(%arg0: i32, %arg1: !llvm.ptr, %arg2: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.switch %arg0 : i32, ^bb6 [
      0: ^bb1,
      1: ^bb2,
      2: ^bb3,
      3: ^bb4
    ]
  ^bb1:  // pred: ^bb0
    llvm.br ^bb5(%arg1 : !llvm.ptr)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb5(%arg1 : !llvm.ptr)
  ^bb3:  // pred: ^bb0
    llvm.call @use(%arg1) : (!llvm.ptr) -> ()
    llvm.br ^bb5(%arg1 : !llvm.ptr)
  ^bb4:  // pred: ^bb0
    llvm.br ^bb5(%arg2 : !llvm.ptr)
  ^bb5(%1: !llvm.ptr):  // 4 preds: ^bb1, ^bb2, ^bb3, ^bb4
    llvm.store %0, %1 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_test_4_incoming_values_different_bases_3   : test_4_incoming_values_different_bases_3_before  ⊑  test_4_incoming_values_different_bases_3_combined := by
  unfold test_4_incoming_values_different_bases_3_before test_4_incoming_values_different_bases_3_combined
  simp_alive_peephole
  sorry
    llvm.return
  ^bb6:  // pred: ^bb0
    llvm.return
  }]

theorem inst_combine_test_4_incoming_values_different_bases_3   : test_4_incoming_values_different_bases_3_before  ⊑  test_4_incoming_values_different_bases_3_combined := by
  unfold test_4_incoming_values_different_bases_3_before test_4_incoming_values_different_bases_3_combined
  simp_alive_peephole
  sorry
def test_addrspacecast_1_combined := [llvmfunc|
  llvm.func @test_addrspacecast_1(%arg0: i1, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    %1 = llvm.addrspacecast %arg1 : !llvm.ptr to !llvm.ptr<1>
    llvm.call @use.i8.addrspace1(%1) : (!llvm.ptr<1>) -> ()
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    %2 = llvm.addrspacecast %arg1 : !llvm.ptr to !llvm.ptr<1>
    llvm.store %0, %2 {alignment = 1 : i64} : i8, !llvm.ptr<1>]

theorem inst_combine_test_addrspacecast_1   : test_addrspacecast_1_before  ⊑  test_addrspacecast_1_combined := by
  unfold test_addrspacecast_1_before test_addrspacecast_1_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test_addrspacecast_1   : test_addrspacecast_1_before  ⊑  test_addrspacecast_1_combined := by
  unfold test_addrspacecast_1_before test_addrspacecast_1_combined
  simp_alive_peephole
  sorry
