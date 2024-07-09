module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global private unnamed_addr constant @charbuf("\00\00\00\01") {addr_space = 0 : i32, alignment = 1 : i64, dso_local}
  llvm.mlir.global private unnamed_addr constant @intbuf_unaligned(dense<[1, 2, 3, 4]> : tensor<4xi16>) {addr_space = 0 : i32, alignment = 1 : i64, dso_local} : !llvm.array<4 x i16>
  llvm.mlir.global private unnamed_addr constant @intbuf(dense<[0, 1]> : tensor<2xi32>) {addr_space = 0 : i32, alignment = 4 : i64, dso_local} : !llvm.array<2 x i32>
  llvm.func @memcmp(!llvm.ptr, !llvm.ptr, i64) -> i32
  llvm.func @memcmp_4bytes_unaligned_constant_i8(%arg0: !llvm.ptr {llvm.align = 4 : i64}) -> i1 {
    %0 = llvm.mlir.constant("\00\00\00\01") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @charbuf : !llvm.ptr
    %2 = llvm.mlir.constant(4 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @memcmp(%arg0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "eq" %4, %3 : i32
    llvm.return %5 : i1
  }
  llvm.func @memcmp_4bytes_unaligned_constant_i16(%arg0: !llvm.ptr {llvm.align = 4 : i64}) -> i1 {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : tensor<4xi16>) : !llvm.array<4 x i16>
    %1 = llvm.mlir.addressof @intbuf_unaligned : !llvm.ptr
    %2 = llvm.mlir.constant(4 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @memcmp(%1, %arg0, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "eq" %4, %3 : i32
    llvm.return %5 : i1
  }
  llvm.func @memcmp_3bytes_aligned_constant_i32(%arg0: !llvm.ptr {llvm.align = 4 : i64}) -> i1 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<[0, 1]> : tensor<2xi32>) : !llvm.array<2 x i32>
    %3 = llvm.mlir.addressof @intbuf : !llvm.ptr
    %4 = llvm.getelementptr inbounds %3[%1, %0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<2 x i32>
    %5 = llvm.mlir.constant(3 : i64) : i64
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.call @memcmp(%4, %3, %5) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %8 = llvm.icmp "eq" %7, %6 : i32
    llvm.return %8 : i1
  }
  llvm.func @memcmp_4bytes_one_unaligned_i8(%arg0: !llvm.ptr {llvm.align = 4 : i64}, %arg1: !llvm.ptr {llvm.align = 1 : i64}) -> i1 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32
    %3 = llvm.call @memcmp(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }
}
