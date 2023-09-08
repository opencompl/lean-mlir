"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: f64, %arg1: f64):  // no predecessors
    %0 = "llvm.call"(%arg0, %arg1) {callee = @cabs, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%0) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "std_cabs", type = !llvm.func<f64 (f64, f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: f32):  // no predecessors
    %0 = "llvm.call"(%arg0, %arg1) {callee = @cabsf, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    "llvm.return"(%0) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "std_cabsf", type = !llvm.func<f32 (f32, f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f128, %arg1: f128):  // no predecessors
    %0 = "llvm.call"(%arg0, %arg1) {callee = @cabsl, fastmathFlags = #llvm.fastmath<>} : (f128, f128) -> f128
    "llvm.return"(%0) : (f128) -> ()
  }) {linkage = 10 : i64, sym_name = "std_cabsl", type = !llvm.func<f128 (f128, f128)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64, %arg1: f64):  // no predecessors
    %0 = "llvm.call"(%arg0, %arg1) {callee = @cabs, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%0) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "fast_cabs", type = !llvm.func<f64 (f64, f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: f32):  // no predecessors
    %0 = "llvm.call"(%arg0, %arg1) {callee = @cabsf, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    "llvm.return"(%0) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "fast_cabsf", type = !llvm.func<f32 (f32, f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f128, %arg1: f128):  // no predecessors
    %0 = "llvm.call"(%arg0, %arg1) {callee = @cabsl, fastmathFlags = #llvm.fastmath<>} : (f128, f128) -> f128
    "llvm.return"(%0) : (f128) -> ()
  }) {linkage = 10 : i64, sym_name = "fast_cabsl", type = !llvm.func<f128 (f128, f128)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "cabs", type = !llvm.func<f64 (f64, f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "cabsf", type = !llvm.func<f32 (f32, f32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "cabsl", type = !llvm.func<f128 (f128, f128)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
