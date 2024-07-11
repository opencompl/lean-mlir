import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  addsub-constant-folding
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def add_const_add_const_before := [llvmfunc|
  llvm.func @add_const_add_const(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.add %2, %1  : i32
    llvm.return %3 : i32
  }]

def add_const_add_const_extrause_before := [llvmfunc|
  llvm.func @add_const_add_const_extrause(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.add %2, %1  : i32
    llvm.return %3 : i32
  }]

def vec_add_const_add_const_before := [llvmfunc|
  llvm.func @vec_add_const_add_const(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.add %arg0, %0  : vector<4xi32>
    %3 = llvm.add %2, %1  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }]

def vec_add_const_add_const_extrause_before := [llvmfunc|
  llvm.func @vec_add_const_add_const_extrause(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.add %arg0, %0  : vector<4xi32>
    llvm.call @vec_use(%2) : (vector<4xi32>) -> ()
    %3 = llvm.add %2, %1  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }]

def vec_add_const_add_const_nonsplat_before := [llvmfunc|
  llvm.func @vec_add_const_add_const_nonsplat(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.constant(21 : i32) : i32
    %3 = llvm.mlir.undef : vector<4xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<4xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<4xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<4xi32>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %0, %9[%10 : i32] : vector<4xi32>
    %12 = llvm.mlir.constant(2 : i32) : i32
    %13 = llvm.mlir.constant(3 : i32) : i32
    %14 = llvm.mlir.undef : vector<4xi32>
    %15 = llvm.mlir.constant(0 : i32) : i32
    %16 = llvm.insertelement %12, %14[%15 : i32] : vector<4xi32>
    %17 = llvm.mlir.constant(1 : i32) : i32
    %18 = llvm.insertelement %13, %16[%17 : i32] : vector<4xi32>
    %19 = llvm.mlir.constant(2 : i32) : i32
    %20 = llvm.insertelement %1, %18[%19 : i32] : vector<4xi32>
    %21 = llvm.mlir.constant(3 : i32) : i32
    %22 = llvm.insertelement %12, %20[%21 : i32] : vector<4xi32>
    %23 = llvm.add %arg0, %11  : vector<4xi32>
    %24 = llvm.add %23, %22  : vector<4xi32>
    llvm.return %24 : vector<4xi32>
  }]

def add_const_sub_const_before := [llvmfunc|
  llvm.func @add_const_sub_const(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.sub %2, %1  : i32
    llvm.return %3 : i32
  }]

def add_const_sub_const_extrause_before := [llvmfunc|
  llvm.func @add_const_sub_const_extrause(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.sub %2, %1  : i32
    llvm.return %3 : i32
  }]

def vec_add_const_sub_const_before := [llvmfunc|
  llvm.func @vec_add_const_sub_const(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.add %arg0, %0  : vector<4xi32>
    %3 = llvm.sub %2, %1  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }]

def vec_add_const_sub_const_extrause_before := [llvmfunc|
  llvm.func @vec_add_const_sub_const_extrause(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.add %arg0, %0  : vector<4xi32>
    llvm.call @vec_use(%2) : (vector<4xi32>) -> ()
    %3 = llvm.sub %2, %1  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }]

def vec_add_const_sub_const_nonsplat_before := [llvmfunc|
  llvm.func @vec_add_const_sub_const_nonsplat(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.constant(21 : i32) : i32
    %3 = llvm.mlir.undef : vector<4xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<4xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<4xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<4xi32>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %0, %9[%10 : i32] : vector<4xi32>
    %12 = llvm.mlir.constant(2 : i32) : i32
    %13 = llvm.mlir.constant(3 : i32) : i32
    %14 = llvm.mlir.undef : vector<4xi32>
    %15 = llvm.mlir.constant(0 : i32) : i32
    %16 = llvm.insertelement %12, %14[%15 : i32] : vector<4xi32>
    %17 = llvm.mlir.constant(1 : i32) : i32
    %18 = llvm.insertelement %13, %16[%17 : i32] : vector<4xi32>
    %19 = llvm.mlir.constant(2 : i32) : i32
    %20 = llvm.insertelement %1, %18[%19 : i32] : vector<4xi32>
    %21 = llvm.mlir.constant(3 : i32) : i32
    %22 = llvm.insertelement %12, %20[%21 : i32] : vector<4xi32>
    %23 = llvm.add %arg0, %11  : vector<4xi32>
    %24 = llvm.sub %23, %22  : vector<4xi32>
    llvm.return %24 : vector<4xi32>
  }]

def add_const_const_sub_before := [llvmfunc|
  llvm.func @add_const_const_sub(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.sub %1, %2  : i32
    llvm.return %3 : i32
  }]

def add_nsw_const_const_sub_nsw_before := [llvmfunc|
  llvm.func @add_nsw_const_const_sub_nsw(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-127 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.sub %1, %2 overflow<nsw>  : i8
    llvm.return %3 : i8
  }]

def add_nsw_const_const_sub_before := [llvmfunc|
  llvm.func @add_nsw_const_const_sub(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-127 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.sub %1, %2  : i8
    llvm.return %3 : i8
  }]

def add_const_const_sub_nsw_before := [llvmfunc|
  llvm.func @add_const_const_sub_nsw(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-127 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.sub %1, %2 overflow<nsw>  : i8
    llvm.return %3 : i8
  }]

def add_nsw_const_const_sub_nsw_ov_before := [llvmfunc|
  llvm.func @add_nsw_const_const_sub_nsw_ov(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(-127 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.sub %1, %2 overflow<nsw>  : i8
    llvm.return %3 : i8
  }]

def add_nuw_const_const_sub_nuw_before := [llvmfunc|
  llvm.func @add_nuw_const_const_sub_nuw(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-127 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i8
    %3 = llvm.sub %1, %2 overflow<nuw>  : i8
    llvm.return %3 : i8
  }]

def add_nuw_const_const_sub_before := [llvmfunc|
  llvm.func @add_nuw_const_const_sub(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-127 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i8
    %3 = llvm.sub %1, %2  : i8
    llvm.return %3 : i8
  }]

def add_const_const_sub_nuw_before := [llvmfunc|
  llvm.func @add_const_const_sub_nuw(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-127 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.sub %1, %2 overflow<nuw>  : i8
    llvm.return %3 : i8
  }]

def non_splat_vec_add_nsw_const_const_sub_nsw_not_ov1_before := [llvmfunc|
  llvm.func @non_splat_vec_add_nsw_const_const_sub_nsw_not_ov1(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[2, 0]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[-125, -126]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0 overflow<nsw>  : vector<2xi8>
    %3 = llvm.sub %1, %2 overflow<nsw>  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def non_splat_vec_add_nsw_const_const_sub_nsw_not_ov2_before := [llvmfunc|
  llvm.func @non_splat_vec_add_nsw_const_const_sub_nsw_not_ov2(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[-125, -126]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0 overflow<nsw>  : vector<2xi8>
    %3 = llvm.sub %1, %2 overflow<nsw>  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def non_splat_vec_add_nsw_const_const_sub_nsw_not_ov3_before := [llvmfunc|
  llvm.func @non_splat_vec_add_nsw_const_const_sub_nsw_not_ov3(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[0, 1]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[-120, -126]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0 overflow<nsw>  : vector<2xi8>
    %3 = llvm.sub %1, %2 overflow<nsw>  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def non_splat_vec_add_nsw_const_const_sub_nsw_ov_before := [llvmfunc|
  llvm.func @non_splat_vec_add_nsw_const_const_sub_nsw_ov(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[-126, -127]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0 overflow<nsw>  : vector<2xi8>
    %3 = llvm.sub %1, %2 overflow<nsw>  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def add_const_const_sub_extrause_before := [llvmfunc|
  llvm.func @add_const_const_sub_extrause(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.sub %1, %2  : i32
    llvm.return %3 : i32
  }]

def vec_add_const_const_sub_before := [llvmfunc|
  llvm.func @vec_add_const_const_sub(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.add %arg0, %0  : vector<4xi32>
    %3 = llvm.sub %1, %2  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }]

def vec_add_const_const_sub_extrause_before := [llvmfunc|
  llvm.func @vec_add_const_const_sub_extrause(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.add %arg0, %0  : vector<4xi32>
    llvm.call @vec_use(%2) : (vector<4xi32>) -> ()
    %3 = llvm.sub %1, %2  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }]

def vec_add_const_const_sub_nonsplat_before := [llvmfunc|
  llvm.func @vec_add_const_const_sub_nonsplat(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.constant(21 : i32) : i32
    %3 = llvm.mlir.undef : vector<4xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<4xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<4xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<4xi32>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %0, %9[%10 : i32] : vector<4xi32>
    %12 = llvm.mlir.constant(2 : i32) : i32
    %13 = llvm.mlir.constant(3 : i32) : i32
    %14 = llvm.mlir.undef : vector<4xi32>
    %15 = llvm.mlir.constant(0 : i32) : i32
    %16 = llvm.insertelement %12, %14[%15 : i32] : vector<4xi32>
    %17 = llvm.mlir.constant(1 : i32) : i32
    %18 = llvm.insertelement %13, %16[%17 : i32] : vector<4xi32>
    %19 = llvm.mlir.constant(2 : i32) : i32
    %20 = llvm.insertelement %1, %18[%19 : i32] : vector<4xi32>
    %21 = llvm.mlir.constant(3 : i32) : i32
    %22 = llvm.insertelement %12, %20[%21 : i32] : vector<4xi32>
    %23 = llvm.add %arg0, %11  : vector<4xi32>
    %24 = llvm.sub %22, %23  : vector<4xi32>
    llvm.return %24 : vector<4xi32>
  }]

def sub_const_add_const_before := [llvmfunc|
  llvm.func @sub_const_add_const(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.sub %arg0, %0  : i32
    %3 = llvm.add %2, %1  : i32
    llvm.return %3 : i32
  }]

def sub_const_add_const_extrause_before := [llvmfunc|
  llvm.func @sub_const_add_const_extrause(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.sub %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.add %2, %1  : i32
    llvm.return %3 : i32
  }]

def vec_sub_const_add_const_before := [llvmfunc|
  llvm.func @vec_sub_const_add_const(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sub %arg0, %0  : vector<4xi32>
    %3 = llvm.add %2, %1  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }]

def vec_sub_const_add_const_extrause_before := [llvmfunc|
  llvm.func @vec_sub_const_add_const_extrause(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sub %arg0, %0  : vector<4xi32>
    llvm.call @vec_use(%2) : (vector<4xi32>) -> ()
    %3 = llvm.add %2, %1  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }]

def vec_sub_const_add_const_nonsplat_before := [llvmfunc|
  llvm.func @vec_sub_const_add_const_nonsplat(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.constant(21 : i32) : i32
    %3 = llvm.mlir.undef : vector<4xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<4xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<4xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<4xi32>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %0, %9[%10 : i32] : vector<4xi32>
    %12 = llvm.mlir.constant(2 : i32) : i32
    %13 = llvm.mlir.constant(3 : i32) : i32
    %14 = llvm.mlir.undef : vector<4xi32>
    %15 = llvm.mlir.constant(0 : i32) : i32
    %16 = llvm.insertelement %12, %14[%15 : i32] : vector<4xi32>
    %17 = llvm.mlir.constant(1 : i32) : i32
    %18 = llvm.insertelement %13, %16[%17 : i32] : vector<4xi32>
    %19 = llvm.mlir.constant(2 : i32) : i32
    %20 = llvm.insertelement %1, %18[%19 : i32] : vector<4xi32>
    %21 = llvm.mlir.constant(3 : i32) : i32
    %22 = llvm.insertelement %12, %20[%21 : i32] : vector<4xi32>
    %23 = llvm.sub %arg0, %11  : vector<4xi32>
    %24 = llvm.add %23, %22  : vector<4xi32>
    llvm.return %24 : vector<4xi32>
  }]

def sub_const_sub_const_before := [llvmfunc|
  llvm.func @sub_const_sub_const(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.sub %arg0, %0  : i32
    %3 = llvm.sub %2, %1  : i32
    llvm.return %3 : i32
  }]

def sub_const_sub_const_extrause_before := [llvmfunc|
  llvm.func @sub_const_sub_const_extrause(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.sub %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.sub %2, %1  : i32
    llvm.return %3 : i32
  }]

def vec_sub_const_sub_const_before := [llvmfunc|
  llvm.func @vec_sub_const_sub_const(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sub %arg0, %0  : vector<4xi32>
    %3 = llvm.sub %2, %1  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }]

def vec_sub_const_sub_const_extrause_before := [llvmfunc|
  llvm.func @vec_sub_const_sub_const_extrause(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sub %arg0, %0  : vector<4xi32>
    llvm.call @vec_use(%2) : (vector<4xi32>) -> ()
    %3 = llvm.sub %2, %1  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }]

def vec_sub_const_sub_const_nonsplat_before := [llvmfunc|
  llvm.func @vec_sub_const_sub_const_nonsplat(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.constant(21 : i32) : i32
    %3 = llvm.mlir.undef : vector<4xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<4xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<4xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<4xi32>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %0, %9[%10 : i32] : vector<4xi32>
    %12 = llvm.mlir.constant(2 : i32) : i32
    %13 = llvm.mlir.constant(3 : i32) : i32
    %14 = llvm.mlir.undef : vector<4xi32>
    %15 = llvm.mlir.constant(0 : i32) : i32
    %16 = llvm.insertelement %12, %14[%15 : i32] : vector<4xi32>
    %17 = llvm.mlir.constant(1 : i32) : i32
    %18 = llvm.insertelement %13, %16[%17 : i32] : vector<4xi32>
    %19 = llvm.mlir.constant(2 : i32) : i32
    %20 = llvm.insertelement %1, %18[%19 : i32] : vector<4xi32>
    %21 = llvm.mlir.constant(3 : i32) : i32
    %22 = llvm.insertelement %12, %20[%21 : i32] : vector<4xi32>
    %23 = llvm.sub %arg0, %11  : vector<4xi32>
    %24 = llvm.sub %23, %22  : vector<4xi32>
    llvm.return %24 : vector<4xi32>
  }]

def sub_const_const_sub_before := [llvmfunc|
  llvm.func @sub_const_const_sub(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.sub %arg0, %0  : i32
    %3 = llvm.sub %1, %2  : i32
    llvm.return %3 : i32
  }]

def sub_const_const_sub_extrause_before := [llvmfunc|
  llvm.func @sub_const_const_sub_extrause(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.sub %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.sub %1, %2  : i32
    llvm.return %3 : i32
  }]

def vec_sub_const_const_sub_before := [llvmfunc|
  llvm.func @vec_sub_const_const_sub(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sub %arg0, %0  : vector<4xi32>
    %3 = llvm.sub %1, %2  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }]

def vec_sub_const_const_sub_extrause_before := [llvmfunc|
  llvm.func @vec_sub_const_const_sub_extrause(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sub %arg0, %0  : vector<4xi32>
    llvm.call @vec_use(%2) : (vector<4xi32>) -> ()
    %3 = llvm.sub %1, %2  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }]

def vec_sub_const_const_sub_nonsplat_before := [llvmfunc|
  llvm.func @vec_sub_const_const_sub_nonsplat(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.constant(21 : i32) : i32
    %3 = llvm.mlir.undef : vector<4xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<4xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<4xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<4xi32>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %0, %9[%10 : i32] : vector<4xi32>
    %12 = llvm.mlir.constant(2 : i32) : i32
    %13 = llvm.mlir.constant(3 : i32) : i32
    %14 = llvm.mlir.undef : vector<4xi32>
    %15 = llvm.mlir.constant(0 : i32) : i32
    %16 = llvm.insertelement %12, %14[%15 : i32] : vector<4xi32>
    %17 = llvm.mlir.constant(1 : i32) : i32
    %18 = llvm.insertelement %13, %16[%17 : i32] : vector<4xi32>
    %19 = llvm.mlir.constant(2 : i32) : i32
    %20 = llvm.insertelement %1, %18[%19 : i32] : vector<4xi32>
    %21 = llvm.mlir.constant(3 : i32) : i32
    %22 = llvm.insertelement %12, %20[%21 : i32] : vector<4xi32>
    %23 = llvm.sub %arg0, %11  : vector<4xi32>
    %24 = llvm.sub %22, %23  : vector<4xi32>
    llvm.return %24 : vector<4xi32>
  }]

def const_sub_add_const_before := [llvmfunc|
  llvm.func @const_sub_add_const(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.add %2, %1  : i32
    llvm.return %3 : i32
  }]

def const_sub_add_const_extrause_before := [llvmfunc|
  llvm.func @const_sub_add_const_extrause(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.add %2, %1  : i32
    llvm.return %3 : i32
  }]

def vec_const_sub_add_const_before := [llvmfunc|
  llvm.func @vec_const_sub_add_const(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sub %0, %arg0  : vector<4xi32>
    %3 = llvm.add %2, %1  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }]

def vec_const_sub_add_const_extrause_before := [llvmfunc|
  llvm.func @vec_const_sub_add_const_extrause(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sub %0, %arg0  : vector<4xi32>
    llvm.call @vec_use(%2) : (vector<4xi32>) -> ()
    %3 = llvm.add %2, %1  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }]

def vec_const_sub_add_const_nonsplat_before := [llvmfunc|
  llvm.func @vec_const_sub_add_const_nonsplat(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.constant(21 : i32) : i32
    %3 = llvm.mlir.undef : vector<4xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<4xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<4xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<4xi32>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %0, %9[%10 : i32] : vector<4xi32>
    %12 = llvm.mlir.constant(2 : i32) : i32
    %13 = llvm.mlir.constant(3 : i32) : i32
    %14 = llvm.mlir.undef : vector<4xi32>
    %15 = llvm.mlir.constant(0 : i32) : i32
    %16 = llvm.insertelement %12, %14[%15 : i32] : vector<4xi32>
    %17 = llvm.mlir.constant(1 : i32) : i32
    %18 = llvm.insertelement %13, %16[%17 : i32] : vector<4xi32>
    %19 = llvm.mlir.constant(2 : i32) : i32
    %20 = llvm.insertelement %1, %18[%19 : i32] : vector<4xi32>
    %21 = llvm.mlir.constant(3 : i32) : i32
    %22 = llvm.insertelement %12, %20[%21 : i32] : vector<4xi32>
    %23 = llvm.sub %11, %arg0  : vector<4xi32>
    %24 = llvm.add %23, %22  : vector<4xi32>
    llvm.return %24 : vector<4xi32>
  }]

def const_sub_sub_const_before := [llvmfunc|
  llvm.func @const_sub_sub_const(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.sub %2, %1  : i32
    llvm.return %3 : i32
  }]

def const_sub_sub_const_extrause_before := [llvmfunc|
  llvm.func @const_sub_sub_const_extrause(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.sub %2, %1  : i32
    llvm.return %3 : i32
  }]

def vec_const_sub_sub_const_before := [llvmfunc|
  llvm.func @vec_const_sub_sub_const(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sub %0, %arg0  : vector<4xi32>
    %3 = llvm.sub %2, %1  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }]

def vec_const_sub_sub_const_extrause_before := [llvmfunc|
  llvm.func @vec_const_sub_sub_const_extrause(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sub %0, %arg0  : vector<4xi32>
    llvm.call @vec_use(%2) : (vector<4xi32>) -> ()
    %3 = llvm.sub %2, %1  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }]

def vec_const_sub_sub_const_nonsplat_before := [llvmfunc|
  llvm.func @vec_const_sub_sub_const_nonsplat(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.constant(21 : i32) : i32
    %3 = llvm.mlir.undef : vector<4xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<4xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<4xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<4xi32>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %0, %9[%10 : i32] : vector<4xi32>
    %12 = llvm.mlir.constant(2 : i32) : i32
    %13 = llvm.mlir.constant(3 : i32) : i32
    %14 = llvm.mlir.undef : vector<4xi32>
    %15 = llvm.mlir.constant(0 : i32) : i32
    %16 = llvm.insertelement %12, %14[%15 : i32] : vector<4xi32>
    %17 = llvm.mlir.constant(1 : i32) : i32
    %18 = llvm.insertelement %13, %16[%17 : i32] : vector<4xi32>
    %19 = llvm.mlir.constant(2 : i32) : i32
    %20 = llvm.insertelement %1, %18[%19 : i32] : vector<4xi32>
    %21 = llvm.mlir.constant(3 : i32) : i32
    %22 = llvm.insertelement %12, %20[%21 : i32] : vector<4xi32>
    %23 = llvm.sub %11, %arg0  : vector<4xi32>
    %24 = llvm.sub %23, %22  : vector<4xi32>
    llvm.return %24 : vector<4xi32>
  }]

def const_sub_const_sub_before := [llvmfunc|
  llvm.func @const_sub_const_sub(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.sub %1, %2  : i32
    llvm.return %3 : i32
  }]

def const_sub_const_sub_extrause_before := [llvmfunc|
  llvm.func @const_sub_const_sub_extrause(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.sub %1, %2  : i32
    llvm.return %3 : i32
  }]

def vec_const_sub_const_sub_before := [llvmfunc|
  llvm.func @vec_const_sub_const_sub(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sub %0, %arg0  : vector<4xi32>
    %3 = llvm.sub %1, %2  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }]

def vec_const_sub_const_sub_extrause_before := [llvmfunc|
  llvm.func @vec_const_sub_const_sub_extrause(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sub %0, %arg0  : vector<4xi32>
    llvm.call @vec_use(%2) : (vector<4xi32>) -> ()
    %3 = llvm.sub %1, %2  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }]

def vec_const_sub_const_sub_nonsplat_before := [llvmfunc|
  llvm.func @vec_const_sub_const_sub_nonsplat(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.constant(21 : i32) : i32
    %3 = llvm.mlir.undef : vector<4xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<4xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<4xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<4xi32>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %0, %9[%10 : i32] : vector<4xi32>
    %12 = llvm.mlir.constant(2 : i32) : i32
    %13 = llvm.mlir.constant(3 : i32) : i32
    %14 = llvm.mlir.undef : vector<4xi32>
    %15 = llvm.mlir.constant(0 : i32) : i32
    %16 = llvm.insertelement %12, %14[%15 : i32] : vector<4xi32>
    %17 = llvm.mlir.constant(1 : i32) : i32
    %18 = llvm.insertelement %13, %16[%17 : i32] : vector<4xi32>
    %19 = llvm.mlir.constant(2 : i32) : i32
    %20 = llvm.insertelement %1, %18[%19 : i32] : vector<4xi32>
    %21 = llvm.mlir.constant(3 : i32) : i32
    %22 = llvm.insertelement %12, %20[%21 : i32] : vector<4xi32>
    %23 = llvm.sub %11, %arg0  : vector<4xi32>
    %24 = llvm.sub %22, %23  : vector<4xi32>
    llvm.return %24 : vector<4xi32>
  }]

def addsub_combine_constants_before := [llvmfunc|
  llvm.func @addsub_combine_constants(%arg0: i7, %arg1: i7) -> i7 {
    %0 = llvm.mlir.constant(42 : i7) : i7
    %1 = llvm.mlir.constant(10 : i7) : i7
    %2 = llvm.add %arg0, %0  : i7
    %3 = llvm.sub %1, %arg1  : i7
    %4 = llvm.add %2, %3 overflow<nsw>  : i7
    llvm.return %4 : i7
  }]

def addsub_combine_constants_use1_before := [llvmfunc|
  llvm.func @addsub_combine_constants_use1(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[42, -7, 0, -1]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[-100, 1, -1, 42]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.add %arg0, %0  : vector<4xi32>
    llvm.call @vec_use(%2) : (vector<4xi32>) -> ()
    %3 = llvm.sub %1, %arg1  : vector<4xi32>
    %4 = llvm.add %3, %2 overflow<nuw>  : vector<4xi32>
    llvm.return %4 : vector<4xi32>
  }]

def addsub_combine_constants_use2_before := [llvmfunc|
  llvm.func @addsub_combine_constants_use2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(100 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.sub %1, %arg1  : i32
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.add %2, %3  : i32
    llvm.return %4 : i32
  }]

def addsub_combine_constants_use3_before := [llvmfunc|
  llvm.func @addsub_combine_constants_use3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(100 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.sub %1, %arg1  : i32
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.add %2, %3  : i32
    llvm.return %4 : i32
  }]

def sub_from_constant_before := [llvmfunc|
  llvm.func @sub_from_constant(%arg0: i5, %arg1: i5) -> i5 {
    %0 = llvm.mlir.constant(10 : i5) : i5
    %1 = llvm.sub %0, %arg0  : i5
    %2 = llvm.add %1, %arg1  : i5
    llvm.return %2 : i5
  }]

def sub_from_constant_commute_before := [llvmfunc|
  llvm.func @sub_from_constant_commute(%arg0: i5, %arg1: i5) -> i5 {
    %0 = llvm.mlir.constant(10 : i5) : i5
    %1 = llvm.mul %arg1, %arg1  : i5
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i5
    %3 = llvm.add %1, %2 overflow<nsw>  : i5
    llvm.return %3 : i5
  }]

def sub_from_constant_vec_before := [llvmfunc|
  llvm.func @sub_from_constant_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[2, -42]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.sub %0, %arg0 overflow<nuw>  : vector<2xi8>
    %2 = llvm.add %1, %arg1 overflow<nuw>  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

def sub_from_constant_extra_use_before := [llvmfunc|
  llvm.func @sub_from_constant_extra_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.addressof @use : !llvm.ptr
    %2 = llvm.sub %0, %arg0  : i8
    llvm.call %1(%2) : !llvm.ptr, (i8) -> ()
    %3 = llvm.add %2, %arg1  : i8
    llvm.return %3 : i8
  }]

def add_const_add_const_combined := [llvmfunc|
  llvm.func @add_const_add_const(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_add_const_add_const   : add_const_add_const_before  ⊑  add_const_add_const_combined := by
  unfold add_const_add_const_before add_const_add_const_combined
  simp_alive_peephole
  sorry
def add_const_add_const_extrause_combined := [llvmfunc|
  llvm.func @add_const_add_const_extrause(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.add %arg0, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_add_const_add_const_extrause   : add_const_add_const_extrause_before  ⊑  add_const_add_const_extrause_combined := by
  unfold add_const_add_const_extrause_before add_const_add_const_extrause_combined
  simp_alive_peephole
  sorry
def vec_add_const_add_const_combined := [llvmfunc|
  llvm.func @vec_add_const_add_const(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<10> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.add %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_vec_add_const_add_const   : vec_add_const_add_const_before  ⊑  vec_add_const_add_const_combined := by
  unfold vec_add_const_add_const_before vec_add_const_add_const_combined
  simp_alive_peephole
  sorry
def vec_add_const_add_const_extrause_combined := [llvmfunc|
  llvm.func @vec_add_const_add_const_extrause(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<10> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.add %arg0, %0  : vector<4xi32>
    llvm.call @vec_use(%2) : (vector<4xi32>) -> ()
    %3 = llvm.add %arg0, %1  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }]

theorem inst_combine_vec_add_const_add_const_extrause   : vec_add_const_add_const_extrause_before  ⊑  vec_add_const_add_const_extrause_combined := by
  unfold vec_add_const_add_const_extrause_before vec_add_const_add_const_extrause_combined
  simp_alive_peephole
  sorry
def vec_add_const_add_const_nonsplat_combined := [llvmfunc|
  llvm.func @vec_add_const_add_const_nonsplat(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.constant(23 : i32) : i32
    %3 = llvm.mlir.undef : vector<4xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<4xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<4xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<4xi32>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %0, %9[%10 : i32] : vector<4xi32>
    %12 = llvm.add %arg0, %11  : vector<4xi32>
    llvm.return %12 : vector<4xi32>
  }]

theorem inst_combine_vec_add_const_add_const_nonsplat   : vec_add_const_add_const_nonsplat_before  ⊑  vec_add_const_add_const_nonsplat_combined := by
  unfold vec_add_const_add_const_nonsplat_before vec_add_const_add_const_nonsplat_combined
  simp_alive_peephole
  sorry
def add_const_sub_const_combined := [llvmfunc|
  llvm.func @add_const_sub_const(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_add_const_sub_const   : add_const_sub_const_before  ⊑  add_const_sub_const_combined := by
  unfold add_const_sub_const_before add_const_sub_const_combined
  simp_alive_peephole
  sorry
def add_const_sub_const_extrause_combined := [llvmfunc|
  llvm.func @add_const_sub_const_extrause(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.add %arg0, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_add_const_sub_const_extrause   : add_const_sub_const_extrause_before  ⊑  add_const_sub_const_extrause_combined := by
  unfold add_const_sub_const_extrause_before add_const_sub_const_extrause_combined
  simp_alive_peephole
  sorry
def vec_add_const_sub_const_combined := [llvmfunc|
  llvm.func @vec_add_const_sub_const(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<6> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.add %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_vec_add_const_sub_const   : vec_add_const_sub_const_before  ⊑  vec_add_const_sub_const_combined := by
  unfold vec_add_const_sub_const_before vec_add_const_sub_const_combined
  simp_alive_peephole
  sorry
def vec_add_const_sub_const_extrause_combined := [llvmfunc|
  llvm.func @vec_add_const_sub_const_extrause(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<6> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.add %arg0, %0  : vector<4xi32>
    llvm.call @vec_use(%2) : (vector<4xi32>) -> ()
    %3 = llvm.add %arg0, %1  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }]

theorem inst_combine_vec_add_const_sub_const_extrause   : vec_add_const_sub_const_extrause_before  ⊑  vec_add_const_sub_const_extrause_combined := by
  unfold vec_add_const_sub_const_extrause_before vec_add_const_sub_const_extrause_combined
  simp_alive_peephole
  sorry
def vec_add_const_sub_const_nonsplat_combined := [llvmfunc|
  llvm.func @vec_add_const_sub_const_nonsplat(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.constant(19 : i32) : i32
    %3 = llvm.mlir.undef : vector<4xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<4xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<4xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<4xi32>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %0, %9[%10 : i32] : vector<4xi32>
    %12 = llvm.add %arg0, %11  : vector<4xi32>
    llvm.return %12 : vector<4xi32>
  }]

theorem inst_combine_vec_add_const_sub_const_nonsplat   : vec_add_const_sub_const_nonsplat_before  ⊑  vec_add_const_sub_const_nonsplat_combined := by
  unfold vec_add_const_sub_const_nonsplat_before vec_add_const_sub_const_nonsplat_combined
  simp_alive_peephole
  sorry
def add_const_const_sub_combined := [llvmfunc|
  llvm.func @add_const_const_sub(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-6 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_add_const_const_sub   : add_const_const_sub_before  ⊑  add_const_const_sub_combined := by
  unfold add_const_const_sub_before add_const_const_sub_combined
  simp_alive_peephole
  sorry
def add_nsw_const_const_sub_nsw_combined := [llvmfunc|
  llvm.func @add_nsw_const_const_sub_nsw(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_add_nsw_const_const_sub_nsw   : add_nsw_const_const_sub_nsw_before  ⊑  add_nsw_const_const_sub_nsw_combined := by
  unfold add_nsw_const_const_sub_nsw_before add_nsw_const_const_sub_nsw_combined
  simp_alive_peephole
  sorry
def add_nsw_const_const_sub_combined := [llvmfunc|
  llvm.func @add_nsw_const_const_sub(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_add_nsw_const_const_sub   : add_nsw_const_const_sub_before  ⊑  add_nsw_const_const_sub_combined := by
  unfold add_nsw_const_const_sub_before add_nsw_const_const_sub_combined
  simp_alive_peephole
  sorry
def add_const_const_sub_nsw_combined := [llvmfunc|
  llvm.func @add_const_const_sub_nsw(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_add_const_const_sub_nsw   : add_const_const_sub_nsw_before  ⊑  add_const_const_sub_nsw_combined := by
  unfold add_const_const_sub_nsw_before add_const_const_sub_nsw_combined
  simp_alive_peephole
  sorry
def add_nsw_const_const_sub_nsw_ov_combined := [llvmfunc|
  llvm.func @add_nsw_const_const_sub_nsw_ov(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_add_nsw_const_const_sub_nsw_ov   : add_nsw_const_const_sub_nsw_ov_before  ⊑  add_nsw_const_const_sub_nsw_ov_combined := by
  unfold add_nsw_const_const_sub_nsw_ov_before add_nsw_const_const_sub_nsw_ov_combined
  simp_alive_peephole
  sorry
def add_nuw_const_const_sub_nuw_combined := [llvmfunc|
  llvm.func @add_nuw_const_const_sub_nuw(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.sub %0, %arg0 overflow<nuw>  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_add_nuw_const_const_sub_nuw   : add_nuw_const_const_sub_nuw_before  ⊑  add_nuw_const_const_sub_nuw_combined := by
  unfold add_nuw_const_const_sub_nuw_before add_nuw_const_const_sub_nuw_combined
  simp_alive_peephole
  sorry
def add_nuw_const_const_sub_combined := [llvmfunc|
  llvm.func @add_nuw_const_const_sub(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_add_nuw_const_const_sub   : add_nuw_const_const_sub_before  ⊑  add_nuw_const_const_sub_combined := by
  unfold add_nuw_const_const_sub_before add_nuw_const_const_sub_combined
  simp_alive_peephole
  sorry
def add_const_const_sub_nuw_combined := [llvmfunc|
  llvm.func @add_const_const_sub_nuw(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_add_const_const_sub_nuw   : add_const_const_sub_nuw_before  ⊑  add_const_const_sub_nuw_combined := by
  unfold add_const_const_sub_nuw_before add_const_const_sub_nuw_combined
  simp_alive_peephole
  sorry
def non_splat_vec_add_nsw_const_const_sub_nsw_not_ov1_combined := [llvmfunc|
  llvm.func @non_splat_vec_add_nsw_const_const_sub_nsw_not_ov1(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[-127, -126]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_non_splat_vec_add_nsw_const_const_sub_nsw_not_ov1   : non_splat_vec_add_nsw_const_const_sub_nsw_not_ov1_before  ⊑  non_splat_vec_add_nsw_const_const_sub_nsw_not_ov1_combined := by
  unfold non_splat_vec_add_nsw_const_const_sub_nsw_not_ov1_before non_splat_vec_add_nsw_const_const_sub_nsw_not_ov1_combined
  simp_alive_peephole
  sorry
def non_splat_vec_add_nsw_const_const_sub_nsw_not_ov2_combined := [llvmfunc|
  llvm.func @non_splat_vec_add_nsw_const_const_sub_nsw_not_ov2(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[-126, -128]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_non_splat_vec_add_nsw_const_const_sub_nsw_not_ov2   : non_splat_vec_add_nsw_const_const_sub_nsw_not_ov2_before  ⊑  non_splat_vec_add_nsw_const_const_sub_nsw_not_ov2_combined := by
  unfold non_splat_vec_add_nsw_const_const_sub_nsw_not_ov2_before non_splat_vec_add_nsw_const_const_sub_nsw_not_ov2_combined
  simp_alive_peephole
  sorry
def non_splat_vec_add_nsw_const_const_sub_nsw_not_ov3_combined := [llvmfunc|
  llvm.func @non_splat_vec_add_nsw_const_const_sub_nsw_not_ov3(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[-120, -127]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_non_splat_vec_add_nsw_const_const_sub_nsw_not_ov3   : non_splat_vec_add_nsw_const_const_sub_nsw_not_ov3_before  ⊑  non_splat_vec_add_nsw_const_const_sub_nsw_not_ov3_combined := by
  unfold non_splat_vec_add_nsw_const_const_sub_nsw_not_ov3_before non_splat_vec_add_nsw_const_const_sub_nsw_not_ov3_combined
  simp_alive_peephole
  sorry
def non_splat_vec_add_nsw_const_const_sub_nsw_ov_combined := [llvmfunc|
  llvm.func @non_splat_vec_add_nsw_const_const_sub_nsw_ov(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[-127, 127]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.sub %0, %arg0  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_non_splat_vec_add_nsw_const_const_sub_nsw_ov   : non_splat_vec_add_nsw_const_const_sub_nsw_ov_before  ⊑  non_splat_vec_add_nsw_const_const_sub_nsw_ov_combined := by
  unfold non_splat_vec_add_nsw_const_const_sub_nsw_ov_before non_splat_vec_add_nsw_const_const_sub_nsw_ov_combined
  simp_alive_peephole
  sorry
def add_const_const_sub_extrause_combined := [llvmfunc|
  llvm.func @add_const_const_sub_extrause(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(-6 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.sub %1, %arg0  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_add_const_const_sub_extrause   : add_const_const_sub_extrause_before  ⊑  add_const_const_sub_extrause_combined := by
  unfold add_const_const_sub_extrause_before add_const_const_sub_extrause_combined
  simp_alive_peephole
  sorry
def vec_add_const_const_sub_combined := [llvmfunc|
  llvm.func @vec_add_const_const_sub(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<-6> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.sub %0, %arg0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_vec_add_const_const_sub   : vec_add_const_const_sub_before  ⊑  vec_add_const_const_sub_combined := by
  unfold vec_add_const_const_sub_before vec_add_const_const_sub_combined
  simp_alive_peephole
  sorry
def vec_add_const_const_sub_extrause_combined := [llvmfunc|
  llvm.func @vec_add_const_const_sub_extrause(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<-6> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.add %arg0, %0  : vector<4xi32>
    llvm.call @vec_use(%2) : (vector<4xi32>) -> ()
    %3 = llvm.sub %1, %arg0  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }]

theorem inst_combine_vec_add_const_const_sub_extrause   : vec_add_const_const_sub_extrause_before  ⊑  vec_add_const_const_sub_extrause_combined := by
  unfold vec_add_const_const_sub_extrause_before vec_add_const_const_sub_extrause_combined
  simp_alive_peephole
  sorry
def vec_add_const_const_sub_nonsplat_combined := [llvmfunc|
  llvm.func @vec_add_const_const_sub_nonsplat(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(-6 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.constant(-19 : i32) : i32
    %3 = llvm.mlir.undef : vector<4xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<4xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<4xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<4xi32>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %0, %9[%10 : i32] : vector<4xi32>
    %12 = llvm.sub %11, %arg0  : vector<4xi32>
    llvm.return %12 : vector<4xi32>
  }]

theorem inst_combine_vec_add_const_const_sub_nonsplat   : vec_add_const_const_sub_nonsplat_before  ⊑  vec_add_const_const_sub_nonsplat_combined := by
  unfold vec_add_const_const_sub_nonsplat_before vec_add_const_const_sub_nonsplat_combined
  simp_alive_peephole
  sorry
def sub_const_add_const_combined := [llvmfunc|
  llvm.func @sub_const_add_const(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-6 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_sub_const_add_const   : sub_const_add_const_before  ⊑  sub_const_add_const_combined := by
  unfold sub_const_add_const_before sub_const_add_const_combined
  simp_alive_peephole
  sorry
def sub_const_add_const_extrause_combined := [llvmfunc|
  llvm.func @sub_const_add_const_extrause(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-8 : i32) : i32
    %1 = llvm.mlir.constant(-6 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.add %arg0, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_sub_const_add_const_extrause   : sub_const_add_const_extrause_before  ⊑  sub_const_add_const_extrause_combined := by
  unfold sub_const_add_const_extrause_before sub_const_add_const_extrause_combined
  simp_alive_peephole
  sorry
def vec_sub_const_add_const_combined := [llvmfunc|
  llvm.func @vec_sub_const_add_const(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<-6> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.add %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_vec_sub_const_add_const   : vec_sub_const_add_const_before  ⊑  vec_sub_const_add_const_combined := by
  unfold vec_sub_const_add_const_before vec_sub_const_add_const_combined
  simp_alive_peephole
  sorry
def vec_sub_const_add_const_extrause_combined := [llvmfunc|
  llvm.func @vec_sub_const_add_const_extrause(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<-8> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<-6> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.add %arg0, %0  : vector<4xi32>
    llvm.call @vec_use(%2) : (vector<4xi32>) -> ()
    %3 = llvm.add %arg0, %1  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }]

theorem inst_combine_vec_sub_const_add_const_extrause   : vec_sub_const_add_const_extrause_before  ⊑  vec_sub_const_add_const_extrause_combined := by
  unfold vec_sub_const_add_const_extrause_before vec_sub_const_add_const_extrause_combined
  simp_alive_peephole
  sorry
def vec_sub_const_add_const_nonsplat_combined := [llvmfunc|
  llvm.func @vec_sub_const_add_const_nonsplat(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(-6 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.constant(-19 : i32) : i32
    %3 = llvm.mlir.undef : vector<4xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<4xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<4xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<4xi32>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %0, %9[%10 : i32] : vector<4xi32>
    %12 = llvm.add %arg0, %11  : vector<4xi32>
    llvm.return %12 : vector<4xi32>
  }]

theorem inst_combine_vec_sub_const_add_const_nonsplat   : vec_sub_const_add_const_nonsplat_before  ⊑  vec_sub_const_add_const_nonsplat_combined := by
  unfold vec_sub_const_add_const_nonsplat_before vec_sub_const_add_const_nonsplat_combined
  simp_alive_peephole
  sorry
def sub_const_sub_const_combined := [llvmfunc|
  llvm.func @sub_const_sub_const(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-10 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_sub_const_sub_const   : sub_const_sub_const_before  ⊑  sub_const_sub_const_combined := by
  unfold sub_const_sub_const_before sub_const_sub_const_combined
  simp_alive_peephole
  sorry
def sub_const_sub_const_extrause_combined := [llvmfunc|
  llvm.func @sub_const_sub_const_extrause(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-8 : i32) : i32
    %1 = llvm.mlir.constant(-10 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.add %arg0, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_sub_const_sub_const_extrause   : sub_const_sub_const_extrause_before  ⊑  sub_const_sub_const_extrause_combined := by
  unfold sub_const_sub_const_extrause_before sub_const_sub_const_extrause_combined
  simp_alive_peephole
  sorry
def vec_sub_const_sub_const_combined := [llvmfunc|
  llvm.func @vec_sub_const_sub_const(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<-10> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.add %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_vec_sub_const_sub_const   : vec_sub_const_sub_const_before  ⊑  vec_sub_const_sub_const_combined := by
  unfold vec_sub_const_sub_const_before vec_sub_const_sub_const_combined
  simp_alive_peephole
  sorry
def vec_sub_const_sub_const_extrause_combined := [llvmfunc|
  llvm.func @vec_sub_const_sub_const_extrause(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<-8> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<-10> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.add %arg0, %0  : vector<4xi32>
    llvm.call @vec_use(%2) : (vector<4xi32>) -> ()
    %3 = llvm.add %arg0, %1  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }]

theorem inst_combine_vec_sub_const_sub_const_extrause   : vec_sub_const_sub_const_extrause_before  ⊑  vec_sub_const_sub_const_extrause_combined := by
  unfold vec_sub_const_sub_const_extrause_before vec_sub_const_sub_const_extrause_combined
  simp_alive_peephole
  sorry
def vec_sub_const_sub_const_nonsplat_combined := [llvmfunc|
  llvm.func @vec_sub_const_sub_const_nonsplat(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(-10 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.constant(-23 : i32) : i32
    %3 = llvm.mlir.undef : vector<4xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<4xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<4xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<4xi32>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %0, %9[%10 : i32] : vector<4xi32>
    %12 = llvm.add %arg0, %11  : vector<4xi32>
    llvm.return %12 : vector<4xi32>
  }]

theorem inst_combine_vec_sub_const_sub_const_nonsplat   : vec_sub_const_sub_const_nonsplat_before  ⊑  vec_sub_const_sub_const_nonsplat_combined := by
  unfold vec_sub_const_sub_const_nonsplat_before vec_sub_const_sub_const_nonsplat_combined
  simp_alive_peephole
  sorry
def sub_const_const_sub_combined := [llvmfunc|
  llvm.func @sub_const_const_sub(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_sub_const_const_sub   : sub_const_const_sub_before  ⊑  sub_const_const_sub_combined := by
  unfold sub_const_const_sub_before sub_const_const_sub_combined
  simp_alive_peephole
  sorry
def sub_const_const_sub_extrause_combined := [llvmfunc|
  llvm.func @sub_const_const_sub_extrause(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-8 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.sub %1, %arg0  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_sub_const_const_sub_extrause   : sub_const_const_sub_extrause_before  ⊑  sub_const_const_sub_extrause_combined := by
  unfold sub_const_const_sub_extrause_before sub_const_const_sub_extrause_combined
  simp_alive_peephole
  sorry
def vec_sub_const_const_sub_combined := [llvmfunc|
  llvm.func @vec_sub_const_const_sub(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<10> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.sub %0, %arg0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_vec_sub_const_const_sub   : vec_sub_const_const_sub_before  ⊑  vec_sub_const_const_sub_combined := by
  unfold vec_sub_const_const_sub_before vec_sub_const_const_sub_combined
  simp_alive_peephole
  sorry
def vec_sub_const_const_sub_extrause_combined := [llvmfunc|
  llvm.func @vec_sub_const_const_sub_extrause(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<-8> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<10> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.add %arg0, %0  : vector<4xi32>
    llvm.call @vec_use(%2) : (vector<4xi32>) -> ()
    %3 = llvm.sub %1, %arg0  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }]

theorem inst_combine_vec_sub_const_const_sub_extrause   : vec_sub_const_const_sub_extrause_before  ⊑  vec_sub_const_const_sub_extrause_combined := by
  unfold vec_sub_const_const_sub_extrause_before vec_sub_const_const_sub_extrause_combined
  simp_alive_peephole
  sorry
def vec_sub_const_const_sub_nonsplat_combined := [llvmfunc|
  llvm.func @vec_sub_const_const_sub_nonsplat(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.constant(23 : i32) : i32
    %3 = llvm.mlir.undef : vector<4xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<4xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<4xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<4xi32>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %0, %9[%10 : i32] : vector<4xi32>
    %12 = llvm.sub %11, %arg0  : vector<4xi32>
    llvm.return %12 : vector<4xi32>
  }]

theorem inst_combine_vec_sub_const_const_sub_nonsplat   : vec_sub_const_const_sub_nonsplat_before  ⊑  vec_sub_const_const_sub_nonsplat_combined := by
  unfold vec_sub_const_const_sub_nonsplat_before vec_sub_const_const_sub_nonsplat_combined
  simp_alive_peephole
  sorry
def const_sub_add_const_combined := [llvmfunc|
  llvm.func @const_sub_add_const(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_const_sub_add_const   : const_sub_add_const_before  ⊑  const_sub_add_const_combined := by
  unfold const_sub_add_const_before const_sub_add_const_combined
  simp_alive_peephole
  sorry
def const_sub_add_const_extrause_combined := [llvmfunc|
  llvm.func @const_sub_add_const_extrause(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.sub %1, %arg0  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_const_sub_add_const_extrause   : const_sub_add_const_extrause_before  ⊑  const_sub_add_const_extrause_combined := by
  unfold const_sub_add_const_extrause_before const_sub_add_const_extrause_combined
  simp_alive_peephole
  sorry
def vec_const_sub_add_const_combined := [llvmfunc|
  llvm.func @vec_const_sub_add_const(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<10> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.sub %0, %arg0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_vec_const_sub_add_const   : vec_const_sub_add_const_before  ⊑  vec_const_sub_add_const_combined := by
  unfold vec_const_sub_add_const_before vec_const_sub_add_const_combined
  simp_alive_peephole
  sorry
def vec_const_sub_add_const_extrause_combined := [llvmfunc|
  llvm.func @vec_const_sub_add_const_extrause(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<10> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sub %0, %arg0  : vector<4xi32>
    llvm.call @vec_use(%2) : (vector<4xi32>) -> ()
    %3 = llvm.sub %1, %arg0  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }]

theorem inst_combine_vec_const_sub_add_const_extrause   : vec_const_sub_add_const_extrause_before  ⊑  vec_const_sub_add_const_extrause_combined := by
  unfold vec_const_sub_add_const_extrause_before vec_const_sub_add_const_extrause_combined
  simp_alive_peephole
  sorry
def vec_const_sub_add_const_nonsplat_combined := [llvmfunc|
  llvm.func @vec_const_sub_add_const_nonsplat(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.constant(23 : i32) : i32
    %3 = llvm.mlir.undef : vector<4xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<4xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<4xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<4xi32>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %0, %9[%10 : i32] : vector<4xi32>
    %12 = llvm.sub %11, %arg0  : vector<4xi32>
    llvm.return %12 : vector<4xi32>
  }]

theorem inst_combine_vec_const_sub_add_const_nonsplat   : vec_const_sub_add_const_nonsplat_before  ⊑  vec_const_sub_add_const_nonsplat_combined := by
  unfold vec_const_sub_add_const_nonsplat_before vec_const_sub_add_const_nonsplat_combined
  simp_alive_peephole
  sorry
def const_sub_sub_const_combined := [llvmfunc|
  llvm.func @const_sub_sub_const(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_const_sub_sub_const   : const_sub_sub_const_before  ⊑  const_sub_sub_const_combined := by
  unfold const_sub_sub_const_before const_sub_sub_const_combined
  simp_alive_peephole
  sorry
def const_sub_sub_const_extrause_combined := [llvmfunc|
  llvm.func @const_sub_sub_const_extrause(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.sub %1, %arg0  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_const_sub_sub_const_extrause   : const_sub_sub_const_extrause_before  ⊑  const_sub_sub_const_extrause_combined := by
  unfold const_sub_sub_const_extrause_before const_sub_sub_const_extrause_combined
  simp_alive_peephole
  sorry
def vec_const_sub_sub_const_combined := [llvmfunc|
  llvm.func @vec_const_sub_sub_const(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<6> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.sub %0, %arg0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_vec_const_sub_sub_const   : vec_const_sub_sub_const_before  ⊑  vec_const_sub_sub_const_combined := by
  unfold vec_const_sub_sub_const_before vec_const_sub_sub_const_combined
  simp_alive_peephole
  sorry
def vec_const_sub_sub_const_extrause_combined := [llvmfunc|
  llvm.func @vec_const_sub_sub_const_extrause(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<6> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sub %0, %arg0  : vector<4xi32>
    llvm.call @vec_use(%2) : (vector<4xi32>) -> ()
    %3 = llvm.sub %1, %arg0  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }]

theorem inst_combine_vec_const_sub_sub_const_extrause   : vec_const_sub_sub_const_extrause_before  ⊑  vec_const_sub_sub_const_extrause_combined := by
  unfold vec_const_sub_sub_const_extrause_before vec_const_sub_sub_const_extrause_combined
  simp_alive_peephole
  sorry
def vec_const_sub_sub_const_nonsplat_combined := [llvmfunc|
  llvm.func @vec_const_sub_sub_const_nonsplat(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.constant(19 : i32) : i32
    %3 = llvm.mlir.undef : vector<4xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<4xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<4xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<4xi32>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %0, %9[%10 : i32] : vector<4xi32>
    %12 = llvm.sub %11, %arg0  : vector<4xi32>
    llvm.return %12 : vector<4xi32>
  }]

theorem inst_combine_vec_const_sub_sub_const_nonsplat   : vec_const_sub_sub_const_nonsplat_before  ⊑  vec_const_sub_sub_const_nonsplat_combined := by
  unfold vec_const_sub_sub_const_nonsplat_before vec_const_sub_sub_const_nonsplat_combined
  simp_alive_peephole
  sorry
def const_sub_const_sub_combined := [llvmfunc|
  llvm.func @const_sub_const_sub(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-6 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_const_sub_const_sub   : const_sub_const_sub_before  ⊑  const_sub_const_sub_combined := by
  unfold const_sub_const_sub_before const_sub_const_sub_combined
  simp_alive_peephole
  sorry
def const_sub_const_sub_extrause_combined := [llvmfunc|
  llvm.func @const_sub_const_sub_extrause(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(-6 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.add %arg0, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_const_sub_const_sub_extrause   : const_sub_const_sub_extrause_before  ⊑  const_sub_const_sub_extrause_combined := by
  unfold const_sub_const_sub_extrause_before const_sub_const_sub_extrause_combined
  simp_alive_peephole
  sorry
def vec_const_sub_const_sub_combined := [llvmfunc|
  llvm.func @vec_const_sub_const_sub(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<-6> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.add %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_vec_const_sub_const_sub   : vec_const_sub_const_sub_before  ⊑  vec_const_sub_const_sub_combined := by
  unfold vec_const_sub_const_sub_before vec_const_sub_const_sub_combined
  simp_alive_peephole
  sorry
def vec_const_sub_const_sub_extrause_combined := [llvmfunc|
  llvm.func @vec_const_sub_const_sub_extrause(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<-6> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sub %0, %arg0  : vector<4xi32>
    llvm.call @vec_use(%2) : (vector<4xi32>) -> ()
    %3 = llvm.add %arg0, %1  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }]

theorem inst_combine_vec_const_sub_const_sub_extrause   : vec_const_sub_const_sub_extrause_before  ⊑  vec_const_sub_const_sub_extrause_combined := by
  unfold vec_const_sub_const_sub_extrause_before vec_const_sub_const_sub_extrause_combined
  simp_alive_peephole
  sorry
def vec_const_sub_const_sub_nonsplat_combined := [llvmfunc|
  llvm.func @vec_const_sub_const_sub_nonsplat(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(-6 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.constant(-19 : i32) : i32
    %3 = llvm.mlir.undef : vector<4xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<4xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<4xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<4xi32>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %0, %9[%10 : i32] : vector<4xi32>
    %12 = llvm.add %arg0, %11  : vector<4xi32>
    llvm.return %12 : vector<4xi32>
  }]

theorem inst_combine_vec_const_sub_const_sub_nonsplat   : vec_const_sub_const_sub_nonsplat_before  ⊑  vec_const_sub_const_sub_nonsplat_combined := by
  unfold vec_const_sub_const_sub_nonsplat_before vec_const_sub_const_sub_nonsplat_combined
  simp_alive_peephole
  sorry
def addsub_combine_constants_combined := [llvmfunc|
  llvm.func @addsub_combine_constants(%arg0: i7, %arg1: i7) -> i7 {
    %0 = llvm.mlir.constant(52 : i7) : i7
    %1 = llvm.sub %arg0, %arg1  : i7
    %2 = llvm.add %1, %0  : i7
    llvm.return %2 : i7
  }]

theorem inst_combine_addsub_combine_constants   : addsub_combine_constants_before  ⊑  addsub_combine_constants_combined := by
  unfold addsub_combine_constants_before addsub_combine_constants_combined
  simp_alive_peephole
  sorry
def addsub_combine_constants_use1_combined := [llvmfunc|
  llvm.func @addsub_combine_constants_use1(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[42, -7, 0, -1]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[-58, -6, -1, 41]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.add %arg0, %0  : vector<4xi32>
    llvm.call @vec_use(%2) : (vector<4xi32>) -> ()
    %3 = llvm.sub %arg0, %arg1  : vector<4xi32>
    %4 = llvm.add %3, %1  : vector<4xi32>
    llvm.return %4 : vector<4xi32>
  }]

theorem inst_combine_addsub_combine_constants_use1   : addsub_combine_constants_use1_before  ⊑  addsub_combine_constants_use1_combined := by
  unfold addsub_combine_constants_use1_before addsub_combine_constants_use1_combined
  simp_alive_peephole
  sorry
def addsub_combine_constants_use2_combined := [llvmfunc|
  llvm.func @addsub_combine_constants_use2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(100 : i32) : i32
    %1 = llvm.mlir.constant(142 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.sub %arg0, %arg1  : i32
    %4 = llvm.add %3, %1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_addsub_combine_constants_use2   : addsub_combine_constants_use2_before  ⊑  addsub_combine_constants_use2_combined := by
  unfold addsub_combine_constants_use2_before addsub_combine_constants_use2_combined
  simp_alive_peephole
  sorry
def addsub_combine_constants_use3_combined := [llvmfunc|
  llvm.func @addsub_combine_constants_use3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(100 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.sub %1, %arg1  : i32
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.add %2, %3  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_addsub_combine_constants_use3   : addsub_combine_constants_use3_before  ⊑  addsub_combine_constants_use3_combined := by
  unfold addsub_combine_constants_use3_before addsub_combine_constants_use3_combined
  simp_alive_peephole
  sorry
def sub_from_constant_combined := [llvmfunc|
  llvm.func @sub_from_constant(%arg0: i5, %arg1: i5) -> i5 {
    %0 = llvm.mlir.constant(10 : i5) : i5
    %1 = llvm.sub %arg1, %arg0  : i5
    %2 = llvm.add %1, %0  : i5
    llvm.return %2 : i5
  }]

theorem inst_combine_sub_from_constant   : sub_from_constant_before  ⊑  sub_from_constant_combined := by
  unfold sub_from_constant_before sub_from_constant_combined
  simp_alive_peephole
  sorry
def sub_from_constant_commute_combined := [llvmfunc|
  llvm.func @sub_from_constant_commute(%arg0: i5, %arg1: i5) -> i5 {
    %0 = llvm.mlir.constant(10 : i5) : i5
    %1 = llvm.mul %arg1, %arg1  : i5
    %2 = llvm.sub %1, %arg0  : i5
    %3 = llvm.add %2, %0  : i5
    llvm.return %3 : i5
  }]

theorem inst_combine_sub_from_constant_commute   : sub_from_constant_commute_before  ⊑  sub_from_constant_commute_combined := by
  unfold sub_from_constant_commute_before sub_from_constant_commute_combined
  simp_alive_peephole
  sorry
def sub_from_constant_vec_combined := [llvmfunc|
  llvm.func @sub_from_constant_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[2, -42]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.sub %arg1, %arg0  : vector<2xi8>
    %2 = llvm.add %1, %0  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

theorem inst_combine_sub_from_constant_vec   : sub_from_constant_vec_before  ⊑  sub_from_constant_vec_combined := by
  unfold sub_from_constant_vec_before sub_from_constant_vec_combined
  simp_alive_peephole
  sorry
def sub_from_constant_extra_use_combined := [llvmfunc|
  llvm.func @sub_from_constant_extra_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.addressof @use : !llvm.ptr
    %2 = llvm.sub %0, %arg0  : i8
    llvm.call %1(%2) : !llvm.ptr, (i8) -> ()
    %3 = llvm.add %2, %arg1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_sub_from_constant_extra_use   : sub_from_constant_extra_use_before  ⊑  sub_from_constant_extra_use_combined := by
  unfold sub_from_constant_extra_use_before sub_from_constant_extra_use_combined
  simp_alive_peephole
  sorry
