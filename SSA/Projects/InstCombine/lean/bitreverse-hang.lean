import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  bitreverse-hang
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fn1_before := [llvmfunc|
  llvm.func @fn1() -> i32 attributes {frame_pointer = #llvm.framePointerKind<all>, passthrough = ["norecurse", "nounwind", "ssp", ["uwtable", "2"], ["disable-tail-calls", "false"], ["less-precise-fpmad", "false"], ["no-infs-fp-math", "false"], ["no-nans-fp-math", "false"], ["stack-protector-buffer-size", "8"], ["target-cpu", "core2"], ["unsafe-fp-math", "false"], ["use-soft-float", "false"]], target_cpu = "core2", target_features = #llvm.target_features<["+cx16", "+fxsr", "+mmx", "+sse", "+sse2", "+sse3", "+ssse3"]>} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @b : !llvm.ptr
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(32 : i32) : i32
    %4 = llvm.mlir.undef : i32
    %5 = llvm.load %1 {alignment = 4 : i64, tbaa = [#tbaa_tag]} : !llvm.ptr -> i32]

    llvm.br ^bb1(%5, %0 : i32, i32)
  ^bb1(%6: i32, %7: i32):  // 2 preds: ^bb0, ^bb1
    %8 = llvm.lshr %6, %2  : i32
    %9 = llvm.or %8, %6  : i32
    %10 = llvm.add %7, %2 overflow<nsw, nuw>  : i32
    %11 = llvm.icmp "eq" %10, %3 : i32
    llvm.cond_br %11, ^bb2, ^bb1(%9, %10 : i32, i32)
  ^bb2:  // pred: ^bb1
    llvm.store %9, %1 {alignment = 4 : i64, tbaa = [#tbaa_tag]} : i32, !llvm.ptr]

    llvm.return %4 : i32
  }]

def fn1_combined := [llvmfunc|
  llvm.func @fn1() -> i32 attributes {frame_pointer = #llvm.framePointerKind<all>, passthrough = ["norecurse", "nounwind", "ssp", ["uwtable", "2"], ["disable-tail-calls", "false"], ["less-precise-fpmad", "false"], ["no-infs-fp-math", "false"], ["no-nans-fp-math", "false"], ["stack-protector-buffer-size", "8"], ["target-cpu", "core2"], ["unsafe-fp-math", "false"], ["use-soft-float", "false"]], target_cpu = "core2", target_features = #llvm.target_features<["+cx16", "+fxsr", "+mmx", "+sse", "+sse2", "+sse3", "+ssse3"]>} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @b : !llvm.ptr
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.undef : i32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %5 = llvm.load %1 {alignment = 4 : i64, tbaa = [#tbaa_tag]} : !llvm.ptr -> i32
    %6 = llvm.lshr %5, %2  : i32
    %7 = llvm.lshr %5, %3  : i32
    %8 = llvm.or %6, %7  : i32
    %9 = llvm.or %8, %5  : i32
    %10 = llvm.lshr %9, %2  : i32
    %11 = llvm.lshr %9, %3  : i32
    %12 = llvm.or %10, %11  : i32
    %13 = llvm.or %12, %9  : i32
    %14 = llvm.lshr %13, %2  : i32
    %15 = llvm.lshr %13, %3  : i32
    %16 = llvm.or %14, %15  : i32
    %17 = llvm.or %16, %13  : i32
    %18 = llvm.lshr %17, %2  : i32
    %19 = llvm.lshr %17, %3  : i32
    %20 = llvm.or %18, %19  : i32
    %21 = llvm.or %20, %17  : i32
    %22 = llvm.lshr %21, %2  : i32
    %23 = llvm.lshr %21, %3  : i32
    %24 = llvm.or %22, %23  : i32
    %25 = llvm.or %24, %21  : i32
    %26 = llvm.lshr %25, %2  : i32
    %27 = llvm.lshr %25, %3  : i32
    %28 = llvm.or %26, %27  : i32
    %29 = llvm.or %28, %25  : i32
    %30 = llvm.lshr %29, %2  : i32
    %31 = llvm.lshr %29, %3  : i32
    %32 = llvm.or %30, %31  : i32
    %33 = llvm.or %32, %29  : i32
    %34 = llvm.lshr %33, %2  : i32
    %35 = llvm.lshr %33, %3  : i32
    %36 = llvm.or %34, %35  : i32
    %37 = llvm.or %36, %33  : i32
    %38 = llvm.lshr %37, %2  : i32
    %39 = llvm.lshr %37, %3  : i32
    %40 = llvm.or %38, %39  : i32
    %41 = llvm.or %40, %37  : i32
    %42 = llvm.lshr %41, %2  : i32
    %43 = llvm.lshr %41, %3  : i32
    %44 = llvm.or %42, %43  : i32
    %45 = llvm.or %44, %41  : i32
    %46 = llvm.lshr %45, %2  : i32
    %47 = llvm.lshr %45, %3  : i32
    %48 = llvm.or %46, %47  : i32
    %49 = llvm.or %48, %45  : i32
    %50 = llvm.lshr %49, %2  : i32
    %51 = llvm.lshr %49, %3  : i32
    %52 = llvm.or %50, %51  : i32
    %53 = llvm.or %52, %49  : i32
    %54 = llvm.lshr %53, %2  : i32
    %55 = llvm.lshr %53, %3  : i32
    %56 = llvm.or %54, %55  : i32
    %57 = llvm.or %56, %53  : i32
    %58 = llvm.lshr %57, %2  : i32
    %59 = llvm.lshr %57, %3  : i32
    %60 = llvm.or %58, %59  : i32
    %61 = llvm.or %60, %57  : i32
    %62 = llvm.lshr %61, %2  : i32
    %63 = llvm.lshr %61, %3  : i32
    %64 = llvm.or %62, %63  : i32
    %65 = llvm.or %64, %61  : i32
    %66 = llvm.lshr %65, %2  : i32
    %67 = llvm.lshr %65, %3  : i32
    %68 = llvm.or %66, %67  : i32
    %69 = llvm.or %68, %65  : i32
    llvm.store %69, %1 {alignment = 4 : i64, tbaa = [#tbaa_tag]} : i32, !llvm.ptr
    llvm.return %4 : i32
  }]

theorem inst_combine_fn1   : fn1_before  ⊑  fn1_combined := by
  unfold fn1_before fn1_combined
  simp_alive_peephole
  sorry
