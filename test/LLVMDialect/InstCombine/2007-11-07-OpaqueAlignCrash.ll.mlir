"module"() ( {
  "llvm.mlir.global"() ( {
  }) {linkage = 10 : i64, sym_name = "g", type = !llvm.struct<"opaque_t", opaque>} : () -> ()
  "llvm.mlir.global"() ( {
  }) {linkage = 10 : i64, sym_name = "h", type = !llvm.struct<"op_ts", (struct<"opaque2", opaque>, i32)>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.addressof"() {global_name = @h} : () -> !llvm.ptr<struct<"op_ts", (struct<"opaque2", opaque>, i32)>>
    %1 = "llvm.bitcast"(%0) : (!llvm.ptr<struct<"op_ts", (struct<"opaque2", opaque>, i32)>>) -> !llvm.ptr<i32>
    %2 = "llvm.mlir.addressof"() {global_name = @g} : () -> !llvm.ptr<struct<"opaque_t", opaque>>
    %3 = "llvm.bitcast"(%2) : (!llvm.ptr<struct<"opaque_t", opaque>>) -> !llvm.ptr<i8>
    %4 = "llvm.load"(%3) : (!llvm.ptr<i8>) -> i8
    %5 = "llvm.load"(%1) : (!llvm.ptr<i32>) -> i32
    %6 = "llvm.zext"(%4) : (i8) -> i32
    %7 = "llvm.add"(%5, %6) : (i32, i32) -> i32
    "llvm.return"(%7) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "foo", type = !llvm.func<i32 ()>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
