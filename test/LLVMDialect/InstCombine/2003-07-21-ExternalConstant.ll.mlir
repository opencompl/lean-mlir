"module"() ( {
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "silly", type = i32} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "bzero", type = !llvm.func<void (ptr<i8>, i32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "bcopy", type = !llvm.func<void (ptr<i8>, ptr<i8>, i32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "bcmp", type = !llvm.func<i32 (ptr<i8>, ptr<i8>, i32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "fputs", type = !llvm.func<i32 (ptr<i8>, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "fputs_unlocked", type = !llvm.func<i32 (ptr<i8>, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.addressof"() {global_name = @silly} : () -> !llvm.ptr<i32>
    %1 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %2 = "llvm.alloca"(%1) : (i32) -> !llvm.ptr<i32>
    %3 = "llvm.alloca"(%1) : (i32) -> !llvm.ptr<i32>
    "llvm.store"(%arg0, %2) : (i32, !llvm.ptr<i32>) -> ()
    %4 = "llvm.load"(%2) : (!llvm.ptr<i32>) -> i32
    %5 = "llvm.load"(%0) : (!llvm.ptr<i32>) -> i32
    %6 = "llvm.add"(%4, %5) : (i32, i32) -> i32
    "llvm.store"(%6, %3) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.br"()[^bb1] : () -> ()
  ^bb1:  // pred: ^bb0
    %7 = "llvm.load"(%3) : (!llvm.ptr<i32>) -> i32
    "llvm.return"(%7) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "function", type = !llvm.func<i32 (i32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
