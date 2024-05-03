{
  stdenv,
  fetchurl,
  autoPatchelfHook,
  lib,
  libusb1,
  eudev,
  webkitgtk,
  gtk3,
  gdk-pixbuf,
  glib,
  gcc,
  wrapGAppsHook,
}:
stdenv.mkDerivation rec {
  pname = "keymapp";
  version = "1.1.1";

  src = fetchurl {
    url = "https://oryx.nyc3.cdn.digitaloceanspaces.com/keymapp/keymapp-latest.tar.gz";
    hash = "sha256-tbRlJ65hHPBDwoXAXf++OdcW67RcqR1x1vfhbPCo1Ls=";
    inherit version;
  };

  nativeBuildInputs = [
    autoPatchelfHook
    wrapGAppsHook
  ];

  buildInputs = [
    libusb1
    eudev
    webkitgtk
    gtk3
    gdk-pixbuf
    glib
    gcc.cc.libgcc
  ];

  dontConfigure = true;

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall

    install -m755 -D keymapp $out/bin/keymapp

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://www.zsa.io/flash/";
    description = "Keymapp is the fastest, most intuitive way to master your new ZSA keyboard.";
    platforms = platforms.linux;
  };
}
