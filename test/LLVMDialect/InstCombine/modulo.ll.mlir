module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @modulo2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.srem %arg0, %0  : i32
    %3 = llvm.icmp "slt" %2, %1 : i32
    %4 = llvm.select %3, %0, %1 : i1, i32
    %5 = llvm.add %4, %2 overflow<nsw>  : i32
    llvm.return %5 : i32
  }
  llvm.func @modulo2_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.srem %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "slt" %3, %2 : vector<2xi32>
    %5 = llvm.select %4, %0, %2 : vector<2xi1>, vector<2xi32>
    %6 = llvm.add %5, %3 overflow<nsw>  : vector<2xi32>
    llvm.return %6 : vector<2xi32>
  }
  llvm.func @modulo3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.srem %arg0, %0  : i32
    %3 = llvm.icmp "slt" %2, %1 : i32
    %4 = llvm.select %3, %0, %1 : i1, i32
    %5 = llvm.add %4, %2 overflow<nsw>  : i32
    llvm.return %5 : i32
  }
  llvm.func @modulo3_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.srem %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "slt" %3, %2 : vector<2xi32>
    %5 = llvm.select %4, %0, %2 : vector<2xi1>, vector<2xi32>
    %6 = llvm.add %5, %3 overflow<nsw>  : vector<2xi32>
    llvm.return %6 : vector<2xi32>
  }
  llvm.func @modulo4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.srem %arg0, %0  : i32
    %3 = llvm.icmp "slt" %2, %1 : i32
    %4 = llvm.select %3, %0, %1 : i1, i32
    %5 = llvm.add %4, %2 overflow<nsw>  : i32
    llvm.return %5 : i32
  }
  llvm.func @modulo4_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.srem %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "slt" %3, %2 : vector<2xi32>
    %5 = llvm.select %4, %0, %2 : vector<2xi1>, vector<2xi32>
    %6 = llvm.add %5, %3 overflow<nsw>  : vector<2xi32>
    llvm.return %6 : vector<2xi32>
  }
  llvm.func @modulo7(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.srem %arg0, %0  : i32
    %3 = llvm.icmp "slt" %2, %1 : i32
    %4 = llvm.select %3, %0, %1 : i1, i32
    %5 = llvm.add %4, %2 overflow<nsw>  : i32
    llvm.return %5 : i32
  }
  llvm.func @modulo7_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.srem %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "slt" %3, %2 : vector<2xi32>
    %5 = llvm.select %4, %0, %2 : vector<2xi1>, vector<2xi32>
    %6 = llvm.add %5, %3 overflow<nsw>  : vector<2xi32>
    llvm.return %6 : vector<2xi32>
  }
  llvm.func @modulo32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.srem %arg0, %0  : i32
    %3 = llvm.icmp "slt" %2, %1 : i32
    %4 = llvm.select %3, %0, %1 : i1, i32
    %5 = llvm.add %4, %2 overflow<nsw>  : i32
    llvm.return %5 : i32
  }
  llvm.func @modulo32_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.srem %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "slt" %3, %2 : vector<2xi32>
    %5 = llvm.select %4, %0, %2 : vector<2xi1>, vector<2xi32>
    %6 = llvm.add %5, %3 overflow<nsw>  : vector<2xi32>
    llvm.return %6 : vector<2xi32>
  }
  llvm.func @modulo16_32_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[16, 32]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.srem %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "slt" %3, %2 : vector<2xi32>
    %5 = llvm.select %4, %0, %2 : vector<2xi1>, vector<2xi32>
    %6 = llvm.add %5, %3 overflow<nsw>  : vector<2xi32>
    llvm.return %6 : vector<2xi32>
  }
}
