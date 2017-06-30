""" Build numpy wheels
"""
from __future__ import print_function, absolute_import

import sys
import os
import re
from os.path import abspath, dirname, join as pjoin
import shutil
from subprocess import check_call
from platform import architecture
from glob import glob
from zipfile import ZipFile

from delocate import wheeltools

BUILD_STUFF = abspath(dirname(__file__))
DEFAULT_OPENBLAS_ROOT = r"c:\opt"
OPENBLAS_LIBNAME_RE = re.compile(r'^libraries\s*=\s*(.+)$', re.M)


def my_zip2dir(zip_fname, out_dir):
    """ Removes need for 'unzip' binary in PATH during `wheeltools.zip2dir`
    """
    with open(zip_fname, 'rb') as fobj:
        zip = ZipFile(fobj)
        zip.extractall(path=out_dir)


# Monkeypatch wheeltools
wheeltools.zip2dir = my_zip2dir


def get_bitness():
    bits, _ = architecture()
    return '32' if bits == '32bit' else '64' if bits == '64bit' else None


def add_library(lib_path, dist_path='dist'):
    wheel_fnames = glob(pjoin(dist_path, '*.whl'))
    for fname in wheel_fnames:
        print('Processing', fname)
        with wheeltools.InWheel(fname, fname):
            shutil.copy2(lib_path, pjoin('numpy', 'core'))


def main():
    argc = len(sys.argv)
    numpy_path = abspath(sys.argv[1] if argc > 1 else os.getcwd())
    n_bits = sys.argv[2] if argc > 2 else get_bitness()
    openblas_root = abspath(sys.argv[3] if argc > 3 else DEFAULT_OPENBLAS_ROOT)
    if n_bits not in ('32', '64'):
        raise RuntimeError("Number of bits should be 32 or 64")
    os.chdir(numpy_path)
    check_call(['git', 'clean', '-fxd'])
    check_call(['git', 'reset', '--hard'])
    blas_dir = pjoin(openblas_root, str(n_bits))
    with open(pjoin(blas_dir, 'site.cfg.template'), 'rt') as fobj:
        cfg_template = fobj.read()
    lib_basename = OPENBLAS_LIBNAME_RE.search(cfg_template).groups()[0]
    with open('site.cfg', 'wt') as fobj:
        fobj.write(cfg_template.format(openblas_root=openblas_root))
    # Copy guard against importing without SSE2
    shutil.copy2(pjoin(BUILD_STUFF, '_distributor_init.py'), 'numpy')
    check_call(['python', 'setup.py', 'bdist_wheel'])
    add_library(pjoin(blas_dir, 'bin', lib_basename + '.dll'))


if __name__ == '__main__':
    main()
