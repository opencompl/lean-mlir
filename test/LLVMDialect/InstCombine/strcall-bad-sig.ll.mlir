module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @a("1\00") {addr_space = 0 : i32}
  llvm.func @atoi(!llvm.ptr) -> !llvm.ptr
  llvm.func @atol(!llvm.ptr) -> !llvm.ptr
  llvm.func @atoll(!llvm.ptr) -> !llvm.ptr
  llvm.func @call_bad_ato(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("1\00") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @a : !llvm.ptr
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.call @atoi(%1) : (!llvm.ptr) -> !llvm.ptr
    llvm.store %4, %arg0 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    %5 = llvm.call @atol(%1) : (!llvm.ptr) -> !llvm.ptr
    %6 = llvm.getelementptr %arg0[%2] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    llvm.store %5, %6 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    %7 = llvm.call @atol(%1) : (!llvm.ptr) -> !llvm.ptr
    %8 = llvm.getelementptr %arg0[%3] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    llvm.store %7, %8 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return
  }
  llvm.func @strncasecmp(!llvm.ptr, !llvm.ptr) -> !llvm.ptr
  llvm.func @call_bad_strncasecmp() -> !llvm.ptr {
    %0 = llvm.mlir.constant("1\00") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @a : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<2 x i8>
    %5 = llvm.call @strncasecmp(%1, %4) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.return %5 : !llvm.ptr
  }
  llvm.func @strcoll(!llvm.ptr, !llvm.ptr, !llvm.ptr) -> i1
  llvm.func @call_bad_strcoll() -> i1 {
    %0 = llvm.mlir.constant("1\00") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @a : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<2 x i8>
    %5 = llvm.call @strcoll(%1, %4, %1) : (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> i1
    llvm.return %5 : i1
  }
  llvm.func @strndup(!llvm.ptr) -> !llvm.ptr
  llvm.func @call_bad_strndup() -> !llvm.ptr {
    %0 = llvm.mlir.constant("1\00") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @a : !llvm.ptr
    %2 = llvm.call @strndup(%1) : (!llvm.ptr) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }
  llvm.func @strtok(!llvm.ptr, !llvm.ptr, i1) -> i1
  llvm.func @call_bad_strtok() -> i1 {
    %0 = llvm.mlir.constant("1\00") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @a : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<2 x i8>
    %6 = llvm.call @strtok(%1, %5, %4) : (!llvm.ptr, !llvm.ptr, i1) -> i1
    llvm.return %6 : i1
  }
  llvm.func @strtok_r(!llvm.ptr, !llvm.ptr) -> i1
  llvm.func @call_bad_strtok_r() -> i1 {
    %0 = llvm.mlir.constant("1\00") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @a : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<2 x i8>
    %5 = llvm.call @strtok_r(%1, %4) : (!llvm.ptr, !llvm.ptr) -> i1
    llvm.return %5 : i1
  }
  llvm.func @strtol(!llvm.ptr, !llvm.ptr) -> i32
  llvm.func @strtoul(!llvm.ptr, !llvm.ptr) -> i32
  llvm.func @strtoll(!llvm.ptr, !llvm.ptr) -> i64
  llvm.func @strtoull(!llvm.ptr, !llvm.ptr) -> i64
  llvm.func @call_bad_strto(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant("1\00") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @a : !llvm.ptr
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(3 : i32) : i32
    %5 = llvm.call @strtol(%1, %2) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.store %5, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr
    %6 = llvm.call @strtoul(%1, %2) : (!llvm.ptr, !llvm.ptr) -> i32
    %7 = llvm.getelementptr %arg0[%3] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %6, %7 {alignment = 4 : i64} : i32, !llvm.ptr
    %8 = llvm.call @strtoll(%1, %2) : (!llvm.ptr, !llvm.ptr) -> i64
    llvm.store %8, %arg1 {alignment = 4 : i64} : i64, !llvm.ptr
    %9 = llvm.call @strtoull(%1, %2) : (!llvm.ptr, !llvm.ptr) -> i64
    %10 = llvm.getelementptr %arg1[%4] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %9, %10 {alignment = 4 : i64} : i64, !llvm.ptr
    llvm.return
  }
  llvm.func @strxfrm(!llvm.ptr, !llvm.ptr) -> !llvm.ptr
  llvm.func @call_bad_strxfrm() -> !llvm.ptr {
    %0 = llvm.mlir.constant("1\00") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @a : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<2 x i8>
    %5 = llvm.call @strxfrm(%1, %4) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.return %5 : !llvm.ptr
  }
}
