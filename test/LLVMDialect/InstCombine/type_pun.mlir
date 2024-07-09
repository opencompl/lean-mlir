module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @type_pun_zeroth(%arg0: vector<16xi8>) -> i32 {
    %0 = llvm.mlir.undef : vector<16xi8>
    %1 = llvm.shufflevector %arg0, %0 [0, 1, 2, 3] : vector<16xi8> 
    %2 = llvm.bitcast %1 : vector<4xi8> to i32
    llvm.return %2 : i32
  }
  llvm.func @type_pun_first(%arg0: vector<16xi8>) -> i32 {
    %0 = llvm.mlir.undef : vector<16xi8>
    %1 = llvm.shufflevector %arg0, %0 [4, 5, 6, 7] : vector<16xi8> 
    %2 = llvm.bitcast %1 : vector<4xi8> to i32
    llvm.return %2 : i32
  }
  llvm.func @type_pun_misaligned(%arg0: vector<16xi8>) -> i32 {
    %0 = llvm.mlir.undef : vector<16xi8>
    %1 = llvm.shufflevector %arg0, %0 [6, 7, 8, 9] : vector<16xi8> 
    %2 = llvm.bitcast %1 : vector<4xi8> to i32
    llvm.return %2 : i32
  }
  llvm.func @type_pun_pointer(%arg0: vector<16xi8>) -> !llvm.ptr {
    %0 = llvm.mlir.undef : vector<16xi8>
    %1 = llvm.shufflevector %arg0, %0 [0, 1, 2, 3] : vector<16xi8> 
    %2 = llvm.bitcast %1 : vector<4xi8> to i32
    %3 = llvm.inttoptr %2 : i32 to !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @type_pun_float(%arg0: vector<16xi8>) -> f32 {
    %0 = llvm.mlir.undef : vector<16xi8>
    %1 = llvm.shufflevector %arg0, %0 [0, 1, 2, 3] : vector<16xi8> 
    %2 = llvm.bitcast %1 : vector<4xi8> to f32
    llvm.return %2 : f32
  }
  llvm.func @type_pun_double(%arg0: vector<16xi8>) -> f64 {
    %0 = llvm.mlir.undef : vector<16xi8>
    %1 = llvm.shufflevector %arg0, %0 [0, 1, 2, 3, 4, 5, 6, 7] : vector<16xi8> 
    %2 = llvm.bitcast %1 : vector<8xi8> to f64
    llvm.return %2 : f64
  }
  llvm.func @type_pun_float_i32(%arg0: vector<16xi8>) -> !llvm.struct<(f32, i32)> {
    %0 = llvm.mlir.undef : vector<16xi8>
    %1 = llvm.mlir.undef : !llvm.struct<(f32, i32)>
    %2 = llvm.shufflevector %arg0, %0 [0, 1, 2, 3] : vector<16xi8> 
    %3 = llvm.bitcast %2 : vector<4xi8> to f32
    %4 = llvm.bitcast %2 : vector<4xi8> to i32
    %5 = llvm.insertvalue %3, %1[0] : !llvm.struct<(f32, i32)> 
    %6 = llvm.insertvalue %4, %5[1] : !llvm.struct<(f32, i32)> 
    llvm.return %6 : !llvm.struct<(f32, i32)>
  }
  llvm.func @type_pun_i32_ctrl(%arg0: vector<16xi8>, %arg1: i1) -> i32 {
    %0 = llvm.mlir.undef : vector<16xi8>
    %1 = llvm.shufflevector %arg0, %0 [0, 1, 2, 3] : vector<16xi8> 
    llvm.cond_br %arg1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %2 = llvm.bitcast %1 : vector<4xi8> to i32
    llvm.br ^bb3(%2 : i32)
  ^bb2:  // pred: ^bb0
    %3 = llvm.bitcast %1 : vector<4xi8> to i32
    llvm.br ^bb3(%3 : i32)
  ^bb3(%4: i32):  // 2 preds: ^bb1, ^bb2
    llvm.return %4 : i32
  }
  llvm.func @type_pun_unhandled(%arg0: vector<16xi8>) -> i40 {
    %0 = llvm.mlir.undef : vector<16xi8>
    %1 = llvm.shufflevector %arg0, %0 [4, 5, 6, 7, 8] : vector<16xi8> 
    %2 = llvm.bitcast %1 : vector<5xi8> to i40
    llvm.return %2 : i40
  }
}
