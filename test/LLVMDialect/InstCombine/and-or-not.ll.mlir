module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(i4)
  llvm.func @and_to_xor1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.and %1, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @and_to_xor2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @and_to_xor3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.and %arg1, %arg0  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.and %1, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @and_to_xor4(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @and_to_xor1_vec(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.or %arg0, %arg1  : vector<4xi32>
    %2 = llvm.and %arg0, %arg1  : vector<4xi32>
    %3 = llvm.xor %2, %0  : vector<4xi32>
    %4 = llvm.and %1, %3  : vector<4xi32>
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @and_to_nxor1(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.fptosi %arg0 : f32 to i32
    %2 = llvm.fptosi %arg1 : f32 to i32
    %3 = llvm.xor %1, %0  : i32
    %4 = llvm.xor %2, %0  : i32
    %5 = llvm.or %1, %4  : i32
    %6 = llvm.or %3, %2  : i32
    %7 = llvm.and %5, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @and_to_nxor2(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.fptosi %arg0 : f32 to i32
    %2 = llvm.fptosi %arg1 : f32 to i32
    %3 = llvm.xor %1, %0  : i32
    %4 = llvm.xor %2, %0  : i32
    %5 = llvm.or %1, %4  : i32
    %6 = llvm.or %2, %3  : i32
    %7 = llvm.and %5, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @and_to_nxor3(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.fptosi %arg0 : f32 to i32
    %2 = llvm.fptosi %arg1 : f32 to i32
    %3 = llvm.xor %1, %0  : i32
    %4 = llvm.xor %2, %0  : i32
    %5 = llvm.or %3, %2  : i32
    %6 = llvm.or %1, %4  : i32
    %7 = llvm.and %5, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @and_to_nxor4(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.fptosi %arg0 : f32 to i32
    %2 = llvm.fptosi %arg1 : f32 to i32
    %3 = llvm.xor %1, %0  : i32
    %4 = llvm.xor %2, %0  : i32
    %5 = llvm.or %3, %2  : i32
    %6 = llvm.or %4, %1  : i32
    %7 = llvm.and %5, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @or_to_xor1(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.fptosi %arg0 : f32 to i32
    %2 = llvm.fptosi %arg1 : f32 to i32
    %3 = llvm.xor %1, %0  : i32
    %4 = llvm.xor %2, %0  : i32
    %5 = llvm.and %1, %4  : i32
    %6 = llvm.and %3, %2  : i32
    %7 = llvm.or %5, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @or_to_xor2(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.fptosi %arg0 : f32 to i32
    %2 = llvm.fptosi %arg1 : f32 to i32
    %3 = llvm.xor %1, %0  : i32
    %4 = llvm.xor %2, %0  : i32
    %5 = llvm.and %1, %4  : i32
    %6 = llvm.and %2, %3  : i32
    %7 = llvm.or %5, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @or_to_xor3(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.fptosi %arg0 : f32 to i32
    %2 = llvm.fptosi %arg1 : f32 to i32
    %3 = llvm.xor %1, %0  : i32
    %4 = llvm.xor %2, %0  : i32
    %5 = llvm.and %3, %2  : i32
    %6 = llvm.and %4, %1  : i32
    %7 = llvm.or %5, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @or_to_xor4(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.fptosi %arg0 : f32 to i32
    %2 = llvm.fptosi %arg1 : f32 to i32
    %3 = llvm.xor %1, %0  : i32
    %4 = llvm.xor %2, %0  : i32
    %5 = llvm.and %3, %2  : i32
    %6 = llvm.and %1, %4  : i32
    %7 = llvm.or %5, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @or_to_nxor1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.or %arg0, %arg1  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.or %1, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @or_to_nxor2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.or %arg1, %arg0  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.or %1, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @or_to_nxor3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.or %arg0, %arg1  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.or %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @or_to_nxor4(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.or %arg0, %arg1  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.or %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @xor_to_xor1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.and %arg0, %arg1  : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.xor %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @xor_to_xor2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.and %arg0, %arg1  : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @xor_to_xor3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.or %arg0, %arg1  : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.xor %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @xor_to_xor4(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.or %arg0, %arg1  : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @xor_to_xor5(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.fptosi %arg0 : f32 to i32
    %2 = llvm.fptosi %arg1 : f32 to i32
    %3 = llvm.xor %1, %0  : i32
    %4 = llvm.xor %2, %0  : i32
    %5 = llvm.or %1, %4  : i32
    %6 = llvm.or %3, %2  : i32
    %7 = llvm.xor %5, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @xor_to_xor6(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.fptosi %arg0 : f32 to i32
    %2 = llvm.fptosi %arg1 : f32 to i32
    %3 = llvm.xor %1, %0  : i32
    %4 = llvm.xor %2, %0  : i32
    %5 = llvm.or %1, %4  : i32
    %6 = llvm.or %2, %3  : i32
    %7 = llvm.xor %5, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @xor_to_xor7(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.fptosi %arg0 : f32 to i32
    %2 = llvm.fptosi %arg1 : f32 to i32
    %3 = llvm.xor %1, %0  : i32
    %4 = llvm.xor %2, %0  : i32
    %5 = llvm.or %1, %4  : i32
    %6 = llvm.or %3, %2  : i32
    %7 = llvm.xor %6, %5  : i32
    llvm.return %7 : i32
  }
  llvm.func @xor_to_xor8(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.fptosi %arg0 : f32 to i32
    %2 = llvm.fptosi %arg1 : f32 to i32
    %3 = llvm.xor %1, %0  : i32
    %4 = llvm.xor %2, %0  : i32
    %5 = llvm.or %4, %1  : i32
    %6 = llvm.or %3, %2  : i32
    %7 = llvm.xor %6, %5  : i32
    llvm.return %7 : i32
  }
  llvm.func @xor_to_xor9(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.fptosi %arg0 : f32 to i32
    %2 = llvm.fptosi %arg1 : f32 to i32
    %3 = llvm.xor %1, %0  : i32
    %4 = llvm.xor %2, %0  : i32
    %5 = llvm.and %1, %4  : i32
    %6 = llvm.and %3, %2  : i32
    %7 = llvm.xor %5, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @xor_to_xor10(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.fptosi %arg0 : f32 to i32
    %2 = llvm.fptosi %arg1 : f32 to i32
    %3 = llvm.xor %1, %0  : i32
    %4 = llvm.xor %2, %0  : i32
    %5 = llvm.and %1, %4  : i32
    %6 = llvm.and %2, %3  : i32
    %7 = llvm.xor %5, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @xor_to_xor11(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.fptosi %arg0 : f32 to i32
    %2 = llvm.fptosi %arg1 : f32 to i32
    %3 = llvm.xor %1, %0  : i32
    %4 = llvm.xor %2, %0  : i32
    %5 = llvm.and %1, %4  : i32
    %6 = llvm.and %3, %2  : i32
    %7 = llvm.xor %6, %5  : i32
    llvm.return %7 : i32
  }
  llvm.func @xor_to_xor12(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.fptosi %arg0 : f32 to i32
    %2 = llvm.fptosi %arg1 : f32 to i32
    %3 = llvm.xor %1, %0  : i32
    %4 = llvm.xor %2, %0  : i32
    %5 = llvm.and %4, %1  : i32
    %6 = llvm.and %3, %2  : i32
    %7 = llvm.xor %6, %5  : i32
    llvm.return %7 : i32
  }
  llvm.func @PR32830(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.xor %arg0, %0  : i64
    %2 = llvm.xor %arg1, %0  : i64
    %3 = llvm.or %2, %arg0  : i64
    %4 = llvm.or %1, %arg2  : i64
    %5 = llvm.and %3, %4  : i64
    llvm.return %5 : i64
  }
  llvm.func @and_to_nxor_multiuse(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.fptosi %arg0 : f32 to i32
    %2 = llvm.fptosi %arg1 : f32 to i32
    %3 = llvm.xor %1, %0  : i32
    %4 = llvm.xor %2, %0  : i32
    %5 = llvm.or %3, %2  : i32
    %6 = llvm.or %4, %1  : i32
    %7 = llvm.and %5, %6  : i32
    %8 = llvm.mul %5, %6  : i32
    %9 = llvm.mul %8, %7  : i32
    llvm.return %9 : i32
  }
  llvm.func @or_to_nxor_multiuse(%arg0: i32 {llvm.noundef}, %arg1: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.or %arg0, %arg1  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.or %1, %3  : i32
    %5 = llvm.mul %1, %3  : i32
    %6 = llvm.mul %5, %4  : i32
    llvm.return %6 : i32
  }
  llvm.func @xor_to_xnor1(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.fptosi %arg0 : f32 to i32
    %2 = llvm.fptosi %arg1 : f32 to i32
    %3 = llvm.xor %1, %0  : i32
    %4 = llvm.xor %2, %0  : i32
    %5 = llvm.or %1, %2  : i32
    %6 = llvm.or %3, %4  : i32
    %7 = llvm.xor %5, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @xor_to_xnor2(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.fptosi %arg0 : f32 to i32
    %2 = llvm.fptosi %arg1 : f32 to i32
    %3 = llvm.xor %1, %0  : i32
    %4 = llvm.xor %2, %0  : i32
    %5 = llvm.or %1, %2  : i32
    %6 = llvm.or %4, %3  : i32
    %7 = llvm.xor %5, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @xor_to_xnor3(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.fptosi %arg0 : f32 to i32
    %2 = llvm.fptosi %arg1 : f32 to i32
    %3 = llvm.xor %1, %0  : i32
    %4 = llvm.xor %2, %0  : i32
    %5 = llvm.or %3, %4  : i32
    %6 = llvm.or %1, %2  : i32
    %7 = llvm.xor %5, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @xor_to_xnor4(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.fptosi %arg0 : f32 to i32
    %2 = llvm.fptosi %arg1 : f32 to i32
    %3 = llvm.xor %1, %0  : i32
    %4 = llvm.xor %2, %0  : i32
    %5 = llvm.or %3, %4  : i32
    %6 = llvm.or %2, %1  : i32
    %7 = llvm.xor %5, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @simplify_or_common_op_commute0(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.and %arg0, %arg1  : i4
    %2 = llvm.and %1, %arg2  : i4
    %3 = llvm.xor %2, %0  : i4
    %4 = llvm.or %3, %arg0  : i4
    llvm.return %4 : i4
  }
  llvm.func @simplify_or_common_op_commute1(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.and %arg1, %arg0  : i4
    %2 = llvm.and %1, %arg2  : i4
    %3 = llvm.xor %2, %0  : i4
    %4 = llvm.or %3, %arg0  : i4
    llvm.return %4 : i4
  }
  llvm.func @simplify_or_common_op_commute2(%arg0: i4, %arg1: i4, %arg2: i4, %arg3: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mul %arg2, %arg2  : i4
    %2 = llvm.and %arg0, %arg1  : i4
    %3 = llvm.and %1, %2  : i4
    %4 = llvm.and %3, %arg3  : i4
    %5 = llvm.xor %4, %0  : i4
    %6 = llvm.or %5, %arg0  : i4
    llvm.return %6 : i4
  }
  llvm.func @simplify_or_common_op_commute3(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.mul %arg2, %arg2  : vector<2xi4>
    %3 = llvm.and %arg1, %arg0  : vector<2xi4>
    %4 = llvm.and %2, %3  : vector<2xi4>
    %5 = llvm.xor %4, %1  : vector<2xi4>
    %6 = llvm.or %arg0, %5  : vector<2xi4>
    llvm.return %6 : vector<2xi4>
  }
  llvm.func @simplify_and_common_op_commute0(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.or %arg0, %arg1  : i4
    llvm.call @use(%arg0) : (i4) -> ()
    %2 = llvm.or %1, %arg2  : i4
    %3 = llvm.xor %2, %0  : i4
    %4 = llvm.and %3, %arg0  : i4
    llvm.return %4 : i4
  }
  llvm.func @simplify_and_common_op_commute1(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.or %arg1, %arg0  : i4
    %2 = llvm.or %1, %arg2  : i4
    %3 = llvm.xor %2, %0  : i4
    %4 = llvm.and %3, %arg0  : i4
    llvm.return %4 : i4
  }
  llvm.func @simplify_and_common_op_commute2(%arg0: i4, %arg1: i4, %arg2: i4, %arg3: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mul %arg2, %arg2  : i4
    %2 = llvm.or %arg0, %arg1  : i4
    %3 = llvm.or %1, %2  : i4
    %4 = llvm.or %3, %arg3  : i4
    %5 = llvm.xor %4, %0  : i4
    %6 = llvm.and %5, %arg0  : i4
    llvm.return %6 : i4
  }
  llvm.func @simplify_and_common_op_commute3(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.mul %arg2, %arg2  : vector<2xi4>
    %3 = llvm.or %arg1, %arg0  : vector<2xi4>
    %4 = llvm.or %2, %3  : vector<2xi4>
    %5 = llvm.xor %4, %1  : vector<2xi4>
    %6 = llvm.and %arg0, %5  : vector<2xi4>
    llvm.return %6 : vector<2xi4>
  }
  llvm.func @simplify_and_common_op_use1(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.or %arg0, %arg1  : i4
    llvm.call @use(%arg1) : (i4) -> ()
    %2 = llvm.or %1, %arg2  : i4
    %3 = llvm.xor %2, %0  : i4
    %4 = llvm.and %3, %arg0  : i4
    llvm.return %4 : i4
  }
  llvm.func @simplify_and_common_op_use2(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.or %arg1, %arg0  : i4
    llvm.call @use(%arg1) : (i4) -> ()
    %2 = llvm.or %1, %arg2  : i4
    %3 = llvm.xor %2, %0  : i4
    %4 = llvm.and %3, %arg0  : i4
    llvm.return %4 : i4
  }
  llvm.func @simplify_and_common_op_use3(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.or %arg0, %arg1  : i4
    %2 = llvm.or %1, %arg2  : i4
    llvm.call @use(%arg2) : (i4) -> ()
    %3 = llvm.xor %2, %0  : i4
    %4 = llvm.and %3, %arg0  : i4
    llvm.return %4 : i4
  }
  llvm.func @reduce_xor_common_op_commute0(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.xor %arg0, %arg1  : i4
    %1 = llvm.xor %0, %arg2  : i4
    %2 = llvm.or %1, %arg0  : i4
    llvm.return %2 : i4
  }
  llvm.func @reduce_xor_common_op_commute1(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.xor %arg1, %arg0  : i4
    %1 = llvm.xor %0, %arg2  : i4
    %2 = llvm.or %1, %arg0  : i4
    llvm.return %2 : i4
  }
  llvm.func @annihilate_xor_common_op_commute2(%arg0: i4, %arg1: i4, %arg2: i4, %arg3: i4) -> i4 {
    %0 = llvm.mul %arg2, %arg2  : i4
    %1 = llvm.xor %arg0, %arg1  : i4
    %2 = llvm.xor %0, %1  : i4
    %3 = llvm.xor %2, %arg3  : i4
    %4 = llvm.xor %3, %arg0  : i4
    llvm.return %4 : i4
  }
  llvm.func @reduce_xor_common_op_commute3(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mul %arg2, %arg2  : vector<2xi4>
    %1 = llvm.xor %arg1, %arg0  : vector<2xi4>
    %2 = llvm.xor %0, %1  : vector<2xi4>
    %3 = llvm.or %arg0, %2  : vector<2xi4>
    llvm.return %3 : vector<2xi4>
  }
}
