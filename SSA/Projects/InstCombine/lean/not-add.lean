
def basic_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = llvm.xor %arg0, %0 : i8
  %2 = llvm.add %1, %arg1 : i8
  %3 = llvm.xor %2, %0 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def basic_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.sub %arg0, %arg1 : i8
  "llvm.return"(%0) : (i8) -> ()
}
]
theorem basic_proof : basic_before ⊑ basic_after := by
  sorry



def basic_com_add_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = llvm.xor %arg1, %0 : i8
  %2 = llvm.add %arg0, %1 : i8
  %3 = llvm.xor %2, %0 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def basic_com_add_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.sub %arg1, %arg0 : i8
  "llvm.return"(%0) : (i8) -> ()
}
]
theorem basic_com_add_proof : basic_com_add_before ⊑ basic_com_add_after := by
  sorry



def basic_preserve_nsw_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = llvm.xor %arg0, %0 : i8
  %2 = llvm.add %1, %arg1 : i8
  %3 = llvm.xor %2, %0 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def basic_preserve_nsw_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.sub %arg0, %arg1 : i8
  "llvm.return"(%0) : (i8) -> ()
}
]
theorem basic_preserve_nsw_proof : basic_preserve_nsw_before ⊑ basic_preserve_nsw_after := by
  sorry



def basic_preserve_nuw_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = llvm.xor %arg0, %0 : i8
  %2 = llvm.add %1, %arg1 : i8
  %3 = llvm.xor %2, %0 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def basic_preserve_nuw_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.sub %arg0, %arg1 : i8
  "llvm.return"(%0) : (i8) -> ()
}
]
theorem basic_preserve_nuw_proof : basic_preserve_nuw_before ⊑ basic_preserve_nuw_after := by
  sorry



def basic_preserve_nuw_nsw_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = llvm.xor %arg0, %0 : i8
  %2 = llvm.add %1, %arg1 : i8
  %3 = llvm.xor %2, %0 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def basic_preserve_nuw_nsw_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.sub %arg0, %arg1 : i8
  "llvm.return"(%0) : (i8) -> ()
}
]
theorem basic_preserve_nuw_nsw_proof : basic_preserve_nuw_nsw_before ⊑ basic_preserve_nuw_nsw_after := by
  sorry



def vector_test_before := [llvm|
{
^0(%arg0 : vector<4xi32>, %arg1 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = llvm.xor %arg0, %0 : vector<4xi32>
  %2 = llvm.add %1, %arg1 : vector<4xi32>
  %3 = llvm.xor %2, %0 : vector<4xi32>
  "llvm.return"(%3) : (vector<4xi32>) -> ()
}
]
def vector_test_after := [llvm|
{
^0(%arg0 : vector<4xi32>, %arg1 : vector<4xi32>):
  %0 = llvm.sub %arg0, %arg1 : vector<4xi32>
  "llvm.return"(%0) : (vector<4xi32>) -> ()
}
]
theorem vector_test_proof : vector_test_before ⊑ vector_test_after := by
  sorry


