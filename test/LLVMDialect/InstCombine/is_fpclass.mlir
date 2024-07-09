module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test_class_no_mask_f32(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 0 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_full_mask_f32(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1023 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_undef_no_mask_f32() -> i1 {
    %0 = llvm.mlir.undef : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 0 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_undef_full_mask_f32() -> i1 {
    %0 = llvm.mlir.undef : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 1023 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_poison_no_mask_f32() -> i1 {
    %0 = llvm.mlir.poison : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 0 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_poison_full_mask_f32() -> i1 {
    %0 = llvm.mlir.poison : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 1023 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_undef_val_f32() -> i1 {
    %0 = llvm.mlir.undef : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 4 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_poison_val_f32() -> i1 {
    %0 = llvm.mlir.poison : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 4 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_isnan_f32(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 3 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_isnan_v2f32(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 3 : i32}> : (vector<2xf32>) -> vector<2xi1>
    llvm.return %0 : vector<2xi1>
  }
  llvm.func @test_class_isnan_f32_strict(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 3 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_p0_n0_f32(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 96 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_p0_n0_v2f32(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 96 : i32}> : (vector<2xf32>) -> vector<2xi1>
    llvm.return %0 : vector<2xi1>
  }
  llvm.func @test_class_is_p0_n0_v2f32_daz(%arg0: vector<2xf32>) -> vector<2xi1> attributes {passthrough = [["denormal-fp-math-f32", "ieee,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 96 : i32}> : (vector<2xf32>) -> vector<2xi1>
    llvm.return %0 : vector<2xi1>
  }
  llvm.func @test_class_is_p0_n0_v2f32_dynamic(%arg0: vector<2xf32>) -> vector<2xi1> attributes {passthrough = [["denormal-fp-math-f32", "ieee,dynamic"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 96 : i32}> : (vector<2xf32>) -> vector<2xi1>
    llvm.return %0 : vector<2xi1>
  }
  llvm.func @test_class_is_p0_n0_or_nan_f32(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 99 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_p0_n0_or_nan_v2f32(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 99 : i32}> : (vector<2xf32>) -> vector<2xi1>
    llvm.return %0 : vector<2xi1>
  }
  llvm.func @test_class_is_p0_n0_or_nan_f32_daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math-f32", "ieee,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 99 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_p0_n0_or_nan_v2f32_daz(%arg0: vector<2xf32>) -> vector<2xi1> attributes {passthrough = [["denormal-fp-math-f32", "ieee,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 99 : i32}> : (vector<2xf32>) -> vector<2xi1>
    llvm.return %0 : vector<2xi1>
  }
  llvm.func @test_class_is_p0_n0_or_sub_or_nan_f32(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 243 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_p0_n0_or_sub_or_nan_v2f32(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 243 : i32}> : (vector<2xf32>) -> vector<2xi1>
    llvm.return %0 : vector<2xi1>
  }
  llvm.func @test_class_is_p0_n0_or_sub_or_nan_f32_daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math-f32", "ieee,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 243 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_p0_n0_or_sub_or_nan_v2f32_daz(%arg0: vector<2xf32>) -> vector<2xi1> attributes {passthrough = [["denormal-fp-math-f32", "ieee,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 243 : i32}> : (vector<2xf32>) -> vector<2xi1>
    llvm.return %0 : vector<2xi1>
  }
  llvm.func @test_class_is_p0_n0_or_sub_or_snan_f32_daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math-f32", "ieee,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 241 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_p0_n0_or_sub_or_qnan_f32_daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math-f32", "ieee,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 242 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_p0_n0_or_nan_f32(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 924 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_p0_n0_or_qnan_f32(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 926 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_p0_n0_or_snan_f32(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 925 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_p0_n0_or_nan_f32_daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math-f32", "ieee,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 924 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_p0_n0_or_sub_or_nan_f32(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 783 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_p0_n0_or_sub_or_nan_f32_daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math-f32", "ieee,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 783 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_p0_n0_or_sub_and_not_nan_f32(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 780 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_p0_n0_or_sub_and_not_nan_f32_daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math-f32", "ieee,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 780 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_p0_n0_f32(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 927 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_p0_n0_v2f32(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 927 : i32}> : (vector<2xf32>) -> vector<2xi1>
    llvm.return %0 : vector<2xi1>
  }
  llvm.func @test_class_is_not_p0_n0_f32_strict(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 927 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_p0_n0_f32_daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "ieee,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 927 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_p0_n0_f32_dynamic(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "ieee,dynamic"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 927 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_p0_n0_psub_nsub_f32_daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "ieee,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 783 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_p0_n0_psub_nsub_f32_dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "ieee,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 783 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_p0_n0_psub_nsub_f32_dynamic(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "ieee,dynamiz"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 783 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_p0_n0_f32_strict(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 96 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_p0_n0_f32_daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "ieee,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 96 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_p0_n0_f32_dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "ieee,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 96 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_p0_n0_psub_nsub_f32(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 240 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_p0_n0_psub_nsub_f32_daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "ieee,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 240 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_p0_n0_psub_nsub_f32_dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "ieee,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 240 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_p0_n0_psub_nsub_f32_dynamic(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "ieee,dynamic"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 240 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_p0_n0_psub_nsub_v2f32(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 240 : i32}> : (vector<2xf32>) -> vector<2xi1>
    llvm.return %0 : vector<2xi1>
  }
  llvm.func @test_class_is_p0_n0_psub_nsub_v2f32_daz(%arg0: vector<2xf32>) -> vector<2xi1> attributes {passthrough = [["denormal-fp-math", "ieee,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 240 : i32}> : (vector<2xf32>) -> vector<2xi1>
    llvm.return %0 : vector<2xi1>
  }
  llvm.func @test_class_is_p0_n0_psub_nsub_v2f32_dapz(%arg0: vector<2xf32>) -> vector<2xi1> attributes {passthrough = [["denormal-fp-math", "ieee,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 240 : i32}> : (vector<2xf32>) -> vector<2xi1>
    llvm.return %0 : vector<2xi1>
  }
  llvm.func @test_class_is_p0_n0_psub_nsub_v2f32_dynamic(%arg0: vector<2xf32>) -> vector<2xi1> attributes {passthrough = [["denormal-fp-math", "ieee,dynamic"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 240 : i32}> : (vector<2xf32>) -> vector<2xi1>
    llvm.return %0 : vector<2xi1>
  }
  llvm.func @test_class_is_pinf_f32(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 512 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_pinf_or_nan_f32(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 515 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_pinf_v2f32(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 512 : i32}> : (vector<2xf32>) -> vector<2xi1>
    llvm.return %0 : vector<2xi1>
  }
  llvm.func @test_class_is_ninf_f32(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 4 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_ninf_or_nan_f32(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 7 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_ninf_v2f32(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 4 : i32}> : (vector<2xf32>) -> vector<2xi1>
    llvm.return %0 : vector<2xi1>
  }
  llvm.func @test_class_is_inf_f32(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 516 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_inf_v2f32(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 516 : i32}> : (vector<2xf32>) -> vector<2xi1>
    llvm.return %0 : vector<2xi1>
  }
  llvm.func @test_class_is_inf_or_nan_f32(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 519 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_pinf_f32_strict(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 512 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_ninf_f32_strict(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 4 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_inf_f32_strict(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 516 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_pinf_or_nan_f32_strict(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 515 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_ninf_or_nan_f32_strict(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 7 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_inf_or_nan_f32_strict(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 519 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_constant_class_snan_test_snan_f64() -> i1 {
    %0 = llvm.mlir.constant(0x7FF0000000000001 : f64) : f64
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 1 : i32}> : (f64) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_constant_class_qnan_test_qnan_f64() -> i1 {
    %0 = llvm.mlir.constant(0x7FF8000000000000 : f64) : f64
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 2 : i32}> : (f64) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_constant_class_qnan_test_snan_f64() -> i1 {
    %0 = llvm.mlir.constant(0x7FF8000000000000 : f64) : f64
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 1 : i32}> : (f64) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_constant_class_ninf_test_ninf_f64() -> i1 {
    %0 = llvm.mlir.constant(0xFFF0000000000000 : f64) : f64
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 4 : i32}> : (f64) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_constant_class_pinf_test_ninf_f64() -> i1 {
    %0 = llvm.mlir.constant(0x7FF0000000000000 : f64) : f64
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 4 : i32}> : (f64) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_constant_class_qnan_test_ninf_f64() -> i1 {
    %0 = llvm.mlir.constant(0x7FF8000000000000 : f64) : f64
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 4 : i32}> : (f64) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_constant_class_snan_test_ninf_f64() -> i1 {
    %0 = llvm.mlir.constant(0x7FF0000000000001 : f64) : f64
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 4 : i32}> : (f64) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_constant_class_nnormal_test_nnormal_f64() -> i1 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f64) : f64
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 8 : i32}> : (f64) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_constant_class_pnormal_test_nnormal_f64() -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 8 : i32}> : (f64) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_constant_class_nsubnormal_test_nsubnormal_f64() -> i1 {
    %0 = llvm.mlir.constant(-2.2250738585072009E-308 : f64) : f64
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 16 : i32}> : (f64) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_constant_class_psubnormal_test_nsubnormal_f64() -> i1 {
    %0 = llvm.mlir.constant(2.2250738585072009E-308 : f64) : f64
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 16 : i32}> : (f64) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_constant_class_nzero_test_nzero_f64() -> i1 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 32 : i32}> : (f64) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_constant_class_pzero_test_nzero_f64() -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 32 : i32}> : (f64) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_constant_class_pzero_test_pzero_f64() -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 64 : i32}> : (f64) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_constant_class_nzero_test_pzero_f64() -> i1 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 64 : i32}> : (f64) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_constant_class_psubnormal_test_psubnormal_f64() -> i1 {
    %0 = llvm.mlir.constant(2.2250738585072009E-308 : f64) : f64
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 128 : i32}> : (f64) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_constant_class_nsubnormal_test_psubnormal_f64() -> i1 {
    %0 = llvm.mlir.constant(-2.2250738585072009E-308 : f64) : f64
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 128 : i32}> : (f64) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_constant_class_pnormal_test_pnormal_f64() -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 256 : i32}> : (f64) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_constant_class_nnormal_test_pnormal_f64() -> i1 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f64) : f64
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 256 : i32}> : (f64) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_constant_class_pinf_test_pinf_f64() -> i1 {
    %0 = llvm.mlir.constant(0x7FF0000000000000 : f64) : f64
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 512 : i32}> : (f64) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_constant_class_ninf_test_pinf_f64() -> i1 {
    %0 = llvm.mlir.constant(0xFFF0000000000000 : f64) : f64
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 512 : i32}> : (f64) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_constant_class_qnan_test_pinf_f64() -> i1 {
    %0 = llvm.mlir.constant(0x7FF8000000000000 : f64) : f64
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 512 : i32}> : (f64) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_constant_class_snan_test_pinf_f64() -> i1 {
    %0 = llvm.mlir.constant(0x7FF0000000000001 : f64) : f64
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 512 : i32}> : (f64) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_is_snan_nnan_src(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan>} : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 1 : i32}> : (f32) -> i1
    llvm.return %2 : i1
  }
  llvm.func @test_class_is_qnan_nnan_src(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan>} : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 2 : i32}> : (f32) -> i1
    llvm.return %2 : i1
  }
  llvm.func @test_class_is_nan_nnan_src(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan>} : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 3 : i32}> : (f32) -> i1
    llvm.return %2 : i1
  }
  llvm.func @test_class_is_nan_other_nnan_src(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan>} : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 267 : i32}> : (f32) -> i1
    llvm.return %2 : i1
  }
  llvm.func @test_class_is_not_nan_nnan_src(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan>} : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 1020 : i32}> : (f32) -> i1
    llvm.return %2 : i1
  }
  llvm.func @test_class_is_not_nan_nnan_src_strict(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan>} : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 1020 : i32}> : (f32) -> i1
    llvm.return %2 : i1
  }
  llvm.func @test_class_is_ninf_pinf_ninf_src(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<ninf>} : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 516 : i32}> : (f32) -> i1
    llvm.return %2 : i1
  }
  llvm.func @test_class_is_ninf_ninf_src(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<ninf>} : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 4 : i32}> : (f32) -> i1
    llvm.return %2 : i1
  }
  llvm.func @test_class_is_pinf_ninf_src(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<ninf>} : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 512 : i32}> : (f32) -> i1
    llvm.return %2 : i1
  }
  llvm.func @test_class_is_ninf_pinf_pnormal_ninf_src(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<ninf>} : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 772 : i32}> : (f32) -> i1
    llvm.return %2 : i1
  }
  llvm.func @test_class_is_not_inf_ninf_src(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<ninf>} : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 507 : i32}> : (f32) -> i1
    llvm.return %2 : i1
  }
  llvm.func @test_class_is_not_inf_ninf_src_strict(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<ninf>} : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 507 : i32}> : (f32) -> i1
    llvm.return %2 : i1
  }
  llvm.func @test_class_not_is_nan(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 3 : i32}> : (f32) -> i1
    %2 = llvm.xor %1, %0  : i1
    llvm.return %2 : i1
  }
  llvm.func @test_class_not_is_nan_multi_use(%arg0: f32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 3 : i32}> : (f32) -> i1
    llvm.store %1, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr
    %2 = llvm.xor %1, %0  : i1
    llvm.return %2 : i1
  }
  llvm.func @test_class_not_is_inf_nan(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 519 : i32}> : (f32) -> i1
    %2 = llvm.xor %1, %0  : i1
    llvm.return %2 : i1
  }
  llvm.func @test_class_not_is_normal(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f32) -> i1
    %2 = llvm.xor %1, %0  : i1
    llvm.return %2 : i1
  }
  llvm.func @test_class_xor_false(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 33 : i32}> : (f32) -> i1
    %2 = llvm.xor %1, %0  : i1
    llvm.return %2 : i1
  }
  llvm.func @test_class_not_vector(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 33 : i32}> : (vector<2xf32>) -> vector<2xi1>
    %3 = llvm.xor %2, %1  : vector<2xi1>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @test_class_xor_vector(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(dense<[true, false]> : vector<2xi1>) : vector<2xi1>
    %3 = "llvm.intr.is.fpclass"(%arg0) <{bit = 33 : i32}> : (vector<2xf32>) -> vector<2xi1>
    %4 = llvm.xor %3, %2  : vector<2xi1>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @test_fold_or_class_f32_0(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1 : i32}> : (f32) -> i1
    %2 = llvm.fcmp "uno" %arg0, %0 : f32
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @test_fold_or3_class_f32_0(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1 : i32}> : (f32) -> i1
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 2 : i32}> : (f32) -> i1
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 4 : i32}> : (f32) -> i1
    %3 = llvm.or %0, %1  : i1
    %4 = llvm.or %3, %2  : i1
    llvm.return %4 : i1
  }
  llvm.func @test_fold_or_all_tests_class_f32_0(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1 : i32}> : (f32) -> i1
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 2 : i32}> : (f32) -> i1
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 4 : i32}> : (f32) -> i1
    %3 = "llvm.intr.is.fpclass"(%arg0) <{bit = 8 : i32}> : (f32) -> i1
    %4 = "llvm.intr.is.fpclass"(%arg0) <{bit = 16 : i32}> : (f32) -> i1
    %5 = "llvm.intr.is.fpclass"(%arg0) <{bit = 32 : i32}> : (f32) -> i1
    %6 = "llvm.intr.is.fpclass"(%arg0) <{bit = 64 : i32}> : (f32) -> i1
    %7 = "llvm.intr.is.fpclass"(%arg0) <{bit = 128 : i32}> : (f32) -> i1
    %8 = "llvm.intr.is.fpclass"(%arg0) <{bit = 256 : i32}> : (f32) -> i1
    %9 = "llvm.intr.is.fpclass"(%arg0) <{bit = 512 : i32}> : (f32) -> i1
    %10 = llvm.or %0, %1  : i1
    %11 = llvm.or %10, %2  : i1
    %12 = llvm.or %11, %3  : i1
    %13 = llvm.or %12, %4  : i1
    %14 = llvm.or %13, %5  : i1
    %15 = llvm.or %14, %6  : i1
    %16 = llvm.or %15, %7  : i1
    %17 = llvm.or %16, %8  : i1
    %18 = llvm.or %17, %9  : i1
    llvm.return %18 : i1
  }
  llvm.func @test_fold_or_class_f32_1(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 4 : i32}> : (f32) -> i1
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 8 : i32}> : (f32) -> i1
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @test_no_fold_or_class_f32_multi_use0(%arg0: f32, %arg1: !llvm.ptr) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 4 : i32}> : (f32) -> i1
    llvm.store %0, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 8 : i32}> : (f32) -> i1
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @test_no_fold_or_class_f32_multi_use1(%arg0: f32, %arg1: !llvm.ptr) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 4 : i32}> : (f32) -> i1
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 8 : i32}> : (f32) -> i1
    llvm.store %1, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @test_fold_or_class_f32_2(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 7 : i32}> : (f32) -> i1
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 7 : i32}> : (f32) -> i1
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @test_no_fold_or_class_f32_0(%arg0: f32, %arg1: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 4 : i32}> : (f32) -> i1
    %1 = "llvm.intr.is.fpclass"(%arg1) <{bit = 8 : i32}> : (f32) -> i1
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @test_fold_or_class_v2f32(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 4 : i32}> : (vector<2xf32>) -> vector<2xi1>
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 8 : i32}> : (vector<2xf32>) -> vector<2xi1>
    %2 = llvm.or %0, %1  : vector<2xi1>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @test_fold_and_class_f32_0(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1 : i32}> : (f32) -> i1
    %2 = llvm.fcmp "uno" %arg0, %0 : f32
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @test_fold_and3_class_f32_0(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 3 : i32}> : (f32) -> i1
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 2 : i32}> : (f32) -> i1
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 7 : i32}> : (f32) -> i1
    %3 = llvm.and %0, %1  : i1
    %4 = llvm.and %3, %2  : i1
    llvm.return %4 : i1
  }
  llvm.func @test_fold_and_all_tests_class_f32_0(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1 : i32}> : (f32) -> i1
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 2 : i32}> : (f32) -> i1
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 4 : i32}> : (f32) -> i1
    %3 = "llvm.intr.is.fpclass"(%arg0) <{bit = 8 : i32}> : (f32) -> i1
    %4 = "llvm.intr.is.fpclass"(%arg0) <{bit = 16 : i32}> : (f32) -> i1
    %5 = "llvm.intr.is.fpclass"(%arg0) <{bit = 32 : i32}> : (f32) -> i1
    %6 = "llvm.intr.is.fpclass"(%arg0) <{bit = 64 : i32}> : (f32) -> i1
    %7 = "llvm.intr.is.fpclass"(%arg0) <{bit = 128 : i32}> : (f32) -> i1
    %8 = "llvm.intr.is.fpclass"(%arg0) <{bit = 256 : i32}> : (f32) -> i1
    %9 = "llvm.intr.is.fpclass"(%arg0) <{bit = 512 : i32}> : (f32) -> i1
    %10 = llvm.and %0, %1  : i1
    %11 = llvm.and %10, %2  : i1
    %12 = llvm.and %11, %3  : i1
    %13 = llvm.and %12, %4  : i1
    %14 = llvm.and %13, %5  : i1
    %15 = llvm.and %14, %6  : i1
    %16 = llvm.and %15, %7  : i1
    %17 = llvm.and %16, %8  : i1
    %18 = llvm.and %17, %9  : i1
    llvm.return %18 : i1
  }
  llvm.func @test_fold_and_not_all_tests_class_f32_0(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1022 : i32}> : (f32) -> i1
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1021 : i32}> : (f32) -> i1
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1019 : i32}> : (f32) -> i1
    %3 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1015 : i32}> : (f32) -> i1
    %4 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1007 : i32}> : (f32) -> i1
    %5 = "llvm.intr.is.fpclass"(%arg0) <{bit = 991 : i32}> : (f32) -> i1
    %6 = "llvm.intr.is.fpclass"(%arg0) <{bit = 959 : i32}> : (f32) -> i1
    %7 = "llvm.intr.is.fpclass"(%arg0) <{bit = 895 : i32}> : (f32) -> i1
    %8 = "llvm.intr.is.fpclass"(%arg0) <{bit = 767 : i32}> : (f32) -> i1
    %9 = "llvm.intr.is.fpclass"(%arg0) <{bit = 511 : i32}> : (f32) -> i1
    %10 = llvm.and %0, %1  : i1
    %11 = llvm.and %10, %2  : i1
    %12 = llvm.and %11, %3  : i1
    %13 = llvm.and %12, %4  : i1
    %14 = llvm.and %13, %5  : i1
    %15 = llvm.and %14, %6  : i1
    %16 = llvm.and %15, %7  : i1
    %17 = llvm.and %16, %8  : i1
    %18 = llvm.and %17, %9  : i1
    llvm.return %18 : i1
  }
  llvm.func @test_fold_and_class_f32_1(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 48 : i32}> : (f32) -> i1
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 11 : i32}> : (f32) -> i1
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @test_no_fold_and_class_f32_multi_use0(%arg0: f32, %arg1: !llvm.ptr) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 15 : i32}> : (f32) -> i1
    llvm.store %0, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 8 : i32}> : (f32) -> i1
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @test_no_fold_and_class_f32_multi_use1(%arg0: f32, %arg1: !llvm.ptr) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 15 : i32}> : (f32) -> i1
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 8 : i32}> : (f32) -> i1
    llvm.store %1, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @test_fold_and_class_f32_2(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 7 : i32}> : (f32) -> i1
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 7 : i32}> : (f32) -> i1
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @test_fold_and_class_f32_3(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 37 : i32}> : (f32) -> i1
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 393 : i32}> : (f32) -> i1
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @test_fold_and_class_f32_4(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 393 : i32}> : (f32) -> i1
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 37 : i32}> : (f32) -> i1
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @test_no_fold_and_class_f32_0(%arg0: f32, %arg1: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 7 : i32}> : (f32) -> i1
    %1 = "llvm.intr.is.fpclass"(%arg1) <{bit = 15 : i32}> : (f32) -> i1
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @test_fold_and_class_v2f32(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 7 : i32}> : (vector<2xf32>) -> vector<2xi1>
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 15 : i32}> : (vector<2xf32>) -> vector<2xi1>
    %2 = llvm.and %0, %1  : vector<2xi1>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @test_fold_xor_class_f32_0(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1 : i32}> : (f32) -> i1
    %2 = llvm.fcmp "uno" %arg0, %0 : f32
    %3 = llvm.xor %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @test_fold_xor3_class_f32_0(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1 : i32}> : (f32) -> i1
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 2 : i32}> : (f32) -> i1
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 4 : i32}> : (f32) -> i1
    %3 = llvm.xor %0, %1  : i1
    %4 = llvm.xor %3, %2  : i1
    llvm.return %4 : i1
  }
  llvm.func @test_fold_xor_all_tests_class_f32_0(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1 : i32}> : (f32) -> i1
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 2 : i32}> : (f32) -> i1
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 4 : i32}> : (f32) -> i1
    %3 = "llvm.intr.is.fpclass"(%arg0) <{bit = 8 : i32}> : (f32) -> i1
    %4 = "llvm.intr.is.fpclass"(%arg0) <{bit = 16 : i32}> : (f32) -> i1
    %5 = "llvm.intr.is.fpclass"(%arg0) <{bit = 32 : i32}> : (f32) -> i1
    %6 = "llvm.intr.is.fpclass"(%arg0) <{bit = 64 : i32}> : (f32) -> i1
    %7 = "llvm.intr.is.fpclass"(%arg0) <{bit = 128 : i32}> : (f32) -> i1
    %8 = "llvm.intr.is.fpclass"(%arg0) <{bit = 256 : i32}> : (f32) -> i1
    %9 = "llvm.intr.is.fpclass"(%arg0) <{bit = 512 : i32}> : (f32) -> i1
    %10 = llvm.xor %0, %1  : i1
    %11 = llvm.xor %10, %2  : i1
    %12 = llvm.xor %11, %3  : i1
    %13 = llvm.xor %12, %4  : i1
    %14 = llvm.xor %13, %5  : i1
    %15 = llvm.xor %14, %6  : i1
    %16 = llvm.xor %15, %7  : i1
    %17 = llvm.xor %16, %8  : i1
    %18 = llvm.xor %17, %9  : i1
    llvm.return %18 : i1
  }
  llvm.func @test_fold_xor_class_f32_1(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 4 : i32}> : (f32) -> i1
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 8 : i32}> : (f32) -> i1
    %2 = llvm.xor %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @test_no_fold_xor_class_f32_multi_use0(%arg0: f32, %arg1: !llvm.ptr) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 4 : i32}> : (f32) -> i1
    llvm.store %0, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 8 : i32}> : (f32) -> i1
    %2 = llvm.xor %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @test_no_fold_xor_class_f32_multi_use1(%arg0: f32, %arg1: !llvm.ptr) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 4 : i32}> : (f32) -> i1
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 8 : i32}> : (f32) -> i1
    llvm.store %1, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr
    %2 = llvm.xor %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @test_fold_xor_class_f32_2(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 7 : i32}> : (f32) -> i1
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 7 : i32}> : (f32) -> i1
    %2 = llvm.xor %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @test_no_fold_xor_class_f32_0(%arg0: f32, %arg1: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 4 : i32}> : (f32) -> i1
    %1 = "llvm.intr.is.fpclass"(%arg1) <{bit = 8 : i32}> : (f32) -> i1
    %2 = llvm.xor %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @test_fold_xor_class_v2f32(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 4 : i32}> : (vector<2xf32>) -> vector<2xi1>
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 13 : i32}> : (vector<2xf32>) -> vector<2xi1>
    %2 = llvm.xor %0, %1  : vector<2xi1>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @test_class_fneg_none(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 0 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_fneg_all(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 1023 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_fneg_snan(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 1 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_fneg_qnan(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 2 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_fneg_neginf(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 4 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_fneg_negnormal(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 8 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_fneg_negsubnormal(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 16 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_fneg_negzero(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 32 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_fneg_poszero(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 64 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_fneg_possubnormal(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 128 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_fneg_posnormal(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 256 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_fneg_posinf(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 512 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_fneg_isnan(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 3 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_fneg_nnan(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 1020 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_fneg_normal(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 264 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_fneg_zero(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 96 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_fneg_subnormal(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 144 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_fneg_normal_neginf(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 268 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_fneg_normal_pinf(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 776 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_fneg_neginf_posnormal_negsubnormal_poszero(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 340 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_fneg_neginf_posnormal_negsubnormal_poszero_snan(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 341 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_fneg_neginf_posnormal_negsubnormal_poszero_qnan(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 342 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_fneg_neginf_posnormal_negsubnormal_poszero_nan(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 343 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_fneg_posinf_negnormal_possubnormal_negzero(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 680 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_fneg_posinf_negnormal_possubnormal_negzero_snan(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 681 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_fneg_posinf_negnormal_possubnormal_negzero_qnan(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 682 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_fneg_posinf_negnormal_possubnormal_negzero_nan(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 683 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_fneg_posinf_negnormal_possubnormal_negzero_snan_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.fneg %arg0  : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 681 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_fneg_multiple_use_fneg(%arg0: f32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    llvm.store %0, %arg1 {alignment = 4 : i64} : f32, !llvm.ptr
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 682 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_fneg_posinf_negnormal_possubnormal_negzero_nan_vector(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.fneg %arg0  : vector<2xf32>
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 683 : i32}> : (vector<2xf32>) -> vector<2xi1>
    llvm.return %1 : vector<2xi1>
  }
  llvm.func @test_class_fabs_none(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 0 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_fabs_all(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 1023 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_fabs_snan(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 1 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_fabs_qnan(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 2 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_fabs_neginf(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 4 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_fabs_negnormal(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 8 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_fabs_negsubnormal(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 16 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_fabs_negzero(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 32 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_fabs_poszero(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 64 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_fabs_possubnormal(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 128 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_fabs_posnormal(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 256 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_fabs_posinf(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 512 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_fabs_isnan(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 3 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_fabs_nnan(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 1020 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_fabs_normal(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 264 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_fabs_zero(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 96 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_fabs_subnormal(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 144 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_fabs_normal_neginf(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 268 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_fabs_normal_pinf(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 776 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_fabs_neginf_posnormal_negsubnormal_poszero(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 340 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_fabs_neginf_posnormal_negsubnormal_poszero_snan(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 341 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_fabs_neginf_posnormal_negsubnormal_poszero_qnan(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 342 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_fabs_neginf_posnormal_negsubnormal_poszero_nan(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 343 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_fabs_posinf_negnormal_possubnormal_negzero(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 680 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_fabs_posinf_negnormal_possubnormal_negzero_snan(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 681 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_fabs_posinf_negnormal_possubnormal_negzero_qnan(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 682 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_fabs_posinf_negnormal_possubnormal_negzero_nan(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 683 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_fabs_posinf_negnormal_possubnormal_negzero_snan_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 681 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_fabs_multiple_use_fabs(%arg0: f32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    llvm.store %0, %arg1 {alignment = 4 : i64} : f32, !llvm.ptr
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 682 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_fabs_posinf_negnormal_possubnormal_negzero_nan_vector(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.intr.fabs(%arg0)  : (vector<2xf32>) -> vector<2xf32>
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 683 : i32}> : (vector<2xf32>) -> vector<2xi1>
    llvm.return %1 : vector<2xi1>
  }
  llvm.func @test_class_fneg_fabs_none(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 0 : i32}> : (f32) -> i1
    llvm.return %2 : i1
  }
  llvm.func @test_class_fneg_fabs_all(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 1023 : i32}> : (f32) -> i1
    llvm.return %2 : i1
  }
  llvm.func @test_class_fneg_fabs_snan(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 1 : i32}> : (f32) -> i1
    llvm.return %2 : i1
  }
  llvm.func @test_class_fneg_fabs_qnan(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 2 : i32}> : (f32) -> i1
    llvm.return %2 : i1
  }
  llvm.func @test_class_fneg_fabs_neginf(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 4 : i32}> : (f32) -> i1
    llvm.return %2 : i1
  }
  llvm.func @test_class_fneg_fabs_negnormal(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 8 : i32}> : (f32) -> i1
    llvm.return %2 : i1
  }
  llvm.func @test_class_fneg_fabs_negsubnormal(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 16 : i32}> : (f32) -> i1
    llvm.return %2 : i1
  }
  llvm.func @test_class_fneg_fabs_negzero(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 32 : i32}> : (f32) -> i1
    llvm.return %2 : i1
  }
  llvm.func @test_class_fneg_fabs_poszero(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 64 : i32}> : (f32) -> i1
    llvm.return %2 : i1
  }
  llvm.func @test_class_fneg_fabs_possubnormal(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 128 : i32}> : (f32) -> i1
    llvm.return %2 : i1
  }
  llvm.func @test_class_fneg_fabs_posnormal(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 256 : i32}> : (f32) -> i1
    llvm.return %2 : i1
  }
  llvm.func @test_class_fneg_fabs_posinf(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 512 : i32}> : (f32) -> i1
    llvm.return %2 : i1
  }
  llvm.func @test_class_fneg_fabs_isnan(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 3 : i32}> : (f32) -> i1
    llvm.return %2 : i1
  }
  llvm.func @test_class_fneg_fabs_nnan(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 1020 : i32}> : (f32) -> i1
    llvm.return %2 : i1
  }
  llvm.func @test_class_fneg_fabs_normal(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 264 : i32}> : (f32) -> i1
    llvm.return %2 : i1
  }
  llvm.func @test_class_fneg_fabs_zero(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 96 : i32}> : (f32) -> i1
    llvm.return %2 : i1
  }
  llvm.func @test_class_fneg_fabs_subnormal(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 144 : i32}> : (f32) -> i1
    llvm.return %2 : i1
  }
  llvm.func @test_class_fneg_fabs_normal_neginf(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 268 : i32}> : (f32) -> i1
    llvm.return %2 : i1
  }
  llvm.func @test_class_fneg_fabs_normal_pinf(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 776 : i32}> : (f32) -> i1
    llvm.return %2 : i1
  }
  llvm.func @test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 340 : i32}> : (f32) -> i1
    llvm.return %2 : i1
  }
  llvm.func @test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero_snan(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 341 : i32}> : (f32) -> i1
    llvm.return %2 : i1
  }
  llvm.func @test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero_qnan(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 342 : i32}> : (f32) -> i1
    llvm.return %2 : i1
  }
  llvm.func @test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero_nan(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 343 : i32}> : (f32) -> i1
    llvm.return %2 : i1
  }
  llvm.func @test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 680 : i32}> : (f32) -> i1
    llvm.return %2 : i1
  }
  llvm.func @test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_snan(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 681 : i32}> : (f32) -> i1
    llvm.return %2 : i1
  }
  llvm.func @test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_qnan(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 682 : i32}> : (f32) -> i1
    llvm.return %2 : i1
  }
  llvm.func @test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_nan(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 683 : i32}> : (f32) -> i1
    llvm.return %2 : i1
  }
  llvm.func @test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_snan_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 681 : i32}> : (f32) -> i1
    llvm.return %2 : i1
  }
  llvm.func @test_class_fneg_fabs_multiple_use_fabs(%arg0: f32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    llvm.store %1, %arg1 {alignment = 4 : i64} : f32, !llvm.ptr
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 682 : i32}> : (f32) -> i1
    llvm.return %2 : i1
  }
  llvm.func @test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_nan_vector(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.intr.fabs(%arg0)  : (vector<2xf32>) -> vector<2xf32>
    %1 = llvm.fneg %0  : vector<2xf32>
    %2 = "llvm.intr.is.fpclass"(%0) <{bit = 683 : i32}> : (vector<2xf32>) -> vector<2xi1>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @test_class_is_zero_nozero_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 96 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_zero_noposzero_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 96 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_zero_nonegzero_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 96 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_pzero_nozero_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 64 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_pzero_nopzero_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 64 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_pzero_nonzero_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 64 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_nzero_nozero_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 32 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_nzero_nopzero_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 32 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_nzero_nonzero_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 32 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_normal_or_zero_nozero_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 360 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_inf_or_nan_nozero_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 519 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_inf_or_nan_noinf_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 519 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_inf_or_nan_nonan_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 519 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_normal_or_subnormal_noinf_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 408 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_neginf_or_nopinf_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 4 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_neginf_noninf_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 4 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_neginf_noinf_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 4 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_posinf_noninf_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 512 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_posinf_nopinf_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 512 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_posinf_noinf_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 512 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_subnormal_nosub_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 144 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_subnormal_nonsub_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 144 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_subnormal_nosub_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 879 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_negsubnormal_nosub_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1007 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_negsubnormal_nonegsub_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1007 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_nnormal_nonorm_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_nnormal_nonorm_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 759 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_nnormal_onlynorm_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 759 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_nnormal_onlynorm_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_normal_assume_normal(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f32) -> i1
    "llvm.intr.assume"(%0) : (i1) -> ()
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_is_normal_assume_not_normal(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f32) -> i1
    "llvm.intr.assume"(%0) : (i1) -> ()
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 759 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  }
  llvm.func @test_class_is_nan_assume_ord(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "ord" %arg0, %0 : f32
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 3 : i32}> : (f32) -> i1
    llvm.return %2 : i1
  }
  llvm.func @test_class_is_nan_assume_uno(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "uno" %arg0, %0 : f32
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 3 : i32}> : (f32) -> i1
    llvm.return %2 : i1
  }
  llvm.func @test_class_is_nan_assume_not_eq_pinf(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 3 : i32}> : (f32) -> i1
    llvm.return %2 : i1
  }
  llvm.func @test_class_is_pzero_psub_pnorm_pinf__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 960 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_pzero_psub_pnorm_pinf_snan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 961 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_pzero_psub_pnorm_pinf_qnan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 962 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_pzero_psub_pnorm_pinf_nan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 963 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_psub_pnorm_pinf__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 896 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_psub_pnorm_pinf_snan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 897 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_psub_pnorm_pinf_qnan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 898 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_psub_pnorm_pinf_nan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 899 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_pnorm_pinf__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 768 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_pzero_pnorm_pinf__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 704 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_pzero_pnorm_pinf_nan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 707 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_nzero_pzero_psub_pnorm_pinf__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 992 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_nzero_pzero_psub_pnorm_pinf_snan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 993 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_nzero_pzero_psub_pnorm_pinf_qnan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 994 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_nzero_pzero_psub_pnorm_pinf_nan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 995 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_nsub_nzero_pzero_psub_pnorm_pinf__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1017 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_snan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1009 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_qnan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1010 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_nan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1011 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_nzero_psub_pnorm_pinf__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 928 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_nzero_nsub_pnorm_pinf__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 816 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_pzero_psub_pnorm_pinf__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 63 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_pzero_psub_pnorm_pinf_snan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 62 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_pzero_psub_pnorm_pinf_qnan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 61 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_pzero_psub_pnorm_pinf_nan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 960 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_psub_pnorm_pinf__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 127 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_psub_pnorm_pinf_snan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 126 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_psub_pnorm_pinf_qnan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 125 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_psub_pnorm_pinf_nan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 124 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_pnorm_pinf__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 255 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_pzero_pnorm_pinf__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 319 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_pzero_pnorm_pinf_nan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 316 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_nzero_pzero_psub_pnorm_pinf__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 22 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_nzero_pzero_psub_pnorm_pinf_snan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 30 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_nzero_pzero_psub_pnorm_pinf_qnan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 29 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_nzero_pzero_psub_pnorm_pinf_nan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 28 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 6 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_snan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 14 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_qnan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 13 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_nan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 12 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_nzero_psub_pnorm_pinf__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 95 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_nzero_nsub_pnorm_pinf__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 207 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_pzero_psub_pnorm_pinf__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 960 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_pzero_psub_pnorm_pinf_snan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 961 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_pzero_psub_pnorm_pinf_qnan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 962 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_pzero_psub_pnorm_pinf_nan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 963 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_psub_pnorm_pinf__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 896 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_psub_pnorm_pinf_snan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 897 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_psub_pnorm_pinf_qnan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 898 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_psub_pnorm_pinf_nan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 899 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_pnorm_pinf__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 768 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_pzero_pnorm_pinf__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 704 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_pzero_pnorm_pinf_nan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 707 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_nzero_pzero_psub_pnorm_pinf__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 992 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_nzero_pzero_psub_pnorm_pinf_snan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 993 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_nzero_pzero_psub_pnorm_pinf_qnan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 994 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_nzero_pzero_psub_pnorm_pinf_nan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 995 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_nsub_nzero_pzero_psub_pnorm_pinf__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1017 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_snan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1009 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_qnan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1010 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_nan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1011 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_nzero_psub_pnorm_pinf__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 928 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_nzero_nsub_pnorm_pinf__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 816 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_pzero_psub_pnorm_pinf__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 63 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_pzero_psub_pnorm_pinf_snan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 62 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_pzero_psub_pnorm_pinf_qnan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 61 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_pzero_psub_pnorm_pinf_nan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 960 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_psub_pnorm_pinf__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 127 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_psub_pnorm_pinf_snan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 126 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_psub_pnorm_pinf_qnan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 125 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_psub_pnorm_pinf_nan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 124 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_pnorm_pinf__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 255 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_pzero_pnorm_pinf__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 319 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_pzero_pnorm_pinf_nan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 316 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_nzero_pzero_psub_pnorm_pinf__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 22 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_nzero_pzero_psub_pnorm_pinf_snan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 30 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_nzero_pzero_psub_pnorm_pinf_qnan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 29 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_nzero_pzero_psub_pnorm_pinf_nan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 28 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 6 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_snan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 14 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_qnan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 13 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_nan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 12 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_nzero_psub_pnorm_pinf__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 95 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_nzero_nsub_pnorm_pinf__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 207 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_pzero_psub_pnorm_pinf__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 960 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_pzero_psub_pnorm_pinf_snan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 961 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_pzero_psub_pnorm_pinf_qnan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 962 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_pzero_psub_pnorm_pinf_nan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 963 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_psub_pnorm_pinf__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 896 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_psub_pnorm_pinf_snan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 897 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_psub_pnorm_pinf_qnan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 898 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_psub_pnorm_pinf_nan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 899 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_pnorm_pinf__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 768 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_pzero_pnorm_pinf__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 704 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_pzero_pnorm_pinf_nan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 707 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_nzero_pzero_psub_pnorm_pinf__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 992 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_nzero_pzero_psub_pnorm_pinf_snan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 993 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_nzero_pzero_psub_pnorm_pinf_qnan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 994 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_nzero_pzero_psub_pnorm_pinf_nan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 995 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_nsub_nzero_pzero_psub_pnorm_pinf__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1017 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_snan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1009 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_qnan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1010 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_nan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1011 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_nzero_psub_pnorm_pinf__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 928 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_nzero_nsub_pnorm_pinf__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 816 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_pzero_psub_pnorm_pinf__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 63 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_pzero_psub_pnorm_pinf_snan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 62 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_pzero_psub_pnorm_pinf_qnan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 61 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_pzero_psub_pnorm_pinf_nan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 960 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_psub_pnorm_pinf__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 127 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_psub_pnorm_pinf_snan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 126 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_psub_pnorm_pinf_qnan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 125 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_psub_pnorm_pinf_nan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 124 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_pnorm_pinf__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 255 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_pzero_pnorm_pinf__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 319 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_pzero_pnorm_pinf_nan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 316 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_nzero_pzero_psub_pnorm_pinf__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 22 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_nzero_pzero_psub_pnorm_pinf_snan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 30 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_nzero_pzero_psub_pnorm_pinf_qnan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 29 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_nzero_pzero_psub_pnorm_pinf_nan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 28 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 6 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_snan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 14 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_qnan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 13 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_nan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 12 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_nzero_psub_pnorm_pinf__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 95 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_nzero_nsub_pnorm_pinf__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 207 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_psub_pnorm_pinf__dynamic(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,dynamic"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 896 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
  llvm.func @test_class_is_not_psub_pnorm_pinf__dynamic(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,dynamic"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 127 : i32}> : (f32) -> i1
    llvm.return %0 : i1
  }
}
