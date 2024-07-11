import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  minmax-intrinsics
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def umin_known_bits_before := [llvmfunc|
  llvm.func @umin_known_bits(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.intr.umin(%2, %arg1)  : (i8, i8) -> i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }]

def umax_known_bits_before := [llvmfunc|
  llvm.func @umax_known_bits(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.or %arg0, %0  : i8
    %2 = llvm.intr.umax(%1, %arg1)  : (i8, i8) -> i8
    %3 = llvm.and %2, %0  : i8
    llvm.return %3 : i8
  }]

def smin_known_bits_before := [llvmfunc|
  llvm.func @smin_known_bits(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.or %arg0, %0  : i8
    %2 = llvm.intr.smin(%1, %arg1)  : (i8, i8) -> i8
    %3 = llvm.and %2, %0  : i8
    llvm.return %3 : i8
  }]

def smax_known_bits_before := [llvmfunc|
  llvm.func @smax_known_bits(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.intr.smax(%2, %arg1)  : (i8, i8) -> i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }]

def smax_sext_before := [llvmfunc|
  llvm.func @smax_sext(%arg0: i5, %arg1: i5) -> i8 {
    %0 = llvm.sext %arg0 : i5 to i8
    %1 = llvm.sext %arg1 : i5 to i8
    %2 = llvm.intr.smax(%0, %1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

def smin_sext_before := [llvmfunc|
  llvm.func @smin_sext(%arg0: i5, %arg1: i5) -> i8 {
    %0 = llvm.sext %arg0 : i5 to i8
    %1 = llvm.sext %arg1 : i5 to i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.intr.smin(%0, %1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

def umax_sext_before := [llvmfunc|
  llvm.func @umax_sext(%arg0: i5, %arg1: i5) -> i8 {
    %0 = llvm.sext %arg0 : i5 to i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.sext %arg1 : i5 to i8
    %2 = llvm.intr.umax(%0, %1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

def umin_sext_before := [llvmfunc|
  llvm.func @umin_sext(%arg0: vector<3xi5>, %arg1: vector<3xi5>) -> vector<3xi8> {
    %0 = llvm.sext %arg0 : vector<3xi5> to vector<3xi8>
    %1 = llvm.sext %arg1 : vector<3xi5> to vector<3xi8>
    %2 = llvm.intr.umin(%0, %1)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %2 : vector<3xi8>
  }]

def smax_zext_before := [llvmfunc|
  llvm.func @smax_zext(%arg0: i5, %arg1: i5) -> i8 {
    %0 = llvm.zext %arg0 : i5 to i8
    %1 = llvm.zext %arg1 : i5 to i8
    %2 = llvm.intr.smax(%0, %1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

def smin_zext_before := [llvmfunc|
  llvm.func @smin_zext(%arg0: i5, %arg1: i5) -> i8 {
    %0 = llvm.zext %arg0 : i5 to i8
    %1 = llvm.zext %arg1 : i5 to i8
    %2 = llvm.intr.smin(%0, %1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

def umax_zext_before := [llvmfunc|
  llvm.func @umax_zext(%arg0: i5, %arg1: i5) -> i8 {
    %0 = llvm.zext %arg0 : i5 to i8
    %1 = llvm.zext %arg1 : i5 to i8
    %2 = llvm.intr.umax(%0, %1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

def umin_zext_before := [llvmfunc|
  llvm.func @umin_zext(%arg0: i5, %arg1: i5) -> i8 {
    %0 = llvm.zext %arg0 : i5 to i8
    %1 = llvm.zext %arg1 : i5 to i8
    %2 = llvm.intr.umin(%0, %1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

def umin_zext_types_before := [llvmfunc|
  llvm.func @umin_zext_types(%arg0: i6, %arg1: i5) -> i8 {
    %0 = llvm.zext %arg0 : i6 to i8
    %1 = llvm.zext %arg1 : i5 to i8
    %2 = llvm.intr.umin(%0, %1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

def umin_ext_before := [llvmfunc|
  llvm.func @umin_ext(%arg0: i5, %arg1: i5) -> i8 {
    %0 = llvm.sext %arg0 : i5 to i8
    %1 = llvm.zext %arg1 : i5 to i8
    %2 = llvm.intr.umin(%0, %1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

def umin_zext_uses_before := [llvmfunc|
  llvm.func @umin_zext_uses(%arg0: i5, %arg1: i5) -> i8 {
    %0 = llvm.zext %arg0 : i5 to i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.zext %arg1 : i5 to i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.intr.umin(%0, %1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

def smax_sext_constant_before := [llvmfunc|
  llvm.func @smax_sext_constant(%arg0: i5) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.sext %arg0 : i5 to i8
    %2 = llvm.intr.smax(%1, %0)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

def smax_sext_constant_big_before := [llvmfunc|
  llvm.func @smax_sext_constant_big(%arg0: i5) -> i8 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.sext %arg0 : i5 to i8
    %2 = llvm.intr.smax(%1, %0)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

def smax_zext_constant_before := [llvmfunc|
  llvm.func @smax_zext_constant(%arg0: i5) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.zext %arg0 : i5 to i8
    %2 = llvm.intr.smax(%1, %0)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

def smin_sext_constant_before := [llvmfunc|
  llvm.func @smin_sext_constant(%arg0: vector<3xi5>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[7, 15, -16]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.sext %arg0 : vector<3xi5> to vector<3xi8>
    %2 = llvm.intr.smin(%1, %0)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %2 : vector<3xi8>
  }]

def smin_zext_constant_before := [llvmfunc|
  llvm.func @smin_zext_constant(%arg0: i5) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.zext %arg0 : i5 to i8
    %2 = llvm.intr.smin(%1, %0)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

def umax_sext_constant_before := [llvmfunc|
  llvm.func @umax_sext_constant(%arg0: i5) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.sext %arg0 : i5 to i8
    %2 = llvm.intr.umax(%1, %0)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

def umax_sext_constant_big_before := [llvmfunc|
  llvm.func @umax_sext_constant_big(%arg0: i5) -> i8 {
    %0 = llvm.mlir.constant(126 : i8) : i8
    %1 = llvm.sext %arg0 : i5 to i8
    %2 = llvm.intr.umax(%1, %0)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

def umax_zext_constant_before := [llvmfunc|
  llvm.func @umax_zext_constant(%arg0: vector<3xi5>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[7, 15, 31]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.zext %arg0 : vector<3xi5> to vector<3xi8>
    %2 = llvm.intr.umax(%1, %0)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %2 : vector<3xi8>
  }]

def umax_zext_constant_big_before := [llvmfunc|
  llvm.func @umax_zext_constant_big(%arg0: i5) -> i8 {
    %0 = llvm.mlir.constant(126 : i8) : i8
    %1 = llvm.zext %arg0 : i5 to i8
    %2 = llvm.intr.umax(%1, %0)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

def umin_sext_constant_before := [llvmfunc|
  llvm.func @umin_sext_constant(%arg0: i5) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.sext %arg0 : i5 to i8
    %2 = llvm.intr.umin(%1, %0)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

def umin_sext_constant_big_before := [llvmfunc|
  llvm.func @umin_sext_constant_big(%arg0: i5) -> i8 {
    %0 = llvm.mlir.constant(126 : i8) : i8
    %1 = llvm.sext %arg0 : i5 to i8
    %2 = llvm.intr.umin(%1, %0)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

def umin_zext_constant_before := [llvmfunc|
  llvm.func @umin_zext_constant(%arg0: i5) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.zext %arg0 : i5 to i8
    %2 = llvm.intr.umin(%1, %0)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

def umin_zext_constant_big_before := [llvmfunc|
  llvm.func @umin_zext_constant_big(%arg0: i5) -> i8 {
    %0 = llvm.mlir.constant(126 : i8) : i8
    %1 = llvm.zext %arg0 : i5 to i8
    %2 = llvm.intr.umin(%1, %0)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

def umin_zext_constant_uses_before := [llvmfunc|
  llvm.func @umin_zext_constant_uses(%arg0: i5) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.zext %arg0 : i5 to i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.intr.umin(%1, %0)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

def smax_of_nots_before := [llvmfunc|
  llvm.func @smax_of_nots(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.intr.smax(%1, %2)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def smin_of_nots_before := [llvmfunc|
  llvm.func @smin_of_nots(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.mlir.undef : vector<3xi8>
    %10 = llvm.mlir.constant(0 : i32) : i32
    %11 = llvm.insertelement %0, %9[%10 : i32] : vector<3xi8>
    %12 = llvm.mlir.constant(1 : i32) : i32
    %13 = llvm.insertelement %0, %11[%12 : i32] : vector<3xi8>
    %14 = llvm.mlir.constant(2 : i32) : i32
    %15 = llvm.insertelement %1, %13[%14 : i32] : vector<3xi8>
    %16 = llvm.xor %arg0, %8  : vector<3xi8>
    %17 = llvm.xor %arg1, %15  : vector<3xi8>
    %18 = llvm.intr.smin(%16, %17)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %18 : vector<3xi8>
  }]

def umax_of_nots_before := [llvmfunc|
  llvm.func @umax_of_nots(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.intr.umax(%1, %2)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def umin_of_nots_before := [llvmfunc|
  llvm.func @umin_of_nots(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.intr.umin(%1, %2)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def umin_of_nots_uses_before := [llvmfunc|
  llvm.func @umin_of_nots_uses(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.xor %arg1, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.intr.umin(%1, %2)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def smax_of_not_and_const_before := [llvmfunc|
  llvm.func @smax_of_not_and_const(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(42 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.intr.smax(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def smin_of_not_and_const_before := [llvmfunc|
  llvm.func @smin_of_not_and_const(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.mlir.constant(43 : i8) : i8
    %10 = llvm.mlir.constant(42 : i8) : i8
    %11 = llvm.mlir.undef : vector<3xi8>
    %12 = llvm.mlir.constant(0 : i32) : i32
    %13 = llvm.insertelement %10, %11[%12 : i32] : vector<3xi8>
    %14 = llvm.mlir.constant(1 : i32) : i32
    %15 = llvm.insertelement %0, %13[%14 : i32] : vector<3xi8>
    %16 = llvm.mlir.constant(2 : i32) : i32
    %17 = llvm.insertelement %9, %15[%16 : i32] : vector<3xi8>
    %18 = llvm.xor %arg0, %8  : vector<3xi8>
    %19 = llvm.intr.smin(%17, %18)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %19 : vector<3xi8>
  }]

def umax_of_not_and_const_before := [llvmfunc|
  llvm.func @umax_of_not_and_const(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(44 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.intr.umax(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def umin_of_not_and_const_before := [llvmfunc|
  llvm.func @umin_of_not_and_const(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(-45 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.intr.umin(%1, %2)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def umin_of_not_and_smax_before := [llvmfunc|
  llvm.func @umin_of_not_and_smax(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.xor %arg2, %0  : i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.intr.smax(%2, %3)  : (i8, i8) -> i8
    %5 = llvm.intr.umin(%4, %1)  : (i8, i8) -> i8
    llvm.return %5 : i8
  }]

def smin_of_umax_and_not_before := [llvmfunc|
  llvm.func @smin_of_umax_and_not(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.xor %arg2, %0  : i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.intr.umax(%2, %3)  : (i8, i8) -> i8
    %5 = llvm.intr.smin(%1, %4)  : (i8, i8) -> i8
    llvm.return %5 : i8
  }]

def umin_of_not_and_nontrivial_const_before := [llvmfunc|
  llvm.func @umin_of_not_and_nontrivial_const(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.addressof @umin_of_not_and_nontrivial_const : !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.intr.umin(%2, %3)  : (i8, i8) -> i8
    llvm.return %4 : i8
  }]

def umin_of_not_and_const_uses_before := [llvmfunc|
  llvm.func @umin_of_not_and_const_uses(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(-45 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.intr.umin(%1, %2)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def not_smax_of_nots_before := [llvmfunc|
  llvm.func @not_smax_of_nots(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.xor %arg1, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.intr.smax(%1, %2)  : (i8, i8) -> i8
    %4 = llvm.xor %3, %0  : i8
    llvm.return %4 : i8
  }]

def not_smin_of_nots_before := [llvmfunc|
  llvm.func @not_smin_of_nots(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.xor %arg1, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.intr.smin(%1, %2)  : (i8, i8) -> i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.xor %3, %0  : i8
    llvm.return %4 : i8
  }]

def not_umax_of_not_before := [llvmfunc|
  llvm.func @not_umax_of_not(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.intr.umax(%1, %arg1)  : (i8, i8) -> i8
    %3 = llvm.xor %2, %0  : i8
    llvm.return %3 : i8
  }]

def not_umin_of_not_before := [llvmfunc|
  llvm.func @not_umin_of_not(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.intr.umin(%1, %arg1)  : (i8, i8) -> i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.xor %2, %0  : i8
    llvm.return %3 : i8
  }]

def not_umin_of_not_constant_op_before := [llvmfunc|
  llvm.func @not_umin_of_not_constant_op(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(42 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.intr.umin(%2, %1)  : (i8, i8) -> i8
    %4 = llvm.xor %3, %0  : i8
    llvm.return %4 : i8
  }]

def smax_negation_before := [llvmfunc|
  llvm.func @smax_negation(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.sub %arg0, %arg1  : i8
    %1 = llvm.sub %arg1, %arg0  : i8
    %2 = llvm.intr.smax(%0, %1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

def smax_negation_nsw_before := [llvmfunc|
  llvm.func @smax_negation_nsw(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.sub %arg0, %arg1 overflow<nsw>  : i8
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i8
    %2 = llvm.intr.smax(%0, %1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

def smax_negation_not_nsw_before := [llvmfunc|
  llvm.func @smax_negation_not_nsw(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.sub %arg0, %arg1 overflow<nsw>  : i8
    %1 = llvm.sub %arg1, %arg0 overflow<nuw>  : i8
    %2 = llvm.intr.smax(%0, %1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

def smax_negation_vec_before := [llvmfunc|
  llvm.func @smax_negation_vec(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.sub %8, %arg0  : vector<3xi8>
    %10 = llvm.intr.smax(%arg0, %9)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %10 : vector<3xi8>
  }]

def smin_negation_before := [llvmfunc|
  llvm.func @smin_negation(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.sub %arg0, %arg1  : i8
    %1 = llvm.sub %arg1, %arg0  : i8
    %2 = llvm.intr.smin(%0, %1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

def umax_negation_before := [llvmfunc|
  llvm.func @umax_negation(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.sub %arg0, %arg1 overflow<nsw>  : i8
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i8
    %2 = llvm.intr.umax(%0, %1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

def umin_negation_before := [llvmfunc|
  llvm.func @umin_negation(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    %2 = llvm.intr.umin(%1, %arg0)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

def smax_negation_uses_before := [llvmfunc|
  llvm.func @smax_negation_uses(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.sub %arg0, %arg1  : i8
    %1 = llvm.sub %arg1, %arg0  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.intr.smax(%0, %1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

def clamp_two_vals_smax_smin_before := [llvmfunc|
  llvm.func @clamp_two_vals_smax_smin(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(43 : i8) : i8
    %2 = llvm.intr.smax(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.intr.smin(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def clamp_two_vals_smin_smax_before := [llvmfunc|
  llvm.func @clamp_two_vals_smin_smax(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<42> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.constant(dense<41> : vector<3xi8>) : vector<3xi8>
    %2 = llvm.intr.smin(%arg0, %0)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    %3 = llvm.intr.smax(%2, %1)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %3 : vector<3xi8>
  }]

def clamp_two_vals_umax_umin_before := [llvmfunc|
  llvm.func @clamp_two_vals_umax_umin(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(43 : i8) : i8
    %2 = llvm.intr.umax(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.intr.umin(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def clamp_two_vals_umin_umax_before := [llvmfunc|
  llvm.func @clamp_two_vals_umin_umax(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(41 : i8) : i8
    %2 = llvm.intr.umin(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.intr.umax(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def clamp_two_vals_smax_umin_before := [llvmfunc|
  llvm.func @clamp_two_vals_smax_umin(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(43 : i8) : i8
    %2 = llvm.intr.smax(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.intr.umin(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def clamp_three_vals_smax_smin_before := [llvmfunc|
  llvm.func @clamp_three_vals_smax_smin(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(44 : i8) : i8
    %2 = llvm.intr.smax(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.intr.smin(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def clamp_two_vals_umax_umin_edge_before := [llvmfunc|
  llvm.func @clamp_two_vals_umax_umin_edge(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.intr.umax(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.intr.umin(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def clamp_two_vals_umin_umax_edge_before := [llvmfunc|
  llvm.func @clamp_two_vals_umin_umax_edge(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.intr.umin(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.intr.umax(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def clamp_two_vals_smax_smin_edge_before := [llvmfunc|
  llvm.func @clamp_two_vals_smax_smin_edge(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.intr.smax(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.intr.smin(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def clamp_two_vals_smin_smax_edge_before := [llvmfunc|
  llvm.func @clamp_two_vals_smin_smax_edge(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.intr.smin(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.intr.smax(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def umin_non_zero_idiom1_before := [llvmfunc|
  llvm.func @umin_non_zero_idiom1(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.intr.umin(%arg0, %0)  : (i8, i8) -> i8
    llvm.return %1 : i8
  }]

def umin_non_zero_idiom2_before := [llvmfunc|
  llvm.func @umin_non_zero_idiom2(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.intr.umin(%0, %arg0)  : (i8, i8) -> i8
    llvm.return %1 : i8
  }]

def umin_non_zero_idiom3_before := [llvmfunc|
  llvm.func @umin_non_zero_idiom3(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<1> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.intr.umin(%arg0, %0)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %1 : vector<3xi8>
  }]

def umin_non_zero_idiom4_before := [llvmfunc|
  llvm.func @umin_non_zero_idiom4(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.intr.umin(%arg0, %8)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %9 : vector<3xi8>
  }]

def umin_eq_zero_before := [llvmfunc|
  llvm.func @umin_eq_zero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.intr.umin(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

def umin_eq_zero2_before := [llvmfunc|
  llvm.func @umin_eq_zero2(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<3xi8>) : vector<3xi8>
    %2 = llvm.intr.umin(%arg0, %arg1)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    %3 = llvm.icmp "eq" %2, %1 : vector<3xi8>
    llvm.return %3 : vector<3xi1>
  }]

def umin_ne_zero_before := [llvmfunc|
  llvm.func @umin_ne_zero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.intr.umin(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }]

def umin_ne_zero2_before := [llvmfunc|
  llvm.func @umin_ne_zero2(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<3xi8>) : vector<3xi8>
    %2 = llvm.intr.umin(%arg0, %arg1)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    %3 = llvm.icmp "ne" %2, %1 : vector<3xi8>
    llvm.return %3 : vector<3xi1>
  }]

def smax_before := [llvmfunc|
  llvm.func @smax(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.intr.smax(%arg0, %arg1)  : (i8, i8) -> i8
    %1 = llvm.intr.smax(%arg0, %arg2)  : (i8, i8) -> i8
    %2 = llvm.intr.smax(%0, %1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

def smin_before := [llvmfunc|
  llvm.func @smin(%arg0: vector<3xi8>, %arg1: vector<3xi8>, %arg2: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.intr.smin(%arg1, %arg0)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    %1 = llvm.intr.smin(%arg0, %arg2)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    %2 = llvm.intr.smin(%0, %1)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %2 : vector<3xi8>
  }]

def umax_before := [llvmfunc|
  llvm.func @umax(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.intr.umax(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.intr.umax(%arg2, %arg0)  : (i8, i8) -> i8
    %2 = llvm.intr.umax(%0, %1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

def umin_before := [llvmfunc|
  llvm.func @umin(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.intr.umin(%arg1, %arg0)  : (i8, i8) -> i8
    %1 = llvm.intr.umin(%arg2, %arg0)  : (i8, i8) -> i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.intr.umin(%0, %1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

def smax_uses_before := [llvmfunc|
  llvm.func @smax_uses(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.intr.smax(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.intr.smax(%arg0, %arg2)  : (i8, i8) -> i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.intr.smax(%0, %1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

def smax_no_common_op_before := [llvmfunc|
  llvm.func @smax_no_common_op(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.intr.smax(%arg0, %arg1)  : (i8, i8) -> i8
    %1 = llvm.intr.smax(%arg3, %arg2)  : (i8, i8) -> i8
    %2 = llvm.intr.smax(%0, %1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

def umax_demand_lshr_before := [llvmfunc|
  llvm.func @umax_demand_lshr(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(15 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.intr.umax(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.lshr %2, %1  : i8
    llvm.return %3 : i8
  }]

def umax_demand_and_before := [llvmfunc|
  llvm.func @umax_demand_and(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.intr.umax(%0, %arg0)  : (i8, i8) -> i8
    %3 = llvm.and %2, %1  : i8
    llvm.return %3 : i8
  }]

def umin_demand_or_31_30_before := [llvmfunc|
  llvm.func @umin_demand_or_31_30(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-30 : i8) : i8
    %1 = llvm.mlir.constant(31 : i8) : i8
    %2 = llvm.intr.umin(%0, %arg0)  : (i8, i8) -> i8
    %3 = llvm.or %2, %1  : i8
    llvm.return %3 : i8
  }]

def umin_demand_and_7_8_before := [llvmfunc|
  llvm.func @umin_demand_and_7_8(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-7 : i8) : i8
    %1 = llvm.mlir.constant(-8 : i8) : i8
    %2 = llvm.intr.umin(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.and %2, %1  : i8
    llvm.return %3 : i8
  }]

def neg_neg_nsw_smax_before := [llvmfunc|
  llvm.func @neg_neg_nsw_smax(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    %2 = llvm.sub %0, %arg1 overflow<nsw>  : i8
    %3 = llvm.intr.smax(%1, %2)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def neg_neg_nsw_smin_before := [llvmfunc|
  llvm.func @neg_neg_nsw_smin(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<3xi8>) : vector<3xi8>
    %2 = llvm.sub %1, %arg0 overflow<nsw>  : vector<3xi8>
    %3 = llvm.sub %1, %arg1 overflow<nsw>  : vector<3xi8>
    %4 = llvm.intr.smin(%2, %3)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %4 : vector<3xi8>
  }]

def neg_neg_nsw_smax_use0_before := [llvmfunc|
  llvm.func @neg_neg_nsw_smax_use0(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.sub %0, %arg1 overflow<nsw>  : i8
    %3 = llvm.intr.smax(%1, %2)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def neg_neg_nsw_smin_use1_before := [llvmfunc|
  llvm.func @neg_neg_nsw_smin_use1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    %2 = llvm.sub %0, %arg1 overflow<nsw>  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.intr.smin(%1, %2)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def neg_neg_nsw_smin_use2_before := [llvmfunc|
  llvm.func @neg_neg_nsw_smin_use2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.sub %0, %arg1 overflow<nsw>  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.intr.smin(%1, %2)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def neg_neg_smax_before := [llvmfunc|
  llvm.func @neg_neg_smax(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    %2 = llvm.sub %0, %arg1 overflow<nsw>  : i8
    %3 = llvm.intr.smax(%1, %2)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def neg_neg_smin_before := [llvmfunc|
  llvm.func @neg_neg_smin(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    %2 = llvm.sub %0, %arg1 overflow<nsw>  : i8
    %3 = llvm.intr.smin(%1, %2)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def neg_neg_nsw_umin_before := [llvmfunc|
  llvm.func @neg_neg_nsw_umin(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    %2 = llvm.sub %0, %arg1 overflow<nsw>  : i8
    %3 = llvm.intr.umin(%1, %2)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def freeToInvertSub_before := [llvmfunc|
  llvm.func @freeToInvertSub(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    llvm.call @use(%2) : (i8) -> ()
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.intr.umax(%1, %2)  : (i8, i8) -> i8
    %5 = llvm.sub %3, %4  : i8
    llvm.return %5 : i8
  }]

def freeToInvertSub_uses_before := [llvmfunc|
  llvm.func @freeToInvertSub_uses(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    llvm.call @use(%2) : (i8) -> ()
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.intr.umax(%1, %2)  : (i8, i8) -> i8
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.sub %3, %4  : i8
    llvm.return %5 : i8
  }]

def freeToInvert_before := [llvmfunc|
  llvm.func @freeToInvert(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    llvm.call @use(%2) : (i8) -> ()
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.intr.umax(%1, %2)  : (i8, i8) -> i8
    %5 = llvm.intr.smin(%4, %3)  : (i8, i8) -> i8
    %6 = llvm.xor %5, %0  : i8
    llvm.return %6 : i8
  }]

def freeToInvert_use1_before := [llvmfunc|
  llvm.func @freeToInvert_use1(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    llvm.call @use(%2) : (i8) -> ()
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.intr.umax(%1, %2)  : (i8, i8) -> i8
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.intr.smin(%4, %3)  : (i8, i8) -> i8
    %6 = llvm.xor %5, %0  : i8
    llvm.return %6 : i8
  }]

def freeToInvert_use2_before := [llvmfunc|
  llvm.func @freeToInvert_use2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    llvm.call @use(%2) : (i8) -> ()
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.intr.umax(%1, %2)  : (i8, i8) -> i8
    %5 = llvm.intr.smin(%4, %3)  : (i8, i8) -> i8
    llvm.call @use(%5) : (i8) -> ()
    %6 = llvm.xor %5, %0  : i8
    llvm.return %6 : i8
  }]

def freeToInvert_use3_before := [llvmfunc|
  llvm.func @freeToInvert_use3(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    llvm.call @use(%2) : (i8) -> ()
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.intr.umax(%1, %2)  : (i8, i8) -> i8
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.intr.smin(%4, %3)  : (i8, i8) -> i8
    llvm.call @use(%5) : (i8) -> ()
    %6 = llvm.xor %5, %0  : i8
    llvm.return %6 : i8
  }]

def freeToInvert_two_minmax_ops_before := [llvmfunc|
  llvm.func @freeToInvert_two_minmax_ops(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.xor %arg3, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    llvm.call @use(%2) : (i8) -> ()
    llvm.call @use(%3) : (i8) -> ()
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.intr.umax(%1, %2)  : (i8, i8) -> i8
    %6 = llvm.intr.smax(%4, %3)  : (i8, i8) -> i8
    %7 = llvm.intr.smin(%5, %6)  : (i8, i8) -> i8
    %8 = llvm.xor %7, %0  : i8
    llvm.return %8 : i8
  }]

def freeToInvert_two_minmax_ops_use1_before := [llvmfunc|
  llvm.func @freeToInvert_two_minmax_ops_use1(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.xor %arg3, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    llvm.call @use(%2) : (i8) -> ()
    llvm.call @use(%3) : (i8) -> ()
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.intr.umax(%1, %2)  : (i8, i8) -> i8
    llvm.call @use(%5) : (i8) -> ()
    %6 = llvm.intr.smax(%4, %3)  : (i8, i8) -> i8
    %7 = llvm.intr.smin(%5, %6)  : (i8, i8) -> i8
    %8 = llvm.xor %7, %0  : i8
    llvm.return %8 : i8
  }]

def freeToInvert_two_minmax_ops_use2_before := [llvmfunc|
  llvm.func @freeToInvert_two_minmax_ops_use2(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.xor %arg3, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    llvm.call @use(%2) : (i8) -> ()
    llvm.call @use(%3) : (i8) -> ()
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.intr.umax(%1, %2)  : (i8, i8) -> i8
    %6 = llvm.intr.smax(%4, %3)  : (i8, i8) -> i8
    llvm.call @use(%6) : (i8) -> ()
    %7 = llvm.intr.smin(%5, %6)  : (i8, i8) -> i8
    %8 = llvm.xor %7, %0  : i8
    llvm.return %8 : i8
  }]

def freeToInvert_two_minmax_ops_use3_before := [llvmfunc|
  llvm.func @freeToInvert_two_minmax_ops_use3(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.xor %arg3, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    llvm.call @use(%2) : (i8) -> ()
    llvm.call @use(%3) : (i8) -> ()
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.intr.umax(%1, %2)  : (i8, i8) -> i8
    llvm.call @use(%5) : (i8) -> ()
    %6 = llvm.intr.smax(%4, %3)  : (i8, i8) -> i8
    llvm.call @use(%6) : (i8) -> ()
    %7 = llvm.intr.smin(%5, %6)  : (i8, i8) -> i8
    %8 = llvm.xor %7, %0  : i8
    llvm.return %8 : i8
  }]

def sub_not_min_max_before := [llvmfunc|
  llvm.func @sub_not_min_max(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.xor %arg2, %0  : i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.intr.smin(%1, %2)  : (i8, i8) -> i8
    %5 = llvm.intr.smin(%4, %3)  : (i8, i8) -> i8
    %6 = llvm.sub %1, %5  : i8
    llvm.return %6 : i8
  }]

def sub_not_min_max_uses1_before := [llvmfunc|
  llvm.func @sub_not_min_max_uses1(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.xor %arg1, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.xor %arg2, %0  : i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.intr.smin(%1, %2)  : (i8, i8) -> i8
    %5 = llvm.intr.smin(%4, %3)  : (i8, i8) -> i8
    %6 = llvm.sub %1, %5  : i8
    llvm.return %6 : i8
  }]

def sub_not_min_max_uses2_before := [llvmfunc|
  llvm.func @sub_not_min_max_uses2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.xor %arg1, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.xor %arg2, %0  : i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.intr.smin(%1, %2)  : (i8, i8) -> i8
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.intr.smin(%4, %3)  : (i8, i8) -> i8
    %6 = llvm.sub %1, %5  : i8
    llvm.return %6 : i8
  }]

def cmyk_before := [llvmfunc|
  llvm.func @cmyk(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.intr.smin(%1, %2)  : (i8, i8) -> i8
    %5 = llvm.intr.smin(%4, %3)  : (i8, i8) -> i8
    %6 = llvm.sub %1, %5  : i8
    %7 = llvm.sub %2, %5  : i8
    %8 = llvm.sub %3, %5  : i8
    llvm.call @use4(%6, %7, %8, %5) : (i8, i8, i8, i8) -> ()
    llvm.return
  }]

def cmyk_commute1_before := [llvmfunc|
  llvm.func @cmyk_commute1(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.intr.smin(%1, %2)  : (i8, i8) -> i8
    %5 = llvm.intr.smin(%3, %4)  : (i8, i8) -> i8
    %6 = llvm.sub %1, %5  : i8
    %7 = llvm.sub %2, %5  : i8
    %8 = llvm.sub %3, %5  : i8
    llvm.call @use4(%6, %7, %8, %5) : (i8, i8, i8, i8) -> ()
    llvm.return
  }]

def cmyk_commute2_before := [llvmfunc|
  llvm.func @cmyk_commute2(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.intr.smin(%2, %1)  : (i8, i8) -> i8
    %5 = llvm.intr.smin(%3, %4)  : (i8, i8) -> i8
    %6 = llvm.sub %1, %5  : i8
    %7 = llvm.sub %2, %5  : i8
    %8 = llvm.sub %3, %5  : i8
    llvm.call @use4(%6, %7, %8, %5) : (i8, i8, i8, i8) -> ()
    llvm.return
  }]

def cmyk_commute3_before := [llvmfunc|
  llvm.func @cmyk_commute3(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.intr.smin(%2, %1)  : (i8, i8) -> i8
    %5 = llvm.intr.smin(%4, %3)  : (i8, i8) -> i8
    %6 = llvm.sub %1, %5  : i8
    %7 = llvm.sub %2, %5  : i8
    %8 = llvm.sub %3, %5  : i8
    llvm.call @use4(%6, %7, %8, %5) : (i8, i8, i8, i8) -> ()
    llvm.return
  }]

def cmyk_commute4_before := [llvmfunc|
  llvm.func @cmyk_commute4(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.intr.smin(%2, %1)  : (i8, i8) -> i8
    %5 = llvm.intr.umin(%4, %3)  : (i8, i8) -> i8
    %6 = llvm.sub %3, %5  : i8
    %7 = llvm.sub %1, %5  : i8
    %8 = llvm.sub %2, %5  : i8
    llvm.call @use4(%7, %8, %6, %5) : (i8, i8, i8, i8) -> ()
    llvm.return
  }]

def cmyk_commute5_before := [llvmfunc|
  llvm.func @cmyk_commute5(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.intr.smax(%2, %1)  : (i8, i8) -> i8
    %5 = llvm.intr.smin(%4, %3)  : (i8, i8) -> i8
    %6 = llvm.sub %1, %5  : i8
    %7 = llvm.sub %3, %5  : i8
    %8 = llvm.sub %2, %5  : i8
    llvm.call @use4(%6, %8, %7, %5) : (i8, i8, i8, i8) -> ()
    llvm.return
  }]

def cmyk_commute6_before := [llvmfunc|
  llvm.func @cmyk_commute6(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.intr.smin(%1, %2)  : (i8, i8) -> i8
    %5 = llvm.intr.smin(%4, %3)  : (i8, i8) -> i8
    %6 = llvm.sub %5, %1  : i8
    %7 = llvm.sub %5, %2  : i8
    %8 = llvm.sub %5, %3  : i8
    llvm.call @use4(%6, %7, %8, %5) : (i8, i8, i8, i8) -> ()
    llvm.return
  }]

def cmyk_commute7_before := [llvmfunc|
  llvm.func @cmyk_commute7(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.intr.smin(%1, %2)  : (i8, i8) -> i8
    %5 = llvm.intr.smin(%3, %4)  : (i8, i8) -> i8
    %6 = llvm.sub %5, %1  : i8
    %7 = llvm.sub %5, %2  : i8
    %8 = llvm.sub %5, %3  : i8
    llvm.call @use4(%6, %7, %8, %5) : (i8, i8, i8, i8) -> ()
    llvm.return
  }]

def cmyk_commute8_before := [llvmfunc|
  llvm.func @cmyk_commute8(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.intr.smin(%2, %1)  : (i8, i8) -> i8
    %5 = llvm.intr.smin(%3, %4)  : (i8, i8) -> i8
    %6 = llvm.sub %5, %1  : i8
    %7 = llvm.sub %5, %2  : i8
    %8 = llvm.sub %5, %3  : i8
    llvm.call @use4(%6, %7, %8, %5) : (i8, i8, i8, i8) -> ()
    llvm.return
  }]

def cmyk_commute9_before := [llvmfunc|
  llvm.func @cmyk_commute9(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.intr.smin(%2, %1)  : (i8, i8) -> i8
    %5 = llvm.intr.smin(%4, %3)  : (i8, i8) -> i8
    %6 = llvm.sub %5, %1  : i8
    %7 = llvm.sub %5, %2  : i8
    %8 = llvm.sub %5, %3  : i8
    llvm.call @use4(%6, %7, %8, %5) : (i8, i8, i8, i8) -> ()
    llvm.return
  }]

def cmyk_commute10_before := [llvmfunc|
  llvm.func @cmyk_commute10(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.intr.smin(%2, %1)  : (i8, i8) -> i8
    %5 = llvm.intr.umin(%4, %3)  : (i8, i8) -> i8
    %6 = llvm.sub %3, %5  : i8
    %7 = llvm.sub %5, %1  : i8
    %8 = llvm.sub %2, %5  : i8
    llvm.call @use4(%7, %8, %6, %5) : (i8, i8, i8, i8) -> ()
    llvm.return
  }]

def cmyk_commute11_before := [llvmfunc|
  llvm.func @cmyk_commute11(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.intr.smax(%2, %1)  : (i8, i8) -> i8
    %5 = llvm.intr.smin(%4, %3)  : (i8, i8) -> i8
    %6 = llvm.sub %1, %5  : i8
    %7 = llvm.sub %5, %3  : i8
    %8 = llvm.sub %5, %2  : i8
    llvm.call @use4(%6, %8, %7, %5) : (i8, i8, i8, i8) -> ()
    llvm.return
  }]

def smax_offset_before := [llvmfunc|
  llvm.func @smax_offset(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(-124 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.intr.smax(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def smax_offset_limit_before := [llvmfunc|
  llvm.func @smax_offset_limit(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(-125 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.intr.smax(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def smax_offset_overflow_before := [llvmfunc|
  llvm.func @smax_offset_overflow(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(-126 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.intr.smax(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def smax_offset_may_wrap_before := [llvmfunc|
  llvm.func @smax_offset_may_wrap(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(-124 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.intr.smax(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def smax_offset_uses_before := [llvmfunc|
  llvm.func @smax_offset_uses(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(-124 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.intr.smax(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def smin_offset_before := [llvmfunc|
  llvm.func @smin_offset(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<124> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.constant(dense<-3> : vector<3xi8>) : vector<3xi8>
    %2 = llvm.add %arg0, %0 overflow<nsw, nuw>  : vector<3xi8>
    %3 = llvm.intr.smin(%2, %1)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %3 : vector<3xi8>
  }]

def smin_offset_limit_before := [llvmfunc|
  llvm.func @smin_offset_limit(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(125 : i8) : i8
    %1 = llvm.mlir.constant(-3 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.intr.smin(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def smin_offset_overflow_before := [llvmfunc|
  llvm.func @smin_offset_overflow(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(126 : i8) : i8
    %1 = llvm.mlir.constant(-3 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.intr.smin(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def smin_offset_may_wrap_before := [llvmfunc|
  llvm.func @smin_offset_may_wrap(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(124 : i8) : i8
    %1 = llvm.mlir.constant(-3 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i8
    %3 = llvm.intr.smin(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def smin_offset_uses_before := [llvmfunc|
  llvm.func @smin_offset_uses(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(124 : i8) : i8
    %1 = llvm.mlir.constant(-3 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.intr.smin(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def umax_offset_before := [llvmfunc|
  llvm.func @umax_offset(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<127> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.constant(dense<-126> : vector<3xi8>) : vector<3xi8>
    %2 = llvm.add %arg0, %0 overflow<nsw, nuw>  : vector<3xi8>
    %3 = llvm.intr.umax(%2, %1)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %3 : vector<3xi8>
  }]

def umax_offset_limit_before := [llvmfunc|
  llvm.func @umax_offset_limit(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.add %arg0, %0 overflow<nuw>  : i8
    %2 = llvm.intr.umax(%1, %0)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

def umax_offset_overflow_before := [llvmfunc|
  llvm.func @umax_offset_overflow(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i8
    %3 = llvm.intr.umax(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def umax_offset_may_wrap_before := [llvmfunc|
  llvm.func @umax_offset_may_wrap(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.intr.umax(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def umax_offset_uses_before := [llvmfunc|
  llvm.func @umax_offset_uses(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.intr.umax(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def umin_offset_before := [llvmfunc|
  llvm.func @umin_offset(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-5 : i8) : i8
    %1 = llvm.mlir.constant(-4 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i8
    %3 = llvm.intr.umin(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def umin_offset_limit_before := [llvmfunc|
  llvm.func @umin_offset_limit(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-4 : i8) : i8
    %1 = llvm.add %arg0, %0 overflow<nuw>  : i8
    %2 = llvm.intr.umin(%1, %0)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

def umin_offset_overflow_before := [llvmfunc|
  llvm.func @umin_offset_overflow(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-3 : i8) : i8
    %1 = llvm.mlir.constant(-4 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i8
    %3 = llvm.intr.umin(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def umin_offset_may_wrap_before := [llvmfunc|
  llvm.func @umin_offset_may_wrap(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-5 : i8) : i8
    %1 = llvm.mlir.constant(-4 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.intr.umin(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def umin_offset_uses_before := [llvmfunc|
  llvm.func @umin_offset_uses(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-5 : i8) : i8
    %1 = llvm.mlir.constant(-4 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.intr.umin(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def umax_vector_splat_poison_before := [llvmfunc|
  llvm.func @umax_vector_splat_poison(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(64 : i8) : i8
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.mlir.constant(dense<[13, -126, -126]> : vector<3xi8>) : vector<3xi8>
    %10 = llvm.add %arg0, %8 overflow<nuw>  : vector<3xi8>
    %11 = llvm.intr.umax(%10, %9)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %11 : vector<3xi8>
  }]

def smax_offset_simplify_before := [llvmfunc|
  llvm.func @smax_offset_simplify(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(50 : i8) : i8
    %1 = llvm.mlir.constant(-124 : i8) : i8
    %2 = llvm.add %0, %arg0 overflow<nsw, nuw>  : i8
    %3 = llvm.intr.smax(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def smax_smax_reassoc_constants_before := [llvmfunc|
  llvm.func @smax_smax_reassoc_constants(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[42, 43, 44]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.constant(dense<[43, -43, 0]> : vector<3xi8>) : vector<3xi8>
    %2 = llvm.intr.smax(%arg0, %0)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    %3 = llvm.intr.smax(%2, %1)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %3 : vector<3xi8>
  }]

def smin_smin_reassoc_constants_before := [llvmfunc|
  llvm.func @smin_smin_reassoc_constants(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(97 : i8) : i8
    %1 = llvm.mlir.constant(-3 : i8) : i8
    %2 = llvm.intr.smin(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.intr.smin(%1, %2)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def umax_umax_reassoc_constants_before := [llvmfunc|
  llvm.func @umax_umax_reassoc_constants(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[42, 43, 44]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.constant(-113 : i8) : i8
    %3 = llvm.mlir.constant(43 : i8) : i8
    %4 = llvm.mlir.undef : vector<3xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %1, %8[%9 : i32] : vector<3xi8>
    %11 = llvm.intr.umax(%arg0, %0)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    %12 = llvm.intr.umax(%11, %10)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %12 : vector<3xi8>
  }]

def umin_umin_reassoc_constants_before := [llvmfunc|
  llvm.func @umin_umin_reassoc_constants(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-116 : i8) : i8
    %1 = llvm.mlir.constant(42 : i8) : i8
    %2 = llvm.intr.umin(%0, %arg0)  : (i8, i8) -> i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.intr.umin(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def smin_smax_reassoc_constants_before := [llvmfunc|
  llvm.func @smin_smax_reassoc_constants(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(97 : i8) : i8
    %1 = llvm.mlir.constant(-3 : i8) : i8
    %2 = llvm.intr.smin(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.intr.smax(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def smax_smax_reassoc_constant_before := [llvmfunc|
  llvm.func @smax_smax_reassoc_constant(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.intr.smax(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.intr.smax(%1, %0)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

def smin_smin_reassoc_constant_before := [llvmfunc|
  llvm.func @smin_smin_reassoc_constant(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[43, -43, 0]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.intr.smin(%arg0, %arg1)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    %2 = llvm.intr.smin(%1, %0)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %2 : vector<3xi8>
  }]

def umax_umax_reassoc_constant_before := [llvmfunc|
  llvm.func @umax_umax_reassoc_constant(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.intr.umax(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.intr.umax(%1, %0)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

def umin_umin_reassoc_constant_before := [llvmfunc|
  llvm.func @umin_umin_reassoc_constant(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[43, -43, 0]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.intr.umin(%arg0, %arg1)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    %2 = llvm.intr.umin(%1, %0)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %2 : vector<3xi8>
  }]

def umin_umin_reassoc_constant_use_before := [llvmfunc|
  llvm.func @umin_umin_reassoc_constant_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.intr.umin(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.intr.umin(%1, %0)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

def smax_smax_reassoc_constant_sink_before := [llvmfunc|
  llvm.func @smax_smax_reassoc_constant_sink(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.intr.smax(%arg0, %0)  : (i8, i8) -> i8
    %2 = llvm.intr.smax(%1, %arg1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

def smin_smin_reassoc_constant_sink_before := [llvmfunc|
  llvm.func @smin_smin_reassoc_constant_sink(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[43, -43, 0]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.intr.smin(%arg0, %0)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    %2 = llvm.intr.smin(%1, %arg1)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %2 : vector<3xi8>
  }]

def umax_umax_reassoc_constant_sink_before := [llvmfunc|
  llvm.func @umax_umax_reassoc_constant_sink(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.intr.umax(%arg0, %0)  : (i8, i8) -> i8
    %2 = llvm.intr.umax(%1, %arg1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

def umin_umin_reassoc_constant_sink_before := [llvmfunc|
  llvm.func @umin_umin_reassoc_constant_sink(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[43, -43, 0]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.intr.umin(%arg0, %0)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    %2 = llvm.intr.umin(%1, %arg1)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %2 : vector<3xi8>
  }]

def umin_umin_reassoc_constant_sink_use_before := [llvmfunc|
  llvm.func @umin_umin_reassoc_constant_sink_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.intr.umin(%arg0, %0)  : (i8, i8) -> i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.intr.umin(%1, %arg1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

def smax_smax_smax_reassoc_constants_before := [llvmfunc|
  llvm.func @smax_smax_smax_reassoc_constants(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(126 : i8) : i8
    %2 = llvm.intr.smax(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.intr.smax(%arg1, %2)  : (i8, i8) -> i8
    %4 = llvm.intr.smax(%3, %1)  : (i8, i8) -> i8
    llvm.return %4 : i8
  }]

def smax_smax_smax_reassoc_constants_swap_before := [llvmfunc|
  llvm.func @smax_smax_smax_reassoc_constants_swap(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(126 : i8) : i8
    %2 = llvm.intr.smax(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.intr.smax(%2, %arg1)  : (i8, i8) -> i8
    %4 = llvm.intr.smax(%3, %1)  : (i8, i8) -> i8
    llvm.return %4 : i8
  }]

def smin_smin_smin_reassoc_constants_before := [llvmfunc|
  llvm.func @smin_smin_smin_reassoc_constants(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(126 : i8) : i8
    %2 = llvm.intr.smin(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.intr.smin(%arg1, %2)  : (i8, i8) -> i8
    %4 = llvm.intr.smin(%3, %1)  : (i8, i8) -> i8
    llvm.return %4 : i8
  }]

def umax_umax_reassoc_constantexpr_sink_before := [llvmfunc|
  llvm.func @umax_umax_reassoc_constantexpr_sink(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.addressof @umax_umax_reassoc_constantexpr_sink : !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i8
    %3 = llvm.intr.umax(%arg0, %0)  : (i8, i8) -> i8
    %4 = llvm.intr.umax(%3, %2)  : (i8, i8) -> i8
    llvm.return %4 : i8
  }]

def smax_unary_shuffle_ops_before := [llvmfunc|
  llvm.func @smax_unary_shuffle_ops(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.poison : vector<3xi8>
    %1 = llvm.shufflevector %arg0, %0 [1, 0, 2] : vector<3xi8> 
    %2 = llvm.shufflevector %arg1, %0 [1, 0, 2] : vector<3xi8> 
    %3 = llvm.intr.smax(%1, %2)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %3 : vector<3xi8>
  }]

def smin_unary_shuffle_ops_use_poison_mask_elt_before := [llvmfunc|
  llvm.func @smin_unary_shuffle_ops_use_poison_mask_elt(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.poison : vector<3xi8>
    %1 = llvm.shufflevector %arg0, %0 [-1, 0, 2] : vector<3xi8> 
    llvm.call @use_vec(%1) : (vector<3xi8>) -> ()
    %2 = llvm.shufflevector %arg1, %0 [-1, 0, 2] : vector<3xi8> 
    %3 = llvm.intr.smin(%1, %2)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %3 : vector<3xi8>
  }]

def umax_unary_shuffle_ops_use_widening_before := [llvmfunc|
  llvm.func @umax_unary_shuffle_ops_use_widening(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.shufflevector %arg0, %0 [1, 0, 0] : vector<2xi8> 
    %2 = llvm.shufflevector %arg1, %0 [1, 0, 0] : vector<2xi8> 
    llvm.call @use_vec(%2) : (vector<3xi8>) -> ()
    %3 = llvm.intr.umax(%1, %2)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %3 : vector<3xi8>
  }]

def umin_unary_shuffle_ops_narrowing_before := [llvmfunc|
  llvm.func @umin_unary_shuffle_ops_narrowing(%arg0: vector<4xi8>, %arg1: vector<4xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.shufflevector %arg0, %0 [1, 0, 3] : vector<4xi8> 
    %2 = llvm.shufflevector %arg1, %0 [1, 0, 3] : vector<4xi8> 
    %3 = llvm.intr.umin(%1, %2)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %3 : vector<3xi8>
  }]

def smax_unary_shuffle_ops_unshuffled_op_before := [llvmfunc|
  llvm.func @smax_unary_shuffle_ops_unshuffled_op(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.poison : vector<3xi8>
    %1 = llvm.shufflevector %arg0, %0 [0, 0, 2] : vector<3xi8> 
    %2 = llvm.intr.smax(%1, %arg1)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %2 : vector<3xi8>
  }]

def smax_unary_shuffle_ops_wrong_mask_before := [llvmfunc|
  llvm.func @smax_unary_shuffle_ops_wrong_mask(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.poison : vector<3xi8>
    %1 = llvm.shufflevector %arg0, %0 [0, 0, 2] : vector<3xi8> 
    %2 = llvm.shufflevector %arg1, %0 [1, 0, 2] : vector<3xi8> 
    %3 = llvm.intr.smax(%1, %2)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %3 : vector<3xi8>
  }]

def smax_unary_shuffle_ops_wrong_shuf_before := [llvmfunc|
  llvm.func @smax_unary_shuffle_ops_wrong_shuf(%arg0: vector<3xi8>, %arg1: vector<3xi8>, %arg2: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.shufflevector %arg0, %arg2 [1, 0, 3] : vector<3xi8> 
    %1 = llvm.shufflevector %arg1, %arg2 [1, 0, 3] : vector<3xi8> 
    %2 = llvm.intr.smax(%0, %1)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %2 : vector<3xi8>
  }]

def smin_unary_shuffle_ops_uses_before := [llvmfunc|
  llvm.func @smin_unary_shuffle_ops_uses(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.poison : vector<3xi8>
    %1 = llvm.shufflevector %arg0, %0 [1, 0, 2] : vector<3xi8> 
    llvm.call @use_vec(%1) : (vector<3xi8>) -> ()
    %2 = llvm.shufflevector %arg1, %0 [1, 0, 2] : vector<3xi8> 
    llvm.call @use_vec(%2) : (vector<3xi8>) -> ()
    %3 = llvm.intr.smin(%1, %2)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %3 : vector<3xi8>
  }]

def PR57986_before := [llvmfunc|
  llvm.func @PR57986() -> i1 {
    %0 = llvm.mlir.addressof @g : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i1
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.intr.umin(%1, %2)  : (i1, i1) -> i1
    llvm.return %3 : i1
  }]

def fold_umax_with_knownbits_info_before := [llvmfunc|
  llvm.func @fold_umax_with_knownbits_info(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.or %arg0, %0  : i8
    %2 = llvm.shl %arg1, %0  : i8
    %3 = llvm.sub %1, %2  : i8
    %4 = llvm.intr.umax(%3, %0)  : (i8, i8) -> i8
    llvm.return %4 : i8
  }]

def fold_umax_with_knownbits_info_poison_in_splat_before := [llvmfunc|
  llvm.func @fold_umax_with_knownbits_info_poison_in_splat(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<1> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.poison : i8
    %3 = llvm.mlir.undef : vector<3xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<3xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<3xi8>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<3xi8>
    %10 = llvm.or %arg0, %0  : vector<3xi8>
    %11 = llvm.shl %arg1, %0  : vector<3xi8>
    %12 = llvm.sub %10, %11  : vector<3xi8>
    %13 = llvm.intr.umax(%12, %9)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %13 : vector<3xi8>
  }]

def fold_umin_with_knownbits_info_before := [llvmfunc|
  llvm.func @fold_umin_with_knownbits_info(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.shl %arg1, %1  : i8
    %4 = llvm.sub %2, %3  : i8
    %5 = llvm.intr.umin(%4, %0)  : (i8, i8) -> i8
    llvm.return %5 : i8
  }]

def fold_umin_with_knownbits_info_poison_in_splat_before := [llvmfunc|
  llvm.func @fold_umin_with_knownbits_info_poison_in_splat(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<3> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.constant(dense<2> : vector<3xi8>) : vector<3xi8>
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.mlir.poison : i8
    %4 = llvm.mlir.undef : vector<3xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %2, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %3, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %2, %8[%9 : i32] : vector<3xi8>
    %11 = llvm.or %arg0, %0  : vector<3xi8>
    %12 = llvm.shl %arg1, %1  : vector<3xi8>
    %13 = llvm.sub %11, %12  : vector<3xi8>
    %14 = llvm.intr.umin(%13, %10)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %14 : vector<3xi8>
  }]

def fold_umax_with_knownbits_info_fail_before := [llvmfunc|
  llvm.func @fold_umax_with_knownbits_info_fail(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.shl %arg1, %1  : i8
    %4 = llvm.sub %2, %3  : i8
    %5 = llvm.intr.umax(%4, %1)  : (i8, i8) -> i8
    llvm.return %5 : i8
  }]

def fold_umin_with_knownbits_info_fail_before := [llvmfunc|
  llvm.func @fold_umin_with_knownbits_info_fail(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.or %arg0, %0  : i8
    %4 = llvm.shl %arg1, %1  : i8
    %5 = llvm.sub %3, %4  : i8
    %6 = llvm.intr.umin(%5, %2)  : (i8, i8) -> i8
    llvm.return %6 : i8
  }]

def test_umax_and_before := [llvmfunc|
  llvm.func @test_umax_and(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-64 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.and %arg1, %0  : i8
    %3 = llvm.intr.umax(%1, %2)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def test_umin_and_before := [llvmfunc|
  llvm.func @test_umin_and(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-64 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.and %arg1, %0  : i8
    %3 = llvm.intr.umin(%1, %2)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def test_smax_and_before := [llvmfunc|
  llvm.func @test_smax_and(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-64 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.and %arg1, %0  : i8
    %3 = llvm.intr.smax(%1, %2)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def test_smin_and_before := [llvmfunc|
  llvm.func @test_smin_and(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-64 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.and %arg1, %0  : i8
    %3 = llvm.intr.smin(%1, %2)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def test_smin_and_mismatch_before := [llvmfunc|
  llvm.func @test_smin_and_mismatch(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-64 : i8) : i8
    %1 = llvm.mlir.constant(-32 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.intr.smin(%2, %3)  : (i8, i8) -> i8
    llvm.return %4 : i8
  }]

def test_smin_and_non_negated_pow2_before := [llvmfunc|
  llvm.func @test_smin_and_non_negated_pow2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(31 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.and %arg1, %0  : i8
    %3 = llvm.intr.smin(%1, %2)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def test_smin_and_multiuse_before := [llvmfunc|
  llvm.func @test_smin_and_multiuse(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(31 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.and %arg1, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.intr.smin(%1, %2)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def umin_known_bits_combined := [llvmfunc|
  llvm.func @umin_known_bits(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_umin_known_bits   : umin_known_bits_before  ⊑  umin_known_bits_combined := by
  unfold umin_known_bits_before umin_known_bits_combined
  simp_alive_peephole
  sorry
def umax_known_bits_combined := [llvmfunc|
  llvm.func @umax_known_bits(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_umax_known_bits   : umax_known_bits_before  ⊑  umax_known_bits_combined := by
  unfold umax_known_bits_before umax_known_bits_combined
  simp_alive_peephole
  sorry
def smin_known_bits_combined := [llvmfunc|
  llvm.func @smin_known_bits(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_smin_known_bits   : smin_known_bits_before  ⊑  smin_known_bits_combined := by
  unfold smin_known_bits_before smin_known_bits_combined
  simp_alive_peephole
  sorry
def smax_known_bits_combined := [llvmfunc|
  llvm.func @smax_known_bits(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_smax_known_bits   : smax_known_bits_before  ⊑  smax_known_bits_combined := by
  unfold smax_known_bits_before smax_known_bits_combined
  simp_alive_peephole
  sorry
def smax_sext_combined := [llvmfunc|
  llvm.func @smax_sext(%arg0: i5, %arg1: i5) -> i8 {
    %0 = llvm.intr.smax(%arg0, %arg1)  : (i5, i5) -> i5
    %1 = llvm.sext %0 : i5 to i8
    llvm.return %1 : i8
  }]

theorem inst_combine_smax_sext   : smax_sext_before  ⊑  smax_sext_combined := by
  unfold smax_sext_before smax_sext_combined
  simp_alive_peephole
  sorry
def smin_sext_combined := [llvmfunc|
  llvm.func @smin_sext(%arg0: i5, %arg1: i5) -> i8 {
    %0 = llvm.sext %arg1 : i5 to i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.intr.smin(%arg0, %arg1)  : (i5, i5) -> i5
    %2 = llvm.sext %1 : i5 to i8
    llvm.return %2 : i8
  }]

theorem inst_combine_smin_sext   : smin_sext_before  ⊑  smin_sext_combined := by
  unfold smin_sext_before smin_sext_combined
  simp_alive_peephole
  sorry
def umax_sext_combined := [llvmfunc|
  llvm.func @umax_sext(%arg0: i5, %arg1: i5) -> i8 {
    %0 = llvm.sext %arg0 : i5 to i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.intr.umax(%arg0, %arg1)  : (i5, i5) -> i5
    %2 = llvm.sext %1 : i5 to i8
    llvm.return %2 : i8
  }]

theorem inst_combine_umax_sext   : umax_sext_before  ⊑  umax_sext_combined := by
  unfold umax_sext_before umax_sext_combined
  simp_alive_peephole
  sorry
def umin_sext_combined := [llvmfunc|
  llvm.func @umin_sext(%arg0: vector<3xi5>, %arg1: vector<3xi5>) -> vector<3xi8> {
    %0 = llvm.intr.umin(%arg0, %arg1)  : (vector<3xi5>, vector<3xi5>) -> vector<3xi5>
    %1 = llvm.sext %0 : vector<3xi5> to vector<3xi8>
    llvm.return %1 : vector<3xi8>
  }]

theorem inst_combine_umin_sext   : umin_sext_before  ⊑  umin_sext_combined := by
  unfold umin_sext_before umin_sext_combined
  simp_alive_peephole
  sorry
def smax_zext_combined := [llvmfunc|
  llvm.func @smax_zext(%arg0: i5, %arg1: i5) -> i8 {
    %0 = llvm.zext %arg0 : i5 to i8
    %1 = llvm.zext %arg1 : i5 to i8
    %2 = llvm.intr.smax(%0, %1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

theorem inst_combine_smax_zext   : smax_zext_before  ⊑  smax_zext_combined := by
  unfold smax_zext_before smax_zext_combined
  simp_alive_peephole
  sorry
def smin_zext_combined := [llvmfunc|
  llvm.func @smin_zext(%arg0: i5, %arg1: i5) -> i8 {
    %0 = llvm.zext %arg0 : i5 to i8
    %1 = llvm.zext %arg1 : i5 to i8
    %2 = llvm.intr.smin(%0, %1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

theorem inst_combine_smin_zext   : smin_zext_before  ⊑  smin_zext_combined := by
  unfold smin_zext_before smin_zext_combined
  simp_alive_peephole
  sorry
def umax_zext_combined := [llvmfunc|
  llvm.func @umax_zext(%arg0: i5, %arg1: i5) -> i8 {
    %0 = llvm.intr.umax(%arg0, %arg1)  : (i5, i5) -> i5
    %1 = llvm.zext %0 : i5 to i8
    llvm.return %1 : i8
  }]

theorem inst_combine_umax_zext   : umax_zext_before  ⊑  umax_zext_combined := by
  unfold umax_zext_before umax_zext_combined
  simp_alive_peephole
  sorry
def umin_zext_combined := [llvmfunc|
  llvm.func @umin_zext(%arg0: i5, %arg1: i5) -> i8 {
    %0 = llvm.intr.umin(%arg0, %arg1)  : (i5, i5) -> i5
    %1 = llvm.zext %0 : i5 to i8
    llvm.return %1 : i8
  }]

theorem inst_combine_umin_zext   : umin_zext_before  ⊑  umin_zext_combined := by
  unfold umin_zext_before umin_zext_combined
  simp_alive_peephole
  sorry
def umin_zext_types_combined := [llvmfunc|
  llvm.func @umin_zext_types(%arg0: i6, %arg1: i5) -> i8 {
    %0 = llvm.zext %arg0 : i6 to i8
    %1 = llvm.zext %arg1 : i5 to i8
    %2 = llvm.intr.umin(%0, %1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

theorem inst_combine_umin_zext_types   : umin_zext_types_before  ⊑  umin_zext_types_combined := by
  unfold umin_zext_types_before umin_zext_types_combined
  simp_alive_peephole
  sorry
def umin_ext_combined := [llvmfunc|
  llvm.func @umin_ext(%arg0: i5, %arg1: i5) -> i8 {
    %0 = llvm.sext %arg0 : i5 to i8
    %1 = llvm.zext %arg1 : i5 to i8
    %2 = llvm.intr.umin(%0, %1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

theorem inst_combine_umin_ext   : umin_ext_before  ⊑  umin_ext_combined := by
  unfold umin_ext_before umin_ext_combined
  simp_alive_peephole
  sorry
def umin_zext_uses_combined := [llvmfunc|
  llvm.func @umin_zext_uses(%arg0: i5, %arg1: i5) -> i8 {
    %0 = llvm.zext %arg0 : i5 to i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.zext %arg1 : i5 to i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.intr.umin(%0, %1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

theorem inst_combine_umin_zext_uses   : umin_zext_uses_before  ⊑  umin_zext_uses_combined := by
  unfold umin_zext_uses_before umin_zext_uses_combined
  simp_alive_peephole
  sorry
def smax_sext_constant_combined := [llvmfunc|
  llvm.func @smax_sext_constant(%arg0: i5) -> i8 {
    %0 = llvm.mlir.constant(7 : i5) : i5
    %1 = llvm.intr.smax(%arg0, %0)  : (i5, i5) -> i5
    %2 = llvm.zext %1 : i5 to i8
    llvm.return %2 : i8
  }]

theorem inst_combine_smax_sext_constant   : smax_sext_constant_before  ⊑  smax_sext_constant_combined := by
  unfold smax_sext_constant_before smax_sext_constant_combined
  simp_alive_peephole
  sorry
def smax_sext_constant_big_combined := [llvmfunc|
  llvm.func @smax_sext_constant_big(%arg0: i5) -> i8 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_smax_sext_constant_big   : smax_sext_constant_big_before  ⊑  smax_sext_constant_big_combined := by
  unfold smax_sext_constant_big_before smax_sext_constant_big_combined
  simp_alive_peephole
  sorry
def smax_zext_constant_combined := [llvmfunc|
  llvm.func @smax_zext_constant(%arg0: i5) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.zext %arg0 : i5 to i8
    %2 = llvm.intr.smax(%1, %0)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

theorem inst_combine_smax_zext_constant   : smax_zext_constant_before  ⊑  smax_zext_constant_combined := by
  unfold smax_zext_constant_before smax_zext_constant_combined
  simp_alive_peephole
  sorry
def smin_sext_constant_combined := [llvmfunc|
  llvm.func @smin_sext_constant(%arg0: vector<3xi5>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(-16 : i5) : i5
    %1 = llvm.mlir.constant(15 : i5) : i5
    %2 = llvm.mlir.constant(7 : i5) : i5
    %3 = llvm.mlir.constant(dense<[7, 15, -16]> : vector<3xi5>) : vector<3xi5>
    %4 = llvm.intr.smin(%arg0, %3)  : (vector<3xi5>, vector<3xi5>) -> vector<3xi5>
    %5 = llvm.sext %4 : vector<3xi5> to vector<3xi8>
    llvm.return %5 : vector<3xi8>
  }]

theorem inst_combine_smin_sext_constant   : smin_sext_constant_before  ⊑  smin_sext_constant_combined := by
  unfold smin_sext_constant_before smin_sext_constant_combined
  simp_alive_peephole
  sorry
def smin_zext_constant_combined := [llvmfunc|
  llvm.func @smin_zext_constant(%arg0: i5) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.zext %arg0 : i5 to i8
    %2 = llvm.intr.smin(%1, %0)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

theorem inst_combine_smin_zext_constant   : smin_zext_constant_before  ⊑  smin_zext_constant_combined := by
  unfold smin_zext_constant_before smin_zext_constant_combined
  simp_alive_peephole
  sorry
def umax_sext_constant_combined := [llvmfunc|
  llvm.func @umax_sext_constant(%arg0: i5) -> i8 {
    %0 = llvm.mlir.constant(7 : i5) : i5
    %1 = llvm.intr.umax(%arg0, %0)  : (i5, i5) -> i5
    %2 = llvm.sext %1 : i5 to i8
    llvm.return %2 : i8
  }]

theorem inst_combine_umax_sext_constant   : umax_sext_constant_before  ⊑  umax_sext_constant_combined := by
  unfold umax_sext_constant_before umax_sext_constant_combined
  simp_alive_peephole
  sorry
def umax_sext_constant_big_combined := [llvmfunc|
  llvm.func @umax_sext_constant_big(%arg0: i5) -> i8 {
    %0 = llvm.mlir.constant(126 : i8) : i8
    %1 = llvm.sext %arg0 : i5 to i8
    %2 = llvm.intr.umax(%1, %0)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

theorem inst_combine_umax_sext_constant_big   : umax_sext_constant_big_before  ⊑  umax_sext_constant_big_combined := by
  unfold umax_sext_constant_big_before umax_sext_constant_big_combined
  simp_alive_peephole
  sorry
def umax_zext_constant_combined := [llvmfunc|
  llvm.func @umax_zext_constant(%arg0: vector<3xi5>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(-1 : i5) : i5
    %1 = llvm.mlir.constant(15 : i5) : i5
    %2 = llvm.mlir.constant(7 : i5) : i5
    %3 = llvm.mlir.constant(dense<[7, 15, -1]> : vector<3xi5>) : vector<3xi5>
    %4 = llvm.intr.umax(%arg0, %3)  : (vector<3xi5>, vector<3xi5>) -> vector<3xi5>
    %5 = llvm.zext %4 : vector<3xi5> to vector<3xi8>
    llvm.return %5 : vector<3xi8>
  }]

theorem inst_combine_umax_zext_constant   : umax_zext_constant_before  ⊑  umax_zext_constant_combined := by
  unfold umax_zext_constant_before umax_zext_constant_combined
  simp_alive_peephole
  sorry
def umax_zext_constant_big_combined := [llvmfunc|
  llvm.func @umax_zext_constant_big(%arg0: i5) -> i8 {
    %0 = llvm.mlir.constant(126 : i8) : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_umax_zext_constant_big   : umax_zext_constant_big_before  ⊑  umax_zext_constant_big_combined := by
  unfold umax_zext_constant_big_before umax_zext_constant_big_combined
  simp_alive_peephole
  sorry
def umin_sext_constant_combined := [llvmfunc|
  llvm.func @umin_sext_constant(%arg0: i5) -> i8 {
    %0 = llvm.mlir.constant(7 : i5) : i5
    %1 = llvm.intr.umin(%arg0, %0)  : (i5, i5) -> i5
    %2 = llvm.zext %1 : i5 to i8
    llvm.return %2 : i8
  }]

theorem inst_combine_umin_sext_constant   : umin_sext_constant_before  ⊑  umin_sext_constant_combined := by
  unfold umin_sext_constant_before umin_sext_constant_combined
  simp_alive_peephole
  sorry
def umin_sext_constant_big_combined := [llvmfunc|
  llvm.func @umin_sext_constant_big(%arg0: i5) -> i8 {
    %0 = llvm.mlir.constant(126 : i8) : i8
    %1 = llvm.sext %arg0 : i5 to i8
    %2 = llvm.intr.umin(%1, %0)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

theorem inst_combine_umin_sext_constant_big   : umin_sext_constant_big_before  ⊑  umin_sext_constant_big_combined := by
  unfold umin_sext_constant_big_before umin_sext_constant_big_combined
  simp_alive_peephole
  sorry
def umin_zext_constant_combined := [llvmfunc|
  llvm.func @umin_zext_constant(%arg0: i5) -> i8 {
    %0 = llvm.mlir.constant(7 : i5) : i5
    %1 = llvm.intr.umin(%arg0, %0)  : (i5, i5) -> i5
    %2 = llvm.zext %1 : i5 to i8
    llvm.return %2 : i8
  }]

theorem inst_combine_umin_zext_constant   : umin_zext_constant_before  ⊑  umin_zext_constant_combined := by
  unfold umin_zext_constant_before umin_zext_constant_combined
  simp_alive_peephole
  sorry
def umin_zext_constant_big_combined := [llvmfunc|
  llvm.func @umin_zext_constant_big(%arg0: i5) -> i8 {
    %0 = llvm.zext %arg0 : i5 to i8
    llvm.return %0 : i8
  }]

theorem inst_combine_umin_zext_constant_big   : umin_zext_constant_big_before  ⊑  umin_zext_constant_big_combined := by
  unfold umin_zext_constant_big_before umin_zext_constant_big_combined
  simp_alive_peephole
  sorry
def umin_zext_constant_uses_combined := [llvmfunc|
  llvm.func @umin_zext_constant_uses(%arg0: i5) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.zext %arg0 : i5 to i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.intr.umin(%1, %0)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

theorem inst_combine_umin_zext_constant_uses   : umin_zext_constant_uses_before  ⊑  umin_zext_constant_uses_combined := by
  unfold umin_zext_constant_uses_before umin_zext_constant_uses_combined
  simp_alive_peephole
  sorry
def smax_of_nots_combined := [llvmfunc|
  llvm.func @smax_of_nots(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.intr.smin(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.xor %1, %0  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_smax_of_nots   : smax_of_nots_before  ⊑  smax_of_nots_combined := by
  unfold smax_of_nots_before smax_of_nots_combined
  simp_alive_peephole
  sorry
def smin_of_nots_combined := [llvmfunc|
  llvm.func @smin_of_nots(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.intr.smax(%arg0, %arg1)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    %2 = llvm.xor %1, %0  : vector<3xi8>
    llvm.return %2 : vector<3xi8>
  }]

theorem inst_combine_smin_of_nots   : smin_of_nots_before  ⊑  smin_of_nots_combined := by
  unfold smin_of_nots_before smin_of_nots_combined
  simp_alive_peephole
  sorry
def umax_of_nots_combined := [llvmfunc|
  llvm.func @umax_of_nots(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.intr.umin(%arg1, %arg0)  : (i8, i8) -> i8
    %3 = llvm.xor %2, %0  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_umax_of_nots   : umax_of_nots_before  ⊑  umax_of_nots_combined := by
  unfold umax_of_nots_before umax_of_nots_combined
  simp_alive_peephole
  sorry
def umin_of_nots_combined := [llvmfunc|
  llvm.func @umin_of_nots(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg1, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.intr.umax(%arg0, %arg1)  : (i8, i8) -> i8
    %3 = llvm.xor %2, %0  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_umin_of_nots   : umin_of_nots_before  ⊑  umin_of_nots_combined := by
  unfold umin_of_nots_before umin_of_nots_combined
  simp_alive_peephole
  sorry
def umin_of_nots_uses_combined := [llvmfunc|
  llvm.func @umin_of_nots_uses(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.xor %arg1, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.intr.umin(%1, %2)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

theorem inst_combine_umin_of_nots_uses   : umin_of_nots_uses_before  ⊑  umin_of_nots_uses_combined := by
  unfold umin_of_nots_uses_before umin_of_nots_uses_combined
  simp_alive_peephole
  sorry
def smax_of_not_and_const_combined := [llvmfunc|
  llvm.func @smax_of_not_and_const(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-43 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.intr.smin(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_smax_of_not_and_const   : smax_of_not_and_const_before  ⊑  smax_of_not_and_const_combined := by
  unfold smax_of_not_and_const_before smax_of_not_and_const_combined
  simp_alive_peephole
  sorry
def smin_of_not_and_const_combined := [llvmfunc|
  llvm.func @smin_of_not_and_const(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(-44 : i8) : i8
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.constant(-43 : i8) : i8
    %3 = llvm.mlir.undef : vector<3xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<3xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<3xi8>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<3xi8>
    %10 = llvm.mlir.constant(dense<-1> : vector<3xi8>) : vector<3xi8>
    %11 = llvm.intr.smax(%arg0, %9)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    %12 = llvm.xor %11, %10  : vector<3xi8>
    llvm.return %12 : vector<3xi8>
  }]

theorem inst_combine_smin_of_not_and_const   : smin_of_not_and_const_before  ⊑  smin_of_not_and_const_combined := by
  unfold smin_of_not_and_const_before smin_of_not_and_const_combined
  simp_alive_peephole
  sorry
def umax_of_not_and_const_combined := [llvmfunc|
  llvm.func @umax_of_not_and_const(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-45 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.intr.umin(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_umax_of_not_and_const   : umax_of_not_and_const_before  ⊑  umax_of_not_and_const_combined := by
  unfold umax_of_not_and_const_before umax_of_not_and_const_combined
  simp_alive_peephole
  sorry
def umin_of_not_and_const_combined := [llvmfunc|
  llvm.func @umin_of_not_and_const(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(44 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.intr.umax(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_umin_of_not_and_const   : umin_of_not_and_const_before  ⊑  umin_of_not_and_const_combined := by
  unfold umin_of_not_and_const_before umin_of_not_and_const_combined
  simp_alive_peephole
  sorry
def umin_of_not_and_smax_combined := [llvmfunc|
  llvm.func @umin_of_not_and_smax(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg1, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.xor %arg2, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.intr.smin(%arg1, %arg2)  : (i8, i8) -> i8
    %4 = llvm.intr.umax(%arg0, %3)  : (i8, i8) -> i8
    %5 = llvm.xor %4, %0  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_umin_of_not_and_smax   : umin_of_not_and_smax_before  ⊑  umin_of_not_and_smax_combined := by
  unfold umin_of_not_and_smax_before umin_of_not_and_smax_combined
  simp_alive_peephole
  sorry
def smin_of_umax_and_not_combined := [llvmfunc|
  llvm.func @smin_of_umax_and_not(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg1, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.xor %arg2, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.intr.umin(%arg1, %arg2)  : (i8, i8) -> i8
    %4 = llvm.intr.smax(%arg0, %3)  : (i8, i8) -> i8
    %5 = llvm.xor %4, %0  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_smin_of_umax_and_not   : smin_of_umax_and_not_before  ⊑  smin_of_umax_and_not_combined := by
  unfold smin_of_umax_and_not_before smin_of_umax_and_not_combined
  simp_alive_peephole
  sorry
def umin_of_not_and_nontrivial_const_combined := [llvmfunc|
  llvm.func @umin_of_not_and_nontrivial_const(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.addressof @umin_of_not_and_nontrivial_const : !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.intr.umin(%3, %2)  : (i8, i8) -> i8
    llvm.return %4 : i8
  }]

theorem inst_combine_umin_of_not_and_nontrivial_const   : umin_of_not_and_nontrivial_const_before  ⊑  umin_of_not_and_nontrivial_const_combined := by
  unfold umin_of_not_and_nontrivial_const_before umin_of_not_and_nontrivial_const_combined
  simp_alive_peephole
  sorry
def umin_of_not_and_const_uses_combined := [llvmfunc|
  llvm.func @umin_of_not_and_const_uses(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(-45 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.intr.umin(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

theorem inst_combine_umin_of_not_and_const_uses   : umin_of_not_and_const_uses_before  ⊑  umin_of_not_and_const_uses_combined := by
  unfold umin_of_not_and_const_uses_before umin_of_not_and_const_uses_combined
  simp_alive_peephole
  sorry
def not_smax_of_nots_combined := [llvmfunc|
  llvm.func @not_smax_of_nots(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.xor %arg1, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.intr.smin(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

theorem inst_combine_not_smax_of_nots   : not_smax_of_nots_before  ⊑  not_smax_of_nots_combined := by
  unfold not_smax_of_nots_before not_smax_of_nots_combined
  simp_alive_peephole
  sorry
def not_smin_of_nots_combined := [llvmfunc|
  llvm.func @not_smin_of_nots(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.xor %arg1, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.intr.smin(%1, %2)  : (i8, i8) -> i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.xor %3, %0  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_not_smin_of_nots   : not_smin_of_nots_before  ⊑  not_smin_of_nots_combined := by
  unfold not_smin_of_nots_before not_smin_of_nots_combined
  simp_alive_peephole
  sorry
def not_umax_of_not_combined := [llvmfunc|
  llvm.func @not_umax_of_not(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.intr.umin(%arg0, %2)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

theorem inst_combine_not_umax_of_not   : not_umax_of_not_before  ⊑  not_umax_of_not_combined := by
  unfold not_umax_of_not_before not_umax_of_not_combined
  simp_alive_peephole
  sorry
def not_umin_of_not_combined := [llvmfunc|
  llvm.func @not_umin_of_not(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.intr.umin(%1, %arg1)  : (i8, i8) -> i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.xor %2, %0  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_not_umin_of_not   : not_umin_of_not_before  ⊑  not_umin_of_not_combined := by
  unfold not_umin_of_not_before not_umin_of_not_combined
  simp_alive_peephole
  sorry
def not_umin_of_not_constant_op_combined := [llvmfunc|
  llvm.func @not_umin_of_not_constant_op(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(-43 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.intr.umax(%arg0, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

theorem inst_combine_not_umin_of_not_constant_op   : not_umin_of_not_constant_op_before  ⊑  not_umin_of_not_constant_op_combined := by
  unfold not_umin_of_not_constant_op_before not_umin_of_not_constant_op_combined
  simp_alive_peephole
  sorry
def smax_negation_combined := [llvmfunc|
  llvm.func @smax_negation(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.sub %arg0, %arg1  : i8
    %1 = "llvm.intr.abs"(%0) <{is_int_min_poison = false}> : (i8) -> i8]

theorem inst_combine_smax_negation   : smax_negation_before  ⊑  smax_negation_combined := by
  unfold smax_negation_before smax_negation_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i8
  }]

theorem inst_combine_smax_negation   : smax_negation_before  ⊑  smax_negation_combined := by
  unfold smax_negation_before smax_negation_combined
  simp_alive_peephole
  sorry
def smax_negation_nsw_combined := [llvmfunc|
  llvm.func @smax_negation_nsw(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.sub %arg0, %arg1 overflow<nsw>  : i8
    %1 = "llvm.intr.abs"(%0) <{is_int_min_poison = true}> : (i8) -> i8]

theorem inst_combine_smax_negation_nsw   : smax_negation_nsw_before  ⊑  smax_negation_nsw_combined := by
  unfold smax_negation_nsw_before smax_negation_nsw_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i8
  }]

theorem inst_combine_smax_negation_nsw   : smax_negation_nsw_before  ⊑  smax_negation_nsw_combined := by
  unfold smax_negation_nsw_before smax_negation_nsw_combined
  simp_alive_peephole
  sorry
def smax_negation_not_nsw_combined := [llvmfunc|
  llvm.func @smax_negation_not_nsw(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.sub %arg0, %arg1 overflow<nsw>  : i8
    %1 = "llvm.intr.abs"(%0) <{is_int_min_poison = false}> : (i8) -> i8]

theorem inst_combine_smax_negation_not_nsw   : smax_negation_not_nsw_before  ⊑  smax_negation_not_nsw_combined := by
  unfold smax_negation_not_nsw_before smax_negation_not_nsw_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i8
  }]

theorem inst_combine_smax_negation_not_nsw   : smax_negation_not_nsw_before  ⊑  smax_negation_not_nsw_combined := by
  unfold smax_negation_not_nsw_before smax_negation_not_nsw_combined
  simp_alive_peephole
  sorry
def smax_negation_vec_combined := [llvmfunc|
  llvm.func @smax_negation_vec(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (vector<3xi8>) -> vector<3xi8>]

theorem inst_combine_smax_negation_vec   : smax_negation_vec_before  ⊑  smax_negation_vec_combined := by
  unfold smax_negation_vec_before smax_negation_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : vector<3xi8>
  }]

theorem inst_combine_smax_negation_vec   : smax_negation_vec_before  ⊑  smax_negation_vec_combined := by
  unfold smax_negation_vec_before smax_negation_vec_combined
  simp_alive_peephole
  sorry
def smin_negation_combined := [llvmfunc|
  llvm.func @smin_negation(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %arg0, %arg1  : i8
    %2 = "llvm.intr.abs"(%1) <{is_int_min_poison = false}> : (i8) -> i8]

theorem inst_combine_smin_negation   : smin_negation_before  ⊑  smin_negation_combined := by
  unfold smin_negation_before smin_negation_combined
  simp_alive_peephole
  sorry
    %3 = llvm.sub %0, %2  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_smin_negation   : smin_negation_before  ⊑  smin_negation_combined := by
  unfold smin_negation_before smin_negation_combined
  simp_alive_peephole
  sorry
def umax_negation_combined := [llvmfunc|
  llvm.func @umax_negation(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %arg0, %arg1 overflow<nsw>  : i8
    %2 = "llvm.intr.abs"(%1) <{is_int_min_poison = true}> : (i8) -> i8]

theorem inst_combine_umax_negation   : umax_negation_before  ⊑  umax_negation_combined := by
  unfold umax_negation_before umax_negation_combined
  simp_alive_peephole
  sorry
    %3 = llvm.sub %0, %2 overflow<nsw>  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_umax_negation   : umax_negation_before  ⊑  umax_negation_combined := by
  unfold umax_negation_before umax_negation_combined
  simp_alive_peephole
  sorry
def umin_negation_combined := [llvmfunc|
  llvm.func @umin_negation(%arg0: i8) -> i8 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i8) -> i8]

theorem inst_combine_umin_negation   : umin_negation_before  ⊑  umin_negation_combined := by
  unfold umin_negation_before umin_negation_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i8
  }]

theorem inst_combine_umin_negation   : umin_negation_before  ⊑  umin_negation_combined := by
  unfold umin_negation_before umin_negation_combined
  simp_alive_peephole
  sorry
def smax_negation_uses_combined := [llvmfunc|
  llvm.func @smax_negation_uses(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.sub %arg1, %arg0  : i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = "llvm.intr.abs"(%0) <{is_int_min_poison = false}> : (i8) -> i8]

theorem inst_combine_smax_negation_uses   : smax_negation_uses_before  ⊑  smax_negation_uses_combined := by
  unfold smax_negation_uses_before smax_negation_uses_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i8
  }]

theorem inst_combine_smax_negation_uses   : smax_negation_uses_before  ⊑  smax_negation_uses_combined := by
  unfold smax_negation_uses_before smax_negation_uses_combined
  simp_alive_peephole
  sorry
def clamp_two_vals_smax_smin_combined := [llvmfunc|
  llvm.func @clamp_two_vals_smax_smin(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(43 : i8) : i8
    %1 = llvm.mlir.constant(42 : i8) : i8
    %2 = llvm.icmp "slt" %arg0, %0 : i8
    %3 = llvm.select %2, %1, %0 : i1, i8
    llvm.return %3 : i8
  }]

theorem inst_combine_clamp_two_vals_smax_smin   : clamp_two_vals_smax_smin_before  ⊑  clamp_two_vals_smax_smin_combined := by
  unfold clamp_two_vals_smax_smin_before clamp_two_vals_smax_smin_combined
  simp_alive_peephole
  sorry
def clamp_two_vals_smin_smax_combined := [llvmfunc|
  llvm.func @clamp_two_vals_smin_smax(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<41> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.constant(dense<42> : vector<3xi8>) : vector<3xi8>
    %2 = llvm.icmp "sgt" %arg0, %0 : vector<3xi8>
    %3 = llvm.select %2, %1, %0 : vector<3xi1>, vector<3xi8>
    llvm.return %3 : vector<3xi8>
  }]

theorem inst_combine_clamp_two_vals_smin_smax   : clamp_two_vals_smin_smax_before  ⊑  clamp_two_vals_smin_smax_combined := by
  unfold clamp_two_vals_smin_smax_before clamp_two_vals_smin_smax_combined
  simp_alive_peephole
  sorry
def clamp_two_vals_umax_umin_combined := [llvmfunc|
  llvm.func @clamp_two_vals_umax_umin(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(43 : i8) : i8
    %1 = llvm.mlir.constant(42 : i8) : i8
    %2 = llvm.icmp "ult" %arg0, %0 : i8
    %3 = llvm.select %2, %1, %0 : i1, i8
    llvm.return %3 : i8
  }]

theorem inst_combine_clamp_two_vals_umax_umin   : clamp_two_vals_umax_umin_before  ⊑  clamp_two_vals_umax_umin_combined := by
  unfold clamp_two_vals_umax_umin_before clamp_two_vals_umax_umin_combined
  simp_alive_peephole
  sorry
def clamp_two_vals_umin_umax_combined := [llvmfunc|
  llvm.func @clamp_two_vals_umin_umax(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(41 : i8) : i8
    %1 = llvm.mlir.constant(42 : i8) : i8
    %2 = llvm.icmp "ugt" %arg0, %0 : i8
    %3 = llvm.select %2, %1, %0 : i1, i8
    llvm.return %3 : i8
  }]

theorem inst_combine_clamp_two_vals_umin_umax   : clamp_two_vals_umin_umax_before  ⊑  clamp_two_vals_umin_umax_combined := by
  unfold clamp_two_vals_umin_umax_before clamp_two_vals_umin_umax_combined
  simp_alive_peephole
  sorry
def clamp_two_vals_smax_umin_combined := [llvmfunc|
  llvm.func @clamp_two_vals_smax_umin(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(43 : i8) : i8
    %2 = llvm.intr.smax(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.intr.umin(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

theorem inst_combine_clamp_two_vals_smax_umin   : clamp_two_vals_smax_umin_before  ⊑  clamp_two_vals_smax_umin_combined := by
  unfold clamp_two_vals_smax_umin_before clamp_two_vals_smax_umin_combined
  simp_alive_peephole
  sorry
def clamp_three_vals_smax_smin_combined := [llvmfunc|
  llvm.func @clamp_three_vals_smax_smin(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(44 : i8) : i8
    %2 = llvm.intr.smax(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.intr.smin(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

theorem inst_combine_clamp_three_vals_smax_smin   : clamp_three_vals_smax_smin_before  ⊑  clamp_three_vals_smax_smin_combined := by
  unfold clamp_three_vals_smax_smin_before clamp_three_vals_smax_smin_combined
  simp_alive_peephole
  sorry
def clamp_two_vals_umax_umin_edge_combined := [llvmfunc|
  llvm.func @clamp_two_vals_umax_umin_edge(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_clamp_two_vals_umax_umin_edge   : clamp_two_vals_umax_umin_edge_before  ⊑  clamp_two_vals_umax_umin_edge_combined := by
  unfold clamp_two_vals_umax_umin_edge_before clamp_two_vals_umax_umin_edge_combined
  simp_alive_peephole
  sorry
def clamp_two_vals_umin_umax_edge_combined := [llvmfunc|
  llvm.func @clamp_two_vals_umin_umax_edge(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_clamp_two_vals_umin_umax_edge   : clamp_two_vals_umin_umax_edge_before  ⊑  clamp_two_vals_umin_umax_edge_combined := by
  unfold clamp_two_vals_umin_umax_edge_before clamp_two_vals_umin_umax_edge_combined
  simp_alive_peephole
  sorry
def clamp_two_vals_smax_smin_edge_combined := [llvmfunc|
  llvm.func @clamp_two_vals_smax_smin_edge(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_clamp_two_vals_smax_smin_edge   : clamp_two_vals_smax_smin_edge_before  ⊑  clamp_two_vals_smax_smin_edge_combined := by
  unfold clamp_two_vals_smax_smin_edge_before clamp_two_vals_smax_smin_edge_combined
  simp_alive_peephole
  sorry
def clamp_two_vals_smin_smax_edge_combined := [llvmfunc|
  llvm.func @clamp_two_vals_smin_smax_edge(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_clamp_two_vals_smin_smax_edge   : clamp_two_vals_smin_smax_edge_before  ⊑  clamp_two_vals_smin_smax_edge_combined := by
  unfold clamp_two_vals_smin_smax_edge_before clamp_two_vals_smin_smax_edge_combined
  simp_alive_peephole
  sorry
def umin_non_zero_idiom1_combined := [llvmfunc|
  llvm.func @umin_non_zero_idiom1(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    %2 = llvm.zext %1 : i1 to i8
    llvm.return %2 : i8
  }]

theorem inst_combine_umin_non_zero_idiom1   : umin_non_zero_idiom1_before  ⊑  umin_non_zero_idiom1_combined := by
  unfold umin_non_zero_idiom1_before umin_non_zero_idiom1_combined
  simp_alive_peephole
  sorry
def umin_non_zero_idiom2_combined := [llvmfunc|
  llvm.func @umin_non_zero_idiom2(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    %2 = llvm.zext %1 : i1 to i8
    llvm.return %2 : i8
  }]

theorem inst_combine_umin_non_zero_idiom2   : umin_non_zero_idiom2_before  ⊑  umin_non_zero_idiom2_combined := by
  unfold umin_non_zero_idiom2_before umin_non_zero_idiom2_combined
  simp_alive_peephole
  sorry
def umin_non_zero_idiom3_combined := [llvmfunc|
  llvm.func @umin_non_zero_idiom3(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<3xi8>) : vector<3xi8>
    %2 = llvm.icmp "ne" %arg0, %1 : vector<3xi8>
    %3 = llvm.zext %2 : vector<3xi1> to vector<3xi8>
    llvm.return %3 : vector<3xi8>
  }]

theorem inst_combine_umin_non_zero_idiom3   : umin_non_zero_idiom3_before  ⊑  umin_non_zero_idiom3_combined := by
  unfold umin_non_zero_idiom3_before umin_non_zero_idiom3_combined
  simp_alive_peephole
  sorry
def umin_non_zero_idiom4_combined := [llvmfunc|
  llvm.func @umin_non_zero_idiom4(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<3xi8>) : vector<3xi8>
    %2 = llvm.icmp "ne" %arg0, %1 : vector<3xi8>
    %3 = llvm.zext %2 : vector<3xi1> to vector<3xi8>
    llvm.return %3 : vector<3xi8>
  }]

theorem inst_combine_umin_non_zero_idiom4   : umin_non_zero_idiom4_before  ⊑  umin_non_zero_idiom4_combined := by
  unfold umin_non_zero_idiom4_before umin_non_zero_idiom4_combined
  simp_alive_peephole
  sorry
def umin_eq_zero_combined := [llvmfunc|
  llvm.func @umin_eq_zero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.intr.umin(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_umin_eq_zero   : umin_eq_zero_before  ⊑  umin_eq_zero_combined := by
  unfold umin_eq_zero_before umin_eq_zero_combined
  simp_alive_peephole
  sorry
def umin_eq_zero2_combined := [llvmfunc|
  llvm.func @umin_eq_zero2(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<3xi8>) : vector<3xi8>
    %2 = llvm.intr.umin(%arg0, %arg1)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    %3 = llvm.icmp "eq" %2, %1 : vector<3xi8>
    llvm.return %3 : vector<3xi1>
  }]

theorem inst_combine_umin_eq_zero2   : umin_eq_zero2_before  ⊑  umin_eq_zero2_combined := by
  unfold umin_eq_zero2_before umin_eq_zero2_combined
  simp_alive_peephole
  sorry
def umin_ne_zero_combined := [llvmfunc|
  llvm.func @umin_ne_zero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.intr.umin(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_umin_ne_zero   : umin_ne_zero_before  ⊑  umin_ne_zero_combined := by
  unfold umin_ne_zero_before umin_ne_zero_combined
  simp_alive_peephole
  sorry
def umin_ne_zero2_combined := [llvmfunc|
  llvm.func @umin_ne_zero2(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<3xi8>) : vector<3xi8>
    %2 = llvm.intr.umin(%arg0, %arg1)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    %3 = llvm.icmp "ne" %2, %1 : vector<3xi8>
    llvm.return %3 : vector<3xi1>
  }]

theorem inst_combine_umin_ne_zero2   : umin_ne_zero2_before  ⊑  umin_ne_zero2_combined := by
  unfold umin_ne_zero2_before umin_ne_zero2_combined
  simp_alive_peephole
  sorry
def smax_combined := [llvmfunc|
  llvm.func @smax(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.intr.smax(%arg0, %arg2)  : (i8, i8) -> i8
    %1 = llvm.intr.smax(%0, %arg1)  : (i8, i8) -> i8
    llvm.return %1 : i8
  }]

theorem inst_combine_smax   : smax_before  ⊑  smax_combined := by
  unfold smax_before smax_combined
  simp_alive_peephole
  sorry
def smin_combined := [llvmfunc|
  llvm.func @smin(%arg0: vector<3xi8>, %arg1: vector<3xi8>, %arg2: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.intr.smin(%arg0, %arg2)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    %1 = llvm.intr.smin(%0, %arg1)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %1 : vector<3xi8>
  }]

theorem inst_combine_smin   : smin_before  ⊑  smin_combined := by
  unfold smin_before smin_combined
  simp_alive_peephole
  sorry
def umax_combined := [llvmfunc|
  llvm.func @umax(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.intr.umax(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.intr.umax(%0, %arg2)  : (i8, i8) -> i8
    llvm.return %1 : i8
  }]

theorem inst_combine_umax   : umax_before  ⊑  umax_combined := by
  unfold umax_before umax_combined
  simp_alive_peephole
  sorry
def umin_combined := [llvmfunc|
  llvm.func @umin(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.intr.umin(%arg2, %arg0)  : (i8, i8) -> i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.intr.umin(%0, %arg1)  : (i8, i8) -> i8
    llvm.return %1 : i8
  }]

theorem inst_combine_umin   : umin_before  ⊑  umin_combined := by
  unfold umin_before umin_combined
  simp_alive_peephole
  sorry
def smax_uses_combined := [llvmfunc|
  llvm.func @smax_uses(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.intr.smax(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.intr.smax(%arg0, %arg2)  : (i8, i8) -> i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.intr.smax(%0, %1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

theorem inst_combine_smax_uses   : smax_uses_before  ⊑  smax_uses_combined := by
  unfold smax_uses_before smax_uses_combined
  simp_alive_peephole
  sorry
def smax_no_common_op_combined := [llvmfunc|
  llvm.func @smax_no_common_op(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.intr.smax(%arg0, %arg1)  : (i8, i8) -> i8
    %1 = llvm.intr.smax(%arg3, %arg2)  : (i8, i8) -> i8
    %2 = llvm.intr.smax(%0, %1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

theorem inst_combine_smax_no_common_op   : smax_no_common_op_before  ⊑  smax_no_common_op_combined := by
  unfold smax_no_common_op_before smax_no_common_op_combined
  simp_alive_peephole
  sorry
def umax_demand_lshr_combined := [llvmfunc|
  llvm.func @umax_demand_lshr(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.lshr %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_umax_demand_lshr   : umax_demand_lshr_before  ⊑  umax_demand_lshr_combined := by
  unfold umax_demand_lshr_before umax_demand_lshr_combined
  simp_alive_peephole
  sorry
def umax_demand_and_combined := [llvmfunc|
  llvm.func @umax_demand_and(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_umax_demand_and   : umax_demand_and_before  ⊑  umax_demand_and_combined := by
  unfold umax_demand_and_before umax_demand_and_combined
  simp_alive_peephole
  sorry
def umin_demand_or_31_30_combined := [llvmfunc|
  llvm.func @umin_demand_or_31_30(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(31 : i8) : i8
    %1 = llvm.or %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_umin_demand_or_31_30   : umin_demand_or_31_30_before  ⊑  umin_demand_or_31_30_combined := by
  unfold umin_demand_or_31_30_before umin_demand_or_31_30_combined
  simp_alive_peephole
  sorry
def umin_demand_and_7_8_combined := [llvmfunc|
  llvm.func @umin_demand_and_7_8(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-8 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_umin_demand_and_7_8   : umin_demand_and_7_8_before  ⊑  umin_demand_and_7_8_combined := by
  unfold umin_demand_and_7_8_before umin_demand_and_7_8_combined
  simp_alive_peephole
  sorry
def neg_neg_nsw_smax_combined := [llvmfunc|
  llvm.func @neg_neg_nsw_smax(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.intr.smin(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.sub %0, %1 overflow<nsw>  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_neg_neg_nsw_smax   : neg_neg_nsw_smax_before  ⊑  neg_neg_nsw_smax_combined := by
  unfold neg_neg_nsw_smax_before neg_neg_nsw_smax_combined
  simp_alive_peephole
  sorry
def neg_neg_nsw_smin_combined := [llvmfunc|
  llvm.func @neg_neg_nsw_smin(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<3xi8>) : vector<3xi8>
    %2 = llvm.intr.smax(%arg0, %arg1)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    %3 = llvm.sub %1, %2 overflow<nsw>  : vector<3xi8>
    llvm.return %3 : vector<3xi8>
  }]

theorem inst_combine_neg_neg_nsw_smin   : neg_neg_nsw_smin_before  ⊑  neg_neg_nsw_smin_combined := by
  unfold neg_neg_nsw_smin_before neg_neg_nsw_smin_combined
  simp_alive_peephole
  sorry
def neg_neg_nsw_smax_use0_combined := [llvmfunc|
  llvm.func @neg_neg_nsw_smax_use0(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.intr.smin(%arg0, %arg1)  : (i8, i8) -> i8
    %3 = llvm.sub %0, %2 overflow<nsw>  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_neg_neg_nsw_smax_use0   : neg_neg_nsw_smax_use0_before  ⊑  neg_neg_nsw_smax_use0_combined := by
  unfold neg_neg_nsw_smax_use0_before neg_neg_nsw_smax_use0_combined
  simp_alive_peephole
  sorry
def neg_neg_nsw_smin_use1_combined := [llvmfunc|
  llvm.func @neg_neg_nsw_smin_use1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg1 overflow<nsw>  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.intr.smax(%arg0, %arg1)  : (i8, i8) -> i8
    %3 = llvm.sub %0, %2 overflow<nsw>  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_neg_neg_nsw_smin_use1   : neg_neg_nsw_smin_use1_before  ⊑  neg_neg_nsw_smin_use1_combined := by
  unfold neg_neg_nsw_smin_use1_before neg_neg_nsw_smin_use1_combined
  simp_alive_peephole
  sorry
def neg_neg_nsw_smin_use2_combined := [llvmfunc|
  llvm.func @neg_neg_nsw_smin_use2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.sub %0, %arg1 overflow<nsw>  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.intr.smin(%1, %2)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

theorem inst_combine_neg_neg_nsw_smin_use2   : neg_neg_nsw_smin_use2_before  ⊑  neg_neg_nsw_smin_use2_combined := by
  unfold neg_neg_nsw_smin_use2_before neg_neg_nsw_smin_use2_combined
  simp_alive_peephole
  sorry
def neg_neg_smax_combined := [llvmfunc|
  llvm.func @neg_neg_smax(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    %2 = llvm.sub %0, %arg1 overflow<nsw>  : i8
    %3 = llvm.intr.smax(%1, %2)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

theorem inst_combine_neg_neg_smax   : neg_neg_smax_before  ⊑  neg_neg_smax_combined := by
  unfold neg_neg_smax_before neg_neg_smax_combined
  simp_alive_peephole
  sorry
def neg_neg_smin_combined := [llvmfunc|
  llvm.func @neg_neg_smin(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    %2 = llvm.sub %0, %arg1 overflow<nsw>  : i8
    %3 = llvm.intr.smin(%1, %2)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

theorem inst_combine_neg_neg_smin   : neg_neg_smin_before  ⊑  neg_neg_smin_combined := by
  unfold neg_neg_smin_before neg_neg_smin_combined
  simp_alive_peephole
  sorry
def neg_neg_nsw_umin_combined := [llvmfunc|
  llvm.func @neg_neg_nsw_umin(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    %2 = llvm.sub %0, %arg1 overflow<nsw>  : i8
    %3 = llvm.intr.umin(%1, %2)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

theorem inst_combine_neg_neg_nsw_umin   : neg_neg_nsw_umin_before  ⊑  neg_neg_nsw_umin_combined := by
  unfold neg_neg_nsw_umin_before neg_neg_nsw_umin_combined
  simp_alive_peephole
  sorry
def freeToInvertSub_combined := [llvmfunc|
  llvm.func @freeToInvertSub(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    llvm.call @use(%2) : (i8) -> ()
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.intr.umin(%arg0, %arg1)  : (i8, i8) -> i8
    %5 = llvm.sub %4, %arg2  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_freeToInvertSub   : freeToInvertSub_before  ⊑  freeToInvertSub_combined := by
  unfold freeToInvertSub_before freeToInvertSub_combined
  simp_alive_peephole
  sorry
def freeToInvertSub_uses_combined := [llvmfunc|
  llvm.func @freeToInvertSub_uses(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    llvm.call @use(%2) : (i8) -> ()
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.intr.umax(%1, %2)  : (i8, i8) -> i8
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.sub %3, %4  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_freeToInvertSub_uses   : freeToInvertSub_uses_before  ⊑  freeToInvertSub_uses_combined := by
  unfold freeToInvertSub_uses_before freeToInvertSub_uses_combined
  simp_alive_peephole
  sorry
def freeToInvert_combined := [llvmfunc|
  llvm.func @freeToInvert(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    llvm.call @use(%2) : (i8) -> ()
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.intr.umin(%arg0, %arg1)  : (i8, i8) -> i8
    %5 = llvm.intr.smax(%arg2, %4)  : (i8, i8) -> i8
    llvm.return %5 : i8
  }]

theorem inst_combine_freeToInvert   : freeToInvert_before  ⊑  freeToInvert_combined := by
  unfold freeToInvert_before freeToInvert_combined
  simp_alive_peephole
  sorry
def freeToInvert_use1_combined := [llvmfunc|
  llvm.func @freeToInvert_use1(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    llvm.call @use(%2) : (i8) -> ()
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.intr.umax(%1, %2)  : (i8, i8) -> i8
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.xor %4, %0  : i8
    %6 = llvm.intr.smax(%arg2, %5)  : (i8, i8) -> i8
    llvm.return %6 : i8
  }]

theorem inst_combine_freeToInvert_use1   : freeToInvert_use1_before  ⊑  freeToInvert_use1_combined := by
  unfold freeToInvert_use1_before freeToInvert_use1_combined
  simp_alive_peephole
  sorry
def freeToInvert_use2_combined := [llvmfunc|
  llvm.func @freeToInvert_use2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    llvm.call @use(%2) : (i8) -> ()
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.intr.umax(%1, %2)  : (i8, i8) -> i8
    %5 = llvm.intr.smin(%4, %3)  : (i8, i8) -> i8
    llvm.call @use(%5) : (i8) -> ()
    %6 = llvm.xor %5, %0  : i8
    llvm.return %6 : i8
  }]

theorem inst_combine_freeToInvert_use2   : freeToInvert_use2_before  ⊑  freeToInvert_use2_combined := by
  unfold freeToInvert_use2_before freeToInvert_use2_combined
  simp_alive_peephole
  sorry
def freeToInvert_use3_combined := [llvmfunc|
  llvm.func @freeToInvert_use3(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    llvm.call @use(%2) : (i8) -> ()
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.intr.umax(%1, %2)  : (i8, i8) -> i8
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.intr.smin(%4, %3)  : (i8, i8) -> i8
    llvm.call @use(%5) : (i8) -> ()
    %6 = llvm.xor %5, %0  : i8
    llvm.return %6 : i8
  }]

theorem inst_combine_freeToInvert_use3   : freeToInvert_use3_before  ⊑  freeToInvert_use3_combined := by
  unfold freeToInvert_use3_before freeToInvert_use3_combined
  simp_alive_peephole
  sorry
def freeToInvert_two_minmax_ops_combined := [llvmfunc|
  llvm.func @freeToInvert_two_minmax_ops(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.xor %arg3, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    llvm.call @use(%2) : (i8) -> ()
    llvm.call @use(%3) : (i8) -> ()
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.intr.umin(%arg0, %arg1)  : (i8, i8) -> i8
    %6 = llvm.intr.smin(%arg3, %arg2)  : (i8, i8) -> i8
    %7 = llvm.intr.smax(%5, %6)  : (i8, i8) -> i8
    llvm.return %7 : i8
  }]

theorem inst_combine_freeToInvert_two_minmax_ops   : freeToInvert_two_minmax_ops_before  ⊑  freeToInvert_two_minmax_ops_combined := by
  unfold freeToInvert_two_minmax_ops_before freeToInvert_two_minmax_ops_combined
  simp_alive_peephole
  sorry
def freeToInvert_two_minmax_ops_use1_combined := [llvmfunc|
  llvm.func @freeToInvert_two_minmax_ops_use1(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.xor %arg3, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    llvm.call @use(%2) : (i8) -> ()
    llvm.call @use(%3) : (i8) -> ()
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.intr.umax(%1, %2)  : (i8, i8) -> i8
    llvm.call @use(%5) : (i8) -> ()
    %6 = llvm.intr.smax(%4, %3)  : (i8, i8) -> i8
    %7 = llvm.intr.smin(%5, %6)  : (i8, i8) -> i8
    %8 = llvm.xor %7, %0  : i8
    llvm.return %8 : i8
  }]

theorem inst_combine_freeToInvert_two_minmax_ops_use1   : freeToInvert_two_minmax_ops_use1_before  ⊑  freeToInvert_two_minmax_ops_use1_combined := by
  unfold freeToInvert_two_minmax_ops_use1_before freeToInvert_two_minmax_ops_use1_combined
  simp_alive_peephole
  sorry
def freeToInvert_two_minmax_ops_use2_combined := [llvmfunc|
  llvm.func @freeToInvert_two_minmax_ops_use2(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.xor %arg3, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    llvm.call @use(%2) : (i8) -> ()
    llvm.call @use(%3) : (i8) -> ()
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.intr.umax(%1, %2)  : (i8, i8) -> i8
    %6 = llvm.intr.smax(%4, %3)  : (i8, i8) -> i8
    llvm.call @use(%6) : (i8) -> ()
    %7 = llvm.intr.smin(%5, %6)  : (i8, i8) -> i8
    %8 = llvm.xor %7, %0  : i8
    llvm.return %8 : i8
  }]

theorem inst_combine_freeToInvert_two_minmax_ops_use2   : freeToInvert_two_minmax_ops_use2_before  ⊑  freeToInvert_two_minmax_ops_use2_combined := by
  unfold freeToInvert_two_minmax_ops_use2_before freeToInvert_two_minmax_ops_use2_combined
  simp_alive_peephole
  sorry
def freeToInvert_two_minmax_ops_use3_combined := [llvmfunc|
  llvm.func @freeToInvert_two_minmax_ops_use3(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.xor %arg3, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    llvm.call @use(%2) : (i8) -> ()
    llvm.call @use(%3) : (i8) -> ()
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.intr.umax(%1, %2)  : (i8, i8) -> i8
    llvm.call @use(%5) : (i8) -> ()
    %6 = llvm.intr.smax(%4, %3)  : (i8, i8) -> i8
    llvm.call @use(%6) : (i8) -> ()
    %7 = llvm.intr.smin(%5, %6)  : (i8, i8) -> i8
    %8 = llvm.xor %7, %0  : i8
    llvm.return %8 : i8
  }]

theorem inst_combine_freeToInvert_two_minmax_ops_use3   : freeToInvert_two_minmax_ops_use3_before  ⊑  freeToInvert_two_minmax_ops_use3_combined := by
  unfold freeToInvert_two_minmax_ops_use3_before freeToInvert_two_minmax_ops_use3_combined
  simp_alive_peephole
  sorry
def sub_not_min_max_combined := [llvmfunc|
  llvm.func @sub_not_min_max(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg1, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.xor %arg2, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.intr.smax(%arg0, %arg1)  : (i8, i8) -> i8
    %4 = llvm.intr.smax(%3, %arg2)  : (i8, i8) -> i8
    %5 = llvm.sub %4, %arg0  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_sub_not_min_max   : sub_not_min_max_before  ⊑  sub_not_min_max_combined := by
  unfold sub_not_min_max_before sub_not_min_max_combined
  simp_alive_peephole
  sorry
def sub_not_min_max_uses1_combined := [llvmfunc|
  llvm.func @sub_not_min_max_uses1(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.xor %arg1, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.xor %arg2, %0  : i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.intr.smax(%arg0, %arg1)  : (i8, i8) -> i8
    %5 = llvm.intr.smax(%4, %arg2)  : (i8, i8) -> i8
    %6 = llvm.sub %5, %arg0  : i8
    llvm.return %6 : i8
  }]

theorem inst_combine_sub_not_min_max_uses1   : sub_not_min_max_uses1_before  ⊑  sub_not_min_max_uses1_combined := by
  unfold sub_not_min_max_uses1_before sub_not_min_max_uses1_combined
  simp_alive_peephole
  sorry
def sub_not_min_max_uses2_combined := [llvmfunc|
  llvm.func @sub_not_min_max_uses2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.xor %arg1, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.xor %arg2, %0  : i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.intr.smin(%1, %2)  : (i8, i8) -> i8
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.intr.smin(%4, %3)  : (i8, i8) -> i8
    %6 = llvm.sub %1, %5  : i8
    llvm.return %6 : i8
  }]

theorem inst_combine_sub_not_min_max_uses2   : sub_not_min_max_uses2_before  ⊑  sub_not_min_max_uses2_combined := by
  unfold sub_not_min_max_uses2_before sub_not_min_max_uses2_combined
  simp_alive_peephole
  sorry
def cmyk_combined := [llvmfunc|
  llvm.func @cmyk(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.intr.smax(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.intr.smax(%arg2, %1)  : (i8, i8) -> i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.sub %2, %arg0  : i8
    %5 = llvm.sub %2, %arg1  : i8
    %6 = llvm.sub %2, %arg2  : i8
    llvm.call @use4(%4, %5, %6, %3) : (i8, i8, i8, i8) -> ()
    llvm.return
  }]

theorem inst_combine_cmyk   : cmyk_before  ⊑  cmyk_combined := by
  unfold cmyk_before cmyk_combined
  simp_alive_peephole
  sorry
def cmyk_commute1_combined := [llvmfunc|
  llvm.func @cmyk_commute1(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.intr.smax(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.intr.smax(%arg2, %1)  : (i8, i8) -> i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.sub %2, %arg0  : i8
    %5 = llvm.sub %2, %arg1  : i8
    %6 = llvm.sub %2, %arg2  : i8
    llvm.call @use4(%4, %5, %6, %3) : (i8, i8, i8, i8) -> ()
    llvm.return
  }]

theorem inst_combine_cmyk_commute1   : cmyk_commute1_before  ⊑  cmyk_commute1_combined := by
  unfold cmyk_commute1_before cmyk_commute1_combined
  simp_alive_peephole
  sorry
def cmyk_commute2_combined := [llvmfunc|
  llvm.func @cmyk_commute2(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.intr.smax(%arg1, %arg0)  : (i8, i8) -> i8
    %2 = llvm.intr.smax(%arg2, %1)  : (i8, i8) -> i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.sub %2, %arg0  : i8
    %5 = llvm.sub %2, %arg1  : i8
    %6 = llvm.sub %2, %arg2  : i8
    llvm.call @use4(%4, %5, %6, %3) : (i8, i8, i8, i8) -> ()
    llvm.return
  }]

theorem inst_combine_cmyk_commute2   : cmyk_commute2_before  ⊑  cmyk_commute2_combined := by
  unfold cmyk_commute2_before cmyk_commute2_combined
  simp_alive_peephole
  sorry
def cmyk_commute3_combined := [llvmfunc|
  llvm.func @cmyk_commute3(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.intr.smax(%arg1, %arg0)  : (i8, i8) -> i8
    %2 = llvm.intr.smax(%arg2, %1)  : (i8, i8) -> i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.sub %2, %arg0  : i8
    %5 = llvm.sub %2, %arg1  : i8
    %6 = llvm.sub %2, %arg2  : i8
    llvm.call @use4(%4, %5, %6, %3) : (i8, i8, i8, i8) -> ()
    llvm.return
  }]

theorem inst_combine_cmyk_commute3   : cmyk_commute3_before  ⊑  cmyk_commute3_combined := by
  unfold cmyk_commute3_before cmyk_commute3_combined
  simp_alive_peephole
  sorry
def cmyk_commute4_combined := [llvmfunc|
  llvm.func @cmyk_commute4(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.intr.smax(%arg1, %arg0)  : (i8, i8) -> i8
    %2 = llvm.intr.umax(%arg2, %1)  : (i8, i8) -> i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.sub %2, %arg2  : i8
    %5 = llvm.sub %2, %arg0  : i8
    %6 = llvm.sub %2, %arg1  : i8
    llvm.call @use4(%5, %6, %4, %3) : (i8, i8, i8, i8) -> ()
    llvm.return
  }]

theorem inst_combine_cmyk_commute4   : cmyk_commute4_before  ⊑  cmyk_commute4_combined := by
  unfold cmyk_commute4_before cmyk_commute4_combined
  simp_alive_peephole
  sorry
def cmyk_commute5_combined := [llvmfunc|
  llvm.func @cmyk_commute5(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.intr.smin(%arg1, %arg0)  : (i8, i8) -> i8
    %2 = llvm.intr.smax(%arg2, %1)  : (i8, i8) -> i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.sub %2, %arg0  : i8
    %5 = llvm.sub %2, %arg2  : i8
    %6 = llvm.sub %2, %arg1  : i8
    llvm.call @use4(%4, %6, %5, %3) : (i8, i8, i8, i8) -> ()
    llvm.return
  }]

theorem inst_combine_cmyk_commute5   : cmyk_commute5_before  ⊑  cmyk_commute5_combined := by
  unfold cmyk_commute5_before cmyk_commute5_combined
  simp_alive_peephole
  sorry
def cmyk_commute6_combined := [llvmfunc|
  llvm.func @cmyk_commute6(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.intr.smax(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.intr.smax(%arg2, %1)  : (i8, i8) -> i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.sub %arg0, %2  : i8
    %5 = llvm.sub %arg1, %2  : i8
    %6 = llvm.sub %arg2, %2  : i8
    llvm.call @use4(%4, %5, %6, %3) : (i8, i8, i8, i8) -> ()
    llvm.return
  }]

theorem inst_combine_cmyk_commute6   : cmyk_commute6_before  ⊑  cmyk_commute6_combined := by
  unfold cmyk_commute6_before cmyk_commute6_combined
  simp_alive_peephole
  sorry
def cmyk_commute7_combined := [llvmfunc|
  llvm.func @cmyk_commute7(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.intr.smax(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.intr.smax(%arg2, %1)  : (i8, i8) -> i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.sub %arg0, %2  : i8
    %5 = llvm.sub %arg1, %2  : i8
    %6 = llvm.sub %arg2, %2  : i8
    llvm.call @use4(%4, %5, %6, %3) : (i8, i8, i8, i8) -> ()
    llvm.return
  }]

theorem inst_combine_cmyk_commute7   : cmyk_commute7_before  ⊑  cmyk_commute7_combined := by
  unfold cmyk_commute7_before cmyk_commute7_combined
  simp_alive_peephole
  sorry
def cmyk_commute8_combined := [llvmfunc|
  llvm.func @cmyk_commute8(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.intr.smax(%arg1, %arg0)  : (i8, i8) -> i8
    %2 = llvm.intr.smax(%arg2, %1)  : (i8, i8) -> i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.sub %arg0, %2  : i8
    %5 = llvm.sub %arg1, %2  : i8
    %6 = llvm.sub %arg2, %2  : i8
    llvm.call @use4(%4, %5, %6, %3) : (i8, i8, i8, i8) -> ()
    llvm.return
  }]

theorem inst_combine_cmyk_commute8   : cmyk_commute8_before  ⊑  cmyk_commute8_combined := by
  unfold cmyk_commute8_before cmyk_commute8_combined
  simp_alive_peephole
  sorry
def cmyk_commute9_combined := [llvmfunc|
  llvm.func @cmyk_commute9(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.intr.smax(%arg1, %arg0)  : (i8, i8) -> i8
    %2 = llvm.intr.smax(%arg2, %1)  : (i8, i8) -> i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.sub %arg0, %2  : i8
    %5 = llvm.sub %arg1, %2  : i8
    %6 = llvm.sub %arg2, %2  : i8
    llvm.call @use4(%4, %5, %6, %3) : (i8, i8, i8, i8) -> ()
    llvm.return
  }]

theorem inst_combine_cmyk_commute9   : cmyk_commute9_before  ⊑  cmyk_commute9_combined := by
  unfold cmyk_commute9_before cmyk_commute9_combined
  simp_alive_peephole
  sorry
def cmyk_commute10_combined := [llvmfunc|
  llvm.func @cmyk_commute10(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.intr.smax(%arg1, %arg0)  : (i8, i8) -> i8
    %2 = llvm.intr.umax(%arg2, %1)  : (i8, i8) -> i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.sub %2, %arg2  : i8
    %5 = llvm.sub %arg0, %2  : i8
    %6 = llvm.sub %2, %arg1  : i8
    llvm.call @use4(%5, %6, %4, %3) : (i8, i8, i8, i8) -> ()
    llvm.return
  }]

theorem inst_combine_cmyk_commute10   : cmyk_commute10_before  ⊑  cmyk_commute10_combined := by
  unfold cmyk_commute10_before cmyk_commute10_combined
  simp_alive_peephole
  sorry
def cmyk_commute11_combined := [llvmfunc|
  llvm.func @cmyk_commute11(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.intr.smin(%arg1, %arg0)  : (i8, i8) -> i8
    %2 = llvm.intr.smax(%arg2, %1)  : (i8, i8) -> i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.sub %2, %arg0  : i8
    %5 = llvm.sub %arg2, %2  : i8
    %6 = llvm.sub %arg1, %2  : i8
    llvm.call @use4(%4, %6, %5, %3) : (i8, i8, i8, i8) -> ()
    llvm.return
  }]

theorem inst_combine_cmyk_commute11   : cmyk_commute11_before  ⊑  cmyk_commute11_combined := by
  unfold cmyk_commute11_before cmyk_commute11_combined
  simp_alive_peephole
  sorry
def smax_offset_combined := [llvmfunc|
  llvm.func @smax_offset(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-127 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.intr.smax(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.add %2, %1 overflow<nsw>  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_smax_offset   : smax_offset_before  ⊑  smax_offset_combined := by
  unfold smax_offset_before smax_offset_combined
  simp_alive_peephole
  sorry
def smax_offset_limit_combined := [llvmfunc|
  llvm.func @smax_offset_limit(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.add %arg0, %0 overflow<nsw>  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_smax_offset_limit   : smax_offset_limit_before  ⊑  smax_offset_limit_combined := by
  unfold smax_offset_limit_before smax_offset_limit_combined
  simp_alive_peephole
  sorry
def smax_offset_overflow_combined := [llvmfunc|
  llvm.func @smax_offset_overflow(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.add %arg0, %0 overflow<nsw>  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_smax_offset_overflow   : smax_offset_overflow_before  ⊑  smax_offset_overflow_combined := by
  unfold smax_offset_overflow_before smax_offset_overflow_combined
  simp_alive_peephole
  sorry
def smax_offset_may_wrap_combined := [llvmfunc|
  llvm.func @smax_offset_may_wrap(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(-124 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.intr.smax(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

theorem inst_combine_smax_offset_may_wrap   : smax_offset_may_wrap_before  ⊑  smax_offset_may_wrap_combined := by
  unfold smax_offset_may_wrap_before smax_offset_may_wrap_combined
  simp_alive_peephole
  sorry
def smax_offset_uses_combined := [llvmfunc|
  llvm.func @smax_offset_uses(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(-124 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.intr.smax(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

theorem inst_combine_smax_offset_uses   : smax_offset_uses_before  ⊑  smax_offset_uses_combined := by
  unfold smax_offset_uses_before smax_offset_uses_combined
  simp_alive_peephole
  sorry
def smin_offset_combined := [llvmfunc|
  llvm.func @smin_offset(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<-127> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.constant(dense<124> : vector<3xi8>) : vector<3xi8>
    %2 = llvm.intr.smin(%arg0, %0)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    %3 = llvm.or %2, %1  : vector<3xi8>
    llvm.return %3 : vector<3xi8>
  }]

theorem inst_combine_smin_offset   : smin_offset_before  ⊑  smin_offset_combined := by
  unfold smin_offset_before smin_offset_combined
  simp_alive_peephole
  sorry
def smin_offset_limit_combined := [llvmfunc|
  llvm.func @smin_offset_limit(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-3 : i8) : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_smin_offset_limit   : smin_offset_limit_before  ⊑  smin_offset_limit_combined := by
  unfold smin_offset_limit_before smin_offset_limit_combined
  simp_alive_peephole
  sorry
def smin_offset_overflow_combined := [llvmfunc|
  llvm.func @smin_offset_overflow(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-3 : i8) : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_smin_offset_overflow   : smin_offset_overflow_before  ⊑  smin_offset_overflow_combined := by
  unfold smin_offset_overflow_before smin_offset_overflow_combined
  simp_alive_peephole
  sorry
def smin_offset_may_wrap_combined := [llvmfunc|
  llvm.func @smin_offset_may_wrap(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(124 : i8) : i8
    %1 = llvm.mlir.constant(-3 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i8
    %3 = llvm.intr.smin(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

theorem inst_combine_smin_offset_may_wrap   : smin_offset_may_wrap_before  ⊑  smin_offset_may_wrap_combined := by
  unfold smin_offset_may_wrap_before smin_offset_may_wrap_combined
  simp_alive_peephole
  sorry
def smin_offset_uses_combined := [llvmfunc|
  llvm.func @smin_offset_uses(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(124 : i8) : i8
    %1 = llvm.mlir.constant(-3 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.intr.smin(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

theorem inst_combine_smin_offset_uses   : smin_offset_uses_before  ⊑  smin_offset_uses_combined := by
  unfold smin_offset_uses_before smin_offset_uses_combined
  simp_alive_peephole
  sorry
def umax_offset_combined := [llvmfunc|
  llvm.func @umax_offset(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<3> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.constant(dense<127> : vector<3xi8>) : vector<3xi8>
    %2 = llvm.intr.umax(%arg0, %0)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    %3 = llvm.add %2, %1 overflow<nuw>  : vector<3xi8>
    llvm.return %3 : vector<3xi8>
  }]

theorem inst_combine_umax_offset   : umax_offset_before  ⊑  umax_offset_combined := by
  unfold umax_offset_before umax_offset_combined
  simp_alive_peephole
  sorry
def umax_offset_limit_combined := [llvmfunc|
  llvm.func @umax_offset_limit(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.add %arg0, %0 overflow<nuw>  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_umax_offset_limit   : umax_offset_limit_before  ⊑  umax_offset_limit_combined := by
  unfold umax_offset_limit_before umax_offset_limit_combined
  simp_alive_peephole
  sorry
def umax_offset_overflow_combined := [llvmfunc|
  llvm.func @umax_offset_overflow(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.add %arg0, %0 overflow<nuw>  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_umax_offset_overflow   : umax_offset_overflow_before  ⊑  umax_offset_overflow_combined := by
  unfold umax_offset_overflow_before umax_offset_overflow_combined
  simp_alive_peephole
  sorry
def umax_offset_may_wrap_combined := [llvmfunc|
  llvm.func @umax_offset_may_wrap(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.intr.umax(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

theorem inst_combine_umax_offset_may_wrap   : umax_offset_may_wrap_before  ⊑  umax_offset_may_wrap_combined := by
  unfold umax_offset_may_wrap_before umax_offset_may_wrap_combined
  simp_alive_peephole
  sorry
def umax_offset_uses_combined := [llvmfunc|
  llvm.func @umax_offset_uses(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.intr.umax(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

theorem inst_combine_umax_offset_uses   : umax_offset_uses_before  ⊑  umax_offset_uses_combined := by
  unfold umax_offset_uses_before umax_offset_uses_combined
  simp_alive_peephole
  sorry
def umin_offset_combined := [llvmfunc|
  llvm.func @umin_offset(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-5 : i8) : i8
    %2 = llvm.mlir.constant(-4 : i8) : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i8
    llvm.return %4 : i8
  }]

theorem inst_combine_umin_offset   : umin_offset_before  ⊑  umin_offset_combined := by
  unfold umin_offset_before umin_offset_combined
  simp_alive_peephole
  sorry
def umin_offset_limit_combined := [llvmfunc|
  llvm.func @umin_offset_limit(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-4 : i8) : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_umin_offset_limit   : umin_offset_limit_before  ⊑  umin_offset_limit_combined := by
  unfold umin_offset_limit_before umin_offset_limit_combined
  simp_alive_peephole
  sorry
def umin_offset_overflow_combined := [llvmfunc|
  llvm.func @umin_offset_overflow(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-4 : i8) : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_umin_offset_overflow   : umin_offset_overflow_before  ⊑  umin_offset_overflow_combined := by
  unfold umin_offset_overflow_before umin_offset_overflow_combined
  simp_alive_peephole
  sorry
def umin_offset_may_wrap_combined := [llvmfunc|
  llvm.func @umin_offset_may_wrap(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-5 : i8) : i8
    %1 = llvm.mlir.constant(-4 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.intr.umin(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

theorem inst_combine_umin_offset_may_wrap   : umin_offset_may_wrap_before  ⊑  umin_offset_may_wrap_combined := by
  unfold umin_offset_may_wrap_before umin_offset_may_wrap_combined
  simp_alive_peephole
  sorry
def umin_offset_uses_combined := [llvmfunc|
  llvm.func @umin_offset_uses(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-5 : i8) : i8
    %1 = llvm.mlir.constant(-4 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.intr.umin(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

theorem inst_combine_umin_offset_uses   : umin_offset_uses_before  ⊑  umin_offset_uses_combined := by
  unfold umin_offset_uses_before umin_offset_uses_combined
  simp_alive_peephole
  sorry
def umax_vector_splat_poison_combined := [llvmfunc|
  llvm.func @umax_vector_splat_poison(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(64 : i8) : i8
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.mlir.constant(dense<[13, -126, -126]> : vector<3xi8>) : vector<3xi8>
    %10 = llvm.add %arg0, %8 overflow<nuw>  : vector<3xi8>
    %11 = llvm.intr.umax(%10, %9)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %11 : vector<3xi8>
  }]

theorem inst_combine_umax_vector_splat_poison   : umax_vector_splat_poison_before  ⊑  umax_vector_splat_poison_combined := by
  unfold umax_vector_splat_poison_before umax_vector_splat_poison_combined
  simp_alive_peephole
  sorry
def smax_offset_simplify_combined := [llvmfunc|
  llvm.func @smax_offset_simplify(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(50 : i8) : i8
    %1 = llvm.add %arg0, %0 overflow<nsw, nuw>  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_smax_offset_simplify   : smax_offset_simplify_before  ⊑  smax_offset_simplify_combined := by
  unfold smax_offset_simplify_before smax_offset_simplify_combined
  simp_alive_peephole
  sorry
def smax_smax_reassoc_constants_combined := [llvmfunc|
  llvm.func @smax_smax_reassoc_constants(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[43, 43, 44]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.intr.smax(%arg0, %0)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %1 : vector<3xi8>
  }]

theorem inst_combine_smax_smax_reassoc_constants   : smax_smax_reassoc_constants_before  ⊑  smax_smax_reassoc_constants_combined := by
  unfold smax_smax_reassoc_constants_before smax_smax_reassoc_constants_combined
  simp_alive_peephole
  sorry
def smin_smin_reassoc_constants_combined := [llvmfunc|
  llvm.func @smin_smin_reassoc_constants(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-3 : i8) : i8
    %1 = llvm.intr.smin(%arg0, %0)  : (i8, i8) -> i8
    llvm.return %1 : i8
  }]

theorem inst_combine_smin_smin_reassoc_constants   : smin_smin_reassoc_constants_before  ⊑  smin_smin_reassoc_constants_combined := by
  unfold smin_smin_reassoc_constants_before smin_smin_reassoc_constants_combined
  simp_alive_peephole
  sorry
def umax_umax_reassoc_constants_combined := [llvmfunc|
  llvm.func @umax_umax_reassoc_constants(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(-113 : i8) : i8
    %2 = llvm.mlir.constant(43 : i8) : i8
    %3 = llvm.mlir.undef : vector<3xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<3xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<3xi8>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<3xi8>
    %10 = llvm.intr.umax(%arg0, %9)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %10 : vector<3xi8>
  }]

theorem inst_combine_umax_umax_reassoc_constants   : umax_umax_reassoc_constants_before  ⊑  umax_umax_reassoc_constants_combined := by
  unfold umax_umax_reassoc_constants_before umax_umax_reassoc_constants_combined
  simp_alive_peephole
  sorry
def umin_umin_reassoc_constants_combined := [llvmfunc|
  llvm.func @umin_umin_reassoc_constants(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-116 : i8) : i8
    %1 = llvm.mlir.constant(42 : i8) : i8
    %2 = llvm.intr.umin(%arg0, %0)  : (i8, i8) -> i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.intr.umin(%arg0, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

theorem inst_combine_umin_umin_reassoc_constants   : umin_umin_reassoc_constants_before  ⊑  umin_umin_reassoc_constants_combined := by
  unfold umin_umin_reassoc_constants_before umin_umin_reassoc_constants_combined
  simp_alive_peephole
  sorry
def smin_smax_reassoc_constants_combined := [llvmfunc|
  llvm.func @smin_smax_reassoc_constants(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(97 : i8) : i8
    %1 = llvm.mlir.constant(-3 : i8) : i8
    %2 = llvm.intr.smin(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.intr.smax(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

theorem inst_combine_smin_smax_reassoc_constants   : smin_smax_reassoc_constants_before  ⊑  smin_smax_reassoc_constants_combined := by
  unfold smin_smax_reassoc_constants_before smin_smax_reassoc_constants_combined
  simp_alive_peephole
  sorry
def smax_smax_reassoc_constant_combined := [llvmfunc|
  llvm.func @smax_smax_reassoc_constant(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.intr.smax(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.intr.smax(%1, %0)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

theorem inst_combine_smax_smax_reassoc_constant   : smax_smax_reassoc_constant_before  ⊑  smax_smax_reassoc_constant_combined := by
  unfold smax_smax_reassoc_constant_before smax_smax_reassoc_constant_combined
  simp_alive_peephole
  sorry
def smin_smin_reassoc_constant_combined := [llvmfunc|
  llvm.func @smin_smin_reassoc_constant(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[43, -43, 0]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.intr.smin(%arg0, %arg1)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    %2 = llvm.intr.smin(%1, %0)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %2 : vector<3xi8>
  }]

theorem inst_combine_smin_smin_reassoc_constant   : smin_smin_reassoc_constant_before  ⊑  smin_smin_reassoc_constant_combined := by
  unfold smin_smin_reassoc_constant_before smin_smin_reassoc_constant_combined
  simp_alive_peephole
  sorry
def umax_umax_reassoc_constant_combined := [llvmfunc|
  llvm.func @umax_umax_reassoc_constant(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.intr.umax(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.intr.umax(%1, %0)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

theorem inst_combine_umax_umax_reassoc_constant   : umax_umax_reassoc_constant_before  ⊑  umax_umax_reassoc_constant_combined := by
  unfold umax_umax_reassoc_constant_before umax_umax_reassoc_constant_combined
  simp_alive_peephole
  sorry
def umin_umin_reassoc_constant_combined := [llvmfunc|
  llvm.func @umin_umin_reassoc_constant(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[43, -43, 0]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.intr.umin(%arg0, %arg1)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    %2 = llvm.intr.umin(%1, %0)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %2 : vector<3xi8>
  }]

theorem inst_combine_umin_umin_reassoc_constant   : umin_umin_reassoc_constant_before  ⊑  umin_umin_reassoc_constant_combined := by
  unfold umin_umin_reassoc_constant_before umin_umin_reassoc_constant_combined
  simp_alive_peephole
  sorry
def umin_umin_reassoc_constant_use_combined := [llvmfunc|
  llvm.func @umin_umin_reassoc_constant_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.intr.umin(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.intr.umin(%1, %0)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

theorem inst_combine_umin_umin_reassoc_constant_use   : umin_umin_reassoc_constant_use_before  ⊑  umin_umin_reassoc_constant_use_combined := by
  unfold umin_umin_reassoc_constant_use_before umin_umin_reassoc_constant_use_combined
  simp_alive_peephole
  sorry
def smax_smax_reassoc_constant_sink_combined := [llvmfunc|
  llvm.func @smax_smax_reassoc_constant_sink(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.intr.smax(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.intr.smax(%1, %0)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

theorem inst_combine_smax_smax_reassoc_constant_sink   : smax_smax_reassoc_constant_sink_before  ⊑  smax_smax_reassoc_constant_sink_combined := by
  unfold smax_smax_reassoc_constant_sink_before smax_smax_reassoc_constant_sink_combined
  simp_alive_peephole
  sorry
def smin_smin_reassoc_constant_sink_combined := [llvmfunc|
  llvm.func @smin_smin_reassoc_constant_sink(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[43, -43, 0]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.intr.smin(%arg0, %arg1)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    %2 = llvm.intr.smin(%1, %0)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %2 : vector<3xi8>
  }]

theorem inst_combine_smin_smin_reassoc_constant_sink   : smin_smin_reassoc_constant_sink_before  ⊑  smin_smin_reassoc_constant_sink_combined := by
  unfold smin_smin_reassoc_constant_sink_before smin_smin_reassoc_constant_sink_combined
  simp_alive_peephole
  sorry
def umax_umax_reassoc_constant_sink_combined := [llvmfunc|
  llvm.func @umax_umax_reassoc_constant_sink(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.intr.umax(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.intr.umax(%1, %0)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

theorem inst_combine_umax_umax_reassoc_constant_sink   : umax_umax_reassoc_constant_sink_before  ⊑  umax_umax_reassoc_constant_sink_combined := by
  unfold umax_umax_reassoc_constant_sink_before umax_umax_reassoc_constant_sink_combined
  simp_alive_peephole
  sorry
def umin_umin_reassoc_constant_sink_combined := [llvmfunc|
  llvm.func @umin_umin_reassoc_constant_sink(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[43, -43, 0]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.intr.umin(%arg0, %arg1)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    %2 = llvm.intr.umin(%1, %0)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %2 : vector<3xi8>
  }]

theorem inst_combine_umin_umin_reassoc_constant_sink   : umin_umin_reassoc_constant_sink_before  ⊑  umin_umin_reassoc_constant_sink_combined := by
  unfold umin_umin_reassoc_constant_sink_before umin_umin_reassoc_constant_sink_combined
  simp_alive_peephole
  sorry
def umin_umin_reassoc_constant_sink_use_combined := [llvmfunc|
  llvm.func @umin_umin_reassoc_constant_sink_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.intr.umin(%arg0, %0)  : (i8, i8) -> i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.intr.umin(%1, %arg1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

theorem inst_combine_umin_umin_reassoc_constant_sink_use   : umin_umin_reassoc_constant_sink_use_before  ⊑  umin_umin_reassoc_constant_sink_use_combined := by
  unfold umin_umin_reassoc_constant_sink_use_before umin_umin_reassoc_constant_sink_use_combined
  simp_alive_peephole
  sorry
def smax_smax_smax_reassoc_constants_combined := [llvmfunc|
  llvm.func @smax_smax_smax_reassoc_constants(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(126 : i8) : i8
    %1 = llvm.intr.smax(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.intr.smax(%1, %0)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

theorem inst_combine_smax_smax_smax_reassoc_constants   : smax_smax_smax_reassoc_constants_before  ⊑  smax_smax_smax_reassoc_constants_combined := by
  unfold smax_smax_smax_reassoc_constants_before smax_smax_smax_reassoc_constants_combined
  simp_alive_peephole
  sorry
def smax_smax_smax_reassoc_constants_swap_combined := [llvmfunc|
  llvm.func @smax_smax_smax_reassoc_constants_swap(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(126 : i8) : i8
    %1 = llvm.intr.smax(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.intr.smax(%1, %0)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

theorem inst_combine_smax_smax_smax_reassoc_constants_swap   : smax_smax_smax_reassoc_constants_swap_before  ⊑  smax_smax_smax_reassoc_constants_swap_combined := by
  unfold smax_smax_smax_reassoc_constants_swap_before smax_smax_smax_reassoc_constants_swap_combined
  simp_alive_peephole
  sorry
def smin_smin_smin_reassoc_constants_combined := [llvmfunc|
  llvm.func @smin_smin_smin_reassoc_constants(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.intr.smin(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.intr.smin(%1, %0)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

theorem inst_combine_smin_smin_smin_reassoc_constants   : smin_smin_smin_reassoc_constants_before  ⊑  smin_smin_smin_reassoc_constants_combined := by
  unfold smin_smin_smin_reassoc_constants_before smin_smin_smin_reassoc_constants_combined
  simp_alive_peephole
  sorry
def umax_umax_reassoc_constantexpr_sink_combined := [llvmfunc|
  llvm.func @umax_umax_reassoc_constantexpr_sink(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.addressof @umax_umax_reassoc_constantexpr_sink : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i8
    %2 = llvm.mlir.constant(42 : i8) : i8
    %3 = llvm.intr.umax(%arg0, %1)  : (i8, i8) -> i8
    %4 = llvm.intr.umax(%3, %2)  : (i8, i8) -> i8
    llvm.return %4 : i8
  }]

theorem inst_combine_umax_umax_reassoc_constantexpr_sink   : umax_umax_reassoc_constantexpr_sink_before  ⊑  umax_umax_reassoc_constantexpr_sink_combined := by
  unfold umax_umax_reassoc_constantexpr_sink_before umax_umax_reassoc_constantexpr_sink_combined
  simp_alive_peephole
  sorry
def smax_unary_shuffle_ops_combined := [llvmfunc|
  llvm.func @smax_unary_shuffle_ops(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.poison : vector<3xi8>
    %1 = llvm.intr.smax(%arg0, %arg1)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    %2 = llvm.shufflevector %1, %0 [1, 0, 2] : vector<3xi8> 
    llvm.return %2 : vector<3xi8>
  }]

theorem inst_combine_smax_unary_shuffle_ops   : smax_unary_shuffle_ops_before  ⊑  smax_unary_shuffle_ops_combined := by
  unfold smax_unary_shuffle_ops_before smax_unary_shuffle_ops_combined
  simp_alive_peephole
  sorry
def smin_unary_shuffle_ops_use_poison_mask_elt_combined := [llvmfunc|
  llvm.func @smin_unary_shuffle_ops_use_poison_mask_elt(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.poison : vector<3xi8>
    %1 = llvm.shufflevector %arg0, %0 [-1, 0, 2] : vector<3xi8> 
    llvm.call @use_vec(%1) : (vector<3xi8>) -> ()
    %2 = llvm.intr.smin(%arg0, %arg1)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    %3 = llvm.shufflevector %2, %0 [-1, 0, 2] : vector<3xi8> 
    llvm.return %3 : vector<3xi8>
  }]

theorem inst_combine_smin_unary_shuffle_ops_use_poison_mask_elt   : smin_unary_shuffle_ops_use_poison_mask_elt_before  ⊑  smin_unary_shuffle_ops_use_poison_mask_elt_combined := by
  unfold smin_unary_shuffle_ops_use_poison_mask_elt_before smin_unary_shuffle_ops_use_poison_mask_elt_combined
  simp_alive_peephole
  sorry
def umax_unary_shuffle_ops_use_widening_combined := [llvmfunc|
  llvm.func @umax_unary_shuffle_ops_use_widening(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.shufflevector %arg1, %0 [1, 0, 0] : vector<2xi8> 
    llvm.call @use_vec(%1) : (vector<3xi8>) -> ()
    %2 = llvm.intr.umax(%arg0, %arg1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %3 = llvm.shufflevector %2, %0 [1, 0, 0] : vector<2xi8> 
    llvm.return %3 : vector<3xi8>
  }]

theorem inst_combine_umax_unary_shuffle_ops_use_widening   : umax_unary_shuffle_ops_use_widening_before  ⊑  umax_unary_shuffle_ops_use_widening_combined := by
  unfold umax_unary_shuffle_ops_use_widening_before umax_unary_shuffle_ops_use_widening_combined
  simp_alive_peephole
  sorry
def umin_unary_shuffle_ops_narrowing_combined := [llvmfunc|
  llvm.func @umin_unary_shuffle_ops_narrowing(%arg0: vector<4xi8>, %arg1: vector<4xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.intr.umin(%arg0, %arg1)  : (vector<4xi8>, vector<4xi8>) -> vector<4xi8>
    %2 = llvm.shufflevector %1, %0 [1, 0, 3] : vector<4xi8> 
    llvm.return %2 : vector<3xi8>
  }]

theorem inst_combine_umin_unary_shuffle_ops_narrowing   : umin_unary_shuffle_ops_narrowing_before  ⊑  umin_unary_shuffle_ops_narrowing_combined := by
  unfold umin_unary_shuffle_ops_narrowing_before umin_unary_shuffle_ops_narrowing_combined
  simp_alive_peephole
  sorry
def smax_unary_shuffle_ops_unshuffled_op_combined := [llvmfunc|
  llvm.func @smax_unary_shuffle_ops_unshuffled_op(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.poison : vector<3xi8>
    %1 = llvm.shufflevector %arg0, %0 [0, 0, 2] : vector<3xi8> 
    %2 = llvm.intr.smax(%1, %arg1)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %2 : vector<3xi8>
  }]

theorem inst_combine_smax_unary_shuffle_ops_unshuffled_op   : smax_unary_shuffle_ops_unshuffled_op_before  ⊑  smax_unary_shuffle_ops_unshuffled_op_combined := by
  unfold smax_unary_shuffle_ops_unshuffled_op_before smax_unary_shuffle_ops_unshuffled_op_combined
  simp_alive_peephole
  sorry
def smax_unary_shuffle_ops_wrong_mask_combined := [llvmfunc|
  llvm.func @smax_unary_shuffle_ops_wrong_mask(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.poison : vector<3xi8>
    %1 = llvm.shufflevector %arg0, %0 [0, 0, 2] : vector<3xi8> 
    %2 = llvm.shufflevector %arg1, %0 [1, 0, 2] : vector<3xi8> 
    %3 = llvm.intr.smax(%1, %2)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %3 : vector<3xi8>
  }]

theorem inst_combine_smax_unary_shuffle_ops_wrong_mask   : smax_unary_shuffle_ops_wrong_mask_before  ⊑  smax_unary_shuffle_ops_wrong_mask_combined := by
  unfold smax_unary_shuffle_ops_wrong_mask_before smax_unary_shuffle_ops_wrong_mask_combined
  simp_alive_peephole
  sorry
def smax_unary_shuffle_ops_wrong_shuf_combined := [llvmfunc|
  llvm.func @smax_unary_shuffle_ops_wrong_shuf(%arg0: vector<3xi8>, %arg1: vector<3xi8>, %arg2: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.shufflevector %arg0, %arg2 [1, 0, 3] : vector<3xi8> 
    %1 = llvm.shufflevector %arg1, %arg2 [1, 0, 3] : vector<3xi8> 
    %2 = llvm.intr.smax(%0, %1)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %2 : vector<3xi8>
  }]

theorem inst_combine_smax_unary_shuffle_ops_wrong_shuf   : smax_unary_shuffle_ops_wrong_shuf_before  ⊑  smax_unary_shuffle_ops_wrong_shuf_combined := by
  unfold smax_unary_shuffle_ops_wrong_shuf_before smax_unary_shuffle_ops_wrong_shuf_combined
  simp_alive_peephole
  sorry
def smin_unary_shuffle_ops_uses_combined := [llvmfunc|
  llvm.func @smin_unary_shuffle_ops_uses(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.poison : vector<3xi8>
    %1 = llvm.shufflevector %arg0, %0 [1, 0, 2] : vector<3xi8> 
    llvm.call @use_vec(%1) : (vector<3xi8>) -> ()
    %2 = llvm.shufflevector %arg1, %0 [1, 0, 2] : vector<3xi8> 
    llvm.call @use_vec(%2) : (vector<3xi8>) -> ()
    %3 = llvm.intr.smin(%1, %2)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %3 : vector<3xi8>
  }]

theorem inst_combine_smin_unary_shuffle_ops_uses   : smin_unary_shuffle_ops_uses_before  ⊑  smin_unary_shuffle_ops_uses_combined := by
  unfold smin_unary_shuffle_ops_uses_before smin_unary_shuffle_ops_uses_combined
  simp_alive_peephole
  sorry
def PR57986_combined := [llvmfunc|
  llvm.func @PR57986() -> i1 {
    %0 = llvm.mlir.addressof @g : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i1
    llvm.return %1 : i1
  }]

theorem inst_combine_PR57986   : PR57986_before  ⊑  PR57986_combined := by
  unfold PR57986_before PR57986_combined
  simp_alive_peephole
  sorry
def fold_umax_with_knownbits_info_combined := [llvmfunc|
  llvm.func @fold_umax_with_knownbits_info(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.or %arg0, %0  : i8
    %2 = llvm.shl %arg1, %0  : i8
    %3 = llvm.sub %1, %2  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_fold_umax_with_knownbits_info   : fold_umax_with_knownbits_info_before  ⊑  fold_umax_with_knownbits_info_combined := by
  unfold fold_umax_with_knownbits_info_before fold_umax_with_knownbits_info_combined
  simp_alive_peephole
  sorry
def fold_umax_with_knownbits_info_poison_in_splat_combined := [llvmfunc|
  llvm.func @fold_umax_with_knownbits_info_poison_in_splat(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<1> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.or %arg0, %0  : vector<3xi8>
    %2 = llvm.shl %arg1, %0  : vector<3xi8>
    %3 = llvm.sub %1, %2  : vector<3xi8>
    llvm.return %3 : vector<3xi8>
  }]

theorem inst_combine_fold_umax_with_knownbits_info_poison_in_splat   : fold_umax_with_knownbits_info_poison_in_splat_before  ⊑  fold_umax_with_knownbits_info_poison_in_splat_combined := by
  unfold fold_umax_with_knownbits_info_poison_in_splat_before fold_umax_with_knownbits_info_poison_in_splat_combined
  simp_alive_peephole
  sorry
def fold_umin_with_knownbits_info_combined := [llvmfunc|
  llvm.func @fold_umin_with_knownbits_info(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_fold_umin_with_knownbits_info   : fold_umin_with_knownbits_info_before  ⊑  fold_umin_with_knownbits_info_combined := by
  unfold fold_umin_with_knownbits_info_before fold_umin_with_knownbits_info_combined
  simp_alive_peephole
  sorry
def fold_umin_with_knownbits_info_poison_in_splat_combined := [llvmfunc|
  llvm.func @fold_umin_with_knownbits_info_poison_in_splat(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<3> : vector<3xi8>) : vector<3xi8>
    llvm.return %0 : vector<3xi8>
  }]

theorem inst_combine_fold_umin_with_knownbits_info_poison_in_splat   : fold_umin_with_knownbits_info_poison_in_splat_before  ⊑  fold_umin_with_knownbits_info_poison_in_splat_combined := by
  unfold fold_umin_with_knownbits_info_poison_in_splat_before fold_umin_with_knownbits_info_poison_in_splat_combined
  simp_alive_peephole
  sorry
def fold_umax_with_knownbits_info_fail_combined := [llvmfunc|
  llvm.func @fold_umax_with_knownbits_info_fail(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.shl %arg1, %1  : i8
    %4 = llvm.sub %2, %3  : i8
    %5 = llvm.intr.umax(%4, %1)  : (i8, i8) -> i8
    llvm.return %5 : i8
  }]

theorem inst_combine_fold_umax_with_knownbits_info_fail   : fold_umax_with_knownbits_info_fail_before  ⊑  fold_umax_with_knownbits_info_fail_combined := by
  unfold fold_umax_with_knownbits_info_fail_before fold_umax_with_knownbits_info_fail_combined
  simp_alive_peephole
  sorry
def fold_umin_with_knownbits_info_fail_combined := [llvmfunc|
  llvm.func @fold_umin_with_knownbits_info_fail(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.or %arg0, %0  : i8
    %4 = llvm.shl %arg1, %1  : i8
    %5 = llvm.sub %3, %4  : i8
    %6 = llvm.intr.umin(%5, %2)  : (i8, i8) -> i8
    llvm.return %6 : i8
  }]

theorem inst_combine_fold_umin_with_knownbits_info_fail   : fold_umin_with_knownbits_info_fail_before  ⊑  fold_umin_with_knownbits_info_fail_combined := by
  unfold fold_umin_with_knownbits_info_fail_before fold_umin_with_knownbits_info_fail_combined
  simp_alive_peephole
  sorry
def test_umax_and_combined := [llvmfunc|
  llvm.func @test_umax_and(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-64 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.and %arg1, %0  : i8
    %3 = llvm.intr.umax(%1, %2)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

theorem inst_combine_test_umax_and   : test_umax_and_before  ⊑  test_umax_and_combined := by
  unfold test_umax_and_before test_umax_and_combined
  simp_alive_peephole
  sorry
def test_umin_and_combined := [llvmfunc|
  llvm.func @test_umin_and(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-64 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.and %arg1, %0  : i8
    %3 = llvm.intr.umin(%1, %2)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

theorem inst_combine_test_umin_and   : test_umin_and_before  ⊑  test_umin_and_combined := by
  unfold test_umin_and_before test_umin_and_combined
  simp_alive_peephole
  sorry
def test_smax_and_combined := [llvmfunc|
  llvm.func @test_smax_and(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-64 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.and %arg1, %0  : i8
    %3 = llvm.intr.smax(%1, %2)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

theorem inst_combine_test_smax_and   : test_smax_and_before  ⊑  test_smax_and_combined := by
  unfold test_smax_and_before test_smax_and_combined
  simp_alive_peephole
  sorry
def test_smin_and_combined := [llvmfunc|
  llvm.func @test_smin_and(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-64 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.and %arg1, %0  : i8
    %3 = llvm.intr.smin(%1, %2)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

theorem inst_combine_test_smin_and   : test_smin_and_before  ⊑  test_smin_and_combined := by
  unfold test_smin_and_before test_smin_and_combined
  simp_alive_peephole
  sorry
def test_smin_and_mismatch_combined := [llvmfunc|
  llvm.func @test_smin_and_mismatch(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-64 : i8) : i8
    %1 = llvm.mlir.constant(-32 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.intr.smin(%2, %3)  : (i8, i8) -> i8
    llvm.return %4 : i8
  }]

theorem inst_combine_test_smin_and_mismatch   : test_smin_and_mismatch_before  ⊑  test_smin_and_mismatch_combined := by
  unfold test_smin_and_mismatch_before test_smin_and_mismatch_combined
  simp_alive_peephole
  sorry
def test_smin_and_non_negated_pow2_combined := [llvmfunc|
  llvm.func @test_smin_and_non_negated_pow2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(31 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.and %arg1, %0  : i8
    %3 = llvm.intr.smin(%1, %2)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

theorem inst_combine_test_smin_and_non_negated_pow2   : test_smin_and_non_negated_pow2_before  ⊑  test_smin_and_non_negated_pow2_combined := by
  unfold test_smin_and_non_negated_pow2_before test_smin_and_non_negated_pow2_combined
  simp_alive_peephole
  sorry
def test_smin_and_multiuse_combined := [llvmfunc|
  llvm.func @test_smin_and_multiuse(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(31 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.and %arg1, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.intr.smin(%1, %2)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

theorem inst_combine_test_smin_and_multiuse   : test_smin_and_multiuse_before  ⊑  test_smin_and_multiuse_combined := by
  unfold test_smin_and_multiuse_before test_smin_and_multiuse_combined
  simp_alive_peephole
  sorry
