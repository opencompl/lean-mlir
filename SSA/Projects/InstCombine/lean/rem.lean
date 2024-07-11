import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  rem
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def rem_signed_before := [llvmfunc|
  llvm.func @rem_signed(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.sdiv %arg0, %arg1  : i64
    %1 = llvm.mul %0, %arg1  : i64
    %2 = llvm.sub %arg0, %1  : i64
    llvm.return %2 : i64
  }]

def rem_signed_vec_before := [llvmfunc|
  llvm.func @rem_signed_vec(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.sdiv %arg0, %arg1  : vector<4xi32>
    %1 = llvm.mul %0, %arg1  : vector<4xi32>
    %2 = llvm.sub %arg0, %1  : vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }]

def rem_unsigned_before := [llvmfunc|
  llvm.func @rem_unsigned(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.udiv %arg0, %arg1  : i64
    %1 = llvm.mul %0, %arg1  : i64
    %2 = llvm.sub %arg0, %1  : i64
    llvm.return %2 : i64
  }]

def big_divisor_before := [llvmfunc|
  llvm.func @big_divisor(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-127 : i8) : i8
    %1 = llvm.urem %arg0, %0  : i8
    llvm.return %1 : i8
  }]

def biggest_divisor_before := [llvmfunc|
  llvm.func @biggest_divisor(%arg0: i5) -> i5 {
    %0 = llvm.mlir.constant(-1 : i5) : i5
    %1 = llvm.urem %arg0, %0  : i5
    llvm.return %1 : i5
  }]

def urem_with_sext_bool_divisor_before := [llvmfunc|
  llvm.func @urem_with_sext_bool_divisor(%arg0: i1, %arg1: i8) -> i8 {
    %0 = llvm.sext %arg0 : i1 to i8
    %1 = llvm.urem %arg1, %0  : i8
    llvm.return %1 : i8
  }]

def urem_with_sext_bool_divisor_vec_before := [llvmfunc|
  llvm.func @urem_with_sext_bool_divisor_vec(%arg0: vector<2xi1>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.sext %arg0 : vector<2xi1> to vector<2xi8>
    %1 = llvm.urem %arg1, %0  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

def big_divisor_vec_before := [llvmfunc|
  llvm.func @big_divisor_vec(%arg0: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-3 : i4) : i4
    %1 = llvm.mlir.constant(dense<-3> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.urem %arg0, %1  : vector<2xi4>
    llvm.return %2 : vector<2xi4>
  }]

def urem1_before := [llvmfunc|
  llvm.func @urem1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.udiv %arg0, %arg1  : i8
    %1 = llvm.mul %0, %arg1  : i8
    %2 = llvm.sub %arg0, %1  : i8
    llvm.return %2 : i8
  }]

def srem1_before := [llvmfunc|
  llvm.func @srem1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.sdiv %arg0, %arg1  : i8
    %1 = llvm.mul %0, %arg1  : i8
    %2 = llvm.sub %arg0, %1  : i8
    llvm.return %2 : i8
  }]

def urem2_before := [llvmfunc|
  llvm.func @urem2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.udiv %arg0, %arg1  : i8
    %1 = llvm.mul %0, %arg1  : i8
    %2 = llvm.sub %1, %arg0  : i8
    llvm.return %2 : i8
  }]

def urem3_before := [llvmfunc|
  llvm.func @urem3(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(-3 : i8) : i8
    %2 = llvm.udiv %arg0, %0  : i8
    %3 = llvm.mul %2, %1  : i8
    %4 = llvm.sub %arg0, %3  : i8
    llvm.return %4 : i8
  }]

def sdiv_mul_sdiv_before := [llvmfunc|
  llvm.func @sdiv_mul_sdiv(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.sdiv %arg0, %arg1  : i32
    %1 = llvm.mul %0, %arg1  : i32
    %2 = llvm.sdiv %1, %arg1  : i32
    llvm.return %2 : i32
  }]

def udiv_mul_udiv_before := [llvmfunc|
  llvm.func @udiv_mul_udiv(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.udiv %arg0, %arg1  : i32
    %1 = llvm.mul %0, %arg1  : i32
    %2 = llvm.udiv %1, %arg1  : i32
    llvm.return %2 : i32
  }]

def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.srem %arg0, %0  : i32
    llvm.return %1 : i32
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.urem %arg0, %0  : i32
    llvm.return %1 : i32
  }]

def vec_power_of_2_constant_splat_divisor_before := [llvmfunc|
  llvm.func @vec_power_of_2_constant_splat_divisor(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.urem %arg0, %0  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

def weird_vec_power_of_2_constant_splat_divisor_before := [llvmfunc|
  llvm.func @weird_vec_power_of_2_constant_splat_divisor(%arg0: vector<2xi19>) -> vector<2xi19> {
    %0 = llvm.mlir.constant(8 : i19) : i19
    %1 = llvm.mlir.constant(dense<8> : vector<2xi19>) : vector<2xi19>
    %2 = llvm.urem %arg0, %1  : vector<2xi19>
    llvm.return %2 : vector<2xi19>
  }]

def test3a_before := [llvmfunc|
  llvm.func @test3a(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.srem %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

def test3a_vec_before := [llvmfunc|
  llvm.func @test3a_vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-8> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.srem %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "ne" %3, %2 : vector<2xi32>
    llvm.return %4 : vector<2xi1>
  }]

def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.select %arg1, %0, %1 : i1, i32
    %3 = llvm.urem %arg0, %2  : i32
    llvm.return %3 : i32
  }]

def test5_before := [llvmfunc|
  llvm.func @test5(%arg0: i32, %arg1: i8) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.zext %arg1 : i8 to i32
    %2 = llvm.shl %0, %1  : i32
    %3 = llvm.urem %arg0, %2  : i32
    llvm.return %3 : i32
  }]

def test6_before := [llvmfunc|
  llvm.func @test6(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.srem %arg0, %0  : i32
    llvm.return %1 : i32
  }]

def test7_before := [llvmfunc|
  llvm.func @test7(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.mul %arg0, %0  : i32
    %3 = llvm.srem %2, %1  : i32
    llvm.return %3 : i32
  }]

def test8_before := [llvmfunc|
  llvm.func @test8(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.srem %2, %1  : i32
    llvm.return %3 : i32
  }]

def test9_before := [llvmfunc|
  llvm.func @test9(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.mul %arg0, %0  : i32
    %3 = llvm.urem %2, %1  : i32
    llvm.return %3 : i32
  }]

def test10_before := [llvmfunc|
  llvm.func @test10(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(4 : i64) : i64
    %2 = llvm.zext %arg0 : i8 to i32
    %3 = llvm.mul %2, %0  : i32
    %4 = llvm.sext %3 : i32 to i64
    %5 = llvm.urem %4, %1  : i64
    %6 = llvm.trunc %5 : i64 to i32
    llvm.return %6 : i32
  }]

def test11_before := [llvmfunc|
  llvm.func @test11(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.mul %3, %1  : i32
    %5 = llvm.urem %4, %2  : i32
    llvm.return %5 : i32
  }]

def test12_before := [llvmfunc|
  llvm.func @test12(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-4 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.srem %2, %1  : i32
    llvm.return %3 : i32
  }]

def test13_before := [llvmfunc|
  llvm.func @test13(%arg0: i32) -> i32 {
    %0 = llvm.srem %arg0, %arg0  : i32
    llvm.return %0 : i32
  }]

def test14_before := [llvmfunc|
  llvm.func @test14(%arg0: i64, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %0, %arg1  : i32
    %2 = llvm.zext %1 : i32 to i64
    %3 = llvm.urem %arg0, %2  : i64
    llvm.return %3 : i64
  }]

def test15_before := [llvmfunc|
  llvm.func @test15(%arg0: i32, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %0, %arg1  : i32
    %2 = llvm.zext %1 : i32 to i64
    %3 = llvm.zext %arg0 : i32 to i64
    %4 = llvm.urem %3, %2  : i64
    llvm.return %4 : i64
  }]

def test16_before := [llvmfunc|
  llvm.func @test16(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(11 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.lshr %arg1, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.add %3, %1  : i32
    %5 = llvm.urem %arg0, %4  : i32
    llvm.return %5 : i32
  }]

def test17_before := [llvmfunc|
  llvm.func @test17(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.urem %0, %arg0  : i32
    llvm.return %1 : i32
  }]

def test18_before := [llvmfunc|
  llvm.func @test18(%arg0: i16, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i16) : i16
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.mlir.constant(64 : i32) : i32
    %4 = llvm.and %arg0, %0  : i16
    %5 = llvm.icmp "ne" %4, %1 : i16
    %6 = llvm.select %5, %2, %3 : i1, i32
    %7 = llvm.urem %arg1, %6  : i32
    llvm.return %7 : i32
  }]

def test19_before := [llvmfunc|
  llvm.func @test19(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %0, %arg0  : i32
    %2 = llvm.shl %0, %arg1  : i32
    %3 = llvm.and %1, %2  : i32
    %4 = llvm.add %3, %1  : i32
    %5 = llvm.urem %arg1, %4  : i32
    llvm.return %5 : i32
  }]

def test19_commutative0_before := [llvmfunc|
  llvm.func @test19_commutative0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %0, %arg0  : i32
    %2 = llvm.shl %0, %arg1  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.add %3, %1  : i32
    %5 = llvm.urem %arg1, %4  : i32
    llvm.return %5 : i32
  }]

def test19_commutative1_before := [llvmfunc|
  llvm.func @test19_commutative1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %0, %arg0  : i32
    %2 = llvm.shl %0, %arg1  : i32
    %3 = llvm.and %1, %2  : i32
    %4 = llvm.add %1, %3  : i32
    %5 = llvm.urem %arg1, %4  : i32
    llvm.return %5 : i32
  }]

def test19_commutative2_before := [llvmfunc|
  llvm.func @test19_commutative2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %0, %arg0  : i32
    %2 = llvm.shl %0, %arg1  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.add %1, %3  : i32
    %5 = llvm.urem %arg1, %4  : i32
    llvm.return %5 : i32
  }]

def test20_before := [llvmfunc|
  llvm.func @test20(%arg0: vector<2xi64>, %arg1: vector<2xi1>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<[8, 9]> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.mlir.constant(dense<[2, 3]> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.select %arg1, %0, %1 : vector<2xi1>, vector<2xi64>
    %4 = llvm.urem %3, %2  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

def test21_before := [llvmfunc|
  llvm.func @test21(%arg0: i1, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    %1 = llvm.load volatile %arg1 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.br ^bb2(%1 : i32)
  ^bb2(%2: i32):  // 2 preds: ^bb0, ^bb1
    %3 = llvm.srem %2, %0  : i32
    llvm.return %3 : i32
  }]

def pr27968_0_before := [llvmfunc|
  llvm.func @pr27968_0(%arg0: i1, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(4 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(0 : i16) : i16
    %4 = llvm.mlir.constant(dense<0> : tensor<5xi16>) : !llvm.array<5 x i16>
    %5 = llvm.mlir.addressof @a : !llvm.ptr
    %6 = llvm.getelementptr inbounds %5[%2, %1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<5 x i16>
    %7 = llvm.mlir.addressof @b : !llvm.ptr
    %8 = llvm.mlir.constant(0 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    %9 = llvm.load volatile %arg1 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.br ^bb2(%9 : i32)
  ^bb2(%10: i32):  // 2 preds: ^bb0, ^bb1
    %11 = llvm.icmp "eq" %6, %7 : !llvm.ptr
    llvm.cond_br %11, ^bb3, ^bb4
  ^bb3:  // pred: ^bb2
    %12 = llvm.zext %11 : i1 to i32
    %13 = llvm.srem %10, %12  : i32
    llvm.return %13 : i32
  ^bb4:  // pred: ^bb2
    llvm.return %8 : i32
  }]

def pr27968_1_before := [llvmfunc|
  llvm.func @pr27968_1(%arg0: i1, %arg1: i1, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-2147483648 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    %3 = llvm.load volatile %arg2 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.br ^bb2(%3 : i32)
  ^bb2(%4: i32):  // 2 preds: ^bb0, ^bb1
    llvm.cond_br %arg1, ^bb3, ^bb4
  ^bb3:  // pred: ^bb2
    %5 = llvm.srem %4, %2  : i32
    llvm.return %5 : i32
  ^bb4:  // pred: ^bb2
    llvm.return %1 : i32
  }]

def pr27968_2_before := [llvmfunc|
  llvm.func @pr27968_2(%arg0: i1, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(4 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(0 : i16) : i16
    %4 = llvm.mlir.constant(dense<0> : tensor<5xi16>) : !llvm.array<5 x i16>
    %5 = llvm.mlir.addressof @a : !llvm.ptr
    %6 = llvm.getelementptr inbounds %5[%2, %1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<5 x i16>
    %7 = llvm.mlir.addressof @b : !llvm.ptr
    %8 = llvm.mlir.constant(0 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    %9 = llvm.load volatile %arg1 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.br ^bb2(%9 : i32)
  ^bb2(%10: i32):  // 2 preds: ^bb0, ^bb1
    %11 = llvm.icmp "eq" %6, %7 : !llvm.ptr
    llvm.cond_br %11, ^bb3, ^bb4
  ^bb3:  // pred: ^bb2
    %12 = llvm.zext %11 : i1 to i32
    %13 = llvm.urem %10, %12  : i32
    llvm.return %13 : i32
  ^bb4:  // pred: ^bb2
    llvm.return %8 : i32
  }]

def pr27968_3_before := [llvmfunc|
  llvm.func @pr27968_3(%arg0: i1, %arg1: i1, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-2147483648 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    %3 = llvm.load volatile %arg2 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.br ^bb2(%3 : i32)
  ^bb2(%4: i32):  // 2 preds: ^bb0, ^bb1
    llvm.cond_br %arg1, ^bb3, ^bb4
  ^bb3:  // pred: ^bb2
    %5 = llvm.urem %4, %2  : i32
    llvm.return %5 : i32
  ^bb4:  // pred: ^bb2
    llvm.return %1 : i32
  }]

def test22_before := [llvmfunc|
  llvm.func @test22(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.srem %1, %0  : i32
    llvm.return %2 : i32
  }]

def test23_before := [llvmfunc|
  llvm.func @test23(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<2147483647> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.and %arg0, %0  : vector<2xi32>
    %2 = llvm.srem %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def test24_before := [llvmfunc|
  llvm.func @test24(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.urem %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

def test24_vec_before := [llvmfunc|
  llvm.func @test24_vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-2147483648> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.urem %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "ne" %3, %2 : vector<2xi32>
    llvm.return %4 : vector<2xi1>
  }]

def test25_before := [llvmfunc|
  llvm.func @test25(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.srem %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

def test25_vec_before := [llvmfunc|
  llvm.func @test25_vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-2147483648> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.srem %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "ne" %3, %2 : vector<2xi32>
    llvm.return %4 : vector<2xi1>
  }]

def test26_before := [llvmfunc|
  llvm.func @test26(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %0, %arg1  : i32
    %3 = llvm.srem %arg0, %2  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    llvm.return %4 : i1
  }]

def test27_before := [llvmfunc|
  llvm.func @test27(%arg0: i32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.srem %arg0, %0  : i32
    llvm.store %2, %arg1 {alignment = 1 : i64} : i32, !llvm.ptr]

    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

def test28_before := [llvmfunc|
  llvm.func @test28(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.srem %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

def positive_and_odd_eq_before := [llvmfunc|
  llvm.func @positive_and_odd_eq(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.srem %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

def negative_and_odd_eq_before := [llvmfunc|
  llvm.func @negative_and_odd_eq(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.srem %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

def positive_and_odd_ne_before := [llvmfunc|
  llvm.func @positive_and_odd_ne(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.srem %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

def negative_and_odd_ne_before := [llvmfunc|
  llvm.func @negative_and_odd_ne(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.srem %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

def PR34870_before := [llvmfunc|
  llvm.func @PR34870(%arg0: i1, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.select %arg0, %arg2, %0 : i1, f64
    %2 = llvm.frem %arg1, %1  : f64
    llvm.return %2 : f64
  }]

def srem_constant_dividend_select_of_constants_divisor_before := [llvmfunc|
  llvm.func @srem_constant_dividend_select_of_constants_divisor(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(-3 : i32) : i32
    %2 = llvm.mlir.constant(42 : i32) : i32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    %4 = llvm.srem %2, %3  : i32
    llvm.return %4 : i32
  }]

def srem_constant_dividend_select_of_constants_divisor_use_before := [llvmfunc|
  llvm.func @srem_constant_dividend_select_of_constants_divisor_use(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(-3 : i32) : i32
    %2 = llvm.mlir.constant(42 : i32) : i32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.srem %2, %3  : i32
    llvm.return %4 : i32
  }]

def srem_constant_dividend_select_of_constants_divisor_0_arm_before := [llvmfunc|
  llvm.func @srem_constant_dividend_select_of_constants_divisor_0_arm(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(42 : i32) : i32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    %4 = llvm.srem %2, %3  : i32
    llvm.return %4 : i32
  }]

def srem_constant_dividend_select_divisor1_before := [llvmfunc|
  llvm.func @srem_constant_dividend_select_divisor1(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-3 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.select %arg0, %arg1, %0 : i1, i32
    %3 = llvm.srem %1, %2  : i32
    llvm.return %3 : i32
  }]

def srem_constant_dividend_select_divisor2_before := [llvmfunc|
  llvm.func @srem_constant_dividend_select_divisor2(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.select %arg0, %0, %arg1 : i1, i32
    %3 = llvm.srem %1, %2  : i32
    llvm.return %3 : i32
  }]

def srem_constant_dividend_select_of_constants_divisor_vec_before := [llvmfunc|
  llvm.func @srem_constant_dividend_select_of_constants_divisor_vec(%arg0: i1) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[12, -5]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[-4, 4]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<[42, -42]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.select %arg0, %0, %1 : i1, vector<2xi8>
    %4 = llvm.srem %2, %3  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

def srem_constant_dividend_select_of_constants_divisor_vec_ub1_before := [llvmfunc|
  llvm.func @srem_constant_dividend_select_of_constants_divisor_vec_ub1(%arg0: i1) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[0, -5]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[-4, 4]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<[42, -42]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.select %arg0, %0, %1 : i1, vector<2xi8>
    %4 = llvm.srem %2, %3  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

def srem_constant_dividend_select_of_constants_divisor_vec_ub2_before := [llvmfunc|
  llvm.func @srem_constant_dividend_select_of_constants_divisor_vec_ub2(%arg0: i1) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[12, -5]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[-4, -1]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<[42, -128]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.select %arg0, %0, %1 : i1, vector<2xi8>
    %4 = llvm.srem %2, %3  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

def srem_select_of_constants_divisor_before := [llvmfunc|
  llvm.func @srem_select_of_constants_divisor(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(-3 : i32) : i32
    %2 = llvm.select %arg0, %0, %1 : i1, i32
    %3 = llvm.srem %arg1, %2  : i32
    llvm.return %3 : i32
  }]

def urem_constant_dividend_select_of_constants_divisor_before := [llvmfunc|
  llvm.func @urem_constant_dividend_select_of_constants_divisor(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(-3 : i32) : i32
    %2 = llvm.mlir.constant(42 : i32) : i32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    %4 = llvm.urem %2, %3  : i32
    llvm.return %4 : i32
  }]

def urem_constant_dividend_select_of_constants_divisor_use_before := [llvmfunc|
  llvm.func @urem_constant_dividend_select_of_constants_divisor_use(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(-3 : i32) : i32
    %2 = llvm.mlir.constant(42 : i32) : i32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.urem %2, %3  : i32
    llvm.return %4 : i32
  }]

def urem_constant_dividend_select_of_constants_divisor_0_arm_before := [llvmfunc|
  llvm.func @urem_constant_dividend_select_of_constants_divisor_0_arm(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(42 : i32) : i32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    %4 = llvm.urem %2, %3  : i32
    llvm.return %4 : i32
  }]

def urem_constant_dividend_select_divisor1_before := [llvmfunc|
  llvm.func @urem_constant_dividend_select_divisor1(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-3 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.select %arg0, %arg1, %0 : i1, i32
    %3 = llvm.urem %1, %2  : i32
    llvm.return %3 : i32
  }]

def urem_constant_dividend_select_divisor2_before := [llvmfunc|
  llvm.func @urem_constant_dividend_select_divisor2(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.select %arg0, %0, %arg1 : i1, i32
    %3 = llvm.urem %1, %2  : i32
    llvm.return %3 : i32
  }]

def urem_constant_dividend_select_of_constants_divisor_vec_before := [llvmfunc|
  llvm.func @urem_constant_dividend_select_of_constants_divisor_vec(%arg0: i1) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[12, -5]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[-4, 4]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<[42, -42]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.select %arg0, %0, %1 : i1, vector<2xi8>
    %4 = llvm.urem %2, %3  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

def urem_constant_dividend_select_of_constants_divisor_vec_ub1_before := [llvmfunc|
  llvm.func @urem_constant_dividend_select_of_constants_divisor_vec_ub1(%arg0: i1) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[0, -5]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[-4, 4]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<[42, -42]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.select %arg0, %0, %1 : i1, vector<2xi8>
    %4 = llvm.urem %2, %3  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

def urem_constant_dividend_select_of_constants_divisor_vec_ub2_before := [llvmfunc|
  llvm.func @urem_constant_dividend_select_of_constants_divisor_vec_ub2(%arg0: i1) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[12, -5]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[-4, -1]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<[42, -128]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.select %arg0, %0, %1 : i1, vector<2xi8>
    %4 = llvm.urem %2, %3  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

def urem_select_of_constants_divisor_before := [llvmfunc|
  llvm.func @urem_select_of_constants_divisor(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(-3 : i32) : i32
    %2 = llvm.select %arg0, %0, %1 : i1, i32
    %3 = llvm.urem %arg1, %2  : i32
    llvm.return %3 : i32
  }]

def PR62401_before := [llvmfunc|
  llvm.func @PR62401(%arg0: vector<2xi1>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.sext %arg0 : vector<2xi1> to vector<2xi32>
    %1 = llvm.urem %arg1, %0  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

def rem_signed_combined := [llvmfunc|
  llvm.func @rem_signed(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.freeze %arg0 : i64
    %1 = llvm.srem %0, %arg1  : i64
    llvm.return %1 : i64
  }]

theorem inst_combine_rem_signed   : rem_signed_before  ⊑  rem_signed_combined := by
  unfold rem_signed_before rem_signed_combined
  simp_alive_peephole
  sorry
def rem_signed_vec_combined := [llvmfunc|
  llvm.func @rem_signed_vec(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.freeze %arg0 : vector<4xi32>
    %1 = llvm.srem %0, %arg1  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_rem_signed_vec   : rem_signed_vec_before  ⊑  rem_signed_vec_combined := by
  unfold rem_signed_vec_before rem_signed_vec_combined
  simp_alive_peephole
  sorry
def rem_unsigned_combined := [llvmfunc|
  llvm.func @rem_unsigned(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.freeze %arg0 : i64
    %1 = llvm.urem %0, %arg1  : i64
    llvm.return %1 : i64
  }]

theorem inst_combine_rem_unsigned   : rem_unsigned_before  ⊑  rem_unsigned_combined := by
  unfold rem_unsigned_before rem_unsigned_combined
  simp_alive_peephole
  sorry
def big_divisor_combined := [llvmfunc|
  llvm.func @big_divisor(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-127 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.freeze %arg0 : i8
    %3 = llvm.icmp "ult" %2, %0 : i8
    %4 = llvm.add %2, %1  : i8
    %5 = llvm.select %3, %2, %4 : i1, i8
    llvm.return %5 : i8
  }]

theorem inst_combine_big_divisor   : big_divisor_before  ⊑  big_divisor_combined := by
  unfold big_divisor_before big_divisor_combined
  simp_alive_peephole
  sorry
def biggest_divisor_combined := [llvmfunc|
  llvm.func @biggest_divisor(%arg0: i5) -> i5 {
    %0 = llvm.mlir.constant(-1 : i5) : i5
    %1 = llvm.mlir.constant(0 : i5) : i5
    %2 = llvm.freeze %arg0 : i5
    %3 = llvm.icmp "eq" %2, %0 : i5
    %4 = llvm.select %3, %1, %2 : i1, i5
    llvm.return %4 : i5
  }]

theorem inst_combine_biggest_divisor   : biggest_divisor_before  ⊑  biggest_divisor_combined := by
  unfold biggest_divisor_before biggest_divisor_combined
  simp_alive_peephole
  sorry
def urem_with_sext_bool_divisor_combined := [llvmfunc|
  llvm.func @urem_with_sext_bool_divisor(%arg0: i1, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.freeze %arg1 : i8
    %3 = llvm.icmp "eq" %2, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i8
    llvm.return %4 : i8
  }]

theorem inst_combine_urem_with_sext_bool_divisor   : urem_with_sext_bool_divisor_before  ⊑  urem_with_sext_bool_divisor_combined := by
  unfold urem_with_sext_bool_divisor_before urem_with_sext_bool_divisor_combined
  simp_alive_peephole
  sorry
def urem_with_sext_bool_divisor_vec_combined := [llvmfunc|
  llvm.func @urem_with_sext_bool_divisor_vec(%arg0: vector<2xi1>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.freeze %arg1 : vector<2xi8>
    %4 = llvm.icmp "eq" %3, %0 : vector<2xi8>
    %5 = llvm.select %4, %2, %3 : vector<2xi1>, vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }]

theorem inst_combine_urem_with_sext_bool_divisor_vec   : urem_with_sext_bool_divisor_vec_before  ⊑  urem_with_sext_bool_divisor_vec_combined := by
  unfold urem_with_sext_bool_divisor_vec_before urem_with_sext_bool_divisor_vec_combined
  simp_alive_peephole
  sorry
def big_divisor_vec_combined := [llvmfunc|
  llvm.func @big_divisor_vec(%arg0: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-3 : i4) : i4
    %1 = llvm.mlir.constant(dense<-3> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.mlir.constant(3 : i4) : i4
    %3 = llvm.mlir.constant(dense<3> : vector<2xi4>) : vector<2xi4>
    %4 = llvm.freeze %arg0 : vector<2xi4>
    %5 = llvm.icmp "ult" %4, %1 : vector<2xi4>
    %6 = llvm.add %4, %3  : vector<2xi4>
    %7 = llvm.select %5, %4, %6 : vector<2xi1>, vector<2xi4>
    llvm.return %7 : vector<2xi4>
  }]

theorem inst_combine_big_divisor_vec   : big_divisor_vec_before  ⊑  big_divisor_vec_combined := by
  unfold big_divisor_vec_before big_divisor_vec_combined
  simp_alive_peephole
  sorry
def urem1_combined := [llvmfunc|
  llvm.func @urem1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.freeze %arg0 : i8
    %1 = llvm.urem %0, %arg1  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_urem1   : urem1_before  ⊑  urem1_combined := by
  unfold urem1_before urem1_combined
  simp_alive_peephole
  sorry
def srem1_combined := [llvmfunc|
  llvm.func @srem1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.freeze %arg0 : i8
    %1 = llvm.srem %0, %arg1  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_srem1   : srem1_before  ⊑  srem1_combined := by
  unfold srem1_before srem1_combined
  simp_alive_peephole
  sorry
def urem2_combined := [llvmfunc|
  llvm.func @urem2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.freeze %arg0 : i8
    %2 = llvm.urem %1, %arg1  : i8
    %3 = llvm.sub %0, %2  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_urem2   : urem2_before  ⊑  urem2_combined := by
  unfold urem2_before urem2_combined
  simp_alive_peephole
  sorry
def urem3_combined := [llvmfunc|
  llvm.func @urem3(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.freeze %arg0 : i8
    %2 = llvm.urem %1, %0  : i8
    %3 = llvm.sub %1, %2 overflow<nuw>  : i8
    %4 = llvm.add %3, %1  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_urem3   : urem3_before  ⊑  urem3_combined := by
  unfold urem3_before urem3_combined
  simp_alive_peephole
  sorry
def sdiv_mul_sdiv_combined := [llvmfunc|
  llvm.func @sdiv_mul_sdiv(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.freeze %arg0 : i32
    %1 = llvm.sdiv %0, %arg1  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_sdiv_mul_sdiv   : sdiv_mul_sdiv_before  ⊑  sdiv_mul_sdiv_combined := by
  unfold sdiv_mul_sdiv_before sdiv_mul_sdiv_combined
  simp_alive_peephole
  sorry
def udiv_mul_udiv_combined := [llvmfunc|
  llvm.func @udiv_mul_udiv(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.freeze %arg0 : i32
    %1 = llvm.udiv %0, %arg1  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_udiv_mul_udiv   : udiv_mul_udiv_before  ⊑  udiv_mul_udiv_combined := by
  unfold udiv_mul_udiv_before udiv_mul_udiv_combined
  simp_alive_peephole
  sorry
def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def vec_power_of_2_constant_splat_divisor_combined := [llvmfunc|
  llvm.func @vec_power_of_2_constant_splat_divisor(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.and %arg0, %0  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_vec_power_of_2_constant_splat_divisor   : vec_power_of_2_constant_splat_divisor_before  ⊑  vec_power_of_2_constant_splat_divisor_combined := by
  unfold vec_power_of_2_constant_splat_divisor_before vec_power_of_2_constant_splat_divisor_combined
  simp_alive_peephole
  sorry
def weird_vec_power_of_2_constant_splat_divisor_combined := [llvmfunc|
  llvm.func @weird_vec_power_of_2_constant_splat_divisor(%arg0: vector<2xi19>) -> vector<2xi19> {
    %0 = llvm.mlir.constant(7 : i19) : i19
    %1 = llvm.mlir.constant(dense<7> : vector<2xi19>) : vector<2xi19>
    %2 = llvm.and %arg0, %1  : vector<2xi19>
    llvm.return %2 : vector<2xi19>
  }]

theorem inst_combine_weird_vec_power_of_2_constant_splat_divisor   : weird_vec_power_of_2_constant_splat_divisor_before  ⊑  weird_vec_power_of_2_constant_splat_divisor_combined := by
  unfold weird_vec_power_of_2_constant_splat_divisor_before weird_vec_power_of_2_constant_splat_divisor_combined
  simp_alive_peephole
  sorry
def test3a_combined := [llvmfunc|
  llvm.func @test3a(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_test3a   : test3a_before  ⊑  test3a_combined := by
  unfold test3a_before test3a_combined
  simp_alive_peephole
  sorry
def test3a_vec_combined := [llvmfunc|
  llvm.func @test3a_vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.and %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "ne" %3, %2 : vector<2xi32>
    llvm.return %4 : vector<2xi1>
  }]

theorem inst_combine_test3a_vec   : test3a_vec_before  ⊑  test3a_vec_combined := by
  unfold test3a_vec_before test3a_vec_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.select %arg1, %0, %1 : i1, i32
    %3 = llvm.and %2, %arg0  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5(%arg0: i32, %arg1: i8) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.zext %arg1 : i8 to i32
    %3 = llvm.shl %0, %2 overflow<nuw>  : i32
    %4 = llvm.add %3, %1  : i32
    %5 = llvm.and %4, %arg0  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
def test6_combined := [llvmfunc|
  llvm.func @test6(%arg0: i32) -> i32 {
    %0 = llvm.mlir.poison : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
def test7_combined := [llvmfunc|
  llvm.func @test7(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test7   : test7_before  ⊑  test7_combined := by
  unfold test7_before test7_combined
  simp_alive_peephole
  sorry
def test8_combined := [llvmfunc|
  llvm.func @test8(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test8   : test8_before  ⊑  test8_combined := by
  unfold test8_before test8_combined
  simp_alive_peephole
  sorry
def test9_combined := [llvmfunc|
  llvm.func @test9(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test9   : test9_before  ⊑  test9_combined := by
  unfold test9_before test9_combined
  simp_alive_peephole
  sorry
def test10_combined := [llvmfunc|
  llvm.func @test10(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test10   : test10_before  ⊑  test10_combined := by
  unfold test10_before test10_combined
  simp_alive_peephole
  sorry
def test11_combined := [llvmfunc|
  llvm.func @test11(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test11   : test11_before  ⊑  test11_combined := by
  unfold test11_before test11_combined
  simp_alive_peephole
  sorry
def test12_combined := [llvmfunc|
  llvm.func @test12(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test12   : test12_before  ⊑  test12_combined := by
  unfold test12_before test12_combined
  simp_alive_peephole
  sorry
def test13_combined := [llvmfunc|
  llvm.func @test13(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test13   : test13_before  ⊑  test13_combined := by
  unfold test13_before test13_combined
  simp_alive_peephole
  sorry
def test14_combined := [llvmfunc|
  llvm.func @test14(%arg0: i64, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i64) : i64
    %2 = llvm.shl %0, %arg1 overflow<nuw>  : i32
    %3 = llvm.zext %2 : i32 to i64
    %4 = llvm.add %3, %1 overflow<nsw>  : i64
    %5 = llvm.and %4, %arg0  : i64
    llvm.return %5 : i64
  }]

theorem inst_combine_test14   : test14_before  ⊑  test14_combined := by
  unfold test14_before test14_combined
  simp_alive_peephole
  sorry
def test15_combined := [llvmfunc|
  llvm.func @test15(%arg0: i32, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.shl %0, %arg1 overflow<nsw>  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.zext %3 : i32 to i64
    llvm.return %4 : i64
  }]

theorem inst_combine_test15   : test15_before  ⊑  test15_combined := by
  unfold test15_before test15_combined
  simp_alive_peephole
  sorry
def test16_combined := [llvmfunc|
  llvm.func @test16(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(11 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.lshr %arg1, %0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.or %4, %2  : i32
    %6 = llvm.and %5, %arg0  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_test16   : test16_before  ⊑  test16_combined := by
  unfold test16_before test16_combined
  simp_alive_peephole
  sorry
def test17_combined := [llvmfunc|
  llvm.func @test17(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    %2 = llvm.zext %1 : i1 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test17   : test17_before  ⊑  test17_combined := by
  unfold test17_before test17_combined
  simp_alive_peephole
  sorry
def test18_combined := [llvmfunc|
  llvm.func @test18(%arg0: i16, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i16) : i16
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.mlir.constant(63 : i32) : i32
    %3 = llvm.mlir.constant(31 : i32) : i32
    %4 = llvm.and %arg0, %0  : i16
    %5 = llvm.icmp "eq" %4, %1 : i16
    %6 = llvm.select %5, %2, %3 : i1, i32
    %7 = llvm.and %6, %arg1  : i32
    llvm.return %7 : i32
  }]

theorem inst_combine_test18   : test18_before  ⊑  test18_combined := by
  unfold test18_before test18_combined
  simp_alive_peephole
  sorry
def test19_combined := [llvmfunc|
  llvm.func @test19(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.shl %0, %arg0 overflow<nuw>  : i32
    %3 = llvm.shl %0, %arg1 overflow<nuw>  : i32
    %4 = llvm.and %2, %3  : i32
    %5 = llvm.add %4, %2  : i32
    %6 = llvm.add %5, %1  : i32
    %7 = llvm.and %6, %arg1  : i32
    llvm.return %7 : i32
  }]

theorem inst_combine_test19   : test19_before  ⊑  test19_combined := by
  unfold test19_before test19_combined
  simp_alive_peephole
  sorry
def test19_commutative0_combined := [llvmfunc|
  llvm.func @test19_commutative0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.shl %0, %arg0 overflow<nuw>  : i32
    %3 = llvm.shl %0, %arg1 overflow<nuw>  : i32
    %4 = llvm.and %3, %2  : i32
    %5 = llvm.add %4, %2  : i32
    %6 = llvm.add %5, %1  : i32
    %7 = llvm.and %6, %arg1  : i32
    llvm.return %7 : i32
  }]

theorem inst_combine_test19_commutative0   : test19_commutative0_before  ⊑  test19_commutative0_combined := by
  unfold test19_commutative0_before test19_commutative0_combined
  simp_alive_peephole
  sorry
def test19_commutative1_combined := [llvmfunc|
  llvm.func @test19_commutative1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.shl %0, %arg0 overflow<nuw>  : i32
    %3 = llvm.shl %0, %arg1 overflow<nuw>  : i32
    %4 = llvm.and %2, %3  : i32
    %5 = llvm.add %2, %4  : i32
    %6 = llvm.add %5, %1  : i32
    %7 = llvm.and %6, %arg1  : i32
    llvm.return %7 : i32
  }]

theorem inst_combine_test19_commutative1   : test19_commutative1_before  ⊑  test19_commutative1_combined := by
  unfold test19_commutative1_before test19_commutative1_combined
  simp_alive_peephole
  sorry
def test19_commutative2_combined := [llvmfunc|
  llvm.func @test19_commutative2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.shl %0, %arg0 overflow<nuw>  : i32
    %3 = llvm.shl %0, %arg1 overflow<nuw>  : i32
    %4 = llvm.and %3, %2  : i32
    %5 = llvm.add %2, %4  : i32
    %6 = llvm.add %5, %1  : i32
    %7 = llvm.and %6, %arg1  : i32
    llvm.return %7 : i32
  }]

theorem inst_combine_test19_commutative2   : test19_commutative2_before  ⊑  test19_commutative2_combined := by
  unfold test19_commutative2_before test19_commutative2_combined
  simp_alive_peephole
  sorry
def test20_combined := [llvmfunc|
  llvm.func @test20(%arg0: vector<2xi64>, %arg1: vector<2xi1>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.select %arg1, %0, %2 : vector<2xi1>, vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }]

theorem inst_combine_test20   : test20_before  ⊑  test20_combined := by
  unfold test20_before test20_combined
  simp_alive_peephole
  sorry
def test21_combined := [llvmfunc|
  llvm.func @test21(%arg0: i1, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    %2 = llvm.load volatile %arg1 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_test21   : test21_before  ⊑  test21_combined := by
  unfold test21_before test21_combined
  simp_alive_peephole
  sorry
    %3 = llvm.srem %2, %1  : i32
    llvm.br ^bb2(%3 : i32)
  ^bb2(%4: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i32
  }]

theorem inst_combine_test21   : test21_before  ⊑  test21_combined := by
  unfold test21_before test21_combined
  simp_alive_peephole
  sorry
def pr27968_0_combined := [llvmfunc|
  llvm.func @pr27968_0(%arg0: i1, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.addressof @b : !llvm.ptr
    %2 = llvm.mlir.constant(4 : i64) : i64
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.mlir.constant(dense<0> : tensor<5xi16>) : !llvm.array<5 x i16>
    %5 = llvm.mlir.addressof @a : !llvm.ptr
    %6 = llvm.getelementptr inbounds %5[%3, %2] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<5 x i16>
    %7 = llvm.icmp "eq" %6, %1 : !llvm.ptr
    %8 = llvm.mlir.constant(0 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %9 = llvm.load volatile %arg1 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_pr27968_0   : pr27968_0_before  ⊑  pr27968_0_combined := by
  unfold pr27968_0_before pr27968_0_combined
  simp_alive_peephole
  sorry
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.cond_br %7, ^bb3, ^bb4
  ^bb3:  // pred: ^bb2
    llvm.return %8 : i32
  ^bb4:  // pred: ^bb2
    llvm.return %8 : i32
  }]

theorem inst_combine_pr27968_0   : pr27968_0_before  ⊑  pr27968_0_combined := by
  unfold pr27968_0_before pr27968_0_combined
  simp_alive_peephole
  sorry
def pr27968_1_combined := [llvmfunc|
  llvm.func @pr27968_1(%arg0: i1, %arg1: i1, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-2147483648 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    %3 = llvm.load volatile %arg2 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_pr27968_1   : pr27968_1_before  ⊑  pr27968_1_combined := by
  unfold pr27968_1_before pr27968_1_combined
  simp_alive_peephole
  sorry
    llvm.br ^bb2(%3 : i32)
  ^bb2(%4: i32):  // 2 preds: ^bb0, ^bb1
    llvm.cond_br %arg1, ^bb3, ^bb4
  ^bb3:  // pred: ^bb2
    %5 = llvm.srem %4, %2  : i32
    llvm.return %5 : i32
  ^bb4:  // pred: ^bb2
    llvm.return %1 : i32
  }]

theorem inst_combine_pr27968_1   : pr27968_1_before  ⊑  pr27968_1_combined := by
  unfold pr27968_1_before pr27968_1_combined
  simp_alive_peephole
  sorry
def pr27968_2_combined := [llvmfunc|
  llvm.func @pr27968_2(%arg0: i1, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.addressof @b : !llvm.ptr
    %2 = llvm.mlir.constant(4 : i64) : i64
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.mlir.constant(dense<0> : tensor<5xi16>) : !llvm.array<5 x i16>
    %5 = llvm.mlir.addressof @a : !llvm.ptr
    %6 = llvm.getelementptr inbounds %5[%3, %2] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<5 x i16>
    %7 = llvm.icmp "eq" %6, %1 : !llvm.ptr
    %8 = llvm.mlir.constant(0 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %9 = llvm.load volatile %arg1 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_pr27968_2   : pr27968_2_before  ⊑  pr27968_2_combined := by
  unfold pr27968_2_before pr27968_2_combined
  simp_alive_peephole
  sorry
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.cond_br %7, ^bb3, ^bb4
  ^bb3:  // pred: ^bb2
    llvm.return %8 : i32
  ^bb4:  // pred: ^bb2
    llvm.return %8 : i32
  }]

theorem inst_combine_pr27968_2   : pr27968_2_before  ⊑  pr27968_2_combined := by
  unfold pr27968_2_before pr27968_2_combined
  simp_alive_peephole
  sorry
def pr27968_3_combined := [llvmfunc|
  llvm.func @pr27968_3(%arg0: i1, %arg1: i1, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(2147483647 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    %3 = llvm.load volatile %arg2 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_pr27968_3   : pr27968_3_before  ⊑  pr27968_3_combined := by
  unfold pr27968_3_before pr27968_3_combined
  simp_alive_peephole
  sorry
    %4 = llvm.and %3, %1  : i32
    llvm.br ^bb2(%4 : i32)
  ^bb2(%5: i32):  // 2 preds: ^bb0, ^bb1
    llvm.cond_br %arg1, ^bb3, ^bb4
  ^bb3:  // pred: ^bb2
    llvm.return %5 : i32
  ^bb4:  // pred: ^bb2
    llvm.return %2 : i32
  }]

theorem inst_combine_pr27968_3   : pr27968_3_before  ⊑  pr27968_3_combined := by
  unfold pr27968_3_before pr27968_3_combined
  simp_alive_peephole
  sorry
def test22_combined := [llvmfunc|
  llvm.func @test22(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.urem %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test22   : test22_before  ⊑  test22_combined := by
  unfold test22_before test22_combined
  simp_alive_peephole
  sorry
def test23_combined := [llvmfunc|
  llvm.func @test23(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<2147483647> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.and %arg0, %0  : vector<2xi32>
    %2 = llvm.urem %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_test23   : test23_before  ⊑  test23_combined := by
  unfold test23_before test23_combined
  simp_alive_peephole
  sorry
def test24_combined := [llvmfunc|
  llvm.func @test24(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_test24   : test24_before  ⊑  test24_combined := by
  unfold test24_before test24_combined
  simp_alive_peephole
  sorry
def test24_vec_combined := [llvmfunc|
  llvm.func @test24_vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<2147483647> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.and %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "ne" %3, %2 : vector<2xi32>
    llvm.return %4 : vector<2xi1>
  }]

theorem inst_combine_test24_vec   : test24_vec_before  ⊑  test24_vec_combined := by
  unfold test24_vec_before test24_vec_combined
  simp_alive_peephole
  sorry
def test25_combined := [llvmfunc|
  llvm.func @test25(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_test25   : test25_before  ⊑  test25_combined := by
  unfold test25_before test25_combined
  simp_alive_peephole
  sorry
def test25_vec_combined := [llvmfunc|
  llvm.func @test25_vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<2147483647> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.and %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "ne" %3, %2 : vector<2xi32>
    llvm.return %4 : vector<2xi1>
  }]

theorem inst_combine_test25_vec   : test25_vec_before  ⊑  test25_vec_combined := by
  unfold test25_vec_before test25_vec_combined
  simp_alive_peephole
  sorry
def test26_combined := [llvmfunc|
  llvm.func @test26(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %0, %arg1 overflow<nsw>  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.and %3, %arg0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    llvm.return %5 : i1
  }]

theorem inst_combine_test26   : test26_before  ⊑  test26_combined := by
  unfold test26_before test26_combined
  simp_alive_peephole
  sorry
def test27_combined := [llvmfunc|
  llvm.func @test27(%arg0: i32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.srem %arg0, %0  : i32
    llvm.store %2, %arg1 {alignment = 1 : i64} : i32, !llvm.ptr]

theorem inst_combine_test27   : test27_before  ⊑  test27_combined := by
  unfold test27_before test27_combined
  simp_alive_peephole
  sorry
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_test27   : test27_before  ⊑  test27_combined := by
  unfold test27_before test27_combined
  simp_alive_peephole
  sorry
def test28_combined := [llvmfunc|
  llvm.func @test28(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_test28   : test28_before  ⊑  test28_combined := by
  unfold test28_before test28_combined
  simp_alive_peephole
  sorry
def positive_and_odd_eq_combined := [llvmfunc|
  llvm.func @positive_and_odd_eq(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483647 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_positive_and_odd_eq   : positive_and_odd_eq_before  ⊑  positive_and_odd_eq_combined := by
  unfold positive_and_odd_eq_before positive_and_odd_eq_combined
  simp_alive_peephole
  sorry
def negative_and_odd_eq_combined := [llvmfunc|
  llvm.func @negative_and_odd_eq(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.srem %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_negative_and_odd_eq   : negative_and_odd_eq_before  ⊑  negative_and_odd_eq_combined := by
  unfold negative_and_odd_eq_before negative_and_odd_eq_combined
  simp_alive_peephole
  sorry
def positive_and_odd_ne_combined := [llvmfunc|
  llvm.func @positive_and_odd_ne(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483647 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_positive_and_odd_ne   : positive_and_odd_ne_before  ⊑  positive_and_odd_ne_combined := by
  unfold positive_and_odd_ne_before positive_and_odd_ne_combined
  simp_alive_peephole
  sorry
def negative_and_odd_ne_combined := [llvmfunc|
  llvm.func @negative_and_odd_ne(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.srem %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_negative_and_odd_ne   : negative_and_odd_ne_before  ⊑  negative_and_odd_ne_combined := by
  unfold negative_and_odd_ne_before negative_and_odd_ne_combined
  simp_alive_peephole
  sorry
def PR34870_combined := [llvmfunc|
  llvm.func @PR34870(%arg0: i1, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.select %arg0, %arg2, %0 : i1, f64
    %2 = llvm.frem %arg1, %1  : f64
    llvm.return %2 : f64
  }]

theorem inst_combine_PR34870   : PR34870_before  ⊑  PR34870_combined := by
  unfold PR34870_before PR34870_combined
  simp_alive_peephole
  sorry
def srem_constant_dividend_select_of_constants_divisor_combined := [llvmfunc|
  llvm.func @srem_constant_dividend_select_of_constants_divisor(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.select %arg0, %0, %1 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_srem_constant_dividend_select_of_constants_divisor   : srem_constant_dividend_select_of_constants_divisor_before  ⊑  srem_constant_dividend_select_of_constants_divisor_combined := by
  unfold srem_constant_dividend_select_of_constants_divisor_before srem_constant_dividend_select_of_constants_divisor_combined
  simp_alive_peephole
  sorry
def srem_constant_dividend_select_of_constants_divisor_use_combined := [llvmfunc|
  llvm.func @srem_constant_dividend_select_of_constants_divisor_use(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(-3 : i32) : i32
    %2 = llvm.mlir.constant(6 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.select %arg0, %0, %1 : i1, i32
    llvm.call @use(%4) : (i32) -> ()
    %5 = llvm.select %arg0, %2, %3 : i1, i32
    llvm.return %5 : i32
  }]

theorem inst_combine_srem_constant_dividend_select_of_constants_divisor_use   : srem_constant_dividend_select_of_constants_divisor_use_before  ⊑  srem_constant_dividend_select_of_constants_divisor_use_combined := by
  unfold srem_constant_dividend_select_of_constants_divisor_use_before srem_constant_dividend_select_of_constants_divisor_use_combined
  simp_alive_peephole
  sorry
def srem_constant_dividend_select_of_constants_divisor_0_arm_combined := [llvmfunc|
  llvm.func @srem_constant_dividend_select_of_constants_divisor_0_arm(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_srem_constant_dividend_select_of_constants_divisor_0_arm   : srem_constant_dividend_select_of_constants_divisor_0_arm_before  ⊑  srem_constant_dividend_select_of_constants_divisor_0_arm_combined := by
  unfold srem_constant_dividend_select_of_constants_divisor_0_arm_before srem_constant_dividend_select_of_constants_divisor_0_arm_combined
  simp_alive_peephole
  sorry
def srem_constant_dividend_select_divisor1_combined := [llvmfunc|
  llvm.func @srem_constant_dividend_select_divisor1(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-3 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.select %arg0, %arg1, %0 : i1, i32
    %3 = llvm.srem %1, %2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_srem_constant_dividend_select_divisor1   : srem_constant_dividend_select_divisor1_before  ⊑  srem_constant_dividend_select_divisor1_combined := by
  unfold srem_constant_dividend_select_divisor1_before srem_constant_dividend_select_divisor1_combined
  simp_alive_peephole
  sorry
def srem_constant_dividend_select_divisor2_combined := [llvmfunc|
  llvm.func @srem_constant_dividend_select_divisor2(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.select %arg0, %0, %arg1 : i1, i32
    %3 = llvm.srem %1, %2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_srem_constant_dividend_select_divisor2   : srem_constant_dividend_select_divisor2_before  ⊑  srem_constant_dividend_select_divisor2_combined := by
  unfold srem_constant_dividend_select_divisor2_before srem_constant_dividend_select_divisor2_combined
  simp_alive_peephole
  sorry
def srem_constant_dividend_select_of_constants_divisor_vec_combined := [llvmfunc|
  llvm.func @srem_constant_dividend_select_of_constants_divisor_vec(%arg0: i1) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[6, -2]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[2, -2]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.select %arg0, %0, %1 : i1, vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

theorem inst_combine_srem_constant_dividend_select_of_constants_divisor_vec   : srem_constant_dividend_select_of_constants_divisor_vec_before  ⊑  srem_constant_dividend_select_of_constants_divisor_vec_combined := by
  unfold srem_constant_dividend_select_of_constants_divisor_vec_before srem_constant_dividend_select_of_constants_divisor_vec_combined
  simp_alive_peephole
  sorry
def srem_constant_dividend_select_of_constants_divisor_vec_ub1_combined := [llvmfunc|
  llvm.func @srem_constant_dividend_select_of_constants_divisor_vec_ub1(%arg0: i1) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[2, -2]> : vector<2xi8>) : vector<2xi8>
    llvm.return %0 : vector<2xi8>
  }]

theorem inst_combine_srem_constant_dividend_select_of_constants_divisor_vec_ub1   : srem_constant_dividend_select_of_constants_divisor_vec_ub1_before  ⊑  srem_constant_dividend_select_of_constants_divisor_vec_ub1_combined := by
  unfold srem_constant_dividend_select_of_constants_divisor_vec_ub1_before srem_constant_dividend_select_of_constants_divisor_vec_ub1_combined
  simp_alive_peephole
  sorry
def srem_constant_dividend_select_of_constants_divisor_vec_ub2_combined := [llvmfunc|
  llvm.func @srem_constant_dividend_select_of_constants_divisor_vec_ub2(%arg0: i1) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[6, -3]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.constant(2 : i8) : i8
    %3 = llvm.mlir.undef : vector<2xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi8>
    %8 = llvm.select %arg0, %0, %7 : i1, vector<2xi8>
    llvm.return %8 : vector<2xi8>
  }]

theorem inst_combine_srem_constant_dividend_select_of_constants_divisor_vec_ub2   : srem_constant_dividend_select_of_constants_divisor_vec_ub2_before  ⊑  srem_constant_dividend_select_of_constants_divisor_vec_ub2_combined := by
  unfold srem_constant_dividend_select_of_constants_divisor_vec_ub2_before srem_constant_dividend_select_of_constants_divisor_vec_ub2_combined
  simp_alive_peephole
  sorry
def srem_select_of_constants_divisor_combined := [llvmfunc|
  llvm.func @srem_select_of_constants_divisor(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(-3 : i32) : i32
    %2 = llvm.select %arg0, %0, %1 : i1, i32
    %3 = llvm.srem %arg1, %2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_srem_select_of_constants_divisor   : srem_select_of_constants_divisor_before  ⊑  srem_select_of_constants_divisor_combined := by
  unfold srem_select_of_constants_divisor_before srem_select_of_constants_divisor_combined
  simp_alive_peephole
  sorry
def urem_constant_dividend_select_of_constants_divisor_combined := [llvmfunc|
  llvm.func @urem_constant_dividend_select_of_constants_divisor(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.select %arg0, %0, %1 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_urem_constant_dividend_select_of_constants_divisor   : urem_constant_dividend_select_of_constants_divisor_before  ⊑  urem_constant_dividend_select_of_constants_divisor_combined := by
  unfold urem_constant_dividend_select_of_constants_divisor_before urem_constant_dividend_select_of_constants_divisor_combined
  simp_alive_peephole
  sorry
def urem_constant_dividend_select_of_constants_divisor_use_combined := [llvmfunc|
  llvm.func @urem_constant_dividend_select_of_constants_divisor_use(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(-3 : i32) : i32
    %2 = llvm.mlir.constant(6 : i32) : i32
    %3 = llvm.mlir.constant(42 : i32) : i32
    %4 = llvm.select %arg0, %0, %1 : i1, i32
    llvm.call @use(%4) : (i32) -> ()
    %5 = llvm.select %arg0, %2, %3 : i1, i32
    llvm.return %5 : i32
  }]

theorem inst_combine_urem_constant_dividend_select_of_constants_divisor_use   : urem_constant_dividend_select_of_constants_divisor_use_before  ⊑  urem_constant_dividend_select_of_constants_divisor_use_combined := by
  unfold urem_constant_dividend_select_of_constants_divisor_use_before urem_constant_dividend_select_of_constants_divisor_use_combined
  simp_alive_peephole
  sorry
def urem_constant_dividend_select_of_constants_divisor_0_arm_combined := [llvmfunc|
  llvm.func @urem_constant_dividend_select_of_constants_divisor_0_arm(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_urem_constant_dividend_select_of_constants_divisor_0_arm   : urem_constant_dividend_select_of_constants_divisor_0_arm_before  ⊑  urem_constant_dividend_select_of_constants_divisor_0_arm_combined := by
  unfold urem_constant_dividend_select_of_constants_divisor_0_arm_before urem_constant_dividend_select_of_constants_divisor_0_arm_combined
  simp_alive_peephole
  sorry
def urem_constant_dividend_select_divisor1_combined := [llvmfunc|
  llvm.func @urem_constant_dividend_select_divisor1(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-3 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.select %arg0, %arg1, %0 : i1, i32
    %3 = llvm.urem %1, %2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_urem_constant_dividend_select_divisor1   : urem_constant_dividend_select_divisor1_before  ⊑  urem_constant_dividend_select_divisor1_combined := by
  unfold urem_constant_dividend_select_divisor1_before urem_constant_dividend_select_divisor1_combined
  simp_alive_peephole
  sorry
def urem_constant_dividend_select_divisor2_combined := [llvmfunc|
  llvm.func @urem_constant_dividend_select_divisor2(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.select %arg0, %0, %arg1 : i1, i32
    %3 = llvm.urem %1, %2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_urem_constant_dividend_select_divisor2   : urem_constant_dividend_select_divisor2_before  ⊑  urem_constant_dividend_select_divisor2_combined := by
  unfold urem_constant_dividend_select_divisor2_before urem_constant_dividend_select_divisor2_combined
  simp_alive_peephole
  sorry
def urem_constant_dividend_select_of_constants_divisor_vec_combined := [llvmfunc|
  llvm.func @urem_constant_dividend_select_of_constants_divisor_vec(%arg0: i1) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[6, -42]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[42, 2]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.select %arg0, %0, %1 : i1, vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

theorem inst_combine_urem_constant_dividend_select_of_constants_divisor_vec   : urem_constant_dividend_select_of_constants_divisor_vec_before  ⊑  urem_constant_dividend_select_of_constants_divisor_vec_combined := by
  unfold urem_constant_dividend_select_of_constants_divisor_vec_before urem_constant_dividend_select_of_constants_divisor_vec_combined
  simp_alive_peephole
  sorry
def urem_constant_dividend_select_of_constants_divisor_vec_ub1_combined := [llvmfunc|
  llvm.func @urem_constant_dividend_select_of_constants_divisor_vec_ub1(%arg0: i1) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[42, 2]> : vector<2xi8>) : vector<2xi8>
    llvm.return %0 : vector<2xi8>
  }]

theorem inst_combine_urem_constant_dividend_select_of_constants_divisor_vec_ub1   : urem_constant_dividend_select_of_constants_divisor_vec_ub1_before  ⊑  urem_constant_dividend_select_of_constants_divisor_vec_ub1_combined := by
  unfold urem_constant_dividend_select_of_constants_divisor_vec_ub1_before urem_constant_dividend_select_of_constants_divisor_vec_ub1_combined
  simp_alive_peephole
  sorry
def urem_constant_dividend_select_of_constants_divisor_vec_ub2_combined := [llvmfunc|
  llvm.func @urem_constant_dividend_select_of_constants_divisor_vec_ub2(%arg0: i1) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[6, -128]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[42, -128]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.select %arg0, %0, %1 : i1, vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

theorem inst_combine_urem_constant_dividend_select_of_constants_divisor_vec_ub2   : urem_constant_dividend_select_of_constants_divisor_vec_ub2_before  ⊑  urem_constant_dividend_select_of_constants_divisor_vec_ub2_combined := by
  unfold urem_constant_dividend_select_of_constants_divisor_vec_ub2_before urem_constant_dividend_select_of_constants_divisor_vec_ub2_combined
  simp_alive_peephole
  sorry
def urem_select_of_constants_divisor_combined := [llvmfunc|
  llvm.func @urem_select_of_constants_divisor(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(-3 : i32) : i32
    %2 = llvm.select %arg0, %0, %1 : i1, i32
    %3 = llvm.urem %arg1, %2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_urem_select_of_constants_divisor   : urem_select_of_constants_divisor_before  ⊑  urem_select_of_constants_divisor_combined := by
  unfold urem_select_of_constants_divisor_before urem_select_of_constants_divisor_combined
  simp_alive_peephole
  sorry
def PR62401_combined := [llvmfunc|
  llvm.func @PR62401(%arg0: vector<2xi1>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.freeze %arg1 : vector<2xi32>
    %4 = llvm.icmp "eq" %3, %0 : vector<2xi32>
    %5 = llvm.select %4, %2, %3 : vector<2xi1>, vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

theorem inst_combine_PR62401   : PR62401_before  ⊑  PR62401_combined := by
  unfold PR62401_before PR62401_combined
  simp_alive_peephole
  sorry
