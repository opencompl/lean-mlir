import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  ctpop-pow2
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def ctpop_x_and_negx_before := [llvmfunc|
  llvm.func @ctpop_x_and_negx(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.sub %0, %arg0  : i16
    %2 = llvm.and %arg0, %1  : i16
    %3 = llvm.intr.ctpop(%2)  : (i16) -> i16
    llvm.return %3 : i16
  }]

def ctpop_x_nz_and_negx_before := [llvmfunc|
  llvm.func @ctpop_x_nz_and_negx(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.sub %1, %2  : i8
    %4 = llvm.and %2, %3  : i8
    %5 = llvm.intr.ctpop(%4)  : (i8) -> i8
    llvm.return %5 : i8
  }]

def ctpop_2_shl_before := [llvmfunc|
  llvm.func @ctpop_2_shl(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.shl %0, %arg0  : i32
    %2 = llvm.intr.ctpop(%1)  : (i32) -> i32
    llvm.return %2 : i32
  }]

def ctpop_2_shl_nz_before := [llvmfunc|
  llvm.func @ctpop_2_shl_nz(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(30 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.and %0, %arg0  : i32
    %3 = llvm.shl %1, %2  : i32
    %4 = llvm.intr.ctpop(%3)  : (i32) -> i32
    llvm.return %4 : i32
  }]

def ctpop_imin_plus1_lshr_nz_before := [llvmfunc|
  llvm.func @ctpop_imin_plus1_lshr_nz(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-127 : i8) : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.lshr %1, %arg0  : i8
    %4 = llvm.intr.ctpop(%3)  : (i8) -> i8
    llvm.return %4 : i8
  }]

def ctpop_x_and_negx_nz_before := [llvmfunc|
  llvm.func @ctpop_x_and_negx_nz(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.sub %0, %arg0  : i64
    %2 = llvm.and %arg0, %1  : i64
    %3 = llvm.icmp "ne" %2, %0 : i64
    "llvm.intr.assume"(%3) : (i1) -> ()
    %4 = llvm.intr.ctpop(%2)  : (i64) -> i64
    llvm.return %4 : i64
  }]

def ctpop_shl2_1_vec_before := [llvmfunc|
  llvm.func @ctpop_shl2_1_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[2, 1]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.shl %0, %arg0  : vector<2xi32>
    %2 = llvm.intr.ctpop(%1)  : (vector<2xi32>) -> vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def ctpop_lshr_intmin_intmin_plus1_vec_nz_before := [llvmfunc|
  llvm.func @ctpop_lshr_intmin_intmin_plus1_vec_nz(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[-2147483648, -2147483647]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.or %arg0, %0  : vector<2xi32>
    %3 = llvm.lshr %1, %2  : vector<2xi32>
    %4 = llvm.intr.ctpop(%3)  : (vector<2xi32>) -> vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def ctpop_shl2_1_vec_nz_before := [llvmfunc|
  llvm.func @ctpop_shl2_1_vec_nz(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<15> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[2, 1]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.and %arg0, %0  : vector<2xi32>
    %3 = llvm.shl %1, %2  : vector<2xi32>
    %4 = llvm.intr.ctpop(%3)  : (vector<2xi32>) -> vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def ctpop_x_and_negx_vec_before := [llvmfunc|
  llvm.func @ctpop_x_and_negx_vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.sub %1, %arg0  : vector<2xi64>
    %3 = llvm.and %2, %arg0  : vector<2xi64>
    %4 = llvm.intr.ctpop(%3)  : (vector<2xi64>) -> vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

def ctpop_x_and_negx_vec_nz_before := [llvmfunc|
  llvm.func @ctpop_x_and_negx_vec_nz(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.or %arg0, %0  : vector<2xi32>
    %4 = llvm.sub %2, %3  : vector<2xi32>
    %5 = llvm.and %4, %3  : vector<2xi32>
    %6 = llvm.intr.ctpop(%5)  : (vector<2xi32>) -> vector<2xi32>
    llvm.return %6 : vector<2xi32>
  }]

def ctpop_x_and_negx_combined := [llvmfunc|
  llvm.func @ctpop_x_and_negx(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.sub %0, %arg0  : i16
    %2 = llvm.and %1, %arg0  : i16
    %3 = llvm.icmp "ne" %2, %0 : i16
    %4 = llvm.zext %3 : i1 to i16
    llvm.return %4 : i16
  }]

theorem inst_combine_ctpop_x_and_negx   : ctpop_x_and_negx_before  ⊑  ctpop_x_and_negx_combined := by
  unfold ctpop_x_and_negx_before ctpop_x_and_negx_combined
  simp_alive_peephole
  sorry
def ctpop_x_nz_and_negx_combined := [llvmfunc|
  llvm.func @ctpop_x_nz_and_negx(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_ctpop_x_nz_and_negx   : ctpop_x_nz_and_negx_before  ⊑  ctpop_x_nz_and_negx_combined := by
  unfold ctpop_x_nz_and_negx_before ctpop_x_nz_and_negx_combined
  simp_alive_peephole
  sorry
def ctpop_2_shl_combined := [llvmfunc|
  llvm.func @ctpop_2_shl(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.icmp "ult" %arg0, %0 : i32
    %2 = llvm.zext %1 : i1 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_ctpop_2_shl   : ctpop_2_shl_before  ⊑  ctpop_2_shl_combined := by
  unfold ctpop_2_shl_before ctpop_2_shl_combined
  simp_alive_peephole
  sorry
def ctpop_2_shl_nz_combined := [llvmfunc|
  llvm.func @ctpop_2_shl_nz(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_ctpop_2_shl_nz   : ctpop_2_shl_nz_before  ⊑  ctpop_2_shl_nz_combined := by
  unfold ctpop_2_shl_nz_before ctpop_2_shl_nz_combined
  simp_alive_peephole
  sorry
def ctpop_imin_plus1_lshr_nz_combined := [llvmfunc|
  llvm.func @ctpop_imin_plus1_lshr_nz(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-127 : i8) : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.lshr %1, %arg0  : i8
    %4 = llvm.intr.ctpop(%3)  : (i8) -> i8
    llvm.return %4 : i8
  }]

theorem inst_combine_ctpop_imin_plus1_lshr_nz   : ctpop_imin_plus1_lshr_nz_before  ⊑  ctpop_imin_plus1_lshr_nz_combined := by
  unfold ctpop_imin_plus1_lshr_nz_before ctpop_imin_plus1_lshr_nz_combined
  simp_alive_peephole
  sorry
def ctpop_x_and_negx_nz_combined := [llvmfunc|
  llvm.func @ctpop_x_and_negx_nz(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.sub %0, %arg0  : i64
    %3 = llvm.and %2, %arg0  : i64
    %4 = llvm.icmp "ne" %3, %0 : i64
    "llvm.intr.assume"(%4) : (i1) -> ()
    llvm.return %1 : i64
  }]

theorem inst_combine_ctpop_x_and_negx_nz   : ctpop_x_and_negx_nz_before  ⊑  ctpop_x_and_negx_nz_combined := by
  unfold ctpop_x_and_negx_nz_before ctpop_x_and_negx_nz_combined
  simp_alive_peephole
  sorry
def ctpop_shl2_1_vec_combined := [llvmfunc|
  llvm.func @ctpop_shl2_1_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[2, 1]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.shl %0, %arg0  : vector<2xi32>
    %4 = llvm.icmp "ne" %3, %2 : vector<2xi32>
    %5 = llvm.zext %4 : vector<2xi1> to vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

theorem inst_combine_ctpop_shl2_1_vec   : ctpop_shl2_1_vec_before  ⊑  ctpop_shl2_1_vec_combined := by
  unfold ctpop_shl2_1_vec_before ctpop_shl2_1_vec_combined
  simp_alive_peephole
  sorry
def ctpop_lshr_intmin_intmin_plus1_vec_nz_combined := [llvmfunc|
  llvm.func @ctpop_lshr_intmin_intmin_plus1_vec_nz(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[-2147483648, -2147483647]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.or %arg0, %0  : vector<2xi32>
    %3 = llvm.lshr %1, %2  : vector<2xi32>
    %4 = llvm.intr.ctpop(%3)  : (vector<2xi32>) -> vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

theorem inst_combine_ctpop_lshr_intmin_intmin_plus1_vec_nz   : ctpop_lshr_intmin_intmin_plus1_vec_nz_before  ⊑  ctpop_lshr_intmin_intmin_plus1_vec_nz_combined := by
  unfold ctpop_lshr_intmin_intmin_plus1_vec_nz_before ctpop_lshr_intmin_intmin_plus1_vec_nz_combined
  simp_alive_peephole
  sorry
def ctpop_shl2_1_vec_nz_combined := [llvmfunc|
  llvm.func @ctpop_shl2_1_vec_nz(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    llvm.return %0 : vector<2xi32>
  }]

theorem inst_combine_ctpop_shl2_1_vec_nz   : ctpop_shl2_1_vec_nz_before  ⊑  ctpop_shl2_1_vec_nz_combined := by
  unfold ctpop_shl2_1_vec_nz_before ctpop_shl2_1_vec_nz_combined
  simp_alive_peephole
  sorry
def ctpop_x_and_negx_vec_combined := [llvmfunc|
  llvm.func @ctpop_x_and_negx_vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.sub %1, %arg0  : vector<2xi64>
    %3 = llvm.and %2, %arg0  : vector<2xi64>
    %4 = llvm.icmp "ne" %3, %1 : vector<2xi64>
    %5 = llvm.zext %4 : vector<2xi1> to vector<2xi64>
    llvm.return %5 : vector<2xi64>
  }]

theorem inst_combine_ctpop_x_and_negx_vec   : ctpop_x_and_negx_vec_before  ⊑  ctpop_x_and_negx_vec_combined := by
  unfold ctpop_x_and_negx_vec_before ctpop_x_and_negx_vec_combined
  simp_alive_peephole
  sorry
def ctpop_x_and_negx_vec_nz_combined := [llvmfunc|
  llvm.func @ctpop_x_and_negx_vec_nz(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    llvm.return %0 : vector<2xi32>
  }]

theorem inst_combine_ctpop_x_and_negx_vec_nz   : ctpop_x_and_negx_vec_nz_before  ⊑  ctpop_x_and_negx_vec_nz_combined := by
  unfold ctpop_x_and_negx_vec_nz_before ctpop_x_and_negx_vec_nz_combined
  simp_alive_peephole
  sorry
