REM Download built OpenBLAS libraries
REM Expects (default)
REM   OPENBLAS_COMMIT: v0.2.19
REM   PYTHON_ARCH: 32
REM   OPENBLAS_ROOT: c:\opt
set RACK_URL=https://3f23b170c54c2533c070-1c8a9b3114517dc5fe17b7c3f8c63a43.ssl.cf2.rackcdn.com
if not exist "%OPENBLAS_ROOT%" mkdir %OPENBLAS_ROOT%
cd %OPENBLAS_ROOT%
set OPENBLAS_FNAME=openblas-%OPENBLAS_COMMIT%_win%PYTHON_ARCH%.zip
curl -L %RACK_URL%/%OPENBLAS_FNAME% -o %OPENBLAS_FNAME%
unzip %OPENBLAS_FNAME%
