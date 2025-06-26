#!/usr/bin/env python3

import argparse
import os
import pandas as pd
import matplotlib
import matplotlib.pyplot as plt
import numpy as np
import math

from typing import Callable

instCombineDataDir = "../raw-data/InstCombine/"
hackersDelightDataDir = "../raw-data/HackersDelight/"
SMTLIBDataDir = "../raw-data/SMTLIB/"


def setGlobalDefaults():
    ## Use TrueType fonts instead of Type 3 fonts
    #
    # Type 3 fonts embed bitmaps and are not allowed in camera-ready submissions
    # for many conferences. TrueType fonts look better and are accepted.
    # This follows: https://www.conference-publishing.com/Help.php
    matplotlib.rcParams["pdf.fonttype"] = 42
    matplotlib.rcParams["ps.fonttype"] = 42

    ## Enable tight_layout by default
    #
    # This ensures the plot has always sufficient space for legends, ...
    # Without this sometimes parts of the figure would be cut off.
    matplotlib.rcParams["figure.autolayout"] = True

    ## Legend defaults
    matplotlib.rcParams["legend.frameon"] = False

    # Hide the right and top spines
    #
    # This reduces the number of lines in the plot. Lines typically catch
    # a readers attention and distract the reader from the actual content.
    # By removing unnecessary spines, we help the reader to focus on
    # the figures in the graph.
    matplotlib.rcParams["axes.spines.right"] = False
    matplotlib.rcParams["axes.spines.top"] = False


matplotlib.rcParams["figure.figsize"] = 14, 7
matplotlib.rcParams.update({"font.size": 16})


# Color palette
light_gray = "#cacaca"
dark_gray = "#827b7b"
light_blue = "#a6cee3"
dark_blue = "#1f78b4"
light_green = "#b2df8a"
dark_green = "#33a02c"
light_red = "#fb9a99"
dark_red = "#e31a1c"
black = "#000000"
white = "#ffffff"

col = [
    "#a6cee3",
    "#1f78b4",
    "#b2df8a",
    "#33a02c",
    "#fb9a99",
    "#e31a1c",
    "#000000",
    "#ffffff",
]


def save(figure, name):
    # Do not emit a creation date, creator name, or producer. This will make the
    # content of the pdfs we generate more deterministic.
    metadata = {"CreationDate": None, "Creator": None, "Producer": None}
    # plt.tight_layout()
    plt.tight_layout()

    figure.savefig(name, metadata=metadata)

    # Close figure to avoid warning about too many open figures.
    plt.close(figure)

    print(f"written to {name}")



def bar_bw_impact(dfs, bm, tool, bv_width):
    i = 0
    fig, ax = plt.subplots()
    width = 0.15
    items = []
    max = 0
    for i, bvw in enumerate(bv_width):
        df = dfs[dfs["bvw"] == str(bvw)]
        a = ax.bar(
            np.arange(df.shape[0]) - width + (i - 1) * width,
            df[tool],
            width,
            color=col[i],
            label=bv_width[i],
        )
        items.append(a)
        if np.max(df[tool]) > max:
            max = np.max(df[tool])
    ax.set_xlabel("Theorems")
    ax.set_ylabel("Time [ms]", rotation="horizontal", horizontalalignment="left", y=1)
    ax.set_yscale("log")
    ax.set_xticks(np.arange(df.shape[0]))
    ax.legend(loc="center right", ncols=1, frameon=False, bbox_to_anchor=(1.2, 0.5))
    # enable autolabel if necessary
    # for a in items:
    #   autolabel(ax, a)
    save(fig, tool + "_" + bm.split(".")[0] + ".pdf")


def compare_tools_same_bw(df, bm, tool1, tool2):
    max = np.max(df[tool1])
    fig, ax = plt.subplots()
    df_sorted = df.sort_values(by="leanSAT")
    ax.plot(
        np.arange(len(df_sorted[tool1])), df_sorted[tool1], color=col[0], label=tool1
    )
    ax.plot(
        np.arange(len(df_sorted[tool2])), df_sorted[tool2], color=col[3], label=tool2
    )
    if np.max(df_sorted[tool2]) > max:
        max = np.max(df_sorted[tool2])
    ax.set_xlabel("Theorems")
    ax.set_ylabel("Time [ms]", rotation="horizontal", horizontalalignment="left", y=1)
    ax.set_xticks(np.arange(len(df[tool1])))
    ax.legend(loc="center right", ncols=1, frameon=False, bbox_to_anchor=(1.2, 0.5))
    ax.set_yscale("log")
    save(fig, tool1 + "_" + tool2 + "_" + bm.split(".")[0] + ".pdf")


def compare_tools_diff_bw(dfs, bm, tool1, tool2, bv_width):
    fig, ax = plt.subplots()
    width = 0.15
    max = 0.0
    for i, bvw in enumerate(bv_width):
        df = dfs[dfs["bvw"] == str(bvw)]
        ax.bar(
            np.arange(len(df[tool1])) - width + (i - 1) * width,
            np.subtract(df[tool1], df[tool2]),
            width,
            color=col[i],
            label=bv_width[i],
        )
        i = i + 1
        if np.max(np.subtract(df[tool1], df[tool2])) > max:
            max = np.max(np.subtract(df[tool1], df[tool2]))
    ax.set_xlabel("Theorems")
    ax.set_ylabel("Time [ms]", rotation="horizontal", horizontalalignment="left", y=1)
    ax.set_xticks(np.arange(len(df[tool1])))
    ax.legend(loc="center right", ncols=1, frameon=False, bbox_to_anchor=(1.2, 0.5))
    save(fig, tool1 + "_" + tool2 + "_diff_" + bm.split(".")[0] + ".pdf")


def leanSAT_tot_stacked_perc(df, bm, type):
    if type == "h_tot":
        matplotlib.rcParams["figure.figsize"] = 14, 3
    x = np.arange(len(df["leanSAT"]))
    width = 1.0
    fig, ax = plt.subplots(figsize=(14, 3.5))
    # df_sorted = df.sort_values(by="leanSAT")
    # print(df_sorted)
    tot_sum = (
        df["leanSAT-rw"]
        + df["leanSAT-bb"]
        + df["leanSAT-sat"]
        + df["leanSAT-lrat-t"]
        + df["leanSAT-lrat-c"]
    )
    df["tot-sum"] = tot_sum
    df_sorted = df.sort_values(by="tot-sum")
    # print(df_sorted)
    ax_right = ax.twinx()

    ax.bar(
        x,
        np.divide(df_sorted["leanSAT-rw"], df_sorted["tot-sum"]) * 100,
        width,
        label="rewriting",
        bottom=np.zeros_like(df_sorted["leanSAT-rw"]),
        color=dark_blue,
        edgecolor=dark_blue,
    )
    ax.bar(
        x,
        np.divide(
            df_sorted["leanSAT-bb"] + df_sorted["leanSAT-sat"], df_sorted["tot-sum"]
        )
        * 100,
        width,
        label="bit-blasting and SAT solving",
        bottom=np.divide(df_sorted["leanSAT-rw"], df_sorted["tot-sum"]) * 100,
        color=light_gray,
        edgecolor=light_gray,
    )
    ax.bar(
        x,
        np.divide(
            df_sorted["leanSAT-lrat-t"] + df_sorted["leanSAT-lrat-c"],
            df_sorted["tot-sum"],
        )
        * 100,
        width,
        label="LRAT",
        bottom=np.divide(df_sorted["leanSAT-rw"], df_sorted["tot-sum"]) * 100
        + np.divide(
            df_sorted["leanSAT-bb"] + df_sorted["leanSAT-sat"], df_sorted["tot-sum"]
        )
        * 100,
        color=dark_green,
        edgecolor=dark_green,
    )
    ax_right.plot(
        x,
        df_sorted["tot-sum"],
        width,
        label="total time",
        color=black,
    )
    ax_right.set_yscale("log")
    ax.set_xticks(
        np.arange(0, len(df_sorted), 10 ** np.floor(np.log10(len(df_sorted))))
    )
    # ax.set_title("Time to solve theorems from "+bm, pad=20)
    ax.set_ylabel(
        "Distribution [%]", rotation="horizontal", horizontalalignment="left", y=1.05
    )
    ax_right.set_ylabel(
        "Time [ms]", rotation="horizontal", horizontalalignment="right", y=1.08
    )
    ax.legend(ncols=4, frameon=False, bbox_to_anchor=[0.5, 1], loc="lower center")
    plt.gca().spines["right"].set_visible(True)
    save(fig, "leanSAT_stacked_perc_" + bm.split(".")[0] + ".pdf")


def leanSAT_smtlib_unsat_stacked_perc(df: pd.DataFrame, bm, type):
    if type == "h_tot":
        matplotlib.rcParams["figure.figsize"] = 14, 5
    x = np.arange(len(df["benchmark"]))
    width = 1.0
    fig, ax = plt.subplots()
    # df_sorted = df.sort_values(by="leanSAT")
    # print(df_sorted)
    df = df.apply(
        lambda x: x / 10**6
        if x.name
        in [
            "leanSAT-ld",
            "leanSAT-rr",
            "leanSAT-ac",
            "leanSAT-af",
            "leanSAT-ecs",
            "leanSAT-bb",
            "leanSAT-sat",
            "leanSAT-lrat",
            "leanSAT-kc",
        ]
        else x
    )
    tot_sum = (
        df["leanSAT-ld"]
        + df["leanSAT-rr"]
        + df["leanSAT-ac"]
        + df["leanSAT-af"]
        + df["leanSAT-ecs"]
        + df["leanSAT-bb"]
        + df["leanSAT-sat"]
        + df["leanSAT-lrat"]
        + df["leanSAT-kc"]
    )
    df["tot-sum"] = tot_sum
    df_sorted = df.sort_values(by="tot-sum")
    # print(df_sorted)
    ax_right = ax.twinx()

    bottom = np.zeros_like(df_sorted["leanSAT-ld"])
    ax.bar(
        x,
        np.divide(
            df_sorted["leanSAT-ld"]
            + df_sorted["leanSAT-rr"]
            + df_sorted["leanSAT-ac"]
            + df_sorted["leanSAT-af"]
            + df_sorted["leanSAT-ecs"]
            + df_sorted["leanSAT-kc"],
            df_sorted["tot-sum"],
        )
        * 100,
        width,
        label="rewriting + kernel checking",
        bottom=bottom,
        color=dark_blue,
        edgecolor=dark_blue,
    )
    bottom += (
        np.divide(
            df_sorted["leanSAT-ld"]
            + df_sorted["leanSAT-rr"]
            + df_sorted["leanSAT-ac"]
            + df_sorted["leanSAT-af"]
            + df_sorted["leanSAT-ecs"]
            + df_sorted["leanSAT-kc"],
            df_sorted["tot-sum"],
        )
        * 100
    )
    ax.bar(
        x,
        np.divide(
            df_sorted["leanSAT-bb"] + df_sorted["leanSAT-sat"], df_sorted["tot-sum"]
        )
        * 100,
        width,
        label="bit-blasting and SAT solving",
        bottom=bottom,
        color=light_gray,
        edgecolor=light_gray,
    )
    bottom += (
        np.divide(
            df_sorted["leanSAT-bb"] + df_sorted["leanSAT-sat"], df_sorted["tot-sum"]
        )
        * 100
    )
    ax.bar(
        x,
        np.divide(df_sorted["leanSAT-lrat"], df_sorted["tot-sum"]) * 100,
        width,
        label="LRAT",
        bottom=bottom,
        color=dark_green,
        edgecolor=dark_green,
    )
    ax_right.plot(
        x,
        df_sorted["tot-sum"],
        width,
        label="total time",
        color=black,
    )
    ax_right.set_yscale("log")
    ax.set_xticks(
        np.arange(0, len(df_sorted), 10 ** np.floor(np.log10(len(df_sorted))))
    )
    # ax.set_title("Time to solve theorems from "+bm, pad=20)
    ax.set_ylabel(
        "Distribution [%]", rotation="horizontal", horizontalalignment="left", y=1.05
    )
    ax_right.set_ylabel(
        "Time [ms]", rotation="horizontal", horizontalalignment="right", y=1.08
    )
    ax.legend(ncols=4, frameon=False, bbox_to_anchor=[0.5, 1], loc="lower center")
    plt.gca().spines["right"].set_visible(True)
    save(fig, "leanSAT_stacked_smtlib_" + bm.split(".")[0] + ".pdf")


def leanSAT_smtlib_sat_stacked_perc(df: pd.DataFrame, bm, type):
    if type == "h_tot":
        matplotlib.rcParams["figure.figsize"] = 14, 5
    x = np.arange(len(df["benchmark"]))
    width = 1.0
    fig, ax = plt.subplots()
    # df_sorted = df.sort_values(by="leanSAT")
    # print(df_sorted)
    df = df.apply(
        lambda x: x / 10**6
        if x.name
        in [
            "leanSAT-ld",
            "leanSAT-rr",
            "leanSAT-ac",
            "leanSAT-af",
            "leanSAT-ecs",
            "leanSAT-bb",
            "leanSAT-sat",
            "leanSAT-lrat",
        ]
        else x
    )
    tot_sum = (
        df["leanSAT-ld"]
        + df["leanSAT-rr"]
        + df["leanSAT-ac"]
        + df["leanSAT-af"]
        + df["leanSAT-ecs"]
        + df["leanSAT-bb"]
        + df["leanSAT-sat"]
        + df["leanSAT-lrat"]
    )
    df["tot-sum"] = tot_sum
    df_sorted = df.sort_values(by="tot-sum")
    # print(df_sorted)
    ax_right = ax.twinx()

    bottom = np.zeros_like(df_sorted["leanSAT-ld"])
    ax.bar(
        x,
        np.divide(
            df_sorted["leanSAT-ld"]
            + df_sorted["leanSAT-rr"]
            + df_sorted["leanSAT-ac"]
            + df_sorted["leanSAT-af"]
            + df_sorted["leanSAT-ecs"],
            df_sorted["tot-sum"],
        )
        * 100,
        width,
        label="rewriting",
        bottom=bottom,
        color=dark_blue,
        edgecolor=dark_blue,
    )
    bottom += (
        np.divide(
            df_sorted["leanSAT-ld"]
            + df_sorted["leanSAT-rr"]
            + df_sorted["leanSAT-ac"]
            + df_sorted["leanSAT-af"]
            + df_sorted["leanSAT-ecs"],
            df_sorted["tot-sum"],
        )
        * 100
    )
    ax.bar(
        x,
        np.divide(
            df_sorted["leanSAT-bb"] + df_sorted["leanSAT-sat"], df_sorted["tot-sum"]
        )
        * 100,
        width,
        label="bit-blasting and SAT solving",
        bottom=bottom,
        color=light_gray,
        edgecolor=light_gray,
    )
    ax_right.plot(
        x,
        df_sorted["tot-sum"],
        width,
        label="total time",
        color=black,
    )
    ax_right.set_yscale("log")
    ax.set_xticks(
        np.arange(0, len(df_sorted), 10 ** np.floor(np.log10(len(df_sorted))))
    )
    # ax.set_title("Time to solve theorems from "+bm, pad=20)
    ax.set_ylabel(
        "Distribution [%]", rotation="horizontal", horizontalalignment="left", y=1.05
    )
    ax_right.set_ylabel(
        "Time [ms]", rotation="horizontal", horizontalalignment="right", y=1.08
    )
    ax.legend(ncols=4, frameon=False, bbox_to_anchor=[0.5, 1], loc="lower center")
    plt.gca().spines["right"].set_visible(True)
    save(fig, "leanSAT_stacked_smtlib_" + bm.split(".")[0] + ".pdf")


def leanSAT_tot_stacked(df, bm):
    x = np.arange(len(df["leanSAT"]))
    width = 0.45
    fig, ax = plt.subplots()
    df_sorted = df.sort_values(by="leanSAT")
    # print(df_sorted)
    colors_in_order = ["#e31a1c", "#9ecae1", "#deebf7", "#74c476", "#bae4b3"]
    ax.bar(
        x,
        df_sorted["leanSAT-rw"],
        width,
        label="rewriting",
        bottom=np.zeros_like(df_sorted["leanSAT-rw"]),
        color=colors_in_order[0],
    )
    ax.bar(
        x,
        df_sorted["leanSAT-bb"],
        width,
        label="bit-blasting",
        bottom=df_sorted["leanSAT-rw"],
        color=colors_in_order[1],
    )
    ax.bar(
        x,
        df_sorted["leanSAT-sat"],
        width,
        label="sat solving",
        bottom=np.array(df_sorted["leanSAT-rw"]) + np.array(df_sorted["leanSAT-bb"]),
        color=colors_in_order[2],
    )
    ax.bar(
        x,
        df_sorted["leanSAT-lrat-t"],
        width,
        label="lrat-trimming",
        bottom=np.array(df_sorted["leanSAT-rw"])
        + np.array(df_sorted["leanSAT-bb"])
        + np.array(df_sorted["leanSAT-sat"]),
        color=colors_in_order[3],
    )
    ax.bar(
        x,
        df_sorted["leanSAT-lrat-c"],
        width,
        label="lrat-checking",
        bottom=np.array(df_sorted["leanSAT-rw"])
        + np.array(df_sorted["leanSAT-bb"])
        + np.array(df_sorted["leanSAT-sat"])
        + np.array(df_sorted["leanSAT-lrat-t"]),
        color=colors_in_order[4],
    )
    # ax.set_yscale("log")
    ax.set_xticks(np.arange(0, len(df_sorted), len(df_sorted) - 1))
    ax.set_title("Time to solve theorems from " + bm, pad=20)
    ax.set_ylabel("Time [ms]", rotation="horizontal", horizontalalignment="left", y=1)
    ax.legend(loc="best", ncols=1, frameon=False)
    save(fig, "leanSAT_stacked_" + bm.split(".")[0] + ".pdf")


def leanSAT_tot_stacked_area(df, bm):
    x = np.arange(len(df["leanSAT"]))
    fig, ax = plt.subplots()
    df_sorted = df.sort_values(by="leanSAT")
    x = np.arange(len(df["leanSAT"]))
    fig, ax = plt.subplots()
    colors_in_order = ["#bdd7e7", "#6baed6", "#3182bd", "#bae4b3", "#74c476"]
    ax.stackplot(
        x,
        df_sorted["leanSAT-rw"],
        df_sorted["leanSAT-bb"],
        df_sorted["leanSAT-sat"],
        df_sorted["leanSAT-lrat-t"],
        df_sorted["leanSAT-lrat-c"],
        labels=["rw", "bb", "sat", "lrat-t", "lrats"],
        colors=colors_in_order,
    )

    ax.set_yscale("log")
    ax.set_xticks(np.arange(0, 51, 50))
    ax.set_xlabel("Theorems")
    ax.set_ylabel("Time [ms]", rotation="horizontal", horizontalalignment="left", y=1)
    ax.legend(loc="center right", ncols=1, frameon=False, bbox_to_anchor=(1.2, 0.5))
    save(fig, "leanSAT_stacked_area_" + bm.split(".")[0] + ".pdf")


# for hackers delight we want to consider bitwidth in the plotting
def cumul_solving_time_hackers_delight(df, tool1, tool2, bm, bv_width):
    matplotlib.rcParams["figure.figsize"] = 14, 5

    fig, ax = plt.subplots(1, 3)
    for i, bvw in enumerate([4, 16, 64]):
        df_tmp = df.loc[df["bvw"] == str(bvw)]
        df_sorted = df_tmp.sort_values(by="leanSAT")

        sorted1 = np.sort(df_sorted[tool1])
        sorted2 = np.sort(df_sorted[tool2])
        cumtime1 = [0]
        cumtime1.extend(np.cumsum(sorted1))
        cumtime2 = [0]
        cumtime2.extend(np.cumsum(sorted2))

        ax[i].plot(
            cumtime1,
            np.arange(0, len(df_sorted[tool1]) + 1),
            marker="o",
            color=col[0],
            label="bv_decide",
        )
        ax[i].plot(
            cumtime2,
            np.arange(0, len(df_sorted[tool2]) + 1),
            marker="x",
            color=col[3],
            label=tool2,
        )
        ax[i].set_xlabel("bitwidth: " + str(bvw))
        ax[i].set_xscale("log")
    ax[0].set_ylabel("Problems solved", rotation="vertical", ha="center")
    # ax.set_yscale("log")
    ax[1].set_title("bv_decide vs. Bitwuzla Scaling Solving Hackers' Delight Theorems")
    ax[0].legend(loc="upper left", ncols=1, frameon=False)
    ax[1].text(
        0.5, -0.28, "Cumulative Time [ms]", transform=ax[1].transAxes, ha="center"
    )
    save(fig, "cumul_problems_bv_4_16_64_" + bm.split(".")[0] + ".pdf")


def cumul_solving_time(df, tool1, tool2, bm):
    fig, ax = plt.subplots(figsize=(14, 3))
    sorted1 = np.sort(df[tool1])
    sorted2 = np.sort(df[tool2])
    cumtime1 = [0]
    cumtime1.extend(np.cumsum(sorted1))
    cumtime2 = [0]
    cumtime2.extend(np.cumsum(sorted2))
    ax.plot(
        cumtime1,
        np.arange(0, len(df[tool1]) + 1),
        marker="o",
        color=col[0],
        label="bv_decide",
    )
    ax.plot(
        cumtime2,
        np.arange(0, len(df[tool2]) + 1),
        marker="x",
        color=col[3],
        label=tool2,
    )
    ax.set_xlabel("Time [ms]")
    ax.set_xscale("log")
    ax.set_ylabel("Problems solved", rotation="horizontal", ha="left", y=1)
    # ax.set_xscale("log")
    # ax.set_yscale("log")
    ax.legend(loc="upper left", ncols=1, frameon=False)
    # ax.legend(loc="center right", ncols=1, frameon=False, bbox_to_anchor=(1.2, 0.5))
    save(fig, "cumul_problems_llvm_" + bm.split(".")[0] + ".pdf")


def cumul_solving_time_smtlib(df, name):
    fig, ax = plt.subplots(figsize=(14, 3))
    plt.rcParams["path.simplify_threshold"] = 1
    # only consider rows where the problem was actually sat/unsat
    sorted1 = np.sort(df["time_cpu_bw"])
    sorted2 = np.sort(df["time_cpu_lwt"])
    sorted3 = np.sort(df["time_cpu_lw"])
    sorted4 = np.sort(df["time_cpu_coq"])
    cumtime1 = [0]
    cumtime1.extend(np.cumsum(sorted1))
    cumtime2 = [0]
    cumtime2.extend(np.cumsum(sorted2))
    cumtime3 = [0]
    cumtime3.extend(np.cumsum(sorted3))
    cumtime4 = [0]
    cumtime4.extend(np.cumsum(sorted4))
    ax.plot(
        cumtime1,
        np.arange(0, len(df["time_cpu_bw"]) + 1),
        marker="o",
        color=dark_green,
        label="bitwuzla",
    )
    ax.plot(
        cumtime2,
        np.arange(0, len(df["time_cpu_lwt"]) + 1),
        marker="x",
        color=light_blue,
        label="bv_decide (no kernel)",
    )
    ax.plot(
        cumtime3,
        np.arange(0, len(df["time_cpu_lw"]) + 1),
        marker="x",
        color=dark_blue,
        label="bv_decide (+ kernel)",
    )
    ax.plot(
        cumtime4,
        np.arange(0, len(df["time_cpu_coq"]) + 1),
        marker="*",
        color=dark_red,
        label="CoqQFBV",
    )
    ax.set_xscale("log")
    ax.set_xlabel("Time [s] - " + name.upper() + " results")
    ax.set_ylabel("Problems solved", rotation="horizontal", ha="left", y=1)
    # add a line to highlight the difference in #solved problems between the tools
    # x_start = cumtime1[len([x for x in np.array(df['time_cpu_lw']) if x > 0])-10]
    # x_end = np.sum(df['time_cpu_lw'])
    # y_value = len([x for x in np.array(df['time_cpu_lw']) if x > 0])
    # ax.plot([x_start, x_end], [len([x for x in np.array(df['time_cpu_lw']) if x > 0]), len([x for x in np.array(df['time_cpu_lw']) if x > 0])], color='black', linestyle='--', linewidth=1)
    # ax.annotate(f"10^{int(np.round(np.log10(x_end - x_start)))} s",
    #         xy=(x_start+(x_end-x_start)/2, y_value),
    #         xytext=((x_end-x_start)/2, y_value * 1.01),
    #         fontsize=12, color='black')

    # x_start_c = cumtime1[len([x for x in np.array(df['time_cpu_coq']) if x > 0])-10]
    # x_end_c = np.sum(df['time_cpu_coq'])
    # y_value_c = len([x for x in np.array(df['time_cpu_coq']) if x > 0])
    # ax.plot([x_start_c, x_end_c], [len([x for x in np.array(df['time_cpu_coq']) if x > 0]), len([x for x in np.array(df['time_cpu_coq']) if x > 0])], color='black', linestyle='--', linewidth=1)
    # ax.annotate(f"10^{int(np.round(np.log10(x_end_c - x_start_c)))} s",
    #         xy=(x_start_c, y_value_c),
    #         xytext=((x_end_c-x_start_c)/2, y_value_c * 1.01),
    #         fontsize=12, color='black')

    # y_start = next((i for i, x in enumerate(cumtime2) if x > np.sum(df['time_cpu_bw'])), -1)
    # y_end = len(df['time_cpu_bw'])
    # print(cumtime1[-1])
    # x_value = np.sum(df['time_cpu_bw'])
    # ax.plot([x_value, x_value], [y_start, y_end], color='black', linestyle='dashed', linewidth=1)
    # y_end = next((i for i, x in enumerate(cumtime2) if x > np.sum(df['time_cpu_bw'])), -1)
    # y_start = 0
    # print(cumtime1[-1])
    # x_value = np.sum(df['time_cpu_bw'])
    # ax.plot([x_value, x_value], [y_start, y_end], color='black', linestyle='solid', linewidth=2)
    # ax.annotate(f"{int(y_end)} problems",
    #         xy=(x_start, y_value),
    #         xytext=(x_value*1.1, y_end * 0.95),
    #         fontsize=12, color='black')

    # x_start_c = cumtime1[len([x for x in np.array(df['time_cpu_coq']) if x > 0])-10]
    # x_end_c = np.sum(df['time_cpu_coq'])
    # y_value_c = len([x for x in np.array(df['time_cpu_coq']) if x > 0])
    # ax.plot([x_start_c, x_end_c], [len([x for x in np.array(df['time_cpu_coq']) if x > 0]), len([x for x in np.array(df['time_cpu_coq']) if x > 0])], color='black', linestyle='--', linewidth=1)
    # ax.annotate(f"10^{int(np.round(np.log10(x_end_c - x_start_c)))} s",
    #         xy=(x_start_c, y_value_c),
    #         xytext=((x_end_c-x_start_c)/2, y_value_c * 1.01),
    #         fontsize=12, color='black')

    # ax.axvline(np.sum(df['time_cpu_bw']), color = black, linestyle = '--')
    # ax.set_xscale("log")
    # ax.set_yscale("log")
    # ax.legend(loc="center right", ncols=1, frameon=False, bbox_to_anchor=(1.2, 0.5))
    ax.legend(loc="upper left", ncols=1, frameon=False)
    save(fig, "cumul_problems_smtlib_" + name + ".pdf")


def scatter_solving_time_smtlib(df_sat, df_unsat):
    fig, ax = plt.subplots(1, 2, figsize=(14, 4), sharey=True)

    ax[0].scatter(
        df_sat["time_cpu_bw"],
        df_sat["time_cpu_lw"],
        c="#beaed4",
        label="SAT results",
        marker=".",
    )
    ax[1].scatter(
        df_unsat["time_cpu_bw"],
        df_unsat["time_cpu_lw"],
        c="#fdc086",
        label="UNSAT results",
        marker=".",
    )

    ax[0].set_xlabel("SAT")
    ax[1].set_xlabel("UNSAT")

    time_sat_min = min(df_sat["time_cpu_bw"].min(), df_sat["time_cpu_lw"].min())
    time_sat_max = max(df_sat["time_cpu_bw"].max(), df_sat["time_cpu_lw"].max())

    time_unsat_min = min(df_unsat["time_cpu_bw"].min(), df_unsat["time_cpu_lw"].min())
    time_unsat_max = max(df_unsat["time_cpu_bw"].max(), df_unsat["time_cpu_lw"].max())

    time_min = min(time_sat_min, time_unsat_min)
    time_max = max(time_sat_max, time_unsat_max)

    ax[0].set_ylim(
        10 ** (np.floor(np.log10(time_min))), 10 ** (np.ceil(np.log10(time_max)))
    )
    ax[1].set_ylim(
        10 ** (np.floor(np.log10(time_min))), 10 ** (np.ceil(np.log10(time_max)))
    )
    ax[0].plot(
        [df_sat["time_cpu_bw"].min(), df_sat["time_cpu_bw"].max()],
        [df_sat["time_cpu_bw"].min(), df_sat["time_cpu_bw"].max()],
        c=black,
    )
    ax[1].plot(
        [df_unsat["time_cpu_bw"].min(), df_unsat["time_cpu_lw"].max()],
        [df_unsat["time_cpu_bw"].min(), df_unsat["time_cpu_lw"].max()],
        c=black,
    )
    ax[0].set_xscale("log")
    ax[0].set_yscale("log")
    ax[1].set_xscale("log")
    ax[1].set_yscale("log")
    # ax[1].text(1.2, 0, "Time [ms]\nbitwuzla", transform=ax[1].transAxes, ha="right")
    fig.text(0.5, 0.04, "Time [ms] - bitwuzla", ha="center", va="center")
    ax[0].set_ylabel("Time [s] - bv_decide", rotation="horizontal", ha="left", y=1.05)
    # ax.legend(loc="lower center", ncols=2, frameon=False)
    save(fig, "scatter_smtlib.pdf")


def scatter_solving_time_instcombine(df):
    fig, ax = plt.subplots(figsize=(14, 3), sharey=True)
    tot_sum = (
        df["leanSAT-rw"]
        + df["leanSAT-bb"]
        + df["leanSAT-sat"]
        + df["leanSAT-lrat-t"]
        + df["leanSAT-lrat-c"]
    )
    # tot_sum = (df["leanSAT"])
    ax.scatter(df["bitwuzla"], tot_sum, c="#beaed4", marker=".")
    ax.set_xlabel("T")

    time_min = min(df["bitwuzla"].min(), tot_sum.min())
    time_max = max(df["bitwuzla"].max(), tot_sum.max())

    ax.set_ylim(
        10 ** (np.floor(np.log10(time_min))), 10 ** (np.ceil(np.log10(time_max)))
    )
    ax.plot(
        [df["bitwuzla"].min(), tot_sum.max()],
        [df["bitwuzla"].min(), tot_sum.max()],
        c=black,
    )
    ax.set_xscale("log")
    ax.set_yscale("log")
    # ax[1].text(1.2, 0, "Time [ms]\nbitwuzla", transform=ax[1].transAxes, ha="right")
    ax.set_xlabel("Time [ms] - bitwuzla", ha="center", va="center", y=-0.2)
    ax.set_ylabel("Time [ms] - bv_decide", rotation="horizontal", ha="left", y=1.05)
    # ax.legend(loc="lower center", ncols=2, frameon=False)
    save(fig, "scatter_smtlib_instcombine.pdf")


def plot_hackersdelight():
    dfs = []
    for file in os.listdir(hackersDelightDataDir):
        if "err" not in file and "ceg" not in file and "sym" not in file:
            print(file)
            bvw = file.split("_")[0].split("w")[1]
            df_bw = pd.read_csv(hackersDelightDataDir + file)
            df_sorted = df_bw.sort_values(by="leanSAT")
            if len(df_sorted > 0):
                compare_tools_same_bw(df_bw, file, "leanSAT", "bitwuzla")
                leanSAT_tot_stacked(df_bw, file)
                leanSAT_tot_stacked_perc(df_bw, file, "h")
                leanSAT_tot_stacked_area(df_bw, file)
                df_sorted.insert(1, "bvw", [bvw] * len(df_sorted), True)
                df_sorted.insert(
                    1, "filename", file.split("_")[1] + "_" + file.split("_")[2], True
                )
                dfs.append(df_sorted)

    df = pd.concat(dfs, axis=0)

    df.to_csv("gigantic-df.csv")

    bv_width = df["bvw"].unique()

    file = "HackersDelight"
    df_new = df[df["bvw"] == str(64)]
    leanSAT_tot_stacked(df_new, file + "_bvw64")
    leanSAT_tot_stacked_perc(df_new, file + "_bvw64", "h_tot")

    cumul_solving_time_hackers_delight(df, "leanSAT", "bitwuzla", file, bv_width)

    bar_bw_impact(df, file, "bitwuzla", bv_width)
    bar_bw_impact(df, file, "leanSAT", bv_width)
    compare_tools_diff_bw(df, file, "leanSAT", "bitwuzla", bv_width)


def plot_instcombine():
    for file in os.listdir(instCombineDataDir):
        if "err" not in file and "ceg" not in file:
            df = pd.read_csv(instCombineDataDir + file)
            cumul_solving_time(df, "leanSAT", "bitwuzla", file)
            leanSAT_tot_stacked(df, "instCombine")
            leanSAT_tot_stacked_perc(df, "instCombine", "i")
            leanSAT_tot_stacked_area(df, "instCombine")
            scatter_solving_time_instcombine(df)


def plot_smtlib():
    # filter out results that are unknown for both solvers
    df_bitwuzla_46k = pd.read_csv(SMTLIBDataDir + "bitwuzla_46k.csv")
    df_leanwuzla_46k = pd.read_csv(SMTLIBDataDir + "leanwuzla_46k.csv")
    df_leanwuzla_trusted_46k = pd.read_csv(SMTLIBDataDir + "leanwuzla_trusted_46k.csv")
    df_coq_46k = pd.read_csv(SMTLIBDataDir + "coq_46k.csv")
    df_bitwuzla_46k_no_unknowns = df_bitwuzla_46k[
        df_bitwuzla_46k["result"] != "unknown"
    ]
    df_leanwuzla_46k_no_unknowns = df_leanwuzla_46k[
        df_leanwuzla_46k["result"] != "unknown"
    ]
    df_leanwuzla_trusted_46k_no_unknowns = df_leanwuzla_trusted_46k[
        df_leanwuzla_trusted_46k["result"] != "unknown"
    ]
    df_leanwuzla_trusted_46k_no_unknowns = df_leanwuzla_trusted_46k_no_unknowns.rename(
        columns=lambda x: x + "_lwt" if x != "benchmark" else x
    )
    df_coq_46k_no_unknowns = df_coq_46k[df_coq_46k["result"] != "unknown"]
    df_coq_46k_no_unknowns = df_coq_46k_no_unknowns.rename(
        columns=lambda x: x + "_coq" if x != "benchmark" else x
    )
    merged_df = pd.merge(
        df_bitwuzla_46k_no_unknowns,
        df_leanwuzla_46k_no_unknowns,
        how="outer",
        on="benchmark",
        suffixes=("_bw", "_lw"),
    )
    merged_df = pd.merge(
        merged_df, df_leanwuzla_trusted_46k_no_unknowns, how="outer", on="benchmark"
    )
    merged_df_tot = pd.merge(
        merged_df, df_coq_46k_no_unknowns, how="outer", on="benchmark"
    )
    df_sat = merged_df_tot.loc[
        lambda x: (x["result_bw"] == "sat")
        | (x["result_lw"] == "sat")
        | (x["result_coq"] == "sat")
    ]
    df_unsat = merged_df_tot.loc[
        lambda x: (x["result_bw"] == "unsat")
        | (x["result_lw"] == "unsat")
        | (x["result_coq"] == "unsat")
    ]
    # separate sat from unsat
    cumul_solving_time_smtlib(df_sat, "sat")
    cumul_solving_time_smtlib(df_unsat, "unsat")
    scatter_solving_time_smtlib(df_sat, df_unsat)
    # plot stacked area plot
    df_leanwuzla_46k_stats = pd.read_csv(SMTLIBDataDir + "leanwuzla_46k_stats.csv")
    df_sat_stats = df_leanwuzla_46k_stats[
        df_leanwuzla_46k_stats["leanSAT-res"] == "sat"
    ]
    df_unsat_stats = df_leanwuzla_46k_stats[
        df_leanwuzla_46k_stats["leanSAT-res"] == "unsat"
    ]
    leanSAT_smtlib_sat_stacked_perc(df_sat_stats, "sat", "i")
    leanSAT_smtlib_unsat_stacked_perc(df_unsat_stats, "unsat", "i")
    df_leanwuzla_trusted_46k_stats = pd.read_csv(
        SMTLIBDataDir + "leanwuzla_trusted_46k_stats.csv"
    )
    df_sat_stats = df_leanwuzla_trusted_46k_stats[
        df_leanwuzla_trusted_46k_stats["leanSAT-res"] == "sat"
    ]
    df_unsat_stats = df_leanwuzla_trusted_46k_stats[
        df_leanwuzla_trusted_46k_stats["leanSAT-res"] == "unsat"
    ]
    leanSAT_smtlib_sat_stacked_perc(df_sat_stats, "trusted_sat", "i")
    leanSAT_smtlib_unsat_stacked_perc(df_unsat_stats, "trusted_unsat", "i")


def main():
    parser = argparse.ArgumentParser(
        prog="plot",
        description="Plot the figures for this paper",
    )
    parser.add_argument(
        "names", nargs="+", choices=["all", "hackersdelight", "instcombine", "smtlib"]
    )
    args = parser.parse_args()

    setGlobalDefaults()

    if "all" in args.names or "hackersdelight" in args.names:
        plot_hackersdelight()

    if "all" in args.names or "instcombine" in args.names:
        plot_instcombine()

    if "all" in args.names or "smtlib" in args.names:
        plot_smtlib()


if __name__ == "__main__":
    main()
