import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  phi-merge-gep
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo_before := [llvmfunc|
  llvm.func @foo(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: !llvm.ptr, %arg4: !llvm.ptr, %arg5: i64, %arg6: i64) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.mlir.constant(-1.500000e+00 : f32) : f32
    %3 = llvm.mlir.constant(0.866025388 : f32) : f32
    %4 = llvm.mlir.constant(1 : i64) : i64
    %5 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %6 = llvm.getelementptr inbounds %arg1[%0] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %7 = llvm.mul %arg6, %arg2  : i64
    %8 = llvm.getelementptr inbounds %arg0[%7] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %9 = llvm.mul %arg6, %arg2  : i64
    %10 = llvm.getelementptr inbounds %arg1[%9] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %11 = llvm.mul %arg6, %1  : i64
    %12 = llvm.mul %11, %arg2  : i64
    %13 = llvm.getelementptr inbounds %arg0[%12] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %14 = llvm.mul %arg6, %1  : i64
    %15 = llvm.mul %14, %arg2  : i64
    %16 = llvm.getelementptr inbounds %arg1[%15] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %17 = llvm.getelementptr inbounds %arg3[%0] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %18 = llvm.getelementptr inbounds %arg4[%0] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %19 = llvm.mul %arg6, %arg5  : i64
    %20 = llvm.getelementptr inbounds %arg3[%19] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %21 = llvm.mul %arg6, %arg5  : i64
    %22 = llvm.getelementptr inbounds %arg4[%21] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %23 = llvm.mul %arg6, %1  : i64
    %24 = llvm.mul %23, %arg5  : i64
    %25 = llvm.getelementptr inbounds %arg3[%24] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %26 = llvm.mul %arg6, %1  : i64
    %27 = llvm.mul %26, %arg5  : i64
    %28 = llvm.getelementptr inbounds %arg4[%27] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.br ^bb2(%0, %28, %25, %22, %20, %18, %17, %16, %13, %10, %8, %6, %5 : i64, !llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr)
  ^bb1:  // pred: ^bb2
    %29 = llvm.load %76 {alignment = 4 : i64} : !llvm.ptr -> f32]

    %30 = llvm.load %75 {alignment = 4 : i64} : !llvm.ptr -> f32]

    %31 = llvm.load %74 {alignment = 4 : i64} : !llvm.ptr -> f32]

    %32 = llvm.load %73 {alignment = 4 : i64} : !llvm.ptr -> f32]

    %33 = llvm.load %72 {alignment = 4 : i64} : !llvm.ptr -> f32]

    %34 = llvm.load %71 {alignment = 4 : i64} : !llvm.ptr -> f32]

    %35 = llvm.fadd %31, %33  : f32
    %36 = llvm.fadd %32, %34  : f32
    %37 = llvm.fsub %31, %33  : f32
    %38 = llvm.fsub %32, %34  : f32
    %39 = llvm.fadd %29, %35  : f32
    %40 = llvm.fadd %30, %36  : f32
    %41 = llvm.fmul %35, %2  : f32
    %42 = llvm.fmul %36, %2  : f32
    %43 = llvm.fadd %39, %41  : f32
    %44 = llvm.fadd %40, %42  : f32
    %45 = llvm.fmul %37, %3  : f32
    %46 = llvm.fmul %38, %3  : f32
    %47 = llvm.fadd %43, %46  : f32
    %48 = llvm.fsub %44, %45  : f32
    %49 = llvm.fsub %43, %46  : f32
    %50 = llvm.fadd %44, %45  : f32
    llvm.store %39, %70 {alignment = 4 : i64} : f32, !llvm.ptr]

    llvm.store %40, %69 {alignment = 4 : i64} : f32, !llvm.ptr]

    llvm.store %47, %68 {alignment = 4 : i64} : f32, !llvm.ptr]

    llvm.store %48, %67 {alignment = 4 : i64} : f32, !llvm.ptr]

    llvm.store %49, %66 {alignment = 4 : i64} : f32, !llvm.ptr]

    llvm.store %50, %65 {alignment = 4 : i64} : f32, !llvm.ptr]

    %51 = llvm.getelementptr inbounds %76[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %52 = llvm.getelementptr inbounds %75[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %53 = llvm.getelementptr inbounds %74[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %54 = llvm.getelementptr inbounds %73[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %55 = llvm.getelementptr inbounds %72[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %56 = llvm.getelementptr inbounds %71[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %57 = llvm.getelementptr inbounds %70[%arg5] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %58 = llvm.getelementptr inbounds %69[%arg5] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %59 = llvm.getelementptr inbounds %68[%arg5] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %60 = llvm.getelementptr inbounds %67[%arg5] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %61 = llvm.getelementptr inbounds %66[%arg5] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %62 = llvm.getelementptr inbounds %65[%arg5] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %63 = llvm.add %64, %4 overflow<nsw>  : i64
    llvm.br ^bb2(%63, %62, %61, %60, %59, %58, %57, %56, %55, %54, %53, %52, %51 : i64, !llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr)
  ^bb2(%64: i64, %65: !llvm.ptr, %66: !llvm.ptr, %67: !llvm.ptr, %68: !llvm.ptr, %69: !llvm.ptr, %70: !llvm.ptr, %71: !llvm.ptr, %72: !llvm.ptr, %73: !llvm.ptr, %74: !llvm.ptr, %75: !llvm.ptr, %76: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    %77 = llvm.icmp "slt" %64, %arg6 : i64
    llvm.cond_br %77, ^bb1, ^bb3
  ^bb3:  // pred: ^bb2
    llvm.br ^bb4
  ^bb4:  // pred: ^bb3
    llvm.return
  }]

