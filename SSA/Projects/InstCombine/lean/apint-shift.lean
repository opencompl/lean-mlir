import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  apint-shift
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test6_before := [llvmfunc|
  llvm.func @test6(%arg0: i55) -> i55 {
    %0 = llvm.mlir.constant(1 : i55) : i55
    %1 = llvm.mlir.constant(3 : i55) : i55
    %2 = llvm.shl %arg0, %0  : i55
    %3 = llvm.mul %2, %1  : i55
    llvm.return %3 : i55
  }]

def test6a_before := [llvmfunc|
  llvm.func @test6a(%arg0: i55) -> i55 {
    %0 = llvm.mlir.constant(3 : i55) : i55
    %1 = llvm.mlir.constant(1 : i55) : i55
    %2 = llvm.mul %arg0, %0  : i55
    %3 = llvm.shl %2, %1  : i55
    llvm.return %3 : i55
  }]

def test6a_negative_oneuse_before := [llvmfunc|
  llvm.func @test6a_negative_oneuse(%arg0: i55) -> i55 {
    %0 = llvm.mlir.constant(3 : i55) : i55
    %1 = llvm.mlir.constant(1 : i55) : i55
    %2 = llvm.mul %arg0, %0  : i55
    %3 = llvm.shl %2, %1  : i55
    llvm.call @use(%2) : (i55) -> ()
    llvm.return %3 : i55
  }]

def test6a_vec_before := [llvmfunc|
  llvm.func @test6a_vec(%arg0: vector<2xi55>) -> vector<2xi55> {
    %0 = llvm.mlir.constant(12 : i55) : i55
    %1 = llvm.mlir.constant(3 : i55) : i55
    %2 = llvm.mlir.constant(dense<[3, 12]> : vector<2xi55>) : vector<2xi55>
    %3 = llvm.mlir.constant(2 : i55) : i55
    %4 = llvm.mlir.constant(1 : i55) : i55
    %5 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi55>) : vector<2xi55>
    %6 = llvm.mul %arg0, %2  : vector<2xi55>
    %7 = llvm.shl %6, %5  : vector<2xi55>
    llvm.return %7 : vector<2xi55>
  }]

def test7_before := [llvmfunc|
  llvm.func @test7(%arg0: i8) -> i29 {
    %0 = llvm.mlir.constant(-1 : i29) : i29
    %1 = llvm.zext %arg0 : i8 to i29
    %2 = llvm.ashr %0, %1  : i29
    llvm.return %2 : i29
  }]

def test8_before := [llvmfunc|
  llvm.func @test8(%arg0: i7) -> i7 {
    %0 = llvm.mlir.constant(4 : i7) : i7
    %1 = llvm.mlir.constant(3 : i7) : i7
    %2 = llvm.shl %arg0, %0  : i7
    %3 = llvm.shl %2, %1  : i7
    llvm.return %3 : i7
  }]

def test9_before := [llvmfunc|
  llvm.func @test9(%arg0: i17) -> i17 {
    %0 = llvm.mlir.constant(16 : i17) : i17
    %1 = llvm.shl %arg0, %0  : i17
    %2 = llvm.lshr %1, %0  : i17
    llvm.return %2 : i17
  }]

def test10_before := [llvmfunc|
  llvm.func @test10(%arg0: i19) -> i19 {
    %0 = llvm.mlir.constant(18 : i19) : i19
    %1 = llvm.lshr %arg0, %0  : i19
    %2 = llvm.shl %1, %0  : i19
    llvm.return %2 : i19
  }]

def lshr_lshr_splat_vec_before := [llvmfunc|
  llvm.func @lshr_lshr_splat_vec(%arg0: vector<2xi19>) -> vector<2xi19> {
    %0 = llvm.mlir.constant(3 : i19) : i19
    %1 = llvm.mlir.constant(dense<3> : vector<2xi19>) : vector<2xi19>
    %2 = llvm.mlir.constant(2 : i19) : i19
    %3 = llvm.mlir.constant(dense<2> : vector<2xi19>) : vector<2xi19>
    %4 = llvm.lshr %arg0, %1  : vector<2xi19>
    %5 = llvm.lshr %4, %3  : vector<2xi19>
    llvm.return %5 : vector<2xi19>
  }]

def multiuse_lshr_lshr_before := [llvmfunc|
  llvm.func @multiuse_lshr_lshr(%arg0: i9) -> i9 {
    %0 = llvm.mlir.constant(2 : i9) : i9
    %1 = llvm.mlir.constant(3 : i9) : i9
    %2 = llvm.lshr %arg0, %0  : i9
    %3 = llvm.lshr %2, %1  : i9
    %4 = llvm.mul %2, %3  : i9
    llvm.return %4 : i9
  }]

def multiuse_lshr_lshr_splat_before := [llvmfunc|
  llvm.func @multiuse_lshr_lshr_splat(%arg0: vector<2xi9>) -> vector<2xi9> {
    %0 = llvm.mlir.constant(2 : i9) : i9
    %1 = llvm.mlir.constant(dense<2> : vector<2xi9>) : vector<2xi9>
    %2 = llvm.mlir.constant(3 : i9) : i9
    %3 = llvm.mlir.constant(dense<3> : vector<2xi9>) : vector<2xi9>
    %4 = llvm.lshr %arg0, %1  : vector<2xi9>
    %5 = llvm.lshr %4, %3  : vector<2xi9>
    %6 = llvm.mul %4, %5  : vector<2xi9>
    llvm.return %6 : vector<2xi9>
  }]

def shl_shl_splat_vec_before := [llvmfunc|
  llvm.func @shl_shl_splat_vec(%arg0: vector<2xi19>) -> vector<2xi19> {
    %0 = llvm.mlir.constant(3 : i19) : i19
    %1 = llvm.mlir.constant(dense<3> : vector<2xi19>) : vector<2xi19>
    %2 = llvm.mlir.constant(2 : i19) : i19
    %3 = llvm.mlir.constant(dense<2> : vector<2xi19>) : vector<2xi19>
    %4 = llvm.shl %arg0, %1  : vector<2xi19>
    %5 = llvm.shl %4, %3  : vector<2xi19>
    llvm.return %5 : vector<2xi19>
  }]

def multiuse_shl_shl_before := [llvmfunc|
  llvm.func @multiuse_shl_shl(%arg0: i42) -> i42 {
    %0 = llvm.mlir.constant(8 : i42) : i42
    %1 = llvm.mlir.constant(9 : i42) : i42
    %2 = llvm.shl %arg0, %0  : i42
    %3 = llvm.shl %2, %1  : i42
    %4 = llvm.mul %2, %3  : i42
    llvm.return %4 : i42
  }]

def multiuse_shl_shl_splat_before := [llvmfunc|
  llvm.func @multiuse_shl_shl_splat(%arg0: vector<2xi42>) -> vector<2xi42> {
    %0 = llvm.mlir.constant(8 : i42) : i42
    %1 = llvm.mlir.constant(dense<8> : vector<2xi42>) : vector<2xi42>
    %2 = llvm.mlir.constant(9 : i42) : i42
    %3 = llvm.mlir.constant(dense<9> : vector<2xi42>) : vector<2xi42>
    %4 = llvm.shl %arg0, %1  : vector<2xi42>
    %5 = llvm.shl %4, %3  : vector<2xi42>
    %6 = llvm.mul %4, %5  : vector<2xi42>
    llvm.return %6 : vector<2xi42>
  }]

def eq_shl_lshr_splat_vec_before := [llvmfunc|
  llvm.func @eq_shl_lshr_splat_vec(%arg0: vector<2xi19>) -> vector<2xi19> {
    %0 = llvm.mlir.constant(3 : i19) : i19
    %1 = llvm.mlir.constant(dense<3> : vector<2xi19>) : vector<2xi19>
    %2 = llvm.shl %arg0, %1  : vector<2xi19>
    %3 = llvm.lshr %2, %1  : vector<2xi19>
    llvm.return %3 : vector<2xi19>
  }]

def eq_lshr_shl_splat_vec_before := [llvmfunc|
  llvm.func @eq_lshr_shl_splat_vec(%arg0: vector<2xi19>) -> vector<2xi19> {
    %0 = llvm.mlir.constant(3 : i19) : i19
    %1 = llvm.mlir.constant(dense<3> : vector<2xi19>) : vector<2xi19>
    %2 = llvm.lshr %arg0, %1  : vector<2xi19>
    %3 = llvm.shl %2, %1  : vector<2xi19>
    llvm.return %3 : vector<2xi19>
  }]

def lshr_shl_splat_vec_before := [llvmfunc|
  llvm.func @lshr_shl_splat_vec(%arg0: vector<2xi7>) -> vector<2xi7> {
    %0 = llvm.mlir.constant(-8 : i7) : i7
    %1 = llvm.mlir.constant(dense<-8> : vector<2xi7>) : vector<2xi7>
    %2 = llvm.mlir.constant(3 : i7) : i7
    %3 = llvm.mlir.constant(dense<3> : vector<2xi7>) : vector<2xi7>
    %4 = llvm.mlir.constant(2 : i7) : i7
    %5 = llvm.mlir.constant(dense<2> : vector<2xi7>) : vector<2xi7>
    %6 = llvm.mul %arg0, %1  : vector<2xi7>
    %7 = llvm.lshr %6, %3  : vector<2xi7>
    %8 = llvm.shl %7, %5 overflow<nsw, nuw>  : vector<2xi7>
    llvm.return %8 : vector<2xi7>
  }]

def shl_lshr_splat_vec_before := [llvmfunc|
  llvm.func @shl_lshr_splat_vec(%arg0: vector<2xi7>) -> vector<2xi7> {
    %0 = llvm.mlir.constant(9 : i7) : i7
    %1 = llvm.mlir.constant(dense<9> : vector<2xi7>) : vector<2xi7>
    %2 = llvm.mlir.constant(3 : i7) : i7
    %3 = llvm.mlir.constant(dense<3> : vector<2xi7>) : vector<2xi7>
    %4 = llvm.mlir.constant(2 : i7) : i7
    %5 = llvm.mlir.constant(dense<2> : vector<2xi7>) : vector<2xi7>
    %6 = llvm.udiv %arg0, %1  : vector<2xi7>
    %7 = llvm.shl %6, %3 overflow<nuw>  : vector<2xi7>
    %8 = llvm.lshr %7, %5  : vector<2xi7>
    llvm.return %8 : vector<2xi7>
  }]

def test11_before := [llvmfunc|
  llvm.func @test11(%arg0: i23) -> i23 {
    %0 = llvm.mlir.constant(3 : i23) : i23
    %1 = llvm.mlir.constant(11 : i23) : i23
    %2 = llvm.mlir.constant(12 : i23) : i23
    %3 = llvm.mul %arg0, %0  : i23
    %4 = llvm.lshr %3, %1  : i23
    %5 = llvm.shl %4, %2  : i23
    llvm.return %5 : i23
  }]

def test12_before := [llvmfunc|
  llvm.func @test12(%arg0: i47) -> i47 {
    %0 = llvm.mlir.constant(8 : i47) : i47
    %1 = llvm.ashr %arg0, %0  : i47
    %2 = llvm.shl %1, %0  : i47
    llvm.return %2 : i47
  }]

def test12_splat_vec_before := [llvmfunc|
  llvm.func @test12_splat_vec(%arg0: vector<2xi47>) -> vector<2xi47> {
    %0 = llvm.mlir.constant(8 : i47) : i47
    %1 = llvm.mlir.constant(dense<8> : vector<2xi47>) : vector<2xi47>
    %2 = llvm.ashr %arg0, %1  : vector<2xi47>
    %3 = llvm.shl %2, %1  : vector<2xi47>
    llvm.return %3 : vector<2xi47>
  }]

def test13_before := [llvmfunc|
  llvm.func @test13(%arg0: i18) -> i18 {
    %0 = llvm.mlir.constant(3 : i18) : i18
    %1 = llvm.mlir.constant(8 : i18) : i18
    %2 = llvm.mlir.constant(9 : i18) : i18
    %3 = llvm.mul %arg0, %0  : i18
    %4 = llvm.ashr %3, %1  : i18
    %5 = llvm.shl %4, %2  : i18
    llvm.return %5 : i18
  }]

def test14_before := [llvmfunc|
  llvm.func @test14(%arg0: i35) -> i35 {
    %0 = llvm.mlir.constant(4 : i35) : i35
    %1 = llvm.mlir.constant(1234 : i35) : i35
    %2 = llvm.lshr %arg0, %0  : i35
    %3 = llvm.or %2, %1  : i35
    %4 = llvm.shl %3, %0  : i35
    llvm.return %4 : i35
  }]

def test14a_before := [llvmfunc|
  llvm.func @test14a(%arg0: i79) -> i79 {
    %0 = llvm.mlir.constant(4 : i79) : i79
    %1 = llvm.mlir.constant(1234 : i79) : i79
    %2 = llvm.shl %arg0, %0  : i79
    %3 = llvm.and %2, %1  : i79
    %4 = llvm.lshr %3, %0  : i79
    llvm.return %4 : i79
  }]

def test15_before := [llvmfunc|
  llvm.func @test15(%arg0: i1) -> i45 {
    %0 = llvm.mlir.constant(3 : i45) : i45
    %1 = llvm.mlir.constant(1 : i45) : i45
    %2 = llvm.mlir.constant(2 : i45) : i45
    %3 = llvm.select %arg0, %0, %1 : i1, i45
    %4 = llvm.shl %3, %2  : i45
    llvm.return %4 : i45
  }]

def test15a_before := [llvmfunc|
  llvm.func @test15a(%arg0: i1) -> i53 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(64 : i53) : i53
    %3 = llvm.select %arg0, %0, %1 : i1, i8
    %4 = llvm.zext %3 : i8 to i53
    %5 = llvm.shl %2, %4  : i53
    llvm.return %5 : i53
  }]

def test16_before := [llvmfunc|
  llvm.func @test16(%arg0: i84) -> i1 {
    %0 = llvm.mlir.constant(4 : i84) : i84
    %1 = llvm.mlir.constant(1 : i84) : i84
    %2 = llvm.mlir.constant(0 : i84) : i84
    %3 = llvm.ashr %arg0, %0  : i84
    %4 = llvm.and %3, %1  : i84
    %5 = llvm.icmp "ne" %4, %2 : i84
    llvm.return %5 : i1
  }]

def test16vec_before := [llvmfunc|
  llvm.func @test16vec(%arg0: vector<2xi84>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(4 : i84) : i84
    %1 = llvm.mlir.constant(dense<4> : vector<2xi84>) : vector<2xi84>
    %2 = llvm.mlir.constant(1 : i84) : i84
    %3 = llvm.mlir.constant(dense<1> : vector<2xi84>) : vector<2xi84>
    %4 = llvm.mlir.constant(0 : i84) : i84
    %5 = llvm.mlir.constant(dense<0> : vector<2xi84>) : vector<2xi84>
    %6 = llvm.ashr %arg0, %1  : vector<2xi84>
    %7 = llvm.and %6, %3  : vector<2xi84>
    %8 = llvm.icmp "ne" %7, %5 : vector<2xi84>
    llvm.return %8 : vector<2xi1>
  }]

def test16vec_nonuniform_before := [llvmfunc|
  llvm.func @test16vec_nonuniform(%arg0: vector<2xi84>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(2 : i84) : i84
    %1 = llvm.mlir.constant(4 : i84) : i84
    %2 = llvm.mlir.constant(dense<[4, 2]> : vector<2xi84>) : vector<2xi84>
    %3 = llvm.mlir.constant(1 : i84) : i84
    %4 = llvm.mlir.constant(dense<1> : vector<2xi84>) : vector<2xi84>
    %5 = llvm.mlir.constant(0 : i84) : i84
    %6 = llvm.mlir.constant(dense<0> : vector<2xi84>) : vector<2xi84>
    %7 = llvm.ashr %arg0, %2  : vector<2xi84>
    %8 = llvm.and %7, %4  : vector<2xi84>
    %9 = llvm.icmp "ne" %8, %6 : vector<2xi84>
    llvm.return %9 : vector<2xi1>
  }]

def test16vec_undef_before := [llvmfunc|
  llvm.func @test16vec_undef(%arg0: vector<2xi84>) -> vector<2xi1> {
    %0 = llvm.mlir.undef : i84
    %1 = llvm.mlir.constant(4 : i84) : i84
    %2 = llvm.mlir.undef : vector<2xi84>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi84>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi84>
    %7 = llvm.mlir.constant(1 : i84) : i84
    %8 = llvm.mlir.constant(dense<1> : vector<2xi84>) : vector<2xi84>
    %9 = llvm.mlir.constant(0 : i84) : i84
    %10 = llvm.mlir.constant(dense<0> : vector<2xi84>) : vector<2xi84>
    %11 = llvm.ashr %arg0, %6  : vector<2xi84>
    %12 = llvm.and %11, %8  : vector<2xi84>
    %13 = llvm.icmp "ne" %12, %10 : vector<2xi84>
    llvm.return %13 : vector<2xi1>
  }]

def test17_before := [llvmfunc|
  llvm.func @test17(%arg0: i106) -> i1 {
    %0 = llvm.mlir.constant(3 : i106) : i106
    %1 = llvm.mlir.constant(1234 : i106) : i106
    %2 = llvm.lshr %arg0, %0  : i106
    %3 = llvm.icmp "eq" %2, %1 : i106
    llvm.return %3 : i1
  }]

def test17vec_before := [llvmfunc|
  llvm.func @test17vec(%arg0: vector<2xi106>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(3 : i106) : i106
    %1 = llvm.mlir.constant(dense<3> : vector<2xi106>) : vector<2xi106>
    %2 = llvm.mlir.constant(1234 : i106) : i106
    %3 = llvm.mlir.constant(dense<1234> : vector<2xi106>) : vector<2xi106>
    %4 = llvm.lshr %arg0, %1  : vector<2xi106>
    %5 = llvm.icmp "eq" %4, %3 : vector<2xi106>
    llvm.return %5 : vector<2xi1>
  }]

def test18_before := [llvmfunc|
  llvm.func @test18(%arg0: i11) -> i1 {
    %0 = llvm.mlir.constant(10 : i11) : i11
    %1 = llvm.mlir.constant(123 : i11) : i11
    %2 = llvm.lshr %arg0, %0  : i11
    %3 = llvm.icmp "eq" %2, %1 : i11
    llvm.return %3 : i1
  }]

def test19_before := [llvmfunc|
  llvm.func @test19(%arg0: i37) -> i1 {
    %0 = llvm.mlir.constant(2 : i37) : i37
    %1 = llvm.mlir.constant(0 : i37) : i37
    %2 = llvm.ashr %arg0, %0  : i37
    %3 = llvm.icmp "eq" %2, %1 : i37
    llvm.return %3 : i1
  }]

def test19vec_before := [llvmfunc|
  llvm.func @test19vec(%arg0: vector<2xi37>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(2 : i37) : i37
    %1 = llvm.mlir.constant(dense<2> : vector<2xi37>) : vector<2xi37>
    %2 = llvm.mlir.constant(0 : i37) : i37
    %3 = llvm.mlir.constant(dense<0> : vector<2xi37>) : vector<2xi37>
    %4 = llvm.ashr %arg0, %1  : vector<2xi37>
    %5 = llvm.icmp "eq" %4, %3 : vector<2xi37>
    llvm.return %5 : vector<2xi1>
  }]

def test19a_before := [llvmfunc|
  llvm.func @test19a(%arg0: i39) -> i1 {
    %0 = llvm.mlir.constant(2 : i39) : i39
    %1 = llvm.mlir.constant(-1 : i39) : i39
    %2 = llvm.ashr %arg0, %0  : i39
    %3 = llvm.icmp "eq" %2, %1 : i39
    llvm.return %3 : i1
  }]

def test19a_vec_before := [llvmfunc|
  llvm.func @test19a_vec(%arg0: vector<2xi39>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(2 : i39) : i39
    %1 = llvm.mlir.constant(dense<2> : vector<2xi39>) : vector<2xi39>
    %2 = llvm.mlir.constant(-1 : i39) : i39
    %3 = llvm.mlir.constant(dense<-1> : vector<2xi39>) : vector<2xi39>
    %4 = llvm.ashr %arg0, %1  : vector<2xi39>
    %5 = llvm.icmp "eq" %4, %3 : vector<2xi39>
    llvm.return %5 : vector<2xi1>
  }]

def test20_before := [llvmfunc|
  llvm.func @test20(%arg0: i13) -> i1 {
    %0 = llvm.mlir.constant(12 : i13) : i13
    %1 = llvm.mlir.constant(123 : i13) : i13
    %2 = llvm.ashr %arg0, %0  : i13
    %3 = llvm.icmp "eq" %2, %1 : i13
    llvm.return %3 : i1
  }]

def test21_before := [llvmfunc|
  llvm.func @test21(%arg0: i12) -> i1 {
    %0 = llvm.mlir.constant(6 : i12) : i12
    %1 = llvm.mlir.constant(-128 : i12) : i12
    %2 = llvm.shl %arg0, %0  : i12
    %3 = llvm.icmp "eq" %2, %1 : i12
    llvm.return %3 : i1
  }]

def test22_before := [llvmfunc|
  llvm.func @test22(%arg0: i14) -> i1 {
    %0 = llvm.mlir.constant(7 : i14) : i14
    %1 = llvm.mlir.constant(0 : i14) : i14
    %2 = llvm.shl %arg0, %0  : i14
    %3 = llvm.icmp "eq" %2, %1 : i14
    llvm.return %3 : i1
  }]

def test23_before := [llvmfunc|
  llvm.func @test23(%arg0: i44) -> i11 {
    %0 = llvm.mlir.constant(33 : i44) : i44
    %1 = llvm.shl %arg0, %0  : i44
    %2 = llvm.ashr %1, %0  : i44
    %3 = llvm.trunc %2 : i44 to i11
    llvm.return %3 : i11
  }]

def shl_lshr_eq_amt_multi_use_before := [llvmfunc|
  llvm.func @shl_lshr_eq_amt_multi_use(%arg0: i44) -> i44 {
    %0 = llvm.mlir.constant(33 : i44) : i44
    %1 = llvm.shl %arg0, %0  : i44
    %2 = llvm.lshr %1, %0  : i44
    %3 = llvm.add %1, %2  : i44
    llvm.return %3 : i44
  }]

def shl_lshr_eq_amt_multi_use_splat_vec_before := [llvmfunc|
  llvm.func @shl_lshr_eq_amt_multi_use_splat_vec(%arg0: vector<2xi44>) -> vector<2xi44> {
    %0 = llvm.mlir.constant(33 : i44) : i44
    %1 = llvm.mlir.constant(dense<33> : vector<2xi44>) : vector<2xi44>
    %2 = llvm.shl %arg0, %1  : vector<2xi44>
    %3 = llvm.lshr %2, %1  : vector<2xi44>
    %4 = llvm.add %2, %3  : vector<2xi44>
    llvm.return %4 : vector<2xi44>
  }]

def lshr_shl_eq_amt_multi_use_before := [llvmfunc|
  llvm.func @lshr_shl_eq_amt_multi_use(%arg0: i43) -> i43 {
    %0 = llvm.mlir.constant(23 : i43) : i43
    %1 = llvm.lshr %arg0, %0  : i43
    %2 = llvm.shl %1, %0  : i43
    %3 = llvm.mul %1, %2  : i43
    llvm.return %3 : i43
  }]

def lshr_shl_eq_amt_multi_use_splat_vec_before := [llvmfunc|
  llvm.func @lshr_shl_eq_amt_multi_use_splat_vec(%arg0: vector<2xi43>) -> vector<2xi43> {
    %0 = llvm.mlir.constant(23 : i43) : i43
    %1 = llvm.mlir.constant(dense<23> : vector<2xi43>) : vector<2xi43>
    %2 = llvm.lshr %arg0, %1  : vector<2xi43>
    %3 = llvm.shl %2, %1  : vector<2xi43>
    %4 = llvm.mul %2, %3  : vector<2xi43>
    llvm.return %4 : vector<2xi43>
  }]

def test25_before := [llvmfunc|
  llvm.func @test25(%arg0: i37, %arg1: i37) -> i37 {
    %0 = llvm.mlir.constant(17 : i37) : i37
    %1 = llvm.lshr %arg1, %0  : i37
    %2 = llvm.lshr %arg0, %0  : i37
    %3 = llvm.add %2, %1  : i37
    %4 = llvm.shl %3, %0  : i37
    llvm.return %4 : i37
  }]

def test26_before := [llvmfunc|
  llvm.func @test26(%arg0: i40) -> i40 {
    %0 = llvm.mlir.constant(1 : i40) : i40
    %1 = llvm.lshr %arg0, %0  : i40
    %2 = llvm.bitcast %1 : i40 to i40
    %3 = llvm.shl %2, %0  : i40
    llvm.return %3 : i40
  }]

def ossfuzz_9880_before := [llvmfunc|
  llvm.func @ossfuzz_9880(%arg0: i177) -> i177 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i177) : i177
    %2 = llvm.mlir.constant(-1 : i177) : i177
    %3 = llvm.alloca %0 x i177 {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    %4 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i177]

    %5 = llvm.or %1, %2  : i177
    %6 = llvm.udiv %4, %5  : i177
    %7 = llvm.add %6, %5  : i177
    %8 = llvm.add %5, %7  : i177
    %9 = llvm.mul %6, %8  : i177
    %10 = llvm.shl %4, %9  : i177
    %11 = llvm.sub %10, %6  : i177
    %12 = llvm.udiv %11, %9  : i177
    llvm.return %12 : i177
  }]

def test6_combined := [llvmfunc|
  llvm.func @test6(%arg0: i55) -> i55 {
    %0 = llvm.mlir.constant(6 : i55) : i55
    %1 = llvm.mul %arg0, %0  : i55
    llvm.return %1 : i55
  }]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
def test6a_combined := [llvmfunc|
  llvm.func @test6a(%arg0: i55) -> i55 {
    %0 = llvm.mlir.constant(6 : i55) : i55
    %1 = llvm.mul %arg0, %0  : i55
    llvm.return %1 : i55
  }]

theorem inst_combine_test6a   : test6a_before  ⊑  test6a_combined := by
  unfold test6a_before test6a_combined
  simp_alive_peephole
  sorry
def test6a_negative_oneuse_combined := [llvmfunc|
  llvm.func @test6a_negative_oneuse(%arg0: i55) -> i55 {
    %0 = llvm.mlir.constant(3 : i55) : i55
    %1 = llvm.mlir.constant(6 : i55) : i55
    %2 = llvm.mul %arg0, %0  : i55
    %3 = llvm.mul %arg0, %1  : i55
    llvm.call @use(%2) : (i55) -> ()
    llvm.return %3 : i55
  }]

theorem inst_combine_test6a_negative_oneuse   : test6a_negative_oneuse_before  ⊑  test6a_negative_oneuse_combined := by
  unfold test6a_negative_oneuse_before test6a_negative_oneuse_combined
  simp_alive_peephole
  sorry
def test6a_vec_combined := [llvmfunc|
  llvm.func @test6a_vec(%arg0: vector<2xi55>) -> vector<2xi55> {
    %0 = llvm.mlir.constant(48 : i55) : i55
    %1 = llvm.mlir.constant(6 : i55) : i55
    %2 = llvm.mlir.constant(dense<[6, 48]> : vector<2xi55>) : vector<2xi55>
    %3 = llvm.mul %arg0, %2  : vector<2xi55>
    llvm.return %3 : vector<2xi55>
  }]

theorem inst_combine_test6a_vec   : test6a_vec_before  ⊑  test6a_vec_combined := by
  unfold test6a_vec_before test6a_vec_combined
  simp_alive_peephole
  sorry
def test7_combined := [llvmfunc|
  llvm.func @test7(%arg0: i8) -> i29 {
    %0 = llvm.mlir.constant(-1 : i29) : i29
    llvm.return %0 : i29
  }]

theorem inst_combine_test7   : test7_before  ⊑  test7_combined := by
  unfold test7_before test7_combined
  simp_alive_peephole
  sorry
def test8_combined := [llvmfunc|
  llvm.func @test8(%arg0: i7) -> i7 {
    %0 = llvm.mlir.constant(0 : i7) : i7
    llvm.return %0 : i7
  }]

theorem inst_combine_test8   : test8_before  ⊑  test8_combined := by
  unfold test8_before test8_combined
  simp_alive_peephole
  sorry
def test9_combined := [llvmfunc|
  llvm.func @test9(%arg0: i17) -> i17 {
    %0 = llvm.mlir.constant(1 : i17) : i17
    %1 = llvm.and %arg0, %0  : i17
    llvm.return %1 : i17
  }]

theorem inst_combine_test9   : test9_before  ⊑  test9_combined := by
  unfold test9_before test9_combined
  simp_alive_peephole
  sorry
def test10_combined := [llvmfunc|
  llvm.func @test10(%arg0: i19) -> i19 {
    %0 = llvm.mlir.constant(-262144 : i19) : i19
    %1 = llvm.and %arg0, %0  : i19
    llvm.return %1 : i19
  }]

theorem inst_combine_test10   : test10_before  ⊑  test10_combined := by
  unfold test10_before test10_combined
  simp_alive_peephole
  sorry
def lshr_lshr_splat_vec_combined := [llvmfunc|
  llvm.func @lshr_lshr_splat_vec(%arg0: vector<2xi19>) -> vector<2xi19> {
    %0 = llvm.mlir.constant(5 : i19) : i19
    %1 = llvm.mlir.constant(dense<5> : vector<2xi19>) : vector<2xi19>
    %2 = llvm.lshr %arg0, %1  : vector<2xi19>
    llvm.return %2 : vector<2xi19>
  }]

theorem inst_combine_lshr_lshr_splat_vec   : lshr_lshr_splat_vec_before  ⊑  lshr_lshr_splat_vec_combined := by
  unfold lshr_lshr_splat_vec_before lshr_lshr_splat_vec_combined
  simp_alive_peephole
  sorry
def multiuse_lshr_lshr_combined := [llvmfunc|
  llvm.func @multiuse_lshr_lshr(%arg0: i9) -> i9 {
    %0 = llvm.mlir.constant(2 : i9) : i9
    %1 = llvm.mlir.constant(5 : i9) : i9
    %2 = llvm.lshr %arg0, %0  : i9
    %3 = llvm.lshr %arg0, %1  : i9
    %4 = llvm.mul %2, %3  : i9
    llvm.return %4 : i9
  }]

theorem inst_combine_multiuse_lshr_lshr   : multiuse_lshr_lshr_before  ⊑  multiuse_lshr_lshr_combined := by
  unfold multiuse_lshr_lshr_before multiuse_lshr_lshr_combined
  simp_alive_peephole
  sorry
def multiuse_lshr_lshr_splat_combined := [llvmfunc|
  llvm.func @multiuse_lshr_lshr_splat(%arg0: vector<2xi9>) -> vector<2xi9> {
    %0 = llvm.mlir.constant(2 : i9) : i9
    %1 = llvm.mlir.constant(dense<2> : vector<2xi9>) : vector<2xi9>
    %2 = llvm.mlir.constant(5 : i9) : i9
    %3 = llvm.mlir.constant(dense<5> : vector<2xi9>) : vector<2xi9>
    %4 = llvm.lshr %arg0, %1  : vector<2xi9>
    %5 = llvm.lshr %arg0, %3  : vector<2xi9>
    %6 = llvm.mul %4, %5  : vector<2xi9>
    llvm.return %6 : vector<2xi9>
  }]

theorem inst_combine_multiuse_lshr_lshr_splat   : multiuse_lshr_lshr_splat_before  ⊑  multiuse_lshr_lshr_splat_combined := by
  unfold multiuse_lshr_lshr_splat_before multiuse_lshr_lshr_splat_combined
  simp_alive_peephole
  sorry
def shl_shl_splat_vec_combined := [llvmfunc|
  llvm.func @shl_shl_splat_vec(%arg0: vector<2xi19>) -> vector<2xi19> {
    %0 = llvm.mlir.constant(5 : i19) : i19
    %1 = llvm.mlir.constant(dense<5> : vector<2xi19>) : vector<2xi19>
    %2 = llvm.shl %arg0, %1  : vector<2xi19>
    llvm.return %2 : vector<2xi19>
  }]

theorem inst_combine_shl_shl_splat_vec   : shl_shl_splat_vec_before  ⊑  shl_shl_splat_vec_combined := by
  unfold shl_shl_splat_vec_before shl_shl_splat_vec_combined
  simp_alive_peephole
  sorry
def multiuse_shl_shl_combined := [llvmfunc|
  llvm.func @multiuse_shl_shl(%arg0: i42) -> i42 {
    %0 = llvm.mlir.constant(8 : i42) : i42
    %1 = llvm.mlir.constant(17 : i42) : i42
    %2 = llvm.shl %arg0, %0  : i42
    %3 = llvm.shl %arg0, %1  : i42
    %4 = llvm.mul %2, %3  : i42
    llvm.return %4 : i42
  }]

theorem inst_combine_multiuse_shl_shl   : multiuse_shl_shl_before  ⊑  multiuse_shl_shl_combined := by
  unfold multiuse_shl_shl_before multiuse_shl_shl_combined
  simp_alive_peephole
  sorry
def multiuse_shl_shl_splat_combined := [llvmfunc|
  llvm.func @multiuse_shl_shl_splat(%arg0: vector<2xi42>) -> vector<2xi42> {
    %0 = llvm.mlir.constant(8 : i42) : i42
    %1 = llvm.mlir.constant(dense<8> : vector<2xi42>) : vector<2xi42>
    %2 = llvm.mlir.constant(17 : i42) : i42
    %3 = llvm.mlir.constant(dense<17> : vector<2xi42>) : vector<2xi42>
    %4 = llvm.shl %arg0, %1  : vector<2xi42>
    %5 = llvm.shl %arg0, %3  : vector<2xi42>
    %6 = llvm.mul %4, %5  : vector<2xi42>
    llvm.return %6 : vector<2xi42>
  }]

theorem inst_combine_multiuse_shl_shl_splat   : multiuse_shl_shl_splat_before  ⊑  multiuse_shl_shl_splat_combined := by
  unfold multiuse_shl_shl_splat_before multiuse_shl_shl_splat_combined
  simp_alive_peephole
  sorry
def eq_shl_lshr_splat_vec_combined := [llvmfunc|
  llvm.func @eq_shl_lshr_splat_vec(%arg0: vector<2xi19>) -> vector<2xi19> {
    %0 = llvm.mlir.constant(65535 : i19) : i19
    %1 = llvm.mlir.constant(dense<65535> : vector<2xi19>) : vector<2xi19>
    %2 = llvm.and %arg0, %1  : vector<2xi19>
    llvm.return %2 : vector<2xi19>
  }]

theorem inst_combine_eq_shl_lshr_splat_vec   : eq_shl_lshr_splat_vec_before  ⊑  eq_shl_lshr_splat_vec_combined := by
  unfold eq_shl_lshr_splat_vec_before eq_shl_lshr_splat_vec_combined
  simp_alive_peephole
  sorry
def eq_lshr_shl_splat_vec_combined := [llvmfunc|
  llvm.func @eq_lshr_shl_splat_vec(%arg0: vector<2xi19>) -> vector<2xi19> {
    %0 = llvm.mlir.constant(-8 : i19) : i19
    %1 = llvm.mlir.constant(dense<-8> : vector<2xi19>) : vector<2xi19>
    %2 = llvm.and %arg0, %1  : vector<2xi19>
    llvm.return %2 : vector<2xi19>
  }]

theorem inst_combine_eq_lshr_shl_splat_vec   : eq_lshr_shl_splat_vec_before  ⊑  eq_lshr_shl_splat_vec_combined := by
  unfold eq_lshr_shl_splat_vec_before eq_lshr_shl_splat_vec_combined
  simp_alive_peephole
  sorry
def lshr_shl_splat_vec_combined := [llvmfunc|
  llvm.func @lshr_shl_splat_vec(%arg0: vector<2xi7>) -> vector<2xi7> {
    %0 = llvm.mlir.constant(60 : i7) : i7
    %1 = llvm.mlir.constant(dense<60> : vector<2xi7>) : vector<2xi7>
    %2 = llvm.mul %arg0, %1  : vector<2xi7>
    %3 = llvm.and %2, %1  : vector<2xi7>
    llvm.return %3 : vector<2xi7>
  }]

theorem inst_combine_lshr_shl_splat_vec   : lshr_shl_splat_vec_before  ⊑  lshr_shl_splat_vec_combined := by
  unfold lshr_shl_splat_vec_before lshr_shl_splat_vec_combined
  simp_alive_peephole
  sorry
def shl_lshr_splat_vec_combined := [llvmfunc|
  llvm.func @shl_lshr_splat_vec(%arg0: vector<2xi7>) -> vector<2xi7> {
    %0 = llvm.mlir.constant(9 : i7) : i7
    %1 = llvm.mlir.constant(dense<9> : vector<2xi7>) : vector<2xi7>
    %2 = llvm.mlir.constant(1 : i7) : i7
    %3 = llvm.mlir.constant(dense<1> : vector<2xi7>) : vector<2xi7>
    %4 = llvm.udiv %arg0, %1  : vector<2xi7>
    %5 = llvm.shl %4, %3 overflow<nsw, nuw>  : vector<2xi7>
    llvm.return %5 : vector<2xi7>
  }]

theorem inst_combine_shl_lshr_splat_vec   : shl_lshr_splat_vec_before  ⊑  shl_lshr_splat_vec_combined := by
  unfold shl_lshr_splat_vec_before shl_lshr_splat_vec_combined
  simp_alive_peephole
  sorry
def test11_combined := [llvmfunc|
  llvm.func @test11(%arg0: i23) -> i23 {
    %0 = llvm.mlir.constant(6 : i23) : i23
    %1 = llvm.mlir.constant(-4096 : i23) : i23
    %2 = llvm.mul %arg0, %0  : i23
    %3 = llvm.and %2, %1  : i23
    llvm.return %3 : i23
  }]

theorem inst_combine_test11   : test11_before  ⊑  test11_combined := by
  unfold test11_before test11_combined
  simp_alive_peephole
  sorry
def test12_combined := [llvmfunc|
  llvm.func @test12(%arg0: i47) -> i47 {
    %0 = llvm.mlir.constant(-256 : i47) : i47
    %1 = llvm.and %arg0, %0  : i47
    llvm.return %1 : i47
  }]

theorem inst_combine_test12   : test12_before  ⊑  test12_combined := by
  unfold test12_before test12_combined
  simp_alive_peephole
  sorry
def test12_splat_vec_combined := [llvmfunc|
  llvm.func @test12_splat_vec(%arg0: vector<2xi47>) -> vector<2xi47> {
    %0 = llvm.mlir.constant(-256 : i47) : i47
    %1 = llvm.mlir.constant(dense<-256> : vector<2xi47>) : vector<2xi47>
    %2 = llvm.and %arg0, %1  : vector<2xi47>
    llvm.return %2 : vector<2xi47>
  }]

theorem inst_combine_test12_splat_vec   : test12_splat_vec_before  ⊑  test12_splat_vec_combined := by
  unfold test12_splat_vec_before test12_splat_vec_combined
  simp_alive_peephole
  sorry
def test13_combined := [llvmfunc|
  llvm.func @test13(%arg0: i18) -> i18 {
    %0 = llvm.mlir.constant(6 : i18) : i18
    %1 = llvm.mlir.constant(-512 : i18) : i18
    %2 = llvm.mul %arg0, %0  : i18
    %3 = llvm.and %2, %1  : i18
    llvm.return %3 : i18
  }]

theorem inst_combine_test13   : test13_before  ⊑  test13_combined := by
  unfold test13_before test13_combined
  simp_alive_peephole
  sorry
def test14_combined := [llvmfunc|
  llvm.func @test14(%arg0: i35) -> i35 {
    %0 = llvm.mlir.constant(-19760 : i35) : i35
    %1 = llvm.mlir.constant(19744 : i35) : i35
    %2 = llvm.and %arg0, %0  : i35
    %3 = llvm.or %2, %1  : i35
    llvm.return %3 : i35
  }]

theorem inst_combine_test14   : test14_before  ⊑  test14_combined := by
  unfold test14_before test14_combined
  simp_alive_peephole
  sorry
def test14a_combined := [llvmfunc|
  llvm.func @test14a(%arg0: i79) -> i79 {
    %0 = llvm.mlir.constant(77 : i79) : i79
    %1 = llvm.and %arg0, %0  : i79
    llvm.return %1 : i79
  }]

theorem inst_combine_test14a   : test14a_before  ⊑  test14a_combined := by
  unfold test14a_before test14a_combined
  simp_alive_peephole
  sorry
def test15_combined := [llvmfunc|
  llvm.func @test15(%arg0: i1) -> i45 {
    %0 = llvm.mlir.constant(12 : i45) : i45
    %1 = llvm.mlir.constant(4 : i45) : i45
    %2 = llvm.select %arg0, %0, %1 : i1, i45
    llvm.return %2 : i45
  }]

theorem inst_combine_test15   : test15_before  ⊑  test15_combined := by
  unfold test15_before test15_combined
  simp_alive_peephole
  sorry
def test15a_combined := [llvmfunc|
  llvm.func @test15a(%arg0: i1) -> i53 {
    %0 = llvm.mlir.constant(512 : i53) : i53
    %1 = llvm.mlir.constant(128 : i53) : i53
    %2 = llvm.select %arg0, %0, %1 : i1, i53
    llvm.return %2 : i53
  }]

theorem inst_combine_test15a   : test15a_before  ⊑  test15a_combined := by
  unfold test15a_before test15a_combined
  simp_alive_peephole
  sorry
def test16_combined := [llvmfunc|
  llvm.func @test16(%arg0: i84) -> i1 {
    %0 = llvm.mlir.constant(16 : i84) : i84
    %1 = llvm.mlir.constant(0 : i84) : i84
    %2 = llvm.and %arg0, %0  : i84
    %3 = llvm.icmp "ne" %2, %1 : i84
    llvm.return %3 : i1
  }]

theorem inst_combine_test16   : test16_before  ⊑  test16_combined := by
  unfold test16_before test16_combined
  simp_alive_peephole
  sorry
def test16vec_combined := [llvmfunc|
  llvm.func @test16vec(%arg0: vector<2xi84>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(16 : i84) : i84
    %1 = llvm.mlir.constant(dense<16> : vector<2xi84>) : vector<2xi84>
    %2 = llvm.mlir.constant(0 : i84) : i84
    %3 = llvm.mlir.constant(dense<0> : vector<2xi84>) : vector<2xi84>
    %4 = llvm.and %arg0, %1  : vector<2xi84>
    %5 = llvm.icmp "ne" %4, %3 : vector<2xi84>
    llvm.return %5 : vector<2xi1>
  }]

theorem inst_combine_test16vec   : test16vec_before  ⊑  test16vec_combined := by
  unfold test16vec_before test16vec_combined
  simp_alive_peephole
  sorry
def test16vec_nonuniform_combined := [llvmfunc|
  llvm.func @test16vec_nonuniform(%arg0: vector<2xi84>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(4 : i84) : i84
    %1 = llvm.mlir.constant(16 : i84) : i84
    %2 = llvm.mlir.constant(dense<[16, 4]> : vector<2xi84>) : vector<2xi84>
    %3 = llvm.mlir.constant(0 : i84) : i84
    %4 = llvm.mlir.constant(dense<0> : vector<2xi84>) : vector<2xi84>
    %5 = llvm.and %arg0, %2  : vector<2xi84>
    %6 = llvm.icmp "ne" %5, %4 : vector<2xi84>
    llvm.return %6 : vector<2xi1>
  }]

theorem inst_combine_test16vec_nonuniform   : test16vec_nonuniform_before  ⊑  test16vec_nonuniform_combined := by
  unfold test16vec_nonuniform_before test16vec_nonuniform_combined
  simp_alive_peephole
  sorry
def test16vec_undef_combined := [llvmfunc|
  llvm.func @test16vec_undef(%arg0: vector<2xi84>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : i84
    %1 = llvm.mlir.constant(16 : i84) : i84
    %2 = llvm.mlir.undef : vector<2xi84>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi84>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi84>
    %7 = llvm.mlir.constant(0 : i84) : i84
    %8 = llvm.mlir.constant(dense<0> : vector<2xi84>) : vector<2xi84>
    %9 = llvm.and %arg0, %6  : vector<2xi84>
    %10 = llvm.icmp "ne" %9, %8 : vector<2xi84>
    llvm.return %10 : vector<2xi1>
  }]

theorem inst_combine_test16vec_undef   : test16vec_undef_before  ⊑  test16vec_undef_combined := by
  unfold test16vec_undef_before test16vec_undef_combined
  simp_alive_peephole
  sorry
def test17_combined := [llvmfunc|
  llvm.func @test17(%arg0: i106) -> i1 {
    %0 = llvm.mlir.constant(-8 : i106) : i106
    %1 = llvm.mlir.constant(9872 : i106) : i106
    %2 = llvm.and %arg0, %0  : i106
    %3 = llvm.icmp "eq" %2, %1 : i106
    llvm.return %3 : i1
  }]

theorem inst_combine_test17   : test17_before  ⊑  test17_combined := by
  unfold test17_before test17_combined
  simp_alive_peephole
  sorry
def test17vec_combined := [llvmfunc|
  llvm.func @test17vec(%arg0: vector<2xi106>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(-8 : i106) : i106
    %1 = llvm.mlir.constant(dense<-8> : vector<2xi106>) : vector<2xi106>
    %2 = llvm.mlir.constant(9872 : i106) : i106
    %3 = llvm.mlir.constant(dense<9872> : vector<2xi106>) : vector<2xi106>
    %4 = llvm.and %arg0, %1  : vector<2xi106>
    %5 = llvm.icmp "eq" %4, %3 : vector<2xi106>
    llvm.return %5 : vector<2xi1>
  }]

theorem inst_combine_test17vec   : test17vec_before  ⊑  test17vec_combined := by
  unfold test17vec_before test17vec_combined
  simp_alive_peephole
  sorry
def test18_combined := [llvmfunc|
  llvm.func @test18(%arg0: i11) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test18   : test18_before  ⊑  test18_combined := by
  unfold test18_before test18_combined
  simp_alive_peephole
  sorry
def test19_combined := [llvmfunc|
  llvm.func @test19(%arg0: i37) -> i1 {
    %0 = llvm.mlir.constant(4 : i37) : i37
    %1 = llvm.icmp "ult" %arg0, %0 : i37
    llvm.return %1 : i1
  }]

theorem inst_combine_test19   : test19_before  ⊑  test19_combined := by
  unfold test19_before test19_combined
  simp_alive_peephole
  sorry
def test19vec_combined := [llvmfunc|
  llvm.func @test19vec(%arg0: vector<2xi37>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(4 : i37) : i37
    %1 = llvm.mlir.constant(dense<4> : vector<2xi37>) : vector<2xi37>
    %2 = llvm.icmp "ult" %arg0, %1 : vector<2xi37>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_test19vec   : test19vec_before  ⊑  test19vec_combined := by
  unfold test19vec_before test19vec_combined
  simp_alive_peephole
  sorry
def test19a_combined := [llvmfunc|
  llvm.func @test19a(%arg0: i39) -> i1 {
    %0 = llvm.mlir.constant(-5 : i39) : i39
    %1 = llvm.icmp "ugt" %arg0, %0 : i39
    llvm.return %1 : i1
  }]

theorem inst_combine_test19a   : test19a_before  ⊑  test19a_combined := by
  unfold test19a_before test19a_combined
  simp_alive_peephole
  sorry
def test19a_vec_combined := [llvmfunc|
  llvm.func @test19a_vec(%arg0: vector<2xi39>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(-5 : i39) : i39
    %1 = llvm.mlir.constant(dense<-5> : vector<2xi39>) : vector<2xi39>
    %2 = llvm.icmp "ugt" %arg0, %1 : vector<2xi39>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_test19a_vec   : test19a_vec_before  ⊑  test19a_vec_combined := by
  unfold test19a_vec_before test19a_vec_combined
  simp_alive_peephole
  sorry
def test20_combined := [llvmfunc|
  llvm.func @test20(%arg0: i13) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test20   : test20_before  ⊑  test20_combined := by
  unfold test20_before test20_combined
  simp_alive_peephole
  sorry
def test21_combined := [llvmfunc|
  llvm.func @test21(%arg0: i12) -> i1 {
    %0 = llvm.mlir.constant(63 : i12) : i12
    %1 = llvm.mlir.constant(62 : i12) : i12
    %2 = llvm.and %arg0, %0  : i12
    %3 = llvm.icmp "eq" %2, %1 : i12
    llvm.return %3 : i1
  }]

theorem inst_combine_test21   : test21_before  ⊑  test21_combined := by
  unfold test21_before test21_combined
  simp_alive_peephole
  sorry
def test22_combined := [llvmfunc|
  llvm.func @test22(%arg0: i14) -> i1 {
    %0 = llvm.mlir.constant(127 : i14) : i14
    %1 = llvm.mlir.constant(0 : i14) : i14
    %2 = llvm.and %arg0, %0  : i14
    %3 = llvm.icmp "eq" %2, %1 : i14
    llvm.return %3 : i1
  }]

theorem inst_combine_test22   : test22_before  ⊑  test22_combined := by
  unfold test22_before test22_combined
  simp_alive_peephole
  sorry
def test23_combined := [llvmfunc|
  llvm.func @test23(%arg0: i44) -> i11 {
    %0 = llvm.trunc %arg0 : i44 to i11
    llvm.return %0 : i11
  }]

theorem inst_combine_test23   : test23_before  ⊑  test23_combined := by
  unfold test23_before test23_combined
  simp_alive_peephole
  sorry
def shl_lshr_eq_amt_multi_use_combined := [llvmfunc|
  llvm.func @shl_lshr_eq_amt_multi_use(%arg0: i44) -> i44 {
    %0 = llvm.mlir.constant(33 : i44) : i44
    %1 = llvm.mlir.constant(2047 : i44) : i44
    %2 = llvm.shl %arg0, %0  : i44
    %3 = llvm.and %arg0, %1  : i44
    %4 = llvm.or %2, %3  : i44
    llvm.return %4 : i44
  }]

theorem inst_combine_shl_lshr_eq_amt_multi_use   : shl_lshr_eq_amt_multi_use_before  ⊑  shl_lshr_eq_amt_multi_use_combined := by
  unfold shl_lshr_eq_amt_multi_use_before shl_lshr_eq_amt_multi_use_combined
  simp_alive_peephole
  sorry
def shl_lshr_eq_amt_multi_use_splat_vec_combined := [llvmfunc|
  llvm.func @shl_lshr_eq_amt_multi_use_splat_vec(%arg0: vector<2xi44>) -> vector<2xi44> {
    %0 = llvm.mlir.constant(33 : i44) : i44
    %1 = llvm.mlir.constant(dense<33> : vector<2xi44>) : vector<2xi44>
    %2 = llvm.mlir.constant(2047 : i44) : i44
    %3 = llvm.mlir.constant(dense<2047> : vector<2xi44>) : vector<2xi44>
    %4 = llvm.shl %arg0, %1  : vector<2xi44>
    %5 = llvm.and %arg0, %3  : vector<2xi44>
    %6 = llvm.or %4, %5  : vector<2xi44>
    llvm.return %6 : vector<2xi44>
  }]

theorem inst_combine_shl_lshr_eq_amt_multi_use_splat_vec   : shl_lshr_eq_amt_multi_use_splat_vec_before  ⊑  shl_lshr_eq_amt_multi_use_splat_vec_combined := by
  unfold shl_lshr_eq_amt_multi_use_splat_vec_before shl_lshr_eq_amt_multi_use_splat_vec_combined
  simp_alive_peephole
  sorry
def lshr_shl_eq_amt_multi_use_combined := [llvmfunc|
  llvm.func @lshr_shl_eq_amt_multi_use(%arg0: i43) -> i43 {
    %0 = llvm.mlir.constant(23 : i43) : i43
    %1 = llvm.mlir.constant(-8388608 : i43) : i43
    %2 = llvm.lshr %arg0, %0  : i43
    %3 = llvm.and %arg0, %1  : i43
    %4 = llvm.mul %2, %3  : i43
    llvm.return %4 : i43
  }]

theorem inst_combine_lshr_shl_eq_amt_multi_use   : lshr_shl_eq_amt_multi_use_before  ⊑  lshr_shl_eq_amt_multi_use_combined := by
  unfold lshr_shl_eq_amt_multi_use_before lshr_shl_eq_amt_multi_use_combined
  simp_alive_peephole
  sorry
def lshr_shl_eq_amt_multi_use_splat_vec_combined := [llvmfunc|
  llvm.func @lshr_shl_eq_amt_multi_use_splat_vec(%arg0: vector<2xi43>) -> vector<2xi43> {
    %0 = llvm.mlir.constant(23 : i43) : i43
    %1 = llvm.mlir.constant(dense<23> : vector<2xi43>) : vector<2xi43>
    %2 = llvm.mlir.constant(-8388608 : i43) : i43
    %3 = llvm.mlir.constant(dense<-8388608> : vector<2xi43>) : vector<2xi43>
    %4 = llvm.lshr %arg0, %1  : vector<2xi43>
    %5 = llvm.and %arg0, %3  : vector<2xi43>
    %6 = llvm.mul %4, %5  : vector<2xi43>
    llvm.return %6 : vector<2xi43>
  }]

theorem inst_combine_lshr_shl_eq_amt_multi_use_splat_vec   : lshr_shl_eq_amt_multi_use_splat_vec_before  ⊑  lshr_shl_eq_amt_multi_use_splat_vec_combined := by
  unfold lshr_shl_eq_amt_multi_use_splat_vec_before lshr_shl_eq_amt_multi_use_splat_vec_combined
  simp_alive_peephole
  sorry
def test25_combined := [llvmfunc|
  llvm.func @test25(%arg0: i37, %arg1: i37) -> i37 {
    %0 = llvm.mlir.constant(-131072 : i37) : i37
    %1 = llvm.and %arg0, %0  : i37
    %2 = llvm.add %1, %arg1  : i37
    %3 = llvm.and %2, %0  : i37
    llvm.return %3 : i37
  }]

theorem inst_combine_test25   : test25_before  ⊑  test25_combined := by
  unfold test25_before test25_combined
  simp_alive_peephole
  sorry
def test26_combined := [llvmfunc|
  llvm.func @test26(%arg0: i40) -> i40 {
    %0 = llvm.mlir.constant(-2 : i40) : i40
    %1 = llvm.and %arg0, %0  : i40
    llvm.return %1 : i40
  }]

theorem inst_combine_test26   : test26_before  ⊑  test26_combined := by
  unfold test26_before test26_combined
  simp_alive_peephole
  sorry
def ossfuzz_9880_combined := [llvmfunc|
  llvm.func @ossfuzz_9880(%arg0: i177) -> i177 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i177) : i177
    %2 = llvm.alloca %0 x i177 {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %3 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> i177
    %4 = llvm.icmp "eq" %3, %1 : i177
    %5 = llvm.sext %4 : i1 to i177
    %6 = llvm.add %3, %5  : i177
    %7 = llvm.icmp "eq" %6, %1 : i177
    %8 = llvm.zext %7 : i1 to i177
    llvm.return %8 : i177
  }]

theorem inst_combine_ossfuzz_9880   : ossfuzz_9880_before  ⊑  ossfuzz_9880_combined := by
  unfold ossfuzz_9880_before ossfuzz_9880_combined
  simp_alive_peephole
  sorry
