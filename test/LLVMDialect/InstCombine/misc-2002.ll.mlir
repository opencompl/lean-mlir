"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.add"(%arg0, %0) : (i32, i32) -> i32
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "hang_2002-03-11", type = !llvm.func<void (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 2 : i32} : () -> i32
    %1 = "llvm.mul"(%arg0, %arg1) : (i32, i32) -> i32
    %2 = "llvm.sub"(%0, %1) : (i32, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "sub_failure_2002-05-14", type = !llvm.func<i32 (i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.trunc"(%arg0) : (i64) -> i8
    %1 = "llvm.zext"(%0) : (i8) -> i64
    "llvm.return"(%1) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "cast_test_2002-08-02", type = !llvm.func<i64 (i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %2 = "llvm.sub"(%1, %arg0) : (i32, i32) -> i32
    %3 = "llvm.sub"(%1, %0) : (i32, i32) -> i32
    %4 = "llvm.add"(%3, %0) : (i32, i32) -> i32
    %5 = "llvm.add"(%arg0, %4) : (i32, i32) -> i32
    %6 = "llvm.add"(%2, %5) : (i32, i32) -> i32
    "llvm.return"(%6) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "missed_const_prop_2002-12-05", type = !llvm.func<i32 (i32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
