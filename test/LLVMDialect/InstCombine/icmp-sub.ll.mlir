module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(i32)
  llvm.func @use_vec(vector<2xi8>)
  llvm.func @test_nuw_and_unsigned_pred(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(10 : i64) : i64
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.sub %0, %arg0 overflow<nuw>  : i64
    %3 = llvm.icmp "ult" %2, %1 : i64
    llvm.return %3 : i1
  }
  llvm.func @test_nsw_and_signed_pred(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.mlir.constant(10 : i64) : i64
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i64
    %3 = llvm.icmp "sgt" %2, %1 : i64
    llvm.return %3 : i1
  }
  llvm.func @test_nuw_nsw_and_unsigned_pred(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(10 : i64) : i64
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.sub %0, %arg0 overflow<nsw, nuw>  : i64
    %3 = llvm.icmp "ule" %2, %1 : i64
    llvm.return %3 : i1
  }
  llvm.func @test_nuw_nsw_and_signed_pred(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(10 : i64) : i64
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.sub %0, %arg0 overflow<nsw, nuw>  : i64
    %3 = llvm.icmp "slt" %2, %1 : i64
    llvm.return %3 : i1
  }
  llvm.func @test_negative_nuw_and_signed_pred(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(10 : i64) : i64
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.sub %0, %arg0 overflow<nuw>  : i64
    %3 = llvm.icmp "slt" %2, %1 : i64
    llvm.return %3 : i1
  }
  llvm.func @test_negative_nsw_and_unsigned_pred(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(10 : i64) : i64
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i64
    %3 = llvm.icmp "ult" %2, %1 : i64
    llvm.return %3 : i1
  }
  llvm.func @test_negative_combined_sub_unsigned_overflow(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(10 : i64) : i64
    %1 = llvm.mlir.constant(11 : i64) : i64
    %2 = llvm.sub %0, %arg0 overflow<nuw>  : i64
    %3 = llvm.icmp "ult" %2, %1 : i64
    llvm.return %3 : i1
  }
  llvm.func @test_negative_combined_sub_signed_overflow(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @test_sub_0_Y_eq_0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @test_sub_0_Y_ne_0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @test_sub_4_Y_ne_4(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @test_sub_127_Y_eq_127(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @test_sub_255_Y_eq_255(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @test_sub_255_Y_eq_255_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.sub %0, %arg0  : vector<2xi8>
    %2 = llvm.icmp "eq" %1, %0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @icmp_eq_sub_undef(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(dense<10> : vector<2xi32>) : vector<2xi32>
    %8 = llvm.sub %6, %arg0  : vector<2xi32>
    %9 = llvm.icmp "eq" %8, %7 : vector<2xi32>
    llvm.return %9 : vector<2xi1>
  }
  llvm.func @icmp_eq_sub_non_splat(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[15, 16]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<10> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sub %0, %arg0  : vector<2xi32>
    %3 = llvm.icmp "eq" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @icmp_eq_sub_undef2(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<15> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.constant(10 : i32) : i32
    %3 = llvm.mlir.undef : vector<2xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi32>
    %8 = llvm.sub %0, %arg0  : vector<2xi32>
    %9 = llvm.icmp "eq" %8, %7 : vector<2xi32>
    llvm.return %9 : vector<2xi1>
  }
  llvm.func @icmp_eq_sub_non_splat2(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<15> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[10, 11]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sub %0, %arg0  : vector<2xi32>
    %3 = llvm.icmp "eq" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @neg_sgt_42(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.icmp "sgt" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @neg_eq_43(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(43 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @neg_ne_44(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(44 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @neg_nsw_eq_45(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(45 : i32) : i32
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @neg_nsw_ne_46(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(46 : i32) : i32
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @subC_eq(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(43 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @subC_ne(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[-6, -128]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-44> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.sub %0, %arg0  : vector<2xi8>
    llvm.call @use_vec(%2) : (vector<2xi8>) -> ()
    %3 = llvm.icmp "ne" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @subC_nsw_eq(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-100 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @subC_nsw_ne(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483647 : i32) : i32
    %1 = llvm.mlir.constant(46 : i32) : i32
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @neg_slt_42(%arg0: i128) -> i1 {
    %0 = llvm.mlir.constant(0 : i128) : i128
    %1 = llvm.mlir.constant(42 : i128) : i128
    %2 = llvm.sub %0, %arg0  : i128
    %3 = llvm.icmp "slt" %2, %1 : i128
    llvm.return %3 : i1
  }
  llvm.func @neg_ugt_42_splat(%arg0: vector<2xi7>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i7) : i7
    %1 = llvm.mlir.constant(dense<0> : vector<2xi7>) : vector<2xi7>
    %2 = llvm.mlir.constant(42 : i7) : i7
    %3 = llvm.mlir.constant(dense<42> : vector<2xi7>) : vector<2xi7>
    %4 = llvm.sub %1, %arg0  : vector<2xi7>
    %5 = llvm.icmp "ugt" %4, %3 : vector<2xi7>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @neg_sgt_42_use(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.icmp "sgt" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @neg_slt_n1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.sub %0, %arg0  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @neg_slt_0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    %2 = llvm.icmp "slt" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @neg_slt_1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.sub %0, %arg0  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @neg_sgt_n1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.sub %0, %arg0  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @neg_sgt_0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    %2 = llvm.icmp "sgt" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @neg_sgt_1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.sub %0, %arg0  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @neg_nsw_slt_n1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @neg_nsw_slt_0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    %2 = llvm.icmp "slt" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @neg_nsw_slt_1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @neg_nsw_sgt_n1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @neg_nsw_sgt_0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    %2 = llvm.icmp "sgt" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @neg_nsw_sgt_1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @sub_eq_zero_use(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %arg0, %arg1  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @sub_ne_zero_use(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.sub %arg0, %arg1  : vector<2xi8>
    llvm.call @use_vec(%2) : (vector<2xi8>) -> ()
    %3 = llvm.icmp "eq" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @sub_eq_zero_select(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %arg0, %arg1  : i32
    llvm.store %1, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr
    %2 = llvm.icmp "eq" %1, %0 : i32
    %3 = llvm.select %2, %arg0, %arg1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @PR54558_reduced(%arg0: i32) {
    %0 = llvm.mlir.constant(43 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    llvm.br ^bb1(%arg0 : i32)
  ^bb1(%2: i32):  // 2 preds: ^bb0, ^bb1
    %3 = llvm.intr.umin(%2, %0)  : (i32, i32) -> i32
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.sub %2, %3  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    llvm.cond_br %5, ^bb2, ^bb1(%4 : i32)
  ^bb2:  // pred: ^bb1
    llvm.return
  }
  llvm.func @PR54558_reduced_more(%arg0: i32, %arg1: i32) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.br ^bb1(%arg0 : i32)
  ^bb1(%1: i32):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.sub %1, %arg1  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    llvm.cond_br %3, ^bb2, ^bb1(%2 : i32)
  ^bb2:  // pred: ^bb1
    llvm.return
  }
  llvm.func @PR60818_ne(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    %2 = llvm.icmp "ne" %1, %arg0 : i32
    llvm.return %2 : i1
  }
  llvm.func @PR60818_eq(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    %2 = llvm.icmp "eq" %1, %arg0 : i32
    llvm.return %2 : i1
  }
  llvm.func @PR60818_eq_commuted(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(43 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mul %arg0, %0  : i32
    %3 = llvm.sub %1, %2  : i32
    %4 = llvm.icmp "eq" %2, %3 : i32
    llvm.return %4 : i1
  }
  llvm.func @PR60818_ne_vector(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sub %1, %arg0  : vector<2xi32>
    %3 = llvm.icmp "ne" %arg0, %2 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @PR60818_eq_multi_use(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.icmp "eq" %1, %arg0 : i32
    llvm.return %2 : i1
  }
  llvm.func @PR60818_sgt(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    %2 = llvm.icmp "sgt" %1, %arg0 : i32
    llvm.return %2 : i1
  }
}
