import pytest
import json
from tfi_orders import create_app

mimetype = 'application/json'
headers = {
    'Content-Type': mimetype,
    'Accept': mimetype
}

@pytest.fixture()
def app():
    app = create_app()
    app.config.update({
        "TESTING": True,
    })
    # other setup can go here
    yield app

@pytest.fixture()
def client(app):
    return app.test_client()


@pytest.fixture()
def runner(app):
    return app.test_cli_runner()

def test_request_example(client):
    response = client.get("/hello")
    assert b"<h2>Hello, World!</h2>" in response.data

def test_request_post(client):
    response = client.post(
        "/", data=json.dumps({}), headers=headers)
    assert response.status_code == 200

def test_json(client):
    response = client.post("/",
                           data=json.dumps({"blockReceiptsRoot": "0x833788b3521327a13481ba920aa8ab7a452d800577dc87f0434922971b1b4b89", "blockStateRoot": "0x4dd6a916f2711af933b5ad7aa773ea260d2c4d7c182e6f73e0e94c2df678862b", "blockTransactionsRoot": "0xdba0ca8fa3f5a2fc14a3e71f80dae6fceba2386c3cd60a7d633e5009ab63f9c3", "logAddress": "0x7c2e0e489493e487903941f399a0255c4c170c91", "logBlockHash": "0x06a09be195cebb930e2ab473937b942e5a4680f255b5a3eee37431af2391bac3", "logBlockNumber": 7615751, "logData": "AAAAAAAAAAAAAAAAKr63r8hmEqbZoXJ6vGdycK3CQipxd9jgFtTVBxZs5WPmjac6hn8QCkMBQAaxR8aBn8sCuQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAKr63r8hmEqbZoXJ6vGdycK3CQirC+4UjAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABjJx6EAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAxZ3NlcnZpY2VkZWNob2RkYXRhZDEwMjRna2V5cGF0aGBjYWJpYGptdWx0aXBsaWVyYAAAAAAAAAAAAAAAAAAAAA==", "logTopics": ["0xd8d7ecc4800d25fa53ce0372f13a416d98907a7ef3d8d3bdd79cf4fe75529c65", "0x3564623935356461626433333430323438363134303638353865316662626532"], "logTxHash": "0x438a306c21aa2fe66050daead2c9b61d915ad6cd94807fd3794b3777368316cb", "meta": {"oracleRequest": {"callbackAddr": "0x2aBeB7AFC86612A6D9A1727aBc677270adc2422a", "callbackFunctionId": "0xc2fb8523", "cancelExpiration": "1663508100", "data": "0x6773657276696365646563686f64646174616431303234676b6579706174686063616269606a6d756c7469706c69657260", "dataVersion": "1", "payment": "0", "requestId": "0x7177d8e016d4d507166ce563e68da73a867f100a43014006b147c6819fcb02b9", "requester": "0x2aBeB7AFC86612A6D9A1727aBc677270adc2422a", "specId": "0x3564623935356461626433333430323438363134303638353865316662626532"}}}),
                           headers=headers)
    assert response.status_code == 200
