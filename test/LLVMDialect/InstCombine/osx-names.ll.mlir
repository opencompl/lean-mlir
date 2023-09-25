"module"() ( {
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 0 : i64, sym_name = ".str", type = !llvm.array<13 x i8>, value = "Hello world\0A\00"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 0 : i64, sym_name = ".str2", type = !llvm.array<3 x i8>, value = "%s\00"} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<struct<"struct.__sFILE", (ptr<i8>, i32, i32, i16, i16, struct<"struct.__sbuf", (ptr<i8>, i32)>, i32, ptr<i8>, ptr<func<i32 (ptr<i8>)>>, ptr<func<i32 (ptr<i8>, ptr<i8>, i32)>>, ptr<func<i64 (ptr<i8>, i64, i32)>>, ptr<func<i32 (ptr<i8>, ptr<i8>, i32)>>, struct<"struct.__sbuf", (ptr<i8>, i32)>, ptr<struct<"struct.__sFILEX", opaque>>, i32, array<3 x i8>, array<1 x i8>, struct<"struct.__sbuf", (ptr<i8>, i32)>, i32, i64)>>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.mlir.addressof"() {global_name = @".str"} : () -> !llvm.ptr<array<13 x i8>>
    %2 = "llvm.getelementptr"(%1, %0, %0) : (!llvm.ptr<array<13 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %3 = "llvm.call"(%arg0, %2) {callee = @fprintf, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<struct<"struct.__sFILE", (ptr<i8>, i32, i32, i16, i16, struct<"struct.__sbuf", (ptr<i8>, i32)>, i32, ptr<i8>, ptr<func<i32 (ptr<i8>)>>, ptr<func<i32 (ptr<i8>, ptr<i8>, i32)>>, ptr<func<i64 (ptr<i8>, i64, i32)>>, ptr<func<i32 (ptr<i8>, ptr<i8>, i32)>>, struct<"struct.__sbuf", (ptr<i8>, i32)>, ptr<struct<"struct.__sFILEX", opaque>>, i32, array<3 x i8>, array<1 x i8>, struct<"struct.__sbuf", (ptr<i8>, i32)>, i32, i64)>>, !llvm.ptr<i8>) -> i32
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test1", type = !llvm.func<void (ptr<struct<"struct.__sFILE", (ptr<i8>, i32, i32, i16, i16, struct<"struct.__sbuf", (ptr<i8>, i32)>, i32, ptr<i8>, ptr<func<i32 (ptr<i8>)>>, ptr<func<i32 (ptr<i8>, ptr<i8>, i32)>>, ptr<func<i64 (ptr<i8>, i64, i32)>>, ptr<func<i32 (ptr<i8>, ptr<i8>, i32)>>, struct<"struct.__sbuf", (ptr<i8>, i32)>, ptr<struct<"struct.__sFILEX", opaque>>, i32, array<3 x i8>, array<1 x i8>, struct<"struct.__sbuf", (ptr<i8>, i32)>, i32, i64)>>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<struct<"struct.__sFILE", (ptr<i8>, i32, i32, i16, i16, struct<"struct.__sbuf", (ptr<i8>, i32)>, i32, ptr<i8>, ptr<func<i32 (ptr<i8>)>>, ptr<func<i32 (ptr<i8>, ptr<i8>, i32)>>, ptr<func<i64 (ptr<i8>, i64, i32)>>, ptr<func<i32 (ptr<i8>, ptr<i8>, i32)>>, struct<"struct.__sbuf", (ptr<i8>, i32)>, ptr<struct<"struct.__sFILEX", opaque>>, i32, array<3 x i8>, array<1 x i8>, struct<"struct.__sbuf", (ptr<i8>, i32)>, i32, i64)>>, %arg1: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.mlir.addressof"() {global_name = @".str2"} : () -> !llvm.ptr<array<3 x i8>>
    %2 = "llvm.getelementptr"(%1, %0, %0) : (!llvm.ptr<array<3 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %3 = "llvm.call"(%arg0, %2, %arg1) {callee = @fprintf, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<struct<"struct.__sFILE", (ptr<i8>, i32, i32, i16, i16, struct<"struct.__sbuf", (ptr<i8>, i32)>, i32, ptr<i8>, ptr<func<i32 (ptr<i8>)>>, ptr<func<i32 (ptr<i8>, ptr<i8>, i32)>>, ptr<func<i64 (ptr<i8>, i64, i32)>>, ptr<func<i32 (ptr<i8>, ptr<i8>, i32)>>, struct<"struct.__sbuf", (ptr<i8>, i32)>, ptr<struct<"struct.__sFILEX", opaque>>, i32, array<3 x i8>, array<1 x i8>, struct<"struct.__sbuf", (ptr<i8>, i32)>, i32, i64)>>, !llvm.ptr<i8>, !llvm.ptr<i8>) -> i32
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test2", type = !llvm.func<void (ptr<struct<"struct.__sFILE", (ptr<i8>, i32, i32, i16, i16, struct<"struct.__sbuf", (ptr<i8>, i32)>, i32, ptr<i8>, ptr<func<i32 (ptr<i8>)>>, ptr<func<i32 (ptr<i8>, ptr<i8>, i32)>>, ptr<func<i64 (ptr<i8>, i64, i32)>>, ptr<func<i32 (ptr<i8>, ptr<i8>, i32)>>, struct<"struct.__sbuf", (ptr<i8>, i32)>, ptr<struct<"struct.__sFILEX", opaque>>, i32, array<3 x i8>, array<1 x i8>, struct<"struct.__sbuf", (ptr<i8>, i32)>, i32, i64)>>, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "fprintf", type = !llvm.func<i32 (ptr<struct<"struct.__sFILE", (ptr<i8>, i32, i32, i16, i16, struct<"struct.__sbuf", (ptr<i8>, i32)>, i32, ptr<i8>, ptr<func<i32 (ptr<i8>)>>, ptr<func<i32 (ptr<i8>, ptr<i8>, i32)>>, ptr<func<i64 (ptr<i8>, i64, i32)>>, ptr<func<i32 (ptr<i8>, ptr<i8>, i32)>>, struct<"struct.__sbuf", (ptr<i8>, i32)>, ptr<struct<"struct.__sFILEX", opaque>>, i32, array<3 x i8>, array<1 x i8>, struct<"struct.__sbuf", (ptr<i8>, i32)>, i32, i64)>>, ptr<i8>, ...)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
