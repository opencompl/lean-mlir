"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i47, %arg1: i47):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 70368744177661 : i47} : () -> i47
    %1 = "llvm.mlir.constant"() {value = -70368744177664 : i47} : () -> i47
    %2 = "llvm.and"(%arg0, %1) : (i47, i47) -> i47
    %3 = "llvm.and"(%arg1, %0) : (i47, i47) -> i47
    %4 = "llvm.xor"(%2, %3) : (i47, i47) -> i47
    "llvm.return"(%4) : (i47) -> ()
  }) {linkage = 10 : i64, sym_name = "test1", type = !llvm.func<i47 (i47, i47)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i15):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i15} : () -> i15
    %1 = "llvm.xor"(%arg0, %0) : (i15, i15) -> i15
    "llvm.return"(%1) : (i15) -> ()
  }) {linkage = 10 : i64, sym_name = "test2", type = !llvm.func<i15 (i15)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i23):  // no predecessors
    %0 = "llvm.xor"(%arg0, %arg0) : (i23, i23) -> i23
    "llvm.return"(%0) : (i23) -> ()
  }) {linkage = 10 : i64, sym_name = "test3", type = !llvm.func<i23 (i23)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i37):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i37} : () -> i37
    %1 = "llvm.xor"(%0, %arg0) : (i37, i37) -> i37
    %2 = "llvm.xor"(%arg0, %1) : (i37, i37) -> i37
    "llvm.return"(%2) : (i37) -> ()
  }) {linkage = 10 : i64, sym_name = "test4", type = !llvm.func<i37 (i37)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i7):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 23 : i7} : () -> i7
    %1 = "llvm.or"(%arg0, %0) : (i7, i7) -> i7
    %2 = "llvm.xor"(%1, %0) : (i7, i7) -> i7
    "llvm.return"(%2) : (i7) -> ()
  }) {linkage = 10 : i64, sym_name = "test5", type = !llvm.func<i7 (i7)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i7):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 23 : i7} : () -> i7
    %1 = "llvm.xor"(%arg0, %0) : (i7, i7) -> i7
    %2 = "llvm.xor"(%1, %0) : (i7, i7) -> i7
    "llvm.return"(%2) : (i7) -> ()
  }) {linkage = 10 : i64, sym_name = "test6", type = !llvm.func<i7 (i7)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i47):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 703687463 : i47} : () -> i47
    %1 = "llvm.mlir.constant"() {value = 70368744177663 : i47} : () -> i47
    %2 = "llvm.or"(%arg0, %1) : (i47, i47) -> i47
    %3 = "llvm.xor"(%2, %0) : (i47, i47) -> i47
    "llvm.return"(%3) : (i47) -> ()
  }) {linkage = 10 : i64, sym_name = "test7", type = !llvm.func<i47 (i47)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
