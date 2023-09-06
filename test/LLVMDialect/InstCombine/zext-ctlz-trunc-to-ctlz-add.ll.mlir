module  {
  llvm.func @llvm.ctlz.i3(i3, i1) -> i3
  llvm.func @llvm.ctlz.i32(i32, i1) -> i32
  llvm.func @llvm.ctlz.i34(i34, i1) -> i34
  llvm.func @llvm.ctlz.v2i33(vector<2xi33>, i1) -> vector<2xi33>
  llvm.func @llvm.ctlz.v2i32(vector<2xi32>, i1) -> vector<2xi32>
  llvm.func @llvm.ctlz.nxv2i64(!llvm.vec<? x 2 x i64>, i1) -> !llvm.vec<? x 2 x i64>
  llvm.func @llvm.ctlz.nxv2i63(!llvm.vec<? x 2 x i63>, i1) -> !llvm.vec<? x 2 x i63>
  llvm.func @use(vector<2xi32>)
  llvm.func @use1(!llvm.vec<? x 2 x i63>)
  llvm.func @trunc_ctlz_zext_i16_i32(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.zext %arg0 : i16 to i32
    %2 = llvm.call @llvm.ctlz.i32(%1, %0) : (i32, i1) -> i32
    %3 = llvm.trunc %2 : i32 to i16
    llvm.return %3 : i16
  }
  llvm.func @trunc_ctlz_zext_v2i8_v2i33(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.zext %arg0 : vector<2xi8> to vector<2xi33>
    %2 = llvm.call @llvm.ctlz.v2i33(%1, %0) : (vector<2xi33>, i1) -> vector<2xi33>
    %3 = llvm.trunc %2 : vector<2xi33> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @trunc_ctlz_zext_nxv2i16_nxv2i64(%arg0: !llvm.vec<? x 2 x i16>) -> !llvm.vec<? x 2 x i16> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.zext %arg0 : !llvm.vec<? x 2 x i16> to !llvm.vec<? x 2 x i64>
    %2 = llvm.call @llvm.ctlz.nxv2i64(%1, %0) : (!llvm.vec<? x 2 x i64>, i1) -> !llvm.vec<? x 2 x i64>
    %3 = llvm.trunc %2 : !llvm.vec<? x 2 x i64> to !llvm.vec<? x 2 x i16>
    llvm.return %3 : !llvm.vec<? x 2 x i16>
  }
  llvm.func @trunc_ctlz_zext_v2i17_v2i32_multiple_uses(%arg0: vector<2xi17>) -> vector<2xi17> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.zext %arg0 : vector<2xi17> to vector<2xi32>
    %2 = llvm.call @llvm.ctlz.v2i32(%1, %0) : (vector<2xi32>, i1) -> vector<2xi32>
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi17>
    llvm.call @use(%2) : (vector<2xi32>) -> ()
    llvm.return %3 : vector<2xi17>
  }
  llvm.func @trunc_ctlz_zext_nxv2i16_nxv2i63_multiple_uses(%arg0: !llvm.vec<? x 2 x i16>) -> !llvm.vec<? x 2 x i16> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.zext %arg0 : !llvm.vec<? x 2 x i16> to !llvm.vec<? x 2 x i63>
    %2 = llvm.call @llvm.ctlz.nxv2i63(%1, %0) : (!llvm.vec<? x 2 x i63>, i1) -> !llvm.vec<? x 2 x i63>
    %3 = llvm.trunc %2 : !llvm.vec<? x 2 x i63> to !llvm.vec<? x 2 x i16>
    llvm.call @use1(%1) : (!llvm.vec<? x 2 x i63>) -> ()
    llvm.return %3 : !llvm.vec<? x 2 x i16>
  }
  llvm.func @trunc_ctlz_zext_i10_i32(%arg0: i10) -> i16 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.zext %arg0 : i10 to i32
    %2 = llvm.call @llvm.ctlz.i32(%1, %0) : (i32, i1) -> i32
    %3 = llvm.trunc %2 : i32 to i16
    llvm.return %3 : i16
  }
  llvm.func @trunc_ctlz_zext_i3_i34(%arg0: i3) -> i3 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.zext %arg0 : i3 to i34
    %2 = llvm.call @llvm.ctlz.i34(%1, %0) : (i34, i1) -> i34
    %3 = llvm.trunc %2 : i34 to i3
    llvm.return %3 : i3
  }
}
