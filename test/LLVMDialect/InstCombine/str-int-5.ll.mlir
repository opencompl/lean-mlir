"module"() ( {
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "ws", type = !llvm.array<7 x i8>, value = "\09\0D\0A\0B\0C \00"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "ws_im123", type = !llvm.array<11 x i8>, value = "\09\0D\0A\0B\0C -123\00"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "ws_ip234", type = !llvm.array<11 x i8>, value = "\09\0D\0A\0B\0C +234\00"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "i32min", type = !llvm.array<13 x i8>, value = " -2147483648\00"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "i32min_m1", type = !llvm.array<13 x i8>, value = " -2147483649\00"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "o32min", type = !llvm.array<15 x i8>, value = " +020000000000\00"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "mo32min", type = !llvm.array<15 x i8>, value = " -020000000000\00"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "x32min", type = !llvm.array<13 x i8>, value = " +0x80000000\00"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "mx32min", type = !llvm.array<13 x i8>, value = " +0x80000000\00"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "i32max", type = !llvm.array<12 x i8>, value = " 2147483647\00"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "i32max_p1", type = !llvm.array<12 x i8>, value = " 2147483648\00"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "mX01", type = !llvm.array<6 x i8>, value = " -0X1\00"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "ui32max", type = !llvm.array<12 x i8>, value = " 4294967295\00"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "ui32max_p1", type = !llvm.array<12 x i8>, value = " 4294967296\00"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "i64min", type = !llvm.array<22 x i8>, value = " -9223372036854775808\00"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "i64min_m1", type = !llvm.array<22 x i8>, value = " -9223372036854775809\00"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "i64max", type = !llvm.array<21 x i8>, value = " 9223372036854775807\00"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "i64max_p1", type = !llvm.array<21 x i8>, value = " 9223372036854775808\00"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "ui64max", type = !llvm.array<22 x i8>, value = " 18446744073709551615\00"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "x64max", type = !llvm.array<20 x i8>, value = " 0xffffffffffffffff\00"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "ui64max_p1", type = !llvm.array<22 x i8>, value = " 18446744073709551616\00"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {linkage = 10 : i64, sym_name = "endptr", type = !llvm.ptr<i8>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "strtoul", type = !llvm.func<i32 (ptr<i8>, ptr<ptr<i8>>, i32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "strtoull", type = !llvm.func<i64 (ptr<i8>, ptr<ptr<i8>>, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 11 : i32} : () -> i32
    %1 = "llvm.mlir.addressof"() {global_name = @endptr} : () -> !llvm.ptr<ptr<i8>>
    %2 = "llvm.mlir.addressof"() {global_name = @ui32max} : () -> !llvm.ptr<array<12 x i8>>
    %3 = "llvm.mlir.addressof"() {global_name = @endptr} : () -> !llvm.ptr<ptr<i8>>
    %4 = "llvm.mlir.addressof"() {global_name = @i32max_p1} : () -> !llvm.ptr<array<12 x i8>>
    %5 = "llvm.mlir.constant"() {value = 9 : i32} : () -> i32
    %6 = "llvm.mlir.addressof"() {global_name = @endptr} : () -> !llvm.ptr<ptr<i8>>
    %7 = "llvm.mlir.addressof"() {global_name = @mX01} : () -> !llvm.ptr<array<6 x i8>>
    %8 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %9 = "llvm.mlir.addressof"() {global_name = @endptr} : () -> !llvm.ptr<ptr<i8>>
    %10 = "llvm.mlir.addressof"() {global_name = @i32max} : () -> !llvm.ptr<array<12 x i8>>
    %11 = "llvm.mlir.constant"() {value = 7 : i32} : () -> i32
    %12 = "llvm.mlir.addressof"() {global_name = @endptr} : () -> !llvm.ptr<ptr<i8>>
    %13 = "llvm.mlir.addressof"() {global_name = @mx32min} : () -> !llvm.ptr<array<13 x i8>>
    %14 = "llvm.mlir.constant"() {value = 6 : i32} : () -> i32
    %15 = "llvm.mlir.addressof"() {global_name = @endptr} : () -> !llvm.ptr<ptr<i8>>
    %16 = "llvm.mlir.addressof"() {global_name = @x32min} : () -> !llvm.ptr<array<13 x i8>>
    %17 = "llvm.mlir.constant"() {value = 5 : i32} : () -> i32
    %18 = "llvm.mlir.addressof"() {global_name = @endptr} : () -> !llvm.ptr<ptr<i8>>
    %19 = "llvm.mlir.addressof"() {global_name = @mo32min} : () -> !llvm.ptr<array<15 x i8>>
    %20 = "llvm.mlir.constant"() {value = 4 : i32} : () -> i32
    %21 = "llvm.mlir.addressof"() {global_name = @endptr} : () -> !llvm.ptr<ptr<i8>>
    %22 = "llvm.mlir.addressof"() {global_name = @o32min} : () -> !llvm.ptr<array<15 x i8>>
    %23 = "llvm.mlir.constant"() {value = 3 : i32} : () -> i32
    %24 = "llvm.mlir.addressof"() {global_name = @endptr} : () -> !llvm.ptr<ptr<i8>>
    %25 = "llvm.mlir.addressof"() {global_name = @i32min} : () -> !llvm.ptr<array<13 x i8>>
    %26 = "llvm.mlir.constant"() {value = 2 : i32} : () -> i32
    %27 = "llvm.mlir.addressof"() {global_name = @endptr} : () -> !llvm.ptr<ptr<i8>>
    %28 = "llvm.mlir.addressof"() {global_name = @i32min_m1} : () -> !llvm.ptr<array<13 x i8>>
    %29 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %30 = "llvm.mlir.addressof"() {global_name = @endptr} : () -> !llvm.ptr<ptr<i8>>
    %31 = "llvm.mlir.addressof"() {global_name = @ws_ip234} : () -> !llvm.ptr<array<11 x i8>>
    %32 = "llvm.mlir.constant"() {value = 10 : i32} : () -> i32
    %33 = "llvm.mlir.addressof"() {global_name = @endptr} : () -> !llvm.ptr<ptr<i8>>
    %34 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %35 = "llvm.mlir.addressof"() {global_name = @ws_im123} : () -> !llvm.ptr<array<11 x i8>>
    %36 = "llvm.getelementptr"(%35, %34, %34) : (!llvm.ptr<array<11 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %37 = "llvm.call"(%36, %33, %32) {callee = @strtoul, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i32
    %38 = "llvm.getelementptr"(%arg0, %34) : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    "llvm.store"(%37, %38) : (i32, !llvm.ptr<i32>) -> ()
    %39 = "llvm.getelementptr"(%31, %34, %34) : (!llvm.ptr<array<11 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %40 = "llvm.call"(%39, %30, %32) {callee = @strtoul, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i32
    %41 = "llvm.getelementptr"(%arg0, %29) : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    "llvm.store"(%40, %41) : (i32, !llvm.ptr<i32>) -> ()
    %42 = "llvm.getelementptr"(%28, %34, %34) : (!llvm.ptr<array<13 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %43 = "llvm.call"(%42, %27, %32) {callee = @strtoul, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i32
    %44 = "llvm.getelementptr"(%arg0, %26) : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    "llvm.store"(%43, %44) : (i32, !llvm.ptr<i32>) -> ()
    %45 = "llvm.getelementptr"(%25, %34, %34) : (!llvm.ptr<array<13 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %46 = "llvm.call"(%45, %24, %32) {callee = @strtoul, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i32
    %47 = "llvm.getelementptr"(%arg0, %23) : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    "llvm.store"(%46, %47) : (i32, !llvm.ptr<i32>) -> ()
    %48 = "llvm.getelementptr"(%22, %34, %34) : (!llvm.ptr<array<15 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %49 = "llvm.call"(%48, %21, %34) {callee = @strtoul, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i32
    %50 = "llvm.getelementptr"(%arg0, %20) : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    "llvm.store"(%49, %50) : (i32, !llvm.ptr<i32>) -> ()
    %51 = "llvm.getelementptr"(%19, %34, %34) : (!llvm.ptr<array<15 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %52 = "llvm.call"(%51, %18, %34) {callee = @strtoul, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i32
    %53 = "llvm.getelementptr"(%arg0, %17) : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    "llvm.store"(%52, %53) : (i32, !llvm.ptr<i32>) -> ()
    %54 = "llvm.getelementptr"(%16, %34, %34) : (!llvm.ptr<array<13 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %55 = "llvm.call"(%54, %15, %34) {callee = @strtoul, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i32
    %56 = "llvm.getelementptr"(%arg0, %14) : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    "llvm.store"(%55, %56) : (i32, !llvm.ptr<i32>) -> ()
    %57 = "llvm.getelementptr"(%13, %34, %34) : (!llvm.ptr<array<13 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %58 = "llvm.call"(%57, %12, %34) {callee = @strtoul, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i32
    %59 = "llvm.getelementptr"(%arg0, %11) : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    "llvm.store"(%55, %59) : (i32, !llvm.ptr<i32>) -> ()
    %60 = "llvm.getelementptr"(%10, %34, %34) : (!llvm.ptr<array<12 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %61 = "llvm.call"(%60, %9, %32) {callee = @strtoul, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i32
    %62 = "llvm.getelementptr"(%arg0, %8) : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    "llvm.store"(%61, %62) : (i32, !llvm.ptr<i32>) -> ()
    %63 = "llvm.getelementptr"(%7, %34, %34) : (!llvm.ptr<array<6 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %64 = "llvm.call"(%63, %6, %34) {callee = @strtoul, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i32
    %65 = "llvm.getelementptr"(%arg0, %5) : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    "llvm.store"(%64, %65) : (i32, !llvm.ptr<i32>) -> ()
    %66 = "llvm.getelementptr"(%4, %34, %34) : (!llvm.ptr<array<12 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %67 = "llvm.call"(%66, %3, %32) {callee = @strtoul, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i32
    %68 = "llvm.getelementptr"(%arg0, %32) : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    "llvm.store"(%67, %68) : (i32, !llvm.ptr<i32>) -> ()
    %69 = "llvm.getelementptr"(%2, %34, %34) : (!llvm.ptr<array<12 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %70 = "llvm.call"(%69, %1, %32) {callee = @strtoul, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i32
    %71 = "llvm.getelementptr"(%arg0, %0) : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    "llvm.store"(%70, %71) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "fold_strtoul", type = !llvm.func<void (ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3 : i32} : () -> i32
    %1 = "llvm.mlir.addressof"() {global_name = @endptr} : () -> !llvm.ptr<ptr<i8>>
    %2 = "llvm.mlir.constant"() {value = 6 : i32} : () -> i32
    %3 = "llvm.mlir.addressof"() {global_name = @ws} : () -> !llvm.ptr<array<7 x i8>>
    %4 = "llvm.mlir.constant"() {value = 2 : i32} : () -> i32
    %5 = "llvm.mlir.addressof"() {global_name = @endptr} : () -> !llvm.ptr<ptr<i8>>
    %6 = "llvm.mlir.addressof"() {global_name = @ws} : () -> !llvm.ptr<array<7 x i8>>
    %7 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %8 = "llvm.mlir.addressof"() {global_name = @endptr} : () -> !llvm.ptr<ptr<i8>>
    %9 = "llvm.mlir.addressof"() {global_name = @ui32max_p1} : () -> !llvm.ptr<array<12 x i8>>
    %10 = "llvm.mlir.constant"() {value = 10 : i32} : () -> i32
    %11 = "llvm.mlir.addressof"() {global_name = @endptr} : () -> !llvm.ptr<ptr<i8>>
    %12 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %13 = "llvm.mlir.addressof"() {global_name = @i64min_m1} : () -> !llvm.ptr<array<22 x i8>>
    %14 = "llvm.getelementptr"(%13, %12, %12) : (!llvm.ptr<array<22 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %15 = "llvm.call"(%14, %11, %10) {callee = @strtoul, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i32
    %16 = "llvm.getelementptr"(%arg0, %12) : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    "llvm.store"(%15, %16) : (i32, !llvm.ptr<i32>) -> ()
    %17 = "llvm.getelementptr"(%9, %12, %12) : (!llvm.ptr<array<12 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %18 = "llvm.call"(%17, %8, %10) {callee = @strtoul, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i32
    %19 = "llvm.getelementptr"(%arg0, %7) : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    "llvm.store"(%18, %19) : (i32, !llvm.ptr<i32>) -> ()
    %20 = "llvm.getelementptr"(%6, %12, %12) : (!llvm.ptr<array<7 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %21 = "llvm.call"(%20, %5, %10) {callee = @strtoul, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i32
    %22 = "llvm.getelementptr"(%arg0, %4) : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    "llvm.store"(%21, %22) : (i32, !llvm.ptr<i32>) -> ()
    %23 = "llvm.getelementptr"(%3, %12, %2) : (!llvm.ptr<array<7 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %24 = "llvm.call"(%23, %1, %10) {callee = @strtoul, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i32
    %25 = "llvm.getelementptr"(%arg0, %0) : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    "llvm.store"(%24, %25) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "call_strtoul", type = !llvm.func<void (ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i64>):  // no predecessors
    %0 = "llvm.mlir.addressof"() {global_name = @endptr} : () -> !llvm.ptr<ptr<i8>>
    %1 = "llvm.mlir.addressof"() {global_name = @x64max} : () -> !llvm.ptr<array<20 x i8>>
    %2 = "llvm.mlir.constant"() {value = 9 : i32} : () -> i32
    %3 = "llvm.mlir.addressof"() {global_name = @endptr} : () -> !llvm.ptr<ptr<i8>>
    %4 = "llvm.mlir.addressof"() {global_name = @ui64max} : () -> !llvm.ptr<array<22 x i8>>
    %5 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %6 = "llvm.mlir.addressof"() {global_name = @endptr} : () -> !llvm.ptr<ptr<i8>>
    %7 = "llvm.mlir.addressof"() {global_name = @i64max_p1} : () -> !llvm.ptr<array<21 x i8>>
    %8 = "llvm.mlir.constant"() {value = 7 : i32} : () -> i32
    %9 = "llvm.mlir.addressof"() {global_name = @endptr} : () -> !llvm.ptr<ptr<i8>>
    %10 = "llvm.mlir.addressof"() {global_name = @i64max} : () -> !llvm.ptr<array<21 x i8>>
    %11 = "llvm.mlir.constant"() {value = 6 : i32} : () -> i32
    %12 = "llvm.mlir.addressof"() {global_name = @endptr} : () -> !llvm.ptr<ptr<i8>>
    %13 = "llvm.mlir.addressof"() {global_name = @i64min} : () -> !llvm.ptr<array<22 x i8>>
    %14 = "llvm.mlir.constant"() {value = 5 : i32} : () -> i32
    %15 = "llvm.mlir.addressof"() {global_name = @endptr} : () -> !llvm.ptr<ptr<i8>>
    %16 = "llvm.mlir.addressof"() {global_name = @x32min} : () -> !llvm.ptr<array<13 x i8>>
    %17 = "llvm.mlir.constant"() {value = 4 : i32} : () -> i32
    %18 = "llvm.mlir.addressof"() {global_name = @endptr} : () -> !llvm.ptr<ptr<i8>>
    %19 = "llvm.mlir.addressof"() {global_name = @o32min} : () -> !llvm.ptr<array<15 x i8>>
    %20 = "llvm.mlir.constant"() {value = 3 : i32} : () -> i32
    %21 = "llvm.mlir.addressof"() {global_name = @endptr} : () -> !llvm.ptr<ptr<i8>>
    %22 = "llvm.mlir.addressof"() {global_name = @i32min} : () -> !llvm.ptr<array<13 x i8>>
    %23 = "llvm.mlir.constant"() {value = 2 : i32} : () -> i32
    %24 = "llvm.mlir.addressof"() {global_name = @endptr} : () -> !llvm.ptr<ptr<i8>>
    %25 = "llvm.mlir.addressof"() {global_name = @i64min_m1} : () -> !llvm.ptr<array<22 x i8>>
    %26 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %27 = "llvm.mlir.addressof"() {global_name = @endptr} : () -> !llvm.ptr<ptr<i8>>
    %28 = "llvm.mlir.addressof"() {global_name = @ws_ip234} : () -> !llvm.ptr<array<11 x i8>>
    %29 = "llvm.mlir.constant"() {value = 10 : i32} : () -> i32
    %30 = "llvm.mlir.addressof"() {global_name = @endptr} : () -> !llvm.ptr<ptr<i8>>
    %31 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %32 = "llvm.mlir.addressof"() {global_name = @ws_im123} : () -> !llvm.ptr<array<11 x i8>>
    %33 = "llvm.getelementptr"(%32, %31, %31) : (!llvm.ptr<array<11 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %34 = "llvm.call"(%33, %30, %29) {callee = @strtoull, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
    %35 = "llvm.getelementptr"(%arg0, %31) : (!llvm.ptr<i64>, i32) -> !llvm.ptr<i64>
    "llvm.store"(%34, %35) : (i64, !llvm.ptr<i64>) -> ()
    %36 = "llvm.getelementptr"(%28, %31, %31) : (!llvm.ptr<array<11 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %37 = "llvm.call"(%36, %27, %29) {callee = @strtoull, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
    %38 = "llvm.getelementptr"(%arg0, %26) : (!llvm.ptr<i64>, i32) -> !llvm.ptr<i64>
    "llvm.store"(%37, %38) : (i64, !llvm.ptr<i64>) -> ()
    %39 = "llvm.getelementptr"(%25, %31, %31) : (!llvm.ptr<array<22 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %40 = "llvm.call"(%39, %24, %29) {callee = @strtoull, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
    %41 = "llvm.getelementptr"(%arg0, %23) : (!llvm.ptr<i64>, i32) -> !llvm.ptr<i64>
    "llvm.store"(%40, %41) : (i64, !llvm.ptr<i64>) -> ()
    %42 = "llvm.getelementptr"(%22, %31, %31) : (!llvm.ptr<array<13 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %43 = "llvm.call"(%42, %21, %29) {callee = @strtoull, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
    %44 = "llvm.getelementptr"(%arg0, %20) : (!llvm.ptr<i64>, i32) -> !llvm.ptr<i64>
    "llvm.store"(%43, %44) : (i64, !llvm.ptr<i64>) -> ()
    %45 = "llvm.getelementptr"(%19, %31, %31) : (!llvm.ptr<array<15 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %46 = "llvm.call"(%45, %18, %31) {callee = @strtoull, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
    %47 = "llvm.getelementptr"(%arg0, %17) : (!llvm.ptr<i64>, i32) -> !llvm.ptr<i64>
    "llvm.store"(%46, %47) : (i64, !llvm.ptr<i64>) -> ()
    %48 = "llvm.getelementptr"(%16, %31, %31) : (!llvm.ptr<array<13 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %49 = "llvm.call"(%48, %15, %31) {callee = @strtoull, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
    %50 = "llvm.getelementptr"(%arg0, %14) : (!llvm.ptr<i64>, i32) -> !llvm.ptr<i64>
    "llvm.store"(%49, %50) : (i64, !llvm.ptr<i64>) -> ()
    %51 = "llvm.getelementptr"(%13, %31, %31) : (!llvm.ptr<array<22 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %52 = "llvm.call"(%51, %12, %29) {callee = @strtoull, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
    %53 = "llvm.getelementptr"(%arg0, %11) : (!llvm.ptr<i64>, i32) -> !llvm.ptr<i64>
    "llvm.store"(%52, %53) : (i64, !llvm.ptr<i64>) -> ()
    %54 = "llvm.getelementptr"(%10, %31, %31) : (!llvm.ptr<array<21 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %55 = "llvm.call"(%54, %9, %29) {callee = @strtoull, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
    %56 = "llvm.getelementptr"(%arg0, %8) : (!llvm.ptr<i64>, i32) -> !llvm.ptr<i64>
    "llvm.store"(%55, %56) : (i64, !llvm.ptr<i64>) -> ()
    %57 = "llvm.getelementptr"(%7, %31, %31) : (!llvm.ptr<array<21 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %58 = "llvm.call"(%57, %6, %29) {callee = @strtoull, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
    %59 = "llvm.getelementptr"(%arg0, %5) : (!llvm.ptr<i64>, i32) -> !llvm.ptr<i64>
    "llvm.store"(%58, %59) : (i64, !llvm.ptr<i64>) -> ()
    %60 = "llvm.getelementptr"(%4, %31, %31) : (!llvm.ptr<array<22 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %61 = "llvm.call"(%60, %3, %29) {callee = @strtoull, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
    %62 = "llvm.getelementptr"(%arg0, %2) : (!llvm.ptr<i64>, i32) -> !llvm.ptr<i64>
    "llvm.store"(%61, %62) : (i64, !llvm.ptr<i64>) -> ()
    %63 = "llvm.getelementptr"(%1, %31, %31) : (!llvm.ptr<array<20 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %64 = "llvm.call"(%63, %0, %31) {callee = @strtoull, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
    %65 = "llvm.getelementptr"(%arg0, %29) : (!llvm.ptr<i64>, i32) -> !llvm.ptr<i64>
    "llvm.store"(%64, %65) : (i64, !llvm.ptr<i64>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "fold_strtoull", type = !llvm.func<void (ptr<i64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i64>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3 : i32} : () -> i32
    %1 = "llvm.mlir.addressof"() {global_name = @endptr} : () -> !llvm.ptr<ptr<i8>>
    %2 = "llvm.mlir.constant"() {value = 6 : i32} : () -> i32
    %3 = "llvm.mlir.addressof"() {global_name = @ws} : () -> !llvm.ptr<array<7 x i8>>
    %4 = "llvm.mlir.constant"() {value = 2 : i32} : () -> i32
    %5 = "llvm.mlir.addressof"() {global_name = @endptr} : () -> !llvm.ptr<ptr<i8>>
    %6 = "llvm.mlir.addressof"() {global_name = @ws} : () -> !llvm.ptr<array<7 x i8>>
    %7 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %8 = "llvm.mlir.constant"() {value = 10 : i32} : () -> i32
    %9 = "llvm.mlir.addressof"() {global_name = @endptr} : () -> !llvm.ptr<ptr<i8>>
    %10 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %11 = "llvm.mlir.addressof"() {global_name = @ui64max_p1} : () -> !llvm.ptr<array<22 x i8>>
    %12 = "llvm.getelementptr"(%11, %10, %10) : (!llvm.ptr<array<22 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %13 = "llvm.call"(%12, %9, %8) {callee = @strtoull, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
    %14 = "llvm.getelementptr"(%arg0, %7) : (!llvm.ptr<i64>, i32) -> !llvm.ptr<i64>
    "llvm.store"(%13, %14) : (i64, !llvm.ptr<i64>) -> ()
    %15 = "llvm.getelementptr"(%6, %10, %10) : (!llvm.ptr<array<7 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %16 = "llvm.call"(%15, %5, %8) {callee = @strtoull, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
    %17 = "llvm.getelementptr"(%arg0, %4) : (!llvm.ptr<i64>, i32) -> !llvm.ptr<i64>
    "llvm.store"(%16, %17) : (i64, !llvm.ptr<i64>) -> ()
    %18 = "llvm.getelementptr"(%3, %10, %2) : (!llvm.ptr<array<7 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %19 = "llvm.call"(%18, %1, %8) {callee = @strtoull, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
    %20 = "llvm.getelementptr"(%arg0, %0) : (!llvm.ptr<i64>, i32) -> !llvm.ptr<i64>
    "llvm.store"(%19, %20) : (i64, !llvm.ptr<i64>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "call_strtoull", type = !llvm.func<void (ptr<i64>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
