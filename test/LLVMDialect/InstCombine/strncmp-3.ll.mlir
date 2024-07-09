module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @ax() {addr_space = 0 : i32} : !llvm.array<0 x i8>
  llvm.mlir.global external @bx() {addr_space = 0 : i32} : !llvm.array<0 x i8>
  llvm.mlir.global external constant @a12345("\01\02\03\04\05") {addr_space = 0 : i32}
  llvm.mlir.global external constant @a123456("\01\02\03\04\05\06") {addr_space = 0 : i32}
  llvm.func @strncmp(!llvm.ptr, !llvm.ptr, i64) -> i32
  llvm.func @call_strncmp_ax_bx_uimax_p1() -> i32 {
    %0 = llvm.mlir.addressof @ax : !llvm.ptr
    %1 = llvm.mlir.addressof @bx : !llvm.ptr
    %2 = llvm.mlir.constant(4294967296 : i64) : i64
    %3 = llvm.call @strncmp(%0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.return %3 : i32
  }
  llvm.func @call_strncmp_ax_bx_uimax_p2() -> i32 {
    %0 = llvm.mlir.addressof @ax : !llvm.ptr
    %1 = llvm.mlir.addressof @bx : !llvm.ptr
    %2 = llvm.mlir.constant(4294967296 : i64) : i64
    %3 = llvm.call @strncmp(%0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.return %3 : i32
  }
  llvm.func @fold_strncmp_a12345_2_uimax_p2() -> i32 {
    %0 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %2 = llvm.mlir.constant("\01\02\03\04\05\06") : !llvm.array<6 x i8>
    %3 = llvm.mlir.addressof @a123456 : !llvm.ptr
    %4 = llvm.mlir.constant(4294967297 : i64) : i64
    %5 = llvm.call @strncmp(%1, %3, %4) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.return %5 : i32
  }
  llvm.func @fold_strncmp_a12345_2_uimax_p3() -> i32 {
    %0 = llvm.mlir.constant("\01\02\03\04\05\06") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @a123456 : !llvm.ptr
    %2 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %3 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %4 = llvm.mlir.constant(4294967298 : i64) : i64
    %5 = llvm.call @strncmp(%1, %3, %4) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.return %5 : i32
  }
}
