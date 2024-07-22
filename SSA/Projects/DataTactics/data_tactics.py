#!/usr/bin/env python3

theorems = [
    "bitvec_AddSub_1043",
    "bitvec_AddSub_1152",
    "bitvec_AddSub_1156",
    "bitvec_AddSub_1164",
    "bitvec_AddSub_1165",
    "bitvec_AddSub_1176",
    "bitvec_AddSub_1202",
    "bitvec_AddSub_1295",
    "bitvec_AddSub_1309",
    "bitvec_AddSub_1539",
    "bitvec_AddSub_1539_2",
    "bitvec_AddSub_1556",
    "bitvec_AddSub_1560",
    "bitvec_AddSub_1564",
    "bitvec_AddSub_1574",
    "bitvec_AddSub_1614",
    "bitvec_AddSub_1619",
    "bitvec_AddSub_1624",
    "bitvec_AndOrXor_135",
    "bitvec_AndOrXor_144",
    "bitvec_AndOrXor_698",
    "bitvec_AndOrXor_709",
    "bitvec_AndOrXor_716",
    "bitvec_AndOrXor_794",
    "bitvec_AndOrXor_827",
    "bitvec_AndOrXor_887_2",
    "bitvec_AndOrXor_1230__A__B___A__B",
    "bitvec_AndOrXor_1241_AB__AB__AB",
    "bitvec_AndOrXor_1247_AB__AB__AB",
    "bitvec_AndOrXor_1253_A__AB___A__B",
    "bitvec_AndOrXor_1280_ABA___AB",
    "bitvec_AndOrXor_1288_A__B__B__C__A___A__B__C",
    "bitvec_AndOrXor_1294_A__B__A__B___A__B",
    "bitvec_AndOrXor_1683_1",
    "bitvec_AndOrXor_1683_2",
    "bitvec_AndOrXor_1704",
    "bitvec_AndOrXor_1705",
    "bitvec_AndOrXor_1733",
    "bitvec_AndOrXor_2063__X__C1__C2____X__C2__C1__C2",
    "bitvec_AndOrXor_2113___A__B__A___A__B",
    "bitvec_AndOrXor_2118___A__B__A___A__B",
    "bitvec_AndOrXor_2123___A__B__A__B___A__B",
    "bitvec_AndOrXor_2188",
    "bitvec_AndOrXor_2231__A__B__B__C__A___A__B__C",
    "bitvec_AndOrXor_2243__B__C__A__B___B__A__C",
    "bitvec_AndOrXor_2247__A__B__A__B",
    "bitvec_AndOrXor_2263",
    "bitvec_AndOrXor_2264",
    "bitvec_AndOrXor_2265",
    "bitvec_AndOrXor_2284",
    "bitvec_AndOrXor_2285",
    "bitvec_AndOrXor_2297",
    "bitvec_AndOrXor_2367",
    "bitvec_AndOrXor_2416",
    "bitvec_AndOrXor_2417",
    "bitvec_AndOrXor_2429",
    "bitvec_AndOrXor_2430",
    "bitvec_AndOrXor_2443",
    "bitvec_AndOrXor_2453",
    "bitvec_AndOrXor_2475",
    "bitvec_AndOrXor_2486",
    "bitvec_AndOrXor_2581__BAB___A__B",
    "bitvec_AndOrXor_2587__BAA___B__A",
    "bitvec_AndOrXor_2595",
    "bitvec_AndOrXor_2607",
    "bitvec_AndOrXor_2617",
    "bitvec_AndOrXor_2627",
    "bitvec_AndOrXor_2647",
    "bitvec_AndOrXor_2658",
    "bitvec_AndOrXor_2663",
    "bitvec_152",
    "bitvec_229",
    "bitvec_239",
    "bitvec_275",
    "bitvec_275_2",
    "bitvec_276",
    "bitvec_276_2",
    "bitvec_283",
    "bitvec_290__292",
    "bitvec_820",
    "bitvec_820'",
    "bitvec_1030",
"bitvec_Select_858",
"bitvec_Select_859'"
"bitvec_select_1100",
"bitvec_Select_1105",
"bitvec_InstCombineShift__239",
"bitvec_InstCombineShift__279",
"bitvec_InstCombineShift__440",
"bitvec_InstCombineShift__476",
"bitvec_InstCombineShift__497",
    "bitvec_InstCombineShift__497'''",
"bitvec_InstCombineShift__582"
]





result = subprocess.run(
     ["lake", "build", "SSA.Projects.DataTactic.AliveStatements"], capture_output=True, text=True
)
# Split the lines string into individual lines
lines_list = result.split('\n')

# Iterate through each theorem
for theorem in theorems:
    found = False
    # Check each line to see if the theorem appears in it
    for line in lines_list:
        if theorem in line:
            print(line)
            found = True
            break
    # If the theorem was not found in any line, print "no output"
    if not found:
        print("no output")
