import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  icmp-bc-vec
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_i1_0_before := [llvmfunc|
  llvm.func @test_i1_0(%arg0: i1) -> i1 {
    %0 = llvm.mlir.undef : vector<4xi1>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0 : i4) : i4
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xi1>
    %4 = llvm.shufflevector %3, %0 [0, 0, 0, 0] : vector<4xi1> 
    %5 = llvm.bitcast %4 : vector<4xi1> to i4
    %6 = llvm.icmp "eq" %5, %2 : i4
    llvm.return %6 : i1
  }]

def test_i1_0_2_before := [llvmfunc|
  llvm.func @test_i1_0_2(%arg0: i1) -> i1 {
    %0 = llvm.mlir.undef : vector<4xi1>
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i4) : i4
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xi1>
    %4 = llvm.shufflevector %3, %0 [2, 2, 2, 2] : vector<4xi1> 
    %5 = llvm.bitcast %4 : vector<4xi1> to i4
    %6 = llvm.icmp "eq" %5, %2 : i4
    llvm.return %6 : i1
  }]

def test_i1_m1_before := [llvmfunc|
  llvm.func @test_i1_m1(%arg0: i1) -> i1 {
    %0 = llvm.mlir.undef : vector<4xi1>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i4) : i4
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xi1>
    %4 = llvm.shufflevector %3, %0 [0, 0, 0, 0] : vector<4xi1> 
    %5 = llvm.bitcast %4 : vector<4xi1> to i4
    %6 = llvm.icmp "eq" %5, %2 : i4
    llvm.return %6 : i1
  }]

def test_i8_pattern_before := [llvmfunc|
  llvm.func @test_i8_pattern(%arg0: i8) -> i1 {
    %0 = llvm.mlir.undef : vector<4xi8>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1212696648 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xi8>
    %4 = llvm.shufflevector %3, %0 [0, 0, 0, 0] : vector<4xi8> 
    %5 = llvm.bitcast %4 : vector<4xi8> to i32
    %6 = llvm.icmp "eq" %5, %2 : i32
    llvm.return %6 : i1
  }]

def test_i8_pattern_2_before := [llvmfunc|
  llvm.func @test_i8_pattern_2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.undef : vector<4xi8>
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(1212696648 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xi8>
    %4 = llvm.shufflevector %3, %0 [2, 2, 2, 2] : vector<4xi8> 
    %5 = llvm.bitcast %4 : vector<4xi8> to i32
    %6 = llvm.icmp "eq" %5, %2 : i32
    llvm.return %6 : i1
  }]

def test_i8_pattern_3_before := [llvmfunc|
  llvm.func @test_i8_pattern_3(%arg0: vector<4xi8>) -> i1 {
    %0 = llvm.mlir.undef : vector<4xi8>
    %1 = llvm.mlir.constant(1212696648 : i32) : i32
    %2 = llvm.shufflevector %arg0, %0 [1, 0, 3, 2] : vector<4xi8> 
    %3 = llvm.bitcast %2 : vector<4xi8> to i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }]

def test_i8_nopattern_before := [llvmfunc|
  llvm.func @test_i8_nopattern(%arg0: i8) -> i1 {
    %0 = llvm.mlir.undef : vector<4xi8>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1212696647 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xi8>
    %4 = llvm.shufflevector %3, %0 [0, 0, 0, 0] : vector<4xi8> 
    %5 = llvm.bitcast %4 : vector<4xi8> to i32
    %6 = llvm.icmp "eq" %5, %2 : i32
    llvm.return %6 : i1
  }]

def test_i8_ult_pattern_before := [llvmfunc|
  llvm.func @test_i8_ult_pattern(%arg0: i8) -> i1 {
    %0 = llvm.mlir.undef : vector<4xi8>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1212696648 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xi8>
    %4 = llvm.shufflevector %3, %0 [0, 0, 0, 0] : vector<4xi8> 
    %5 = llvm.bitcast %4 : vector<4xi8> to i32
    %6 = llvm.icmp "ult" %5, %2 : i32
    llvm.return %6 : i1
  }]

def extending_shuffle_with_weird_types_before := [llvmfunc|
  llvm.func @extending_shuffle_with_weird_types(%arg0: vector<2xi9>) -> i1 {
    %0 = llvm.mlir.undef : vector<2xi9>
    %1 = llvm.mlir.constant(262657 : i27) : i27
    %2 = llvm.shufflevector %arg0, %0 [0, 0, 0] : vector<2xi9> 
    %3 = llvm.bitcast %2 : vector<3xi9> to i27
    %4 = llvm.icmp "slt" %3, %1 : i27
    llvm.return %4 : i1
  }]

def test_i1_0_combined := [llvmfunc|
  llvm.func @test_i1_0(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    llvm.return %1 : i1
  }]

theorem inst_combine_test_i1_0   : test_i1_0_before  ⊑  test_i1_0_combined := by
  unfold test_i1_0_before test_i1_0_combined
  simp_alive_peephole
  sorry
def test_i1_0_2_combined := [llvmfunc|
  llvm.func @test_i1_0_2(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    llvm.return %1 : i1
  }]

theorem inst_combine_test_i1_0_2   : test_i1_0_2_before  ⊑  test_i1_0_2_combined := by
  unfold test_i1_0_2_before test_i1_0_2_combined
  simp_alive_peephole
  sorry
def test_i1_m1_combined := [llvmfunc|
  llvm.func @test_i1_m1(%arg0: i1) -> i1 {
    llvm.return %arg0 : i1
  }]

theorem inst_combine_test_i1_m1   : test_i1_m1_before  ⊑  test_i1_m1_combined := by
  unfold test_i1_m1_before test_i1_m1_combined
  simp_alive_peephole
  sorry
def test_i8_pattern_combined := [llvmfunc|
  llvm.func @test_i8_pattern(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(72 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_test_i8_pattern   : test_i8_pattern_before  ⊑  test_i8_pattern_combined := by
  unfold test_i8_pattern_before test_i8_pattern_combined
  simp_alive_peephole
  sorry
def test_i8_pattern_2_combined := [llvmfunc|
  llvm.func @test_i8_pattern_2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(72 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_test_i8_pattern_2   : test_i8_pattern_2_before  ⊑  test_i8_pattern_2_combined := by
  unfold test_i8_pattern_2_before test_i8_pattern_2_combined
  simp_alive_peephole
  sorry
def test_i8_pattern_3_combined := [llvmfunc|
  llvm.func @test_i8_pattern_3(%arg0: vector<4xi8>) -> i1 {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.mlir.constant(1212696648 : i32) : i32
    %2 = llvm.shufflevector %arg0, %0 [1, 0, 3, 2] : vector<4xi8> 
    %3 = llvm.bitcast %2 : vector<4xi8> to i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_test_i8_pattern_3   : test_i8_pattern_3_before  ⊑  test_i8_pattern_3_combined := by
  unfold test_i8_pattern_3_before test_i8_pattern_3_combined
  simp_alive_peephole
  sorry
def test_i8_nopattern_combined := [llvmfunc|
  llvm.func @test_i8_nopattern(%arg0: i8) -> i1 {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1212696647 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i64] : vector<4xi8>
    %4 = llvm.shufflevector %3, %0 [0, 0, 0, 0] : vector<4xi8> 
    %5 = llvm.bitcast %4 : vector<4xi8> to i32
    %6 = llvm.icmp "eq" %5, %2 : i32
    llvm.return %6 : i1
  }]

theorem inst_combine_test_i8_nopattern   : test_i8_nopattern_before  ⊑  test_i8_nopattern_combined := by
  unfold test_i8_nopattern_before test_i8_nopattern_combined
  simp_alive_peephole
  sorry
def test_i8_ult_pattern_combined := [llvmfunc|
  llvm.func @test_i8_ult_pattern(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(72 : i8) : i8
    %1 = llvm.icmp "ult" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_test_i8_ult_pattern   : test_i8_ult_pattern_before  ⊑  test_i8_ult_pattern_combined := by
  unfold test_i8_ult_pattern_before test_i8_ult_pattern_combined
  simp_alive_peephole
  sorry
def extending_shuffle_with_weird_types_combined := [llvmfunc|
  llvm.func @extending_shuffle_with_weird_types(%arg0: vector<2xi9>) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i9) : i9
    %2 = llvm.extractelement %arg0[%0 : i64] : vector<2xi9>
    %3 = llvm.icmp "slt" %2, %1 : i9
    llvm.return %3 : i1
  }]

theorem inst_combine_extending_shuffle_with_weird_types   : extending_shuffle_with_weird_types_before  ⊑  extending_shuffle_with_weird_types_combined := by
  unfold extending_shuffle_with_weird_types_before extending_shuffle_with_weird_types_combined
  simp_alive_peephole
  sorry
