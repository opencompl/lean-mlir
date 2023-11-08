"module"() ( {
  "llvm.mlir.global"() ( {
  }) {linkage = 5 : i64, sym_name = "d", type = i32, value = 0 : i32} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -2 : i32} : () -> i32
    %1 = "llvm.mlir.addressof"() {global_name = @d} : () -> !llvm.ptr<i32>
    %2 = "llvm.zext"(%arg0) : (i8) -> i32
    %3 = "llvm.load"(%1) : (!llvm.ptr<i32>) -> i32
    %4 = "llvm.or"(%3, %0) : (i32, i32) -> i32
    %5 = "llvm.add"(%4, %2) : (i32, i32) -> i32
    %6 = "llvm.icmp"(%2, %5) {predicate = 8 : i64} : (i32, i32) -> i1
    "llvm.return"(%6) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "f", type = !llvm.func<i1 (i8)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
