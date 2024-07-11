import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  AddOverFlow
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def oppositesign_before := [llvmfunc|
  llvm.func @oppositesign(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(-32768 : i16) : i16
    %1 = llvm.mlir.constant(32767 : i16) : i16
    %2 = llvm.or %arg0, %0  : i16
    %3 = llvm.and %arg1, %1  : i16
    %4 = llvm.add %2, %3  : i16
    llvm.return %4 : i16
  }]

def zero_sign_bit_before := [llvmfunc|
  llvm.func @zero_sign_bit(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(32767 : i16) : i16
    %1 = llvm.mlir.constant(512 : i16) : i16
    %2 = llvm.and %arg0, %0  : i16
    %3 = llvm.add %2, %1  : i16
    llvm.return %3 : i16
  }]

def zero_sign_bit2_before := [llvmfunc|
  llvm.func @zero_sign_bit2(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(32767 : i16) : i16
    %1 = llvm.and %arg0, %0  : i16
    %2 = llvm.and %arg1, %0  : i16
    %3 = llvm.add %1, %2  : i16
    llvm.return %3 : i16
  }]

def add_bounded_values_before := [llvmfunc|
  llvm.func @add_bounded_values(%arg0: i16, %arg1: i16) -> i16 attributes {personality = @__gxx_personality_v0} {
    %0 = llvm.mlir.undef : !llvm.array<0 x ptr>
    %1 = llvm.mlir.constant(42 : i16) : i16
    %2 = llvm.call @bounded(%arg0) : (i16) -> i16
    %3 = llvm.invoke @bounded(%arg1) to ^bb1 unwind ^bb2 : (i16) -> i16
  ^bb1:  // pred: ^bb0
    %4 = llvm.add %2, %3  : i16
    llvm.return %4 : i16
  ^bb2:  // pred: ^bb0
    %5 = llvm.landingpad (filter %0 : !llvm.array<0 x ptr>) : !llvm.struct<(ptr, i32)>
    llvm.return %1 : i16
  }]

def add_bounded_values_2_before := [llvmfunc|
  llvm.func @add_bounded_values_2(%arg0: i16, %arg1: i16) -> i16 attributes {personality = @__gxx_personality_v0} {
    %0 = llvm.mlir.undef : !llvm.array<0 x ptr>
    %1 = llvm.mlir.constant(42 : i16) : i16
    %2 = llvm.call @bounded(%arg0) : (i16) -> i16
    %3 = llvm.invoke @bounded(%arg1) to ^bb1 unwind ^bb2 : (i16) -> i16
  ^bb1:  // pred: ^bb0
    %4 = llvm.add %2, %3  : i16
    llvm.return %4 : i16
  ^bb2:  // pred: ^bb0
    %5 = llvm.landingpad (filter %0 : !llvm.array<0 x ptr>) : !llvm.struct<(ptr, i32)>
    llvm.return %1 : i16
  }]

def ripple_nsw1_before := [llvmfunc|
  llvm.func @ripple_nsw1(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.mlir.constant(-16385 : i16) : i16
    %2 = llvm.and %arg1, %0  : i16
    %3 = llvm.and %arg0, %1  : i16
    %4 = llvm.add %2, %3  : i16
    llvm.return %4 : i16
  }]

def ripple_nsw2_before := [llvmfunc|
  llvm.func @ripple_nsw2(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.mlir.constant(-16385 : i16) : i16
    %2 = llvm.and %arg1, %0  : i16
    %3 = llvm.and %arg0, %1  : i16
    %4 = llvm.add %3, %2  : i16
    llvm.return %4 : i16
  }]

def ripple_nsw3_before := [llvmfunc|
  llvm.func @ripple_nsw3(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(-21845 : i16) : i16
    %1 = llvm.mlir.constant(21843 : i16) : i16
    %2 = llvm.and %arg1, %0  : i16
    %3 = llvm.and %arg0, %1  : i16
    %4 = llvm.add %2, %3  : i16
    llvm.return %4 : i16
  }]

def ripple_nsw4_before := [llvmfunc|
  llvm.func @ripple_nsw4(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(-21845 : i16) : i16
    %1 = llvm.mlir.constant(21843 : i16) : i16
    %2 = llvm.and %arg1, %0  : i16
    %3 = llvm.and %arg0, %1  : i16
    %4 = llvm.add %3, %2  : i16
    llvm.return %4 : i16
  }]

def ripple_nsw5_before := [llvmfunc|
  llvm.func @ripple_nsw5(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(-21845 : i16) : i16
    %1 = llvm.mlir.constant(-10923 : i16) : i16
    %2 = llvm.or %arg1, %0  : i16
    %3 = llvm.or %arg0, %1  : i16
    %4 = llvm.add %2, %3  : i16
    llvm.return %4 : i16
  }]

def ripple_nsw6_before := [llvmfunc|
  llvm.func @ripple_nsw6(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(-21845 : i16) : i16
    %1 = llvm.mlir.constant(-10923 : i16) : i16
    %2 = llvm.or %arg1, %0  : i16
    %3 = llvm.or %arg0, %1  : i16
    %4 = llvm.add %3, %2  : i16
    llvm.return %4 : i16
  }]

def ripple_no_nsw1_before := [llvmfunc|
  llvm.func @ripple_no_nsw1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.and %arg1, %0  : i32
    %2 = llvm.add %1, %arg0  : i32
    llvm.return %2 : i32
  }]

def ripple_no_nsw2_before := [llvmfunc|
  llvm.func @ripple_no_nsw2(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.mlir.constant(32767 : i16) : i16
    %2 = llvm.and %arg1, %0  : i16
    %3 = llvm.and %arg0, %1  : i16
    %4 = llvm.add %2, %3  : i16
    llvm.return %4 : i16
  }]

def ripple_no_nsw3_before := [llvmfunc|
  llvm.func @ripple_no_nsw3(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(-21845 : i16) : i16
    %1 = llvm.mlir.constant(21845 : i16) : i16
    %2 = llvm.and %arg1, %0  : i16
    %3 = llvm.and %arg0, %1  : i16
    %4 = llvm.add %2, %3  : i16
    llvm.return %4 : i16
  }]

def ripple_no_nsw4_before := [llvmfunc|
  llvm.func @ripple_no_nsw4(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(-21845 : i16) : i16
    %1 = llvm.mlir.constant(21845 : i16) : i16
    %2 = llvm.and %arg1, %0  : i16
    %3 = llvm.and %arg0, %1  : i16
    %4 = llvm.add %3, %2  : i16
    llvm.return %4 : i16
  }]

def ripple_no_nsw5_before := [llvmfunc|
  llvm.func @ripple_no_nsw5(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(-21847 : i16) : i16
    %1 = llvm.mlir.constant(-10923 : i16) : i16
    %2 = llvm.or %arg1, %0  : i16
    %3 = llvm.or %arg0, %1  : i16
    %4 = llvm.add %2, %3  : i16
    llvm.return %4 : i16
  }]

def ripple_no_nsw6_before := [llvmfunc|
  llvm.func @ripple_no_nsw6(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(-21847 : i16) : i16
    %1 = llvm.mlir.constant(-10923 : i16) : i16
    %2 = llvm.or %arg1, %0  : i16
    %3 = llvm.or %arg0, %1  : i16
    %4 = llvm.add %3, %2  : i16
    llvm.return %4 : i16
  }]

def PR38021_before := [llvmfunc|
  llvm.func @PR38021(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(-63 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.add %2, %1  : i8
    llvm.return %3 : i8
  }]

def oppositesign_combined := [llvmfunc|
  llvm.func @oppositesign(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(-32768 : i16) : i16
    %1 = llvm.mlir.constant(32767 : i16) : i16
    %2 = llvm.or %arg0, %0  : i16
    %3 = llvm.and %arg1, %1  : i16
    %4 = llvm.add %2, %3 overflow<nsw>  : i16
    llvm.return %4 : i16
  }]

theorem inst_combine_oppositesign   : oppositesign_before  ⊑  oppositesign_combined := by
  unfold oppositesign_before oppositesign_combined
  simp_alive_peephole
  sorry
def zero_sign_bit_combined := [llvmfunc|
  llvm.func @zero_sign_bit(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(32767 : i16) : i16
    %1 = llvm.mlir.constant(512 : i16) : i16
    %2 = llvm.and %arg0, %0  : i16
    %3 = llvm.add %2, %1 overflow<nuw>  : i16
    llvm.return %3 : i16
  }]

theorem inst_combine_zero_sign_bit   : zero_sign_bit_before  ⊑  zero_sign_bit_combined := by
  unfold zero_sign_bit_before zero_sign_bit_combined
  simp_alive_peephole
  sorry
def zero_sign_bit2_combined := [llvmfunc|
  llvm.func @zero_sign_bit2(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(32767 : i16) : i16
    %1 = llvm.and %arg0, %0  : i16
    %2 = llvm.and %arg1, %0  : i16
    %3 = llvm.add %1, %2 overflow<nuw>  : i16
    llvm.return %3 : i16
  }]

theorem inst_combine_zero_sign_bit2   : zero_sign_bit2_before  ⊑  zero_sign_bit2_combined := by
  unfold zero_sign_bit2_before zero_sign_bit2_combined
  simp_alive_peephole
  sorry
def add_bounded_values_combined := [llvmfunc|
  llvm.func @add_bounded_values(%arg0: i16, %arg1: i16) -> i16 attributes {personality = @__gxx_personality_v0} {
    %0 = llvm.mlir.undef : !llvm.array<0 x ptr>
    %1 = llvm.mlir.constant(42 : i16) : i16
    %2 = llvm.call @bounded(%arg0) : (i16) -> i16
    %3 = llvm.invoke @bounded(%arg1) to ^bb1 unwind ^bb2 : (i16) -> i16
  ^bb1:  // pred: ^bb0
    %4 = llvm.add %2, %3 overflow<nuw>  : i16
    llvm.return %4 : i16
  ^bb2:  // pred: ^bb0
    %5 = llvm.landingpad (filter %0 : !llvm.array<0 x ptr>) : !llvm.struct<(ptr, i32)>
    llvm.return %1 : i16
  }]

theorem inst_combine_add_bounded_values   : add_bounded_values_before  ⊑  add_bounded_values_combined := by
  unfold add_bounded_values_before add_bounded_values_combined
  simp_alive_peephole
  sorry
def add_bounded_values_2_combined := [llvmfunc|
  llvm.func @add_bounded_values_2(%arg0: i16, %arg1: i16) -> i16 attributes {personality = @__gxx_personality_v0} {
    %0 = llvm.mlir.undef : !llvm.array<0 x ptr>
    %1 = llvm.mlir.constant(42 : i16) : i16
    %2 = llvm.call @bounded(%arg0) : (i16) -> i16
    %3 = llvm.invoke @bounded(%arg1) to ^bb1 unwind ^bb2 : (i16) -> i16
  ^bb1:  // pred: ^bb0
    %4 = llvm.add %2, %3  : i16
    llvm.return %4 : i16
  ^bb2:  // pred: ^bb0
    %5 = llvm.landingpad (filter %0 : !llvm.array<0 x ptr>) : !llvm.struct<(ptr, i32)>
    llvm.return %1 : i16
  }]

theorem inst_combine_add_bounded_values_2   : add_bounded_values_2_before  ⊑  add_bounded_values_2_combined := by
  unfold add_bounded_values_2_before add_bounded_values_2_combined
  simp_alive_peephole
  sorry
def ripple_nsw1_combined := [llvmfunc|
  llvm.func @ripple_nsw1(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.mlir.constant(-16385 : i16) : i16
    %2 = llvm.and %arg1, %0  : i16
    %3 = llvm.and %arg0, %1  : i16
    %4 = llvm.add %2, %3 overflow<nsw, nuw>  : i16
    llvm.return %4 : i16
  }]

theorem inst_combine_ripple_nsw1   : ripple_nsw1_before  ⊑  ripple_nsw1_combined := by
  unfold ripple_nsw1_before ripple_nsw1_combined
  simp_alive_peephole
  sorry
def ripple_nsw2_combined := [llvmfunc|
  llvm.func @ripple_nsw2(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.mlir.constant(-16385 : i16) : i16
    %2 = llvm.and %arg1, %0  : i16
    %3 = llvm.and %arg0, %1  : i16
    %4 = llvm.add %3, %2 overflow<nsw, nuw>  : i16
    llvm.return %4 : i16
  }]

theorem inst_combine_ripple_nsw2   : ripple_nsw2_before  ⊑  ripple_nsw2_combined := by
  unfold ripple_nsw2_before ripple_nsw2_combined
  simp_alive_peephole
  sorry
def ripple_nsw3_combined := [llvmfunc|
  llvm.func @ripple_nsw3(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(-21845 : i16) : i16
    %1 = llvm.mlir.constant(21843 : i16) : i16
    %2 = llvm.and %arg1, %0  : i16
    %3 = llvm.and %arg0, %1  : i16
    %4 = llvm.add %2, %3 overflow<nsw, nuw>  : i16
    llvm.return %4 : i16
  }]

theorem inst_combine_ripple_nsw3   : ripple_nsw3_before  ⊑  ripple_nsw3_combined := by
  unfold ripple_nsw3_before ripple_nsw3_combined
  simp_alive_peephole
  sorry
def ripple_nsw4_combined := [llvmfunc|
  llvm.func @ripple_nsw4(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(-21845 : i16) : i16
    %1 = llvm.mlir.constant(21843 : i16) : i16
    %2 = llvm.and %arg1, %0  : i16
    %3 = llvm.and %arg0, %1  : i16
    %4 = llvm.add %3, %2 overflow<nsw, nuw>  : i16
    llvm.return %4 : i16
  }]

theorem inst_combine_ripple_nsw4   : ripple_nsw4_before  ⊑  ripple_nsw4_combined := by
  unfold ripple_nsw4_before ripple_nsw4_combined
  simp_alive_peephole
  sorry
def ripple_nsw5_combined := [llvmfunc|
  llvm.func @ripple_nsw5(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(-21845 : i16) : i16
    %1 = llvm.mlir.constant(-10923 : i16) : i16
    %2 = llvm.or %arg1, %0  : i16
    %3 = llvm.or %arg0, %1  : i16
    %4 = llvm.add %2, %3 overflow<nsw>  : i16
    llvm.return %4 : i16
  }]

theorem inst_combine_ripple_nsw5   : ripple_nsw5_before  ⊑  ripple_nsw5_combined := by
  unfold ripple_nsw5_before ripple_nsw5_combined
  simp_alive_peephole
  sorry
def ripple_nsw6_combined := [llvmfunc|
  llvm.func @ripple_nsw6(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(-21845 : i16) : i16
    %1 = llvm.mlir.constant(-10923 : i16) : i16
    %2 = llvm.or %arg1, %0  : i16
    %3 = llvm.or %arg0, %1  : i16
    %4 = llvm.add %3, %2 overflow<nsw>  : i16
    llvm.return %4 : i16
  }]

theorem inst_combine_ripple_nsw6   : ripple_nsw6_before  ⊑  ripple_nsw6_combined := by
  unfold ripple_nsw6_before ripple_nsw6_combined
  simp_alive_peephole
  sorry
def ripple_no_nsw1_combined := [llvmfunc|
  llvm.func @ripple_no_nsw1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.and %arg1, %0  : i32
    %2 = llvm.add %1, %arg0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_ripple_no_nsw1   : ripple_no_nsw1_before  ⊑  ripple_no_nsw1_combined := by
  unfold ripple_no_nsw1_before ripple_no_nsw1_combined
  simp_alive_peephole
  sorry
def ripple_no_nsw2_combined := [llvmfunc|
  llvm.func @ripple_no_nsw2(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.mlir.constant(32767 : i16) : i16
    %2 = llvm.and %arg1, %0  : i16
    %3 = llvm.and %arg0, %1  : i16
    %4 = llvm.add %2, %3 overflow<nuw>  : i16
    llvm.return %4 : i16
  }]

theorem inst_combine_ripple_no_nsw2   : ripple_no_nsw2_before  ⊑  ripple_no_nsw2_combined := by
  unfold ripple_no_nsw2_before ripple_no_nsw2_combined
  simp_alive_peephole
  sorry
def ripple_no_nsw3_combined := [llvmfunc|
  llvm.func @ripple_no_nsw3(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(-21845 : i16) : i16
    %1 = llvm.mlir.constant(21845 : i16) : i16
    %2 = llvm.and %arg1, %0  : i16
    %3 = llvm.and %arg0, %1  : i16
    %4 = llvm.add %2, %3  : i16
    llvm.return %4 : i16
  }]

theorem inst_combine_ripple_no_nsw3   : ripple_no_nsw3_before  ⊑  ripple_no_nsw3_combined := by
  unfold ripple_no_nsw3_before ripple_no_nsw3_combined
  simp_alive_peephole
  sorry
def ripple_no_nsw4_combined := [llvmfunc|
  llvm.func @ripple_no_nsw4(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(-21845 : i16) : i16
    %1 = llvm.mlir.constant(21845 : i16) : i16
    %2 = llvm.and %arg1, %0  : i16
    %3 = llvm.and %arg0, %1  : i16
    %4 = llvm.add %3, %2  : i16
    llvm.return %4 : i16
  }]

theorem inst_combine_ripple_no_nsw4   : ripple_no_nsw4_before  ⊑  ripple_no_nsw4_combined := by
  unfold ripple_no_nsw4_before ripple_no_nsw4_combined
  simp_alive_peephole
  sorry
def ripple_no_nsw5_combined := [llvmfunc|
  llvm.func @ripple_no_nsw5(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(-21847 : i16) : i16
    %1 = llvm.mlir.constant(-10923 : i16) : i16
    %2 = llvm.or %arg1, %0  : i16
    %3 = llvm.or %arg0, %1  : i16
    %4 = llvm.add %2, %3  : i16
    llvm.return %4 : i16
  }]

theorem inst_combine_ripple_no_nsw5   : ripple_no_nsw5_before  ⊑  ripple_no_nsw5_combined := by
  unfold ripple_no_nsw5_before ripple_no_nsw5_combined
  simp_alive_peephole
  sorry
def ripple_no_nsw6_combined := [llvmfunc|
  llvm.func @ripple_no_nsw6(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(-21847 : i16) : i16
    %1 = llvm.mlir.constant(-10923 : i16) : i16
    %2 = llvm.or %arg1, %0  : i16
    %3 = llvm.or %arg0, %1  : i16
    %4 = llvm.add %3, %2  : i16
    llvm.return %4 : i16
  }]

theorem inst_combine_ripple_no_nsw6   : ripple_no_nsw6_before  ⊑  ripple_no_nsw6_combined := by
  unfold ripple_no_nsw6_before ripple_no_nsw6_combined
  simp_alive_peephole
  sorry
def PR38021_combined := [llvmfunc|
  llvm.func @PR38021(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(-63 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.add %2, %1 overflow<nsw, nuw>  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_PR38021   : PR38021_before  ⊑  PR38021_combined := by
  unfold PR38021_before PR38021_combined
  simp_alive_peephole
  sorry
