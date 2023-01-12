FROM rust:1.66.0 as build

RUN rustup toolchain install stable \
    && rustup default stable

COPY . .

RUN cargo install --path .

FROM debian:buster-slim

COPY --from=build /usr/local/cargo/bin/dummy /usr/local/bin/dummy
COPY --from=build /lib/x86_64-linux-gnu/libz.so.1 /lib/x86_64-linux-gnu/libz.so.1

EXPOSE 3000

CMD ["dummy"]
