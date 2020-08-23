{ stdenv, fetchFromGitHub, mkDerivation, qt5, qtbase, cmake, extra-cmake-modules
, libGL, fontconfig, freetype, harfbuzz, tbb, pcre-cpp, pkgconfig, boost
, kwindowsystem, fmt, catch2 }:

mkDerivation rec {
  version = "30072020";
  pname = "contour";

  src = fetchFromGitHub {
    owner = "christianparpart";
    repo = "contour";
    fetchSubmodules = true;
    rev = "2089d98a92e06661fab72650388c0bb88be457fe";
    sha256 = "1crdqyvi91iz4wgyqbgzv2hpbqw9a5i2cqsx9yiavn2vm3jygkkl";
  };

  buildInputs = [
    qt5.qtbase
    kwindowsystem
    harfbuzz
    freetype
    tbb
    pcre-cpp
    boost
    fontconfig
    libGL
    fmt
    catch2
    kwindowsystem
  ];

  nativeBuildInputs = [ cmake extra-cmake-modules pkgconfig ];

  cmakeFlags = [
    "-DCONTOUR_BLUR_PLATFORM_KWIN=OFF"
    "-DCONTOUR_COVERAGE=OFF"
    "-DCONTOUR_PERF_STATS=OFF"
    "-DLIBTERMINAL_EXECUTION_PAR=ON"
    "-DLIBTERMINAL_LOG_TRACE=ON"
    "-DLIBTERMINAL_LOG_RAW=ON"
    "-DOpenGL_GL_PREFERENCE=LEGACY"
    "-DYAML_CPP_BUILD_TOOLS=OFF"
    "-DYAML_CPP_BUILD_CONTRIB=OFF"
    "-DBUILD_SHARED_LIBS=ON"
    "-DYAML_CPP_BUILD_TESTS=OFF"
    "-DCMAKE_INSTALL_PREFIX=$out"
    "-DCMAKE_BUILD_TYPE=Debug"
    "-DCMAKE_CXX_FLAGS=-Wall -O2"
  ];

  #  installFlags = [ "INSTALL_ROOT=$(out)" ];

  enableParallelBuilding = true;

  meta = {
    description = "Modern C++ Terminal Emulator";
    longDescription = ''
      contour is a modern terminal emulator, for everyday use. 
      It is fully seperating emulation from graphical representation for clear seperation of concerns
      but also for special features to come before version 1.0 is released
      (headless terminal server with GUI & TUI frontends).
    '';
    homepage = "https://github.com/christianparpart/contour";
    license = stdenv.lib.licenses.asl20;
    platforms = with stdenv.lib.platforms; unix;
    maintainers = with stdenv.lib.maintainers; [ thefenriswolf ];
  };
}
