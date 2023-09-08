"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i23):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i23} : () -> i23
    %1 = "llvm.xor"(%0, %arg0) : (i23, i23) -> i23
    %2 = "llvm.or"(%arg0, %1) : (i23, i23) -> i23
    "llvm.return"(%2) : (i23) -> ()
  }) {linkage = 10 : i64, sym_name = "test1", type = !llvm.func<i23 (i23)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i39, %arg1: i39):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -274877906944 : i39} : () -> i39
    %1 = "llvm.mlir.constant"() {value = -1 : i39} : () -> i39
    %2 = "llvm.mlir.constant"() {value = 274877906943 : i39} : () -> i39
    %3 = "llvm.xor"(%2, %1) : (i39, i39) -> i39
    %4 = "llvm.and"(%arg1, %0) : (i39, i39) -> i39
    %5 = "llvm.add"(%arg0, %4) : (i39, i39) -> i39
    %6 = "llvm.and"(%5, %3) : (i39, i39) -> i39
    %7 = "llvm.and"(%arg0, %2) : (i39, i39) -> i39
    %8 = "llvm.or"(%6, %7) : (i39, i39) -> i39
    "llvm.return"(%8) : (i39) -> ()
  }) {linkage = 10 : i64, sym_name = "test2", type = !llvm.func<i39 (i39, i39)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i1023):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i1023} : () -> i1023
    %1 = "llvm.xor"(%0, %arg0) : (i1023, i1023) -> i1023
    %2 = "llvm.or"(%arg0, %1) : (i1023, i1023) -> i1023
    "llvm.return"(%2) : (i1023) -> ()
  }) {linkage = 10 : i64, sym_name = "test4", type = !llvm.func<i1023 (i1023)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i399, %arg1: i399):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 18446742974197923840 : i399} : () -> i399
    %1 = "llvm.mlir.constant"() {value = -1 : i399} : () -> i399
    %2 = "llvm.mlir.constant"() {value = 274877906943 : i399} : () -> i399
    %3 = "llvm.xor"(%2, %1) : (i399, i399) -> i399
    %4 = "llvm.and"(%arg1, %0) : (i399, i399) -> i399
    %5 = "llvm.add"(%arg0, %4) : (i399, i399) -> i399
    %6 = "llvm.and"(%5, %3) : (i399, i399) -> i399
    %7 = "llvm.and"(%arg0, %2) : (i399, i399) -> i399
    %8 = "llvm.or"(%6, %7) : (i399, i399) -> i399
    "llvm.return"(%8) : (i399) -> ()
  }) {linkage = 10 : i64, sym_name = "test5", type = !llvm.func<i399 (i399, i399)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
