###########################
Numpy Windows wheel builder
###########################

A very crude first pass at building numpy wheels with MSVC and binaries build
from ATLAS.

* Put the ``unzip`` command on your Windows path (needed by the ``delocate``
  utility). I used the binary at
  http://www.stahlworks.com/dev/index.php?tool=zipunzip
* You might want to make a virtualenv to work in.
* ``pip install cython delocate``.
* Clone the numpy github repo, and run the main script::

    git clone https://github.com/numpy/numpy.git
    cd numpy
    git checkout v1.10.4
    python ..\np-wheel-builder\build_numpy.py 32

This should build you a numpy wheel with the ATLAS binary packaged inside.  It
will be in the ``dist`` subdirectory of the numpy source tree.  ``32`` is when
building against a 32-bit Python, use ``64`` otherwise.

Built wheels at: http://nipy.bic.berkeley.edu/scipy_installers/atlas_builds

http://stackoverflow.com/questions/9946322/how-to-generate-an-import-library-lib-file-from-a-dll