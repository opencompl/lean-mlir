module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global private unnamed_addr constant @".str"("12\00") {addr_space = 0 : i32, alignment = 1 : i64, dso_local}
  llvm.mlir.global private unnamed_addr constant @".str.1"("0\00") {addr_space = 0 : i32, alignment = 1 : i64, dso_local}
  llvm.mlir.global private unnamed_addr constant @".str.2"("4294967296\00") {addr_space = 0 : i32, alignment = 1 : i64, dso_local}
  llvm.mlir.global private unnamed_addr constant @".str.3"("10000000000000000000000\00") {addr_space = 0 : i32, alignment = 1 : i64, dso_local}
  llvm.mlir.global private unnamed_addr constant @".str.4"("9923372036854775807\00") {addr_space = 0 : i32, alignment = 1 : i64, dso_local}
  llvm.mlir.global private unnamed_addr constant @".str.5"("4994967295\00") {addr_space = 0 : i32, alignment = 1 : i64, dso_local}
  llvm.mlir.global private unnamed_addr constant @".str.6"("499496729\00") {addr_space = 0 : i32, alignment = 1 : i64, dso_local}
  llvm.mlir.global private unnamed_addr constant @".str.7"("4994967295\00") {addr_space = 0 : i32, alignment = 1 : i64, dso_local}
  llvm.func @strtol(!llvm.ptr, !llvm.ptr, i32) -> i32
  llvm.func @atoi(!llvm.ptr) -> i32
  llvm.func @atol(!llvm.ptr) -> i32
  llvm.func @atoll(!llvm.ptr) -> i64
  llvm.func @strtoll(!llvm.ptr, !llvm.ptr, i32) -> i64
  llvm.func @strtol_dec() -> i32 {
    %0 = llvm.mlir.constant("12\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @".str" : !llvm.ptr
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.mlir.constant(10 : i32) : i32
    %4 = llvm.call @strtol(%1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.return %4 : i32
  }
  llvm.func @strtol_base_zero() -> i32 {
    %0 = llvm.mlir.constant("12\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @".str" : !llvm.ptr
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @strtol(%1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.return %4 : i32
  }
  llvm.func @strtol_hex() -> i32 {
    %0 = llvm.mlir.constant("12\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @".str" : !llvm.ptr
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.mlir.constant(16 : i32) : i32
    %4 = llvm.call @strtol(%1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.return %4 : i32
  }
  llvm.func @strtol_endptr_not_null(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant("12\00") : !llvm.array<3 x i8>
    %2 = llvm.mlir.addressof @".str" : !llvm.ptr
    %3 = llvm.mlir.constant(10 : i32) : i32
    %4 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    %5 = llvm.call @strtol(%2, %4, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.return %5 : i32
  }
  llvm.func @strtol_endptr_maybe_null(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant("0\00") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @".str.1" : !llvm.ptr
    %2 = llvm.mlir.constant(10 : i32) : i32
    %3 = llvm.call @strtol(%1, %arg0, %2) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.return %3 : i32
  }
  llvm.func @atoi_test() -> i32 {
    %0 = llvm.mlir.constant("12\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @".str" : !llvm.ptr
    %2 = llvm.call @atoi(%1) : (!llvm.ptr) -> i32
    llvm.return %2 : i32
  }
  llvm.func @strtol_not_const_str(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.call @strtol(%arg0, %0, %1) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @atoi_not_const_str(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.call @atoi(%arg0) : (!llvm.ptr) -> i32
    llvm.return %0 : i32
  }
  llvm.func @strtol_not_const_base(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant("12\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @".str" : !llvm.ptr
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.call @strtol(%1, %2, %arg0) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.return %3 : i32
  }
  llvm.func @strtol_long_int() -> i32 {
    %0 = llvm.mlir.constant("4294967296\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @".str.2" : !llvm.ptr
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.mlir.constant(10 : i32) : i32
    %4 = llvm.call @strtol(%1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.return %4 : i32
  }
  llvm.func @strtol_big_overflow() -> i32 {
    %0 = llvm.mlir.constant("10000000000000000000000\00") : !llvm.array<24 x i8>
    %1 = llvm.mlir.addressof @".str.3" : !llvm.ptr
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.mlir.constant(10 : i32) : i32
    %4 = llvm.call @strtol(%1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.return %4 : i32
  }
  llvm.func @atol_test() -> i32 {
    %0 = llvm.mlir.constant("499496729\00") : !llvm.array<10 x i8>
    %1 = llvm.mlir.addressof @".str.6" : !llvm.ptr
    %2 = llvm.call @atol(%1) : (!llvm.ptr) -> i32
    llvm.return %2 : i32
  }
  llvm.func @atoll_test() -> i64 {
    %0 = llvm.mlir.constant("4994967295\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @".str.5" : !llvm.ptr
    %2 = llvm.call @atoll(%1) : (!llvm.ptr) -> i64
    llvm.return %2 : i64
  }
  llvm.func @strtoll_test() -> i64 {
    %0 = llvm.mlir.constant("4994967295\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @".str.7" : !llvm.ptr
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.mlir.constant(10 : i32) : i32
    %4 = llvm.call @strtoll(%1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    llvm.return %4 : i64
  }
}
