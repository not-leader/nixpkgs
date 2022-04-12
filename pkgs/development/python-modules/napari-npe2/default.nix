{ lib
, buildPythonPackage
, fetchFromGitHub
, appdirs
, pyyaml
, pytomlpp
, pydantic
, magicgui
, typer
, setuptools-scm
, napari # reverse dependency, for tests
}:

let
  pname = "napari-npe2";
  version = "0.3.0";
in
buildPythonPackage {
  inherit pname version;

  format = "pyproject";

  src = fetchFromGitHub {
    owner = "napari";
    repo = "npe2";
    rev = "v${version}";
    hash = "sha256-IyDUeztWQ8JWXDo//76iHzAlWWaZP6/0lwCh0eZAZsM=";
  };

  SETUPTOOLS_SCM_PRETEND_VERSION = version;

  nativeBuildInputs = [
    # npe2 *can* build without it,
    # but then setuptools refuses to acknowledge it when building napari
    setuptools-scm
  ];
  propagatedBuildInputs = [
    appdirs
    pyyaml
    pytomlpp
    pydantic
    magicgui
    typer
  ];

  passthru.tests = { inherit napari; };

  meta = with lib; {
    description = "Yet another plugin system for napari (the image visualizer)";
    homepage = "https://github.com/napari/npe2";
    license = licenses.bsd3;
    maintainers = with maintainers; [ SomeoneSerge ];
  };
}
