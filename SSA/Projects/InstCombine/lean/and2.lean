import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  and2
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.and %arg0, %arg1  : i1
    %1 = llvm.and %0, %arg0  : i1
    llvm.return %1 : i1
  }]

def test2_logical_before := [llvmfunc|
  llvm.func @test2_logical(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg0, %arg1, %0 : i1, i1
    %2 = llvm.select %1, %arg0, %0 : i1, i1
    llvm.return %2 : i1
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.and %arg0, %arg1  : i32
    %1 = llvm.and %arg1, %0  : i32
    llvm.return %1 : i32
  }]

def test7_before := [llvmfunc|
  llvm.func @test7(%arg0: i32, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.icmp "sgt" %arg0, %1 : i32
    %4 = llvm.and %2, %arg1  : i1
    %5 = llvm.and %4, %3  : i1
    llvm.return %5 : i1
  }]

def test7_logical_before := [llvmfunc|
  llvm.func @test7_logical(%arg0: i32, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.icmp "sgt" %arg0, %1 : i32
    %5 = llvm.select %3, %arg1, %2 : i1, i1
    %6 = llvm.select %5, %4, %2 : i1, i1
    llvm.return %6 : i1
  }]

def test8_before := [llvmfunc|
  llvm.func @test8(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(14 : i32) : i32
    %2 = llvm.icmp "ne" %arg0, %0 : i32
    %3 = llvm.icmp "ult" %arg0, %1 : i32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

def test8_logical_before := [llvmfunc|
  llvm.func @test8_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(14 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "ne" %arg0, %0 : i32
    %4 = llvm.icmp "ult" %arg0, %1 : i32
    %5 = llvm.select %3, %4, %2 : i1, i1
    llvm.return %5 : i1
  }]

def test8vec_before := [llvmfunc|
  llvm.func @test8vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<14> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.icmp "ne" %arg0, %1 : vector<2xi32>
    %4 = llvm.icmp "ult" %arg0, %2 : vector<2xi32>
    %5 = llvm.and %3, %4  : vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }]

def test9_before := [llvmfunc|
  llvm.func @test9(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i64
    %3 = llvm.and %2, %1  : i64
    llvm.return %3 : i64
  }]

def test9vec_before := [llvmfunc|
  llvm.func @test9vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.mlir.constant(dense<1> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : vector<2xi64>
    %4 = llvm.and %3, %2  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

def test10_before := [llvmfunc|
  llvm.func @test10(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i64
    %3 = llvm.and %2, %1  : i64
    %4 = llvm.add %2, %3  : i64
    llvm.return %4 : i64
  }]

def and1_shl1_is_cmp_eq_0_before := [llvmfunc|
  llvm.func @and1_shl1_is_cmp_eq_0(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %0, %arg0  : i8
    %2 = llvm.and %1, %0  : i8
    llvm.return %2 : i8
  }]

def and1_shl1_is_cmp_eq_0_multiuse_before := [llvmfunc|
  llvm.func @and1_shl1_is_cmp_eq_0_multiuse(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %0, %arg0  : i8
    %2 = llvm.and %1, %0  : i8
    %3 = llvm.add %1, %2  : i8
    llvm.return %3 : i8
  }]

def and1_shl1_is_cmp_eq_0_vec_before := [llvmfunc|
  llvm.func @and1_shl1_is_cmp_eq_0_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.shl %0, %arg0  : vector<2xi8>
    %2 = llvm.and %1, %0  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

def and1_shl1_is_cmp_eq_0_vec_poison_before := [llvmfunc|
  llvm.func @and1_shl1_is_cmp_eq_0_vec_poison(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.shl %6, %arg0  : vector<2xi8>
    %8 = llvm.and %7, %6  : vector<2xi8>
    llvm.return %8 : vector<2xi8>
  }]

def and1_lshr1_is_cmp_eq_0_before := [llvmfunc|
  llvm.func @and1_lshr1_is_cmp_eq_0(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.lshr %0, %arg0  : i8
    %2 = llvm.and %1, %0  : i8
    llvm.return %2 : i8
  }]

def and1_lshr1_is_cmp_eq_0_multiuse_before := [llvmfunc|
  llvm.func @and1_lshr1_is_cmp_eq_0_multiuse(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.lshr %0, %arg0  : i8
    %2 = llvm.and %1, %0  : i8
    %3 = llvm.add %1, %2  : i8
    llvm.return %3 : i8
  }]

def and1_lshr1_is_cmp_eq_0_vec_before := [llvmfunc|
  llvm.func @and1_lshr1_is_cmp_eq_0_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.lshr %0, %arg0  : vector<2xi8>
    %2 = llvm.and %1, %0  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

def and1_lshr1_is_cmp_eq_0_vec_poison_before := [llvmfunc|
  llvm.func @and1_lshr1_is_cmp_eq_0_vec_poison(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.lshr %6, %arg0  : vector<2xi8>
    %8 = llvm.and %7, %6  : vector<2xi8>
    llvm.return %8 : vector<2xi8>
  }]

def test11_before := [llvmfunc|
  llvm.func @test11(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.add %2, %arg1  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.mul %4, %2  : i32
    llvm.return %5 : i32
  }]

def test12_before := [llvmfunc|
  llvm.func @test12(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.add %arg1, %2  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.mul %4, %2  : i32
    llvm.return %5 : i32
  }]

def test13_before := [llvmfunc|
  llvm.func @test13(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.sub %arg1, %2  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.mul %4, %2  : i32
    llvm.return %5 : i32
  }]

def test14_before := [llvmfunc|
  llvm.func @test14(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.sub %2, %arg1  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.mul %4, %2  : i32
    llvm.return %5 : i32
  }]

def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.and %arg0, %arg1  : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test2_logical_combined := [llvmfunc|
  llvm.func @test2_logical(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg0, %arg1, %0 : i1, i1
    llvm.return %1 : i1
  }]

theorem inst_combine_test2_logical   : test2_logical_before  ⊑  test2_logical_combined := by
  unfold test2_logical_before test2_logical_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.and %arg0, %arg1  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test7_combined := [llvmfunc|
  llvm.func @test7(%arg0: i32, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.and %1, %arg1  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_test7   : test7_before  ⊑  test7_combined := by
  unfold test7_before test7_combined
  simp_alive_peephole
  sorry
def test7_logical_combined := [llvmfunc|
  llvm.func @test7_logical(%arg0: i32, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.select %2, %arg1, %1 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_test7_logical   : test7_logical_before  ⊑  test7_logical_combined := by
  unfold test7_logical_before test7_logical_combined
  simp_alive_peephole
  sorry
def test8_combined := [llvmfunc|
  llvm.func @test8(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(13 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_test8   : test8_before  ⊑  test8_combined := by
  unfold test8_before test8_combined
  simp_alive_peephole
  sorry
def test8_logical_combined := [llvmfunc|
  llvm.func @test8_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(13 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_test8_logical   : test8_logical_before  ⊑  test8_logical_combined := by
  unfold test8_logical_before test8_logical_combined
  simp_alive_peephole
  sorry
def test8vec_combined := [llvmfunc|
  llvm.func @test8vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<13> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %arg0, %0  : vector<2xi32>
    %3 = llvm.icmp "ult" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_test8vec   : test8vec_before  ⊑  test8vec_combined := by
  unfold test8vec_before test8vec_combined
  simp_alive_peephole
  sorry
def test9_combined := [llvmfunc|
  llvm.func @test9(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.and %arg0, %0  : i64
    llvm.return %1 : i64
  }]

theorem inst_combine_test9   : test9_before  ⊑  test9_combined := by
  unfold test9_before test9_combined
  simp_alive_peephole
  sorry
def test9vec_combined := [llvmfunc|
  llvm.func @test9vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.and %arg0, %0  : vector<2xi64>
    llvm.return %1 : vector<2xi64>
  }]

theorem inst_combine_test9vec   : test9vec_before  ⊑  test9vec_combined := by
  unfold test9vec_before test9vec_combined
  simp_alive_peephole
  sorry
def test10_combined := [llvmfunc|
  llvm.func @test10(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(-2 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.and %arg0, %0  : i64
    %3 = llvm.sub %1, %2  : i64
    llvm.return %3 : i64
  }]

theorem inst_combine_test10   : test10_before  ⊑  test10_combined := by
  unfold test10_before test10_combined
  simp_alive_peephole
  sorry
def and1_shl1_is_cmp_eq_0_combined := [llvmfunc|
  llvm.func @and1_shl1_is_cmp_eq_0(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    %2 = llvm.zext %1 : i1 to i8
    llvm.return %2 : i8
  }]

theorem inst_combine_and1_shl1_is_cmp_eq_0   : and1_shl1_is_cmp_eq_0_before  ⊑  and1_shl1_is_cmp_eq_0_combined := by
  unfold and1_shl1_is_cmp_eq_0_before and1_shl1_is_cmp_eq_0_combined
  simp_alive_peephole
  sorry
def and1_shl1_is_cmp_eq_0_multiuse_combined := [llvmfunc|
  llvm.func @and1_shl1_is_cmp_eq_0_multiuse(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %0, %arg0 overflow<nuw>  : i8
    %2 = llvm.and %1, %0  : i8
    %3 = llvm.add %1, %2 overflow<nuw>  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_and1_shl1_is_cmp_eq_0_multiuse   : and1_shl1_is_cmp_eq_0_multiuse_before  ⊑  and1_shl1_is_cmp_eq_0_multiuse_combined := by
  unfold and1_shl1_is_cmp_eq_0_multiuse_before and1_shl1_is_cmp_eq_0_multiuse_combined
  simp_alive_peephole
  sorry
def and1_shl1_is_cmp_eq_0_vec_combined := [llvmfunc|
  llvm.func @and1_shl1_is_cmp_eq_0_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.icmp "eq" %arg0, %1 : vector<2xi8>
    %3 = llvm.zext %2 : vector<2xi1> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_and1_shl1_is_cmp_eq_0_vec   : and1_shl1_is_cmp_eq_0_vec_before  ⊑  and1_shl1_is_cmp_eq_0_vec_combined := by
  unfold and1_shl1_is_cmp_eq_0_vec_before and1_shl1_is_cmp_eq_0_vec_combined
  simp_alive_peephole
  sorry
def and1_shl1_is_cmp_eq_0_vec_poison_combined := [llvmfunc|
  llvm.func @and1_shl1_is_cmp_eq_0_vec_poison(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.icmp "eq" %arg0, %1 : vector<2xi8>
    %3 = llvm.zext %2 : vector<2xi1> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_and1_shl1_is_cmp_eq_0_vec_poison   : and1_shl1_is_cmp_eq_0_vec_poison_before  ⊑  and1_shl1_is_cmp_eq_0_vec_poison_combined := by
  unfold and1_shl1_is_cmp_eq_0_vec_poison_before and1_shl1_is_cmp_eq_0_vec_poison_combined
  simp_alive_peephole
  sorry
def and1_lshr1_is_cmp_eq_0_combined := [llvmfunc|
  llvm.func @and1_lshr1_is_cmp_eq_0(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.lshr %0, %arg0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_and1_lshr1_is_cmp_eq_0   : and1_lshr1_is_cmp_eq_0_before  ⊑  and1_lshr1_is_cmp_eq_0_combined := by
  unfold and1_lshr1_is_cmp_eq_0_before and1_lshr1_is_cmp_eq_0_combined
  simp_alive_peephole
  sorry
def and1_lshr1_is_cmp_eq_0_multiuse_combined := [llvmfunc|
  llvm.func @and1_lshr1_is_cmp_eq_0_multiuse(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.lshr %0, %arg0  : i8
    %2 = llvm.shl %1, %0 overflow<nsw, nuw>  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_and1_lshr1_is_cmp_eq_0_multiuse   : and1_lshr1_is_cmp_eq_0_multiuse_before  ⊑  and1_lshr1_is_cmp_eq_0_multiuse_combined := by
  unfold and1_lshr1_is_cmp_eq_0_multiuse_before and1_lshr1_is_cmp_eq_0_multiuse_combined
  simp_alive_peephole
  sorry
def and1_lshr1_is_cmp_eq_0_vec_combined := [llvmfunc|
  llvm.func @and1_lshr1_is_cmp_eq_0_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.lshr %0, %arg0  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_and1_lshr1_is_cmp_eq_0_vec   : and1_lshr1_is_cmp_eq_0_vec_before  ⊑  and1_lshr1_is_cmp_eq_0_vec_combined := by
  unfold and1_lshr1_is_cmp_eq_0_vec_before and1_lshr1_is_cmp_eq_0_vec_combined
  simp_alive_peephole
  sorry
def and1_lshr1_is_cmp_eq_0_vec_poison_combined := [llvmfunc|
  llvm.func @and1_lshr1_is_cmp_eq_0_vec_poison(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.lshr %6, %arg0  : vector<2xi8>
    llvm.return %7 : vector<2xi8>
  }]

theorem inst_combine_and1_lshr1_is_cmp_eq_0_vec_poison   : and1_lshr1_is_cmp_eq_0_vec_poison_before  ⊑  and1_lshr1_is_cmp_eq_0_vec_poison_combined := by
  unfold and1_lshr1_is_cmp_eq_0_vec_poison_before and1_lshr1_is_cmp_eq_0_vec_poison_combined
  simp_alive_peephole
  sorry
def test11_combined := [llvmfunc|
  llvm.func @test11(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.and %arg1, %1  : i32
    %4 = llvm.mul %3, %2  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_test11   : test11_before  ⊑  test11_combined := by
  unfold test11_before test11_combined
  simp_alive_peephole
  sorry
def test12_combined := [llvmfunc|
  llvm.func @test12(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.and %arg1, %1  : i32
    %4 = llvm.mul %3, %2  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_test12   : test12_before  ⊑  test12_combined := by
  unfold test12_before test12_combined
  simp_alive_peephole
  sorry
def test13_combined := [llvmfunc|
  llvm.func @test13(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.and %arg1, %1  : i32
    %4 = llvm.mul %3, %2  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_test13   : test13_before  ⊑  test13_combined := by
  unfold test13_before test13_combined
  simp_alive_peephole
  sorry
def test14_combined := [llvmfunc|
  llvm.func @test14(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(128 : i32) : i32
    %3 = llvm.shl %arg0, %0  : i32
    %4 = llvm.sub %1, %arg1  : i32
    %5 = llvm.and %4, %2  : i32
    %6 = llvm.mul %5, %3  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_test14   : test14_before  ⊑  test14_combined := by
  unfold test14_before test14_combined
  simp_alive_peephole
  sorry
