"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "memmove", type = !llvm.func<ptr<i8> (ptr<i8>, ptr<i8>, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>, %arg2: i32):  // no predecessors
    %0 = "llvm.call"(%arg0, %arg1, %arg2) {callee = @memmove, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
    "llvm.return"(%0) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify1", type = !llvm.func<ptr<i8> (ptr<i8>, ptr<i8>, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>, %arg2: i32):  // no predecessors
    %0 = "llvm.call"(%arg0, %arg1, %arg2) {callee = @memmove, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
    "llvm.return"(%0) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify2", type = !llvm.func<ptr<i8> (ptr<i8>, ptr<i8>, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>, %arg2: i32):  // no predecessors
    %0 = "llvm.call"(%arg0, %arg1, %arg2) {callee = @memmove, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
    "llvm.return"(%0) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "test_no_simplify1", type = !llvm.func<ptr<i8> (ptr<i8>, ptr<i8>, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>, %arg2: i32):  // no predecessors
    %0 = "llvm.call"(%arg0, %arg1, %arg2) {callee = @memmove, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
    "llvm.return"(%0) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "test_no_incompatible_attr", type = !llvm.func<ptr<i8> (ptr<i8>, ptr<i8>, i32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
