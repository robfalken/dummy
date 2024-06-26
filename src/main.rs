use std::net::SocketAddr;

use axum::{routing::get, Json, Router, Server};
use serde_json::{json, Value};

#[tokio::main]
async fn main() {
    let app = Router::new().route("/", get(index));
    let port = std::env::var("PORT").unwrap_or_else(|_| "3000".to_string());
    let port: u16 = port.parse().expect("Parse port");
    let addr = SocketAddr::from(([0, 0, 0, 0], port));

    println!("Dummy server running on port {}", addr.port());

    Server::bind(&addr)
        .serve(app.into_make_service())
        .await
        .expect("Serve app");
}

async fn index() -> Json<Value> {
    Json(json!({"status": "ok", "version": "0.0.6"}))
}
