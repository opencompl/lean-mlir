"module"() ( {
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 0 : i64, sym_name = ".str", type = !llvm.array<3 x i8>, value = "12\00"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 0 : i64, sym_name = ".str.1", type = !llvm.array<2 x i8>, value = "0\00"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 0 : i64, sym_name = ".str.2", type = !llvm.array<11 x i8>, value = "4294967296\00"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 0 : i64, sym_name = ".str.3", type = !llvm.array<24 x i8>, value = "10000000000000000000000\00"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 0 : i64, sym_name = ".str.4", type = !llvm.array<20 x i8>, value = "9923372036854775807\00"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 0 : i64, sym_name = ".str.5", type = !llvm.array<11 x i8>, value = "4994967295\00"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 0 : i64, sym_name = ".str.6", type = !llvm.array<10 x i8>, value = "499496729\00"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 0 : i64, sym_name = ".str.7", type = !llvm.array<11 x i8>, value = "4994967295\00"} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "strtol", type = !llvm.func<i32 (ptr<i8>, ptr<ptr<i8>>, i32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "atoi", type = !llvm.func<i32 (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "atol", type = !llvm.func<i32 (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "atoll", type = !llvm.func<i64 (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "strtoll", type = !llvm.func<i64 (ptr<i8>, ptr<ptr<i8>>, i32)>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 10 : i32} : () -> i32
    %1 = "llvm.mlir.null"() : () -> !llvm.ptr<ptr<i8>>
    %2 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %3 = "llvm.mlir.addressof"() {global_name = @".str"} : () -> !llvm.ptr<array<3 x i8>>
    %4 = "llvm.getelementptr"(%3, %2, %2) : (!llvm.ptr<array<3 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = "llvm.call"(%4, %1, %0) {callee = @strtol, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i32
    "llvm.return"(%5) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "strtol_dec", type = !llvm.func<i32 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.null"() : () -> !llvm.ptr<ptr<i8>>
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %2 = "llvm.mlir.addressof"() {global_name = @".str"} : () -> !llvm.ptr<array<3 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %1) : (!llvm.ptr<array<3 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%3, %0, %1) {callee = @strtol, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "strtol_base_zero", type = !llvm.func<i32 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 16 : i32} : () -> i32
    %1 = "llvm.mlir.null"() : () -> !llvm.ptr<ptr<i8>>
    %2 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %3 = "llvm.mlir.addressof"() {global_name = @".str"} : () -> !llvm.ptr<array<3 x i8>>
    %4 = "llvm.getelementptr"(%3, %2, %2) : (!llvm.ptr<array<3 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = "llvm.call"(%4, %1, %0) {callee = @strtol, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i32
    "llvm.return"(%5) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "strtol_hex", type = !llvm.func<i32 ()>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<ptr<i8>>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 10 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %2 = "llvm.mlir.addressof"() {global_name = @".str"} : () -> !llvm.ptr<array<3 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %1) : (!llvm.ptr<array<3 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %5 = "llvm.getelementptr"(%arg0, %4) : (!llvm.ptr<ptr<i8>>, i32) -> !llvm.ptr<ptr<i8>>
    %6 = "llvm.call"(%3, %5, %0) {callee = @strtol, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i32
    "llvm.return"(%6) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "strtol_endptr_not_null", type = !llvm.func<i32 (ptr<ptr<i8>>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<ptr<i8>>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 10 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %2 = "llvm.mlir.addressof"() {global_name = @".str.1"} : () -> !llvm.ptr<array<2 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %1) : (!llvm.ptr<array<2 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%3, %arg0, %0) {callee = @strtol, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "strtol_endptr_maybe_null", type = !llvm.func<i32 (ptr<ptr<i8>>)>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.mlir.addressof"() {global_name = @".str"} : () -> !llvm.ptr<array<3 x i8>>
    %2 = "llvm.getelementptr"(%1, %0, %0) : (!llvm.ptr<array<3 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %3 = "llvm.call"(%2) {callee = @atoi, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "atoi_test", type = !llvm.func<i32 ()>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 10 : i32} : () -> i32
    %1 = "llvm.mlir.null"() : () -> !llvm.ptr<ptr<i8>>
    %2 = "llvm.call"(%arg0, %1, %0) {callee = @strtol, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "strtol_not_const_str", type = !llvm.func<i32 (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @atoi, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> i32
    "llvm.return"(%0) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "atoi_not_const_str", type = !llvm.func<i32 (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.null"() : () -> !llvm.ptr<ptr<i8>>
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %2 = "llvm.mlir.addressof"() {global_name = @".str"} : () -> !llvm.ptr<array<3 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %1) : (!llvm.ptr<array<3 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%3, %0, %arg0) {callee = @strtol, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "strtol_not_const_base", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 10 : i32} : () -> i32
    %1 = "llvm.mlir.null"() : () -> !llvm.ptr<ptr<i8>>
    %2 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %3 = "llvm.mlir.addressof"() {global_name = @".str.2"} : () -> !llvm.ptr<array<11 x i8>>
    %4 = "llvm.getelementptr"(%3, %2, %2) : (!llvm.ptr<array<11 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = "llvm.call"(%4, %1, %0) {callee = @strtol, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i32
    "llvm.return"(%5) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "strtol_long_int", type = !llvm.func<i32 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 10 : i32} : () -> i32
    %1 = "llvm.mlir.null"() : () -> !llvm.ptr<ptr<i8>>
    %2 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %3 = "llvm.mlir.addressof"() {global_name = @".str.3"} : () -> !llvm.ptr<array<24 x i8>>
    %4 = "llvm.getelementptr"(%3, %2, %2) : (!llvm.ptr<array<24 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = "llvm.call"(%4, %1, %0) {callee = @strtol, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i32
    "llvm.return"(%5) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "strtol_big_overflow", type = !llvm.func<i32 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.mlir.addressof"() {global_name = @".str.6"} : () -> !llvm.ptr<array<10 x i8>>
    %2 = "llvm.getelementptr"(%1, %0, %0) : (!llvm.ptr<array<10 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %3 = "llvm.call"(%2) {callee = @atol, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "atol_test", type = !llvm.func<i32 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.mlir.addressof"() {global_name = @".str.5"} : () -> !llvm.ptr<array<11 x i8>>
    %2 = "llvm.getelementptr"(%1, %0, %0) : (!llvm.ptr<array<11 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %3 = "llvm.call"(%2) {callee = @atoll, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> i64
    "llvm.return"(%3) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "atoll_test", type = !llvm.func<i64 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 10 : i32} : () -> i32
    %1 = "llvm.mlir.null"() : () -> !llvm.ptr<ptr<i8>>
    %2 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %3 = "llvm.mlir.addressof"() {global_name = @".str.7"} : () -> !llvm.ptr<array<11 x i8>>
    %4 = "llvm.getelementptr"(%3, %2, %2) : (!llvm.ptr<array<11 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = "llvm.call"(%4, %1, %0) {callee = @strtoll, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
    "llvm.return"(%5) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "strtoll_test", type = !llvm.func<i64 ()>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
