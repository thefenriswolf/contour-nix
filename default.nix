# after cool-retro-term
# contour = libsForQt5.callPackage ../applications/misc/contour { };

#{ stdenv, fetchFromGitHub, mkDerivation, qt5, qtbase, cmake, extra-cmake-modules
#, libGL, fontconfig, freetype, harfbuzz, tbb, pcre-cpp, pkgconfig, boost
#, kwindowsystem, fmt, catch2 }:

with import <nixpkgs> { };

stdenv.mkDerivation rec {
  version = "19122020";
  pname = "contour";

  src = fetchFromGitHub {
    owner = "christianparpart";
    repo = "contour";
    fetchSubmodules = true;
    rev = "57adae889420810cae4f9cedc69b1ac51db9c956";
    sha256 = "0slzsldylakswgkigja8yh3cx6hwssrmagg7w25jbvx5rbqqymwv";
  };

  buildInputs = [
    qt5.qtbase
    libsForQt5.kwindowsystem
    harfbuzz
    freetype
    tbb
    pcre-cpp
    boost
    fontconfig
    libGL
    fmt
    catch2
    libyamlcpp
  ];

  nativeBuildInputs = [ cmake extra-cmake-modules ninja pkgconfig ];

  #  cmakeFlags = [
  #    "-DCONTOUR_BLUR_PLATFORM_KWIN=ON"
  #    "-DCONTOUR_COVERAGE=OFF"
  #    "-DCONTOUR_PERF_STATS=OFF"
  #    "-DLIBTERMINAL_EXECUTION_PAR=ON"
  #    "-DLIBTERMINAL_LOG_TRACE=ON"
  #    "-DLIBTERMINAL_LOG_RAW=ON"
  #    "-DOpenGL_GL_PREFERENCE=LEGACY"
  #    "-DYAML_CPP_BUILD_TOOLS=OFF"
  #    "-DYAML_CPP_BUILD_CONTRIB=OFF"
  #    "-DBUILD_SHARED_LIBS=ON"
  #    "-DYAML_CPP_BUILD_TESTS=OFF"
  #    "-DCMAKE_BUILD_TYPE=Debug"
  #  ];

  # installFlags = [ "INSTALL_ROOT=$(out)" ];

  hardeningEnable = [ "pie" "fortify" ];

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
