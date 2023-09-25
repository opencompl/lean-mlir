"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.fsub"(%arg0, %arg0) : (f64, f64) -> f64
    "llvm.return"(%0) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "test", type = !llvm.func<f64 (f64)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
