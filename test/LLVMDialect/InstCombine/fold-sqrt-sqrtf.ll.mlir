"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @sqrt, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "foo", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "sqrt", type = !llvm.func<f64 (f64)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
