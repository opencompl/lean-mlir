import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  partally-redundant-left-shift-input-masking-variant-a
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t0_basic_before := [llvmfunc|
  llvm.func @t0_basic(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.add %arg1, %0  : i32
    %4 = llvm.shl %1, %3  : i32
    %5 = llvm.add %4, %0  : i32
    %6 = llvm.and %5, %arg0  : i32
    %7 = llvm.sub %2, %arg1  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.shl %6, %7  : i32
    llvm.return %8 : i32
  }]

def t1_vec_splat_before := [llvmfunc|
  llvm.func @t1_vec_splat(%arg0: vector<8xi32>, %arg1: vector<8xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<8xi32>) : vector<8xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<8xi32>) : vector<8xi32>
    %2 = llvm.mlir.constant(dense<32> : vector<8xi32>) : vector<8xi32>
    %3 = llvm.add %arg1, %0  : vector<8xi32>
    %4 = llvm.shl %1, %3  : vector<8xi32>
    %5 = llvm.add %4, %0  : vector<8xi32>
    %6 = llvm.and %5, %arg0  : vector<8xi32>
    %7 = llvm.sub %2, %arg1  : vector<8xi32>
    llvm.call @use8xi32(%3) : (vector<8xi32>) -> ()
    llvm.call @use8xi32(%4) : (vector<8xi32>) -> ()
    llvm.call @use8xi32(%5) : (vector<8xi32>) -> ()
    llvm.call @use8xi32(%7) : (vector<8xi32>) -> ()
    %8 = llvm.shl %6, %7  : vector<8xi32>
    llvm.return %8 : vector<8xi32>
  }]

def t1_vec_splat_poison_before := [llvmfunc|
  llvm.func @t1_vec_splat_poison(%arg0: vector<8xi32>, %arg1: vector<8xi32>) -> vector<8xi32> {
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
    %19 = llvm.mlir.constant(1 : i32) : i32
    %20 = llvm.mlir.undef : vector<8xi32>
    %21 = llvm.mlir.constant(0 : i32) : i32
    %22 = llvm.insertelement %19, %20[%21 : i32] : vector<8xi32>
    %23 = llvm.mlir.constant(1 : i32) : i32
    %24 = llvm.insertelement %19, %22[%23 : i32] : vector<8xi32>
    %25 = llvm.mlir.constant(2 : i32) : i32
    %26 = llvm.insertelement %19, %24[%25 : i32] : vector<8xi32>
    %27 = llvm.mlir.constant(3 : i32) : i32
    %28 = llvm.insertelement %19, %26[%27 : i32] : vector<8xi32>
    %29 = llvm.mlir.constant(4 : i32) : i32
    %30 = llvm.insertelement %19, %28[%29 : i32] : vector<8xi32>
    %31 = llvm.mlir.constant(5 : i32) : i32
    %32 = llvm.insertelement %19, %30[%31 : i32] : vector<8xi32>
    %33 = llvm.mlir.constant(6 : i32) : i32
    %34 = llvm.insertelement %1, %32[%33 : i32] : vector<8xi32>
    %35 = llvm.mlir.constant(7 : i32) : i32
    %36 = llvm.insertelement %19, %34[%35 : i32] : vector<8xi32>
    %37 = llvm.mlir.constant(32 : i32) : i32
    %38 = llvm.mlir.undef : vector<8xi32>
    %39 = llvm.mlir.constant(0 : i32) : i32
    %40 = llvm.insertelement %37, %38[%39 : i32] : vector<8xi32>
    %41 = llvm.mlir.constant(1 : i32) : i32
    %42 = llvm.insertelement %37, %40[%41 : i32] : vector<8xi32>
    %43 = llvm.mlir.constant(2 : i32) : i32
    %44 = llvm.insertelement %37, %42[%43 : i32] : vector<8xi32>
    %45 = llvm.mlir.constant(3 : i32) : i32
    %46 = llvm.insertelement %37, %44[%45 : i32] : vector<8xi32>
    %47 = llvm.mlir.constant(4 : i32) : i32
    %48 = llvm.insertelement %37, %46[%47 : i32] : vector<8xi32>
    %49 = llvm.mlir.constant(5 : i32) : i32
    %50 = llvm.insertelement %37, %48[%49 : i32] : vector<8xi32>
    %51 = llvm.mlir.constant(6 : i32) : i32
    %52 = llvm.insertelement %1, %50[%51 : i32] : vector<8xi32>
    %53 = llvm.mlir.constant(7 : i32) : i32
    %54 = llvm.insertelement %37, %52[%53 : i32] : vector<8xi32>
    %55 = llvm.add %arg1, %18  : vector<8xi32>
    %56 = llvm.shl %36, %55  : vector<8xi32>
    %57 = llvm.add %56, %18  : vector<8xi32>
    %58 = llvm.and %57, %arg0  : vector<8xi32>
    %59 = llvm.sub %54, %arg1  : vector<8xi32>
    llvm.call @use8xi32(%55) : (vector<8xi32>) -> ()
    llvm.call @use8xi32(%56) : (vector<8xi32>) -> ()
    llvm.call @use8xi32(%57) : (vector<8xi32>) -> ()
    llvm.call @use8xi32(%59) : (vector<8xi32>) -> ()
    %60 = llvm.shl %58, %59  : vector<8xi32>
    llvm.return %60 : vector<8xi32>
  }]

def t2_vec_nonsplat_before := [llvmfunc|
  llvm.func @t2_vec_nonsplat(%arg0: vector<8xi32>, %arg1: vector<8xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(dense<[-33, -32, -31, -1, 0, 1, 31, 32]> : vector<8xi32>) : vector<8xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<8xi32>) : vector<8xi32>
    %2 = llvm.mlir.constant(dense<-1> : vector<8xi32>) : vector<8xi32>
    %3 = llvm.mlir.constant(dense<32> : vector<8xi32>) : vector<8xi32>
    %4 = llvm.add %arg1, %0  : vector<8xi32>
    %5 = llvm.shl %1, %4  : vector<8xi32>
    %6 = llvm.add %5, %2  : vector<8xi32>
    %7 = llvm.and %6, %arg0  : vector<8xi32>
    %8 = llvm.sub %3, %arg1  : vector<8xi32>
    llvm.call @use8xi32(%4) : (vector<8xi32>) -> ()
    llvm.call @use8xi32(%5) : (vector<8xi32>) -> ()
    llvm.call @use8xi32(%6) : (vector<8xi32>) -> ()
    llvm.call @use8xi32(%8) : (vector<8xi32>) -> ()
    %9 = llvm.shl %7, %8  : vector<8xi32>
    llvm.return %9 : vector<8xi32>
  }]

def n3_extrause_before := [llvmfunc|
  llvm.func @n3_extrause(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.add %arg1, %0  : i32
    %4 = llvm.shl %1, %3  : i32
    %5 = llvm.add %4, %0  : i32
    %6 = llvm.and %5, %arg0  : i32
    %7 = llvm.sub %2, %arg1  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.shl %6, %7  : i32
    llvm.return %8 : i32
  }]

def t0_basic_combined := [llvmfunc|
  llvm.func @t0_basic(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.mlir.constant(2147483647 : i32) : i32
    %4 = llvm.add %arg1, %0  : i32
    %5 = llvm.shl %1, %4 overflow<nuw>  : i32
    %6 = llvm.add %5, %0  : i32
    %7 = llvm.sub %2, %arg1  : i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.shl %arg0, %7  : i32
    %9 = llvm.and %8, %3  : i32
    llvm.return %9 : i32
  }]

theorem inst_combine_t0_basic   : t0_basic_before  ⊑  t0_basic_combined := by
  unfold t0_basic_before t0_basic_combined
  simp_alive_peephole
  sorry
def t1_vec_splat_combined := [llvmfunc|
  llvm.func @t1_vec_splat(%arg0: vector<8xi32>, %arg1: vector<8xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<8xi32>) : vector<8xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<8xi32>) : vector<8xi32>
    %2 = llvm.mlir.constant(dense<32> : vector<8xi32>) : vector<8xi32>
    %3 = llvm.mlir.constant(dense<2147483647> : vector<8xi32>) : vector<8xi32>
    %4 = llvm.add %arg1, %0  : vector<8xi32>
    %5 = llvm.shl %1, %4 overflow<nuw>  : vector<8xi32>
    %6 = llvm.add %5, %0  : vector<8xi32>
    %7 = llvm.sub %2, %arg1  : vector<8xi32>
    llvm.call @use8xi32(%4) : (vector<8xi32>) -> ()
    llvm.call @use8xi32(%5) : (vector<8xi32>) -> ()
    llvm.call @use8xi32(%6) : (vector<8xi32>) -> ()
    llvm.call @use8xi32(%7) : (vector<8xi32>) -> ()
    %8 = llvm.shl %arg0, %7  : vector<8xi32>
    %9 = llvm.and %8, %3  : vector<8xi32>
    llvm.return %9 : vector<8xi32>
  }]

theorem inst_combine_t1_vec_splat   : t1_vec_splat_before  ⊑  t1_vec_splat_combined := by
  unfold t1_vec_splat_before t1_vec_splat_combined
  simp_alive_peephole
  sorry
def t1_vec_splat_poison_combined := [llvmfunc|
  llvm.func @t1_vec_splat_poison(%arg0: vector<8xi32>, %arg1: vector<8xi32>) -> vector<8xi32> {
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
    %19 = llvm.mlir.constant(1 : i32) : i32
    %20 = llvm.mlir.undef : vector<8xi32>
    %21 = llvm.mlir.constant(0 : i32) : i32
    %22 = llvm.insertelement %19, %20[%21 : i32] : vector<8xi32>
    %23 = llvm.mlir.constant(1 : i32) : i32
    %24 = llvm.insertelement %19, %22[%23 : i32] : vector<8xi32>
    %25 = llvm.mlir.constant(2 : i32) : i32
    %26 = llvm.insertelement %19, %24[%25 : i32] : vector<8xi32>
    %27 = llvm.mlir.constant(3 : i32) : i32
    %28 = llvm.insertelement %19, %26[%27 : i32] : vector<8xi32>
    %29 = llvm.mlir.constant(4 : i32) : i32
    %30 = llvm.insertelement %19, %28[%29 : i32] : vector<8xi32>
    %31 = llvm.mlir.constant(5 : i32) : i32
    %32 = llvm.insertelement %19, %30[%31 : i32] : vector<8xi32>
    %33 = llvm.mlir.constant(6 : i32) : i32
    %34 = llvm.insertelement %1, %32[%33 : i32] : vector<8xi32>
    %35 = llvm.mlir.constant(7 : i32) : i32
    %36 = llvm.insertelement %19, %34[%35 : i32] : vector<8xi32>
    %37 = llvm.mlir.constant(32 : i32) : i32
    %38 = llvm.mlir.undef : vector<8xi32>
    %39 = llvm.mlir.constant(0 : i32) : i32
    %40 = llvm.insertelement %37, %38[%39 : i32] : vector<8xi32>
    %41 = llvm.mlir.constant(1 : i32) : i32
    %42 = llvm.insertelement %37, %40[%41 : i32] : vector<8xi32>
    %43 = llvm.mlir.constant(2 : i32) : i32
    %44 = llvm.insertelement %37, %42[%43 : i32] : vector<8xi32>
    %45 = llvm.mlir.constant(3 : i32) : i32
    %46 = llvm.insertelement %37, %44[%45 : i32] : vector<8xi32>
    %47 = llvm.mlir.constant(4 : i32) : i32
    %48 = llvm.insertelement %37, %46[%47 : i32] : vector<8xi32>
    %49 = llvm.mlir.constant(5 : i32) : i32
    %50 = llvm.insertelement %37, %48[%49 : i32] : vector<8xi32>
    %51 = llvm.mlir.constant(6 : i32) : i32
    %52 = llvm.insertelement %1, %50[%51 : i32] : vector<8xi32>
    %53 = llvm.mlir.constant(7 : i32) : i32
    %54 = llvm.insertelement %37, %52[%53 : i32] : vector<8xi32>
    %55 = llvm.mlir.constant(2147483647 : i32) : i32
    %56 = llvm.mlir.undef : vector<8xi32>
    %57 = llvm.mlir.constant(0 : i32) : i32
    %58 = llvm.insertelement %55, %56[%57 : i32] : vector<8xi32>
    %59 = llvm.mlir.constant(1 : i32) : i32
    %60 = llvm.insertelement %55, %58[%59 : i32] : vector<8xi32>
    %61 = llvm.mlir.constant(2 : i32) : i32
    %62 = llvm.insertelement %55, %60[%61 : i32] : vector<8xi32>
    %63 = llvm.mlir.constant(3 : i32) : i32
    %64 = llvm.insertelement %55, %62[%63 : i32] : vector<8xi32>
    %65 = llvm.mlir.constant(4 : i32) : i32
    %66 = llvm.insertelement %55, %64[%65 : i32] : vector<8xi32>
    %67 = llvm.mlir.constant(5 : i32) : i32
    %68 = llvm.insertelement %55, %66[%67 : i32] : vector<8xi32>
    %69 = llvm.mlir.constant(6 : i32) : i32
    %70 = llvm.insertelement %1, %68[%69 : i32] : vector<8xi32>
    %71 = llvm.mlir.constant(7 : i32) : i32
    %72 = llvm.insertelement %55, %70[%71 : i32] : vector<8xi32>
    %73 = llvm.add %arg1, %18  : vector<8xi32>
    %74 = llvm.shl %36, %73 overflow<nuw>  : vector<8xi32>
    %75 = llvm.add %74, %18  : vector<8xi32>
    %76 = llvm.sub %54, %arg1  : vector<8xi32>
    llvm.call @use8xi32(%73) : (vector<8xi32>) -> ()
    llvm.call @use8xi32(%74) : (vector<8xi32>) -> ()
    llvm.call @use8xi32(%75) : (vector<8xi32>) -> ()
    llvm.call @use8xi32(%76) : (vector<8xi32>) -> ()
    %77 = llvm.shl %arg0, %76  : vector<8xi32>
    %78 = llvm.and %77, %72  : vector<8xi32>
    llvm.return %78 : vector<8xi32>
  }]

theorem inst_combine_t1_vec_splat_poison   : t1_vec_splat_poison_before  ⊑  t1_vec_splat_poison_combined := by
  unfold t1_vec_splat_poison_before t1_vec_splat_poison_combined
  simp_alive_peephole
  sorry
def t2_vec_nonsplat_combined := [llvmfunc|
  llvm.func @t2_vec_nonsplat(%arg0: vector<8xi32>, %arg1: vector<8xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(dense<[-33, -32, -31, -1, 0, 1, 31, 32]> : vector<8xi32>) : vector<8xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<8xi32>) : vector<8xi32>
    %2 = llvm.mlir.constant(dense<-1> : vector<8xi32>) : vector<8xi32>
    %3 = llvm.mlir.constant(dense<32> : vector<8xi32>) : vector<8xi32>
    %4 = llvm.mlir.poison : i32
    %5 = llvm.mlir.constant(-1 : i32) : i32
    %6 = llvm.mlir.constant(2147483647 : i32) : i32
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.mlir.undef : vector<8xi32>
    %10 = llvm.mlir.constant(0 : i32) : i32
    %11 = llvm.insertelement %4, %9[%10 : i32] : vector<8xi32>
    %12 = llvm.mlir.constant(1 : i32) : i32
    %13 = llvm.insertelement %8, %11[%12 : i32] : vector<8xi32>
    %14 = llvm.mlir.constant(2 : i32) : i32
    %15 = llvm.insertelement %7, %13[%14 : i32] : vector<8xi32>
    %16 = llvm.mlir.constant(3 : i32) : i32
    %17 = llvm.insertelement %6, %15[%16 : i32] : vector<8xi32>
    %18 = llvm.mlir.constant(4 : i32) : i32
    %19 = llvm.insertelement %5, %17[%18 : i32] : vector<8xi32>
    %20 = llvm.mlir.constant(5 : i32) : i32
    %21 = llvm.insertelement %5, %19[%20 : i32] : vector<8xi32>
    %22 = llvm.mlir.constant(6 : i32) : i32
    %23 = llvm.insertelement %5, %21[%22 : i32] : vector<8xi32>
    %24 = llvm.mlir.constant(7 : i32) : i32
    %25 = llvm.insertelement %4, %23[%24 : i32] : vector<8xi32>
    %26 = llvm.add %arg1, %0  : vector<8xi32>
    %27 = llvm.shl %1, %26 overflow<nuw>  : vector<8xi32>
    %28 = llvm.add %27, %2  : vector<8xi32>
    %29 = llvm.sub %3, %arg1  : vector<8xi32>
    llvm.call @use8xi32(%26) : (vector<8xi32>) -> ()
    llvm.call @use8xi32(%27) : (vector<8xi32>) -> ()
    llvm.call @use8xi32(%28) : (vector<8xi32>) -> ()
    llvm.call @use8xi32(%29) : (vector<8xi32>) -> ()
    %30 = llvm.shl %arg0, %29  : vector<8xi32>
    %31 = llvm.and %30, %25  : vector<8xi32>
    llvm.return %31 : vector<8xi32>
  }]

theorem inst_combine_t2_vec_nonsplat   : t2_vec_nonsplat_before  ⊑  t2_vec_nonsplat_combined := by
  unfold t2_vec_nonsplat_before t2_vec_nonsplat_combined
  simp_alive_peephole
  sorry
def n3_extrause_combined := [llvmfunc|
  llvm.func @n3_extrause(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.add %arg1, %0  : i32
    %4 = llvm.shl %1, %3 overflow<nuw>  : i32
    %5 = llvm.add %4, %0  : i32
    %6 = llvm.and %5, %arg0  : i32
    %7 = llvm.sub %2, %arg1  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.shl %6, %7  : i32
    llvm.return %8 : i32
  }]

theorem inst_combine_n3_extrause   : n3_extrause_before  ⊑  n3_extrause_combined := by
  unfold n3_extrause_before n3_extrause_combined
  simp_alive_peephole
  sorry
