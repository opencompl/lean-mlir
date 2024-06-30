"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -2 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %2 = "llvm.alloca"(%1) : (i32) -> !llvm.ptr<i32>
    %3 = "llvm.alloca"(%1) : (i32) -> !llvm.ptr<i32>
    "llvm.store"(%arg0, %2) : (i32, !llvm.ptr<i32>) -> ()
    %4 = "llvm.load"(%2) : (!llvm.ptr<i32>) -> i32
    %5 = "llvm.sub"(%1, %4) : (i32, i32) -> i32
    %6 = "llvm.mul"(%5, %0) : (i32, i32) -> i32
    "llvm.store"(%6, %3) : (i32, !llvm.ptr<i32>) -> ()
    %7 = "llvm.load"(%3) : (!llvm.ptr<i32>) -> i32
    %8 = "llvm.trunc"(%7) : (i32) -> i16
    "llvm.return"(%8) : (i16) -> ()
  }) {linkage = 10 : i64, sym_name = "foo1", type = !llvm.func<i16 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -4 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %2 = "llvm.alloca"(%1) : (i32) -> !llvm.ptr<i32>
    %3 = "llvm.alloca"(%1) : (i32) -> !llvm.ptr<i32>
    %4 = "llvm.alloca"(%1) : (i32) -> !llvm.ptr<i32>
    "llvm.store"(%arg0, %2) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.store"(%arg1, %3) : (i32, !llvm.ptr<i32>) -> ()
    %5 = "llvm.load"(%3) : (!llvm.ptr<i32>) -> i32
    %6 = "llvm.load"(%2) : (!llvm.ptr<i32>) -> i32
    %7 = "llvm.sub"(%5, %6) : (i32, i32) -> i32
    %8 = "llvm.mul"(%7, %0) : (i32, i32) -> i32
    "llvm.store"(%8, %4) : (i32, !llvm.ptr<i32>) -> ()
    %9 = "llvm.load"(%4) : (!llvm.ptr<i32>) -> i32
    %10 = "llvm.trunc"(%9) : (i32) -> i16
    "llvm.return"(%10) : (i16) -> ()
  }) {linkage = 10 : i64, sym_name = "foo2", type = !llvm.func<i16 (i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -4 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 7 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %3 = "llvm.alloca"(%2) : (i32) -> !llvm.ptr<i32>
    %4 = "llvm.alloca"(%2) : (i32) -> !llvm.ptr<i32>
    "llvm.store"(%arg0, %3) : (i32, !llvm.ptr<i32>) -> ()
    %5 = "llvm.load"(%3) : (!llvm.ptr<i32>) -> i32
    %6 = "llvm.sub"(%1, %5) : (i32, i32) -> i32
    %7 = "llvm.mul"(%6, %0) : (i32, i32) -> i32
    "llvm.store"(%7, %4) : (i32, !llvm.ptr<i32>) -> ()
    %8 = "llvm.load"(%4) : (!llvm.ptr<i32>) -> i32
    %9 = "llvm.trunc"(%8) : (i32) -> i16
    "llvm.return"(%9) : (i16) -> ()
  }) {linkage = 10 : i64, sym_name = "foo3", type = !llvm.func<i16 (i32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
