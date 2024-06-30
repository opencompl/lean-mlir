"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i33, %arg1: i33):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 65280 : i33} : () -> i33
    %1 = "llvm.and"(%arg0, %0) : (i33, i33) -> i33
    %2 = "llvm.and"(%arg1, %0) : (i33, i33) -> i33
    %3 = "llvm.icmp"(%1, %2) {predicate = 1 : i64} : (i33, i33) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "test1", type = !llvm.func<i1 (i33, i33)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i999, %arg1: i999):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 65280 : i999} : () -> i999
    %1 = "llvm.and"(%arg0, %0) : (i999, i999) -> i999
    %2 = "llvm.and"(%arg1, %0) : (i999, i999) -> i999
    %3 = "llvm.icmp"(%1, %2) {predicate = 1 : i64} : (i999, i999) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "test2", type = !llvm.func<i1 (i999, i999)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
