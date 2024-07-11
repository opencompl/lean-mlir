import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  trunc-inseltpoison
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.trunc %arg0 : i64 to i32
    %2 = llvm.and %1, %0  : i32
    %3 = llvm.zext %2 : i32 to i64
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %3 : i64
  }]

def test1_vec_before := [llvmfunc|
  llvm.func @test1_vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<15> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %2 = llvm.and %1, %0  : vector<2xi32>
    %3 = llvm.zext %2 : vector<2xi32> to vector<2xi64>
    llvm.call @use_vec(%1) : (vector<2xi32>) -> ()
    llvm.return %3 : vector<2xi64>
  }]

def test1_vec_nonuniform_before := [llvmfunc|
  llvm.func @test1_vec_nonuniform(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[15, 7]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %2 = llvm.and %1, %0  : vector<2xi32>
    %3 = llvm.zext %2 : vector<2xi32> to vector<2xi64>
    llvm.call @use_vec(%1) : (vector<2xi32>) -> ()
    llvm.return %3 : vector<2xi64>
  }]

def test1_vec_poison_before := [llvmfunc|
  llvm.func @test1_vec_poison(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %8 = llvm.and %7, %6  : vector<2xi32>
    %9 = llvm.zext %8 : vector<2xi32> to vector<2xi64>
    llvm.call @use_vec(%7) : (vector<2xi32>) -> ()
    llvm.return %9 : vector<2xi64>
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.trunc %arg0 : i64 to i32
    %2 = llvm.shl %1, %0  : i32
    %3 = llvm.ashr %2, %0  : i32
    %4 = llvm.sext %3 : i32 to i64
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %4 : i64
  }]

def test2_vec_before := [llvmfunc|
  llvm.func @test2_vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %2 = llvm.shl %1, %0  : vector<2xi32>
    %3 = llvm.ashr %2, %0  : vector<2xi32>
    %4 = llvm.sext %3 : vector<2xi32> to vector<2xi64>
    llvm.call @use_vec(%1) : (vector<2xi32>) -> ()
    llvm.return %4 : vector<2xi64>
  }]

def test2_vec_nonuniform_before := [llvmfunc|
  llvm.func @test2_vec_nonuniform(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[4, 5]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %2 = llvm.shl %1, %0  : vector<2xi32>
    %3 = llvm.ashr %2, %0  : vector<2xi32>
    %4 = llvm.sext %3 : vector<2xi32> to vector<2xi64>
    llvm.call @use_vec(%1) : (vector<2xi32>) -> ()
    llvm.return %4 : vector<2xi64>
  }]

def test2_vec_poison_before := [llvmfunc|
  llvm.func @test2_vec_poison(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %8 = llvm.shl %7, %6  : vector<2xi32>
    %9 = llvm.ashr %8, %6  : vector<2xi32>
    %10 = llvm.sext %9 : vector<2xi32> to vector<2xi64>
    llvm.call @use_vec(%7) : (vector<2xi32>) -> ()
    llvm.return %10 : vector<2xi64>
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.trunc %arg0 : i64 to i32
    %2 = llvm.and %1, %0  : i32
    %3 = llvm.zext %2 : i32 to i64
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %3 : i64
  }]

def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.trunc %arg0 : i64 to i32
    %2 = llvm.and %1, %0  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.zext %3 : i32 to i64
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %4 : i64
  }]

def test5_before := [llvmfunc|
  llvm.func @test5(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(16 : i128) : i128
    %1 = llvm.zext %arg0 : i32 to i128
    %2 = llvm.lshr %1, %0  : i128
    %3 = llvm.trunc %2 : i128 to i32
    llvm.return %3 : i32
  }]

def test6_before := [llvmfunc|
  llvm.func @test6(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(32 : i128) : i128
    %1 = llvm.zext %arg0 : i64 to i128
    %2 = llvm.lshr %1, %0  : i128
    %3 = llvm.trunc %2 : i128 to i32
    llvm.return %3 : i32
  }]

def ashr_mul_sign_bits_before := [llvmfunc|
  llvm.func @ashr_mul_sign_bits(%arg0: i8, %arg1: i8) -> i16 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.sext %arg1 : i8 to i32
    %3 = llvm.mul %1, %2  : i32
    %4 = llvm.ashr %3, %0  : i32
    %5 = llvm.trunc %4 : i32 to i16
    llvm.return %5 : i16
  }]

def ashr_mul_before := [llvmfunc|
  llvm.func @ashr_mul(%arg0: i8, %arg1: i8) -> i16 {
    %0 = llvm.mlir.constant(8 : i20) : i20
    %1 = llvm.sext %arg0 : i8 to i20
    %2 = llvm.sext %arg1 : i8 to i20
    %3 = llvm.mul %1, %2  : i20
    %4 = llvm.ashr %3, %0  : i20
    %5 = llvm.trunc %4 : i20 to i16
    llvm.return %5 : i16
  }]

def trunc_ashr_before := [llvmfunc|
  llvm.func @trunc_ashr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2147483648 : i36) : i36
    %1 = llvm.mlir.constant(8 : i36) : i36
    %2 = llvm.zext %arg0 : i32 to i36
    %3 = llvm.or %2, %0  : i36
    %4 = llvm.ashr %3, %1  : i36
    %5 = llvm.trunc %4 : i36 to i32
    llvm.return %5 : i32
  }]

def trunc_ashr_vec_before := [llvmfunc|
  llvm.func @trunc_ashr_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(-2147483648 : i36) : i36
    %1 = llvm.mlir.constant(dense<-2147483648> : vector<2xi36>) : vector<2xi36>
    %2 = llvm.mlir.constant(8 : i36) : i36
    %3 = llvm.mlir.constant(dense<8> : vector<2xi36>) : vector<2xi36>
    %4 = llvm.zext %arg0 : vector<2xi32> to vector<2xi36>
    %5 = llvm.or %4, %1  : vector<2xi36>
    %6 = llvm.ashr %5, %3  : vector<2xi36>
    %7 = llvm.trunc %6 : vector<2xi36> to vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }]

def test7_before := [llvmfunc|
  llvm.func @test7(%arg0: i64) -> i92 {
    %0 = llvm.mlir.constant(32 : i128) : i128
    %1 = llvm.zext %arg0 : i64 to i128
    %2 = llvm.lshr %1, %0  : i128
    %3 = llvm.trunc %2 : i128 to i92
    llvm.return %3 : i92
  }]

def test8_before := [llvmfunc|
  llvm.func @test8(%arg0: i32, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(32 : i128) : i128
    %1 = llvm.zext %arg0 : i32 to i128
    %2 = llvm.zext %arg1 : i32 to i128
    %3 = llvm.shl %2, %0  : i128
    %4 = llvm.or %3, %1  : i128
    %5 = llvm.trunc %4 : i128 to i64
    llvm.return %5 : i64
  }]

def test8_vec_before := [llvmfunc|
  llvm.func @test8_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(32 : i128) : i128
    %1 = llvm.mlir.constant(dense<32> : vector<2xi128>) : vector<2xi128>
    %2 = llvm.zext %arg0 : vector<2xi32> to vector<2xi128>
    %3 = llvm.zext %arg1 : vector<2xi32> to vector<2xi128>
    %4 = llvm.shl %3, %1  : vector<2xi128>
    %5 = llvm.or %4, %2  : vector<2xi128>
    %6 = llvm.trunc %5 : vector<2xi128> to vector<2xi64>
    llvm.return %6 : vector<2xi64>
  }]

def test8_vec_nonuniform_before := [llvmfunc|
  llvm.func @test8_vec_nonuniform(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(48 : i128) : i128
    %1 = llvm.mlir.constant(32 : i128) : i128
    %2 = llvm.mlir.constant(dense<[32, 48]> : vector<2xi128>) : vector<2xi128>
    %3 = llvm.zext %arg0 : vector<2xi32> to vector<2xi128>
    %4 = llvm.zext %arg1 : vector<2xi32> to vector<2xi128>
    %5 = llvm.shl %4, %2  : vector<2xi128>
    %6 = llvm.or %5, %3  : vector<2xi128>
    %7 = llvm.trunc %6 : vector<2xi128> to vector<2xi64>
    llvm.return %7 : vector<2xi64>
  }]

def test8_vec_poison_before := [llvmfunc|
  llvm.func @test8_vec_poison(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.poison : i128
    %1 = llvm.mlir.constant(32 : i128) : i128
    %2 = llvm.mlir.undef : vector<2xi128>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi128>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi128>
    %7 = llvm.zext %arg0 : vector<2xi32> to vector<2xi128>
    %8 = llvm.zext %arg1 : vector<2xi32> to vector<2xi128>
    %9 = llvm.shl %8, %6  : vector<2xi128>
    %10 = llvm.or %9, %7  : vector<2xi128>
    %11 = llvm.trunc %10 : vector<2xi128> to vector<2xi64>
    llvm.return %11 : vector<2xi64>
  }]

def test9_before := [llvmfunc|
  llvm.func @test9(%arg0: i32) -> i8 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.trunc %1 : i32 to i8
    llvm.return %2 : i8
  }]

def test10_before := [llvmfunc|
  llvm.func @test10(%arg0: i32) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.trunc %arg0 : i32 to i8
    %2 = llvm.and %1, %0  : i8
    llvm.return %2 : i8
  }]

def test11_before := [llvmfunc|
  llvm.func @test11(%arg0: i32, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(31 : i128) : i128
    %1 = llvm.zext %arg0 : i32 to i128
    %2 = llvm.zext %arg1 : i32 to i128
    %3 = llvm.and %2, %0  : i128
    %4 = llvm.shl %1, %3  : i128
    %5 = llvm.trunc %4 : i128 to i64
    llvm.return %5 : i64
  }]

def test11_vec_before := [llvmfunc|
  llvm.func @test11_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(31 : i128) : i128
    %1 = llvm.mlir.constant(dense<31> : vector<2xi128>) : vector<2xi128>
    %2 = llvm.zext %arg0 : vector<2xi32> to vector<2xi128>
    %3 = llvm.zext %arg1 : vector<2xi32> to vector<2xi128>
    %4 = llvm.and %3, %1  : vector<2xi128>
    %5 = llvm.shl %2, %4  : vector<2xi128>
    %6 = llvm.trunc %5 : vector<2xi128> to vector<2xi64>
    llvm.return %6 : vector<2xi64>
  }]

def test11_vec_nonuniform_before := [llvmfunc|
  llvm.func @test11_vec_nonuniform(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(15 : i128) : i128
    %1 = llvm.mlir.constant(31 : i128) : i128
    %2 = llvm.mlir.constant(dense<[31, 15]> : vector<2xi128>) : vector<2xi128>
    %3 = llvm.zext %arg0 : vector<2xi32> to vector<2xi128>
    %4 = llvm.zext %arg1 : vector<2xi32> to vector<2xi128>
    %5 = llvm.and %4, %2  : vector<2xi128>
    %6 = llvm.shl %3, %5  : vector<2xi128>
    %7 = llvm.trunc %6 : vector<2xi128> to vector<2xi64>
    llvm.return %7 : vector<2xi64>
  }]

def test11_vec_poison_before := [llvmfunc|
  llvm.func @test11_vec_poison(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.poison : i128
    %1 = llvm.mlir.constant(31 : i128) : i128
    %2 = llvm.mlir.undef : vector<2xi128>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi128>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi128>
    %7 = llvm.zext %arg0 : vector<2xi32> to vector<2xi128>
    %8 = llvm.zext %arg1 : vector<2xi32> to vector<2xi128>
    %9 = llvm.and %8, %6  : vector<2xi128>
    %10 = llvm.shl %7, %9  : vector<2xi128>
    %11 = llvm.trunc %10 : vector<2xi128> to vector<2xi64>
    llvm.return %11 : vector<2xi64>
  }]

def test12_before := [llvmfunc|
  llvm.func @test12(%arg0: i32, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(31 : i128) : i128
    %1 = llvm.zext %arg0 : i32 to i128
    %2 = llvm.zext %arg1 : i32 to i128
    %3 = llvm.and %2, %0  : i128
    %4 = llvm.lshr %1, %3  : i128
    %5 = llvm.trunc %4 : i128 to i64
    llvm.return %5 : i64
  }]

def test12_vec_before := [llvmfunc|
  llvm.func @test12_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(31 : i128) : i128
    %1 = llvm.mlir.constant(dense<31> : vector<2xi128>) : vector<2xi128>
    %2 = llvm.zext %arg0 : vector<2xi32> to vector<2xi128>
    %3 = llvm.zext %arg1 : vector<2xi32> to vector<2xi128>
    %4 = llvm.and %3, %1  : vector<2xi128>
    %5 = llvm.lshr %2, %4  : vector<2xi128>
    %6 = llvm.trunc %5 : vector<2xi128> to vector<2xi64>
    llvm.return %6 : vector<2xi64>
  }]

def test12_vec_nonuniform_before := [llvmfunc|
  llvm.func @test12_vec_nonuniform(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(15 : i128) : i128
    %1 = llvm.mlir.constant(31 : i128) : i128
    %2 = llvm.mlir.constant(dense<[31, 15]> : vector<2xi128>) : vector<2xi128>
    %3 = llvm.zext %arg0 : vector<2xi32> to vector<2xi128>
    %4 = llvm.zext %arg1 : vector<2xi32> to vector<2xi128>
    %5 = llvm.and %4, %2  : vector<2xi128>
    %6 = llvm.lshr %3, %5  : vector<2xi128>
    %7 = llvm.trunc %6 : vector<2xi128> to vector<2xi64>
    llvm.return %7 : vector<2xi64>
  }]

def test12_vec_poison_before := [llvmfunc|
  llvm.func @test12_vec_poison(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.poison : i128
    %1 = llvm.mlir.constant(31 : i128) : i128
    %2 = llvm.mlir.undef : vector<2xi128>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi128>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi128>
    %7 = llvm.zext %arg0 : vector<2xi32> to vector<2xi128>
    %8 = llvm.zext %arg1 : vector<2xi32> to vector<2xi128>
    %9 = llvm.and %8, %6  : vector<2xi128>
    %10 = llvm.lshr %7, %9  : vector<2xi128>
    %11 = llvm.trunc %10 : vector<2xi128> to vector<2xi64>
    llvm.return %11 : vector<2xi64>
  }]

def test13_before := [llvmfunc|
  llvm.func @test13(%arg0: i32, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(31 : i128) : i128
    %1 = llvm.sext %arg0 : i32 to i128
    %2 = llvm.zext %arg1 : i32 to i128
    %3 = llvm.and %2, %0  : i128
    %4 = llvm.ashr %1, %3  : i128
    %5 = llvm.trunc %4 : i128 to i64
    llvm.return %5 : i64
  }]

def test13_vec_before := [llvmfunc|
  llvm.func @test13_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(31 : i128) : i128
    %1 = llvm.mlir.constant(dense<31> : vector<2xi128>) : vector<2xi128>
    %2 = llvm.sext %arg0 : vector<2xi32> to vector<2xi128>
    %3 = llvm.zext %arg1 : vector<2xi32> to vector<2xi128>
    %4 = llvm.and %3, %1  : vector<2xi128>
    %5 = llvm.ashr %2, %4  : vector<2xi128>
    %6 = llvm.trunc %5 : vector<2xi128> to vector<2xi64>
    llvm.return %6 : vector<2xi64>
  }]

def test13_vec_nonuniform_before := [llvmfunc|
  llvm.func @test13_vec_nonuniform(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(15 : i128) : i128
    %1 = llvm.mlir.constant(31 : i128) : i128
    %2 = llvm.mlir.constant(dense<[31, 15]> : vector<2xi128>) : vector<2xi128>
    %3 = llvm.sext %arg0 : vector<2xi32> to vector<2xi128>
    %4 = llvm.zext %arg1 : vector<2xi32> to vector<2xi128>
    %5 = llvm.and %4, %2  : vector<2xi128>
    %6 = llvm.ashr %3, %5  : vector<2xi128>
    %7 = llvm.trunc %6 : vector<2xi128> to vector<2xi64>
    llvm.return %7 : vector<2xi64>
  }]

def test13_vec_poison_before := [llvmfunc|
  llvm.func @test13_vec_poison(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.poison : i128
    %1 = llvm.mlir.constant(31 : i128) : i128
    %2 = llvm.mlir.undef : vector<2xi128>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi128>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi128>
    %7 = llvm.sext %arg0 : vector<2xi32> to vector<2xi128>
    %8 = llvm.zext %arg1 : vector<2xi32> to vector<2xi128>
    %9 = llvm.and %8, %6  : vector<2xi128>
    %10 = llvm.ashr %7, %9  : vector<2xi128>
    %11 = llvm.trunc %10 : vector<2xi128> to vector<2xi64>
    llvm.return %11 : vector<2xi64>
  }]

def trunc_bitcast1_before := [llvmfunc|
  llvm.func @trunc_bitcast1(%arg0: vector<4xi32>) -> i32 {
    %0 = llvm.mlir.constant(32 : i128) : i128
    %1 = llvm.bitcast %arg0 : vector<4xi32> to i128
    %2 = llvm.lshr %1, %0  : i128
    %3 = llvm.trunc %2 : i128 to i32
    llvm.return %3 : i32
  }]

def trunc_bitcast2_before := [llvmfunc|
  llvm.func @trunc_bitcast2(%arg0: vector<2xi64>) -> i32 {
    %0 = llvm.mlir.constant(64 : i128) : i128
    %1 = llvm.bitcast %arg0 : vector<2xi64> to i128
    %2 = llvm.lshr %1, %0  : i128
    %3 = llvm.trunc %2 : i128 to i32
    llvm.return %3 : i32
  }]

def trunc_bitcast3_before := [llvmfunc|
  llvm.func @trunc_bitcast3(%arg0: vector<4xi32>) -> i32 {
    %0 = llvm.bitcast %arg0 : vector<4xi32> to i128
    %1 = llvm.trunc %0 : i128 to i32
    llvm.return %1 : i32
  }]

def trunc_shl_31_i32_i64_before := [llvmfunc|
  llvm.func @trunc_shl_31_i32_i64(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(31 : i64) : i64
    %1 = llvm.shl %arg0, %0  : i64
    %2 = llvm.trunc %1 : i64 to i32
    llvm.return %2 : i32
  }]

def trunc_shl_nsw_31_i32_i64_before := [llvmfunc|
  llvm.func @trunc_shl_nsw_31_i32_i64(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(31 : i64) : i64
    %1 = llvm.shl %arg0, %0 overflow<nsw>  : i64
    %2 = llvm.trunc %1 : i64 to i32
    llvm.return %2 : i32
  }]

def trunc_shl_nuw_31_i32_i64_before := [llvmfunc|
  llvm.func @trunc_shl_nuw_31_i32_i64(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(31 : i64) : i64
    %1 = llvm.shl %arg0, %0 overflow<nuw>  : i64
    %2 = llvm.trunc %1 : i64 to i32
    llvm.return %2 : i32
  }]

def trunc_shl_nsw_nuw_31_i32_i64_before := [llvmfunc|
  llvm.func @trunc_shl_nsw_nuw_31_i32_i64(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(31 : i64) : i64
    %1 = llvm.shl %arg0, %0 overflow<nsw, nuw>  : i64
    %2 = llvm.trunc %1 : i64 to i32
    llvm.return %2 : i32
  }]

def trunc_shl_15_i16_i64_before := [llvmfunc|
  llvm.func @trunc_shl_15_i16_i64(%arg0: i64) -> i16 {
    %0 = llvm.mlir.constant(15 : i64) : i64
    %1 = llvm.shl %arg0, %0  : i64
    %2 = llvm.trunc %1 : i64 to i16
    llvm.return %2 : i16
  }]

def trunc_shl_15_i16_i32_before := [llvmfunc|
  llvm.func @trunc_shl_15_i16_i32(%arg0: i32) -> i16 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.shl %arg0, %0  : i32
    %2 = llvm.trunc %1 : i32 to i16
    llvm.return %2 : i16
  }]

def trunc_shl_7_i8_i64_before := [llvmfunc|
  llvm.func @trunc_shl_7_i8_i64(%arg0: i64) -> i8 {
    %0 = llvm.mlir.constant(7 : i64) : i64
    %1 = llvm.shl %arg0, %0  : i64
    %2 = llvm.trunc %1 : i64 to i8
    llvm.return %2 : i8
  }]

def trunc_shl_1_i2_i64_before := [llvmfunc|
  llvm.func @trunc_shl_1_i2_i64(%arg0: i64) -> i2 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.shl %arg0, %0  : i64
    %2 = llvm.trunc %1 : i64 to i2
    llvm.return %2 : i2
  }]

def trunc_shl_1_i32_i64_before := [llvmfunc|
  llvm.func @trunc_shl_1_i32_i64(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.shl %arg0, %0  : i64
    %2 = llvm.trunc %1 : i64 to i32
    llvm.return %2 : i32
  }]

def trunc_shl_16_i32_i64_before := [llvmfunc|
  llvm.func @trunc_shl_16_i32_i64(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.shl %arg0, %0  : i64
    %2 = llvm.trunc %1 : i64 to i32
    llvm.return %2 : i32
  }]

def trunc_shl_33_i32_i64_before := [llvmfunc|
  llvm.func @trunc_shl_33_i32_i64(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(33 : i64) : i64
    %1 = llvm.shl %arg0, %0  : i64
    %2 = llvm.trunc %1 : i64 to i32
    llvm.return %2 : i32
  }]

def trunc_shl_32_i32_i64_before := [llvmfunc|
  llvm.func @trunc_shl_32_i32_i64(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.shl %arg0, %0  : i64
    %2 = llvm.trunc %1 : i64 to i32
    llvm.return %2 : i32
  }]

def trunc_shl_16_v2i32_v2i64_before := [llvmfunc|
  llvm.func @trunc_shl_16_v2i32_v2i64(%arg0: vector<2xi64>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.shl %arg0, %0  : vector<2xi64>
    %2 = llvm.trunc %1 : vector<2xi64> to vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def trunc_shl_nosplat_v2i32_v2i64_before := [llvmfunc|
  llvm.func @trunc_shl_nosplat_v2i32_v2i64(%arg0: vector<2xi64>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[15, 16]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.shl %arg0, %0  : vector<2xi64>
    %2 = llvm.trunc %1 : vector<2xi64> to vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def trunc_shl_31_i32_i64_multi_use_before := [llvmfunc|
  llvm.func @trunc_shl_31_i32_i64_multi_use(%arg0: i64, %arg1: !llvm.ptr<1>, %arg2: !llvm.ptr<1>) {
    %0 = llvm.mlir.constant(31 : i64) : i64
    %1 = llvm.shl %arg0, %0  : i64
    %2 = llvm.trunc %1 : i64 to i32
    llvm.store volatile %2, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr<1>]

    llvm.store volatile %1, %arg2 {alignment = 8 : i64} : i64, !llvm.ptr<1>]

    llvm.return
  }]

def trunc_shl_lshr_infloop_before := [llvmfunc|
  llvm.func @trunc_shl_lshr_infloop(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.shl %2, %1  : i64
    %4 = llvm.trunc %3 : i64 to i32
    llvm.return %4 : i32
  }]

def trunc_shl_v2i32_v2i64_uniform_before := [llvmfunc|
  llvm.func @trunc_shl_v2i32_v2i64_uniform(%arg0: vector<2xi64>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<31> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.shl %arg0, %0  : vector<2xi64>
    %2 = llvm.trunc %1 : vector<2xi64> to vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def trunc_shl_v2i32_v2i64_poison_before := [llvmfunc|
  llvm.func @trunc_shl_v2i32_v2i64_poison(%arg0: vector<2xi64>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : i64
    %1 = llvm.mlir.constant(31 : i64) : i64
    %2 = llvm.mlir.undef : vector<2xi64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi64>
    %7 = llvm.shl %arg0, %6  : vector<2xi64>
    %8 = llvm.trunc %7 : vector<2xi64> to vector<2xi32>
    llvm.return %8 : vector<2xi32>
  }]

def trunc_shl_v2i32_v2i64_nonuniform_before := [llvmfunc|
  llvm.func @trunc_shl_v2i32_v2i64_nonuniform(%arg0: vector<2xi64>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[31, 12]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.shl %arg0, %0  : vector<2xi64>
    %2 = llvm.trunc %1 : vector<2xi64> to vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def trunc_shl_v2i32_v2i64_outofrange_before := [llvmfunc|
  llvm.func @trunc_shl_v2i32_v2i64_outofrange(%arg0: vector<2xi64>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[31, 33]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.shl %arg0, %0  : vector<2xi64>
    %2 = llvm.trunc %1 : vector<2xi64> to vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def trunc_shl_ashr_infloop_before := [llvmfunc|
  llvm.func @trunc_shl_ashr_infloop(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.ashr %arg0, %0  : i64
    %3 = llvm.shl %2, %1  : i64
    %4 = llvm.trunc %3 : i64 to i32
    llvm.return %4 : i32
  }]

def trunc_shl_shl_infloop_before := [llvmfunc|
  llvm.func @trunc_shl_shl_infloop(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.shl %arg0, %0  : i64
    %3 = llvm.shl %2, %1  : i64
    %4 = llvm.trunc %3 : i64 to i32
    llvm.return %4 : i32
  }]

def trunc_shl_lshr_var_before := [llvmfunc|
  llvm.func @trunc_shl_lshr_var(%arg0: i64, %arg1: i64) -> i32 {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.lshr %arg0, %arg1  : i64
    %2 = llvm.shl %1, %0  : i64
    %3 = llvm.trunc %2 : i64 to i32
    llvm.return %3 : i32
  }]

def trunc_shl_ashr_var_before := [llvmfunc|
  llvm.func @trunc_shl_ashr_var(%arg0: i64, %arg1: i64) -> i32 {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.ashr %arg0, %arg1  : i64
    %2 = llvm.shl %1, %0  : i64
    %3 = llvm.trunc %2 : i64 to i32
    llvm.return %3 : i32
  }]

def trunc_shl_shl_var_before := [llvmfunc|
  llvm.func @trunc_shl_shl_var(%arg0: i64, %arg1: i64) -> i32 {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.shl %arg0, %arg1  : i64
    %2 = llvm.shl %1, %0  : i64
    %3 = llvm.trunc %2 : i64 to i32
    llvm.return %3 : i32
  }]

def trunc_shl_v8i15_v8i32_15_before := [llvmfunc|
  llvm.func @trunc_shl_v8i15_v8i32_15(%arg0: vector<8xi32>) -> vector<8xi16> {
    %0 = llvm.mlir.constant(dense<15> : vector<8xi32>) : vector<8xi32>
    %1 = llvm.shl %arg0, %0  : vector<8xi32>
    %2 = llvm.trunc %1 : vector<8xi32> to vector<8xi16>
    llvm.return %2 : vector<8xi16>
  }]

def trunc_shl_v8i16_v8i32_16_before := [llvmfunc|
  llvm.func @trunc_shl_v8i16_v8i32_16(%arg0: vector<8xi32>) -> vector<8xi16> {
    %0 = llvm.mlir.constant(dense<16> : vector<8xi32>) : vector<8xi32>
    %1 = llvm.shl %arg0, %0  : vector<8xi32>
    %2 = llvm.trunc %1 : vector<8xi32> to vector<8xi16>
    llvm.return %2 : vector<8xi16>
  }]

def trunc_shl_v8i16_v8i32_17_before := [llvmfunc|
  llvm.func @trunc_shl_v8i16_v8i32_17(%arg0: vector<8xi32>) -> vector<8xi16> {
    %0 = llvm.mlir.constant(dense<17> : vector<8xi32>) : vector<8xi32>
    %1 = llvm.shl %arg0, %0  : vector<8xi32>
    %2 = llvm.trunc %1 : vector<8xi32> to vector<8xi16>
    llvm.return %2 : vector<8xi16>
  }]

def trunc_shl_v8i16_v8i32_4_before := [llvmfunc|
  llvm.func @trunc_shl_v8i16_v8i32_4(%arg0: vector<8xi32>) -> vector<8xi16> {
    %0 = llvm.mlir.constant(dense<4> : vector<8xi32>) : vector<8xi32>
    %1 = llvm.shl %arg0, %0  : vector<8xi32>
    %2 = llvm.trunc %1 : vector<8xi32> to vector<8xi16>
    llvm.return %2 : vector<8xi16>
  }]

def wide_shuf_before := [llvmfunc|
  llvm.func @wide_shuf(%arg0: vector<4xi32>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<[35, 3634, 90, -1]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.shufflevector %arg0, %0 [1, 5, 6, 2] : vector<4xi32> 
    %2 = llvm.trunc %1 : vector<4xi32> to vector<4xi8>
    llvm.return %2 : vector<4xi8>
  }]

def wide_splat1_before := [llvmfunc|
  llvm.func @wide_splat1(%arg0: vector<4xi32>) -> vector<4xi8> {
    %0 = llvm.mlir.poison : vector<4xi32>
    %1 = llvm.shufflevector %arg0, %0 [2, 2, 2, 2] : vector<4xi32> 
    %2 = llvm.trunc %1 : vector<4xi32> to vector<4xi8>
    llvm.return %2 : vector<4xi8>
  }]

def wide_splat2_before := [llvmfunc|
  llvm.func @wide_splat2(%arg0: vector<3xi33>) -> vector<3xi31> {
    %0 = llvm.mlir.poison : vector<3xi33>
    %1 = llvm.shufflevector %arg0, %0 [1, 1, 1] : vector<3xi33> 
    %2 = llvm.trunc %1 : vector<3xi33> to vector<3xi31>
    llvm.return %2 : vector<3xi31>
  }]

def wide_splat3_before := [llvmfunc|
  llvm.func @wide_splat3(%arg0: vector<3xi33>) -> vector<3xi31> {
    %0 = llvm.mlir.poison : vector<3xi33>
    %1 = llvm.shufflevector %arg0, %0 [-1, 1, 1] : vector<3xi33> 
    %2 = llvm.trunc %1 : vector<3xi33> to vector<3xi31>
    llvm.return %2 : vector<3xi31>
  }]

def wide_lengthening_splat_before := [llvmfunc|
  llvm.func @wide_lengthening_splat(%arg0: vector<4xi16>) -> vector<8xi8> {
    %0 = llvm.shufflevector %arg0, %arg0 [0, 0, 0, 0, 0, 0, 0, 0] : vector<4xi16> 
    %1 = llvm.trunc %0 : vector<8xi16> to vector<8xi8>
    llvm.return %1 : vector<8xi8>
  }]

def narrow_add_vec_constant_before := [llvmfunc|
  llvm.func @narrow_add_vec_constant(%arg0: vector<2xi32>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[256, -129]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.add %arg0, %0  : vector<2xi32>
    %2 = llvm.trunc %1 : vector<2xi32> to vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

def narrow_mul_vec_constant_before := [llvmfunc|
  llvm.func @narrow_mul_vec_constant(%arg0: vector<2xi32>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[256, -129]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mul %arg0, %0  : vector<2xi32>
    %2 = llvm.trunc %1 : vector<2xi32> to vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

def narrow_sub_vec_constant_before := [llvmfunc|
  llvm.func @narrow_sub_vec_constant(%arg0: vector<2xi32>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[256, -129]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sub %0, %arg0  : vector<2xi32>
    %2 = llvm.trunc %1 : vector<2xi32> to vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

def PR44545_before := [llvmfunc|
  llvm.func @PR44545(%arg0: i32, %arg1: i32) -> i16 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i16) : i16
    %3 = llvm.add %arg0, %0 overflow<nsw, nuw>  : i32
    %4 = llvm.icmp "eq" %arg1, %1 : i32
    %5 = llvm.select %4, %1, %3 : i1, i32
    %6 = llvm.trunc %5 : i32 to i16
    %7 = llvm.add %6, %2 overflow<nsw>  : i16
    llvm.return %7 : i16
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(15 : i64) : i64
    %1 = llvm.trunc %arg0 : i64 to i32
    %2 = llvm.and %arg0, %0  : i64
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %2 : i64
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test1_vec_combined := [llvmfunc|
  llvm.func @test1_vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<15> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %2 = llvm.and %arg0, %0  : vector<2xi64>
    llvm.call @use_vec(%1) : (vector<2xi32>) -> ()
    llvm.return %2 : vector<2xi64>
  }]

theorem inst_combine_test1_vec   : test1_vec_before  ⊑  test1_vec_combined := by
  unfold test1_vec_before test1_vec_combined
  simp_alive_peephole
  sorry
def test1_vec_nonuniform_combined := [llvmfunc|
  llvm.func @test1_vec_nonuniform(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[15, 7]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %2 = llvm.and %arg0, %0  : vector<2xi64>
    llvm.call @use_vec(%1) : (vector<2xi32>) -> ()
    llvm.return %2 : vector<2xi64>
  }]

theorem inst_combine_test1_vec_nonuniform   : test1_vec_nonuniform_before  ⊑  test1_vec_nonuniform_combined := by
  unfold test1_vec_nonuniform_before test1_vec_nonuniform_combined
  simp_alive_peephole
  sorry
def test1_vec_poison_combined := [llvmfunc|
  llvm.func @test1_vec_poison(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.poison : i64
    %1 = llvm.mlir.constant(15 : i64) : i64
    %2 = llvm.mlir.undef : vector<2xi64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi64>
    %7 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %8 = llvm.and %arg0, %6  : vector<2xi64>
    llvm.call @use_vec(%7) : (vector<2xi32>) -> ()
    llvm.return %8 : vector<2xi64>
  }]

theorem inst_combine_test1_vec_poison   : test1_vec_poison_before  ⊑  test1_vec_poison_combined := by
  unfold test1_vec_poison_before test1_vec_poison_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(36 : i64) : i64
    %1 = llvm.trunc %arg0 : i64 to i32
    %2 = llvm.shl %arg0, %0  : i64
    %3 = llvm.ashr %2, %0  : i64
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %3 : i64
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test2_vec_combined := [llvmfunc|
  llvm.func @test2_vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<36> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %2 = llvm.shl %arg0, %0  : vector<2xi64>
    %3 = llvm.ashr %2, %0  : vector<2xi64>
    llvm.call @use_vec(%1) : (vector<2xi32>) -> ()
    llvm.return %3 : vector<2xi64>
  }]

theorem inst_combine_test2_vec   : test2_vec_before  ⊑  test2_vec_combined := by
  unfold test2_vec_before test2_vec_combined
  simp_alive_peephole
  sorry
def test2_vec_nonuniform_combined := [llvmfunc|
  llvm.func @test2_vec_nonuniform(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[36, 37]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %2 = llvm.shl %arg0, %0  : vector<2xi64>
    %3 = llvm.ashr %2, %0  : vector<2xi64>
    llvm.call @use_vec(%1) : (vector<2xi32>) -> ()
    llvm.return %3 : vector<2xi64>
  }]

theorem inst_combine_test2_vec_nonuniform   : test2_vec_nonuniform_before  ⊑  test2_vec_nonuniform_combined := by
  unfold test2_vec_nonuniform_before test2_vec_nonuniform_combined
  simp_alive_peephole
  sorry
def test2_vec_poison_combined := [llvmfunc|
  llvm.func @test2_vec_poison(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.poison : i64
    %1 = llvm.mlir.constant(36 : i64) : i64
    %2 = llvm.mlir.undef : vector<2xi64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi64>
    %7 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %8 = llvm.shl %arg0, %6  : vector<2xi64>
    %9 = llvm.ashr %8, %6  : vector<2xi64>
    llvm.call @use_vec(%7) : (vector<2xi32>) -> ()
    llvm.return %9 : vector<2xi64>
  }]

theorem inst_combine_test2_vec_poison   : test2_vec_poison_before  ⊑  test2_vec_poison_combined := by
  unfold test2_vec_poison_before test2_vec_poison_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(8 : i64) : i64
    %1 = llvm.trunc %arg0 : i64 to i32
    %2 = llvm.and %arg0, %0  : i64
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %2 : i64
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(8 : i64) : i64
    %1 = llvm.trunc %arg0 : i64 to i32
    %2 = llvm.and %arg0, %0  : i64
    %3 = llvm.xor %2, %0  : i64
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %3 : i64
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
def test6_combined := [llvmfunc|
  llvm.func @test6(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.lshr %arg0, %0  : i64
    %2 = llvm.trunc %1 : i64 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
def ashr_mul_sign_bits_combined := [llvmfunc|
  llvm.func @ashr_mul_sign_bits(%arg0: i8, %arg1: i8) -> i16 {
    %0 = llvm.mlir.constant(3 : i16) : i16
    %1 = llvm.sext %arg0 : i8 to i16
    %2 = llvm.sext %arg1 : i8 to i16
    %3 = llvm.mul %1, %2 overflow<nsw>  : i16
    %4 = llvm.ashr %3, %0  : i16
    llvm.return %4 : i16
  }]

theorem inst_combine_ashr_mul_sign_bits   : ashr_mul_sign_bits_before  ⊑  ashr_mul_sign_bits_combined := by
  unfold ashr_mul_sign_bits_before ashr_mul_sign_bits_combined
  simp_alive_peephole
  sorry
def ashr_mul_combined := [llvmfunc|
  llvm.func @ashr_mul(%arg0: i8, %arg1: i8) -> i16 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.sext %arg0 : i8 to i16
    %2 = llvm.sext %arg1 : i8 to i16
    %3 = llvm.mul %1, %2 overflow<nsw>  : i16
    %4 = llvm.ashr %3, %0  : i16
    llvm.return %4 : i16
  }]

theorem inst_combine_ashr_mul   : ashr_mul_before  ⊑  ashr_mul_combined := by
  unfold ashr_mul_before ashr_mul_combined
  simp_alive_peephole
  sorry
def trunc_ashr_combined := [llvmfunc|
  llvm.func @trunc_ashr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(-8388608 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.or %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_trunc_ashr   : trunc_ashr_before  ⊑  trunc_ashr_combined := by
  unfold trunc_ashr_before trunc_ashr_combined
  simp_alive_peephole
  sorry
def trunc_ashr_vec_combined := [llvmfunc|
  llvm.func @trunc_ashr_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-8388608> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.lshr %arg0, %0  : vector<2xi32>
    %3 = llvm.or %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_trunc_ashr_vec   : trunc_ashr_vec_before  ⊑  trunc_ashr_vec_combined := by
  unfold trunc_ashr_vec_before trunc_ashr_vec_combined
  simp_alive_peephole
  sorry
def test7_combined := [llvmfunc|
  llvm.func @test7(%arg0: i64) -> i92 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.lshr %arg0, %0  : i64
    %2 = llvm.zext %1 : i64 to i92
    llvm.return %2 : i92
  }]

theorem inst_combine_test7   : test7_before  ⊑  test7_combined := by
  unfold test7_before test7_combined
  simp_alive_peephole
  sorry
def test8_combined := [llvmfunc|
  llvm.func @test8(%arg0: i32, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.zext %arg0 : i32 to i64
    %2 = llvm.zext %arg1 : i32 to i64
    %3 = llvm.shl %2, %0 overflow<nuw>  : i64
    %4 = llvm.or %3, %1  : i64
    llvm.return %4 : i64
  }]

theorem inst_combine_test8   : test8_before  ⊑  test8_combined := by
  unfold test8_before test8_combined
  simp_alive_peephole
  sorry
def test8_vec_combined := [llvmfunc|
  llvm.func @test8_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.zext %arg0 : vector<2xi32> to vector<2xi64>
    %2 = llvm.zext %arg1 : vector<2xi32> to vector<2xi64>
    %3 = llvm.shl %2, %0 overflow<nuw>  : vector<2xi64>
    %4 = llvm.or %3, %1  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

theorem inst_combine_test8_vec   : test8_vec_before  ⊑  test8_vec_combined := by
  unfold test8_vec_before test8_vec_combined
  simp_alive_peephole
  sorry
def test8_vec_nonuniform_combined := [llvmfunc|
  llvm.func @test8_vec_nonuniform(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[32, 48]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.zext %arg0 : vector<2xi32> to vector<2xi64>
    %2 = llvm.zext %arg1 : vector<2xi32> to vector<2xi64>
    %3 = llvm.shl %2, %0  : vector<2xi64>
    %4 = llvm.or %3, %1  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

theorem inst_combine_test8_vec_nonuniform   : test8_vec_nonuniform_before  ⊑  test8_vec_nonuniform_combined := by
  unfold test8_vec_nonuniform_before test8_vec_nonuniform_combined
  simp_alive_peephole
  sorry
def test8_vec_poison_combined := [llvmfunc|
  llvm.func @test8_vec_poison(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.poison : i64
    %1 = llvm.mlir.constant(32 : i64) : i64
    %2 = llvm.mlir.undef : vector<2xi64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi64>
    %7 = llvm.zext %arg0 : vector<2xi32> to vector<2xi64>
    %8 = llvm.zext %arg1 : vector<2xi32> to vector<2xi64>
    %9 = llvm.shl %8, %6 overflow<nuw>  : vector<2xi64>
    %10 = llvm.or %9, %7  : vector<2xi64>
    llvm.return %10 : vector<2xi64>
  }]

theorem inst_combine_test8_vec_poison   : test8_vec_poison_before  ⊑  test8_vec_poison_combined := by
  unfold test8_vec_poison_before test8_vec_poison_combined
  simp_alive_peephole
  sorry
def test9_combined := [llvmfunc|
  llvm.func @test9(%arg0: i32) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.trunc %arg0 : i32 to i8
    %2 = llvm.and %1, %0  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_test9   : test9_before  ⊑  test9_combined := by
  unfold test9_before test9_combined
  simp_alive_peephole
  sorry
def test10_combined := [llvmfunc|
  llvm.func @test10(%arg0: i32) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.trunc %arg0 : i32 to i8
    %2 = llvm.and %1, %0  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_test10   : test10_before  ⊑  test10_combined := by
  unfold test10_before test10_combined
  simp_alive_peephole
  sorry
def test11_combined := [llvmfunc|
  llvm.func @test11(%arg0: i32, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.zext %arg0 : i32 to i64
    %2 = llvm.and %arg1, %0  : i32
    %3 = llvm.zext %2 : i32 to i64
    %4 = llvm.shl %1, %3 overflow<nsw, nuw>  : i64
    llvm.return %4 : i64
  }]

theorem inst_combine_test11   : test11_before  ⊑  test11_combined := by
  unfold test11_before test11_combined
  simp_alive_peephole
  sorry
def test11_vec_combined := [llvmfunc|
  llvm.func @test11_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<31> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.zext %arg0 : vector<2xi32> to vector<2xi64>
    %2 = llvm.and %arg1, %0  : vector<2xi32>
    %3 = llvm.zext %2 : vector<2xi32> to vector<2xi64>
    %4 = llvm.shl %1, %3 overflow<nsw, nuw>  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

theorem inst_combine_test11_vec   : test11_vec_before  ⊑  test11_vec_combined := by
  unfold test11_vec_before test11_vec_combined
  simp_alive_peephole
  sorry
def test11_vec_nonuniform_combined := [llvmfunc|
  llvm.func @test11_vec_nonuniform(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[31, 15]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.zext %arg0 : vector<2xi32> to vector<2xi64>
    %2 = llvm.and %arg1, %0  : vector<2xi32>
    %3 = llvm.zext %2 : vector<2xi32> to vector<2xi64>
    %4 = llvm.shl %1, %3 overflow<nsw, nuw>  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

theorem inst_combine_test11_vec_nonuniform   : test11_vec_nonuniform_before  ⊑  test11_vec_nonuniform_combined := by
  unfold test11_vec_nonuniform_before test11_vec_nonuniform_combined
  simp_alive_peephole
  sorry
def test11_vec_poison_combined := [llvmfunc|
  llvm.func @test11_vec_poison(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.zext %arg0 : vector<2xi32> to vector<2xi64>
    %8 = llvm.and %arg1, %6  : vector<2xi32>
    %9 = llvm.zext %8 : vector<2xi32> to vector<2xi64>
    %10 = llvm.shl %7, %9 overflow<nsw, nuw>  : vector<2xi64>
    llvm.return %10 : vector<2xi64>
  }]

theorem inst_combine_test11_vec_poison   : test11_vec_poison_before  ⊑  test11_vec_poison_combined := by
  unfold test11_vec_poison_before test11_vec_poison_combined
  simp_alive_peephole
  sorry
def test12_combined := [llvmfunc|
  llvm.func @test12(%arg0: i32, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.zext %arg0 : i32 to i64
    %2 = llvm.and %arg1, %0  : i32
    %3 = llvm.zext %2 : i32 to i64
    %4 = llvm.lshr %1, %3  : i64
    llvm.return %4 : i64
  }]

theorem inst_combine_test12   : test12_before  ⊑  test12_combined := by
  unfold test12_before test12_combined
  simp_alive_peephole
  sorry
def test12_vec_combined := [llvmfunc|
  llvm.func @test12_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<31> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.zext %arg0 : vector<2xi32> to vector<2xi64>
    %2 = llvm.and %arg1, %0  : vector<2xi32>
    %3 = llvm.zext %2 : vector<2xi32> to vector<2xi64>
    %4 = llvm.lshr %1, %3  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

theorem inst_combine_test12_vec   : test12_vec_before  ⊑  test12_vec_combined := by
  unfold test12_vec_before test12_vec_combined
  simp_alive_peephole
  sorry
def test12_vec_nonuniform_combined := [llvmfunc|
  llvm.func @test12_vec_nonuniform(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[31, 15]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.zext %arg0 : vector<2xi32> to vector<2xi64>
    %2 = llvm.and %arg1, %0  : vector<2xi32>
    %3 = llvm.zext %2 : vector<2xi32> to vector<2xi64>
    %4 = llvm.lshr %1, %3  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

theorem inst_combine_test12_vec_nonuniform   : test12_vec_nonuniform_before  ⊑  test12_vec_nonuniform_combined := by
  unfold test12_vec_nonuniform_before test12_vec_nonuniform_combined
  simp_alive_peephole
  sorry
def test12_vec_poison_combined := [llvmfunc|
  llvm.func @test12_vec_poison(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.zext %arg0 : vector<2xi32> to vector<2xi64>
    %8 = llvm.and %arg1, %6  : vector<2xi32>
    %9 = llvm.zext %8 : vector<2xi32> to vector<2xi64>
    %10 = llvm.lshr %7, %9  : vector<2xi64>
    llvm.return %10 : vector<2xi64>
  }]

theorem inst_combine_test12_vec_poison   : test12_vec_poison_before  ⊑  test12_vec_poison_combined := by
  unfold test12_vec_poison_before test12_vec_poison_combined
  simp_alive_peephole
  sorry
def test13_combined := [llvmfunc|
  llvm.func @test13(%arg0: i32, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.sext %arg0 : i32 to i64
    %2 = llvm.and %arg1, %0  : i32
    %3 = llvm.zext %2 : i32 to i64
    %4 = llvm.ashr %1, %3  : i64
    llvm.return %4 : i64
  }]

theorem inst_combine_test13   : test13_before  ⊑  test13_combined := by
  unfold test13_before test13_combined
  simp_alive_peephole
  sorry
def test13_vec_combined := [llvmfunc|
  llvm.func @test13_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<31> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi32> to vector<2xi64>
    %2 = llvm.and %arg1, %0  : vector<2xi32>
    %3 = llvm.zext %2 : vector<2xi32> to vector<2xi64>
    %4 = llvm.ashr %1, %3  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

theorem inst_combine_test13_vec   : test13_vec_before  ⊑  test13_vec_combined := by
  unfold test13_vec_before test13_vec_combined
  simp_alive_peephole
  sorry
def test13_vec_nonuniform_combined := [llvmfunc|
  llvm.func @test13_vec_nonuniform(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[31, 15]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi32> to vector<2xi64>
    %2 = llvm.and %arg1, %0  : vector<2xi32>
    %3 = llvm.zext %2 : vector<2xi32> to vector<2xi64>
    %4 = llvm.ashr %1, %3  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

theorem inst_combine_test13_vec_nonuniform   : test13_vec_nonuniform_before  ⊑  test13_vec_nonuniform_combined := by
  unfold test13_vec_nonuniform_before test13_vec_nonuniform_combined
  simp_alive_peephole
  sorry
def test13_vec_poison_combined := [llvmfunc|
  llvm.func @test13_vec_poison(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.sext %arg0 : vector<2xi32> to vector<2xi64>
    %8 = llvm.and %arg1, %6  : vector<2xi32>
    %9 = llvm.zext %8 : vector<2xi32> to vector<2xi64>
    %10 = llvm.ashr %7, %9  : vector<2xi64>
    llvm.return %10 : vector<2xi64>
  }]

theorem inst_combine_test13_vec_poison   : test13_vec_poison_before  ⊑  test13_vec_poison_combined := by
  unfold test13_vec_poison_before test13_vec_poison_combined
  simp_alive_peephole
  sorry
def trunc_bitcast1_combined := [llvmfunc|
  llvm.func @trunc_bitcast1(%arg0: vector<4xi32>) -> i32 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.extractelement %arg0[%0 : i64] : vector<4xi32>
    llvm.return %1 : i32
  }]

theorem inst_combine_trunc_bitcast1   : trunc_bitcast1_before  ⊑  trunc_bitcast1_combined := by
  unfold trunc_bitcast1_before trunc_bitcast1_combined
  simp_alive_peephole
  sorry
def trunc_bitcast2_combined := [llvmfunc|
  llvm.func @trunc_bitcast2(%arg0: vector<2xi64>) -> i32 {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.bitcast %arg0 : vector<2xi64> to vector<4xi32>
    %2 = llvm.extractelement %1[%0 : i64] : vector<4xi32>
    llvm.return %2 : i32
  }]

theorem inst_combine_trunc_bitcast2   : trunc_bitcast2_before  ⊑  trunc_bitcast2_combined := by
  unfold trunc_bitcast2_before trunc_bitcast2_combined
  simp_alive_peephole
  sorry
def trunc_bitcast3_combined := [llvmfunc|
  llvm.func @trunc_bitcast3(%arg0: vector<4xi32>) -> i32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.extractelement %arg0[%0 : i64] : vector<4xi32>
    llvm.return %1 : i32
  }]

theorem inst_combine_trunc_bitcast3   : trunc_bitcast3_before  ⊑  trunc_bitcast3_combined := by
  unfold trunc_bitcast3_before trunc_bitcast3_combined
  simp_alive_peephole
  sorry
def trunc_shl_31_i32_i64_combined := [llvmfunc|
  llvm.func @trunc_shl_31_i32_i64(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.trunc %arg0 : i64 to i32
    %2 = llvm.shl %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_trunc_shl_31_i32_i64   : trunc_shl_31_i32_i64_before  ⊑  trunc_shl_31_i32_i64_combined := by
  unfold trunc_shl_31_i32_i64_before trunc_shl_31_i32_i64_combined
  simp_alive_peephole
  sorry
def trunc_shl_nsw_31_i32_i64_combined := [llvmfunc|
  llvm.func @trunc_shl_nsw_31_i32_i64(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.trunc %arg0 : i64 to i32
    %2 = llvm.shl %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_trunc_shl_nsw_31_i32_i64   : trunc_shl_nsw_31_i32_i64_before  ⊑  trunc_shl_nsw_31_i32_i64_combined := by
  unfold trunc_shl_nsw_31_i32_i64_before trunc_shl_nsw_31_i32_i64_combined
  simp_alive_peephole
  sorry
def trunc_shl_nuw_31_i32_i64_combined := [llvmfunc|
  llvm.func @trunc_shl_nuw_31_i32_i64(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.trunc %arg0 : i64 to i32
    %2 = llvm.shl %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_trunc_shl_nuw_31_i32_i64   : trunc_shl_nuw_31_i32_i64_before  ⊑  trunc_shl_nuw_31_i32_i64_combined := by
  unfold trunc_shl_nuw_31_i32_i64_before trunc_shl_nuw_31_i32_i64_combined
  simp_alive_peephole
  sorry
def trunc_shl_nsw_nuw_31_i32_i64_combined := [llvmfunc|
  llvm.func @trunc_shl_nsw_nuw_31_i32_i64(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.trunc %arg0 : i64 to i32
    %2 = llvm.shl %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_trunc_shl_nsw_nuw_31_i32_i64   : trunc_shl_nsw_nuw_31_i32_i64_before  ⊑  trunc_shl_nsw_nuw_31_i32_i64_combined := by
  unfold trunc_shl_nsw_nuw_31_i32_i64_before trunc_shl_nsw_nuw_31_i32_i64_combined
  simp_alive_peephole
  sorry
def trunc_shl_15_i16_i64_combined := [llvmfunc|
  llvm.func @trunc_shl_15_i16_i64(%arg0: i64) -> i16 {
    %0 = llvm.mlir.constant(15 : i16) : i16
    %1 = llvm.trunc %arg0 : i64 to i16
    %2 = llvm.shl %1, %0  : i16
    llvm.return %2 : i16
  }]

theorem inst_combine_trunc_shl_15_i16_i64   : trunc_shl_15_i16_i64_before  ⊑  trunc_shl_15_i16_i64_combined := by
  unfold trunc_shl_15_i16_i64_before trunc_shl_15_i16_i64_combined
  simp_alive_peephole
  sorry
def trunc_shl_15_i16_i32_combined := [llvmfunc|
  llvm.func @trunc_shl_15_i16_i32(%arg0: i32) -> i16 {
    %0 = llvm.mlir.constant(15 : i16) : i16
    %1 = llvm.trunc %arg0 : i32 to i16
    %2 = llvm.shl %1, %0  : i16
    llvm.return %2 : i16
  }]

theorem inst_combine_trunc_shl_15_i16_i32   : trunc_shl_15_i16_i32_before  ⊑  trunc_shl_15_i16_i32_combined := by
  unfold trunc_shl_15_i16_i32_before trunc_shl_15_i16_i32_combined
  simp_alive_peephole
  sorry
def trunc_shl_7_i8_i64_combined := [llvmfunc|
  llvm.func @trunc_shl_7_i8_i64(%arg0: i64) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.trunc %arg0 : i64 to i8
    %2 = llvm.shl %1, %0  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_trunc_shl_7_i8_i64   : trunc_shl_7_i8_i64_before  ⊑  trunc_shl_7_i8_i64_combined := by
  unfold trunc_shl_7_i8_i64_before trunc_shl_7_i8_i64_combined
  simp_alive_peephole
  sorry
def trunc_shl_1_i2_i64_combined := [llvmfunc|
  llvm.func @trunc_shl_1_i2_i64(%arg0: i64) -> i2 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.shl %arg0, %0  : i64
    %2 = llvm.trunc %1 : i64 to i2
    llvm.return %2 : i2
  }]

theorem inst_combine_trunc_shl_1_i2_i64   : trunc_shl_1_i2_i64_before  ⊑  trunc_shl_1_i2_i64_combined := by
  unfold trunc_shl_1_i2_i64_before trunc_shl_1_i2_i64_combined
  simp_alive_peephole
  sorry
def trunc_shl_1_i32_i64_combined := [llvmfunc|
  llvm.func @trunc_shl_1_i32_i64(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.trunc %arg0 : i64 to i32
    %2 = llvm.shl %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_trunc_shl_1_i32_i64   : trunc_shl_1_i32_i64_before  ⊑  trunc_shl_1_i32_i64_combined := by
  unfold trunc_shl_1_i32_i64_before trunc_shl_1_i32_i64_combined
  simp_alive_peephole
  sorry
def trunc_shl_16_i32_i64_combined := [llvmfunc|
  llvm.func @trunc_shl_16_i32_i64(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.trunc %arg0 : i64 to i32
    %2 = llvm.shl %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_trunc_shl_16_i32_i64   : trunc_shl_16_i32_i64_before  ⊑  trunc_shl_16_i32_i64_combined := by
  unfold trunc_shl_16_i32_i64_before trunc_shl_16_i32_i64_combined
  simp_alive_peephole
  sorry
def trunc_shl_33_i32_i64_combined := [llvmfunc|
  llvm.func @trunc_shl_33_i32_i64(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_trunc_shl_33_i32_i64   : trunc_shl_33_i32_i64_before  ⊑  trunc_shl_33_i32_i64_combined := by
  unfold trunc_shl_33_i32_i64_before trunc_shl_33_i32_i64_combined
  simp_alive_peephole
  sorry
def trunc_shl_32_i32_i64_combined := [llvmfunc|
  llvm.func @trunc_shl_32_i32_i64(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_trunc_shl_32_i32_i64   : trunc_shl_32_i32_i64_before  ⊑  trunc_shl_32_i32_i64_combined := by
  unfold trunc_shl_32_i32_i64_before trunc_shl_32_i32_i64_combined
  simp_alive_peephole
  sorry
def trunc_shl_16_v2i32_v2i64_combined := [llvmfunc|
  llvm.func @trunc_shl_16_v2i32_v2i64(%arg0: vector<2xi64>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %2 = llvm.shl %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_trunc_shl_16_v2i32_v2i64   : trunc_shl_16_v2i32_v2i64_before  ⊑  trunc_shl_16_v2i32_v2i64_combined := by
  unfold trunc_shl_16_v2i32_v2i64_before trunc_shl_16_v2i32_v2i64_combined
  simp_alive_peephole
  sorry
def trunc_shl_nosplat_v2i32_v2i64_combined := [llvmfunc|
  llvm.func @trunc_shl_nosplat_v2i32_v2i64(%arg0: vector<2xi64>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[15, 16]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %2 = llvm.shl %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_trunc_shl_nosplat_v2i32_v2i64   : trunc_shl_nosplat_v2i32_v2i64_before  ⊑  trunc_shl_nosplat_v2i32_v2i64_combined := by
  unfold trunc_shl_nosplat_v2i32_v2i64_before trunc_shl_nosplat_v2i32_v2i64_combined
  simp_alive_peephole
  sorry
def trunc_shl_31_i32_i64_multi_use_combined := [llvmfunc|
  llvm.func @trunc_shl_31_i32_i64_multi_use(%arg0: i64, %arg1: !llvm.ptr<1>, %arg2: !llvm.ptr<1>) {
    %0 = llvm.mlir.constant(31 : i64) : i64
    %1 = llvm.shl %arg0, %0  : i64
    %2 = llvm.trunc %1 : i64 to i32
    llvm.store volatile %2, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr<1>
    llvm.store volatile %1, %arg2 {alignment = 8 : i64} : i64, !llvm.ptr<1>
    llvm.return
  }]

theorem inst_combine_trunc_shl_31_i32_i64_multi_use   : trunc_shl_31_i32_i64_multi_use_before  ⊑  trunc_shl_31_i32_i64_multi_use_combined := by
  unfold trunc_shl_31_i32_i64_multi_use_before trunc_shl_31_i32_i64_multi_use_combined
  simp_alive_peephole
  sorry
def trunc_shl_lshr_infloop_combined := [llvmfunc|
  llvm.func @trunc_shl_lshr_infloop(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-4 : i32) : i32
    %2 = llvm.trunc %arg0 : i64 to i32
    %3 = llvm.shl %2, %0  : i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_trunc_shl_lshr_infloop   : trunc_shl_lshr_infloop_before  ⊑  trunc_shl_lshr_infloop_combined := by
  unfold trunc_shl_lshr_infloop_before trunc_shl_lshr_infloop_combined
  simp_alive_peephole
  sorry
def trunc_shl_v2i32_v2i64_uniform_combined := [llvmfunc|
  llvm.func @trunc_shl_v2i32_v2i64_uniform(%arg0: vector<2xi64>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<31> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %2 = llvm.shl %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_trunc_shl_v2i32_v2i64_uniform   : trunc_shl_v2i32_v2i64_uniform_before  ⊑  trunc_shl_v2i32_v2i64_uniform_combined := by
  unfold trunc_shl_v2i32_v2i64_uniform_before trunc_shl_v2i32_v2i64_uniform_combined
  simp_alive_peephole
  sorry
def trunc_shl_v2i32_v2i64_poison_combined := [llvmfunc|
  llvm.func @trunc_shl_v2i32_v2i64_poison(%arg0: vector<2xi64>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %8 = llvm.shl %7, %6  : vector<2xi32>
    llvm.return %8 : vector<2xi32>
  }]

theorem inst_combine_trunc_shl_v2i32_v2i64_poison   : trunc_shl_v2i32_v2i64_poison_before  ⊑  trunc_shl_v2i32_v2i64_poison_combined := by
  unfold trunc_shl_v2i32_v2i64_poison_before trunc_shl_v2i32_v2i64_poison_combined
  simp_alive_peephole
  sorry
def trunc_shl_v2i32_v2i64_nonuniform_combined := [llvmfunc|
  llvm.func @trunc_shl_v2i32_v2i64_nonuniform(%arg0: vector<2xi64>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[31, 12]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %2 = llvm.shl %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_trunc_shl_v2i32_v2i64_nonuniform   : trunc_shl_v2i32_v2i64_nonuniform_before  ⊑  trunc_shl_v2i32_v2i64_nonuniform_combined := by
  unfold trunc_shl_v2i32_v2i64_nonuniform_before trunc_shl_v2i32_v2i64_nonuniform_combined
  simp_alive_peephole
  sorry
def trunc_shl_v2i32_v2i64_outofrange_combined := [llvmfunc|
  llvm.func @trunc_shl_v2i32_v2i64_outofrange(%arg0: vector<2xi64>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[31, 33]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.shl %arg0, %0  : vector<2xi64>
    %2 = llvm.trunc %1 : vector<2xi64> to vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_trunc_shl_v2i32_v2i64_outofrange   : trunc_shl_v2i32_v2i64_outofrange_before  ⊑  trunc_shl_v2i32_v2i64_outofrange_combined := by
  unfold trunc_shl_v2i32_v2i64_outofrange_before trunc_shl_v2i32_v2i64_outofrange_combined
  simp_alive_peephole
  sorry
def trunc_shl_ashr_infloop_combined := [llvmfunc|
  llvm.func @trunc_shl_ashr_infloop(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(-4 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_trunc_shl_ashr_infloop   : trunc_shl_ashr_infloop_before  ⊑  trunc_shl_ashr_infloop_combined := by
  unfold trunc_shl_ashr_infloop_before trunc_shl_ashr_infloop_combined
  simp_alive_peephole
  sorry
def trunc_shl_shl_infloop_combined := [llvmfunc|
  llvm.func @trunc_shl_shl_infloop(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.trunc %arg0 : i64 to i32
    %2 = llvm.shl %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_trunc_shl_shl_infloop   : trunc_shl_shl_infloop_before  ⊑  trunc_shl_shl_infloop_combined := by
  unfold trunc_shl_shl_infloop_before trunc_shl_shl_infloop_combined
  simp_alive_peephole
  sorry
def trunc_shl_lshr_var_combined := [llvmfunc|
  llvm.func @trunc_shl_lshr_var(%arg0: i64, %arg1: i64) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.lshr %arg0, %arg1  : i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.shl %2, %0  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_trunc_shl_lshr_var   : trunc_shl_lshr_var_before  ⊑  trunc_shl_lshr_var_combined := by
  unfold trunc_shl_lshr_var_before trunc_shl_lshr_var_combined
  simp_alive_peephole
  sorry
def trunc_shl_ashr_var_combined := [llvmfunc|
  llvm.func @trunc_shl_ashr_var(%arg0: i64, %arg1: i64) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.ashr %arg0, %arg1  : i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.shl %2, %0  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_trunc_shl_ashr_var   : trunc_shl_ashr_var_before  ⊑  trunc_shl_ashr_var_combined := by
  unfold trunc_shl_ashr_var_before trunc_shl_ashr_var_combined
  simp_alive_peephole
  sorry
def trunc_shl_shl_var_combined := [llvmfunc|
  llvm.func @trunc_shl_shl_var(%arg0: i64, %arg1: i64) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.shl %arg0, %arg1  : i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.shl %2, %0  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_trunc_shl_shl_var   : trunc_shl_shl_var_before  ⊑  trunc_shl_shl_var_combined := by
  unfold trunc_shl_shl_var_before trunc_shl_shl_var_combined
  simp_alive_peephole
  sorry
def trunc_shl_v8i15_v8i32_15_combined := [llvmfunc|
  llvm.func @trunc_shl_v8i15_v8i32_15(%arg0: vector<8xi32>) -> vector<8xi16> {
    %0 = llvm.mlir.constant(dense<15> : vector<8xi16>) : vector<8xi16>
    %1 = llvm.trunc %arg0 : vector<8xi32> to vector<8xi16>
    %2 = llvm.shl %1, %0  : vector<8xi16>
    llvm.return %2 : vector<8xi16>
  }]

theorem inst_combine_trunc_shl_v8i15_v8i32_15   : trunc_shl_v8i15_v8i32_15_before  ⊑  trunc_shl_v8i15_v8i32_15_combined := by
  unfold trunc_shl_v8i15_v8i32_15_before trunc_shl_v8i15_v8i32_15_combined
  simp_alive_peephole
  sorry
def trunc_shl_v8i16_v8i32_16_combined := [llvmfunc|
  llvm.func @trunc_shl_v8i16_v8i32_16(%arg0: vector<8xi32>) -> vector<8xi16> {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(dense<0> : vector<8xi16>) : vector<8xi16>
    llvm.return %1 : vector<8xi16>
  }]

theorem inst_combine_trunc_shl_v8i16_v8i32_16   : trunc_shl_v8i16_v8i32_16_before  ⊑  trunc_shl_v8i16_v8i32_16_combined := by
  unfold trunc_shl_v8i16_v8i32_16_before trunc_shl_v8i16_v8i32_16_combined
  simp_alive_peephole
  sorry
def trunc_shl_v8i16_v8i32_17_combined := [llvmfunc|
  llvm.func @trunc_shl_v8i16_v8i32_17(%arg0: vector<8xi32>) -> vector<8xi16> {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(dense<0> : vector<8xi16>) : vector<8xi16>
    llvm.return %1 : vector<8xi16>
  }]

theorem inst_combine_trunc_shl_v8i16_v8i32_17   : trunc_shl_v8i16_v8i32_17_before  ⊑  trunc_shl_v8i16_v8i32_17_combined := by
  unfold trunc_shl_v8i16_v8i32_17_before trunc_shl_v8i16_v8i32_17_combined
  simp_alive_peephole
  sorry
def trunc_shl_v8i16_v8i32_4_combined := [llvmfunc|
  llvm.func @trunc_shl_v8i16_v8i32_4(%arg0: vector<8xi32>) -> vector<8xi16> {
    %0 = llvm.mlir.constant(dense<4> : vector<8xi16>) : vector<8xi16>
    %1 = llvm.trunc %arg0 : vector<8xi32> to vector<8xi16>
    %2 = llvm.shl %1, %0  : vector<8xi16>
    llvm.return %2 : vector<8xi16>
  }]

theorem inst_combine_trunc_shl_v8i16_v8i32_4   : trunc_shl_v8i16_v8i32_4_before  ⊑  trunc_shl_v8i16_v8i32_4_combined := by
  unfold trunc_shl_v8i16_v8i32_4_before trunc_shl_v8i16_v8i32_4_combined
  simp_alive_peephole
  sorry
def wide_shuf_combined := [llvmfunc|
  llvm.func @wide_shuf(%arg0: vector<4xi32>) -> vector<4xi8> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(90 : i32) : i32
    %2 = llvm.mlir.constant(3634 : i32) : i32
    %3 = llvm.mlir.undef : vector<4xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %0, %3[%4 : i32] : vector<4xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<4xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<4xi32>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %0, %9[%10 : i32] : vector<4xi32>
    %12 = llvm.shufflevector %arg0, %11 [1, 5, 6, 2] : vector<4xi32> 
    %13 = llvm.trunc %12 : vector<4xi32> to vector<4xi8>
    llvm.return %13 : vector<4xi8>
  }]

theorem inst_combine_wide_shuf   : wide_shuf_before  ⊑  wide_shuf_combined := by
  unfold wide_shuf_before wide_shuf_combined
  simp_alive_peephole
  sorry
def wide_splat1_combined := [llvmfunc|
  llvm.func @wide_splat1(%arg0: vector<4xi32>) -> vector<4xi8> {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.trunc %arg0 : vector<4xi32> to vector<4xi8>
    %2 = llvm.shufflevector %1, %0 [2, 2, 2, 2] : vector<4xi8> 
    llvm.return %2 : vector<4xi8>
  }]

theorem inst_combine_wide_splat1   : wide_splat1_before  ⊑  wide_splat1_combined := by
  unfold wide_splat1_before wide_splat1_combined
  simp_alive_peephole
  sorry
def wide_splat2_combined := [llvmfunc|
  llvm.func @wide_splat2(%arg0: vector<3xi33>) -> vector<3xi31> {
    %0 = llvm.mlir.poison : vector<3xi31>
    %1 = llvm.trunc %arg0 : vector<3xi33> to vector<3xi31>
    %2 = llvm.shufflevector %1, %0 [1, 1, 1] : vector<3xi31> 
    llvm.return %2 : vector<3xi31>
  }]

theorem inst_combine_wide_splat2   : wide_splat2_before  ⊑  wide_splat2_combined := by
  unfold wide_splat2_before wide_splat2_combined
  simp_alive_peephole
  sorry
def wide_splat3_combined := [llvmfunc|
  llvm.func @wide_splat3(%arg0: vector<3xi33>) -> vector<3xi31> {
    %0 = llvm.mlir.poison : vector<3xi33>
    %1 = llvm.shufflevector %arg0, %0 [-1, 1, 1] : vector<3xi33> 
    %2 = llvm.trunc %1 : vector<3xi33> to vector<3xi31>
    llvm.return %2 : vector<3xi31>
  }]

theorem inst_combine_wide_splat3   : wide_splat3_before  ⊑  wide_splat3_combined := by
  unfold wide_splat3_before wide_splat3_combined
  simp_alive_peephole
  sorry
def wide_lengthening_splat_combined := [llvmfunc|
  llvm.func @wide_lengthening_splat(%arg0: vector<4xi16>) -> vector<8xi8> {
    %0 = llvm.mlir.poison : vector<4xi16>
    %1 = llvm.shufflevector %arg0, %0 [0, 0, 0, 0, 0, 0, 0, 0] : vector<4xi16> 
    %2 = llvm.trunc %1 : vector<8xi16> to vector<8xi8>
    llvm.return %2 : vector<8xi8>
  }]

theorem inst_combine_wide_lengthening_splat   : wide_lengthening_splat_before  ⊑  wide_lengthening_splat_combined := by
  unfold wide_lengthening_splat_before wide_lengthening_splat_combined
  simp_alive_peephole
  sorry
def narrow_add_vec_constant_combined := [llvmfunc|
  llvm.func @narrow_add_vec_constant(%arg0: vector<2xi32>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[0, 127]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.trunc %arg0 : vector<2xi32> to vector<2xi8>
    %2 = llvm.add %1, %0  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

theorem inst_combine_narrow_add_vec_constant   : narrow_add_vec_constant_before  ⊑  narrow_add_vec_constant_combined := by
  unfold narrow_add_vec_constant_before narrow_add_vec_constant_combined
  simp_alive_peephole
  sorry
def narrow_mul_vec_constant_combined := [llvmfunc|
  llvm.func @narrow_mul_vec_constant(%arg0: vector<2xi32>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[0, 127]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.trunc %arg0 : vector<2xi32> to vector<2xi8>
    %2 = llvm.mul %1, %0  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

theorem inst_combine_narrow_mul_vec_constant   : narrow_mul_vec_constant_before  ⊑  narrow_mul_vec_constant_combined := by
  unfold narrow_mul_vec_constant_before narrow_mul_vec_constant_combined
  simp_alive_peephole
  sorry
def narrow_sub_vec_constant_combined := [llvmfunc|
  llvm.func @narrow_sub_vec_constant(%arg0: vector<2xi32>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[0, 127]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.trunc %arg0 : vector<2xi32> to vector<2xi8>
    %2 = llvm.sub %0, %1  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

theorem inst_combine_narrow_sub_vec_constant   : narrow_sub_vec_constant_before  ⊑  narrow_sub_vec_constant_combined := by
  unfold narrow_sub_vec_constant_before narrow_sub_vec_constant_combined
  simp_alive_peephole
  sorry
def PR44545_combined := [llvmfunc|
  llvm.func @PR44545(%arg0: i32, %arg1: i32) -> i16 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i16) : i16
    %2 = llvm.icmp "eq" %arg1, %0 : i32
    %3 = llvm.trunc %arg0 : i32 to i16
    %4 = llvm.select %2, %1, %3 : i1, i16
    llvm.return %4 : i16
  }]

theorem inst_combine_PR44545   : PR44545_before  ⊑  PR44545_combined := by
  unfold PR44545_before PR44545_combined
  simp_alive_peephole
  sorry
