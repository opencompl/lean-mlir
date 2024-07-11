import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  fold-bin-operand
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def f_before := [llvmfunc|
  llvm.func @f(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.inttoptr %0 : i32 to !llvm.ptr
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.inttoptr %2 : i32 to !llvm.ptr
    %4 = llvm.icmp "eq" %1, %3 : !llvm.ptr
    %5 = llvm.and %arg0, %4  : i1
    llvm.return %5 : i1
  }]

def f_logical_before := [llvmfunc|
  llvm.func @f_logical(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.inttoptr %0 : i32 to !llvm.ptr
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.inttoptr %2 : i32 to !llvm.ptr
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.icmp "eq" %1, %3 : !llvm.ptr
    %6 = llvm.select %arg0, %5, %4 : i1, i1
    llvm.return %6 : i1
  }]

def g_before := [llvmfunc|
  llvm.func @g(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.inttoptr %0 : i32 to !llvm.ptr
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.inttoptr %2 : i32 to !llvm.ptr
    %4 = llvm.icmp "eq" %1, %3 : !llvm.ptr
    %5 = llvm.zext %4 : i1 to i32
    %6 = llvm.add %arg0, %5  : i32
    llvm.return %6 : i32
  }]

def h_before := [llvmfunc|
  llvm.func @h(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.select %arg0, %0, %arg1 : i1, i32
    %3 = llvm.add %1, %2  : i32
    llvm.return %3 : i32
  }]

def h1_before := [llvmfunc|
  llvm.func @h1(%arg0: i1, %arg1: vector<4xi32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.select %arg0, %0, %arg1 : i1, vector<4xi32>
    %2 = llvm.bitcast %1 : vector<4xi32> to vector<4xf32>
    llvm.return %2 : vector<4xf32>
  }]

def h2_before := [llvmfunc|
  llvm.func @h2(%arg0: i1, %arg1: !llvm.vec<? x 4 x  i32>) -> !llvm.vec<? x 4 x  f32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.undef : !llvm.vec<? x 4 x  i32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.insertelement %0, %1[%2 : i32] : !llvm.vec<? x 4 x  i32>
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.insertelement %0, %3[%4 : i32] : !llvm.vec<? x 4 x  i32>
    %6 = llvm.mlir.constant(2 : i32) : i32
    %7 = llvm.insertelement %0, %5[%6 : i32] : !llvm.vec<? x 4 x  i32>
    %8 = llvm.mlir.constant(3 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : !llvm.vec<? x 4 x  i32>
    %10 = llvm.select %arg0, %9, %arg1 : i1, !llvm.vec<? x 4 x  i32>
    %11 = llvm.bitcast %10 : !llvm.vec<? x 4 x  i32> to !llvm.vec<? x 4 x  f32>
    llvm.return %11 : !llvm.vec<? x 4 x  f32>
  }]

def h3_before := [llvmfunc|
  llvm.func @h3(%arg0: i1, %arg1: !llvm.vec<? x 4 x  i32>) -> !llvm.vec<? x 2 x  i64> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.undef : !llvm.vec<? x 4 x  i32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.insertelement %0, %1[%2 : i32] : !llvm.vec<? x 4 x  i32>
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.insertelement %0, %3[%4 : i32] : !llvm.vec<? x 4 x  i32>
    %6 = llvm.mlir.constant(2 : i32) : i32
    %7 = llvm.insertelement %0, %5[%6 : i32] : !llvm.vec<? x 4 x  i32>
    %8 = llvm.mlir.constant(3 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : !llvm.vec<? x 4 x  i32>
    %10 = llvm.select %arg0, %9, %arg1 : i1, !llvm.vec<? x 4 x  i32>
    %11 = llvm.bitcast %10 : !llvm.vec<? x 4 x  i32> to !llvm.vec<? x 2 x  i64>
    llvm.return %11 : !llvm.vec<? x 2 x  i64>
  }]

def f_combined := [llvmfunc|
  llvm.func @f(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_f   : f_before  ⊑  f_combined := by
  unfold f_before f_combined
  simp_alive_peephole
  sorry
def f_logical_combined := [llvmfunc|
  llvm.func @f_logical(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_f_logical   : f_logical_before  ⊑  f_logical_combined := by
  unfold f_logical_before f_logical_combined
  simp_alive_peephole
  sorry
def g_combined := [llvmfunc|
  llvm.func @g(%arg0: i32) -> i32 {
    llvm.return %arg0 : i32
  }]

theorem inst_combine_g   : g_before  ⊑  g_combined := by
  unfold g_before g_combined
  simp_alive_peephole
  sorry
def h_combined := [llvmfunc|
  llvm.func @h(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.add %arg1, %0  : i32
    %3 = llvm.select %arg0, %1, %2 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_h   : h_before  ⊑  h_combined := by
  unfold h_before h_combined
  simp_alive_peephole
  sorry
def h1_combined := [llvmfunc|
  llvm.func @h1(%arg0: i1, %arg1: vector<4xi32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<1.401300e-45> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.bitcast %arg1 : vector<4xi32> to vector<4xf32>
    %2 = llvm.select %arg0, %0, %1 : i1, vector<4xf32>
    llvm.return %2 : vector<4xf32>
  }]

theorem inst_combine_h1   : h1_before  ⊑  h1_combined := by
  unfold h1_before h1_combined
  simp_alive_peephole
  sorry
def h2_combined := [llvmfunc|
  llvm.func @h2(%arg0: i1, %arg1: !llvm.vec<? x 4 x  i32>) -> !llvm.vec<? x 4 x  f32> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.undef : !llvm.vec<? x 4 x  f32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.insertelement %0, %1[%2 : i32] : !llvm.vec<? x 4 x  f32>
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.insertelement %0, %3[%4 : i32] : !llvm.vec<? x 4 x  f32>
    %6 = llvm.mlir.constant(2 : i32) : i32
    %7 = llvm.insertelement %0, %5[%6 : i32] : !llvm.vec<? x 4 x  f32>
    %8 = llvm.mlir.constant(3 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : !llvm.vec<? x 4 x  f32>
    %10 = llvm.bitcast %arg1 : !llvm.vec<? x 4 x  i32> to !llvm.vec<? x 4 x  f32>
    %11 = llvm.select %arg0, %9, %10 : i1, !llvm.vec<? x 4 x  f32>
    llvm.return %11 : !llvm.vec<? x 4 x  f32>
  }]

theorem inst_combine_h2   : h2_before  ⊑  h2_combined := by
  unfold h2_before h2_combined
  simp_alive_peephole
  sorry
def h3_combined := [llvmfunc|
  llvm.func @h3(%arg0: i1, %arg1: !llvm.vec<? x 4 x  i32>) -> !llvm.vec<? x 2 x  i64> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.undef : !llvm.vec<? x 4 x  i32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.insertelement %0, %1[%2 : i32] : !llvm.vec<? x 4 x  i32>
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.insertelement %0, %3[%4 : i32] : !llvm.vec<? x 4 x  i32>
    %6 = llvm.mlir.constant(2 : i32) : i32
    %7 = llvm.insertelement %0, %5[%6 : i32] : !llvm.vec<? x 4 x  i32>
    %8 = llvm.mlir.constant(3 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : !llvm.vec<? x 4 x  i32>
    %10 = llvm.select %arg0, %9, %arg1 : i1, !llvm.vec<? x 4 x  i32>
    %11 = llvm.bitcast %10 : !llvm.vec<? x 4 x  i32> to !llvm.vec<? x 2 x  i64>
    llvm.return %11 : !llvm.vec<? x 2 x  i64>
  }]

theorem inst_combine_h3   : h3_before  ⊑  h3_combined := by
  unfold h3_before h3_combined
  simp_alive_peephole
  sorry
