import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  shift-sra
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i32, %arg1: i8) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg1 : i8 to i32
    %2 = llvm.ashr %arg0, %1  : i32
    %3 = llvm.and %2, %0  : i32
    llvm.return %3 : i32
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.zext %arg0 : i8 to i32
    %3 = llvm.add %2, %0  : i32
    %4 = llvm.ashr %3, %1  : i32
    llvm.return %4 : i32
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: i1, %arg1: i64, %arg2: i1) -> i64 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.mlir.constant(12 : i64) : i64
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %2 = llvm.sext %arg0 : i1 to i64
    llvm.br ^bb3(%2 : i64)
  ^bb2:  // pred: ^bb0
    %3 = llvm.ashr %arg1, %0  : i64
    llvm.br ^bb3(%3 : i64)
  ^bb3(%4: i64):  // 2 preds: ^bb1, ^bb2
    %5 = llvm.ashr %4, %1  : i64
    llvm.return %5 : i64
  }]

def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: i1, %arg1: i64, %arg2: i1) -> i64 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.mlir.constant(12 : i64) : i64
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %2 = llvm.sext %arg0 : i1 to i64
    llvm.br ^bb3(%2 : i64)
  ^bb2:  // pred: ^bb0
    %3 = llvm.ashr %arg1, %0  : i64
    llvm.br ^bb3(%3 : i64)
  ^bb3(%4: i64):  // 2 preds: ^bb1, ^bb2
    %5 = llvm.shl %4, %1  : i64
    %6 = llvm.ashr %5, %1  : i64
    llvm.return %6 : i64
  }]

def test5_before := [llvmfunc|
  llvm.func @test5(%arg0: i32, %arg1: i1, %arg2: i1, %arg3: i1) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    llvm.cond_br %arg1, ^bb1, ^bb3
  ^bb1:  // pred: ^bb0
    llvm.cond_br %arg2, ^bb2, ^bb4(%0 : i32)
  ^bb2:  // pred: ^bb1
    llvm.br ^bb4(%0 : i32)
  ^bb3:  // pred: ^bb0
    llvm.cond_br %arg3, ^bb4(%arg0 : i32), ^bb5
  ^bb4(%2: i32):  // 3 preds: ^bb1, ^bb2, ^bb3
    %3 = llvm.ashr %2, %1  : i32
    llvm.return %3 : i32
  ^bb5:  // pred: ^bb3
    llvm.return %0 : i32
  }]

def ashr_ashr_before := [llvmfunc|
  llvm.func @ashr_ashr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.ashr %2, %1  : i32
    llvm.return %3 : i32
  }]

def ashr_overshift_before := [llvmfunc|
  llvm.func @ashr_overshift(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(17 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.ashr %2, %1  : i32
    llvm.return %3 : i32
  }]

def ashr_ashr_splat_vec_before := [llvmfunc|
  llvm.func @ashr_ashr_splat_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<7> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.ashr %arg0, %0  : vector<2xi32>
    %3 = llvm.ashr %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def ashr_overshift_splat_vec_before := [llvmfunc|
  llvm.func @ashr_overshift_splat_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<15> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<17> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.ashr %arg0, %0  : vector<2xi32>
    %3 = llvm.ashr %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def hoist_ashr_ahead_of_sext_1_before := [llvmfunc|
  llvm.func @hoist_ashr_ahead_of_sext_1(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.ashr %1, %0  : i32
    llvm.return %2 : i32
  }]

def hoist_ashr_ahead_of_sext_1_splat_before := [llvmfunc|
  llvm.func @hoist_ashr_ahead_of_sext_1_splat(%arg0: vector<2xi8>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi8> to vector<2xi32>
    %2 = llvm.ashr %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def hoist_ashr_ahead_of_sext_2_before := [llvmfunc|
  llvm.func @hoist_ashr_ahead_of_sext_2(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.ashr %1, %0  : i32
    llvm.return %2 : i32
  }]

def hoist_ashr_ahead_of_sext_2_splat_before := [llvmfunc|
  llvm.func @hoist_ashr_ahead_of_sext_2_splat(%arg0: vector<2xi8>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi8> to vector<2xi32>
    %2 = llvm.ashr %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i32, %arg1: i8) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg1 : i8 to i32
    %2 = llvm.lshr %arg0, %1  : i32
    %3 = llvm.and %2, %0  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.zext %arg0 : i8 to i32
    %3 = llvm.add %2, %0 overflow<nsw, nuw>  : i32
    %4 = llvm.lshr %3, %1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: i1, %arg1: i64, %arg2: i1) -> i64 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.sext %arg0 : i1 to i64
    llvm.br ^bb3(%1 : i64)
  ^bb2:  // pred: ^bb0
    %2 = llvm.ashr %arg1, %0  : i64
    llvm.br ^bb3(%2 : i64)
  ^bb3(%3: i64):  // 2 preds: ^bb1, ^bb2
    llvm.return %3 : i64
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4(%arg0: i1, %arg1: i64, %arg2: i1) -> i64 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.sext %arg0 : i1 to i64
    llvm.br ^bb3(%1 : i64)
  ^bb2:  // pred: ^bb0
    %2 = llvm.ashr %arg1, %0  : i64
    llvm.br ^bb3(%2 : i64)
  ^bb3(%3: i64):  // 2 preds: ^bb1, ^bb2
    llvm.return %3 : i64
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5(%arg0: i32, %arg1: i1, %arg2: i1, %arg3: i1) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    llvm.cond_br %arg1, ^bb1, ^bb3
  ^bb1:  // pred: ^bb0
    llvm.cond_br %arg2, ^bb2, ^bb4(%0 : i32)
  ^bb2:  // pred: ^bb1
    llvm.br ^bb4(%0 : i32)
  ^bb3:  // pred: ^bb0
    llvm.cond_br %arg3, ^bb4(%arg0 : i32), ^bb5
  ^bb4(%2: i32):  // 3 preds: ^bb1, ^bb2, ^bb3
    %3 = llvm.ashr %2, %1  : i32
    llvm.return %3 : i32
  ^bb5:  // pred: ^bb3
    llvm.return %0 : i32
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
def ashr_ashr_combined := [llvmfunc|
  llvm.func @ashr_ashr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.ashr %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_ashr_ashr   : ashr_ashr_before  ⊑  ashr_ashr_combined := by
  unfold ashr_ashr_before ashr_ashr_combined
  simp_alive_peephole
  sorry
def ashr_overshift_combined := [llvmfunc|
  llvm.func @ashr_overshift(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.ashr %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_ashr_overshift   : ashr_overshift_before  ⊑  ashr_overshift_combined := by
  unfold ashr_overshift_before ashr_overshift_combined
  simp_alive_peephole
  sorry
def ashr_ashr_splat_vec_combined := [llvmfunc|
  llvm.func @ashr_ashr_splat_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<12> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.ashr %arg0, %0  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_ashr_ashr_splat_vec   : ashr_ashr_splat_vec_before  ⊑  ashr_ashr_splat_vec_combined := by
  unfold ashr_ashr_splat_vec_before ashr_ashr_splat_vec_combined
  simp_alive_peephole
  sorry
def ashr_overshift_splat_vec_combined := [llvmfunc|
  llvm.func @ashr_overshift_splat_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<31> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.ashr %arg0, %0  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_ashr_overshift_splat_vec   : ashr_overshift_splat_vec_before  ⊑  ashr_overshift_splat_vec_combined := by
  unfold ashr_overshift_splat_vec_before ashr_overshift_splat_vec_combined
  simp_alive_peephole
  sorry
def hoist_ashr_ahead_of_sext_1_combined := [llvmfunc|
  llvm.func @hoist_ashr_ahead_of_sext_1(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    %2 = llvm.sext %1 : i8 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_hoist_ashr_ahead_of_sext_1   : hoist_ashr_ahead_of_sext_1_before  ⊑  hoist_ashr_ahead_of_sext_1_combined := by
  unfold hoist_ashr_ahead_of_sext_1_before hoist_ashr_ahead_of_sext_1_combined
  simp_alive_peephole
  sorry
def hoist_ashr_ahead_of_sext_1_splat_combined := [llvmfunc|
  llvm.func @hoist_ashr_ahead_of_sext_1_splat(%arg0: vector<2xi8>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.ashr %arg0, %0  : vector<2xi8>
    %2 = llvm.sext %1 : vector<2xi8> to vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_hoist_ashr_ahead_of_sext_1_splat   : hoist_ashr_ahead_of_sext_1_splat_before  ⊑  hoist_ashr_ahead_of_sext_1_splat_combined := by
  unfold hoist_ashr_ahead_of_sext_1_splat_before hoist_ashr_ahead_of_sext_1_splat_combined
  simp_alive_peephole
  sorry
def hoist_ashr_ahead_of_sext_2_combined := [llvmfunc|
  llvm.func @hoist_ashr_ahead_of_sext_2(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    %2 = llvm.sext %1 : i8 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_hoist_ashr_ahead_of_sext_2   : hoist_ashr_ahead_of_sext_2_before  ⊑  hoist_ashr_ahead_of_sext_2_combined := by
  unfold hoist_ashr_ahead_of_sext_2_before hoist_ashr_ahead_of_sext_2_combined
  simp_alive_peephole
  sorry
def hoist_ashr_ahead_of_sext_2_splat_combined := [llvmfunc|
  llvm.func @hoist_ashr_ahead_of_sext_2_splat(%arg0: vector<2xi8>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.ashr %arg0, %0  : vector<2xi8>
    %2 = llvm.sext %1 : vector<2xi8> to vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_hoist_ashr_ahead_of_sext_2_splat   : hoist_ashr_ahead_of_sext_2_splat_before  ⊑  hoist_ashr_ahead_of_sext_2_splat_combined := by
  unfold hoist_ashr_ahead_of_sext_2_splat_before hoist_ashr_ahead_of_sext_2_splat_combined
  simp_alive_peephole
  sorry
