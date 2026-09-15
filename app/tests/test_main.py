from fastapi.testclient import TestClient
from src.main import app

client = TestClient(app)

def test_health():
    res = client.get("/health")
    assert res.status_code == 200
    assert res.json() == {"status": "ok"}

def test_metrics():
    res = client.get("/metrics")
    assert res.status_code == 200

def test_root_redirects_to_docs():
    res = client.get("/", follow_redirects=False)
    assert res.status_code in (307, 302)
    assert res.headers["location"] == "/docs"
