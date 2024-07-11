import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  compare-signs
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i32, %arg1: i32) -> i32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.icmp "slt" %arg1, %1 : i32
    %4 = llvm.xor %3, %2  : i1
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i32, %arg1: i32) -> i32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.and %arg1, %0  : i32
    %3 = llvm.icmp "eq" %1, %2 : i32
    %4 = llvm.zext %3 : i1 to i32
    llvm.return %4 : i32
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: i32, %arg1: i32) -> i32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.lshr %arg1, %0  : i32
    %3 = llvm.icmp "eq" %1, %2 : i32
    %4 = llvm.zext %3 : i1 to i32
    llvm.return %4 : i32
  }]

def test3vec_before := [llvmfunc|
  llvm.func @test3vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<31> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.lshr %arg0, %0  : vector<2xi32>
    %2 = llvm.lshr %arg1, %0  : vector<2xi32>
    %3 = llvm.icmp "eq" %1, %2 : vector<2xi32>
    %4 = llvm.zext %3 : vector<2xi1> to vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def test3vec_poison1_before := [llvmfunc|
  llvm.func @test3vec_poison1(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(24 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(dense<24> : vector<2xi32>) : vector<2xi32>
    %8 = llvm.lshr %arg0, %6  : vector<2xi32>
    %9 = llvm.lshr %arg1, %7  : vector<2xi32>
    %10 = llvm.icmp "eq" %8, %9 : vector<2xi32>
    %11 = llvm.zext %10 : vector<2xi1> to vector<2xi32>
    llvm.return %11 : vector<2xi32>
  }]

def test3vec_poison2_before := [llvmfunc|
  llvm.func @test3vec_poison2(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(17 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.lshr %arg0, %6  : vector<2xi32>
    %8 = llvm.lshr %arg1, %6  : vector<2xi32>
    %9 = llvm.icmp "eq" %7, %8 : vector<2xi32>
    %10 = llvm.zext %9 : vector<2xi1> to vector<2xi32>
    llvm.return %10 : vector<2xi32>
  }]

def test3vec_diff_before := [llvmfunc|
  llvm.func @test3vec_diff(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<31> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<30> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.lshr %arg0, %0  : vector<2xi32>
    %3 = llvm.lshr %arg1, %1  : vector<2xi32>
    %4 = llvm.icmp "eq" %2, %3 : vector<2xi32>
    %5 = llvm.zext %4 : vector<2xi1> to vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

def "test3vec_non-uniform"_before := [llvmfunc|
  llvm.func @"test3vec_non-uniform"(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<[30, 31]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.lshr %arg0, %0  : vector<2xi32>
    %2 = llvm.lshr %arg1, %0  : vector<2xi32>
    %3 = llvm.icmp "eq" %1, %2 : vector<2xi32>
    %4 = llvm.zext %3 : vector<2xi1> to vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def test3i_before := [llvmfunc|
  llvm.func @test3i(%arg0: i32, %arg1: i32) -> i32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(29 : i32) : i32
    %1 = llvm.mlir.constant(35 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.lshr %arg1, %0  : i32
    %4 = llvm.or %2, %1  : i32
    %5 = llvm.or %3, %1  : i32
    %6 = llvm.icmp "eq" %4, %5 : i32
    %7 = llvm.zext %6 : i1 to i32
    llvm.return %7 : i32
  }]

def test4a_before := [llvmfunc|
  llvm.func @test4a(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.ashr %arg0, %0  : i32
    %4 = llvm.sub %1, %arg0  : i32
    %5 = llvm.lshr %4, %0  : i32
    %6 = llvm.or %3, %5  : i32
    %7 = llvm.icmp "slt" %6, %2 : i32
    llvm.return %7 : i1
  }]

def test4a_vec_before := [llvmfunc|
  llvm.func @test4a_vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<31> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.ashr %arg0, %0  : vector<2xi32>
    %5 = llvm.sub %2, %arg0  : vector<2xi32>
    %6 = llvm.lshr %5, %0  : vector<2xi32>
    %7 = llvm.or %4, %6  : vector<2xi32>
    %8 = llvm.icmp "slt" %7, %3 : vector<2xi32>
    llvm.return %8 : vector<2xi1>
  }]

def test4b_before := [llvmfunc|
  llvm.func @test4b(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.ashr %arg0, %0  : i64
    %4 = llvm.sub %1, %arg0  : i64
    %5 = llvm.lshr %4, %0  : i64
    %6 = llvm.or %3, %5  : i64
    %7 = llvm.icmp "slt" %6, %2 : i64
    llvm.return %7 : i1
  }]

def test4c_before := [llvmfunc|
  llvm.func @test4c(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.ashr %arg0, %0  : i64
    %4 = llvm.sub %1, %arg0  : i64
    %5 = llvm.lshr %4, %0  : i64
    %6 = llvm.or %3, %5  : i64
    %7 = llvm.trunc %6 : i64 to i32
    %8 = llvm.icmp "slt" %7, %2 : i32
    llvm.return %8 : i1
  }]

def test4c_vec_before := [llvmfunc|
  llvm.func @test4c_vec(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<63> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.ashr %arg0, %0  : vector<2xi64>
    %5 = llvm.sub %2, %arg0  : vector<2xi64>
    %6 = llvm.lshr %5, %0  : vector<2xi64>
    %7 = llvm.or %4, %6  : vector<2xi64>
    %8 = llvm.trunc %7 : vector<2xi64> to vector<2xi32>
    %9 = llvm.icmp "slt" %8, %3 : vector<2xi32>
    llvm.return %9 : vector<2xi1>
  }]

def shift_trunc_signbit_test_before := [llvmfunc|
  llvm.func @shift_trunc_signbit_test(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    %4 = llvm.icmp "slt" %3, %1 : i8
    llvm.return %4 : i1
  }]

def shift_trunc_signbit_test_vec_uses_before := [llvmfunc|
  llvm.func @shift_trunc_signbit_test_vec_uses(%arg0: vector<2xi17>, %arg1: !llvm.ptr, %arg2: !llvm.ptr) -> vector<2xi1> {
    %0 = llvm.mlir.constant(4 : i17) : i17
    %1 = llvm.mlir.constant(dense<4> : vector<2xi17>) : vector<2xi17>
    %2 = llvm.mlir.constant(-1 : i13) : i13
    %3 = llvm.mlir.constant(dense<-1> : vector<2xi13>) : vector<2xi13>
    %4 = llvm.lshr %arg0, %1  : vector<2xi17>
    llvm.store %4, %arg1 {alignment = 8 : i64} : vector<2xi17>, !llvm.ptr]

    %5 = llvm.trunc %4 : vector<2xi17> to vector<2xi13>
    llvm.store %5, %arg2 {alignment = 4 : i64} : vector<2xi13>, !llvm.ptr]

    %6 = llvm.icmp "sgt" %5, %3 : vector<2xi13>
    llvm.return %6 : vector<2xi1>
  }]

def shift_trunc_wrong_shift_before := [llvmfunc|
  llvm.func @shift_trunc_wrong_shift(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(23 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    %4 = llvm.icmp "slt" %3, %1 : i8
    llvm.return %4 : i1
  }]

def shift_trunc_wrong_cmp_before := [llvmfunc|
  llvm.func @shift_trunc_wrong_cmp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    %4 = llvm.icmp "slt" %3, %1 : i8
    llvm.return %4 : i1
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i32, %arg1: i32) -> i32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %arg0  : i32
    %2 = llvm.icmp "sgt" %1, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i32, %arg1: i32) -> i32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.xor %arg0, %arg1  : i32
    %3 = llvm.lshr %2, %0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.xor %4, %1  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: i32, %arg1: i32) -> i32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %arg1  : i32
    %2 = llvm.icmp "sgt" %1, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test3vec_combined := [llvmfunc|
  llvm.func @test3vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.xor %arg0, %arg1  : vector<2xi32>
    %2 = llvm.icmp "sgt" %1, %0 : vector<2xi32>
    %3 = llvm.zext %2 : vector<2xi1> to vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_test3vec   : test3vec_before  ⊑  test3vec_combined := by
  unfold test3vec_before test3vec_combined
  simp_alive_peephole
  sorry
def test3vec_poison1_combined := [llvmfunc|
  llvm.func @test3vec_poison1(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<16777216> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.xor %arg0, %arg1  : vector<2xi32>
    %2 = llvm.icmp "ult" %1, %0 : vector<2xi32>
    %3 = llvm.zext %2 : vector<2xi1> to vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_test3vec_poison1   : test3vec_poison1_before  ⊑  test3vec_poison1_combined := by
  unfold test3vec_poison1_before test3vec_poison1_combined
  simp_alive_peephole
  sorry
def test3vec_poison2_combined := [llvmfunc|
  llvm.func @test3vec_poison2(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<131072> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.xor %arg0, %arg1  : vector<2xi32>
    %2 = llvm.icmp "ult" %1, %0 : vector<2xi32>
    %3 = llvm.zext %2 : vector<2xi1> to vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_test3vec_poison2   : test3vec_poison2_before  ⊑  test3vec_poison2_combined := by
  unfold test3vec_poison2_before test3vec_poison2_combined
  simp_alive_peephole
  sorry
def test3vec_diff_combined := [llvmfunc|
  llvm.func @test3vec_diff(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<31> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<30> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.lshr %arg0, %0  : vector<2xi32>
    %3 = llvm.lshr %arg1, %1  : vector<2xi32>
    %4 = llvm.icmp "eq" %2, %3 : vector<2xi32>
    %5 = llvm.zext %4 : vector<2xi1> to vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

theorem inst_combine_test3vec_diff   : test3vec_diff_before  ⊑  test3vec_diff_combined := by
  unfold test3vec_diff_before test3vec_diff_combined
  simp_alive_peephole
  sorry
def "test3vec_non-uniform"_combined := [llvmfunc|
  llvm.func @"test3vec_non-uniform"(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<[30, 31]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.lshr %arg0, %0  : vector<2xi32>
    %2 = llvm.lshr %arg1, %0  : vector<2xi32>
    %3 = llvm.icmp "eq" %1, %2 : vector<2xi32>
    %4 = llvm.zext %3 : vector<2xi1> to vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

theorem inst_combine_"test3vec_non-uniform"   : "test3vec_non-uniform"_before  ⊑  "test3vec_non-uniform"_combined := by
  unfold "test3vec_non-uniform"_before "test3vec_non-uniform"_combined
  simp_alive_peephole
  sorry
def test3i_combined := [llvmfunc|
  llvm.func @test3i(%arg0: i32, %arg1: i32) -> i32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %arg1  : i32
    %2 = llvm.icmp "sgt" %1, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test3i   : test3i_before  ⊑  test3i_combined := by
  unfold test3i_before test3i_combined
  simp_alive_peephole
  sorry
def test4a_combined := [llvmfunc|
  llvm.func @test4a(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_test4a   : test4a_before  ⊑  test4a_combined := by
  unfold test4a_before test4a_combined
  simp_alive_peephole
  sorry
def test4a_vec_combined := [llvmfunc|
  llvm.func @test4a_vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "slt" %arg0, %0 : vector<2xi32>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_test4a_vec   : test4a_vec_before  ⊑  test4a_vec_combined := by
  unfold test4a_vec_before test4a_vec_combined
  simp_alive_peephole
  sorry
def test4b_combined := [llvmfunc|
  llvm.func @test4b(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    llvm.return %1 : i1
  }]

theorem inst_combine_test4b   : test4b_before  ⊑  test4b_combined := by
  unfold test4b_before test4b_combined
  simp_alive_peephole
  sorry
def test4c_combined := [llvmfunc|
  llvm.func @test4c(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    llvm.return %1 : i1
  }]

theorem inst_combine_test4c   : test4c_before  ⊑  test4c_combined := by
  unfold test4c_before test4c_combined
  simp_alive_peephole
  sorry
def test4c_vec_combined := [llvmfunc|
  llvm.func @test4c_vec(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.icmp "slt" %arg0, %0 : vector<2xi64>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_test4c_vec   : test4c_vec_before  ⊑  test4c_vec_combined := by
  unfold test4c_vec_before test4c_vec_combined
  simp_alive_peephole
  sorry
def shift_trunc_signbit_test_combined := [llvmfunc|
  llvm.func @shift_trunc_signbit_test(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_shift_trunc_signbit_test   : shift_trunc_signbit_test_before  ⊑  shift_trunc_signbit_test_combined := by
  unfold shift_trunc_signbit_test_before shift_trunc_signbit_test_combined
  simp_alive_peephole
  sorry
def shift_trunc_signbit_test_vec_uses_combined := [llvmfunc|
  llvm.func @shift_trunc_signbit_test_vec_uses(%arg0: vector<2xi17>, %arg1: !llvm.ptr, %arg2: !llvm.ptr) -> vector<2xi1> {
    %0 = llvm.mlir.constant(4 : i17) : i17
    %1 = llvm.mlir.constant(dense<4> : vector<2xi17>) : vector<2xi17>
    %2 = llvm.mlir.constant(-1 : i17) : i17
    %3 = llvm.mlir.constant(dense<-1> : vector<2xi17>) : vector<2xi17>
    %4 = llvm.lshr %arg0, %1  : vector<2xi17>
    llvm.store %4, %arg1 {alignment = 8 : i64} : vector<2xi17>, !llvm.ptr]

theorem inst_combine_shift_trunc_signbit_test_vec_uses   : shift_trunc_signbit_test_vec_uses_before  ⊑  shift_trunc_signbit_test_vec_uses_combined := by
  unfold shift_trunc_signbit_test_vec_uses_before shift_trunc_signbit_test_vec_uses_combined
  simp_alive_peephole
  sorry
    %5 = llvm.trunc %4 : vector<2xi17> to vector<2xi13>
    llvm.store %5, %arg2 {alignment = 4 : i64} : vector<2xi13>, !llvm.ptr]

theorem inst_combine_shift_trunc_signbit_test_vec_uses   : shift_trunc_signbit_test_vec_uses_before  ⊑  shift_trunc_signbit_test_vec_uses_combined := by
  unfold shift_trunc_signbit_test_vec_uses_before shift_trunc_signbit_test_vec_uses_combined
  simp_alive_peephole
  sorry
    %6 = llvm.icmp "sgt" %arg0, %3 : vector<2xi17>
    llvm.return %6 : vector<2xi1>
  }]

theorem inst_combine_shift_trunc_signbit_test_vec_uses   : shift_trunc_signbit_test_vec_uses_before  ⊑  shift_trunc_signbit_test_vec_uses_combined := by
  unfold shift_trunc_signbit_test_vec_uses_before shift_trunc_signbit_test_vec_uses_combined
  simp_alive_peephole
  sorry
def shift_trunc_wrong_shift_combined := [llvmfunc|
  llvm.func @shift_trunc_wrong_shift(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1073741824 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_shift_trunc_wrong_shift   : shift_trunc_wrong_shift_before  ⊑  shift_trunc_wrong_shift_combined := by
  unfold shift_trunc_wrong_shift_before shift_trunc_wrong_shift_combined
  simp_alive_peephole
  sorry
def shift_trunc_wrong_cmp_combined := [llvmfunc|
  llvm.func @shift_trunc_wrong_cmp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    %4 = llvm.icmp "slt" %3, %1 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_shift_trunc_wrong_cmp   : shift_trunc_wrong_cmp_before  ⊑  shift_trunc_wrong_cmp_combined := by
  unfold shift_trunc_wrong_cmp_before shift_trunc_wrong_cmp_combined
  simp_alive_peephole
  sorry
