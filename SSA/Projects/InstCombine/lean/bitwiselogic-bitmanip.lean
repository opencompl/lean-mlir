import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  bitwiselogic-bitmanip
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_or_fshl_before := [llvmfunc|
  llvm.func @test_or_fshl(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32) -> i32 {
    %0 = llvm.intr.fshl(%arg0, %arg1, %arg4)  : (i32, i32, i32) -> i32
    %1 = llvm.intr.fshl(%arg2, %arg3, %arg4)  : (i32, i32, i32) -> i32
    %2 = llvm.or %0, %1  : i32
    llvm.return %2 : i32
  }]

def test_and_fshl_before := [llvmfunc|
  llvm.func @test_and_fshl(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32) -> i32 {
    %0 = llvm.intr.fshl(%arg0, %arg1, %arg4)  : (i32, i32, i32) -> i32
    %1 = llvm.intr.fshl(%arg2, %arg3, %arg4)  : (i32, i32, i32) -> i32
    %2 = llvm.and %0, %1  : i32
    llvm.return %2 : i32
  }]

def test_xor_fshl_before := [llvmfunc|
  llvm.func @test_xor_fshl(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32) -> i32 {
    %0 = llvm.intr.fshl(%arg0, %arg1, %arg4)  : (i32, i32, i32) -> i32
    %1 = llvm.intr.fshl(%arg2, %arg3, %arg4)  : (i32, i32, i32) -> i32
    %2 = llvm.xor %0, %1  : i32
    llvm.return %2 : i32
  }]

def test_or_fshr_before := [llvmfunc|
  llvm.func @test_or_fshr(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32) -> i32 {
    %0 = llvm.intr.fshr(%arg0, %arg1, %arg4)  : (i32, i32, i32) -> i32
    %1 = llvm.intr.fshr(%arg2, %arg3, %arg4)  : (i32, i32, i32) -> i32
    %2 = llvm.or %0, %1  : i32
    llvm.return %2 : i32
  }]

def test_or_fshl_cascade_before := [llvmfunc|
  llvm.func @test_or_fshl_cascade(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.intr.fshl(%arg0, %arg0, %0)  : (i32, i32, i32) -> i32
    %2 = llvm.intr.fshl(%arg1, %arg1, %0)  : (i32, i32, i32) -> i32
    %3 = llvm.intr.fshl(%arg2, %arg2, %0)  : (i32, i32, i32) -> i32
    %4 = llvm.or %1, %2  : i32
    %5 = llvm.or %4, %3  : i32
    llvm.return %5 : i32
  }]

def test_or_bitreverse_before := [llvmfunc|
  llvm.func @test_or_bitreverse(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.bitreverse(%arg0)  : (i32) -> i32
    %1 = llvm.intr.bitreverse(%arg1)  : (i32) -> i32
    %2 = llvm.or %0, %1  : i32
    llvm.return %2 : i32
  }]

def test_or_bitreverse_constant_before := [llvmfunc|
  llvm.func @test_or_bitreverse_constant(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-16777216 : i32) : i32
    %1 = llvm.intr.bitreverse(%arg0)  : (i32) -> i32
    %2 = llvm.or %1, %0  : i32
    llvm.return %2 : i32
  }]

def test_or_bswap_before := [llvmfunc|
  llvm.func @test_or_bswap(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.bswap(%arg0)  : (i32) -> i32
    %1 = llvm.intr.bswap(%arg1)  : (i32) -> i32
    %2 = llvm.or %0, %1  : i32
    llvm.return %2 : i32
  }]

def test_or_bswap_constant_before := [llvmfunc|
  llvm.func @test_or_bswap_constant(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-16777216 : i32) : i32
    %1 = llvm.intr.bswap(%arg0)  : (i32) -> i32
    %2 = llvm.or %1, %0  : i32
    llvm.return %2 : i32
  }]

def test_or_fshl_fshr_before := [llvmfunc|
  llvm.func @test_or_fshl_fshr(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32) -> i32 {
    %0 = llvm.intr.fshl(%arg0, %arg1, %arg4)  : (i32, i32, i32) -> i32
    %1 = llvm.intr.fshr(%arg2, %arg3, %arg4)  : (i32, i32, i32) -> i32
    %2 = llvm.or %0, %1  : i32
    llvm.return %2 : i32
  }]

def test_or_bitreverse_bswap_before := [llvmfunc|
  llvm.func @test_or_bitreverse_bswap(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.bitreverse(%arg0)  : (i32) -> i32
    %1 = llvm.intr.bswap(%arg1)  : (i32) -> i32
    %2 = llvm.or %0, %1  : i32
    llvm.return %2 : i32
  }]

def test_or_fshl_mismatched_shamt_before := [llvmfunc|
  llvm.func @test_or_fshl_mismatched_shamt(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32) -> i32 {
    %0 = llvm.intr.fshl(%arg0, %arg1, %arg4)  : (i32, i32, i32) -> i32
    %1 = llvm.intr.fshl(%arg2, %arg3, %arg5)  : (i32, i32, i32) -> i32
    %2 = llvm.or %0, %1  : i32
    llvm.return %2 : i32
  }]

def test_add_fshl_before := [llvmfunc|
  llvm.func @test_add_fshl(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32) -> i32 {
    %0 = llvm.intr.fshl(%arg0, %arg1, %arg4)  : (i32, i32, i32) -> i32
    %1 = llvm.intr.fshl(%arg2, %arg3, %arg4)  : (i32, i32, i32) -> i32
    %2 = llvm.add %0, %1  : i32
    llvm.return %2 : i32
  }]

def test_or_fshl_multiuse_before := [llvmfunc|
  llvm.func @test_or_fshl_multiuse(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32) -> i32 {
    %0 = llvm.intr.fshl(%arg0, %arg1, %arg4)  : (i32, i32, i32) -> i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.intr.fshl(%arg2, %arg3, %arg4)  : (i32, i32, i32) -> i32
    %2 = llvm.or %0, %1  : i32
    llvm.return %2 : i32
  }]

def test_or_bitreverse_multiuse_before := [llvmfunc|
  llvm.func @test_or_bitreverse_multiuse(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.bitreverse(%arg0)  : (i32) -> i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.intr.bitreverse(%arg1)  : (i32) -> i32
    %2 = llvm.or %0, %1  : i32
    llvm.return %2 : i32
  }]

def test_or_fshl_constant_before := [llvmfunc|
  llvm.func @test_or_fshl_constant(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-16777216 : i32) : i32
    %1 = llvm.intr.fshl(%arg0, %arg1, %arg2)  : (i32, i32, i32) -> i32
    %2 = llvm.or %1, %0  : i32
    llvm.return %2 : i32
  }]

def test_or_fshl_combined := [llvmfunc|
  llvm.func @test_or_fshl(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32) -> i32 {
    %0 = llvm.or %arg0, %arg2  : i32
    %1 = llvm.or %arg1, %arg3  : i32
    %2 = llvm.intr.fshl(%0, %1, %arg4)  : (i32, i32, i32) -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test_or_fshl   : test_or_fshl_before  ⊑  test_or_fshl_combined := by
  unfold test_or_fshl_before test_or_fshl_combined
  simp_alive_peephole
  sorry
def test_and_fshl_combined := [llvmfunc|
  llvm.func @test_and_fshl(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32) -> i32 {
    %0 = llvm.and %arg0, %arg2  : i32
    %1 = llvm.and %arg1, %arg3  : i32
    %2 = llvm.intr.fshl(%0, %1, %arg4)  : (i32, i32, i32) -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test_and_fshl   : test_and_fshl_before  ⊑  test_and_fshl_combined := by
  unfold test_and_fshl_before test_and_fshl_combined
  simp_alive_peephole
  sorry
def test_xor_fshl_combined := [llvmfunc|
  llvm.func @test_xor_fshl(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32) -> i32 {
    %0 = llvm.xor %arg0, %arg2  : i32
    %1 = llvm.xor %arg1, %arg3  : i32
    %2 = llvm.intr.fshl(%0, %1, %arg4)  : (i32, i32, i32) -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test_xor_fshl   : test_xor_fshl_before  ⊑  test_xor_fshl_combined := by
  unfold test_xor_fshl_before test_xor_fshl_combined
  simp_alive_peephole
  sorry
def test_or_fshr_combined := [llvmfunc|
  llvm.func @test_or_fshr(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32) -> i32 {
    %0 = llvm.or %arg0, %arg2  : i32
    %1 = llvm.or %arg1, %arg3  : i32
    %2 = llvm.intr.fshr(%0, %1, %arg4)  : (i32, i32, i32) -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test_or_fshr   : test_or_fshr_before  ⊑  test_or_fshr_combined := by
  unfold test_or_fshr_before test_or_fshr_combined
  simp_alive_peephole
  sorry
def test_or_fshl_cascade_combined := [llvmfunc|
  llvm.func @test_or_fshl_cascade(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.or %arg0, %arg1  : i32
    %3 = llvm.or %1, %arg2  : i32
    %4 = llvm.or %2, %arg2  : i32
    %5 = llvm.intr.fshl(%3, %4, %0)  : (i32, i32, i32) -> i32
    llvm.return %5 : i32
  }]

theorem inst_combine_test_or_fshl_cascade   : test_or_fshl_cascade_before  ⊑  test_or_fshl_cascade_combined := by
  unfold test_or_fshl_cascade_before test_or_fshl_cascade_combined
  simp_alive_peephole
  sorry
def test_or_bitreverse_combined := [llvmfunc|
  llvm.func @test_or_bitreverse(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.or %arg0, %arg1  : i32
    %1 = llvm.intr.bitreverse(%0)  : (i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test_or_bitreverse   : test_or_bitreverse_before  ⊑  test_or_bitreverse_combined := by
  unfold test_or_bitreverse_before test_or_bitreverse_combined
  simp_alive_peephole
  sorry
def test_or_bitreverse_constant_combined := [llvmfunc|
  llvm.func @test_or_bitreverse_constant(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.or %arg0, %0  : i32
    %2 = llvm.intr.bitreverse(%1)  : (i32) -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test_or_bitreverse_constant   : test_or_bitreverse_constant_before  ⊑  test_or_bitreverse_constant_combined := by
  unfold test_or_bitreverse_constant_before test_or_bitreverse_constant_combined
  simp_alive_peephole
  sorry
def test_or_bswap_combined := [llvmfunc|
  llvm.func @test_or_bswap(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.or %arg0, %arg1  : i32
    %1 = llvm.intr.bswap(%0)  : (i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test_or_bswap   : test_or_bswap_before  ⊑  test_or_bswap_combined := by
  unfold test_or_bswap_before test_or_bswap_combined
  simp_alive_peephole
  sorry
def test_or_bswap_constant_combined := [llvmfunc|
  llvm.func @test_or_bswap_constant(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.or %arg0, %0  : i32
    %2 = llvm.intr.bswap(%1)  : (i32) -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test_or_bswap_constant   : test_or_bswap_constant_before  ⊑  test_or_bswap_constant_combined := by
  unfold test_or_bswap_constant_before test_or_bswap_constant_combined
  simp_alive_peephole
  sorry
def test_or_fshl_fshr_combined := [llvmfunc|
  llvm.func @test_or_fshl_fshr(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32) -> i32 {
    %0 = llvm.intr.fshl(%arg0, %arg1, %arg4)  : (i32, i32, i32) -> i32
    %1 = llvm.intr.fshr(%arg2, %arg3, %arg4)  : (i32, i32, i32) -> i32
    %2 = llvm.or %0, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test_or_fshl_fshr   : test_or_fshl_fshr_before  ⊑  test_or_fshl_fshr_combined := by
  unfold test_or_fshl_fshr_before test_or_fshl_fshr_combined
  simp_alive_peephole
  sorry
def test_or_bitreverse_bswap_combined := [llvmfunc|
  llvm.func @test_or_bitreverse_bswap(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.bitreverse(%arg0)  : (i32) -> i32
    %1 = llvm.intr.bswap(%arg1)  : (i32) -> i32
    %2 = llvm.or %0, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test_or_bitreverse_bswap   : test_or_bitreverse_bswap_before  ⊑  test_or_bitreverse_bswap_combined := by
  unfold test_or_bitreverse_bswap_before test_or_bitreverse_bswap_combined
  simp_alive_peephole
  sorry
def test_or_fshl_mismatched_shamt_combined := [llvmfunc|
  llvm.func @test_or_fshl_mismatched_shamt(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32) -> i32 {
    %0 = llvm.intr.fshl(%arg0, %arg1, %arg4)  : (i32, i32, i32) -> i32
    %1 = llvm.intr.fshl(%arg2, %arg3, %arg5)  : (i32, i32, i32) -> i32
    %2 = llvm.or %0, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test_or_fshl_mismatched_shamt   : test_or_fshl_mismatched_shamt_before  ⊑  test_or_fshl_mismatched_shamt_combined := by
  unfold test_or_fshl_mismatched_shamt_before test_or_fshl_mismatched_shamt_combined
  simp_alive_peephole
  sorry
def test_add_fshl_combined := [llvmfunc|
  llvm.func @test_add_fshl(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32) -> i32 {
    %0 = llvm.intr.fshl(%arg0, %arg1, %arg4)  : (i32, i32, i32) -> i32
    %1 = llvm.intr.fshl(%arg2, %arg3, %arg4)  : (i32, i32, i32) -> i32
    %2 = llvm.add %0, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test_add_fshl   : test_add_fshl_before  ⊑  test_add_fshl_combined := by
  unfold test_add_fshl_before test_add_fshl_combined
  simp_alive_peephole
  sorry
def test_or_fshl_multiuse_combined := [llvmfunc|
  llvm.func @test_or_fshl_multiuse(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32) -> i32 {
    %0 = llvm.intr.fshl(%arg0, %arg1, %arg4)  : (i32, i32, i32) -> i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.intr.fshl(%arg2, %arg3, %arg4)  : (i32, i32, i32) -> i32
    %2 = llvm.or %0, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test_or_fshl_multiuse   : test_or_fshl_multiuse_before  ⊑  test_or_fshl_multiuse_combined := by
  unfold test_or_fshl_multiuse_before test_or_fshl_multiuse_combined
  simp_alive_peephole
  sorry
def test_or_bitreverse_multiuse_combined := [llvmfunc|
  llvm.func @test_or_bitreverse_multiuse(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.bitreverse(%arg0)  : (i32) -> i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.intr.bitreverse(%arg1)  : (i32) -> i32
    %2 = llvm.or %0, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test_or_bitreverse_multiuse   : test_or_bitreverse_multiuse_before  ⊑  test_or_bitreverse_multiuse_combined := by
  unfold test_or_bitreverse_multiuse_before test_or_bitreverse_multiuse_combined
  simp_alive_peephole
  sorry
def test_or_fshl_constant_combined := [llvmfunc|
  llvm.func @test_or_fshl_constant(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-16777216 : i32) : i32
    %1 = llvm.intr.fshl(%arg0, %arg1, %arg2)  : (i32, i32, i32) -> i32
    %2 = llvm.or %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test_or_fshl_constant   : test_or_fshl_constant_before  ⊑  test_or_fshl_constant_combined := by
  unfold test_or_fshl_constant_before test_or_fshl_constant_combined
  simp_alive_peephole
  sorry
