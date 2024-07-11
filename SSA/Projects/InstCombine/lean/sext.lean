import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  sext
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i32) -> i64 {
    %0 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %1 = llvm.sext %0 : i32 to i64
    llvm.return %1 : i64
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i32) -> i64 {
    %0 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32]

    %1 = llvm.sext %0 : i32 to i64
    llvm.return %1 : i64
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: i32) -> i64 {
    %0 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32]

    %1 = llvm.sext %0 : i32 to i64
    llvm.return %1 : i64
  }]

def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.udiv %arg0, %0  : i32
    %2 = llvm.sext %1 : i32 to i64
    llvm.return %2 : i64
  }]

def test5_before := [llvmfunc|
  llvm.func @test5(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(30000 : i32) : i32
    %1 = llvm.urem %arg0, %0  : i32
    %2 = llvm.sext %1 : i32 to i64
    llvm.return %2 : i64
  }]

def test6_before := [llvmfunc|
  llvm.func @test6(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.mul %1, %0  : i32
    %3 = llvm.sext %2 : i32 to i64
    llvm.return %3 : i64
  }]

def test7_before := [llvmfunc|
  llvm.func @test7(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(511 : i32) : i32
    %1 = llvm.mlir.constant(20000 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.sub %1, %2  : i32
    %4 = llvm.sext %3 : i32 to i64
    llvm.return %4 : i64
  }]

def test8_before := [llvmfunc|
  llvm.func @test8(%arg0: i8, %arg1: i32, %arg2: i1, %arg3: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg1, %0  : i32
    %3 = llvm.select %arg2, %2, %1 : i1, i32
    %4 = llvm.trunc %3 : i32 to i16
    %5 = llvm.sext %4 : i16 to i32
    llvm.return %5 : i32
  }]

def test9_before := [llvmfunc|
  llvm.func @test9(%arg0: i16, %arg1: i1) -> i16 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    llvm.cond_br %arg1, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    %1 = llvm.sext %arg0 : i16 to i32
    llvm.br ^bb2(%1 : i32)
  ^bb2(%2: i32):  // 2 preds: ^bb0, ^bb1
    %3 = llvm.trunc %2 : i32 to i16
    llvm.return %3 : i16
  }]

def test10_before := [llvmfunc|
  llvm.func @test10(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.trunc %arg0 : i32 to i8
    %2 = llvm.shl %1, %0  : i8
    %3 = llvm.ashr %2, %0  : i8
    %4 = llvm.sext %3 : i8 to i32
    llvm.return %4 : i32
  }]

def test10_vec_before := [llvmfunc|
  llvm.func @test10_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<6> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.trunc %arg0 : vector<2xi32> to vector<2xi8>
    %2 = llvm.shl %1, %0  : vector<2xi8>
    %3 = llvm.ashr %2, %0  : vector<2xi8>
    %4 = llvm.sext %3 : vector<2xi8> to vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def test10_vec_nonuniform_before := [llvmfunc|
  llvm.func @test10_vec_nonuniform(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[6, 3]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.trunc %arg0 : vector<2xi32> to vector<2xi8>
    %2 = llvm.shl %1, %0  : vector<2xi8>
    %3 = llvm.ashr %2, %0  : vector<2xi8>
    %4 = llvm.sext %3 : vector<2xi8> to vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def test10_vec_poison0_before := [llvmfunc|
  llvm.func @test10_vec_poison0(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[6, 0]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.constant(6 : i8) : i8
    %3 = llvm.mlir.undef : vector<2xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi8>
    %8 = llvm.trunc %arg0 : vector<2xi32> to vector<2xi8>
    %9 = llvm.shl %8, %0  : vector<2xi8>
    %10 = llvm.ashr %9, %7  : vector<2xi8>
    %11 = llvm.sext %10 : vector<2xi8> to vector<2xi32>
    llvm.return %11 : vector<2xi32>
  }]

def test10_vec_poison1_before := [llvmfunc|
  llvm.func @test10_vec_poison1(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(dense<[6, 0]> : vector<2xi8>) : vector<2xi8>
    %8 = llvm.trunc %arg0 : vector<2xi32> to vector<2xi8>
    %9 = llvm.shl %8, %6  : vector<2xi8>
    %10 = llvm.ashr %9, %7  : vector<2xi8>
    %11 = llvm.sext %10 : vector<2xi8> to vector<2xi32>
    llvm.return %11 : vector<2xi32>
  }]

def test10_vec_poison2_before := [llvmfunc|
  llvm.func @test10_vec_poison2(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.trunc %arg0 : vector<2xi32> to vector<2xi8>
    %8 = llvm.shl %7, %6  : vector<2xi8>
    %9 = llvm.ashr %8, %6  : vector<2xi8>
    %10 = llvm.sext %9 : vector<2xi8> to vector<2xi32>
    llvm.return %10 : vector<2xi32>
  }]

def test11_before := [llvmfunc|
  llvm.func @test11(%arg0: vector<2xi16>, %arg1: vector<2xi16>, %arg2: !llvm.ptr) {
    %0 = llvm.mlir.constant(dense<15> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.icmp "eq" %arg1, %arg0 : vector<2xi16>
    %2 = llvm.sext %1 : vector<2xi1> to vector<2xi16>
    %3 = llvm.ashr %2, %0  : vector<2xi16>
    llvm.store %3, %arg2 {alignment = 4 : i64} : vector<2xi16>, !llvm.ptr]

    llvm.return
  }]

def test12_before := [llvmfunc|
  llvm.func @test12(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.sub %1, %2 overflow<nsw>  : i32
    %4 = llvm.sext %3 : i32 to i64
    llvm.return %4 : i64
  }]

def test13_before := [llvmfunc|
  llvm.func @test13(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.sext %3 : i1 to i32
    llvm.return %4 : i32
  }]

def test14_before := [llvmfunc|
  llvm.func @test14(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(16 : i16) : i16
    %1 = llvm.and %arg0, %0  : i16
    %2 = llvm.icmp "ne" %1, %0 : i16
    %3 = llvm.sext %2 : i1 to i32
    llvm.return %3 : i32
  }]

def test15_before := [llvmfunc|
  llvm.func @test15(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    %4 = llvm.sext %3 : i1 to i32
    llvm.return %4 : i32
  }]

def test16_before := [llvmfunc|
  llvm.func @test16(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.and %arg0, %0  : i16
    %2 = llvm.icmp "eq" %1, %0 : i16
    %3 = llvm.sext %2 : i1 to i32
    llvm.return %3 : i32
  }]

def test17_before := [llvmfunc|
  llvm.func @test17(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sub %0, %1  : i32
    llvm.return %2 : i32
  }]

def test18_before := [llvmfunc|
  llvm.func @test18(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.icmp "slt" %arg0, %0 : i16
    %2 = llvm.select %1, %0, %arg0 : i1, i16
    %3 = llvm.sext %2 : i16 to i32
    llvm.return %3 : i32
  }]

def test19_before := [llvmfunc|
  llvm.func @test19(%arg0: i10) -> i10 {
    %0 = llvm.mlir.constant(2 : i3) : i3
    %1 = llvm.trunc %arg0 : i10 to i3
    %2 = llvm.shl %1, %0  : i3
    %3 = llvm.ashr %2, %0  : i3
    %4 = llvm.sext %3 : i3 to i10
    llvm.return %4 : i10
  }]

def smear_set_bit_before := [llvmfunc|
  llvm.func @smear_set_bit(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.trunc %arg0 : i32 to i8
    %2 = llvm.ashr %1, %0  : i8
    %3 = llvm.sext %2 : i8 to i32
    llvm.return %3 : i32
  }]

def smear_set_bit_vec_use1_before := [llvmfunc|
  llvm.func @smear_set_bit_vec_use1(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(4 : i5) : i5
    %1 = llvm.mlir.constant(dense<4> : vector<2xi5>) : vector<2xi5>
    %2 = llvm.trunc %arg0 : vector<2xi32> to vector<2xi5>
    llvm.call @use_vec(%2) : (vector<2xi5>) -> ()
    %3 = llvm.ashr %2, %1  : vector<2xi5>
    %4 = llvm.sext %3 : vector<2xi5> to vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def smear_set_bit_use2_before := [llvmfunc|
  llvm.func @smear_set_bit_use2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.trunc %arg0 : i32 to i8
    %2 = llvm.ashr %1, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.sext %2 : i8 to i32
    llvm.return %3 : i32
  }]

def smear_set_bit_wrong_shift_amount_before := [llvmfunc|
  llvm.func @smear_set_bit_wrong_shift_amount(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.trunc %arg0 : i32 to i8
    %2 = llvm.ashr %1, %0  : i8
    %3 = llvm.sext %2 : i8 to i32
    llvm.return %3 : i32
  }]

def smear_set_bit_different_dest_type_before := [llvmfunc|
  llvm.func @smear_set_bit_different_dest_type(%arg0: i32) -> i16 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.trunc %arg0 : i32 to i8
    %2 = llvm.ashr %1, %0  : i8
    %3 = llvm.sext %2 : i8 to i16
    llvm.return %3 : i16
  }]

def smear_set_bit_different_dest_type_extra_use_before := [llvmfunc|
  llvm.func @smear_set_bit_different_dest_type_extra_use(%arg0: i32) -> i16 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.trunc %arg0 : i32 to i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.ashr %1, %0  : i8
    %3 = llvm.sext %2 : i8 to i16
    llvm.return %3 : i16
  }]

def smear_set_bit_different_dest_type_wider_dst_before := [llvmfunc|
  llvm.func @smear_set_bit_different_dest_type_wider_dst(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.trunc %arg0 : i32 to i8
    %2 = llvm.ashr %1, %0  : i8
    %3 = llvm.sext %2 : i8 to i64
    llvm.return %3 : i64
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i32) -> i64 {
    %0 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %1 = llvm.zext %0 : i32 to i64
    llvm.return %1 : i64
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i32) -> i64 {
    %0 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32
    %1 = llvm.zext %0 : i32 to i64
    llvm.return %1 : i64
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: i32) -> i64 {
    %0 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32
    %1 = llvm.zext %0 : i32 to i64
    llvm.return %1 : i64
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.udiv %arg0, %0  : i32
    %2 = llvm.zext %1 : i32 to i64
    llvm.return %2 : i64
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(30000 : i32) : i32
    %1 = llvm.urem %arg0, %0  : i32
    %2 = llvm.zext %1 : i32 to i64
    llvm.return %2 : i64
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
def test6_combined := [llvmfunc|
  llvm.func @test6(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.mul %1, %0 overflow<nsw, nuw>  : i32
    %3 = llvm.zext %2 : i32 to i64
    llvm.return %3 : i64
  }]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
def test7_combined := [llvmfunc|
  llvm.func @test7(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(511 : i32) : i32
    %1 = llvm.mlir.constant(20000 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.sub %1, %2 overflow<nsw, nuw>  : i32
    %4 = llvm.zext %3 : i32 to i64
    llvm.return %4 : i64
  }]

theorem inst_combine_test7   : test7_before  ⊑  test7_combined := by
  unfold test7_before test7_combined
  simp_alive_peephole
  sorry
def test8_combined := [llvmfunc|
  llvm.func @test8(%arg0: i8, %arg1: i32, %arg2: i1, %arg3: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg1, %0  : i32
    %3 = llvm.select %arg2, %2, %1 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test8   : test8_before  ⊑  test8_combined := by
  unfold test8_before test8_combined
  simp_alive_peephole
  sorry
def test9_combined := [llvmfunc|
  llvm.func @test9(%arg0: i16, %arg1: i1) -> i16 {
    %0 = llvm.mlir.constant(42 : i16) : i16
    llvm.cond_br %arg1, ^bb1, ^bb2(%0 : i16)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%arg0 : i16)
  ^bb2(%1: i16):  // 2 preds: ^bb0, ^bb1
    llvm.return %1 : i16
  }]

theorem inst_combine_test9   : test9_before  ⊑  test9_combined := by
  unfold test9_before test9_combined
  simp_alive_peephole
  sorry
def test10_combined := [llvmfunc|
  llvm.func @test10(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(30 : i32) : i32
    %1 = llvm.shl %arg0, %0  : i32
    %2 = llvm.ashr %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test10   : test10_before  ⊑  test10_combined := by
  unfold test10_before test10_combined
  simp_alive_peephole
  sorry
def test10_vec_combined := [llvmfunc|
  llvm.func @test10_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<30> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.shl %arg0, %0  : vector<2xi32>
    %2 = llvm.ashr %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_test10_vec   : test10_vec_before  ⊑  test10_vec_combined := by
  unfold test10_vec_before test10_vec_combined
  simp_alive_peephole
  sorry
def test10_vec_nonuniform_combined := [llvmfunc|
  llvm.func @test10_vec_nonuniform(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[30, 27]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.shl %arg0, %0  : vector<2xi32>
    %2 = llvm.ashr %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_test10_vec_nonuniform   : test10_vec_nonuniform_before  ⊑  test10_vec_nonuniform_combined := by
  unfold test10_vec_nonuniform_before test10_vec_nonuniform_combined
  simp_alive_peephole
  sorry
def test10_vec_poison0_combined := [llvmfunc|
  llvm.func @test10_vec_poison0(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(30 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.shl %arg0, %6  : vector<2xi32>
    %8 = llvm.ashr %7, %6  : vector<2xi32>
    llvm.return %8 : vector<2xi32>
  }]

theorem inst_combine_test10_vec_poison0   : test10_vec_poison0_before  ⊑  test10_vec_poison0_combined := by
  unfold test10_vec_poison0_before test10_vec_poison0_combined
  simp_alive_peephole
  sorry
def test10_vec_poison1_combined := [llvmfunc|
  llvm.func @test10_vec_poison1(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.mlir.constant(30 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.shl %arg0, %6  : vector<2xi32>
    %8 = llvm.ashr %7, %6  : vector<2xi32>
    llvm.return %8 : vector<2xi32>
  }]

theorem inst_combine_test10_vec_poison1   : test10_vec_poison1_before  ⊑  test10_vec_poison1_combined := by
  unfold test10_vec_poison1_before test10_vec_poison1_combined
  simp_alive_peephole
  sorry
def test10_vec_poison2_combined := [llvmfunc|
  llvm.func @test10_vec_poison2(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(30 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.shl %arg0, %6  : vector<2xi32>
    %8 = llvm.ashr %7, %6  : vector<2xi32>
    llvm.return %8 : vector<2xi32>
  }]

theorem inst_combine_test10_vec_poison2   : test10_vec_poison2_before  ⊑  test10_vec_poison2_combined := by
  unfold test10_vec_poison2_before test10_vec_poison2_combined
  simp_alive_peephole
  sorry
def test11_combined := [llvmfunc|
  llvm.func @test11(%arg0: vector<2xi16>, %arg1: vector<2xi16>, %arg2: !llvm.ptr) {
    %0 = llvm.icmp "eq" %arg1, %arg0 : vector<2xi16>
    %1 = llvm.sext %0 : vector<2xi1> to vector<2xi16>
    llvm.store %1, %arg2 {alignment = 4 : i64} : vector<2xi16>, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_test11   : test11_before  ⊑  test11_combined := by
  unfold test11_before test11_combined
  simp_alive_peephole
  sorry
def test12_combined := [llvmfunc|
  llvm.func @test12(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.sub %1, %2 overflow<nsw>  : i32
    %4 = llvm.sext %3 : i32 to i64
    llvm.return %4 : i64
  }]

theorem inst_combine_test12   : test12_before  ⊑  test12_combined := by
  unfold test12_before test12_combined
  simp_alive_peephole
  sorry
def test13_combined := [llvmfunc|
  llvm.func @test13(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.add %4, %2 overflow<nsw>  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_test13   : test13_before  ⊑  test13_combined := by
  unfold test13_before test13_combined
  simp_alive_peephole
  sorry
def test14_combined := [llvmfunc|
  llvm.func @test14(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(4 : i16) : i16
    %1 = llvm.mlir.constant(1 : i16) : i16
    %2 = llvm.mlir.constant(-1 : i16) : i16
    %3 = llvm.lshr %arg0, %0  : i16
    %4 = llvm.and %3, %1  : i16
    %5 = llvm.add %4, %2 overflow<nsw>  : i16
    %6 = llvm.sext %5 : i16 to i32
    llvm.return %6 : i32
  }]

theorem inst_combine_test14   : test14_before  ⊑  test14_combined := by
  unfold test14_before test14_combined
  simp_alive_peephole
  sorry
def test15_combined := [llvmfunc|
  llvm.func @test15(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(27 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.ashr %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test15   : test15_before  ⊑  test15_combined := by
  unfold test15_before test15_combined
  simp_alive_peephole
  sorry
def test16_combined := [llvmfunc|
  llvm.func @test16(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(12 : i16) : i16
    %1 = llvm.mlir.constant(15 : i16) : i16
    %2 = llvm.shl %arg0, %0  : i16
    %3 = llvm.ashr %2, %1  : i16
    %4 = llvm.sext %3 : i16 to i32
    llvm.return %4 : i32
  }]

theorem inst_combine_test16   : test16_before  ⊑  test16_combined := by
  unfold test16_before test16_combined
  simp_alive_peephole
  sorry
def test17_combined := [llvmfunc|
  llvm.func @test17(%arg0: i1) -> i32 {
    %0 = llvm.zext %arg0 : i1 to i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test17   : test17_before  ⊑  test17_combined := by
  unfold test17_before test17_combined
  simp_alive_peephole
  sorry
def test18_combined := [llvmfunc|
  llvm.func @test18(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.intr.smax(%arg0, %0)  : (i16, i16) -> i16
    %2 = llvm.zext %1 : i16 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test18   : test18_before  ⊑  test18_combined := by
  unfold test18_before test18_combined
  simp_alive_peephole
  sorry
def test19_combined := [llvmfunc|
  llvm.func @test19(%arg0: i10) -> i10 {
    %0 = llvm.mlir.constant(1 : i3) : i3
    %1 = llvm.mlir.constant(0 : i3) : i3
    %2 = llvm.trunc %arg0 : i10 to i3
    %3 = llvm.and %2, %0  : i3
    %4 = llvm.sub %1, %3 overflow<nsw>  : i3
    %5 = llvm.sext %4 : i3 to i10
    llvm.return %5 : i10
  }]

theorem inst_combine_test19   : test19_before  ⊑  test19_combined := by
  unfold test19_before test19_combined
  simp_alive_peephole
  sorry
def smear_set_bit_combined := [llvmfunc|
  llvm.func @smear_set_bit(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.ashr %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_smear_set_bit   : smear_set_bit_before  ⊑  smear_set_bit_combined := by
  unfold smear_set_bit_before smear_set_bit_combined
  simp_alive_peephole
  sorry
def smear_set_bit_vec_use1_combined := [llvmfunc|
  llvm.func @smear_set_bit_vec_use1(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<27> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<31> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.trunc %arg0 : vector<2xi32> to vector<2xi5>
    llvm.call @use_vec(%2) : (vector<2xi5>) -> ()
    %3 = llvm.shl %arg0, %0  : vector<2xi32>
    %4 = llvm.ashr %3, %1  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

theorem inst_combine_smear_set_bit_vec_use1   : smear_set_bit_vec_use1_before  ⊑  smear_set_bit_vec_use1_combined := by
  unfold smear_set_bit_vec_use1_before smear_set_bit_vec_use1_combined
  simp_alive_peephole
  sorry
def smear_set_bit_use2_combined := [llvmfunc|
  llvm.func @smear_set_bit_use2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.trunc %arg0 : i32 to i8
    %2 = llvm.ashr %1, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.sext %2 : i8 to i32
    llvm.return %3 : i32
  }]

theorem inst_combine_smear_set_bit_use2   : smear_set_bit_use2_before  ⊑  smear_set_bit_use2_combined := by
  unfold smear_set_bit_use2_before smear_set_bit_use2_combined
  simp_alive_peephole
  sorry
def smear_set_bit_wrong_shift_amount_combined := [llvmfunc|
  llvm.func @smear_set_bit_wrong_shift_amount(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.trunc %arg0 : i32 to i8
    %2 = llvm.ashr %1, %0  : i8
    %3 = llvm.sext %2 : i8 to i32
    llvm.return %3 : i32
  }]

theorem inst_combine_smear_set_bit_wrong_shift_amount   : smear_set_bit_wrong_shift_amount_before  ⊑  smear_set_bit_wrong_shift_amount_combined := by
  unfold smear_set_bit_wrong_shift_amount_before smear_set_bit_wrong_shift_amount_combined
  simp_alive_peephole
  sorry
def smear_set_bit_different_dest_type_combined := [llvmfunc|
  llvm.func @smear_set_bit_different_dest_type(%arg0: i32) -> i16 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.ashr %2, %1  : i32
    %4 = llvm.trunc %3 : i32 to i16
    llvm.return %4 : i16
  }]

theorem inst_combine_smear_set_bit_different_dest_type   : smear_set_bit_different_dest_type_before  ⊑  smear_set_bit_different_dest_type_combined := by
  unfold smear_set_bit_different_dest_type_before smear_set_bit_different_dest_type_combined
  simp_alive_peephole
  sorry
def smear_set_bit_different_dest_type_extra_use_combined := [llvmfunc|
  llvm.func @smear_set_bit_different_dest_type_extra_use(%arg0: i32) -> i16 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.trunc %arg0 : i32 to i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.ashr %1, %0  : i8
    %3 = llvm.sext %2 : i8 to i16
    llvm.return %3 : i16
  }]

theorem inst_combine_smear_set_bit_different_dest_type_extra_use   : smear_set_bit_different_dest_type_extra_use_before  ⊑  smear_set_bit_different_dest_type_extra_use_combined := by
  unfold smear_set_bit_different_dest_type_extra_use_before smear_set_bit_different_dest_type_extra_use_combined
  simp_alive_peephole
  sorry
def smear_set_bit_different_dest_type_wider_dst_combined := [llvmfunc|
  llvm.func @smear_set_bit_different_dest_type_wider_dst(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.ashr %2, %1  : i32
    %4 = llvm.sext %3 : i32 to i64
    llvm.return %4 : i64
  }]

theorem inst_combine_smear_set_bit_different_dest_type_wider_dst   : smear_set_bit_different_dest_type_wider_dst_before  ⊑  smear_set_bit_different_dest_type_wider_dst_combined := by
  unfold smear_set_bit_different_dest_type_wider_dst_before smear_set_bit_different_dest_type_wider_dst_combined
  simp_alive_peephole
  sorry
