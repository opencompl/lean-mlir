import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  masked_intrinsics-inseltpoison
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def load_zeromask_before := [llvmfunc|
  llvm.func @load_zeromask(%arg0: !llvm.ptr, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.intr.masked.load %arg0, %1, %arg1 {alignment = 1 : i32} : (!llvm.ptr, vector<2xi1>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %3 : vector<2xf64>
  }]

def load_onemask_before := [llvmfunc|
  llvm.func @load_onemask(%arg0: !llvm.ptr, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.intr.masked.load %arg0, %1, %arg1 {alignment = 2 : i32} : (!llvm.ptr, vector<2xi1>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %3 : vector<2xf64>
  }]

def load_undefmask_before := [llvmfunc|
  llvm.func @load_undefmask(%arg0: !llvm.ptr, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.undef : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.undef : vector<2xi1>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi1>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi1>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.intr.masked.load %arg0, %6, %arg1 {alignment = 2 : i32} : (!llvm.ptr, vector<2xi1>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %8 : vector<2xf64>
  }]

def load_cemask_before := [llvmfunc|
  llvm.func @load_cemask(%arg0: !llvm.ptr, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.addressof @G : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i1
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.undef : vector<2xi1>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi1>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi1>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.intr.masked.load %arg0, %7, %arg1 {alignment = 2 : i32} : (!llvm.ptr, vector<2xi1>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %9 : vector<2xf64>
  }]

def load_lane0_before := [llvmfunc|
  llvm.func @load_lane0(%arg0: !llvm.ptr, %arg1: f64) -> vector<2xf64> {
    %0 = llvm.mlir.poison : vector<2xf64>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.mlir.constant(true) : i1
    %5 = llvm.mlir.constant(dense<[true, false]> : vector<2xi1>) : vector<2xi1>
    %6 = llvm.mlir.constant(2 : i32) : i32
    %7 = llvm.insertelement %arg1, %0[%1 : i64] : vector<2xf64>
    %8 = llvm.insertelement %arg1, %7[%2 : i64] : vector<2xf64>
    %9 = llvm.intr.masked.load %arg0, %5, %8 {alignment = 2 : i32} : (!llvm.ptr, vector<2xi1>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %9 : vector<2xf64>
  }]

def load_all_before := [llvmfunc|
  llvm.func @load_all(%arg0: !llvm.ptr, %arg1: f64) -> f64 {
    %0 = llvm.mlir.constant(dense<[0, 1, 2, 3]> : vector<4xi64>) : vector<4xi64>
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(dense<[true, false, true, true]> : vector<4xi1>) : vector<4xi1>
    %4 = llvm.mlir.undef : vector<4xf64>
    %5 = llvm.mlir.constant(4 : i32) : i32
    %6 = llvm.mlir.constant(2 : i64) : i64
    %7 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, vector<4xi64>) -> !llvm.vec<4 x ptr>, f64
    %8 = llvm.intr.masked.gather %7, %3, %4 {alignment = 4 : i32} : (!llvm.vec<4 x ptr>, vector<4xi1>, vector<4xf64>) -> vector<4xf64>]

    %9 = llvm.extractelement %8[%6 : i64] : vector<4xf64>
    llvm.return %9 : f64
  }]

def load_generic_before := [llvmfunc|
  llvm.func @load_generic(%arg0: !llvm.ptr, %arg1: f64, %arg2: vector<2xi1>) -> vector<2xf64> {
    %0 = llvm.mlir.poison : vector<2xf64>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(4 : i32) : i32
    %4 = llvm.insertelement %arg1, %0[%1 : i64] : vector<2xf64>
    %5 = llvm.insertelement %arg1, %4[%2 : i64] : vector<2xf64>
    %6 = llvm.intr.masked.load %arg0, %arg2, %5 {alignment = 4 : i32} : (!llvm.ptr, vector<2xi1>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %6 : vector<2xf64>
  }]

def load_speculative_before := [llvmfunc|
  llvm.func @load_speculative(%arg0: !llvm.ptr {llvm.align = 4 : i64, llvm.dereferenceable = 16 : i64}, %arg1: f64, %arg2: vector<2xi1>) -> vector<2xf64> attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.poison : vector<2xf64>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(4 : i32) : i32
    %4 = llvm.insertelement %arg1, %0[%1 : i64] : vector<2xf64>
    %5 = llvm.insertelement %arg1, %4[%2 : i64] : vector<2xf64>
    %6 = llvm.intr.masked.load %arg0, %arg2, %5 {alignment = 4 : i32} : (!llvm.ptr, vector<2xi1>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %6 : vector<2xf64>
  }]

def load_speculative_less_aligned_before := [llvmfunc|
  llvm.func @load_speculative_less_aligned(%arg0: !llvm.ptr {llvm.dereferenceable = 16 : i64}, %arg1: f64, %arg2: vector<2xi1>) -> vector<2xf64> attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.poison : vector<2xf64>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(4 : i32) : i32
    %4 = llvm.insertelement %arg1, %0[%1 : i64] : vector<2xf64>
    %5 = llvm.insertelement %arg1, %4[%2 : i64] : vector<2xf64>
    %6 = llvm.intr.masked.load %arg0, %arg2, %5 {alignment = 4 : i32} : (!llvm.ptr, vector<2xi1>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %6 : vector<2xf64>
  }]

def load_spec_neg_size_before := [llvmfunc|
  llvm.func @load_spec_neg_size(%arg0: !llvm.ptr {llvm.dereferenceable = 8 : i64}, %arg1: f64, %arg2: vector<2xi1>) -> vector<2xf64> attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.poison : vector<2xf64>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(4 : i32) : i32
    %4 = llvm.insertelement %arg1, %0[%1 : i64] : vector<2xf64>
    %5 = llvm.insertelement %arg1, %4[%2 : i64] : vector<2xf64>
    %6 = llvm.intr.masked.load %arg0, %arg2, %5 {alignment = 4 : i32} : (!llvm.ptr, vector<2xi1>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %6 : vector<2xf64>
  }]

def load_spec_lan0_before := [llvmfunc|
  llvm.func @load_spec_lan0(%arg0: !llvm.ptr {llvm.dereferenceable = 8 : i64}, %arg1: f64, %arg2: vector<2xi1>) -> vector<2xf64> attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.poison : vector<2xf64>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.mlir.constant(4 : i32) : i32
    %5 = llvm.insertelement %arg1, %0[%1 : i64] : vector<2xf64>
    %6 = llvm.insertelement %arg1, %5[%2 : i64] : vector<2xf64>
    %7 = llvm.insertelement %3, %arg2[%2 : i64] : vector<2xi1>
    %8 = llvm.intr.masked.load %arg0, %7, %6 {alignment = 4 : i32} : (!llvm.ptr, vector<2xi1>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %8 : vector<2xf64>
  }]

def store_zeromask_before := [llvmfunc|
  llvm.func @store_zeromask(%arg0: !llvm.ptr, %arg1: vector<2xf64>) {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(4 : i32) : i32
    llvm.intr.masked.store %arg1, %arg0, %1 {alignment = 4 : i32} : vector<2xf64>, vector<2xi1> into !llvm.ptr]

    llvm.return
  }]

def store_onemask_before := [llvmfunc|
  llvm.func @store_onemask(%arg0: !llvm.ptr, %arg1: vector<2xf64>) {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(4 : i32) : i32
    llvm.intr.masked.store %arg1, %arg0, %1 {alignment = 4 : i32} : vector<2xf64>, vector<2xi1> into !llvm.ptr]

    llvm.return
  }]

def store_demandedelts_before := [llvmfunc|
  llvm.func @store_demandedelts(%arg0: !llvm.ptr, %arg1: f64) {
    %0 = llvm.mlir.poison : vector<2xf64>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.mlir.constant(true) : i1
    %5 = llvm.mlir.constant(dense<[true, false]> : vector<2xi1>) : vector<2xi1>
    %6 = llvm.mlir.constant(4 : i32) : i32
    %7 = llvm.insertelement %arg1, %0[%1 : i32] : vector<2xf64>
    %8 = llvm.insertelement %arg1, %7[%2 : i32] : vector<2xf64>
    llvm.intr.masked.store %8, %arg0, %5 {alignment = 4 : i32} : vector<2xf64>, vector<2xi1> into !llvm.ptr]

    llvm.return
  }]

def gather_generic_before := [llvmfunc|
  llvm.func @gather_generic(%arg0: !llvm.vec<2 x ptr>, %arg1: vector<2xi1>, %arg2: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.intr.masked.gather %arg0, %arg1, %arg2 {alignment = 4 : i32} : (!llvm.vec<2 x ptr>, vector<2xi1>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %1 : vector<2xf64>
  }]

def gather_zeromask_before := [llvmfunc|
  llvm.func @gather_zeromask(%arg0: !llvm.vec<2 x ptr>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.intr.masked.gather %arg0, %1, %arg1 {alignment = 4 : i32} : (!llvm.vec<2 x ptr>, vector<2xi1>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %3 : vector<2xf64>
  }]

def gather_onemask_before := [llvmfunc|
  llvm.func @gather_onemask(%arg0: !llvm.vec<2 x ptr>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.intr.masked.gather %arg0, %1, %arg1 {alignment = 4 : i32} : (!llvm.vec<2 x ptr>, vector<2xi1>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %3 : vector<2xf64>
  }]

def gather_lane2_before := [llvmfunc|
  llvm.func @gather_lane2(%arg0: !llvm.ptr, %arg1: f64) -> vector<4xf64> {
    %0 = llvm.mlir.constant(dense<[0, 1, 2, 3]> : vector<4xi64>) : vector<4xi64>
    %1 = llvm.mlir.poison : vector<4xf64>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.mlir.constant(true) : i1
    %5 = llvm.mlir.constant(dense<[false, false, true, false]> : vector<4xi1>) : vector<4xi1>
    %6 = llvm.mlir.constant(4 : i32) : i32
    %7 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, vector<4xi64>) -> !llvm.vec<4 x ptr>, f64
    %8 = llvm.insertelement %arg1, %1[%2 : i64] : vector<4xf64>
    %9 = llvm.shufflevector %8, %1 [0, 0, 0, 0] : vector<4xf64> 
    %10 = llvm.intr.masked.gather %7, %5, %9 {alignment = 4 : i32} : (!llvm.vec<4 x ptr>, vector<4xi1>, vector<4xf64>) -> vector<4xf64>]

    llvm.return %10 : vector<4xf64>
  }]

def gather_lane0_maybe_before := [llvmfunc|
  llvm.func @gather_lane0_maybe(%arg0: !llvm.ptr, %arg1: f64, %arg2: vector<2xi1>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<[0, 1]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.poison : vector<2xf64>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.mlir.constant(4 : i32) : i32
    %6 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, vector<2xi64>) -> !llvm.vec<2 x ptr>, f64
    %7 = llvm.insertelement %arg1, %1[%2 : i64] : vector<2xf64>
    %8 = llvm.insertelement %arg1, %7[%3 : i64] : vector<2xf64>
    %9 = llvm.insertelement %4, %arg2[%3 : i64] : vector<2xi1>
    %10 = llvm.intr.masked.gather %6, %9, %8 {alignment = 4 : i32} : (!llvm.vec<2 x ptr>, vector<2xi1>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %10 : vector<2xf64>
  }]

def gather_lane0_maybe_spec_before := [llvmfunc|
  llvm.func @gather_lane0_maybe_spec(%arg0: !llvm.ptr, %arg1: f64, %arg2: vector<2xi1>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<[0, 1]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.poison : vector<2xf64>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.mlir.constant(4 : i32) : i32
    %6 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, vector<2xi64>) -> !llvm.vec<2 x ptr>, f64
    %7 = llvm.insertelement %arg1, %1[%2 : i64] : vector<2xf64>
    %8 = llvm.insertelement %arg1, %7[%3 : i64] : vector<2xf64>
    %9 = llvm.insertelement %4, %arg2[%3 : i64] : vector<2xi1>
    %10 = llvm.intr.masked.gather %6, %9, %8 {alignment = 4 : i32} : (!llvm.vec<2 x ptr>, vector<2xi1>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %10 : vector<2xf64>
  }]

def scatter_zeromask_before := [llvmfunc|
  llvm.func @scatter_zeromask(%arg0: !llvm.vec<2 x ptr>, %arg1: vector<2xf64>) {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(8 : i32) : i32
    llvm.intr.masked.scatter %arg1, %arg0, %1 {alignment = 8 : i32} : vector<2xf64>, vector<2xi1> into !llvm.vec<2 x ptr>]

    llvm.return
  }]

def scatter_demandedelts_before := [llvmfunc|
  llvm.func @scatter_demandedelts(%arg0: !llvm.ptr, %arg1: f64) {
    %0 = llvm.mlir.constant(dense<[0, 1]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.poison : vector<2xf64>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.mlir.constant(true) : i1
    %6 = llvm.mlir.constant(dense<[true, false]> : vector<2xi1>) : vector<2xi1>
    %7 = llvm.mlir.constant(8 : i32) : i32
    %8 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, vector<2xi64>) -> !llvm.vec<2 x ptr>, f64
    %9 = llvm.insertelement %arg1, %1[%2 : i32] : vector<2xf64>
    %10 = llvm.insertelement %arg1, %9[%3 : i32] : vector<2xf64>
    llvm.intr.masked.scatter %10, %8, %6 {alignment = 8 : i32} : vector<2xf64>, vector<2xi1> into !llvm.vec<2 x ptr>]

    llvm.return
  }]

def load_zeromask_combined := [llvmfunc|
  llvm.func @load_zeromask(%arg0: !llvm.ptr, %arg1: vector<2xf64>) -> vector<2xf64> {
    llvm.return %arg1 : vector<2xf64>
  }]

theorem inst_combine_load_zeromask   : load_zeromask_before  ⊑  load_zeromask_combined := by
  unfold load_zeromask_before load_zeromask_combined
  simp_alive_peephole
  sorry
def load_onemask_combined := [llvmfunc|
  llvm.func @load_onemask(%arg0: !llvm.ptr, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.load %arg0 {alignment = 2 : i64} : !llvm.ptr -> vector<2xf64>
    llvm.return %0 : vector<2xf64>
  }]

theorem inst_combine_load_onemask   : load_onemask_before  ⊑  load_onemask_combined := by
  unfold load_onemask_before load_onemask_combined
  simp_alive_peephole
  sorry
def load_undefmask_combined := [llvmfunc|
  llvm.func @load_undefmask(%arg0: !llvm.ptr, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.load %arg0 {alignment = 2 : i64} : !llvm.ptr -> vector<2xf64>
    llvm.return %0 : vector<2xf64>
  }]

theorem inst_combine_load_undefmask   : load_undefmask_before  ⊑  load_undefmask_combined := by
  unfold load_undefmask_before load_undefmask_combined
  simp_alive_peephole
  sorry
def load_cemask_combined := [llvmfunc|
  llvm.func @load_cemask(%arg0: !llvm.ptr, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.addressof @G : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i1
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.undef : vector<2xi1>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi1>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi1>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.intr.masked.load %arg0, %7, %arg1 {alignment = 2 : i32} : (!llvm.ptr, vector<2xi1>, vector<2xf64>) -> vector<2xf64>
    llvm.return %9 : vector<2xf64>
  }]

theorem inst_combine_load_cemask   : load_cemask_before  ⊑  load_cemask_combined := by
  unfold load_cemask_before load_cemask_combined
  simp_alive_peephole
  sorry
def load_lane0_combined := [llvmfunc|
  llvm.func @load_lane0(%arg0: !llvm.ptr, %arg1: f64) -> vector<2xf64> {
    %0 = llvm.mlir.poison : vector<2xf64>
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.mlir.constant(dense<[true, false]> : vector<2xi1>) : vector<2xi1>
    %5 = llvm.mlir.constant(2 : i32) : i32
    %6 = llvm.insertelement %arg1, %0[%1 : i64] : vector<2xf64>
    %7 = llvm.intr.masked.load %arg0, %4, %6 {alignment = 2 : i32} : (!llvm.ptr, vector<2xi1>, vector<2xf64>) -> vector<2xf64>
    llvm.return %7 : vector<2xf64>
  }]

theorem inst_combine_load_lane0   : load_lane0_before  ⊑  load_lane0_combined := by
  unfold load_lane0_before load_lane0_combined
  simp_alive_peephole
  sorry
def load_all_combined := [llvmfunc|
  llvm.func @load_all(%arg0: !llvm.ptr, %arg1: f64) -> f64 {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.mlir.poison : i64
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.mlir.undef : vector<4xi64>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<4xi64>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<4xi64>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %1, %8[%9 : i32] : vector<4xi64>
    %11 = llvm.mlir.constant(3 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<4xi64>
    %13 = llvm.mlir.constant(true) : i1
    %14 = llvm.mlir.constant(false) : i1
    %15 = llvm.mlir.constant(dense<[true, false, true, true]> : vector<4xi1>) : vector<4xi1>
    %16 = llvm.mlir.poison : vector<4xf64>
    %17 = llvm.mlir.constant(4 : i32) : i32
    %18 = llvm.getelementptr %arg0[%12] : (!llvm.ptr, vector<4xi64>) -> !llvm.vec<4 x ptr>, f64
    %19 = llvm.intr.masked.gather %18, %15, %16 {alignment = 4 : i32} : (!llvm.vec<4 x ptr>, vector<4xi1>, vector<4xf64>) -> vector<4xf64>
    %20 = llvm.extractelement %19[%1 : i64] : vector<4xf64>
    llvm.return %20 : f64
  }]

theorem inst_combine_load_all   : load_all_before  ⊑  load_all_combined := by
  unfold load_all_before load_all_combined
  simp_alive_peephole
  sorry
def load_generic_combined := [llvmfunc|
  llvm.func @load_generic(%arg0: !llvm.ptr, %arg1: f64, %arg2: vector<2xi1>) -> vector<2xf64> {
    %0 = llvm.mlir.poison : vector<2xf64>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.insertelement %arg1, %0[%1 : i64] : vector<2xf64>
    %4 = llvm.shufflevector %3, %0 [0, 0] : vector<2xf64> 
    %5 = llvm.intr.masked.load %arg0, %arg2, %4 {alignment = 4 : i32} : (!llvm.ptr, vector<2xi1>, vector<2xf64>) -> vector<2xf64>
    llvm.return %5 : vector<2xf64>
  }]

theorem inst_combine_load_generic   : load_generic_before  ⊑  load_generic_combined := by
  unfold load_generic_before load_generic_combined
  simp_alive_peephole
  sorry
def load_speculative_combined := [llvmfunc|
  llvm.func @load_speculative(%arg0: !llvm.ptr {llvm.align = 4 : i64, llvm.dereferenceable = 16 : i64}, %arg1: f64, %arg2: vector<2xi1>) -> vector<2xf64> attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.poison : vector<2xf64>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.insertelement %arg1, %0[%1 : i64] : vector<2xf64>
    %3 = llvm.shufflevector %2, %0 [0, 0] : vector<2xf64> 
    %4 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> vector<2xf64>
    %5 = llvm.select %arg2, %4, %3 : vector<2xi1>, vector<2xf64>
    llvm.return %5 : vector<2xf64>
  }]

theorem inst_combine_load_speculative   : load_speculative_before  ⊑  load_speculative_combined := by
  unfold load_speculative_before load_speculative_combined
  simp_alive_peephole
  sorry
def load_speculative_less_aligned_combined := [llvmfunc|
  llvm.func @load_speculative_less_aligned(%arg0: !llvm.ptr {llvm.dereferenceable = 16 : i64}, %arg1: f64, %arg2: vector<2xi1>) -> vector<2xf64> attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.poison : vector<2xf64>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.insertelement %arg1, %0[%1 : i64] : vector<2xf64>
    %3 = llvm.shufflevector %2, %0 [0, 0] : vector<2xf64> 
    %4 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> vector<2xf64>
    %5 = llvm.select %arg2, %4, %3 : vector<2xi1>, vector<2xf64>
    llvm.return %5 : vector<2xf64>
  }]

theorem inst_combine_load_speculative_less_aligned   : load_speculative_less_aligned_before  ⊑  load_speculative_less_aligned_combined := by
  unfold load_speculative_less_aligned_before load_speculative_less_aligned_combined
  simp_alive_peephole
  sorry
def load_spec_neg_size_combined := [llvmfunc|
  llvm.func @load_spec_neg_size(%arg0: !llvm.ptr {llvm.dereferenceable = 8 : i64}, %arg1: f64, %arg2: vector<2xi1>) -> vector<2xf64> attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.poison : vector<2xf64>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.insertelement %arg1, %0[%1 : i64] : vector<2xf64>
    %4 = llvm.shufflevector %3, %0 [0, 0] : vector<2xf64> 
    %5 = llvm.intr.masked.load %arg0, %arg2, %4 {alignment = 4 : i32} : (!llvm.ptr, vector<2xi1>, vector<2xf64>) -> vector<2xf64>
    llvm.return %5 : vector<2xf64>
  }]

theorem inst_combine_load_spec_neg_size   : load_spec_neg_size_before  ⊑  load_spec_neg_size_combined := by
  unfold load_spec_neg_size_before load_spec_neg_size_combined
  simp_alive_peephole
  sorry
def load_spec_lan0_combined := [llvmfunc|
  llvm.func @load_spec_lan0(%arg0: !llvm.ptr {llvm.dereferenceable = 8 : i64}, %arg1: f64, %arg2: vector<2xi1>) -> vector<2xf64> attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.poison : vector<2xf64>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.mlir.constant(4 : i32) : i32
    %5 = llvm.insertelement %arg1, %0[%1 : i64] : vector<2xf64>
    %6 = llvm.shufflevector %5, %0 [0, 0] : vector<2xf64> 
    %7 = llvm.insertelement %2, %arg2[%3 : i64] : vector<2xi1>
    %8 = llvm.intr.masked.load %arg0, %7, %6 {alignment = 4 : i32} : (!llvm.ptr, vector<2xi1>, vector<2xf64>) -> vector<2xf64>
    llvm.return %8 : vector<2xf64>
  }]

theorem inst_combine_load_spec_lan0   : load_spec_lan0_before  ⊑  load_spec_lan0_combined := by
  unfold load_spec_lan0_before load_spec_lan0_combined
  simp_alive_peephole
  sorry
def store_zeromask_combined := [llvmfunc|
  llvm.func @store_zeromask(%arg0: !llvm.ptr, %arg1: vector<2xf64>) {
    llvm.return
  }]

theorem inst_combine_store_zeromask   : store_zeromask_before  ⊑  store_zeromask_combined := by
  unfold store_zeromask_before store_zeromask_combined
  simp_alive_peephole
  sorry
def store_onemask_combined := [llvmfunc|
  llvm.func @store_onemask(%arg0: !llvm.ptr, %arg1: vector<2xf64>) {
    llvm.store %arg1, %arg0 {alignment = 4 : i64} : vector<2xf64>, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_store_onemask   : store_onemask_before  ⊑  store_onemask_combined := by
  unfold store_onemask_before store_onemask_combined
  simp_alive_peephole
  sorry
def store_demandedelts_combined := [llvmfunc|
  llvm.func @store_demandedelts(%arg0: !llvm.ptr, %arg1: f64) {
    %0 = llvm.mlir.poison : vector<2xf64>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.mlir.constant(dense<[true, false]> : vector<2xi1>) : vector<2xi1>
    %5 = llvm.mlir.constant(4 : i32) : i32
    %6 = llvm.insertelement %arg1, %0[%1 : i64] : vector<2xf64>
    llvm.intr.masked.store %6, %arg0, %4 {alignment = 4 : i32} : vector<2xf64>, vector<2xi1> into !llvm.ptr
    llvm.return
  }]

theorem inst_combine_store_demandedelts   : store_demandedelts_before  ⊑  store_demandedelts_combined := by
  unfold store_demandedelts_before store_demandedelts_combined
  simp_alive_peephole
  sorry
def gather_generic_combined := [llvmfunc|
  llvm.func @gather_generic(%arg0: !llvm.vec<2 x ptr>, %arg1: vector<2xi1>, %arg2: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.intr.masked.gather %arg0, %arg1, %arg2 {alignment = 4 : i32} : (!llvm.vec<2 x ptr>, vector<2xi1>, vector<2xf64>) -> vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }]

theorem inst_combine_gather_generic   : gather_generic_before  ⊑  gather_generic_combined := by
  unfold gather_generic_before gather_generic_combined
  simp_alive_peephole
  sorry
def gather_zeromask_combined := [llvmfunc|
  llvm.func @gather_zeromask(%arg0: !llvm.vec<2 x ptr>, %arg1: vector<2xf64>) -> vector<2xf64> {
    llvm.return %arg1 : vector<2xf64>
  }]

theorem inst_combine_gather_zeromask   : gather_zeromask_before  ⊑  gather_zeromask_combined := by
  unfold gather_zeromask_before gather_zeromask_combined
  simp_alive_peephole
  sorry
def gather_onemask_combined := [llvmfunc|
  llvm.func @gather_onemask(%arg0: !llvm.vec<2 x ptr>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.poison : vector<2xf64>
    %3 = llvm.mlir.constant(4 : i32) : i32
    %4 = llvm.intr.masked.gather %arg0, %1, %2 {alignment = 4 : i32} : (!llvm.vec<2 x ptr>, vector<2xi1>, vector<2xf64>) -> vector<2xf64>
    llvm.return %4 : vector<2xf64>
  }]

theorem inst_combine_gather_onemask   : gather_onemask_before  ⊑  gather_onemask_combined := by
  unfold gather_onemask_before gather_onemask_combined
  simp_alive_peephole
  sorry
def gather_lane2_combined := [llvmfunc|
  llvm.func @gather_lane2(%arg0: !llvm.ptr, %arg1: f64) -> vector<4xf64> {
    %0 = llvm.mlir.poison : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.mlir.undef : vector<4xi64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<4xi64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<4xi64>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %1, %6[%7 : i32] : vector<4xi64>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi64>
    %11 = llvm.mlir.poison : vector<4xf64>
    %12 = llvm.mlir.constant(0 : i64) : i64
    %13 = llvm.mlir.constant(false) : i1
    %14 = llvm.mlir.constant(true) : i1
    %15 = llvm.mlir.constant(dense<[false, false, true, false]> : vector<4xi1>) : vector<4xi1>
    %16 = llvm.mlir.constant(4 : i32) : i32
    %17 = llvm.getelementptr %arg0[%10] : (!llvm.ptr, vector<4xi64>) -> !llvm.vec<4 x ptr>, f64
    %18 = llvm.insertelement %arg1, %11[%12 : i64] : vector<4xf64>
    %19 = llvm.shufflevector %18, %11 [0, 0, -1, 0] : vector<4xf64> 
    %20 = llvm.intr.masked.gather %17, %15, %19 {alignment = 4 : i32} : (!llvm.vec<4 x ptr>, vector<4xi1>, vector<4xf64>) -> vector<4xf64>
    llvm.return %20 : vector<4xf64>
  }]

theorem inst_combine_gather_lane2   : gather_lane2_before  ⊑  gather_lane2_combined := by
  unfold gather_lane2_before gather_lane2_combined
  simp_alive_peephole
  sorry
def gather_lane0_maybe_combined := [llvmfunc|
  llvm.func @gather_lane0_maybe(%arg0: !llvm.ptr, %arg1: f64, %arg2: vector<2xi1>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<[0, 1]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.poison : vector<2xf64>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.mlir.constant(1 : i64) : i64
    %5 = llvm.mlir.constant(4 : i32) : i32
    %6 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, vector<2xi64>) -> !llvm.vec<2 x ptr>, f64
    %7 = llvm.insertelement %arg1, %1[%2 : i64] : vector<2xf64>
    %8 = llvm.shufflevector %7, %1 [0, 0] : vector<2xf64> 
    %9 = llvm.insertelement %3, %arg2[%4 : i64] : vector<2xi1>
    %10 = llvm.intr.masked.gather %6, %9, %8 {alignment = 4 : i32} : (!llvm.vec<2 x ptr>, vector<2xi1>, vector<2xf64>) -> vector<2xf64>
    llvm.return %10 : vector<2xf64>
  }]

theorem inst_combine_gather_lane0_maybe   : gather_lane0_maybe_before  ⊑  gather_lane0_maybe_combined := by
  unfold gather_lane0_maybe_before gather_lane0_maybe_combined
  simp_alive_peephole
  sorry
def gather_lane0_maybe_spec_combined := [llvmfunc|
  llvm.func @gather_lane0_maybe_spec(%arg0: !llvm.ptr, %arg1: f64, %arg2: vector<2xi1>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<[0, 1]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.poison : vector<2xf64>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.mlir.constant(1 : i64) : i64
    %5 = llvm.mlir.constant(4 : i32) : i32
    %6 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, vector<2xi64>) -> !llvm.vec<2 x ptr>, f64
    %7 = llvm.insertelement %arg1, %1[%2 : i64] : vector<2xf64>
    %8 = llvm.shufflevector %7, %1 [0, 0] : vector<2xf64> 
    %9 = llvm.insertelement %3, %arg2[%4 : i64] : vector<2xi1>
    %10 = llvm.intr.masked.gather %6, %9, %8 {alignment = 4 : i32} : (!llvm.vec<2 x ptr>, vector<2xi1>, vector<2xf64>) -> vector<2xf64>
    llvm.return %10 : vector<2xf64>
  }]

theorem inst_combine_gather_lane0_maybe_spec   : gather_lane0_maybe_spec_before  ⊑  gather_lane0_maybe_spec_combined := by
  unfold gather_lane0_maybe_spec_before gather_lane0_maybe_spec_combined
  simp_alive_peephole
  sorry
def scatter_zeromask_combined := [llvmfunc|
  llvm.func @scatter_zeromask(%arg0: !llvm.vec<2 x ptr>, %arg1: vector<2xf64>) {
    llvm.return
  }]

theorem inst_combine_scatter_zeromask   : scatter_zeromask_before  ⊑  scatter_zeromask_combined := by
  unfold scatter_zeromask_before scatter_zeromask_combined
  simp_alive_peephole
  sorry
def scatter_demandedelts_combined := [llvmfunc|
  llvm.func @scatter_demandedelts(%arg0: !llvm.ptr, %arg1: f64) {
    %0 = llvm.mlir.poison : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.undef : vector<2xi64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi64>
    %7 = llvm.mlir.poison : vector<2xf64>
    %8 = llvm.mlir.constant(false) : i1
    %9 = llvm.mlir.constant(true) : i1
    %10 = llvm.mlir.constant(dense<[true, false]> : vector<2xi1>) : vector<2xi1>
    %11 = llvm.mlir.constant(8 : i32) : i32
    %12 = llvm.getelementptr %arg0[%6] : (!llvm.ptr, vector<2xi64>) -> !llvm.vec<2 x ptr>, f64
    %13 = llvm.insertelement %arg1, %7[%1 : i64] : vector<2xf64>
    llvm.intr.masked.scatter %13, %12, %10 {alignment = 8 : i32} : vector<2xf64>, vector<2xi1> into !llvm.vec<2 x ptr>
    llvm.return
  }]

theorem inst_combine_scatter_demandedelts   : scatter_demandedelts_before  ⊑  scatter_demandedelts_combined := by
  unfold scatter_demandedelts_before scatter_demandedelts_combined
  simp_alive_peephole
  sorry
