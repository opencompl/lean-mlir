import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  modulo
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def modulo2_before := [llvmfunc|
  llvm.func @modulo2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.srem %arg0, %0  : i32
    %3 = llvm.icmp "slt" %2, %1 : i32
    %4 = llvm.select %3, %0, %1 : i1, i32
    %5 = llvm.add %4, %2 overflow<nsw>  : i32
    llvm.return %5 : i32
  }]

def modulo2_vec_before := [llvmfunc|
  llvm.func @modulo2_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.srem %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "slt" %3, %2 : vector<2xi32>
    %5 = llvm.select %4, %0, %2 : vector<2xi1>, vector<2xi32>
    %6 = llvm.add %5, %3 overflow<nsw>  : vector<2xi32>
    llvm.return %6 : vector<2xi32>
  }]

def modulo3_before := [llvmfunc|
  llvm.func @modulo3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.srem %arg0, %0  : i32
    %3 = llvm.icmp "slt" %2, %1 : i32
    %4 = llvm.select %3, %0, %1 : i1, i32
    %5 = llvm.add %4, %2 overflow<nsw>  : i32
    llvm.return %5 : i32
  }]

def modulo3_vec_before := [llvmfunc|
  llvm.func @modulo3_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.srem %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "slt" %3, %2 : vector<2xi32>
    %5 = llvm.select %4, %0, %2 : vector<2xi1>, vector<2xi32>
    %6 = llvm.add %5, %3 overflow<nsw>  : vector<2xi32>
    llvm.return %6 : vector<2xi32>
  }]

def modulo4_before := [llvmfunc|
  llvm.func @modulo4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.srem %arg0, %0  : i32
    %3 = llvm.icmp "slt" %2, %1 : i32
    %4 = llvm.select %3, %0, %1 : i1, i32
    %5 = llvm.add %4, %2 overflow<nsw>  : i32
    llvm.return %5 : i32
  }]

def modulo4_vec_before := [llvmfunc|
  llvm.func @modulo4_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.srem %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "slt" %3, %2 : vector<2xi32>
    %5 = llvm.select %4, %0, %2 : vector<2xi1>, vector<2xi32>
    %6 = llvm.add %5, %3 overflow<nsw>  : vector<2xi32>
    llvm.return %6 : vector<2xi32>
  }]

def modulo7_before := [llvmfunc|
  llvm.func @modulo7(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.srem %arg0, %0  : i32
    %3 = llvm.icmp "slt" %2, %1 : i32
    %4 = llvm.select %3, %0, %1 : i1, i32
    %5 = llvm.add %4, %2 overflow<nsw>  : i32
    llvm.return %5 : i32
  }]

def modulo7_vec_before := [llvmfunc|
  llvm.func @modulo7_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.srem %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "slt" %3, %2 : vector<2xi32>
    %5 = llvm.select %4, %0, %2 : vector<2xi1>, vector<2xi32>
    %6 = llvm.add %5, %3 overflow<nsw>  : vector<2xi32>
    llvm.return %6 : vector<2xi32>
  }]

def modulo32_before := [llvmfunc|
  llvm.func @modulo32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.srem %arg0, %0  : i32
    %3 = llvm.icmp "slt" %2, %1 : i32
    %4 = llvm.select %3, %0, %1 : i1, i32
    %5 = llvm.add %4, %2 overflow<nsw>  : i32
    llvm.return %5 : i32
  }]

def modulo32_vec_before := [llvmfunc|
  llvm.func @modulo32_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.srem %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "slt" %3, %2 : vector<2xi32>
    %5 = llvm.select %4, %0, %2 : vector<2xi1>, vector<2xi32>
    %6 = llvm.add %5, %3 overflow<nsw>  : vector<2xi32>
    llvm.return %6 : vector<2xi32>
  }]

def modulo16_32_vec_before := [llvmfunc|
  llvm.func @modulo16_32_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[16, 32]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.srem %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "slt" %3, %2 : vector<2xi32>
    %5 = llvm.select %4, %0, %2 : vector<2xi1>, vector<2xi32>
    %6 = llvm.add %5, %3 overflow<nsw>  : vector<2xi32>
    llvm.return %6 : vector<2xi32>
  }]

def modulo2_combined := [llvmfunc|
  llvm.func @modulo2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_modulo2   : modulo2_before  ⊑  modulo2_combined := by
  unfold modulo2_before modulo2_combined
  simp_alive_peephole
  sorry
def modulo2_vec_combined := [llvmfunc|
  llvm.func @modulo2_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.and %arg0, %0  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_modulo2_vec   : modulo2_vec_before  ⊑  modulo2_vec_combined := by
  unfold modulo2_vec_before modulo2_vec_combined
  simp_alive_peephole
  sorry
def modulo3_combined := [llvmfunc|
  llvm.func @modulo3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.srem %arg0, %0  : i32
    %3 = llvm.icmp "slt" %2, %1 : i32
    %4 = llvm.select %3, %0, %1 : i1, i32
    %5 = llvm.add %4, %2 overflow<nsw>  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_modulo3   : modulo3_before  ⊑  modulo3_combined := by
  unfold modulo3_before modulo3_combined
  simp_alive_peephole
  sorry
def modulo3_vec_combined := [llvmfunc|
  llvm.func @modulo3_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.srem %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "slt" %3, %2 : vector<2xi32>
    %5 = llvm.select %4, %0, %2 : vector<2xi1>, vector<2xi32>
    %6 = llvm.add %5, %3 overflow<nsw>  : vector<2xi32>
    llvm.return %6 : vector<2xi32>
  }]

theorem inst_combine_modulo3_vec   : modulo3_vec_before  ⊑  modulo3_vec_combined := by
  unfold modulo3_vec_before modulo3_vec_combined
  simp_alive_peephole
  sorry
def modulo4_combined := [llvmfunc|
  llvm.func @modulo4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_modulo4   : modulo4_before  ⊑  modulo4_combined := by
  unfold modulo4_before modulo4_combined
  simp_alive_peephole
  sorry
def modulo4_vec_combined := [llvmfunc|
  llvm.func @modulo4_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.and %arg0, %0  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_modulo4_vec   : modulo4_vec_before  ⊑  modulo4_vec_combined := by
  unfold modulo4_vec_before modulo4_vec_combined
  simp_alive_peephole
  sorry
def modulo7_combined := [llvmfunc|
  llvm.func @modulo7(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.srem %arg0, %0  : i32
    %3 = llvm.icmp "slt" %2, %1 : i32
    %4 = llvm.select %3, %0, %1 : i1, i32
    %5 = llvm.add %4, %2 overflow<nsw>  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_modulo7   : modulo7_before  ⊑  modulo7_combined := by
  unfold modulo7_before modulo7_combined
  simp_alive_peephole
  sorry
def modulo7_vec_combined := [llvmfunc|
  llvm.func @modulo7_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.srem %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "slt" %3, %2 : vector<2xi32>
    %5 = llvm.select %4, %0, %2 : vector<2xi1>, vector<2xi32>
    %6 = llvm.add %5, %3 overflow<nsw>  : vector<2xi32>
    llvm.return %6 : vector<2xi32>
  }]

theorem inst_combine_modulo7_vec   : modulo7_vec_before  ⊑  modulo7_vec_combined := by
  unfold modulo7_vec_before modulo7_vec_combined
  simp_alive_peephole
  sorry
def modulo32_combined := [llvmfunc|
  llvm.func @modulo32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_modulo32   : modulo32_before  ⊑  modulo32_combined := by
  unfold modulo32_before modulo32_combined
  simp_alive_peephole
  sorry
def modulo32_vec_combined := [llvmfunc|
  llvm.func @modulo32_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<31> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.and %arg0, %0  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_modulo32_vec   : modulo32_vec_before  ⊑  modulo32_vec_combined := by
  unfold modulo32_vec_before modulo32_vec_combined
  simp_alive_peephole
  sorry
def modulo16_32_vec_combined := [llvmfunc|
  llvm.func @modulo16_32_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[16, 32]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.srem %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "slt" %3, %2 : vector<2xi32>
    %5 = llvm.select %4, %0, %2 : vector<2xi1>, vector<2xi32>
    %6 = llvm.add %5, %3 overflow<nsw>  : vector<2xi32>
    llvm.return %6 : vector<2xi32>
  }]

theorem inst_combine_modulo16_32_vec   : modulo16_32_vec_before  ⊑  modulo16_32_vec_combined := by
  unfold modulo16_32_vec_before modulo16_32_vec_combined
  simp_alive_peephole
  sorry
