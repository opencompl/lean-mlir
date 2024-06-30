"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: f64, %arg1: f64):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f64) -> f80
    %1 = "llvm.fpext"(%arg1) : (f64) -> f80
    %2 = "llvm.fadd"(%0, %1) : (f80, f80) -> f80
    %3 = "llvm.fptrunc"(%2) : (f80) -> f64
    "llvm.return"(%3) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "test1", type = !llvm.func<f64 (f64, f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64, %arg1: f64):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f64) -> f80
    %1 = "llvm.fpext"(%arg1) : (f64) -> f80
    %2 = "llvm.fsub"(%0, %1) : (f80, f80) -> f80
    %3 = "llvm.fptrunc"(%2) : (f80) -> f64
    "llvm.return"(%3) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "test2", type = !llvm.func<f64 (f64, f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64, %arg1: f64):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f64) -> f80
    %1 = "llvm.fpext"(%arg1) : (f64) -> f80
    %2 = "llvm.fmul"(%0, %1) : (f80, f80) -> f80
    %3 = "llvm.fptrunc"(%2) : (f80) -> f64
    "llvm.return"(%3) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "test3", type = !llvm.func<f64 (f64, f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64, %arg1: f16):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f64) -> f80
    %1 = "llvm.fpext"(%arg1) : (f16) -> f80
    %2 = "llvm.fmul"(%0, %1) : (f80, f80) -> f80
    %3 = "llvm.fptrunc"(%2) : (f80) -> f64
    "llvm.return"(%3) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "test4", type = !llvm.func<f64 (f64, f16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64, %arg1: f64):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f64) -> f80
    %1 = "llvm.fpext"(%arg1) : (f64) -> f80
    %2 = "llvm.fdiv"(%0, %1) : (f80, f80) -> f80
    %3 = "llvm.fptrunc"(%2) : (f80) -> f64
    "llvm.return"(%3) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "test5", type = !llvm.func<f64 (f64, f64)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
