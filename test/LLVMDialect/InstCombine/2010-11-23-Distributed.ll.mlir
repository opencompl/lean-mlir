"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32):  // no predecessors
    %0 = "llvm.add"(%arg1, %arg0) : (i32, i32) -> i32
    %1 = "llvm.mul"(%0, %arg1) : (i32, i32) -> i32
    %2 = "llvm.mul"(%arg1, %arg1) : (i32, i32) -> i32
    %3 = "llvm.sub"(%1, %2) : (i32, i32) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "foo", type = !llvm.func<i32 (i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64, %arg1: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = -1 : i64} : () -> i64
    %2 = "llvm.and"(%arg1, %arg0) : (i64, i64) -> i64
    %3 = "llvm.xor"(%2, %1) : (i64, i64) -> i64
    %4 = "llvm.and"(%arg1, %3) : (i64, i64) -> i64
    %5 = "llvm.icmp"(%4, %0) {predicate = 0 : i64} : (i64, i64) -> i1
    "llvm.return"(%5) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "bar", type = !llvm.func<i1 (i64, i64)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
