#!/usr/bin/env python3

import argparse
import os
import pandas as pd
import matplotlib
import matplotlib.pyplot as plt
import numpy as np
import pudb
import math

from typing import Callable

rawdatadir = "raw-data/"
plotsdir = "plots/"


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

def leanSAT_tot_stacked_perc(df, bm, type):
    if type == 'h_tot':
        matplotlib.rcParams["figure.figsize"] = 14, 3
    x = np.arange(len(df["leanSAT"]))
    width = 1.0
    fig, ax = plt.subplots(figsize=(14, 3.5))
    # df_sorted = df.sort_values(by="leanSAT")
    # print(df_sorted)
    tot_sum = (df["leanSAT-rw"] + df["leanSAT-bb"]+ df["leanSAT-sat"]+ df["leanSAT-lrat-t"]+ df["leanSAT-lrat-c"])
    df['tot-sum'] = tot_sum
    df_sorted = df.sort_values(by="tot-sum")
    # print(df_sorted)
    ax_right = ax.twinx()

    ax.bar(
        x,
        np.divide(df_sorted["leanSAT-rw"],df_sorted['tot-sum'])*100,
        width,
        label="rewriting",
        bottom=np.zeros_like(df_sorted["leanSAT-rw"]),
        color=dark_blue, 
        edgecolor = dark_blue
    )
    ax.bar(
        x,
        np.divide(df_sorted["leanSAT-bb"]+df_sorted["leanSAT-sat"], df_sorted['tot-sum'])*100,
        width,
        label="bit-blasting and SAT solving",
        bottom=np.divide(df_sorted["leanSAT-rw"],df_sorted['tot-sum'])*100,
        color=light_gray,
        edgecolor=light_gray
    )
    ax.bar(
        x,
        np.divide(df_sorted["leanSAT-lrat-t"] +df_sorted["leanSAT-lrat-c"], df_sorted['tot-sum'])*100,
        width,
        label="LRAT",
        bottom=np.divide(df_sorted["leanSAT-rw"],df_sorted['tot-sum'])*100
        + np.divide(df_sorted["leanSAT-bb"]+df_sorted["leanSAT-sat"], df_sorted['tot-sum'])*100,
        color=dark_green,
        edgecolor=dark_green
    )
    ax_right.plot(
        x,
        df_sorted['tot-sum'],
        width,
        label="total time",
        color=black, 
    )
    ax_right.set_yscale("log")
    ax.set_xticks(np.arange(0,len(df_sorted), 10**np.floor(np.log10(len(df_sorted)))))
    # ax.set_title("Time to solve theorems from "+bm, pad=20)
    ax.set_ylabel("Distribution [%]", rotation="horizontal", horizontalalignment="left", y=1.05)
    ax_right.set_ylabel("Time [ms]", rotation="horizontal", horizontalalignment="right", y=1.08)
    ax.legend(ncols=4, frameon=False, bbox_to_anchor= [0.5, 1], loc='lower center')
    plt.gca().spines['right'].set_visible(True) 
    save(fig, plotsdir + "leanSAT_stacked_perc_" + bm.split(".")[0] + ".pdf")


def leanSAT_smtlib_unsat_stacked_perc(df: pd.DataFrame, bm, type):
    if type == 'h_tot':
        matplotlib.rcParams["figure.figsize"] = 14, 5
    x = np.arange(len(df["benchmark"]))
    width = 1.0
    fig, ax = plt.subplots()
    # df_sorted = df.sort_values(by="leanSAT")
    # print(df_sorted)
    df = df.apply(lambda x: x / 10**6 if x.name in
      ['leanSAT-ld', 'leanSAT-rr', 'leanSAT-ac',
       'leanSAT-af', 'leanSAT-ecs', 'leanSAT-bb',
       'leanSAT-sat', 'leanSAT-lrat', 'leanSAT-kc'] else x)
    tot_sum = (df["leanSAT-ld"] + df["leanSAT-rr"] + df["leanSAT-ac"] +
               df["leanSAT-af"] + df["leanSAT-ecs"] + df["leanSAT-bb"] +
               df["leanSAT-sat"] + df["leanSAT-lrat"] + df["leanSAT-kc"])
    df['tot-sum'] = tot_sum
    df_sorted = df.sort_values(by="tot-sum")
    # print(df_sorted)
    ax_right = ax.twinx()

    bottom = np.zeros_like(df_sorted["leanSAT-ld"])
    ax.bar(
        x,
        np.divide(df_sorted["leanSAT-ld"] + df_sorted["leanSAT-rr"] +
                  df_sorted["leanSAT-ac"] + df_sorted["leanSAT-af"] +
                  df_sorted["leanSAT-ecs"] + df_sorted["leanSAT-kc"], df_sorted['tot-sum'])*100,
        width,
        label="rewriting + kernel checking",
        bottom=bottom,
        color=dark_blue, 
        edgecolor = dark_blue
    )
    bottom += np.divide(df_sorted["leanSAT-ld"] + df_sorted["leanSAT-rr"] +
                        df_sorted["leanSAT-ac"] + df_sorted["leanSAT-af"] +
                        df_sorted["leanSAT-ecs"] + df_sorted["leanSAT-kc"], df_sorted['tot-sum'])*100
    ax.bar(
        x,
        np.divide(df_sorted["leanSAT-bb"] + df_sorted["leanSAT-sat"],
                  df_sorted['tot-sum'])*100,
        width,
        label="bit-blasting and SAT solving",
        bottom=bottom,
        color=light_gray,
        edgecolor=light_gray
    )
    bottom += np.divide(df_sorted["leanSAT-bb"] + df_sorted["leanSAT-sat"], df_sorted['tot-sum'])*100
    ax.bar(
        x,
        np.divide(df_sorted["leanSAT-lrat"], df_sorted['tot-sum'])*100,
        width,
        label="LRAT",
        bottom=bottom,
        color=dark_green,
        edgecolor=dark_green
    )
    ax_right.plot(
        x,
        df_sorted['tot-sum'],
        width,
        label="total time",
        color=black, 
    )
    ax_right.set_yscale("log")
    ax.set_xticks(np.arange(0,len(df_sorted), 10**np.floor(np.log10(len(df_sorted)))))
    # ax.set_title("Time to solve theorems from "+bm, pad=20)
    ax.set_ylabel("Distribution [%]", rotation="horizontal", horizontalalignment="left", y=1.05)
    ax_right.set_ylabel("Time [ms]", rotation="horizontal", horizontalalignment="right", y=1.08)
    ax.legend(ncols=4, frameon=False, bbox_to_anchor= [0.5, 1], loc='lower center')
    plt.gca().spines['right'].set_visible(True) 
    save(fig, plotsdir + "leanSAT_stacked_smtlib_" + bm.split(".")[0] + ".pdf")


def leanSAT_smtlib_sat_stacked_perc(df: pd.DataFrame, bm, type):
    if type == 'h_tot':
        matplotlib.rcParams["figure.figsize"] = 14, 5
    x = np.arange(len(df["benchmark"]))
    width = 1.0
    fig, ax = plt.subplots()
    # df_sorted = df.sort_values(by="leanSAT")
    # print(df_sorted)
    df = df.apply(lambda x: x / 10**6 if x.name in
      ['leanSAT-ld', 'leanSAT-rr', 'leanSAT-ac',
       'leanSAT-af', 'leanSAT-ecs', 'leanSAT-bb',
       'leanSAT-sat', 'leanSAT-lrat'] else x)
    tot_sum = (df["leanSAT-ld"] + df["leanSAT-rr"] + df["leanSAT-ac"] +
               df["leanSAT-af"] + df["leanSAT-ecs"] + df["leanSAT-bb"] +
               df["leanSAT-sat"] + df["leanSAT-lrat"])
    df['tot-sum'] = tot_sum
    df_sorted = df.sort_values(by="tot-sum")
    # print(df_sorted)
    ax_right = ax.twinx()

    bottom = np.zeros_like(df_sorted["leanSAT-ld"])
    ax.bar(
        x,
        np.divide(df_sorted["leanSAT-ld"] + df_sorted["leanSAT-rr"] +
                  df_sorted["leanSAT-ac"] + df_sorted["leanSAT-af"] +
                  df_sorted["leanSAT-ecs"], df_sorted['tot-sum'])*100,
        width,
        label="rewriting",
        bottom=bottom,
        color=dark_blue, 
        edgecolor = dark_blue
    )
    bottom += np.divide(df_sorted["leanSAT-ld"] + df_sorted["leanSAT-rr"] +
                        df_sorted["leanSAT-ac"] + df_sorted["leanSAT-af"] +
                        df_sorted["leanSAT-ecs"], df_sorted['tot-sum'])*100
    ax.bar(
        x,
        np.divide(df_sorted["leanSAT-bb"] + df_sorted["leanSAT-sat"],
                  df_sorted['tot-sum'])*100,
        width,
        label="bit-blasting and SAT solving",
        bottom=bottom,
        color=light_gray,
        edgecolor=light_gray
    )
    ax_right.plot(
        x,
        df_sorted['tot-sum'],
        width,
        label="total time",
        color=black, 
    )
    ax_right.set_yscale("log")
    ax.set_xticks(np.arange(0,len(df_sorted), 10**np.floor(np.log10(len(df_sorted)))))
    # ax.set_title("Time to solve theorems from "+bm, pad=20)
    ax.set_ylabel("Distribution [%]", rotation="horizontal", horizontalalignment="left", y=1.05)
    ax_right.set_ylabel("Time [ms]", rotation="horizontal", horizontalalignment="right", y=1.08)
    ax.legend(ncols=4, frameon=False, bbox_to_anchor= [0.5, 1], loc='lower center')
    plt.gca().spines['right'].set_visible(True) 
    save(fig, plotsdir + "leanSAT_stacked_smtlib_" + bm.split(".")[0] + ".pdf")


def leanSAT_tot_stacked(df, bm):
    x = np.arange(len(df["leanSAT"]))
    width = 0.45
    fig, ax = plt.subplots()
    df_sorted = df.sort_values(by="leanSAT")
    # print(df_sorted)
    colors_in_order = [
        "#e31a1c",
        "#9ecae1",
        "#deebf7",
        "#74c476",
        "#bae4b3"
    ]
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
    ax.set_xticks(np.arange(0,len(df_sorted),len(df_sorted)-1))
    ax.set_title("Time to solve theorems from "+bm, pad=20)
    ax.set_ylabel("Time [ms]", rotation="horizontal", horizontalalignment="left", y=1)
    ax.legend(loc="best", ncols=1, frameon=False)
    save(fig, plotsdir + "leanSAT_stacked_" + bm.split(".")[0] + ".pdf")

def leanSAT_tot_stacked_area(df, bm):
    x = np.arange(len(df["leanSAT"]))
    fig, ax = plt.subplots()
    df_sorted = df.sort_values(by="leanSAT")
    x = np.arange(len(df["leanSAT"]))
    fig, ax = plt.subplots()
    colors_in_order = [
        "#bdd7e7",
        "#6baed6",
        "#3182bd",
        "#bae4b3",
        "#74c476"
    ]
    ax.stackplot(
        x,
        df_sorted["leanSAT-rw"],
        df_sorted["leanSAT-bb"],
        df_sorted["leanSAT-sat"],
        df_sorted["leanSAT-lrat-t"],
        df_sorted["leanSAT-lrat-c"],
        labels=["rw","bb","sat","lrat-t","lrats"],
        colors=colors_in_order
    )

    ax.set_yscale("log")
    ax.set_xticks(np.arange(0,51,50))
    ax.set_xlabel("Theorems")
    ax.set_ylabel("Time [ms]", rotation="horizontal", horizontalalignment="left", y=1)
    ax.legend(loc="center right", ncols=1, frameon=False, bbox_to_anchor=(1.2, 0.5))
    save(fig, plotsdir + "leanSAT_stacked_area_" + bm.split(".")[0] + ".pdf")

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
        label='bv_decide',
    )
    ax.plot(
        cumtime2,
        np.arange(0, len(df[tool2]) + 1),
        marker="x",
        color=col[3],
        label=tool2,
    )
    ax.set_xlabel("Time [ms]")
    ax.set_xscale('log')
    ax.set_ylabel("Problems solved", rotation="horizontal", ha="left", y=1)
    # ax.set_xscale("log")
    # ax.set_yscale("log")
    ax.legend(loc="upper left", ncols=1, frameon=False)
    # ax.legend(loc="center right", ncols=1, frameon=False, bbox_to_anchor=(1.2, 0.5))
    save(fig, plotsdir + "cumul_problems_llvm_" + bm.split(".")[0] + ".pdf")

def scatter_solving_time_instcombine(df): 
    fig, ax = plt.subplots(figsize=(14, 3), sharey=True)
    tot_sum = (df["leanSAT-rw"] + df["leanSAT-bb"]+ df["leanSAT-sat"]+ df["leanSAT-lrat-t"]+ df["leanSAT-lrat-c"])
    # tot_sum = (df["leanSAT"])
    ax.scatter(df['bitwuzla'], tot_sum, c = "#beaed4", marker = ".")
    ax.set_xlabel("T")

    time_min = min(df["bitwuzla"].min(), tot_sum.min())
    time_max = max(df["bitwuzla"].max(), tot_sum.max())

    ax.set_ylim(10**(np.floor(np.log10(time_min))), 10**(np.ceil(np.log10(time_max))))
    ax.plot([df["bitwuzla"].min(), tot_sum.max()], [df["bitwuzla"].min(), tot_sum.max()], c = black)
    ax.set_xscale('log')
    ax.set_yscale('log')
    # ax[1].text(1.2, 0, "Time [ms]\nbitwuzla", transform=ax[1].transAxes, ha="right")
    ax.set_xlabel("Time [ms] - bitwuzla", ha="center", va="center", y = -0.2)
    ax.set_ylabel("Time [ms] - bv_decide", rotation="horizontal", ha="left", y=1.05)
    # ax.legend(loc="lower center", ncols=2, frameon=False)
    save(fig, plotsdir + "scatter_smtlib_instcombine.pdf")

def plot_instcombine():
    for file in os.listdir(rawdatadir):
        if 'err' not in file and 'ceg' not in file:
            df = pd.read_csv(rawdatadir + file)
            cumul_solving_time(df, "leanSAT", "bitwuzla", file)
            leanSAT_tot_stacked(df, 'instCombine')
            leanSAT_tot_stacked_perc(df, 'instCombine', 'i')
            leanSAT_tot_stacked_area(df, 'instCombine')
            scatter_solving_time_instcombine(df)


if __name__ == "__main__":
    plot_instcombine()