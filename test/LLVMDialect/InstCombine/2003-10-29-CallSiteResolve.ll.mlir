"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "bar", type = !llvm.func<ptr<i32> ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.null"() : () -> !llvm.ptr<f32>
    %1 = "llvm.mlir.addressof"() {global_name = @bar} : () -> !llvm.ptr<func<ptr<i32> ()>>
    %2 = "llvm.bitcast"(%1) : (!llvm.ptr<func<ptr<i32> ()>>) -> !llvm.ptr<func<ptr<f32> ()>>
    %3 = "llvm.invoke"(%2)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (!llvm.ptr<func<ptr<f32> ()>>) -> !llvm.ptr<f32>
  ^bb1:  // pred: ^bb0
    "llvm.return"(%3) : (!llvm.ptr<f32>) -> ()
  ^bb2:  // pred: ^bb0
    %4 = "llvm.landingpad"() {cleanup} : () -> !llvm.struct<(ptr<i8>, i32)>
    "llvm.return"(%0) : (!llvm.ptr<f32>) -> ()
  }) {linkage = 10 : i64, personality = @__gxx_personality_v0, sym_name = "foo", type = !llvm.func<ptr<f32> ()>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "__gxx_personality_v0", type = !llvm.func<i32 (...)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
