import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  icmp-shl-nuw
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def icmp_ugt_32_before := [llvmfunc|
  llvm.func @icmp_ugt_32(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(4294967295 : i64) : i64
    %2 = llvm.shl %arg0, %0 overflow<nuw>  : i64
    %3 = llvm.icmp "ugt" %2, %1 : i64
    llvm.return %3 : i1
  }]

def icmp_ule_64_before := [llvmfunc|
  llvm.func @icmp_ule_64(%arg0: i128) -> i1 {
    %0 = llvm.mlir.constant(64 : i128) : i128
    %1 = llvm.mlir.constant(18446744073709551615 : i128) : i128
    %2 = llvm.shl %arg0, %0 overflow<nuw>  : i128
    %3 = llvm.icmp "ule" %2, %1 : i128
    llvm.return %3 : i1
  }]

def icmp_ugt_16_before := [llvmfunc|
  llvm.func @icmp_ugt_16(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.mlir.constant(1048575 : i64) : i64
    %2 = llvm.shl %arg0, %0 overflow<nuw>  : i64
    %3 = llvm.icmp "ugt" %2, %1 : i64
    llvm.return %3 : i1
  }]

def icmp_ule_16x2_before := [llvmfunc|
  llvm.func @icmp_ule_16x2(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<65535> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.shl %arg0, %0 overflow<nuw>  : vector<2xi64>
    %3 = llvm.icmp "ule" %2, %1 : vector<2xi64>
    llvm.return %3 : vector<2xi1>
  }]

def icmp_ule_16x2_nonzero_before := [llvmfunc|
  llvm.func @icmp_ule_16x2_nonzero(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<196608> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.shl %arg0, %0 overflow<nuw>  : vector<2xi64>
    %3 = llvm.icmp "ule" %2, %1 : vector<2xi64>
    llvm.return %3 : vector<2xi1>
  }]

def icmp_ule_12x2_before := [llvmfunc|
  llvm.func @icmp_ule_12x2(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<12> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<12288> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.shl %arg0, %0 overflow<nuw>  : vector<2xi64>
    %3 = llvm.icmp "ule" %2, %1 : vector<2xi64>
    llvm.return %3 : vector<2xi1>
  }]

def icmp_ult_8_before := [llvmfunc|
  llvm.func @icmp_ult_8(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(8 : i64) : i64
    %1 = llvm.mlir.constant(4095 : i64) : i64
    %2 = llvm.shl %arg0, %0 overflow<nuw>  : i64
    %3 = llvm.icmp "ult" %2, %1 : i64
    llvm.return %3 : i1
  }]

def icmp_uge_8x2_before := [llvmfunc|
  llvm.func @icmp_uge_8x2(%arg0: vector<2xi16>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(dense<4095> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.shl %arg0, %0 overflow<nuw>  : vector<2xi16>
    %3 = llvm.icmp "uge" %2, %1 : vector<2xi16>
    llvm.return %3 : vector<2xi1>
  }]

def icmp_ugt_16x2_before := [llvmfunc|
  llvm.func @icmp_ugt_16x2(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<1048575> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.shl %arg0, %0 overflow<nuw>  : vector<2xi32>
    %3 = llvm.icmp "ugt" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

def icmp_ugt_32_combined := [llvmfunc|
  llvm.func @icmp_ugt_32(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_ugt_32   : icmp_ugt_32_before  ⊑  icmp_ugt_32_combined := by
  unfold icmp_ugt_32_before icmp_ugt_32_combined
  simp_alive_peephole
  sorry
def icmp_ule_64_combined := [llvmfunc|
  llvm.func @icmp_ule_64(%arg0: i128) -> i1 {
    %0 = llvm.mlir.constant(0 : i128) : i128
    %1 = llvm.icmp "eq" %arg0, %0 : i128
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_ule_64   : icmp_ule_64_before  ⊑  icmp_ule_64_combined := by
  unfold icmp_ule_64_before icmp_ule_64_combined
  simp_alive_peephole
  sorry
def icmp_ugt_16_combined := [llvmfunc|
  llvm.func @icmp_ugt_16(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(15 : i64) : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_ugt_16   : icmp_ugt_16_before  ⊑  icmp_ugt_16_combined := by
  unfold icmp_ugt_16_before icmp_ugt_16_combined
  simp_alive_peephole
  sorry
def icmp_ule_16x2_combined := [llvmfunc|
  llvm.func @icmp_ule_16x2(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.icmp "eq" %arg0, %1 : vector<2xi64>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_icmp_ule_16x2   : icmp_ule_16x2_before  ⊑  icmp_ule_16x2_combined := by
  unfold icmp_ule_16x2_before icmp_ule_16x2_combined
  simp_alive_peephole
  sorry
def icmp_ule_16x2_nonzero_combined := [llvmfunc|
  llvm.func @icmp_ule_16x2_nonzero(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.icmp "ult" %arg0, %0 : vector<2xi64>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_icmp_ule_16x2_nonzero   : icmp_ule_16x2_nonzero_before  ⊑  icmp_ule_16x2_nonzero_combined := by
  unfold icmp_ule_16x2_nonzero_before icmp_ule_16x2_nonzero_combined
  simp_alive_peephole
  sorry
def icmp_ule_12x2_combined := [llvmfunc|
  llvm.func @icmp_ule_12x2(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.icmp "ult" %arg0, %0 : vector<2xi64>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_icmp_ule_12x2   : icmp_ule_12x2_before  ⊑  icmp_ule_12x2_combined := by
  unfold icmp_ule_12x2_before icmp_ule_12x2_combined
  simp_alive_peephole
  sorry
def icmp_ult_8_combined := [llvmfunc|
  llvm.func @icmp_ult_8(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_ult_8   : icmp_ult_8_before  ⊑  icmp_ult_8_combined := by
  unfold icmp_ult_8_before icmp_ult_8_combined
  simp_alive_peephole
  sorry
def icmp_uge_8x2_combined := [llvmfunc|
  llvm.func @icmp_uge_8x2(%arg0: vector<2xi16>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<15> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.icmp "ugt" %arg0, %0 : vector<2xi16>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_icmp_uge_8x2   : icmp_uge_8x2_before  ⊑  icmp_uge_8x2_combined := by
  unfold icmp_uge_8x2_before icmp_uge_8x2_combined
  simp_alive_peephole
  sorry
def icmp_ugt_16x2_combined := [llvmfunc|
  llvm.func @icmp_ugt_16x2(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<15> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "ugt" %arg0, %0 : vector<2xi32>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_icmp_ugt_16x2   : icmp_ugt_16x2_before  ⊑  icmp_ugt_16x2_combined := by
  unfold icmp_ugt_16x2_before icmp_ugt_16x2_combined
  simp_alive_peephole
  sorry
