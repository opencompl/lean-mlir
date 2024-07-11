import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  known_align
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def main_before := [llvmfunc|
  llvm.func @main() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(10 : i32) : i32
    %3 = llvm.mlir.constant(1 : i8) : i8
    %4 = llvm.mlir.undef : !llvm.struct<"struct.p", packed (i8, i32)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"struct.p", packed (i8, i32)> 
    %6 = llvm.insertvalue %2, %5[1] : !llvm.struct<"struct.p", packed (i8, i32)> 
    %7 = llvm.mlir.addressof @t : !llvm.ptr
    %8 = llvm.getelementptr inbounds %7[%1, 1] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.p", packed (i8, i32)>
    %9 = llvm.mlir.constant(0 : i8) : i8
    %10 = llvm.mlir.undef : !llvm.struct<"struct.p", packed (i8, i32)>
    %11 = llvm.insertvalue %9, %10[0] : !llvm.struct<"struct.p", packed (i8, i32)> 
    %12 = llvm.insertvalue %1, %11[1] : !llvm.struct<"struct.p", packed (i8, i32)> 
    %13 = llvm.mlir.addressof @u : !llvm.ptr
    %14 = llvm.getelementptr inbounds %13[%1, 1] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.p", packed (i8, i32)>
    %15 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %16 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %17 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %18 = llvm.bitcast %1 : i32 to i32
    %19 = llvm.load %8 {alignment = 1 : i64} : !llvm.ptr -> i32]

    llvm.store %19, %17 {alignment = 4 : i64} : i32, !llvm.ptr]

    %20 = llvm.load %17 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.store %20, %14 {alignment = 1 : i64} : i32, !llvm.ptr]

    %21 = llvm.load %17 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.store %21, %16 {alignment = 4 : i64} : i32, !llvm.ptr]

    %22 = llvm.load %16 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.store %22, %15 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %23 = llvm.load %15 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %23 : i32
  }]

def main_combined := [llvmfunc|
  llvm.func @main() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(10 : i32) : i32
    %3 = llvm.mlir.constant(1 : i8) : i8
    %4 = llvm.mlir.undef : !llvm.struct<"struct.p", packed (i8, i32)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"struct.p", packed (i8, i32)> 
    %6 = llvm.insertvalue %2, %5[1] : !llvm.struct<"struct.p", packed (i8, i32)> 
    %7 = llvm.mlir.addressof @t : !llvm.ptr
    %8 = llvm.getelementptr inbounds %7[%1, 1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"struct.p", packed (i8, i32)>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.mlir.constant(0 : i8) : i8
    %11 = llvm.mlir.undef : !llvm.struct<"struct.p", packed (i8, i32)>
    %12 = llvm.insertvalue %10, %11[0] : !llvm.struct<"struct.p", packed (i8, i32)> 
    %13 = llvm.insertvalue %9, %12[1] : !llvm.struct<"struct.p", packed (i8, i32)> 
    %14 = llvm.mlir.addressof @u : !llvm.ptr
    %15 = llvm.getelementptr inbounds %14[%1, 1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"struct.p", packed (i8, i32)>
    %16 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %17 = llvm.load %8 {alignment = 1 : i64} : !llvm.ptr -> i32
    llvm.store %17, %15 {alignment = 1 : i64} : i32, !llvm.ptr
    llvm.store %17, %16 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %18 = llvm.load %16 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %18 : i32
  }]

theorem inst_combine_main   : main_before  ⊑  main_combined := by
  unfold main_before main_combined
  simp_alive_peephole
  sorry
