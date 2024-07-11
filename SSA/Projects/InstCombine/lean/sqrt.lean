import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  sqrt
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: f32) -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind", "ssp"]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @sqrt(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: f32) -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind", "ssp"]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @sqrt(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: !llvm.ptr) -> f32 attributes {passthrough = ["nounwind", "ssp", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.mlir.undef : f32
    %2 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %3 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> f32]

    %4 = llvm.fmul %3, %3  : f32
    %5 = llvm.fadd %1, %4  : f32
    %6 = llvm.fpext %5 : f32 to f64
    %7 = llvm.call @sqrt(%6) : (f64) -> f64
    %8 = llvm.call @foo(%7) : (f64) -> i32
    %9 = llvm.fptrunc %7 : f64 to f32
    llvm.return %9 : f32
  }]

def <<INVALID EMPTY SYMBOL>>_before := [llvmfunc|
  llvm.func @<<INVALID EMPTY SYMBOL>>(%arg0: f32) {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @sqrt(%0) : (f64) -> f64
    llvm.return
  }]

def sqrt_call_nnan_f32_before := [llvmfunc|
  llvm.func @sqrt_call_nnan_f32(%arg0: f32) -> f32 {
    %0 = llvm.call @sqrtf(%arg0) {fastmathFlags = #llvm.fastmath<nnan>} : (f32) -> f32]

    llvm.return %0 : f32
  }]

def sqrt_call_nnan_f64_before := [llvmfunc|
  llvm.func @sqrt_call_nnan_f64(%arg0: f64) -> f64 {
    %0 = llvm.call @sqrt(%arg0) {fastmathFlags = #llvm.fastmath<nnan, ninf>} : (f64) -> f64]

    llvm.return %0 : f64
  }]

def sqrt_call_fabs_f32_before := [llvmfunc|
  llvm.func @sqrt_call_fabs_f32(%arg0: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.call @sqrtf(%0) : (f32) -> f32
    llvm.return %1 : f32
  }]

def sqrt_exp_before := [llvmfunc|
  llvm.func @sqrt_exp(%arg0: f64) -> f64 {
    %0 = llvm.intr.exp(%arg0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64]

    %1 = llvm.intr.sqrt(%0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64]

    llvm.return %1 : f64
  }]

def sqrt_exp_2_before := [llvmfunc|
  llvm.func @sqrt_exp_2(%arg0: f64) -> f64 {
    %0 = llvm.call @exp(%arg0) {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64]

    %1 = llvm.call @sqrt(%0) {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64]

    llvm.return %1 : f64
  }]

def sqrt_exp2_before := [llvmfunc|
  llvm.func @sqrt_exp2(%arg0: f64) -> f64 {
    %0 = llvm.call @exp2(%arg0) {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64]

    %1 = llvm.call @sqrt(%0) {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64]

    llvm.return %1 : f64
  }]

def sqrt_exp10_before := [llvmfunc|
  llvm.func @sqrt_exp10(%arg0: f64) -> f64 {
    %0 = llvm.call @exp10(%arg0) {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64]

    %1 = llvm.call @sqrt(%0) {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64]

    llvm.return %1 : f64
  }]

def sqrt_exp_nofast_1_before := [llvmfunc|
  llvm.func @sqrt_exp_nofast_1(%arg0: f64) -> f64 {
    %0 = llvm.intr.exp(%arg0)  : (f64) -> f64
    %1 = llvm.intr.sqrt(%0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64]

    llvm.return %1 : f64
  }]

def sqrt_exp_nofast_2_before := [llvmfunc|
  llvm.func @sqrt_exp_nofast_2(%arg0: f64) -> f64 {
    %0 = llvm.intr.exp(%arg0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64]

    %1 = llvm.intr.sqrt(%0)  : (f64) -> f64
    llvm.return %1 : f64
  }]

def sqrt_exp_merge_constant_before := [llvmfunc|
  llvm.func @sqrt_exp_merge_constant(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+01 : f64) : f64
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f64]

    %2 = llvm.intr.exp(%1)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64]

    %3 = llvm.intr.sqrt(%2)  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : (f64) -> f64]

    llvm.return %3 : f64
  }]

def sqrt_exp_intr_and_libcall_before := [llvmfunc|
  llvm.func @sqrt_exp_intr_and_libcall(%arg0: f64) -> f64 {
    %0 = llvm.call @exp(%arg0) {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64]

    %1 = llvm.intr.sqrt(%0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64]

    llvm.return %1 : f64
  }]

def sqrt_exp_intr_and_libcall_2_before := [llvmfunc|
  llvm.func @sqrt_exp_intr_and_libcall_2(%arg0: f64) -> f64 {
    %0 = llvm.intr.exp(%arg0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64]

    %1 = llvm.call @sqrt(%0) {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64]

    llvm.return %1 : f64
  }]

def sqrt_exp_vec_before := [llvmfunc|
  llvm.func @sqrt_exp_vec(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.intr.exp(%arg0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (vector<2xf32>) -> vector<2xf32>]

    %1 = llvm.intr.sqrt(%0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (vector<2xf32>) -> vector<2xf32>]

    llvm.return %1 : vector<2xf32>
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: f32) -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind", "ssp"]} {
    %0 = llvm.call @sqrtf(%arg0) : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: f32) -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind", "ssp"]} {
    %0 = llvm.call @sqrtf(%arg0) : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: !llvm.ptr) -> f32 attributes {passthrough = ["nounwind", "ssp", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(0x7FF8000000000000 : f64) : f64
    %1 = llvm.call @sqrt(%0) : (f64) -> f64
    %2 = llvm.call @foo(%1) : (f64) -> i32
    %3 = llvm.fptrunc %1 : f64 to f32
    llvm.return %3 : f32
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def <<INVALID EMPTY SYMBOL>>_combined := [llvmfunc|
  llvm.func @<<INVALID EMPTY SYMBOL>>(%arg0: f32) {
    %0 = llvm.call @sqrtf(%arg0) : (f32) -> f32
    llvm.return
  }]

theorem inst_combine_<<INVALID EMPTY SYMBOL>>   : <<INVALID EMPTY SYMBOL>>_before  ⊑  <<INVALID EMPTY SYMBOL>>_combined := by
  unfold <<INVALID EMPTY SYMBOL>>_before <<INVALID EMPTY SYMBOL>>_combined
  simp_alive_peephole
  sorry
def sqrt_call_nnan_f32_combined := [llvmfunc|
  llvm.func @sqrt_call_nnan_f32(%arg0: f32) -> f32 {
    %0 = llvm.call @sqrtf(%arg0) {fastmathFlags = #llvm.fastmath<nnan>} : (f32) -> f32]

theorem inst_combine_sqrt_call_nnan_f32   : sqrt_call_nnan_f32_before  ⊑  sqrt_call_nnan_f32_combined := by
  unfold sqrt_call_nnan_f32_before sqrt_call_nnan_f32_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : f32
  }]

theorem inst_combine_sqrt_call_nnan_f32   : sqrt_call_nnan_f32_before  ⊑  sqrt_call_nnan_f32_combined := by
  unfold sqrt_call_nnan_f32_before sqrt_call_nnan_f32_combined
  simp_alive_peephole
  sorry
def sqrt_call_nnan_f64_combined := [llvmfunc|
  llvm.func @sqrt_call_nnan_f64(%arg0: f64) -> f64 {
    %0 = llvm.call @sqrt(%arg0) {fastmathFlags = #llvm.fastmath<nnan, ninf>} : (f64) -> f64]

theorem inst_combine_sqrt_call_nnan_f64   : sqrt_call_nnan_f64_before  ⊑  sqrt_call_nnan_f64_combined := by
  unfold sqrt_call_nnan_f64_before sqrt_call_nnan_f64_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : f64
  }]

theorem inst_combine_sqrt_call_nnan_f64   : sqrt_call_nnan_f64_before  ⊑  sqrt_call_nnan_f64_combined := by
  unfold sqrt_call_nnan_f64_before sqrt_call_nnan_f64_combined
  simp_alive_peephole
  sorry
def sqrt_call_fabs_f32_combined := [llvmfunc|
  llvm.func @sqrt_call_fabs_f32(%arg0: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.call @sqrtf(%0) : (f32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_sqrt_call_fabs_f32   : sqrt_call_fabs_f32_before  ⊑  sqrt_call_fabs_f32_combined := by
  unfold sqrt_call_fabs_f32_before sqrt_call_fabs_f32_combined
  simp_alive_peephole
  sorry
def sqrt_exp_combined := [llvmfunc|
  llvm.func @sqrt_exp(%arg0: f64) -> f64 {
    %0 = llvm.intr.exp(%arg0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64]

theorem inst_combine_sqrt_exp   : sqrt_exp_before  ⊑  sqrt_exp_combined := by
  unfold sqrt_exp_before sqrt_exp_combined
  simp_alive_peephole
  sorry
    %1 = llvm.intr.sqrt(%0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64]

theorem inst_combine_sqrt_exp   : sqrt_exp_before  ⊑  sqrt_exp_combined := by
  unfold sqrt_exp_before sqrt_exp_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f64
  }]

theorem inst_combine_sqrt_exp   : sqrt_exp_before  ⊑  sqrt_exp_combined := by
  unfold sqrt_exp_before sqrt_exp_combined
  simp_alive_peephole
  sorry
def sqrt_exp_2_combined := [llvmfunc|
  llvm.func @sqrt_exp_2(%arg0: f64) -> f64 {
    %0 = llvm.call @exp(%arg0) {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64]

theorem inst_combine_sqrt_exp_2   : sqrt_exp_2_before  ⊑  sqrt_exp_2_combined := by
  unfold sqrt_exp_2_before sqrt_exp_2_combined
  simp_alive_peephole
  sorry
    %1 = llvm.call @sqrt(%0) {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64]

theorem inst_combine_sqrt_exp_2   : sqrt_exp_2_before  ⊑  sqrt_exp_2_combined := by
  unfold sqrt_exp_2_before sqrt_exp_2_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f64
  }]

theorem inst_combine_sqrt_exp_2   : sqrt_exp_2_before  ⊑  sqrt_exp_2_combined := by
  unfold sqrt_exp_2_before sqrt_exp_2_combined
  simp_alive_peephole
  sorry
def sqrt_exp2_combined := [llvmfunc|
  llvm.func @sqrt_exp2(%arg0: f64) -> f64 {
    %0 = llvm.call @exp2(%arg0) {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64]

theorem inst_combine_sqrt_exp2   : sqrt_exp2_before  ⊑  sqrt_exp2_combined := by
  unfold sqrt_exp2_before sqrt_exp2_combined
  simp_alive_peephole
  sorry
    %1 = llvm.call @sqrt(%0) {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64]

theorem inst_combine_sqrt_exp2   : sqrt_exp2_before  ⊑  sqrt_exp2_combined := by
  unfold sqrt_exp2_before sqrt_exp2_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f64
  }]

theorem inst_combine_sqrt_exp2   : sqrt_exp2_before  ⊑  sqrt_exp2_combined := by
  unfold sqrt_exp2_before sqrt_exp2_combined
  simp_alive_peephole
  sorry
def sqrt_exp10_combined := [llvmfunc|
  llvm.func @sqrt_exp10(%arg0: f64) -> f64 {
    %0 = llvm.call @exp10(%arg0) {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64]

theorem inst_combine_sqrt_exp10   : sqrt_exp10_before  ⊑  sqrt_exp10_combined := by
  unfold sqrt_exp10_before sqrt_exp10_combined
  simp_alive_peephole
  sorry
    %1 = llvm.call @sqrt(%0) {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64]

theorem inst_combine_sqrt_exp10   : sqrt_exp10_before  ⊑  sqrt_exp10_combined := by
  unfold sqrt_exp10_before sqrt_exp10_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f64
  }]

theorem inst_combine_sqrt_exp10   : sqrt_exp10_before  ⊑  sqrt_exp10_combined := by
  unfold sqrt_exp10_before sqrt_exp10_combined
  simp_alive_peephole
  sorry
def sqrt_exp_nofast_1_combined := [llvmfunc|
  llvm.func @sqrt_exp_nofast_1(%arg0: f64) -> f64 {
    %0 = llvm.intr.exp(%arg0)  : (f64) -> f64
    %1 = llvm.intr.sqrt(%0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64]

theorem inst_combine_sqrt_exp_nofast_1   : sqrt_exp_nofast_1_before  ⊑  sqrt_exp_nofast_1_combined := by
  unfold sqrt_exp_nofast_1_before sqrt_exp_nofast_1_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f64
  }]

theorem inst_combine_sqrt_exp_nofast_1   : sqrt_exp_nofast_1_before  ⊑  sqrt_exp_nofast_1_combined := by
  unfold sqrt_exp_nofast_1_before sqrt_exp_nofast_1_combined
  simp_alive_peephole
  sorry
def sqrt_exp_nofast_2_combined := [llvmfunc|
  llvm.func @sqrt_exp_nofast_2(%arg0: f64) -> f64 {
    %0 = llvm.intr.exp(%arg0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64]

theorem inst_combine_sqrt_exp_nofast_2   : sqrt_exp_nofast_2_before  ⊑  sqrt_exp_nofast_2_combined := by
  unfold sqrt_exp_nofast_2_before sqrt_exp_nofast_2_combined
  simp_alive_peephole
  sorry
    %1 = llvm.intr.sqrt(%0)  : (f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_sqrt_exp_nofast_2   : sqrt_exp_nofast_2_before  ⊑  sqrt_exp_nofast_2_combined := by
  unfold sqrt_exp_nofast_2_before sqrt_exp_nofast_2_combined
  simp_alive_peephole
  sorry
def sqrt_exp_merge_constant_combined := [llvmfunc|
  llvm.func @sqrt_exp_merge_constant(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+01 : f64) : f64
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f64]

theorem inst_combine_sqrt_exp_merge_constant   : sqrt_exp_merge_constant_before  ⊑  sqrt_exp_merge_constant_combined := by
  unfold sqrt_exp_merge_constant_before sqrt_exp_merge_constant_combined
  simp_alive_peephole
  sorry
    %2 = llvm.intr.exp(%1)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64]

theorem inst_combine_sqrt_exp_merge_constant   : sqrt_exp_merge_constant_before  ⊑  sqrt_exp_merge_constant_combined := by
  unfold sqrt_exp_merge_constant_before sqrt_exp_merge_constant_combined
  simp_alive_peephole
  sorry
    %3 = llvm.intr.sqrt(%2)  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : (f64) -> f64]

theorem inst_combine_sqrt_exp_merge_constant   : sqrt_exp_merge_constant_before  ⊑  sqrt_exp_merge_constant_combined := by
  unfold sqrt_exp_merge_constant_before sqrt_exp_merge_constant_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : f64
  }]

theorem inst_combine_sqrt_exp_merge_constant   : sqrt_exp_merge_constant_before  ⊑  sqrt_exp_merge_constant_combined := by
  unfold sqrt_exp_merge_constant_before sqrt_exp_merge_constant_combined
  simp_alive_peephole
  sorry
def sqrt_exp_intr_and_libcall_combined := [llvmfunc|
  llvm.func @sqrt_exp_intr_and_libcall(%arg0: f64) -> f64 {
    %0 = llvm.call @exp(%arg0) {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64]

theorem inst_combine_sqrt_exp_intr_and_libcall   : sqrt_exp_intr_and_libcall_before  ⊑  sqrt_exp_intr_and_libcall_combined := by
  unfold sqrt_exp_intr_and_libcall_before sqrt_exp_intr_and_libcall_combined
  simp_alive_peephole
  sorry
    %1 = llvm.intr.sqrt(%0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64]

theorem inst_combine_sqrt_exp_intr_and_libcall   : sqrt_exp_intr_and_libcall_before  ⊑  sqrt_exp_intr_and_libcall_combined := by
  unfold sqrt_exp_intr_and_libcall_before sqrt_exp_intr_and_libcall_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f64
  }]

theorem inst_combine_sqrt_exp_intr_and_libcall   : sqrt_exp_intr_and_libcall_before  ⊑  sqrt_exp_intr_and_libcall_combined := by
  unfold sqrt_exp_intr_and_libcall_before sqrt_exp_intr_and_libcall_combined
  simp_alive_peephole
  sorry
def sqrt_exp_intr_and_libcall_2_combined := [llvmfunc|
  llvm.func @sqrt_exp_intr_and_libcall_2(%arg0: f64) -> f64 {
    %0 = llvm.intr.exp(%arg0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64]

theorem inst_combine_sqrt_exp_intr_and_libcall_2   : sqrt_exp_intr_and_libcall_2_before  ⊑  sqrt_exp_intr_and_libcall_2_combined := by
  unfold sqrt_exp_intr_and_libcall_2_before sqrt_exp_intr_and_libcall_2_combined
  simp_alive_peephole
  sorry
    %1 = llvm.call @sqrt(%0) {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64]

theorem inst_combine_sqrt_exp_intr_and_libcall_2   : sqrt_exp_intr_and_libcall_2_before  ⊑  sqrt_exp_intr_and_libcall_2_combined := by
  unfold sqrt_exp_intr_and_libcall_2_before sqrt_exp_intr_and_libcall_2_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f64
  }]

theorem inst_combine_sqrt_exp_intr_and_libcall_2   : sqrt_exp_intr_and_libcall_2_before  ⊑  sqrt_exp_intr_and_libcall_2_combined := by
  unfold sqrt_exp_intr_and_libcall_2_before sqrt_exp_intr_and_libcall_2_combined
  simp_alive_peephole
  sorry
def sqrt_exp_vec_combined := [llvmfunc|
  llvm.func @sqrt_exp_vec(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.intr.exp(%arg0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (vector<2xf32>) -> vector<2xf32>]

theorem inst_combine_sqrt_exp_vec   : sqrt_exp_vec_before  ⊑  sqrt_exp_vec_combined := by
  unfold sqrt_exp_vec_before sqrt_exp_vec_combined
  simp_alive_peephole
  sorry
    %1 = llvm.intr.sqrt(%0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (vector<2xf32>) -> vector<2xf32>]

theorem inst_combine_sqrt_exp_vec   : sqrt_exp_vec_before  ⊑  sqrt_exp_vec_combined := by
  unfold sqrt_exp_vec_before sqrt_exp_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : vector<2xf32>
  }]

theorem inst_combine_sqrt_exp_vec   : sqrt_exp_vec_before  ⊑  sqrt_exp_vec_combined := by
  unfold sqrt_exp_vec_before sqrt_exp_vec_combined
  simp_alive_peephole
  sorry
