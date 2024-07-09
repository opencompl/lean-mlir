module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @uaddtest1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = "llvm.intr.uadd.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(i8, i1)> 
    llvm.return %1 : i8
  }
  llvm.func @uaddtest2(%arg0: i8, %arg1: i8, %arg2: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.and %arg1, %0  : i8
    %3 = "llvm.intr.uadd.with.overflow"(%1, %2) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    llvm.store %5, %arg2 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.return %4 : i8
  }
  llvm.func @uaddtest3(%arg0: i8, %arg1: i8, %arg2: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.or %arg0, %0  : i8
    %2 = llvm.or %arg1, %0  : i8
    %3 = "llvm.intr.uadd.with.overflow"(%1, %2) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    llvm.store %5, %arg2 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.return %4 : i8
  }
  llvm.func @uaddtest4(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.undef : i8
    %1 = "llvm.intr.uadd.with.overflow"(%0, %arg0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(i8, i1)> 
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.store %3, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.return %2 : i8
  }
  llvm.func @uaddtest5(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = "llvm.intr.uadd.with.overflow"(%0, %arg0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(i8, i1)> 
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.store %3, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.return %2 : i8
  }
  llvm.func @uaddtest6(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-4 : i8) : i8
    %1 = "llvm.intr.uadd.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.return %2 : i1
  }
  llvm.func @uaddtest7(%arg0: i8, %arg1: i8) -> i8 {
    %0 = "llvm.intr.uadd.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(i8, i1)> 
    llvm.return %1 : i8
  }
  llvm.func @saddtest_nsw(%arg0: i8, %arg1: i8) -> !llvm.struct<(i32, i1)> {
    %0 = llvm.sext %arg0 : i8 to i32
    %1 = llvm.sext %arg1 : i8 to i32
    %2 = "llvm.intr.sadd.with.overflow"(%0, %1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %2 : !llvm.struct<(i32, i1)>
  }
  llvm.func @uaddtest_nuw(%arg0: i32, %arg1: i32) -> !llvm.struct<(i32, i1)> {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.and %arg1, %0  : i32
    %3 = "llvm.intr.uadd.with.overflow"(%1, %2) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %3 : !llvm.struct<(i32, i1)>
  }
  llvm.func @ssubtest_nsw(%arg0: i8, %arg1: i8) -> !llvm.struct<(i32, i1)> {
    %0 = llvm.sext %arg0 : i8 to i32
    %1 = llvm.sext %arg1 : i8 to i32
    %2 = "llvm.intr.ssub.with.overflow"(%0, %1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %2 : !llvm.struct<(i32, i1)>
  }
  llvm.func @usubtest_nuw(%arg0: i32, %arg1: i32) -> !llvm.struct<(i32, i1)> {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(2147483647 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.and %arg1, %1  : i32
    %4 = "llvm.intr.usub.with.overflow"(%2, %3) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %4 : !llvm.struct<(i32, i1)>
  }
  llvm.func @smultest1_nsw(%arg0: i32, %arg1: i32) -> !llvm.struct<(i32, i1)> {
    %0 = llvm.mlir.constant(4095 : i32) : i32
    %1 = llvm.mlir.constant(524287 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.and %arg1, %1  : i32
    %4 = "llvm.intr.smul.with.overflow"(%2, %3) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %4 : !llvm.struct<(i32, i1)>
  }
  llvm.func @smultest2_nsw(%arg0: i32, %arg1: i32) -> !llvm.struct<(i32, i1)> {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.ashr %arg0, %0  : i32
    %2 = llvm.ashr %arg1, %0  : i32
    %3 = "llvm.intr.smul.with.overflow"(%1, %2) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %3 : !llvm.struct<(i32, i1)>
  }
  llvm.func @smultest3_sw(%arg0: i32, %arg1: i32) -> !llvm.struct<(i32, i1)> {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.ashr %arg1, %1  : i32
    %4 = "llvm.intr.smul.with.overflow"(%2, %3) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %4 : !llvm.struct<(i32, i1)>
  }
  llvm.func @umultest_nuw(%arg0: i32, %arg1: i32) -> !llvm.struct<(i32, i1)> {
    %0 = llvm.mlir.constant(65535 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.and %arg1, %0  : i32
    %3 = "llvm.intr.umul.with.overflow"(%1, %2) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %3 : !llvm.struct<(i32, i1)>
  }
  llvm.func @umultest1(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = "llvm.intr.umul.with.overflow"(%0, %arg0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(i8, i1)> 
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.store %3, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.return %2 : i8
  }
  llvm.func @umultest2(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = "llvm.intr.umul.with.overflow"(%0, %arg0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(i8, i1)> 
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.store %3, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.return %2 : i8
  }
  llvm.func @umultest3(%arg0: i32) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = "llvm.intr.umul.with.overflow"(%3, %1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %5 = llvm.extractvalue %4[1] : !llvm.struct<(i32, i1)> 
    %6 = llvm.extractvalue %4[0] : !llvm.struct<(i32, i1)> 
    %7 = llvm.select %5, %2, %6 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @umultest4(%arg0: i32) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = "llvm.intr.umul.with.overflow"(%3, %1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %5 = llvm.extractvalue %4[1] : !llvm.struct<(i32, i1)> 
    %6 = llvm.extractvalue %4[0] : !llvm.struct<(i32, i1)> 
    %7 = llvm.select %5, %2, %6 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @umultest5(%arg0: i32, %arg1: i32) -> !llvm.struct<(i32, i1)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.or %arg0, %0  : i32
    %2 = llvm.or %arg1, %0  : i32
    %3 = "llvm.intr.umul.with.overflow"(%1, %2) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %3 : !llvm.struct<(i32, i1)>
  }
  llvm.func @overflow_div_add(%arg0: i32, %arg1: i32) -> i1 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.sdiv %arg0, %0  : i32
    %3 = "llvm.intr.sadd.with.overflow"(%2, %1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i32, i1)> 
    llvm.return %4 : i1
  }
  llvm.func @overflow_div_sub(%arg0: i32, %arg1: i32) -> i1 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(18 : i32) : i32
    %1 = llvm.mlir.constant(65536 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.ashr %arg0, %0  : i32
    %4 = llvm.sdiv %3, %1  : i32
    %5 = "llvm.intr.ssub.with.overflow"(%4, %2) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %6 = llvm.extractvalue %5[1] : !llvm.struct<(i32, i1)> 
    llvm.return %6 : i1
  }
  llvm.func @overflow_mod_mul(%arg0: i32, %arg1: i32) -> i1 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1000 : i32) : i32
    %1 = llvm.srem %arg0, %0  : i32
    %2 = "llvm.intr.smul.with.overflow"(%1, %1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    llvm.return %3 : i1
  }
  llvm.func @overflow_mod_overflow_mul(%arg0: i32, %arg1: i32) -> i1 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(65537 : i32) : i32
    %1 = llvm.srem %arg0, %0  : i32
    %2 = "llvm.intr.smul.with.overflow"(%1, %1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    llvm.return %3 : i1
  }
  llvm.func @overflow_mod_mul2(%arg0: i16, %arg1: i32) -> i1 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.sext %arg0 : i16 to i32
    %1 = llvm.srem %0, %arg1  : i32
    %2 = "llvm.intr.smul.with.overflow"(%1, %1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    llvm.return %3 : i1
  }
  llvm.func @ssubtest_reorder(%arg0: i8) -> !llvm.struct<(i32, i1)> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = "llvm.intr.ssub.with.overflow"(%0, %1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %2 : !llvm.struct<(i32, i1)>
  }
  llvm.func @never_overflows_ssub_test0(%arg0: i32) -> !llvm.struct<(i32, i1)> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = "llvm.intr.ssub.with.overflow"(%arg0, %0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %1 : !llvm.struct<(i32, i1)>
  }
  llvm.func @uadd_res_ult_x(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i1 attributes {passthrough = ["nounwind"]} {
    %0 = "llvm.intr.uadd.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(i32, i1)> 
    llvm.store %1, %arg2 {alignment = 1 : i64} : i1, !llvm.ptr
    %2 = llvm.extractvalue %0[0] : !llvm.struct<(i32, i1)> 
    %3 = llvm.icmp "ult" %2, %arg0 : i32
    llvm.return %3 : i1
  }
  llvm.func @uadd_res_ult_y(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i1 attributes {passthrough = ["nounwind"]} {
    %0 = "llvm.intr.uadd.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(i32, i1)> 
    llvm.store %1, %arg2 {alignment = 1 : i64} : i1, !llvm.ptr
    %2 = llvm.extractvalue %0[0] : !llvm.struct<(i32, i1)> 
    %3 = llvm.icmp "ult" %2, %arg1 : i32
    llvm.return %3 : i1
  }
  llvm.func @uadd_res_ugt_x(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i1 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.urem %0, %arg0  : i32
    %2 = "llvm.intr.uadd.with.overflow"(%1, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    llvm.store %3, %arg2 {alignment = 1 : i64} : i1, !llvm.ptr
    %4 = llvm.extractvalue %2[0] : !llvm.struct<(i32, i1)> 
    %5 = llvm.icmp "ugt" %1, %4 : i32
    llvm.return %5 : i1
  }
  llvm.func @uadd_res_ugt_y(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i1 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.urem %0, %arg1  : i32
    %2 = "llvm.intr.uadd.with.overflow"(%arg0, %1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    llvm.store %3, %arg2 {alignment = 1 : i64} : i1, !llvm.ptr
    %4 = llvm.extractvalue %2[0] : !llvm.struct<(i32, i1)> 
    %5 = llvm.icmp "ugt" %1, %4 : i32
    llvm.return %5 : i1
  }
  llvm.func @uadd_res_ult_const(%arg0: i32, %arg1: !llvm.ptr) -> i1 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = "llvm.intr.uadd.with.overflow"(%arg0, %0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i32, i1)> 
    llvm.store %2, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr
    %3 = llvm.extractvalue %1[0] : !llvm.struct<(i32, i1)> 
    %4 = llvm.icmp "ult" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @uadd_res_ult_const_one(%arg0: i32, %arg1: !llvm.ptr) -> i1 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = "llvm.intr.uadd.with.overflow"(%arg0, %0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i32, i1)> 
    llvm.store %2, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr
    %3 = llvm.extractvalue %1[0] : !llvm.struct<(i32, i1)> 
    %4 = llvm.icmp "ult" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @uadd_res_ult_const_minus_one(%arg0: i32, %arg1: !llvm.ptr) -> i1 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = "llvm.intr.uadd.with.overflow"(%arg0, %0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i32, i1)> 
    llvm.store %2, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr
    %3 = llvm.extractvalue %1[0] : !llvm.struct<(i32, i1)> 
    %4 = llvm.icmp "ult" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @sadd_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<(i32, i1)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = "llvm.intr.sadd.with.overflow"(%0, %arg0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %1 : !llvm.struct<(i32, i1)>
  }
  llvm.func @uadd_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<(i32, i1)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = "llvm.intr.uadd.with.overflow"(%0, %arg0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %1 : !llvm.struct<(i32, i1)>
  }
  llvm.func @ssub_no_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<(i32, i1)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = "llvm.intr.ssub.with.overflow"(%0, %arg0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %1 : !llvm.struct<(i32, i1)>
  }
  llvm.func @usub_no_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<(i32, i1)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = "llvm.intr.usub.with.overflow"(%0, %arg0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %1 : !llvm.struct<(i32, i1)>
  }
  llvm.func @smul_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<(i32, i1)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = "llvm.intr.smul.with.overflow"(%0, %arg0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %1 : !llvm.struct<(i32, i1)>
  }
  llvm.func @umul_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<(i32, i1)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = "llvm.intr.umul.with.overflow"(%0, %arg0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %1 : !llvm.struct<(i32, i1)>
  }
  llvm.func @uadd_always_overflow(%arg0: i8) -> !llvm.struct<(i8, i1)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(-64 : i8) : i8
    %1 = llvm.mlir.constant(64 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = "llvm.intr.uadd.with.overflow"(%2, %1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    llvm.return %3 : !llvm.struct<(i8, i1)>
  }
  llvm.func @usub_always_overflow(%arg0: i8) -> !llvm.struct<(i8, i1)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(64 : i8) : i8
    %1 = llvm.mlir.constant(63 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = "llvm.intr.usub.with.overflow"(%1, %2) : (i8, i8) -> !llvm.struct<(i8, i1)>
    llvm.return %3 : !llvm.struct<(i8, i1)>
  }
  llvm.func @umul_always_overflow(%arg0: i8) -> !llvm.struct<(i8, i1)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = "llvm.intr.umul.with.overflow"(%2, %1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    llvm.return %3 : !llvm.struct<(i8, i1)>
  }
  llvm.func @sadd_always_overflow(%arg0: i8) -> !llvm.struct<(i8, i1)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(100 : i8) : i8
    %1 = llvm.mlir.constant(28 : i8) : i8
    %2 = llvm.icmp "sgt" %arg0, %0 : i8
    %3 = llvm.select %2, %arg0, %0 : i1, i8
    %4 = "llvm.intr.sadd.with.overflow"(%3, %1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    llvm.return %4 : !llvm.struct<(i8, i1)>
  }
  llvm.func @ssub_always_overflow(%arg0: i8) -> !llvm.struct<(i8, i1)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(29 : i8) : i8
    %1 = llvm.mlir.constant(-100 : i8) : i8
    %2 = llvm.icmp "sgt" %arg0, %0 : i8
    %3 = llvm.select %2, %arg0, %0 : i1, i8
    %4 = "llvm.intr.ssub.with.overflow"(%1, %3) : (i8, i8) -> !llvm.struct<(i8, i1)>
    llvm.return %4 : !llvm.struct<(i8, i1)>
  }
  llvm.func @smul_always_overflow(%arg0: i8) -> !llvm.struct<(i8, i1)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(100 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.icmp "sgt" %arg0, %0 : i8
    %3 = llvm.select %2, %arg0, %0 : i1, i8
    %4 = "llvm.intr.smul.with.overflow"(%3, %1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    llvm.return %4 : !llvm.struct<(i8, i1)>
  }
  llvm.func @always_sadd_const_vector() -> !llvm.struct<(vector<4xi8>, vector<4xi1>)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<127> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(dense<1> : vector<4xi8>) : vector<4xi8>
    %2 = "llvm.intr.sadd.with.overflow"(%0, %1) : (vector<4xi8>, vector<4xi8>) -> !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    llvm.return %2 : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
  }
  llvm.func @always_uadd_const_vector() -> !llvm.struct<(vector<4xi8>, vector<4xi1>)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(dense<1> : vector<4xi8>) : vector<4xi8>
    %2 = "llvm.intr.uadd.with.overflow"(%0, %1) : (vector<4xi8>, vector<4xi8>) -> !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    llvm.return %2 : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
  }
  llvm.func @always_ssub_const_vector() -> !llvm.struct<(vector<4xi8>, vector<4xi1>)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<-128> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(dense<1> : vector<4xi8>) : vector<4xi8>
    %2 = "llvm.intr.ssub.with.overflow"(%0, %1) : (vector<4xi8>, vector<4xi8>) -> !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    llvm.return %2 : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
  }
  llvm.func @always_usub_const_vector() -> !llvm.struct<(vector<4xi8>, vector<4xi1>)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<4xi8>) : vector<4xi8>
    %2 = llvm.mlir.constant(dense<1> : vector<4xi8>) : vector<4xi8>
    %3 = "llvm.intr.usub.with.overflow"(%1, %2) : (vector<4xi8>, vector<4xi8>) -> !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    llvm.return %3 : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
  }
  llvm.func @always_smul_const_vector() -> !llvm.struct<(vector<4xi8>, vector<4xi1>)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<127> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(dense<3> : vector<4xi8>) : vector<4xi8>
    %2 = "llvm.intr.smul.with.overflow"(%0, %1) : (vector<4xi8>, vector<4xi8>) -> !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    llvm.return %2 : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
  }
  llvm.func @always_umul_const_vector() -> !llvm.struct<(vector<4xi8>, vector<4xi1>)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(dense<3> : vector<4xi8>) : vector<4xi8>
    %2 = "llvm.intr.umul.with.overflow"(%0, %1) : (vector<4xi8>, vector<4xi8>) -> !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    llvm.return %2 : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
  }
  llvm.func @never_sadd_const_vector() -> !llvm.struct<(vector<4xi8>, vector<4xi1>)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<[-10, -20, 30, 40]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(dense<[-40, 10, -30, 20]> : vector<4xi8>) : vector<4xi8>
    %2 = "llvm.intr.sadd.with.overflow"(%0, %1) : (vector<4xi8>, vector<4xi8>) -> !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    llvm.return %2 : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
  }
  llvm.func @never_uadd_const_vector() -> !llvm.struct<(vector<4xi8>, vector<4xi1>)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<[0, 32, 64, 16]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(dense<32> : vector<4xi8>) : vector<4xi8>
    %2 = "llvm.intr.uadd.with.overflow"(%0, %1) : (vector<4xi8>, vector<4xi8>) -> !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    llvm.return %2 : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
  }
  llvm.func @never_ssub_const_vector() -> !llvm.struct<(vector<4xi8>, vector<4xi1>)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<-10> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(dense<[-10, -20, -30, -40]> : vector<4xi8>) : vector<4xi8>
    %2 = "llvm.intr.ssub.with.overflow"(%0, %1) : (vector<4xi8>, vector<4xi8>) -> !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    llvm.return %2 : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
  }
  llvm.func @never_usub_const_vector() -> !llvm.struct<(vector<4xi8>, vector<4xi1>)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(dense<[-128, 0, -1, 1]> : vector<4xi8>) : vector<4xi8>
    %2 = "llvm.intr.usub.with.overflow"(%0, %1) : (vector<4xi8>, vector<4xi8>) -> !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    llvm.return %2 : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
  }
  llvm.func @never_smul_const_vector() -> !llvm.struct<(vector<4xi8>, vector<4xi1>)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<-6> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(dense<[9, 3, 10, 15]> : vector<4xi8>) : vector<4xi8>
    %2 = "llvm.intr.smul.with.overflow"(%0, %1) : (vector<4xi8>, vector<4xi8>) -> !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    llvm.return %2 : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
  }
  llvm.func @never_umul_const_vector() -> !llvm.struct<(vector<4xi8>, vector<4xi1>)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<15> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(dense<[15, 8, 4, 2]> : vector<4xi8>) : vector<4xi8>
    %2 = "llvm.intr.umul.with.overflow"(%0, %1) : (vector<4xi8>, vector<4xi8>) -> !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    llvm.return %2 : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
  }
  llvm.func @neutral_sadd_const_vector() -> !llvm.struct<(vector<4xi8>, vector<4xi1>)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<4xi8>) : vector<4xi8>
    %3 = "llvm.intr.sadd.with.overflow"(%0, %2) : (vector<4xi8>, vector<4xi8>) -> !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    llvm.return %3 : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
  }
  llvm.func @neutral_uadd_const_vector() -> !llvm.struct<(vector<4xi8>, vector<4xi1>)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<4xi8>) : vector<4xi8>
    %3 = "llvm.intr.uadd.with.overflow"(%0, %2) : (vector<4xi8>, vector<4xi8>) -> !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    llvm.return %3 : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
  }
  llvm.func @neutral_ssub_const_vector() -> !llvm.struct<(vector<4xi8>, vector<4xi1>)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<4xi8>) : vector<4xi8>
    %3 = "llvm.intr.ssub.with.overflow"(%0, %2) : (vector<4xi8>, vector<4xi8>) -> !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    llvm.return %3 : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
  }
  llvm.func @neutral_usub_const_vector() -> !llvm.struct<(vector<4xi8>, vector<4xi1>)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<4xi8>) : vector<4xi8>
    %3 = "llvm.intr.usub.with.overflow"(%0, %2) : (vector<4xi8>, vector<4xi8>) -> !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    llvm.return %3 : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
  }
  llvm.func @neutral_smul_const_vector() -> !llvm.struct<(vector<4xi8>, vector<4xi1>)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(dense<1> : vector<4xi8>) : vector<4xi8>
    %2 = "llvm.intr.smul.with.overflow"(%0, %1) : (vector<4xi8>, vector<4xi8>) -> !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    llvm.return %2 : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
  }
  llvm.func @neutral_umul_const_vector() -> !llvm.struct<(vector<4xi8>, vector<4xi1>)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(dense<1> : vector<4xi8>) : vector<4xi8>
    %2 = "llvm.intr.umul.with.overflow"(%0, %1) : (vector<4xi8>, vector<4xi8>) -> !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    llvm.return %2 : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
  }
  llvm.func @smul_neg1(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = "llvm.intr.smul.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(i8, i1)> 
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.store %3, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.return %2 : i8
  }
  llvm.func @smul_neg1_vec(%arg0: vector<4xi8>, %arg1: !llvm.ptr) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi8>) : vector<4xi8>
    %1 = "llvm.intr.smul.with.overflow"(%arg0, %0) : (vector<4xi8>, vector<4xi8>) -> !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    llvm.store %3, %arg1 {alignment = 1 : i64} : vector<4xi1>, !llvm.ptr
    llvm.return %2 : vector<4xi8>
  }
  llvm.func @smul_neg1_vec_poison(%arg0: vector<4xi8>, %arg1: !llvm.ptr) -> vector<4xi8> {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.undef : vector<4xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<4xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<4xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %1, %6[%7 : i32] : vector<4xi8>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi8>
    %11 = "llvm.intr.smul.with.overflow"(%arg0, %10) : (vector<4xi8>, vector<4xi8>) -> !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    %12 = llvm.extractvalue %11[0] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    %13 = llvm.extractvalue %11[1] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    llvm.store %13, %arg1 {alignment = 1 : i64} : vector<4xi1>, !llvm.ptr
    llvm.return %12 : vector<4xi8>
  }
  llvm.func @smul_neg2(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = "llvm.intr.smul.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(i8, i1)> 
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.store %3, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.return %2 : i8
  }
  llvm.func @umul_neg1(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(i8, i1)> 
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.store %3, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.return %2 : i8
  }
  llvm.func @umul_neg1_vec(%arg0: vector<4xi8>, %arg1: !llvm.ptr) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi8>) : vector<4xi8>
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %0) : (vector<4xi8>, vector<4xi8>) -> !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    llvm.store %3, %arg1 {alignment = 1 : i64} : vector<4xi1>, !llvm.ptr
    llvm.return %2 : vector<4xi8>
  }
  llvm.func @umul_neg1_vec_poison(%arg0: vector<4xi8>, %arg1: !llvm.ptr) -> vector<4xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.undef : vector<4xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<4xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<4xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %1, %6[%7 : i32] : vector<4xi8>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi8>
    %11 = "llvm.intr.umul.with.overflow"(%arg0, %10) : (vector<4xi8>, vector<4xi8>) -> !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    %12 = llvm.extractvalue %11[0] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    %13 = llvm.extractvalue %11[1] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    llvm.store %13, %arg1 {alignment = 1 : i64} : vector<4xi1>, !llvm.ptr
    llvm.return %12 : vector<4xi8>
  }
  llvm.func @smul_not_neg1_vec(%arg0: vector<4xi8>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(-3 : i8) : i8
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.undef : vector<4xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<4xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<4xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %1, %6[%7 : i32] : vector<4xi8>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi8>
    %11 = "llvm.intr.smul.with.overflow"(%arg0, %10) : (vector<4xi8>, vector<4xi8>) -> !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    %12 = llvm.extractvalue %11[1] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    llvm.return %12 : vector<4xi1>
  }
  llvm.func @umul_neg1_select(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(i8, i1)> 
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    %4 = llvm.select %3, %0, %2 : i1, i8
    llvm.return %4 : i8
  }
  llvm.func @umul_2(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(i8, i1)> 
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.store %3, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.return %2 : i8
  }
  llvm.func @umul_8(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(8 : i8) : i8
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(i8, i1)> 
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.store %3, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.return %2 : i8
  }
  llvm.func @umul_64(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(64 : i8) : i8
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(i8, i1)> 
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.store %3, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.return %2 : i8
  }
  llvm.func @umul_256(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(i8, i1)> 
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.store %3, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.return %2 : i8
  }
  llvm.func @umul_4_vec_poison(%arg0: vector<4xi8>, %arg1: !llvm.ptr) -> vector<4xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.mlir.undef : vector<4xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<4xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<4xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %1, %6[%7 : i32] : vector<4xi8>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi8>
    %11 = "llvm.intr.umul.with.overflow"(%arg0, %10) : (vector<4xi8>, vector<4xi8>) -> !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    %12 = llvm.extractvalue %11[0] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    %13 = llvm.extractvalue %11[1] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    llvm.store %13, %arg1 {alignment = 1 : i64} : vector<4xi1>, !llvm.ptr
    llvm.return %12 : vector<4xi8>
  }
  llvm.func @umul_3(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(i8, i1)> 
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.store %3, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.return %2 : i8
  }
  llvm.func @smul_4(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = "llvm.intr.smul.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(i8, i1)> 
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.store %3, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.return %2 : i8
  }
  llvm.func @smul_16(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = "llvm.intr.smul.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(i8, i1)> 
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.store %3, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.return %2 : i8
  }
  llvm.func @smul_32(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(32 : i8) : i8
    %1 = "llvm.intr.smul.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(i8, i1)> 
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.store %3, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.return %2 : i8
  }
  llvm.func @smul_128(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = "llvm.intr.smul.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(i8, i1)> 
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.store %3, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.return %2 : i8
  }
  llvm.func @smul_2_vec_poison(%arg0: vector<4xi8>, %arg1: !llvm.ptr) -> vector<4xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.undef : vector<4xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<4xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<4xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %1, %6[%7 : i32] : vector<4xi8>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi8>
    %11 = "llvm.intr.smul.with.overflow"(%arg0, %10) : (vector<4xi8>, vector<4xi8>) -> !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    %12 = llvm.extractvalue %11[0] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    %13 = llvm.extractvalue %11[1] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    llvm.store %13, %arg1 {alignment = 1 : i64} : vector<4xi1>, !llvm.ptr
    llvm.return %12 : vector<4xi8>
  }
  llvm.func @smul_7(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = "llvm.intr.smul.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(i8, i1)> 
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.store %3, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.return %2 : i8
  }
}
