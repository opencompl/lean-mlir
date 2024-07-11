import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  cast
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i32) -> i32 {
    %0 = llvm.bitcast %arg0 : i32 to i32
    %1 = llvm.bitcast %0 : i32 to i32
    llvm.return %1 : i32
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i8) -> i64 {
    %0 = llvm.zext %arg0 : i8 to i16
    %1 = llvm.zext %0 : i16 to i32
    %2 = llvm.zext %1 : i32 to i64
    llvm.return %2 : i64
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: i64) -> i64 {
    %0 = llvm.trunc %arg0 : i64 to i8
    %1 = llvm.zext %0 : i8 to i64
    llvm.return %1 : i64
  }]

def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i32
    %1 = llvm.zext %0 : i1 to i8
    %2 = llvm.zext %1 : i8 to i32
    llvm.return %2 : i32
  }]

def test5_before := [llvmfunc|
  llvm.func @test5(%arg0: i1) -> i32 {
    %0 = llvm.zext %arg0 : i1 to i8
    %1 = llvm.zext %0 : i8 to i32
    llvm.return %1 : i32
  }]

def test6_before := [llvmfunc|
  llvm.func @test6(%arg0: i64) -> i32 {
    %0 = llvm.trunc %arg0 : i64 to i32
    %1 = llvm.bitcast %0 : i32 to i32
    llvm.return %1 : i32
  }]

def test7_before := [llvmfunc|
  llvm.func @test7(%arg0: i1) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i32
    %1 = llvm.sext %0 : i32 to i64
    llvm.return %1 : i64
  }]

def test8_before := [llvmfunc|
  llvm.func @test8(%arg0: i8) -> i64 {
    %0 = llvm.sext %arg0 : i8 to i64
    %1 = llvm.bitcast %0 : i64 to i64
    llvm.return %1 : i64
  }]

def test9_before := [llvmfunc|
  llvm.func @test9(%arg0: i16) -> i16 {
    %0 = llvm.sext %arg0 : i16 to i32
    %1 = llvm.trunc %0 : i32 to i16
    llvm.return %1 : i16
  }]

def test10_before := [llvmfunc|
  llvm.func @test10(%arg0: i16) -> i16 {
    %0 = llvm.sext %arg0 : i16 to i32
    %1 = llvm.trunc %0 : i32 to i16
    llvm.return %1 : i16
  }]

def test11_before := [llvmfunc|
  llvm.func @test11(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(5 : i32) : i32
    llvm.call @varargs(%0, %arg0) vararg(!llvm.func<void (i32, ...)>) : (i32, !llvm.ptr) -> ()
    llvm.return
  }]

def test_invoke_vararg_cast_before := [llvmfunc|
  llvm.func @test_invoke_vararg_cast(%arg0: !llvm.ptr, %arg1: !llvm.ptr) attributes {personality = @__gxx_personality_v0} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    llvm.invoke @varargs(%0, %arg1, %arg0) to ^bb1 unwind ^bb2 vararg(!llvm.func<void (i32, ...)>) : (i32, !llvm.ptr, !llvm.ptr) -> ()
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    %1 = llvm.landingpad cleanup : !llvm.struct<(ptr, i32)>
    llvm.return
  }]

def test13_before := [llvmfunc|
  llvm.func @test13(%arg0: i64) -> !llvm.ptr {
    %0 = llvm.mlir.addressof @inbuf : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.getelementptr %0[%1, %arg0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i8>
    llvm.return %2 : !llvm.ptr
  }]

def test14_before := [llvmfunc|
  llvm.func @test14(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.bitcast %arg0 : i8 to i8
    %2 = llvm.icmp "ult" %1, %0 : i8
    llvm.return %2 : i1
  }]

def test16_before := [llvmfunc|
  llvm.func @test16(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    llvm.return %1 : i1
  }]

def test17_before := [llvmfunc|
  llvm.func @test17(%arg0: i1) -> i16 {
    %0 = llvm.zext %arg0 : i1 to i32
    %1 = llvm.trunc %0 : i32 to i16
    llvm.return %1 : i16
  }]

def test18_before := [llvmfunc|
  llvm.func @test18(%arg0: i8) -> i16 {
    %0 = llvm.sext %arg0 : i8 to i32
    %1 = llvm.trunc %0 : i32 to i16
    llvm.return %1 : i16
  }]

def test19_before := [llvmfunc|
  llvm.func @test19(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12345 : i64) : i64
    %1 = llvm.sext %arg0 : i32 to i64
    %2 = llvm.icmp "slt" %1, %0 : i64
    llvm.return %2 : i1
  }]

def test19vec_before := [llvmfunc|
  llvm.func @test19vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[12345, 2147483647]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.sext %arg0 : vector<2xi32> to vector<2xi64>
    %2 = llvm.icmp "slt" %1, %0 : vector<2xi64>
    llvm.return %2 : vector<2xi1>
  }]

def test19vec2_before := [llvmfunc|
  llvm.func @test19vec2(%arg0: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<3xi32>) : vector<3xi32>
    %2 = llvm.sext %arg0 : vector<3xi1> to vector<3xi32>
    %3 = llvm.icmp "eq" %2, %1 : vector<3xi32>
    llvm.return %3 : vector<3xi1>
  }]

def test20_before := [llvmfunc|
  llvm.func @test20(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    llvm.return %2 : i1
  }]

def test21_before := [llvmfunc|
  llvm.func @test21(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.trunc %arg0 : i32 to i8
    %2 = llvm.sext %1 : i8 to i32
    %3 = llvm.and %2, %0  : i32
    llvm.return %3 : i32
  }]

def test22_before := [llvmfunc|
  llvm.func @test22(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.trunc %arg0 : i32 to i8
    %2 = llvm.sext %1 : i8 to i32
    %3 = llvm.shl %2, %0  : i32
    llvm.return %3 : i32
  }]

def test23_before := [llvmfunc|
  llvm.func @test23(%arg0: i32) -> i32 {
    %0 = llvm.trunc %arg0 : i32 to i16
    %1 = llvm.zext %0 : i16 to i32
    llvm.return %1 : i32
  }]

def test24_before := [llvmfunc|
  llvm.func @test24(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(14 : i32) : i32
    %1 = llvm.mlir.constant(1234 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    %4 = llvm.icmp "ne" %3, %2 : i32
    llvm.return %4 : i1
  }]

def test26_before := [llvmfunc|
  llvm.func @test26(%arg0: f32) -> i32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fptosi %0 : f64 to i32
    llvm.return %1 : i32
  }]

def test27_before := [llvmfunc|
  llvm.func @test27(%arg0: !llvm.ptr) -> !llvm.ptr {
    llvm.return %arg0 : !llvm.ptr
  }]

def test28_before := [llvmfunc|
  llvm.func @test28(%arg0: !llvm.ptr) -> !llvm.ptr {
    llvm.return %arg0 : !llvm.ptr
  }]

def test29_before := [llvmfunc|
  llvm.func @test29(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.trunc %arg0 : i32 to i8
    %1 = llvm.trunc %arg1 : i32 to i8
    %2 = llvm.or %1, %0  : i8
    %3 = llvm.zext %2 : i8 to i32
    llvm.return %3 : i32
  }]

def test30_before := [llvmfunc|
  llvm.func @test30(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.trunc %arg0 : i32 to i8
    %2 = llvm.xor %1, %0  : i8
    %3 = llvm.zext %2 : i8 to i32
    llvm.return %3 : i32
  }]

def test31_before := [llvmfunc|
  llvm.func @test31(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.trunc %arg0 : i64 to i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }]

def test31vec_before := [llvmfunc|
  llvm.func @test31vec(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<10> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %3 = llvm.and %2, %0  : vector<2xi32>
    %4 = llvm.icmp "eq" %3, %1 : vector<2xi32>
    llvm.return %4 : vector<2xi1>
  }]

def test32vec_before := [llvmfunc|
  llvm.func @test32vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(dense<10> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.zext %arg0 : vector<2xi8> to vector<2xi16>
    %3 = llvm.and %2, %0  : vector<2xi16>
    %4 = llvm.icmp "eq" %3, %1 : vector<2xi16>
    llvm.return %4 : vector<2xi1>
  }]

def test33_before := [llvmfunc|
  llvm.func @test33(%arg0: i32) -> i32 {
    %0 = llvm.bitcast %arg0 : i32 to f32
    %1 = llvm.bitcast %0 : f32 to i32
    llvm.return %1 : i32
  }]

def test34_before := [llvmfunc|
  llvm.func @test34(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.zext %arg0 : i16 to i32
    %2 = llvm.lshr %1, %0  : i32
    %3 = llvm.trunc %2 : i32 to i16
    llvm.return %3 : i16
  }]

def test35_before := [llvmfunc|
  llvm.func @test35(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.bitcast %arg0 : i16 to i16
    %2 = llvm.lshr %1, %0  : i16
    %3 = llvm.bitcast %2 : i16 to i16
    llvm.return %3 : i16
  }]

def test36_before := [llvmfunc|
  llvm.func @test36(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    llvm.return %4 : i1
  }]

def test36vec_before := [llvmfunc|
  llvm.func @test36vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<31> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.lshr %arg0, %0  : vector<2xi32>
    %4 = llvm.trunc %3 : vector<2xi32> to vector<2xi8>
    %5 = llvm.icmp "eq" %4, %2 : vector<2xi8>
    llvm.return %5 : vector<2xi1>
  }]

def test37_before := [llvmfunc|
  llvm.func @test37(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(512 : i32) : i32
    %2 = llvm.mlir.constant(11 : i8) : i8
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = llvm.or %3, %1  : i32
    %5 = llvm.trunc %4 : i32 to i8
    %6 = llvm.icmp "eq" %5, %2 : i8
    llvm.return %6 : i1
  }]

def test38_before := [llvmfunc|
  llvm.func @test38(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.zext %2 : i1 to i8
    %4 = llvm.xor %3, %1  : i8
    %5 = llvm.zext %4 : i8 to i64
    llvm.return %5 : i64
  }]

def test39_before := [llvmfunc|
  llvm.func @test39(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.zext %arg0 : i16 to i32
    %2 = llvm.lshr %1, %0  : i32
    %3 = llvm.shl %1, %0  : i32
    %4 = llvm.or %2, %3  : i32
    %5 = llvm.trunc %4 : i32 to i16
    llvm.return %5 : i16
  }]

def test40_before := [llvmfunc|
  llvm.func @test40(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.zext %arg0 : i16 to i32
    %3 = llvm.lshr %2, %0  : i32
    %4 = llvm.shl %2, %1  : i32
    %5 = llvm.or %3, %4  : i32
    %6 = llvm.trunc %5 : i32 to i16
    llvm.return %6 : i16
  }]

def test40vec_before := [llvmfunc|
  llvm.func @test40vec(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<9> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.zext %arg0 : vector<2xi16> to vector<2xi32>
    %3 = llvm.lshr %2, %0  : vector<2xi32>
    %4 = llvm.shl %2, %1  : vector<2xi32>
    %5 = llvm.or %3, %4  : vector<2xi32>
    %6 = llvm.trunc %5 : vector<2xi32> to vector<2xi16>
    llvm.return %6 : vector<2xi16>
  }]

def test40vec_nonuniform_before := [llvmfunc|
  llvm.func @test40vec_nonuniform(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[9, 10]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[8, 9]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.zext %arg0 : vector<2xi16> to vector<2xi32>
    %3 = llvm.lshr %2, %0  : vector<2xi32>
    %4 = llvm.shl %2, %1  : vector<2xi32>
    %5 = llvm.or %3, %4  : vector<2xi32>
    %6 = llvm.trunc %5 : vector<2xi32> to vector<2xi16>
    llvm.return %6 : vector<2xi16>
  }]

def test40vec_poison_before := [llvmfunc|
  llvm.func @test40vec_poison(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(8 : i32) : i32
    %8 = llvm.mlir.undef : vector<2xi32>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %7, %8[%9 : i32] : vector<2xi32>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<2xi32>
    %13 = llvm.zext %arg0 : vector<2xi16> to vector<2xi32>
    %14 = llvm.lshr %13, %6  : vector<2xi32>
    %15 = llvm.shl %13, %12  : vector<2xi32>
    %16 = llvm.or %14, %15  : vector<2xi32>
    %17 = llvm.trunc %16 : vector<2xi32> to vector<2xi16>
    llvm.return %17 : vector<2xi16>
  }]

def test41_before := [llvmfunc|
  llvm.func @test41(%arg0: !llvm.ptr) -> !llvm.ptr {
    llvm.return %arg0 : !llvm.ptr
  }]

def test41_addrspacecast_smaller_before := [llvmfunc|
  llvm.func @test41_addrspacecast_smaller(%arg0: !llvm.ptr) -> !llvm.ptr<1> {
    %0 = llvm.addrspacecast %arg0 : !llvm.ptr to !llvm.ptr<1>
    llvm.return %0 : !llvm.ptr<1>
  }]

def test41_addrspacecast_larger_before := [llvmfunc|
  llvm.func @test41_addrspacecast_larger(%arg0: !llvm.ptr<1>) -> !llvm.ptr {
    %0 = llvm.addrspacecast %arg0 : !llvm.ptr<1> to !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

def test42_before := [llvmfunc|
  llvm.func @test42(%arg0: i32) -> i32 {
    %0 = llvm.trunc %arg0 : i32 to i8
    %1 = llvm.zext %0 : i8 to i32
    llvm.return %1 : i32
  }]

def test43(%arg0: i8 {llvm.zeroext}) -> _before := [llvmfunc|
  llvm.func @test43(%arg0: i8 {llvm.zeroext}) -> (i64 {llvm.zeroext}) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.add %1, %0  : i32
    %3 = llvm.sext %2 : i32 to i64
    llvm.return %3 : i64
  }]

def test44_before := [llvmfunc|
  llvm.func @test44(%arg0: i8) -> i64 {
    %0 = llvm.mlir.constant(1234 : i16) : i16
    %1 = llvm.zext %arg0 : i8 to i16
    %2 = llvm.or %1, %0  : i16
    %3 = llvm.zext %2 : i16 to i64
    llvm.return %3 : i64
  }]

def test45_before := [llvmfunc|
  llvm.func @test45(%arg0: i8, %arg1: i64) -> i64 {
    %0 = llvm.trunc %arg1 : i64 to i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.or %1, %0  : i32
    %3 = llvm.zext %2 : i32 to i64
    llvm.return %3 : i64
  }]

def test46_before := [llvmfunc|
  llvm.func @test46(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.trunc %arg0 : i64 to i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.shl %3, %1  : i32
    %5 = llvm.zext %4 : i32 to i64
    llvm.return %5 : i64
  }]

def test46vec_before := [llvmfunc|
  llvm.func @test46vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %3 = llvm.and %2, %0  : vector<2xi32>
    %4 = llvm.shl %3, %1  : vector<2xi32>
    %5 = llvm.zext %4 : vector<2xi32> to vector<2xi64>
    llvm.return %5 : vector<2xi64>
  }]

def test47_before := [llvmfunc|
  llvm.func @test47(%arg0: i8) -> i64 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.or %1, %0  : i32
    %3 = llvm.zext %2 : i32 to i64
    llvm.return %3 : i64
  }]

def test48_before := [llvmfunc|
  llvm.func @test48(%arg0: i8, %arg1: i8) -> i64 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.zext %arg1 : i8 to i32
    %2 = llvm.zext %arg0 : i8 to i32
    %3 = llvm.shl %2, %0  : i32
    %4 = llvm.or %3, %2  : i32
    %5 = llvm.zext %4 : i32 to i64
    llvm.return %5 : i64
  }]

def test49_before := [llvmfunc|
  llvm.func @test49(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.trunc %arg0 : i64 to i32
    %2 = llvm.or %1, %0  : i32
    %3 = llvm.sext %2 : i32 to i64
    llvm.return %3 : i64
  }]

def test50_before := [llvmfunc|
  llvm.func @test50(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.add %3, %1  : i32
    %5 = llvm.sext %4 : i32 to i64
    llvm.return %5 : i64
  }]

def test51_before := [llvmfunc|
  llvm.func @test51(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.trunc %arg0 : i64 to i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.or %2, %1  : i32
    %5 = llvm.select %arg1, %3, %4 : i1, i32
    %6 = llvm.sext %5 : i32 to i64
    llvm.return %6 : i64
  }]

def test52_before := [llvmfunc|
  llvm.func @test52(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(-32574 : i16) : i16
    %1 = llvm.mlir.constant(-25350 : i16) : i16
    %2 = llvm.trunc %arg0 : i64 to i16
    %3 = llvm.or %2, %0  : i16
    %4 = llvm.and %3, %1  : i16
    %5 = llvm.zext %4 : i16 to i32
    llvm.return %5 : i32
  }]

def test53_before := [llvmfunc|
  llvm.func @test53(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(-32574 : i16) : i16
    %1 = llvm.mlir.constant(-25350 : i16) : i16
    %2 = llvm.trunc %arg0 : i32 to i16
    %3 = llvm.or %2, %0  : i16
    %4 = llvm.and %3, %1  : i16
    %5 = llvm.zext %4 : i16 to i64
    llvm.return %5 : i64
  }]

def test54_before := [llvmfunc|
  llvm.func @test54(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(-32574 : i16) : i16
    %1 = llvm.mlir.constant(-25350 : i16) : i16
    %2 = llvm.trunc %arg0 : i64 to i16
    %3 = llvm.or %2, %0  : i16
    %4 = llvm.and %3, %1  : i16
    %5 = llvm.sext %4 : i16 to i32
    llvm.return %5 : i32
  }]

def test55_before := [llvmfunc|
  llvm.func @test55(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(-32574 : i16) : i16
    %1 = llvm.mlir.constant(-25350 : i16) : i16
    %2 = llvm.trunc %arg0 : i32 to i16
    %3 = llvm.or %2, %0  : i16
    %4 = llvm.and %3, %1  : i16
    %5 = llvm.sext %4 : i16 to i64
    llvm.return %5 : i64
  }]

def test56_before := [llvmfunc|
  llvm.func @test56(%arg0: i16) -> i64 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.sext %arg0 : i16 to i32
    %2 = llvm.lshr %1, %0  : i32
    %3 = llvm.zext %2 : i32 to i64
    llvm.return %3 : i64
  }]

def test56vec_before := [llvmfunc|
  llvm.func @test56vec(%arg0: vector<2xi16>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi16> to vector<2xi32>
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    %3 = llvm.zext %2 : vector<2xi32> to vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }]

def test57_before := [llvmfunc|
  llvm.func @test57(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.trunc %arg0 : i64 to i32
    %2 = llvm.lshr %1, %0  : i32
    %3 = llvm.zext %2 : i32 to i64
    llvm.return %3 : i64
  }]

def test57vec_before := [llvmfunc|
  llvm.func @test57vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    %3 = llvm.zext %2 : vector<2xi32> to vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }]

def test58_before := [llvmfunc|
  llvm.func @test58(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.trunc %arg0 : i64 to i32
    %3 = llvm.lshr %2, %0  : i32
    %4 = llvm.or %3, %1  : i32
    %5 = llvm.zext %4 : i32 to i64
    llvm.return %5 : i64
  }]

def test59_before := [llvmfunc|
  llvm.func @test59(%arg0: i8, %arg1: i8) -> i64 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(48 : i32) : i32
    %2 = llvm.zext %arg0 : i8 to i32
    %3 = llvm.shl %2, %0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.zext %arg1 : i8 to i32
    %6 = llvm.lshr %5, %0  : i32
    %7 = llvm.or %6, %4  : i32
    %8 = llvm.zext %7 : i32 to i64
    llvm.return %8 : i64
  }]

def test60_before := [llvmfunc|
  llvm.func @test60(%arg0: vector<4xi32>) -> vector<3xi32> {
    %0 = llvm.bitcast %arg0 : vector<4xi32> to i128
    %1 = llvm.trunc %0 : i128 to i96
    %2 = llvm.bitcast %1 : i96 to vector<3xi32>
    llvm.return %2 : vector<3xi32>
  }]

def test61_before := [llvmfunc|
  llvm.func @test61(%arg0: vector<3xi32>) -> vector<4xi32> {
    %0 = llvm.bitcast %arg0 : vector<3xi32> to i96
    %1 = llvm.zext %0 : i96 to i128
    %2 = llvm.bitcast %1 : i128 to vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }]

def test62_before := [llvmfunc|
  llvm.func @test62(%arg0: vector<3xf32>) -> vector<4xi32> {
    %0 = llvm.bitcast %arg0 : vector<3xf32> to i96
    %1 = llvm.zext %0 : i96 to i128
    %2 = llvm.bitcast %1 : i128 to vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }]

def test63_before := [llvmfunc|
  llvm.func @test63(%arg0: i64) -> vector<2xf32> {
    %0 = llvm.bitcast %arg0 : i64 to vector<2xi32>
    %1 = llvm.uitofp %0 : vector<2xi32> to vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }]

def test64_before := [llvmfunc|
  llvm.func @test64(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.bitcast %arg0 : vector<4xf32> to vector<4xi32>
    %1 = llvm.bitcast %0 : vector<4xi32> to vector<4xf32>
    llvm.return %1 : vector<4xf32>
  }]

def test65_before := [llvmfunc|
  llvm.func @test65(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.bitcast %arg0 : vector<4xf32> to vector<2xf64>
    %1 = llvm.bitcast %0 : vector<2xf64> to vector<4xf32>
    llvm.return %1 : vector<4xf32>
  }]

def test66_before := [llvmfunc|
  llvm.func @test66(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.bitcast %arg0 : vector<2xf32> to f64
    %1 = llvm.bitcast %0 : f64 to vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }]

def test2c_before := [llvmfunc|
  llvm.func @test2c() -> f32 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f32) : f32
    llvm.return %0 : f32
  }]

def test_mmx_before := [llvmfunc|
  llvm.func @test_mmx(%arg0: vector<2xi32>) -> i64 {
    %0 = llvm.bitcast %arg0 : vector<2xi32> to !llvm.x86_mmx
    %1 = llvm.bitcast %0 : !llvm.x86_mmx to vector<2xi32>
    %2 = llvm.bitcast %1 : vector<2xi32> to i64
    llvm.return %2 : i64
  }]

def test_mmx_const_before := [llvmfunc|
  llvm.func @test_mmx_const(%arg0: vector<2xi32>) -> i64 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.bitcast %1 : vector<2xi32> to !llvm.x86_mmx
    %3 = llvm.bitcast %2 : !llvm.x86_mmx to vector<2xi32>
    %4 = llvm.bitcast %3 : vector<2xi32> to i64
    llvm.return %4 : i64
  }]

def test67_before := [llvmfunc|
  llvm.func @test67(%arg0: i1, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(24 : i32) : i32
    %2 = llvm.mlir.constant(-16777216 : i32) : i32
    %3 = llvm.mlir.constant(0 : i8) : i8
    %4 = llvm.zext %arg0 : i1 to i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.and %arg1, %5  : i32
    %7 = llvm.shl %6, %1 overflow<nsw, nuw>  : i32
    %8 = llvm.xor %7, %2  : i32
    %9 = llvm.ashr %8, %1  : i32
    %10 = llvm.trunc %9 : i32 to i8
    %11 = llvm.icmp "eq" %10, %3 : i8
    llvm.return %11 : i1
  }]

def test68(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.struct<"s", _before := [llvmfunc|
  llvm.func @test68(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.struct<"s", (i32, i32, i16)> {
    %0 = llvm.mlir.constant(12 : i64) : i64
    %1 = llvm.mul %arg1, %0  : i64
    %2 = llvm.getelementptr inbounds %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> !llvm.struct<"s", (i32, i32, i16)>]

    llvm.return %3 : !llvm.struct<"s", (i32, i32, i16)>
  }]

def test68_addrspacecast(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.struct<"s", _before := [llvmfunc|
  llvm.func @test68_addrspacecast(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.struct<"s", (i32, i32, i16)> {
    %0 = llvm.mlir.constant(12 : i64) : i64
    %1 = llvm.mul %arg1, %0  : i64
    %2 = llvm.addrspacecast %arg0 : !llvm.ptr to !llvm.ptr<2>
    %3 = llvm.getelementptr inbounds %2[%1] : (!llvm.ptr<2>, i64) -> !llvm.ptr<2>, i8
    %4 = llvm.addrspacecast %3 : !llvm.ptr<2> to !llvm.ptr
    %5 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr -> !llvm.struct<"s", (i32, i32, i16)>]

    llvm.return %5 : !llvm.struct<"s", (i32, i32, i16)>
  }]

def test68_addrspacecast_2(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.struct<"s", _before := [llvmfunc|
  llvm.func @test68_addrspacecast_2(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.struct<"s", (i32, i32, i16)> {
    %0 = llvm.mlir.constant(12 : i64) : i64
    %1 = llvm.mul %arg1, %0  : i64
    %2 = llvm.addrspacecast %arg0 : !llvm.ptr to !llvm.ptr<2>
    %3 = llvm.getelementptr inbounds %2[%1] : (!llvm.ptr<2>, i64) -> !llvm.ptr<2>, i8
    %4 = llvm.addrspacecast %3 : !llvm.ptr<2> to !llvm.ptr<1>
    %5 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr<1> -> !llvm.struct<"s", (i32, i32, i16)>]

    llvm.return %5 : !llvm.struct<"s", (i32, i32, i16)>
  }]

def test68_as1(%arg0: !llvm.ptr<1>, %arg1: i32) -> !llvm.struct<"s", _before := [llvmfunc|
  llvm.func @test68_as1(%arg0: !llvm.ptr<1>, %arg1: i32) -> !llvm.struct<"s", (i32, i32, i16)> {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mul %arg1, %0  : i32
    %2 = llvm.getelementptr inbounds %arg0[%1] : (!llvm.ptr<1>, i32) -> !llvm.ptr<1>, i8
    %3 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr<1> -> !llvm.struct<"s", (i32, i32, i16)>]

    llvm.return %3 : !llvm.struct<"s", (i32, i32, i16)>
  }]

def test69_before := [llvmfunc|
  llvm.func @test69(%arg0: !llvm.ptr, %arg1: i64) -> f64 {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.shl %arg1, %0 overflow<nsw>  : i64
    %2 = llvm.getelementptr inbounds %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> f64]

    llvm.return %3 : f64
  }]

def test70(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.struct<"s", _before := [llvmfunc|
  llvm.func @test70(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.struct<"s", (i32, i32, i16)> {
    %0 = llvm.mlir.constant(36 : i64) : i64
    %1 = llvm.mul %arg1, %0 overflow<nsw>  : i64
    %2 = llvm.getelementptr inbounds %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> !llvm.struct<"s", (i32, i32, i16)>]

    llvm.return %3 : !llvm.struct<"s", (i32, i32, i16)>
  }]

def test71_before := [llvmfunc|
  llvm.func @test71(%arg0: !llvm.ptr, %arg1: i64) -> f64 {
    %0 = llvm.mlir.constant(5 : i64) : i64
    %1 = llvm.shl %arg1, %0  : i64
    %2 = llvm.getelementptr %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> f64]

    llvm.return %3 : f64
  }]

def test72_before := [llvmfunc|
  llvm.func @test72(%arg0: !llvm.ptr, %arg1: i32) -> f64 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.shl %arg1, %0 overflow<nsw>  : i32
    %2 = llvm.sext %1 : i32 to i64
    %3 = llvm.getelementptr inbounds %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %4 = llvm.load %3 {alignment = 8 : i64} : !llvm.ptr -> f64]

    llvm.return %4 : f64
  }]

def test73_before := [llvmfunc|
  llvm.func @test73(%arg0: !llvm.ptr, %arg1: i128) -> f64 {
    %0 = llvm.mlir.constant(3 : i128) : i128
    %1 = llvm.shl %arg1, %0 overflow<nsw>  : i128
    %2 = llvm.trunc %1 : i128 to i64
    %3 = llvm.getelementptr inbounds %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %4 = llvm.load %3 {alignment = 8 : i64} : !llvm.ptr -> f64]

    llvm.return %4 : f64
  }]

def test74_before := [llvmfunc|
  llvm.func @test74(%arg0: !llvm.ptr, %arg1: i64) -> f64 {
    %0 = llvm.getelementptr inbounds %arg0[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %1 = llvm.load %0 {alignment = 8 : i64} : !llvm.ptr -> f64]

    llvm.return %1 : f64
  }]

def test75_before := [llvmfunc|
  llvm.func @test75(%arg0: !llvm.ptr, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.shl %arg1, %0  : i32
    %2 = llvm.sext %1 : i32 to i64
    %3 = llvm.getelementptr %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.return %3 : !llvm.ptr
  }]

def test76(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.struct<"s", _before := [llvmfunc|
  llvm.func @test76(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.struct<"s", (i32, i32, i16)> {
    %0 = llvm.mlir.constant(12 : i64) : i64
    %1 = llvm.mul %arg1, %0  : i64
    %2 = llvm.mul %1, %arg2 overflow<nsw>  : i64
    %3 = llvm.getelementptr inbounds %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %4 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> !llvm.struct<"s", (i32, i32, i16)>]

    llvm.return %4 : !llvm.struct<"s", (i32, i32, i16)>
  }]

def test77(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.struct<"s", _before := [llvmfunc|
  llvm.func @test77(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.struct<"s", (i32, i32, i16)> {
    %0 = llvm.mlir.constant(36 : i64) : i64
    %1 = llvm.mul %arg1, %0 overflow<nsw>  : i64
    %2 = llvm.mul %1, %arg2 overflow<nsw>  : i64
    %3 = llvm.getelementptr inbounds %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %4 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> !llvm.struct<"s", (i32, i32, i16)>]

    llvm.return %4 : !llvm.struct<"s", (i32, i32, i16)>
  }]

def test78(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64, %arg3: i32, %arg4: i32, %arg5: i128, %arg6: i128) -> !llvm.struct<"s", _before := [llvmfunc|
  llvm.func @test78(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64, %arg3: i32, %arg4: i32, %arg5: i128, %arg6: i128) -> !llvm.struct<"s", (i32, i32, i16)> {
    %0 = llvm.mlir.constant(36 : i32) : i32
    %1 = llvm.mul %arg3, %0 overflow<nsw>  : i32
    %2 = llvm.mul %1, %arg4 overflow<nsw>  : i32
    %3 = llvm.sext %2 : i32 to i128
    %4 = llvm.mul %3, %arg5 overflow<nsw>  : i128
    %5 = llvm.mul %4, %arg6  : i128
    %6 = llvm.trunc %5 : i128 to i64
    %7 = llvm.mul %6, %arg1 overflow<nsw>  : i64
    %8 = llvm.mul %7, %arg2 overflow<nsw>  : i64
    %9 = llvm.getelementptr inbounds %arg0[%8] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %10 = llvm.load %9 {alignment = 4 : i64} : !llvm.ptr -> !llvm.struct<"s", (i32, i32, i16)>]

    llvm.return %10 : !llvm.struct<"s", (i32, i32, i16)>
  }]

def test79(%arg0: !llvm.ptr, %arg1: i64, %arg2: i32) -> !llvm.struct<"s", _before := [llvmfunc|
  llvm.func @test79(%arg0: !llvm.ptr, %arg1: i64, %arg2: i32) -> !llvm.struct<"s", (i32, i32, i16)> {
    %0 = llvm.mlir.constant(36 : i64) : i64
    %1 = llvm.mul %arg1, %0 overflow<nsw>  : i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.mul %2, %arg2  : i32
    %4 = llvm.getelementptr inbounds %arg0[%3] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %5 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr -> !llvm.struct<"s", (i32, i32, i16)>]

    llvm.return %5 : !llvm.struct<"s", (i32, i32, i16)>
  }]

def test80_before := [llvmfunc|
  llvm.func @test80(%arg0: !llvm.ptr, %arg1: i32) -> f64 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.shl %arg1, %0 overflow<nsw>  : i32
    %2 = llvm.getelementptr %arg0[%1] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %3 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> f64]

    llvm.return %3 : f64
  }]

def test80_addrspacecast_before := [llvmfunc|
  llvm.func @test80_addrspacecast(%arg0: !llvm.ptr<1>, %arg1: i32) -> f64 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.shl %arg1, %0 overflow<nsw>  : i32
    %2 = llvm.addrspacecast %arg0 : !llvm.ptr<1> to !llvm.ptr<2>
    %3 = llvm.getelementptr %2[%1] : (!llvm.ptr<2>, i32) -> !llvm.ptr<2>, i8
    %4 = llvm.addrspacecast %3 : !llvm.ptr<2> to !llvm.ptr<1>
    %5 = llvm.load %4 {alignment = 8 : i64} : !llvm.ptr<1> -> f64]

    llvm.return %5 : f64
  }]

def test80_addrspacecast_2_before := [llvmfunc|
  llvm.func @test80_addrspacecast_2(%arg0: !llvm.ptr<1>, %arg1: i32) -> f64 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.shl %arg1, %0 overflow<nsw>  : i32
    %2 = llvm.addrspacecast %arg0 : !llvm.ptr<1> to !llvm.ptr<2>
    %3 = llvm.getelementptr %2[%1] : (!llvm.ptr<2>, i32) -> !llvm.ptr<2>, i8
    %4 = llvm.addrspacecast %3 : !llvm.ptr<2> to !llvm.ptr<3>
    %5 = llvm.load %4 {alignment = 8 : i64} : !llvm.ptr<3> -> f64]

    llvm.return %5 : f64
  }]

def test80_as1_before := [llvmfunc|
  llvm.func @test80_as1(%arg0: !llvm.ptr<1>, %arg1: i16) -> f64 {
    %0 = llvm.mlir.constant(3 : i16) : i16
    %1 = llvm.shl %arg1, %0 overflow<nsw>  : i16
    %2 = llvm.getelementptr %arg0[%1] : (!llvm.ptr<1>, i16) -> !llvm.ptr<1>, i8
    %3 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr<1> -> f64]

    llvm.return %3 : f64
  }]

def test81_before := [llvmfunc|
  llvm.func @test81(%arg0: !llvm.ptr, %arg1: f32) -> f64 {
    %0 = llvm.fptosi %arg1 : f32 to i64
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %2 = llvm.load %1 {alignment = 8 : i64} : !llvm.ptr -> f64]

    llvm.return %2 : f64
  }]

def test82_before := [llvmfunc|
  llvm.func @test82(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.trunc %arg0 : i64 to i32
    %3 = llvm.lshr %2, %0  : i32
    %4 = llvm.shl %3, %1  : i32
    %5 = llvm.zext %4 : i32 to i64
    llvm.return %5 : i64
  }]

def test83_before := [llvmfunc|
  llvm.func @test83(%arg0: i16, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.sext %arg0 : i16 to i32
    %2 = llvm.add %arg1, %0 overflow<nsw>  : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.shl %1, %3  : i32
    %5 = llvm.zext %4 : i32 to i64
    llvm.return %5 : i64
  }]

def test84_before := [llvmfunc|
  llvm.func @test84(%arg0: i32) -> i8 {
    %0 = llvm.mlir.constant(-16777216 : i32) : i32
    %1 = llvm.mlir.constant(23 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.lshr %2, %1  : i32
    %4 = llvm.trunc %3 : i32 to i8
    llvm.return %4 : i8
  }]

def test85_before := [llvmfunc|
  llvm.func @test85(%arg0: i32) -> i8 {
    %0 = llvm.mlir.constant(-16777216 : i32) : i32
    %1 = llvm.mlir.constant(23 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.lshr %2, %1  : i32
    %4 = llvm.trunc %3 : i32 to i8
    llvm.return %4 : i8
  }]

def test86_before := [llvmfunc|
  llvm.func @test86(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.sext %arg0 : i16 to i32
    %2 = llvm.ashr %1, %0  : i32
    %3 = llvm.trunc %2 : i32 to i16
    llvm.return %3 : i16
  }]

def test87_before := [llvmfunc|
  llvm.func @test87(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.sext %arg0 : i16 to i32
    %2 = llvm.mul %1, %0 overflow<nsw>  : i32
    %3 = llvm.ashr %2, %0  : i32
    %4 = llvm.trunc %3 : i32 to i16
    llvm.return %4 : i16
  }]

def test88_before := [llvmfunc|
  llvm.func @test88(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(18 : i32) : i32
    %1 = llvm.sext %arg0 : i16 to i32
    %2 = llvm.ashr %1, %0  : i32
    %3 = llvm.trunc %2 : i32 to i16
    llvm.return %3 : i16
  }]

def PR21388_before := [llvmfunc|
  llvm.func @PR21388(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "slt" %arg0, %0 : !llvm.ptr
    %2 = llvm.sext %1 : i1 to i32
    llvm.return %2 : i32
  }]

def sitofp_zext_before := [llvmfunc|
  llvm.func @sitofp_zext(%arg0: i16) -> f32 {
    %0 = llvm.zext %arg0 : i16 to i32
    %1 = llvm.sitofp %0 : i32 to f32
    llvm.return %1 : f32
  }]

def PR23309_before := [llvmfunc|
  llvm.func @PR23309(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-4 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.sub %1, %arg1 overflow<nsw>  : i32
    %3 = llvm.trunc %2 : i32 to i1
    llvm.return %3 : i1
  }]

def PR23309v2_before := [llvmfunc|
  llvm.func @PR23309v2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-4 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.add %1, %arg1 overflow<nuw>  : i32
    %3 = llvm.trunc %2 : i32 to i1
    llvm.return %3 : i1
  }]

def PR24763_before := [llvmfunc|
  llvm.func @PR24763(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.lshr %1, %0  : i32
    %3 = llvm.trunc %2 : i32 to i16
    llvm.return %3 : i16
  }]

def PR28745_before := [llvmfunc|
  llvm.func @PR28745() -> i64 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<1> : vector<1xi32>) : vector<1xi32>
    %2 = llvm.bitcast %1 : vector<1xi32> to vector<2xi16>
    %3 = llvm.extractelement %2[%0 : i32] : vector<2xi16>
    %4 = llvm.mlir.constant(0 : i16) : i16
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.mlir.undef : !llvm.struct<(i32)>
    %7 = llvm.insertvalue %5, %6[0] : !llvm.struct<(i32)> 
    %8 = llvm.mlir.undef : !llvm.struct<(i32)>
    %9 = llvm.insertvalue %0, %8[0] : !llvm.struct<(i32)> 
    %10 = llvm.icmp "eq" %3, %4 : i16
    %11 = llvm.select %10, %7, %9 : i1, !llvm.struct<(i32)>
    %12 = llvm.extractvalue %11[0] : !llvm.struct<(i32)> 
    %13 = llvm.zext %12 : i32 to i64
    llvm.return %13 : i64
  }]

def test89_before := [llvmfunc|
  llvm.func @test89() -> i32 {
    %0 = llvm.mlir.poison : i16
    %1 = llvm.mlir.constant(6 : i16) : i16
    %2 = llvm.mlir.undef : vector<2xi16>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi16>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi16>
    %7 = llvm.bitcast %6 : vector<2xi16> to i32
    llvm.return %7 : i32
  }]

def test90_before := [llvmfunc|
  llvm.func @test90() -> vector<2xi32> {
    %0 = llvm.mlir.constant(1.000000e+00 : f16) : f16
    %1 = llvm.mlir.poison : f16
    %2 = llvm.mlir.undef : vector<4xf16>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<4xf16>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<4xf16>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %1, %6[%7 : i32] : vector<4xf16>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xf16>
    %11 = llvm.bitcast %10 : vector<4xf16> to vector<2xi32>
    llvm.return %11 : vector<2xi32>
  }]

def test91_before := [llvmfunc|
  llvm.func @test91(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(48 : i96) : i96
    %1 = llvm.sext %arg0 : i64 to i96
    %2 = llvm.lshr %1, %0  : i96
    %3 = llvm.trunc %2 : i96 to i64
    llvm.return %3 : i64
  }]

def test92_before := [llvmfunc|
  llvm.func @test92(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(32 : i96) : i96
    %1 = llvm.sext %arg0 : i64 to i96
    %2 = llvm.lshr %1, %0  : i96
    %3 = llvm.trunc %2 : i96 to i64
    llvm.return %3 : i64
  }]

def test93_before := [llvmfunc|
  llvm.func @test93(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i96) : i96
    %1 = llvm.sext %arg0 : i32 to i96
    %2 = llvm.lshr %1, %0  : i96
    %3 = llvm.trunc %2 : i96 to i32
    llvm.return %3 : i32
  }]

def trunc_lshr_sext_before := [llvmfunc|
  llvm.func @trunc_lshr_sext(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.lshr %1, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    llvm.return %3 : i8
  }]

def trunc_lshr_sext_exact_before := [llvmfunc|
  llvm.func @trunc_lshr_sext_exact(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.lshr %1, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    llvm.return %3 : i8
  }]

def trunc_lshr_sext_uniform_before := [llvmfunc|
  llvm.func @trunc_lshr_sext_uniform(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<6> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi8> to vector<2xi32>
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def trunc_lshr_sext_uniform_poison_before := [llvmfunc|
  llvm.func @trunc_lshr_sext_uniform_poison(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.sext %arg0 : vector<2xi8> to vector<2xi32>
    %8 = llvm.lshr %7, %6  : vector<2xi32>
    %9 = llvm.trunc %8 : vector<2xi32> to vector<2xi8>
    llvm.return %9 : vector<2xi8>
  }]

def trunc_lshr_sext_nonuniform_before := [llvmfunc|
  llvm.func @trunc_lshr_sext_nonuniform(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[6, 2]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi8> to vector<2xi32>
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def trunc_lshr_sext_nonuniform_poison_before := [llvmfunc|
  llvm.func @trunc_lshr_sext_nonuniform_poison(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(6 : i32) : i32
    %3 = llvm.mlir.undef : vector<3xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<3xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<3xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<3xi32>
    %10 = llvm.sext %arg0 : vector<3xi8> to vector<3xi32>
    %11 = llvm.lshr %10, %9  : vector<3xi32>
    %12 = llvm.trunc %11 : vector<3xi32> to vector<3xi8>
    llvm.return %12 : vector<3xi8>
  }]

def trunc_lshr_sext_uses1_before := [llvmfunc|
  llvm.func @trunc_lshr_sext_uses1(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<6> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi8> to vector<2xi32>
    llvm.call @use_v2i32(%1) : (vector<2xi32>) -> ()
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def trunc_lshr_sext_uses2_before := [llvmfunc|
  llvm.func @trunc_lshr_sext_uses2(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.lshr %1, %0  : i32
    llvm.call @use_i32(%2) : (i32) -> ()
    %3 = llvm.trunc %2 : i32 to i8
    llvm.return %3 : i8
  }]

def trunc_lshr_sext_uses3_before := [llvmfunc|
  llvm.func @trunc_lshr_sext_uses3(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<6> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi8> to vector<2xi32>
    llvm.call @use_v2i32(%1) : (vector<2xi32>) -> ()
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    llvm.call @use_v2i32(%2) : (vector<2xi32>) -> ()
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def trunc_lshr_overshift_sext_before := [llvmfunc|
  llvm.func @trunc_lshr_overshift_sext(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi8> to vector<2xi32>
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def trunc_lshr_overshift_sext_uses1_before := [llvmfunc|
  llvm.func @trunc_lshr_overshift_sext_uses1(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    llvm.call @use_i32(%1) : (i32) -> ()
    %2 = llvm.lshr %1, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    llvm.return %3 : i8
  }]

def trunc_lshr_overshift_sext_uses2_before := [llvmfunc|
  llvm.func @trunc_lshr_overshift_sext_uses2(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi8> to vector<2xi32>
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    llvm.call @use_v2i32(%2) : (vector<2xi32>) -> ()
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def trunc_lshr_overshift_sext_uses3_before := [llvmfunc|
  llvm.func @trunc_lshr_overshift_sext_uses3(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    llvm.call @use_i32(%1) : (i32) -> ()
    %2 = llvm.lshr %1, %0  : i32
    llvm.call @use_i32(%2) : (i32) -> ()
    %3 = llvm.trunc %2 : i32 to i8
    llvm.return %3 : i8
  }]

def trunc_lshr_sext_wide_input_before := [llvmfunc|
  llvm.func @trunc_lshr_sext_wide_input(%arg0: i16) -> i8 {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.sext %arg0 : i16 to i32
    %2 = llvm.lshr %1, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    llvm.return %3 : i8
  }]

def trunc_lshr_sext_wide_input_exact_before := [llvmfunc|
  llvm.func @trunc_lshr_sext_wide_input_exact(%arg0: i16) -> i8 {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.sext %arg0 : i16 to i32
    %2 = llvm.lshr %1, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    llvm.return %3 : i8
  }]

def trunc_lshr_sext_wide_input_uses1_before := [llvmfunc|
  llvm.func @trunc_lshr_sext_wide_input_uses1(%arg0: vector<2xi16>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<9> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi16> to vector<2xi32>
    llvm.call @use_v2i32(%1) : (vector<2xi32>) -> ()
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def trunc_lshr_sext_wide_input_uses2_before := [llvmfunc|
  llvm.func @trunc_lshr_sext_wide_input_uses2(%arg0: i16) -> i8 {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.sext %arg0 : i16 to i32
    %2 = llvm.lshr %1, %0  : i32
    llvm.call @use_i32(%2) : (i32) -> ()
    %3 = llvm.trunc %2 : i32 to i8
    llvm.return %3 : i8
  }]

def trunc_lshr_sext_wide_input_uses3_before := [llvmfunc|
  llvm.func @trunc_lshr_sext_wide_input_uses3(%arg0: vector<2xi16>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<9> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi16> to vector<2xi32>
    llvm.call @use_v2i32(%1) : (vector<2xi32>) -> ()
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    llvm.call @use_v2i32(%2) : (vector<2xi32>) -> ()
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def trunc_lshr_overshift_wide_input_sext_before := [llvmfunc|
  llvm.func @trunc_lshr_overshift_wide_input_sext(%arg0: vector<2xi16>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi16> to vector<2xi32>
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def trunc_lshr_overshift_sext_wide_input_uses1_before := [llvmfunc|
  llvm.func @trunc_lshr_overshift_sext_wide_input_uses1(%arg0: i16) -> i8 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.sext %arg0 : i16 to i32
    llvm.call @use_i32(%1) : (i32) -> ()
    %2 = llvm.lshr %1, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    llvm.return %3 : i8
  }]

def trunc_lshr_overshift_sext_wide_input_uses2_before := [llvmfunc|
  llvm.func @trunc_lshr_overshift_sext_wide_input_uses2(%arg0: vector<2xi16>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi16> to vector<2xi32>
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    llvm.call @use_v2i32(%2) : (vector<2xi32>) -> ()
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def trunc_lshr_overshift_sext_wide_input_uses3_before := [llvmfunc|
  llvm.func @trunc_lshr_overshift_sext_wide_input_uses3(%arg0: i16) -> i8 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.sext %arg0 : i16 to i32
    llvm.call @use_i32(%1) : (i32) -> ()
    %2 = llvm.lshr %1, %0  : i32
    llvm.call @use_i32(%2) : (i32) -> ()
    %3 = llvm.trunc %2 : i32 to i8
    llvm.return %3 : i8
  }]

def trunc_lshr_sext_narrow_input_before := [llvmfunc|
  llvm.func @trunc_lshr_sext_narrow_input(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.lshr %1, %0  : i32
    %3 = llvm.trunc %2 : i32 to i16
    llvm.return %3 : i16
  }]

def trunc_lshr_sext_narrow_input_uses1_before := [llvmfunc|
  llvm.func @trunc_lshr_sext_narrow_input_uses1(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<6> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi8> to vector<2xi32>
    llvm.call @use_v2i32(%1) : (vector<2xi32>) -> ()
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

def trunc_lshr_sext_narrow_input_uses2_before := [llvmfunc|
  llvm.func @trunc_lshr_sext_narrow_input_uses2(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.lshr %1, %0  : i32
    llvm.call @use_i32(%2) : (i32) -> ()
    %3 = llvm.trunc %2 : i32 to i16
    llvm.return %3 : i16
  }]

def trunc_lshr_sext_narrow_input_uses3_before := [llvmfunc|
  llvm.func @trunc_lshr_sext_narrow_input_uses3(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<6> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi8> to vector<2xi32>
    llvm.call @use_v2i32(%1) : (vector<2xi32>) -> ()
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    llvm.call @use_v2i32(%2) : (vector<2xi32>) -> ()
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

def trunc_lshr_overshift_narrow_input_sext_before := [llvmfunc|
  llvm.func @trunc_lshr_overshift_narrow_input_sext(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi8> to vector<2xi32>
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

def trunc_lshr_overshift_sext_narrow_input_uses1_before := [llvmfunc|
  llvm.func @trunc_lshr_overshift_sext_narrow_input_uses1(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    llvm.call @use_i32(%1) : (i32) -> ()
    %2 = llvm.lshr %1, %0  : i32
    %3 = llvm.trunc %2 : i32 to i16
    llvm.return %3 : i16
  }]

def trunc_lshr_overshift_sext_narrow_input_uses2_before := [llvmfunc|
  llvm.func @trunc_lshr_overshift_sext_narrow_input_uses2(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi8> to vector<2xi32>
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    llvm.call @use_v2i32(%2) : (vector<2xi32>) -> ()
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

def trunc_lshr_overshift_sext_narrow_input_uses3_before := [llvmfunc|
  llvm.func @trunc_lshr_overshift_sext_narrow_input_uses3(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    llvm.call @use_i32(%1) : (i32) -> ()
    %2 = llvm.lshr %1, %0  : i32
    llvm.call @use_i32(%2) : (i32) -> ()
    %3 = llvm.trunc %2 : i32 to i16
    llvm.return %3 : i16
  }]

def trunc_lshr_overshift2_sext_before := [llvmfunc|
  llvm.func @trunc_lshr_overshift2_sext(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<25> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi8> to vector<2xi32>
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def trunc_lshr_overshift2_sext_uses1_before := [llvmfunc|
  llvm.func @trunc_lshr_overshift2_sext_uses1(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(25 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    llvm.call @use_i32(%1) : (i32) -> ()
    %2 = llvm.lshr %1, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    llvm.return %3 : i8
  }]

def trunc_lshr_overshift2_sext_uses2_before := [llvmfunc|
  llvm.func @trunc_lshr_overshift2_sext_uses2(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<25> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi8> to vector<2xi32>
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    llvm.call @use_v2i32(%2) : (vector<2xi32>) -> ()
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def trunc_lshr_overshift2_sext_uses3_before := [llvmfunc|
  llvm.func @trunc_lshr_overshift2_sext_uses3(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(25 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    llvm.call @use_i32(%1) : (i32) -> ()
    %2 = llvm.lshr %1, %0  : i32
    llvm.call @use_i32(%2) : (i32) -> ()
    %3 = llvm.trunc %2 : i32 to i8
    llvm.return %3 : i8
  }]

def trunc_lshr_zext_before := [llvmfunc|
  llvm.func @trunc_lshr_zext(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.lshr %1, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    llvm.return %3 : i8
  }]

def trunc_lshr_zext_exact_before := [llvmfunc|
  llvm.func @trunc_lshr_zext_exact(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.lshr %1, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    llvm.return %3 : i8
  }]

def trunc_lshr_zext_uniform_before := [llvmfunc|
  llvm.func @trunc_lshr_zext_uniform(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<6> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.zext %arg0 : vector<2xi8> to vector<2xi32>
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def trunc_lshr_zext_uniform_poison_before := [llvmfunc|
  llvm.func @trunc_lshr_zext_uniform_poison(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.zext %arg0 : vector<2xi8> to vector<2xi32>
    %8 = llvm.lshr %7, %6  : vector<2xi32>
    %9 = llvm.trunc %8 : vector<2xi32> to vector<2xi8>
    llvm.return %9 : vector<2xi8>
  }]

def trunc_lshr_zext_nonuniform_before := [llvmfunc|
  llvm.func @trunc_lshr_zext_nonuniform(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[6, 2]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.zext %arg0 : vector<2xi8> to vector<2xi32>
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def trunc_lshr_zext_nonuniform_poison_before := [llvmfunc|
  llvm.func @trunc_lshr_zext_nonuniform_poison(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(6 : i32) : i32
    %3 = llvm.mlir.undef : vector<3xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<3xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<3xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<3xi32>
    %10 = llvm.zext %arg0 : vector<3xi8> to vector<3xi32>
    %11 = llvm.lshr %10, %9  : vector<3xi32>
    %12 = llvm.trunc %11 : vector<3xi32> to vector<3xi8>
    llvm.return %12 : vector<3xi8>
  }]

def trunc_lshr_zext_uses1_before := [llvmfunc|
  llvm.func @trunc_lshr_zext_uses1(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<6> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.zext %arg0 : vector<2xi8> to vector<2xi32>
    llvm.call @use_v2i32(%1) : (vector<2xi32>) -> ()
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def pr33078_1_before := [llvmfunc|
  llvm.func @pr33078_1(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.sext %arg0 : i8 to i16
    %2 = llvm.lshr %1, %0  : i16
    %3 = llvm.trunc %2 : i16 to i8
    llvm.return %3 : i8
  }]

def pr33078_2_before := [llvmfunc|
  llvm.func @pr33078_2(%arg0: i8) -> i12 {
    %0 = llvm.mlir.constant(4 : i16) : i16
    %1 = llvm.sext %arg0 : i8 to i16
    %2 = llvm.lshr %1, %0  : i16
    %3 = llvm.trunc %2 : i16 to i12
    llvm.return %3 : i12
  }]

def pr33078_3_before := [llvmfunc|
  llvm.func @pr33078_3(%arg0: i8) -> i4 {
    %0 = llvm.mlir.constant(12 : i16) : i16
    %1 = llvm.sext %arg0 : i8 to i16
    %2 = llvm.lshr %1, %0  : i16
    %3 = llvm.trunc %2 : i16 to i4
    llvm.return %3 : i4
  }]

def pr33078_4_before := [llvmfunc|
  llvm.func @pr33078_4(%arg0: i3) -> i8 {
    %0 = llvm.mlir.constant(13 : i16) : i16
    %1 = llvm.sext %arg0 : i3 to i16
    %2 = llvm.lshr %1, %0  : i16
    %3 = llvm.trunc %2 : i16 to i8
    llvm.return %3 : i8
  }]

def test94_before := [llvmfunc|
  llvm.func @test94(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.sext %2 : i1 to i8
    %4 = llvm.xor %3, %1  : i8
    %5 = llvm.sext %4 : i8 to i64
    llvm.return %5 : i64
  }]

def test95_before := [llvmfunc|
  llvm.func @test95(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.constant(40 : i8) : i8
    %3 = llvm.trunc %arg0 : i32 to i8
    %4 = llvm.lshr %3, %0  : i8
    %5 = llvm.and %4, %1  : i8
    %6 = llvm.or %5, %2  : i8
    %7 = llvm.zext %6 : i8 to i32
    llvm.return %7 : i32
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i32) -> i32 {
    llvm.return %arg0 : i32
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i8) -> i64 {
    %0 = llvm.zext %arg0 : i8 to i64
    llvm.return %0 : i64
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(255 : i64) : i64
    %1 = llvm.and %arg0, %0  : i64
    llvm.return %1 : i64
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i32
    %1 = llvm.zext %0 : i1 to i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5(%arg0: i1) -> i32 {
    %0 = llvm.zext %arg0 : i1 to i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
def test6_combined := [llvmfunc|
  llvm.func @test6(%arg0: i64) -> i32 {
    %0 = llvm.trunc %arg0 : i64 to i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
def test7_combined := [llvmfunc|
  llvm.func @test7(%arg0: i1) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    llvm.return %0 : i64
  }]

theorem inst_combine_test7   : test7_before  ⊑  test7_combined := by
  unfold test7_before test7_combined
  simp_alive_peephole
  sorry
def test8_combined := [llvmfunc|
  llvm.func @test8(%arg0: i8) -> i64 {
    %0 = llvm.sext %arg0 : i8 to i64
    llvm.return %0 : i64
  }]

theorem inst_combine_test8   : test8_before  ⊑  test8_combined := by
  unfold test8_before test8_combined
  simp_alive_peephole
  sorry
def test9_combined := [llvmfunc|
  llvm.func @test9(%arg0: i16) -> i16 {
    llvm.return %arg0 : i16
  }]

theorem inst_combine_test9   : test9_before  ⊑  test9_combined := by
  unfold test9_before test9_combined
  simp_alive_peephole
  sorry
def test10_combined := [llvmfunc|
  llvm.func @test10(%arg0: i16) -> i16 {
    llvm.return %arg0 : i16
  }]

theorem inst_combine_test10   : test10_before  ⊑  test10_combined := by
  unfold test10_before test10_combined
  simp_alive_peephole
  sorry
def test11_combined := [llvmfunc|
  llvm.func @test11(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(5 : i32) : i32
    llvm.call @varargs(%0, %arg0) vararg(!llvm.func<void (i32, ...)>) : (i32, !llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_test11   : test11_before  ⊑  test11_combined := by
  unfold test11_before test11_combined
  simp_alive_peephole
  sorry
def test_invoke_vararg_cast_combined := [llvmfunc|
  llvm.func @test_invoke_vararg_cast(%arg0: !llvm.ptr, %arg1: !llvm.ptr) attributes {personality = @__gxx_personality_v0} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    llvm.invoke @varargs(%0, %arg1, %arg0) to ^bb1 unwind ^bb2 vararg(!llvm.func<void (i32, ...)>) : (i32, !llvm.ptr, !llvm.ptr) -> ()
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    %1 = llvm.landingpad cleanup : !llvm.struct<(ptr, i32)>
    llvm.return
  }]

theorem inst_combine_test_invoke_vararg_cast   : test_invoke_vararg_cast_before  ⊑  test_invoke_vararg_cast_combined := by
  unfold test_invoke_vararg_cast_before test_invoke_vararg_cast_combined
  simp_alive_peephole
  sorry
def test13_combined := [llvmfunc|
  llvm.func @test13(%arg0: i64) -> !llvm.ptr {
    %0 = llvm.mlir.addressof @inbuf : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.getelementptr %0[%1, %arg0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i8>
    llvm.return %2 : !llvm.ptr
  }]

theorem inst_combine_test13   : test13_before  ⊑  test13_combined := by
  unfold test13_before test13_combined
  simp_alive_peephole
  sorry
def test14_combined := [llvmfunc|
  llvm.func @test14(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_test14   : test14_before  ⊑  test14_combined := by
  unfold test14_before test14_combined
  simp_alive_peephole
  sorry
def test16_combined := [llvmfunc|
  llvm.func @test16(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    llvm.return %1 : i1
  }]

theorem inst_combine_test16   : test16_before  ⊑  test16_combined := by
  unfold test16_before test16_combined
  simp_alive_peephole
  sorry
def test17_combined := [llvmfunc|
  llvm.func @test17(%arg0: i1) -> i16 {
    %0 = llvm.zext %arg0 : i1 to i16
    llvm.return %0 : i16
  }]

theorem inst_combine_test17   : test17_before  ⊑  test17_combined := by
  unfold test17_before test17_combined
  simp_alive_peephole
  sorry
def test18_combined := [llvmfunc|
  llvm.func @test18(%arg0: i8) -> i16 {
    %0 = llvm.sext %arg0 : i8 to i16
    llvm.return %0 : i16
  }]

theorem inst_combine_test18   : test18_before  ⊑  test18_combined := by
  unfold test18_before test18_combined
  simp_alive_peephole
  sorry
def test19_combined := [llvmfunc|
  llvm.func @test19(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12345 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_test19   : test19_before  ⊑  test19_combined := by
  unfold test19_before test19_combined
  simp_alive_peephole
  sorry
def test19vec_combined := [llvmfunc|
  llvm.func @test19vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[12345, 2147483647]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "slt" %arg0, %0 : vector<2xi32>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_test19vec   : test19vec_before  ⊑  test19vec_combined := by
  unfold test19vec_before test19vec_combined
  simp_alive_peephole
  sorry
def test19vec2_combined := [llvmfunc|
  llvm.func @test19vec2(%arg0: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<3xi1>) : vector<3xi1>
    %2 = llvm.xor %arg0, %1  : vector<3xi1>
    llvm.return %2 : vector<3xi1>
  }]

theorem inst_combine_test19vec2   : test19vec2_before  ⊑  test19vec2_combined := by
  unfold test19vec2_before test19vec2_combined
  simp_alive_peephole
  sorry
def test20_combined := [llvmfunc|
  llvm.func @test20(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test20   : test20_before  ⊑  test20_combined := by
  unfold test20_before test20_combined
  simp_alive_peephole
  sorry
def test21_combined := [llvmfunc|
  llvm.func @test21(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test21   : test21_before  ⊑  test21_combined := by
  unfold test21_before test21_combined
  simp_alive_peephole
  sorry
def test22_combined := [llvmfunc|
  llvm.func @test22(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.shl %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test22   : test22_before  ⊑  test22_combined := by
  unfold test22_before test22_combined
  simp_alive_peephole
  sorry
def test23_combined := [llvmfunc|
  llvm.func @test23(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(65535 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test23   : test23_before  ⊑  test23_combined := by
  unfold test23_before test23_combined
  simp_alive_peephole
  sorry
def test24_combined := [llvmfunc|
  llvm.func @test24(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test24   : test24_before  ⊑  test24_combined := by
  unfold test24_before test24_combined
  simp_alive_peephole
  sorry
def test26_combined := [llvmfunc|
  llvm.func @test26(%arg0: f32) -> i32 {
    %0 = llvm.fptosi %arg0 : f32 to i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test26   : test26_before  ⊑  test26_combined := by
  unfold test26_before test26_combined
  simp_alive_peephole
  sorry
def test27_combined := [llvmfunc|
  llvm.func @test27(%arg0: !llvm.ptr) -> !llvm.ptr {
    llvm.return %arg0 : !llvm.ptr
  }]

theorem inst_combine_test27   : test27_before  ⊑  test27_combined := by
  unfold test27_before test27_combined
  simp_alive_peephole
  sorry
def test28_combined := [llvmfunc|
  llvm.func @test28(%arg0: !llvm.ptr) -> !llvm.ptr {
    llvm.return %arg0 : !llvm.ptr
  }]

theorem inst_combine_test28   : test28_before  ⊑  test28_combined := by
  unfold test28_before test28_combined
  simp_alive_peephole
  sorry
def test29_combined := [llvmfunc|
  llvm.func @test29(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.and %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test29   : test29_before  ⊑  test29_combined := by
  unfold test29_before test29_combined
  simp_alive_peephole
  sorry
def test30_combined := [llvmfunc|
  llvm.func @test30(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.xor %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test30   : test30_before  ⊑  test30_combined := by
  unfold test30_before test30_combined
  simp_alive_peephole
  sorry
def test31_combined := [llvmfunc|
  llvm.func @test31(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(42 : i64) : i64
    %1 = llvm.mlir.constant(10 : i64) : i64
    %2 = llvm.and %arg0, %0  : i64
    %3 = llvm.icmp "eq" %2, %1 : i64
    llvm.return %3 : i1
  }]

theorem inst_combine_test31   : test31_before  ⊑  test31_combined := by
  unfold test31_before test31_combined
  simp_alive_peephole
  sorry
def test31vec_combined := [llvmfunc|
  llvm.func @test31vec(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<10> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %3 = llvm.and %2, %0  : vector<2xi32>
    %4 = llvm.icmp "eq" %3, %1 : vector<2xi32>
    llvm.return %4 : vector<2xi1>
  }]

theorem inst_combine_test31vec   : test31vec_before  ⊑  test31vec_combined := by
  unfold test31vec_before test31vec_combined
  simp_alive_peephole
  sorry
def test32vec_combined := [llvmfunc|
  llvm.func @test32vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<10> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.and %arg0, %0  : vector<2xi8>
    %3 = llvm.icmp "eq" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_test32vec   : test32vec_before  ⊑  test32vec_combined := by
  unfold test32vec_before test32vec_combined
  simp_alive_peephole
  sorry
def test33_combined := [llvmfunc|
  llvm.func @test33(%arg0: i32) -> i32 {
    llvm.return %arg0 : i32
  }]

theorem inst_combine_test33   : test33_before  ⊑  test33_combined := by
  unfold test33_before test33_combined
  simp_alive_peephole
  sorry
def test34_combined := [llvmfunc|
  llvm.func @test34(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.lshr %arg0, %0  : i16
    llvm.return %1 : i16
  }]

theorem inst_combine_test34   : test34_before  ⊑  test34_combined := by
  unfold test34_before test34_combined
  simp_alive_peephole
  sorry
def test35_combined := [llvmfunc|
  llvm.func @test35(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.lshr %arg0, %0  : i16
    llvm.return %1 : i16
  }]

theorem inst_combine_test35   : test35_before  ⊑  test35_combined := by
  unfold test35_before test35_combined
  simp_alive_peephole
  sorry
def test36_combined := [llvmfunc|
  llvm.func @test36(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_test36   : test36_before  ⊑  test36_combined := by
  unfold test36_before test36_combined
  simp_alive_peephole
  sorry
def test36vec_combined := [llvmfunc|
  llvm.func @test36vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "sgt" %arg0, %0 : vector<2xi32>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_test36vec   : test36vec_before  ⊑  test36vec_combined := by
  unfold test36vec_before test36vec_combined
  simp_alive_peephole
  sorry
def test37_combined := [llvmfunc|
  llvm.func @test37(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test37   : test37_before  ⊑  test37_combined := by
  unfold test37_before test37_combined
  simp_alive_peephole
  sorry
def test38_combined := [llvmfunc|
  llvm.func @test38(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    %2 = llvm.zext %1 : i1 to i64
    llvm.return %2 : i64
  }]

theorem inst_combine_test38   : test38_before  ⊑  test38_combined := by
  unfold test38_before test38_combined
  simp_alive_peephole
  sorry
def test39_combined := [llvmfunc|
  llvm.func @test39(%arg0: i16) -> i16 {
    %0 = llvm.intr.bswap(%arg0)  : (i16) -> i16
    llvm.return %0 : i16
  }]

theorem inst_combine_test39   : test39_before  ⊑  test39_combined := by
  unfold test39_before test39_combined
  simp_alive_peephole
  sorry
def test40_combined := [llvmfunc|
  llvm.func @test40(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(9 : i16) : i16
    %1 = llvm.mlir.constant(8 : i16) : i16
    %2 = llvm.lshr %arg0, %0  : i16
    %3 = llvm.shl %arg0, %1  : i16
    %4 = llvm.or %2, %3  : i16
    llvm.return %4 : i16
  }]

theorem inst_combine_test40   : test40_before  ⊑  test40_combined := by
  unfold test40_before test40_combined
  simp_alive_peephole
  sorry
def test40vec_combined := [llvmfunc|
  llvm.func @test40vec(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<9> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(dense<8> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.lshr %arg0, %0  : vector<2xi16>
    %3 = llvm.shl %arg0, %1  : vector<2xi16>
    %4 = llvm.or %2, %3  : vector<2xi16>
    llvm.return %4 : vector<2xi16>
  }]

theorem inst_combine_test40vec   : test40vec_before  ⊑  test40vec_combined := by
  unfold test40vec_before test40vec_combined
  simp_alive_peephole
  sorry
def test40vec_nonuniform_combined := [llvmfunc|
  llvm.func @test40vec_nonuniform(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[9, 10]> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(dense<[8, 9]> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.lshr %arg0, %0  : vector<2xi16>
    %3 = llvm.shl %arg0, %1  : vector<2xi16>
    %4 = llvm.or %2, %3  : vector<2xi16>
    llvm.return %4 : vector<2xi16>
  }]

theorem inst_combine_test40vec_nonuniform   : test40vec_nonuniform_before  ⊑  test40vec_nonuniform_combined := by
  unfold test40vec_nonuniform_before test40vec_nonuniform_combined
  simp_alive_peephole
  sorry
def test40vec_poison_combined := [llvmfunc|
  llvm.func @test40vec_poison(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.poison : i16
    %1 = llvm.mlir.constant(9 : i16) : i16
    %2 = llvm.mlir.undef : vector<2xi16>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi16>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi16>
    %7 = llvm.mlir.constant(8 : i16) : i16
    %8 = llvm.mlir.undef : vector<2xi16>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %7, %8[%9 : i32] : vector<2xi16>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<2xi16>
    %13 = llvm.lshr %arg0, %6  : vector<2xi16>
    %14 = llvm.shl %arg0, %12  : vector<2xi16>
    %15 = llvm.or %13, %14  : vector<2xi16>
    llvm.return %15 : vector<2xi16>
  }]

theorem inst_combine_test40vec_poison   : test40vec_poison_before  ⊑  test40vec_poison_combined := by
  unfold test40vec_poison_before test40vec_poison_combined
  simp_alive_peephole
  sorry
def test41_combined := [llvmfunc|
  llvm.func @test41(%arg0: !llvm.ptr) -> !llvm.ptr {
    llvm.return %arg0 : !llvm.ptr
  }]

theorem inst_combine_test41   : test41_before  ⊑  test41_combined := by
  unfold test41_before test41_combined
  simp_alive_peephole
  sorry
def test41_addrspacecast_smaller_combined := [llvmfunc|
  llvm.func @test41_addrspacecast_smaller(%arg0: !llvm.ptr) -> !llvm.ptr<1> {
    %0 = llvm.addrspacecast %arg0 : !llvm.ptr to !llvm.ptr<1>
    llvm.return %0 : !llvm.ptr<1>
  }]

theorem inst_combine_test41_addrspacecast_smaller   : test41_addrspacecast_smaller_before  ⊑  test41_addrspacecast_smaller_combined := by
  unfold test41_addrspacecast_smaller_before test41_addrspacecast_smaller_combined
  simp_alive_peephole
  sorry
def test41_addrspacecast_larger_combined := [llvmfunc|
  llvm.func @test41_addrspacecast_larger(%arg0: !llvm.ptr<1>) -> !llvm.ptr {
    %0 = llvm.addrspacecast %arg0 : !llvm.ptr<1> to !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_test41_addrspacecast_larger   : test41_addrspacecast_larger_before  ⊑  test41_addrspacecast_larger_combined := by
  unfold test41_addrspacecast_larger_before test41_addrspacecast_larger_combined
  simp_alive_peephole
  sorry
def test42_combined := [llvmfunc|
  llvm.func @test42(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test42   : test42_before  ⊑  test42_combined := by
  unfold test42_before test42_combined
  simp_alive_peephole
  sorry
def test43(%arg0: i8 {llvm.zeroext}) -> _combined := [llvmfunc|
  llvm.func @test43(%arg0: i8 {llvm.zeroext}) -> (i64 {llvm.zeroext}) {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.zext %arg0 : i8 to i64
    %2 = llvm.add %1, %0 overflow<nsw>  : i64
    llvm.return %2 : i64
  }]

theorem inst_combine_test43(%arg0: i8 {llvm.zeroext}) ->    : test43(%arg0: i8 {llvm.zeroext}) -> _before  ⊑  test43(%arg0: i8 {llvm.zeroext}) -> _combined := by
  unfold test43(%arg0: i8 {llvm.zeroext}) -> _before test43(%arg0: i8 {llvm.zeroext}) -> _combined
  simp_alive_peephole
  sorry
def test44_combined := [llvmfunc|
  llvm.func @test44(%arg0: i8) -> i64 {
    %0 = llvm.mlir.constant(1234 : i64) : i64
    %1 = llvm.zext %arg0 : i8 to i64
    %2 = llvm.or %1, %0  : i64
    llvm.return %2 : i64
  }]

theorem inst_combine_test44   : test44_before  ⊑  test44_combined := by
  unfold test44_before test44_combined
  simp_alive_peephole
  sorry
def test45_combined := [llvmfunc|
  llvm.func @test45(%arg0: i8, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    %1 = llvm.sext %arg0 : i8 to i64
    %2 = llvm.or %1, %arg1  : i64
    %3 = llvm.and %2, %0  : i64
    llvm.return %3 : i64
  }]

theorem inst_combine_test45   : test45_before  ⊑  test45_combined := by
  unfold test45_before test45_combined
  simp_alive_peephole
  sorry
def test46_combined := [llvmfunc|
  llvm.func @test46(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(8 : i64) : i64
    %1 = llvm.mlir.constant(10752 : i64) : i64
    %2 = llvm.shl %arg0, %0  : i64
    %3 = llvm.and %2, %1  : i64
    llvm.return %3 : i64
  }]

theorem inst_combine_test46   : test46_before  ⊑  test46_combined := by
  unfold test46_before test46_combined
  simp_alive_peephole
  sorry
def test46vec_combined := [llvmfunc|
  llvm.func @test46vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<10752> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %3 = llvm.shl %2, %0  : vector<2xi32>
    %4 = llvm.and %3, %1  : vector<2xi32>
    %5 = llvm.zext %4 : vector<2xi32> to vector<2xi64>
    llvm.return %5 : vector<2xi64>
  }]

theorem inst_combine_test46vec   : test46vec_before  ⊑  test46vec_combined := by
  unfold test46vec_before test46vec_combined
  simp_alive_peephole
  sorry
def test47_combined := [llvmfunc|
  llvm.func @test47(%arg0: i8) -> i64 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(4294967295 : i64) : i64
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.sext %2 : i8 to i64
    %4 = llvm.and %3, %1  : i64
    llvm.return %4 : i64
  }]

theorem inst_combine_test47   : test47_before  ⊑  test47_combined := by
  unfold test47_before test47_combined
  simp_alive_peephole
  sorry
def test48_combined := [llvmfunc|
  llvm.func @test48(%arg0: i8, %arg1: i8) -> i64 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.shl %1, %0 overflow<nsw, nuw>  : i32
    %3 = llvm.or %2, %1  : i32
    %4 = llvm.zext %3 : i32 to i64
    llvm.return %4 : i64
  }]

theorem inst_combine_test48   : test48_before  ⊑  test48_combined := by
  unfold test48_before test48_combined
  simp_alive_peephole
  sorry
def test49_combined := [llvmfunc|
  llvm.func @test49(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.shl %arg0, %0  : i64
    %3 = llvm.ashr %2, %0  : i64
    %4 = llvm.or %3, %1  : i64
    llvm.return %4 : i64
  }]

theorem inst_combine_test49   : test49_before  ⊑  test49_combined := by
  unfold test49_before test49_combined
  simp_alive_peephole
  sorry
def test50_combined := [llvmfunc|
  llvm.func @test50(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(30 : i64) : i64
    %1 = llvm.mlir.constant(-4294967296 : i64) : i64
    %2 = llvm.mlir.constant(32 : i64) : i64
    %3 = llvm.shl %arg0, %0  : i64
    %4 = llvm.add %3, %1  : i64
    %5 = llvm.ashr %4, %2  : i64
    llvm.return %5 : i64
  }]

theorem inst_combine_test50   : test50_before  ⊑  test50_combined := by
  unfold test50_before test50_combined
  simp_alive_peephole
  sorry
def test51_combined := [llvmfunc|
  llvm.func @test51(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.mlir.constant(4294967294 : i64) : i64
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(32 : i64) : i64
    %3 = llvm.and %arg0, %0  : i64
    %4 = llvm.xor %arg1, %1  : i1
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.or %3, %5  : i64
    %7 = llvm.shl %6, %2 overflow<nuw>  : i64
    %8 = llvm.ashr %7, %2  : i64
    llvm.return %8 : i64
  }]

theorem inst_combine_test51   : test51_before  ⊑  test51_combined := by
  unfold test51_before test51_combined
  simp_alive_peephole
  sorry
def test52_combined := [llvmfunc|
  llvm.func @test52(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(7224 : i32) : i32
    %1 = llvm.mlir.constant(32962 : i32) : i32
    %2 = llvm.trunc %arg0 : i64 to i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.or %3, %1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_test52   : test52_before  ⊑  test52_combined := by
  unfold test52_before test52_combined
  simp_alive_peephole
  sorry
def test53_combined := [llvmfunc|
  llvm.func @test53(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(7224 : i32) : i32
    %1 = llvm.mlir.constant(32962 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.or %2, %1  : i32
    %4 = llvm.zext %3 : i32 to i64
    llvm.return %4 : i64
  }]

theorem inst_combine_test53   : test53_before  ⊑  test53_combined := by
  unfold test53_before test53_combined
  simp_alive_peephole
  sorry
def test54_combined := [llvmfunc|
  llvm.func @test54(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(7224 : i32) : i32
    %1 = llvm.mlir.constant(-32574 : i32) : i32
    %2 = llvm.trunc %arg0 : i64 to i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.or %3, %1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_test54   : test54_before  ⊑  test54_combined := by
  unfold test54_before test54_combined
  simp_alive_peephole
  sorry
def test55_combined := [llvmfunc|
  llvm.func @test55(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(7224 : i32) : i32
    %1 = llvm.mlir.constant(-32574 : i64) : i64
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.zext %2 : i32 to i64
    %4 = llvm.or %3, %1  : i64
    llvm.return %4 : i64
  }]

theorem inst_combine_test55   : test55_before  ⊑  test55_combined := by
  unfold test55_before test55_combined
  simp_alive_peephole
  sorry
def test56_combined := [llvmfunc|
  llvm.func @test56(%arg0: i16) -> i64 {
    %0 = llvm.mlir.constant(5 : i64) : i64
    %1 = llvm.mlir.constant(134217727 : i64) : i64
    %2 = llvm.sext %arg0 : i16 to i64
    %3 = llvm.lshr %2, %0  : i64
    %4 = llvm.and %3, %1  : i64
    llvm.return %4 : i64
  }]

theorem inst_combine_test56   : test56_before  ⊑  test56_combined := by
  unfold test56_before test56_combined
  simp_alive_peephole
  sorry
def test56vec_combined := [llvmfunc|
  llvm.func @test56vec(%arg0: vector<2xi16>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi16> to vector<2xi32>
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    %3 = llvm.zext %2 : vector<2xi32> to vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }]

theorem inst_combine_test56vec   : test56vec_before  ⊑  test56vec_combined := by
  unfold test56vec_before test56vec_combined
  simp_alive_peephole
  sorry
def test57_combined := [llvmfunc|
  llvm.func @test57(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(8 : i64) : i64
    %1 = llvm.mlir.constant(16777215 : i64) : i64
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.and %2, %1  : i64
    llvm.return %3 : i64
  }]

theorem inst_combine_test57   : test57_before  ⊑  test57_combined := by
  unfold test57_before test57_combined
  simp_alive_peephole
  sorry
def test57vec_combined := [llvmfunc|
  llvm.func @test57vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    %3 = llvm.zext %2 : vector<2xi32> to vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }]

theorem inst_combine_test57vec   : test57vec_before  ⊑  test57vec_combined := by
  unfold test57vec_before test57vec_combined
  simp_alive_peephole
  sorry
def test58_combined := [llvmfunc|
  llvm.func @test58(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(8 : i64) : i64
    %1 = llvm.mlir.constant(16777087 : i64) : i64
    %2 = llvm.mlir.constant(128 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i64
    %4 = llvm.and %3, %1  : i64
    %5 = llvm.or %4, %2  : i64
    llvm.return %5 : i64
  }]

theorem inst_combine_test58   : test58_before  ⊑  test58_combined := by
  unfold test58_before test58_combined
  simp_alive_peephole
  sorry
def test59_combined := [llvmfunc|
  llvm.func @test59(%arg0: i8, %arg1: i8) -> i64 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(48 : i64) : i64
    %2 = llvm.mlir.constant(4 : i8) : i8
    %3 = llvm.zext %arg0 : i8 to i64
    %4 = llvm.shl %3, %0 overflow<nsw, nuw>  : i64
    %5 = llvm.and %4, %1  : i64
    %6 = llvm.lshr %arg1, %2  : i8
    %7 = llvm.zext %6 : i8 to i64
    %8 = llvm.or %5, %7  : i64
    llvm.return %8 : i64
  }]

theorem inst_combine_test59   : test59_before  ⊑  test59_combined := by
  unfold test59_before test59_combined
  simp_alive_peephole
  sorry
def test60_combined := [llvmfunc|
  llvm.func @test60(%arg0: vector<4xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.poison : vector<4xi32>
    %1 = llvm.shufflevector %arg0, %0 [1, 2, 3] : vector<4xi32> 
    llvm.return %1 : vector<3xi32>
  }]

theorem inst_combine_test60   : test60_before  ⊑  test60_combined := by
  unfold test60_before test60_combined
  simp_alive_peephole
  sorry
def test61_combined := [llvmfunc|
  llvm.func @test61(%arg0: vector<3xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.shufflevector %arg0, %8 [3, 0, 1, 2] : vector<3xi32> 
    llvm.return %9 : vector<4xi32>
  }]

theorem inst_combine_test61   : test61_before  ⊑  test61_combined := by
  unfold test61_before test61_combined
  simp_alive_peephole
  sorry
def test62_combined := [llvmfunc|
  llvm.func @test62(%arg0: vector<3xf32>) -> vector<4xi32> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.bitcast %arg0 : vector<3xf32> to vector<3xi32>
    %10 = llvm.shufflevector %9, %8 [3, 0, 1, 2] : vector<3xi32> 
    llvm.return %10 : vector<4xi32>
  }]

theorem inst_combine_test62   : test62_before  ⊑  test62_combined := by
  unfold test62_before test62_combined
  simp_alive_peephole
  sorry
def test63_combined := [llvmfunc|
  llvm.func @test63(%arg0: i64) -> vector<2xf32> {
    %0 = llvm.bitcast %arg0 : i64 to vector<2xi32>
    %1 = llvm.uitofp %0 : vector<2xi32> to vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }]

theorem inst_combine_test63   : test63_before  ⊑  test63_combined := by
  unfold test63_before test63_combined
  simp_alive_peephole
  sorry
def test64_combined := [llvmfunc|
  llvm.func @test64(%arg0: vector<4xf32>) -> vector<4xf32> {
    llvm.return %arg0 : vector<4xf32>
  }]

theorem inst_combine_test64   : test64_before  ⊑  test64_combined := by
  unfold test64_before test64_combined
  simp_alive_peephole
  sorry
def test65_combined := [llvmfunc|
  llvm.func @test65(%arg0: vector<4xf32>) -> vector<4xf32> {
    llvm.return %arg0 : vector<4xf32>
  }]

theorem inst_combine_test65   : test65_before  ⊑  test65_combined := by
  unfold test65_before test65_combined
  simp_alive_peephole
  sorry
def test66_combined := [llvmfunc|
  llvm.func @test66(%arg0: vector<2xf32>) -> vector<2xf32> {
    llvm.return %arg0 : vector<2xf32>
  }]

theorem inst_combine_test66   : test66_before  ⊑  test66_combined := by
  unfold test66_before test66_combined
  simp_alive_peephole
  sorry
def test2c_combined := [llvmfunc|
  llvm.func @test2c() -> f32 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f32) : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_test2c   : test2c_before  ⊑  test2c_combined := by
  unfold test2c_before test2c_combined
  simp_alive_peephole
  sorry
def test_mmx_combined := [llvmfunc|
  llvm.func @test_mmx(%arg0: vector<2xi32>) -> i64 {
    %0 = llvm.bitcast %arg0 : vector<2xi32> to i64
    llvm.return %0 : i64
  }]

theorem inst_combine_test_mmx   : test_mmx_before  ⊑  test_mmx_combined := by
  unfold test_mmx_before test_mmx_combined
  simp_alive_peephole
  sorry
def test_mmx_const_combined := [llvmfunc|
  llvm.func @test_mmx_const(%arg0: vector<2xi32>) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    llvm.return %0 : i64
  }]

theorem inst_combine_test_mmx_const   : test_mmx_const_before  ⊑  test_mmx_const_combined := by
  unfold test_mmx_const_before test_mmx_const_combined
  simp_alive_peephole
  sorry
def test67_combined := [llvmfunc|
  llvm.func @test67(%arg0: i1, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test67   : test67_before  ⊑  test67_combined := by
  unfold test67_before test67_combined
  simp_alive_peephole
  sorry
def test68(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.struct<"s", _combined := [llvmfunc|
  llvm.func @test68(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.struct<"s", (i32, i32, i16)> {
    %0 = llvm.mlir.constant(12 : i64) : i64
    %1 = llvm.mul %arg1, %0  : i64
    %2 = llvm.getelementptr inbounds %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> !llvm.struct<"s", (i32, i32, i16)>
    llvm.return %3 : !llvm.struct<"s", (i32, i32, i16)>
  }]

theorem inst_combine_test68(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.struct<"s",    : test68(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.struct<"s", _before  ⊑  test68(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.struct<"s", _combined := by
  unfold test68(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.struct<"s", _before test68(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.struct<"s", _combined
  simp_alive_peephole
  sorry
def test68_addrspacecast(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.struct<"s", _combined := [llvmfunc|
  llvm.func @test68_addrspacecast(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.struct<"s", (i32, i32, i16)> {
    %0 = llvm.mlir.constant(12 : i64) : i64
    %1 = llvm.mul %arg1, %0  : i64
    %2 = llvm.addrspacecast %arg0 : !llvm.ptr to !llvm.ptr<2>
    %3 = llvm.getelementptr inbounds %2[%1] : (!llvm.ptr<2>, i64) -> !llvm.ptr<2>, i8
    %4 = llvm.addrspacecast %3 : !llvm.ptr<2> to !llvm.ptr
    %5 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr -> !llvm.struct<"s", (i32, i32, i16)>
    llvm.return %5 : !llvm.struct<"s", (i32, i32, i16)>
  }]

theorem inst_combine_test68_addrspacecast(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.struct<"s",    : test68_addrspacecast(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.struct<"s", _before  ⊑  test68_addrspacecast(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.struct<"s", _combined := by
  unfold test68_addrspacecast(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.struct<"s", _before test68_addrspacecast(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.struct<"s", _combined
  simp_alive_peephole
  sorry
def test68_addrspacecast_2(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.struct<"s", _combined := [llvmfunc|
  llvm.func @test68_addrspacecast_2(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.struct<"s", (i32, i32, i16)> {
    %0 = llvm.mlir.constant(12 : i64) : i64
    %1 = llvm.mul %arg1, %0  : i64
    %2 = llvm.addrspacecast %arg0 : !llvm.ptr to !llvm.ptr<2>
    %3 = llvm.getelementptr inbounds %2[%1] : (!llvm.ptr<2>, i64) -> !llvm.ptr<2>, i8
    %4 = llvm.addrspacecast %3 : !llvm.ptr<2> to !llvm.ptr<1>
    %5 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr<1> -> !llvm.struct<"s", (i32, i32, i16)>
    llvm.return %5 : !llvm.struct<"s", (i32, i32, i16)>
  }]

theorem inst_combine_test68_addrspacecast_2(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.struct<"s",    : test68_addrspacecast_2(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.struct<"s", _before  ⊑  test68_addrspacecast_2(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.struct<"s", _combined := by
  unfold test68_addrspacecast_2(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.struct<"s", _before test68_addrspacecast_2(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.struct<"s", _combined
  simp_alive_peephole
  sorry
def test68_as1(%arg0: !llvm.ptr<1>, %arg1: i32) -> !llvm.struct<"s", _combined := [llvmfunc|
  llvm.func @test68_as1(%arg0: !llvm.ptr<1>, %arg1: i32) -> !llvm.struct<"s", (i32, i32, i16)> {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mul %arg1, %0  : i32
    %2 = llvm.getelementptr inbounds %arg0[%1] : (!llvm.ptr<1>, i32) -> !llvm.ptr<1>, i8
    %3 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr<1> -> !llvm.struct<"s", (i32, i32, i16)>
    llvm.return %3 : !llvm.struct<"s", (i32, i32, i16)>
  }]

theorem inst_combine_test68_as1(%arg0: !llvm.ptr<1>, %arg1: i32) -> !llvm.struct<"s",    : test68_as1(%arg0: !llvm.ptr<1>, %arg1: i32) -> !llvm.struct<"s", _before  ⊑  test68_as1(%arg0: !llvm.ptr<1>, %arg1: i32) -> !llvm.struct<"s", _combined := by
  unfold test68_as1(%arg0: !llvm.ptr<1>, %arg1: i32) -> !llvm.struct<"s", _before test68_as1(%arg0: !llvm.ptr<1>, %arg1: i32) -> !llvm.struct<"s", _combined
  simp_alive_peephole
  sorry
def test69_combined := [llvmfunc|
  llvm.func @test69(%arg0: !llvm.ptr, %arg1: i64) -> f64 {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.shl %arg1, %0 overflow<nsw>  : i64
    %2 = llvm.getelementptr inbounds %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> f64
    llvm.return %3 : f64
  }]

theorem inst_combine_test69   : test69_before  ⊑  test69_combined := by
  unfold test69_before test69_combined
  simp_alive_peephole
  sorry
def test70(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.struct<"s", _combined := [llvmfunc|
  llvm.func @test70(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.struct<"s", (i32, i32, i16)> {
    %0 = llvm.mlir.constant(36 : i64) : i64
    %1 = llvm.mul %arg1, %0 overflow<nsw>  : i64
    %2 = llvm.getelementptr inbounds %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> !llvm.struct<"s", (i32, i32, i16)>
    llvm.return %3 : !llvm.struct<"s", (i32, i32, i16)>
  }]

theorem inst_combine_test70(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.struct<"s",    : test70(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.struct<"s", _before  ⊑  test70(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.struct<"s", _combined := by
  unfold test70(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.struct<"s", _before test70(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.struct<"s", _combined
  simp_alive_peephole
  sorry
def test71_combined := [llvmfunc|
  llvm.func @test71(%arg0: !llvm.ptr, %arg1: i64) -> f64 {
    %0 = llvm.mlir.constant(5 : i64) : i64
    %1 = llvm.shl %arg1, %0  : i64
    %2 = llvm.getelementptr %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> f64
    llvm.return %3 : f64
  }]

theorem inst_combine_test71   : test71_before  ⊑  test71_combined := by
  unfold test71_before test71_combined
  simp_alive_peephole
  sorry
def test72_combined := [llvmfunc|
  llvm.func @test72(%arg0: !llvm.ptr, %arg1: i32) -> f64 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.shl %arg1, %0 overflow<nsw>  : i32
    %2 = llvm.sext %1 : i32 to i64
    %3 = llvm.getelementptr inbounds %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %4 = llvm.load %3 {alignment = 8 : i64} : !llvm.ptr -> f64
    llvm.return %4 : f64
  }]

theorem inst_combine_test72   : test72_before  ⊑  test72_combined := by
  unfold test72_before test72_combined
  simp_alive_peephole
  sorry
def test73_combined := [llvmfunc|
  llvm.func @test73(%arg0: !llvm.ptr, %arg1: i128) -> f64 {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.trunc %arg1 : i128 to i64
    %2 = llvm.shl %1, %0  : i64
    %3 = llvm.getelementptr inbounds %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %4 = llvm.load %3 {alignment = 8 : i64} : !llvm.ptr -> f64
    llvm.return %4 : f64
  }]

theorem inst_combine_test73   : test73_before  ⊑  test73_combined := by
  unfold test73_before test73_combined
  simp_alive_peephole
  sorry
def test74_combined := [llvmfunc|
  llvm.func @test74(%arg0: !llvm.ptr, %arg1: i64) -> f64 {
    %0 = llvm.getelementptr inbounds %arg0[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %1 = llvm.load %0 {alignment = 8 : i64} : !llvm.ptr -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_test74   : test74_before  ⊑  test74_combined := by
  unfold test74_before test74_combined
  simp_alive_peephole
  sorry
def test75_combined := [llvmfunc|
  llvm.func @test75(%arg0: !llvm.ptr, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.shl %arg1, %0  : i32
    %2 = llvm.sext %1 : i32 to i64
    %3 = llvm.getelementptr %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_test75   : test75_before  ⊑  test75_combined := by
  unfold test75_before test75_combined
  simp_alive_peephole
  sorry
def test76(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.struct<"s", _combined := [llvmfunc|
  llvm.func @test76(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.struct<"s", (i32, i32, i16)> {
    %0 = llvm.mlir.constant(12 : i64) : i64
    %1 = llvm.mul %arg1, %0  : i64
    %2 = llvm.mul %1, %arg2 overflow<nsw>  : i64
    %3 = llvm.getelementptr inbounds %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %4 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> !llvm.struct<"s", (i32, i32, i16)>
    llvm.return %4 : !llvm.struct<"s", (i32, i32, i16)>
  }]

theorem inst_combine_test76(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.struct<"s",    : test76(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.struct<"s", _before  ⊑  test76(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.struct<"s", _combined := by
  unfold test76(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.struct<"s", _before test76(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.struct<"s", _combined
  simp_alive_peephole
  sorry
def test77(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.struct<"s", _combined := [llvmfunc|
  llvm.func @test77(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.struct<"s", (i32, i32, i16)> {
    %0 = llvm.mlir.constant(36 : i64) : i64
    %1 = llvm.mul %arg1, %0 overflow<nsw>  : i64
    %2 = llvm.mul %1, %arg2 overflow<nsw>  : i64
    %3 = llvm.getelementptr inbounds %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %4 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> !llvm.struct<"s", (i32, i32, i16)>
    llvm.return %4 : !llvm.struct<"s", (i32, i32, i16)>
  }]

theorem inst_combine_test77(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.struct<"s",    : test77(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.struct<"s", _before  ⊑  test77(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.struct<"s", _combined := by
  unfold test77(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.struct<"s", _before test77(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.struct<"s", _combined
  simp_alive_peephole
  sorry
def test78(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64, %arg3: i32, %arg4: i32, %arg5: i128, %arg6: i128) -> !llvm.struct<"s", _combined := [llvmfunc|
  llvm.func @test78(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64, %arg3: i32, %arg4: i32, %arg5: i128, %arg6: i128) -> !llvm.struct<"s", (i32, i32, i16)> {
    %0 = llvm.mlir.constant(36 : i32) : i32
    %1 = llvm.mul %arg3, %0 overflow<nsw>  : i32
    %2 = llvm.mul %1, %arg4 overflow<nsw>  : i32
    %3 = llvm.sext %2 : i32 to i128
    %4 = llvm.mul %3, %arg5 overflow<nsw>  : i128
    %5 = llvm.mul %4, %arg6  : i128
    %6 = llvm.trunc %5 : i128 to i64
    %7 = llvm.mul %6, %arg1 overflow<nsw>  : i64
    %8 = llvm.mul %7, %arg2 overflow<nsw>  : i64
    %9 = llvm.getelementptr inbounds %arg0[%8] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %10 = llvm.load %9 {alignment = 4 : i64} : !llvm.ptr -> !llvm.struct<"s", (i32, i32, i16)>
    llvm.return %10 : !llvm.struct<"s", (i32, i32, i16)>
  }]

theorem inst_combine_test78(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64, %arg3: i32, %arg4: i32, %arg5: i128, %arg6: i128) -> !llvm.struct<"s",    : test78(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64, %arg3: i32, %arg4: i32, %arg5: i128, %arg6: i128) -> !llvm.struct<"s", _before  ⊑  test78(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64, %arg3: i32, %arg4: i32, %arg5: i128, %arg6: i128) -> !llvm.struct<"s", _combined := by
  unfold test78(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64, %arg3: i32, %arg4: i32, %arg5: i128, %arg6: i128) -> !llvm.struct<"s", _before test78(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64, %arg3: i32, %arg4: i32, %arg5: i128, %arg6: i128) -> !llvm.struct<"s", _combined
  simp_alive_peephole
  sorry
def test79(%arg0: !llvm.ptr, %arg1: i64, %arg2: i32) -> !llvm.struct<"s", _combined := [llvmfunc|
  llvm.func @test79(%arg0: !llvm.ptr, %arg1: i64, %arg2: i32) -> !llvm.struct<"s", (i32, i32, i16)> {
    %0 = llvm.mlir.constant(36 : i32) : i32
    %1 = llvm.trunc %arg1 : i64 to i32
    %2 = llvm.mul %1, %0  : i32
    %3 = llvm.mul %2, %arg2  : i32
    %4 = llvm.sext %3 : i32 to i64
    %5 = llvm.getelementptr inbounds %arg0[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %6 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> !llvm.struct<"s", (i32, i32, i16)>
    llvm.return %6 : !llvm.struct<"s", (i32, i32, i16)>
  }]

theorem inst_combine_test79(%arg0: !llvm.ptr, %arg1: i64, %arg2: i32) -> !llvm.struct<"s",    : test79(%arg0: !llvm.ptr, %arg1: i64, %arg2: i32) -> !llvm.struct<"s", _before  ⊑  test79(%arg0: !llvm.ptr, %arg1: i64, %arg2: i32) -> !llvm.struct<"s", _combined := by
  unfold test79(%arg0: !llvm.ptr, %arg1: i64, %arg2: i32) -> !llvm.struct<"s", _before test79(%arg0: !llvm.ptr, %arg1: i64, %arg2: i32) -> !llvm.struct<"s", _combined
  simp_alive_peephole
  sorry
def test80_combined := [llvmfunc|
  llvm.func @test80(%arg0: !llvm.ptr, %arg1: i32) -> f64 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.shl %arg1, %0 overflow<nsw>  : i32
    %2 = llvm.sext %1 : i32 to i64
    %3 = llvm.getelementptr %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %4 = llvm.load %3 {alignment = 8 : i64} : !llvm.ptr -> f64
    llvm.return %4 : f64
  }]

theorem inst_combine_test80   : test80_before  ⊑  test80_combined := by
  unfold test80_before test80_combined
  simp_alive_peephole
  sorry
def test80_addrspacecast_combined := [llvmfunc|
  llvm.func @test80_addrspacecast(%arg0: !llvm.ptr<1>, %arg1: i32) -> f64 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.shl %arg1, %0 overflow<nsw>  : i32
    %2 = llvm.addrspacecast %arg0 : !llvm.ptr<1> to !llvm.ptr<2>
    %3 = llvm.sext %1 : i32 to i64
    %4 = llvm.getelementptr %2[%3] : (!llvm.ptr<2>, i64) -> !llvm.ptr<2>, i8
    %5 = llvm.addrspacecast %4 : !llvm.ptr<2> to !llvm.ptr<1>
    %6 = llvm.load %5 {alignment = 8 : i64} : !llvm.ptr<1> -> f64
    llvm.return %6 : f64
  }]

theorem inst_combine_test80_addrspacecast   : test80_addrspacecast_before  ⊑  test80_addrspacecast_combined := by
  unfold test80_addrspacecast_before test80_addrspacecast_combined
  simp_alive_peephole
  sorry
def test80_addrspacecast_2_combined := [llvmfunc|
  llvm.func @test80_addrspacecast_2(%arg0: !llvm.ptr<1>, %arg1: i32) -> f64 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.shl %arg1, %0 overflow<nsw>  : i32
    %2 = llvm.addrspacecast %arg0 : !llvm.ptr<1> to !llvm.ptr<2>
    %3 = llvm.sext %1 : i32 to i64
    %4 = llvm.getelementptr %2[%3] : (!llvm.ptr<2>, i64) -> !llvm.ptr<2>, i8
    %5 = llvm.addrspacecast %4 : !llvm.ptr<2> to !llvm.ptr<3>
    %6 = llvm.load %5 {alignment = 8 : i64} : !llvm.ptr<3> -> f64
    llvm.return %6 : f64
  }]

theorem inst_combine_test80_addrspacecast_2   : test80_addrspacecast_2_before  ⊑  test80_addrspacecast_2_combined := by
  unfold test80_addrspacecast_2_before test80_addrspacecast_2_combined
  simp_alive_peephole
  sorry
def test80_as1_combined := [llvmfunc|
  llvm.func @test80_as1(%arg0: !llvm.ptr<1>, %arg1: i16) -> f64 {
    %0 = llvm.mlir.constant(3 : i16) : i16
    %1 = llvm.shl %arg1, %0 overflow<nsw>  : i16
    %2 = llvm.sext %1 : i16 to i32
    %3 = llvm.getelementptr %arg0[%2] : (!llvm.ptr<1>, i32) -> !llvm.ptr<1>, i8
    %4 = llvm.load %3 {alignment = 8 : i64} : !llvm.ptr<1> -> f64
    llvm.return %4 : f64
  }]

theorem inst_combine_test80_as1   : test80_as1_before  ⊑  test80_as1_combined := by
  unfold test80_as1_before test80_as1_combined
  simp_alive_peephole
  sorry
def test81_combined := [llvmfunc|
  llvm.func @test81(%arg0: !llvm.ptr, %arg1: f32) -> f64 {
    %0 = llvm.fptosi %arg1 : f32 to i64
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %2 = llvm.load %1 {alignment = 8 : i64} : !llvm.ptr -> f64
    llvm.return %2 : f64
  }]

theorem inst_combine_test81   : test81_before  ⊑  test81_combined := by
  unfold test81_before test81_combined
  simp_alive_peephole
  sorry
def test82_combined := [llvmfunc|
  llvm.func @test82(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(4294966784 : i64) : i64
    %2 = llvm.shl %arg0, %0  : i64
    %3 = llvm.and %2, %1  : i64
    llvm.return %3 : i64
  }]

theorem inst_combine_test82   : test82_before  ⊑  test82_combined := by
  unfold test82_before test82_combined
  simp_alive_peephole
  sorry
def test83_combined := [llvmfunc|
  llvm.func @test83(%arg0: i16, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.sext %arg0 : i16 to i32
    %2 = llvm.trunc %arg1 : i64 to i32
    %3 = llvm.add %2, %0  : i32
    %4 = llvm.shl %1, %3  : i32
    %5 = llvm.zext %4 : i32 to i64
    llvm.return %5 : i64
  }]

theorem inst_combine_test83   : test83_before  ⊑  test83_combined := by
  unfold test83_before test83_combined
  simp_alive_peephole
  sorry
def test84_combined := [llvmfunc|
  llvm.func @test84(%arg0: i32) -> i8 {
    %0 = llvm.mlir.constant(2130706432 : i32) : i32
    %1 = llvm.mlir.constant(23 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.lshr %2, %1  : i32
    %4 = llvm.trunc %3 : i32 to i8
    llvm.return %4 : i8
  }]

theorem inst_combine_test84   : test84_before  ⊑  test84_combined := by
  unfold test84_before test84_combined
  simp_alive_peephole
  sorry
def test85_combined := [llvmfunc|
  llvm.func @test85(%arg0: i32) -> i8 {
    %0 = llvm.mlir.constant(2130706432 : i32) : i32
    %1 = llvm.mlir.constant(23 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.lshr %2, %1  : i32
    %4 = llvm.trunc %3 : i32 to i8
    llvm.return %4 : i8
  }]

theorem inst_combine_test85   : test85_before  ⊑  test85_combined := by
  unfold test85_before test85_combined
  simp_alive_peephole
  sorry
def test86_combined := [llvmfunc|
  llvm.func @test86(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(4 : i16) : i16
    %1 = llvm.ashr %arg0, %0  : i16
    llvm.return %1 : i16
  }]

theorem inst_combine_test86   : test86_before  ⊑  test86_combined := by
  unfold test86_before test86_combined
  simp_alive_peephole
  sorry
def test87_combined := [llvmfunc|
  llvm.func @test87(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(12 : i16) : i16
    %1 = llvm.ashr %arg0, %0  : i16
    llvm.return %1 : i16
  }]

theorem inst_combine_test87   : test87_before  ⊑  test87_combined := by
  unfold test87_before test87_combined
  simp_alive_peephole
  sorry
def test88_combined := [llvmfunc|
  llvm.func @test88(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(15 : i16) : i16
    %1 = llvm.ashr %arg0, %0  : i16
    llvm.return %1 : i16
  }]

theorem inst_combine_test88   : test88_before  ⊑  test88_combined := by
  unfold test88_before test88_combined
  simp_alive_peephole
  sorry
def PR21388_combined := [llvmfunc|
  llvm.func @PR21388(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "slt" %arg0, %0 : !llvm.ptr
    %2 = llvm.sext %1 : i1 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_PR21388   : PR21388_before  ⊑  PR21388_combined := by
  unfold PR21388_before PR21388_combined
  simp_alive_peephole
  sorry
def sitofp_zext_combined := [llvmfunc|
  llvm.func @sitofp_zext(%arg0: i16) -> f32 {
    %0 = llvm.uitofp %arg0 : i16 to f32
    llvm.return %0 : f32
  }]

theorem inst_combine_sitofp_zext   : sitofp_zext_before  ⊑  sitofp_zext_combined := by
  unfold sitofp_zext_before sitofp_zext_combined
  simp_alive_peephole
  sorry
def PR23309_combined := [llvmfunc|
  llvm.func @PR23309(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.sub %arg0, %arg1  : i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_PR23309   : PR23309_before  ⊑  PR23309_combined := by
  unfold PR23309_before PR23309_combined
  simp_alive_peephole
  sorry
def PR23309v2_combined := [llvmfunc|
  llvm.func @PR23309v2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.add %arg0, %arg1  : i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_PR23309v2   : PR23309v2_before  ⊑  PR23309v2_combined := by
  unfold PR23309v2_before PR23309v2_combined
  simp_alive_peephole
  sorry
def PR24763_combined := [llvmfunc|
  llvm.func @PR24763(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    %2 = llvm.sext %1 : i8 to i16
    llvm.return %2 : i16
  }]

theorem inst_combine_PR24763   : PR24763_before  ⊑  PR24763_combined := by
  unfold PR24763_before PR24763_combined
  simp_alive_peephole
  sorry
def PR28745_combined := [llvmfunc|
  llvm.func @PR28745() -> i64 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    llvm.return %0 : i64
  }]

theorem inst_combine_PR28745   : PR28745_before  ⊑  PR28745_combined := by
  unfold PR28745_before PR28745_combined
  simp_alive_peephole
  sorry
def test89_combined := [llvmfunc|
  llvm.func @test89() -> i32 {
    %0 = llvm.mlir.constant(393216 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test89   : test89_before  ⊑  test89_combined := by
  unfold test89_before test89_combined
  simp_alive_peephole
  sorry
def test90_combined := [llvmfunc|
  llvm.func @test90() -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[0, 15360]> : vector<2xi32>) : vector<2xi32>
    llvm.return %0 : vector<2xi32>
  }]

theorem inst_combine_test90   : test90_before  ⊑  test90_combined := by
  unfold test90_before test90_combined
  simp_alive_peephole
  sorry
def test91_combined := [llvmfunc|
  llvm.func @test91(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(48 : i96) : i96
    %1 = llvm.sext %arg0 : i64 to i96
    %2 = llvm.lshr %1, %0  : i96
    %3 = llvm.trunc %2 : i96 to i64
    llvm.return %3 : i64
  }]

theorem inst_combine_test91   : test91_before  ⊑  test91_combined := by
  unfold test91_before test91_combined
  simp_alive_peephole
  sorry
def test92_combined := [llvmfunc|
  llvm.func @test92(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.ashr %arg0, %0  : i64
    llvm.return %1 : i64
  }]

theorem inst_combine_test92   : test92_before  ⊑  test92_combined := by
  unfold test92_before test92_combined
  simp_alive_peephole
  sorry
def test93_combined := [llvmfunc|
  llvm.func @test93(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.ashr %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test93   : test93_before  ⊑  test93_combined := by
  unfold test93_before test93_combined
  simp_alive_peephole
  sorry
def trunc_lshr_sext_combined := [llvmfunc|
  llvm.func @trunc_lshr_sext(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_trunc_lshr_sext   : trunc_lshr_sext_before  ⊑  trunc_lshr_sext_combined := by
  unfold trunc_lshr_sext_before trunc_lshr_sext_combined
  simp_alive_peephole
  sorry
def trunc_lshr_sext_exact_combined := [llvmfunc|
  llvm.func @trunc_lshr_sext_exact(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_trunc_lshr_sext_exact   : trunc_lshr_sext_exact_before  ⊑  trunc_lshr_sext_exact_combined := by
  unfold trunc_lshr_sext_exact_before trunc_lshr_sext_exact_combined
  simp_alive_peephole
  sorry
def trunc_lshr_sext_uniform_combined := [llvmfunc|
  llvm.func @trunc_lshr_sext_uniform(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<6> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.ashr %arg0, %0  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_trunc_lshr_sext_uniform   : trunc_lshr_sext_uniform_before  ⊑  trunc_lshr_sext_uniform_combined := by
  unfold trunc_lshr_sext_uniform_before trunc_lshr_sext_uniform_combined
  simp_alive_peephole
  sorry
def trunc_lshr_sext_uniform_poison_combined := [llvmfunc|
  llvm.func @trunc_lshr_sext_uniform_poison(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.ashr %arg0, %6  : vector<2xi8>
    llvm.return %7 : vector<2xi8>
  }]

theorem inst_combine_trunc_lshr_sext_uniform_poison   : trunc_lshr_sext_uniform_poison_before  ⊑  trunc_lshr_sext_uniform_poison_combined := by
  unfold trunc_lshr_sext_uniform_poison_before trunc_lshr_sext_uniform_poison_combined
  simp_alive_peephole
  sorry
def trunc_lshr_sext_nonuniform_combined := [llvmfunc|
  llvm.func @trunc_lshr_sext_nonuniform(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[6, 2]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.ashr %arg0, %0  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_trunc_lshr_sext_nonuniform   : trunc_lshr_sext_nonuniform_before  ⊑  trunc_lshr_sext_nonuniform_combined := by
  unfold trunc_lshr_sext_nonuniform_before trunc_lshr_sext_nonuniform_combined
  simp_alive_peephole
  sorry
def trunc_lshr_sext_nonuniform_poison_combined := [llvmfunc|
  llvm.func @trunc_lshr_sext_nonuniform_poison(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.constant(6 : i8) : i8
    %3 = llvm.mlir.undef : vector<3xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<3xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<3xi8>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<3xi8>
    %10 = llvm.ashr %arg0, %9  : vector<3xi8>
    llvm.return %10 : vector<3xi8>
  }]

theorem inst_combine_trunc_lshr_sext_nonuniform_poison   : trunc_lshr_sext_nonuniform_poison_before  ⊑  trunc_lshr_sext_nonuniform_poison_combined := by
  unfold trunc_lshr_sext_nonuniform_poison_before trunc_lshr_sext_nonuniform_poison_combined
  simp_alive_peephole
  sorry
def trunc_lshr_sext_uses1_combined := [llvmfunc|
  llvm.func @trunc_lshr_sext_uses1(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<6> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.sext %arg0 : vector<2xi8> to vector<2xi32>
    llvm.call @use_v2i32(%1) : (vector<2xi32>) -> ()
    %2 = llvm.ashr %arg0, %0  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

theorem inst_combine_trunc_lshr_sext_uses1   : trunc_lshr_sext_uses1_before  ⊑  trunc_lshr_sext_uses1_combined := by
  unfold trunc_lshr_sext_uses1_before trunc_lshr_sext_uses1_combined
  simp_alive_peephole
  sorry
def trunc_lshr_sext_uses2_combined := [llvmfunc|
  llvm.func @trunc_lshr_sext_uses2(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.sext %arg0 : i8 to i32
    %3 = llvm.lshr %2, %0  : i32
    llvm.call @use_i32(%3) : (i32) -> ()
    %4 = llvm.ashr %arg0, %1  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_trunc_lshr_sext_uses2   : trunc_lshr_sext_uses2_before  ⊑  trunc_lshr_sext_uses2_combined := by
  unfold trunc_lshr_sext_uses2_before trunc_lshr_sext_uses2_combined
  simp_alive_peephole
  sorry
def trunc_lshr_sext_uses3_combined := [llvmfunc|
  llvm.func @trunc_lshr_sext_uses3(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<6> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<6> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.sext %arg0 : vector<2xi8> to vector<2xi32>
    llvm.call @use_v2i32(%2) : (vector<2xi32>) -> ()
    %3 = llvm.lshr %2, %0  : vector<2xi32>
    llvm.call @use_v2i32(%3) : (vector<2xi32>) -> ()
    %4 = llvm.ashr %arg0, %1  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

theorem inst_combine_trunc_lshr_sext_uses3   : trunc_lshr_sext_uses3_before  ⊑  trunc_lshr_sext_uses3_combined := by
  unfold trunc_lshr_sext_uses3_before trunc_lshr_sext_uses3_combined
  simp_alive_peephole
  sorry
def trunc_lshr_overshift_sext_combined := [llvmfunc|
  llvm.func @trunc_lshr_overshift_sext(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.ashr %arg0, %0  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_trunc_lshr_overshift_sext   : trunc_lshr_overshift_sext_before  ⊑  trunc_lshr_overshift_sext_combined := by
  unfold trunc_lshr_overshift_sext_before trunc_lshr_overshift_sext_combined
  simp_alive_peephole
  sorry
def trunc_lshr_overshift_sext_uses1_combined := [llvmfunc|
  llvm.func @trunc_lshr_overshift_sext_uses1(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.sext %arg0 : i8 to i32
    llvm.call @use_i32(%1) : (i32) -> ()
    %2 = llvm.ashr %arg0, %0  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_trunc_lshr_overshift_sext_uses1   : trunc_lshr_overshift_sext_uses1_before  ⊑  trunc_lshr_overshift_sext_uses1_combined := by
  unfold trunc_lshr_overshift_sext_uses1_before trunc_lshr_overshift_sext_uses1_combined
  simp_alive_peephole
  sorry
def trunc_lshr_overshift_sext_uses2_combined := [llvmfunc|
  llvm.func @trunc_lshr_overshift_sext_uses2(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<7> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.sext %arg0 : vector<2xi8> to vector<2xi32>
    %3 = llvm.lshr %2, %0  : vector<2xi32>
    llvm.call @use_v2i32(%3) : (vector<2xi32>) -> ()
    %4 = llvm.ashr %arg0, %1  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

theorem inst_combine_trunc_lshr_overshift_sext_uses2   : trunc_lshr_overshift_sext_uses2_before  ⊑  trunc_lshr_overshift_sext_uses2_combined := by
  unfold trunc_lshr_overshift_sext_uses2_before trunc_lshr_overshift_sext_uses2_combined
  simp_alive_peephole
  sorry
def trunc_lshr_overshift_sext_uses3_combined := [llvmfunc|
  llvm.func @trunc_lshr_overshift_sext_uses3(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.sext %arg0 : i8 to i32
    llvm.call @use_i32(%2) : (i32) -> ()
    %3 = llvm.lshr %2, %0  : i32
    llvm.call @use_i32(%3) : (i32) -> ()
    %4 = llvm.ashr %arg0, %1  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_trunc_lshr_overshift_sext_uses3   : trunc_lshr_overshift_sext_uses3_before  ⊑  trunc_lshr_overshift_sext_uses3_combined := by
  unfold trunc_lshr_overshift_sext_uses3_before trunc_lshr_overshift_sext_uses3_combined
  simp_alive_peephole
  sorry
def trunc_lshr_sext_wide_input_combined := [llvmfunc|
  llvm.func @trunc_lshr_sext_wide_input(%arg0: i16) -> i8 {
    %0 = llvm.mlir.constant(9 : i16) : i16
    %1 = llvm.ashr %arg0, %0  : i16
    %2 = llvm.trunc %1 : i16 to i8
    llvm.return %2 : i8
  }]

theorem inst_combine_trunc_lshr_sext_wide_input   : trunc_lshr_sext_wide_input_before  ⊑  trunc_lshr_sext_wide_input_combined := by
  unfold trunc_lshr_sext_wide_input_before trunc_lshr_sext_wide_input_combined
  simp_alive_peephole
  sorry
def trunc_lshr_sext_wide_input_exact_combined := [llvmfunc|
  llvm.func @trunc_lshr_sext_wide_input_exact(%arg0: i16) -> i8 {
    %0 = llvm.mlir.constant(9 : i16) : i16
    %1 = llvm.ashr %arg0, %0  : i16
    %2 = llvm.trunc %1 : i16 to i8
    llvm.return %2 : i8
  }]

theorem inst_combine_trunc_lshr_sext_wide_input_exact   : trunc_lshr_sext_wide_input_exact_before  ⊑  trunc_lshr_sext_wide_input_exact_combined := by
  unfold trunc_lshr_sext_wide_input_exact_before trunc_lshr_sext_wide_input_exact_combined
  simp_alive_peephole
  sorry
def trunc_lshr_sext_wide_input_uses1_combined := [llvmfunc|
  llvm.func @trunc_lshr_sext_wide_input_uses1(%arg0: vector<2xi16>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<9> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.sext %arg0 : vector<2xi16> to vector<2xi32>
    llvm.call @use_v2i32(%1) : (vector<2xi32>) -> ()
    %2 = llvm.ashr %arg0, %0  : vector<2xi16>
    %3 = llvm.trunc %2 : vector<2xi16> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_trunc_lshr_sext_wide_input_uses1   : trunc_lshr_sext_wide_input_uses1_before  ⊑  trunc_lshr_sext_wide_input_uses1_combined := by
  unfold trunc_lshr_sext_wide_input_uses1_before trunc_lshr_sext_wide_input_uses1_combined
  simp_alive_peephole
  sorry
def trunc_lshr_sext_wide_input_uses2_combined := [llvmfunc|
  llvm.func @trunc_lshr_sext_wide_input_uses2(%arg0: i16) -> i8 {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.sext %arg0 : i16 to i32
    %2 = llvm.lshr %1, %0  : i32
    llvm.call @use_i32(%2) : (i32) -> ()
    %3 = llvm.trunc %2 : i32 to i8
    llvm.return %3 : i8
  }]

theorem inst_combine_trunc_lshr_sext_wide_input_uses2   : trunc_lshr_sext_wide_input_uses2_before  ⊑  trunc_lshr_sext_wide_input_uses2_combined := by
  unfold trunc_lshr_sext_wide_input_uses2_before trunc_lshr_sext_wide_input_uses2_combined
  simp_alive_peephole
  sorry
def trunc_lshr_sext_wide_input_uses3_combined := [llvmfunc|
  llvm.func @trunc_lshr_sext_wide_input_uses3(%arg0: vector<2xi16>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<9> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi16> to vector<2xi32>
    llvm.call @use_v2i32(%1) : (vector<2xi32>) -> ()
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    llvm.call @use_v2i32(%2) : (vector<2xi32>) -> ()
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_trunc_lshr_sext_wide_input_uses3   : trunc_lshr_sext_wide_input_uses3_before  ⊑  trunc_lshr_sext_wide_input_uses3_combined := by
  unfold trunc_lshr_sext_wide_input_uses3_before trunc_lshr_sext_wide_input_uses3_combined
  simp_alive_peephole
  sorry
def trunc_lshr_overshift_wide_input_sext_combined := [llvmfunc|
  llvm.func @trunc_lshr_overshift_wide_input_sext(%arg0: vector<2xi16>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<15> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.ashr %arg0, %0  : vector<2xi16>
    %2 = llvm.trunc %1 : vector<2xi16> to vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

theorem inst_combine_trunc_lshr_overshift_wide_input_sext   : trunc_lshr_overshift_wide_input_sext_before  ⊑  trunc_lshr_overshift_wide_input_sext_combined := by
  unfold trunc_lshr_overshift_wide_input_sext_before trunc_lshr_overshift_wide_input_sext_combined
  simp_alive_peephole
  sorry
def trunc_lshr_overshift_sext_wide_input_uses1_combined := [llvmfunc|
  llvm.func @trunc_lshr_overshift_sext_wide_input_uses1(%arg0: i16) -> i8 {
    %0 = llvm.mlir.constant(15 : i16) : i16
    %1 = llvm.sext %arg0 : i16 to i32
    llvm.call @use_i32(%1) : (i32) -> ()
    %2 = llvm.ashr %arg0, %0  : i16
    %3 = llvm.trunc %2 : i16 to i8
    llvm.return %3 : i8
  }]

theorem inst_combine_trunc_lshr_overshift_sext_wide_input_uses1   : trunc_lshr_overshift_sext_wide_input_uses1_before  ⊑  trunc_lshr_overshift_sext_wide_input_uses1_combined := by
  unfold trunc_lshr_overshift_sext_wide_input_uses1_before trunc_lshr_overshift_sext_wide_input_uses1_combined
  simp_alive_peephole
  sorry
def trunc_lshr_overshift_sext_wide_input_uses2_combined := [llvmfunc|
  llvm.func @trunc_lshr_overshift_sext_wide_input_uses2(%arg0: vector<2xi16>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<15> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.ashr %arg0, %0  : vector<2xi16>
    %2 = llvm.zext %1 : vector<2xi16> to vector<2xi32>
    llvm.call @use_v2i32(%2) : (vector<2xi32>) -> ()
    %3 = llvm.trunc %1 : vector<2xi16> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_trunc_lshr_overshift_sext_wide_input_uses2   : trunc_lshr_overshift_sext_wide_input_uses2_before  ⊑  trunc_lshr_overshift_sext_wide_input_uses2_combined := by
  unfold trunc_lshr_overshift_sext_wide_input_uses2_before trunc_lshr_overshift_sext_wide_input_uses2_combined
  simp_alive_peephole
  sorry
def trunc_lshr_overshift_sext_wide_input_uses3_combined := [llvmfunc|
  llvm.func @trunc_lshr_overshift_sext_wide_input_uses3(%arg0: i16) -> i8 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.sext %arg0 : i16 to i32
    llvm.call @use_i32(%1) : (i32) -> ()
    %2 = llvm.lshr %1, %0  : i32
    llvm.call @use_i32(%2) : (i32) -> ()
    %3 = llvm.trunc %2 : i32 to i8
    llvm.return %3 : i8
  }]

theorem inst_combine_trunc_lshr_overshift_sext_wide_input_uses3   : trunc_lshr_overshift_sext_wide_input_uses3_before  ⊑  trunc_lshr_overshift_sext_wide_input_uses3_combined := by
  unfold trunc_lshr_overshift_sext_wide_input_uses3_before trunc_lshr_overshift_sext_wide_input_uses3_combined
  simp_alive_peephole
  sorry
def trunc_lshr_sext_narrow_input_combined := [llvmfunc|
  llvm.func @trunc_lshr_sext_narrow_input(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    %2 = llvm.sext %1 : i8 to i16
    llvm.return %2 : i16
  }]

theorem inst_combine_trunc_lshr_sext_narrow_input   : trunc_lshr_sext_narrow_input_before  ⊑  trunc_lshr_sext_narrow_input_combined := by
  unfold trunc_lshr_sext_narrow_input_before trunc_lshr_sext_narrow_input_combined
  simp_alive_peephole
  sorry
def trunc_lshr_sext_narrow_input_uses1_combined := [llvmfunc|
  llvm.func @trunc_lshr_sext_narrow_input_uses1(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<6> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.sext %arg0 : vector<2xi8> to vector<2xi32>
    llvm.call @use_v2i32(%1) : (vector<2xi32>) -> ()
    %2 = llvm.ashr %arg0, %0  : vector<2xi8>
    %3 = llvm.sext %2 : vector<2xi8> to vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

theorem inst_combine_trunc_lshr_sext_narrow_input_uses1   : trunc_lshr_sext_narrow_input_uses1_before  ⊑  trunc_lshr_sext_narrow_input_uses1_combined := by
  unfold trunc_lshr_sext_narrow_input_uses1_before trunc_lshr_sext_narrow_input_uses1_combined
  simp_alive_peephole
  sorry
def trunc_lshr_sext_narrow_input_uses2_combined := [llvmfunc|
  llvm.func @trunc_lshr_sext_narrow_input_uses2(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.lshr %1, %0  : i32
    llvm.call @use_i32(%2) : (i32) -> ()
    %3 = llvm.trunc %2 : i32 to i16
    llvm.return %3 : i16
  }]

theorem inst_combine_trunc_lshr_sext_narrow_input_uses2   : trunc_lshr_sext_narrow_input_uses2_before  ⊑  trunc_lshr_sext_narrow_input_uses2_combined := by
  unfold trunc_lshr_sext_narrow_input_uses2_before trunc_lshr_sext_narrow_input_uses2_combined
  simp_alive_peephole
  sorry
def trunc_lshr_sext_narrow_input_uses3_combined := [llvmfunc|
  llvm.func @trunc_lshr_sext_narrow_input_uses3(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<6> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi8> to vector<2xi32>
    llvm.call @use_v2i32(%1) : (vector<2xi32>) -> ()
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    llvm.call @use_v2i32(%2) : (vector<2xi32>) -> ()
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

theorem inst_combine_trunc_lshr_sext_narrow_input_uses3   : trunc_lshr_sext_narrow_input_uses3_before  ⊑  trunc_lshr_sext_narrow_input_uses3_combined := by
  unfold trunc_lshr_sext_narrow_input_uses3_before trunc_lshr_sext_narrow_input_uses3_combined
  simp_alive_peephole
  sorry
def trunc_lshr_overshift_narrow_input_sext_combined := [llvmfunc|
  llvm.func @trunc_lshr_overshift_narrow_input_sext(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.ashr %arg0, %0  : vector<2xi8>
    %2 = llvm.sext %1 : vector<2xi8> to vector<2xi16>
    llvm.return %2 : vector<2xi16>
  }]

theorem inst_combine_trunc_lshr_overshift_narrow_input_sext   : trunc_lshr_overshift_narrow_input_sext_before  ⊑  trunc_lshr_overshift_narrow_input_sext_combined := by
  unfold trunc_lshr_overshift_narrow_input_sext_before trunc_lshr_overshift_narrow_input_sext_combined
  simp_alive_peephole
  sorry
def trunc_lshr_overshift_sext_narrow_input_uses1_combined := [llvmfunc|
  llvm.func @trunc_lshr_overshift_sext_narrow_input_uses1(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.sext %arg0 : i8 to i32
    llvm.call @use_i32(%1) : (i32) -> ()
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.sext %2 : i8 to i16
    llvm.return %3 : i16
  }]

theorem inst_combine_trunc_lshr_overshift_sext_narrow_input_uses1   : trunc_lshr_overshift_sext_narrow_input_uses1_before  ⊑  trunc_lshr_overshift_sext_narrow_input_uses1_combined := by
  unfold trunc_lshr_overshift_sext_narrow_input_uses1_before trunc_lshr_overshift_sext_narrow_input_uses1_combined
  simp_alive_peephole
  sorry
def trunc_lshr_overshift_sext_narrow_input_uses2_combined := [llvmfunc|
  llvm.func @trunc_lshr_overshift_sext_narrow_input_uses2(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi8> to vector<2xi32>
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    llvm.call @use_v2i32(%2) : (vector<2xi32>) -> ()
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

theorem inst_combine_trunc_lshr_overshift_sext_narrow_input_uses2   : trunc_lshr_overshift_sext_narrow_input_uses2_before  ⊑  trunc_lshr_overshift_sext_narrow_input_uses2_combined := by
  unfold trunc_lshr_overshift_sext_narrow_input_uses2_before trunc_lshr_overshift_sext_narrow_input_uses2_combined
  simp_alive_peephole
  sorry
def trunc_lshr_overshift_sext_narrow_input_uses3_combined := [llvmfunc|
  llvm.func @trunc_lshr_overshift_sext_narrow_input_uses3(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    llvm.call @use_i32(%1) : (i32) -> ()
    %2 = llvm.lshr %1, %0  : i32
    llvm.call @use_i32(%2) : (i32) -> ()
    %3 = llvm.trunc %2 : i32 to i16
    llvm.return %3 : i16
  }]

theorem inst_combine_trunc_lshr_overshift_sext_narrow_input_uses3   : trunc_lshr_overshift_sext_narrow_input_uses3_before  ⊑  trunc_lshr_overshift_sext_narrow_input_uses3_combined := by
  unfold trunc_lshr_overshift_sext_narrow_input_uses3_before trunc_lshr_overshift_sext_narrow_input_uses3_combined
  simp_alive_peephole
  sorry
def trunc_lshr_overshift2_sext_combined := [llvmfunc|
  llvm.func @trunc_lshr_overshift2_sext(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<25> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi8> to vector<2xi32>
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_trunc_lshr_overshift2_sext   : trunc_lshr_overshift2_sext_before  ⊑  trunc_lshr_overshift2_sext_combined := by
  unfold trunc_lshr_overshift2_sext_before trunc_lshr_overshift2_sext_combined
  simp_alive_peephole
  sorry
def trunc_lshr_overshift2_sext_uses1_combined := [llvmfunc|
  llvm.func @trunc_lshr_overshift2_sext_uses1(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(25 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    llvm.call @use_i32(%1) : (i32) -> ()
    %2 = llvm.lshr %1, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    llvm.return %3 : i8
  }]

theorem inst_combine_trunc_lshr_overshift2_sext_uses1   : trunc_lshr_overshift2_sext_uses1_before  ⊑  trunc_lshr_overshift2_sext_uses1_combined := by
  unfold trunc_lshr_overshift2_sext_uses1_before trunc_lshr_overshift2_sext_uses1_combined
  simp_alive_peephole
  sorry
def trunc_lshr_overshift2_sext_uses2_combined := [llvmfunc|
  llvm.func @trunc_lshr_overshift2_sext_uses2(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<25> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi8> to vector<2xi32>
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    llvm.call @use_v2i32(%2) : (vector<2xi32>) -> ()
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_trunc_lshr_overshift2_sext_uses2   : trunc_lshr_overshift2_sext_uses2_before  ⊑  trunc_lshr_overshift2_sext_uses2_combined := by
  unfold trunc_lshr_overshift2_sext_uses2_before trunc_lshr_overshift2_sext_uses2_combined
  simp_alive_peephole
  sorry
def trunc_lshr_overshift2_sext_uses3_combined := [llvmfunc|
  llvm.func @trunc_lshr_overshift2_sext_uses3(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(25 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    llvm.call @use_i32(%1) : (i32) -> ()
    %2 = llvm.lshr %1, %0  : i32
    llvm.call @use_i32(%2) : (i32) -> ()
    %3 = llvm.trunc %2 : i32 to i8
    llvm.return %3 : i8
  }]

theorem inst_combine_trunc_lshr_overshift2_sext_uses3   : trunc_lshr_overshift2_sext_uses3_before  ⊑  trunc_lshr_overshift2_sext_uses3_combined := by
  unfold trunc_lshr_overshift2_sext_uses3_before trunc_lshr_overshift2_sext_uses3_combined
  simp_alive_peephole
  sorry
def trunc_lshr_zext_combined := [llvmfunc|
  llvm.func @trunc_lshr_zext(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.lshr %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_trunc_lshr_zext   : trunc_lshr_zext_before  ⊑  trunc_lshr_zext_combined := by
  unfold trunc_lshr_zext_before trunc_lshr_zext_combined
  simp_alive_peephole
  sorry
def trunc_lshr_zext_exact_combined := [llvmfunc|
  llvm.func @trunc_lshr_zext_exact(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.lshr %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_trunc_lshr_zext_exact   : trunc_lshr_zext_exact_before  ⊑  trunc_lshr_zext_exact_combined := by
  unfold trunc_lshr_zext_exact_before trunc_lshr_zext_exact_combined
  simp_alive_peephole
  sorry
def trunc_lshr_zext_uniform_combined := [llvmfunc|
  llvm.func @trunc_lshr_zext_uniform(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<6> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.lshr %arg0, %0  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_trunc_lshr_zext_uniform   : trunc_lshr_zext_uniform_before  ⊑  trunc_lshr_zext_uniform_combined := by
  unfold trunc_lshr_zext_uniform_before trunc_lshr_zext_uniform_combined
  simp_alive_peephole
  sorry
def trunc_lshr_zext_uniform_poison_combined := [llvmfunc|
  llvm.func @trunc_lshr_zext_uniform_poison(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.lshr %arg0, %6  : vector<2xi8>
    llvm.return %7 : vector<2xi8>
  }]

theorem inst_combine_trunc_lshr_zext_uniform_poison   : trunc_lshr_zext_uniform_poison_before  ⊑  trunc_lshr_zext_uniform_poison_combined := by
  unfold trunc_lshr_zext_uniform_poison_before trunc_lshr_zext_uniform_poison_combined
  simp_alive_peephole
  sorry
def trunc_lshr_zext_nonuniform_combined := [llvmfunc|
  llvm.func @trunc_lshr_zext_nonuniform(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[6, 2]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.lshr %arg0, %0  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_trunc_lshr_zext_nonuniform   : trunc_lshr_zext_nonuniform_before  ⊑  trunc_lshr_zext_nonuniform_combined := by
  unfold trunc_lshr_zext_nonuniform_before trunc_lshr_zext_nonuniform_combined
  simp_alive_peephole
  sorry
def trunc_lshr_zext_nonuniform_poison_combined := [llvmfunc|
  llvm.func @trunc_lshr_zext_nonuniform_poison(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.constant(6 : i8) : i8
    %3 = llvm.mlir.undef : vector<3xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<3xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<3xi8>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<3xi8>
    %10 = llvm.lshr %arg0, %9  : vector<3xi8>
    llvm.return %10 : vector<3xi8>
  }]

theorem inst_combine_trunc_lshr_zext_nonuniform_poison   : trunc_lshr_zext_nonuniform_poison_before  ⊑  trunc_lshr_zext_nonuniform_poison_combined := by
  unfold trunc_lshr_zext_nonuniform_poison_before trunc_lshr_zext_nonuniform_poison_combined
  simp_alive_peephole
  sorry
def trunc_lshr_zext_uses1_combined := [llvmfunc|
  llvm.func @trunc_lshr_zext_uses1(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<6> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.zext %arg0 : vector<2xi8> to vector<2xi32>
    llvm.call @use_v2i32(%1) : (vector<2xi32>) -> ()
    %2 = llvm.lshr %arg0, %0  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

theorem inst_combine_trunc_lshr_zext_uses1   : trunc_lshr_zext_uses1_before  ⊑  trunc_lshr_zext_uses1_combined := by
  unfold trunc_lshr_zext_uses1_before trunc_lshr_zext_uses1_combined
  simp_alive_peephole
  sorry
def pr33078_1_combined := [llvmfunc|
  llvm.func @pr33078_1(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_pr33078_1   : pr33078_1_before  ⊑  pr33078_1_combined := by
  unfold pr33078_1_before pr33078_1_combined
  simp_alive_peephole
  sorry
def pr33078_2_combined := [llvmfunc|
  llvm.func @pr33078_2(%arg0: i8) -> i12 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    %2 = llvm.sext %1 : i8 to i12
    llvm.return %2 : i12
  }]

theorem inst_combine_pr33078_2   : pr33078_2_before  ⊑  pr33078_2_combined := by
  unfold pr33078_2_before pr33078_2_combined
  simp_alive_peephole
  sorry
def pr33078_3_combined := [llvmfunc|
  llvm.func @pr33078_3(%arg0: i8) -> i4 {
    %0 = llvm.mlir.constant(12 : i16) : i16
    %1 = llvm.sext %arg0 : i8 to i16
    %2 = llvm.lshr %1, %0  : i16
    %3 = llvm.trunc %2 : i16 to i4
    llvm.return %3 : i4
  }]

theorem inst_combine_pr33078_3   : pr33078_3_before  ⊑  pr33078_3_combined := by
  unfold pr33078_3_before pr33078_3_combined
  simp_alive_peephole
  sorry
def pr33078_4_combined := [llvmfunc|
  llvm.func @pr33078_4(%arg0: i3) -> i8 {
    %0 = llvm.mlir.constant(13 : i16) : i16
    %1 = llvm.sext %arg0 : i3 to i16
    %2 = llvm.lshr %1, %0  : i16
    %3 = llvm.trunc %2 : i16 to i8
    llvm.return %3 : i8
  }]

theorem inst_combine_pr33078_4   : pr33078_4_before  ⊑  pr33078_4_combined := by
  unfold pr33078_4_before pr33078_4_combined
  simp_alive_peephole
  sorry
def test94_combined := [llvmfunc|
  llvm.func @test94(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    %2 = llvm.sext %1 : i1 to i64
    llvm.return %2 : i64
  }]

theorem inst_combine_test94   : test94_before  ⊑  test94_combined := by
  unfold test94_before test94_combined
  simp_alive_peephole
  sorry
def test95_combined := [llvmfunc|
  llvm.func @test95(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(40 : i32) : i32
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.or %4, %2  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_test95   : test95_before  ⊑  test95_combined := by
  unfold test95_before test95_combined
  simp_alive_peephole
  sorry
