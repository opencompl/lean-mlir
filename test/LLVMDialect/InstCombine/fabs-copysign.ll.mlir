"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.fabs.f64", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.fabs.f32", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.fabs.v4f64", type = !llvm.func<vector<4xf64> (vector<4xf64>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "use", type = !llvm.func<void (f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.copysign.f64", type = !llvm.func<f64 (f64, f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.copysign.f32", type = !llvm.func<f32 (f32, f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @llvm.fabs.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %1 = "llvm.fdiv"(%arg0, %0) : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "fabs_copysign", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @llvm.fabs.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %1 = "llvm.fdiv"(%0, %arg0) : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "fabs_copysign_commuted", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<4xf64>):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @llvm.fabs.v4f64, fastmathFlags = #llvm.fastmath<>} : (vector<4xf64>) -> vector<4xf64>
    %1 = "llvm.fdiv"(%arg0, %0) : (vector<4xf64>, vector<4xf64>) -> vector<4xf64>
    "llvm.return"(%1) : (vector<4xf64>) -> ()
  }) {linkage = 10 : i64, sym_name = "fabs_copysign_vec", type = !llvm.func<vector<4xf64> (vector<4xf64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<4xf64>):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @llvm.fabs.v4f64, fastmathFlags = #llvm.fastmath<>} : (vector<4xf64>) -> vector<4xf64>
    %1 = "llvm.fdiv"(%0, %arg0) : (vector<4xf64>, vector<4xf64>) -> vector<4xf64>
    "llvm.return"(%1) : (vector<4xf64>) -> ()
  }) {linkage = 10 : i64, sym_name = "fabs_copysign_vec_commuted", type = !llvm.func<vector<4xf64> (vector<4xf64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @llvm.fabs.f32, fastmathFlags = #llvm.fastmath<>} : (f32) -> f32
    %1 = "llvm.fdiv"(%arg0, %0) : (f32, f32) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "fabs_copysignf", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @llvm.fabs.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    "llvm.call"(%0) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (f64) -> ()
    %1 = "llvm.fdiv"(%arg0, %0) : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "fabs_copysign_use", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64, %arg1: f64):  // no predecessors
    %0 = "llvm.call"(%arg1) {callee = @llvm.fabs.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %1 = "llvm.fdiv"(%arg0, %0) : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "fabs_copysign_mismatch", type = !llvm.func<f64 (f64, f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64, %arg1: f64):  // no predecessors
    %0 = "llvm.call"(%arg1) {callee = @llvm.fabs.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %1 = "llvm.fdiv"(%0, %arg0) : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "fabs_copysign_commuted_mismatch", type = !llvm.func<f64 (f64, f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @llvm.fabs.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %1 = "llvm.fdiv"(%arg0, %0) : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "fabs_copysign_no_nnan", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @llvm.fabs.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %1 = "llvm.fdiv"(%arg0, %0) : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "fabs_copysign_no_ninf", type = !llvm.func<f64 (f64)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
