"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "exp2", type = !llvm.func<f32 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.sitofp"(%arg0) : (i32) -> f64
    %1 = "llvm.call"(%0) {callee = @exp2, fastmathFlags = #llvm.fastmath<>} : (f64) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_no_simplify1", type = !llvm.func<f32 (i32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
