# Implementation Status {#contrib_impl_status}

This page summarizes the implementation scope of the repository without duplicating release-specific values that already live elsewhere.

## Scope

The repository currently contains implemented source trees for:

- C++ wrapper API
- Builder API
- Transport implementations
- Diagnostics and logging
- Configuration management
- Memory and framing utilities
- Test suites

## C++ API Surface

The public umbrella header `wirestead/wirestead.hpp` exposes wrappers and builders for:

- TCP client
- TCP server
- UDP
- Serial
- UDS client
- UDS server

If you need the exact public entry points, treat `wirestead/wirestead.hpp` and the headers under `wirestead/wrapper/` and `wirestead/builder/` as the source of truth.

## Python Binding Scope

Python bindings have moved to https://github.com/wirestead/unilink-python.
This repository keeps only the C++20 core, native package metadata, runtime,
tests, and C++ API documentation.

## Build And Test Status

Dynamic build defaults and flags should be read from:

- `CMakeLists.txt`
- `cmake/WiresteadOptions.cmake`
- [Build Guide](build_guide.md)

Dynamic test registration and current pass/fail state should be read from:

- `test/CMakeLists.txt`
- [Test Structure](test_structure.md)
- `ctest` output from the active build directory

Latest explicitly reported ARM64 validation:

- Jetson Orin Nano on Ubuntu 22.04 `aarch64`
- Full C++ `ctest` sweep passed: 481 passed, 0 failed
- Python binding validation now belongs to the Wirestead Python repository
- ARM64 installed-package consumer smoke passed with `find_package(wirestead)` and `wirestead::wirestead`
- One disabled test was listed as not run: `UdsErrorTest.ServerStopWithActiveSessions`
- See [Orin Nano Validation](orin_nano_validation.md) for the reproducible runbook and scope boundaries

This document intentionally does not repeat exact version numbers, build-cache values, or test counts, because those change more often than the implementation scope itself.

## Recommended Reading Order

If you are trying to understand "what is implemented right now", read in this order:

1. `wirestead/wirestead.hpp`
2. [API Guide](../user/api_guide.md)
3. [Examples Repository](https://github.com/wirestead/unilink-examples)
4. [Test Structure](test_structure.md)
5. [Architecture Overview](architecture/)
