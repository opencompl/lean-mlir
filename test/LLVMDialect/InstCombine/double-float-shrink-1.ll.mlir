"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @acos, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "acos_test1", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @acos, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "acos_test2", type = !llvm.func<f64 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @acosh, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "acosh_test1", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @acosh, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "acosh_test2", type = !llvm.func<f64 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @asin, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "asin_test1", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @asin, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "asin_test2", type = !llvm.func<f64 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @asinh, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "asinh_test1", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @asinh, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "asinh_test2", type = !llvm.func<f64 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @atan, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "atan_test1", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @atan, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "atan_test2", type = !llvm.func<f64 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @atanh, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "atanh_test1", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @atanh, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "atanh_test2", type = !llvm.func<f64 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @cbrt, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "cbrt_test1", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @cbrt, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "cbrt_test2", type = !llvm.func<f64 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @exp, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "exp_test1", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @exp, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "exp_test2", type = !llvm.func<f64 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @expm1, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "expm1_test1", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @expm1, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "expm1_test2", type = !llvm.func<f64 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @exp10, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "exp10_test1", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @exp10, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "exp10_test2", type = !llvm.func<f64 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @log, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "log_test1", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @log, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "log_test2", type = !llvm.func<f64 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @log10, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "log10_test1", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @log10, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "log10_test2", type = !llvm.func<f64 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @log1p, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "log1p_test1", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @log1p, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "log1p_test2", type = !llvm.func<f64 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @log2, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "log2_test1", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @log2, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "log2_test2", type = !llvm.func<f64 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @logb, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "logb_test1", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @logb, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "logb_test2", type = !llvm.func<f64 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.fpext"(%arg1) : (f32) -> f64
    %2 = "llvm.call"(%0, %1) {callee = @pow, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    %3 = "llvm.fptrunc"(%2) : (f64) -> f32
    "llvm.return"(%3) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_test1", type = !llvm.func<f32 (f32, f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.fpext"(%arg1) : (f32) -> f64
    %2 = "llvm.call"(%0, %1) {callee = @pow, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%2) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_test2", type = !llvm.func<f64 (f32, f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @sin, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "sin_test1", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @sin, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "sin_test2", type = !llvm.func<f64 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @sqrt, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "sqrt_test1", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @sqrt, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "sqrt_test2", type = !llvm.func<f64 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @llvm.sqrt.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "sqrt_int_test1", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @llvm.sqrt.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "sqrt_int_test2", type = !llvm.func<f64 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @tan, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "tan_test1", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @tan, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "tan_test2", type = !llvm.func<f64 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @tanh, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "tanh_test1", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @tanh, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "tanh_test2", type = !llvm.func<f64 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.fpext"(%arg1) : (f32) -> f64
    %2 = "llvm.call"(%0, %1) {callee = @fmax, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    %3 = "llvm.fptrunc"(%2) : (f64) -> f32
    "llvm.return"(%3) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "max1", type = !llvm.func<f32 (f32, f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f128
    %1 = "llvm.fpext"(%arg1) : (f32) -> f128
    %2 = "llvm.call"(%0, %1) {callee = @fmin, fastmathFlags = #llvm.fastmath<>} : (f128, f128) -> f128
    %3 = "llvm.fptrunc"(%2) : (f128) -> f32
    "llvm.return"(%3) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "fake_fmin", type = !llvm.func<f32 (f32, f32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "fmin", type = !llvm.func<f128 (f128, f128)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "fmax", type = !llvm.func<f64 (f64, f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "tanh", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "tan", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "sqrt", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.sqrt.f64", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "sin", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "pow", type = !llvm.func<f64 (f64, f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "log2", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "log1p", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "log10", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "log", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "logb", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "exp10", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "expm1", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "exp", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "cbrt", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "atanh", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "atan", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "acos", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "acosh", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "asin", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "asinh", type = !llvm.func<f64 (f64)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
