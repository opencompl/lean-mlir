import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  minmax-fold
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t1_before := [llvmfunc|
  llvm.func @t1(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    %2 = llvm.select %1, %arg0, %0 : i1, i32
    %3 = llvm.sext %2 : i32 to i64
    llvm.return %3 : i64
  }]

def t2_before := [llvmfunc|
  llvm.func @t2(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(5 : i64) : i64
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.sext %arg0 : i32 to i64
    %4 = llvm.select %2, %3, %1 : i1, i64
    llvm.return %4 : i64
  }]

def t3_before := [llvmfunc|
  llvm.func @t3(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(5 : i64) : i64
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.zext %arg0 : i32 to i64
    %4 = llvm.select %2, %1, %3 : i1, i64
    llvm.return %4 : i64
  }]

def t4_before := [llvmfunc|
  llvm.func @t4(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(5 : i64) : i64
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i64
    %3 = llvm.trunc %arg0 : i64 to i32
    %4 = llvm.select %2, %3, %1 : i1, i32
    llvm.return %4 : i32
  }]

def t5_before := [llvmfunc|
  llvm.func @t5(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(5 : i64) : i64
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.zext %arg0 : i32 to i64
    %4 = llvm.select %2, %1, %3 : i1, i64
    llvm.return %4 : i64
  }]

def t6_before := [llvmfunc|
  llvm.func @t6(%arg0: i32) -> f32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    %2 = llvm.select %1, %arg0, %0 : i1, i32
    %3 = llvm.sitofp %2 : i32 to f32
    llvm.return %3 : f32
  }]

def t7_before := [llvmfunc|
  llvm.func @t7(%arg0: i32) -> i16 {
    %0 = llvm.mlir.constant(-32768 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i16) : i16
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.trunc %arg0 : i32 to i16
    %4 = llvm.select %2, %3, %1 : i1, i16
    llvm.return %4 : i16
  }]

def t8_before := [llvmfunc|
  llvm.func @t8(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-32767 : i64) : i64
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i64
    %3 = llvm.select %2, %arg0, %0 : i1, i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.icmp "slt" %arg1, %1 : i32
    %6 = llvm.select %5, %1, %4 : i1, i32
    %7 = llvm.icmp "ne" %6, %arg1 : i32
    %8 = llvm.zext %7 : i1 to i32
    llvm.return %8 : i32
  }]

def t9_before := [llvmfunc|
  llvm.func @t9(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(4294967295 : i64) : i64
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.sext %arg0 : i32 to i64
    %4 = llvm.select %2, %3, %1 : i1, i64
    llvm.return %4 : i64
  }]

def t10_before := [llvmfunc|
  llvm.func @t10(%arg0: i32) -> f32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %2 = llvm.sitofp %arg0 : i32 to f32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.select %3, %2, %1 : i1, f32
    llvm.return %4 : f32
  }]

def t11_before := [llvmfunc|
  llvm.func @t11(%arg0: i64) -> f32 {
    %0 = llvm.mlir.constant(255 : i64) : i64
    %1 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %2 = llvm.sitofp %arg0 : i64 to f32
    %3 = llvm.icmp "sgt" %arg0, %0 : i64
    %4 = llvm.select %3, %2, %1 : i1, f32
    llvm.return %4 : f32
  }]

def bitcasts_fcmp_1_before := [llvmfunc|
  llvm.func @bitcasts_fcmp_1(%arg0: vector<2xi64>, %arg1: vector<2xi64>) -> vector<4xi32> {
    %0 = llvm.bitcast %arg0 : vector<2xi64> to vector<4xf32>
    %1 = llvm.bitcast %arg1 : vector<2xi64> to vector<4xf32>
    %2 = llvm.fcmp "olt" %1, %0 : vector<4xf32>
    %3 = llvm.bitcast %arg0 : vector<2xi64> to vector<4xi32>
    %4 = llvm.bitcast %arg1 : vector<2xi64> to vector<4xi32>
    %5 = llvm.select %2, %3, %4 : vector<4xi1>, vector<4xi32>
    llvm.return %5 : vector<4xi32>
  }]

def bitcasts_fcmp_2_before := [llvmfunc|
  llvm.func @bitcasts_fcmp_2(%arg0: vector<2xi64>, %arg1: vector<2xi64>) -> vector<4xi32> {
    %0 = llvm.bitcast %arg0 : vector<2xi64> to vector<4xf32>
    %1 = llvm.bitcast %arg1 : vector<2xi64> to vector<4xf32>
    %2 = llvm.fcmp "olt" %0, %1 : vector<4xf32>
    %3 = llvm.bitcast %arg0 : vector<2xi64> to vector<4xi32>
    %4 = llvm.bitcast %arg1 : vector<2xi64> to vector<4xi32>
    %5 = llvm.select %2, %3, %4 : vector<4xi1>, vector<4xi32>
    llvm.return %5 : vector<4xi32>
  }]

def bitcasts_icmp_before := [llvmfunc|
  llvm.func @bitcasts_icmp(%arg0: vector<2xi64>, %arg1: vector<2xi64>) -> vector<4xf32> {
    %0 = llvm.bitcast %arg0 : vector<2xi64> to vector<4xi32>
    %1 = llvm.bitcast %arg1 : vector<2xi64> to vector<4xi32>
    %2 = llvm.icmp "slt" %1, %0 : vector<4xi32>
    %3 = llvm.bitcast %arg0 : vector<2xi64> to vector<4xf32>
    %4 = llvm.bitcast %arg1 : vector<2xi64> to vector<4xf32>
    %5 = llvm.select %2, %3, %4 : vector<4xi1>, vector<4xf32>
    llvm.return %5 : vector<4xf32>
  }]

def test68_before := [llvmfunc|
  llvm.func @test68(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(11 : i32) : i32
    %1 = llvm.mlir.constant(92 : i32) : i32
    %2 = llvm.icmp "slt" %0, %arg0 : i32
    %3 = llvm.select %2, %0, %arg0 : i1, i32
    %4 = llvm.icmp "slt" %1, %3 : i32
    %5 = llvm.select %4, %1, %3 : i1, i32
    llvm.return %5 : i32
  }]

def test68vec_before := [llvmfunc|
  llvm.func @test68vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<11> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<92> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "slt" %0, %arg0 : vector<2xi32>
    %3 = llvm.select %2, %0, %arg0 : vector<2xi1>, vector<2xi32>
    %4 = llvm.icmp "slt" %1, %3 : vector<2xi32>
    %5 = llvm.select %4, %1, %3 : vector<2xi1>, vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

def test69_before := [llvmfunc|
  llvm.func @test69(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(83 : i32) : i32
    %2 = llvm.icmp "ult" %0, %arg0 : i32
    %3 = llvm.select %2, %0, %arg0 : i1, i32
    %4 = llvm.icmp "ult" %1, %3 : i32
    %5 = llvm.select %4, %1, %3 : i1, i32
    llvm.return %5 : i32
  }]

def test70_before := [llvmfunc|
  llvm.func @test70(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(75 : i32) : i32
    %1 = llvm.mlir.constant(36 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %0, %arg0 : i1, i32
    %4 = llvm.icmp "slt" %3, %1 : i32
    %5 = llvm.select %4, %1, %3 : i1, i32
    llvm.return %5 : i32
  }]

def test71_before := [llvmfunc|
  llvm.func @test71(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(68 : i32) : i32
    %1 = llvm.mlir.constant(47 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.select %2, %0, %arg0 : i1, i32
    %4 = llvm.icmp "ult" %3, %1 : i32
    %5 = llvm.select %4, %1, %3 : i1, i32
    llvm.return %5 : i32
  }]

def test72_before := [llvmfunc|
  llvm.func @test72(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(92 : i32) : i32
    %1 = llvm.mlir.constant(11 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.select %2, %0, %arg0 : i1, i32
    %4 = llvm.icmp "sgt" %3, %1 : i32
    %5 = llvm.select %4, %1, %3 : i1, i32
    llvm.return %5 : i32
  }]

def test72vec_before := [llvmfunc|
  llvm.func @test72vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<92> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<11> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "sgt" %arg0, %0 : vector<2xi32>
    %3 = llvm.select %2, %0, %arg0 : vector<2xi1>, vector<2xi32>
    %4 = llvm.icmp "sgt" %3, %1 : vector<2xi32>
    %5 = llvm.select %4, %1, %3 : vector<2xi1>, vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

def test73_before := [llvmfunc|
  llvm.func @test73(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(83 : i32) : i32
    %1 = llvm.mlir.constant(24 : i32) : i32
    %2 = llvm.icmp "ugt" %arg0, %0 : i32
    %3 = llvm.select %2, %0, %arg0 : i1, i32
    %4 = llvm.icmp "ugt" %3, %1 : i32
    %5 = llvm.select %4, %1, %3 : i1, i32
    llvm.return %5 : i32
  }]

def test74_before := [llvmfunc|
  llvm.func @test74(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(36 : i32) : i32
    %1 = llvm.mlir.constant(75 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %0, %arg0 : i1, i32
    %4 = llvm.icmp "slt" %3, %1 : i32
    %5 = llvm.select %4, %1, %3 : i1, i32
    llvm.return %5 : i32
  }]

def test75_before := [llvmfunc|
  llvm.func @test75(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(47 : i32) : i32
    %1 = llvm.mlir.constant(68 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.select %2, %0, %arg0 : i1, i32
    %4 = llvm.icmp "ult" %3, %1 : i32
    %5 = llvm.select %4, %1, %3 : i1, i32
    llvm.return %5 : i32
  }]

def clamp_signed1_before := [llvmfunc|
  llvm.func @clamp_signed1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg0, %0 : i1, i32
    %4 = llvm.icmp "slt" %arg0, %1 : i32
    %5 = llvm.select %4, %1, %3 : i1, i32
    llvm.return %5 : i32
  }]

def clamp_signed2_before := [llvmfunc|
  llvm.func @clamp_signed2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(255 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg0, %0 : i1, i32
    %4 = llvm.icmp "sgt" %arg0, %1 : i32
    %5 = llvm.select %4, %1, %3 : i1, i32
    llvm.return %5 : i32
  }]

def clamp_signed3_before := [llvmfunc|
  llvm.func @clamp_signed3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg0, %0 : i1, i32
    %4 = llvm.icmp "sgt" %arg0, %1 : i32
    %5 = llvm.select %4, %3, %1 : i1, i32
    llvm.return %5 : i32
  }]

def clamp_signed4_before := [llvmfunc|
  llvm.func @clamp_signed4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(255 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg0, %0 : i1, i32
    %4 = llvm.icmp "slt" %arg0, %1 : i32
    %5 = llvm.select %4, %3, %1 : i1, i32
    llvm.return %5 : i32
  }]

def clamp_unsigned1_before := [llvmfunc|
  llvm.func @clamp_unsigned1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.select %2, %arg0, %0 : i1, i32
    %4 = llvm.icmp "ult" %arg0, %1 : i32
    %5 = llvm.select %4, %1, %3 : i1, i32
    llvm.return %5 : i32
  }]

def clamp_unsigned2_before := [llvmfunc|
  llvm.func @clamp_unsigned2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(255 : i32) : i32
    %2 = llvm.icmp "ugt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg0, %0 : i1, i32
    %4 = llvm.icmp "ugt" %arg0, %1 : i32
    %5 = llvm.select %4, %1, %3 : i1, i32
    llvm.return %5 : i32
  }]

def clamp_unsigned3_before := [llvmfunc|
  llvm.func @clamp_unsigned3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.select %2, %arg0, %0 : i1, i32
    %4 = llvm.icmp "ugt" %arg0, %1 : i32
    %5 = llvm.select %4, %3, %1 : i1, i32
    llvm.return %5 : i32
  }]

def clamp_unsigned4_before := [llvmfunc|
  llvm.func @clamp_unsigned4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(255 : i32) : i32
    %2 = llvm.icmp "ugt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg0, %0 : i1, i32
    %4 = llvm.icmp "ult" %arg0, %1 : i32
    %5 = llvm.select %4, %3, %1 : i1, i32
    llvm.return %5 : i32
  }]

def clamp_check_for_no_infinite_loop1_before := [llvmfunc|
  llvm.func @clamp_check_for_no_infinite_loop1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg0, %0 : i1, i32
    %4 = llvm.icmp "slt" %arg0, %1 : i32
    %5 = llvm.select %4, %1, %3 : i1, i32
    llvm.return %5 : i32
  }]

def clamp_check_for_no_infinite_loop2_before := [llvmfunc|
  llvm.func @clamp_check_for_no_infinite_loop2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-255 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg0, %0 : i1, i32
    %4 = llvm.icmp "slt" %arg0, %1 : i32
    %5 = llvm.select %4, %3, %1 : i1, i32
    llvm.return %5 : i32
  }]

def clamp_check_for_no_infinite_loop3_before := [llvmfunc|
  llvm.func @clamp_check_for_no_infinite_loop3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.select %3, %arg0, %0 : i1, i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %6 = llvm.icmp "slt" %4, %2 : i32
    %7 = llvm.select %6, %4, %2 : i1, i32
    %8 = llvm.shl %7, %2 overflow<nsw, nuw>  : i32
    llvm.return %8 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i32
  }]

def PR31751_umin1_before := [llvmfunc|
  llvm.func @PR31751_umin1(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(2147483647 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %1, %arg0 : i1, i32
    %4 = llvm.sitofp %3 : i32 to f64
    llvm.return %4 : f64
  }]

def PR31751_umin2_before := [llvmfunc|
  llvm.func @PR31751_umin2(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.icmp "ult" %arg0, %0 : i32
    %2 = llvm.select %1, %arg0, %0 : i1, i32
    %3 = llvm.sitofp %2 : i32 to f64
    llvm.return %3 : f64
  }]

def PR31751_umin3_before := [llvmfunc|
  llvm.func @PR31751_umin3(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.icmp "ugt" %arg0, %0 : i32
    %2 = llvm.select %1, %0, %arg0 : i1, i32
    %3 = llvm.sitofp %2 : i32 to f64
    llvm.return %3 : f64
  }]

def PR31751_umax1_before := [llvmfunc|
  llvm.func @PR31751_umax1(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.select %2, %1, %arg0 : i1, i32
    %4 = llvm.sitofp %3 : i32 to f64
    llvm.return %4 : f64
  }]

def PR31751_umax2_before := [llvmfunc|
  llvm.func @PR31751_umax2(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.icmp "ugt" %arg0, %0 : i32
    %2 = llvm.select %1, %arg0, %0 : i1, i32
    %3 = llvm.sitofp %2 : i32 to f64
    llvm.return %3 : f64
  }]

def PR31751_umax3_before := [llvmfunc|
  llvm.func @PR31751_umax3(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.icmp "ult" %arg0, %0 : i32
    %2 = llvm.select %1, %0, %arg0 : i1, i32
    %3 = llvm.sitofp %2 : i32 to f64
    llvm.return %3 : f64
  }]

def bitcast_scalar_smax_before := [llvmfunc|
  llvm.func @bitcast_scalar_smax(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.bitcast %arg0 : f32 to i32
    %1 = llvm.bitcast %arg1 : f32 to i32
    %2 = llvm.icmp "sgt" %0, %1 : i32
    %3 = llvm.select %2, %0, %1 : i1, i32
    %4 = llvm.bitcast %3 : i32 to f32
    llvm.return %4 : f32
  }]

def bitcast_scalar_umax_before := [llvmfunc|
  llvm.func @bitcast_scalar_umax(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.bitcast %arg0 : f32 to i32
    %1 = llvm.bitcast %arg1 : f32 to i32
    %2 = llvm.icmp "ugt" %0, %1 : i32
    %3 = llvm.select %2, %arg0, %arg1 : i1, f32
    llvm.return %3 : f32
  }]

def bitcast_vector_smin_before := [llvmfunc|
  llvm.func @bitcast_vector_smin(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xf32> {
    %0 = llvm.bitcast %arg0 : vector<8xf32> to vector<8xi32>
    %1 = llvm.bitcast %arg1 : vector<8xf32> to vector<8xi32>
    %2 = llvm.icmp "slt" %0, %1 : vector<8xi32>
    %3 = llvm.select %2, %0, %1 : vector<8xi1>, vector<8xi32>
    %4 = llvm.bitcast %3 : vector<8xi32> to vector<8xf32>
    llvm.return %4 : vector<8xf32>
  }]

def bitcast_vector_umin_before := [llvmfunc|
  llvm.func @bitcast_vector_umin(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xf32> {
    %0 = llvm.bitcast %arg0 : vector<8xf32> to vector<8xi32>
    %1 = llvm.bitcast %arg1 : vector<8xf32> to vector<8xi32>
    %2 = llvm.icmp "slt" %0, %1 : vector<8xi32>
    %3 = llvm.select %2, %arg0, %arg1 : vector<8xi1>, vector<8xf32>
    llvm.return %3 : vector<8xf32>
  }]

def look_through_cast1(%arg0: i32) -> _before := [llvmfunc|
  llvm.func @look_through_cast1(%arg0: i32) -> (i8 {llvm.zeroext}) {
    %0 = llvm.mlir.constant(511 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.trunc %arg0 : i32 to i8
    %4 = llvm.select %2, %3, %1 : i1, i8
    llvm.return %4 : i8
  }]

def look_through_cast2(%arg0: i32) -> _before := [llvmfunc|
  llvm.func @look_through_cast2(%arg0: i32) -> (i8 {llvm.zeroext}) {
    %0 = llvm.mlir.constant(510 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.trunc %arg0 : i32 to i8
    %4 = llvm.select %2, %3, %1 : i1, i8
    llvm.return %4 : i8
  }]

def min_through_cast_vec1_before := [llvmfunc|
  llvm.func @min_through_cast_vec1(%arg0: vector<2xi32>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[510, 511]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[-2, -1]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.icmp "slt" %arg0, %0 : vector<2xi32>
    %3 = llvm.trunc %arg0 : vector<2xi32> to vector<2xi8>
    %4 = llvm.select %2, %3, %1 : vector<2xi1>, vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

def min_through_cast_vec2_before := [llvmfunc|
  llvm.func @min_through_cast_vec2(%arg0: vector<2xi32>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<511> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.icmp "slt" %arg0, %0 : vector<2xi32>
    %3 = llvm.trunc %arg0 : vector<2xi32> to vector<2xi8>
    %4 = llvm.select %2, %3, %1 : vector<2xi1>, vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

def common_factor_smin_before := [llvmfunc|
  llvm.func @common_factor_smin(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg0, %arg1 : i1, i32
    %2 = llvm.icmp "slt" %arg1, %arg2 : i32
    %3 = llvm.select %2, %arg1, %arg2 : i1, i32
    %4 = llvm.icmp "slt" %1, %3 : i32
    %5 = llvm.select %4, %1, %3 : i1, i32
    llvm.return %5 : i32
  }]

def common_factor_smax_before := [llvmfunc|
  llvm.func @common_factor_smax(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : vector<2xi32>
    %1 = llvm.select %0, %arg0, %arg1 : vector<2xi1>, vector<2xi32>
    %2 = llvm.icmp "sgt" %arg2, %arg1 : vector<2xi32>
    %3 = llvm.select %2, %arg2, %arg1 : vector<2xi1>, vector<2xi32>
    %4 = llvm.icmp "sgt" %1, %3 : vector<2xi32>
    %5 = llvm.select %4, %1, %3 : vector<2xi1>, vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

def common_factor_umin_before := [llvmfunc|
  llvm.func @common_factor_umin(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.icmp "ult" %arg1, %arg2 : vector<2xi32>
    %1 = llvm.select %0, %arg1, %arg2 : vector<2xi1>, vector<2xi32>
    %2 = llvm.icmp "ult" %arg0, %arg1 : vector<2xi32>
    %3 = llvm.select %2, %arg0, %arg1 : vector<2xi1>, vector<2xi32>
    %4 = llvm.icmp "ult" %1, %3 : vector<2xi32>
    %5 = llvm.select %4, %1, %3 : vector<2xi1>, vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

def common_factor_umax_before := [llvmfunc|
  llvm.func @common_factor_umax(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.icmp "ugt" %arg1, %arg2 : i32
    %1 = llvm.select %0, %arg1, %arg2 : i1, i32
    %2 = llvm.icmp "ugt" %arg1, %arg0 : i32
    %3 = llvm.select %2, %arg1, %arg0 : i1, i32
    %4 = llvm.icmp "ugt" %1, %3 : i32
    %5 = llvm.select %4, %1, %3 : i1, i32
    llvm.return %5 : i32
  }]

def common_factor_umax_extra_use_lhs_before := [llvmfunc|
  llvm.func @common_factor_umax_extra_use_lhs(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.icmp "ugt" %arg1, %arg2 : i32
    %1 = llvm.select %0, %arg1, %arg2 : i1, i32
    %2 = llvm.icmp "ugt" %arg1, %arg0 : i32
    %3 = llvm.select %2, %arg1, %arg0 : i1, i32
    %4 = llvm.icmp "ugt" %1, %3 : i32
    %5 = llvm.select %4, %1, %3 : i1, i32
    llvm.call @extra_use(%1) : (i32) -> ()
    llvm.return %5 : i32
  }]

def common_factor_umax_extra_use_rhs_before := [llvmfunc|
  llvm.func @common_factor_umax_extra_use_rhs(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.icmp "ugt" %arg1, %arg2 : i32
    %1 = llvm.select %0, %arg1, %arg2 : i1, i32
    %2 = llvm.icmp "ugt" %arg1, %arg0 : i32
    %3 = llvm.select %2, %arg1, %arg0 : i1, i32
    %4 = llvm.icmp "ugt" %1, %3 : i32
    %5 = llvm.select %4, %1, %3 : i1, i32
    llvm.call @extra_use(%3) : (i32) -> ()
    llvm.return %5 : i32
  }]

def common_factor_umax_extra_use_both_before := [llvmfunc|
  llvm.func @common_factor_umax_extra_use_both(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.icmp "ugt" %arg1, %arg2 : i32
    %1 = llvm.select %0, %arg1, %arg2 : i1, i32
    %2 = llvm.icmp "ugt" %arg1, %arg0 : i32
    %3 = llvm.select %2, %arg1, %arg0 : i1, i32
    %4 = llvm.icmp "ugt" %1, %3 : i32
    %5 = llvm.select %4, %1, %3 : i1, i32
    llvm.call @extra_use(%1) : (i32) -> ()
    llvm.call @extra_use(%3) : (i32) -> ()
    llvm.return %5 : i32
  }]

def not_min_of_min_before := [llvmfunc|
  llvm.func @not_min_of_min(%arg0: i8, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(16 : i8) : i8
    %3 = llvm.fcmp "ult" %arg1, %0 {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %4 = llvm.select %3, %arg1, %0 : i1, f32
    %5 = llvm.fcmp "ult" %arg1, %1 {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %6 = llvm.select %5, %arg1, %1 : i1, f32
    %7 = llvm.icmp "ult" %arg0, %2 : i8
    %8 = llvm.select %7, %4, %6 : i1, f32
    llvm.return %8 : f32
  }]

def add_umin_before := [llvmfunc|
  llvm.func @add_umin(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }]

def add_umin_constant_limit_before := [llvmfunc|
  llvm.func @add_umin_constant_limit(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(41 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }]

def add_umin_simplify_before := [llvmfunc|
  llvm.func @add_umin_simplify(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.add %arg0, %0 overflow<nuw>  : i32
    %2 = llvm.icmp "ult" %1, %0 : i32
    %3 = llvm.select %2, %1, %0 : i1, i32
    llvm.return %3 : i32
  }]

def add_umin_simplify2_before := [llvmfunc|
  llvm.func @add_umin_simplify2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(43 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }]

def add_umin_wrong_pred_before := [llvmfunc|
  llvm.func @add_umin_wrong_pred(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.icmp "slt" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }]

def add_umin_wrong_wrap_before := [llvmfunc|
  llvm.func @add_umin_wrong_wrap(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }]

def add_umin_extra_use_before := [llvmfunc|
  llvm.func @add_umin_extra_use(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i32
    llvm.store %2, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

    %3 = llvm.icmp "ult" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }]

def add_umin_vec_before := [llvmfunc|
  llvm.func @add_umin_vec(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<15> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(dense<240> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.add %arg0, %0 overflow<nuw>  : vector<2xi16>
    %3 = llvm.icmp "ult" %2, %1 : vector<2xi16>
    %4 = llvm.select %3, %2, %1 : vector<2xi1>, vector<2xi16>
    llvm.return %4 : vector<2xi16>
  }]

def add_umax_before := [llvmfunc|
  llvm.func @add_umax(%arg0: i37) -> i37 {
    %0 = llvm.mlir.constant(5 : i37) : i37
    %1 = llvm.mlir.constant(42 : i37) : i37
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i37
    %3 = llvm.icmp "ugt" %2, %1 : i37
    %4 = llvm.select %3, %2, %1 : i1, i37
    llvm.return %4 : i37
  }]

def add_umax_constant_limit_before := [llvmfunc|
  llvm.func @add_umax_constant_limit(%arg0: i37) -> i37 {
    %0 = llvm.mlir.constant(81 : i37) : i37
    %1 = llvm.mlir.constant(82 : i37) : i37
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i37
    %3 = llvm.icmp "ugt" %2, %1 : i37
    %4 = llvm.select %3, %2, %1 : i1, i37
    llvm.return %4 : i37
  }]

def add_umax_simplify_before := [llvmfunc|
  llvm.func @add_umax_simplify(%arg0: i37) -> i37 {
    %0 = llvm.mlir.constant(42 : i37) : i37
    %1 = llvm.add %arg0, %0 overflow<nuw>  : i37
    %2 = llvm.icmp "ugt" %1, %0 : i37
    %3 = llvm.select %2, %1, %0 : i1, i37
    llvm.return %3 : i37
  }]

def add_umax_simplify2_before := [llvmfunc|
  llvm.func @add_umax_simplify2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(57 : i32) : i32
    %1 = llvm.mlir.constant(56 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.icmp "ugt" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }]

def add_umax_wrong_pred_before := [llvmfunc|
  llvm.func @add_umax_wrong_pred(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.icmp "sgt" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }]

def add_umax_wrong_wrap_before := [llvmfunc|
  llvm.func @add_umax_wrong_wrap(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.icmp "ugt" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }]

def add_umax_extra_use_before := [llvmfunc|
  llvm.func @add_umax_extra_use(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i32
    llvm.store %2, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

    %3 = llvm.icmp "ugt" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }]

def add_umax_vec_before := [llvmfunc|
  llvm.func @add_umax_vec(%arg0: vector<2xi33>) -> vector<2xi33> {
    %0 = llvm.mlir.constant(5 : i33) : i33
    %1 = llvm.mlir.constant(dense<5> : vector<2xi33>) : vector<2xi33>
    %2 = llvm.mlir.constant(240 : i33) : i33
    %3 = llvm.mlir.constant(dense<240> : vector<2xi33>) : vector<2xi33>
    %4 = llvm.add %arg0, %1 overflow<nuw>  : vector<2xi33>
    %5 = llvm.icmp "ugt" %4, %3 : vector<2xi33>
    %6 = llvm.select %5, %4, %3 : vector<2xi1>, vector<2xi33>
    llvm.return %6 : vector<2xi33>
  }]

def PR14613_umin_before := [llvmfunc|
  llvm.func @PR14613_umin(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(255 : i32) : i32
    %2 = llvm.zext %arg0 : i8 to i32
    %3 = llvm.add %2, %0 overflow<nsw, nuw>  : i32
    %4 = llvm.icmp "ult" %3, %1 : i32
    %5 = llvm.select %4, %3, %1 : i1, i32
    %6 = llvm.trunc %5 : i32 to i8
    llvm.return %6 : i8
  }]

def PR14613_umax_before := [llvmfunc|
  llvm.func @PR14613_umax(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(255 : i32) : i32
    %2 = llvm.zext %arg0 : i8 to i32
    %3 = llvm.add %2, %0 overflow<nsw, nuw>  : i32
    %4 = llvm.icmp "ugt" %3, %1 : i32
    %5 = llvm.select %4, %3, %1 : i1, i32
    %6 = llvm.trunc %5 : i32 to i8
    llvm.return %6 : i8
  }]

def add_smin_before := [llvmfunc|
  llvm.func @add_smin(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.icmp "slt" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }]

def add_smin_constant_limit_before := [llvmfunc|
  llvm.func @add_smin_constant_limit(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-3 : i32) : i32
    %1 = llvm.mlir.constant(2147483643 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.icmp "slt" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }]

def add_smin_simplify_before := [llvmfunc|
  llvm.func @add_smin_simplify(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-3 : i32) : i32
    %1 = llvm.mlir.constant(2147483644 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.icmp "slt" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }]

def add_smin_simplify2_before := [llvmfunc|
  llvm.func @add_smin_simplify2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-3 : i32) : i32
    %1 = llvm.mlir.constant(2147483645 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.icmp "slt" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }]

def add_smin_wrong_pred_before := [llvmfunc|
  llvm.func @add_smin_wrong_pred(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }]

def add_smin_wrong_wrap_before := [llvmfunc|
  llvm.func @add_smin_wrong_wrap(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.icmp "slt" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }]

def add_smin_extra_use_before := [llvmfunc|
  llvm.func @add_smin_extra_use(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i32
    llvm.store %2, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

    %3 = llvm.icmp "slt" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }]

def add_smin_vec_before := [llvmfunc|
  llvm.func @add_smin_vec(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<15> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(dense<240> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.add %arg0, %0 overflow<nsw>  : vector<2xi16>
    %3 = llvm.icmp "slt" %2, %1 : vector<2xi16>
    %4 = llvm.select %3, %2, %1 : vector<2xi1>, vector<2xi16>
    llvm.return %4 : vector<2xi16>
  }]

def add_smax_before := [llvmfunc|
  llvm.func @add_smax(%arg0: i37) -> i37 {
    %0 = llvm.mlir.constant(5 : i37) : i37
    %1 = llvm.mlir.constant(42 : i37) : i37
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i37
    %3 = llvm.icmp "sgt" %2, %1 : i37
    %4 = llvm.select %3, %2, %1 : i1, i37
    llvm.return %4 : i37
  }]

def add_smax_constant_limit_before := [llvmfunc|
  llvm.func @add_smax_constant_limit(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(125 : i8) : i8
    %1 = llvm.mlir.constant(-2 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    %4 = llvm.select %3, %2, %1 : i1, i8
    llvm.return %4 : i8
  }]

def add_smax_simplify_before := [llvmfunc|
  llvm.func @add_smax_simplify(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(126 : i8) : i8
    %1 = llvm.mlir.constant(-2 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    %4 = llvm.select %3, %2, %1 : i1, i8
    llvm.return %4 : i8
  }]

def add_smax_simplify2_before := [llvmfunc|
  llvm.func @add_smax_simplify2(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(-2 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    %4 = llvm.select %3, %2, %1 : i1, i8
    llvm.return %4 : i8
  }]

def add_smax_wrong_pred_before := [llvmfunc|
  llvm.func @add_smax_wrong_pred(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.icmp "ugt" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }]

def add_smax_wrong_wrap_before := [llvmfunc|
  llvm.func @add_smax_wrong_wrap(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.icmp "sgt" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }]

def add_smax_extra_use_before := [llvmfunc|
  llvm.func @add_smax_extra_use(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i32
    llvm.store %2, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

    %3 = llvm.icmp "sgt" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }]

def add_smax_vec_before := [llvmfunc|
  llvm.func @add_smax_vec(%arg0: vector<2xi33>) -> vector<2xi33> {
    %0 = llvm.mlir.constant(5 : i33) : i33
    %1 = llvm.mlir.constant(dense<5> : vector<2xi33>) : vector<2xi33>
    %2 = llvm.mlir.constant(240 : i33) : i33
    %3 = llvm.mlir.constant(dense<240> : vector<2xi33>) : vector<2xi33>
    %4 = llvm.add %arg0, %1 overflow<nsw>  : vector<2xi33>
    %5 = llvm.icmp "sgt" %4, %3 : vector<2xi33>
    %6 = llvm.select %5, %4, %3 : vector<2xi1>, vector<2xi33>
    llvm.return %6 : vector<2xi33>
  }]

def PR14613_smin_before := [llvmfunc|
  llvm.func @PR14613_smin(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(55 : i32) : i32
    %2 = llvm.sext %arg0 : i8 to i32
    %3 = llvm.add %2, %0 overflow<nsw, nuw>  : i32
    %4 = llvm.icmp "slt" %3, %1 : i32
    %5 = llvm.select %4, %3, %1 : i1, i32
    %6 = llvm.trunc %5 : i32 to i8
    llvm.return %6 : i8
  }]

def PR14613_smax_before := [llvmfunc|
  llvm.func @PR14613_smax(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(55 : i32) : i32
    %2 = llvm.sext %arg0 : i8 to i32
    %3 = llvm.add %2, %0 overflow<nsw, nuw>  : i32
    %4 = llvm.icmp "sgt" %3, %1 : i32
    %5 = llvm.select %4, %3, %1 : i1, i32
    %6 = llvm.trunc %5 : i32 to i8
    llvm.return %6 : i8
  }]

def PR46271_before := [llvmfunc|
  llvm.func @PR46271(%arg0: vector<2xi8>) -> i8 {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.poison : i8
    %3 = llvm.mlir.undef : vector<2xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi8>
    %8 = llvm.mlir.constant(1 : i32) : i32
    %9 = llvm.icmp "sgt" %arg0, %0 : vector<2xi8>
    %10 = llvm.select %9, %arg0, %7 : vector<2xi1>, vector<2xi8>
    %11 = llvm.xor %10, %7  : vector<2xi8>
    %12 = llvm.extractelement %11[%8 : i32] : vector<2xi8>
    llvm.return %12 : i8
  }]

def twoway_clamp_lt_before := [llvmfunc|
  llvm.func @twoway_clamp_lt(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(13768 : i32) : i32
    %1 = llvm.mlir.constant(13767 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg0, %0 : i1, i32
    %4 = llvm.icmp "sgt" %3, %1 : i32
    %5 = llvm.select %4, %3, %1 : i1, i32
    llvm.return %5 : i32
  }]

def twoway_clamp_gt_before := [llvmfunc|
  llvm.func @twoway_clamp_gt(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(13767 : i32) : i32
    %1 = llvm.mlir.constant(13768 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg0, %0 : i1, i32
    %4 = llvm.icmp "slt" %3, %1 : i32
    %5 = llvm.select %4, %3, %1 : i1, i32
    llvm.return %5 : i32
  }]

def twoway_clamp_gt_nonconst_before := [llvmfunc|
  llvm.func @twoway_clamp_gt_nonconst(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.add %arg1, %0  : i32
    %2 = llvm.icmp "sgt" %arg0, %arg1 : i32
    %3 = llvm.select %2, %arg0, %arg1 : i1, i32
    %4 = llvm.icmp "slt" %3, %1 : i32
    %5 = llvm.select %4, %3, %1 : i1, i32
    llvm.return %5 : i32
  }]

def test_umax_smax1_before := [llvmfunc|
  llvm.func @test_umax_smax1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.intr.umax(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

def test_umax_smax2_before := [llvmfunc|
  llvm.func @test_umax_smax2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(20 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.intr.umax(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

def test_umax_smax_vec_before := [llvmfunc|
  llvm.func @test_umax_smax_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[0, 20]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[1, 10]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.intr.smax(%arg0, %0)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %3 = llvm.intr.umax(%2, %1)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def test_smin_umin1_before := [llvmfunc|
  llvm.func @test_smin_umin1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(20 : i32) : i32
    %2 = llvm.intr.umin(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.intr.smin(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

def test_smin_umin2_before := [llvmfunc|
  llvm.func @test_smin_umin2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(20 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.intr.umin(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.intr.smin(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

def test_smin_umin_vec_before := [llvmfunc|
  llvm.func @test_smin_umin_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[10, 20]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[20, 10]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.intr.umin(%arg0, %0)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %3 = llvm.intr.smin(%2, %1)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def test_umax_smax3_before := [llvmfunc|
  llvm.func @test_umax_smax3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.intr.umax(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

def test_umax_smax4_before := [llvmfunc|
  llvm.func @test_umax_smax4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-20 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.intr.umax(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

def test_smin_umin3_before := [llvmfunc|
  llvm.func @test_smin_umin3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(-20 : i32) : i32
    %2 = llvm.intr.umin(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.intr.smin(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

def test_smin_umin4_before := [llvmfunc|
  llvm.func @test_smin_umin4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-20 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.intr.umin(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.intr.smin(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

def test_umax_nonminmax_before := [llvmfunc|
  llvm.func @test_umax_nonminmax(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %2 = llvm.intr.umax(%1, %0)  : (i32, i32) -> i32
    llvm.return %2 : i32
  }]

def test_umax_smax_vec_neg_before := [llvmfunc|
  llvm.func @test_umax_smax_vec_neg(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[0, -20]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[1, 10]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.intr.smax(%arg0, %0)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %3 = llvm.intr.umax(%2, %1)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def t1_combined := [llvmfunc|
  llvm.func @t1(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.intr.smin(%arg0, %0)  : (i32, i32) -> i32
    %2 = llvm.sext %1 : i32 to i64
    llvm.return %2 : i64
  }]

theorem inst_combine_t1   : t1_before  ⊑  t1_combined := by
  unfold t1_before t1_combined
  simp_alive_peephole
  sorry
def t2_combined := [llvmfunc|
  llvm.func @t2(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.intr.smin(%arg0, %0)  : (i32, i32) -> i32
    %2 = llvm.sext %1 : i32 to i64
    llvm.return %2 : i64
  }]

theorem inst_combine_t2   : t2_before  ⊑  t2_combined := by
  unfold t2_before t2_combined
  simp_alive_peephole
  sorry
def t3_combined := [llvmfunc|
  llvm.func @t3(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.intr.umax(%arg0, %0)  : (i32, i32) -> i32
    %2 = llvm.zext %1 : i32 to i64
    llvm.return %2 : i64
  }]

theorem inst_combine_t3   : t3_before  ⊑  t3_combined := by
  unfold t3_before t3_combined
  simp_alive_peephole
  sorry
def t4_combined := [llvmfunc|
  llvm.func @t4(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(5 : i64) : i64
    %1 = llvm.intr.smin(%arg0, %0)  : (i64, i64) -> i64
    %2 = llvm.trunc %1 : i64 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_t4   : t4_before  ⊑  t4_combined := by
  unfold t4_before t4_combined
  simp_alive_peephole
  sorry
def t5_combined := [llvmfunc|
  llvm.func @t5(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    %2 = llvm.zext %1 : i32 to i64
    llvm.return %2 : i64
  }]

theorem inst_combine_t5   : t5_before  ⊑  t5_combined := by
  unfold t5_before t5_combined
  simp_alive_peephole
  sorry
def t6_combined := [llvmfunc|
  llvm.func @t6(%arg0: i32) -> f32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.intr.smin(%arg0, %0)  : (i32, i32) -> i32
    %2 = llvm.sitofp %1 : i32 to f32
    llvm.return %2 : f32
  }]

theorem inst_combine_t6   : t6_before  ⊑  t6_combined := by
  unfold t6_before t6_combined
  simp_alive_peephole
  sorry
def t7_combined := [llvmfunc|
  llvm.func @t7(%arg0: i32) -> i16 {
    %0 = llvm.mlir.constant(-32768 : i32) : i32
    %1 = llvm.intr.smin(%arg0, %0)  : (i32, i32) -> i32
    %2 = llvm.trunc %1 : i32 to i16
    llvm.return %2 : i16
  }]

theorem inst_combine_t7   : t7_before  ⊑  t7_combined := by
  unfold t7_before t7_combined
  simp_alive_peephole
  sorry
def t8_combined := [llvmfunc|
  llvm.func @t8(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-32767 : i64) : i64
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.intr.smin(%arg0, %0)  : (i64, i64) -> i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.icmp "slt" %arg1, %1 : i32
    %6 = llvm.icmp "ne" %4, %arg1 : i32
    %7 = llvm.select %5, %2, %6 : i1, i1
    %8 = llvm.zext %7 : i1 to i32
    llvm.return %8 : i32
  }]

theorem inst_combine_t8   : t8_before  ⊑  t8_combined := by
  unfold t8_before t8_combined
  simp_alive_peephole
  sorry
def t9_combined := [llvmfunc|
  llvm.func @t9(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(4294967295 : i64) : i64
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.sext %arg0 : i32 to i64
    %4 = llvm.select %2, %3, %1 : i1, i64
    llvm.return %4 : i64
  }]

theorem inst_combine_t9   : t9_before  ⊑  t9_combined := by
  unfold t9_before t9_combined
  simp_alive_peephole
  sorry
def t10_combined := [llvmfunc|
  llvm.func @t10(%arg0: i32) -> f32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    %2 = llvm.sitofp %1 : i32 to f32
    llvm.return %2 : f32
  }]

theorem inst_combine_t10   : t10_before  ⊑  t10_combined := by
  unfold t10_before t10_combined
  simp_alive_peephole
  sorry
def t11_combined := [llvmfunc|
  llvm.func @t11(%arg0: i64) -> f32 {
    %0 = llvm.mlir.constant(255 : i64) : i64
    %1 = llvm.intr.smax(%arg0, %0)  : (i64, i64) -> i64
    %2 = llvm.sitofp %1 : i64 to f32
    llvm.return %2 : f32
  }]

theorem inst_combine_t11   : t11_before  ⊑  t11_combined := by
  unfold t11_before t11_combined
  simp_alive_peephole
  sorry
def bitcasts_fcmp_1_combined := [llvmfunc|
  llvm.func @bitcasts_fcmp_1(%arg0: vector<2xi64>, %arg1: vector<2xi64>) -> vector<4xi32> {
    %0 = llvm.bitcast %arg0 : vector<2xi64> to vector<4xf32>
    %1 = llvm.bitcast %arg1 : vector<2xi64> to vector<4xf32>
    %2 = llvm.fcmp "olt" %1, %0 : vector<4xf32>
    %3 = llvm.select %2, %0, %1 : vector<4xi1>, vector<4xf32>
    %4 = llvm.bitcast %3 : vector<4xf32> to vector<4xi32>
    llvm.return %4 : vector<4xi32>
  }]

theorem inst_combine_bitcasts_fcmp_1   : bitcasts_fcmp_1_before  ⊑  bitcasts_fcmp_1_combined := by
  unfold bitcasts_fcmp_1_before bitcasts_fcmp_1_combined
  simp_alive_peephole
  sorry
def bitcasts_fcmp_2_combined := [llvmfunc|
  llvm.func @bitcasts_fcmp_2(%arg0: vector<2xi64>, %arg1: vector<2xi64>) -> vector<4xi32> {
    %0 = llvm.bitcast %arg0 : vector<2xi64> to vector<4xf32>
    %1 = llvm.bitcast %arg1 : vector<2xi64> to vector<4xf32>
    %2 = llvm.fcmp "olt" %0, %1 : vector<4xf32>
    %3 = llvm.select %2, %0, %1 : vector<4xi1>, vector<4xf32>
    %4 = llvm.bitcast %3 : vector<4xf32> to vector<4xi32>
    llvm.return %4 : vector<4xi32>
  }]

theorem inst_combine_bitcasts_fcmp_2   : bitcasts_fcmp_2_before  ⊑  bitcasts_fcmp_2_combined := by
  unfold bitcasts_fcmp_2_before bitcasts_fcmp_2_combined
  simp_alive_peephole
  sorry
def bitcasts_icmp_combined := [llvmfunc|
  llvm.func @bitcasts_icmp(%arg0: vector<2xi64>, %arg1: vector<2xi64>) -> vector<4xf32> {
    %0 = llvm.bitcast %arg0 : vector<2xi64> to vector<4xi32>
    %1 = llvm.bitcast %arg1 : vector<2xi64> to vector<4xi32>
    %2 = llvm.intr.smax(%1, %0)  : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %3 = llvm.bitcast %2 : vector<4xi32> to vector<4xf32>
    llvm.return %3 : vector<4xf32>
  }]

theorem inst_combine_bitcasts_icmp   : bitcasts_icmp_before  ⊑  bitcasts_icmp_combined := by
  unfold bitcasts_icmp_before bitcasts_icmp_combined
  simp_alive_peephole
  sorry
def test68_combined := [llvmfunc|
  llvm.func @test68(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(11 : i32) : i32
    %1 = llvm.intr.smin(%arg0, %0)  : (i32, i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test68   : test68_before  ⊑  test68_combined := by
  unfold test68_before test68_combined
  simp_alive_peephole
  sorry
def test68vec_combined := [llvmfunc|
  llvm.func @test68vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<11> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.smin(%arg0, %0)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_test68vec   : test68vec_before  ⊑  test68vec_combined := by
  unfold test68vec_before test68vec_combined
  simp_alive_peephole
  sorry
def test69_combined := [llvmfunc|
  llvm.func @test69(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.intr.umin(%arg0, %0)  : (i32, i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test69   : test69_before  ⊑  test69_combined := by
  unfold test69_before test69_combined
  simp_alive_peephole
  sorry
def test70_combined := [llvmfunc|
  llvm.func @test70(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(75 : i32) : i32
    %1 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test70   : test70_before  ⊑  test70_combined := by
  unfold test70_before test70_combined
  simp_alive_peephole
  sorry
def test71_combined := [llvmfunc|
  llvm.func @test71(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(68 : i32) : i32
    %1 = llvm.intr.umax(%arg0, %0)  : (i32, i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test71   : test71_before  ⊑  test71_combined := by
  unfold test71_before test71_combined
  simp_alive_peephole
  sorry
def test72_combined := [llvmfunc|
  llvm.func @test72(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(11 : i32) : i32
    %1 = llvm.intr.smin(%arg0, %0)  : (i32, i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test72   : test72_before  ⊑  test72_combined := by
  unfold test72_before test72_combined
  simp_alive_peephole
  sorry
def test72vec_combined := [llvmfunc|
  llvm.func @test72vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<11> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.smin(%arg0, %0)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_test72vec   : test72vec_before  ⊑  test72vec_combined := by
  unfold test72vec_before test72vec_combined
  simp_alive_peephole
  sorry
def test73_combined := [llvmfunc|
  llvm.func @test73(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.intr.umin(%arg0, %0)  : (i32, i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test73   : test73_before  ⊑  test73_combined := by
  unfold test73_before test73_combined
  simp_alive_peephole
  sorry
def test74_combined := [llvmfunc|
  llvm.func @test74(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(36 : i32) : i32
    %1 = llvm.mlir.constant(75 : i32) : i32
    %2 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.intr.umax(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test74   : test74_before  ⊑  test74_combined := by
  unfold test74_before test74_combined
  simp_alive_peephole
  sorry
def test75_combined := [llvmfunc|
  llvm.func @test75(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(68 : i32) : i32
    %1 = llvm.intr.umax(%arg0, %0)  : (i32, i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test75   : test75_before  ⊑  test75_combined := by
  unfold test75_before test75_combined
  simp_alive_peephole
  sorry
def clamp_signed1_combined := [llvmfunc|
  llvm.func @clamp_signed1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.intr.smin(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.intr.smax(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_clamp_signed1   : clamp_signed1_before  ⊑  clamp_signed1_combined := by
  unfold clamp_signed1_before clamp_signed1_combined
  simp_alive_peephole
  sorry
def clamp_signed2_combined := [llvmfunc|
  llvm.func @clamp_signed2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(255 : i32) : i32
    %2 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.intr.smin(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_clamp_signed2   : clamp_signed2_before  ⊑  clamp_signed2_combined := by
  unfold clamp_signed2_before clamp_signed2_combined
  simp_alive_peephole
  sorry
def clamp_signed3_combined := [llvmfunc|
  llvm.func @clamp_signed3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.intr.smin(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.intr.smax(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_clamp_signed3   : clamp_signed3_before  ⊑  clamp_signed3_combined := by
  unfold clamp_signed3_before clamp_signed3_combined
  simp_alive_peephole
  sorry
def clamp_signed4_combined := [llvmfunc|
  llvm.func @clamp_signed4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(255 : i32) : i32
    %2 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.intr.smin(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_clamp_signed4   : clamp_signed4_before  ⊑  clamp_signed4_combined := by
  unfold clamp_signed4_before clamp_signed4_combined
  simp_alive_peephole
  sorry
def clamp_unsigned1_combined := [llvmfunc|
  llvm.func @clamp_unsigned1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.intr.umin(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.intr.umax(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_clamp_unsigned1   : clamp_unsigned1_before  ⊑  clamp_unsigned1_combined := by
  unfold clamp_unsigned1_before clamp_unsigned1_combined
  simp_alive_peephole
  sorry
def clamp_unsigned2_combined := [llvmfunc|
  llvm.func @clamp_unsigned2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(255 : i32) : i32
    %2 = llvm.intr.umax(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.intr.umin(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_clamp_unsigned2   : clamp_unsigned2_before  ⊑  clamp_unsigned2_combined := by
  unfold clamp_unsigned2_before clamp_unsigned2_combined
  simp_alive_peephole
  sorry
def clamp_unsigned3_combined := [llvmfunc|
  llvm.func @clamp_unsigned3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.intr.umin(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.intr.umax(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_clamp_unsigned3   : clamp_unsigned3_before  ⊑  clamp_unsigned3_combined := by
  unfold clamp_unsigned3_before clamp_unsigned3_combined
  simp_alive_peephole
  sorry
def clamp_unsigned4_combined := [llvmfunc|
  llvm.func @clamp_unsigned4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(255 : i32) : i32
    %2 = llvm.intr.umax(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.intr.umin(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_clamp_unsigned4   : clamp_unsigned4_before  ⊑  clamp_unsigned4_combined := by
  unfold clamp_unsigned4_before clamp_unsigned4_combined
  simp_alive_peephole
  sorry
def clamp_check_for_no_infinite_loop1_combined := [llvmfunc|
  llvm.func @clamp_check_for_no_infinite_loop1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.smin(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.intr.smax(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_clamp_check_for_no_infinite_loop1   : clamp_check_for_no_infinite_loop1_before  ⊑  clamp_check_for_no_infinite_loop1_combined := by
  unfold clamp_check_for_no_infinite_loop1_before clamp_check_for_no_infinite_loop1_combined
  simp_alive_peephole
  sorry
def clamp_check_for_no_infinite_loop2_combined := [llvmfunc|
  llvm.func @clamp_check_for_no_infinite_loop2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-255 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.intr.smin(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_clamp_check_for_no_infinite_loop2   : clamp_check_for_no_infinite_loop2_before  ⊑  clamp_check_for_no_infinite_loop2_combined := by
  unfold clamp_check_for_no_infinite_loop2_before clamp_check_for_no_infinite_loop2_combined
  simp_alive_peephole
  sorry
def clamp_check_for_no_infinite_loop3_combined := [llvmfunc|
  llvm.func @clamp_check_for_no_infinite_loop3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %4 = llvm.intr.smax(%arg0, %2)  : (i32, i32) -> i32
    %5 = llvm.intr.umin(%4, %3)  : (i32, i32) -> i32
    %6 = llvm.shl %5, %3 overflow<nsw, nuw>  : i32
    llvm.return %6 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i32
  }]

theorem inst_combine_clamp_check_for_no_infinite_loop3   : clamp_check_for_no_infinite_loop3_before  ⊑  clamp_check_for_no_infinite_loop3_combined := by
  unfold clamp_check_for_no_infinite_loop3_before clamp_check_for_no_infinite_loop3_combined
  simp_alive_peephole
  sorry
def PR31751_umin1_combined := [llvmfunc|
  llvm.func @PR31751_umin1(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.intr.umin(%arg0, %0)  : (i32, i32) -> i32
    %2 = llvm.sitofp %1 : i32 to f64
    llvm.return %2 : f64
  }]

theorem inst_combine_PR31751_umin1   : PR31751_umin1_before  ⊑  PR31751_umin1_combined := by
  unfold PR31751_umin1_before PR31751_umin1_combined
  simp_alive_peephole
  sorry
def PR31751_umin2_combined := [llvmfunc|
  llvm.func @PR31751_umin2(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.intr.umin(%arg0, %0)  : (i32, i32) -> i32
    %2 = llvm.sitofp %1 : i32 to f64
    llvm.return %2 : f64
  }]

theorem inst_combine_PR31751_umin2   : PR31751_umin2_before  ⊑  PR31751_umin2_combined := by
  unfold PR31751_umin2_before PR31751_umin2_combined
  simp_alive_peephole
  sorry
def PR31751_umin3_combined := [llvmfunc|
  llvm.func @PR31751_umin3(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.intr.umin(%arg0, %0)  : (i32, i32) -> i32
    %2 = llvm.sitofp %1 : i32 to f64
    llvm.return %2 : f64
  }]

theorem inst_combine_PR31751_umin3   : PR31751_umin3_before  ⊑  PR31751_umin3_combined := by
  unfold PR31751_umin3_before PR31751_umin3_combined
  simp_alive_peephole
  sorry
def PR31751_umax1_combined := [llvmfunc|
  llvm.func @PR31751_umax1(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.intr.umax(%arg0, %0)  : (i32, i32) -> i32
    %2 = llvm.sitofp %1 : i32 to f64
    llvm.return %2 : f64
  }]

theorem inst_combine_PR31751_umax1   : PR31751_umax1_before  ⊑  PR31751_umax1_combined := by
  unfold PR31751_umax1_before PR31751_umax1_combined
  simp_alive_peephole
  sorry
def PR31751_umax2_combined := [llvmfunc|
  llvm.func @PR31751_umax2(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.intr.umax(%arg0, %0)  : (i32, i32) -> i32
    %2 = llvm.sitofp %1 : i32 to f64
    llvm.return %2 : f64
  }]

theorem inst_combine_PR31751_umax2   : PR31751_umax2_before  ⊑  PR31751_umax2_combined := by
  unfold PR31751_umax2_before PR31751_umax2_combined
  simp_alive_peephole
  sorry
def PR31751_umax3_combined := [llvmfunc|
  llvm.func @PR31751_umax3(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.intr.umax(%arg0, %0)  : (i32, i32) -> i32
    %2 = llvm.sitofp %1 : i32 to f64
    llvm.return %2 : f64
  }]

theorem inst_combine_PR31751_umax3   : PR31751_umax3_before  ⊑  PR31751_umax3_combined := by
  unfold PR31751_umax3_before PR31751_umax3_combined
  simp_alive_peephole
  sorry
def bitcast_scalar_smax_combined := [llvmfunc|
  llvm.func @bitcast_scalar_smax(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.bitcast %arg0 : f32 to i32
    %1 = llvm.bitcast %arg1 : f32 to i32
    %2 = llvm.intr.smax(%0, %1)  : (i32, i32) -> i32
    %3 = llvm.bitcast %2 : i32 to f32
    llvm.return %3 : f32
  }]

theorem inst_combine_bitcast_scalar_smax   : bitcast_scalar_smax_before  ⊑  bitcast_scalar_smax_combined := by
  unfold bitcast_scalar_smax_before bitcast_scalar_smax_combined
  simp_alive_peephole
  sorry
def bitcast_scalar_umax_combined := [llvmfunc|
  llvm.func @bitcast_scalar_umax(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.bitcast %arg0 : f32 to i32
    %1 = llvm.bitcast %arg1 : f32 to i32
    %2 = llvm.icmp "ugt" %0, %1 : i32
    %3 = llvm.select %2, %arg0, %arg1 : i1, f32
    llvm.return %3 : f32
  }]

theorem inst_combine_bitcast_scalar_umax   : bitcast_scalar_umax_before  ⊑  bitcast_scalar_umax_combined := by
  unfold bitcast_scalar_umax_before bitcast_scalar_umax_combined
  simp_alive_peephole
  sorry
def bitcast_vector_smin_combined := [llvmfunc|
  llvm.func @bitcast_vector_smin(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xf32> {
    %0 = llvm.bitcast %arg0 : vector<8xf32> to vector<8xi32>
    %1 = llvm.bitcast %arg1 : vector<8xf32> to vector<8xi32>
    %2 = llvm.intr.smin(%0, %1)  : (vector<8xi32>, vector<8xi32>) -> vector<8xi32>
    %3 = llvm.bitcast %2 : vector<8xi32> to vector<8xf32>
    llvm.return %3 : vector<8xf32>
  }]

theorem inst_combine_bitcast_vector_smin   : bitcast_vector_smin_before  ⊑  bitcast_vector_smin_combined := by
  unfold bitcast_vector_smin_before bitcast_vector_smin_combined
  simp_alive_peephole
  sorry
def bitcast_vector_umin_combined := [llvmfunc|
  llvm.func @bitcast_vector_umin(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xf32> {
    %0 = llvm.bitcast %arg0 : vector<8xf32> to vector<8xi32>
    %1 = llvm.bitcast %arg1 : vector<8xf32> to vector<8xi32>
    %2 = llvm.icmp "slt" %0, %1 : vector<8xi32>
    %3 = llvm.select %2, %arg0, %arg1 : vector<8xi1>, vector<8xf32>
    llvm.return %3 : vector<8xf32>
  }]

theorem inst_combine_bitcast_vector_umin   : bitcast_vector_umin_before  ⊑  bitcast_vector_umin_combined := by
  unfold bitcast_vector_umin_before bitcast_vector_umin_combined
  simp_alive_peephole
  sorry
def look_through_cast1(%arg0: i32) -> _combined := [llvmfunc|
  llvm.func @look_through_cast1(%arg0: i32) -> (i8 {llvm.zeroext}) {
    %0 = llvm.mlir.constant(511 : i32) : i32
    %1 = llvm.intr.smin(%arg0, %0)  : (i32, i32) -> i32
    %2 = llvm.trunc %1 : i32 to i8
    llvm.return %2 : i8
  }]

theorem inst_combine_look_through_cast1(%arg0: i32) ->    : look_through_cast1(%arg0: i32) -> _before  ⊑  look_through_cast1(%arg0: i32) -> _combined := by
  unfold look_through_cast1(%arg0: i32) -> _before look_through_cast1(%arg0: i32) -> _combined
  simp_alive_peephole
  sorry
def look_through_cast2(%arg0: i32) -> _combined := [llvmfunc|
  llvm.func @look_through_cast2(%arg0: i32) -> (i8 {llvm.zeroext}) {
    %0 = llvm.mlir.constant(510 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.trunc %arg0 : i32 to i8
    %4 = llvm.select %2, %3, %1 : i1, i8
    llvm.return %4 : i8
  }]

theorem inst_combine_look_through_cast2(%arg0: i32) ->    : look_through_cast2(%arg0: i32) -> _before  ⊑  look_through_cast2(%arg0: i32) -> _combined := by
  unfold look_through_cast2(%arg0: i32) -> _before look_through_cast2(%arg0: i32) -> _combined
  simp_alive_peephole
  sorry
def min_through_cast_vec1_combined := [llvmfunc|
  llvm.func @min_through_cast_vec1(%arg0: vector<2xi32>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[510, 511]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.smin(%arg0, %0)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %2 = llvm.trunc %1 : vector<2xi32> to vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

theorem inst_combine_min_through_cast_vec1   : min_through_cast_vec1_before  ⊑  min_through_cast_vec1_combined := by
  unfold min_through_cast_vec1_before min_through_cast_vec1_combined
  simp_alive_peephole
  sorry
def min_through_cast_vec2_combined := [llvmfunc|
  llvm.func @min_through_cast_vec2(%arg0: vector<2xi32>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<511> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.smin(%arg0, %0)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %2 = llvm.trunc %1 : vector<2xi32> to vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

theorem inst_combine_min_through_cast_vec2   : min_through_cast_vec2_before  ⊑  min_through_cast_vec2_combined := by
  unfold min_through_cast_vec2_before min_through_cast_vec2_combined
  simp_alive_peephole
  sorry
def common_factor_smin_combined := [llvmfunc|
  llvm.func @common_factor_smin(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.intr.smin(%arg1, %arg2)  : (i32, i32) -> i32
    %1 = llvm.intr.smin(%0, %arg0)  : (i32, i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_common_factor_smin   : common_factor_smin_before  ⊑  common_factor_smin_combined := by
  unfold common_factor_smin_before common_factor_smin_combined
  simp_alive_peephole
  sorry
def common_factor_smax_combined := [llvmfunc|
  llvm.func @common_factor_smax(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.intr.smax(%arg2, %arg1)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %1 = llvm.intr.smax(%0, %arg0)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_common_factor_smax   : common_factor_smax_before  ⊑  common_factor_smax_combined := by
  unfold common_factor_smax_before common_factor_smax_combined
  simp_alive_peephole
  sorry
def common_factor_umin_combined := [llvmfunc|
  llvm.func @common_factor_umin(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.intr.umin(%arg0, %arg1)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %1 = llvm.intr.umin(%0, %arg2)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_common_factor_umin   : common_factor_umin_before  ⊑  common_factor_umin_combined := by
  unfold common_factor_umin_before common_factor_umin_combined
  simp_alive_peephole
  sorry
def common_factor_umax_combined := [llvmfunc|
  llvm.func @common_factor_umax(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.intr.umax(%arg1, %arg0)  : (i32, i32) -> i32
    %1 = llvm.intr.umax(%0, %arg2)  : (i32, i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_common_factor_umax   : common_factor_umax_before  ⊑  common_factor_umax_combined := by
  unfold common_factor_umax_before common_factor_umax_combined
  simp_alive_peephole
  sorry
def common_factor_umax_extra_use_lhs_combined := [llvmfunc|
  llvm.func @common_factor_umax_extra_use_lhs(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.intr.umax(%arg1, %arg2)  : (i32, i32) -> i32
    %1 = llvm.intr.umax(%0, %arg0)  : (i32, i32) -> i32
    llvm.call @extra_use(%0) : (i32) -> ()
    llvm.return %1 : i32
  }]

theorem inst_combine_common_factor_umax_extra_use_lhs   : common_factor_umax_extra_use_lhs_before  ⊑  common_factor_umax_extra_use_lhs_combined := by
  unfold common_factor_umax_extra_use_lhs_before common_factor_umax_extra_use_lhs_combined
  simp_alive_peephole
  sorry
def common_factor_umax_extra_use_rhs_combined := [llvmfunc|
  llvm.func @common_factor_umax_extra_use_rhs(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.intr.umax(%arg1, %arg0)  : (i32, i32) -> i32
    %1 = llvm.intr.umax(%0, %arg2)  : (i32, i32) -> i32
    llvm.call @extra_use(%0) : (i32) -> ()
    llvm.return %1 : i32
  }]

theorem inst_combine_common_factor_umax_extra_use_rhs   : common_factor_umax_extra_use_rhs_before  ⊑  common_factor_umax_extra_use_rhs_combined := by
  unfold common_factor_umax_extra_use_rhs_before common_factor_umax_extra_use_rhs_combined
  simp_alive_peephole
  sorry
def common_factor_umax_extra_use_both_combined := [llvmfunc|
  llvm.func @common_factor_umax_extra_use_both(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.intr.umax(%arg1, %arg2)  : (i32, i32) -> i32
    %1 = llvm.intr.umax(%arg1, %arg0)  : (i32, i32) -> i32
    %2 = llvm.intr.umax(%0, %1)  : (i32, i32) -> i32
    llvm.call @extra_use(%0) : (i32) -> ()
    llvm.call @extra_use(%1) : (i32) -> ()
    llvm.return %2 : i32
  }]

theorem inst_combine_common_factor_umax_extra_use_both   : common_factor_umax_extra_use_both_before  ⊑  common_factor_umax_extra_use_both_combined := by
  unfold common_factor_umax_extra_use_both_before common_factor_umax_extra_use_both_combined
  simp_alive_peephole
  sorry
def not_min_of_min_combined := [llvmfunc|
  llvm.func @not_min_of_min(%arg0: i8, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(16 : i8) : i8
    %3 = llvm.fcmp "oge" %arg1, %0 {fastmathFlags = #llvm.fastmath<fast>} : f32
    %4 = llvm.select %3, %0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : i1, f32
    %5 = llvm.fcmp "oge" %arg1, %1 {fastmathFlags = #llvm.fastmath<fast>} : f32
    %6 = llvm.select %5, %1, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : i1, f32
    %7 = llvm.icmp "ult" %arg0, %2 : i8
    %8 = llvm.select %7, %4, %6 : i1, f32
    llvm.return %8 : f32
  }]

theorem inst_combine_not_min_of_min   : not_min_of_min_before  ⊑  not_min_of_min_combined := by
  unfold not_min_of_min_before not_min_of_min_combined
  simp_alive_peephole
  sorry
def add_umin_combined := [llvmfunc|
  llvm.func @add_umin(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(27 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.intr.umin(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.add %2, %1 overflow<nsw, nuw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_add_umin   : add_umin_before  ⊑  add_umin_combined := by
  unfold add_umin_before add_umin_combined
  simp_alive_peephole
  sorry
def add_umin_constant_limit_combined := [llvmfunc|
  llvm.func @add_umin_constant_limit(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(41 : i32) : i32
    %2 = llvm.mlir.constant(42 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.select %3, %1, %2 : i1, i32
    llvm.return %4 : i32
  }]

theorem inst_combine_add_umin_constant_limit   : add_umin_constant_limit_before  ⊑  add_umin_constant_limit_combined := by
  unfold add_umin_constant_limit_before add_umin_constant_limit_combined
  simp_alive_peephole
  sorry
def add_umin_simplify_combined := [llvmfunc|
  llvm.func @add_umin_simplify(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_add_umin_simplify   : add_umin_simplify_before  ⊑  add_umin_simplify_combined := by
  unfold add_umin_simplify_before add_umin_simplify_combined
  simp_alive_peephole
  sorry
def add_umin_simplify2_combined := [llvmfunc|
  llvm.func @add_umin_simplify2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_add_umin_simplify2   : add_umin_simplify2_before  ⊑  add_umin_simplify2_combined := by
  unfold add_umin_simplify2_before add_umin_simplify2_combined
  simp_alive_peephole
  sorry
def add_umin_wrong_pred_combined := [llvmfunc|
  llvm.func @add_umin_wrong_pred(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.intr.smin(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_add_umin_wrong_pred   : add_umin_wrong_pred_before  ⊑  add_umin_wrong_pred_combined := by
  unfold add_umin_wrong_pred_before add_umin_wrong_pred_combined
  simp_alive_peephole
  sorry
def add_umin_wrong_wrap_combined := [llvmfunc|
  llvm.func @add_umin_wrong_wrap(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.intr.umin(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_add_umin_wrong_wrap   : add_umin_wrong_wrap_before  ⊑  add_umin_wrong_wrap_combined := by
  unfold add_umin_wrong_wrap_before add_umin_wrong_wrap_combined
  simp_alive_peephole
  sorry
def add_umin_extra_use_combined := [llvmfunc|
  llvm.func @add_umin_extra_use(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i32
    llvm.store %2, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    %3 = llvm.intr.umin(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_add_umin_extra_use   : add_umin_extra_use_before  ⊑  add_umin_extra_use_combined := by
  unfold add_umin_extra_use_before add_umin_extra_use_combined
  simp_alive_peephole
  sorry
def add_umin_vec_combined := [llvmfunc|
  llvm.func @add_umin_vec(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<225> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(dense<15> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.intr.umin(%arg0, %0)  : (vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    %3 = llvm.add %2, %1 overflow<nsw, nuw>  : vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

theorem inst_combine_add_umin_vec   : add_umin_vec_before  ⊑  add_umin_vec_combined := by
  unfold add_umin_vec_before add_umin_vec_combined
  simp_alive_peephole
  sorry
def add_umax_combined := [llvmfunc|
  llvm.func @add_umax(%arg0: i37) -> i37 {
    %0 = llvm.mlir.constant(37 : i37) : i37
    %1 = llvm.mlir.constant(5 : i37) : i37
    %2 = llvm.intr.umax(%arg0, %0)  : (i37, i37) -> i37
    %3 = llvm.add %2, %1 overflow<nuw>  : i37
    llvm.return %3 : i37
  }]

theorem inst_combine_add_umax   : add_umax_before  ⊑  add_umax_combined := by
  unfold add_umax_before add_umax_combined
  simp_alive_peephole
  sorry
def add_umax_constant_limit_combined := [llvmfunc|
  llvm.func @add_umax_constant_limit(%arg0: i37) -> i37 {
    %0 = llvm.mlir.constant(1 : i37) : i37
    %1 = llvm.mlir.constant(81 : i37) : i37
    %2 = llvm.intr.umax(%arg0, %0)  : (i37, i37) -> i37
    %3 = llvm.add %2, %1 overflow<nuw>  : i37
    llvm.return %3 : i37
  }]

theorem inst_combine_add_umax_constant_limit   : add_umax_constant_limit_before  ⊑  add_umax_constant_limit_combined := by
  unfold add_umax_constant_limit_before add_umax_constant_limit_combined
  simp_alive_peephole
  sorry
def add_umax_simplify_combined := [llvmfunc|
  llvm.func @add_umax_simplify(%arg0: i37) -> i37 {
    %0 = llvm.mlir.constant(42 : i37) : i37
    %1 = llvm.add %arg0, %0 overflow<nuw>  : i37
    llvm.return %1 : i37
  }]

theorem inst_combine_add_umax_simplify   : add_umax_simplify_before  ⊑  add_umax_simplify_combined := by
  unfold add_umax_simplify_before add_umax_simplify_combined
  simp_alive_peephole
  sorry
def add_umax_simplify2_combined := [llvmfunc|
  llvm.func @add_umax_simplify2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(57 : i32) : i32
    %1 = llvm.add %arg0, %0 overflow<nuw>  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_add_umax_simplify2   : add_umax_simplify2_before  ⊑  add_umax_simplify2_combined := by
  unfold add_umax_simplify2_before add_umax_simplify2_combined
  simp_alive_peephole
  sorry
def add_umax_wrong_pred_combined := [llvmfunc|
  llvm.func @add_umax_wrong_pred(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.intr.smax(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_add_umax_wrong_pred   : add_umax_wrong_pred_before  ⊑  add_umax_wrong_pred_combined := by
  unfold add_umax_wrong_pred_before add_umax_wrong_pred_combined
  simp_alive_peephole
  sorry
def add_umax_wrong_wrap_combined := [llvmfunc|
  llvm.func @add_umax_wrong_wrap(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.intr.umax(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_add_umax_wrong_wrap   : add_umax_wrong_wrap_before  ⊑  add_umax_wrong_wrap_combined := by
  unfold add_umax_wrong_wrap_before add_umax_wrong_wrap_combined
  simp_alive_peephole
  sorry
def add_umax_extra_use_combined := [llvmfunc|
  llvm.func @add_umax_extra_use(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i32
    llvm.store %2, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    %3 = llvm.intr.umax(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_add_umax_extra_use   : add_umax_extra_use_before  ⊑  add_umax_extra_use_combined := by
  unfold add_umax_extra_use_before add_umax_extra_use_combined
  simp_alive_peephole
  sorry
def add_umax_vec_combined := [llvmfunc|
  llvm.func @add_umax_vec(%arg0: vector<2xi33>) -> vector<2xi33> {
    %0 = llvm.mlir.constant(235 : i33) : i33
    %1 = llvm.mlir.constant(dense<235> : vector<2xi33>) : vector<2xi33>
    %2 = llvm.mlir.constant(5 : i33) : i33
    %3 = llvm.mlir.constant(dense<5> : vector<2xi33>) : vector<2xi33>
    %4 = llvm.intr.umax(%arg0, %1)  : (vector<2xi33>, vector<2xi33>) -> vector<2xi33>
    %5 = llvm.add %4, %3 overflow<nuw>  : vector<2xi33>
    llvm.return %5 : vector<2xi33>
  }]

theorem inst_combine_add_umax_vec   : add_umax_vec_before  ⊑  add_umax_vec_combined := by
  unfold add_umax_vec_before add_umax_vec_combined
  simp_alive_peephole
  sorry
def PR14613_umin_combined := [llvmfunc|
  llvm.func @PR14613_umin(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(15 : i8) : i8
    %1 = llvm.intr.uadd.sat(%arg0, %0)  : (i8, i8) -> i8
    llvm.return %1 : i8
  }]

theorem inst_combine_PR14613_umin   : PR14613_umin_before  ⊑  PR14613_umin_combined := by
  unfold PR14613_umin_before PR14613_umin_combined
  simp_alive_peephole
  sorry
def PR14613_umax_combined := [llvmfunc|
  llvm.func @PR14613_umax(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-16 : i8) : i8
    %1 = llvm.mlir.constant(15 : i8) : i8
    %2 = llvm.intr.umax(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.add %2, %1 overflow<nsw>  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_PR14613_umax   : PR14613_umax_before  ⊑  PR14613_umax_combined := by
  unfold PR14613_umax_before PR14613_umax_combined
  simp_alive_peephole
  sorry
def add_smin_combined := [llvmfunc|
  llvm.func @add_smin(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(27 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.intr.smin(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.add %2, %1 overflow<nsw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_add_smin   : add_smin_before  ⊑  add_smin_combined := by
  unfold add_smin_before add_smin_combined
  simp_alive_peephole
  sorry
def add_smin_constant_limit_combined := [llvmfunc|
  llvm.func @add_smin_constant_limit(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483646 : i32) : i32
    %1 = llvm.mlir.constant(-3 : i32) : i32
    %2 = llvm.intr.smin(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.add %2, %1 overflow<nsw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_add_smin_constant_limit   : add_smin_constant_limit_before  ⊑  add_smin_constant_limit_combined := by
  unfold add_smin_constant_limit_before add_smin_constant_limit_combined
  simp_alive_peephole
  sorry
def add_smin_simplify_combined := [llvmfunc|
  llvm.func @add_smin_simplify(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-3 : i32) : i32
    %1 = llvm.add %arg0, %0 overflow<nsw>  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_add_smin_simplify   : add_smin_simplify_before  ⊑  add_smin_simplify_combined := by
  unfold add_smin_simplify_before add_smin_simplify_combined
  simp_alive_peephole
  sorry
def add_smin_simplify2_combined := [llvmfunc|
  llvm.func @add_smin_simplify2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-3 : i32) : i32
    %1 = llvm.add %arg0, %0 overflow<nsw>  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_add_smin_simplify2   : add_smin_simplify2_before  ⊑  add_smin_simplify2_combined := by
  unfold add_smin_simplify2_before add_smin_simplify2_combined
  simp_alive_peephole
  sorry
def add_smin_wrong_pred_combined := [llvmfunc|
  llvm.func @add_smin_wrong_pred(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.intr.umin(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_add_smin_wrong_pred   : add_smin_wrong_pred_before  ⊑  add_smin_wrong_pred_combined := by
  unfold add_smin_wrong_pred_before add_smin_wrong_pred_combined
  simp_alive_peephole
  sorry
def add_smin_wrong_wrap_combined := [llvmfunc|
  llvm.func @add_smin_wrong_wrap(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.intr.smin(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_add_smin_wrong_wrap   : add_smin_wrong_wrap_before  ⊑  add_smin_wrong_wrap_combined := by
  unfold add_smin_wrong_wrap_before add_smin_wrong_wrap_combined
  simp_alive_peephole
  sorry
def add_smin_extra_use_combined := [llvmfunc|
  llvm.func @add_smin_extra_use(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i32
    llvm.store %2, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    %3 = llvm.intr.smin(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_add_smin_extra_use   : add_smin_extra_use_before  ⊑  add_smin_extra_use_combined := by
  unfold add_smin_extra_use_before add_smin_extra_use_combined
  simp_alive_peephole
  sorry
def add_smin_vec_combined := [llvmfunc|
  llvm.func @add_smin_vec(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<225> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(dense<15> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.intr.smin(%arg0, %0)  : (vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    %3 = llvm.add %2, %1 overflow<nsw>  : vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

theorem inst_combine_add_smin_vec   : add_smin_vec_before  ⊑  add_smin_vec_combined := by
  unfold add_smin_vec_before add_smin_vec_combined
  simp_alive_peephole
  sorry
def add_smax_combined := [llvmfunc|
  llvm.func @add_smax(%arg0: i37) -> i37 {
    %0 = llvm.mlir.constant(37 : i37) : i37
    %1 = llvm.mlir.constant(5 : i37) : i37
    %2 = llvm.intr.smax(%arg0, %0)  : (i37, i37) -> i37
    %3 = llvm.add %2, %1 overflow<nsw, nuw>  : i37
    llvm.return %3 : i37
  }]

theorem inst_combine_add_smax   : add_smax_before  ⊑  add_smax_combined := by
  unfold add_smax_before add_smax_combined
  simp_alive_peephole
  sorry
def add_smax_constant_limit_combined := [llvmfunc|
  llvm.func @add_smax_constant_limit(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-127 : i8) : i8
    %1 = llvm.mlir.constant(125 : i8) : i8
    %2 = llvm.intr.smax(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.add %2, %1 overflow<nsw>  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_add_smax_constant_limit   : add_smax_constant_limit_before  ⊑  add_smax_constant_limit_combined := by
  unfold add_smax_constant_limit_before add_smax_constant_limit_combined
  simp_alive_peephole
  sorry
def add_smax_simplify_combined := [llvmfunc|
  llvm.func @add_smax_simplify(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(126 : i8) : i8
    %1 = llvm.add %arg0, %0 overflow<nsw>  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_add_smax_simplify   : add_smax_simplify_before  ⊑  add_smax_simplify_combined := by
  unfold add_smax_simplify_before add_smax_simplify_combined
  simp_alive_peephole
  sorry
def add_smax_simplify2_combined := [llvmfunc|
  llvm.func @add_smax_simplify2(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.add %arg0, %0 overflow<nsw>  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_add_smax_simplify2   : add_smax_simplify2_before  ⊑  add_smax_simplify2_combined := by
  unfold add_smax_simplify2_before add_smax_simplify2_combined
  simp_alive_peephole
  sorry
def add_smax_wrong_pred_combined := [llvmfunc|
  llvm.func @add_smax_wrong_pred(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.intr.umax(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_add_smax_wrong_pred   : add_smax_wrong_pred_before  ⊑  add_smax_wrong_pred_combined := by
  unfold add_smax_wrong_pred_before add_smax_wrong_pred_combined
  simp_alive_peephole
  sorry
def add_smax_wrong_wrap_combined := [llvmfunc|
  llvm.func @add_smax_wrong_wrap(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.intr.smax(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_add_smax_wrong_wrap   : add_smax_wrong_wrap_before  ⊑  add_smax_wrong_wrap_combined := by
  unfold add_smax_wrong_wrap_before add_smax_wrong_wrap_combined
  simp_alive_peephole
  sorry
def add_smax_extra_use_combined := [llvmfunc|
  llvm.func @add_smax_extra_use(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i32
    llvm.store %2, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    %3 = llvm.intr.smax(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_add_smax_extra_use   : add_smax_extra_use_before  ⊑  add_smax_extra_use_combined := by
  unfold add_smax_extra_use_before add_smax_extra_use_combined
  simp_alive_peephole
  sorry
def add_smax_vec_combined := [llvmfunc|
  llvm.func @add_smax_vec(%arg0: vector<2xi33>) -> vector<2xi33> {
    %0 = llvm.mlir.constant(235 : i33) : i33
    %1 = llvm.mlir.constant(dense<235> : vector<2xi33>) : vector<2xi33>
    %2 = llvm.mlir.constant(5 : i33) : i33
    %3 = llvm.mlir.constant(dense<5> : vector<2xi33>) : vector<2xi33>
    %4 = llvm.intr.smax(%arg0, %1)  : (vector<2xi33>, vector<2xi33>) -> vector<2xi33>
    %5 = llvm.add %4, %3 overflow<nsw, nuw>  : vector<2xi33>
    llvm.return %5 : vector<2xi33>
  }]

theorem inst_combine_add_smax_vec   : add_smax_vec_before  ⊑  add_smax_vec_combined := by
  unfold add_smax_vec_before add_smax_vec_combined
  simp_alive_peephole
  sorry
def PR14613_smin_combined := [llvmfunc|
  llvm.func @PR14613_smin(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(40 : i8) : i8
    %1 = llvm.mlir.constant(15 : i8) : i8
    %2 = llvm.intr.smin(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.add %2, %1 overflow<nsw>  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_PR14613_smin   : PR14613_smin_before  ⊑  PR14613_smin_combined := by
  unfold PR14613_smin_before PR14613_smin_combined
  simp_alive_peephole
  sorry
def PR14613_smax_combined := [llvmfunc|
  llvm.func @PR14613_smax(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(40 : i8) : i8
    %1 = llvm.mlir.constant(15 : i8) : i8
    %2 = llvm.intr.smax(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.add %2, %1 overflow<nuw>  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_PR14613_smax   : PR14613_smax_before  ⊑  PR14613_smax_combined := by
  unfold PR14613_smax_before PR14613_smax_combined
  simp_alive_peephole
  sorry
def PR46271_combined := [llvmfunc|
  llvm.func @PR46271(%arg0: vector<2xi8>) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(0 : i8) : i8
    %8 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %9 = llvm.mlir.undef : vector<2xi8>
    %10 = llvm.mlir.constant(0 : i32) : i32
    %11 = llvm.insertelement %1, %9[%10 : i32] : vector<2xi8>
    %12 = llvm.mlir.constant(1 : i32) : i32
    %13 = llvm.insertelement %7, %11[%12 : i32] : vector<2xi8>
    %14 = llvm.mlir.constant(1 : i64) : i64
    %15 = llvm.xor %arg0, %6  : vector<2xi8>
    %16 = llvm.icmp "slt" %arg0, %8 : vector<2xi8>
    %17 = llvm.select %16, %13, %15 : vector<2xi1>, vector<2xi8>
    %18 = llvm.extractelement %17[%14 : i64] : vector<2xi8>
    llvm.return %18 : i8
  }]

theorem inst_combine_PR46271   : PR46271_before  ⊑  PR46271_combined := by
  unfold PR46271_before PR46271_combined
  simp_alive_peephole
  sorry
def twoway_clamp_lt_combined := [llvmfunc|
  llvm.func @twoway_clamp_lt(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(13767 : i32) : i32
    %1 = llvm.mlir.constant(13768 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.select %2, %1, %0 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_twoway_clamp_lt   : twoway_clamp_lt_before  ⊑  twoway_clamp_lt_combined := by
  unfold twoway_clamp_lt_before twoway_clamp_lt_combined
  simp_alive_peephole
  sorry
def twoway_clamp_gt_combined := [llvmfunc|
  llvm.func @twoway_clamp_gt(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(13767 : i32) : i32
    %1 = llvm.mlir.constant(13768 : i32) : i32
    %2 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.intr.umin(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_twoway_clamp_gt   : twoway_clamp_gt_before  ⊑  twoway_clamp_gt_combined := by
  unfold twoway_clamp_gt_before twoway_clamp_gt_combined
  simp_alive_peephole
  sorry
def twoway_clamp_gt_nonconst_combined := [llvmfunc|
  llvm.func @twoway_clamp_gt_nonconst(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.add %arg1, %0  : i32
    %2 = llvm.intr.smax(%arg0, %arg1)  : (i32, i32) -> i32
    %3 = llvm.intr.smin(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_twoway_clamp_gt_nonconst   : twoway_clamp_gt_nonconst_before  ⊑  twoway_clamp_gt_nonconst_combined := by
  unfold twoway_clamp_gt_nonconst_before twoway_clamp_gt_nonconst_combined
  simp_alive_peephole
  sorry
def test_umax_smax1_combined := [llvmfunc|
  llvm.func @test_umax_smax1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.intr.umax(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test_umax_smax1   : test_umax_smax1_before  ⊑  test_umax_smax1_combined := by
  unfold test_umax_smax1_before test_umax_smax1_combined
  simp_alive_peephole
  sorry
def test_umax_smax2_combined := [llvmfunc|
  llvm.func @test_umax_smax2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(20 : i32) : i32
    %1 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test_umax_smax2   : test_umax_smax2_before  ⊑  test_umax_smax2_combined := by
  unfold test_umax_smax2_before test_umax_smax2_combined
  simp_alive_peephole
  sorry
def test_umax_smax_vec_combined := [llvmfunc|
  llvm.func @test_umax_smax_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[0, 20]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[1, 10]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.intr.smax(%arg0, %0)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %3 = llvm.intr.umax(%2, %1)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_test_umax_smax_vec   : test_umax_smax_vec_before  ⊑  test_umax_smax_vec_combined := by
  unfold test_umax_smax_vec_before test_umax_smax_vec_combined
  simp_alive_peephole
  sorry
def test_smin_umin1_combined := [llvmfunc|
  llvm.func @test_smin_umin1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.intr.umin(%arg0, %0)  : (i32, i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test_smin_umin1   : test_smin_umin1_before  ⊑  test_smin_umin1_combined := by
  unfold test_smin_umin1_before test_smin_umin1_combined
  simp_alive_peephole
  sorry
def test_smin_umin2_combined := [llvmfunc|
  llvm.func @test_smin_umin2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(20 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.intr.umin(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.intr.smin(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test_smin_umin2   : test_smin_umin2_before  ⊑  test_smin_umin2_combined := by
  unfold test_smin_umin2_before test_smin_umin2_combined
  simp_alive_peephole
  sorry
def test_smin_umin_vec_combined := [llvmfunc|
  llvm.func @test_smin_umin_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[10, 20]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[20, 10]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.intr.umin(%arg0, %0)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %3 = llvm.intr.smin(%2, %1)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_test_smin_umin_vec   : test_smin_umin_vec_before  ⊑  test_smin_umin_vec_combined := by
  unfold test_smin_umin_vec_before test_smin_umin_vec_combined
  simp_alive_peephole
  sorry
def test_umax_smax3_combined := [llvmfunc|
  llvm.func @test_umax_smax3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test_umax_smax3   : test_umax_smax3_before  ⊑  test_umax_smax3_combined := by
  unfold test_umax_smax3_before test_umax_smax3_combined
  simp_alive_peephole
  sorry
def test_umax_smax4_combined := [llvmfunc|
  llvm.func @test_umax_smax4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-20 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.intr.umax(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test_umax_smax4   : test_umax_smax4_before  ⊑  test_umax_smax4_combined := by
  unfold test_umax_smax4_before test_umax_smax4_combined
  simp_alive_peephole
  sorry
def test_smin_umin3_combined := [llvmfunc|
  llvm.func @test_smin_umin3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-20 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test_smin_umin3   : test_smin_umin3_before  ⊑  test_smin_umin3_combined := by
  unfold test_smin_umin3_before test_smin_umin3_combined
  simp_alive_peephole
  sorry
def test_smin_umin4_combined := [llvmfunc|
  llvm.func @test_smin_umin4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-20 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.intr.umin(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.intr.smin(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test_smin_umin4   : test_smin_umin4_before  ⊑  test_smin_umin4_combined := by
  unfold test_smin_umin4_before test_smin_umin4_combined
  simp_alive_peephole
  sorry
def test_umax_nonminmax_combined := [llvmfunc|
  llvm.func @test_umax_nonminmax(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %2 = llvm.intr.umax(%1, %0)  : (i32, i32) -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test_umax_nonminmax   : test_umax_nonminmax_before  ⊑  test_umax_nonminmax_combined := by
  unfold test_umax_nonminmax_before test_umax_nonminmax_combined
  simp_alive_peephole
  sorry
def test_umax_smax_vec_neg_combined := [llvmfunc|
  llvm.func @test_umax_smax_vec_neg(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[0, -20]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[1, 10]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.intr.smax(%arg0, %0)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %3 = llvm.intr.umax(%2, %1)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_test_umax_smax_vec_neg   : test_umax_smax_vec_neg_before  ⊑  test_umax_smax_vec_neg_combined := by
  unfold test_umax_smax_vec_neg_before test_umax_smax_vec_neg_combined
  simp_alive_peephole
  sorry
