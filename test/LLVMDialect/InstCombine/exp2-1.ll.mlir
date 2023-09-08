"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "exp2", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "exp2f", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.sitofp"(%arg0) : (i32) -> f64
    %1 = "llvm.call"(%0) {callee = @exp2, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify1", type = !llvm.func<f64 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16):  // no predecessors
    %0 = "llvm.sitofp"(%arg0) : (i16) -> f64
    %1 = "llvm.call"(%0) {callee = @exp2, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify2", type = !llvm.func<f64 (i16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.sitofp"(%arg0) : (i8) -> f64
    %1 = "llvm.call"(%0) {callee = @exp2, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify3", type = !llvm.func<f64 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.sitofp"(%arg0) : (i32) -> f32
    %1 = "llvm.call"(%0) {callee = @exp2f, fastmathFlags = #llvm.fastmath<>} : (f32) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify4", type = !llvm.func<f32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.uitofp"(%arg0) : (i32) -> f64
    %1 = "llvm.call"(%0) {callee = @exp2, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "test_no_simplify1", type = !llvm.func<f64 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16):  // no predecessors
    %0 = "llvm.uitofp"(%arg0) : (i16) -> f64
    %1 = "llvm.call"(%0) {callee = @exp2, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify6", type = !llvm.func<f64 (i16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.uitofp"(%arg0) : (i8) -> f64
    %1 = "llvm.call"(%0) {callee = @exp2, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify7", type = !llvm.func<f64 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.uitofp"(%arg0) : (i8) -> f32
    %1 = "llvm.call"(%0) {callee = @exp2f, fastmathFlags = #llvm.fastmath<>} : (f32) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify8", type = !llvm.func<f32 (i8)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.exp2.f64", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.exp2.f32", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.uitofp"(%arg0) : (i8) -> f64
    %1 = "llvm.call"(%0) {callee = @llvm.exp2.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify9", type = !llvm.func<f64 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.uitofp"(%arg0) : (i8) -> f32
    %1 = "llvm.call"(%0) {callee = @llvm.exp2.f32, fastmathFlags = #llvm.fastmath<>} : (f32) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify10", type = !llvm.func<f32 (i8)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
