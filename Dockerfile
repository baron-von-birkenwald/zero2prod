FROM rustlang/rust:nightly

WORKDIR /app
RUN apt update && apt install lld clang -y
COPY . .
ENV SQLX_OFFLINE=true
# Limit codegen units to reduce memory usage during compilation
ENV CARGO_BUILD_JOBS=1
ENV CARGO_INCREMENTAL=0
RUN cargo build --release -j 1
ENTRYPOINT ["./target/release/zero2prod"]
