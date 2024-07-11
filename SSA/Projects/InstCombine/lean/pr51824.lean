import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pr51824
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def PR51824_before := [llvmfunc|
  llvm.func @PR51824(%arg0: vector<4xi16>, %arg1: !llvm.ptr, %arg2: i1, %arg3: !llvm.ptr) {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(-32768 : i16) : i16
    %3 = llvm.mlir.constant(0 : i16) : i16
    %4 = llvm.mlir.constant(dense<0> : vector<4xi16>) : vector<4xi16>
    %5 = llvm.mlir.poison : vector<4xi16>
    %6 = llvm.mlir.zero : !llvm.ptr
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.mlir.undef : vector<4xi32>
    %9 = llvm.mlir.undef : i32
    %10 = llvm.mlir.constant(0 : i32) : i32
    %11 = llvm.mlir.poison : i1
    %12 = llvm.icmp "sgt" %0, %1 : i1
    %13 = llvm.lshr %2, %3  : i16
    %14 = llvm.icmp "uge" %13, %13 : i16
    %15 = llvm.extractelement %4[%13 : i16] : vector<4xi16>
    %16 = llvm.insertelement %15, %5[%3 : i16] : vector<4xi16>
    %17 = llvm.sext %16 : vector<4xi16> to vector<4xi32>
    %18 = llvm.getelementptr inbounds %6[%17] : (!llvm.ptr, vector<4xi32>) -> !llvm.vec<4 x ptr>, i64
    %19 = llvm.ptrtoint %18 : !llvm.vec<4 x ptr> to vector<4xi32>
    %20 = llvm.extractelement %19[%3 : i16] : vector<4xi32>
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb1
    %21 = llvm.alloca %7 x vector<4xi32> {alignment = 16 : i64} : (i32) -> !llvm.ptr]

    %22 = llvm.load %21 {alignment = 16 : i64} : !llvm.ptr -> vector<4xi32>]

    %23 = llvm.getelementptr %6[%20] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    %24 = llvm.getelementptr inbounds %23[%arg0] : (!llvm.ptr, vector<4xi16>) -> !llvm.vec<4 x ptr>, i64
    %25 = llvm.ptrtoint %24 : !llvm.vec<4 x ptr> to vector<4xi32>
    %26 = llvm.extractelement %22[%0 : i1] : vector<4xi32>
    %27 = llvm.extractelement %25[%0 : i1] : vector<4xi32>
    %28 = llvm.insertelement %9, %8[%27 : i32] : vector<4xi32>
    %29 = llvm.insertelement %26, %28[%3 : i16] : vector<4xi32>
    %30 = llvm.shufflevector %29, %22 [-1, -1, -1, -1] : vector<4xi32> 
    %31 = llvm.insertelement %10, %29[%14 : i1] : vector<4xi32>
    %32 = llvm.extractelement %31[%11 : i1] : vector<4xi32>
    llvm.store %32, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb2:  // pred: ^bb1
    %33 = llvm.shufflevector %28, %30 [-1, -1, -1, -1] : vector<4xi32> 
    llvm.store %33, %arg3 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.return
  }]

def PR51824_combined := [llvmfunc|
  llvm.func @PR51824(%arg0: vector<4xi16>, %arg1: !llvm.ptr, %arg2: i1, %arg3: !llvm.ptr) {
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb1
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return
  }]

theorem inst_combine_PR51824   : PR51824_before  ⊑  PR51824_combined := by
  unfold PR51824_before PR51824_combined
  simp_alive_peephole
  sorry
