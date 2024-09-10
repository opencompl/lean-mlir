module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(vector<4xi16>)
  llvm.func @test(%arg0: vector<16xi8>, %arg1: !llvm.ptr, %arg2: !llvm.ptr) {
    %0 = llvm.mlir.undef : vector<16xi8>
    %1 = llvm.shufflevector %arg0, %0 [12, 13, 14, 15] : vector<16xi8> 
    %2 = llvm.bitcast %1 : vector<4xi8> to f32
    %3 = llvm.bitcast %1 : vector<4xi8> to i32
    llvm.store %3, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %2, %arg2 {alignment = 4 : i64} : f32, !llvm.ptr
    llvm.return
  }
  llvm.func @splat_bitcast_operand(%arg0: vector<8xi8>) -> vector<4xi16> {
    %0 = llvm.mlir.undef : vector<8xi8>
    %1 = llvm.mlir.undef : vector<4xi16>
    %2 = llvm.shufflevector %arg0, %0 [1, 1, 1, 1, 1, 1, 1, 1] : vector<8xi8> 
    %3 = llvm.bitcast %2 : vector<8xi8> to vector<4xi16>
    %4 = llvm.shufflevector %3, %1 [0, 2, 1, 0] : vector<4xi16> 
    llvm.return %4 : vector<4xi16>
  }
  llvm.func @splat_bitcast_operand_uses(%arg0: vector<8xi8>) -> vector<4xi16> {
    %0 = llvm.mlir.undef : vector<8xi8>
    %1 = llvm.mlir.undef : vector<4xi16>
    %2 = llvm.shufflevector %arg0, %0 [1, 1, 1, 1, 1, 1, 1, 1] : vector<8xi8> 
    %3 = llvm.bitcast %2 : vector<8xi8> to vector<4xi16>
    llvm.call @use(%3) : (vector<4xi16>) -> ()
    %4 = llvm.shufflevector %3, %1 [0, 2, 1, 0] : vector<4xi16> 
    llvm.return %4 : vector<4xi16>
  }
  llvm.func @splat_bitcast_operand_same_size_src_elt(%arg0: vector<4xf32>) -> vector<4xi32> {
    %0 = llvm.mlir.undef : vector<4xf32>
    %1 = llvm.mlir.undef : vector<4xi32>
    %2 = llvm.shufflevector %arg0, %0 [2, 2, 2, 2] : vector<4xf32> 
    %3 = llvm.bitcast %2 : vector<4xf32> to vector<4xi32>
    %4 = llvm.shufflevector %3, %1 [0, 2, 1, 0] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @shuf_bitcast_operand(%arg0: vector<16xi8>) -> vector<4xi32> {
    %0 = llvm.mlir.undef : vector<16xi8>
    %1 = llvm.mlir.undef : vector<4xi32>
    %2 = llvm.shufflevector %arg0, %0 [12, 13, 14, 15, 8, 9, 10, 11, 4, 5, 6, 7, 0, 1, 2, 3] : vector<16xi8> 
    %3 = llvm.bitcast %2 : vector<16xi8> to vector<4xi32>
    %4 = llvm.shufflevector %3, %1 [3, 2, 1, 0] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @splat_bitcast_operand_change_type(%arg0: vector<8xi8>) -> vector<5xi16> {
    %0 = llvm.mlir.undef : vector<8xi8>
    %1 = llvm.mlir.undef : vector<4xi16>
    %2 = llvm.shufflevector %arg0, %0 [1, 1, 1, 1, 1, 1, 1, 1] : vector<8xi8> 
    %3 = llvm.bitcast %2 : vector<8xi8> to vector<4xi16>
    %4 = llvm.shufflevector %3, %1 [0, 2, 1, 0, 3] : vector<4xi16> 
    llvm.return %4 : vector<5xi16>
  }
  llvm.func @splat_bitcast_operand_wider_src_elt(%arg0: vector<2xi32>) -> vector<4xi16> {
    %0 = llvm.mlir.undef : vector<2xi32>
    %1 = llvm.mlir.undef : vector<4xi16>
    %2 = llvm.shufflevector %arg0, %0 [1, 1] : vector<2xi32> 
    %3 = llvm.bitcast %2 : vector<2xi32> to vector<4xi16>
    %4 = llvm.shufflevector %3, %1 [0, 1, 0, 1] : vector<4xi16> 
    llvm.return %4 : vector<4xi16>
  }
  llvm.func @splat_bitcast_operand_wider_src_elt_uses(%arg0: vector<2xi32>) -> vector<4xi16> {
    %0 = llvm.mlir.undef : vector<2xi32>
    %1 = llvm.mlir.undef : vector<4xi16>
    %2 = llvm.shufflevector %arg0, %0 [1, 1] : vector<2xi32> 
    %3 = llvm.bitcast %2 : vector<2xi32> to vector<4xi16>
    llvm.call @use(%3) : (vector<4xi16>) -> ()
    %4 = llvm.shufflevector %3, %1 [0, 1, 0, 1] : vector<4xi16> 
    llvm.return %4 : vector<4xi16>
  }
  llvm.func @shuf_bitcast_operand_wider_src(%arg0: vector<4xi32>) -> vector<16xi8> {
    %0 = llvm.mlir.undef : vector<4xi32>
    %1 = llvm.mlir.undef : vector<16xi8>
    %2 = llvm.shufflevector %arg0, %0 [3, 2, 1, 0] : vector<4xi32> 
    %3 = llvm.bitcast %2 : vector<4xi32> to vector<16xi8>
    %4 = llvm.shufflevector %3, %1 [12, 13, 14, 15, 8, 9, 10, 11, 4, 5, 6, 7, 0, 1, 2, 3] : vector<16xi8> 
    llvm.return %4 : vector<16xi8>
  }
  llvm.func @shuf_bitcast_operand_cannot_widen(%arg0: vector<4xi32>) -> vector<16xi8> {
    %0 = llvm.mlir.undef : vector<4xi32>
    %1 = llvm.mlir.undef : vector<16xi8>
    %2 = llvm.shufflevector %arg0, %0 [3, 2, 1, 0] : vector<4xi32> 
    %3 = llvm.bitcast %2 : vector<4xi32> to vector<16xi8>
    %4 = llvm.shufflevector %3, %1 [12, 13, 12, 13, 8, 9, 10, 11, 4, 5, 6, 7, 0, 1, 2, 3] : vector<16xi8> 
    llvm.return %4 : vector<16xi8>
  }
  llvm.func @shuf_bitcast_operand_cannot_widen_undef(%arg0: vector<4xi32>) -> vector<16xi8> {
    %0 = llvm.mlir.undef : vector<4xi32>
    %1 = llvm.mlir.undef : vector<16xi8>
    %2 = llvm.shufflevector %arg0, %0 [3, 2, 1, 0] : vector<4xi32> 
    %3 = llvm.bitcast %2 : vector<4xi32> to vector<16xi8>
    %4 = llvm.shufflevector %3, %1 [12, -1, 14, 15, 8, 9, 10, 11, 4, 5, 6, 7, 0, 1, 2, 3] : vector<16xi8> 
    llvm.return %4 : vector<16xi8>
  }
  llvm.func @shuf_bitcast_insert(%arg0: vector<2xi8>, %arg1: i8) -> vector<2xi4> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.undef : vector<4xi4>
    %2 = llvm.insertelement %arg1, %arg0[%0 : i32] : vector<2xi8>
    %3 = llvm.bitcast %2 : vector<2xi8> to vector<4xi4>
    %4 = llvm.shufflevector %3, %1 [0, 1] : vector<4xi4> 
    llvm.return %4 : vector<2xi4>
  }
  llvm.func @shuf_bitcast_inserti_use1(%arg0: vector<2xi8>, %arg1: i8, %arg2: !llvm.ptr) -> vector<2xi4> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.undef : vector<4xi4>
    %2 = llvm.insertelement %arg1, %arg0[%0 : i32] : vector<2xi8>
    llvm.store %2, %arg2 {alignment = 2 : i64} : vector<2xi8>, !llvm.ptr
    %3 = llvm.bitcast %2 : vector<2xi8> to vector<4xi4>
    %4 = llvm.shufflevector %3, %1 [0, 1] : vector<4xi4> 
    llvm.return %4 : vector<2xi4>
  }
  llvm.func @shuf_bitcast_insert_use2(%arg0: vector<2xi8>, %arg1: i8, %arg2: !llvm.ptr) -> vector<2xi4> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.undef : vector<4xi4>
    %2 = llvm.insertelement %arg1, %arg0[%0 : i32] : vector<2xi8>
    %3 = llvm.bitcast %2 : vector<2xi8> to vector<4xi4>
    llvm.store %3, %arg2 {alignment = 2 : i64} : vector<4xi4>, !llvm.ptr
    %4 = llvm.shufflevector %3, %1 [0, 1] : vector<4xi4> 
    llvm.return %4 : vector<2xi4>
  }
  llvm.func @shuf_bitcast_insert_wrong_index(%arg0: vector<2xi8>, %arg1: i8) -> vector<2xi4> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.undef : vector<4xi4>
    %2 = llvm.insertelement %arg1, %arg0[%0 : i32] : vector<2xi8>
    %3 = llvm.bitcast %2 : vector<2xi8> to vector<4xi4>
    %4 = llvm.shufflevector %3, %1 [0, 1] : vector<4xi4> 
    llvm.return %4 : vector<2xi4>
  }
  llvm.func @shuf_bitcast_wrong_size(%arg0: vector<2xi8>, %arg1: i8) -> vector<3xi4> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.undef : vector<4xi4>
    %2 = llvm.insertelement %arg1, %arg0[%0 : i32] : vector<2xi8>
    %3 = llvm.bitcast %2 : vector<2xi8> to vector<4xi4>
    %4 = llvm.shufflevector %3, %1 [0, 1, 2] : vector<4xi4> 
    llvm.return %4 : vector<3xi4>
  }
}
