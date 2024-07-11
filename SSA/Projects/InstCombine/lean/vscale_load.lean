import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  vscale_load
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def constprop_load_bitcast_before := [llvmfunc|
  llvm.func @constprop_load_bitcast(%arg0: !llvm.ptr) -> vector<2xi8> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.undef : !llvm.vec<? x 16 x  i1>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.insertelement %0, %1[%2 : i32] : !llvm.vec<? x 16 x  i1>
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.insertelement %0, %3[%4 : i32] : !llvm.vec<? x 16 x  i1>
    %6 = llvm.mlir.constant(2 : i32) : i32
    %7 = llvm.insertelement %0, %5[%6 : i32] : !llvm.vec<? x 16 x  i1>
    %8 = llvm.mlir.constant(3 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : !llvm.vec<? x 16 x  i1>
    %10 = llvm.mlir.constant(4 : i32) : i32
    %11 = llvm.insertelement %0, %9[%10 : i32] : !llvm.vec<? x 16 x  i1>
    %12 = llvm.mlir.constant(5 : i32) : i32
    %13 = llvm.insertelement %0, %11[%12 : i32] : !llvm.vec<? x 16 x  i1>
    %14 = llvm.mlir.constant(6 : i32) : i32
    %15 = llvm.insertelement %0, %13[%14 : i32] : !llvm.vec<? x 16 x  i1>
    %16 = llvm.mlir.constant(7 : i32) : i32
    %17 = llvm.insertelement %0, %15[%16 : i32] : !llvm.vec<? x 16 x  i1>
    %18 = llvm.mlir.constant(8 : i32) : i32
    %19 = llvm.insertelement %0, %17[%18 : i32] : !llvm.vec<? x 16 x  i1>
    %20 = llvm.mlir.constant(9 : i32) : i32
    %21 = llvm.insertelement %0, %19[%20 : i32] : !llvm.vec<? x 16 x  i1>
    %22 = llvm.mlir.constant(10 : i32) : i32
    %23 = llvm.insertelement %0, %21[%22 : i32] : !llvm.vec<? x 16 x  i1>
    %24 = llvm.mlir.constant(11 : i32) : i32
    %25 = llvm.insertelement %0, %23[%24 : i32] : !llvm.vec<? x 16 x  i1>
    %26 = llvm.mlir.constant(12 : i32) : i32
    %27 = llvm.insertelement %0, %25[%26 : i32] : !llvm.vec<? x 16 x  i1>
    %28 = llvm.mlir.constant(13 : i32) : i32
    %29 = llvm.insertelement %0, %27[%28 : i32] : !llvm.vec<? x 16 x  i1>
    %30 = llvm.mlir.constant(14 : i32) : i32
    %31 = llvm.insertelement %0, %29[%30 : i32] : !llvm.vec<? x 16 x  i1>
    %32 = llvm.mlir.constant(15 : i32) : i32
    %33 = llvm.insertelement %0, %31[%32 : i32] : !llvm.vec<? x 16 x  i1>
    llvm.store %33, %arg0 {alignment = 16 : i64} : !llvm.vec<? x 16 x  i1>, !llvm.ptr]

    %34 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr -> vector<2xi8>]

    llvm.return %34 : vector<2xi8>
  }]

def constprop_load_bitcast_neg_before := [llvmfunc|
  llvm.func @constprop_load_bitcast_neg(%arg0: !llvm.ptr) -> vector<8xi8> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.undef : !llvm.vec<? x 16 x  i1>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.insertelement %0, %1[%2 : i32] : !llvm.vec<? x 16 x  i1>
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.insertelement %0, %3[%4 : i32] : !llvm.vec<? x 16 x  i1>
    %6 = llvm.mlir.constant(2 : i32) : i32
    %7 = llvm.insertelement %0, %5[%6 : i32] : !llvm.vec<? x 16 x  i1>
    %8 = llvm.mlir.constant(3 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : !llvm.vec<? x 16 x  i1>
    %10 = llvm.mlir.constant(4 : i32) : i32
    %11 = llvm.insertelement %0, %9[%10 : i32] : !llvm.vec<? x 16 x  i1>
    %12 = llvm.mlir.constant(5 : i32) : i32
    %13 = llvm.insertelement %0, %11[%12 : i32] : !llvm.vec<? x 16 x  i1>
    %14 = llvm.mlir.constant(6 : i32) : i32
    %15 = llvm.insertelement %0, %13[%14 : i32] : !llvm.vec<? x 16 x  i1>
    %16 = llvm.mlir.constant(7 : i32) : i32
    %17 = llvm.insertelement %0, %15[%16 : i32] : !llvm.vec<? x 16 x  i1>
    %18 = llvm.mlir.constant(8 : i32) : i32
    %19 = llvm.insertelement %0, %17[%18 : i32] : !llvm.vec<? x 16 x  i1>
    %20 = llvm.mlir.constant(9 : i32) : i32
    %21 = llvm.insertelement %0, %19[%20 : i32] : !llvm.vec<? x 16 x  i1>
    %22 = llvm.mlir.constant(10 : i32) : i32
    %23 = llvm.insertelement %0, %21[%22 : i32] : !llvm.vec<? x 16 x  i1>
    %24 = llvm.mlir.constant(11 : i32) : i32
    %25 = llvm.insertelement %0, %23[%24 : i32] : !llvm.vec<? x 16 x  i1>
    %26 = llvm.mlir.constant(12 : i32) : i32
    %27 = llvm.insertelement %0, %25[%26 : i32] : !llvm.vec<? x 16 x  i1>
    %28 = llvm.mlir.constant(13 : i32) : i32
    %29 = llvm.insertelement %0, %27[%28 : i32] : !llvm.vec<? x 16 x  i1>
    %30 = llvm.mlir.constant(14 : i32) : i32
    %31 = llvm.insertelement %0, %29[%30 : i32] : !llvm.vec<? x 16 x  i1>
    %32 = llvm.mlir.constant(15 : i32) : i32
    %33 = llvm.insertelement %0, %31[%32 : i32] : !llvm.vec<? x 16 x  i1>
    llvm.store %33, %arg0 {alignment = 16 : i64} : !llvm.vec<? x 16 x  i1>, !llvm.ptr]

    %34 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr -> vector<8xi8>]

    llvm.return %34 : vector<8xi8>
  }]

def constprop_load_bitcast_combined := [llvmfunc|
  llvm.func @constprop_load_bitcast(%arg0: !llvm.ptr) -> vector<2xi8> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.undef : !llvm.vec<? x 16 x  i1>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.insertelement %0, %1[%2 : i32] : !llvm.vec<? x 16 x  i1>
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.insertelement %0, %3[%4 : i32] : !llvm.vec<? x 16 x  i1>
    %6 = llvm.mlir.constant(2 : i32) : i32
    %7 = llvm.insertelement %0, %5[%6 : i32] : !llvm.vec<? x 16 x  i1>
    %8 = llvm.mlir.constant(3 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : !llvm.vec<? x 16 x  i1>
    %10 = llvm.mlir.constant(4 : i32) : i32
    %11 = llvm.insertelement %0, %9[%10 : i32] : !llvm.vec<? x 16 x  i1>
    %12 = llvm.mlir.constant(5 : i32) : i32
    %13 = llvm.insertelement %0, %11[%12 : i32] : !llvm.vec<? x 16 x  i1>
    %14 = llvm.mlir.constant(6 : i32) : i32
    %15 = llvm.insertelement %0, %13[%14 : i32] : !llvm.vec<? x 16 x  i1>
    %16 = llvm.mlir.constant(7 : i32) : i32
    %17 = llvm.insertelement %0, %15[%16 : i32] : !llvm.vec<? x 16 x  i1>
    %18 = llvm.mlir.constant(8 : i32) : i32
    %19 = llvm.insertelement %0, %17[%18 : i32] : !llvm.vec<? x 16 x  i1>
    %20 = llvm.mlir.constant(9 : i32) : i32
    %21 = llvm.insertelement %0, %19[%20 : i32] : !llvm.vec<? x 16 x  i1>
    %22 = llvm.mlir.constant(10 : i32) : i32
    %23 = llvm.insertelement %0, %21[%22 : i32] : !llvm.vec<? x 16 x  i1>
    %24 = llvm.mlir.constant(11 : i32) : i32
    %25 = llvm.insertelement %0, %23[%24 : i32] : !llvm.vec<? x 16 x  i1>
    %26 = llvm.mlir.constant(12 : i32) : i32
    %27 = llvm.insertelement %0, %25[%26 : i32] : !llvm.vec<? x 16 x  i1>
    %28 = llvm.mlir.constant(13 : i32) : i32
    %29 = llvm.insertelement %0, %27[%28 : i32] : !llvm.vec<? x 16 x  i1>
    %30 = llvm.mlir.constant(14 : i32) : i32
    %31 = llvm.insertelement %0, %29[%30 : i32] : !llvm.vec<? x 16 x  i1>
    %32 = llvm.mlir.constant(15 : i32) : i32
    %33 = llvm.insertelement %0, %31[%32 : i32] : !llvm.vec<? x 16 x  i1>
    %34 = llvm.mlir.constant(0 : i8) : i8
    %35 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    llvm.store %33, %arg0 {alignment = 16 : i64} : !llvm.vec<? x 16 x  i1>, !llvm.ptr]

theorem inst_combine_constprop_load_bitcast   : constprop_load_bitcast_before  ⊑  constprop_load_bitcast_combined := by
  unfold constprop_load_bitcast_before constprop_load_bitcast_combined
  simp_alive_peephole
  sorry
    llvm.return %35 : vector<2xi8>
  }]

theorem inst_combine_constprop_load_bitcast   : constprop_load_bitcast_before  ⊑  constprop_load_bitcast_combined := by
  unfold constprop_load_bitcast_before constprop_load_bitcast_combined
  simp_alive_peephole
  sorry
def constprop_load_bitcast_neg_combined := [llvmfunc|
  llvm.func @constprop_load_bitcast_neg(%arg0: !llvm.ptr) -> vector<8xi8> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.undef : !llvm.vec<? x 16 x  i1>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.insertelement %0, %1[%2 : i32] : !llvm.vec<? x 16 x  i1>
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.insertelement %0, %3[%4 : i32] : !llvm.vec<? x 16 x  i1>
    %6 = llvm.mlir.constant(2 : i32) : i32
    %7 = llvm.insertelement %0, %5[%6 : i32] : !llvm.vec<? x 16 x  i1>
    %8 = llvm.mlir.constant(3 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : !llvm.vec<? x 16 x  i1>
    %10 = llvm.mlir.constant(4 : i32) : i32
    %11 = llvm.insertelement %0, %9[%10 : i32] : !llvm.vec<? x 16 x  i1>
    %12 = llvm.mlir.constant(5 : i32) : i32
    %13 = llvm.insertelement %0, %11[%12 : i32] : !llvm.vec<? x 16 x  i1>
    %14 = llvm.mlir.constant(6 : i32) : i32
    %15 = llvm.insertelement %0, %13[%14 : i32] : !llvm.vec<? x 16 x  i1>
    %16 = llvm.mlir.constant(7 : i32) : i32
    %17 = llvm.insertelement %0, %15[%16 : i32] : !llvm.vec<? x 16 x  i1>
    %18 = llvm.mlir.constant(8 : i32) : i32
    %19 = llvm.insertelement %0, %17[%18 : i32] : !llvm.vec<? x 16 x  i1>
    %20 = llvm.mlir.constant(9 : i32) : i32
    %21 = llvm.insertelement %0, %19[%20 : i32] : !llvm.vec<? x 16 x  i1>
    %22 = llvm.mlir.constant(10 : i32) : i32
    %23 = llvm.insertelement %0, %21[%22 : i32] : !llvm.vec<? x 16 x  i1>
    %24 = llvm.mlir.constant(11 : i32) : i32
    %25 = llvm.insertelement %0, %23[%24 : i32] : !llvm.vec<? x 16 x  i1>
    %26 = llvm.mlir.constant(12 : i32) : i32
    %27 = llvm.insertelement %0, %25[%26 : i32] : !llvm.vec<? x 16 x  i1>
    %28 = llvm.mlir.constant(13 : i32) : i32
    %29 = llvm.insertelement %0, %27[%28 : i32] : !llvm.vec<? x 16 x  i1>
    %30 = llvm.mlir.constant(14 : i32) : i32
    %31 = llvm.insertelement %0, %29[%30 : i32] : !llvm.vec<? x 16 x  i1>
    %32 = llvm.mlir.constant(15 : i32) : i32
    %33 = llvm.insertelement %0, %31[%32 : i32] : !llvm.vec<? x 16 x  i1>
    llvm.store %33, %arg0 {alignment = 16 : i64} : !llvm.vec<? x 16 x  i1>, !llvm.ptr]

theorem inst_combine_constprop_load_bitcast_neg   : constprop_load_bitcast_neg_before  ⊑  constprop_load_bitcast_neg_combined := by
  unfold constprop_load_bitcast_neg_before constprop_load_bitcast_neg_combined
  simp_alive_peephole
  sorry
    %34 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr -> vector<8xi8>]

theorem inst_combine_constprop_load_bitcast_neg   : constprop_load_bitcast_neg_before  ⊑  constprop_load_bitcast_neg_combined := by
  unfold constprop_load_bitcast_neg_before constprop_load_bitcast_neg_combined
  simp_alive_peephole
  sorry
    llvm.return %34 : vector<8xi8>
  }]

theorem inst_combine_constprop_load_bitcast_neg   : constprop_load_bitcast_neg_before  ⊑  constprop_load_bitcast_neg_combined := by
  unfold constprop_load_bitcast_neg_before constprop_load_bitcast_neg_combined
  simp_alive_peephole
  sorry
