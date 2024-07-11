import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  bswap
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.constant(65280 : i32) : i32
    %3 = llvm.mlir.constant(16711680 : i32) : i32
    %4 = llvm.lshr %arg0, %0  : i32
    %5 = llvm.lshr %arg0, %1  : i32
    %6 = llvm.and %5, %2  : i32
    %7 = llvm.or %4, %6  : i32
    %8 = llvm.shl %arg0, %1  : i32
    %9 = llvm.and %8, %3  : i32
    %10 = llvm.or %7, %9  : i32
    %11 = llvm.shl %arg0, %0  : i32
    %12 = llvm.or %10, %11  : i32
    llvm.return %12 : i32
  }]

def test1_vector_before := [llvmfunc|
  llvm.func @test1_vector(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<24> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<65280> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<16711680> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.lshr %arg0, %0  : vector<2xi32>
    %5 = llvm.lshr %arg0, %1  : vector<2xi32>
    %6 = llvm.and %5, %2  : vector<2xi32>
    %7 = llvm.or %4, %6  : vector<2xi32>
    %8 = llvm.shl %arg0, %1  : vector<2xi32>
    %9 = llvm.and %8, %3  : vector<2xi32>
    %10 = llvm.or %7, %9  : vector<2xi32>
    %11 = llvm.shl %arg0, %0  : vector<2xi32>
    %12 = llvm.or %10, %11  : vector<2xi32>
    llvm.return %12 : vector<2xi32>
  }]

def test1_trunc_before := [llvmfunc|
  llvm.func @test1_trunc(%arg0: i32) -> i16 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.constant(65280 : i32) : i32
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.and %4, %2  : i32
    %6 = llvm.or %3, %5  : i32
    %7 = llvm.trunc %6 : i32 to i16
    llvm.return %7 : i16
  }]

def test1_trunc_extra_use_before := [llvmfunc|
  llvm.func @test1_trunc_extra_use(%arg0: i32) -> i16 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.constant(65280 : i32) : i32
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.and %4, %2  : i32
    %6 = llvm.or %3, %5  : i32
    llvm.call @extra_use(%6) : (i32) -> ()
    %7 = llvm.trunc %6 : i32 to i16
    llvm.return %7 : i16
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.constant(16711680 : i32) : i32
    %3 = llvm.mlir.constant(65280 : i32) : i32
    %4 = llvm.shl %arg0, %0  : i32
    %5 = llvm.shl %arg0, %1  : i32
    %6 = llvm.and %5, %2  : i32
    %7 = llvm.or %4, %6  : i32
    %8 = llvm.lshr %arg0, %1  : i32
    %9 = llvm.and %8, %3  : i32
    %10 = llvm.or %7, %9  : i32
    %11 = llvm.lshr %arg0, %0  : i32
    %12 = llvm.or %10, %11  : i32
    llvm.return %12 : i32
  }]

def test2_vector_before := [llvmfunc|
  llvm.func @test2_vector(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<24> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<16711680> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<65280> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.shl %arg0, %0  : vector<2xi32>
    %5 = llvm.shl %arg0, %1  : vector<2xi32>
    %6 = llvm.and %5, %2  : vector<2xi32>
    %7 = llvm.or %4, %6  : vector<2xi32>
    %8 = llvm.lshr %arg0, %1  : vector<2xi32>
    %9 = llvm.and %8, %3  : vector<2xi32>
    %10 = llvm.or %7, %9  : vector<2xi32>
    %11 = llvm.lshr %arg0, %0  : vector<2xi32>
    %12 = llvm.or %10, %11  : vector<2xi32>
    llvm.return %12 : vector<2xi32>
  }]

def test2_vector_poison_before := [llvmfunc|
  llvm.func @test2_vector_poison(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(24 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %8 = llvm.mlir.constant(16711680 : i32) : i32
    %9 = llvm.mlir.undef : vector<2xi32>
    %10 = llvm.mlir.constant(0 : i32) : i32
    %11 = llvm.insertelement %8, %9[%10 : i32] : vector<2xi32>
    %12 = llvm.mlir.constant(1 : i32) : i32
    %13 = llvm.insertelement %0, %11[%12 : i32] : vector<2xi32>
    %14 = llvm.mlir.constant(65280 : i32) : i32
    %15 = llvm.mlir.undef : vector<2xi32>
    %16 = llvm.mlir.constant(0 : i32) : i32
    %17 = llvm.insertelement %14, %15[%16 : i32] : vector<2xi32>
    %18 = llvm.mlir.constant(1 : i32) : i32
    %19 = llvm.insertelement %0, %17[%18 : i32] : vector<2xi32>
    %20 = llvm.shl %arg0, %6  : vector<2xi32>
    %21 = llvm.shl %arg0, %7  : vector<2xi32>
    %22 = llvm.and %21, %13  : vector<2xi32>
    %23 = llvm.or %20, %22  : vector<2xi32>
    %24 = llvm.lshr %arg0, %7  : vector<2xi32>
    %25 = llvm.and %24, %19  : vector<2xi32>
    %26 = llvm.or %23, %25  : vector<2xi32>
    %27 = llvm.lshr %arg0, %6  : vector<2xi32>
    %28 = llvm.or %26, %27  : vector<2xi32>
    llvm.return %28 : vector<2xi32>
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.lshr %arg0, %0  : i16
    %2 = llvm.shl %arg0, %0  : i16
    %3 = llvm.or %1, %2  : i16
    llvm.return %3 : i16
  }]

def test3_vector_before := [llvmfunc|
  llvm.func @test3_vector(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.lshr %arg0, %0  : vector<2xi16>
    %2 = llvm.shl %arg0, %0  : vector<2xi16>
    %3 = llvm.or %1, %2  : vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

def test3_vector_poison_before := [llvmfunc|
  llvm.func @test3_vector_poison(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.mlir.poison : i16
    %2 = llvm.mlir.undef : vector<2xi16>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi16>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi16>
    %7 = llvm.mlir.undef : vector<2xi16>
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<2xi16>
    %10 = llvm.mlir.constant(1 : i32) : i32
    %11 = llvm.insertelement %1, %9[%10 : i32] : vector<2xi16>
    %12 = llvm.lshr %arg0, %6  : vector<2xi16>
    %13 = llvm.shl %arg0, %11  : vector<2xi16>
    %14 = llvm.or %12, %13  : vector<2xi16>
    llvm.return %14 : vector<2xi16>
  }]

def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.lshr %arg0, %0  : i16
    %2 = llvm.shl %arg0, %0  : i16
    %3 = llvm.or %2, %1  : i16
    llvm.return %3 : i16
  }]

def test4_vector_before := [llvmfunc|
  llvm.func @test4_vector(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.lshr %arg0, %0  : vector<2xi16>
    %2 = llvm.shl %arg0, %0  : vector<2xi16>
    %3 = llvm.or %2, %1  : vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

def test5_before := [llvmfunc|
  llvm.func @test5(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(65280 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.constant(255 : i32) : i32
    %3 = llvm.zext %arg0 : i16 to i32
    %4 = llvm.and %3, %0  : i32
    %5 = llvm.ashr %4, %1  : i32
    %6 = llvm.trunc %5 : i32 to i16
    %7 = llvm.and %3, %2  : i32
    %8 = llvm.shl %7, %1  : i32
    %9 = llvm.trunc %8 : i32 to i16
    %10 = llvm.or %6, %9  : i16
    %11 = llvm.bitcast %10 : i16 to i16
    %12 = llvm.zext %11 : i16 to i32
    %13 = llvm.trunc %12 : i32 to i16
    llvm.return %13 : i16
  }]

def test5_vector_before := [llvmfunc|
  llvm.func @test5_vector(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<65280> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<255> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.zext %arg0 : vector<2xi16> to vector<2xi32>
    %4 = llvm.and %3, %0  : vector<2xi32>
    %5 = llvm.ashr %4, %1  : vector<2xi32>
    %6 = llvm.trunc %5 : vector<2xi32> to vector<2xi16>
    %7 = llvm.and %3, %2  : vector<2xi32>
    %8 = llvm.shl %7, %1  : vector<2xi32>
    %9 = llvm.trunc %8 : vector<2xi32> to vector<2xi16>
    %10 = llvm.or %6, %9  : vector<2xi16>
    %11 = llvm.bitcast %10 : vector<2xi16> to vector<2xi16>
    %12 = llvm.zext %11 : vector<2xi16> to vector<2xi32>
    %13 = llvm.trunc %12 : vector<2xi32> to vector<2xi16>
    llvm.return %13 : vector<2xi16>
  }]

def test6_before := [llvmfunc|
  llvm.func @test6(%arg0: i32) -> i32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(65280 : i32) : i32
    %2 = llvm.mlir.constant(255 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.mlir.constant(24 : i32) : i32
    %5 = llvm.shl %arg0, %0  : i32
    %6 = llvm.and %arg0, %1  : i32
    %7 = llvm.lshr %arg0, %0  : i32
    %8 = llvm.and %7, %2  : i32
    %9 = llvm.or %6, %5  : i32
    %10 = llvm.or %9, %8  : i32
    %11 = llvm.shl %10, %3  : i32
    %12 = llvm.lshr %arg0, %4  : i32
    %13 = llvm.or %11, %12  : i32
    llvm.return %13 : i32
  }]

def test6_vector_before := [llvmfunc|
  llvm.func @test6_vector(%arg0: vector<2xi32>) -> vector<2xi32> attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<65280> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<255> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.mlir.constant(dense<24> : vector<2xi32>) : vector<2xi32>
    %5 = llvm.shl %arg0, %0  : vector<2xi32>
    %6 = llvm.and %arg0, %1  : vector<2xi32>
    %7 = llvm.lshr %arg0, %0  : vector<2xi32>
    %8 = llvm.and %7, %2  : vector<2xi32>
    %9 = llvm.or %6, %5  : vector<2xi32>
    %10 = llvm.or %9, %8  : vector<2xi32>
    %11 = llvm.shl %10, %3  : vector<2xi32>
    %12 = llvm.lshr %arg0, %4  : vector<2xi32>
    %13 = llvm.or %11, %12  : vector<2xi32>
    llvm.return %13 : vector<2xi32>
  }]

def bswap32_and_first_before := [llvmfunc|
  llvm.func @bswap32_and_first(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(16711935 : i32) : i32
    %2 = llvm.mlir.constant(8 : i32) : i32
    %3 = llvm.shl %arg0, %0  : i32
    %4 = llvm.lshr %arg0, %0  : i32
    %5 = llvm.or %3, %4  : i32
    %6 = llvm.and %5, %1  : i32
    %7 = llvm.shl %6, %2 overflow<nuw>  : i32
    %8 = llvm.lshr %5, %2  : i32
    %9 = llvm.and %8, %1  : i32
    %10 = llvm.or %7, %9  : i32
    llvm.return %10 : i32
  }]

def bswap32_and_first_extra_use_before := [llvmfunc|
  llvm.func @bswap32_and_first_extra_use(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(16711935 : i32) : i32
    %2 = llvm.mlir.constant(8 : i32) : i32
    %3 = llvm.shl %arg0, %0  : i32
    %4 = llvm.lshr %arg0, %0  : i32
    %5 = llvm.or %3, %4  : i32
    %6 = llvm.and %5, %1  : i32
    %7 = llvm.shl %6, %2 overflow<nuw>  : i32
    %8 = llvm.lshr %5, %2  : i32
    %9 = llvm.and %8, %1  : i32
    %10 = llvm.or %7, %9  : i32
    llvm.call @extra_use(%6) : (i32) -> ()
    llvm.return %10 : i32
  }]

def bswap32_shl_first_before := [llvmfunc|
  llvm.func @bswap32_shl_first(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.constant(-16711936 : i32) : i32
    %3 = llvm.mlir.constant(16711935 : i32) : i32
    %4 = llvm.shl %arg0, %0  : i32
    %5 = llvm.lshr %arg0, %0  : i32
    %6 = llvm.or %4, %5  : i32
    %7 = llvm.shl %6, %1  : i32
    %8 = llvm.and %7, %2  : i32
    %9 = llvm.lshr %6, %1  : i32
    %10 = llvm.and %9, %3  : i32
    %11 = llvm.or %8, %10  : i32
    llvm.return %11 : i32
  }]

def bswap32_shl_first_extra_use_before := [llvmfunc|
  llvm.func @bswap32_shl_first_extra_use(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.constant(-16711936 : i32) : i32
    %3 = llvm.mlir.constant(16711935 : i32) : i32
    %4 = llvm.shl %arg0, %0  : i32
    %5 = llvm.lshr %arg0, %0  : i32
    %6 = llvm.or %4, %5  : i32
    %7 = llvm.shl %6, %1  : i32
    %8 = llvm.and %7, %2  : i32
    %9 = llvm.lshr %6, %1  : i32
    %10 = llvm.and %9, %3  : i32
    %11 = llvm.or %8, %10  : i32
    llvm.call @extra_use(%7) : (i32) -> ()
    llvm.return %11 : i32
  }]

def test8_before := [llvmfunc|
  llvm.func @test8(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.zext %arg0 : i16 to i32
    %3 = llvm.lshr %arg0, %0  : i16
    %4 = llvm.shl %2, %1  : i32
    %5 = llvm.zext %3 : i16 to i32
    %6 = llvm.or %5, %4  : i32
    %7 = llvm.trunc %6 : i32 to i16
    llvm.return %7 : i16
  }]

def test9_before := [llvmfunc|
  llvm.func @test9(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.zext %arg0 : i16 to i32
    %2 = llvm.lshr %1, %0  : i32
    %3 = llvm.shl %1, %0  : i32
    %4 = llvm.or %2, %3  : i32
    %5 = llvm.trunc %4 : i32 to i16
    llvm.return %5 : i16
  }]

def test10_before := [llvmfunc|
  llvm.func @test10(%arg0: i32) -> i16 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(255 : i32) : i32
    %2 = llvm.mlir.constant(65280 : i32) : i32
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.shl %arg0, %0  : i32
    %6 = llvm.and %5, %2  : i32
    %7 = llvm.or %4, %6  : i32
    %8 = llvm.trunc %7 : i32 to i16
    llvm.return %8 : i16
  }]

def test10_vector_before := [llvmfunc|
  llvm.func @test10_vector(%arg0: vector<2xi32>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<255> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<65280> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.lshr %arg0, %0  : vector<2xi32>
    %4 = llvm.and %3, %1  : vector<2xi32>
    %5 = llvm.shl %arg0, %0  : vector<2xi32>
    %6 = llvm.and %5, %2  : vector<2xi32>
    %7 = llvm.or %4, %6  : vector<2xi32>
    %8 = llvm.trunc %7 : vector<2xi32> to vector<2xi16>
    llvm.return %8 : vector<2xi16>
  }]

def PR39793_bswap_u64_as_u32_before := [llvmfunc|
  llvm.func @PR39793_bswap_u64_as_u32(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(24 : i64) : i64
    %1 = llvm.mlir.constant(255 : i64) : i64
    %2 = llvm.mlir.constant(8 : i64) : i64
    %3 = llvm.mlir.constant(65280 : i64) : i64
    %4 = llvm.mlir.constant(16711680 : i64) : i64
    %5 = llvm.mlir.constant(4278190080 : i64) : i64
    %6 = llvm.lshr %arg0, %0  : i64
    %7 = llvm.and %6, %1  : i64
    %8 = llvm.lshr %arg0, %2  : i64
    %9 = llvm.and %8, %3  : i64
    %10 = llvm.or %7, %9  : i64
    %11 = llvm.shl %arg0, %2  : i64
    %12 = llvm.and %11, %4  : i64
    %13 = llvm.or %10, %12  : i64
    %14 = llvm.shl %arg0, %0  : i64
    %15 = llvm.and %14, %5  : i64
    %16 = llvm.or %13, %15  : i64
    llvm.return %16 : i64
  }]

def PR39793_bswap_u64_as_u32_trunc_before := [llvmfunc|
  llvm.func @PR39793_bswap_u64_as_u32_trunc(%arg0: i64) -> i16 {
    %0 = llvm.mlir.constant(24 : i64) : i64
    %1 = llvm.mlir.constant(255 : i64) : i64
    %2 = llvm.mlir.constant(8 : i64) : i64
    %3 = llvm.mlir.constant(65280 : i64) : i64
    %4 = llvm.mlir.constant(16711680 : i64) : i64
    %5 = llvm.mlir.constant(4278190080 : i64) : i64
    %6 = llvm.lshr %arg0, %0  : i64
    %7 = llvm.and %6, %1  : i64
    %8 = llvm.lshr %arg0, %2  : i64
    %9 = llvm.and %8, %3  : i64
    %10 = llvm.or %7, %9  : i64
    %11 = llvm.shl %arg0, %2  : i64
    %12 = llvm.and %11, %4  : i64
    %13 = llvm.or %10, %12  : i64
    %14 = llvm.shl %arg0, %0  : i64
    %15 = llvm.and %14, %5  : i64
    %16 = llvm.or %13, %15  : i64
    %17 = llvm.trunc %16 : i64 to i16
    llvm.return %17 : i16
  }]

def PR39793_bswap_u64_as_u16_before := [llvmfunc|
  llvm.func @PR39793_bswap_u64_as_u16(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(8 : i64) : i64
    %1 = llvm.mlir.constant(255 : i64) : i64
    %2 = llvm.mlir.constant(65280 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i64
    %4 = llvm.and %3, %1  : i64
    %5 = llvm.shl %arg0, %0  : i64
    %6 = llvm.and %5, %2  : i64
    %7 = llvm.or %4, %6  : i64
    llvm.return %7 : i64
  }]

def PR39793_bswap_u64_as_u16_vector_before := [llvmfunc|
  llvm.func @PR39793_bswap_u64_as_u16_vector(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<255> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.mlir.constant(dense<65280> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.lshr %arg0, %0  : vector<2xi64>
    %4 = llvm.and %3, %1  : vector<2xi64>
    %5 = llvm.shl %arg0, %0  : vector<2xi64>
    %6 = llvm.and %5, %2  : vector<2xi64>
    %7 = llvm.or %4, %6  : vector<2xi64>
    llvm.return %7 : vector<2xi64>
  }]

def PR39793_bswap_u64_as_u16_trunc_before := [llvmfunc|
  llvm.func @PR39793_bswap_u64_as_u16_trunc(%arg0: i64) -> i8 {
    %0 = llvm.mlir.constant(8 : i64) : i64
    %1 = llvm.mlir.constant(255 : i64) : i64
    %2 = llvm.mlir.constant(65280 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i64
    %4 = llvm.and %3, %1  : i64
    %5 = llvm.shl %arg0, %0  : i64
    %6 = llvm.and %5, %2  : i64
    %7 = llvm.or %4, %6  : i64
    %8 = llvm.trunc %7 : i64 to i8
    llvm.return %8 : i8
  }]

def PR39793_bswap_u50_as_u16_before := [llvmfunc|
  llvm.func @PR39793_bswap_u50_as_u16(%arg0: i50) -> i50 {
    %0 = llvm.mlir.constant(8 : i50) : i50
    %1 = llvm.mlir.constant(255 : i50) : i50
    %2 = llvm.mlir.constant(65280 : i50) : i50
    %3 = llvm.lshr %arg0, %0  : i50
    %4 = llvm.and %3, %1  : i50
    %5 = llvm.shl %arg0, %0  : i50
    %6 = llvm.and %5, %2  : i50
    %7 = llvm.or %4, %6  : i50
    llvm.return %7 : i50
  }]

def PR39793_bswap_u32_as_u16_before := [llvmfunc|
  llvm.func @PR39793_bswap_u32_as_u16(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(255 : i32) : i32
    %2 = llvm.mlir.constant(65280 : i32) : i32
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.shl %arg0, %0  : i32
    %6 = llvm.and %5, %2  : i32
    %7 = llvm.or %4, %6  : i32
    llvm.return %7 : i32
  }]

def PR39793_bswap_u32_as_u16_trunc_before := [llvmfunc|
  llvm.func @PR39793_bswap_u32_as_u16_trunc(%arg0: i32) -> i8 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(255 : i32) : i32
    %2 = llvm.mlir.constant(65280 : i32) : i32
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.shl %arg0, %0  : i32
    %6 = llvm.and %5, %2  : i32
    %7 = llvm.or %4, %6  : i32
    %8 = llvm.trunc %7 : i32 to i8
    llvm.return %8 : i8
  }]

def partial_bswap_before := [llvmfunc|
  llvm.func @partial_bswap(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.constant(16711680 : i32) : i32
    %3 = llvm.mlir.constant(-65536 : i32) : i32
    %4 = llvm.shl %arg0, %0  : i32
    %5 = llvm.shl %arg0, %1  : i32
    %6 = llvm.and %5, %2  : i32
    %7 = llvm.or %4, %6  : i32
    %8 = llvm.and %arg0, %3  : i32
    %9 = llvm.intr.bswap(%8)  : (i32) -> i32
    %10 = llvm.or %7, %9  : i32
    llvm.return %10 : i32
  }]

def partial_bswap_vector_before := [llvmfunc|
  llvm.func @partial_bswap_vector(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<24> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<16711680> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<-65536> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.shl %arg0, %0  : vector<2xi32>
    %5 = llvm.shl %arg0, %1  : vector<2xi32>
    %6 = llvm.and %5, %2  : vector<2xi32>
    %7 = llvm.or %4, %6  : vector<2xi32>
    %8 = llvm.and %arg0, %3  : vector<2xi32>
    %9 = llvm.intr.bswap(%8)  : (vector<2xi32>) -> vector<2xi32>
    %10 = llvm.or %7, %9  : vector<2xi32>
    llvm.return %10 : vector<2xi32>
  }]

def partial_bitreverse_before := [llvmfunc|
  llvm.func @partial_bitreverse(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(255 : i16) : i16
    %1 = llvm.mlir.constant(-256 : i16) : i16
    %2 = llvm.mlir.constant(8 : i16) : i16
    %3 = llvm.intr.bitreverse(%arg0)  : (i16) -> i16
    %4 = llvm.and %3, %0  : i16
    %5 = llvm.and %3, %1  : i16
    %6 = llvm.intr.bitreverse(%4)  : (i16) -> i16
    %7 = llvm.intr.bitreverse(%5)  : (i16) -> i16
    %8 = llvm.lshr %6, %2  : i16
    %9 = llvm.shl %7, %2  : i16
    %10 = llvm.or %8, %9  : i16
    llvm.return %10 : i16
  }]

def bswap_and_mask_0_before := [llvmfunc|
  llvm.func @bswap_and_mask_0(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(56 : i64) : i64
    %1 = llvm.lshr %arg0, %0  : i64
    %2 = llvm.shl %arg0, %0  : i64
    %3 = llvm.or %1, %2  : i64
    llvm.return %3 : i64
  }]

def bswap_and_mask_1_before := [llvmfunc|
  llvm.func @bswap_and_mask_1(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(56 : i64) : i64
    %1 = llvm.mlir.constant(40 : i64) : i64
    %2 = llvm.mlir.constant(65280 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i64
    %4 = llvm.lshr %arg0, %1  : i64
    %5 = llvm.and %4, %2  : i64
    %6 = llvm.or %5, %3  : i64
    llvm.return %6 : i64
  }]

def bswap_and_mask_2_before := [llvmfunc|
  llvm.func @bswap_and_mask_2(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(56 : i64) : i64
    %1 = llvm.mlir.constant(40 : i64) : i64
    %2 = llvm.mlir.constant(71776119061217280 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i64
    %4 = llvm.shl %arg0, %0  : i64
    %5 = llvm.or %3, %4  : i64
    %6 = llvm.shl %arg0, %1  : i64
    %7 = llvm.and %6, %2  : i64
    %8 = llvm.or %5, %7  : i64
    llvm.return %8 : i64
  }]

def bswap_trunc_before := [llvmfunc|
  llvm.func @bswap_trunc(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(56 : i64) : i64
    %1 = llvm.mlir.constant(8 : i64) : i64
    %2 = llvm.mlir.constant(40 : i64) : i64
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.mlir.constant(24 : i64) : i64
    %5 = llvm.shl %arg0, %0  : i64
    %6 = llvm.lshr %arg0, %1  : i64
    %7 = llvm.lshr %arg0, %2  : i64
    %8 = llvm.trunc %6 : i64 to i32
    %9 = llvm.trunc %7 : i64 to i32
    %10 = llvm.intr.bswap(%8)  : (i32) -> i32
    %11 = llvm.intr.bswap(%9)  : (i32) -> i32
    %12 = llvm.lshr %11, %3  : i32
    %13 = llvm.zext %10 : i32 to i64
    %14 = llvm.zext %12 : i32 to i64
    %15 = llvm.shl %13, %4  : i64
    %16 = llvm.or %14, %15  : i64
    %17 = llvm.or %16, %5  : i64
    llvm.return %17 : i64
  }]

def shuf_4bytes_before := [llvmfunc|
  llvm.func @shuf_4bytes(%arg0: vector<4xi8>) -> i32 {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.shufflevector %arg0, %0 [3, 2, 1, 0] : vector<4xi8> 
    %2 = llvm.bitcast %1 : vector<4xi8> to i32
    llvm.return %2 : i32
  }]

def shuf_load_4bytes_before := [llvmfunc|
  llvm.func @shuf_load_4bytes(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> vector<4xi8>]

    %2 = llvm.shufflevector %1, %0 [3, 2, -1, 0] : vector<4xi8> 
    %3 = llvm.bitcast %2 : vector<4xi8> to i32
    llvm.return %3 : i32
  }]

def shuf_bitcast_twice_4bytes_before := [llvmfunc|
  llvm.func @shuf_bitcast_twice_4bytes(%arg0: i32) -> i32 {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.bitcast %arg0 : i32 to vector<4xi8>
    %2 = llvm.shufflevector %1, %0 [-1, 2, 1, 0] : vector<4xi8> 
    %3 = llvm.bitcast %2 : vector<4xi8> to i32
    llvm.return %3 : i32
  }]

def shuf_4bytes_extra_use_before := [llvmfunc|
  llvm.func @shuf_4bytes_extra_use(%arg0: vector<4xi8>) -> i32 {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.shufflevector %arg0, %0 [3, 2, 1, 0] : vector<4xi8> 
    llvm.call @use(%1) : (vector<4xi8>) -> ()
    %2 = llvm.bitcast %1 : vector<4xi8> to i32
    llvm.return %2 : i32
  }]

def shuf_16bytes_before := [llvmfunc|
  llvm.func @shuf_16bytes(%arg0: vector<16xi8>) -> i128 {
    %0 = llvm.mlir.poison : vector<16xi8>
    %1 = llvm.shufflevector %arg0, %0 [15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0] : vector<16xi8> 
    %2 = llvm.bitcast %1 : vector<16xi8> to i128
    llvm.return %2 : i128
  }]

def shuf_2bytes_widening_before := [llvmfunc|
  llvm.func @shuf_2bytes_widening(%arg0: vector<2xi8>) -> i32 {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.shufflevector %arg0, %0 [1, 0, -1, -1] : vector<2xi8> 
    %2 = llvm.bitcast %1 : vector<4xi8> to i32
    llvm.return %2 : i32
  }]

def funnel_unary_before := [llvmfunc|
  llvm.func @funnel_unary(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(-16711936 : i32) : i32
    %2 = llvm.mlir.constant(16711935 : i32) : i32
    %3 = llvm.intr.fshl(%arg0, %arg0, %0)  : (i32, i32, i32) -> i32
    %4 = llvm.intr.fshr(%arg0, %arg0, %0)  : (i32, i32, i32) -> i32
    %5 = llvm.and %3, %1  : i32
    %6 = llvm.and %4, %2  : i32
    %7 = llvm.or %5, %6  : i32
    llvm.return %7 : i32
  }]

def funnel_binary_before := [llvmfunc|
  llvm.func @funnel_binary(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(24 : i32) : i32
    %2 = llvm.mlir.constant(-65536 : i32) : i32
    %3 = llvm.mlir.constant(65535 : i32) : i32
    %4 = llvm.shl %arg0, %0  : i32
    %5 = llvm.intr.fshl(%arg0, %4, %1)  : (i32, i32, i32) -> i32
    %6 = llvm.lshr %arg0, %0  : i32
    %7 = llvm.intr.fshr(%6, %arg0, %1)  : (i32, i32, i32) -> i32
    %8 = llvm.and %5, %2  : i32
    %9 = llvm.and %7, %3  : i32
    %10 = llvm.or %8, %9  : i32
    llvm.return %10 : i32
  }]

def funnel_and_before := [llvmfunc|
  llvm.func @funnel_and(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(65280 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.constant(16711680 : i32) : i32
    %3 = llvm.mlir.constant(24 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.intr.fshl(%4, %arg0, %1)  : (i32, i32, i32) -> i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.intr.fshl(%arg0, %6, %3)  : (i32, i32, i32) -> i32
    %8 = llvm.or %5, %7  : i32
    llvm.return %8 : i32
  }]

def trunc_bswap_i160_before := [llvmfunc|
  llvm.func @trunc_bswap_i160(%arg0: !llvm.ptr) -> i16 {
    %0 = llvm.mlir.constant(128 : i160) : i160
    %1 = llvm.mlir.constant(136 : i160) : i160
    %2 = llvm.mlir.constant(255 : i16) : i16
    %3 = llvm.mlir.constant(8 : i16) : i16
    %4 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i160]

    %5 = llvm.lshr %4, %0  : i160
    %6 = llvm.lshr %4, %1  : i160
    %7 = llvm.trunc %5 : i160 to i16
    %8 = llvm.trunc %6 : i160 to i16
    %9 = llvm.and %7, %2  : i16
    %10 = llvm.and %8, %2  : i16
    %11 = llvm.shl %9, %3  : i16
    %12 = llvm.or %10, %11  : i16
    llvm.return %12 : i16
  }]

def PR47191_problem1_before := [llvmfunc|
  llvm.func @PR47191_problem1(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(56 : i64) : i64
    %1 = llvm.mlir.constant(40 : i64) : i64
    %2 = llvm.mlir.constant(65280 : i64) : i64
    %3 = llvm.mlir.constant(24 : i64) : i64
    %4 = llvm.mlir.constant(16711680 : i64) : i64
    %5 = llvm.mlir.constant(8 : i64) : i64
    %6 = llvm.mlir.constant(4278190080 : i64) : i64
    %7 = llvm.mlir.constant(71776119061217280 : i64) : i64
    %8 = llvm.mlir.constant(280375465082880 : i64) : i64
    %9 = llvm.mlir.constant(1095216660480 : i64) : i64
    %10 = llvm.lshr %arg0, %0  : i64
    %11 = llvm.lshr %arg0, %1  : i64
    %12 = llvm.and %11, %2  : i64
    %13 = llvm.lshr %arg0, %3  : i64
    %14 = llvm.and %13, %4  : i64
    %15 = llvm.lshr %arg0, %5  : i64
    %16 = llvm.and %15, %6  : i64
    %17 = llvm.shl %arg0, %0  : i64
    %18 = llvm.shl %arg0, %1  : i64
    %19 = llvm.and %18, %7  : i64
    %20 = llvm.shl %arg0, %3  : i64
    %21 = llvm.and %20, %8  : i64
    %22 = llvm.or %17, %10  : i64
    %23 = llvm.or %22, %12  : i64
    %24 = llvm.or %23, %14  : i64
    %25 = llvm.or %24, %16  : i64
    %26 = llvm.or %25, %19  : i64
    %27 = llvm.or %26, %21  : i64
    %28 = llvm.shl %arg0, %5  : i64
    %29 = llvm.and %28, %9  : i64
    %30 = llvm.add %27, %29  : i64
    llvm.return %30 : i64
  }]

def PR47191_problem2_before := [llvmfunc|
  llvm.func @PR47191_problem2(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(56 : i64) : i64
    %1 = llvm.mlir.constant(40 : i64) : i64
    %2 = llvm.mlir.constant(65280 : i64) : i64
    %3 = llvm.mlir.constant(24 : i64) : i64
    %4 = llvm.mlir.constant(16711680 : i64) : i64
    %5 = llvm.mlir.constant(8 : i64) : i64
    %6 = llvm.mlir.constant(4278190080 : i64) : i64
    %7 = llvm.mlir.constant(71776119061217280 : i64) : i64
    %8 = llvm.mlir.constant(280375465082880 : i64) : i64
    %9 = llvm.mlir.constant(1095216660480 : i64) : i64
    %10 = llvm.lshr %arg0, %0  : i64
    %11 = llvm.lshr %arg0, %1  : i64
    %12 = llvm.and %11, %2  : i64
    %13 = llvm.lshr %arg0, %3  : i64
    %14 = llvm.and %13, %4  : i64
    %15 = llvm.lshr %arg0, %5  : i64
    %16 = llvm.and %15, %6  : i64
    %17 = llvm.shl %arg0, %0  : i64
    %18 = llvm.shl %arg0, %1  : i64
    %19 = llvm.and %18, %7  : i64
    %20 = llvm.or %17, %10  : i64
    %21 = llvm.or %20, %12  : i64
    %22 = llvm.or %21, %14  : i64
    %23 = llvm.or %22, %16  : i64
    %24 = llvm.or %23, %19  : i64
    %25 = llvm.shl %arg0, %3  : i64
    %26 = llvm.and %25, %8  : i64
    %27 = llvm.shl %arg0, %5  : i64
    %28 = llvm.and %27, %9  : i64
    %29 = llvm.or %28, %26  : i64
    %30 = llvm.xor %29, %24  : i64
    llvm.return %30 : i64
  }]

def PR47191_problem3_before := [llvmfunc|
  llvm.func @PR47191_problem3(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(56 : i64) : i64
    %1 = llvm.mlir.constant(40 : i64) : i64
    %2 = llvm.mlir.constant(65280 : i64) : i64
    %3 = llvm.mlir.constant(24 : i64) : i64
    %4 = llvm.mlir.constant(16711680 : i64) : i64
    %5 = llvm.mlir.constant(8 : i64) : i64
    %6 = llvm.mlir.constant(4278190080 : i64) : i64
    %7 = llvm.mlir.constant(71776119061217280 : i64) : i64
    %8 = llvm.mlir.constant(280375465082880 : i64) : i64
    %9 = llvm.mlir.constant(1095216660480 : i64) : i64
    %10 = llvm.lshr %arg0, %0  : i64
    %11 = llvm.lshr %arg0, %1  : i64
    %12 = llvm.and %11, %2  : i64
    %13 = llvm.lshr %arg0, %3  : i64
    %14 = llvm.and %13, %4  : i64
    %15 = llvm.lshr %arg0, %5  : i64
    %16 = llvm.and %15, %6  : i64
    %17 = llvm.shl %arg0, %0  : i64
    %18 = llvm.shl %arg0, %1  : i64
    %19 = llvm.and %18, %7  : i64
    %20 = llvm.or %17, %10  : i64
    %21 = llvm.or %20, %12  : i64
    %22 = llvm.or %21, %14  : i64
    %23 = llvm.or %22, %16  : i64
    %24 = llvm.or %23, %19  : i64
    %25 = llvm.shl %arg0, %3  : i64
    %26 = llvm.and %25, %8  : i64
    %27 = llvm.shl %arg0, %5  : i64
    %28 = llvm.and %27, %9  : i64
    %29 = llvm.or %28, %26  : i64
    %30 = llvm.xor %29, %24  : i64
    llvm.return %30 : i64
  }]

def PR47191_problem4_before := [llvmfunc|
  llvm.func @PR47191_problem4(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(56 : i64) : i64
    %1 = llvm.mlir.constant(40 : i64) : i64
    %2 = llvm.mlir.constant(65280 : i64) : i64
    %3 = llvm.mlir.constant(71776119061217280 : i64) : i64
    %4 = llvm.mlir.constant(24 : i64) : i64
    %5 = llvm.mlir.constant(16711680 : i64) : i64
    %6 = llvm.mlir.constant(280375465082880 : i64) : i64
    %7 = llvm.mlir.constant(8 : i64) : i64
    %8 = llvm.mlir.constant(4278190080 : i64) : i64
    %9 = llvm.mlir.constant(1095216660480 : i64) : i64
    %10 = llvm.lshr %arg0, %0  : i64
    %11 = llvm.shl %arg0, %0  : i64
    %12 = llvm.or %10, %11  : i64
    %13 = llvm.lshr %arg0, %1  : i64
    %14 = llvm.and %13, %2  : i64
    %15 = llvm.or %12, %14  : i64
    %16 = llvm.shl %arg0, %1  : i64
    %17 = llvm.and %16, %3  : i64
    %18 = llvm.or %15, %17  : i64
    %19 = llvm.lshr %arg0, %4  : i64
    %20 = llvm.and %19, %5  : i64
    %21 = llvm.or %18, %20  : i64
    %22 = llvm.shl %arg0, %4  : i64
    %23 = llvm.and %22, %6  : i64
    %24 = llvm.or %21, %23  : i64
    %25 = llvm.lshr %arg0, %7  : i64
    %26 = llvm.and %25, %8  : i64
    %27 = llvm.or %24, %26  : i64
    %28 = llvm.shl %arg0, %7  : i64
    %29 = llvm.and %28, %9  : i64
    %30 = llvm.add %27, %29  : i64
    llvm.return %30 : i64
  }]

def PR50910_before := [llvmfunc|
  llvm.func @PR50910(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(72057594037927935 : i64) : i64
    %1 = llvm.mlir.constant(56 : i64) : i64
    %2 = llvm.and %arg0, %0  : i64
    %3 = llvm.intr.bswap(%2)  : (i64) -> i64
    %4 = llvm.lshr %arg0, %1  : i64
    %5 = llvm.or %3, %4  : i64
    %6 = llvm.trunc %5 : i64 to i32
    llvm.return %6 : i32
  }]

def PR60690_call_fshl_before := [llvmfunc|
  llvm.func @PR60690_call_fshl(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(8 : i64) : i64
    %1 = llvm.mlir.constant(71777214294589695 : i64) : i64
    %2 = llvm.mlir.constant(-71777214294589696 : i64) : i64
    %3 = llvm.mlir.constant(16 : i64) : i64
    %4 = llvm.mlir.constant(-281470681808896 : i64) : i64
    %5 = llvm.mlir.constant(281470681808895 : i64) : i64
    %6 = llvm.mlir.constant(32 : i64) : i64
    %7 = llvm.lshr %arg0, %0  : i64
    %8 = llvm.and %7, %1  : i64
    %9 = llvm.shl %arg0, %0  : i64
    %10 = llvm.and %9, %2  : i64
    %11 = llvm.or %8, %10  : i64
    %12 = llvm.shl %11, %3  : i64
    %13 = llvm.and %12, %4  : i64
    %14 = llvm.lshr %11, %3  : i64
    %15 = llvm.and %14, %5  : i64
    %16 = llvm.or %13, %15  : i64
    %17 = llvm.intr.fshl(%16, %16, %6)  : (i64, i64, i64) -> i64
    llvm.return %17 : i64
  }]

def PR60690_call_fshr_before := [llvmfunc|
  llvm.func @PR60690_call_fshr(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(8 : i64) : i64
    %1 = llvm.mlir.constant(71777214294589695 : i64) : i64
    %2 = llvm.mlir.constant(-71777214294589696 : i64) : i64
    %3 = llvm.mlir.constant(16 : i64) : i64
    %4 = llvm.mlir.constant(-281470681808896 : i64) : i64
    %5 = llvm.mlir.constant(281470681808895 : i64) : i64
    %6 = llvm.mlir.constant(32 : i64) : i64
    %7 = llvm.lshr %arg0, %0  : i64
    %8 = llvm.and %7, %1  : i64
    %9 = llvm.shl %arg0, %0  : i64
    %10 = llvm.and %9, %2  : i64
    %11 = llvm.or %8, %10  : i64
    %12 = llvm.shl %11, %3  : i64
    %13 = llvm.and %12, %4  : i64
    %14 = llvm.lshr %11, %3  : i64
    %15 = llvm.and %14, %5  : i64
    %16 = llvm.or %13, %15  : i64
    %17 = llvm.intr.fshr(%16, %16, %6)  : (i64, i64, i64) -> i64
    llvm.return %17 : i64
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i32) -> i32 {
    %0 = llvm.intr.bswap(%arg0)  : (i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test1_vector_combined := [llvmfunc|
  llvm.func @test1_vector(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.intr.bswap(%arg0)  : (vector<2xi32>) -> vector<2xi32>
    llvm.return %0 : vector<2xi32>
  }]

theorem inst_combine_test1_vector   : test1_vector_before  ⊑  test1_vector_combined := by
  unfold test1_vector_before test1_vector_combined
  simp_alive_peephole
  sorry
def test1_trunc_combined := [llvmfunc|
  llvm.func @test1_trunc(%arg0: i32) -> i16 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.constant(65280 : i32) : i32
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.and %4, %2  : i32
    %6 = llvm.or %3, %5  : i32
    %7 = llvm.trunc %6 : i32 to i16
    llvm.return %7 : i16
  }]

theorem inst_combine_test1_trunc   : test1_trunc_before  ⊑  test1_trunc_combined := by
  unfold test1_trunc_before test1_trunc_combined
  simp_alive_peephole
  sorry
def test1_trunc_extra_use_combined := [llvmfunc|
  llvm.func @test1_trunc_extra_use(%arg0: i32) -> i16 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.constant(65280 : i32) : i32
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.and %4, %2  : i32
    %6 = llvm.or %3, %5  : i32
    llvm.call @extra_use(%6) : (i32) -> ()
    %7 = llvm.trunc %6 : i32 to i16
    llvm.return %7 : i16
  }]

theorem inst_combine_test1_trunc_extra_use   : test1_trunc_extra_use_before  ⊑  test1_trunc_extra_use_combined := by
  unfold test1_trunc_extra_use_before test1_trunc_extra_use_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i32) -> i32 {
    %0 = llvm.intr.bswap(%arg0)  : (i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test2_vector_combined := [llvmfunc|
  llvm.func @test2_vector(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.intr.bswap(%arg0)  : (vector<2xi32>) -> vector<2xi32>
    llvm.return %0 : vector<2xi32>
  }]

theorem inst_combine_test2_vector   : test2_vector_before  ⊑  test2_vector_combined := by
  unfold test2_vector_before test2_vector_combined
  simp_alive_peephole
  sorry
def test2_vector_poison_combined := [llvmfunc|
  llvm.func @test2_vector_poison(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(24 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %8 = llvm.mlir.constant(16711680 : i32) : i32
    %9 = llvm.mlir.undef : vector<2xi32>
    %10 = llvm.mlir.constant(0 : i32) : i32
    %11 = llvm.insertelement %8, %9[%10 : i32] : vector<2xi32>
    %12 = llvm.mlir.constant(1 : i32) : i32
    %13 = llvm.insertelement %0, %11[%12 : i32] : vector<2xi32>
    %14 = llvm.mlir.constant(65280 : i32) : i32
    %15 = llvm.mlir.undef : vector<2xi32>
    %16 = llvm.mlir.constant(0 : i32) : i32
    %17 = llvm.insertelement %14, %15[%16 : i32] : vector<2xi32>
    %18 = llvm.mlir.constant(1 : i32) : i32
    %19 = llvm.insertelement %0, %17[%18 : i32] : vector<2xi32>
    %20 = llvm.shl %arg0, %6  : vector<2xi32>
    %21 = llvm.shl %arg0, %7  : vector<2xi32>
    %22 = llvm.and %21, %13  : vector<2xi32>
    %23 = llvm.or %20, %22  : vector<2xi32>
    %24 = llvm.lshr %arg0, %7  : vector<2xi32>
    %25 = llvm.and %24, %19  : vector<2xi32>
    %26 = llvm.or %23, %25  : vector<2xi32>
    %27 = llvm.lshr %arg0, %6  : vector<2xi32>
    %28 = llvm.or %26, %27  : vector<2xi32>
    llvm.return %28 : vector<2xi32>
  }]

theorem inst_combine_test2_vector_poison   : test2_vector_poison_before  ⊑  test2_vector_poison_combined := by
  unfold test2_vector_poison_before test2_vector_poison_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: i16) -> i16 {
    %0 = llvm.intr.bswap(%arg0)  : (i16) -> i16
    llvm.return %0 : i16
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test3_vector_combined := [llvmfunc|
  llvm.func @test3_vector(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.intr.bswap(%arg0)  : (vector<2xi16>) -> vector<2xi16>
    llvm.return %0 : vector<2xi16>
  }]

theorem inst_combine_test3_vector   : test3_vector_before  ⊑  test3_vector_combined := by
  unfold test3_vector_before test3_vector_combined
  simp_alive_peephole
  sorry
def test3_vector_poison_combined := [llvmfunc|
  llvm.func @test3_vector_poison(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.intr.bswap(%arg0)  : (vector<2xi16>) -> vector<2xi16>
    llvm.return %0 : vector<2xi16>
  }]

theorem inst_combine_test3_vector_poison   : test3_vector_poison_before  ⊑  test3_vector_poison_combined := by
  unfold test3_vector_poison_before test3_vector_poison_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4(%arg0: i16) -> i16 {
    %0 = llvm.intr.bswap(%arg0)  : (i16) -> i16
    llvm.return %0 : i16
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def test4_vector_combined := [llvmfunc|
  llvm.func @test4_vector(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.intr.bswap(%arg0)  : (vector<2xi16>) -> vector<2xi16>
    llvm.return %0 : vector<2xi16>
  }]

theorem inst_combine_test4_vector   : test4_vector_before  ⊑  test4_vector_combined := by
  unfold test4_vector_before test4_vector_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5(%arg0: i16) -> i16 {
    %0 = llvm.intr.bswap(%arg0)  : (i16) -> i16
    llvm.return %0 : i16
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
def test5_vector_combined := [llvmfunc|
  llvm.func @test5_vector(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.intr.bswap(%arg0)  : (vector<2xi16>) -> vector<2xi16>
    llvm.return %0 : vector<2xi16>
  }]

theorem inst_combine_test5_vector   : test5_vector_before  ⊑  test5_vector_combined := by
  unfold test5_vector_before test5_vector_combined
  simp_alive_peephole
  sorry
def test6_combined := [llvmfunc|
  llvm.func @test6(%arg0: i32) -> i32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.intr.bswap(%arg0)  : (i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
def test6_vector_combined := [llvmfunc|
  llvm.func @test6_vector(%arg0: vector<2xi32>) -> vector<2xi32> attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.intr.bswap(%arg0)  : (vector<2xi32>) -> vector<2xi32>
    llvm.return %0 : vector<2xi32>
  }]

theorem inst_combine_test6_vector   : test6_vector_before  ⊑  test6_vector_combined := by
  unfold test6_vector_before test6_vector_combined
  simp_alive_peephole
  sorry
def bswap32_and_first_combined := [llvmfunc|
  llvm.func @bswap32_and_first(%arg0: i32) -> i32 {
    %0 = llvm.intr.bswap(%arg0)  : (i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_bswap32_and_first   : bswap32_and_first_before  ⊑  bswap32_and_first_combined := by
  unfold bswap32_and_first_before bswap32_and_first_combined
  simp_alive_peephole
  sorry
def bswap32_and_first_extra_use_combined := [llvmfunc|
  llvm.func @bswap32_and_first_extra_use(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(16711935 : i32) : i32
    %2 = llvm.intr.fshl(%arg0, %arg0, %0)  : (i32, i32, i32) -> i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.intr.bswap(%arg0)  : (i32) -> i32
    llvm.call @extra_use(%3) : (i32) -> ()
    llvm.return %4 : i32
  }]

theorem inst_combine_bswap32_and_first_extra_use   : bswap32_and_first_extra_use_before  ⊑  bswap32_and_first_extra_use_combined := by
  unfold bswap32_and_first_extra_use_before bswap32_and_first_extra_use_combined
  simp_alive_peephole
  sorry
def bswap32_shl_first_combined := [llvmfunc|
  llvm.func @bswap32_shl_first(%arg0: i32) -> i32 {
    %0 = llvm.intr.bswap(%arg0)  : (i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_bswap32_shl_first   : bswap32_shl_first_before  ⊑  bswap32_shl_first_combined := by
  unfold bswap32_shl_first_before bswap32_shl_first_combined
  simp_alive_peephole
  sorry
def bswap32_shl_first_extra_use_combined := [llvmfunc|
  llvm.func @bswap32_shl_first_extra_use(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.intr.fshl(%arg0, %arg0, %0)  : (i32, i32, i32) -> i32
    %3 = llvm.shl %2, %1  : i32
    %4 = llvm.intr.bswap(%arg0)  : (i32) -> i32
    llvm.call @extra_use(%3) : (i32) -> ()
    llvm.return %4 : i32
  }]

theorem inst_combine_bswap32_shl_first_extra_use   : bswap32_shl_first_extra_use_before  ⊑  bswap32_shl_first_extra_use_combined := by
  unfold bswap32_shl_first_extra_use_before bswap32_shl_first_extra_use_combined
  simp_alive_peephole
  sorry
def test8_combined := [llvmfunc|
  llvm.func @test8(%arg0: i16) -> i16 {
    %0 = llvm.intr.bswap(%arg0)  : (i16) -> i16
    llvm.return %0 : i16
  }]

theorem inst_combine_test8   : test8_before  ⊑  test8_combined := by
  unfold test8_before test8_combined
  simp_alive_peephole
  sorry
def test9_combined := [llvmfunc|
  llvm.func @test9(%arg0: i16) -> i16 {
    %0 = llvm.intr.bswap(%arg0)  : (i16) -> i16
    llvm.return %0 : i16
  }]

theorem inst_combine_test9   : test9_before  ⊑  test9_combined := by
  unfold test9_before test9_combined
  simp_alive_peephole
  sorry
def test10_combined := [llvmfunc|
  llvm.func @test10(%arg0: i32) -> i16 {
    %0 = llvm.trunc %arg0 : i32 to i16
    %1 = llvm.intr.bswap(%0)  : (i16) -> i16
    llvm.return %1 : i16
  }]

theorem inst_combine_test10   : test10_before  ⊑  test10_combined := by
  unfold test10_before test10_combined
  simp_alive_peephole
  sorry
def test10_vector_combined := [llvmfunc|
  llvm.func @test10_vector(%arg0: vector<2xi32>) -> vector<2xi16> {
    %0 = llvm.trunc %arg0 : vector<2xi32> to vector<2xi16>
    %1 = llvm.intr.bswap(%0)  : (vector<2xi16>) -> vector<2xi16>
    llvm.return %1 : vector<2xi16>
  }]

theorem inst_combine_test10_vector   : test10_vector_before  ⊑  test10_vector_combined := by
  unfold test10_vector_before test10_vector_combined
  simp_alive_peephole
  sorry
def PR39793_bswap_u64_as_u32_combined := [llvmfunc|
  llvm.func @PR39793_bswap_u64_as_u32(%arg0: i64) -> i64 {
    %0 = llvm.trunc %arg0 : i64 to i32
    %1 = llvm.intr.bswap(%0)  : (i32) -> i32
    %2 = llvm.zext %1 : i32 to i64
    llvm.return %2 : i64
  }]

theorem inst_combine_PR39793_bswap_u64_as_u32   : PR39793_bswap_u64_as_u32_before  ⊑  PR39793_bswap_u64_as_u32_combined := by
  unfold PR39793_bswap_u64_as_u32_before PR39793_bswap_u64_as_u32_combined
  simp_alive_peephole
  sorry
def PR39793_bswap_u64_as_u32_trunc_combined := [llvmfunc|
  llvm.func @PR39793_bswap_u64_as_u32_trunc(%arg0: i64) -> i16 {
    %0 = llvm.trunc %arg0 : i64 to i32
    %1 = llvm.intr.bswap(%0)  : (i32) -> i32
    %2 = llvm.trunc %1 : i32 to i16
    llvm.return %2 : i16
  }]

theorem inst_combine_PR39793_bswap_u64_as_u32_trunc   : PR39793_bswap_u64_as_u32_trunc_before  ⊑  PR39793_bswap_u64_as_u32_trunc_combined := by
  unfold PR39793_bswap_u64_as_u32_trunc_before PR39793_bswap_u64_as_u32_trunc_combined
  simp_alive_peephole
  sorry
def PR39793_bswap_u64_as_u16_combined := [llvmfunc|
  llvm.func @PR39793_bswap_u64_as_u16(%arg0: i64) -> i64 {
    %0 = llvm.trunc %arg0 : i64 to i16
    %1 = llvm.intr.bswap(%0)  : (i16) -> i16
    %2 = llvm.zext %1 : i16 to i64
    llvm.return %2 : i64
  }]

theorem inst_combine_PR39793_bswap_u64_as_u16   : PR39793_bswap_u64_as_u16_before  ⊑  PR39793_bswap_u64_as_u16_combined := by
  unfold PR39793_bswap_u64_as_u16_before PR39793_bswap_u64_as_u16_combined
  simp_alive_peephole
  sorry
def PR39793_bswap_u64_as_u16_vector_combined := [llvmfunc|
  llvm.func @PR39793_bswap_u64_as_u16_vector(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi16>
    %1 = llvm.intr.bswap(%0)  : (vector<2xi16>) -> vector<2xi16>
    %2 = llvm.zext %1 : vector<2xi16> to vector<2xi64>
    llvm.return %2 : vector<2xi64>
  }]

theorem inst_combine_PR39793_bswap_u64_as_u16_vector   : PR39793_bswap_u64_as_u16_vector_before  ⊑  PR39793_bswap_u64_as_u16_vector_combined := by
  unfold PR39793_bswap_u64_as_u16_vector_before PR39793_bswap_u64_as_u16_vector_combined
  simp_alive_peephole
  sorry
def PR39793_bswap_u64_as_u16_trunc_combined := [llvmfunc|
  llvm.func @PR39793_bswap_u64_as_u16_trunc(%arg0: i64) -> i8 {
    %0 = llvm.mlir.constant(8 : i64) : i64
    %1 = llvm.lshr %arg0, %0  : i64
    %2 = llvm.trunc %1 : i64 to i8
    llvm.return %2 : i8
  }]

theorem inst_combine_PR39793_bswap_u64_as_u16_trunc   : PR39793_bswap_u64_as_u16_trunc_before  ⊑  PR39793_bswap_u64_as_u16_trunc_combined := by
  unfold PR39793_bswap_u64_as_u16_trunc_before PR39793_bswap_u64_as_u16_trunc_combined
  simp_alive_peephole
  sorry
def PR39793_bswap_u50_as_u16_combined := [llvmfunc|
  llvm.func @PR39793_bswap_u50_as_u16(%arg0: i50) -> i50 {
    %0 = llvm.trunc %arg0 : i50 to i16
    %1 = llvm.intr.bswap(%0)  : (i16) -> i16
    %2 = llvm.zext %1 : i16 to i50
    llvm.return %2 : i50
  }]

theorem inst_combine_PR39793_bswap_u50_as_u16   : PR39793_bswap_u50_as_u16_before  ⊑  PR39793_bswap_u50_as_u16_combined := by
  unfold PR39793_bswap_u50_as_u16_before PR39793_bswap_u50_as_u16_combined
  simp_alive_peephole
  sorry
def PR39793_bswap_u32_as_u16_combined := [llvmfunc|
  llvm.func @PR39793_bswap_u32_as_u16(%arg0: i32) -> i32 {
    %0 = llvm.trunc %arg0 : i32 to i16
    %1 = llvm.intr.bswap(%0)  : (i16) -> i16
    %2 = llvm.zext %1 : i16 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_PR39793_bswap_u32_as_u16   : PR39793_bswap_u32_as_u16_before  ⊑  PR39793_bswap_u32_as_u16_combined := by
  unfold PR39793_bswap_u32_as_u16_before PR39793_bswap_u32_as_u16_combined
  simp_alive_peephole
  sorry
def PR39793_bswap_u32_as_u16_trunc_combined := [llvmfunc|
  llvm.func @PR39793_bswap_u32_as_u16_trunc(%arg0: i32) -> i8 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.trunc %1 : i32 to i8
    llvm.return %2 : i8
  }]

theorem inst_combine_PR39793_bswap_u32_as_u16_trunc   : PR39793_bswap_u32_as_u16_trunc_before  ⊑  PR39793_bswap_u32_as_u16_trunc_combined := by
  unfold PR39793_bswap_u32_as_u16_trunc_before PR39793_bswap_u32_as_u16_trunc_combined
  simp_alive_peephole
  sorry
def partial_bswap_combined := [llvmfunc|
  llvm.func @partial_bswap(%arg0: i32) -> i32 {
    %0 = llvm.intr.bswap(%arg0)  : (i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_partial_bswap   : partial_bswap_before  ⊑  partial_bswap_combined := by
  unfold partial_bswap_before partial_bswap_combined
  simp_alive_peephole
  sorry
def partial_bswap_vector_combined := [llvmfunc|
  llvm.func @partial_bswap_vector(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.intr.bswap(%arg0)  : (vector<2xi32>) -> vector<2xi32>
    llvm.return %0 : vector<2xi32>
  }]

theorem inst_combine_partial_bswap_vector   : partial_bswap_vector_before  ⊑  partial_bswap_vector_combined := by
  unfold partial_bswap_vector_before partial_bswap_vector_combined
  simp_alive_peephole
  sorry
def partial_bitreverse_combined := [llvmfunc|
  llvm.func @partial_bitreverse(%arg0: i16) -> i16 {
    %0 = llvm.intr.bswap(%arg0)  : (i16) -> i16
    llvm.return %0 : i16
  }]

theorem inst_combine_partial_bitreverse   : partial_bitreverse_before  ⊑  partial_bitreverse_combined := by
  unfold partial_bitreverse_before partial_bitreverse_combined
  simp_alive_peephole
  sorry
def bswap_and_mask_0_combined := [llvmfunc|
  llvm.func @bswap_and_mask_0(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(-72057594037927681 : i64) : i64
    %1 = llvm.and %arg0, %0  : i64
    %2 = llvm.intr.bswap(%1)  : (i64) -> i64
    llvm.return %2 : i64
  }]

theorem inst_combine_bswap_and_mask_0   : bswap_and_mask_0_before  ⊑  bswap_and_mask_0_combined := by
  unfold bswap_and_mask_0_before bswap_and_mask_0_combined
  simp_alive_peephole
  sorry
def bswap_and_mask_1_combined := [llvmfunc|
  llvm.func @bswap_and_mask_1(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(56 : i64) : i64
    %1 = llvm.mlir.constant(40 : i64) : i64
    %2 = llvm.mlir.constant(65280 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i64
    %4 = llvm.lshr %arg0, %1  : i64
    %5 = llvm.and %4, %2  : i64
    %6 = llvm.or %5, %3  : i64
    llvm.return %6 : i64
  }]

theorem inst_combine_bswap_and_mask_1   : bswap_and_mask_1_before  ⊑  bswap_and_mask_1_combined := by
  unfold bswap_and_mask_1_before bswap_and_mask_1_combined
  simp_alive_peephole
  sorry
def bswap_and_mask_2_combined := [llvmfunc|
  llvm.func @bswap_and_mask_2(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(-72057594037862401 : i64) : i64
    %1 = llvm.and %arg0, %0  : i64
    %2 = llvm.intr.bswap(%1)  : (i64) -> i64
    llvm.return %2 : i64
  }]

theorem inst_combine_bswap_and_mask_2   : bswap_and_mask_2_before  ⊑  bswap_and_mask_2_combined := by
  unfold bswap_and_mask_2_before bswap_and_mask_2_combined
  simp_alive_peephole
  sorry
def bswap_trunc_combined := [llvmfunc|
  llvm.func @bswap_trunc(%arg0: i64) -> i64 {
    %0 = llvm.intr.bswap(%arg0)  : (i64) -> i64
    llvm.return %0 : i64
  }]

theorem inst_combine_bswap_trunc   : bswap_trunc_before  ⊑  bswap_trunc_combined := by
  unfold bswap_trunc_before bswap_trunc_combined
  simp_alive_peephole
  sorry
def shuf_4bytes_combined := [llvmfunc|
  llvm.func @shuf_4bytes(%arg0: vector<4xi8>) -> i32 {
    %0 = llvm.bitcast %arg0 : vector<4xi8> to i32
    %1 = llvm.intr.bswap(%0)  : (i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_shuf_4bytes   : shuf_4bytes_before  ⊑  shuf_4bytes_combined := by
  unfold shuf_4bytes_before shuf_4bytes_combined
  simp_alive_peephole
  sorry
def shuf_load_4bytes_combined := [llvmfunc|
  llvm.func @shuf_load_4bytes(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32
    %1 = llvm.intr.bswap(%0)  : (i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_shuf_load_4bytes   : shuf_load_4bytes_before  ⊑  shuf_load_4bytes_combined := by
  unfold shuf_load_4bytes_before shuf_load_4bytes_combined
  simp_alive_peephole
  sorry
def shuf_bitcast_twice_4bytes_combined := [llvmfunc|
  llvm.func @shuf_bitcast_twice_4bytes(%arg0: i32) -> i32 {
    %0 = llvm.intr.bswap(%arg0)  : (i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_shuf_bitcast_twice_4bytes   : shuf_bitcast_twice_4bytes_before  ⊑  shuf_bitcast_twice_4bytes_combined := by
  unfold shuf_bitcast_twice_4bytes_before shuf_bitcast_twice_4bytes_combined
  simp_alive_peephole
  sorry
def shuf_4bytes_extra_use_combined := [llvmfunc|
  llvm.func @shuf_4bytes_extra_use(%arg0: vector<4xi8>) -> i32 {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.shufflevector %arg0, %0 [3, 2, 1, 0] : vector<4xi8> 
    llvm.call @use(%1) : (vector<4xi8>) -> ()
    %2 = llvm.bitcast %1 : vector<4xi8> to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_shuf_4bytes_extra_use   : shuf_4bytes_extra_use_before  ⊑  shuf_4bytes_extra_use_combined := by
  unfold shuf_4bytes_extra_use_before shuf_4bytes_extra_use_combined
  simp_alive_peephole
  sorry
def shuf_16bytes_combined := [llvmfunc|
  llvm.func @shuf_16bytes(%arg0: vector<16xi8>) -> i128 {
    %0 = llvm.mlir.poison : vector<16xi8>
    %1 = llvm.shufflevector %arg0, %0 [15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0] : vector<16xi8> 
    %2 = llvm.bitcast %1 : vector<16xi8> to i128
    llvm.return %2 : i128
  }]

theorem inst_combine_shuf_16bytes   : shuf_16bytes_before  ⊑  shuf_16bytes_combined := by
  unfold shuf_16bytes_before shuf_16bytes_combined
  simp_alive_peephole
  sorry
def shuf_2bytes_widening_combined := [llvmfunc|
  llvm.func @shuf_2bytes_widening(%arg0: vector<2xi8>) -> i32 {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.shufflevector %arg0, %0 [1, 0, -1, -1] : vector<2xi8> 
    %2 = llvm.bitcast %1 : vector<4xi8> to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_shuf_2bytes_widening   : shuf_2bytes_widening_before  ⊑  shuf_2bytes_widening_combined := by
  unfold shuf_2bytes_widening_before shuf_2bytes_widening_combined
  simp_alive_peephole
  sorry
def funnel_unary_combined := [llvmfunc|
  llvm.func @funnel_unary(%arg0: i32) -> i32 {
    %0 = llvm.intr.bswap(%arg0)  : (i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_funnel_unary   : funnel_unary_before  ⊑  funnel_unary_combined := by
  unfold funnel_unary_before funnel_unary_combined
  simp_alive_peephole
  sorry
def funnel_binary_combined := [llvmfunc|
  llvm.func @funnel_binary(%arg0: i32) -> i32 {
    %0 = llvm.intr.bswap(%arg0)  : (i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_funnel_binary   : funnel_binary_before  ⊑  funnel_binary_combined := by
  unfold funnel_binary_before funnel_binary_combined
  simp_alive_peephole
  sorry
def funnel_and_combined := [llvmfunc|
  llvm.func @funnel_and(%arg0: i32) -> i32 {
    %0 = llvm.intr.bswap(%arg0)  : (i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_funnel_and   : funnel_and_before  ⊑  funnel_and_combined := by
  unfold funnel_and_before funnel_and_combined
  simp_alive_peephole
  sorry
def trunc_bswap_i160_combined := [llvmfunc|
  llvm.func @trunc_bswap_i160(%arg0: !llvm.ptr) -> i16 {
    %0 = llvm.mlir.constant(136 : i160) : i160
    %1 = llvm.mlir.constant(255 : i16) : i16
    %2 = llvm.mlir.constant(120 : i160) : i160
    %3 = llvm.mlir.constant(-256 : i16) : i16
    %4 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i160
    %5 = llvm.lshr %4, %0  : i160
    %6 = llvm.trunc %5 : i160 to i16
    %7 = llvm.and %6, %1  : i16
    %8 = llvm.lshr %4, %2  : i160
    %9 = llvm.trunc %8 : i160 to i16
    %10 = llvm.and %9, %3  : i16
    %11 = llvm.or %7, %10  : i16
    llvm.return %11 : i16
  }]

theorem inst_combine_trunc_bswap_i160   : trunc_bswap_i160_before  ⊑  trunc_bswap_i160_combined := by
  unfold trunc_bswap_i160_before trunc_bswap_i160_combined
  simp_alive_peephole
  sorry
def PR47191_problem1_combined := [llvmfunc|
  llvm.func @PR47191_problem1(%arg0: i64) -> i64 {
    %0 = llvm.intr.bswap(%arg0)  : (i64) -> i64
    llvm.return %0 : i64
  }]

theorem inst_combine_PR47191_problem1   : PR47191_problem1_before  ⊑  PR47191_problem1_combined := by
  unfold PR47191_problem1_before PR47191_problem1_combined
  simp_alive_peephole
  sorry
def PR47191_problem2_combined := [llvmfunc|
  llvm.func @PR47191_problem2(%arg0: i64) -> i64 {
    %0 = llvm.intr.bswap(%arg0)  : (i64) -> i64
    llvm.return %0 : i64
  }]

theorem inst_combine_PR47191_problem2   : PR47191_problem2_before  ⊑  PR47191_problem2_combined := by
  unfold PR47191_problem2_before PR47191_problem2_combined
  simp_alive_peephole
  sorry
def PR47191_problem3_combined := [llvmfunc|
  llvm.func @PR47191_problem3(%arg0: i64) -> i64 {
    %0 = llvm.intr.bswap(%arg0)  : (i64) -> i64
    llvm.return %0 : i64
  }]

theorem inst_combine_PR47191_problem3   : PR47191_problem3_before  ⊑  PR47191_problem3_combined := by
  unfold PR47191_problem3_before PR47191_problem3_combined
  simp_alive_peephole
  sorry
def PR47191_problem4_combined := [llvmfunc|
  llvm.func @PR47191_problem4(%arg0: i64) -> i64 {
    %0 = llvm.intr.bswap(%arg0)  : (i64) -> i64
    llvm.return %0 : i64
  }]

theorem inst_combine_PR47191_problem4   : PR47191_problem4_before  ⊑  PR47191_problem4_combined := by
  unfold PR47191_problem4_before PR47191_problem4_combined
  simp_alive_peephole
  sorry
def PR50910_combined := [llvmfunc|
  llvm.func @PR50910(%arg0: i64) -> i32 {
    %0 = llvm.intr.bswap(%arg0)  : (i64) -> i64
    %1 = llvm.trunc %0 : i64 to i32
    llvm.return %1 : i32
  }]

theorem inst_combine_PR50910   : PR50910_before  ⊑  PR50910_combined := by
  unfold PR50910_before PR50910_combined
  simp_alive_peephole
  sorry
def PR60690_call_fshl_combined := [llvmfunc|
  llvm.func @PR60690_call_fshl(%arg0: i64) -> i64 {
    %0 = llvm.intr.bswap(%arg0)  : (i64) -> i64
    llvm.return %0 : i64
  }]

theorem inst_combine_PR60690_call_fshl   : PR60690_call_fshl_before  ⊑  PR60690_call_fshl_combined := by
  unfold PR60690_call_fshl_before PR60690_call_fshl_combined
  simp_alive_peephole
  sorry
def PR60690_call_fshr_combined := [llvmfunc|
  llvm.func @PR60690_call_fshr(%arg0: i64) -> i64 {
    %0 = llvm.intr.bswap(%arg0)  : (i64) -> i64
    llvm.return %0 : i64
  }]

theorem inst_combine_PR60690_call_fshr   : PR60690_call_fshr_before  ⊑  PR60690_call_fshr_combined := by
  unfold PR60690_call_fshr_before PR60690_call_fshr_combined
  simp_alive_peephole
  sorry
