import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  binop-select
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg1  : i32
    %2 = llvm.select %arg0, %1, %arg2 : i1, i32
    %3 = llvm.add %2, %arg1  : i32
    llvm.return %3 : i32
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg1  : i32
    %2 = llvm.select %arg0, %1, %arg1 : i1, i32
    %3 = llvm.add %2, %arg1  : i32
    llvm.return %3 : i32
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.select %arg0, %2, %1 : i1, i32
    %4 = llvm.mul %3, %arg1  : i32
    llvm.return %4 : i32
  }]

def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.select %arg0, %2, %1 : i1, i32
    %4 = llvm.mul %3, %arg1  : i32
    llvm.return %4 : i32
  }]

def test5_before := [llvmfunc|
  llvm.func @test5(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.select %arg0, %arg1, %0 : i1, i32
    %2 = llvm.add %1, %arg1  : i32
    llvm.return %2 : i32
  }]

def test_sub_deduce_true_before := [llvmfunc|
  llvm.func @test_sub_deduce_true(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.select %2, %1, %arg1 : i1, i32
    %4 = llvm.intr.sadd.sat(%arg0, %3)  : (i32, i32) -> i32
    llvm.return %4 : i32
  }]

def test_sub_deduce_true_no_const_fold_before := [llvmfunc|
  llvm.func @test_sub_deduce_true_no_const_fold(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.select %2, %arg1, %1 : i1, i32
    %4 = llvm.intr.sadd.sat(%arg0, %3)  : (i32, i32) -> i32
    llvm.return %4 : i32
  }]

def test_sub_deduce_false_before := [llvmfunc|
  llvm.func @test_sub_deduce_false(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.icmp "ne" %arg0, %0 : i32
    %3 = llvm.select %2, %arg1, %1 : i1, i32
    %4 = llvm.intr.sadd.sat(%arg0, %3)  : (i32, i32) -> i32
    llvm.return %4 : i32
  }]

def test_sub_dont_deduce_with_undef_cond_vec_before := [llvmfunc|
  llvm.func @test_sub_dont_deduce_with_undef_cond_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.undef : i8
    %1 = llvm.mlir.constant(9 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(dense<7> : vector<2xi8>) : vector<2xi8>
    %8 = llvm.icmp "ne" %arg0, %6 : vector<2xi8>
    %9 = llvm.select %8, %arg1, %7 : vector<2xi1>, vector<2xi8>
    %10 = llvm.intr.sadd.sat(%arg0, %9)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }]

def test_sub_dont_deduce_with_poison_cond_vec_before := [llvmfunc|
  llvm.func @test_sub_dont_deduce_with_poison_cond_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(9 : i8) : i8
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(dense<7> : vector<2xi8>) : vector<2xi8>
    %8 = llvm.icmp "ne" %arg0, %6 : vector<2xi8>
    %9 = llvm.select %8, %arg1, %7 : vector<2xi1>, vector<2xi8>
    %10 = llvm.intr.sadd.sat(%arg0, %9)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }]

def test_sub_deduce_with_undef_val_vec_before := [llvmfunc|
  llvm.func @test_sub_deduce_with_undef_val_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.undef : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.mlir.undef : vector<2xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi8>
    %8 = llvm.icmp "ne" %arg0, %0 : vector<2xi8>
    %9 = llvm.select %8, %arg1, %7 : vector<2xi1>, vector<2xi8>
    %10 = llvm.intr.sadd.sat(%arg0, %9)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }]

def test6_before := [llvmfunc|
  llvm.func @test6(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.select %arg0, %0, %arg1 : i1, i32
    %2 = llvm.and %1, %arg1  : i32
    llvm.return %2 : i32
  }]

def test7_before := [llvmfunc|
  llvm.func @test7(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg1  : i32
    %2 = llvm.select %arg0, %arg1, %1 : i1, i32
    %3 = llvm.sdiv %arg1, %2  : i32
    llvm.return %3 : i32
  }]

def test8_before := [llvmfunc|
  llvm.func @test8(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.select %arg0, %0, %arg2 : i1, i32
    %3 = llvm.sdiv %1, %2  : i32
    llvm.return %3 : i32
  }]

def test9_before := [llvmfunc|
  llvm.func @test9(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.select %arg0, %0, %arg1 : i1, i32
    %3 = llvm.sub %1, %2 overflow<nsw>  : i32
    llvm.return %3 : i32
  }]

def test10_before := [llvmfunc|
  llvm.func @test10(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.select %arg0, %0, %arg2 : i1, i32
    %3 = llvm.udiv %1, %2  : i32
    llvm.return %3 : i32
  }]

def test11_before := [llvmfunc|
  llvm.func @test11(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.select %arg0, %0, %arg2 : i1, i32
    %3 = llvm.srem %1, %2  : i32
    llvm.return %3 : i32
  }]

def test12_before := [llvmfunc|
  llvm.func @test12(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.select %arg0, %0, %arg2 : i1, i32
    %3 = llvm.urem %1, %2  : i32
    llvm.return %3 : i32
  }]

def extra_use_before := [llvmfunc|
  llvm.func @extra_use(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.select %arg0, %0, %arg1 : i1, i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.sub %1, %2 overflow<nsw>  : i32
    llvm.return %3 : i32
  }]

def extra_use2_before := [llvmfunc|
  llvm.func @extra_use2(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg1  : i32
    %2 = llvm.select %arg0, %arg1, %1 : i1, i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.sdiv %2, %arg1  : i32
    llvm.return %3 : i32
  }]

def and_sel_op0_before := [llvmfunc|
  llvm.func @and_sel_op0(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(25 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    %4 = llvm.and %3, %2  : i32
    llvm.return %4 : i32
  }]

def and_sel_op0_use_before := [llvmfunc|
  llvm.func @and_sel_op0_use(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(25 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.and %3, %2  : i32
    llvm.return %4 : i32
  }]

def mul_sel_op0_before := [llvmfunc|
  llvm.func @mul_sel_op0(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.udiv %0, %arg1  : i32
    %3 = llvm.select %arg0, %1, %2 : i1, i32
    %4 = llvm.mul %3, %arg1  : i32
    llvm.return %4 : i32
  }]

def mul_sel_op0_use_before := [llvmfunc|
  llvm.func @mul_sel_op0_use(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.udiv %0, %arg1  : i32
    %3 = llvm.select %arg0, %1, %2 : i1, i32
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.mul %3, %arg1  : i32
    llvm.return %4 : i32
  }]

def sub_sel_op1_before := [llvmfunc|
  llvm.func @sub_sel_op1(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(41 : i32) : i32
    %2 = llvm.select %arg0, %0, %1 : i1, i32
    %3 = llvm.sub %0, %2 overflow<nsw>  : i32
    llvm.return %3 : i32
  }]

def sub_sel_op1_use_before := [llvmfunc|
  llvm.func @sub_sel_op1_use(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(41 : i32) : i32
    %2 = llvm.select %arg0, %0, %1 : i1, i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.sub %0, %2 overflow<nsw, nuw>  : i32
    llvm.return %3 : i32
  }]

def fadd_sel_op0_before := [llvmfunc|
  llvm.func @fadd_sel_op0(%arg0: i1, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(0xFF800000 : f32) : f32
    %1 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %2 = llvm.select %arg0, %0, %1 : i1, f32
    %3 = llvm.fadd %2, %arg1  {fastmathFlags = #llvm.fastmath<nnan>} : f32]

    llvm.return %3 : f32
  }]

def fadd_sel_op0_use_before := [llvmfunc|
  llvm.func @fadd_sel_op0_use(%arg0: i1, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(0xFF800000 : f32) : f32
    %1 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %2 = llvm.select %arg0, %0, %1 : i1, f32
    llvm.call @use_f32(%2) : (f32) -> ()
    %3 = llvm.fadd %2, %arg1  {fastmathFlags = #llvm.fastmath<nnan>} : f32]

    llvm.return %3 : f32
  }]

def fmul_sel_op1_before := [llvmfunc|
  llvm.func @fmul_sel_op1(%arg0: i1, %arg1: vector<2xf16>) -> vector<2xf16> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00]> : vector<2xf16>) : vector<2xf16>
    %1 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %2 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf16>) : vector<2xf16>
    %3 = llvm.mlir.constant(dense<0xFFFF> : vector<2xf16>) : vector<2xf16>
    %4 = llvm.fadd %arg1, %0  : vector<2xf16>
    %5 = llvm.select %arg0, %2, %3 : i1, vector<2xf16>
    %6 = llvm.fmul %4, %5  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : vector<2xf16>]

    llvm.return %6 : vector<2xf16>
  }]

def fmul_sel_op1_use_before := [llvmfunc|
  llvm.func @fmul_sel_op1_use(%arg0: i1, %arg1: vector<2xf16>) -> vector<2xf16> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00]> : vector<2xf16>) : vector<2xf16>
    %1 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %2 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf16>) : vector<2xf16>
    %3 = llvm.mlir.constant(dense<0xFFFF> : vector<2xf16>) : vector<2xf16>
    %4 = llvm.fadd %arg1, %0  : vector<2xf16>
    %5 = llvm.select %arg0, %2, %3 : i1, vector<2xf16>
    llvm.call @use_v2f16(%5) : (vector<2xf16>) -> ()
    %6 = llvm.fmul %4, %5  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : vector<2xf16>]

    llvm.return %6 : vector<2xf16>
  }]

def ashr_sel_op1_before := [llvmfunc|
  llvm.func @ashr_sel_op1(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-2 : i32) : i32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    %4 = llvm.ashr %2, %3  : i32
    llvm.return %4 : i32
  }]

def ashr_sel_op1_use_before := [llvmfunc|
  llvm.func @ashr_sel_op1_use(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-2 : i32) : i32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.ashr %2, %3  : i32
    llvm.return %4 : i32
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg1  : i32
    %2 = llvm.select %arg0, %1, %arg2 : i1, i32
    %3 = llvm.add %2, %arg1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg1  : i32
    %2 = llvm.select %arg0, %1, %arg1 : i1, i32
    %3 = llvm.add %2, %arg1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.select %arg0, %2, %1 : i1, i32
    %4 = llvm.mul %3, %arg1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.select %arg0, %2, %1 : i1, i32
    %4 = llvm.mul %3, %arg1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.select %arg0, %arg1, %0 : i1, i32
    %2 = llvm.add %1, %arg1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
def test_sub_deduce_true_combined := [llvmfunc|
  llvm.func @test_sub_deduce_true(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.intr.sadd.sat(%arg0, %arg1)  : (i32, i32) -> i32
    %4 = llvm.select %2, %1, %3 : i1, i32
    llvm.return %4 : i32
  }]

theorem inst_combine_test_sub_deduce_true   : test_sub_deduce_true_before  ⊑  test_sub_deduce_true_combined := by
  unfold test_sub_deduce_true_before test_sub_deduce_true_combined
  simp_alive_peephole
  sorry
def test_sub_deduce_true_no_const_fold_combined := [llvmfunc|
  llvm.func @test_sub_deduce_true_no_const_fold(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.select %2, %arg1, %1 : i1, i32
    %4 = llvm.intr.sadd.sat(%arg0, %3)  : (i32, i32) -> i32
    llvm.return %4 : i32
  }]

theorem inst_combine_test_sub_deduce_true_no_const_fold   : test_sub_deduce_true_no_const_fold_before  ⊑  test_sub_deduce_true_no_const_fold_combined := by
  unfold test_sub_deduce_true_no_const_fold_before test_sub_deduce_true_no_const_fold_combined
  simp_alive_peephole
  sorry
def test_sub_deduce_false_combined := [llvmfunc|
  llvm.func @test_sub_deduce_false(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.intr.sadd.sat(%arg0, %arg1)  : (i32, i32) -> i32
    %4 = llvm.select %2, %1, %3 : i1, i32
    llvm.return %4 : i32
  }]

theorem inst_combine_test_sub_deduce_false   : test_sub_deduce_false_before  ⊑  test_sub_deduce_false_combined := by
  unfold test_sub_deduce_false_before test_sub_deduce_false_combined
  simp_alive_peephole
  sorry
def test_sub_dont_deduce_with_undef_cond_vec_combined := [llvmfunc|
  llvm.func @test_sub_dont_deduce_with_undef_cond_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.undef : i8
    %1 = llvm.mlir.constant(9 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(dense<7> : vector<2xi8>) : vector<2xi8>
    %8 = llvm.icmp "eq" %arg0, %6 : vector<2xi8>
    %9 = llvm.select %8, %7, %arg1 : vector<2xi1>, vector<2xi8>
    %10 = llvm.intr.sadd.sat(%arg0, %9)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }]

theorem inst_combine_test_sub_dont_deduce_with_undef_cond_vec   : test_sub_dont_deduce_with_undef_cond_vec_before  ⊑  test_sub_dont_deduce_with_undef_cond_vec_combined := by
  unfold test_sub_dont_deduce_with_undef_cond_vec_before test_sub_dont_deduce_with_undef_cond_vec_combined
  simp_alive_peephole
  sorry
def test_sub_dont_deduce_with_poison_cond_vec_combined := [llvmfunc|
  llvm.func @test_sub_dont_deduce_with_poison_cond_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(9 : i8) : i8
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(dense<7> : vector<2xi8>) : vector<2xi8>
    %8 = llvm.icmp "eq" %arg0, %6 : vector<2xi8>
    %9 = llvm.select %8, %7, %arg1 : vector<2xi1>, vector<2xi8>
    %10 = llvm.intr.sadd.sat(%arg0, %9)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }]

theorem inst_combine_test_sub_dont_deduce_with_poison_cond_vec   : test_sub_dont_deduce_with_poison_cond_vec_before  ⊑  test_sub_dont_deduce_with_poison_cond_vec_combined := by
  unfold test_sub_dont_deduce_with_poison_cond_vec_before test_sub_dont_deduce_with_poison_cond_vec_combined
  simp_alive_peephole
  sorry
def test_sub_deduce_with_undef_val_vec_combined := [llvmfunc|
  llvm.func @test_sub_deduce_with_undef_val_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[4, -1]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.icmp "eq" %arg0, %0 : vector<2xi8>
    %3 = llvm.intr.sadd.sat(%arg0, %arg1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %4 = llvm.select %2, %1, %3 : vector<2xi1>, vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

theorem inst_combine_test_sub_deduce_with_undef_val_vec   : test_sub_deduce_with_undef_val_vec_before  ⊑  test_sub_deduce_with_undef_val_vec_combined := by
  unfold test_sub_deduce_with_undef_val_vec_before test_sub_deduce_with_undef_val_vec_combined
  simp_alive_peephole
  sorry
def test6_combined := [llvmfunc|
  llvm.func @test6(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.select %arg0, %0, %arg1 : i1, i32
    %2 = llvm.and %1, %arg1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
def test7_combined := [llvmfunc|
  llvm.func @test7(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg1  : i32
    %2 = llvm.select %arg0, %arg1, %1 : i1, i32
    %3 = llvm.sdiv %arg1, %2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test7   : test7_before  ⊑  test7_combined := by
  unfold test7_before test7_combined
  simp_alive_peephole
  sorry
def test8_combined := [llvmfunc|
  llvm.func @test8(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.select %arg0, %0, %arg2 : i1, i32
    %3 = llvm.sdiv %1, %2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test8   : test8_before  ⊑  test8_combined := by
  unfold test8_before test8_combined
  simp_alive_peephole
  sorry
def test9_combined := [llvmfunc|
  llvm.func @test9(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.select %arg0, %0, %arg1 : i1, i32
    %3 = llvm.sub %1, %2 overflow<nsw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test9   : test9_before  ⊑  test9_combined := by
  unfold test9_before test9_combined
  simp_alive_peephole
  sorry
def test10_combined := [llvmfunc|
  llvm.func @test10(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.select %arg0, %0, %arg2 : i1, i32
    %3 = llvm.udiv %1, %2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test10   : test10_before  ⊑  test10_combined := by
  unfold test10_before test10_combined
  simp_alive_peephole
  sorry
def test11_combined := [llvmfunc|
  llvm.func @test11(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.select %arg0, %0, %arg2 : i1, i32
    %3 = llvm.srem %1, %2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test11   : test11_before  ⊑  test11_combined := by
  unfold test11_before test11_combined
  simp_alive_peephole
  sorry
def test12_combined := [llvmfunc|
  llvm.func @test12(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.select %arg0, %0, %arg2 : i1, i32
    %3 = llvm.urem %1, %2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test12   : test12_before  ⊑  test12_combined := by
  unfold test12_before test12_combined
  simp_alive_peephole
  sorry
def extra_use_combined := [llvmfunc|
  llvm.func @extra_use(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.select %arg0, %0, %arg1 : i1, i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.sub %1, %2 overflow<nsw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_extra_use   : extra_use_before  ⊑  extra_use_combined := by
  unfold extra_use_before extra_use_combined
  simp_alive_peephole
  sorry
def extra_use2_combined := [llvmfunc|
  llvm.func @extra_use2(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg1  : i32
    %2 = llvm.select %arg0, %arg1, %1 : i1, i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.sdiv %2, %arg1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_extra_use2   : extra_use2_before  ⊑  extra_use2_combined := by
  unfold extra_use2_before extra_use2_combined
  simp_alive_peephole
  sorry
def and_sel_op0_combined := [llvmfunc|
  llvm.func @and_sel_op0(%arg0: i1) -> i32 {
    %0 = llvm.zext %arg0 : i1 to i32
    llvm.return %0 : i32
  }]

theorem inst_combine_and_sel_op0   : and_sel_op0_before  ⊑  and_sel_op0_combined := by
  unfold and_sel_op0_before and_sel_op0_combined
  simp_alive_peephole
  sorry
def and_sel_op0_use_combined := [llvmfunc|
  llvm.func @and_sel_op0_use(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(25 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.and %3, %2  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_and_sel_op0_use   : and_sel_op0_use_before  ⊑  and_sel_op0_use_combined := by
  unfold and_sel_op0_use_before and_sel_op0_use_combined
  simp_alive_peephole
  sorry
def mul_sel_op0_combined := [llvmfunc|
  llvm.func @mul_sel_op0(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.select %arg0, %0, %1 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_mul_sel_op0   : mul_sel_op0_before  ⊑  mul_sel_op0_combined := by
  unfold mul_sel_op0_before mul_sel_op0_combined
  simp_alive_peephole
  sorry
def mul_sel_op0_use_combined := [llvmfunc|
  llvm.func @mul_sel_op0_use(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.udiv %0, %arg1  : i32
    %3 = llvm.select %arg0, %1, %2 : i1, i32
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.mul %3, %arg1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_mul_sel_op0_use   : mul_sel_op0_use_before  ⊑  mul_sel_op0_use_combined := by
  unfold mul_sel_op0_use_before mul_sel_op0_use_combined
  simp_alive_peephole
  sorry
def sub_sel_op1_combined := [llvmfunc|
  llvm.func @sub_sel_op1(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.zext %1 : i1 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_sub_sel_op1   : sub_sel_op1_before  ⊑  sub_sel_op1_combined := by
  unfold sub_sel_op1_before sub_sel_op1_combined
  simp_alive_peephole
  sorry
def sub_sel_op1_use_combined := [llvmfunc|
  llvm.func @sub_sel_op1_use(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(41 : i32) : i32
    %2 = llvm.select %arg0, %0, %1 : i1, i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.sub %0, %2 overflow<nsw, nuw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_sub_sel_op1_use   : sub_sel_op1_use_before  ⊑  sub_sel_op1_use_combined := by
  unfold sub_sel_op1_use_before sub_sel_op1_use_combined
  simp_alive_peephole
  sorry
def fadd_sel_op0_combined := [llvmfunc|
  llvm.func @fadd_sel_op0(%arg0: i1, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(0xFF800000 : f32) : f32
    %1 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %2 = llvm.select %arg0, %0, %1 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32
    llvm.return %2 : f32
  }]

theorem inst_combine_fadd_sel_op0   : fadd_sel_op0_before  ⊑  fadd_sel_op0_combined := by
  unfold fadd_sel_op0_before fadd_sel_op0_combined
  simp_alive_peephole
  sorry
def fadd_sel_op0_use_combined := [llvmfunc|
  llvm.func @fadd_sel_op0_use(%arg0: i1, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(0xFF800000 : f32) : f32
    %1 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %2 = llvm.select %arg0, %0, %1 : i1, f32
    llvm.call @use_f32(%2) : (f32) -> ()
    %3 = llvm.fadd %2, %arg1  {fastmathFlags = #llvm.fastmath<nnan>} : f32
    llvm.return %3 : f32
  }]

theorem inst_combine_fadd_sel_op0_use   : fadd_sel_op0_use_before  ⊑  fadd_sel_op0_use_combined := by
  unfold fadd_sel_op0_use_before fadd_sel_op0_use_combined
  simp_alive_peephole
  sorry
def fmul_sel_op1_combined := [llvmfunc|
  llvm.func @fmul_sel_op1(%arg0: i1, %arg1: vector<2xf16>) -> vector<2xf16> {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf16>) : vector<2xf16>
    llvm.return %1 : vector<2xf16>
  }]

theorem inst_combine_fmul_sel_op1   : fmul_sel_op1_before  ⊑  fmul_sel_op1_combined := by
  unfold fmul_sel_op1_before fmul_sel_op1_combined
  simp_alive_peephole
  sorry
def fmul_sel_op1_use_combined := [llvmfunc|
  llvm.func @fmul_sel_op1_use(%arg0: i1, %arg1: vector<2xf16>) -> vector<2xf16> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00]> : vector<2xf16>) : vector<2xf16>
    %1 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %2 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf16>) : vector<2xf16>
    %3 = llvm.mlir.constant(dense<0xFFFF> : vector<2xf16>) : vector<2xf16>
    %4 = llvm.fadd %arg1, %0  : vector<2xf16>
    %5 = llvm.select %arg0, %2, %3 : i1, vector<2xf16>
    llvm.call @use_v2f16(%5) : (vector<2xf16>) -> ()
    %6 = llvm.fmul %4, %5  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : vector<2xf16>
    llvm.return %6 : vector<2xf16>
  }]

theorem inst_combine_fmul_sel_op1_use   : fmul_sel_op1_use_before  ⊑  fmul_sel_op1_use_combined := by
  unfold fmul_sel_op1_use_before fmul_sel_op1_use_combined
  simp_alive_peephole
  sorry
def ashr_sel_op1_combined := [llvmfunc|
  llvm.func @ashr_sel_op1(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.select %arg0, %0, %1 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_ashr_sel_op1   : ashr_sel_op1_before  ⊑  ashr_sel_op1_combined := by
  unfold ashr_sel_op1_before ashr_sel_op1_combined
  simp_alive_peephole
  sorry
def ashr_sel_op1_use_combined := [llvmfunc|
  llvm.func @ashr_sel_op1_use(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-2 : i32) : i32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.ashr %2, %3  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_ashr_sel_op1_use   : ashr_sel_op1_use_before  ⊑  ashr_sel_op1_use_combined := by
  unfold ashr_sel_op1_use_before ashr_sel_op1_use_combined
  simp_alive_peephole
  sorry
