import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  fmul-maximum-minimum
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_before := [llvmfunc|
  llvm.func @test(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.minimum(%arg0, %arg1)  : (f32, f32) -> f32
    %1 = llvm.intr.maximum(%arg0, %arg1)  : (f32, f32) -> f32
    %2 = llvm.fmul %0, %1  : f32
    llvm.return %2 : f32
  }]

def test_comm1_before := [llvmfunc|
  llvm.func @test_comm1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.minimum(%arg0, %arg1)  : (f32, f32) -> f32
    %1 = llvm.intr.maximum(%arg0, %arg1)  : (f32, f32) -> f32
    %2 = llvm.fmul %1, %0  : f32
    llvm.return %2 : f32
  }]

def test_comm2_before := [llvmfunc|
  llvm.func @test_comm2(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.minimum(%arg0, %arg1)  : (f32, f32) -> f32
    %1 = llvm.intr.maximum(%arg1, %arg0)  : (f32, f32) -> f32
    %2 = llvm.fmul %0, %1  : f32
    llvm.return %2 : f32
  }]

def test_comm3_before := [llvmfunc|
  llvm.func @test_comm3(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.minimum(%arg0, %arg1)  : (f32, f32) -> f32
    %1 = llvm.intr.maximum(%arg1, %arg0)  : (f32, f32) -> f32
    %2 = llvm.fmul %1, %0  : f32
    llvm.return %2 : f32
  }]

def test_vect_before := [llvmfunc|
  llvm.func @test_vect(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.intr.minimum(%arg0, %arg1)  : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %1 = llvm.intr.maximum(%arg1, %arg0)  : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %2 = llvm.fmul %0, %1  : vector<4xf32>
    llvm.return %2 : vector<4xf32>
  }]

def test_flags_before := [llvmfunc|
  llvm.func @test_flags(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.minimum(%arg0, %arg1)  : (f32, f32) -> f32
    %1 = llvm.intr.maximum(%arg0, %arg1)  : (f32, f32) -> f32
    %2 = llvm.fmul %0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.return %2 : f32
  }]

def test_flags2_before := [llvmfunc|
  llvm.func @test_flags2(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.minimum(%arg0, %arg1)  : (f32, f32) -> f32
    %1 = llvm.intr.maximum(%arg0, %arg1)  : (f32, f32) -> f32
    %2 = llvm.fmul %0, %1  {fastmathFlags = #llvm.fastmath<ninf, nsz, arcp, contract, afn, reassoc>} : f32]

    llvm.return %2 : f32
  }]

def test_combined := [llvmfunc|
  llvm.func @test(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fmul %arg0, %arg1  : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
def test_comm1_combined := [llvmfunc|
  llvm.func @test_comm1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fmul %arg0, %arg1  : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_test_comm1   : test_comm1_before  ⊑  test_comm1_combined := by
  unfold test_comm1_before test_comm1_combined
  simp_alive_peephole
  sorry
def test_comm2_combined := [llvmfunc|
  llvm.func @test_comm2(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fmul %arg1, %arg0  : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_test_comm2   : test_comm2_before  ⊑  test_comm2_combined := by
  unfold test_comm2_before test_comm2_combined
  simp_alive_peephole
  sorry
def test_comm3_combined := [llvmfunc|
  llvm.func @test_comm3(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fmul %arg1, %arg0  : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_test_comm3   : test_comm3_before  ⊑  test_comm3_combined := by
  unfold test_comm3_before test_comm3_combined
  simp_alive_peephole
  sorry
def test_vect_combined := [llvmfunc|
  llvm.func @test_vect(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.fmul %arg1, %arg0  : vector<4xf32>
    llvm.return %0 : vector<4xf32>
  }]

theorem inst_combine_test_vect   : test_vect_before  ⊑  test_vect_combined := by
  unfold test_vect_before test_vect_combined
  simp_alive_peephole
  sorry
def test_flags_combined := [llvmfunc|
  llvm.func @test_flags(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fmul %arg0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_test_flags   : test_flags_before  ⊑  test_flags_combined := by
  unfold test_flags_before test_flags_combined
  simp_alive_peephole
  sorry
def test_flags2_combined := [llvmfunc|
  llvm.func @test_flags2(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fmul %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nsz, arcp, contract, afn, reassoc>} : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_test_flags2   : test_flags2_before  ⊑  test_flags2_combined := by
  unfold test_flags2_before test_flags2_combined
  simp_alive_peephole
  sorry
