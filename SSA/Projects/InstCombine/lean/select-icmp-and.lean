import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  select-icmp-and
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test5_before := [llvmfunc|
  llvm.func @test5(%arg0: i41) -> i41 {
    %0 = llvm.mlir.constant(32 : i41) : i41
    %1 = llvm.mlir.constant(0 : i41) : i41
    %2 = llvm.and %arg0, %0  : i41
    %3 = llvm.icmp "ne" %2, %1 : i41
    %4 = llvm.select %3, %0, %1 : i1, i41
    llvm.return %4 : i41
  }]

def test6_before := [llvmfunc|
  llvm.func @test6(%arg0: i1023) -> i1023 {
    %0 = llvm.mlir.constant(64 : i1023) : i1023
    %1 = llvm.mlir.constant(0 : i1023) : i1023
    %2 = llvm.and %arg0, %0  : i1023
    %3 = llvm.icmp "ne" %2, %1 : i1023
    %4 = llvm.select %3, %0, %1 : i1, i1023
    llvm.return %4 : i1023
  }]

def test35_before := [llvmfunc|
  llvm.func @test35(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(60 : i32) : i32
    %2 = llvm.mlir.constant(100 : i32) : i32
    %3 = llvm.icmp "sge" %arg0, %0 : i32
    %4 = llvm.select %3, %1, %2 : i1, i32
    llvm.return %4 : i32
  }]

def test35vec_before := [llvmfunc|
  llvm.func @test35vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<60> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<100> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.icmp "sge" %arg0, %1 : vector<2xi32>
    %5 = llvm.select %4, %2, %3 : vector<2xi1>, vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

def test35_with_trunc_before := [llvmfunc|
  llvm.func @test35_with_trunc(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(60 : i32) : i32
    %2 = llvm.mlir.constant(100 : i32) : i32
    %3 = llvm.trunc %arg0 : i64 to i32
    %4 = llvm.icmp "sge" %3, %0 : i32
    %5 = llvm.select %4, %1, %2 : i1, i32
    llvm.return %5 : i32
  }]

def test36_before := [llvmfunc|
  llvm.func @test36(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(60 : i32) : i32
    %2 = llvm.mlir.constant(100 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.select %3, %1, %2 : i1, i32
    llvm.return %4 : i32
  }]

def test36vec_before := [llvmfunc|
  llvm.func @test36vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<60> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<100> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.icmp "slt" %arg0, %1 : vector<2xi32>
    %5 = llvm.select %4, %2, %3 : vector<2xi1>, vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

def test37_before := [llvmfunc|
  llvm.func @test37(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.select %2, %1, %0 : i1, i32
    llvm.return %3 : i32
  }]

def test37vec_before := [llvmfunc|
  llvm.func @test37vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "sgt" %arg0, %0 : vector<2xi32>
    %3 = llvm.select %2, %1, %0 : vector<2xi1>, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def test65_before := [llvmfunc|
  llvm.func @test65(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(40 : i32) : i32
    %3 = llvm.mlir.constant(42 : i32) : i32
    %4 = llvm.and %arg0, %0  : i64
    %5 = llvm.icmp "ne" %4, %1 : i64
    %6 = llvm.select %5, %2, %3 : i1, i32
    llvm.return %6 : i32
  }]

def test65vec_before := [llvmfunc|
  llvm.func @test65vec(%arg0: vector<2xi64>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.mlir.constant(dense<40> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.mlir.constant(dense<42> : vector<2xi32>) : vector<2xi32>
    %5 = llvm.and %arg0, %0  : vector<2xi64>
    %6 = llvm.icmp "ne" %5, %2 : vector<2xi64>
    %7 = llvm.select %6, %3, %4 : vector<2xi1>, vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }]

def test66_before := [llvmfunc|
  llvm.func @test66(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(4294967296 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(40 : i32) : i32
    %3 = llvm.mlir.constant(42 : i32) : i32
    %4 = llvm.and %arg0, %0  : i64
    %5 = llvm.icmp "ne" %4, %1 : i64
    %6 = llvm.select %5, %2, %3 : i1, i32
    llvm.return %6 : i32
  }]

def test66vec_before := [llvmfunc|
  llvm.func @test66vec(%arg0: vector<2xi64>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<4294967296> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.mlir.constant(dense<40> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.mlir.constant(dense<42> : vector<2xi32>) : vector<2xi32>
    %5 = llvm.and %arg0, %0  : vector<2xi64>
    %6 = llvm.icmp "ne" %5, %2 : vector<2xi64>
    %7 = llvm.select %6, %3, %4 : vector<2xi1>, vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }]

def test66vec_scalar_and_before := [llvmfunc|
  llvm.func @test66vec_scalar_and(%arg0: i64) -> vector<2xi32> {
    %0 = llvm.mlir.constant(4294967296 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<40> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<42> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.and %arg0, %0  : i64
    %5 = llvm.icmp "ne" %4, %1 : i64
    %6 = llvm.select %5, %2, %3 : i1, vector<2xi32>
    llvm.return %6 : vector<2xi32>
  }]

def test67_before := [llvmfunc|
  llvm.func @test67(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(4 : i16) : i16
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.mlir.constant(40 : i32) : i32
    %3 = llvm.mlir.constant(42 : i32) : i32
    %4 = llvm.and %arg0, %0  : i16
    %5 = llvm.icmp "ne" %4, %1 : i16
    %6 = llvm.select %5, %2, %3 : i1, i32
    llvm.return %6 : i32
  }]

def test67vec_before := [llvmfunc|
  llvm.func @test67vec(%arg0: vector<2xi16>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.mlir.constant(dense<0> : vector<2xi16>) : vector<2xi16>
    %3 = llvm.mlir.constant(dense<40> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.mlir.constant(dense<42> : vector<2xi32>) : vector<2xi32>
    %5 = llvm.and %arg0, %0  : vector<2xi16>
    %6 = llvm.icmp "ne" %5, %2 : vector<2xi16>
    %7 = llvm.select %6, %3, %4 : vector<2xi1>, vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }]

def test71_before := [llvmfunc|
  llvm.func @test71(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(40 : i32) : i32
    %3 = llvm.mlir.constant(42 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.select %5, %2, %3 : i1, i32
    llvm.return %6 : i32
  }]

def test71vec_before := [llvmfunc|
  llvm.func @test71vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<128> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<40> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.mlir.constant(dense<42> : vector<2xi32>) : vector<2xi32>
    %5 = llvm.and %arg0, %0  : vector<2xi32>
    %6 = llvm.icmp "ne" %5, %2 : vector<2xi32>
    %7 = llvm.select %6, %3, %4 : vector<2xi1>, vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }]

def test72_before := [llvmfunc|
  llvm.func @test72(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(40 : i32) : i32
    %3 = llvm.mlir.constant(42 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.select %5, %2, %3 : i1, i32
    llvm.return %6 : i32
  }]

def test72vec_before := [llvmfunc|
  llvm.func @test72vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<128> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<40> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.mlir.constant(dense<42> : vector<2xi32>) : vector<2xi32>
    %5 = llvm.and %arg0, %0  : vector<2xi32>
    %6 = llvm.icmp "eq" %5, %2 : vector<2xi32>
    %7 = llvm.select %6, %3, %4 : vector<2xi1>, vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }]

def test73_before := [llvmfunc|
  llvm.func @test73(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(40 : i32) : i32
    %2 = llvm.mlir.constant(42 : i32) : i32
    %3 = llvm.trunc %arg0 : i32 to i8
    %4 = llvm.icmp "sgt" %3, %0 : i8
    %5 = llvm.select %4, %1, %2 : i1, i32
    llvm.return %5 : i32
  }]

def test73vec_before := [llvmfunc|
  llvm.func @test73vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<40> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<42> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.trunc %arg0 : vector<2xi32> to vector<2xi8>
    %4 = llvm.icmp "sgt" %3, %0 : vector<2xi8>
    %5 = llvm.select %4, %1, %2 : vector<2xi1>, vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

def test74_before := [llvmfunc|
  llvm.func @test74(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(40 : i32) : i32
    %2 = llvm.mlir.constant(42 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.select %3, %1, %2 : i1, i32
    llvm.return %4 : i32
  }]

def test74vec_before := [llvmfunc|
  llvm.func @test74vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<40> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<42> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.icmp "sgt" %arg0, %0 : vector<2xi32>
    %4 = llvm.select %3, %1, %2 : vector<2xi1>, vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def test75_before := [llvmfunc|
  llvm.func @test75(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(8 : i64) : i64
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.select %3, %1, %2 : i1, i64
    llvm.return %4 : i64
  }]

def test15a_before := [llvmfunc|
  llvm.func @test15a(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.select %3, %1, %0 : i1, i32
    llvm.return %4 : i32
  }]

def test15b_before := [llvmfunc|
  llvm.func @test15b(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.select %3, %0, %1 : i1, i32
    llvm.return %4 : i32
  }]

def test15c_before := [llvmfunc|
  llvm.func @test15c(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    %4 = llvm.select %3, %0, %1 : i1, i32
    llvm.return %4 : i32
  }]

def test15d_before := [llvmfunc|
  llvm.func @test15d(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    %4 = llvm.select %3, %0, %1 : i1, i32
    llvm.return %4 : i32
  }]

def test15e_before := [llvmfunc|
  llvm.func @test15e(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(256 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.select %4, %2, %1 : i1, i32
    llvm.return %5 : i32
  }]

def test15f_before := [llvmfunc|
  llvm.func @test15f(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(256 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.select %4, %1, %2 : i1, i32
    llvm.return %5 : i32
  }]

def test15g_before := [llvmfunc|
  llvm.func @test15g(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(-9 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.select %5, %2, %3 : i1, i32
    llvm.return %6 : i32
  }]

def test15h_before := [llvmfunc|
  llvm.func @test15h(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-9 : i32) : i32
    %3 = llvm.mlir.constant(-1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.select %5, %2, %3 : i1, i32
    llvm.return %6 : i32
  }]

def test15i_before := [llvmfunc|
  llvm.func @test15i(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(577 : i32) : i32
    %3 = llvm.mlir.constant(1089 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.select %5, %2, %3 : i1, i32
    llvm.return %6 : i32
  }]

def test15j_before := [llvmfunc|
  llvm.func @test15j(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1089 : i32) : i32
    %3 = llvm.mlir.constant(577 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.select %5, %2, %3 : i1, i32
    llvm.return %6 : i32
  }]

def clear_to_set_before := [llvmfunc|
  llvm.func @clear_to_set(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-3 : i32) : i32
    %3 = llvm.mlir.constant(-11 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.select %5, %2, %3 : i1, i32
    llvm.call @use1(%5) : (i1) -> ()
    llvm.return %6 : i32
  }]

def clear_to_clear_before := [llvmfunc|
  llvm.func @clear_to_clear(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-11 : i32) : i32
    %3 = llvm.mlir.constant(-3 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.select %5, %2, %3 : i1, i32
    llvm.call @use1(%5) : (i1) -> ()
    llvm.return %6 : i32
  }]

def set_to_set_before := [llvmfunc|
  llvm.func @set_to_set(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-3 : i32) : i32
    %3 = llvm.mlir.constant(-11 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.select %5, %2, %3 : i1, i32
    llvm.call @use1(%5) : (i1) -> ()
    llvm.return %6 : i32
  }]

def set_to_clear_before := [llvmfunc|
  llvm.func @set_to_clear(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-11 : i32) : i32
    %3 = llvm.mlir.constant(-3 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.select %5, %2, %3 : i1, i32
    llvm.call @use1(%5) : (i1) -> ()
    llvm.return %6 : i32
  }]

def clear_to_set_decomposebittest_before := [llvmfunc|
  llvm.func @clear_to_set_decomposebittest(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(-125 : i8) : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.icmp "sgt" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i8
    llvm.return %4 : i8
  }]

def clear_to_clear_decomposebittest_before := [llvmfunc|
  llvm.func @clear_to_clear_decomposebittest(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.mlir.constant(-125 : i8) : i8
    %3 = llvm.icmp "sgt" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i8
    llvm.return %4 : i8
  }]

def set_to_set_decomposebittest_before := [llvmfunc|
  llvm.func @set_to_set_decomposebittest(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-125 : i8) : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.icmp "slt" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i8
    llvm.return %4 : i8
  }]

def set_to_clear_decomposebittest_before := [llvmfunc|
  llvm.func @set_to_clear_decomposebittest(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.mlir.constant(-125 : i8) : i8
    %3 = llvm.icmp "slt" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i8
    llvm.return %4 : i8
  }]

def clear_to_set_decomposebittest_extra_use_before := [llvmfunc|
  llvm.func @clear_to_set_decomposebittest_extra_use(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(-125 : i8) : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.icmp "sgt" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i8
    llvm.call @use1(%3) : (i1) -> ()
    llvm.return %4 : i8
  }]

def clear_to_clear_decomposebittest_extra_use_before := [llvmfunc|
  llvm.func @clear_to_clear_decomposebittest_extra_use(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.mlir.constant(-125 : i8) : i8
    %3 = llvm.icmp "sgt" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i8
    llvm.call @use1(%3) : (i1) -> ()
    llvm.return %4 : i8
  }]

def set_to_set_decomposebittest_extra_use_before := [llvmfunc|
  llvm.func @set_to_set_decomposebittest_extra_use(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-125 : i8) : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.icmp "slt" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i8
    llvm.call @use1(%3) : (i1) -> ()
    llvm.return %4 : i8
  }]

def set_to_clear_decomposebittest_extra_use_before := [llvmfunc|
  llvm.func @set_to_clear_decomposebittest_extra_use(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.mlir.constant(-125 : i8) : i8
    %3 = llvm.icmp "slt" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i8
    llvm.call @use1(%3) : (i1) -> ()
    llvm.return %4 : i8
  }]

def test5_combined := [llvmfunc|
  llvm.func @test5(%arg0: i41) -> i41 {
    %0 = llvm.mlir.constant(32 : i41) : i41
    %1 = llvm.and %arg0, %0  : i41
    llvm.return %1 : i41
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
def test6_combined := [llvmfunc|
  llvm.func @test6(%arg0: i1023) -> i1023 {
    %0 = llvm.mlir.constant(64 : i1023) : i1023
    %1 = llvm.and %arg0, %0  : i1023
    llvm.return %1 : i1023
  }]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
def test35_combined := [llvmfunc|
  llvm.func @test35(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(60 : i32) : i32
    %2 = llvm.mlir.constant(100 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.select %3, %1, %2 : i1, i32
    llvm.return %4 : i32
  }]

theorem inst_combine_test35   : test35_before  ⊑  test35_combined := by
  unfold test35_before test35_combined
  simp_alive_peephole
  sorry
def test35vec_combined := [llvmfunc|
  llvm.func @test35vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<60> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<100> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.icmp "sgt" %arg0, %0 : vector<2xi32>
    %4 = llvm.select %3, %1, %2 : vector<2xi1>, vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

theorem inst_combine_test35vec   : test35vec_before  ⊑  test35vec_combined := by
  unfold test35vec_before test35vec_combined
  simp_alive_peephole
  sorry
def test35_with_trunc_combined := [llvmfunc|
  llvm.func @test35_with_trunc(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(2147483648 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(60 : i32) : i32
    %3 = llvm.mlir.constant(100 : i32) : i32
    %4 = llvm.and %arg0, %0  : i64
    %5 = llvm.icmp "eq" %4, %1 : i64
    %6 = llvm.select %5, %2, %3 : i1, i32
    llvm.return %6 : i32
  }]

theorem inst_combine_test35_with_trunc   : test35_with_trunc_before  ⊑  test35_with_trunc_combined := by
  unfold test35_with_trunc_before test35_with_trunc_combined
  simp_alive_peephole
  sorry
def test36_combined := [llvmfunc|
  llvm.func @test36(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(60 : i32) : i32
    %2 = llvm.mlir.constant(100 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.select %3, %1, %2 : i1, i32
    llvm.return %4 : i32
  }]

theorem inst_combine_test36   : test36_before  ⊑  test36_combined := by
  unfold test36_before test36_combined
  simp_alive_peephole
  sorry
def test36vec_combined := [llvmfunc|
  llvm.func @test36vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<60> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<100> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.icmp "slt" %arg0, %1 : vector<2xi32>
    %5 = llvm.select %4, %2, %3 : vector<2xi1>, vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

theorem inst_combine_test36vec   : test36vec_before  ⊑  test36vec_combined := by
  unfold test36vec_before test36vec_combined
  simp_alive_peephole
  sorry
def test37_combined := [llvmfunc|
  llvm.func @test37(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.select %2, %1, %0 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test37   : test37_before  ⊑  test37_combined := by
  unfold test37_before test37_combined
  simp_alive_peephole
  sorry
def test37vec_combined := [llvmfunc|
  llvm.func @test37vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "sgt" %arg0, %0 : vector<2xi32>
    %3 = llvm.select %2, %1, %0 : vector<2xi1>, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_test37vec   : test37vec_before  ⊑  test37vec_combined := by
  unfold test37vec_before test37vec_combined
  simp_alive_peephole
  sorry
def test65_combined := [llvmfunc|
  llvm.func @test65(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(42 : i32) : i32
    %3 = llvm.mlir.constant(40 : i32) : i32
    %4 = llvm.and %arg0, %0  : i64
    %5 = llvm.icmp "eq" %4, %1 : i64
    %6 = llvm.select %5, %2, %3 : i1, i32
    llvm.return %6 : i32
  }]

theorem inst_combine_test65   : test65_before  ⊑  test65_combined := by
  unfold test65_before test65_combined
  simp_alive_peephole
  sorry
def test65vec_combined := [llvmfunc|
  llvm.func @test65vec(%arg0: vector<2xi64>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.mlir.constant(dense<42> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.mlir.constant(dense<40> : vector<2xi32>) : vector<2xi32>
    %5 = llvm.and %arg0, %0  : vector<2xi64>
    %6 = llvm.icmp "eq" %5, %2 : vector<2xi64>
    %7 = llvm.select %6, %3, %4 : vector<2xi1>, vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }]

theorem inst_combine_test65vec   : test65vec_before  ⊑  test65vec_combined := by
  unfold test65vec_before test65vec_combined
  simp_alive_peephole
  sorry
def test66_combined := [llvmfunc|
  llvm.func @test66(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(4294967296 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(42 : i32) : i32
    %3 = llvm.mlir.constant(40 : i32) : i32
    %4 = llvm.and %arg0, %0  : i64
    %5 = llvm.icmp "eq" %4, %1 : i64
    %6 = llvm.select %5, %2, %3 : i1, i32
    llvm.return %6 : i32
  }]

theorem inst_combine_test66   : test66_before  ⊑  test66_combined := by
  unfold test66_before test66_combined
  simp_alive_peephole
  sorry
def test66vec_combined := [llvmfunc|
  llvm.func @test66vec(%arg0: vector<2xi64>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<4294967296> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.mlir.constant(dense<42> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.mlir.constant(dense<40> : vector<2xi32>) : vector<2xi32>
    %5 = llvm.and %arg0, %0  : vector<2xi64>
    %6 = llvm.icmp "eq" %5, %2 : vector<2xi64>
    %7 = llvm.select %6, %3, %4 : vector<2xi1>, vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }]

theorem inst_combine_test66vec   : test66vec_before  ⊑  test66vec_combined := by
  unfold test66vec_before test66vec_combined
  simp_alive_peephole
  sorry
def test66vec_scalar_and_combined := [llvmfunc|
  llvm.func @test66vec_scalar_and(%arg0: i64) -> vector<2xi32> {
    %0 = llvm.mlir.constant(4294967296 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<42> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<40> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.and %arg0, %0  : i64
    %5 = llvm.icmp "eq" %4, %1 : i64
    %6 = llvm.select %5, %2, %3 : i1, vector<2xi32>
    llvm.return %6 : vector<2xi32>
  }]

theorem inst_combine_test66vec_scalar_and   : test66vec_scalar_and_before  ⊑  test66vec_scalar_and_combined := by
  unfold test66vec_scalar_and_before test66vec_scalar_and_combined
  simp_alive_peephole
  sorry
def test67_combined := [llvmfunc|
  llvm.func @test67(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(4 : i16) : i16
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.mlir.constant(42 : i32) : i32
    %3 = llvm.mlir.constant(40 : i32) : i32
    %4 = llvm.and %arg0, %0  : i16
    %5 = llvm.icmp "eq" %4, %1 : i16
    %6 = llvm.select %5, %2, %3 : i1, i32
    llvm.return %6 : i32
  }]

theorem inst_combine_test67   : test67_before  ⊑  test67_combined := by
  unfold test67_before test67_combined
  simp_alive_peephole
  sorry
def test67vec_combined := [llvmfunc|
  llvm.func @test67vec(%arg0: vector<2xi16>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.mlir.constant(dense<0> : vector<2xi16>) : vector<2xi16>
    %3 = llvm.mlir.constant(dense<42> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.mlir.constant(dense<40> : vector<2xi32>) : vector<2xi32>
    %5 = llvm.and %arg0, %0  : vector<2xi16>
    %6 = llvm.icmp "eq" %5, %2 : vector<2xi16>
    %7 = llvm.select %6, %3, %4 : vector<2xi1>, vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }]

theorem inst_combine_test67vec   : test67vec_before  ⊑  test67vec_combined := by
  unfold test67vec_before test67vec_combined
  simp_alive_peephole
  sorry
def test71_combined := [llvmfunc|
  llvm.func @test71(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(42 : i32) : i32
    %3 = llvm.mlir.constant(40 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.select %5, %2, %3 : i1, i32
    llvm.return %6 : i32
  }]

theorem inst_combine_test71   : test71_before  ⊑  test71_combined := by
  unfold test71_before test71_combined
  simp_alive_peephole
  sorry
def test71vec_combined := [llvmfunc|
  llvm.func @test71vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<128> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<42> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.mlir.constant(dense<40> : vector<2xi32>) : vector<2xi32>
    %5 = llvm.and %arg0, %0  : vector<2xi32>
    %6 = llvm.icmp "eq" %5, %2 : vector<2xi32>
    %7 = llvm.select %6, %3, %4 : vector<2xi1>, vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }]

theorem inst_combine_test71vec   : test71vec_before  ⊑  test71vec_combined := by
  unfold test71vec_before test71vec_combined
  simp_alive_peephole
  sorry
def test72_combined := [llvmfunc|
  llvm.func @test72(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(40 : i32) : i32
    %3 = llvm.mlir.constant(42 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.select %5, %2, %3 : i1, i32
    llvm.return %6 : i32
  }]

theorem inst_combine_test72   : test72_before  ⊑  test72_combined := by
  unfold test72_before test72_combined
  simp_alive_peephole
  sorry
def test72vec_combined := [llvmfunc|
  llvm.func @test72vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<128> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<40> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.mlir.constant(dense<42> : vector<2xi32>) : vector<2xi32>
    %5 = llvm.and %arg0, %0  : vector<2xi32>
    %6 = llvm.icmp "eq" %5, %2 : vector<2xi32>
    %7 = llvm.select %6, %3, %4 : vector<2xi1>, vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }]

theorem inst_combine_test72vec   : test72vec_before  ⊑  test72vec_combined := by
  unfold test72vec_before test72vec_combined
  simp_alive_peephole
  sorry
def test73_combined := [llvmfunc|
  llvm.func @test73(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(40 : i32) : i32
    %3 = llvm.mlir.constant(42 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.select %5, %2, %3 : i1, i32
    llvm.return %6 : i32
  }]

theorem inst_combine_test73   : test73_before  ⊑  test73_combined := by
  unfold test73_before test73_combined
  simp_alive_peephole
  sorry
def test73vec_combined := [llvmfunc|
  llvm.func @test73vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<128> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<40> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.mlir.constant(dense<42> : vector<2xi32>) : vector<2xi32>
    %5 = llvm.and %arg0, %0  : vector<2xi32>
    %6 = llvm.icmp "eq" %5, %2 : vector<2xi32>
    %7 = llvm.select %6, %3, %4 : vector<2xi1>, vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }]

theorem inst_combine_test73vec   : test73vec_before  ⊑  test73vec_combined := by
  unfold test73vec_before test73vec_combined
  simp_alive_peephole
  sorry
def test74_combined := [llvmfunc|
  llvm.func @test74(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(40 : i32) : i32
    %2 = llvm.mlir.constant(42 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.select %3, %1, %2 : i1, i32
    llvm.return %4 : i32
  }]

theorem inst_combine_test74   : test74_before  ⊑  test74_combined := by
  unfold test74_before test74_combined
  simp_alive_peephole
  sorry
def test74vec_combined := [llvmfunc|
  llvm.func @test74vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<40> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<42> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.icmp "sgt" %arg0, %0 : vector<2xi32>
    %4 = llvm.select %3, %1, %2 : vector<2xi1>, vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

theorem inst_combine_test74vec   : test74vec_before  ⊑  test74vec_combined := by
  unfold test74vec_before test74vec_combined
  simp_alive_peephole
  sorry
def test75_combined := [llvmfunc|
  llvm.func @test75(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(28 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.zext %4 : i32 to i64
    llvm.return %5 : i64
  }]

theorem inst_combine_test75   : test75_before  ⊑  test75_combined := by
  unfold test75_before test75_combined
  simp_alive_peephole
  sorry
def test15a_combined := [llvmfunc|
  llvm.func @test15a(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test15a   : test15a_before  ⊑  test15a_combined := by
  unfold test15a_before test15a_combined
  simp_alive_peephole
  sorry
def test15b_combined := [llvmfunc|
  llvm.func @test15b(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test15b   : test15b_before  ⊑  test15b_combined := by
  unfold test15b_before test15b_combined
  simp_alive_peephole
  sorry
def test15c_combined := [llvmfunc|
  llvm.func @test15c(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test15c   : test15c_before  ⊑  test15c_combined := by
  unfold test15c_before test15c_combined
  simp_alive_peephole
  sorry
def test15d_combined := [llvmfunc|
  llvm.func @test15d(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test15d   : test15d_before  ⊑  test15d_combined := by
  unfold test15d_before test15d_combined
  simp_alive_peephole
  sorry
def test15e_combined := [llvmfunc|
  llvm.func @test15e(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(256 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test15e   : test15e_before  ⊑  test15e_combined := by
  unfold test15e_before test15e_combined
  simp_alive_peephole
  sorry
def test15f_combined := [llvmfunc|
  llvm.func @test15f(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(256 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.xor %3, %1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_test15f   : test15f_before  ⊑  test15f_combined := by
  unfold test15f_before test15f_combined
  simp_alive_peephole
  sorry
def test15g_combined := [llvmfunc|
  llvm.func @test15g(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-9 : i32) : i32
    %1 = llvm.or %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test15g   : test15g_before  ⊑  test15g_combined := by
  unfold test15g_before test15g_combined
  simp_alive_peephole
  sorry
def test15h_combined := [llvmfunc|
  llvm.func @test15h(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.xor %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test15h   : test15h_before  ⊑  test15h_combined := by
  unfold test15h_before test15h_combined
  simp_alive_peephole
  sorry
def test15i_combined := [llvmfunc|
  llvm.func @test15i(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1089 : i32) : i32
    %3 = llvm.mlir.constant(577 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.select %5, %2, %3 : i1, i32
    llvm.return %6 : i32
  }]

theorem inst_combine_test15i   : test15i_before  ⊑  test15i_combined := by
  unfold test15i_before test15i_combined
  simp_alive_peephole
  sorry
def test15j_combined := [llvmfunc|
  llvm.func @test15j(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(577 : i32) : i32
    %3 = llvm.mlir.constant(1089 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.select %5, %2, %3 : i1, i32
    llvm.return %6 : i32
  }]

theorem inst_combine_test15j   : test15j_before  ⊑  test15j_combined := by
  unfold test15j_before test15j_combined
  simp_alive_peephole
  sorry
def clear_to_set_combined := [llvmfunc|
  llvm.func @clear_to_set(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-3 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.xor %3, %2  : i32
    llvm.call @use1(%4) : (i1) -> ()
    llvm.return %5 : i32
  }]

theorem inst_combine_clear_to_set   : clear_to_set_before  ⊑  clear_to_set_combined := by
  unfold clear_to_set_before clear_to_set_combined
  simp_alive_peephole
  sorry
def clear_to_clear_combined := [llvmfunc|
  llvm.func @clear_to_clear(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-11 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.or %3, %2  : i32
    llvm.call @use1(%4) : (i1) -> ()
    llvm.return %5 : i32
  }]

theorem inst_combine_clear_to_clear   : clear_to_clear_before  ⊑  clear_to_clear_combined := by
  unfold clear_to_clear_before clear_to_clear_combined
  simp_alive_peephole
  sorry
def set_to_set_combined := [llvmfunc|
  llvm.func @set_to_set(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-11 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.or %3, %2  : i32
    llvm.call @use1(%4) : (i1) -> ()
    llvm.return %5 : i32
  }]

theorem inst_combine_set_to_set   : set_to_set_before  ⊑  set_to_set_combined := by
  unfold set_to_set_before set_to_set_combined
  simp_alive_peephole
  sorry
def set_to_clear_combined := [llvmfunc|
  llvm.func @set_to_clear(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-3 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.xor %3, %2  : i32
    llvm.call @use1(%4) : (i1) -> ()
    llvm.return %5 : i32
  }]

theorem inst_combine_set_to_clear   : set_to_clear_before  ⊑  set_to_clear_combined := by
  unfold set_to_clear_before set_to_clear_combined
  simp_alive_peephole
  sorry
def clear_to_set_decomposebittest_combined := [llvmfunc|
  llvm.func @clear_to_set_decomposebittest(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(-125 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_clear_to_set_decomposebittest   : clear_to_set_decomposebittest_before  ⊑  clear_to_set_decomposebittest_combined := by
  unfold clear_to_set_decomposebittest_before clear_to_set_decomposebittest_combined
  simp_alive_peephole
  sorry
def clear_to_clear_decomposebittest_combined := [llvmfunc|
  llvm.func @clear_to_clear_decomposebittest(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.or %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_clear_to_clear_decomposebittest   : clear_to_clear_decomposebittest_before  ⊑  clear_to_clear_decomposebittest_combined := by
  unfold clear_to_clear_decomposebittest_before clear_to_clear_decomposebittest_combined
  simp_alive_peephole
  sorry
def set_to_set_decomposebittest_combined := [llvmfunc|
  llvm.func @set_to_set_decomposebittest(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.or %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_set_to_set_decomposebittest   : set_to_set_decomposebittest_before  ⊑  set_to_set_decomposebittest_combined := by
  unfold set_to_set_decomposebittest_before set_to_set_decomposebittest_combined
  simp_alive_peephole
  sorry
def set_to_clear_decomposebittest_combined := [llvmfunc|
  llvm.func @set_to_clear_decomposebittest(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(-125 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_set_to_clear_decomposebittest   : set_to_clear_decomposebittest_before  ⊑  set_to_clear_decomposebittest_combined := by
  unfold set_to_clear_decomposebittest_before set_to_clear_decomposebittest_combined
  simp_alive_peephole
  sorry
def clear_to_set_decomposebittest_extra_use_combined := [llvmfunc|
  llvm.func @clear_to_set_decomposebittest_extra_use(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(-125 : i8) : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.icmp "sgt" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i8
    llvm.call @use1(%3) : (i1) -> ()
    llvm.return %4 : i8
  }]

theorem inst_combine_clear_to_set_decomposebittest_extra_use   : clear_to_set_decomposebittest_extra_use_before  ⊑  clear_to_set_decomposebittest_extra_use_combined := by
  unfold clear_to_set_decomposebittest_extra_use_before clear_to_set_decomposebittest_extra_use_combined
  simp_alive_peephole
  sorry
def clear_to_clear_decomposebittest_extra_use_combined := [llvmfunc|
  llvm.func @clear_to_clear_decomposebittest_extra_use(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.mlir.constant(-125 : i8) : i8
    %3 = llvm.icmp "sgt" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i8
    llvm.call @use1(%3) : (i1) -> ()
    llvm.return %4 : i8
  }]

theorem inst_combine_clear_to_clear_decomposebittest_extra_use   : clear_to_clear_decomposebittest_extra_use_before  ⊑  clear_to_clear_decomposebittest_extra_use_combined := by
  unfold clear_to_clear_decomposebittest_extra_use_before clear_to_clear_decomposebittest_extra_use_combined
  simp_alive_peephole
  sorry
def set_to_set_decomposebittest_extra_use_combined := [llvmfunc|
  llvm.func @set_to_set_decomposebittest_extra_use(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-125 : i8) : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.icmp "slt" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i8
    llvm.call @use1(%3) : (i1) -> ()
    llvm.return %4 : i8
  }]

theorem inst_combine_set_to_set_decomposebittest_extra_use   : set_to_set_decomposebittest_extra_use_before  ⊑  set_to_set_decomposebittest_extra_use_combined := by
  unfold set_to_set_decomposebittest_extra_use_before set_to_set_decomposebittest_extra_use_combined
  simp_alive_peephole
  sorry
def set_to_clear_decomposebittest_extra_use_combined := [llvmfunc|
  llvm.func @set_to_clear_decomposebittest_extra_use(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.mlir.constant(-125 : i8) : i8
    %3 = llvm.icmp "slt" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i8
    llvm.call @use1(%3) : (i1) -> ()
    llvm.return %4 : i8
  }]

theorem inst_combine_set_to_clear_decomposebittest_extra_use   : set_to_clear_decomposebittest_extra_use_before  ⊑  set_to_clear_decomposebittest_extra_use_combined := by
  unfold set_to_clear_decomposebittest_extra_use_before set_to_clear_decomposebittest_extra_use_combined
  simp_alive_peephole
  sorry
