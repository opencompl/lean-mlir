import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  truncating-saturate
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def testi16i8_before := [llvmfunc|
  llvm.func @testi16i8(%arg0: i16) -> i8 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.mlir.constant(15 : i16) : i16
    %3 = llvm.mlir.constant(127 : i8) : i8
    %4 = llvm.lshr %arg0, %0  : i16
    %5 = llvm.trunc %4 : i16 to i8
    %6 = llvm.trunc %arg0 : i16 to i8
    %7 = llvm.ashr %6, %1  : i8
    %8 = llvm.icmp "eq" %7, %5 : i8
    %9 = llvm.ashr %arg0, %2  : i16
    %10 = llvm.trunc %9 : i16 to i8
    %11 = llvm.xor %10, %3  : i8
    %12 = llvm.select %8, %6, %11 : i1, i8
    llvm.return %12 : i8
  }]

def testi64i32_before := [llvmfunc|
  llvm.func @testi64i32(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.mlir.constant(63 : i64) : i64
    %3 = llvm.mlir.constant(2147483647 : i32) : i32
    %4 = llvm.lshr %arg0, %0  : i64
    %5 = llvm.trunc %4 : i64 to i32
    %6 = llvm.trunc %arg0 : i64 to i32
    %7 = llvm.ashr %6, %1  : i32
    %8 = llvm.icmp "eq" %7, %5 : i32
    %9 = llvm.ashr %arg0, %2  : i64
    %10 = llvm.trunc %9 : i64 to i32
    %11 = llvm.xor %10, %3  : i32
    %12 = llvm.select %8, %6, %11 : i1, i32
    llvm.return %12 : i32
  }]

def testi32i16i8_before := [llvmfunc|
  llvm.func @testi32i16i8(%arg0: i32) -> i16 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(256 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(127 : i16) : i16
    %4 = llvm.mlir.constant(-128 : i16) : i16
    %5 = llvm.add %arg0, %0  : i32
    %6 = llvm.icmp "ult" %5, %1 : i32
    %7 = llvm.trunc %arg0 : i32 to i16
    %8 = llvm.icmp "sgt" %arg0, %2 : i32
    %9 = llvm.select %8, %3, %4 : i1, i16
    %10 = llvm.select %6, %7, %9 : i1, i16
    llvm.return %10 : i16
  }]

def testv4i32i16i8_before := [llvmfunc|
  llvm.func @testv4i32i16i8(%arg0: vector<4xi32>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(dense<128> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<256> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.mlir.constant(dense<127> : vector<4xi16>) : vector<4xi16>
    %4 = llvm.mlir.constant(dense<-128> : vector<4xi16>) : vector<4xi16>
    %5 = llvm.add %arg0, %0  : vector<4xi32>
    %6 = llvm.icmp "ult" %5, %1 : vector<4xi32>
    %7 = llvm.trunc %arg0 : vector<4xi32> to vector<4xi16>
    %8 = llvm.icmp "sgt" %arg0, %2 : vector<4xi32>
    %9 = llvm.select %8, %3, %4 : vector<4xi1>, vector<4xi16>
    %10 = llvm.select %6, %7, %9 : vector<4xi1>, vector<4xi16>
    llvm.return %10 : vector<4xi16>
  }]

def testi32i32i8_before := [llvmfunc|
  llvm.func @testi32i32i8(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(256 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(127 : i32) : i32
    %4 = llvm.mlir.constant(-128 : i32) : i32
    %5 = llvm.add %arg0, %0  : i32
    %6 = llvm.icmp "ult" %5, %1 : i32
    %7 = llvm.icmp "sgt" %arg0, %2 : i32
    %8 = llvm.select %7, %3, %4 : i1, i32
    %9 = llvm.select %6, %arg0, %8 : i1, i32
    llvm.return %9 : i32
  }]

def test_truncfirst_before := [llvmfunc|
  llvm.func @test_truncfirst(%arg0: i32) -> i16 {
    %0 = llvm.mlir.constant(128 : i16) : i16
    %1 = llvm.mlir.constant(256 : i16) : i16
    %2 = llvm.mlir.constant(-1 : i16) : i16
    %3 = llvm.mlir.constant(127 : i16) : i16
    %4 = llvm.mlir.constant(-128 : i16) : i16
    %5 = llvm.trunc %arg0 : i32 to i16
    %6 = llvm.add %5, %0  : i16
    %7 = llvm.icmp "ult" %6, %1 : i16
    %8 = llvm.icmp "sgt" %5, %2 : i16
    %9 = llvm.select %8, %3, %4 : i1, i16
    %10 = llvm.select %7, %5, %9 : i1, i16
    llvm.return %10 : i16
  }]

def testtrunclowhigh_before := [llvmfunc|
  llvm.func @testtrunclowhigh(%arg0: i32, %arg1: i16, %arg2: i16) -> i16 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(256 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.add %arg0, %0  : i32
    %4 = llvm.icmp "ult" %3, %1 : i32
    %5 = llvm.trunc %arg0 : i32 to i16
    %6 = llvm.icmp "sgt" %arg0, %2 : i32
    %7 = llvm.select %6, %arg2, %arg1 : i1, i16
    %8 = llvm.select %4, %5, %7 : i1, i16
    llvm.return %8 : i16
  }]

def testi64i32addsat_before := [llvmfunc|
  llvm.func @testi64i32addsat(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.mlir.constant(63 : i64) : i64
    %3 = llvm.mlir.constant(2147483647 : i32) : i32
    %4 = llvm.sext %arg0 : i32 to i64
    %5 = llvm.sext %arg1 : i32 to i64
    %6 = llvm.add %4, %5  : i64
    %7 = llvm.lshr %6, %0  : i64
    %8 = llvm.trunc %7 : i64 to i32
    %9 = llvm.trunc %6 : i64 to i32
    %10 = llvm.ashr %9, %1  : i32
    %11 = llvm.icmp "eq" %10, %8 : i32
    %12 = llvm.ashr %6, %2  : i64
    %13 = llvm.trunc %12 : i64 to i32
    %14 = llvm.xor %13, %3  : i32
    %15 = llvm.select %11, %9, %14 : i1, i32
    llvm.return %15 : i32
  }]

def testv4i16i8_before := [llvmfunc|
  llvm.func @testv4i16i8(%arg0: vector<4xi16>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<8> : vector<4xi16>) : vector<4xi16>
    %1 = llvm.mlir.constant(dense<7> : vector<4xi8>) : vector<4xi8>
    %2 = llvm.mlir.constant(dense<15> : vector<4xi16>) : vector<4xi16>
    %3 = llvm.mlir.constant(dense<127> : vector<4xi8>) : vector<4xi8>
    %4 = llvm.lshr %arg0, %0  : vector<4xi16>
    %5 = llvm.trunc %4 : vector<4xi16> to vector<4xi8>
    %6 = llvm.trunc %arg0 : vector<4xi16> to vector<4xi8>
    %7 = llvm.ashr %6, %1  : vector<4xi8>
    %8 = llvm.icmp "eq" %7, %5 : vector<4xi8>
    %9 = llvm.ashr %arg0, %2  : vector<4xi16>
    %10 = llvm.trunc %9 : vector<4xi16> to vector<4xi8>
    %11 = llvm.xor %10, %3  : vector<4xi8>
    %12 = llvm.select %8, %6, %11 : vector<4xi1>, vector<4xi8>
    llvm.return %12 : vector<4xi8>
  }]

def testv4i16i8add_before := [llvmfunc|
  llvm.func @testv4i16i8add(%arg0: vector<4xi8>, %arg1: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<8> : vector<4xi16>) : vector<4xi16>
    %1 = llvm.mlir.constant(dense<7> : vector<4xi8>) : vector<4xi8>
    %2 = llvm.mlir.constant(dense<15> : vector<4xi16>) : vector<4xi16>
    %3 = llvm.mlir.constant(dense<127> : vector<4xi8>) : vector<4xi8>
    %4 = llvm.sext %arg0 : vector<4xi8> to vector<4xi16>
    %5 = llvm.sext %arg1 : vector<4xi8> to vector<4xi16>
    %6 = llvm.add %4, %5  : vector<4xi16>
    %7 = llvm.lshr %6, %0  : vector<4xi16>
    %8 = llvm.trunc %7 : vector<4xi16> to vector<4xi8>
    %9 = llvm.trunc %6 : vector<4xi16> to vector<4xi8>
    %10 = llvm.ashr %9, %1  : vector<4xi8>
    %11 = llvm.icmp "eq" %10, %8 : vector<4xi8>
    %12 = llvm.ashr %6, %2  : vector<4xi16>
    %13 = llvm.trunc %12 : vector<4xi16> to vector<4xi8>
    %14 = llvm.xor %13, %3  : vector<4xi8>
    %15 = llvm.select %11, %9, %14 : vector<4xi1>, vector<4xi8>
    llvm.return %15 : vector<4xi8>
  }]

def testi16i8_revcmp_before := [llvmfunc|
  llvm.func @testi16i8_revcmp(%arg0: i16) -> i8 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.mlir.constant(15 : i16) : i16
    %3 = llvm.mlir.constant(127 : i8) : i8
    %4 = llvm.lshr %arg0, %0  : i16
    %5 = llvm.trunc %4 : i16 to i8
    %6 = llvm.trunc %arg0 : i16 to i8
    %7 = llvm.ashr %6, %1  : i8
    %8 = llvm.icmp "eq" %5, %7 : i8
    %9 = llvm.ashr %arg0, %2  : i16
    %10 = llvm.trunc %9 : i16 to i8
    %11 = llvm.xor %10, %3  : i8
    %12 = llvm.select %8, %6, %11 : i1, i8
    llvm.return %12 : i8
  }]

def testi16i8_revselect_before := [llvmfunc|
  llvm.func @testi16i8_revselect(%arg0: i16) -> i8 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.mlir.constant(15 : i16) : i16
    %3 = llvm.mlir.constant(127 : i8) : i8
    %4 = llvm.lshr %arg0, %0  : i16
    %5 = llvm.trunc %4 : i16 to i8
    %6 = llvm.trunc %arg0 : i16 to i8
    %7 = llvm.ashr %6, %1  : i8
    %8 = llvm.icmp "ne" %5, %7 : i8
    %9 = llvm.ashr %arg0, %2  : i16
    %10 = llvm.trunc %9 : i16 to i8
    %11 = llvm.xor %10, %3  : i8
    %12 = llvm.select %8, %11, %6 : i1, i8
    llvm.return %12 : i8
  }]

def testi32i8_before := [llvmfunc|
  llvm.func @testi32i8(%arg0: i32) -> i8 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(127 : i8) : i8
    %4 = llvm.lshr %arg0, %0  : i32
    %5 = llvm.trunc %4 : i32 to i8
    %6 = llvm.trunc %arg0 : i32 to i8
    %7 = llvm.ashr %6, %1  : i8
    %8 = llvm.icmp "eq" %7, %5 : i8
    %9 = llvm.ashr %arg0, %2  : i32
    %10 = llvm.trunc %9 : i32 to i8
    %11 = llvm.xor %10, %3  : i8
    %12 = llvm.select %8, %6, %11 : i1, i8
    llvm.return %12 : i8
  }]

def differentconsts_before := [llvmfunc|
  llvm.func @differentconsts(%arg0: i32, %arg1: i16, %arg2: i16) -> i16 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(256 : i16) : i16
    %2 = llvm.mlir.constant(-1 : i16) : i16
    %3 = llvm.mlir.constant(16 : i32) : i32
    %4 = llvm.mlir.constant(144 : i32) : i32
    %5 = llvm.icmp "slt" %arg0, %0 : i32
    %6 = llvm.select %5, %1, %2 : i1, i16
    %7 = llvm.add %arg0, %3  : i32
    %8 = llvm.icmp "ult" %7, %4 : i32
    %9 = llvm.trunc %arg0 : i32 to i16
    %10 = llvm.select %8, %9, %6 : i1, i16
    llvm.return %10 : i16
  }]

def badimm1_before := [llvmfunc|
  llvm.func @badimm1(%arg0: i16) -> i8 {
    %0 = llvm.mlir.constant(9 : i16) : i16
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.mlir.constant(15 : i16) : i16
    %3 = llvm.mlir.constant(127 : i8) : i8
    %4 = llvm.lshr %arg0, %0  : i16
    %5 = llvm.trunc %4 : i16 to i8
    %6 = llvm.trunc %arg0 : i16 to i8
    %7 = llvm.ashr %6, %1  : i8
    %8 = llvm.icmp "eq" %7, %5 : i8
    %9 = llvm.ashr %arg0, %2  : i16
    %10 = llvm.trunc %9 : i16 to i8
    %11 = llvm.xor %10, %3  : i8
    %12 = llvm.select %8, %6, %11 : i1, i8
    llvm.return %12 : i8
  }]

def badimm2_before := [llvmfunc|
  llvm.func @badimm2(%arg0: i16) -> i8 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.mlir.constant(15 : i16) : i16
    %3 = llvm.mlir.constant(127 : i8) : i8
    %4 = llvm.lshr %arg0, %0  : i16
    %5 = llvm.trunc %4 : i16 to i8
    %6 = llvm.trunc %arg0 : i16 to i8
    %7 = llvm.ashr %6, %1  : i8
    %8 = llvm.icmp "eq" %7, %5 : i8
    %9 = llvm.ashr %arg0, %2  : i16
    %10 = llvm.trunc %9 : i16 to i8
    %11 = llvm.xor %10, %3  : i8
    %12 = llvm.select %8, %6, %11 : i1, i8
    llvm.return %12 : i8
  }]

def badimm3_before := [llvmfunc|
  llvm.func @badimm3(%arg0: i16) -> i8 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.mlir.constant(14 : i16) : i16
    %3 = llvm.mlir.constant(127 : i8) : i8
    %4 = llvm.lshr %arg0, %0  : i16
    %5 = llvm.trunc %4 : i16 to i8
    %6 = llvm.trunc %arg0 : i16 to i8
    %7 = llvm.ashr %6, %1  : i8
    %8 = llvm.icmp "eq" %7, %5 : i8
    %9 = llvm.ashr %arg0, %2  : i16
    %10 = llvm.trunc %9 : i16 to i8
    %11 = llvm.xor %10, %3  : i8
    %12 = llvm.select %8, %6, %11 : i1, i8
    llvm.return %12 : i8
  }]

def badimm4_before := [llvmfunc|
  llvm.func @badimm4(%arg0: i16) -> i8 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.mlir.constant(15 : i16) : i16
    %3 = llvm.mlir.constant(126 : i8) : i8
    %4 = llvm.lshr %arg0, %0  : i16
    %5 = llvm.trunc %4 : i16 to i8
    %6 = llvm.trunc %arg0 : i16 to i8
    %7 = llvm.ashr %6, %1  : i8
    %8 = llvm.icmp "eq" %7, %5 : i8
    %9 = llvm.ashr %arg0, %2  : i16
    %10 = llvm.trunc %9 : i16 to i8
    %11 = llvm.xor %10, %3  : i8
    %12 = llvm.select %8, %6, %11 : i1, i8
    llvm.return %12 : i8
  }]

def oneusexor_before := [llvmfunc|
  llvm.func @oneusexor(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.mlir.constant(63 : i64) : i64
    %3 = llvm.mlir.constant(2147483647 : i32) : i32
    %4 = llvm.lshr %arg0, %0  : i64
    %5 = llvm.trunc %4 : i64 to i32
    %6 = llvm.trunc %arg0 : i64 to i32
    %7 = llvm.ashr %6, %1  : i32
    %8 = llvm.icmp "eq" %7, %5 : i32
    %9 = llvm.ashr %arg0, %2  : i64
    %10 = llvm.trunc %9 : i64 to i32
    %11 = llvm.xor %10, %3  : i32
    %12 = llvm.select %8, %6, %11 : i1, i32
    llvm.call @use(%11) : (i32) -> ()
    llvm.return %12 : i32
  }]

def oneuseconv_before := [llvmfunc|
  llvm.func @oneuseconv(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.mlir.constant(63 : i64) : i64
    %3 = llvm.mlir.constant(2147483647 : i32) : i32
    %4 = llvm.lshr %arg0, %0  : i64
    %5 = llvm.trunc %4 : i64 to i32
    %6 = llvm.trunc %arg0 : i64 to i32
    %7 = llvm.ashr %6, %1  : i32
    %8 = llvm.icmp "eq" %7, %5 : i32
    %9 = llvm.ashr %arg0, %2  : i64
    %10 = llvm.trunc %9 : i64 to i32
    %11 = llvm.xor %10, %3  : i32
    %12 = llvm.select %8, %6, %11 : i1, i32
    llvm.call @use(%6) : (i32) -> ()
    llvm.return %12 : i32
  }]

def oneusecmp_before := [llvmfunc|
  llvm.func @oneusecmp(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.mlir.constant(63 : i64) : i64
    %3 = llvm.mlir.constant(2147483647 : i32) : i32
    %4 = llvm.lshr %arg0, %0  : i64
    %5 = llvm.trunc %4 : i64 to i32
    %6 = llvm.trunc %arg0 : i64 to i32
    %7 = llvm.ashr %6, %1  : i32
    %8 = llvm.icmp "eq" %7, %5 : i32
    %9 = llvm.ashr %arg0, %2  : i64
    %10 = llvm.trunc %9 : i64 to i32
    %11 = llvm.xor %10, %3  : i32
    %12 = llvm.select %8, %6, %11 : i1, i32
    llvm.call @use1(%8) : (i1) -> ()
    llvm.return %12 : i32
  }]

def oneuseboth_before := [llvmfunc|
  llvm.func @oneuseboth(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.mlir.constant(63 : i64) : i64
    %3 = llvm.mlir.constant(2147483647 : i32) : i32
    %4 = llvm.lshr %arg0, %0  : i64
    %5 = llvm.trunc %4 : i64 to i32
    %6 = llvm.trunc %arg0 : i64 to i32
    %7 = llvm.ashr %6, %1  : i32
    %8 = llvm.icmp "eq" %7, %5 : i32
    %9 = llvm.ashr %arg0, %2  : i64
    %10 = llvm.trunc %9 : i64 to i32
    %11 = llvm.xor %10, %3  : i32
    %12 = llvm.select %8, %6, %11 : i1, i32
    llvm.call @use(%11) : (i32) -> ()
    llvm.call @use(%6) : (i32) -> ()
    llvm.return %12 : i32
  }]

def oneusethree_before := [llvmfunc|
  llvm.func @oneusethree(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.mlir.constant(63 : i64) : i64
    %3 = llvm.mlir.constant(2147483647 : i32) : i32
    %4 = llvm.lshr %arg0, %0  : i64
    %5 = llvm.trunc %4 : i64 to i32
    %6 = llvm.trunc %arg0 : i64 to i32
    %7 = llvm.ashr %6, %1  : i32
    %8 = llvm.icmp "eq" %7, %5 : i32
    %9 = llvm.ashr %arg0, %2  : i64
    %10 = llvm.trunc %9 : i64 to i32
    %11 = llvm.xor %10, %3  : i32
    %12 = llvm.select %8, %6, %11 : i1, i32
    llvm.call @use(%11) : (i32) -> ()
    llvm.call @use(%6) : (i32) -> ()
    llvm.call @use1(%8) : (i1) -> ()
    llvm.return %12 : i32
  }]

def differentconsts_usetrunc_before := [llvmfunc|
  llvm.func @differentconsts_usetrunc(%arg0: i32, %arg1: i16, %arg2: i16) -> i16 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(256 : i16) : i16
    %2 = llvm.mlir.constant(-1 : i16) : i16
    %3 = llvm.mlir.constant(16 : i32) : i32
    %4 = llvm.mlir.constant(144 : i32) : i32
    %5 = llvm.icmp "slt" %arg0, %0 : i32
    %6 = llvm.select %5, %1, %2 : i1, i16
    %7 = llvm.add %arg0, %3  : i32
    %8 = llvm.icmp "ult" %7, %4 : i32
    %9 = llvm.trunc %arg0 : i32 to i16
    %10 = llvm.select %8, %9, %6 : i1, i16
    llvm.call @use16(%9) : (i16) -> ()
    llvm.return %10 : i16
  }]

def differentconsts_useadd_before := [llvmfunc|
  llvm.func @differentconsts_useadd(%arg0: i32, %arg1: i16, %arg2: i16) -> i16 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(256 : i16) : i16
    %2 = llvm.mlir.constant(-1 : i16) : i16
    %3 = llvm.mlir.constant(16 : i32) : i32
    %4 = llvm.mlir.constant(144 : i32) : i32
    %5 = llvm.icmp "slt" %arg0, %0 : i32
    %6 = llvm.select %5, %1, %2 : i1, i16
    %7 = llvm.add %arg0, %3  : i32
    %8 = llvm.icmp "ult" %7, %4 : i32
    %9 = llvm.trunc %arg0 : i32 to i16
    %10 = llvm.select %8, %9, %6 : i1, i16
    llvm.call @use(%7) : (i32) -> ()
    llvm.return %10 : i16
  }]

def differentconsts_useaddtrunc_before := [llvmfunc|
  llvm.func @differentconsts_useaddtrunc(%arg0: i32, %arg1: i16, %arg2: i16) -> i16 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(256 : i16) : i16
    %2 = llvm.mlir.constant(-1 : i16) : i16
    %3 = llvm.mlir.constant(16 : i32) : i32
    %4 = llvm.mlir.constant(144 : i32) : i32
    %5 = llvm.icmp "slt" %arg0, %0 : i32
    %6 = llvm.select %5, %1, %2 : i1, i16
    %7 = llvm.add %arg0, %3  : i32
    %8 = llvm.icmp "ult" %7, %4 : i32
    %9 = llvm.trunc %arg0 : i32 to i16
    %10 = llvm.select %8, %9, %6 : i1, i16
    llvm.call @use16(%9) : (i16) -> ()
    llvm.call @use(%7) : (i32) -> ()
    llvm.return %10 : i16
  }]

def C0zero_before := [llvmfunc|
  llvm.func @C0zero(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(-10 : i8) : i8
    %3 = llvm.add %arg0, %0  : i8
    %4 = llvm.icmp "ult" %3, %1 : i8
    %5 = llvm.icmp "slt" %arg0, %2 : i8
    %6 = llvm.select %5, %arg1, %arg2 : i1, i8
    %7 = llvm.select %4, %arg0, %6 : i1, i8
    llvm.return %7 : i8
  }]

def C0zeroV_before := [llvmfunc|
  llvm.func @C0zeroV(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<10> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.mlir.constant(dense<-10> : vector<2xi8>) : vector<2xi8>
    %4 = llvm.add %arg0, %0  : vector<2xi8>
    %5 = llvm.icmp "ult" %4, %2 : vector<2xi8>
    %6 = llvm.icmp "slt" %arg0, %3 : vector<2xi8>
    %7 = llvm.select %6, %arg1, %arg2 : vector<2xi1>, vector<2xi8>
    %8 = llvm.select %5, %arg0, %7 : vector<2xi1>, vector<2xi8>
    llvm.return %8 : vector<2xi8>
  }]

def C0zeroVu_before := [llvmfunc|
  llvm.func @C0zeroVu(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<10> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[0, 10]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<-10> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.add %arg0, %0  : vector<2xi8>
    %4 = llvm.icmp "ult" %3, %1 : vector<2xi8>
    %5 = llvm.icmp "slt" %arg0, %2 : vector<2xi8>
    %6 = llvm.select %5, %arg1, %arg2 : vector<2xi1>, vector<2xi8>
    %7 = llvm.select %4, %arg0, %6 : vector<2xi1>, vector<2xi8>
    llvm.return %7 : vector<2xi8>
  }]

def f_before := [llvmfunc|
  llvm.func @f(%arg0: i32, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(256 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.select %3, %arg1, %1 : i1, i8
    %5 = llvm.icmp "ult" %arg0, %2 : i32
    %6 = llvm.trunc %arg0 : i32 to i8
    %7 = llvm.select %5, %6, %4 : i1, i8
    llvm.return %7 : i8
  }]

def testi16i8_combined := [llvmfunc|
  llvm.func @testi16i8(%arg0: i16) -> i8 {
    %0 = llvm.mlir.constant(-128 : i16) : i16
    %1 = llvm.mlir.constant(127 : i16) : i16
    %2 = llvm.intr.smax(%arg0, %0)  : (i16, i16) -> i16
    %3 = llvm.intr.smin(%2, %1)  : (i16, i16) -> i16
    %4 = llvm.trunc %3 : i16 to i8
    llvm.return %4 : i8
  }]

theorem inst_combine_testi16i8   : testi16i8_before  ⊑  testi16i8_combined := by
  unfold testi16i8_before testi16i8_combined
  simp_alive_peephole
  sorry
def testi64i32_combined := [llvmfunc|
  llvm.func @testi64i32(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(-2147483648 : i64) : i64
    %1 = llvm.mlir.constant(2147483647 : i64) : i64
    %2 = llvm.intr.smax(%arg0, %0)  : (i64, i64) -> i64
    %3 = llvm.intr.smin(%2, %1)  : (i64, i64) -> i64
    %4 = llvm.trunc %3 : i64 to i32
    llvm.return %4 : i32
  }]

theorem inst_combine_testi64i32   : testi64i32_before  ⊑  testi64i32_combined := by
  unfold testi64i32_before testi64i32_combined
  simp_alive_peephole
  sorry
def testi32i16i8_combined := [llvmfunc|
  llvm.func @testi32i16i8(%arg0: i32) -> i16 {
    %0 = llvm.mlir.constant(-128 : i32) : i32
    %1 = llvm.mlir.constant(127 : i32) : i32
    %2 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.intr.smin(%2, %1)  : (i32, i32) -> i32
    %4 = llvm.trunc %3 : i32 to i16
    llvm.return %4 : i16
  }]

theorem inst_combine_testi32i16i8   : testi32i16i8_before  ⊑  testi32i16i8_combined := by
  unfold testi32i16i8_before testi32i16i8_combined
  simp_alive_peephole
  sorry
def testv4i32i16i8_combined := [llvmfunc|
  llvm.func @testv4i32i16i8(%arg0: vector<4xi32>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(dense<-128> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<127> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.intr.smax(%arg0, %0)  : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %3 = llvm.intr.smin(%2, %1)  : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %4 = llvm.trunc %3 : vector<4xi32> to vector<4xi16>
    llvm.return %4 : vector<4xi16>
  }]

theorem inst_combine_testv4i32i16i8   : testv4i32i16i8_before  ⊑  testv4i32i16i8_combined := by
  unfold testv4i32i16i8_before testv4i32i16i8_combined
  simp_alive_peephole
  sorry
def testi32i32i8_combined := [llvmfunc|
  llvm.func @testi32i32i8(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-128 : i32) : i32
    %1 = llvm.mlir.constant(127 : i32) : i32
    %2 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.intr.smin(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_testi32i32i8   : testi32i32i8_before  ⊑  testi32i32i8_combined := by
  unfold testi32i32i8_before testi32i32i8_combined
  simp_alive_peephole
  sorry
def test_truncfirst_combined := [llvmfunc|
  llvm.func @test_truncfirst(%arg0: i32) -> i16 {
    %0 = llvm.mlir.constant(-128 : i16) : i16
    %1 = llvm.mlir.constant(127 : i16) : i16
    %2 = llvm.trunc %arg0 : i32 to i16
    %3 = llvm.intr.smax(%2, %0)  : (i16, i16) -> i16
    %4 = llvm.intr.smin(%3, %1)  : (i16, i16) -> i16
    llvm.return %4 : i16
  }]

theorem inst_combine_test_truncfirst   : test_truncfirst_before  ⊑  test_truncfirst_combined := by
  unfold test_truncfirst_before test_truncfirst_combined
  simp_alive_peephole
  sorry
def testtrunclowhigh_combined := [llvmfunc|
  llvm.func @testtrunclowhigh(%arg0: i32, %arg1: i16, %arg2: i16) -> i16 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(256 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.add %arg0, %0  : i32
    %4 = llvm.icmp "ult" %3, %1 : i32
    %5 = llvm.trunc %arg0 : i32 to i16
    %6 = llvm.icmp "slt" %arg0, %2 : i32
    %7 = llvm.select %6, %arg1, %arg2 : i1, i16
    %8 = llvm.select %4, %5, %7 : i1, i16
    llvm.return %8 : i16
  }]

theorem inst_combine_testtrunclowhigh   : testtrunclowhigh_before  ⊑  testtrunclowhigh_combined := by
  unfold testtrunclowhigh_before testtrunclowhigh_combined
  simp_alive_peephole
  sorry
def testi64i32addsat_combined := [llvmfunc|
  llvm.func @testi64i32addsat(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.sadd.sat(%arg0, %arg1)  : (i32, i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_testi64i32addsat   : testi64i32addsat_before  ⊑  testi64i32addsat_combined := by
  unfold testi64i32addsat_before testi64i32addsat_combined
  simp_alive_peephole
  sorry
def testv4i16i8_combined := [llvmfunc|
  llvm.func @testv4i16i8(%arg0: vector<4xi16>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<-128> : vector<4xi16>) : vector<4xi16>
    %1 = llvm.mlir.constant(dense<127> : vector<4xi16>) : vector<4xi16>
    %2 = llvm.intr.smax(%arg0, %0)  : (vector<4xi16>, vector<4xi16>) -> vector<4xi16>
    %3 = llvm.intr.smin(%2, %1)  : (vector<4xi16>, vector<4xi16>) -> vector<4xi16>
    %4 = llvm.trunc %3 : vector<4xi16> to vector<4xi8>
    llvm.return %4 : vector<4xi8>
  }]

theorem inst_combine_testv4i16i8   : testv4i16i8_before  ⊑  testv4i16i8_combined := by
  unfold testv4i16i8_before testv4i16i8_combined
  simp_alive_peephole
  sorry
def testv4i16i8add_combined := [llvmfunc|
  llvm.func @testv4i16i8add(%arg0: vector<4xi8>, %arg1: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.intr.sadd.sat(%arg0, %arg1)  : (vector<4xi8>, vector<4xi8>) -> vector<4xi8>
    llvm.return %0 : vector<4xi8>
  }]

theorem inst_combine_testv4i16i8add   : testv4i16i8add_before  ⊑  testv4i16i8add_combined := by
  unfold testv4i16i8add_before testv4i16i8add_combined
  simp_alive_peephole
  sorry
def testi16i8_revcmp_combined := [llvmfunc|
  llvm.func @testi16i8_revcmp(%arg0: i16) -> i8 {
    %0 = llvm.mlir.constant(-128 : i16) : i16
    %1 = llvm.mlir.constant(127 : i16) : i16
    %2 = llvm.intr.smax(%arg0, %0)  : (i16, i16) -> i16
    %3 = llvm.intr.smin(%2, %1)  : (i16, i16) -> i16
    %4 = llvm.trunc %3 : i16 to i8
    llvm.return %4 : i8
  }]

theorem inst_combine_testi16i8_revcmp   : testi16i8_revcmp_before  ⊑  testi16i8_revcmp_combined := by
  unfold testi16i8_revcmp_before testi16i8_revcmp_combined
  simp_alive_peephole
  sorry
def testi16i8_revselect_combined := [llvmfunc|
  llvm.func @testi16i8_revselect(%arg0: i16) -> i8 {
    %0 = llvm.mlir.constant(-128 : i16) : i16
    %1 = llvm.mlir.constant(127 : i16) : i16
    %2 = llvm.intr.smax(%arg0, %0)  : (i16, i16) -> i16
    %3 = llvm.intr.smin(%2, %1)  : (i16, i16) -> i16
    %4 = llvm.trunc %3 : i16 to i8
    llvm.return %4 : i8
  }]

theorem inst_combine_testi16i8_revselect   : testi16i8_revselect_before  ⊑  testi16i8_revselect_combined := by
  unfold testi16i8_revselect_before testi16i8_revselect_combined
  simp_alive_peephole
  sorry
def testi32i8_combined := [llvmfunc|
  llvm.func @testi32i8(%arg0: i32) -> i8 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(127 : i8) : i8
    %4 = llvm.lshr %arg0, %0  : i32
    %5 = llvm.trunc %4 : i32 to i8
    %6 = llvm.trunc %arg0 : i32 to i8
    %7 = llvm.ashr %6, %1  : i8
    %8 = llvm.icmp "eq" %7, %5 : i8
    %9 = llvm.lshr %arg0, %2  : i32
    %10 = llvm.trunc %9 : i32 to i8
    %11 = llvm.xor %10, %3  : i8
    %12 = llvm.select %8, %6, %11 : i1, i8
    llvm.return %12 : i8
  }]

theorem inst_combine_testi32i8   : testi32i8_before  ⊑  testi32i8_combined := by
  unfold testi32i8_before testi32i8_combined
  simp_alive_peephole
  sorry
def differentconsts_combined := [llvmfunc|
  llvm.func @differentconsts(%arg0: i32, %arg1: i16, %arg2: i16) -> i16 {
    %0 = llvm.mlir.constant(-16 : i32) : i32
    %1 = llvm.mlir.constant(127 : i32) : i32
    %2 = llvm.mlir.constant(256 : i16) : i16
    %3 = llvm.mlir.constant(-1 : i16) : i16
    %4 = llvm.icmp "slt" %arg0, %0 : i32
    %5 = llvm.icmp "sgt" %arg0, %1 : i32
    %6 = llvm.trunc %arg0 : i32 to i16
    %7 = llvm.select %4, %2, %6 : i1, i16
    %8 = llvm.select %5, %3, %7 : i1, i16
    llvm.return %8 : i16
  }]

theorem inst_combine_differentconsts   : differentconsts_before  ⊑  differentconsts_combined := by
  unfold differentconsts_before differentconsts_combined
  simp_alive_peephole
  sorry
def badimm1_combined := [llvmfunc|
  llvm.func @badimm1(%arg0: i16) -> i8 {
    %0 = llvm.mlir.constant(9 : i16) : i16
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.mlir.constant(-1 : i16) : i16
    %3 = llvm.mlir.constant(127 : i8) : i8
    %4 = llvm.mlir.constant(-128 : i8) : i8
    %5 = llvm.lshr %arg0, %0  : i16
    %6 = llvm.trunc %5 : i16 to i8
    %7 = llvm.trunc %arg0 : i16 to i8
    %8 = llvm.ashr %7, %1  : i8
    %9 = llvm.icmp "eq" %8, %6 : i8
    %10 = llvm.icmp "sgt" %arg0, %2 : i16
    %11 = llvm.select %10, %3, %4 : i1, i8
    %12 = llvm.select %9, %7, %11 : i1, i8
    llvm.return %12 : i8
  }]

theorem inst_combine_badimm1   : badimm1_before  ⊑  badimm1_combined := by
  unfold badimm1_before badimm1_combined
  simp_alive_peephole
  sorry
def badimm2_combined := [llvmfunc|
  llvm.func @badimm2(%arg0: i16) -> i8 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.mlir.constant(-1 : i16) : i16
    %3 = llvm.mlir.constant(127 : i8) : i8
    %4 = llvm.mlir.constant(-128 : i8) : i8
    %5 = llvm.lshr %arg0, %0  : i16
    %6 = llvm.trunc %5 : i16 to i8
    %7 = llvm.trunc %arg0 : i16 to i8
    %8 = llvm.ashr %7, %1  : i8
    %9 = llvm.icmp "eq" %8, %6 : i8
    %10 = llvm.icmp "sgt" %arg0, %2 : i16
    %11 = llvm.select %10, %3, %4 : i1, i8
    %12 = llvm.select %9, %7, %11 : i1, i8
    llvm.return %12 : i8
  }]

theorem inst_combine_badimm2   : badimm2_before  ⊑  badimm2_combined := by
  unfold badimm2_before badimm2_combined
  simp_alive_peephole
  sorry
def badimm3_combined := [llvmfunc|
  llvm.func @badimm3(%arg0: i16) -> i8 {
    %0 = llvm.mlir.constant(128 : i16) : i16
    %1 = llvm.mlir.constant(256 : i16) : i16
    %2 = llvm.mlir.constant(14 : i16) : i16
    %3 = llvm.mlir.constant(127 : i8) : i8
    %4 = llvm.trunc %arg0 : i16 to i8
    %5 = llvm.add %arg0, %0  : i16
    %6 = llvm.icmp "ult" %5, %1 : i16
    %7 = llvm.ashr %arg0, %2  : i16
    %8 = llvm.trunc %7 : i16 to i8
    %9 = llvm.xor %8, %3  : i8
    %10 = llvm.select %6, %4, %9 : i1, i8
    llvm.return %10 : i8
  }]

theorem inst_combine_badimm3   : badimm3_before  ⊑  badimm3_combined := by
  unfold badimm3_before badimm3_combined
  simp_alive_peephole
  sorry
def badimm4_combined := [llvmfunc|
  llvm.func @badimm4(%arg0: i16) -> i8 {
    %0 = llvm.mlir.constant(-128 : i16) : i16
    %1 = llvm.mlir.constant(127 : i16) : i16
    %2 = llvm.mlir.constant(-127 : i8) : i8
    %3 = llvm.mlir.constant(126 : i8) : i8
    %4 = llvm.icmp "slt" %arg0, %0 : i16
    %5 = llvm.icmp "sgt" %arg0, %1 : i16
    %6 = llvm.trunc %arg0 : i16 to i8
    %7 = llvm.select %4, %2, %6 : i1, i8
    %8 = llvm.select %5, %3, %7 : i1, i8
    llvm.return %8 : i8
  }]

theorem inst_combine_badimm4   : badimm4_before  ⊑  badimm4_combined := by
  unfold badimm4_before badimm4_combined
  simp_alive_peephole
  sorry
def oneusexor_combined := [llvmfunc|
  llvm.func @oneusexor(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(2147483648 : i64) : i64
    %1 = llvm.mlir.constant(4294967296 : i64) : i64
    %2 = llvm.mlir.constant(-1 : i64) : i64
    %3 = llvm.mlir.constant(2147483647 : i32) : i32
    %4 = llvm.mlir.constant(-2147483648 : i32) : i32
    %5 = llvm.trunc %arg0 : i64 to i32
    %6 = llvm.add %arg0, %0  : i64
    %7 = llvm.icmp "ult" %6, %1 : i64
    %8 = llvm.icmp "sgt" %arg0, %2 : i64
    %9 = llvm.select %8, %3, %4 : i1, i32
    %10 = llvm.select %7, %5, %9 : i1, i32
    llvm.call @use(%9) : (i32) -> ()
    llvm.return %10 : i32
  }]

theorem inst_combine_oneusexor   : oneusexor_before  ⊑  oneusexor_combined := by
  unfold oneusexor_before oneusexor_combined
  simp_alive_peephole
  sorry
def oneuseconv_combined := [llvmfunc|
  llvm.func @oneuseconv(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(2147483648 : i64) : i64
    %1 = llvm.mlir.constant(4294967296 : i64) : i64
    %2 = llvm.mlir.constant(-1 : i64) : i64
    %3 = llvm.mlir.constant(2147483647 : i32) : i32
    %4 = llvm.mlir.constant(-2147483648 : i32) : i32
    %5 = llvm.trunc %arg0 : i64 to i32
    %6 = llvm.add %arg0, %0  : i64
    %7 = llvm.icmp "ult" %6, %1 : i64
    %8 = llvm.icmp "sgt" %arg0, %2 : i64
    %9 = llvm.select %8, %3, %4 : i1, i32
    %10 = llvm.select %7, %5, %9 : i1, i32
    llvm.call @use(%5) : (i32) -> ()
    llvm.return %10 : i32
  }]

theorem inst_combine_oneuseconv   : oneuseconv_before  ⊑  oneuseconv_combined := by
  unfold oneuseconv_before oneuseconv_combined
  simp_alive_peephole
  sorry
def oneusecmp_combined := [llvmfunc|
  llvm.func @oneusecmp(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(2147483648 : i64) : i64
    %1 = llvm.mlir.constant(4294967296 : i64) : i64
    %2 = llvm.mlir.constant(-1 : i64) : i64
    %3 = llvm.mlir.constant(2147483647 : i32) : i32
    %4 = llvm.mlir.constant(-2147483648 : i32) : i32
    %5 = llvm.trunc %arg0 : i64 to i32
    %6 = llvm.add %arg0, %0  : i64
    %7 = llvm.icmp "ult" %6, %1 : i64
    %8 = llvm.icmp "sgt" %arg0, %2 : i64
    %9 = llvm.select %8, %3, %4 : i1, i32
    %10 = llvm.select %7, %5, %9 : i1, i32
    llvm.call @use1(%7) : (i1) -> ()
    llvm.return %10 : i32
  }]

theorem inst_combine_oneusecmp   : oneusecmp_before  ⊑  oneusecmp_combined := by
  unfold oneusecmp_before oneusecmp_combined
  simp_alive_peephole
  sorry
def oneuseboth_combined := [llvmfunc|
  llvm.func @oneuseboth(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(2147483648 : i64) : i64
    %1 = llvm.mlir.constant(4294967296 : i64) : i64
    %2 = llvm.mlir.constant(-1 : i64) : i64
    %3 = llvm.mlir.constant(2147483647 : i32) : i32
    %4 = llvm.mlir.constant(-2147483648 : i32) : i32
    %5 = llvm.trunc %arg0 : i64 to i32
    %6 = llvm.add %arg0, %0  : i64
    %7 = llvm.icmp "ult" %6, %1 : i64
    %8 = llvm.icmp "sgt" %arg0, %2 : i64
    %9 = llvm.select %8, %3, %4 : i1, i32
    %10 = llvm.select %7, %5, %9 : i1, i32
    llvm.call @use(%9) : (i32) -> ()
    llvm.call @use(%5) : (i32) -> ()
    llvm.return %10 : i32
  }]

theorem inst_combine_oneuseboth   : oneuseboth_before  ⊑  oneuseboth_combined := by
  unfold oneuseboth_before oneuseboth_combined
  simp_alive_peephole
  sorry
def oneusethree_combined := [llvmfunc|
  llvm.func @oneusethree(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(2147483648 : i64) : i64
    %1 = llvm.mlir.constant(4294967296 : i64) : i64
    %2 = llvm.mlir.constant(-1 : i64) : i64
    %3 = llvm.mlir.constant(2147483647 : i32) : i32
    %4 = llvm.mlir.constant(-2147483648 : i32) : i32
    %5 = llvm.trunc %arg0 : i64 to i32
    %6 = llvm.add %arg0, %0  : i64
    %7 = llvm.icmp "ult" %6, %1 : i64
    %8 = llvm.icmp "sgt" %arg0, %2 : i64
    %9 = llvm.select %8, %3, %4 : i1, i32
    %10 = llvm.select %7, %5, %9 : i1, i32
    llvm.call @use(%9) : (i32) -> ()
    llvm.call @use(%5) : (i32) -> ()
    llvm.call @use1(%7) : (i1) -> ()
    llvm.return %10 : i32
  }]

theorem inst_combine_oneusethree   : oneusethree_before  ⊑  oneusethree_combined := by
  unfold oneusethree_before oneusethree_combined
  simp_alive_peephole
  sorry
def differentconsts_usetrunc_combined := [llvmfunc|
  llvm.func @differentconsts_usetrunc(%arg0: i32, %arg1: i16, %arg2: i16) -> i16 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(256 : i16) : i16
    %2 = llvm.mlir.constant(-1 : i16) : i16
    %3 = llvm.mlir.constant(16 : i32) : i32
    %4 = llvm.mlir.constant(144 : i32) : i32
    %5 = llvm.icmp "slt" %arg0, %0 : i32
    %6 = llvm.select %5, %1, %2 : i1, i16
    %7 = llvm.add %arg0, %3  : i32
    %8 = llvm.icmp "ult" %7, %4 : i32
    %9 = llvm.trunc %arg0 : i32 to i16
    %10 = llvm.select %8, %9, %6 : i1, i16
    llvm.call @use16(%9) : (i16) -> ()
    llvm.return %10 : i16
  }]

theorem inst_combine_differentconsts_usetrunc   : differentconsts_usetrunc_before  ⊑  differentconsts_usetrunc_combined := by
  unfold differentconsts_usetrunc_before differentconsts_usetrunc_combined
  simp_alive_peephole
  sorry
def differentconsts_useadd_combined := [llvmfunc|
  llvm.func @differentconsts_useadd(%arg0: i32, %arg1: i16, %arg2: i16) -> i16 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(-16 : i32) : i32
    %2 = llvm.mlir.constant(127 : i32) : i32
    %3 = llvm.mlir.constant(256 : i16) : i16
    %4 = llvm.mlir.constant(-1 : i16) : i16
    %5 = llvm.add %arg0, %0  : i32
    %6 = llvm.icmp "slt" %arg0, %1 : i32
    %7 = llvm.icmp "sgt" %arg0, %2 : i32
    %8 = llvm.trunc %arg0 : i32 to i16
    %9 = llvm.select %6, %3, %8 : i1, i16
    %10 = llvm.select %7, %4, %9 : i1, i16
    llvm.call @use(%5) : (i32) -> ()
    llvm.return %10 : i16
  }]

theorem inst_combine_differentconsts_useadd   : differentconsts_useadd_before  ⊑  differentconsts_useadd_combined := by
  unfold differentconsts_useadd_before differentconsts_useadd_combined
  simp_alive_peephole
  sorry
def differentconsts_useaddtrunc_combined := [llvmfunc|
  llvm.func @differentconsts_useaddtrunc(%arg0: i32, %arg1: i16, %arg2: i16) -> i16 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(256 : i16) : i16
    %2 = llvm.mlir.constant(-1 : i16) : i16
    %3 = llvm.mlir.constant(16 : i32) : i32
    %4 = llvm.mlir.constant(144 : i32) : i32
    %5 = llvm.icmp "slt" %arg0, %0 : i32
    %6 = llvm.select %5, %1, %2 : i1, i16
    %7 = llvm.add %arg0, %3  : i32
    %8 = llvm.icmp "ult" %7, %4 : i32
    %9 = llvm.trunc %arg0 : i32 to i16
    %10 = llvm.select %8, %9, %6 : i1, i16
    llvm.call @use16(%9) : (i16) -> ()
    llvm.call @use(%7) : (i32) -> ()
    llvm.return %10 : i16
  }]

theorem inst_combine_differentconsts_useaddtrunc   : differentconsts_useaddtrunc_before  ⊑  differentconsts_useaddtrunc_combined := by
  unfold differentconsts_useaddtrunc_before differentconsts_useaddtrunc_combined
  simp_alive_peephole
  sorry
def C0zero_combined := [llvmfunc|
  llvm.func @C0zero(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-10 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    %2 = llvm.select %1, %arg1, %arg2 : i1, i8
    llvm.return %2 : i8
  }]

theorem inst_combine_C0zero   : C0zero_before  ⊑  C0zero_combined := by
  unfold C0zero_before C0zero_combined
  simp_alive_peephole
  sorry
def C0zeroV_combined := [llvmfunc|
  llvm.func @C0zeroV(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-10> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "slt" %arg0, %0 : vector<2xi8>
    %2 = llvm.select %1, %arg1, %arg2 : vector<2xi1>, vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

theorem inst_combine_C0zeroV   : C0zeroV_before  ⊑  C0zeroV_combined := by
  unfold C0zeroV_before C0zeroV_combined
  simp_alive_peephole
  sorry
def C0zeroVu_combined := [llvmfunc|
  llvm.func @C0zeroVu(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<10> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[0, 10]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<-10> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.add %arg0, %0  : vector<2xi8>
    %4 = llvm.icmp "ult" %3, %1 : vector<2xi8>
    %5 = llvm.icmp "slt" %arg0, %2 : vector<2xi8>
    %6 = llvm.select %5, %arg1, %arg2 : vector<2xi1>, vector<2xi8>
    %7 = llvm.select %4, %arg0, %6 : vector<2xi1>, vector<2xi8>
    llvm.return %7 : vector<2xi8>
  }]

theorem inst_combine_C0zeroVu   : C0zeroVu_before  ⊑  C0zeroVu_combined := by
  unfold C0zeroVu_before C0zeroVu_combined
  simp_alive_peephole
  sorry
def f_combined := [llvmfunc|
  llvm.func @f(%arg0: i32, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(256 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.select %3, %arg1, %1 : i1, i8
    %5 = llvm.icmp "ult" %arg0, %2 : i32
    %6 = llvm.trunc %arg0 : i32 to i8
    %7 = llvm.select %5, %6, %4 : i1, i8
    llvm.return %7 : i8
  }]

theorem inst_combine_f   : f_before  ⊑  f_combined := by
  unfold f_before f_combined
  simp_alive_peephole
  sorry
