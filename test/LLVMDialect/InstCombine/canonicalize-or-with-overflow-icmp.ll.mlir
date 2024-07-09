module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(i1)
  llvm.func @ckd_add_unsigned(%arg0: i31) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.zext %arg0 : i31 to i32
    %3 = "llvm.intr.sadd.with.overflow"(%2, %0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i32, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i32, i1)> 
    %6 = llvm.icmp "slt" %5, %1 : i32
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }
  llvm.func @ckd_add_unsigned_commuted(%arg0: i31) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.zext %arg0 : i31 to i32
    %3 = "llvm.intr.sadd.with.overflow"(%2, %0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i32, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i32, i1)> 
    %6 = llvm.icmp "slt" %5, %1 : i32
    %7 = llvm.or %6, %4  : i1
    llvm.return %7 : i1
  }
  llvm.func @ckd_add_unsigned_imply_true(%arg0: i31) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.zext %arg0 : i31 to i32
    %3 = "llvm.intr.sadd.with.overflow"(%2, %0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i32, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i32, i1)> 
    %6 = llvm.icmp "sgt" %5, %1 : i32
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }
  llvm.func @canonicalize_or_sadd_with_overflow_icmp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = "llvm.intr.sadd.with.overflow"(%arg0, %0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    %4 = llvm.extractvalue %2[0] : !llvm.struct<(i32, i1)> 
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.or %3, %5  : i1
    llvm.return %6 : i1
  }
  llvm.func @canonicalize_or_ssub_with_overflow_icmp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = "llvm.intr.ssub.with.overflow"(%arg0, %0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    %4 = llvm.extractvalue %2[0] : !llvm.struct<(i32, i1)> 
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.or %3, %5  : i1
    llvm.return %6 : i1
  }
  llvm.func @canonicalize_or_uadd_with_overflow_icmp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = "llvm.intr.uadd.with.overflow"(%arg0, %0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    %4 = llvm.extractvalue %2[0] : !llvm.struct<(i32, i1)> 
    %5 = llvm.icmp "ult" %4, %1 : i32
    %6 = llvm.or %3, %5  : i1
    llvm.return %6 : i1
  }
  llvm.func @canonicalize_or_sadd_with_overflow_icmp_eq(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = "llvm.intr.sadd.with.overflow"(%arg0, %0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    %4 = llvm.extractvalue %2[0] : !llvm.struct<(i32, i1)> 
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.or %3, %5  : i1
    llvm.return %6 : i1
  }
  llvm.func @canonicalize_or_uadd_with_overflow_icmp_ne(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = "llvm.intr.uadd.with.overflow"(%arg0, %0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    %4 = llvm.extractvalue %2[0] : !llvm.struct<(i32, i1)> 
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.or %3, %5  : i1
    llvm.return %6 : i1
  }
  llvm.func @canonicalize_or_sadd_with_overflow_icmp_mismatched_pred(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = "llvm.intr.sadd.with.overflow"(%arg0, %0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    %4 = llvm.extractvalue %2[0] : !llvm.struct<(i32, i1)> 
    %5 = llvm.icmp "ult" %4, %1 : i32
    %6 = llvm.or %3, %5  : i1
    llvm.return %6 : i1
  }
  llvm.func @canonicalize_or_sadd_with_overflow_icmp_non_constant1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = "llvm.intr.sadd.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i32, i1)> 
    %3 = llvm.extractvalue %1[0] : !llvm.struct<(i32, i1)> 
    %4 = llvm.icmp "slt" %3, %0 : i32
    %5 = llvm.or %2, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @canonicalize_or_sadd_with_overflow_icmp_non_constant2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = "llvm.intr.sadd.with.overflow"(%arg0, %0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i32, i1)> 
    %3 = llvm.extractvalue %1[0] : !llvm.struct<(i32, i1)> 
    %4 = llvm.icmp "slt" %3, %arg1 : i32
    %5 = llvm.or %2, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @canonicalize_or_sadd_with_overflow_icmp_multiuse(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = "llvm.intr.sadd.with.overflow"(%arg0, %0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    %4 = llvm.extractvalue %2[0] : !llvm.struct<(i32, i1)> 
    %5 = llvm.icmp "slt" %4, %1 : i32
    llvm.call @use(%5) : (i1) -> ()
    %6 = llvm.or %3, %5  : i1
    llvm.return %6 : i1
  }
  llvm.func @canonicalize_or_sadd_with_overflow_icmp_overflow(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483647 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = "llvm.intr.sadd.with.overflow"(%arg0, %0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    %4 = llvm.extractvalue %2[0] : !llvm.struct<(i32, i1)> 
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.or %3, %5  : i1
    llvm.return %6 : i1
  }
  llvm.func @canonicalize_or_uadd_with_overflow_icmp_overflow(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = "llvm.intr.uadd.with.overflow"(%arg0, %0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    %4 = llvm.extractvalue %2[0] : !llvm.struct<(i32, i1)> 
    %5 = llvm.icmp "ult" %4, %1 : i32
    %6 = llvm.or %3, %5  : i1
    llvm.return %6 : i1
  }
  llvm.func @canonicalize_or_ssub_with_overflow_icmp_overflow(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = "llvm.intr.ssub.with.overflow"(%arg0, %0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    %4 = llvm.extractvalue %2[0] : !llvm.struct<(i32, i1)> 
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.or %3, %5  : i1
    llvm.return %6 : i1
  }
  llvm.func @canonicalize_or_smul_with_overflow_icmp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = "llvm.intr.smul.with.overflow"(%arg0, %0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    %4 = llvm.extractvalue %2[0] : !llvm.struct<(i32, i1)> 
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.or %3, %5  : i1
    llvm.return %6 : i1
  }
}
