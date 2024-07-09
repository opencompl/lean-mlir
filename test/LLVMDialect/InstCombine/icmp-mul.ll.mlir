module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global extern_weak @g() {addr_space = 0 : i32} : i32
  llvm.func @use(i8)
  llvm.func @usev2xi8(vector<2xi8>)
  llvm.func @squared_nsw_eq0(%arg0: i5) -> i1 {
    %0 = llvm.mlir.constant(0 : i5) : i5
    %1 = llvm.mul %arg0, %arg0 overflow<nsw>  : i5
    %2 = llvm.icmp "eq" %1, %0 : i5
    llvm.return %2 : i1
  }
  llvm.func @squared_nuw_eq0(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mul %arg0, %arg0 overflow<nuw>  : vector<2xi8>
    %3 = llvm.icmp "eq" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @squared_nsw_nuw_ne0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mul %arg0, %arg0 overflow<nsw, nuw>  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @squared_eq0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mul %arg0, %arg0  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @mul_nsw_eq0(%arg0: i5, %arg1: i5) -> i1 {
    %0 = llvm.mlir.constant(0 : i5) : i5
    %1 = llvm.mul %arg0, %arg1 overflow<nsw>  : i5
    %2 = llvm.icmp "eq" %1, %0 : i5
    llvm.return %2 : i1
  }
  llvm.func @squared_nsw_eq1(%arg0: i5) -> i1 {
    %0 = llvm.mlir.constant(1 : i5) : i5
    %1 = llvm.mul %arg0, %arg0 overflow<nsw>  : i5
    %2 = llvm.icmp "eq" %1, %0 : i5
    llvm.return %2 : i1
  }
  llvm.func @squared_nsw_sgt0(%arg0: i5) -> i1 {
    %0 = llvm.mlir.constant(0 : i5) : i5
    %1 = llvm.mul %arg0, %arg0 overflow<nsw>  : i5
    %2 = llvm.icmp "sgt" %1, %0 : i5
    llvm.return %2 : i1
  }
  llvm.func @slt_positive_multip_rem_zero(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(21 : i8) : i8
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @slt_negative_multip_rem_zero(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-7 : i8) : i8
    %1 = llvm.mlir.constant(21 : i8) : i8
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @slt_positive_multip_rem_nz(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(21 : i8) : i8
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @ult_rem_zero(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(21 : i8) : i8
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @ult_rem_zero_nsw(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(21 : i8) : i8
    %2 = llvm.mul %arg0, %0 overflow<nsw, nuw>  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @ult_rem_nz(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(21 : i8) : i8
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @ult_rem_nz_nsw(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(21 : i8) : i8
    %2 = llvm.mul %arg0, %0 overflow<nsw, nuw>  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @sgt_positive_multip_rem_zero(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(21 : i8) : i8
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @sgt_negative_multip_rem_zero(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-7 : i8) : i8
    %1 = llvm.mlir.constant(21 : i8) : i8
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @sgt_positive_multip_rem_nz(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(21 : i8) : i8
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @ugt_rem_zero(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(21 : i8) : i8
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : i8
    %3 = llvm.icmp "ugt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @ugt_rem_zero_nsw(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(21 : i8) : i8
    %2 = llvm.mul %arg0, %0 overflow<nsw, nuw>  : i8
    %3 = llvm.icmp "ugt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @ugt_rem_nz(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(21 : i8) : i8
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : i8
    %3 = llvm.icmp "ugt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @ugt_rem_nz_nsw(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(21 : i8) : i8
    %2 = llvm.mul %arg0, %0 overflow<nsw, nuw>  : i8
    %3 = llvm.icmp "ugt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @eq_nsw_rem_zero(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-5 : i8) : i8
    %1 = llvm.mlir.constant(20 : i8) : i8
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @ne_nsw_rem_zero(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-30> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : vector<2xi8>
    %3 = llvm.icmp "ne" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @ne_nsw_rem_zero_undef1(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.undef : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(dense<-30> : vector<2xi8>) : vector<2xi8>
    %8 = llvm.mul %arg0, %6 overflow<nsw>  : vector<2xi8>
    %9 = llvm.icmp "ne" %8, %7 : vector<2xi8>
    llvm.return %9 : vector<2xi1>
  }
  llvm.func @ne_nsw_rem_zero_undef2(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.undef : i8
    %2 = llvm.mlir.constant(-30 : i8) : i8
    %3 = llvm.mlir.undef : vector<2xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi8>
    %8 = llvm.mul %arg0, %0 overflow<nsw>  : vector<2xi8>
    %9 = llvm.icmp "ne" %8, %7 : vector<2xi8>
    llvm.return %9 : vector<2xi1>
  }
  llvm.func @eq_nsw_rem_zero_uses(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-5 : i8) : i8
    %1 = llvm.mlir.constant(20 : i8) : i8
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @eq_nsw_rem_nz(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(-11 : i8) : i8
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @ne_nsw_rem_nz(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(-126 : i8) : i8
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @eq_nuw_rem_zero(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<20> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : vector<2xi8>
    %3 = llvm.icmp "eq" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @eq_nuw_rem_zero_undef1(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.undef : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(dense<20> : vector<2xi8>) : vector<2xi8>
    %8 = llvm.mul %arg0, %6 overflow<nuw>  : vector<2xi8>
    %9 = llvm.icmp "eq" %8, %7 : vector<2xi8>
    llvm.return %9 : vector<2xi1>
  }
  llvm.func @eq_nuw_rem_zero_undef2(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(20 : i8) : i8
    %2 = llvm.mlir.undef : i8
    %3 = llvm.mlir.undef : vector<2xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi8>
    %8 = llvm.mul %arg0, %0 overflow<nuw>  : vector<2xi8>
    %9 = llvm.icmp "eq" %8, %7 : vector<2xi8>
    llvm.return %9 : vector<2xi1>
  }
  llvm.func @ne_nuw_rem_zero(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(-126 : i8) : i8
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @ne_nuw_rem_zero_uses(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(-126 : i8) : i8
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @eq_nuw_rem_nz(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-5 : i8) : i8
    %1 = llvm.mlir.constant(20 : i8) : i8
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @ne_nuw_rem_nz(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(-30 : i8) : i8
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @sgt_positive_multip_rem_zero_nonsw(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(21 : i8) : i8
    %2 = llvm.mul %arg0, %0  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @ult_multip_rem_zero_nonsw(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(21 : i8) : i8
    %2 = llvm.mul %arg0, %0  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @ugt_rem_zero_nonuw(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(21 : i8) : i8
    %2 = llvm.mul %arg0, %0  : i8
    %3 = llvm.icmp "ugt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @sgt_minnum(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @ule_bignum(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mul %arg0, %0  : i8
    %3 = llvm.icmp "ule" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @sgt_mulzero(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(21 : i8) : i8
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @eq_rem_zero_nonuw(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(20 : i8) : i8
    %2 = llvm.mul %arg0, %0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @ne_rem_zero_nonuw(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(30 : i8) : i8
    %2 = llvm.mul %arg0, %0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @mul_constant_eq(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.icmp "eq" %1, %2 : i32
    llvm.return %3 : i1
  }
  llvm.func @mul_constant_ne_splat(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mul %arg0, %0  : vector<2xi32>
    %2 = llvm.mul %arg1, %0  : vector<2xi32>
    %3 = llvm.icmp "ne" %1, %2 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @mul_constant_ne_extra_use1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mul %arg0, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.mul %arg1, %0  : i8
    %3 = llvm.icmp "ne" %1, %2 : i8
    llvm.return %3 : i1
  }
  llvm.func @mul_constant_eq_extra_use2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mul %arg0, %0  : i8
    %2 = llvm.mul %arg1, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "eq" %1, %2 : i8
    llvm.return %3 : i1
  }
  llvm.func @mul_constant_ne_extra_use3(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mul %arg0, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.mul %arg1, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %1, %2 : i8
    llvm.return %3 : i1
  }
  llvm.func @mul_constant_eq_nsw(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.mul %arg0, %0 overflow<nsw>  : i32
    %2 = llvm.mul %arg1, %0 overflow<nsw>  : i32
    %3 = llvm.icmp "eq" %1, %2 : i32
    llvm.return %3 : i1
  }
  llvm.func @mul_constant_ne_nsw_splat(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<12> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mul %arg0, %0 overflow<nsw>  : vector<2xi32>
    %2 = llvm.mul %arg1, %0 overflow<nsw>  : vector<2xi32>
    %3 = llvm.icmp "ne" %1, %2 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @mul_constant_ne_nsw_extra_use1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(74 : i8) : i8
    %1 = llvm.mul %arg0, %0 overflow<nsw>  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.mul %arg1, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "ne" %1, %2 : i8
    llvm.return %3 : i1
  }
  llvm.func @mul_constant_eq_nsw_extra_use2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(20 : i8) : i8
    %1 = llvm.mul %arg0, %0 overflow<nsw>  : i8
    %2 = llvm.mul %arg1, %0 overflow<nsw>  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "eq" %1, %2 : i8
    llvm.return %3 : i1
  }
  llvm.func @mul_constant_ne_nsw_extra_use3(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(24 : i8) : i8
    %1 = llvm.mul %arg0, %0 overflow<nsw>  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.mul %arg1, %0 overflow<nsw>  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %1, %2 : i8
    llvm.return %3 : i1
  }
  llvm.func @mul_constant_nuw_eq(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(22 : i32) : i32
    %1 = llvm.mul %arg0, %0 overflow<nuw>  : i32
    %2 = llvm.mul %arg1, %0 overflow<nuw>  : i32
    %3 = llvm.icmp "eq" %1, %2 : i32
    llvm.return %3 : i1
  }
  llvm.func @mul_constant_ne_nuw_splat(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<10> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mul %arg0, %0 overflow<nuw>  : vector<2xi32>
    %2 = llvm.mul %arg1, %0 overflow<nuw>  : vector<2xi32>
    %3 = llvm.icmp "ne" %1, %2 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @mul_constant_ne_nuw_extra_use1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mul %arg0, %0 overflow<nuw>  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.mul %arg1, %0 overflow<nuw>  : i8
    %3 = llvm.icmp "ne" %1, %2 : i8
    llvm.return %3 : i1
  }
  llvm.func @mul_constant_eq_nuw_extra_use2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(36 : i8) : i8
    %1 = llvm.mul %arg0, %0 overflow<nuw>  : i8
    %2 = llvm.mul %arg1, %0 overflow<nuw>  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "eq" %1, %2 : i8
    llvm.return %3 : i1
  }
  llvm.func @mul_constant_ne_nuw_extra_use3(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(38 : i8) : i8
    %1 = llvm.mul %arg0, %0 overflow<nuw>  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.mul %arg1, %0 overflow<nuw>  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %1, %2 : i8
    llvm.return %3 : i1
  }
  llvm.func @mul_constant_ult(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(47 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.icmp "ult" %1, %2 : i32
    llvm.return %3 : i1
  }
  llvm.func @mul_constant_nuw_sgt(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(46 : i32) : i32
    %1 = llvm.mul %arg0, %0 overflow<nuw>  : i32
    %2 = llvm.mul %arg1, %0 overflow<nuw>  : i32
    %3 = llvm.icmp "sgt" %1, %2 : i32
    llvm.return %3 : i1
  }
  llvm.func @mul_mismatch_constant_nuw_eq(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(46 : i32) : i32
    %1 = llvm.mlir.constant(44 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.mul %arg1, %1 overflow<nuw>  : i32
    %4 = llvm.icmp "eq" %2, %3 : i32
    llvm.return %4 : i1
  }
  llvm.func @mul_constant_partial_nuw_eq(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(44 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.mul %arg1, %0 overflow<nuw>  : i32
    %3 = llvm.icmp "eq" %1, %2 : i32
    llvm.return %3 : i1
  }
  llvm.func @mul_constant_mismatch_wrap_eq(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(54 : i32) : i32
    %1 = llvm.mul %arg0, %0 overflow<nsw>  : i32
    %2 = llvm.mul %arg1, %0 overflow<nuw>  : i32
    %3 = llvm.icmp "eq" %1, %2 : i32
    llvm.return %3 : i1
  }
  llvm.func @eq_mul_constants_with_tz(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.icmp "ne" %1, %2 : i32
    llvm.return %3 : i1
  }
  llvm.func @eq_mul_constants_with_tz_splat(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<12> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mul %arg0, %0  : vector<2xi32>
    %2 = llvm.mul %arg1, %0  : vector<2xi32>
    %3 = llvm.icmp "eq" %1, %2 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @oss_fuzz_39934(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-65536 : i32) : i32
    %1 = llvm.mlir.addressof @g : !llvm.ptr
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.mlir.constant(65537 : i32) : i32
    %4 = llvm.mul %arg0, %0 overflow<nsw>  : i32
    %5 = llvm.icmp "eq" %1, %2 : !llvm.ptr
    %6 = llvm.zext %5 : i1 to i32
    %7 = llvm.or %6, %3  : i32
    %8 = llvm.mul %7, %0  : i32
    %9 = llvm.icmp "ne" %8, %4 : i32
    llvm.return %9 : i1
  }
  llvm.func @mul_of_bool(%arg0: i32, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(255 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.zext %arg1 : i8 to i32
    %4 = llvm.mul %2, %3  : i32
    %5 = llvm.icmp "ugt" %4, %1 : i32
    llvm.return %5 : i1
  }
  llvm.func @mul_of_bool_commute(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(255 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.and %arg1, %1  : i32
    %4 = llvm.mul %3, %2  : i32
    %5 = llvm.icmp "ugt" %4, %1 : i32
    llvm.return %5 : i1
  }
  llvm.func @mul_of_bools(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.and %arg1, %0  : i32
    %4 = llvm.mul %2, %3  : i32
    %5 = llvm.icmp "ult" %4, %1 : i32
    llvm.return %5 : i1
  }
  llvm.func @not_mul_of_bool(%arg0: i32, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(255 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.zext %arg1 : i8 to i32
    %4 = llvm.mul %2, %3  : i32
    %5 = llvm.icmp "ugt" %4, %1 : i32
    llvm.return %5 : i1
  }
  llvm.func @not_mul_of_bool_commute(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(30 : i32) : i32
    %1 = llvm.mlir.constant(255 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.and %arg1, %1  : i32
    %4 = llvm.mul %3, %2  : i32
    %5 = llvm.icmp "ugt" %4, %1 : i32
    llvm.return %5 : i1
  }
  llvm.func @mul_of_bool_no_lz_other_op(%arg0: i32, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(127 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.sext %arg1 : i8 to i32
    %4 = llvm.mul %2, %3 overflow<nsw, nuw>  : i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    llvm.return %5 : i1
  }
  llvm.func @mul_of_pow2(%arg0: i32, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(510 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.zext %arg1 : i8 to i32
    %4 = llvm.mul %2, %3  : i32
    %5 = llvm.icmp "ugt" %4, %1 : i32
    llvm.return %5 : i1
  }
  llvm.func @mul_of_pow2_commute(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(255 : i32) : i32
    %2 = llvm.mlir.constant(1020 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.and %arg1, %1  : i32
    %5 = llvm.mul %4, %3  : i32
    %6 = llvm.icmp "ugt" %5, %2 : i32
    llvm.return %6 : i1
  }
  llvm.func @mul_of_pow2s(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(128 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.and %arg1, %1  : i32
    %5 = llvm.mul %3, %4  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.return %6 : i32
  }
  llvm.func @not_mul_of_pow2(%arg0: i32, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.mlir.constant(1530 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.zext %arg1 : i8 to i32
    %4 = llvm.mul %2, %3  : i32
    %5 = llvm.icmp "ugt" %4, %1 : i32
    llvm.return %5 : i1
  }
  llvm.func @not_mul_of_pow2_commute(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(255 : i32) : i32
    %2 = llvm.mlir.constant(3060 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.and %arg1, %1  : i32
    %5 = llvm.mul %4, %3  : i32
    %6 = llvm.icmp "ugt" %5, %2 : i32
    llvm.return %6 : i1
  }
  llvm.func @mul_of_pow2_no_lz_other_op(%arg0: i32, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(254 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.sext %arg1 : i8 to i32
    %4 = llvm.mul %2, %3 overflow<nsw, nuw>  : i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    llvm.return %5 : i1
  }
  llvm.func @splat_mul_known_lz(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(18446744078004518913 : i128) : i128
    %1 = llvm.mlir.constant(96 : i128) : i128
    %2 = llvm.mlir.constant(0 : i128) : i128
    %3 = llvm.zext %arg0 : i32 to i128
    %4 = llvm.mul %3, %0  : i128
    %5 = llvm.lshr %4, %1  : i128
    %6 = llvm.icmp "eq" %5, %2 : i128
    llvm.return %6 : i1
  }
  llvm.func @splat_mul_unknown_lz(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(18446744078004518913 : i128) : i128
    %1 = llvm.mlir.constant(95 : i128) : i128
    %2 = llvm.mlir.constant(0 : i128) : i128
    %3 = llvm.zext %arg0 : i32 to i128
    %4 = llvm.mul %3, %0  : i128
    %5 = llvm.lshr %4, %1  : i128
    %6 = llvm.icmp "eq" %5, %2 : i128
    llvm.return %6 : i1
  }
  llvm.func @mul_oddC_overflow_eq(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(101 : i8) : i8
    %2 = llvm.mul %arg0, %0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @mul_oddC_eq_nomod(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(34 : i8) : i8
    %2 = llvm.mul %arg0, %0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @mul_evenC_ne(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(36 : i8) : i8
    %2 = llvm.mul %arg0, %0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @mul_oddC_ne_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<12> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mul %arg0, %0  : vector<2xi8>
    %3 = llvm.icmp "ne" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @mul_oddC_ne_nosplat_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[3, 5]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[12, 15]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mul %arg0, %0  : vector<2xi8>
    %3 = llvm.icmp "ne" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @mul_nsuw_xy_z_maybe_zero_eq(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mul %arg0, %arg2 overflow<nsw, nuw>  : i8
    %1 = llvm.mul %arg1, %arg2 overflow<nsw, nuw>  : i8
    %2 = llvm.icmp "eq" %0, %1 : i8
    llvm.return %2 : i1
  }
  llvm.func @mul_xy_z_assumenozero_ne(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ne" %arg2, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.mul %arg0, %arg2  : i8
    %3 = llvm.mul %arg1, %arg2  : i8
    %4 = llvm.icmp "ne" %3, %2 : i8
    llvm.return %4 : i1
  }
  llvm.func @mul_xy_z_assumeodd_eq(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.and %arg2, %0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    "llvm.intr.assume"(%3) : (i1) -> ()
    %4 = llvm.mul %arg0, %arg2  : i8
    %5 = llvm.mul %arg2, %arg1  : i8
    %6 = llvm.icmp "eq" %4, %5 : i8
    llvm.return %6 : i1
  }
  llvm.func @reused_mul_nsw_xy_z_setnonzero_vec_ne(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.or %arg2, %0  : vector<2xi8>
    %2 = llvm.mul %1, %arg0 overflow<nsw>  : vector<2xi8>
    %3 = llvm.mul %arg1, %1 overflow<nsw>  : vector<2xi8>
    %4 = llvm.icmp "ne" %3, %2 : vector<2xi8>
    llvm.call @usev2xi8(%3) : (vector<2xi8>) -> ()
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @mul_mixed_nuw_nsw_xy_z_setodd_ult(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.or %arg2, %0  : i8
    %2 = llvm.mul %arg0, %1 overflow<nsw>  : i8
    %3 = llvm.mul %arg1, %1 overflow<nsw, nuw>  : i8
    %4 = llvm.icmp "ult" %2, %3 : i8
    llvm.return %4 : i1
  }
  llvm.func @mul_nuw_xy_z_assumenonzero_uge(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ne" %arg2, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.mul %arg0, %arg2 overflow<nuw>  : i8
    %3 = llvm.mul %arg1, %arg2 overflow<nuw>  : i8
    %4 = llvm.icmp "uge" %3, %2 : i8
    llvm.call @use(%2) : (i8) -> ()
    llvm.return %4 : i1
  }
  llvm.func @mul_nuw_xy_z_setnonzero_vec_eq(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[41, 12]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.or %arg2, %0  : vector<2xi8>
    %2 = llvm.mul %1, %arg0 overflow<nuw>  : vector<2xi8>
    %3 = llvm.mul %1, %arg1 overflow<nuw>  : vector<2xi8>
    %4 = llvm.icmp "eq" %2, %3 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @mul_nuw_xy_z_brnonzero_ult(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ne" %arg2, %0 : i8
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = llvm.mul %arg0, %arg2 overflow<nuw>  : i8
    %4 = llvm.mul %arg1, %arg2 overflow<nuw>  : i8
    %5 = llvm.icmp "ult" %4, %3 : i8
    llvm.return %5 : i1
  ^bb2:  // pred: ^bb0
    llvm.call @use(%arg2) : (i8) -> ()
    llvm.return %1 : i1
  }
  llvm.func @reused_mul_nuw_xy_z_selectnonzero_ugt(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ne" %arg2, %0 : i8
    %3 = llvm.mul %arg0, %arg2 overflow<nuw>  : i8
    %4 = llvm.mul %arg1, %arg2 overflow<nuw>  : i8
    %5 = llvm.icmp "ugt" %4, %3 : i8
    %6 = llvm.select %2, %5, %1 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @mul_mixed_nsw_nuw_xy_z_setnonzero_vec_ule(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[1, 3]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.or %arg2, %0  : vector<2xi8>
    %2 = llvm.mul %arg0, %1 overflow<nuw>  : vector<2xi8>
    %3 = llvm.mul %1, %arg1 overflow<nsw>  : vector<2xi8>
    %4 = llvm.icmp "ule" %3, %2 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }
}
