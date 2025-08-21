{
  pkgs,
  ...
  # mkDerivation,
  # lib,
  # callPackage,
  # fetchzip,
  # fetchFromGitHub,
  # cmake,
  # pkg-config,
  # ninja,
  # copyDesktopItems,
  # qtbase,
  # qttools,
  # opencv4,
  # procps,
  # eigen,
  # libXdmcp,
  # libevdev,
  # makeDesktopItem,
  # fetchurl,
  # fetchpatch,
  # wineWowPackages,
}:

with pkgs;

let
  version_orig = "2023.3.0";
  version = "opentrack-starcit-git";

  aruco = callPackage ./aruco.nix { };

  # license.txt inside the zip file is MIT
in
with qt6;
with xorg;
with wrapQtAppsHook;
with python312Packages;
with stdenv;
with qttools;

stdenv.mkDerivation {
  pname = "opentrack";
  inherit version_orig;
  inherit version;

  src = fetchFromGitHub {
    owner = "opentrack";
    repo = "opentrack";
    # owner = "Priton-CE";
    # repo = "opentrack-StarCitizen";
    # rev = "4dd97af0f139f3ddc8f34a24ee961a1046015d3f";
    # hash = "sha256-xN4Z1Cpmj8ktqWCQYPZTfqznHrYe28qlKkPoQxHRPJ8=";
    rev = "a47cbd05214787640bbeffa289b4d932905d213f";
    hash = "sha256-gWvLcFmpekAS4Wa0PB8laZQ8QKXD8aVhdfh9HBZZWYo=";
    # hash = "sha256-C0jLS55DcLJh/e5yM8kLG7fhhKvBNllv5HkfCWRIfc5=";
    # rev = "wine-extended-proton";
    # hash = "sha256-C1RUttks/FTcVbD+v7fUVCVISsAmMqUP+QWZl9vtdNs=";
  };

  patches = [
    # https://github.com/opentrack/opentrack/pull/1754
    # (fetchpatch {
    #   url = "https://github.com/opentrack/opentrack/commit/d501d7e0b237ed0c305525788b423d842ffa356d.patch";
    #   hash = "sha256-XMGHV78vt/Xn3hS+4V//pqtsdBQCfJPjIXxfwtdXX+Q=";
    # })
  ];

  nativeBuildInputs = [
    cmake
    pkg-config
    ninja
    copyDesktopItems
    wrapQtAppsHook
  ];
  buildInputs = [
    qtbase
    qttools
    opencv4
    procps
    eigen
    libXdmcp
    libevdev
    aruco
  ] ++ lib.optionals pkgs.stdenv.targetPlatform.isx86_64 [ wineWowPackages.waylandFull ];

  env.NIX_CFLAGS_COMPILE = "-Wall -Wextra -Wpedantic -ffast-math -O3";
  dontWrapQtApps = true;

  cmakeFlags = [
    "-GNinja"
    # "-DCMAKE_BUILD_TYPE=Release"
    # "-DCMAKE_BUILD_TYPE=Unstable"
    "-DSDK_ARUCO_LIBPATH=${aruco}/lib/libaruco.a"
  ] ++ lib.optionals pkgs.stdenv.targetPlatform.isx86_64 [ "-DSDK_WINE=ON" ];

  postInstall = ''
    wrapQtApp $out/bin/opentrack
  '';

  desktopItems = [
    (makeDesktopItem rec {
      name = "opentrack";
      exec = "opentrack";
      icon = fetchurl {
        url = "https://github.com/opentrack/opentrack/raw/opentrack-${version_orig}/gui/images/opentrack.png";
        hash = "sha256-9k3jToEpdW14ErbNGHM4c0x/LH7k14RmtvY4dOYnITQ=";
      };
      desktopName = name;
      genericName = "Head tracking software";
      categories = [ "Utility" ];
    })
  ];

  meta = with lib; {
    homepage = "https://github.com/opentrack/opentrack";
    description = "Head tracking software for MS Windows, Linux, and Apple OSX";
    mainProgram = "opentrack";
    changelog = "https://github.com/opentrack/opentrack/releases/tag/${version_orig}";
    license = licenses.isc;
    maintainers = with maintainers; [ zaninime ];
  };
}
