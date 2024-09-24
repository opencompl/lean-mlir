{
  buildPythonPackage,
  fetchPypi,
  lib,
  matplotlib,
  numpy,
  pyaudio,
  pydub,
  pythonOlder,
  unittestCheckHook,
  fetchFromGitHub,
  immutabledict,
  typing-extensions,
  ordered-set
}:

buildPythonPackage rec {
  pname = "xdsl";
  version = "0.22.0";

  src = fetchPypi {
    inherit version;
    pname = "xdsl";
    # hash = "sha256-oh618MGF7YmQ0Y8tl7IKSu7c1n0DnW+oRbx5eeDV18w=";
    hash = "sha256-+t8Lic/fm7u7PNEQs9DtSwoVnDjBjdy43f62qtkzPMs=";
  };

  propagatedBuildInputs = [
    immutabledict
    typing-extensions
    ordered-set
  ];


  # do not run tests
  doCheck = false;

  meta = with lib; {
    description = "Audio Activity Detection tool that can process online data as well as audio files";
    mainProgram = "xdsl";
    homepage = "https://github.com/amsehili/xdsl/";
    changelog = "https://github.com/amsehili/xdsl/blob/v${version}/CHANGELOG";
    license = licenses.mit;
    maintainers = [ ];
  };
}
