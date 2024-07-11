import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  adjust-for-minmax
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def smax1_before := [llvmfunc|
  llvm.func @smax1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    %2 = llvm.select %1, %arg0, %0 : i1, i32
    llvm.return %2 : i32
  }]

def smin1_before := [llvmfunc|
  llvm.func @smin1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    %2 = llvm.select %1, %arg0, %0 : i1, i32
    llvm.return %2 : i32
  }]

def smax2_before := [llvmfunc|
  llvm.func @smax2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "sge" %arg0, %0 : i32
    %3 = llvm.select %2, %arg0, %1 : i1, i32
    llvm.return %3 : i32
  }]

def smin2_before := [llvmfunc|
  llvm.func @smin2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "sle" %arg0, %0 : i32
    %3 = llvm.select %2, %arg0, %1 : i1, i32
    llvm.return %3 : i32
  }]

def smax3_before := [llvmfunc|
  llvm.func @smax3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg0, %1 : i1, i32
    llvm.return %3 : i32
  }]

def smax3_vec_before := [llvmfunc|
  llvm.func @smax3_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.icmp "sgt" %arg0, %0 : vector<2xi32>
    %4 = llvm.select %3, %arg0, %2 : vector<2xi1>, vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def smin3_before := [llvmfunc|
  llvm.func @smin3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg0, %1 : i1, i32
    llvm.return %3 : i32
  }]

def smin3_vec_before := [llvmfunc|
  llvm.func @smin3_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.icmp "slt" %arg0, %0 : vector<2xi32>
    %4 = llvm.select %3, %arg0, %2 : vector<2xi1>, vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def umax3_before := [llvmfunc|
  llvm.func @umax3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.icmp "ugt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg0, %1 : i1, i32
    llvm.return %3 : i32
  }]

def umax3_vec_before := [llvmfunc|
  llvm.func @umax3_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<5> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "ugt" %arg0, %0 : vector<2xi32>
    %3 = llvm.select %2, %arg0, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def umin3_before := [llvmfunc|
  llvm.func @umin3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.select %2, %arg0, %1 : i1, i32
    llvm.return %3 : i32
  }]

def umin3_vec_before := [llvmfunc|
  llvm.func @umin3_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<6> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "ult" %arg0, %0 : vector<2xi32>
    %3 = llvm.select %2, %arg0, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def smax4_before := [llvmfunc|
  llvm.func @smax4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sge" %arg0, %0 : i32
    %2 = llvm.select %1, %arg0, %0 : i1, i32
    llvm.return %2 : i32
  }]

def smax4_vec_before := [llvmfunc|
  llvm.func @smax4_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "sge" %arg0, %1 : vector<2xi32>
    %3 = llvm.select %2, %arg0, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def smin4_before := [llvmfunc|
  llvm.func @smin4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sle" %arg0, %0 : i32
    %2 = llvm.select %1, %arg0, %0 : i1, i32
    llvm.return %2 : i32
  }]

def smin4_vec_before := [llvmfunc|
  llvm.func @smin4_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "sle" %arg0, %1 : vector<2xi32>
    %3 = llvm.select %2, %arg0, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def umax4_before := [llvmfunc|
  llvm.func @umax4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.icmp "uge" %arg0, %0 : i32
    %2 = llvm.select %1, %arg0, %0 : i1, i32
    llvm.return %2 : i32
  }]

def umax4_vec_before := [llvmfunc|
  llvm.func @umax4_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "uge" %arg0, %0 : vector<2xi32>
    %2 = llvm.select %1, %arg0, %0 : vector<2xi1>, vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def umin4_before := [llvmfunc|
  llvm.func @umin4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.icmp "ule" %arg0, %0 : i32
    %2 = llvm.select %1, %arg0, %0 : i1, i32
    llvm.return %2 : i32
  }]

def umin4_vec_before := [llvmfunc|
  llvm.func @umin4_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<9> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "ule" %arg0, %0 : vector<2xi32>
    %2 = llvm.select %1, %arg0, %0 : vector<2xi1>, vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def smax_sext_before := [llvmfunc|
  llvm.func @smax_sext(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.select %3, %2, %1 : i1, i64
    llvm.return %4 : i64
  }]

def smax_sext_vec_before := [llvmfunc|
  llvm.func @smax_sext_vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.sext %arg0 : vector<2xi32> to vector<2xi64>
    %4 = llvm.icmp "sgt" %arg0, %0 : vector<2xi32>
    %5 = llvm.select %4, %3, %2 : vector<2xi1>, vector<2xi64>
    llvm.return %5 : vector<2xi64>
  }]

def smin_sext_before := [llvmfunc|
  llvm.func @smin_sext(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.select %3, %2, %1 : i1, i64
    llvm.return %4 : i64
  }]

def smin_sext_vec_before := [llvmfunc|
  llvm.func @smin_sext_vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.sext %arg0 : vector<2xi32> to vector<2xi64>
    %4 = llvm.icmp "slt" %arg0, %0 : vector<2xi32>
    %5 = llvm.select %4, %3, %2 : vector<2xi1>, vector<2xi64>
    llvm.return %5 : vector<2xi64>
  }]

def umax_sext_before := [llvmfunc|
  llvm.func @umax_sext(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.icmp "ugt" %arg0, %0 : i32
    %4 = llvm.select %3, %2, %1 : i1, i64
    llvm.return %4 : i64
  }]

def umax_sext_vec_before := [llvmfunc|
  llvm.func @umax_sext_vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<3> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.sext %arg0 : vector<2xi32> to vector<2xi64>
    %3 = llvm.icmp "ugt" %arg0, %0 : vector<2xi32>
    %4 = llvm.select %3, %2, %1 : vector<2xi1>, vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

def umin_sext_before := [llvmfunc|
  llvm.func @umin_sext(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.icmp "ult" %arg0, %0 : i32
    %4 = llvm.select %3, %2, %1 : i1, i64
    llvm.return %4 : i64
  }]

def umin_sext_vec_before := [llvmfunc|
  llvm.func @umin_sext_vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.sext %arg0 : vector<2xi32> to vector<2xi64>
    %3 = llvm.icmp "ult" %arg0, %0 : vector<2xi32>
    %4 = llvm.select %3, %2, %1 : vector<2xi1>, vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

def umax_sext2_before := [llvmfunc|
  llvm.func @umax_sext2(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.icmp "ult" %arg0, %0 : i32
    %4 = llvm.select %3, %1, %2 : i1, i64
    llvm.return %4 : i64
  }]

def umax_sext2_vec_before := [llvmfunc|
  llvm.func @umax_sext2_vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.sext %arg0 : vector<2xi32> to vector<2xi64>
    %3 = llvm.icmp "ult" %arg0, %0 : vector<2xi32>
    %4 = llvm.select %3, %1, %2 : vector<2xi1>, vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

def umin_sext2_before := [llvmfunc|
  llvm.func @umin_sext2(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.icmp "ugt" %arg0, %0 : i32
    %4 = llvm.select %3, %1, %2 : i1, i64
    llvm.return %4 : i64
  }]

def umin_sext2_vec_before := [llvmfunc|
  llvm.func @umin_sext2_vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<3> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.sext %arg0 : vector<2xi32> to vector<2xi64>
    %3 = llvm.icmp "ugt" %arg0, %0 : vector<2xi32>
    %4 = llvm.select %3, %1, %2 : vector<2xi1>, vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

def umax_zext_before := [llvmfunc|
  llvm.func @umax_zext(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.zext %arg0 : i32 to i64
    %3 = llvm.icmp "ugt" %arg0, %0 : i32
    %4 = llvm.select %3, %2, %1 : i1, i64
    llvm.return %4 : i64
  }]

def umax_zext_vec_before := [llvmfunc|
  llvm.func @umax_zext_vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<3> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.zext %arg0 : vector<2xi32> to vector<2xi64>
    %3 = llvm.icmp "ugt" %arg0, %0 : vector<2xi32>
    %4 = llvm.select %3, %2, %1 : vector<2xi1>, vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

def umin_zext_before := [llvmfunc|
  llvm.func @umin_zext(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.zext %arg0 : i32 to i64
    %3 = llvm.icmp "ult" %arg0, %0 : i32
    %4 = llvm.select %3, %2, %1 : i1, i64
    llvm.return %4 : i64
  }]

def umin_zext_vec_before := [llvmfunc|
  llvm.func @umin_zext_vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.zext %arg0 : vector<2xi32> to vector<2xi64>
    %3 = llvm.icmp "ult" %arg0, %0 : vector<2xi32>
    %4 = llvm.select %3, %2, %1 : vector<2xi1>, vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

def scalar_select_of_vectors_before := [llvmfunc|
  llvm.func @scalar_select_of_vectors(%arg0: vector<2xi16>, %arg1: vector<2xi16>, %arg2: i8) -> vector<2xi16> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg2, %0 : i8
    %2 = llvm.select %1, %arg0, %arg1 : i1, vector<2xi16>
    llvm.return %2 : vector<2xi16>
  }]

def smax1_combined := [llvmfunc|
  llvm.func @smax1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_smax1   : smax1_before  ⊑  smax1_combined := by
  unfold smax1_before smax1_combined
  simp_alive_peephole
  sorry
def smin1_combined := [llvmfunc|
  llvm.func @smin1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.intr.smin(%arg0, %0)  : (i32, i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_smin1   : smin1_before  ⊑  smin1_combined := by
  unfold smin1_before smin1_combined
  simp_alive_peephole
  sorry
def smax2_combined := [llvmfunc|
  llvm.func @smax2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_smax2   : smax2_before  ⊑  smax2_combined := by
  unfold smax2_before smax2_combined
  simp_alive_peephole
  sorry
def smin2_combined := [llvmfunc|
  llvm.func @smin2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.intr.smin(%arg0, %0)  : (i32, i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_smin2   : smin2_before  ⊑  smin2_combined := by
  unfold smin2_before smin2_combined
  simp_alive_peephole
  sorry
def smax3_combined := [llvmfunc|
  llvm.func @smax3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_smax3   : smax3_before  ⊑  smax3_combined := by
  unfold smax3_before smax3_combined
  simp_alive_peephole
  sorry
def smax3_vec_combined := [llvmfunc|
  llvm.func @smax3_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.intr.smax(%arg0, %1)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_smax3_vec   : smax3_vec_before  ⊑  smax3_vec_combined := by
  unfold smax3_vec_before smax3_vec_combined
  simp_alive_peephole
  sorry
def smin3_combined := [llvmfunc|
  llvm.func @smin3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.intr.smin(%arg0, %0)  : (i32, i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_smin3   : smin3_before  ⊑  smin3_combined := by
  unfold smin3_before smin3_combined
  simp_alive_peephole
  sorry
def smin3_vec_combined := [llvmfunc|
  llvm.func @smin3_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.intr.smin(%arg0, %1)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_smin3_vec   : smin3_vec_before  ⊑  smin3_vec_combined := by
  unfold smin3_vec_before smin3_vec_combined
  simp_alive_peephole
  sorry
def umax3_combined := [llvmfunc|
  llvm.func @umax3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.intr.umax(%arg0, %0)  : (i32, i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_umax3   : umax3_before  ⊑  umax3_combined := by
  unfold umax3_before umax3_combined
  simp_alive_peephole
  sorry
def umax3_vec_combined := [llvmfunc|
  llvm.func @umax3_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.umax(%arg0, %0)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_umax3_vec   : umax3_vec_before  ⊑  umax3_vec_combined := by
  unfold umax3_vec_before umax3_vec_combined
  simp_alive_peephole
  sorry
def umin3_combined := [llvmfunc|
  llvm.func @umin3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.intr.umin(%arg0, %0)  : (i32, i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_umin3   : umin3_before  ⊑  umin3_combined := by
  unfold umin3_before umin3_combined
  simp_alive_peephole
  sorry
def umin3_vec_combined := [llvmfunc|
  llvm.func @umin3_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<6> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.umin(%arg0, %0)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_umin3_vec   : umin3_vec_before  ⊑  umin3_vec_combined := by
  unfold umin3_vec_before umin3_vec_combined
  simp_alive_peephole
  sorry
def smax4_combined := [llvmfunc|
  llvm.func @smax4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_smax4   : smax4_before  ⊑  smax4_combined := by
  unfold smax4_before smax4_combined
  simp_alive_peephole
  sorry
def smax4_vec_combined := [llvmfunc|
  llvm.func @smax4_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.intr.smax(%arg0, %1)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_smax4_vec   : smax4_vec_before  ⊑  smax4_vec_combined := by
  unfold smax4_vec_before smax4_vec_combined
  simp_alive_peephole
  sorry
def smin4_combined := [llvmfunc|
  llvm.func @smin4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.intr.smin(%arg0, %0)  : (i32, i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_smin4   : smin4_before  ⊑  smin4_combined := by
  unfold smin4_before smin4_combined
  simp_alive_peephole
  sorry
def smin4_vec_combined := [llvmfunc|
  llvm.func @smin4_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.intr.smin(%arg0, %1)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_smin4_vec   : smin4_vec_before  ⊑  smin4_vec_combined := by
  unfold smin4_vec_before smin4_vec_combined
  simp_alive_peephole
  sorry
def umax4_combined := [llvmfunc|
  llvm.func @umax4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.intr.umax(%arg0, %0)  : (i32, i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_umax4   : umax4_before  ⊑  umax4_combined := by
  unfold umax4_before umax4_combined
  simp_alive_peephole
  sorry
def umax4_vec_combined := [llvmfunc|
  llvm.func @umax4_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.umax(%arg0, %0)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_umax4_vec   : umax4_vec_before  ⊑  umax4_vec_combined := by
  unfold umax4_vec_before umax4_vec_combined
  simp_alive_peephole
  sorry
def umin4_combined := [llvmfunc|
  llvm.func @umin4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.intr.umin(%arg0, %0)  : (i32, i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_umin4   : umin4_before  ⊑  umin4_combined := by
  unfold umin4_before umin4_combined
  simp_alive_peephole
  sorry
def umin4_vec_combined := [llvmfunc|
  llvm.func @umin4_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<9> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.umin(%arg0, %0)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_umin4_vec   : umin4_vec_before  ⊑  umin4_vec_combined := by
  unfold umin4_vec_before umin4_vec_combined
  simp_alive_peephole
  sorry
def smax_sext_combined := [llvmfunc|
  llvm.func @smax_sext(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    %2 = llvm.zext %1 : i32 to i64
    llvm.return %2 : i64
  }]

theorem inst_combine_smax_sext   : smax_sext_before  ⊑  smax_sext_combined := by
  unfold smax_sext_before smax_sext_combined
  simp_alive_peephole
  sorry
def smax_sext_vec_combined := [llvmfunc|
  llvm.func @smax_sext_vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.intr.smax(%arg0, %1)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %3 = llvm.zext %2 : vector<2xi32> to vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }]

theorem inst_combine_smax_sext_vec   : smax_sext_vec_before  ⊑  smax_sext_vec_combined := by
  unfold smax_sext_vec_before smax_sext_vec_combined
  simp_alive_peephole
  sorry
def smin_sext_combined := [llvmfunc|
  llvm.func @smin_sext(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.intr.smin(%arg0, %0)  : (i32, i32) -> i32
    %2 = llvm.sext %1 : i32 to i64
    llvm.return %2 : i64
  }]

theorem inst_combine_smin_sext   : smin_sext_before  ⊑  smin_sext_combined := by
  unfold smin_sext_before smin_sext_combined
  simp_alive_peephole
  sorry
def smin_sext_vec_combined := [llvmfunc|
  llvm.func @smin_sext_vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.intr.smin(%arg0, %1)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %3 = llvm.sext %2 : vector<2xi32> to vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }]

theorem inst_combine_smin_sext_vec   : smin_sext_vec_before  ⊑  smin_sext_vec_combined := by
  unfold smin_sext_vec_before smin_sext_vec_combined
  simp_alive_peephole
  sorry
def umax_sext_combined := [llvmfunc|
  llvm.func @umax_sext(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.intr.umax(%arg0, %0)  : (i32, i32) -> i32
    %2 = llvm.sext %1 : i32 to i64
    llvm.return %2 : i64
  }]

theorem inst_combine_umax_sext   : umax_sext_before  ⊑  umax_sext_combined := by
  unfold umax_sext_before umax_sext_combined
  simp_alive_peephole
  sorry
def umax_sext_vec_combined := [llvmfunc|
  llvm.func @umax_sext_vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.umax(%arg0, %0)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %2 = llvm.sext %1 : vector<2xi32> to vector<2xi64>
    llvm.return %2 : vector<2xi64>
  }]

theorem inst_combine_umax_sext_vec   : umax_sext_vec_before  ⊑  umax_sext_vec_combined := by
  unfold umax_sext_vec_before umax_sext_vec_combined
  simp_alive_peephole
  sorry
def umin_sext_combined := [llvmfunc|
  llvm.func @umin_sext(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.intr.umin(%arg0, %0)  : (i32, i32) -> i32
    %2 = llvm.zext %1 : i32 to i64
    llvm.return %2 : i64
  }]

theorem inst_combine_umin_sext   : umin_sext_before  ⊑  umin_sext_combined := by
  unfold umin_sext_before umin_sext_combined
  simp_alive_peephole
  sorry
def umin_sext_vec_combined := [llvmfunc|
  llvm.func @umin_sext_vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.umin(%arg0, %0)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %2 = llvm.zext %1 : vector<2xi32> to vector<2xi64>
    llvm.return %2 : vector<2xi64>
  }]

theorem inst_combine_umin_sext_vec   : umin_sext_vec_before  ⊑  umin_sext_vec_combined := by
  unfold umin_sext_vec_before umin_sext_vec_combined
  simp_alive_peephole
  sorry
def umax_sext2_combined := [llvmfunc|
  llvm.func @umax_sext2(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.intr.umax(%arg0, %0)  : (i32, i32) -> i32
    %2 = llvm.sext %1 : i32 to i64
    llvm.return %2 : i64
  }]

theorem inst_combine_umax_sext2   : umax_sext2_before  ⊑  umax_sext2_combined := by
  unfold umax_sext2_before umax_sext2_combined
  simp_alive_peephole
  sorry
def umax_sext2_vec_combined := [llvmfunc|
  llvm.func @umax_sext2_vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.umax(%arg0, %0)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %2 = llvm.sext %1 : vector<2xi32> to vector<2xi64>
    llvm.return %2 : vector<2xi64>
  }]

theorem inst_combine_umax_sext2_vec   : umax_sext2_vec_before  ⊑  umax_sext2_vec_combined := by
  unfold umax_sext2_vec_before umax_sext2_vec_combined
  simp_alive_peephole
  sorry
def umin_sext2_combined := [llvmfunc|
  llvm.func @umin_sext2(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.intr.umin(%arg0, %0)  : (i32, i32) -> i32
    %2 = llvm.zext %1 : i32 to i64
    llvm.return %2 : i64
  }]

theorem inst_combine_umin_sext2   : umin_sext2_before  ⊑  umin_sext2_combined := by
  unfold umin_sext2_before umin_sext2_combined
  simp_alive_peephole
  sorry
def umin_sext2_vec_combined := [llvmfunc|
  llvm.func @umin_sext2_vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.umin(%arg0, %0)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %2 = llvm.zext %1 : vector<2xi32> to vector<2xi64>
    llvm.return %2 : vector<2xi64>
  }]

theorem inst_combine_umin_sext2_vec   : umin_sext2_vec_before  ⊑  umin_sext2_vec_combined := by
  unfold umin_sext2_vec_before umin_sext2_vec_combined
  simp_alive_peephole
  sorry
def umax_zext_combined := [llvmfunc|
  llvm.func @umax_zext(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.intr.umax(%arg0, %0)  : (i32, i32) -> i32
    %2 = llvm.zext %1 : i32 to i64
    llvm.return %2 : i64
  }]

theorem inst_combine_umax_zext   : umax_zext_before  ⊑  umax_zext_combined := by
  unfold umax_zext_before umax_zext_combined
  simp_alive_peephole
  sorry
def umax_zext_vec_combined := [llvmfunc|
  llvm.func @umax_zext_vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.umax(%arg0, %0)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %2 = llvm.zext %1 : vector<2xi32> to vector<2xi64>
    llvm.return %2 : vector<2xi64>
  }]

theorem inst_combine_umax_zext_vec   : umax_zext_vec_before  ⊑  umax_zext_vec_combined := by
  unfold umax_zext_vec_before umax_zext_vec_combined
  simp_alive_peephole
  sorry
def umin_zext_combined := [llvmfunc|
  llvm.func @umin_zext(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.intr.umin(%arg0, %0)  : (i32, i32) -> i32
    %2 = llvm.zext %1 : i32 to i64
    llvm.return %2 : i64
  }]

theorem inst_combine_umin_zext   : umin_zext_before  ⊑  umin_zext_combined := by
  unfold umin_zext_before umin_zext_combined
  simp_alive_peephole
  sorry
def umin_zext_vec_combined := [llvmfunc|
  llvm.func @umin_zext_vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.umin(%arg0, %0)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %2 = llvm.zext %1 : vector<2xi32> to vector<2xi64>
    llvm.return %2 : vector<2xi64>
  }]

theorem inst_combine_umin_zext_vec   : umin_zext_vec_before  ⊑  umin_zext_vec_combined := by
  unfold umin_zext_vec_before umin_zext_vec_combined
  simp_alive_peephole
  sorry
def scalar_select_of_vectors_combined := [llvmfunc|
  llvm.func @scalar_select_of_vectors(%arg0: vector<2xi16>, %arg1: vector<2xi16>, %arg2: i8) -> vector<2xi16> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg2, %0 : i8
    %2 = llvm.select %1, %arg0, %arg1 : i1, vector<2xi16>
    llvm.return %2 : vector<2xi16>
  }]

theorem inst_combine_scalar_select_of_vectors   : scalar_select_of_vectors_before  ⊑  scalar_select_of_vectors_combined := by
  unfold scalar_select_of_vectors_before scalar_select_of_vectors_combined
  simp_alive_peephole
  sorry
