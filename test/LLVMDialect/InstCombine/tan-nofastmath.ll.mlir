"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @atanf, fastmathFlags = #llvm.fastmath<>} : (f32) -> f32
    %1 = "llvm.call"(%0) {callee = @tanf, fastmathFlags = #llvm.fastmath<>} : (f32) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "mytan", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "tanf", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "atanf", type = !llvm.func<f32 (f32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
