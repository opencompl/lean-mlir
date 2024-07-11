import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  conditional-negation
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t0_before := [llvmfunc|
  llvm.func @t0(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.sext %arg1 : i1 to i8
    %1 = llvm.add %0, %arg0  : i8
    %2 = llvm.xor %1, %0  : i8
    llvm.return %2 : i8
  }]

def t0_vec_before := [llvmfunc|
  llvm.func @t0_vec(%arg0: vector<2xi8>, %arg1: vector<2xi1>) -> vector<2xi8> {
    %0 = llvm.sext %arg1 : vector<2xi1> to vector<2xi8>
    %1 = llvm.add %0, %arg0  : vector<2xi8>
    %2 = llvm.xor %1, %0  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

def t1_before := [llvmfunc|
  llvm.func @t1(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.sext %arg1 : i1 to i8
    %1 = llvm.sext %arg1 : i1 to i8
    %2 = llvm.add %0, %arg0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }]

def t2_before := [llvmfunc|
  llvm.func @t2(%arg0: i8, %arg1: i1, %arg2: i1) -> i8 {
    %0 = llvm.sext %arg1 : i1 to i8
    %1 = llvm.sext %arg2 : i1 to i8
    %2 = llvm.add %0, %arg0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }]

def t3_before := [llvmfunc|
  llvm.func @t3(%arg0: i8, %arg1: i2) -> i8 {
    %0 = llvm.sext %arg1 : i2 to i8
    %1 = llvm.add %0, %arg0  : i8
    %2 = llvm.xor %1, %0  : i8
    llvm.return %2 : i8
  }]

def t3_vec_before := [llvmfunc|
  llvm.func @t3_vec(%arg0: vector<2xi8>, %arg1: vector<2xi2>) -> vector<2xi8> {
    %0 = llvm.sext %arg1 : vector<2xi2> to vector<2xi8>
    %1 = llvm.add %0, %arg0  : vector<2xi8>
    %2 = llvm.xor %1, %0  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

def xor.commuted_before := [llvmfunc|
  llvm.func @xor.commuted(%arg0: i1) -> i8 {
    %0 = llvm.sext %arg0 : i1 to i8
    %1 = llvm.call @gen.i8() : () -> i8
    %2 = llvm.add %1, %0  : i8
    %3 = llvm.xor %2, %0  : i8
    llvm.return %3 : i8
  }]

def extrause01_v1_before := [llvmfunc|
  llvm.func @extrause01_v1(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.sext %arg1 : i1 to i8
    llvm.call @use.i8(%0) : (i8) -> ()
    %1 = llvm.add %0, %arg0  : i8
    %2 = llvm.xor %1, %0  : i8
    llvm.return %2 : i8
  }]

def extrause10_v1_before := [llvmfunc|
  llvm.func @extrause10_v1(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.sext %arg1 : i1 to i8
    %1 = llvm.add %0, %arg0  : i8
    llvm.call @use.i8(%1) : (i8) -> ()
    %2 = llvm.xor %1, %0  : i8
    llvm.return %2 : i8
  }]

def extrause11_v1_before := [llvmfunc|
  llvm.func @extrause11_v1(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.sext %arg1 : i1 to i8
    llvm.call @use.i8(%0) : (i8) -> ()
    %1 = llvm.add %0, %arg0  : i8
    llvm.call @use.i8(%1) : (i8) -> ()
    %2 = llvm.xor %1, %0  : i8
    llvm.return %2 : i8
  }]

def extrause001_v2_before := [llvmfunc|
  llvm.func @extrause001_v2(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.sext %arg1 : i1 to i8
    llvm.call @use.i8(%0) : (i8) -> ()
    %1 = llvm.sext %arg1 : i1 to i8
    %2 = llvm.add %0, %arg0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }]

def extrause010_v2_before := [llvmfunc|
  llvm.func @extrause010_v2(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.sext %arg1 : i1 to i8
    %1 = llvm.sext %arg1 : i1 to i8
    llvm.call @use.i8(%1) : (i8) -> ()
    %2 = llvm.add %0, %arg0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }]

def extrause011_v2_before := [llvmfunc|
  llvm.func @extrause011_v2(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.sext %arg1 : i1 to i8
    llvm.call @use.i8(%0) : (i8) -> ()
    %1 = llvm.sext %arg1 : i1 to i8
    llvm.call @use.i8(%1) : (i8) -> ()
    %2 = llvm.add %0, %arg0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }]

def extrause100_v2_before := [llvmfunc|
  llvm.func @extrause100_v2(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.sext %arg1 : i1 to i8
    %1 = llvm.sext %arg1 : i1 to i8
    %2 = llvm.add %0, %arg0  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }]

def extrause101_v2_before := [llvmfunc|
  llvm.func @extrause101_v2(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.sext %arg1 : i1 to i8
    llvm.call @use.i8(%0) : (i8) -> ()
    %1 = llvm.sext %arg1 : i1 to i8
    %2 = llvm.add %0, %arg0  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }]

def extrause110_v2_before := [llvmfunc|
  llvm.func @extrause110_v2(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.sext %arg1 : i1 to i8
    %1 = llvm.sext %arg1 : i1 to i8
    llvm.call @use.i8(%1) : (i8) -> ()
    %2 = llvm.add %0, %arg0  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }]

def extrause111_v2_before := [llvmfunc|
  llvm.func @extrause111_v2(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.sext %arg1 : i1 to i8
    llvm.call @use.i8(%0) : (i8) -> ()
    %1 = llvm.sext %arg1 : i1 to i8
    llvm.call @use.i8(%1) : (i8) -> ()
    %2 = llvm.add %0, %arg0  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }]

def t0_combined := [llvmfunc|
  llvm.func @t0(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    %2 = llvm.select %arg1, %1, %arg0 : i1, i8
    llvm.return %2 : i8
  }]

theorem inst_combine_t0   : t0_before  ⊑  t0_combined := by
  unfold t0_before t0_combined
  simp_alive_peephole
  sorry
def t0_vec_combined := [llvmfunc|
  llvm.func @t0_vec(%arg0: vector<2xi8>, %arg1: vector<2xi1>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.sub %1, %arg0  : vector<2xi8>
    %3 = llvm.select %arg1, %2, %arg0 : vector<2xi1>, vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_t0_vec   : t0_vec_before  ⊑  t0_vec_combined := by
  unfold t0_vec_before t0_vec_combined
  simp_alive_peephole
  sorry
def t1_combined := [llvmfunc|
  llvm.func @t1(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    %2 = llvm.select %arg1, %1, %arg0 : i1, i8
    llvm.return %2 : i8
  }]

theorem inst_combine_t1   : t1_before  ⊑  t1_combined := by
  unfold t1_before t1_combined
  simp_alive_peephole
  sorry
def t2_combined := [llvmfunc|
  llvm.func @t2(%arg0: i8, %arg1: i1, %arg2: i1) -> i8 {
    %0 = llvm.sext %arg1 : i1 to i8
    %1 = llvm.sext %arg2 : i1 to i8
    %2 = llvm.add %0, %arg0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_t2   : t2_before  ⊑  t2_combined := by
  unfold t2_before t2_combined
  simp_alive_peephole
  sorry
def t3_combined := [llvmfunc|
  llvm.func @t3(%arg0: i8, %arg1: i2) -> i8 {
    %0 = llvm.sext %arg1 : i2 to i8
    %1 = llvm.add %0, %arg0  : i8
    %2 = llvm.xor %1, %0  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_t3   : t3_before  ⊑  t3_combined := by
  unfold t3_before t3_combined
  simp_alive_peephole
  sorry
def t3_vec_combined := [llvmfunc|
  llvm.func @t3_vec(%arg0: vector<2xi8>, %arg1: vector<2xi2>) -> vector<2xi8> {
    %0 = llvm.sext %arg1 : vector<2xi2> to vector<2xi8>
    %1 = llvm.add %0, %arg0  : vector<2xi8>
    %2 = llvm.xor %1, %0  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

theorem inst_combine_t3_vec   : t3_vec_before  ⊑  t3_vec_combined := by
  unfold t3_vec_before t3_vec_combined
  simp_alive_peephole
  sorry
def xor.commuted_combined := [llvmfunc|
  llvm.func @xor.commuted(%arg0: i1) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.call @gen.i8() : () -> i8
    %2 = llvm.sub %0, %1  : i8
    %3 = llvm.select %arg0, %2, %1 : i1, i8
    llvm.return %3 : i8
  }]

theorem inst_combine_xor.commuted   : xor.commuted_before  ⊑  xor.commuted_combined := by
  unfold xor.commuted_before xor.commuted_combined
  simp_alive_peephole
  sorry
def extrause01_v1_combined := [llvmfunc|
  llvm.func @extrause01_v1(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sext %arg1 : i1 to i8
    llvm.call @use.i8(%1) : (i8) -> ()
    %2 = llvm.sub %0, %arg0  : i8
    %3 = llvm.select %arg1, %2, %arg0 : i1, i8
    llvm.return %3 : i8
  }]

theorem inst_combine_extrause01_v1   : extrause01_v1_before  ⊑  extrause01_v1_combined := by
  unfold extrause01_v1_before extrause01_v1_combined
  simp_alive_peephole
  sorry
def extrause10_v1_combined := [llvmfunc|
  llvm.func @extrause10_v1(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.sext %arg1 : i1 to i8
    %1 = llvm.add %0, %arg0  : i8
    llvm.call @use.i8(%1) : (i8) -> ()
    %2 = llvm.xor %1, %0  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_extrause10_v1   : extrause10_v1_before  ⊑  extrause10_v1_combined := by
  unfold extrause10_v1_before extrause10_v1_combined
  simp_alive_peephole
  sorry
def extrause11_v1_combined := [llvmfunc|
  llvm.func @extrause11_v1(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.sext %arg1 : i1 to i8
    llvm.call @use.i8(%0) : (i8) -> ()
    %1 = llvm.add %0, %arg0  : i8
    llvm.call @use.i8(%1) : (i8) -> ()
    %2 = llvm.xor %1, %0  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_extrause11_v1   : extrause11_v1_before  ⊑  extrause11_v1_combined := by
  unfold extrause11_v1_before extrause11_v1_combined
  simp_alive_peephole
  sorry
def extrause001_v2_combined := [llvmfunc|
  llvm.func @extrause001_v2(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sext %arg1 : i1 to i8
    llvm.call @use.i8(%1) : (i8) -> ()
    %2 = llvm.sub %0, %arg0  : i8
    %3 = llvm.select %arg1, %2, %arg0 : i1, i8
    llvm.return %3 : i8
  }]

theorem inst_combine_extrause001_v2   : extrause001_v2_before  ⊑  extrause001_v2_combined := by
  unfold extrause001_v2_before extrause001_v2_combined
  simp_alive_peephole
  sorry
def extrause010_v2_combined := [llvmfunc|
  llvm.func @extrause010_v2(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sext %arg1 : i1 to i8
    llvm.call @use.i8(%1) : (i8) -> ()
    %2 = llvm.sub %0, %arg0  : i8
    %3 = llvm.select %arg1, %2, %arg0 : i1, i8
    llvm.return %3 : i8
  }]

theorem inst_combine_extrause010_v2   : extrause010_v2_before  ⊑  extrause010_v2_combined := by
  unfold extrause010_v2_before extrause010_v2_combined
  simp_alive_peephole
  sorry
def extrause011_v2_combined := [llvmfunc|
  llvm.func @extrause011_v2(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sext %arg1 : i1 to i8
    llvm.call @use.i8(%1) : (i8) -> ()
    %2 = llvm.sext %arg1 : i1 to i8
    llvm.call @use.i8(%2) : (i8) -> ()
    %3 = llvm.sub %0, %arg0  : i8
    %4 = llvm.select %arg1, %3, %arg0 : i1, i8
    llvm.return %4 : i8
  }]

theorem inst_combine_extrause011_v2   : extrause011_v2_before  ⊑  extrause011_v2_combined := by
  unfold extrause011_v2_before extrause011_v2_combined
  simp_alive_peephole
  sorry
def extrause100_v2_combined := [llvmfunc|
  llvm.func @extrause100_v2(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sext %arg1 : i1 to i8
    %2 = llvm.add %1, %arg0  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    %3 = llvm.sub %0, %arg0  : i8
    %4 = llvm.select %arg1, %3, %arg0 : i1, i8
    llvm.return %4 : i8
  }]

theorem inst_combine_extrause100_v2   : extrause100_v2_before  ⊑  extrause100_v2_combined := by
  unfold extrause100_v2_before extrause100_v2_combined
  simp_alive_peephole
  sorry
def extrause101_v2_combined := [llvmfunc|
  llvm.func @extrause101_v2(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sext %arg1 : i1 to i8
    llvm.call @use.i8(%1) : (i8) -> ()
    %2 = llvm.add %1, %arg0  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    %3 = llvm.sub %0, %arg0  : i8
    %4 = llvm.select %arg1, %3, %arg0 : i1, i8
    llvm.return %4 : i8
  }]

theorem inst_combine_extrause101_v2   : extrause101_v2_before  ⊑  extrause101_v2_combined := by
  unfold extrause101_v2_before extrause101_v2_combined
  simp_alive_peephole
  sorry
def extrause110_v2_combined := [llvmfunc|
  llvm.func @extrause110_v2(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.sext %arg1 : i1 to i8
    %1 = llvm.sext %arg1 : i1 to i8
    llvm.call @use.i8(%1) : (i8) -> ()
    %2 = llvm.add %0, %arg0  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_extrause110_v2   : extrause110_v2_before  ⊑  extrause110_v2_combined := by
  unfold extrause110_v2_before extrause110_v2_combined
  simp_alive_peephole
  sorry
def extrause111_v2_combined := [llvmfunc|
  llvm.func @extrause111_v2(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.sext %arg1 : i1 to i8
    llvm.call @use.i8(%0) : (i8) -> ()
    %1 = llvm.sext %arg1 : i1 to i8
    llvm.call @use.i8(%1) : (i8) -> ()
    %2 = llvm.add %0, %arg0  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_extrause111_v2   : extrause111_v2_before  ⊑  extrause111_v2_combined := by
  unfold extrause111_v2_before extrause111_v2_combined
  simp_alive_peephole
  sorry
