import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  xor-and-or
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def xor_logic_and_logic_or1_before := [llvmfunc|
  llvm.func @xor_logic_and_logic_or1(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.select %arg0, %0, %arg2 : i1, i1
    %3 = llvm.select %arg0, %arg1, %1 : i1, i1
    %4 = llvm.xor %3, %2  : i1
    llvm.return %4 : i1
  }]

def xor_logic_and_logic_or2_before := [llvmfunc|
  llvm.func @xor_logic_and_logic_or2(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.select %arg2, %0, %arg0 : i1, i1
    %3 = llvm.select %arg0, %arg1, %1 : i1, i1
    %4 = llvm.xor %3, %2  : i1
    llvm.return %4 : i1
  }]

def xor_logic_and_logic_or3_before := [llvmfunc|
  llvm.func @xor_logic_and_logic_or3(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.select %arg2, %0, %arg0 : i1, i1
    %3 = llvm.select %arg1, %arg0, %1 : i1, i1
    %4 = llvm.xor %3, %2  : i1
    llvm.return %4 : i1
  }]

def xor_logic_and_logic_or4_before := [llvmfunc|
  llvm.func @xor_logic_and_logic_or4(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.select %arg0, %0, %arg2 : i1, i1
    %3 = llvm.select %arg1, %arg0, %1 : i1, i1
    %4 = llvm.xor %3, %2  : i1
    llvm.return %4 : i1
  }]

def xor_logic_and_logic_or_vector1_before := [llvmfunc|
  llvm.func @xor_logic_and_logic_or_vector1(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<3xi1>) : vector<3xi1>
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(dense<false> : vector<3xi1>) : vector<3xi1>
    %4 = llvm.select %arg0, %1, %arg2 : vector<3xi1>, vector<3xi1>
    %5 = llvm.select %arg0, %arg1, %3 : vector<3xi1>, vector<3xi1>
    %6 = llvm.xor %5, %4  : vector<3xi1>
    llvm.return %6 : vector<3xi1>
  }]

def xor_logic_and_logic_or_vector2_before := [llvmfunc|
  llvm.func @xor_logic_and_logic_or_vector2(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<3xi1>) : vector<3xi1>
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(dense<false> : vector<3xi1>) : vector<3xi1>
    %4 = llvm.select %arg2, %1, %arg0 : vector<3xi1>, vector<3xi1>
    %5 = llvm.select %arg1, %arg0, %3 : vector<3xi1>, vector<3xi1>
    %6 = llvm.xor %5, %4  : vector<3xi1>
    llvm.return %6 : vector<3xi1>
  }]

def xor_logic_and_logic_or_vector_poison1_before := [llvmfunc|
  llvm.func @xor_logic_and_logic_or_vector_poison1(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.poison : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.undef : vector<3xi1>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<3xi1>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi1>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi1>
    %9 = llvm.mlir.constant(false) : i1
    %10 = llvm.mlir.constant(dense<false> : vector<3xi1>) : vector<3xi1>
    %11 = llvm.select %arg0, %8, %arg2 : vector<3xi1>, vector<3xi1>
    %12 = llvm.select %arg0, %arg1, %10 : vector<3xi1>, vector<3xi1>
    %13 = llvm.xor %12, %11  : vector<3xi1>
    llvm.return %13 : vector<3xi1>
  }]

def xor_logic_and_logic_or_vector_poison2_before := [llvmfunc|
  llvm.func @xor_logic_and_logic_or_vector_poison2(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<3xi1>) : vector<3xi1>
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.poison : i1
    %4 = llvm.mlir.undef : vector<3xi1>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %2, %4[%5 : i32] : vector<3xi1>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %3, %6[%7 : i32] : vector<3xi1>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %2, %8[%9 : i32] : vector<3xi1>
    %11 = llvm.select %arg0, %1, %arg2 : vector<3xi1>, vector<3xi1>
    %12 = llvm.select %arg0, %arg1, %10 : vector<3xi1>, vector<3xi1>
    %13 = llvm.xor %12, %11  : vector<3xi1>
    llvm.return %13 : vector<3xi1>
  }]

def xor_and_logic_or1_before := [llvmfunc|
  llvm.func @xor_and_logic_or1(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg2 : i1, i1
    %2 = llvm.and %arg0, %arg1  : i1
    %3 = llvm.xor %2, %1  : i1
    llvm.return %3 : i1
  }]

def xor_and_logic_or2_before := [llvmfunc|
  llvm.func @xor_and_logic_or2(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg2, %0, %arg0 : i1, i1
    %2 = llvm.and %arg1, %arg0  : i1
    %3 = llvm.xor %2, %1  : i1
    llvm.return %3 : i1
  }]

def xor_and_logic_or_vector_before := [llvmfunc|
  llvm.func @xor_and_logic_or_vector(%arg0: vector<2xi1>, %arg1: vector<2xi1>, %arg2: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.select %arg0, %1, %arg2 : vector<2xi1>, vector<2xi1>
    %3 = llvm.and %arg0, %arg1  : vector<2xi1>
    %4 = llvm.xor %3, %2  : vector<2xi1>
    llvm.return %4 : vector<2xi1>
  }]

def xor_and_logic_or_vector_poison_before := [llvmfunc|
  llvm.func @xor_and_logic_or_vector_poison(%arg0: vector<2xi1>, %arg1: vector<2xi1>, %arg2: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.poison : i1
    %2 = llvm.mlir.undef : vector<2xi1>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi1>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi1>
    %7 = llvm.select %arg0, %6, %arg2 : vector<2xi1>, vector<2xi1>
    %8 = llvm.and %arg0, %arg1  : vector<2xi1>
    %9 = llvm.xor %8, %7  : vector<2xi1>
    llvm.return %9 : vector<2xi1>
  }]

def xor_logic_and_or1_before := [llvmfunc|
  llvm.func @xor_logic_and_or1(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.or %arg2, %arg0  : i1
    %2 = llvm.select %arg0, %arg1, %0 : i1, i1
    %3 = llvm.xor %2, %1  : i1
    llvm.return %3 : i1
  }]

def xor_logic_and_or2_before := [llvmfunc|
  llvm.func @xor_logic_and_or2(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.or %arg0, %arg2  : i1
    %2 = llvm.select %arg1, %arg0, %0 : i1, i1
    %3 = llvm.xor %2, %1  : i1
    llvm.return %3 : i1
  }]

def xor_logic_and_or_vector_before := [llvmfunc|
  llvm.func @xor_logic_and_or_vector(%arg0: vector<2xi1>, %arg1: vector<2xi1>, %arg2: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.or %arg2, %arg0  : vector<2xi1>
    %3 = llvm.select %arg0, %arg1, %1 : vector<2xi1>, vector<2xi1>
    %4 = llvm.xor %3, %2  : vector<2xi1>
    llvm.return %4 : vector<2xi1>
  }]

def xor_logic_and_or_vector_poison_before := [llvmfunc|
  llvm.func @xor_logic_and_or_vector_poison(%arg0: vector<2xi1>, %arg1: vector<2xi1>, %arg2: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.poison : i1
    %2 = llvm.mlir.undef : vector<2xi1>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi1>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi1>
    %7 = llvm.or %arg2, %arg0  : vector<2xi1>
    %8 = llvm.select %arg0, %arg1, %6 : vector<2xi1>, vector<2xi1>
    %9 = llvm.xor %8, %7  : vector<2xi1>
    llvm.return %9 : vector<2xi1>
  }]

def xor_and_or_before := [llvmfunc|
  llvm.func @xor_and_or(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.or %arg2, %arg0  : i1
    %1 = llvm.and %arg0, %arg1  : i1
    %2 = llvm.xor %1, %0  : i1
    llvm.return %2 : i1
  }]

def xor_and_or_vector_before := [llvmfunc|
  llvm.func @xor_and_or_vector(%arg0: vector<4xi1>, %arg1: vector<4xi1>, %arg2: vector<4xi1>) -> vector<4xi1> {
    %0 = llvm.or %arg2, %arg0  : vector<4xi1>
    %1 = llvm.and %arg0, %arg1  : vector<4xi1>
    %2 = llvm.xor %1, %0  : vector<4xi1>
    llvm.return %2 : vector<4xi1>
  }]

def xor_and_or_negative_oneuse_before := [llvmfunc|
  llvm.func @xor_and_or_negative_oneuse(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.or %arg2, %arg0  : i1
    %1 = llvm.and %arg0, %arg1  : i1
    %2 = llvm.xor %1, %0  : i1
    llvm.call @use(%0) : (i1) -> ()
    llvm.return %2 : i1
  }]

def xor_logic_and_logic_or1_combined := [llvmfunc|
  llvm.func @xor_logic_and_logic_or1(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg1, %0  : i1
    %2 = llvm.select %arg0, %1, %arg2 : i1, i1
    llvm.return %2 : i1
  }]

theorem inst_combine_xor_logic_and_logic_or1   : xor_logic_and_logic_or1_before  ⊑  xor_logic_and_logic_or1_combined := by
  unfold xor_logic_and_logic_or1_before xor_logic_and_logic_or1_combined
  simp_alive_peephole
  sorry
def xor_logic_and_logic_or2_combined := [llvmfunc|
  llvm.func @xor_logic_and_logic_or2(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg1, %0  : i1
    %2 = llvm.select %arg0, %1, %arg2 : i1, i1
    llvm.return %2 : i1
  }]

theorem inst_combine_xor_logic_and_logic_or2   : xor_logic_and_logic_or2_before  ⊑  xor_logic_and_logic_or2_combined := by
  unfold xor_logic_and_logic_or2_before xor_logic_and_logic_or2_combined
  simp_alive_peephole
  sorry
def xor_logic_and_logic_or3_combined := [llvmfunc|
  llvm.func @xor_logic_and_logic_or3(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.freeze %arg0 : i1
    %2 = llvm.xor %arg1, %0  : i1
    %3 = llvm.select %1, %2, %arg2 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_xor_logic_and_logic_or3   : xor_logic_and_logic_or3_before  ⊑  xor_logic_and_logic_or3_combined := by
  unfold xor_logic_and_logic_or3_before xor_logic_and_logic_or3_combined
  simp_alive_peephole
  sorry
def xor_logic_and_logic_or4_combined := [llvmfunc|
  llvm.func @xor_logic_and_logic_or4(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg1, %0  : i1
    %2 = llvm.select %arg0, %1, %arg2 : i1, i1
    llvm.return %2 : i1
  }]

theorem inst_combine_xor_logic_and_logic_or4   : xor_logic_and_logic_or4_before  ⊑  xor_logic_and_logic_or4_combined := by
  unfold xor_logic_and_logic_or4_before xor_logic_and_logic_or4_combined
  simp_alive_peephole
  sorry
def xor_logic_and_logic_or_vector1_combined := [llvmfunc|
  llvm.func @xor_logic_and_logic_or_vector1(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<3xi1>) : vector<3xi1>
    %2 = llvm.xor %arg1, %1  : vector<3xi1>
    %3 = llvm.select %arg0, %2, %arg2 : vector<3xi1>, vector<3xi1>
    llvm.return %3 : vector<3xi1>
  }]

theorem inst_combine_xor_logic_and_logic_or_vector1   : xor_logic_and_logic_or_vector1_before  ⊑  xor_logic_and_logic_or_vector1_combined := by
  unfold xor_logic_and_logic_or_vector1_before xor_logic_and_logic_or_vector1_combined
  simp_alive_peephole
  sorry
def xor_logic_and_logic_or_vector2_combined := [llvmfunc|
  llvm.func @xor_logic_and_logic_or_vector2(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<3xi1>) : vector<3xi1>
    %2 = llvm.freeze %arg0 : vector<3xi1>
    %3 = llvm.xor %arg1, %1  : vector<3xi1>
    %4 = llvm.select %2, %3, %arg2 : vector<3xi1>, vector<3xi1>
    llvm.return %4 : vector<3xi1>
  }]

theorem inst_combine_xor_logic_and_logic_or_vector2   : xor_logic_and_logic_or_vector2_before  ⊑  xor_logic_and_logic_or_vector2_combined := by
  unfold xor_logic_and_logic_or_vector2_before xor_logic_and_logic_or_vector2_combined
  simp_alive_peephole
  sorry
def xor_logic_and_logic_or_vector_poison1_combined := [llvmfunc|
  llvm.func @xor_logic_and_logic_or_vector_poison1(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.poison : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.undef : vector<3xi1>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<3xi1>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi1>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi1>
    %9 = llvm.xor %arg1, %8  : vector<3xi1>
    %10 = llvm.select %arg0, %9, %arg2 : vector<3xi1>, vector<3xi1>
    llvm.return %10 : vector<3xi1>
  }]

theorem inst_combine_xor_logic_and_logic_or_vector_poison1   : xor_logic_and_logic_or_vector_poison1_before  ⊑  xor_logic_and_logic_or_vector_poison1_combined := by
  unfold xor_logic_and_logic_or_vector_poison1_before xor_logic_and_logic_or_vector_poison1_combined
  simp_alive_peephole
  sorry
def xor_logic_and_logic_or_vector_poison2_combined := [llvmfunc|
  llvm.func @xor_logic_and_logic_or_vector_poison2(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<3xi1>) : vector<3xi1>
    %2 = llvm.xor %arg1, %1  : vector<3xi1>
    %3 = llvm.select %arg0, %2, %arg2 : vector<3xi1>, vector<3xi1>
    llvm.return %3 : vector<3xi1>
  }]

theorem inst_combine_xor_logic_and_logic_or_vector_poison2   : xor_logic_and_logic_or_vector_poison2_before  ⊑  xor_logic_and_logic_or_vector_poison2_combined := by
  unfold xor_logic_and_logic_or_vector_poison2_before xor_logic_and_logic_or_vector_poison2_combined
  simp_alive_peephole
  sorry
def xor_and_logic_or1_combined := [llvmfunc|
  llvm.func @xor_and_logic_or1(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg1, %0  : i1
    %2 = llvm.select %arg0, %1, %arg2 : i1, i1
    llvm.return %2 : i1
  }]

theorem inst_combine_xor_and_logic_or1   : xor_and_logic_or1_before  ⊑  xor_and_logic_or1_combined := by
  unfold xor_and_logic_or1_before xor_and_logic_or1_combined
  simp_alive_peephole
  sorry
def xor_and_logic_or2_combined := [llvmfunc|
  llvm.func @xor_and_logic_or2(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg1, %0  : i1
    %2 = llvm.select %arg0, %1, %arg2 : i1, i1
    llvm.return %2 : i1
  }]

theorem inst_combine_xor_and_logic_or2   : xor_and_logic_or2_before  ⊑  xor_and_logic_or2_combined := by
  unfold xor_and_logic_or2_before xor_and_logic_or2_combined
  simp_alive_peephole
  sorry
def xor_and_logic_or_vector_combined := [llvmfunc|
  llvm.func @xor_and_logic_or_vector(%arg0: vector<2xi1>, %arg1: vector<2xi1>, %arg2: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.xor %arg1, %1  : vector<2xi1>
    %3 = llvm.select %arg0, %2, %arg2 : vector<2xi1>, vector<2xi1>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_xor_and_logic_or_vector   : xor_and_logic_or_vector_before  ⊑  xor_and_logic_or_vector_combined := by
  unfold xor_and_logic_or_vector_before xor_and_logic_or_vector_combined
  simp_alive_peephole
  sorry
def xor_and_logic_or_vector_poison_combined := [llvmfunc|
  llvm.func @xor_and_logic_or_vector_poison(%arg0: vector<2xi1>, %arg1: vector<2xi1>, %arg2: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.poison : i1
    %2 = llvm.mlir.undef : vector<2xi1>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi1>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi1>
    %7 = llvm.select %arg0, %6, %arg2 : vector<2xi1>, vector<2xi1>
    %8 = llvm.and %arg0, %arg1  : vector<2xi1>
    %9 = llvm.xor %8, %7  : vector<2xi1>
    llvm.return %9 : vector<2xi1>
  }]

theorem inst_combine_xor_and_logic_or_vector_poison   : xor_and_logic_or_vector_poison_before  ⊑  xor_and_logic_or_vector_poison_combined := by
  unfold xor_and_logic_or_vector_poison_before xor_and_logic_or_vector_poison_combined
  simp_alive_peephole
  sorry
def xor_logic_and_or1_combined := [llvmfunc|
  llvm.func @xor_logic_and_or1(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg1, %0  : i1
    %2 = llvm.select %arg0, %1, %arg2 : i1, i1
    llvm.return %2 : i1
  }]

theorem inst_combine_xor_logic_and_or1   : xor_logic_and_or1_before  ⊑  xor_logic_and_or1_combined := by
  unfold xor_logic_and_or1_before xor_logic_and_or1_combined
  simp_alive_peephole
  sorry
def xor_logic_and_or2_combined := [llvmfunc|
  llvm.func @xor_logic_and_or2(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg1, %0  : i1
    %2 = llvm.select %arg0, %1, %arg2 : i1, i1
    llvm.return %2 : i1
  }]

theorem inst_combine_xor_logic_and_or2   : xor_logic_and_or2_before  ⊑  xor_logic_and_or2_combined := by
  unfold xor_logic_and_or2_before xor_logic_and_or2_combined
  simp_alive_peephole
  sorry
def xor_logic_and_or_vector_combined := [llvmfunc|
  llvm.func @xor_logic_and_or_vector(%arg0: vector<2xi1>, %arg1: vector<2xi1>, %arg2: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.xor %arg1, %1  : vector<2xi1>
    %3 = llvm.select %arg0, %2, %arg2 : vector<2xi1>, vector<2xi1>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_xor_logic_and_or_vector   : xor_logic_and_or_vector_before  ⊑  xor_logic_and_or_vector_combined := by
  unfold xor_logic_and_or_vector_before xor_logic_and_or_vector_combined
  simp_alive_peephole
  sorry
def xor_logic_and_or_vector_poison_combined := [llvmfunc|
  llvm.func @xor_logic_and_or_vector_poison(%arg0: vector<2xi1>, %arg1: vector<2xi1>, %arg2: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.poison : i1
    %2 = llvm.mlir.undef : vector<2xi1>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi1>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi1>
    %7 = llvm.or %arg2, %arg0  : vector<2xi1>
    %8 = llvm.select %arg0, %arg1, %6 : vector<2xi1>, vector<2xi1>
    %9 = llvm.xor %8, %7  : vector<2xi1>
    llvm.return %9 : vector<2xi1>
  }]

theorem inst_combine_xor_logic_and_or_vector_poison   : xor_logic_and_or_vector_poison_before  ⊑  xor_logic_and_or_vector_poison_combined := by
  unfold xor_logic_and_or_vector_poison_before xor_logic_and_or_vector_poison_combined
  simp_alive_peephole
  sorry
def xor_and_or_combined := [llvmfunc|
  llvm.func @xor_and_or(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg1, %0  : i1
    %2 = llvm.select %arg0, %1, %arg2 : i1, i1
    llvm.return %2 : i1
  }]

theorem inst_combine_xor_and_or   : xor_and_or_before  ⊑  xor_and_or_combined := by
  unfold xor_and_or_before xor_and_or_combined
  simp_alive_peephole
  sorry
def xor_and_or_vector_combined := [llvmfunc|
  llvm.func @xor_and_or_vector(%arg0: vector<4xi1>, %arg1: vector<4xi1>, %arg2: vector<4xi1>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<4xi1>) : vector<4xi1>
    %2 = llvm.xor %arg1, %1  : vector<4xi1>
    %3 = llvm.select %arg0, %2, %arg2 : vector<4xi1>, vector<4xi1>
    llvm.return %3 : vector<4xi1>
  }]

theorem inst_combine_xor_and_or_vector   : xor_and_or_vector_before  ⊑  xor_and_or_vector_combined := by
  unfold xor_and_or_vector_before xor_and_or_vector_combined
  simp_alive_peephole
  sorry
def xor_and_or_negative_oneuse_combined := [llvmfunc|
  llvm.func @xor_and_or_negative_oneuse(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.or %arg2, %arg0  : i1
    %1 = llvm.and %arg0, %arg1  : i1
    %2 = llvm.xor %1, %0  : i1
    llvm.call @use(%0) : (i1) -> ()
    llvm.return %2 : i1
  }]

theorem inst_combine_xor_and_or_negative_oneuse   : xor_and_or_negative_oneuse_before  ⊑  xor_and_or_negative_oneuse_combined := by
  unfold xor_and_or_negative_oneuse_before xor_and_or_negative_oneuse_combined
  simp_alive_peephole
  sorry
