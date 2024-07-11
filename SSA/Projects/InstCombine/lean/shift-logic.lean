import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  shift-logic
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def shl_and_before := [llvmfunc|
  llvm.func @shl_and(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.and %2, %arg1  : i8
    %4 = llvm.shl %3, %1  : i8
    llvm.return %4 : i8
  }]

def shl_and_nonuniform_before := [llvmfunc|
  llvm.func @shl_and_nonuniform(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[3, 4]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[2, 0]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %arg0, %0  : vector<2xi8>
    %3 = llvm.and %2, %arg1  : vector<2xi8>
    %4 = llvm.shl %3, %1  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

def shl_or_before := [llvmfunc|
  llvm.func @shl_or(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(42 : i16) : i16
    %1 = llvm.mlir.constant(5 : i16) : i16
    %2 = llvm.mlir.constant(7 : i16) : i16
    %3 = llvm.srem %arg1, %0  : i16
    %4 = llvm.shl %arg0, %1  : i16
    %5 = llvm.or %3, %4  : i16
    %6 = llvm.shl %5, %2  : i16
    llvm.return %6 : i16
  }]

def shl_or_poison_before := [llvmfunc|
  llvm.func @shl_or_poison(%arg0: vector<2xi16>, %arg1: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.poison : i16
    %2 = llvm.mlir.constant(5 : i16) : i16
    %3 = llvm.mlir.undef : vector<2xi16>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi16>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi16>
    %8 = llvm.mlir.constant(7 : i16) : i16
    %9 = llvm.mlir.undef : vector<2xi16>
    %10 = llvm.mlir.constant(0 : i32) : i32
    %11 = llvm.insertelement %8, %9[%10 : i32] : vector<2xi16>
    %12 = llvm.mlir.constant(1 : i32) : i32
    %13 = llvm.insertelement %1, %11[%12 : i32] : vector<2xi16>
    %14 = llvm.srem %arg1, %0  : vector<2xi16>
    %15 = llvm.shl %arg0, %7  : vector<2xi16>
    %16 = llvm.or %14, %15  : vector<2xi16>
    %17 = llvm.shl %16, %13  : vector<2xi16>
    llvm.return %17 : vector<2xi16>
  }]

def shl_xor_before := [llvmfunc|
  llvm.func @shl_xor(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.xor %2, %arg1  : i32
    %4 = llvm.shl %3, %1  : i32
    llvm.return %4 : i32
  }]

def shl_xor_nonuniform_before := [llvmfunc|
  llvm.func @shl_xor_nonuniform(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[5, 6]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[7, 8]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.shl %arg0, %0  : vector<2xi32>
    %3 = llvm.xor %2, %arg1  : vector<2xi32>
    %4 = llvm.shl %3, %1  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def lshr_and_before := [llvmfunc|
  llvm.func @lshr_and(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(42 : i64) : i64
    %1 = llvm.mlir.constant(5 : i64) : i64
    %2 = llvm.mlir.constant(7 : i64) : i64
    %3 = llvm.srem %arg1, %0  : i64
    %4 = llvm.lshr %arg0, %1  : i64
    %5 = llvm.and %3, %4  : i64
    %6 = llvm.lshr %5, %2  : i64
    llvm.return %6 : i64
  }]

def lshr_and_poison_before := [llvmfunc|
  llvm.func @lshr_and_poison(%arg0: vector<2xi64>, %arg1: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.poison : i64
    %2 = llvm.mlir.constant(5 : i64) : i64
    %3 = llvm.mlir.undef : vector<2xi64>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi64>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi64>
    %8 = llvm.mlir.constant(7 : i64) : i64
    %9 = llvm.mlir.undef : vector<2xi64>
    %10 = llvm.mlir.constant(0 : i32) : i32
    %11 = llvm.insertelement %8, %9[%10 : i32] : vector<2xi64>
    %12 = llvm.mlir.constant(1 : i32) : i32
    %13 = llvm.insertelement %1, %11[%12 : i32] : vector<2xi64>
    %14 = llvm.srem %arg1, %0  : vector<2xi64>
    %15 = llvm.lshr %arg0, %7  : vector<2xi64>
    %16 = llvm.and %14, %15  : vector<2xi64>
    %17 = llvm.lshr %16, %13  : vector<2xi64>
    llvm.return %17 : vector<2xi64>
  }]

def lshr_or_before := [llvmfunc|
  llvm.func @lshr_or(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<5> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<7> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.lshr %arg0, %0  : vector<4xi32>
    %3 = llvm.or %2, %arg1  : vector<4xi32>
    %4 = llvm.lshr %3, %1  : vector<4xi32>
    llvm.return %4 : vector<4xi32>
  }]

def lshr_xor_before := [llvmfunc|
  llvm.func @lshr_xor(%arg0: vector<8xi16>, %arg1: vector<8xi16>) -> vector<8xi16> {
    %0 = llvm.mlir.constant(dense<[42, 42, 42, 42, 42, 42, 42, -42]> : vector<8xi16>) : vector<8xi16>
    %1 = llvm.mlir.constant(dense<5> : vector<8xi16>) : vector<8xi16>
    %2 = llvm.mlir.constant(dense<7> : vector<8xi16>) : vector<8xi16>
    %3 = llvm.srem %arg1, %0  : vector<8xi16>
    %4 = llvm.lshr %arg0, %1  : vector<8xi16>
    %5 = llvm.xor %3, %4  : vector<8xi16>
    %6 = llvm.lshr %5, %2  : vector<8xi16>
    llvm.return %6 : vector<8xi16>
  }]

def ashr_and_before := [llvmfunc|
  llvm.func @ashr_and(%arg0: vector<16xi8>, %arg1: vector<16xi8>, %arg2: vector<16xi8>) -> vector<16xi8> {
    %0 = llvm.mlir.constant(dense<3> : vector<16xi8>) : vector<16xi8>
    %1 = llvm.mlir.constant(dense<2> : vector<16xi8>) : vector<16xi8>
    %2 = llvm.srem %arg1, %arg2  : vector<16xi8>
    %3 = llvm.ashr %arg0, %0  : vector<16xi8>
    %4 = llvm.and %2, %3  : vector<16xi8>
    %5 = llvm.ashr %4, %1  : vector<16xi8>
    llvm.return %5 : vector<16xi8>
  }]

def ashr_or_before := [llvmfunc|
  llvm.func @ashr_or(%arg0: vector<2xi64>, %arg1: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<7> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.ashr %arg0, %0  : vector<2xi64>
    %3 = llvm.or %2, %arg1  : vector<2xi64>
    %4 = llvm.ashr %3, %1  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

def ashr_xor_before := [llvmfunc|
  llvm.func @ashr_xor(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.srem %arg1, %0  : i32
    %4 = llvm.ashr %arg0, %1  : i32
    %5 = llvm.xor %3, %4  : i32
    %6 = llvm.ashr %5, %2  : i32
    llvm.return %6 : i32
  }]

def shr_mismatch_xor_before := [llvmfunc|
  llvm.func @shr_mismatch_xor(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.xor %arg1, %2  : i32
    %4 = llvm.lshr %3, %1  : i32
    llvm.return %4 : i32
  }]

def ashr_overshift_xor_before := [llvmfunc|
  llvm.func @ashr_overshift_xor(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(17 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.xor %arg1, %2  : i32
    %4 = llvm.ashr %3, %1  : i32
    llvm.return %4 : i32
  }]

def ashr_poison_poison_xor_before := [llvmfunc|
  llvm.func @ashr_poison_poison_xor(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(17 : i32) : i32
    %8 = llvm.mlir.undef : vector<2xi32>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<2xi32>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %7, %10[%11 : i32] : vector<2xi32>
    %13 = llvm.ashr %arg0, %6  : vector<2xi32>
    %14 = llvm.xor %arg1, %13  : vector<2xi32>
    %15 = llvm.ashr %14, %12  : vector<2xi32>
    llvm.return %15 : vector<2xi32>
  }]

def lshr_or_extra_use_before := [llvmfunc|
  llvm.func @lshr_or_extra_use(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.or %2, %arg1  : i32
    llvm.store %3, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

    %4 = llvm.lshr %3, %1  : i32
    llvm.return %4 : i32
  }]

def PR44028_before := [llvmfunc|
  llvm.func @PR44028(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.addressof @g : !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i32
    %3 = llvm.ashr %arg0, %0  : i32
    %4 = llvm.shl %2, %0  : i32
    %5 = llvm.xor %3, %4  : i32
    %6 = llvm.ashr %5, %0  : i32
    llvm.return %6 : i32
  }]

def lshr_mul_before := [llvmfunc|
  llvm.func @lshr_mul(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(52 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : i64
    %3 = llvm.lshr %2, %1  : i64
    llvm.return %3 : i64
  }]

def lshr_mul_nuw_nsw_before := [llvmfunc|
  llvm.func @lshr_mul_nuw_nsw(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(52 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.mul %arg0, %0 overflow<nsw, nuw>  : i64
    %3 = llvm.lshr %2, %1  : i64
    llvm.return %3 : i64
  }]

def lshr_mul_vector_before := [llvmfunc|
  llvm.func @lshr_mul_vector(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<52> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : vector<4xi32>
    %3 = llvm.lshr %2, %1  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }]

def lshr_mul_negative_noexact_before := [llvmfunc|
  llvm.func @lshr_mul_negative_noexact(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(53 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : i64
    %3 = llvm.lshr %2, %1  : i64
    llvm.return %3 : i64
  }]

def lshr_mul_negative_oneuse_before := [llvmfunc|
  llvm.func @lshr_mul_negative_oneuse(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(52 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : i64
    llvm.call @use(%2) : (i64) -> ()
    %3 = llvm.lshr %2, %1  : i64
    llvm.return %3 : i64
  }]

def lshr_mul_negative_nonuw_before := [llvmfunc|
  llvm.func @lshr_mul_negative_nonuw(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(52 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.mul %arg0, %0  : i64
    %3 = llvm.lshr %2, %1  : i64
    llvm.return %3 : i64
  }]

def lshr_mul_negative_nsw_before := [llvmfunc|
  llvm.func @lshr_mul_negative_nsw(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(52 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i64
    %3 = llvm.lshr %2, %1  : i64
    llvm.return %3 : i64
  }]

def shl_add_before := [llvmfunc|
  llvm.func @shl_add(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.add %2, %arg1  : i8
    %4 = llvm.shl %3, %1  : i8
    llvm.return %4 : i8
  }]

def shl_add_multiuse_before := [llvmfunc|
  llvm.func @shl_add_multiuse(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(-42 : i8) : i8
    %2 = llvm.mlir.addressof @use : !llvm.ptr
    %3 = llvm.mlir.constant(2 : i8) : i8
    %4 = llvm.shl %arg0, %0  : i8
    %5 = llvm.add %4, %1  : i8
    llvm.call %2(%4) : !llvm.ptr, (i8) -> ()
    %6 = llvm.shl %5, %3  : i8
    llvm.return %6 : i8
  }]

def shl_add_multiuse_nonconstant_before := [llvmfunc|
  llvm.func @shl_add_multiuse_nonconstant(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.addressof @use : !llvm.ptr
    %2 = llvm.mlir.constant(2 : i8) : i8
    %3 = llvm.shl %arg0, %0  : i8
    %4 = llvm.add %3, %arg1  : i8
    llvm.call %1(%3) : !llvm.ptr, (i8) -> ()
    %5 = llvm.shl %4, %2  : i8
    llvm.return %5 : i8
  }]

def shl_add_nonuniform_before := [llvmfunc|
  llvm.func @shl_add_nonuniform(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[3, 4]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[2, 0]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %arg0, %0  : vector<2xi8>
    %3 = llvm.add %2, %arg1  : vector<2xi8>
    %4 = llvm.shl %3, %1  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

def shl_add_poison_before := [llvmfunc|
  llvm.func @shl_add_poison(%arg0: vector<2xi64>, %arg1: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.poison : i64
    %2 = llvm.mlir.constant(5 : i64) : i64
    %3 = llvm.mlir.undef : vector<2xi64>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi64>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi64>
    %8 = llvm.mlir.constant(7 : i64) : i64
    %9 = llvm.mlir.undef : vector<2xi64>
    %10 = llvm.mlir.constant(0 : i32) : i32
    %11 = llvm.insertelement %8, %9[%10 : i32] : vector<2xi64>
    %12 = llvm.mlir.constant(1 : i32) : i32
    %13 = llvm.insertelement %1, %11[%12 : i32] : vector<2xi64>
    %14 = llvm.srem %arg1, %0  : vector<2xi64>
    %15 = llvm.shl %arg0, %7  : vector<2xi64>
    %16 = llvm.add %14, %15  : vector<2xi64>
    %17 = llvm.shl %16, %13  : vector<2xi64>
    llvm.return %17 : vector<2xi64>
  }]

def lshr_add_before := [llvmfunc|
  llvm.func @lshr_add(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.add %2, %arg1  : i8
    %4 = llvm.lshr %3, %1  : i8
    llvm.return %4 : i8
  }]

def lshr_add_nonuniform_before := [llvmfunc|
  llvm.func @lshr_add_nonuniform(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[3, 4]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[2, 0]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.lshr %arg0, %0  : vector<2xi8>
    %3 = llvm.add %2, %arg1  : vector<2xi8>
    %4 = llvm.lshr %3, %1  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

def lshr_add_poison_before := [llvmfunc|
  llvm.func @lshr_add_poison(%arg0: vector<2xi64>, %arg1: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.poison : i64
    %2 = llvm.mlir.constant(5 : i64) : i64
    %3 = llvm.mlir.undef : vector<2xi64>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi64>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi64>
    %8 = llvm.mlir.constant(7 : i64) : i64
    %9 = llvm.mlir.undef : vector<2xi64>
    %10 = llvm.mlir.constant(0 : i32) : i32
    %11 = llvm.insertelement %8, %9[%10 : i32] : vector<2xi64>
    %12 = llvm.mlir.constant(1 : i32) : i32
    %13 = llvm.insertelement %1, %11[%12 : i32] : vector<2xi64>
    %14 = llvm.srem %arg1, %0  : vector<2xi64>
    %15 = llvm.lshr %arg0, %7  : vector<2xi64>
    %16 = llvm.add %14, %15  : vector<2xi64>
    %17 = llvm.lshr %16, %13  : vector<2xi64>
    llvm.return %17 : vector<2xi64>
  }]

def shl_sub_before := [llvmfunc|
  llvm.func @shl_sub(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.sub %2, %arg1  : i8
    %4 = llvm.shl %3, %1  : i8
    llvm.return %4 : i8
  }]

def shl_sub_no_commute_before := [llvmfunc|
  llvm.func @shl_sub_no_commute(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.shl %arg1, %0  : i8
    %3 = llvm.sub %arg0, %2  : i8
    %4 = llvm.shl %3, %1  : i8
    llvm.return %4 : i8
  }]

def shl_sub_nonuniform_before := [llvmfunc|
  llvm.func @shl_sub_nonuniform(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[3, 4]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[2, 0]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %arg0, %0  : vector<2xi8>
    %3 = llvm.sub %2, %arg1  : vector<2xi8>
    %4 = llvm.shl %3, %1  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

def shl_sub_poison_before := [llvmfunc|
  llvm.func @shl_sub_poison(%arg0: vector<2xi64>, %arg1: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.poison : i64
    %2 = llvm.mlir.constant(5 : i64) : i64
    %3 = llvm.mlir.undef : vector<2xi64>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi64>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi64>
    %8 = llvm.mlir.constant(7 : i64) : i64
    %9 = llvm.mlir.undef : vector<2xi64>
    %10 = llvm.mlir.constant(0 : i32) : i32
    %11 = llvm.insertelement %8, %9[%10 : i32] : vector<2xi64>
    %12 = llvm.mlir.constant(1 : i32) : i32
    %13 = llvm.insertelement %1, %11[%12 : i32] : vector<2xi64>
    %14 = llvm.srem %arg1, %0  : vector<2xi64>
    %15 = llvm.shl %arg0, %7  : vector<2xi64>
    %16 = llvm.sub %14, %15  : vector<2xi64>
    %17 = llvm.shl %16, %13  : vector<2xi64>
    llvm.return %17 : vector<2xi64>
  }]

def lshr_sub_before := [llvmfunc|
  llvm.func @lshr_sub(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.sub %2, %arg1  : i8
    %4 = llvm.lshr %3, %1  : i8
    llvm.return %4 : i8
  }]

def lshr_sub_nonuniform_before := [llvmfunc|
  llvm.func @lshr_sub_nonuniform(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[3, 4]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[2, 0]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.lshr %arg0, %0  : vector<2xi8>
    %3 = llvm.sub %2, %arg1  : vector<2xi8>
    %4 = llvm.lshr %3, %1  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

def lshr_sub_poison_before := [llvmfunc|
  llvm.func @lshr_sub_poison(%arg0: vector<2xi64>, %arg1: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.poison : i64
    %2 = llvm.mlir.constant(5 : i64) : i64
    %3 = llvm.mlir.undef : vector<2xi64>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi64>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi64>
    %8 = llvm.mlir.constant(7 : i64) : i64
    %9 = llvm.mlir.undef : vector<2xi64>
    %10 = llvm.mlir.constant(0 : i32) : i32
    %11 = llvm.insertelement %8, %9[%10 : i32] : vector<2xi64>
    %12 = llvm.mlir.constant(1 : i32) : i32
    %13 = llvm.insertelement %1, %11[%12 : i32] : vector<2xi64>
    %14 = llvm.srem %arg1, %0  : vector<2xi64>
    %15 = llvm.lshr %arg0, %7  : vector<2xi64>
    %16 = llvm.sub %14, %15  : vector<2xi64>
    %17 = llvm.lshr %16, %13  : vector<2xi64>
    llvm.return %17 : vector<2xi64>
  }]

def shl_and_combined := [llvmfunc|
  llvm.func @shl_and(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.shl %arg1, %1  : i8
    %4 = llvm.and %2, %3  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_shl_and   : shl_and_before  ⊑  shl_and_combined := by
  unfold shl_and_before shl_and_combined
  simp_alive_peephole
  sorry
def shl_and_nonuniform_combined := [llvmfunc|
  llvm.func @shl_and_nonuniform(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[5, 4]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[2, 0]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %arg0, %0  : vector<2xi8>
    %3 = llvm.shl %arg1, %1  : vector<2xi8>
    %4 = llvm.and %2, %3  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

theorem inst_combine_shl_and_nonuniform   : shl_and_nonuniform_before  ⊑  shl_and_nonuniform_combined := by
  unfold shl_and_nonuniform_before shl_and_nonuniform_combined
  simp_alive_peephole
  sorry
def shl_or_combined := [llvmfunc|
  llvm.func @shl_or(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(42 : i16) : i16
    %1 = llvm.mlir.constant(12 : i16) : i16
    %2 = llvm.mlir.constant(7 : i16) : i16
    %3 = llvm.srem %arg1, %0  : i16
    %4 = llvm.shl %arg0, %1  : i16
    %5 = llvm.shl %3, %2 overflow<nsw>  : i16
    %6 = llvm.or %4, %5  : i16
    llvm.return %6 : i16
  }]

theorem inst_combine_shl_or   : shl_or_before  ⊑  shl_or_combined := by
  unfold shl_or_before shl_or_combined
  simp_alive_peephole
  sorry
def shl_or_poison_combined := [llvmfunc|
  llvm.func @shl_or_poison(%arg0: vector<2xi16>, %arg1: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.poison : i16
    %2 = llvm.mlir.constant(12 : i16) : i16
    %3 = llvm.mlir.undef : vector<2xi16>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi16>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi16>
    %8 = llvm.mlir.constant(7 : i16) : i16
    %9 = llvm.mlir.undef : vector<2xi16>
    %10 = llvm.mlir.constant(0 : i32) : i32
    %11 = llvm.insertelement %8, %9[%10 : i32] : vector<2xi16>
    %12 = llvm.mlir.constant(1 : i32) : i32
    %13 = llvm.insertelement %1, %11[%12 : i32] : vector<2xi16>
    %14 = llvm.srem %arg1, %0  : vector<2xi16>
    %15 = llvm.shl %arg0, %7  : vector<2xi16>
    %16 = llvm.shl %14, %13 overflow<nsw>  : vector<2xi16>
    %17 = llvm.or %15, %16  : vector<2xi16>
    llvm.return %17 : vector<2xi16>
  }]

theorem inst_combine_shl_or_poison   : shl_or_poison_before  ⊑  shl_or_poison_combined := by
  unfold shl_or_poison_before shl_or_poison_combined
  simp_alive_peephole
  sorry
def shl_xor_combined := [llvmfunc|
  llvm.func @shl_xor(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.shl %arg1, %1  : i32
    %4 = llvm.xor %2, %3  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_shl_xor   : shl_xor_before  ⊑  shl_xor_combined := by
  unfold shl_xor_before shl_xor_combined
  simp_alive_peephole
  sorry
def shl_xor_nonuniform_combined := [llvmfunc|
  llvm.func @shl_xor_nonuniform(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[12, 14]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[7, 8]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.shl %arg0, %0  : vector<2xi32>
    %3 = llvm.shl %arg1, %1  : vector<2xi32>
    %4 = llvm.xor %2, %3  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

theorem inst_combine_shl_xor_nonuniform   : shl_xor_nonuniform_before  ⊑  shl_xor_nonuniform_combined := by
  unfold shl_xor_nonuniform_before shl_xor_nonuniform_combined
  simp_alive_peephole
  sorry
def lshr_and_combined := [llvmfunc|
  llvm.func @lshr_and(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(42 : i64) : i64
    %1 = llvm.mlir.constant(12 : i64) : i64
    %2 = llvm.mlir.constant(7 : i64) : i64
    %3 = llvm.srem %arg1, %0  : i64
    %4 = llvm.lshr %arg0, %1  : i64
    %5 = llvm.lshr %3, %2  : i64
    %6 = llvm.and %4, %5  : i64
    llvm.return %6 : i64
  }]

theorem inst_combine_lshr_and   : lshr_and_before  ⊑  lshr_and_combined := by
  unfold lshr_and_before lshr_and_combined
  simp_alive_peephole
  sorry
def lshr_and_poison_combined := [llvmfunc|
  llvm.func @lshr_and_poison(%arg0: vector<2xi64>, %arg1: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.poison : i64
    %2 = llvm.mlir.constant(12 : i64) : i64
    %3 = llvm.mlir.undef : vector<2xi64>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi64>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi64>
    %8 = llvm.mlir.constant(7 : i64) : i64
    %9 = llvm.mlir.undef : vector<2xi64>
    %10 = llvm.mlir.constant(0 : i32) : i32
    %11 = llvm.insertelement %8, %9[%10 : i32] : vector<2xi64>
    %12 = llvm.mlir.constant(1 : i32) : i32
    %13 = llvm.insertelement %1, %11[%12 : i32] : vector<2xi64>
    %14 = llvm.srem %arg1, %0  : vector<2xi64>
    %15 = llvm.lshr %arg0, %7  : vector<2xi64>
    %16 = llvm.lshr %14, %13  : vector<2xi64>
    %17 = llvm.and %15, %16  : vector<2xi64>
    llvm.return %17 : vector<2xi64>
  }]

theorem inst_combine_lshr_and_poison   : lshr_and_poison_before  ⊑  lshr_and_poison_combined := by
  unfold lshr_and_poison_before lshr_and_poison_combined
  simp_alive_peephole
  sorry
def lshr_or_combined := [llvmfunc|
  llvm.func @lshr_or(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<12> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<7> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.lshr %arg0, %0  : vector<4xi32>
    %3 = llvm.lshr %arg1, %1  : vector<4xi32>
    %4 = llvm.or %2, %3  : vector<4xi32>
    llvm.return %4 : vector<4xi32>
  }]

theorem inst_combine_lshr_or   : lshr_or_before  ⊑  lshr_or_combined := by
  unfold lshr_or_before lshr_or_combined
  simp_alive_peephole
  sorry
def lshr_xor_combined := [llvmfunc|
  llvm.func @lshr_xor(%arg0: vector<8xi16>, %arg1: vector<8xi16>) -> vector<8xi16> {
    %0 = llvm.mlir.constant(dense<42> : vector<8xi16>) : vector<8xi16>
    %1 = llvm.mlir.constant(dense<12> : vector<8xi16>) : vector<8xi16>
    %2 = llvm.mlir.constant(dense<7> : vector<8xi16>) : vector<8xi16>
    %3 = llvm.srem %arg1, %0  : vector<8xi16>
    %4 = llvm.lshr %arg0, %1  : vector<8xi16>
    %5 = llvm.lshr %3, %2  : vector<8xi16>
    %6 = llvm.xor %4, %5  : vector<8xi16>
    llvm.return %6 : vector<8xi16>
  }]

theorem inst_combine_lshr_xor   : lshr_xor_before  ⊑  lshr_xor_combined := by
  unfold lshr_xor_before lshr_xor_combined
  simp_alive_peephole
  sorry
def ashr_and_combined := [llvmfunc|
  llvm.func @ashr_and(%arg0: vector<16xi8>, %arg1: vector<16xi8>, %arg2: vector<16xi8>) -> vector<16xi8> {
    %0 = llvm.mlir.constant(dense<5> : vector<16xi8>) : vector<16xi8>
    %1 = llvm.mlir.constant(dense<2> : vector<16xi8>) : vector<16xi8>
    %2 = llvm.srem %arg1, %arg2  : vector<16xi8>
    %3 = llvm.ashr %arg0, %0  : vector<16xi8>
    %4 = llvm.ashr %2, %1  : vector<16xi8>
    %5 = llvm.and %3, %4  : vector<16xi8>
    llvm.return %5 : vector<16xi8>
  }]

theorem inst_combine_ashr_and   : ashr_and_before  ⊑  ashr_and_combined := by
  unfold ashr_and_before ashr_and_combined
  simp_alive_peephole
  sorry
def ashr_or_combined := [llvmfunc|
  llvm.func @ashr_or(%arg0: vector<2xi64>, %arg1: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<12> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<7> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.ashr %arg0, %0  : vector<2xi64>
    %3 = llvm.ashr %arg1, %1  : vector<2xi64>
    %4 = llvm.or %2, %3  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

theorem inst_combine_ashr_or   : ashr_or_before  ⊑  ashr_or_combined := by
  unfold ashr_or_before ashr_or_combined
  simp_alive_peephole
  sorry
def ashr_xor_combined := [llvmfunc|
  llvm.func @ashr_xor(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.srem %arg1, %0  : i32
    %4 = llvm.ashr %arg0, %1  : i32
    %5 = llvm.ashr %3, %2  : i32
    %6 = llvm.xor %4, %5  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_ashr_xor   : ashr_xor_before  ⊑  ashr_xor_combined := by
  unfold ashr_xor_before ashr_xor_combined
  simp_alive_peephole
  sorry
def shr_mismatch_xor_combined := [llvmfunc|
  llvm.func @shr_mismatch_xor(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.xor %2, %arg1  : i32
    %4 = llvm.lshr %3, %1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_shr_mismatch_xor   : shr_mismatch_xor_before  ⊑  shr_mismatch_xor_combined := by
  unfold shr_mismatch_xor_before shr_mismatch_xor_combined
  simp_alive_peephole
  sorry
def ashr_overshift_xor_combined := [llvmfunc|
  llvm.func @ashr_overshift_xor(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(17 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.xor %2, %arg1  : i32
    %4 = llvm.ashr %3, %1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_ashr_overshift_xor   : ashr_overshift_xor_before  ⊑  ashr_overshift_xor_combined := by
  unfold ashr_overshift_xor_before ashr_overshift_xor_combined
  simp_alive_peephole
  sorry
def ashr_poison_poison_xor_combined := [llvmfunc|
  llvm.func @ashr_poison_poison_xor(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(17 : i32) : i32
    %8 = llvm.mlir.undef : vector<2xi32>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<2xi32>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %7, %10[%11 : i32] : vector<2xi32>
    %13 = llvm.ashr %arg0, %6  : vector<2xi32>
    %14 = llvm.xor %13, %arg1  : vector<2xi32>
    %15 = llvm.ashr %14, %12  : vector<2xi32>
    llvm.return %15 : vector<2xi32>
  }]

theorem inst_combine_ashr_poison_poison_xor   : ashr_poison_poison_xor_before  ⊑  ashr_poison_poison_xor_combined := by
  unfold ashr_poison_poison_xor_before ashr_poison_poison_xor_combined
  simp_alive_peephole
  sorry
def lshr_or_extra_use_combined := [llvmfunc|
  llvm.func @lshr_or_extra_use(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.or %2, %arg1  : i32
    llvm.store %3, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr
    %4 = llvm.lshr %3, %1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_lshr_or_extra_use   : lshr_or_extra_use_before  ⊑  lshr_or_extra_use_combined := by
  unfold lshr_or_extra_use_before lshr_or_extra_use_combined
  simp_alive_peephole
  sorry
def PR44028_combined := [llvmfunc|
  llvm.func @PR44028(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.addressof @g : !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i32
    %3 = llvm.shl %2, %0  : i32
    %4 = llvm.ashr %arg0, %0  : i32
    %5 = llvm.xor %4, %3  : i32
    %6 = llvm.ashr %5, %0  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_PR44028   : PR44028_before  ⊑  PR44028_combined := by
  unfold PR44028_before PR44028_combined
  simp_alive_peephole
  sorry
def lshr_mul_combined := [llvmfunc|
  llvm.func @lshr_mul(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(13 : i64) : i64
    %1 = llvm.mul %arg0, %0 overflow<nsw, nuw>  : i64
    llvm.return %1 : i64
  }]

theorem inst_combine_lshr_mul   : lshr_mul_before  ⊑  lshr_mul_combined := by
  unfold lshr_mul_before lshr_mul_combined
  simp_alive_peephole
  sorry
def lshr_mul_nuw_nsw_combined := [llvmfunc|
  llvm.func @lshr_mul_nuw_nsw(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(13 : i64) : i64
    %1 = llvm.mul %arg0, %0 overflow<nsw, nuw>  : i64
    llvm.return %1 : i64
  }]

theorem inst_combine_lshr_mul_nuw_nsw   : lshr_mul_nuw_nsw_before  ⊑  lshr_mul_nuw_nsw_combined := by
  unfold lshr_mul_nuw_nsw_before lshr_mul_nuw_nsw_combined
  simp_alive_peephole
  sorry
def lshr_mul_vector_combined := [llvmfunc|
  llvm.func @lshr_mul_vector(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<13> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mul %arg0, %0 overflow<nsw, nuw>  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_lshr_mul_vector   : lshr_mul_vector_before  ⊑  lshr_mul_vector_combined := by
  unfold lshr_mul_vector_before lshr_mul_vector_combined
  simp_alive_peephole
  sorry
def lshr_mul_negative_noexact_combined := [llvmfunc|
  llvm.func @lshr_mul_negative_noexact(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(53 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : i64
    %3 = llvm.lshr %2, %1  : i64
    llvm.return %3 : i64
  }]

theorem inst_combine_lshr_mul_negative_noexact   : lshr_mul_negative_noexact_before  ⊑  lshr_mul_negative_noexact_combined := by
  unfold lshr_mul_negative_noexact_before lshr_mul_negative_noexact_combined
  simp_alive_peephole
  sorry
def lshr_mul_negative_oneuse_combined := [llvmfunc|
  llvm.func @lshr_mul_negative_oneuse(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(52 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : i64
    llvm.call @use(%2) : (i64) -> ()
    %3 = llvm.lshr %2, %1  : i64
    llvm.return %3 : i64
  }]

theorem inst_combine_lshr_mul_negative_oneuse   : lshr_mul_negative_oneuse_before  ⊑  lshr_mul_negative_oneuse_combined := by
  unfold lshr_mul_negative_oneuse_before lshr_mul_negative_oneuse_combined
  simp_alive_peephole
  sorry
def lshr_mul_negative_nonuw_combined := [llvmfunc|
  llvm.func @lshr_mul_negative_nonuw(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(52 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.mul %arg0, %0  : i64
    %3 = llvm.lshr %2, %1  : i64
    llvm.return %3 : i64
  }]

theorem inst_combine_lshr_mul_negative_nonuw   : lshr_mul_negative_nonuw_before  ⊑  lshr_mul_negative_nonuw_combined := by
  unfold lshr_mul_negative_nonuw_before lshr_mul_negative_nonuw_combined
  simp_alive_peephole
  sorry
def lshr_mul_negative_nsw_combined := [llvmfunc|
  llvm.func @lshr_mul_negative_nsw(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(52 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i64
    %3 = llvm.lshr %2, %1  : i64
    llvm.return %3 : i64
  }]

theorem inst_combine_lshr_mul_negative_nsw   : lshr_mul_negative_nsw_before  ⊑  lshr_mul_negative_nsw_combined := by
  unfold lshr_mul_negative_nsw_before lshr_mul_negative_nsw_combined
  simp_alive_peephole
  sorry
def shl_add_combined := [llvmfunc|
  llvm.func @shl_add(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.shl %arg1, %1  : i8
    %4 = llvm.add %2, %3  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_shl_add   : shl_add_before  ⊑  shl_add_combined := by
  unfold shl_add_before shl_add_combined
  simp_alive_peephole
  sorry
def shl_add_multiuse_combined := [llvmfunc|
  llvm.func @shl_add_multiuse(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.addressof @use : !llvm.ptr
    %2 = llvm.mlir.constant(5 : i8) : i8
    %3 = llvm.mlir.constant(88 : i8) : i8
    %4 = llvm.shl %arg0, %0  : i8
    llvm.call %1(%4) : !llvm.ptr, (i8) -> ()
    %5 = llvm.shl %arg0, %2  : i8
    %6 = llvm.add %5, %3  : i8
    llvm.return %6 : i8
  }]

theorem inst_combine_shl_add_multiuse   : shl_add_multiuse_before  ⊑  shl_add_multiuse_combined := by
  unfold shl_add_multiuse_before shl_add_multiuse_combined
  simp_alive_peephole
  sorry
def shl_add_multiuse_nonconstant_combined := [llvmfunc|
  llvm.func @shl_add_multiuse_nonconstant(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.addressof @use : !llvm.ptr
    %2 = llvm.mlir.constant(2 : i8) : i8
    %3 = llvm.shl %arg0, %0  : i8
    %4 = llvm.add %3, %arg1  : i8
    llvm.call %1(%3) : !llvm.ptr, (i8) -> ()
    %5 = llvm.shl %4, %2  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_shl_add_multiuse_nonconstant   : shl_add_multiuse_nonconstant_before  ⊑  shl_add_multiuse_nonconstant_combined := by
  unfold shl_add_multiuse_nonconstant_before shl_add_multiuse_nonconstant_combined
  simp_alive_peephole
  sorry
def shl_add_nonuniform_combined := [llvmfunc|
  llvm.func @shl_add_nonuniform(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[5, 4]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[2, 0]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %arg0, %0  : vector<2xi8>
    %3 = llvm.shl %arg1, %1  : vector<2xi8>
    %4 = llvm.add %2, %3  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

theorem inst_combine_shl_add_nonuniform   : shl_add_nonuniform_before  ⊑  shl_add_nonuniform_combined := by
  unfold shl_add_nonuniform_before shl_add_nonuniform_combined
  simp_alive_peephole
  sorry
def shl_add_poison_combined := [llvmfunc|
  llvm.func @shl_add_poison(%arg0: vector<2xi64>, %arg1: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.poison : i64
    %2 = llvm.mlir.constant(12 : i64) : i64
    %3 = llvm.mlir.undef : vector<2xi64>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi64>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi64>
    %8 = llvm.mlir.constant(7 : i64) : i64
    %9 = llvm.mlir.undef : vector<2xi64>
    %10 = llvm.mlir.constant(0 : i32) : i32
    %11 = llvm.insertelement %8, %9[%10 : i32] : vector<2xi64>
    %12 = llvm.mlir.constant(1 : i32) : i32
    %13 = llvm.insertelement %1, %11[%12 : i32] : vector<2xi64>
    %14 = llvm.srem %arg1, %0  : vector<2xi64>
    %15 = llvm.shl %arg0, %7  : vector<2xi64>
    %16 = llvm.shl %14, %13 overflow<nsw>  : vector<2xi64>
    %17 = llvm.add %15, %16  : vector<2xi64>
    llvm.return %17 : vector<2xi64>
  }]

theorem inst_combine_shl_add_poison   : shl_add_poison_before  ⊑  shl_add_poison_combined := by
  unfold shl_add_poison_before shl_add_poison_combined
  simp_alive_peephole
  sorry
def lshr_add_combined := [llvmfunc|
  llvm.func @lshr_add(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.add %2, %arg1  : i8
    %4 = llvm.lshr %3, %1  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_lshr_add   : lshr_add_before  ⊑  lshr_add_combined := by
  unfold lshr_add_before lshr_add_combined
  simp_alive_peephole
  sorry
def lshr_add_nonuniform_combined := [llvmfunc|
  llvm.func @lshr_add_nonuniform(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[3, 4]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[2, 0]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.lshr %arg0, %0  : vector<2xi8>
    %3 = llvm.add %2, %arg1  : vector<2xi8>
    %4 = llvm.lshr %3, %1  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

theorem inst_combine_lshr_add_nonuniform   : lshr_add_nonuniform_before  ⊑  lshr_add_nonuniform_combined := by
  unfold lshr_add_nonuniform_before lshr_add_nonuniform_combined
  simp_alive_peephole
  sorry
def lshr_add_poison_combined := [llvmfunc|
  llvm.func @lshr_add_poison(%arg0: vector<2xi64>, %arg1: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.poison : i64
    %2 = llvm.mlir.constant(5 : i64) : i64
    %3 = llvm.mlir.undef : vector<2xi64>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi64>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi64>
    %8 = llvm.mlir.constant(7 : i64) : i64
    %9 = llvm.mlir.undef : vector<2xi64>
    %10 = llvm.mlir.constant(0 : i32) : i32
    %11 = llvm.insertelement %8, %9[%10 : i32] : vector<2xi64>
    %12 = llvm.mlir.constant(1 : i32) : i32
    %13 = llvm.insertelement %1, %11[%12 : i32] : vector<2xi64>
    %14 = llvm.srem %arg1, %0  : vector<2xi64>
    %15 = llvm.lshr %arg0, %7  : vector<2xi64>
    %16 = llvm.add %14, %15 overflow<nsw>  : vector<2xi64>
    %17 = llvm.lshr %16, %13  : vector<2xi64>
    llvm.return %17 : vector<2xi64>
  }]

theorem inst_combine_lshr_add_poison   : lshr_add_poison_before  ⊑  lshr_add_poison_combined := by
  unfold lshr_add_poison_before lshr_add_poison_combined
  simp_alive_peephole
  sorry
def shl_sub_combined := [llvmfunc|
  llvm.func @shl_sub(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.shl %arg1, %1  : i8
    %4 = llvm.sub %2, %3  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_shl_sub   : shl_sub_before  ⊑  shl_sub_combined := by
  unfold shl_sub_before shl_sub_combined
  simp_alive_peephole
  sorry
def shl_sub_no_commute_combined := [llvmfunc|
  llvm.func @shl_sub_no_commute(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.shl %arg1, %0  : i8
    %3 = llvm.shl %arg0, %1  : i8
    %4 = llvm.sub %3, %2  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_shl_sub_no_commute   : shl_sub_no_commute_before  ⊑  shl_sub_no_commute_combined := by
  unfold shl_sub_no_commute_before shl_sub_no_commute_combined
  simp_alive_peephole
  sorry
def shl_sub_nonuniform_combined := [llvmfunc|
  llvm.func @shl_sub_nonuniform(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[5, 4]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[2, 0]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %arg0, %0  : vector<2xi8>
    %3 = llvm.shl %arg1, %1  : vector<2xi8>
    %4 = llvm.sub %2, %3  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

theorem inst_combine_shl_sub_nonuniform   : shl_sub_nonuniform_before  ⊑  shl_sub_nonuniform_combined := by
  unfold shl_sub_nonuniform_before shl_sub_nonuniform_combined
  simp_alive_peephole
  sorry
def shl_sub_poison_combined := [llvmfunc|
  llvm.func @shl_sub_poison(%arg0: vector<2xi64>, %arg1: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.poison : i64
    %2 = llvm.mlir.constant(12 : i64) : i64
    %3 = llvm.mlir.undef : vector<2xi64>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi64>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi64>
    %8 = llvm.mlir.constant(7 : i64) : i64
    %9 = llvm.mlir.undef : vector<2xi64>
    %10 = llvm.mlir.constant(0 : i32) : i32
    %11 = llvm.insertelement %8, %9[%10 : i32] : vector<2xi64>
    %12 = llvm.mlir.constant(1 : i32) : i32
    %13 = llvm.insertelement %1, %11[%12 : i32] : vector<2xi64>
    %14 = llvm.srem %arg1, %0  : vector<2xi64>
    %15 = llvm.shl %arg0, %7  : vector<2xi64>
    %16 = llvm.shl %14, %13 overflow<nsw>  : vector<2xi64>
    %17 = llvm.sub %16, %15  : vector<2xi64>
    llvm.return %17 : vector<2xi64>
  }]

theorem inst_combine_shl_sub_poison   : shl_sub_poison_before  ⊑  shl_sub_poison_combined := by
  unfold shl_sub_poison_before shl_sub_poison_combined
  simp_alive_peephole
  sorry
def lshr_sub_combined := [llvmfunc|
  llvm.func @lshr_sub(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.sub %2, %arg1  : i8
    %4 = llvm.lshr %3, %1  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_lshr_sub   : lshr_sub_before  ⊑  lshr_sub_combined := by
  unfold lshr_sub_before lshr_sub_combined
  simp_alive_peephole
  sorry
def lshr_sub_nonuniform_combined := [llvmfunc|
  llvm.func @lshr_sub_nonuniform(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[3, 4]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[2, 0]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.lshr %arg0, %0  : vector<2xi8>
    %3 = llvm.sub %2, %arg1  : vector<2xi8>
    %4 = llvm.lshr %3, %1  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

theorem inst_combine_lshr_sub_nonuniform   : lshr_sub_nonuniform_before  ⊑  lshr_sub_nonuniform_combined := by
  unfold lshr_sub_nonuniform_before lshr_sub_nonuniform_combined
  simp_alive_peephole
  sorry
def lshr_sub_poison_combined := [llvmfunc|
  llvm.func @lshr_sub_poison(%arg0: vector<2xi64>, %arg1: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.poison : i64
    %2 = llvm.mlir.constant(5 : i64) : i64
    %3 = llvm.mlir.undef : vector<2xi64>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi64>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi64>
    %8 = llvm.mlir.constant(7 : i64) : i64
    %9 = llvm.mlir.undef : vector<2xi64>
    %10 = llvm.mlir.constant(0 : i32) : i32
    %11 = llvm.insertelement %8, %9[%10 : i32] : vector<2xi64>
    %12 = llvm.mlir.constant(1 : i32) : i32
    %13 = llvm.insertelement %1, %11[%12 : i32] : vector<2xi64>
    %14 = llvm.srem %arg1, %0  : vector<2xi64>
    %15 = llvm.lshr %arg0, %7  : vector<2xi64>
    %16 = llvm.sub %14, %15 overflow<nsw>  : vector<2xi64>
    %17 = llvm.lshr %16, %13  : vector<2xi64>
    llvm.return %17 : vector<2xi64>
  }]

theorem inst_combine_lshr_sub_poison   : lshr_sub_poison_before  ⊑  lshr_sub_poison_combined := by
  unfold lshr_sub_poison_before lshr_sub_poison_combined
  simp_alive_peephole
  sorry
