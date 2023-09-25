"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i23):  // no predecessors
    %0 = "llvm.sub"(%arg0, %arg0) : (i23, i23) -> i23
    "llvm.return"(%0) : (i23) -> ()
  }) {linkage = 10 : i64, sym_name = "test1", type = !llvm.func<i23 (i23)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i47):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i47} : () -> i47
    %1 = "llvm.sub"(%arg0, %0) : (i47, i47) -> i47
    "llvm.return"(%1) : (i47) -> ()
  }) {linkage = 10 : i64, sym_name = "test2", type = !llvm.func<i47 (i47)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i97):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i97} : () -> i97
    %1 = "llvm.sub"(%0, %arg0) : (i97, i97) -> i97
    %2 = "llvm.sub"(%0, %1) : (i97, i97) -> i97
    "llvm.return"(%2) : (i97) -> ()
  }) {linkage = 10 : i64, sym_name = "test3", type = !llvm.func<i97 (i97)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i108, %arg1: i108):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i108} : () -> i108
    %1 = "llvm.sub"(%0, %arg0) : (i108, i108) -> i108
    %2 = "llvm.sub"(%arg1, %1) : (i108, i108) -> i108
    "llvm.return"(%2) : (i108) -> ()
  }) {linkage = 10 : i64, sym_name = "test4", type = !llvm.func<i108 (i108, i108)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i19, %arg1: i19, %arg2: i19):  // no predecessors
    %0 = "llvm.sub"(%arg1, %arg2) : (i19, i19) -> i19
    %1 = "llvm.sub"(%arg0, %0) : (i19, i19) -> i19
    "llvm.return"(%1) : (i19) -> ()
  }) {linkage = 10 : i64, sym_name = "test5", type = !llvm.func<i19 (i19, i19, i19)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i57, %arg1: i57):  // no predecessors
    %0 = "llvm.and"(%arg0, %arg1) : (i57, i57) -> i57
    %1 = "llvm.sub"(%arg0, %0) : (i57, i57) -> i57
    "llvm.return"(%1) : (i57) -> ()
  }) {linkage = 10 : i64, sym_name = "test6", type = !llvm.func<i57 (i57, i57)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i77):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i77} : () -> i77
    %1 = "llvm.sub"(%0, %arg0) : (i77, i77) -> i77
    "llvm.return"(%1) : (i77) -> ()
  }) {linkage = 10 : i64, sym_name = "test7", type = !llvm.func<i77 (i77)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i27):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 9 : i27} : () -> i27
    %1 = "llvm.mul"(%0, %arg0) : (i27, i27) -> i27
    %2 = "llvm.sub"(%1, %arg0) : (i27, i27) -> i27
    "llvm.return"(%2) : (i27) -> ()
  }) {linkage = 10 : i64, sym_name = "test8", type = !llvm.func<i27 (i27)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i42):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3 : i42} : () -> i42
    %1 = "llvm.mul"(%0, %arg0) : (i42, i42) -> i42
    %2 = "llvm.sub"(%arg0, %1) : (i42, i42) -> i42
    "llvm.return"(%2) : (i42) -> ()
  }) {linkage = 10 : i64, sym_name = "test9", type = !llvm.func<i42 (i42)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i9, %arg1: i9):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i9} : () -> i9
    %1 = "llvm.sub"(%arg0, %arg1) : (i9, i9) -> i9
    %2 = "llvm.icmp"(%1, %0) {predicate = 1 : i64} : (i9, i9) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "test11", type = !llvm.func<i1 (i9, i9)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i43):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i43} : () -> i43
    %1 = "llvm.mlir.constant"() {value = 42 : i43} : () -> i43
    %2 = "llvm.ashr"(%arg0, %1) : (i43, i43) -> i43
    %3 = "llvm.sub"(%0, %2) : (i43, i43) -> i43
    "llvm.return"(%3) : (i43) -> ()
  }) {linkage = 10 : i64, sym_name = "test12", type = !llvm.func<i43 (i43)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i79):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i79} : () -> i79
    %1 = "llvm.mlir.constant"() {value = 78 : i79} : () -> i79
    %2 = "llvm.lshr"(%arg0, %1) : (i79, i79) -> i79
    %3 = "llvm.sub"(%0, %2) : (i79, i79) -> i79
    "llvm.return"(%3) : (i79) -> ()
  }) {linkage = 10 : i64, sym_name = "test13", type = !llvm.func<i79 (i79)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i1024):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i1024} : () -> i1024
    %1 = "llvm.mlir.constant"() {value = 1023 : i1024} : () -> i1024
    %2 = "llvm.lshr"(%arg0, %1) : (i1024, i1024) -> i1024
    %3 = "llvm.bitcast"(%2) : (i1024) -> i1024
    %4 = "llvm.sub"(%0, %3) : (i1024, i1024) -> i1024
    "llvm.return"(%4) : (i1024) -> ()
  }) {linkage = 10 : i64, sym_name = "test14", type = !llvm.func<i1024 (i1024)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i51):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i51} : () -> i51
    %1 = "llvm.mlir.constant"() {value = 1123 : i51} : () -> i51
    %2 = "llvm.sdiv"(%arg0, %1) : (i51, i51) -> i51
    %3 = "llvm.sub"(%0, %2) : (i51, i51) -> i51
    "llvm.return"(%3) : (i51) -> ()
  }) {linkage = 10 : i64, sym_name = "test16", type = !llvm.func<i51 (i51)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i25):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1234 : i25} : () -> i25
    %1 = "llvm.mlir.constant"() {value = 0 : i25} : () -> i25
    %2 = "llvm.sub"(%1, %arg0) : (i25, i25) -> i25
    %3 = "llvm.sdiv"(%2, %0) : (i25, i25) -> i25
    "llvm.return"(%3) : (i25) -> ()
  }) {linkage = 10 : i64, sym_name = "test17", type = !llvm.func<i25 (i25)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i128):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 2 : i128} : () -> i128
    %1 = "llvm.shl"(%arg0, %0) : (i128, i128) -> i128
    %2 = "llvm.shl"(%arg0, %0) : (i128, i128) -> i128
    %3 = "llvm.sub"(%1, %2) : (i128, i128) -> i128
    "llvm.return"(%3) : (i128) -> ()
  }) {linkage = 10 : i64, sym_name = "test18", type = !llvm.func<i128 (i128)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i39, %arg1: i39):  // no predecessors
    %0 = "llvm.sub"(%arg0, %arg1) : (i39, i39) -> i39
    %1 = "llvm.add"(%0, %arg1) : (i39, i39) -> i39
    "llvm.return"(%1) : (i39) -> ()
  }) {linkage = 10 : i64, sym_name = "test19", type = !llvm.func<i39 (i39, i39)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i33, %arg1: i33):  // no predecessors
    %0 = "llvm.sub"(%arg0, %arg1) : (i33, i33) -> i33
    %1 = "llvm.icmp"(%0, %arg0) {predicate = 1 : i64} : (i33, i33) -> i1
    "llvm.return"(%1) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "test20", type = !llvm.func<i1 (i33, i33)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i256, %arg1: i256):  // no predecessors
    %0 = "llvm.sub"(%arg0, %arg1) : (i256, i256) -> i256
    %1 = "llvm.icmp"(%0, %arg0) {predicate = 1 : i64} : (i256, i256) -> i1
    "llvm.return"(%1) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "test21", type = !llvm.func<i1 (i256, i256)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
