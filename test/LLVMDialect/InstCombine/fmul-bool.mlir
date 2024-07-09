module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @fmul_bool(%arg0: f32, %arg1: i1) -> f32 {
    %0 = llvm.uitofp %arg1 : i1 to f32
    %1 = llvm.fmul %0, %arg0  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : f32
    llvm.return %1 : f32
  }
  llvm.func @fmul_bool_vec(%arg0: vector<2xf32>, %arg1: vector<2xi1>) -> vector<2xf32> {
    %0 = llvm.uitofp %arg1 : vector<2xi1> to vector<2xf32>
    %1 = llvm.fmul %0, %arg0  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }
  llvm.func @fmul_bool_vec_commute(%arg0: vector<2xf32>, %arg1: vector<2xi1>) -> vector<2xf32> {
    %0 = llvm.fmul %arg0, %arg0  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : vector<2xf32>
    %1 = llvm.uitofp %arg1 : vector<2xi1> to vector<2xf32>
    %2 = llvm.fmul %0, %1  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }
}
