"module"() ( {
  "llvm.mlir.global"() ( {
  }) {linkage = 10 : i64, sym_name = "ecp", type = !llvm.ptr<i8>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "strnlen", type = !llvm.func<i64 (ptr<i8>, i64)>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 3 : i64} : () -> i64
    %1 = "llvm.mlir.addressof"() {global_name = @ecp} : () -> !llvm.ptr<ptr<i8>>
    %2 = "llvm.load"(%1) : (!llvm.ptr<ptr<i8>>) -> !llvm.ptr<i8>
    %3 = "llvm.call"(%2, %0) {callee = @strnlen, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> i64
    "llvm.return"(%3) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "deref_strnlen_ecp_3", type = !llvm.func<i64 ()>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.addressof"() {global_name = @ecp} : () -> !llvm.ptr<ptr<i8>>
    %1 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %2 = "llvm.or"(%arg0, %1) : (i64, i64) -> i64
    %3 = "llvm.load"(%0) : (!llvm.ptr<ptr<i8>>) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%3, %2) {callee = @strnlen, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> i64
    "llvm.return"(%4) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "deref_strnlen_ecp_nz", type = !llvm.func<i64 (i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.addressof"() {global_name = @ecp} : () -> !llvm.ptr<ptr<i8>>
    %1 = "llvm.load"(%0) : (!llvm.ptr<ptr<i8>>) -> !llvm.ptr<i8>
    %2 = "llvm.call"(%1, %arg0) {callee = @strnlen, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> i64
    "llvm.return"(%2) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "noderef_strnlen_ecp_n", type = !llvm.func<i64 (i64)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
