module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @cttz_abs(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.select %1, %2, %arg0 : i1, i32
    %4 = "llvm.intr.cttz"(%3) <{is_zero_poison = true}> : (i32) -> i32
    llvm.return %4 : i32
  }
  llvm.func @cttz_abs_vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.icmp "slt" %arg0, %1 : vector<2xi64>
    %3 = llvm.sub %1, %arg0  : vector<2xi64>
    %4 = llvm.select %2, %3, %arg0 : vector<2xi1>, vector<2xi64>
    %5 = "llvm.intr.cttz"(%4) <{is_zero_poison = false}> : (vector<2xi64>) -> vector<2xi64>
    llvm.return %5 : vector<2xi64>
  }
  llvm.func @cttz_abs2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.call @use_cond(%1) : (i1) -> ()
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.select %1, %arg0, %2 : i1, i32
    %4 = "llvm.intr.cttz"(%3) <{is_zero_poison = true}> : (i32) -> i32
    llvm.return %4 : i32
  }
  llvm.func @cttz_abs3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.call @use_cond(%2) : (i1) -> ()
    %3 = llvm.sub %1, %arg0  : i32
    %4 = llvm.select %2, %arg0, %3 : i1, i32
    %5 = "llvm.intr.cttz"(%4) <{is_zero_poison = true}> : (i32) -> i32
    llvm.return %5 : i32
  }
  llvm.func @cttz_abs4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0  : i32
    %4 = llvm.select %2, %3, %arg0 : i1, i32
    %5 = "llvm.intr.cttz"(%4) <{is_zero_poison = true}> : (i32) -> i32
    llvm.return %5 : i32
  }
  llvm.func @cttz_nabs(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.select %1, %arg0, %2 : i1, i32
    %4 = "llvm.intr.cttz"(%3) <{is_zero_poison = false}> : (i32) -> i32
    llvm.return %4 : i32
  }
  llvm.func @cttz_nabs_vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.icmp "slt" %arg0, %1 : vector<2xi64>
    %3 = llvm.sub %1, %arg0  : vector<2xi64>
    %4 = llvm.select %2, %arg0, %3 : vector<2xi1>, vector<2xi64>
    %5 = "llvm.intr.cttz"(%4) <{is_zero_poison = false}> : (vector<2xi64>) -> vector<2xi64>
    llvm.return %5 : vector<2xi64>
  }
  llvm.func @cttz_abs_64(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    %2 = llvm.sub %0, %arg0  : i64
    %3 = llvm.select %1, %2, %arg0 : i1, i64
    %4 = "llvm.intr.cttz"(%3) <{is_zero_poison = false}> : (i64) -> i64
    llvm.return %4 : i64
  }
  llvm.func @cttz_abs_multiuse(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0  : i32
    %4 = llvm.select %2, %3, %arg0 : i1, i32
    llvm.call @use_abs(%4) : (i32) -> ()
    %5 = "llvm.intr.cttz"(%4) <{is_zero_poison = true}> : (i32) -> i32
    llvm.return %5 : i32
  }
  llvm.func @cttz_nabs_multiuse(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0  : i32
    %4 = llvm.select %2, %arg0, %3 : i1, i32
    llvm.call @use_abs(%4) : (i32) -> ()
    %5 = "llvm.intr.cttz"(%4) <{is_zero_poison = true}> : (i32) -> i32
    llvm.return %5 : i32
  }
  llvm.func @no_cttz_abs(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0  : i32
    %4 = llvm.select %2, %3, %arg0 : i1, i32
    %5 = "llvm.intr.cttz"(%4) <{is_zero_poison = true}> : (i32) -> i32
    llvm.return %5 : i32
  }
  llvm.func @no_cttz_abs2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0  : i32
    %4 = llvm.select %2, %3, %arg0 : i1, i32
    %5 = "llvm.intr.cttz"(%4) <{is_zero_poison = true}> : (i32) -> i32
    llvm.return %5 : i32
  }
  llvm.func @no_cttz_abs3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.call @use_cond(%2) : (i1) -> ()
    %3 = llvm.sub %1, %arg0  : i32
    %4 = llvm.select %2, %arg0, %3 : i1, i32
    %5 = "llvm.intr.cttz"(%4) <{is_zero_poison = true}> : (i32) -> i32
    llvm.return %5 : i32
  }
  llvm.func @no_cttz_abs_vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[2, 1]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<[1, 0]> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.icmp "slt" %arg0, %0 : vector<2xi64>
    %3 = llvm.sub %1, %arg0  : vector<2xi64>
    %4 = llvm.select %2, %3, %arg0 : vector<2xi1>, vector<2xi64>
    %5 = "llvm.intr.cttz"(%4) <{is_zero_poison = false}> : (vector<2xi64>) -> vector<2xi64>
    llvm.return %5 : vector<2xi64>
  }
  llvm.func @no_cttz_nabs_vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[2, 1]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<[1, 0]> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.icmp "slt" %arg0, %0 : vector<2xi64>
    %3 = llvm.sub %1, %arg0  : vector<2xi64>
    %4 = llvm.select %2, %arg0, %3 : vector<2xi1>, vector<2xi64>
    %5 = "llvm.intr.cttz"(%4) <{is_zero_poison = false}> : (vector<2xi64>) -> vector<2xi64>
    llvm.return %5 : vector<2xi64>
  }
  llvm.func @cttz_abs_intrin(%arg0: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32
    %1 = "llvm.intr.cttz"(%0) <{is_zero_poison = false}> : (i32) -> i32
    llvm.return %1 : i32
  }
  llvm.func @cttz_nabs_intrin(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32
    %2 = llvm.sub %0, %1  : i32
    %3 = "llvm.intr.cttz"(%2) <{is_zero_poison = false}> : (i32) -> i32
    llvm.return %3 : i32
  }
  llvm.func @use_cond(i1)
  llvm.func @use_abs(i32)
}
