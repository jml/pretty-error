{ mkDerivation, base, basic-prelude, bytestring, pretty-show
, stdenv
}:
mkDerivation {
  pname = "pretty-error";
  version = "0.1.0.0";
  src = ./.;
  buildDepends = [ base basic-prelude bytestring pretty-show ];
  homepage = "https://github.com/jml/pretty-error";
  description = "Pretty error messages";
  license = stdenv.lib.licenses.asl20;
}
