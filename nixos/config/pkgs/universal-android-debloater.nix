{stdenv, pkgs, ... }:

pkgs.stdenv.mkDerivation {
  pname = "universal-android-debloater";
  version = "0.5.1";

  src = pkgs.fetchurl {
    url = "";
    sha256 = "141y46rz7arfcbarhf9gc9a1abjkrix31gj12fmzck1s7cw920vn";
  }; 
  
  dontUnpack = true;

  installPhase = ''
  mkdir -p $out
  ${pkgs.unzip}/bin/unzip $src -d $out/
  '';

}
