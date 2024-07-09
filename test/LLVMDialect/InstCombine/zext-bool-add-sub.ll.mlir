module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @a(%arg0: i1 {llvm.zeroext}, %arg1: i1 {llvm.zeroext}) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.zext %arg0 : i1 to i32
    %3 = llvm.zext %arg1 : i1 to i32
    %4 = llvm.sub %0, %3  : i32
    %5 = llvm.add %2, %1  : i32
    %6 = llvm.add %5, %4  : i32
    llvm.return %6 : i32
  }
  llvm.func @PR30273_select(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.zext %arg0 : i1 to i32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    %4 = llvm.select %arg1, %3, %2 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @PR30273_zext_add(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.zext %arg0 : i1 to i32
    %1 = llvm.zext %arg1 : i1 to i32
    %2 = llvm.add %1, %0 overflow<nsw, nuw>  : i32
    llvm.return %2 : i32
  }
  llvm.func @PR30273_three_bools(%arg0: i1, %arg1: i1, %arg2: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.add %1, %0 overflow<nsw>  : i32
    %3 = llvm.select %arg1, %2, %1 : i1, i32
    %4 = llvm.add %3, %0 overflow<nsw>  : i32
    %5 = llvm.select %arg2, %4, %3 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @zext_add_scalar(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.add %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @zext_add_vec_splat(%arg0: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.zext %arg0 : vector<2xi1> to vector<2xi32>
    %2 = llvm.add %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @zext_add_vec(%arg0: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[42, 23]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.zext %arg0 : vector<2xi1> to vector<2xi32>
    %2 = llvm.add %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @use(i64)
  llvm.func @zext_negate(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.sub %0, %1  : i64
    llvm.return %2 : i64
  }
  llvm.func @zext_negate_extra_use(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.sub %0, %1  : i64
    llvm.call @use(%1) : (i64) -> ()
    llvm.return %2 : i64
  }
  llvm.func @zext_negate_vec(%arg0: vector<2xi1>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.zext %arg0 : vector<2xi1> to vector<2xi64>
    %3 = llvm.sub %1, %2  : vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }
  llvm.func @zext_negate_vec_poison_elt(%arg0: vector<2xi1>) -> vector<2xi64> {
    %0 = llvm.mlir.poison : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.undef : vector<2xi64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi64>
    %7 = llvm.zext %arg0 : vector<2xi1> to vector<2xi64>
    %8 = llvm.sub %6, %7  : vector<2xi64>
    llvm.return %8 : vector<2xi64>
  }
  llvm.func @zext_sub_const(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant(42 : i64) : i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.sub %0, %1  : i64
    llvm.return %2 : i64
  }
  llvm.func @zext_sub_const_extra_use(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant(42 : i64) : i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.sub %0, %1  : i64
    llvm.call @use(%1) : (i64) -> ()
    llvm.return %2 : i64
  }
  llvm.func @zext_sub_const_vec(%arg0: vector<2xi1>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[42, 3]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.zext %arg0 : vector<2xi1> to vector<2xi64>
    %2 = llvm.sub %0, %1  : vector<2xi64>
    llvm.return %2 : vector<2xi64>
  }
  llvm.func @zext_sub_const_vec_poison_elt(%arg0: vector<2xi1>) -> vector<2xi64> {
    %0 = llvm.mlir.poison : i64
    %1 = llvm.mlir.constant(42 : i64) : i64
    %2 = llvm.mlir.undef : vector<2xi64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi64>
    %7 = llvm.zext %arg0 : vector<2xi1> to vector<2xi64>
    %8 = llvm.sub %6, %7  : vector<2xi64>
    llvm.return %8 : vector<2xi64>
  }
  llvm.func @sext_negate(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.sub %0, %1  : i64
    llvm.return %2 : i64
  }
  llvm.func @sext_negate_extra_use(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.sub %0, %1  : i64
    llvm.call @use(%1) : (i64) -> ()
    llvm.return %2 : i64
  }
  llvm.func @sext_negate_vec(%arg0: vector<2xi1>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.sext %arg0 : vector<2xi1> to vector<2xi64>
    %3 = llvm.sub %1, %2  : vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }
  llvm.func @sext_negate_vec_poison_elt(%arg0: vector<2xi1>) -> vector<2xi64> {
    %0 = llvm.mlir.poison : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.undef : vector<2xi64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi64>
    %7 = llvm.sext %arg0 : vector<2xi1> to vector<2xi64>
    %8 = llvm.sub %6, %7  : vector<2xi64>
    llvm.return %8 : vector<2xi64>
  }
  llvm.func @sext_sub_const(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant(42 : i64) : i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.sub %0, %1  : i64
    llvm.return %2 : i64
  }
  llvm.func @sext_sub_const_extra_use(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant(42 : i64) : i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.sub %0, %1  : i64
    llvm.call @use(%1) : (i64) -> ()
    llvm.return %2 : i64
  }
  llvm.func @sext_sub_const_vec(%arg0: vector<2xi1>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[42, 3]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.sext %arg0 : vector<2xi1> to vector<2xi64>
    %2 = llvm.sub %0, %1  : vector<2xi64>
    llvm.return %2 : vector<2xi64>
  }
  llvm.func @sext_sub_const_vec_poison_elt(%arg0: vector<2xi1>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(42 : i64) : i64
    %1 = llvm.mlir.poison : i64
    %2 = llvm.mlir.undef : vector<2xi64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi64>
    %7 = llvm.sext %arg0 : vector<2xi1> to vector<2xi64>
    %8 = llvm.sub %6, %7  : vector<2xi64>
    llvm.return %8 : vector<2xi64>
  }
  llvm.func @sext_sub(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.sext %arg1 : i1 to i8
    %1 = llvm.sub %arg0, %0  : i8
    llvm.return %1 : i8
  }
  llvm.func @sext_sub_vec(%arg0: vector<2xi8>, %arg1: vector<2xi1>) -> vector<2xi8> {
    %0 = llvm.sext %arg1 : vector<2xi1> to vector<2xi8>
    %1 = llvm.sub %arg0, %0  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }
  llvm.func @sext_sub_vec_nsw(%arg0: vector<2xi8>, %arg1: vector<2xi1>) -> vector<2xi8> {
    %0 = llvm.sext %arg1 : vector<2xi1> to vector<2xi8>
    %1 = llvm.sub %arg0, %0 overflow<nsw>  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }
  llvm.func @sext_sub_nuw(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.sext %arg1 : i1 to i8
    %1 = llvm.sub %arg0, %0 overflow<nuw>  : i8
    llvm.return %1 : i8
  }
  llvm.func @sextbool_add(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.sext %arg0 : i1 to i32
    %1 = llvm.add %0, %arg1  : i32
    llvm.return %1 : i32
  }
  llvm.func @sextbool_add_commute(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.urem %arg1, %0  : i32
    %2 = llvm.sext %arg0 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @use32(i32)
  llvm.func @sextbool_add_uses(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.sext %arg0 : i1 to i32
    llvm.call @use32(%0) : (i32) -> ()
    %1 = llvm.add %0, %arg1  : i32
    llvm.return %1 : i32
  }
  llvm.func @sextbool_add_vector(%arg0: vector<4xi1>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.sext %arg0 : vector<4xi1> to vector<4xi32>
    %1 = llvm.add %arg1, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }
  llvm.func @zextbool_sub(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.zext %arg0 : i1 to i32
    %1 = llvm.sub %0, %arg1  : i32
    llvm.return %1 : i32
  }
  llvm.func @zextbool_sub_uses(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.zext %arg0 : i1 to i32
    llvm.call @use32(%0) : (i32) -> ()
    %1 = llvm.sub %arg1, %0  : i32
    llvm.return %1 : i32
  }
  llvm.func @zextbool_sub_vector(%arg0: vector<4xi1>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.zext %arg0 : vector<4xi1> to vector<4xi32>
    %1 = llvm.sub %arg1, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }
}
