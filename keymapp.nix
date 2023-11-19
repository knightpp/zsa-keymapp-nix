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
}:
stdenv.mkDerivation {
  pname = "keymapp";
  version = "latest";

  src = fetchurl {
    url = "https://oryx.nyc3.cdn.digitaloceanspaces.com/keymapp/keymapp-latest.tar.gz";
    hash = "sha256-e9Ty3gMb+nkXGK8sND4ljyrIxP+1fLasiV6DoTiWmsU=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
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
