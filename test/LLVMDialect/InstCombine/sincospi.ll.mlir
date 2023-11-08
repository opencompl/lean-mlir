"module"() ( {
  "llvm.mlir.global"() ( {
  }) {linkage = 10 : i64, sym_name = "var32", type = f32, value = 0.000000e+00 : f32} : () -> ()
  "llvm.mlir.global"() ( {
  }) {linkage = 10 : i64, sym_name = "var64", type = f64, value = 0.000000e+00 : f64} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "__sinpif", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "__cospif", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "__sinpi", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "__cospi", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.addressof"() {global_name = @var32} : () -> !llvm.ptr<f32>
    %1 = "llvm.load"(%0) : (!llvm.ptr<f32>) -> f32
    %2 = "llvm.call"(%1) {callee = @__sinpif, fastmathFlags = #llvm.fastmath<>} : (f32) -> f32
    %3 = "llvm.call"(%1) {callee = @__cospif, fastmathFlags = #llvm.fastmath<>} : (f32) -> f32
    %4 = "llvm.fadd"(%2, %3) : (f32, f32) -> f32
    "llvm.return"(%4) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_instbased_f32", type = !llvm.func<f32 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 1.000000e+00 : f32} : () -> f32
    %1 = "llvm.call"(%0) {callee = @__sinpif, fastmathFlags = #llvm.fastmath<>} : (f32) -> f32
    %2 = "llvm.call"(%0) {callee = @__cospif, fastmathFlags = #llvm.fastmath<>} : (f32) -> f32
    %3 = "llvm.fadd"(%1, %2) : (f32, f32) -> f32
    "llvm.return"(%3) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_constant_f32", type = !llvm.func<f32 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.addressof"() {global_name = @var64} : () -> !llvm.ptr<f64>
    %1 = "llvm.load"(%0) : (!llvm.ptr<f64>) -> f64
    %2 = "llvm.call"(%1) {callee = @__sinpi, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %3 = "llvm.call"(%1) {callee = @__cospi, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %4 = "llvm.fadd"(%2, %3) : (f64, f64) -> f64
    "llvm.return"(%4) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "test_instbased_f64", type = !llvm.func<f64 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 1.000000e+00 : f64} : () -> f64
    %1 = "llvm.call"(%0) {callee = @__sinpi, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.call"(%0) {callee = @__cospi, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %3 = "llvm.fadd"(%1, %2) : (f64, f64) -> f64
    "llvm.return"(%3) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "test_constant_f64", type = !llvm.func<f64 ()>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<func<f64 (f64)>>, %arg1: f64):  // no predecessors
    %0 = "llvm.call"(%arg1) {callee = @__sinpi, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %1 = "llvm.call"(%arg0, %arg1) : (!llvm.ptr<func<f64 (f64)>>, f64) -> f64
    %2 = "llvm.fadd"(%0, %1) : (f64, f64) -> f64
    "llvm.return"(%2) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "test_fptr", type = !llvm.func<f64 (ptr<func<f64 (f64)>>, f64)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
