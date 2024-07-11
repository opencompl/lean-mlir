import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  canonicalize-ashr-shl-to-masking
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def positive_samevar_before := [llvmfunc|
  llvm.func @positive_samevar(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.ashr %arg0, %arg1  : i8
    %1 = llvm.shl %0, %arg1  : i8
    llvm.return %1 : i8
  }]

def positive_sameconst_before := [llvmfunc|
  llvm.func @positive_sameconst(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    %2 = llvm.shl %1, %0  : i8
    llvm.return %2 : i8
  }]

def positive_biggerashr_before := [llvmfunc|
  llvm.func @positive_biggerashr(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.shl %2, %1  : i8
    llvm.return %3 : i8
  }]

def positive_biggershl_before := [llvmfunc|
  llvm.func @positive_biggershl(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.shl %2, %1  : i8
    llvm.return %3 : i8
  }]

def positive_samevar_shlnuw_before := [llvmfunc|
  llvm.func @positive_samevar_shlnuw(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.ashr %arg0, %arg1  : i8
    %1 = llvm.shl %0, %arg1 overflow<nuw>  : i8
    llvm.return %1 : i8
  }]

def positive_sameconst_shlnuw_before := [llvmfunc|
  llvm.func @positive_sameconst_shlnuw(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    %2 = llvm.shl %1, %0 overflow<nuw>  : i8
    llvm.return %2 : i8
  }]

def positive_biggerashr_shlnuw_before := [llvmfunc|
  llvm.func @positive_biggerashr_shlnuw(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.shl %2, %1 overflow<nuw>  : i8
    llvm.return %3 : i8
  }]

def positive_biggershl_shlnuw_before := [llvmfunc|
  llvm.func @positive_biggershl_shlnuw(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.shl %2, %1 overflow<nuw>  : i8
    llvm.return %3 : i8
  }]

def positive_samevar_shlnsw_before := [llvmfunc|
  llvm.func @positive_samevar_shlnsw(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.ashr %arg0, %arg1  : i8
    %1 = llvm.shl %0, %arg1 overflow<nsw>  : i8
    llvm.return %1 : i8
  }]

def positive_sameconst_shlnsw_before := [llvmfunc|
  llvm.func @positive_sameconst_shlnsw(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    %2 = llvm.shl %1, %0 overflow<nsw>  : i8
    llvm.return %2 : i8
  }]

def positive_biggerashr_shlnsw_before := [llvmfunc|
  llvm.func @positive_biggerashr_shlnsw(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.shl %2, %1 overflow<nsw>  : i8
    llvm.return %3 : i8
  }]

def positive_biggershl_shlnsw_before := [llvmfunc|
  llvm.func @positive_biggershl_shlnsw(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.shl %2, %1 overflow<nsw>  : i8
    llvm.return %3 : i8
  }]

def positive_samevar_shlnuwnsw_before := [llvmfunc|
  llvm.func @positive_samevar_shlnuwnsw(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.ashr %arg0, %arg1  : i8
    %1 = llvm.shl %0, %arg1 overflow<nsw, nuw>  : i8
    llvm.return %1 : i8
  }]

def positive_sameconst_shlnuwnsw_before := [llvmfunc|
  llvm.func @positive_sameconst_shlnuwnsw(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    %2 = llvm.shl %1, %0 overflow<nsw, nuw>  : i8
    llvm.return %2 : i8
  }]

def positive_biggerashr_shlnuwnsw_before := [llvmfunc|
  llvm.func @positive_biggerashr_shlnuwnsw(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.shl %2, %1 overflow<nsw, nuw>  : i8
    llvm.return %3 : i8
  }]

def positive_biggershl_shlnuwnsw_before := [llvmfunc|
  llvm.func @positive_biggershl_shlnuwnsw(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.shl %2, %1 overflow<nsw, nuw>  : i8
    llvm.return %3 : i8
  }]

def positive_samevar_ashrexact_before := [llvmfunc|
  llvm.func @positive_samevar_ashrexact(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.ashr %arg0, %arg1  : i8
    %1 = llvm.shl %0, %arg1  : i8
    llvm.return %1 : i8
  }]

def positive_sameconst_ashrexact_before := [llvmfunc|
  llvm.func @positive_sameconst_ashrexact(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    %2 = llvm.shl %1, %0  : i8
    llvm.return %2 : i8
  }]

def positive_biggerashr_ashrexact_before := [llvmfunc|
  llvm.func @positive_biggerashr_ashrexact(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.shl %2, %1  : i8
    llvm.return %3 : i8
  }]

def positive_biggershl_ashrexact_before := [llvmfunc|
  llvm.func @positive_biggershl_ashrexact(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.shl %2, %1  : i8
    llvm.return %3 : i8
  }]

def positive_samevar_shlnsw_ashrexact_before := [llvmfunc|
  llvm.func @positive_samevar_shlnsw_ashrexact(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.ashr %arg0, %arg1  : i8
    %1 = llvm.shl %0, %arg1 overflow<nsw>  : i8
    llvm.return %1 : i8
  }]

def positive_sameconst_shlnsw_ashrexact_before := [llvmfunc|
  llvm.func @positive_sameconst_shlnsw_ashrexact(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    %2 = llvm.shl %1, %0 overflow<nsw>  : i8
    llvm.return %2 : i8
  }]

def positive_biggerashr_shlnsw_ashrexact_before := [llvmfunc|
  llvm.func @positive_biggerashr_shlnsw_ashrexact(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.shl %2, %1 overflow<nsw>  : i8
    llvm.return %3 : i8
  }]

def positive_biggershl_shlnsw_ashrexact_before := [llvmfunc|
  llvm.func @positive_biggershl_shlnsw_ashrexact(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.shl %2, %1 overflow<nsw>  : i8
    llvm.return %3 : i8
  }]

def positive_samevar_shlnuw_ashrexact_before := [llvmfunc|
  llvm.func @positive_samevar_shlnuw_ashrexact(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.ashr %arg0, %arg1  : i8
    %1 = llvm.shl %0, %arg1 overflow<nuw>  : i8
    llvm.return %1 : i8
  }]

def positive_sameconst_shlnuw_ashrexact_before := [llvmfunc|
  llvm.func @positive_sameconst_shlnuw_ashrexact(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    %2 = llvm.shl %1, %0 overflow<nuw>  : i8
    llvm.return %2 : i8
  }]

def positive_biggerashr_shlnuw_ashrexact_before := [llvmfunc|
  llvm.func @positive_biggerashr_shlnuw_ashrexact(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.shl %2, %1 overflow<nuw>  : i8
    llvm.return %3 : i8
  }]

def positive_biggershl_shlnuw_ashrexact_before := [llvmfunc|
  llvm.func @positive_biggershl_shlnuw_ashrexact(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.shl %2, %1 overflow<nuw>  : i8
    llvm.return %3 : i8
  }]

def positive_samevar_shlnuwnsw_ashrexact_before := [llvmfunc|
  llvm.func @positive_samevar_shlnuwnsw_ashrexact(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.ashr %arg0, %arg1  : i8
    %1 = llvm.shl %0, %arg1 overflow<nsw, nuw>  : i8
    llvm.return %1 : i8
  }]

def positive_sameconst_shlnuwnsw_ashrexact_before := [llvmfunc|
  llvm.func @positive_sameconst_shlnuwnsw_ashrexact(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    %2 = llvm.shl %1, %0 overflow<nsw, nuw>  : i8
    llvm.return %2 : i8
  }]

def positive_biggerashr_shlnuwnsw_ashrexact_before := [llvmfunc|
  llvm.func @positive_biggerashr_shlnuwnsw_ashrexact(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.shl %2, %1 overflow<nsw, nuw>  : i8
    llvm.return %3 : i8
  }]

def positive_biggershl_shlnuwnsw_ashrexact_before := [llvmfunc|
  llvm.func @positive_biggershl_shlnuwnsw_ashrexact(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.shl %2, %1 overflow<nsw, nuw>  : i8
    llvm.return %3 : i8
  }]

def positive_samevar_vec_before := [llvmfunc|
  llvm.func @positive_samevar_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.ashr %arg0, %arg1  : vector<2xi8>
    %1 = llvm.shl %0, %arg1  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

def positive_sameconst_vec_before := [llvmfunc|
  llvm.func @positive_sameconst_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.ashr %arg0, %0  : vector<2xi8>
    %2 = llvm.shl %1, %0  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

def positive_sameconst_vec_undef0_before := [llvmfunc|
  llvm.func @positive_sameconst_vec_undef0(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.undef : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.mlir.constant(dense<3> : vector<3xi8>) : vector<3xi8>
    %10 = llvm.ashr %arg0, %8  : vector<3xi8>
    %11 = llvm.shl %10, %9  : vector<3xi8>
    llvm.return %11 : vector<3xi8>
  }]

def positive_sameconst_vec_undef1_before := [llvmfunc|
  llvm.func @positive_sameconst_vec_undef1(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<3> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.mlir.undef : i8
    %3 = llvm.mlir.undef : vector<3xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<3xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<3xi8>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<3xi8>
    %10 = llvm.ashr %arg0, %0  : vector<3xi8>
    %11 = llvm.shl %10, %9  : vector<3xi8>
    llvm.return %11 : vector<3xi8>
  }]

def positive_sameconst_vec_undef2_before := [llvmfunc|
  llvm.func @positive_sameconst_vec_undef2(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.undef : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.ashr %arg0, %8  : vector<3xi8>
    %10 = llvm.shl %9, %8  : vector<3xi8>
    llvm.return %10 : vector<3xi8>
  }]

def positive_biggerashr_vec_before := [llvmfunc|
  llvm.func @positive_biggerashr_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<6> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.ashr %arg0, %0  : vector<2xi8>
    %3 = llvm.shl %2, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def positive_biggerashr_vec_undef0_before := [llvmfunc|
  llvm.func @positive_biggerashr_vec_undef0(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.undef : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.mlir.constant(dense<3> : vector<3xi8>) : vector<3xi8>
    %10 = llvm.ashr %arg0, %8  : vector<3xi8>
    %11 = llvm.shl %10, %9  : vector<3xi8>
    llvm.return %11 : vector<3xi8>
  }]

def positive_biggerashr_vec_undef1_before := [llvmfunc|
  llvm.func @positive_biggerashr_vec_undef1(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<6> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.mlir.undef : i8
    %3 = llvm.mlir.undef : vector<3xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<3xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<3xi8>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<3xi8>
    %10 = llvm.ashr %arg0, %0  : vector<3xi8>
    %11 = llvm.shl %10, %9  : vector<3xi8>
    llvm.return %11 : vector<3xi8>
  }]

def positive_biggerashr_vec_undef2_before := [llvmfunc|
  llvm.func @positive_biggerashr_vec_undef2(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.undef : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.mlir.constant(3 : i8) : i8
    %10 = llvm.mlir.undef : vector<3xi8>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<3xi8>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %1, %12[%13 : i32] : vector<3xi8>
    %15 = llvm.mlir.constant(2 : i32) : i32
    %16 = llvm.insertelement %9, %14[%15 : i32] : vector<3xi8>
    %17 = llvm.ashr %arg0, %8  : vector<3xi8>
    %18 = llvm.shl %17, %16  : vector<3xi8>
    llvm.return %18 : vector<3xi8>
  }]

def positive_biggershl_vec_before := [llvmfunc|
  llvm.func @positive_biggershl_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<6> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.ashr %arg0, %0  : vector<2xi8>
    %3 = llvm.shl %2, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def positive_biggershl_vec_undef0_before := [llvmfunc|
  llvm.func @positive_biggershl_vec_undef0(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.undef : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.mlir.constant(dense<6> : vector<3xi8>) : vector<3xi8>
    %10 = llvm.ashr %arg0, %8  : vector<3xi8>
    %11 = llvm.shl %10, %9  : vector<3xi8>
    llvm.return %11 : vector<3xi8>
  }]

def positive_biggershl_vec_undef1_before := [llvmfunc|
  llvm.func @positive_biggershl_vec_undef1(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<3> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.mlir.undef : i8
    %3 = llvm.mlir.undef : vector<3xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<3xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<3xi8>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<3xi8>
    %10 = llvm.ashr %arg0, %0  : vector<3xi8>
    %11 = llvm.shl %10, %9  : vector<3xi8>
    llvm.return %11 : vector<3xi8>
  }]

def positive_biggershl_vec_undef2_before := [llvmfunc|
  llvm.func @positive_biggershl_vec_undef2(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.undef : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.mlir.constant(6 : i8) : i8
    %10 = llvm.mlir.undef : vector<3xi8>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<3xi8>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %1, %12[%13 : i32] : vector<3xi8>
    %15 = llvm.mlir.constant(2 : i32) : i32
    %16 = llvm.insertelement %9, %14[%15 : i32] : vector<3xi8>
    %17 = llvm.ashr %arg0, %8  : vector<3xi8>
    %18 = llvm.shl %17, %16  : vector<3xi8>
    llvm.return %18 : vector<3xi8>
  }]

def positive_sameconst_multiuse_before := [llvmfunc|
  llvm.func @positive_sameconst_multiuse(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    llvm.call @use32(%1) : (i8) -> ()
    %2 = llvm.shl %1, %0  : i8
    llvm.return %2 : i8
  }]

def positive_biggerashr_multiuse_before := [llvmfunc|
  llvm.func @positive_biggerashr_multiuse(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    llvm.call @use32(%2) : (i8) -> ()
    %3 = llvm.shl %2, %1  : i8
    llvm.return %3 : i8
  }]

def positive_biggershl_multiuse_before := [llvmfunc|
  llvm.func @positive_biggershl_multiuse(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    llvm.call @use32(%2) : (i8) -> ()
    %3 = llvm.shl %2, %1  : i8
    llvm.return %3 : i8
  }]

def positive_biggerashr_vec_nonsplat_before := [llvmfunc|
  llvm.func @positive_biggerashr_vec_nonsplat(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[3, 6]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.ashr %arg0, %0  : vector<2xi8>
    %3 = llvm.shl %2, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def positive_biggerLashr_vec_nonsplat_before := [llvmfunc|
  llvm.func @positive_biggerLashr_vec_nonsplat(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[3, 6]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.ashr %arg0, %0  : vector<2xi8>
    %3 = llvm.shl %2, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def negative_twovars_before := [llvmfunc|
  llvm.func @negative_twovars(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.ashr %arg0, %arg1  : i8
    %1 = llvm.shl %0, %arg2  : i8
    llvm.return %1 : i8
  }]

def negative_oneuse_before := [llvmfunc|
  llvm.func @negative_oneuse(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.ashr %arg0, %arg1  : i8
    llvm.call @use32(%0) : (i8) -> ()
    %1 = llvm.shl %0, %arg1  : i8
    llvm.return %1 : i8
  }]

def positive_samevar_combined := [llvmfunc|
  llvm.func @positive_samevar(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.shl %0, %arg1 overflow<nsw>  : i8
    %2 = llvm.and %1, %arg0  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_positive_samevar   : positive_samevar_before  ⊑  positive_samevar_combined := by
  unfold positive_samevar_before positive_samevar_combined
  simp_alive_peephole
  sorry
def positive_sameconst_combined := [llvmfunc|
  llvm.func @positive_sameconst(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-8 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_positive_sameconst   : positive_sameconst_before  ⊑  positive_sameconst_combined := by
  unfold positive_sameconst_before positive_sameconst_combined
  simp_alive_peephole
  sorry
def positive_biggerashr_combined := [llvmfunc|
  llvm.func @positive_biggerashr(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(-8 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.and %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_positive_biggerashr   : positive_biggerashr_before  ⊑  positive_biggerashr_combined := by
  unfold positive_biggerashr_before positive_biggerashr_combined
  simp_alive_peephole
  sorry
def positive_biggershl_combined := [llvmfunc|
  llvm.func @positive_biggershl(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(-64 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.and %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_positive_biggershl   : positive_biggershl_before  ⊑  positive_biggershl_combined := by
  unfold positive_biggershl_before positive_biggershl_combined
  simp_alive_peephole
  sorry
def positive_samevar_shlnuw_combined := [llvmfunc|
  llvm.func @positive_samevar_shlnuw(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.shl %0, %arg1 overflow<nsw>  : i8
    %2 = llvm.and %1, %arg0  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_positive_samevar_shlnuw   : positive_samevar_shlnuw_before  ⊑  positive_samevar_shlnuw_combined := by
  unfold positive_samevar_shlnuw_before positive_samevar_shlnuw_combined
  simp_alive_peephole
  sorry
def positive_sameconst_shlnuw_combined := [llvmfunc|
  llvm.func @positive_sameconst_shlnuw(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-8 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_positive_sameconst_shlnuw   : positive_sameconst_shlnuw_before  ⊑  positive_sameconst_shlnuw_combined := by
  unfold positive_sameconst_shlnuw_before positive_sameconst_shlnuw_combined
  simp_alive_peephole
  sorry
def positive_biggerashr_shlnuw_combined := [llvmfunc|
  llvm.func @positive_biggerashr_shlnuw(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(-8 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.and %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_positive_biggerashr_shlnuw   : positive_biggerashr_shlnuw_before  ⊑  positive_biggerashr_shlnuw_combined := by
  unfold positive_biggerashr_shlnuw_before positive_biggerashr_shlnuw_combined
  simp_alive_peephole
  sorry
def positive_biggershl_shlnuw_combined := [llvmfunc|
  llvm.func @positive_biggershl_shlnuw(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(-64 : i8) : i8
    %2 = llvm.shl %arg0, %0 overflow<nuw>  : i8
    %3 = llvm.and %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_positive_biggershl_shlnuw   : positive_biggershl_shlnuw_before  ⊑  positive_biggershl_shlnuw_combined := by
  unfold positive_biggershl_shlnuw_before positive_biggershl_shlnuw_combined
  simp_alive_peephole
  sorry
def positive_samevar_shlnsw_combined := [llvmfunc|
  llvm.func @positive_samevar_shlnsw(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.shl %0, %arg1 overflow<nsw>  : i8
    %2 = llvm.and %1, %arg0  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_positive_samevar_shlnsw   : positive_samevar_shlnsw_before  ⊑  positive_samevar_shlnsw_combined := by
  unfold positive_samevar_shlnsw_before positive_samevar_shlnsw_combined
  simp_alive_peephole
  sorry
def positive_sameconst_shlnsw_combined := [llvmfunc|
  llvm.func @positive_sameconst_shlnsw(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-8 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_positive_sameconst_shlnsw   : positive_sameconst_shlnsw_before  ⊑  positive_sameconst_shlnsw_combined := by
  unfold positive_sameconst_shlnsw_before positive_sameconst_shlnsw_combined
  simp_alive_peephole
  sorry
def positive_biggerashr_shlnsw_combined := [llvmfunc|
  llvm.func @positive_biggerashr_shlnsw(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(-8 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.and %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_positive_biggerashr_shlnsw   : positive_biggerashr_shlnsw_before  ⊑  positive_biggerashr_shlnsw_combined := by
  unfold positive_biggerashr_shlnsw_before positive_biggerashr_shlnsw_combined
  simp_alive_peephole
  sorry
def positive_biggershl_shlnsw_combined := [llvmfunc|
  llvm.func @positive_biggershl_shlnsw(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(-64 : i8) : i8
    %2 = llvm.shl %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.and %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_positive_biggershl_shlnsw   : positive_biggershl_shlnsw_before  ⊑  positive_biggershl_shlnsw_combined := by
  unfold positive_biggershl_shlnsw_before positive_biggershl_shlnsw_combined
  simp_alive_peephole
  sorry
def positive_samevar_shlnuwnsw_combined := [llvmfunc|
  llvm.func @positive_samevar_shlnuwnsw(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.shl %0, %arg1 overflow<nsw>  : i8
    %2 = llvm.and %1, %arg0  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_positive_samevar_shlnuwnsw   : positive_samevar_shlnuwnsw_before  ⊑  positive_samevar_shlnuwnsw_combined := by
  unfold positive_samevar_shlnuwnsw_before positive_samevar_shlnuwnsw_combined
  simp_alive_peephole
  sorry
def positive_sameconst_shlnuwnsw_combined := [llvmfunc|
  llvm.func @positive_sameconst_shlnuwnsw(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-8 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_positive_sameconst_shlnuwnsw   : positive_sameconst_shlnuwnsw_before  ⊑  positive_sameconst_shlnuwnsw_combined := by
  unfold positive_sameconst_shlnuwnsw_before positive_sameconst_shlnuwnsw_combined
  simp_alive_peephole
  sorry
def positive_biggerashr_shlnuwnsw_combined := [llvmfunc|
  llvm.func @positive_biggerashr_shlnuwnsw(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(-8 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.and %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_positive_biggerashr_shlnuwnsw   : positive_biggerashr_shlnuwnsw_before  ⊑  positive_biggerashr_shlnuwnsw_combined := by
  unfold positive_biggerashr_shlnuwnsw_before positive_biggerashr_shlnuwnsw_combined
  simp_alive_peephole
  sorry
def positive_biggershl_shlnuwnsw_combined := [llvmfunc|
  llvm.func @positive_biggershl_shlnuwnsw(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(64 : i8) : i8
    %2 = llvm.shl %arg0, %0 overflow<nsw, nuw>  : i8
    %3 = llvm.and %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_positive_biggershl_shlnuwnsw   : positive_biggershl_shlnuwnsw_before  ⊑  positive_biggershl_shlnuwnsw_combined := by
  unfold positive_biggershl_shlnuwnsw_before positive_biggershl_shlnuwnsw_combined
  simp_alive_peephole
  sorry
def positive_samevar_ashrexact_combined := [llvmfunc|
  llvm.func @positive_samevar_ashrexact(%arg0: i8, %arg1: i8) -> i8 {
    llvm.return %arg0 : i8
  }]

theorem inst_combine_positive_samevar_ashrexact   : positive_samevar_ashrexact_before  ⊑  positive_samevar_ashrexact_combined := by
  unfold positive_samevar_ashrexact_before positive_samevar_ashrexact_combined
  simp_alive_peephole
  sorry
def positive_sameconst_ashrexact_combined := [llvmfunc|
  llvm.func @positive_sameconst_ashrexact(%arg0: i8) -> i8 {
    llvm.return %arg0 : i8
  }]

theorem inst_combine_positive_sameconst_ashrexact   : positive_sameconst_ashrexact_before  ⊑  positive_sameconst_ashrexact_combined := by
  unfold positive_sameconst_ashrexact_before positive_sameconst_ashrexact_combined
  simp_alive_peephole
  sorry
def positive_biggerashr_ashrexact_combined := [llvmfunc|
  llvm.func @positive_biggerashr_ashrexact(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_positive_biggerashr_ashrexact   : positive_biggerashr_ashrexact_before  ⊑  positive_biggerashr_ashrexact_combined := by
  unfold positive_biggerashr_ashrexact_before positive_biggerashr_ashrexact_combined
  simp_alive_peephole
  sorry
def positive_biggershl_ashrexact_combined := [llvmfunc|
  llvm.func @positive_biggershl_ashrexact(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.shl %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_positive_biggershl_ashrexact   : positive_biggershl_ashrexact_before  ⊑  positive_biggershl_ashrexact_combined := by
  unfold positive_biggershl_ashrexact_before positive_biggershl_ashrexact_combined
  simp_alive_peephole
  sorry
def positive_samevar_shlnsw_ashrexact_combined := [llvmfunc|
  llvm.func @positive_samevar_shlnsw_ashrexact(%arg0: i8, %arg1: i8) -> i8 {
    llvm.return %arg0 : i8
  }]

theorem inst_combine_positive_samevar_shlnsw_ashrexact   : positive_samevar_shlnsw_ashrexact_before  ⊑  positive_samevar_shlnsw_ashrexact_combined := by
  unfold positive_samevar_shlnsw_ashrexact_before positive_samevar_shlnsw_ashrexact_combined
  simp_alive_peephole
  sorry
def positive_sameconst_shlnsw_ashrexact_combined := [llvmfunc|
  llvm.func @positive_sameconst_shlnsw_ashrexact(%arg0: i8) -> i8 {
    llvm.return %arg0 : i8
  }]

theorem inst_combine_positive_sameconst_shlnsw_ashrexact   : positive_sameconst_shlnsw_ashrexact_before  ⊑  positive_sameconst_shlnsw_ashrexact_combined := by
  unfold positive_sameconst_shlnsw_ashrexact_before positive_sameconst_shlnsw_ashrexact_combined
  simp_alive_peephole
  sorry
def positive_biggerashr_shlnsw_ashrexact_combined := [llvmfunc|
  llvm.func @positive_biggerashr_shlnsw_ashrexact(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_positive_biggerashr_shlnsw_ashrexact   : positive_biggerashr_shlnsw_ashrexact_before  ⊑  positive_biggerashr_shlnsw_ashrexact_combined := by
  unfold positive_biggerashr_shlnsw_ashrexact_before positive_biggerashr_shlnsw_ashrexact_combined
  simp_alive_peephole
  sorry
def positive_biggershl_shlnsw_ashrexact_combined := [llvmfunc|
  llvm.func @positive_biggershl_shlnsw_ashrexact(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.shl %arg0, %0 overflow<nsw>  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_positive_biggershl_shlnsw_ashrexact   : positive_biggershl_shlnsw_ashrexact_before  ⊑  positive_biggershl_shlnsw_ashrexact_combined := by
  unfold positive_biggershl_shlnsw_ashrexact_before positive_biggershl_shlnsw_ashrexact_combined
  simp_alive_peephole
  sorry
def positive_samevar_shlnuw_ashrexact_combined := [llvmfunc|
  llvm.func @positive_samevar_shlnuw_ashrexact(%arg0: i8, %arg1: i8) -> i8 {
    llvm.return %arg0 : i8
  }]

theorem inst_combine_positive_samevar_shlnuw_ashrexact   : positive_samevar_shlnuw_ashrexact_before  ⊑  positive_samevar_shlnuw_ashrexact_combined := by
  unfold positive_samevar_shlnuw_ashrexact_before positive_samevar_shlnuw_ashrexact_combined
  simp_alive_peephole
  sorry
def positive_sameconst_shlnuw_ashrexact_combined := [llvmfunc|
  llvm.func @positive_sameconst_shlnuw_ashrexact(%arg0: i8) -> i8 {
    llvm.return %arg0 : i8
  }]

theorem inst_combine_positive_sameconst_shlnuw_ashrexact   : positive_sameconst_shlnuw_ashrexact_before  ⊑  positive_sameconst_shlnuw_ashrexact_combined := by
  unfold positive_sameconst_shlnuw_ashrexact_before positive_sameconst_shlnuw_ashrexact_combined
  simp_alive_peephole
  sorry
def positive_biggerashr_shlnuw_ashrexact_combined := [llvmfunc|
  llvm.func @positive_biggerashr_shlnuw_ashrexact(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_positive_biggerashr_shlnuw_ashrexact   : positive_biggerashr_shlnuw_ashrexact_before  ⊑  positive_biggerashr_shlnuw_ashrexact_combined := by
  unfold positive_biggerashr_shlnuw_ashrexact_before positive_biggerashr_shlnuw_ashrexact_combined
  simp_alive_peephole
  sorry
def positive_biggershl_shlnuw_ashrexact_combined := [llvmfunc|
  llvm.func @positive_biggershl_shlnuw_ashrexact(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.shl %arg0, %0 overflow<nuw>  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_positive_biggershl_shlnuw_ashrexact   : positive_biggershl_shlnuw_ashrexact_before  ⊑  positive_biggershl_shlnuw_ashrexact_combined := by
  unfold positive_biggershl_shlnuw_ashrexact_before positive_biggershl_shlnuw_ashrexact_combined
  simp_alive_peephole
  sorry
def positive_samevar_shlnuwnsw_ashrexact_combined := [llvmfunc|
  llvm.func @positive_samevar_shlnuwnsw_ashrexact(%arg0: i8, %arg1: i8) -> i8 {
    llvm.return %arg0 : i8
  }]

theorem inst_combine_positive_samevar_shlnuwnsw_ashrexact   : positive_samevar_shlnuwnsw_ashrexact_before  ⊑  positive_samevar_shlnuwnsw_ashrexact_combined := by
  unfold positive_samevar_shlnuwnsw_ashrexact_before positive_samevar_shlnuwnsw_ashrexact_combined
  simp_alive_peephole
  sorry
def positive_sameconst_shlnuwnsw_ashrexact_combined := [llvmfunc|
  llvm.func @positive_sameconst_shlnuwnsw_ashrexact(%arg0: i8) -> i8 {
    llvm.return %arg0 : i8
  }]

theorem inst_combine_positive_sameconst_shlnuwnsw_ashrexact   : positive_sameconst_shlnuwnsw_ashrexact_before  ⊑  positive_sameconst_shlnuwnsw_ashrexact_combined := by
  unfold positive_sameconst_shlnuwnsw_ashrexact_before positive_sameconst_shlnuwnsw_ashrexact_combined
  simp_alive_peephole
  sorry
def positive_biggerashr_shlnuwnsw_ashrexact_combined := [llvmfunc|
  llvm.func @positive_biggerashr_shlnuwnsw_ashrexact(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_positive_biggerashr_shlnuwnsw_ashrexact   : positive_biggerashr_shlnuwnsw_ashrexact_before  ⊑  positive_biggerashr_shlnuwnsw_ashrexact_combined := by
  unfold positive_biggerashr_shlnuwnsw_ashrexact_before positive_biggerashr_shlnuwnsw_ashrexact_combined
  simp_alive_peephole
  sorry
def positive_biggershl_shlnuwnsw_ashrexact_combined := [llvmfunc|
  llvm.func @positive_biggershl_shlnuwnsw_ashrexact(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.shl %arg0, %0 overflow<nsw, nuw>  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_positive_biggershl_shlnuwnsw_ashrexact   : positive_biggershl_shlnuwnsw_ashrexact_before  ⊑  positive_biggershl_shlnuwnsw_ashrexact_combined := by
  unfold positive_biggershl_shlnuwnsw_ashrexact_before positive_biggershl_shlnuwnsw_ashrexact_combined
  simp_alive_peephole
  sorry
def positive_samevar_vec_combined := [llvmfunc|
  llvm.func @positive_samevar_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.shl %0, %arg1 overflow<nsw>  : vector<2xi8>
    %2 = llvm.and %1, %arg0  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

theorem inst_combine_positive_samevar_vec   : positive_samevar_vec_before  ⊑  positive_samevar_vec_combined := by
  unfold positive_samevar_vec_before positive_samevar_vec_combined
  simp_alive_peephole
  sorry
def positive_sameconst_vec_combined := [llvmfunc|
  llvm.func @positive_sameconst_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-8> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.and %arg0, %0  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_positive_sameconst_vec   : positive_sameconst_vec_before  ⊑  positive_sameconst_vec_combined := by
  unfold positive_sameconst_vec_before positive_sameconst_vec_combined
  simp_alive_peephole
  sorry
def positive_sameconst_vec_undef0_combined := [llvmfunc|
  llvm.func @positive_sameconst_vec_undef0(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.undef : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.mlir.constant(dense<3> : vector<3xi8>) : vector<3xi8>
    %10 = llvm.ashr %arg0, %8  : vector<3xi8>
    %11 = llvm.shl %10, %9  : vector<3xi8>
    llvm.return %11 : vector<3xi8>
  }]

theorem inst_combine_positive_sameconst_vec_undef0   : positive_sameconst_vec_undef0_before  ⊑  positive_sameconst_vec_undef0_combined := by
  unfold positive_sameconst_vec_undef0_before positive_sameconst_vec_undef0_combined
  simp_alive_peephole
  sorry
def positive_sameconst_vec_undef1_combined := [llvmfunc|
  llvm.func @positive_sameconst_vec_undef1(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<3> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.mlir.undef : i8
    %3 = llvm.mlir.undef : vector<3xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<3xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<3xi8>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<3xi8>
    %10 = llvm.ashr %arg0, %0  : vector<3xi8>
    %11 = llvm.shl %10, %9  : vector<3xi8>
    llvm.return %11 : vector<3xi8>
  }]

theorem inst_combine_positive_sameconst_vec_undef1   : positive_sameconst_vec_undef1_before  ⊑  positive_sameconst_vec_undef1_combined := by
  unfold positive_sameconst_vec_undef1_before positive_sameconst_vec_undef1_combined
  simp_alive_peephole
  sorry
def positive_sameconst_vec_undef2_combined := [llvmfunc|
  llvm.func @positive_sameconst_vec_undef2(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(-8 : i8) : i8
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.and %arg0, %8  : vector<3xi8>
    llvm.return %9 : vector<3xi8>
  }]

theorem inst_combine_positive_sameconst_vec_undef2   : positive_sameconst_vec_undef2_before  ⊑  positive_sameconst_vec_undef2_combined := by
  unfold positive_sameconst_vec_undef2_before positive_sameconst_vec_undef2_combined
  simp_alive_peephole
  sorry
def positive_biggerashr_vec_combined := [llvmfunc|
  llvm.func @positive_biggerashr_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-8> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.ashr %arg0, %0  : vector<2xi8>
    %3 = llvm.and %2, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_positive_biggerashr_vec   : positive_biggerashr_vec_before  ⊑  positive_biggerashr_vec_combined := by
  unfold positive_biggerashr_vec_before positive_biggerashr_vec_combined
  simp_alive_peephole
  sorry
def positive_biggerashr_vec_undef0_combined := [llvmfunc|
  llvm.func @positive_biggerashr_vec_undef0(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.undef : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.mlir.constant(dense<3> : vector<3xi8>) : vector<3xi8>
    %10 = llvm.ashr %arg0, %8  : vector<3xi8>
    %11 = llvm.shl %10, %9  : vector<3xi8>
    llvm.return %11 : vector<3xi8>
  }]

theorem inst_combine_positive_biggerashr_vec_undef0   : positive_biggerashr_vec_undef0_before  ⊑  positive_biggerashr_vec_undef0_combined := by
  unfold positive_biggerashr_vec_undef0_before positive_biggerashr_vec_undef0_combined
  simp_alive_peephole
  sorry
def positive_biggerashr_vec_undef1_combined := [llvmfunc|
  llvm.func @positive_biggerashr_vec_undef1(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<6> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.mlir.undef : i8
    %3 = llvm.mlir.undef : vector<3xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<3xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<3xi8>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<3xi8>
    %10 = llvm.ashr %arg0, %0  : vector<3xi8>
    %11 = llvm.shl %10, %9  : vector<3xi8>
    llvm.return %11 : vector<3xi8>
  }]

theorem inst_combine_positive_biggerashr_vec_undef1   : positive_biggerashr_vec_undef1_before  ⊑  positive_biggerashr_vec_undef1_combined := by
  unfold positive_biggerashr_vec_undef1_before positive_biggerashr_vec_undef1_combined
  simp_alive_peephole
  sorry
def positive_biggerashr_vec_undef2_combined := [llvmfunc|
  llvm.func @positive_biggerashr_vec_undef2(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.undef : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.mlir.constant(3 : i8) : i8
    %10 = llvm.mlir.undef : vector<3xi8>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<3xi8>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %1, %12[%13 : i32] : vector<3xi8>
    %15 = llvm.mlir.constant(2 : i32) : i32
    %16 = llvm.insertelement %9, %14[%15 : i32] : vector<3xi8>
    %17 = llvm.ashr %arg0, %8  : vector<3xi8>
    %18 = llvm.shl %17, %16  : vector<3xi8>
    llvm.return %18 : vector<3xi8>
  }]

theorem inst_combine_positive_biggerashr_vec_undef2   : positive_biggerashr_vec_undef2_before  ⊑  positive_biggerashr_vec_undef2_combined := by
  unfold positive_biggerashr_vec_undef2_before positive_biggerashr_vec_undef2_combined
  simp_alive_peephole
  sorry
def positive_biggershl_vec_combined := [llvmfunc|
  llvm.func @positive_biggershl_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-64> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %arg0, %0  : vector<2xi8>
    %3 = llvm.and %2, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_positive_biggershl_vec   : positive_biggershl_vec_before  ⊑  positive_biggershl_vec_combined := by
  unfold positive_biggershl_vec_before positive_biggershl_vec_combined
  simp_alive_peephole
  sorry
def positive_biggershl_vec_undef0_combined := [llvmfunc|
  llvm.func @positive_biggershl_vec_undef0(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.undef : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.mlir.constant(dense<6> : vector<3xi8>) : vector<3xi8>
    %10 = llvm.ashr %arg0, %8  : vector<3xi8>
    %11 = llvm.shl %10, %9  : vector<3xi8>
    llvm.return %11 : vector<3xi8>
  }]

theorem inst_combine_positive_biggershl_vec_undef0   : positive_biggershl_vec_undef0_before  ⊑  positive_biggershl_vec_undef0_combined := by
  unfold positive_biggershl_vec_undef0_before positive_biggershl_vec_undef0_combined
  simp_alive_peephole
  sorry
def positive_biggershl_vec_undef1_combined := [llvmfunc|
  llvm.func @positive_biggershl_vec_undef1(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<3> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.mlir.undef : i8
    %3 = llvm.mlir.undef : vector<3xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<3xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<3xi8>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<3xi8>
    %10 = llvm.ashr %arg0, %0  : vector<3xi8>
    %11 = llvm.shl %10, %9  : vector<3xi8>
    llvm.return %11 : vector<3xi8>
  }]

theorem inst_combine_positive_biggershl_vec_undef1   : positive_biggershl_vec_undef1_before  ⊑  positive_biggershl_vec_undef1_combined := by
  unfold positive_biggershl_vec_undef1_before positive_biggershl_vec_undef1_combined
  simp_alive_peephole
  sorry
def positive_biggershl_vec_undef2_combined := [llvmfunc|
  llvm.func @positive_biggershl_vec_undef2(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.undef : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.mlir.constant(6 : i8) : i8
    %10 = llvm.mlir.undef : vector<3xi8>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<3xi8>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %1, %12[%13 : i32] : vector<3xi8>
    %15 = llvm.mlir.constant(2 : i32) : i32
    %16 = llvm.insertelement %9, %14[%15 : i32] : vector<3xi8>
    %17 = llvm.ashr %arg0, %8  : vector<3xi8>
    %18 = llvm.shl %17, %16  : vector<3xi8>
    llvm.return %18 : vector<3xi8>
  }]

theorem inst_combine_positive_biggershl_vec_undef2   : positive_biggershl_vec_undef2_before  ⊑  positive_biggershl_vec_undef2_combined := by
  unfold positive_biggershl_vec_undef2_before positive_biggershl_vec_undef2_combined
  simp_alive_peephole
  sorry
def positive_sameconst_multiuse_combined := [llvmfunc|
  llvm.func @positive_sameconst_multiuse(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(-8 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    llvm.call @use32(%2) : (i8) -> ()
    %3 = llvm.and %arg0, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_positive_sameconst_multiuse   : positive_sameconst_multiuse_before  ⊑  positive_sameconst_multiuse_combined := by
  unfold positive_sameconst_multiuse_before positive_sameconst_multiuse_combined
  simp_alive_peephole
  sorry
def positive_biggerashr_multiuse_combined := [llvmfunc|
  llvm.func @positive_biggerashr_multiuse(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    llvm.call @use32(%2) : (i8) -> ()
    %3 = llvm.shl %2, %1 overflow<nsw>  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_positive_biggerashr_multiuse   : positive_biggerashr_multiuse_before  ⊑  positive_biggerashr_multiuse_combined := by
  unfold positive_biggerashr_multiuse_before positive_biggerashr_multiuse_combined
  simp_alive_peephole
  sorry
def positive_biggershl_multiuse_combined := [llvmfunc|
  llvm.func @positive_biggershl_multiuse(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    llvm.call @use32(%2) : (i8) -> ()
    %3 = llvm.shl %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_positive_biggershl_multiuse   : positive_biggershl_multiuse_before  ⊑  positive_biggershl_multiuse_combined := by
  unfold positive_biggershl_multiuse_before positive_biggershl_multiuse_combined
  simp_alive_peephole
  sorry
def positive_biggerashr_vec_nonsplat_combined := [llvmfunc|
  llvm.func @positive_biggerashr_vec_nonsplat(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[3, 6]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.ashr %arg0, %0  : vector<2xi8>
    %3 = llvm.shl %2, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_positive_biggerashr_vec_nonsplat   : positive_biggerashr_vec_nonsplat_before  ⊑  positive_biggerashr_vec_nonsplat_combined := by
  unfold positive_biggerashr_vec_nonsplat_before positive_biggerashr_vec_nonsplat_combined
  simp_alive_peephole
  sorry
def positive_biggerLashr_vec_nonsplat_combined := [llvmfunc|
  llvm.func @positive_biggerLashr_vec_nonsplat(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[3, 6]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.ashr %arg0, %0  : vector<2xi8>
    %3 = llvm.shl %2, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_positive_biggerLashr_vec_nonsplat   : positive_biggerLashr_vec_nonsplat_before  ⊑  positive_biggerLashr_vec_nonsplat_combined := by
  unfold positive_biggerLashr_vec_nonsplat_before positive_biggerLashr_vec_nonsplat_combined
  simp_alive_peephole
  sorry
def negative_twovars_combined := [llvmfunc|
  llvm.func @negative_twovars(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.ashr %arg0, %arg1  : i8
    %1 = llvm.shl %0, %arg2  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_negative_twovars   : negative_twovars_before  ⊑  negative_twovars_combined := by
  unfold negative_twovars_before negative_twovars_combined
  simp_alive_peephole
  sorry
def negative_oneuse_combined := [llvmfunc|
  llvm.func @negative_oneuse(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.ashr %arg0, %arg1  : i8
    llvm.call @use32(%0) : (i8) -> ()
    %1 = llvm.shl %0, %arg1  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_negative_oneuse   : negative_oneuse_before  ⊑  negative_oneuse_combined := by
  unfold negative_oneuse_before negative_oneuse_combined
  simp_alive_peephole
  sorry
