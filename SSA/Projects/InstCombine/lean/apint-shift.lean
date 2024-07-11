
def test6_before := [llvm|
{
^0(%arg0 : i55):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i55}> : () -> i55
  %1 = "llvm.mlir.constant"() <{"value" = 3 : i55}> : () -> i55
  %2 = llvm.shl %arg0, %0 : i55
  %3 = llvm.mul %2, %1 : i55
  "llvm.return"(%3) : (i55) -> ()
}
]
def test6_after := [llvm|
{
^0(%arg0 : i55):
  %0 = "llvm.mlir.constant"() <{"value" = 6 : i55}> : () -> i55
  %1 = llvm.mul %arg0, %0 : i55
  "llvm.return"(%1) : (i55) -> ()
}
]
theorem test6_proof : test6_before ⊑ test6_after := by
  sorry



def test6a_before := [llvm|
{
^0(%arg0 : i55):
  %0 = "llvm.mlir.constant"() <{"value" = 3 : i55}> : () -> i55
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i55}> : () -> i55
  %2 = llvm.mul %arg0, %0 : i55
  %3 = llvm.shl %2, %1 : i55
  "llvm.return"(%3) : (i55) -> ()
}
]
def test6a_after := [llvm|
{
^0(%arg0 : i55):
  %0 = "llvm.mlir.constant"() <{"value" = 6 : i55}> : () -> i55
  %1 = llvm.mul %arg0, %0 : i55
  "llvm.return"(%1) : (i55) -> ()
}
]
theorem test6a_proof : test6a_before ⊑ test6a_after := by
  sorry



def test6a_vec_before := [llvm|
{
^0(%arg0 : vector<2xi55>):
  %0 = "llvm.mlir.constant"() <{"value" = 12 : i55}> : () -> i55
  %1 = "llvm.mlir.constant"() <{"value" = 3 : i55}> : () -> i55
  %2 = "llvm.mlir.constant"() <{"value" = dense<[3, 12]> : vector<2xi55>}> : () -> vector<2xi55>
  %3 = "llvm.mlir.constant"() <{"value" = 2 : i55}> : () -> i55
  %4 = "llvm.mlir.constant"() <{"value" = 1 : i55}> : () -> i55
  %5 = "llvm.mlir.constant"() <{"value" = dense<[1, 2]> : vector<2xi55>}> : () -> vector<2xi55>
  %6 = llvm.mul %arg0, %2 : vector<2xi55>
  %7 = llvm.shl %6, %5 : vector<2xi55>
  "llvm.return"(%7) : (vector<2xi55>) -> ()
}
]
def test6a_vec_after := [llvm|
{
^0(%arg0 : vector<2xi55>):
  %0 = "llvm.mlir.constant"() <{"value" = 48 : i55}> : () -> i55
  %1 = "llvm.mlir.constant"() <{"value" = 6 : i55}> : () -> i55
  %2 = "llvm.mlir.constant"() <{"value" = dense<[6, 48]> : vector<2xi55>}> : () -> vector<2xi55>
  %3 = llvm.mul %arg0, %2 : vector<2xi55>
  "llvm.return"(%3) : (vector<2xi55>) -> ()
}
]
theorem test6a_vec_proof : test6a_vec_before ⊑ test6a_vec_after := by
  sorry



def test8_before := [llvm|
{
^0(%arg0 : i7):
  %0 = "llvm.mlir.constant"() <{"value" = 4 : i7}> : () -> i7
  %1 = "llvm.mlir.constant"() <{"value" = 3 : i7}> : () -> i7
  %2 = llvm.shl %arg0, %0 : i7
  %3 = llvm.shl %2, %1 : i7
  "llvm.return"(%3) : (i7) -> ()
}
]
def test8_after := [llvm|
{
^0(%arg0 : i7):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i7}> : () -> i7
  "llvm.return"(%0) : (i7) -> ()
}
]
theorem test8_proof : test8_before ⊑ test8_after := by
  sorry



def shl_shl_splat_vec_before := [llvm|
{
^0(%arg0 : vector<2xi19>):
  %0 = "llvm.mlir.constant"() <{"value" = 3 : i19}> : () -> i19
  %1 = "llvm.mlir.constant"() <{"value" = dense<3> : vector<2xi19>}> : () -> vector<2xi19>
  %2 = "llvm.mlir.constant"() <{"value" = 2 : i19}> : () -> i19
  %3 = "llvm.mlir.constant"() <{"value" = dense<2> : vector<2xi19>}> : () -> vector<2xi19>
  %4 = llvm.shl %arg0, %1 : vector<2xi19>
  %5 = llvm.shl %4, %3 : vector<2xi19>
  "llvm.return"(%5) : (vector<2xi19>) -> ()
}
]
def shl_shl_splat_vec_after := [llvm|
{
^0(%arg0 : vector<2xi19>):
  %0 = "llvm.mlir.constant"() <{"value" = 5 : i19}> : () -> i19
  %1 = "llvm.mlir.constant"() <{"value" = dense<5> : vector<2xi19>}> : () -> vector<2xi19>
  %2 = llvm.shl %arg0, %1 : vector<2xi19>
  "llvm.return"(%2) : (vector<2xi19>) -> ()
}
]
theorem shl_shl_splat_vec_proof : shl_shl_splat_vec_before ⊑ shl_shl_splat_vec_after := by
  sorry



def multiuse_shl_shl_before := [llvm|
{
^0(%arg0 : i42):
  %0 = "llvm.mlir.constant"() <{"value" = 8 : i42}> : () -> i42
  %1 = "llvm.mlir.constant"() <{"value" = 9 : i42}> : () -> i42
  %2 = llvm.shl %arg0, %0 : i42
  %3 = llvm.shl %2, %1 : i42
  %4 = llvm.mul %2, %3 : i42
  "llvm.return"(%4) : (i42) -> ()
}
]
def multiuse_shl_shl_after := [llvm|
{
^0(%arg0 : i42):
  %0 = "llvm.mlir.constant"() <{"value" = 8 : i42}> : () -> i42
  %1 = "llvm.mlir.constant"() <{"value" = 17 : i42}> : () -> i42
  %2 = llvm.shl %arg0, %0 : i42
  %3 = llvm.shl %arg0, %1 : i42
  %4 = llvm.mul %2, %3 : i42
  "llvm.return"(%4) : (i42) -> ()
}
]
theorem multiuse_shl_shl_proof : multiuse_shl_shl_before ⊑ multiuse_shl_shl_after := by
  sorry



def multiuse_shl_shl_splat_before := [llvm|
{
^0(%arg0 : vector<2xi42>):
  %0 = "llvm.mlir.constant"() <{"value" = 8 : i42}> : () -> i42
  %1 = "llvm.mlir.constant"() <{"value" = dense<8> : vector<2xi42>}> : () -> vector<2xi42>
  %2 = "llvm.mlir.constant"() <{"value" = 9 : i42}> : () -> i42
  %3 = "llvm.mlir.constant"() <{"value" = dense<9> : vector<2xi42>}> : () -> vector<2xi42>
  %4 = llvm.shl %arg0, %1 : vector<2xi42>
  %5 = llvm.shl %4, %3 : vector<2xi42>
  %6 = llvm.mul %4, %5 : vector<2xi42>
  "llvm.return"(%6) : (vector<2xi42>) -> ()
}
]
def multiuse_shl_shl_splat_after := [llvm|
{
^0(%arg0 : vector<2xi42>):
  %0 = "llvm.mlir.constant"() <{"value" = 8 : i42}> : () -> i42
  %1 = "llvm.mlir.constant"() <{"value" = dense<8> : vector<2xi42>}> : () -> vector<2xi42>
  %2 = "llvm.mlir.constant"() <{"value" = 17 : i42}> : () -> i42
  %3 = "llvm.mlir.constant"() <{"value" = dense<17> : vector<2xi42>}> : () -> vector<2xi42>
  %4 = llvm.shl %arg0, %1 : vector<2xi42>
  %5 = llvm.shl %arg0, %3 : vector<2xi42>
  %6 = llvm.mul %4, %5 : vector<2xi42>
  "llvm.return"(%6) : (vector<2xi42>) -> ()
}
]
theorem multiuse_shl_shl_splat_proof : multiuse_shl_shl_splat_before ⊑ multiuse_shl_shl_splat_after := by
  sorry



def test21_before := [llvm|
{
^0(%arg0 : i12):
  %0 = "llvm.mlir.constant"() <{"value" = 6 : i12}> : () -> i12
  %1 = "llvm.mlir.constant"() <{"value" = -128 : i12}> : () -> i12
  %2 = llvm.shl %arg0, %0 : i12
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i12, i12) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def test21_after := [llvm|
{
^0(%arg0 : i12):
  %0 = "llvm.mlir.constant"() <{"value" = 63 : i12}> : () -> i12
  %1 = "llvm.mlir.constant"() <{"value" = 62 : i12}> : () -> i12
  %2 = llvm.and %arg0, %0 : i12
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i12, i12) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem test21_proof : test21_before ⊑ test21_after := by
  sorry



def test22_before := [llvm|
{
^0(%arg0 : i14):
  %0 = "llvm.mlir.constant"() <{"value" = 7 : i14}> : () -> i14
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i14}> : () -> i14
  %2 = llvm.shl %arg0, %0 : i14
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i14, i14) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def test22_after := [llvm|
{
^0(%arg0 : i14):
  %0 = "llvm.mlir.constant"() <{"value" = 127 : i14}> : () -> i14
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i14}> : () -> i14
  %2 = llvm.and %arg0, %0 : i14
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i14, i14) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem test22_proof : test22_before ⊑ test22_after := by
  sorry


