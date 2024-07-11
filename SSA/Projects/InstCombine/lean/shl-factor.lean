
def add_shl_same_amount_before := [llvm|
{
^0(%arg0 : i6, %arg1 : i6, %arg2 : i6):
  %0 = llvm.shl %arg0, %arg2 : i6
  %1 = llvm.shl %arg1, %arg2 : i6
  %2 = llvm.add %0, %1 : i6
  "llvm.return"(%2) : (i6) -> ()
}
]
def add_shl_same_amount_after := [llvm|
{
^0(%arg0 : i6, %arg1 : i6, %arg2 : i6):
  %0 = llvm.add %arg0, %arg1 : i6
  %1 = llvm.shl %0, %arg2 : i6
  "llvm.return"(%1) : (i6) -> ()
}
]
theorem add_shl_same_amount_proof : add_shl_same_amount_before ⊑ add_shl_same_amount_after := by
  sorry



def add_shl_same_amount_nsw_before := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>, %arg2 : vector<2xi4>):
  %0 = llvm.shl %arg0, %arg2 : vector<2xi4>
  %1 = llvm.shl %arg1, %arg2 : vector<2xi4>
  %2 = llvm.add %0, %1 : vector<2xi4>
  "llvm.return"(%2) : (vector<2xi4>) -> ()
}
]
def add_shl_same_amount_nsw_after := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>, %arg2 : vector<2xi4>):
  %0 = llvm.add %arg0, %arg1 : vector<2xi4>
  %1 = llvm.shl %0, %arg2 : vector<2xi4>
  "llvm.return"(%1) : (vector<2xi4>) -> ()
}
]
theorem add_shl_same_amount_nsw_proof : add_shl_same_amount_nsw_before ⊑ add_shl_same_amount_nsw_after := by
  sorry



def add_shl_same_amount_nuw_before := [llvm|
{
^0(%arg0 : i64, %arg1 : i64, %arg2 : i64):
  %0 = llvm.shl %arg0, %arg2 : i64
  %1 = llvm.shl %arg1, %arg2 : i64
  %2 = llvm.add %0, %1 : i64
  "llvm.return"(%2) : (i64) -> ()
}
]
def add_shl_same_amount_nuw_after := [llvm|
{
^0(%arg0 : i64, %arg1 : i64, %arg2 : i64):
  %0 = llvm.add %arg0, %arg1 : i64
  %1 = llvm.shl %0, %arg2 : i64
  "llvm.return"(%1) : (i64) -> ()
}
]
theorem add_shl_same_amount_nuw_proof : add_shl_same_amount_nuw_before ⊑ add_shl_same_amount_nuw_after := by
  sorry



def add_shl_same_amount_partial_nsw1_before := [llvm|
{
^0(%arg0 : i6, %arg1 : i6, %arg2 : i6):
  %0 = llvm.shl %arg0, %arg2 : i6
  %1 = llvm.shl %arg1, %arg2 : i6
  %2 = llvm.add %0, %1 : i6
  "llvm.return"(%2) : (i6) -> ()
}
]
def add_shl_same_amount_partial_nsw1_after := [llvm|
{
^0(%arg0 : i6, %arg1 : i6, %arg2 : i6):
  %0 = llvm.add %arg0, %arg1 : i6
  %1 = llvm.shl %0, %arg2 : i6
  "llvm.return"(%1) : (i6) -> ()
}
]
theorem add_shl_same_amount_partial_nsw1_proof : add_shl_same_amount_partial_nsw1_before ⊑ add_shl_same_amount_partial_nsw1_after := by
  sorry



def add_shl_same_amount_partial_nsw2_before := [llvm|
{
^0(%arg0 : i6, %arg1 : i6, %arg2 : i6):
  %0 = llvm.shl %arg0, %arg2 : i6
  %1 = llvm.shl %arg1, %arg2 : i6
  %2 = llvm.add %0, %1 : i6
  "llvm.return"(%2) : (i6) -> ()
}
]
def add_shl_same_amount_partial_nsw2_after := [llvm|
{
^0(%arg0 : i6, %arg1 : i6, %arg2 : i6):
  %0 = llvm.add %arg0, %arg1 : i6
  %1 = llvm.shl %0, %arg2 : i6
  "llvm.return"(%1) : (i6) -> ()
}
]
theorem add_shl_same_amount_partial_nsw2_proof : add_shl_same_amount_partial_nsw2_before ⊑ add_shl_same_amount_partial_nsw2_after := by
  sorry



def add_shl_same_amount_partial_nuw1_before := [llvm|
{
^0(%arg0 : i6, %arg1 : i6, %arg2 : i6):
  %0 = llvm.shl %arg0, %arg2 : i6
  %1 = llvm.shl %arg1, %arg2 : i6
  %2 = llvm.add %0, %1 : i6
  "llvm.return"(%2) : (i6) -> ()
}
]
def add_shl_same_amount_partial_nuw1_after := [llvm|
{
^0(%arg0 : i6, %arg1 : i6, %arg2 : i6):
  %0 = llvm.add %arg0, %arg1 : i6
  %1 = llvm.shl %0, %arg2 : i6
  "llvm.return"(%1) : (i6) -> ()
}
]
theorem add_shl_same_amount_partial_nuw1_proof : add_shl_same_amount_partial_nuw1_before ⊑ add_shl_same_amount_partial_nuw1_after := by
  sorry



def add_shl_same_amount_partial_nuw2_before := [llvm|
{
^0(%arg0 : i6, %arg1 : i6, %arg2 : i6):
  %0 = llvm.shl %arg0, %arg2 : i6
  %1 = llvm.shl %arg1, %arg2 : i6
  %2 = llvm.add %0, %1 : i6
  "llvm.return"(%2) : (i6) -> ()
}
]
def add_shl_same_amount_partial_nuw2_after := [llvm|
{
^0(%arg0 : i6, %arg1 : i6, %arg2 : i6):
  %0 = llvm.add %arg0, %arg1 : i6
  %1 = llvm.shl %0, %arg2 : i6
  "llvm.return"(%1) : (i6) -> ()
}
]
theorem add_shl_same_amount_partial_nuw2_proof : add_shl_same_amount_partial_nuw2_before ⊑ add_shl_same_amount_partial_nuw2_after := by
  sorry



def sub_shl_same_amount_before := [llvm|
{
^0(%arg0 : i6, %arg1 : i6, %arg2 : i6):
  %0 = llvm.shl %arg0, %arg2 : i6
  %1 = llvm.shl %arg1, %arg2 : i6
  %2 = llvm.sub %0, %1 : i6
  "llvm.return"(%2) : (i6) -> ()
}
]
def sub_shl_same_amount_after := [llvm|
{
^0(%arg0 : i6, %arg1 : i6, %arg2 : i6):
  %0 = llvm.sub %arg0, %arg1 : i6
  %1 = llvm.shl %0, %arg2 : i6
  "llvm.return"(%1) : (i6) -> ()
}
]
theorem sub_shl_same_amount_proof : sub_shl_same_amount_before ⊑ sub_shl_same_amount_after := by
  sorry



def sub_shl_same_amount_nsw_before := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>, %arg2 : vector<2xi4>):
  %0 = llvm.shl %arg0, %arg2 : vector<2xi4>
  %1 = llvm.shl %arg1, %arg2 : vector<2xi4>
  %2 = llvm.sub %0, %1 : vector<2xi4>
  "llvm.return"(%2) : (vector<2xi4>) -> ()
}
]
def sub_shl_same_amount_nsw_after := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>, %arg2 : vector<2xi4>):
  %0 = llvm.sub %arg0, %arg1 : vector<2xi4>
  %1 = llvm.shl %0, %arg2 : vector<2xi4>
  "llvm.return"(%1) : (vector<2xi4>) -> ()
}
]
theorem sub_shl_same_amount_nsw_proof : sub_shl_same_amount_nsw_before ⊑ sub_shl_same_amount_nsw_after := by
  sorry



def sub_shl_same_amount_nuw_before := [llvm|
{
^0(%arg0 : i64, %arg1 : i64, %arg2 : i64):
  %0 = llvm.shl %arg0, %arg2 : i64
  %1 = llvm.shl %arg1, %arg2 : i64
  %2 = llvm.sub %0, %1 : i64
  "llvm.return"(%2) : (i64) -> ()
}
]
def sub_shl_same_amount_nuw_after := [llvm|
{
^0(%arg0 : i64, %arg1 : i64, %arg2 : i64):
  %0 = llvm.sub %arg0, %arg1 : i64
  %1 = llvm.shl %0, %arg2 : i64
  "llvm.return"(%1) : (i64) -> ()
}
]
theorem sub_shl_same_amount_nuw_proof : sub_shl_same_amount_nuw_before ⊑ sub_shl_same_amount_nuw_after := by
  sorry



def sub_shl_same_amount_partial_nsw1_before := [llvm|
{
^0(%arg0 : i6, %arg1 : i6, %arg2 : i6):
  %0 = llvm.shl %arg0, %arg2 : i6
  %1 = llvm.shl %arg1, %arg2 : i6
  %2 = llvm.sub %0, %1 : i6
  "llvm.return"(%2) : (i6) -> ()
}
]
def sub_shl_same_amount_partial_nsw1_after := [llvm|
{
^0(%arg0 : i6, %arg1 : i6, %arg2 : i6):
  %0 = llvm.sub %arg0, %arg1 : i6
  %1 = llvm.shl %0, %arg2 : i6
  "llvm.return"(%1) : (i6) -> ()
}
]
theorem sub_shl_same_amount_partial_nsw1_proof : sub_shl_same_amount_partial_nsw1_before ⊑ sub_shl_same_amount_partial_nsw1_after := by
  sorry



def sub_shl_same_amount_partial_nsw2_before := [llvm|
{
^0(%arg0 : i6, %arg1 : i6, %arg2 : i6):
  %0 = llvm.shl %arg0, %arg2 : i6
  %1 = llvm.shl %arg1, %arg2 : i6
  %2 = llvm.sub %0, %1 : i6
  "llvm.return"(%2) : (i6) -> ()
}
]
def sub_shl_same_amount_partial_nsw2_after := [llvm|
{
^0(%arg0 : i6, %arg1 : i6, %arg2 : i6):
  %0 = llvm.sub %arg0, %arg1 : i6
  %1 = llvm.shl %0, %arg2 : i6
  "llvm.return"(%1) : (i6) -> ()
}
]
theorem sub_shl_same_amount_partial_nsw2_proof : sub_shl_same_amount_partial_nsw2_before ⊑ sub_shl_same_amount_partial_nsw2_after := by
  sorry



def sub_shl_same_amount_partial_nuw1_before := [llvm|
{
^0(%arg0 : i6, %arg1 : i6, %arg2 : i6):
  %0 = llvm.shl %arg0, %arg2 : i6
  %1 = llvm.shl %arg1, %arg2 : i6
  %2 = llvm.sub %0, %1 : i6
  "llvm.return"(%2) : (i6) -> ()
}
]
def sub_shl_same_amount_partial_nuw1_after := [llvm|
{
^0(%arg0 : i6, %arg1 : i6, %arg2 : i6):
  %0 = llvm.sub %arg0, %arg1 : i6
  %1 = llvm.shl %0, %arg2 : i6
  "llvm.return"(%1) : (i6) -> ()
}
]
theorem sub_shl_same_amount_partial_nuw1_proof : sub_shl_same_amount_partial_nuw1_before ⊑ sub_shl_same_amount_partial_nuw1_after := by
  sorry



def sub_shl_same_amount_partial_nuw2_before := [llvm|
{
^0(%arg0 : i6, %arg1 : i6, %arg2 : i6):
  %0 = llvm.shl %arg0, %arg2 : i6
  %1 = llvm.shl %arg1, %arg2 : i6
  %2 = llvm.sub %0, %1 : i6
  "llvm.return"(%2) : (i6) -> ()
}
]
def sub_shl_same_amount_partial_nuw2_after := [llvm|
{
^0(%arg0 : i6, %arg1 : i6, %arg2 : i6):
  %0 = llvm.sub %arg0, %arg1 : i6
  %1 = llvm.shl %0, %arg2 : i6
  "llvm.return"(%1) : (i6) -> ()
}
]
theorem sub_shl_same_amount_partial_nuw2_proof : sub_shl_same_amount_partial_nuw2_before ⊑ sub_shl_same_amount_partial_nuw2_after := by
  sorry


