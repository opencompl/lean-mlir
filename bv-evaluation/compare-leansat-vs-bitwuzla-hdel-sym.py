import subprocess
import os 
import shutil 

results_dir = "bv-evaluation/results/HackersDelightSymbolic/"

benchmark_dir_list = "../SSA/Projects/InstCombine/HackersDelight/"
benchmark_dir = "SSA/Projects/InstCombine/HackersDelight/"


reps = 1

# for file in os.listdir(results_dir):
#     file_path = os.path.join(results_dir, file)
#     try:
#         if os.path.isfile(file_path) or os.path.islink(file_path):
#             os.unlink(file_path)
#         elif os.path.isdir(file_path):
#             shutil.rmtree(file_path)
#     except Exception as e:
#         print('Failed to delete %s. Reason: %s' % (file_path, e))

bvw = "w"
for file in os.listdir(benchmark_dir_list):
    print(file)
    subprocess.Popen(f'git checkout -- '+benchmark_dir_list+file, shell=True).wait()
    subprocess.Popen('gsed -i -E \'s/variable \\{x y z : BitVec .+\\}/variable \\{x y z : BitVec '+str(bvw)+'\\}/g\' '+benchmark_dir_list+file, shell=True).wait()
    # replace any sorrys with bv_compare'
    TACTIC = 'bv_bench'
    subprocess.Popen(f'gsed -i -E \'s@all_goals sorry@{TACTIC}@g\' '+benchmark_dir_list+file, shell=True).wait()
    for r in range(reps):
        print(f'cd .. && lake lean '+benchmark_dir+file+' 2>&1 |" tee '+results_dir+file.split(".")[0]+'_'+str(bvw)+'_'+'r'+str(r)+'.txt')
        subprocess.Popen(f'cd .. && lake lean '+benchmark_dir+file+' 2>&1 | tee '+results_dir+file.split(".")[0]+'_'+str(bvw)+'_'+'r'+str(r)+'.txt', shell=True).wait()
    subprocess.Popen(f'gsed -i -E \'s@{TACTIC}@all_goals sorry@g\' '+benchmark_dir_list+file, shell=True).wait()
    subprocess.Popen(f'git checkout -- '+benchmark_dir_list+file, shell=True).wait()
