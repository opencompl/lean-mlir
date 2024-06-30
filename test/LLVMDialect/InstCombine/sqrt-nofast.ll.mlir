"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: f32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.alloca"(%0) : (i32) -> !llvm.ptr<f32>
    %2 = "llvm.alloca"(%0) : (i32) -> !llvm.ptr<f32>
    "llvm.store"(%arg0, %1) : (f32, !llvm.ptr<f32>) -> ()
    "llvm.store"(%arg1, %2) : (f32, !llvm.ptr<f32>) -> ()
    %3 = "llvm.load"(%1) : (!llvm.ptr<f32>) -> f32
    %4 = "llvm.load"(%1) : (!llvm.ptr<f32>) -> f32
    %5 = "llvm.fmul"(%3, %4) : (f32, f32) -> f32
    %6 = "llvm.call"(%5) {callee = @llvm.sqrt.f32, fastmathFlags = #llvm.fastmath<>} : (f32) -> f32
    "llvm.return"(%6) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "mysqrt", type = !llvm.func<f32 (f32, f32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.sqrt.f32", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64, %arg1: f64):  // no predecessors
    %0 = "llvm.fmul"(%arg0, %arg0) : (f64, f64) -> f64
    %1 = "llvm.call"(%0) {callee = @sqrtf, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "fake_sqrt", type = !llvm.func<f64 (f64, f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "sqrtf", type = !llvm.func<f64 (f64)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
