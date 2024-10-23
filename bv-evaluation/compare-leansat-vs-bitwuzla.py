import os 
import fileinput
import sys
import shutil 

results_dir = "bv_eval/results/"

benchmark_dir = "../SSA/Projects/InstCombine/HackersDelight/"
benchmark_dir_lake = "SSA.Projects.InstCombine.HackersDelight"

reps = 2

bv_width = [4, 8, 16, 32, 64]

for file in os.listdir(benchmark_dir):
    if "ch2_3" not in file: # currently discard broken chapter
        for bvw in bv_width:
            os.system('sed -i \'\' -E \"s/variable {x y z : BitVec .+}/variable {x y z : BitVec '+str(bvw)+'}/\" '+benchmark_dir+file)
            for r in range(reps):
                os.system(f'cd ../ && lake build '+benchmark_dir_lake+'.'+file.split(".")[0]+' 2>&1 > '+results_dir+file.split(".")[0]+'_'+str(bvw)+'_'+'r'+str(r)+'.txt')