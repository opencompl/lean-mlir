import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  add2
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i64, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(123 : i64) : i64
    %2 = llvm.zext %arg1 : i32 to i64
    %3 = llvm.shl %2, %0  : i64
    %4 = llvm.add %3, %arg0  : i64
    %5 = llvm.and %4, %1  : i64
    llvm.return %5 : i64
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.and %arg0, %1  : i32
    %4 = llvm.add %2, %3  : i32
    llvm.return %4 : i32
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(30 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.lshr %arg0, %1  : i32
    %4 = llvm.add %2, %3  : i32
    llvm.return %4 : i32
  }]

def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: i32) -> i32 {
    %0 = llvm.add %arg0, %arg0 overflow<nuw>  : i32
    llvm.return %0 : i32
  }]

def test5_before := [llvmfunc|
  llvm.func @test5(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.add %arg0, %arg1  : vector<2xi1>
    llvm.return %0 : vector<2xi1>
  }]

def test6_before := [llvmfunc|
  llvm.func @test6(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[2, 3]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.shl %arg0, %0  : vector<2xi64>
    %2 = llvm.add %1, %arg0  : vector<2xi64>
    llvm.return %2 : vector<2xi64>
  }]

def test7_before := [llvmfunc|
  llvm.func @test7(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[2, 3]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<[3, 4]> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.shl %arg0, %0  : vector<2xi64>
    %3 = llvm.mul %arg0, %1  : vector<2xi64>
    %4 = llvm.add %2, %3  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

def test9_before := [llvmfunc|
  llvm.func @test9(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(2 : i16) : i16
    %1 = llvm.mlir.constant(32767 : i16) : i16
    %2 = llvm.mul %arg0, %0  : i16
    %3 = llvm.mul %arg0, %1  : i16
    %4 = llvm.add %2, %3  : i16
    llvm.return %4 : i16
  }]

def test10_before := [llvmfunc|
  llvm.func @test10(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(-1431655766 : i32) : i32
    %2 = llvm.mlir.constant(1431655765 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.ashr %arg0, %0  : i32
    %5 = llvm.or %4, %1  : i32
    %6 = llvm.xor %5, %2  : i32
    %7 = llvm.add %arg1, %3  : i32
    %8 = llvm.add %7, %6  : i32
    llvm.return %8 : i32
  }]

def test11_before := [llvmfunc|
  llvm.func @test11(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1431655766 : i32) : i32
    %1 = llvm.mlir.constant(1431655765 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.or %arg0, %0  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.add %arg1, %2  : i32
    %6 = llvm.add %5, %4  : i32
    llvm.return %6 : i32
  }]

def test12_before := [llvmfunc|
  llvm.func @test12(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1431655766 : i32) : i32
    %2 = llvm.mlir.constant(1431655765 : i32) : i32
    %3 = llvm.add %arg1, %0 overflow<nsw>  : i32
    %4 = llvm.or %arg0, %1  : i32
    %5 = llvm.xor %4, %2  : i32
    %6 = llvm.add %3, %5 overflow<nsw>  : i32
    llvm.return %6 : i32
  }]

def test13_before := [llvmfunc|
  llvm.func @test13(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1431655767 : i32) : i32
    %1 = llvm.mlir.constant(1431655766 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.or %arg0, %0  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.add %arg1, %2  : i32
    %6 = llvm.add %5, %4  : i32
    llvm.return %6 : i32
  }]

def test14_before := [llvmfunc|
  llvm.func @test14(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1431655767 : i32) : i32
    %2 = llvm.mlir.constant(1431655766 : i32) : i32
    %3 = llvm.add %arg1, %0 overflow<nsw>  : i32
    %4 = llvm.or %arg0, %1  : i32
    %5 = llvm.xor %4, %2  : i32
    %6 = llvm.add %3, %5 overflow<nsw>  : i32
    llvm.return %6 : i32
  }]

def test15_before := [llvmfunc|
  llvm.func @test15(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1431655767 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.add %arg1, %1  : i32
    %5 = llvm.add %4, %3  : i32
    llvm.return %5 : i32
  }]

def test16_before := [llvmfunc|
  llvm.func @test16(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1431655767 : i32) : i32
    %2 = llvm.add %arg1, %0 overflow<nsw>  : i32
    %3 = llvm.and %arg0, %1  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.add %2, %4 overflow<nsw>  : i32
    llvm.return %5 : i32
  }]

def test17_before := [llvmfunc|
  llvm.func @test17(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1431655766 : i32) : i32
    %1 = llvm.mlir.constant(-1431655765 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.xor %2, %1  : i32
    %4 = llvm.add %3, %arg1 overflow<nsw>  : i32
    llvm.return %4 : i32
  }]

def test18_before := [llvmfunc|
  llvm.func @test18(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1431655766 : i32) : i32
    %2 = llvm.add %arg1, %0 overflow<nsw>  : i32
    %3 = llvm.and %arg0, %1  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.add %2, %4 overflow<nsw>  : i32
    llvm.return %5 : i32
  }]

def add_nsw_mul_nsw_before := [llvmfunc|
  llvm.func @add_nsw_mul_nsw(%arg0: i16) -> i16 {
    %0 = llvm.add %arg0, %arg0 overflow<nsw>  : i16
    %1 = llvm.add %0, %arg0 overflow<nsw>  : i16
    llvm.return %1 : i16
  }]

def mul_add_to_mul_1_before := [llvmfunc|
  llvm.func @mul_add_to_mul_1(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.mul %arg0, %0 overflow<nsw>  : i16
    %2 = llvm.add %arg0, %1 overflow<nsw>  : i16
    llvm.return %2 : i16
  }]

def mul_add_to_mul_2_before := [llvmfunc|
  llvm.func @mul_add_to_mul_2(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.mul %arg0, %0 overflow<nsw>  : i16
    %2 = llvm.add %1, %arg0 overflow<nsw>  : i16
    llvm.return %2 : i16
  }]

def mul_add_to_mul_3_before := [llvmfunc|
  llvm.func @mul_add_to_mul_3(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(2 : i16) : i16
    %1 = llvm.mlir.constant(3 : i16) : i16
    %2 = llvm.mul %arg0, %0  : i16
    %3 = llvm.mul %arg0, %1  : i16
    %4 = llvm.add %2, %3 overflow<nsw>  : i16
    llvm.return %4 : i16
  }]

def mul_add_to_mul_4_before := [llvmfunc|
  llvm.func @mul_add_to_mul_4(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(2 : i16) : i16
    %1 = llvm.mlir.constant(7 : i16) : i16
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i16
    %3 = llvm.mul %arg0, %1 overflow<nsw>  : i16
    %4 = llvm.add %2, %3 overflow<nsw>  : i16
    llvm.return %4 : i16
  }]

def mul_add_to_mul_5_before := [llvmfunc|
  llvm.func @mul_add_to_mul_5(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(3 : i16) : i16
    %1 = llvm.mlir.constant(7 : i16) : i16
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i16
    %3 = llvm.mul %arg0, %1 overflow<nsw>  : i16
    %4 = llvm.add %2, %3 overflow<nsw>  : i16
    llvm.return %4 : i16
  }]

def mul_add_to_mul_6_before := [llvmfunc|
  llvm.func @mul_add_to_mul_6(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mul %arg0, %arg1 overflow<nsw>  : i32
    %2 = llvm.mul %1, %0 overflow<nsw>  : i32
    %3 = llvm.add %1, %2 overflow<nsw>  : i32
    llvm.return %3 : i32
  }]

def mul_add_to_mul_7_before := [llvmfunc|
  llvm.func @mul_add_to_mul_7(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(32767 : i16) : i16
    %1 = llvm.mul %arg0, %0 overflow<nsw>  : i16
    %2 = llvm.add %arg0, %1 overflow<nsw>  : i16
    llvm.return %2 : i16
  }]

def mul_add_to_mul_8_before := [llvmfunc|
  llvm.func @mul_add_to_mul_8(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(16383 : i16) : i16
    %1 = llvm.mlir.constant(16384 : i16) : i16
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i16
    %3 = llvm.mul %arg0, %1 overflow<nsw>  : i16
    %4 = llvm.add %2, %3 overflow<nsw>  : i16
    llvm.return %4 : i16
  }]

def mul_add_to_mul_9_before := [llvmfunc|
  llvm.func @mul_add_to_mul_9(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(16384 : i16) : i16
    %1 = llvm.mul %arg0, %0 overflow<nsw>  : i16
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i16
    %3 = llvm.add %1, %2 overflow<nsw>  : i16
    llvm.return %3 : i16
  }]

def add_cttz_before := [llvmfunc|
  llvm.func @add_cttz(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(-8 : i16) : i16
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = true}> : (i16) -> i16]

    %2 = llvm.add %1, %0  : i16
    llvm.return %2 : i16
  }]

def add_cttz_2_before := [llvmfunc|
  llvm.func @add_cttz_2(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(-16 : i16) : i16
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = true}> : (i16) -> i16]

    %2 = llvm.add %1, %0  : i16
    llvm.return %2 : i16
  }]

def add_or_and_before := [llvmfunc|
  llvm.func @add_or_and(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.or %arg0, %arg1  : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.add %0, %1  : i32
    llvm.return %2 : i32
  }]

def add_or_and_commutative_before := [llvmfunc|
  llvm.func @add_or_and_commutative(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.or %arg0, %arg1  : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.add %0, %1  : i32
    llvm.return %2 : i32
  }]

def add_and_or_before := [llvmfunc|
  llvm.func @add_and_or(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.or %arg0, %arg1  : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.add %1, %0  : i32
    llvm.return %2 : i32
  }]

def add_and_or_commutative_before := [llvmfunc|
  llvm.func @add_and_or_commutative(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.or %arg0, %arg1  : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.add %1, %0  : i32
    llvm.return %2 : i32
  }]

def add_nsw_or_and_before := [llvmfunc|
  llvm.func @add_nsw_or_and(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.or %arg0, %arg1  : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.add %0, %1 overflow<nsw>  : i32
    llvm.return %2 : i32
  }]

def add_nuw_or_and_before := [llvmfunc|
  llvm.func @add_nuw_or_and(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.or %arg0, %arg1  : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.add %0, %1 overflow<nuw>  : i32
    llvm.return %2 : i32
  }]

def add_nuw_nsw_or_and_before := [llvmfunc|
  llvm.func @add_nuw_nsw_or_and(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.or %arg0, %arg1  : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.add %0, %1 overflow<nsw, nuw>  : i32
    llvm.return %2 : i32
  }]

def add_of_mul_before := [llvmfunc|
  llvm.func @add_of_mul(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mul %arg0, %arg1 overflow<nsw>  : i8
    %1 = llvm.mul %arg0, %arg2 overflow<nsw>  : i8
    %2 = llvm.add %0, %1 overflow<nsw>  : i8
    llvm.return %2 : i8
  }]

def add_of_selects_before := [llvmfunc|
  llvm.func @add_of_selects(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    %4 = llvm.select %arg0, %arg1, %2 : i1, i32
    %5 = llvm.add %3, %4  : i32
    llvm.return %5 : i32
  }]

def add_undemanded_low_bits_before := [llvmfunc|
  llvm.func @add_undemanded_low_bits(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(1616 : i32) : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.or %arg0, %0  : i32
    %4 = llvm.add %3, %1  : i32
    %5 = llvm.lshr %4, %2  : i32
    llvm.return %5 : i32
  }]

def sub_undemanded_low_bits_before := [llvmfunc|
  llvm.func @sub_undemanded_low_bits(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(1616 : i32) : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.or %arg0, %0  : i32
    %4 = llvm.sub %3, %1  : i32
    %5 = llvm.lshr %4, %2  : i32
    llvm.return %5 : i32
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i64, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(123 : i64) : i64
    %1 = llvm.and %arg0, %0  : i64
    llvm.return %1 : i64
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(39 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(30 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.lshr %arg0, %1  : i32
    %4 = llvm.or %2, %3  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %arg0, %0 overflow<nuw>  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.xor %arg0, %arg1  : vector<2xi1>
    llvm.return %0 : vector<2xi1>
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
def test6_combined := [llvmfunc|
  llvm.func @test6(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[5, 9]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mul %arg0, %0  : vector<2xi64>
    llvm.return %1 : vector<2xi64>
  }]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
def test7_combined := [llvmfunc|
  llvm.func @test7(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[7, 12]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mul %arg0, %0  : vector<2xi64>
    llvm.return %1 : vector<2xi64>
  }]

theorem inst_combine_test7   : test7_before  ⊑  test7_combined := by
  unfold test7_before test7_combined
  simp_alive_peephole
  sorry
def test9_combined := [llvmfunc|
  llvm.func @test9(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(-32767 : i16) : i16
    %1 = llvm.mul %arg0, %0  : i16
    llvm.return %1 : i16
  }]

theorem inst_combine_test9   : test9_before  ⊑  test9_combined := by
  unfold test9_before test9_combined
  simp_alive_peephole
  sorry
def test10_combined := [llvmfunc|
  llvm.func @test10(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(1431655765 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.sub %arg1, %3  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_test10   : test10_before  ⊑  test10_combined := by
  unfold test10_before test10_combined
  simp_alive_peephole
  sorry
def test11_combined := [llvmfunc|
  llvm.func @test11(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1431655765 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.sub %arg1, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test11   : test11_before  ⊑  test11_combined := by
  unfold test11_before test11_combined
  simp_alive_peephole
  sorry
def test12_combined := [llvmfunc|
  llvm.func @test12(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1431655765 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.sub %arg1, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test12   : test12_before  ⊑  test12_combined := by
  unfold test12_before test12_combined
  simp_alive_peephole
  sorry
def test13_combined := [llvmfunc|
  llvm.func @test13(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1431655766 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.sub %arg1, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test13   : test13_before  ⊑  test13_combined := by
  unfold test13_before test13_combined
  simp_alive_peephole
  sorry
def test14_combined := [llvmfunc|
  llvm.func @test14(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1431655766 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.sub %arg1, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test14   : test14_before  ⊑  test14_combined := by
  unfold test14_before test14_combined
  simp_alive_peephole
  sorry
def test15_combined := [llvmfunc|
  llvm.func @test15(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1431655766 : i32) : i32
    %1 = llvm.or %arg0, %0  : i32
    %2 = llvm.sub %arg1, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test15   : test15_before  ⊑  test15_combined := by
  unfold test15_before test15_combined
  simp_alive_peephole
  sorry
def test16_combined := [llvmfunc|
  llvm.func @test16(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1431655766 : i32) : i32
    %1 = llvm.or %arg0, %0  : i32
    %2 = llvm.sub %arg1, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test16   : test16_before  ⊑  test16_combined := by
  unfold test16_before test16_combined
  simp_alive_peephole
  sorry
def test17_combined := [llvmfunc|
  llvm.func @test17(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1431655765 : i32) : i32
    %1 = llvm.or %arg0, %0  : i32
    %2 = llvm.sub %arg1, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test17   : test17_before  ⊑  test17_combined := by
  unfold test17_before test17_combined
  simp_alive_peephole
  sorry
def test18_combined := [llvmfunc|
  llvm.func @test18(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1431655765 : i32) : i32
    %1 = llvm.or %arg0, %0  : i32
    %2 = llvm.sub %arg1, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test18   : test18_before  ⊑  test18_combined := by
  unfold test18_before test18_combined
  simp_alive_peephole
  sorry
def add_nsw_mul_nsw_combined := [llvmfunc|
  llvm.func @add_nsw_mul_nsw(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(3 : i16) : i16
    %1 = llvm.mul %arg0, %0 overflow<nsw>  : i16
    llvm.return %1 : i16
  }]

theorem inst_combine_add_nsw_mul_nsw   : add_nsw_mul_nsw_before  ⊑  add_nsw_mul_nsw_combined := by
  unfold add_nsw_mul_nsw_before add_nsw_mul_nsw_combined
  simp_alive_peephole
  sorry
def mul_add_to_mul_1_combined := [llvmfunc|
  llvm.func @mul_add_to_mul_1(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(9 : i16) : i16
    %1 = llvm.mul %arg0, %0 overflow<nsw>  : i16
    llvm.return %1 : i16
  }]

theorem inst_combine_mul_add_to_mul_1   : mul_add_to_mul_1_before  ⊑  mul_add_to_mul_1_combined := by
  unfold mul_add_to_mul_1_before mul_add_to_mul_1_combined
  simp_alive_peephole
  sorry
def mul_add_to_mul_2_combined := [llvmfunc|
  llvm.func @mul_add_to_mul_2(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(9 : i16) : i16
    %1 = llvm.mul %arg0, %0 overflow<nsw>  : i16
    llvm.return %1 : i16
  }]

theorem inst_combine_mul_add_to_mul_2   : mul_add_to_mul_2_before  ⊑  mul_add_to_mul_2_combined := by
  unfold mul_add_to_mul_2_before mul_add_to_mul_2_combined
  simp_alive_peephole
  sorry
def mul_add_to_mul_3_combined := [llvmfunc|
  llvm.func @mul_add_to_mul_3(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(5 : i16) : i16
    %1 = llvm.mul %arg0, %0  : i16
    llvm.return %1 : i16
  }]

theorem inst_combine_mul_add_to_mul_3   : mul_add_to_mul_3_before  ⊑  mul_add_to_mul_3_combined := by
  unfold mul_add_to_mul_3_before mul_add_to_mul_3_combined
  simp_alive_peephole
  sorry
def mul_add_to_mul_4_combined := [llvmfunc|
  llvm.func @mul_add_to_mul_4(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(9 : i16) : i16
    %1 = llvm.mul %arg0, %0 overflow<nsw>  : i16
    llvm.return %1 : i16
  }]

theorem inst_combine_mul_add_to_mul_4   : mul_add_to_mul_4_before  ⊑  mul_add_to_mul_4_combined := by
  unfold mul_add_to_mul_4_before mul_add_to_mul_4_combined
  simp_alive_peephole
  sorry
def mul_add_to_mul_5_combined := [llvmfunc|
  llvm.func @mul_add_to_mul_5(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(10 : i16) : i16
    %1 = llvm.mul %arg0, %0 overflow<nsw>  : i16
    llvm.return %1 : i16
  }]

theorem inst_combine_mul_add_to_mul_5   : mul_add_to_mul_5_before  ⊑  mul_add_to_mul_5_combined := by
  unfold mul_add_to_mul_5_before mul_add_to_mul_5_combined
  simp_alive_peephole
  sorry
def mul_add_to_mul_6_combined := [llvmfunc|
  llvm.func @mul_add_to_mul_6(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.mul %arg0, %arg1 overflow<nsw>  : i32
    %2 = llvm.mul %1, %0 overflow<nsw>  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_mul_add_to_mul_6   : mul_add_to_mul_6_before  ⊑  mul_add_to_mul_6_combined := by
  unfold mul_add_to_mul_6_before mul_add_to_mul_6_combined
  simp_alive_peephole
  sorry
def mul_add_to_mul_7_combined := [llvmfunc|
  llvm.func @mul_add_to_mul_7(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(15 : i16) : i16
    %1 = llvm.shl %arg0, %0  : i16
    llvm.return %1 : i16
  }]

theorem inst_combine_mul_add_to_mul_7   : mul_add_to_mul_7_before  ⊑  mul_add_to_mul_7_combined := by
  unfold mul_add_to_mul_7_before mul_add_to_mul_7_combined
  simp_alive_peephole
  sorry
def mul_add_to_mul_8_combined := [llvmfunc|
  llvm.func @mul_add_to_mul_8(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(32767 : i16) : i16
    %1 = llvm.mul %arg0, %0 overflow<nsw>  : i16
    llvm.return %1 : i16
  }]

theorem inst_combine_mul_add_to_mul_8   : mul_add_to_mul_8_before  ⊑  mul_add_to_mul_8_combined := by
  unfold mul_add_to_mul_8_before mul_add_to_mul_8_combined
  simp_alive_peephole
  sorry
def mul_add_to_mul_9_combined := [llvmfunc|
  llvm.func @mul_add_to_mul_9(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(15 : i16) : i16
    %1 = llvm.shl %arg0, %0  : i16
    llvm.return %1 : i16
  }]

theorem inst_combine_mul_add_to_mul_9   : mul_add_to_mul_9_before  ⊑  mul_add_to_mul_9_combined := by
  unfold mul_add_to_mul_9_before mul_add_to_mul_9_combined
  simp_alive_peephole
  sorry
def add_cttz_combined := [llvmfunc|
  llvm.func @add_cttz(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(-8 : i16) : i16
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = true}> : (i16) -> i16]

theorem inst_combine_add_cttz   : add_cttz_before  ⊑  add_cttz_combined := by
  unfold add_cttz_before add_cttz_combined
  simp_alive_peephole
  sorry
    %2 = llvm.or %1, %0  : i16
    llvm.return %2 : i16
  }]

theorem inst_combine_add_cttz   : add_cttz_before  ⊑  add_cttz_combined := by
  unfold add_cttz_before add_cttz_combined
  simp_alive_peephole
  sorry
def add_cttz_2_combined := [llvmfunc|
  llvm.func @add_cttz_2(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(-16 : i16) : i16
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = true}> : (i16) -> i16]

theorem inst_combine_add_cttz_2   : add_cttz_2_before  ⊑  add_cttz_2_combined := by
  unfold add_cttz_2_before add_cttz_2_combined
  simp_alive_peephole
  sorry
    %2 = llvm.or %1, %0  : i16
    llvm.return %2 : i16
  }]

theorem inst_combine_add_cttz_2   : add_cttz_2_before  ⊑  add_cttz_2_combined := by
  unfold add_cttz_2_before add_cttz_2_combined
  simp_alive_peephole
  sorry
def add_or_and_combined := [llvmfunc|
  llvm.func @add_or_and(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.add %arg0, %arg1  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_add_or_and   : add_or_and_before  ⊑  add_or_and_combined := by
  unfold add_or_and_before add_or_and_combined
  simp_alive_peephole
  sorry
def add_or_and_commutative_combined := [llvmfunc|
  llvm.func @add_or_and_commutative(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.add %arg0, %arg1  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_add_or_and_commutative   : add_or_and_commutative_before  ⊑  add_or_and_commutative_combined := by
  unfold add_or_and_commutative_before add_or_and_commutative_combined
  simp_alive_peephole
  sorry
def add_and_or_combined := [llvmfunc|
  llvm.func @add_and_or(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.add %arg0, %arg1  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_add_and_or   : add_and_or_before  ⊑  add_and_or_combined := by
  unfold add_and_or_before add_and_or_combined
  simp_alive_peephole
  sorry
def add_and_or_commutative_combined := [llvmfunc|
  llvm.func @add_and_or_commutative(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.add %arg0, %arg1  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_add_and_or_commutative   : add_and_or_commutative_before  ⊑  add_and_or_commutative_combined := by
  unfold add_and_or_commutative_before add_and_or_commutative_combined
  simp_alive_peephole
  sorry
def add_nsw_or_and_combined := [llvmfunc|
  llvm.func @add_nsw_or_and(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.add %arg0, %arg1 overflow<nsw>  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_add_nsw_or_and   : add_nsw_or_and_before  ⊑  add_nsw_or_and_combined := by
  unfold add_nsw_or_and_before add_nsw_or_and_combined
  simp_alive_peephole
  sorry
def add_nuw_or_and_combined := [llvmfunc|
  llvm.func @add_nuw_or_and(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.add %arg0, %arg1 overflow<nuw>  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_add_nuw_or_and   : add_nuw_or_and_before  ⊑  add_nuw_or_and_combined := by
  unfold add_nuw_or_and_before add_nuw_or_and_combined
  simp_alive_peephole
  sorry
def add_nuw_nsw_or_and_combined := [llvmfunc|
  llvm.func @add_nuw_nsw_or_and(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.add %arg0, %arg1 overflow<nsw, nuw>  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_add_nuw_nsw_or_and   : add_nuw_nsw_or_and_before  ⊑  add_nuw_nsw_or_and_combined := by
  unfold add_nuw_nsw_or_and_before add_nuw_nsw_or_and_combined
  simp_alive_peephole
  sorry
def add_of_mul_combined := [llvmfunc|
  llvm.func @add_of_mul(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.add %arg1, %arg2  : i8
    %1 = llvm.mul %0, %arg0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_add_of_mul   : add_of_mul_before  ⊑  add_of_mul_combined := by
  unfold add_of_mul_before add_of_mul_combined
  simp_alive_peephole
  sorry
def add_of_selects_combined := [llvmfunc|
  llvm.func @add_of_selects(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.select %arg0, %arg1, %0 : i1, i32
    llvm.return %1 : i32
  }]

theorem inst_combine_add_of_selects   : add_of_selects_before  ⊑  add_of_selects_combined := by
  unfold add_of_selects_before add_of_selects_combined
  simp_alive_peephole
  sorry
def add_undemanded_low_bits_combined := [llvmfunc|
  llvm.func @add_undemanded_low_bits(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1616 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_add_undemanded_low_bits   : add_undemanded_low_bits_before  ⊑  add_undemanded_low_bits_combined := by
  unfold add_undemanded_low_bits_before add_undemanded_low_bits_combined
  simp_alive_peephole
  sorry
def sub_undemanded_low_bits_combined := [llvmfunc|
  llvm.func @sub_undemanded_low_bits(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1616 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_sub_undemanded_low_bits   : sub_undemanded_low_bits_before  ⊑  sub_undemanded_low_bits_combined := by
  unfold sub_undemanded_low_bits_before sub_undemanded_low_bits_combined
  simp_alive_peephole
  sorry
