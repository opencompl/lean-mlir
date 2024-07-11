import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  ctpop
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.intr.ctpop(%2)  : (i32) -> i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.intr.ctpop(%2)  : (i32) -> i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }]

def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.intr.ctpop(%arg0)  : (i8) -> i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

def test5_before := [llvmfunc|
  llvm.func @test5(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.intr.ctpop(%1)  : (i32) -> i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    llvm.return %3 : i1
  }]

def test5vec_before := [llvmfunc|
  llvm.func @test5vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.and %arg0, %0  : vector<2xi32>
    %2 = llvm.intr.ctpop(%1)  : (vector<2xi32>) -> vector<2xi32>
    %3 = llvm.icmp "eq" %2, %0 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

def test6_before := [llvmfunc|
  llvm.func @test6(%arg0: i1) -> i1 {
    %0 = llvm.intr.ctpop(%arg0)  : (i1) -> i1
    llvm.return %0 : i1
  }]

def mask_one_bit_before := [llvmfunc|
  llvm.func @mask_one_bit(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.intr.ctpop(%1)  : (i8) -> i8
    llvm.return %2 : i8
  }]

def mask_one_bit_splat_before := [llvmfunc|
  llvm.func @mask_one_bit_splat(%arg0: vector<2xi32>, %arg1: !llvm.ptr) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<2048> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.and %arg0, %0  : vector<2xi32>
    llvm.store %1, %arg1 {alignment = 8 : i64} : vector<2xi32>, !llvm.ptr]

    %2 = llvm.intr.ctpop(%1)  : (vector<2xi32>) -> vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def _parity_of_not_before := [llvmfunc|
  llvm.func @_parity_of_not(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.intr.ctpop(%2)  : (i32) -> i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }]

def _parity_of_not_odd_type_before := [llvmfunc|
  llvm.func @_parity_of_not_odd_type(%arg0: i7) -> i7 {
    %0 = llvm.mlir.constant(-1 : i7) : i7
    %1 = llvm.mlir.constant(1 : i7) : i7
    %2 = llvm.xor %arg0, %0  : i7
    %3 = llvm.intr.ctpop(%2)  : (i7) -> i7
    %4 = llvm.and %3, %1  : i7
    llvm.return %4 : i7
  }]

def _parity_of_not_vec_before := [llvmfunc|
  llvm.func @_parity_of_not_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.xor %arg0, %0  : vector<2xi32>
    %3 = llvm.intr.ctpop(%2)  : (vector<2xi32>) -> vector<2xi32>
    %4 = llvm.and %3, %1  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def _parity_of_not_poison_before := [llvmfunc|
  llvm.func @_parity_of_not_poison(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %8 = llvm.xor %arg0, %6  : vector<2xi32>
    %9 = llvm.intr.ctpop(%8)  : (vector<2xi32>) -> vector<2xi32>
    %10 = llvm.and %9, %7  : vector<2xi32>
    llvm.return %10 : vector<2xi32>
  }]

def _parity_of_not_poison2_before := [llvmfunc|
  llvm.func @_parity_of_not_poison2(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.undef : vector<2xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi32>
    %8 = llvm.xor %arg0, %0  : vector<2xi32>
    %9 = llvm.intr.ctpop(%8)  : (vector<2xi32>) -> vector<2xi32>
    %10 = llvm.and %9, %7  : vector<2xi32>
    llvm.return %10 : vector<2xi32>
  }]

def ctpop_add_before := [llvmfunc|
  llvm.func @ctpop_add(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.intr.ctpop(%2)  : (i32) -> i32
    %4 = llvm.and %arg1, %1  : i32
    %5 = llvm.intr.ctpop(%4)  : (i32) -> i32
    %6 = llvm.add %3, %5  : i32
    llvm.return %6 : i32
  }]

def ctpop_add_no_common_bits_before := [llvmfunc|
  llvm.func @ctpop_add_no_common_bits(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.shl %arg0, %0  : i32
    %2 = llvm.intr.ctpop(%1)  : (i32) -> i32
    %3 = llvm.lshr %arg1, %0  : i32
    %4 = llvm.intr.ctpop(%3)  : (i32) -> i32
    %5 = llvm.add %2, %4  : i32
    llvm.return %5 : i32
  }]

def ctpop_add_no_common_bits_vec_before := [llvmfunc|
  llvm.func @ctpop_add_no_common_bits_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.shl %arg0, %0  : vector<2xi32>
    %2 = llvm.intr.ctpop(%1)  : (vector<2xi32>) -> vector<2xi32>
    %3 = llvm.lshr %arg1, %0  : vector<2xi32>
    %4 = llvm.intr.ctpop(%3)  : (vector<2xi32>) -> vector<2xi32>
    %5 = llvm.add %2, %4  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

def ctpop_add_no_common_bits_vec_use_before := [llvmfunc|
  llvm.func @ctpop_add_no_common_bits_vec_use(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: !llvm.ptr) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.shl %arg0, %0  : vector<2xi32>
    %2 = llvm.intr.ctpop(%1)  : (vector<2xi32>) -> vector<2xi32>
    %3 = llvm.lshr %arg1, %0  : vector<2xi32>
    %4 = llvm.intr.ctpop(%3)  : (vector<2xi32>) -> vector<2xi32>
    llvm.store %4, %arg2 {alignment = 8 : i64} : vector<2xi32>, !llvm.ptr]

    %5 = llvm.add %2, %4  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

def ctpop_add_no_common_bits_vec_use2_before := [llvmfunc|
  llvm.func @ctpop_add_no_common_bits_vec_use2(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: !llvm.ptr) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.shl %arg0, %0  : vector<2xi32>
    %2 = llvm.intr.ctpop(%1)  : (vector<2xi32>) -> vector<2xi32>
    llvm.store %2, %arg2 {alignment = 8 : i64} : vector<2xi32>, !llvm.ptr]

    %3 = llvm.lshr %arg1, %0  : vector<2xi32>
    %4 = llvm.intr.ctpop(%3)  : (vector<2xi32>) -> vector<2xi32>
    %5 = llvm.add %2, %4  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

def ctpop_rotate_left_before := [llvmfunc|
  llvm.func @ctpop_rotate_left(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.fshl(%arg0, %arg0, %arg1)  : (i8, i8, i8) -> i8
    %1 = llvm.intr.ctpop(%0)  : (i8) -> i8
    llvm.return %1 : i8
  }]

def ctpop_rotate_right_before := [llvmfunc|
  llvm.func @ctpop_rotate_right(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.fshr(%arg0, %arg0, %arg1)  : (i8, i8, i8) -> i8
    %1 = llvm.intr.ctpop(%0)  : (i8) -> i8
    llvm.return %1 : i8
  }]

def sub_ctpop_before := [llvmfunc|
  llvm.func @sub_ctpop(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(8 : i8) : i8
    %1 = llvm.intr.ctpop(%arg0)  : (i8) -> i8
    %2 = llvm.sub %0, %1  : i8
    llvm.return %2 : i8
  }]

def sub_ctpop_wrong_cst_before := [llvmfunc|
  llvm.func @sub_ctpop_wrong_cst(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.intr.ctpop(%arg0)  : (i8) -> i8
    %2 = llvm.sub %0, %1  : i8
    llvm.return %2 : i8
  }]

def sub_ctpop_unknown_before := [llvmfunc|
  llvm.func @sub_ctpop_unknown(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.ctpop(%arg0)  : (i8) -> i8
    %1 = llvm.sub %arg1, %0  : i8
    llvm.return %1 : i8
  }]

def sub_ctpop_vec_before := [llvmfunc|
  llvm.func @sub_ctpop_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.ctpop(%arg0)  : (vector<2xi32>) -> vector<2xi32>
    %2 = llvm.sub %0, %1  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def sub_ctpop_vec_extra_use_before := [llvmfunc|
  llvm.func @sub_ctpop_vec_extra_use(%arg0: vector<2xi32>, %arg1: !llvm.ptr) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.ctpop(%arg0)  : (vector<2xi32>) -> vector<2xi32>
    llvm.store %1, %arg1 {alignment = 8 : i64} : vector<2xi32>, !llvm.ptr]

    %2 = llvm.sub %0, %1  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def zext_ctpop_before := [llvmfunc|
  llvm.func @zext_ctpop(%arg0: i16) -> i32 {
    %0 = llvm.zext %arg0 : i16 to i32
    %1 = llvm.intr.ctpop(%0)  : (i32) -> i32
    llvm.return %1 : i32
  }]

def zext_ctpop_vec_before := [llvmfunc|
  llvm.func @zext_ctpop_vec(%arg0: vector<2xi7>) -> vector<2xi32> {
    %0 = llvm.zext %arg0 : vector<2xi7> to vector<2xi32>
    %1 = llvm.intr.ctpop(%0)  : (vector<2xi32>) -> vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

def zext_ctpop_extra_use_before := [llvmfunc|
  llvm.func @zext_ctpop_extra_use(%arg0: i16, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.zext %arg0 : i16 to i32
    llvm.store %0, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

    %1 = llvm.intr.ctpop(%0)  : (i32) -> i32
    llvm.return %1 : i32
  }]

def parity_xor_before := [llvmfunc|
  llvm.func @parity_xor(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %2 = llvm.intr.ctpop(%arg1)  : (i32) -> i32
    %3 = llvm.xor %2, %1  : i32
    %4 = llvm.and %3, %0  : i32
    llvm.return %4 : i32
  }]

def parity_xor_trunc_before := [llvmfunc|
  llvm.func @parity_xor_trunc(%arg0: i64, %arg1: i64) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.intr.ctpop(%arg0)  : (i64) -> i64
    %2 = llvm.intr.ctpop(%arg1)  : (i64) -> i64
    %3 = llvm.xor %2, %1  : i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.and %4, %0  : i32
    llvm.return %5 : i32
  }]

def parity_xor_vec_before := [llvmfunc|
  llvm.func @parity_xor_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.ctpop(%arg0)  : (vector<2xi32>) -> vector<2xi32>
    %2 = llvm.intr.ctpop(%arg1)  : (vector<2xi32>) -> vector<2xi32>
    %3 = llvm.xor %2, %1  : vector<2xi32>
    %4 = llvm.and %3, %0  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def parity_xor_wrong_cst_before := [llvmfunc|
  llvm.func @parity_xor_wrong_cst(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %2 = llvm.intr.ctpop(%arg1)  : (i32) -> i32
    %3 = llvm.xor %2, %1  : i32
    %4 = llvm.and %3, %0  : i32
    llvm.return %4 : i32
  }]

def parity_xor_extra_use_before := [llvmfunc|
  llvm.func @parity_xor_extra_use(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %2 = llvm.and %1, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.intr.ctpop(%arg1)  : (i32) -> i32
    %4 = llvm.and %3, %0  : i32
    %5 = llvm.xor %4, %2  : i32
    llvm.return %5 : i32
  }]

def parity_xor_extra_use2_before := [llvmfunc|
  llvm.func @parity_xor_extra_use2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.intr.ctpop(%arg1)  : (i32) -> i32
    %2 = llvm.and %1, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %4 = llvm.and %3, %0  : i32
    %5 = llvm.xor %2, %4  : i32
    llvm.return %5 : i32
  }]

def select_ctpop_zero_before := [llvmfunc|
  llvm.func @select_ctpop_zero(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.select %2, %0, %1 : i1, i32
    llvm.return %3 : i32
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    "llvm.intr.assume"(%2) : (i1) -> ()
    llvm.return %1 : i1
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.intr.ctpop(%arg0)  : (i8) -> i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
def test5vec_combined := [llvmfunc|
  llvm.func @test5vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_test5vec   : test5vec_before  ⊑  test5vec_combined := by
  unfold test5vec_before test5vec_combined
  simp_alive_peephole
  sorry
def test6_combined := [llvmfunc|
  llvm.func @test6(%arg0: i1) -> i1 {
    llvm.return %arg0 : i1
  }]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
def mask_one_bit_combined := [llvmfunc|
  llvm.func @mask_one_bit(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.and %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_mask_one_bit   : mask_one_bit_before  ⊑  mask_one_bit_combined := by
  unfold mask_one_bit_before mask_one_bit_combined
  simp_alive_peephole
  sorry
def mask_one_bit_splat_combined := [llvmfunc|
  llvm.func @mask_one_bit_splat(%arg0: vector<2xi32>, %arg1: !llvm.ptr) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<2048> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<11> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.and %arg0, %0  : vector<2xi32>
    llvm.store %2, %arg1 {alignment = 8 : i64} : vector<2xi32>, !llvm.ptr
    %3 = llvm.lshr %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_mask_one_bit_splat   : mask_one_bit_splat_before  ⊑  mask_one_bit_splat_combined := by
  unfold mask_one_bit_splat_before mask_one_bit_splat_combined
  simp_alive_peephole
  sorry
def _parity_of_not_combined := [llvmfunc|
  llvm.func @_parity_of_not(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %2 = llvm.and %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine__parity_of_not   : _parity_of_not_before  ⊑  _parity_of_not_combined := by
  unfold _parity_of_not_before _parity_of_not_combined
  simp_alive_peephole
  sorry
def _parity_of_not_odd_type_combined := [llvmfunc|
  llvm.func @_parity_of_not_odd_type(%arg0: i7) -> i7 {
    %0 = llvm.mlir.constant(-1 : i7) : i7
    %1 = llvm.mlir.constant(1 : i7) : i7
    %2 = llvm.xor %arg0, %0  : i7
    %3 = llvm.intr.ctpop(%2)  : (i7) -> i7
    %4 = llvm.and %3, %1  : i7
    llvm.return %4 : i7
  }]

theorem inst_combine__parity_of_not_odd_type   : _parity_of_not_odd_type_before  ⊑  _parity_of_not_odd_type_combined := by
  unfold _parity_of_not_odd_type_before _parity_of_not_odd_type_combined
  simp_alive_peephole
  sorry
def _parity_of_not_vec_combined := [llvmfunc|
  llvm.func @_parity_of_not_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.ctpop(%arg0)  : (vector<2xi32>) -> vector<2xi32>
    %2 = llvm.and %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine__parity_of_not_vec   : _parity_of_not_vec_before  ⊑  _parity_of_not_vec_combined := by
  unfold _parity_of_not_vec_before _parity_of_not_vec_combined
  simp_alive_peephole
  sorry
def _parity_of_not_poison_combined := [llvmfunc|
  llvm.func @_parity_of_not_poison(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.ctpop(%arg0)  : (vector<2xi32>) -> vector<2xi32>
    %2 = llvm.and %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine__parity_of_not_poison   : _parity_of_not_poison_before  ⊑  _parity_of_not_poison_combined := by
  unfold _parity_of_not_poison_before _parity_of_not_poison_combined
  simp_alive_peephole
  sorry
def _parity_of_not_poison2_combined := [llvmfunc|
  llvm.func @_parity_of_not_poison2(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.intr.ctpop(%arg0)  : (vector<2xi32>) -> vector<2xi32>
    %8 = llvm.and %7, %6  : vector<2xi32>
    llvm.return %8 : vector<2xi32>
  }]

theorem inst_combine__parity_of_not_poison2   : _parity_of_not_poison2_before  ⊑  _parity_of_not_poison2_combined := by
  unfold _parity_of_not_poison2_before _parity_of_not_poison2_combined
  simp_alive_peephole
  sorry
def ctpop_add_combined := [llvmfunc|
  llvm.func @ctpop_add(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.lshr %arg1, %1  : i32
    %5 = llvm.and %4, %1  : i32
    %6 = llvm.add %3, %5 overflow<nsw, nuw>  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_ctpop_add   : ctpop_add_before  ⊑  ctpop_add_combined := by
  unfold ctpop_add_before ctpop_add_combined
  simp_alive_peephole
  sorry
def ctpop_add_no_common_bits_combined := [llvmfunc|
  llvm.func @ctpop_add_no_common_bits(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.intr.fshl(%arg0, %arg1, %0)  : (i32, i32, i32) -> i32
    %2 = llvm.intr.ctpop(%1)  : (i32) -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_ctpop_add_no_common_bits   : ctpop_add_no_common_bits_before  ⊑  ctpop_add_no_common_bits_combined := by
  unfold ctpop_add_no_common_bits_before ctpop_add_no_common_bits_combined
  simp_alive_peephole
  sorry
def ctpop_add_no_common_bits_vec_combined := [llvmfunc|
  llvm.func @ctpop_add_no_common_bits_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.fshl(%arg0, %arg1, %0)  : (vector<2xi32>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %2 = llvm.intr.ctpop(%1)  : (vector<2xi32>) -> vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_ctpop_add_no_common_bits_vec   : ctpop_add_no_common_bits_vec_before  ⊑  ctpop_add_no_common_bits_vec_combined := by
  unfold ctpop_add_no_common_bits_vec_before ctpop_add_no_common_bits_vec_combined
  simp_alive_peephole
  sorry
def ctpop_add_no_common_bits_vec_use_combined := [llvmfunc|
  llvm.func @ctpop_add_no_common_bits_vec_use(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: !llvm.ptr) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.shl %arg0, %0  : vector<2xi32>
    %2 = llvm.intr.ctpop(%1)  : (vector<2xi32>) -> vector<2xi32>
    %3 = llvm.lshr %arg1, %0  : vector<2xi32>
    %4 = llvm.intr.ctpop(%3)  : (vector<2xi32>) -> vector<2xi32>
    llvm.store %4, %arg2 {alignment = 8 : i64} : vector<2xi32>, !llvm.ptr
    %5 = llvm.add %2, %4 overflow<nsw, nuw>  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

theorem inst_combine_ctpop_add_no_common_bits_vec_use   : ctpop_add_no_common_bits_vec_use_before  ⊑  ctpop_add_no_common_bits_vec_use_combined := by
  unfold ctpop_add_no_common_bits_vec_use_before ctpop_add_no_common_bits_vec_use_combined
  simp_alive_peephole
  sorry
def ctpop_add_no_common_bits_vec_use2_combined := [llvmfunc|
  llvm.func @ctpop_add_no_common_bits_vec_use2(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: !llvm.ptr) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.shl %arg0, %0  : vector<2xi32>
    %2 = llvm.intr.ctpop(%1)  : (vector<2xi32>) -> vector<2xi32>
    llvm.store %2, %arg2 {alignment = 8 : i64} : vector<2xi32>, !llvm.ptr
    %3 = llvm.lshr %arg1, %0  : vector<2xi32>
    %4 = llvm.intr.ctpop(%3)  : (vector<2xi32>) -> vector<2xi32>
    %5 = llvm.add %2, %4 overflow<nsw, nuw>  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

theorem inst_combine_ctpop_add_no_common_bits_vec_use2   : ctpop_add_no_common_bits_vec_use2_before  ⊑  ctpop_add_no_common_bits_vec_use2_combined := by
  unfold ctpop_add_no_common_bits_vec_use2_before ctpop_add_no_common_bits_vec_use2_combined
  simp_alive_peephole
  sorry
def ctpop_rotate_left_combined := [llvmfunc|
  llvm.func @ctpop_rotate_left(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.ctpop(%arg0)  : (i8) -> i8
    llvm.return %0 : i8
  }]

theorem inst_combine_ctpop_rotate_left   : ctpop_rotate_left_before  ⊑  ctpop_rotate_left_combined := by
  unfold ctpop_rotate_left_before ctpop_rotate_left_combined
  simp_alive_peephole
  sorry
def ctpop_rotate_right_combined := [llvmfunc|
  llvm.func @ctpop_rotate_right(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.ctpop(%arg0)  : (i8) -> i8
    llvm.return %0 : i8
  }]

theorem inst_combine_ctpop_rotate_right   : ctpop_rotate_right_before  ⊑  ctpop_rotate_right_combined := by
  unfold ctpop_rotate_right_before ctpop_rotate_right_combined
  simp_alive_peephole
  sorry
def sub_ctpop_combined := [llvmfunc|
  llvm.func @sub_ctpop(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.intr.ctpop(%1)  : (i8) -> i8
    llvm.return %2 : i8
  }]

theorem inst_combine_sub_ctpop   : sub_ctpop_before  ⊑  sub_ctpop_combined := by
  unfold sub_ctpop_before sub_ctpop_combined
  simp_alive_peephole
  sorry
def sub_ctpop_wrong_cst_combined := [llvmfunc|
  llvm.func @sub_ctpop_wrong_cst(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.intr.ctpop(%arg0)  : (i8) -> i8
    %2 = llvm.sub %0, %1 overflow<nsw>  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_sub_ctpop_wrong_cst   : sub_ctpop_wrong_cst_before  ⊑  sub_ctpop_wrong_cst_combined := by
  unfold sub_ctpop_wrong_cst_before sub_ctpop_wrong_cst_combined
  simp_alive_peephole
  sorry
def sub_ctpop_unknown_combined := [llvmfunc|
  llvm.func @sub_ctpop_unknown(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.ctpop(%arg0)  : (i8) -> i8
    %1 = llvm.sub %arg1, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_sub_ctpop_unknown   : sub_ctpop_unknown_before  ⊑  sub_ctpop_unknown_combined := by
  unfold sub_ctpop_unknown_before sub_ctpop_unknown_combined
  simp_alive_peephole
  sorry
def sub_ctpop_vec_combined := [llvmfunc|
  llvm.func @sub_ctpop_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.xor %arg0, %0  : vector<2xi32>
    %2 = llvm.intr.ctpop(%1)  : (vector<2xi32>) -> vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_sub_ctpop_vec   : sub_ctpop_vec_before  ⊑  sub_ctpop_vec_combined := by
  unfold sub_ctpop_vec_before sub_ctpop_vec_combined
  simp_alive_peephole
  sorry
def sub_ctpop_vec_extra_use_combined := [llvmfunc|
  llvm.func @sub_ctpop_vec_extra_use(%arg0: vector<2xi32>, %arg1: !llvm.ptr) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.ctpop(%arg0)  : (vector<2xi32>) -> vector<2xi32>
    llvm.store %1, %arg1 {alignment = 8 : i64} : vector<2xi32>, !llvm.ptr
    %2 = llvm.sub %0, %1 overflow<nsw, nuw>  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_sub_ctpop_vec_extra_use   : sub_ctpop_vec_extra_use_before  ⊑  sub_ctpop_vec_extra_use_combined := by
  unfold sub_ctpop_vec_extra_use_before sub_ctpop_vec_extra_use_combined
  simp_alive_peephole
  sorry
def zext_ctpop_combined := [llvmfunc|
  llvm.func @zext_ctpop(%arg0: i16) -> i32 {
    %0 = llvm.intr.ctpop(%arg0)  : (i16) -> i16
    %1 = llvm.zext %0 : i16 to i32
    llvm.return %1 : i32
  }]

theorem inst_combine_zext_ctpop   : zext_ctpop_before  ⊑  zext_ctpop_combined := by
  unfold zext_ctpop_before zext_ctpop_combined
  simp_alive_peephole
  sorry
def zext_ctpop_vec_combined := [llvmfunc|
  llvm.func @zext_ctpop_vec(%arg0: vector<2xi7>) -> vector<2xi32> {
    %0 = llvm.intr.ctpop(%arg0)  : (vector<2xi7>) -> vector<2xi7>
    %1 = llvm.zext %0 : vector<2xi7> to vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_zext_ctpop_vec   : zext_ctpop_vec_before  ⊑  zext_ctpop_vec_combined := by
  unfold zext_ctpop_vec_before zext_ctpop_vec_combined
  simp_alive_peephole
  sorry
def zext_ctpop_extra_use_combined := [llvmfunc|
  llvm.func @zext_ctpop_extra_use(%arg0: i16, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.zext %arg0 : i16 to i32
    llvm.store %0, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    %1 = llvm.intr.ctpop(%0)  : (i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_zext_ctpop_extra_use   : zext_ctpop_extra_use_before  ⊑  zext_ctpop_extra_use_combined := by
  unfold zext_ctpop_extra_use_before zext_ctpop_extra_use_combined
  simp_alive_peephole
  sorry
def parity_xor_combined := [llvmfunc|
  llvm.func @parity_xor(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.xor %arg1, %arg0  : i32
    %2 = llvm.intr.ctpop(%1)  : (i32) -> i32
    %3 = llvm.and %2, %0  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_parity_xor   : parity_xor_before  ⊑  parity_xor_combined := by
  unfold parity_xor_before parity_xor_combined
  simp_alive_peephole
  sorry
def parity_xor_trunc_combined := [llvmfunc|
  llvm.func @parity_xor_trunc(%arg0: i64, %arg1: i64) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.xor %arg1, %arg0  : i64
    %2 = llvm.intr.ctpop(%1)  : (i64) -> i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.and %3, %0  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_parity_xor_trunc   : parity_xor_trunc_before  ⊑  parity_xor_trunc_combined := by
  unfold parity_xor_trunc_before parity_xor_trunc_combined
  simp_alive_peephole
  sorry
def parity_xor_vec_combined := [llvmfunc|
  llvm.func @parity_xor_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.xor %arg1, %arg0  : vector<2xi32>
    %2 = llvm.intr.ctpop(%1)  : (vector<2xi32>) -> vector<2xi32>
    %3 = llvm.and %2, %0  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_parity_xor_vec   : parity_xor_vec_before  ⊑  parity_xor_vec_combined := by
  unfold parity_xor_vec_before parity_xor_vec_combined
  simp_alive_peephole
  sorry
def parity_xor_wrong_cst_combined := [llvmfunc|
  llvm.func @parity_xor_wrong_cst(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %2 = llvm.intr.ctpop(%arg1)  : (i32) -> i32
    %3 = llvm.xor %2, %1  : i32
    %4 = llvm.and %3, %0  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_parity_xor_wrong_cst   : parity_xor_wrong_cst_before  ⊑  parity_xor_wrong_cst_combined := by
  unfold parity_xor_wrong_cst_before parity_xor_wrong_cst_combined
  simp_alive_peephole
  sorry
def parity_xor_extra_use_combined := [llvmfunc|
  llvm.func @parity_xor_extra_use(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %2 = llvm.and %1, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.xor %arg1, %arg0  : i32
    %4 = llvm.intr.ctpop(%3)  : (i32) -> i32
    %5 = llvm.and %4, %0  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_parity_xor_extra_use   : parity_xor_extra_use_before  ⊑  parity_xor_extra_use_combined := by
  unfold parity_xor_extra_use_before parity_xor_extra_use_combined
  simp_alive_peephole
  sorry
def parity_xor_extra_use2_combined := [llvmfunc|
  llvm.func @parity_xor_extra_use2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.intr.ctpop(%arg1)  : (i32) -> i32
    %2 = llvm.and %1, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.xor %arg1, %arg0  : i32
    %4 = llvm.intr.ctpop(%3)  : (i32) -> i32
    %5 = llvm.and %4, %0  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_parity_xor_extra_use2   : parity_xor_extra_use2_before  ⊑  parity_xor_extra_use2_combined := by
  unfold parity_xor_extra_use2_before parity_xor_extra_use2_combined
  simp_alive_peephole
  sorry
def select_ctpop_zero_combined := [llvmfunc|
  llvm.func @select_ctpop_zero(%arg0: i32) -> i32 {
    %0 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_select_ctpop_zero   : select_ctpop_zero_before  ⊑  select_ctpop_zero_combined := by
  unfold select_ctpop_zero_before select_ctpop_zero_combined
  simp_alive_peephole
  sorry
