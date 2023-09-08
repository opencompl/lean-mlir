"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.experimental.guard", type = !llvm.func<void (i1, ...)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i1):  // no predecessors
    "llvm.call"(%arg0) {callee = @llvm.experimental.guard, fastmathFlags = #llvm.fastmath<>} : (i1) -> ()
    "llvm.call"(%arg0) {callee = @llvm.experimental.guard, fastmathFlags = #llvm.fastmath<>} : (i1) -> ()
    "llvm.call"(%arg0) {callee = @llvm.experimental.guard, fastmathFlags = #llvm.fastmath<>} : (i1) -> ()
    "llvm.call"(%arg0) {callee = @llvm.experimental.guard, fastmathFlags = #llvm.fastmath<>} : (i1) -> ()
    "llvm.call"(%arg0) {callee = @llvm.experimental.guard, fastmathFlags = #llvm.fastmath<>} : (i1) -> ()
    "llvm.call"(%arg0) {callee = @llvm.experimental.guard, fastmathFlags = #llvm.fastmath<>} : (i1) -> ()
    "llvm.call"(%arg0) {callee = @llvm.experimental.guard, fastmathFlags = #llvm.fastmath<>} : (i1) -> ()
    "llvm.call"(%arg0) {callee = @llvm.experimental.guard, fastmathFlags = #llvm.fastmath<>} : (i1) -> ()
    "llvm.call"(%arg0) {callee = @llvm.experimental.guard, fastmathFlags = #llvm.fastmath<>} : (i1) -> ()
    "llvm.call"(%arg0) {callee = @llvm.experimental.guard, fastmathFlags = #llvm.fastmath<>} : (i1) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_guard_adjacent_same_cond", type = !llvm.func<void (i1)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i1, %arg1: i1, %arg2: i1):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 789 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 456 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 123 : i32} : () -> i32
    "llvm.call"(%arg0, %2) {callee = @llvm.experimental.guard, fastmathFlags = #llvm.fastmath<>} : (i1, i32) -> ()
    "llvm.call"(%arg1, %1) {callee = @llvm.experimental.guard, fastmathFlags = #llvm.fastmath<>} : (i1, i32) -> ()
    "llvm.call"(%arg2, %0) {callee = @llvm.experimental.guard, fastmathFlags = #llvm.fastmath<>} : (i1, i32) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_guard_adjacent_diff_cond", type = !llvm.func<void (i1, i1, i1)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 789 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 128 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 255 : i32} : () -> i32
    %3 = "llvm.mlir.constant"() {value = 456 : i32} : () -> i32
    %4 = "llvm.mlir.constant"() {value = 123 : i32} : () -> i32
    %5 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %6 = "llvm.icmp"(%arg0, %5) {predicate = 2 : i64} : (i32, i32) -> i1
    "llvm.call"(%6, %4) {callee = @llvm.experimental.guard, fastmathFlags = #llvm.fastmath<>} : (i1, i32) -> ()
    %7 = "llvm.icmp"(%arg1, %5) {predicate = 2 : i64} : (i32, i32) -> i1
    "llvm.call"(%7, %3) {callee = @llvm.experimental.guard, fastmathFlags = #llvm.fastmath<>} : (i1, i32) -> ()
    %8 = "llvm.and"(%arg0, %2) : (i32, i32) -> i32
    %9 = "llvm.icmp"(%8, %1) {predicate = 3 : i64} : (i32, i32) -> i1
    "llvm.call"(%9, %0) {callee = @llvm.experimental.guard, fastmathFlags = #llvm.fastmath<>} : (i1, i32) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_guard_adjacent_diff_cond2", type = !llvm.func<void (i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 456 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 123 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %3 = "llvm.icmp"(%arg0, %2) {predicate = 2 : i64} : (i32, i32) -> i1
    "llvm.call"(%3, %1) {callee = @llvm.experimental.guard, fastmathFlags = #llvm.fastmath<>} : (i1, i32) -> ()
    %4 = "llvm.load"(%arg1) : (!llvm.ptr<i32>) -> i32
    %5 = "llvm.icmp"(%4, %2) {predicate = 2 : i64} : (i32, i32) -> i1
    "llvm.call"(%5, %0) {callee = @llvm.experimental.guard, fastmathFlags = #llvm.fastmath<>} : (i1, i32) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "negative_load", type = !llvm.func<void (i32, ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 456 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 123 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %3 = "llvm.icmp"(%arg0, %2) {predicate = 2 : i64} : (i32, i32) -> i1
    "llvm.call"(%3, %1) {callee = @llvm.experimental.guard, fastmathFlags = #llvm.fastmath<>} : (i1, i32) -> ()
    %4 = "llvm.load"(%arg1) : (!llvm.ptr<i32>) -> i32
    %5 = "llvm.icmp"(%4, %2) {predicate = 2 : i64} : (i32, i32) -> i1
    "llvm.call"(%5, %0) {callee = @llvm.experimental.guard, fastmathFlags = #llvm.fastmath<>} : (i1, i32) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "deref_load", type = !llvm.func<void (i32, ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 456 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 123 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %3 = "llvm.icmp"(%arg0, %2) {predicate = 2 : i64} : (i32, i32) -> i1
    "llvm.call"(%3, %1) {callee = @llvm.experimental.guard, fastmathFlags = #llvm.fastmath<>} : (i1, i32) -> ()
    %4 = "llvm.udiv"(%arg0, %arg1) : (i32, i32) -> i32
    %5 = "llvm.icmp"(%4, %2) {predicate = 2 : i64} : (i32, i32) -> i1
    "llvm.call"(%5, %0) {callee = @llvm.experimental.guard, fastmathFlags = #llvm.fastmath<>} : (i1, i32) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "negative_div", type = !llvm.func<void (i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 456 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 123 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %3 = "llvm.icmp"(%arg0, %2) {predicate = 2 : i64} : (i32, i32) -> i1
    "llvm.call"(%3, %1) {callee = @llvm.experimental.guard, fastmathFlags = #llvm.fastmath<>} : (i1, i32) -> ()
    %4 = "llvm.add"(%arg1, %arg2) : (i32, i32) -> i32
    %5 = "llvm.add"(%4, %arg3) : (i32, i32) -> i32
    %6 = "llvm.add"(%5, %arg4) : (i32, i32) -> i32
    %7 = "llvm.icmp"(%6, %2) {predicate = 2 : i64} : (i32, i32) -> i1
    "llvm.call"(%7, %0) {callee = @llvm.experimental.guard, fastmathFlags = #llvm.fastmath<>} : (i1, i32) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "negative_window", type = !llvm.func<void (i32, i32, i32, i32, i32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
