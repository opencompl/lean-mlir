module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @zext(%arg0: i1) -> i41 {
    %0 = llvm.mlir.constant(1 : i41) : i41
    %1 = llvm.mlir.constant(0 : i41) : i41
    %2 = llvm.select %arg0, %0, %1 : i1, i41
    llvm.return %2 : i41
  }
  llvm.func @sext(%arg0: i1) -> i41 {
    %0 = llvm.mlir.constant(-1 : i41) : i41
    %1 = llvm.mlir.constant(0 : i41) : i41
    %2 = llvm.select %arg0, %0, %1 : i1, i41
    llvm.return %2 : i41
  }
  llvm.func @not_zext(%arg0: i1) -> i999 {
    %0 = llvm.mlir.constant(0 : i999) : i999
    %1 = llvm.mlir.constant(1 : i999) : i999
    %2 = llvm.select %arg0, %0, %1 : i1, i999
    llvm.return %2 : i999
  }
  llvm.func @not_sext(%arg0: i1) -> i999 {
    %0 = llvm.mlir.constant(0 : i999) : i999
    %1 = llvm.mlir.constant(-1 : i999) : i999
    %2 = llvm.select %arg0, %0, %1 : i1, i999
    llvm.return %2 : i999
  }
  llvm.func @zext_vec(%arg0: vector<2xi1>) -> vector<2xi41> {
    %0 = llvm.mlir.constant(1 : i41) : i41
    %1 = llvm.mlir.constant(dense<1> : vector<2xi41>) : vector<2xi41>
    %2 = llvm.mlir.constant(0 : i41) : i41
    %3 = llvm.mlir.constant(dense<0> : vector<2xi41>) : vector<2xi41>
    %4 = llvm.select %arg0, %1, %3 : vector<2xi1>, vector<2xi41>
    llvm.return %4 : vector<2xi41>
  }
  llvm.func @sext_vec(%arg0: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.select %arg0, %0, %2 : vector<2xi1>, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @not_zext_vec(%arg0: vector<2xi1>) -> vector<2xi999> {
    %0 = llvm.mlir.constant(0 : i999) : i999
    %1 = llvm.mlir.constant(dense<0> : vector<2xi999>) : vector<2xi999>
    %2 = llvm.mlir.constant(1 : i999) : i999
    %3 = llvm.mlir.constant(dense<1> : vector<2xi999>) : vector<2xi999>
    %4 = llvm.select %arg0, %1, %3 : vector<2xi1>, vector<2xi999>
    llvm.return %4 : vector<2xi999>
  }
  llvm.func @not_sext_vec(%arg0: vector<2xi1>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.mlir.constant(dense<-1> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.select %arg0, %1, %2 : vector<2xi1>, vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }
  llvm.func @scalar_select_of_vectors(%arg0: i1) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.select %arg0, %0, %2 : i1, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @test3(%arg0: i41) -> i41 {
    %0 = llvm.mlir.constant(0 : i41) : i41
    %1 = llvm.mlir.constant(-1 : i41) : i41
    %2 = llvm.icmp "slt" %arg0, %0 : i41
    %3 = llvm.select %2, %1, %0 : i1, i41
    llvm.return %3 : i41
  }
  llvm.func @test4(%arg0: i1023) -> i1023 {
    %0 = llvm.mlir.constant(0 : i1023) : i1023
    %1 = llvm.mlir.constant(-1 : i1023) : i1023
    %2 = llvm.icmp "slt" %arg0, %0 : i1023
    %3 = llvm.select %2, %1, %0 : i1, i1023
    llvm.return %3 : i1023
  }
}
