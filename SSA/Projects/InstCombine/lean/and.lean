import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  and
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_with_1_before := [llvmfunc|
  llvm.func @test_with_1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %0, %arg0  : i32
    %2 = llvm.and %1, %0  : i32
    llvm.return %2 : i32
  }]

def test_with_3_before := [llvmfunc|
  llvm.func @test_with_3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.shl %0, %arg0  : i32
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }]

def test_with_5_before := [llvmfunc|
  llvm.func @test_with_5(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.shl %0, %arg0  : i32
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }]

def test_with_neg_5_before := [llvmfunc|
  llvm.func @test_with_neg_5(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-5 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.shl %0, %arg0  : i32
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }]

def test_with_even_before := [llvmfunc|
  llvm.func @test_with_even(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.shl %0, %arg0  : i32
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }]

def test_vec_before := [llvmfunc|
  llvm.func @test_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.shl %0, %arg0  : vector<2xi32>
    %3 = llvm.and %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def test_with_neg_even_before := [llvmfunc|
  llvm.func @test_with_neg_even(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-4 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.shl %0, %arg0  : i32
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }]

def test_with_more_one_use_before := [llvmfunc|
  llvm.func @test_with_more_one_use(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.shl %0, %arg0  : i32
    %3 = llvm.and %2, %1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    llvm.return %3 : i32
  }]

def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    llvm.return %1 : i32
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    llvm.return %1 : i32
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.and %arg0, %0  : i1
    llvm.return %1 : i1
  }]

def test3_logical_before := [llvmfunc|
  llvm.func @test3_logical(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg0, %0, %0 : i1, i1
    llvm.return %1 : i1
  }]

def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.and %arg0, %0  : i1
    llvm.return %1 : i1
  }]

def test4_logical_before := [llvmfunc|
  llvm.func @test4_logical(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }]

def test5_before := [llvmfunc|
  llvm.func @test5(%arg0: i32) -> i32 {
    %0 = llvm.and %arg0, %arg0  : i32
    llvm.return %0 : i32
  }]

def test6_before := [llvmfunc|
  llvm.func @test6(%arg0: i1) -> i1 {
    %0 = llvm.and %arg0, %arg0  : i1
    llvm.return %0 : i1
  }]

def test6_logical_before := [llvmfunc|
  llvm.func @test6_logical(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg0, %arg0, %0 : i1, i1
    llvm.return %1 : i1
  }]

def test7_before := [llvmfunc|
  llvm.func @test7(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.and %arg0, %1  : i32
    llvm.return %2 : i32
  }]

def test8_before := [llvmfunc|
  llvm.func @test8(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.and %2, %1  : i8
    llvm.return %3 : i8
  }]

def test9_before := [llvmfunc|
  llvm.func @test9(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

def test9a_before := [llvmfunc|
  llvm.func @test9a(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

def test10_before := [llvmfunc|
  llvm.func @test10(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.and %4, %2  : i32
    llvm.return %5 : i32
  }]

def test11_before := [llvmfunc|
  llvm.func @test11(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.xor %2, %1  : i32
    llvm.store %3, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

    %4 = llvm.and %3, %0  : i32
    llvm.return %4 : i32
  }]

def test12_before := [llvmfunc|
  llvm.func @test12(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i32
    %1 = llvm.icmp "ule" %arg0, %arg1 : i32
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }]

def test12_logical_before := [llvmfunc|
  llvm.func @test12_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.icmp "ult" %arg0, %arg1 : i32
    %2 = llvm.icmp "ule" %arg0, %arg1 : i32
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }]

def test13_before := [llvmfunc|
  llvm.func @test13(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i32
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }]

def test13_logical_before := [llvmfunc|
  llvm.func @test13_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.icmp "ult" %arg0, %arg1 : i32
    %2 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }]

def test14_before := [llvmfunc|
  llvm.func @test14(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }]

def test15_before := [llvmfunc|
  llvm.func @test15(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.and %2, %1  : i8
    llvm.return %3 : i8
  }]

def test16_before := [llvmfunc|
  llvm.func @test16(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.and %2, %1  : i8
    llvm.return %3 : i8
  }]

def test18_before := [llvmfunc|
  llvm.func @test18(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-128 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

def test18_vec_before := [llvmfunc|
  llvm.func @test18_vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-128> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.and %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "ne" %3, %2 : vector<2xi32>
    llvm.return %4 : vector<2xi1>
  }]

def test18a_before := [llvmfunc|
  llvm.func @test18a(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

def test18a_vec_before := [llvmfunc|
  llvm.func @test18a_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-2> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.and %arg0, %0  : vector<2xi8>
    %4 = llvm.icmp "eq" %3, %2 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }]

def test19_before := [llvmfunc|
  llvm.func @test19(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }]

def test20_before := [llvmfunc|
  llvm.func @test20(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.and %2, %1  : i8
    llvm.return %3 : i8
  }]

def test23_before := [llvmfunc|
  llvm.func @test23(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.icmp "sle" %arg0, %1 : i32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

def test23_logical_before := [llvmfunc|
  llvm.func @test23_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.icmp "sle" %arg0, %1 : i32
    %5 = llvm.select %3, %4, %2 : i1, i1
    llvm.return %5 : i1
  }]

def test23vec_before := [llvmfunc|
  llvm.func @test23vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "sgt" %arg0, %0 : vector<2xi32>
    %3 = llvm.icmp "sle" %arg0, %1 : vector<2xi32>
    %4 = llvm.and %2, %3  : vector<2xi1>
    llvm.return %4 : vector<2xi1>
  }]

def test24_before := [llvmfunc|
  llvm.func @test24(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.icmp "ne" %arg0, %1 : i32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

def test24_logical_before := [llvmfunc|
  llvm.func @test24_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.icmp "ne" %arg0, %1 : i32
    %5 = llvm.select %3, %4, %2 : i1, i1
    llvm.return %5 : i1
  }]

def test25_before := [llvmfunc|
  llvm.func @test25(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(50 : i32) : i32
    %1 = llvm.mlir.constant(100 : i32) : i32
    %2 = llvm.icmp "sge" %arg0, %0 : i32
    %3 = llvm.icmp "slt" %arg0, %1 : i32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

def test25_logical_before := [llvmfunc|
  llvm.func @test25_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(50 : i32) : i32
    %1 = llvm.mlir.constant(100 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "sge" %arg0, %0 : i32
    %4 = llvm.icmp "slt" %arg0, %1 : i32
    %5 = llvm.select %3, %4, %2 : i1, i1
    llvm.return %5 : i1
  }]

def test25vec_before := [llvmfunc|
  llvm.func @test25vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<50> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<100> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "sge" %arg0, %0 : vector<2xi32>
    %3 = llvm.icmp "slt" %arg0, %1 : vector<2xi32>
    %4 = llvm.and %2, %3  : vector<2xi1>
    llvm.return %4 : vector<2xi1>
  }]

def test27_before := [llvmfunc|
  llvm.func @test27(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.mlir.constant(16 : i8) : i8
    %2 = llvm.mlir.constant(-16 : i8) : i8
    %3 = llvm.and %arg0, %0  : i8
    %4 = llvm.sub %3, %1  : i8
    %5 = llvm.and %4, %2  : i8
    %6 = llvm.add %5, %1  : i8
    llvm.return %6 : i8
  }]

def ashr_lowmask_before := [llvmfunc|
  llvm.func @ashr_lowmask(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(255 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }]

def ashr_lowmask_use_before := [llvmfunc|
  llvm.func @ashr_lowmask_use(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2147483647 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }]

def ashr_lowmask_use_splat_before := [llvmfunc|
  llvm.func @ashr_lowmask_use_splat(%arg0: vector<2xi8>, %arg1: !llvm.ptr) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.ashr %arg0, %0  : vector<2xi8>
    llvm.store %2, %arg1 {alignment = 2 : i64} : vector<2xi8>, !llvm.ptr]

    %3 = llvm.and %2, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def ashr_not_lowmask1_use_before := [llvmfunc|
  llvm.func @ashr_not_lowmask1_use(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(254 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }]

def ashr_not_lowmask2_use_before := [llvmfunc|
  llvm.func @ashr_not_lowmask2_use(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(127 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }]

def ashr_not_lowmask3_use_before := [llvmfunc|
  llvm.func @ashr_not_lowmask3_use(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(511 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }]

def test29_before := [llvmfunc|
  llvm.func @test29(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.and %1, %0  : i32
    llvm.return %2 : i32
  }]

def test30_before := [llvmfunc|
  llvm.func @test30(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.and %1, %0  : i32
    llvm.return %2 : i32
  }]

def test31_before := [llvmfunc|
  llvm.func @test31(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.zext %arg0 : i1 to i32
    %3 = llvm.shl %2, %0  : i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }]

def and_demanded_bits_splat_vec_before := [llvmfunc|
  llvm.func @and_demanded_bits_splat_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<7> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %arg0, %0  : vector<2xi32>
    %3 = llvm.and %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def and_zext_demanded_before := [llvmfunc|
  llvm.func @and_zext_demanded(%arg0: i16, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.mlir.constant(255 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i16
    %3 = llvm.zext %2 : i16 to i32
    %4 = llvm.or %arg1, %1  : i32
    %5 = llvm.and %4, %3  : i32
    llvm.return %5 : i32
  }]

def test32_before := [llvmfunc|
  llvm.func @test32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.lshr %3, %1  : i32
    %5 = llvm.and %4, %2  : i32
    llvm.return %5 : i32
  }]

def test33_before := [llvmfunc|
  llvm.func @test33(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.and %arg0, %1  : i32
    %5 = llvm.or %4, %3  : i32
    llvm.return %5 : i32
  }]

def test33b_before := [llvmfunc|
  llvm.func @test33b(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.and %arg0, %1  : i32
    %5 = llvm.or %3, %4  : i32
    llvm.return %5 : i32
  }]

def test33vec_before := [llvmfunc|
  llvm.func @test33vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-2> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.and %arg0, %0  : vector<2xi32>
    %3 = llvm.xor %2, %0  : vector<2xi32>
    %4 = llvm.and %arg0, %1  : vector<2xi32>
    %5 = llvm.or %4, %3  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

def test33vecb_before := [llvmfunc|
  llvm.func @test33vecb(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-2> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.and %arg0, %0  : vector<2xi32>
    %3 = llvm.xor %2, %0  : vector<2xi32>
    %4 = llvm.and %arg0, %1  : vector<2xi32>
    %5 = llvm.or %3, %4  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

def test34_before := [llvmfunc|
  llvm.func @test34(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.or %arg1, %arg0  : i32
    %1 = llvm.and %0, %arg1  : i32
    llvm.return %1 : i32
  }]

def PR24942_before := [llvmfunc|
  llvm.func @PR24942(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<31> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.lshr %arg0, %0  : vector<2xi32>
    %3 = llvm.and %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def test35_before := [llvmfunc|
  llvm.func @test35(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(240 : i64) : i64
    %2 = llvm.zext %arg0 : i32 to i64
    %3 = llvm.sub %0, %2  : i64
    %4 = llvm.and %3, %1  : i64
    llvm.return %4 : i64
  }]

def test35_uniform_before := [llvmfunc|
  llvm.func @test35_uniform(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.mlir.constant(dense<240> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.zext %arg0 : vector<2xi32> to vector<2xi64>
    %4 = llvm.sub %1, %3  : vector<2xi64>
    %5 = llvm.and %4, %2  : vector<2xi64>
    llvm.return %5 : vector<2xi64>
  }]

def test36_before := [llvmfunc|
  llvm.func @test36(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(7 : i64) : i64
    %1 = llvm.mlir.constant(240 : i64) : i64
    %2 = llvm.zext %arg0 : i32 to i64
    %3 = llvm.add %2, %0  : i64
    %4 = llvm.and %3, %1  : i64
    llvm.return %4 : i64
  }]

def test36_uniform_before := [llvmfunc|
  llvm.func @test36_uniform(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<240> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.zext %arg0 : vector<2xi32> to vector<2xi64>
    %3 = llvm.add %2, %0  : vector<2xi64>
    %4 = llvm.and %3, %1  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

def test36_poison_before := [llvmfunc|
  llvm.func @test36_poison(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.poison : i64
    %1 = llvm.mlir.constant(7 : i64) : i64
    %2 = llvm.mlir.undef : vector<2xi64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi64>
    %7 = llvm.mlir.constant(240 : i64) : i64
    %8 = llvm.mlir.undef : vector<2xi64>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %7, %8[%9 : i32] : vector<2xi64>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<2xi64>
    %13 = llvm.zext %arg0 : vector<2xi32> to vector<2xi64>
    %14 = llvm.add %13, %6  : vector<2xi64>
    %15 = llvm.and %14, %12  : vector<2xi64>
    llvm.return %15 : vector<2xi64>
  }]

def test37_before := [llvmfunc|
  llvm.func @test37(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(7 : i64) : i64
    %1 = llvm.mlir.constant(240 : i64) : i64
    %2 = llvm.zext %arg0 : i32 to i64
    %3 = llvm.mul %2, %0  : i64
    %4 = llvm.and %3, %1  : i64
    llvm.return %4 : i64
  }]

def test37_uniform_before := [llvmfunc|
  llvm.func @test37_uniform(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<240> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.zext %arg0 : vector<2xi32> to vector<2xi64>
    %3 = llvm.mul %2, %0  : vector<2xi64>
    %4 = llvm.and %3, %1  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

def test37_nonuniform_before := [llvmfunc|
  llvm.func @test37_nonuniform(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[7, 9]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<[240, 110]> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.zext %arg0 : vector<2xi32> to vector<2xi64>
    %3 = llvm.mul %2, %0  : vector<2xi64>
    %4 = llvm.and %3, %1  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

def test38_before := [llvmfunc|
  llvm.func @test38(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(7 : i64) : i64
    %1 = llvm.mlir.constant(240 : i64) : i64
    %2 = llvm.zext %arg0 : i32 to i64
    %3 = llvm.xor %2, %0  : i64
    %4 = llvm.and %3, %1  : i64
    llvm.return %4 : i64
  }]

def test39_before := [llvmfunc|
  llvm.func @test39(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(7 : i64) : i64
    %1 = llvm.mlir.constant(240 : i64) : i64
    %2 = llvm.zext %arg0 : i32 to i64
    %3 = llvm.or %2, %0  : i64
    %4 = llvm.and %3, %1  : i64
    llvm.return %4 : i64
  }]

def lowmask_add_zext_before := [llvmfunc|
  llvm.func @lowmask_add_zext(%arg0: i8, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.add %1, %arg1  : i32
    %3 = llvm.and %2, %0  : i32
    llvm.return %3 : i32
  }]

def lowmask_add_zext_commute_before := [llvmfunc|
  llvm.func @lowmask_add_zext_commute(%arg0: i16, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65535 : i32) : i32
    %1 = llvm.mul %arg1, %arg1  : i32
    %2 = llvm.zext %arg0 : i16 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.and %3, %0  : i32
    llvm.return %4 : i32
  }]

def lowmask_add_zext_wrong_mask_before := [llvmfunc|
  llvm.func @lowmask_add_zext_wrong_mask(%arg0: i8, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(511 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.add %1, %arg1  : i32
    %3 = llvm.and %2, %0  : i32
    llvm.return %3 : i32
  }]

def lowmask_add_zext_use1_before := [llvmfunc|
  llvm.func @lowmask_add_zext_use1(%arg0: i8, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.add %1, %arg1  : i32
    %3 = llvm.and %2, %0  : i32
    llvm.return %3 : i32
  }]

def lowmask_add_zext_use2_before := [llvmfunc|
  llvm.func @lowmask_add_zext_use2(%arg0: i8, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.add %1, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.and %2, %0  : i32
    llvm.return %3 : i32
  }]

def lowmask_sub_zext_before := [llvmfunc|
  llvm.func @lowmask_sub_zext(%arg0: vector<2xi4>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<15> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.zext %arg0 : vector<2xi4> to vector<2xi32>
    %2 = llvm.sub %1, %arg1  : vector<2xi32>
    %3 = llvm.and %2, %0  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def lowmask_sub_zext_commute_before := [llvmfunc|
  llvm.func @lowmask_sub_zext_commute(%arg0: i5, %arg1: i17) -> i17 {
    %0 = llvm.mlir.constant(31 : i17) : i17
    %1 = llvm.zext %arg0 : i5 to i17
    %2 = llvm.sub %arg1, %1  : i17
    %3 = llvm.and %2, %0  : i17
    llvm.return %3 : i17
  }]

def lowmask_mul_zext_before := [llvmfunc|
  llvm.func @lowmask_mul_zext(%arg0: i8, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.mul %1, %arg1  : i32
    %3 = llvm.and %2, %0  : i32
    llvm.return %3 : i32
  }]

def lowmask_xor_zext_commute_before := [llvmfunc|
  llvm.func @lowmask_xor_zext_commute(%arg0: i8, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mul %arg1, %arg1  : i32
    %2 = llvm.zext %arg0 : i8 to i32
    %3 = llvm.xor %1, %2  : i32
    %4 = llvm.and %3, %0  : i32
    llvm.return %4 : i32
  }]

def lowmask_or_zext_commute_before := [llvmfunc|
  llvm.func @lowmask_or_zext_commute(%arg0: i16, %arg1: i24) -> i24 {
    %0 = llvm.mlir.constant(65535 : i24) : i24
    %1 = llvm.zext %arg0 : i16 to i24
    %2 = llvm.or %arg1, %1  : i24
    %3 = llvm.and %2, %0  : i24
    llvm.return %3 : i24
  }]

def test40_before := [llvmfunc|
  llvm.func @test40(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1000 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.mlir.constant(123 : i32) : i32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    %4 = llvm.and %3, %2  : i32
    llvm.return %4 : i32
  }]

def test40vec_before := [llvmfunc|
  llvm.func @test40vec(%arg0: i1) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1000> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<10> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<123> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.select %arg0, %0, %1 : i1, vector<2xi32>
    %4 = llvm.and %3, %2  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def test40vec2_before := [llvmfunc|
  llvm.func @test40vec2(%arg0: i1) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[1000, 2500]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[10, 30]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<[123, 333]> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.select %arg0, %0, %1 : i1, vector<2xi32>
    %4 = llvm.and %3, %2  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def test41_before := [llvmfunc|
  llvm.func @test41(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1000 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.mlir.constant(123 : i32) : i32
    llvm.cond_br %arg0, ^bb2(%0 : i32), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%1 : i32)
  ^bb2(%3: i32):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.and %3, %2  : i32
    llvm.return %4 : i32
  }]

def test41vec_before := [llvmfunc|
  llvm.func @test41vec(%arg0: i1) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1000> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<10> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<123> : vector<2xi32>) : vector<2xi32>
    llvm.cond_br %arg0, ^bb2(%0 : vector<2xi32>), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%1 : vector<2xi32>)
  ^bb2(%3: vector<2xi32>):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.and %3, %2  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def test41vec2_before := [llvmfunc|
  llvm.func @test41vec2(%arg0: i1) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[1000, 2500]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[10, 30]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<[123, 333]> : vector<2xi32>) : vector<2xi32>
    llvm.cond_br %arg0, ^bb2(%0 : vector<2xi32>), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%1 : vector<2xi32>)
  ^bb2(%3: vector<2xi32>):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.and %3, %2  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def test42_before := [llvmfunc|
  llvm.func @test42(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mul %arg1, %arg2  : i32
    %2 = llvm.or %arg0, %1  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.and %4, %2  : i32
    llvm.return %5 : i32
  }]

def test43_before := [llvmfunc|
  llvm.func @test43(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mul %arg1, %arg2  : i32
    %2 = llvm.or %arg0, %1  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.and %2, %4  : i32
    llvm.return %5 : i32
  }]

def test44_before := [llvmfunc|
  llvm.func @test44(%arg0: i32, %arg1: i32) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.or %1, %arg0  : i32
    %3 = llvm.and %2, %arg1  : i32
    llvm.return %3 : i32
  }]

def test45_before := [llvmfunc|
  llvm.func @test45(%arg0: i32, %arg1: i32) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.or %arg0, %1  : i32
    %3 = llvm.and %2, %arg1  : i32
    llvm.return %3 : i32
  }]

def test46_before := [llvmfunc|
  llvm.func @test46(%arg0: i32, %arg1: i32) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.or %1, %arg0  : i32
    %3 = llvm.and %arg1, %2  : i32
    llvm.return %3 : i32
  }]

def test47_before := [llvmfunc|
  llvm.func @test47(%arg0: i32, %arg1: i32) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.or %arg0, %1  : i32
    %3 = llvm.and %arg1, %2  : i32
    llvm.return %3 : i32
  }]

def and_orn_cmp_1_before := [llvmfunc|
  llvm.func @and_orn_cmp_1(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i32
    %2 = llvm.icmp "sle" %arg0, %arg1 : i32
    %3 = llvm.icmp "ugt" %arg2, %0 : i32
    %4 = llvm.or %3, %2  : i1
    %5 = llvm.and %1, %4  : i1
    llvm.return %5 : i1
  }]

def and_orn_cmp_1_logical_before := [llvmfunc|
  llvm.func @and_orn_cmp_1_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "sgt" %arg0, %arg1 : i32
    %4 = llvm.icmp "sle" %arg0, %arg1 : i32
    %5 = llvm.icmp "ugt" %arg2, %0 : i32
    %6 = llvm.select %5, %1, %4 : i1, i1
    %7 = llvm.select %3, %6, %2 : i1, i1
    llvm.return %7 : i1
  }]

def and_orn_cmp_2_before := [llvmfunc|
  llvm.func @and_orn_cmp_2(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[42, 47]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "sge" %arg0, %arg1 : vector<2xi32>
    %2 = llvm.icmp "slt" %arg0, %arg1 : vector<2xi32>
    %3 = llvm.icmp "ugt" %arg2, %0 : vector<2xi32>
    %4 = llvm.or %3, %2  : vector<2xi1>
    %5 = llvm.and %4, %1  : vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }]

def and_orn_cmp_3_before := [llvmfunc|
  llvm.func @and_orn_cmp_3(%arg0: i72, %arg1: i72, %arg2: i72) -> i1 {
    %0 = llvm.mlir.constant(42 : i72) : i72
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i72
    %2 = llvm.icmp "ule" %arg0, %arg1 : i72
    %3 = llvm.icmp "ugt" %arg2, %0 : i72
    %4 = llvm.or %2, %3  : i1
    %5 = llvm.and %1, %4  : i1
    llvm.return %5 : i1
  }]

def and_orn_cmp_3_logical_before := [llvmfunc|
  llvm.func @and_orn_cmp_3_logical(%arg0: i72, %arg1: i72, %arg2: i72) -> i1 {
    %0 = llvm.mlir.constant(42 : i72) : i72
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "ugt" %arg0, %arg1 : i72
    %4 = llvm.icmp "ule" %arg0, %arg1 : i72
    %5 = llvm.icmp "ugt" %arg2, %0 : i72
    %6 = llvm.select %4, %1, %5 : i1, i1
    %7 = llvm.select %3, %6, %2 : i1, i1
    llvm.return %7 : i1
  }]

def or_andn_cmp_4_before := [llvmfunc|
  llvm.func @or_andn_cmp_4(%arg0: vector<3xi32>, %arg1: vector<3xi32>, %arg2: vector<3xi32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(dense<[42, 43, -1]> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.icmp "eq" %arg0, %arg1 : vector<3xi32>
    %2 = llvm.icmp "ne" %arg0, %arg1 : vector<3xi32>
    %3 = llvm.icmp "ugt" %arg2, %0 : vector<3xi32>
    %4 = llvm.or %2, %3  : vector<3xi1>
    %5 = llvm.and %4, %1  : vector<3xi1>
    llvm.return %5 : vector<3xi1>
  }]

def andn_or_cmp_1_before := [llvmfunc|
  llvm.func @andn_or_cmp_1(%arg0: i37, %arg1: i37, %arg2: i37) -> i1 {
    %0 = llvm.mlir.constant(42 : i37) : i37
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i37
    %2 = llvm.icmp "sle" %arg0, %arg1 : i37
    %3 = llvm.icmp "ugt" %arg2, %0 : i37
    %4 = llvm.or %3, %1  : i1
    %5 = llvm.and %2, %4  : i1
    llvm.return %5 : i1
  }]

def andn_or_cmp_1_logical_before := [llvmfunc|
  llvm.func @andn_or_cmp_1_logical(%arg0: i37, %arg1: i37, %arg2: i37) -> i1 {
    %0 = llvm.mlir.constant(42 : i37) : i37
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "sgt" %arg0, %arg1 : i37
    %4 = llvm.icmp "sle" %arg0, %arg1 : i37
    %5 = llvm.icmp "ugt" %arg2, %0 : i37
    %6 = llvm.select %5, %1, %3 : i1, i1
    %7 = llvm.select %4, %6, %2 : i1, i1
    llvm.return %7 : i1
  }]

def andn_or_cmp_2_before := [llvmfunc|
  llvm.func @andn_or_cmp_2(%arg0: i16, %arg1: i16, %arg2: i16) -> i1 {
    %0 = llvm.mlir.constant(42 : i16) : i16
    %1 = llvm.icmp "sge" %arg0, %arg1 : i16
    %2 = llvm.icmp "slt" %arg0, %arg1 : i16
    %3 = llvm.icmp "ugt" %arg2, %0 : i16
    %4 = llvm.or %3, %1  : i1
    %5 = llvm.and %4, %2  : i1
    llvm.return %5 : i1
  }]

def andn_or_cmp_2_logical_before := [llvmfunc|
  llvm.func @andn_or_cmp_2_logical(%arg0: i16, %arg1: i16, %arg2: i16) -> i1 {
    %0 = llvm.mlir.constant(42 : i16) : i16
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "sge" %arg0, %arg1 : i16
    %4 = llvm.icmp "slt" %arg0, %arg1 : i16
    %5 = llvm.icmp "ugt" %arg2, %0 : i16
    %6 = llvm.select %5, %1, %3 : i1, i1
    %7 = llvm.select %6, %4, %2 : i1, i1
    llvm.return %7 : i1
  }]

def andn_or_cmp_3_before := [llvmfunc|
  llvm.func @andn_or_cmp_3(%arg0: vector<4xi32>, %arg1: vector<4xi32>, %arg2: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<[42, 0, 1, -1]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.icmp "ugt" %arg0, %arg1 : vector<4xi32>
    %2 = llvm.icmp "ule" %arg0, %arg1 : vector<4xi32>
    %3 = llvm.icmp "ugt" %arg2, %0 : vector<4xi32>
    %4 = llvm.or %1, %3  : vector<4xi1>
    %5 = llvm.and %2, %4  : vector<4xi1>
    llvm.return %5 : vector<4xi1>
  }]

def andn_or_cmp_4_before := [llvmfunc|
  llvm.func @andn_or_cmp_4(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %arg1 : i32
    %2 = llvm.icmp "ne" %arg0, %arg1 : i32
    %3 = llvm.icmp "ugt" %arg2, %0 : i32
    %4 = llvm.or %1, %3  : i1
    %5 = llvm.and %4, %2  : i1
    llvm.return %5 : i1
  }]

def andn_or_cmp_4_logical_before := [llvmfunc|
  llvm.func @andn_or_cmp_4_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "eq" %arg0, %arg1 : i32
    %4 = llvm.icmp "ne" %arg0, %arg1 : i32
    %5 = llvm.icmp "ugt" %arg2, %0 : i32
    %6 = llvm.select %3, %1, %5 : i1, i1
    %7 = llvm.select %6, %4, %2 : i1, i1
    llvm.return %7 : i1
  }]

def lowbitmask_casted_shift_before := [llvmfunc|
  llvm.func @lowbitmask_casted_shift(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(2147483647 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.sext %2 : i8 to i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }]

def lowbitmask_casted_shift_wrong_mask1_before := [llvmfunc|
  llvm.func @lowbitmask_casted_shift_wrong_mask1(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(2147483647 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.sext %2 : i8 to i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }]

def lowbitmask_casted_shift_wrong_mask2_before := [llvmfunc|
  llvm.func @lowbitmask_casted_shift_wrong_mask2(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(536870911 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.sext %2 : i8 to i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }]

def lowbitmask_casted_shift_use1_before := [llvmfunc|
  llvm.func @lowbitmask_casted_shift_use1(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(536870911 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sext %2 : i8 to i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }]

def lowbitmask_casted_shift_use2_before := [llvmfunc|
  llvm.func @lowbitmask_casted_shift_use2(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(536870911 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.sext %2 : i8 to i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }]

def lowbitmask_casted_shift_vec_splat_before := [llvmfunc|
  llvm.func @lowbitmask_casted_shift_vec_splat(%arg0: vector<2xi47>) -> vector<2xi59> {
    %0 = llvm.mlir.constant(5 : i47) : i47
    %1 = llvm.mlir.constant(dense<5> : vector<2xi47>) : vector<2xi47>
    %2 = llvm.mlir.constant(18014398509481983 : i59) : i59
    %3 = llvm.mlir.constant(dense<18014398509481983> : vector<2xi59>) : vector<2xi59>
    %4 = llvm.ashr %arg0, %1  : vector<2xi47>
    %5 = llvm.sext %4 : vector<2xi47> to vector<2xi59>
    %6 = llvm.and %5, %3  : vector<2xi59>
    llvm.return %6 : vector<2xi59>
  }]

def lowmask_sext_in_reg_before := [llvmfunc|
  llvm.func @lowmask_sext_in_reg(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(20 : i32) : i32
    %1 = llvm.mlir.constant(4095 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.ashr %2, %0  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }]

def lowmask_not_sext_in_reg_before := [llvmfunc|
  llvm.func @lowmask_not_sext_in_reg(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(19 : i32) : i32
    %1 = llvm.mlir.constant(20 : i32) : i32
    %2 = llvm.mlir.constant(4095 : i32) : i32
    %3 = llvm.shl %arg0, %0  : i32
    %4 = llvm.ashr %3, %1  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.and %4, %2  : i32
    llvm.return %5 : i32
  }]

def not_lowmask_sext_in_reg_before := [llvmfunc|
  llvm.func @not_lowmask_sext_in_reg(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(20 : i32) : i32
    %1 = llvm.mlir.constant(4096 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.ashr %2, %0  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }]

def not_lowmask_sext_in_reg2_before := [llvmfunc|
  llvm.func @not_lowmask_sext_in_reg2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(21 : i32) : i32
    %1 = llvm.mlir.constant(4095 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.ashr %2, %0  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }]

def lowmask_sext_in_reg_splat_before := [llvmfunc|
  llvm.func @lowmask_sext_in_reg_splat(%arg0: vector<2xi32>, %arg1: !llvm.ptr) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<20> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<4095> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.shl %arg0, %0  : vector<2xi32>
    %3 = llvm.ashr %2, %0  : vector<2xi32>
    llvm.store %3, %arg1 {alignment = 8 : i64} : vector<2xi32>, !llvm.ptr]

    %4 = llvm.and %3, %1  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def lowmask_add_before := [llvmfunc|
  llvm.func @lowmask_add(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-64 : i8) : i8
    %1 = llvm.mlir.constant(32 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.and %2, %1  : i8
    llvm.return %3 : i8
  }]

def lowmask_add_2_before := [llvmfunc|
  llvm.func @lowmask_add_2(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-64 : i8) : i8
    %1 = llvm.mlir.constant(63 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.and %2, %1  : i8
    llvm.return %3 : i8
  }]

def lowmask_add_2_uses_before := [llvmfunc|
  llvm.func @lowmask_add_2_uses(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-64 : i8) : i8
    %1 = llvm.mlir.constant(63 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.and %2, %1  : i8
    llvm.return %3 : i8
  }]

def lowmask_add_2_splat_before := [llvmfunc|
  llvm.func @lowmask_add_2_splat(%arg0: vector<2xi8>, %arg1: !llvm.ptr) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-64> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<63> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0  : vector<2xi8>
    llvm.store %2, %arg1 {alignment = 2 : i64} : vector<2xi8>, !llvm.ptr]

    %3 = llvm.and %2, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def not_lowmask_add_before := [llvmfunc|
  llvm.func @not_lowmask_add(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-64 : i8) : i8
    %1 = llvm.mlir.constant(64 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.and %2, %1  : i8
    llvm.return %3 : i8
  }]

def not_lowmask_add2_before := [llvmfunc|
  llvm.func @not_lowmask_add2(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-96 : i8) : i8
    %1 = llvm.mlir.constant(63 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.and %2, %1  : i8
    llvm.return %3 : i8
  }]

def lowmask_add_splat_before := [llvmfunc|
  llvm.func @lowmask_add_splat(%arg0: vector<2xi8>, %arg1: !llvm.ptr) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-64> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<32> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0  : vector<2xi8>
    llvm.store %2, %arg1 {alignment = 2 : i64} : vector<2xi8>, !llvm.ptr]

    %3 = llvm.and %2, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def lowmask_add_splat_poison_before := [llvmfunc|
  llvm.func @lowmask_add_splat_poison(%arg0: vector<2xi8>, %arg1: !llvm.ptr) -> vector<2xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(-64 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(32 : i8) : i8
    %8 = llvm.mlir.undef : vector<2xi8>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<2xi8>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %7, %10[%11 : i32] : vector<2xi8>
    %13 = llvm.add %arg0, %6  : vector<2xi8>
    llvm.store %13, %arg1 {alignment = 2 : i64} : vector<2xi8>, !llvm.ptr]

    %14 = llvm.and %13, %12  : vector<2xi8>
    llvm.return %14 : vector<2xi8>
  }]

def lowmask_add_vec_before := [llvmfunc|
  llvm.func @lowmask_add_vec(%arg0: vector<2xi8>, %arg1: !llvm.ptr) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[-96, -64]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[16, 32]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0  : vector<2xi8>
    llvm.store %2, %arg1 {alignment = 2 : i64} : vector<2xi8>, !llvm.ptr]

    %3 = llvm.and %2, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def flip_masked_bit_before := [llvmfunc|
  llvm.func @flip_masked_bit(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    %2 = llvm.and %1, %0  : i8
    llvm.return %2 : i8
  }]

def flip_masked_bit_uniform_before := [llvmfunc|
  llvm.func @flip_masked_bit_uniform(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.add %arg0, %0  : vector<2xi8>
    %2 = llvm.and %1, %0  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

def flip_masked_bit_poison_before := [llvmfunc|
  llvm.func @flip_masked_bit_poison(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(16 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.add %arg0, %6  : vector<2xi8>
    %8 = llvm.and %7, %6  : vector<2xi8>
    llvm.return %8 : vector<2xi8>
  }]

def flip_masked_bit_nonuniform_before := [llvmfunc|
  llvm.func @flip_masked_bit_nonuniform(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[16, 4]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.add %arg0, %0  : vector<2xi8>
    %2 = llvm.and %1, %0  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

def ashr_bitwidth_mask_before := [llvmfunc|
  llvm.func @ashr_bitwidth_mask(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    %2 = llvm.and %1, %arg1  : i8
    llvm.return %2 : i8
  }]

def ashr_bitwidth_mask_vec_commute_before := [llvmfunc|
  llvm.func @ashr_bitwidth_mask_vec_commute(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[42, 2]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<7> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mul %arg1, %0  : vector<2xi8>
    %3 = llvm.ashr %arg0, %1  : vector<2xi8>
    %4 = llvm.and %2, %3  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

def ashr_bitwidth_mask_use_before := [llvmfunc|
  llvm.func @ashr_bitwidth_mask_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.and %1, %arg1  : i8
    llvm.return %2 : i8
  }]

def ashr_not_bitwidth_mask_before := [llvmfunc|
  llvm.func @ashr_not_bitwidth_mask(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    %2 = llvm.and %1, %arg1  : i8
    llvm.return %2 : i8
  }]

def lshr_bitwidth_mask_before := [llvmfunc|
  llvm.func @lshr_bitwidth_mask(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.lshr %arg0, %0  : i8
    %2 = llvm.and %1, %arg1  : i8
    llvm.return %2 : i8
  }]

def signbit_splat_mask_before := [llvmfunc|
  llvm.func @signbit_splat_mask(%arg0: i8, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    %2 = llvm.sext %1 : i8 to i16
    %3 = llvm.and %2, %arg1  : i16
    llvm.return %3 : i16
  }]

def signbit_splat_mask_commute_before := [llvmfunc|
  llvm.func @signbit_splat_mask_commute(%arg0: vector<2xi5>, %arg1: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.poison : i5
    %1 = llvm.mlir.constant(4 : i5) : i5
    %2 = llvm.mlir.undef : vector<2xi5>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi5>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi5>
    %7 = llvm.mul %arg1, %arg1  : vector<2xi16>
    %8 = llvm.ashr %arg0, %6  : vector<2xi5>
    %9 = llvm.sext %8 : vector<2xi5> to vector<2xi16>
    %10 = llvm.and %7, %9  : vector<2xi16>
    llvm.return %10 : vector<2xi16>
  }]

def signbit_splat_mask_use1_before := [llvmfunc|
  llvm.func @signbit_splat_mask_use1(%arg0: i8, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.sext %1 : i8 to i16
    %3 = llvm.and %2, %arg1  : i16
    llvm.return %3 : i16
  }]

def signbit_splat_mask_use2_before := [llvmfunc|
  llvm.func @signbit_splat_mask_use2(%arg0: i8, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    %2 = llvm.sext %1 : i8 to i16
    llvm.call @use16(%2) : (i16) -> ()
    %3 = llvm.and %2, %arg1  : i16
    llvm.return %3 : i16
  }]

def not_signbit_splat_mask1_before := [llvmfunc|
  llvm.func @not_signbit_splat_mask1(%arg0: i8, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    %2 = llvm.zext %1 : i8 to i16
    %3 = llvm.and %2, %arg1  : i16
    llvm.return %3 : i16
  }]

def not_signbit_splat_mask2_before := [llvmfunc|
  llvm.func @not_signbit_splat_mask2(%arg0: i8, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    %2 = llvm.sext %1 : i8 to i16
    %3 = llvm.and %2, %arg1  : i16
    llvm.return %3 : i16
  }]

def not_ashr_bitwidth_mask_before := [llvmfunc|
  llvm.func @not_ashr_bitwidth_mask(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    %4 = llvm.and %3, %arg1  : i8
    llvm.return %4 : i8
  }]

def not_ashr_bitwidth_mask_vec_commute_before := [llvmfunc|
  llvm.func @not_ashr_bitwidth_mask_vec_commute(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[42, 2]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<7> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.mul %arg1, %0  : vector<2xi8>
    %4 = llvm.ashr %arg0, %1  : vector<2xi8>
    %5 = llvm.xor %4, %2  : vector<2xi8>
    %6 = llvm.and %3, %5  : vector<2xi8>
    llvm.return %6 : vector<2xi8>
  }]

def not_ashr_bitwidth_mask_use1_before := [llvmfunc|
  llvm.func @not_ashr_bitwidth_mask_use1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.xor %2, %1  : i8
    %4 = llvm.and %3, %arg1  : i8
    llvm.return %4 : i8
  }]

def not_ashr_bitwidth_mask_use2_before := [llvmfunc|
  llvm.func @not_ashr_bitwidth_mask_use2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.and %3, %arg1  : i8
    llvm.return %4 : i8
  }]

def not_ashr_not_bitwidth_mask_before := [llvmfunc|
  llvm.func @not_ashr_not_bitwidth_mask(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    %4 = llvm.and %3, %arg1  : i8
    llvm.return %4 : i8
  }]

def not_lshr_bitwidth_mask_before := [llvmfunc|
  llvm.func @not_lshr_bitwidth_mask(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    %4 = llvm.and %3, %arg1  : i8
    llvm.return %4 : i8
  }]

def invert_signbit_splat_mask_before := [llvmfunc|
  llvm.func @invert_signbit_splat_mask(%arg0: i8, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    %4 = llvm.sext %3 : i8 to i16
    %5 = llvm.and %4, %arg1  : i16
    llvm.return %5 : i16
  }]

def invert_signbit_splat_mask_commute_before := [llvmfunc|
  llvm.func @invert_signbit_splat_mask_commute(%arg0: vector<2xi5>, %arg1: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.poison : i5
    %1 = llvm.mlir.constant(4 : i5) : i5
    %2 = llvm.mlir.undef : vector<2xi5>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi5>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi5>
    %7 = llvm.mlir.constant(-1 : i5) : i5
    %8 = llvm.mlir.constant(dense<-1> : vector<2xi5>) : vector<2xi5>
    %9 = llvm.mul %arg1, %arg1  : vector<2xi16>
    %10 = llvm.ashr %arg0, %6  : vector<2xi5>
    %11 = llvm.xor %10, %8  : vector<2xi5>
    %12 = llvm.sext %11 : vector<2xi5> to vector<2xi16>
    %13 = llvm.and %9, %12  : vector<2xi16>
    llvm.return %13 : vector<2xi16>
  }]

def invert_signbit_splat_mask_use1_before := [llvmfunc|
  llvm.func @invert_signbit_splat_mask_use1(%arg0: i8, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.xor %2, %1  : i8
    %4 = llvm.sext %3 : i8 to i16
    %5 = llvm.and %4, %arg1  : i16
    llvm.return %5 : i16
  }]

def invert_signbit_splat_mask_use2_before := [llvmfunc|
  llvm.func @invert_signbit_splat_mask_use2(%arg0: i8, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.sext %3 : i8 to i16
    %5 = llvm.and %4, %arg1  : i16
    llvm.return %5 : i16
  }]

def invert_signbit_splat_mask_use3_before := [llvmfunc|
  llvm.func @invert_signbit_splat_mask_use3(%arg0: i8, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    %4 = llvm.sext %3 : i8 to i16
    llvm.call @use16(%4) : (i16) -> ()
    %5 = llvm.and %4, %arg1  : i16
    llvm.return %5 : i16
  }]

def not_invert_signbit_splat_mask1_before := [llvmfunc|
  llvm.func @not_invert_signbit_splat_mask1(%arg0: i8, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    %4 = llvm.zext %3 : i8 to i16
    %5 = llvm.and %4, %arg1  : i16
    llvm.return %5 : i16
  }]

def not_invert_signbit_splat_mask2_before := [llvmfunc|
  llvm.func @not_invert_signbit_splat_mask2(%arg0: i8, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    %4 = llvm.sext %3 : i8 to i16
    %5 = llvm.and %4, %arg1  : i16
    llvm.return %5 : i16
  }]

def shl_lshr_pow2_const_case1_before := [llvmfunc|
  llvm.func @shl_lshr_pow2_const_case1(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(4 : i16) : i16
    %1 = llvm.mlir.constant(6 : i16) : i16
    %2 = llvm.mlir.constant(8 : i16) : i16
    %3 = llvm.shl %0, %arg0  : i16
    %4 = llvm.lshr %3, %1  : i16
    %5 = llvm.and %4, %2  : i16
    llvm.return %5 : i16
  }]

def shl_ashr_pow2_const_case1_before := [llvmfunc|
  llvm.func @shl_ashr_pow2_const_case1(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(4 : i16) : i16
    %1 = llvm.mlir.constant(6 : i16) : i16
    %2 = llvm.mlir.constant(8 : i16) : i16
    %3 = llvm.shl %0, %arg0  : i16
    %4 = llvm.ashr %3, %1  : i16
    %5 = llvm.and %4, %2  : i16
    llvm.return %5 : i16
  }]

def shl_lshr_pow2_const_case1_uniform_vec_before := [llvmfunc|
  llvm.func @shl_lshr_pow2_const_case1_uniform_vec(%arg0: vector<3xi16>) -> vector<3xi16> {
    %0 = llvm.mlir.constant(dense<4> : vector<3xi16>) : vector<3xi16>
    %1 = llvm.mlir.constant(dense<6> : vector<3xi16>) : vector<3xi16>
    %2 = llvm.mlir.constant(dense<8> : vector<3xi16>) : vector<3xi16>
    %3 = llvm.shl %0, %arg0  : vector<3xi16>
    %4 = llvm.lshr %3, %1  : vector<3xi16>
    %5 = llvm.and %4, %2  : vector<3xi16>
    llvm.return %5 : vector<3xi16>
  }]

def shl_lshr_pow2_const_case1_non_uniform_vec_before := [llvmfunc|
  llvm.func @shl_lshr_pow2_const_case1_non_uniform_vec(%arg0: vector<3xi16>) -> vector<3xi16> {
    %0 = llvm.mlir.constant(dense<[2, 8, 32]> : vector<3xi16>) : vector<3xi16>
    %1 = llvm.mlir.constant(dense<[5, 6, 3]> : vector<3xi16>) : vector<3xi16>
    %2 = llvm.mlir.constant(dense<[8, 4, 8]> : vector<3xi16>) : vector<3xi16>
    %3 = llvm.shl %0, %arg0  : vector<3xi16>
    %4 = llvm.lshr %3, %1  : vector<3xi16>
    %5 = llvm.and %4, %2  : vector<3xi16>
    llvm.return %5 : vector<3xi16>
  }]

def shl_lshr_pow2_const_case1_non_uniform_vec_negative_before := [llvmfunc|
  llvm.func @shl_lshr_pow2_const_case1_non_uniform_vec_negative(%arg0: vector<3xi16>) -> vector<3xi16> {
    %0 = llvm.mlir.constant(dense<[2, 8, 32]> : vector<3xi16>) : vector<3xi16>
    %1 = llvm.mlir.constant(dense<[5, 6, 3]> : vector<3xi16>) : vector<3xi16>
    %2 = llvm.mlir.constant(dense<[8, 4, 16384]> : vector<3xi16>) : vector<3xi16>
    %3 = llvm.shl %0, %arg0  : vector<3xi16>
    %4 = llvm.lshr %3, %1  : vector<3xi16>
    %5 = llvm.and %4, %2  : vector<3xi16>
    llvm.return %5 : vector<3xi16>
  }]

def shl_lshr_pow2_const_case1_poison1_vec_before := [llvmfunc|
  llvm.func @shl_lshr_pow2_const_case1_poison1_vec(%arg0: vector<3xi16>) -> vector<3xi16> {
    %0 = llvm.mlir.constant(16 : i16) : i16
    %1 = llvm.mlir.poison : i16
    %2 = llvm.mlir.undef : vector<3xi16>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<3xi16>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<3xi16>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi16>
    %9 = llvm.mlir.constant(dense<5> : vector<3xi16>) : vector<3xi16>
    %10 = llvm.mlir.constant(dense<8> : vector<3xi16>) : vector<3xi16>
    %11 = llvm.shl %8, %arg0  : vector<3xi16>
    %12 = llvm.lshr %11, %9  : vector<3xi16>
    %13 = llvm.and %12, %10  : vector<3xi16>
    llvm.return %13 : vector<3xi16>
  }]

def shl_lshr_pow2_const_case1_poison2_vec_before := [llvmfunc|
  llvm.func @shl_lshr_pow2_const_case1_poison2_vec(%arg0: vector<3xi16>) -> vector<3xi16> {
    %0 = llvm.mlir.constant(dense<16> : vector<3xi16>) : vector<3xi16>
    %1 = llvm.mlir.constant(5 : i16) : i16
    %2 = llvm.mlir.poison : i16
    %3 = llvm.mlir.undef : vector<3xi16>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<3xi16>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<3xi16>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<3xi16>
    %10 = llvm.mlir.constant(dense<8> : vector<3xi16>) : vector<3xi16>
    %11 = llvm.shl %0, %arg0  : vector<3xi16>
    %12 = llvm.lshr %11, %9  : vector<3xi16>
    %13 = llvm.and %12, %10  : vector<3xi16>
    llvm.return %13 : vector<3xi16>
  }]

def shl_lshr_pow2_const_case1_poison3_vec_before := [llvmfunc|
  llvm.func @shl_lshr_pow2_const_case1_poison3_vec(%arg0: vector<3xi16>) -> vector<3xi16> {
    %0 = llvm.mlir.constant(dense<16> : vector<3xi16>) : vector<3xi16>
    %1 = llvm.mlir.constant(dense<5> : vector<3xi16>) : vector<3xi16>
    %2 = llvm.mlir.constant(8 : i16) : i16
    %3 = llvm.mlir.poison : i16
    %4 = llvm.mlir.undef : vector<3xi16>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<3xi16>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<3xi16>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %2, %8[%9 : i32] : vector<3xi16>
    %11 = llvm.shl %0, %arg0  : vector<3xi16>
    %12 = llvm.lshr %11, %1  : vector<3xi16>
    %13 = llvm.and %12, %10  : vector<3xi16>
    llvm.return %13 : vector<3xi16>
  }]

def shl_lshr_pow2_const_case2_before := [llvmfunc|
  llvm.func @shl_lshr_pow2_const_case2(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(16 : i16) : i16
    %1 = llvm.mlir.constant(3 : i16) : i16
    %2 = llvm.mlir.constant(8 : i16) : i16
    %3 = llvm.shl %0, %arg0  : i16
    %4 = llvm.lshr %3, %1  : i16
    %5 = llvm.and %4, %2  : i16
    llvm.return %5 : i16
  }]

def shl_lshr_pow2_not_const_case2_before := [llvmfunc|
  llvm.func @shl_lshr_pow2_not_const_case2(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(16 : i16) : i16
    %1 = llvm.mlir.constant(3 : i16) : i16
    %2 = llvm.mlir.constant(8 : i16) : i16
    %3 = llvm.shl %0, %arg0  : i16
    %4 = llvm.lshr %3, %1  : i16
    %5 = llvm.and %4, %2  : i16
    %6 = llvm.xor %5, %2  : i16
    llvm.return %6 : i16
  }]

def shl_lshr_pow2_const_negative_overflow1_before := [llvmfunc|
  llvm.func @shl_lshr_pow2_const_negative_overflow1(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(4096 : i16) : i16
    %1 = llvm.mlir.constant(6 : i16) : i16
    %2 = llvm.mlir.constant(8 : i16) : i16
    %3 = llvm.shl %0, %arg0  : i16
    %4 = llvm.lshr %3, %1  : i16
    %5 = llvm.and %4, %2  : i16
    llvm.return %5 : i16
  }]

def shl_lshr_pow2_const_negative_overflow2_before := [llvmfunc|
  llvm.func @shl_lshr_pow2_const_negative_overflow2(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.mlir.constant(6 : i16) : i16
    %2 = llvm.mlir.constant(-32768 : i16) : i16
    %3 = llvm.shl %0, %arg0  : i16
    %4 = llvm.lshr %3, %1  : i16
    %5 = llvm.and %4, %2  : i16
    llvm.return %5 : i16
  }]

def shl_lshr_pow2_const_negative_oneuse_before := [llvmfunc|
  llvm.func @shl_lshr_pow2_const_negative_oneuse(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(4 : i16) : i16
    %1 = llvm.mlir.constant(6 : i16) : i16
    %2 = llvm.mlir.constant(8 : i16) : i16
    %3 = llvm.shl %0, %arg0  : i16
    %4 = llvm.lshr %3, %1  : i16
    llvm.call @use16(%4) : (i16) -> ()
    %5 = llvm.and %4, %2  : i16
    llvm.return %5 : i16
  }]

def shl_lshr_pow2_const_negative_nopow2_1_before := [llvmfunc|
  llvm.func @shl_lshr_pow2_const_negative_nopow2_1(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(3 : i16) : i16
    %1 = llvm.mlir.constant(6 : i16) : i16
    %2 = llvm.mlir.constant(8 : i16) : i16
    %3 = llvm.shl %0, %arg0  : i16
    %4 = llvm.lshr %3, %1  : i16
    %5 = llvm.and %4, %2  : i16
    llvm.return %5 : i16
  }]

def shl_lshr_pow2_const_negative_nopow2_2_before := [llvmfunc|
  llvm.func @shl_lshr_pow2_const_negative_nopow2_2(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(3 : i16) : i16
    %1 = llvm.mlir.constant(6 : i16) : i16
    %2 = llvm.mlir.constant(7 : i16) : i16
    %3 = llvm.shl %0, %arg0  : i16
    %4 = llvm.lshr %3, %1  : i16
    %5 = llvm.and %4, %2  : i16
    llvm.return %5 : i16
  }]

def lshr_lshr_pow2_const_before := [llvmfunc|
  llvm.func @lshr_lshr_pow2_const(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(2048 : i16) : i16
    %1 = llvm.mlir.constant(6 : i16) : i16
    %2 = llvm.mlir.constant(4 : i16) : i16
    %3 = llvm.lshr %0, %arg0  : i16
    %4 = llvm.lshr %3, %1  : i16
    %5 = llvm.and %4, %2  : i16
    llvm.return %5 : i16
  }]

def lshr_lshr_pow2_const_negative_oneuse_before := [llvmfunc|
  llvm.func @lshr_lshr_pow2_const_negative_oneuse(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(2048 : i16) : i16
    %1 = llvm.mlir.constant(6 : i16) : i16
    %2 = llvm.mlir.constant(4 : i16) : i16
    %3 = llvm.lshr %0, %arg0  : i16
    %4 = llvm.lshr %3, %1  : i16
    llvm.call @use16(%4) : (i16) -> ()
    %5 = llvm.and %4, %2  : i16
    llvm.return %5 : i16
  }]

def lshr_lshr_pow2_const_negative_nopow2_1_before := [llvmfunc|
  llvm.func @lshr_lshr_pow2_const_negative_nopow2_1(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(2047 : i16) : i16
    %1 = llvm.mlir.constant(6 : i16) : i16
    %2 = llvm.mlir.constant(4 : i16) : i16
    %3 = llvm.lshr %0, %arg0  : i16
    %4 = llvm.lshr %3, %1  : i16
    %5 = llvm.and %4, %2  : i16
    llvm.return %5 : i16
  }]

def lshr_lshr_pow2_const_negative_nopow2_2_before := [llvmfunc|
  llvm.func @lshr_lshr_pow2_const_negative_nopow2_2(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(8192 : i16) : i16
    %1 = llvm.mlir.constant(6 : i16) : i16
    %2 = llvm.mlir.constant(3 : i16) : i16
    %3 = llvm.lshr %0, %arg0  : i16
    %4 = llvm.lshr %3, %1  : i16
    %5 = llvm.and %4, %2  : i16
    llvm.return %5 : i16
  }]

def lshr_lshr_pow2_const_negative_overflow_before := [llvmfunc|
  llvm.func @lshr_lshr_pow2_const_negative_overflow(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(-32768 : i16) : i16
    %1 = llvm.mlir.constant(15 : i16) : i16
    %2 = llvm.mlir.constant(4 : i16) : i16
    %3 = llvm.lshr %0, %arg0  : i16
    %4 = llvm.lshr %3, %1  : i16
    %5 = llvm.and %4, %2  : i16
    llvm.return %5 : i16
  }]

def lshr_shl_pow2_const_case1_before := [llvmfunc|
  llvm.func @lshr_shl_pow2_const_case1(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(256 : i16) : i16
    %1 = llvm.mlir.constant(2 : i16) : i16
    %2 = llvm.mlir.constant(8 : i16) : i16
    %3 = llvm.lshr %0, %arg0  : i16
    %4 = llvm.shl %3, %1  : i16
    %5 = llvm.and %4, %2  : i16
    llvm.return %5 : i16
  }]

def lshr_shl_pow2_const_xor_before := [llvmfunc|
  llvm.func @lshr_shl_pow2_const_xor(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(256 : i16) : i16
    %1 = llvm.mlir.constant(2 : i16) : i16
    %2 = llvm.mlir.constant(8 : i16) : i16
    %3 = llvm.lshr %0, %arg0  : i16
    %4 = llvm.shl %3, %1  : i16
    %5 = llvm.and %4, %2  : i16
    %6 = llvm.xor %5, %2  : i16
    llvm.return %6 : i16
  }]

def lshr_shl_pow2_const_case2_before := [llvmfunc|
  llvm.func @lshr_shl_pow2_const_case2(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(8192 : i16) : i16
    %1 = llvm.mlir.constant(4 : i16) : i16
    %2 = llvm.mlir.constant(32 : i16) : i16
    %3 = llvm.lshr %0, %arg0  : i16
    %4 = llvm.shl %3, %1  : i16
    %5 = llvm.and %4, %2  : i16
    llvm.return %5 : i16
  }]

def lshr_shl_pow2_const_overflow_before := [llvmfunc|
  llvm.func @lshr_shl_pow2_const_overflow(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(8192 : i16) : i16
    %1 = llvm.mlir.constant(6 : i16) : i16
    %2 = llvm.mlir.constant(32 : i16) : i16
    %3 = llvm.lshr %0, %arg0  : i16
    %4 = llvm.shl %3, %1  : i16
    %5 = llvm.and %4, %2  : i16
    llvm.return %5 : i16
  }]

def lshr_shl_pow2_const_negative_oneuse_before := [llvmfunc|
  llvm.func @lshr_shl_pow2_const_negative_oneuse(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(8192 : i16) : i16
    %1 = llvm.mlir.constant(4 : i16) : i16
    %2 = llvm.mlir.constant(32 : i16) : i16
    %3 = llvm.lshr %0, %arg0  : i16
    %4 = llvm.shl %3, %1  : i16
    llvm.call @use16(%4) : (i16) -> ()
    %5 = llvm.and %4, %2  : i16
    llvm.return %5 : i16
  }]

def lshr_shl_pow2_const_case1_uniform_vec_before := [llvmfunc|
  llvm.func @lshr_shl_pow2_const_case1_uniform_vec(%arg0: vector<3xi16>) -> vector<3xi16> {
    %0 = llvm.mlir.constant(dense<8192> : vector<3xi16>) : vector<3xi16>
    %1 = llvm.mlir.constant(dense<6> : vector<3xi16>) : vector<3xi16>
    %2 = llvm.mlir.constant(dense<128> : vector<3xi16>) : vector<3xi16>
    %3 = llvm.lshr %0, %arg0  : vector<3xi16>
    %4 = llvm.shl %3, %1  : vector<3xi16>
    %5 = llvm.and %4, %2  : vector<3xi16>
    llvm.return %5 : vector<3xi16>
  }]

def lshr_shl_pow2_const_case1_non_uniform_vec_before := [llvmfunc|
  llvm.func @lshr_shl_pow2_const_case1_non_uniform_vec(%arg0: vector<3xi16>) -> vector<3xi16> {
    %0 = llvm.mlir.constant(dense<[8192, 16384, -32768]> : vector<3xi16>) : vector<3xi16>
    %1 = llvm.mlir.constant(dense<[7, 5, 3]> : vector<3xi16>) : vector<3xi16>
    %2 = llvm.mlir.constant(dense<[128, 256, 512]> : vector<3xi16>) : vector<3xi16>
    %3 = llvm.lshr %0, %arg0  : vector<3xi16>
    %4 = llvm.shl %3, %1  : vector<3xi16>
    %5 = llvm.and %4, %2  : vector<3xi16>
    llvm.return %5 : vector<3xi16>
  }]

def lshr_shl_pow2_const_case1_non_uniform_vec_negative_before := [llvmfunc|
  llvm.func @lshr_shl_pow2_const_case1_non_uniform_vec_negative(%arg0: vector<3xi16>) -> vector<3xi16> {
    %0 = llvm.mlir.constant(dense<[8192, 16384, -32768]> : vector<3xi16>) : vector<3xi16>
    %1 = llvm.mlir.constant(dense<[8, 5, 3]> : vector<3xi16>) : vector<3xi16>
    %2 = llvm.mlir.constant(dense<[128, 256, 512]> : vector<3xi16>) : vector<3xi16>
    %3 = llvm.lshr %0, %arg0  : vector<3xi16>
    %4 = llvm.shl %3, %1  : vector<3xi16>
    %5 = llvm.and %4, %2  : vector<3xi16>
    llvm.return %5 : vector<3xi16>
  }]

def lshr_shl_pow2_const_case1_poison1_vec_before := [llvmfunc|
  llvm.func @lshr_shl_pow2_const_case1_poison1_vec(%arg0: vector<3xi16>) -> vector<3xi16> {
    %0 = llvm.mlir.constant(8192 : i16) : i16
    %1 = llvm.mlir.poison : i16
    %2 = llvm.mlir.undef : vector<3xi16>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<3xi16>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<3xi16>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi16>
    %9 = llvm.mlir.constant(dense<6> : vector<3xi16>) : vector<3xi16>
    %10 = llvm.mlir.constant(dense<128> : vector<3xi16>) : vector<3xi16>
    %11 = llvm.lshr %8, %arg0  : vector<3xi16>
    %12 = llvm.shl %11, %9  : vector<3xi16>
    %13 = llvm.and %12, %10  : vector<3xi16>
    llvm.return %13 : vector<3xi16>
  }]

def lshr_shl_pow2_const_case1_poison2_vec_before := [llvmfunc|
  llvm.func @lshr_shl_pow2_const_case1_poison2_vec(%arg0: vector<3xi16>) -> vector<3xi16> {
    %0 = llvm.mlir.constant(dense<8192> : vector<3xi16>) : vector<3xi16>
    %1 = llvm.mlir.constant(6 : i16) : i16
    %2 = llvm.mlir.poison : i16
    %3 = llvm.mlir.undef : vector<3xi16>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<3xi16>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<3xi16>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<3xi16>
    %10 = llvm.mlir.constant(dense<128> : vector<3xi16>) : vector<3xi16>
    %11 = llvm.lshr %0, %arg0  : vector<3xi16>
    %12 = llvm.shl %11, %9  : vector<3xi16>
    %13 = llvm.and %12, %10  : vector<3xi16>
    llvm.return %13 : vector<3xi16>
  }]

def lshr_shl_pow2_const_case1_poison3_vec_before := [llvmfunc|
  llvm.func @lshr_shl_pow2_const_case1_poison3_vec(%arg0: vector<3xi16>) -> vector<3xi16> {
    %0 = llvm.mlir.constant(dense<8192> : vector<3xi16>) : vector<3xi16>
    %1 = llvm.mlir.constant(dense<6> : vector<3xi16>) : vector<3xi16>
    %2 = llvm.mlir.constant(128 : i16) : i16
    %3 = llvm.mlir.poison : i16
    %4 = llvm.mlir.undef : vector<3xi16>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<3xi16>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<3xi16>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %2, %8[%9 : i32] : vector<3xi16>
    %11 = llvm.lshr %0, %arg0  : vector<3xi16>
    %12 = llvm.shl %11, %1  : vector<3xi16>
    %13 = llvm.and %12, %10  : vector<3xi16>
    llvm.return %13 : vector<3xi16>
  }]

def negate_lowbitmask_before := [llvmfunc|
  llvm.func @negate_lowbitmask(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.sub %1, %2  : i8
    %4 = llvm.and %3, %arg1  : i8
    llvm.return %4 : i8
  }]

def negate_lowbitmask_commute_before := [llvmfunc|
  llvm.func @negate_lowbitmask_commute(%arg0: vector<2xi5>, %arg1: vector<2xi5>) -> vector<2xi5> {
    %0 = llvm.mlir.poison : i5
    %1 = llvm.mlir.constant(1 : i5) : i5
    %2 = llvm.mlir.undef : vector<2xi5>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi5>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi5>
    %7 = llvm.mlir.constant(0 : i5) : i5
    %8 = llvm.mlir.undef : vector<2xi5>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<2xi5>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %7, %10[%11 : i32] : vector<2xi5>
    %13 = llvm.mul %arg1, %arg1  : vector<2xi5>
    %14 = llvm.and %arg0, %6  : vector<2xi5>
    %15 = llvm.sub %12, %14  : vector<2xi5>
    %16 = llvm.and %13, %15  : vector<2xi5>
    llvm.return %16 : vector<2xi5>
  }]

def negate_lowbitmask_use1_before := [llvmfunc|
  llvm.func @negate_lowbitmask_use1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %1, %2  : i8
    %4 = llvm.and %3, %arg1  : i8
    llvm.return %4 : i8
  }]

def negate_lowbitmask_use2_before := [llvmfunc|
  llvm.func @negate_lowbitmask_use2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.sub %1, %2  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.and %3, %arg1  : i8
    llvm.return %4 : i8
  }]

def test_and_or_constexpr_infloop_before := [llvmfunc|
  llvm.func @test_and_or_constexpr_infloop() -> i64 {
    %0 = llvm.mlir.addressof @g : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i64
    %2 = llvm.mlir.constant(-8 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.and %1, %2  : i64
    %5 = llvm.or %4, %3  : i64
    llvm.return %5 : i64
  }]

def and_zext_before := [llvmfunc|
  llvm.func @and_zext(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.zext %arg1 : i1 to i32
    %1 = llvm.and %arg0, %0  : i32
    llvm.return %1 : i32
  }]

def and_zext_commuted_before := [llvmfunc|
  llvm.func @and_zext_commuted(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.zext %arg1 : i1 to i32
    %1 = llvm.and %0, %arg0  : i32
    llvm.return %1 : i32
  }]

def and_zext_multiuse_before := [llvmfunc|
  llvm.func @and_zext_multiuse(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.zext %arg1 : i1 to i32
    llvm.call @use32(%0) : (i32) -> ()
    %1 = llvm.and %arg0, %0  : i32
    llvm.return %1 : i32
  }]

def and_zext_vec_before := [llvmfunc|
  llvm.func @and_zext_vec(%arg0: vector<2xi32>, %arg1: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.zext %arg1 : vector<2xi1> to vector<2xi32>
    %1 = llvm.and %arg0, %0  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

def and_zext_eq_even_before := [llvmfunc|
  llvm.func @and_zext_eq_even(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.zext %1 : i1 to i32
    %3 = llvm.and %arg0, %2  : i32
    llvm.return %3 : i32
  }]

def and_zext_eq_even_commuted_before := [llvmfunc|
  llvm.func @and_zext_eq_even_commuted(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.zext %1 : i1 to i32
    %3 = llvm.and %2, %arg0  : i32
    llvm.return %3 : i32
  }]

def and_zext_eq_odd_before := [llvmfunc|
  llvm.func @and_zext_eq_odd(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.zext %1 : i1 to i32
    %3 = llvm.and %arg0, %2  : i32
    llvm.return %3 : i32
  }]

def and_zext_eq_odd_commuted_before := [llvmfunc|
  llvm.func @and_zext_eq_odd_commuted(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.zext %1 : i1 to i32
    %3 = llvm.and %2, %arg0  : i32
    llvm.return %3 : i32
  }]

def and_zext_eq_zero_before := [llvmfunc|
  llvm.func @and_zext_eq_zero(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.lshr %arg0, %arg1  : i32
    %5 = llvm.xor %4, %1  : i32
    %6 = llvm.and %3, %5  : i32
    llvm.return %6 : i32
  }]

def canonicalize_and_add_power2_or_zero_before := [llvmfunc|
  llvm.func @canonicalize_and_add_power2_or_zero(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg1  : i32
    %2 = llvm.and %1, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.mul %arg0, %arg0  : i32
    %4 = llvm.add %3, %2  : i32
    %5 = llvm.and %4, %2  : i32
    llvm.return %5 : i32
  }]

def canonicalize_and_sub_power2_or_zero_before := [llvmfunc|
  llvm.func @canonicalize_and_sub_power2_or_zero(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg1  : i32
    %2 = llvm.and %1, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.sub %arg0, %2  : i32
    %4 = llvm.and %3, %2  : i32
    llvm.return %4 : i32
  }]

def canonicalize_and_add_power2_or_zero_commuted1_before := [llvmfunc|
  llvm.func @canonicalize_and_add_power2_or_zero_commuted1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg1  : i32
    %2 = llvm.and %1, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.add %2, %arg0  : i32
    %4 = llvm.and %3, %2  : i32
    llvm.return %4 : i32
  }]

def canonicalize_and_add_power2_or_zero_commuted2_before := [llvmfunc|
  llvm.func @canonicalize_and_add_power2_or_zero_commuted2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg1  : i32
    %2 = llvm.and %1, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.mul %arg0, %arg0  : i32
    %4 = llvm.add %3, %2  : i32
    %5 = llvm.and %2, %4  : i32
    llvm.return %5 : i32
  }]

def canonicalize_and_add_power2_or_zero_commuted3_before := [llvmfunc|
  llvm.func @canonicalize_and_add_power2_or_zero_commuted3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg1  : i32
    %2 = llvm.and %1, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.add %2, %arg0  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.return %4 : i32
  }]

def canonicalize_and_sub_power2_or_zero_commuted_nofold_before := [llvmfunc|
  llvm.func @canonicalize_and_sub_power2_or_zero_commuted_nofold(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg1  : i32
    %2 = llvm.and %1, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.sub %2, %arg0  : i32
    %4 = llvm.and %3, %2  : i32
    llvm.return %4 : i32
  }]

def canonicalize_and_add_non_power2_or_zero_nofold_before := [llvmfunc|
  llvm.func @canonicalize_and_add_non_power2_or_zero_nofold(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.add %arg0, %arg1  : i32
    %1 = llvm.and %0, %arg1  : i32
    llvm.return %1 : i32
  }]

def canonicalize_and_add_power2_or_zero_multiuse_nofold_before := [llvmfunc|
  llvm.func @canonicalize_and_add_power2_or_zero_multiuse_nofold(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg1  : i32
    %2 = llvm.and %1, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.mul %arg0, %arg0  : i32
    %4 = llvm.add %3, %2  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.and %4, %2  : i32
    llvm.return %5 : i32
  }]

def canonicalize_and_sub_power2_or_zero_multiuse_nofold_before := [llvmfunc|
  llvm.func @canonicalize_and_sub_power2_or_zero_multiuse_nofold(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg1  : i32
    %2 = llvm.and %1, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.sub %arg0, %2  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.and %3, %2  : i32
    llvm.return %4 : i32
  }]

def add_constant_equal_with_the_top_bit_of_demandedbits_pass_before := [llvmfunc|
  llvm.func @add_constant_equal_with_the_top_bit_of_demandedbits_pass(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(24 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }]

def add_constant_equal_with_the_top_bit_of_demandedbits_pass_vector_before := [llvmfunc|
  llvm.func @add_constant_equal_with_the_top_bit_of_demandedbits_pass_vector(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(dense<24> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.add %arg0, %0  : vector<2xi16>
    %3 = llvm.and %2, %1  : vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

def add_constant_equal_with_the_top_bit_of_demandedbits_fail1_before := [llvmfunc|
  llvm.func @add_constant_equal_with_the_top_bit_of_demandedbits_fail1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(24 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }]

def add_constant_equal_with_the_top_bit_of_demandedbits_fail2_before := [llvmfunc|
  llvm.func @add_constant_equal_with_the_top_bit_of_demandedbits_fail2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.and %1, %0  : i32
    llvm.return %2 : i32
  }]

def add_constant_equal_with_the_top_bit_of_demandedbits_insertpt_before := [llvmfunc|
  llvm.func @add_constant_equal_with_the_top_bit_of_demandedbits_insertpt(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(24 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.or %2, %arg1  : i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }]

def and_sext_multiuse_before := [llvmfunc|
  llvm.func @and_sext_multiuse(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i32
    %1 = llvm.sext %0 : i1 to i32
    %2 = llvm.and %1, %arg2  : i32
    %3 = llvm.and %1, %arg3  : i32
    %4 = llvm.add %2, %3  : i32
    llvm.return %4 : i32
  }]

def test_with_1_combined := [llvmfunc|
  llvm.func @test_with_1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.zext %1 : i1 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test_with_1   : test_with_1_before  ⊑  test_with_1_combined := by
  unfold test_with_1_before test_with_1_combined
  simp_alive_peephole
  sorry
def test_with_3_combined := [llvmfunc|
  llvm.func @test_with_3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.shl %0, %arg0  : i32
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test_with_3   : test_with_3_before  ⊑  test_with_3_combined := by
  unfold test_with_3_before test_with_3_combined
  simp_alive_peephole
  sorry
def test_with_5_combined := [llvmfunc|
  llvm.func @test_with_5(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.shl %0, %arg0  : i32
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test_with_5   : test_with_5_before  ⊑  test_with_5_combined := by
  unfold test_with_5_before test_with_5_combined
  simp_alive_peephole
  sorry
def test_with_neg_5_combined := [llvmfunc|
  llvm.func @test_with_neg_5(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-5 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.shl %0, %arg0  : i32
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test_with_neg_5   : test_with_neg_5_before  ⊑  test_with_neg_5_combined := by
  unfold test_with_neg_5_before test_with_neg_5_combined
  simp_alive_peephole
  sorry
def test_with_even_combined := [llvmfunc|
  llvm.func @test_with_even(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test_with_even   : test_with_even_before  ⊑  test_with_even_combined := by
  unfold test_with_even_before test_with_even_combined
  simp_alive_peephole
  sorry
def test_vec_combined := [llvmfunc|
  llvm.func @test_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.shl %0, %arg0  : vector<2xi32>
    %3 = llvm.and %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_test_vec   : test_vec_before  ⊑  test_vec_combined := by
  unfold test_vec_before test_vec_combined
  simp_alive_peephole
  sorry
def test_with_neg_even_combined := [llvmfunc|
  llvm.func @test_with_neg_even(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test_with_neg_even   : test_with_neg_even_before  ⊑  test_with_neg_even_combined := by
  unfold test_with_neg_even_before test_with_neg_even_combined
  simp_alive_peephole
  sorry
def test_with_more_one_use_combined := [llvmfunc|
  llvm.func @test_with_more_one_use(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.shl %0, %arg0  : i32
    %3 = llvm.and %2, %1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    llvm.return %3 : i32
  }]

theorem inst_combine_test_with_more_one_use   : test_with_more_one_use_before  ⊑  test_with_more_one_use_combined := by
  unfold test_with_more_one_use_before test_with_more_one_use_combined
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
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i32) -> i32 {
    llvm.return %arg0 : i32
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test3_logical_combined := [llvmfunc|
  llvm.func @test3_logical(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test3_logical   : test3_logical_before  ⊑  test3_logical_combined := by
  unfold test3_logical_before test3_logical_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4(%arg0: i1) -> i1 {
    llvm.return %arg0 : i1
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def test4_logical_combined := [llvmfunc|
  llvm.func @test4_logical(%arg0: i1) -> i1 {
    llvm.return %arg0 : i1
  }]

theorem inst_combine_test4_logical   : test4_logical_before  ⊑  test4_logical_combined := by
  unfold test4_logical_before test4_logical_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5(%arg0: i32) -> i32 {
    llvm.return %arg0 : i32
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
def test6_combined := [llvmfunc|
  llvm.func @test6(%arg0: i1) -> i1 {
    llvm.return %arg0 : i1
  }]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
def test6_logical_combined := [llvmfunc|
  llvm.func @test6_logical(%arg0: i1) -> i1 {
    llvm.return %arg0 : i1
  }]

theorem inst_combine_test6_logical   : test6_logical_before  ⊑  test6_logical_combined := by
  unfold test6_logical_before test6_logical_combined
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
  llvm.func @test8(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_test8   : test8_before  ⊑  test8_combined := by
  unfold test8_before test8_combined
  simp_alive_peephole
  sorry
def test9_combined := [llvmfunc|
  llvm.func @test9(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_test9   : test9_before  ⊑  test9_combined := by
  unfold test9_before test9_combined
  simp_alive_peephole
  sorry
def test9a_combined := [llvmfunc|
  llvm.func @test9a(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_test9a   : test9a_before  ⊑  test9a_combined := by
  unfold test9a_before test9a_combined
  simp_alive_peephole
  sorry
def test10_combined := [llvmfunc|
  llvm.func @test10(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test10   : test10_before  ⊑  test10_combined := by
  unfold test10_before test10_combined
  simp_alive_peephole
  sorry
def test11_combined := [llvmfunc|
  llvm.func @test11(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(-4 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.xor %3, %1  : i32
    llvm.store %4, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return %2 : i32
  }]

theorem inst_combine_test11   : test11_before  ⊑  test11_combined := by
  unfold test11_before test11_combined
  simp_alive_peephole
  sorry
def test12_combined := [llvmfunc|
  llvm.func @test12(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i32
    llvm.return %0 : i1
  }]

theorem inst_combine_test12   : test12_before  ⊑  test12_combined := by
  unfold test12_before test12_combined
  simp_alive_peephole
  sorry
def test12_logical_combined := [llvmfunc|
  llvm.func @test12_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i32
    llvm.return %0 : i1
  }]

theorem inst_combine_test12_logical   : test12_logical_before  ⊑  test12_logical_combined := by
  unfold test12_logical_before test12_logical_combined
  simp_alive_peephole
  sorry
def test13_combined := [llvmfunc|
  llvm.func @test13(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test13   : test13_before  ⊑  test13_combined := by
  unfold test13_before test13_combined
  simp_alive_peephole
  sorry
def test13_logical_combined := [llvmfunc|
  llvm.func @test13_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test13_logical   : test13_logical_before  ⊑  test13_logical_combined := by
  unfold test13_logical_before test13_logical_combined
  simp_alive_peephole
  sorry
def test14_combined := [llvmfunc|
  llvm.func @test14(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_test14   : test14_before  ⊑  test14_combined := by
  unfold test14_before test14_combined
  simp_alive_peephole
  sorry
def test15_combined := [llvmfunc|
  llvm.func @test15(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_test15   : test15_before  ⊑  test15_combined := by
  unfold test15_before test15_combined
  simp_alive_peephole
  sorry
def test16_combined := [llvmfunc|
  llvm.func @test16(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_test16   : test16_before  ⊑  test16_combined := by
  unfold test16_before test16_combined
  simp_alive_peephole
  sorry
def test18_combined := [llvmfunc|
  llvm.func @test18(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(127 : i32) : i32
    %1 = llvm.icmp "ugt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_test18   : test18_before  ⊑  test18_combined := by
  unfold test18_before test18_combined
  simp_alive_peephole
  sorry
def test18_vec_combined := [llvmfunc|
  llvm.func @test18_vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<127> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "ugt" %arg0, %0 : vector<2xi32>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_test18_vec   : test18_vec_before  ⊑  test18_vec_combined := by
  unfold test18_vec_before test18_vec_combined
  simp_alive_peephole
  sorry
def test18a_combined := [llvmfunc|
  llvm.func @test18a(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.icmp "ult" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_test18a   : test18a_before  ⊑  test18a_combined := by
  unfold test18a_before test18a_combined
  simp_alive_peephole
  sorry
def test18a_vec_combined := [llvmfunc|
  llvm.func @test18a_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "ult" %arg0, %0 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_test18a_vec   : test18a_vec_before  ⊑  test18a_vec_combined := by
  unfold test18a_vec_before test18a_vec_combined
  simp_alive_peephole
  sorry
def test19_combined := [llvmfunc|
  llvm.func @test19(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.shl %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test19   : test19_before  ⊑  test19_combined := by
  unfold test19_before test19_combined
  simp_alive_peephole
  sorry
def test20_combined := [llvmfunc|
  llvm.func @test20(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.lshr %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_test20   : test20_before  ⊑  test20_combined := by
  unfold test20_before test20_combined
  simp_alive_peephole
  sorry
def test23_combined := [llvmfunc|
  llvm.func @test23(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_test23   : test23_before  ⊑  test23_combined := by
  unfold test23_before test23_combined
  simp_alive_peephole
  sorry
def test23_logical_combined := [llvmfunc|
  llvm.func @test23_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_test23_logical   : test23_logical_before  ⊑  test23_logical_combined := by
  unfold test23_logical_before test23_logical_combined
  simp_alive_peephole
  sorry
def test23vec_combined := [llvmfunc|
  llvm.func @test23vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "eq" %arg0, %0 : vector<2xi32>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_test23vec   : test23vec_before  ⊑  test23vec_combined := by
  unfold test23vec_before test23vec_combined
  simp_alive_peephole
  sorry
def test24_combined := [llvmfunc|
  llvm.func @test24(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_test24   : test24_before  ⊑  test24_combined := by
  unfold test24_before test24_combined
  simp_alive_peephole
  sorry
def test24_logical_combined := [llvmfunc|
  llvm.func @test24_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_test24_logical   : test24_logical_before  ⊑  test24_logical_combined := by
  unfold test24_logical_before test24_logical_combined
  simp_alive_peephole
  sorry
def test25_combined := [llvmfunc|
  llvm.func @test25(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-50 : i32) : i32
    %1 = llvm.mlir.constant(50 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_test25   : test25_before  ⊑  test25_combined := by
  unfold test25_before test25_combined
  simp_alive_peephole
  sorry
def test25_logical_combined := [llvmfunc|
  llvm.func @test25_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-50 : i32) : i32
    %1 = llvm.mlir.constant(50 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_test25_logical   : test25_logical_before  ⊑  test25_logical_combined := by
  unfold test25_logical_before test25_logical_combined
  simp_alive_peephole
  sorry
def test25vec_combined := [llvmfunc|
  llvm.func @test25vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-50> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<50> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %arg0, %0  : vector<2xi32>
    %3 = llvm.icmp "ult" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_test25vec   : test25vec_before  ⊑  test25vec_combined := by
  unfold test25vec_before test25vec_combined
  simp_alive_peephole
  sorry
def test27_combined := [llvmfunc|
  llvm.func @test27(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_test27   : test27_before  ⊑  test27_combined := by
  unfold test27_before test27_combined
  simp_alive_peephole
  sorry
def ashr_lowmask_combined := [llvmfunc|
  llvm.func @ashr_lowmask(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_ashr_lowmask   : ashr_lowmask_before  ⊑  ashr_lowmask_combined := by
  unfold ashr_lowmask_before ashr_lowmask_combined
  simp_alive_peephole
  sorry
def ashr_lowmask_use_combined := [llvmfunc|
  llvm.func @ashr_lowmask_use(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.ashr %arg0, %0  : i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.lshr %arg0, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_ashr_lowmask_use   : ashr_lowmask_use_before  ⊑  ashr_lowmask_use_combined := by
  unfold ashr_lowmask_use_before ashr_lowmask_use_combined
  simp_alive_peephole
  sorry
def ashr_lowmask_use_splat_combined := [llvmfunc|
  llvm.func @ashr_lowmask_use_splat(%arg0: vector<2xi8>, %arg1: !llvm.ptr) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.ashr %arg0, %0  : vector<2xi8>
    llvm.store %1, %arg1 {alignment = 2 : i64} : vector<2xi8>, !llvm.ptr
    %2 = llvm.lshr %arg0, %0  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

theorem inst_combine_ashr_lowmask_use_splat   : ashr_lowmask_use_splat_before  ⊑  ashr_lowmask_use_splat_combined := by
  unfold ashr_lowmask_use_splat_before ashr_lowmask_use_splat_combined
  simp_alive_peephole
  sorry
def ashr_not_lowmask1_use_combined := [llvmfunc|
  llvm.func @ashr_not_lowmask1_use(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(254 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_ashr_not_lowmask1_use   : ashr_not_lowmask1_use_before  ⊑  ashr_not_lowmask1_use_combined := by
  unfold ashr_not_lowmask1_use_before ashr_not_lowmask1_use_combined
  simp_alive_peephole
  sorry
def ashr_not_lowmask2_use_combined := [llvmfunc|
  llvm.func @ashr_not_lowmask2_use(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(127 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_ashr_not_lowmask2_use   : ashr_not_lowmask2_use_before  ⊑  ashr_not_lowmask2_use_combined := by
  unfold ashr_not_lowmask2_use_before ashr_not_lowmask2_use_combined
  simp_alive_peephole
  sorry
def ashr_not_lowmask3_use_combined := [llvmfunc|
  llvm.func @ashr_not_lowmask3_use(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(511 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_ashr_not_lowmask3_use   : ashr_not_lowmask3_use_before  ⊑  ashr_not_lowmask3_use_combined := by
  unfold ashr_not_lowmask3_use_before ashr_not_lowmask3_use_combined
  simp_alive_peephole
  sorry
def test29_combined := [llvmfunc|
  llvm.func @test29(%arg0: i8) -> i32 {
    %0 = llvm.zext %arg0 : i8 to i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test29   : test29_before  ⊑  test29_combined := by
  unfold test29_before test29_combined
  simp_alive_peephole
  sorry
def test30_combined := [llvmfunc|
  llvm.func @test30(%arg0: i1) -> i32 {
    %0 = llvm.zext %arg0 : i1 to i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test30   : test30_before  ⊑  test30_combined := by
  unfold test30_before test30_combined
  simp_alive_peephole
  sorry
def test31_combined := [llvmfunc|
  llvm.func @test31(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.select %arg0, %0, %1 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test31   : test31_before  ⊑  test31_combined := by
  unfold test31_before test31_combined
  simp_alive_peephole
  sorry
def and_demanded_bits_splat_vec_combined := [llvmfunc|
  llvm.func @and_demanded_bits_splat_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.and %arg0, %0  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_and_demanded_bits_splat_vec   : and_demanded_bits_splat_vec_before  ⊑  and_demanded_bits_splat_vec_combined := by
  unfold and_demanded_bits_splat_vec_before and_demanded_bits_splat_vec_combined
  simp_alive_peephole
  sorry
def and_zext_demanded_combined := [llvmfunc|
  llvm.func @and_zext_demanded(%arg0: i16, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.lshr %arg0, %0  : i16
    %2 = llvm.zext %1 : i16 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_and_zext_demanded   : and_zext_demanded_before  ⊑  and_zext_demanded_combined := by
  unfold and_zext_demanded_before and_zext_demanded_combined
  simp_alive_peephole
  sorry
def test32_combined := [llvmfunc|
  llvm.func @test32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test32   : test32_before  ⊑  test32_combined := by
  unfold test32_before test32_combined
  simp_alive_peephole
  sorry
def test33_combined := [llvmfunc|
  llvm.func @test33(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test33   : test33_before  ⊑  test33_combined := by
  unfold test33_before test33_combined
  simp_alive_peephole
  sorry
def test33b_combined := [llvmfunc|
  llvm.func @test33b(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test33b   : test33b_before  ⊑  test33b_combined := by
  unfold test33b_before test33b_combined
  simp_alive_peephole
  sorry
def test33vec_combined := [llvmfunc|
  llvm.func @test33vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.xor %arg0, %0  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_test33vec   : test33vec_before  ⊑  test33vec_combined := by
  unfold test33vec_before test33vec_combined
  simp_alive_peephole
  sorry
def test33vecb_combined := [llvmfunc|
  llvm.func @test33vecb(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.xor %arg0, %0  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_test33vecb   : test33vecb_before  ⊑  test33vecb_combined := by
  unfold test33vecb_before test33vecb_combined
  simp_alive_peephole
  sorry
def test34_combined := [llvmfunc|
  llvm.func @test34(%arg0: i32, %arg1: i32) -> i32 {
    llvm.return %arg1 : i32
  }]

theorem inst_combine_test34   : test34_before  ⊑  test34_combined := by
  unfold test34_before test34_combined
  simp_alive_peephole
  sorry
def PR24942_combined := [llvmfunc|
  llvm.func @PR24942(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_PR24942   : PR24942_before  ⊑  PR24942_combined := by
  unfold PR24942_before PR24942_combined
  simp_alive_peephole
  sorry
def test35_combined := [llvmfunc|
  llvm.func @test35(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(240 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.zext %3 : i32 to i64
    llvm.return %4 : i64
  }]

theorem inst_combine_test35   : test35_before  ⊑  test35_combined := by
  unfold test35_before test35_combined
  simp_alive_peephole
  sorry
def test35_uniform_combined := [llvmfunc|
  llvm.func @test35_uniform(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<240> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.sub %1, %arg0  : vector<2xi32>
    %4 = llvm.and %3, %2  : vector<2xi32>
    %5 = llvm.zext %4 : vector<2xi32> to vector<2xi64>
    llvm.return %5 : vector<2xi64>
  }]

theorem inst_combine_test35_uniform   : test35_uniform_before  ⊑  test35_uniform_combined := by
  unfold test35_uniform_before test35_uniform_combined
  simp_alive_peephole
  sorry
def test36_combined := [llvmfunc|
  llvm.func @test36(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(240 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.zext %3 : i32 to i64
    llvm.return %4 : i64
  }]

theorem inst_combine_test36   : test36_before  ⊑  test36_combined := by
  unfold test36_before test36_combined
  simp_alive_peephole
  sorry
def test36_uniform_combined := [llvmfunc|
  llvm.func @test36_uniform(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<240> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %arg0, %0  : vector<2xi32>
    %3 = llvm.and %2, %1  : vector<2xi32>
    %4 = llvm.zext %3 : vector<2xi32> to vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

theorem inst_combine_test36_uniform   : test36_uniform_before  ⊑  test36_uniform_combined := by
  unfold test36_uniform_before test36_uniform_combined
  simp_alive_peephole
  sorry
def test36_poison_combined := [llvmfunc|
  llvm.func @test36_poison(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.poison : i64
    %1 = llvm.mlir.constant(7 : i64) : i64
    %2 = llvm.mlir.undef : vector<2xi64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi64>
    %7 = llvm.mlir.constant(240 : i64) : i64
    %8 = llvm.mlir.undef : vector<2xi64>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %7, %8[%9 : i32] : vector<2xi64>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<2xi64>
    %13 = llvm.zext %arg0 : vector<2xi32> to vector<2xi64>
    %14 = llvm.add %13, %6 overflow<nsw, nuw>  : vector<2xi64>
    %15 = llvm.and %14, %12  : vector<2xi64>
    llvm.return %15 : vector<2xi64>
  }]

theorem inst_combine_test36_poison   : test36_poison_before  ⊑  test36_poison_combined := by
  unfold test36_poison_before test36_poison_combined
  simp_alive_peephole
  sorry
def test37_combined := [llvmfunc|
  llvm.func @test37(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(240 : i32) : i32
    %2 = llvm.mul %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.zext %3 : i32 to i64
    llvm.return %4 : i64
  }]

theorem inst_combine_test37   : test37_before  ⊑  test37_combined := by
  unfold test37_before test37_combined
  simp_alive_peephole
  sorry
def test37_uniform_combined := [llvmfunc|
  llvm.func @test37_uniform(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<240> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mul %arg0, %0  : vector<2xi32>
    %3 = llvm.and %2, %1  : vector<2xi32>
    %4 = llvm.zext %3 : vector<2xi32> to vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

theorem inst_combine_test37_uniform   : test37_uniform_before  ⊑  test37_uniform_combined := by
  unfold test37_uniform_before test37_uniform_combined
  simp_alive_peephole
  sorry
def test37_nonuniform_combined := [llvmfunc|
  llvm.func @test37_nonuniform(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[7, 9]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<[240, 110]> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.zext %arg0 : vector<2xi32> to vector<2xi64>
    %3 = llvm.mul %2, %0 overflow<nsw, nuw>  : vector<2xi64>
    %4 = llvm.and %3, %1  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

theorem inst_combine_test37_nonuniform   : test37_nonuniform_before  ⊑  test37_nonuniform_combined := by
  unfold test37_nonuniform_before test37_nonuniform_combined
  simp_alive_peephole
  sorry
def test38_combined := [llvmfunc|
  llvm.func @test38(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(240 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.zext %1 : i32 to i64
    llvm.return %2 : i64
  }]

theorem inst_combine_test38   : test38_before  ⊑  test38_combined := by
  unfold test38_before test38_combined
  simp_alive_peephole
  sorry
def test39_combined := [llvmfunc|
  llvm.func @test39(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(240 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.zext %1 : i32 to i64
    llvm.return %2 : i64
  }]

theorem inst_combine_test39   : test39_before  ⊑  test39_combined := by
  unfold test39_before test39_combined
  simp_alive_peephole
  sorry
def lowmask_add_zext_combined := [llvmfunc|
  llvm.func @lowmask_add_zext(%arg0: i8, %arg1: i32) -> i32 {
    %0 = llvm.trunc %arg1 : i32 to i8
    %1 = llvm.add %0, %arg0  : i8
    %2 = llvm.zext %1 : i8 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_lowmask_add_zext   : lowmask_add_zext_before  ⊑  lowmask_add_zext_combined := by
  unfold lowmask_add_zext_before lowmask_add_zext_combined
  simp_alive_peephole
  sorry
def lowmask_add_zext_commute_combined := [llvmfunc|
  llvm.func @lowmask_add_zext_commute(%arg0: i16, %arg1: i32) -> i32 {
    %0 = llvm.mul %arg1, %arg1  : i32
    %1 = llvm.trunc %0 : i32 to i16
    %2 = llvm.add %1, %arg0  : i16
    %3 = llvm.zext %2 : i16 to i32
    llvm.return %3 : i32
  }]

theorem inst_combine_lowmask_add_zext_commute   : lowmask_add_zext_commute_before  ⊑  lowmask_add_zext_commute_combined := by
  unfold lowmask_add_zext_commute_before lowmask_add_zext_commute_combined
  simp_alive_peephole
  sorry
def lowmask_add_zext_wrong_mask_combined := [llvmfunc|
  llvm.func @lowmask_add_zext_wrong_mask(%arg0: i8, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(511 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.add %1, %arg1  : i32
    %3 = llvm.and %2, %0  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_lowmask_add_zext_wrong_mask   : lowmask_add_zext_wrong_mask_before  ⊑  lowmask_add_zext_wrong_mask_combined := by
  unfold lowmask_add_zext_wrong_mask_before lowmask_add_zext_wrong_mask_combined
  simp_alive_peephole
  sorry
def lowmask_add_zext_use1_combined := [llvmfunc|
  llvm.func @lowmask_add_zext_use1(%arg0: i8, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.add %1, %arg1  : i32
    %3 = llvm.and %2, %0  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_lowmask_add_zext_use1   : lowmask_add_zext_use1_before  ⊑  lowmask_add_zext_use1_combined := by
  unfold lowmask_add_zext_use1_before lowmask_add_zext_use1_combined
  simp_alive_peephole
  sorry
def lowmask_add_zext_use2_combined := [llvmfunc|
  llvm.func @lowmask_add_zext_use2(%arg0: i8, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.add %1, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.and %2, %0  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_lowmask_add_zext_use2   : lowmask_add_zext_use2_before  ⊑  lowmask_add_zext_use2_combined := by
  unfold lowmask_add_zext_use2_before lowmask_add_zext_use2_combined
  simp_alive_peephole
  sorry
def lowmask_sub_zext_combined := [llvmfunc|
  llvm.func @lowmask_sub_zext(%arg0: vector<2xi4>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.trunc %arg1 : vector<2xi32> to vector<2xi4>
    %1 = llvm.sub %arg0, %0  : vector<2xi4>
    %2 = llvm.zext %1 : vector<2xi4> to vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_lowmask_sub_zext   : lowmask_sub_zext_before  ⊑  lowmask_sub_zext_combined := by
  unfold lowmask_sub_zext_before lowmask_sub_zext_combined
  simp_alive_peephole
  sorry
def lowmask_sub_zext_commute_combined := [llvmfunc|
  llvm.func @lowmask_sub_zext_commute(%arg0: i5, %arg1: i17) -> i17 {
    %0 = llvm.trunc %arg1 : i17 to i5
    %1 = llvm.sub %0, %arg0  : i5
    %2 = llvm.zext %1 : i5 to i17
    llvm.return %2 : i17
  }]

theorem inst_combine_lowmask_sub_zext_commute   : lowmask_sub_zext_commute_before  ⊑  lowmask_sub_zext_commute_combined := by
  unfold lowmask_sub_zext_commute_before lowmask_sub_zext_commute_combined
  simp_alive_peephole
  sorry
def lowmask_mul_zext_combined := [llvmfunc|
  llvm.func @lowmask_mul_zext(%arg0: i8, %arg1: i32) -> i32 {
    %0 = llvm.trunc %arg1 : i32 to i8
    %1 = llvm.mul %0, %arg0  : i8
    %2 = llvm.zext %1 : i8 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_lowmask_mul_zext   : lowmask_mul_zext_before  ⊑  lowmask_mul_zext_combined := by
  unfold lowmask_mul_zext_before lowmask_mul_zext_combined
  simp_alive_peephole
  sorry
def lowmask_xor_zext_commute_combined := [llvmfunc|
  llvm.func @lowmask_xor_zext_commute(%arg0: i8, %arg1: i32) -> i32 {
    %0 = llvm.mul %arg1, %arg1  : i32
    %1 = llvm.trunc %0 : i32 to i8
    %2 = llvm.xor %1, %arg0  : i8
    %3 = llvm.zext %2 : i8 to i32
    llvm.return %3 : i32
  }]

theorem inst_combine_lowmask_xor_zext_commute   : lowmask_xor_zext_commute_before  ⊑  lowmask_xor_zext_commute_combined := by
  unfold lowmask_xor_zext_commute_before lowmask_xor_zext_commute_combined
  simp_alive_peephole
  sorry
def lowmask_or_zext_commute_combined := [llvmfunc|
  llvm.func @lowmask_or_zext_commute(%arg0: i16, %arg1: i24) -> i24 {
    %0 = llvm.trunc %arg1 : i24 to i16
    %1 = llvm.or %0, %arg0  : i16
    %2 = llvm.zext %1 : i16 to i24
    llvm.return %2 : i24
  }]

theorem inst_combine_lowmask_or_zext_commute   : lowmask_or_zext_commute_before  ⊑  lowmask_or_zext_commute_combined := by
  unfold lowmask_or_zext_commute_before lowmask_or_zext_commute_combined
  simp_alive_peephole
  sorry
def test40_combined := [llvmfunc|
  llvm.func @test40(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(104 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.select %arg0, %0, %1 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test40   : test40_before  ⊑  test40_combined := by
  unfold test40_before test40_combined
  simp_alive_peephole
  sorry
def test40vec_combined := [llvmfunc|
  llvm.func @test40vec(%arg0: i1) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<104> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<10> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.select %arg0, %0, %1 : i1, vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_test40vec   : test40vec_before  ⊑  test40vec_combined := by
  unfold test40vec_before test40vec_combined
  simp_alive_peephole
  sorry
def test40vec2_combined := [llvmfunc|
  llvm.func @test40vec2(%arg0: i1) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[104, 324]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[10, 12]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.select %arg0, %0, %1 : i1, vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_test40vec2   : test40vec2_before  ⊑  test40vec2_combined := by
  unfold test40vec2_before test40vec2_combined
  simp_alive_peephole
  sorry
def test41_combined := [llvmfunc|
  llvm.func @test41(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(104 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    llvm.cond_br %arg0, ^bb2(%0 : i32), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%1 : i32)
  ^bb2(%2: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : i32
  }]

theorem inst_combine_test41   : test41_before  ⊑  test41_combined := by
  unfold test41_before test41_combined
  simp_alive_peephole
  sorry
def test41vec_combined := [llvmfunc|
  llvm.func @test41vec(%arg0: i1) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<104> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<10> : vector<2xi32>) : vector<2xi32>
    llvm.cond_br %arg0, ^bb2(%0 : vector<2xi32>), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%1 : vector<2xi32>)
  ^bb2(%2: vector<2xi32>):  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_test41vec   : test41vec_before  ⊑  test41vec_combined := by
  unfold test41vec_before test41vec_combined
  simp_alive_peephole
  sorry
def test41vec2_combined := [llvmfunc|
  llvm.func @test41vec2(%arg0: i1) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[104, 324]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[10, 12]> : vector<2xi32>) : vector<2xi32>
    llvm.cond_br %arg0, ^bb2(%0 : vector<2xi32>), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%1 : vector<2xi32>)
  ^bb2(%2: vector<2xi32>):  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_test41vec2   : test41vec2_before  ⊑  test41vec2_combined := by
  unfold test41vec2_before test41vec2_combined
  simp_alive_peephole
  sorry
def test42_combined := [llvmfunc|
  llvm.func @test42(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mul %arg1, %arg2  : i32
    %1 = llvm.and %0, %arg0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test42   : test42_before  ⊑  test42_combined := by
  unfold test42_before test42_combined
  simp_alive_peephole
  sorry
def test43_combined := [llvmfunc|
  llvm.func @test43(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mul %arg1, %arg2  : i32
    %1 = llvm.and %0, %arg0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test43   : test43_before  ⊑  test43_combined := by
  unfold test43_before test43_combined
  simp_alive_peephole
  sorry
def test44_combined := [llvmfunc|
  llvm.func @test44(%arg0: i32, %arg1: i32) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.and %arg0, %arg1  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test44   : test44_before  ⊑  test44_combined := by
  unfold test44_before test44_combined
  simp_alive_peephole
  sorry
def test45_combined := [llvmfunc|
  llvm.func @test45(%arg0: i32, %arg1: i32) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.and %arg0, %arg1  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test45   : test45_before  ⊑  test45_combined := by
  unfold test45_before test45_combined
  simp_alive_peephole
  sorry
def test46_combined := [llvmfunc|
  llvm.func @test46(%arg0: i32, %arg1: i32) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.and %arg0, %arg1  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test46   : test46_before  ⊑  test46_combined := by
  unfold test46_before test46_combined
  simp_alive_peephole
  sorry
def test47_combined := [llvmfunc|
  llvm.func @test47(%arg0: i32, %arg1: i32) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.and %arg0, %arg1  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test47   : test47_before  ⊑  test47_combined := by
  unfold test47_before test47_combined
  simp_alive_peephole
  sorry
def and_orn_cmp_1_combined := [llvmfunc|
  llvm.func @and_orn_cmp_1(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i32
    %2 = llvm.icmp "ugt" %arg2, %0 : i32
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_and_orn_cmp_1   : and_orn_cmp_1_before  ⊑  and_orn_cmp_1_combined := by
  unfold and_orn_cmp_1_before and_orn_cmp_1_combined
  simp_alive_peephole
  sorry
def and_orn_cmp_1_logical_combined := [llvmfunc|
  llvm.func @and_orn_cmp_1_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "sgt" %arg0, %arg1 : i32
    %3 = llvm.icmp "ugt" %arg2, %0 : i32
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_and_orn_cmp_1_logical   : and_orn_cmp_1_logical_before  ⊑  and_orn_cmp_1_logical_combined := by
  unfold and_orn_cmp_1_logical_before and_orn_cmp_1_logical_combined
  simp_alive_peephole
  sorry
def and_orn_cmp_2_combined := [llvmfunc|
  llvm.func @and_orn_cmp_2(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[42, 47]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "sge" %arg0, %arg1 : vector<2xi32>
    %2 = llvm.icmp "ugt" %arg2, %0 : vector<2xi32>
    %3 = llvm.and %2, %1  : vector<2xi1>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_and_orn_cmp_2   : and_orn_cmp_2_before  ⊑  and_orn_cmp_2_combined := by
  unfold and_orn_cmp_2_before and_orn_cmp_2_combined
  simp_alive_peephole
  sorry
def and_orn_cmp_3_combined := [llvmfunc|
  llvm.func @and_orn_cmp_3(%arg0: i72, %arg1: i72, %arg2: i72) -> i1 {
    %0 = llvm.mlir.constant(42 : i72) : i72
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i72
    %2 = llvm.icmp "ugt" %arg2, %0 : i72
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_and_orn_cmp_3   : and_orn_cmp_3_before  ⊑  and_orn_cmp_3_combined := by
  unfold and_orn_cmp_3_before and_orn_cmp_3_combined
  simp_alive_peephole
  sorry
def and_orn_cmp_3_logical_combined := [llvmfunc|
  llvm.func @and_orn_cmp_3_logical(%arg0: i72, %arg1: i72, %arg2: i72) -> i1 {
    %0 = llvm.mlir.constant(42 : i72) : i72
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ugt" %arg0, %arg1 : i72
    %3 = llvm.icmp "ugt" %arg2, %0 : i72
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_and_orn_cmp_3_logical   : and_orn_cmp_3_logical_before  ⊑  and_orn_cmp_3_logical_combined := by
  unfold and_orn_cmp_3_logical_before and_orn_cmp_3_logical_combined
  simp_alive_peephole
  sorry
def or_andn_cmp_4_combined := [llvmfunc|
  llvm.func @or_andn_cmp_4(%arg0: vector<3xi32>, %arg1: vector<3xi32>, %arg2: vector<3xi32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(dense<[42, 43, -1]> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.icmp "eq" %arg0, %arg1 : vector<3xi32>
    %2 = llvm.icmp "ugt" %arg2, %0 : vector<3xi32>
    %3 = llvm.and %2, %1  : vector<3xi1>
    llvm.return %3 : vector<3xi1>
  }]

theorem inst_combine_or_andn_cmp_4   : or_andn_cmp_4_before  ⊑  or_andn_cmp_4_combined := by
  unfold or_andn_cmp_4_before or_andn_cmp_4_combined
  simp_alive_peephole
  sorry
def andn_or_cmp_1_combined := [llvmfunc|
  llvm.func @andn_or_cmp_1(%arg0: i37, %arg1: i37, %arg2: i37) -> i1 {
    %0 = llvm.mlir.constant(42 : i37) : i37
    %1 = llvm.icmp "sle" %arg0, %arg1 : i37
    %2 = llvm.icmp "ugt" %arg2, %0 : i37
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_andn_or_cmp_1   : andn_or_cmp_1_before  ⊑  andn_or_cmp_1_combined := by
  unfold andn_or_cmp_1_before andn_or_cmp_1_combined
  simp_alive_peephole
  sorry
def andn_or_cmp_1_logical_combined := [llvmfunc|
  llvm.func @andn_or_cmp_1_logical(%arg0: i37, %arg1: i37, %arg2: i37) -> i1 {
    %0 = llvm.mlir.constant(42 : i37) : i37
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "sle" %arg0, %arg1 : i37
    %3 = llvm.icmp "ugt" %arg2, %0 : i37
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_andn_or_cmp_1_logical   : andn_or_cmp_1_logical_before  ⊑  andn_or_cmp_1_logical_combined := by
  unfold andn_or_cmp_1_logical_before andn_or_cmp_1_logical_combined
  simp_alive_peephole
  sorry
def andn_or_cmp_2_combined := [llvmfunc|
  llvm.func @andn_or_cmp_2(%arg0: i16, %arg1: i16, %arg2: i16) -> i1 {
    %0 = llvm.mlir.constant(42 : i16) : i16
    %1 = llvm.icmp "slt" %arg0, %arg1 : i16
    %2 = llvm.icmp "ugt" %arg2, %0 : i16
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_andn_or_cmp_2   : andn_or_cmp_2_before  ⊑  andn_or_cmp_2_combined := by
  unfold andn_or_cmp_2_before andn_or_cmp_2_combined
  simp_alive_peephole
  sorry
def andn_or_cmp_2_logical_combined := [llvmfunc|
  llvm.func @andn_or_cmp_2_logical(%arg0: i16, %arg1: i16, %arg2: i16) -> i1 {
    %0 = llvm.mlir.constant(42 : i16) : i16
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "slt" %arg0, %arg1 : i16
    %3 = llvm.icmp "ugt" %arg2, %0 : i16
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_andn_or_cmp_2_logical   : andn_or_cmp_2_logical_before  ⊑  andn_or_cmp_2_logical_combined := by
  unfold andn_or_cmp_2_logical_before andn_or_cmp_2_logical_combined
  simp_alive_peephole
  sorry
def andn_or_cmp_3_combined := [llvmfunc|
  llvm.func @andn_or_cmp_3(%arg0: vector<4xi32>, %arg1: vector<4xi32>, %arg2: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<[42, 0, 1, -1]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.icmp "ule" %arg0, %arg1 : vector<4xi32>
    %2 = llvm.icmp "ugt" %arg2, %0 : vector<4xi32>
    %3 = llvm.and %1, %2  : vector<4xi1>
    llvm.return %3 : vector<4xi1>
  }]

theorem inst_combine_andn_or_cmp_3   : andn_or_cmp_3_before  ⊑  andn_or_cmp_3_combined := by
  unfold andn_or_cmp_3_before andn_or_cmp_3_combined
  simp_alive_peephole
  sorry
def andn_or_cmp_4_combined := [llvmfunc|
  llvm.func @andn_or_cmp_4(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %arg1 : i32
    %2 = llvm.icmp "ugt" %arg2, %0 : i32
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_andn_or_cmp_4   : andn_or_cmp_4_before  ⊑  andn_or_cmp_4_combined := by
  unfold andn_or_cmp_4_before andn_or_cmp_4_combined
  simp_alive_peephole
  sorry
def andn_or_cmp_4_logical_combined := [llvmfunc|
  llvm.func @andn_or_cmp_4_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ne" %arg0, %arg1 : i32
    %3 = llvm.icmp "ugt" %arg2, %0 : i32
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_andn_or_cmp_4_logical   : andn_or_cmp_4_logical_before  ⊑  andn_or_cmp_4_logical_combined := by
  unfold andn_or_cmp_4_logical_before andn_or_cmp_4_logical_combined
  simp_alive_peephole
  sorry
def lowbitmask_casted_shift_combined := [llvmfunc|
  llvm.func @lowbitmask_casted_shift(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.lshr %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_lowbitmask_casted_shift   : lowbitmask_casted_shift_before  ⊑  lowbitmask_casted_shift_combined := by
  unfold lowbitmask_casted_shift_before lowbitmask_casted_shift_combined
  simp_alive_peephole
  sorry
def lowbitmask_casted_shift_wrong_mask1_combined := [llvmfunc|
  llvm.func @lowbitmask_casted_shift_wrong_mask1(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(2147483647 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.sext %2 : i8 to i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_lowbitmask_casted_shift_wrong_mask1   : lowbitmask_casted_shift_wrong_mask1_before  ⊑  lowbitmask_casted_shift_wrong_mask1_combined := by
  unfold lowbitmask_casted_shift_wrong_mask1_before lowbitmask_casted_shift_wrong_mask1_combined
  simp_alive_peephole
  sorry
def lowbitmask_casted_shift_wrong_mask2_combined := [llvmfunc|
  llvm.func @lowbitmask_casted_shift_wrong_mask2(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(536870911 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.sext %2 : i8 to i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_lowbitmask_casted_shift_wrong_mask2   : lowbitmask_casted_shift_wrong_mask2_before  ⊑  lowbitmask_casted_shift_wrong_mask2_combined := by
  unfold lowbitmask_casted_shift_wrong_mask2_before lowbitmask_casted_shift_wrong_mask2_combined
  simp_alive_peephole
  sorry
def lowbitmask_casted_shift_use1_combined := [llvmfunc|
  llvm.func @lowbitmask_casted_shift_use1(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sext %arg0 : i8 to i32
    %4 = llvm.lshr %3, %1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_lowbitmask_casted_shift_use1   : lowbitmask_casted_shift_use1_before  ⊑  lowbitmask_casted_shift_use1_combined := by
  unfold lowbitmask_casted_shift_use1_before lowbitmask_casted_shift_use1_combined
  simp_alive_peephole
  sorry
def lowbitmask_casted_shift_use2_combined := [llvmfunc|
  llvm.func @lowbitmask_casted_shift_use2(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(536870911 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.sext %2 : i8 to i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_lowbitmask_casted_shift_use2   : lowbitmask_casted_shift_use2_before  ⊑  lowbitmask_casted_shift_use2_combined := by
  unfold lowbitmask_casted_shift_use2_before lowbitmask_casted_shift_use2_combined
  simp_alive_peephole
  sorry
def lowbitmask_casted_shift_vec_splat_combined := [llvmfunc|
  llvm.func @lowbitmask_casted_shift_vec_splat(%arg0: vector<2xi47>) -> vector<2xi59> {
    %0 = llvm.mlir.constant(5 : i59) : i59
    %1 = llvm.mlir.constant(dense<5> : vector<2xi59>) : vector<2xi59>
    %2 = llvm.sext %arg0 : vector<2xi47> to vector<2xi59>
    %3 = llvm.lshr %2, %1  : vector<2xi59>
    llvm.return %3 : vector<2xi59>
  }]

theorem inst_combine_lowbitmask_casted_shift_vec_splat   : lowbitmask_casted_shift_vec_splat_before  ⊑  lowbitmask_casted_shift_vec_splat_combined := by
  unfold lowbitmask_casted_shift_vec_splat_before lowbitmask_casted_shift_vec_splat_combined
  simp_alive_peephole
  sorry
def lowmask_sext_in_reg_combined := [llvmfunc|
  llvm.func @lowmask_sext_in_reg(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(20 : i32) : i32
    %1 = llvm.mlir.constant(4095 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.ashr %2, %0  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.and %arg0, %1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_lowmask_sext_in_reg   : lowmask_sext_in_reg_before  ⊑  lowmask_sext_in_reg_combined := by
  unfold lowmask_sext_in_reg_before lowmask_sext_in_reg_combined
  simp_alive_peephole
  sorry
def lowmask_not_sext_in_reg_combined := [llvmfunc|
  llvm.func @lowmask_not_sext_in_reg(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(19 : i32) : i32
    %1 = llvm.mlir.constant(20 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.ashr %2, %1  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.lshr %2, %1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_lowmask_not_sext_in_reg   : lowmask_not_sext_in_reg_before  ⊑  lowmask_not_sext_in_reg_combined := by
  unfold lowmask_not_sext_in_reg_before lowmask_not_sext_in_reg_combined
  simp_alive_peephole
  sorry
def not_lowmask_sext_in_reg_combined := [llvmfunc|
  llvm.func @not_lowmask_sext_in_reg(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(20 : i32) : i32
    %1 = llvm.mlir.constant(4096 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.ashr %2, %0  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_not_lowmask_sext_in_reg   : not_lowmask_sext_in_reg_before  ⊑  not_lowmask_sext_in_reg_combined := by
  unfold not_lowmask_sext_in_reg_before not_lowmask_sext_in_reg_combined
  simp_alive_peephole
  sorry
def not_lowmask_sext_in_reg2_combined := [llvmfunc|
  llvm.func @not_lowmask_sext_in_reg2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(21 : i32) : i32
    %1 = llvm.mlir.constant(4095 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.ashr %2, %0  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_not_lowmask_sext_in_reg2   : not_lowmask_sext_in_reg2_before  ⊑  not_lowmask_sext_in_reg2_combined := by
  unfold not_lowmask_sext_in_reg2_before not_lowmask_sext_in_reg2_combined
  simp_alive_peephole
  sorry
def lowmask_sext_in_reg_splat_combined := [llvmfunc|
  llvm.func @lowmask_sext_in_reg_splat(%arg0: vector<2xi32>, %arg1: !llvm.ptr) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<20> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<4095> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.shl %arg0, %0  : vector<2xi32>
    %3 = llvm.ashr %2, %0  : vector<2xi32>
    llvm.store %3, %arg1 {alignment = 8 : i64} : vector<2xi32>, !llvm.ptr
    %4 = llvm.and %arg0, %1  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

theorem inst_combine_lowmask_sext_in_reg_splat   : lowmask_sext_in_reg_splat_before  ⊑  lowmask_sext_in_reg_splat_combined := by
  unfold lowmask_sext_in_reg_splat_before lowmask_sext_in_reg_splat_combined
  simp_alive_peephole
  sorry
def lowmask_add_combined := [llvmfunc|
  llvm.func @lowmask_add(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-64 : i8) : i8
    %1 = llvm.mlir.constant(32 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.and %arg0, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_lowmask_add   : lowmask_add_before  ⊑  lowmask_add_combined := by
  unfold lowmask_add_before lowmask_add_combined
  simp_alive_peephole
  sorry
def lowmask_add_2_combined := [llvmfunc|
  llvm.func @lowmask_add_2(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(63 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_lowmask_add_2   : lowmask_add_2_before  ⊑  lowmask_add_2_combined := by
  unfold lowmask_add_2_before lowmask_add_2_combined
  simp_alive_peephole
  sorry
def lowmask_add_2_uses_combined := [llvmfunc|
  llvm.func @lowmask_add_2_uses(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-64 : i8) : i8
    %1 = llvm.mlir.constant(63 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.and %arg0, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_lowmask_add_2_uses   : lowmask_add_2_uses_before  ⊑  lowmask_add_2_uses_combined := by
  unfold lowmask_add_2_uses_before lowmask_add_2_uses_combined
  simp_alive_peephole
  sorry
def lowmask_add_2_splat_combined := [llvmfunc|
  llvm.func @lowmask_add_2_splat(%arg0: vector<2xi8>, %arg1: !llvm.ptr) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-64> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<63> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0  : vector<2xi8>
    llvm.store %2, %arg1 {alignment = 2 : i64} : vector<2xi8>, !llvm.ptr
    %3 = llvm.and %arg0, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_lowmask_add_2_splat   : lowmask_add_2_splat_before  ⊑  lowmask_add_2_splat_combined := by
  unfold lowmask_add_2_splat_before lowmask_add_2_splat_combined
  simp_alive_peephole
  sorry
def not_lowmask_add_combined := [llvmfunc|
  llvm.func @not_lowmask_add(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-64 : i8) : i8
    %1 = llvm.mlir.constant(64 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.and %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_not_lowmask_add   : not_lowmask_add_before  ⊑  not_lowmask_add_combined := by
  unfold not_lowmask_add_before not_lowmask_add_combined
  simp_alive_peephole
  sorry
def not_lowmask_add2_combined := [llvmfunc|
  llvm.func @not_lowmask_add2(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-96 : i8) : i8
    %1 = llvm.mlir.constant(63 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.and %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_not_lowmask_add2   : not_lowmask_add2_before  ⊑  not_lowmask_add2_combined := by
  unfold not_lowmask_add2_before not_lowmask_add2_combined
  simp_alive_peephole
  sorry
def lowmask_add_splat_combined := [llvmfunc|
  llvm.func @lowmask_add_splat(%arg0: vector<2xi8>, %arg1: !llvm.ptr) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-64> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<32> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0  : vector<2xi8>
    llvm.store %2, %arg1 {alignment = 2 : i64} : vector<2xi8>, !llvm.ptr
    %3 = llvm.and %arg0, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_lowmask_add_splat   : lowmask_add_splat_before  ⊑  lowmask_add_splat_combined := by
  unfold lowmask_add_splat_before lowmask_add_splat_combined
  simp_alive_peephole
  sorry
def lowmask_add_splat_poison_combined := [llvmfunc|
  llvm.func @lowmask_add_splat_poison(%arg0: vector<2xi8>, %arg1: !llvm.ptr) -> vector<2xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(-64 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(32 : i8) : i8
    %8 = llvm.mlir.undef : vector<2xi8>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<2xi8>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %7, %10[%11 : i32] : vector<2xi8>
    %13 = llvm.add %arg0, %6  : vector<2xi8>
    llvm.store %13, %arg1 {alignment = 2 : i64} : vector<2xi8>, !llvm.ptr
    %14 = llvm.and %arg0, %12  : vector<2xi8>
    llvm.return %14 : vector<2xi8>
  }]

theorem inst_combine_lowmask_add_splat_poison   : lowmask_add_splat_poison_before  ⊑  lowmask_add_splat_poison_combined := by
  unfold lowmask_add_splat_poison_before lowmask_add_splat_poison_combined
  simp_alive_peephole
  sorry
def lowmask_add_vec_combined := [llvmfunc|
  llvm.func @lowmask_add_vec(%arg0: vector<2xi8>, %arg1: !llvm.ptr) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[-96, -64]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[16, 32]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0  : vector<2xi8>
    llvm.store %2, %arg1 {alignment = 2 : i64} : vector<2xi8>, !llvm.ptr
    %3 = llvm.and %2, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_lowmask_add_vec   : lowmask_add_vec_before  ⊑  lowmask_add_vec_combined := by
  unfold lowmask_add_vec_before lowmask_add_vec_combined
  simp_alive_peephole
  sorry
def flip_masked_bit_combined := [llvmfunc|
  llvm.func @flip_masked_bit(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.xor %1, %0  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_flip_masked_bit   : flip_masked_bit_before  ⊑  flip_masked_bit_combined := by
  unfold flip_masked_bit_before flip_masked_bit_combined
  simp_alive_peephole
  sorry
def flip_masked_bit_uniform_combined := [llvmfunc|
  llvm.func @flip_masked_bit_uniform(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.and %arg0, %0  : vector<2xi8>
    %2 = llvm.xor %1, %0  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

theorem inst_combine_flip_masked_bit_uniform   : flip_masked_bit_uniform_before  ⊑  flip_masked_bit_uniform_combined := by
  unfold flip_masked_bit_uniform_before flip_masked_bit_uniform_combined
  simp_alive_peephole
  sorry
def flip_masked_bit_poison_combined := [llvmfunc|
  llvm.func @flip_masked_bit_poison(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.constant(16 : i8) : i8
    %3 = llvm.mlir.undef : vector<2xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi8>
    %8 = llvm.xor %arg0, %0  : vector<2xi8>
    %9 = llvm.and %8, %7  : vector<2xi8>
    llvm.return %9 : vector<2xi8>
  }]

theorem inst_combine_flip_masked_bit_poison   : flip_masked_bit_poison_before  ⊑  flip_masked_bit_poison_combined := by
  unfold flip_masked_bit_poison_before flip_masked_bit_poison_combined
  simp_alive_peephole
  sorry
def flip_masked_bit_nonuniform_combined := [llvmfunc|
  llvm.func @flip_masked_bit_nonuniform(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[16, 4]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.xor %arg0, %0  : vector<2xi8>
    %3 = llvm.and %2, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_flip_masked_bit_nonuniform   : flip_masked_bit_nonuniform_before  ⊑  flip_masked_bit_nonuniform_combined := by
  unfold flip_masked_bit_nonuniform_before flip_masked_bit_nonuniform_combined
  simp_alive_peephole
  sorry
def ashr_bitwidth_mask_combined := [llvmfunc|
  llvm.func @ashr_bitwidth_mask(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    %2 = llvm.select %1, %arg1, %0 : i1, i8
    llvm.return %2 : i8
  }]

theorem inst_combine_ashr_bitwidth_mask   : ashr_bitwidth_mask_before  ⊑  ashr_bitwidth_mask_combined := by
  unfold ashr_bitwidth_mask_before ashr_bitwidth_mask_combined
  simp_alive_peephole
  sorry
def ashr_bitwidth_mask_vec_commute_combined := [llvmfunc|
  llvm.func @ashr_bitwidth_mask_vec_commute(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[42, 2]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.mul %arg1, %0  : vector<2xi8>
    %4 = llvm.icmp "slt" %arg0, %2 : vector<2xi8>
    %5 = llvm.select %4, %3, %2 : vector<2xi1>, vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }]

theorem inst_combine_ashr_bitwidth_mask_vec_commute   : ashr_bitwidth_mask_vec_commute_before  ⊑  ashr_bitwidth_mask_vec_commute_combined := by
  unfold ashr_bitwidth_mask_vec_commute_before ashr_bitwidth_mask_vec_commute_combined
  simp_alive_peephole
  sorry
def ashr_bitwidth_mask_use_combined := [llvmfunc|
  llvm.func @ashr_bitwidth_mask_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.and %1, %arg1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_ashr_bitwidth_mask_use   : ashr_bitwidth_mask_use_before  ⊑  ashr_bitwidth_mask_use_combined := by
  unfold ashr_bitwidth_mask_use_before ashr_bitwidth_mask_use_combined
  simp_alive_peephole
  sorry
def ashr_not_bitwidth_mask_combined := [llvmfunc|
  llvm.func @ashr_not_bitwidth_mask(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    %2 = llvm.and %1, %arg1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_ashr_not_bitwidth_mask   : ashr_not_bitwidth_mask_before  ⊑  ashr_not_bitwidth_mask_combined := by
  unfold ashr_not_bitwidth_mask_before ashr_not_bitwidth_mask_combined
  simp_alive_peephole
  sorry
def lshr_bitwidth_mask_combined := [llvmfunc|
  llvm.func @lshr_bitwidth_mask(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.lshr %arg0, %0  : i8
    %2 = llvm.and %1, %arg1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_lshr_bitwidth_mask   : lshr_bitwidth_mask_before  ⊑  lshr_bitwidth_mask_combined := by
  unfold lshr_bitwidth_mask_before lshr_bitwidth_mask_combined
  simp_alive_peephole
  sorry
def signbit_splat_mask_combined := [llvmfunc|
  llvm.func @signbit_splat_mask(%arg0: i8, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.icmp "slt" %arg0, %0 : i8
    %3 = llvm.select %2, %arg1, %1 : i1, i16
    llvm.return %3 : i16
  }]

theorem inst_combine_signbit_splat_mask   : signbit_splat_mask_before  ⊑  signbit_splat_mask_combined := by
  unfold signbit_splat_mask_before signbit_splat_mask_combined
  simp_alive_peephole
  sorry
def signbit_splat_mask_commute_combined := [llvmfunc|
  llvm.func @signbit_splat_mask_commute(%arg0: vector<2xi5>, %arg1: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(0 : i5) : i5
    %1 = llvm.mlir.constant(dense<0> : vector<2xi5>) : vector<2xi5>
    %2 = llvm.mlir.constant(0 : i16) : i16
    %3 = llvm.mlir.constant(dense<0> : vector<2xi16>) : vector<2xi16>
    %4 = llvm.mul %arg1, %arg1  : vector<2xi16>
    %5 = llvm.icmp "slt" %arg0, %1 : vector<2xi5>
    %6 = llvm.select %5, %4, %3 : vector<2xi1>, vector<2xi16>
    llvm.return %6 : vector<2xi16>
  }]

theorem inst_combine_signbit_splat_mask_commute   : signbit_splat_mask_commute_before  ⊑  signbit_splat_mask_commute_combined := by
  unfold signbit_splat_mask_commute_before signbit_splat_mask_commute_combined
  simp_alive_peephole
  sorry
def signbit_splat_mask_use1_combined := [llvmfunc|
  llvm.func @signbit_splat_mask_use1(%arg0: i8, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(0 : i16) : i16
    %3 = llvm.ashr %arg0, %0  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.icmp "slt" %arg0, %1 : i8
    %5 = llvm.select %4, %arg1, %2 : i1, i16
    llvm.return %5 : i16
  }]

theorem inst_combine_signbit_splat_mask_use1   : signbit_splat_mask_use1_before  ⊑  signbit_splat_mask_use1_combined := by
  unfold signbit_splat_mask_use1_before signbit_splat_mask_use1_combined
  simp_alive_peephole
  sorry
def signbit_splat_mask_use2_combined := [llvmfunc|
  llvm.func @signbit_splat_mask_use2(%arg0: i8, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    %2 = llvm.sext %1 : i8 to i16
    llvm.call @use16(%2) : (i16) -> ()
    %3 = llvm.and %2, %arg1  : i16
    llvm.return %3 : i16
  }]

theorem inst_combine_signbit_splat_mask_use2   : signbit_splat_mask_use2_before  ⊑  signbit_splat_mask_use2_combined := by
  unfold signbit_splat_mask_use2_before signbit_splat_mask_use2_combined
  simp_alive_peephole
  sorry
def not_signbit_splat_mask1_combined := [llvmfunc|
  llvm.func @not_signbit_splat_mask1(%arg0: i8, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    %2 = llvm.zext %1 : i8 to i16
    %3 = llvm.and %2, %arg1  : i16
    llvm.return %3 : i16
  }]

theorem inst_combine_not_signbit_splat_mask1   : not_signbit_splat_mask1_before  ⊑  not_signbit_splat_mask1_combined := by
  unfold not_signbit_splat_mask1_before not_signbit_splat_mask1_combined
  simp_alive_peephole
  sorry
def not_signbit_splat_mask2_combined := [llvmfunc|
  llvm.func @not_signbit_splat_mask2(%arg0: i8, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    %2 = llvm.sext %1 : i8 to i16
    %3 = llvm.and %2, %arg1  : i16
    llvm.return %3 : i16
  }]

theorem inst_combine_not_signbit_splat_mask2   : not_signbit_splat_mask2_before  ⊑  not_signbit_splat_mask2_combined := by
  unfold not_signbit_splat_mask2_before not_signbit_splat_mask2_combined
  simp_alive_peephole
  sorry
def not_ashr_bitwidth_mask_combined := [llvmfunc|
  llvm.func @not_ashr_bitwidth_mask(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    %2 = llvm.select %1, %0, %arg1 : i1, i8
    llvm.return %2 : i8
  }]

theorem inst_combine_not_ashr_bitwidth_mask   : not_ashr_bitwidth_mask_before  ⊑  not_ashr_bitwidth_mask_combined := by
  unfold not_ashr_bitwidth_mask_before not_ashr_bitwidth_mask_combined
  simp_alive_peephole
  sorry
def not_ashr_bitwidth_mask_vec_commute_combined := [llvmfunc|
  llvm.func @not_ashr_bitwidth_mask_vec_commute(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[42, 2]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.mul %arg1, %0  : vector<2xi8>
    %4 = llvm.icmp "slt" %arg0, %2 : vector<2xi8>
    %5 = llvm.select %4, %2, %3 : vector<2xi1>, vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }]

theorem inst_combine_not_ashr_bitwidth_mask_vec_commute   : not_ashr_bitwidth_mask_vec_commute_before  ⊑  not_ashr_bitwidth_mask_vec_commute_combined := by
  unfold not_ashr_bitwidth_mask_vec_commute_before not_ashr_bitwidth_mask_vec_commute_combined
  simp_alive_peephole
  sorry
def not_ashr_bitwidth_mask_use1_combined := [llvmfunc|
  llvm.func @not_ashr_bitwidth_mask_use1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "slt" %arg0, %1 : i8
    %4 = llvm.select %3, %1, %arg1 : i1, i8
    llvm.return %4 : i8
  }]

theorem inst_combine_not_ashr_bitwidth_mask_use1   : not_ashr_bitwidth_mask_use1_before  ⊑  not_ashr_bitwidth_mask_use1_combined := by
  unfold not_ashr_bitwidth_mask_use1_before not_ashr_bitwidth_mask_use1_combined
  simp_alive_peephole
  sorry
def not_ashr_bitwidth_mask_use2_combined := [llvmfunc|
  llvm.func @not_ashr_bitwidth_mask_use2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %0 : i8
    %2 = llvm.sext %1 : i1 to i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.and %2, %arg1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_not_ashr_bitwidth_mask_use2   : not_ashr_bitwidth_mask_use2_before  ⊑  not_ashr_bitwidth_mask_use2_combined := by
  unfold not_ashr_bitwidth_mask_use2_before not_ashr_bitwidth_mask_use2_combined
  simp_alive_peephole
  sorry
def not_ashr_not_bitwidth_mask_combined := [llvmfunc|
  llvm.func @not_ashr_not_bitwidth_mask(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    %4 = llvm.and %3, %arg1  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_not_ashr_not_bitwidth_mask   : not_ashr_not_bitwidth_mask_before  ⊑  not_ashr_not_bitwidth_mask_combined := by
  unfold not_ashr_not_bitwidth_mask_before not_ashr_not_bitwidth_mask_combined
  simp_alive_peephole
  sorry
def not_lshr_bitwidth_mask_combined := [llvmfunc|
  llvm.func @not_lshr_bitwidth_mask(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    %4 = llvm.and %3, %arg1  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_not_lshr_bitwidth_mask   : not_lshr_bitwidth_mask_before  ⊑  not_lshr_bitwidth_mask_combined := by
  unfold not_lshr_bitwidth_mask_before not_lshr_bitwidth_mask_combined
  simp_alive_peephole
  sorry
def invert_signbit_splat_mask_combined := [llvmfunc|
  llvm.func @invert_signbit_splat_mask(%arg0: i8, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.icmp "sgt" %arg0, %0 : i8
    %3 = llvm.select %2, %arg1, %1 : i1, i16
    llvm.return %3 : i16
  }]

theorem inst_combine_invert_signbit_splat_mask   : invert_signbit_splat_mask_before  ⊑  invert_signbit_splat_mask_combined := by
  unfold invert_signbit_splat_mask_before invert_signbit_splat_mask_combined
  simp_alive_peephole
  sorry
def invert_signbit_splat_mask_commute_combined := [llvmfunc|
  llvm.func @invert_signbit_splat_mask_commute(%arg0: vector<2xi5>, %arg1: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(0 : i5) : i5
    %1 = llvm.mlir.constant(dense<0> : vector<2xi5>) : vector<2xi5>
    %2 = llvm.mlir.constant(0 : i16) : i16
    %3 = llvm.mlir.constant(dense<0> : vector<2xi16>) : vector<2xi16>
    %4 = llvm.mul %arg1, %arg1  : vector<2xi16>
    %5 = llvm.icmp "slt" %arg0, %1 : vector<2xi5>
    %6 = llvm.select %5, %3, %4 : vector<2xi1>, vector<2xi16>
    llvm.return %6 : vector<2xi16>
  }]

theorem inst_combine_invert_signbit_splat_mask_commute   : invert_signbit_splat_mask_commute_before  ⊑  invert_signbit_splat_mask_commute_combined := by
  unfold invert_signbit_splat_mask_commute_before invert_signbit_splat_mask_commute_combined
  simp_alive_peephole
  sorry
def invert_signbit_splat_mask_use1_combined := [llvmfunc|
  llvm.func @invert_signbit_splat_mask_use1(%arg0: i8, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(0 : i16) : i16
    %3 = llvm.ashr %arg0, %0  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.icmp "slt" %arg0, %1 : i8
    %5 = llvm.select %4, %2, %arg1 : i1, i16
    llvm.return %5 : i16
  }]

theorem inst_combine_invert_signbit_splat_mask_use1   : invert_signbit_splat_mask_use1_before  ⊑  invert_signbit_splat_mask_use1_combined := by
  unfold invert_signbit_splat_mask_use1_before invert_signbit_splat_mask_use1_combined
  simp_alive_peephole
  sorry
def invert_signbit_splat_mask_use2_combined := [llvmfunc|
  llvm.func @invert_signbit_splat_mask_use2(%arg0: i8, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.icmp "sgt" %arg0, %0 : i8
    %3 = llvm.sext %2 : i1 to i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.select %2, %arg1, %1 : i1, i16
    llvm.return %4 : i16
  }]

theorem inst_combine_invert_signbit_splat_mask_use2   : invert_signbit_splat_mask_use2_before  ⊑  invert_signbit_splat_mask_use2_combined := by
  unfold invert_signbit_splat_mask_use2_before invert_signbit_splat_mask_use2_combined
  simp_alive_peephole
  sorry
def invert_signbit_splat_mask_use3_combined := [llvmfunc|
  llvm.func @invert_signbit_splat_mask_use3(%arg0: i8, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %0 : i8
    %2 = llvm.sext %1 : i1 to i16
    llvm.call @use16(%2) : (i16) -> ()
    %3 = llvm.and %2, %arg1  : i16
    llvm.return %3 : i16
  }]

theorem inst_combine_invert_signbit_splat_mask_use3   : invert_signbit_splat_mask_use3_before  ⊑  invert_signbit_splat_mask_use3_combined := by
  unfold invert_signbit_splat_mask_use3_before invert_signbit_splat_mask_use3_combined
  simp_alive_peephole
  sorry
def not_invert_signbit_splat_mask1_combined := [llvmfunc|
  llvm.func @not_invert_signbit_splat_mask1(%arg0: i8, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %0 : i8
    %2 = llvm.sext %1 : i1 to i8
    %3 = llvm.zext %2 : i8 to i16
    %4 = llvm.and %3, %arg1  : i16
    llvm.return %4 : i16
  }]

theorem inst_combine_not_invert_signbit_splat_mask1   : not_invert_signbit_splat_mask1_before  ⊑  not_invert_signbit_splat_mask1_combined := by
  unfold not_invert_signbit_splat_mask1_before not_invert_signbit_splat_mask1_combined
  simp_alive_peephole
  sorry
def not_invert_signbit_splat_mask2_combined := [llvmfunc|
  llvm.func @not_invert_signbit_splat_mask2(%arg0: i8, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    %4 = llvm.sext %3 : i8 to i16
    %5 = llvm.and %4, %arg1  : i16
    llvm.return %5 : i16
  }]

theorem inst_combine_not_invert_signbit_splat_mask2   : not_invert_signbit_splat_mask2_before  ⊑  not_invert_signbit_splat_mask2_combined := by
  unfold not_invert_signbit_splat_mask2_before not_invert_signbit_splat_mask2_combined
  simp_alive_peephole
  sorry
def shl_lshr_pow2_const_case1_combined := [llvmfunc|
  llvm.func @shl_lshr_pow2_const_case1(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(7 : i16) : i16
    %1 = llvm.mlir.constant(8 : i16) : i16
    %2 = llvm.mlir.constant(0 : i16) : i16
    %3 = llvm.icmp "eq" %arg0, %0 : i16
    %4 = llvm.select %3, %1, %2 : i1, i16
    llvm.return %4 : i16
  }]

theorem inst_combine_shl_lshr_pow2_const_case1   : shl_lshr_pow2_const_case1_before  ⊑  shl_lshr_pow2_const_case1_combined := by
  unfold shl_lshr_pow2_const_case1_before shl_lshr_pow2_const_case1_combined
  simp_alive_peephole
  sorry
def shl_ashr_pow2_const_case1_combined := [llvmfunc|
  llvm.func @shl_ashr_pow2_const_case1(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(7 : i16) : i16
    %1 = llvm.mlir.constant(8 : i16) : i16
    %2 = llvm.mlir.constant(0 : i16) : i16
    %3 = llvm.icmp "eq" %arg0, %0 : i16
    %4 = llvm.select %3, %1, %2 : i1, i16
    llvm.return %4 : i16
  }]

theorem inst_combine_shl_ashr_pow2_const_case1   : shl_ashr_pow2_const_case1_before  ⊑  shl_ashr_pow2_const_case1_combined := by
  unfold shl_ashr_pow2_const_case1_before shl_ashr_pow2_const_case1_combined
  simp_alive_peephole
  sorry
def shl_lshr_pow2_const_case1_uniform_vec_combined := [llvmfunc|
  llvm.func @shl_lshr_pow2_const_case1_uniform_vec(%arg0: vector<3xi16>) -> vector<3xi16> {
    %0 = llvm.mlir.constant(dense<7> : vector<3xi16>) : vector<3xi16>
    %1 = llvm.mlir.constant(dense<8> : vector<3xi16>) : vector<3xi16>
    %2 = llvm.mlir.constant(0 : i16) : i16
    %3 = llvm.mlir.constant(dense<0> : vector<3xi16>) : vector<3xi16>
    %4 = llvm.icmp "eq" %arg0, %0 : vector<3xi16>
    %5 = llvm.select %4, %1, %3 : vector<3xi1>, vector<3xi16>
    llvm.return %5 : vector<3xi16>
  }]

theorem inst_combine_shl_lshr_pow2_const_case1_uniform_vec   : shl_lshr_pow2_const_case1_uniform_vec_before  ⊑  shl_lshr_pow2_const_case1_uniform_vec_combined := by
  unfold shl_lshr_pow2_const_case1_uniform_vec_before shl_lshr_pow2_const_case1_uniform_vec_combined
  simp_alive_peephole
  sorry
def shl_lshr_pow2_const_case1_non_uniform_vec_combined := [llvmfunc|
  llvm.func @shl_lshr_pow2_const_case1_non_uniform_vec(%arg0: vector<3xi16>) -> vector<3xi16> {
    %0 = llvm.mlir.constant(dense<[2, 8, 32]> : vector<3xi16>) : vector<3xi16>
    %1 = llvm.mlir.constant(dense<[5, 6, 3]> : vector<3xi16>) : vector<3xi16>
    %2 = llvm.mlir.constant(dense<[8, 4, 8]> : vector<3xi16>) : vector<3xi16>
    %3 = llvm.shl %0, %arg0  : vector<3xi16>
    %4 = llvm.lshr %3, %1  : vector<3xi16>
    %5 = llvm.and %4, %2  : vector<3xi16>
    llvm.return %5 : vector<3xi16>
  }]

theorem inst_combine_shl_lshr_pow2_const_case1_non_uniform_vec   : shl_lshr_pow2_const_case1_non_uniform_vec_before  ⊑  shl_lshr_pow2_const_case1_non_uniform_vec_combined := by
  unfold shl_lshr_pow2_const_case1_non_uniform_vec_before shl_lshr_pow2_const_case1_non_uniform_vec_combined
  simp_alive_peephole
  sorry
def shl_lshr_pow2_const_case1_non_uniform_vec_negative_combined := [llvmfunc|
  llvm.func @shl_lshr_pow2_const_case1_non_uniform_vec_negative(%arg0: vector<3xi16>) -> vector<3xi16> {
    %0 = llvm.mlir.constant(dense<[2, 8, 32]> : vector<3xi16>) : vector<3xi16>
    %1 = llvm.mlir.constant(dense<[5, 6, 3]> : vector<3xi16>) : vector<3xi16>
    %2 = llvm.mlir.constant(dense<[8, 4, 16384]> : vector<3xi16>) : vector<3xi16>
    %3 = llvm.shl %0, %arg0  : vector<3xi16>
    %4 = llvm.lshr %3, %1  : vector<3xi16>
    %5 = llvm.and %4, %2  : vector<3xi16>
    llvm.return %5 : vector<3xi16>
  }]

theorem inst_combine_shl_lshr_pow2_const_case1_non_uniform_vec_negative   : shl_lshr_pow2_const_case1_non_uniform_vec_negative_before  ⊑  shl_lshr_pow2_const_case1_non_uniform_vec_negative_combined := by
  unfold shl_lshr_pow2_const_case1_non_uniform_vec_negative_before shl_lshr_pow2_const_case1_non_uniform_vec_negative_combined
  simp_alive_peephole
  sorry
def shl_lshr_pow2_const_case1_poison1_vec_combined := [llvmfunc|
  llvm.func @shl_lshr_pow2_const_case1_poison1_vec(%arg0: vector<3xi16>) -> vector<3xi16> {
    %0 = llvm.mlir.constant(dense<[8, 4, 4]> : vector<3xi16>) : vector<3xi16>
    %1 = llvm.mlir.constant(dense<8> : vector<3xi16>) : vector<3xi16>
    %2 = llvm.mlir.constant(0 : i16) : i16
    %3 = llvm.mlir.constant(dense<0> : vector<3xi16>) : vector<3xi16>
    %4 = llvm.icmp "eq" %arg0, %0 : vector<3xi16>
    %5 = llvm.select %4, %1, %3 : vector<3xi1>, vector<3xi16>
    llvm.return %5 : vector<3xi16>
  }]

theorem inst_combine_shl_lshr_pow2_const_case1_poison1_vec   : shl_lshr_pow2_const_case1_poison1_vec_before  ⊑  shl_lshr_pow2_const_case1_poison1_vec_combined := by
  unfold shl_lshr_pow2_const_case1_poison1_vec_before shl_lshr_pow2_const_case1_poison1_vec_combined
  simp_alive_peephole
  sorry
def shl_lshr_pow2_const_case1_poison2_vec_combined := [llvmfunc|
  llvm.func @shl_lshr_pow2_const_case1_poison2_vec(%arg0: vector<3xi16>) -> vector<3xi16> {
    %0 = llvm.mlir.constant(4 : i16) : i16
    %1 = llvm.mlir.poison : i16
    %2 = llvm.mlir.undef : vector<3xi16>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<3xi16>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<3xi16>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi16>
    %9 = llvm.mlir.constant(dense<8> : vector<3xi16>) : vector<3xi16>
    %10 = llvm.mlir.constant(0 : i16) : i16
    %11 = llvm.mlir.constant(dense<0> : vector<3xi16>) : vector<3xi16>
    %12 = llvm.icmp "eq" %arg0, %8 : vector<3xi16>
    %13 = llvm.select %12, %9, %11 : vector<3xi1>, vector<3xi16>
    llvm.return %13 : vector<3xi16>
  }]

theorem inst_combine_shl_lshr_pow2_const_case1_poison2_vec   : shl_lshr_pow2_const_case1_poison2_vec_before  ⊑  shl_lshr_pow2_const_case1_poison2_vec_combined := by
  unfold shl_lshr_pow2_const_case1_poison2_vec_before shl_lshr_pow2_const_case1_poison2_vec_combined
  simp_alive_peephole
  sorry
def shl_lshr_pow2_const_case1_poison3_vec_combined := [llvmfunc|
  llvm.func @shl_lshr_pow2_const_case1_poison3_vec(%arg0: vector<3xi16>) -> vector<3xi16> {
    %0 = llvm.mlir.constant(dense<16> : vector<3xi16>) : vector<3xi16>
    %1 = llvm.mlir.constant(dense<5> : vector<3xi16>) : vector<3xi16>
    %2 = llvm.mlir.constant(8 : i16) : i16
    %3 = llvm.mlir.poison : i16
    %4 = llvm.mlir.undef : vector<3xi16>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<3xi16>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<3xi16>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %2, %8[%9 : i32] : vector<3xi16>
    %11 = llvm.shl %0, %arg0  : vector<3xi16>
    %12 = llvm.lshr %11, %1  : vector<3xi16>
    %13 = llvm.and %12, %10  : vector<3xi16>
    llvm.return %13 : vector<3xi16>
  }]

theorem inst_combine_shl_lshr_pow2_const_case1_poison3_vec   : shl_lshr_pow2_const_case1_poison3_vec_before  ⊑  shl_lshr_pow2_const_case1_poison3_vec_combined := by
  unfold shl_lshr_pow2_const_case1_poison3_vec_before shl_lshr_pow2_const_case1_poison3_vec_combined
  simp_alive_peephole
  sorry
def shl_lshr_pow2_const_case2_combined := [llvmfunc|
  llvm.func @shl_lshr_pow2_const_case2(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(2 : i16) : i16
    %1 = llvm.mlir.constant(8 : i16) : i16
    %2 = llvm.mlir.constant(0 : i16) : i16
    %3 = llvm.icmp "eq" %arg0, %0 : i16
    %4 = llvm.select %3, %1, %2 : i1, i16
    llvm.return %4 : i16
  }]

theorem inst_combine_shl_lshr_pow2_const_case2   : shl_lshr_pow2_const_case2_before  ⊑  shl_lshr_pow2_const_case2_combined := by
  unfold shl_lshr_pow2_const_case2_before shl_lshr_pow2_const_case2_combined
  simp_alive_peephole
  sorry
def shl_lshr_pow2_not_const_case2_combined := [llvmfunc|
  llvm.func @shl_lshr_pow2_not_const_case2(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(2 : i16) : i16
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.mlir.constant(8 : i16) : i16
    %3 = llvm.icmp "eq" %arg0, %0 : i16
    %4 = llvm.select %3, %1, %2 : i1, i16
    llvm.return %4 : i16
  }]

theorem inst_combine_shl_lshr_pow2_not_const_case2   : shl_lshr_pow2_not_const_case2_before  ⊑  shl_lshr_pow2_not_const_case2_combined := by
  unfold shl_lshr_pow2_not_const_case2_before shl_lshr_pow2_not_const_case2_combined
  simp_alive_peephole
  sorry
def shl_lshr_pow2_const_negative_overflow1_combined := [llvmfunc|
  llvm.func @shl_lshr_pow2_const_negative_overflow1(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    llvm.return %0 : i16
  }]

theorem inst_combine_shl_lshr_pow2_const_negative_overflow1   : shl_lshr_pow2_const_negative_overflow1_before  ⊑  shl_lshr_pow2_const_negative_overflow1_combined := by
  unfold shl_lshr_pow2_const_negative_overflow1_before shl_lshr_pow2_const_negative_overflow1_combined
  simp_alive_peephole
  sorry
def shl_lshr_pow2_const_negative_overflow2_combined := [llvmfunc|
  llvm.func @shl_lshr_pow2_const_negative_overflow2(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    llvm.return %0 : i16
  }]

theorem inst_combine_shl_lshr_pow2_const_negative_overflow2   : shl_lshr_pow2_const_negative_overflow2_before  ⊑  shl_lshr_pow2_const_negative_overflow2_combined := by
  unfold shl_lshr_pow2_const_negative_overflow2_before shl_lshr_pow2_const_negative_overflow2_combined
  simp_alive_peephole
  sorry
def shl_lshr_pow2_const_negative_oneuse_combined := [llvmfunc|
  llvm.func @shl_lshr_pow2_const_negative_oneuse(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(4 : i16) : i16
    %1 = llvm.mlir.constant(6 : i16) : i16
    %2 = llvm.mlir.constant(8 : i16) : i16
    %3 = llvm.shl %0, %arg0  : i16
    %4 = llvm.lshr %3, %1  : i16
    llvm.call @use16(%4) : (i16) -> ()
    %5 = llvm.and %4, %2  : i16
    llvm.return %5 : i16
  }]

theorem inst_combine_shl_lshr_pow2_const_negative_oneuse   : shl_lshr_pow2_const_negative_oneuse_before  ⊑  shl_lshr_pow2_const_negative_oneuse_combined := by
  unfold shl_lshr_pow2_const_negative_oneuse_before shl_lshr_pow2_const_negative_oneuse_combined
  simp_alive_peephole
  sorry
def shl_lshr_pow2_const_negative_nopow2_1_combined := [llvmfunc|
  llvm.func @shl_lshr_pow2_const_negative_nopow2_1(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(3 : i16) : i16
    %1 = llvm.mlir.constant(6 : i16) : i16
    %2 = llvm.mlir.constant(8 : i16) : i16
    %3 = llvm.shl %0, %arg0  : i16
    %4 = llvm.lshr %3, %1  : i16
    %5 = llvm.and %4, %2  : i16
    llvm.return %5 : i16
  }]

theorem inst_combine_shl_lshr_pow2_const_negative_nopow2_1   : shl_lshr_pow2_const_negative_nopow2_1_before  ⊑  shl_lshr_pow2_const_negative_nopow2_1_combined := by
  unfold shl_lshr_pow2_const_negative_nopow2_1_before shl_lshr_pow2_const_negative_nopow2_1_combined
  simp_alive_peephole
  sorry
def shl_lshr_pow2_const_negative_nopow2_2_combined := [llvmfunc|
  llvm.func @shl_lshr_pow2_const_negative_nopow2_2(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(3 : i16) : i16
    %1 = llvm.mlir.constant(6 : i16) : i16
    %2 = llvm.mlir.constant(7 : i16) : i16
    %3 = llvm.shl %0, %arg0  : i16
    %4 = llvm.lshr %3, %1  : i16
    %5 = llvm.and %4, %2  : i16
    llvm.return %5 : i16
  }]

theorem inst_combine_shl_lshr_pow2_const_negative_nopow2_2   : shl_lshr_pow2_const_negative_nopow2_2_before  ⊑  shl_lshr_pow2_const_negative_nopow2_2_combined := by
  unfold shl_lshr_pow2_const_negative_nopow2_2_before shl_lshr_pow2_const_negative_nopow2_2_combined
  simp_alive_peephole
  sorry
def lshr_lshr_pow2_const_combined := [llvmfunc|
  llvm.func @lshr_lshr_pow2_const(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(3 : i16) : i16
    %1 = llvm.mlir.constant(4 : i16) : i16
    %2 = llvm.mlir.constant(0 : i16) : i16
    %3 = llvm.icmp "eq" %arg0, %0 : i16
    %4 = llvm.select %3, %1, %2 : i1, i16
    llvm.return %4 : i16
  }]

theorem inst_combine_lshr_lshr_pow2_const   : lshr_lshr_pow2_const_before  ⊑  lshr_lshr_pow2_const_combined := by
  unfold lshr_lshr_pow2_const_before lshr_lshr_pow2_const_combined
  simp_alive_peephole
  sorry
def lshr_lshr_pow2_const_negative_oneuse_combined := [llvmfunc|
  llvm.func @lshr_lshr_pow2_const_negative_oneuse(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(32 : i16) : i16
    %1 = llvm.mlir.constant(4 : i16) : i16
    %2 = llvm.lshr %0, %arg0  : i16
    llvm.call @use16(%2) : (i16) -> ()
    %3 = llvm.and %2, %1  : i16
    llvm.return %3 : i16
  }]

theorem inst_combine_lshr_lshr_pow2_const_negative_oneuse   : lshr_lshr_pow2_const_negative_oneuse_before  ⊑  lshr_lshr_pow2_const_negative_oneuse_combined := by
  unfold lshr_lshr_pow2_const_negative_oneuse_before lshr_lshr_pow2_const_negative_oneuse_combined
  simp_alive_peephole
  sorry
def lshr_lshr_pow2_const_negative_nopow2_1_combined := [llvmfunc|
  llvm.func @lshr_lshr_pow2_const_negative_nopow2_1(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(31 : i16) : i16
    %1 = llvm.mlir.constant(4 : i16) : i16
    %2 = llvm.lshr %0, %arg0  : i16
    %3 = llvm.and %2, %1  : i16
    llvm.return %3 : i16
  }]

theorem inst_combine_lshr_lshr_pow2_const_negative_nopow2_1   : lshr_lshr_pow2_const_negative_nopow2_1_before  ⊑  lshr_lshr_pow2_const_negative_nopow2_1_combined := by
  unfold lshr_lshr_pow2_const_negative_nopow2_1_before lshr_lshr_pow2_const_negative_nopow2_1_combined
  simp_alive_peephole
  sorry
def lshr_lshr_pow2_const_negative_nopow2_2_combined := [llvmfunc|
  llvm.func @lshr_lshr_pow2_const_negative_nopow2_2(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(128 : i16) : i16
    %1 = llvm.mlir.constant(3 : i16) : i16
    %2 = llvm.lshr %0, %arg0  : i16
    %3 = llvm.and %2, %1  : i16
    llvm.return %3 : i16
  }]

theorem inst_combine_lshr_lshr_pow2_const_negative_nopow2_2   : lshr_lshr_pow2_const_negative_nopow2_2_before  ⊑  lshr_lshr_pow2_const_negative_nopow2_2_combined := by
  unfold lshr_lshr_pow2_const_negative_nopow2_2_before lshr_lshr_pow2_const_negative_nopow2_2_combined
  simp_alive_peephole
  sorry
def lshr_lshr_pow2_const_negative_overflow_combined := [llvmfunc|
  llvm.func @lshr_lshr_pow2_const_negative_overflow(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    llvm.return %0 : i16
  }]

theorem inst_combine_lshr_lshr_pow2_const_negative_overflow   : lshr_lshr_pow2_const_negative_overflow_before  ⊑  lshr_lshr_pow2_const_negative_overflow_combined := by
  unfold lshr_lshr_pow2_const_negative_overflow_before lshr_lshr_pow2_const_negative_overflow_combined
  simp_alive_peephole
  sorry
def lshr_shl_pow2_const_case1_combined := [llvmfunc|
  llvm.func @lshr_shl_pow2_const_case1(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(7 : i16) : i16
    %1 = llvm.mlir.constant(8 : i16) : i16
    %2 = llvm.mlir.constant(0 : i16) : i16
    %3 = llvm.icmp "eq" %arg0, %0 : i16
    %4 = llvm.select %3, %1, %2 : i1, i16
    llvm.return %4 : i16
  }]

theorem inst_combine_lshr_shl_pow2_const_case1   : lshr_shl_pow2_const_case1_before  ⊑  lshr_shl_pow2_const_case1_combined := by
  unfold lshr_shl_pow2_const_case1_before lshr_shl_pow2_const_case1_combined
  simp_alive_peephole
  sorry
def lshr_shl_pow2_const_xor_combined := [llvmfunc|
  llvm.func @lshr_shl_pow2_const_xor(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(7 : i16) : i16
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.mlir.constant(8 : i16) : i16
    %3 = llvm.icmp "eq" %arg0, %0 : i16
    %4 = llvm.select %3, %1, %2 : i1, i16
    llvm.return %4 : i16
  }]

theorem inst_combine_lshr_shl_pow2_const_xor   : lshr_shl_pow2_const_xor_before  ⊑  lshr_shl_pow2_const_xor_combined := by
  unfold lshr_shl_pow2_const_xor_before lshr_shl_pow2_const_xor_combined
  simp_alive_peephole
  sorry
def lshr_shl_pow2_const_case2_combined := [llvmfunc|
  llvm.func @lshr_shl_pow2_const_case2(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(12 : i16) : i16
    %1 = llvm.mlir.constant(32 : i16) : i16
    %2 = llvm.mlir.constant(0 : i16) : i16
    %3 = llvm.icmp "eq" %arg0, %0 : i16
    %4 = llvm.select %3, %1, %2 : i1, i16
    llvm.return %4 : i16
  }]

theorem inst_combine_lshr_shl_pow2_const_case2   : lshr_shl_pow2_const_case2_before  ⊑  lshr_shl_pow2_const_case2_combined := by
  unfold lshr_shl_pow2_const_case2_before lshr_shl_pow2_const_case2_combined
  simp_alive_peephole
  sorry
def lshr_shl_pow2_const_overflow_combined := [llvmfunc|
  llvm.func @lshr_shl_pow2_const_overflow(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    llvm.return %0 : i16
  }]

theorem inst_combine_lshr_shl_pow2_const_overflow   : lshr_shl_pow2_const_overflow_before  ⊑  lshr_shl_pow2_const_overflow_combined := by
  unfold lshr_shl_pow2_const_overflow_before lshr_shl_pow2_const_overflow_combined
  simp_alive_peephole
  sorry
def lshr_shl_pow2_const_negative_oneuse_combined := [llvmfunc|
  llvm.func @lshr_shl_pow2_const_negative_oneuse(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(8192 : i16) : i16
    %1 = llvm.mlir.constant(4 : i16) : i16
    %2 = llvm.mlir.constant(32 : i16) : i16
    %3 = llvm.lshr %0, %arg0  : i16
    %4 = llvm.shl %3, %1  : i16
    llvm.call @use16(%4) : (i16) -> ()
    %5 = llvm.and %4, %2  : i16
    llvm.return %5 : i16
  }]

theorem inst_combine_lshr_shl_pow2_const_negative_oneuse   : lshr_shl_pow2_const_negative_oneuse_before  ⊑  lshr_shl_pow2_const_negative_oneuse_combined := by
  unfold lshr_shl_pow2_const_negative_oneuse_before lshr_shl_pow2_const_negative_oneuse_combined
  simp_alive_peephole
  sorry
def lshr_shl_pow2_const_case1_uniform_vec_combined := [llvmfunc|
  llvm.func @lshr_shl_pow2_const_case1_uniform_vec(%arg0: vector<3xi16>) -> vector<3xi16> {
    %0 = llvm.mlir.constant(dense<12> : vector<3xi16>) : vector<3xi16>
    %1 = llvm.mlir.constant(dense<128> : vector<3xi16>) : vector<3xi16>
    %2 = llvm.mlir.constant(0 : i16) : i16
    %3 = llvm.mlir.constant(dense<0> : vector<3xi16>) : vector<3xi16>
    %4 = llvm.icmp "eq" %arg0, %0 : vector<3xi16>
    %5 = llvm.select %4, %1, %3 : vector<3xi1>, vector<3xi16>
    llvm.return %5 : vector<3xi16>
  }]

theorem inst_combine_lshr_shl_pow2_const_case1_uniform_vec   : lshr_shl_pow2_const_case1_uniform_vec_before  ⊑  lshr_shl_pow2_const_case1_uniform_vec_combined := by
  unfold lshr_shl_pow2_const_case1_uniform_vec_before lshr_shl_pow2_const_case1_uniform_vec_combined
  simp_alive_peephole
  sorry
def lshr_shl_pow2_const_case1_non_uniform_vec_combined := [llvmfunc|
  llvm.func @lshr_shl_pow2_const_case1_non_uniform_vec(%arg0: vector<3xi16>) -> vector<3xi16> {
    %0 = llvm.mlir.constant(dense<[8192, 16384, -32768]> : vector<3xi16>) : vector<3xi16>
    %1 = llvm.mlir.constant(dense<[7, 5, 3]> : vector<3xi16>) : vector<3xi16>
    %2 = llvm.mlir.constant(dense<[128, 256, 512]> : vector<3xi16>) : vector<3xi16>
    %3 = llvm.lshr %0, %arg0  : vector<3xi16>
    %4 = llvm.shl %3, %1  : vector<3xi16>
    %5 = llvm.and %4, %2  : vector<3xi16>
    llvm.return %5 : vector<3xi16>
  }]

theorem inst_combine_lshr_shl_pow2_const_case1_non_uniform_vec   : lshr_shl_pow2_const_case1_non_uniform_vec_before  ⊑  lshr_shl_pow2_const_case1_non_uniform_vec_combined := by
  unfold lshr_shl_pow2_const_case1_non_uniform_vec_before lshr_shl_pow2_const_case1_non_uniform_vec_combined
  simp_alive_peephole
  sorry
def lshr_shl_pow2_const_case1_non_uniform_vec_negative_combined := [llvmfunc|
  llvm.func @lshr_shl_pow2_const_case1_non_uniform_vec_negative(%arg0: vector<3xi16>) -> vector<3xi16> {
    %0 = llvm.mlir.constant(dense<[8192, 16384, -32768]> : vector<3xi16>) : vector<3xi16>
    %1 = llvm.mlir.constant(dense<[8, 5, 3]> : vector<3xi16>) : vector<3xi16>
    %2 = llvm.mlir.constant(dense<[128, 256, 512]> : vector<3xi16>) : vector<3xi16>
    %3 = llvm.lshr %0, %arg0  : vector<3xi16>
    %4 = llvm.shl %3, %1  : vector<3xi16>
    %5 = llvm.and %4, %2  : vector<3xi16>
    llvm.return %5 : vector<3xi16>
  }]

theorem inst_combine_lshr_shl_pow2_const_case1_non_uniform_vec_negative   : lshr_shl_pow2_const_case1_non_uniform_vec_negative_before  ⊑  lshr_shl_pow2_const_case1_non_uniform_vec_negative_combined := by
  unfold lshr_shl_pow2_const_case1_non_uniform_vec_negative_before lshr_shl_pow2_const_case1_non_uniform_vec_negative_combined
  simp_alive_peephole
  sorry
def lshr_shl_pow2_const_case1_poison1_vec_combined := [llvmfunc|
  llvm.func @lshr_shl_pow2_const_case1_poison1_vec(%arg0: vector<3xi16>) -> vector<3xi16> {
    %0 = llvm.mlir.constant(dense<[-1, 12, 12]> : vector<3xi16>) : vector<3xi16>
    %1 = llvm.mlir.constant(dense<128> : vector<3xi16>) : vector<3xi16>
    %2 = llvm.mlir.constant(0 : i16) : i16
    %3 = llvm.mlir.constant(dense<0> : vector<3xi16>) : vector<3xi16>
    %4 = llvm.icmp "eq" %arg0, %0 : vector<3xi16>
    %5 = llvm.select %4, %1, %3 : vector<3xi1>, vector<3xi16>
    llvm.return %5 : vector<3xi16>
  }]

theorem inst_combine_lshr_shl_pow2_const_case1_poison1_vec   : lshr_shl_pow2_const_case1_poison1_vec_before  ⊑  lshr_shl_pow2_const_case1_poison1_vec_combined := by
  unfold lshr_shl_pow2_const_case1_poison1_vec_before lshr_shl_pow2_const_case1_poison1_vec_combined
  simp_alive_peephole
  sorry
def lshr_shl_pow2_const_case1_poison2_vec_combined := [llvmfunc|
  llvm.func @lshr_shl_pow2_const_case1_poison2_vec(%arg0: vector<3xi16>) -> vector<3xi16> {
    %0 = llvm.mlir.constant(dense<8192> : vector<3xi16>) : vector<3xi16>
    %1 = llvm.mlir.constant(6 : i16) : i16
    %2 = llvm.mlir.poison : i16
    %3 = llvm.mlir.undef : vector<3xi16>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<3xi16>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<3xi16>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<3xi16>
    %10 = llvm.mlir.constant(dense<128> : vector<3xi16>) : vector<3xi16>
    %11 = llvm.lshr %0, %arg0  : vector<3xi16>
    %12 = llvm.shl %11, %9  : vector<3xi16>
    %13 = llvm.and %12, %10  : vector<3xi16>
    llvm.return %13 : vector<3xi16>
  }]

theorem inst_combine_lshr_shl_pow2_const_case1_poison2_vec   : lshr_shl_pow2_const_case1_poison2_vec_before  ⊑  lshr_shl_pow2_const_case1_poison2_vec_combined := by
  unfold lshr_shl_pow2_const_case1_poison2_vec_before lshr_shl_pow2_const_case1_poison2_vec_combined
  simp_alive_peephole
  sorry
def lshr_shl_pow2_const_case1_poison3_vec_combined := [llvmfunc|
  llvm.func @lshr_shl_pow2_const_case1_poison3_vec(%arg0: vector<3xi16>) -> vector<3xi16> {
    %0 = llvm.mlir.constant(dense<8192> : vector<3xi16>) : vector<3xi16>
    %1 = llvm.mlir.constant(dense<6> : vector<3xi16>) : vector<3xi16>
    %2 = llvm.mlir.constant(128 : i16) : i16
    %3 = llvm.mlir.poison : i16
    %4 = llvm.mlir.undef : vector<3xi16>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<3xi16>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<3xi16>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %2, %8[%9 : i32] : vector<3xi16>
    %11 = llvm.lshr %0, %arg0  : vector<3xi16>
    %12 = llvm.shl %11, %1  : vector<3xi16>
    %13 = llvm.and %12, %10  : vector<3xi16>
    llvm.return %13 : vector<3xi16>
  }]

theorem inst_combine_lshr_shl_pow2_const_case1_poison3_vec   : lshr_shl_pow2_const_case1_poison3_vec_before  ⊑  lshr_shl_pow2_const_case1_poison3_vec_combined := by
  unfold lshr_shl_pow2_const_case1_poison3_vec_before lshr_shl_pow2_const_case1_poison3_vec_combined
  simp_alive_peephole
  sorry
def negate_lowbitmask_combined := [llvmfunc|
  llvm.func @negate_lowbitmask(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    %4 = llvm.select %3, %1, %arg1 : i1, i8
    llvm.return %4 : i8
  }]

theorem inst_combine_negate_lowbitmask   : negate_lowbitmask_before  ⊑  negate_lowbitmask_combined := by
  unfold negate_lowbitmask_before negate_lowbitmask_combined
  simp_alive_peephole
  sorry
def negate_lowbitmask_commute_combined := [llvmfunc|
  llvm.func @negate_lowbitmask_commute(%arg0: vector<2xi5>, %arg1: vector<2xi5>) -> vector<2xi5> {
    %0 = llvm.mlir.poison : i5
    %1 = llvm.mlir.constant(1 : i5) : i5
    %2 = llvm.mlir.undef : vector<2xi5>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi5>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi5>
    %7 = llvm.mlir.constant(0 : i5) : i5
    %8 = llvm.mlir.undef : vector<2xi5>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<2xi5>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %7, %10[%11 : i32] : vector<2xi5>
    %13 = llvm.mlir.constant(dense<0> : vector<2xi5>) : vector<2xi5>
    %14 = llvm.mul %arg1, %arg1  : vector<2xi5>
    %15 = llvm.and %arg0, %6  : vector<2xi5>
    %16 = llvm.icmp "eq" %15, %12 : vector<2xi5>
    %17 = llvm.select %16, %13, %14 : vector<2xi1>, vector<2xi5>
    llvm.return %17 : vector<2xi5>
  }]

theorem inst_combine_negate_lowbitmask_commute   : negate_lowbitmask_commute_before  ⊑  negate_lowbitmask_commute_combined := by
  unfold negate_lowbitmask_commute_before negate_lowbitmask_commute_combined
  simp_alive_peephole
  sorry
def negate_lowbitmask_use1_combined := [llvmfunc|
  llvm.func @negate_lowbitmask_use1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "eq" %2, %1 : i8
    %4 = llvm.select %3, %1, %arg1 : i1, i8
    llvm.return %4 : i8
  }]

theorem inst_combine_negate_lowbitmask_use1   : negate_lowbitmask_use1_before  ⊑  negate_lowbitmask_use1_combined := by
  unfold negate_lowbitmask_use1_before negate_lowbitmask_use1_combined
  simp_alive_peephole
  sorry
def negate_lowbitmask_use2_combined := [llvmfunc|
  llvm.func @negate_lowbitmask_use2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.sub %1, %2 overflow<nsw>  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.and %3, %arg1  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_negate_lowbitmask_use2   : negate_lowbitmask_use2_before  ⊑  negate_lowbitmask_use2_combined := by
  unfold negate_lowbitmask_use2_before negate_lowbitmask_use2_combined
  simp_alive_peephole
  sorry
def test_and_or_constexpr_infloop_combined := [llvmfunc|
  llvm.func @test_and_or_constexpr_infloop() -> i64 {
    %0 = llvm.mlir.addressof @g : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i64
    %2 = llvm.mlir.constant(-8 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.and %1, %2  : i64
    %5 = llvm.or %4, %3  : i64
    llvm.return %5 : i64
  }]

theorem inst_combine_test_and_or_constexpr_infloop   : test_and_or_constexpr_infloop_before  ⊑  test_and_or_constexpr_infloop_combined := by
  unfold test_and_or_constexpr_infloop_before test_and_or_constexpr_infloop_combined
  simp_alive_peephole
  sorry
def and_zext_combined := [llvmfunc|
  llvm.func @and_zext(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.select %arg1, %2, %1 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_and_zext   : and_zext_before  ⊑  and_zext_combined := by
  unfold and_zext_before and_zext_combined
  simp_alive_peephole
  sorry
def and_zext_commuted_combined := [llvmfunc|
  llvm.func @and_zext_commuted(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.select %arg1, %2, %1 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_and_zext_commuted   : and_zext_commuted_before  ⊑  and_zext_commuted_combined := by
  unfold and_zext_commuted_before and_zext_commuted_combined
  simp_alive_peephole
  sorry
def and_zext_multiuse_combined := [llvmfunc|
  llvm.func @and_zext_multiuse(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.zext %arg1 : i1 to i32
    llvm.call @use32(%0) : (i32) -> ()
    %1 = llvm.and %0, %arg0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_and_zext_multiuse   : and_zext_multiuse_before  ⊑  and_zext_multiuse_combined := by
  unfold and_zext_multiuse_before and_zext_multiuse_combined
  simp_alive_peephole
  sorry
def and_zext_vec_combined := [llvmfunc|
  llvm.func @and_zext_vec(%arg0: vector<2xi32>, %arg1: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.and %arg0, %0  : vector<2xi32>
    %4 = llvm.select %arg1, %3, %2 : vector<2xi1>, vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

theorem inst_combine_and_zext_vec   : and_zext_vec_before  ⊑  and_zext_vec_combined := by
  unfold and_zext_vec_before and_zext_vec_combined
  simp_alive_peephole
  sorry
def and_zext_eq_even_combined := [llvmfunc|
  llvm.func @and_zext_eq_even(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_and_zext_eq_even   : and_zext_eq_even_before  ⊑  and_zext_eq_even_combined := by
  unfold and_zext_eq_even_before and_zext_eq_even_combined
  simp_alive_peephole
  sorry
def and_zext_eq_even_commuted_combined := [llvmfunc|
  llvm.func @and_zext_eq_even_commuted(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_and_zext_eq_even_commuted   : and_zext_eq_even_commuted_before  ⊑  and_zext_eq_even_commuted_combined := by
  unfold and_zext_eq_even_commuted_before and_zext_eq_even_commuted_combined
  simp_alive_peephole
  sorry
def and_zext_eq_odd_combined := [llvmfunc|
  llvm.func @and_zext_eq_odd(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.zext %1 : i1 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_and_zext_eq_odd   : and_zext_eq_odd_before  ⊑  and_zext_eq_odd_combined := by
  unfold and_zext_eq_odd_before and_zext_eq_odd_combined
  simp_alive_peephole
  sorry
def and_zext_eq_odd_commuted_combined := [llvmfunc|
  llvm.func @and_zext_eq_odd_commuted(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.zext %1 : i1 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_and_zext_eq_odd_commuted   : and_zext_eq_odd_commuted_before  ⊑  and_zext_eq_odd_commuted_combined := by
  unfold and_zext_eq_odd_commuted_before and_zext_eq_odd_commuted_combined
  simp_alive_peephole
  sorry
def and_zext_eq_zero_combined := [llvmfunc|
  llvm.func @and_zext_eq_zero(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.zext %1 : i1 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_and_zext_eq_zero   : and_zext_eq_zero_before  ⊑  and_zext_eq_zero_combined := by
  unfold and_zext_eq_zero_before and_zext_eq_zero_combined
  simp_alive_peephole
  sorry
def canonicalize_and_add_power2_or_zero_combined := [llvmfunc|
  llvm.func @canonicalize_and_add_power2_or_zero(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.and %2, %arg1  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.mul %arg0, %arg0  : i32
    %5 = llvm.xor %4, %1  : i32
    %6 = llvm.and %3, %5  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_canonicalize_and_add_power2_or_zero   : canonicalize_and_add_power2_or_zero_before  ⊑  canonicalize_and_add_power2_or_zero_combined := by
  unfold canonicalize_and_add_power2_or_zero_before canonicalize_and_add_power2_or_zero_combined
  simp_alive_peephole
  sorry
def canonicalize_and_sub_power2_or_zero_combined := [llvmfunc|
  llvm.func @canonicalize_and_sub_power2_or_zero(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.and %2, %arg1  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.xor %arg0, %1  : i32
    %5 = llvm.and %3, %4  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_canonicalize_and_sub_power2_or_zero   : canonicalize_and_sub_power2_or_zero_before  ⊑  canonicalize_and_sub_power2_or_zero_combined := by
  unfold canonicalize_and_sub_power2_or_zero_before canonicalize_and_sub_power2_or_zero_combined
  simp_alive_peephole
  sorry
def canonicalize_and_add_power2_or_zero_commuted1_combined := [llvmfunc|
  llvm.func @canonicalize_and_add_power2_or_zero_commuted1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.and %2, %arg1  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.xor %arg0, %1  : i32
    %5 = llvm.and %3, %4  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_canonicalize_and_add_power2_or_zero_commuted1   : canonicalize_and_add_power2_or_zero_commuted1_before  ⊑  canonicalize_and_add_power2_or_zero_commuted1_combined := by
  unfold canonicalize_and_add_power2_or_zero_commuted1_before canonicalize_and_add_power2_or_zero_commuted1_combined
  simp_alive_peephole
  sorry
def canonicalize_and_add_power2_or_zero_commuted2_combined := [llvmfunc|
  llvm.func @canonicalize_and_add_power2_or_zero_commuted2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.and %2, %arg1  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.mul %arg0, %arg0  : i32
    %5 = llvm.xor %4, %1  : i32
    %6 = llvm.and %3, %5  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_canonicalize_and_add_power2_or_zero_commuted2   : canonicalize_and_add_power2_or_zero_commuted2_before  ⊑  canonicalize_and_add_power2_or_zero_commuted2_combined := by
  unfold canonicalize_and_add_power2_or_zero_commuted2_before canonicalize_and_add_power2_or_zero_commuted2_combined
  simp_alive_peephole
  sorry
def canonicalize_and_add_power2_or_zero_commuted3_combined := [llvmfunc|
  llvm.func @canonicalize_and_add_power2_or_zero_commuted3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.and %2, %arg1  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.xor %arg0, %1  : i32
    %5 = llvm.and %3, %4  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_canonicalize_and_add_power2_or_zero_commuted3   : canonicalize_and_add_power2_or_zero_commuted3_before  ⊑  canonicalize_and_add_power2_or_zero_commuted3_combined := by
  unfold canonicalize_and_add_power2_or_zero_commuted3_before canonicalize_and_add_power2_or_zero_commuted3_combined
  simp_alive_peephole
  sorry
def canonicalize_and_sub_power2_or_zero_commuted_nofold_combined := [llvmfunc|
  llvm.func @canonicalize_and_sub_power2_or_zero_commuted_nofold(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg1  : i32
    %2 = llvm.and %1, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.sub %2, %arg0  : i32
    %4 = llvm.and %3, %2  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_canonicalize_and_sub_power2_or_zero_commuted_nofold   : canonicalize_and_sub_power2_or_zero_commuted_nofold_before  ⊑  canonicalize_and_sub_power2_or_zero_commuted_nofold_combined := by
  unfold canonicalize_and_sub_power2_or_zero_commuted_nofold_before canonicalize_and_sub_power2_or_zero_commuted_nofold_combined
  simp_alive_peephole
  sorry
def canonicalize_and_add_non_power2_or_zero_nofold_combined := [llvmfunc|
  llvm.func @canonicalize_and_add_non_power2_or_zero_nofold(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.add %arg0, %arg1  : i32
    %1 = llvm.and %0, %arg1  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_canonicalize_and_add_non_power2_or_zero_nofold   : canonicalize_and_add_non_power2_or_zero_nofold_before  ⊑  canonicalize_and_add_non_power2_or_zero_nofold_combined := by
  unfold canonicalize_and_add_non_power2_or_zero_nofold_before canonicalize_and_add_non_power2_or_zero_nofold_combined
  simp_alive_peephole
  sorry
def canonicalize_and_add_power2_or_zero_multiuse_nofold_combined := [llvmfunc|
  llvm.func @canonicalize_and_add_power2_or_zero_multiuse_nofold(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg1  : i32
    %2 = llvm.and %1, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.mul %arg0, %arg0  : i32
    %4 = llvm.add %3, %2  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.and %4, %2  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_canonicalize_and_add_power2_or_zero_multiuse_nofold   : canonicalize_and_add_power2_or_zero_multiuse_nofold_before  ⊑  canonicalize_and_add_power2_or_zero_multiuse_nofold_combined := by
  unfold canonicalize_and_add_power2_or_zero_multiuse_nofold_before canonicalize_and_add_power2_or_zero_multiuse_nofold_combined
  simp_alive_peephole
  sorry
def canonicalize_and_sub_power2_or_zero_multiuse_nofold_combined := [llvmfunc|
  llvm.func @canonicalize_and_sub_power2_or_zero_multiuse_nofold(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg1  : i32
    %2 = llvm.and %1, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.sub %arg0, %2  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.and %3, %2  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_canonicalize_and_sub_power2_or_zero_multiuse_nofold   : canonicalize_and_sub_power2_or_zero_multiuse_nofold_before  ⊑  canonicalize_and_sub_power2_or_zero_multiuse_nofold_combined := by
  unfold canonicalize_and_sub_power2_or_zero_multiuse_nofold_before canonicalize_and_sub_power2_or_zero_multiuse_nofold_combined
  simp_alive_peephole
  sorry
def add_constant_equal_with_the_top_bit_of_demandedbits_pass_combined := [llvmfunc|
  llvm.func @add_constant_equal_with_the_top_bit_of_demandedbits_pass(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.xor %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_add_constant_equal_with_the_top_bit_of_demandedbits_pass   : add_constant_equal_with_the_top_bit_of_demandedbits_pass_before  ⊑  add_constant_equal_with_the_top_bit_of_demandedbits_pass_combined := by
  unfold add_constant_equal_with_the_top_bit_of_demandedbits_pass_before add_constant_equal_with_the_top_bit_of_demandedbits_pass_combined
  simp_alive_peephole
  sorry
def add_constant_equal_with_the_top_bit_of_demandedbits_pass_vector_combined := [llvmfunc|
  llvm.func @add_constant_equal_with_the_top_bit_of_demandedbits_pass_vector(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<24> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(dense<16> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.and %arg0, %0  : vector<2xi16>
    %3 = llvm.xor %2, %1  : vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

theorem inst_combine_add_constant_equal_with_the_top_bit_of_demandedbits_pass_vector   : add_constant_equal_with_the_top_bit_of_demandedbits_pass_vector_before  ⊑  add_constant_equal_with_the_top_bit_of_demandedbits_pass_vector_combined := by
  unfold add_constant_equal_with_the_top_bit_of_demandedbits_pass_vector_before add_constant_equal_with_the_top_bit_of_demandedbits_pass_vector_combined
  simp_alive_peephole
  sorry
def add_constant_equal_with_the_top_bit_of_demandedbits_fail1_combined := [llvmfunc|
  llvm.func @add_constant_equal_with_the_top_bit_of_demandedbits_fail1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(24 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_add_constant_equal_with_the_top_bit_of_demandedbits_fail1   : add_constant_equal_with_the_top_bit_of_demandedbits_fail1_before  ⊑  add_constant_equal_with_the_top_bit_of_demandedbits_fail1_combined := by
  unfold add_constant_equal_with_the_top_bit_of_demandedbits_fail1_before add_constant_equal_with_the_top_bit_of_demandedbits_fail1_combined
  simp_alive_peephole
  sorry
def add_constant_equal_with_the_top_bit_of_demandedbits_fail2_combined := [llvmfunc|
  llvm.func @add_constant_equal_with_the_top_bit_of_demandedbits_fail2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.and %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_add_constant_equal_with_the_top_bit_of_demandedbits_fail2   : add_constant_equal_with_the_top_bit_of_demandedbits_fail2_before  ⊑  add_constant_equal_with_the_top_bit_of_demandedbits_fail2_combined := by
  unfold add_constant_equal_with_the_top_bit_of_demandedbits_fail2_before add_constant_equal_with_the_top_bit_of_demandedbits_fail2_combined
  simp_alive_peephole
  sorry
def add_constant_equal_with_the_top_bit_of_demandedbits_insertpt_combined := [llvmfunc|
  llvm.func @add_constant_equal_with_the_top_bit_of_demandedbits_insertpt(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(24 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.or %2, %arg1  : i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_add_constant_equal_with_the_top_bit_of_demandedbits_insertpt   : add_constant_equal_with_the_top_bit_of_demandedbits_insertpt_before  ⊑  add_constant_equal_with_the_top_bit_of_demandedbits_insertpt_combined := by
  unfold add_constant_equal_with_the_top_bit_of_demandedbits_insertpt_before add_constant_equal_with_the_top_bit_of_demandedbits_insertpt_combined
  simp_alive_peephole
  sorry
def and_sext_multiuse_combined := [llvmfunc|
  llvm.func @and_sext_multiuse(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i32
    %1 = llvm.sext %0 : i1 to i32
    %2 = llvm.and %1, %arg2  : i32
    %3 = llvm.and %1, %arg3  : i32
    %4 = llvm.add %2, %3  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_and_sext_multiuse   : and_sext_multiuse_before  ⊑  and_sext_multiuse_combined := by
  unfold and_sext_multiuse_before and_sext_multiuse_combined
  simp_alive_peephole
  sorry
