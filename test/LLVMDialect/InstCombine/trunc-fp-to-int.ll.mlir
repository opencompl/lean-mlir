module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @half_fptoui_i17_i16(%arg0: f16) -> i16 {
    %0 = llvm.fptoui %arg0 : f16 to i17
    %1 = llvm.trunc %0 : i17 to i16
    llvm.return %1 : i16
  }
  llvm.func @half_fptoui_i17_i15(%arg0: f16) -> i15 {
    %0 = llvm.fptoui %arg0 : f16 to i17
    %1 = llvm.trunc %0 : i17 to i15
    llvm.return %1 : i15
  }
  llvm.func @half_fptoui_i32_i16(%arg0: f16) -> i16 {
    %0 = llvm.fptoui %arg0 : f16 to i32
    %1 = llvm.trunc %0 : i32 to i16
    llvm.return %1 : i16
  }
  llvm.func @half_fptoui_i32_i17(%arg0: f16) -> i17 {
    %0 = llvm.fptoui %arg0 : f16 to i32
    %1 = llvm.trunc %0 : i32 to i17
    llvm.return %1 : i17
  }
  llvm.func @half_fptoui_4xi32_4xi16(%arg0: vector<4xf16>) -> vector<4xi16> {
    %0 = llvm.fptoui %arg0 : vector<4xf16> to vector<4xi32>
    %1 = llvm.trunc %0 : vector<4xi32> to vector<4xi16>
    llvm.return %1 : vector<4xi16>
  }
  llvm.func @bfloat_fptoui_i129_i128(%arg0: bf16) -> i128 {
    %0 = llvm.fptoui %arg0 : bf16 to i129
    %1 = llvm.trunc %0 : i129 to i128
    llvm.return %1 : i128
  }
  llvm.func @bfloat_fptoui_i128_i127(%arg0: bf16) -> i127 {
    %0 = llvm.fptoui %arg0 : bf16 to i128
    %1 = llvm.trunc %0 : i128 to i127
    llvm.return %1 : i127
  }
  llvm.func @float_fptoui_i129_i128(%arg0: f32) -> i128 {
    %0 = llvm.fptoui %arg0 : f32 to i129
    %1 = llvm.trunc %0 : i129 to i128
    llvm.return %1 : i128
  }
  llvm.func @use(i129)
  llvm.func @float_fptoui_i129_i128_use(%arg0: f32) -> i128 {
    %0 = llvm.fptoui %arg0 : f32 to i129
    llvm.call @use(%0) : (i129) -> ()
    %1 = llvm.trunc %0 : i129 to i128
    llvm.return %1 : i128
  }
  llvm.func @float_fptoui_i128_i127(%arg0: f32) -> i127 {
    %0 = llvm.fptoui %arg0 : f32 to i128
    %1 = llvm.trunc %0 : i128 to i127
    llvm.return %1 : i127
  }
  llvm.func @double_fptoui_i1025_i1024(%arg0: f64) -> i1024 {
    %0 = llvm.fptoui %arg0 : f64 to i1025
    %1 = llvm.trunc %0 : i1025 to i1024
    llvm.return %1 : i1024
  }
  llvm.func @double_fptoui_i1024_i1023(%arg0: f64) -> i1023 {
    %0 = llvm.fptoui %arg0 : f64 to i1024
    %1 = llvm.trunc %0 : i1024 to i1023
    llvm.return %1 : i1023
  }
  llvm.func @half_fptosi_i17_i16(%arg0: f16) -> i16 {
    %0 = llvm.fptosi %arg0 : f16 to i17
    %1 = llvm.trunc %0 : i17 to i16
    llvm.return %1 : i16
  }
  llvm.func @half_fptosi_i18_i17(%arg0: f16) -> i17 {
    %0 = llvm.fptosi %arg0 : f16 to i18
    %1 = llvm.trunc %0 : i18 to i17
    llvm.return %1 : i17
  }
  llvm.func @half_fptosi_i32_i17(%arg0: f16) -> i17 {
    %0 = llvm.fptosi %arg0 : f16 to i32
    %1 = llvm.trunc %0 : i32 to i17
    llvm.return %1 : i17
  }
  llvm.func @half_fptosi_i32_i18(%arg0: f16) -> i18 {
    %0 = llvm.fptosi %arg0 : f16 to i32
    %1 = llvm.trunc %0 : i32 to i18
    llvm.return %1 : i18
  }
  llvm.func @half_fptosi_4xi32_4xi17(%arg0: vector<4xf16>) -> vector<4xi17> {
    %0 = llvm.fptosi %arg0 : vector<4xf16> to vector<4xi32>
    %1 = llvm.trunc %0 : vector<4xi32> to vector<4xi17>
    llvm.return %1 : vector<4xi17>
  }
  llvm.func @bfloat_fptosi_i129_i128(%arg0: bf16) -> i128 {
    %0 = llvm.fptosi %arg0 : bf16 to i129
    %1 = llvm.trunc %0 : i129 to i128
    llvm.return %1 : i128
  }
  llvm.func @bfloat_fptosi_i130_i129(%arg0: bf16) -> i129 {
    %0 = llvm.fptosi %arg0 : bf16 to i130
    %1 = llvm.trunc %0 : i130 to i129
    llvm.return %1 : i129
  }
  llvm.func @float_fptosi_i130_i129(%arg0: f32) -> i129 {
    %0 = llvm.fptosi %arg0 : f32 to i130
    %1 = llvm.trunc %0 : i130 to i129
    llvm.return %1 : i129
  }
  llvm.func @float_fptosi_i129_i128(%arg0: f32) -> i128 {
    %0 = llvm.fptosi %arg0 : f32 to i129
    %1 = llvm.trunc %0 : i129 to i128
    llvm.return %1 : i128
  }
  llvm.func @double_fptosi_i1026_i1025(%arg0: f64) -> i1025 {
    %0 = llvm.fptosi %arg0 : f64 to i1026
    %1 = llvm.trunc %0 : i1026 to i1025
    llvm.return %1 : i1025
  }
  llvm.func @double_fptosi_i1025_i1024(%arg0: f64) -> i1024 {
    %0 = llvm.fptosi %arg0 : f64 to i1025
    %1 = llvm.trunc %0 : i1025 to i1024
    llvm.return %1 : i1024
  }
}
