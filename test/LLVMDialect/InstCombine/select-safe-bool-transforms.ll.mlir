module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @land_land_left1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg0, %arg1, %0 : i1, i1
    %2 = llvm.select %1, %arg0, %0 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @land_land_left2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg1, %arg0, %0 : i1, i1
    %2 = llvm.select %1, %arg0, %0 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @land_band_left1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg0, %arg1, %0 : i1, i1
    %2 = llvm.and %1, %arg0  : i1
    llvm.return %2 : i1
  }
  llvm.func @land_band_left2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg1, %arg0, %0 : i1, i1
    %2 = llvm.and %1, %arg0  : i1
    llvm.return %2 : i1
  }
  llvm.func @land_lor_left1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg0, %arg1, %0 : i1, i1
    %3 = llvm.select %2, %1, %arg0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @land_lor_left2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg1, %arg0, %0 : i1, i1
    %3 = llvm.select %2, %1, %arg0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @land_bor_left1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg0, %arg1, %0 : i1, i1
    %2 = llvm.or %1, %arg0  : i1
    llvm.return %2 : i1
  }
  llvm.func @land_bor_left2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg1, %arg0, %0 : i1, i1
    %2 = llvm.or %1, %arg0  : i1
    llvm.return %2 : i1
  }
  llvm.func @band_land_left1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.and %arg0, %arg1  : i1
    %2 = llvm.select %1, %arg0, %0 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @band_land_left2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.and %arg1, %arg0  : i1
    %2 = llvm.select %1, %arg0, %0 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @band_lor_left1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.and %arg0, %arg1  : i1
    %2 = llvm.select %1, %0, %arg0 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @band_lor_left2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.and %arg1, %arg0  : i1
    %2 = llvm.select %1, %0, %arg0 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @lor_land_left1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.select %arg0, %0, %arg1 : i1, i1
    %3 = llvm.select %2, %arg0, %1 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @lor_land_left2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.select %arg1, %0, %arg0 : i1, i1
    %3 = llvm.select %2, %arg0, %1 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @lor_band_left1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg1 : i1, i1
    %2 = llvm.and %1, %arg0  : i1
    llvm.return %2 : i1
  }
  llvm.func @lor_band_left2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg1, %0, %arg0 : i1, i1
    %2 = llvm.and %1, %arg0  : i1
    llvm.return %2 : i1
  }
  llvm.func @lor_lor_left1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg1 : i1, i1
    %2 = llvm.select %1, %0, %arg0 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @lor_lor_left2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg1, %0, %arg0 : i1, i1
    %2 = llvm.select %1, %0, %arg0 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @lor_bor_left1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg1 : i1, i1
    %2 = llvm.or %1, %arg0  : i1
    llvm.return %2 : i1
  }
  llvm.func @lor_bor_left2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg1, %0, %arg0 : i1, i1
    %2 = llvm.or %1, %arg0  : i1
    llvm.return %2 : i1
  }
  llvm.func @bor_land_left1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.or %arg0, %arg1  : i1
    %2 = llvm.select %1, %arg0, %0 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @bor_land_left2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.or %arg1, %arg0  : i1
    %2 = llvm.select %1, %arg0, %0 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @bor_lor_left1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.or %arg0, %arg1  : i1
    %2 = llvm.select %1, %0, %arg0 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @bor_lor_left2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.or %arg1, %arg0  : i1
    %2 = llvm.select %1, %0, %arg0 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @land_land_right1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg0, %arg1, %0 : i1, i1
    %2 = llvm.select %arg0, %1, %0 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @land_land_right2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg1, %arg0, %0 : i1, i1
    %2 = llvm.select %arg0, %1, %0 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @land_band_right1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg0, %arg1, %0 : i1, i1
    %2 = llvm.and %arg0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @land_band_right2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg1, %arg0, %0 : i1, i1
    %2 = llvm.and %arg0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @land_lor_right1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg0, %arg1, %0 : i1, i1
    %3 = llvm.select %arg0, %1, %2 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @land_lor_right2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg1, %arg0, %0 : i1, i1
    %3 = llvm.select %arg0, %1, %2 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @land_lor_right1_vec(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %4 = llvm.select %arg0, %arg1, %1 : vector<2xi1>, vector<2xi1>
    %5 = llvm.select %arg0, %3, %4 : vector<2xi1>, vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @land_lor_right2_vec(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %4 = llvm.select %arg1, %arg0, %1 : vector<2xi1>, vector<2xi1>
    %5 = llvm.select %arg0, %3, %4 : vector<2xi1>, vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @land_bor_right1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg0, %arg1, %0 : i1, i1
    %2 = llvm.or %arg0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @land_bor_right2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg1, %arg0, %0 : i1, i1
    %2 = llvm.or %arg0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @band_land_right1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.and %arg0, %arg1  : i1
    %2 = llvm.select %arg0, %1, %0 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @band_land_right2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.and %arg1, %arg0  : i1
    %2 = llvm.select %arg0, %1, %0 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @band_lor_right1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.and %arg0, %arg1  : i1
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @band_lor_right2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.and %arg1, %arg0  : i1
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @lor_land_right1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.select %arg0, %0, %arg1 : i1, i1
    %3 = llvm.select %arg0, %2, %1 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @lor_land_right2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.select %arg1, %0, %arg0 : i1, i1
    %3 = llvm.select %arg0, %2, %1 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @lor_band_right1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg1 : i1, i1
    %2 = llvm.and %arg0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @lor_band_right2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg1, %0, %arg0 : i1, i1
    %2 = llvm.and %arg0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @lor_lor_right1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg1 : i1, i1
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @lor_lor_right2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg1, %0, %arg0 : i1, i1
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @lor_bor_right1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg1 : i1, i1
    %2 = llvm.or %arg0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @lor_bor_right2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg1, %0, %arg0 : i1, i1
    %2 = llvm.or %arg0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @bor_land_right1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.or %arg0, %arg1  : i1
    %2 = llvm.select %arg0, %1, %0 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @bor_land_right2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.or %arg1, %arg0  : i1
    %2 = llvm.select %arg0, %1, %0 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @bor_lor_right1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.or %arg0, %arg1  : i1
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @bor_lor_right2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.or %arg1, %arg0  : i1
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @PR50500_trueval(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : vector<2xi1>
    %1 = llvm.shufflevector %arg0, %0 [1, 0] : vector<2xi1> 
    %2 = llvm.select %arg0, %1, %arg1 : vector<2xi1>, vector<2xi1>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @PR50500_falseval(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : vector<2xi1>
    %1 = llvm.shufflevector %arg0, %0 [1, 0] : vector<2xi1> 
    %2 = llvm.select %arg0, %arg1, %1 : vector<2xi1>, vector<2xi1>
    llvm.return %2 : vector<2xi1>
  }
}
