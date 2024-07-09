module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @f32_fcnan_fcinf(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(2139095040 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.and %1, %0  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    llvm.return %3 : i1
  }
  llvm.func @f32_fcnan_fcinf_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(2139095040 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.and %1, %0  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    llvm.return %3 : i1
  }
  llvm.func @f32_not_fcnan_fcinf(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(2139095040 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.and %1, %0  : i32
    %3 = llvm.icmp "ne" %2, %0 : i32
    llvm.return %3 : i1
  }
  llvm.func @f32_not_fcnan_fcinf_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(2139095040 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.and %1, %0  : i32
    %3 = llvm.icmp "ne" %2, %0 : i32
    llvm.return %3 : i1
  }
  llvm.func @f64_fcnan_fcinf(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(9218868437227405312 : i64) : i64
    %1 = llvm.bitcast %arg0 : f64 to i64
    %2 = llvm.and %1, %0  : i64
    %3 = llvm.icmp "eq" %2, %0 : i64
    llvm.return %3 : i1
  }
  llvm.func @f64_fcnan_fcinf_strictfp(%arg0: f64) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(9218868437227405312 : i64) : i64
    %1 = llvm.bitcast %arg0 : f64 to i64
    %2 = llvm.and %1, %0  : i64
    %3 = llvm.icmp "eq" %2, %0 : i64
    llvm.return %3 : i1
  }
  llvm.func @f32_fcinf(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(2139095040 : i32) : i32
    %2 = llvm.bitcast %arg0 : f32 to i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }
  llvm.func @f32_fcinf_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(2139095040 : i32) : i32
    %2 = llvm.bitcast %arg0 : f32 to i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }
  llvm.func @f32_fcposinf(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(2139095040 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @f32_fcposinf_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(2139095040 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @f32_fcneginf(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(-8388608 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @f32_fcneginf_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(-8388608 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @f32_fcposzero(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @f32_fcposzero_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @f32_fcnegzero(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @f32_fcnegzero_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @f32_fczero(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.bitcast %arg0 : f32 to i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }
  llvm.func @f32_fczero_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.bitcast %arg0 : f32 to i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }
  llvm.func @f32_fcnan(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(2139095040 : i32) : i32
    %1 = llvm.mlir.constant(8388607 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.bitcast %arg0 : f32 to i32
    %4 = llvm.and %3, %0  : i32
    %5 = llvm.icmp "eq" %4, %0 : i32
    %6 = llvm.and %3, %1  : i32
    %7 = llvm.icmp "ne" %6, %2 : i32
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }
  llvm.func @f32_fcnan_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(2139095040 : i32) : i32
    %1 = llvm.mlir.constant(8388607 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.bitcast %arg0 : f32 to i32
    %4 = llvm.and %3, %0  : i32
    %5 = llvm.icmp "eq" %4, %0 : i32
    %6 = llvm.and %3, %1  : i32
    %7 = llvm.icmp "ne" %6, %2 : i32
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }
  llvm.func @f32_fcnan_fcinf_vec(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<2139095040> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.bitcast %arg0 : vector<2xf32> to vector<2xi32>
    %2 = llvm.and %1, %0  : vector<2xi32>
    %3 = llvm.icmp "eq" %2, %0 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @f32_fcnan_fcinf_vec_strictfp(%arg0: vector<2xf32>) -> vector<2xi1> attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(dense<2139095040> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.bitcast %arg0 : vector<2xf32> to vector<2xi32>
    %2 = llvm.and %1, %0  : vector<2xi32>
    %3 = llvm.icmp "eq" %2, %0 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @f32_fcinf_vec(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<2147483647> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<2139095040> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.bitcast %arg0 : vector<2xf32> to vector<2xi32>
    %3 = llvm.and %2, %0  : vector<2xi32>
    %4 = llvm.icmp "eq" %3, %1 : vector<2xi32>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @f32_fcinf_vec_strictfp(%arg0: vector<2xf32>) -> vector<2xi1> attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(dense<2147483647> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<2139095040> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.bitcast %arg0 : vector<2xf32> to vector<2xi32>
    %3 = llvm.and %2, %0  : vector<2xi32>
    %4 = llvm.icmp "eq" %3, %1 : vector<2xi32>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @f32_fcnan_fcinf_wrong_mask1(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(2139095041 : i32) : i32
    %1 = llvm.mlir.constant(2139095040 : i32) : i32
    %2 = llvm.bitcast %arg0 : f32 to i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }
  llvm.func @f32_fcnan_fcinf_wrong_mask1_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(2139095041 : i32) : i32
    %1 = llvm.mlir.constant(2139095040 : i32) : i32
    %2 = llvm.bitcast %arg0 : f32 to i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }
  llvm.func @f32_fcnan_fcinf_wrong_mask2(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(2139095040 : i32) : i32
    %1 = llvm.mlir.constant(2130706432 : i32) : i32
    %2 = llvm.bitcast %arg0 : f32 to i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }
  llvm.func @f32_fcnan_fcinf_wrong_mask2_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(2139095040 : i32) : i32
    %1 = llvm.mlir.constant(2130706432 : i32) : i32
    %2 = llvm.bitcast %arg0 : f32 to i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }
  llvm.func @f64_fcnan_fcinf_wrong_mask3(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(2139095040 : i64) : i64
    %1 = llvm.bitcast %arg0 : f64 to i64
    %2 = llvm.and %1, %0  : i64
    %3 = llvm.icmp "eq" %2, %0 : i64
    llvm.return %3 : i1
  }
  llvm.func @f64_fcnan_fcinf_wrong_mask3_strictfp(%arg0: f64) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(2139095040 : i64) : i64
    %1 = llvm.bitcast %arg0 : f64 to i64
    %2 = llvm.and %1, %0  : i64
    %3 = llvm.icmp "eq" %2, %0 : i64
    llvm.return %3 : i1
  }
  llvm.func @f32_fcnan_fcinf_wrong_pred(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(2139095040 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.and %1, %0  : i32
    %3 = llvm.icmp "slt" %2, %0 : i32
    llvm.return %3 : i1
  }
  llvm.func @f32_fcnan_fcinf_wrong_pred_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(2139095040 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.and %1, %0  : i32
    %3 = llvm.icmp "slt" %2, %0 : i32
    llvm.return %3 : i1
  }
  llvm.func @f32_fcposzero_wrong_pred(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @f32_fcposzero_wrong_pred_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @f32_fcnan_fcinf_wrong_type1(%arg0: vector<2xf32>) -> i1 {
    %0 = llvm.mlir.constant(2139095040 : i64) : i64
    %1 = llvm.bitcast %arg0 : vector<2xf32> to i64
    %2 = llvm.and %1, %0  : i64
    %3 = llvm.icmp "eq" %2, %0 : i64
    llvm.return %3 : i1
  }
  llvm.func @f32_fcnan_fcinf_wrong_type1_strictfp(%arg0: vector<2xf32>) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(2139095040 : i64) : i64
    %1 = llvm.bitcast %arg0 : vector<2xf32> to i64
    %2 = llvm.and %1, %0  : i64
    %3 = llvm.icmp "eq" %2, %0 : i64
    llvm.return %3 : i1
  }
  llvm.func @f32_fcposinf_wrong_type1(%arg0: vector<2xf32>) -> i1 {
    %0 = llvm.mlir.constant(2139095040 : i64) : i64
    %1 = llvm.bitcast %arg0 : vector<2xf32> to i64
    %2 = llvm.icmp "eq" %1, %0 : i64
    llvm.return %2 : i1
  }
  llvm.func @f32_fcposinf_wrong_type1_strictfp(%arg0: vector<2xf32>) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(2139095040 : i64) : i64
    %1 = llvm.bitcast %arg0 : vector<2xf32> to i64
    %2 = llvm.icmp "eq" %1, %0 : i64
    llvm.return %2 : i1
  }
  llvm.func @f32_fcnan_fcinf_wrong_type2(%arg0: f80) -> i1 {
    %0 = llvm.mlir.constant(2139095040 : i80) : i80
    %1 = llvm.bitcast %arg0 : f80 to i80
    %2 = llvm.and %1, %0  : i80
    %3 = llvm.icmp "eq" %2, %0 : i80
    llvm.return %3 : i1
  }
  llvm.func @f32_fcnan_fcinf_wrong_type2_strictfp(%arg0: f80) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(2139095040 : i80) : i80
    %1 = llvm.bitcast %arg0 : f80 to i80
    %2 = llvm.and %1, %0  : i80
    %3 = llvm.icmp "eq" %2, %0 : i80
    llvm.return %3 : i1
  }
  llvm.func @f32_fcposzero_wrong_type2(%arg0: f80) -> i1 {
    %0 = llvm.mlir.constant(0 : i80) : i80
    %1 = llvm.bitcast %arg0 : f80 to i80
    %2 = llvm.icmp "eq" %1, %0 : i80
    llvm.return %2 : i1
  }
  llvm.func @f32_fcposzero_wrong_type2_strictfp(%arg0: f80) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(0 : i80) : i80
    %1 = llvm.bitcast %arg0 : f80 to i80
    %2 = llvm.icmp "eq" %1, %0 : i80
    llvm.return %2 : i1
  }
  llvm.func @f32_fcnan_fcinf_noimplicitfloat(%arg0: f32) -> i1 attributes {passthrough = ["noimplicitfloat"]} {
    %0 = llvm.mlir.constant(2139095040 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.and %1, %0  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    llvm.return %3 : i1
  }
  llvm.func @f32_fcnan_fcinf_noimplicitfloat_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["noimplicitfloat", "strictfp"]} {
    %0 = llvm.mlir.constant(2139095040 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.and %1, %0  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    llvm.return %3 : i1
  }
  llvm.func @f32_fcposinf_noimplicitfloat(%arg0: f32) -> i1 attributes {passthrough = ["noimplicitfloat"]} {
    %0 = llvm.mlir.constant(2139095040 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @f32_fcposinf_noimplicitfloat_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["noimplicitfloat", "strictfp"]} {
    %0 = llvm.mlir.constant(2139095040 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @f32_fcposnan(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(2139095041 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @f32_fcposnan_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(2139095041 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @f32_fcposinf_multiuse(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(2139095040 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    llvm.call @usei32(%1) : (i32) -> ()
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @f32_fcposinf_multiuse_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(2139095040 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    llvm.call @usei32(%1) : (i32) -> ()
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @usei32(i32)
}
