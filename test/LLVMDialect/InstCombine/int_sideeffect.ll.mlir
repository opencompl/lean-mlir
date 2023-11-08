"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.sideeffect", type = !llvm.func<void ()>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<f32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0.000000e+00 : f32} : () -> f32
    "llvm.store"(%0, %arg0) : (f32, !llvm.ptr<f32>) -> ()
    "llvm.call"() {callee = @llvm.sideeffect, fastmathFlags = #llvm.fastmath<>} : () -> ()
    %1 = "llvm.load"(%arg0) : (!llvm.ptr<f32>) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "s2l", type = !llvm.func<f32 (ptr<f32>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
