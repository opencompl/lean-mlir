import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  narrow-math
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def sext_sext_add_before := [llvmfunc|
  llvm.func @sext_sext_add(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.ashr %arg0, %1  : i32
    %4 = llvm.sext %2 : i32 to i64
    %5 = llvm.sext %3 : i32 to i64
    %6 = llvm.add %4, %5  : i64
    llvm.return %6 : i64
  }]

def sext_zext_add_mismatched_exts_before := [llvmfunc|
  llvm.func @sext_zext_add_mismatched_exts(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.lshr %arg0, %1  : i32
    %4 = llvm.sext %2 : i32 to i64
    %5 = llvm.zext %3 : i32 to i64
    %6 = llvm.add %4, %5  : i64
    llvm.return %6 : i64
  }]

def sext_sext_add_mismatched_types_before := [llvmfunc|
  llvm.func @sext_sext_add_mismatched_types(%arg0: i16, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(7 : i16) : i16
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i16
    %3 = llvm.ashr %arg1, %1  : i32
    %4 = llvm.sext %2 : i16 to i64
    %5 = llvm.sext %3 : i32 to i64
    %6 = llvm.add %4, %5  : i64
    llvm.return %6 : i64
  }]

def sext_sext_add_extra_use1_before := [llvmfunc|
  llvm.func @sext_sext_add_extra_use1(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.ashr %arg0, %1  : i32
    %4 = llvm.sext %2 : i32 to i64
    llvm.call @use(%4) : (i64) -> ()
    %5 = llvm.sext %3 : i32 to i64
    %6 = llvm.add %4, %5  : i64
    llvm.return %6 : i64
  }]

def sext_sext_add_extra_use2_before := [llvmfunc|
  llvm.func @sext_sext_add_extra_use2(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.ashr %arg0, %1  : i32
    %4 = llvm.sext %2 : i32 to i64
    %5 = llvm.sext %3 : i32 to i64
    llvm.call @use(%5) : (i64) -> ()
    %6 = llvm.add %4, %5  : i64
    llvm.return %6 : i64
  }]

def sext_sext_add_extra_use3_before := [llvmfunc|
  llvm.func @sext_sext_add_extra_use3(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.ashr %arg0, %1  : i32
    %4 = llvm.sext %2 : i32 to i64
    llvm.call @use(%4) : (i64) -> ()
    %5 = llvm.sext %3 : i32 to i64
    llvm.call @use(%5) : (i64) -> ()
    %6 = llvm.add %4, %5  : i64
    llvm.return %6 : i64
  }]

def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i32) -> i64 {
    %0 = llvm.call @callee() : () -> i32
    %1 = llvm.call @callee() : () -> i32
    %2 = llvm.sext %0 : i32 to i64
    %3 = llvm.sext %1 : i32 to i64
    %4 = llvm.add %2, %3  : i64
    llvm.return %4 : i64
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i32) -> i64 {
    %0 = llvm.call @callee() : () -> i32
    %1 = llvm.call @callee() : () -> i32
    %2 = llvm.add %0, %1  : i32
    %3 = llvm.sext %2 : i32 to i64
    llvm.return %3 : i64
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: i32) -> i64 {
    %0 = llvm.call @callee() : () -> i32
    %1 = llvm.call @callee() : () -> i32
    %2 = llvm.sext %0 : i32 to i64
    %3 = llvm.sext %1 : i32 to i64
    %4 = llvm.mul %2, %3  : i64
    llvm.return %4 : i64
  }]

def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: i32) -> i64 {
    %0 = llvm.call @callee() : () -> i32
    %1 = llvm.call @callee() : () -> i32
    %2 = llvm.mul %0, %1  : i32
    %3 = llvm.sext %2 : i32 to i64
    llvm.return %3 : i64
  }]

def test5_before := [llvmfunc|
  llvm.func @test5(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(1073741823 : i64) : i64
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.sext %2 : i32 to i64
    %4 = llvm.add %3, %1  : i64
    llvm.return %4 : i64
  }]

def sext_add_constant_extra_use_before := [llvmfunc|
  llvm.func @sext_add_constant_extra_use(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(1073741823 : i64) : i64
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.sext %2 : i32 to i64
    llvm.call @use(%3) : (i64) -> ()
    %4 = llvm.add %3, %1  : i64
    llvm.return %4 : i64
  }]

def test5_splat_before := [llvmfunc|
  llvm.func @test5_splat(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<1073741823> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.ashr %arg0, %0  : vector<2xi32>
    %3 = llvm.sext %2 : vector<2xi32> to vector<2xi64>
    %4 = llvm.add %3, %1  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

def test5_vec_before := [llvmfunc|
  llvm.func @test5_vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.ashr %arg0, %0  : vector<2xi32>
    %3 = llvm.sext %2 : vector<2xi32> to vector<2xi64>
    %4 = llvm.add %3, %1  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

def test6_before := [llvmfunc|
  llvm.func @test6(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1073741824 : i64) : i64
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.sext %2 : i32 to i64
    %4 = llvm.add %3, %1  : i64
    llvm.return %4 : i64
  }]

def test6_splat_before := [llvmfunc|
  llvm.func @test6_splat(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-1073741824> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.ashr %arg0, %0  : vector<2xi32>
    %3 = llvm.sext %2 : vector<2xi32> to vector<2xi64>
    %4 = llvm.add %3, %1  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

def test6_vec_before := [llvmfunc|
  llvm.func @test6_vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[-1, -2]> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.ashr %arg0, %0  : vector<2xi32>
    %3 = llvm.sext %2 : vector<2xi32> to vector<2xi64>
    %4 = llvm.add %3, %1  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

def test6_vec2_before := [llvmfunc|
  llvm.func @test6_vec2(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[-1, 1]> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.ashr %arg0, %0  : vector<2xi32>
    %3 = llvm.sext %2 : vector<2xi32> to vector<2xi64>
    %4 = llvm.add %3, %1  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

def test7_before := [llvmfunc|
  llvm.func @test7(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2147483647 : i64) : i64
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.zext %2 : i32 to i64
    %4 = llvm.add %3, %1  : i64
    llvm.return %4 : i64
  }]

def test7_splat_before := [llvmfunc|
  llvm.func @test7_splat(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<2147483647> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.lshr %arg0, %0  : vector<2xi32>
    %3 = llvm.zext %2 : vector<2xi32> to vector<2xi64>
    %4 = llvm.add %3, %1  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

def test7_vec_before := [llvmfunc|
  llvm.func @test7_vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.lshr %arg0, %0  : vector<2xi32>
    %3 = llvm.zext %2 : vector<2xi32> to vector<2xi64>
    %4 = llvm.add %3, %1  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

def test8_before := [llvmfunc|
  llvm.func @test8(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(32767 : i64) : i64
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.sext %2 : i32 to i64
    %4 = llvm.mul %3, %1  : i64
    llvm.return %4 : i64
  }]

def test8_splat_before := [llvmfunc|
  llvm.func @test8_splat(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<32767> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.ashr %arg0, %0  : vector<2xi32>
    %3 = llvm.sext %2 : vector<2xi32> to vector<2xi64>
    %4 = llvm.mul %3, %1  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

def test8_vec_before := [llvmfunc|
  llvm.func @test8_vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[32767, 16384]> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.ashr %arg0, %0  : vector<2xi32>
    %3 = llvm.sext %2 : vector<2xi32> to vector<2xi64>
    %4 = llvm.mul %3, %1  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

def test8_vec2_before := [llvmfunc|
  llvm.func @test8_vec2(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[32767, -32767]> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.ashr %arg0, %0  : vector<2xi32>
    %3 = llvm.sext %2 : vector<2xi32> to vector<2xi64>
    %4 = llvm.mul %3, %1  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

def test9_before := [llvmfunc|
  llvm.func @test9(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(-32767 : i64) : i64
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.sext %2 : i32 to i64
    %4 = llvm.mul %3, %1  : i64
    llvm.return %4 : i64
  }]

def test9_splat_before := [llvmfunc|
  llvm.func @test9_splat(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-32767> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.ashr %arg0, %0  : vector<2xi32>
    %3 = llvm.sext %2 : vector<2xi32> to vector<2xi64>
    %4 = llvm.mul %3, %1  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

def test9_vec_before := [llvmfunc|
  llvm.func @test9_vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[-32767, -10]> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.ashr %arg0, %0  : vector<2xi32>
    %3 = llvm.sext %2 : vector<2xi32> to vector<2xi64>
    %4 = llvm.mul %3, %1  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

def test10_before := [llvmfunc|
  llvm.func @test10(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(65535 : i64) : i64
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.zext %2 : i32 to i64
    %4 = llvm.mul %3, %1  : i64
    llvm.return %4 : i64
  }]

def test10_splat_before := [llvmfunc|
  llvm.func @test10_splat(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<65535> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.lshr %arg0, %0  : vector<2xi32>
    %3 = llvm.zext %2 : vector<2xi32> to vector<2xi64>
    %4 = llvm.mul %3, %1  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

def test10_vec_before := [llvmfunc|
  llvm.func @test10_vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[65535, 2]> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.lshr %arg0, %0  : vector<2xi32>
    %3 = llvm.zext %2 : vector<2xi32> to vector<2xi64>
    %4 = llvm.mul %3, %1  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

def test11_before := [llvmfunc|
  llvm.func @test11(%arg0: i32) -> i64 {
    %0 = llvm.call @callee() : () -> i32
    %1 = llvm.call @callee() : () -> i32
    %2 = llvm.sext %0 : i32 to i64
    %3 = llvm.sext %1 : i32 to i64
    %4 = llvm.add %2, %3  : i64
    llvm.return %4 : i64
  }]

def test12_before := [llvmfunc|
  llvm.func @test12(%arg0: i32) -> i64 {
    %0 = llvm.call @callee() : () -> i32
    %1 = llvm.call @callee() : () -> i32
    %2 = llvm.sext %0 : i32 to i64
    %3 = llvm.sext %1 : i32 to i64
    %4 = llvm.mul %2, %3  : i64
    llvm.return %4 : i64
  }]

def test13_before := [llvmfunc|
  llvm.func @test13(%arg0: i32) -> i64 {
    %0 = llvm.call @callee() : () -> i32
    %1 = llvm.call @callee() : () -> i32
    %2 = llvm.sext %0 : i32 to i64
    %3 = llvm.sext %1 : i32 to i64
    %4 = llvm.sub %2, %3  : i64
    llvm.return %4 : i64
  }]

def test14_before := [llvmfunc|
  llvm.func @test14(%arg0: i32) -> i64 {
    %0 = llvm.call @callee() : () -> i32
    %1 = llvm.call @callee() : () -> i32
    %2 = llvm.zext %0 : i32 to i64
    %3 = llvm.zext %1 : i32 to i64
    %4 = llvm.sub %2, %3  : i64
    llvm.return %4 : i64
  }]

def test15_before := [llvmfunc|
  llvm.func @test15(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(8 : i64) : i64
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.sext %2 : i32 to i64
    %4 = llvm.sub %1, %3  : i64
    llvm.return %4 : i64
  }]

def test15vec_before := [llvmfunc|
  llvm.func @test15vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<8> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.ashr %arg0, %0  : vector<2xi32>
    %3 = llvm.sext %2 : vector<2xi32> to vector<2xi64>
    %4 = llvm.sub %1, %3  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

def test16_before := [llvmfunc|
  llvm.func @test16(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(4294967294 : i64) : i64
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.zext %2 : i32 to i64
    %4 = llvm.sub %1, %3  : i64
    llvm.return %4 : i64
  }]

def test16vec_before := [llvmfunc|
  llvm.func @test16vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<4294967294> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.lshr %arg0, %0  : vector<2xi32>
    %3 = llvm.zext %2 : vector<2xi32> to vector<2xi64>
    %4 = llvm.sub %1, %3  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

def test17_before := [llvmfunc|
  llvm.func @test17(%arg0: i32) -> i64 {
    %0 = llvm.call @callee() : () -> i32
    %1 = llvm.call @callee() : () -> i32
    %2 = llvm.zext %0 : i32 to i64
    %3 = llvm.zext %1 : i32 to i64
    %4 = llvm.sub %2, %3  : i64
    llvm.return %4 : i64
  }]

def test18_before := [llvmfunc|
  llvm.func @test18(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(2147481648 : i64) : i64
    %1 = llvm.call @callee() : () -> i32
    %2 = llvm.sext %1 : i32 to i64
    %3 = llvm.sub %0, %2  : i64
    llvm.return %3 : i64
  }]

def test19_before := [llvmfunc|
  llvm.func @test19(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(-2147481648 : i64) : i64
    %1 = llvm.call @callee() : () -> i32
    %2 = llvm.sext %1 : i32 to i64
    %3 = llvm.sub %0, %2  : i64
    llvm.return %3 : i64
  }]

def sext_sext_add_combined := [llvmfunc|
  llvm.func @sext_sext_add(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.ashr %arg0, %1  : i32
    %4 = llvm.add %2, %3 overflow<nsw>  : i32
    %5 = llvm.sext %4 : i32 to i64
    llvm.return %5 : i64
  }]

theorem inst_combine_sext_sext_add   : sext_sext_add_before  ⊑  sext_sext_add_combined := by
  unfold sext_sext_add_before sext_sext_add_combined
  simp_alive_peephole
  sorry
def sext_zext_add_mismatched_exts_combined := [llvmfunc|
  llvm.func @sext_zext_add_mismatched_exts(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.lshr %arg0, %1  : i32
    %4 = llvm.sext %2 : i32 to i64
    %5 = llvm.zext %3 : i32 to i64
    %6 = llvm.add %4, %5 overflow<nsw>  : i64
    llvm.return %6 : i64
  }]

theorem inst_combine_sext_zext_add_mismatched_exts   : sext_zext_add_mismatched_exts_before  ⊑  sext_zext_add_mismatched_exts_combined := by
  unfold sext_zext_add_mismatched_exts_before sext_zext_add_mismatched_exts_combined
  simp_alive_peephole
  sorry
def sext_sext_add_mismatched_types_combined := [llvmfunc|
  llvm.func @sext_sext_add_mismatched_types(%arg0: i16, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(7 : i16) : i16
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i16
    %3 = llvm.ashr %arg1, %1  : i32
    %4 = llvm.sext %2 : i16 to i64
    %5 = llvm.sext %3 : i32 to i64
    %6 = llvm.add %4, %5 overflow<nsw>  : i64
    llvm.return %6 : i64
  }]

theorem inst_combine_sext_sext_add_mismatched_types   : sext_sext_add_mismatched_types_before  ⊑  sext_sext_add_mismatched_types_combined := by
  unfold sext_sext_add_mismatched_types_before sext_sext_add_mismatched_types_combined
  simp_alive_peephole
  sorry
def sext_sext_add_extra_use1_combined := [llvmfunc|
  llvm.func @sext_sext_add_extra_use1(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.ashr %arg0, %1  : i32
    %4 = llvm.sext %2 : i32 to i64
    llvm.call @use(%4) : (i64) -> ()
    %5 = llvm.add %2, %3 overflow<nsw>  : i32
    %6 = llvm.sext %5 : i32 to i64
    llvm.return %6 : i64
  }]

theorem inst_combine_sext_sext_add_extra_use1   : sext_sext_add_extra_use1_before  ⊑  sext_sext_add_extra_use1_combined := by
  unfold sext_sext_add_extra_use1_before sext_sext_add_extra_use1_combined
  simp_alive_peephole
  sorry
def sext_sext_add_extra_use2_combined := [llvmfunc|
  llvm.func @sext_sext_add_extra_use2(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.ashr %arg0, %1  : i32
    %4 = llvm.sext %3 : i32 to i64
    llvm.call @use(%4) : (i64) -> ()
    %5 = llvm.add %2, %3 overflow<nsw>  : i32
    %6 = llvm.sext %5 : i32 to i64
    llvm.return %6 : i64
  }]

theorem inst_combine_sext_sext_add_extra_use2   : sext_sext_add_extra_use2_before  ⊑  sext_sext_add_extra_use2_combined := by
  unfold sext_sext_add_extra_use2_before sext_sext_add_extra_use2_combined
  simp_alive_peephole
  sorry
def sext_sext_add_extra_use3_combined := [llvmfunc|
  llvm.func @sext_sext_add_extra_use3(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.ashr %arg0, %1  : i32
    %4 = llvm.sext %2 : i32 to i64
    llvm.call @use(%4) : (i64) -> ()
    %5 = llvm.sext %3 : i32 to i64
    llvm.call @use(%5) : (i64) -> ()
    %6 = llvm.add %4, %5 overflow<nsw>  : i64
    llvm.return %6 : i64
  }]

theorem inst_combine_sext_sext_add_extra_use3   : sext_sext_add_extra_use3_before  ⊑  sext_sext_add_extra_use3_combined := by
  unfold sext_sext_add_extra_use3_before sext_sext_add_extra_use3_combined
  simp_alive_peephole
  sorry
def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i32) -> i64 {
    %0 = llvm.call @callee() : () -> i32
    %1 = llvm.call @callee() : () -> i32
    %2 = llvm.add %0, %1 overflow<nsw, nuw>  : i32
    %3 = llvm.zext %2 : i32 to i64
    llvm.return %3 : i64
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i32) -> i64 {
    %0 = llvm.call @callee() : () -> i32
    %1 = llvm.call @callee() : () -> i32
    %2 = llvm.add %0, %1 overflow<nsw, nuw>  : i32
    %3 = llvm.zext %2 : i32 to i64
    llvm.return %3 : i64
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: i32) -> i64 {
    %0 = llvm.call @callee() : () -> i32
    %1 = llvm.call @callee() : () -> i32
    %2 = llvm.mul %0, %1 overflow<nsw, nuw>  : i32
    %3 = llvm.zext %2 : i32 to i64
    llvm.return %3 : i64
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4(%arg0: i32) -> i64 {
    %0 = llvm.call @callee() : () -> i32
    %1 = llvm.call @callee() : () -> i32
    %2 = llvm.mul %0, %1 overflow<nsw, nuw>  : i32
    %3 = llvm.zext %2 : i32 to i64
    llvm.return %3 : i64
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(1073741823 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.add %2, %1 overflow<nsw>  : i32
    %4 = llvm.sext %3 : i32 to i64
    llvm.return %4 : i64
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
def sext_add_constant_extra_use_combined := [llvmfunc|
  llvm.func @sext_add_constant_extra_use(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(1073741823 : i64) : i64
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.sext %2 : i32 to i64
    llvm.call @use(%3) : (i64) -> ()
    %4 = llvm.add %3, %1 overflow<nsw>  : i64
    llvm.return %4 : i64
  }]

theorem inst_combine_sext_add_constant_extra_use   : sext_add_constant_extra_use_before  ⊑  sext_add_constant_extra_use_combined := by
  unfold sext_add_constant_extra_use_before sext_add_constant_extra_use_combined
  simp_alive_peephole
  sorry
def test5_splat_combined := [llvmfunc|
  llvm.func @test5_splat(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<1073741823> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.ashr %arg0, %0  : vector<2xi32>
    %3 = llvm.add %2, %1 overflow<nsw>  : vector<2xi32>
    %4 = llvm.sext %3 : vector<2xi32> to vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

theorem inst_combine_test5_splat   : test5_splat_before  ⊑  test5_splat_combined := by
  unfold test5_splat_before test5_splat_combined
  simp_alive_peephole
  sorry
def test5_vec_combined := [llvmfunc|
  llvm.func @test5_vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.ashr %arg0, %0  : vector<2xi32>
    %3 = llvm.add %2, %1 overflow<nsw>  : vector<2xi32>
    %4 = llvm.sext %3 : vector<2xi32> to vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

theorem inst_combine_test5_vec   : test5_vec_before  ⊑  test5_vec_combined := by
  unfold test5_vec_before test5_vec_combined
  simp_alive_peephole
  sorry
def test6_combined := [llvmfunc|
  llvm.func @test6(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1073741824 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.add %2, %1 overflow<nsw>  : i32
    %4 = llvm.sext %3 : i32 to i64
    llvm.return %4 : i64
  }]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
def test6_splat_combined := [llvmfunc|
  llvm.func @test6_splat(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-1073741824> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.ashr %arg0, %0  : vector<2xi32>
    %3 = llvm.add %2, %1 overflow<nsw>  : vector<2xi32>
    %4 = llvm.sext %3 : vector<2xi32> to vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

theorem inst_combine_test6_splat   : test6_splat_before  ⊑  test6_splat_combined := by
  unfold test6_splat_before test6_splat_combined
  simp_alive_peephole
  sorry
def test6_vec_combined := [llvmfunc|
  llvm.func @test6_vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[-1, -2]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.ashr %arg0, %0  : vector<2xi32>
    %3 = llvm.add %2, %1 overflow<nsw>  : vector<2xi32>
    %4 = llvm.sext %3 : vector<2xi32> to vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

theorem inst_combine_test6_vec   : test6_vec_before  ⊑  test6_vec_combined := by
  unfold test6_vec_before test6_vec_combined
  simp_alive_peephole
  sorry
def test6_vec2_combined := [llvmfunc|
  llvm.func @test6_vec2(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[-1, 1]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.ashr %arg0, %0  : vector<2xi32>
    %3 = llvm.add %2, %1 overflow<nsw>  : vector<2xi32>
    %4 = llvm.sext %3 : vector<2xi32> to vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

theorem inst_combine_test6_vec2   : test6_vec2_before  ⊑  test6_vec2_combined := by
  unfold test6_vec2_before test6_vec2_combined
  simp_alive_peephole
  sorry
def test7_combined := [llvmfunc|
  llvm.func @test7(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2147483647 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.add %2, %1 overflow<nuw>  : i32
    %4 = llvm.zext %3 : i32 to i64
    llvm.return %4 : i64
  }]

theorem inst_combine_test7   : test7_before  ⊑  test7_combined := by
  unfold test7_before test7_combined
  simp_alive_peephole
  sorry
def test7_splat_combined := [llvmfunc|
  llvm.func @test7_splat(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<2147483647> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.lshr %arg0, %0  : vector<2xi32>
    %3 = llvm.add %2, %1 overflow<nuw>  : vector<2xi32>
    %4 = llvm.zext %3 : vector<2xi32> to vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

theorem inst_combine_test7_splat   : test7_splat_before  ⊑  test7_splat_combined := by
  unfold test7_splat_before test7_splat_combined
  simp_alive_peephole
  sorry
def test7_vec_combined := [llvmfunc|
  llvm.func @test7_vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.lshr %arg0, %0  : vector<2xi32>
    %3 = llvm.add %2, %1 overflow<nuw>  : vector<2xi32>
    %4 = llvm.zext %3 : vector<2xi32> to vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

theorem inst_combine_test7_vec   : test7_vec_before  ⊑  test7_vec_combined := by
  unfold test7_vec_before test7_vec_combined
  simp_alive_peephole
  sorry
def test8_combined := [llvmfunc|
  llvm.func @test8(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(32767 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.mul %2, %1 overflow<nsw>  : i32
    %4 = llvm.sext %3 : i32 to i64
    llvm.return %4 : i64
  }]

theorem inst_combine_test8   : test8_before  ⊑  test8_combined := by
  unfold test8_before test8_combined
  simp_alive_peephole
  sorry
def test8_splat_combined := [llvmfunc|
  llvm.func @test8_splat(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<32767> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.ashr %arg0, %0  : vector<2xi32>
    %3 = llvm.mul %2, %1 overflow<nsw>  : vector<2xi32>
    %4 = llvm.sext %3 : vector<2xi32> to vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

theorem inst_combine_test8_splat   : test8_splat_before  ⊑  test8_splat_combined := by
  unfold test8_splat_before test8_splat_combined
  simp_alive_peephole
  sorry
def test8_vec_combined := [llvmfunc|
  llvm.func @test8_vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[32767, 16384]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.ashr %arg0, %0  : vector<2xi32>
    %3 = llvm.mul %2, %1 overflow<nsw>  : vector<2xi32>
    %4 = llvm.sext %3 : vector<2xi32> to vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

theorem inst_combine_test8_vec   : test8_vec_before  ⊑  test8_vec_combined := by
  unfold test8_vec_before test8_vec_combined
  simp_alive_peephole
  sorry
def test8_vec2_combined := [llvmfunc|
  llvm.func @test8_vec2(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[32767, -32767]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.ashr %arg0, %0  : vector<2xi32>
    %3 = llvm.mul %2, %1 overflow<nsw>  : vector<2xi32>
    %4 = llvm.sext %3 : vector<2xi32> to vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

theorem inst_combine_test8_vec2   : test8_vec2_before  ⊑  test8_vec2_combined := by
  unfold test8_vec2_before test8_vec2_combined
  simp_alive_peephole
  sorry
def test9_combined := [llvmfunc|
  llvm.func @test9(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(-32767 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.mul %2, %1 overflow<nsw>  : i32
    %4 = llvm.sext %3 : i32 to i64
    llvm.return %4 : i64
  }]

theorem inst_combine_test9   : test9_before  ⊑  test9_combined := by
  unfold test9_before test9_combined
  simp_alive_peephole
  sorry
def test9_splat_combined := [llvmfunc|
  llvm.func @test9_splat(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-32767> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.ashr %arg0, %0  : vector<2xi32>
    %3 = llvm.mul %2, %1 overflow<nsw>  : vector<2xi32>
    %4 = llvm.sext %3 : vector<2xi32> to vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

theorem inst_combine_test9_splat   : test9_splat_before  ⊑  test9_splat_combined := by
  unfold test9_splat_before test9_splat_combined
  simp_alive_peephole
  sorry
def test9_vec_combined := [llvmfunc|
  llvm.func @test9_vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[-32767, -10]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.ashr %arg0, %0  : vector<2xi32>
    %3 = llvm.mul %2, %1 overflow<nsw>  : vector<2xi32>
    %4 = llvm.sext %3 : vector<2xi32> to vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

theorem inst_combine_test9_vec   : test9_vec_before  ⊑  test9_vec_combined := by
  unfold test9_vec_before test9_vec_combined
  simp_alive_peephole
  sorry
def test10_combined := [llvmfunc|
  llvm.func @test10(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(65535 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.mul %2, %1 overflow<nuw>  : i32
    %4 = llvm.zext %3 : i32 to i64
    llvm.return %4 : i64
  }]

theorem inst_combine_test10   : test10_before  ⊑  test10_combined := by
  unfold test10_before test10_combined
  simp_alive_peephole
  sorry
def test10_splat_combined := [llvmfunc|
  llvm.func @test10_splat(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<65535> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.lshr %arg0, %0  : vector<2xi32>
    %3 = llvm.mul %2, %1 overflow<nuw>  : vector<2xi32>
    %4 = llvm.zext %3 : vector<2xi32> to vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

theorem inst_combine_test10_splat   : test10_splat_before  ⊑  test10_splat_combined := by
  unfold test10_splat_before test10_splat_combined
  simp_alive_peephole
  sorry
def test10_vec_combined := [llvmfunc|
  llvm.func @test10_vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[65535, 2]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.lshr %arg0, %0  : vector<2xi32>
    %3 = llvm.mul %2, %1 overflow<nuw>  : vector<2xi32>
    %4 = llvm.zext %3 : vector<2xi32> to vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

theorem inst_combine_test10_vec   : test10_vec_before  ⊑  test10_vec_combined := by
  unfold test10_vec_before test10_vec_combined
  simp_alive_peephole
  sorry
def test11_combined := [llvmfunc|
  llvm.func @test11(%arg0: i32) -> i64 {
    %0 = llvm.call @callee() : () -> i32
    %1 = llvm.call @callee() : () -> i32
    %2 = llvm.add %0, %1 overflow<nsw>  : i32
    %3 = llvm.sext %2 : i32 to i64
    llvm.return %3 : i64
  }]

theorem inst_combine_test11   : test11_before  ⊑  test11_combined := by
  unfold test11_before test11_combined
  simp_alive_peephole
  sorry
def test12_combined := [llvmfunc|
  llvm.func @test12(%arg0: i32) -> i64 {
    %0 = llvm.call @callee() : () -> i32
    %1 = llvm.call @callee() : () -> i32
    %2 = llvm.mul %0, %1 overflow<nsw>  : i32
    %3 = llvm.zext %2 : i32 to i64
    llvm.return %3 : i64
  }]

theorem inst_combine_test12   : test12_before  ⊑  test12_combined := by
  unfold test12_before test12_combined
  simp_alive_peephole
  sorry
def test13_combined := [llvmfunc|
  llvm.func @test13(%arg0: i32) -> i64 {
    %0 = llvm.call @callee() : () -> i32
    %1 = llvm.call @callee() : () -> i32
    %2 = llvm.sub %0, %1 overflow<nsw>  : i32
    %3 = llvm.sext %2 : i32 to i64
    llvm.return %3 : i64
  }]

theorem inst_combine_test13   : test13_before  ⊑  test13_combined := by
  unfold test13_before test13_combined
  simp_alive_peephole
  sorry
def test14_combined := [llvmfunc|
  llvm.func @test14(%arg0: i32) -> i64 {
    %0 = llvm.call @callee() : () -> i32
    %1 = llvm.call @callee() : () -> i32
    %2 = llvm.sub %0, %1 overflow<nsw, nuw>  : i32
    %3 = llvm.zext %2 : i32 to i64
    llvm.return %3 : i64
  }]

theorem inst_combine_test14   : test14_before  ⊑  test14_combined := by
  unfold test14_before test14_combined
  simp_alive_peephole
  sorry
def test15_combined := [llvmfunc|
  llvm.func @test15(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.sub %1, %2 overflow<nsw>  : i32
    %4 = llvm.sext %3 : i32 to i64
    llvm.return %4 : i64
  }]

theorem inst_combine_test15   : test15_before  ⊑  test15_combined := by
  unfold test15_before test15_combined
  simp_alive_peephole
  sorry
def test15vec_combined := [llvmfunc|
  llvm.func @test15vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.ashr %arg0, %0  : vector<2xi32>
    %3 = llvm.sub %1, %2 overflow<nsw>  : vector<2xi32>
    %4 = llvm.sext %3 : vector<2xi32> to vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

theorem inst_combine_test15vec   : test15vec_before  ⊑  test15vec_combined := by
  unfold test15vec_before test15vec_combined
  simp_alive_peephole
  sorry
def test16_combined := [llvmfunc|
  llvm.func @test16(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.sub %1, %2 overflow<nuw>  : i32
    %4 = llvm.zext %3 : i32 to i64
    llvm.return %4 : i64
  }]

theorem inst_combine_test16   : test16_before  ⊑  test16_combined := by
  unfold test16_before test16_combined
  simp_alive_peephole
  sorry
def test16vec_combined := [llvmfunc|
  llvm.func @test16vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-2> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.lshr %arg0, %0  : vector<2xi32>
    %3 = llvm.sub %1, %2 overflow<nuw>  : vector<2xi32>
    %4 = llvm.zext %3 : vector<2xi32> to vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

theorem inst_combine_test16vec   : test16vec_before  ⊑  test16vec_combined := by
  unfold test16vec_before test16vec_combined
  simp_alive_peephole
  sorry
def test17_combined := [llvmfunc|
  llvm.func @test17(%arg0: i32) -> i64 {
    %0 = llvm.call @callee() : () -> i32
    %1 = llvm.call @callee() : () -> i32
    %2 = llvm.zext %0 : i32 to i64
    %3 = llvm.zext %1 : i32 to i64
    %4 = llvm.sub %2, %3 overflow<nsw>  : i64
    llvm.return %4 : i64
  }]

theorem inst_combine_test17   : test17_before  ⊑  test17_combined := by
  unfold test17_before test17_combined
  simp_alive_peephole
  sorry
def test18_combined := [llvmfunc|
  llvm.func @test18(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(2147481648 : i64) : i64
    %1 = llvm.call @callee() : () -> i32
    %2 = llvm.sext %1 : i32 to i64
    %3 = llvm.sub %0, %2 overflow<nsw>  : i64
    llvm.return %3 : i64
  }]

theorem inst_combine_test18   : test18_before  ⊑  test18_combined := by
  unfold test18_before test18_combined
  simp_alive_peephole
  sorry
def test19_combined := [llvmfunc|
  llvm.func @test19(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(-2147481648 : i64) : i64
    %1 = llvm.call @callee() : () -> i32
    %2 = llvm.zext %1 : i32 to i64
    %3 = llvm.sub %0, %2 overflow<nsw, nuw>  : i64
    llvm.return %3 : i64
  }]

theorem inst_combine_test19   : test19_before  ⊑  test19_combined := by
  unfold test19_before test19_combined
  simp_alive_peephole
  sorry
