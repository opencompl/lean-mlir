module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @select_max_ugt(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "ugt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<arcp>} : f32
    %1 = llvm.select %0, %arg0, %arg1 {fastmathFlags = #llvm.fastmath<arcp>} : i1, f32
    llvm.return %1 : f32
  }
  llvm.func @select_max_uge(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nnan>} : f32
    %1 = llvm.select %0, %arg0, %arg1 {fastmathFlags = #llvm.fastmath<ninf>} : i1, f32
    llvm.return %1 : f32
  }
  llvm.func @select_min_ugt(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "ugt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f32
    %1 = llvm.select %0, %arg1, %arg0 {fastmathFlags = #llvm.fastmath<reassoc>} : i1, f32
    llvm.return %1 : f32
  }
  llvm.func @select_min_uge(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nsz>} : f32
    %1 = llvm.select %0, %arg1, %arg0 {fastmathFlags = #llvm.fastmath<fast>} : i1, f32
    llvm.return %1 : f32
  }
  llvm.func @select_max_ult(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "ult" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<arcp>} : f32
    %1 = llvm.select %0, %arg1, %arg0 {fastmathFlags = #llvm.fastmath<nnan, ninf>} : i1, f32
    llvm.return %1 : f32
  }
  llvm.func @select_max_ule(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f32
    %1 = llvm.select %0, %arg1, %arg0 {fastmathFlags = #llvm.fastmath<nsz>} : i1, f32
    llvm.return %1 : f32
  }
  llvm.func @select_min_ult(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "ult" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nsz>} : f32
    %1 = llvm.select %0, %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : i1, f32
    llvm.return %1 : f32
  }
  llvm.func @select_min_ule(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<arcp>} : f32
    %1 = llvm.select %0, %arg0, %arg1 {fastmathFlags = #llvm.fastmath<ninf>} : i1, f32
    llvm.return %1 : f32
  }
  llvm.func @select_fcmp_une(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "une" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %1 = llvm.select %0, %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32
    llvm.return %1 : f32
  }
  llvm.func @select_fcmp_ueq(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "ueq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %1 = llvm.select %0, %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nnan, arcp>} : i1, f32
    llvm.return %1 : f32
  }
  llvm.func @foo(i1)
  llvm.func @select_max_ugt_2_use_cmp(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "ugt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    llvm.call @foo(%0) : (i1) -> ()
    %1 = llvm.select %0, %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : i1, f32
    llvm.return %1 : f32
  }
  llvm.func @select_min_uge_2_use_cmp(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<ninf>} : f32
    llvm.call @foo(%0) : (i1) -> ()
    %1 = llvm.select %0, %arg1, %arg0 {fastmathFlags = #llvm.fastmath<nsz>} : i1, f32
    llvm.return %1 : f32
  }
}
