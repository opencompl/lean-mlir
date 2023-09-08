"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i39):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i39} : () -> i39
    %1 = "llvm.and"(%arg0, %0) : (i39, i39) -> i39
    "llvm.return"(%1) : (i39) -> ()
  }) {linkage = 10 : i64, sym_name = "test0", type = !llvm.func<i39 (i39)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i15):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i15} : () -> i15
    %1 = "llvm.and"(%arg0, %0) : (i15, i15) -> i15
    "llvm.return"(%1) : (i15) -> ()
  }) {linkage = 10 : i64, sym_name = "test2", type = !llvm.func<i15 (i15)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i23):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 128 : i23} : () -> i23
    %1 = "llvm.mlir.constant"() {value = 127 : i23} : () -> i23
    %2 = "llvm.and"(%arg0, %1) : (i23, i23) -> i23
    %3 = "llvm.and"(%2, %0) : (i23, i23) -> i23
    "llvm.return"(%3) : (i23) -> ()
  }) {linkage = 10 : i64, sym_name = "test3", type = !llvm.func<i23 (i23)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i37):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i37} : () -> i37
    %1 = "llvm.mlir.constant"() {value = -2147483648 : i37} : () -> i37
    %2 = "llvm.and"(%arg0, %1) : (i37, i37) -> i37
    %3 = "llvm.icmp"(%2, %0) {predicate = 1 : i64} : (i37, i37) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "test4", type = !llvm.func<i1 (i37)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i7, %arg1: !llvm.ptr<i7>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 12 : i7} : () -> i7
    %1 = "llvm.mlir.constant"() {value = 3 : i7} : () -> i7
    %2 = "llvm.or"(%arg0, %1) : (i7, i7) -> i7
    %3 = "llvm.xor"(%2, %0) : (i7, i7) -> i7
    "llvm.store"(%3, %arg1) : (i7, !llvm.ptr<i7>) -> ()
    %4 = "llvm.and"(%3, %1) : (i7, i7) -> i7
    "llvm.return"(%4) : (i7) -> ()
  }) {linkage = 10 : i64, sym_name = "test5", type = !llvm.func<i7 (i7, ptr<i7>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i47):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 255 : i47} : () -> i47
    %1 = "llvm.mlir.constant"() {value = 39 : i47} : () -> i47
    %2 = "llvm.ashr"(%arg0, %1) : (i47, i47) -> i47
    %3 = "llvm.and"(%2, %0) : (i47, i47) -> i47
    "llvm.return"(%3) : (i47) -> ()
  }) {linkage = 10 : i64, sym_name = "test7", type = !llvm.func<i47 (i47)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i999):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i999} : () -> i999
    %1 = "llvm.and"(%arg0, %0) : (i999, i999) -> i999
    "llvm.return"(%1) : (i999) -> ()
  }) {linkage = 10 : i64, sym_name = "test8", type = !llvm.func<i999 (i999)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i1005):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i1005} : () -> i1005
    %1 = "llvm.and"(%arg0, %0) : (i1005, i1005) -> i1005
    "llvm.return"(%1) : (i1005) -> ()
  }) {linkage = 10 : i64, sym_name = "test9", type = !llvm.func<i1005 (i1005)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i123):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 128 : i123} : () -> i123
    %1 = "llvm.mlir.constant"() {value = 127 : i123} : () -> i123
    %2 = "llvm.and"(%arg0, %1) : (i123, i123) -> i123
    %3 = "llvm.and"(%2, %0) : (i123, i123) -> i123
    "llvm.return"(%3) : (i123) -> ()
  }) {linkage = 10 : i64, sym_name = "test10", type = !llvm.func<i123 (i123)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i737):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i737} : () -> i737
    %1 = "llvm.mlir.constant"() {value = -2147483648 : i737} : () -> i737
    %2 = "llvm.and"(%arg0, %1) : (i737, i737) -> i737
    %3 = "llvm.icmp"(%2, %0) {predicate = 1 : i64} : (i737, i737) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "test11", type = !llvm.func<i1 (i737)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i117, %arg1: !llvm.ptr<i117>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 12 : i117} : () -> i117
    %1 = "llvm.mlir.constant"() {value = 3 : i117} : () -> i117
    %2 = "llvm.or"(%arg0, %1) : (i117, i117) -> i117
    %3 = "llvm.xor"(%2, %0) : (i117, i117) -> i117
    "llvm.store"(%3, %arg1) : (i117, !llvm.ptr<i117>) -> ()
    %4 = "llvm.and"(%3, %1) : (i117, i117) -> i117
    "llvm.return"(%4) : (i117) -> ()
  }) {linkage = 10 : i64, sym_name = "test12", type = !llvm.func<i117 (i117, ptr<i117>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i1024):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 255 : i1024} : () -> i1024
    %1 = "llvm.mlir.constant"() {value = 1016 : i1024} : () -> i1024
    %2 = "llvm.ashr"(%arg0, %1) : (i1024, i1024) -> i1024
    %3 = "llvm.and"(%2, %0) : (i1024, i1024) -> i1024
    "llvm.return"(%3) : (i1024) -> ()
  }) {linkage = 10 : i64, sym_name = "test13", type = !llvm.func<i1024 (i1024)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
