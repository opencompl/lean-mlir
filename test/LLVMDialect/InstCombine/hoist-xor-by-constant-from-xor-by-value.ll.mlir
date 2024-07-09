module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @a(17 : i8) {addr_space = 0 : i32} : i8
  llvm.mlir.global internal @global_constant(0 : i32) {addr_space = 0 : i32, alignment = 4 : i64, dso_local} : i32
  llvm.mlir.global internal @global_constant2(0 : i32) {addr_space = 0 : i32, alignment = 4 : i64, dso_local} : i32
  llvm.mlir.global external @global_constant3() {addr_space = 0 : i32, alignment = 1 : i64} : !llvm.array<6 x array<1 x i64>>
  llvm.mlir.global external @global_constant4() {addr_space = 0 : i32, alignment = 1 : i64} : i64
  llvm.mlir.global external @global_constant5() {addr_space = 0 : i32, alignment = 1 : i64} : !llvm.ptr
  llvm.func @gen8() -> i8
  llvm.func @use8(i8)
  llvm.func @t0_scalar(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %1, %arg1  : i8
    llvm.return %2 : i8
  }
  llvm.func @t1_splatvec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.xor %arg0, %0  : vector<2xi8>
    %2 = llvm.xor %1, %arg1  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }
  llvm.func @t2_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[42, 24]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.xor %arg0, %0  : vector<2xi8>
    %2 = llvm.xor %1, %arg1  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }
  llvm.func @t3_vec_undef(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.undef : i8
    %1 = llvm.mlir.constant(42 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.xor %arg0, %6  : vector<2xi8>
    %8 = llvm.xor %7, %arg1  : vector<2xi8>
    llvm.return %8 : vector<2xi8>
  }
  llvm.func @t4_extrause(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.xor %1, %arg1  : i8
    llvm.return %2 : i8
  }
  llvm.func @t5_commutativity(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.call @gen8() : () -> i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func local_unnamed_addr @constantexpr(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @global_constant2 : !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i8
    %3 = llvm.mlir.addressof @global_constant : !llvm.ptr
    %4 = llvm.ptrtoint %3 : !llvm.ptr to i8
    %5 = llvm.xor %4, %2  : i8
    %6 = llvm.xor %arg0, %5  : i8
    llvm.return %6 : i8
  }
  llvm.func @constantexpr2() -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(5 : i16) : i16
    %2 = llvm.mlir.addressof @global_constant3 : !llvm.ptr
    %3 = llvm.getelementptr inbounds %2[%0, %1, %0] : (!llvm.ptr, i16, i16, i16) -> !llvm.ptr, !llvm.array<6 x array<1 x i64>>
    %4 = llvm.mlir.addressof @global_constant4 : !llvm.ptr
    %5 = llvm.mlir.addressof @global_constant5 : !llvm.ptr
    %6 = llvm.mlir.constant(-1 : i16) : i16
    %7 = llvm.icmp "ne" %3, %4 : !llvm.ptr
    %8 = llvm.zext %7 : i1 to i16
    %9 = llvm.load %5 {alignment = 1 : i64} : !llvm.ptr -> !llvm.ptr
    %10 = llvm.load %9 {alignment = 1 : i64} : !llvm.ptr -> i16
    %11 = llvm.xor %10, %8  : i16
    %12 = llvm.xor %11, %6  : i16
    llvm.return %12 : i16
  }
}
