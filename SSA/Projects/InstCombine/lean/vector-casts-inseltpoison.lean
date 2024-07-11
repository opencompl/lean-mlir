import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  vector-casts-inseltpoison
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def trunc_before := [llvmfunc|
  llvm.func @trunc(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi1>
    llvm.return %0 : vector<2xi1>
  }]

def and_cmp_is_trunc_before := [llvmfunc|
  llvm.func @and_cmp_is_trunc(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.and %arg0, %0  : vector<2xi64>
    %4 = llvm.icmp "ne" %3, %2 : vector<2xi64>
    llvm.return %4 : vector<2xi1>
  }]

def and_cmp_is_trunc_even_with_poison_elt_before := [llvmfunc|
  llvm.func @and_cmp_is_trunc_even_with_poison_elt(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.poison : i64
    %2 = llvm.mlir.undef : vector<2xi64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi64>
    %7 = llvm.mlir.constant(0 : i64) : i64
    %8 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %9 = llvm.and %arg0, %6  : vector<2xi64>
    %10 = llvm.icmp "ne" %9, %8 : vector<2xi64>
    llvm.return %10 : vector<2xi1>
  }]

def and_cmp_is_trunc_even_with_poison_elts_before := [llvmfunc|
  llvm.func @and_cmp_is_trunc_even_with_poison_elts(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.poison : i64
    %2 = llvm.mlir.undef : vector<2xi64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi64>
    %7 = llvm.mlir.constant(0 : i64) : i64
    %8 = llvm.mlir.undef : vector<2xi64>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %1, %8[%9 : i32] : vector<2xi64>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %7, %10[%11 : i32] : vector<2xi64>
    %13 = llvm.and %arg0, %6  : vector<2xi64>
    %14 = llvm.icmp "ne" %13, %12 : vector<2xi64>
    llvm.return %14 : vector<2xi1>
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<65535> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.and %arg0, %0  : vector<2xi64>
    %3 = llvm.ashr %2, %1  : vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.fcmp "ord" %arg0, %1 : vector<4xf32>
    %3 = llvm.sext %2 : vector<4xi1> to vector<4xi32>
    %4 = llvm.fcmp "ord" %arg1, %1 : vector<4xf32>
    %5 = llvm.sext %4 : vector<4xi1> to vector<4xi32>
    %6 = llvm.and %3, %5  : vector<4xi32>
    %7 = llvm.bitcast %6 : vector<4xi32> to vector<2xi64>
    llvm.return %7 : vector<2xi64>
  }]

def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.fcmp "uno" %arg0, %1 : vector<4xf32>
    %3 = llvm.sext %2 : vector<4xi1> to vector<4xi32>
    %4 = llvm.fcmp "uno" %arg1, %1 : vector<4xf32>
    %5 = llvm.sext %4 : vector<4xi1> to vector<4xi32>
    %6 = llvm.or %3, %5  : vector<4xi32>
    %7 = llvm.bitcast %6 : vector<4xi32> to vector<2xi64>
    llvm.return %7 : vector<2xi64>
  }]

def test5_before := [llvmfunc|
  llvm.func @test5(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.fcmp "ult" %arg0, %1 : vector<4xf32>
    %3 = llvm.sext %2 : vector<4xi1> to vector<4xi32>
    %4 = llvm.fcmp "ult" %arg1, %1 : vector<4xf32>
    %5 = llvm.sext %4 : vector<4xi1> to vector<4xi32>
    %6 = llvm.and %3, %5  : vector<4xi32>
    %7 = llvm.bitcast %6 : vector<4xi32> to vector<2xi64>
    llvm.return %7 : vector<2xi64>
  }]

def test6_before := [llvmfunc|
  llvm.func @test6(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.fcmp "ult" %arg0, %1 : vector<4xf32>
    %3 = llvm.sext %2 : vector<4xi1> to vector<4xi32>
    %4 = llvm.fcmp "ult" %arg1, %1 : vector<4xf32>
    %5 = llvm.sext %4 : vector<4xi1> to vector<4xi32>
    %6 = llvm.or %3, %5  : vector<4xi32>
    %7 = llvm.bitcast %6 : vector<4xi32> to vector<2xi64>
    llvm.return %7 : vector<2xi64>
  }]

def test7_before := [llvmfunc|
  llvm.func @test7(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.fcmp "ult" %arg0, %1 : vector<4xf32>
    %3 = llvm.sext %2 : vector<4xi1> to vector<4xi32>
    %4 = llvm.fcmp "ult" %arg1, %1 : vector<4xf32>
    %5 = llvm.sext %4 : vector<4xi1> to vector<4xi32>
    %6 = llvm.xor %3, %5  : vector<4xi32>
    %7 = llvm.bitcast %6 : vector<4xi32> to vector<2xi64>
    llvm.return %7 : vector<2xi64>
  }]

def convert_before := [llvmfunc|
  llvm.func @convert(%arg0: !llvm.ptr, %arg1: vector<2xi64>) {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.trunc %arg1 : vector<2xi64> to vector<2xi32>
    %2 = llvm.add %1, %0  : vector<2xi32>
    llvm.store %2, %arg0 {alignment = 8 : i64} : vector<2xi32>, !llvm.ptr]

    llvm.return
  }]

def foo_before := [llvmfunc|
  llvm.func @foo(%arg0: vector<2xi64>) -> vector<2xi65> {
    %0 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %1 = llvm.zext %0 : vector<2xi32> to vector<2xi65>
    llvm.return %1 : vector<2xi65>
  }]

def bar_before := [llvmfunc|
  llvm.func @bar(%arg0: vector<2xi65>) -> vector<2xi64> {
    %0 = llvm.trunc %arg0 : vector<2xi65> to vector<2xi32>
    %1 = llvm.zext %0 : vector<2xi32> to vector<2xi64>
    llvm.return %1 : vector<2xi64>
  }]

def bars_before := [llvmfunc|
  llvm.func @bars(%arg0: vector<2xi65>) -> vector<2xi64> {
    %0 = llvm.trunc %arg0 : vector<2xi65> to vector<2xi32>
    %1 = llvm.sext %0 : vector<2xi32> to vector<2xi64>
    llvm.return %1 : vector<2xi64>
  }]

def quxs_before := [llvmfunc|
  llvm.func @quxs(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %1 = llvm.sext %0 : vector<2xi32> to vector<2xi64>
    llvm.return %1 : vector<2xi64>
  }]

def quxt_before := [llvmfunc|
  llvm.func @quxt(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.shl %arg0, %0  : vector<2xi64>
    %2 = llvm.ashr %1, %0  : vector<2xi64>
    llvm.return %2 : vector<2xi64>
  }]

def fa_before := [llvmfunc|
  llvm.func @fa(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.fptrunc %arg0 : vector<2xf64> to vector<2xf32>
    %1 = llvm.fpext %0 : vector<2xf32> to vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }]

def fb_before := [llvmfunc|
  llvm.func @fb(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.fptoui %arg0 : vector<2xf64> to vector<2xi64>
    %1 = llvm.uitofp %0 : vector<2xi64> to vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }]

def fc_before := [llvmfunc|
  llvm.func @fc(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.fptosi %arg0 : vector<2xf64> to vector<2xi64>
    %1 = llvm.sitofp %0 : vector<2xi64> to vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }]

def f_before := [llvmfunc|
  llvm.func @f(%arg0: i32) -> vector<4xf32> {
    %0 = llvm.mlir.poison : vector<4xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(3 : i32) : i32
    %5 = llvm.mlir.zero : !llvm.ptr
    %6 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %7 = llvm.mlir.undef : vector<4xi32>
    %8 = llvm.mlir.undef : vector<4xf32>
    %9 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xi32>
    %10 = llvm.insertelement %arg0, %9[%2 : i32] : vector<4xi32>
    %11 = llvm.insertelement %arg0, %10[%3 : i32] : vector<4xi32>
    %12 = llvm.insertelement %arg0, %11[%4 : i32] : vector<4xi32>
    %13 = llvm.getelementptr %5[%2] : (!llvm.ptr, i32) -> !llvm.ptr, vector<4xf32>
    %14 = llvm.ptrtoint %13 : !llvm.ptr to i64
    %15 = llvm.trunc %14 : i64 to i32
    %16 = llvm.insertelement %15, %0[%1 : i32] : vector<4xi32>
    %17 = llvm.insertelement %15, %16[%2 : i32] : vector<4xi32>
    %18 = llvm.insertelement %15, %17[%3 : i32] : vector<4xi32>
    %19 = llvm.insertelement %15, %18[%4 : i32] : vector<4xi32>
    %20 = llvm.mul %12, %19  : vector<4xi32>
    %21 = llvm.add %6, %20  : vector<4xi32>
    %22 = llvm.add %21, %7  : vector<4xi32>
    llvm.return %8 : vector<4xf32>
  }]

def pr24458_before := [llvmfunc|
  llvm.func @pr24458(%arg0: vector<8xf32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fcmp "une" %arg0, %1 : vector<8xf32>
    %3 = llvm.fcmp "ueq" %arg0, %1 : vector<8xf32>
    %4 = llvm.sext %2 : vector<8xi1> to vector<8xi32>
    %5 = llvm.sext %3 : vector<8xi1> to vector<8xi32>
    %6 = llvm.or %4, %5  : vector<8xi32>
    llvm.return %6 : vector<8xi32>
  }]

def trunc_inselt_undef_before := [llvmfunc|
  llvm.func @trunc_inselt_undef(%arg0: i32) -> vector<3xi16> {
    %0 = llvm.mlir.poison : vector<3xi32>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.insertelement %arg0, %0[%1 : i32] : vector<3xi32>
    %3 = llvm.trunc %2 : vector<3xi32> to vector<3xi16>
    llvm.return %3 : vector<3xi16>
  }]

def fptrunc_inselt_undef_before := [llvmfunc|
  llvm.func @fptrunc_inselt_undef(%arg0: f64, %arg1: i32) -> vector<2xf32> {
    %0 = llvm.mlir.undef : vector<2xf64>
    %1 = llvm.insertelement %arg0, %0[%arg1 : i32] : vector<2xf64>
    %2 = llvm.fptrunc %1 : vector<2xf64> to vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }]

def trunc_inselt1_before := [llvmfunc|
  llvm.func @trunc_inselt1(%arg0: i32) -> vector<3xi16> {
    %0 = llvm.mlir.constant(dense<[3, -2, 65536]> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.insertelement %arg0, %0[%1 : i32] : vector<3xi32>
    %3 = llvm.trunc %2 : vector<3xi32> to vector<3xi16>
    llvm.return %3 : vector<3xi16>
  }]

def fptrunc_inselt1_before := [llvmfunc|
  llvm.func @fptrunc_inselt1(%arg0: f64, %arg1: i32) -> vector<2xf32> {
    %0 = llvm.mlir.constant(3.000000e+00 : f64) : f64
    %1 = llvm.mlir.undef : f64
    %2 = llvm.mlir.undef : vector<2xf64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf64>
    %7 = llvm.insertelement %arg0, %6[%arg1 : i32] : vector<2xf64>
    %8 = llvm.fptrunc %7 : vector<2xf64> to vector<2xf32>
    llvm.return %8 : vector<2xf32>
  }]

def trunc_inselt2_before := [llvmfunc|
  llvm.func @trunc_inselt2(%arg0: vector<8xi32>, %arg1: i32) -> vector<8xi16> {
    %0 = llvm.mlir.constant(1048576 : i32) : i32
    %1 = llvm.insertelement %0, %arg0[%arg1 : i32] : vector<8xi32>
    %2 = llvm.trunc %1 : vector<8xi32> to vector<8xi16>
    llvm.return %2 : vector<8xi16>
  }]

def fptrunc_inselt2_before := [llvmfunc|
  llvm.func @fptrunc_inselt2(%arg0: vector<3xf64>) -> vector<3xf32> {
    %0 = llvm.mlir.constant(4.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.insertelement %0, %arg0[%1 : i32] : vector<3xf64>
    %3 = llvm.fptrunc %2 : vector<3xf64> to vector<3xf32>
    llvm.return %3 : vector<3xf32>
  }]

def sext_less_casting_with_wideop_before := [llvmfunc|
  llvm.func @sext_less_casting_with_wideop(%arg0: vector<2xi64>, %arg1: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %1 = llvm.trunc %arg1 : vector<2xi64> to vector<2xi32>
    %2 = llvm.mul %0, %1  : vector<2xi32>
    %3 = llvm.sext %2 : vector<2xi32> to vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }]

def zext_less_casting_with_wideop_before := [llvmfunc|
  llvm.func @zext_less_casting_with_wideop(%arg0: vector<2xi64>, %arg1: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %1 = llvm.trunc %arg1 : vector<2xi64> to vector<2xi32>
    %2 = llvm.mul %0, %1  : vector<2xi32>
    %3 = llvm.zext %2 : vector<2xi32> to vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }]

def trunc_combined := [llvmfunc|
  llvm.func @trunc(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi1>
    llvm.return %0 : vector<2xi1>
  }]

theorem inst_combine_trunc   : trunc_before  ⊑  trunc_combined := by
  unfold trunc_before trunc_combined
  simp_alive_peephole
  sorry
def and_cmp_is_trunc_combined := [llvmfunc|
  llvm.func @and_cmp_is_trunc(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi1>
    llvm.return %0 : vector<2xi1>
  }]

theorem inst_combine_and_cmp_is_trunc   : and_cmp_is_trunc_before  ⊑  and_cmp_is_trunc_combined := by
  unfold and_cmp_is_trunc_before and_cmp_is_trunc_combined
  simp_alive_peephole
  sorry
def and_cmp_is_trunc_even_with_poison_elt_combined := [llvmfunc|
  llvm.func @and_cmp_is_trunc_even_with_poison_elt(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi1>
    llvm.return %0 : vector<2xi1>
  }]

theorem inst_combine_and_cmp_is_trunc_even_with_poison_elt   : and_cmp_is_trunc_even_with_poison_elt_before  ⊑  and_cmp_is_trunc_even_with_poison_elt_combined := by
  unfold and_cmp_is_trunc_even_with_poison_elt_before and_cmp_is_trunc_even_with_poison_elt_combined
  simp_alive_peephole
  sorry
def and_cmp_is_trunc_even_with_poison_elts_combined := [llvmfunc|
  llvm.func @and_cmp_is_trunc_even_with_poison_elts(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.poison : i64
    %2 = llvm.mlir.undef : vector<2xi64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi64>
    %7 = llvm.mlir.constant(0 : i64) : i64
    %8 = llvm.mlir.undef : vector<2xi64>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %1, %8[%9 : i32] : vector<2xi64>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %7, %10[%11 : i32] : vector<2xi64>
    %13 = llvm.and %arg0, %6  : vector<2xi64>
    %14 = llvm.icmp "ne" %13, %12 : vector<2xi64>
    llvm.return %14 : vector<2xi1>
  }]

theorem inst_combine_and_cmp_is_trunc_even_with_poison_elts   : and_cmp_is_trunc_even_with_poison_elts_before  ⊑  and_cmp_is_trunc_even_with_poison_elts_combined := by
  unfold and_cmp_is_trunc_even_with_poison_elts_before and_cmp_is_trunc_even_with_poison_elts_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<32767> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.lshr %arg0, %0  : vector<2xi64>
    %3 = llvm.and %2, %1  : vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<2xi64> {
    %0 = llvm.fcmp "ord" %arg0, %arg1 : vector<4xf32>
    %1 = llvm.sext %0 : vector<4xi1> to vector<4xi32>
    %2 = llvm.bitcast %1 : vector<4xi32> to vector<2xi64>
    llvm.return %2 : vector<2xi64>
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<2xi64> {
    %0 = llvm.fcmp "uno" %arg0, %arg1 : vector<4xf32>
    %1 = llvm.sext %0 : vector<4xi1> to vector<4xi32>
    %2 = llvm.bitcast %1 : vector<4xi32> to vector<2xi64>
    llvm.return %2 : vector<2xi64>
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.fcmp "ult" %arg0, %1 : vector<4xf32>
    %3 = llvm.fcmp "ult" %arg1, %1 : vector<4xf32>
    %4 = llvm.and %2, %3  : vector<4xi1>
    %5 = llvm.sext %4 : vector<4xi1> to vector<4xi32>
    %6 = llvm.bitcast %5 : vector<4xi32> to vector<2xi64>
    llvm.return %6 : vector<2xi64>
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
def test6_combined := [llvmfunc|
  llvm.func @test6(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.fcmp "ult" %arg0, %1 : vector<4xf32>
    %3 = llvm.fcmp "ult" %arg1, %1 : vector<4xf32>
    %4 = llvm.or %2, %3  : vector<4xi1>
    %5 = llvm.sext %4 : vector<4xi1> to vector<4xi32>
    %6 = llvm.bitcast %5 : vector<4xi32> to vector<2xi64>
    llvm.return %6 : vector<2xi64>
  }]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
def test7_combined := [llvmfunc|
  llvm.func @test7(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.fcmp "ult" %arg0, %1 : vector<4xf32>
    %3 = llvm.fcmp "ult" %arg1, %1 : vector<4xf32>
    %4 = llvm.xor %2, %3  : vector<4xi1>
    %5 = llvm.sext %4 : vector<4xi1> to vector<4xi32>
    %6 = llvm.bitcast %5 : vector<4xi32> to vector<2xi64>
    llvm.return %6 : vector<2xi64>
  }]

theorem inst_combine_test7   : test7_before  ⊑  test7_combined := by
  unfold test7_before test7_combined
  simp_alive_peephole
  sorry
def convert_combined := [llvmfunc|
  llvm.func @convert(%arg0: !llvm.ptr, %arg1: vector<2xi64>) {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.trunc %arg1 : vector<2xi64> to vector<2xi32>
    %2 = llvm.add %1, %0  : vector<2xi32>
    llvm.store %2, %arg0 {alignment = 8 : i64} : vector<2xi32>, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_convert   : convert_before  ⊑  convert_combined := by
  unfold convert_before convert_combined
  simp_alive_peephole
  sorry
def foo_combined := [llvmfunc|
  llvm.func @foo(%arg0: vector<2xi64>) -> vector<2xi65> {
    %0 = llvm.mlir.constant(dense<4294967295> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.and %arg0, %0  : vector<2xi64>
    %2 = llvm.zext %1 : vector<2xi64> to vector<2xi65>
    llvm.return %2 : vector<2xi65>
  }]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
def bar_combined := [llvmfunc|
  llvm.func @bar(%arg0: vector<2xi65>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<4294967295> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.trunc %arg0 : vector<2xi65> to vector<2xi64>
    %2 = llvm.and %1, %0  : vector<2xi64>
    llvm.return %2 : vector<2xi64>
  }]

theorem inst_combine_bar   : bar_before  ⊑  bar_combined := by
  unfold bar_before bar_combined
  simp_alive_peephole
  sorry
def bars_combined := [llvmfunc|
  llvm.func @bars(%arg0: vector<2xi65>) -> vector<2xi64> {
    %0 = llvm.trunc %arg0 : vector<2xi65> to vector<2xi32>
    %1 = llvm.sext %0 : vector<2xi32> to vector<2xi64>
    llvm.return %1 : vector<2xi64>
  }]

theorem inst_combine_bars   : bars_before  ⊑  bars_combined := by
  unfold bars_before bars_combined
  simp_alive_peephole
  sorry
def quxs_combined := [llvmfunc|
  llvm.func @quxs(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.shl %arg0, %0  : vector<2xi64>
    %2 = llvm.ashr %1, %0  : vector<2xi64>
    llvm.return %2 : vector<2xi64>
  }]

theorem inst_combine_quxs   : quxs_before  ⊑  quxs_combined := by
  unfold quxs_before quxs_combined
  simp_alive_peephole
  sorry
def quxt_combined := [llvmfunc|
  llvm.func @quxt(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.shl %arg0, %0  : vector<2xi64>
    %2 = llvm.ashr %1, %0  : vector<2xi64>
    llvm.return %2 : vector<2xi64>
  }]

theorem inst_combine_quxt   : quxt_before  ⊑  quxt_combined := by
  unfold quxt_before quxt_combined
  simp_alive_peephole
  sorry
def fa_combined := [llvmfunc|
  llvm.func @fa(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.fptrunc %arg0 : vector<2xf64> to vector<2xf32>
    %1 = llvm.fpext %0 : vector<2xf32> to vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }]

theorem inst_combine_fa   : fa_before  ⊑  fa_combined := by
  unfold fa_before fa_combined
  simp_alive_peephole
  sorry
def fb_combined := [llvmfunc|
  llvm.func @fb(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.fptoui %arg0 : vector<2xf64> to vector<2xi64>
    %1 = llvm.uitofp %0 : vector<2xi64> to vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }]

theorem inst_combine_fb   : fb_before  ⊑  fb_combined := by
  unfold fb_before fb_combined
  simp_alive_peephole
  sorry
def fc_combined := [llvmfunc|
  llvm.func @fc(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.fptosi %arg0 : vector<2xf64> to vector<2xi64>
    %1 = llvm.sitofp %0 : vector<2xi64> to vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }]

theorem inst_combine_fc   : fc_before  ⊑  fc_combined := by
  unfold fc_before fc_combined
  simp_alive_peephole
  sorry
def f_combined := [llvmfunc|
  llvm.func @f(%arg0: i32) -> vector<4xf32> {
    %0 = llvm.mlir.undef : vector<4xf32>
    llvm.return %0 : vector<4xf32>
  }]

theorem inst_combine_f   : f_before  ⊑  f_combined := by
  unfold f_before f_combined
  simp_alive_peephole
  sorry
def pr24458_combined := [llvmfunc|
  llvm.func @pr24458(%arg0: vector<8xf32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<8xi32>) : vector<8xi32>
    llvm.return %0 : vector<8xi32>
  }]

theorem inst_combine_pr24458   : pr24458_before  ⊑  pr24458_combined := by
  unfold pr24458_before pr24458_combined
  simp_alive_peephole
  sorry
def trunc_inselt_undef_combined := [llvmfunc|
  llvm.func @trunc_inselt_undef(%arg0: i32) -> vector<3xi16> {
    %0 = llvm.mlir.undef : i16
    %1 = llvm.mlir.poison : i16
    %2 = llvm.mlir.undef : vector<3xi16>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi16>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi16>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi16>
    %9 = llvm.mlir.constant(1 : i64) : i64
    %10 = llvm.trunc %arg0 : i32 to i16
    %11 = llvm.insertelement %10, %8[%9 : i64] : vector<3xi16>
    llvm.return %11 : vector<3xi16>
  }]

theorem inst_combine_trunc_inselt_undef   : trunc_inselt_undef_before  ⊑  trunc_inselt_undef_combined := by
  unfold trunc_inselt_undef_before trunc_inselt_undef_combined
  simp_alive_peephole
  sorry
def fptrunc_inselt_undef_combined := [llvmfunc|
  llvm.func @fptrunc_inselt_undef(%arg0: f64, %arg1: i32) -> vector<2xf32> {
    %0 = llvm.mlir.undef : vector<2xf32>
    %1 = llvm.fptrunc %arg0 : f64 to f32
    %2 = llvm.insertelement %1, %0[%arg1 : i32] : vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }]

theorem inst_combine_fptrunc_inselt_undef   : fptrunc_inselt_undef_before  ⊑  fptrunc_inselt_undef_combined := by
  unfold fptrunc_inselt_undef_before fptrunc_inselt_undef_combined
  simp_alive_peephole
  sorry
def trunc_inselt1_combined := [llvmfunc|
  llvm.func @trunc_inselt1(%arg0: i32) -> vector<3xi16> {
    %0 = llvm.mlir.constant(65536 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.undef : vector<3xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<3xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<3xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<3xi32>
    %10 = llvm.mlir.constant(1 : i64) : i64
    %11 = llvm.insertelement %arg0, %9[%10 : i64] : vector<3xi32>
    %12 = llvm.trunc %11 : vector<3xi32> to vector<3xi16>
    llvm.return %12 : vector<3xi16>
  }]

theorem inst_combine_trunc_inselt1   : trunc_inselt1_before  ⊑  trunc_inselt1_combined := by
  unfold trunc_inselt1_before trunc_inselt1_combined
  simp_alive_peephole
  sorry
def fptrunc_inselt1_combined := [llvmfunc|
  llvm.func @fptrunc_inselt1(%arg0: f64, %arg1: i32) -> vector<2xf32> {
    %0 = llvm.mlir.constant(3.000000e+00 : f64) : f64
    %1 = llvm.mlir.undef : f64
    %2 = llvm.mlir.undef : vector<2xf64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf64>
    %7 = llvm.insertelement %arg0, %6[%arg1 : i32] : vector<2xf64>
    %8 = llvm.fptrunc %7 : vector<2xf64> to vector<2xf32>
    llvm.return %8 : vector<2xf32>
  }]

theorem inst_combine_fptrunc_inselt1   : fptrunc_inselt1_before  ⊑  fptrunc_inselt1_combined := by
  unfold fptrunc_inselt1_before fptrunc_inselt1_combined
  simp_alive_peephole
  sorry
def trunc_inselt2_combined := [llvmfunc|
  llvm.func @trunc_inselt2(%arg0: vector<8xi32>, %arg1: i32) -> vector<8xi16> {
    %0 = llvm.mlir.constant(1048576 : i32) : i32
    %1 = llvm.insertelement %0, %arg0[%arg1 : i32] : vector<8xi32>
    %2 = llvm.trunc %1 : vector<8xi32> to vector<8xi16>
    llvm.return %2 : vector<8xi16>
  }]

theorem inst_combine_trunc_inselt2   : trunc_inselt2_before  ⊑  trunc_inselt2_combined := by
  unfold trunc_inselt2_before trunc_inselt2_combined
  simp_alive_peephole
  sorry
def fptrunc_inselt2_combined := [llvmfunc|
  llvm.func @fptrunc_inselt2(%arg0: vector<3xf64>) -> vector<3xf32> {
    %0 = llvm.mlir.constant(4.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.insertelement %0, %arg0[%1 : i64] : vector<3xf64>
    %3 = llvm.fptrunc %2 : vector<3xf64> to vector<3xf32>
    llvm.return %3 : vector<3xf32>
  }]

theorem inst_combine_fptrunc_inselt2   : fptrunc_inselt2_before  ⊑  fptrunc_inselt2_combined := by
  unfold fptrunc_inselt2_before fptrunc_inselt2_combined
  simp_alive_peephole
  sorry
def sext_less_casting_with_wideop_combined := [llvmfunc|
  llvm.func @sext_less_casting_with_wideop(%arg0: vector<2xi64>, %arg1: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %1 = llvm.trunc %arg1 : vector<2xi64> to vector<2xi32>
    %2 = llvm.mul %0, %1  : vector<2xi32>
    %3 = llvm.sext %2 : vector<2xi32> to vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }]

theorem inst_combine_sext_less_casting_with_wideop   : sext_less_casting_with_wideop_before  ⊑  sext_less_casting_with_wideop_combined := by
  unfold sext_less_casting_with_wideop_before sext_less_casting_with_wideop_combined
  simp_alive_peephole
  sorry
def zext_less_casting_with_wideop_combined := [llvmfunc|
  llvm.func @zext_less_casting_with_wideop(%arg0: vector<2xi64>, %arg1: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %1 = llvm.trunc %arg1 : vector<2xi64> to vector<2xi32>
    %2 = llvm.mul %0, %1  : vector<2xi32>
    %3 = llvm.zext %2 : vector<2xi32> to vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }]

theorem inst_combine_zext_less_casting_with_wideop   : zext_less_casting_with_wideop_before  ⊑  zext_less_casting_with_wideop_combined := by
  unfold zext_less_casting_with_wideop_before zext_less_casting_with_wideop_combined
  simp_alive_peephole
  sorry
