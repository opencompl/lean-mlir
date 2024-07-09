module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @F0(%arg0: bf16) -> f64 {
    %0 = llvm.bitcast %arg0 : bf16 to f16
    %1 = llvm.fpext %0 : f16 to f64
    llvm.return %1 : f64
  }
  llvm.func @F1(%arg0: f16) -> f64 {
    %0 = llvm.bitcast %arg0 : f16 to bf16
    %1 = llvm.fpext %0 : bf16 to f64
    llvm.return %1 : f64
  }
  llvm.func @F2(%arg0: bf16) -> i32 {
    %0 = llvm.bitcast %arg0 : bf16 to f16
    %1 = llvm.fptoui %0 : f16 to i32
    llvm.return %1 : i32
  }
  llvm.func @F3(%arg0: f16) -> i32 {
    %0 = llvm.bitcast %arg0 : f16 to bf16
    %1 = llvm.fptoui %0 : bf16 to i32
    llvm.return %1 : i32
  }
  llvm.func @F4(%arg0: bf16) -> i32 {
    %0 = llvm.bitcast %arg0 : bf16 to f16
    %1 = llvm.fptosi %0 : f16 to i32
    llvm.return %1 : i32
  }
  llvm.func @F5(%arg0: f16) -> i32 {
    %0 = llvm.bitcast %arg0 : f16 to bf16
    %1 = llvm.fptosi %0 : bf16 to i32
    llvm.return %1 : i32
  }
}
