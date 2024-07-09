module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @shrinkExtractElt_i64_to_i32_0(%arg0: vector<3xi64>) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.extractelement %arg0[%0 : i32] : vector<3xi64>
    %2 = llvm.trunc %1 : i64 to i32
    llvm.return %2 : i32
  }
  llvm.func @vscale_shrinkExtractElt_i64_to_i32_0(%arg0: !llvm.vec<? x 3 x  i64>) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.extractelement %arg0[%0 : i32] : !llvm.vec<? x 3 x  i64>
    %2 = llvm.trunc %1 : i64 to i32
    llvm.return %2 : i32
  }
  llvm.func @shrinkExtractElt_i64_to_i32_1(%arg0: vector<3xi64>) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.extractelement %arg0[%0 : i32] : vector<3xi64>
    %2 = llvm.trunc %1 : i64 to i32
    llvm.return %2 : i32
  }
  llvm.func @shrinkExtractElt_i64_to_i32_2(%arg0: vector<3xi64>) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.extractelement %arg0[%0 : i32] : vector<3xi64>
    %2 = llvm.trunc %1 : i64 to i32
    llvm.return %2 : i32
  }
  llvm.func @shrinkExtractElt_i64_to_i16_0(%arg0: vector<3xi64>) -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.extractelement %arg0[%0 : i16] : vector<3xi64>
    %2 = llvm.trunc %1 : i64 to i16
    llvm.return %2 : i16
  }
  llvm.func @shrinkExtractElt_i64_to_i16_1(%arg0: vector<3xi64>) -> i16 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.extractelement %arg0[%0 : i16] : vector<3xi64>
    %2 = llvm.trunc %1 : i64 to i16
    llvm.return %2 : i16
  }
  llvm.func @shrinkExtractElt_i64_to_i16_2(%arg0: vector<3xi64>) -> i16 {
    %0 = llvm.mlir.constant(2 : i16) : i16
    %1 = llvm.extractelement %arg0[%0 : i16] : vector<3xi64>
    %2 = llvm.trunc %1 : i64 to i16
    llvm.return %2 : i16
  }
  llvm.func @shrinkExtractElt_i33_to_11_2(%arg0: vector<3xi33>) -> i11 {
    %0 = llvm.mlir.constant(2 : i16) : i16
    %1 = llvm.extractelement %arg0[%0 : i16] : vector<3xi33>
    %2 = llvm.trunc %1 : i33 to i11
    llvm.return %2 : i11
  }
  llvm.func @shrinkExtractElt_i67_to_i13_2(%arg0: vector<3xi67>) -> i13 {
    %0 = llvm.mlir.constant(2 : i459) : i459
    %1 = llvm.extractelement %arg0[%0 : i459] : vector<3xi67>
    %2 = llvm.trunc %1 : i67 to i13
    llvm.return %2 : i13
  }
  llvm.func @shrinkExtractElt_i40_to_i30_1(%arg0: vector<3xi40>) -> i30 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.extractelement %arg0[%0 : i32] : vector<3xi40>
    %2 = llvm.trunc %1 : i40 to i30
    llvm.return %2 : i30
  }
  llvm.func @use(i64)
  llvm.func @shrinkExtractElt_i64_to_i16_2_extra_use(%arg0: vector<3xi64>) -> i16 {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.extractelement %arg0[%0 : i64] : vector<3xi64>
    llvm.call @use(%1) : (i64) -> ()
    %2 = llvm.trunc %1 : i64 to i16
    llvm.return %2 : i16
  }
  llvm.func @PR45314(%arg0: vector<4xi64>) -> vector<4xi64> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.poison : vector<8xi32>
    %2 = llvm.extractelement %arg0[%0 : i32] : vector<4xi64>
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.insertelement %3, %1[%0 : i32] : vector<8xi32>
    %5 = llvm.shufflevector %4, %1 [0, 0, 0, 0, 0, 0, 0, 0] : vector<8xi32> 
    %6 = llvm.bitcast %5 : vector<8xi32> to vector<4xi64>
    llvm.return %6 : vector<4xi64>
  }
}
