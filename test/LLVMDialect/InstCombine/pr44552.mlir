module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @csmith_sink_(0 : i64) {addr_space = 0 : i32, alignment = 1 : i64, dso_local} : i64
  llvm.mlir.global internal constant @g_302_7(0 : i32) {addr_space = 0 : i32, alignment = 1 : i64, dso_local} : i32
  llvm.mlir.global internal @g_313_0(0 : i16) {addr_space = 0 : i32, alignment = 1 : i64, dso_local} : i16
  llvm.mlir.global internal @g_313_1(0 : i32) {addr_space = 0 : i32, alignment = 1 : i64, dso_local} : i32
  llvm.mlir.global internal @g_313_2(0 : i32) {addr_space = 0 : i32, alignment = 1 : i64, dso_local} : i32
  llvm.mlir.global internal @g_313_3(0 : i32) {addr_space = 0 : i32, alignment = 1 : i64, dso_local} : i32
  llvm.mlir.global internal @g_313_4(0 : i16) {addr_space = 0 : i32, alignment = 1 : i64, dso_local} : i16
  llvm.mlir.global internal @g_313_5(0 : i16) {addr_space = 0 : i32, alignment = 1 : i64, dso_local} : i16
  llvm.mlir.global internal @g_313_6(0 : i16) {addr_space = 0 : i32, alignment = 1 : i64, dso_local} : i16
  llvm.mlir.global internal @g_316() {addr_space = 0 : i32, alignment = 1 : i64, dso_local} : !llvm.struct<"struct.S3", (i64)> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.undef : !llvm.struct<"struct.S3", (i64)>
    %2 = llvm.insertvalue %0, %1[0] : !llvm.struct<"struct.S3", (i64)> 
    llvm.return %2 : !llvm.struct<"struct.S3", (i64)>
  }
  llvm.mlir.global internal @g_316_1_0(0 : i16) {addr_space = 0 : i32, alignment = 1 : i64, dso_local} : i16
  llvm.func @main() -> i16 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.addressof @csmith_sink_ : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i16) : i16
    %3 = llvm.mlir.addressof @g_313_0 : !llvm.ptr
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.addressof @g_313_1 : !llvm.ptr
    %6 = llvm.mlir.addressof @g_313_2 : !llvm.ptr
    %7 = llvm.mlir.addressof @g_313_3 : !llvm.ptr
    %8 = llvm.mlir.addressof @g_313_4 : !llvm.ptr
    %9 = llvm.mlir.addressof @g_313_5 : !llvm.ptr
    %10 = llvm.mlir.addressof @g_313_6 : !llvm.ptr
    %11 = llvm.mlir.undef : !llvm.struct<"struct.S3", (i64)>
    %12 = llvm.insertvalue %0, %11[0] : !llvm.struct<"struct.S3", (i64)> 
    %13 = llvm.mlir.addressof @g_316 : !llvm.ptr
    %14 = llvm.mlir.addressof @g_316_1_0 : !llvm.ptr
    llvm.store %0, %1 {alignment = 1 : i64} : i64, !llvm.ptr
    %15 = llvm.load %3 {alignment = 1 : i64} : !llvm.ptr -> i16
    %16 = llvm.sext %15 : i16 to i64
    llvm.store %16, %1 {alignment = 1 : i64} : i64, !llvm.ptr
    %17 = llvm.load %5 {alignment = 1 : i64} : !llvm.ptr -> i32
    %18 = llvm.zext %17 : i32 to i64
    llvm.store %18, %1 {alignment = 1 : i64} : i64, !llvm.ptr
    %19 = llvm.load %6 {alignment = 1 : i64} : !llvm.ptr -> i32
    %20 = llvm.sext %19 : i32 to i64
    llvm.store %20, %1 {alignment = 1 : i64} : i64, !llvm.ptr
    %21 = llvm.load %7 {alignment = 1 : i64} : !llvm.ptr -> i32
    %22 = llvm.zext %21 : i32 to i64
    llvm.store %22, %1 {alignment = 1 : i64} : i64, !llvm.ptr
    %23 = llvm.load %8 {alignment = 1 : i64} : !llvm.ptr -> i16
    %24 = llvm.sext %23 : i16 to i64
    llvm.store %24, %1 {alignment = 1 : i64} : i64, !llvm.ptr
    %25 = llvm.load %9 {alignment = 1 : i64} : !llvm.ptr -> i16
    %26 = llvm.sext %25 : i16 to i64
    llvm.store %26, %1 {alignment = 1 : i64} : i64, !llvm.ptr
    %27 = llvm.load %10 {alignment = 1 : i64} : !llvm.ptr -> i16
    %28 = llvm.sext %27 : i16 to i64
    llvm.store %28, %1 {alignment = 1 : i64} : i64, !llvm.ptr
    %29 = llvm.load %13 {alignment = 1 : i64} : !llvm.ptr -> i64
    llvm.store %29, %1 {alignment = 1 : i64} : i64, !llvm.ptr
    %30 = llvm.load %14 {alignment = 1 : i64} : !llvm.ptr -> i16
    %31 = llvm.sext %30 : i16 to i64
    llvm.store %31, %1 {alignment = 1 : i64} : i64, !llvm.ptr
    llvm.store %0, %1 {alignment = 1 : i64} : i64, !llvm.ptr
    llvm.return %2 : i16
  }
}
