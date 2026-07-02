# Unilink Quick Start Guide {#user_quickstart}

Get started with unilink in 5 minutes!

## Installation

For most users, install the packaged library through vcpkg:

```bash
vcpkg install jwsung91-unilink
```

Then consume the CMake package from your application:

```cmake
find_package(unilink CONFIG REQUIRED)
target_link_libraries(my_client PRIVATE unilink::unilink)
```

For source builds and dependency setup, see [Installation](installation.md).

---

## Your First TCP Client

<!-- doc-compile: quickstart_tcp_client -->
```cpp
#include <chrono>
#include <iostream>
#include <thread>
#include <unilink/unilink.hpp>

int main() {
    // Create a TCP client - it's that simple!
    auto client = unilink::tcp_client("127.0.0.1", 8080)
        .on_connect([](const unilink::ConnectionContext& ctx) {
            std::cout << "Connected!" << std::endl;
        })
        .on_data([](const unilink::MessageContext& ctx) {
            std::cout << "Received: " << ctx.data() << std::endl;
        })
        .on_error([](const unilink::ErrorContext& ctx) {
            std::cerr << "Error: " << ctx.message() << std::endl;
        })
        .build();

    bool started = client->start_sync();

    // Send a message
    std::this_thread::sleep_for(std::chrono::seconds(1));
    if (started && client->connected()) {
        client->send("Hello, Server!");
    }

    // Keep running
    std::this_thread::sleep_for(std::chrono::seconds(5));
    client->stop();
    return 0;
}
```

**Compile with CMake (recommended):**

Create `CMakeLists.txt` next to `my_client.cc`:

```cmake
cmake_minimum_required(VERSION 3.12)
project(my_client_app LANGUAGES CXX)

find_package(unilink CONFIG REQUIRED)

add_executable(my_client my_client.cc)
target_link_libraries(my_client PRIVATE unilink::unilink)
target_compile_features(my_client PRIVATE cxx_std_20)
```

Then build and run:

```bash
cmake -S . -B build
cmake --build build
./build/my_client
```

**Direct compiler invocation:**

Direct compiler invocation is shown only for minimal manual experiments. For
normal projects, prefer CMake so transitive include paths, library paths, and
platform-specific flags are handled correctly.

```bash
g++ -std=c++20 my_client.cc -lunilink -lboost_system -pthread -o my_client
./my_client
```

---

## Your First TCP Server

The TCP client above expects a server to be listening on `127.0.0.1:8080`.
For a runnable server companion, see [TCP Server](tutorials/02_tcp_server.md).

---

## Transport Tutorials

After the first TCP client, use the transport-specific tutorials for complete
examples:

- [TCP Server](tutorials/02_tcp_server.md)
- [UDS Communication](tutorials/03_uds_communication.md)
- [Serial Communication](tutorials/04_serial_communication.md)
- [UDP Communication](tutorials/05_udp_communication.md)

---

## Common Patterns

Callbacks are optional for construction. In production code, register `.on_error(...)` so failures are visible, and register a data or message callback for receive-oriented workflows.

### Pattern 1: Auto-Reconnection

```cpp
#include <chrono>
#include <iostream>
using namespace std::chrono_literals;

auto client = unilink::tcp_client("server.com", 8080)
    .retry_interval(3000ms)  // Retry every 3 seconds (override; default is 1000ms)
    .on_error([](const unilink::ErrorContext& ctx) {
        std::cerr << "Error: " << ctx.message() << std::endl;
    })
    .build();

client->start();  // Will automatically reconnect on disconnect
```

### Pattern 2: Error Handling

```cpp
auto server = unilink::tcp_server(8080)
    .on_error([](const unilink::ErrorContext& ctx) {
        std::cerr << "Error: " << ctx.message() << std::endl;
    })
    .port_retry(true, 5, 1000)  // 5 retries, 1 sec interval
    .build();
```

### Pattern 3: Connection Limits (optional)

```cpp
// Set an explicit client limit
auto server = unilink::tcp_server(8080)
    .max_clients(8)  // allow up to 8 clients
    .build();

// Default unlimited client limit
auto server = unilink::tcp_server(8080)
    .build();
```

---

## Next Steps

1. **Read the API Guide**: [API Guide](api_guide.md)
2. **Check Examples**: <https://github.com/unilink-lab/unilink-examples>
3. **View API Reference Locally**: run `./scripts/generate_docs.sh` in `unilink-docs`, then open `build/doxygen/html/index.html`

---

## Troubleshooting

### Can't connect to server?

```cpp
// Enable logging to see what's happening
unilink::diagnostics::Logger::instance().set_level(unilink::diagnostics::LogLevel::DEBUG);
unilink::diagnostics::Logger::instance().set_console_output(true);
```

### Port already in use?

```cpp
auto server = unilink::tcp_server(8080)
    .port_retry(true, 5, 1000)  // Try 5 times
    .build();
```

### Need independent IO thread?

```cpp
// For testing or isolation
auto client = unilink::tcp_client("127.0.0.1", 8080)
    .independent_context(true)
    .build();
```

---

## Support

- **GitHub Issues**: https://github.com/jwsung91/unilink/issues
- **Documentation**: `docs/` directory
- **Examples**: <https://github.com/unilink-lab/unilink-examples>

Happy coding! 🚀
