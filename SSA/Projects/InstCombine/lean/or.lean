import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  or
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test12_before := [llvmfunc|
  llvm.func @test12(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }]

def test13_before := [llvmfunc|
  llvm.func @test13(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }]

def test14_before := [llvmfunc|
  llvm.func @test14(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i32
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def test14_commuted_before := [llvmfunc|
  llvm.func @test14_commuted(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i32
    %1 = llvm.icmp "ult" %arg1, %arg0 : i32
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def test14_logical_before := [llvmfunc|
  llvm.func @test14_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "ult" %arg0, %arg1 : i32
    %2 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def test15_before := [llvmfunc|
  llvm.func @test15(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i32
    %1 = llvm.icmp "eq" %arg0, %arg1 : i32
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def test15_logical_before := [llvmfunc|
  llvm.func @test15_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "ult" %arg0, %arg1 : i32
    %2 = llvm.icmp "eq" %arg0, %arg1 : i32
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def test16_before := [llvmfunc|
  llvm.func @test16(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.and %arg0, %1  : i32
    %4 = llvm.or %2, %3  : i32
    llvm.return %4 : i32
  }]

def test17_before := [llvmfunc|
  llvm.func @test17(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.and %arg0, %1  : i32
    %4 = llvm.or %2, %3  : i32
    llvm.return %4 : i32
  }]

def test18_before := [llvmfunc|
  llvm.func @test18(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(100 : i32) : i32
    %1 = llvm.mlir.constant(50 : i32) : i32
    %2 = llvm.icmp "sge" %arg0, %0 : i32
    %3 = llvm.icmp "slt" %arg0, %1 : i32
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }]

def test18_logical_before := [llvmfunc|
  llvm.func @test18_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(100 : i32) : i32
    %1 = llvm.mlir.constant(50 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "sge" %arg0, %0 : i32
    %4 = llvm.icmp "slt" %arg0, %1 : i32
    %5 = llvm.select %3, %2, %4 : i1, i1
    llvm.return %5 : i1
  }]

def test18vec_before := [llvmfunc|
  llvm.func @test18vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<100> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<50> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "sge" %arg0, %0 : vector<2xi32>
    %3 = llvm.icmp "slt" %arg0, %1 : vector<2xi32>
    %4 = llvm.or %2, %3  : vector<2xi1>
    llvm.return %4 : vector<2xi1>
  }]

def test20_before := [llvmfunc|
  llvm.func @test20(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.or %1, %arg0  : i32
    llvm.return %2 : i32
  }]

def test21_before := [llvmfunc|
  llvm.func @test21(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.add %arg0, %0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.and %arg0, %2  : i32
    %6 = llvm.or %5, %4  : i32
    llvm.return %6 : i32
  }]

def test22_before := [llvmfunc|
  llvm.func @test22(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.and %arg0, %1  : i32
    %4 = llvm.or %2, %3  : i32
    llvm.return %4 : i32
  }]

def test23_before := [llvmfunc|
  llvm.func @test23(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.mlir.constant(-32768 : i16) : i16
    %2 = llvm.mlir.constant(8193 : i16) : i16
    %3 = llvm.lshr %arg0, %0  : i16
    %4 = llvm.or %3, %1  : i16
    %5 = llvm.xor %4, %2  : i16
    llvm.return %5 : i16
  }]

def test23vec_before := [llvmfunc|
  llvm.func @test23vec(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(dense<-32768> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.mlir.constant(dense<8193> : vector<2xi16>) : vector<2xi16>
    %3 = llvm.lshr %arg0, %0  : vector<2xi16>
    %4 = llvm.or %3, %1  : vector<2xi16>
    %5 = llvm.xor %4, %2  : vector<2xi16>
    llvm.return %5 : vector<2xi16>
  }]

def test25_before := [llvmfunc|
  llvm.func @test25(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(57 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.icmp "eq" %arg1, %1 : i32
    %5 = llvm.or %3, %4  : i1
    %6 = llvm.xor %5, %2  : i1
    llvm.return %6 : i1
  }]

def test25_logical_before := [llvmfunc|
  llvm.func @test25_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(57 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.icmp "eq" %arg1, %1 : i32
    %5 = llvm.select %3, %2, %4 : i1, i1
    %6 = llvm.xor %5, %2  : i1
    llvm.return %6 : i1
  }]

def and_icmp_eq_0_before := [llvmfunc|
  llvm.func @and_icmp_eq_0(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.icmp "eq" %arg1, %0 : i32
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def and_icmp_eq_0_vector_before := [llvmfunc|
  llvm.func @and_icmp_eq_0_vector(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "eq" %arg0, %1 : vector<2xi32>
    %3 = llvm.icmp "eq" %arg1, %1 : vector<2xi32>
    %4 = llvm.and %2, %3  : vector<2xi1>
    llvm.return %4 : vector<2xi1>
  }]

def and_icmp_eq_0_vector_poison1_before := [llvmfunc|
  llvm.func @and_icmp_eq_0_vector_poison1(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.icmp "eq" %arg0, %6 : vector<2xi32>
    %8 = llvm.icmp "eq" %arg1, %6 : vector<2xi32>
    %9 = llvm.and %7, %8  : vector<2xi1>
    llvm.return %9 : vector<2xi1>
  }]

def and_icmp_eq_0_vector_poison2_before := [llvmfunc|
  llvm.func @and_icmp_eq_0_vector_poison2(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.undef : vector<2xi32>
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<2xi32>
    %10 = llvm.mlir.constant(1 : i32) : i32
    %11 = llvm.insertelement %1, %9[%10 : i32] : vector<2xi32>
    %12 = llvm.icmp "eq" %arg0, %6 : vector<2xi32>
    %13 = llvm.icmp "eq" %arg1, %11 : vector<2xi32>
    %14 = llvm.and %12, %13  : vector<2xi1>
    llvm.return %14 : vector<2xi1>
  }]

def and_icmp_eq_0_logical_before := [llvmfunc|
  llvm.func @and_icmp_eq_0_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.icmp "eq" %arg1, %0 : i32
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

def test27_before := [llvmfunc|
  llvm.func @test27(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.ptrtoint %arg0 : !llvm.ptr to i32
    %2 = llvm.ptrtoint %arg1 : !llvm.ptr to i32
    %3 = llvm.or %1, %2  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test27vec_before := [llvmfunc|
  llvm.func @test27vec(%arg0: !llvm.vec<2 x ptr>, %arg1: !llvm.vec<2 x ptr>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.ptrtoint %arg0 : !llvm.vec<2 x ptr> to vector<2xi32>
    %3 = llvm.ptrtoint %arg1 : !llvm.vec<2 x ptr> to vector<2xi32>
    %4 = llvm.or %2, %3  : vector<2xi32>
    %5 = llvm.icmp "eq" %4, %1 : vector<2xi32>
    llvm.return %5 : vector<2xi1>
  }]

def test28_before := [llvmfunc|
  llvm.func @test28(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    %2 = llvm.icmp "ne" %arg1, %0 : i32
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def test28_logical_before := [llvmfunc|
  llvm.func @test28_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ne" %arg0, %0 : i32
    %3 = llvm.icmp "ne" %arg1, %0 : i32
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

def test29_before := [llvmfunc|
  llvm.func @test29(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.ptrtoint %arg0 : !llvm.ptr to i32
    %2 = llvm.ptrtoint %arg1 : !llvm.ptr to i32
    %3 = llvm.or %1, %2  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test29vec_before := [llvmfunc|
  llvm.func @test29vec(%arg0: !llvm.vec<2 x ptr>, %arg1: !llvm.vec<2 x ptr>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.ptrtoint %arg0 : !llvm.vec<2 x ptr> to vector<2xi32>
    %3 = llvm.ptrtoint %arg1 : !llvm.vec<2 x ptr> to vector<2xi32>
    %4 = llvm.or %2, %3  : vector<2xi32>
    %5 = llvm.icmp "ne" %4, %1 : vector<2xi32>
    llvm.return %5 : vector<2xi1>
  }]

def test30_before := [llvmfunc|
  llvm.func @test30(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(32962 : i32) : i32
    %1 = llvm.mlir.constant(-65536 : i32) : i32
    %2 = llvm.mlir.constant(40186 : i32) : i32
    %3 = llvm.or %arg0, %0  : i32
    %4 = llvm.and %arg0, %1  : i32
    %5 = llvm.and %3, %2  : i32
    %6 = llvm.or %5, %4  : i32
    llvm.return %6 : i32
  }]

def test30vec_before := [llvmfunc|
  llvm.func @test30vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<32962> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-65536> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<40186> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.or %arg0, %0  : vector<2xi32>
    %4 = llvm.and %arg0, %1  : vector<2xi32>
    %5 = llvm.and %3, %2  : vector<2xi32>
    %6 = llvm.or %5, %4  : vector<2xi32>
    llvm.return %6 : vector<2xi32>
  }]

def test31_before := [llvmfunc|
  llvm.func @test31(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(194 : i64) : i64
    %1 = llvm.mlir.constant(250 : i64) : i64
    %2 = llvm.mlir.constant(32768 : i64) : i64
    %3 = llvm.mlir.constant(4294941696 : i64) : i64
    %4 = llvm.or %arg0, %0  : i64
    %5 = llvm.and %4, %1  : i64
    %6 = llvm.or %arg0, %2  : i64
    %7 = llvm.and %6, %3  : i64
    %8 = llvm.or %5, %7  : i64
    llvm.return %8 : i64
  }]

def test31vec_before := [llvmfunc|
  llvm.func @test31vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<194> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<250> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.mlir.constant(dense<32768> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.mlir.constant(dense<4294941696> : vector<2xi64>) : vector<2xi64>
    %4 = llvm.or %arg0, %0  : vector<2xi64>
    %5 = llvm.and %4, %1  : vector<2xi64>
    %6 = llvm.or %arg0, %2  : vector<2xi64>
    %7 = llvm.and %6, %3  : vector<2xi64>
    %8 = llvm.or %5, %7  : vector<2xi64>
    llvm.return %8 : vector<2xi64>
  }]

def test32_before := [llvmfunc|
  llvm.func @test32(%arg0: vector<4xi1>, %arg1: vector<4xi32>, %arg2: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.sext %arg0 : vector<4xi1> to vector<4xi32>
    %2 = llvm.and %arg1, %1  : vector<4xi32>
    %3 = llvm.xor %1, %0  : vector<4xi32>
    %4 = llvm.and %arg2, %3  : vector<4xi32>
    %5 = llvm.or %4, %2  : vector<4xi32>
    llvm.return %5 : vector<4xi32>
  }]

def test33_before := [llvmfunc|
  llvm.func @test33(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.or %arg0, %arg1  : i1
    %1 = llvm.or %0, %arg0  : i1
    llvm.return %1 : i1
  }]

def test33_logical_before := [llvmfunc|
  llvm.func @test33_logical(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg1 : i1, i1
    %2 = llvm.select %1, %0, %arg0 : i1, i1
    llvm.return %2 : i1
  }]

def test34_before := [llvmfunc|
  llvm.func @test34(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.or %arg0, %arg1  : i32
    %1 = llvm.or %arg1, %0  : i32
    llvm.return %1 : i32
  }]

def test35_before := [llvmfunc|
  llvm.func @test35(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1135 : i32) : i32
    %1 = llvm.or %arg0, %0  : i32
    %2 = llvm.or %1, %arg1  : i32
    llvm.return %2 : i32
  }]

def test36_before := [llvmfunc|
  llvm.func @test36(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(23 : i32) : i32
    %1 = llvm.mlir.constant(24 : i32) : i32
    %2 = llvm.mlir.constant(25 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.icmp "eq" %arg0, %1 : i32
    %5 = llvm.or %3, %4  : i1
    %6 = llvm.icmp "eq" %arg0, %2 : i32
    %7 = llvm.or %5, %6  : i1
    llvm.return %7 : i1
  }]

def test36_logical_before := [llvmfunc|
  llvm.func @test36_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(23 : i32) : i32
    %1 = llvm.mlir.constant(24 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.constant(25 : i32) : i32
    %4 = llvm.icmp "eq" %arg0, %0 : i32
    %5 = llvm.icmp "eq" %arg0, %1 : i32
    %6 = llvm.select %4, %2, %5 : i1, i1
    %7 = llvm.icmp "eq" %arg0, %3 : i32
    %8 = llvm.select %6, %2, %7 : i1, i1
    llvm.return %8 : i1
  }]

def test37_before := [llvmfunc|
  llvm.func @test37(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(30 : i32) : i32
    %2 = llvm.mlir.constant(23 : i32) : i32
    %3 = llvm.add %arg0, %0  : i32
    %4 = llvm.icmp "ult" %3, %1 : i32
    %5 = llvm.icmp "eq" %arg0, %2 : i32
    %6 = llvm.or %4, %5  : i1
    llvm.return %6 : i1
  }]

def test37_logical_before := [llvmfunc|
  llvm.func @test37_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(30 : i32) : i32
    %2 = llvm.mlir.constant(23 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.add %arg0, %0  : i32
    %5 = llvm.icmp "ult" %4, %1 : i32
    %6 = llvm.icmp "eq" %arg0, %2 : i32
    %7 = llvm.select %5, %3, %6 : i1, i1
    llvm.return %7 : i1
  }]

def test37_uniform_before := [llvmfunc|
  llvm.func @test37_uniform(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<30> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<23> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.add %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "ult" %3, %1 : vector<2xi32>
    %5 = llvm.icmp "eq" %arg0, %2 : vector<2xi32>
    %6 = llvm.or %4, %5  : vector<2xi1>
    llvm.return %6 : vector<2xi1>
  }]

def test37_poison_before := [llvmfunc|
  llvm.func @test37_poison(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(30 : i32) : i32
    %8 = llvm.mlir.undef : vector<2xi32>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %7, %8[%9 : i32] : vector<2xi32>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<2xi32>
    %13 = llvm.mlir.constant(23 : i32) : i32
    %14 = llvm.mlir.undef : vector<2xi32>
    %15 = llvm.mlir.constant(0 : i32) : i32
    %16 = llvm.insertelement %13, %14[%15 : i32] : vector<2xi32>
    %17 = llvm.mlir.constant(1 : i32) : i32
    %18 = llvm.insertelement %0, %16[%17 : i32] : vector<2xi32>
    %19 = llvm.add %arg0, %6  : vector<2xi32>
    %20 = llvm.icmp "ult" %19, %12 : vector<2xi32>
    %21 = llvm.icmp "eq" %arg0, %18 : vector<2xi32>
    %22 = llvm.or %20, %21  : vector<2xi1>
    llvm.return %22 : vector<2xi1>
  }]

def test38_before := [llvmfunc|
  llvm.func @test38(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(23 : i32) : i32
    %2 = llvm.mlir.constant(30 : i32) : i32
    %3 = llvm.add %arg0, %0  : i32
    %4 = llvm.icmp "eq" %arg0, %1 : i32
    %5 = llvm.icmp "ult" %3, %2 : i32
    %6 = llvm.or %4, %5  : i1
    llvm.return %6 : i1
  }]

def test38_logical_before := [llvmfunc|
  llvm.func @test38_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(23 : i32) : i32
    %2 = llvm.mlir.constant(30 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.add %arg0, %0  : i32
    %5 = llvm.icmp "eq" %arg0, %1 : i32
    %6 = llvm.icmp "ult" %4, %2 : i32
    %7 = llvm.select %5, %3, %6 : i1, i1
    llvm.return %7 : i1
  }]

def test38_nonuniform_before := [llvmfunc|
  llvm.func @test38_nonuniform(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[7, 24]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[23, 8]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<[30, 32]> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.add %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "eq" %arg0, %1 : vector<2xi32>
    %5 = llvm.icmp "ult" %3, %2 : vector<2xi32>
    %6 = llvm.or %4, %5  : vector<2xi1>
    llvm.return %6 : vector<2xi1>
  }]

def test39a_before := [llvmfunc|
  llvm.func @test39a(%arg0: i32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mul %arg0, %0  : i32
    %3 = llvm.bitcast %arg1 : f32 to i32
    %4 = llvm.xor %2, %1  : i32
    %5 = llvm.and %4, %3  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.return %6 : i32
  }]

def test39b_before := [llvmfunc|
  llvm.func @test39b(%arg0: i32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mul %arg0, %0  : i32
    %3 = llvm.bitcast %arg1 : f32 to i32
    %4 = llvm.xor %2, %1  : i32
    %5 = llvm.and %3, %4  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.return %6 : i32
  }]

def test39c_before := [llvmfunc|
  llvm.func @test39c(%arg0: i32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mul %arg0, %0  : i32
    %3 = llvm.bitcast %arg1 : f32 to i32
    %4 = llvm.xor %2, %1  : i32
    %5 = llvm.and %4, %3  : i32
    %6 = llvm.or %2, %5  : i32
    llvm.return %6 : i32
  }]

def test39d_before := [llvmfunc|
  llvm.func @test39d(%arg0: i32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mul %arg0, %0  : i32
    %3 = llvm.bitcast %arg1 : f32 to i32
    %4 = llvm.xor %2, %1  : i32
    %5 = llvm.and %3, %4  : i32
    %6 = llvm.or %2, %5  : i32
    llvm.return %6 : i32
  }]

def test40_before := [llvmfunc|
  llvm.func @test40(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.or %1, %2  : i32
    llvm.return %3 : i32
  }]

def test40b_before := [llvmfunc|
  llvm.func @test40b(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.or %1, %2  : i32
    llvm.return %3 : i32
  }]

def test40c_before := [llvmfunc|
  llvm.func @test40c(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.or %2, %1  : i32
    llvm.return %3 : i32
  }]

def test40d_before := [llvmfunc|
  llvm.func @test40d(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.or %2, %1  : i32
    llvm.return %3 : i32
  }]

def test45_before := [llvmfunc|
  llvm.func @test45(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.or %arg1, %arg2  : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.or %1, %arg1  : i32
    llvm.return %2 : i32
  }]

def test45_uses1_before := [llvmfunc|
  llvm.func @test45_uses1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.or %arg1, %arg2  : i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.or %1, %arg1  : i32
    llvm.return %2 : i32
  }]

def test45_uses2_before := [llvmfunc|
  llvm.func @test45_uses2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.or %arg1, %arg2  : i32
    %1 = llvm.and %arg0, %0  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.or %1, %arg1  : i32
    llvm.return %2 : i32
  }]

def test45_commuted1_before := [llvmfunc|
  llvm.func @test45_commuted1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mul %arg1, %arg1  : i32
    %1 = llvm.or %0, %arg2  : i32
    %2 = llvm.and %1, %arg0  : i32
    %3 = llvm.or %0, %2  : i32
    llvm.return %3 : i32
  }]

def test45_commuted2_before := [llvmfunc|
  llvm.func @test45_commuted2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mul %arg1, %arg1  : i32
    %1 = llvm.mul %arg0, %arg0  : i32
    %2 = llvm.or %0, %arg2  : i32
    %3 = llvm.and %1, %2  : i32
    %4 = llvm.or %3, %0  : i32
    llvm.return %4 : i32
  }]

def test45_commuted3_before := [llvmfunc|
  llvm.func @test45_commuted3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mul %arg1, %arg1  : i32
    %1 = llvm.mul %arg2, %arg2  : i32
    %2 = llvm.or %1, %0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.or %3, %0  : i32
    llvm.return %4 : i32
  }]

def test46_before := [llvmfunc|
  llvm.func @test46(%arg0: i8 {llvm.signext}) -> i1 {
    %0 = llvm.mlir.constant(-97 : i8) : i8
    %1 = llvm.mlir.constant(26 : i8) : i8
    %2 = llvm.mlir.constant(-65 : i8) : i8
    %3 = llvm.add %arg0, %0  : i8
    %4 = llvm.icmp "ult" %3, %1 : i8
    %5 = llvm.add %arg0, %2  : i8
    %6 = llvm.icmp "ult" %5, %1 : i8
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }]

def test46_logical_before := [llvmfunc|
  llvm.func @test46_logical(%arg0: i8 {llvm.signext}) -> i1 {
    %0 = llvm.mlir.constant(-97 : i8) : i8
    %1 = llvm.mlir.constant(26 : i8) : i8
    %2 = llvm.mlir.constant(-65 : i8) : i8
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.add %arg0, %0  : i8
    %5 = llvm.icmp "ult" %4, %1 : i8
    %6 = llvm.add %arg0, %2  : i8
    %7 = llvm.icmp "ult" %6, %1 : i8
    %8 = llvm.select %5, %3, %7 : i1, i1
    llvm.return %8 : i1
  }]

def test46_uniform_before := [llvmfunc|
  llvm.func @test46_uniform(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-97> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<26> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<-65> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.add %arg0, %0  : vector<2xi8>
    %4 = llvm.icmp "ult" %3, %1 : vector<2xi8>
    %5 = llvm.add %arg0, %2  : vector<2xi8>
    %6 = llvm.icmp "ult" %5, %1 : vector<2xi8>
    %7 = llvm.or %4, %6  : vector<2xi1>
    llvm.return %7 : vector<2xi1>
  }]

def test46_poison_before := [llvmfunc|
  llvm.func @test46_poison(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(-97 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(26 : i8) : i8
    %8 = llvm.mlir.undef : vector<2xi8>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %7, %8[%9 : i32] : vector<2xi8>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<2xi8>
    %13 = llvm.mlir.constant(-65 : i8) : i8
    %14 = llvm.mlir.undef : vector<2xi8>
    %15 = llvm.mlir.constant(0 : i32) : i32
    %16 = llvm.insertelement %13, %14[%15 : i32] : vector<2xi8>
    %17 = llvm.mlir.constant(1 : i32) : i32
    %18 = llvm.insertelement %0, %16[%17 : i32] : vector<2xi8>
    %19 = llvm.add %arg0, %6  : vector<2xi8>
    %20 = llvm.icmp "ult" %19, %12 : vector<2xi8>
    %21 = llvm.add %arg0, %18  : vector<2xi8>
    %22 = llvm.icmp "ult" %21, %12 : vector<2xi8>
    %23 = llvm.or %20, %22  : vector<2xi1>
    llvm.return %23 : vector<2xi1>
  }]

def two_ranges_to_mask_and_range_degenerate_before := [llvmfunc|
  llvm.func @two_ranges_to_mask_and_range_degenerate(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(12 : i16) : i16
    %1 = llvm.mlir.constant(16 : i16) : i16
    %2 = llvm.mlir.constant(28 : i16) : i16
    %3 = llvm.icmp "ult" %arg0, %0 : i16
    %4 = llvm.icmp "uge" %arg0, %1 : i16
    %5 = llvm.icmp "ult" %arg0, %2 : i16
    %6 = llvm.and %4, %5  : i1
    %7 = llvm.or %3, %6  : i1
    llvm.return %7 : i1
  }]

def test47_before := [llvmfunc|
  llvm.func @test47(%arg0: i8 {llvm.signext}) -> i1 {
    %0 = llvm.mlir.constant(-65 : i8) : i8
    %1 = llvm.mlir.constant(26 : i8) : i8
    %2 = llvm.mlir.constant(-97 : i8) : i8
    %3 = llvm.add %arg0, %0  : i8
    %4 = llvm.icmp "ule" %3, %1 : i8
    %5 = llvm.add %arg0, %2  : i8
    %6 = llvm.icmp "ule" %5, %1 : i8
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }]

def test47_logical_before := [llvmfunc|
  llvm.func @test47_logical(%arg0: i8 {llvm.signext}) -> i1 {
    %0 = llvm.mlir.constant(-65 : i8) : i8
    %1 = llvm.mlir.constant(26 : i8) : i8
    %2 = llvm.mlir.constant(-97 : i8) : i8
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.add %arg0, %0  : i8
    %5 = llvm.icmp "ule" %4, %1 : i8
    %6 = llvm.add %arg0, %2  : i8
    %7 = llvm.icmp "ule" %6, %1 : i8
    %8 = llvm.select %5, %3, %7 : i1, i1
    llvm.return %8 : i1
  }]

def test47_nonuniform_before := [llvmfunc|
  llvm.func @test47_nonuniform(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[-65, -97]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<26> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<[-97, -65]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.add %arg0, %0  : vector<2xi8>
    %4 = llvm.icmp "ule" %3, %1 : vector<2xi8>
    %5 = llvm.add %arg0, %2  : vector<2xi8>
    %6 = llvm.icmp "ule" %5, %1 : vector<2xi8>
    %7 = llvm.or %4, %6  : vector<2xi1>
    llvm.return %7 : vector<2xi1>
  }]

def test49_before := [llvmfunc|
  llvm.func @test49(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1000 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.mlir.constant(123 : i32) : i32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    %4 = llvm.or %3, %2  : i32
    llvm.return %4 : i32
  }]

def test49vec_before := [llvmfunc|
  llvm.func @test49vec(%arg0: i1) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1000> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<10> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<123> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.select %arg0, %0, %1 : i1, vector<2xi32>
    %4 = llvm.or %3, %2  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def test49vec2_before := [llvmfunc|
  llvm.func @test49vec2(%arg0: i1) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[1000, 2500]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[10, 30]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<[123, 333]> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.select %arg0, %0, %1 : i1, vector<2xi32>
    %4 = llvm.or %3, %2  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def test50_before := [llvmfunc|
  llvm.func @test50(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1000 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.mlir.constant(123 : i32) : i32
    llvm.cond_br %arg0, ^bb2(%0 : i32), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%1 : i32)
  ^bb2(%3: i32):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.or %3, %2  : i32
    llvm.return %4 : i32
  }]

def test50vec_before := [llvmfunc|
  llvm.func @test50vec(%arg0: i1) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1000> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<10> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<123> : vector<2xi32>) : vector<2xi32>
    llvm.cond_br %arg0, ^bb2(%0 : vector<2xi32>), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%1 : vector<2xi32>)
  ^bb2(%3: vector<2xi32>):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.or %3, %2  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def test50vec2_before := [llvmfunc|
  llvm.func @test50vec2(%arg0: i1) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[1000, 2500]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[10, 30]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<[123, 333]> : vector<2xi32>) : vector<2xi32>
    llvm.cond_br %arg0, ^bb2(%0 : vector<2xi32>), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%1 : vector<2xi32>)
  ^bb2(%3: vector<2xi32>):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.or %3, %2  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def or_andn_cmp_1_before := [llvmfunc|
  llvm.func @or_andn_cmp_1(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i32
    %2 = llvm.icmp "sle" %arg0, %arg1 : i32
    %3 = llvm.icmp "ugt" %arg2, %0 : i32
    %4 = llvm.and %3, %2  : i1
    %5 = llvm.or %1, %4  : i1
    llvm.return %5 : i1
  }]

def or_andn_cmp_1_logical_before := [llvmfunc|
  llvm.func @or_andn_cmp_1_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "sgt" %arg0, %arg1 : i32
    %4 = llvm.icmp "sle" %arg0, %arg1 : i32
    %5 = llvm.icmp "ugt" %arg2, %0 : i32
    %6 = llvm.select %5, %4, %1 : i1, i1
    %7 = llvm.select %3, %2, %6 : i1, i1
    llvm.return %7 : i1
  }]

def or_andn_cmp_2_before := [llvmfunc|
  llvm.func @or_andn_cmp_2(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[42, 47]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "sge" %arg0, %arg1 : vector<2xi32>
    %2 = llvm.icmp "slt" %arg0, %arg1 : vector<2xi32>
    %3 = llvm.icmp "ugt" %arg2, %0 : vector<2xi32>
    %4 = llvm.and %3, %2  : vector<2xi1>
    %5 = llvm.or %4, %1  : vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }]

def or_andn_cmp_3_before := [llvmfunc|
  llvm.func @or_andn_cmp_3(%arg0: i72, %arg1: i72, %arg2: i72) -> i1 {
    %0 = llvm.mlir.constant(42 : i72) : i72
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i72
    %2 = llvm.icmp "ule" %arg0, %arg1 : i72
    %3 = llvm.icmp "ugt" %arg2, %0 : i72
    %4 = llvm.and %2, %3  : i1
    %5 = llvm.or %1, %4  : i1
    llvm.return %5 : i1
  }]

def or_andn_cmp_3_logical_before := [llvmfunc|
  llvm.func @or_andn_cmp_3_logical(%arg0: i72, %arg1: i72, %arg2: i72) -> i1 {
    %0 = llvm.mlir.constant(42 : i72) : i72
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "ugt" %arg0, %arg1 : i72
    %4 = llvm.icmp "ule" %arg0, %arg1 : i72
    %5 = llvm.icmp "ugt" %arg2, %0 : i72
    %6 = llvm.select %4, %5, %1 : i1, i1
    %7 = llvm.select %3, %2, %6 : i1, i1
    llvm.return %7 : i1
  }]

def or_andn_cmp_4_before := [llvmfunc|
  llvm.func @or_andn_cmp_4(%arg0: vector<3xi32>, %arg1: vector<3xi32>, %arg2: vector<3xi32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(dense<[42, 43, -1]> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.icmp "eq" %arg0, %arg1 : vector<3xi32>
    %2 = llvm.icmp "ne" %arg0, %arg1 : vector<3xi32>
    %3 = llvm.icmp "ugt" %arg2, %0 : vector<3xi32>
    %4 = llvm.and %2, %3  : vector<3xi1>
    %5 = llvm.or %4, %1  : vector<3xi1>
    llvm.return %5 : vector<3xi1>
  }]

def orn_and_cmp_1_before := [llvmfunc|
  llvm.func @orn_and_cmp_1(%arg0: i37, %arg1: i37, %arg2: i37) -> i1 {
    %0 = llvm.mlir.constant(42 : i37) : i37
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i37
    %2 = llvm.icmp "sle" %arg0, %arg1 : i37
    %3 = llvm.icmp "ugt" %arg2, %0 : i37
    %4 = llvm.and %3, %1  : i1
    %5 = llvm.or %2, %4  : i1
    llvm.return %5 : i1
  }]

def orn_and_cmp_1_logical_before := [llvmfunc|
  llvm.func @orn_and_cmp_1_logical(%arg0: i37, %arg1: i37, %arg2: i37) -> i1 {
    %0 = llvm.mlir.constant(42 : i37) : i37
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "sgt" %arg0, %arg1 : i37
    %4 = llvm.icmp "sle" %arg0, %arg1 : i37
    %5 = llvm.icmp "ugt" %arg2, %0 : i37
    %6 = llvm.select %5, %3, %1 : i1, i1
    %7 = llvm.select %4, %2, %6 : i1, i1
    llvm.return %7 : i1
  }]

def orn_and_cmp_2_before := [llvmfunc|
  llvm.func @orn_and_cmp_2(%arg0: i16, %arg1: i16, %arg2: i16) -> i1 {
    %0 = llvm.mlir.constant(42 : i16) : i16
    %1 = llvm.icmp "sge" %arg0, %arg1 : i16
    %2 = llvm.icmp "slt" %arg0, %arg1 : i16
    %3 = llvm.icmp "ugt" %arg2, %0 : i16
    %4 = llvm.and %3, %1  : i1
    %5 = llvm.or %4, %2  : i1
    llvm.return %5 : i1
  }]

def orn_and_cmp_2_logical_before := [llvmfunc|
  llvm.func @orn_and_cmp_2_logical(%arg0: i16, %arg1: i16, %arg2: i16) -> i1 {
    %0 = llvm.mlir.constant(42 : i16) : i16
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "sge" %arg0, %arg1 : i16
    %4 = llvm.icmp "slt" %arg0, %arg1 : i16
    %5 = llvm.icmp "ugt" %arg2, %0 : i16
    %6 = llvm.select %5, %3, %1 : i1, i1
    %7 = llvm.select %6, %2, %4 : i1, i1
    llvm.return %7 : i1
  }]

def orn_and_cmp_3_before := [llvmfunc|
  llvm.func @orn_and_cmp_3(%arg0: vector<4xi32>, %arg1: vector<4xi32>, %arg2: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<[42, 0, 1, -1]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.icmp "ugt" %arg0, %arg1 : vector<4xi32>
    %2 = llvm.icmp "ule" %arg0, %arg1 : vector<4xi32>
    %3 = llvm.icmp "ugt" %arg2, %0 : vector<4xi32>
    %4 = llvm.and %1, %3  : vector<4xi1>
    %5 = llvm.or %2, %4  : vector<4xi1>
    llvm.return %5 : vector<4xi1>
  }]

def orn_and_cmp_4_before := [llvmfunc|
  llvm.func @orn_and_cmp_4(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %arg1 : i32
    %2 = llvm.icmp "ne" %arg0, %arg1 : i32
    %3 = llvm.icmp "ugt" %arg2, %0 : i32
    %4 = llvm.and %1, %3  : i1
    %5 = llvm.or %4, %2  : i1
    llvm.return %5 : i1
  }]

def orn_and_cmp_4_logical_before := [llvmfunc|
  llvm.func @orn_and_cmp_4_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "eq" %arg0, %arg1 : i32
    %4 = llvm.icmp "ne" %arg0, %arg1 : i32
    %5 = llvm.icmp "ugt" %arg2, %0 : i32
    %6 = llvm.select %3, %5, %1 : i1, i1
    %7 = llvm.select %6, %2, %4 : i1, i1
    llvm.return %7 : i1
  }]

def test51_before := [llvmfunc|
  llvm.func @test51(%arg0: vector<16xi1>, %arg1: vector<16xi1>) -> vector<16xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(dense<[true, true, true, true, false, true, true, false, false, true, true, false, false, false, false, false]> : vector<16xi1>) : vector<16xi1>
    %3 = llvm.mlir.constant(dense<[false, false, false, false, true, false, false, true, true, false, false, true, true, true, true, true]> : vector<16xi1>) : vector<16xi1>
    %4 = llvm.and %arg0, %2  : vector<16xi1>
    %5 = llvm.and %arg1, %3  : vector<16xi1>
    %6 = llvm.or %4, %5  : vector<16xi1>
    llvm.return %6 : vector<16xi1>
  }]

def PR46712_before := [llvmfunc|
  llvm.func @PR46712(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i64) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.or %arg0, %arg1  : i1
    %5 = llvm.sext %4 : i1 to i32
    %6 = llvm.icmp "sge" %5, %0 : i32
    %7 = llvm.zext %6 : i1 to i64
    llvm.cond_br %arg2, ^bb1, ^bb2(%1 : i1)
  ^bb1:  // pred: ^bb0
    %8 = llvm.icmp "eq" %7, %2 : i64
    %9 = llvm.icmp "ne" %arg3, %2 : i64
    %10 = llvm.and %8, %9  : i1
    %11 = llvm.select %10, %1, %3 : i1, i1
    llvm.br ^bb2(%11 : i1)
  ^bb2(%12: i1):  // 2 preds: ^bb0, ^bb1
    %13 = llvm.zext %12 : i1 to i32
    llvm.return %13 : i32
  }]

def PR46712_logical_before := [llvmfunc|
  llvm.func @PR46712_logical(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i64) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.select %arg0, %0, %arg1 : i1, i1
    %5 = llvm.sext %4 : i1 to i32
    %6 = llvm.icmp "sge" %5, %1 : i32
    %7 = llvm.zext %6 : i1 to i64
    llvm.cond_br %arg2, ^bb1, ^bb2(%2 : i1)
  ^bb1:  // pred: ^bb0
    %8 = llvm.icmp "eq" %7, %3 : i64
    %9 = llvm.icmp "ne" %arg3, %3 : i64
    %10 = llvm.select %8, %9, %2 : i1, i1
    %11 = llvm.select %10, %2, %0 : i1, i1
    llvm.br ^bb2(%11 : i1)
  ^bb2(%12: i1):  // 2 preds: ^bb0, ^bb1
    %13 = llvm.zext %12 : i1 to i32
    llvm.return %13 : i32
  }]

def PR38929_before := [llvmfunc|
  llvm.func @PR38929(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.and %1, %arg1  : i32
    %3 = llvm.or %arg1, %arg0  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.or %2, %4  : i32
    llvm.return %5 : i32
  }]

def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %arg0  : i32
    %2 = llvm.or %arg1, %arg0  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.or %1, %3  : i32
    llvm.return %4 : i32
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg1, %arg0  : i32
    %4 = llvm.or %3, %2  : i32
    llvm.return %4 : i32
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg0, %arg1  : i32
    %4 = llvm.or %3, %2  : i32
    llvm.return %4 : i32
  }]

def test4_vec_before := [llvmfunc|
  llvm.func @test4_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.or %arg1, %arg0  : vector<2xi32>
    %2 = llvm.xor %1, %0  : vector<2xi32>
    %3 = llvm.xor %arg1, %arg0  : vector<2xi32>
    %4 = llvm.or %3, %2  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def test5_use_before := [llvmfunc|
  llvm.func @test5_use(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg1, %arg0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %4 = llvm.or %3, %2  : i32
    llvm.return %4 : i32
  }]

def test5_use2_before := [llvmfunc|
  llvm.func @test5_use2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg1, %arg0  : i32
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.or %3, %2  : i32
    llvm.return %4 : i32
  }]

def test5_use3_before := [llvmfunc|
  llvm.func @test5_use3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.xor %arg1, %arg0  : i32
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.or %3, %2  : i32
    llvm.return %4 : i32
  }]

def ashr_bitwidth_mask_before := [llvmfunc|
  llvm.func @ashr_bitwidth_mask(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    %2 = llvm.or %1, %arg1  : i8
    llvm.return %2 : i8
  }]

def ashr_bitwidth_mask_vec_commute_before := [llvmfunc|
  llvm.func @ashr_bitwidth_mask_vec_commute(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[42, 2]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<7> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mul %arg1, %0  : vector<2xi8>
    %3 = llvm.ashr %arg0, %1  : vector<2xi8>
    %4 = llvm.or %2, %3  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

def ashr_bitwidth_mask_use_before := [llvmfunc|
  llvm.func @ashr_bitwidth_mask_use(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.ashr %arg0, %0  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.or %1, %arg1  : i32
    llvm.return %2 : i32
  }]

def ashr_not_bitwidth_mask_before := [llvmfunc|
  llvm.func @ashr_not_bitwidth_mask(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    %2 = llvm.or %1, %arg1  : i8
    llvm.return %2 : i8
  }]

def lshr_bitwidth_mask_before := [llvmfunc|
  llvm.func @lshr_bitwidth_mask(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.lshr %arg0, %0  : i8
    %2 = llvm.or %1, %arg1  : i8
    llvm.return %2 : i8
  }]

def cmp_overlap_before := [llvmfunc|
  llvm.func @cmp_overlap(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.sub %0, %arg0  : i32
    %4 = llvm.icmp "sgt" %3, %1 : i32
    %5 = llvm.or %2, %4  : i1
    llvm.return %5 : i1
  }]

def cmp_overlap_splat_before := [llvmfunc|
  llvm.func @cmp_overlap_splat(%arg0: vector<2xi5>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i5) : i5
    %1 = llvm.mlir.constant(dense<0> : vector<2xi5>) : vector<2xi5>
    %2 = llvm.mlir.constant(-1 : i5) : i5
    %3 = llvm.mlir.constant(dense<-1> : vector<2xi5>) : vector<2xi5>
    %4 = llvm.icmp "slt" %arg0, %1 : vector<2xi5>
    %5 = llvm.sub %1, %arg0  : vector<2xi5>
    %6 = llvm.icmp "sgt" %5, %3 : vector<2xi5>
    %7 = llvm.or %4, %6  : vector<2xi1>
    llvm.return %7 : vector<2xi1>
  }]

def mul_no_common_bits_before := [llvmfunc|
  llvm.func @mul_no_common_bits(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.shl %arg1, %1  : i32
    %4 = llvm.mul %2, %3  : i32
    %5 = llvm.or %4, %2  : i32
    llvm.return %5 : i32
  }]

def mul_no_common_bits_const_op_before := [llvmfunc|
  llvm.func @mul_no_common_bits_const_op(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(24 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.mul %2, %1  : i32
    %4 = llvm.or %3, %2  : i32
    llvm.return %4 : i32
  }]

def mul_no_common_bits_commute_before := [llvmfunc|
  llvm.func @mul_no_common_bits_commute(%arg0: vector<2xi12>) -> vector<2xi12> {
    %0 = llvm.mlir.constant(1 : i12) : i12
    %1 = llvm.mlir.constant(dense<1> : vector<2xi12>) : vector<2xi12>
    %2 = llvm.mlir.constant(16 : i12) : i12
    %3 = llvm.mlir.constant(14 : i12) : i12
    %4 = llvm.mlir.constant(dense<[14, 16]> : vector<2xi12>) : vector<2xi12>
    %5 = llvm.and %arg0, %1  : vector<2xi12>
    %6 = llvm.mul %5, %4  : vector<2xi12>
    %7 = llvm.or %5, %6  : vector<2xi12>
    llvm.return %7 : vector<2xi12>
  }]

def mul_no_common_bits_commute2_before := [llvmfunc|
  llvm.func @mul_no_common_bits_commute2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.shl %arg1, %1  : i32
    %4 = llvm.mul %3, %2  : i32
    %5 = llvm.or %4, %2  : i32
    llvm.return %5 : i32
  }]

def mul_no_common_bits_disjoint_before := [llvmfunc|
  llvm.func @mul_no_common_bits_disjoint(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mul %arg0, %arg1  : i32
    %1 = llvm.or %0, %arg0  : i32
    llvm.return %1 : i32
  }]

def mul_no_common_bits_const_op_disjoint_before := [llvmfunc|
  llvm.func @mul_no_common_bits_const_op_disjoint(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.or %1, %arg0  : i32
    llvm.return %2 : i32
  }]

def mul_no_common_bits_uses_before := [llvmfunc|
  llvm.func @mul_no_common_bits_uses(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.shl %arg1, %1  : i32
    %4 = llvm.mul %2, %3  : i32
    llvm.call @use(%4) : (i32) -> ()
    %5 = llvm.or %4, %2  : i32
    llvm.return %5 : i32
  }]

def mul_no_common_bits_const_op_uses_before := [llvmfunc|
  llvm.func @mul_no_common_bits_const_op_uses(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(24 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.mul %2, %1  : i32
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.or %3, %2  : i32
    llvm.return %4 : i32
  }]

def mul_common_bits_before := [llvmfunc|
  llvm.func @mul_common_bits(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.mul %2, %1  : i32
    %4 = llvm.or %3, %2  : i32
    llvm.return %4 : i32
  }]

def and_or_not_or_logical_vec_before := [llvmfunc|
  llvm.func @and_or_not_or_logical_vec(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.constant(dense<true> : vector<4xi1>) : vector<4xi1>
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.mlir.constant(dense<false> : vector<4xi1>) : vector<4xi1>
    %6 = llvm.icmp "eq" %arg0, %1 : vector<4xi32>
    %7 = llvm.icmp "eq" %arg1, %1 : vector<4xi32>
    %8 = llvm.xor %6, %3  : vector<4xi1>
    %9 = llvm.select %7, %8, %5 : vector<4xi1>, vector<4xi1>
    %10 = llvm.or %7, %6  : vector<4xi1>
    %11 = llvm.xor %10, %3  : vector<4xi1>
    %12 = llvm.or %9, %11  : vector<4xi1>
    llvm.return %12 : vector<4xi1>
  }]

def drop_disjoint_before := [llvmfunc|
  llvm.func @drop_disjoint(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.or %2, %1  : i8
    llvm.return %3 : i8
  }]

def assoc_cast_assoc_disjoint_before := [llvmfunc|
  llvm.func @assoc_cast_assoc_disjoint(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.mlir.constant(65536 : i32) : i32
    %2 = llvm.or %arg0, %0  : i16
    %3 = llvm.zext %2 : i16 to i32
    %4 = llvm.or %3, %1  : i32
    llvm.return %4 : i32
  }]

def test_or_and_disjoint_before := [llvmfunc|
  llvm.func @test_or_and_disjoint(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(7 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %6 = llvm.and %arg0, %3  : i32
    %7 = llvm.or %6, %1  : i32
    llvm.return %7 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %2 : i32
  }]

def test_or_and_mixed_before := [llvmfunc|
  llvm.func @test_or_and_mixed(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(27 : i32) : i32
    %1 = llvm.mlir.constant(11 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(7 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %6 = llvm.and %arg0, %3  : i32
    %7 = llvm.or %6, %1  : i32
    llvm.return %7 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %2 : i32
  }]

def test_or_and_disjoint_fail_before := [llvmfunc|
  llvm.func @test_or_and_disjoint_fail(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(7 : i32) : i32
    %4 = llvm.mlir.constant(8 : i32) : i32
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    llvm.cond_br %6, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %7 = llvm.and %arg0, %3  : i32
    %8 = llvm.or %7, %4  : i32
    llvm.return %8 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %2 : i32
  }]

def test_or_and_disjoint_multiuse_before := [llvmfunc|
  llvm.func @test_or_and_disjoint_multiuse(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(7 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %6 = llvm.and %arg0, %3  : i32
    llvm.call @use(%6) : (i32) -> ()
    %7 = llvm.or %6, %1  : i32
    llvm.return %7 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %2 : i32
  }]

def test_or_and_xor_constant_before := [llvmfunc|
  llvm.func @test_or_and_xor_constant(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg1  : i32
    %4 = llvm.or %3, %1  : i32
    llvm.return %4 : i32
  }]

def test_or_and_xor_before := [llvmfunc|
  llvm.func @test_or_and_xor(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.xor %arg0, %arg1  : i32
    %1 = llvm.and %0, %arg2  : i32
    %2 = llvm.or %1, %arg0  : i32
    llvm.return %2 : i32
  }]

def test_or_and_xor_commuted1_before := [llvmfunc|
  llvm.func @test_or_and_xor_commuted1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.xor %arg1, %arg0  : i32
    %1 = llvm.and %0, %arg2  : i32
    %2 = llvm.or %1, %arg0  : i32
    llvm.return %2 : i32
  }]

def test_or_and_xor_commuted2_before := [llvmfunc|
  llvm.func @test_or_and_xor_commuted2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mul %arg2, %arg2  : i32
    %1 = llvm.xor %arg0, %arg1  : i32
    %2 = llvm.and %0, %1  : i32
    %3 = llvm.or %2, %arg0  : i32
    llvm.return %3 : i32
  }]

def test_or_and_xor_commuted3_before := [llvmfunc|
  llvm.func @test_or_and_xor_commuted3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mul %arg0, %arg0  : i32
    %1 = llvm.xor %0, %arg1  : i32
    %2 = llvm.and %1, %arg2  : i32
    %3 = llvm.or %0, %2  : i32
    llvm.return %3 : i32
  }]

def test_or_and_xor_multiuse1_before := [llvmfunc|
  llvm.func @test_or_and_xor_multiuse1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.xor %arg0, %arg1  : i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.and %0, %arg2  : i32
    %2 = llvm.or %1, %arg0  : i32
    llvm.return %2 : i32
  }]

def test_or_and_xor_mismatched_op_before := [llvmfunc|
  llvm.func @test_or_and_xor_mismatched_op(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.xor %arg0, %arg1  : i32
    %1 = llvm.and %0, %arg2  : i32
    %2 = llvm.or %1, %arg3  : i32
    llvm.return %2 : i32
  }]

def test_or_and_xor_multiuse2_before := [llvmfunc|
  llvm.func @test_or_and_xor_multiuse2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.xor %arg0, %arg1  : i32
    %1 = llvm.and %0, %arg2  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.or %1, %arg0  : i32
    llvm.return %2 : i32
  }]

def test_or_add_xor_before := [llvmfunc|
  llvm.func @test_or_add_xor(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.xor %arg0, %arg1  : i32
    %1 = llvm.add %0, %arg2  : i32
    %2 = llvm.or %1, %arg0  : i32
    llvm.return %2 : i32
  }]

def test_or_and_and_multiuse_before := [llvmfunc|
  llvm.func @test_or_and_and_multiuse(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.and %arg0, %arg1  : i32
    %1 = llvm.and %0, %arg2  : i32
    llvm.call @use(%0) : (i32) -> ()
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.or %1, %arg0  : i32
    llvm.return %2 : i32
  }]

def or_xor_and_before := [llvmfunc|
  llvm.func @or_xor_and(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.and %arg1, %arg2  : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.or %1, %arg1  : i32
    llvm.return %2 : i32
  }]

def or_xor_and_uses1_before := [llvmfunc|
  llvm.func @or_xor_and_uses1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.and %arg1, %arg2  : i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.or %1, %arg1  : i32
    llvm.return %2 : i32
  }]

def or_xor_and_uses2_before := [llvmfunc|
  llvm.func @or_xor_and_uses2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.and %arg1, %arg2  : i32
    %1 = llvm.xor %arg0, %0  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.or %1, %arg1  : i32
    llvm.return %2 : i32
  }]

def or_xor_and_commuted1_before := [llvmfunc|
  llvm.func @or_xor_and_commuted1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mul %arg1, %arg1  : i32
    %1 = llvm.and %0, %arg2  : i32
    %2 = llvm.xor %1, %arg0  : i32
    %3 = llvm.or %0, %2  : i32
    llvm.return %3 : i32
  }]

def or_xor_and_commuted2_before := [llvmfunc|
  llvm.func @or_xor_and_commuted2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mul %arg1, %arg1  : i32
    %1 = llvm.mul %arg0, %arg0  : i32
    %2 = llvm.and %0, %arg2  : i32
    %3 = llvm.xor %1, %2  : i32
    %4 = llvm.or %3, %0  : i32
    llvm.return %4 : i32
  }]

def or_xor_and_commuted3_before := [llvmfunc|
  llvm.func @or_xor_and_commuted3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mul %arg1, %arg1  : i32
    %1 = llvm.mul %arg2, %arg2  : i32
    %2 = llvm.and %1, %0  : i32
    %3 = llvm.xor %2, %arg0  : i32
    %4 = llvm.or %3, %0  : i32
    llvm.return %4 : i32
  }]

def test12_combined := [llvmfunc|
  llvm.func @test12(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test12   : test12_before  ⊑  test12_combined := by
  unfold test12_before test12_combined
  simp_alive_peephole
  sorry
def test13_combined := [llvmfunc|
  llvm.func @test13(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test13   : test13_before  ⊑  test13_combined := by
  unfold test13_before test13_combined
  simp_alive_peephole
  sorry
def test14_combined := [llvmfunc|
  llvm.func @test14(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "ne" %arg0, %arg1 : i32
    llvm.return %0 : i1
  }]

theorem inst_combine_test14   : test14_before  ⊑  test14_combined := by
  unfold test14_before test14_combined
  simp_alive_peephole
  sorry
def test14_commuted_combined := [llvmfunc|
  llvm.func @test14_commuted(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "ne" %arg1, %arg0 : i32
    llvm.return %0 : i1
  }]

theorem inst_combine_test14_commuted   : test14_commuted_before  ⊑  test14_commuted_combined := by
  unfold test14_commuted_before test14_commuted_combined
  simp_alive_peephole
  sorry
def test14_logical_combined := [llvmfunc|
  llvm.func @test14_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "ne" %arg0, %arg1 : i32
    llvm.return %0 : i1
  }]

theorem inst_combine_test14_logical   : test14_logical_before  ⊑  test14_logical_combined := by
  unfold test14_logical_before test14_logical_combined
  simp_alive_peephole
  sorry
def test15_combined := [llvmfunc|
  llvm.func @test15(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "ule" %arg0, %arg1 : i32
    llvm.return %0 : i1
  }]

theorem inst_combine_test15   : test15_before  ⊑  test15_combined := by
  unfold test15_before test15_combined
  simp_alive_peephole
  sorry
def test15_logical_combined := [llvmfunc|
  llvm.func @test15_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "ule" %arg0, %arg1 : i32
    llvm.return %0 : i1
  }]

theorem inst_combine_test15_logical   : test15_logical_before  ⊑  test15_logical_combined := by
  unfold test15_logical_before test15_logical_combined
  simp_alive_peephole
  sorry
def test16_combined := [llvmfunc|
  llvm.func @test16(%arg0: i32) -> i32 {
    llvm.return %arg0 : i32
  }]

theorem inst_combine_test16   : test16_before  ⊑  test16_combined := by
  unfold test16_before test16_combined
  simp_alive_peephole
  sorry
def test17_combined := [llvmfunc|
  llvm.func @test17(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test17   : test17_before  ⊑  test17_combined := by
  unfold test17_before test17_combined
  simp_alive_peephole
  sorry
def test18_combined := [llvmfunc|
  llvm.func @test18(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-100 : i32) : i32
    %1 = llvm.mlir.constant(-50 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_test18   : test18_before  ⊑  test18_combined := by
  unfold test18_before test18_combined
  simp_alive_peephole
  sorry
def test18_logical_combined := [llvmfunc|
  llvm.func @test18_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-100 : i32) : i32
    %1 = llvm.mlir.constant(-50 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_test18_logical   : test18_logical_before  ⊑  test18_logical_combined := by
  unfold test18_logical_before test18_logical_combined
  simp_alive_peephole
  sorry
def test18vec_combined := [llvmfunc|
  llvm.func @test18vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-100> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-50> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %arg0, %0  : vector<2xi32>
    %3 = llvm.icmp "ult" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_test18vec   : test18vec_before  ⊑  test18vec_combined := by
  unfold test18vec_before test18vec_combined
  simp_alive_peephole
  sorry
def test20_combined := [llvmfunc|
  llvm.func @test20(%arg0: i32) -> i32 {
    llvm.return %arg0 : i32
  }]

theorem inst_combine_test20   : test20_before  ⊑  test20_combined := by
  unfold test20_before test20_combined
  simp_alive_peephole
  sorry
def test21_combined := [llvmfunc|
  llvm.func @test21(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.add %3, %1  : i32
    %5 = llvm.and %arg0, %2  : i32
    %6 = llvm.or %5, %4  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_test21   : test21_before  ⊑  test21_combined := by
  unfold test21_before test21_combined
  simp_alive_peephole
  sorry
def test22_combined := [llvmfunc|
  llvm.func @test22(%arg0: i32) -> i32 {
    llvm.return %arg0 : i32
  }]

theorem inst_combine_test22   : test22_before  ⊑  test22_combined := by
  unfold test22_before test22_combined
  simp_alive_peephole
  sorry
def test23_combined := [llvmfunc|
  llvm.func @test23(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.mlir.constant(-24575 : i16) : i16
    %2 = llvm.lshr %arg0, %0  : i16
    %3 = llvm.xor %2, %1  : i16
    llvm.return %3 : i16
  }]

theorem inst_combine_test23   : test23_before  ⊑  test23_combined := by
  unfold test23_before test23_combined
  simp_alive_peephole
  sorry
def test23vec_combined := [llvmfunc|
  llvm.func @test23vec(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(dense<-24575> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.lshr %arg0, %0  : vector<2xi16>
    %3 = llvm.xor %2, %1  : vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

theorem inst_combine_test23vec   : test23vec_before  ⊑  test23vec_combined := by
  unfold test23vec_before test23vec_combined
  simp_alive_peephole
  sorry
def test25_combined := [llvmfunc|
  llvm.func @test25(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(57 : i32) : i32
    %2 = llvm.icmp "ne" %arg0, %0 : i32
    %3 = llvm.icmp "ne" %arg1, %1 : i32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_test25   : test25_before  ⊑  test25_combined := by
  unfold test25_before test25_combined
  simp_alive_peephole
  sorry
def test25_logical_combined := [llvmfunc|
  llvm.func @test25_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(57 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "ne" %arg0, %0 : i32
    %4 = llvm.icmp "ne" %arg1, %1 : i32
    %5 = llvm.select %3, %4, %2 : i1, i1
    llvm.return %5 : i1
  }]

theorem inst_combine_test25_logical   : test25_logical_before  ⊑  test25_logical_combined := by
  unfold test25_logical_before test25_logical_combined
  simp_alive_peephole
  sorry
def and_icmp_eq_0_combined := [llvmfunc|
  llvm.func @and_icmp_eq_0(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_and_icmp_eq_0   : and_icmp_eq_0_before  ⊑  and_icmp_eq_0_combined := by
  unfold and_icmp_eq_0_before and_icmp_eq_0_combined
  simp_alive_peephole
  sorry
def and_icmp_eq_0_vector_combined := [llvmfunc|
  llvm.func @and_icmp_eq_0_vector(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.or %arg0, %arg1  : vector<2xi32>
    %3 = llvm.icmp "eq" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_and_icmp_eq_0_vector   : and_icmp_eq_0_vector_before  ⊑  and_icmp_eq_0_vector_combined := by
  unfold and_icmp_eq_0_vector_before and_icmp_eq_0_vector_combined
  simp_alive_peephole
  sorry
def and_icmp_eq_0_vector_poison1_combined := [llvmfunc|
  llvm.func @and_icmp_eq_0_vector_poison1(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.or %arg0, %arg1  : vector<2xi32>
    %3 = llvm.icmp "eq" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_and_icmp_eq_0_vector_poison1   : and_icmp_eq_0_vector_poison1_before  ⊑  and_icmp_eq_0_vector_poison1_combined := by
  unfold and_icmp_eq_0_vector_poison1_before and_icmp_eq_0_vector_poison1_combined
  simp_alive_peephole
  sorry
def and_icmp_eq_0_vector_poison2_combined := [llvmfunc|
  llvm.func @and_icmp_eq_0_vector_poison2(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.or %arg0, %arg1  : vector<2xi32>
    %3 = llvm.icmp "eq" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_and_icmp_eq_0_vector_poison2   : and_icmp_eq_0_vector_poison2_before  ⊑  and_icmp_eq_0_vector_poison2_combined := by
  unfold and_icmp_eq_0_vector_poison2_before and_icmp_eq_0_vector_poison2_combined
  simp_alive_peephole
  sorry
def and_icmp_eq_0_logical_combined := [llvmfunc|
  llvm.func @and_icmp_eq_0_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.icmp "eq" %arg1, %0 : i32
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_and_icmp_eq_0_logical   : and_icmp_eq_0_logical_before  ⊑  and_icmp_eq_0_logical_combined := by
  unfold and_icmp_eq_0_logical_before and_icmp_eq_0_logical_combined
  simp_alive_peephole
  sorry
def test27_combined := [llvmfunc|
  llvm.func @test27(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %2 = llvm.icmp "eq" %arg1, %0 : !llvm.ptr
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_test27   : test27_before  ⊑  test27_combined := by
  unfold test27_before test27_combined
  simp_alive_peephole
  sorry
def test27vec_combined := [llvmfunc|
  llvm.func @test27vec(%arg0: !llvm.vec<2 x ptr>, %arg1: !llvm.vec<2 x ptr>) -> vector<2xi1> {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.undef : !llvm.vec<2 x ptr>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.insertelement %0, %1[%2 : i32] : !llvm.vec<2 x ptr>
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.insertelement %0, %3[%4 : i32] : !llvm.vec<2 x ptr>
    %6 = llvm.icmp "eq" %arg0, %5 : !llvm.vec<2 x ptr>
    %7 = llvm.icmp "eq" %arg1, %5 : !llvm.vec<2 x ptr>
    %8 = llvm.and %6, %7  : vector<2xi1>
    llvm.return %8 : vector<2xi1>
  }]

theorem inst_combine_test27vec   : test27vec_before  ⊑  test27vec_combined := by
  unfold test27vec_before test27vec_combined
  simp_alive_peephole
  sorry
def test28_combined := [llvmfunc|
  llvm.func @test28(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.icmp "ne" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_test28   : test28_before  ⊑  test28_combined := by
  unfold test28_before test28_combined
  simp_alive_peephole
  sorry
def test28_logical_combined := [llvmfunc|
  llvm.func @test28_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ne" %arg0, %0 : i32
    %3 = llvm.icmp "ne" %arg1, %0 : i32
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_test28_logical   : test28_logical_before  ⊑  test28_logical_combined := by
  unfold test28_logical_before test28_logical_combined
  simp_alive_peephole
  sorry
def test29_combined := [llvmfunc|
  llvm.func @test29(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %2 = llvm.icmp "ne" %arg1, %0 : !llvm.ptr
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_test29   : test29_before  ⊑  test29_combined := by
  unfold test29_before test29_combined
  simp_alive_peephole
  sorry
def test29vec_combined := [llvmfunc|
  llvm.func @test29vec(%arg0: !llvm.vec<2 x ptr>, %arg1: !llvm.vec<2 x ptr>) -> vector<2xi1> {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.undef : !llvm.vec<2 x ptr>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.insertelement %0, %1[%2 : i32] : !llvm.vec<2 x ptr>
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.insertelement %0, %3[%4 : i32] : !llvm.vec<2 x ptr>
    %6 = llvm.icmp "ne" %arg0, %5 : !llvm.vec<2 x ptr>
    %7 = llvm.icmp "ne" %arg1, %5 : !llvm.vec<2 x ptr>
    %8 = llvm.or %6, %7  : vector<2xi1>
    llvm.return %8 : vector<2xi1>
  }]

theorem inst_combine_test29vec   : test29vec_before  ⊑  test29vec_combined := by
  unfold test29vec_before test29vec_combined
  simp_alive_peephole
  sorry
def test30_combined := [llvmfunc|
  llvm.func @test30(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-58312 : i32) : i32
    %1 = llvm.mlir.constant(32962 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.or %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test30   : test30_before  ⊑  test30_combined := by
  unfold test30_before test30_combined
  simp_alive_peephole
  sorry
def test30vec_combined := [llvmfunc|
  llvm.func @test30vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-58312> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<32962> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.and %arg0, %0  : vector<2xi32>
    %3 = llvm.or %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_test30vec   : test30vec_before  ⊑  test30vec_combined := by
  unfold test30vec_before test30vec_combined
  simp_alive_peephole
  sorry
def test31_combined := [llvmfunc|
  llvm.func @test31(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(4294908984 : i64) : i64
    %1 = llvm.mlir.constant(32962 : i64) : i64
    %2 = llvm.and %arg0, %0  : i64
    %3 = llvm.or %2, %1  : i64
    llvm.return %3 : i64
  }]

theorem inst_combine_test31   : test31_before  ⊑  test31_combined := by
  unfold test31_before test31_combined
  simp_alive_peephole
  sorry
def test31vec_combined := [llvmfunc|
  llvm.func @test31vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<4294908984> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<32962> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.and %arg0, %0  : vector<2xi64>
    %3 = llvm.or %2, %1  : vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }]

theorem inst_combine_test31vec   : test31vec_before  ⊑  test31vec_combined := by
  unfold test31vec_before test31vec_combined
  simp_alive_peephole
  sorry
def test32_combined := [llvmfunc|
  llvm.func @test32(%arg0: vector<4xi1>, %arg1: vector<4xi32>, %arg2: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.select %arg0, %arg1, %arg2 : vector<4xi1>, vector<4xi32>
    llvm.return %0 : vector<4xi32>
  }]

theorem inst_combine_test32   : test32_before  ⊑  test32_combined := by
  unfold test32_before test32_combined
  simp_alive_peephole
  sorry
def test33_combined := [llvmfunc|
  llvm.func @test33(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.or %arg0, %arg1  : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test33   : test33_before  ⊑  test33_combined := by
  unfold test33_before test33_combined
  simp_alive_peephole
  sorry
def test33_logical_combined := [llvmfunc|
  llvm.func @test33_logical(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg1 : i1, i1
    llvm.return %1 : i1
  }]

theorem inst_combine_test33_logical   : test33_logical_before  ⊑  test33_logical_combined := by
  unfold test33_logical_before test33_logical_combined
  simp_alive_peephole
  sorry
def test34_combined := [llvmfunc|
  llvm.func @test34(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.or %arg0, %arg1  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test34   : test34_before  ⊑  test34_combined := by
  unfold test34_before test34_combined
  simp_alive_peephole
  sorry
def test35_combined := [llvmfunc|
  llvm.func @test35(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1135 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.or %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test35   : test35_before  ⊑  test35_combined := by
  unfold test35_before test35_combined
  simp_alive_peephole
  sorry
def test36_combined := [llvmfunc|
  llvm.func @test36(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-23 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_test36   : test36_before  ⊑  test36_combined := by
  unfold test36_before test36_combined
  simp_alive_peephole
  sorry
def test36_logical_combined := [llvmfunc|
  llvm.func @test36_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-23 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_test36_logical   : test36_logical_before  ⊑  test36_logical_combined := by
  unfold test36_logical_before test36_logical_combined
  simp_alive_peephole
  sorry
def test37_combined := [llvmfunc|
  llvm.func @test37(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_test37   : test37_before  ⊑  test37_combined := by
  unfold test37_before test37_combined
  simp_alive_peephole
  sorry
def test37_logical_combined := [llvmfunc|
  llvm.func @test37_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_test37_logical   : test37_logical_before  ⊑  test37_logical_combined := by
  unfold test37_logical_before test37_logical_combined
  simp_alive_peephole
  sorry
def test37_uniform_combined := [llvmfunc|
  llvm.func @test37_uniform(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<31> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %arg0, %0  : vector<2xi32>
    %3 = llvm.icmp "ult" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_test37_uniform   : test37_uniform_before  ⊑  test37_uniform_combined := by
  unfold test37_uniform_before test37_uniform_combined
  simp_alive_peephole
  sorry
def test37_poison_combined := [llvmfunc|
  llvm.func @test37_poison(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(30 : i32) : i32
    %8 = llvm.mlir.undef : vector<2xi32>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %7, %8[%9 : i32] : vector<2xi32>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<2xi32>
    %13 = llvm.mlir.constant(23 : i32) : i32
    %14 = llvm.mlir.undef : vector<2xi32>
    %15 = llvm.mlir.constant(0 : i32) : i32
    %16 = llvm.insertelement %13, %14[%15 : i32] : vector<2xi32>
    %17 = llvm.mlir.constant(1 : i32) : i32
    %18 = llvm.insertelement %0, %16[%17 : i32] : vector<2xi32>
    %19 = llvm.add %arg0, %6  : vector<2xi32>
    %20 = llvm.icmp "ult" %19, %12 : vector<2xi32>
    %21 = llvm.icmp "eq" %arg0, %18 : vector<2xi32>
    %22 = llvm.or %20, %21  : vector<2xi1>
    llvm.return %22 : vector<2xi1>
  }]

theorem inst_combine_test37_poison   : test37_poison_before  ⊑  test37_poison_combined := by
  unfold test37_poison_before test37_poison_combined
  simp_alive_peephole
  sorry
def test38_combined := [llvmfunc|
  llvm.func @test38(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_test38   : test38_before  ⊑  test38_combined := by
  unfold test38_before test38_combined
  simp_alive_peephole
  sorry
def test38_logical_combined := [llvmfunc|
  llvm.func @test38_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_test38_logical   : test38_logical_before  ⊑  test38_logical_combined := by
  unfold test38_logical_before test38_logical_combined
  simp_alive_peephole
  sorry
def test38_nonuniform_combined := [llvmfunc|
  llvm.func @test38_nonuniform(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[7, 24]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[23, 8]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<[30, 32]> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.add %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "eq" %arg0, %1 : vector<2xi32>
    %5 = llvm.icmp "ult" %3, %2 : vector<2xi32>
    %6 = llvm.or %4, %5  : vector<2xi1>
    llvm.return %6 : vector<2xi1>
  }]

theorem inst_combine_test38_nonuniform   : test38_nonuniform_before  ⊑  test38_nonuniform_combined := by
  unfold test38_nonuniform_before test38_nonuniform_combined
  simp_alive_peephole
  sorry
def test39a_combined := [llvmfunc|
  llvm.func @test39a(%arg0: i32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.bitcast %arg1 : f32 to i32
    %3 = llvm.or %1, %2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test39a   : test39a_before  ⊑  test39a_combined := by
  unfold test39a_before test39a_combined
  simp_alive_peephole
  sorry
def test39b_combined := [llvmfunc|
  llvm.func @test39b(%arg0: i32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.bitcast %arg1 : f32 to i32
    %3 = llvm.or %1, %2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test39b   : test39b_before  ⊑  test39b_combined := by
  unfold test39b_before test39b_combined
  simp_alive_peephole
  sorry
def test39c_combined := [llvmfunc|
  llvm.func @test39c(%arg0: i32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.bitcast %arg1 : f32 to i32
    %3 = llvm.or %1, %2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test39c   : test39c_before  ⊑  test39c_combined := by
  unfold test39c_before test39c_combined
  simp_alive_peephole
  sorry
def test39d_combined := [llvmfunc|
  llvm.func @test39d(%arg0: i32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.bitcast %arg1 : f32 to i32
    %3 = llvm.or %1, %2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test39d   : test39d_before  ⊑  test39d_combined := by
  unfold test39d_before test39d_combined
  simp_alive_peephole
  sorry
def test40_combined := [llvmfunc|
  llvm.func @test40(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.or %1, %arg1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test40   : test40_before  ⊑  test40_combined := by
  unfold test40_before test40_combined
  simp_alive_peephole
  sorry
def test40b_combined := [llvmfunc|
  llvm.func @test40b(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.or %1, %arg1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test40b   : test40b_before  ⊑  test40b_combined := by
  unfold test40b_before test40b_combined
  simp_alive_peephole
  sorry
def test40c_combined := [llvmfunc|
  llvm.func @test40c(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.or %1, %arg1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test40c   : test40c_before  ⊑  test40c_combined := by
  unfold test40c_before test40c_combined
  simp_alive_peephole
  sorry
def test40d_combined := [llvmfunc|
  llvm.func @test40d(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.or %1, %arg1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test40d   : test40d_before  ⊑  test40d_combined := by
  unfold test40d_before test40d_combined
  simp_alive_peephole
  sorry
def test45_combined := [llvmfunc|
  llvm.func @test45(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.and %arg0, %arg2  : i32
    %1 = llvm.or %0, %arg1  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test45   : test45_before  ⊑  test45_combined := by
  unfold test45_before test45_combined
  simp_alive_peephole
  sorry
def test45_uses1_combined := [llvmfunc|
  llvm.func @test45_uses1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.or %arg1, %arg2  : i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.and %arg0, %arg2  : i32
    %2 = llvm.or %1, %arg1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test45_uses1   : test45_uses1_before  ⊑  test45_uses1_combined := by
  unfold test45_uses1_before test45_uses1_combined
  simp_alive_peephole
  sorry
def test45_uses2_combined := [llvmfunc|
  llvm.func @test45_uses2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.or %arg1, %arg2  : i32
    %1 = llvm.and %0, %arg0  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.and %arg0, %arg2  : i32
    %3 = llvm.or %2, %arg1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test45_uses2   : test45_uses2_before  ⊑  test45_uses2_combined := by
  unfold test45_uses2_before test45_uses2_combined
  simp_alive_peephole
  sorry
def test45_commuted1_combined := [llvmfunc|
  llvm.func @test45_commuted1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mul %arg1, %arg1  : i32
    %1 = llvm.and %arg0, %arg2  : i32
    %2 = llvm.or %0, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test45_commuted1   : test45_commuted1_before  ⊑  test45_commuted1_combined := by
  unfold test45_commuted1_before test45_commuted1_combined
  simp_alive_peephole
  sorry
def test45_commuted2_combined := [llvmfunc|
  llvm.func @test45_commuted2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mul %arg1, %arg1  : i32
    %1 = llvm.mul %arg0, %arg0  : i32
    %2 = llvm.and %1, %arg2  : i32
    %3 = llvm.or %0, %2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test45_commuted2   : test45_commuted2_before  ⊑  test45_commuted2_combined := by
  unfold test45_commuted2_before test45_commuted2_combined
  simp_alive_peephole
  sorry
def test45_commuted3_combined := [llvmfunc|
  llvm.func @test45_commuted3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mul %arg1, %arg1  : i32
    %1 = llvm.mul %arg2, %arg2  : i32
    %2 = llvm.and %1, %arg0  : i32
    %3 = llvm.or %0, %2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test45_commuted3   : test45_commuted3_before  ⊑  test45_commuted3_combined := by
  unfold test45_commuted3_before test45_commuted3_combined
  simp_alive_peephole
  sorry
def test46_combined := [llvmfunc|
  llvm.func @test46(%arg0: i8 {llvm.signext}) -> i1 {
    %0 = llvm.mlir.constant(-33 : i8) : i8
    %1 = llvm.mlir.constant(-65 : i8) : i8
    %2 = llvm.mlir.constant(26 : i8) : i8
    %3 = llvm.and %arg0, %0  : i8
    %4 = llvm.add %3, %1  : i8
    %5 = llvm.icmp "ult" %4, %2 : i8
    llvm.return %5 : i1
  }]

theorem inst_combine_test46   : test46_before  ⊑  test46_combined := by
  unfold test46_before test46_combined
  simp_alive_peephole
  sorry
def test46_logical_combined := [llvmfunc|
  llvm.func @test46_logical(%arg0: i8 {llvm.signext}) -> i1 {
    %0 = llvm.mlir.constant(-33 : i8) : i8
    %1 = llvm.mlir.constant(-65 : i8) : i8
    %2 = llvm.mlir.constant(26 : i8) : i8
    %3 = llvm.and %arg0, %0  : i8
    %4 = llvm.add %3, %1  : i8
    %5 = llvm.icmp "ult" %4, %2 : i8
    llvm.return %5 : i1
  }]

theorem inst_combine_test46_logical   : test46_logical_before  ⊑  test46_logical_combined := by
  unfold test46_logical_before test46_logical_combined
  simp_alive_peephole
  sorry
def test46_uniform_combined := [llvmfunc|
  llvm.func @test46_uniform(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-33> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-65> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<26> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.and %arg0, %0  : vector<2xi8>
    %4 = llvm.add %3, %1  : vector<2xi8>
    %5 = llvm.icmp "ult" %4, %2 : vector<2xi8>
    llvm.return %5 : vector<2xi1>
  }]

theorem inst_combine_test46_uniform   : test46_uniform_before  ⊑  test46_uniform_combined := by
  unfold test46_uniform_before test46_uniform_combined
  simp_alive_peephole
  sorry
def test46_poison_combined := [llvmfunc|
  llvm.func @test46_poison(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(-97 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(26 : i8) : i8
    %8 = llvm.mlir.undef : vector<2xi8>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %7, %8[%9 : i32] : vector<2xi8>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<2xi8>
    %13 = llvm.mlir.constant(-65 : i8) : i8
    %14 = llvm.mlir.undef : vector<2xi8>
    %15 = llvm.mlir.constant(0 : i32) : i32
    %16 = llvm.insertelement %13, %14[%15 : i32] : vector<2xi8>
    %17 = llvm.mlir.constant(1 : i32) : i32
    %18 = llvm.insertelement %0, %16[%17 : i32] : vector<2xi8>
    %19 = llvm.add %arg0, %6  : vector<2xi8>
    %20 = llvm.icmp "ult" %19, %12 : vector<2xi8>
    %21 = llvm.add %arg0, %18  : vector<2xi8>
    %22 = llvm.icmp "ult" %21, %12 : vector<2xi8>
    %23 = llvm.or %20, %22  : vector<2xi1>
    llvm.return %23 : vector<2xi1>
  }]

theorem inst_combine_test46_poison   : test46_poison_before  ⊑  test46_poison_combined := by
  unfold test46_poison_before test46_poison_combined
  simp_alive_peephole
  sorry
def two_ranges_to_mask_and_range_degenerate_combined := [llvmfunc|
  llvm.func @two_ranges_to_mask_and_range_degenerate(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(-20 : i16) : i16
    %1 = llvm.mlir.constant(12 : i16) : i16
    %2 = llvm.and %arg0, %0  : i16
    %3 = llvm.icmp "ult" %2, %1 : i16
    llvm.return %3 : i1
  }]

theorem inst_combine_two_ranges_to_mask_and_range_degenerate   : two_ranges_to_mask_and_range_degenerate_before  ⊑  two_ranges_to_mask_and_range_degenerate_combined := by
  unfold two_ranges_to_mask_and_range_degenerate_before two_ranges_to_mask_and_range_degenerate_combined
  simp_alive_peephole
  sorry
def test47_combined := [llvmfunc|
  llvm.func @test47(%arg0: i8 {llvm.signext}) -> i1 {
    %0 = llvm.mlir.constant(-33 : i8) : i8
    %1 = llvm.mlir.constant(-65 : i8) : i8
    %2 = llvm.mlir.constant(27 : i8) : i8
    %3 = llvm.and %arg0, %0  : i8
    %4 = llvm.add %3, %1  : i8
    %5 = llvm.icmp "ult" %4, %2 : i8
    llvm.return %5 : i1
  }]

theorem inst_combine_test47   : test47_before  ⊑  test47_combined := by
  unfold test47_before test47_combined
  simp_alive_peephole
  sorry
def test47_logical_combined := [llvmfunc|
  llvm.func @test47_logical(%arg0: i8 {llvm.signext}) -> i1 {
    %0 = llvm.mlir.constant(-33 : i8) : i8
    %1 = llvm.mlir.constant(-65 : i8) : i8
    %2 = llvm.mlir.constant(27 : i8) : i8
    %3 = llvm.and %arg0, %0  : i8
    %4 = llvm.add %3, %1  : i8
    %5 = llvm.icmp "ult" %4, %2 : i8
    llvm.return %5 : i1
  }]

theorem inst_combine_test47_logical   : test47_logical_before  ⊑  test47_logical_combined := by
  unfold test47_logical_before test47_logical_combined
  simp_alive_peephole
  sorry
def test47_nonuniform_combined := [llvmfunc|
  llvm.func @test47_nonuniform(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[-65, -97]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<27> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<[-97, -65]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.add %arg0, %0  : vector<2xi8>
    %4 = llvm.icmp "ult" %3, %1 : vector<2xi8>
    %5 = llvm.add %arg0, %2  : vector<2xi8>
    %6 = llvm.icmp "ult" %5, %1 : vector<2xi8>
    %7 = llvm.or %4, %6  : vector<2xi1>
    llvm.return %7 : vector<2xi1>
  }]

theorem inst_combine_test47_nonuniform   : test47_nonuniform_before  ⊑  test47_nonuniform_combined := by
  unfold test47_nonuniform_before test47_nonuniform_combined
  simp_alive_peephole
  sorry
def test49_combined := [llvmfunc|
  llvm.func @test49(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1019 : i32) : i32
    %1 = llvm.mlir.constant(123 : i32) : i32
    %2 = llvm.select %arg0, %0, %1 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test49   : test49_before  ⊑  test49_combined := by
  unfold test49_before test49_combined
  simp_alive_peephole
  sorry
def test49vec_combined := [llvmfunc|
  llvm.func @test49vec(%arg0: i1) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1019> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<123> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.select %arg0, %0, %1 : i1, vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_test49vec   : test49vec_before  ⊑  test49vec_combined := by
  unfold test49vec_before test49vec_combined
  simp_alive_peephole
  sorry
def test49vec2_combined := [llvmfunc|
  llvm.func @test49vec2(%arg0: i1) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[1019, 2509]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[123, 351]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.select %arg0, %0, %1 : i1, vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_test49vec2   : test49vec2_before  ⊑  test49vec2_combined := by
  unfold test49vec2_before test49vec2_combined
  simp_alive_peephole
  sorry
def test50_combined := [llvmfunc|
  llvm.func @test50(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1019 : i32) : i32
    %1 = llvm.mlir.constant(123 : i32) : i32
    llvm.cond_br %arg0, ^bb2(%0 : i32), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%1 : i32)
  ^bb2(%2: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : i32
  }]

theorem inst_combine_test50   : test50_before  ⊑  test50_combined := by
  unfold test50_before test50_combined
  simp_alive_peephole
  sorry
def test50vec_combined := [llvmfunc|
  llvm.func @test50vec(%arg0: i1) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1019> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<123> : vector<2xi32>) : vector<2xi32>
    llvm.cond_br %arg0, ^bb2(%0 : vector<2xi32>), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%1 : vector<2xi32>)
  ^bb2(%2: vector<2xi32>):  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_test50vec   : test50vec_before  ⊑  test50vec_combined := by
  unfold test50vec_before test50vec_combined
  simp_alive_peephole
  sorry
def test50vec2_combined := [llvmfunc|
  llvm.func @test50vec2(%arg0: i1) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[1019, 2509]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[123, 351]> : vector<2xi32>) : vector<2xi32>
    llvm.cond_br %arg0, ^bb2(%0 : vector<2xi32>), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%1 : vector<2xi32>)
  ^bb2(%2: vector<2xi32>):  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_test50vec2   : test50vec2_before  ⊑  test50vec2_combined := by
  unfold test50vec2_before test50vec2_combined
  simp_alive_peephole
  sorry
def or_andn_cmp_1_combined := [llvmfunc|
  llvm.func @or_andn_cmp_1(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i32
    %2 = llvm.icmp "ugt" %arg2, %0 : i32
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_or_andn_cmp_1   : or_andn_cmp_1_before  ⊑  or_andn_cmp_1_combined := by
  unfold or_andn_cmp_1_before or_andn_cmp_1_combined
  simp_alive_peephole
  sorry
def or_andn_cmp_1_logical_combined := [llvmfunc|
  llvm.func @or_andn_cmp_1_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "sgt" %arg0, %arg1 : i32
    %3 = llvm.icmp "ugt" %arg2, %0 : i32
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_or_andn_cmp_1_logical   : or_andn_cmp_1_logical_before  ⊑  or_andn_cmp_1_logical_combined := by
  unfold or_andn_cmp_1_logical_before or_andn_cmp_1_logical_combined
  simp_alive_peephole
  sorry
def or_andn_cmp_2_combined := [llvmfunc|
  llvm.func @or_andn_cmp_2(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[42, 47]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "sge" %arg0, %arg1 : vector<2xi32>
    %2 = llvm.icmp "ugt" %arg2, %0 : vector<2xi32>
    %3 = llvm.or %2, %1  : vector<2xi1>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_or_andn_cmp_2   : or_andn_cmp_2_before  ⊑  or_andn_cmp_2_combined := by
  unfold or_andn_cmp_2_before or_andn_cmp_2_combined
  simp_alive_peephole
  sorry
def or_andn_cmp_3_combined := [llvmfunc|
  llvm.func @or_andn_cmp_3(%arg0: i72, %arg1: i72, %arg2: i72) -> i1 {
    %0 = llvm.mlir.constant(42 : i72) : i72
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i72
    %2 = llvm.icmp "ugt" %arg2, %0 : i72
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_or_andn_cmp_3   : or_andn_cmp_3_before  ⊑  or_andn_cmp_3_combined := by
  unfold or_andn_cmp_3_before or_andn_cmp_3_combined
  simp_alive_peephole
  sorry
def or_andn_cmp_3_logical_combined := [llvmfunc|
  llvm.func @or_andn_cmp_3_logical(%arg0: i72, %arg1: i72, %arg2: i72) -> i1 {
    %0 = llvm.mlir.constant(42 : i72) : i72
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ugt" %arg0, %arg1 : i72
    %3 = llvm.icmp "ugt" %arg2, %0 : i72
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_or_andn_cmp_3_logical   : or_andn_cmp_3_logical_before  ⊑  or_andn_cmp_3_logical_combined := by
  unfold or_andn_cmp_3_logical_before or_andn_cmp_3_logical_combined
  simp_alive_peephole
  sorry
def or_andn_cmp_4_combined := [llvmfunc|
  llvm.func @or_andn_cmp_4(%arg0: vector<3xi32>, %arg1: vector<3xi32>, %arg2: vector<3xi32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(dense<[42, 43, -1]> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.icmp "eq" %arg0, %arg1 : vector<3xi32>
    %2 = llvm.icmp "ugt" %arg2, %0 : vector<3xi32>
    %3 = llvm.or %2, %1  : vector<3xi1>
    llvm.return %3 : vector<3xi1>
  }]

theorem inst_combine_or_andn_cmp_4   : or_andn_cmp_4_before  ⊑  or_andn_cmp_4_combined := by
  unfold or_andn_cmp_4_before or_andn_cmp_4_combined
  simp_alive_peephole
  sorry
def orn_and_cmp_1_combined := [llvmfunc|
  llvm.func @orn_and_cmp_1(%arg0: i37, %arg1: i37, %arg2: i37) -> i1 {
    %0 = llvm.mlir.constant(42 : i37) : i37
    %1 = llvm.icmp "sle" %arg0, %arg1 : i37
    %2 = llvm.icmp "ugt" %arg2, %0 : i37
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_orn_and_cmp_1   : orn_and_cmp_1_before  ⊑  orn_and_cmp_1_combined := by
  unfold orn_and_cmp_1_before orn_and_cmp_1_combined
  simp_alive_peephole
  sorry
def orn_and_cmp_1_logical_combined := [llvmfunc|
  llvm.func @orn_and_cmp_1_logical(%arg0: i37, %arg1: i37, %arg2: i37) -> i1 {
    %0 = llvm.mlir.constant(42 : i37) : i37
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "sle" %arg0, %arg1 : i37
    %3 = llvm.icmp "ugt" %arg2, %0 : i37
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_orn_and_cmp_1_logical   : orn_and_cmp_1_logical_before  ⊑  orn_and_cmp_1_logical_combined := by
  unfold orn_and_cmp_1_logical_before orn_and_cmp_1_logical_combined
  simp_alive_peephole
  sorry
def orn_and_cmp_2_combined := [llvmfunc|
  llvm.func @orn_and_cmp_2(%arg0: i16, %arg1: i16, %arg2: i16) -> i1 {
    %0 = llvm.mlir.constant(42 : i16) : i16
    %1 = llvm.icmp "slt" %arg0, %arg1 : i16
    %2 = llvm.icmp "ugt" %arg2, %0 : i16
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_orn_and_cmp_2   : orn_and_cmp_2_before  ⊑  orn_and_cmp_2_combined := by
  unfold orn_and_cmp_2_before orn_and_cmp_2_combined
  simp_alive_peephole
  sorry
def orn_and_cmp_2_logical_combined := [llvmfunc|
  llvm.func @orn_and_cmp_2_logical(%arg0: i16, %arg1: i16, %arg2: i16) -> i1 {
    %0 = llvm.mlir.constant(42 : i16) : i16
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "slt" %arg0, %arg1 : i16
    %3 = llvm.icmp "ugt" %arg2, %0 : i16
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_orn_and_cmp_2_logical   : orn_and_cmp_2_logical_before  ⊑  orn_and_cmp_2_logical_combined := by
  unfold orn_and_cmp_2_logical_before orn_and_cmp_2_logical_combined
  simp_alive_peephole
  sorry
def orn_and_cmp_3_combined := [llvmfunc|
  llvm.func @orn_and_cmp_3(%arg0: vector<4xi32>, %arg1: vector<4xi32>, %arg2: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<[42, 0, 1, -1]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.icmp "ule" %arg0, %arg1 : vector<4xi32>
    %2 = llvm.icmp "ugt" %arg2, %0 : vector<4xi32>
    %3 = llvm.or %1, %2  : vector<4xi1>
    llvm.return %3 : vector<4xi1>
  }]

theorem inst_combine_orn_and_cmp_3   : orn_and_cmp_3_before  ⊑  orn_and_cmp_3_combined := by
  unfold orn_and_cmp_3_before orn_and_cmp_3_combined
  simp_alive_peephole
  sorry
def orn_and_cmp_4_combined := [llvmfunc|
  llvm.func @orn_and_cmp_4(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %arg1 : i32
    %2 = llvm.icmp "ugt" %arg2, %0 : i32
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_orn_and_cmp_4   : orn_and_cmp_4_before  ⊑  orn_and_cmp_4_combined := by
  unfold orn_and_cmp_4_before orn_and_cmp_4_combined
  simp_alive_peephole
  sorry
def orn_and_cmp_4_logical_combined := [llvmfunc|
  llvm.func @orn_and_cmp_4_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ne" %arg0, %arg1 : i32
    %3 = llvm.icmp "ugt" %arg2, %0 : i32
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_orn_and_cmp_4_logical   : orn_and_cmp_4_logical_before  ⊑  orn_and_cmp_4_logical_combined := by
  unfold orn_and_cmp_4_logical_before orn_and_cmp_4_logical_combined
  simp_alive_peephole
  sorry
def test51_combined := [llvmfunc|
  llvm.func @test51(%arg0: vector<16xi1>, %arg1: vector<16xi1>) -> vector<16xi1> {
    %0 = llvm.shufflevector %arg0, %arg1 [0, 1, 2, 3, 20, 5, 6, 23, 24, 9, 10, 27, 28, 29, 30, 31] : vector<16xi1> 
    llvm.return %0 : vector<16xi1>
  }]

theorem inst_combine_test51   : test51_before  ⊑  test51_combined := by
  unfold test51_before test51_combined
  simp_alive_peephole
  sorry
def PR46712_combined := [llvmfunc|
  llvm.func @PR46712(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i64) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    llvm.cond_br %arg2, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    %2 = llvm.icmp "eq" %arg3, %1 : i64
    %3 = llvm.zext %2 : i1 to i32
    llvm.br ^bb2(%3 : i32)
  ^bb2(%4: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i32
  }]

theorem inst_combine_PR46712   : PR46712_before  ⊑  PR46712_combined := by
  unfold PR46712_before PR46712_combined
  simp_alive_peephole
  sorry
def PR46712_logical_combined := [llvmfunc|
  llvm.func @PR46712_logical(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i64) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    llvm.cond_br %arg2, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    %2 = llvm.icmp "eq" %arg3, %1 : i64
    %3 = llvm.zext %2 : i1 to i32
    llvm.br ^bb2(%3 : i32)
  ^bb2(%4: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i32
  }]

theorem inst_combine_PR46712_logical   : PR46712_logical_before  ⊑  PR46712_logical_combined := by
  unfold PR46712_logical_before PR46712_logical_combined
  simp_alive_peephole
  sorry
def PR38929_combined := [llvmfunc|
  llvm.func @PR38929(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_PR38929   : PR38929_before  ⊑  PR38929_combined := by
  unfold PR38929_before PR38929_combined
  simp_alive_peephole
  sorry
def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test4_vec_combined := [llvmfunc|
  llvm.func @test4_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.and %arg1, %arg0  : vector<2xi32>
    %2 = llvm.xor %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_test4_vec   : test4_vec_before  ⊑  test4_vec_combined := by
  unfold test4_vec_before test4_vec_combined
  simp_alive_peephole
  sorry
def test5_use_combined := [llvmfunc|
  llvm.func @test5_use(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.and %arg1, %arg0  : i32
    %4 = llvm.xor %3, %0  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_test5_use   : test5_use_before  ⊑  test5_use_combined := by
  unfold test5_use_before test5_use_combined
  simp_alive_peephole
  sorry
def test5_use2_combined := [llvmfunc|
  llvm.func @test5_use2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %arg0  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.and %arg1, %arg0  : i32
    %3 = llvm.xor %2, %0  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test5_use2   : test5_use2_before  ⊑  test5_use2_combined := by
  unfold test5_use2_before test5_use2_combined
  simp_alive_peephole
  sorry
def test5_use3_combined := [llvmfunc|
  llvm.func @test5_use3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.xor %arg1, %arg0  : i32
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.or %3, %2  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_test5_use3   : test5_use3_before  ⊑  test5_use3_combined := by
  unfold test5_use3_before test5_use3_combined
  simp_alive_peephole
  sorry
def ashr_bitwidth_mask_combined := [llvmfunc|
  llvm.func @ashr_bitwidth_mask(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    %2 = llvm.or %1, %arg1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_ashr_bitwidth_mask   : ashr_bitwidth_mask_before  ⊑  ashr_bitwidth_mask_combined := by
  unfold ashr_bitwidth_mask_before ashr_bitwidth_mask_combined
  simp_alive_peephole
  sorry
def ashr_bitwidth_mask_vec_commute_combined := [llvmfunc|
  llvm.func @ashr_bitwidth_mask_vec_commute(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[42, 2]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<7> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mul %arg1, %0  : vector<2xi8>
    %3 = llvm.ashr %arg0, %1  : vector<2xi8>
    %4 = llvm.or %2, %3  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

theorem inst_combine_ashr_bitwidth_mask_vec_commute   : ashr_bitwidth_mask_vec_commute_before  ⊑  ashr_bitwidth_mask_vec_commute_combined := by
  unfold ashr_bitwidth_mask_vec_commute_before ashr_bitwidth_mask_vec_commute_combined
  simp_alive_peephole
  sorry
def ashr_bitwidth_mask_use_combined := [llvmfunc|
  llvm.func @ashr_bitwidth_mask_use(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.ashr %arg0, %0  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.or %1, %arg1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_ashr_bitwidth_mask_use   : ashr_bitwidth_mask_use_before  ⊑  ashr_bitwidth_mask_use_combined := by
  unfold ashr_bitwidth_mask_use_before ashr_bitwidth_mask_use_combined
  simp_alive_peephole
  sorry
def ashr_not_bitwidth_mask_combined := [llvmfunc|
  llvm.func @ashr_not_bitwidth_mask(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    %2 = llvm.or %1, %arg1  : i8
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
    %2 = llvm.or %1, %arg1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_lshr_bitwidth_mask   : lshr_bitwidth_mask_before  ⊑  lshr_bitwidth_mask_combined := by
  unfold lshr_bitwidth_mask_before lshr_bitwidth_mask_combined
  simp_alive_peephole
  sorry
def cmp_overlap_combined := [llvmfunc|
  llvm.func @cmp_overlap(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_cmp_overlap   : cmp_overlap_before  ⊑  cmp_overlap_combined := by
  unfold cmp_overlap_before cmp_overlap_combined
  simp_alive_peephole
  sorry
def cmp_overlap_splat_combined := [llvmfunc|
  llvm.func @cmp_overlap_splat(%arg0: vector<2xi5>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(1 : i5) : i5
    %1 = llvm.mlir.constant(dense<1> : vector<2xi5>) : vector<2xi5>
    %2 = llvm.icmp "slt" %arg0, %1 : vector<2xi5>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_cmp_overlap_splat   : cmp_overlap_splat_before  ⊑  cmp_overlap_splat_combined := by
  unfold cmp_overlap_splat_before cmp_overlap_splat_combined
  simp_alive_peephole
  sorry
def mul_no_common_bits_combined := [llvmfunc|
  llvm.func @mul_no_common_bits(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.shl %arg1, %1  : i32
    %5 = llvm.or %4, %2  : i32
    %6 = llvm.mul %3, %5  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_mul_no_common_bits   : mul_no_common_bits_before  ⊑  mul_no_common_bits_combined := by
  unfold mul_no_common_bits_before mul_no_common_bits_combined
  simp_alive_peephole
  sorry
def mul_no_common_bits_const_op_combined := [llvmfunc|
  llvm.func @mul_no_common_bits_const_op(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(25 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.mul %2, %1 overflow<nsw, nuw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_mul_no_common_bits_const_op   : mul_no_common_bits_const_op_before  ⊑  mul_no_common_bits_const_op_combined := by
  unfold mul_no_common_bits_const_op_before mul_no_common_bits_const_op_combined
  simp_alive_peephole
  sorry
def mul_no_common_bits_commute_combined := [llvmfunc|
  llvm.func @mul_no_common_bits_commute(%arg0: vector<2xi12>) -> vector<2xi12> {
    %0 = llvm.mlir.constant(17 : i12) : i12
    %1 = llvm.mlir.constant(15 : i12) : i12
    %2 = llvm.mlir.constant(dense<[15, 17]> : vector<2xi12>) : vector<2xi12>
    %3 = llvm.mlir.constant(0 : i12) : i12
    %4 = llvm.mlir.constant(dense<0> : vector<2xi12>) : vector<2xi12>
    %5 = llvm.trunc %arg0 : vector<2xi12> to vector<2xi1>
    %6 = llvm.select %5, %2, %4 : vector<2xi1>, vector<2xi12>
    llvm.return %6 : vector<2xi12>
  }]

theorem inst_combine_mul_no_common_bits_commute   : mul_no_common_bits_commute_before  ⊑  mul_no_common_bits_commute_combined := by
  unfold mul_no_common_bits_commute_before mul_no_common_bits_commute_combined
  simp_alive_peephole
  sorry
def mul_no_common_bits_commute2_combined := [llvmfunc|
  llvm.func @mul_no_common_bits_commute2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.shl %arg1, %1  : i32
    %4 = llvm.mul %3, %2  : i32
    %5 = llvm.or %4, %2  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_mul_no_common_bits_commute2   : mul_no_common_bits_commute2_before  ⊑  mul_no_common_bits_commute2_combined := by
  unfold mul_no_common_bits_commute2_before mul_no_common_bits_commute2_combined
  simp_alive_peephole
  sorry
def mul_no_common_bits_disjoint_combined := [llvmfunc|
  llvm.func @mul_no_common_bits_disjoint(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.add %arg1, %0  : i32
    %2 = llvm.mul %1, %arg0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_mul_no_common_bits_disjoint   : mul_no_common_bits_disjoint_before  ⊑  mul_no_common_bits_disjoint_combined := by
  unfold mul_no_common_bits_disjoint_before mul_no_common_bits_disjoint_combined
  simp_alive_peephole
  sorry
def mul_no_common_bits_const_op_disjoint_combined := [llvmfunc|
  llvm.func @mul_no_common_bits_const_op_disjoint(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(25 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_mul_no_common_bits_const_op_disjoint   : mul_no_common_bits_const_op_disjoint_before  ⊑  mul_no_common_bits_const_op_disjoint_combined := by
  unfold mul_no_common_bits_const_op_disjoint_before mul_no_common_bits_const_op_disjoint_combined
  simp_alive_peephole
  sorry
def mul_no_common_bits_uses_combined := [llvmfunc|
  llvm.func @mul_no_common_bits_uses(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.shl %arg1, %1  : i32
    %4 = llvm.mul %2, %3  : i32
    llvm.call @use(%4) : (i32) -> ()
    %5 = llvm.or %4, %2  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_mul_no_common_bits_uses   : mul_no_common_bits_uses_before  ⊑  mul_no_common_bits_uses_combined := by
  unfold mul_no_common_bits_uses_before mul_no_common_bits_uses_combined
  simp_alive_peephole
  sorry
def mul_no_common_bits_const_op_uses_combined := [llvmfunc|
  llvm.func @mul_no_common_bits_const_op_uses(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(24 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.mul %2, %1 overflow<nsw, nuw>  : i32
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.or %3, %2  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_mul_no_common_bits_const_op_uses   : mul_no_common_bits_const_op_uses_before  ⊑  mul_no_common_bits_const_op_uses_combined := by
  unfold mul_no_common_bits_const_op_uses_before mul_no_common_bits_const_op_uses_combined
  simp_alive_peephole
  sorry
def mul_common_bits_combined := [llvmfunc|
  llvm.func @mul_common_bits(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.mul %2, %1 overflow<nsw, nuw>  : i32
    %4 = llvm.or %3, %2  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_mul_common_bits   : mul_common_bits_before  ⊑  mul_common_bits_combined := by
  unfold mul_common_bits_before mul_common_bits_combined
  simp_alive_peephole
  sorry
def and_or_not_or_logical_vec_combined := [llvmfunc|
  llvm.func @and_or_not_or_logical_vec(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.icmp "ne" %arg0, %1 : vector<4xi32>
    llvm.return %2 : vector<4xi1>
  }]

theorem inst_combine_and_or_not_or_logical_vec   : and_or_not_or_logical_vec_before  ⊑  and_or_not_or_logical_vec_combined := by
  unfold and_or_not_or_logical_vec_before and_or_not_or_logical_vec_combined
  simp_alive_peephole
  sorry
def drop_disjoint_combined := [llvmfunc|
  llvm.func @drop_disjoint(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.or %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_drop_disjoint   : drop_disjoint_before  ⊑  drop_disjoint_combined := by
  unfold drop_disjoint_before drop_disjoint_combined
  simp_alive_peephole
  sorry
def assoc_cast_assoc_disjoint_combined := [llvmfunc|
  llvm.func @assoc_cast_assoc_disjoint(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(65537 : i32) : i32
    %1 = llvm.zext %arg0 : i16 to i32
    %2 = llvm.or %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_assoc_cast_assoc_disjoint   : assoc_cast_assoc_disjoint_before  ⊑  assoc_cast_assoc_disjoint_combined := by
  unfold assoc_cast_assoc_disjoint_before assoc_cast_assoc_disjoint_combined
  simp_alive_peephole
  sorry
def test_or_and_disjoint_combined := [llvmfunc|
  llvm.func @test_or_and_disjoint(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(15 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %6 = llvm.and %arg0, %3  : i32
    llvm.return %6 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %2 : i32
  }]

theorem inst_combine_test_or_and_disjoint   : test_or_and_disjoint_before  ⊑  test_or_and_disjoint_combined := by
  unfold test_or_and_disjoint_before test_or_and_disjoint_combined
  simp_alive_peephole
  sorry
def test_or_and_mixed_combined := [llvmfunc|
  llvm.func @test_or_and_mixed(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(27 : i32) : i32
    %1 = llvm.mlir.constant(11 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(15 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %6 = llvm.and %arg0, %3  : i32
    llvm.return %6 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %2 : i32
  }]

theorem inst_combine_test_or_and_mixed   : test_or_and_mixed_before  ⊑  test_or_and_mixed_combined := by
  unfold test_or_and_mixed_before test_or_and_mixed_combined
  simp_alive_peephole
  sorry
def test_or_and_disjoint_fail_combined := [llvmfunc|
  llvm.func @test_or_and_disjoint_fail(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(7 : i32) : i32
    %4 = llvm.mlir.constant(8 : i32) : i32
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    llvm.cond_br %6, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %7 = llvm.and %arg0, %3  : i32
    %8 = llvm.or %7, %4  : i32
    llvm.return %8 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %2 : i32
  }]

theorem inst_combine_test_or_and_disjoint_fail   : test_or_and_disjoint_fail_before  ⊑  test_or_and_disjoint_fail_combined := by
  unfold test_or_and_disjoint_fail_before test_or_and_disjoint_fail_combined
  simp_alive_peephole
  sorry
def test_or_and_disjoint_multiuse_combined := [llvmfunc|
  llvm.func @test_or_and_disjoint_multiuse(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(7 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %6 = llvm.and %arg0, %3  : i32
    llvm.call @use(%6) : (i32) -> ()
    %7 = llvm.or %6, %1  : i32
    llvm.return %7 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %2 : i32
  }]

theorem inst_combine_test_or_and_disjoint_multiuse   : test_or_and_disjoint_multiuse_before  ⊑  test_or_and_disjoint_multiuse_combined := by
  unfold test_or_and_disjoint_multiuse_before test_or_and_disjoint_multiuse_combined
  simp_alive_peephole
  sorry
def test_or_and_xor_constant_combined := [llvmfunc|
  llvm.func @test_or_and_xor_constant(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg1  : i32
    %4 = llvm.or %3, %1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_test_or_and_xor_constant   : test_or_and_xor_constant_before  ⊑  test_or_and_xor_constant_combined := by
  unfold test_or_and_xor_constant_before test_or_and_xor_constant_combined
  simp_alive_peephole
  sorry
def test_or_and_xor_combined := [llvmfunc|
  llvm.func @test_or_and_xor(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.xor %arg0, %arg1  : i32
    %1 = llvm.and %0, %arg2  : i32
    %2 = llvm.or %1, %arg0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test_or_and_xor   : test_or_and_xor_before  ⊑  test_or_and_xor_combined := by
  unfold test_or_and_xor_before test_or_and_xor_combined
  simp_alive_peephole
  sorry
def test_or_and_xor_commuted1_combined := [llvmfunc|
  llvm.func @test_or_and_xor_commuted1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.xor %arg1, %arg0  : i32
    %1 = llvm.and %0, %arg2  : i32
    %2 = llvm.or %1, %arg0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test_or_and_xor_commuted1   : test_or_and_xor_commuted1_before  ⊑  test_or_and_xor_commuted1_combined := by
  unfold test_or_and_xor_commuted1_before test_or_and_xor_commuted1_combined
  simp_alive_peephole
  sorry
def test_or_and_xor_commuted2_combined := [llvmfunc|
  llvm.func @test_or_and_xor_commuted2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mul %arg2, %arg2  : i32
    %1 = llvm.xor %arg0, %arg1  : i32
    %2 = llvm.and %0, %1  : i32
    %3 = llvm.or %2, %arg0  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test_or_and_xor_commuted2   : test_or_and_xor_commuted2_before  ⊑  test_or_and_xor_commuted2_combined := by
  unfold test_or_and_xor_commuted2_before test_or_and_xor_commuted2_combined
  simp_alive_peephole
  sorry
def test_or_and_xor_commuted3_combined := [llvmfunc|
  llvm.func @test_or_and_xor_commuted3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mul %arg0, %arg0  : i32
    %1 = llvm.xor %0, %arg1  : i32
    %2 = llvm.and %1, %arg2  : i32
    %3 = llvm.or %0, %2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test_or_and_xor_commuted3   : test_or_and_xor_commuted3_before  ⊑  test_or_and_xor_commuted3_combined := by
  unfold test_or_and_xor_commuted3_before test_or_and_xor_commuted3_combined
  simp_alive_peephole
  sorry
def test_or_and_xor_multiuse1_combined := [llvmfunc|
  llvm.func @test_or_and_xor_multiuse1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.xor %arg0, %arg1  : i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.and %0, %arg2  : i32
    %2 = llvm.or %1, %arg0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test_or_and_xor_multiuse1   : test_or_and_xor_multiuse1_before  ⊑  test_or_and_xor_multiuse1_combined := by
  unfold test_or_and_xor_multiuse1_before test_or_and_xor_multiuse1_combined
  simp_alive_peephole
  sorry
def test_or_and_xor_mismatched_op_combined := [llvmfunc|
  llvm.func @test_or_and_xor_mismatched_op(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.xor %arg0, %arg1  : i32
    %1 = llvm.and %0, %arg2  : i32
    %2 = llvm.or %1, %arg3  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test_or_and_xor_mismatched_op   : test_or_and_xor_mismatched_op_before  ⊑  test_or_and_xor_mismatched_op_combined := by
  unfold test_or_and_xor_mismatched_op_before test_or_and_xor_mismatched_op_combined
  simp_alive_peephole
  sorry
def test_or_and_xor_multiuse2_combined := [llvmfunc|
  llvm.func @test_or_and_xor_multiuse2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.xor %arg0, %arg1  : i32
    %1 = llvm.and %0, %arg2  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.or %1, %arg0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test_or_and_xor_multiuse2   : test_or_and_xor_multiuse2_before  ⊑  test_or_and_xor_multiuse2_combined := by
  unfold test_or_and_xor_multiuse2_before test_or_and_xor_multiuse2_combined
  simp_alive_peephole
  sorry
def test_or_add_xor_combined := [llvmfunc|
  llvm.func @test_or_add_xor(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.xor %arg0, %arg1  : i32
    %1 = llvm.add %0, %arg2  : i32
    %2 = llvm.or %1, %arg0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test_or_add_xor   : test_or_add_xor_before  ⊑  test_or_add_xor_combined := by
  unfold test_or_add_xor_before test_or_add_xor_combined
  simp_alive_peephole
  sorry
def test_or_and_and_multiuse_combined := [llvmfunc|
  llvm.func @test_or_and_and_multiuse(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.and %arg0, %arg1  : i32
    %1 = llvm.and %0, %arg2  : i32
    llvm.call @use(%0) : (i32) -> ()
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.or %1, %arg0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test_or_and_and_multiuse   : test_or_and_and_multiuse_before  ⊑  test_or_and_and_multiuse_combined := by
  unfold test_or_and_and_multiuse_before test_or_and_and_multiuse_combined
  simp_alive_peephole
  sorry
def or_xor_and_combined := [llvmfunc|
  llvm.func @or_xor_and(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.or %arg0, %arg1  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_or_xor_and   : or_xor_and_before  ⊑  or_xor_and_combined := by
  unfold or_xor_and_before or_xor_and_combined
  simp_alive_peephole
  sorry
def or_xor_and_uses1_combined := [llvmfunc|
  llvm.func @or_xor_and_uses1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.and %arg1, %arg2  : i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.or %arg0, %arg1  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_or_xor_and_uses1   : or_xor_and_uses1_before  ⊑  or_xor_and_uses1_combined := by
  unfold or_xor_and_uses1_before or_xor_and_uses1_combined
  simp_alive_peephole
  sorry
def or_xor_and_uses2_combined := [llvmfunc|
  llvm.func @or_xor_and_uses2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.and %arg1, %arg2  : i32
    %1 = llvm.xor %0, %arg0  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.or %arg0, %arg1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_or_xor_and_uses2   : or_xor_and_uses2_before  ⊑  or_xor_and_uses2_combined := by
  unfold or_xor_and_uses2_before or_xor_and_uses2_combined
  simp_alive_peephole
  sorry
def or_xor_and_commuted1_combined := [llvmfunc|
  llvm.func @or_xor_and_commuted1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mul %arg1, %arg1  : i32
    %1 = llvm.or %0, %arg0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_or_xor_and_commuted1   : or_xor_and_commuted1_before  ⊑  or_xor_and_commuted1_combined := by
  unfold or_xor_and_commuted1_before or_xor_and_commuted1_combined
  simp_alive_peephole
  sorry
def or_xor_and_commuted2_combined := [llvmfunc|
  llvm.func @or_xor_and_commuted2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mul %arg1, %arg1  : i32
    %1 = llvm.mul %arg0, %arg0  : i32
    %2 = llvm.or %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_or_xor_and_commuted2   : or_xor_and_commuted2_before  ⊑  or_xor_and_commuted2_combined := by
  unfold or_xor_and_commuted2_before or_xor_and_commuted2_combined
  simp_alive_peephole
  sorry
def or_xor_and_commuted3_combined := [llvmfunc|
  llvm.func @or_xor_and_commuted3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mul %arg1, %arg1  : i32
    %1 = llvm.or %0, %arg0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_or_xor_and_commuted3   : or_xor_and_commuted3_before  ⊑  or_xor_and_commuted3_combined := by
  unfold or_xor_and_commuted3_before or_xor_and_commuted3_combined
  simp_alive_peephole
  sorry
