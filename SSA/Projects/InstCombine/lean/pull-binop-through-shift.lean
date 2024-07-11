import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pull-binop-through-shift
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def and_signbit_shl_before := [llvmfunc|
  llvm.func @and_signbit_shl(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-65536 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.shl %2, %1  : i32
    llvm.return %3 : i32
  }]

def and_nosignbit_shl_before := [llvmfunc|
  llvm.func @and_nosignbit_shl(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2147418112 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.shl %2, %1  : i32
    llvm.return %3 : i32
  }]

def or_signbit_shl_before := [llvmfunc|
  llvm.func @or_signbit_shl(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-65536 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.shl %2, %1  : i32
    llvm.return %3 : i32
  }]

def or_nosignbit_shl_before := [llvmfunc|
  llvm.func @or_nosignbit_shl(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2147418112 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.shl %2, %1  : i32
    llvm.return %3 : i32
  }]

def xor_signbit_shl_before := [llvmfunc|
  llvm.func @xor_signbit_shl(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-65536 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.shl %2, %1  : i32
    llvm.return %3 : i32
  }]

def xor_nosignbit_shl_before := [llvmfunc|
  llvm.func @xor_nosignbit_shl(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2147418112 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.shl %2, %1  : i32
    llvm.return %3 : i32
  }]

def add_signbit_shl_before := [llvmfunc|
  llvm.func @add_signbit_shl(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-65536 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.shl %2, %1  : i32
    llvm.return %3 : i32
  }]

def add_nosignbit_shl_before := [llvmfunc|
  llvm.func @add_nosignbit_shl(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2147418112 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.shl %2, %1  : i32
    llvm.return %3 : i32
  }]

def and_signbit_lshr_before := [llvmfunc|
  llvm.func @and_signbit_lshr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-65536 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }]

def and_nosignbit_lshr_before := [llvmfunc|
  llvm.func @and_nosignbit_lshr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2147418112 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }]

def or_signbit_lshr_before := [llvmfunc|
  llvm.func @or_signbit_lshr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-65536 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }]

def or_nosignbit_lshr_before := [llvmfunc|
  llvm.func @or_nosignbit_lshr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2147418112 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }]

def xor_signbit_lshr_before := [llvmfunc|
  llvm.func @xor_signbit_lshr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-65536 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }]

def xor_nosignbit_lshr_before := [llvmfunc|
  llvm.func @xor_nosignbit_lshr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2147418112 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }]

def add_signbit_lshr_before := [llvmfunc|
  llvm.func @add_signbit_lshr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-65536 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }]

def add_nosignbit_lshr_before := [llvmfunc|
  llvm.func @add_nosignbit_lshr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2147418112 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }]

def and_signbit_ashr_before := [llvmfunc|
  llvm.func @and_signbit_ashr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-65536 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.ashr %2, %1  : i32
    llvm.return %3 : i32
  }]

def and_nosignbit_ashr_before := [llvmfunc|
  llvm.func @and_nosignbit_ashr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2147418112 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.ashr %2, %1  : i32
    llvm.return %3 : i32
  }]

def or_signbit_ashr_before := [llvmfunc|
  llvm.func @or_signbit_ashr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-65536 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.ashr %2, %1  : i32
    llvm.return %3 : i32
  }]

def or_nosignbit_ashr_before := [llvmfunc|
  llvm.func @or_nosignbit_ashr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2147418112 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.ashr %2, %1  : i32
    llvm.return %3 : i32
  }]

def xor_signbit_ashr_before := [llvmfunc|
  llvm.func @xor_signbit_ashr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-65536 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.ashr %2, %1  : i32
    llvm.return %3 : i32
  }]

def xor_nosignbit_ashr_before := [llvmfunc|
  llvm.func @xor_nosignbit_ashr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2147418112 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.ashr %2, %1  : i32
    llvm.return %3 : i32
  }]

def add_signbit_ashr_before := [llvmfunc|
  llvm.func @add_signbit_ashr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-65536 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.ashr %2, %1  : i32
    llvm.return %3 : i32
  }]

def add_nosignbit_ashr_before := [llvmfunc|
  llvm.func @add_nosignbit_ashr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2147418112 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.ashr %2, %1  : i32
    llvm.return %3 : i32
  }]

def and_signbit_shl_combined := [llvmfunc|
  llvm.func @and_signbit_shl(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(-16777216 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_and_signbit_shl   : and_signbit_shl_before  ⊑  and_signbit_shl_combined := by
  unfold and_signbit_shl_before and_signbit_shl_combined
  simp_alive_peephole
  sorry
def and_nosignbit_shl_combined := [llvmfunc|
  llvm.func @and_nosignbit_shl(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(-16777216 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_and_nosignbit_shl   : and_nosignbit_shl_before  ⊑  and_nosignbit_shl_combined := by
  unfold and_nosignbit_shl_before and_nosignbit_shl_combined
  simp_alive_peephole
  sorry
def or_signbit_shl_combined := [llvmfunc|
  llvm.func @or_signbit_shl(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(-16777216 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.or %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_or_signbit_shl   : or_signbit_shl_before  ⊑  or_signbit_shl_combined := by
  unfold or_signbit_shl_before or_signbit_shl_combined
  simp_alive_peephole
  sorry
def or_nosignbit_shl_combined := [llvmfunc|
  llvm.func @or_nosignbit_shl(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(-16777216 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.or %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_or_nosignbit_shl   : or_nosignbit_shl_before  ⊑  or_nosignbit_shl_combined := by
  unfold or_nosignbit_shl_before or_nosignbit_shl_combined
  simp_alive_peephole
  sorry
def xor_signbit_shl_combined := [llvmfunc|
  llvm.func @xor_signbit_shl(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(-16777216 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.xor %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_xor_signbit_shl   : xor_signbit_shl_before  ⊑  xor_signbit_shl_combined := by
  unfold xor_signbit_shl_before xor_signbit_shl_combined
  simp_alive_peephole
  sorry
def xor_nosignbit_shl_combined := [llvmfunc|
  llvm.func @xor_nosignbit_shl(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(-16777216 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.xor %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_xor_nosignbit_shl   : xor_nosignbit_shl_before  ⊑  xor_nosignbit_shl_combined := by
  unfold xor_nosignbit_shl_before xor_nosignbit_shl_combined
  simp_alive_peephole
  sorry
def add_signbit_shl_combined := [llvmfunc|
  llvm.func @add_signbit_shl(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(-16777216 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.add %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_add_signbit_shl   : add_signbit_shl_before  ⊑  add_signbit_shl_combined := by
  unfold add_signbit_shl_before add_signbit_shl_combined
  simp_alive_peephole
  sorry
def add_nosignbit_shl_combined := [llvmfunc|
  llvm.func @add_nosignbit_shl(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(-16777216 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.add %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_add_nosignbit_shl   : add_nosignbit_shl_before  ⊑  add_nosignbit_shl_combined := by
  unfold add_nosignbit_shl_before add_nosignbit_shl_combined
  simp_alive_peephole
  sorry
def and_signbit_lshr_combined := [llvmfunc|
  llvm.func @and_signbit_lshr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(16776960 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_and_signbit_lshr   : and_signbit_lshr_before  ⊑  and_signbit_lshr_combined := by
  unfold and_signbit_lshr_before and_signbit_lshr_combined
  simp_alive_peephole
  sorry
def and_nosignbit_lshr_combined := [llvmfunc|
  llvm.func @and_nosignbit_lshr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(8388352 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_and_nosignbit_lshr   : and_nosignbit_lshr_before  ⊑  and_nosignbit_lshr_combined := by
  unfold and_nosignbit_lshr_before and_nosignbit_lshr_combined
  simp_alive_peephole
  sorry
def or_signbit_lshr_combined := [llvmfunc|
  llvm.func @or_signbit_lshr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(16776960 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.or %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_or_signbit_lshr   : or_signbit_lshr_before  ⊑  or_signbit_lshr_combined := by
  unfold or_signbit_lshr_before or_signbit_lshr_combined
  simp_alive_peephole
  sorry
def or_nosignbit_lshr_combined := [llvmfunc|
  llvm.func @or_nosignbit_lshr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(8388352 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.or %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_or_nosignbit_lshr   : or_nosignbit_lshr_before  ⊑  or_nosignbit_lshr_combined := by
  unfold or_nosignbit_lshr_before or_nosignbit_lshr_combined
  simp_alive_peephole
  sorry
def xor_signbit_lshr_combined := [llvmfunc|
  llvm.func @xor_signbit_lshr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(16776960 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.xor %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_xor_signbit_lshr   : xor_signbit_lshr_before  ⊑  xor_signbit_lshr_combined := by
  unfold xor_signbit_lshr_before xor_signbit_lshr_combined
  simp_alive_peephole
  sorry
def xor_nosignbit_lshr_combined := [llvmfunc|
  llvm.func @xor_nosignbit_lshr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(8388352 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.xor %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_xor_nosignbit_lshr   : xor_nosignbit_lshr_before  ⊑  xor_nosignbit_lshr_combined := by
  unfold xor_nosignbit_lshr_before xor_nosignbit_lshr_combined
  simp_alive_peephole
  sorry
def add_signbit_lshr_combined := [llvmfunc|
  llvm.func @add_signbit_lshr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-65536 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_add_signbit_lshr   : add_signbit_lshr_before  ⊑  add_signbit_lshr_combined := by
  unfold add_signbit_lshr_before add_signbit_lshr_combined
  simp_alive_peephole
  sorry
def add_nosignbit_lshr_combined := [llvmfunc|
  llvm.func @add_nosignbit_lshr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2147418112 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_add_nosignbit_lshr   : add_nosignbit_lshr_before  ⊑  add_nosignbit_lshr_combined := by
  unfold add_nosignbit_lshr_before add_nosignbit_lshr_combined
  simp_alive_peephole
  sorry
def and_signbit_ashr_combined := [llvmfunc|
  llvm.func @and_signbit_ashr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(-256 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_and_signbit_ashr   : and_signbit_ashr_before  ⊑  and_signbit_ashr_combined := by
  unfold and_signbit_ashr_before and_signbit_ashr_combined
  simp_alive_peephole
  sorry
def and_nosignbit_ashr_combined := [llvmfunc|
  llvm.func @and_nosignbit_ashr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(8388352 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_and_nosignbit_ashr   : and_nosignbit_ashr_before  ⊑  and_nosignbit_ashr_combined := by
  unfold and_nosignbit_ashr_before and_nosignbit_ashr_combined
  simp_alive_peephole
  sorry
def or_signbit_ashr_combined := [llvmfunc|
  llvm.func @or_signbit_ashr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(-256 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.or %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_or_signbit_ashr   : or_signbit_ashr_before  ⊑  or_signbit_ashr_combined := by
  unfold or_signbit_ashr_before or_signbit_ashr_combined
  simp_alive_peephole
  sorry
def or_nosignbit_ashr_combined := [llvmfunc|
  llvm.func @or_nosignbit_ashr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(8388352 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.or %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_or_nosignbit_ashr   : or_nosignbit_ashr_before  ⊑  or_nosignbit_ashr_combined := by
  unfold or_nosignbit_ashr_before or_nosignbit_ashr_combined
  simp_alive_peephole
  sorry
def xor_signbit_ashr_combined := [llvmfunc|
  llvm.func @xor_signbit_ashr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(-256 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.xor %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_xor_signbit_ashr   : xor_signbit_ashr_before  ⊑  xor_signbit_ashr_combined := by
  unfold xor_signbit_ashr_before xor_signbit_ashr_combined
  simp_alive_peephole
  sorry
def xor_nosignbit_ashr_combined := [llvmfunc|
  llvm.func @xor_nosignbit_ashr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(8388352 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.xor %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_xor_nosignbit_ashr   : xor_nosignbit_ashr_before  ⊑  xor_nosignbit_ashr_combined := by
  unfold xor_nosignbit_ashr_before xor_nosignbit_ashr_combined
  simp_alive_peephole
  sorry
def add_signbit_ashr_combined := [llvmfunc|
  llvm.func @add_signbit_ashr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-65536 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.ashr %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_add_signbit_ashr   : add_signbit_ashr_before  ⊑  add_signbit_ashr_combined := by
  unfold add_signbit_ashr_before add_signbit_ashr_combined
  simp_alive_peephole
  sorry
def add_nosignbit_ashr_combined := [llvmfunc|
  llvm.func @add_nosignbit_ashr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2147418112 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.ashr %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_add_nosignbit_ashr   : add_nosignbit_ashr_before  ⊑  add_nosignbit_ashr_combined := by
  unfold add_nosignbit_ashr_before add_nosignbit_ashr_combined
  simp_alive_peephole
  sorry
