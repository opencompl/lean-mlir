"module"() ( {
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "a5", type = !llvm.array<5 x i8>, value = "%s\0045"} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "strchr", type = !llvm.func<ptr<i8> (ptr<i8>, i32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "strrchr", type = !llvm.func<ptr<i8> (ptr<i8>, i32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "strcmp", type = !llvm.func<i32 (ptr<i8>, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "strncmp", type = !llvm.func<i32 (ptr<i8>, ptr<i8>, i64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "strstr", type = !llvm.func<ptr<i8> (ptr<i8>, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "stpcpy", type = !llvm.func<ptr<i8> (ptr<i8>, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "strcpy", type = !llvm.func<ptr<i8> (ptr<i8>, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "stpncpy", type = !llvm.func<ptr<i8> (ptr<i8>, ptr<i8>, i64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "strncpy", type = !llvm.func<ptr<i8> (ptr<i8>, ptr<i8>, i64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "strlen", type = !llvm.func<i64 (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "strnlen", type = !llvm.func<i64 (ptr<i8>, i64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "strpbrk", type = !llvm.func<ptr<i8> (ptr<i8>, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "strspn", type = !llvm.func<i64 (ptr<i8>, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "strcspn", type = !llvm.func<i64 (ptr<i8>, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "atoi", type = !llvm.func<i32 (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "atol", type = !llvm.func<i64 (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "atoll", type = !llvm.func<i64 (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "strtol", type = !llvm.func<i64 (ptr<i8>, ptr<ptr<i8>>, i32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "strtoll", type = !llvm.func<i64 (ptr<i8>, ptr<ptr<i8>>, i32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "strtoul", type = !llvm.func<i64 (ptr<i8>, ptr<ptr<i8>>, i32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "strtoull", type = !llvm.func<i64 (ptr<i8>, ptr<ptr<i8>>, i32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "sprintf", type = !llvm.func<i32 (ptr<i8>, ptr<i8>, ...)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "snprintf", type = !llvm.func<i32 (ptr<i8>, i64, ptr<i8>, ...)>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 5 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %2 = "llvm.mlir.addressof"() {global_name = @a5} : () -> !llvm.ptr<array<5 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %0) : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%3, %1) {callee = @strchr, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
    "llvm.return"(%4) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "fold_strchr_past_end", type = !llvm.func<ptr<i8> ()>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 5 : i32} : () -> i32
    %2 = "llvm.mlir.addressof"() {global_name = @a5} : () -> !llvm.ptr<array<5 x i8>>
    %3 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %4 = "llvm.mlir.addressof"() {global_name = @a5} : () -> !llvm.ptr<array<5 x i8>>
    %5 = "llvm.getelementptr"(%4, %3, %3) : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %6 = "llvm.getelementptr"(%2, %3, %1) : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %7 = "llvm.call"(%5, %6) {callee = @strcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> i32
    %8 = "llvm.getelementptr"(%arg0, %3) : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    "llvm.store"(%7, %8) : (i32, !llvm.ptr<i32>) -> ()
    %9 = "llvm.call"(%6, %5) {callee = @strcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> i32
    %10 = "llvm.getelementptr"(%arg0, %0) : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    "llvm.store"(%9, %10) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "fold_strcmp_past_end", type = !llvm.func<void (ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 5 : i64} : () -> i64
    %2 = "llvm.mlir.constant"() {value = 5 : i32} : () -> i32
    %3 = "llvm.mlir.addressof"() {global_name = @a5} : () -> !llvm.ptr<array<5 x i8>>
    %4 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %5 = "llvm.mlir.addressof"() {global_name = @a5} : () -> !llvm.ptr<array<5 x i8>>
    %6 = "llvm.getelementptr"(%5, %4, %4) : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %7 = "llvm.getelementptr"(%3, %4, %2) : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %8 = "llvm.call"(%6, %7, %1) {callee = @strncmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %9 = "llvm.getelementptr"(%arg0, %4) : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    "llvm.store"(%8, %9) : (i32, !llvm.ptr<i32>) -> ()
    %10 = "llvm.call"(%7, %6, %1) {callee = @strncmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %11 = "llvm.getelementptr"(%arg0, %0) : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    "llvm.store"(%10, %11) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "fold_strncmp_past_end", type = !llvm.func<void (ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %2 = "llvm.mlir.addressof"() {global_name = @a5} : () -> !llvm.ptr<array<5 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %0) : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%3, %1) {callee = @strrchr, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
    "llvm.return"(%4) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "fold_strrchr_past_end", type = !llvm.func<ptr<i8> (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<ptr<i8>>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 5 : i32} : () -> i32
    %2 = "llvm.mlir.addressof"() {global_name = @a5} : () -> !llvm.ptr<array<5 x i8>>
    %3 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %4 = "llvm.mlir.addressof"() {global_name = @a5} : () -> !llvm.ptr<array<5 x i8>>
    %5 = "llvm.getelementptr"(%4, %3, %3) : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %6 = "llvm.getelementptr"(%2, %3, %1) : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %7 = "llvm.call"(%5, %6) {callee = @strstr, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> !llvm.ptr<i8>
    %8 = "llvm.getelementptr"(%arg0, %3) : (!llvm.ptr<ptr<i8>>, i32) -> !llvm.ptr<ptr<i8>>
    "llvm.store"(%7, %8) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>) -> ()
    %9 = "llvm.call"(%6, %5) {callee = @strstr, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> !llvm.ptr<i8>
    %10 = "llvm.getelementptr"(%arg0, %0) : (!llvm.ptr<ptr<i8>>, i32) -> !llvm.ptr<ptr<i8>>
    "llvm.store"(%9, %10) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "fold_strstr_past_end", type = !llvm.func<void (ptr<ptr<i8>>)>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 5 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %2 = "llvm.mlir.addressof"() {global_name = @a5} : () -> !llvm.ptr<array<5 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %0) : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%3) {callee = @strlen, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> i64
    "llvm.return"(%4) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "fold_strlen_past_end", type = !llvm.func<i64 ()>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %2 = "llvm.mlir.addressof"() {global_name = @a5} : () -> !llvm.ptr<array<5 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %0) : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%arg0, %3) {callee = @strcpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> !llvm.ptr<i8>
    "llvm.return"(%4) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "fold_stpcpy_past_end", type = !llvm.func<ptr<i8> (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %2 = "llvm.mlir.addressof"() {global_name = @a5} : () -> !llvm.ptr<array<5 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %0) : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%arg0, %3) {callee = @strcpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> !llvm.ptr<i8>
    "llvm.return"(%4) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "fold_strcpy_past_end", type = !llvm.func<ptr<i8> (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 5 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %3 = "llvm.mlir.addressof"() {global_name = @a5} : () -> !llvm.ptr<array<5 x i8>>
    %4 = "llvm.getelementptr"(%3, %2, %1) : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = "llvm.call"(%arg0, %4, %0) {callee = @strncpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    "llvm.return"(%5) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "fold_stpncpy_past_end", type = !llvm.func<ptr<i8> (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 5 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %3 = "llvm.mlir.addressof"() {global_name = @a5} : () -> !llvm.ptr<array<5 x i8>>
    %4 = "llvm.getelementptr"(%3, %2, %1) : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = "llvm.call"(%arg0, %4, %0) {callee = @strncpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    "llvm.return"(%5) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "fold_strncpy_past_end", type = !llvm.func<ptr<i8> (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<ptr<i8>>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 5 : i32} : () -> i32
    %2 = "llvm.mlir.addressof"() {global_name = @a5} : () -> !llvm.ptr<array<5 x i8>>
    %3 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %4 = "llvm.mlir.addressof"() {global_name = @a5} : () -> !llvm.ptr<array<5 x i8>>
    %5 = "llvm.getelementptr"(%4, %3, %3) : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %6 = "llvm.getelementptr"(%2, %3, %1) : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %7 = "llvm.call"(%5, %6) {callee = @strpbrk, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> !llvm.ptr<i8>
    %8 = "llvm.getelementptr"(%arg0, %3) : (!llvm.ptr<ptr<i8>>, i32) -> !llvm.ptr<ptr<i8>>
    "llvm.store"(%7, %8) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>) -> ()
    %9 = "llvm.call"(%6, %5) {callee = @strpbrk, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> !llvm.ptr<i8>
    %10 = "llvm.getelementptr"(%arg0, %0) : (!llvm.ptr<ptr<i8>>, i32) -> !llvm.ptr<ptr<i8>>
    "llvm.store"(%9, %10) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "fold_strpbrk_past_end", type = !llvm.func<void (ptr<ptr<i8>>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i64>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 5 : i32} : () -> i32
    %2 = "llvm.mlir.addressof"() {global_name = @a5} : () -> !llvm.ptr<array<5 x i8>>
    %3 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %4 = "llvm.mlir.addressof"() {global_name = @a5} : () -> !llvm.ptr<array<5 x i8>>
    %5 = "llvm.getelementptr"(%4, %3, %3) : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %6 = "llvm.getelementptr"(%2, %3, %1) : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %7 = "llvm.call"(%5, %6) {callee = @strspn, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> i64
    %8 = "llvm.getelementptr"(%arg0, %3) : (!llvm.ptr<i64>, i32) -> !llvm.ptr<i64>
    "llvm.store"(%7, %8) : (i64, !llvm.ptr<i64>) -> ()
    %9 = "llvm.call"(%6, %5) {callee = @strspn, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> i64
    %10 = "llvm.getelementptr"(%arg0, %0) : (!llvm.ptr<i64>, i32) -> !llvm.ptr<i64>
    "llvm.store"(%9, %10) : (i64, !llvm.ptr<i64>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "fold_strspn_past_end", type = !llvm.func<void (ptr<i64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i64>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 5 : i32} : () -> i32
    %2 = "llvm.mlir.addressof"() {global_name = @a5} : () -> !llvm.ptr<array<5 x i8>>
    %3 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %4 = "llvm.mlir.addressof"() {global_name = @a5} : () -> !llvm.ptr<array<5 x i8>>
    %5 = "llvm.getelementptr"(%4, %3, %3) : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %6 = "llvm.getelementptr"(%2, %3, %1) : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %7 = "llvm.call"(%5, %6) {callee = @strcspn, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> i64
    %8 = "llvm.getelementptr"(%arg0, %3) : (!llvm.ptr<i64>, i32) -> !llvm.ptr<i64>
    "llvm.store"(%7, %8) : (i64, !llvm.ptr<i64>) -> ()
    %9 = "llvm.call"(%6, %5) {callee = @strcspn, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> i64
    %10 = "llvm.getelementptr"(%arg0, %0) : (!llvm.ptr<i64>, i32) -> !llvm.ptr<i64>
    "llvm.store"(%9, %10) : (i64, !llvm.ptr<i64>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "fold_strcspn_past_end", type = !llvm.func<void (ptr<i64>)>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 5 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %2 = "llvm.mlir.addressof"() {global_name = @a5} : () -> !llvm.ptr<array<5 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %0) : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%3) {callee = @atoi, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "fold_atoi_past_end", type = !llvm.func<i32 ()>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i64>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 16 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 4 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 10 : i32} : () -> i32
    %3 = "llvm.mlir.constant"() {value = 3 : i32} : () -> i32
    %4 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %5 = "llvm.mlir.constant"() {value = 2 : i32} : () -> i32
    %6 = "llvm.mlir.null"() : () -> !llvm.ptr<ptr<i8>>
    %7 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %8 = "llvm.mlir.constant"() {value = 5 : i32} : () -> i32
    %9 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %10 = "llvm.mlir.addressof"() {global_name = @a5} : () -> !llvm.ptr<array<5 x i8>>
    %11 = "llvm.getelementptr"(%10, %9, %8) : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %12 = "llvm.call"(%11) {callee = @atol, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> i64
    %13 = "llvm.getelementptr"(%arg0, %9) : (!llvm.ptr<i64>, i32) -> !llvm.ptr<i64>
    "llvm.store"(%12, %13) : (i64, !llvm.ptr<i64>) -> ()
    %14 = "llvm.call"(%11) {callee = @atoll, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> i64
    %15 = "llvm.getelementptr"(%arg0, %7) : (!llvm.ptr<i64>, i32) -> !llvm.ptr<i64>
    "llvm.store"(%14, %15) : (i64, !llvm.ptr<i64>) -> ()
    %16 = "llvm.call"(%11, %6, %9) {callee = @strtol, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
    %17 = "llvm.getelementptr"(%arg0, %5) : (!llvm.ptr<i64>, i32) -> !llvm.ptr<i64>
    "llvm.store"(%16, %17) : (i64, !llvm.ptr<i64>) -> ()
    %18 = "llvm.call"(%11, %6, %4) {callee = @strtoul, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
    %19 = "llvm.getelementptr"(%arg0, %3) : (!llvm.ptr<i64>, i32) -> !llvm.ptr<i64>
    "llvm.store"(%18, %19) : (i64, !llvm.ptr<i64>) -> ()
    %20 = "llvm.call"(%11, %6, %2) {callee = @strtoll, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
    %21 = "llvm.getelementptr"(%arg0, %1) : (!llvm.ptr<i64>, i32) -> !llvm.ptr<i64>
    "llvm.store"(%20, %21) : (i64, !llvm.ptr<i64>) -> ()
    %22 = "llvm.call"(%11, %6, %0) {callee = @strtoul, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
    %23 = "llvm.getelementptr"(%arg0, %8) : (!llvm.ptr<i64>, i32) -> !llvm.ptr<i64>
    "llvm.store"(%22, %23) : (i64, !llvm.ptr<i64>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "fold_atol_strtol_past_end", type = !llvm.func<void (ptr<i64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>, %arg1: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 5 : i32} : () -> i32
    %2 = "llvm.mlir.addressof"() {global_name = @a5} : () -> !llvm.ptr<array<5 x i8>>
    %3 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %4 = "llvm.mlir.addressof"() {global_name = @a5} : () -> !llvm.ptr<array<5 x i8>>
    %5 = "llvm.getelementptr"(%4, %3, %3) : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %6 = "llvm.getelementptr"(%2, %3, %1) : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %7 = "llvm.call"(%arg1, %6) {callee = @sprintf, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> i32
    %8 = "llvm.getelementptr"(%arg0, %3) : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    "llvm.store"(%7, %8) : (i32, !llvm.ptr<i32>) -> ()
    %9 = "llvm.call"(%arg1, %5, %6) {callee = @sprintf, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, !llvm.ptr<i8>) -> i32
    %10 = "llvm.getelementptr"(%arg0, %0) : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    "llvm.store"(%9, %10) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "fold_sprintf_past_end", type = !llvm.func<void (ptr<i32>, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>, %arg1: !llvm.ptr<i8>, %arg2: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 5 : i32} : () -> i32
    %2 = "llvm.mlir.addressof"() {global_name = @a5} : () -> !llvm.ptr<array<5 x i8>>
    %3 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %4 = "llvm.mlir.addressof"() {global_name = @a5} : () -> !llvm.ptr<array<5 x i8>>
    %5 = "llvm.getelementptr"(%4, %3, %3) : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %6 = "llvm.getelementptr"(%2, %3, %1) : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %7 = "llvm.call"(%arg1, %arg2, %6) {callee = @snprintf, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64, !llvm.ptr<i8>) -> i32
    %8 = "llvm.getelementptr"(%arg0, %3) : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    "llvm.store"(%7, %8) : (i32, !llvm.ptr<i32>) -> ()
    %9 = "llvm.call"(%arg1, %arg2, %5, %6) {callee = @snprintf, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64, !llvm.ptr<i8>, !llvm.ptr<i8>) -> i32
    %10 = "llvm.getelementptr"(%arg0, %0) : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    "llvm.store"(%9, %10) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "fold_snprintf_past_end", type = !llvm.func<void (ptr<i32>, ptr<i8>, i64)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
