"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "foo", type = !llvm.func<void (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "bar", type = !llvm.func<void (ptr<i8, 1>)>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.alloca"(%0) : (i32) -> !llvm.ptr<i32>
    %2 = "llvm.bitcast"(%1) : (!llvm.ptr<i32>) -> !llvm.ptr<i8>
    "llvm.call"(%2) {callee = @foo, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "nonnullAfterBitCast", type = !llvm.func<void ()>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 2 : i32} : () -> i32
    %1 = "llvm.zext"(%arg0) : (i8) -> i32
    %2 = "llvm.add"(%1, %0) : (i32, i32) -> i32
    %3 = "llvm.sext"(%2) : (i32) -> i64
    %4 = "llvm.inttoptr"(%3) : (i64) -> !llvm.ptr<i8>
    "llvm.call"(%4) {callee = @foo, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "nonnullAfterSExt", type = !llvm.func<void (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 2 : i32} : () -> i32
    %1 = "llvm.zext"(%arg0) : (i8) -> i32
    %2 = "llvm.add"(%1, %0) : (i32, i32) -> i32
    %3 = "llvm.zext"(%2) : (i32) -> i64
    %4 = "llvm.inttoptr"(%3) : (i64) -> !llvm.ptr<i8>
    "llvm.call"(%4) {callee = @foo, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "nonnullAfterZExt", type = !llvm.func<void (i8)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.assume", type = !llvm.func<void (i1)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 100 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 100 : i32} : () -> i32
    %2 = "llvm.sdiv"(%1, %arg0) : (i32, i32) -> i32
    %3 = "llvm.inttoptr"(%2) : (i32) -> !llvm.ptr<i8>
    "llvm.call"(%3) {callee = @foo, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> ()
    %4 = "llvm.sdiv"(%0, %arg1) : (i64, i64) -> i64
    %5 = "llvm.inttoptr"(%4) : (i64) -> !llvm.ptr<i8>
    "llvm.call"(%5) {callee = @foo, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "nonnullAfterInt2Ptr", type = !llvm.func<void (i32, i64)>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.alloca"(%0) : (i32) -> !llvm.ptr<i32>
    %2 = "llvm.ptrtoint"(%1) : (!llvm.ptr<i32>) -> i64
    %3 = "llvm.inttoptr"(%2) : (i64) -> !llvm.ptr<i8>
    "llvm.call"(%3) {callee = @foo, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "nonnullAfterPtr2Int", type = !llvm.func<void ()>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i128):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i128} : () -> i128
    %1 = "llvm.icmp"(%arg0, %0) {predicate = 1 : i64} : (i128, i128) -> i1
    "llvm.call"(%1) {callee = @llvm.assume, fastmathFlags = #llvm.fastmath<>} : (i1) -> ()
    %2 = "llvm.inttoptr"(%arg0) : (i128) -> !llvm.ptr<i8>
    "llvm.call"(%2) {callee = @foo, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "maybenullAfterInt2Ptr", type = !llvm.func<void (i128)>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.alloca"(%0) : (i32) -> !llvm.ptr<i32>
    %2 = "llvm.ptrtoint"(%1) : (!llvm.ptr<i32>) -> i32
    %3 = "llvm.inttoptr"(%2) : (i32) -> !llvm.ptr<i8>
    "llvm.call"(%3) {callee = @foo, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "maybenullAfterPtr2Int", type = !llvm.func<void ()>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.addrspacecast"(%arg0) : (!llvm.ptr<i8>) -> !llvm.ptr<i8, 1>
    "llvm.call"(%0) {callee = @bar, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8, 1>) -> ()
    "llvm.call"(%arg0) {callee = @foo, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "maybenullAfterAddrspacecast", type = !llvm.func<void (ptr<i8>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
