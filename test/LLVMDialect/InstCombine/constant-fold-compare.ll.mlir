"module"() ( {
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.mlir.addressof"() {global_name = @a} : () -> !llvm.ptr<func<i32 ()>>
    %2 = "llvm.ptrtoint"(%1) : (!llvm.ptr<func<i32 ()>>) -> i32
    %3 = "llvm.icmp"(%2, %0) {predicate = 0 : i64} : (i32, i32) -> i1
    %4 = "llvm.zext"(%3) : (i1) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "a", type = !llvm.func<i32 ()>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
