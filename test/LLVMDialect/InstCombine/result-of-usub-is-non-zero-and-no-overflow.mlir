module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use8(i8)
  llvm.func @use64(i64)
  llvm.func @use1(i1)
  llvm.func @useagg(!llvm.struct<(i8, i1)>)
  llvm.func @t0_noncanonical_ignoreme(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "ule" %1, %arg0 : i8
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.icmp "ne" %1, %0 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.and %3, %2  : i1
    llvm.return %4 : i1
  }
  llvm.func @t0_noncanonical_ignoreme_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ule" %2, %arg0 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.icmp "ne" %2, %0 : i8
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.select %4, %3, %1 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @t1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "uge" %arg0, %arg1 : i8
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.icmp "ne" %1, %0 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.and %3, %2  : i1
    llvm.return %4 : i1
  }
  llvm.func @t1_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "uge" %arg0, %arg1 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.icmp "ne" %2, %0 : i8
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.select %4, %3, %1 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @t1_strict(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "ugt" %arg0, %arg1 : i8
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.icmp "ne" %1, %0 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.and %3, %2  : i1
    llvm.return %4 : i1
  }
  llvm.func @t1_strict_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ugt" %arg0, %arg1 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.icmp "ne" %2, %0 : i8
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.select %4, %3, %1 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @t2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    llvm.call @useagg(%2) : (!llvm.struct<(i8, i1)>) -> ()
    %3 = llvm.extractvalue %2[0] : !llvm.struct<(i8, i1)> 
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.extractvalue %2[1] : !llvm.struct<(i8, i1)> 
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.xor %4, %0  : i1
    llvm.call @use1(%5) : (i1) -> ()
    %6 = llvm.icmp "ne" %3, %1 : i8
    %7 = llvm.and %6, %5  : i1
    llvm.return %7 : i1
  }
  llvm.func @t2_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(false) : i1
    %3 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    llvm.call @useagg(%3) : (!llvm.struct<(i8, i1)>) -> ()
    %4 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    llvm.call @use8(%4) : (i8) -> ()
    %5 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    llvm.call @use1(%5) : (i1) -> ()
    %6 = llvm.xor %5, %0  : i1
    llvm.call @use1(%6) : (i1) -> ()
    %7 = llvm.icmp "ne" %4, %1 : i8
    %8 = llvm.select %7, %6, %2 : i1, i1
    llvm.return %8 : i1
  }
  llvm.func @t3_commutability0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "ule" %arg1, %arg0 : i8
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.icmp "ne" %1, %0 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.and %3, %2  : i1
    llvm.return %4 : i1
  }
  llvm.func @t3_commutability0_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ule" %arg1, %arg0 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.icmp "ne" %2, %0 : i8
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.select %4, %3, %1 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @t4_commutability1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "uge" %arg0, %arg1 : i8
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.icmp "ne" %1, %0 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @t4_commutability1_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "uge" %arg0, %arg1 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.icmp "ne" %2, %0 : i8
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.select %3, %4, %1 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @t5_commutability2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "ule" %arg1, %arg0 : i8
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.icmp "ne" %1, %0 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @t5_commutability2_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ule" %arg1, %arg0 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.icmp "ne" %2, %0 : i8
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.select %3, %4, %1 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @t6_commutability(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    llvm.call @useagg(%2) : (!llvm.struct<(i8, i1)>) -> ()
    %3 = llvm.extractvalue %2[0] : !llvm.struct<(i8, i1)> 
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.extractvalue %2[1] : !llvm.struct<(i8, i1)> 
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.xor %4, %0  : i1
    llvm.call @use1(%5) : (i1) -> ()
    %6 = llvm.icmp "ne" %3, %1 : i8
    %7 = llvm.and %5, %6  : i1
    llvm.return %7 : i1
  }
  llvm.func @t6_commutability_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(false) : i1
    %3 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    llvm.call @useagg(%3) : (!llvm.struct<(i8, i1)>) -> ()
    %4 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    llvm.call @use8(%4) : (i8) -> ()
    %5 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    llvm.call @use1(%5) : (i1) -> ()
    %6 = llvm.xor %5, %0  : i1
    llvm.call @use1(%6) : (i1) -> ()
    %7 = llvm.icmp "ne" %4, %1 : i8
    %8 = llvm.select %6, %7, %2 : i1, i1
    llvm.return %8 : i1
  }
  llvm.func @t7(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "ult" %arg0, %arg1 : i8
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.icmp "eq" %1, %0 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.or %3, %2  : i1
    llvm.return %4 : i1
  }
  llvm.func @t7_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ult" %arg0, %arg1 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.icmp "eq" %2, %0 : i8
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.select %4, %1, %3 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @t7_nonstrict(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "ule" %arg0, %arg1 : i8
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.icmp "eq" %1, %0 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.or %3, %2  : i1
    llvm.return %4 : i1
  }
  llvm.func @t7_nonstrict_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ule" %arg0, %arg1 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.icmp "eq" %2, %0 : i8
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.select %4, %1, %3 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @t8(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    llvm.call @useagg(%1) : (!llvm.struct<(i8, i1)>) -> ()
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(i8, i1)> 
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.icmp "eq" %2, %0 : i8
    %5 = llvm.or %4, %3  : i1
    llvm.return %5 : i1
  }
  llvm.func @t8_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    llvm.call @useagg(%2) : (!llvm.struct<(i8, i1)>) -> ()
    %3 = llvm.extractvalue %2[0] : !llvm.struct<(i8, i1)> 
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.extractvalue %2[1] : !llvm.struct<(i8, i1)> 
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.icmp "eq" %3, %0 : i8
    %6 = llvm.select %5, %1, %4 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @t9_commutative(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "ult" %arg0, %1 : i8
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.icmp "eq" %1, %0 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.or %3, %2  : i1
    llvm.return %4 : i1
  }
  llvm.func @t9_commutative_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ult" %arg0, %2 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.icmp "eq" %2, %0 : i8
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.select %4, %1, %3 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @t10(%arg0: i64, %arg1: !llvm.ptr {llvm.nonnull}) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.ptrtoint %arg1 : !llvm.ptr to i64
    %2 = llvm.sub %arg0, %1  : i64
    llvm.call @use64(%2) : (i64) -> ()
    %3 = llvm.icmp "ult" %2, %arg0 : i64
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.icmp "ne" %2, %0 : i64
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.and %4, %3  : i1
    llvm.return %5 : i1
  }
  llvm.func @t10_logical(%arg0: i64, %arg1: !llvm.ptr {llvm.nonnull}) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.ptrtoint %arg1 : !llvm.ptr to i64
    %3 = llvm.sub %arg0, %2  : i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.icmp "ult" %3, %arg0 : i64
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.icmp "ne" %3, %0 : i64
    llvm.call @use1(%5) : (i1) -> ()
    %6 = llvm.select %5, %4, %1 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @t11_commutative(%arg0: i64, %arg1: !llvm.ptr {llvm.nonnull}) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.ptrtoint %arg1 : !llvm.ptr to i64
    %2 = llvm.sub %arg0, %1  : i64
    llvm.call @use64(%2) : (i64) -> ()
    %3 = llvm.icmp "ugt" %arg0, %2 : i64
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.icmp "ne" %2, %0 : i64
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.and %4, %3  : i1
    llvm.return %5 : i1
  }
  llvm.func @t11_commutative_logical(%arg0: i64, %arg1: !llvm.ptr {llvm.nonnull}) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.ptrtoint %arg1 : !llvm.ptr to i64
    %3 = llvm.sub %arg0, %2  : i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.icmp "ugt" %arg0, %3 : i64
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.icmp "ne" %3, %0 : i64
    llvm.call @use1(%5) : (i1) -> ()
    %6 = llvm.select %5, %4, %1 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @t12(%arg0: i64, %arg1: !llvm.ptr {llvm.nonnull}) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.ptrtoint %arg1 : !llvm.ptr to i64
    %2 = llvm.sub %arg0, %1  : i64
    llvm.call @use64(%2) : (i64) -> ()
    %3 = llvm.icmp "uge" %2, %arg0 : i64
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.icmp "eq" %2, %0 : i64
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.or %4, %3  : i1
    llvm.return %5 : i1
  }
  llvm.func @t12_logical(%arg0: i64, %arg1: !llvm.ptr {llvm.nonnull}) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.ptrtoint %arg1 : !llvm.ptr to i64
    %3 = llvm.sub %arg0, %2  : i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.icmp "uge" %3, %arg0 : i64
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.icmp "eq" %3, %0 : i64
    llvm.call @use1(%5) : (i1) -> ()
    %6 = llvm.select %5, %1, %4 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @t13(%arg0: i64, %arg1: !llvm.ptr {llvm.nonnull}) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.ptrtoint %arg1 : !llvm.ptr to i64
    %2 = llvm.sub %arg0, %1  : i64
    llvm.call @use64(%2) : (i64) -> ()
    %3 = llvm.icmp "ule" %arg0, %2 : i64
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.icmp "eq" %2, %0 : i64
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.or %4, %3  : i1
    llvm.return %5 : i1
  }
  llvm.func @t13_logical(%arg0: i64, %arg1: !llvm.ptr {llvm.nonnull}) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.ptrtoint %arg1 : !llvm.ptr to i64
    %3 = llvm.sub %arg0, %2  : i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.icmp "ule" %arg0, %3 : i64
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.icmp "eq" %3, %0 : i64
    llvm.call @use1(%5) : (i1) -> ()
    %6 = llvm.select %5, %1, %4 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @t14_bad(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.sub %arg0, %arg1  : i64
    llvm.call @use64(%1) : (i64) -> ()
    %2 = llvm.icmp "ult" %1, %arg0 : i64
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.icmp "ne" %1, %0 : i64
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.and %3, %2  : i1
    llvm.return %4 : i1
  }
  llvm.func @t14_bad_logical(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.sub %arg0, %arg1  : i64
    llvm.call @use64(%2) : (i64) -> ()
    %3 = llvm.icmp "ult" %2, %arg0 : i64
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.icmp "ne" %2, %0 : i64
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.select %4, %3, %1 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @base_ult_offset(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "ne" %1, %0 : i8
    %3 = llvm.icmp "ule" %arg0, %arg1 : i8
    %4 = llvm.and %3, %2  : i1
    llvm.return %4 : i1
  }
  llvm.func @base_ult_offset_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %2, %0 : i8
    %4 = llvm.icmp "ule" %arg0, %arg1 : i8
    %5 = llvm.select %4, %3, %1 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @base_uge_offset(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "eq" %1, %0 : i8
    %3 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %4 = llvm.or %3, %2  : i1
    llvm.return %4 : i1
  }
  llvm.func @base_uge_offset_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "eq" %2, %0 : i8
    %4 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %5 = llvm.select %4, %1, %3 : i1, i1
    llvm.return %5 : i1
  }
}
