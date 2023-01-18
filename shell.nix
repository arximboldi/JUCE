
with import <nixpkgs> {};

pkgs.mkShell {
  packages = [
    cmake
    ninja
    pkg-config
    alsa-lib
    libGL
    xorg.libX11
    xorg.libXcursor
    xorg.libXext
    xorg.libXrender
    xorg.libXrandr
    xorg.libXinerama
    freetype
    curl
  ];

  hardeningDisable = [ "fortify" ];

  # so Juce finds libcurl at runtime
  LD_LIBRARY_PATH = lib.makeLibraryPath [curl];

  # Otherwise these are considered runtime deps and it crashes...
  NIX_LDFLAGS = (toString [
    "-lX11"
    "-lXext"
    "-lXcursor"
    "-lXinerama"
    "-lXrandr"
  ]);

  shellHook = ''
    export JUCE_FONT_PATH=${dejavu_fonts}/share/fonts/truetype
  '';
}
