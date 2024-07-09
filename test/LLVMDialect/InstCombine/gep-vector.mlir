module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @block(dense<0> : tensor<64x8192xi8>) {addr_space = 0 : i32, alignment = 1 : i64} : !llvm.array<64 x array<8192 x i8>>
  llvm.func @vectorindex1() -> !llvm.vec<2 x ptr> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<8192xi8>) : !llvm.array<8192 x i8>
    %2 = llvm.mlir.constant(dense<0> : tensor<64x8192xi8>) : !llvm.array<64 x array<8192 x i8>>
    %3 = llvm.mlir.addressof @block : !llvm.ptr
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.mlir.constant(dense<[0, 1]> : vector<2xi64>) : vector<2xi64>
    %6 = llvm.mlir.constant(8192 : i64) : i64
    %7 = llvm.getelementptr inbounds %3[%4, %5, %6] : (!llvm.ptr, i64, vector<2xi64>, i64) -> !llvm.vec<2 x ptr>, !llvm.array<64 x array<8192 x i8>>
    llvm.return %7 : !llvm.vec<2 x ptr>
  }
  llvm.func @vectorindex2() -> !llvm.vec<2 x ptr> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<8192xi8>) : !llvm.array<8192 x i8>
    %2 = llvm.mlir.constant(dense<0> : tensor<64x8192xi8>) : !llvm.array<64 x array<8192 x i8>>
    %3 = llvm.mlir.addressof @block : !llvm.ptr
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.mlir.constant(1 : i64) : i64
    %6 = llvm.mlir.constant(dense<[8191, 8193]> : vector<2xi64>) : vector<2xi64>
    %7 = llvm.getelementptr inbounds %3[%4, %5, %6] : (!llvm.ptr, i64, i64, vector<2xi64>) -> !llvm.vec<2 x ptr>, !llvm.array<64 x array<8192 x i8>>
    llvm.return %7 : !llvm.vec<2 x ptr>
  }
  llvm.func @vectorindex3() -> !llvm.vec<2 x ptr> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<8192xi8>) : !llvm.array<8192 x i8>
    %2 = llvm.mlir.constant(dense<0> : tensor<64x8192xi8>) : !llvm.array<64 x array<8192 x i8>>
    %3 = llvm.mlir.addressof @block : !llvm.ptr
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.mlir.constant(dense<[0, 1]> : vector<2xi64>) : vector<2xi64>
    %6 = llvm.mlir.constant(dense<[8191, 8193]> : vector<2xi64>) : vector<2xi64>
    %7 = llvm.getelementptr inbounds %3[%4, %5, %6] : (!llvm.ptr, i64, vector<2xi64>, vector<2xi64>) -> !llvm.vec<2 x ptr>, !llvm.array<64 x array<8192 x i8>>
    llvm.return %7 : !llvm.vec<2 x ptr>
  }
  llvm.func @bitcast_vec_to_array_gep(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.ptr {
    %0 = llvm.getelementptr %arg0[%arg1, %arg2] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<7 x i32>
    llvm.return %0 : !llvm.ptr
  }
  llvm.func @bitcast_array_to_vec_gep(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.ptr {
    %0 = llvm.getelementptr inbounds %arg0[%arg1, %arg2] : (!llvm.ptr, i64, i64) -> !llvm.ptr, vector<3xi32>
    llvm.return %0 : !llvm.ptr
  }
  llvm.func @bitcast_vec_to_array_gep_matching_alloc_size(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.ptr {
    %0 = llvm.getelementptr %arg0[%arg1, %arg2] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.return %0 : !llvm.ptr
  }
  llvm.func @bitcast_array_to_vec_gep_matching_alloc_size(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.ptr {
    %0 = llvm.getelementptr inbounds %arg0[%arg1, %arg2] : (!llvm.ptr, i64, i64) -> !llvm.ptr, vector<4xi32>
    llvm.return %0 : !llvm.ptr
  }
  llvm.func @bitcast_vec_to_array_addrspace(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.ptr<3> {
    %0 = llvm.addrspacecast %arg0 : !llvm.ptr to !llvm.ptr<3>
    %1 = llvm.getelementptr %0[%arg1, %arg2] : (!llvm.ptr<3>, i64, i64) -> !llvm.ptr<3>, !llvm.array<7 x i32>
    llvm.return %1 : !llvm.ptr<3>
  }
  llvm.func @inbounds_bitcast_vec_to_array_addrspace(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.ptr<3> {
    %0 = llvm.addrspacecast %arg0 : !llvm.ptr to !llvm.ptr<3>
    %1 = llvm.getelementptr inbounds %0[%arg1, %arg2] : (!llvm.ptr<3>, i64, i64) -> !llvm.ptr<3>, !llvm.array<7 x i32>
    llvm.return %1 : !llvm.ptr<3>
  }
  llvm.func @bitcast_vec_to_array_addrspace_matching_alloc_size(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.ptr<3> {
    %0 = llvm.addrspacecast %arg0 : !llvm.ptr to !llvm.ptr<3>
    %1 = llvm.getelementptr %0[%arg1, %arg2] : (!llvm.ptr<3>, i64, i64) -> !llvm.ptr<3>, !llvm.array<4 x i32>
    llvm.return %1 : !llvm.ptr<3>
  }
  llvm.func @inbounds_bitcast_vec_to_array_addrspace_matching_alloc_size(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.ptr<3> {
    %0 = llvm.addrspacecast %arg0 : !llvm.ptr to !llvm.ptr<3>
    %1 = llvm.getelementptr inbounds %0[%arg1, %arg2] : (!llvm.ptr<3>, i64, i64) -> !llvm.ptr<3>, !llvm.array<4 x i32>
    llvm.return %1 : !llvm.ptr<3>
  }
  llvm.func @test_accumulate_constant_offset_vscale_nonzero(%arg0: !llvm.vec<? x 16 x  i1>, %arg1: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(4 : i64) : i64
    %2 = llvm.getelementptr %arg1[%0, %1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.vec<? x 16 x  i8>
    llvm.return %2 : !llvm.ptr
  }
  llvm.func @test_accumulate_constant_offset_vscale_zero(%arg0: !llvm.vec<? x 16 x  i1>, %arg1: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(4 : i64) : i64
    %2 = llvm.getelementptr %arg1[%0, %1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.vec<? x 16 x  i8>
    llvm.return %2 : !llvm.ptr
  }
}
