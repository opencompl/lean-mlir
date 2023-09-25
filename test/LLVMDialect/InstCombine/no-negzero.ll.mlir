"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0.000000e+00 : f64} : () -> f64
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %3 = "llvm.alloca"(%2) : (i32) -> !llvm.ptr<f64>
    %4 = "llvm.alloca"(%2) : (i32) -> !llvm.ptr<f64>
    %5 = "llvm.alloca"(%2) : (i32) -> !llvm.ptr<f64>
    %6 = "llvm.bitcast"(%1) : (i32) -> i32
    "llvm.store"(%arg0, %3) : (f64, !llvm.ptr<f64>) -> ()
    %7 = "llvm.load"(%3) : (!llvm.ptr<f64>) -> f64
    %8 = "llvm.call"(%7) {callee = @fabs, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %9 = "llvm.call"(%8) {callee = @sqrt, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %10 = "llvm.fadd"(%9, %0) : (f64, f64) -> f64
    "llvm.store"(%10, %5) : (f64, !llvm.ptr<f64>) -> ()
    %11 = "llvm.load"(%5) : (!llvm.ptr<f64>) -> f64
    "llvm.store"(%11, %4) : (f64, !llvm.ptr<f64>) -> ()
    "llvm.br"()[^bb1] : () -> ()
  ^bb1:  // pred: ^bb0
    %12 = "llvm.load"(%4) : (!llvm.ptr<f64>) -> f64
    "llvm.return"(%12) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "mysqrt", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "fabs", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "sqrt", type = !llvm.func<f64 (f64)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
