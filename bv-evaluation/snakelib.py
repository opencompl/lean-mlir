import argparse
import os
import random
import subprocess
import concurrent.futures
import shutil
import multiprocessing
import psutil
import time
import threading
import platform
from functools import partial
from pathlib import Path
import sys

def git_root() -> Path:
  return Path(subprocess.check_output( ["git", "rev-parse", "--show-toplevel"]).decode().strip())


def sed() -> str:
  return "gsed" if platform.system() == "Darwin" else "sed"
