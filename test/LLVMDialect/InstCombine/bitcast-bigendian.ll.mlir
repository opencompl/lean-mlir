"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xf32>, %arg1: vector<2xi32>):  // no predecessors
    %0 = "llvm.bitcast"(%arg0) : (vector<2xf32>) -> i64
    %1 = "llvm.trunc"(%0) : (i64) -> i32
    %2 = "llvm.bitcast"(%1) : (i32) -> f32
    %3 = "llvm.bitcast"(%arg1) : (vector<2xi32>) -> i64
    %4 = "llvm.trunc"(%3) : (i64) -> i32
    %5 = "llvm.bitcast"(%4) : (i32) -> f32
    %6 = "llvm.fadd"(%2, %5) : (f32, f32) -> f32
    "llvm.return"(%6) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test2", type = !llvm.func<f32 (vector<2xf32>, vector<2xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xf32>, %arg1: vector<2xi64>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 64 : i128} : () -> i128
    %1 = "llvm.mlir.constant"() {value = 32 : i64} : () -> i64
    %2 = "llvm.bitcast"(%arg0) : (vector<2xf32>) -> i64
    %3 = "llvm.lshr"(%2, %1) : (i64, i64) -> i64
    %4 = "llvm.trunc"(%3) : (i64) -> i32
    %5 = "llvm.bitcast"(%4) : (i32) -> f32
    %6 = "llvm.bitcast"(%arg1) : (vector<2xi64>) -> i128
    %7 = "llvm.lshr"(%6, %0) : (i128, i128) -> i128
    %8 = "llvm.trunc"(%7) : (i128) -> i32
    %9 = "llvm.bitcast"(%8) : (i32) -> f32
    %10 = "llvm.fadd"(%5, %9) : (f32, f32) -> f32
    "llvm.return"(%10) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test3", type = !llvm.func<f32 (vector<2xf32>, vector<2xi64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 32 : i64} : () -> i64
    %1 = "llvm.zext"(%arg0) : (i32) -> i64
    %2 = "llvm.zext"(%arg1) : (i32) -> i64
    %3 = "llvm.shl"(%2, %0) : (i64, i64) -> i64
    %4 = "llvm.or"(%3, %1) : (i64, i64) -> i64
    %5 = "llvm.bitcast"(%4) : (i64) -> vector<2xi32>
    "llvm.return"(%5) : (vector<2xi32>) -> ()
  }) {linkage = 10 : i64, sym_name = "test4", type = !llvm.func<vector<2xi32> (i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: f32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 32 : i64} : () -> i64
    %1 = "llvm.bitcast"(%arg0) : (f32) -> i32
    %2 = "llvm.zext"(%1) : (i32) -> i64
    %3 = "llvm.bitcast"(%arg1) : (f32) -> i32
    %4 = "llvm.zext"(%3) : (i32) -> i64
    %5 = "llvm.shl"(%4, %0) : (i64, i64) -> i64
    %6 = "llvm.or"(%5, %2) : (i64, i64) -> i64
    %7 = "llvm.bitcast"(%6) : (i64) -> vector<2xf32>
    "llvm.return"(%7) : (vector<2xf32>) -> ()
  }) {linkage = 10 : i64, sym_name = "test5", type = !llvm.func<vector<2xf32> (f32, f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1109917696 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 32 : i64} : () -> i64
    %2 = "llvm.bitcast"(%arg0) : (f32) -> i32
    %3 = "llvm.zext"(%2) : (i32) -> i64
    %4 = "llvm.shl"(%3, %1) : (i64, i64) -> i64
    %5 = "llvm.or"(%4, %0) : (i64, i64) -> i64
    %6 = "llvm.bitcast"(%5) : (i64) -> vector<2xf32>
    "llvm.return"(%6) : (vector<2xf32>) -> ()
  }) {linkage = 10 : i64, sym_name = "test6", type = !llvm.func<vector<2xf32> (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<1xi64>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<[1, 2]> : vector<2xi32>} : () -> vector<2xi32>
    %1 = "llvm.bitcast"(%arg0) : (vector<1xi64>) -> vector<2xi32>
    %2 = "llvm.xor"(%0, %1) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    "llvm.return"(%2) : (vector<2xi32>) -> ()
  }) {linkage = 10 : i64, sym_name = "xor_bitcast_vec_to_vec", type = !llvm.func<vector<2xi32> (vector<1xi64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3 : i64} : () -> i64
    %1 = "llvm.bitcast"(%arg0) : (vector<2xi32>) -> i64
    %2 = "llvm.and"(%1, %0) : (i64, i64) -> i64
    "llvm.return"(%2) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "and_bitcast_vec_to_int", type = !llvm.func<i64 (vector<2xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<[1, 2]> : vector<2xi32>} : () -> vector<2xi32>
    %1 = "llvm.bitcast"(%arg0) : (i64) -> vector<2xi32>
    %2 = "llvm.or"(%1, %0) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    "llvm.return"(%2) : (vector<2xi32>) -> ()
  }) {linkage = 10 : i64, sym_name = "or_bitcast_int_to_vec", type = !llvm.func<vector<2xi32> (i64)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
