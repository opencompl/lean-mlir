#!/usr/bin/env python3
import os
import pandas as pd
import numpy as np
import num2words

bv_widths = [4, 8, 16, 32, 64]


def geomean(xs):
    xs = [x for x in xs if x > 0]
    if len(xs) > 0:
        return np.exp(np.mean(np.log(np.array(xs))))
    else:
        return 0.0  # e^(-infty) = 0
        # raise RuntimeError("Trying to compute the geomean of an empty list. ")


def get_avg_bb_sat(df_tot, benchmark, phase, statsfile): 
    df_tot_ordered = df_tot.sort_values(by='solved_bv_decide_times_average')
    df_tot_ordered.to_csv('sorted_'+benchmark+'.csv')
    df = df_tot[df_tot["solved_bv_decide_sat_times_average"] > 0]
    if(len(df["solved_bv_decide_times_average"])>0):
        if phase == 'sat': 
            sat_bb =  np.sum(np.array(df['solved_bv_decide_bb_times_average'])+np.array(df['solved_bv_decide_sat_times_average']))
            perc_sat_bb = (sat_bb/np.sum(df['solved_bv_decide_times_average']))*100
            geomean_sat_bb = geomean((df['solved_bv_decide_bb_times_average']+df['solved_bv_decide_sat_times_average'])/df['solved_bv_decide_times_average'])*100
            f = open(statsfile, "a+")
            f.write("\\newcommand{\\"+benchmark.replace('_', '')+r"SatBitBlastingPerc}{"+("%.1f" % perc_sat_bb)+"\\%}\n")
            f.write("\\newcommand{\\"+benchmark.replace('_', '')+r"SatBitBlastingGeoMean}{"+("%.1f" % geomean_sat_bb)+"\\%}\n")
            if benchmark == 'InstCombine':
                filtered_df = df_tot[(df_tot['solved_bv_decide_bb_times_average'] == 0) & (df_tot['solved_bv_decide_sat_times_average'] == 0) & (df_tot['solved_bv_decide_lratt_times_average'] == 0) & (df_tot['solved_bv_decide_lratc_times_average'] == 0)]
                rewriteOnlyMean = geomean(filtered_df['solved_bv_decide_times_average'])
                f.write("\\newcommand{\\"+benchmark.replace('_', '')+r"RewriteOnlyGeoMean}{"+("%.1f" % rewriteOnlyMean)+"}\n")
            f.close()
        elif phase == 'lrat':
            lrat_tot = np.sum(np.array(df['solved_bv_decide_lratt_times_average'])+np.array(df['solved_bv_decide_lratc_times_average']))
            perc_sat_bb = (lrat_tot/np.sum(df['solved_bv_decide_times_average']))*100
            # geomean (r1 / r2) = geomean(r1) / geomean(r2)
            geomean_lrat = geomean((df['solved_bv_decide_lratt_times_average']+df['solved_bv_decide_lratc_times_average'])/df['solved_bv_decide_times_average'])*100
            f = open(statsfile, "a+")
            f.write("\\newcommand{\\"+benchmark.replace('_', '')+r"LRATPerc}{"+("%.1f" % perc_sat_bb)+"\\%}\n")
            f.write("\\newcommand{\\"+benchmark.replace('_', '')+r"LRATGeoMean}{"+("%.1f" % geomean_lrat)+"\\%}\n")
            f.close()
        else:
            raise RuntimeError("Unexpected phase selected. ")
# def smtlib_slowdown_by_fam(df, type):
#     print(df)
#     fig, ax = plt.subplots(figsize=(14, 5))
#     h = 0.5
#     ax.scatter(np.arange(0, len(df['family'])), df['slowdown'], color=light_red, marker='x')
#     ax.set_yscale('log')
#     ax.set_ylabel("Slowdown [x]", rotation="horizontal", ha="left", y=1.05)
#     ax.set_xlabel("Families")
#     xLabels = ['']*len(df['family'])
#     ax.set_xticklabels(xLabels)
#     for i in [0, 1, len(df)-1, len(df)-2]: # keep fastest and slowest.
#         if(i == len(df)-2):
#             plt.annotate(np.array(df['family'])[i],
#                     xy=(i, np.array(df['slowdown'])[i]),  # Po0int to annotate (x, y)
#                     xytext=(i+2, np.array(df['slowdown'])[i]-0.5),  # Position of the text label
#                     ha='left',  # Horizontal alignment of the text
#                     va='bottom')
#         elif(i == len(df)-1):
#             plt.annotate(np.array(df['family'])[i],
#                     xy=(i, np.array(df['slowdown'])[i]),  # Po0int to annotate (x, y)
#                     xytext=(i, np.array(df['slowdown'])[i]+1),  # Position of the text label
#                     ha='left',  # Horizontal alignment of the text
#                     va='bottom')
#         else:
#             plt.annotate(np.array(df['family'])[i],
#                     xy=(i, np.array( df['slowdown'])[i]),  # Point to annotate (x, y)
#                     xytext=(i+1, np.array( df['slowdown'])[i]),  # Position of the text label
#                     ha='left',  # Horizontal alignment of the text
#                     va='bottom')
#     save(fig, type+"slowdown_by_fam_smtlib.pdf")


# def generate_stats_hackersdelight():
#     files = ['ch2_1DeMorgan', 'ch2_2AdditionAndLogicalOps', 'ch2_3LogicalArithmeticIneq']
#     rows = []
#     for file in files:
#         for bvw in bv_widths:
#             df_ceg=pd.read_csv('../raw-data/HackersDelight/bvw'+str(bvw)+'_'+file+'_ceg_data.csv')
#             df=pd.read_csv('../raw-data/HackersDelight/bvw'+str(bvw)+'_'+file+'_proved_data.csv')
#             # the number of solved
#             solved = len(df)
#             cegs = len(df_ceg)

#             if (solved > 0):
#                 rw = np.sum(df['leanSAT-rw'])/np.sum(df['leanSAT'])*100
#                 bb=np.sum(df['leanSAT-bb'])/np.sum(df['leanSAT'])*100
#                 sat=np.sum(df['leanSAT-sat'])/np.sum(df['leanSAT'])*100
#                 lrat_c=np.sum(df['leanSAT-lrat-c'])/np.sum(df['leanSAT'])*100
#                 lrat_t=np.sum(df['leanSAT-lrat-t'])/np.sum(df['leanSAT'])*100

#                 time_proof = [str(round(np.mean(rw), 3)), str(round(np.mean(bb), 3)), str(round(np.mean(sat), 3)), str(round(np.mean(lrat_c), 3)), str(round(np.mean(lrat_t), 3))]
#             else :
#                 time_proof = ['-'] * 5

#             if (cegs>0):
#                 ceg_rw = np.sum(df_ceg['leanSAT-rw'])/np.sum(df['leanSAT'])*100
#                 ceg_sat=np.sum(df_ceg['leanSAT-sat'])/np.sum(df['leanSAT'])*100
#                 time_ceg = [str(round(np.mean(ceg_rw), 3)), str(round(np.mean(ceg_sat), 3))]
#             else :
#                 time_ceg = ['-'] * 2

#             rows.append([file, str(bvw), str(solved), str(cegs), time_proof, time_ceg])
#     return rows

# def generate_stats_instcombine():

#     df_ceg=pd.read_csv('../raw-data/InstCombine/instcombine_ceg.csv')
#     df=pd.read_csv('../raw-data/InstCombine/instcombine_proved.csv')

#     solved = len(df)
#     cegs = len(df_ceg)

#     if (solved > 0):

#         rw = np.sum(df['leanSAT-rw'])/np.sum(df['leanSAT'])*100
#         bb=np.sum(df['leanSAT-bb'])/np.sum(df['leanSAT'])*100
#         sat=np.sum(df['leanSAT-sat'])/np.sum(df['leanSAT'])*100
#         lrat_c=np.sum(df['leanSAT-lrat-c'])/np.sum(df['leanSAT'])*100
#         lrat_t=np.sum(df['leanSAT-lrat-t'])/np.sum(df['leanSAT'])*100

#         time_proof = [str(round(np.mean(rw), 3)), str(round(np.mean(bb), 3)), str(round(np.mean(sat), 3)), str(round(np.mean(lrat_c), 3)), str(round(np.mean(lrat_t), 3))]
#     else :
#         time_proof = ['-'] * 5

#     if (cegs>0):
#         ceg_rw = np.sum(df_ceg['leanSAT-rw'])/np.sum(df['leanSAT'])*100
#         ceg_sat=np.sum(df_ceg['leanSAT-sat'])/np.sum(df['leanSAT'])*100
#         time_ceg = [str(round(np.mean(ceg_rw), 3)), str(round(np.mean(ceg_sat), 3))]
#     else :
#         time_ceg = ['-'] * 2

#     return ['InstCombine', '-', str(solved), str(cegs), time_proof, time_ceg]

# def generate_latex_table_tot_solved():
#     instc = generate_stats_instcombine()
#     hdel = generate_stats_hackersdelight()
#     # Create the header row
#     latex_table = "\\begin{tabular}{" + "l|" * 3 + "}\n"
#     latex_table += "\\hline\n"
#     latex_table += " Benchmark & Solved & Counterexample Found\\\\\n"
#     latex_table += "\\hline\n"
#     latex_table += instc[0]+" & "+instc[2]+" & "+instc[3]+"\\\\\n"
#     latex_table += "\\hline\n"
#     # no need to add a line for every bitwidth
#     latex_table += hdel[0][0].replace("_","-")+" & "+hdel[0][2]+" & "+hdel[0][3]+"\\\\\n"
#     latex_table += "\\hline\n"
#     latex_table += hdel[len(bv_widths)][0].replace("_","-")+" & "+hdel[len(bv_widths)][2]+" & "+hdel[len(bv_widths)][3]+"\\\\\n"
#     latex_table += "\\hline\n"
#     latex_table += hdel[2 * len(bv_widths)][0].replace("_","-")+" & "+hdel[2 * len(bv_widths)][2]+" & "+hdel[2 * len(bv_widths)][3]+"\\\\\n"
#     latex_table += "\\hline\n"
#     latex_table += "\\end{tabular}"
#     return latex_table

# def generate_latex_table_hackerdelight_solved_times():
#     hdel = generate_stats_hackersdelight()
#     # Create the header row
#     latex_table = "\\begin{tabular}{" + "l|" * 7 + "}\n"
#     latex_table += "\\hline\n"
#     latex_table += " Benchmark & Bitwidth & Rewriting & Bit-Blasting & SAT Solving & LRAT Trimming & LRAT Checking\\\\\n"
#     latex_table += "\\hline\n"
#     # no need to add a line for every bitwidth
#     for r in hdel :
#         if r[4][0] != "-":
#             latex_table += r[0].replace("_","-") +" & "+r[1]+" & "+r[4][0]+"\\% & "+r[4][1]+"\\% & "+r[4][2]+"\\% & "+r[4][3]+"\\% & "+r[4][4]+"\\%\\\\\n"
#     latex_table += "\\end{tabular}"
#     return latex_table

# def generate_latex_table_hackerdelight_ceg_times():
#     hdel = generate_stats_hackersdelight()
#     # Create the header row
#     latex_table = "\\begin{tabular}{" + "l|" * 4 + "}\n"
#     latex_table += "\\hline\n"
#     latex_table += " Benchmark & Bitwidth & Rewriting & SAT Solving\\\\\n"
#     latex_table += "\\hline\n"
#     # no need to add a line for every bitwidth
#     for r in hdel :
#         if r[5][0] != "-":
#             latex_table += r[0].replace("_","-") +" & "+r[1]+" & "+r[5][0]+"\\% & "+r[5][1]+"\\%\\\\\n"
#     latex_table += "\\end{tabular}"
#     return latex_table

# def generate_latex_table_instcombine_solved_times():
#     r = generate_stats_instcombine()
#     # Create the header row
#     latex_table = "\\begin{tabular}{" + "l|" * 7 + "}\n"
#     latex_table += "\\hline\n"
#     latex_table += " Benchmark & Rewriting & Bit-Blasting & SAT Solving & LRAT Trimming & LRAT Checking\\\\\n"
#     latex_table += "\\hline\n"
#     # no need to add a line for every bitwidth
#     latex_table += r[0] +" & "+r[4][0]+" & "+r[4][1]+"\\% & "+r[4][2]+"\\% & "+r[4][3]+"\\% & "+r[4][4]+"\\%\\\\\n"
#     latex_table += "\\end{tabular}"
#     return latex_table

# def generate_latex_table_instcombine_ceg_times():
#     r = generate_stats_instcombine()
#     # Create the header row
#     latex_table = "\\begin{tabular}{" + "l|" * 3 + "}\n"
#     latex_table += "\\hline\n"
#     latex_table += " Benchmark & Rewriting & SAT Solving\\\\\n"
#     latex_table += "\\hline\n"
#     # no need to add a line for every bitwidth
#     latex_table += r[0] +" & "+r[5][0]+"\\% & "+r[5][1]+"\\%\\\\\n"
#     latex_table += "\\end{tabular}"
#     return latex_table


def print_df(x):
    pd.set_option("display.max_rows", None)
    print(x)
    pd.reset_option("display.max_rows")


# def plot_smtlib_slowdown_families_raw(merged_df, type):
#     df_with_bm_names = merged_df.copy()
#     df_with_bm_names['family'] = merged_df['benchmark'].map(lambda s : s[:s.rfind("/")])

#     lw_unknowns = df_with_bm_names.groupby('family').agg(
#         total_entries=('result_lw', 'size'),
#         unknown=('result_lw', lambda x: (x == 'unknown').sum())
#     )

#     bw_unknowns = df_with_bm_names.groupby('family').agg(
#         total_entries=('result_bw', 'size'),
#         unknown=('result_bw', lambda x: (x == 'unknown').sum())
#     )

#     merged_fam_unknowns = pd.merge(lw_unknowns, bw_unknowns, how = 'inner', on = ['family', 'total_entries'], suffixes = ('_lw', '_bw') )
#     merged_fam_unknowns = merged_fam_unknowns.sort_values(by='total_entries', ascending=False)
#     #                                                     total_entries  unknown_lw  unknown_bw
#     # sage/app9                                                    3301           0           0
#     # sage/app8                                                    2756           0           0
#     # 20221012-MCMPC/millionaires                                  1682           0           0
#     # 20190311-bv-term-small-rw-Noetzli                            1575         159           7
#     # bv-term-small-rw-Noetzli.

#     print_df(merged_fam_unknowns)
#     print("total of "+str(len(merged_fam_unknowns)))
#     merged_fam_unknowns.to_csv('merged-df-entries-unknowns.csv')

#     # merged_fam_unknowns_lw_better_than_bw = merged_fam_unknowns[merged_fam_unknowns['unknown_lw']<= merged_fam_unknowns['unknown_bw']]
#     # print_df(merged_fam_unknowns_lw_better_than_bw)
#     # print("leanwuzla solves as many pb. as bw on "+str(len(merged_fam_unknowns_lw_better_than_bw)))

#     # lw_geomean_by_fam = df_with_bm_names.groupby(by='family')['time_cpu_lw'].agg(lambda x: np.exp(np.log(x).mean())).reset_index()
#     # bw_geomean_by_fam = df_with_bm_names.groupby(by='family')['time_cpu_bw'].agg(lambda x: np.exp(np.log(x).mean())).reset_index()
#     # merged_geomean = pd.merge(lw_geomean_by_fam, bw_geomean_by_fam, on='family', how='inner')
#     # merged_geomean["slowdown"] = merged_geomean['time_cpu_lw'] / merged_geomean['time_cpu_bw']
#     # merged_geomean = merged_geomean.sort_values(by='slowdown', ascending=False)
#     # smtlib_slowdown_by_fam(merged_geomean, type)
#     # fig, ax = plt.subplots(1, 4, figsize=(14, 5), sharey=True)
#     # dfs=[df_with_bm_names[df_with_bm_names['family']==merged_geomean.loc[0]['family']],
#     #      df_with_bm_names[df_with_bm_names['family']==merged_geomean.loc[1]['family']],
#     #      df_with_bm_names[df_with_bm_names['family']==merged_geomean.loc[len(merged_geomean)-1]['family']],
#     #      df_with_bm_names[df_with_bm_names['family']==merged_geomean.loc[len(merged_geomean)-2]['family']]]
#     # families = [merged_geomean.loc[0]['family'], merged_geomean.loc[1]['family'], merged_geomean.loc[len(merged_geomean)-1]['family'], merged_geomean.loc[len(merged_geomean)-1]['family']]
#     # print(families)
#     # time_min = np.inf
#     # time_max = 0
#     # for i in range(4):
#     #     df = dfs[i]
#     #     time_min = min(time_min, df["time_cpu_bw"].min(), df["time_cpu_lw"].min())
#     #     time_max = max(time_max, df["time_cpu_bw"].max(), df["time_cpu_lw"].max())

#     # for i in range(4):
#     #     df = dfs[i]
#     #     w = 1/(len(df["time_cpu_bw"]))
#     #     x = np.arange(0, len(df["time_cpu_bw"]))
#     #     ax[i].bar(x+w/2, df["time_cpu_bw"], width=w, color=dark_green)
#     #     ax[i].bar(x-w/2, df["time_cpu_lw"], width=w, color=light_blue)

#     #     ax[i].set_yscale('log')
#     #     ax[i].set_ylim(10**(np.floor(np.log10(time_min))), 10**(np.ceil(np.log10(time_max))))
#     #     ax[i].set_xlabel(families[i], fontsize = 14)
#     #     ax[i].set_xticklabels([""]*len(df["time_cpu_bw"]))
#     # ax[0].set_ylabel("Time [s] - bv_decide", rotation="horizontal", ha="left", y=1.05)
#     # fig.tight_layout()
#     # # Create additional space at the bottom of the figure for a common x-axis label
#     # fig.subplots_adjust(bottom=0.2)
#     # # ax.legend(loc="lower center", ncols=2, frameon=False)
#     # fig.text(0.5, 0.01, "Time [ms] - bitwuzla", ha="center", va="center")
#     # save(fig, "interesting_families_scatter_smtlib.pdf")

#     # print(f"average slowdown, across all gropus : {np.exp(np.log(merged_geomean['slowdown']).mean())}")


def plot_smtlib_slowdown_families_raw(merged_df):
    df_with_bm_names = merged_df.copy()
    df_with_bm_names["family"] = merged_df["benchmark"].map(lambda s: s[: s.rfind("/")])

    lw_unknowns = df_with_bm_names.groupby("family").agg(
        total_entries=("result_lw", "size"),
        unknown=("result_lw", lambda x: (x == "unknown").sum()),
    )

    bw_unknowns = df_with_bm_names.groupby("family").agg(
        total_entries=("result_bw", "size"),
        unknown=("result_bw", lambda x: (x == "unknown").sum()),
    )

    merged_fam_unknowns = pd.merge(
        lw_unknowns,
        bw_unknowns,
        how="inner",
        on=["family", "total_entries"],
        suffixes=("_lw", "_bw"),
    )
    merged_fam_unknowns = merged_fam_unknowns.sort_values(
        by="total_entries", ascending=False
    )
    print_df(merged_fam_unknowns)
    merged_fam_unknowns.to_csv("smtlib-group-by-family-sort-by-total-problems.csv")
    return merged_fam_unknowns

    # lw_geomean_by_fam = df_with_bm_names.groupby(by='family')['time_cpu_lw'].agg(lambda x: np.exp(np.log(x).mean())).reset_index()
    # bw_geomean_by_fam = df_with_bm_names.groupby(by='family')['time_cpu_bw'].agg(lambda x: np.exp(np.log(x).mean())).reset_index()
    # merged_geomean = pd.merge(lw_geomean_by_fam, bw_geomean_by_fam, on='family', how='inner')
    # merged_geomean["slowdown"] = merged_geomean['time_cpu_lw'] / merged_geomean['time_cpu_bw']
    # merged_geomean = merged_geomean.sort_values(by='slowdown', ascending=False)
    # smtlib_slowdown_by_fam(merged_geomean, type)
    # print(f"average slowdown, across all gropus : {np.exp(np.log(merged_geomean['slowdown']).mean())}")


# def plot_smtlib_slowdown_families(merged_df, type):
#     df_with_bm_names = merged_df.copy()
#     df_with_bm_names['family'] = merged_df['benchmark'].map(lambda s : s[:s.rfind("/")])
#     lw_geomean_by_fam = df_with_bm_names.groupby(by='family')['time_cpu_lw'].agg(lambda x: np.exp(np.log(x).mean())).reset_index()
#     bw_geomean_by_fam = df_with_bm_names.groupby(by='family')['time_cpu_bw'].agg(lambda x: np.exp(np.log(x).mean())).reset_index()
#     merged_geomean = pd.merge(lw_geomean_by_fam, bw_geomean_by_fam, on='family', how='inner')
#     merged_geomean["slowdown"] = merged_geomean['time_cpu_lw'] / merged_geomean['time_cpu_bw']
#     merged_geomean = merged_geomean.sort_values(by='slowdown', ascending=False)
#     smtlib_slowdown_by_fam(merged_geomean, type)
#     fig, ax = plt.subplots(1, 4, figsize=(14, 5), sharey=True)
#     dfs=[df_with_bm_names[df_with_bm_names['family']==merged_geomean.loc[0]['family']],
#          df_with_bm_names[df_with_bm_names['family']==merged_geomean.loc[1]['family']],
#          df_with_bm_names[df_with_bm_names['family']==merged_geomean.loc[len(merged_geomean)-1]['family']],
#          df_with_bm_names[df_with_bm_names['family']==merged_geomean.loc[len(merged_geomean)-2]['family']]]
#     families = [merged_geomean.loc[0]['family'], merged_geomean.loc[1]['family'], merged_geomean.loc[len(merged_geomean)-1]['family'], merged_geomean.loc[len(merged_geomean)-1]['family']]
#     print(families)
#     time_min = np.inf
#     time_max = 0
#     for i in range(4):
#         df = dfs[i]
#         time_min = min(time_min, df["time_cpu_bw"].min(), df["time_cpu_lw"].min())
#         time_max = max(time_max, df["time_cpu_bw"].max(), df["time_cpu_lw"].max())

#     for i in range(4):
#         df = dfs[i]
#         w = 1/(len(df["time_cpu_bw"]))
#         x = np.arange(0, len(df["time_cpu_bw"]))
#         ax[i].bar(x+w/2, df["time_cpu_bw"], width=w, color=dark_green)
#         ax[i].bar(x-w/2, df["time_cpu_lw"], width=w, color=light_blue)

#         ax[i].set_yscale('log')
#         ax[i].set_ylim(10**(np.floor(np.log10(time_min))), 10**(np.ceil(np.log10(time_max))))
#         ax[i].set_xlabel(families[i], fontsize = 14)
#         ax[i].set_xticklabels([""]*len(df["time_cpu_bw"]))
#     ax[0].set_ylabel("Time [s] - bv_decide", rotation="horizontal", ha="left", y=1.05)
#     fig.tight_layout()
#     # Create additional space at the bottom of the figure for a common x-axis label
#     fig.subplots_adjust(bottom=0.2)
#     # ax.legend(loc="lower center", ncols=2, frameon=False)
#     fig.text(0.5, 0.01, "Time [ms] - bitwuzla", ha="center", va="center")
#     save(fig, "interesting_families_scatter_smtlib.pdf")
#     print(f"average slowdown, across all groups : {np.exp(np.log(merged_geomean['slowdown']).mean())}")


def slowdown_smtlib_stats():
    df_bitwuzla_46k = pd.read_csv("../raw-data/SMTLIB/bitwuzla_46k.csv")
    df_leanwuzla_2k = pd.read_csv("../raw-data/SMTLIB/leanwuzla_46k.csv")
    merged_df = pd.merge(
        df_bitwuzla_46k, df_leanwuzla_2k, on="benchmark", suffixes=("_bw", "_lw")
    )
    df_clean_tmp = merged_df[merged_df["result_bw"] != "unknown"]
    df_clean = df_clean_tmp[df_clean_tmp["result_lw"] != "unknown"]
    # filter out results that are not consistent
    df_cons = df_clean[df_clean["result_bw"] == df_clean["result_lw"]]
    df_unsat = df_cons[df_cons["result_bw"] == "unsat"]
    df_unsat_slowdown = df_unsat.copy()
    df_unsat_slowdown["slowdown"] = np.divide(
        np.array(df_unsat["time_cpu_lw"]), np.array(df_unsat["time_cpu_bw"])
    )
    df_unsat_sorted = df_unsat_slowdown.sort_values(by="slowdown", ascending=False)
    df_unsat_sorted.to_csv("slowdown.csv")


def smtlib_stats(performance_smtlib_dir):
    df_bitwuzla = pd.read_csv("raw-data/SMT-LIB/bitwuzla_data.csv")
    df_bv_decide = pd.read_csv("raw-data/SMT-LIB/bv_decide_data.csv")
    df_bitwuzla["benchmark"] = df_bitwuzla["benchmark"].apply(os.path.dirname)
    df_bv_decide["benchmark"] = df_bv_decide["benchmark"].apply(os.path.dirname)
    assert len(df_bitwuzla) == len(df_bv_decide)
    merged_df = pd.merge(
        df_bitwuzla, df_bv_decide, on="benchmark", how="inner", suffixes=("_bw", "_lw")
    )
    df_clean_tmp = merged_df[merged_df["result_bw"] != "unknown"]
    df_clean = df_clean_tmp[df_clean_tmp["result_lw"] != "unknown"]
    # create new df for slowdown
    slowdown_df = df_clean.copy()
    slowdown_df["slowdown"] = df_clean["total_lw"] / df_clean["total_bw"]
    # geomean slowdown, leanwuzla vs. bitwuzla, SAT problems (removing all unknowns)
    slowdown_df_sat = slowdown_df[slowdown_df["result_bw"] == "sat"]
    geomean_slowdown_smtlib_sat = geomean(slowdown_df_sat["slowdown"])
    # geomean slowdown, leanwuzla vs. bitwuzla, UNSAT problems (removing all unknowns)
    slowdown_df_unsat = slowdown_df[slowdown_df["result_bw"] == "unsat"]
    geomean_slowdown_smtlib_unsat = geomean(slowdown_df_unsat["slowdown"])
    # geomean slowdown, leanwuzla vs. bitwuzla, UNSAT+SAT problems (removing all unknowns)
    geomean_slowdown_smtlib_tot = geomean(slowdown_df["slowdown"])
    # num. of problems where neither leanwuzla nor bitwuzla terminate
    merged_df_both_unknown = merged_df[
        (merged_df["result_bw"] == "unknown") & (merged_df["result_lw"] == "unknown")
    ]
    problems_both_unknown = len(merged_df_both_unknown)
    # num. of problems where bitwuzla terminates and leanwuzla does not terminate
    merged_df_lw_only_unknown = merged_df[
        (merged_df["result_bw"] != "unknown") & (merged_df["result_lw"] == "unknown")
    ]
    problems_lw_only_unknown = len(merged_df_lw_only_unknown)
    # perc. of SAT solved by leanwuzla
    tot_bitwuzla_sat = len(merged_df[merged_df["result_bw"] == "sat"])
    tot_leanwuzla_sat = len(merged_df[merged_df["result_lw"] == "sat"])
    perc_leanwuzla_sat = tot_leanwuzla_sat / tot_bitwuzla_sat * 100
    # perc. of UNSAT solved by leanwuzla
    tot_bitwuzla_unsat = len(merged_df[merged_df["result_bw"] == "unsat"])
    tot_leanwuzla_unsat = len(merged_df[merged_df["result_lw"] == "unsat"])
    perc_leanwuzla_unsat = tot_leanwuzla_unsat / tot_bitwuzla_unsat * 100
    # plot_smtlib_slowdown_families_raw(merged_df)
    # perc. of SAT + UNSAT solved by leanwuzla
    tot_bitwuzla = tot_bitwuzla_sat + tot_bitwuzla_unsat
    tot_leanwuzla = tot_leanwuzla_sat + tot_leanwuzla_unsat
    perc_leanwuzla_tot = tot_leanwuzla / tot_bitwuzla * 100

    f = open(performance_smtlib_dir, "a+")
    f.write(r"\newcommand{\SMTLIBBitwuzlaSolvedSat}{" + str(tot_bitwuzla_sat) + "}\n")
    f.write(
        r"\newcommand{\SMTLIBBitwuzlaSolvedUnsat}{" + str(tot_bitwuzla_unsat) + "}\n"
    )
    f.write(r"\newcommand{\SMTLIBBitwuzlaSolved}{" + str(tot_bitwuzla) + "}\n")
    f.write(r"\newcommand{\SMTLIBLeanwuzlaSolvedSat}{" + str(tot_leanwuzla_sat) + "}\n")
    f.write(
        r"\newcommand{\SMTLIBLeanwuzlaSolvedUnsat}{" + str(tot_leanwuzla_unsat) + "}\n"
    )
    f.write(r"\newcommand{\SMTLIBLeanwuzlaSolved}{" + str(tot_leanwuzla) + "}\n")
    f.write(
        r"\newcommand{\SMTLIBGeomeanSlowdownSat}{"
        + ("%.1f" % geomean_slowdown_smtlib_sat)
        + "}\n"
    )
    f.write(
        r"\newcommand{\SMTLIBGeomeanSlowdownUnsat}{"
        + ("%.1f" % geomean_slowdown_smtlib_unsat)
        + "}\n"
    )
    f.write(
        r"\newcommand{\SMTLIBGeomeanSlowdownTot}{"
        + ("%.1f" % geomean_slowdown_smtlib_tot)
        + "}\n"
    )
    f.write(r"\newcommand{\SMTLIBBothUnknown}{" + str(problems_both_unknown) + "}\n")
    f.write(
        r"\newcommand{\SMTLIBLeanwuzlaOnlyUnknown}{"
        + str(problems_lw_only_unknown)
        + "}\n"
    )
    f.write(
        r"\newcommand{\SMTLIBPercLeanwuzlaSolvedSAT}{"
        + ("%.1f" % perc_leanwuzla_sat)
        + "}\n"
    )
    f.write(
        r"\newcommand{\SMTLIBPercLeanwuzlaSolvedUNSAT}{"
        + ("%.1f" % perc_leanwuzla_unsat)
        + "}\n"
    )
    f.write(
        r"\newcommand{\SMTLIBPercLeanwuzlaSolvedTot}{"
        + ("%.1f" % perc_leanwuzla_tot)
        + "}\n"
    )
    f.close()


def smtlib_nokernel_stats(performance_smtlib_nokernel_dir):
    df_bitwuzla = pd.read_csv("raw-data/SMT-LIB/bitwuzla_data.csv")
    df_bv_decide = pd.read_csv("raw-data/SMT-LIB/bv_decide-nokernel_data.csv")
    df_bitwuzla["benchmark"] = df_bitwuzla["benchmark"].apply(os.path.dirname)
    df_bv_decide["benchmark"] = df_bv_decide["benchmark"].apply(os.path.dirname)
    assert len(df_bitwuzla) == len(df_bv_decide)
    merged_df = pd.merge(
        df_bitwuzla, df_bv_decide, on="benchmark", how="inner", suffixes=("_bw", "_lw")
    )
    df_clean_tmp = merged_df[merged_df["result_bw"] != "unknown"]
    df_clean = df_clean_tmp[df_clean_tmp["result_lw"] != "unknown"]
    # create new df for slowdown
    slowdown_df = df_clean.copy()
    slowdown_df["slowdown"] = df_clean["total_lw"] / df_clean["total_bw"]
    # geomean slowdown, leanwuzla vs. bitwuzla, SAT problems (removing all unknowns)
    slowdown_df_sat = slowdown_df[slowdown_df["result_bw"] == "sat"]
    geomean_slowdown_smtlib_sat = geomean(slowdown_df_sat["slowdown"])
    # geomean slowdown, leanwuzla vs. bitwuzla, UNSAT problems (removing all unknowns)
    slowdown_df_unsat = slowdown_df[slowdown_df["result_bw"] == "unsat"]
    geomean_slowdown_smtlib_unsat = geomean(slowdown_df_unsat["slowdown"])
    # geomean slowdown, leanwuzla vs. bitwuzla, UNSAT+SAT problems (removing all unknowns)
    geomean_slowdown_smtlib_tot = geomean(slowdown_df["slowdown"])
    tot_num_problems = len(df_bitwuzla)
    # num. of problems where neither leanwuzla nor bitwuzla terminate
    merged_df_both_unknown = merged_df[
        (merged_df["result_bw"] == "unknown") & (merged_df["result_lw"] == "unknown")
    ]
    problems_both_unknown = len(merged_df_both_unknown)
    # num. of problems where bitwuzla terminates and leanwuzla does not terminate
    merged_df_lw_only_unknown = merged_df[
        (merged_df["result_bw"] != "unknown") & (merged_df["result_lw"] == "unknown")
    ]
    problems_lw_only_unknown = len(merged_df_lw_only_unknown)
    # num. of problems where leanwuzla terminates and bitwuzla does not terminate
    merged_df_bw_only_unknown = merged_df[
        (merged_df["result_bw"] == "unknown") & (merged_df["result_lw"] != "unknown")
    ]
    problems_bw_only_unknown = len(merged_df_bw_only_unknown)
    # perc. of SAT solved by leanwuzla
    tot_bitwuzla_sat = len(merged_df[merged_df["result_bw"] == "sat"])
    tot_leanwuzla_sat = len(merged_df[merged_df["result_lw"] == "sat"])
    perc_leanwuzla_sat = tot_leanwuzla_sat / tot_bitwuzla_sat * 100
    # perc. of UNSAT solved by leanwuzla
    tot_bitwuzla_unsat = len(merged_df[merged_df["result_bw"] == "unsat"])
    tot_leanwuzla_unsat = len(merged_df[merged_df["result_lw"] == "unsat"])
    perc_leanwuzla_unsat = tot_leanwuzla_unsat / tot_bitwuzla_unsat * 100
    # plot_smtlib_slowdown_families_raw(merged_df)
    # perc. of SAT + UNSAT solved by leanwuzla
    tot_bitwuzla = tot_bitwuzla_sat + tot_bitwuzla_unsat
    tot_leanwuzla = tot_leanwuzla_sat + tot_leanwuzla_unsat
    perc_leanwuzla_tot = tot_leanwuzla / tot_bitwuzla * 100

    f = open(performance_smtlib_nokernel_dir, "a+")
    f.write(r"\newcommand{\SMTLIBProblemsTot}{" + str(tot_num_problems) + "}\n")
    f.write(
        r"\newcommand{\SMTLIBLeanwuzlaNoKernelSolvedSat}{"
        + str(tot_leanwuzla_sat)
        + "}\n"
    )
    f.write(
        r"\newcommand{\SMTLIBLeanwuzlaNoKernelSolvedUnsat}{"
        + str(tot_leanwuzla_unsat)
        + "}\n"
    )
    f.write(
        r"\newcommand{\SMTLIBLeanwuzlaNoKernelSolved}{" + str(tot_leanwuzla) + "}\n"
    )
    f.write(
        r"\newcommand{\SMTLIBNoKernelGeomeanSlowdownSat}{"
        + ("%.1f" % geomean_slowdown_smtlib_sat)
        + "}\n"
    )
    f.write(
        r"\newcommand{\SMTLIBNoKernelGeomeanSlowdownUnsat}{"
        + ("%.1f" % geomean_slowdown_smtlib_unsat)
        + "}\n"
    )
    f.write(
        r"\newcommand{\SMTLIBNoKernelGeomeanSlowdownTot}{"
        + ("%.1f" % geomean_slowdown_smtlib_tot)
        + "}\n"
    )
    f.write(
        r"\newcommand{\SMTLIBNoKernelBothUnknown}{" + str(problems_both_unknown) + "}\n"
    )
    f.write(
        r"\newcommand{\SMTLIBLeanwuzlaNoKernelOnlyUnknown}{"
        + str(problems_lw_only_unknown)
        + "}\n"
    )
    f.write(
        r"\newcommand{\SMTLIBBitwuzlaOnlyUnknown}{"
        + str(problems_bw_only_unknown)
        + "}\n"
    )
    f.write(
        r"\newcommand{\SMTLIBPercLeanwuzlaNoKernelSolvedSAT}{"
        + ("%.1f" % perc_leanwuzla_sat)
        + "}\n"
    )
    f.write(
        r"\newcommand{\SMTLIBPercLeanwuzlaNoKernelSolvedUNSAT}{"
        + ("%.1f" % perc_leanwuzla_unsat)
        + "}\n"
    )
    f.write(
        r"\newcommand{\SMTLIBPercLeanwuzlaNoKernelSolvedTot}{"
        + ("%.1f" % perc_leanwuzla_tot)
        + "}\n"
    )
    f.close()


def instcombine_stats(performance_instcombine_dir):
    df_ceg = pd.read_csv("raw-data/InstCombine/instcombine_ceg_data.csv")
    df = pd.read_csv("raw-data/InstCombine/instcombine_solved_data.csv")
    df_err = pd.read_csv("raw-data/InstCombine/instcombine_err_data.csv")
    df_err_bv_decide = []
    print(df_err)
    for idx1, row1 in df_err.iterrows() : 
        loc1 = row1[1].split(",")[0]
        msg1 = row1[1].split(",")[1]
        found = False
        for idx2, row2 in df_err.iterrows() : 
            loc2 = row2[1].split(",")[0]
            msg2 = row2[1].split(",")[1]
            if loc1 == loc2 and msg1 != msg2: 
                df_err_bv_decide.append(row2)
                found = True 
        if not found: 
            df_err_bv_decide.append(row1)



    get_avg_bb_sat(df, "InstCombine", "sat", performance_instcombine_dir)
    get_avg_bb_sat(df, "InstCombine", "lrat", performance_instcombine_dir)
    tot_problems = len(df) + len(df_ceg) + len(df_err_bv_decide)
    tot_problems_solved = len(df)


    print("tot_solved:"+str(len(df)))
    print("tot_ceg: "+str(len(df_ceg)))
    print("tot_err: "+str(len(df_err_bv_decide)))
    print(tot_problems)
    f = open(performance_instcombine_dir, "a+")
    f.write(r"\newcommand{\InstCombineNProblemsTot}{" + str(tot_problems) + "}\n")
    f.write(
        r"\newcommand{\InstCombineNumProblemsSolved}{"
        + str(tot_problems_solved)
        + "}\n"
    )
    # slowdown
    slowdown_df = df.copy()

    slowdown_df["slowdown"] = df["solved_bv_decide_times_average"] / df["solved_bitwuzla_times_average"]
    # geomean slowdown where both leanwuzla and bitwuzla terminate
    geomean_time_instcombine_bvdecide = geomean(df["solved_bv_decide_times_average"])
    geomean_time_instcombine_bitwuzla = geomean(df["solved_bitwuzla_times_average"])
    geomean_slowdown_instcombine = geomean(slowdown_df["slowdown"])
    mean_slowdown_instcombine = np.mean(slowdown_df["slowdown"])
    f.write(
        r"\newcommand{\InstCombineGeomeanBvDecide}{"
        + ("%.2f" % geomean_time_instcombine_bvdecide)
        + "}\n"
    )
    f.write(
        r"\newcommand{\InstCombineGeomeanBitwuzla}{"
        + ("%.2f" % geomean_time_instcombine_bitwuzla)
        + "}\n"
    )
    f.write(
        r"\newcommand{\InstCombineGeomeanSlowdown}{"
        + ("%.1f" % geomean_slowdown_instcombine)
        + "}\n"
    )
    f.write(
        r"\newcommand{\InstCombineMeanSlowdown}{"
        + ("%.1f" % mean_slowdown_instcombine)
        + "}\n"
    )
    f.close()


def hackersdelight_stats(performance_hackersdelight_dir):
    files = ["ch2_1DeMorgan", "ch2_2AdditionAndLogicalOps"]
    for bvw in bv_widths:
        dfs = []
        for file in files:
            # df_ceg=pd.read_csv('../raw-data/HackersDelight/bvw'+str(bvw)+'_'+file+'_ceg_data.csv')
            df = pd.read_csv(
                "raw-data/HackersDelight/"
                + file 
                + "_"
                + str(bvw)
                + "_solved_data.csv"
            )
            if len(df) > 0:
                dfs.append(df)
        # concatenate all dataframes from all files
        df_concat = pd.concat(dfs, ignore_index=True)
        get_avg_bb_sat(
            df_concat,
            "HackersDelight" + num2words.num2words(bvw).replace("-", ""),
            "sat",
            performance_hackersdelight_dir,
        )
        get_avg_bb_sat(
            df_concat,
            "HackersDelight" + num2words.num2words(bvw).replace("-", ""),
            "lrat",
            performance_hackersdelight_dir,
        )


def generate_latex_table_smtlib_problems_solved():
    df_bitwuzla_46k = pd.read_csv("../raw-data/SMTLIB/bitwuzla_46k.csv")
    df_leanwuzla_46k = pd.read_csv("../raw-data/SMTLIB/leanwuzla_46k.csv")
    df_coq_46k = pd.read_csv("../raw-data/SMTLIB/coq_46k.csv")
    df_coq_46k = df_coq_46k.rename(
        columns=lambda x: x + "_coq" if x != "benchmark" else x
    )
    merged_df = pd.merge(
        df_bitwuzla_46k, df_leanwuzla_46k, on="benchmark", suffixes=("_bw", "_lw")
    )
    merged_df = pd.merge(merged_df, df_coq_46k, on="benchmark")
    # merged_df.to_csv('tmp.csv')
    # filter out results that are unknown for either of the two or not consistent
    unknown_bw = len(merged_df[merged_df["result_bw"] == "unknown"])
    unknown_lw = len(merged_df[merged_df["result_lw"] == "unknown"])
    unknown_coq = len(merged_df[merged_df["result_coq"] == "unknown"])
    sat_bw = len(merged_df[merged_df["result_bw"] == "sat"])
    sat_lw = len(merged_df[merged_df["result_lw"] == "sat"])
    sat_coq = len(merged_df[merged_df["result_coq"] == "sat"])
    unsat_bw = len(merged_df[merged_df["result_bw"] == "unsat"])
    unsat_lw = len(merged_df[merged_df["result_lw"] == "unsat"])
    unsat_coq = len(merged_df[merged_df["result_coq"] == "unsat"])

    latex_table = "\\begin{tabular}{" + "l|" * 4 + "}\n"
    latex_table += "\\hline\n"
    latex_table += " Result & LeanSAT & Bitwuzla & CoqQFBV \\\\\n"
    latex_table += "\\hline\n"
    # no need to add a line for every bitwidth
    latex_table += (
        "unsat"
        + " & "
        + str(unsat_lw)
        + " & "
        + str(unsat_bw)
        + " & "
        + str(unsat_coq)
        + "\\\\\n"
    )
    latex_table += (
        "sat (counterexample found)"
        + " & "
        + str(sat_lw)
        + " & "
        + str(sat_bw)
        + " & "
        + str(sat_coq)
        + "\\\\\n"
    )
    latex_table += (
        "unknown"
        + " & "
        + str(unknown_lw)
        + " & "
        + str(unknown_bw)
        + " & "
        + str(unknown_coq)
        + "\\\\\n"
    )
    latex_table += "\\end{tabular}"
    return latex_table


# f = open('../solved_theorems.tex', 'w')
# f.write(generate_latex_table_tot_solved())
# f.close()

# f = open('../solved_times_hackersdelight.tex', 'w')
# f.write(generate_latex_table_hackerdelight_solved_times())
# f.close()

# f = open('../ceg_times_hackersdelight.tex', 'w')
# f.write(generate_latex_table_hackerdelight_ceg_times())
# f.close()

# f = open('../solved_times_instcombine.tex', 'w')
# f.write(generate_latex_table_instcombine_solved_times())
# f.close()

# f = open('../ceg_times_instcombine.tex', 'w')
# f.write(generate_latex_table_instcombine_ceg_times())
# f.close()

# f = open('../solved_problems_smtlib.tex', 'w')
# f.write(generate_latex_table_smtlib_problems_solved())
# f.close()

performance_smtlib_dir = "tables/performance-smtlib.tex"
performance_smtlib_nokernel_dir = "tables/performance-smtlib-nokernel.tex"
performance_instcombine_dir = "tables/performance-instcombine.tex"
performance_hackerdelight_dir = "tables/performance-hackersdelight.tex"
performance_hackersdelight_symbolic_file = "tables/performance-hackersdelight-symbolic.tex"
performance_instcombine_symbolic_file = "tables/performance-instcombine-symbolic.tex"
performance_alive_symbolic_file = "tables/performance-alive-symbolic.tex"

# slowdown_smtlib_stats()

# first remove old stats

# with open (performance_smtlib_dir, "w"):
#    pass

with open(performance_instcombine_dir, "w"):
    pass

with open(performance_hackerdelight_dir, "w"):
    pass

instcombine_stats(performance_instcombine_dir)
hackersdelight_stats(performance_hackerdelight_dir)
# smtlib_stats(performance_smtlib_dir)
# smtlib_nokernel_stats(performance_smtlib_nokernel_dir)
