"module"() ( {
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 0 : i64, sym_name = "str", type = !llvm.array<17 x i8>, value = "exactly 16 chars\00"} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "strcpy", type = !llvm.func<ptr<i8, 200> (ptr<i8, 200>, ptr<i8, 200>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "stpcpy", type = !llvm.func<ptr<i8, 200> (ptr<i8, 200>, ptr<i8, 200>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "strncpy", type = !llvm.func<ptr<i8, 200> (ptr<i8, 200>, ptr<i8, 200>, i64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "stpncpy", type = !llvm.func<ptr<i8, 200> (ptr<i8, 200>, ptr<i8, 200>, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8, 200>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %1 = "llvm.mlir.addressof"() {global_name = @str} : () -> !llvm.ptr<array<17 x i8>>
    %2 = "llvm.getelementptr"(%1, %0, %0) : (!llvm.ptr<array<17 x i8>>, i64, i64) -> !llvm.ptr<i8, 200>
    %3 = "llvm.call"(%arg0, %2) {callee = @strcpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8, 200>, !llvm.ptr<i8, 200>) -> !llvm.ptr<i8, 200>
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_strcpy_to_memcpy", type = !llvm.func<void (ptr<i8, 200>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8, 200>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %1 = "llvm.mlir.addressof"() {global_name = @str} : () -> !llvm.ptr<array<17 x i8>>
    %2 = "llvm.getelementptr"(%1, %0, %0) : (!llvm.ptr<array<17 x i8>>, i64, i64) -> !llvm.ptr<i8, 200>
    %3 = "llvm.call"(%arg0, %2) {callee = @stpcpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8, 200>, !llvm.ptr<i8, 200>) -> !llvm.ptr<i8, 200>
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_stpcpy_to_memcpy", type = !llvm.func<void (ptr<i8, 200>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8, 200>, %arg1: !llvm.ptr<i8, 200>):  // no predecessors
    %0 = "llvm.call"(%arg0, %arg1) {callee = @stpcpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8, 200>, !llvm.ptr<i8, 200>) -> !llvm.ptr<i8, 200>
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_stpcpy_to_strcpy", type = !llvm.func<void (ptr<i8, 200>, ptr<i8, 200>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8, 200>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 17 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %2 = "llvm.mlir.addressof"() {global_name = @str} : () -> !llvm.ptr<array<17 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %1) : (!llvm.ptr<array<17 x i8>>, i64, i64) -> !llvm.ptr<i8, 200>
    %4 = "llvm.call"(%arg0, %3, %0) {callee = @strncpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8, 200>, !llvm.ptr<i8, 200>, i64) -> !llvm.ptr<i8, 200>
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_strncpy_to_memcpy", type = !llvm.func<void (ptr<i8, 200>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8, 200>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 17 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %2 = "llvm.mlir.addressof"() {global_name = @str} : () -> !llvm.ptr<array<17 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %1) : (!llvm.ptr<array<17 x i8>>, i64, i64) -> !llvm.ptr<i8, 200>
    %4 = "llvm.call"(%arg0, %3, %0) {callee = @stpncpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8, 200>, !llvm.ptr<i8, 200>, i64) -> !llvm.ptr<i8, 200>
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_stpncpy_to_memcpy", type = !llvm.func<void (ptr<i8, 200>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
