module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @smax_of_smax_smin_commute0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg0, %arg1 : i1, i32
    %2 = llvm.icmp "slt" %arg1, %arg0 : i32
    %3 = llvm.select %2, %arg0, %arg1 : i1, i32
    %4 = llvm.icmp "sgt" %3, %1 : i32
    %5 = llvm.select %4, %3, %1 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @smax_of_smax_smin_commute1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg1, %arg0 : i1, i32
    %2 = llvm.icmp "sgt" %arg0, %arg1 : i32
    %3 = llvm.select %2, %arg0, %arg1 : i1, i32
    %4 = llvm.icmp "sgt" %3, %1 : i32
    %5 = llvm.select %4, %3, %1 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @smax_of_smax_smin_commute2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg0, %arg1 : i1, i32
    %2 = llvm.icmp "slt" %arg1, %arg0 : i32
    %3 = llvm.select %2, %arg0, %arg1 : i1, i32
    %4 = llvm.icmp "slt" %1, %3 : i32
    %5 = llvm.select %4, %3, %1 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @smax_of_smax_smin_commute3(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : vector<2xi32>
    %1 = llvm.select %0, %arg1, %arg0 : vector<2xi1>, vector<2xi32>
    %2 = llvm.icmp "sgt" %arg0, %arg1 : vector<2xi32>
    %3 = llvm.select %2, %arg0, %arg1 : vector<2xi1>, vector<2xi32>
    %4 = llvm.icmp "slt" %1, %3 : vector<2xi32>
    %5 = llvm.select %4, %3, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }
  llvm.func @smin_of_smin_smax_commute0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg0, %arg1 : i1, i32
    %2 = llvm.icmp "sgt" %arg1, %arg0 : i32
    %3 = llvm.select %2, %arg0, %arg1 : i1, i32
    %4 = llvm.icmp "sgt" %1, %3 : i32
    %5 = llvm.select %4, %3, %1 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @smin_of_smin_smax_commute1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg1, %arg0 : i1, i32
    %2 = llvm.icmp "slt" %arg0, %arg1 : i32
    %3 = llvm.select %2, %arg0, %arg1 : i1, i32
    %4 = llvm.icmp "sgt" %1, %3 : i32
    %5 = llvm.select %4, %3, %1 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @smin_of_smin_smax_commute2(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : vector<2xi32>
    %1 = llvm.select %0, %arg0, %arg1 : vector<2xi1>, vector<2xi32>
    %2 = llvm.icmp "slt" %arg0, %arg1 : vector<2xi32>
    %3 = llvm.select %2, %arg0, %arg1 : vector<2xi1>, vector<2xi32>
    %4 = llvm.icmp "slt" %3, %1 : vector<2xi32>
    %5 = llvm.select %4, %3, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }
  llvm.func @smin_of_smin_smax_commute3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg1, %arg0 : i1, i32
    %2 = llvm.icmp "sgt" %arg1, %arg0 : i32
    %3 = llvm.select %2, %arg0, %arg1 : i1, i32
    %4 = llvm.icmp "slt" %3, %1 : i32
    %5 = llvm.select %4, %3, %1 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @umax_of_umax_umin_commute0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg0, %arg1 : i1, i32
    %2 = llvm.icmp "ult" %arg1, %arg0 : i32
    %3 = llvm.select %2, %arg0, %arg1 : i1, i32
    %4 = llvm.icmp "ugt" %3, %1 : i32
    %5 = llvm.select %4, %3, %1 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @umax_of_umax_umin_commute1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg1, %arg0 : i1, i32
    %2 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %3 = llvm.select %2, %arg0, %arg1 : i1, i32
    %4 = llvm.icmp "ugt" %3, %1 : i32
    %5 = llvm.select %4, %3, %1 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @umax_of_umax_umin_commute2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg0, %arg1 : i1, i32
    %2 = llvm.icmp "ult" %arg1, %arg0 : i32
    %3 = llvm.select %2, %arg0, %arg1 : i1, i32
    %4 = llvm.icmp "ult" %1, %3 : i32
    %5 = llvm.select %4, %3, %1 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @umax_of_umax_umin_commute3(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.icmp "ugt" %arg0, %arg1 : vector<2xi32>
    %1 = llvm.select %0, %arg1, %arg0 : vector<2xi1>, vector<2xi32>
    %2 = llvm.icmp "ugt" %arg0, %arg1 : vector<2xi32>
    %3 = llvm.select %2, %arg0, %arg1 : vector<2xi1>, vector<2xi32>
    %4 = llvm.icmp "ult" %1, %3 : vector<2xi32>
    %5 = llvm.select %4, %3, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }
  llvm.func @umin_of_umin_umax_commute0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg0, %arg1 : i1, i32
    %2 = llvm.icmp "ugt" %arg1, %arg0 : i32
    %3 = llvm.select %2, %arg0, %arg1 : i1, i32
    %4 = llvm.icmp "ugt" %1, %3 : i32
    %5 = llvm.select %4, %3, %1 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @umin_of_umin_umax_commute1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg1, %arg0 : i1, i32
    %2 = llvm.icmp "ult" %arg0, %arg1 : i32
    %3 = llvm.select %2, %arg0, %arg1 : i1, i32
    %4 = llvm.icmp "ugt" %1, %3 : i32
    %5 = llvm.select %4, %3, %1 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @umin_of_umin_umax_commute2(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.icmp "ugt" %arg0, %arg1 : vector<2xi32>
    %1 = llvm.select %0, %arg0, %arg1 : vector<2xi1>, vector<2xi32>
    %2 = llvm.icmp "ult" %arg0, %arg1 : vector<2xi32>
    %3 = llvm.select %2, %arg0, %arg1 : vector<2xi1>, vector<2xi32>
    %4 = llvm.icmp "ult" %3, %1 : vector<2xi32>
    %5 = llvm.select %4, %3, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }
  llvm.func @umin_of_umin_umax_commute3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg1, %arg0 : i1, i32
    %2 = llvm.icmp "ugt" %arg1, %arg0 : i32
    %3 = llvm.select %2, %arg0, %arg1 : i1, i32
    %4 = llvm.icmp "ult" %3, %1 : i32
    %5 = llvm.select %4, %3, %1 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @umin_of_smin_umax_wrong_pattern(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg0, %arg1 : i1, i32
    %2 = llvm.icmp "sgt" %arg1, %arg0 : i32
    %3 = llvm.select %2, %arg0, %arg1 : i1, i32
    %4 = llvm.icmp "ugt" %1, %3 : i32
    %5 = llvm.select %4, %3, %1 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @smin_of_umin_umax_wrong_pattern2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg1, %arg0 : i1, i32
    %2 = llvm.icmp "ult" %arg0, %arg1 : i32
    %3 = llvm.select %2, %arg0, %arg1 : i1, i32
    %4 = llvm.icmp "sgt" %1, %3 : i32
    %5 = llvm.select %4, %3, %1 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @umin_of_umin_umax_wrong_operand(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.icmp "ugt" %arg0, %arg1 : vector<2xi32>
    %1 = llvm.select %0, %arg0, %arg1 : vector<2xi1>, vector<2xi32>
    %2 = llvm.icmp "ult" %arg0, %arg2 : vector<2xi32>
    %3 = llvm.select %2, %arg0, %arg2 : vector<2xi1>, vector<2xi32>
    %4 = llvm.icmp "ult" %3, %1 : vector<2xi32>
    %5 = llvm.select %4, %3, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }
  llvm.func @umin_of_umin_umax_wrong_operand2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.icmp "ult" %arg0, %arg2 : i32
    %1 = llvm.select %0, %arg2, %arg0 : i1, i32
    %2 = llvm.icmp "ugt" %arg1, %arg0 : i32
    %3 = llvm.select %2, %arg0, %arg1 : i1, i32
    %4 = llvm.icmp "ult" %3, %1 : i32
    %5 = llvm.select %4, %3, %1 : i1, i32
    llvm.return %5 : i32
  }
}
