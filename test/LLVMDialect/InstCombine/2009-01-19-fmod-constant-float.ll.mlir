"module"() ( {
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 1.000000e+00 : f64} : () -> f64
    %1 = "llvm.mlir.constant"() {value = 1.000000e-01 : f64} : () -> f64
    %2 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %3 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %4 = "llvm.alloca"(%3) : (i32) -> !llvm.ptr<f32>
    %5 = "llvm.alloca"(%3) : (i32) -> !llvm.ptr<f32>
    %6 = "llvm.bitcast"(%2) : (i32) -> i32
    %7 = "llvm.frem"(%1, %0) : (f64, f64) -> f64
    %8 = "llvm.fptrunc"(%7) : (f64) -> f32
    "llvm.store"(%8, %5) : (f32, !llvm.ptr<f32>) -> ()
    %9 = "llvm.load"(%5) : (!llvm.ptr<f32>) -> f32
    "llvm.store"(%9, %4) : (f32, !llvm.ptr<f32>) -> ()
    "llvm.br"()[^bb1] : () -> ()
  ^bb1:  // pred: ^bb0
    %10 = "llvm.load"(%4) : (!llvm.ptr<f32>) -> f32
    "llvm.return"(%10) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test1", type = !llvm.func<f32 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 1.000000e+00 : f64} : () -> f64
    %1 = "llvm.mlir.constant"() {value = -1.000000e-01 : f64} : () -> f64
    %2 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %3 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %4 = "llvm.alloca"(%3) : (i32) -> !llvm.ptr<f32>
    %5 = "llvm.alloca"(%3) : (i32) -> !llvm.ptr<f32>
    %6 = "llvm.bitcast"(%2) : (i32) -> i32
    %7 = "llvm.frem"(%1, %0) : (f64, f64) -> f64
    %8 = "llvm.fptrunc"(%7) : (f64) -> f32
    "llvm.store"(%8, %5) : (f32, !llvm.ptr<f32>) -> ()
    %9 = "llvm.load"(%5) : (!llvm.ptr<f32>) -> f32
    "llvm.store"(%9, %4) : (f32, !llvm.ptr<f32>) -> ()
    "llvm.br"()[^bb1] : () -> ()
  ^bb1:  // pred: ^bb0
    %10 = "llvm.load"(%4) : (!llvm.ptr<f32>) -> f32
    "llvm.return"(%10) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test2", type = !llvm.func<f32 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = -1.000000e+00 : f64} : () -> f64
    %1 = "llvm.mlir.constant"() {value = 1.000000e-01 : f64} : () -> f64
    %2 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %3 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %4 = "llvm.alloca"(%3) : (i32) -> !llvm.ptr<f32>
    %5 = "llvm.alloca"(%3) : (i32) -> !llvm.ptr<f32>
    %6 = "llvm.bitcast"(%2) : (i32) -> i32
    %7 = "llvm.frem"(%1, %0) : (f64, f64) -> f64
    %8 = "llvm.fptrunc"(%7) : (f64) -> f32
    "llvm.store"(%8, %5) : (f32, !llvm.ptr<f32>) -> ()
    %9 = "llvm.load"(%5) : (!llvm.ptr<f32>) -> f32
    "llvm.store"(%9, %4) : (f32, !llvm.ptr<f32>) -> ()
    "llvm.br"()[^bb1] : () -> ()
  ^bb1:  // pred: ^bb0
    %10 = "llvm.load"(%4) : (!llvm.ptr<f32>) -> f32
    "llvm.return"(%10) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test3", type = !llvm.func<f32 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = -1.000000e+00 : f64} : () -> f64
    %1 = "llvm.mlir.constant"() {value = -1.000000e-01 : f64} : () -> f64
    %2 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %3 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %4 = "llvm.alloca"(%3) : (i32) -> !llvm.ptr<f32>
    %5 = "llvm.alloca"(%3) : (i32) -> !llvm.ptr<f32>
    %6 = "llvm.bitcast"(%2) : (i32) -> i32
    %7 = "llvm.frem"(%1, %0) : (f64, f64) -> f64
    %8 = "llvm.fptrunc"(%7) : (f64) -> f32
    "llvm.store"(%8, %5) : (f32, !llvm.ptr<f32>) -> ()
    %9 = "llvm.load"(%5) : (!llvm.ptr<f32>) -> f32
    "llvm.store"(%9, %4) : (f32, !llvm.ptr<f32>) -> ()
    "llvm.br"()[^bb1] : () -> ()
  ^bb1:  // pred: ^bb0
    %10 = "llvm.load"(%4) : (!llvm.ptr<f32>) -> f32
    "llvm.return"(%10) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test4", type = !llvm.func<f32 ()>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
