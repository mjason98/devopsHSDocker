from web import SimpleFactory

def test_factory():
    simple = SimpleFactory("My Url")
    
    assert simple['url'] == "My Url"
    assert simple['name'] == "Hello"
    assert simple['description'] == "Mariano Jason"
