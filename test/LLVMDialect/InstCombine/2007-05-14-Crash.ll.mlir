"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<struct<"struct.anon", packed ()>>, %arg1: !llvm.ptr<struct<"struct.abc", (i32, array<32 x i8>)>>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %2 = "llvm.bitcast"(%arg0) : (!llvm.ptr<struct<"struct.anon", packed ()>>) -> !llvm.ptr<struct<"struct.def", (ptr<ptr<i8>>, struct<"struct.abc", (i32, array<32 x i8>)>)>>
    %3 = "llvm.getelementptr"(%2, %1, %0) : (!llvm.ptr<struct<"struct.def", (ptr<ptr<i8>>, struct<"struct.abc", (i32, array<32 x i8>)>)>>, i32, i32) -> !llvm.ptr<struct<"struct.abc", (i32, array<32 x i8>)>>
    %4 = "llvm.bitcast"(%3) : (!llvm.ptr<struct<"struct.abc", (i32, array<32 x i8>)>>) -> !llvm.ptr<i8>
    "llvm.return"(%4) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "foo", type = !llvm.func<ptr<i8> (ptr<struct<"struct.anon", packed ()>>, ptr<struct<"struct.abc", (i32, array<32 x i8>)>>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
