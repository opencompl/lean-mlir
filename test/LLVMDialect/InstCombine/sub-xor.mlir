module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(i32)
  llvm.func @low_mask_nsw_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(63 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.sub %1, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @low_mask_nsw_nuw_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<31> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<63> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.and %arg0, %0  : vector<2xi32>
    %3 = llvm.sub %1, %2  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @arbitrary_mask_sub_i8(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(11 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.sub %1, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @arbitrary_mask_sub_high_bit_dont_care_i8(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-93 : i8) : i8
    %1 = llvm.mlir.constant(39 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.sub %1, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @arbitrary_mask_sub_nsw_high_bit_dont_care_i8(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-93 : i8) : i8
    %1 = llvm.mlir.constant(39 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.sub %1, %2 overflow<nsw>  : i8
    llvm.return %3 : i8
  }
  llvm.func @arbitrary_mask_sub_nuw_high_bit_dont_care_i8(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-93 : i8) : i8
    %1 = llvm.mlir.constant(39 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.sub %1, %2 overflow<nuw>  : i8
    llvm.return %3 : i8
  }
  llvm.func @arbitrary_mask_sub_v2i5(%arg0: vector<2xi5>) -> vector<2xi5> {
    %0 = llvm.mlir.constant(-8 : i5) : i5
    %1 = llvm.mlir.constant(dense<-8> : vector<2xi5>) : vector<2xi5>
    %2 = llvm.mlir.constant(-6 : i5) : i5
    %3 = llvm.mlir.constant(dense<-6> : vector<2xi5>) : vector<2xi5>
    %4 = llvm.and %arg0, %1  : vector<2xi5>
    %5 = llvm.sub %3, %4  : vector<2xi5>
    llvm.return %5 : vector<2xi5>
  }
  llvm.func @not_masked_sub_i8(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(11 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.sub %1, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @range_masked_sub(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32
    %2 = llvm.sub %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @xor_add(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.add %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @xor_add_extra_use(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.xor %2, %0  : i32
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.add %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @xor_add_splat(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<24> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<63> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<42> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.and %arg0, %0  : vector<2xi8>
    %4 = llvm.xor %3, %1  : vector<2xi8>
    %5 = llvm.add %4, %2  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }
  llvm.func @xor_add_splat_undef(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<24> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.undef : i8
    %2 = llvm.mlir.constant(63 : i8) : i8
    %3 = llvm.mlir.undef : vector<2xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi8>
    %8 = llvm.mlir.constant(dense<42> : vector<2xi8>) : vector<2xi8>
    %9 = llvm.and %arg0, %0  : vector<2xi8>
    %10 = llvm.xor %9, %7  : vector<2xi8>
    %11 = llvm.add %10, %8  : vector<2xi8>
    llvm.return %11 : vector<2xi8>
  }
  llvm.func @xor_dominating_cond(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(256 : i32) : i32
    %1 = llvm.mlir.constant(255 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = llvm.sub %1, %arg0  : i32
    llvm.return %3 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %arg0 : i32
  }
}
