import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  xor-ashr
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def testi8i8_before := [llvmfunc|
  llvm.func @testi8i8(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }]

def testi16i8_before := [llvmfunc|
  llvm.func @testi16i8(%arg0: i16) -> i8 {
    %0 = llvm.mlir.constant(15 : i16) : i16
    %1 = llvm.mlir.constant(27 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i16
    %3 = llvm.trunc %2 : i16 to i8
    %4 = llvm.xor %3, %1  : i8
    llvm.return %4 : i8
  }]

def testi64i32_before := [llvmfunc|
  llvm.func @testi64i32(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.mlir.constant(127 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.xor %3, %1  : i32
    llvm.return %4 : i32
  }]

def testi128i128_before := [llvmfunc|
  llvm.func @testi128i128(%arg0: i128) -> i128 {
    %0 = llvm.mlir.constant(127 : i128) : i128
    %1 = llvm.mlir.constant(27 : i128) : i128
    %2 = llvm.ashr %arg0, %0  : i128
    %3 = llvm.xor %2, %1  : i128
    llvm.return %3 : i128
  }]

def testv4i16i8_before := [llvmfunc|
  llvm.func @testv4i16i8(%arg0: vector<4xi16>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<15> : vector<4xi16>) : vector<4xi16>
    %1 = llvm.mlir.constant(dense<27> : vector<4xi8>) : vector<4xi8>
    %2 = llvm.ashr %arg0, %0  : vector<4xi16>
    %3 = llvm.trunc %2 : vector<4xi16> to vector<4xi8>
    %4 = llvm.xor %3, %1  : vector<4xi8>
    llvm.return %4 : vector<4xi8>
  }]

def testv4i16i8_poison_before := [llvmfunc|
  llvm.func @testv4i16i8_poison(%arg0: vector<4xi16>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(15 : i16) : i16
    %1 = llvm.mlir.poison : i16
    %2 = llvm.mlir.undef : vector<4xi16>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<4xi16>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<4xi16>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<4xi16>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi16>
    %11 = llvm.mlir.constant(27 : i8) : i8
    %12 = llvm.mlir.poison : i8
    %13 = llvm.mlir.undef : vector<4xi8>
    %14 = llvm.mlir.constant(0 : i32) : i32
    %15 = llvm.insertelement %11, %13[%14 : i32] : vector<4xi8>
    %16 = llvm.mlir.constant(1 : i32) : i32
    %17 = llvm.insertelement %11, %15[%16 : i32] : vector<4xi8>
    %18 = llvm.mlir.constant(2 : i32) : i32
    %19 = llvm.insertelement %12, %17[%18 : i32] : vector<4xi8>
    %20 = llvm.mlir.constant(3 : i32) : i32
    %21 = llvm.insertelement %11, %19[%20 : i32] : vector<4xi8>
    %22 = llvm.ashr %arg0, %10  : vector<4xi16>
    %23 = llvm.trunc %22 : vector<4xi16> to vector<4xi8>
    %24 = llvm.xor %23, %21  : vector<4xi8>
    llvm.return %24 : vector<4xi8>
  }]

def wrongimm_before := [llvmfunc|
  llvm.func @wrongimm(%arg0: i16) -> i8 {
    %0 = llvm.mlir.constant(14 : i16) : i16
    %1 = llvm.mlir.constant(27 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i16
    %3 = llvm.trunc %2 : i16 to i8
    %4 = llvm.xor %3, %1  : i8
    llvm.return %4 : i8
  }]

def vectorpoison_before := [llvmfunc|
  llvm.func @vectorpoison(%arg0: vector<6xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<6xi32>) : vector<6xi32>
    %1 = llvm.mlir.constant(dense<31> : vector<6xi32>) : vector<6xi32>
    %2 = llvm.mlir.poison : vector<6xi32>
    %3 = llvm.xor %arg0, %0  : vector<6xi32>
    %4 = llvm.ashr %3, %1  : vector<6xi32>
    %5 = llvm.shufflevector %4, %2 [0, 1, 0, 2] : vector<6xi32> 
    llvm.return %5 : vector<4xi32>
  }]

def extrause_before := [llvmfunc|
  llvm.func @extrause(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(15 : i16) : i16
    %1 = llvm.mlir.constant(27 : i16) : i16
    %2 = llvm.ashr %arg0, %0  : i16
    %3 = llvm.xor %2, %1  : i16
    llvm.call @use16(%2) : (i16) -> ()
    llvm.return %3 : i16
  }]

def extrause_trunc1_before := [llvmfunc|
  llvm.func @extrause_trunc1(%arg0: i32) -> i16 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(127 : i16) : i16
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i16
    llvm.call @use32(%2) : (i32) -> ()
    %4 = llvm.xor %3, %1  : i16
    llvm.return %4 : i16
  }]

def extrause_trunc2_before := [llvmfunc|
  llvm.func @extrause_trunc2(%arg0: i32) -> i16 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(127 : i16) : i16
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i16
    llvm.call @use16(%3) : (i16) -> ()
    %4 = llvm.xor %3, %1  : i16
    llvm.return %4 : i16
  }]

def testi8i8_combined := [llvmfunc|
  llvm.func @testi8i8(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.mlir.constant(-128 : i8) : i8
    %3 = llvm.icmp "sgt" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i8
    llvm.return %4 : i8
  }]

theorem inst_combine_testi8i8   : testi8i8_before  ⊑  testi8i8_combined := by
  unfold testi8i8_before testi8i8_combined
  simp_alive_peephole
  sorry
def testi16i8_combined := [llvmfunc|
  llvm.func @testi16i8(%arg0: i16) -> i8 {
    %0 = llvm.mlir.constant(-1 : i16) : i16
    %1 = llvm.mlir.constant(27 : i8) : i8
    %2 = llvm.mlir.constant(-28 : i8) : i8
    %3 = llvm.icmp "sgt" %arg0, %0 : i16
    %4 = llvm.select %3, %1, %2 : i1, i8
    llvm.return %4 : i8
  }]

theorem inst_combine_testi16i8   : testi16i8_before  ⊑  testi16i8_combined := by
  unfold testi16i8_before testi16i8_combined
  simp_alive_peephole
  sorry
def testi64i32_combined := [llvmfunc|
  llvm.func @testi64i32(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.mlir.constant(127 : i32) : i32
    %2 = llvm.mlir.constant(-128 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i64
    %4 = llvm.select %3, %1, %2 : i1, i32
    llvm.return %4 : i32
  }]

theorem inst_combine_testi64i32   : testi64i32_before  ⊑  testi64i32_combined := by
  unfold testi64i32_before testi64i32_combined
  simp_alive_peephole
  sorry
def testi128i128_combined := [llvmfunc|
  llvm.func @testi128i128(%arg0: i128) -> i128 {
    %0 = llvm.mlir.constant(-1 : i128) : i128
    %1 = llvm.mlir.constant(27 : i128) : i128
    %2 = llvm.mlir.constant(-28 : i128) : i128
    %3 = llvm.icmp "sgt" %arg0, %0 : i128
    %4 = llvm.select %3, %1, %2 : i1, i128
    llvm.return %4 : i128
  }]

theorem inst_combine_testi128i128   : testi128i128_before  ⊑  testi128i128_combined := by
  unfold testi128i128_before testi128i128_combined
  simp_alive_peephole
  sorry
def testv4i16i8_combined := [llvmfunc|
  llvm.func @testv4i16i8(%arg0: vector<4xi16>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi16>) : vector<4xi16>
    %1 = llvm.mlir.constant(dense<27> : vector<4xi8>) : vector<4xi8>
    %2 = llvm.mlir.constant(dense<-28> : vector<4xi8>) : vector<4xi8>
    %3 = llvm.icmp "sgt" %arg0, %0 : vector<4xi16>
    %4 = llvm.select %3, %1, %2 : vector<4xi1>, vector<4xi8>
    llvm.return %4 : vector<4xi8>
  }]

theorem inst_combine_testv4i16i8   : testv4i16i8_before  ⊑  testv4i16i8_combined := by
  unfold testv4i16i8_before testv4i16i8_combined
  simp_alive_peephole
  sorry
def testv4i16i8_poison_combined := [llvmfunc|
  llvm.func @testv4i16i8_poison(%arg0: vector<4xi16>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi16>) : vector<4xi16>
    %1 = llvm.mlir.constant(27 : i8) : i8
    %2 = llvm.mlir.poison : i8
    %3 = llvm.mlir.undef : vector<4xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<4xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<4xi8>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %2, %7[%8 : i32] : vector<4xi8>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %1, %9[%10 : i32] : vector<4xi8>
    %12 = llvm.mlir.constant(-28 : i8) : i8
    %13 = llvm.mlir.undef : vector<4xi8>
    %14 = llvm.mlir.constant(0 : i32) : i32
    %15 = llvm.insertelement %12, %13[%14 : i32] : vector<4xi8>
    %16 = llvm.mlir.constant(1 : i32) : i32
    %17 = llvm.insertelement %12, %15[%16 : i32] : vector<4xi8>
    %18 = llvm.mlir.constant(2 : i32) : i32
    %19 = llvm.insertelement %2, %17[%18 : i32] : vector<4xi8>
    %20 = llvm.mlir.constant(3 : i32) : i32
    %21 = llvm.insertelement %12, %19[%20 : i32] : vector<4xi8>
    %22 = llvm.icmp "sgt" %arg0, %0 : vector<4xi16>
    %23 = llvm.select %22, %11, %21 : vector<4xi1>, vector<4xi8>
    llvm.return %23 : vector<4xi8>
  }]

theorem inst_combine_testv4i16i8_poison   : testv4i16i8_poison_before  ⊑  testv4i16i8_poison_combined := by
  unfold testv4i16i8_poison_before testv4i16i8_poison_combined
  simp_alive_peephole
  sorry
def wrongimm_combined := [llvmfunc|
  llvm.func @wrongimm(%arg0: i16) -> i8 {
    %0 = llvm.mlir.constant(14 : i16) : i16
    %1 = llvm.mlir.constant(27 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i16
    %3 = llvm.trunc %2 : i16 to i8
    %4 = llvm.xor %3, %1  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_wrongimm   : wrongimm_before  ⊑  wrongimm_combined := by
  unfold wrongimm_before wrongimm_combined
  simp_alive_peephole
  sorry
def vectorpoison_combined := [llvmfunc|
  llvm.func @vectorpoison(%arg0: vector<6xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<6xi32>) : vector<6xi32>
    %1 = llvm.mlir.poison : vector<6xi32>
    %2 = llvm.icmp "sgt" %arg0, %0 : vector<6xi32>
    %3 = llvm.sext %2 : vector<6xi1> to vector<6xi32>
    %4 = llvm.shufflevector %3, %1 [0, 1, 0, 2] : vector<6xi32> 
    llvm.return %4 : vector<4xi32>
  }]

theorem inst_combine_vectorpoison   : vectorpoison_before  ⊑  vectorpoison_combined := by
  unfold vectorpoison_before vectorpoison_combined
  simp_alive_peephole
  sorry
def extrause_combined := [llvmfunc|
  llvm.func @extrause(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(15 : i16) : i16
    %1 = llvm.mlir.constant(27 : i16) : i16
    %2 = llvm.ashr %arg0, %0  : i16
    %3 = llvm.xor %2, %1  : i16
    llvm.call @use16(%2) : (i16) -> ()
    llvm.return %3 : i16
  }]

theorem inst_combine_extrause   : extrause_before  ⊑  extrause_combined := by
  unfold extrause_before extrause_combined
  simp_alive_peephole
  sorry
def extrause_trunc1_combined := [llvmfunc|
  llvm.func @extrause_trunc1(%arg0: i32) -> i16 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(127 : i16) : i16
    %3 = llvm.mlir.constant(-128 : i16) : i16
    %4 = llvm.ashr %arg0, %0  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.icmp "sgt" %arg0, %1 : i32
    %6 = llvm.select %5, %2, %3 : i1, i16
    llvm.return %6 : i16
  }]

theorem inst_combine_extrause_trunc1   : extrause_trunc1_before  ⊑  extrause_trunc1_combined := by
  unfold extrause_trunc1_before extrause_trunc1_combined
  simp_alive_peephole
  sorry
def extrause_trunc2_combined := [llvmfunc|
  llvm.func @extrause_trunc2(%arg0: i32) -> i16 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(127 : i16) : i16
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i16
    llvm.call @use16(%3) : (i16) -> ()
    %4 = llvm.xor %3, %1  : i16
    llvm.return %4 : i16
  }]

theorem inst_combine_extrause_trunc2   : extrause_trunc2_before  ⊑  extrause_trunc2_combined := by
  unfold extrause_trunc2_before extrause_trunc2_combined
  simp_alive_peephole
  sorry
