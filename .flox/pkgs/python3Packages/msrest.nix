{
  lib,
  aiodns,
  aiohttp,
  buildPythonPackage,
  certifi,
  fetchFromGitHub,
  httpretty,
  isodate,
  pytest-aiohttp,
  pytestCheckHook,
  pythonAtLeast,
  requests,
  requests-oauthlib,
  setuptools,
  trio,
}:

buildPythonPackage {
  pname = "msrest";
  version = "0.7.1";
  pyproject = true;

  src = ../../..;

  nativeBuildInputs = [ setuptools ];

  propagatedBuildInputs = [
    aiodns
    aiohttp
    certifi
    isodate
    requests
    requests-oauthlib
  ];

  nativeCheckInputs = [
    httpretty
    pytest-aiohttp
    pytestCheckHook
    trio
  ];

  disabledTests = [
    # Test require network access
    "test_basic_aiohttp"
    "test_basic_aiohttp"
    "test_basic_async_requests"
    "test_basic_async_requests"
    "test_conf_async_requests"
    "test_conf_async_requests"
    "test_conf_async_trio_requests"
  ]
  ++ lib.optionals (pythonAtLeast "3.12") [
    # AttributeError: 'TestAuthentication' object has no attribute...
    "test_apikey_auth"
    "test_cs_auth"
    "test_eventgrid_auth"
    "test_eventgrid_domain_auth"
  ];

  pythonImportsCheck = [ "msrest" ];

  meta = {
    description = "Runtime library for AutoRest generated Python clients";
    homepage = "https://github.com/Azure/msrest-for-python";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [
      bendlas
      maxwilson
    ];
  };
}
