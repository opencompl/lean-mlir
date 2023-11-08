"module"() ( {
  "llvm.func"() ( {
    %0 = "llvm.mlir.addressof"() {global_name = @f} : () -> !llvm.ptr<func<i32 (ptr<i8>)>>
    %1 = "llvm.bitcast"(%0) : (!llvm.ptr<func<i32 (ptr<i8>)>>) -> !llvm.ptr<func<i32 (...)>>
    %2 = "llvm.mlir.constant"() {value = 3.000000e+00 : f64} : () -> f64
    %3 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %4 = "llvm.alloca"(%3) : (i32) -> !llvm.ptr<i32>
    %5 = "llvm.call"(%1, %2) : (!llvm.ptr<func<i32 (...)>>, f64) -> i32
    "llvm.br"()[^bb1] : () -> ()
  ^bb1:  // pred: ^bb0
    %6 = "llvm.load"(%4) : (!llvm.ptr<i32>) -> i32
    "llvm.return"(%6) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "bar", type = !llvm.func<i32 ()>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.alloca"(%0) : (i32) -> !llvm.ptr<ptr<i8>>
    %2 = "llvm.alloca"(%0) : (i32) -> !llvm.ptr<i32>
    "llvm.store"(%arg0, %1) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>) -> ()
    "llvm.br"()[^bb1] : () -> ()
  ^bb1:  // pred: ^bb0
    %3 = "llvm.load"(%2) : (!llvm.ptr<i32>) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "f", type = !llvm.func<i32 (ptr<i8>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
