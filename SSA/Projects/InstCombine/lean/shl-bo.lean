import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  shl-bo
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def lshr_add_before := [llvmfunc|
  llvm.func @lshr_add(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.srem %arg0, %0  : i8
    %3 = llvm.lshr %arg1, %1  : i8
    %4 = llvm.add %3, %2  : i8
    %5 = llvm.shl %4, %1  : i8
    llvm.return %5 : i8
  }]

def lshr_add_commute_splat_before := [llvmfunc|
  llvm.func @lshr_add_commute_splat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<5> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.srem %arg0, %0  : vector<2xi8>
    %3 = llvm.lshr %arg1, %1  : vector<2xi8>
    %4 = llvm.add %2, %3  : vector<2xi8>
    %5 = llvm.shl %4, %1  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }]

def lshr_sub_before := [llvmfunc|
  llvm.func @lshr_sub(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.srem %arg0, %0  : i8
    %3 = llvm.lshr %arg1, %1  : i8
    %4 = llvm.sub %2, %3  : i8
    %5 = llvm.shl %4, %1  : i8
    llvm.return %5 : i8
  }]

def lshr_sub_commute_splat_before := [llvmfunc|
  llvm.func @lshr_sub_commute_splat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.srem %arg0, %0  : vector<2xi8>
    %3 = llvm.lshr %arg1, %1  : vector<2xi8>
    %4 = llvm.sub %3, %2  : vector<2xi8>
    %5 = llvm.shl %4, %1  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }]

def lshr_and_before := [llvmfunc|
  llvm.func @lshr_and(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.srem %arg0, %0  : i8
    %3 = llvm.lshr %arg1, %1  : i8
    %4 = llvm.and %3, %2  : i8
    %5 = llvm.shl %4, %1  : i8
    llvm.return %5 : i8
  }]

def lshr_and_commute_splat_before := [llvmfunc|
  llvm.func @lshr_and_commute_splat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<6> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.srem %arg0, %0  : vector<2xi8>
    %3 = llvm.lshr %arg1, %1  : vector<2xi8>
    %4 = llvm.and %2, %3  : vector<2xi8>
    %5 = llvm.shl %4, %1  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }]

def lshr_or_before := [llvmfunc|
  llvm.func @lshr_or(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.srem %arg0, %0  : i8
    %3 = llvm.lshr %arg1, %1  : i8
    %4 = llvm.or %2, %3  : i8
    %5 = llvm.shl %4, %1  : i8
    llvm.return %5 : i8
  }]

def lshr_or_commute_splat_before := [llvmfunc|
  llvm.func @lshr_or_commute_splat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<4> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.srem %arg0, %0  : vector<2xi8>
    %3 = llvm.lshr %arg1, %1  : vector<2xi8>
    %4 = llvm.or %3, %2  : vector<2xi8>
    %5 = llvm.shl %4, %1  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }]

def lshr_xor_before := [llvmfunc|
  llvm.func @lshr_xor(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.srem %arg0, %0  : i8
    %3 = llvm.lshr %arg1, %1  : i8
    %4 = llvm.xor %3, %2  : i8
    %5 = llvm.shl %4, %1  : i8
    llvm.return %5 : i8
  }]

def lshr_xor_commute_splat_before := [llvmfunc|
  llvm.func @lshr_xor_commute_splat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.srem %arg0, %0  : vector<2xi8>
    %3 = llvm.lshr %arg1, %1  : vector<2xi8>
    %4 = llvm.xor %2, %3  : vector<2xi8>
    %5 = llvm.shl %4, %1  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }]

def lshr_add_use1_before := [llvmfunc|
  llvm.func @lshr_add_use1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.lshr %arg1, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.add %1, %arg0  : i8
    %3 = llvm.shl %2, %0  : i8
    llvm.return %3 : i8
  }]

def lshr_add_use2_before := [llvmfunc|
  llvm.func @lshr_add_use2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.lshr %arg1, %0  : i8
    %2 = llvm.add %1, %arg0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.shl %2, %0  : i8
    llvm.return %3 : i8
  }]

def lshr_and_add_before := [llvmfunc|
  llvm.func @lshr_and_add(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.mlir.constant(12 : i8) : i8
    %3 = llvm.srem %arg0, %0  : i8
    %4 = llvm.lshr %arg1, %1  : i8
    %5 = llvm.and %4, %2  : i8
    %6 = llvm.add %3, %5  : i8
    %7 = llvm.shl %6, %1  : i8
    llvm.return %7 : i8
  }]

def lshr_and_add_commute_splat_before := [llvmfunc|
  llvm.func @lshr_and_add_commute_splat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<12> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.srem %arg0, %0  : vector<2xi8>
    %4 = llvm.lshr %arg1, %1  : vector<2xi8>
    %5 = llvm.and %4, %2  : vector<2xi8>
    %6 = llvm.add %5, %3  : vector<2xi8>
    %7 = llvm.shl %6, %1  : vector<2xi8>
    llvm.return %7 : vector<2xi8>
  }]

def lshr_and_sub_before := [llvmfunc|
  llvm.func @lshr_and_sub(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.constant(13 : i8) : i8
    %3 = llvm.srem %arg0, %0  : i8
    %4 = llvm.lshr %arg1, %1  : i8
    %5 = llvm.and %4, %2  : i8
    %6 = llvm.sub %3, %5  : i8
    %7 = llvm.shl %6, %1  : i8
    llvm.return %7 : i8
  }]

def lshr_and_sub_commute_splat_before := [llvmfunc|
  llvm.func @lshr_and_sub_commute_splat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<2> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<13> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.srem %arg0, %0  : vector<2xi8>
    %4 = llvm.lshr %arg1, %1  : vector<2xi8>
    %5 = llvm.and %4, %2  : vector<2xi8>
    %6 = llvm.sub %5, %3  : vector<2xi8>
    %7 = llvm.shl %6, %1  : vector<2xi8>
    llvm.return %7 : vector<2xi8>
  }]

def lshr_and_and_before := [llvmfunc|
  llvm.func @lshr_and_and(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.constant(13 : i8) : i8
    %3 = llvm.srem %arg0, %0  : i8
    %4 = llvm.lshr %arg1, %1  : i8
    %5 = llvm.and %4, %2  : i8
    %6 = llvm.and %5, %3  : i8
    %7 = llvm.shl %6, %1  : i8
    llvm.return %7 : i8
  }]

def lshr_and_and_commute_splat_before := [llvmfunc|
  llvm.func @lshr_and_and_commute_splat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<2> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<13> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.srem %arg0, %0  : vector<2xi8>
    %4 = llvm.lshr %arg1, %1  : vector<2xi8>
    %5 = llvm.and %4, %2  : vector<2xi8>
    %6 = llvm.and %3, %5  : vector<2xi8>
    %7 = llvm.shl %6, %1  : vector<2xi8>
    llvm.return %7 : vector<2xi8>
  }]

def lshr_and_or_before := [llvmfunc|
  llvm.func @lshr_and_or(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.constant(13 : i8) : i8
    %3 = llvm.srem %arg0, %0  : i8
    %4 = llvm.lshr %arg1, %1  : i8
    %5 = llvm.and %4, %2  : i8
    %6 = llvm.or %3, %5  : i8
    %7 = llvm.shl %6, %1  : i8
    llvm.return %7 : i8
  }]

def lshr_and_or_disjoint_before := [llvmfunc|
  llvm.func @lshr_and_or_disjoint(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.constant(13 : i8) : i8
    %3 = llvm.srem %arg0, %0  : i8
    %4 = llvm.lshr %arg1, %1  : i8
    %5 = llvm.and %4, %2  : i8
    %6 = llvm.or %3, %5  : i8
    %7 = llvm.shl %6, %1  : i8
    llvm.return %7 : i8
  }]

def ashr_and_or_disjoint_before := [llvmfunc|
  llvm.func @ashr_and_or_disjoint(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.constant(13 : i8) : i8
    %3 = llvm.srem %arg0, %0  : i8
    %4 = llvm.ashr %arg1, %1  : i8
    %5 = llvm.and %4, %2  : i8
    %6 = llvm.or %3, %5  : i8
    %7 = llvm.shl %6, %1  : i8
    llvm.return %7 : i8
  }]

def lshr_and_or_commute_splat_before := [llvmfunc|
  llvm.func @lshr_and_or_commute_splat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<2> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<13> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.srem %arg0, %0  : vector<2xi8>
    %4 = llvm.lshr %arg1, %1  : vector<2xi8>
    %5 = llvm.and %4, %2  : vector<2xi8>
    %6 = llvm.or %5, %3  : vector<2xi8>
    %7 = llvm.shl %6, %1  : vector<2xi8>
    llvm.return %7 : vector<2xi8>
  }]

def lshr_and_xor_before := [llvmfunc|
  llvm.func @lshr_and_xor(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.constant(13 : i8) : i8
    %3 = llvm.srem %arg0, %0  : i8
    %4 = llvm.lshr %arg1, %1  : i8
    %5 = llvm.and %4, %2  : i8
    %6 = llvm.xor %5, %3  : i8
    %7 = llvm.shl %6, %1  : i8
    llvm.return %7 : i8
  }]

def lshr_and_xor_commute_splat_before := [llvmfunc|
  llvm.func @lshr_and_xor_commute_splat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<2> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<13> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.srem %arg0, %0  : vector<2xi8>
    %4 = llvm.lshr %arg1, %1  : vector<2xi8>
    %5 = llvm.and %4, %2  : vector<2xi8>
    %6 = llvm.xor %3, %5  : vector<2xi8>
    %7 = llvm.shl %6, %1  : vector<2xi8>
    llvm.return %7 : vector<2xi8>
  }]

def lshr_and_add_use1_before := [llvmfunc|
  llvm.func @lshr_and_add_use1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(12 : i8) : i8
    %2 = llvm.lshr %arg1, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.and %2, %1  : i8
    %4 = llvm.add %arg0, %3  : i8
    %5 = llvm.shl %4, %0  : i8
    llvm.return %5 : i8
  }]

def lshr_and_add_use2_before := [llvmfunc|
  llvm.func @lshr_and_add_use2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(12 : i8) : i8
    %2 = llvm.lshr %arg1, %0  : i8
    %3 = llvm.and %2, %1  : i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.add %arg0, %3  : i8
    %5 = llvm.shl %4, %0  : i8
    llvm.return %5 : i8
  }]

def lshr_and_add_use3_before := [llvmfunc|
  llvm.func @lshr_and_add_use3(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(12 : i8) : i8
    %2 = llvm.lshr %arg1, %0  : i8
    %3 = llvm.and %2, %1  : i8
    %4 = llvm.add %arg0, %3  : i8
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.shl %4, %0  : i8
    llvm.return %5 : i8
  }]

def lshr_and_add_use4_before := [llvmfunc|
  llvm.func @lshr_and_add_use4(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(12 : i8) : i8
    %2 = llvm.lshr %arg1, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.and %2, %1  : i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.add %arg0, %3  : i8
    %5 = llvm.shl %4, %0  : i8
    llvm.return %5 : i8
  }]

def lshr_and_add_use5_before := [llvmfunc|
  llvm.func @lshr_and_add_use5(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(12 : i8) : i8
    %2 = llvm.lshr %arg1, %0  : i8
    %3 = llvm.and %2, %1  : i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.add %arg0, %3  : i8
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.shl %4, %0  : i8
    llvm.return %5 : i8
  }]

def lshr_and_add_use6_before := [llvmfunc|
  llvm.func @lshr_and_add_use6(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(12 : i8) : i8
    %2 = llvm.lshr %arg1, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.and %2, %1  : i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.add %arg0, %3  : i8
    %5 = llvm.shl %4, %0  : i8
    llvm.return %5 : i8
  }]

def lshr_add_shl_v2i8_undef_before := [llvmfunc|
  llvm.func @lshr_add_shl_v2i8_undef(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.undef : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.undef : vector<2xi8>
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<2xi8>
    %10 = llvm.mlir.constant(1 : i32) : i32
    %11 = llvm.insertelement %1, %9[%10 : i32] : vector<2xi8>
    %12 = llvm.lshr %arg1, %6  : vector<2xi8>
    %13 = llvm.add %12, %arg0  : vector<2xi8>
    %14 = llvm.shl %13, %11  : vector<2xi8>
    llvm.return %14 : vector<2xi8>
  }]

def lshr_add_shl_v2i8_nonuniform_before := [llvmfunc|
  llvm.func @lshr_add_shl_v2i8_nonuniform(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[5, 6]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.lshr %arg1, %0  : vector<2xi8>
    %2 = llvm.add %1, %arg0  : vector<2xi8>
    %3 = llvm.shl %2, %0  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def lshr_add_and_shl_before := [llvmfunc|
  llvm.func @lshr_add_and_shl(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(127 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.add %arg1, %3  : i32
    %5 = llvm.shl %4, %0  : i32
    llvm.return %5 : i32
  }]

def lshr_add_and_shl_v2i32_before := [llvmfunc|
  llvm.func @lshr_add_and_shl_v2i32(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<127> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.lshr %arg0, %0  : vector<2xi32>
    %3 = llvm.and %2, %1  : vector<2xi32>
    %4 = llvm.add %arg1, %3  : vector<2xi32>
    %5 = llvm.shl %4, %0  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

def lshr_add_and_shl_v2i32_undef_before := [llvmfunc|
  llvm.func @lshr_add_and_shl_v2i32_undef(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(dense<127> : vector<2xi32>) : vector<2xi32>
    %8 = llvm.mlir.undef : vector<2xi32>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<2xi32>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %1, %10[%11 : i32] : vector<2xi32>
    %13 = llvm.lshr %arg0, %6  : vector<2xi32>
    %14 = llvm.and %13, %7  : vector<2xi32>
    %15 = llvm.add %arg1, %14  : vector<2xi32>
    %16 = llvm.shl %15, %12  : vector<2xi32>
    llvm.return %16 : vector<2xi32>
  }]

def lshr_add_and_shl_v2i32_nonuniform_before := [llvmfunc|
  llvm.func @lshr_add_and_shl_v2i32_nonuniform(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[5, 6]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[127, 255]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.lshr %arg0, %0  : vector<2xi32>
    %3 = llvm.and %2, %1  : vector<2xi32>
    %4 = llvm.add %arg1, %3  : vector<2xi32>
    %5 = llvm.shl %4, %0  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

def shl_add_and_lshr_before := [llvmfunc|
  llvm.func @shl_add_and_lshr(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.add %3, %arg1  : i32
    %5 = llvm.shl %4, %0  : i32
    llvm.return %5 : i32
  }]

def shl_add_and_lshr_v2i32_before := [llvmfunc|
  llvm.func @shl_add_and_lshr_v2i32(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.lshr %arg0, %0  : vector<2xi32>
    %3 = llvm.and %2, %1  : vector<2xi32>
    %4 = llvm.add %3, %arg1  : vector<2xi32>
    %5 = llvm.shl %4, %0  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

def shl_add_and_lshr_v2i32_undef_before := [llvmfunc|
  llvm.func @shl_add_and_lshr_v2i32_undef(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(8 : i32) : i32
    %8 = llvm.mlir.undef : vector<2xi32>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %7, %8[%9 : i32] : vector<2xi32>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<2xi32>
    %13 = llvm.lshr %arg0, %6  : vector<2xi32>
    %14 = llvm.and %13, %12  : vector<2xi32>
    %15 = llvm.add %14, %arg1  : vector<2xi32>
    %16 = llvm.shl %15, %6  : vector<2xi32>
    llvm.return %16 : vector<2xi32>
  }]

def shl_add_and_lshr_v2i32_nonuniform_before := [llvmfunc|
  llvm.func @shl_add_and_lshr_v2i32_nonuniform(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[4, 5]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[8, 9]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.lshr %arg0, %0  : vector<2xi32>
    %3 = llvm.and %2, %1  : vector<2xi32>
    %4 = llvm.add %3, %arg1  : vector<2xi32>
    %5 = llvm.shl %4, %0  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

def test_FoldShiftByConstant_CreateSHL_before := [llvmfunc|
  llvm.func @test_FoldShiftByConstant_CreateSHL(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[0, -1, 0, -1]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<5> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mul %arg0, %0  : vector<4xi32>
    %3 = llvm.shl %2, %1  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }]

def test_FoldShiftByConstant_CreateSHL2_before := [llvmfunc|
  llvm.func @test_FoldShiftByConstant_CreateSHL2(%arg0: vector<8xi16>) -> vector<8xi16> {
    %0 = llvm.mlir.constant(dense<[0, -1, 0, -1, 0, -1, 0, -1]> : vector<8xi16>) : vector<8xi16>
    %1 = llvm.mlir.constant(dense<5> : vector<8xi16>) : vector<8xi16>
    %2 = llvm.mul %arg0, %0  : vector<8xi16>
    %3 = llvm.shl %2, %1  : vector<8xi16>
    llvm.return %3 : vector<8xi16>
  }]

def test_FoldShiftByConstant_CreateAnd_before := [llvmfunc|
  llvm.func @test_FoldShiftByConstant_CreateAnd(%arg0: vector<16xi8>) -> vector<16xi8> {
    %0 = llvm.mlir.constant(dense<5> : vector<16xi8>) : vector<16xi8>
    %1 = llvm.ashr %arg0, %0  : vector<16xi8>
    %2 = llvm.add %arg0, %1  : vector<16xi8>
    %3 = llvm.shl %2, %0  : vector<16xi8>
    llvm.return %3 : vector<16xi8>
  }]

def lshr_add_combined := [llvmfunc|
  llvm.func @lshr_add(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.mlir.constant(-32 : i8) : i8
    %3 = llvm.srem %arg0, %0  : i8
    %4 = llvm.shl %3, %1  : i8
    %5 = llvm.add %4, %arg1  : i8
    %6 = llvm.and %5, %2  : i8
    llvm.return %6 : i8
  }]

theorem inst_combine_lshr_add   : lshr_add_before  ⊑  lshr_add_combined := by
  unfold lshr_add_before lshr_add_combined
  simp_alive_peephole
  sorry
def lshr_add_commute_splat_combined := [llvmfunc|
  llvm.func @lshr_add_commute_splat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<5> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<-32> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.srem %arg0, %0  : vector<2xi8>
    %4 = llvm.shl %3, %1  : vector<2xi8>
    %5 = llvm.add %4, %arg1  : vector<2xi8>
    %6 = llvm.and %5, %2  : vector<2xi8>
    llvm.return %6 : vector<2xi8>
  }]

theorem inst_combine_lshr_add_commute_splat   : lshr_add_commute_splat_before  ⊑  lshr_add_commute_splat_combined := by
  unfold lshr_add_commute_splat_before lshr_add_commute_splat_combined
  simp_alive_peephole
  sorry
def lshr_sub_combined := [llvmfunc|
  llvm.func @lshr_sub(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.srem %arg0, %0  : i8
    %3 = llvm.lshr %arg1, %1  : i8
    %4 = llvm.sub %2, %3 overflow<nsw>  : i8
    %5 = llvm.shl %4, %1  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_lshr_sub   : lshr_sub_before  ⊑  lshr_sub_combined := by
  unfold lshr_sub_before lshr_sub_combined
  simp_alive_peephole
  sorry
def lshr_sub_commute_splat_combined := [llvmfunc|
  llvm.func @lshr_sub_commute_splat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<-8> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.srem %arg0, %0  : vector<2xi8>
    %4 = llvm.shl %3, %1  : vector<2xi8>
    %5 = llvm.sub %arg1, %4  : vector<2xi8>
    %6 = llvm.and %5, %2  : vector<2xi8>
    llvm.return %6 : vector<2xi8>
  }]

theorem inst_combine_lshr_sub_commute_splat   : lshr_sub_commute_splat_before  ⊑  lshr_sub_commute_splat_combined := by
  unfold lshr_sub_commute_splat_before lshr_sub_commute_splat_combined
  simp_alive_peephole
  sorry
def lshr_and_combined := [llvmfunc|
  llvm.func @lshr_and(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.srem %arg0, %0  : i8
    %3 = llvm.shl %2, %1  : i8
    %4 = llvm.and %3, %arg1  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_lshr_and   : lshr_and_before  ⊑  lshr_and_combined := by
  unfold lshr_and_before lshr_and_combined
  simp_alive_peephole
  sorry
def lshr_and_commute_splat_combined := [llvmfunc|
  llvm.func @lshr_and_commute_splat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<6> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.srem %arg0, %0  : vector<2xi8>
    %3 = llvm.shl %2, %1  : vector<2xi8>
    %4 = llvm.and %3, %arg1  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

theorem inst_combine_lshr_and_commute_splat   : lshr_and_commute_splat_before  ⊑  lshr_and_commute_splat_combined := by
  unfold lshr_and_commute_splat_before lshr_and_commute_splat_combined
  simp_alive_peephole
  sorry
def lshr_or_combined := [llvmfunc|
  llvm.func @lshr_or(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.mlir.constant(-16 : i8) : i8
    %3 = llvm.srem %arg0, %0  : i8
    %4 = llvm.shl %3, %1  : i8
    %5 = llvm.and %arg1, %2  : i8
    %6 = llvm.or %4, %5  : i8
    llvm.return %6 : i8
  }]

theorem inst_combine_lshr_or   : lshr_or_before  ⊑  lshr_or_combined := by
  unfold lshr_or_before lshr_or_combined
  simp_alive_peephole
  sorry
def lshr_or_commute_splat_combined := [llvmfunc|
  llvm.func @lshr_or_commute_splat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<4> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<-16> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.srem %arg0, %0  : vector<2xi8>
    %4 = llvm.shl %3, %1  : vector<2xi8>
    %5 = llvm.and %arg1, %2  : vector<2xi8>
    %6 = llvm.or %4, %5  : vector<2xi8>
    llvm.return %6 : vector<2xi8>
  }]

theorem inst_combine_lshr_or_commute_splat   : lshr_or_commute_splat_before  ⊑  lshr_or_commute_splat_combined := by
  unfold lshr_or_commute_splat_before lshr_or_commute_splat_combined
  simp_alive_peephole
  sorry
def lshr_xor_combined := [llvmfunc|
  llvm.func @lshr_xor(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.mlir.constant(-8 : i8) : i8
    %3 = llvm.srem %arg0, %0  : i8
    %4 = llvm.shl %3, %1  : i8
    %5 = llvm.and %arg1, %2  : i8
    %6 = llvm.xor %4, %5  : i8
    llvm.return %6 : i8
  }]

theorem inst_combine_lshr_xor   : lshr_xor_before  ⊑  lshr_xor_combined := by
  unfold lshr_xor_before lshr_xor_combined
  simp_alive_peephole
  sorry
def lshr_xor_commute_splat_combined := [llvmfunc|
  llvm.func @lshr_xor_commute_splat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<-8> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.srem %arg0, %0  : vector<2xi8>
    %4 = llvm.shl %3, %1  : vector<2xi8>
    %5 = llvm.and %arg1, %2  : vector<2xi8>
    %6 = llvm.xor %4, %5  : vector<2xi8>
    llvm.return %6 : vector<2xi8>
  }]

theorem inst_combine_lshr_xor_commute_splat   : lshr_xor_commute_splat_before  ⊑  lshr_xor_commute_splat_combined := by
  unfold lshr_xor_commute_splat_before lshr_xor_commute_splat_combined
  simp_alive_peephole
  sorry
def lshr_add_use1_combined := [llvmfunc|
  llvm.func @lshr_add_use1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.lshr %arg1, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.add %1, %arg0  : i8
    %3 = llvm.shl %2, %0  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_lshr_add_use1   : lshr_add_use1_before  ⊑  lshr_add_use1_combined := by
  unfold lshr_add_use1_before lshr_add_use1_combined
  simp_alive_peephole
  sorry
def lshr_add_use2_combined := [llvmfunc|
  llvm.func @lshr_add_use2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.lshr %arg1, %0  : i8
    %2 = llvm.add %1, %arg0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.shl %2, %0  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_lshr_add_use2   : lshr_add_use2_before  ⊑  lshr_add_use2_combined := by
  unfold lshr_add_use2_before lshr_add_use2_combined
  simp_alive_peephole
  sorry
def lshr_and_add_combined := [llvmfunc|
  llvm.func @lshr_and_add(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.mlir.constant(96 : i8) : i8
    %3 = llvm.srem %arg0, %0  : i8
    %4 = llvm.shl %3, %1  : i8
    %5 = llvm.and %arg1, %2  : i8
    %6 = llvm.add %5, %4  : i8
    llvm.return %6 : i8
  }]

theorem inst_combine_lshr_and_add   : lshr_and_add_before  ⊑  lshr_and_add_combined := by
  unfold lshr_and_add_before lshr_and_add_combined
  simp_alive_peephole
  sorry
def lshr_and_add_commute_splat_combined := [llvmfunc|
  llvm.func @lshr_and_add_commute_splat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<96> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.srem %arg0, %0  : vector<2xi8>
    %4 = llvm.shl %3, %1  : vector<2xi8>
    %5 = llvm.and %arg1, %2  : vector<2xi8>
    %6 = llvm.add %5, %4  : vector<2xi8>
    llvm.return %6 : vector<2xi8>
  }]

theorem inst_combine_lshr_and_add_commute_splat   : lshr_and_add_commute_splat_before  ⊑  lshr_and_add_commute_splat_combined := by
  unfold lshr_and_add_commute_splat_before lshr_and_add_commute_splat_combined
  simp_alive_peephole
  sorry
def lshr_and_sub_combined := [llvmfunc|
  llvm.func @lshr_and_sub(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.constant(13 : i8) : i8
    %3 = llvm.srem %arg0, %0  : i8
    %4 = llvm.lshr %arg1, %1  : i8
    %5 = llvm.and %4, %2  : i8
    %6 = llvm.sub %3, %5 overflow<nsw>  : i8
    %7 = llvm.shl %6, %1  : i8
    llvm.return %7 : i8
  }]

theorem inst_combine_lshr_and_sub   : lshr_and_sub_before  ⊑  lshr_and_sub_combined := by
  unfold lshr_and_sub_before lshr_and_sub_combined
  simp_alive_peephole
  sorry
def lshr_and_sub_commute_splat_combined := [llvmfunc|
  llvm.func @lshr_and_sub_commute_splat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<2> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<52> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.srem %arg0, %0  : vector<2xi8>
    %4 = llvm.shl %3, %1  : vector<2xi8>
    %5 = llvm.and %arg1, %2  : vector<2xi8>
    %6 = llvm.sub %5, %4  : vector<2xi8>
    llvm.return %6 : vector<2xi8>
  }]

theorem inst_combine_lshr_and_sub_commute_splat   : lshr_and_sub_commute_splat_before  ⊑  lshr_and_sub_commute_splat_combined := by
  unfold lshr_and_sub_commute_splat_before lshr_and_sub_commute_splat_combined
  simp_alive_peephole
  sorry
def lshr_and_and_combined := [llvmfunc|
  llvm.func @lshr_and_and(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.constant(52 : i8) : i8
    %3 = llvm.srem %arg0, %0  : i8
    %4 = llvm.shl %3, %1  : i8
    %5 = llvm.and %arg1, %2  : i8
    %6 = llvm.and %5, %4  : i8
    llvm.return %6 : i8
  }]

theorem inst_combine_lshr_and_and   : lshr_and_and_before  ⊑  lshr_and_and_combined := by
  unfold lshr_and_and_before lshr_and_and_combined
  simp_alive_peephole
  sorry
def lshr_and_and_commute_splat_combined := [llvmfunc|
  llvm.func @lshr_and_and_commute_splat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<2> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<52> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.srem %arg0, %0  : vector<2xi8>
    %4 = llvm.shl %3, %1  : vector<2xi8>
    %5 = llvm.and %arg1, %2  : vector<2xi8>
    %6 = llvm.and %5, %4  : vector<2xi8>
    llvm.return %6 : vector<2xi8>
  }]

theorem inst_combine_lshr_and_and_commute_splat   : lshr_and_and_commute_splat_before  ⊑  lshr_and_and_commute_splat_combined := by
  unfold lshr_and_and_commute_splat_before lshr_and_and_commute_splat_combined
  simp_alive_peephole
  sorry
def lshr_and_or_combined := [llvmfunc|
  llvm.func @lshr_and_or(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.constant(52 : i8) : i8
    %3 = llvm.srem %arg0, %0  : i8
    %4 = llvm.shl %3, %1  : i8
    %5 = llvm.and %arg1, %2  : i8
    %6 = llvm.or %5, %4  : i8
    llvm.return %6 : i8
  }]

theorem inst_combine_lshr_and_or   : lshr_and_or_before  ⊑  lshr_and_or_combined := by
  unfold lshr_and_or_before lshr_and_or_combined
  simp_alive_peephole
  sorry
def lshr_and_or_disjoint_combined := [llvmfunc|
  llvm.func @lshr_and_or_disjoint(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.constant(52 : i8) : i8
    %3 = llvm.srem %arg0, %0  : i8
    %4 = llvm.shl %3, %1  : i8
    %5 = llvm.and %arg1, %2  : i8
    %6 = llvm.or %5, %4  : i8
    llvm.return %6 : i8
  }]

theorem inst_combine_lshr_and_or_disjoint   : lshr_and_or_disjoint_before  ⊑  lshr_and_or_disjoint_combined := by
  unfold lshr_and_or_disjoint_before lshr_and_or_disjoint_combined
  simp_alive_peephole
  sorry
def ashr_and_or_disjoint_combined := [llvmfunc|
  llvm.func @ashr_and_or_disjoint(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.constant(52 : i8) : i8
    %3 = llvm.srem %arg0, %0  : i8
    %4 = llvm.shl %3, %1  : i8
    %5 = llvm.and %arg1, %2  : i8
    %6 = llvm.or %5, %4  : i8
    llvm.return %6 : i8
  }]

theorem inst_combine_ashr_and_or_disjoint   : ashr_and_or_disjoint_before  ⊑  ashr_and_or_disjoint_combined := by
  unfold ashr_and_or_disjoint_before ashr_and_or_disjoint_combined
  simp_alive_peephole
  sorry
def lshr_and_or_commute_splat_combined := [llvmfunc|
  llvm.func @lshr_and_or_commute_splat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<2> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<52> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.srem %arg0, %0  : vector<2xi8>
    %4 = llvm.shl %3, %1  : vector<2xi8>
    %5 = llvm.and %arg1, %2  : vector<2xi8>
    %6 = llvm.or %5, %4  : vector<2xi8>
    llvm.return %6 : vector<2xi8>
  }]

theorem inst_combine_lshr_and_or_commute_splat   : lshr_and_or_commute_splat_before  ⊑  lshr_and_or_commute_splat_combined := by
  unfold lshr_and_or_commute_splat_before lshr_and_or_commute_splat_combined
  simp_alive_peephole
  sorry
def lshr_and_xor_combined := [llvmfunc|
  llvm.func @lshr_and_xor(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.constant(52 : i8) : i8
    %3 = llvm.srem %arg0, %0  : i8
    %4 = llvm.shl %3, %1  : i8
    %5 = llvm.and %arg1, %2  : i8
    %6 = llvm.xor %5, %4  : i8
    llvm.return %6 : i8
  }]

theorem inst_combine_lshr_and_xor   : lshr_and_xor_before  ⊑  lshr_and_xor_combined := by
  unfold lshr_and_xor_before lshr_and_xor_combined
  simp_alive_peephole
  sorry
def lshr_and_xor_commute_splat_combined := [llvmfunc|
  llvm.func @lshr_and_xor_commute_splat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<2> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<52> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.srem %arg0, %0  : vector<2xi8>
    %4 = llvm.shl %3, %1  : vector<2xi8>
    %5 = llvm.and %arg1, %2  : vector<2xi8>
    %6 = llvm.xor %5, %4  : vector<2xi8>
    llvm.return %6 : vector<2xi8>
  }]

theorem inst_combine_lshr_and_xor_commute_splat   : lshr_and_xor_commute_splat_before  ⊑  lshr_and_xor_commute_splat_combined := by
  unfold lshr_and_xor_commute_splat_before lshr_and_xor_commute_splat_combined
  simp_alive_peephole
  sorry
def lshr_and_add_use1_combined := [llvmfunc|
  llvm.func @lshr_and_add_use1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(12 : i8) : i8
    %2 = llvm.lshr %arg1, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.and %2, %1  : i8
    %4 = llvm.add %3, %arg0  : i8
    %5 = llvm.shl %4, %0  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_lshr_and_add_use1   : lshr_and_add_use1_before  ⊑  lshr_and_add_use1_combined := by
  unfold lshr_and_add_use1_before lshr_and_add_use1_combined
  simp_alive_peephole
  sorry
def lshr_and_add_use2_combined := [llvmfunc|
  llvm.func @lshr_and_add_use2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(12 : i8) : i8
    %2 = llvm.lshr %arg1, %0  : i8
    %3 = llvm.and %2, %1  : i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.add %3, %arg0  : i8
    %5 = llvm.shl %4, %0  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_lshr_and_add_use2   : lshr_and_add_use2_before  ⊑  lshr_and_add_use2_combined := by
  unfold lshr_and_add_use2_before lshr_and_add_use2_combined
  simp_alive_peephole
  sorry
def lshr_and_add_use3_combined := [llvmfunc|
  llvm.func @lshr_and_add_use3(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(12 : i8) : i8
    %2 = llvm.lshr %arg1, %0  : i8
    %3 = llvm.and %2, %1  : i8
    %4 = llvm.add %3, %arg0  : i8
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.shl %4, %0  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_lshr_and_add_use3   : lshr_and_add_use3_before  ⊑  lshr_and_add_use3_combined := by
  unfold lshr_and_add_use3_before lshr_and_add_use3_combined
  simp_alive_peephole
  sorry
def lshr_and_add_use4_combined := [llvmfunc|
  llvm.func @lshr_and_add_use4(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(12 : i8) : i8
    %2 = llvm.lshr %arg1, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.and %2, %1  : i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.add %3, %arg0  : i8
    %5 = llvm.shl %4, %0  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_lshr_and_add_use4   : lshr_and_add_use4_before  ⊑  lshr_and_add_use4_combined := by
  unfold lshr_and_add_use4_before lshr_and_add_use4_combined
  simp_alive_peephole
  sorry
def lshr_and_add_use5_combined := [llvmfunc|
  llvm.func @lshr_and_add_use5(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(12 : i8) : i8
    %2 = llvm.lshr %arg1, %0  : i8
    %3 = llvm.and %2, %1  : i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.add %3, %arg0  : i8
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.shl %4, %0  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_lshr_and_add_use5   : lshr_and_add_use5_before  ⊑  lshr_and_add_use5_combined := by
  unfold lshr_and_add_use5_before lshr_and_add_use5_combined
  simp_alive_peephole
  sorry
def lshr_and_add_use6_combined := [llvmfunc|
  llvm.func @lshr_and_add_use6(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(12 : i8) : i8
    %2 = llvm.lshr %arg1, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.and %2, %1  : i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.add %3, %arg0  : i8
    %5 = llvm.shl %4, %0  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_lshr_and_add_use6   : lshr_and_add_use6_before  ⊑  lshr_and_add_use6_combined := by
  unfold lshr_and_add_use6_before lshr_and_add_use6_combined
  simp_alive_peephole
  sorry
def lshr_add_shl_v2i8_undef_combined := [llvmfunc|
  llvm.func @lshr_add_shl_v2i8_undef(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.undef : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.undef : vector<2xi8>
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<2xi8>
    %10 = llvm.mlir.constant(1 : i32) : i32
    %11 = llvm.insertelement %1, %9[%10 : i32] : vector<2xi8>
    %12 = llvm.lshr %arg1, %6  : vector<2xi8>
    %13 = llvm.add %12, %arg0  : vector<2xi8>
    %14 = llvm.shl %13, %11  : vector<2xi8>
    llvm.return %14 : vector<2xi8>
  }]

theorem inst_combine_lshr_add_shl_v2i8_undef   : lshr_add_shl_v2i8_undef_before  ⊑  lshr_add_shl_v2i8_undef_combined := by
  unfold lshr_add_shl_v2i8_undef_before lshr_add_shl_v2i8_undef_combined
  simp_alive_peephole
  sorry
def lshr_add_shl_v2i8_nonuniform_combined := [llvmfunc|
  llvm.func @lshr_add_shl_v2i8_nonuniform(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[5, 6]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.lshr %arg1, %0  : vector<2xi8>
    %2 = llvm.add %1, %arg0  : vector<2xi8>
    %3 = llvm.shl %2, %0  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_lshr_add_shl_v2i8_nonuniform   : lshr_add_shl_v2i8_nonuniform_before  ⊑  lshr_add_shl_v2i8_nonuniform_combined := by
  unfold lshr_add_shl_v2i8_nonuniform_before lshr_add_shl_v2i8_nonuniform_combined
  simp_alive_peephole
  sorry
def lshr_add_and_shl_combined := [llvmfunc|
  llvm.func @lshr_add_and_shl(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(4064 : i32) : i32
    %2 = llvm.shl %arg1, %0  : i32
    %3 = llvm.and %arg0, %1  : i32
    %4 = llvm.add %3, %2  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_lshr_add_and_shl   : lshr_add_and_shl_before  ⊑  lshr_add_and_shl_combined := by
  unfold lshr_add_and_shl_before lshr_add_and_shl_combined
  simp_alive_peephole
  sorry
def lshr_add_and_shl_v2i32_combined := [llvmfunc|
  llvm.func @lshr_add_and_shl_v2i32(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<4064> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.shl %arg1, %0  : vector<2xi32>
    %3 = llvm.and %arg0, %1  : vector<2xi32>
    %4 = llvm.add %3, %2  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

theorem inst_combine_lshr_add_and_shl_v2i32   : lshr_add_and_shl_v2i32_before  ⊑  lshr_add_and_shl_v2i32_combined := by
  unfold lshr_add_and_shl_v2i32_before lshr_add_and_shl_v2i32_combined
  simp_alive_peephole
  sorry
def lshr_add_and_shl_v2i32_undef_combined := [llvmfunc|
  llvm.func @lshr_add_and_shl_v2i32_undef(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(dense<127> : vector<2xi32>) : vector<2xi32>
    %8 = llvm.mlir.undef : vector<2xi32>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<2xi32>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %1, %10[%11 : i32] : vector<2xi32>
    %13 = llvm.lshr %arg0, %6  : vector<2xi32>
    %14 = llvm.and %13, %7  : vector<2xi32>
    %15 = llvm.add %14, %arg1  : vector<2xi32>
    %16 = llvm.shl %15, %12  : vector<2xi32>
    llvm.return %16 : vector<2xi32>
  }]

theorem inst_combine_lshr_add_and_shl_v2i32_undef   : lshr_add_and_shl_v2i32_undef_before  ⊑  lshr_add_and_shl_v2i32_undef_combined := by
  unfold lshr_add_and_shl_v2i32_undef_before lshr_add_and_shl_v2i32_undef_combined
  simp_alive_peephole
  sorry
def lshr_add_and_shl_v2i32_nonuniform_combined := [llvmfunc|
  llvm.func @lshr_add_and_shl_v2i32_nonuniform(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[5, 6]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[127, 255]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.lshr %arg0, %0  : vector<2xi32>
    %3 = llvm.and %2, %1  : vector<2xi32>
    %4 = llvm.add %3, %arg1  : vector<2xi32>
    %5 = llvm.shl %4, %0  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

theorem inst_combine_lshr_add_and_shl_v2i32_nonuniform   : lshr_add_and_shl_v2i32_nonuniform_before  ⊑  lshr_add_and_shl_v2i32_nonuniform_combined := by
  unfold lshr_add_and_shl_v2i32_nonuniform_before lshr_add_and_shl_v2i32_nonuniform_combined
  simp_alive_peephole
  sorry
def shl_add_and_lshr_combined := [llvmfunc|
  llvm.func @shl_add_and_lshr(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.shl %arg1, %0  : i32
    %3 = llvm.and %arg0, %1  : i32
    %4 = llvm.add %3, %2  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_shl_add_and_lshr   : shl_add_and_lshr_before  ⊑  shl_add_and_lshr_combined := by
  unfold shl_add_and_lshr_before shl_add_and_lshr_combined
  simp_alive_peephole
  sorry
def shl_add_and_lshr_v2i32_combined := [llvmfunc|
  llvm.func @shl_add_and_lshr_v2i32(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<128> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.shl %arg1, %0  : vector<2xi32>
    %3 = llvm.and %arg0, %1  : vector<2xi32>
    %4 = llvm.add %3, %2  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

theorem inst_combine_shl_add_and_lshr_v2i32   : shl_add_and_lshr_v2i32_before  ⊑  shl_add_and_lshr_v2i32_combined := by
  unfold shl_add_and_lshr_v2i32_before shl_add_and_lshr_v2i32_combined
  simp_alive_peephole
  sorry
def shl_add_and_lshr_v2i32_undef_combined := [llvmfunc|
  llvm.func @shl_add_and_lshr_v2i32_undef(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(8 : i32) : i32
    %8 = llvm.mlir.undef : vector<2xi32>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %7, %8[%9 : i32] : vector<2xi32>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<2xi32>
    %13 = llvm.lshr %arg0, %6  : vector<2xi32>
    %14 = llvm.and %13, %12  : vector<2xi32>
    %15 = llvm.add %14, %arg1  : vector<2xi32>
    %16 = llvm.shl %15, %6  : vector<2xi32>
    llvm.return %16 : vector<2xi32>
  }]

theorem inst_combine_shl_add_and_lshr_v2i32_undef   : shl_add_and_lshr_v2i32_undef_before  ⊑  shl_add_and_lshr_v2i32_undef_combined := by
  unfold shl_add_and_lshr_v2i32_undef_before shl_add_and_lshr_v2i32_undef_combined
  simp_alive_peephole
  sorry
def shl_add_and_lshr_v2i32_nonuniform_combined := [llvmfunc|
  llvm.func @shl_add_and_lshr_v2i32_nonuniform(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[4, 5]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[8, 9]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.lshr %arg0, %0  : vector<2xi32>
    %3 = llvm.and %2, %1  : vector<2xi32>
    %4 = llvm.add %3, %arg1  : vector<2xi32>
    %5 = llvm.shl %4, %0  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

theorem inst_combine_shl_add_and_lshr_v2i32_nonuniform   : shl_add_and_lshr_v2i32_nonuniform_before  ⊑  shl_add_and_lshr_v2i32_nonuniform_combined := by
  unfold shl_add_and_lshr_v2i32_nonuniform_before shl_add_and_lshr_v2i32_nonuniform_combined
  simp_alive_peephole
  sorry
def test_FoldShiftByConstant_CreateSHL_combined := [llvmfunc|
  llvm.func @test_FoldShiftByConstant_CreateSHL(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[0, -32, 0, -32]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mul %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_test_FoldShiftByConstant_CreateSHL   : test_FoldShiftByConstant_CreateSHL_before  ⊑  test_FoldShiftByConstant_CreateSHL_combined := by
  unfold test_FoldShiftByConstant_CreateSHL_before test_FoldShiftByConstant_CreateSHL_combined
  simp_alive_peephole
  sorry
def test_FoldShiftByConstant_CreateSHL2_combined := [llvmfunc|
  llvm.func @test_FoldShiftByConstant_CreateSHL2(%arg0: vector<8xi16>) -> vector<8xi16> {
    %0 = llvm.mlir.constant(dense<[0, -32, 0, -32, 0, -32, 0, -32]> : vector<8xi16>) : vector<8xi16>
    %1 = llvm.mul %arg0, %0  : vector<8xi16>
    llvm.return %1 : vector<8xi16>
  }]

theorem inst_combine_test_FoldShiftByConstant_CreateSHL2   : test_FoldShiftByConstant_CreateSHL2_before  ⊑  test_FoldShiftByConstant_CreateSHL2_combined := by
  unfold test_FoldShiftByConstant_CreateSHL2_before test_FoldShiftByConstant_CreateSHL2_combined
  simp_alive_peephole
  sorry
def test_FoldShiftByConstant_CreateAnd_combined := [llvmfunc|
  llvm.func @test_FoldShiftByConstant_CreateAnd(%arg0: vector<16xi8>) -> vector<16xi8> {
    %0 = llvm.mlir.constant(dense<33> : vector<16xi8>) : vector<16xi8>
    %1 = llvm.mlir.constant(dense<-32> : vector<16xi8>) : vector<16xi8>
    %2 = llvm.mul %arg0, %0  : vector<16xi8>
    %3 = llvm.and %2, %1  : vector<16xi8>
    llvm.return %3 : vector<16xi8>
  }]

theorem inst_combine_test_FoldShiftByConstant_CreateAnd   : test_FoldShiftByConstant_CreateAnd_before  ⊑  test_FoldShiftByConstant_CreateAnd_combined := by
  unfold test_FoldShiftByConstant_CreateAnd_before test_FoldShiftByConstant_CreateAnd_combined
  simp_alive_peephole
  sorry
