module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @fcmp_oeq_inf_or_class_normal(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0x7C00 : f16) : f16
    %1 = llvm.fcmp "oeq" %arg0, %0 : f16
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f16) -> i1
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @class_normal_or_fcmp_oeq_inf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0x7C00 : f16) : f16
    %1 = llvm.fcmp "oeq" %arg0, %0 : f16
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f16) -> i1
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @fcmp_oeq_inf_or_class_normal_vector(%arg0: vector<2xf16>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<0x7C00> : vector<2xf16>) : vector<2xf16>
    %1 = llvm.fcmp "oeq" %arg0, %0 : vector<2xf16>
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (vector<2xf16>) -> vector<2xi1>
    %3 = llvm.or %1, %2  : vector<2xi1>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @fcmp_oeq_inf_multi_use_or_class_normal(%arg0: f16, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0x7C00 : f16) : f16
    %1 = llvm.fcmp "oeq" %arg0, %0 : f16
    llvm.store %1, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f16) -> i1
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @fcmp_oeq_inf_or_class_normal_multi_use(%arg0: f16, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0x7C00 : f16) : f16
    %1 = llvm.fcmp "oeq" %arg0, %0 : f16
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f16) -> i1
    llvm.store %2, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @fcmp_ord_or_class_isnan(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 : f16
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 3 : i32}> : (f16) -> i1
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @fcmp_ord_or_class_isnan_wrong_operand(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 : f16
    %2 = "llvm.intr.is.fpclass"(%arg1) <{bit = 3 : i32}> : (f16) -> i1
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @fcmp_ord_and_class_isnan(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 : f16
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 3 : i32}> : (f16) -> i1
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @fcmp_ord_or_class_isnan_commute(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 3 : i32}> : (f16) -> i1
    %2 = llvm.fcmp "ord" %arg0, %0 : f16
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @fcmp_ord_and_class_isnan_commute(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 3 : i32}> : (f16) -> i1
    %2 = llvm.fcmp "ord" %arg0, %0 : f16
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @fcmp_isfinite_and_class_subnormal(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0x7C00 : f16) : f16
    %1 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %2 = llvm.fcmp "olt" %1, %0 : f16
    %3 = "llvm.intr.is.fpclass"(%arg0) <{bit = 144 : i32}> : (f16) -> i1
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @fcmp_isfinite_or_class_subnormal(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0x7C00 : f16) : f16
    %1 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %2 = llvm.fcmp "olt" %1, %0 : f16
    %3 = "llvm.intr.is.fpclass"(%arg0) <{bit = 144 : i32}> : (f16) -> i1
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @fcmp_issubnormal_or_class_finite(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(6.103520e-05 : f16) : f16
    %1 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %2 = llvm.fcmp "olt" %1, %0 : f16
    %3 = "llvm.intr.is.fpclass"(%arg0) <{bit = 504 : i32}> : (f16) -> i1
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @class_finite_or_fcmp_issubnormal(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(6.103520e-05 : f16) : f16
    %1 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %2 = llvm.fcmp "olt" %1, %0 : f16
    %3 = "llvm.intr.is.fpclass"(%arg0) <{bit = 504 : i32}> : (f16) -> i1
    %4 = llvm.or %3, %2  : i1
    llvm.return %4 : i1
  }
  llvm.func @fcmp_issubnormal_and_class_finite(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(6.103520e-05 : f16) : f16
    %1 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %2 = llvm.fcmp "olt" %1, %0 : f16
    %3 = "llvm.intr.is.fpclass"(%arg0) <{bit = 504 : i32}> : (f16) -> i1
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @class_inf_or_fcmp_issubnormal(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(6.103520e-05 : f16) : f16
    %1 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %2 = llvm.fcmp "olt" %1, %0 : f16
    %3 = "llvm.intr.is.fpclass"(%arg0) <{bit = 516 : i32}> : (f16) -> i1
    %4 = llvm.or %3, %2  : i1
    llvm.return %4 : i1
  }
  llvm.func @class_finite_or_fcmp_issubnormal_vector(%arg0: vector<2xf16>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<6.103520e-05> : vector<2xf16>) : vector<2xf16>
    %1 = llvm.intr.fabs(%arg0)  : (vector<2xf16>) -> vector<2xf16>
    %2 = llvm.fcmp "olt" %1, %0 : vector<2xf16>
    %3 = "llvm.intr.is.fpclass"(%arg0) <{bit = 504 : i32}> : (vector<2xf16>) -> vector<2xi1>
    %4 = llvm.or %3, %2  : vector<2xi1>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @fcmp_oeq_zero_or_class_normal(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "oeq" %arg0, %0 : f16
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f16) -> i1
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @fcmp_oeq_zero_or_class_normal_daz(%arg0: f16) -> i1 attributes {passthrough = [["denormal-fp-math", "ieee,preserve-sign"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "oeq" %arg0, %0 : f16
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f16) -> i1
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @fcmp_oeq_zero_or_class_normal_daz_v2f16(%arg0: vector<2xf16>) -> vector<2xi1> attributes {passthrough = [["denormal-fp-math", "ieee,preserve-sign"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf16>) : vector<2xf16>
    %2 = llvm.fcmp "oeq" %arg0, %1 : vector<2xf16>
    %3 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (vector<2xf16>) -> vector<2xi1>
    %4 = llvm.or %2, %3  : vector<2xi1>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @fcmp_oeq_zero_or_class_normal_dynamic(%arg0: f16) -> i1 attributes {passthrough = [["denormal-fp-math", "ieee,dynamic"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "oeq" %arg0, %0 : f16
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f16) -> i1
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @fcmp_oeq_zero_or_class_normal_dynamic_v2f16(%arg0: vector<2xf16>) -> vector<2xi1> attributes {passthrough = [["denormal-fp-math", "ieee,dynamic"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf16>) : vector<2xf16>
    %2 = llvm.fcmp "oeq" %arg0, %1 : vector<2xf16>
    %3 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (vector<2xf16>) -> vector<2xi1>
    %4 = llvm.or %2, %3  : vector<2xi1>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @class_normal_or_fcmp_oeq_zero(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "oeq" %arg0, %0 : f16
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f16) -> i1
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @fcmp_ueq_zero_or_class_normal(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ueq" %arg0, %0 : f16
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f16) -> i1
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @class_normal_or_fcmp_ueq_zero(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ueq" %arg0, %0 : f16
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f16) -> i1
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @fcmp_one_zero_or_class_normal(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "one" %arg0, %0 : f16
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f16) -> i1
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @fcmp_one_zero_or_class_normal_daz(%arg0: f16) -> i1 attributes {passthrough = [["denormal-fp-math", "ieee,preserve-sign"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "one" %arg0, %0 : f16
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f16) -> i1
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @fcmp_one_zero_or_class_normal_dynamic(%arg0: f16) -> i1 attributes {passthrough = [["denormal-fp-math", "ieee,dynamic"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "one" %arg0, %0 : f16
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f16) -> i1
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @class_normal_or_fcmp_one_zero(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "one" %arg0, %0 : f16
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f16) -> i1
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @fcmp_une_zero_or_class_normal(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "une" %arg0, %0 : f16
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f16) -> i1
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @class_normal_or_fcmp_une_zero(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "une" %arg0, %0 : f16
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f16) -> i1
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @class_normal_or_fcmp_une_zero_daz(%arg0: f16) -> i1 attributes {passthrough = [["denormal-fp-math", "ieee,preserve-sign"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "une" %arg0, %0 : f16
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f16) -> i1
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @class_normal_or_fcmp_une_zero_dynamic(%arg0: f16) -> i1 attributes {passthrough = [["denormal-fp-math", "ieee,dynamic"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "une" %arg0, %0 : f16
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f16) -> i1
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @fcmp_oeq_inf_xor_class_normal(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0x7C00 : f16) : f16
    %1 = llvm.fcmp "oeq" %arg0, %0 : f16
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f16) -> i1
    %3 = llvm.xor %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @class_normal_xor_fcmp_oeq_inf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0x7C00 : f16) : f16
    %1 = llvm.fcmp "oeq" %arg0, %0 : f16
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f16) -> i1
    %3 = llvm.xor %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @llvm.canonicalize.f16(f16) -> f16 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nocallback", "nofree", "nosync", "nounwind", "speculatable", "willreturn"]}
}
