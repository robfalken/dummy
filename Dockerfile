FROM rust:1.77.0-buster as build

RUN rustup toolchain install stable \
    && rustup default stable

COPY . .

RUN cargo install --path .

FROM debian:buster-slim

COPY --from=build /usr/local/cargo/bin/dummy /usr/local/bin/dummy

EXPOSE 3000

CMD ["dummy"]
