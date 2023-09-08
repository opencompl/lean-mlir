"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: f32, %arg2: f32):  // no predecessors
    %0 = "llvm.fmul"(%arg0, %arg2) : (f32, f32) -> f32
    %1 = "llvm.fmul"(%arg1, %arg2) : (f32, f32) -> f32
    %2 = "llvm.fadd"(%0, %1) : (f32, f32) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "fmul_fadd", type = !llvm.func<f32 (f32, f32, f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>):  // no predecessors
    %0 = "llvm.fmul"(%arg2, %arg0) : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %1 = "llvm.fmul"(%arg2, %arg1) : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %2 = "llvm.fadd"(%0, %1) : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    "llvm.return"(%2) : (vector<2xf32>) -> ()
  }) {linkage = 10 : i64, sym_name = "fmul_fadd_commute1_vec", type = !llvm.func<vector<2xf32> (vector<2xf32>, vector<2xf32>, vector<2xf32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>):  // no predecessors
    %0 = "llvm.fmul"(%arg0, %arg2) : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %1 = "llvm.fmul"(%arg2, %arg1) : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %2 = "llvm.fadd"(%0, %1) : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    "llvm.return"(%2) : (vector<2xf32>) -> ()
  }) {linkage = 10 : i64, sym_name = "fmul_fadd_commute2_vec", type = !llvm.func<vector<2xf32> (vector<2xf32>, vector<2xf32>, vector<2xf32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64, %arg1: f64, %arg2: f64):  // no predecessors
    %0 = "llvm.fmul"(%arg2, %arg0) : (f64, f64) -> f64
    %1 = "llvm.fmul"(%arg1, %arg2) : (f64, f64) -> f64
    %2 = "llvm.fadd"(%0, %1) : (f64, f64) -> f64
    "llvm.return"(%2) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "fmul_fadd_commute3", type = !llvm.func<f64 (f64, f64, f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: f32, %arg2: f32):  // no predecessors
    %0 = "llvm.fmul"(%arg0, %arg2) : (f32, f32) -> f32
    %1 = "llvm.fmul"(%arg1, %arg2) : (f32, f32) -> f32
    %2 = "llvm.fadd"(%0, %1) : (f32, f32) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "fmul_fadd_not_enough_FMF", type = !llvm.func<f32 (f32, f32, f32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "use", type = !llvm.func<void (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: f32, %arg2: f32):  // no predecessors
    %0 = "llvm.fmul"(%arg2, %arg0) : (f32, f32) -> f32
    %1 = "llvm.fmul"(%arg1, %arg2) : (f32, f32) -> f32
    %2 = "llvm.fadd"(%0, %1) : (f32, f32) -> f32
    "llvm.call"(%0) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (f32) -> ()
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "fmul_fadd_uses1", type = !llvm.func<f32 (f32, f32, f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: f32, %arg2: f32):  // no predecessors
    %0 = "llvm.fmul"(%arg2, %arg0) : (f32, f32) -> f32
    %1 = "llvm.fmul"(%arg2, %arg1) : (f32, f32) -> f32
    %2 = "llvm.fadd"(%0, %1) : (f32, f32) -> f32
    "llvm.call"(%1) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (f32) -> ()
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "fmul_fadd_uses2", type = !llvm.func<f32 (f32, f32, f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: f32, %arg2: f32):  // no predecessors
    %0 = "llvm.fmul"(%arg0, %arg2) : (f32, f32) -> f32
    %1 = "llvm.fmul"(%arg2, %arg1) : (f32, f32) -> f32
    %2 = "llvm.fadd"(%0, %1) : (f32, f32) -> f32
    "llvm.call"(%0) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (f32) -> ()
    "llvm.call"(%1) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (f32) -> ()
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "fmul_fadd_uses3", type = !llvm.func<f32 (f32, f32, f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f16, %arg1: f16, %arg2: f16):  // no predecessors
    %0 = "llvm.fmul"(%arg0, %arg2) : (f16, f16) -> f16
    %1 = "llvm.fmul"(%arg1, %arg2) : (f16, f16) -> f16
    %2 = "llvm.fsub"(%0, %1) : (f16, f16) -> f16
    "llvm.return"(%2) : (f16) -> ()
  }) {linkage = 10 : i64, sym_name = "fmul_fsub", type = !llvm.func<f16 (f16, f16, f16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>):  // no predecessors
    %0 = "llvm.fmul"(%arg2, %arg0) : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %1 = "llvm.fmul"(%arg1, %arg2) : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %2 = "llvm.fsub"(%0, %1) : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    "llvm.return"(%2) : (vector<2xf32>) -> ()
  }) {linkage = 10 : i64, sym_name = "fmul_fsub_commute1_vec", type = !llvm.func<vector<2xf32> (vector<2xf32>, vector<2xf32>, vector<2xf32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>):  // no predecessors
    %0 = "llvm.fmul"(%arg0, %arg2) : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %1 = "llvm.fmul"(%arg2, %arg1) : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %2 = "llvm.fsub"(%0, %1) : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    "llvm.return"(%2) : (vector<2xf32>) -> ()
  }) {linkage = 10 : i64, sym_name = "fmul_fsub_commute2_vec", type = !llvm.func<vector<2xf32> (vector<2xf32>, vector<2xf32>, vector<2xf32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64, %arg1: f64, %arg2: f64):  // no predecessors
    %0 = "llvm.fmul"(%arg2, %arg0) : (f64, f64) -> f64
    %1 = "llvm.fmul"(%arg2, %arg1) : (f64, f64) -> f64
    %2 = "llvm.fsub"(%0, %1) : (f64, f64) -> f64
    "llvm.return"(%2) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "fmul_fsub_commute3", type = !llvm.func<f64 (f64, f64, f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: f32, %arg2: f32):  // no predecessors
    %0 = "llvm.fmul"(%arg2, %arg0) : (f32, f32) -> f32
    %1 = "llvm.fmul"(%arg1, %arg2) : (f32, f32) -> f32
    %2 = "llvm.fsub"(%0, %1) : (f32, f32) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "fmul_fsub_not_enough_FMF", type = !llvm.func<f32 (f32, f32, f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: f32, %arg2: f32):  // no predecessors
    %0 = "llvm.fmul"(%arg0, %arg2) : (f32, f32) -> f32
    %1 = "llvm.fmul"(%arg1, %arg2) : (f32, f32) -> f32
    %2 = "llvm.fsub"(%0, %1) : (f32, f32) -> f32
    "llvm.call"(%0) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (f32) -> ()
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "fmul_fsub_uses1", type = !llvm.func<f32 (f32, f32, f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: f32, %arg2: f32):  // no predecessors
    %0 = "llvm.fmul"(%arg2, %arg0) : (f32, f32) -> f32
    %1 = "llvm.fmul"(%arg2, %arg1) : (f32, f32) -> f32
    %2 = "llvm.fsub"(%0, %1) : (f32, f32) -> f32
    "llvm.call"(%1) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (f32) -> ()
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "fmul_fsub_uses2", type = !llvm.func<f32 (f32, f32, f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: f32, %arg2: f32):  // no predecessors
    %0 = "llvm.fmul"(%arg0, %arg2) : (f32, f32) -> f32
    %1 = "llvm.fmul"(%arg1, %arg2) : (f32, f32) -> f32
    %2 = "llvm.fsub"(%0, %1) : (f32, f32) -> f32
    "llvm.call"(%0) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (f32) -> ()
    "llvm.call"(%1) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (f32) -> ()
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "fmul_fsub_uses3", type = !llvm.func<f32 (f32, f32, f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64, %arg1: f64, %arg2: f64):  // no predecessors
    %0 = "llvm.fdiv"(%arg0, %arg2) : (f64, f64) -> f64
    %1 = "llvm.fdiv"(%arg1, %arg2) : (f64, f64) -> f64
    %2 = "llvm.fadd"(%0, %1) : (f64, f64) -> f64
    "llvm.return"(%2) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "fdiv_fadd", type = !llvm.func<f64 (f64, f64, f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: f32, %arg2: f32):  // no predecessors
    %0 = "llvm.fdiv"(%arg0, %arg2) : (f32, f32) -> f32
    %1 = "llvm.fdiv"(%arg1, %arg2) : (f32, f32) -> f32
    %2 = "llvm.fsub"(%0, %1) : (f32, f32) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "fdiv_fsub", type = !llvm.func<f32 (f32, f32, f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xf64>, %arg1: vector<2xf64>, %arg2: vector<2xf64>):  // no predecessors
    %0 = "llvm.fdiv"(%arg0, %arg2) : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    %1 = "llvm.fdiv"(%arg1, %arg2) : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    %2 = "llvm.fadd"(%0, %1) : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    "llvm.return"(%2) : (vector<2xf64>) -> ()
  }) {linkage = 10 : i64, sym_name = "fdiv_fadd_vec", type = !llvm.func<vector<2xf64> (vector<2xf64>, vector<2xf64>, vector<2xf64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>):  // no predecessors
    %0 = "llvm.fdiv"(%arg0, %arg2) : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %1 = "llvm.fdiv"(%arg1, %arg2) : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %2 = "llvm.fsub"(%0, %1) : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    "llvm.return"(%2) : (vector<2xf32>) -> ()
  }) {linkage = 10 : i64, sym_name = "fdiv_fsub_vec", type = !llvm.func<vector<2xf32> (vector<2xf32>, vector<2xf32>, vector<2xf32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: f32, %arg2: f32):  // no predecessors
    %0 = "llvm.fdiv"(%arg2, %arg1) : (f32, f32) -> f32
    %1 = "llvm.fdiv"(%arg2, %arg0) : (f32, f32) -> f32
    %2 = "llvm.fadd"(%0, %1) : (f32, f32) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "fdiv_fadd_commute1", type = !llvm.func<f32 (f32, f32, f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: f32, %arg2: f32):  // no predecessors
    %0 = "llvm.fdiv"(%arg2, %arg1) : (f32, f32) -> f32
    %1 = "llvm.fdiv"(%arg0, %arg2) : (f32, f32) -> f32
    %2 = "llvm.fsub"(%0, %1) : (f32, f32) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "fdiv_fsub_commute2", type = !llvm.func<f32 (f32, f32, f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: f32, %arg2: f32):  // no predecessors
    %0 = "llvm.fdiv"(%arg1, %arg0) : (f32, f32) -> f32
    %1 = "llvm.fdiv"(%arg2, %arg0) : (f32, f32) -> f32
    %2 = "llvm.fadd"(%0, %1) : (f32, f32) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "fdiv_fadd_not_enough_FMF", type = !llvm.func<f32 (f32, f32, f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: f32, %arg2: f32):  // no predecessors
    %0 = "llvm.fdiv"(%arg1, %arg0) : (f32, f32) -> f32
    %1 = "llvm.fdiv"(%arg2, %arg0) : (f32, f32) -> f32
    %2 = "llvm.fsub"(%0, %1) : (f32, f32) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "fdiv_fsub_not_enough_FMF", type = !llvm.func<f32 (f32, f32, f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: f32, %arg2: f32):  // no predecessors
    %0 = "llvm.fdiv"(%arg0, %arg2) : (f32, f32) -> f32
    %1 = "llvm.fdiv"(%arg1, %arg2) : (f32, f32) -> f32
    %2 = "llvm.fadd"(%0, %1) : (f32, f32) -> f32
    "llvm.call"(%0) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (f32) -> ()
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "fdiv_fadd_uses1", type = !llvm.func<f32 (f32, f32, f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: f32, %arg2: f32):  // no predecessors
    %0 = "llvm.fdiv"(%arg0, %arg2) : (f32, f32) -> f32
    %1 = "llvm.fdiv"(%arg1, %arg2) : (f32, f32) -> f32
    %2 = "llvm.fsub"(%0, %1) : (f32, f32) -> f32
    "llvm.call"(%1) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (f32) -> ()
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "fdiv_fsub_uses2", type = !llvm.func<f32 (f32, f32, f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: f32, %arg2: f32):  // no predecessors
    %0 = "llvm.fdiv"(%arg0, %arg2) : (f32, f32) -> f32
    %1 = "llvm.fdiv"(%arg1, %arg2) : (f32, f32) -> f32
    %2 = "llvm.fsub"(%0, %1) : (f32, f32) -> f32
    "llvm.call"(%0) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (f32) -> ()
    "llvm.call"(%1) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (f32) -> ()
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "fdiv_fsub_uses3", type = !llvm.func<f32 (f32, f32, f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5.87747175E-39 : f32} : () -> f32
    %1 = "llvm.mlir.constant"() {value = 1.17549435E-38 : f32} : () -> f32
    %2 = "llvm.fdiv"(%1, %arg0) : (f32, f32) -> f32
    %3 = "llvm.fdiv"(%0, %arg0) : (f32, f32) -> f32
    %4 = "llvm.fadd"(%2, %3) : (f32, f32) -> f32
    "llvm.return"(%4) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "fdiv_fadd_not_denorm", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5.87747175E-39 : f32} : () -> f32
    %1 = "llvm.mlir.constant"() {value = -1.17549435E-38 : f32} : () -> f32
    %2 = "llvm.fdiv"(%1, %arg0) : (f32, f32) -> f32
    %3 = "llvm.fdiv"(%0, %arg0) : (f32, f32) -> f32
    %4 = "llvm.fadd"(%2, %3) : (f32, f32) -> f32
    "llvm.return"(%4) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "fdiv_fadd_denorm", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5.87747175E-39 : f32} : () -> f32
    %1 = "llvm.mlir.constant"() {value = 1.17549435E-38 : f32} : () -> f32
    %2 = "llvm.fdiv"(%1, %arg0) : (f32, f32) -> f32
    %3 = "llvm.fdiv"(%0, %arg0) : (f32, f32) -> f32
    %4 = "llvm.fsub"(%2, %3) : (f32, f32) -> f32
    "llvm.return"(%4) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "fdiv_fsub_denorm", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: f32, %arg2: f32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1.000000e+00 : f32} : () -> f32
    %1 = "llvm.fsub"(%0, %arg2) : (f32, f32) -> f32
    %2 = "llvm.fmul"(%1, %arg0) : (f32, f32) -> f32
    %3 = "llvm.fmul"(%arg2, %arg1) : (f32, f32) -> f32
    %4 = "llvm.fadd"(%2, %3) : (f32, f32) -> f32
    "llvm.return"(%4) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "lerp_commute0", type = !llvm.func<f32 (f32, f32, f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<1.000000e+00> : vector<2xf32>} : () -> vector<2xf32>
    %1 = "llvm.fsub"(%0, %arg2) : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %2 = "llvm.fmul"(%1, %arg0) : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %3 = "llvm.fmul"(%arg2, %arg1) : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %4 = "llvm.fadd"(%3, %2) : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    "llvm.return"(%4) : (vector<2xf32>) -> ()
  }) {linkage = 10 : i64, sym_name = "lerp_commute1", type = !llvm.func<vector<2xf32> (vector<2xf32>, vector<2xf32>, vector<2xf32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: f32, %arg2: f32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1.000000e+00 : f32} : () -> f32
    %1 = "llvm.fsub"(%0, %arg2) : (f32, f32) -> f32
    %2 = "llvm.fmul"(%1, %arg0) : (f32, f32) -> f32
    %3 = "llvm.fmul"(%arg1, %arg2) : (f32, f32) -> f32
    %4 = "llvm.fadd"(%2, %3) : (f32, f32) -> f32
    "llvm.return"(%4) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "lerp_commute2", type = !llvm.func<f32 (f32, f32, f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: f32, %arg2: f32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1.000000e+00 : f32} : () -> f32
    %1 = "llvm.fsub"(%0, %arg2) : (f32, f32) -> f32
    %2 = "llvm.fmul"(%1, %arg0) : (f32, f32) -> f32
    %3 = "llvm.fmul"(%arg1, %arg2) : (f32, f32) -> f32
    %4 = "llvm.fadd"(%3, %2) : (f32, f32) -> f32
    "llvm.return"(%4) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "lerp_commute3", type = !llvm.func<f32 (f32, f32, f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64, %arg1: f64, %arg2: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1.000000e+00 : f64} : () -> f64
    %1 = "llvm.fsub"(%0, %arg2) : (f64, f64) -> f64
    %2 = "llvm.fmul"(%arg0, %1) : (f64, f64) -> f64
    %3 = "llvm.fmul"(%arg2, %arg1) : (f64, f64) -> f64
    %4 = "llvm.fadd"(%2, %3) : (f64, f64) -> f64
    "llvm.return"(%4) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "lerp_commute4", type = !llvm.func<f64 (f64, f64, f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64, %arg1: f64, %arg2: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1.000000e+00 : f64} : () -> f64
    %1 = "llvm.fsub"(%0, %arg2) : (f64, f64) -> f64
    %2 = "llvm.fmul"(%arg0, %1) : (f64, f64) -> f64
    %3 = "llvm.fmul"(%arg2, %arg1) : (f64, f64) -> f64
    %4 = "llvm.fadd"(%3, %2) : (f64, f64) -> f64
    "llvm.return"(%4) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "lerp_commute5", type = !llvm.func<f64 (f64, f64, f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f16, %arg1: f16, %arg2: f16):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1.000000e+00 : f32} : () -> f16
    %1 = "llvm.fsub"(%0, %arg2) : (f16, f16) -> f16
    %2 = "llvm.fmul"(%arg0, %1) : (f16, f16) -> f16
    %3 = "llvm.fmul"(%arg1, %arg2) : (f16, f16) -> f16
    %4 = "llvm.fadd"(%2, %3) : (f16, f16) -> f16
    "llvm.return"(%4) : (f16) -> ()
  }) {linkage = 10 : i64, sym_name = "lerp_commute6", type = !llvm.func<f16 (f16, f16, f16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f16, %arg1: f16, %arg2: f16):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1.000000e+00 : f32} : () -> f16
    %1 = "llvm.fsub"(%0, %arg2) : (f16, f16) -> f16
    %2 = "llvm.fmul"(%arg0, %1) : (f16, f16) -> f16
    %3 = "llvm.fmul"(%arg1, %arg2) : (f16, f16) -> f16
    %4 = "llvm.fadd"(%3, %2) : (f16, f16) -> f16
    "llvm.return"(%4) : (f16) -> ()
  }) {linkage = 10 : i64, sym_name = "lerp_commute7", type = !llvm.func<f16 (f16, f16, f16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: f32, %arg2: f32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1.000000e+00 : f32} : () -> f32
    %1 = "llvm.fsub"(%0, %arg2) : (f32, f32) -> f32
    %2 = "llvm.fmul"(%arg0, %1) : (f32, f32) -> f32
    %3 = "llvm.fmul"(%arg1, %arg2) : (f32, f32) -> f32
    "llvm.call"(%3) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (f32) -> ()
    %4 = "llvm.fadd"(%3, %2) : (f32, f32) -> f32
    "llvm.return"(%4) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "lerp_extra_use1", type = !llvm.func<f32 (f32, f32, f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: f32, %arg2: f32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1.000000e+00 : f32} : () -> f32
    %1 = "llvm.fsub"(%0, %arg2) : (f32, f32) -> f32
    %2 = "llvm.fmul"(%arg0, %1) : (f32, f32) -> f32
    "llvm.call"(%2) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (f32) -> ()
    %3 = "llvm.fmul"(%arg1, %arg2) : (f32, f32) -> f32
    %4 = "llvm.fadd"(%3, %2) : (f32, f32) -> f32
    "llvm.return"(%4) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "lerp_extra_use2", type = !llvm.func<f32 (f32, f32, f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: f32, %arg2: f32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1.000000e+00 : f32} : () -> f32
    %1 = "llvm.fsub"(%0, %arg2) : (f32, f32) -> f32
    "llvm.call"(%1) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (f32) -> ()
    %2 = "llvm.fmul"(%arg0, %1) : (f32, f32) -> f32
    %3 = "llvm.fmul"(%arg1, %arg2) : (f32, f32) -> f32
    %4 = "llvm.fadd"(%3, %2) : (f32, f32) -> f32
    "llvm.return"(%4) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "lerp_extra_use3", type = !llvm.func<f32 (f32, f32, f32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
