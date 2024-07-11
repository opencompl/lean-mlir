import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  and-xor-or
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def and_xor_common_op_before := [llvmfunc|
  llvm.func @and_xor_common_op(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(43 : i32) : i32
    %2 = llvm.udiv %0, %arg0  : i32
    %3 = llvm.udiv %1, %arg1  : i32
    %4 = llvm.xor %2, %3  : i32
    %5 = llvm.and %2, %4  : i32
    llvm.return %5 : i32
  }]

def and_xor_common_op_commute1_before := [llvmfunc|
  llvm.func @and_xor_common_op_commute1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(43 : i32) : i32
    %2 = llvm.udiv %0, %arg0  : i32
    %3 = llvm.udiv %1, %arg1  : i32
    %4 = llvm.xor %3, %2  : i32
    %5 = llvm.and %2, %4  : i32
    llvm.return %5 : i32
  }]

def and_xor_common_op_commute2_before := [llvmfunc|
  llvm.func @and_xor_common_op_commute2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(43 : i32) : i32
    %2 = llvm.udiv %0, %arg0  : i32
    %3 = llvm.udiv %1, %arg1  : i32
    %4 = llvm.xor %3, %2  : i32
    %5 = llvm.and %4, %2  : i32
    llvm.return %5 : i32
  }]

def and_xor_common_op_commute3_before := [llvmfunc|
  llvm.func @and_xor_common_op_commute3(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[42, 43]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[43, 42]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.udiv %0, %arg0  : vector<2xi32>
    %3 = llvm.udiv %1, %arg1  : vector<2xi32>
    %4 = llvm.xor %2, %3  : vector<2xi32>
    %5 = llvm.and %4, %2  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

def and_xor_common_op_constant_before := [llvmfunc|
  llvm.func @and_xor_common_op_constant(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.xor %arg0, %0  : vector<4xi32>
    %2 = llvm.and %0, %1  : vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }]

def and_xor_not_common_op_before := [llvmfunc|
  llvm.func @and_xor_not_common_op(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.xor %arg0, %1  : i32
    %3 = llvm.and %2, %arg0  : i32
    llvm.return %3 : i32
  }]

def and_xor_not_common_op_extrause_before := [llvmfunc|
  llvm.func @and_xor_not_common_op_extrause(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    llvm.store %1, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

    %2 = llvm.xor %arg0, %1  : i32
    %3 = llvm.and %2, %arg0  : i32
    llvm.return %3 : i32
  }]

def and_not_xor_common_op_before := [llvmfunc|
  llvm.func @and_not_xor_common_op(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg0  : i32
    llvm.return %3 : i32
  }]

def and_not_xor_common_op_commutative_before := [llvmfunc|
  llvm.func @and_not_xor_common_op_commutative(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.call @gen32() : () -> i32
    %2 = llvm.xor %1, %arg0  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.and %1, %3  : i32
    llvm.return %4 : i32
  }]

def or_before := [llvmfunc|
  llvm.func @or(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.and %arg1, %arg0  : i64
    %1 = llvm.xor %arg1, %arg0  : i64
    %2 = llvm.add %0, %1  : i64
    llvm.return %2 : i64
  }]

def or2_before := [llvmfunc|
  llvm.func @or2(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.and %arg1, %arg0  : i64
    %1 = llvm.xor %arg1, %arg0  : i64
    %2 = llvm.or %0, %1  : i64
    llvm.return %2 : i64
  }]

def and_xor_or1_before := [llvmfunc|
  llvm.func @and_xor_or1(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(42 : i64) : i64
    %1 = llvm.udiv %0, %arg0  : i64
    %2 = llvm.udiv %0, %arg1  : i64
    %3 = llvm.udiv %0, %arg2  : i64
    %4 = llvm.and %1, %2  : i64
    %5 = llvm.xor %4, %3  : i64
    %6 = llvm.or %5, %2  : i64
    llvm.return %6 : i64
  }]

def and_xor_or2_before := [llvmfunc|
  llvm.func @and_xor_or2(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(42 : i64) : i64
    %1 = llvm.udiv %0, %arg0  : i64
    %2 = llvm.udiv %0, %arg1  : i64
    %3 = llvm.udiv %0, %arg2  : i64
    %4 = llvm.and %2, %1  : i64
    %5 = llvm.xor %4, %3  : i64
    %6 = llvm.or %5, %2  : i64
    llvm.return %6 : i64
  }]

def and_xor_or3_before := [llvmfunc|
  llvm.func @and_xor_or3(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(42 : i64) : i64
    %1 = llvm.udiv %0, %arg0  : i64
    %2 = llvm.udiv %0, %arg1  : i64
    %3 = llvm.udiv %0, %arg2  : i64
    %4 = llvm.and %1, %2  : i64
    %5 = llvm.xor %3, %4  : i64
    %6 = llvm.or %5, %2  : i64
    llvm.return %6 : i64
  }]

def and_xor_or4_before := [llvmfunc|
  llvm.func @and_xor_or4(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(42 : i64) : i64
    %1 = llvm.udiv %0, %arg0  : i64
    %2 = llvm.udiv %0, %arg1  : i64
    %3 = llvm.udiv %0, %arg2  : i64
    %4 = llvm.and %2, %1  : i64
    %5 = llvm.xor %3, %4  : i64
    %6 = llvm.or %5, %2  : i64
    llvm.return %6 : i64
  }]

def and_xor_or5_before := [llvmfunc|
  llvm.func @and_xor_or5(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(42 : i64) : i64
    %1 = llvm.udiv %0, %arg0  : i64
    %2 = llvm.udiv %0, %arg1  : i64
    %3 = llvm.udiv %0, %arg2  : i64
    %4 = llvm.and %1, %2  : i64
    %5 = llvm.xor %4, %3  : i64
    %6 = llvm.or %2, %5  : i64
    llvm.return %6 : i64
  }]

def and_xor_or6_before := [llvmfunc|
  llvm.func @and_xor_or6(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(42 : i64) : i64
    %1 = llvm.udiv %0, %arg0  : i64
    %2 = llvm.udiv %0, %arg1  : i64
    %3 = llvm.udiv %0, %arg2  : i64
    %4 = llvm.and %2, %1  : i64
    %5 = llvm.xor %4, %3  : i64
    %6 = llvm.or %2, %5  : i64
    llvm.return %6 : i64
  }]

def and_xor_or7_before := [llvmfunc|
  llvm.func @and_xor_or7(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(42 : i64) : i64
    %1 = llvm.udiv %0, %arg0  : i64
    %2 = llvm.udiv %0, %arg1  : i64
    %3 = llvm.udiv %0, %arg2  : i64
    %4 = llvm.and %1, %2  : i64
    %5 = llvm.xor %3, %4  : i64
    %6 = llvm.or %2, %5  : i64
    llvm.return %6 : i64
  }]

def and_xor_or8_before := [llvmfunc|
  llvm.func @and_xor_or8(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(42 : i64) : i64
    %1 = llvm.udiv %0, %arg0  : i64
    %2 = llvm.udiv %0, %arg1  : i64
    %3 = llvm.udiv %0, %arg2  : i64
    %4 = llvm.and %2, %1  : i64
    %5 = llvm.xor %3, %4  : i64
    %6 = llvm.or %2, %5  : i64
    llvm.return %6 : i64
  }]

def and_xor_or_negative_before := [llvmfunc|
  llvm.func @and_xor_or_negative(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64) -> i64 {
    %0 = llvm.and %arg1, %arg0  : i64
    %1 = llvm.xor %arg2, %0  : i64
    %2 = llvm.or %arg3, %1  : i64
    llvm.return %2 : i64
  }]

def and_shl_before := [llvmfunc|
  llvm.func @and_shl(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg3  : i8
    %1 = llvm.shl %arg1, %arg3  : i8
    %2 = llvm.and %0, %arg2  : i8
    %3 = llvm.and %1, %2  : i8
    llvm.return %3 : i8
  }]

def or_shl_before := [llvmfunc|
  llvm.func @or_shl(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg3  : i8
    %1 = llvm.shl %arg1, %arg3  : i8
    %2 = llvm.or %0, %arg2  : i8
    %3 = llvm.or %2, %1  : i8
    llvm.return %3 : i8
  }]

def xor_shl_before := [llvmfunc|
  llvm.func @xor_shl(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.sdiv %0, %arg2  : i8
    %2 = llvm.shl %arg0, %arg3  : i8
    %3 = llvm.shl %arg1, %arg3  : i8
    %4 = llvm.xor %1, %2  : i8
    %5 = llvm.xor %4, %3  : i8
    llvm.return %5 : i8
  }]

def and_lshr_before := [llvmfunc|
  llvm.func @and_lshr(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.sdiv %0, %arg2  : i8
    %2 = llvm.lshr %arg0, %arg3  : i8
    %3 = llvm.lshr %arg1, %arg3  : i8
    %4 = llvm.and %1, %2  : i8
    %5 = llvm.and %3, %4  : i8
    llvm.return %5 : i8
  }]

def or_lshr_before := [llvmfunc|
  llvm.func @or_lshr(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.lshr %arg0, %arg3  : i8
    %1 = llvm.lshr %arg1, %arg3  : i8
    %2 = llvm.or %0, %arg2  : i8
    %3 = llvm.or %1, %2  : i8
    llvm.return %3 : i8
  }]

def xor_lshr_before := [llvmfunc|
  llvm.func @xor_lshr(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.lshr %arg0, %arg3  : i8
    %1 = llvm.lshr %arg1, %arg3  : i8
    %2 = llvm.xor %0, %arg2  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }]

def and_ashr_before := [llvmfunc|
  llvm.func @and_ashr(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.sdiv %0, %arg2  : i8
    %2 = llvm.ashr %arg0, %arg3  : i8
    %3 = llvm.ashr %arg1, %arg3  : i8
    %4 = llvm.and %1, %2  : i8
    %5 = llvm.and %4, %3  : i8
    llvm.return %5 : i8
  }]

def or_ashr_before := [llvmfunc|
  llvm.func @or_ashr(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.sdiv %0, %arg2  : i8
    %2 = llvm.ashr %arg0, %arg3  : i8
    %3 = llvm.ashr %arg1, %arg3  : i8
    %4 = llvm.or %1, %2  : i8
    %5 = llvm.or %3, %4  : i8
    llvm.return %5 : i8
  }]

def xor_ashr_before := [llvmfunc|
  llvm.func @xor_ashr(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>, %arg3: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.ashr %arg0, %arg3  : vector<2xi8>
    %1 = llvm.ashr %arg1, %arg3  : vector<2xi8>
    %2 = llvm.xor %0, %arg2  : vector<2xi8>
    %3 = llvm.xor %2, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def or_and_shl_before := [llvmfunc|
  llvm.func @or_and_shl(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg3  : i8
    %1 = llvm.shl %arg1, %arg3  : i8
    %2 = llvm.or %0, %arg2  : i8
    %3 = llvm.and %1, %2  : i8
    llvm.return %3 : i8
  }]

def or_lshr_shl_before := [llvmfunc|
  llvm.func @or_lshr_shl(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.lshr %arg0, %arg3  : i8
    %1 = llvm.shl %arg1, %arg3  : i8
    %2 = llvm.or %0, %arg2  : i8
    %3 = llvm.or %2, %1  : i8
    llvm.return %3 : i8
  }]

def or_lshr_shamt2_before := [llvmfunc|
  llvm.func @or_lshr_shamt2(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.lshr %arg0, %0  : i8
    %2 = llvm.lshr %arg1, %arg3  : i8
    %3 = llvm.or %1, %arg2  : i8
    %4 = llvm.or %2, %3  : i8
    llvm.return %4 : i8
  }]

def xor_lshr_multiuse_before := [llvmfunc|
  llvm.func @xor_lshr_multiuse(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.lshr %arg0, %arg3  : i8
    %1 = llvm.lshr %arg1, %arg3  : i8
    %2 = llvm.xor %0, %arg2  : i8
    %3 = llvm.xor %2, %1  : i8
    %4 = llvm.sdiv %2, %3  : i8
    llvm.return %4 : i8
  }]

def sext_or_chain_before := [llvmfunc|
  llvm.func @sext_or_chain(%arg0: i64, %arg1: i16, %arg2: i16) -> i64 {
    %0 = llvm.sext %arg1 : i16 to i64
    %1 = llvm.sext %arg2 : i16 to i64
    %2 = llvm.or %arg0, %0  : i64
    %3 = llvm.or %2, %1  : i64
    llvm.return %3 : i64
  }]

def zext_or_chain_before := [llvmfunc|
  llvm.func @zext_or_chain(%arg0: i64, %arg1: i16, %arg2: i16) -> i64 {
    %0 = llvm.zext %arg1 : i16 to i64
    %1 = llvm.zext %arg2 : i16 to i64
    %2 = llvm.or %arg0, %0  : i64
    %3 = llvm.or %2, %1  : i64
    llvm.return %3 : i64
  }]

def sext_and_chain_before := [llvmfunc|
  llvm.func @sext_and_chain(%arg0: i64, %arg1: i16, %arg2: i16) -> i64 {
    %0 = llvm.sext %arg1 : i16 to i64
    %1 = llvm.sext %arg2 : i16 to i64
    %2 = llvm.and %arg0, %0  : i64
    %3 = llvm.and %2, %1  : i64
    llvm.return %3 : i64
  }]

def zext_and_chain_before := [llvmfunc|
  llvm.func @zext_and_chain(%arg0: i64, %arg1: i16, %arg2: i16) -> i64 {
    %0 = llvm.zext %arg1 : i16 to i64
    %1 = llvm.zext %arg2 : i16 to i64
    %2 = llvm.and %arg0, %0  : i64
    %3 = llvm.and %2, %1  : i64
    llvm.return %3 : i64
  }]

def sext_xor_chain_before := [llvmfunc|
  llvm.func @sext_xor_chain(%arg0: i64, %arg1: i16, %arg2: i16) -> i64 {
    %0 = llvm.sext %arg1 : i16 to i64
    %1 = llvm.sext %arg2 : i16 to i64
    %2 = llvm.xor %arg0, %0  : i64
    %3 = llvm.xor %2, %1  : i64
    llvm.return %3 : i64
  }]

def zext_xor_chain_before := [llvmfunc|
  llvm.func @zext_xor_chain(%arg0: i64, %arg1: i16, %arg2: i16) -> i64 {
    %0 = llvm.zext %arg1 : i16 to i64
    %1 = llvm.zext %arg2 : i16 to i64
    %2 = llvm.xor %arg0, %0  : i64
    %3 = llvm.xor %2, %1  : i64
    llvm.return %3 : i64
  }]

def sext_or_chain_two_uses1_before := [llvmfunc|
  llvm.func @sext_or_chain_two_uses1(%arg0: i64, %arg1: i16, %arg2: i16, %arg3: i64) -> i64 {
    %0 = llvm.sext %arg1 : i16 to i64
    %1 = llvm.sext %arg2 : i16 to i64
    %2 = llvm.or %arg0, %0  : i64
    %3 = llvm.or %2, %1  : i64
    %4 = llvm.udiv %2, %arg3  : i64
    %5 = llvm.udiv %3, %4  : i64
    llvm.return %5 : i64
  }]

def sext_or_chain_two_uses2_before := [llvmfunc|
  llvm.func @sext_or_chain_two_uses2(%arg0: i64, %arg1: i16, %arg2: i16, %arg3: i64) -> i64 {
    %0 = llvm.sext %arg1 : i16 to i64
    %1 = llvm.sext %arg2 : i16 to i64
    %2 = llvm.or %arg0, %0  : i64
    %3 = llvm.or %2, %1  : i64
    %4 = llvm.udiv %3, %arg3  : i64
    %5 = llvm.udiv %3, %4  : i64
    llvm.return %5 : i64
  }]

def not_and_and_not_before := [llvmfunc|
  llvm.func @not_and_and_not(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg0  : i32
    %3 = llvm.xor %arg1, %1  : i32
    %4 = llvm.xor %arg2, %1  : i32
    %5 = llvm.and %2, %3  : i32
    %6 = llvm.and %5, %4  : i32
    llvm.return %6 : i32
  }]

def not_and_and_not_4i64_before := [llvmfunc|
  llvm.func @not_and_and_not_4i64(%arg0: vector<4xi64>, %arg1: vector<4xi64>, %arg2: vector<4xi64>) -> vector<4xi64> {
    %0 = llvm.mlir.constant(dense<42> : vector<4xi64>) : vector<4xi64>
    %1 = llvm.mlir.constant(dense<-1> : vector<4xi64>) : vector<4xi64>
    %2 = llvm.sdiv %0, %arg0  : vector<4xi64>
    %3 = llvm.xor %arg1, %1  : vector<4xi64>
    %4 = llvm.xor %arg2, %1  : vector<4xi64>
    %5 = llvm.and %2, %3  : vector<4xi64>
    %6 = llvm.and %5, %4  : vector<4xi64>
    llvm.return %6 : vector<4xi64>
  }]

def not_and_and_not_commute1_before := [llvmfunc|
  llvm.func @not_and_and_not_commute1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.xor %arg2, %0  : i32
    %3 = llvm.and %1, %arg0  : i32
    %4 = llvm.and %3, %2  : i32
    llvm.return %4 : i32
  }]

def not_and_and_not_commute2_extra_not_use_before := [llvmfunc|
  llvm.func @not_and_and_not_commute2_extra_not_use(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg0  : i32
    %3 = llvm.xor %arg1, %1  : i32
    %4 = llvm.xor %arg2, %1  : i32
    %5 = llvm.and %2, %3  : i32
    %6 = llvm.and %4, %5  : i32
    llvm.call @use(%4) : (i32) -> ()
    llvm.return %6 : i32
  }]

def not_and_and_not_extra_and1_use_before := [llvmfunc|
  llvm.func @not_and_and_not_extra_and1_use(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg0  : i32
    %3 = llvm.xor %arg1, %1  : i32
    %4 = llvm.xor %arg2, %1  : i32
    %5 = llvm.and %2, %3  : i32
    %6 = llvm.and %5, %4  : i32
    llvm.call @use(%5) : (i32) -> ()
    llvm.return %6 : i32
  }]

def not_or_or_not_before := [llvmfunc|
  llvm.func @not_or_or_not(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg0  : i32
    %3 = llvm.xor %arg1, %1  : i32
    %4 = llvm.xor %arg2, %1  : i32
    %5 = llvm.or %2, %3  : i32
    %6 = llvm.or %5, %4  : i32
    llvm.return %6 : i32
  }]

def not_or_or_not_2i6_before := [llvmfunc|
  llvm.func @not_or_or_not_2i6(%arg0: vector<2xi6>, %arg1: vector<2xi6>, %arg2: vector<2xi6>) -> vector<2xi6> {
    %0 = llvm.mlir.constant(3 : i6) : i6
    %1 = llvm.mlir.constant(dense<3> : vector<2xi6>) : vector<2xi6>
    %2 = llvm.mlir.constant(-1 : i6) : i6
    %3 = llvm.mlir.constant(dense<-1> : vector<2xi6>) : vector<2xi6>
    %4 = llvm.mlir.poison : i6
    %5 = llvm.mlir.undef : vector<2xi6>
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<2xi6>
    %8 = llvm.mlir.constant(1 : i32) : i32
    %9 = llvm.insertelement %4, %7[%8 : i32] : vector<2xi6>
    %10 = llvm.sdiv %1, %arg0  : vector<2xi6>
    %11 = llvm.xor %arg1, %3  : vector<2xi6>
    %12 = llvm.xor %arg2, %9  : vector<2xi6>
    %13 = llvm.or %10, %11  : vector<2xi6>
    %14 = llvm.or %13, %12  : vector<2xi6>
    llvm.return %14 : vector<2xi6>
  }]

def not_or_or_not_commute1_before := [llvmfunc|
  llvm.func @not_or_or_not_commute1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.xor %arg2, %0  : i32
    %3 = llvm.or %1, %arg0  : i32
    %4 = llvm.or %3, %2  : i32
    llvm.return %4 : i32
  }]

def not_or_or_not_commute2_extra_not_use_before := [llvmfunc|
  llvm.func @not_or_or_not_commute2_extra_not_use(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg0  : i32
    %3 = llvm.xor %arg1, %1  : i32
    %4 = llvm.xor %arg2, %1  : i32
    %5 = llvm.or %2, %3  : i32
    %6 = llvm.or %4, %5  : i32
    llvm.call @use(%4) : (i32) -> ()
    llvm.return %6 : i32
  }]

def not_or_or_not_extra_or1_use_before := [llvmfunc|
  llvm.func @not_or_or_not_extra_or1_use(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg0  : i32
    %3 = llvm.xor %arg1, %1  : i32
    %4 = llvm.xor %arg2, %1  : i32
    %5 = llvm.or %2, %3  : i32
    %6 = llvm.or %5, %4  : i32
    llvm.call @use(%5) : (i32) -> ()
    llvm.return %6 : i32
  }]

def or_not_and_before := [llvmfunc|
  llvm.func @or_not_and(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg2  : i32
    %4 = llvm.or %arg0, %arg2  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.and %5, %arg1  : i32
    %7 = llvm.or %3, %6  : i32
    llvm.return %7 : i32
  }]

def or_not_and_commute1_before := [llvmfunc|
  llvm.func @or_not_and_commute1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg1  : i32
    %3 = llvm.or %arg0, %2  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.and %4, %arg2  : i32
    %6 = llvm.or %arg0, %arg2  : i32
    %7 = llvm.xor %6, %1  : i32
    %8 = llvm.and %2, %7  : i32
    %9 = llvm.or %5, %8  : i32
    llvm.return %9 : i32
  }]

def or_not_and_commute2_before := [llvmfunc|
  llvm.func @or_not_and_commute2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg1  : i32
    %3 = llvm.or %arg0, %2  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.and %4, %arg2  : i32
    %6 = llvm.or %arg0, %arg2  : i32
    %7 = llvm.xor %6, %1  : i32
    %8 = llvm.and %2, %7  : i32
    %9 = llvm.or %8, %5  : i32
    llvm.return %9 : i32
  }]

def or_not_and_commute3_before := [llvmfunc|
  llvm.func @or_not_and_commute3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg2  : i32
    %4 = llvm.or %arg2, %arg0  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.and %5, %arg1  : i32
    %7 = llvm.or %3, %6  : i32
    llvm.return %7 : i32
  }]

def or_not_and_commute4_before := [llvmfunc|
  llvm.func @or_not_and_commute4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg2  : i32
    %3 = llvm.or %arg0, %arg1  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.and %2, %4  : i32
    %6 = llvm.or %arg0, %2  : i32
    %7 = llvm.xor %6, %1  : i32
    %8 = llvm.and %7, %arg1  : i32
    %9 = llvm.or %5, %8  : i32
    llvm.return %9 : i32
  }]

def or_not_and_commute5_before := [llvmfunc|
  llvm.func @or_not_and_commute5(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg0  : i32
    %3 = llvm.sdiv %0, %arg2  : i32
    %4 = llvm.or %2, %arg1  : i32
    %5 = llvm.xor %4, %1  : i32
    %6 = llvm.and %3, %5  : i32
    %7 = llvm.or %2, %3  : i32
    %8 = llvm.xor %7, %1  : i32
    %9 = llvm.and %8, %arg1  : i32
    %10 = llvm.or %6, %9  : i32
    llvm.return %10 : i32
  }]

def or_not_and_commute6_before := [llvmfunc|
  llvm.func @or_not_and_commute6(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg2  : i32
    %4 = llvm.or %arg2, %arg0  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.and %5, %arg1  : i32
    %7 = llvm.or %3, %6  : i32
    llvm.return %7 : i32
  }]

def or_not_and_commute7_before := [llvmfunc|
  llvm.func @or_not_and_commute7(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg2  : i32
    %4 = llvm.or %arg0, %arg2  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.and %5, %arg1  : i32
    %7 = llvm.or %3, %6  : i32
    llvm.return %7 : i32
  }]

def or_not_and_commute8_before := [llvmfunc|
  llvm.func @or_not_and_commute8(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg0  : i32
    %3 = llvm.sdiv %0, %arg1  : i32
    %4 = llvm.or %2, %3  : i32
    %5 = llvm.xor %4, %1  : i32
    %6 = llvm.and %5, %arg2  : i32
    %7 = llvm.or %arg2, %2  : i32
    %8 = llvm.xor %7, %1  : i32
    %9 = llvm.and %3, %8  : i32
    %10 = llvm.or %6, %9  : i32
    llvm.return %10 : i32
  }]

def or_not_and_commute9_before := [llvmfunc|
  llvm.func @or_not_and_commute9(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg0  : i32
    %3 = llvm.sdiv %0, %arg1  : i32
    %4 = llvm.sdiv %0, %arg2  : i32
    %5 = llvm.or %2, %3  : i32
    %6 = llvm.xor %5, %1  : i32
    %7 = llvm.and %6, %4  : i32
    %8 = llvm.or %2, %4  : i32
    %9 = llvm.xor %8, %1  : i32
    %10 = llvm.and %3, %9  : i32
    %11 = llvm.or %7, %10  : i32
    llvm.return %11 : i32
  }]

def or_not_and_extra_not_use1_before := [llvmfunc|
  llvm.func @or_not_and_extra_not_use1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg2  : i32
    %4 = llvm.or %arg0, %arg2  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.and %5, %arg1  : i32
    %7 = llvm.or %3, %6  : i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %7 : i32
  }]

def or_not_and_extra_not_use2_before := [llvmfunc|
  llvm.func @or_not_and_extra_not_use2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg2  : i32
    %4 = llvm.or %arg0, %arg2  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.and %5, %arg1  : i32
    %7 = llvm.or %3, %6  : i32
    llvm.call @use(%5) : (i32) -> ()
    llvm.return %7 : i32
  }]

def or_not_and_extra_and_use1_before := [llvmfunc|
  llvm.func @or_not_and_extra_and_use1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg2  : i32
    %4 = llvm.or %arg0, %arg2  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.and %5, %arg1  : i32
    %7 = llvm.or %3, %6  : i32
    llvm.call @use(%3) : (i32) -> ()
    llvm.return %7 : i32
  }]

def or_not_and_extra_and_use2_before := [llvmfunc|
  llvm.func @or_not_and_extra_and_use2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg2  : i32
    %4 = llvm.or %arg0, %arg2  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.and %5, %arg1  : i32
    %7 = llvm.or %3, %6  : i32
    llvm.call @use(%6) : (i32) -> ()
    llvm.return %7 : i32
  }]

def or_not_and_extra_or_use1_before := [llvmfunc|
  llvm.func @or_not_and_extra_or_use1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg2  : i32
    %4 = llvm.or %arg0, %arg2  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.and %5, %arg1  : i32
    %7 = llvm.or %3, %6  : i32
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %7 : i32
  }]

def or_not_and_extra_or_use2_before := [llvmfunc|
  llvm.func @or_not_and_extra_or_use2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg2  : i32
    %4 = llvm.or %arg0, %arg2  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.and %5, %arg1  : i32
    %7 = llvm.or %3, %6  : i32
    llvm.call @use(%4) : (i32) -> ()
    llvm.return %7 : i32
  }]

def or_not_and_wrong_c_before := [llvmfunc|
  llvm.func @or_not_and_wrong_c(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg2  : i32
    %4 = llvm.or %arg0, %arg3  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.and %5, %arg1  : i32
    %7 = llvm.or %3, %6  : i32
    llvm.return %7 : i32
  }]

def or_not_and_wrong_b_before := [llvmfunc|
  llvm.func @or_not_and_wrong_b(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg2  : i32
    %4 = llvm.or %arg0, %arg2  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.and %5, %arg3  : i32
    %7 = llvm.or %3, %6  : i32
    llvm.return %7 : i32
  }]

def and_not_or_before := [llvmfunc|
  llvm.func @and_not_or(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg2  : i32
    %4 = llvm.and %arg0, %arg2  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.or %5, %arg1  : i32
    %7 = llvm.and %3, %6  : i32
    llvm.return %7 : i32
  }]

def and_not_or_commute1_before := [llvmfunc|
  llvm.func @and_not_or_commute1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg1  : i32
    %3 = llvm.and %arg0, %2  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.or %4, %arg2  : i32
    %6 = llvm.and %arg0, %arg2  : i32
    %7 = llvm.xor %6, %1  : i32
    %8 = llvm.or %2, %7  : i32
    %9 = llvm.and %5, %8  : i32
    llvm.return %9 : i32
  }]

def and_not_or_commute2_before := [llvmfunc|
  llvm.func @and_not_or_commute2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg1  : i32
    %3 = llvm.and %arg0, %2  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.or %4, %arg2  : i32
    %6 = llvm.and %arg0, %arg2  : i32
    %7 = llvm.xor %6, %1  : i32
    %8 = llvm.or %2, %7  : i32
    %9 = llvm.and %8, %5  : i32
    llvm.return %9 : i32
  }]

def and_not_or_commute3_before := [llvmfunc|
  llvm.func @and_not_or_commute3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg2  : i32
    %4 = llvm.and %arg2, %arg0  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.or %5, %arg1  : i32
    %7 = llvm.and %3, %6  : i32
    llvm.return %7 : i32
  }]

def and_not_or_commute4_before := [llvmfunc|
  llvm.func @and_not_or_commute4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg2  : i32
    %3 = llvm.and %arg0, %arg1  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.or %2, %4  : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.xor %6, %1  : i32
    %8 = llvm.or %7, %arg1  : i32
    %9 = llvm.and %5, %8  : i32
    llvm.return %9 : i32
  }]

def and_not_or_commute5_before := [llvmfunc|
  llvm.func @and_not_or_commute5(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg0  : i32
    %3 = llvm.sdiv %0, %arg2  : i32
    %4 = llvm.and %2, %arg1  : i32
    %5 = llvm.xor %4, %1  : i32
    %6 = llvm.or %3, %5  : i32
    %7 = llvm.and %2, %3  : i32
    %8 = llvm.xor %7, %1  : i32
    %9 = llvm.or %8, %arg1  : i32
    %10 = llvm.and %6, %9  : i32
    llvm.return %10 : i32
  }]

def and_not_or_commute6_before := [llvmfunc|
  llvm.func @and_not_or_commute6(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg2  : i32
    %4 = llvm.and %arg2, %arg0  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.or %5, %arg1  : i32
    %7 = llvm.and %3, %6  : i32
    llvm.return %7 : i32
  }]

def and_not_or_commute7_before := [llvmfunc|
  llvm.func @and_not_or_commute7(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg2  : i32
    %4 = llvm.and %arg0, %arg2  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.or %5, %arg1  : i32
    %7 = llvm.and %3, %6  : i32
    llvm.return %7 : i32
  }]

def and_not_or_commute8_before := [llvmfunc|
  llvm.func @and_not_or_commute8(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg0  : i32
    %3 = llvm.sdiv %0, %arg1  : i32
    %4 = llvm.and %2, %3  : i32
    %5 = llvm.xor %4, %1  : i32
    %6 = llvm.or %5, %arg2  : i32
    %7 = llvm.and %arg2, %2  : i32
    %8 = llvm.xor %7, %1  : i32
    %9 = llvm.or %3, %8  : i32
    %10 = llvm.and %6, %9  : i32
    llvm.return %10 : i32
  }]

def and_not_or_commute9_before := [llvmfunc|
  llvm.func @and_not_or_commute9(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg0  : i32
    %3 = llvm.sdiv %0, %arg1  : i32
    %4 = llvm.sdiv %0, %arg2  : i32
    %5 = llvm.and %2, %3  : i32
    %6 = llvm.xor %5, %1  : i32
    %7 = llvm.or %6, %4  : i32
    %8 = llvm.and %2, %4  : i32
    %9 = llvm.xor %8, %1  : i32
    %10 = llvm.or %3, %9  : i32
    %11 = llvm.and %7, %10  : i32
    llvm.return %11 : i32
  }]

def and_not_or_extra_not_use1_before := [llvmfunc|
  llvm.func @and_not_or_extra_not_use1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg2  : i32
    %4 = llvm.and %arg0, %arg2  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.or %5, %arg1  : i32
    %7 = llvm.and %3, %6  : i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %7 : i32
  }]

def and_not_or_extra_not_use2_before := [llvmfunc|
  llvm.func @and_not_or_extra_not_use2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg2  : i32
    %4 = llvm.and %arg0, %arg2  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.or %5, %arg1  : i32
    %7 = llvm.and %3, %6  : i32
    llvm.call @use(%5) : (i32) -> ()
    llvm.return %7 : i32
  }]

def and_not_or_extra_and_use1_before := [llvmfunc|
  llvm.func @and_not_or_extra_and_use1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg2  : i32
    %4 = llvm.and %arg0, %arg2  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.or %5, %arg1  : i32
    %7 = llvm.and %3, %6  : i32
    llvm.call @use(%3) : (i32) -> ()
    llvm.return %7 : i32
  }]

def and_not_or_extra_and_use2_before := [llvmfunc|
  llvm.func @and_not_or_extra_and_use2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg2  : i32
    %4 = llvm.and %arg0, %arg2  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.or %5, %arg1  : i32
    %7 = llvm.and %3, %6  : i32
    llvm.call @use(%6) : (i32) -> ()
    llvm.return %7 : i32
  }]

def and_not_or_extra_or_use1_before := [llvmfunc|
  llvm.func @and_not_or_extra_or_use1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg2  : i32
    %4 = llvm.and %arg0, %arg2  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.or %5, %arg1  : i32
    %7 = llvm.and %3, %6  : i32
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %7 : i32
  }]

def and_not_or_extra_or_use2_before := [llvmfunc|
  llvm.func @and_not_or_extra_or_use2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg2  : i32
    %4 = llvm.and %arg0, %arg2  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.or %5, %arg1  : i32
    %7 = llvm.and %3, %6  : i32
    llvm.call @use(%4) : (i32) -> ()
    llvm.return %7 : i32
  }]

def and_not_or_wrong_c_before := [llvmfunc|
  llvm.func @and_not_or_wrong_c(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg2  : i32
    %4 = llvm.and %arg0, %arg3  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.or %5, %arg1  : i32
    %7 = llvm.and %3, %6  : i32
    llvm.return %7 : i32
  }]

def and_not_or_wrong_b_before := [llvmfunc|
  llvm.func @and_not_or_wrong_b(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg2  : i32
    %4 = llvm.and %arg0, %arg2  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.or %5, %arg3  : i32
    %7 = llvm.and %3, %6  : i32
    llvm.return %7 : i32
  }]

def or_and_not_not_before := [llvmfunc|
  llvm.func @or_and_not_not(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %arg0, %arg2  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.return %6 : i32
  }]

def or_and_not_not_commute1_before := [llvmfunc|
  llvm.func @or_and_not_not_commute1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg1  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.or %arg0, %arg2  : i32
    %6 = llvm.xor %5, %1  : i32
    %7 = llvm.and %2, %6  : i32
    %8 = llvm.or %7, %4  : i32
    llvm.return %8 : i32
  }]

def or_and_not_not_commute2_before := [llvmfunc|
  llvm.func @or_and_not_not_commute2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %arg0, %arg2  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.return %6 : i32
  }]

def or_and_not_not_commute3_before := [llvmfunc|
  llvm.func @or_and_not_not_commute3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %arg2, %arg0  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.return %6 : i32
  }]

def or_and_not_not_commute4_before := [llvmfunc|
  llvm.func @or_and_not_not_commute4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %arg0, %arg2  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.return %6 : i32
  }]

def or_and_not_not_commute5_before := [llvmfunc|
  llvm.func @or_and_not_not_commute5(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %arg0, %arg2  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.or %2, %5  : i32
    llvm.return %6 : i32
  }]

def or_and_not_not_commute6_before := [llvmfunc|
  llvm.func @or_and_not_not_commute6(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg1  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.or %arg2, %arg0  : i32
    %6 = llvm.xor %5, %1  : i32
    %7 = llvm.and %2, %6  : i32
    %8 = llvm.or %7, %4  : i32
    llvm.return %8 : i32
  }]

def or_and_not_not_commute7_before := [llvmfunc|
  llvm.func @or_and_not_not_commute7(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %arg2, %arg0  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.return %6 : i32
  }]

def or_and_not_not_extra_not_use1_before := [llvmfunc|
  llvm.func @or_and_not_not_extra_not_use1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %arg0, %arg2  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %6 : i32
  }]

def or_and_not_not_extra_not_use2_before := [llvmfunc|
  llvm.func @or_and_not_not_extra_not_use2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %arg0, %arg2  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.call @use(%4) : (i32) -> ()
    llvm.return %6 : i32
  }]

def or_and_not_not_extra_and_use_before := [llvmfunc|
  llvm.func @or_and_not_not_extra_and_use(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %arg0, %arg2  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.call @use(%5) : (i32) -> ()
    llvm.return %6 : i32
  }]

def or_and_not_not_extra_or_use1_before := [llvmfunc|
  llvm.func @or_and_not_not_extra_or_use1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %arg0, %arg2  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %6 : i32
  }]

def or_and_not_not_extra_or_use2_before := [llvmfunc|
  llvm.func @or_and_not_not_extra_or_use2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %arg0, %arg2  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.call @use(%3) : (i32) -> ()
    llvm.return %6 : i32
  }]

def or_and_not_not_2_extra_uses_before := [llvmfunc|
  llvm.func @or_and_not_not_2_extra_uses(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %arg0, %arg2  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.and %4, %arg1  : i32
    llvm.call @use(%5) : (i32) -> ()
    %6 = llvm.or %2, %5  : i32
    llvm.return %6 : i32
  }]

def or_and_not_not_wrong_a_before := [llvmfunc|
  llvm.func @or_and_not_not_wrong_a(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg3  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %arg0, %arg2  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.return %6 : i32
  }]

def or_and_not_not_wrong_b_before := [llvmfunc|
  llvm.func @or_and_not_not_wrong_b(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg3, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %arg0, %arg2  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.return %6 : i32
  }]

def and_or_not_not_before := [llvmfunc|
  llvm.func @and_or_not_not(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %arg0, %arg2  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.and %5, %2  : i32
    llvm.return %6 : i32
  }]

def and_or_not_not_commute1_before := [llvmfunc|
  llvm.func @and_or_not_not_commute1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg1  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.and %arg0, %arg2  : i32
    %6 = llvm.xor %5, %1  : i32
    %7 = llvm.or %2, %6  : i32
    %8 = llvm.and %7, %4  : i32
    llvm.return %8 : i32
  }]

def and_or_not_not_commute2_before := [llvmfunc|
  llvm.func @and_or_not_not_commute2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %arg0, %arg2  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.and %5, %2  : i32
    llvm.return %6 : i32
  }]

def and_or_not_not_commute3_before := [llvmfunc|
  llvm.func @and_or_not_not_commute3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %arg2, %arg0  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.and %5, %2  : i32
    llvm.return %6 : i32
  }]

def and_or_not_not_commute4_before := [llvmfunc|
  llvm.func @and_or_not_not_commute4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %arg0, %arg2  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.and %5, %2  : i32
    llvm.return %6 : i32
  }]

def and_or_not_not_commute5_before := [llvmfunc|
  llvm.func @and_or_not_not_commute5(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %arg0, %arg2  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.and %2, %5  : i32
    llvm.return %6 : i32
  }]

def and_or_not_not_commute6_before := [llvmfunc|
  llvm.func @and_or_not_not_commute6(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg1  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.and %arg2, %arg0  : i32
    %6 = llvm.xor %5, %1  : i32
    %7 = llvm.or %2, %6  : i32
    %8 = llvm.and %7, %4  : i32
    llvm.return %8 : i32
  }]

def and_or_not_not_commute7_before := [llvmfunc|
  llvm.func @and_or_not_not_commute7(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %arg2, %arg0  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.and %5, %2  : i32
    llvm.return %6 : i32
  }]

def and_or_not_not_extra_not_use1_before := [llvmfunc|
  llvm.func @and_or_not_not_extra_not_use1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %arg0, %arg2  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.and %5, %2  : i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %6 : i32
  }]

def and_or_not_not_extra_not_use2_before := [llvmfunc|
  llvm.func @and_or_not_not_extra_not_use2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %arg0, %arg2  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.and %5, %2  : i32
    llvm.call @use(%4) : (i32) -> ()
    llvm.return %6 : i32
  }]

def and_or_not_not_extra_and_use_before := [llvmfunc|
  llvm.func @and_or_not_not_extra_and_use(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %arg0, %arg2  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.and %5, %2  : i32
    llvm.call @use(%5) : (i32) -> ()
    llvm.return %6 : i32
  }]

def and_or_not_not_extra_or_use1_before := [llvmfunc|
  llvm.func @and_or_not_not_extra_or_use1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %arg0, %arg2  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.and %5, %2  : i32
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %6 : i32
  }]

def and_or_not_not_extra_or_use2_before := [llvmfunc|
  llvm.func @and_or_not_not_extra_or_use2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %arg0, %arg2  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.and %5, %2  : i32
    llvm.call @use(%3) : (i32) -> ()
    llvm.return %6 : i32
  }]

def and_or_not_not_2_extra_uses_before := [llvmfunc|
  llvm.func @and_or_not_not_2_extra_uses(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %arg0, %arg2  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.or %4, %arg1  : i32
    llvm.call @use(%5) : (i32) -> ()
    %6 = llvm.and %2, %5  : i32
    llvm.return %6 : i32
  }]

def and_or_not_not_wrong_a_before := [llvmfunc|
  llvm.func @and_or_not_not_wrong_a(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg3  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %arg0, %arg2  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.and %5, %2  : i32
    llvm.return %6 : i32
  }]

def and_or_not_not_wrong_b_before := [llvmfunc|
  llvm.func @and_or_not_not_wrong_b(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg3, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %arg0, %arg2  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.and %5, %2  : i32
    llvm.return %6 : i32
  }]

def and_not_or_or_not_or_xor_before := [llvmfunc|
  llvm.func @and_not_or_or_not_or_xor(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg2  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.xor %arg1, %arg2  : i32
    %5 = llvm.or %4, %arg0  : i32
    %6 = llvm.xor %5, %0  : i32
    %7 = llvm.or %3, %6  : i32
    llvm.return %7 : i32
  }]

def and_not_or_or_not_or_xor_commute1_before := [llvmfunc|
  llvm.func @and_not_or_or_not_or_xor_commute1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg2, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.xor %arg1, %arg2  : i32
    %5 = llvm.or %4, %arg0  : i32
    %6 = llvm.xor %5, %0  : i32
    %7 = llvm.or %3, %6  : i32
    llvm.return %7 : i32
  }]

def and_not_or_or_not_or_xor_commute2_before := [llvmfunc|
  llvm.func @and_not_or_or_not_or_xor_commute2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg0  : i32
    %3 = llvm.or %arg1, %arg2  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.and %2, %4  : i32
    %6 = llvm.xor %arg1, %arg2  : i32
    %7 = llvm.or %6, %2  : i32
    %8 = llvm.xor %7, %1  : i32
    %9 = llvm.or %5, %8  : i32
    llvm.return %9 : i32
  }]

def and_not_or_or_not_or_xor_commute3_before := [llvmfunc|
  llvm.func @and_not_or_or_not_or_xor_commute3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg2  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.xor %arg2, %arg1  : i32
    %5 = llvm.or %4, %arg0  : i32
    %6 = llvm.xor %5, %0  : i32
    %7 = llvm.or %3, %6  : i32
    llvm.return %7 : i32
  }]

def and_not_or_or_not_or_xor_commute4_before := [llvmfunc|
  llvm.func @and_not_or_or_not_or_xor_commute4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg0  : i32
    %3 = llvm.or %arg1, %arg2  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.and %2, %4  : i32
    %6 = llvm.xor %arg1, %arg2  : i32
    %7 = llvm.or %2, %6  : i32
    %8 = llvm.xor %7, %1  : i32
    %9 = llvm.or %5, %8  : i32
    llvm.return %9 : i32
  }]

def and_not_or_or_not_or_xor_commute5_before := [llvmfunc|
  llvm.func @and_not_or_or_not_or_xor_commute5(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg2  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.xor %arg1, %arg2  : i32
    %5 = llvm.or %4, %arg0  : i32
    %6 = llvm.xor %5, %0  : i32
    %7 = llvm.or %6, %3  : i32
    llvm.return %7 : i32
  }]

def and_not_or_or_not_or_xor_use1_before := [llvmfunc|
  llvm.func @and_not_or_or_not_or_xor_use1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg2  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.xor %arg1, %arg2  : i32
    %5 = llvm.or %4, %arg0  : i32
    %6 = llvm.xor %5, %0  : i32
    %7 = llvm.or %3, %6  : i32
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %7 : i32
  }]

def and_not_or_or_not_or_xor_use2_before := [llvmfunc|
  llvm.func @and_not_or_or_not_or_xor_use2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg2  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.xor %arg1, %arg2  : i32
    %5 = llvm.or %4, %arg0  : i32
    %6 = llvm.xor %5, %0  : i32
    %7 = llvm.or %3, %6  : i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %7 : i32
  }]

def and_not_or_or_not_or_xor_use3_before := [llvmfunc|
  llvm.func @and_not_or_or_not_or_xor_use3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg2  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.xor %arg1, %arg2  : i32
    %5 = llvm.or %4, %arg0  : i32
    %6 = llvm.xor %5, %0  : i32
    %7 = llvm.or %3, %6  : i32
    llvm.call @use(%3) : (i32) -> ()
    llvm.return %7 : i32
  }]

def and_not_or_or_not_or_xor_use4_before := [llvmfunc|
  llvm.func @and_not_or_or_not_or_xor_use4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg2  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.xor %arg1, %arg2  : i32
    %5 = llvm.or %4, %arg0  : i32
    %6 = llvm.xor %5, %0  : i32
    %7 = llvm.or %3, %6  : i32
    llvm.call @use(%4) : (i32) -> ()
    llvm.return %7 : i32
  }]

def and_not_or_or_not_or_xor_use5_before := [llvmfunc|
  llvm.func @and_not_or_or_not_or_xor_use5(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg2  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.xor %arg1, %arg2  : i32
    %5 = llvm.or %4, %arg0  : i32
    %6 = llvm.xor %5, %0  : i32
    %7 = llvm.or %3, %6  : i32
    llvm.call @use(%5) : (i32) -> ()
    llvm.return %7 : i32
  }]

def and_not_or_or_not_or_xor_use6_before := [llvmfunc|
  llvm.func @and_not_or_or_not_or_xor_use6(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg2  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.xor %arg1, %arg2  : i32
    %5 = llvm.or %4, %arg0  : i32
    %6 = llvm.xor %5, %0  : i32
    %7 = llvm.or %3, %6  : i32
    llvm.call @use(%6) : (i32) -> ()
    llvm.return %7 : i32
  }]

def or_not_and_and_not_and_xor_before := [llvmfunc|
  llvm.func @or_not_and_and_not_and_xor(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg2  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.xor %arg1, %arg2  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.xor %5, %0  : i32
    %7 = llvm.and %3, %6  : i32
    llvm.return %7 : i32
  }]

def or_not_and_and_not_and_xor_commute1_before := [llvmfunc|
  llvm.func @or_not_and_and_not_and_xor_commute1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg2, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.xor %arg1, %arg2  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.xor %5, %0  : i32
    %7 = llvm.and %3, %6  : i32
    llvm.return %7 : i32
  }]

def or_not_and_and_not_and_xor_commute2_before := [llvmfunc|
  llvm.func @or_not_and_and_not_and_xor_commute2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg0  : i32
    %3 = llvm.and %arg1, %arg2  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.or %2, %4  : i32
    %6 = llvm.xor %arg1, %arg2  : i32
    %7 = llvm.and %6, %2  : i32
    %8 = llvm.xor %7, %1  : i32
    %9 = llvm.and %5, %8  : i32
    llvm.return %9 : i32
  }]

def or_not_and_and_not_and_xor_commute3_before := [llvmfunc|
  llvm.func @or_not_and_and_not_and_xor_commute3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg2  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.xor %arg2, %arg1  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.xor %5, %0  : i32
    %7 = llvm.and %3, %6  : i32
    llvm.return %7 : i32
  }]

def or_not_and_and_not_and_xor_commute4_before := [llvmfunc|
  llvm.func @or_not_and_and_not_and_xor_commute4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg0  : i32
    %3 = llvm.and %arg1, %arg2  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.or %2, %4  : i32
    %6 = llvm.xor %arg1, %arg2  : i32
    %7 = llvm.and %2, %6  : i32
    %8 = llvm.xor %7, %1  : i32
    %9 = llvm.and %5, %8  : i32
    llvm.return %9 : i32
  }]

def or_not_and_and_not_and_xor_commute5_before := [llvmfunc|
  llvm.func @or_not_and_and_not_and_xor_commute5(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg2  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.xor %arg1, %arg2  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.xor %5, %0  : i32
    %7 = llvm.and %6, %3  : i32
    llvm.return %7 : i32
  }]

def or_not_and_and_not_and_xor_use1_before := [llvmfunc|
  llvm.func @or_not_and_and_not_and_xor_use1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg2  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.xor %arg1, %arg2  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.xor %5, %0  : i32
    %7 = llvm.and %3, %6  : i32
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %7 : i32
  }]

def or_not_and_and_not_and_xor_use2_before := [llvmfunc|
  llvm.func @or_not_and_and_not_and_xor_use2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg2  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.xor %arg1, %arg2  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.xor %5, %0  : i32
    %7 = llvm.and %3, %6  : i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %7 : i32
  }]

def or_not_and_and_not_and_xor_use3_before := [llvmfunc|
  llvm.func @or_not_and_and_not_and_xor_use3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg2  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.xor %arg1, %arg2  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.xor %5, %0  : i32
    %7 = llvm.and %3, %6  : i32
    llvm.call @use(%3) : (i32) -> ()
    llvm.return %7 : i32
  }]

def or_not_and_and_not_and_xor_use4_before := [llvmfunc|
  llvm.func @or_not_and_and_not_and_xor_use4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg2  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.xor %arg1, %arg2  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.xor %5, %0  : i32
    %7 = llvm.and %3, %6  : i32
    llvm.call @use(%4) : (i32) -> ()
    llvm.return %7 : i32
  }]

def or_not_and_and_not_and_xor_use5_before := [llvmfunc|
  llvm.func @or_not_and_and_not_and_xor_use5(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg2  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.xor %arg1, %arg2  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.xor %5, %0  : i32
    %7 = llvm.and %3, %6  : i32
    llvm.call @use(%5) : (i32) -> ()
    llvm.return %7 : i32
  }]

def or_not_and_and_not_and_xor_use6_before := [llvmfunc|
  llvm.func @or_not_and_and_not_and_xor_use6(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg2  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.xor %arg1, %arg2  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.xor %5, %0  : i32
    %7 = llvm.and %3, %6  : i32
    llvm.call @use(%6) : (i32) -> ()
    llvm.return %7 : i32
  }]

def not_and_and_or_not_or_or_before := [llvmfunc|
  llvm.func @not_and_and_or_not_or_or(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.or %1, %arg2  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.and %5, %arg2  : i32
    %7 = llvm.or %6, %3  : i32
    llvm.return %7 : i32
  }]

def not_and_and_or_not_or_or_commute1_or_before := [llvmfunc|
  llvm.func @not_and_and_or_not_or_or_commute1_or(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg2, %arg0  : i32
    %2 = llvm.or %1, %arg1  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.and %5, %arg2  : i32
    %7 = llvm.or %6, %3  : i32
    llvm.return %7 : i32
  }]

def not_and_and_or_not_or_or_commute2_or_before := [llvmfunc|
  llvm.func @not_and_and_or_not_or_or_commute2_or(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg2  : i32
    %2 = llvm.or %1, %arg0  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.and %5, %arg2  : i32
    %7 = llvm.or %6, %3  : i32
    llvm.return %7 : i32
  }]

def not_and_and_or_not_or_or_commute1_and_before := [llvmfunc|
  llvm.func @not_and_and_or_not_or_or_commute1_and(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.or %1, %arg2  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.and %4, %arg2  : i32
    %6 = llvm.and %5, %arg1  : i32
    %7 = llvm.or %6, %3  : i32
    llvm.return %7 : i32
  }]

def not_and_and_or_not_or_or_commute2_and_before := [llvmfunc|
  llvm.func @not_and_and_or_not_or_or_commute2_and(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.or %1, %arg2  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.and %arg1, %arg2  : i32
    %6 = llvm.and %5, %4  : i32
    %7 = llvm.or %6, %3  : i32
    llvm.return %7 : i32
  }]

def not_and_and_or_not_or_or_commute1_before := [llvmfunc|
  llvm.func @not_and_and_or_not_or_or_commute1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.or %1, %arg2  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.and %5, %arg2  : i32
    %7 = llvm.or %6, %3  : i32
    llvm.return %7 : i32
  }]

def not_and_and_or_not_or_or_commute2_before := [llvmfunc|
  llvm.func @not_and_and_or_not_or_or_commute2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg2  : i32
    %3 = llvm.or %arg1, %arg0  : i32
    %4 = llvm.or %2, %3  : i32
    %5 = llvm.xor %4, %1  : i32
    %6 = llvm.xor %arg0, %1  : i32
    %7 = llvm.and %6, %arg1  : i32
    %8 = llvm.and %7, %2  : i32
    %9 = llvm.or %8, %5  : i32
    llvm.return %9 : i32
  }]

def not_and_and_or_not_or_or_commute3_before := [llvmfunc|
  llvm.func @not_and_and_or_not_or_or_commute3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg1  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.or %3, %arg2  : i32
    %5 = llvm.xor %4, %1  : i32
    %6 = llvm.xor %arg0, %1  : i32
    %7 = llvm.and %2, %6  : i32
    %8 = llvm.and %7, %arg2  : i32
    %9 = llvm.or %8, %5  : i32
    llvm.return %9 : i32
  }]

def not_and_and_or_not_or_or_commute4_before := [llvmfunc|
  llvm.func @not_and_and_or_not_or_or_commute4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg2  : i32
    %3 = llvm.or %arg1, %arg0  : i32
    %4 = llvm.or %3, %2  : i32
    %5 = llvm.xor %4, %1  : i32
    %6 = llvm.xor %arg0, %1  : i32
    %7 = llvm.and %6, %arg1  : i32
    %8 = llvm.and %2, %7  : i32
    %9 = llvm.or %8, %5  : i32
    llvm.return %9 : i32
  }]

def not_and_and_or_not_or_or_use1_before := [llvmfunc|
  llvm.func @not_and_and_or_not_or_or_use1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.or %1, %arg2  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.and %5, %arg2  : i32
    %7 = llvm.or %6, %3  : i32
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %7 : i32
  }]

def not_and_and_or_not_or_or_use2_before := [llvmfunc|
  llvm.func @not_and_and_or_not_or_or_use2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.or %1, %arg2  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.and %5, %arg2  : i32
    %7 = llvm.or %6, %3  : i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %7 : i32
  }]

def not_and_and_or_not_or_or_use3_before := [llvmfunc|
  llvm.func @not_and_and_or_not_or_or_use3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.or %1, %arg2  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.and %5, %arg2  : i32
    %7 = llvm.or %6, %3  : i32
    llvm.call @use(%3) : (i32) -> ()
    llvm.return %7 : i32
  }]

def not_and_and_or_not_or_or_use4_before := [llvmfunc|
  llvm.func @not_and_and_or_not_or_or_use4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.or %1, %arg2  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.and %5, %arg2  : i32
    %7 = llvm.or %6, %3  : i32
    llvm.call @use(%4) : (i32) -> ()
    llvm.return %7 : i32
  }]

def not_and_and_or_not_or_or_use5_before := [llvmfunc|
  llvm.func @not_and_and_or_not_or_or_use5(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.or %1, %arg2  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.and %5, %arg2  : i32
    %7 = llvm.or %6, %3  : i32
    llvm.call @use(%5) : (i32) -> ()
    llvm.return %7 : i32
  }]

def not_and_and_or_not_or_or_use6_before := [llvmfunc|
  llvm.func @not_and_and_or_not_or_or_use6(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.or %1, %arg2  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.and %5, %arg2  : i32
    %7 = llvm.or %6, %3  : i32
    llvm.call @use(%6) : (i32) -> ()
    llvm.return %7 : i32
  }]

def not_or_or_and_not_and_and_before := [llvmfunc|
  llvm.func @not_or_or_and_not_and_and(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.and %1, %arg2  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.or %5, %arg2  : i32
    %7 = llvm.and %6, %3  : i32
    llvm.return %7 : i32
  }]

def not_or_or_and_not_and_and_commute1_and_before := [llvmfunc|
  llvm.func @not_or_or_and_not_and_and_commute1_and(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg2, %arg0  : i32
    %2 = llvm.and %1, %arg1  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.or %5, %arg2  : i32
    %7 = llvm.and %6, %3  : i32
    llvm.return %7 : i32
  }]

def not_or_or_and_not_and_and_commute2_and_before := [llvmfunc|
  llvm.func @not_or_or_and_not_and_and_commute2_and(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg2  : i32
    %2 = llvm.and %1, %arg0  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.or %5, %arg2  : i32
    %7 = llvm.and %6, %3  : i32
    llvm.return %7 : i32
  }]

def not_or_or_and_not_and_and_commute1_or_before := [llvmfunc|
  llvm.func @not_or_or_and_not_and_and_commute1_or(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.and %1, %arg2  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.or %4, %arg2  : i32
    %6 = llvm.or %5, %arg1  : i32
    %7 = llvm.and %6, %3  : i32
    llvm.return %7 : i32
  }]

def not_or_or_and_not_and_and_commute2_or_before := [llvmfunc|
  llvm.func @not_or_or_and_not_and_and_commute2_or(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.and %1, %arg2  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.or %arg1, %arg2  : i32
    %6 = llvm.or %5, %4  : i32
    %7 = llvm.and %6, %3  : i32
    llvm.return %7 : i32
  }]

def not_or_or_and_not_and_and_commute1_before := [llvmfunc|
  llvm.func @not_or_or_and_not_and_and_commute1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.and %1, %arg2  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.or %5, %arg2  : i32
    %7 = llvm.and %6, %3  : i32
    llvm.return %7 : i32
  }]

def not_or_or_and_not_and_and_commute2_before := [llvmfunc|
  llvm.func @not_or_or_and_not_and_and_commute2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg2  : i32
    %3 = llvm.and %arg1, %arg0  : i32
    %4 = llvm.and %2, %3  : i32
    %5 = llvm.xor %4, %1  : i32
    %6 = llvm.xor %arg0, %1  : i32
    %7 = llvm.or %6, %arg1  : i32
    %8 = llvm.or %7, %2  : i32
    %9 = llvm.and %8, %5  : i32
    llvm.return %9 : i32
  }]

def not_or_or_and_not_and_and_commute3_before := [llvmfunc|
  llvm.func @not_or_or_and_not_and_and_commute3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg1  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.and %3, %arg2  : i32
    %5 = llvm.xor %4, %1  : i32
    %6 = llvm.xor %arg0, %1  : i32
    %7 = llvm.or %2, %6  : i32
    %8 = llvm.or %7, %arg2  : i32
    %9 = llvm.and %8, %5  : i32
    llvm.return %9 : i32
  }]

def not_or_or_and_not_and_and_commute4_before := [llvmfunc|
  llvm.func @not_or_or_and_not_and_and_commute4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg2  : i32
    %3 = llvm.and %arg1, %arg0  : i32
    %4 = llvm.and %3, %2  : i32
    %5 = llvm.xor %4, %1  : i32
    %6 = llvm.xor %arg0, %1  : i32
    %7 = llvm.or %6, %arg1  : i32
    %8 = llvm.or %2, %7  : i32
    %9 = llvm.and %8, %5  : i32
    llvm.return %9 : i32
  }]

def not_or_or_and_not_and_and_use1_before := [llvmfunc|
  llvm.func @not_or_or_and_not_and_and_use1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.and %1, %arg2  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.or %5, %arg2  : i32
    %7 = llvm.and %6, %3  : i32
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %7 : i32
  }]

def not_or_or_and_not_and_and_use2_before := [llvmfunc|
  llvm.func @not_or_or_and_not_and_and_use2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.and %1, %arg2  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.or %5, %arg2  : i32
    %7 = llvm.and %6, %3  : i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %7 : i32
  }]

def not_or_or_and_not_and_and_use3_before := [llvmfunc|
  llvm.func @not_or_or_and_not_and_and_use3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.and %1, %arg2  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.or %5, %arg2  : i32
    %7 = llvm.and %6, %3  : i32
    llvm.call @use(%3) : (i32) -> ()
    llvm.return %7 : i32
  }]

def not_or_or_and_not_and_and_use4_before := [llvmfunc|
  llvm.func @not_or_or_and_not_and_and_use4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.and %1, %arg2  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.or %5, %arg2  : i32
    %7 = llvm.and %6, %3  : i32
    llvm.call @use(%4) : (i32) -> ()
    llvm.return %7 : i32
  }]

def not_or_or_and_not_and_and_use5_before := [llvmfunc|
  llvm.func @not_or_or_and_not_and_and_use5(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.and %1, %arg2  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.or %5, %arg2  : i32
    %7 = llvm.and %6, %3  : i32
    llvm.call @use(%5) : (i32) -> ()
    llvm.return %7 : i32
  }]

def not_or_or_and_not_and_and_use6_before := [llvmfunc|
  llvm.func @not_or_or_and_not_and_and_use6(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.and %1, %arg2  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.or %5, %arg2  : i32
    %7 = llvm.and %6, %3  : i32
    llvm.call @use(%6) : (i32) -> ()
    llvm.return %7 : i32
  }]

def not_and_and_or_no_or_before := [llvmfunc|
  llvm.func @not_and_and_or_no_or(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.and %3, %arg1  : i32
    %5 = llvm.and %4, %arg2  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.return %6 : i32
  }]

def not_and_and_or_no_or_commute1_and_before := [llvmfunc|
  llvm.func @not_and_and_or_no_or_commute1_and(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.and %arg2, %arg1  : i32
    %5 = llvm.and %4, %3  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.return %6 : i32
  }]

def not_and_and_or_no_or_commute2_and_before := [llvmfunc|
  llvm.func @not_and_and_or_no_or_commute2_and(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.and %3, %arg2  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.return %6 : i32
  }]

def not_and_and_or_no_or_commute1_before := [llvmfunc|
  llvm.func @not_and_and_or_no_or_commute1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.and %3, %arg1  : i32
    %5 = llvm.and %4, %arg2  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.return %6 : i32
  }]

def not_and_and_or_no_or_commute2_before := [llvmfunc|
  llvm.func @not_and_and_or_no_or_commute2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg1  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.xor %arg0, %1  : i32
    %6 = llvm.and %2, %5  : i32
    %7 = llvm.and %6, %arg2  : i32
    %8 = llvm.or %7, %4  : i32
    llvm.return %8 : i32
  }]

def not_and_and_or_no_or_commute3_before := [llvmfunc|
  llvm.func @not_and_and_or_no_or_commute3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg2  : i32
    %3 = llvm.or %arg1, %arg0  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.xor %arg0, %1  : i32
    %6 = llvm.and %5, %arg1  : i32
    %7 = llvm.and %2, %6  : i32
    %8 = llvm.or %7, %4  : i32
    llvm.return %8 : i32
  }]

def not_and_and_or_no_or_use1_before := [llvmfunc|
  llvm.func @not_and_and_or_no_or_use1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.and %3, %arg1  : i32
    %5 = llvm.and %4, %arg2  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.call @use(%3) : (i32) -> ()
    llvm.return %6 : i32
  }]

def not_and_and_or_no_or_use2_before := [llvmfunc|
  llvm.func @not_and_and_or_no_or_use2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.and %arg1, %arg2  : i32
    %5 = llvm.and %4, %3  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.call @use(%3) : (i32) -> ()
    llvm.return %6 : i32
  }]

def not_and_and_or_no_or_use3_before := [llvmfunc|
  llvm.func @not_and_and_or_no_or_use3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.and %3, %arg2  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.call @use(%3) : (i32) -> ()
    llvm.return %6 : i32
  }]

def not_and_and_or_no_or_use4_before := [llvmfunc|
  llvm.func @not_and_and_or_no_or_use4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.and %3, %arg2  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.call @use(%3) : (i32) -> ()
    llvm.return %6 : i32
  }]

def not_and_and_or_no_or_use5_before := [llvmfunc|
  llvm.func @not_and_and_or_no_or_use5(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.and %3, %arg1  : i32
    %5 = llvm.and %4, %arg2  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %6 : i32
  }]

def not_and_and_or_no_or_use6_before := [llvmfunc|
  llvm.func @not_and_and_or_no_or_use6(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.and %3, %arg1  : i32
    %5 = llvm.and %4, %arg2  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %6 : i32
  }]

def not_and_and_or_no_or_use7_before := [llvmfunc|
  llvm.func @not_and_and_or_no_or_use7(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.and %3, %arg1  : i32
    %5 = llvm.and %4, %arg2  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.call @use(%4) : (i32) -> ()
    llvm.return %6 : i32
  }]

def not_and_and_or_no_or_use8_before := [llvmfunc|
  llvm.func @not_and_and_or_no_or_use8(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.and %3, %arg1  : i32
    %5 = llvm.and %4, %arg2  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.call @use(%5) : (i32) -> ()
    llvm.return %6 : i32
  }]

def not_or_or_and_no_and_before := [llvmfunc|
  llvm.func @not_or_or_and_no_and(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.or %3, %arg1  : i32
    %5 = llvm.or %4, %arg2  : i32
    %6 = llvm.and %5, %2  : i32
    llvm.return %6 : i32
  }]

def not_or_or_and_no_and_commute1_or_before := [llvmfunc|
  llvm.func @not_or_or_and_no_and_commute1_or(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.or %arg2, %arg1  : i32
    %5 = llvm.or %4, %3  : i32
    %6 = llvm.and %5, %2  : i32
    llvm.return %6 : i32
  }]

def not_or_or_and_no_and_commute2_or_before := [llvmfunc|
  llvm.func @not_or_or_and_no_and_commute2_or(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.or %3, %arg2  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.and %5, %2  : i32
    llvm.return %6 : i32
  }]

def not_or_or_and_no_and_commute1_before := [llvmfunc|
  llvm.func @not_or_or_and_no_and_commute1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.or %3, %arg1  : i32
    %5 = llvm.or %4, %arg2  : i32
    %6 = llvm.and %5, %2  : i32
    llvm.return %6 : i32
  }]

def not_or_or_and_no_and_commute2_before := [llvmfunc|
  llvm.func @not_or_or_and_no_and_commute2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg1  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.xor %arg0, %1  : i32
    %6 = llvm.or %2, %5  : i32
    %7 = llvm.or %6, %arg2  : i32
    %8 = llvm.and %7, %4  : i32
    llvm.return %8 : i32
  }]

def not_or_or_and_no_and_commute3_before := [llvmfunc|
  llvm.func @not_or_or_and_no_and_commute3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg2  : i32
    %3 = llvm.and %arg1, %arg0  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.xor %arg0, %1  : i32
    %6 = llvm.or %5, %arg1  : i32
    %7 = llvm.or %2, %6  : i32
    %8 = llvm.and %7, %4  : i32
    llvm.return %8 : i32
  }]

def not_or_or_and_no_and_use1_before := [llvmfunc|
  llvm.func @not_or_or_and_no_and_use1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.or %3, %arg1  : i32
    %5 = llvm.or %4, %arg2  : i32
    %6 = llvm.and %5, %2  : i32
    llvm.call @use(%3) : (i32) -> ()
    llvm.return %6 : i32
  }]

def not_or_or_and_no_and_use2_before := [llvmfunc|
  llvm.func @not_or_or_and_no_and_use2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.or %arg1, %arg2  : i32
    %5 = llvm.or %4, %3  : i32
    %6 = llvm.and %5, %2  : i32
    llvm.call @use(%3) : (i32) -> ()
    llvm.return %6 : i32
  }]

def not_or_or_and_no_and_use3_before := [llvmfunc|
  llvm.func @not_or_or_and_no_and_use3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.or %3, %arg2  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.and %5, %2  : i32
    llvm.call @use(%3) : (i32) -> ()
    llvm.return %6 : i32
  }]

def not_or_or_and_no_and_use4_before := [llvmfunc|
  llvm.func @not_or_or_and_no_and_use4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.or %3, %arg2  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.and %5, %2  : i32
    llvm.call @use(%3) : (i32) -> ()
    llvm.return %6 : i32
  }]

def not_or_or_and_no_and_use5_before := [llvmfunc|
  llvm.func @not_or_or_and_no_and_use5(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.or %3, %arg1  : i32
    %5 = llvm.or %4, %arg2  : i32
    %6 = llvm.and %5, %2  : i32
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %6 : i32
  }]

def not_or_or_and_no_and_use6_before := [llvmfunc|
  llvm.func @not_or_or_and_no_and_use6(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.or %3, %arg1  : i32
    %5 = llvm.or %4, %arg2  : i32
    %6 = llvm.and %5, %2  : i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %6 : i32
  }]

def not_or_or_and_no_and_use7_before := [llvmfunc|
  llvm.func @not_or_or_and_no_and_use7(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.or %3, %arg1  : i32
    %5 = llvm.or %4, %arg2  : i32
    %6 = llvm.and %5, %2  : i32
    llvm.call @use(%4) : (i32) -> ()
    llvm.return %6 : i32
  }]

def not_or_or_and_no_and_use8_before := [llvmfunc|
  llvm.func @not_or_or_and_no_and_use8(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.or %3, %arg1  : i32
    %5 = llvm.or %4, %arg2  : i32
    %6 = llvm.and %5, %2  : i32
    llvm.call @use(%5) : (i32) -> ()
    llvm.return %6 : i32
  }]

def and_orn_xor_before := [llvmfunc|
  llvm.func @and_orn_xor(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.xor %arg0, %arg1  : i4
    %2 = llvm.xor %arg0, %0  : i4
    %3 = llvm.or %2, %arg1  : i4
    %4 = llvm.and %3, %1  : i4
    llvm.return %4 : i4
  }]

def and_orn_xor_commute1_before := [llvmfunc|
  llvm.func @and_orn_xor_commute1(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.poison : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.mlir.undef : vector<2xi4>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi4>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi4>
    %7 = llvm.xor %arg0, %arg1  : vector<2xi4>
    %8 = llvm.xor %arg0, %6  : vector<2xi4>
    %9 = llvm.or %8, %arg1  : vector<2xi4>
    %10 = llvm.and %7, %9  : vector<2xi4>
    llvm.return %10 : vector<2xi4>
  }]

def and_orn_xor_commute2_before := [llvmfunc|
  llvm.func @and_orn_xor_commute2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %arg0  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.or %2, %arg1  : i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }]

def and_orn_xor_commute3_before := [llvmfunc|
  llvm.func @and_orn_xor_commute3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %arg0  : i32
    %2 = llvm.xor %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.or %2, %arg1  : i32
    %4 = llvm.and %1, %3  : i32
    llvm.return %4 : i32
  }]

def and_orn_xor_commute5_before := [llvmfunc|
  llvm.func @and_orn_xor_commute5(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mul %arg0, %arg0  : i32
    %2 = llvm.mul %arg1, %arg1  : i32
    %3 = llvm.xor %1, %2  : i32
    %4 = llvm.xor %1, %0  : i32
    %5 = llvm.or %2, %4  : i32
    llvm.call @use(%5) : (i32) -> ()
    %6 = llvm.and %5, %3  : i32
    llvm.return %6 : i32
  }]

def and_orn_xor_commute6_before := [llvmfunc|
  llvm.func @and_orn_xor_commute6(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mul %arg0, %arg0  : i32
    %2 = llvm.mul %arg1, %arg1  : i32
    %3 = llvm.xor %1, %2  : i32
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.xor %1, %0  : i32
    llvm.call @use(%4) : (i32) -> ()
    %5 = llvm.or %2, %4  : i32
    %6 = llvm.and %3, %5  : i32
    llvm.return %6 : i32
  }]

def and_orn_xor_commute7_before := [llvmfunc|
  llvm.func @and_orn_xor_commute7(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mul %arg0, %arg0  : i32
    %2 = llvm.mul %arg1, %arg1  : i32
    %3 = llvm.xor %2, %1  : i32
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.xor %1, %0  : i32
    llvm.call @use(%4) : (i32) -> ()
    %5 = llvm.or %2, %4  : i32
    llvm.call @use(%5) : (i32) -> ()
    %6 = llvm.and %5, %3  : i32
    llvm.return %6 : i32
  }]

def and_orn_xor_commute8_before := [llvmfunc|
  llvm.func @and_orn_xor_commute8(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mul %arg0, %arg0  : i32
    %2 = llvm.mul %arg1, %arg1  : i32
    %3 = llvm.xor %2, %1  : i32
    %4 = llvm.xor %1, %0  : i32
    %5 = llvm.or %2, %4  : i32
    %6 = llvm.and %3, %5  : i32
    llvm.return %6 : i32
  }]

def zext_zext_and_uses_before := [llvmfunc|
  llvm.func @zext_zext_and_uses(%arg0: i8, %arg1: i8) -> i32 {
    %0 = llvm.zext %arg0 : i8 to i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.zext %arg1 : i8 to i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.and %0, %1  : i32
    llvm.return %2 : i32
  }]

def sext_sext_or_uses_before := [llvmfunc|
  llvm.func @sext_sext_or_uses(%arg0: i8, %arg1: i8) -> i32 {
    %0 = llvm.sext %arg0 : i8 to i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.sext %arg1 : i8 to i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.or %0, %1  : i32
    llvm.return %2 : i32
  }]

def trunc_trunc_xor_uses_before := [llvmfunc|
  llvm.func @trunc_trunc_xor_uses(%arg0: i65, %arg1: i65) -> i32 {
    %0 = llvm.trunc %arg0 : i65 to i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.trunc %arg1 : i65 to i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.xor %0, %1  : i32
    llvm.return %2 : i32
  }]

def and_zext_zext_before := [llvmfunc|
  llvm.func @and_zext_zext(%arg0: i8, %arg1: i4) -> i16 {
    %0 = llvm.zext %arg0 : i8 to i16
    %1 = llvm.zext %arg1 : i4 to i16
    %2 = llvm.and %0, %1  : i16
    llvm.return %2 : i16
  }]

def or_zext_zext_before := [llvmfunc|
  llvm.func @or_zext_zext(%arg0: i8, %arg1: i4) -> i16 {
    %0 = llvm.zext %arg0 : i8 to i16
    %1 = llvm.zext %arg1 : i4 to i16
    %2 = llvm.or %1, %0  : i16
    llvm.return %2 : i16
  }]

def xor_zext_zext_before := [llvmfunc|
  llvm.func @xor_zext_zext(%arg0: vector<2xi8>, %arg1: vector<2xi4>) -> vector<2xi16> {
    %0 = llvm.zext %arg0 : vector<2xi8> to vector<2xi16>
    %1 = llvm.zext %arg1 : vector<2xi4> to vector<2xi16>
    %2 = llvm.xor %0, %1  : vector<2xi16>
    llvm.return %2 : vector<2xi16>
  }]

def and_sext_sext_before := [llvmfunc|
  llvm.func @and_sext_sext(%arg0: i8, %arg1: i4) -> i16 {
    %0 = llvm.sext %arg0 : i8 to i16
    %1 = llvm.sext %arg1 : i4 to i16
    %2 = llvm.and %1, %0  : i16
    llvm.return %2 : i16
  }]

def or_sext_sext_before := [llvmfunc|
  llvm.func @or_sext_sext(%arg0: i8, %arg1: i4) -> i16 {
    %0 = llvm.sext %arg0 : i8 to i16
    %1 = llvm.sext %arg1 : i4 to i16
    %2 = llvm.or %0, %1  : i16
    llvm.return %2 : i16
  }]

def xor_sext_sext_before := [llvmfunc|
  llvm.func @xor_sext_sext(%arg0: i8, %arg1: i4) -> i16 {
    %0 = llvm.sext %arg0 : i8 to i16
    %1 = llvm.sext %arg1 : i4 to i16
    %2 = llvm.xor %0, %1  : i16
    llvm.return %2 : i16
  }]

def and_zext_sext_before := [llvmfunc|
  llvm.func @and_zext_sext(%arg0: i8, %arg1: i4) -> i16 {
    %0 = llvm.zext %arg0 : i8 to i16
    %1 = llvm.sext %arg1 : i4 to i16
    %2 = llvm.and %0, %1  : i16
    llvm.return %2 : i16
  }]

def and_zext_zext_use1_before := [llvmfunc|
  llvm.func @and_zext_zext_use1(%arg0: i8, %arg1: i4) -> i32 {
    %0 = llvm.zext %arg0 : i8 to i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.zext %arg1 : i4 to i32
    %2 = llvm.and %0, %1  : i32
    llvm.return %2 : i32
  }]

def or_sext_sext_use1_before := [llvmfunc|
  llvm.func @or_sext_sext_use1(%arg0: i8, %arg1: i4) -> i32 {
    %0 = llvm.sext %arg0 : i8 to i32
    %1 = llvm.sext %arg1 : i4 to i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.or %0, %1  : i32
    llvm.return %2 : i32
  }]

def PR56294_before := [llvmfunc|
  llvm.func @PR56294(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.and %arg0, %1  : i8
    %5 = llvm.zext %3 : i1 to i32
    %6 = llvm.zext %4 : i8 to i32
    %7 = llvm.and %5, %6  : i32
    %8 = llvm.icmp "ne" %7, %2 : i32
    llvm.return %8 : i1
  }]

def canonicalize_logic_first_or0_before := [llvmfunc|
  llvm.func @canonicalize_logic_first_or0(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(112 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.or %2, %1  : i32
    llvm.return %3 : i32
  }]

def canonicalize_logic_first_or0_nsw_before := [llvmfunc|
  llvm.func @canonicalize_logic_first_or0_nsw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(112 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.or %2, %1  : i32
    llvm.return %3 : i32
  }]

def canonicalize_logic_first_or0_nswnuw_before := [llvmfunc|
  llvm.func @canonicalize_logic_first_or0_nswnuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(112 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nsw, nuw>  : i32
    %3 = llvm.or %2, %1  : i32
    llvm.return %3 : i32
  }]

def canonicalize_logic_first_or_vector0_before := [llvmfunc|
  llvm.func @canonicalize_logic_first_or_vector0(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<112> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<15> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %0, %arg0  : vector<2xi32>
    %3 = llvm.or %1, %2  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def canonicalize_logic_first_or_vector0_nsw_before := [llvmfunc|
  llvm.func @canonicalize_logic_first_or_vector0_nsw(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<112> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<15> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %0, %arg0 overflow<nsw>  : vector<2xi32>
    %3 = llvm.or %1, %2  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def canonicalize_logic_first_or_vector0_nswnuw_before := [llvmfunc|
  llvm.func @canonicalize_logic_first_or_vector0_nswnuw(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<112> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<15> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %0, %arg0 overflow<nsw, nuw>  : vector<2xi32>
    %3 = llvm.or %1, %2  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def canonicalize_logic_first_or_vector1_before := [llvmfunc|
  llvm.func @canonicalize_logic_first_or_vector1(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[-8388608, 2071986176]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[32783, 2063]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %0, %arg0  : vector<2xi32>
    %3 = llvm.or %1, %2  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def canonicalize_logic_first_or_vector1_nsw_before := [llvmfunc|
  llvm.func @canonicalize_logic_first_or_vector1_nsw(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[-8388608, 2071986176]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[32783, 2063]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %0, %arg0 overflow<nsw>  : vector<2xi32>
    %3 = llvm.or %1, %2  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def canonicalize_logic_first_or_vector1_nswnuw_before := [llvmfunc|
  llvm.func @canonicalize_logic_first_or_vector1_nswnuw(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[-8388608, 2071986176]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[32783, 2063]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %0, %arg0 overflow<nsw, nuw>  : vector<2xi32>
    %3 = llvm.or %1, %2  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def canonicalize_logic_first_or_vector2_before := [llvmfunc|
  llvm.func @canonicalize_logic_first_or_vector2(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[2147483632, 2147483640]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[32783, 2063]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %0, %arg0  : vector<2xi32>
    %3 = llvm.or %1, %2  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def canonicalize_logic_first_or_mult_use1_before := [llvmfunc|
  llvm.func @canonicalize_logic_first_or_mult_use1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(112 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.or %2, %1  : i32
    llvm.return %3 : i32
  }]

def canonicalize_logic_first_or_bad_constraints2_before := [llvmfunc|
  llvm.func @canonicalize_logic_first_or_bad_constraints2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(112 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.or %2, %1  : i32
    llvm.return %3 : i32
  }]

def canonicalize_logic_first_and0_before := [llvmfunc|
  llvm.func @canonicalize_logic_first_and0(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(48 : i8) : i8
    %1 = llvm.mlir.constant(-10 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.and %2, %1  : i8
    llvm.return %3 : i8
  }]

def canonicalize_logic_first_and0_nsw_before := [llvmfunc|
  llvm.func @canonicalize_logic_first_and0_nsw(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(48 : i8) : i8
    %1 = llvm.mlir.constant(-10 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.and %2, %1  : i8
    llvm.return %3 : i8
  }]

def canonicalize_logic_first_and0_nswnuw_before := [llvmfunc|
  llvm.func @canonicalize_logic_first_and0_nswnuw(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(48 : i8) : i8
    %1 = llvm.mlir.constant(-10 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw, nuw>  : i8
    %3 = llvm.and %2, %1  : i8
    llvm.return %3 : i8
  }]

def canonicalize_logic_first_and_vector0_before := [llvmfunc|
  llvm.func @canonicalize_logic_first_and_vector0(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<48> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-10> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %0, %arg0  : vector<2xi8>
    %3 = llvm.and %1, %2  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def canonicalize_logic_first_and_vector0_nsw_before := [llvmfunc|
  llvm.func @canonicalize_logic_first_and_vector0_nsw(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<48> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-10> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %0, %arg0 overflow<nsw>  : vector<2xi8>
    %3 = llvm.and %1, %2  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def canonicalize_logic_first_and_vector0_nswnuw_before := [llvmfunc|
  llvm.func @canonicalize_logic_first_and_vector0_nswnuw(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<48> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-10> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %0, %arg0 overflow<nsw, nuw>  : vector<2xi8>
    %3 = llvm.and %1, %2  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def canonicalize_logic_first_and_vector1_before := [llvmfunc|
  llvm.func @canonicalize_logic_first_and_vector1(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[48, 32]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[-10, -4]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %0, %arg0  : vector<2xi8>
    %3 = llvm.and %1, %2  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def canonicalize_logic_first_and_vector2_before := [llvmfunc|
  llvm.func @canonicalize_logic_first_and_vector2(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<612368384> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[-65536, -32768]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %0, %arg0  : vector<2xi32>
    %3 = llvm.and %1, %2  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def canonicalize_logic_first_and_vector3_before := [llvmfunc|
  llvm.func @canonicalize_logic_first_and_vector3(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[32768, 16384]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[-65536, -32768]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %0, %arg0  : vector<2xi32>
    %3 = llvm.and %1, %2  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def canonicalize_logic_first_and_mult_use1_before := [llvmfunc|
  llvm.func @canonicalize_logic_first_and_mult_use1(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(48 : i8) : i8
    %1 = llvm.mlir.constant(-10 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    llvm.call @use_i8(%2) : (i8) -> ()
    %3 = llvm.and %2, %1  : i8
    llvm.return %3 : i8
  }]

def canonicalize_logic_first_and_bad_constraints2_before := [llvmfunc|
  llvm.func @canonicalize_logic_first_and_bad_constraints2(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(48 : i8) : i8
    %1 = llvm.mlir.constant(-26 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.and %2, %1  : i8
    llvm.return %3 : i8
  }]

def canonicalize_logic_first_xor_0_before := [llvmfunc|
  llvm.func @canonicalize_logic_first_xor_0(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(96 : i8) : i8
    %1 = llvm.mlir.constant(31 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }]

def canonicalize_logic_first_xor_0_nsw_before := [llvmfunc|
  llvm.func @canonicalize_logic_first_xor_0_nsw(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(96 : i8) : i8
    %1 = llvm.mlir.constant(31 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }]

def canonicalize_logic_first_xor_0_nswnuw_before := [llvmfunc|
  llvm.func @canonicalize_logic_first_xor_0_nswnuw(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(96 : i8) : i8
    %1 = llvm.mlir.constant(31 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw, nuw>  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }]

def canonicalize_logic_first_xor_vector0_before := [llvmfunc|
  llvm.func @canonicalize_logic_first_xor_vector0(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-8388608> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<32783> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %0, %arg0  : vector<2xi32>
    %3 = llvm.xor %1, %2  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def canonicalize_logic_first_xor_vector0_nsw_before := [llvmfunc|
  llvm.func @canonicalize_logic_first_xor_vector0_nsw(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-8388608> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<32783> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %0, %arg0 overflow<nsw>  : vector<2xi32>
    %3 = llvm.xor %1, %2  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def canonicalize_logic_first_xor_vector0_nswnuw_before := [llvmfunc|
  llvm.func @canonicalize_logic_first_xor_vector0_nswnuw(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-8388608> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<32783> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %0, %arg0 overflow<nsw, nuw>  : vector<2xi32>
    %3 = llvm.xor %1, %2  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def canonicalize_logic_first_xor_vector1_before := [llvmfunc|
  llvm.func @canonicalize_logic_first_xor_vector1(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[-8388608, 2071986176]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[32783, 2063]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %0, %arg0  : vector<2xi32>
    %3 = llvm.xor %1, %2  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def canonicalize_logic_first_xor_vector2_before := [llvmfunc|
  llvm.func @canonicalize_logic_first_xor_vector2(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[2147483632, 2147483640]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[32783, 2063]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %0, %arg0  : vector<2xi32>
    %3 = llvm.xor %1, %2  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def canonicalize_logic_first_xor_mult_use1_before := [llvmfunc|
  llvm.func @canonicalize_logic_first_xor_mult_use1(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(96 : i8) : i8
    %1 = llvm.mlir.constant(31 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    llvm.call @use_i8(%2) : (i8) -> ()
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }]

def canonicalize_logic_first_xor_bad_constants2_before := [llvmfunc|
  llvm.func @canonicalize_logic_first_xor_bad_constants2(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(96 : i8) : i8
    %1 = llvm.mlir.constant(32 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }]

def canonicalize_logic_first_constexpr_before := [llvmfunc|
  llvm.func @canonicalize_logic_first_constexpr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.addressof @g : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i32
    %2 = llvm.mlir.constant(48 : i32) : i32
    %3 = llvm.mlir.constant(-10 : i32) : i32
    %4 = llvm.add %1, %2  : i32
    %5 = llvm.and %4, %3  : i32
    llvm.return %5 : i32
  }]

def canonicalize_logic_first_constexpr_nuw_before := [llvmfunc|
  llvm.func @canonicalize_logic_first_constexpr_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.addressof @g : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i32
    %2 = llvm.mlir.constant(48 : i32) : i32
    %3 = llvm.mlir.constant(-10 : i32) : i32
    %4 = llvm.add %1, %2 overflow<nuw>  : i32
    %5 = llvm.and %4, %3  : i32
    llvm.return %5 : i32
  }]

def test_and_xor_freely_invertable_before := [llvmfunc|
  llvm.func @test_and_xor_freely_invertable(%arg0: i32, %arg1: i32, %arg2: i1) -> i1 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i32
    %1 = llvm.xor %0, %arg2  : i1
    %2 = llvm.and %1, %arg2  : i1
    llvm.return %2 : i1
  }]

def test_and_xor_freely_invertable_multiuse_before := [llvmfunc|
  llvm.func @test_and_xor_freely_invertable_multiuse(%arg0: i32, %arg1: i32, %arg2: i1) -> i1 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i32
    llvm.call @use_i1(%0) : (i1) -> ()
    %1 = llvm.xor %0, %arg2  : i1
    %2 = llvm.and %1, %arg2  : i1
    llvm.return %2 : i1
  }]

def and_xor_common_op_combined := [llvmfunc|
  llvm.func @and_xor_common_op(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(43 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.udiv %0, %arg0  : i32
    %4 = llvm.udiv %1, %arg1  : i32
    %5 = llvm.xor %4, %2  : i32
    %6 = llvm.and %3, %5  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_and_xor_common_op   : and_xor_common_op_before  ⊑  and_xor_common_op_combined := by
  unfold and_xor_common_op_before and_xor_common_op_combined
  simp_alive_peephole
  sorry
def and_xor_common_op_commute1_combined := [llvmfunc|
  llvm.func @and_xor_common_op_commute1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(43 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.udiv %0, %arg0  : i32
    %4 = llvm.udiv %1, %arg1  : i32
    %5 = llvm.xor %4, %2  : i32
    %6 = llvm.and %3, %5  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_and_xor_common_op_commute1   : and_xor_common_op_commute1_before  ⊑  and_xor_common_op_commute1_combined := by
  unfold and_xor_common_op_commute1_before and_xor_common_op_commute1_combined
  simp_alive_peephole
  sorry
def and_xor_common_op_commute2_combined := [llvmfunc|
  llvm.func @and_xor_common_op_commute2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(43 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.udiv %0, %arg0  : i32
    %4 = llvm.udiv %1, %arg1  : i32
    %5 = llvm.xor %4, %2  : i32
    %6 = llvm.and %3, %5  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_and_xor_common_op_commute2   : and_xor_common_op_commute2_before  ⊑  and_xor_common_op_commute2_combined := by
  unfold and_xor_common_op_commute2_before and_xor_common_op_commute2_combined
  simp_alive_peephole
  sorry
def and_xor_common_op_commute3_combined := [llvmfunc|
  llvm.func @and_xor_common_op_commute3(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[42, 43]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[43, 42]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.udiv %0, %arg0  : vector<2xi32>
    %4 = llvm.udiv %1, %arg1  : vector<2xi32>
    %5 = llvm.xor %4, %2  : vector<2xi32>
    %6 = llvm.and %3, %5  : vector<2xi32>
    llvm.return %6 : vector<2xi32>
  }]

theorem inst_combine_and_xor_common_op_commute3   : and_xor_common_op_commute3_before  ⊑  and_xor_common_op_commute3_combined := by
  unfold and_xor_common_op_commute3_before and_xor_common_op_commute3_combined
  simp_alive_peephole
  sorry
def and_xor_common_op_constant_combined := [llvmfunc|
  llvm.func @and_xor_common_op_constant(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.xor %arg0, %0  : vector<4xi32>
    %3 = llvm.and %2, %1  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }]

theorem inst_combine_and_xor_common_op_constant   : and_xor_common_op_constant_before  ⊑  and_xor_common_op_constant_combined := by
  unfold and_xor_common_op_constant_before and_xor_common_op_constant_combined
  simp_alive_peephole
  sorry
def and_xor_not_common_op_combined := [llvmfunc|
  llvm.func @and_xor_not_common_op(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.and %arg0, %arg1  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_and_xor_not_common_op   : and_xor_not_common_op_before  ⊑  and_xor_not_common_op_combined := by
  unfold and_xor_not_common_op_before and_xor_not_common_op_combined
  simp_alive_peephole
  sorry
def and_xor_not_common_op_extrause_combined := [llvmfunc|
  llvm.func @and_xor_not_common_op_extrause(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    llvm.store %1, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_and_xor_not_common_op_extrause   : and_xor_not_common_op_extrause_before  ⊑  and_xor_not_common_op_extrause_combined := by
  unfold and_xor_not_common_op_extrause_before and_xor_not_common_op_extrause_combined
  simp_alive_peephole
  sorry
    %2 = llvm.and %arg0, %arg1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_and_xor_not_common_op_extrause   : and_xor_not_common_op_extrause_before  ⊑  and_xor_not_common_op_extrause_combined := by
  unfold and_xor_not_common_op_extrause_before and_xor_not_common_op_extrause_combined
  simp_alive_peephole
  sorry
def and_not_xor_common_op_combined := [llvmfunc|
  llvm.func @and_not_xor_common_op(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.and %arg0, %arg1  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_and_not_xor_common_op   : and_not_xor_common_op_before  ⊑  and_not_xor_common_op_combined := by
  unfold and_not_xor_common_op_before and_not_xor_common_op_combined
  simp_alive_peephole
  sorry
def and_not_xor_common_op_commutative_combined := [llvmfunc|
  llvm.func @and_not_xor_common_op_commutative(%arg0: i32) -> i32 {
    %0 = llvm.call @gen32() : () -> i32
    %1 = llvm.and %0, %arg0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_and_not_xor_common_op_commutative   : and_not_xor_common_op_commutative_before  ⊑  and_not_xor_common_op_commutative_combined := by
  unfold and_not_xor_common_op_commutative_before and_not_xor_common_op_commutative_combined
  simp_alive_peephole
  sorry
def or_combined := [llvmfunc|
  llvm.func @or(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.or %arg1, %arg0  : i64
    llvm.return %0 : i64
  }]

theorem inst_combine_or   : or_before  ⊑  or_combined := by
  unfold or_before or_combined
  simp_alive_peephole
  sorry
def or2_combined := [llvmfunc|
  llvm.func @or2(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.or %arg1, %arg0  : i64
    llvm.return %0 : i64
  }]

theorem inst_combine_or2   : or2_before  ⊑  or2_combined := by
  unfold or2_before or2_combined
  simp_alive_peephole
  sorry
def and_xor_or1_combined := [llvmfunc|
  llvm.func @and_xor_or1(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(42 : i64) : i64
    %1 = llvm.udiv %0, %arg1  : i64
    %2 = llvm.udiv %0, %arg2  : i64
    %3 = llvm.or %2, %1  : i64
    llvm.return %3 : i64
  }]

theorem inst_combine_and_xor_or1   : and_xor_or1_before  ⊑  and_xor_or1_combined := by
  unfold and_xor_or1_before and_xor_or1_combined
  simp_alive_peephole
  sorry
def and_xor_or2_combined := [llvmfunc|
  llvm.func @and_xor_or2(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(42 : i64) : i64
    %1 = llvm.udiv %0, %arg1  : i64
    %2 = llvm.udiv %0, %arg2  : i64
    %3 = llvm.or %2, %1  : i64
    llvm.return %3 : i64
  }]

theorem inst_combine_and_xor_or2   : and_xor_or2_before  ⊑  and_xor_or2_combined := by
  unfold and_xor_or2_before and_xor_or2_combined
  simp_alive_peephole
  sorry
def and_xor_or3_combined := [llvmfunc|
  llvm.func @and_xor_or3(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(42 : i64) : i64
    %1 = llvm.udiv %0, %arg1  : i64
    %2 = llvm.udiv %0, %arg2  : i64
    %3 = llvm.or %2, %1  : i64
    llvm.return %3 : i64
  }]

theorem inst_combine_and_xor_or3   : and_xor_or3_before  ⊑  and_xor_or3_combined := by
  unfold and_xor_or3_before and_xor_or3_combined
  simp_alive_peephole
  sorry
def and_xor_or4_combined := [llvmfunc|
  llvm.func @and_xor_or4(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(42 : i64) : i64
    %1 = llvm.udiv %0, %arg1  : i64
    %2 = llvm.udiv %0, %arg2  : i64
    %3 = llvm.or %2, %1  : i64
    llvm.return %3 : i64
  }]

theorem inst_combine_and_xor_or4   : and_xor_or4_before  ⊑  and_xor_or4_combined := by
  unfold and_xor_or4_before and_xor_or4_combined
  simp_alive_peephole
  sorry
def and_xor_or5_combined := [llvmfunc|
  llvm.func @and_xor_or5(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(42 : i64) : i64
    %1 = llvm.udiv %0, %arg1  : i64
    %2 = llvm.udiv %0, %arg2  : i64
    %3 = llvm.or %1, %2  : i64
    llvm.return %3 : i64
  }]

theorem inst_combine_and_xor_or5   : and_xor_or5_before  ⊑  and_xor_or5_combined := by
  unfold and_xor_or5_before and_xor_or5_combined
  simp_alive_peephole
  sorry
def and_xor_or6_combined := [llvmfunc|
  llvm.func @and_xor_or6(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(42 : i64) : i64
    %1 = llvm.udiv %0, %arg1  : i64
    %2 = llvm.udiv %0, %arg2  : i64
    %3 = llvm.or %1, %2  : i64
    llvm.return %3 : i64
  }]

theorem inst_combine_and_xor_or6   : and_xor_or6_before  ⊑  and_xor_or6_combined := by
  unfold and_xor_or6_before and_xor_or6_combined
  simp_alive_peephole
  sorry
def and_xor_or7_combined := [llvmfunc|
  llvm.func @and_xor_or7(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(42 : i64) : i64
    %1 = llvm.udiv %0, %arg1  : i64
    %2 = llvm.udiv %0, %arg2  : i64
    %3 = llvm.or %1, %2  : i64
    llvm.return %3 : i64
  }]

theorem inst_combine_and_xor_or7   : and_xor_or7_before  ⊑  and_xor_or7_combined := by
  unfold and_xor_or7_before and_xor_or7_combined
  simp_alive_peephole
  sorry
def and_xor_or8_combined := [llvmfunc|
  llvm.func @and_xor_or8(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(42 : i64) : i64
    %1 = llvm.udiv %0, %arg1  : i64
    %2 = llvm.udiv %0, %arg2  : i64
    %3 = llvm.or %1, %2  : i64
    llvm.return %3 : i64
  }]

theorem inst_combine_and_xor_or8   : and_xor_or8_before  ⊑  and_xor_or8_combined := by
  unfold and_xor_or8_before and_xor_or8_combined
  simp_alive_peephole
  sorry
def and_xor_or_negative_combined := [llvmfunc|
  llvm.func @and_xor_or_negative(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64) -> i64 {
    %0 = llvm.and %arg1, %arg0  : i64
    %1 = llvm.xor %0, %arg2  : i64
    %2 = llvm.or %1, %arg3  : i64
    llvm.return %2 : i64
  }]

theorem inst_combine_and_xor_or_negative   : and_xor_or_negative_before  ⊑  and_xor_or_negative_combined := by
  unfold and_xor_or_negative_before and_xor_or_negative_combined
  simp_alive_peephole
  sorry
def and_shl_combined := [llvmfunc|
  llvm.func @and_shl(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.and %arg0, %arg1  : i8
    %1 = llvm.shl %0, %arg3  : i8
    %2 = llvm.and %1, %arg2  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_and_shl   : and_shl_before  ⊑  and_shl_combined := by
  unfold and_shl_before and_shl_combined
  simp_alive_peephole
  sorry
def or_shl_combined := [llvmfunc|
  llvm.func @or_shl(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.or %arg0, %arg1  : i8
    %1 = llvm.shl %0, %arg3  : i8
    %2 = llvm.or %1, %arg2  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_or_shl   : or_shl_before  ⊑  or_shl_combined := by
  unfold or_shl_before or_shl_combined
  simp_alive_peephole
  sorry
def xor_shl_combined := [llvmfunc|
  llvm.func @xor_shl(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.sdiv %0, %arg2  : i8
    %2 = llvm.shl %arg0, %arg3  : i8
    %3 = llvm.shl %arg1, %arg3  : i8
    %4 = llvm.xor %1, %2  : i8
    %5 = llvm.xor %4, %3  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_xor_shl   : xor_shl_before  ⊑  xor_shl_combined := by
  unfold xor_shl_before xor_shl_combined
  simp_alive_peephole
  sorry
def and_lshr_combined := [llvmfunc|
  llvm.func @and_lshr(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.sdiv %0, %arg2  : i8
    %2 = llvm.lshr %arg0, %arg3  : i8
    %3 = llvm.lshr %arg1, %arg3  : i8
    %4 = llvm.and %1, %2  : i8
    %5 = llvm.and %3, %4  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_and_lshr   : and_lshr_before  ⊑  and_lshr_combined := by
  unfold and_lshr_before and_lshr_combined
  simp_alive_peephole
  sorry
def or_lshr_combined := [llvmfunc|
  llvm.func @or_lshr(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.or %arg0, %arg1  : i8
    %1 = llvm.lshr %0, %arg3  : i8
    %2 = llvm.or %1, %arg2  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_or_lshr   : or_lshr_before  ⊑  or_lshr_combined := by
  unfold or_lshr_before or_lshr_combined
  simp_alive_peephole
  sorry
def xor_lshr_combined := [llvmfunc|
  llvm.func @xor_lshr(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.xor %arg0, %arg1  : i8
    %1 = llvm.lshr %0, %arg3  : i8
    %2 = llvm.xor %1, %arg2  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_xor_lshr   : xor_lshr_before  ⊑  xor_lshr_combined := by
  unfold xor_lshr_before xor_lshr_combined
  simp_alive_peephole
  sorry
def and_ashr_combined := [llvmfunc|
  llvm.func @and_ashr(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.sdiv %0, %arg2  : i8
    %2 = llvm.ashr %arg0, %arg3  : i8
    %3 = llvm.ashr %arg1, %arg3  : i8
    %4 = llvm.and %1, %2  : i8
    %5 = llvm.and %4, %3  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_and_ashr   : and_ashr_before  ⊑  and_ashr_combined := by
  unfold and_ashr_before and_ashr_combined
  simp_alive_peephole
  sorry
def or_ashr_combined := [llvmfunc|
  llvm.func @or_ashr(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.sdiv %0, %arg2  : i8
    %2 = llvm.ashr %arg0, %arg3  : i8
    %3 = llvm.ashr %arg1, %arg3  : i8
    %4 = llvm.or %1, %2  : i8
    %5 = llvm.or %3, %4  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_or_ashr   : or_ashr_before  ⊑  or_ashr_combined := by
  unfold or_ashr_before or_ashr_combined
  simp_alive_peephole
  sorry
def xor_ashr_combined := [llvmfunc|
  llvm.func @xor_ashr(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>, %arg3: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.ashr %arg0, %arg3  : vector<2xi8>
    %1 = llvm.ashr %arg1, %arg3  : vector<2xi8>
    %2 = llvm.xor %0, %arg2  : vector<2xi8>
    %3 = llvm.xor %2, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_xor_ashr   : xor_ashr_before  ⊑  xor_ashr_combined := by
  unfold xor_ashr_before xor_ashr_combined
  simp_alive_peephole
  sorry
def or_and_shl_combined := [llvmfunc|
  llvm.func @or_and_shl(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg3  : i8
    %1 = llvm.shl %arg1, %arg3  : i8
    %2 = llvm.or %0, %arg2  : i8
    %3 = llvm.and %1, %2  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_or_and_shl   : or_and_shl_before  ⊑  or_and_shl_combined := by
  unfold or_and_shl_before or_and_shl_combined
  simp_alive_peephole
  sorry
def or_lshr_shl_combined := [llvmfunc|
  llvm.func @or_lshr_shl(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.lshr %arg0, %arg3  : i8
    %1 = llvm.shl %arg1, %arg3  : i8
    %2 = llvm.or %0, %arg2  : i8
    %3 = llvm.or %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_or_lshr_shl   : or_lshr_shl_before  ⊑  or_lshr_shl_combined := by
  unfold or_lshr_shl_before or_lshr_shl_combined
  simp_alive_peephole
  sorry
def or_lshr_shamt2_combined := [llvmfunc|
  llvm.func @or_lshr_shamt2(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.lshr %arg0, %0  : i8
    %2 = llvm.lshr %arg1, %arg3  : i8
    %3 = llvm.or %1, %arg2  : i8
    %4 = llvm.or %2, %3  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_or_lshr_shamt2   : or_lshr_shamt2_before  ⊑  or_lshr_shamt2_combined := by
  unfold or_lshr_shamt2_before or_lshr_shamt2_combined
  simp_alive_peephole
  sorry
def xor_lshr_multiuse_combined := [llvmfunc|
  llvm.func @xor_lshr_multiuse(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.lshr %arg0, %arg3  : i8
    %1 = llvm.xor %0, %arg2  : i8
    %2 = llvm.xor %arg0, %arg1  : i8
    %3 = llvm.lshr %2, %arg3  : i8
    %4 = llvm.xor %3, %arg2  : i8
    %5 = llvm.sdiv %1, %4  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_xor_lshr_multiuse   : xor_lshr_multiuse_before  ⊑  xor_lshr_multiuse_combined := by
  unfold xor_lshr_multiuse_before xor_lshr_multiuse_combined
  simp_alive_peephole
  sorry
def sext_or_chain_combined := [llvmfunc|
  llvm.func @sext_or_chain(%arg0: i64, %arg1: i16, %arg2: i16) -> i64 {
    %0 = llvm.sext %arg1 : i16 to i64
    %1 = llvm.sext %arg2 : i16 to i64
    %2 = llvm.or %0, %arg0  : i64
    %3 = llvm.or %2, %1  : i64
    llvm.return %3 : i64
  }]

theorem inst_combine_sext_or_chain   : sext_or_chain_before  ⊑  sext_or_chain_combined := by
  unfold sext_or_chain_before sext_or_chain_combined
  simp_alive_peephole
  sorry
def zext_or_chain_combined := [llvmfunc|
  llvm.func @zext_or_chain(%arg0: i64, %arg1: i16, %arg2: i16) -> i64 {
    %0 = llvm.zext %arg1 : i16 to i64
    %1 = llvm.zext %arg2 : i16 to i64
    %2 = llvm.or %0, %arg0  : i64
    %3 = llvm.or %2, %1  : i64
    llvm.return %3 : i64
  }]

theorem inst_combine_zext_or_chain   : zext_or_chain_before  ⊑  zext_or_chain_combined := by
  unfold zext_or_chain_before zext_or_chain_combined
  simp_alive_peephole
  sorry
def sext_and_chain_combined := [llvmfunc|
  llvm.func @sext_and_chain(%arg0: i64, %arg1: i16, %arg2: i16) -> i64 {
    %0 = llvm.sext %arg1 : i16 to i64
    %1 = llvm.sext %arg2 : i16 to i64
    %2 = llvm.and %0, %arg0  : i64
    %3 = llvm.and %2, %1  : i64
    llvm.return %3 : i64
  }]

theorem inst_combine_sext_and_chain   : sext_and_chain_before  ⊑  sext_and_chain_combined := by
  unfold sext_and_chain_before sext_and_chain_combined
  simp_alive_peephole
  sorry
def zext_and_chain_combined := [llvmfunc|
  llvm.func @zext_and_chain(%arg0: i64, %arg1: i16, %arg2: i16) -> i64 {
    %0 = llvm.zext %arg1 : i16 to i64
    %1 = llvm.zext %arg2 : i16 to i64
    %2 = llvm.and %0, %arg0  : i64
    %3 = llvm.and %2, %1  : i64
    llvm.return %3 : i64
  }]

theorem inst_combine_zext_and_chain   : zext_and_chain_before  ⊑  zext_and_chain_combined := by
  unfold zext_and_chain_before zext_and_chain_combined
  simp_alive_peephole
  sorry
def sext_xor_chain_combined := [llvmfunc|
  llvm.func @sext_xor_chain(%arg0: i64, %arg1: i16, %arg2: i16) -> i64 {
    %0 = llvm.sext %arg1 : i16 to i64
    %1 = llvm.sext %arg2 : i16 to i64
    %2 = llvm.xor %0, %arg0  : i64
    %3 = llvm.xor %2, %1  : i64
    llvm.return %3 : i64
  }]

theorem inst_combine_sext_xor_chain   : sext_xor_chain_before  ⊑  sext_xor_chain_combined := by
  unfold sext_xor_chain_before sext_xor_chain_combined
  simp_alive_peephole
  sorry
def zext_xor_chain_combined := [llvmfunc|
  llvm.func @zext_xor_chain(%arg0: i64, %arg1: i16, %arg2: i16) -> i64 {
    %0 = llvm.zext %arg1 : i16 to i64
    %1 = llvm.zext %arg2 : i16 to i64
    %2 = llvm.xor %0, %arg0  : i64
    %3 = llvm.xor %2, %1  : i64
    llvm.return %3 : i64
  }]

theorem inst_combine_zext_xor_chain   : zext_xor_chain_before  ⊑  zext_xor_chain_combined := by
  unfold zext_xor_chain_before zext_xor_chain_combined
  simp_alive_peephole
  sorry
def sext_or_chain_two_uses1_combined := [llvmfunc|
  llvm.func @sext_or_chain_two_uses1(%arg0: i64, %arg1: i16, %arg2: i16, %arg3: i64) -> i64 {
    %0 = llvm.sext %arg1 : i16 to i64
    %1 = llvm.sext %arg2 : i16 to i64
    %2 = llvm.or %0, %arg0  : i64
    %3 = llvm.or %2, %1  : i64
    %4 = llvm.udiv %2, %arg3  : i64
    %5 = llvm.udiv %3, %4  : i64
    llvm.return %5 : i64
  }]

theorem inst_combine_sext_or_chain_two_uses1   : sext_or_chain_two_uses1_before  ⊑  sext_or_chain_two_uses1_combined := by
  unfold sext_or_chain_two_uses1_before sext_or_chain_two_uses1_combined
  simp_alive_peephole
  sorry
def sext_or_chain_two_uses2_combined := [llvmfunc|
  llvm.func @sext_or_chain_two_uses2(%arg0: i64, %arg1: i16, %arg2: i16, %arg3: i64) -> i64 {
    %0 = llvm.sext %arg1 : i16 to i64
    %1 = llvm.sext %arg2 : i16 to i64
    %2 = llvm.or %0, %arg0  : i64
    %3 = llvm.or %2, %1  : i64
    %4 = llvm.udiv %3, %arg3  : i64
    %5 = llvm.udiv %3, %4  : i64
    llvm.return %5 : i64
  }]

theorem inst_combine_sext_or_chain_two_uses2   : sext_or_chain_two_uses2_before  ⊑  sext_or_chain_two_uses2_combined := by
  unfold sext_or_chain_two_uses2_before sext_or_chain_two_uses2_combined
  simp_alive_peephole
  sorry
def not_and_and_not_combined := [llvmfunc|
  llvm.func @not_and_and_not(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg0  : i32
    %3 = llvm.or %arg1, %arg2  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.and %2, %4  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_not_and_and_not   : not_and_and_not_before  ⊑  not_and_and_not_combined := by
  unfold not_and_and_not_before not_and_and_not_combined
  simp_alive_peephole
  sorry
def not_and_and_not_4i64_combined := [llvmfunc|
  llvm.func @not_and_and_not_4i64(%arg0: vector<4xi64>, %arg1: vector<4xi64>, %arg2: vector<4xi64>) -> vector<4xi64> {
    %0 = llvm.mlir.constant(dense<42> : vector<4xi64>) : vector<4xi64>
    %1 = llvm.mlir.constant(dense<-1> : vector<4xi64>) : vector<4xi64>
    %2 = llvm.sdiv %0, %arg0  : vector<4xi64>
    %3 = llvm.or %arg1, %arg2  : vector<4xi64>
    %4 = llvm.xor %3, %1  : vector<4xi64>
    %5 = llvm.and %2, %4  : vector<4xi64>
    llvm.return %5 : vector<4xi64>
  }]

theorem inst_combine_not_and_and_not_4i64   : not_and_and_not_4i64_before  ⊑  not_and_and_not_4i64_combined := by
  unfold not_and_and_not_4i64_before not_and_and_not_4i64_combined
  simp_alive_peephole
  sorry
def not_and_and_not_commute1_combined := [llvmfunc|
  llvm.func @not_and_and_not_commute1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg2  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg0  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_not_and_and_not_commute1   : not_and_and_not_commute1_before  ⊑  not_and_and_not_commute1_combined := by
  unfold not_and_and_not_commute1_before not_and_and_not_commute1_combined
  simp_alive_peephole
  sorry
def not_and_and_not_commute2_extra_not_use_combined := [llvmfunc|
  llvm.func @not_and_and_not_commute2_extra_not_use(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg0  : i32
    %3 = llvm.xor %arg2, %1  : i32
    %4 = llvm.or %arg1, %arg2  : i32
    %5 = llvm.xor %4, %1  : i32
    %6 = llvm.and %2, %5  : i32
    llvm.call @use(%3) : (i32) -> ()
    llvm.return %6 : i32
  }]

theorem inst_combine_not_and_and_not_commute2_extra_not_use   : not_and_and_not_commute2_extra_not_use_before  ⊑  not_and_and_not_commute2_extra_not_use_combined := by
  unfold not_and_and_not_commute2_extra_not_use_before not_and_and_not_commute2_extra_not_use_combined
  simp_alive_peephole
  sorry
def not_and_and_not_extra_and1_use_combined := [llvmfunc|
  llvm.func @not_and_and_not_extra_and1_use(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg0  : i32
    %3 = llvm.xor %arg1, %1  : i32
    %4 = llvm.xor %arg2, %1  : i32
    %5 = llvm.and %2, %3  : i32
    %6 = llvm.and %5, %4  : i32
    llvm.call @use(%5) : (i32) -> ()
    llvm.return %6 : i32
  }]

theorem inst_combine_not_and_and_not_extra_and1_use   : not_and_and_not_extra_and1_use_before  ⊑  not_and_and_not_extra_and1_use_combined := by
  unfold not_and_and_not_extra_and1_use_before not_and_and_not_extra_and1_use_combined
  simp_alive_peephole
  sorry
def not_or_or_not_combined := [llvmfunc|
  llvm.func @not_or_or_not(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg0  : i32
    %3 = llvm.and %arg1, %arg2  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.or %2, %4  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_not_or_or_not   : not_or_or_not_before  ⊑  not_or_or_not_combined := by
  unfold not_or_or_not_before not_or_or_not_combined
  simp_alive_peephole
  sorry
def not_or_or_not_2i6_combined := [llvmfunc|
  llvm.func @not_or_or_not_2i6(%arg0: vector<2xi6>, %arg1: vector<2xi6>, %arg2: vector<2xi6>) -> vector<2xi6> {
    %0 = llvm.mlir.constant(3 : i6) : i6
    %1 = llvm.mlir.constant(dense<3> : vector<2xi6>) : vector<2xi6>
    %2 = llvm.mlir.constant(-1 : i6) : i6
    %3 = llvm.mlir.constant(dense<-1> : vector<2xi6>) : vector<2xi6>
    %4 = llvm.sdiv %1, %arg0  : vector<2xi6>
    %5 = llvm.and %arg1, %arg2  : vector<2xi6>
    %6 = llvm.xor %5, %3  : vector<2xi6>
    %7 = llvm.or %4, %6  : vector<2xi6>
    llvm.return %7 : vector<2xi6>
  }]

theorem inst_combine_not_or_or_not_2i6   : not_or_or_not_2i6_before  ⊑  not_or_or_not_2i6_combined := by
  unfold not_or_or_not_2i6_before not_or_or_not_2i6_combined
  simp_alive_peephole
  sorry
def not_or_or_not_commute1_combined := [llvmfunc|
  llvm.func @not_or_or_not_commute1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg2  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg0  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_not_or_or_not_commute1   : not_or_or_not_commute1_before  ⊑  not_or_or_not_commute1_combined := by
  unfold not_or_or_not_commute1_before not_or_or_not_commute1_combined
  simp_alive_peephole
  sorry
def not_or_or_not_commute2_extra_not_use_combined := [llvmfunc|
  llvm.func @not_or_or_not_commute2_extra_not_use(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg0  : i32
    %3 = llvm.xor %arg2, %1  : i32
    %4 = llvm.and %arg1, %arg2  : i32
    %5 = llvm.xor %4, %1  : i32
    %6 = llvm.or %2, %5  : i32
    llvm.call @use(%3) : (i32) -> ()
    llvm.return %6 : i32
  }]

theorem inst_combine_not_or_or_not_commute2_extra_not_use   : not_or_or_not_commute2_extra_not_use_before  ⊑  not_or_or_not_commute2_extra_not_use_combined := by
  unfold not_or_or_not_commute2_extra_not_use_before not_or_or_not_commute2_extra_not_use_combined
  simp_alive_peephole
  sorry
def not_or_or_not_extra_or1_use_combined := [llvmfunc|
  llvm.func @not_or_or_not_extra_or1_use(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg0  : i32
    %3 = llvm.xor %arg1, %1  : i32
    %4 = llvm.xor %arg2, %1  : i32
    %5 = llvm.or %2, %3  : i32
    %6 = llvm.or %5, %4  : i32
    llvm.call @use(%5) : (i32) -> ()
    llvm.return %6 : i32
  }]

theorem inst_combine_not_or_or_not_extra_or1_use   : not_or_or_not_extra_or1_use_before  ⊑  not_or_or_not_extra_or1_use_combined := by
  unfold not_or_or_not_extra_or1_use_before not_or_or_not_extra_or1_use_combined
  simp_alive_peephole
  sorry
def or_not_and_combined := [llvmfunc|
  llvm.func @or_not_and(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %arg2  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.and %1, %2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_or_not_and   : or_not_and_before  ⊑  or_not_and_combined := by
  unfold or_not_and_before or_not_and_combined
  simp_alive_peephole
  sorry
def or_not_and_commute1_combined := [llvmfunc|
  llvm.func @or_not_and_commute1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg1  : i32
    %3 = llvm.xor %2, %arg2  : i32
    %4 = llvm.xor %arg0, %1  : i32
    %5 = llvm.and %3, %4  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_or_not_and_commute1   : or_not_and_commute1_before  ⊑  or_not_and_commute1_combined := by
  unfold or_not_and_commute1_before or_not_and_commute1_combined
  simp_alive_peephole
  sorry
def or_not_and_commute2_combined := [llvmfunc|
  llvm.func @or_not_and_commute2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg1  : i32
    %3 = llvm.xor %2, %arg2  : i32
    %4 = llvm.xor %arg0, %1  : i32
    %5 = llvm.and %3, %4  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_or_not_and_commute2   : or_not_and_commute2_before  ⊑  or_not_and_commute2_combined := by
  unfold or_not_and_commute2_before or_not_and_commute2_combined
  simp_alive_peephole
  sorry
def or_not_and_commute3_combined := [llvmfunc|
  llvm.func @or_not_and_commute3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %arg2  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.and %1, %2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_or_not_and_commute3   : or_not_and_commute3_before  ⊑  or_not_and_commute3_combined := by
  unfold or_not_and_commute3_before or_not_and_commute3_combined
  simp_alive_peephole
  sorry
def or_not_and_commute4_combined := [llvmfunc|
  llvm.func @or_not_and_commute4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg2  : i32
    %3 = llvm.xor %2, %arg1  : i32
    %4 = llvm.xor %arg0, %1  : i32
    %5 = llvm.and %3, %4  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_or_not_and_commute4   : or_not_and_commute4_before  ⊑  or_not_and_commute4_combined := by
  unfold or_not_and_commute4_before or_not_and_commute4_combined
  simp_alive_peephole
  sorry
def or_not_and_commute5_combined := [llvmfunc|
  llvm.func @or_not_and_commute5(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg0  : i32
    %3 = llvm.sdiv %0, %arg2  : i32
    %4 = llvm.xor %3, %arg1  : i32
    %5 = llvm.xor %2, %1  : i32
    %6 = llvm.and %4, %5  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_or_not_and_commute5   : or_not_and_commute5_before  ⊑  or_not_and_commute5_combined := by
  unfold or_not_and_commute5_before or_not_and_commute5_combined
  simp_alive_peephole
  sorry
def or_not_and_commute6_combined := [llvmfunc|
  llvm.func @or_not_and_commute6(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %arg2  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.and %1, %2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_or_not_and_commute6   : or_not_and_commute6_before  ⊑  or_not_and_commute6_combined := by
  unfold or_not_and_commute6_before or_not_and_commute6_combined
  simp_alive_peephole
  sorry
def or_not_and_commute7_combined := [llvmfunc|
  llvm.func @or_not_and_commute7(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %arg2  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.and %1, %2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_or_not_and_commute7   : or_not_and_commute7_before  ⊑  or_not_and_commute7_combined := by
  unfold or_not_and_commute7_before or_not_and_commute7_combined
  simp_alive_peephole
  sorry
def or_not_and_commute8_combined := [llvmfunc|
  llvm.func @or_not_and_commute8(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg0  : i32
    %3 = llvm.sdiv %0, %arg1  : i32
    %4 = llvm.xor %3, %arg2  : i32
    %5 = llvm.xor %2, %1  : i32
    %6 = llvm.and %4, %5  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_or_not_and_commute8   : or_not_and_commute8_before  ⊑  or_not_and_commute8_combined := by
  unfold or_not_and_commute8_before or_not_and_commute8_combined
  simp_alive_peephole
  sorry
def or_not_and_commute9_combined := [llvmfunc|
  llvm.func @or_not_and_commute9(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg0  : i32
    %3 = llvm.sdiv %0, %arg1  : i32
    %4 = llvm.sdiv %0, %arg2  : i32
    %5 = llvm.xor %3, %4  : i32
    %6 = llvm.xor %2, %1  : i32
    %7 = llvm.and %5, %6  : i32
    llvm.return %7 : i32
  }]

theorem inst_combine_or_not_and_commute9   : or_not_and_commute9_before  ⊑  or_not_and_commute9_combined := by
  unfold or_not_and_commute9_before or_not_and_commute9_combined
  simp_alive_peephole
  sorry
def or_not_and_extra_not_use1_combined := [llvmfunc|
  llvm.func @or_not_and_extra_not_use1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg1, %arg2  : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.and %3, %4  : i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %5 : i32
  }]

theorem inst_combine_or_not_and_extra_not_use1   : or_not_and_extra_not_use1_before  ⊑  or_not_and_extra_not_use1_combined := by
  unfold or_not_and_extra_not_use1_before or_not_and_extra_not_use1_combined
  simp_alive_peephole
  sorry
def or_not_and_extra_not_use2_combined := [llvmfunc|
  llvm.func @or_not_and_extra_not_use2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg2  : i32
    %4 = llvm.or %arg0, %arg2  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.and %5, %arg1  : i32
    %7 = llvm.or %3, %6  : i32
    llvm.call @use(%5) : (i32) -> ()
    llvm.return %7 : i32
  }]

theorem inst_combine_or_not_and_extra_not_use2   : or_not_and_extra_not_use2_before  ⊑  or_not_and_extra_not_use2_combined := by
  unfold or_not_and_extra_not_use2_before or_not_and_extra_not_use2_combined
  simp_alive_peephole
  sorry
def or_not_and_extra_and_use1_combined := [llvmfunc|
  llvm.func @or_not_and_extra_and_use1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg2  : i32
    %4 = llvm.xor %arg1, %arg2  : i32
    %5 = llvm.xor %arg0, %0  : i32
    %6 = llvm.and %4, %5  : i32
    llvm.call @use(%3) : (i32) -> ()
    llvm.return %6 : i32
  }]

theorem inst_combine_or_not_and_extra_and_use1   : or_not_and_extra_and_use1_before  ⊑  or_not_and_extra_and_use1_combined := by
  unfold or_not_and_extra_and_use1_before or_not_and_extra_and_use1_combined
  simp_alive_peephole
  sorry
def or_not_and_extra_and_use2_combined := [llvmfunc|
  llvm.func @or_not_and_extra_and_use2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg2  : i32
    %4 = llvm.or %arg0, %arg2  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.and %5, %arg1  : i32
    %7 = llvm.or %3, %6  : i32
    llvm.call @use(%6) : (i32) -> ()
    llvm.return %7 : i32
  }]

theorem inst_combine_or_not_and_extra_and_use2   : or_not_and_extra_and_use2_before  ⊑  or_not_and_extra_and_use2_combined := by
  unfold or_not_and_extra_and_use2_before or_not_and_extra_and_use2_combined
  simp_alive_peephole
  sorry
def or_not_and_extra_or_use1_combined := [llvmfunc|
  llvm.func @or_not_and_extra_or_use1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.xor %arg1, %arg2  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %4 : i32
  }]

theorem inst_combine_or_not_and_extra_or_use1   : or_not_and_extra_or_use1_before  ⊑  or_not_and_extra_or_use1_combined := by
  unfold or_not_and_extra_or_use1_before or_not_and_extra_or_use1_combined
  simp_alive_peephole
  sorry
def or_not_and_extra_or_use2_combined := [llvmfunc|
  llvm.func @or_not_and_extra_or_use2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg2  : i32
    %2 = llvm.xor %arg1, %arg2  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %4 : i32
  }]

theorem inst_combine_or_not_and_extra_or_use2   : or_not_and_extra_or_use2_before  ⊑  or_not_and_extra_or_use2_combined := by
  unfold or_not_and_extra_or_use2_before or_not_and_extra_or_use2_combined
  simp_alive_peephole
  sorry
def or_not_and_wrong_c_combined := [llvmfunc|
  llvm.func @or_not_and_wrong_c(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg2  : i32
    %4 = llvm.or %arg0, %arg3  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.and %5, %arg1  : i32
    %7 = llvm.or %3, %6  : i32
    llvm.return %7 : i32
  }]

theorem inst_combine_or_not_and_wrong_c   : or_not_and_wrong_c_before  ⊑  or_not_and_wrong_c_combined := by
  unfold or_not_and_wrong_c_before or_not_and_wrong_c_combined
  simp_alive_peephole
  sorry
def or_not_and_wrong_b_combined := [llvmfunc|
  llvm.func @or_not_and_wrong_b(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg2  : i32
    %4 = llvm.or %arg0, %arg2  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.and %5, %arg3  : i32
    %7 = llvm.or %3, %6  : i32
    llvm.return %7 : i32
  }]

theorem inst_combine_or_not_and_wrong_b   : or_not_and_wrong_b_before  ⊑  or_not_and_wrong_b_combined := by
  unfold or_not_and_wrong_b_before or_not_and_wrong_b_combined
  simp_alive_peephole
  sorry
def and_not_or_combined := [llvmfunc|
  llvm.func @and_not_or(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %arg2  : i32
    %2 = llvm.and %1, %arg0  : i32
    %3 = llvm.xor %2, %0  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_and_not_or   : and_not_or_before  ⊑  and_not_or_combined := by
  unfold and_not_or_before and_not_or_combined
  simp_alive_peephole
  sorry
def and_not_or_commute1_combined := [llvmfunc|
  llvm.func @and_not_or_commute1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg1  : i32
    %3 = llvm.xor %2, %arg2  : i32
    %4 = llvm.and %3, %arg0  : i32
    %5 = llvm.xor %4, %1  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_and_not_or_commute1   : and_not_or_commute1_before  ⊑  and_not_or_commute1_combined := by
  unfold and_not_or_commute1_before and_not_or_commute1_combined
  simp_alive_peephole
  sorry
def and_not_or_commute2_combined := [llvmfunc|
  llvm.func @and_not_or_commute2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg1  : i32
    %3 = llvm.xor %2, %arg2  : i32
    %4 = llvm.and %3, %arg0  : i32
    %5 = llvm.xor %4, %1  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_and_not_or_commute2   : and_not_or_commute2_before  ⊑  and_not_or_commute2_combined := by
  unfold and_not_or_commute2_before and_not_or_commute2_combined
  simp_alive_peephole
  sorry
def and_not_or_commute3_combined := [llvmfunc|
  llvm.func @and_not_or_commute3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %arg2  : i32
    %2 = llvm.and %1, %arg0  : i32
    %3 = llvm.xor %2, %0  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_and_not_or_commute3   : and_not_or_commute3_before  ⊑  and_not_or_commute3_combined := by
  unfold and_not_or_commute3_before and_not_or_commute3_combined
  simp_alive_peephole
  sorry
def and_not_or_commute4_combined := [llvmfunc|
  llvm.func @and_not_or_commute4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg2  : i32
    %3 = llvm.xor %2, %arg1  : i32
    %4 = llvm.and %3, %arg0  : i32
    %5 = llvm.xor %4, %1  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_and_not_or_commute4   : and_not_or_commute4_before  ⊑  and_not_or_commute4_combined := by
  unfold and_not_or_commute4_before and_not_or_commute4_combined
  simp_alive_peephole
  sorry
def and_not_or_commute5_combined := [llvmfunc|
  llvm.func @and_not_or_commute5(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg0  : i32
    %3 = llvm.sdiv %0, %arg2  : i32
    %4 = llvm.xor %3, %arg1  : i32
    %5 = llvm.and %4, %2  : i32
    %6 = llvm.xor %5, %1  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_and_not_or_commute5   : and_not_or_commute5_before  ⊑  and_not_or_commute5_combined := by
  unfold and_not_or_commute5_before and_not_or_commute5_combined
  simp_alive_peephole
  sorry
def and_not_or_commute6_combined := [llvmfunc|
  llvm.func @and_not_or_commute6(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %arg2  : i32
    %2 = llvm.and %1, %arg0  : i32
    %3 = llvm.xor %2, %0  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_and_not_or_commute6   : and_not_or_commute6_before  ⊑  and_not_or_commute6_combined := by
  unfold and_not_or_commute6_before and_not_or_commute6_combined
  simp_alive_peephole
  sorry
def and_not_or_commute7_combined := [llvmfunc|
  llvm.func @and_not_or_commute7(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %arg2  : i32
    %2 = llvm.and %1, %arg0  : i32
    %3 = llvm.xor %2, %0  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_and_not_or_commute7   : and_not_or_commute7_before  ⊑  and_not_or_commute7_combined := by
  unfold and_not_or_commute7_before and_not_or_commute7_combined
  simp_alive_peephole
  sorry
def and_not_or_commute8_combined := [llvmfunc|
  llvm.func @and_not_or_commute8(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg0  : i32
    %3 = llvm.sdiv %0, %arg1  : i32
    %4 = llvm.xor %3, %arg2  : i32
    %5 = llvm.and %4, %2  : i32
    %6 = llvm.xor %5, %1  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_and_not_or_commute8   : and_not_or_commute8_before  ⊑  and_not_or_commute8_combined := by
  unfold and_not_or_commute8_before and_not_or_commute8_combined
  simp_alive_peephole
  sorry
def and_not_or_commute9_combined := [llvmfunc|
  llvm.func @and_not_or_commute9(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg0  : i32
    %3 = llvm.sdiv %0, %arg1  : i32
    %4 = llvm.sdiv %0, %arg2  : i32
    %5 = llvm.xor %3, %4  : i32
    %6 = llvm.and %5, %2  : i32
    %7 = llvm.xor %6, %1  : i32
    llvm.return %7 : i32
  }]

theorem inst_combine_and_not_or_commute9   : and_not_or_commute9_before  ⊑  and_not_or_commute9_combined := by
  unfold and_not_or_commute9_before and_not_or_commute9_combined
  simp_alive_peephole
  sorry
def and_not_or_extra_not_use1_combined := [llvmfunc|
  llvm.func @and_not_or_extra_not_use1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg1, %arg2  : i32
    %4 = llvm.and %3, %arg0  : i32
    %5 = llvm.xor %4, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %5 : i32
  }]

theorem inst_combine_and_not_or_extra_not_use1   : and_not_or_extra_not_use1_before  ⊑  and_not_or_extra_not_use1_combined := by
  unfold and_not_or_extra_not_use1_before and_not_or_extra_not_use1_combined
  simp_alive_peephole
  sorry
def and_not_or_extra_not_use2_combined := [llvmfunc|
  llvm.func @and_not_or_extra_not_use2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg2  : i32
    %4 = llvm.and %arg0, %arg2  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.or %5, %arg1  : i32
    %7 = llvm.and %3, %6  : i32
    llvm.call @use(%5) : (i32) -> ()
    llvm.return %7 : i32
  }]

theorem inst_combine_and_not_or_extra_not_use2   : and_not_or_extra_not_use2_before  ⊑  and_not_or_extra_not_use2_combined := by
  unfold and_not_or_extra_not_use2_before and_not_or_extra_not_use2_combined
  simp_alive_peephole
  sorry
def and_not_or_extra_and_use1_combined := [llvmfunc|
  llvm.func @and_not_or_extra_and_use1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg2  : i32
    %4 = llvm.xor %arg1, %arg2  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.xor %5, %0  : i32
    llvm.call @use(%3) : (i32) -> ()
    llvm.return %6 : i32
  }]

theorem inst_combine_and_not_or_extra_and_use1   : and_not_or_extra_and_use1_before  ⊑  and_not_or_extra_and_use1_combined := by
  unfold and_not_or_extra_and_use1_before and_not_or_extra_and_use1_combined
  simp_alive_peephole
  sorry
def and_not_or_extra_and_use2_combined := [llvmfunc|
  llvm.func @and_not_or_extra_and_use2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg2  : i32
    %4 = llvm.and %arg0, %arg2  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.or %5, %arg1  : i32
    %7 = llvm.and %3, %6  : i32
    llvm.call @use(%6) : (i32) -> ()
    llvm.return %7 : i32
  }]

theorem inst_combine_and_not_or_extra_and_use2   : and_not_or_extra_and_use2_before  ⊑  and_not_or_extra_and_use2_combined := by
  unfold and_not_or_extra_and_use2_before and_not_or_extra_and_use2_combined
  simp_alive_peephole
  sorry
def and_not_or_extra_or_use1_combined := [llvmfunc|
  llvm.func @and_not_or_extra_or_use1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.xor %arg1, %arg2  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.xor %3, %0  : i32
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %4 : i32
  }]

theorem inst_combine_and_not_or_extra_or_use1   : and_not_or_extra_or_use1_before  ⊑  and_not_or_extra_or_use1_combined := by
  unfold and_not_or_extra_or_use1_before and_not_or_extra_or_use1_combined
  simp_alive_peephole
  sorry
def and_not_or_extra_or_use2_combined := [llvmfunc|
  llvm.func @and_not_or_extra_or_use2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg2  : i32
    %2 = llvm.xor %arg1, %arg2  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.xor %3, %0  : i32
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %4 : i32
  }]

theorem inst_combine_and_not_or_extra_or_use2   : and_not_or_extra_or_use2_before  ⊑  and_not_or_extra_or_use2_combined := by
  unfold and_not_or_extra_or_use2_before and_not_or_extra_or_use2_combined
  simp_alive_peephole
  sorry
def and_not_or_wrong_c_combined := [llvmfunc|
  llvm.func @and_not_or_wrong_c(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg2  : i32
    %4 = llvm.and %arg0, %arg3  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.or %5, %arg1  : i32
    %7 = llvm.and %3, %6  : i32
    llvm.return %7 : i32
  }]

theorem inst_combine_and_not_or_wrong_c   : and_not_or_wrong_c_before  ⊑  and_not_or_wrong_c_combined := by
  unfold and_not_or_wrong_c_before and_not_or_wrong_c_combined
  simp_alive_peephole
  sorry
def and_not_or_wrong_b_combined := [llvmfunc|
  llvm.func @and_not_or_wrong_b(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg2  : i32
    %4 = llvm.and %arg0, %arg2  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.or %5, %arg3  : i32
    %7 = llvm.and %3, %6  : i32
    llvm.return %7 : i32
  }]

theorem inst_combine_and_not_or_wrong_b   : and_not_or_wrong_b_before  ⊑  and_not_or_wrong_b_combined := by
  unfold and_not_or_wrong_b_before and_not_or_wrong_b_combined
  simp_alive_peephole
  sorry
def or_and_not_not_combined := [llvmfunc|
  llvm.func @or_and_not_not(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg2, %arg1  : i32
    %2 = llvm.or %1, %arg0  : i32
    %3 = llvm.xor %2, %0  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_or_and_not_not   : or_and_not_not_before  ⊑  or_and_not_not_combined := by
  unfold or_and_not_not_before or_and_not_not_combined
  simp_alive_peephole
  sorry
def or_and_not_not_commute1_combined := [llvmfunc|
  llvm.func @or_and_not_not_commute1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg1  : i32
    %3 = llvm.and %2, %arg2  : i32
    %4 = llvm.or %3, %arg0  : i32
    %5 = llvm.xor %4, %1  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_or_and_not_not_commute1   : or_and_not_not_commute1_before  ⊑  or_and_not_not_commute1_combined := by
  unfold or_and_not_not_commute1_before or_and_not_not_commute1_combined
  simp_alive_peephole
  sorry
def or_and_not_not_commute2_combined := [llvmfunc|
  llvm.func @or_and_not_not_commute2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg2, %arg1  : i32
    %2 = llvm.or %1, %arg0  : i32
    %3 = llvm.xor %2, %0  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_or_and_not_not_commute2   : or_and_not_not_commute2_before  ⊑  or_and_not_not_commute2_combined := by
  unfold or_and_not_not_commute2_before or_and_not_not_commute2_combined
  simp_alive_peephole
  sorry
def or_and_not_not_commute3_combined := [llvmfunc|
  llvm.func @or_and_not_not_commute3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg2, %arg1  : i32
    %2 = llvm.or %1, %arg0  : i32
    %3 = llvm.xor %2, %0  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_or_and_not_not_commute3   : or_and_not_not_commute3_before  ⊑  or_and_not_not_commute3_combined := by
  unfold or_and_not_not_commute3_before or_and_not_not_commute3_combined
  simp_alive_peephole
  sorry
def or_and_not_not_commute4_combined := [llvmfunc|
  llvm.func @or_and_not_not_commute4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg2, %arg1  : i32
    %2 = llvm.or %1, %arg0  : i32
    %3 = llvm.xor %2, %0  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_or_and_not_not_commute4   : or_and_not_not_commute4_before  ⊑  or_and_not_not_commute4_combined := by
  unfold or_and_not_not_commute4_before or_and_not_not_commute4_combined
  simp_alive_peephole
  sorry
def or_and_not_not_commute5_combined := [llvmfunc|
  llvm.func @or_and_not_not_commute5(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg2, %arg1  : i32
    %2 = llvm.or %1, %arg0  : i32
    %3 = llvm.xor %2, %0  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_or_and_not_not_commute5   : or_and_not_not_commute5_before  ⊑  or_and_not_not_commute5_combined := by
  unfold or_and_not_not_commute5_before or_and_not_not_commute5_combined
  simp_alive_peephole
  sorry
def or_and_not_not_commute6_combined := [llvmfunc|
  llvm.func @or_and_not_not_commute6(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg1  : i32
    %3 = llvm.and %2, %arg2  : i32
    %4 = llvm.or %3, %arg0  : i32
    %5 = llvm.xor %4, %1  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_or_and_not_not_commute6   : or_and_not_not_commute6_before  ⊑  or_and_not_not_commute6_combined := by
  unfold or_and_not_not_commute6_before or_and_not_not_commute6_combined
  simp_alive_peephole
  sorry
def or_and_not_not_commute7_combined := [llvmfunc|
  llvm.func @or_and_not_not_commute7(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg2, %arg1  : i32
    %2 = llvm.or %1, %arg0  : i32
    %3 = llvm.xor %2, %0  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_or_and_not_not_commute7   : or_and_not_not_commute7_before  ⊑  or_and_not_not_commute7_combined := by
  unfold or_and_not_not_commute7_before or_and_not_not_commute7_combined
  simp_alive_peephole
  sorry
def or_and_not_not_extra_not_use1_combined := [llvmfunc|
  llvm.func @or_and_not_not_extra_not_use1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %arg0, %arg2  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %6 : i32
  }]

theorem inst_combine_or_and_not_not_extra_not_use1   : or_and_not_not_extra_not_use1_before  ⊑  or_and_not_not_extra_not_use1_combined := by
  unfold or_and_not_not_extra_not_use1_before or_and_not_not_extra_not_use1_combined
  simp_alive_peephole
  sorry
def or_and_not_not_extra_not_use2_combined := [llvmfunc|
  llvm.func @or_and_not_not_extra_not_use2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg2  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %arg2, %arg1  : i32
    %4 = llvm.or %3, %arg0  : i32
    %5 = llvm.xor %4, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %5 : i32
  }]

theorem inst_combine_or_and_not_not_extra_not_use2   : or_and_not_not_extra_not_use2_before  ⊑  or_and_not_not_extra_not_use2_combined := by
  unfold or_and_not_not_extra_not_use2_before or_and_not_not_extra_not_use2_combined
  simp_alive_peephole
  sorry
def or_and_not_not_extra_and_use_combined := [llvmfunc|
  llvm.func @or_and_not_not_extra_and_use(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg2  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg1  : i32
    %4 = llvm.and %arg2, %arg1  : i32
    %5 = llvm.or %4, %arg0  : i32
    %6 = llvm.xor %5, %0  : i32
    llvm.call @use(%3) : (i32) -> ()
    llvm.return %6 : i32
  }]

theorem inst_combine_or_and_not_not_extra_and_use   : or_and_not_not_extra_and_use_before  ⊑  or_and_not_not_extra_and_use_combined := by
  unfold or_and_not_not_extra_and_use_before or_and_not_not_extra_and_use_combined
  simp_alive_peephole
  sorry
def or_and_not_not_extra_or_use1_combined := [llvmfunc|
  llvm.func @or_and_not_not_extra_or_use1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %arg0, %arg2  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %6 : i32
  }]

theorem inst_combine_or_and_not_not_extra_or_use1   : or_and_not_not_extra_or_use1_before  ⊑  or_and_not_not_extra_or_use1_combined := by
  unfold or_and_not_not_extra_or_use1_before or_and_not_not_extra_or_use1_combined
  simp_alive_peephole
  sorry
def or_and_not_not_extra_or_use2_combined := [llvmfunc|
  llvm.func @or_and_not_not_extra_or_use2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg2  : i32
    %2 = llvm.and %arg2, %arg1  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.xor %3, %0  : i32
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %4 : i32
  }]

theorem inst_combine_or_and_not_not_extra_or_use2   : or_and_not_not_extra_or_use2_before  ⊑  or_and_not_not_extra_or_use2_combined := by
  unfold or_and_not_not_extra_or_use2_before or_and_not_not_extra_or_use2_combined
  simp_alive_peephole
  sorry
def or_and_not_not_2_extra_uses_combined := [llvmfunc|
  llvm.func @or_and_not_not_2_extra_uses(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %arg0, %arg2  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.and %4, %arg1  : i32
    llvm.call @use(%5) : (i32) -> ()
    %6 = llvm.or %5, %2  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_or_and_not_not_2_extra_uses   : or_and_not_not_2_extra_uses_before  ⊑  or_and_not_not_2_extra_uses_combined := by
  unfold or_and_not_not_2_extra_uses_before or_and_not_not_2_extra_uses_combined
  simp_alive_peephole
  sorry
def or_and_not_not_wrong_a_combined := [llvmfunc|
  llvm.func @or_and_not_not_wrong_a(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg3  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %arg0, %arg2  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_or_and_not_not_wrong_a   : or_and_not_not_wrong_a_before  ⊑  or_and_not_not_wrong_a_combined := by
  unfold or_and_not_not_wrong_a_before or_and_not_not_wrong_a_combined
  simp_alive_peephole
  sorry
def or_and_not_not_wrong_b_combined := [llvmfunc|
  llvm.func @or_and_not_not_wrong_b(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg3, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %arg0, %arg2  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_or_and_not_not_wrong_b   : or_and_not_not_wrong_b_before  ⊑  or_and_not_not_wrong_b_combined := by
  unfold or_and_not_not_wrong_b_before or_and_not_not_wrong_b_combined
  simp_alive_peephole
  sorry
def and_or_not_not_combined := [llvmfunc|
  llvm.func @and_or_not_not(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg2, %arg1  : i32
    %2 = llvm.and %1, %arg0  : i32
    %3 = llvm.xor %2, %0  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_and_or_not_not   : and_or_not_not_before  ⊑  and_or_not_not_combined := by
  unfold and_or_not_not_before and_or_not_not_combined
  simp_alive_peephole
  sorry
def and_or_not_not_commute1_combined := [llvmfunc|
  llvm.func @and_or_not_not_commute1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg1  : i32
    %3 = llvm.or %2, %arg2  : i32
    %4 = llvm.and %3, %arg0  : i32
    %5 = llvm.xor %4, %1  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_and_or_not_not_commute1   : and_or_not_not_commute1_before  ⊑  and_or_not_not_commute1_combined := by
  unfold and_or_not_not_commute1_before and_or_not_not_commute1_combined
  simp_alive_peephole
  sorry
def and_or_not_not_commute2_combined := [llvmfunc|
  llvm.func @and_or_not_not_commute2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg2, %arg1  : i32
    %2 = llvm.and %1, %arg0  : i32
    %3 = llvm.xor %2, %0  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_and_or_not_not_commute2   : and_or_not_not_commute2_before  ⊑  and_or_not_not_commute2_combined := by
  unfold and_or_not_not_commute2_before and_or_not_not_commute2_combined
  simp_alive_peephole
  sorry
def and_or_not_not_commute3_combined := [llvmfunc|
  llvm.func @and_or_not_not_commute3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg2, %arg1  : i32
    %2 = llvm.and %1, %arg0  : i32
    %3 = llvm.xor %2, %0  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_and_or_not_not_commute3   : and_or_not_not_commute3_before  ⊑  and_or_not_not_commute3_combined := by
  unfold and_or_not_not_commute3_before and_or_not_not_commute3_combined
  simp_alive_peephole
  sorry
def and_or_not_not_commute4_combined := [llvmfunc|
  llvm.func @and_or_not_not_commute4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg2, %arg1  : i32
    %2 = llvm.and %1, %arg0  : i32
    %3 = llvm.xor %2, %0  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_and_or_not_not_commute4   : and_or_not_not_commute4_before  ⊑  and_or_not_not_commute4_combined := by
  unfold and_or_not_not_commute4_before and_or_not_not_commute4_combined
  simp_alive_peephole
  sorry
def and_or_not_not_commute5_combined := [llvmfunc|
  llvm.func @and_or_not_not_commute5(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg2, %arg1  : i32
    %2 = llvm.and %1, %arg0  : i32
    %3 = llvm.xor %2, %0  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_and_or_not_not_commute5   : and_or_not_not_commute5_before  ⊑  and_or_not_not_commute5_combined := by
  unfold and_or_not_not_commute5_before and_or_not_not_commute5_combined
  simp_alive_peephole
  sorry
def and_or_not_not_commute6_combined := [llvmfunc|
  llvm.func @and_or_not_not_commute6(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg1  : i32
    %3 = llvm.or %2, %arg2  : i32
    %4 = llvm.and %3, %arg0  : i32
    %5 = llvm.xor %4, %1  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_and_or_not_not_commute6   : and_or_not_not_commute6_before  ⊑  and_or_not_not_commute6_combined := by
  unfold and_or_not_not_commute6_before and_or_not_not_commute6_combined
  simp_alive_peephole
  sorry
def and_or_not_not_commute7_combined := [llvmfunc|
  llvm.func @and_or_not_not_commute7(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg2, %arg1  : i32
    %2 = llvm.and %1, %arg0  : i32
    %3 = llvm.xor %2, %0  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_and_or_not_not_commute7   : and_or_not_not_commute7_before  ⊑  and_or_not_not_commute7_combined := by
  unfold and_or_not_not_commute7_before and_or_not_not_commute7_combined
  simp_alive_peephole
  sorry
def and_or_not_not_extra_not_use1_combined := [llvmfunc|
  llvm.func @and_or_not_not_extra_not_use1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %arg0, %arg2  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.xor %1, %5  : i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %6 : i32
  }]

theorem inst_combine_and_or_not_not_extra_not_use1   : and_or_not_not_extra_not_use1_before  ⊑  and_or_not_not_extra_not_use1_combined := by
  unfold and_or_not_not_extra_not_use1_before and_or_not_not_extra_not_use1_combined
  simp_alive_peephole
  sorry
def and_or_not_not_extra_not_use2_combined := [llvmfunc|
  llvm.func @and_or_not_not_extra_not_use2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg2  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %arg2, %arg1  : i32
    %4 = llvm.and %3, %arg0  : i32
    %5 = llvm.xor %4, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %5 : i32
  }]

theorem inst_combine_and_or_not_not_extra_not_use2   : and_or_not_not_extra_not_use2_before  ⊑  and_or_not_not_extra_not_use2_combined := by
  unfold and_or_not_not_extra_not_use2_before and_or_not_not_extra_not_use2_combined
  simp_alive_peephole
  sorry
def and_or_not_not_extra_and_use_combined := [llvmfunc|
  llvm.func @and_or_not_not_extra_and_use(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg2  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg1  : i32
    %4 = llvm.or %arg2, %arg1  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.xor %5, %0  : i32
    llvm.call @use(%3) : (i32) -> ()
    llvm.return %6 : i32
  }]

theorem inst_combine_and_or_not_not_extra_and_use   : and_or_not_not_extra_and_use_before  ⊑  and_or_not_not_extra_and_use_combined := by
  unfold and_or_not_not_extra_and_use_before and_or_not_not_extra_and_use_combined
  simp_alive_peephole
  sorry
def and_or_not_not_extra_or_use1_combined := [llvmfunc|
  llvm.func @and_or_not_not_extra_or_use1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.and %arg0, %arg2  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.or %3, %arg1  : i32
    %5 = llvm.xor %1, %4  : i32
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %5 : i32
  }]

theorem inst_combine_and_or_not_not_extra_or_use1   : and_or_not_not_extra_or_use1_before  ⊑  and_or_not_not_extra_or_use1_combined := by
  unfold and_or_not_not_extra_or_use1_before and_or_not_not_extra_or_use1_combined
  simp_alive_peephole
  sorry
def and_or_not_not_extra_or_use2_combined := [llvmfunc|
  llvm.func @and_or_not_not_extra_or_use2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg2  : i32
    %2 = llvm.or %arg2, %arg1  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.xor %3, %0  : i32
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %4 : i32
  }]

theorem inst_combine_and_or_not_not_extra_or_use2   : and_or_not_not_extra_or_use2_before  ⊑  and_or_not_not_extra_or_use2_combined := by
  unfold and_or_not_not_extra_or_use2_before and_or_not_not_extra_or_use2_combined
  simp_alive_peephole
  sorry
def and_or_not_not_2_extra_uses_combined := [llvmfunc|
  llvm.func @and_or_not_not_2_extra_uses(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.and %arg0, %arg2  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.or %3, %arg1  : i32
    llvm.call @use(%4) : (i32) -> ()
    %5 = llvm.xor %1, %4  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_and_or_not_not_2_extra_uses   : and_or_not_not_2_extra_uses_before  ⊑  and_or_not_not_2_extra_uses_combined := by
  unfold and_or_not_not_2_extra_uses_before and_or_not_not_2_extra_uses_combined
  simp_alive_peephole
  sorry
def and_or_not_not_wrong_a_combined := [llvmfunc|
  llvm.func @and_or_not_not_wrong_a(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg3  : i32
    %2 = llvm.and %arg0, %arg2  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.or %3, %arg1  : i32
    %5 = llvm.xor %1, %4  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_and_or_not_not_wrong_a   : and_or_not_not_wrong_a_before  ⊑  and_or_not_not_wrong_a_combined := by
  unfold and_or_not_not_wrong_a_before and_or_not_not_wrong_a_combined
  simp_alive_peephole
  sorry
def and_or_not_not_wrong_b_combined := [llvmfunc|
  llvm.func @and_or_not_not_wrong_b(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg3, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %arg0, %arg2  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.and %5, %2  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_and_or_not_not_wrong_b   : and_or_not_not_wrong_b_before  ⊑  and_or_not_not_wrong_b_combined := by
  unfold and_or_not_not_wrong_b_before and_or_not_not_wrong_b_combined
  simp_alive_peephole
  sorry
def and_not_or_or_not_or_xor_combined := [llvmfunc|
  llvm.func @and_not_or_or_not_or_xor(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg2  : i32
    %2 = llvm.xor %arg1, %arg2  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.and %1, %3  : i32
    %5 = llvm.xor %4, %0  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_and_not_or_or_not_or_xor   : and_not_or_or_not_or_xor_before  ⊑  and_not_or_or_not_or_xor_combined := by
  unfold and_not_or_or_not_or_xor_before and_not_or_or_not_or_xor_combined
  simp_alive_peephole
  sorry
def and_not_or_or_not_or_xor_commute1_combined := [llvmfunc|
  llvm.func @and_not_or_or_not_or_xor_commute1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg2, %arg1  : i32
    %2 = llvm.xor %arg1, %arg2  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.and %1, %3  : i32
    %5 = llvm.xor %4, %0  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_and_not_or_or_not_or_xor_commute1   : and_not_or_or_not_or_xor_commute1_before  ⊑  and_not_or_or_not_or_xor_commute1_combined := by
  unfold and_not_or_or_not_or_xor_commute1_before and_not_or_or_not_or_xor_commute1_combined
  simp_alive_peephole
  sorry
def and_not_or_or_not_or_xor_commute2_combined := [llvmfunc|
  llvm.func @and_not_or_or_not_or_xor_commute2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg0  : i32
    %3 = llvm.or %arg1, %arg2  : i32
    %4 = llvm.xor %arg1, %arg2  : i32
    %5 = llvm.or %4, %2  : i32
    %6 = llvm.and %3, %5  : i32
    %7 = llvm.xor %6, %1  : i32
    llvm.return %7 : i32
  }]

theorem inst_combine_and_not_or_or_not_or_xor_commute2   : and_not_or_or_not_or_xor_commute2_before  ⊑  and_not_or_or_not_or_xor_commute2_combined := by
  unfold and_not_or_or_not_or_xor_commute2_before and_not_or_or_not_or_xor_commute2_combined
  simp_alive_peephole
  sorry
def and_not_or_or_not_or_xor_commute3_combined := [llvmfunc|
  llvm.func @and_not_or_or_not_or_xor_commute3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg2  : i32
    %2 = llvm.xor %arg2, %arg1  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.and %1, %3  : i32
    %5 = llvm.xor %4, %0  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_and_not_or_or_not_or_xor_commute3   : and_not_or_or_not_or_xor_commute3_before  ⊑  and_not_or_or_not_or_xor_commute3_combined := by
  unfold and_not_or_or_not_or_xor_commute3_before and_not_or_or_not_or_xor_commute3_combined
  simp_alive_peephole
  sorry
def and_not_or_or_not_or_xor_commute4_combined := [llvmfunc|
  llvm.func @and_not_or_or_not_or_xor_commute4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg0  : i32
    %3 = llvm.or %arg1, %arg2  : i32
    %4 = llvm.xor %arg1, %arg2  : i32
    %5 = llvm.or %2, %4  : i32
    %6 = llvm.and %3, %5  : i32
    %7 = llvm.xor %6, %1  : i32
    llvm.return %7 : i32
  }]

theorem inst_combine_and_not_or_or_not_or_xor_commute4   : and_not_or_or_not_or_xor_commute4_before  ⊑  and_not_or_or_not_or_xor_commute4_combined := by
  unfold and_not_or_or_not_or_xor_commute4_before and_not_or_or_not_or_xor_commute4_combined
  simp_alive_peephole
  sorry
def and_not_or_or_not_or_xor_commute5_combined := [llvmfunc|
  llvm.func @and_not_or_or_not_or_xor_commute5(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg2  : i32
    %2 = llvm.xor %arg1, %arg2  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.and %1, %3  : i32
    %5 = llvm.xor %4, %0  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_and_not_or_or_not_or_xor_commute5   : and_not_or_or_not_or_xor_commute5_before  ⊑  and_not_or_or_not_or_xor_commute5_combined := by
  unfold and_not_or_or_not_or_xor_commute5_before and_not_or_or_not_or_xor_commute5_combined
  simp_alive_peephole
  sorry
def and_not_or_or_not_or_xor_use1_combined := [llvmfunc|
  llvm.func @and_not_or_or_not_or_xor_use1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg2  : i32
    %2 = llvm.xor %arg1, %arg2  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.and %1, %3  : i32
    %5 = llvm.xor %4, %0  : i32
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %5 : i32
  }]

theorem inst_combine_and_not_or_or_not_or_xor_use1   : and_not_or_or_not_or_xor_use1_before  ⊑  and_not_or_or_not_or_xor_use1_combined := by
  unfold and_not_or_or_not_or_xor_use1_before and_not_or_or_not_or_xor_use1_combined
  simp_alive_peephole
  sorry
def and_not_or_or_not_or_xor_use2_combined := [llvmfunc|
  llvm.func @and_not_or_or_not_or_xor_use2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg2  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg1, %arg2  : i32
    %4 = llvm.or %3, %arg0  : i32
    %5 = llvm.and %1, %4  : i32
    %6 = llvm.xor %5, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %6 : i32
  }]

theorem inst_combine_and_not_or_or_not_or_xor_use2   : and_not_or_or_not_or_xor_use2_before  ⊑  and_not_or_or_not_or_xor_use2_combined := by
  unfold and_not_or_or_not_or_xor_use2_before and_not_or_or_not_or_xor_use2_combined
  simp_alive_peephole
  sorry
def and_not_or_or_not_or_xor_use3_combined := [llvmfunc|
  llvm.func @and_not_or_or_not_or_xor_use3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg2  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.xor %arg1, %arg2  : i32
    %5 = llvm.or %4, %arg0  : i32
    %6 = llvm.xor %5, %0  : i32
    %7 = llvm.or %3, %6  : i32
    llvm.call @use(%3) : (i32) -> ()
    llvm.return %7 : i32
  }]

theorem inst_combine_and_not_or_or_not_or_xor_use3   : and_not_or_or_not_or_xor_use3_before  ⊑  and_not_or_or_not_or_xor_use3_combined := by
  unfold and_not_or_or_not_or_xor_use3_before and_not_or_or_not_or_xor_use3_combined
  simp_alive_peephole
  sorry
def and_not_or_or_not_or_xor_use4_combined := [llvmfunc|
  llvm.func @and_not_or_or_not_or_xor_use4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg2  : i32
    %2 = llvm.xor %arg1, %arg2  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.and %1, %3  : i32
    %5 = llvm.xor %4, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %5 : i32
  }]

theorem inst_combine_and_not_or_or_not_or_xor_use4   : and_not_or_or_not_or_xor_use4_before  ⊑  and_not_or_or_not_or_xor_use4_combined := by
  unfold and_not_or_or_not_or_xor_use4_before and_not_or_or_not_or_xor_use4_combined
  simp_alive_peephole
  sorry
def and_not_or_or_not_or_xor_use5_combined := [llvmfunc|
  llvm.func @and_not_or_or_not_or_xor_use5(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg2  : i32
    %2 = llvm.xor %arg1, %arg2  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.and %1, %3  : i32
    %5 = llvm.xor %4, %0  : i32
    llvm.call @use(%3) : (i32) -> ()
    llvm.return %5 : i32
  }]

theorem inst_combine_and_not_or_or_not_or_xor_use5   : and_not_or_or_not_or_xor_use5_before  ⊑  and_not_or_or_not_or_xor_use5_combined := by
  unfold and_not_or_or_not_or_xor_use5_before and_not_or_or_not_or_xor_use5_combined
  simp_alive_peephole
  sorry
def and_not_or_or_not_or_xor_use6_combined := [llvmfunc|
  llvm.func @and_not_or_or_not_or_xor_use6(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg2  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.xor %arg1, %arg2  : i32
    %5 = llvm.or %4, %arg0  : i32
    %6 = llvm.xor %5, %0  : i32
    %7 = llvm.or %3, %6  : i32
    llvm.call @use(%6) : (i32) -> ()
    llvm.return %7 : i32
  }]

theorem inst_combine_and_not_or_or_not_or_xor_use6   : and_not_or_or_not_or_xor_use6_before  ⊑  and_not_or_or_not_or_xor_use6_combined := by
  unfold and_not_or_or_not_or_xor_use6_before and_not_or_or_not_or_xor_use6_combined
  simp_alive_peephole
  sorry
def or_not_and_and_not_and_xor_combined := [llvmfunc|
  llvm.func @or_not_and_and_not_and_xor(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg2  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.xor %arg1, %arg2  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.xor %5, %3  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_or_not_and_and_not_and_xor   : or_not_and_and_not_and_xor_before  ⊑  or_not_and_and_not_and_xor_combined := by
  unfold or_not_and_and_not_and_xor_before or_not_and_and_not_and_xor_combined
  simp_alive_peephole
  sorry
def or_not_and_and_not_and_xor_commute1_combined := [llvmfunc|
  llvm.func @or_not_and_and_not_and_xor_commute1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg2, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.xor %arg1, %arg2  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.xor %5, %3  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_or_not_and_and_not_and_xor_commute1   : or_not_and_and_not_and_xor_commute1_before  ⊑  or_not_and_and_not_and_xor_commute1_combined := by
  unfold or_not_and_and_not_and_xor_commute1_before or_not_and_and_not_and_xor_commute1_combined
  simp_alive_peephole
  sorry
def or_not_and_and_not_and_xor_commute2_combined := [llvmfunc|
  llvm.func @or_not_and_and_not_and_xor_commute2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg0  : i32
    %3 = llvm.and %arg1, %arg2  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.or %2, %4  : i32
    %6 = llvm.xor %arg1, %arg2  : i32
    %7 = llvm.and %6, %2  : i32
    %8 = llvm.xor %7, %5  : i32
    llvm.return %8 : i32
  }]

theorem inst_combine_or_not_and_and_not_and_xor_commute2   : or_not_and_and_not_and_xor_commute2_before  ⊑  or_not_and_and_not_and_xor_commute2_combined := by
  unfold or_not_and_and_not_and_xor_commute2_before or_not_and_and_not_and_xor_commute2_combined
  simp_alive_peephole
  sorry
def or_not_and_and_not_and_xor_commute3_combined := [llvmfunc|
  llvm.func @or_not_and_and_not_and_xor_commute3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg2  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.xor %arg2, %arg1  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.xor %5, %3  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_or_not_and_and_not_and_xor_commute3   : or_not_and_and_not_and_xor_commute3_before  ⊑  or_not_and_and_not_and_xor_commute3_combined := by
  unfold or_not_and_and_not_and_xor_commute3_before or_not_and_and_not_and_xor_commute3_combined
  simp_alive_peephole
  sorry
def or_not_and_and_not_and_xor_commute4_combined := [llvmfunc|
  llvm.func @or_not_and_and_not_and_xor_commute4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg0  : i32
    %3 = llvm.and %arg1, %arg2  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.or %2, %4  : i32
    %6 = llvm.xor %arg1, %arg2  : i32
    %7 = llvm.and %2, %6  : i32
    %8 = llvm.xor %7, %5  : i32
    llvm.return %8 : i32
  }]

theorem inst_combine_or_not_and_and_not_and_xor_commute4   : or_not_and_and_not_and_xor_commute4_before  ⊑  or_not_and_and_not_and_xor_commute4_combined := by
  unfold or_not_and_and_not_and_xor_commute4_before or_not_and_and_not_and_xor_commute4_combined
  simp_alive_peephole
  sorry
def or_not_and_and_not_and_xor_commute5_combined := [llvmfunc|
  llvm.func @or_not_and_and_not_and_xor_commute5(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg2  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.xor %arg1, %arg2  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.xor %5, %3  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_or_not_and_and_not_and_xor_commute5   : or_not_and_and_not_and_xor_commute5_before  ⊑  or_not_and_and_not_and_xor_commute5_combined := by
  unfold or_not_and_and_not_and_xor_commute5_before or_not_and_and_not_and_xor_commute5_combined
  simp_alive_peephole
  sorry
def or_not_and_and_not_and_xor_use1_combined := [llvmfunc|
  llvm.func @or_not_and_and_not_and_xor_use1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg2  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.xor %arg1, %arg2  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.xor %5, %3  : i32
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %6 : i32
  }]

theorem inst_combine_or_not_and_and_not_and_xor_use1   : or_not_and_and_not_and_xor_use1_before  ⊑  or_not_and_and_not_and_xor_use1_combined := by
  unfold or_not_and_and_not_and_xor_use1_before or_not_and_and_not_and_xor_use1_combined
  simp_alive_peephole
  sorry
def or_not_and_and_not_and_xor_use2_combined := [llvmfunc|
  llvm.func @or_not_and_and_not_and_xor_use2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg2  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.xor %arg1, %arg2  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.xor %5, %3  : i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %6 : i32
  }]

theorem inst_combine_or_not_and_and_not_and_xor_use2   : or_not_and_and_not_and_xor_use2_before  ⊑  or_not_and_and_not_and_xor_use2_combined := by
  unfold or_not_and_and_not_and_xor_use2_before or_not_and_and_not_and_xor_use2_combined
  simp_alive_peephole
  sorry
def or_not_and_and_not_and_xor_use3_combined := [llvmfunc|
  llvm.func @or_not_and_and_not_and_xor_use3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg2  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.xor %arg1, %arg2  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.xor %5, %3  : i32
    llvm.call @use(%3) : (i32) -> ()
    llvm.return %6 : i32
  }]

theorem inst_combine_or_not_and_and_not_and_xor_use3   : or_not_and_and_not_and_xor_use3_before  ⊑  or_not_and_and_not_and_xor_use3_combined := by
  unfold or_not_and_and_not_and_xor_use3_before or_not_and_and_not_and_xor_use3_combined
  simp_alive_peephole
  sorry
def or_not_and_and_not_and_xor_use4_combined := [llvmfunc|
  llvm.func @or_not_and_and_not_and_xor_use4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg2  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.xor %arg1, %arg2  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.xor %5, %3  : i32
    llvm.call @use(%4) : (i32) -> ()
    llvm.return %6 : i32
  }]

theorem inst_combine_or_not_and_and_not_and_xor_use4   : or_not_and_and_not_and_xor_use4_before  ⊑  or_not_and_and_not_and_xor_use4_combined := by
  unfold or_not_and_and_not_and_xor_use4_before or_not_and_and_not_and_xor_use4_combined
  simp_alive_peephole
  sorry
def or_not_and_and_not_and_xor_use5_combined := [llvmfunc|
  llvm.func @or_not_and_and_not_and_xor_use5(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg2  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.xor %arg1, %arg2  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.xor %5, %3  : i32
    llvm.call @use(%5) : (i32) -> ()
    llvm.return %6 : i32
  }]

theorem inst_combine_or_not_and_and_not_and_xor_use5   : or_not_and_and_not_and_xor_use5_before  ⊑  or_not_and_and_not_and_xor_use5_combined := by
  unfold or_not_and_and_not_and_xor_use5_before or_not_and_and_not_and_xor_use5_combined
  simp_alive_peephole
  sorry
def or_not_and_and_not_and_xor_use6_combined := [llvmfunc|
  llvm.func @or_not_and_and_not_and_xor_use6(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg2  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.xor %arg1, %arg2  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.xor %5, %0  : i32
    %7 = llvm.xor %5, %3  : i32
    llvm.call @use(%6) : (i32) -> ()
    llvm.return %7 : i32
  }]

theorem inst_combine_or_not_and_and_not_and_xor_use6   : or_not_and_and_not_and_xor_use6_before  ⊑  or_not_and_and_not_and_xor_use6_combined := by
  unfold or_not_and_and_not_and_xor_use6_before or_not_and_and_not_and_xor_use6_combined
  simp_alive_peephole
  sorry
def not_and_and_or_not_or_or_combined := [llvmfunc|
  llvm.func @not_and_and_or_not_or_or(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg2, %arg1  : i32
    %2 = llvm.or %1, %arg0  : i32
    %3 = llvm.xor %2, %0  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_not_and_and_or_not_or_or   : not_and_and_or_not_or_or_before  ⊑  not_and_and_or_not_or_or_combined := by
  unfold not_and_and_or_not_or_or_before not_and_and_or_not_or_or_combined
  simp_alive_peephole
  sorry
def not_and_and_or_not_or_or_commute1_or_combined := [llvmfunc|
  llvm.func @not_and_and_or_not_or_or_commute1_or(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg2, %arg1  : i32
    %2 = llvm.or %1, %arg0  : i32
    %3 = llvm.xor %2, %0  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_not_and_and_or_not_or_or_commute1_or   : not_and_and_or_not_or_or_commute1_or_before  ⊑  not_and_and_or_not_or_or_commute1_or_combined := by
  unfold not_and_and_or_not_or_or_commute1_or_before not_and_and_or_not_or_or_commute1_or_combined
  simp_alive_peephole
  sorry
def not_and_and_or_not_or_or_commute2_or_combined := [llvmfunc|
  llvm.func @not_and_and_or_not_or_or_commute2_or(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg2, %arg1  : i32
    %2 = llvm.or %1, %arg0  : i32
    %3 = llvm.xor %2, %0  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_not_and_and_or_not_or_or_commute2_or   : not_and_and_or_not_or_or_commute2_or_before  ⊑  not_and_and_or_not_or_or_commute2_or_combined := by
  unfold not_and_and_or_not_or_or_commute2_or_before not_and_and_or_not_or_or_commute2_or_combined
  simp_alive_peephole
  sorry
def not_and_and_or_not_or_or_commute1_and_combined := [llvmfunc|
  llvm.func @not_and_and_or_not_or_or_commute1_and(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %arg2  : i32
    %2 = llvm.or %1, %arg0  : i32
    %3 = llvm.xor %2, %0  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_not_and_and_or_not_or_or_commute1_and   : not_and_and_or_not_or_or_commute1_and_before  ⊑  not_and_and_or_not_or_or_commute1_and_combined := by
  unfold not_and_and_or_not_or_or_commute1_and_before not_and_and_or_not_or_or_commute1_and_combined
  simp_alive_peephole
  sorry
def not_and_and_or_not_or_or_commute2_and_combined := [llvmfunc|
  llvm.func @not_and_and_or_not_or_or_commute2_and(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %arg2  : i32
    %2 = llvm.or %1, %arg0  : i32
    %3 = llvm.xor %2, %0  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_not_and_and_or_not_or_or_commute2_and   : not_and_and_or_not_or_or_commute2_and_before  ⊑  not_and_and_or_not_or_or_commute2_and_combined := by
  unfold not_and_and_or_not_or_or_commute2_and_before not_and_and_or_not_or_or_commute2_and_combined
  simp_alive_peephole
  sorry
def not_and_and_or_not_or_or_commute1_combined := [llvmfunc|
  llvm.func @not_and_and_or_not_or_or_commute1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg2, %arg1  : i32
    %2 = llvm.or %1, %arg0  : i32
    %3 = llvm.xor %2, %0  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_not_and_and_or_not_or_or_commute1   : not_and_and_or_not_or_or_commute1_before  ⊑  not_and_and_or_not_or_or_commute1_combined := by
  unfold not_and_and_or_not_or_or_commute1_before not_and_and_or_not_or_or_commute1_combined
  simp_alive_peephole
  sorry
def not_and_and_or_not_or_or_commute2_combined := [llvmfunc|
  llvm.func @not_and_and_or_not_or_or_commute2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg2  : i32
    %3 = llvm.xor %2, %arg1  : i32
    %4 = llvm.or %3, %arg0  : i32
    %5 = llvm.xor %4, %1  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_not_and_and_or_not_or_or_commute2   : not_and_and_or_not_or_or_commute2_before  ⊑  not_and_and_or_not_or_or_commute2_combined := by
  unfold not_and_and_or_not_or_or_commute2_before not_and_and_or_not_or_or_commute2_combined
  simp_alive_peephole
  sorry
def not_and_and_or_not_or_or_commute3_combined := [llvmfunc|
  llvm.func @not_and_and_or_not_or_or_commute3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg1  : i32
    %3 = llvm.xor %2, %arg2  : i32
    %4 = llvm.or %3, %arg0  : i32
    %5 = llvm.xor %4, %1  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_not_and_and_or_not_or_or_commute3   : not_and_and_or_not_or_or_commute3_before  ⊑  not_and_and_or_not_or_or_commute3_combined := by
  unfold not_and_and_or_not_or_or_commute3_before not_and_and_or_not_or_or_commute3_combined
  simp_alive_peephole
  sorry
def not_and_and_or_not_or_or_commute4_combined := [llvmfunc|
  llvm.func @not_and_and_or_not_or_or_commute4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg2  : i32
    %3 = llvm.xor %2, %arg1  : i32
    %4 = llvm.or %3, %arg0  : i32
    %5 = llvm.xor %4, %1  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_not_and_and_or_not_or_or_commute4   : not_and_and_or_not_or_or_commute4_before  ⊑  not_and_and_or_not_or_or_commute4_combined := by
  unfold not_and_and_or_not_or_or_commute4_before not_and_and_or_not_or_or_commute4_combined
  simp_alive_peephole
  sorry
def not_and_and_or_not_or_or_use1_combined := [llvmfunc|
  llvm.func @not_and_and_or_not_or_or_use1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %arg2, %arg1  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.xor %3, %0  : i32
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %4 : i32
  }]

theorem inst_combine_not_and_and_or_not_or_or_use1   : not_and_and_or_not_or_or_use1_before  ⊑  not_and_and_or_not_or_or_use1_combined := by
  unfold not_and_and_or_not_or_or_use1_before not_and_and_or_not_or_or_use1_combined
  simp_alive_peephole
  sorry
def not_and_and_or_not_or_or_use2_combined := [llvmfunc|
  llvm.func @not_and_and_or_not_or_or_use2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.or %1, %arg2  : i32
    %3 = llvm.xor %arg2, %arg1  : i32
    %4 = llvm.or %3, %arg0  : i32
    %5 = llvm.xor %4, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %5 : i32
  }]

theorem inst_combine_not_and_and_or_not_or_or_use2   : not_and_and_or_not_or_or_use2_before  ⊑  not_and_and_or_not_or_or_use2_combined := by
  unfold not_and_and_or_not_or_or_use2_before not_and_and_or_not_or_or_use2_combined
  simp_alive_peephole
  sorry
def not_and_and_or_not_or_or_use3_combined := [llvmfunc|
  llvm.func @not_and_and_or_not_or_or_use3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.or %1, %arg2  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.and %5, %arg2  : i32
    %7 = llvm.or %6, %3  : i32
    llvm.call @use(%3) : (i32) -> ()
    llvm.return %7 : i32
  }]

theorem inst_combine_not_and_and_or_not_or_or_use3   : not_and_and_or_not_or_or_use3_before  ⊑  not_and_and_or_not_or_or_use3_combined := by
  unfold not_and_and_or_not_or_or_use3_before not_and_and_or_not_or_or_use3_combined
  simp_alive_peephole
  sorry
def not_and_and_or_not_or_or_use4_combined := [llvmfunc|
  llvm.func @not_and_and_or_not_or_or_use4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %arg2, %arg1  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.xor %3, %0  : i32
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %4 : i32
  }]

theorem inst_combine_not_and_and_or_not_or_or_use4   : not_and_and_or_not_or_or_use4_before  ⊑  not_and_and_or_not_or_or_use4_combined := by
  unfold not_and_and_or_not_or_or_use4_before not_and_and_or_not_or_or_use4_combined
  simp_alive_peephole
  sorry
def not_and_and_or_not_or_or_use5_combined := [llvmfunc|
  llvm.func @not_and_and_or_not_or_or_use5(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.and %1, %arg1  : i32
    %3 = llvm.xor %arg2, %arg1  : i32
    %4 = llvm.or %3, %arg0  : i32
    %5 = llvm.xor %4, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %5 : i32
  }]

theorem inst_combine_not_and_and_or_not_or_or_use5   : not_and_and_or_not_or_or_use5_before  ⊑  not_and_and_or_not_or_or_use5_combined := by
  unfold not_and_and_or_not_or_or_use5_before not_and_and_or_not_or_or_use5_combined
  simp_alive_peephole
  sorry
def not_and_and_or_not_or_or_use6_combined := [llvmfunc|
  llvm.func @not_and_and_or_not_or_or_use6(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.or %1, %arg2  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.and %5, %arg2  : i32
    %7 = llvm.or %6, %3  : i32
    llvm.call @use(%6) : (i32) -> ()
    llvm.return %7 : i32
  }]

theorem inst_combine_not_and_and_or_not_or_or_use6   : not_and_and_or_not_or_or_use6_before  ⊑  not_and_and_or_not_or_or_use6_combined := by
  unfold not_and_and_or_not_or_or_use6_before not_and_and_or_not_or_or_use6_combined
  simp_alive_peephole
  sorry
def not_or_or_and_not_and_and_combined := [llvmfunc|
  llvm.func @not_or_or_and_not_and_and(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %arg2, %arg1  : i32
    %3 = llvm.or %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_not_or_or_and_not_and_and   : not_or_or_and_not_and_and_before  ⊑  not_or_or_and_not_and_and_combined := by
  unfold not_or_or_and_not_and_and_before not_or_or_and_not_and_and_combined
  simp_alive_peephole
  sorry
def not_or_or_and_not_and_and_commute1_and_combined := [llvmfunc|
  llvm.func @not_or_or_and_not_and_and_commute1_and(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %arg2, %arg1  : i32
    %3 = llvm.or %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_not_or_or_and_not_and_and_commute1_and   : not_or_or_and_not_and_and_commute1_and_before  ⊑  not_or_or_and_not_and_and_commute1_and_combined := by
  unfold not_or_or_and_not_and_and_commute1_and_before not_or_or_and_not_and_and_commute1_and_combined
  simp_alive_peephole
  sorry
def not_or_or_and_not_and_and_commute2_and_combined := [llvmfunc|
  llvm.func @not_or_or_and_not_and_and_commute2_and(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %arg2, %arg1  : i32
    %3 = llvm.or %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_not_or_or_and_not_and_and_commute2_and   : not_or_or_and_not_and_and_commute2_and_before  ⊑  not_or_or_and_not_and_and_commute2_and_combined := by
  unfold not_or_or_and_not_and_and_commute2_and_before not_or_or_and_not_and_and_commute2_and_combined
  simp_alive_peephole
  sorry
def not_or_or_and_not_and_and_commute1_or_combined := [llvmfunc|
  llvm.func @not_or_or_and_not_and_and_commute1_or(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %arg1, %arg2  : i32
    %3 = llvm.or %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_not_or_or_and_not_and_and_commute1_or   : not_or_or_and_not_and_and_commute1_or_before  ⊑  not_or_or_and_not_and_and_commute1_or_combined := by
  unfold not_or_or_and_not_and_and_commute1_or_before not_or_or_and_not_and_and_commute1_or_combined
  simp_alive_peephole
  sorry
def not_or_or_and_not_and_and_commute2_or_combined := [llvmfunc|
  llvm.func @not_or_or_and_not_and_and_commute2_or(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %arg1, %arg2  : i32
    %3 = llvm.or %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_not_or_or_and_not_and_and_commute2_or   : not_or_or_and_not_and_and_commute2_or_before  ⊑  not_or_or_and_not_and_and_commute2_or_combined := by
  unfold not_or_or_and_not_and_and_commute2_or_before not_or_or_and_not_and_and_commute2_or_combined
  simp_alive_peephole
  sorry
def not_or_or_and_not_and_and_commute1_combined := [llvmfunc|
  llvm.func @not_or_or_and_not_and_and_commute1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %arg2, %arg1  : i32
    %3 = llvm.or %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_not_or_or_and_not_and_and_commute1   : not_or_or_and_not_and_and_commute1_before  ⊑  not_or_or_and_not_and_and_commute1_combined := by
  unfold not_or_or_and_not_and_and_commute1_before not_or_or_and_not_and_and_commute1_combined
  simp_alive_peephole
  sorry
def not_or_or_and_not_and_and_commute2_combined := [llvmfunc|
  llvm.func @not_or_or_and_not_and_and_commute2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg2  : i32
    %3 = llvm.xor %arg0, %1  : i32
    %4 = llvm.xor %2, %arg1  : i32
    %5 = llvm.or %4, %3  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_not_or_or_and_not_and_and_commute2   : not_or_or_and_not_and_and_commute2_before  ⊑  not_or_or_and_not_and_and_commute2_combined := by
  unfold not_or_or_and_not_and_and_commute2_before not_or_or_and_not_and_and_commute2_combined
  simp_alive_peephole
  sorry
def not_or_or_and_not_and_and_commute3_combined := [llvmfunc|
  llvm.func @not_or_or_and_not_and_and_commute3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg1  : i32
    %3 = llvm.xor %arg0, %1  : i32
    %4 = llvm.xor %2, %arg2  : i32
    %5 = llvm.or %4, %3  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_not_or_or_and_not_and_and_commute3   : not_or_or_and_not_and_and_commute3_before  ⊑  not_or_or_and_not_and_and_commute3_combined := by
  unfold not_or_or_and_not_and_and_commute3_before not_or_or_and_not_and_and_commute3_combined
  simp_alive_peephole
  sorry
def not_or_or_and_not_and_and_commute4_combined := [llvmfunc|
  llvm.func @not_or_or_and_not_and_and_commute4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg2  : i32
    %3 = llvm.xor %arg0, %1  : i32
    %4 = llvm.xor %2, %arg1  : i32
    %5 = llvm.or %4, %3  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_not_or_or_and_not_and_and_commute4   : not_or_or_and_not_and_and_commute4_before  ⊑  not_or_or_and_not_and_and_commute4_combined := by
  unfold not_or_or_and_not_and_and_commute4_before not_or_or_and_not_and_and_commute4_combined
  simp_alive_peephole
  sorry
def not_or_or_and_not_and_and_use1_combined := [llvmfunc|
  llvm.func @not_or_or_and_not_and_and_use1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.xor %arg2, %arg1  : i32
    %4 = llvm.or %3, %2  : i32
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %4 : i32
  }]

theorem inst_combine_not_or_or_and_not_and_and_use1   : not_or_or_and_not_and_and_use1_before  ⊑  not_or_or_and_not_and_and_use1_combined := by
  unfold not_or_or_and_not_and_and_use1_before not_or_or_and_not_and_and_use1_combined
  simp_alive_peephole
  sorry
def not_or_or_and_not_and_and_use2_combined := [llvmfunc|
  llvm.func @not_or_or_and_not_and_and_use2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.and %1, %arg2  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.xor %arg2, %arg1  : i32
    %5 = llvm.or %4, %3  : i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %5 : i32
  }]

theorem inst_combine_not_or_or_and_not_and_and_use2   : not_or_or_and_not_and_and_use2_before  ⊑  not_or_or_and_not_and_and_use2_combined := by
  unfold not_or_or_and_not_and_and_use2_before not_or_or_and_not_and_and_use2_combined
  simp_alive_peephole
  sorry
def not_or_or_and_not_and_and_use3_combined := [llvmfunc|
  llvm.func @not_or_or_and_not_and_and_use3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.and %1, %arg2  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.or %5, %arg2  : i32
    %7 = llvm.xor %2, %6  : i32
    llvm.call @use(%3) : (i32) -> ()
    llvm.return %7 : i32
  }]

theorem inst_combine_not_or_or_and_not_and_and_use3   : not_or_or_and_not_and_and_use3_before  ⊑  not_or_or_and_not_and_and_use3_combined := by
  unfold not_or_or_and_not_and_and_use3_before not_or_or_and_not_and_and_use3_combined
  simp_alive_peephole
  sorry
def not_or_or_and_not_and_and_use4_combined := [llvmfunc|
  llvm.func @not_or_or_and_not_and_and_use4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %arg2, %arg1  : i32
    %3 = llvm.or %2, %1  : i32
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %3 : i32
  }]

theorem inst_combine_not_or_or_and_not_and_and_use4   : not_or_or_and_not_and_and_use4_before  ⊑  not_or_or_and_not_and_and_use4_combined := by
  unfold not_or_or_and_not_and_and_use4_before not_or_or_and_not_and_and_use4_combined
  simp_alive_peephole
  sorry
def not_or_or_and_not_and_and_use5_combined := [llvmfunc|
  llvm.func @not_or_or_and_not_and_and_use5(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.or %1, %arg1  : i32
    %3 = llvm.xor %arg2, %arg1  : i32
    %4 = llvm.or %3, %1  : i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %4 : i32
  }]

theorem inst_combine_not_or_or_and_not_and_and_use5   : not_or_or_and_not_and_and_use5_before  ⊑  not_or_or_and_not_and_and_use5_combined := by
  unfold not_or_or_and_not_and_and_use5_before not_or_or_and_not_and_and_use5_combined
  simp_alive_peephole
  sorry
def not_or_or_and_not_and_and_use6_combined := [llvmfunc|
  llvm.func @not_or_or_and_not_and_and_use6(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.and %1, %arg2  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.or %3, %arg1  : i32
    %5 = llvm.or %4, %arg2  : i32
    %6 = llvm.xor %2, %5  : i32
    llvm.call @use(%5) : (i32) -> ()
    llvm.return %6 : i32
  }]

theorem inst_combine_not_or_or_and_not_and_and_use6   : not_or_or_and_not_and_and_use6_before  ⊑  not_or_or_and_not_and_and_use6_combined := by
  unfold not_or_or_and_not_and_and_use6_before not_or_or_and_not_and_and_use6_combined
  simp_alive_peephole
  sorry
def not_and_and_or_no_or_combined := [llvmfunc|
  llvm.func @not_and_and_or_no_or(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %arg1, %0  : i32
    %3 = llvm.or %2, %arg2  : i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_not_and_and_or_no_or   : not_and_and_or_no_or_before  ⊑  not_and_and_or_no_or_combined := by
  unfold not_and_and_or_no_or_before not_and_and_or_no_or_combined
  simp_alive_peephole
  sorry
def not_and_and_or_no_or_commute1_and_combined := [llvmfunc|
  llvm.func @not_and_and_or_no_or_commute1_and(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %arg1, %0  : i32
    %3 = llvm.or %2, %arg2  : i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_not_and_and_or_no_or_commute1_and   : not_and_and_or_no_or_commute1_and_before  ⊑  not_and_and_or_no_or_commute1_and_combined := by
  unfold not_and_and_or_no_or_commute1_and_before not_and_and_or_no_or_commute1_and_combined
  simp_alive_peephole
  sorry
def not_and_and_or_no_or_commute2_and_combined := [llvmfunc|
  llvm.func @not_and_and_or_no_or_commute2_and(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %arg1, %0  : i32
    %3 = llvm.or %2, %arg2  : i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_not_and_and_or_no_or_commute2_and   : not_and_and_or_no_or_commute2_and_before  ⊑  not_and_and_or_no_or_commute2_and_combined := by
  unfold not_and_and_or_no_or_commute2_and_before not_and_and_or_no_or_commute2_and_combined
  simp_alive_peephole
  sorry
def not_and_and_or_no_or_commute1_combined := [llvmfunc|
  llvm.func @not_and_and_or_no_or_commute1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %arg1, %0  : i32
    %3 = llvm.or %2, %arg2  : i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_not_and_and_or_no_or_commute1   : not_and_and_or_no_or_commute1_before  ⊑  not_and_and_or_no_or_commute1_combined := by
  unfold not_and_and_or_no_or_commute1_before not_and_and_or_no_or_commute1_combined
  simp_alive_peephole
  sorry
def not_and_and_or_no_or_commute2_combined := [llvmfunc|
  llvm.func @not_and_and_or_no_or_commute2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg1  : i32
    %3 = llvm.xor %arg0, %1  : i32
    %4 = llvm.xor %2, %1  : i32
    %5 = llvm.or %4, %arg2  : i32
    %6 = llvm.and %5, %3  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_not_and_and_or_no_or_commute2   : not_and_and_or_no_or_commute2_before  ⊑  not_and_and_or_no_or_commute2_combined := by
  unfold not_and_and_or_no_or_commute2_before not_and_and_or_no_or_commute2_combined
  simp_alive_peephole
  sorry
def not_and_and_or_no_or_commute3_combined := [llvmfunc|
  llvm.func @not_and_and_or_no_or_commute3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg2  : i32
    %3 = llvm.xor %arg0, %1  : i32
    %4 = llvm.xor %arg1, %1  : i32
    %5 = llvm.or %2, %4  : i32
    %6 = llvm.and %5, %3  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_not_and_and_or_no_or_commute3   : not_and_and_or_no_or_commute3_before  ⊑  not_and_and_or_no_or_commute3_combined := by
  unfold not_and_and_or_no_or_commute3_before not_and_and_or_no_or_commute3_combined
  simp_alive_peephole
  sorry
def not_and_and_or_no_or_use1_combined := [llvmfunc|
  llvm.func @not_and_and_or_no_or_use1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %arg1, %0  : i32
    %3 = llvm.or %2, %arg2  : i32
    %4 = llvm.and %3, %1  : i32
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %4 : i32
  }]

theorem inst_combine_not_and_and_or_no_or_use1   : not_and_and_or_no_or_use1_before  ⊑  not_and_and_or_no_or_use1_combined := by
  unfold not_and_and_or_no_or_use1_before not_and_and_or_no_or_use1_combined
  simp_alive_peephole
  sorry
def not_and_and_or_no_or_use2_combined := [llvmfunc|
  llvm.func @not_and_and_or_no_or_use2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %arg1, %0  : i32
    %3 = llvm.or %2, %arg2  : i32
    %4 = llvm.and %3, %1  : i32
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %4 : i32
  }]

theorem inst_combine_not_and_and_or_no_or_use2   : not_and_and_or_no_or_use2_before  ⊑  not_and_and_or_no_or_use2_combined := by
  unfold not_and_and_or_no_or_use2_before not_and_and_or_no_or_use2_combined
  simp_alive_peephole
  sorry
def not_and_and_or_no_or_use3_combined := [llvmfunc|
  llvm.func @not_and_and_or_no_or_use3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %arg1, %0  : i32
    %3 = llvm.or %2, %arg2  : i32
    %4 = llvm.and %3, %1  : i32
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %4 : i32
  }]

theorem inst_combine_not_and_and_or_no_or_use3   : not_and_and_or_no_or_use3_before  ⊑  not_and_and_or_no_or_use3_combined := by
  unfold not_and_and_or_no_or_use3_before not_and_and_or_no_or_use3_combined
  simp_alive_peephole
  sorry
def not_and_and_or_no_or_use4_combined := [llvmfunc|
  llvm.func @not_and_and_or_no_or_use4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %arg1, %0  : i32
    %3 = llvm.or %2, %arg2  : i32
    %4 = llvm.and %3, %1  : i32
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %4 : i32
  }]

theorem inst_combine_not_and_and_or_no_or_use4   : not_and_and_or_no_or_use4_before  ⊑  not_and_and_or_no_or_use4_combined := by
  unfold not_and_and_or_no_or_use4_before not_and_and_or_no_or_use4_combined
  simp_alive_peephole
  sorry
def not_and_and_or_no_or_use5_combined := [llvmfunc|
  llvm.func @not_and_and_or_no_or_use5(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.and %3, %arg2  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %6 : i32
  }]

theorem inst_combine_not_and_and_or_no_or_use5   : not_and_and_or_no_or_use5_before  ⊑  not_and_and_or_no_or_use5_combined := by
  unfold not_and_and_or_no_or_use5_before not_and_and_or_no_or_use5_combined
  simp_alive_peephole
  sorry
def not_and_and_or_no_or_use6_combined := [llvmfunc|
  llvm.func @not_and_and_or_no_or_use6(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.and %3, %arg2  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %6 : i32
  }]

theorem inst_combine_not_and_and_or_no_or_use6   : not_and_and_or_no_or_use6_before  ⊑  not_and_and_or_no_or_use6_combined := by
  unfold not_and_and_or_no_or_use6_before not_and_and_or_no_or_use6_combined
  simp_alive_peephole
  sorry
def not_and_and_or_no_or_use7_combined := [llvmfunc|
  llvm.func @not_and_and_or_no_or_use7(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.and %1, %arg1  : i32
    %3 = llvm.xor %arg1, %0  : i32
    %4 = llvm.or %3, %arg2  : i32
    %5 = llvm.and %4, %1  : i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %5 : i32
  }]

theorem inst_combine_not_and_and_or_no_or_use7   : not_and_and_or_no_or_use7_before  ⊑  not_and_and_or_no_or_use7_combined := by
  unfold not_and_and_or_no_or_use7_before not_and_and_or_no_or_use7_combined
  simp_alive_peephole
  sorry
def not_and_and_or_no_or_use8_combined := [llvmfunc|
  llvm.func @not_and_and_or_no_or_use8(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.and %3, %arg2  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.call @use(%5) : (i32) -> ()
    llvm.return %6 : i32
  }]

theorem inst_combine_not_and_and_or_no_or_use8   : not_and_and_or_no_or_use8_before  ⊑  not_and_and_or_no_or_use8_combined := by
  unfold not_and_and_or_no_or_use8_before not_and_and_or_no_or_use8_combined
  simp_alive_peephole
  sorry
def not_or_or_and_no_and_combined := [llvmfunc|
  llvm.func @not_or_or_and_no_and(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %arg1, %0  : i32
    %3 = llvm.and %2, %arg2  : i32
    %4 = llvm.or %3, %1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_not_or_or_and_no_and   : not_or_or_and_no_and_before  ⊑  not_or_or_and_no_and_combined := by
  unfold not_or_or_and_no_and_before not_or_or_and_no_and_combined
  simp_alive_peephole
  sorry
def not_or_or_and_no_and_commute1_or_combined := [llvmfunc|
  llvm.func @not_or_or_and_no_and_commute1_or(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %arg1, %0  : i32
    %3 = llvm.and %2, %arg2  : i32
    %4 = llvm.or %3, %1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_not_or_or_and_no_and_commute1_or   : not_or_or_and_no_and_commute1_or_before  ⊑  not_or_or_and_no_and_commute1_or_combined := by
  unfold not_or_or_and_no_and_commute1_or_before not_or_or_and_no_and_commute1_or_combined
  simp_alive_peephole
  sorry
def not_or_or_and_no_and_commute2_or_combined := [llvmfunc|
  llvm.func @not_or_or_and_no_and_commute2_or(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %arg1, %0  : i32
    %3 = llvm.and %2, %arg2  : i32
    %4 = llvm.or %3, %1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_not_or_or_and_no_and_commute2_or   : not_or_or_and_no_and_commute2_or_before  ⊑  not_or_or_and_no_and_commute2_or_combined := by
  unfold not_or_or_and_no_and_commute2_or_before not_or_or_and_no_and_commute2_or_combined
  simp_alive_peephole
  sorry
def not_or_or_and_no_and_commute1_combined := [llvmfunc|
  llvm.func @not_or_or_and_no_and_commute1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %arg1, %0  : i32
    %3 = llvm.and %2, %arg2  : i32
    %4 = llvm.or %3, %1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_not_or_or_and_no_and_commute1   : not_or_or_and_no_and_commute1_before  ⊑  not_or_or_and_no_and_commute1_combined := by
  unfold not_or_or_and_no_and_commute1_before not_or_or_and_no_and_commute1_combined
  simp_alive_peephole
  sorry
def not_or_or_and_no_and_commute2_combined := [llvmfunc|
  llvm.func @not_or_or_and_no_and_commute2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg1  : i32
    %3 = llvm.xor %arg0, %1  : i32
    %4 = llvm.xor %2, %1  : i32
    %5 = llvm.and %4, %arg2  : i32
    %6 = llvm.or %5, %3  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_not_or_or_and_no_and_commute2   : not_or_or_and_no_and_commute2_before  ⊑  not_or_or_and_no_and_commute2_combined := by
  unfold not_or_or_and_no_and_commute2_before not_or_or_and_no_and_commute2_combined
  simp_alive_peephole
  sorry
def not_or_or_and_no_and_commute3_combined := [llvmfunc|
  llvm.func @not_or_or_and_no_and_commute3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg2  : i32
    %3 = llvm.xor %arg0, %1  : i32
    %4 = llvm.xor %arg1, %1  : i32
    %5 = llvm.and %2, %4  : i32
    %6 = llvm.or %5, %3  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_not_or_or_and_no_and_commute3   : not_or_or_and_no_and_commute3_before  ⊑  not_or_or_and_no_and_commute3_combined := by
  unfold not_or_or_and_no_and_commute3_before not_or_or_and_no_and_commute3_combined
  simp_alive_peephole
  sorry
def not_or_or_and_no_and_use1_combined := [llvmfunc|
  llvm.func @not_or_or_and_no_and_use1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %arg1, %0  : i32
    %3 = llvm.and %2, %arg2  : i32
    %4 = llvm.or %3, %1  : i32
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %4 : i32
  }]

theorem inst_combine_not_or_or_and_no_and_use1   : not_or_or_and_no_and_use1_before  ⊑  not_or_or_and_no_and_use1_combined := by
  unfold not_or_or_and_no_and_use1_before not_or_or_and_no_and_use1_combined
  simp_alive_peephole
  sorry
def not_or_or_and_no_and_use2_combined := [llvmfunc|
  llvm.func @not_or_or_and_no_and_use2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %arg1, %0  : i32
    %3 = llvm.and %2, %arg2  : i32
    %4 = llvm.or %3, %1  : i32
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %4 : i32
  }]

theorem inst_combine_not_or_or_and_no_and_use2   : not_or_or_and_no_and_use2_before  ⊑  not_or_or_and_no_and_use2_combined := by
  unfold not_or_or_and_no_and_use2_before not_or_or_and_no_and_use2_combined
  simp_alive_peephole
  sorry
def not_or_or_and_no_and_use3_combined := [llvmfunc|
  llvm.func @not_or_or_and_no_and_use3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %arg1, %0  : i32
    %3 = llvm.and %2, %arg2  : i32
    %4 = llvm.or %3, %1  : i32
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %4 : i32
  }]

theorem inst_combine_not_or_or_and_no_and_use3   : not_or_or_and_no_and_use3_before  ⊑  not_or_or_and_no_and_use3_combined := by
  unfold not_or_or_and_no_and_use3_before not_or_or_and_no_and_use3_combined
  simp_alive_peephole
  sorry
def not_or_or_and_no_and_use4_combined := [llvmfunc|
  llvm.func @not_or_or_and_no_and_use4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %arg1, %0  : i32
    %3 = llvm.and %2, %arg2  : i32
    %4 = llvm.or %3, %1  : i32
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %4 : i32
  }]

theorem inst_combine_not_or_or_and_no_and_use4   : not_or_or_and_no_and_use4_before  ⊑  not_or_or_and_no_and_use4_combined := by
  unfold not_or_or_and_no_and_use4_before not_or_or_and_no_and_use4_combined
  simp_alive_peephole
  sorry
def not_or_or_and_no_and_use5_combined := [llvmfunc|
  llvm.func @not_or_or_and_no_and_use5(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.or %2, %arg2  : i32
    %4 = llvm.or %3, %arg1  : i32
    %5 = llvm.xor %1, %4  : i32
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %5 : i32
  }]

theorem inst_combine_not_or_or_and_no_and_use5   : not_or_or_and_no_and_use5_before  ⊑  not_or_or_and_no_and_use5_combined := by
  unfold not_or_or_and_no_and_use5_before not_or_or_and_no_and_use5_combined
  simp_alive_peephole
  sorry
def not_or_or_and_no_and_use6_combined := [llvmfunc|
  llvm.func @not_or_or_and_no_and_use6(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.or %3, %arg2  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.xor %1, %5  : i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %6 : i32
  }]

theorem inst_combine_not_or_or_and_no_and_use6   : not_or_or_and_no_and_use6_before  ⊑  not_or_or_and_no_and_use6_combined := by
  unfold not_or_or_and_no_and_use6_before not_or_or_and_no_and_use6_combined
  simp_alive_peephole
  sorry
def not_or_or_and_no_and_use7_combined := [llvmfunc|
  llvm.func @not_or_or_and_no_and_use7(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.or %1, %arg1  : i32
    %3 = llvm.xor %arg1, %0  : i32
    %4 = llvm.and %3, %arg2  : i32
    %5 = llvm.or %4, %1  : i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %5 : i32
  }]

theorem inst_combine_not_or_or_and_no_and_use7   : not_or_or_and_no_and_use7_before  ⊑  not_or_or_and_no_and_use7_combined := by
  unfold not_or_or_and_no_and_use7_before not_or_or_and_no_and_use7_combined
  simp_alive_peephole
  sorry
def not_or_or_and_no_and_use8_combined := [llvmfunc|
  llvm.func @not_or_or_and_no_and_use8(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.or %2, %arg2  : i32
    %4 = llvm.or %3, %arg1  : i32
    %5 = llvm.xor %1, %4  : i32
    llvm.call @use(%4) : (i32) -> ()
    llvm.return %5 : i32
  }]

theorem inst_combine_not_or_or_and_no_and_use8   : not_or_or_and_no_and_use8_before  ⊑  not_or_or_and_no_and_use8_combined := by
  unfold not_or_or_and_no_and_use8_before not_or_or_and_no_and_use8_combined
  simp_alive_peephole
  sorry
def and_orn_xor_combined := [llvmfunc|
  llvm.func @and_orn_xor(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.xor %arg0, %0  : i4
    %2 = llvm.and %1, %arg1  : i4
    llvm.return %2 : i4
  }]

theorem inst_combine_and_orn_xor   : and_orn_xor_before  ⊑  and_orn_xor_combined := by
  unfold and_orn_xor_before and_orn_xor_combined
  simp_alive_peephole
  sorry
def and_orn_xor_commute1_combined := [llvmfunc|
  llvm.func @and_orn_xor_commute1(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg0, %1  : vector<2xi4>
    %3 = llvm.and %2, %arg1  : vector<2xi4>
    llvm.return %3 : vector<2xi4>
  }]

theorem inst_combine_and_orn_xor_commute1   : and_orn_xor_commute1_before  ⊑  and_orn_xor_commute1_combined := by
  unfold and_orn_xor_commute1_before and_orn_xor_commute1_combined
  simp_alive_peephole
  sorry
def and_orn_xor_commute2_combined := [llvmfunc|
  llvm.func @and_orn_xor_commute2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %arg0  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.and %2, %arg1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_and_orn_xor_commute2   : and_orn_xor_commute2_before  ⊑  and_orn_xor_commute2_combined := by
  unfold and_orn_xor_commute2_before and_orn_xor_commute2_combined
  simp_alive_peephole
  sorry
def and_orn_xor_commute3_combined := [llvmfunc|
  llvm.func @and_orn_xor_commute3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.and %2, %arg1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_and_orn_xor_commute3   : and_orn_xor_commute3_before  ⊑  and_orn_xor_commute3_combined := by
  unfold and_orn_xor_commute3_before and_orn_xor_commute3_combined
  simp_alive_peephole
  sorry
def and_orn_xor_commute5_combined := [llvmfunc|
  llvm.func @and_orn_xor_commute5(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mul %arg0, %arg0  : i32
    %2 = llvm.mul %arg1, %arg1  : i32
    %3 = llvm.xor %1, %0  : i32
    %4 = llvm.or %2, %3  : i32
    llvm.call @use(%4) : (i32) -> ()
    %5 = llvm.xor %1, %0  : i32
    %6 = llvm.and %2, %5  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_and_orn_xor_commute5   : and_orn_xor_commute5_before  ⊑  and_orn_xor_commute5_combined := by
  unfold and_orn_xor_commute5_before and_orn_xor_commute5_combined
  simp_alive_peephole
  sorry
def and_orn_xor_commute6_combined := [llvmfunc|
  llvm.func @and_orn_xor_commute6(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mul %arg0, %arg0  : i32
    %2 = llvm.mul %arg1, %arg1  : i32
    %3 = llvm.xor %1, %2  : i32
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.xor %1, %0  : i32
    llvm.call @use(%4) : (i32) -> ()
    %5 = llvm.xor %1, %0  : i32
    %6 = llvm.and %2, %5  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_and_orn_xor_commute6   : and_orn_xor_commute6_before  ⊑  and_orn_xor_commute6_combined := by
  unfold and_orn_xor_commute6_before and_orn_xor_commute6_combined
  simp_alive_peephole
  sorry
def and_orn_xor_commute7_combined := [llvmfunc|
  llvm.func @and_orn_xor_commute7(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mul %arg0, %arg0  : i32
    %2 = llvm.mul %arg1, %arg1  : i32
    %3 = llvm.xor %2, %1  : i32
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.xor %1, %0  : i32
    llvm.call @use(%4) : (i32) -> ()
    %5 = llvm.or %2, %4  : i32
    llvm.call @use(%5) : (i32) -> ()
    %6 = llvm.xor %1, %0  : i32
    %7 = llvm.and %2, %6  : i32
    llvm.return %7 : i32
  }]

theorem inst_combine_and_orn_xor_commute7   : and_orn_xor_commute7_before  ⊑  and_orn_xor_commute7_combined := by
  unfold and_orn_xor_commute7_before and_orn_xor_commute7_combined
  simp_alive_peephole
  sorry
def and_orn_xor_commute8_combined := [llvmfunc|
  llvm.func @and_orn_xor_commute8(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mul %arg0, %arg0  : i32
    %2 = llvm.mul %arg1, %arg1  : i32
    %3 = llvm.xor %1, %0  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_and_orn_xor_commute8   : and_orn_xor_commute8_before  ⊑  and_orn_xor_commute8_combined := by
  unfold and_orn_xor_commute8_before and_orn_xor_commute8_combined
  simp_alive_peephole
  sorry
def zext_zext_and_uses_combined := [llvmfunc|
  llvm.func @zext_zext_and_uses(%arg0: i8, %arg1: i8) -> i32 {
    %0 = llvm.zext %arg0 : i8 to i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.zext %arg1 : i8 to i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.and %0, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_zext_zext_and_uses   : zext_zext_and_uses_before  ⊑  zext_zext_and_uses_combined := by
  unfold zext_zext_and_uses_before zext_zext_and_uses_combined
  simp_alive_peephole
  sorry
def sext_sext_or_uses_combined := [llvmfunc|
  llvm.func @sext_sext_or_uses(%arg0: i8, %arg1: i8) -> i32 {
    %0 = llvm.sext %arg0 : i8 to i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.sext %arg1 : i8 to i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.or %0, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_sext_sext_or_uses   : sext_sext_or_uses_before  ⊑  sext_sext_or_uses_combined := by
  unfold sext_sext_or_uses_before sext_sext_or_uses_combined
  simp_alive_peephole
  sorry
def trunc_trunc_xor_uses_combined := [llvmfunc|
  llvm.func @trunc_trunc_xor_uses(%arg0: i65, %arg1: i65) -> i32 {
    %0 = llvm.trunc %arg0 : i65 to i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.trunc %arg1 : i65 to i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.xor %0, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_trunc_trunc_xor_uses   : trunc_trunc_xor_uses_before  ⊑  trunc_trunc_xor_uses_combined := by
  unfold trunc_trunc_xor_uses_before trunc_trunc_xor_uses_combined
  simp_alive_peephole
  sorry
def and_zext_zext_combined := [llvmfunc|
  llvm.func @and_zext_zext(%arg0: i8, %arg1: i4) -> i16 {
    %0 = llvm.zext %arg1 : i4 to i8
    %1 = llvm.and %0, %arg0  : i8
    %2 = llvm.zext %1 : i8 to i16
    llvm.return %2 : i16
  }]

theorem inst_combine_and_zext_zext   : and_zext_zext_before  ⊑  and_zext_zext_combined := by
  unfold and_zext_zext_before and_zext_zext_combined
  simp_alive_peephole
  sorry
def or_zext_zext_combined := [llvmfunc|
  llvm.func @or_zext_zext(%arg0: i8, %arg1: i4) -> i16 {
    %0 = llvm.zext %arg1 : i4 to i8
    %1 = llvm.or %0, %arg0  : i8
    %2 = llvm.zext %1 : i8 to i16
    llvm.return %2 : i16
  }]

theorem inst_combine_or_zext_zext   : or_zext_zext_before  ⊑  or_zext_zext_combined := by
  unfold or_zext_zext_before or_zext_zext_combined
  simp_alive_peephole
  sorry
def xor_zext_zext_combined := [llvmfunc|
  llvm.func @xor_zext_zext(%arg0: vector<2xi8>, %arg1: vector<2xi4>) -> vector<2xi16> {
    %0 = llvm.zext %arg1 : vector<2xi4> to vector<2xi8>
    %1 = llvm.xor %0, %arg0  : vector<2xi8>
    %2 = llvm.zext %1 : vector<2xi8> to vector<2xi16>
    llvm.return %2 : vector<2xi16>
  }]

theorem inst_combine_xor_zext_zext   : xor_zext_zext_before  ⊑  xor_zext_zext_combined := by
  unfold xor_zext_zext_before xor_zext_zext_combined
  simp_alive_peephole
  sorry
def and_sext_sext_combined := [llvmfunc|
  llvm.func @and_sext_sext(%arg0: i8, %arg1: i4) -> i16 {
    %0 = llvm.sext %arg1 : i4 to i8
    %1 = llvm.and %0, %arg0  : i8
    %2 = llvm.sext %1 : i8 to i16
    llvm.return %2 : i16
  }]

theorem inst_combine_and_sext_sext   : and_sext_sext_before  ⊑  and_sext_sext_combined := by
  unfold and_sext_sext_before and_sext_sext_combined
  simp_alive_peephole
  sorry
def or_sext_sext_combined := [llvmfunc|
  llvm.func @or_sext_sext(%arg0: i8, %arg1: i4) -> i16 {
    %0 = llvm.sext %arg1 : i4 to i8
    %1 = llvm.or %0, %arg0  : i8
    %2 = llvm.sext %1 : i8 to i16
    llvm.return %2 : i16
  }]

theorem inst_combine_or_sext_sext   : or_sext_sext_before  ⊑  or_sext_sext_combined := by
  unfold or_sext_sext_before or_sext_sext_combined
  simp_alive_peephole
  sorry
def xor_sext_sext_combined := [llvmfunc|
  llvm.func @xor_sext_sext(%arg0: i8, %arg1: i4) -> i16 {
    %0 = llvm.sext %arg1 : i4 to i8
    %1 = llvm.xor %0, %arg0  : i8
    %2 = llvm.sext %1 : i8 to i16
    llvm.return %2 : i16
  }]

theorem inst_combine_xor_sext_sext   : xor_sext_sext_before  ⊑  xor_sext_sext_combined := by
  unfold xor_sext_sext_before xor_sext_sext_combined
  simp_alive_peephole
  sorry
def and_zext_sext_combined := [llvmfunc|
  llvm.func @and_zext_sext(%arg0: i8, %arg1: i4) -> i16 {
    %0 = llvm.zext %arg0 : i8 to i16
    %1 = llvm.sext %arg1 : i4 to i16
    %2 = llvm.and %0, %1  : i16
    llvm.return %2 : i16
  }]

theorem inst_combine_and_zext_sext   : and_zext_sext_before  ⊑  and_zext_sext_combined := by
  unfold and_zext_sext_before and_zext_sext_combined
  simp_alive_peephole
  sorry
def and_zext_zext_use1_combined := [llvmfunc|
  llvm.func @and_zext_zext_use1(%arg0: i8, %arg1: i4) -> i32 {
    %0 = llvm.zext %arg0 : i8 to i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.zext %arg1 : i4 to i32
    %2 = llvm.and %0, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_and_zext_zext_use1   : and_zext_zext_use1_before  ⊑  and_zext_zext_use1_combined := by
  unfold and_zext_zext_use1_before and_zext_zext_use1_combined
  simp_alive_peephole
  sorry
def or_sext_sext_use1_combined := [llvmfunc|
  llvm.func @or_sext_sext_use1(%arg0: i8, %arg1: i4) -> i32 {
    %0 = llvm.sext %arg0 : i8 to i32
    %1 = llvm.sext %arg1 : i4 to i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.or %0, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_or_sext_sext_use1   : or_sext_sext_use1_before  ⊑  or_sext_sext_use1_combined := by
  unfold or_sext_sext_use1_before or_sext_sext_use1_combined
  simp_alive_peephole
  sorry
def PR56294_combined := [llvmfunc|
  llvm.func @PR56294(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_PR56294   : PR56294_before  ⊑  PR56294_combined := by
  unfold PR56294_before PR56294_combined
  simp_alive_peephole
  sorry
def canonicalize_logic_first_or0_combined := [llvmfunc|
  llvm.func @canonicalize_logic_first_or0(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(112 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.add %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_canonicalize_logic_first_or0   : canonicalize_logic_first_or0_before  ⊑  canonicalize_logic_first_or0_combined := by
  unfold canonicalize_logic_first_or0_before canonicalize_logic_first_or0_combined
  simp_alive_peephole
  sorry
def canonicalize_logic_first_or0_nsw_combined := [llvmfunc|
  llvm.func @canonicalize_logic_first_or0_nsw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(112 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.add %2, %1 overflow<nsw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_canonicalize_logic_first_or0_nsw   : canonicalize_logic_first_or0_nsw_before  ⊑  canonicalize_logic_first_or0_nsw_combined := by
  unfold canonicalize_logic_first_or0_nsw_before canonicalize_logic_first_or0_nsw_combined
  simp_alive_peephole
  sorry
def canonicalize_logic_first_or0_nswnuw_combined := [llvmfunc|
  llvm.func @canonicalize_logic_first_or0_nswnuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(112 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.add %2, %1 overflow<nsw, nuw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_canonicalize_logic_first_or0_nswnuw   : canonicalize_logic_first_or0_nswnuw_before  ⊑  canonicalize_logic_first_or0_nswnuw_combined := by
  unfold canonicalize_logic_first_or0_nswnuw_before canonicalize_logic_first_or0_nswnuw_combined
  simp_alive_peephole
  sorry
def canonicalize_logic_first_or_vector0_combined := [llvmfunc|
  llvm.func @canonicalize_logic_first_or_vector0(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<15> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<112> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.or %arg0, %0  : vector<2xi32>
    %3 = llvm.add %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_canonicalize_logic_first_or_vector0   : canonicalize_logic_first_or_vector0_before  ⊑  canonicalize_logic_first_or_vector0_combined := by
  unfold canonicalize_logic_first_or_vector0_before canonicalize_logic_first_or_vector0_combined
  simp_alive_peephole
  sorry
def canonicalize_logic_first_or_vector0_nsw_combined := [llvmfunc|
  llvm.func @canonicalize_logic_first_or_vector0_nsw(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<15> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<112> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.or %arg0, %0  : vector<2xi32>
    %3 = llvm.add %2, %1 overflow<nsw>  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_canonicalize_logic_first_or_vector0_nsw   : canonicalize_logic_first_or_vector0_nsw_before  ⊑  canonicalize_logic_first_or_vector0_nsw_combined := by
  unfold canonicalize_logic_first_or_vector0_nsw_before canonicalize_logic_first_or_vector0_nsw_combined
  simp_alive_peephole
  sorry
def canonicalize_logic_first_or_vector0_nswnuw_combined := [llvmfunc|
  llvm.func @canonicalize_logic_first_or_vector0_nswnuw(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<15> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<112> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.or %arg0, %0  : vector<2xi32>
    %3 = llvm.add %2, %1 overflow<nsw, nuw>  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_canonicalize_logic_first_or_vector0_nswnuw   : canonicalize_logic_first_or_vector0_nswnuw_before  ⊑  canonicalize_logic_first_or_vector0_nswnuw_combined := by
  unfold canonicalize_logic_first_or_vector0_nswnuw_before canonicalize_logic_first_or_vector0_nswnuw_combined
  simp_alive_peephole
  sorry
def canonicalize_logic_first_or_vector1_combined := [llvmfunc|
  llvm.func @canonicalize_logic_first_or_vector1(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[-8388608, 2071986176]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[32783, 2063]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %arg0, %0  : vector<2xi32>
    %3 = llvm.or %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_canonicalize_logic_first_or_vector1   : canonicalize_logic_first_or_vector1_before  ⊑  canonicalize_logic_first_or_vector1_combined := by
  unfold canonicalize_logic_first_or_vector1_before canonicalize_logic_first_or_vector1_combined
  simp_alive_peephole
  sorry
def canonicalize_logic_first_or_vector1_nsw_combined := [llvmfunc|
  llvm.func @canonicalize_logic_first_or_vector1_nsw(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[-8388608, 2071986176]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[32783, 2063]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %arg0, %0 overflow<nsw>  : vector<2xi32>
    %3 = llvm.or %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_canonicalize_logic_first_or_vector1_nsw   : canonicalize_logic_first_or_vector1_nsw_before  ⊑  canonicalize_logic_first_or_vector1_nsw_combined := by
  unfold canonicalize_logic_first_or_vector1_nsw_before canonicalize_logic_first_or_vector1_nsw_combined
  simp_alive_peephole
  sorry
def canonicalize_logic_first_or_vector1_nswnuw_combined := [llvmfunc|
  llvm.func @canonicalize_logic_first_or_vector1_nswnuw(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[-8388608, 2071986176]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[32783, 2063]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %arg0, %0 overflow<nsw, nuw>  : vector<2xi32>
    %3 = llvm.or %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_canonicalize_logic_first_or_vector1_nswnuw   : canonicalize_logic_first_or_vector1_nswnuw_before  ⊑  canonicalize_logic_first_or_vector1_nswnuw_combined := by
  unfold canonicalize_logic_first_or_vector1_nswnuw_before canonicalize_logic_first_or_vector1_nswnuw_combined
  simp_alive_peephole
  sorry
def canonicalize_logic_first_or_vector2_combined := [llvmfunc|
  llvm.func @canonicalize_logic_first_or_vector2(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[2147483632, 2147483640]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[32783, 2063]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %arg0, %0  : vector<2xi32>
    %3 = llvm.or %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_canonicalize_logic_first_or_vector2   : canonicalize_logic_first_or_vector2_before  ⊑  canonicalize_logic_first_or_vector2_combined := by
  unfold canonicalize_logic_first_or_vector2_before canonicalize_logic_first_or_vector2_combined
  simp_alive_peephole
  sorry
def canonicalize_logic_first_or_mult_use1_combined := [llvmfunc|
  llvm.func @canonicalize_logic_first_or_mult_use1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(112 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.or %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_canonicalize_logic_first_or_mult_use1   : canonicalize_logic_first_or_mult_use1_before  ⊑  canonicalize_logic_first_or_mult_use1_combined := by
  unfold canonicalize_logic_first_or_mult_use1_before canonicalize_logic_first_or_mult_use1_combined
  simp_alive_peephole
  sorry
def canonicalize_logic_first_or_bad_constraints2_combined := [llvmfunc|
  llvm.func @canonicalize_logic_first_or_bad_constraints2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(112 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.or %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_canonicalize_logic_first_or_bad_constraints2   : canonicalize_logic_first_or_bad_constraints2_before  ⊑  canonicalize_logic_first_or_bad_constraints2_combined := by
  unfold canonicalize_logic_first_or_bad_constraints2_before canonicalize_logic_first_or_bad_constraints2_combined
  simp_alive_peephole
  sorry
def canonicalize_logic_first_and0_combined := [llvmfunc|
  llvm.func @canonicalize_logic_first_and0(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-10 : i8) : i8
    %1 = llvm.mlir.constant(48 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.add %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_canonicalize_logic_first_and0   : canonicalize_logic_first_and0_before  ⊑  canonicalize_logic_first_and0_combined := by
  unfold canonicalize_logic_first_and0_before canonicalize_logic_first_and0_combined
  simp_alive_peephole
  sorry
def canonicalize_logic_first_and0_nsw_combined := [llvmfunc|
  llvm.func @canonicalize_logic_first_and0_nsw(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-10 : i8) : i8
    %1 = llvm.mlir.constant(48 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.add %2, %1 overflow<nsw>  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_canonicalize_logic_first_and0_nsw   : canonicalize_logic_first_and0_nsw_before  ⊑  canonicalize_logic_first_and0_nsw_combined := by
  unfold canonicalize_logic_first_and0_nsw_before canonicalize_logic_first_and0_nsw_combined
  simp_alive_peephole
  sorry
def canonicalize_logic_first_and0_nswnuw_combined := [llvmfunc|
  llvm.func @canonicalize_logic_first_and0_nswnuw(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-10 : i8) : i8
    %1 = llvm.mlir.constant(48 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.add %2, %1 overflow<nsw, nuw>  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_canonicalize_logic_first_and0_nswnuw   : canonicalize_logic_first_and0_nswnuw_before  ⊑  canonicalize_logic_first_and0_nswnuw_combined := by
  unfold canonicalize_logic_first_and0_nswnuw_before canonicalize_logic_first_and0_nswnuw_combined
  simp_alive_peephole
  sorry
def canonicalize_logic_first_and_vector0_combined := [llvmfunc|
  llvm.func @canonicalize_logic_first_and_vector0(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-10> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<48> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.and %arg0, %0  : vector<2xi8>
    %3 = llvm.add %2, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_canonicalize_logic_first_and_vector0   : canonicalize_logic_first_and_vector0_before  ⊑  canonicalize_logic_first_and_vector0_combined := by
  unfold canonicalize_logic_first_and_vector0_before canonicalize_logic_first_and_vector0_combined
  simp_alive_peephole
  sorry
def canonicalize_logic_first_and_vector0_nsw_combined := [llvmfunc|
  llvm.func @canonicalize_logic_first_and_vector0_nsw(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-10> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<48> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.and %arg0, %0  : vector<2xi8>
    %3 = llvm.add %2, %1 overflow<nsw>  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_canonicalize_logic_first_and_vector0_nsw   : canonicalize_logic_first_and_vector0_nsw_before  ⊑  canonicalize_logic_first_and_vector0_nsw_combined := by
  unfold canonicalize_logic_first_and_vector0_nsw_before canonicalize_logic_first_and_vector0_nsw_combined
  simp_alive_peephole
  sorry
def canonicalize_logic_first_and_vector0_nswnuw_combined := [llvmfunc|
  llvm.func @canonicalize_logic_first_and_vector0_nswnuw(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-10> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<48> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.and %arg0, %0  : vector<2xi8>
    %3 = llvm.add %2, %1 overflow<nsw, nuw>  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_canonicalize_logic_first_and_vector0_nswnuw   : canonicalize_logic_first_and_vector0_nswnuw_before  ⊑  canonicalize_logic_first_and_vector0_nswnuw_combined := by
  unfold canonicalize_logic_first_and_vector0_nswnuw_before canonicalize_logic_first_and_vector0_nswnuw_combined
  simp_alive_peephole
  sorry
def canonicalize_logic_first_and_vector1_combined := [llvmfunc|
  llvm.func @canonicalize_logic_first_and_vector1(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[48, 32]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[-10, -4]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0  : vector<2xi8>
    %3 = llvm.and %2, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_canonicalize_logic_first_and_vector1   : canonicalize_logic_first_and_vector1_before  ⊑  canonicalize_logic_first_and_vector1_combined := by
  unfold canonicalize_logic_first_and_vector1_before canonicalize_logic_first_and_vector1_combined
  simp_alive_peephole
  sorry
def canonicalize_logic_first_and_vector2_combined := [llvmfunc|
  llvm.func @canonicalize_logic_first_and_vector2(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<612368384> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[-65536, -32768]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %arg0, %0  : vector<2xi32>
    %3 = llvm.and %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_canonicalize_logic_first_and_vector2   : canonicalize_logic_first_and_vector2_before  ⊑  canonicalize_logic_first_and_vector2_combined := by
  unfold canonicalize_logic_first_and_vector2_before canonicalize_logic_first_and_vector2_combined
  simp_alive_peephole
  sorry
def canonicalize_logic_first_and_vector3_combined := [llvmfunc|
  llvm.func @canonicalize_logic_first_and_vector3(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[32768, 16384]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[-65536, -32768]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %arg0, %0  : vector<2xi32>
    %3 = llvm.and %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_canonicalize_logic_first_and_vector3   : canonicalize_logic_first_and_vector3_before  ⊑  canonicalize_logic_first_and_vector3_combined := by
  unfold canonicalize_logic_first_and_vector3_before canonicalize_logic_first_and_vector3_combined
  simp_alive_peephole
  sorry
def canonicalize_logic_first_and_mult_use1_combined := [llvmfunc|
  llvm.func @canonicalize_logic_first_and_mult_use1(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(48 : i8) : i8
    %1 = llvm.mlir.constant(-10 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    llvm.call @use_i8(%2) : (i8) -> ()
    %3 = llvm.and %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_canonicalize_logic_first_and_mult_use1   : canonicalize_logic_first_and_mult_use1_before  ⊑  canonicalize_logic_first_and_mult_use1_combined := by
  unfold canonicalize_logic_first_and_mult_use1_before canonicalize_logic_first_and_mult_use1_combined
  simp_alive_peephole
  sorry
def canonicalize_logic_first_and_bad_constraints2_combined := [llvmfunc|
  llvm.func @canonicalize_logic_first_and_bad_constraints2(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(48 : i8) : i8
    %1 = llvm.mlir.constant(-26 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.and %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_canonicalize_logic_first_and_bad_constraints2   : canonicalize_logic_first_and_bad_constraints2_before  ⊑  canonicalize_logic_first_and_bad_constraints2_combined := by
  unfold canonicalize_logic_first_and_bad_constraints2_before canonicalize_logic_first_and_bad_constraints2_combined
  simp_alive_peephole
  sorry
def canonicalize_logic_first_xor_0_combined := [llvmfunc|
  llvm.func @canonicalize_logic_first_xor_0(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(31 : i8) : i8
    %1 = llvm.mlir.constant(96 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.add %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_canonicalize_logic_first_xor_0   : canonicalize_logic_first_xor_0_before  ⊑  canonicalize_logic_first_xor_0_combined := by
  unfold canonicalize_logic_first_xor_0_before canonicalize_logic_first_xor_0_combined
  simp_alive_peephole
  sorry
def canonicalize_logic_first_xor_0_nsw_combined := [llvmfunc|
  llvm.func @canonicalize_logic_first_xor_0_nsw(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(31 : i8) : i8
    %1 = llvm.mlir.constant(96 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.add %2, %1 overflow<nsw>  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_canonicalize_logic_first_xor_0_nsw   : canonicalize_logic_first_xor_0_nsw_before  ⊑  canonicalize_logic_first_xor_0_nsw_combined := by
  unfold canonicalize_logic_first_xor_0_nsw_before canonicalize_logic_first_xor_0_nsw_combined
  simp_alive_peephole
  sorry
def canonicalize_logic_first_xor_0_nswnuw_combined := [llvmfunc|
  llvm.func @canonicalize_logic_first_xor_0_nswnuw(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(31 : i8) : i8
    %1 = llvm.mlir.constant(96 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.add %2, %1 overflow<nsw, nuw>  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_canonicalize_logic_first_xor_0_nswnuw   : canonicalize_logic_first_xor_0_nswnuw_before  ⊑  canonicalize_logic_first_xor_0_nswnuw_combined := by
  unfold canonicalize_logic_first_xor_0_nswnuw_before canonicalize_logic_first_xor_0_nswnuw_combined
  simp_alive_peephole
  sorry
def canonicalize_logic_first_xor_vector0_combined := [llvmfunc|
  llvm.func @canonicalize_logic_first_xor_vector0(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<32783> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-8388608> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.xor %arg0, %0  : vector<2xi32>
    %3 = llvm.add %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_canonicalize_logic_first_xor_vector0   : canonicalize_logic_first_xor_vector0_before  ⊑  canonicalize_logic_first_xor_vector0_combined := by
  unfold canonicalize_logic_first_xor_vector0_before canonicalize_logic_first_xor_vector0_combined
  simp_alive_peephole
  sorry
def canonicalize_logic_first_xor_vector0_nsw_combined := [llvmfunc|
  llvm.func @canonicalize_logic_first_xor_vector0_nsw(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<32783> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-8388608> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.xor %arg0, %0  : vector<2xi32>
    %3 = llvm.add %2, %1 overflow<nsw>  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_canonicalize_logic_first_xor_vector0_nsw   : canonicalize_logic_first_xor_vector0_nsw_before  ⊑  canonicalize_logic_first_xor_vector0_nsw_combined := by
  unfold canonicalize_logic_first_xor_vector0_nsw_before canonicalize_logic_first_xor_vector0_nsw_combined
  simp_alive_peephole
  sorry
def canonicalize_logic_first_xor_vector0_nswnuw_combined := [llvmfunc|
  llvm.func @canonicalize_logic_first_xor_vector0_nswnuw(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<32783> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-8388608> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.xor %arg0, %0  : vector<2xi32>
    %3 = llvm.add %2, %1 overflow<nsw, nuw>  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_canonicalize_logic_first_xor_vector0_nswnuw   : canonicalize_logic_first_xor_vector0_nswnuw_before  ⊑  canonicalize_logic_first_xor_vector0_nswnuw_combined := by
  unfold canonicalize_logic_first_xor_vector0_nswnuw_before canonicalize_logic_first_xor_vector0_nswnuw_combined
  simp_alive_peephole
  sorry
def canonicalize_logic_first_xor_vector1_combined := [llvmfunc|
  llvm.func @canonicalize_logic_first_xor_vector1(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[-8388608, 2071986176]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[32783, 2063]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %arg0, %0  : vector<2xi32>
    %3 = llvm.xor %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_canonicalize_logic_first_xor_vector1   : canonicalize_logic_first_xor_vector1_before  ⊑  canonicalize_logic_first_xor_vector1_combined := by
  unfold canonicalize_logic_first_xor_vector1_before canonicalize_logic_first_xor_vector1_combined
  simp_alive_peephole
  sorry
def canonicalize_logic_first_xor_vector2_combined := [llvmfunc|
  llvm.func @canonicalize_logic_first_xor_vector2(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[2147483632, 2147483640]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[32783, 2063]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %arg0, %0  : vector<2xi32>
    %3 = llvm.xor %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_canonicalize_logic_first_xor_vector2   : canonicalize_logic_first_xor_vector2_before  ⊑  canonicalize_logic_first_xor_vector2_combined := by
  unfold canonicalize_logic_first_xor_vector2_before canonicalize_logic_first_xor_vector2_combined
  simp_alive_peephole
  sorry
def canonicalize_logic_first_xor_mult_use1_combined := [llvmfunc|
  llvm.func @canonicalize_logic_first_xor_mult_use1(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(96 : i8) : i8
    %1 = llvm.mlir.constant(31 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    llvm.call @use_i8(%2) : (i8) -> ()
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_canonicalize_logic_first_xor_mult_use1   : canonicalize_logic_first_xor_mult_use1_before  ⊑  canonicalize_logic_first_xor_mult_use1_combined := by
  unfold canonicalize_logic_first_xor_mult_use1_before canonicalize_logic_first_xor_mult_use1_combined
  simp_alive_peephole
  sorry
def canonicalize_logic_first_xor_bad_constants2_combined := [llvmfunc|
  llvm.func @canonicalize_logic_first_xor_bad_constants2(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(96 : i8) : i8
    %1 = llvm.mlir.constant(32 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_canonicalize_logic_first_xor_bad_constants2   : canonicalize_logic_first_xor_bad_constants2_before  ⊑  canonicalize_logic_first_xor_bad_constants2_combined := by
  unfold canonicalize_logic_first_xor_bad_constants2_before canonicalize_logic_first_xor_bad_constants2_combined
  simp_alive_peephole
  sorry
def canonicalize_logic_first_constexpr_combined := [llvmfunc|
  llvm.func @canonicalize_logic_first_constexpr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(48 : i32) : i32
    %1 = llvm.mlir.addressof @g : !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i32
    %3 = llvm.add %2, %0  : i32
    %4 = llvm.mlir.constant(-10 : i32) : i32
    %5 = llvm.and %3, %4  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_canonicalize_logic_first_constexpr   : canonicalize_logic_first_constexpr_before  ⊑  canonicalize_logic_first_constexpr_combined := by
  unfold canonicalize_logic_first_constexpr_before canonicalize_logic_first_constexpr_combined
  simp_alive_peephole
  sorry
def canonicalize_logic_first_constexpr_nuw_combined := [llvmfunc|
  llvm.func @canonicalize_logic_first_constexpr_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(48 : i32) : i32
    %1 = llvm.mlir.addressof @g : !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i32
    %3 = llvm.add %2, %0  : i32
    %4 = llvm.mlir.constant(-10 : i32) : i32
    %5 = llvm.and %3, %4  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_canonicalize_logic_first_constexpr_nuw   : canonicalize_logic_first_constexpr_nuw_before  ⊑  canonicalize_logic_first_constexpr_nuw_combined := by
  unfold canonicalize_logic_first_constexpr_nuw_before canonicalize_logic_first_constexpr_nuw_combined
  simp_alive_peephole
  sorry
def test_and_xor_freely_invertable_combined := [llvmfunc|
  llvm.func @test_and_xor_freely_invertable(%arg0: i32, %arg1: i32, %arg2: i1) -> i1 {
    %0 = llvm.icmp "sle" %arg0, %arg1 : i32
    %1 = llvm.and %0, %arg2  : i1
    llvm.return %1 : i1
  }]

theorem inst_combine_test_and_xor_freely_invertable   : test_and_xor_freely_invertable_before  ⊑  test_and_xor_freely_invertable_combined := by
  unfold test_and_xor_freely_invertable_before test_and_xor_freely_invertable_combined
  simp_alive_peephole
  sorry
def test_and_xor_freely_invertable_multiuse_combined := [llvmfunc|
  llvm.func @test_and_xor_freely_invertable_multiuse(%arg0: i32, %arg1: i32, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i32
    llvm.call @use_i1(%1) : (i1) -> ()
    %2 = llvm.xor %1, %0  : i1
    %3 = llvm.and %2, %arg2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_test_and_xor_freely_invertable_multiuse   : test_and_xor_freely_invertable_multiuse_before  ⊑  test_and_xor_freely_invertable_multiuse_combined := by
  unfold test_and_xor_freely_invertable_multiuse_before test_and_xor_freely_invertable_multiuse_combined
  simp_alive_peephole
  sorry
