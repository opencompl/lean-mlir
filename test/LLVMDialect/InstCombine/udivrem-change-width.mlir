module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @b() {addr_space = 0 : i32} : !llvm.array<1 x i8>
  llvm.mlir.global external @g1() {addr_space = 0 : i32} : !llvm.array<1 x i8>
  llvm.mlir.global external @g2() {addr_space = 0 : i32} : !llvm.array<1 x i8>
  llvm.mlir.global external @g3() {addr_space = 0 : i32} : !llvm.array<1 x i8>
  llvm.mlir.global external @g4() {addr_space = 0 : i32} : !llvm.array<1 x i8>
  llvm.func @udiv_i8(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.zext %arg0 : i8 to i32
    %1 = llvm.zext %arg1 : i8 to i32
    %2 = llvm.udiv %0, %1  : i32
    %3 = llvm.trunc %2 : i32 to i8
    llvm.return %3 : i8
  }
  llvm.func @udiv_i8_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.zext %arg0 : vector<2xi8> to vector<2xi32>
    %1 = llvm.zext %arg1 : vector<2xi8> to vector<2xi32>
    %2 = llvm.udiv %0, %1  : vector<2xi32>
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @urem_i8(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.zext %arg0 : i8 to i32
    %1 = llvm.zext %arg1 : i8 to i32
    %2 = llvm.urem %0, %1  : i32
    %3 = llvm.trunc %2 : i32 to i8
    llvm.return %3 : i8
  }
  llvm.func @urem_i8_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.zext %arg0 : vector<2xi8> to vector<2xi32>
    %1 = llvm.zext %arg1 : vector<2xi8> to vector<2xi32>
    %2 = llvm.urem %0, %1  : vector<2xi32>
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @udiv_i32(%arg0: i8, %arg1: i8) -> i32 {
    %0 = llvm.zext %arg0 : i8 to i32
    %1 = llvm.zext %arg1 : i8 to i32
    %2 = llvm.udiv %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @udiv_i32_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi32> {
    %0 = llvm.zext %arg0 : vector<2xi8> to vector<2xi32>
    %1 = llvm.zext %arg1 : vector<2xi8> to vector<2xi32>
    %2 = llvm.udiv %0, %1  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @udiv_i32_multiuse(%arg0: i8, %arg1: i8) -> i32 {
    %0 = llvm.zext %arg0 : i8 to i32
    %1 = llvm.zext %arg1 : i8 to i32
    %2 = llvm.udiv %0, %1  : i32
    %3 = llvm.add %0, %1  : i32
    %4 = llvm.mul %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @udiv_illegal_type(%arg0: i9, %arg1: i9) -> i32 {
    %0 = llvm.zext %arg0 : i9 to i32
    %1 = llvm.zext %arg1 : i9 to i32
    %2 = llvm.udiv %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @urem_i32(%arg0: i8, %arg1: i8) -> i32 {
    %0 = llvm.zext %arg0 : i8 to i32
    %1 = llvm.zext %arg1 : i8 to i32
    %2 = llvm.urem %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @urem_i32_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi32> {
    %0 = llvm.zext %arg0 : vector<2xi8> to vector<2xi32>
    %1 = llvm.zext %arg1 : vector<2xi8> to vector<2xi32>
    %2 = llvm.urem %0, %1  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @urem_i32_multiuse(%arg0: i8, %arg1: i8) -> i32 {
    %0 = llvm.zext %arg0 : i8 to i32
    %1 = llvm.zext %arg1 : i8 to i32
    %2 = llvm.urem %0, %1  : i32
    %3 = llvm.add %0, %1  : i32
    %4 = llvm.mul %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @urem_illegal_type(%arg0: i9, %arg1: i9) -> i32 {
    %0 = llvm.zext %arg0 : i9 to i32
    %1 = llvm.zext %arg1 : i9 to i32
    %2 = llvm.urem %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @udiv_i32_c(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.udiv %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @udiv_i32_c_vec(%arg0: vector<2xi8>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[10, 17]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.zext %arg0 : vector<2xi8> to vector<2xi32>
    %2 = llvm.udiv %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @udiv_i32_c_multiuse(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.udiv %1, %0  : i32
    %3 = llvm.add %1, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @udiv_illegal_type_c(%arg0: i9) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.zext %arg0 : i9 to i32
    %2 = llvm.udiv %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @urem_i32_c(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.urem %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @urem_i32_c_vec(%arg0: vector<2xi8>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[10, 17]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.zext %arg0 : vector<2xi8> to vector<2xi32>
    %2 = llvm.urem %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @urem_i32_c_multiuse(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.urem %1, %0  : i32
    %3 = llvm.add %1, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @urem_illegal_type_c(%arg0: i9) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.zext %arg0 : i9 to i32
    %2 = llvm.urem %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @udiv_c_i32(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.udiv %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @urem_c_i32(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.urem %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @udiv_constexpr(%arg0: i8) -> i32 {
    %0 = llvm.mlir.addressof @b : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i8
    %2 = llvm.zext %arg0 : i8 to i32
    %3 = llvm.zext %1 : i8 to i32
    %4 = llvm.udiv %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @udiv_const_constexpr(%arg0: i8) -> i32 {
    %0 = llvm.mlir.addressof @g1 : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i8
    %2 = llvm.mlir.constant(42 : i32) : i32
    %3 = llvm.zext %1 : i8 to i32
    %4 = llvm.udiv %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @urem_const_constexpr(%arg0: i8) -> i32 {
    %0 = llvm.mlir.addressof @g2 : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i8
    %2 = llvm.mlir.constant(42 : i32) : i32
    %3 = llvm.zext %1 : i8 to i32
    %4 = llvm.urem %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @udiv_constexpr_const(%arg0: i8) -> i32 {
    %0 = llvm.mlir.addressof @g3 : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i8
    %2 = llvm.mlir.constant(42 : i32) : i32
    %3 = llvm.zext %1 : i8 to i32
    %4 = llvm.udiv %3, %2  : i32
    llvm.return %4 : i32
  }
  llvm.func @urem_constexpr_const(%arg0: i8) -> i32 {
    %0 = llvm.mlir.addressof @g4 : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i8
    %2 = llvm.mlir.constant(42 : i32) : i32
    %3 = llvm.zext %1 : i8 to i32
    %4 = llvm.urem %3, %2  : i32
    llvm.return %4 : i32
  }
}
