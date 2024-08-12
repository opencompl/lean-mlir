module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @demorgan_or_apint1(%arg0: i43, %arg1: i43) -> i43 {
    %0 = llvm.mlir.constant(-1 : i43) : i43
    %1 = llvm.xor %arg0, %0  : i43
    %2 = llvm.xor %arg1, %0  : i43
    %3 = llvm.or %1, %2  : i43
    llvm.return %3 : i43
  }
  llvm.func @demorgan_or_apint2(%arg0: i129, %arg1: i129) -> i129 {
    %0 = llvm.mlir.constant(-1 : i129) : i129
    %1 = llvm.xor %arg0, %0  : i129
    %2 = llvm.xor %arg1, %0  : i129
    %3 = llvm.or %1, %2  : i129
    llvm.return %3 : i129
  }
  llvm.func @demorgan_and_apint1(%arg0: i477, %arg1: i477) -> i477 {
    %0 = llvm.mlir.constant(-1 : i477) : i477
    %1 = llvm.xor %arg0, %0  : i477
    %2 = llvm.xor %arg1, %0  : i477
    %3 = llvm.and %1, %2  : i477
    llvm.return %3 : i477
  }
  llvm.func @demorgan_and_apint2(%arg0: i129, %arg1: i129) -> i129 {
    %0 = llvm.mlir.constant(-1 : i129) : i129
    %1 = llvm.xor %arg0, %0  : i129
    %2 = llvm.xor %arg1, %0  : i129
    %3 = llvm.and %1, %2  : i129
    llvm.return %3 : i129
  }
  llvm.func @demorgan_and_apint3(%arg0: i65, %arg1: i65) -> i65 {
    %0 = llvm.mlir.constant(-1 : i65) : i65
    %1 = llvm.xor %arg0, %0  : i65
    %2 = llvm.xor %0, %arg1  : i65
    %3 = llvm.and %1, %2  : i65
    llvm.return %3 : i65
  }
  llvm.func @demorgan_and_apint4(%arg0: i66, %arg1: i66) -> i66 {
    %0 = llvm.mlir.constant(-1 : i66) : i66
    %1 = llvm.xor %arg0, %0  : i66
    %2 = llvm.xor %arg1, %0  : i66
    %3 = llvm.and %1, %2  : i66
    llvm.return %3 : i66
  }
  llvm.func @demorgan_and_apint5(%arg0: i47, %arg1: i47) -> i47 {
    %0 = llvm.mlir.constant(-1 : i47) : i47
    %1 = llvm.xor %arg0, %0  : i47
    %2 = llvm.xor %arg1, %0  : i47
    %3 = llvm.and %1, %2  : i47
    llvm.return %3 : i47
  }
  llvm.func @test3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %arg1, %0  : i32
    %3 = llvm.and %1, %2  : i32
    %4 = llvm.xor %3, %0  : i32
    llvm.return %4 : i32
  }
  llvm.func @test4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.xor %3, %0  : i32
    llvm.return %4 : i32
  }
  llvm.func @test5(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %arg1, %0  : i32
    %3 = llvm.or %1, %2  : i32
    %4 = llvm.xor %3, %0  : i32
    llvm.return %4 : i32
  }
  llvm.func @test3_apint(%arg0: i47, %arg1: i47) -> i47 {
    %0 = llvm.mlir.constant(-1 : i47) : i47
    %1 = llvm.xor %arg0, %0  : i47
    %2 = llvm.xor %arg1, %0  : i47
    %3 = llvm.and %1, %2  : i47
    %4 = llvm.xor %3, %0  : i47
    llvm.return %4 : i47
  }
  llvm.func @test4_apint(%arg0: i61) -> i61 {
    %0 = llvm.mlir.constant(-1 : i61) : i61
    %1 = llvm.mlir.constant(5 : i61) : i61
    %2 = llvm.xor %arg0, %0  : i61
    %3 = llvm.and %2, %1  : i61
    %4 = llvm.xor %3, %0  : i61
    llvm.return %3 : i61
  }
  llvm.func @test5_apint(%arg0: i71, %arg1: i71) -> i71 {
    %0 = llvm.mlir.constant(-1 : i71) : i71
    %1 = llvm.xor %arg0, %0  : i71
    %2 = llvm.xor %arg1, %0  : i71
    %3 = llvm.or %1, %2  : i71
    %4 = llvm.xor %3, %0  : i71
    llvm.return %4 : i71
  }
  llvm.func @demorgan_nand(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.and %1, %arg1  : i8
    %3 = llvm.xor %2, %0  : i8
    llvm.return %3 : i8
  }
  llvm.func @demorgan_nand_apint1(%arg0: i7, %arg1: i7) -> i7 {
    %0 = llvm.mlir.constant(-1 : i7) : i7
    %1 = llvm.xor %arg0, %0  : i7
    %2 = llvm.and %1, %arg1  : i7
    %3 = llvm.xor %2, %0  : i7
    llvm.return %3 : i7
  }
  llvm.func @demorgan_nand_apint2(%arg0: i117, %arg1: i117) -> i117 {
    %0 = llvm.mlir.constant(-1 : i117) : i117
    %1 = llvm.xor %arg0, %0  : i117
    %2 = llvm.and %1, %arg1  : i117
    %3 = llvm.xor %2, %0  : i117
    llvm.return %3 : i117
  }
  llvm.func @demorgan_nor(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.or %1, %arg1  : i8
    %3 = llvm.xor %2, %0  : i8
    llvm.return %3 : i8
  }
  llvm.func @demorgan_nor_use2a(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(23 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.mul %2, %1  : i8
    %4 = llvm.or %2, %arg1  : i8
    %5 = llvm.xor %4, %0  : i8
    %6 = llvm.sdiv %5, %3  : i8
    llvm.return %6 : i8
  }
  llvm.func @demorgan_nor_use2b(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(23 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mul %arg1, %0  : i8
    %3 = llvm.xor %arg0, %1  : i8
    %4 = llvm.or %3, %arg1  : i8
    %5 = llvm.xor %4, %1  : i8
    %6 = llvm.sdiv %5, %2  : i8
    llvm.return %6 : i8
  }
  llvm.func @demorgan_nor_use2c(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(23 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.or %2, %arg1  : i8
    %4 = llvm.mul %3, %1  : i8
    %5 = llvm.xor %3, %0  : i8
    %6 = llvm.sdiv %5, %4  : i8
    llvm.return %6 : i8
  }
  llvm.func @demorgan_nor_use2ab(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(23 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(17 : i8) : i8
    %3 = llvm.mul %arg1, %0  : i8
    %4 = llvm.xor %arg0, %1  : i8
    %5 = llvm.mul %4, %2  : i8
    %6 = llvm.or %4, %arg1  : i8
    %7 = llvm.xor %6, %1  : i8
    %8 = llvm.sdiv %7, %3  : i8
    %9 = llvm.sdiv %8, %5  : i8
    llvm.return %9 : i8
  }
  llvm.func @demorgan_nor_use2ac(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(17 : i8) : i8
    %2 = llvm.mlir.constant(23 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.mul %3, %1  : i8
    %5 = llvm.or %3, %arg1  : i8
    %6 = llvm.mul %5, %2  : i8
    %7 = llvm.xor %5, %0  : i8
    %8 = llvm.sdiv %7, %6  : i8
    %9 = llvm.sdiv %8, %4  : i8
    llvm.return %9 : i8
  }
  llvm.func @demorgan_nor_use2bc(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(23 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mul %arg1, %0  : i8
    %3 = llvm.xor %arg0, %1  : i8
    %4 = llvm.or %3, %arg1  : i8
    %5 = llvm.mul %4, %0  : i8
    %6 = llvm.xor %4, %1  : i8
    %7 = llvm.sdiv %6, %5  : i8
    %8 = llvm.sdiv %7, %2  : i8
    llvm.return %8 : i8
  }
  llvm.func @demorganize_constant1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.xor %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @demorganize_constant2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.xor %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @demorgan_or_zext(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.xor %1, %0  : i32
    %4 = llvm.xor %2, %0  : i32
    %5 = llvm.or %3, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @demorgan_and_zext(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.xor %1, %0  : i32
    %4 = llvm.xor %2, %0  : i32
    %5 = llvm.and %3, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @demorgan_or_zext_vec(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.zext %arg0 : vector<2xi1> to vector<2xi32>
    %2 = llvm.zext %arg1 : vector<2xi1> to vector<2xi32>
    %3 = llvm.xor %1, %0  : vector<2xi32>
    %4 = llvm.xor %2, %0  : vector<2xi32>
    %5 = llvm.or %3, %4  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }
  llvm.func @demorgan_and_zext_vec(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.zext %arg0 : vector<2xi1> to vector<2xi32>
    %2 = llvm.zext %arg1 : vector<2xi1> to vector<2xi32>
    %3 = llvm.xor %1, %0  : vector<2xi32>
    %4 = llvm.xor %2, %0  : vector<2xi32>
    %5 = llvm.and %3, %4  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }
  llvm.func @PR28476(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.icmp "ne" %arg0, %0 : i32
    %3 = llvm.icmp "ne" %arg1, %0 : i32
    %4 = llvm.and %2, %3  : i1
    %5 = llvm.zext %4 : i1 to i32
    %6 = llvm.xor %5, %1  : i32
    llvm.return %6 : i32
  }
  llvm.func @PR28476_logical(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.icmp "ne" %arg0, %0 : i32
    %4 = llvm.icmp "ne" %arg1, %0 : i32
    %5 = llvm.select %3, %4, %1 : i1, i1
    %6 = llvm.zext %5 : i1 to i32
    %7 = llvm.xor %6, %2  : i32
    llvm.return %7 : i32
  }
  llvm.func @demorgan_plus_and_to_xor(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %arg1, %arg0  : i32
    %4 = llvm.or %3, %2  : i32
    %5 = llvm.xor %4, %0  : i32
    llvm.return %5 : i32
  }
  llvm.func @demorgan_plus_and_to_xor_vec(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.or %arg0, %arg1  : vector<4xi32>
    %2 = llvm.xor %1, %0  : vector<4xi32>
    %3 = llvm.and %arg0, %arg1  : vector<4xi32>
    %4 = llvm.or %3, %2  : vector<4xi32>
    %5 = llvm.xor %4, %0  : vector<4xi32>
    llvm.return %5 : vector<4xi32>
  }
  llvm.func @PR45984(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %arg0  : i32
    %2 = llvm.or %arg1, %arg0  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.or %1, %3  : i32
    llvm.return %4 : i32
  }
}
