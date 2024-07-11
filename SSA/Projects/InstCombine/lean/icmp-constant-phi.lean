import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  icmp-constant-phi
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_eq_before := [llvmfunc|
  llvm.func @test_eq(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(456 : i32) : i32
    %1 = llvm.mlir.constant(123 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%1 : i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%0 : i32)
  ^bb3(%2: i32):  // 2 preds: ^bb1, ^bb2
    llvm.br ^bb4
  ^bb4:  // pred: ^bb3
    %3 = llvm.icmp "eq" %2, %0 : i32
    llvm.return %3 : i1
  }]

def test_slt_before := [llvmfunc|
  llvm.func @test_slt(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(456 : i32) : i32
    %1 = llvm.mlir.constant(123 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%1 : i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%0 : i32)
  ^bb3(%2: i32):  // 2 preds: ^bb1, ^bb2
    llvm.br ^bb4
  ^bb4:  // pred: ^bb3
    %3 = llvm.icmp "slt" %2, %0 : i32
    llvm.return %3 : i1
  }]

def test_sle_before := [llvmfunc|
  llvm.func @test_sle(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(456 : i32) : i32
    %1 = llvm.mlir.constant(123 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%1 : i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%0 : i32)
  ^bb3(%2: i32):  // 2 preds: ^bb1, ^bb2
    llvm.br ^bb4
  ^bb4:  // pred: ^bb3
    %3 = llvm.icmp "sle" %2, %0 : i32
    llvm.return %3 : i1
  }]

def test_ne_before := [llvmfunc|
  llvm.func @test_ne(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(456 : i32) : i32
    %1 = llvm.mlir.constant(123 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%1 : i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%0 : i32)
  ^bb3(%2: i32):  // 2 preds: ^bb1, ^bb2
    llvm.br ^bb4
  ^bb4:  // pred: ^bb3
    %3 = llvm.icmp "ne" %2, %0 : i32
    llvm.return %3 : i1
  }]

def test_ne_undef_before := [llvmfunc|
  llvm.func @test_ne_undef(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(456 : i32) : i32
    %1 = llvm.mlir.undef : i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%1 : i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%0 : i32)
  ^bb3(%2: i32):  // 2 preds: ^bb1, ^bb2
    llvm.br ^bb4
  ^bb4:  // pred: ^bb3
    %3 = llvm.icmp "ne" %2, %0 : i32
    llvm.return %3 : i1
  }]

def test_ne_int_vector_before := [llvmfunc|
  llvm.func @test_ne_int_vector(%arg0: i1) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<456> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<123> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<[123, 456]> : vector<2xi32>) : vector<2xi32>
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%1 : vector<2xi32>)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%0 : vector<2xi32>)
  ^bb3(%3: vector<2xi32>):  // 2 preds: ^bb1, ^bb2
    llvm.br ^bb4
  ^bb4:  // pred: ^bb3
    %4 = llvm.icmp "ne" %3, %2 : vector<2xi32>
    llvm.return %4 : vector<2xi1>
  }]

def test_ne_float_before := [llvmfunc|
  llvm.func @test_ne_float(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(1.250000e+00 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%1 : f32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%0 : f32)
  ^bb3(%2: f32):  // 2 preds: ^bb1, ^bb2
    llvm.br ^bb4
  ^bb4:  // pred: ^bb3
    %3 = llvm.fcmp "one" %2, %0 : f32
    llvm.return %3 : i1
  }]

def test_ne_float_undef_before := [llvmfunc|
  llvm.func @test_ne_float_undef(%arg0: i1) -> i1 {
    %0 = llvm.mlir.undef : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(1.250000e+00 : f32) : f32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%1 : f32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%0 : f32)
  ^bb3(%3: f32):  // 2 preds: ^bb1, ^bb2
    llvm.br ^bb4
  ^bb4:  // pred: ^bb3
    %4 = llvm.fcmp "one" %3, %2 : f32
    llvm.return %4 : i1
  }]

def test_ne_float_vector_before := [llvmfunc|
  llvm.func @test_ne_float_vector(%arg0: i1) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<4.562500e+02> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.mlir.constant(dense<1.232500e+02> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.mlir.constant(dense<[1.232500e+02, 4.562500e+02]> : vector<2xf32>) : vector<2xf32>
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%1 : vector<2xf32>)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%0 : vector<2xf32>)
  ^bb3(%3: vector<2xf32>):  // 2 preds: ^bb1, ^bb2
    llvm.br ^bb4
  ^bb4:  // pred: ^bb3
    %4 = llvm.fcmp "one" %3, %2 : vector<2xf32>
    llvm.return %4 : vector<2xi1>
  }]

def test_eq_combined := [llvmfunc|
  llvm.func @test_eq(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    llvm.br ^bb4
  ^bb4:  // pred: ^bb3
    %1 = llvm.xor %arg0, %0  : i1
    llvm.return %1 : i1
  }]

theorem inst_combine_test_eq   : test_eq_before  ⊑  test_eq_combined := by
  unfold test_eq_before test_eq_combined
  simp_alive_peephole
  sorry
def test_slt_combined := [llvmfunc|
  llvm.func @test_slt(%arg0: i1) -> i1 {
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    llvm.br ^bb4
  ^bb4:  // pred: ^bb3
    llvm.return %arg0 : i1
  }]

theorem inst_combine_test_slt   : test_slt_before  ⊑  test_slt_combined := by
  unfold test_slt_before test_slt_combined
  simp_alive_peephole
  sorry
def test_sle_combined := [llvmfunc|
  llvm.func @test_sle(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    llvm.br ^bb4
  ^bb4:  // pred: ^bb3
    llvm.return %0 : i1
  }]

theorem inst_combine_test_sle   : test_sle_before  ⊑  test_sle_combined := by
  unfold test_sle_before test_sle_combined
  simp_alive_peephole
  sorry
def test_ne_combined := [llvmfunc|
  llvm.func @test_ne(%arg0: i1) -> i1 {
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    llvm.br ^bb4
  ^bb4:  // pred: ^bb3
    llvm.return %arg0 : i1
  }]

theorem inst_combine_test_ne   : test_ne_before  ⊑  test_ne_combined := by
  unfold test_ne_before test_ne_combined
  simp_alive_peephole
  sorry
def test_ne_undef_combined := [llvmfunc|
  llvm.func @test_ne_undef(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    llvm.br ^bb4
  ^bb4:  // pred: ^bb3
    llvm.return %0 : i1
  }]

theorem inst_combine_test_ne_undef   : test_ne_undef_before  ⊑  test_ne_undef_combined := by
  unfold test_ne_undef_before test_ne_undef_combined
  simp_alive_peephole
  sorry
def test_ne_int_vector_combined := [llvmfunc|
  llvm.func @test_ne_int_vector(%arg0: i1) -> vector<2xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(dense<[true, false]> : vector<2xi1>) : vector<2xi1>
    %3 = llvm.mlir.constant(dense<[false, true]> : vector<2xi1>) : vector<2xi1>
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%3 : vector<2xi1>)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%2 : vector<2xi1>)
  ^bb3(%4: vector<2xi1>):  // 2 preds: ^bb1, ^bb2
    llvm.br ^bb4
  ^bb4:  // pred: ^bb3
    llvm.return %4 : vector<2xi1>
  }]

theorem inst_combine_test_ne_int_vector   : test_ne_int_vector_before  ⊑  test_ne_int_vector_combined := by
  unfold test_ne_int_vector_before test_ne_int_vector_combined
  simp_alive_peephole
  sorry
def test_ne_float_combined := [llvmfunc|
  llvm.func @test_ne_float(%arg0: i1) -> i1 {
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    llvm.br ^bb4
  ^bb4:  // pred: ^bb3
    llvm.return %arg0 : i1
  }]

theorem inst_combine_test_ne_float   : test_ne_float_before  ⊑  test_ne_float_combined := by
  unfold test_ne_float_before test_ne_float_combined
  simp_alive_peephole
  sorry
def test_ne_float_undef_combined := [llvmfunc|
  llvm.func @test_ne_float_undef(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    llvm.br ^bb4
  ^bb4:  // pred: ^bb3
    llvm.return %0 : i1
  }]

theorem inst_combine_test_ne_float_undef   : test_ne_float_undef_before  ⊑  test_ne_float_undef_combined := by
  unfold test_ne_float_undef_before test_ne_float_undef_combined
  simp_alive_peephole
  sorry
def test_ne_float_vector_combined := [llvmfunc|
  llvm.func @test_ne_float_vector(%arg0: i1) -> vector<2xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(dense<[true, false]> : vector<2xi1>) : vector<2xi1>
    %3 = llvm.mlir.constant(dense<[false, true]> : vector<2xi1>) : vector<2xi1>
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%3 : vector<2xi1>)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%2 : vector<2xi1>)
  ^bb3(%4: vector<2xi1>):  // 2 preds: ^bb1, ^bb2
    llvm.br ^bb4
  ^bb4:  // pred: ^bb3
    llvm.return %4 : vector<2xi1>
  }]

theorem inst_combine_test_ne_float_vector   : test_ne_float_vector_before  ⊑  test_ne_float_vector_combined := by
  unfold test_ne_float_vector_before test_ne_float_vector_combined
  simp_alive_peephole
  sorry
