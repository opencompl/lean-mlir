import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  minmax-fp
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t1_before := [llvmfunc|
  llvm.func @t1(%arg0: f32) -> f64 {
    %0 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %1 = llvm.fcmp "ult" %arg0, %0 : f32
    %2 = llvm.select %1, %arg0, %0 : i1, f32
    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }]

def t2_before := [llvmfunc|
  llvm.func @t2(%arg0: f32) -> f64 {
    %0 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(5.000000e+00 : f64) : f64
    %2 = llvm.fcmp "ult" %arg0, %0 : f32
    %3 = llvm.fpext %arg0 : f32 to f64
    %4 = llvm.select %2, %3, %1 : i1, f64
    llvm.return %4 : f64
  }]

def t4_before := [llvmfunc|
  llvm.func @t4(%arg0: f64) -> f32 {
    %0 = llvm.mlir.constant(5.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %2 = llvm.fcmp "ult" %arg0, %0 : f64
    %3 = llvm.fptrunc %arg0 : f64 to f32
    %4 = llvm.select %2, %3, %1 : i1, f32
    llvm.return %4 : f32
  }]

def t5_before := [llvmfunc|
  llvm.func @t5(%arg0: f32) -> f64 {
    %0 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(5.001000e+00 : f64) : f64
    %2 = llvm.fcmp "ult" %arg0, %0 : f32
    %3 = llvm.fpext %arg0 : f32 to f64
    %4 = llvm.select %2, %3, %1 : i1, f64
    llvm.return %4 : f64
  }]

def not_maxnum_before := [llvmfunc|
  llvm.func @not_maxnum(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 : f32
    %3 = llvm.select %2, %1, %arg0 : i1, f32
    llvm.return %3 : f32
  }]

def t6_before := [llvmfunc|
  llvm.func @t6(%arg0: f32) -> f64 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.fcmp "ult" %arg0, %0 : f32
    %3 = llvm.fpext %arg0 : f32 to f64
    %4 = llvm.select %2, %3, %1 : i1, f64
    llvm.return %4 : f64
  }]

def t7_before := [llvmfunc|
  llvm.func @t7(%arg0: f32) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %2 = llvm.fcmp "ult" %arg0, %0 : f32
    %3 = llvm.fpext %arg0 : f32 to f64
    %4 = llvm.select %2, %3, %1 : i1, f64
    llvm.return %4 : f64
  }]

def fmin_fmin_zero_mismatch_before := [llvmfunc|
  llvm.func @fmin_fmin_zero_mismatch(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 : f32
    %3 = llvm.select %2, %arg0, %1 : i1, f32
    %4 = llvm.fcmp "olt" %3, %1 : f32
    %5 = llvm.select %4, %3, %1 : i1, f32
    llvm.return %5 : f32
  }]

def fmax_fmax_zero_mismatch_before := [llvmfunc|
  llvm.func @fmax_fmax_zero_mismatch(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %2 = llvm.fcmp "ogt" %arg0, %0 : f32
    %3 = llvm.select %2, %arg0, %1 : i1, f32
    %4 = llvm.fcmp "ogt" %0, %3 : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }]

def t8_before := [llvmfunc|
  llvm.func @t8(%arg0: f32) -> i64 {
    %0 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(5 : i64) : i64
    %2 = llvm.fcmp "ult" %arg0, %0 : f32
    %3 = llvm.fptoui %arg0 : f32 to i64
    %4 = llvm.select %2, %3, %1 : i1, i64
    llvm.return %4 : i64
  }]

def t9_before := [llvmfunc|
  llvm.func @t9(%arg0: f32) -> i8 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.fcmp "ult" %arg0, %0 : f32
    %3 = llvm.fptosi %arg0 : f32 to i8
    %4 = llvm.select %2, %3, %1 : i1, i8
    llvm.return %4 : i8
  }]

def t11_before := [llvmfunc|
  llvm.func @t11(%arg0: f32, %arg1: f32) -> i8 {
    %0 = llvm.fcmp "ult" %arg1, %arg0 {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %1 = llvm.fptosi %arg0 : f32 to i8
    %2 = llvm.fptosi %arg1 : f32 to i8
    %3 = llvm.select %0, %2, %1 : i1, i8
    llvm.return %3 : i8
  }]

def t12_before := [llvmfunc|
  llvm.func @t12(%arg0: f32, %arg1: f32) -> i8 {
    %0 = llvm.fcmp "ult" %arg1, %arg0 {fastmathFlags = #llvm.fastmath<nnan>} : f32]

    %1 = llvm.fptosi %arg0 : f32 to i8
    %2 = llvm.fptosi %arg1 : f32 to i8
    %3 = llvm.select %0, %2, %1 : i1, i8
    llvm.return %3 : i8
  }]

def t13_before := [llvmfunc|
  llvm.func @t13(%arg0: f32) -> i8 {
    %0 = llvm.mlir.constant(1.500000e+00 : f32) : f32
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.fcmp "ult" %arg0, %0 : f32
    %3 = llvm.fptosi %arg0 : f32 to i8
    %4 = llvm.select %2, %3, %1 : i1, i8
    llvm.return %4 : i8
  }]

def t14_before := [llvmfunc|
  llvm.func @t14(%arg0: f32) -> i8 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.fcmp "ule" %arg0, %0 : f32
    %3 = llvm.fptosi %arg0 : f32 to i8
    %4 = llvm.select %2, %3, %1 : i1, i8
    llvm.return %4 : i8
  }]

def t14_commute_before := [llvmfunc|
  llvm.func @t14_commute(%arg0: f32) -> i8 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.fcmp "ule" %arg0, %0 : f32
    %3 = llvm.fptosi %arg0 : f32 to i8
    %4 = llvm.select %2, %1, %3 : i1, i8
    llvm.return %4 : i8
  }]

def t15_before := [llvmfunc|
  llvm.func @t15(%arg0: f32) -> i8 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.fcmp "ule" %arg0, %0 {fastmathFlags = #llvm.fastmath<nsz>} : f32]

    %3 = llvm.fptosi %arg0 : f32 to i8
    %4 = llvm.select %2, %3, %1 : i1, i8
    llvm.return %4 : i8
  }]

def t16_before := [llvmfunc|
  llvm.func @t16(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.sitofp %arg0 : i32 to f64
    %4 = llvm.select %2, %3, %1 : i1, f64
    llvm.return %4 : f64
  }]

def t17_before := [llvmfunc|
  llvm.func @t17(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.sitofp %arg0 : i32 to f64
    %4 = llvm.select %2, %3, %1 : i1, f64
    llvm.return %4 : f64
  }]

def fneg_fmax_before := [llvmfunc|
  llvm.func @fneg_fmax(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.fneg %arg1  : f32
    %2 = llvm.fcmp "ogt" %0, %1 {fastmathFlags = #llvm.fastmath<nnan>} : f32]

    %3 = llvm.select %2, %0, %1 : i1, f32
    llvm.return %3 : f32
  }]

def fsub_fmax_before := [llvmfunc|
  llvm.func @fsub_fmax(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fsub %0, %arg0  : vector<2xf32>
    %2 = llvm.fsub %0, %arg1  : vector<2xf32>
    %3 = llvm.fcmp "uge" %1, %2 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : vector<2xf32>]

    %4 = llvm.select %3, %1, %2 : vector<2xi1>, vector<2xf32>
    llvm.return %4 : vector<2xf32>
  }]

def fsub_fmin_before := [llvmfunc|
  llvm.func @fsub_fmin(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.fsub %0, %arg0  : vector<2xf64>
    %2 = llvm.fsub %0, %arg1  : vector<2xf64>
    %3 = llvm.fcmp "olt" %1, %2 {fastmathFlags = #llvm.fastmath<nnan>} : vector<2xf64>]

    %4 = llvm.select %3, %1, %2 : vector<2xi1>, vector<2xf64>
    llvm.return %4 : vector<2xf64>
  }]

def fneg_fmin_before := [llvmfunc|
  llvm.func @fneg_fmin(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.fneg %arg0  : f64
    %1 = llvm.fneg %arg1  : f64
    %2 = llvm.fcmp "ule" %0, %1 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : f64]

    %3 = llvm.select %2, %0, %1 : i1, f64
    llvm.return %3 : f64
  }]

def maxnum_ogt_fmf_on_select_before := [llvmfunc|
  llvm.func @maxnum_ogt_fmf_on_select(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "ogt" %arg0, %arg1 : f32
    %1 = llvm.select %0, %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : i1, f32]

    llvm.return %1 : f32
  }]

def maxnum_oge_fmf_on_select_before := [llvmfunc|
  llvm.func @maxnum_oge_fmf_on_select(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fcmp "oge" %arg0, %arg1 : vector<2xf32>
    %1 = llvm.select %0, %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nnan, ninf, nsz>} : vector<2xi1>, vector<2xf32>]

    llvm.return %1 : vector<2xf32>
  }]

def maxnum_ogt_fmf_on_fcmp_before := [llvmfunc|
  llvm.func @maxnum_ogt_fmf_on_fcmp(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "ogt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : f32]

    %1 = llvm.select %0, %arg0, %arg1 : i1, f32
    llvm.return %1 : f32
  }]

def maxnum_oge_fmf_on_fcmp_before := [llvmfunc|
  llvm.func @maxnum_oge_fmf_on_fcmp(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fcmp "oge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nnan, ninf, nsz>} : vector<2xf32>]

    %1 = llvm.select %0, %arg0, %arg1 : vector<2xi1>, vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }]

def maxnum_no_nsz_before := [llvmfunc|
  llvm.func @maxnum_no_nsz(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "ogt" %arg0, %arg1 : f32
    %1 = llvm.select %0, %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32]

    llvm.return %1 : f32
  }]

def maxnum_no_nnan_before := [llvmfunc|
  llvm.func @maxnum_no_nnan(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "oge" %arg0, %arg1 : f32
    %1 = llvm.select %0, %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nsz>} : i1, f32]

    llvm.return %1 : f32
  }]

def minnum_olt_fmf_on_select_before := [llvmfunc|
  llvm.func @minnum_olt_fmf_on_select(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "olt" %arg0, %arg1 : f32
    %1 = llvm.select %0, %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : i1, f32]

    llvm.return %1 : f32
  }]

def minnum_ole_fmf_on_select_before := [llvmfunc|
  llvm.func @minnum_ole_fmf_on_select(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fcmp "ole" %arg0, %arg1 : vector<2xf32>
    %1 = llvm.select %0, %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nnan, ninf, nsz>} : vector<2xi1>, vector<2xf32>]

    llvm.return %1 : vector<2xf32>
  }]

def minnum_olt_fmf_on_fcmp_before := [llvmfunc|
  llvm.func @minnum_olt_fmf_on_fcmp(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "olt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : f32]

    %1 = llvm.select %0, %arg0, %arg1 : i1, f32
    llvm.return %1 : f32
  }]

def minnum_ole_fmf_on_fcmp_before := [llvmfunc|
  llvm.func @minnum_ole_fmf_on_fcmp(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fcmp "ole" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nnan, ninf, nsz>} : vector<2xf32>]

    %1 = llvm.select %0, %arg0, %arg1 : vector<2xi1>, vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }]

def minnum_no_nsz_before := [llvmfunc|
  llvm.func @minnum_no_nsz(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "olt" %arg0, %arg1 : f32
    %1 = llvm.select %0, %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32]

    llvm.return %1 : f32
  }]

def minnum_no_nnan_before := [llvmfunc|
  llvm.func @minnum_no_nnan(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "ole" %arg0, %arg1 : f32
    %1 = llvm.select %0, %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nsz>} : i1, f32]

    llvm.return %1 : f32
  }]

def pr64937_preserve_min_idiom_before := [llvmfunc|
  llvm.func @pr64937_preserve_min_idiom(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(3.276700e+04 : f32) : f32
    %1 = llvm.mlir.constant(6.553600e+04 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 {fastmathFlags = #llvm.fastmath<nnan>} : f32]

    %3 = llvm.select %2, %arg0, %0 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32]

    %4 = llvm.fmul %3, %1  {fastmathFlags = #llvm.fastmath<nnan>} : f32]

    llvm.return %4 : f32
  }]

def t1_combined := [llvmfunc|
  llvm.func @t1(%arg0: f32) -> f64 {
    %0 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oge" %arg0, %0 : f32
    %2 = llvm.select %1, %0, %arg0 : i1, f32
    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }]

theorem inst_combine_t1   : t1_before  ⊑  t1_combined := by
  unfold t1_before t1_combined
  simp_alive_peephole
  sorry
def t2_combined := [llvmfunc|
  llvm.func @t2(%arg0: f32) -> f64 {
    %0 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oge" %arg0, %0 : f32
    %2 = llvm.select %1, %0, %arg0 : i1, f32
    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }]

theorem inst_combine_t2   : t2_before  ⊑  t2_combined := by
  unfold t2_before t2_combined
  simp_alive_peephole
  sorry
def t4_combined := [llvmfunc|
  llvm.func @t4(%arg0: f64) -> f32 {
    %0 = llvm.mlir.constant(5.000000e+00 : f64) : f64
    %1 = llvm.fcmp "oge" %arg0, %0 : f64
    %2 = llvm.select %1, %0, %arg0 : i1, f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }]

theorem inst_combine_t4   : t4_before  ⊑  t4_combined := by
  unfold t4_before t4_combined
  simp_alive_peephole
  sorry
def t5_combined := [llvmfunc|
  llvm.func @t5(%arg0: f32) -> f64 {
    %0 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(5.001000e+00 : f64) : f64
    %2 = llvm.fcmp "ult" %arg0, %0 : f32
    %3 = llvm.fpext %arg0 : f32 to f64
    %4 = llvm.select %2, %3, %1 : i1, f64
    llvm.return %4 : f64
  }]

theorem inst_combine_t5   : t5_before  ⊑  t5_combined := by
  unfold t5_before t5_combined
  simp_alive_peephole
  sorry
def not_maxnum_combined := [llvmfunc|
  llvm.func @not_maxnum(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 : f32
    %3 = llvm.select %2, %1, %arg0 : i1, f32
    llvm.return %3 : f32
  }]

theorem inst_combine_not_maxnum   : not_maxnum_before  ⊑  not_maxnum_combined := by
  unfold not_maxnum_before not_maxnum_combined
  simp_alive_peephole
  sorry
def t6_combined := [llvmfunc|
  llvm.func @t6(%arg0: f32) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oge" %arg0, %0 : f32
    %2 = llvm.select %1, %0, %arg0 : i1, f32
    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }]

theorem inst_combine_t6   : t6_before  ⊑  t6_combined := by
  unfold t6_before t6_combined
  simp_alive_peephole
  sorry
def t7_combined := [llvmfunc|
  llvm.func @t7(%arg0: f32) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %2 = llvm.fcmp "ult" %arg0, %0 : f32
    %3 = llvm.fpext %arg0 : f32 to f64
    %4 = llvm.select %2, %3, %1 : i1, f64
    llvm.return %4 : f64
  }]

theorem inst_combine_t7   : t7_before  ⊑  t7_combined := by
  unfold t7_before t7_combined
  simp_alive_peephole
  sorry
def fmin_fmin_zero_mismatch_combined := [llvmfunc|
  llvm.func @fmin_fmin_zero_mismatch(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "olt" %arg0, %0 : f32
    %2 = llvm.select %1, %arg0, %0 : i1, f32
    llvm.return %2 : f32
  }]

theorem inst_combine_fmin_fmin_zero_mismatch   : fmin_fmin_zero_mismatch_before  ⊑  fmin_fmin_zero_mismatch_combined := by
  unfold fmin_fmin_zero_mismatch_before fmin_fmin_zero_mismatch_combined
  simp_alive_peephole
  sorry
def fmax_fmax_zero_mismatch_combined := [llvmfunc|
  llvm.func @fmax_fmax_zero_mismatch(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %2 = llvm.fcmp "ogt" %arg0, %0 : f32
    %3 = llvm.select %2, %arg0, %1 : i1, f32
    llvm.return %3 : f32
  }]

theorem inst_combine_fmax_fmax_zero_mismatch   : fmax_fmax_zero_mismatch_before  ⊑  fmax_fmax_zero_mismatch_combined := by
  unfold fmax_fmax_zero_mismatch_before fmax_fmax_zero_mismatch_combined
  simp_alive_peephole
  sorry
def t8_combined := [llvmfunc|
  llvm.func @t8(%arg0: f32) -> i64 {
    %0 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oge" %arg0, %0 : f32
    %2 = llvm.select %1, %0, %arg0 : i1, f32
    %3 = llvm.fptoui %2 : f32 to i64
    llvm.return %3 : i64
  }]

theorem inst_combine_t8   : t8_before  ⊑  t8_combined := by
  unfold t8_before t8_combined
  simp_alive_peephole
  sorry
def t9_combined := [llvmfunc|
  llvm.func @t9(%arg0: f32) -> i8 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oge" %arg0, %0 : f32
    %2 = llvm.select %1, %0, %arg0 : i1, f32
    %3 = llvm.fptosi %2 : f32 to i8
    llvm.return %3 : i8
  }]

theorem inst_combine_t9   : t9_before  ⊑  t9_combined := by
  unfold t9_before t9_combined
  simp_alive_peephole
  sorry
def t11_combined := [llvmfunc|
  llvm.func @t11(%arg0: f32, %arg1: f32) -> i8 {
    %0 = llvm.fcmp "oge" %arg1, %arg0 {fastmathFlags = #llvm.fastmath<fast>} : f32
    %1 = llvm.select %0, %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : i1, f32
    %2 = llvm.fptosi %1 : f32 to i8
    llvm.return %2 : i8
  }]

theorem inst_combine_t11   : t11_before  ⊑  t11_combined := by
  unfold t11_before t11_combined
  simp_alive_peephole
  sorry
def t12_combined := [llvmfunc|
  llvm.func @t12(%arg0: f32, %arg1: f32) -> i8 {
    %0 = llvm.fcmp "oge" %arg1, %arg0 {fastmathFlags = #llvm.fastmath<nnan>} : f32
    %1 = llvm.select %0, %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32
    %2 = llvm.fptosi %1 : f32 to i8
    llvm.return %2 : i8
  }]

theorem inst_combine_t12   : t12_before  ⊑  t12_combined := by
  unfold t12_before t12_combined
  simp_alive_peephole
  sorry
def t13_combined := [llvmfunc|
  llvm.func @t13(%arg0: f32) -> i8 {
    %0 = llvm.mlir.constant(1.500000e+00 : f32) : f32
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.fcmp "ult" %arg0, %0 : f32
    %3 = llvm.fptosi %arg0 : f32 to i8
    %4 = llvm.select %2, %3, %1 : i1, i8
    llvm.return %4 : i8
  }]

theorem inst_combine_t13   : t13_before  ⊑  t13_combined := by
  unfold t13_before t13_combined
  simp_alive_peephole
  sorry
def t14_combined := [llvmfunc|
  llvm.func @t14(%arg0: f32) -> i8 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oge" %arg0, %0 : f32
    %2 = llvm.select %1, %0, %arg0 : i1, f32
    %3 = llvm.fptosi %2 : f32 to i8
    llvm.return %3 : i8
  }]

theorem inst_combine_t14   : t14_before  ⊑  t14_combined := by
  unfold t14_before t14_combined
  simp_alive_peephole
  sorry
def t14_commute_combined := [llvmfunc|
  llvm.func @t14_commute(%arg0: f32) -> i8 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "ogt" %arg0, %0 : f32
    %2 = llvm.select %1, %arg0, %0 : i1, f32
    %3 = llvm.fptosi %2 : f32 to i8
    llvm.return %3 : i8
  }]

theorem inst_combine_t14_commute   : t14_commute_before  ⊑  t14_commute_combined := by
  unfold t14_commute_before t14_commute_combined
  simp_alive_peephole
  sorry
def t15_combined := [llvmfunc|
  llvm.func @t15(%arg0: f32) -> i8 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oge" %arg0, %0 {fastmathFlags = #llvm.fastmath<nsz>} : f32
    %2 = llvm.select %1, %0, %arg0 {fastmathFlags = #llvm.fastmath<nsz>} : i1, f32
    %3 = llvm.fptosi %2 : f32 to i8
    llvm.return %3 : i8
  }]

theorem inst_combine_t15   : t15_before  ⊑  t15_combined := by
  unfold t15_before t15_combined
  simp_alive_peephole
  sorry
def t16_combined := [llvmfunc|
  llvm.func @t16(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.sitofp %arg0 : i32 to f64
    %4 = llvm.select %2, %3, %1 : i1, f64
    llvm.return %4 : f64
  }]

theorem inst_combine_t16   : t16_before  ⊑  t16_combined := by
  unfold t16_before t16_combined
  simp_alive_peephole
  sorry
def t17_combined := [llvmfunc|
  llvm.func @t17(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    %2 = llvm.sitofp %1 : i32 to f64
    llvm.return %2 : f64
  }]

theorem inst_combine_t17   : t17_before  ⊑  t17_combined := by
  unfold t17_before t17_combined
  simp_alive_peephole
  sorry
def fneg_fmax_combined := [llvmfunc|
  llvm.func @fneg_fmax(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "olt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nnan>} : f32
    %1 = llvm.select %0, %arg0, %arg1 : i1, f32
    %2 = llvm.fneg %1  : f32
    llvm.return %2 : f32
  }]

theorem inst_combine_fneg_fmax   : fneg_fmax_before  ⊑  fneg_fmax_combined := by
  unfold fneg_fmax_before fneg_fmax_combined
  simp_alive_peephole
  sorry
def fsub_fmax_combined := [llvmfunc|
  llvm.func @fsub_fmax(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fcmp "ogt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : vector<2xf32>
    %1 = llvm.select %0, %arg1, %arg0 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : vector<2xi1>, vector<2xf32>
    %2 = llvm.fneg %1  : vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }]

theorem inst_combine_fsub_fmax   : fsub_fmax_before  ⊑  fsub_fmax_combined := by
  unfold fsub_fmax_before fsub_fmax_combined
  simp_alive_peephole
  sorry
def fsub_fmin_combined := [llvmfunc|
  llvm.func @fsub_fmin(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.fcmp "ogt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nnan>} : vector<2xf64>
    %1 = llvm.select %0, %arg0, %arg1 : vector<2xi1>, vector<2xf64>
    %2 = llvm.fneg %1  : vector<2xf64>
    llvm.return %2 : vector<2xf64>
  }]

theorem inst_combine_fsub_fmin   : fsub_fmin_before  ⊑  fsub_fmin_combined := by
  unfold fsub_fmin_before fsub_fmin_combined
  simp_alive_peephole
  sorry
def fneg_fmin_combined := [llvmfunc|
  llvm.func @fneg_fmin(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.fcmp "olt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : f64
    %1 = llvm.select %0, %arg1, %arg0 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : i1, f64
    %2 = llvm.fneg %1  : f64
    llvm.return %2 : f64
  }]

theorem inst_combine_fneg_fmin   : fneg_fmin_before  ⊑  fneg_fmin_combined := by
  unfold fneg_fmin_before fneg_fmin_combined
  simp_alive_peephole
  sorry
def maxnum_ogt_fmf_on_select_combined := [llvmfunc|
  llvm.func @maxnum_ogt_fmf_on_select(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.maxnum(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (f32, f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_maxnum_ogt_fmf_on_select   : maxnum_ogt_fmf_on_select_before  ⊑  maxnum_ogt_fmf_on_select_combined := by
  unfold maxnum_ogt_fmf_on_select_before maxnum_ogt_fmf_on_select_combined
  simp_alive_peephole
  sorry
def maxnum_oge_fmf_on_select_combined := [llvmfunc|
  llvm.func @maxnum_oge_fmf_on_select(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.intr.maxnum(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<nnan, ninf, nsz>} : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    llvm.return %0 : vector<2xf32>
  }]

theorem inst_combine_maxnum_oge_fmf_on_select   : maxnum_oge_fmf_on_select_before  ⊑  maxnum_oge_fmf_on_select_combined := by
  unfold maxnum_oge_fmf_on_select_before maxnum_oge_fmf_on_select_combined
  simp_alive_peephole
  sorry
def maxnum_ogt_fmf_on_fcmp_combined := [llvmfunc|
  llvm.func @maxnum_ogt_fmf_on_fcmp(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "ogt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : f32
    %1 = llvm.select %0, %arg0, %arg1 : i1, f32
    llvm.return %1 : f32
  }]

theorem inst_combine_maxnum_ogt_fmf_on_fcmp   : maxnum_ogt_fmf_on_fcmp_before  ⊑  maxnum_ogt_fmf_on_fcmp_combined := by
  unfold maxnum_ogt_fmf_on_fcmp_before maxnum_ogt_fmf_on_fcmp_combined
  simp_alive_peephole
  sorry
def maxnum_oge_fmf_on_fcmp_combined := [llvmfunc|
  llvm.func @maxnum_oge_fmf_on_fcmp(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fcmp "oge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nnan, ninf, nsz>} : vector<2xf32>
    %1 = llvm.select %0, %arg0, %arg1 : vector<2xi1>, vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }]

theorem inst_combine_maxnum_oge_fmf_on_fcmp   : maxnum_oge_fmf_on_fcmp_before  ⊑  maxnum_oge_fmf_on_fcmp_combined := by
  unfold maxnum_oge_fmf_on_fcmp_before maxnum_oge_fmf_on_fcmp_combined
  simp_alive_peephole
  sorry
def maxnum_no_nsz_combined := [llvmfunc|
  llvm.func @maxnum_no_nsz(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "ogt" %arg0, %arg1 : f32
    %1 = llvm.select %0, %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32
    llvm.return %1 : f32
  }]

theorem inst_combine_maxnum_no_nsz   : maxnum_no_nsz_before  ⊑  maxnum_no_nsz_combined := by
  unfold maxnum_no_nsz_before maxnum_no_nsz_combined
  simp_alive_peephole
  sorry
def maxnum_no_nnan_combined := [llvmfunc|
  llvm.func @maxnum_no_nnan(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "oge" %arg0, %arg1 : f32
    %1 = llvm.select %0, %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nsz>} : i1, f32
    llvm.return %1 : f32
  }]

theorem inst_combine_maxnum_no_nnan   : maxnum_no_nnan_before  ⊑  maxnum_no_nnan_combined := by
  unfold maxnum_no_nnan_before maxnum_no_nnan_combined
  simp_alive_peephole
  sorry
def minnum_olt_fmf_on_select_combined := [llvmfunc|
  llvm.func @minnum_olt_fmf_on_select(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.minnum(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (f32, f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_minnum_olt_fmf_on_select   : minnum_olt_fmf_on_select_before  ⊑  minnum_olt_fmf_on_select_combined := by
  unfold minnum_olt_fmf_on_select_before minnum_olt_fmf_on_select_combined
  simp_alive_peephole
  sorry
def minnum_ole_fmf_on_select_combined := [llvmfunc|
  llvm.func @minnum_ole_fmf_on_select(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.intr.minnum(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<nnan, ninf, nsz>} : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    llvm.return %0 : vector<2xf32>
  }]

theorem inst_combine_minnum_ole_fmf_on_select   : minnum_ole_fmf_on_select_before  ⊑  minnum_ole_fmf_on_select_combined := by
  unfold minnum_ole_fmf_on_select_before minnum_ole_fmf_on_select_combined
  simp_alive_peephole
  sorry
def minnum_olt_fmf_on_fcmp_combined := [llvmfunc|
  llvm.func @minnum_olt_fmf_on_fcmp(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "olt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : f32
    %1 = llvm.select %0, %arg0, %arg1 : i1, f32
    llvm.return %1 : f32
  }]

theorem inst_combine_minnum_olt_fmf_on_fcmp   : minnum_olt_fmf_on_fcmp_before  ⊑  minnum_olt_fmf_on_fcmp_combined := by
  unfold minnum_olt_fmf_on_fcmp_before minnum_olt_fmf_on_fcmp_combined
  simp_alive_peephole
  sorry
def minnum_ole_fmf_on_fcmp_combined := [llvmfunc|
  llvm.func @minnum_ole_fmf_on_fcmp(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fcmp "ole" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nnan, ninf, nsz>} : vector<2xf32>
    %1 = llvm.select %0, %arg0, %arg1 : vector<2xi1>, vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }]

theorem inst_combine_minnum_ole_fmf_on_fcmp   : minnum_ole_fmf_on_fcmp_before  ⊑  minnum_ole_fmf_on_fcmp_combined := by
  unfold minnum_ole_fmf_on_fcmp_before minnum_ole_fmf_on_fcmp_combined
  simp_alive_peephole
  sorry
def minnum_no_nsz_combined := [llvmfunc|
  llvm.func @minnum_no_nsz(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "olt" %arg0, %arg1 : f32
    %1 = llvm.select %0, %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32
    llvm.return %1 : f32
  }]

theorem inst_combine_minnum_no_nsz   : minnum_no_nsz_before  ⊑  minnum_no_nsz_combined := by
  unfold minnum_no_nsz_before minnum_no_nsz_combined
  simp_alive_peephole
  sorry
def minnum_no_nnan_combined := [llvmfunc|
  llvm.func @minnum_no_nnan(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "ole" %arg0, %arg1 : f32
    %1 = llvm.select %0, %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nsz>} : i1, f32
    llvm.return %1 : f32
  }]

theorem inst_combine_minnum_no_nnan   : minnum_no_nnan_before  ⊑  minnum_no_nnan_combined := by
  unfold minnum_no_nnan_before minnum_no_nnan_combined
  simp_alive_peephole
  sorry
def pr64937_preserve_min_idiom_combined := [llvmfunc|
  llvm.func @pr64937_preserve_min_idiom(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(3.276700e+04 : f32) : f32
    %1 = llvm.mlir.constant(6.553600e+04 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 {fastmathFlags = #llvm.fastmath<nnan>} : f32
    %3 = llvm.select %2, %arg0, %0 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32
    %4 = llvm.fmul %3, %1  {fastmathFlags = #llvm.fastmath<nnan>} : f32
    llvm.return %4 : f32
  }]

theorem inst_combine_pr64937_preserve_min_idiom   : pr64937_preserve_min_idiom_before  ⊑  pr64937_preserve_min_idiom_combined := by
  unfold pr64937_preserve_min_idiom_before pr64937_preserve_min_idiom_combined
  simp_alive_peephole
  sorry
