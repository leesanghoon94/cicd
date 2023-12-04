import pytest
from hello import app

@pytest.fixture()
def clinet():
    return app.test_client()

def test_hello_world(clinet):
    res = clinet.get('/')
    assert res.status_code == 200

