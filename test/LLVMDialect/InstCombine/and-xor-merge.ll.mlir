"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i32):  // no predecessors
    %0 = "llvm.and"(%arg2, %arg0) : (i32, i32) -> i32
    %1 = "llvm.and"(%arg2, %arg1) : (i32, i32) -> i32
    %2 = "llvm.xor"(%0, %1) : (i32, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test1", type = !llvm.func<i32 (i32, i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i32):  // no predecessors
    %0 = "llvm.and"(%arg1, %arg0) : (i32, i32) -> i32
    %1 = "llvm.or"(%arg1, %arg0) : (i32, i32) -> i32
    %2 = "llvm.xor"(%0, %1) : (i32, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test2", type = !llvm.func<i32 (i32, i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 31 : i32} : () -> i32
    %2 = "llvm.lshr"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.xor"(%2, %0) : (i32, i32) -> i32
    %4 = "llvm.lshr"(%arg1, %1) : (i32, i32) -> i32
    %5 = "llvm.xor"(%4, %0) : (i32, i32) -> i32
    %6 = "llvm.and"(%5, %3) : (i32, i32) -> i32
    "llvm.return"(%6) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "PR38781", type = !llvm.func<i32 (i32, i32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
