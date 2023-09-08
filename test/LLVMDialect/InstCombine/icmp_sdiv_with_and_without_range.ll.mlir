"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 2 : i32} : () -> i32
    %2 = "llvm.load"(%arg0) : (!llvm.ptr<i32>) -> i32
    %3 = "llvm.sdiv"(%2, %1) : (i32, i32) -> i32
    %4 = "llvm.icmp"(%0, %3) {predicate = 5 : i64} : (i32, i32) -> i1
    "llvm.return"(%4) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "without_range", type = !llvm.func<i1 (ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 2 : i32} : () -> i32
    %2 = "llvm.load"(%arg0) : (!llvm.ptr<i32>) -> i32
    %3 = "llvm.sdiv"(%2, %1) : (i32, i32) -> i32
    %4 = "llvm.icmp"(%0, %3) {predicate = 5 : i64} : (i32, i32) -> i1
    "llvm.return"(%4) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "with_range", type = !llvm.func<i1 (ptr<i32>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
