import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  xor-of-or
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t0_before := [llvmfunc|
  llvm.func @t0(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.or %arg0, %arg1  : i4
    %1 = llvm.xor %0, %arg2  : i4
    llvm.return %1 : i4
  }]

def t1_before := [llvmfunc|
  llvm.func @t1(%arg0: i4) -> i4 {
    %0 = llvm.mlir.constant(-4 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.or %arg0, %0  : i4
    %3 = llvm.xor %2, %1  : i4
    llvm.return %3 : i4
  }]

def t2_before := [llvmfunc|
  llvm.func @t2(%arg0: i4) -> i4 {
    %0 = llvm.mlir.constant(-4 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.or %arg0, %0  : i4
    llvm.call @use(%2) : (i4) -> ()
    %3 = llvm.xor %2, %1  : i4
    llvm.return %3 : i4
  }]

def t3_before := [llvmfunc|
  llvm.func @t3(%arg0: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-4 : i4) : i4
    %1 = llvm.mlir.constant(dense<-4> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.mlir.constant(-6 : i4) : i4
    %3 = llvm.mlir.constant(dense<-6> : vector<2xi4>) : vector<2xi4>
    %4 = llvm.or %arg0, %1  : vector<2xi4>
    %5 = llvm.xor %4, %3  : vector<2xi4>
    llvm.return %5 : vector<2xi4>
  }]

def t4_before := [llvmfunc|
  llvm.func @t4(%arg0: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-6 : i4) : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.mlir.constant(dense<[-4, -6]> : vector<2xi4>) : vector<2xi4>
    %3 = llvm.mlir.constant(dense<[-6, -4]> : vector<2xi4>) : vector<2xi4>
    %4 = llvm.or %arg0, %2  : vector<2xi4>
    %5 = llvm.xor %4, %3  : vector<2xi4>
    llvm.return %5 : vector<2xi4>
  }]

def t5_before := [llvmfunc|
  llvm.func @t5(%arg0: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-4 : i4) : i4
    %1 = llvm.mlir.constant(dense<-4> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.mlir.undef : i4
    %3 = llvm.mlir.constant(-6 : i4) : i4
    %4 = llvm.mlir.undef : vector<2xi4>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi4>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi4>
    %9 = llvm.or %arg0, %1  : vector<2xi4>
    %10 = llvm.xor %9, %8  : vector<2xi4>
    llvm.return %10 : vector<2xi4>
  }]

def t6_before := [llvmfunc|
  llvm.func @t6(%arg0: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.undef : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.mlir.undef : vector<2xi4>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi4>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi4>
    %7 = llvm.mlir.constant(-6 : i4) : i4
    %8 = llvm.mlir.constant(dense<-6> : vector<2xi4>) : vector<2xi4>
    %9 = llvm.or %arg0, %6  : vector<2xi4>
    %10 = llvm.xor %9, %8  : vector<2xi4>
    llvm.return %10 : vector<2xi4>
  }]

def t7_before := [llvmfunc|
  llvm.func @t7(%arg0: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.undef : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.mlir.undef : vector<2xi4>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi4>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi4>
    %7 = llvm.mlir.constant(-6 : i4) : i4
    %8 = llvm.mlir.undef : vector<2xi4>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %7, %8[%9 : i32] : vector<2xi4>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<2xi4>
    %13 = llvm.or %arg0, %6  : vector<2xi4>
    %14 = llvm.xor %13, %12  : vector<2xi4>
    llvm.return %14 : vector<2xi4>
  }]

def t8_before := [llvmfunc|
  llvm.func @t8(%arg0: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-4 : i4) : i4
    %1 = llvm.mlir.constant(dense<-4> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.mlir.poison : i4
    %3 = llvm.mlir.constant(-6 : i4) : i4
    %4 = llvm.mlir.undef : vector<2xi4>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi4>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi4>
    %9 = llvm.or %arg0, %1  : vector<2xi4>
    %10 = llvm.xor %9, %8  : vector<2xi4>
    llvm.return %10 : vector<2xi4>
  }]

def t9_before := [llvmfunc|
  llvm.func @t9(%arg0: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.poison : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.mlir.undef : vector<2xi4>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi4>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi4>
    %7 = llvm.mlir.constant(-6 : i4) : i4
    %8 = llvm.mlir.constant(dense<-6> : vector<2xi4>) : vector<2xi4>
    %9 = llvm.or %arg0, %6  : vector<2xi4>
    %10 = llvm.xor %9, %8  : vector<2xi4>
    llvm.return %10 : vector<2xi4>
  }]

def t10_before := [llvmfunc|
  llvm.func @t10(%arg0: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.poison : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.mlir.undef : vector<2xi4>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi4>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi4>
    %7 = llvm.mlir.constant(-6 : i4) : i4
    %8 = llvm.mlir.undef : vector<2xi4>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %7, %8[%9 : i32] : vector<2xi4>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<2xi4>
    %13 = llvm.or %arg0, %6  : vector<2xi4>
    %14 = llvm.xor %13, %12  : vector<2xi4>
    llvm.return %14 : vector<2xi4>
  }]

def t11_before := [llvmfunc|
  llvm.func @t11(%arg0: i4) -> i4 {
    %0 = llvm.mlir.constant(-4 : i4) : i4
    %1 = llvm.mlir.addressof @G2 : !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i4
    %3 = llvm.or %arg0, %0  : i4
    %4 = llvm.xor %3, %2  : i4
    llvm.return %4 : i4
  }]

def t12_before := [llvmfunc|
  llvm.func @t12(%arg0: i4) -> i4 {
    %0 = llvm.mlir.addressof @G : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i4
    %2 = llvm.mlir.constant(-6 : i4) : i4
    %3 = llvm.or %arg0, %1  : i4
    %4 = llvm.xor %3, %2  : i4
    llvm.return %4 : i4
  }]

def t13_before := [llvmfunc|
  llvm.func @t13(%arg0: i4) -> i4 {
    %0 = llvm.mlir.addressof @G : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i4
    %2 = llvm.mlir.addressof @G2 : !llvm.ptr
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i4
    %4 = llvm.or %arg0, %1  : i4
    %5 = llvm.xor %4, %3  : i4
    llvm.return %5 : i4
  }]

def t0_combined := [llvmfunc|
  llvm.func @t0(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.or %arg0, %arg1  : i4
    %1 = llvm.xor %0, %arg2  : i4
    llvm.return %1 : i4
  }]

theorem inst_combine_t0   : t0_before  ⊑  t0_combined := by
  unfold t0_before t0_combined
  simp_alive_peephole
  sorry
def t1_combined := [llvmfunc|
  llvm.func @t1(%arg0: i4) -> i4 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.and %arg0, %0  : i4
    %3 = llvm.xor %2, %1  : i4
    llvm.return %3 : i4
  }]

theorem inst_combine_t1   : t1_before  ⊑  t1_combined := by
  unfold t1_before t1_combined
  simp_alive_peephole
  sorry
def t2_combined := [llvmfunc|
  llvm.func @t2(%arg0: i4) -> i4 {
    %0 = llvm.mlir.constant(-4 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.or %arg0, %0  : i4
    llvm.call @use(%2) : (i4) -> ()
    %3 = llvm.xor %2, %1  : i4
    llvm.return %3 : i4
  }]

theorem inst_combine_t2   : t2_before  ⊑  t2_combined := by
  unfold t2_before t2_combined
  simp_alive_peephole
  sorry
def t3_combined := [llvmfunc|
  llvm.func @t3(%arg0: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(dense<3> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.mlir.constant(6 : i4) : i4
    %3 = llvm.mlir.constant(dense<6> : vector<2xi4>) : vector<2xi4>
    %4 = llvm.and %arg0, %1  : vector<2xi4>
    %5 = llvm.xor %4, %3  : vector<2xi4>
    llvm.return %5 : vector<2xi4>
  }]

theorem inst_combine_t3   : t3_before  ⊑  t3_combined := by
  unfold t3_before t3_combined
  simp_alive_peephole
  sorry
def t4_combined := [llvmfunc|
  llvm.func @t4(%arg0: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(5 : i4) : i4
    %1 = llvm.mlir.constant(3 : i4) : i4
    %2 = llvm.mlir.constant(dense<[3, 5]> : vector<2xi4>) : vector<2xi4>
    %3 = llvm.mlir.constant(6 : i4) : i4
    %4 = llvm.mlir.constant(dense<6> : vector<2xi4>) : vector<2xi4>
    %5 = llvm.and %arg0, %2  : vector<2xi4>
    %6 = llvm.xor %5, %4  : vector<2xi4>
    llvm.return %6 : vector<2xi4>
  }]

theorem inst_combine_t4   : t4_before  ⊑  t4_combined := by
  unfold t4_before t4_combined
  simp_alive_peephole
  sorry
def t5_combined := [llvmfunc|
  llvm.func @t5(%arg0: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.undef : i4
    %1 = llvm.mlir.constant(3 : i4) : i4
    %2 = llvm.mlir.undef : vector<2xi4>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi4>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi4>
    %7 = llvm.mlir.constant(6 : i4) : i4
    %8 = llvm.mlir.undef : vector<2xi4>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %7, %8[%9 : i32] : vector<2xi4>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<2xi4>
    %13 = llvm.and %arg0, %6  : vector<2xi4>
    %14 = llvm.xor %13, %12  : vector<2xi4>
    llvm.return %14 : vector<2xi4>
  }]

theorem inst_combine_t5   : t5_before  ⊑  t5_combined := by
  unfold t5_before t5_combined
  simp_alive_peephole
  sorry
def t6_combined := [llvmfunc|
  llvm.func @t6(%arg0: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.mlir.constant(3 : i4) : i4
    %2 = llvm.mlir.constant(dense<[3, 0]> : vector<2xi4>) : vector<2xi4>
    %3 = llvm.mlir.constant(5 : i4) : i4
    %4 = llvm.mlir.constant(6 : i4) : i4
    %5 = llvm.mlir.constant(dense<[6, 5]> : vector<2xi4>) : vector<2xi4>
    %6 = llvm.and %arg0, %2  : vector<2xi4>
    %7 = llvm.xor %6, %5  : vector<2xi4>
    llvm.return %7 : vector<2xi4>
  }]

theorem inst_combine_t6   : t6_before  ⊑  t6_combined := by
  unfold t6_before t6_combined
  simp_alive_peephole
  sorry
def t7_combined := [llvmfunc|
  llvm.func @t7(%arg0: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.undef : i4
    %1 = llvm.mlir.constant(3 : i4) : i4
    %2 = llvm.mlir.undef : vector<2xi4>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi4>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi4>
    %7 = llvm.mlir.constant(6 : i4) : i4
    %8 = llvm.mlir.undef : vector<2xi4>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %7, %8[%9 : i32] : vector<2xi4>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<2xi4>
    %13 = llvm.and %arg0, %6  : vector<2xi4>
    %14 = llvm.xor %13, %12  : vector<2xi4>
    llvm.return %14 : vector<2xi4>
  }]

theorem inst_combine_t7   : t7_before  ⊑  t7_combined := by
  unfold t7_before t7_combined
  simp_alive_peephole
  sorry
def t8_combined := [llvmfunc|
  llvm.func @t8(%arg0: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.undef : i4
    %1 = llvm.mlir.constant(3 : i4) : i4
    %2 = llvm.mlir.undef : vector<2xi4>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi4>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi4>
    %7 = llvm.mlir.poison : i4
    %8 = llvm.mlir.constant(6 : i4) : i4
    %9 = llvm.mlir.undef : vector<2xi4>
    %10 = llvm.mlir.constant(0 : i32) : i32
    %11 = llvm.insertelement %8, %9[%10 : i32] : vector<2xi4>
    %12 = llvm.mlir.constant(1 : i32) : i32
    %13 = llvm.insertelement %7, %11[%12 : i32] : vector<2xi4>
    %14 = llvm.and %arg0, %6  : vector<2xi4>
    %15 = llvm.xor %14, %13  : vector<2xi4>
    llvm.return %15 : vector<2xi4>
  }]

theorem inst_combine_t8   : t8_before  ⊑  t8_combined := by
  unfold t8_before t8_combined
  simp_alive_peephole
  sorry
def t9_combined := [llvmfunc|
  llvm.func @t9(%arg0: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.mlir.constant(3 : i4) : i4
    %2 = llvm.mlir.constant(dense<[3, 0]> : vector<2xi4>) : vector<2xi4>
    %3 = llvm.mlir.constant(5 : i4) : i4
    %4 = llvm.mlir.constant(6 : i4) : i4
    %5 = llvm.mlir.constant(dense<[6, 5]> : vector<2xi4>) : vector<2xi4>
    %6 = llvm.and %arg0, %2  : vector<2xi4>
    %7 = llvm.xor %6, %5  : vector<2xi4>
    llvm.return %7 : vector<2xi4>
  }]

theorem inst_combine_t9   : t9_before  ⊑  t9_combined := by
  unfold t9_before t9_combined
  simp_alive_peephole
  sorry
def t10_combined := [llvmfunc|
  llvm.func @t10(%arg0: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.undef : i4
    %1 = llvm.mlir.constant(3 : i4) : i4
    %2 = llvm.mlir.undef : vector<2xi4>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi4>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi4>
    %7 = llvm.mlir.poison : i4
    %8 = llvm.mlir.constant(6 : i4) : i4
    %9 = llvm.mlir.undef : vector<2xi4>
    %10 = llvm.mlir.constant(0 : i32) : i32
    %11 = llvm.insertelement %8, %9[%10 : i32] : vector<2xi4>
    %12 = llvm.mlir.constant(1 : i32) : i32
    %13 = llvm.insertelement %7, %11[%12 : i32] : vector<2xi4>
    %14 = llvm.and %arg0, %6  : vector<2xi4>
    %15 = llvm.xor %14, %13  : vector<2xi4>
    llvm.return %15 : vector<2xi4>
  }]

theorem inst_combine_t10   : t10_before  ⊑  t10_combined := by
  unfold t10_before t10_combined
  simp_alive_peephole
  sorry
def t11_combined := [llvmfunc|
  llvm.func @t11(%arg0: i4) -> i4 {
    %0 = llvm.mlir.constant(-4 : i4) : i4
    %1 = llvm.mlir.addressof @G2 : !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i4
    %3 = llvm.or %arg0, %0  : i4
    %4 = llvm.xor %3, %2  : i4
    llvm.return %4 : i4
  }]

theorem inst_combine_t11   : t11_before  ⊑  t11_combined := by
  unfold t11_before t11_combined
  simp_alive_peephole
  sorry
def t12_combined := [llvmfunc|
  llvm.func @t12(%arg0: i4) -> i4 {
    %0 = llvm.mlir.addressof @G : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i4
    %2 = llvm.mlir.constant(-6 : i4) : i4
    %3 = llvm.or %arg0, %1  : i4
    %4 = llvm.xor %3, %2  : i4
    llvm.return %4 : i4
  }]

theorem inst_combine_t12   : t12_before  ⊑  t12_combined := by
  unfold t12_before t12_combined
  simp_alive_peephole
  sorry
def t13_combined := [llvmfunc|
  llvm.func @t13(%arg0: i4) -> i4 {
    %0 = llvm.mlir.addressof @G : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i4
    %2 = llvm.mlir.addressof @G2 : !llvm.ptr
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i4
    %4 = llvm.or %arg0, %1  : i4
    %5 = llvm.xor %4, %3  : i4
    llvm.return %5 : i4
  }]

theorem inst_combine_t13   : t13_before  ⊑  t13_combined := by
  unfold t13_before t13_combined
  simp_alive_peephole
  sorry
