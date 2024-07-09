module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(vector<2xi32>)
  llvm.func @use1(!llvm.vec<? x 2 x  i63>)
  llvm.func @trunc_ctlz_zext_i16_i32(%arg0: i16) -> i16 {
    %0 = llvm.zext %arg0 : i16 to i32
    %1 = "llvm.intr.ctlz"(%0) <{is_zero_poison = false}> : (i32) -> i32
    %2 = llvm.trunc %1 : i32 to i16
    llvm.return %2 : i16
  }
  llvm.func @trunc_ctlz_zext_v2i8_v2i33(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.zext %arg0 : vector<2xi8> to vector<2xi33>
    %1 = "llvm.intr.ctlz"(%0) <{is_zero_poison = true}> : (vector<2xi33>) -> vector<2xi33>
    %2 = llvm.trunc %1 : vector<2xi33> to vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }
  llvm.func @trunc_ctlz_zext_nxv2i16_nxv2i64(%arg0: !llvm.vec<? x 2 x  i16>) -> !llvm.vec<? x 2 x  i16> {
    %0 = llvm.zext %arg0 : !llvm.vec<? x 2 x  i16> to !llvm.vec<? x 2 x  i64>
    %1 = "llvm.intr.ctlz"(%0) <{is_zero_poison = false}> : (!llvm.vec<? x 2 x  i64>) -> !llvm.vec<? x 2 x  i64>
    %2 = llvm.trunc %1 : !llvm.vec<? x 2 x  i64> to !llvm.vec<? x 2 x  i16>
    llvm.return %2 : !llvm.vec<? x 2 x  i16>
  }
  llvm.func @trunc_ctlz_zext_v2i17_v2i32_multiple_uses(%arg0: vector<2xi17>) -> vector<2xi17> {
    %0 = llvm.zext %arg0 : vector<2xi17> to vector<2xi32>
    %1 = "llvm.intr.ctlz"(%0) <{is_zero_poison = false}> : (vector<2xi32>) -> vector<2xi32>
    %2 = llvm.trunc %1 : vector<2xi32> to vector<2xi17>
    llvm.call @use(%1) : (vector<2xi32>) -> ()
    llvm.return %2 : vector<2xi17>
  }
  llvm.func @trunc_ctlz_zext_nxv2i16_nxv2i63_multiple_uses(%arg0: !llvm.vec<? x 2 x  i16>) -> !llvm.vec<? x 2 x  i16> {
    %0 = llvm.zext %arg0 : !llvm.vec<? x 2 x  i16> to !llvm.vec<? x 2 x  i63>
    %1 = "llvm.intr.ctlz"(%0) <{is_zero_poison = true}> : (!llvm.vec<? x 2 x  i63>) -> !llvm.vec<? x 2 x  i63>
    %2 = llvm.trunc %1 : !llvm.vec<? x 2 x  i63> to !llvm.vec<? x 2 x  i16>
    llvm.call @use1(%0) : (!llvm.vec<? x 2 x  i63>) -> ()
    llvm.return %2 : !llvm.vec<? x 2 x  i16>
  }
  llvm.func @trunc_ctlz_zext_i10_i32(%arg0: i10) -> i16 {
    %0 = llvm.zext %arg0 : i10 to i32
    %1 = "llvm.intr.ctlz"(%0) <{is_zero_poison = false}> : (i32) -> i32
    %2 = llvm.trunc %1 : i32 to i16
    llvm.return %2 : i16
  }
  llvm.func @trunc_ctlz_zext_i3_i34(%arg0: i3) -> i3 {
    %0 = llvm.zext %arg0 : i3 to i34
    %1 = "llvm.intr.ctlz"(%0) <{is_zero_poison = false}> : (i34) -> i34
    %2 = llvm.trunc %1 : i34 to i3
    llvm.return %2 : i3
  }
}
