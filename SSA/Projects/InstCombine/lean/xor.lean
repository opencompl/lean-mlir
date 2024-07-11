import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  xor
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test0_before := [llvmfunc|
  llvm.func @test0(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.xor %arg0, %0  : i1
    llvm.return %1 : i1
  }]

def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    llvm.return %1 : i32
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i1) -> i1 {
    %0 = llvm.xor %arg0, %arg0  : i1
    llvm.return %0 : i1
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: i32) -> i32 {
    %0 = llvm.xor %arg0, %arg0  : i32
    llvm.return %0 : i32
  }]

def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %0, %arg0  : i32
    %2 = llvm.xor %arg0, %1  : i32
    llvm.return %2 : i32
  }]

def test5_before := [llvmfunc|
  llvm.func @test5(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.or %arg0, %0  : i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }]

def test6_before := [llvmfunc|
  llvm.func @test6(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(17 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %1, %0  : i8
    llvm.return %2 : i8
  }]

def test7_before := [llvmfunc|
  llvm.func @test7(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.and %arg1, %1  : i32
    %4 = llvm.xor %2, %3  : i32
    llvm.return %4 : i32
  }]

def test8_before := [llvmfunc|
  llvm.func @test8(%arg0: i1) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.mlir.constant(1 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i1
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %2 : i8
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i8
  }]

def test9_before := [llvmfunc|
  llvm.func @test9(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(34 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

def test9vec_before := [llvmfunc|
  llvm.func @test9vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<123> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<34> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.xor %arg0, %0  : vector<2xi8>
    %3 = llvm.icmp "eq" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

def test10_before := [llvmfunc|
  llvm.func @test10(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }]

def test11_before := [llvmfunc|
  llvm.func @test11(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(12 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }]

def test12_before := [llvmfunc|
  llvm.func @test12(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }]

def test12vec_before := [llvmfunc|
  llvm.func @test12vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.xor %arg0, %0  : vector<2xi8>
    %4 = llvm.icmp "ne" %3, %2 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }]

def test18_before := [llvmfunc|
  llvm.func @test18(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(123 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.sub %1, %2  : i32
    llvm.return %3 : i32
  }]

def test19_before := [llvmfunc|
  llvm.func @test19(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.xor %arg0, %arg1  : i32
    %1 = llvm.xor %0, %arg0  : i32
    llvm.return %1 : i32
  }]

def test20_before := [llvmfunc|
  llvm.func @test20(%arg0: i32, %arg1: i32) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @G1 : !llvm.ptr
    %2 = llvm.mlir.addressof @G2 : !llvm.ptr
    %3 = llvm.xor %arg1, %arg0  : i32
    %4 = llvm.xor %3, %arg1  : i32
    %5 = llvm.xor %4, %3  : i32
    llvm.store %5, %1 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %4, %2 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def test22_before := [llvmfunc|
  llvm.func @test22(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i1
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.xor %3, %1  : i32
    llvm.return %4 : i32
  }]

def fold_zext_xor_sandwich_before := [llvmfunc|
  llvm.func @fold_zext_xor_sandwich(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i1
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.xor %3, %1  : i32
    llvm.return %4 : i32
  }]

def fold_zext_xor_sandwich_vec_before := [llvmfunc|
  llvm.func @fold_zext_xor_sandwich_vec(%arg0: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.xor %arg0, %1  : vector<2xi1>
    %4 = llvm.zext %3 : vector<2xi1> to vector<2xi32>
    %5 = llvm.xor %4, %2  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

def test23_before := [llvmfunc|
  llvm.func @test23(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.xor %arg1, %arg0  : i32
    %1 = llvm.icmp "eq" %0, %arg0 : i32
    llvm.return %1 : i1
  }]

def test24_before := [llvmfunc|
  llvm.func @test24(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.xor %arg1, %arg0  : i32
    %1 = llvm.icmp "ne" %0, %arg0 : i32
    llvm.return %1 : i1
  }]

def test25_before := [llvmfunc|
  llvm.func @test25(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.and %1, %arg0  : i32
    %3 = llvm.xor %2, %arg0  : i32
    llvm.return %3 : i32
  }]

def test27_before := [llvmfunc|
  llvm.func @test27(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.xor %arg2, %arg0  : i32
    %1 = llvm.xor %arg2, %arg1  : i32
    %2 = llvm.icmp "eq" %0, %1 : i32
    %3 = llvm.zext %2 : i1 to i32
    llvm.return %3 : i32
  }]

def test28_before := [llvmfunc|
  llvm.func @test28(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2147483647 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.xor %2, %1  : i32
    llvm.return %3 : i32
  }]

def test28vec_before := [llvmfunc|
  llvm.func @test28vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-2147483647> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-2147483648> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %arg0, %0  : vector<2xi32>
    %3 = llvm.xor %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def test28_sub_before := [llvmfunc|
  llvm.func @test28_sub(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2147483647 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.xor %2, %1  : i32
    llvm.return %3 : i32
  }]

def test28_subvec_before := [llvmfunc|
  llvm.func @test28_subvec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-2147483647> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-2147483648> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sub %0, %arg0  : vector<2xi32>
    %3 = llvm.xor %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def test29_before := [llvmfunc|
  llvm.func @test29(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1000 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.mlir.constant(123 : i32) : i32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    %4 = llvm.xor %3, %2  : i32
    llvm.return %4 : i32
  }]

def test29vec_before := [llvmfunc|
  llvm.func @test29vec(%arg0: i1) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1000> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<10> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<123> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.select %arg0, %0, %1 : i1, vector<2xi32>
    %4 = llvm.xor %3, %2  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def test29vec2_before := [llvmfunc|
  llvm.func @test29vec2(%arg0: i1) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[1000, 2500]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[10, 30]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<[123, 333]> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.select %arg0, %0, %1 : i1, vector<2xi32>
    %4 = llvm.xor %3, %2  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def test30_before := [llvmfunc|
  llvm.func @test30(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1000 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.mlir.constant(123 : i32) : i32
    llvm.cond_br %arg0, ^bb2(%0 : i32), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%1 : i32)
  ^bb2(%3: i32):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.xor %3, %2  : i32
    llvm.return %4 : i32
  }]

def test30vec_before := [llvmfunc|
  llvm.func @test30vec(%arg0: i1) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1000> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<10> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<123> : vector<2xi32>) : vector<2xi32>
    llvm.cond_br %arg0, ^bb2(%0 : vector<2xi32>), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%1 : vector<2xi32>)
  ^bb2(%3: vector<2xi32>):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.xor %3, %2  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def test30vec2_before := [llvmfunc|
  llvm.func @test30vec2(%arg0: i1) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[1000, 2500]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[10, 30]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<[123, 333]> : vector<2xi32>) : vector<2xi32>
    llvm.cond_br %arg0, ^bb2(%0 : vector<2xi32>), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%1 : vector<2xi32>)
  ^bb2(%3: vector<2xi32>):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.xor %3, %2  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def or_xor_commute1_before := [llvmfunc|
  llvm.func @or_xor_commute1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.udiv %0, %arg0  : i32
    %2 = llvm.udiv %0, %arg1  : i32
    %3 = llvm.or %2, %1  : i32
    %4 = llvm.xor %2, %3  : i32
    llvm.return %4 : i32
  }]

def or_xor_commute2_before := [llvmfunc|
  llvm.func @or_xor_commute2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.udiv %0, %arg0  : i32
    %2 = llvm.udiv %0, %arg1  : i32
    %3 = llvm.or %1, %2  : i32
    %4 = llvm.xor %3, %2  : i32
    llvm.return %4 : i32
  }]

def or_xor_commute3_before := [llvmfunc|
  llvm.func @or_xor_commute3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.udiv %0, %arg0  : i32
    %2 = llvm.udiv %0, %arg1  : i32
    %3 = llvm.or %2, %1  : i32
    %4 = llvm.xor %3, %2  : i32
    llvm.return %4 : i32
  }]

def or_xor_commute4_before := [llvmfunc|
  llvm.func @or_xor_commute4(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.udiv %0, %arg0  : i32
    %2 = llvm.udiv %0, %arg1  : i32
    %3 = llvm.or %1, %2  : i32
    %4 = llvm.xor %2, %3  : i32
    llvm.return %4 : i32
  }]

def or_xor_extra_use_before := [llvmfunc|
  llvm.func @or_xor_extra_use(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.or %arg0, %arg1  : i32
    llvm.store %0, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

    %1 = llvm.xor %arg1, %0  : i32
    llvm.return %1 : i32
  }]

def and_xor_commute1_before := [llvmfunc|
  llvm.func @and_xor_commute1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.udiv %0, %arg0  : i32
    %2 = llvm.udiv %0, %arg1  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.xor %2, %3  : i32
    llvm.return %4 : i32
  }]

def and_xor_commute2_before := [llvmfunc|
  llvm.func @and_xor_commute2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.udiv %0, %arg0  : i32
    %2 = llvm.udiv %0, %arg1  : i32
    %3 = llvm.and %1, %2  : i32
    %4 = llvm.xor %3, %2  : i32
    llvm.return %4 : i32
  }]

def and_xor_commute3_before := [llvmfunc|
  llvm.func @and_xor_commute3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.udiv %0, %arg0  : i32
    %2 = llvm.udiv %0, %arg1  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.xor %3, %2  : i32
    llvm.return %4 : i32
  }]

def and_xor_commute4_before := [llvmfunc|
  llvm.func @and_xor_commute4(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.udiv %0, %arg0  : i32
    %2 = llvm.udiv %0, %arg1  : i32
    %3 = llvm.and %1, %2  : i32
    %4 = llvm.xor %2, %3  : i32
    llvm.return %4 : i32
  }]

def and_xor_extra_use_before := [llvmfunc|
  llvm.func @and_xor_extra_use(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.and %arg0, %arg1  : i32
    llvm.store %0, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

    %1 = llvm.xor %arg1, %0  : i32
    llvm.return %1 : i32
  }]

def xor_or_not_before := [llvmfunc|
  llvm.func @xor_or_not(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.mlir.constant(12 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    llvm.store %3, %arg1 {alignment = 1 : i64} : i8, !llvm.ptr]

    %4 = llvm.or %3, %1  : i8
    %5 = llvm.xor %4, %2  : i8
    llvm.return %5 : i8
  }]

def xor_or_not_uses_before := [llvmfunc|
  llvm.func @xor_or_not_uses(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.mlir.constant(12 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.or %3, %1  : i8
    llvm.store %4, %arg1 {alignment = 1 : i64} : i8, !llvm.ptr]

    %5 = llvm.xor %4, %2  : i8
    llvm.return %5 : i8
  }]

def xor_and_not_before := [llvmfunc|
  llvm.func @xor_and_not(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(42 : i8) : i8
    %2 = llvm.mlir.constant(31 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    llvm.store %3, %arg1 {alignment = 1 : i64} : i8, !llvm.ptr]

    %4 = llvm.and %3, %1  : i8
    %5 = llvm.xor %4, %2  : i8
    llvm.return %5 : i8
  }]

def xor_and_not_uses_before := [llvmfunc|
  llvm.func @xor_and_not_uses(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(42 : i8) : i8
    %2 = llvm.mlir.constant(31 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.and %3, %1  : i8
    llvm.store %4, %arg1 {alignment = 1 : i64} : i8, !llvm.ptr]

    %5 = llvm.xor %4, %2  : i8
    llvm.return %5 : i8
  }]

def test39_before := [llvmfunc|
  llvm.func @test39(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(-256 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.icmp "sgt" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    %5 = llvm.xor %4, %0  : i32
    llvm.return %5 : i32
  }]

def test40_before := [llvmfunc|
  llvm.func @test40(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.icmp "sgt" %1, %arg1 : i32
    %3 = llvm.select %2, %1, %arg1 : i1, i32
    %4 = llvm.xor %3, %0  : i32
    llvm.return %4 : i32
  }]

def test41_before := [llvmfunc|
  llvm.func @test41(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.icmp "slt" %1, %arg1 : i32
    %3 = llvm.select %2, %1, %arg1 : i1, i32
    %4 = llvm.xor %3, %0  : i32
    llvm.return %4 : i32
  }]

def test42_before := [llvmfunc|
  llvm.func @test42(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.icmp "ugt" %1, %arg1 : i32
    %3 = llvm.select %2, %1, %arg1 : i1, i32
    %4 = llvm.xor %3, %0  : i32
    llvm.return %4 : i32
  }]

def test43_before := [llvmfunc|
  llvm.func @test43(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.icmp "ult" %1, %arg1 : i32
    %3 = llvm.select %2, %1, %arg1 : i1, i32
    %4 = llvm.xor %3, %0  : i32
    llvm.return %4 : i32
  }]

def test44_before := [llvmfunc|
  llvm.func @test44(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.add %arg1, %0  : i32
    %3 = llvm.xor %arg0, %1  : i32
    %4 = llvm.icmp "ult" %2, %3 : i32
    %5 = llvm.select %4, %2, %3 : i1, i32
    %6 = llvm.xor %5, %1  : i32
    llvm.return %6 : i32
  }]

def test45_before := [llvmfunc|
  llvm.func @test45(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.icmp "ult" %1, %2 : i32
    %4 = llvm.select %3, %1, %2 : i1, i32
    %5 = llvm.xor %4, %0  : i32
    llvm.return %5 : i32
  }]

def test46_before := [llvmfunc|
  llvm.func @test46(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<-256> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.xor %arg0, %0  : vector<4xi32>
    %3 = llvm.icmp "sgt" %2, %1 : vector<4xi32>
    %4 = llvm.select %3, %2, %1 : vector<4xi1>, vector<4xi32>
    %5 = llvm.xor %4, %0  : vector<4xi32>
    llvm.return %5 : vector<4xi32>
  }]

def test47_before := [llvmfunc|
  llvm.func @test47(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.icmp "ugt" %1, %arg1 : i32
    %3 = llvm.select %2, %1, %arg1 : i1, i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.add %3, %arg2  : i32
    %6 = llvm.mul %4, %5  : i32
    llvm.return %6 : i32
  }]

def test48_before := [llvmfunc|
  llvm.func @test48(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.sub %0, %arg0  : i32
    %4 = llvm.icmp "sgt" %3, %1 : i32
    %5 = llvm.select %4, %3, %1 : i1, i32
    %6 = llvm.xor %5, %2  : i32
    llvm.return %6 : i32
  }]

def test48vec_before := [llvmfunc|
  llvm.func @test48vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-2> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.sub %0, %arg0  : vector<2xi32>
    %5 = llvm.icmp "sgt" %4, %2 : vector<2xi32>
    %6 = llvm.select %5, %4, %2 : vector<2xi1>, vector<2xi32>
    %7 = llvm.xor %6, %3  : vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }]

def test49_before := [llvmfunc|
  llvm.func @test49(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.icmp "slt" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    %5 = llvm.xor %4, %1  : i32
    llvm.return %5 : i32
  }]

def test49vec_before := [llvmfunc|
  llvm.func @test49vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-2> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %arg0, %0  : vector<2xi32>
    %3 = llvm.icmp "slt" %2, %1 : vector<2xi32>
    %4 = llvm.select %3, %2, %1 : vector<2xi1>, vector<2xi32>
    %5 = llvm.xor %4, %1  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

def test50_before := [llvmfunc|
  llvm.func @test50(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.icmp "slt" %2, %3 : i32
    %5 = llvm.select %4, %2, %3 : i1, i32
    %6 = llvm.xor %5, %1  : i32
    llvm.return %6 : i32
  }]

def test50vec_before := [llvmfunc|
  llvm.func @test50vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-2> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %arg0, %0  : vector<2xi32>
    %3 = llvm.sub %0, %arg1  : vector<2xi32>
    %4 = llvm.icmp "slt" %2, %3 : vector<2xi32>
    %5 = llvm.select %4, %2, %3 : vector<2xi1>, vector<2xi32>
    %6 = llvm.xor %5, %1  : vector<2xi32>
    llvm.return %6 : vector<2xi32>
  }]

def test51_before := [llvmfunc|
  llvm.func @test51(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.icmp "sgt" %2, %3 : i32
    %5 = llvm.select %4, %2, %3 : i1, i32
    %6 = llvm.xor %5, %1  : i32
    llvm.return %6 : i32
  }]

def test51vec_before := [llvmfunc|
  llvm.func @test51vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %arg0, %0  : vector<2xi32>
    %3 = llvm.sub %0, %arg1  : vector<2xi32>
    %4 = llvm.icmp "sgt" %2, %3 : vector<2xi32>
    %5 = llvm.select %4, %2, %3 : vector<2xi1>, vector<2xi32>
    %6 = llvm.xor %5, %1  : vector<2xi32>
    llvm.return %6 : vector<2xi32>
  }]

def or_or_xor_before := [llvmfunc|
  llvm.func @or_or_xor(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.or %arg2, %arg0  : i4
    %1 = llvm.or %arg2, %arg1  : i4
    %2 = llvm.xor %0, %1  : i4
    llvm.return %2 : i4
  }]

def or_or_xor_commute1_before := [llvmfunc|
  llvm.func @or_or_xor_commute1(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.or %arg0, %arg2  : i4
    %1 = llvm.or %arg2, %arg1  : i4
    %2 = llvm.xor %0, %1  : i4
    llvm.return %2 : i4
  }]

def or_or_xor_commute2_before := [llvmfunc|
  llvm.func @or_or_xor_commute2(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.or %arg2, %arg0  : i4
    %1 = llvm.or %arg1, %arg2  : i4
    %2 = llvm.xor %0, %1  : i4
    llvm.return %2 : i4
  }]

def or_or_xor_commute3_before := [llvmfunc|
  llvm.func @or_or_xor_commute3(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.or %arg0, %arg2  : vector<2xi4>
    %1 = llvm.or %arg1, %arg2  : vector<2xi4>
    %2 = llvm.xor %0, %1  : vector<2xi4>
    llvm.return %2 : vector<2xi4>
  }]

def or_or_xor_use1_before := [llvmfunc|
  llvm.func @or_or_xor_use1(%arg0: i4, %arg1: i4, %arg2: i4, %arg3: !llvm.ptr) -> i4 {
    %0 = llvm.or %arg2, %arg0  : i4
    llvm.store %0, %arg3 {alignment = 1 : i64} : i4, !llvm.ptr]

    %1 = llvm.or %arg2, %arg1  : i4
    %2 = llvm.xor %0, %1  : i4
    llvm.return %2 : i4
  }]

def or_or_xor_use2_before := [llvmfunc|
  llvm.func @or_or_xor_use2(%arg0: i4, %arg1: i4, %arg2: i4, %arg3: !llvm.ptr) -> i4 {
    %0 = llvm.or %arg2, %arg0  : i4
    %1 = llvm.or %arg2, %arg1  : i4
    llvm.store %1, %arg3 {alignment = 1 : i64} : i4, !llvm.ptr]

    %2 = llvm.xor %0, %1  : i4
    llvm.return %2 : i4
  }]

def not_is_canonical_before := [llvmfunc|
  llvm.func @not_is_canonical(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1073741823 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.add %2, %arg1  : i32
    %4 = llvm.shl %3, %1  : i32
    llvm.return %4 : i32
  }]

def not_shl_before := [llvmfunc|
  llvm.func @not_shl(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }]

def not_shl_vec_before := [llvmfunc|
  llvm.func @not_shl_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-32> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %arg0, %0  : vector<2xi8>
    %3 = llvm.xor %2, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def not_shl_extra_use_before := [llvmfunc|
  llvm.func @not_shl_extra_use(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }]

def not_shl_wrong_const_before := [llvmfunc|
  llvm.func @not_shl_wrong_const(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }]

def not_lshr_before := [llvmfunc|
  llvm.func @not_lshr(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }]

def not_lshr_vec_before := [llvmfunc|
  llvm.func @not_lshr_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.lshr %arg0, %0  : vector<2xi8>
    %3 = llvm.xor %2, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def not_lshr_extra_use_before := [llvmfunc|
  llvm.func @not_lshr_extra_use(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }]

def not_lshr_wrong_const_before := [llvmfunc|
  llvm.func @not_lshr_wrong_const(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }]

def ashr_not_before := [llvmfunc|
  llvm.func @ashr_not(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.ashr %2, %1  : i8
    llvm.return %3 : i8
  }]

def not_ashr_before := [llvmfunc|
  llvm.func @not_ashr(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }]

def not_ashr_vec_before := [llvmfunc|
  llvm.func @not_ashr_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.ashr %arg0, %0  : vector<2xi8>
    %3 = llvm.xor %2, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def not_ashr_extra_use_before := [llvmfunc|
  llvm.func @not_ashr_extra_use(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }]

def not_ashr_wrong_const_before := [llvmfunc|
  llvm.func @not_ashr_wrong_const(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(-2 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }]

def xor_andn_commute1_before := [llvmfunc|
  llvm.func @xor_andn_commute1(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.xor %arg0, %0  : vector<2xi32>
    %2 = llvm.and %1, %arg1  : vector<2xi32>
    %3 = llvm.xor %2, %arg0  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def xor_andn_commute2_before := [llvmfunc|
  llvm.func @xor_andn_commute2(%arg0: i33, %arg1: i33) -> i33 {
    %0 = llvm.mlir.constant(42 : i33) : i33
    %1 = llvm.mlir.constant(-1 : i33) : i33
    %2 = llvm.udiv %0, %arg1  : i33
    %3 = llvm.xor %arg0, %1  : i33
    %4 = llvm.and %2, %3  : i33
    %5 = llvm.xor %4, %arg0  : i33
    llvm.return %5 : i33
  }]

def xor_andn_commute3_before := [llvmfunc|
  llvm.func @xor_andn_commute3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.udiv %0, %arg0  : i32
    %3 = llvm.xor %2, %1  : i32
    %4 = llvm.and %3, %arg1  : i32
    %5 = llvm.xor %2, %4  : i32
    llvm.return %5 : i32
  }]

def xor_andn_commute4_before := [llvmfunc|
  llvm.func @xor_andn_commute4(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.udiv %0, %arg0  : i32
    %3 = llvm.udiv %0, %arg1  : i32
    %4 = llvm.xor %2, %1  : i32
    %5 = llvm.and %3, %4  : i32
    %6 = llvm.xor %2, %5  : i32
    llvm.return %6 : i32
  }]

def xor_orn_before := [llvmfunc|
  llvm.func @xor_orn(%arg0: vector<2xi64>, %arg1: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.xor %arg0, %0  : vector<2xi64>
    %2 = llvm.or %1, %arg1  : vector<2xi64>
    %3 = llvm.xor %2, %arg0  : vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }]

def xor_orn_commute1_before := [llvmfunc|
  llvm.func @xor_orn_commute1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.udiv %0, %arg0  : i8
    %3 = llvm.xor %2, %1  : i8
    %4 = llvm.or %3, %arg1  : i8
    %5 = llvm.xor %2, %4  : i8
    llvm.return %5 : i8
  }]

def xor_orn_commute2_before := [llvmfunc|
  llvm.func @xor_orn_commute2(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.udiv %0, %arg1  : i32
    %3 = llvm.xor %arg0, %1  : i32
    %4 = llvm.or %2, %3  : i32
    %5 = llvm.xor %4, %arg0  : i32
    llvm.return %5 : i32
  }]

def xor_orn_commute2_1use_before := [llvmfunc|
  llvm.func @xor_orn_commute2_1use(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.udiv %0, %arg1  : i32
    %3 = llvm.xor %arg0, %1  : i32
    %4 = llvm.or %2, %3  : i32
    llvm.store %3, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

    %5 = llvm.xor %4, %arg0  : i32
    llvm.return %5 : i32
  }]

def xor_orn_commute3_before := [llvmfunc|
  llvm.func @xor_orn_commute3(%arg0: i67, %arg1: i67, %arg2: !llvm.ptr) -> i67 {
    %0 = llvm.mlir.constant(42 : i67) : i67
    %1 = llvm.mlir.constant(-1 : i67) : i67
    %2 = llvm.udiv %0, %arg0  : i67
    %3 = llvm.udiv %0, %arg1  : i67
    %4 = llvm.xor %2, %1  : i67
    %5 = llvm.or %3, %4  : i67
    %6 = llvm.xor %2, %5  : i67
    llvm.return %6 : i67
  }]

def xor_orn_commute3_1use_before := [llvmfunc|
  llvm.func @xor_orn_commute3_1use(%arg0: i67, %arg1: i67, %arg2: !llvm.ptr) -> i67 {
    %0 = llvm.mlir.constant(42 : i67) : i67
    %1 = llvm.mlir.constant(-1 : i67) : i67
    %2 = llvm.udiv %0, %arg0  : i67
    %3 = llvm.udiv %0, %arg1  : i67
    %4 = llvm.xor %2, %1  : i67
    %5 = llvm.or %3, %4  : i67
    llvm.store %5, %arg2 {alignment = 4 : i64} : i67, !llvm.ptr]

    %6 = llvm.xor %2, %5  : i67
    llvm.return %6 : i67
  }]

def xor_orn_2use_before := [llvmfunc|
  llvm.func @xor_orn_2use(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr, %arg3: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    llvm.store %1, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

    %2 = llvm.or %1, %arg1  : i32
    llvm.store %2, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr]

    %3 = llvm.xor %2, %arg0  : i32
    llvm.return %3 : i32
  }]

def ctlz_pow2_before := [llvmfunc|
  llvm.func @ctlz_pow2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = "llvm.intr.ctlz"(%3) <{is_zero_poison = true}> : (i32) -> i32]

    %5 = llvm.xor %4, %1  : i32
    llvm.return %5 : i32
  }]

def cttz_pow2_before := [llvmfunc|
  llvm.func @cttz_pow2(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<7> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %0, %arg0  : vector<2xi8>
    %3 = llvm.udiv %2, %arg1  : vector<2xi8>
    %4 = "llvm.intr.cttz"(%3) <{is_zero_poison = true}> : (vector<2xi8>) -> vector<2xi8>]

    %5 = llvm.xor %4, %1  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }]

def ctlz_pow2_or_zero_before := [llvmfunc|
  llvm.func @ctlz_pow2_or_zero(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = "llvm.intr.ctlz"(%3) <{is_zero_poison = false}> : (i32) -> i32]

    %5 = llvm.xor %4, %1  : i32
    llvm.return %5 : i32
  }]

def ctlz_pow2_wrong_const_before := [llvmfunc|
  llvm.func @ctlz_pow2_wrong_const(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(30 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = "llvm.intr.ctlz"(%3) <{is_zero_poison = true}> : (i32) -> i32]

    %5 = llvm.xor %4, %1  : i32
    llvm.return %5 : i32
  }]

def tryFactorization_xor_ashr_lshr_before := [llvmfunc|
  llvm.func @tryFactorization_xor_ashr_lshr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-3 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.ashr %0, %arg0  : i32
    %3 = llvm.lshr %1, %arg0  : i32
    %4 = llvm.xor %2, %3  : i32
    llvm.return %4 : i32
  }]

def tryFactorization_xor_lshr_ashr_before := [llvmfunc|
  llvm.func @tryFactorization_xor_lshr_ashr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-3 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.ashr %0, %arg0  : i32
    %3 = llvm.lshr %1, %arg0  : i32
    %4 = llvm.xor %3, %2  : i32
    llvm.return %4 : i32
  }]

def tryFactorization_xor_ashr_lshr_negative_lhs_before := [llvmfunc|
  llvm.func @tryFactorization_xor_ashr_lshr_negative_lhs(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-3 : i32) : i32
    %1 = llvm.mlir.constant(-5 : i32) : i32
    %2 = llvm.ashr %0, %arg0  : i32
    %3 = llvm.lshr %1, %arg0  : i32
    %4 = llvm.xor %2, %3  : i32
    llvm.return %4 : i32
  }]

def tryFactorization_xor_lshr_lshr_before := [llvmfunc|
  llvm.func @tryFactorization_xor_lshr_lshr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-3 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.lshr %0, %arg0  : i32
    %3 = llvm.lshr %1, %arg0  : i32
    %4 = llvm.xor %2, %3  : i32
    llvm.return %4 : i32
  }]

def tryFactorization_xor_ashr_ashr_before := [llvmfunc|
  llvm.func @tryFactorization_xor_ashr_ashr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-3 : i32) : i32
    %1 = llvm.mlir.constant(-5 : i32) : i32
    %2 = llvm.ashr %0, %arg0  : i32
    %3 = llvm.ashr %1, %arg0  : i32
    %4 = llvm.xor %2, %3  : i32
    llvm.return %4 : i32
  }]

def PR96857_xor_with_noundef_before := [llvmfunc|
  llvm.func @PR96857_xor_with_noundef(%arg0: i4, %arg1: i4, %arg2: i4 {llvm.noundef}) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.and %arg2, %arg0  : i4
    %2 = llvm.xor %arg2, %0  : i4
    %3 = llvm.and %2, %arg1  : i4
    %4 = llvm.xor %1, %3  : i4
    llvm.return %4 : i4
  }]

def PR96857_xor_without_noundef_before := [llvmfunc|
  llvm.func @PR96857_xor_without_noundef(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.and %arg2, %arg0  : i4
    %2 = llvm.xor %arg2, %0  : i4
    %3 = llvm.and %2, %arg1  : i4
    %4 = llvm.xor %1, %3  : i4
    llvm.return %4 : i4
  }]

def test0_combined := [llvmfunc|
  llvm.func @test0(%arg0: i1) -> i1 {
    llvm.return %arg0 : i1
  }]

theorem inst_combine_test0   : test0_before  ⊑  test0_combined := by
  unfold test0_before test0_combined
  simp_alive_peephole
  sorry
def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i32) -> i32 {
    llvm.return %arg0 : i32
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-124 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
def test6_combined := [llvmfunc|
  llvm.func @test6(%arg0: i8) -> i8 {
    llvm.return %arg0 : i8
  }]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
def test7_combined := [llvmfunc|
  llvm.func @test7(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.and %arg1, %1  : i32
    %4 = llvm.or %2, %3  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_test7   : test7_before  ⊑  test7_combined := by
  unfold test7_before test7_combined
  simp_alive_peephole
  sorry
def test8_combined := [llvmfunc|
  llvm.func @test8(%arg0: i1) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    llvm.cond_br %arg0, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return %0 : i8
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i8
  }]

theorem inst_combine_test8   : test8_before  ⊑  test8_combined := by
  unfold test8_before test8_combined
  simp_alive_peephole
  sorry
def test9_combined := [llvmfunc|
  llvm.func @test9(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(89 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_test9   : test9_before  ⊑  test9_combined := by
  unfold test9_before test9_combined
  simp_alive_peephole
  sorry
def test9vec_combined := [llvmfunc|
  llvm.func @test9vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<89> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "eq" %arg0, %0 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_test9vec   : test9vec_before  ⊑  test9vec_combined := by
  unfold test9vec_before test9vec_combined
  simp_alive_peephole
  sorry
def test10_combined := [llvmfunc|
  llvm.func @test10(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.or %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_test10   : test10_before  ⊑  test10_combined := by
  unfold test10_before test10_combined
  simp_alive_peephole
  sorry
def test11_combined := [llvmfunc|
  llvm.func @test11(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-13 : i8) : i8
    %1 = llvm.mlir.constant(8 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.or %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_test11   : test11_before  ⊑  test11_combined := by
  unfold test11_before test11_combined
  simp_alive_peephole
  sorry
def test12_combined := [llvmfunc|
  llvm.func @test12(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_test12   : test12_before  ⊑  test12_combined := by
  unfold test12_before test12_combined
  simp_alive_peephole
  sorry
def test12vec_combined := [llvmfunc|
  llvm.func @test12vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "ne" %arg0, %0 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_test12vec   : test12vec_before  ⊑  test12vec_combined := by
  unfold test12vec_before test12vec_combined
  simp_alive_peephole
  sorry
def test18_combined := [llvmfunc|
  llvm.func @test18(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(124 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test18   : test18_before  ⊑  test18_combined := by
  unfold test18_before test18_combined
  simp_alive_peephole
  sorry
def test19_combined := [llvmfunc|
  llvm.func @test19(%arg0: i32, %arg1: i32) -> i32 {
    llvm.return %arg1 : i32
  }]

theorem inst_combine_test19   : test19_before  ⊑  test19_combined := by
  unfold test19_before test19_combined
  simp_alive_peephole
  sorry
def test20_combined := [llvmfunc|
  llvm.func @test20(%arg0: i32, %arg1: i32) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @G1 : !llvm.ptr
    %2 = llvm.mlir.addressof @G2 : !llvm.ptr
    llvm.store %arg1, %1 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %arg0, %2 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_test20   : test20_before  ⊑  test20_combined := by
  unfold test20_before test20_combined
  simp_alive_peephole
  sorry
def test22_combined := [llvmfunc|
  llvm.func @test22(%arg0: i1) -> i32 {
    %0 = llvm.zext %arg0 : i1 to i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test22   : test22_before  ⊑  test22_combined := by
  unfold test22_before test22_combined
  simp_alive_peephole
  sorry
def fold_zext_xor_sandwich_combined := [llvmfunc|
  llvm.func @fold_zext_xor_sandwich(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_fold_zext_xor_sandwich   : fold_zext_xor_sandwich_before  ⊑  fold_zext_xor_sandwich_combined := by
  unfold fold_zext_xor_sandwich_before fold_zext_xor_sandwich_combined
  simp_alive_peephole
  sorry
def fold_zext_xor_sandwich_vec_combined := [llvmfunc|
  llvm.func @fold_zext_xor_sandwich_vec(%arg0: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.zext %arg0 : vector<2xi1> to vector<2xi32>
    %2 = llvm.xor %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_fold_zext_xor_sandwich_vec   : fold_zext_xor_sandwich_vec_before  ⊑  fold_zext_xor_sandwich_vec_combined := by
  unfold fold_zext_xor_sandwich_vec_before fold_zext_xor_sandwich_vec_combined
  simp_alive_peephole
  sorry
def test23_combined := [llvmfunc|
  llvm.func @test23(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg1, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_test23   : test23_before  ⊑  test23_combined := by
  unfold test23_before test23_combined
  simp_alive_peephole
  sorry
def test24_combined := [llvmfunc|
  llvm.func @test24(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ne" %arg1, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_test24   : test24_before  ⊑  test24_combined := by
  unfold test24_before test24_combined
  simp_alive_peephole
  sorry
def test25_combined := [llvmfunc|
  llvm.func @test25(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.and %arg1, %arg0  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test25   : test25_before  ⊑  test25_combined := by
  unfold test25_before test25_combined
  simp_alive_peephole
  sorry
def test27_combined := [llvmfunc|
  llvm.func @test27(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i32
    %1 = llvm.zext %0 : i1 to i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test27   : test27_before  ⊑  test27_combined := by
  unfold test27_before test27_combined
  simp_alive_peephole
  sorry
def test28_combined := [llvmfunc|
  llvm.func @test28(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test28   : test28_before  ⊑  test28_combined := by
  unfold test28_before test28_combined
  simp_alive_peephole
  sorry
def test28vec_combined := [llvmfunc|
  llvm.func @test28vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.add %arg0, %0  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_test28vec   : test28vec_before  ⊑  test28vec_combined := by
  unfold test28vec_before test28vec_combined
  simp_alive_peephole
  sorry
def test28_sub_combined := [llvmfunc|
  llvm.func @test28_sub(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test28_sub   : test28_sub_before  ⊑  test28_sub_combined := by
  unfold test28_sub_before test28_sub_combined
  simp_alive_peephole
  sorry
def test28_subvec_combined := [llvmfunc|
  llvm.func @test28_subvec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sub %0, %arg0  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_test28_subvec   : test28_subvec_before  ⊑  test28_subvec_combined := by
  unfold test28_subvec_before test28_subvec_combined
  simp_alive_peephole
  sorry
def test29_combined := [llvmfunc|
  llvm.func @test29(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(915 : i32) : i32
    %1 = llvm.mlir.constant(113 : i32) : i32
    %2 = llvm.select %arg0, %0, %1 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test29   : test29_before  ⊑  test29_combined := by
  unfold test29_before test29_combined
  simp_alive_peephole
  sorry
def test29vec_combined := [llvmfunc|
  llvm.func @test29vec(%arg0: i1) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<915> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<113> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.select %arg0, %0, %1 : i1, vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_test29vec   : test29vec_before  ⊑  test29vec_combined := by
  unfold test29vec_before test29vec_combined
  simp_alive_peephole
  sorry
def test29vec2_combined := [llvmfunc|
  llvm.func @test29vec2(%arg0: i1) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[915, 2185]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[113, 339]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.select %arg0, %0, %1 : i1, vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_test29vec2   : test29vec2_before  ⊑  test29vec2_combined := by
  unfold test29vec2_before test29vec2_combined
  simp_alive_peephole
  sorry
def test30_combined := [llvmfunc|
  llvm.func @test30(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(915 : i32) : i32
    %1 = llvm.mlir.constant(113 : i32) : i32
    llvm.cond_br %arg0, ^bb2(%0 : i32), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%1 : i32)
  ^bb2(%2: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : i32
  }]

theorem inst_combine_test30   : test30_before  ⊑  test30_combined := by
  unfold test30_before test30_combined
  simp_alive_peephole
  sorry
def test30vec_combined := [llvmfunc|
  llvm.func @test30vec(%arg0: i1) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<915> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<113> : vector<2xi32>) : vector<2xi32>
    llvm.cond_br %arg0, ^bb2(%0 : vector<2xi32>), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%1 : vector<2xi32>)
  ^bb2(%2: vector<2xi32>):  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_test30vec   : test30vec_before  ⊑  test30vec_combined := by
  unfold test30vec_before test30vec_combined
  simp_alive_peephole
  sorry
def test30vec2_combined := [llvmfunc|
  llvm.func @test30vec2(%arg0: i1) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[915, 2185]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[113, 339]> : vector<2xi32>) : vector<2xi32>
    llvm.cond_br %arg0, ^bb2(%0 : vector<2xi32>), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%1 : vector<2xi32>)
  ^bb2(%2: vector<2xi32>):  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_test30vec2   : test30vec2_before  ⊑  test30vec2_combined := by
  unfold test30vec2_before test30vec2_combined
  simp_alive_peephole
  sorry
def or_xor_commute1_combined := [llvmfunc|
  llvm.func @or_xor_commute1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.udiv %0, %arg0  : i32
    %3 = llvm.udiv %0, %arg1  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.and %2, %4  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_or_xor_commute1   : or_xor_commute1_before  ⊑  or_xor_commute1_combined := by
  unfold or_xor_commute1_before or_xor_commute1_combined
  simp_alive_peephole
  sorry
def or_xor_commute2_combined := [llvmfunc|
  llvm.func @or_xor_commute2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.udiv %0, %arg0  : i32
    %3 = llvm.udiv %0, %arg1  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.and %2, %4  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_or_xor_commute2   : or_xor_commute2_before  ⊑  or_xor_commute2_combined := by
  unfold or_xor_commute2_before or_xor_commute2_combined
  simp_alive_peephole
  sorry
def or_xor_commute3_combined := [llvmfunc|
  llvm.func @or_xor_commute3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.udiv %0, %arg0  : i32
    %3 = llvm.udiv %0, %arg1  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.and %2, %4  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_or_xor_commute3   : or_xor_commute3_before  ⊑  or_xor_commute3_combined := by
  unfold or_xor_commute3_before or_xor_commute3_combined
  simp_alive_peephole
  sorry
def or_xor_commute4_combined := [llvmfunc|
  llvm.func @or_xor_commute4(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.udiv %0, %arg0  : i32
    %3 = llvm.udiv %0, %arg1  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.and %2, %4  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_or_xor_commute4   : or_xor_commute4_before  ⊑  or_xor_commute4_combined := by
  unfold or_xor_commute4_before or_xor_commute4_combined
  simp_alive_peephole
  sorry
def or_xor_extra_use_combined := [llvmfunc|
  llvm.func @or_xor_extra_use(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.or %arg0, %arg1  : i32
    llvm.store %0, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr
    %1 = llvm.xor %0, %arg1  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_or_xor_extra_use   : or_xor_extra_use_before  ⊑  or_xor_extra_use_combined := by
  unfold or_xor_extra_use_before or_xor_extra_use_combined
  simp_alive_peephole
  sorry
def and_xor_commute1_combined := [llvmfunc|
  llvm.func @and_xor_commute1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.udiv %0, %arg0  : i32
    %3 = llvm.udiv %0, %arg1  : i32
    %4 = llvm.xor %2, %1  : i32
    %5 = llvm.and %3, %4  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_and_xor_commute1   : and_xor_commute1_before  ⊑  and_xor_commute1_combined := by
  unfold and_xor_commute1_before and_xor_commute1_combined
  simp_alive_peephole
  sorry
def and_xor_commute2_combined := [llvmfunc|
  llvm.func @and_xor_commute2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.udiv %0, %arg0  : i32
    %3 = llvm.udiv %0, %arg1  : i32
    %4 = llvm.xor %2, %1  : i32
    %5 = llvm.and %3, %4  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_and_xor_commute2   : and_xor_commute2_before  ⊑  and_xor_commute2_combined := by
  unfold and_xor_commute2_before and_xor_commute2_combined
  simp_alive_peephole
  sorry
def and_xor_commute3_combined := [llvmfunc|
  llvm.func @and_xor_commute3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.udiv %0, %arg0  : i32
    %3 = llvm.udiv %0, %arg1  : i32
    %4 = llvm.xor %2, %1  : i32
    %5 = llvm.and %3, %4  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_and_xor_commute3   : and_xor_commute3_before  ⊑  and_xor_commute3_combined := by
  unfold and_xor_commute3_before and_xor_commute3_combined
  simp_alive_peephole
  sorry
def and_xor_commute4_combined := [llvmfunc|
  llvm.func @and_xor_commute4(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.udiv %0, %arg0  : i32
    %3 = llvm.udiv %0, %arg1  : i32
    %4 = llvm.xor %2, %1  : i32
    %5 = llvm.and %3, %4  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_and_xor_commute4   : and_xor_commute4_before  ⊑  and_xor_commute4_combined := by
  unfold and_xor_commute4_before and_xor_commute4_combined
  simp_alive_peephole
  sorry
def and_xor_extra_use_combined := [llvmfunc|
  llvm.func @and_xor_extra_use(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.and %arg0, %arg1  : i32
    llvm.store %0, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr
    %1 = llvm.xor %0, %arg1  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_and_xor_extra_use   : and_xor_extra_use_before  ⊑  and_xor_extra_use_combined := by
  unfold and_xor_extra_use_before and_xor_extra_use_combined
  simp_alive_peephole
  sorry
def xor_or_not_combined := [llvmfunc|
  llvm.func @xor_or_not(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(-8 : i8) : i8
    %2 = llvm.mlir.constant(-13 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    llvm.store %3, %arg1 {alignment = 1 : i64} : i8, !llvm.ptr
    %4 = llvm.and %arg0, %1  : i8
    %5 = llvm.xor %4, %2  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_xor_or_not   : xor_or_not_before  ⊑  xor_or_not_combined := by
  unfold xor_or_not_before xor_or_not_combined
  simp_alive_peephole
  sorry
def xor_or_not_uses_combined := [llvmfunc|
  llvm.func @xor_or_not_uses(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.mlir.constant(12 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.or %3, %1  : i8
    llvm.store %4, %arg1 {alignment = 1 : i64} : i8, !llvm.ptr
    %5 = llvm.xor %4, %2  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_xor_or_not_uses   : xor_or_not_uses_before  ⊑  xor_or_not_uses_combined := by
  unfold xor_or_not_uses_before xor_or_not_uses_combined
  simp_alive_peephole
  sorry
def xor_and_not_combined := [llvmfunc|
  llvm.func @xor_and_not(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(42 : i8) : i8
    %2 = llvm.mlir.constant(53 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    llvm.store %3, %arg1 {alignment = 1 : i64} : i8, !llvm.ptr
    %4 = llvm.and %arg0, %1  : i8
    %5 = llvm.xor %4, %2  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_xor_and_not   : xor_and_not_before  ⊑  xor_and_not_combined := by
  unfold xor_and_not_before xor_and_not_combined
  simp_alive_peephole
  sorry
def xor_and_not_uses_combined := [llvmfunc|
  llvm.func @xor_and_not_uses(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(53 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.xor %2, %0  : i8
    llvm.store %3, %arg1 {alignment = 1 : i64} : i8, !llvm.ptr
    %4 = llvm.xor %2, %1  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_xor_and_not_uses   : xor_and_not_uses_before  ⊑  xor_and_not_uses_combined := by
  unfold xor_and_not_uses_before xor_and_not_uses_combined
  simp_alive_peephole
  sorry
def test39_combined := [llvmfunc|
  llvm.func @test39(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.intr.smin(%arg0, %0)  : (i32, i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test39   : test39_before  ⊑  test39_combined := by
  unfold test39_before test39_combined
  simp_alive_peephole
  sorry
def test40_combined := [llvmfunc|
  llvm.func @test40(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.intr.smin(%arg0, %1)  : (i32, i32) -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test40   : test40_before  ⊑  test40_combined := by
  unfold test40_before test40_combined
  simp_alive_peephole
  sorry
def test41_combined := [llvmfunc|
  llvm.func @test41(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.intr.smax(%arg0, %1)  : (i32, i32) -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test41   : test41_before  ⊑  test41_combined := by
  unfold test41_before test41_combined
  simp_alive_peephole
  sorry
def test42_combined := [llvmfunc|
  llvm.func @test42(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.intr.umin(%arg0, %1)  : (i32, i32) -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test42   : test42_before  ⊑  test42_combined := by
  unfold test42_before test42_combined
  simp_alive_peephole
  sorry
def test43_combined := [llvmfunc|
  llvm.func @test43(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.intr.umax(%arg0, %1)  : (i32, i32) -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test43   : test43_before  ⊑  test43_combined := by
  unfold test43_before test43_combined
  simp_alive_peephole
  sorry
def test44_combined := [llvmfunc|
  llvm.func @test44(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-4 : i32) : i32
    %1 = llvm.sub %0, %arg1  : i32
    %2 = llvm.intr.umax(%arg0, %1)  : (i32, i32) -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test44   : test44_before  ⊑  test44_combined := by
  unfold test44_before test44_combined
  simp_alive_peephole
  sorry
def test45_combined := [llvmfunc|
  llvm.func @test45(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.umax(%arg1, %arg0)  : (i32, i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test45   : test45_before  ⊑  test45_combined := by
  unfold test45_before test45_combined
  simp_alive_peephole
  sorry
def test46_combined := [llvmfunc|
  llvm.func @test46(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<255> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.intr.smin(%arg0, %0)  : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_test46   : test46_before  ⊑  test46_combined := by
  unfold test46_before test46_combined
  simp_alive_peephole
  sorry
def test47_combined := [llvmfunc|
  llvm.func @test47(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.intr.umax(%1, %arg1)  : (i32, i32) -> i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.add %2, %arg2  : i32
    %5 = llvm.mul %4, %3  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_test47   : test47_before  ⊑  test47_combined := by
  unfold test47_before test47_combined
  simp_alive_peephole
  sorry
def test48_combined := [llvmfunc|
  llvm.func @test48(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.intr.smin(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test48   : test48_before  ⊑  test48_combined := by
  unfold test48_before test48_combined
  simp_alive_peephole
  sorry
def test48vec_combined := [llvmfunc|
  llvm.func @test48vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %arg0, %0  : vector<2xi32>
    %3 = llvm.intr.smin(%2, %1)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_test48vec   : test48vec_before  ⊑  test48vec_combined := by
  unfold test48vec_before test48vec_combined
  simp_alive_peephole
  sorry
def test49_combined := [llvmfunc|
  llvm.func @test49(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.intr.smax(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test49   : test49_before  ⊑  test49_combined := by
  unfold test49_before test49_combined
  simp_alive_peephole
  sorry
def test49vec_combined := [llvmfunc|
  llvm.func @test49vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.sub %0, %arg0  : vector<2xi32>
    %4 = llvm.intr.smax(%3, %2)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

theorem inst_combine_test49vec   : test49vec_before  ⊑  test49vec_combined := by
  unfold test49vec_before test49vec_combined
  simp_alive_peephole
  sorry
def test50_combined := [llvmfunc|
  llvm.func @test50(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    %2 = llvm.add %arg1, %0  : i32
    %3 = llvm.intr.smax(%1, %2)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test50   : test50_before  ⊑  test50_combined := by
  unfold test50_before test50_combined
  simp_alive_peephole
  sorry
def test50vec_combined := [llvmfunc|
  llvm.func @test50vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sub %0, %arg0  : vector<2xi32>
    %2 = llvm.add %arg1, %0  : vector<2xi32>
    %3 = llvm.intr.smax(%1, %2)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_test50vec   : test50vec_before  ⊑  test50vec_combined := by
  unfold test50vec_before test50vec_combined
  simp_alive_peephole
  sorry
def test51_combined := [llvmfunc|
  llvm.func @test51(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-3 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    %2 = llvm.add %arg1, %0  : i32
    %3 = llvm.intr.smin(%1, %2)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test51   : test51_before  ⊑  test51_combined := by
  unfold test51_before test51_combined
  simp_alive_peephole
  sorry
def test51vec_combined := [llvmfunc|
  llvm.func @test51vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-3> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sub %0, %arg0  : vector<2xi32>
    %2 = llvm.add %arg1, %0  : vector<2xi32>
    %3 = llvm.intr.smin(%1, %2)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_test51vec   : test51vec_before  ⊑  test51vec_combined := by
  unfold test51vec_before test51vec_combined
  simp_alive_peephole
  sorry
def or_or_xor_combined := [llvmfunc|
  llvm.func @or_or_xor(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.xor %arg2, %0  : i4
    %2 = llvm.xor %arg0, %arg1  : i4
    %3 = llvm.and %2, %1  : i4
    llvm.return %3 : i4
  }]

theorem inst_combine_or_or_xor   : or_or_xor_before  ⊑  or_or_xor_combined := by
  unfold or_or_xor_before or_or_xor_combined
  simp_alive_peephole
  sorry
def or_or_xor_commute1_combined := [llvmfunc|
  llvm.func @or_or_xor_commute1(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.xor %arg2, %0  : i4
    %2 = llvm.xor %arg0, %arg1  : i4
    %3 = llvm.and %2, %1  : i4
    llvm.return %3 : i4
  }]

theorem inst_combine_or_or_xor_commute1   : or_or_xor_commute1_before  ⊑  or_or_xor_commute1_combined := by
  unfold or_or_xor_commute1_before or_or_xor_commute1_combined
  simp_alive_peephole
  sorry
def or_or_xor_commute2_combined := [llvmfunc|
  llvm.func @or_or_xor_commute2(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.xor %arg2, %0  : i4
    %2 = llvm.xor %arg0, %arg1  : i4
    %3 = llvm.and %2, %1  : i4
    llvm.return %3 : i4
  }]

theorem inst_combine_or_or_xor_commute2   : or_or_xor_commute2_before  ⊑  or_or_xor_commute2_combined := by
  unfold or_or_xor_commute2_before or_or_xor_commute2_combined
  simp_alive_peephole
  sorry
def or_or_xor_commute3_combined := [llvmfunc|
  llvm.func @or_or_xor_commute3(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg2, %1  : vector<2xi4>
    %3 = llvm.xor %arg0, %arg1  : vector<2xi4>
    %4 = llvm.and %3, %2  : vector<2xi4>
    llvm.return %4 : vector<2xi4>
  }]

theorem inst_combine_or_or_xor_commute3   : or_or_xor_commute3_before  ⊑  or_or_xor_commute3_combined := by
  unfold or_or_xor_commute3_before or_or_xor_commute3_combined
  simp_alive_peephole
  sorry
def or_or_xor_use1_combined := [llvmfunc|
  llvm.func @or_or_xor_use1(%arg0: i4, %arg1: i4, %arg2: i4, %arg3: !llvm.ptr) -> i4 {
    %0 = llvm.or %arg2, %arg0  : i4
    llvm.store %0, %arg3 {alignment = 1 : i64} : i4, !llvm.ptr
    %1 = llvm.or %arg2, %arg1  : i4
    %2 = llvm.xor %0, %1  : i4
    llvm.return %2 : i4
  }]

theorem inst_combine_or_or_xor_use1   : or_or_xor_use1_before  ⊑  or_or_xor_use1_combined := by
  unfold or_or_xor_use1_before or_or_xor_use1_combined
  simp_alive_peephole
  sorry
def or_or_xor_use2_combined := [llvmfunc|
  llvm.func @or_or_xor_use2(%arg0: i4, %arg1: i4, %arg2: i4, %arg3: !llvm.ptr) -> i4 {
    %0 = llvm.or %arg2, %arg0  : i4
    %1 = llvm.or %arg2, %arg1  : i4
    llvm.store %1, %arg3 {alignment = 1 : i64} : i4, !llvm.ptr
    %2 = llvm.xor %0, %1  : i4
    llvm.return %2 : i4
  }]

theorem inst_combine_or_or_xor_use2   : or_or_xor_use2_before  ⊑  or_or_xor_use2_combined := by
  unfold or_or_xor_use2_before or_or_xor_use2_combined
  simp_alive_peephole
  sorry
def not_is_canonical_combined := [llvmfunc|
  llvm.func @not_is_canonical(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.add %2, %arg1  : i32
    %4 = llvm.shl %3, %1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_not_is_canonical   : not_is_canonical_before  ⊑  not_is_canonical_combined := by
  unfold not_is_canonical_before not_is_canonical_combined
  simp_alive_peephole
  sorry
def not_shl_combined := [llvmfunc|
  llvm.func @not_shl(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.shl %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_not_shl   : not_shl_before  ⊑  not_shl_combined := by
  unfold not_shl_before not_shl_combined
  simp_alive_peephole
  sorry
def not_shl_vec_combined := [llvmfunc|
  llvm.func @not_shl_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<5> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.xor %arg0, %0  : vector<2xi8>
    %3 = llvm.shl %2, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_not_shl_vec   : not_shl_vec_before  ⊑  not_shl_vec_combined := by
  unfold not_shl_vec_before not_shl_vec_combined
  simp_alive_peephole
  sorry
def not_shl_extra_use_combined := [llvmfunc|
  llvm.func @not_shl_extra_use(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_not_shl_extra_use   : not_shl_extra_use_before  ⊑  not_shl_extra_use_combined := by
  unfold not_shl_extra_use_before not_shl_extra_use_combined
  simp_alive_peephole
  sorry
def not_shl_wrong_const_combined := [llvmfunc|
  llvm.func @not_shl_wrong_const(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_not_shl_wrong_const   : not_shl_wrong_const_before  ⊑  not_shl_wrong_const_combined := by
  unfold not_shl_wrong_const_before not_shl_wrong_const_combined
  simp_alive_peephole
  sorry
def not_lshr_combined := [llvmfunc|
  llvm.func @not_lshr(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.lshr %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_not_lshr   : not_lshr_before  ⊑  not_lshr_combined := by
  unfold not_lshr_before not_lshr_combined
  simp_alive_peephole
  sorry
def not_lshr_vec_combined := [llvmfunc|
  llvm.func @not_lshr_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "sgt" %arg0, %0 : vector<2xi8>
    %2 = llvm.zext %1 : vector<2xi1> to vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

theorem inst_combine_not_lshr_vec   : not_lshr_vec_before  ⊑  not_lshr_vec_combined := by
  unfold not_lshr_vec_before not_lshr_vec_combined
  simp_alive_peephole
  sorry
def not_lshr_extra_use_combined := [llvmfunc|
  llvm.func @not_lshr_extra_use(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_not_lshr_extra_use   : not_lshr_extra_use_before  ⊑  not_lshr_extra_use_combined := by
  unfold not_lshr_extra_use_before not_lshr_extra_use_combined
  simp_alive_peephole
  sorry
def not_lshr_wrong_const_combined := [llvmfunc|
  llvm.func @not_lshr_wrong_const(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_not_lshr_wrong_const   : not_lshr_wrong_const_before  ⊑  not_lshr_wrong_const_combined := by
  unfold not_lshr_wrong_const_before not_lshr_wrong_const_combined
  simp_alive_peephole
  sorry
def ashr_not_combined := [llvmfunc|
  llvm.func @ashr_not(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_ashr_not   : ashr_not_before  ⊑  ashr_not_combined := by
  unfold ashr_not_before ashr_not_combined
  simp_alive_peephole
  sorry
def not_ashr_combined := [llvmfunc|
  llvm.func @not_ashr(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_not_ashr   : not_ashr_before  ⊑  not_ashr_combined := by
  unfold not_ashr_before not_ashr_combined
  simp_alive_peephole
  sorry
def not_ashr_vec_combined := [llvmfunc|
  llvm.func @not_ashr_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "sgt" %arg0, %0 : vector<2xi8>
    %2 = llvm.sext %1 : vector<2xi1> to vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

theorem inst_combine_not_ashr_vec   : not_ashr_vec_before  ⊑  not_ashr_vec_combined := by
  unfold not_ashr_vec_before not_ashr_vec_combined
  simp_alive_peephole
  sorry
def not_ashr_extra_use_combined := [llvmfunc|
  llvm.func @not_ashr_extra_use(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_not_ashr_extra_use   : not_ashr_extra_use_before  ⊑  not_ashr_extra_use_combined := by
  unfold not_ashr_extra_use_before not_ashr_extra_use_combined
  simp_alive_peephole
  sorry
def not_ashr_wrong_const_combined := [llvmfunc|
  llvm.func @not_ashr_wrong_const(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(-2 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_not_ashr_wrong_const   : not_ashr_wrong_const_before  ⊑  not_ashr_wrong_const_combined := by
  unfold not_ashr_wrong_const_before not_ashr_wrong_const_combined
  simp_alive_peephole
  sorry
def xor_andn_commute1_combined := [llvmfunc|
  llvm.func @xor_andn_commute1(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.or %arg0, %arg1  : vector<2xi32>
    llvm.return %0 : vector<2xi32>
  }]

theorem inst_combine_xor_andn_commute1   : xor_andn_commute1_before  ⊑  xor_andn_commute1_combined := by
  unfold xor_andn_commute1_before xor_andn_commute1_combined
  simp_alive_peephole
  sorry
def xor_andn_commute2_combined := [llvmfunc|
  llvm.func @xor_andn_commute2(%arg0: i33, %arg1: i33) -> i33 {
    %0 = llvm.mlir.constant(42 : i33) : i33
    %1 = llvm.udiv %0, %arg1  : i33
    %2 = llvm.or %1, %arg0  : i33
    llvm.return %2 : i33
  }]

theorem inst_combine_xor_andn_commute2   : xor_andn_commute2_before  ⊑  xor_andn_commute2_combined := by
  unfold xor_andn_commute2_before xor_andn_commute2_combined
  simp_alive_peephole
  sorry
def xor_andn_commute3_combined := [llvmfunc|
  llvm.func @xor_andn_commute3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.udiv %0, %arg0  : i32
    %2 = llvm.or %1, %arg1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_xor_andn_commute3   : xor_andn_commute3_before  ⊑  xor_andn_commute3_combined := by
  unfold xor_andn_commute3_before xor_andn_commute3_combined
  simp_alive_peephole
  sorry
def xor_andn_commute4_combined := [llvmfunc|
  llvm.func @xor_andn_commute4(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.udiv %0, %arg0  : i32
    %2 = llvm.udiv %0, %arg1  : i32
    %3 = llvm.or %1, %2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_xor_andn_commute4   : xor_andn_commute4_before  ⊑  xor_andn_commute4_combined := by
  unfold xor_andn_commute4_before xor_andn_commute4_combined
  simp_alive_peephole
  sorry
def xor_orn_combined := [llvmfunc|
  llvm.func @xor_orn(%arg0: vector<2xi64>, %arg1: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.and %arg0, %arg1  : vector<2xi64>
    %2 = llvm.xor %1, %0  : vector<2xi64>
    llvm.return %2 : vector<2xi64>
  }]

theorem inst_combine_xor_orn   : xor_orn_before  ⊑  xor_orn_combined := by
  unfold xor_orn_before xor_orn_combined
  simp_alive_peephole
  sorry
def xor_orn_commute1_combined := [llvmfunc|
  llvm.func @xor_orn_commute1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.udiv %0, %arg0  : i8
    %3 = llvm.and %2, %arg1  : i8
    %4 = llvm.xor %3, %1  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_xor_orn_commute1   : xor_orn_commute1_before  ⊑  xor_orn_commute1_combined := by
  unfold xor_orn_commute1_before xor_orn_commute1_combined
  simp_alive_peephole
  sorry
def xor_orn_commute2_combined := [llvmfunc|
  llvm.func @xor_orn_commute2(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.udiv %0, %arg1  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.xor %3, %1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_xor_orn_commute2   : xor_orn_commute2_before  ⊑  xor_orn_commute2_combined := by
  unfold xor_orn_commute2_before xor_orn_commute2_combined
  simp_alive_peephole
  sorry
def xor_orn_commute2_1use_combined := [llvmfunc|
  llvm.func @xor_orn_commute2_1use(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.udiv %0, %arg1  : i32
    %3 = llvm.xor %arg0, %1  : i32
    llvm.store %3, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr
    %4 = llvm.and %2, %arg0  : i32
    %5 = llvm.xor %4, %1  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_xor_orn_commute2_1use   : xor_orn_commute2_1use_before  ⊑  xor_orn_commute2_1use_combined := by
  unfold xor_orn_commute2_1use_before xor_orn_commute2_1use_combined
  simp_alive_peephole
  sorry
def xor_orn_commute3_combined := [llvmfunc|
  llvm.func @xor_orn_commute3(%arg0: i67, %arg1: i67, %arg2: !llvm.ptr) -> i67 {
    %0 = llvm.mlir.constant(42 : i67) : i67
    %1 = llvm.mlir.constant(-1 : i67) : i67
    %2 = llvm.udiv %0, %arg0  : i67
    %3 = llvm.udiv %0, %arg1  : i67
    %4 = llvm.and %2, %3  : i67
    %5 = llvm.xor %4, %1  : i67
    llvm.return %5 : i67
  }]

theorem inst_combine_xor_orn_commute3   : xor_orn_commute3_before  ⊑  xor_orn_commute3_combined := by
  unfold xor_orn_commute3_before xor_orn_commute3_combined
  simp_alive_peephole
  sorry
def xor_orn_commute3_1use_combined := [llvmfunc|
  llvm.func @xor_orn_commute3_1use(%arg0: i67, %arg1: i67, %arg2: !llvm.ptr) -> i67 {
    %0 = llvm.mlir.constant(42 : i67) : i67
    %1 = llvm.mlir.constant(-1 : i67) : i67
    %2 = llvm.udiv %0, %arg0  : i67
    %3 = llvm.udiv %0, %arg1  : i67
    %4 = llvm.xor %2, %1  : i67
    %5 = llvm.or %3, %4  : i67
    llvm.store %5, %arg2 {alignment = 4 : i64} : i67, !llvm.ptr
    %6 = llvm.xor %2, %5  : i67
    llvm.return %6 : i67
  }]

theorem inst_combine_xor_orn_commute3_1use   : xor_orn_commute3_1use_before  ⊑  xor_orn_commute3_1use_combined := by
  unfold xor_orn_commute3_1use_before xor_orn_commute3_1use_combined
  simp_alive_peephole
  sorry
def xor_orn_2use_combined := [llvmfunc|
  llvm.func @xor_orn_2use(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr, %arg3: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    llvm.store %1, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr
    %2 = llvm.or %1, %arg1  : i32
    llvm.store %2, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr
    %3 = llvm.xor %2, %arg0  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_xor_orn_2use   : xor_orn_2use_before  ⊑  xor_orn_2use_combined := by
  unfold xor_orn_2use_before xor_orn_2use_combined
  simp_alive_peephole
  sorry
def ctlz_pow2_combined := [llvmfunc|
  llvm.func @ctlz_pow2(%arg0: i32) -> i32 {
    %0 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_ctlz_pow2   : ctlz_pow2_before  ⊑  ctlz_pow2_combined := by
  unfold ctlz_pow2_before ctlz_pow2_combined
  simp_alive_peephole
  sorry
def cttz_pow2_combined := [llvmfunc|
  llvm.func @cttz_pow2(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.shl %0, %arg0 overflow<nuw>  : vector<2xi8>
    %2 = llvm.udiv %1, %arg1  : vector<2xi8>
    %3 = "llvm.intr.ctlz"(%2) <{is_zero_poison = true}> : (vector<2xi8>) -> vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_cttz_pow2   : cttz_pow2_before  ⊑  cttz_pow2_combined := by
  unfold cttz_pow2_before cttz_pow2_combined
  simp_alive_peephole
  sorry
def ctlz_pow2_or_zero_combined := [llvmfunc|
  llvm.func @ctlz_pow2_or_zero(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = "llvm.intr.ctlz"(%3) <{is_zero_poison = false}> : (i32) -> i32
    %5 = llvm.xor %4, %1  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_ctlz_pow2_or_zero   : ctlz_pow2_or_zero_before  ⊑  ctlz_pow2_or_zero_combined := by
  unfold ctlz_pow2_or_zero_before ctlz_pow2_or_zero_combined
  simp_alive_peephole
  sorry
def ctlz_pow2_wrong_const_combined := [llvmfunc|
  llvm.func @ctlz_pow2_wrong_const(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(30 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = "llvm.intr.ctlz"(%3) <{is_zero_poison = true}> : (i32) -> i32
    %5 = llvm.xor %4, %1  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_ctlz_pow2_wrong_const   : ctlz_pow2_wrong_const_before  ⊑  ctlz_pow2_wrong_const_combined := by
  unfold ctlz_pow2_wrong_const_before ctlz_pow2_wrong_const_combined
  simp_alive_peephole
  sorry
def tryFactorization_xor_ashr_lshr_combined := [llvmfunc|
  llvm.func @tryFactorization_xor_ashr_lshr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-8 : i32) : i32
    %1 = llvm.ashr %0, %arg0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_tryFactorization_xor_ashr_lshr   : tryFactorization_xor_ashr_lshr_before  ⊑  tryFactorization_xor_ashr_lshr_combined := by
  unfold tryFactorization_xor_ashr_lshr_before tryFactorization_xor_ashr_lshr_combined
  simp_alive_peephole
  sorry
def tryFactorization_xor_lshr_ashr_combined := [llvmfunc|
  llvm.func @tryFactorization_xor_lshr_ashr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-8 : i32) : i32
    %1 = llvm.ashr %0, %arg0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_tryFactorization_xor_lshr_ashr   : tryFactorization_xor_lshr_ashr_before  ⊑  tryFactorization_xor_lshr_ashr_combined := by
  unfold tryFactorization_xor_lshr_ashr_before tryFactorization_xor_lshr_ashr_combined
  simp_alive_peephole
  sorry
def tryFactorization_xor_ashr_lshr_negative_lhs_combined := [llvmfunc|
  llvm.func @tryFactorization_xor_ashr_lshr_negative_lhs(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-3 : i32) : i32
    %1 = llvm.mlir.constant(-5 : i32) : i32
    %2 = llvm.ashr %0, %arg0  : i32
    %3 = llvm.lshr %1, %arg0  : i32
    %4 = llvm.xor %2, %3  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_tryFactorization_xor_ashr_lshr_negative_lhs   : tryFactorization_xor_ashr_lshr_negative_lhs_before  ⊑  tryFactorization_xor_ashr_lshr_negative_lhs_combined := by
  unfold tryFactorization_xor_ashr_lshr_negative_lhs_before tryFactorization_xor_ashr_lshr_negative_lhs_combined
  simp_alive_peephole
  sorry
def tryFactorization_xor_lshr_lshr_combined := [llvmfunc|
  llvm.func @tryFactorization_xor_lshr_lshr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-8 : i32) : i32
    %1 = llvm.lshr %0, %arg0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_tryFactorization_xor_lshr_lshr   : tryFactorization_xor_lshr_lshr_before  ⊑  tryFactorization_xor_lshr_lshr_combined := by
  unfold tryFactorization_xor_lshr_lshr_before tryFactorization_xor_lshr_lshr_combined
  simp_alive_peephole
  sorry
def tryFactorization_xor_ashr_ashr_combined := [llvmfunc|
  llvm.func @tryFactorization_xor_ashr_ashr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.lshr %0, %arg0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_tryFactorization_xor_ashr_ashr   : tryFactorization_xor_ashr_ashr_before  ⊑  tryFactorization_xor_ashr_ashr_combined := by
  unfold tryFactorization_xor_ashr_ashr_before tryFactorization_xor_ashr_ashr_combined
  simp_alive_peephole
  sorry
def PR96857_xor_with_noundef_combined := [llvmfunc|
  llvm.func @PR96857_xor_with_noundef(%arg0: i4, %arg1: i4, %arg2: i4 {llvm.noundef}) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.and %arg2, %arg0  : i4
    %2 = llvm.xor %arg2, %0  : i4
    %3 = llvm.and %2, %arg1  : i4
    %4 = llvm.or %1, %3  : i4
    llvm.return %4 : i4
  }]

theorem inst_combine_PR96857_xor_with_noundef   : PR96857_xor_with_noundef_before  ⊑  PR96857_xor_with_noundef_combined := by
  unfold PR96857_xor_with_noundef_before PR96857_xor_with_noundef_combined
  simp_alive_peephole
  sorry
def PR96857_xor_without_noundef_combined := [llvmfunc|
  llvm.func @PR96857_xor_without_noundef(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.and %arg2, %arg0  : i4
    %2 = llvm.xor %arg2, %0  : i4
    %3 = llvm.and %2, %arg1  : i4
    %4 = llvm.or %1, %3  : i4
    llvm.return %4 : i4
  }]

theorem inst_combine_PR96857_xor_without_noundef   : PR96857_xor_without_noundef_before  ⊑  PR96857_xor_without_noundef_combined := by
  unfold PR96857_xor_without_noundef_before PR96857_xor_without_noundef_combined
  simp_alive_peephole
  sorry
