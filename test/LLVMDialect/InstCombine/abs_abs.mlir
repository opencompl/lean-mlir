module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @abs_abs_x01(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %arg0, %3 : i1, i32
    %5 = llvm.icmp "sgt" %4, %0 : i32
    %6 = llvm.sub %1, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %4, %6 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @abs_abs_x01_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.icmp "sgt" %arg0, %0 : vector<2xi32>
    %4 = llvm.sub %2, %arg0 overflow<nsw>  : vector<2xi32>
    %5 = llvm.select %3, %arg0, %4 : vector<2xi1>, vector<2xi32>
    %6 = llvm.icmp "sgt" %5, %0 : vector<2xi32>
    %7 = llvm.sub %2, %5 overflow<nsw>  : vector<2xi32>
    %8 = llvm.select %6, %5, %7 : vector<2xi1>, vector<2xi32>
    llvm.return %8 : vector<2xi32>
  }
  llvm.func @abs_abs_x02(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %arg0, %3 : i1, i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.sub %0, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %4, %6 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @abs_abs_x03(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %3, %arg0 : i1, i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.sub %0, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %4, %6 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @abs_abs_x04(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %5 = llvm.select %3, %4, %arg0 : i1, i32
    %6 = llvm.icmp "sgt" %5, %2 : i32
    %7 = llvm.sub %1, %5 overflow<nsw>  : i32
    %8 = llvm.select %6, %5, %7 : i1, i32
    llvm.return %8 : i32
  }
  llvm.func @abs_abs_x04_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.icmp "slt" %arg0, %0 : vector<2xi32>
    %5 = llvm.sub %2, %arg0 overflow<nsw>  : vector<2xi32>
    %6 = llvm.select %4, %5, %arg0 : vector<2xi1>, vector<2xi32>
    %7 = llvm.icmp "sgt" %6, %3 : vector<2xi32>
    %8 = llvm.sub %2, %6 overflow<nsw>  : vector<2xi32>
    %9 = llvm.select %7, %6, %8 : vector<2xi1>, vector<2xi32>
    llvm.return %9 : vector<2xi32>
  }
  llvm.func @abs_abs_x05(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %arg0, %3 : i1, i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.sub %1, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %4, %6 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @abs_abs_x06(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %3 = llvm.select %1, %arg0, %2 : i1, i32
    %4 = llvm.icmp "sgt" %3, %0 : i32
    %5 = llvm.sub %0, %3 overflow<nsw>  : i32
    %6 = llvm.select %4, %3, %5 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @abs_abs_x07(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %3 = llvm.select %1, %2, %arg0 : i1, i32
    %4 = llvm.icmp "sgt" %3, %0 : i32
    %5 = llvm.sub %0, %3 overflow<nsw>  : i32
    %6 = llvm.select %4, %3, %5 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @abs_abs_x08(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %3, %arg0 : i1, i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.sub %1, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %4, %6 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @abs_abs_x09(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %arg0, %3 : i1, i32
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.sub %1, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %6, %4 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @abs_abs_x10(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %3 = llvm.select %1, %arg0, %2 : i1, i32
    %4 = llvm.icmp "slt" %3, %0 : i32
    %5 = llvm.sub %0, %3 overflow<nsw>  : i32
    %6 = llvm.select %4, %5, %3 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @abs_abs_x11(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %3 = llvm.select %1, %2, %arg0 : i1, i32
    %4 = llvm.icmp "slt" %3, %0 : i32
    %5 = llvm.sub %0, %3 overflow<nsw>  : i32
    %6 = llvm.select %4, %5, %3 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @abs_abs_x12(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %3, %arg0 : i1, i32
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.sub %1, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %6, %4 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @abs_abs_x13(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %5 = llvm.select %3, %arg0, %4 : i1, i32
    %6 = llvm.icmp "slt" %5, %2 : i32
    %7 = llvm.sub %1, %5 overflow<nsw>  : i32
    %8 = llvm.select %6, %7, %5 : i1, i32
    llvm.return %8 : i32
  }
  llvm.func @abs_abs_x14(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %arg0, %3 : i1, i32
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.sub %0, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %6, %4 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @abs_abs_x15(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %3, %arg0 : i1, i32
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.sub %0, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %6, %4 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @abs_abs_x16(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %3, %arg0 : i1, i32
    %5 = llvm.icmp "slt" %4, %0 : i32
    %6 = llvm.sub %1, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %6, %4 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @abs_abs_x17(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %3 = llvm.icmp "sgt" %2, %1 : i32
    %4 = llvm.select %3, %2, %arg0 : i1, i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.sub %0, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %4, %6 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @abs_abs_x18(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    %3 = llvm.sub %arg1, %arg0 overflow<nsw>  : i32
    %4 = llvm.icmp "sgt" %2, %0 : i32
    %5 = llvm.select %4, %2, %3 : i1, i32
    %6 = llvm.icmp "sgt" %5, %0 : i32
    %7 = llvm.sub %1, %5 overflow<nsw>  : i32
    %8 = llvm.select %6, %5, %7 : i1, i32
    llvm.return %8 : i32
  }
  llvm.func @abs_abs_x02_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : vector<2xi32>
    %4 = llvm.icmp "sgt" %3, %2 : vector<2xi32>
    %5 = llvm.select %4, %3, %arg0 : vector<2xi1>, vector<2xi32>
    %6 = llvm.icmp "sgt" %5, %2 : vector<2xi32>
    %7 = llvm.sub %1, %5 overflow<nsw>  : vector<2xi32>
    %8 = llvm.select %6, %5, %7 : vector<2xi1>, vector<2xi32>
    llvm.return %8 : vector<2xi32>
  }
  llvm.func @abs_abs_x03_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.sub %arg0, %arg1 overflow<nsw>  : vector<2xi32>
    %4 = llvm.sub %arg1, %arg0 overflow<nsw>  : vector<2xi32>
    %5 = llvm.icmp "sgt" %3, %0 : vector<2xi32>
    %6 = llvm.select %5, %3, %4 : vector<2xi1>, vector<2xi32>
    %7 = llvm.icmp "sgt" %6, %0 : vector<2xi32>
    %8 = llvm.sub %2, %6 overflow<nsw>  : vector<2xi32>
    %9 = llvm.select %7, %6, %8 : vector<2xi1>, vector<2xi32>
    llvm.return %9 : vector<2xi32>
  }
  llvm.func @nabs_nabs_x01(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %3, %arg0 : i1, i32
    %5 = llvm.icmp "sgt" %4, %0 : i32
    %6 = llvm.sub %1, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %6, %4 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @nabs_nabs_x02(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %3, %arg0 : i1, i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.sub %0, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %6, %4 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @nabs_nabs_x03(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %arg0, %3 : i1, i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.sub %0, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %6, %4 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @nabs_nabs_x04(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %5 = llvm.select %3, %arg0, %4 : i1, i32
    %6 = llvm.icmp "sgt" %5, %2 : i32
    %7 = llvm.sub %1, %5 overflow<nsw>  : i32
    %8 = llvm.select %6, %7, %5 : i1, i32
    llvm.return %8 : i32
  }
  llvm.func @nabs_nabs_x05(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %3, %arg0 : i1, i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.sub %1, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %6, %4 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @nabs_nabs_x06(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %3 = llvm.select %1, %2, %arg0 : i1, i32
    %4 = llvm.icmp "sgt" %3, %0 : i32
    %5 = llvm.sub %0, %3 overflow<nsw>  : i32
    %6 = llvm.select %4, %5, %3 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @nabs_nabs_x07(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %3 = llvm.select %1, %arg0, %2 : i1, i32
    %4 = llvm.icmp "sgt" %3, %0 : i32
    %5 = llvm.sub %0, %3 overflow<nsw>  : i32
    %6 = llvm.select %4, %5, %3 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @nabs_nabs_x08(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %arg0, %3 : i1, i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.sub %1, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %6, %4 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @nabs_nabs_x09(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %3, %arg0 : i1, i32
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.sub %1, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %4, %6 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @nabs_nabs_x10(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %3 = llvm.select %1, %2, %arg0 : i1, i32
    %4 = llvm.icmp "slt" %3, %0 : i32
    %5 = llvm.sub %0, %3 overflow<nsw>  : i32
    %6 = llvm.select %4, %3, %5 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @nabs_nabs_x11(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %3 = llvm.select %1, %arg0, %2 : i1, i32
    %4 = llvm.icmp "slt" %3, %0 : i32
    %5 = llvm.sub %0, %3 overflow<nsw>  : i32
    %6 = llvm.select %4, %3, %5 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @nabs_nabs_x12(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %arg0, %3 : i1, i32
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.sub %1, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %4, %6 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @nabs_nabs_x13(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %5 = llvm.select %3, %4, %arg0 : i1, i32
    %6 = llvm.icmp "slt" %5, %2 : i32
    %7 = llvm.sub %1, %5 overflow<nsw>  : i32
    %8 = llvm.select %6, %5, %7 : i1, i32
    llvm.return %8 : i32
  }
  llvm.func @nabs_nabs_x14(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %3, %arg0 : i1, i32
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.sub %0, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %4, %6 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @nabs_nabs_x15(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %arg0, %3 : i1, i32
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.sub %0, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %4, %6 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @nabs_nabs_x16(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %arg0, %3 : i1, i32
    %5 = llvm.icmp "slt" %4, %0 : i32
    %6 = llvm.sub %1, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %4, %6 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @nabs_nabs_x17(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %3 = llvm.icmp "sgt" %2, %1 : i32
    %4 = llvm.select %3, %arg0, %2 : i1, i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.sub %0, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %6, %4 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @nabs_nabs_x18(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    %3 = llvm.sub %arg1, %arg0 overflow<nsw>  : i32
    %4 = llvm.icmp "sgt" %2, %0 : i32
    %5 = llvm.select %4, %3, %2 : i1, i32
    %6 = llvm.icmp "sgt" %5, %0 : i32
    %7 = llvm.sub %1, %5 overflow<nsw>  : i32
    %8 = llvm.select %6, %7, %5 : i1, i32
    llvm.return %8 : i32
  }
  llvm.func @nabs_nabs_x01_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : vector<2xi32>
    %4 = llvm.icmp "sgt" %3, %2 : vector<2xi32>
    %5 = llvm.select %4, %arg0, %3 : vector<2xi1>, vector<2xi32>
    %6 = llvm.icmp "sgt" %5, %2 : vector<2xi32>
    %7 = llvm.sub %1, %5 overflow<nsw>  : vector<2xi32>
    %8 = llvm.select %6, %7, %5 : vector<2xi1>, vector<2xi32>
    llvm.return %8 : vector<2xi32>
  }
  llvm.func @nabs_nabs_x02_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.sub %arg0, %arg1 overflow<nsw>  : vector<2xi32>
    %4 = llvm.sub %arg1, %arg0 overflow<nsw>  : vector<2xi32>
    %5 = llvm.icmp "sgt" %3, %0 : vector<2xi32>
    %6 = llvm.select %5, %4, %3 : vector<2xi1>, vector<2xi32>
    %7 = llvm.icmp "sgt" %6, %0 : vector<2xi32>
    %8 = llvm.sub %2, %6 overflow<nsw>  : vector<2xi32>
    %9 = llvm.select %7, %8, %6 : vector<2xi1>, vector<2xi32>
    llvm.return %9 : vector<2xi32>
  }
  llvm.func @abs_nabs_x01(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %3, %arg0 : i1, i32
    %5 = llvm.icmp "sgt" %4, %0 : i32
    %6 = llvm.sub %1, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %4, %6 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @abs_nabs_x02(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %3, %arg0 : i1, i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.sub %0, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %4, %6 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @abs_nabs_x03(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %arg0, %3 : i1, i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.sub %0, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %4, %6 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @abs_nabs_x04(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %5 = llvm.select %3, %arg0, %4 : i1, i32
    %6 = llvm.icmp "sgt" %5, %2 : i32
    %7 = llvm.sub %1, %5 overflow<nsw>  : i32
    %8 = llvm.select %6, %5, %7 : i1, i32
    llvm.return %8 : i32
  }
  llvm.func @abs_nabs_x05(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %3, %arg0 : i1, i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.sub %1, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %4, %6 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @abs_nabs_x06(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %3 = llvm.select %1, %2, %arg0 : i1, i32
    %4 = llvm.icmp "sgt" %3, %0 : i32
    %5 = llvm.sub %0, %3 overflow<nsw>  : i32
    %6 = llvm.select %4, %3, %5 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @abs_nabs_x07(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %3 = llvm.select %1, %arg0, %2 : i1, i32
    %4 = llvm.icmp "sgt" %3, %0 : i32
    %5 = llvm.sub %0, %3 overflow<nsw>  : i32
    %6 = llvm.select %4, %3, %5 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @abs_nabs_x08(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %arg0, %3 : i1, i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.sub %1, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %4, %6 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @abs_nabs_x09(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %3, %arg0 : i1, i32
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.sub %1, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %6, %4 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @abs_nabs_x10(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %3 = llvm.select %1, %2, %arg0 : i1, i32
    %4 = llvm.icmp "slt" %3, %0 : i32
    %5 = llvm.sub %0, %3 overflow<nsw>  : i32
    %6 = llvm.select %4, %5, %3 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @abs_nabs_x11(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %3 = llvm.select %1, %arg0, %2 : i1, i32
    %4 = llvm.icmp "slt" %3, %0 : i32
    %5 = llvm.sub %0, %3 overflow<nsw>  : i32
    %6 = llvm.select %4, %5, %3 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @abs_nabs_x12(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %arg0, %3 : i1, i32
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.sub %1, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %6, %4 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @abs_nabs_x13(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %5 = llvm.select %3, %4, %arg0 : i1, i32
    %6 = llvm.icmp "slt" %5, %2 : i32
    %7 = llvm.sub %1, %5 overflow<nsw>  : i32
    %8 = llvm.select %6, %7, %5 : i1, i32
    llvm.return %8 : i32
  }
  llvm.func @abs_nabs_x14(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %3, %arg0 : i1, i32
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.sub %0, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %6, %4 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @abs_nabs_x15(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %arg0, %3 : i1, i32
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.sub %0, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %6, %4 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @abs_nabs_x16(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %arg0, %3 : i1, i32
    %5 = llvm.icmp "slt" %4, %0 : i32
    %6 = llvm.sub %1, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %6, %4 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @abs_nabs_x17(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %3 = llvm.icmp "sgt" %2, %1 : i32
    %4 = llvm.select %3, %arg0, %2 : i1, i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.sub %0, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %4, %6 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @abs_nabs_x18(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    %3 = llvm.sub %arg1, %arg0 overflow<nsw>  : i32
    %4 = llvm.icmp "sgt" %2, %0 : i32
    %5 = llvm.select %4, %3, %2 : i1, i32
    %6 = llvm.icmp "sgt" %5, %0 : i32
    %7 = llvm.sub %1, %5 overflow<nsw>  : i32
    %8 = llvm.select %6, %5, %7 : i1, i32
    llvm.return %8 : i32
  }
  llvm.func @abs_nabs_x01_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : vector<2xi32>
    %4 = llvm.icmp "sgt" %3, %2 : vector<2xi32>
    %5 = llvm.select %4, %arg0, %3 : vector<2xi1>, vector<2xi32>
    %6 = llvm.icmp "sgt" %5, %2 : vector<2xi32>
    %7 = llvm.sub %1, %5 overflow<nsw>  : vector<2xi32>
    %8 = llvm.select %6, %5, %7 : vector<2xi1>, vector<2xi32>
    llvm.return %8 : vector<2xi32>
  }
  llvm.func @abs_nabs_x02_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.sub %arg0, %arg1 overflow<nsw>  : vector<2xi32>
    %4 = llvm.sub %arg1, %arg0 overflow<nsw>  : vector<2xi32>
    %5 = llvm.icmp "sgt" %3, %0 : vector<2xi32>
    %6 = llvm.select %5, %4, %3 : vector<2xi1>, vector<2xi32>
    %7 = llvm.icmp "sgt" %6, %0 : vector<2xi32>
    %8 = llvm.sub %2, %6 overflow<nsw>  : vector<2xi32>
    %9 = llvm.select %7, %6, %8 : vector<2xi1>, vector<2xi32>
    llvm.return %9 : vector<2xi32>
  }
  llvm.func @nabs_abs_x01(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %arg0, %3 : i1, i32
    %5 = llvm.icmp "sgt" %4, %0 : i32
    %6 = llvm.sub %1, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %6, %4 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @nabs_abs_x02(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %arg0, %3 : i1, i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.sub %0, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %6, %4 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @nabs_abs_x03(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %3, %arg0 : i1, i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.sub %0, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %6, %4 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @nabs_abs_x04(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %5 = llvm.select %3, %4, %arg0 : i1, i32
    %6 = llvm.icmp "sgt" %5, %2 : i32
    %7 = llvm.sub %1, %5 overflow<nsw>  : i32
    %8 = llvm.select %6, %7, %5 : i1, i32
    llvm.return %8 : i32
  }
  llvm.func @nabs_abs_x05(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %arg0, %3 : i1, i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.sub %1, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %6, %4 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @nabs_abs_x06(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %3 = llvm.select %1, %arg0, %2 : i1, i32
    %4 = llvm.icmp "sgt" %3, %0 : i32
    %5 = llvm.sub %0, %3 overflow<nsw>  : i32
    %6 = llvm.select %4, %5, %3 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @nabs_abs_x07(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %3 = llvm.select %1, %2, %arg0 : i1, i32
    %4 = llvm.icmp "sgt" %3, %0 : i32
    %5 = llvm.sub %0, %3 overflow<nsw>  : i32
    %6 = llvm.select %4, %5, %3 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @nabs_abs_x08(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %3, %arg0 : i1, i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.sub %1, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %6, %4 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @nabs_abs_x09(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %arg0, %3 : i1, i32
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.sub %1, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %4, %6 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @nabs_abs_x10(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %3 = llvm.select %1, %arg0, %2 : i1, i32
    %4 = llvm.icmp "slt" %3, %0 : i32
    %5 = llvm.sub %0, %3 overflow<nsw>  : i32
    %6 = llvm.select %4, %3, %5 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @nabs_abs_x11(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %3 = llvm.select %1, %2, %arg0 : i1, i32
    %4 = llvm.icmp "slt" %3, %0 : i32
    %5 = llvm.sub %0, %3 overflow<nsw>  : i32
    %6 = llvm.select %4, %3, %5 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @nabs_abs_x12(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %3, %arg0 : i1, i32
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.sub %1, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %4, %6 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @nabs_abs_x13(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %5 = llvm.select %3, %arg0, %4 : i1, i32
    %6 = llvm.icmp "slt" %5, %2 : i32
    %7 = llvm.sub %1, %5 overflow<nsw>  : i32
    %8 = llvm.select %6, %5, %7 : i1, i32
    llvm.return %8 : i32
  }
  llvm.func @nabs_abs_x14(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %arg0, %3 : i1, i32
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.sub %0, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %4, %6 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @nabs_abs_x15(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %3, %arg0 : i1, i32
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.sub %0, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %4, %6 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @nabs_abs_x16(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %3, %arg0 : i1, i32
    %5 = llvm.icmp "slt" %4, %0 : i32
    %6 = llvm.sub %1, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %4, %6 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @nabs_abs_x17(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %3 = llvm.icmp "sgt" %2, %1 : i32
    %4 = llvm.select %3, %2, %arg0 : i1, i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.sub %0, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %6, %4 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @nabs_abs_x18(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    %3 = llvm.sub %arg1, %arg0 overflow<nsw>  : i32
    %4 = llvm.icmp "sgt" %2, %0 : i32
    %5 = llvm.select %4, %2, %3 : i1, i32
    %6 = llvm.icmp "sgt" %5, %0 : i32
    %7 = llvm.sub %1, %5 overflow<nsw>  : i32
    %8 = llvm.select %6, %7, %5 : i1, i32
    llvm.return %8 : i32
  }
  llvm.func @nabs_abs_x01_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : vector<2xi32>
    %4 = llvm.icmp "sgt" %3, %2 : vector<2xi32>
    %5 = llvm.select %4, %3, %arg0 : vector<2xi1>, vector<2xi32>
    %6 = llvm.icmp "sgt" %5, %2 : vector<2xi32>
    %7 = llvm.sub %1, %5 overflow<nsw>  : vector<2xi32>
    %8 = llvm.select %6, %7, %5 : vector<2xi1>, vector<2xi32>
    llvm.return %8 : vector<2xi32>
  }
  llvm.func @nabs_abs_x02_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.sub %arg0, %arg1 overflow<nsw>  : vector<2xi32>
    %4 = llvm.sub %arg1, %arg0 overflow<nsw>  : vector<2xi32>
    %5 = llvm.icmp "sgt" %3, %0 : vector<2xi32>
    %6 = llvm.select %5, %3, %4 : vector<2xi1>, vector<2xi32>
    %7 = llvm.icmp "sgt" %6, %0 : vector<2xi32>
    %8 = llvm.sub %2, %6 overflow<nsw>  : vector<2xi32>
    %9 = llvm.select %7, %8, %6 : vector<2xi1>, vector<2xi32>
    llvm.return %9 : vector<2xi32>
  }
}
