"module"() ( {
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "a", type = !llvm.array<5 x i32>, value = dense<[1633837924, 1701209960, 1768581996, 1835954032, 1633837924]> : tensor<5xi32>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "memrchr", type = !llvm.func<ptr<i8> (ptr<i8>, i32, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i64>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 8 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 113 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 7 : i64} : () -> i64
    %3 = "llvm.mlir.constant"() {value = 112 : i32} : () -> i32
    %4 = "llvm.mlir.constant"() {value = 6 : i64} : () -> i64
    %5 = "llvm.mlir.constant"() {value = 111 : i32} : () -> i32
    %6 = "llvm.mlir.constant"() {value = 4 : i64} : () -> i64
    %7 = "llvm.mlir.constant"() {value = 110 : i32} : () -> i32
    %8 = "llvm.mlir.constant"() {value = 3 : i64} : () -> i64
    %9 = "llvm.mlir.constant"() {value = 100 : i32} : () -> i32
    %10 = "llvm.mlir.constant"() {value = 2 : i64} : () -> i64
    %11 = "llvm.mlir.constant"() {value = 99 : i32} : () -> i32
    %12 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %13 = "llvm.mlir.constant"() {value = 98 : i32} : () -> i32
    %14 = "llvm.mlir.constant"() {value = 16 : i64} : () -> i64
    %15 = "llvm.mlir.constant"() {value = 97 : i32} : () -> i32
    %16 = "llvm.mlir.addressof"() {global_name = @a} : () -> !llvm.ptr<array<5 x i32>>
    %17 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %18 = "llvm.mlir.addressof"() {global_name = @a} : () -> !llvm.ptr<array<5 x i32>>
    %19 = "llvm.getelementptr"(%18, %17, %17) : (!llvm.ptr<array<5 x i32>>, i64, i64) -> !llvm.ptr<i32>
    %20 = "llvm.bitcast"(%19) : (!llvm.ptr<i32>) -> !llvm.ptr<i8>
    %21 = "llvm.ptrtoint"(%16) : (!llvm.ptr<array<5 x i32>>) -> i64
    %22 = "llvm.call"(%20, %15, %14) {callee = @memrchr, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    %23 = "llvm.ptrtoint"(%22) : (!llvm.ptr<i8>) -> i64
    %24 = "llvm.sub"(%23, %21) : (i64, i64) -> i64
    %25 = "llvm.getelementptr"(%arg0, %17) : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    "llvm.store"(%24, %25) : (i64, !llvm.ptr<i64>) -> ()
    %26 = "llvm.call"(%20, %13, %14) {callee = @memrchr, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    %27 = "llvm.ptrtoint"(%26) : (!llvm.ptr<i8>) -> i64
    %28 = "llvm.sub"(%27, %21) : (i64, i64) -> i64
    %29 = "llvm.getelementptr"(%arg0, %12) : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    "llvm.store"(%28, %29) : (i64, !llvm.ptr<i64>) -> ()
    %30 = "llvm.call"(%20, %11, %14) {callee = @memrchr, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    %31 = "llvm.ptrtoint"(%30) : (!llvm.ptr<i8>) -> i64
    %32 = "llvm.sub"(%31, %21) : (i64, i64) -> i64
    %33 = "llvm.getelementptr"(%arg0, %10) : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    "llvm.store"(%32, %33) : (i64, !llvm.ptr<i64>) -> ()
    %34 = "llvm.call"(%20, %9, %14) {callee = @memrchr, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    %35 = "llvm.ptrtoint"(%34) : (!llvm.ptr<i8>) -> i64
    %36 = "llvm.sub"(%35, %21) : (i64, i64) -> i64
    %37 = "llvm.getelementptr"(%arg0, %8) : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    "llvm.store"(%36, %37) : (i64, !llvm.ptr<i64>) -> ()
    %38 = "llvm.call"(%20, %7, %14) {callee = @memrchr, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    %39 = "llvm.ptrtoint"(%38) : (!llvm.ptr<i8>) -> i64
    %40 = "llvm.sub"(%39, %21) : (i64, i64) -> i64
    %41 = "llvm.getelementptr"(%arg0, %6) : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    "llvm.store"(%40, %41) : (i64, !llvm.ptr<i64>) -> ()
    %42 = "llvm.call"(%20, %5, %14) {callee = @memrchr, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    %43 = "llvm.ptrtoint"(%42) : (!llvm.ptr<i8>) -> i64
    %44 = "llvm.sub"(%43, %21) : (i64, i64) -> i64
    %45 = "llvm.getelementptr"(%arg0, %4) : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    "llvm.store"(%44, %45) : (i64, !llvm.ptr<i64>) -> ()
    %46 = "llvm.call"(%20, %3, %14) {callee = @memrchr, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    %47 = "llvm.ptrtoint"(%46) : (!llvm.ptr<i8>) -> i64
    %48 = "llvm.sub"(%47, %21) : (i64, i64) -> i64
    %49 = "llvm.getelementptr"(%arg0, %2) : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    "llvm.store"(%48, %49) : (i64, !llvm.ptr<i64>) -> ()
    %50 = "llvm.call"(%20, %1, %14) {callee = @memrchr, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    %51 = "llvm.ptrtoint"(%50) : (!llvm.ptr<i8>) -> i64
    %52 = "llvm.getelementptr"(%arg0, %0) : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    "llvm.store"(%51, %52) : (i64, !llvm.ptr<i64>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "fold_memrchr_a_16", type = !llvm.func<void (ptr<i64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i64>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 100 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 4 : i64} : () -> i64
    %3 = "llvm.mlir.constant"() {value = 97 : i32} : () -> i32
    %4 = "llvm.mlir.constant"() {value = 3 : i64} : () -> i64
    %5 = "llvm.mlir.constant"() {value = 104 : i32} : () -> i32
    %6 = "llvm.mlir.constant"() {value = 2 : i64} : () -> i64
    %7 = "llvm.mlir.constant"() {value = 103 : i32} : () -> i32
    %8 = "llvm.mlir.constant"() {value = 102 : i32} : () -> i32
    %9 = "llvm.mlir.constant"() {value = 12 : i64} : () -> i64
    %10 = "llvm.mlir.constant"() {value = 101 : i32} : () -> i32
    %11 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %12 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %13 = "llvm.mlir.addressof"() {global_name = @a} : () -> !llvm.ptr<array<5 x i32>>
    %14 = "llvm.getelementptr"(%13, %12, %11) : (!llvm.ptr<array<5 x i32>>, i64, i64) -> !llvm.ptr<i32>
    %15 = "llvm.bitcast"(%14) : (!llvm.ptr<i32>) -> !llvm.ptr<i8>
    %16 = "llvm.ptrtoint"(%15) : (!llvm.ptr<i8>) -> i64
    %17 = "llvm.call"(%15, %10, %9) {callee = @memrchr, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    %18 = "llvm.ptrtoint"(%17) : (!llvm.ptr<i8>) -> i64
    %19 = "llvm.sub"(%18, %16) : (i64, i64) -> i64
    %20 = "llvm.getelementptr"(%arg0, %12) : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    "llvm.store"(%19, %20) : (i64, !llvm.ptr<i64>) -> ()
    %21 = "llvm.call"(%15, %8, %9) {callee = @memrchr, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    %22 = "llvm.ptrtoint"(%21) : (!llvm.ptr<i8>) -> i64
    %23 = "llvm.sub"(%22, %16) : (i64, i64) -> i64
    %24 = "llvm.getelementptr"(%arg0, %11) : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    "llvm.store"(%23, %24) : (i64, !llvm.ptr<i64>) -> ()
    %25 = "llvm.call"(%15, %7, %9) {callee = @memrchr, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    %26 = "llvm.ptrtoint"(%25) : (!llvm.ptr<i8>) -> i64
    %27 = "llvm.sub"(%26, %16) : (i64, i64) -> i64
    %28 = "llvm.getelementptr"(%arg0, %6) : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    "llvm.store"(%27, %28) : (i64, !llvm.ptr<i64>) -> ()
    %29 = "llvm.call"(%15, %5, %9) {callee = @memrchr, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    %30 = "llvm.ptrtoint"(%29) : (!llvm.ptr<i8>) -> i64
    %31 = "llvm.sub"(%30, %16) : (i64, i64) -> i64
    %32 = "llvm.getelementptr"(%arg0, %4) : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    "llvm.store"(%31, %32) : (i64, !llvm.ptr<i64>) -> ()
    %33 = "llvm.call"(%15, %3, %9) {callee = @memrchr, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    %34 = "llvm.ptrtoint"(%33) : (!llvm.ptr<i8>) -> i64
    %35 = "llvm.getelementptr"(%arg0, %2) : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    "llvm.store"(%34, %35) : (i64, !llvm.ptr<i64>) -> ()
    %36 = "llvm.call"(%15, %1, %9) {callee = @memrchr, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    %37 = "llvm.ptrtoint"(%36) : (!llvm.ptr<i8>) -> i64
    %38 = "llvm.getelementptr"(%arg0, %0) : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    "llvm.store"(%37, %38) : (i64, !llvm.ptr<i64>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "fold_memrchr_a_p1_16", type = !llvm.func<void (ptr<i64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i64>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 4 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 101 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 3 : i64} : () -> i64
    %3 = "llvm.mlir.constant"() {value = 100 : i32} : () -> i32
    %4 = "llvm.mlir.constant"() {value = 2 : i64} : () -> i64
    %5 = "llvm.mlir.constant"() {value = 99 : i32} : () -> i32
    %6 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %7 = "llvm.mlir.constant"() {value = 98 : i32} : () -> i32
    %8 = "llvm.mlir.constant"() {value = 20 : i64} : () -> i64
    %9 = "llvm.mlir.constant"() {value = 97 : i32} : () -> i32
    %10 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %11 = "llvm.mlir.addressof"() {global_name = @a} : () -> !llvm.ptr<array<5 x i32>>
    %12 = "llvm.getelementptr"(%11, %10, %10) : (!llvm.ptr<array<5 x i32>>, i64, i64) -> !llvm.ptr<i32>
    %13 = "llvm.bitcast"(%12) : (!llvm.ptr<i32>) -> !llvm.ptr<i8>
    %14 = "llvm.ptrtoint"(%13) : (!llvm.ptr<i8>) -> i64
    %15 = "llvm.call"(%13, %9, %8) {callee = @memrchr, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    %16 = "llvm.ptrtoint"(%15) : (!llvm.ptr<i8>) -> i64
    %17 = "llvm.sub"(%16, %14) : (i64, i64) -> i64
    %18 = "llvm.getelementptr"(%arg0, %10) : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    "llvm.store"(%17, %18) : (i64, !llvm.ptr<i64>) -> ()
    %19 = "llvm.call"(%13, %7, %8) {callee = @memrchr, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    %20 = "llvm.ptrtoint"(%19) : (!llvm.ptr<i8>) -> i64
    %21 = "llvm.sub"(%20, %14) : (i64, i64) -> i64
    %22 = "llvm.getelementptr"(%arg0, %6) : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    "llvm.store"(%21, %22) : (i64, !llvm.ptr<i64>) -> ()
    %23 = "llvm.call"(%13, %5, %8) {callee = @memrchr, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    %24 = "llvm.ptrtoint"(%23) : (!llvm.ptr<i8>) -> i64
    %25 = "llvm.sub"(%24, %14) : (i64, i64) -> i64
    %26 = "llvm.getelementptr"(%arg0, %4) : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    "llvm.store"(%25, %26) : (i64, !llvm.ptr<i64>) -> ()
    %27 = "llvm.call"(%13, %3, %8) {callee = @memrchr, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    %28 = "llvm.ptrtoint"(%27) : (!llvm.ptr<i8>) -> i64
    %29 = "llvm.sub"(%28, %14) : (i64, i64) -> i64
    %30 = "llvm.getelementptr"(%arg0, %2) : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    "llvm.store"(%29, %30) : (i64, !llvm.ptr<i64>) -> ()
    %31 = "llvm.call"(%13, %1, %8) {callee = @memrchr, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    %32 = "llvm.ptrtoint"(%31) : (!llvm.ptr<i8>) -> i64
    %33 = "llvm.sub"(%32, %14) : (i64, i64) -> i64
    %34 = "llvm.getelementptr"(%arg0, %0) : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    "llvm.store"(%33, %34) : (i64, !llvm.ptr<i64>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "fold_memrchr_a_20", type = !llvm.func<void (ptr<i64>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
