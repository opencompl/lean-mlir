"module"() ( {
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 1 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = 0 : i8} : () -> i8
    %2 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %3 = "llvm.mlir.constant"() {value = 10 : i32} : () -> i32
    %4 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %5 = "llvm.bitcast"(%4) : (i32) -> i32
    %6 = "llvm.call"(%3) {callee = @malloc, fastmathFlags = #llvm.fastmath<>} : (i32) -> !llvm.ptr<i8>
    %7 = "llvm.getelementptr"(%6, %2) : (!llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
    "llvm.store"(%1, %7) : (i8, !llvm.ptr<i8>) -> ()
    %8 = "llvm.getelementptr"(%6, %4) : (!llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
    "llvm.store"(%0, %8) : (i8, !llvm.ptr<i8>) -> ()
    %9 = "llvm.call"(%6) {callee = @strlen, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> i32
    %10 = "llvm.getelementptr"(%6, %4) : (!llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
    "llvm.store"(%1, %10) : (i8, !llvm.ptr<i8>) -> ()
    %11 = "llvm.call"(%6) {callee = @b, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> i32
    "llvm.br"()[^bb1] : () -> ()
  ^bb1:  // pred: ^bb0
    "llvm.return"(%9) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "a", type = !llvm.func<i32 ()>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "malloc", type = !llvm.func<ptr<i8> (i32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "strlen", type = !llvm.func<i32 (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "b", type = !llvm.func<i32 (...)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
