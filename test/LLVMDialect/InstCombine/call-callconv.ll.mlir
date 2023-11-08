"module"() ( {
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 0 : i64, sym_name = ".str", type = !llvm.array<4 x i8>, value = "abc\00"} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @abs, fastmathFlags = #llvm.fastmath<>} : (i32) -> i32
    "llvm.return"(%0) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "_abs", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "abs", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @labs, fastmathFlags = #llvm.fastmath<>} : (i32) -> i32
    "llvm.return"(%0) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "_labs", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "labs", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.mlir.addressof"() {global_name = @".str"} : () -> !llvm.ptr<array<4 x i8>>
    %2 = "llvm.getelementptr"(%1, %0, %0) : (!llvm.ptr<array<4 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %3 = "llvm.call"(%2) {callee = @strlen, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "_strlen1", type = !llvm.func<i32 ()>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "strlen", type = !llvm.func<i32 (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.call"(%arg0) {callee = @strlen, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> i32
    %2 = "llvm.icmp"(%1, %0) {predicate = 1 : i64} : (i32, i32) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "_strlen2", type = !llvm.func<i1 (ptr<i8>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
