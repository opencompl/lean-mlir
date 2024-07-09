module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @b() {addr_space = 0 : i32} : !llvm.array<72 x i32>
  llvm.mlir.global external @c() {addr_space = 0 : i32} : i32
  llvm.func @add_select_zext(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.select %arg0, %0, %1 : i1, i64
    %3 = llvm.zext %arg0 : i1 to i64
    %4 = llvm.add %2, %3  : i64
    llvm.return %4 : i64
  }
  llvm.func @add_select_sext(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.select %arg0, %0, %1 : i1, i64
    %3 = llvm.sext %arg0 : i1 to i64
    %4 = llvm.add %2, %3  : i64
    llvm.return %4 : i64
  }
  llvm.func @add_select_not_zext(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.select %arg0, %0, %1 : i1, i64
    %4 = llvm.xor %arg0, %2  : i1
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.add %3, %5  : i64
    llvm.return %6 : i64
  }
  llvm.func @add_select_not_sext(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.select %arg0, %0, %1 : i1, i64
    %4 = llvm.xor %arg0, %2  : i1
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.add %3, %5  : i64
    llvm.return %6 : i64
  }
  llvm.func @sub_select_sext(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.select %arg0, %0, %arg1 : i1, i64
    %2 = llvm.sext %arg0 : i1 to i64
    %3 = llvm.sub %1, %2  : i64
    llvm.return %3 : i64
  }
  llvm.func @sub_select_not_zext(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg0, %arg1, %0 : i1, i64
    %3 = llvm.xor %arg0, %1  : i1
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.sub %2, %4  : i64
    llvm.return %5 : i64
  }
  llvm.func @sub_select_not_sext(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg0, %arg1, %0 : i1, i64
    %3 = llvm.xor %arg0, %1  : i1
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.sub %2, %4  : i64
    llvm.return %5 : i64
  }
  llvm.func @mul_select_zext(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.select %arg0, %arg1, %0 : i1, i64
    %2 = llvm.zext %arg0 : i1 to i64
    %3 = llvm.mul %1, %2  : i64
    llvm.return %3 : i64
  }
  llvm.func @mul_select_sext(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.select %arg0, %0, %1 : i1, i64
    %3 = llvm.sext %arg0 : i1 to i64
    %4 = llvm.mul %2, %3  : i64
    llvm.return %4 : i64
  }
  llvm.func @select_zext_different_condition(%arg0: i1, %arg1: i1) -> i64 {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.select %arg0, %0, %1 : i1, i64
    %3 = llvm.zext %arg1 : i1 to i64
    %4 = llvm.add %2, %3  : i64
    llvm.return %4 : i64
  }
  llvm.func @vector_test(%arg0: i1) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<64> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.mlir.undef : vector<2xi64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.select %arg0, %0, %1 : i1, vector<2xi64>
    %6 = llvm.zext %arg0 : i1 to i64
    %7 = llvm.insertelement %6, %2[%3 : i32] : vector<2xi64>
    %8 = llvm.insertelement %6, %7[%4 : i32] : vector<2xi64>
    %9 = llvm.add %5, %8  : vector<2xi64>
    llvm.return %9 : vector<2xi64>
  }
  llvm.func @multiuse_add(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.select %arg0, %0, %1 : i1, i64
    %3 = llvm.zext %arg0 : i1 to i64
    %4 = llvm.add %2, %3  : i64
    %5 = llvm.add %4, %1  : i64
    llvm.return %5 : i64
  }
  llvm.func @multiuse_select(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.select %arg0, %0, %1 : i1, i64
    %3 = llvm.zext %arg0 : i1 to i64
    %4 = llvm.sub %2, %3  : i64
    %5 = llvm.mul %2, %4  : i64
    llvm.return %5 : i64
  }
  llvm.func @select_non_const_sides(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %2 = llvm.sub %1, %0  : i64
    llvm.return %2 : i64
  }
  llvm.func @sub_select_sext_op_swapped_non_const_args(%arg0: i1, %arg1: i6, %arg2: i6) -> i6 {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i6
    %1 = llvm.sext %arg0 : i1 to i6
    %2 = llvm.sub %1, %0  : i6
    llvm.return %2 : i6
  }
  llvm.func @sub_select_zext_op_swapped_non_const_args(%arg0: i1, %arg1: i6, %arg2: i6) -> i6 {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i6
    %1 = llvm.zext %arg0 : i1 to i6
    %2 = llvm.sub %1, %0  : i6
    llvm.return %2 : i6
  }
  llvm.func @vectorized_add(%arg0: vector<2xi1>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.zext %arg0 : vector<2xi1> to vector<2xi8>
    %2 = llvm.select %arg0, %arg1, %0 : vector<2xi1>, vector<2xi8>
    %3 = llvm.add %2, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @pr64669(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(25 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.addressof @b : !llvm.ptr
    %3 = llvm.getelementptr inbounds %2[%1, %0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<72 x i32>
    %4 = llvm.mlir.addressof @c : !llvm.ptr
    %5 = llvm.icmp "ne" %3, %4 : !llvm.ptr
    %6 = llvm.select %5, %arg0, %1 : i1, i64
    %7 = llvm.zext %5 : i1 to i64
    %8 = llvm.add %6, %7 overflow<nsw>  : i64
    llvm.return %8 : i64
  }
}
