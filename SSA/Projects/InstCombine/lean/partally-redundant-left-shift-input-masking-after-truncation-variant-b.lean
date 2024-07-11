import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  partally-redundant-left-shift-input-masking-after-truncation-variant-b
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t0_basic_before := [llvmfunc|
  llvm.func @t0_basic(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i64) : i64
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.add %arg1, %0  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.shl %1, %4  : i64
    %6 = llvm.xor %5, %1  : i64
    %7 = llvm.sub %2, %arg1  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use64(%4) : (i64) -> ()
    llvm.call @use64(%5) : (i64) -> ()
    llvm.call @use64(%6) : (i64) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.and %6, %arg0  : i64
    %9 = llvm.trunc %8 : i64 to i32
    %10 = llvm.shl %9, %7  : i32
    llvm.return %10 : i32
  }]

def t1_vec_splat_before := [llvmfunc|
  llvm.func @t1_vec_splat(%arg0: vector<8xi64>, %arg1: vector<8xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<8xi32>) : vector<8xi32>
    %1 = llvm.mlir.constant(dense<-1> : vector<8xi64>) : vector<8xi64>
    %2 = llvm.mlir.constant(dense<32> : vector<8xi32>) : vector<8xi32>
    %3 = llvm.add %arg1, %0  : vector<8xi32>
    %4 = llvm.zext %3 : vector<8xi32> to vector<8xi64>
    %5 = llvm.shl %1, %4  : vector<8xi64>
    %6 = llvm.xor %5, %1  : vector<8xi64>
    %7 = llvm.sub %2, %arg1  : vector<8xi32>
    llvm.call @use8xi32(%3) : (vector<8xi32>) -> ()
    llvm.call @use8xi64(%4) : (vector<8xi64>) -> ()
    llvm.call @use8xi64(%5) : (vector<8xi64>) -> ()
    llvm.call @use8xi64(%6) : (vector<8xi64>) -> ()
    llvm.call @use8xi32(%7) : (vector<8xi32>) -> ()
    %8 = llvm.and %6, %arg0  : vector<8xi64>
    %9 = llvm.trunc %8 : vector<8xi64> to vector<8xi32>
    %10 = llvm.shl %9, %7  : vector<8xi32>
    llvm.return %10 : vector<8xi32>
  }]

def t2_vec_splat_poison_before := [llvmfunc|
  llvm.func @t2_vec_splat_poison(%arg0: vector<8xi64>, %arg1: vector<8xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<8xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<8xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<8xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<8xi32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<8xi32>
    %11 = llvm.mlir.constant(4 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<8xi32>
    %13 = llvm.mlir.constant(5 : i32) : i32
    %14 = llvm.insertelement %0, %12[%13 : i32] : vector<8xi32>
    %15 = llvm.mlir.constant(6 : i32) : i32
    %16 = llvm.insertelement %1, %14[%15 : i32] : vector<8xi32>
    %17 = llvm.mlir.constant(7 : i32) : i32
    %18 = llvm.insertelement %0, %16[%17 : i32] : vector<8xi32>
    %19 = llvm.mlir.constant(-1 : i64) : i64
    %20 = llvm.mlir.poison : i64
    %21 = llvm.mlir.undef : vector<8xi64>
    %22 = llvm.mlir.constant(0 : i32) : i32
    %23 = llvm.insertelement %19, %21[%22 : i32] : vector<8xi64>
    %24 = llvm.mlir.constant(1 : i32) : i32
    %25 = llvm.insertelement %19, %23[%24 : i32] : vector<8xi64>
    %26 = llvm.mlir.constant(2 : i32) : i32
    %27 = llvm.insertelement %19, %25[%26 : i32] : vector<8xi64>
    %28 = llvm.mlir.constant(3 : i32) : i32
    %29 = llvm.insertelement %19, %27[%28 : i32] : vector<8xi64>
    %30 = llvm.mlir.constant(4 : i32) : i32
    %31 = llvm.insertelement %19, %29[%30 : i32] : vector<8xi64>
    %32 = llvm.mlir.constant(5 : i32) : i32
    %33 = llvm.insertelement %19, %31[%32 : i32] : vector<8xi64>
    %34 = llvm.mlir.constant(6 : i32) : i32
    %35 = llvm.insertelement %20, %33[%34 : i32] : vector<8xi64>
    %36 = llvm.mlir.constant(7 : i32) : i32
    %37 = llvm.insertelement %19, %35[%36 : i32] : vector<8xi64>
    %38 = llvm.mlir.constant(32 : i32) : i32
    %39 = llvm.mlir.undef : vector<8xi32>
    %40 = llvm.mlir.constant(0 : i32) : i32
    %41 = llvm.insertelement %38, %39[%40 : i32] : vector<8xi32>
    %42 = llvm.mlir.constant(1 : i32) : i32
    %43 = llvm.insertelement %38, %41[%42 : i32] : vector<8xi32>
    %44 = llvm.mlir.constant(2 : i32) : i32
    %45 = llvm.insertelement %38, %43[%44 : i32] : vector<8xi32>
    %46 = llvm.mlir.constant(3 : i32) : i32
    %47 = llvm.insertelement %38, %45[%46 : i32] : vector<8xi32>
    %48 = llvm.mlir.constant(4 : i32) : i32
    %49 = llvm.insertelement %38, %47[%48 : i32] : vector<8xi32>
    %50 = llvm.mlir.constant(5 : i32) : i32
    %51 = llvm.insertelement %38, %49[%50 : i32] : vector<8xi32>
    %52 = llvm.mlir.constant(6 : i32) : i32
    %53 = llvm.insertelement %1, %51[%52 : i32] : vector<8xi32>
    %54 = llvm.mlir.constant(7 : i32) : i32
    %55 = llvm.insertelement %38, %53[%54 : i32] : vector<8xi32>
    %56 = llvm.add %arg1, %18  : vector<8xi32>
    %57 = llvm.zext %56 : vector<8xi32> to vector<8xi64>
    %58 = llvm.shl %37, %57  : vector<8xi64>
    %59 = llvm.xor %58, %37  : vector<8xi64>
    %60 = llvm.sub %55, %arg1  : vector<8xi32>
    llvm.call @use8xi32(%56) : (vector<8xi32>) -> ()
    llvm.call @use8xi64(%57) : (vector<8xi64>) -> ()
    llvm.call @use8xi64(%58) : (vector<8xi64>) -> ()
    llvm.call @use8xi64(%59) : (vector<8xi64>) -> ()
    llvm.call @use8xi32(%60) : (vector<8xi32>) -> ()
    %61 = llvm.and %59, %arg0  : vector<8xi64>
    %62 = llvm.trunc %61 : vector<8xi64> to vector<8xi32>
    %63 = llvm.shl %62, %60  : vector<8xi32>
    llvm.return %63 : vector<8xi32>
  }]

def t3_vec_nonsplat_before := [llvmfunc|
  llvm.func @t3_vec_nonsplat(%arg0: vector<8xi64>, %arg1: vector<8xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(dense<[-33, -32, -31, -1, 0, 1, 31, 32]> : vector<8xi32>) : vector<8xi32>
    %1 = llvm.mlir.constant(dense<-1> : vector<8xi64>) : vector<8xi64>
    %2 = llvm.mlir.constant(dense<32> : vector<8xi32>) : vector<8xi32>
    %3 = llvm.add %arg1, %0  : vector<8xi32>
    %4 = llvm.zext %3 : vector<8xi32> to vector<8xi64>
    %5 = llvm.shl %1, %4  : vector<8xi64>
    %6 = llvm.xor %5, %1  : vector<8xi64>
    %7 = llvm.sub %2, %arg1  : vector<8xi32>
    llvm.call @use8xi32(%3) : (vector<8xi32>) -> ()
    llvm.call @use8xi64(%4) : (vector<8xi64>) -> ()
    llvm.call @use8xi64(%5) : (vector<8xi64>) -> ()
    llvm.call @use8xi64(%6) : (vector<8xi64>) -> ()
    llvm.call @use8xi32(%7) : (vector<8xi32>) -> ()
    %8 = llvm.and %6, %arg0  : vector<8xi64>
    %9 = llvm.trunc %8 : vector<8xi64> to vector<8xi32>
    %10 = llvm.shl %9, %7  : vector<8xi32>
    llvm.return %10 : vector<8xi32>
  }]

def t4_allones_trunc_before := [llvmfunc|
  llvm.func @t4_allones_trunc(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i64) : i64
    %2 = llvm.mlir.constant(4294967295 : i64) : i64
    %3 = llvm.mlir.constant(32 : i32) : i32
    %4 = llvm.add %arg1, %0  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.shl %1, %5  : i64
    %7 = llvm.xor %6, %2  : i64
    %8 = llvm.sub %3, %arg1  : i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use64(%5) : (i64) -> ()
    llvm.call @use64(%6) : (i64) -> ()
    llvm.call @use64(%7) : (i64) -> ()
    llvm.call @use32(%8) : (i32) -> ()
    %9 = llvm.and %7, %arg0  : i64
    %10 = llvm.trunc %9 : i64 to i32
    %11 = llvm.shl %10, %8  : i32
    llvm.return %11 : i32
  }]

def n5_extrause0_before := [llvmfunc|
  llvm.func @n5_extrause0(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i64) : i64
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.add %arg1, %0  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.shl %1, %4  : i64
    %6 = llvm.xor %5, %1  : i64
    %7 = llvm.sub %2, %arg1  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use64(%4) : (i64) -> ()
    llvm.call @use64(%5) : (i64) -> ()
    llvm.call @use64(%6) : (i64) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.and %6, %arg0  : i64
    llvm.call @use64(%8) : (i64) -> ()
    %9 = llvm.trunc %8 : i64 to i32
    %10 = llvm.shl %9, %7  : i32
    llvm.return %10 : i32
  }]

def n6_extrause1_before := [llvmfunc|
  llvm.func @n6_extrause1(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i64) : i64
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.add %arg1, %0  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.shl %1, %4  : i64
    %6 = llvm.xor %5, %1  : i64
    %7 = llvm.sub %2, %arg1  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use64(%4) : (i64) -> ()
    llvm.call @use64(%5) : (i64) -> ()
    llvm.call @use64(%6) : (i64) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.and %6, %arg0  : i64
    %9 = llvm.trunc %8 : i64 to i32
    llvm.call @use32(%9) : (i32) -> ()
    %10 = llvm.shl %9, %7  : i32
    llvm.return %10 : i32
  }]

def n7_extrause2_before := [llvmfunc|
  llvm.func @n7_extrause2(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i64) : i64
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.add %arg1, %0  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.shl %1, %4  : i64
    %6 = llvm.xor %5, %1  : i64
    %7 = llvm.sub %2, %arg1  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use64(%4) : (i64) -> ()
    llvm.call @use64(%5) : (i64) -> ()
    llvm.call @use64(%6) : (i64) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.and %6, %arg0  : i64
    llvm.call @use64(%8) : (i64) -> ()
    %9 = llvm.trunc %8 : i64 to i32
    llvm.call @use32(%9) : (i32) -> ()
    %10 = llvm.shl %9, %7  : i32
    llvm.return %10 : i32
  }]

def t0_basic_combined := [llvmfunc|
  llvm.func @t0_basic(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i64) : i64
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.mlir.constant(2147483647 : i32) : i32
    %4 = llvm.add %arg1, %0  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.shl %1, %5 overflow<nsw>  : i64
    %7 = llvm.xor %6, %1  : i64
    %8 = llvm.sub %2, %arg1  : i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use64(%5) : (i64) -> ()
    llvm.call @use64(%6) : (i64) -> ()
    llvm.call @use64(%7) : (i64) -> ()
    llvm.call @use32(%8) : (i32) -> ()
    %9 = llvm.trunc %arg0 : i64 to i32
    %10 = llvm.shl %9, %8  : i32
    %11 = llvm.and %10, %3  : i32
    llvm.return %11 : i32
  }]

theorem inst_combine_t0_basic   : t0_basic_before  ⊑  t0_basic_combined := by
  unfold t0_basic_before t0_basic_combined
  simp_alive_peephole
  sorry
def t1_vec_splat_combined := [llvmfunc|
  llvm.func @t1_vec_splat(%arg0: vector<8xi64>, %arg1: vector<8xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<8xi32>) : vector<8xi32>
    %1 = llvm.mlir.constant(dense<-1> : vector<8xi64>) : vector<8xi64>
    %2 = llvm.mlir.constant(dense<32> : vector<8xi32>) : vector<8xi32>
    %3 = llvm.mlir.constant(dense<2147483647> : vector<8xi32>) : vector<8xi32>
    %4 = llvm.add %arg1, %0  : vector<8xi32>
    %5 = llvm.zext %4 : vector<8xi32> to vector<8xi64>
    %6 = llvm.shl %1, %5 overflow<nsw>  : vector<8xi64>
    %7 = llvm.xor %6, %1  : vector<8xi64>
    %8 = llvm.sub %2, %arg1  : vector<8xi32>
    llvm.call @use8xi32(%4) : (vector<8xi32>) -> ()
    llvm.call @use8xi64(%5) : (vector<8xi64>) -> ()
    llvm.call @use8xi64(%6) : (vector<8xi64>) -> ()
    llvm.call @use8xi64(%7) : (vector<8xi64>) -> ()
    llvm.call @use8xi32(%8) : (vector<8xi32>) -> ()
    %9 = llvm.trunc %arg0 : vector<8xi64> to vector<8xi32>
    %10 = llvm.shl %9, %8  : vector<8xi32>
    %11 = llvm.and %10, %3  : vector<8xi32>
    llvm.return %11 : vector<8xi32>
  }]

theorem inst_combine_t1_vec_splat   : t1_vec_splat_before  ⊑  t1_vec_splat_combined := by
  unfold t1_vec_splat_before t1_vec_splat_combined
  simp_alive_peephole
  sorry
def t2_vec_splat_poison_combined := [llvmfunc|
  llvm.func @t2_vec_splat_poison(%arg0: vector<8xi64>, %arg1: vector<8xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<8xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<8xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<8xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<8xi32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<8xi32>
    %11 = llvm.mlir.constant(4 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<8xi32>
    %13 = llvm.mlir.constant(5 : i32) : i32
    %14 = llvm.insertelement %0, %12[%13 : i32] : vector<8xi32>
    %15 = llvm.mlir.constant(6 : i32) : i32
    %16 = llvm.insertelement %1, %14[%15 : i32] : vector<8xi32>
    %17 = llvm.mlir.constant(7 : i32) : i32
    %18 = llvm.insertelement %0, %16[%17 : i32] : vector<8xi32>
    %19 = llvm.mlir.constant(-1 : i64) : i64
    %20 = llvm.mlir.poison : i64
    %21 = llvm.mlir.undef : vector<8xi64>
    %22 = llvm.mlir.constant(0 : i32) : i32
    %23 = llvm.insertelement %19, %21[%22 : i32] : vector<8xi64>
    %24 = llvm.mlir.constant(1 : i32) : i32
    %25 = llvm.insertelement %19, %23[%24 : i32] : vector<8xi64>
    %26 = llvm.mlir.constant(2 : i32) : i32
    %27 = llvm.insertelement %19, %25[%26 : i32] : vector<8xi64>
    %28 = llvm.mlir.constant(3 : i32) : i32
    %29 = llvm.insertelement %19, %27[%28 : i32] : vector<8xi64>
    %30 = llvm.mlir.constant(4 : i32) : i32
    %31 = llvm.insertelement %19, %29[%30 : i32] : vector<8xi64>
    %32 = llvm.mlir.constant(5 : i32) : i32
    %33 = llvm.insertelement %19, %31[%32 : i32] : vector<8xi64>
    %34 = llvm.mlir.constant(6 : i32) : i32
    %35 = llvm.insertelement %20, %33[%34 : i32] : vector<8xi64>
    %36 = llvm.mlir.constant(7 : i32) : i32
    %37 = llvm.insertelement %19, %35[%36 : i32] : vector<8xi64>
    %38 = llvm.mlir.constant(32 : i32) : i32
    %39 = llvm.mlir.undef : vector<8xi32>
    %40 = llvm.mlir.constant(0 : i32) : i32
    %41 = llvm.insertelement %38, %39[%40 : i32] : vector<8xi32>
    %42 = llvm.mlir.constant(1 : i32) : i32
    %43 = llvm.insertelement %38, %41[%42 : i32] : vector<8xi32>
    %44 = llvm.mlir.constant(2 : i32) : i32
    %45 = llvm.insertelement %38, %43[%44 : i32] : vector<8xi32>
    %46 = llvm.mlir.constant(3 : i32) : i32
    %47 = llvm.insertelement %38, %45[%46 : i32] : vector<8xi32>
    %48 = llvm.mlir.constant(4 : i32) : i32
    %49 = llvm.insertelement %38, %47[%48 : i32] : vector<8xi32>
    %50 = llvm.mlir.constant(5 : i32) : i32
    %51 = llvm.insertelement %38, %49[%50 : i32] : vector<8xi32>
    %52 = llvm.mlir.constant(6 : i32) : i32
    %53 = llvm.insertelement %1, %51[%52 : i32] : vector<8xi32>
    %54 = llvm.mlir.constant(7 : i32) : i32
    %55 = llvm.insertelement %38, %53[%54 : i32] : vector<8xi32>
    %56 = llvm.mlir.constant(2147483647 : i32) : i32
    %57 = llvm.mlir.undef : vector<8xi32>
    %58 = llvm.mlir.constant(0 : i32) : i32
    %59 = llvm.insertelement %56, %57[%58 : i32] : vector<8xi32>
    %60 = llvm.mlir.constant(1 : i32) : i32
    %61 = llvm.insertelement %56, %59[%60 : i32] : vector<8xi32>
    %62 = llvm.mlir.constant(2 : i32) : i32
    %63 = llvm.insertelement %56, %61[%62 : i32] : vector<8xi32>
    %64 = llvm.mlir.constant(3 : i32) : i32
    %65 = llvm.insertelement %56, %63[%64 : i32] : vector<8xi32>
    %66 = llvm.mlir.constant(4 : i32) : i32
    %67 = llvm.insertelement %56, %65[%66 : i32] : vector<8xi32>
    %68 = llvm.mlir.constant(5 : i32) : i32
    %69 = llvm.insertelement %56, %67[%68 : i32] : vector<8xi32>
    %70 = llvm.mlir.constant(6 : i32) : i32
    %71 = llvm.insertelement %1, %69[%70 : i32] : vector<8xi32>
    %72 = llvm.mlir.constant(7 : i32) : i32
    %73 = llvm.insertelement %56, %71[%72 : i32] : vector<8xi32>
    %74 = llvm.add %arg1, %18  : vector<8xi32>
    %75 = llvm.zext %74 : vector<8xi32> to vector<8xi64>
    %76 = llvm.shl %37, %75 overflow<nsw>  : vector<8xi64>
    %77 = llvm.xor %76, %37  : vector<8xi64>
    %78 = llvm.sub %55, %arg1  : vector<8xi32>
    llvm.call @use8xi32(%74) : (vector<8xi32>) -> ()
    llvm.call @use8xi64(%75) : (vector<8xi64>) -> ()
    llvm.call @use8xi64(%76) : (vector<8xi64>) -> ()
    llvm.call @use8xi64(%77) : (vector<8xi64>) -> ()
    llvm.call @use8xi32(%78) : (vector<8xi32>) -> ()
    %79 = llvm.trunc %arg0 : vector<8xi64> to vector<8xi32>
    %80 = llvm.shl %79, %78  : vector<8xi32>
    %81 = llvm.and %80, %73  : vector<8xi32>
    llvm.return %81 : vector<8xi32>
  }]

theorem inst_combine_t2_vec_splat_poison   : t2_vec_splat_poison_before  ⊑  t2_vec_splat_poison_combined := by
  unfold t2_vec_splat_poison_before t2_vec_splat_poison_combined
  simp_alive_peephole
  sorry
def t3_vec_nonsplat_combined := [llvmfunc|
  llvm.func @t3_vec_nonsplat(%arg0: vector<8xi64>, %arg1: vector<8xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(dense<[-33, -32, -31, -1, 0, 1, 31, 32]> : vector<8xi32>) : vector<8xi32>
    %1 = llvm.mlir.constant(dense<-1> : vector<8xi64>) : vector<8xi64>
    %2 = llvm.mlir.constant(dense<32> : vector<8xi32>) : vector<8xi32>
    %3 = llvm.mlir.constant(-1 : i32) : i32
    %4 = llvm.mlir.constant(2147483647 : i32) : i32
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.mlir.poison : i32
    %8 = llvm.mlir.undef : vector<8xi32>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %7, %8[%9 : i32] : vector<8xi32>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %6, %10[%11 : i32] : vector<8xi32>
    %13 = llvm.mlir.constant(2 : i32) : i32
    %14 = llvm.insertelement %5, %12[%13 : i32] : vector<8xi32>
    %15 = llvm.mlir.constant(3 : i32) : i32
    %16 = llvm.insertelement %4, %14[%15 : i32] : vector<8xi32>
    %17 = llvm.mlir.constant(4 : i32) : i32
    %18 = llvm.insertelement %3, %16[%17 : i32] : vector<8xi32>
    %19 = llvm.mlir.constant(5 : i32) : i32
    %20 = llvm.insertelement %3, %18[%19 : i32] : vector<8xi32>
    %21 = llvm.mlir.constant(6 : i32) : i32
    %22 = llvm.insertelement %3, %20[%21 : i32] : vector<8xi32>
    %23 = llvm.mlir.constant(7 : i32) : i32
    %24 = llvm.insertelement %3, %22[%23 : i32] : vector<8xi32>
    %25 = llvm.add %arg1, %0  : vector<8xi32>
    %26 = llvm.zext %25 : vector<8xi32> to vector<8xi64>
    %27 = llvm.shl %1, %26 overflow<nsw>  : vector<8xi64>
    %28 = llvm.xor %27, %1  : vector<8xi64>
    %29 = llvm.sub %2, %arg1  : vector<8xi32>
    llvm.call @use8xi32(%25) : (vector<8xi32>) -> ()
    llvm.call @use8xi64(%26) : (vector<8xi64>) -> ()
    llvm.call @use8xi64(%27) : (vector<8xi64>) -> ()
    llvm.call @use8xi64(%28) : (vector<8xi64>) -> ()
    llvm.call @use8xi32(%29) : (vector<8xi32>) -> ()
    %30 = llvm.trunc %arg0 : vector<8xi64> to vector<8xi32>
    %31 = llvm.shl %30, %29  : vector<8xi32>
    %32 = llvm.and %31, %24  : vector<8xi32>
    llvm.return %32 : vector<8xi32>
  }]

theorem inst_combine_t3_vec_nonsplat   : t3_vec_nonsplat_before  ⊑  t3_vec_nonsplat_combined := by
  unfold t3_vec_nonsplat_before t3_vec_nonsplat_combined
  simp_alive_peephole
  sorry
def t4_allones_trunc_combined := [llvmfunc|
  llvm.func @t4_allones_trunc(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i64) : i64
    %2 = llvm.mlir.constant(4294967295 : i64) : i64
    %3 = llvm.mlir.constant(32 : i32) : i32
    %4 = llvm.add %arg1, %0  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.shl %1, %5 overflow<nsw>  : i64
    %7 = llvm.xor %6, %2  : i64
    %8 = llvm.sub %3, %arg1  : i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use64(%5) : (i64) -> ()
    llvm.call @use64(%6) : (i64) -> ()
    llvm.call @use64(%7) : (i64) -> ()
    llvm.call @use32(%8) : (i32) -> ()
    %9 = llvm.and %7, %arg0  : i64
    %10 = llvm.trunc %9 : i64 to i32
    %11 = llvm.shl %10, %8  : i32
    llvm.return %11 : i32
  }]

theorem inst_combine_t4_allones_trunc   : t4_allones_trunc_before  ⊑  t4_allones_trunc_combined := by
  unfold t4_allones_trunc_before t4_allones_trunc_combined
  simp_alive_peephole
  sorry
def n5_extrause0_combined := [llvmfunc|
  llvm.func @n5_extrause0(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i64) : i64
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.add %arg1, %0  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.shl %1, %4 overflow<nsw>  : i64
    %6 = llvm.xor %5, %1  : i64
    %7 = llvm.sub %2, %arg1  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use64(%4) : (i64) -> ()
    llvm.call @use64(%5) : (i64) -> ()
    llvm.call @use64(%6) : (i64) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.and %6, %arg0  : i64
    llvm.call @use64(%8) : (i64) -> ()
    %9 = llvm.trunc %8 : i64 to i32
    %10 = llvm.shl %9, %7  : i32
    llvm.return %10 : i32
  }]

theorem inst_combine_n5_extrause0   : n5_extrause0_before  ⊑  n5_extrause0_combined := by
  unfold n5_extrause0_before n5_extrause0_combined
  simp_alive_peephole
  sorry
def n6_extrause1_combined := [llvmfunc|
  llvm.func @n6_extrause1(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i64) : i64
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.add %arg1, %0  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.shl %1, %4 overflow<nsw>  : i64
    %6 = llvm.xor %5, %1  : i64
    %7 = llvm.sub %2, %arg1  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use64(%4) : (i64) -> ()
    llvm.call @use64(%5) : (i64) -> ()
    llvm.call @use64(%6) : (i64) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.and %6, %arg0  : i64
    %9 = llvm.trunc %8 : i64 to i32
    llvm.call @use32(%9) : (i32) -> ()
    %10 = llvm.shl %9, %7  : i32
    llvm.return %10 : i32
  }]

theorem inst_combine_n6_extrause1   : n6_extrause1_before  ⊑  n6_extrause1_combined := by
  unfold n6_extrause1_before n6_extrause1_combined
  simp_alive_peephole
  sorry
def n7_extrause2_combined := [llvmfunc|
  llvm.func @n7_extrause2(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i64) : i64
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.add %arg1, %0  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.shl %1, %4 overflow<nsw>  : i64
    %6 = llvm.xor %5, %1  : i64
    %7 = llvm.sub %2, %arg1  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use64(%4) : (i64) -> ()
    llvm.call @use64(%5) : (i64) -> ()
    llvm.call @use64(%6) : (i64) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.and %6, %arg0  : i64
    llvm.call @use64(%8) : (i64) -> ()
    %9 = llvm.trunc %8 : i64 to i32
    llvm.call @use32(%9) : (i32) -> ()
    %10 = llvm.shl %9, %7  : i32
    llvm.return %10 : i32
  }]

theorem inst_combine_n7_extrause2   : n7_extrause2_before  ⊑  n7_extrause2_combined := by
  unfold n7_extrause2_before n7_extrause2_combined
  simp_alive_peephole
  sorry
