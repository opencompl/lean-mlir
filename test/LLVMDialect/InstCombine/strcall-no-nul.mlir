module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @a5("%s\0045") {addr_space = 0 : i32}
  llvm.func @strchr(!llvm.ptr, i32) -> !llvm.ptr
  llvm.func @strrchr(!llvm.ptr, i32) -> !llvm.ptr
  llvm.func @strcmp(!llvm.ptr, !llvm.ptr) -> i32
  llvm.func @strncmp(!llvm.ptr, !llvm.ptr, i64) -> i32
  llvm.func @strstr(!llvm.ptr, !llvm.ptr) -> !llvm.ptr
  llvm.func @stpcpy(!llvm.ptr, !llvm.ptr) -> !llvm.ptr
  llvm.func @strcpy(!llvm.ptr, !llvm.ptr) -> !llvm.ptr
  llvm.func @stpncpy(!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
  llvm.func @strncpy(!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
  llvm.func @strlen(!llvm.ptr) -> i64
  llvm.func @strnlen(!llvm.ptr, i64) -> i64
  llvm.func @strpbrk(!llvm.ptr, !llvm.ptr) -> !llvm.ptr
  llvm.func @strspn(!llvm.ptr, !llvm.ptr) -> i64
  llvm.func @strcspn(!llvm.ptr, !llvm.ptr) -> i64
  llvm.func @atoi(!llvm.ptr) -> i32
  llvm.func @atol(!llvm.ptr) -> i64
  llvm.func @atoll(!llvm.ptr) -> i64
  llvm.func @strtol(!llvm.ptr, !llvm.ptr, i32) -> i64
  llvm.func @strtoll(!llvm.ptr, !llvm.ptr, i32) -> i64
  llvm.func @strtoul(!llvm.ptr, !llvm.ptr, i32) -> i64
  llvm.func @strtoull(!llvm.ptr, !llvm.ptr, i32) -> i64
  llvm.func @sprintf(!llvm.ptr, !llvm.ptr, ...) -> i32
  llvm.func @snprintf(!llvm.ptr, i64, !llvm.ptr, ...) -> i32
  llvm.func @fold_strchr_past_end() -> !llvm.ptr {
    %0 = llvm.mlir.constant("%s\0045") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %5 = llvm.call @strchr(%4, %2) : (!llvm.ptr, i32) -> !llvm.ptr
    llvm.return %5 : !llvm.ptr
  }
  llvm.func @fold_strcmp_past_end(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("%s\0045") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %6 = llvm.call @strcmp(%1, %5) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.store %6, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr
    %7 = llvm.call @strcmp(%5, %1) : (!llvm.ptr, !llvm.ptr) -> i32
    %8 = llvm.getelementptr %arg0[%4] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %7, %8 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @fold_strncmp_past_end(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("%s\0045") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.mlir.constant(5 : i64) : i64
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %7 = llvm.call @strncmp(%1, %6, %4) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.store %7, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr
    %8 = llvm.call @strncmp(%6, %1, %4) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %9 = llvm.getelementptr %arg0[%5] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %8, %9 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @fold_strrchr_past_end(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant("%s\0045") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %5 = llvm.call @strrchr(%4, %2) : (!llvm.ptr, i32) -> !llvm.ptr
    llvm.return %5 : !llvm.ptr
  }
  llvm.func @fold_strstr_past_end(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("%s\0045") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %6 = llvm.call @strstr(%1, %5) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.store %6, %arg0 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    %7 = llvm.call @strstr(%5, %1) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    %8 = llvm.getelementptr %arg0[%4] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    llvm.store %7, %8 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return
  }
  llvm.func @fold_strlen_past_end() -> i64 {
    %0 = llvm.mlir.constant("%s\0045") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %5 = llvm.call @strlen(%4) : (!llvm.ptr) -> i64
    llvm.return %5 : i64
  }
  llvm.func @fold_stpcpy_past_end(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant("%s\0045") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %5 = llvm.call @strcpy(%arg0, %4) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.return %5 : !llvm.ptr
  }
  llvm.func @fold_strcpy_past_end(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant("%s\0045") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %5 = llvm.call @strcpy(%arg0, %4) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.return %5 : !llvm.ptr
  }
  llvm.func @fold_stpncpy_past_end(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant("%s\0045") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.mlir.constant(5 : i64) : i64
    %5 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %6 = llvm.call @strncpy(%arg0, %5, %4) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.return %6 : !llvm.ptr
  }
  llvm.func @fold_strncpy_past_end(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant("%s\0045") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.mlir.constant(5 : i64) : i64
    %5 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %6 = llvm.call @strncpy(%arg0, %5, %4) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.return %6 : !llvm.ptr
  }
  llvm.func @fold_strpbrk_past_end(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("%s\0045") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %6 = llvm.call @strpbrk(%1, %5) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.store %6, %arg0 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    %7 = llvm.call @strpbrk(%5, %1) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    %8 = llvm.getelementptr %arg0[%4] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    llvm.store %7, %8 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return
  }
  llvm.func @fold_strspn_past_end(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("%s\0045") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %6 = llvm.call @strspn(%1, %5) : (!llvm.ptr, !llvm.ptr) -> i64
    llvm.store %6, %arg0 {alignment = 4 : i64} : i64, !llvm.ptr
    %7 = llvm.call @strspn(%5, %1) : (!llvm.ptr, !llvm.ptr) -> i64
    %8 = llvm.getelementptr %arg0[%4] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %7, %8 {alignment = 4 : i64} : i64, !llvm.ptr
    llvm.return
  }
  llvm.func @fold_strcspn_past_end(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("%s\0045") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %6 = llvm.call @strcspn(%1, %5) : (!llvm.ptr, !llvm.ptr) -> i64
    llvm.store %6, %arg0 {alignment = 4 : i64} : i64, !llvm.ptr
    %7 = llvm.call @strcspn(%5, %1) : (!llvm.ptr, !llvm.ptr) -> i64
    %8 = llvm.getelementptr %arg0[%4] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %7, %8 {alignment = 4 : i64} : i64, !llvm.ptr
    llvm.return
  }
  llvm.func @fold_atoi_past_end() -> i32 {
    %0 = llvm.mlir.constant("%s\0045") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %5 = llvm.call @atoi(%4) : (!llvm.ptr) -> i32
    llvm.return %5 : i32
  }
  llvm.func @fold_atol_strtol_past_end(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("%s\0045") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.mlir.zero : !llvm.ptr
    %6 = llvm.mlir.constant(2 : i32) : i32
    %7 = llvm.mlir.constant(8 : i32) : i32
    %8 = llvm.mlir.constant(3 : i32) : i32
    %9 = llvm.mlir.constant(10 : i32) : i32
    %10 = llvm.mlir.constant(4 : i32) : i32
    %11 = llvm.mlir.constant(16 : i32) : i32
    %12 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %13 = llvm.call @atol(%12) : (!llvm.ptr) -> i64
    llvm.store %13, %arg0 {alignment = 4 : i64} : i64, !llvm.ptr
    %14 = llvm.call @atoll(%12) : (!llvm.ptr) -> i64
    %15 = llvm.getelementptr %arg0[%4] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %14, %15 {alignment = 4 : i64} : i64, !llvm.ptr
    %16 = llvm.call @strtol(%12, %5, %2) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    %17 = llvm.getelementptr %arg0[%6] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %16, %17 {alignment = 4 : i64} : i64, !llvm.ptr
    %18 = llvm.call @strtoul(%12, %5, %7) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    %19 = llvm.getelementptr %arg0[%8] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %18, %19 {alignment = 4 : i64} : i64, !llvm.ptr
    %20 = llvm.call @strtoll(%12, %5, %9) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    %21 = llvm.getelementptr %arg0[%10] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %20, %21 {alignment = 4 : i64} : i64, !llvm.ptr
    %22 = llvm.call @strtoul(%12, %5, %11) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    %23 = llvm.getelementptr %arg0[%3] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %22, %23 {alignment = 4 : i64} : i64, !llvm.ptr
    llvm.return
  }
  llvm.func @fold_sprintf_past_end(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant("%s\0045") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %6 = llvm.call @sprintf(%arg1, %5) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.store %6, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr
    %7 = llvm.call @sprintf(%arg1, %1, %5) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> i32
    %8 = llvm.getelementptr %arg0[%4] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %7, %8 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @fold_snprintf_past_end(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64) {
    %0 = llvm.mlir.constant("%s\0045") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %6 = llvm.call @snprintf(%arg1, %arg2, %5) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr) -> i32
    llvm.store %6, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr
    %7 = llvm.call @snprintf(%arg1, %arg2, %1, %5) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, !llvm.ptr) -> i32
    %8 = llvm.getelementptr %arg0[%4] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %7, %8 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
}
