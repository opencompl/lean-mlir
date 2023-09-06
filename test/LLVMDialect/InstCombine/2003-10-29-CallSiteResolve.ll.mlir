module  {
  llvm.func @bar() -> !llvm.ptr<i32>
  llvm.func @foo() -> !llvm.ptr<f32> attributes {personality = @__gxx_personality_v0} {
    %0 = llvm.mlir.null : !llvm.ptr<f32>
    %1 = llvm.mlir.addressof @bar : !llvm.ptr<func<ptr<i32> ()>>
    %2 = llvm.bitcast %1 : !llvm.ptr<func<ptr<i32> ()>> to !llvm.ptr<func<ptr<f32> ()>>
    %3 = llvm.invoke %2() to ^bb1 unwind ^bb2 : () -> !llvm.ptr<f32>
  ^bb1:  // pred: ^bb0
    llvm.return %3 : !llvm.ptr<f32>
  ^bb2:  // pred: ^bb0
    %4 = llvm.landingpad cleanup : !llvm.struct<(ptr<i8>, i32)>
    llvm.return %0 : !llvm.ptr<f32>
  }
  llvm.func @__gxx_personality_v0(...) -> i32
}
