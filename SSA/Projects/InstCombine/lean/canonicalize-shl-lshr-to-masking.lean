import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  canonicalize-shl-lshr-to-masking
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def positive_samevar_before := [llvmfunc|
  llvm.func @positive_samevar(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1  : i32
    %1 = llvm.lshr %0, %arg1  : i32
    llvm.return %1 : i32
  }]

def positive_sameconst_before := [llvmfunc|
  llvm.func @positive_sameconst(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.shl %arg0, %0  : i32
    %2 = llvm.lshr %1, %0  : i32
    llvm.return %2 : i32
  }]

def positive_biggerShl_before := [llvmfunc|
  llvm.func @positive_biggerShl(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }]

def positive_biggerLshr_before := [llvmfunc|
  llvm.func @positive_biggerLshr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }]

def positive_biggerLshr_lshrexact_before := [llvmfunc|
  llvm.func @positive_biggerLshr_lshrexact(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }]

def positive_samevar_shlnuw_before := [llvmfunc|
  llvm.func @positive_samevar_shlnuw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.lshr %0, %arg1  : i32
    llvm.return %1 : i32
  }]

def positive_sameconst_shlnuw_before := [llvmfunc|
  llvm.func @positive_sameconst_shlnuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.shl %arg0, %0 overflow<nuw>  : i32
    %2 = llvm.lshr %1, %0  : i32
    llvm.return %2 : i32
  }]

def positive_biggerShl_shlnuw_before := [llvmfunc|
  llvm.func @positive_biggerShl_shlnuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.shl %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }]

def positive_biggerLshr_shlnuw_before := [llvmfunc|
  llvm.func @positive_biggerLshr_shlnuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.shl %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }]

def positive_biggerLshr_shlnuw_lshrexact_before := [llvmfunc|
  llvm.func @positive_biggerLshr_shlnuw_lshrexact(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.shl %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }]

def positive_samevar_vec_before := [llvmfunc|
  llvm.func @positive_samevar_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.shl %arg0, %arg1  : vector<2xi32>
    %1 = llvm.lshr %0, %arg1  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

def positive_sameconst_vec_before := [llvmfunc|
  llvm.func @positive_sameconst_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.shl %arg0, %0  : vector<2xi32>
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def positive_sameconst_vec_undef0_before := [llvmfunc|
  llvm.func @positive_sameconst_vec_undef0(%arg0: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(dense<5> : vector<3xi32>) : vector<3xi32>
    %10 = llvm.shl %arg0, %8  : vector<3xi32>
    %11 = llvm.lshr %10, %9  : vector<3xi32>
    llvm.return %11 : vector<3xi32>
  }]

def positive_sameconst_vec_undef1_before := [llvmfunc|
  llvm.func @positive_sameconst_vec_undef1(%arg0: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(dense<5> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.undef : i32
    %3 = llvm.mlir.undef : vector<3xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<3xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<3xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<3xi32>
    %10 = llvm.shl %arg0, %0  : vector<3xi32>
    %11 = llvm.lshr %10, %9  : vector<3xi32>
    llvm.return %11 : vector<3xi32>
  }]

def positive_sameconst_vec_undef2_before := [llvmfunc|
  llvm.func @positive_sameconst_vec_undef2(%arg0: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.shl %arg0, %8  : vector<3xi32>
    %10 = llvm.lshr %9, %8  : vector<3xi32>
    llvm.return %10 : vector<3xi32>
  }]

def positive_biggerShl_vec_before := [llvmfunc|
  llvm.func @positive_biggerShl_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<10> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<5> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.shl %arg0, %0  : vector<2xi32>
    %3 = llvm.lshr %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def positive_biggerShl_vec_undef0_before := [llvmfunc|
  llvm.func @positive_biggerShl_vec_undef0(%arg0: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(dense<5> : vector<3xi32>) : vector<3xi32>
    %10 = llvm.shl %arg0, %8  : vector<3xi32>
    %11 = llvm.lshr %10, %9  : vector<3xi32>
    llvm.return %11 : vector<3xi32>
  }]

def positive_biggerShl_vec_undef1_before := [llvmfunc|
  llvm.func @positive_biggerShl_vec_undef1(%arg0: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(dense<10> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.undef : i32
    %3 = llvm.mlir.undef : vector<3xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<3xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<3xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<3xi32>
    %10 = llvm.shl %arg0, %0  : vector<3xi32>
    %11 = llvm.lshr %10, %9  : vector<3xi32>
    llvm.return %11 : vector<3xi32>
  }]

def positive_biggerShl_vec_undef2_before := [llvmfunc|
  llvm.func @positive_biggerShl_vec_undef2(%arg0: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(5 : i32) : i32
    %10 = llvm.mlir.undef : vector<3xi32>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<3xi32>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %1, %12[%13 : i32] : vector<3xi32>
    %15 = llvm.mlir.constant(2 : i32) : i32
    %16 = llvm.insertelement %9, %14[%15 : i32] : vector<3xi32>
    %17 = llvm.shl %arg0, %8  : vector<3xi32>
    %18 = llvm.lshr %17, %16  : vector<3xi32>
    llvm.return %18 : vector<3xi32>
  }]

def positive_biggerLshr_vec_before := [llvmfunc|
  llvm.func @positive_biggerLshr_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<10> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.shl %arg0, %0  : vector<2xi32>
    %3 = llvm.lshr %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def positive_biggerLshr_vec_undef0_before := [llvmfunc|
  llvm.func @positive_biggerLshr_vec_undef0(%arg0: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(dense<10> : vector<3xi32>) : vector<3xi32>
    %10 = llvm.shl %arg0, %8  : vector<3xi32>
    %11 = llvm.lshr %10, %9  : vector<3xi32>
    llvm.return %11 : vector<3xi32>
  }]

def positive_biggerLshr_vec_undef1_before := [llvmfunc|
  llvm.func @positive_biggerLshr_vec_undef1(%arg0: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(dense<5> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.mlir.undef : i32
    %3 = llvm.mlir.undef : vector<3xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<3xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<3xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<3xi32>
    %10 = llvm.shl %arg0, %0  : vector<3xi32>
    %11 = llvm.lshr %10, %9  : vector<3xi32>
    llvm.return %11 : vector<3xi32>
  }]

def positive_biggerLshr_vec_undef2_before := [llvmfunc|
  llvm.func @positive_biggerLshr_vec_undef2(%arg0: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(10 : i32) : i32
    %10 = llvm.mlir.undef : vector<3xi32>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<3xi32>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %1, %12[%13 : i32] : vector<3xi32>
    %15 = llvm.mlir.constant(2 : i32) : i32
    %16 = llvm.insertelement %9, %14[%15 : i32] : vector<3xi32>
    %17 = llvm.shl %arg0, %8  : vector<3xi32>
    %18 = llvm.lshr %17, %16  : vector<3xi32>
    llvm.return %18 : vector<3xi32>
  }]

def positive_sameconst_multiuse_before := [llvmfunc|
  llvm.func @positive_sameconst_multiuse(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.shl %arg0, %0  : i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.lshr %1, %0  : i32
    llvm.return %2 : i32
  }]

def positive_biggerShl_shlnuw_multiuse_before := [llvmfunc|
  llvm.func @positive_biggerShl_shlnuw_multiuse(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.shl %arg0, %0 overflow<nuw>  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }]

def positive_biggerLshr_shlnuw_multiuse_before := [llvmfunc|
  llvm.func @positive_biggerLshr_shlnuw_multiuse(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.shl %arg0, %0 overflow<nuw>  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }]

def positive_biggerShl_multiuse_extrainstr_before := [llvmfunc|
  llvm.func @positive_biggerShl_multiuse_extrainstr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }]

def positive_biggerLshr_multiuse_extrainstr_before := [llvmfunc|
  llvm.func @positive_biggerLshr_multiuse_extrainstr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }]

def positive_biggerShl_vec_nonsplat_before := [llvmfunc|
  llvm.func @positive_biggerShl_vec_nonsplat(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[5, 10]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.shl %arg0, %0  : vector<2xi32>
    %3 = llvm.lshr %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def positive_biggerLshl_vec_nonsplat_before := [llvmfunc|
  llvm.func @positive_biggerLshl_vec_nonsplat(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[5, 10]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<5> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.shl %arg0, %0  : vector<2xi32>
    %3 = llvm.lshr %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def negative_twovars_before := [llvmfunc|
  llvm.func @negative_twovars(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1  : i32
    %1 = llvm.lshr %0, %arg2  : i32
    llvm.return %1 : i32
  }]

def negative_oneuse_before := [llvmfunc|
  llvm.func @negative_oneuse(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1  : i32
    llvm.call @use32(%0) : (i32) -> ()
    %1 = llvm.lshr %0, %arg1  : i32
    llvm.return %1 : i32
  }]

def positive_samevar_combined := [llvmfunc|
  llvm.func @positive_samevar(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.lshr %0, %arg1  : i32
    %2 = llvm.and %1, %arg0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_positive_samevar   : positive_samevar_before  ⊑  positive_samevar_combined := by
  unfold positive_samevar_before positive_samevar_combined
  simp_alive_peephole
  sorry
def positive_sameconst_combined := [llvmfunc|
  llvm.func @positive_sameconst(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(134217727 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_positive_sameconst   : positive_sameconst_before  ⊑  positive_sameconst_combined := by
  unfold positive_sameconst_before positive_sameconst_combined
  simp_alive_peephole
  sorry
def positive_biggerShl_combined := [llvmfunc|
  llvm.func @positive_biggerShl(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(134217696 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_positive_biggerShl   : positive_biggerShl_before  ⊑  positive_biggerShl_combined := by
  unfold positive_biggerShl_before positive_biggerShl_combined
  simp_alive_peephole
  sorry
def positive_biggerLshr_combined := [llvmfunc|
  llvm.func @positive_biggerLshr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(4194303 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_positive_biggerLshr   : positive_biggerLshr_before  ⊑  positive_biggerLshr_combined := by
  unfold positive_biggerLshr_before positive_biggerLshr_combined
  simp_alive_peephole
  sorry
def positive_biggerLshr_lshrexact_combined := [llvmfunc|
  llvm.func @positive_biggerLshr_lshrexact(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(4194303 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_positive_biggerLshr_lshrexact   : positive_biggerLshr_lshrexact_before  ⊑  positive_biggerLshr_lshrexact_combined := by
  unfold positive_biggerLshr_lshrexact_before positive_biggerLshr_lshrexact_combined
  simp_alive_peephole
  sorry
def positive_samevar_shlnuw_combined := [llvmfunc|
  llvm.func @positive_samevar_shlnuw(%arg0: i32, %arg1: i32) -> i32 {
    llvm.return %arg0 : i32
  }]

theorem inst_combine_positive_samevar_shlnuw   : positive_samevar_shlnuw_before  ⊑  positive_samevar_shlnuw_combined := by
  unfold positive_samevar_shlnuw_before positive_samevar_shlnuw_combined
  simp_alive_peephole
  sorry
def positive_sameconst_shlnuw_combined := [llvmfunc|
  llvm.func @positive_sameconst_shlnuw(%arg0: i32) -> i32 {
    llvm.return %arg0 : i32
  }]

theorem inst_combine_positive_sameconst_shlnuw   : positive_sameconst_shlnuw_before  ⊑  positive_sameconst_shlnuw_combined := by
  unfold positive_sameconst_shlnuw_before positive_sameconst_shlnuw_combined
  simp_alive_peephole
  sorry
def positive_biggerShl_shlnuw_combined := [llvmfunc|
  llvm.func @positive_biggerShl_shlnuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.shl %arg0, %0 overflow<nsw, nuw>  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_positive_biggerShl_shlnuw   : positive_biggerShl_shlnuw_before  ⊑  positive_biggerShl_shlnuw_combined := by
  unfold positive_biggerShl_shlnuw_before positive_biggerShl_shlnuw_combined
  simp_alive_peephole
  sorry
def positive_biggerLshr_shlnuw_combined := [llvmfunc|
  llvm.func @positive_biggerLshr_shlnuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_positive_biggerLshr_shlnuw   : positive_biggerLshr_shlnuw_before  ⊑  positive_biggerLshr_shlnuw_combined := by
  unfold positive_biggerLshr_shlnuw_before positive_biggerLshr_shlnuw_combined
  simp_alive_peephole
  sorry
def positive_biggerLshr_shlnuw_lshrexact_combined := [llvmfunc|
  llvm.func @positive_biggerLshr_shlnuw_lshrexact(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_positive_biggerLshr_shlnuw_lshrexact   : positive_biggerLshr_shlnuw_lshrexact_before  ⊑  positive_biggerLshr_shlnuw_lshrexact_combined := by
  unfold positive_biggerLshr_shlnuw_lshrexact_before positive_biggerLshr_shlnuw_lshrexact_combined
  simp_alive_peephole
  sorry
def positive_samevar_vec_combined := [llvmfunc|
  llvm.func @positive_samevar_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.lshr %0, %arg1  : vector<2xi32>
    %2 = llvm.and %1, %arg0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_positive_samevar_vec   : positive_samevar_vec_before  ⊑  positive_samevar_vec_combined := by
  unfold positive_samevar_vec_before positive_samevar_vec_combined
  simp_alive_peephole
  sorry
def positive_sameconst_vec_combined := [llvmfunc|
  llvm.func @positive_sameconst_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<134217727> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.and %arg0, %0  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_positive_sameconst_vec   : positive_sameconst_vec_before  ⊑  positive_sameconst_vec_combined := by
  unfold positive_sameconst_vec_before positive_sameconst_vec_combined
  simp_alive_peephole
  sorry
def positive_sameconst_vec_undef0_combined := [llvmfunc|
  llvm.func @positive_sameconst_vec_undef0(%arg0: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(dense<5> : vector<3xi32>) : vector<3xi32>
    %10 = llvm.shl %arg0, %8  : vector<3xi32>
    %11 = llvm.lshr %10, %9  : vector<3xi32>
    llvm.return %11 : vector<3xi32>
  }]

theorem inst_combine_positive_sameconst_vec_undef0   : positive_sameconst_vec_undef0_before  ⊑  positive_sameconst_vec_undef0_combined := by
  unfold positive_sameconst_vec_undef0_before positive_sameconst_vec_undef0_combined
  simp_alive_peephole
  sorry
def positive_sameconst_vec_undef1_combined := [llvmfunc|
  llvm.func @positive_sameconst_vec_undef1(%arg0: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(dense<5> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.undef : i32
    %3 = llvm.mlir.undef : vector<3xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<3xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<3xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<3xi32>
    %10 = llvm.shl %arg0, %0  : vector<3xi32>
    %11 = llvm.lshr %10, %9  : vector<3xi32>
    llvm.return %11 : vector<3xi32>
  }]

theorem inst_combine_positive_sameconst_vec_undef1   : positive_sameconst_vec_undef1_before  ⊑  positive_sameconst_vec_undef1_combined := by
  unfold positive_sameconst_vec_undef1_before positive_sameconst_vec_undef1_combined
  simp_alive_peephole
  sorry
def positive_sameconst_vec_undef2_combined := [llvmfunc|
  llvm.func @positive_sameconst_vec_undef2(%arg0: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(134217727 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.and %arg0, %8  : vector<3xi32>
    llvm.return %9 : vector<3xi32>
  }]

theorem inst_combine_positive_sameconst_vec_undef2   : positive_sameconst_vec_undef2_before  ⊑  positive_sameconst_vec_undef2_combined := by
  unfold positive_sameconst_vec_undef2_before positive_sameconst_vec_undef2_combined
  simp_alive_peephole
  sorry
def positive_biggerShl_vec_combined := [llvmfunc|
  llvm.func @positive_biggerShl_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<134217696> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.shl %arg0, %0  : vector<2xi32>
    %3 = llvm.and %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_positive_biggerShl_vec   : positive_biggerShl_vec_before  ⊑  positive_biggerShl_vec_combined := by
  unfold positive_biggerShl_vec_before positive_biggerShl_vec_combined
  simp_alive_peephole
  sorry
def positive_biggerShl_vec_undef0_combined := [llvmfunc|
  llvm.func @positive_biggerShl_vec_undef0(%arg0: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(dense<5> : vector<3xi32>) : vector<3xi32>
    %10 = llvm.shl %arg0, %8  : vector<3xi32>
    %11 = llvm.lshr %10, %9  : vector<3xi32>
    llvm.return %11 : vector<3xi32>
  }]

theorem inst_combine_positive_biggerShl_vec_undef0   : positive_biggerShl_vec_undef0_before  ⊑  positive_biggerShl_vec_undef0_combined := by
  unfold positive_biggerShl_vec_undef0_before positive_biggerShl_vec_undef0_combined
  simp_alive_peephole
  sorry
def positive_biggerShl_vec_undef1_combined := [llvmfunc|
  llvm.func @positive_biggerShl_vec_undef1(%arg0: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(dense<10> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.undef : i32
    %3 = llvm.mlir.undef : vector<3xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<3xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<3xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<3xi32>
    %10 = llvm.shl %arg0, %0  : vector<3xi32>
    %11 = llvm.lshr %10, %9  : vector<3xi32>
    llvm.return %11 : vector<3xi32>
  }]

theorem inst_combine_positive_biggerShl_vec_undef1   : positive_biggerShl_vec_undef1_before  ⊑  positive_biggerShl_vec_undef1_combined := by
  unfold positive_biggerShl_vec_undef1_before positive_biggerShl_vec_undef1_combined
  simp_alive_peephole
  sorry
def positive_biggerShl_vec_undef2_combined := [llvmfunc|
  llvm.func @positive_biggerShl_vec_undef2(%arg0: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(5 : i32) : i32
    %10 = llvm.mlir.undef : vector<3xi32>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<3xi32>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %1, %12[%13 : i32] : vector<3xi32>
    %15 = llvm.mlir.constant(2 : i32) : i32
    %16 = llvm.insertelement %9, %14[%15 : i32] : vector<3xi32>
    %17 = llvm.shl %arg0, %8  : vector<3xi32>
    %18 = llvm.lshr %17, %16  : vector<3xi32>
    llvm.return %18 : vector<3xi32>
  }]

theorem inst_combine_positive_biggerShl_vec_undef2   : positive_biggerShl_vec_undef2_before  ⊑  positive_biggerShl_vec_undef2_combined := by
  unfold positive_biggerShl_vec_undef2_before positive_biggerShl_vec_undef2_combined
  simp_alive_peephole
  sorry
def positive_biggerLshr_vec_combined := [llvmfunc|
  llvm.func @positive_biggerLshr_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<4194303> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.lshr %arg0, %0  : vector<2xi32>
    %3 = llvm.and %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_positive_biggerLshr_vec   : positive_biggerLshr_vec_before  ⊑  positive_biggerLshr_vec_combined := by
  unfold positive_biggerLshr_vec_before positive_biggerLshr_vec_combined
  simp_alive_peephole
  sorry
def positive_biggerLshr_vec_undef0_combined := [llvmfunc|
  llvm.func @positive_biggerLshr_vec_undef0(%arg0: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(dense<10> : vector<3xi32>) : vector<3xi32>
    %10 = llvm.shl %arg0, %8  : vector<3xi32>
    %11 = llvm.lshr %10, %9  : vector<3xi32>
    llvm.return %11 : vector<3xi32>
  }]

theorem inst_combine_positive_biggerLshr_vec_undef0   : positive_biggerLshr_vec_undef0_before  ⊑  positive_biggerLshr_vec_undef0_combined := by
  unfold positive_biggerLshr_vec_undef0_before positive_biggerLshr_vec_undef0_combined
  simp_alive_peephole
  sorry
def positive_biggerLshr_vec_undef1_combined := [llvmfunc|
  llvm.func @positive_biggerLshr_vec_undef1(%arg0: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(dense<5> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.mlir.undef : i32
    %3 = llvm.mlir.undef : vector<3xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<3xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<3xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<3xi32>
    %10 = llvm.shl %arg0, %0  : vector<3xi32>
    %11 = llvm.lshr %10, %9  : vector<3xi32>
    llvm.return %11 : vector<3xi32>
  }]

theorem inst_combine_positive_biggerLshr_vec_undef1   : positive_biggerLshr_vec_undef1_before  ⊑  positive_biggerLshr_vec_undef1_combined := by
  unfold positive_biggerLshr_vec_undef1_before positive_biggerLshr_vec_undef1_combined
  simp_alive_peephole
  sorry
def positive_biggerLshr_vec_undef2_combined := [llvmfunc|
  llvm.func @positive_biggerLshr_vec_undef2(%arg0: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(10 : i32) : i32
    %10 = llvm.mlir.undef : vector<3xi32>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<3xi32>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %1, %12[%13 : i32] : vector<3xi32>
    %15 = llvm.mlir.constant(2 : i32) : i32
    %16 = llvm.insertelement %9, %14[%15 : i32] : vector<3xi32>
    %17 = llvm.shl %arg0, %8  : vector<3xi32>
    %18 = llvm.lshr %17, %16  : vector<3xi32>
    llvm.return %18 : vector<3xi32>
  }]

theorem inst_combine_positive_biggerLshr_vec_undef2   : positive_biggerLshr_vec_undef2_before  ⊑  positive_biggerLshr_vec_undef2_combined := by
  unfold positive_biggerLshr_vec_undef2_before positive_biggerLshr_vec_undef2_combined
  simp_alive_peephole
  sorry
def positive_sameconst_multiuse_combined := [llvmfunc|
  llvm.func @positive_sameconst_multiuse(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(134217727 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.and %arg0, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_positive_sameconst_multiuse   : positive_sameconst_multiuse_before  ⊑  positive_sameconst_multiuse_combined := by
  unfold positive_sameconst_multiuse_before positive_sameconst_multiuse_combined
  simp_alive_peephole
  sorry
def positive_biggerShl_shlnuw_multiuse_combined := [llvmfunc|
  llvm.func @positive_biggerShl_shlnuw_multiuse(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.shl %arg0, %0 overflow<nuw>  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.shl %arg0, %1 overflow<nsw, nuw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_positive_biggerShl_shlnuw_multiuse   : positive_biggerShl_shlnuw_multiuse_before  ⊑  positive_biggerShl_shlnuw_multiuse_combined := by
  unfold positive_biggerShl_shlnuw_multiuse_before positive_biggerShl_shlnuw_multiuse_combined
  simp_alive_peephole
  sorry
def positive_biggerLshr_shlnuw_multiuse_combined := [llvmfunc|
  llvm.func @positive_biggerLshr_shlnuw_multiuse(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.shl %arg0, %0 overflow<nuw>  : i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.lshr %arg0, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_positive_biggerLshr_shlnuw_multiuse   : positive_biggerLshr_shlnuw_multiuse_before  ⊑  positive_biggerLshr_shlnuw_multiuse_combined := by
  unfold positive_biggerLshr_shlnuw_multiuse_before positive_biggerLshr_shlnuw_multiuse_combined
  simp_alive_peephole
  sorry
def positive_biggerShl_multiuse_extrainstr_combined := [llvmfunc|
  llvm.func @positive_biggerShl_multiuse_extrainstr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_positive_biggerShl_multiuse_extrainstr   : positive_biggerShl_multiuse_extrainstr_before  ⊑  positive_biggerShl_multiuse_extrainstr_combined := by
  unfold positive_biggerShl_multiuse_extrainstr_before positive_biggerShl_multiuse_extrainstr_combined
  simp_alive_peephole
  sorry
def positive_biggerLshr_multiuse_extrainstr_combined := [llvmfunc|
  llvm.func @positive_biggerLshr_multiuse_extrainstr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_positive_biggerLshr_multiuse_extrainstr   : positive_biggerLshr_multiuse_extrainstr_before  ⊑  positive_biggerLshr_multiuse_extrainstr_combined := by
  unfold positive_biggerLshr_multiuse_extrainstr_before positive_biggerLshr_multiuse_extrainstr_combined
  simp_alive_peephole
  sorry
def positive_biggerShl_vec_nonsplat_combined := [llvmfunc|
  llvm.func @positive_biggerShl_vec_nonsplat(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[5, 10]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.shl %arg0, %0  : vector<2xi32>
    %3 = llvm.lshr %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_positive_biggerShl_vec_nonsplat   : positive_biggerShl_vec_nonsplat_before  ⊑  positive_biggerShl_vec_nonsplat_combined := by
  unfold positive_biggerShl_vec_nonsplat_before positive_biggerShl_vec_nonsplat_combined
  simp_alive_peephole
  sorry
def positive_biggerLshl_vec_nonsplat_combined := [llvmfunc|
  llvm.func @positive_biggerLshl_vec_nonsplat(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[5, 10]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<5> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.shl %arg0, %0  : vector<2xi32>
    %3 = llvm.lshr %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_positive_biggerLshl_vec_nonsplat   : positive_biggerLshl_vec_nonsplat_before  ⊑  positive_biggerLshl_vec_nonsplat_combined := by
  unfold positive_biggerLshl_vec_nonsplat_before positive_biggerLshl_vec_nonsplat_combined
  simp_alive_peephole
  sorry
def negative_twovars_combined := [llvmfunc|
  llvm.func @negative_twovars(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1  : i32
    %1 = llvm.lshr %0, %arg2  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_negative_twovars   : negative_twovars_before  ⊑  negative_twovars_combined := by
  unfold negative_twovars_before negative_twovars_combined
  simp_alive_peephole
  sorry
def negative_oneuse_combined := [llvmfunc|
  llvm.func @negative_oneuse(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1  : i32
    llvm.call @use32(%0) : (i32) -> ()
    %1 = llvm.lshr %0, %arg1  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_negative_oneuse   : negative_oneuse_before  ⊑  negative_oneuse_combined := by
  unfold negative_oneuse_before negative_oneuse_combined
  simp_alive_peephole
  sorry
