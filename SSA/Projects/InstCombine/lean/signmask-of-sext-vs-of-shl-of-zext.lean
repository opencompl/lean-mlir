import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  signmask-of-sext-vs-of-shl-of-zext
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t0_before := [llvmfunc|
  llvm.func @t0(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.zext %arg0 : i16 to i32
    %3 = llvm.shl %2, %0  : i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }]

def t1_before := [llvmfunc|
  llvm.func @t1(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.zext %arg0 : i8 to i32
    %3 = llvm.shl %2, %0  : i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }]

def n2_before := [llvmfunc|
  llvm.func @n2(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.zext %arg0 : i16 to i32
    %3 = llvm.shl %2, %0  : i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }]

def n3_before := [llvmfunc|
  llvm.func @n3(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(17 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.zext %arg0 : i16 to i32
    %3 = llvm.shl %2, %0  : i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }]

def n4_before := [llvmfunc|
  llvm.func @n4(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(-1073741824 : i32) : i32
    %2 = llvm.zext %arg0 : i16 to i32
    %3 = llvm.shl %2, %0  : i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }]

def t5_before := [llvmfunc|
  llvm.func @t5(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.zext %arg0 : i16 to i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.shl %2, %0  : i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }]

def n6_before := [llvmfunc|
  llvm.func @n6(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.zext %arg0 : i16 to i32
    %3 = llvm.shl %2, %0  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }]

def n7_before := [llvmfunc|
  llvm.func @n7(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.zext %arg0 : i16 to i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.shl %2, %0  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }]

def t8_before := [llvmfunc|
  llvm.func @t8(%arg0: vector<2xi16>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-2147483648> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.zext %arg0 : vector<2xi16> to vector<2xi32>
    %3 = llvm.shl %2, %0  : vector<2xi32>
    %4 = llvm.and %3, %1  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def t9_before := [llvmfunc|
  llvm.func @t9(%arg0: vector<2xi16>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(dense<-2147483648> : vector<2xi32>) : vector<2xi32>
    %8 = llvm.zext %arg0 : vector<2xi16> to vector<2xi32>
    %9 = llvm.shl %8, %6  : vector<2xi32>
    %10 = llvm.and %9, %7  : vector<2xi32>
    llvm.return %10 : vector<2xi32>
  }]

def t10_undef_before := [llvmfunc|
  llvm.func @t10_undef(%arg0: vector<2xi16>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.constant(-2147483648 : i32) : i32
    %3 = llvm.mlir.undef : vector<2xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi32>
    %8 = llvm.zext %arg0 : vector<2xi16> to vector<2xi32>
    %9 = llvm.shl %8, %0  : vector<2xi32>
    %10 = llvm.and %9, %7  : vector<2xi32>
    llvm.return %10 : vector<2xi32>
  }]

def t10_poison_before := [llvmfunc|
  llvm.func @t10_poison(%arg0: vector<2xi16>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.constant(-2147483648 : i32) : i32
    %3 = llvm.mlir.undef : vector<2xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi32>
    %8 = llvm.zext %arg0 : vector<2xi16> to vector<2xi32>
    %9 = llvm.shl %8, %0  : vector<2xi32>
    %10 = llvm.and %9, %7  : vector<2xi32>
    llvm.return %10 : vector<2xi32>
  }]

def t11_before := [llvmfunc|
  llvm.func @t11(%arg0: vector<2xi16>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(-2147483648 : i32) : i32
    %8 = llvm.mlir.undef : vector<2xi32>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %7, %8[%9 : i32] : vector<2xi32>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<2xi32>
    %13 = llvm.zext %arg0 : vector<2xi16> to vector<2xi32>
    %14 = llvm.shl %13, %6  : vector<2xi32>
    %15 = llvm.and %14, %12  : vector<2xi32>
    llvm.return %15 : vector<2xi32>
  }]

def t0_combined := [llvmfunc|
  llvm.func @t0(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.sext %arg0 : i16 to i32
    %2 = llvm.and %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_t0   : t0_before  ⊑  t0_combined := by
  unfold t0_before t0_combined
  simp_alive_peephole
  sorry
def t1_combined := [llvmfunc|
  llvm.func @t1(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.and %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_t1   : t1_before  ⊑  t1_combined := by
  unfold t1_before t1_combined
  simp_alive_peephole
  sorry
def n2_combined := [llvmfunc|
  llvm.func @n2(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_n2   : n2_before  ⊑  n2_combined := by
  unfold n2_before n2_combined
  simp_alive_peephole
  sorry
def n3_combined := [llvmfunc|
  llvm.func @n3(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(17 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.zext %arg0 : i16 to i32
    %3 = llvm.shl %2, %0  : i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_n3   : n3_before  ⊑  n3_combined := by
  unfold n3_before n3_combined
  simp_alive_peephole
  sorry
def n4_combined := [llvmfunc|
  llvm.func @n4(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(-1073741824 : i32) : i32
    %2 = llvm.zext %arg0 : i16 to i32
    %3 = llvm.shl %2, %0 overflow<nuw>  : i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_n4   : n4_before  ⊑  n4_combined := by
  unfold n4_before n4_combined
  simp_alive_peephole
  sorry
def t5_combined := [llvmfunc|
  llvm.func @t5(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.zext %arg0 : i16 to i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.sext %arg0 : i16 to i32
    %3 = llvm.and %2, %0  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_t5   : t5_before  ⊑  t5_combined := by
  unfold t5_before t5_combined
  simp_alive_peephole
  sorry
def n6_combined := [llvmfunc|
  llvm.func @n6(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.zext %arg0 : i16 to i32
    %3 = llvm.shl %2, %0 overflow<nuw>  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_n6   : n6_before  ⊑  n6_combined := by
  unfold n6_before n6_combined
  simp_alive_peephole
  sorry
def n7_combined := [llvmfunc|
  llvm.func @n7(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.zext %arg0 : i16 to i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.shl %2, %0 overflow<nuw>  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_n7   : n7_before  ⊑  n7_combined := by
  unfold n7_before n7_combined
  simp_alive_peephole
  sorry
def t8_combined := [llvmfunc|
  llvm.func @t8(%arg0: vector<2xi16>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-2147483648> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi16> to vector<2xi32>
    %2 = llvm.and %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_t8   : t8_before  ⊑  t8_combined := by
  unfold t8_before t8_combined
  simp_alive_peephole
  sorry
def t9_combined := [llvmfunc|
  llvm.func @t9(%arg0: vector<2xi16>) -> vector<2xi32> {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.sext %arg0 : vector<2xi16> to vector<2xi32>
    %8 = llvm.and %7, %6  : vector<2xi32>
    llvm.return %8 : vector<2xi32>
  }]

theorem inst_combine_t9   : t9_before  ⊑  t9_combined := by
  unfold t9_before t9_combined
  simp_alive_peephole
  sorry
def t10_undef_combined := [llvmfunc|
  llvm.func @t10_undef(%arg0: vector<2xi16>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[-2147483648, 0]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi16> to vector<2xi32>
    %2 = llvm.and %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_t10_undef   : t10_undef_before  ⊑  t10_undef_combined := by
  unfold t10_undef_before t10_undef_combined
  simp_alive_peephole
  sorry
def t10_poison_combined := [llvmfunc|
  llvm.func @t10_poison(%arg0: vector<2xi16>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[-2147483648, 0]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi16> to vector<2xi32>
    %2 = llvm.and %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_t10_poison   : t10_poison_before  ⊑  t10_poison_combined := by
  unfold t10_poison_before t10_poison_combined
  simp_alive_peephole
  sorry
def t11_combined := [llvmfunc|
  llvm.func @t11(%arg0: vector<2xi16>) -> vector<2xi32> {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.sext %arg0 : vector<2xi16> to vector<2xi32>
    %8 = llvm.and %7, %6  : vector<2xi32>
    llvm.return %8 : vector<2xi32>
  }]

theorem inst_combine_t11   : t11_before  ⊑  t11_combined := by
  unfold t11_before t11_combined
  simp_alive_peephole
  sorry
