"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "fabsl", type = !llvm.func<f80 (f80)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f80):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @fabsl, fastmathFlags = #llvm.fastmath<>} : (f80) -> f80
    "llvm.return"(%0) : (f80) -> ()
  }) {linkage = 10 : i64, sym_name = "replace_fabs_call_f80", type = !llvm.func<f80 (f80)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f80):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @fabsl, fastmathFlags = #llvm.fastmath<>} : (f80) -> f80
    "llvm.return"(%0) : (f80) -> ()
  }) {linkage = 10 : i64, sym_name = "fmf_replace_fabs_call_f80", type = !llvm.func<f80 (f80)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
