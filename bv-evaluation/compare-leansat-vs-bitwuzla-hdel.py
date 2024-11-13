#!/usr/bin/env python3
import subprocess
import os 
import shutil 

results_dir = os.path.abspath("results/HackersDelight/") + "/"
print(f"Writing results to: {results_dir}")

benchmark_dir_list = "../SSA/Projects/InstCombine/HackersDelight/"
benchmark_dir = "SSA/Projects/InstCombine/HackersDelight/"


reps = 1

bv_width = [4, 8, 16, 32, 64]

for file in os.listdir(results_dir):
    file_path = os.path.join(results_dir, file)
    try:
        if os.path.isfile(file_path) or os.path.islink(file_path):
            os.unlink(file_path)
        elif os.path.isdir(file_path):
            shutil.rmtree(file_path)
    except Exception as e:
        print('Failed to delete %s. Reason: %s' % (file_path, e))

for file in os.listdir(benchmark_dir_list):
    print(file)
    for bvw in bv_width:
        subprocess.Popen('sed -i -E \'s/variable \\{x y z : BitVec .+\\}/variable \\{x y z : BitVec '+str(bvw)+'\\}/g\' '+benchmark_dir_list+file, shell=True).wait()
        # replace any sorrys with bv_compare'
        subprocess.Popen('sed -i -E \'s,all_goals sorry,bv_compare\'\\\'\',g\' '+benchmark_dir_list+file, shell=True).wait()
        for r in range(reps):
            print(f'cd .. && lake lean '+benchmark_dir+file+' 2>&1 > '+results_dir+file.split(".")[0]+'_'+str(bvw)+'_'+'r'+str(r)+'.txt')
            subprocess.Popen(f'cd .. && lake lean '+benchmark_dir+file+' 2>&1 > '+results_dir+file.split(".")[0]+'_'+str(bvw)+'_'+'r'+str(r)+'.txt', shell=True).wait()
        subprocess.Popen('sed -i -E \'s,bv_compare\'\\\'\',all_goals sorry,g\' '+benchmark_dir_list+file, shell=True).wait()
