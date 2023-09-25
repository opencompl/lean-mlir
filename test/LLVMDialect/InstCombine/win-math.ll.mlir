"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "acos", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @acos, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "float_acos", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "asin", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @asin, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "float_asin", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "atan", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @atan, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "float_atan", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "atan2", type = !llvm.func<f64 (f64, f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.fpext"(%arg1) : (f32) -> f64
    %2 = "llvm.call"(%0, %1) {callee = @atan2, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    %3 = "llvm.fptrunc"(%2) : (f64) -> f32
    "llvm.return"(%3) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "float_atan2", type = !llvm.func<f32 (f32, f32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "ceil", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @ceil, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "float_ceil", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "_copysign", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @_copysign, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "float_copysign", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "cos", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @cos, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "float_cos", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "cosh", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @cosh, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "float_cosh", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "exp", type = !llvm.func<f64 (f64, f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.fpext"(%arg1) : (f32) -> f64
    %2 = "llvm.call"(%0, %1) {callee = @exp, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    %3 = "llvm.fptrunc"(%2) : (f64) -> f32
    "llvm.return"(%3) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "float_exp", type = !llvm.func<f32 (f32, f32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "fabs", type = !llvm.func<f64 (f64, f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.fpext"(%arg1) : (f32) -> f64
    %2 = "llvm.call"(%0, %1) {callee = @fabs, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    %3 = "llvm.fptrunc"(%2) : (f64) -> f32
    "llvm.return"(%3) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "float_fabs", type = !llvm.func<f32 (f32, f32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "floor", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @floor, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "float_floor", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "fmod", type = !llvm.func<f64 (f64, f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.fpext"(%arg1) : (f32) -> f64
    %2 = "llvm.call"(%0, %1) {callee = @fmod, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    %3 = "llvm.fptrunc"(%2) : (f64) -> f32
    "llvm.return"(%3) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "float_fmod", type = !llvm.func<f32 (f32, f32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "log", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @log, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "float_log", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "logb", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @logb, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "float_logb", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "pow", type = !llvm.func<f64 (f64, f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.fpext"(%arg1) : (f32) -> f64
    %2 = "llvm.call"(%0, %1) {callee = @pow, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    %3 = "llvm.fptrunc"(%2) : (f64) -> f32
    "llvm.return"(%3) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "float_pow", type = !llvm.func<f32 (f32, f32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "sin", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @sin, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "float_sin", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "sinh", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @sinh, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "float_sinh", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "sqrt", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @sqrt, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "float_sqrt", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "tan", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @tan, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "float_tan", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "tanh", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @tanh, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "float_tanh", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "round", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @round, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "float_round", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "powf", type = !llvm.func<f32 (f32, f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5.000000e-01 : f32} : () -> f32
    %1 = "llvm.call"(%arg0, %0) {callee = @powf, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "float_powsqrt", type = !llvm.func<f32 (f32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
