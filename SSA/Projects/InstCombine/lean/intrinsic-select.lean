import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  intrinsic-select
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def ctlz_sel_const_true_false_before := [llvmfunc|
  llvm.func @ctlz_sel_const_true_false(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(-7 : i32) : i32
    %2 = llvm.select %arg0, %0, %1 : i1, i32
    %3 = "llvm.intr.ctlz"(%2) <{is_zero_poison = true}> : (i32) -> i32]

    llvm.return %3 : i32
  }]

def ctlz_sel_const_true_before := [llvmfunc|
  llvm.func @ctlz_sel_const_true(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.select %arg0, %0, %arg1 : i1, i32
    %2 = "llvm.intr.ctlz"(%1) <{is_zero_poison = false}> : (i32) -> i32]

    llvm.return %2 : i32
  }]

def ctlz_sel_const_false_before := [llvmfunc|
  llvm.func @ctlz_sel_const_false(%arg0: vector<3xi1>, %arg1: vector<3xi17>) -> vector<3xi17> {
    %0 = llvm.mlir.constant(0 : i17) : i17
    %1 = llvm.mlir.constant(-1 : i17) : i17
    %2 = llvm.mlir.constant(7 : i17) : i17
    %3 = llvm.mlir.constant(dense<[7, -1, 0]> : vector<3xi17>) : vector<3xi17>
    %4 = llvm.select %arg0, %arg1, %3 : vector<3xi1>, vector<3xi17>
    %5 = "llvm.intr.ctlz"(%4) <{is_zero_poison = true}> : (vector<3xi17>) -> vector<3xi17>]

    llvm.return %5 : vector<3xi17>
  }]

def ctlz_sel_const_true_false_extra_use_before := [llvmfunc|
  llvm.func @ctlz_sel_const_true_false_extra_use(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.select %arg0, %0, %1 : i1, i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = "llvm.intr.ctlz"(%2) <{is_zero_poison = false}> : (i32) -> i32]

    llvm.return %3 : i32
  }]

def cttz_sel_const_true_false_before := [llvmfunc|
  llvm.func @cttz_sel_const_true_false(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(-7 : i32) : i32
    %2 = llvm.select %arg0, %0, %1 : i1, i32
    %3 = "llvm.intr.cttz"(%2) <{is_zero_poison = false}> : (i32) -> i32]

    llvm.return %3 : i32
  }]

def cttz_sel_const_true_before := [llvmfunc|
  llvm.func @cttz_sel_const_true(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.select %arg0, %0, %arg1 : i1, i32
    %2 = "llvm.intr.cttz"(%1) <{is_zero_poison = true}> : (i32) -> i32]

    llvm.return %2 : i32
  }]

def cttz_sel_const_false_before := [llvmfunc|
  llvm.func @cttz_sel_const_false(%arg0: vector<3xi1>, %arg1: vector<3xi5>) -> vector<3xi5> {
    %0 = llvm.mlir.constant(0 : i5) : i5
    %1 = llvm.mlir.constant(-1 : i5) : i5
    %2 = llvm.mlir.constant(7 : i5) : i5
    %3 = llvm.mlir.constant(dense<[7, -1, 0]> : vector<3xi5>) : vector<3xi5>
    %4 = llvm.select %arg0, %arg1, %3 : vector<3xi1>, vector<3xi5>
    %5 = "llvm.intr.cttz"(%4) <{is_zero_poison = false}> : (vector<3xi5>) -> vector<3xi5>]

    llvm.return %5 : vector<3xi5>
  }]

def cttz_sel_const_true_false_extra_use_before := [llvmfunc|
  llvm.func @cttz_sel_const_true_false_extra_use(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(-8 : i32) : i32
    %2 = llvm.select %arg0, %0, %1 : i1, i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = "llvm.intr.cttz"(%2) <{is_zero_poison = true}> : (i32) -> i32]

    llvm.return %3 : i32
  }]

def ctpop_sel_const_true_false_before := [llvmfunc|
  llvm.func @ctpop_sel_const_true_false(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(-7 : i32) : i32
    %2 = llvm.select %arg0, %0, %1 : i1, i32
    %3 = llvm.intr.ctpop(%2)  : (i32) -> i32
    llvm.return %3 : i32
  }]

def ctpop_sel_const_true_before := [llvmfunc|
  llvm.func @ctpop_sel_const_true(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.select %arg0, %0, %arg1 : i1, i32
    %2 = llvm.intr.ctpop(%1)  : (i32) -> i32
    llvm.return %2 : i32
  }]

def ctpop_sel_const_false_before := [llvmfunc|
  llvm.func @ctpop_sel_const_false(%arg0: vector<3xi1>, %arg1: vector<3xi7>) -> vector<3xi7> {
    %0 = llvm.mlir.constant(0 : i7) : i7
    %1 = llvm.mlir.constant(-1 : i7) : i7
    %2 = llvm.mlir.constant(7 : i7) : i7
    %3 = llvm.mlir.constant(dense<[7, -1, 0]> : vector<3xi7>) : vector<3xi7>
    %4 = llvm.select %arg0, %arg1, %3 : vector<3xi1>, vector<3xi7>
    %5 = llvm.intr.ctpop(%4)  : (vector<3xi7>) -> vector<3xi7>
    llvm.return %5 : vector<3xi7>
  }]

def ctpop_sel_const_true_false_extra_use_before := [llvmfunc|
  llvm.func @ctpop_sel_const_true_false_extra_use(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.select %arg0, %0, %1 : i1, i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.intr.ctpop(%2)  : (i32) -> i32
    llvm.return %3 : i32
  }]

def usub_sat_rhs_const_select_all_const_before := [llvmfunc|
  llvm.func @usub_sat_rhs_const_select_all_const(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    %4 = llvm.intr.usub.sat(%3, %2)  : (i32, i32) -> i32
    llvm.return %4 : i32
  }]

def usub_sat_rhs_var_select_all_const_before := [llvmfunc|
  llvm.func @usub_sat_rhs_var_select_all_const(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.select %arg0, %0, %1 : i1, i32
    %3 = llvm.intr.usub.sat(%2, %arg1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

def usub_sat_rhs_const_select_one_const_before := [llvmfunc|
  llvm.func @usub_sat_rhs_const_select_one_const(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.select %arg0, %0, %arg1 : i1, i32
    %3 = llvm.intr.usub.sat(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

def usub_sat_rhs_const_select_no_const_before := [llvmfunc|
  llvm.func @usub_sat_rhs_const_select_no_const(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.select %arg0, %arg2, %arg1 : i1, i32
    %2 = llvm.intr.usub.sat(%1, %0)  : (i32, i32) -> i32
    llvm.return %2 : i32
  }]

def usub_sat_lhs_const_select_all_const_before := [llvmfunc|
  llvm.func @usub_sat_lhs_const_select_all_const(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    %4 = llvm.intr.usub.sat(%2, %3)  : (i32, i32) -> i32
    llvm.return %4 : i32
  }]

def non_speculatable_before := [llvmfunc|
  llvm.func @non_speculatable(%arg0: i1) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.addressof @g1 : !llvm.ptr
    %3 = llvm.mlir.addressof @g2 : !llvm.ptr
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.mlir.constant(true) : i1
    %6 = llvm.mlir.constant(dense<[true, false]> : vector<2xi1>) : vector<2xi1>
    %7 = llvm.mlir.poison : vector<2xi32>
    %8 = llvm.mlir.constant(64 : i32) : i32
    %9 = llvm.select %arg0, %2, %3 : i1, !llvm.ptr
    %10 = llvm.intr.masked.load %9, %6, %7 {alignment = 64 : i32} : (!llvm.ptr, vector<2xi1>, vector<2xi32>) -> vector<2xi32>]

    llvm.return %10 : vector<2xi32>
  }]

def vec_to_scalar_select_scalar_before := [llvmfunc|
  llvm.func @vec_to_scalar_select_scalar(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[3, 4]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.select %arg0, %0, %1 : i1, vector<2xi32>
    %3 = "llvm.intr.vector.reduce.add"(%2) : (vector<2xi32>) -> i32
    llvm.return %3 : i32
  }]

def vec_to_scalar_select_vector_before := [llvmfunc|
  llvm.func @vec_to_scalar_select_vector(%arg0: vector<2xi1>) -> i32 {
    %0 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[3, 4]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.select %arg0, %0, %1 : vector<2xi1>, vector<2xi32>
    %3 = "llvm.intr.vector.reduce.add"(%2) : (vector<2xi32>) -> i32
    llvm.return %3 : i32
  }]

def test_drop_noundef_before := [llvmfunc|
  llvm.func @test_drop_noundef(%arg0: i1, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.select %arg0, %0, %arg1 : i1, i8
    %3 = llvm.intr.smin(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def pr85536_before := [llvmfunc|
  llvm.func @pr85536(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(30 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(48 : i64) : i64
    %3 = llvm.mlir.constant(-1 : i64) : i64
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.mlir.constant(65535 : i64) : i64
    %6 = llvm.icmp "ugt" %arg0, %0 : i32
    %7 = llvm.shl %1, %arg0 overflow<nsw>  : i32
    %8 = llvm.zext %7 : i32 to i64
    %9 = llvm.shl %8, %2  : i64
    %10 = llvm.ashr %9, %2  : i64
    %11 = llvm.select %6, %3, %10 : i1, i64
    %12 = llvm.intr.smin(%11, %4)  : (i64, i64) -> i64
    %13 = llvm.and %12, %5  : i64
    %14 = llvm.icmp "eq" %13, %4 : i64
    llvm.return %14 : i1
  }]

def test_fabs_select1_before := [llvmfunc|
  llvm.func @test_fabs_select1(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(0x7FF8000000000000 : f64) : f64
    %2 = llvm.fcmp "uno" %arg0, %0 : f64
    %3 = llvm.select %2, %1, %arg0 : i1, f64
    %4 = llvm.intr.fabs(%3)  : (f64) -> f64
    %5 = llvm.select %2, %4, %arg0 : i1, f64
    llvm.return %5 : f64
  }]

def test_fabs_select1_vec_before := [llvmfunc|
  llvm.func @test_fabs_select1_vec(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.mlir.constant(dense<0x7FF8000000000000> : vector<2xf64>) : vector<2xf64>
    %3 = llvm.fcmp "uno" %arg0, %1 : vector<2xf64>
    %4 = llvm.select %3, %2, %arg0 : vector<2xi1>, vector<2xf64>
    %5 = llvm.intr.fabs(%4)  : (vector<2xf64>) -> vector<2xf64>
    %6 = llvm.select %3, %5, %arg0 : vector<2xi1>, vector<2xf64>
    llvm.return %6 : vector<2xf64>
  }]

def test_fabs_select2_before := [llvmfunc|
  llvm.func @test_fabs_select2(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0x7FF0000000000000 : f64) : f64
    %1 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %2 = llvm.intr.fabs(%arg0)  : (f64) -> f64
    %3 = llvm.fcmp "oeq" %2, %0 : f64
    %4 = llvm.select %3, %1, %2 : i1, f64
    %5 = llvm.intr.fabs(%4)  : (f64) -> f64
    llvm.return %5 : f64
  }]

def test_fabs_select_fmf1_before := [llvmfunc|
  llvm.func @test_fabs_select_fmf1(%arg0: i1, %arg1: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.select %arg0, %0, %arg1 {fastmathFlags = #llvm.fastmath<nnan, ninf, nsz>} : i1, f64]

    %2 = llvm.intr.fabs(%1)  : (f64) -> f64
    llvm.return %2 : f64
  }]

def test_fabs_select_fmf2_before := [llvmfunc|
  llvm.func @test_fabs_select_fmf2(%arg0: i1, %arg1: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.select %arg0, %0, %arg1 : i1, f64
    %2 = llvm.intr.fabs(%1)  {fastmathFlags = #llvm.fastmath<nnan, ninf, nsz>} : (f64) -> f64]

    llvm.return %2 : f64
  }]

def ctlz_sel_const_true_false_combined := [llvmfunc|
  llvm.func @ctlz_sel_const_true_false(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(29 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.select %arg0, %0, %1 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_ctlz_sel_const_true_false   : ctlz_sel_const_true_false_before  ⊑  ctlz_sel_const_true_false_combined := by
  unfold ctlz_sel_const_true_false_before ctlz_sel_const_true_false_combined
  simp_alive_peephole
  sorry
def ctlz_sel_const_true_combined := [llvmfunc|
  llvm.func @ctlz_sel_const_true(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(29 : i32) : i32
    %1 = "llvm.intr.ctlz"(%arg1) <{is_zero_poison = false}> : (i32) -> i32
    %2 = llvm.select %arg0, %0, %1 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_ctlz_sel_const_true   : ctlz_sel_const_true_before  ⊑  ctlz_sel_const_true_combined := by
  unfold ctlz_sel_const_true_before ctlz_sel_const_true_combined
  simp_alive_peephole
  sorry
def ctlz_sel_const_false_combined := [llvmfunc|
  llvm.func @ctlz_sel_const_false(%arg0: vector<3xi1>, %arg1: vector<3xi17>) -> vector<3xi17> {
    %0 = llvm.mlir.poison : i17
    %1 = llvm.mlir.constant(0 : i17) : i17
    %2 = llvm.mlir.constant(14 : i17) : i17
    %3 = llvm.mlir.undef : vector<3xi17>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<3xi17>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<3xi17>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<3xi17>
    %10 = "llvm.intr.ctlz"(%arg1) <{is_zero_poison = true}> : (vector<3xi17>) -> vector<3xi17>
    %11 = llvm.select %arg0, %10, %9 : vector<3xi1>, vector<3xi17>
    llvm.return %11 : vector<3xi17>
  }]

theorem inst_combine_ctlz_sel_const_false   : ctlz_sel_const_false_before  ⊑  ctlz_sel_const_false_combined := by
  unfold ctlz_sel_const_false_before ctlz_sel_const_false_combined
  simp_alive_peephole
  sorry
def ctlz_sel_const_true_false_extra_use_combined := [llvmfunc|
  llvm.func @ctlz_sel_const_true_false_extra_use(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.select %arg0, %0, %1 : i1, i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = "llvm.intr.ctlz"(%2) <{is_zero_poison = true}> : (i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_ctlz_sel_const_true_false_extra_use   : ctlz_sel_const_true_false_extra_use_before  ⊑  ctlz_sel_const_true_false_extra_use_combined := by
  unfold ctlz_sel_const_true_false_extra_use_before ctlz_sel_const_true_false_extra_use_combined
  simp_alive_peephole
  sorry
def cttz_sel_const_true_false_combined := [llvmfunc|
  llvm.func @cttz_sel_const_true_false(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.select %arg0, %0, %1 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_cttz_sel_const_true_false   : cttz_sel_const_true_false_before  ⊑  cttz_sel_const_true_false_combined := by
  unfold cttz_sel_const_true_false_before cttz_sel_const_true_false_combined
  simp_alive_peephole
  sorry
def cttz_sel_const_true_combined := [llvmfunc|
  llvm.func @cttz_sel_const_true(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = "llvm.intr.cttz"(%arg1) <{is_zero_poison = true}> : (i32) -> i32
    %2 = llvm.select %arg0, %0, %1 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_cttz_sel_const_true   : cttz_sel_const_true_before  ⊑  cttz_sel_const_true_combined := by
  unfold cttz_sel_const_true_before cttz_sel_const_true_combined
  simp_alive_peephole
  sorry
def cttz_sel_const_false_combined := [llvmfunc|
  llvm.func @cttz_sel_const_false(%arg0: vector<3xi1>, %arg1: vector<3xi5>) -> vector<3xi5> {
    %0 = llvm.mlir.constant(5 : i5) : i5
    %1 = llvm.mlir.constant(0 : i5) : i5
    %2 = llvm.mlir.constant(dense<[0, 0, 5]> : vector<3xi5>) : vector<3xi5>
    %3 = "llvm.intr.cttz"(%arg1) <{is_zero_poison = false}> : (vector<3xi5>) -> vector<3xi5>
    %4 = llvm.select %arg0, %3, %2 : vector<3xi1>, vector<3xi5>
    llvm.return %4 : vector<3xi5>
  }]

theorem inst_combine_cttz_sel_const_false   : cttz_sel_const_false_before  ⊑  cttz_sel_const_false_combined := by
  unfold cttz_sel_const_false_before cttz_sel_const_false_combined
  simp_alive_peephole
  sorry
def cttz_sel_const_true_false_extra_use_combined := [llvmfunc|
  llvm.func @cttz_sel_const_true_false_extra_use(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(-8 : i32) : i32
    %2 = llvm.select %arg0, %0, %1 : i1, i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = "llvm.intr.cttz"(%2) <{is_zero_poison = true}> : (i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_cttz_sel_const_true_false_extra_use   : cttz_sel_const_true_false_extra_use_before  ⊑  cttz_sel_const_true_false_extra_use_combined := by
  unfold cttz_sel_const_true_false_extra_use_before cttz_sel_const_true_false_extra_use_combined
  simp_alive_peephole
  sorry
def ctpop_sel_const_true_false_combined := [llvmfunc|
  llvm.func @ctpop_sel_const_true_false(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(30 : i32) : i32
    %2 = llvm.select %arg0, %0, %1 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_ctpop_sel_const_true_false   : ctpop_sel_const_true_false_before  ⊑  ctpop_sel_const_true_false_combined := by
  unfold ctpop_sel_const_true_false_before ctpop_sel_const_true_false_combined
  simp_alive_peephole
  sorry
def ctpop_sel_const_true_combined := [llvmfunc|
  llvm.func @ctpop_sel_const_true(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.intr.ctpop(%arg1)  : (i32) -> i32
    %2 = llvm.select %arg0, %0, %1 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_ctpop_sel_const_true   : ctpop_sel_const_true_before  ⊑  ctpop_sel_const_true_combined := by
  unfold ctpop_sel_const_true_before ctpop_sel_const_true_combined
  simp_alive_peephole
  sorry
def ctpop_sel_const_false_combined := [llvmfunc|
  llvm.func @ctpop_sel_const_false(%arg0: vector<3xi1>, %arg1: vector<3xi7>) -> vector<3xi7> {
    %0 = llvm.mlir.constant(0 : i7) : i7
    %1 = llvm.mlir.constant(7 : i7) : i7
    %2 = llvm.mlir.constant(3 : i7) : i7
    %3 = llvm.mlir.constant(dense<[3, 7, 0]> : vector<3xi7>) : vector<3xi7>
    %4 = llvm.intr.ctpop(%arg1)  : (vector<3xi7>) -> vector<3xi7>
    %5 = llvm.select %arg0, %4, %3 : vector<3xi1>, vector<3xi7>
    llvm.return %5 : vector<3xi7>
  }]

theorem inst_combine_ctpop_sel_const_false   : ctpop_sel_const_false_before  ⊑  ctpop_sel_const_false_combined := by
  unfold ctpop_sel_const_false_before ctpop_sel_const_false_combined
  simp_alive_peephole
  sorry
def ctpop_sel_const_true_false_extra_use_combined := [llvmfunc|
  llvm.func @ctpop_sel_const_true_false_extra_use(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.select %arg0, %0, %1 : i1, i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.intr.ctpop(%2)  : (i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_ctpop_sel_const_true_false_extra_use   : ctpop_sel_const_true_false_extra_use_before  ⊑  ctpop_sel_const_true_false_extra_use_combined := by
  unfold ctpop_sel_const_true_false_extra_use_before ctpop_sel_const_true_false_extra_use_combined
  simp_alive_peephole
  sorry
def usub_sat_rhs_const_select_all_const_combined := [llvmfunc|
  llvm.func @usub_sat_rhs_const_select_all_const(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.select %arg0, %0, %1 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_usub_sat_rhs_const_select_all_const   : usub_sat_rhs_const_select_all_const_before  ⊑  usub_sat_rhs_const_select_all_const_combined := by
  unfold usub_sat_rhs_const_select_all_const_before usub_sat_rhs_const_select_all_const_combined
  simp_alive_peephole
  sorry
def usub_sat_rhs_var_select_all_const_combined := [llvmfunc|
  llvm.func @usub_sat_rhs_var_select_all_const(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.select %arg0, %0, %1 : i1, i32
    %3 = llvm.intr.usub.sat(%2, %arg1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_usub_sat_rhs_var_select_all_const   : usub_sat_rhs_var_select_all_const_before  ⊑  usub_sat_rhs_var_select_all_const_combined := by
  unfold usub_sat_rhs_var_select_all_const_before usub_sat_rhs_var_select_all_const_combined
  simp_alive_peephole
  sorry
def usub_sat_rhs_const_select_one_const_combined := [llvmfunc|
  llvm.func @usub_sat_rhs_const_select_one_const(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.usub.sat(%arg1, %0)  : (i32, i32) -> i32
    %3 = llvm.select %arg0, %1, %2 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_usub_sat_rhs_const_select_one_const   : usub_sat_rhs_const_select_one_const_before  ⊑  usub_sat_rhs_const_select_one_const_combined := by
  unfold usub_sat_rhs_const_select_one_const_before usub_sat_rhs_const_select_one_const_combined
  simp_alive_peephole
  sorry
def usub_sat_rhs_const_select_no_const_combined := [llvmfunc|
  llvm.func @usub_sat_rhs_const_select_no_const(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.select %arg0, %arg2, %arg1 : i1, i32
    %2 = llvm.intr.usub.sat(%1, %0)  : (i32, i32) -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_usub_sat_rhs_const_select_no_const   : usub_sat_rhs_const_select_no_const_before  ⊑  usub_sat_rhs_const_select_no_const_combined := by
  unfold usub_sat_rhs_const_select_no_const_before usub_sat_rhs_const_select_no_const_combined
  simp_alive_peephole
  sorry
def usub_sat_lhs_const_select_all_const_combined := [llvmfunc|
  llvm.func @usub_sat_lhs_const_select_all_const(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.select %arg0, %0, %1 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_usub_sat_lhs_const_select_all_const   : usub_sat_lhs_const_select_all_const_before  ⊑  usub_sat_lhs_const_select_all_const_combined := by
  unfold usub_sat_lhs_const_select_all_const_before usub_sat_lhs_const_select_all_const_combined
  simp_alive_peephole
  sorry
def non_speculatable_combined := [llvmfunc|
  llvm.func @non_speculatable(%arg0: i1) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.addressof @g1 : !llvm.ptr
    %3 = llvm.mlir.addressof @g2 : !llvm.ptr
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.mlir.constant(true) : i1
    %6 = llvm.mlir.constant(dense<[true, false]> : vector<2xi1>) : vector<2xi1>
    %7 = llvm.mlir.poison : vector<2xi32>
    %8 = llvm.mlir.constant(64 : i32) : i32
    %9 = llvm.select %arg0, %2, %3 : i1, !llvm.ptr
    %10 = llvm.intr.masked.load %9, %6, %7 {alignment = 64 : i32} : (!llvm.ptr, vector<2xi1>, vector<2xi32>) -> vector<2xi32>
    llvm.return %10 : vector<2xi32>
  }]

theorem inst_combine_non_speculatable   : non_speculatable_before  ⊑  non_speculatable_combined := by
  unfold non_speculatable_before non_speculatable_combined
  simp_alive_peephole
  sorry
def vec_to_scalar_select_scalar_combined := [llvmfunc|
  llvm.func @vec_to_scalar_select_scalar(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[3, 4]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.select %arg0, %0, %1 : i1, vector<2xi32>
    %3 = "llvm.intr.vector.reduce.add"(%2) : (vector<2xi32>) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_vec_to_scalar_select_scalar   : vec_to_scalar_select_scalar_before  ⊑  vec_to_scalar_select_scalar_combined := by
  unfold vec_to_scalar_select_scalar_before vec_to_scalar_select_scalar_combined
  simp_alive_peephole
  sorry
def vec_to_scalar_select_vector_combined := [llvmfunc|
  llvm.func @vec_to_scalar_select_vector(%arg0: vector<2xi1>) -> i32 {
    %0 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[3, 4]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.select %arg0, %0, %1 : vector<2xi1>, vector<2xi32>
    %3 = "llvm.intr.vector.reduce.add"(%2) : (vector<2xi32>) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_vec_to_scalar_select_vector   : vec_to_scalar_select_vector_before  ⊑  vec_to_scalar_select_vector_combined := by
  unfold vec_to_scalar_select_vector_before vec_to_scalar_select_vector_combined
  simp_alive_peephole
  sorry
def test_drop_noundef_combined := [llvmfunc|
  llvm.func @test_drop_noundef(%arg0: i1, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.intr.smin(%arg1, %0)  : (i8, i8) -> i8
    %3 = llvm.select %arg0, %1, %2 : i1, i8
    llvm.return %3 : i8
  }]

theorem inst_combine_test_drop_noundef   : test_drop_noundef_before  ⊑  test_drop_noundef_combined := by
  unfold test_drop_noundef_before test_drop_noundef_combined
  simp_alive_peephole
  sorry
def pr85536_combined := [llvmfunc|
  llvm.func @pr85536(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(48 : i64) : i64
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.mlir.constant(65535 : i64) : i64
    %5 = llvm.mlir.constant(false) : i1
    %6 = llvm.icmp "ult" %arg0, %0 : i32
    %7 = llvm.shl %1, %arg0 overflow<nsw>  : i32
    %8 = llvm.zext %7 : i32 to i64
    %9 = llvm.shl %8, %2  : i64
    %10 = llvm.ashr %9, %2  : i64
    %11 = llvm.intr.smin(%10, %3)  : (i64, i64) -> i64
    %12 = llvm.and %11, %4  : i64
    %13 = llvm.icmp "eq" %12, %3 : i64
    %14 = llvm.select %6, %13, %5 : i1, i1
    llvm.return %14 : i1
  }]

theorem inst_combine_pr85536   : pr85536_before  ⊑  pr85536_combined := by
  unfold pr85536_before pr85536_combined
  simp_alive_peephole
  sorry
def test_fabs_select1_combined := [llvmfunc|
  llvm.func @test_fabs_select1(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(0x7FF8000000000000 : f64) : f64
    %2 = llvm.fcmp "uno" %arg0, %0 : f64
    %3 = llvm.select %2, %1, %arg0 : i1, f64
    %4 = llvm.intr.fabs(%3)  : (f64) -> f64
    %5 = llvm.select %2, %4, %arg0 : i1, f64
    llvm.return %5 : f64
  }]

theorem inst_combine_test_fabs_select1   : test_fabs_select1_before  ⊑  test_fabs_select1_combined := by
  unfold test_fabs_select1_before test_fabs_select1_combined
  simp_alive_peephole
  sorry
def test_fabs_select1_vec_combined := [llvmfunc|
  llvm.func @test_fabs_select1_vec(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.mlir.constant(dense<0x7FF8000000000000> : vector<2xf64>) : vector<2xf64>
    %3 = llvm.fcmp "uno" %arg0, %1 : vector<2xf64>
    %4 = llvm.select %3, %2, %arg0 : vector<2xi1>, vector<2xf64>
    %5 = llvm.intr.fabs(%4)  : (vector<2xf64>) -> vector<2xf64>
    %6 = llvm.select %3, %5, %arg0 : vector<2xi1>, vector<2xf64>
    llvm.return %6 : vector<2xf64>
  }]

theorem inst_combine_test_fabs_select1_vec   : test_fabs_select1_vec_before  ⊑  test_fabs_select1_vec_combined := by
  unfold test_fabs_select1_vec_before test_fabs_select1_vec_combined
  simp_alive_peephole
  sorry
def test_fabs_select2_combined := [llvmfunc|
  llvm.func @test_fabs_select2(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0x7FF0000000000000 : f64) : f64
    %1 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %2 = llvm.intr.fabs(%arg0)  : (f64) -> f64
    %3 = llvm.fcmp "oeq" %2, %0 : f64
    %4 = llvm.select %3, %1, %2 : i1, f64
    %5 = llvm.intr.fabs(%4)  : (f64) -> f64
    llvm.return %5 : f64
  }]

theorem inst_combine_test_fabs_select2   : test_fabs_select2_before  ⊑  test_fabs_select2_combined := by
  unfold test_fabs_select2_before test_fabs_select2_combined
  simp_alive_peephole
  sorry
def test_fabs_select_fmf1_combined := [llvmfunc|
  llvm.func @test_fabs_select_fmf1(%arg0: i1, %arg1: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.select %arg0, %0, %arg1 {fastmathFlags = #llvm.fastmath<nnan, ninf, nsz>} : i1, f64
    %2 = llvm.intr.fabs(%1)  : (f64) -> f64
    llvm.return %2 : f64
  }]

theorem inst_combine_test_fabs_select_fmf1   : test_fabs_select_fmf1_before  ⊑  test_fabs_select_fmf1_combined := by
  unfold test_fabs_select_fmf1_before test_fabs_select_fmf1_combined
  simp_alive_peephole
  sorry
def test_fabs_select_fmf2_combined := [llvmfunc|
  llvm.func @test_fabs_select_fmf2(%arg0: i1, %arg1: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.select %arg0, %0, %arg1 : i1, f64
    %2 = llvm.intr.fabs(%1)  {fastmathFlags = #llvm.fastmath<nnan, ninf, nsz>} : (f64) -> f64
    llvm.return %2 : f64
  }]

theorem inst_combine_test_fabs_select_fmf2   : test_fabs_select_fmf2_before  ⊑  test_fabs_select_fmf2_combined := by
  unfold test_fabs_select_fmf2_before test_fabs_select_fmf2_combined
  simp_alive_peephole
  sorry
