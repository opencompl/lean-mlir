"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1.000000e+00 : f64} : () -> f64
    %1 = "llvm.mlir.constant"() {value = 24 : i32} : () -> i32
    %2 = "llvm.lshr"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.and"(%2, %arg1) : (i32, i32) -> i32
    %4 = "llvm.sitofp"(%3) : (i32) -> f64
    %5 = "llvm.fadd"(%4, %0) : (f64, f64) -> f64
    "llvm.return"(%5) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "x", type = !llvm.func<f64 (i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1.000000e+00 : f64} : () -> f64
    %1 = "llvm.mlir.constant"() {value = 1073741823 : i32} : () -> i32
    %2 = "llvm.and"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.sitofp"(%2) : (i32) -> f64
    %4 = "llvm.fadd"(%3, %0) : (f64, f64) -> f64
    "llvm.return"(%4) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "test", type = !llvm.func<f64 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1.000000e+00 : f32} : () -> f32
    %1 = "llvm.mlir.constant"() {value = 1073741823 : i32} : () -> i32
    %2 = "llvm.and"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.sitofp"(%2) : (i32) -> f32
    %4 = "llvm.fadd"(%3, %0) : (f32, f32) -> f32
    "llvm.return"(%4) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_neg", type = !llvm.func<f32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1073741823 : i32} : () -> i32
    %1 = "llvm.and"(%arg0, %0) : (i32, i32) -> i32
    %2 = "llvm.and"(%arg1, %0) : (i32, i32) -> i32
    %3 = "llvm.sitofp"(%1) : (i32) -> f64
    %4 = "llvm.sitofp"(%2) : (i32) -> f64
    %5 = "llvm.fadd"(%3, %4) : (f64, f64) -> f64
    "llvm.return"(%5) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "test_2", type = !llvm.func<f64 (i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1073741823 : i32} : () -> i32
    %1 = "llvm.and"(%arg0, %0) : (i32, i32) -> i32
    %2 = "llvm.and"(%arg1, %0) : (i32, i32) -> i32
    %3 = "llvm.sitofp"(%1) : (i32) -> f32
    %4 = "llvm.sitofp"(%2) : (i32) -> f32
    %5 = "llvm.fadd"(%3, %4) : (f32, f32) -> f32
    "llvm.return"(%5) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_2_neg", type = !llvm.func<f32 (i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1.000000e+00 : f32} : () -> f32
    %1 = "llvm.mlir.constant"() {value = 24 : i32} : () -> i32
    %2 = "llvm.lshr"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.and"(%2, %arg1) : (i32, i32) -> i32
    %4 = "llvm.sitofp"(%3) : (i32) -> f32
    %5 = "llvm.fadd"(%4, %0) : (f32, f32) -> f32
    "llvm.return"(%5) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_3", type = !llvm.func<f32 (i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<4xi32>, %arg1: vector<4xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<1073741823> : vector<4xi32>} : () -> vector<4xi32>
    %1 = "llvm.and"(%arg0, %0) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %2 = "llvm.and"(%arg1, %0) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %3 = "llvm.sitofp"(%1) : (vector<4xi32>) -> vector<4xf64>
    %4 = "llvm.sitofp"(%2) : (vector<4xi32>) -> vector<4xf64>
    %5 = "llvm.fadd"(%3, %4) : (vector<4xf64>, vector<4xf64>) -> vector<4xf64>
    "llvm.return"(%5) : (vector<4xf64>) -> ()
  }) {linkage = 10 : i64, sym_name = "test_4", type = !llvm.func<vector<4xf64> (vector<4xi32>, vector<4xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<4xi32>, %arg1: vector<4xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<1073741823> : vector<4xi32>} : () -> vector<4xi32>
    %1 = "llvm.and"(%arg0, %0) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %2 = "llvm.and"(%arg1, %0) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %3 = "llvm.sitofp"(%1) : (vector<4xi32>) -> vector<4xf32>
    %4 = "llvm.sitofp"(%2) : (vector<4xi32>) -> vector<4xf32>
    %5 = "llvm.fadd"(%3, %4) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "llvm.return"(%5) : (vector<4xf32>) -> ()
  }) {linkage = 10 : i64, sym_name = "test_4_neg", type = !llvm.func<vector<4xf32> (vector<4xi32>, vector<4xi32>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
