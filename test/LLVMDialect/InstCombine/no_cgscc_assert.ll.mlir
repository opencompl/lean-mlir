"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fmul"(%arg0, %arg0) : (f32, f32) -> f32
    %1 = "llvm.call"(%0) {callee = @sqrtf, fastmathFlags = #llvm.fastmath<>} : (f32) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "bar", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "sqrtf", type = !llvm.func<f32 (f32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
